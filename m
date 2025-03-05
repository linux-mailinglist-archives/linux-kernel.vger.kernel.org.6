Return-Path: <linux-kernel+bounces-547537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2608A50A8F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951BC171C4E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ED21A5BB7;
	Wed,  5 Mar 2025 18:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BA7f1aSp"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C932512ED
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741201081; cv=none; b=cpIRWJavOlK1SvmuMJ1EMnGxMbGEbgz/7PP9pEP7ZoeAFWcl34i6/dXFU32nlTRZrMGKuvi0Jhk5lCRI8Wd2Vx1TItP02CWMKj2wkhM2QpLfrdwM/6AeXvrrp9Y9h3ZT3p+C+ot6YUazM8ngFSxcnF/R+BgPXvz9AawYIfUarQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741201081; c=relaxed/simple;
	bh=D0ez5L+mh+d3N1St9Y0FuzIQgaBbXSpDE1DjTHDTB0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G54c2vOMrta6yjdoi5oX3zgmj3EtNnLqh9So6LPh2KFqw3wXZQe8+jc8Q71706KON3bZlJX8VTnSMD+GuGyfOsnFPkm9RYp0r8SmQMW3MFOI3ziJp+6x3ALP15iFQFtGYFvu4iBEm2hoLZYJGyHOoedU7pgIWAmgAy9vzGWwiW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BA7f1aSp; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 5 Mar 2025 18:57:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741201076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F/pxQm/GTBuWXpkm2E2xQcWdXz+nSd25BI4v2m4VQII=;
	b=BA7f1aSpTqg4jihYzqWbOuaiN1vbMeL48KwQWXuCr26ejsbyzTYLvQ5r5aK2xqWVXlNur8
	cM99aKZuBVUNL8WUOBfMoDgbUSc/MFgvxsUoFmnFYeyydtSSwJxFfXKV1QppPCzAYF5R3c
	793wFHEsYCw2ioZMzk41wnVvEtFM0ys=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable 4/5] mm: zsmalloc: Remove object mapping APIs
 and per-CPU map areas
Message-ID: <Z8ier-ZZp8T6MOTH@google.com>
References: <20250305061134.4105762-1-yosry.ahmed@linux.dev>
 <20250305061134.4105762-5-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305061134.4105762-5-yosry.ahmed@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 05, 2025 at 06:11:32AM +0000, Yosry Ahmed wrote:
> zs_map_object() and zs_unmap_object() are no longer used, remove them.
> Since these are the only users of per-CPU mapping_areas, remove them and
> the associated CPU hotplug callbacks too.
> 
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> ---
>  include/linux/cpuhotplug.h |   1 -
>  include/linux/zsmalloc.h   |  21 ----
>  mm/zsmalloc.c              | 226 +------------------------------------
>  3 files changed, 1 insertion(+), 247 deletions(-)

I missed updating the docs. Andrew, could you please squash the
following diff in? I intentionally did not state the name of the new
APIs to avoid needing to update the docs with similar changes in the
future:

diff --git a/Documentation/mm/zsmalloc.rst b/Documentation/mm/zsmalloc.rst
index 76902835e68e9..d2bbecd78e146 100644
--- a/Documentation/mm/zsmalloc.rst
+++ b/Documentation/mm/zsmalloc.rst
@@ -27,9 +27,8 @@ Instead, it returns an opaque handle (unsigned long) which encodes actual
 location of the allocated object. The reason for this indirection is that
 zsmalloc does not keep zspages permanently mapped since that would cause
 issues on 32-bit systems where the VA region for kernel space mappings
-is very small. So, before using the allocating memory, the object has to
-be mapped using zs_map_object() to get a usable pointer and subsequently
-unmapped using zs_unmap_object().
+is very small. So, using the allocated memory should be done through the
+proper handle-based APIs.

 stat
 ====

