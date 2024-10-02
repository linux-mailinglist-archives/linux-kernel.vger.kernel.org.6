Return-Path: <linux-kernel+bounces-348360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2A198E697
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 01:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FE97B2225A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 23:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32A119D077;
	Wed,  2 Oct 2024 23:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dfhddu4o"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186388286A
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 23:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727910563; cv=none; b=EaVHkikakM5jDFHSPFe9lY9zTJpsPdO3GWJbCOpSm9VtLf8lnDuInvl7XixyT4w01s/rILmMpUvmia+iIXJdiz7jxrf4UkYfslo2EcuhT7yEBZWvx/tTXqUiMRg+EttwP/phz2K+kKHRPxGe6SLI7JPWTqf30ZDqT3BqxUHx6bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727910563; c=relaxed/simple;
	bh=Ej1rcUG+ezhqFZnFzQpCwHaJ5PYUCdyTJ/ppF04QEdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHhnEzzyC2totx8mQeiiLbBPdRBjK5r+ePuKMs+8ZiDiUHFmuDMWmeuBgjHrIs7qmunl4iCTB2gujmokWeeptjj4GR5EMyoibnZkVa8tllfWOuHy+s1h3idis7NBbqBJE49cyHYyUeLT2WVEiKzIsMVbNNE+fSU7zdd7j5JsBkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dfhddu4o; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 2 Oct 2024 16:09:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727910556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=24Y9sBYzc7//kYNIJDx4hME+s6CyiY68wj/PqtM7k5U=;
	b=Dfhddu4oV5hRXi3eExN19YvHIvk8qF9I/X5krVBec64Jl0UpFpyLNRFbwaisWOfXj5UGiC
	VVilH2vRZzeDA25R5k8jF0h5IgnJhJ0Rh+8G9d1AgPQxuU22rtKOHnzHjKCppHLoaxVQbr
	8dZS2zwXGVKHbe0NbRcd4h//4Bv29Wo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>, Yu Zhao <yuzhao@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] mm/truncate: reset xa_has_values flag on each iteration
Message-ID: <zdrmuzjcgxps3ivdvnmouygdct2lr6qj2avypuj3hatv746rye@7wu3txx5hyou>
References: <20241002225150.2334504-1-shakeel.butt@linux.dev>
 <20241002155555.7fc4c6e294c75e2510426598@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002155555.7fc4c6e294c75e2510426598@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 02, 2024 at 03:55:55PM GMT, Andrew Morton wrote:
> On Wed,  2 Oct 2024 15:51:50 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> > Currently mapping_try_invalidate() and invalidate_inode_pages2_range()
> > traverses the xarray in batches and then for each batch, maintains and
> > set the flag named xa_has_values if the batch has a shadow entry to
> > clear the entries at the end of the iteration. However they forgot to
> > reset the flag at the end of the iteration which cause them to always
> > try to clear the shadow entries in the subsequent iterations where
> > there might not be any shadow entries. Fixing it.
> > 
> 
> So this is an efficiency thing, no other effects expected?
> 

Correct, just an efficiency thing.

