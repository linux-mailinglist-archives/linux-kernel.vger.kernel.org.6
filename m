Return-Path: <linux-kernel+bounces-537579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DA6A48DB4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 02:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE9BF3AE95B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 01:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F59821364;
	Fri, 28 Feb 2025 01:14:47 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CB11DA3D
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 01:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740705286; cv=none; b=RV1PqUyZ71lj/J36TGKQ4VJyzssmnZnmHASu2dnHXmFKffF5EVbjkClNkKA1ZbhthZlqOFz9p+nZWvF8HoaNVS0Z31FB/FTYfJ0Nls1mibM/SKH61Gonjjv74/CSotmBxMJG0WSn7RcU2trDMQbW54Ulrk7648Xfd3GhonQMwaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740705286; c=relaxed/simple;
	bh=LMGGWA840V+iylSgal18OSNufVRm7V6h1Tzo8UNlwJM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aHK6/2QOjwJ1UBuItHyWk5aJWz6ygrApy3i5WApUh/9hqb68LZejGcpuXyUhHmfdzxoHi0/V9yTPKHkBPbfjERBSEikOy1qmZiL2jKgQCSv3lXqpqnWUdY9JGjSheLL+SfPf9ouixgLS+UglwsRY6rc8FqDGt5JXbjQwsrS/WXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tnown-000000008Pv-0wtD;
	Thu, 27 Feb 2025 20:13:49 -0500
Message-ID: <c6a38a1b6f27ae787dbfd99df225f464c274590e.camel@surriel.com>
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
Date: Thu, 27 Feb 2025 20:13:49 -0500
In-Reply-To: <2731f073-d529-7870-6d25-ebd2e44cd10c@amd.com>
References: <20250223194943.3518952-1-riel@surriel.com>
	 <20250223194943.3518952-7-riel@surriel.com>
	 <20250224132711.GHZ7xzr0vdhva3-TvK@fat_crate.local>
	 <7c2baf33265444089ab780848de29a1336a9a4cc.camel@surriel.com>
	 <20250225203803.GGZ74qK1oZWk8u69O4@fat_crate.local>
	 <20250225210300.GHZ74wBP2ogmM5P5lP@fat_crate.local>
	 <680053d3-4cf9-534a-1c52-c6e259b85452@amd.com>
	 <297b28e9ef9f4cd983ae2e3dd4cf1fce8b74d0f1.camel@surriel.com>
	 <059ba03a-a892-6a68-6000-c7db3dd6cf9c@amd.com>
	 <9086371cfe69760780d67ec279f69e91f65086a7.camel@surriel.com>
	 <2731f073-d529-7870-6d25-ebd2e44cd10c@amd.com>
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

On Wed, 2025-02-26 at 12:12 -0600, Tom Lendacky wrote:
>=20
> As long as you keep the ASID value in EDX[15:0] as 0, then you won't
> #GP. ASID 0 is the host/hypervisor. An ASID > 0 belongs to a guest.
>=20
I've been spending some time reading the KVM code,
and I don't think invlpgb would be currently useful
with KVM.

From reading pre_svm_run(), new_asid(), and svm_vcpu_run(),
it looks like the ASID number used might be different for
each VCPU, assigned on a per (physical host) CPU basis.

It would take some surgery to change that around.

Some googling around also suggests that the ASID address
space is even more limited than the PCID address space :(

--=20
All Rights Reversed.

