Return-Path: <linux-kernel+bounces-527302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E14AEA4095D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 16:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7719189929C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 15:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5C919E975;
	Sat, 22 Feb 2025 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVBreqcq"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1A678F32;
	Sat, 22 Feb 2025 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740236921; cv=none; b=D8v5lGiYFa+3/omlaY8u12bmBeH/MGFACPkiI5qeU+4zq31Q4nmyhzKzmB2F+QaqYpU4Xljsc1J1DA0F4khKH/+tWt1kWE1/Cs6my3X1fZC1vsYI3NIUcYC4zcJRRECLUCwIcgkf9KoA5wDrzmIyiVqst9sGWXqXIKxeC6qvccI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740236921; c=relaxed/simple;
	bh=QtuG/5BcoUsjSrbU4qpV+q15VbeQ71cUAi9kEK9SiH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gFfRuWd8chrbgskVJBJc6YhLwhwJZaE0QwpICd/eW1CRvR2mcW0gzxmN6SijzQR1Q9gcN77y737lPaNv1alF2MGUvd5tYmGaKtMqPIS2dzLmaGY+QYN+QEkHSk/jC4OM3DMi5Ue/a3FSYhwhI6oayaxrzfVQgxpehyG077yGcJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVBreqcq; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e65baef2edso26441596d6.2;
        Sat, 22 Feb 2025 07:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740236918; x=1740841718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtuG/5BcoUsjSrbU4qpV+q15VbeQ71cUAi9kEK9SiH8=;
        b=fVBreqcqygTOpvHlIwNcjJ4bxQCiawAmxUyoSWzs+7nCbsKC4i0Dz67KrRRtSmxw2z
         pLmHJNjeotJhDeWyO5g7WjhRRyo0ujcmDzLMb9OgzPNiO992qvfdkSb9eU9AjkKqQdo/
         pRXHLd0k5q1Rlf+zj29B3xxlPmPlxfTY5BZwDQXBLUY6J2EF+SyWEaS/CaUvZhbklKXq
         v9DeYqpgAMZLRAQehrd1GE0Iwx6ncTA64rjkLiOm1Xtx23P4dJPP8D5jyON8UG9JM1SR
         q4N4YlpbdUBBAqRjH+I0hGpfDREySqjK5edMV+tC/7y06v6adf4Uvmi5jCkH5hMM7rTS
         sCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740236918; x=1740841718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtuG/5BcoUsjSrbU4qpV+q15VbeQ71cUAi9kEK9SiH8=;
        b=uRbI2cj0TkP4j9JKCf9ue88NqZMROb8P1YjwHd7aJLglKVAHmYE1SyesPVVdPR3HhT
         NdvGVBFE2HwHk+oaY3Pw9iQ0dT1R9YiY1nyIzqI3u/lGjzIe/19RPKOoSlkQ1F08Zm2d
         YoDYyFn9unONBgYCaOpUQsti7uDk+ML/lsxABHsYVFJ2CNDJSpT0dfRlMnwcA/HALw6Z
         QasZmH+ItDHvtru4Vd/PdpoTAlx7Mx86BvAZCGNouzAY6h6ZVpTuWSeAmwD/pSeV7+i3
         lgLIoXYEUmPJzOVC86gc1mskpH4OiFYKGYdjlnNKQFvuWUDzAQkA1dAc9PIb9KDTTyGH
         iFww==
X-Forwarded-Encrypted: i=1; AJvYcCV7MLwA678lb5KJXppTVvIz+SEY/BsOmShs6xmIX6zVKOM/wyvN+oFLtSNL6jkIQxInbocB6oUHjc4=@vger.kernel.org, AJvYcCXdKyfHdYVyIkXwomNqlHn8Li1nYmrBKWPDTyYQXhvviVmXyi3sAuCDgAkmX6oqZtxAShg1mozCo5PnyjJn@vger.kernel.org
X-Gm-Message-State: AOJu0YwAzoA1E9jYhT154o0MEgfwc0jRVKkodM5EoTSeoIELujqW+96c
	r5jAbSay0dCgh7Kc4I4LxEkqKzjNG3/il/H17EXTakmrjzGYZ7iOJSCw4XT6Q1+nCZnut26Q7eU
	J8Wv1M7i+z7o2yAeLy3WbVjSTRYA=
