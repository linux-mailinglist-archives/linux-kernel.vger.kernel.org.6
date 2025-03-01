Return-Path: <linux-kernel+bounces-539655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0A1A4A6EF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 01:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3052C189A98C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 00:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD25B664;
	Sat,  1 Mar 2025 00:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GV9/wq73"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B8E1805E;
	Sat,  1 Mar 2025 00:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740788527; cv=none; b=YBH8Rsfe9/9QFN4wInDjR4BfHugqEMaJEx4VQS8qzMqmtq59dV57sz4Rf+w3MNOrTIOTDHRU8Ww8P1UuaXtXKqhr34LZhp8NWqCJpfEtC1OY7+Ol3kpQ7S1WMP0pUjfxEGaFaeas3ekFXooYK+9h9OwRmQJ/QeztBc0m+Nenbt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740788527; c=relaxed/simple;
	bh=JDF9dNFYZNjyFCSuFDjLYAP7h7amRG0VensvLE72MRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpcqZFel1rzTJQCXO6ixUjsu9bSSXtf8VLskD6hCGsQ2jNw+E1ZJk0q1ecUi73NWzbQW+6Ao1expU3AQG+s+OQwubtAcvOO/7FJhCqMA83D6cdk4eYsjwYfvIA+a4t7gv12hqH3QdM8AOYVV18Xg3KdulQ2HQwh2Pl+4WaD4c7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GV9/wq73; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38f406e9f80so2174582f8f.2;
        Fri, 28 Feb 2025 16:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740788524; x=1741393324; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=17XNK1hQwkcmGrY7OjaJII0SHza23hpB66sdZO0tw4M=;
        b=GV9/wq73BfWXGo1UOt8yNFl9PixXTUlSQ7ipNWKXfm3RYGDss/WoCBBhrERKpwzfCr
         vMiadi+oD+yUZ1AtPREcvgeIancL9rCGVCVSzq/CSeJ0Lvm7By3ahrvZDlIiUMofKZ7E
         9xj49m2EYGlCDHAdey1dxqyqFY6+V3Pc54GDTNqklvnskwMMsDtnUQNToNq1cIRyzI8U
         MKrZhHtMnT4wIuLx2i4ty1HccxlQ+5GgKTQo1utusqKixUtbfMHVblICl6wPlexw7cLz
         j0kw1o61N0bUJYZ4EUM7XLTCcuNIzQWa9KT5XPb4hAgiZcpGoXE5W5t9XyNZXe4ap0QV
         7tQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740788524; x=1741393324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17XNK1hQwkcmGrY7OjaJII0SHza23hpB66sdZO0tw4M=;
        b=qgMKfN3cEZjOLmmlb8yjafVROFSDkP7ysmkAEcGgtJNmWFjYmsOkYOYE/kx7cdFvb8
         L0jz8ffgdIt/6CnoWKP5/k7UR67rbZPhAkD6+81DNkVlUhXLN+iyY4PMuS0jkmPbanDN
         kooVRcRgrKA09pmd5VJYrnEUO/6oyC+nctpgC8KwbeBOt1bogkT7mzYMd8j4olO+7Dk5
         89jy+WaurCh65+RgGBzzfAJVz1lh6KWJefyjR6RAw+VwZhkOaS5o0t0iMzMkj0j97SpK
         nGEQBRb+hcePJ5M7PJMh7Zx0nY7Gco404jU58MgUJ6zUJhC8WBsDyKde1MR4Ox/+fFV2
         qehQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrgOEK+3CUQ4lwFZz57PCHre99UgWn75aai0C1GKG8UyqcD997qA/o53jnGCa6BtdSPZZh/fLhnBk8KS4r@vger.kernel.org, AJvYcCX+OK4Rwz2PURAeyZU0VN79TTmfQeOoCYgNZDFTAT19s8HyPmk55ueyXrcGmfO/oBzWYQKEdDO66qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyABJrx6lFLNaL+CF0c4K7oVJbXDkWRPPcw6Wc8GdkAvAN73yvh
	95pp27jRrkTvokjfOgM1XpKKE6tbhNHA2fX5f8il+mWtl14JbUfI3/t5Yzuvd0ebKRQuaOz3gBk
	OyGo1D1Q0ZL9qf3iTarMg/jn8sNs=
