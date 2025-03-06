Return-Path: <linux-kernel+bounces-549765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D095A5570D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64FD16A1E3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FFA26BD9F;
	Thu,  6 Mar 2025 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jN4WEpW6"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D001A5BA8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 19:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741290392; cv=none; b=ZhtgtKYZwH9h6k1p0GU9zm7wEH3tES9Y02d9gT3EfaxmbbsjUqtraDS6q/nXXeuuD2S+IlB8WiQZth/Mi14uK35QBywW1qO4hmqQeN/XTFj8tAJceKePdsvzh+y1ucIIDjbc+fhxhOiHH/uXdtwSZslOtlfT7Cx+DGc/bOEB3JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741290392; c=relaxed/simple;
	bh=d7KlZetNgavwgQSM0Z1yPmLM8orAxUkWhHo4UiOa8j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SImVPpaAIbxsDIadGlCx0jhY/VnDFhnBzk8ixZK6t+NQV9Z6Xq2duw6wRbck+EPOIjRGcaKABMv334vxH8kcI6vknoffAxDaB/giUTJhMzDOs2d6YHlWu0BN6oR+ARliQ14EjMssfaut4SULe8Qubw4B2HXs/cLaQDqGSa9XMog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jN4WEpW6; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 6 Mar 2025 19:46:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741290377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cPfH0at9b2Of8Fho2dIZEk48ulRtn7SnhprVF28eu+c=;
	b=jN4WEpW6DVv9F9al+waDzh6R4ZZn8+7pjJcValcBi2Ck0+8MA2GEIChy71yw2+NBngIfJh
	ni4fizmxwThEXcF8Z7XU/Xu2A1PEWF1RHjfMmnAGMQU9lJey5ZEOyiYy1LQWx1hC4Nzp8G
	lnRdE142z5pmwE+S9UDoqPjI4nx1g+Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org,
	nphamcs@gmail.com, chengming.zhou@linux.dev, usamaarif642@gmail.com,
	ryan.roberts@arm.com, 21cnbao@gmail.com,
	ying.huang@linux.alibaba.com, akpm@linux-foundation.org,
	linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
	davem@davemloft.net, clabbe@baylibre.com, ardb@kernel.org,
	ebiggers@google.com, surenb@google.com, kristen.c.accardi@intel.com,
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Subject: Re: [PATCH v8 12/14] mm: zswap: Simplify acomp_ctx resource
 allocation/deletion and mutex lock usage.
Message-ID: <Z8n7gjggkyf9qLMy@google.com>
References: <20250303084724.6490-1-kanchana.p.sridhar@intel.com>
 <20250303084724.6490-13-kanchana.p.sridhar@intel.com>
 <Z8n5CCmELvpUwi3B@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8n5CCmELvpUwi3B@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 06, 2025 at 07:35:36PM +0000, Yosry Ahmed wrote:
