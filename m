Return-Path: <linux-kernel+bounces-307604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2924965039
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38C6DB24E60
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E741A1BD51E;
	Thu, 29 Aug 2024 19:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKlOH1Xd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8101BD00B
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 19:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724960794; cv=none; b=gQZ5ejtUi5idqEu3tzuNGqTimMmPEAlT/3nxRk8B35w1UmXbQ6Bycsb5D1cFUunaEQ53Z8Nnby8bMBmCbFDpkEOOYC+uVTcwSjlMbikOWdsgXgoJfgayT6BeMtxMzL4l8nRssjKGyRDTCpnWAAnciEvs1ih6HSPWntqdQgr3QRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724960794; c=relaxed/simple;
	bh=10dh7jnjT81MN0q3B+Lrr3xtfTLmhCikedT0exQ8d5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8MC2MCpmJo9ln8yi+VZ7kHsbFsk8BJu/8MD13bBJBi9YWBaOYDJOgtV/iAhi1rIMFM/IERRFvocT4xUaVbqAv5RTKJ1QRQ4ZRqJbGSSke4IcoyNI2zTTP/+Oxe58HETtWrkhE845T4AOFUw4Iaq+kmg9QHQ3c+3j991aD6HMmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKlOH1Xd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C416CC4CEC1;
	Thu, 29 Aug 2024 19:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724960793;
	bh=10dh7jnjT81MN0q3B+Lrr3xtfTLmhCikedT0exQ8d5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JKlOH1Xds/tunf71DHY+DPWMAGwrEodyappwyScajNqgUnINNAsrntwdTJmvJlHi0
	 ViabpkAKRgz15UNHFzVIpiX18QGXaP4px2pFWPXj1sDnqVJByt0g8I8o2+JFFD9Gmj
	 VNgZydgFUvrBH2Wrl+vrx90ZN8zkOj8cxZ/9SULiuLOUvBvwSi8q3wRhMAzun8SLQC
	 /goTiYOL7uTrRKRzz1pQQ5Wc+xVFriQ4jC3+lojZPyzKFKXHGODdk1QwXu3CJ9sOCx
	 /LiRVLUTAVUcbkAmk9THtNcL3tnWajzNYwwaSmPg0GM6RTQNYvUVHGaEX2xh7Yr0m9
	 GMHrteM4u8VFQ==
Date: Thu, 29 Aug 2024 20:46:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Aishwarya TCV <aishwarya.tcv@arm.com>, dev.jain@arm.com
Subject: Re: [PATCH v2 06/10] mm: avoid using vma_merge() for new VMAs
Message-ID: <51452bab-65ef-4924-8ca8-61536d2bc168@sirena.org.uk>
References: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
 <57f55a1473586a88211e04b44c6b128332d4272c.1724441678.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f5NSZ20PrPX2cu+u"
Content-Disposition: inline
In-Reply-To: <57f55a1473586a88211e04b44c6b128332d4272c.1724441678.git.lorenzo.stoakes@oracle.com>
X-Cookie: YOU PICKED KARL MALDEN'S NOSE!!


--f5NSZ20PrPX2cu+u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 23, 2024 at 09:07:01PM +0100, Lorenzo Stoakes wrote:
> Abstract vma_merge_new_vma() to use vma_merge_struct and rename the
> resultant function vma_merge_new_range() to be clear what the purpose of
> this function is - a new VMA is desired in the specified range, and we wish
> to see if it is possible to 'merge' surrounding VMAs into this range rather
> than having to allocate a new VMA.

This patch, which is in -next today with the fixup Lorenzo posted as
commit 8c9d0f8b1e9a42586, seems to be causing problems with the mremap
expand merge selftest.  The test has been failing for a few days.  It
unfortunately doesn't log anything about why it's upset:

# # ok 15 5MB mremap - Source 1MB-aligned, Dest 1MB-aligned with 40MB Preamble
# # not ok 16 mremap expand merge
# # ok 18 mremap mremap move within range

I identified this commit using a bisect which appears to converge fairly
smoothly, I didn't do any other analysis:

git bisect start
# status: waiting for both good and bad commits
# bad: [b18bbfc14a38b5234e09c2adcf713e38063a7e6e] Add linux-next specific files for 20240829
git bisect bad b18bbfc14a38b5234e09c2adcf713e38063a7e6e
# status: waiting for good commit(s), bad commit known
# good: [559a93afece952cb129a236febe5d1b8f7c79367] Merge branch 'for-linux-next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
git bisect good 559a93afece952cb129a236febe5d1b8f7c79367
# bad: [47b9fb7c1f3efb63f2a5ed614385476856196527] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git
git bisect bad 47b9fb7c1f3efb63f2a5ed614385476856196527
# bad: [3582529887df7b4d397a05584ceb9d9944b54328] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git
git bisect bad 3582529887df7b4d397a05584ceb9d9944b54328
# bad: [a97442baf3538d884696539023a068269c983182] Merge branch 'at91-next' of git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git
git bisect bad a97442baf3538d884696539023a068269c983182
# bad: [9287e4adbc6ab8fa04d25eb82e097fed877a4642] mm: optimization on page allocation when CMA enabled
git bisect bad 9287e4adbc6ab8fa04d25eb82e097fed877a4642
# good: [becee36d72a57fd245033efdfd94cb54ac24472e] mm: swap: extend swap_shmem_alloc() to support batch SWAP_MAP_SHMEM flag setting
git bisect good becee36d72a57fd245033efdfd94cb54ac24472e
# good: [8939071cd2fdfd69f48631845613f5d841e0e97e] selftests-test_zswap-add-test-for-hierarchical-zswapwriteback-fix
git bisect good 8939071cd2fdfd69f48631845613f5d841e0e97e
# bad: [42c5d3ae23db3086624db99c52498d5843d3b88a] mm/damon/core-test: fix damon_test_ops_registration() for DAMON_VADDR unset case
git bisect bad 42c5d3ae23db3086624db99c52498d5843d3b88a
# good: [6abe8def9543d42a31fa6560410a1ab45b3e1917] mm/vma: drop incorrect comment from vms_gather_munmap_vmas()
git bisect good 6abe8def9543d42a31fa6560410a1ab45b3e1917
# bad: [bdf4d125288d2ac24a49f7f52d882261bed6e1e1] mm: vmalloc: refactor vm_area_alloc_pages() function
git bisect bad bdf4d125288d2ac24a49f7f52d882261bed6e1e1
# good: [5cc3d95b7d3a1cd7c09772d6b7aaa0371cc37236] mm: abstract vma_expand() to use vma_merge_struct
git bisect good 5cc3d95b7d3a1cd7c09772d6b7aaa0371cc37236
# bad: [042a3d61fddaff155b6595d8e47323f1e85aefb3] mm: make vma_prepare() and friends static and internal to vma.c
git bisect bad 042a3d61fddaff155b6595d8e47323f1e85aefb3
# bad: [b46446ab789bc2cfc3d18ddcc0e93fa533f6b479] mm: only advance iterator if prev exists
git bisect bad b46446ab789bc2cfc3d18ddcc0e93fa533f6b479
# bad: [8c9d0f8b1e9a4258676714557c8d69fbb85578ab] mm: avoid using vma_merge() for new VMAs
git bisect bad 8c9d0f8b1e9a4258676714557c8d69fbb85578ab
# first bad commit: [8c9d0f8b1e9a4258676714557c8d69fbb85578ab] mm: avoid using vma_merge() for new VMAs

--f5NSZ20PrPX2cu+u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbQ0BQACgkQJNaLcl1U
h9CtGQf/d99BV4Jvx2lWkQIeHLGHZeB1aq79+UwWVBwQF2zvMKaRtFbHHH/BSr1s
bQVVRfRQSzp4VzV03AdPCfWbCyU/GP3AxvHHwB3JB7/Dq0kswqkXYeYjKVWm7ny1
OZ7r9snTeLV3JKaPW7y/D2BeXCMq+SYSjbRgVfoNsKaPdlXBu2LWAaj0YsrOqSmd
Jcmj2zVy477KyLM979Xnb2G9XISC3eZBs/M2U81S4NnLf+8aaaLKXwlpwDBBIpra
1JZnMPac9dJdgr0eu86WTWKgHczZFw7hnNavzlIy/l7wk5YRr5A9MduGJiiyCvld
elTOllORi74CZd6Jwmbpjehhsbnv9g==
=Z/Ps
-----END PGP SIGNATURE-----

--f5NSZ20PrPX2cu+u--