X-Gm-Gg: ASbGncuUMY+GcBehgmyeOUvpttwBpf0sYmYOFj2W/IVLwmbjeDU0wTMXPG+lN9I/CWA
	6WGNpfin2vMr6/NvkTla1KL71Fq26Zw/NiDETIopiA6orsSEwZvb8WIs+ya22haVmGvZgHHDY6+
	hwCihX1LIWsgMGKe577I4ATMA6pHJc
X-Google-Smtp-Source: AGHT+IFOnLZU+7AsXdT1fH8V+V/ZM0jdpOVpC0yjysXv6NywZMSeHr/25idU/t84Fmf1uu7X+n2FH1vjxT1JyqNqBv8=
X-Received: by 2002:a5d:6da3:0:b0:390:eb32:3fee with SMTP id
 ffacd0b85a97d-390eca80548mr4682267f8f.49.1740788523425; Fri, 28 Feb 2025
 16:22:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+fCnZcVSwUAC9_xtVAHvO6+RWDzt6wOzWN623m=dT-3G=NnTQ@mail.gmail.com>
 <cik7z3nwspdabtw5n2sfoyrq5nqfhuqcsnm42iet5azibsf4rs@jx3qkqwhf6z2>
 <CA+fCnZd6O0_fc1U-D_i2shcF4Td-6389F3Q=fDkdYYXQupX1NA@mail.gmail.com>
 <uup72ceniis544hgfaojy5omctzf7gs4qlydyv2szkr5hqia32@t6fgaxcaw2oi>
 <gisttijkccu6pynsdhvv3lpyxx7bxpvqbni43ybsa5axujr7qj@7feqy5fy2kgt>
 <6wdzi5lszeaycdfjjowrbsnniks35zhatavknktskslwop5fne@uv5wzotu4ri4>
 <CA+fCnZeEm+-RzqEXp1FqYJ5Gsm+mUZh5k3nq=92ZuTiqwsaWvA@mail.gmail.com>
 <qnxlqbc4cs7izjilisbjlrup4zyntjyucvfa4s6eegn72wfbkd@czthvwkdvo3v>
 <CA+fCnZdUFO0+G9HHy4oaQfEx8sm3D_ZfxdkH3y2ZojjYqTN74Q@mail.gmail.com>
 <agqtypvkcpju3gdsq7pnpabikm4mnnpy4kp5efqs2pvsz6ubsl@togxtecvtb74> <mjyjkyiyhbbxyksiycywgh72laozztzwxxwi3gi252uk4b6f7j@3zwpv7l7aisk>
In-Reply-To: <mjyjkyiyhbbxyksiycywgh72laozztzwxxwi3gi252uk4b6f7j@3zwpv7l7aisk>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sat, 1 Mar 2025 01:21:52 +0100
X-Gm-Features: AQ5f1Job2uTJiDaFRVhtBwap-aEMFc-I22BIiCb20obah84ENVZn9xQZFsNgYZY
Message-ID: <CA+fCnZcDyS8FJwE6x66THExYU_t_n9cTA=9Qy3wL-RSssEb55g@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] kasan: sw_tags: Use arithmetic shift for shadow computation
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: Vitaly Buka <vitalybuka@google.com>, kees@kernel.org, 
	julian.stecklina@cyberus-technology.de, kevinloughlin@google.com, 
	peterz@infradead.org, tglx@linutronix.de, justinstitt@google.com, 
	catalin.marinas@arm.com, wangkefeng.wang@huawei.com, bhe@redhat.com, 
	ryabinin.a.a@gmail.com, kirill.shutemov@linux.intel.com, will@kernel.org, 
	ardb@kernel.org, jason.andryuk@amd.com, dave.hansen@linux.intel.com, 
	pasha.tatashin@soleen.com, guoweikang.kernel@gmail.com, dwmw@amazon.co.uk, 
	mark.rutland@arm.com, broonie@kernel.org, apopple@nvidia.com, bp@alien8.de, 
	rppt@kernel.org, kaleshsingh@google.com, richard.weiyang@gmail.com, 
	luto@kernel.org, glider@google.com, pankaj.gupta@amd.com, 
	pawan.kumar.gupta@linux.intel.com, kuan-ying.lee@canonical.com, 
	tony.luck@intel.com, tj@kernel.org, jgross@suse.com, dvyukov@google.com, 
	baohua@kernel.org, samuel.holland@sifive.com, dennis@kernel.org, 
	akpm@linux-foundation.org, thomas.weissschuh@linutronix.de, surenb@google.com, 
	kbingham@kernel.org, ankita@nvidia.com, nathan@kernel.org, ziy@nvidia.com, 
	xin@zytor.com, rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com, 
	cl@linux.com, jhubbard@nvidia.com, hpa@zytor.com, 
	scott@os.amperecomputing.com, david@redhat.com, jan.kiszka@siemens.com, 
	vincenzo.frascino@arm.com, corbet@lwn.net, maz@kernel.org, mingo@redhat.com, 
	arnd@arndb.de, ytcoode@gmail.com, xur@google.com, morbo@google.com, 
	thiago.bauermann@linaro.org, linux-doc@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org
