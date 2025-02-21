Return-Path: <linux-kernel+bounces-525098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A88B4A3EABE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 03:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFEBC189FB0D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C54B1BD9DD;
	Fri, 21 Feb 2025 02:25:52 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C3B286298
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 02:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740104752; cv=none; b=uGknc7Dpi/FC2H4euSAjgAQeRuStNrvuOjG/aTqHtOtUwP/l/F0h60QAY3GsDi3tcX9J8Hzvuw0hk4JZUXr2HuSpJaWePtoh/iE7Fw3W1rvmAojvb08s8oz3sUUsYTKeyzEsEb5uGR0WcESuIReOnfn9CoSK1qUVWA5Dc6SazLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740104752; c=relaxed/simple;
	bh=7/yqfP3iceHrfnayukb1Orj2YKC5cwMxJacePl+CLT4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rvy7Dmh71XAOLDX7G6GAfoqw7LM1MgQ0CUdkVLJp2uyXIrEeNM9EmMzVDXjoVS6nV67UJeLTaSCiQU/Dj82TrL8IRi6dxmOAmhmxQEUOcT3h1GeCNF2Wo5q7WHNHLBuMCM3KxprQakl/q3h2soqQboo3zxLXb78S9Ikhbq18H8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tlIj5-000000006TZ-42Bn;
	Thu, 20 Feb 2025 21:25:15 -0500
Message-ID: <ef1792cc40b5812975008a9646a9ba8f3b432a62.camel@surriel.com>
Subject: Re: [PATCH v12 04/16] x86/mm: get INVLPGB count max from CPUID
From: Rik van Riel <riel@surriel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org, 
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
 nadav.amit@gmail.com, 	thomas.lendacky@amd.com, kernel-team@meta.com,
 linux-mm@kvack.org, 	akpm@linux-foundation.org, jackmanb@google.com,
 jannh@google.com, 	mhklinux@outlook.com, andrew.cooper3@citrix.com,
 Manali.Shukla@amd.com, Dave Hansen <dave.hansen@intel.com>
Date: Thu, 20 Feb 2025 21:25:15 -0500
In-Reply-To: <20250221015801.GHZ7fdqaGFEvsG6qW1@fat_crate.local>
References: <20250221005345.2156760-1-riel@surriel.com>
	 <20250221005345.2156760-5-riel@surriel.com>
	 <20250221015801.GHZ7fdqaGFEvsG6qW1@fat_crate.local>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Fri, 2025-02-21 at 02:58 +0100, Borislav Petkov wrote:
> On Thu, Feb 20, 2025 at 07:53:03PM -0500, Rik van Riel wrote:
> > diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
> > index 2a7279d80460..bb6943c21b7f 100644
> > --- a/arch/x86/Kconfig.cpu
> > +++ b/arch/x86/Kconfig.cpu
> > @@ -401,6 +401,10 @@ menuconfig PROCESSOR_SELECT
> > =C2=A0	=C2=A0 This lets you choose what x86 vendor support code your
> > kernel
> > =C2=A0	=C2=A0 will include.
> > =C2=A0
> > +config X86_BROADCAST_TLB_FLUSH
> > +	def_bool y
> > +	depends on CPU_SUP_AMD && 64BIT
> > +
> > =C2=A0config CPU_SUP_INTEL
> > =C2=A0	default y
> > =C2=A0	bool "Support Intel processors" if PROCESSOR_SELECT
> > @@ -431,6 +435,7 @@ config CPU_SUP_CYRIX_32
> > =C2=A0config CPU_SUP_AMD
> > =C2=A0	default y
> > =C2=A0	bool "Support AMD processors" if PROCESSOR_SELECT
> > +	select X86_BROADCAST_TLB_FLUSH
> > =C2=A0	help
> > =C2=A0	=C2=A0 This enables detection, tunings and quirks for AMD
> > processors
>=20
> You missed my comment again. How about you read review feedback more
> carefully
> please?
>=20
I try, but most of my brainpower the last round was
spent trying to figure out what to do where you and
Dave both wanted something different :)

> CPU_SUP_AMD selects X86_BROADCAST_TLB_FLUSH which depends on
> CPU_SUP_AMD which
> selects X86_BROADCAST_TLB_FLUSH which depends on CPU_SUP_AMD...

I'll fix that to have it depend only on 64BIT.

--=20
All Rights Reversed.

