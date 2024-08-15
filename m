Return-Path: <linux-kernel+bounces-287803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4BB952CF9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA84BB24AA5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41BD1BF307;
	Thu, 15 Aug 2024 10:31:54 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7BB1BDAA9
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723717914; cv=none; b=Lltwijer4Rq5E6EzsmtJrmA4oHBzzmgQnYeCKzaEATBkktRwNcci4Tea4agZajNK2zQNVpHu8xqnmgHPji9W0LF9woQ+FtokfFV6Vc8OswSav98O+vuhmK13WDbMYqtTHhaLkWMh5oT0V8rLVg+X7PGMt9laVxQlIAXi3kLL6vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723717914; c=relaxed/simple;
	bh=URHSL4KC2PhkmcfJ3PvdV8Nb0wEiWPwgZrarxFiuIt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8RfEK6dl3Xi47hcXu7M9HUs8m8L8lf82a9gHn630VDSagaK9vZ9R26gZN1+hpBYONaa6Y96ALYBBwPrJsITTAc9wVGC7WKGPWZjGI6+t/uzQeDTYFPli5iOaDWFYbAmJ6GLSsdN8OSuk5y5VkN3GD6CDvrCT4yaHIctZf1joV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDC5C32786;
	Thu, 15 Aug 2024 10:31:52 +0000 (UTC)
Date: Thu, 15 Aug 2024 11:31:50 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: muchun.song@linux.dev, will@kernel.org, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hugetlbfs: add MTE support
Message-ID: <Zr3ZFmRqtkbrOJq7@arm.com>
References: <20240625233717.2769975-1-yang@os.amperecomputing.com>
 <ZoPz14fYSqVyvRTw@arm.com>
 <7a4a60af-e471-484b-a4a3-ed31daaca30b@os.amperecomputing.com>
 <546bf8d4-3680-4af3-8d4d-af2d7c192d04@os.amperecomputing.com>
 <ZoanN7hkWDBjCTu3@arm.com>
 <b140e3e1-cbf7-4b07-8239-abfe8b85d14c@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b140e3e1-cbf7-4b07-8239-abfe8b85d14c@os.amperecomputing.com>

Sorry for the delay (holidays etc.)

On Tue, Jul 09, 2024 at 10:42:58AM -0700, Yang Shi wrote:
> On 7/4/24 6:44 AM, Catalin Marinas wrote:
> > It might be better to convert those page flag checks to only happen on
> > the head page. My stashed changes from over a year ago (before we had
> > more folio conversions) below. However, as I mentioned, I got stuck on
> > folio_copy() which also does a cond_resched() between copy_highpage().
> 
> We can have the page flags set for head only for hugetlb page. For
> copy_highpage(), we should be able to do something like the below:
> 
> if  page_is_head && page_is_hugetlb && page_has_mte_tagged
>     set page_mte_tagged flags
>     copy tags for all sub pages
> else // <-- tail page or non-hugetlb page
>     current copy_highpage implementation

Ah, so you want in the first copy_highpage() for the head page to
populate the tags for the tail pages. I guess this would work.

> The hugetlb folio can't go away under us since migration path should pin it
> so the status of folio is stable. The preemption caused by cond_resched()
> should be fine too due to the pin and the page table entry keeps being
> migration entry until migration is done, so every one should just see
> migration entry and wait for migration is done.

Yeah, I don't see those pages going away, otherwise folio_copy() would
corrupt data.

> The other concerned user of copy_highpage() is uprobe, but it also pins the
> page then doing copy and it is called with holding write mmap_lock.
> 
> IIUC, it should work if I don't miss something. This also should have no
> impact on HVO. The overhead for other users of copy_highpage() should be
> also acceptable.

I also think so. We also have the copy_user_highpage() on arm64 that
calls copy_highpage() but I think that's also safe.

-- 
Catalin

