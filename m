Return-Path: <linux-kernel+bounces-534488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB2FA46753
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257413B1020
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28CC221DB5;
	Wed, 26 Feb 2025 17:03:14 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC65F1DE2A9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589394; cv=none; b=u3oa7uY/47CTWlqBUnskGVARs3ilFqUgsOKEQXwblPszEA9lY6CotbXetIPZ03t7nzQR4Xu10U90AKpEnmH+FEkNZlFIEYrzJSIz7xhJBcOv0EKwO8sLzouzOCDG+2clPySBUdNUTUdFD7p0TNsVh3U32Lx33pZGvdZmyjv/cYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589394; c=relaxed/simple;
	bh=TLXA1FoRHn2QluKXWO9dXWWYzbhjA3gHd7Gt5zghIDI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nl3ZbKo3dsQBL5ASYbNQhUWpyIfkTxa2poBPEKIMFVy+BWosL/Zs56zYPrAOtP1BXnZViJ0cDjmGVNDuaS/Pd1yBnaE+1iEfidtuHEDyk1E+m+3mC11vnzQzAysBLmv3Wb7DmALBv2hkjIIE0WRkln53ZDk8oDrgyoOt77iliOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tnKo3-000000003P0-3dj6;
	Wed, 26 Feb 2025 12:02:47 -0500
Message-ID: <297b28e9ef9f4cd983ae2e3dd4cf1fce8b74d0f1.camel@surriel.com>
Subject: Re: [PATCH v13 06/14] x86/mm: use broadcast TLB flushing for page
 reclaim TLB flushing
From: Rik van Riel <riel@surriel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org, 
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
 nadav.amit@gmail.com, 	kernel-team@meta.com, linux-mm@kvack.org,
 akpm@linux-foundation.org, 	jackmanb@google.com, jannh@google.com,
 mhklinux@outlook.com, 	andrew.cooper3@citrix.com, Manali.Shukla@amd.com,
 mingo@kernel.org
Date: Wed, 26 Feb 2025 12:02:47 -0500
In-Reply-To: <680053d3-4cf9-534a-1c52-c6e259b85452@amd.com>
References: <20250223194943.3518952-1-riel@surriel.com>
	 <20250223194943.3518952-7-riel@surriel.com>
	 <20250224132711.GHZ7xzr0vdhva3-TvK@fat_crate.local>
	 <7c2baf33265444089ab780848de29a1336a9a4cc.camel@surriel.com>
	 <20250225203803.GGZ74qK1oZWk8u69O4@fat_crate.local>
	 <20250225210300.GHZ74wBP2ogmM5P5lP@fat_crate.local>
	 <680053d3-4cf9-534a-1c52-c6e259b85452@amd.com>
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

On Wed, 2025-02-26 at 11:00 -0600, Tom Lendacky wrote:
> On 2/25/25 15:03, Borislav Petkov wrote:
> > On Tue, Feb 25, 2025 at 09:38:03PM +0100, Borislav Petkov wrote:
> > > On Tue, Feb 25, 2025 at 02:17:20PM -0500, Rik van Riel wrote:
> > > > Who do we need to ask to confirm that reading?
> > >=20
> > > Lemme figure it out.
> >=20
> > Confirmed - that really is the case.
>=20
> Hmmm... since this is for host/hypervisor TLB handling, this makes me
> think that we should always be setting the ASID valid bit with 0 for
> the
> ASID value in EDX[15:0] on all INVLPGB instructions in this series.
> Otherwise we will also be flushing any guest ASID TLB entries that
> match
> the conditions, when that isn't intended.

The ASID is always zero in this series.

We only ever use the PCID for address space identification.

--=20
All Rights Reversed.

