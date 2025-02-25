Return-Path: <linux-kernel+bounces-532298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE957A44B29
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5911C3B577E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C647F1A0BCA;
	Tue, 25 Feb 2025 19:18:04 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02685EC2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 19:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740511084; cv=none; b=V3IP99UC4jphW4gj8AOfLwmQVezXCKiDcbifAO2pbiNBsieWb88AEPistwI6rv+zwCjk4tdS2xvNM+wlqJ3Ss/zDBWFktgdxCp8JI/E56rz1kTzN/pzipTTYKvQUELqEY9Lrou+8pusIQTBSonxX5GHfF9TlOe6+vfY4uCoKwUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740511084; c=relaxed/simple;
	bh=xZXN1LUmK23+/0JBU5dwIm98J8Qqdrq3sNTAb9iX0QM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HFG0CDgb7fNIWJBVuLCS6fzaXyRfHfnz6+ZJDUntAWFcOc16IU4ad8Mejt+gn2EDChioIYeEJLB+Of2CM1/pxHDIrPyvb9Q3ydERiFkDrZoNJkKpSLrx1ioPsOLuYaSfFH4oOK9rK2xptno0wDVfsGr/m4EnXtogUdgYV3yCZK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tn0Qi-0000000062h-3AxP;
	Tue, 25 Feb 2025 14:17:20 -0500
Message-ID: <7c2baf33265444089ab780848de29a1336a9a4cc.camel@surriel.com>
Subject: Re: [PATCH v13 06/14] x86/mm: use broadcast TLB flushing for page
 reclaim TLB flushing
From: Rik van Riel <riel@surriel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org, 
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
 nadav.amit@gmail.com, 	thomas.lendacky@amd.com, kernel-team@meta.com,
 linux-mm@kvack.org, 	akpm@linux-foundation.org, jackmanb@google.com,
 jannh@google.com, 	mhklinux@outlook.com, andrew.cooper3@citrix.com,
 Manali.Shukla@amd.com, 	mingo@kernel.org
Date: Tue, 25 Feb 2025 14:17:20 -0500
In-Reply-To: <20250224132711.GHZ7xzr0vdhva3-TvK@fat_crate.local>
References: <20250223194943.3518952-1-riel@surriel.com>
	 <20250223194943.3518952-7-riel@surriel.com>
	 <20250224132711.GHZ7xzr0vdhva3-TvK@fat_crate.local>
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

On Mon, 2025-02-24 at 14:27 +0100, Borislav Petkov wrote:
> On Sun, Feb 23, 2025 at 02:48:56PM -0500, Rik van Riel wrote:
> >=20
> > +++ b/arch/x86/mm/tlb.c
> > @@ -1326,7 +1326,9 @@ void arch_tlbbatch_flush(struct
> > arch_tlbflush_unmap_batch *batch)
> > =C2=A0	 * a local TLB flush is needed. Optimize this use-case by
> > calling
> > =C2=A0	 * flush_tlb_func_local() directly in this case.
> > =C2=A0	 */
> > -	if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids) {
> > +	if (cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
> > +		invlpgb_flush_all_nonglobals();
>=20
> I'm confused. The docs say rAX needs to be 0x6 to do "Invalidate all
> TLB
> entries that match {ASID, PCID} excluding Global". But you're calling
> INVLPGB
> with rAX=3D=3D0 and the APM doesn't say what this does.
>=20
> I'm guessing you want this to mean invalidate all non-globals for any
> ASID and
> PCID. So I muss be missing the place in the docs where it says so...

You are right that it does not explicitly say it.
However, it does strongly hint at it:

"The TLB control field is specified in rAX[5:0]. It determines
which components of the address (VA, PCID, ASID) are valid for
comparison in the TLB and whether to include global entries in=C2=A0
the invalidation process.

...

rAX[3:0] provides for various types of invalidations. A few=C2=A0
examples are listed in the following table, but all values=C2=A0
are legal."=20

This text, to me, suggests we can filter the TLB
invalidations by some combination of virtual address,
PCID, or ASID, or not filter by any of those keys,
and invalidate them all.

Who do we need to ask to confirm that reading?

--=20
All Rights Reversed.

