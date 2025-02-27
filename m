Return-Path: <linux-kernel+bounces-535174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B53A46FCA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595B816D88C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC85428373;
	Thu, 27 Feb 2025 00:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rZ/gTDFQ"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E445324B28
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740614636; cv=none; b=ddCJKGxFYxc/4Vq4ZJWt5KbFMoab4uBIc/t/q+wyn86ae+rIr5FBmSGnjqe8Yb5q1rVhzjXcjSTCaX1M35BiANHgAtD8u9Vs99fGc/W1aDpm8OivzYL1icXE00rLfV8EeHX1093Bn9WZHFvrHtLIiJZ4q/ZgrpxUSwVNi+imsxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740614636; c=relaxed/simple;
	bh=XeHY8UoB9z6j6DczgmO3hcITCPBP6mUHpMkvzG4IUF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dG7hpbdBP4ujFJ7MHcPQOMuycaeYC3BaxaJpDLpmL+DmgqAkibUWMkitb78l3rku+ABhPC6EAi1qlAHtY/mAimEp+mu7PUWpUIRh8Yy42gWEPH0DPYLOTQks+amRQMo2dxX8UcYKQPFvfq78/3a7G++yjCjDSgitMi+sAj2mqYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rZ/gTDFQ; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 27 Feb 2025 00:03:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740614631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=le6kNlXVRfm086n/45QPAP2GootGePeFsgHvWj72AMU=;
	b=rZ/gTDFQctKHR82tLw2MKwcl/WmrHvA79Q09RSXyT7u/W9CZoc2TZOgwm4cuno4xUxu8oi
	D6iZdOE3szQ0CbS8JSTXtusVY9zJrsGFnHiOW9SRtWozIhjM5SMRYhD4Ovbc0LstWkDyaP
	RvSORTY+BJBnZm01EicEVUtj/ZAn4WU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, chengming.zhou@linux.dev,
	linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zswap: do not crash the kernel on decompression failure
Message-ID: <Z7-r43-8ongoUDdZ@google.com>
References: <20250225213200.729056-1-nphamcs@gmail.com>
 <Z75_I5q7Qm_oPgMA@google.com>
 <CAKEwX=O=zcNBHaxqj34mZ0Q0OENsbdAOVR3ySW3v-mr--AjScw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKEwX=O=zcNBHaxqj34mZ0Q0OENsbdAOVR3ySW3v-mr--AjScw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

[..]
> > zswap_decompress()
> > {
> >         mutex_lock();
> >         ...
> >         ret = crypto_wait_req(..);
> >         ...
> >         mutex_unlock();
> >         ...
> >         if (ret || acomp_ctx->req->dlen != PAGE_SIZE) {
> 
> Hmmmm, do we need the mutex to protect acomp_ctx->req->dlen? No strong
> opinions here from my end TBH.

We can copy the length to a local variable if that's the case.

> 
> >                 /* SHIT */
> >                 return false;
> >         }
> >         return true;
> > }
> [...]
> >
> > We are doing load + erase here and in the writeback path now, so two
> > xarray walks instead of one. How does this affect performance? We had a
> > similar about the possiblity of doing a lockless xas_load() followed by
> > a conditional xas_erase() for zswap_invalidate():
> >
> > https://lore.kernel.org/lkml/20241018192525.95862-1-ryncsn@gmail.com/
> >
> > Unfortunately it seems like we can't trivially do that unless we keep
> > the tree locked, which we probably don't want to do throughout
> > decompression.
> >
> > How crazy would it be to remove the entry from the tree and re-add it if
> > compression fails? Does swapcache_prepare() provide sufficient
> > protection for us to do this without anyone else looking at this entry
> > (seems like it)?
> 
> My concern is, what happens if xa_store() in the re-add path fails
> because we do not have enough memory?

Hmm good point. xa_erase() is essentially xas_store(NULL), but I think
at some point if a node is made of entirely NULLs we'll free it, and it
would be theoritically possible that we hit this case.

Let's start by checking if the added xarray walk adds any noticable
overhead and go from there. Ideally we want to test with a large (and
sparse?) xarray to try and hit the worst case.

> 
> >
> > Anyway, this is all moot if the second walk is not noticeable from a
> > perf perspective.

