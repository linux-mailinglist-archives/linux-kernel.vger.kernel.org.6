Return-Path: <linux-kernel+bounces-535740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5D3A4769D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1342D188FE5B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0A62222A7;
	Thu, 27 Feb 2025 07:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IDf+qrhO"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C37191F8C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740641394; cv=none; b=VZ4yRlqehTzeXAiDO086z8qSfOShQHOpVmg/RQG3IontcuXEwypGpqG2M5ojPHNv0mWDiF2irj/3TLXxvWH18TOIJOK3ckdcsU2Fq0AyB9sNdVNhCrCVzaXo5jD12wI1/BCUVSSp/DYpfUNw6lV9jygmbLfarbl1gmuLAySfoAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740641394; c=relaxed/simple;
	bh=kHD8fFfJ4i7uizXiKZnOTHfdEbfvd3UROdMSTSbLN4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdUJZGvDdxjrUHq1wHbjOKN2/NG2uIep3ZW/Gen+OHIbS8LEkjibs9MHBhz0C5k5M5rMyfIfN77gP5jQo+JwSUi7VEJnsljDgXmnQTGpcZT9Zc10NVssnjUsWB/c+KW/Iqiu86BXn7Wm6CYBPmSV9NQ7FiE4pAprjZ728cuIsZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IDf+qrhO; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 27 Feb 2025 07:29:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740641390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SXNwsf4ANZAQ/D0DGM+1iMj7YQ8P/MXBqdHWaKj4AyM=;
	b=IDf+qrhO8kaYB9sCbvYzwC6wZ4hYRbhuBpC7c2ACdnRcF3gcXlrNBdHslhkeuDG/qNG7Pw
	sbw8afEhsemg/mCWCimoxTvh448CR3ewB5cA0JEJQXI38VV2On/+LWzpaYCcMvb4m4nnzn
	bv3IwBK07M0Dir7kHQB/aruwWbk7peo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
	chengming.zhou@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] zswap: do not crash the kernel on decompression
 failure
Message-ID: <Z8AUaQamubA9lWae@google.com>
References: <20250227001445.1099203-1-nphamcs@gmail.com>
 <Z7-9o81kBfw4tFSz@google.com>
 <20250227043141.GB110982@cmpxchg.org>
 <Z7_7vah_U1JzmpCX@google.com>
 <20250227061616.GD110982@cmpxchg.org>
 <Z8AQPyY7Qpux0mO0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8AQPyY7Qpux0mO0@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 27, 2025 at 07:11:59AM +0000, Yosry Ahmed wrote:
> On Thu, Feb 27, 2025 at 01:16:16AM -0500, Johannes Weiner wrote:
> > On Thu, Feb 27, 2025 at 05:44:29AM +0000, Yosry Ahmed wrote:
> > > On Wed, Feb 26, 2025 at 11:31:41PM -0500, Johannes Weiner wrote:
> > > > On Thu, Feb 27, 2025 at 01:19:31AM +0000, Yosry Ahmed wrote:
> > > > > On Wed, Feb 26, 2025 at 04:14:45PM -0800, Nhat Pham wrote:
> > > > > >  	if (WARN_ON_ONCE(folio_test_large(folio)))
> > > > > >  		return true;
> > > > > >  
> > > > > > +	entry = xa_load(tree, offset);
> > > > > > +	if (!entry)
> > > > > > +		return false;
> > > > > > +
> > > > > 
> > > > > A small comment here pointing out that we are deliberatly not setting
> > > > > uptodate because of the failure may make things more obvious, or do you
> > > > > think that's not needed?
> > > > >
> > > > > > +	if (!zswap_decompress(entry, folio))
> > > > > > +		return true;
> > > > 
> > > > How about an actual -ev and have this in swap_read_folio():
> > > 
> > > Good idea, I was going to suggest an enum but this is simpler.
> > > 
> > > > 
> > > >         ret = zswap_load(folio);
> > > >         if (ret != -ENOENT) {
> > > >                 folio_unlock(folio);
> > > >                 goto finish;
> > > >         }
> > > > 
> > > > 	read from swapfile...
> > > > 
> > > > Then in zswap_load(), move uptodate further up like this (I had
> > > > previously suggested this):
> > > > 
> > > > 	if (!zswap_decompress(entry, folio))
> > > > 		return -EIO;
> > > > 
> > > > 	folio_mark_uptodate(folio);
> > > > 
> > > > and I think it would be clear, even without or just minimal comments.
> > > 
> > > Another possibility is moving folio_mark_uptodate() back to
> > > swap_read_folio(), which should make things even clearer imo as the
> > > success/failure logic is all in one place:
> > 
> > That works. bdev, swapfile and zeromap set the flag in that file.
> > 
> > > 	ret = zswap_load(folio);
> > > 	if (ret != -ENOENT) {
> > > 		folio_unlock(folio);
> > > 		/* Comment about not marking uptodate */
> > > 		if (!ret)
> > > 			folio_mark_uptodate();
> > > 		goto finish;
> > > 	}
> > 
> > Personally, I like this one ^. The comment isn't needed IMO, as now
> > zswap really isn't doing anything special compared to the others.
> > 
> > > or we can make it crystal clear we have 3 distinct cases:
> > > 
> > > 	ret = zswap_load(folio);
> > > 	if (!ret) {
> > > 		folio_unlock(folio);
> > > 		folio_mark_uptodate();
> > > 		goto finish;
> > > 	} else if (ret != -ENOENT) {
> > > 		/* Comment about not marking uptodate */
> > > 		folio_unlock(folio);
> > > 		goto finish;
> > > 	}
> > 
> > This seems unnecessarily repetetive.
> 
> I know, but looking at the two, this one makes it clearer to me there
> are 3 distinct cases, and the redundancy is not terrible.
> 
> So I personally prefer the latter, but I am fine either way.

I just realized that swap_read_folio_zeromap() does the same trick, so
we should probably also move the folio_mark_uptodate() in there to
swap_read_folio().

Maybe we can do something like this:

/* Returns true if the folio was in the zeromap or zswap */
bool swap_read_folio_in_memory(struct folio *folio)
{
	int ret;

	ret = swap_read_folio_zeromap(folio);
	if (ret == -ENOENT)
		ret = zswap_load(folio);

	if (ret == 0) {
		folio_mark_uptodate(folio);
		folio_unlock(folio);
		return true;
	} else if (ret != -ENOENT) {
		folio_unlock(folio);
		return true;
	} else {
		return false;
	}
}

void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
{
	...
	if (swap_read_folio_in_memory(folio))
		goto finish;
	...
}

Admittedly, swap_read_folio_in_memory() is not a good name. Maybe
swap_read_folio_zeromap_or_zswap() :)

