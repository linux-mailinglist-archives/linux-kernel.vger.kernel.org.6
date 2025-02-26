Return-Path: <linux-kernel+bounces-535170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB899A46FC2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD96D3AFF7A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F49425FA37;
	Wed, 26 Feb 2025 23:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T8Kqo0MO"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291C627004B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 23:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740614329; cv=none; b=K2iItEmwjtRiFvF5rgNYympg3B/2YHVvu1nR2tQuVfOl816KzCBEIIdVe2U7DisjHZQ9QUWnDD4L99Vmu5ozdiMq9RMdc0Rq4966LmGLDmUymQ1ycSeu0GJIHu3yf3l6P4C6RKxt90xEVFxL2DqdfNQcmnY9IHV12hg/yi9Zg0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740614329; c=relaxed/simple;
	bh=4Pj9kjyz6137WG7himdJP85mNE+Wj/4ku1bjTMb3HhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSRL2wNYHaC5UuvLgOiwitu5q9zLbbCtKXkI9MtL3Jfh/Gb4Jho/csqX6NKTaRWVJdSKQcmv7DTjnGF+XSsBxpUfZG4i8VPLppBTAf3390he1op6bOAqRSdesWGh+/kw27eHi29yxCyUfiwitP1dSZwl8LI27VawRIOgw7Ndwno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T8Kqo0MO; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 26 Feb 2025 23:58:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740614323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yswrmCRrVsnZeMvvRyeXCzhvfViLwt8KDXKusOpWbOI=;
	b=T8Kqo0MO1ZeLalmsNe+Zfiw1jmoaYYsLmXnleDI/1ggc4o2kqX/wPyqiKkf9qKsWl/J+oU
	XGRzol7hoMsGyrYhK2ngvUz2dUntRBxYHJ8uz4awS2l8vSCPVGNnPUoiHQwbnURFOpJeb7
	SB9KuG8Pyt7nI95EOdH1Y9ScQgj2VuU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, chengming.zhou@linux.dev,
	linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zswap: do not crash the kernel on decompression failure
Message-ID: <Z7-qr6ar0HPyiYOv@google.com>
References: <20250225213200.729056-1-nphamcs@gmail.com>
 <Z76Go1VGw272joly@google.com>
 <CAKEwX=O+27wN5p_j5REfnEsfVi4zsgvyowdhGUKQseo9g1GtLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=O+27wN5p_j5REfnEsfVi4zsgvyowdhGUKQseo9g1GtLg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 26, 2025 at 03:29:06PM -0800, Nhat Pham wrote:
> On Tue, Feb 25, 2025 at 7:12 PM Yosry Ahmed <yosry.ahmed@linux.dev> wrote:
> >
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
> poisoned, I think? It's the weird SWP_PTE_MARKER thing.

Not sure what you mean here, I am referring to the inconsistency between
shmem_swapin_folio() and do_swap_page().

> 
> [...]
> 
> >
> >
> > (3) If we run into a decompression failure, should we free the
> > underlying memory from zsmalloc? I don't know. On one hand if we free it
> > zsmalloc may start using it for more compressed objects. OTOH, I don't
> > think proper hwpoison handling will kick in until the page is freed.
> > Maybe we should tell zsmalloc to drop this page entirely and mark
> > objects within it as invalid? Probably not worth the hassle but
> > something to think about.
> 
> This might be a fun follow up :) I guess my question is - is there a
> chance that we might recover in the future?
> 
> For example, can memory (hardware) failure somehow recover, or the
> decompression algorithm somehow fix itself? I suppose not?
> 
> If that is the case, one thing we can do is just free the zsmalloc
> slot, then mark the zswap entry as corrupted somehow. We can even
> invalidate the zswap entry altogether, and install a (shared)
> ZSWAP_CORRUPT_ENTRY. Future readers can check for this and exit if
> they encounter a corrupted entry?
> 
> It's not common enough (lol hopefully) for me to optimize right away,
> but I can get on with it if there are actual data of this happening
> IRL/in product :)ion

I am not aware of this being a common problem, but something to keep in
mind, perhaps.

