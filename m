Return-Path: <linux-kernel+bounces-304996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A45B49627E5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AC1D1F25B72
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA6717BB13;
	Wed, 28 Aug 2024 12:55:01 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD5617335C;
	Wed, 28 Aug 2024 12:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849701; cv=none; b=a2h+FEY1RPwHpNSCrJCzuQ8S03kDUzsVxOBCakwlxvK0Fj5daUxNIosYuCRJ2eyKHRQpqOs80bmc9No+0dEaYFRJCKME3TIiZ19Dkcc9T9G1BRhOVw/GPG2NE0SogKmqsk8SEhgFbDzxvkkkExQHpXBBjXQSbsUEuPrtIkr/zzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849701; c=relaxed/simple;
	bh=H9xGvRslflWZOOm5Scl/mBKn6XvgSSf5ROmmH8aPjBo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mJ+JNgg896u7ENOy+adRGAljJU3nQ76uJH9nfR/TYmMbCRrm2Upa1OJmExVBOGijcbzqQkn4otuj843WZfsH8RVQ7Htxpnloz/O+O9xpwPdsfMyVWdgOPU0mbvPHXBtRlyRRadRLNXHEy3/ASAn8eTNqUdB81e3qqz2rqi1HyUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1sjIBr-000000003J8-3ujq;
	Wed, 28 Aug 2024 08:54:23 -0400
Message-ID: <8d0a923115746ab77064764e391271403b5b820e.camel@surriel.com>
Subject: Re: [RFC 0/2] mm: introduce THP deferred setting
From: Rik van Riel <riel@surriel.com>
To: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Usama Arif
 <usamaarif642@gmail.com>,  Nico Pache <npache@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, David
 Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, Barry
 Song <baohua@kernel.org>,  Ryan Roberts <ryan.roberts@arm.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Lance Yang <ioworker0@gmail.com>, Peter Xu
 <peterx@redhat.com>, Rafael Aquini <aquini@redhat.com>, Andrea Arcangeli
 <aarcange@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Zi Yan
 <ziy@nvidia.com>
Date: Wed, 28 Aug 2024 08:54:23 -0400
In-Reply-To: <ouerpxb676mei3kndz53j4am4fo2duvygoatfnposo2rkct566@akl7ckd7nrvk>
References: <20240729222727.64319-1-npache@redhat.com>
	 <72320F9D-9B6A-4ABA-9B18-E59B8382A262@nvidia.com>
	 <CAA1CXcCD798gkLoZuz3Cd5-Wf2MRfnAG_EB0U3nbScZeFv09dw@mail.gmail.com>
	 <CAA1CXcCCOS8-aqcm+w8Aoqe2P5q005wMrgmtx=xjzJgjKFb7mg@mail.gmail.com>
	 <61411216-d196-42de-aa64-12bd28aef44f@gmail.com>
	 <CAA1CXcCe8QDir2KiWg=GmN4BErfXSDs_9kmnYfyK=X8H8U8QwA@mail.gmail.com>
	 <698ea52e-db99-4d21-9984-ad07038d4068@gmail.com>
	 <20240827110959.GA438928@cmpxchg.org>
	 <9cf237df1a7bb21bba1a464787938eba8f372658.camel@surriel.com>
	 <ouerpxb676mei3kndz53j4am4fo2duvygoatfnposo2rkct566@akl7ckd7nrvk>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33Aeo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdYdIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gUmllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986ogEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHVWjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE+BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTeg4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/j
	ddPxKRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/NefO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0MmG1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tPokBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznnekoTE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44NcQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhIomYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0IpQrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkEc4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Wed, 2024-08-28 at 09:17 +0300, Kirill A . Shutemov wrote:
> On Tue, Aug 27, 2024 at 09:18:58PM -0400, Rik van Riel wrote:
> >=20
> > Workload owners are going to have a real problem trying to figure
> > out what the best value of max_ptes_none should be for their
> > workloads.
> >=20
> > However, giving workload owners the ability to say "this workload
> > should not waste more than 1GB of memory on zero pages inside
> > THPs",
> > or 500MB, or 4GB or whatever, would then allow the kernel to
> > automatically adjust the max_ptes_none threshold.
>=20
> The problem is that we don't have and cannot have the info on zero
> pages
> inside THPs readily available. It requires memory scanning which is
> prohibitively expensive if we want the info to be somewhat up-to-
> date.
>=20
I'm not sure it needs to be super up to date.

After all, we only care when there is memory pressure, and
when there is memory pressure we will be doing some sort of
scanning, anyway.

With a shrinker in the mix, we do not need totally up to date
information, but can gradually approximate the target.

--=20
All Rights Reversed.

