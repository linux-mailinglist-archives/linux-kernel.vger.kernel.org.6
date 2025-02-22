Return-Path: <linux-kernel+bounces-527298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF0EA40953
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 16:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A294C1737B7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 15:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E04219D084;
	Sat, 22 Feb 2025 15:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B04n+P1B"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52C31487ED;
	Sat, 22 Feb 2025 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740236776; cv=none; b=PNBdaX56KLusW+FY/ROawNacq81GcDBb2AFDszgmR85/XsA/uBZyZFKyndeJ/aumZCBfwEL1sm8VcCFXPKAIe7faWSrdP5hmekTporGJXJPoKGYkfRVjrrb36peGILCjmGNTwamJ+qZk2BMV54TkkWUOyAJ6L9sN7lwRLr12FBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740236776; c=relaxed/simple;
	bh=fmQi/ZB5zetQzQQstVsJBvy+3xdas4eNJYf4ZSUkUJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OgW/pUH5IGLH2d9NICHeXNdHuLHKgyJyQjcGgPNz2aXj5eREdLHBEsV4mHhnvEAi3nuCyKbVuzL3FrGDkwofqPfISqpMrKOG3OVIYEzafs83mxoBbvkdpPwXjaXgvshGltCPBYIuQEJVQntU8DaEXaerAnCCmON08ac4RrzwQvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B04n+P1B; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-439946a49e1so19227985e9.0;
        Sat, 22 Feb 2025 07:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740236773; x=1740841573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzMYHvrv9HpWCutgVpnHfFN6zecH/fwJ8xUtPbSALWo=;
        b=B04n+P1BDmGn5W+2qYEW/A/MOcUGcEMiYY4wMbLgqxeXdFfZjv6Jxl6/l1nd7dzrRL
         9TXsuwXFdwRcqOvxA8Uwc7QNh34FxvWK1uAKxMqtvBVPFgERuvaYqdCFu18pw+w9beG9
         bYRWd+VIs25iQe1JdBAvgtr+2Awdx0V4HFxTLSf9BGOp9wnTDaJc0Ebpm8GKARjk7qK+
         MY/uQjo/cp07oNZ44+ZBiuLdixQrHXMBLzXRUlHgAeOSFVC3JIU0ypgo+POHJYlTOmKM
         cWDDKU3s2JKt1uo2I0l6VmWduGqxTLbYgz6DLG7zxeHnm2hVA7L529re8JOHs3JHrWM+
         9zFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740236773; x=1740841573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzMYHvrv9HpWCutgVpnHfFN6zecH/fwJ8xUtPbSALWo=;
        b=j2uHlJeUkX3kpUO+rB/Y5DE4Ds3m+ajU7j11ondMEknuHY/WHB24pnaq4YOzOwHEMF
         fDWOk9viV55d5unaePv2jW21pKFmFY9/6RpkXFqcvuFUUd7mOLJolOispKYBeLcWIHvi
         j4B1CXnWPgzC3gPPORIheauvcgM0o1uZQAl7Xonj2WKpsN4xhnmUhKUQ0m8WZpNZJAib
         u82YAyI/N9HeBtuJsWBqNETXkU+HzIFdbp7woqOzGeEjksOIq/PwJtu61xufTNftR/uJ
         WUJgnTGtQFUWd0Lel8XbRwoiPMdr/mNhKeYSwW/pVCvkVPpQKJNvdpDDERZMqgmNs/i9
         VCVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJkyEdcCaMSaOn8NdUzEj7rO1c42q8eDPdfgbk2PNtyKZwdSbqXZcNXj75iFsYJBPQQAtuDba5f58=@vger.kernel.org, AJvYcCXKKX5pw1pmhnaUw+c6Z/kiTQ/MHbM4rauxqBfais9VfiYqKgkkXxndaPqmQvlVIQgChMR44/QGFpmCY6QQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwpdNg4sINW3q1edWS7Wi3n/jO4GsNWg7gO5jHgrc76B+aiLizY
	q+mL6iGwNRE7teJMh/E/Im8i322rNDMhvQxltLp9DZLrD5Nnfxf9BJjyjE+rJ0hOZP4L624gIaP
	vJ5rx8vEBdqiLOg+VNrnAuA95XD8=
X-Gm-Gg: ASbGnct0QstWAzTCbkP0Lh6HN6OWC9mN/8dBK39nt/B0Oq9jktt93sz0RWXee5exz/l
	jaoM/VGhpvdti8oJlAA115RCnw8PVY8ZylSD8eCQIggfuHFD64JxY/rWma7UYLWDzyPvFv81GJN
	/BZbWRrfxc6A==
