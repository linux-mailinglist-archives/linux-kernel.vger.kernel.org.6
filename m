Return-Path: <linux-kernel+bounces-362862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE2399BA44
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 18:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F64281AC9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 16:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243551474B8;
	Sun, 13 Oct 2024 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEh07/lR"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D657F231CB0;
	Sun, 13 Oct 2024 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728835427; cv=none; b=fri3ytbdEajIjTdG9wX3Tri91bC/SRyRqg7OxbEv+C8XK+OFLrfPCdZp/722Lbkmla/YOAEvflz+QwxJ4o2w0v6dCZ0MCXwwYV5CybhPumgqIHh8dk0WljWAAnY3vaCYB3O26123UygvZ1KBAt7NTtPITMHWBVsuCCxP2yYmhKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728835427; c=relaxed/simple;
	bh=fqNr3v1OTK3DoPMJhKEduNqNWjzuazuP9bL8kDWIOmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IAH2T0nLeTO0hXTPM1AYRP3kb1OhnyDa5MWJ6yV9IWabrbW2JT1zLtvsCIVdlqtJ9456/5Jt5IAeShvC4Zy+G2pav0IR576tJWhuNX2p0LonKpXNMf7+t/YXdNEU4ZxA1zk1MU2I+XlxZVu8eb5m4QTqJDqD9RdJ8fmvFoIjxDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEh07/lR; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d47b38336so2038365f8f.3;
        Sun, 13 Oct 2024 09:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728835424; x=1729440224; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=clhS6jCen8r1o4VJuWKC3QPAogIxNmTpT2RR7+NeInQ=;
        b=PEh07/lRQiHSeLgU+Dad1uvMgD7QbrcgKW5er7hp8dOLqcu7T7VNVo5SJ9TjIdbHTO
         zaVsluOcbUAfIPPwsB45Bi9Va9gWDjqz32U3ghEmcvTapxppQzRlUd+m6zawt1N0fflk
         EzkrGXFuw8T8Opx2shecmo2Y0345Tu/o5hA3bGNWwH8WAlUctr4KwFzQqHDLmfQUVlub
         K2KO/z+rio4BL8PElluSFcaeAQYIXpGdBML8Jx7rqPmLzAoi7/fXwtQLWGuH13KlXdjh
         6tGWD0q/BH56ZZZYxWfG/YJXy7Z/5WjHZBUBYZOc6r/WDGxv+8fzO1jSTX53GUgdT9xY
         65cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728835424; x=1729440224;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=clhS6jCen8r1o4VJuWKC3QPAogIxNmTpT2RR7+NeInQ=;
        b=vf/ETgJ8tDm97K+5G/XBrill++0n0vLa1bXiyu2glDqD736/V8q+yQ1ottg/5uodq9
         VF4bhXnvx2X1t+Vvih+rvGO8Ng5J45oGp6rNc5crV4Q37MU4RXJvBXiGrr9/fnRq/HPe
         RiM4h/gjsGyp4/c1h0QHhB6F1bHjDBnP5QU9jjXJFlW0+mgjK64fC4Hly4ztty0CXroY
         49XOPEP1P/8kTUlGXYyhAZryoJ0MJFMXUyzWzdS/ZizJxfJaNL3KqXlCkfoeXG/9OJRn
         OKymPIFPGPejY2xXIGEojMVx08+WcOnOfYaSPXvM9cWh4zxB4hGBGCndgu/2VYqfxMye
         XmFA==
X-Forwarded-Encrypted: i=1; AJvYcCVwF1lwVv+ZjX/lS+vIVMBQ/kT76Je6vKAqF2vCDUAUArhou8UaPCSFMUc7bw7fq3rJyqaBEUatHxHKpve/@vger.kernel.org, AJvYcCW4IGtXC4G27Cakvhnr74cZcoaqCuOAV/cF3NGcjnFyS1YKVnmWVyA2aZanz2xeljqKBNATXU6CzMgX@vger.kernel.org, AJvYcCX8WkyFaIGujTMsMhB5Fw1F4Y2s0P+UHiPGW0C6EjzUnH/0Y+BDntnuVpHvnYyH1hhUau7MDUpO7Po=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQJnHvQyCfOn4/GHEbH7z6Th8S6Hp2YOCRAN+oolVyssiiroD5
	TgpY79BSREHnHf6Ym9NvlD96x4GpEwgB2h1dvI5avU3O238jh52mI3eXKjCoucI4KvM12Hb8zDP
	B3JuobZVpWJqWQ6nhbf8UuXYEEiA=
X-Google-Smtp-Source: AGHT+IFCb1vl5q9AcdR2CUXxL37GmMUvsx1+c69n3IU2+xGcp0f2XiA4uF0uoAGaRxI+YzQK/w9D/bkmLW0YVEiH6h4=
X-Received: by 2002:a5d:4750:0:b0:374:c56e:1d44 with SMTP id
 ffacd0b85a97d-37d5531a55amr5620451f8f.48.1728835424046; Sun, 13 Oct 2024
 09:03:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+fCnZdeuNxTmGaYniiRMhS-TtNhiwj_MwW53K73a5Wiui+8RQ@mail.gmail.com>
 <20241013130211.3067196-1-snovitoll@gmail.com> <20241013130211.3067196-4-snovitoll@gmail.com>
