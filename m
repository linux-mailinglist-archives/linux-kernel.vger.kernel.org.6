Return-Path: <linux-kernel+bounces-549384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9049AA551E4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8DF916743C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E572E2566F8;
	Thu,  6 Mar 2025 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vQsIxCqt"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D93713635B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 16:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280119; cv=none; b=FnacHWMRGkwlnZvKfOoAzFwGth5yVKzsw+1PgM8mj7E+k0zF1sW7m+bh4T9kHG1b3kiODSKe0wfXQO0uFHY73ofg83pTK4zoLhq7oAzfpQYnVJqqvSGBgutGRG5Rfq+LhOLm19vVV+9RkF4cNqsz5G3v+pSSCdOTCBrVfadGmlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280119; c=relaxed/simple;
	bh=ojDLRfmuqq9GPR5jEUbYNGGbiERxN/yA2YCWiVfKxJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZXd0DDXzPSZvZzBpABXIaSWgc7T2P+F5y/8o/W2C3shRtAAL1WTQ4+79z4D4NZUTt5hZ5tyQPICArc7R5c7tfYsGgT5h5oR2X5c89lbWSFr63vwpk3IgYr5WjVW5z1r+Nv4PA6IuOi+ac6W9p3Q8zo17+JnNW4UFmm9K3RWj3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vQsIxCqt; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 6 Mar 2025 16:55:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741280112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kwhx/mtOi1GHi7BWSEe20K0H0IJsKkOByjdFjZj3bKc=;
	b=vQsIxCqtKLzZDN2FoDbwBZ2U/BVPqjwidfkrceSl4A798NuUB19lgu1wZEi7kwHPakRhDP
	ssQA/ydZeQ3uErvGo9p7CSJ4b0V9D+rGJbDkfxpWmJpixhunt341epOTV0C+2JPSqobLkz
	EL6msC+6vtKG1sarEevBM/MFeofyaPM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable 3/5] mm: zpool: Remove object mapping APIs
Message-ID: <Z8nTa1yut6I0RS0a@google.com>
References: <20250305061134.4105762-1-yosry.ahmed@linux.dev>
 <20250305061134.4105762-4-yosry.ahmed@linux.dev>
 <Z8j_Ct0hTwAnd2-w@gondor.apana.org.au>
 <Z8kiRym1hS9fB2mE@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8kiRym1hS9fB2mE@gondor.apana.org.au>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 06, 2025 at 12:19:19PM +0800, Herbert Xu wrote:
> On Thu, Mar 06, 2025 at 09:48:58AM +0800, Herbert Xu wrote:
> >
> > This patch breaks zbud and z3fold because they haven't been converted
> > to the new interface.
> 
> I've rebased my zswap SG patch on top of your series.  I've removed
> all the mapping code from zpool/zsmalloc and pushed it out to zram
> instead.
> 
> This patch depends on a new memcpy_sglist function which I've just
> posted a patch for:
> 
> https://patchwork.kernel.org/project/linux-crypto/patch/Z8kXhLb681E_FLzs@gondor.apana.org.au/
> 
> From a77ee529b831e7e606ed2a5b723b74ce234a3915 Mon Sep 17 00:00:00 2001
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Date: Thu, 6 Mar 2025 12:13:58 +0800
> Subject: [PATCH] mm: zswap: Give non-linear objects to Crypto API
> 
> Instead of copying non-linear objects into a buffer, use the
> scatterlist to give them directly to the Crypto API.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

The zswap and zsmalloc look good and the code is simpler. I am fine with
this approach if Sergey is fine with it, although I wonder if we should
update Sergey's patches in mm-unstable do this directly. Currently we
are switching from mapping APIs to read/write APIs, and then quickly to
the pinning APIs. The history will be confusing.

Sergey, do you prefer if we keep things as-is, or if you update your
series to incorporate Herbert's changes for zsmalloc/zram, then I can
update my series to incorporate the changes in zswap?

We can also combine the series into a single updated one with
zsmalloc/zram/zswap changes.

Let me know what you prefer.

