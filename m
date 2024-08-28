Return-Path: <linux-kernel+bounces-304181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053E4961B81
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 03:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3700A1C2319D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 01:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84323A8D0;
	Wed, 28 Aug 2024 01:30:49 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FC41BC2F;
	Wed, 28 Aug 2024 01:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724808649; cv=none; b=e5OHlezF7FihcGxGvwwDmcz+oNCiQNcmQo9zeCEvVAlDZkuOxmXHiDwTCtxEcqSv6amtPxh844bq8pE9f0e6cHKrhWPuAminvayYTqUIcwzDkNTX2Rii4oMUHGHsVtcxhX4kTrx23TvSE3TGN9LrrPmxM7NHdT9f/U1dRcQ6saY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724808649; c=relaxed/simple;
	bh=ms90ZfuGTSmYoDdlexybq2TrNT+dwIexRy+xuIKnH08=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tZdeqYcgpaNGo+8y6d3ywbFj/U9u40Sf8kMIaIUtYqx7e3JZmSkQbxQICJXOiqphKgtolRxgC3yDqfDO8tHZNAShSxMdn9XpqUT6Y9uqe1BTvToz/7mrldQpEZ3WZ7XoPL4DQjNvkqNS6Y/C2bF4uzNzIP7e7AoufKAUw4O3ZVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1sj7Ks-000000003Zt-3y7g;
	Tue, 27 Aug 2024 21:18:58 -0400
Message-ID: <9cf237df1a7bb21bba1a464787938eba8f372658.camel@surriel.com>
Subject: Re: [RFC 0/2] mm: introduce THP deferred setting
From: Rik van Riel <riel@surriel.com>
To: Johannes Weiner <hannes@cmpxchg.org>, Usama Arif <usamaarif642@gmail.com>
Cc: Nico Pache <npache@redhat.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Matthew
 Wilcox <willy@infradead.org>, Barry Song <baohua@kernel.org>, Ryan Roberts
 <ryan.roberts@arm.com>,  Baolin Wang <baolin.wang@linux.alibaba.com>, Lance
 Yang <ioworker0@gmail.com>, Peter Xu <peterx@redhat.com>,  Rafael Aquini
 <aquini@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>,  "Kirill A . Shutemov"
 <kirill.shutemov@linux.intel.com>, Zi Yan <ziy@nvidia.com>
Date: Tue, 27 Aug 2024 21:18:58 -0400
In-Reply-To: <20240827110959.GA438928@cmpxchg.org>
References: <20240729222727.64319-1-npache@redhat.com>
	 <72320F9D-9B6A-4ABA-9B18-E59B8382A262@nvidia.com>
	 <CAA1CXcCD798gkLoZuz3Cd5-Wf2MRfnAG_EB0U3nbScZeFv09dw@mail.gmail.com>
	 <CAA1CXcCCOS8-aqcm+w8Aoqe2P5q005wMrgmtx=xjzJgjKFb7mg@mail.gmail.com>
	 <61411216-d196-42de-aa64-12bd28aef44f@gmail.com>
	 <CAA1CXcCe8QDir2KiWg=GmN4BErfXSDs_9kmnYfyK=X8H8U8QwA@mail.gmail.com>
	 <698ea52e-db99-4d21-9984-ad07038d4068@gmail.com>
	 <20240827110959.GA438928@cmpxchg.org>
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

On Tue, 2024-08-27 at 13:09 +0200, Johannes Weiner wrote:
>=20
> I agree with this. The defer mode is an improvement over the upstream
> status quo, no doubt. However, both defer mode and the shrinker solve
> the issue of memory waste under pressure, while the shrinker permits
> more desirable behavior when memory is abundant.
>=20
> So my take is that the shrinker is the way to go, and I don't see a
> bonafide usecase for defer mode that the shrinker couldn't cover.
>=20
>=20
I would like to take one step back, and think about what some real
world workloads might want as a tunable for THP.

Workload owners are going to have a real problem trying to figure
out what the best value of max_ptes_none should be for their
workloads.

However, giving workload owners the ability to say "this workload
should not waste more than 1GB of memory on zero pages inside THPs",
or 500MB, or 4GB or whatever, would then allow the kernel to
automatically adjust the max_ptes_none threshold.

Once a workload is close to, or exceeding the maximum amount of
THP zero page overhead, we could both shrink THPs, and disable
direct THP allocation at page fault time for that workload.

If we want to give workload owners a predictable, easy to work
with tunable, we probably want both the shrinker and the deferred
allocation.

--=20
All Rights Reversed.

