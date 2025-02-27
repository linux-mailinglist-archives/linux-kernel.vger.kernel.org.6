Return-Path: <linux-kernel+bounces-535717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0E5A4765C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52D73B1B23
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EAC2206BE;
	Thu, 27 Feb 2025 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oYro76F1"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EA3220687
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740640330; cv=none; b=lNwqeQx261jscd8J//IXILp0IVus+ZAVO3mbW/nnGjCZaX8kjd3AdE/Nr1mGlhMSltI7TDE1nZ1uLDR9s4HRC6ln17PzGznXbEuVO6VERXuJXctOj2e363VqHrQl5ZqqZorgf+kHC862MxHpu+NvE0PLkoTE5JDlGeh2dhor/DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740640330; c=relaxed/simple;
	bh=ZA/uwsUoeTUQclrBWYVtn9n4WpFsCxLUQiPi7JocoQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=US7/00P7BZ2lh8cwUH10a9zJYgQbZDnSTuaMvu7pQASh46JjO7YjoLx2O4zBpZy/kB2+Uf5FrcvHugVWtkrmSNTQ/iapQC0p9WpYyShEQJo0Z44BLk5JWrLmmL+oiwQcTNjMUYxOZJsIfRXWIIHqXbJDWtR4N7H+IDRRwPl6k6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oYro76F1; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 27 Feb 2025 07:11:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740640325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QSxiF897g4G7kv0+39CQIytewmyhY9s4Wvke+nHP2s0=;
	b=oYro76F1d34k+ogEVC27K6e6Utg0y0RwdQKPOwaApd4gh2wGoRpC2b6ditqd/Zo9ZP2Iku
	OfPRu5PiSX5hntzcTQ56QoH1HWHDIxNcna3rM8k3+5iQB+3zOJBTv96m17rYTfL7DGdDwR
	GJGOX6S29TxZ6yj7Ih/VxW+CGIwCuEU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
	chengming.zhou@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] zswap: do not crash the kernel on decompression
 failure
Message-ID: <Z8AQPyY7Qpux0mO0@google.com>
References: <20250227001445.1099203-1-nphamcs@gmail.com>
 <Z7-9o81kBfw4tFSz@google.com>
 <20250227043141.GB110982@cmpxchg.org>
 <Z7_7vah_U1JzmpCX@google.com>
 <20250227061616.GD110982@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227061616.GD110982@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 27, 2025 at 01:16:16AM -0500, Johannes Weiner wrote:
> On Thu, Feb 27, 2025 at 05:44:29AM +0000, Yosry Ahmed wrote:
> > On Wed, Feb 26, 2025 at 11:31:41PM -0500, Johannes Weiner wrote:
> > > On Thu, Feb 27, 2025 at 01:19:31AM +0000, Yosry Ahmed wrote:
> > > > On Wed, Feb 26, 2025 at 04:14:45PM -0800, Nhat Pham wrote:
> > > > >  	if (WARN_ON_ONCE(folio_test_large(folio)))
> > > > >  		return true;
> > > > >  
> > > > > +	entry = xa_load(tree, offset);
> > > > > +	if (!entry)
> > > > > +		return false;
> > > > > +
> > > > 
> > > > A small comment here pointing out that we are deliberatly not setting
> > > > uptodate because of the failure may make things more obvious, or do you
> > > > think that's not needed?
> > > >
> > > > > +	if (!zswap_decompress(entry, folio))
> > > > > +		return true;
> > > 
> > > How about an actual -ev and have this in swap_read_folio():
> > 
> > Good idea, I was going to suggest an enum but this is simpler.
> > 
> > > 
> > >         ret = zswap_load(folio);
> > >         if (ret != -ENOENT) {
> > >                 folio_unlock(folio);
> > >                 goto finish;
> > >         }
> > > 
> > > 	read from swapfile...
> > > 
> > > Then in zswap_load(), move uptodate further up like this (I had
> > > previously suggested this):
> > > 
> > > 	if (!zswap_decompress(entry, folio))
> > > 		return -EIO;
> > > 
> > > 	folio_mark_uptodate(folio);
> > > 
> > > and I think it would be clear, even without or just minimal comments.
> > 
> > Another possibility is moving folio_mark_uptodate() back to
> > swap_read_folio(), which should make things even clearer imo as the
> > success/failure logic is all in one place:
> 
> That works. bdev, swapfile and zeromap set the flag in that file.
> 
> > 	ret = zswap_load(folio);
> > 	if (ret != -ENOENT) {
> > 		folio_unlock(folio);
> > 		/* Comment about not marking uptodate */
> > 		if (!ret)
> > 			folio_mark_uptodate();
> > 		goto finish;
> > 	}
> 
> Personally, I like this one ^. The comment isn't needed IMO, as now
> zswap really isn't doing anything special compared to the others.
> 
> > or we can make it crystal clear we have 3 distinct cases:
> > 
> > 	ret = zswap_load(folio);
> > 	if (!ret) {
> > 		folio_unlock(folio);
> > 		folio_mark_uptodate();
> > 		goto finish;
> > 	} else if (ret != -ENOENT) {
> > 		/* Comment about not marking uptodate */
> > 		folio_unlock(folio);
> > 		goto finish;
> > 	}
> 
> This seems unnecessarily repetetive.

I know, but looking at the two, this one makes it clearer to me there
are 3 distinct cases, and the redundancy is not terrible.

So I personally prefer the latter, but I am fine either way.

