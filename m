Return-Path: <linux-kernel+bounces-509957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE402A31688
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BC60188A23D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 20:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5D1261597;
	Tue, 11 Feb 2025 20:23:29 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC2D26562D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 20:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739305409; cv=none; b=Cep0M+W/wGv8RhUZ/8REV+8R0iTHdaP7PF41ojoMcQ12lnergUOtWho9maPc0WBmWPR5M+eNowwR/qtkX94zjjUFRyf1jiPPd4M1aomvn3zekCbhu7oGFvNuUtu4i16GR+z8siP99ZBYcbJNOpvxRGb5UIZN9VruTwDhnzROeuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739305409; c=relaxed/simple;
	bh=5dq4xyGUc2jwFeJ+8G56MUWYoHUlqkXEf/52bcTWrHI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T43gQ8lCZTOKp2UEFN0tWHl/gRArDY8mYmjGAvaLjjFxSIXUMPV/IDTSxoI60uX1kyUaeZDV+pN3b+MfmYOABVkdOSrC50mlKqGOqjCBt1Q3Jju2CIFCrm/IHjUlmP2L1Q041+jyss5q0dMGNdo3TWD46VTOUgvGG9pYU3xxhuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1thwmt-000000007Kq-2LZB;
	Tue, 11 Feb 2025 15:23:19 -0500
Message-ID: <b56f0ef79708c66adf8971b78d631eb5f318e48c.camel@surriel.com>
Subject: Re: [PATCH v9 01/12] x86/mm: make MMU_GATHER_RCU_TABLE_FREE
 unconditional
From: Rik van Riel <riel@surriel.com>
To: Brendan Jackman <jackmanb@google.com>, Peter Zijlstra
 <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de, 
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
 nadav.amit@gmail.com, 	thomas.lendacky@amd.com, kernel-team@meta.com,
 linux-mm@kvack.org, 	akpm@linux-foundation.org, jannh@google.com,
 mhklinux@outlook.com, 	andrew.cooper3@citrix.com, Manali Shukla
 <Manali.Shukla@amd.com>
Date: Tue, 11 Feb 2025 15:23:19 -0500
In-Reply-To: <CA+i-1C1fP+Lk4FGO+-sLMq+LmjVjm-1r-wG15oKtDDu0=gi+Gg@mail.gmail.com>
References: <20250206044346.3810242-1-riel@surriel.com>
	 <20250206044346.3810242-2-riel@surriel.com>
	 <CA+i-1C2QgSTq4gbGZqjyzGcuscsFZvymHvXnfJYuT-CNjPPuMQ@mail.gmail.com>
	 <20250211110721.GF29593@noisy.programming.kicks-ass.net>
	 <CA+i-1C1fP+Lk4FGO+-sLMq+LmjVjm-1r-wG15oKtDDu0=gi+Gg@mail.gmail.com>
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
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Tue, 2025-02-11 at 13:10 +0100, Brendan Jackman wrote:
>=20
> Maybe I can send a separate patch to note this in the commentary,
> it's
> interesting and useful to know.
>=20

I added a similar comment to this patch series
for v10 yesterday. I'll send it out after a few
more tests have finished running.

I'm not particularly invested in which version
of the comment gets merged :)

--=20
All Rights Reversed.