In-Reply-To: <20241013130211.3067196-4-snovitoll@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sun, 13 Oct 2024 18:03:33 +0200
Message-ID: <CA+fCnZdakHrmky_-4weoP=_rHb4cQ9Z=1RkZnmZcumL9AXeo1Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] kasan: delete CONFIG_KASAN_MODULE_TEST
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: akpm@linux-foundation.org, dvyukov@google.com, glider@google.com, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	ryabinin.a.a@gmail.com, vincenzo.frascino@arm.com, elver@google.com, 
	corbet@lwn.net, alexs@kernel.org, siyanteng@loongson.cn, 
	2023002089@link.tyut.edu.cn, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000053d77606245ddd32"

--00000000000053d77606245ddd32
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 3:02=E2=80=AFPM Sabyrzhan Tasbolatov
<snovitoll@gmail.com> wrote:
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/=
kasan.rst
> index d7de44f5339..52fdd6b5ef6 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -511,17 +511,12 @@ Tests
>  ~~~~~
>
>  There are KASAN tests that allow verifying that KASAN works and can dete=
ct
> -certain types of memory corruptions. The tests consist of two parts:
> +certain types of memory corruptions.
>
> -1. Tests that are integrated with the KUnit Test Framework. Enabled with
> +Tests that are integrated with the KUnit Test Framework. Enabled with
>  ``CONFIG_KASAN_KUNIT_TEST``. These tests can be run and partially verifi=
ed
>  automatically in a few different ways; see the instructions below.
>
> -2. Tests that are currently incompatible with KUnit. Enabled with
> -``CONFIG_KASAN_MODULE_TEST`` and can only be run as a module. These test=
s can
> -only be verified manually by loading the kernel module and inspecting th=
e
> -kernel log for KASAN reports.
> -
>  Each KUnit-compatible KASAN test prints one of multiple KASAN reports if=
 an
>  error is detected. Then the test prints its number and status.

Let's reword these parts even more, please see the attached file.

