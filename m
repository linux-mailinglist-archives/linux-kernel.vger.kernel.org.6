Return-Path: <linux-kernel+bounces-527333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D98A409CF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 17:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8335B3B95E6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 16:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E9A1CBEAA;
	Sat, 22 Feb 2025 16:06:05 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F73EADC
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 16:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740240364; cv=none; b=PRwgaZ/Oi411HO/lDOSfxzkqwNZKqHLrNezPy23iLKkYAfkLaGT0oKVvzj1JpFfokKNQPDr6yl7SP48tZoOsuVkfNMyHC0ZTC3k0Wl43aprp/ZQ0MH+I+Tw7tIOnkktS2oLLStCu8fYb1s1LE9JBHf0AtrAnHGeAZdBJ6rynGAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740240364; c=relaxed/simple;
	bh=aFROy9ae+WikNdeM/LQHnwVp0Vg8VO4VTN5RMCnvvw4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fw844Yt9BTul4W5UoWA/p8NiWj/+Vp0t9JWOj53uR4YuD6pqQCRzu1z6MyFb7Lw2N7uIcjB+ZDWXRdtmAT7lN8VJ4o8pqB2MnZmL1Qok9w9gXTzfVo67lGeVOexqOTjzXRXP/nh2NAaTFLLa2/Dgr6m4PIQY9BFy/CJYYCLmDMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tls0b-000000005J6-0BJb;
	Sat, 22 Feb 2025 11:05:41 -0500
Message-ID: <eb2feccb1874399699731aa9f16049a375b0f9a9.camel@surriel.com>
Subject: Re: [PATCH v12 00/16] AMD broadcast TLB invalidation
From: Rik van Riel <riel@surriel.com>
To: Oleksandr Natalenko <oleksandr@natalenko.name>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, bp@alien8.de, peterz@infradead.org, 
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
 nadav.amit@gmail.com, 	thomas.lendacky@amd.com, kernel-team@meta.com,
 linux-mm@kvack.org, 	akpm@linux-foundation.org, jackmanb@google.com,
 jannh@google.com, 	mhklinux@outlook.com, andrew.cooper3@citrix.com,
 Manali.Shukla@amd.com
Date: Sat, 22 Feb 2025 11:05:41 -0500
In-Reply-To: <5861243.DvuYhMxLoT@natalenko.name>
References: <20250221005345.2156760-1-riel@surriel.com>
	 <5861243.DvuYhMxLoT@natalenko.name>
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

On Sat, 2025-02-22 at 12:29 +0100, Oleksandr Natalenko wrote:
>=20
> [=C2=A0=C2=A0 24.381400] RIP: 0010:get_cpu_cap+0x39b/0x4f0
>=20

> $ scripts/faddr2line arch/x86/kernel/cpu/common.o get_cpu_cap+0x39b
> get_cpu_cap+0x39b/0x500:
> get_cpu_cap at =E2=80=A6/arch/x86/kernel/cpu/common.c:1063
>=20
> 1060=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (c->extended_cpui=
d_level >=3D 0x80000008) {
> 1061=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
> 1062=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 c->x86_capability[CPUID_8000_0008_EBX] =3D ebx;
> 1063=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 invlpgb_count_max =3D (edx & 0xffff) + 1;
> 1064=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> ```
>=20
> Any idea what I'm looking at?

It's crashing when writing the value to the
invlpgb_count_max variable.

This would be because:
1) invlpgb_count_max is marked __ro_after_init, making
   it read-only after the system has finished booting, but
2) get_cpu_cap gets run at resume and CPU hotplug time!

Borislav, do you prefer I move the initialization of=C2=A0
invlpgb_count_max back to where it was before, or get
rid of the __ro_after_init thing?

--=20
All Rights Reversed.