X-Google-Smtp-Source: AGHT+IG/5hYYNb7GJKzFAMA7qjQhD/2iJUv73XgnGmsxKtIVrNPOjotGccdz0pvGUzM8NDCVmC/Tnjv7k33iBVxJx6Y=
X-Received: by 2002:a05:600c:4f84:b0:439:955d:7ad9 with SMTP id
 5b1f17b1804b1-439ae1f145cmr75369895e9.14.1740236772914; Sat, 22 Feb 2025
 07:06:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739866028.git.maciej.wieczor-retman@intel.com>
 <168f775c4587f3a1338271390204a9fe16b150dd.1739866028.git.maciej.wieczor-retman@intel.com>
 <CA+fCnZcVSwUAC9_xtVAHvO6+RWDzt6wOzWN623m=dT-3G=NnTQ@mail.gmail.com> <cik7z3nwspdabtw5n2sfoyrq5nqfhuqcsnm42iet5azibsf4rs@jx3qkqwhf6z2>
In-Reply-To: <cik7z3nwspdabtw5n2sfoyrq5nqfhuqcsnm42iet5azibsf4rs@jx3qkqwhf6z2>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sat, 22 Feb 2025 16:06:02 +0100
X-Gm-Features: AWEUYZnFqlAhlbFhk_9-WAra7TCYMXPYd8CyySx1oX6HAXsK_aRCuDKHtzc0hoo
Message-ID: <CA+fCnZd6O0_fc1U-D_i2shcF4Td-6389F3Q=fDkdYYXQupX1NA@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] kasan: sw_tags: Use arithmetic shift for shadow computation
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: kees@kernel.org, julian.stecklina@cyberus-technology.de, 
	kevinloughlin@google.com, peterz@infradead.org, tglx@linutronix.de, 
	justinstitt@google.com, catalin.marinas@arm.com, wangkefeng.wang@huawei.com, 
	bhe@redhat.com, ryabinin.a.a@gmail.com, kirill.shutemov@linux.intel.com, 
	will@kernel.org, ardb@kernel.org, jason.andryuk@amd.com, 
	dave.hansen@linux.intel.com, pasha.tatashin@soleen.com, 
	guoweikang.kernel@gmail.com, dwmw@amazon.co.uk, mark.rutland@arm.com, 
	broonie@kernel.org, apopple@nvidia.com, bp@alien8.de, rppt@kernel.org, 
	kaleshsingh@google.com, richard.weiyang@gmail.com, luto@kernel.org, 
	glider@google.com, pankaj.gupta@amd.com, pawan.kumar.gupta@linux.intel.com, 
	kuan-ying.lee@canonical.com, tony.luck@intel.com, tj@kernel.org, 
	jgross@suse.com, dvyukov@google.com, baohua@kernel.org, 
	samuel.holland@sifive.com, dennis@kernel.org, akpm@linux-foundation.org, 
	thomas.weissschuh@linutronix.de, surenb@google.com, kbingham@kernel.org, 
	ankita@nvidia.com, nathan@kernel.org, ziy@nvidia.com, xin@zytor.com, 
	rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com, cl@linux.com, 
	jhubbard@nvidia.com, hpa@zytor.com, scott@os.amperecomputing.com, 
	david@redhat.com, jan.kiszka@siemens.com, vincenzo.frascino@arm.com, 
	corbet@lwn.net, maz@kernel.org, mingo@redhat.com, arnd@arndb.de, 
	ytcoode@gmail.com, xur@google.com, morbo@google.com, 
	thiago.bauermann@linaro.org, linux-doc@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 2:12=E2=80=AFPM Maciej Wieczor-Retman
<maciej.wieczor-retman@intel.com> wrote:
>
> >Is there any reason we need this change for x86 SW_TAGS besides the
> >optimization benefits?
>
> I wanted to have the shadow memory boundries aligned properly, to not was=
te page
> table entries, so the memory map is more straight forward. This patch hel=
ps with
> that, I don't think it would have worked without it.

Ok, I see - let's add this info into the commit message then.

> >However, I just realized that this check is not entirely precise. When
> >doing the memory-to-shadow mapping, the memory address always has its
> >top byte set to 0xff: both the inlined compiler code and the outline
> >KASAN code do this
>
> Do you mean that non-canonical addresses passed to kasan_mem_to_shadow() =
will
> map to the same space that the canonical version would map to?

No, but non-canonical address are never passed to
kasan_mem_to_shadow(): KASAN always resets the tag before calling this
function.

> What does that? Does the compiler do something more than is in
> kasan_mem_to_shadow() when instrumenting functions?

Same for the compiler, it always untags the pointer first [1].

[1] https://github.com/llvm/llvm-project/blob/llvmorg-20-init/llvm/lib/Tran=
sforms/Instrumentation/HWAddressSanitizer.cpp#L922

> >                   Thus, the possible values a shadow address can
> >take are the result of the memory-to-shadow mapping applied to
> >[0xff00000000000000, 0xffffffffffffffff], not to the whole address
> >space. So we can make this check more precise.
>
> In case my question above didn't lead to this: what happens to the rest o=
f the
> values if they get plugged into kasan_mem_to_shadow()?

We will get some invalid addresses. But this should never happen in
the first place.