Content-Type: multipart/mixed; boundary="0000000000009180c7062f3ce9f2"

--0000000000009180c7062f3ce9f2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 5:13=E2=80=AFPM Maciej Wieczor-Retman
<maciej.wieczor-retman@intel.com> wrote:
>
> I was applying your other comments to the series and came up with somethi=
ng like
> this. What do you think?
>
>         /*
>          * With the default kasan_mem_to_shadow() algorithm, all addresse=
s
>          * returned by the memory-to-shadow mapping (even for bogus point=
ers)
>          * must be within a certain displacement from KASAN_SHADOW_OFFSET=
.
>          *
>          * For Generic KASAN the displacement is unsigned so the mapping =
from zero
>          * to the last kernel address needs checking.
>          */
>         if (IS_ENABLED(CONFIG_KASAN_GENERIC)) {
>                 if (addr < KASAN_SHADOW_OFFSET ||
>                     addr >=3D KASAN_SHADOW_OFFSET + max_shadow_size)
>                         return;
>         } else {
>                 /*
>                  * For the tag-based mode the compiler resets tags in add=
resses at
>                  * the start of kasan_mem_to_shadow(). Because of this it=
's not
>                  * necessary to check a mapping of the entire address spa=
ce but only
>                  * whether a range of [0xFF00000000000000 - 0xFFFFFFFFFFF=
FFFFF] is a
>                  * valid memory-to-shadow mapping. On x86, tags are locat=
ed in bits
>                  * 62:57 so the range becomes [0x7E00000000000000 - 0xFFF=
FFFFFFFFFFFFF].
>                  * The check below tries to exclude invalid addresses by
>                  * checking spaces between [0x7E00000000000000 - 0x7FFFFF=
FFFFFFFFFF]
>                  * (which are positive and will overflow the memory-to-sh=
adow
>                  * mapping) and [0xFE00000000000000 - 0xFFFFFFFFFFFFFFFF]
>                  */
>                  if (addr > KASAN_SHADOW_OFFSET ||
>                      (addr < (u64)kasan_mem_to_shadow((void *)(0xFEUL << =
56)) &&
>                      addr > (u64)kasan_mem_to_shadow((void *)(~0UL >> 1))=
) ||
>                      addr < (u64)kasan_mem_to_shadow((void *)(0x7EUL << 5=
6)))
>                         return;
>         }
>
> The comment is a bit long and has a lot of hexes but maybe it's good to l=
eave a
> longer explanation so no one has to dig through the mailing archives to
> understand the logic :b

Explaining the logic sounds good to me!

I think your patch is close to what would look good, but I think the
parentheses in the long if condition look suspicious.