X-Gm-Gg: ASbGnct0V0rqKpSz85jazlWugkK8mKx5rv9rXs609E1vlIbzfk2FzcheLcjejDdl/Uo
	iQBBjewvhJ5tvRsVLMVMFwe2uEU2yEia3CSW33oLHk4VYxB0/kt6317vmUn61XY51OBdxPsJaY5
	qAYLrl/QhbHA==
X-Google-Smtp-Source: AGHT+IEJ2JsBIFft6qtbntZmh6AxGF+u51NNVilXV5V7bSD/sZi1cOS+hJiUD4Pv6rAwQGUfSVoXl46LYmb2ewIlxz0=
X-Received: by 2002:a05:6214:400d:b0:6e4:3de6:e67a with SMTP id
 6a1803df08f44-6e6ae967571mr77225696d6.30.1740236918641; Sat, 22 Feb 2025
 07:08:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739866028.git.maciej.wieczor-retman@intel.com>
 <2a2f08bc8118b369610d34e4d190a879d44f76b8.1739866028.git.maciej.wieczor-retman@intel.com>
 <CA+fCnZdtJj7VcEJfsjkjr3UhmkcKS25SEPTs=dB9k3cEFvfX2g@mail.gmail.com>
 <lcbigfjrgkckybimqx6cjoogon7nwyztv2tbet62wxbkm7hsyr@nyssicid3kwb> <ffbyaler57cdwgs5axtdpnwg52jtwx7tx2rykjro755c45mihl@czmbriuhg3to>
In-Reply-To: <ffbyaler57cdwgs5axtdpnwg52jtwx7tx2rykjro755c45mihl@czmbriuhg3to>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sat, 22 Feb 2025 16:08:25 +0100
X-Gm-Features: AWEUYZkHzCChafiSRX_ILBVkyvuq6LP-GPRD5NbeLAJBmqWSC9A2XvM186wgsYI
Message-ID: <CA+fCnZe1U_nV_ByK2+XjBdXq0WNYzB0f30BsrsZKcxyOSu9cTg@mail.gmail.com>
Subject: Re: [PATCH v2 13/14] x86: runtime_const used for KASAN_SHADOW_END
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: kees@kernel.org, julian.stecklina@cyberus-technology.de, 
	kevinloughlin@google.com, peterz@infradead.org, tglx@linutronix.de, 
	justinstitt@google.com, catalin.marinas@arm.com, wangkefeng.wang@huawei.com, 
	bhe@redhat.com, ryabinin.a.a@gmail.com, kirill.shutemov@linux.intel.com, 
	will@kernel.org, ardb@kernel.org, jason.andryuk@amd.com, 
	dave.hansen@linux.intel.com, pasha.tatashin@soleen.com, 
	ndesaulniers@google.com, guoweikang.kernel@gmail.com, dwmw@amazon.co.uk, 
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 4:27=E2=80=AFPM Maciej Wieczor-Retman
<maciej.wieczor-retman@intel.com> wrote:
>
> Also I was wondering if you know what "hwasan-mapping-offset-dynamic" opt=
ion is?
> I noticed it in the llvm docs but can't find a good description what it d=
oes,
> even from looking at the code in HWAddressSanitizer.cpp. If
> hwasan-mapping-offset is not implemeneted for x86 I doubt this is but may=
be it
> could help in a cleaner makefile for x86 at least? Especially once these =
options
> will be working in x86 llvm.

Yeah, reading the code [1] works better to understand these options.

My understanding is that specifying
-hwasan-mapping-offset-dynamic=3Dglobal without -hwasan-mapping-offset
would make the generated code get the shadow memory address from the
__hwasan_shadow_memory_dynamic_address global variable. This option is
in the common code, so it should work on x86 too. But I believe it's
intended for userspace, not sure if it would work for the kernel.

Even if we use this option, I don't get how it would make the Makefile
cleaner - to me it already looks clean tbh :) But it will possibly
make KASAN work slower.

[1] https://github.com/llvm/llvm-project/blob/llvmorg-21-init/llvm/lib/Tran=
sforms/Instrumentation/HWAddressSanitizer.cpp#L1929

