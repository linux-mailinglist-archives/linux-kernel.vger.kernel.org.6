Return-Path: <linux-kernel+bounces-171219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60308BE155
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6EDB1C203F7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E945B153811;
	Tue,  7 May 2024 11:45:19 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F16152172
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715082319; cv=none; b=Gpzo3WICpgKH142egxTUCe9L7Rno1dBDvWUe/QXiJRStJNv1lYi5AEeN96VqjntP81RU6pbOJ9hn+FgamvUCvbJm29B554QluHEa5fsoFfIViwiBjNuMFTOI3qwedguRMU5/ikt7278qKTH18kzklhARVHnRA1gvNXwLXnEwtv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715082319; c=relaxed/simple;
	bh=Rtv5oSv1iIBoJqb3A4DN0/IqS7sdGnxSfTJJoBWqabg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+j7ZcEzT//YHR/bcms64+U4lwR/Xj23DQSdHgAqSNswoB+h/C8V5B67xShgYVbGmFIoRDpYPtpQgM4UoJgfwRrxNjatG5IizNNcuma7WuvIMGxa5etSVZ4V4Xpweqlewzj4oe55f+DIljYD12XlPJBh5qCpvC9AJXAanl+qkAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F356CC2BBFC;
	Tue,  7 May 2024 11:45:16 +0000 (UTC)
Date: Tue, 7 May 2024 12:45:14 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
	Mike Rapoport <rppt@linux.ibm.com>,
	Shivansh Vij <shivanshvij@outlook.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] arm64/mm: Enable userfaultfd write-protect
Message-ID: <ZjoUSjWhEbohMfX0@arm.com>
References: <20240503144604.151095-1-ryan.roberts@arm.com>
 <20240507110750.GA22289@willie-the-truck>
 <3764382b-9fa6-4e94-ad5b-2e22e3e7c71a@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3764382b-9fa6-4e94-ad5b-2e22e3e7c71a@arm.com>

On Tue, May 07, 2024 at 12:17:18PM +0100, Ryan Roberts wrote:
> On 07/05/2024 12:07, Will Deacon wrote:
> > On Fri, May 03, 2024 at 03:45:58PM +0100, Ryan Roberts wrote:
> >> This series adds uffd write-protect support for arm64.
> >>
> >> Previous attempts to add uffd-wp (and soft-dirty) have failed because of a
> >> perceived lack of available PTE SW bits. However it actually turns out that
> >> there are 2 available but they are hidden. PTE_PROT_NONE was previously
> >> occupying a SW bit, but can be moved, freeing up the SW bit. Bit 63 is marked as
> >> "IGNORED" in the Arm ARM, but it does not currently indicate "reserved for SW
> >> use" like it does for the other SW bits. I've confirmed with the spec owner that
> >> this is an oversight; the bit is intended to be reserved for SW use and the spec
> >> will clarify this in a future update.
> >>
> >> So now we have two spare bits; patch 4 enables uffd-wp on arm64, using the SW
> >> bit freed up by moving PTE_PROT_NONE. This leaves bit 63 spare for future use
> >> (e.g. soft-dirty - see RFC at [4] - or some other usage).
> >>
> >> ---
> >>
> >> This applies on top of v6.9-rc5.
> > 
> > I chucked this into the CI on Friday and it looks to have survived the
> > long weekend, so I've gone ahead and merged it into for-next/core. Short
> > of any last minute failures (touch wood), this should land in 6.10.
> 
> Oh great - thanks!
> 
> Catalin was previously proposing to hold this until 6.11 - I'll leave you two to
> fight it out in case that's still his preference ;-)

Fine by me as well to go in 6.10. Will is taking the blame if it all
falls apart ;).

-- 
Catalin

