Return-Path: <linux-kernel+bounces-534290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 025AFA46517
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEEA019C193E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B8621CC68;
	Wed, 26 Feb 2025 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AX7MX3wM"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035141624E0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584032; cv=none; b=bOnvZd0TwRPrr8IW+C4yrDunf/5gO2tWq/qyQXUig0mZLTaNgArAbnljGw4P/PljA0DjJyvyivTZwP4Xl+ckQNzpacM6tf3YidibGIFJAvCTJgm2EpdZLapxim68Q9933AGnSOP6cg5QAbYGv+d5Q9IDWcovcObm76nqMqqoLHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584032; c=relaxed/simple;
	bh=/bB/yZLGL3DWE2PUG3M5lw3kgRGqPeayAXHhqErbi10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBKCEFOCCYkCnOj0OOZFUoDJIsKL7DeApCiNZEK6egzVc/+URLpPUTA8knf2pRe5TahXz5rZlEzKuMemCaEiIisR3muCT8pxcbVUBXiK9EryCfyroftX6kkKhGfn4gTHsJpiEL6X6YVuS5vk6e+vO/TpTVv8X6iZjxLbMygS4NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AX7MX3wM; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 26 Feb 2025 15:33:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740584027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YghUIUtGJFDQ2JIT44YnprUkmQqQzSSO6n1OgaplZRk=;
	b=AX7MX3wMWgNLdA8YTvt8dSILGImJRuHBwZfP9SPk6Nd9B/IDdvnJogK8ehjKudK4AGLCH/
	T4oOprYE0r6ihvzf6xnEmIstsYkgnvP2L0maEprSSu4xkQK5pvsUwcIoP2U6awEyoyHMse
	zjCIDxX/rtym74xSdEBw1a5mqf/+fYg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
	chengming.zhou@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zswap: do not crash the kernel on decompression failure
Message-ID: <Z780VzBOE3LKY0yi@google.com>
References: <20250225213200.729056-1-nphamcs@gmail.com>
 <Z76Go1VGw272joly@google.com>
 <20250226045727.GB1775487@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226045727.GB1775487@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 25, 2025 at 11:57:27PM -0500, Johannes Weiner wrote:
> On Wed, Feb 26, 2025 at 03:12:35AM +0000, Yosry Ahmed wrote:
> > On Tue, Feb 25, 2025 at 01:32:00PM -0800, Nhat Pham wrote:
> > > Currently, we crash the kernel when a decompression failure occurs in
> > > zswap (either because of memory corruption, or a bug in the compression
> > > algorithm). This is overkill. We should only SIGBUS the unfortunate
> > > process asking for the zswap entry on zswap load, and skip the corrupted
> > > entry in zswap writeback.
> > 
> > Some relevant observations/questions, but not really actionable for this
> > patch, perhaps some future work, or more likely some incoherent
> > illogical thoughts :
> > 
> > (1) It seems like not making the folio uptodate will cause shmem faults
> > to mark the swap entry as hwpoisoned, but I don't see similar handling
> > for do_swap_page(). So it seems like even if we SIGBUS the process,
> > other processes mapping the same page could follow in the same
> > footsteps.
> 
> It's analogous to what __end_swap_bio_read() does for block backends,
> so it's hitchhiking on the standard swap protocol for read failures.

Right, that's also how I got the idea when I did the same for large
folios handling.

> 
> The page sticks around if there are other users. It can get reclaimed,
> but since it's not marked dirty, it won't get overwritten. Another
> access will either find it in the swapcache and die on !uptodate; if
> it was reclaimed, it will attempt another decompression. If all
> references have been killed, zswap_invalidate() will finally drop it.
> 
> Swapoff actually poisons the page table as well (unuse_pte).

Right. My question was basically why don't we also poison the page table
in do_swap_page() in this case. It's like that we never swapoff.

This will cause subsequent fault attempts to return VM_FAULT_HWPOISON
quickly without doing through the swapcache or decompression. Probably
not a big deal, but shmem does it so maybe it'd be nice to do it for
consistency.

> 
> > (2) A hwpoisoned swap entry results in VM_FAULT_SIGBUS in some cases
> > (e.g. shmem_fault() -> shmem_get_folio_gfp() -> shmem_swapin_folio()),
> > even though we have VM_FAULT_HWPOISON. This patch falls under this
> > bucket, but unfortunately we cannot tell for sure if it's a hwpoision or
> > a decompression bug.
> 
> Are you sure? Actual memory failure should replace the ptes of a
> mapped shmem page with TTU_HWPOISON, which turns them into special
> swap entries that trigger VM_FAULT_HWPOISON in do_swap_page().

I was looking at the shmem_fault() path. It seems like for this path we
end up with VM_SIGBUS because shmem_swapin_folio() returns -EIO and not
-EHWPOISON. This seems like something that can be easily fixed though,
unless -EHWPOISON is not always correct for a diffrent reason.

> 
> Anon swap distinguishes as long as the swapfile is there. Swapoff
> installs poison markers, which are then handled the same in future
> faults (VM_FAULT_HWPOISON):
> 
> /*
>  * "Poisoned" here is meant in the very general sense of "future accesses are
>  * invalid", instead of referring very specifically to hardware memory errors.
>  * This marker is meant to represent any of various different causes of this.
>  *
>  * Note that, when encountered by the faulting logic, PTEs with this marker will
>  * result in VM_FAULT_HWPOISON and thus regardless trigger hardware memory error
>  * logic.

If that's the case, maybe it's better for zswap in the future if we stop
relying on not marking the folio uptodate, and instead propagate an
error through swap_read_folio() to the callers to make sure we always
return VM_FAULT_HWPOISON and install poison markers.

The handling is a bit quirky and inconsistent, but it ultimately results
in VM_SIGBUS or VM_FAULT_HWPOISON which I guess is fine for now.

>  */
> #define  PTE_MARKER_POISONED                    BIT(1)

