Return-Path: <linux-kernel+bounces-271344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5035944D15
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E171F22456
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE26E1A0B06;
	Thu,  1 Aug 2024 13:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHZ6ODzM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF2816DC02
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518612; cv=none; b=W/V/HWTlSw8JF7v2FlhpU+e++y29cApoHdxbmZPwPQPsQL4miksegFAtlYt9s1XfoMhrZvx0B2CgXkCkcYiRTVSAHqAfIvGY1VNHxImvC0iuGjFrhWBIkWJvs03w2nHR1l8Er15VbQxss7wc5OoQOMZoueOU7x7Lqj85pIq9WlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518612; c=relaxed/simple;
	bh=rX7rb9hXMhlm2xmHKvLXykMAxNBBTXGZ3WbXhR4Q1zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJ60Iy4krjtKiiSH9aIfY5Ouyd1RCHFGDVih2F+xplv3bV8dc/JaMf61bIBi+Lv61ly0wmOwQu2MAXsKvvnv0yJAAsr1fgyRgpGb3+/TXVMHYk9iYVenNieaGrOqhAchiQBWZp2I+3EHOn3ABqbzQS4hh5lVEAEmwqtkvTOxZXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHZ6ODzM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF64C4AF0A;
	Thu,  1 Aug 2024 13:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722518611;
	bh=rX7rb9hXMhlm2xmHKvLXykMAxNBBTXGZ3WbXhR4Q1zY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eHZ6ODzMEz6vXABGsnmbdiF4B5FK05z6tLlhyOkPeYDrBYaxUVCwUcPEq6Xx84A3A
	 7JcrH6c4x+CDR36JQ1fI+1WXLKUOCP3UgD2jI4zyyRylqnkQHLJn1oyVTidVAQs9OU
	 BtB4P00y6LevFsPyiFKVmeWBitOy8b5hqaLe7CRHixO7+/TZHT5A8Ubrchgm5L8AfY
	 X/MBL7zrEPhw8JScqyYq1g2pBIVR7aFFlj5MvYbWEtJCvqZqp93Iu3XUr02JYqBTcj
	 SqyxHBN0aWNAkTjuk+/6gqAe6t+qbhoHW6kKPhMVVQSl4OpszSPdZTuSajjGSnqlHx
	 2D3xZItiFI7WQ==
Date: Thu, 1 Aug 2024 14:23:27 +0100
From: Will Deacon <will@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Avoid direct referencing page table enties in
 map_range()
Message-ID: <20240801132326.GA4794@willie-the-truck>
References: <20240725091052.314750-1-anshuman.khandual@arm.com>
 <3e82687a-0183-42f3-b32c-6d99dbd4fe49@arm.com>
 <20240801113440.GB4476@willie-the-truck>
 <c65c0bcc-149e-4f30-9bab-e5377230d2cd@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c65c0bcc-149e-4f30-9bab-e5377230d2cd@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Aug 01, 2024 at 01:48:17PM +0100, Ryan Roberts wrote:
> On 01/08/2024 12:34, Will Deacon wrote:
> > On Thu, Jul 25, 2024 at 11:36:56AM +0100, Ryan Roberts wrote:
> >> On 25/07/2024 10:10, Anshuman Khandual wrote:
> >>> Like else where in arm64 platform, use WRITE_ONCE() in map_range() while
> >>> creating page table entries. This avoids referencing page table entries
> >>> directly.
> >>
> >> I could be wrong, but I don't think this code is ever operating on live
> >> pgtables? So there is never a potential to race with the HW walker and therefore
> >> no need to guarrantee copy atomicity? As long as the correct barriers are placed
> >> at the point where you load the pgdir into the TTBRx there should be no problem?
> >>
> >> If my assertion is correct, I don't think there is any need for this change.
> > 
> > Agreed.
> 
> I think I need to row back on this. It looks like map_range() does act on live
> pgtables; see map_kernel() where twopass == true. init_pg_dir is populated then
> installed in TTBR1, then permissions are modified with 3 [un]map_segment()
> calls, which call through to map_range().

I think the permission part is fine, but I hadn't spotted that
unmap_segment() uses map_range() to zap the ptes mapping the text. That
*does* need single-copy atomicity, so should probably use
__set_pte_nosync().

> So on that basis, I think the WRITE_ONCE() calls are warranted. And to be
> consistent, I'd additionally recommend adding a READ_ONCE() around the:
> 
> if (pte_none(*tbl)) {

Why? I don't think we need that.

Will