--00000000000053d77606245ddd32
Content-Type: application/x-patch; name="kasan-doc.patch"
Content-Disposition: attachment; filename="kasan-doc.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m27rwwlv0>
X-Attachment-Id: f_m27rwwlv0

ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2thc2FuLnJzdCBiL0RvY3VtZW50
YXRpb24vZGV2LXRvb2xzL2thc2FuLnJzdAppbmRleCBkN2RlNDRmNTMzOWQ0Li44M2M3NzdiYzk2
ODgxIDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL2Rldi10b29scy9rYXNhbi5yc3QKKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMva2FzYW4ucnN0CkBAIC01MTEsMTkgKzUxMSwxNCBAQCBU
ZXN0cwogfn5+fn4KIAogVGhlcmUgYXJlIEtBU0FOIHRlc3RzIHRoYXQgYWxsb3cgdmVyaWZ5aW5n
IHRoYXQgS0FTQU4gd29ya3MgYW5kIGNhbiBkZXRlY3QKLWNlcnRhaW4gdHlwZXMgb2YgbWVtb3J5
IGNvcnJ1cHRpb25zLiBUaGUgdGVzdHMgY29uc2lzdCBvZiB0d28gcGFydHM6CitjZXJ0YWluIHR5
cGVzIG9mIG1lbW9yeSBjb3JydXB0aW9ucy4KIAotMS4gVGVzdHMgdGhhdCBhcmUgaW50ZWdyYXRl
ZCB3aXRoIHRoZSBLVW5pdCBUZXN0IEZyYW1ld29yay4gRW5hYmxlZCB3aXRoCi1gYENPTkZJR19L
QVNBTl9LVU5JVF9URVNUYGAuIFRoZXNlIHRlc3RzIGNhbiBiZSBydW4gYW5kIHBhcnRpYWxseSB2
ZXJpZmllZAorQWxsIEtBU0FOIHRlc3RzIGFyZSBpbnRlZ3JhdGVkIHdpdGggdGhlIEtVbml0IFRl
c3QgRnJhbWV3b3JrIGFuZCBjYW4gYmUgZW5hYmxlZAordmlhIGBgQ09ORklHX0tBU0FOX0tVTklU
X1RFU1RgYC4gVGhlIHRlc3RzIGNhbiBiZSBydW4gYW5kIHBhcnRpYWxseSB2ZXJpZmllZAogYXV0
b21hdGljYWxseSBpbiBhIGZldyBkaWZmZXJlbnQgd2F5czsgc2VlIHRoZSBpbnN0cnVjdGlvbnMg
YmVsb3cuCiAKLTIuIFRlc3RzIHRoYXQgYXJlIGN1cnJlbnRseSBpbmNvbXBhdGlibGUgd2l0aCBL
VW5pdC4gRW5hYmxlZCB3aXRoCi1gYENPTkZJR19LQVNBTl9NT0RVTEVfVEVTVGBgIGFuZCBjYW4g
b25seSBiZSBydW4gYXMgYSBtb2R1bGUuIFRoZXNlIHRlc3RzIGNhbgotb25seSBiZSB2ZXJpZmll
ZCBtYW51YWxseSBieSBsb2FkaW5nIHRoZSBrZXJuZWwgbW9kdWxlIGFuZCBpbnNwZWN0aW5nIHRo
ZQota2VybmVsIGxvZyBmb3IgS0FTQU4gcmVwb3J0cy4KLQotRWFjaCBLVW5pdC1jb21wYXRpYmxl
IEtBU0FOIHRlc3QgcHJpbnRzIG9uZSBvZiBtdWx0aXBsZSBLQVNBTiByZXBvcnRzIGlmIGFuCi1l
cnJvciBpcyBkZXRlY3RlZC4gVGhlbiB0aGUgdGVzdCBwcmludHMgaXRzIG51bWJlciBhbmQgc3Rh
dHVzLgorRWFjaCBLQVNBTiB0ZXN0IHByaW50cyBvbmUgb2YgbXVsdGlwbGUgS0FTQU4gcmVwb3J0
cyBpZiBhbiBlcnJvciBpcyBkZXRlY3RlZC4KK1RoZW4gdGhlIHRlc3QgcHJpbnRzIGl0cyBudW1i
ZXIgYW5kIHN0YXR1cy4KIAogV2hlbiBhIHRlc3QgcGFzc2VzOjoKIApAQCAtNTQxLDcgKzUzNiw2
IEBAIFdoZW4gYSB0ZXN0IGZhaWxzIGR1ZSB0byBhIG1pc3NpbmcgS0FTQU4gcmVwb3J0OjoKICAg
ICAgICAgS0FTQU4gZmFpbHVyZSBleHBlY3RlZCBpbiAia2ZyZWVfc2Vuc2l0aXZlKHB0cikiLCBi
dXQgbm9uZSBvY2N1cnJlZAogICAgICAgICBub3Qgb2sgMjggLSBrbWFsbG9jX2RvdWJsZV9remZy
ZWUKIAotCiBBdCB0aGUgZW5kIHRoZSBjdW11bGF0aXZlIHN0YXR1cyBvZiBhbGwgS0FTQU4gdGVz
dHMgaXMgcHJpbnRlZC4gT24gc3VjY2Vzczo6CiAKICAgICAgICAgb2sgMSAtIGthc2FuCkBAIC01
NTAsMTYgKzU0NCwxNiBAQCBPciwgaWYgb25lIG9mIHRoZSB0ZXN0cyBmYWlsZWQ6OgogCiAgICAg
ICAgIG5vdCBvayAxIC0ga2FzYW4KIAotVGhlcmUgYXJlIGEgZmV3IHdheXMgdG8gcnVuIEtVbml0
LWNvbXBhdGlibGUgS0FTQU4gdGVzdHMuCitUaGVyZSBhcmUgYSBmZXcgd2F5cyB0byBydW4gdGhl
IEtBU0FOIHRlc3RzLgogCiAxLiBMb2FkYWJsZSBtb2R1bGUKIAotICAgV2l0aCBgYENPTkZJR19L
VU5JVGBgIGVuYWJsZWQsIEtBU0FOLUtVbml0IHRlc3RzIGNhbiBiZSBidWlsdCBhcyBhIGxvYWRh
YmxlCi0gICBtb2R1bGUgYW5kIHJ1biBieSBsb2FkaW5nIGBga2FzYW5fdGVzdC5rb2BgIHdpdGgg
YGBpbnNtb2RgYCBvciBgYG1vZHByb2JlYGAuCisgICBXaXRoIGBgQ09ORklHX0tVTklUYGAgZW5h
YmxlZCwgdGhlIHRlc3RzIGNhbiBiZSBidWlsdCBhcyBhIGxvYWRhYmxlIG1vZHVsZQorICAgYW5k
IHJ1biBieSBsb2FkaW5nIGBga2FzYW5fdGVzdC5rb2BgIHdpdGggYGBpbnNtb2RgYCBvciBgYG1v
ZHByb2JlYGAuCiAKIDIuIEJ1aWx0LUluCiAKLSAgIFdpdGggYGBDT05GSUdfS1VOSVRgYCBidWls
dC1pbiwgS0FTQU4tS1VuaXQgdGVzdHMgY2FuIGJlIGJ1aWx0LWluIGFzIHdlbGwuCisgICBXaXRo
IGBgQ09ORklHX0tVTklUYGAgYnVpbHQtaW4sIHRoZSB0ZXN0cyBjYW4gYmUgYnVpbHQtaW4gYXMg
d2VsbC4KICAgIEluIHRoaXMgY2FzZSwgdGhlIHRlc3RzIHdpbGwgcnVuIGF0IGJvb3QgYXMgYSBs
YXRlLWluaXQgY2FsbC4KIAogMy4gVXNpbmcga3VuaXRfdG9vbAo=
--00000000000053d77606245ddd32--