> On Mon, Mar 03, 2025 at 12:47:22AM -0800, Kanchana P Sridhar wrote:
> > This patch modifies the acomp_ctx resources' lifetime to be from pool
> > creation to deletion. A "bool __online" and "u8 nr_reqs" are added to
> > "struct crypto_acomp_ctx" which simplify a few things:
> > 
> > 1) zswap_pool_create() will initialize all members of each percpu acomp_ctx
> >    to 0 or NULL and only then initialize the mutex.
> > 2) CPU hotplug will set nr_reqs to 1, allocate resources and set __online
> >    to true, without locking the mutex.
> > 3) CPU hotunplug will lock the mutex before setting __online to false. It
> >    will not delete any resources.
> > 4) acomp_ctx_get_cpu_lock() will lock the mutex, then check if __online
> >    is true, and if so, return the mutex for use in zswap compress and
> >    decompress ops.
> > 5) CPU onlining after offlining will simply check if either __online or
> >    nr_reqs are non-0, and return 0 if so, without re-allocating the
> >    resources.
> > 6) zswap_pool_destroy() will call a newly added zswap_cpu_comp_dealloc() to
> >    delete the acomp_ctx resources.
> > 7) Common resource deletion code in case of zswap_cpu_comp_prepare()
> >    errors, and for use in zswap_cpu_comp_dealloc(), is factored into a new
> >    acomp_ctx_dealloc().
> > 
> > The CPU hot[un]plug callback functions are moved to "pool functions"
> > accordingly.
> > 
> > The per-cpu memory cost of not deleting the acomp_ctx resources upon CPU
> > offlining, and only deleting them when the pool is destroyed, is as follows:
> > 
> >     IAA with batching: 64.8 KB
> >     Software compressors: 8.2 KB
> > 
> > I would appreciate code review comments on whether this memory cost is
> > acceptable, for the latency improvement that it provides due to a faster
> > reclaim restart after a CPU hotunplug-hotplug sequence - all that the
> > hotplug code needs to do is to check if acomp_ctx->nr_reqs is non-0, and
> > if so, set __online to true and return, and reclaim can proceed.
> 
> I like the idea of allocating the resources on memory hotplug but
> leaving them allocated until the pool is torn down. It avoids allocating
> unnecessary memory if some CPUs are never onlined, but it simplifies
> things because we don't have to synchronize against the resources being
> freed in CPU offline.
> 
> The only case that would suffer from this AFAICT is if someone onlines
> many CPUs, uses them once, and then offline them and not use them again.
> I am not familiar with CPU hotplug use cases so I can't tell if that's
> something people do, but I am inclined to agree with this
> simplification.
> 
> > 
> > Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> > ---
> >  mm/zswap.c | 273 +++++++++++++++++++++++++++++++++++------------------
> >  1 file changed, 182 insertions(+), 91 deletions(-)
> > 
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 10f2a16e7586..cff96df1df8b 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -144,10 +144,12 @@ bool zswap_never_enabled(void)
> >  struct crypto_acomp_ctx {
> >  	struct crypto_acomp *acomp;
> >  	struct acomp_req *req;
> > -	struct crypto_wait wait;
> 
> Is there a reason for moving this? If not please avoid unrelated changes.
> 
> >  	u8 *buffer;
> > +	u8 nr_reqs;
> > +	struct crypto_wait wait;
> >  	struct mutex mutex;
> >  	bool is_sleepable;
> > +	bool __online;
> 
> I don't believe we need this.
> 
> If we are not freeing resources during CPU offlining, then we do not
> need a CPU offline callback and acomp_ctx->__online serves no purpose.
> 
> The whole point of synchronizing between offlining and
> compress/decompress operations is to avoid UAF. If offlining does not
> free resources, then we can hold the mutex directly in the
> compress/decompress path and drop the hotunplug callback completely.
> 
> I also believe nr_reqs can be dropped from this patch, as it seems like
> it's only used know when to set __online.
> 
> >  };
> >  
> >  /*
> > @@ -246,6 +248,122 @@ static inline struct xarray *swap_zswap_tree(swp_entry_t swp)
> >  **********************************/
> >  static void __zswap_pool_empty(struct percpu_ref *ref);
> >  
> > +static void acomp_ctx_dealloc(struct crypto_acomp_ctx *acomp_ctx)
> > +{
> > +	if (!IS_ERR_OR_NULL(acomp_ctx) && acomp_ctx->nr_reqs) {

Also, we can just return early here to save an indentation level:

	if (IS_ERR_OR_NULL(acomp_ctx) || !acomp_ctx->nr_reqs)
		return;

> > +
> > +		if (!IS_ERR_OR_NULL(acomp_ctx->req))
> > +			acomp_request_free(acomp_ctx->req);
> > +		acomp_ctx->req = NULL;
> > +
> > +		kfree(acomp_ctx->buffer);
> > +		acomp_ctx->buffer = NULL;
> > +
> > +		if (!IS_ERR_OR_NULL(acomp_ctx->acomp))
> > +			crypto_free_acomp(acomp_ctx->acomp);
> > +
> > +		acomp_ctx->nr_reqs = 0;
> > +	}
> > +}
> 
> Please split the pure refactoring into a separate patch to make it
> easier to review.