Please check the attached diff (Gmail makes it hard to inline code): I
fixed the parentheses (if I'm right about them being wrong), made the
checks look uniform, added an arm-specific check, and reworked the
comments (please check if they make sense).

If the diff looks good to you, let's use that.

It also would be great, if you could test this: add some code that
dereferences various bad addresses and see if the extra KASAN message
line gets printed during the GPF.

--0000000000009180c7062f3ce9f2
Content-Type: text/x-patch; charset="US-ASCII"; name="kasan_non_canonical_hook.patch"
Content-Disposition: attachment; filename="kasan_non_canonical_hook.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m7pg3pxi0>
X-Attachment-Id: f_m7pg3pxi0

ZGlmZiAtLWdpdCBhL21tL2thc2FuL3JlcG9ydC5jIGIvbW0va2FzYW4vcmVwb3J0LmMKaW5kZXgg
ODM1N2UxYTMzNjk5Li43ZWRkZTFhMjZhNDEgMTAwNjQ0Ci0tLSBhL21tL2thc2FuL3JlcG9ydC5j
CisrKyBiL21tL2thc2FuL3JlcG9ydC5jCkBAIC02ODEsMTEgKzY4MSw1NiBAQCB2b2lkIGthc2Fu
X25vbl9jYW5vbmljYWxfaG9vayh1bnNpZ25lZCBsb25nIGFkZHIpCiAJY29uc3QgY2hhciAqYnVn
X3R5cGU7CiAKIAkvKgotCSAqIEFsbCBhZGRyZXNzZXMgdGhhdCBjYW1lIGFzIGEgcmVzdWx0IG9m
IHRoZSBtZW1vcnktdG8tc2hhZG93IG1hcHBpbmcKLQkgKiAoZXZlbiBmb3IgYm9ndXMgcG9pbnRl
cnMpIG11c3QgYmUgPj0gS0FTQU5fU0hBRE9XX09GRlNFVC4KKwkgKiBGb3IgR2VuZXJpYyBLQVNB
Tiwga2FzYW5fbWVtX3RvX3NoYWRvdygpIHVzZXMgdGhlIGxvZ2ljYWwgcmlnaHQgc2hpZnQKKwkg
KiBhbmQgbmV2ZXIgb3ZlcmZsb3dzIHdpdGggdGhlIGNob3NlbiBLQVNBTl9TSEFET1dfT0ZGU0VU
IHZhbHVlcyAob24KKwkgKiBib3RoIHg4NiBhbmQgYXJtNjQpLiBUaHVzLCB0aGUgcG9zc2libGUg
c2hhZG93IGFkZHJlc3NlcyAoZXZlbiBmb3IKKwkgKiBib2d1cyBwb2ludGVycykgYmVsb25nIHRv
IGEgc2luZ2xlIGNvbnRpZ3VvdXMgcmVnaW9uIHRoYXQgaXMgdGhlCisJICogcmVzdWx0IG9mIGth
c2FuX21lbV90b19zaGFkb3coKSBhcHBsaWVkIHRvIHRoZSB3aG9sZSBhZGRyZXNzIHNwYWNlLgog
CSAqLwotCWlmIChhZGRyIDwgS0FTQU5fU0hBRE9XX09GRlNFVCkKLQkJcmV0dXJuOworCWlmIChJ
U19FTkFCTEVEKENPTkZJR19LQVNBTl9HRU5FUklDKSkgeworCQlpZiAoYWRkciA8ICh1NjQpa2Fz
YW5fbWVtX3RvX3NoYWRvdygodm9pZCAqKSgwVUwpKSB8fAorCQkgICAgYWRkciA+ICh1NjQpa2Fz
YW5fbWVtX3RvX3NoYWRvdygodm9pZCAqKSh+MFVMKSkpCisJCQlyZXR1cm47CisJfQorCisJLyoK
KwkgKiBGb3IgU29mdHdhcmUgVGFnLUJhc2VkIEtBU0FOLCBrYXNhbl9tZW1fdG9fc2hhZG93KCkg
dXNlcyB0aGUKKwkgKiBhcml0aG1ldGljIHNoaWZ0LiBOb3JtYWxseSwgdGhpcyB3b3VsZCBtYWtl
IGNoZWNraW5nIGZvciBhIHBvc3NpYmxlCisJICogc2hhZG93IGFkZHJlc3MgY29tcGxpY2F0ZWQs
IGFzIHRoZSBzaGFkb3cgYWRkcmVzcyBjb21wdXRhdGlvbgorCSAqIG9wZXJhdGlvbiB3b3VsZCBv
dmVyZmxvdyBvbmx5IGZvciBzb21lIG1lbW9yeSBhZGRyZXNzZXMuIEhvd2V2ZXIsIGR1ZQorCSAq
IHRvIHRoZSBjaG9zZW4gS0FTQU5fU0hBRE9XX09GRlNFVCB2YWx1ZXMgYW5kIHRoZSBmYWN0IHRo
ZQorCSAqIGthc2FuX21lbV90b19zaGFkb3coKSBvbmx5IG9wZXJhdGVzIG9uIHBvaW50ZXJzIHdp
dGggdGhlIHRhZyByZXNldCwKKwkgKiB0aGUgb3ZlcmZsb3cgYWx3YXlzIGhhcHBlbnMgKGZvciBi
b3RoIHg4NiBhbmQgYXJtNjQpLgorCSAqCisJICogRm9yIGFybTY0LCB0aGUgdG9wIGJ5dGUgb2Yg
dGhlIHBvaW50ZXIgZ2V0cyByZXNldCB0byAweEZGLiBUaHVzLCB0aGUKKwkgKiBwb3NzaWJsZSBz
aGFkb3cgYWRkcmVzc2VzIGJlbG9uZyB0byBhIHJlZ2lvbiB0aGF0IGlzIHRoZSByZXN1bHQgb2YK
KwkgKiBrYXNhbl9tZW1fdG9fc2hhZG93KCkgYXBwbGllZCB0byB0aGUgbWVtb3J5IHJhbmdlCisJ
ICogWzB4RkYwMDAwMDAwMDAwMDAsIDB4RkZGRkZGRkZGRkZGRkZGRl0uIERlc3BpdGUgdGhlIG92
ZXJmbG93LCB0aGUKKwkgKiByZXN1bHRpbmcgcG9zc2libGUgc2hhZG93IHJlZ2lvbiBpcyBjb250
aWd1b3VzLCBhcyB0aGUgb3ZlcmZsb3cKKwkgKiBoYXBwZW5zIGZvciBib3RoIDB4RkYwMDAwMDAw
MDAwMDAgYW5kIDB4RkZGRkZGRkZGRkZGRkZGRi4KKwkgKi8KKwlpZiAoSVNfRU5BQkxFRChDT05G
SUdfS0FTQU5fU1dfVEFHUykgJiYgSVNfRU5BQkxFRChDT05GSUdfQVJNNjQpKSB7CisJCWlmIChh
ZGRyIDwgKHU2NClrYXNhbl9tZW1fdG9fc2hhZG93KCh2b2lkICopKDB4RkZVTCA8PCA1NikpIHx8
CisJCSAgICBhZGRyID4gKHU2NClrYXNhbl9tZW1fdG9fc2hhZG93KCh2b2lkICopKH4wVUwpKSkK
KwkJCXJldHVybjsKKwl9CisKKwkgLyoKKwkgICogRm9yIHg4Ni02NCwgb25seSB0aGUgcG9pbnRl
ciBiaXRzIFs2Mjo1N10gZ2V0IHJlc2V0LCBhbmQgYml0cyAjNjMKKwkgICogYW5kICM1NiBjYW4g
YmUgMCBvciAxLiBUaHVzLCBrYXNhbl9tZW1fdG9fc2hhZG93KCkgY2FuIGJlIHBvc3NpYmx5CisJ
ICAqIGFwcGxpZWQgdG8gdHdvIHJlZ2lvbnMgb2YgbWVtb3J5OgorCSAgKiBbMHg3RTAwMDAwMDAw
MDAwMDAwLCAweDdGRkZGRkZGRkZGRkZGRkZdIGFuZAorCSAgKiBbMHhGRTAwMDAwMDAwMDAwMDAw
LCAweEZGRkZGRkZGRkZGRkZGRkZdLiBBcyB0aGUgb3ZlcmZsb3cgaGFwcGVucworCSAgKiBmb3Ig
Ym90aCBlbmRzIG9mIGJvdGggbWVtb3J5IHJhbmdlcywgYm90aCBwb3NzaWJsZSBzaGFkb3cgcmVn
aW9ucworCSAgKiBhcmUgY29udGlndW91cy4KKwkgKi8KKwlpZiAoSVNfRU5BQkxFRChDT05GSUdf
S0FTQU5fU1dfVEFHUykgJiYgSVNfRU5BQkxFRChDT05GSUdfWDg2XzY0KSkgeworCQlpZiAoKGFk
ZHIgPCAodTY0KWthc2FuX21lbV90b19zaGFkb3coKHZvaWQgKikoMHg3RVVMIDw8IDU2KSkgfHwK
KwkJICAgICBhZGRyID4gKHU2NClrYXNhbl9tZW1fdG9fc2hhZG93KCh2b2lkICopKH4wVUwgPj4g
MSkpKSAmJgorCQkgICAgKGFkZHIgPCAodTY0KWthc2FuX21lbV90b19zaGFkb3coKHZvaWQgKiko
MHhGRVVMIDw8IDU2KSkgfHwKKwkJICAgICBhZGRyID4gKHU2NClrYXNhbl9tZW1fdG9fc2hhZG93
KCh2b2lkICopKH4wVUwpKSkpCisJCQlyZXR1cm47CisJfQogCiAJb3JpZ19hZGRyID0gKHVuc2ln
bmVkIGxvbmcpa2FzYW5fc2hhZG93X3RvX21lbSgodm9pZCAqKWFkZHIpOwogCg==
--0000000000009180c7062f3ce9f2--

