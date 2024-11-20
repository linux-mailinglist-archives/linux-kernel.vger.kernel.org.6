Return-Path: <linux-kernel+bounces-415904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 523169D3DF3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68FC7B24758
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF411AA1E6;
	Wed, 20 Nov 2024 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LpiCDHfV"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D697191
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732113974; cv=none; b=kM3uXnq/tiro1mwsGG4LbhF6qbkg3cZ+pI0jl5YT28czz4L6yBsq2b+pL9wZ6sct1e864B78XRTTsndEDD3ZPESkhe36YsdbaOf0vuoT/c51auaRud8LUa49dMofvv7kWGqp7jQ/hWtaSVLkT1ybzFRn1wHxxB64LN5kly1aDNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732113974; c=relaxed/simple;
	bh=I9KZ/PB/HClPmdFVa2NrtE7Tx0fwtHnfdsiZH1IJEA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkxrVw0eKWw+IpyGMvG2KUGKPB2/qEE+SZFTkR7A8v9IvBkWF70IMNbtgzkeA7nJkBLxW2dtvb1rE9+GjBBakycIhqe3XTHvLfm6X9s9ZNvWWArcFdFcsk04wIpOHWpq2qOu6Xf+a2oiVsECw0gccHYcs5Rvpob78UN9PQ2vp+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LpiCDHfV; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iAL6CvyKrJV00e4de2oVseBxuM25oZkzucHJ65fPFUQ=; b=LpiCDHfVZxpdIOQqm5xkaMhYrU
	qPVi7Y83Uz2UBgeXBO2C4iJu8p8z4p1aWQiVDvhFlxLM3TDLwJqukj6C/G0aSMsrCuoXJR3HH6Q24
	2ANWcoWtxeTMlYQPU3rodu6NvATmyp3T4PgbLnkQxqtqAa7TJSLITvHP/Or+qGznWyDMtq0bo5KEi
	D8sXECQxa9ZtJSf4RgqqNdWAZet7KrafvqsTmc1hMdMg2thZeOOw06SXLitsa+/f/slov/6uwQVHm
	a/ksWZbGFOPSEkpbWWDmmg8SCtH55I4camGk8VeRLqC9+6D+gmhyylh77D3yDUSr0/b5fjXdtUbmC
	8Saxl9RQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDly1-00000000Tnd-1Bts;
	Wed, 20 Nov 2024 14:46:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 041983006AB; Wed, 20 Nov 2024 15:46:04 +0100 (CET)
Date: Wed, 20 Nov 2024 15:46:03 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: mingo@kernel.org, lucas.demarchi@intel.com,
	linux-kernel@vger.kernel.org, willy@infradead.org, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Subject: Re: [PATCH 06/19] perf: Simplify perf_pmu_register()
Message-ID: <20241120144603.GG19989@noisy.programming.kicks-ass.net>
References: <20241104133909.669111662@infradead.org>
 <20241104135518.198937277@infradead.org>
 <d64ebfba-49db-4b04-9a84-b9ecd26e6c76@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d64ebfba-49db-4b04-9a84-b9ecd26e6c76@amd.com>

On Wed, Nov 20, 2024 at 06:36:55PM +0530, Ravi Bangoria wrote:
> Hi Peter,
> 
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -11778,52 +11778,49 @@ static void perf_pmu_free(struct pmu *pm
> >  	free_percpu(pmu->cpu_pmu_context);
> >  }
> >  
> > -int perf_pmu_register(struct pmu *pmu, const char *name, int type)
> > +DEFINE_FREE(pmu_unregister, struct pmu *, if (_T) perf_pmu_free(_T))
> > +
> > +int perf_pmu_register(struct pmu *_pmu, const char *name, int type)
> >  {
> > -	int cpu, ret, max = PERF_TYPE_MAX;
> > +	int cpu, max = PERF_TYPE_MAX;
> >  
> > -	pmu->type = -1;
> > +	struct pmu *pmu __free(pmu_unregister) = _pmu;
> > +	guard(mutex)(&pmus_lock);
> >  
> > -	mutex_lock(&pmus_lock);
> > -	ret = -ENOMEM;
> >  	pmu->pmu_disable_count = alloc_percpu(int);
> >  	if (!pmu->pmu_disable_count)
> > -		goto unlock;
> > +		return -ENOMEM;
> >  
> > -	if (WARN_ONCE(!name, "Can not register anonymous pmu.\n")) {
> > -		ret = -EINVAL;
> > -		goto free;
> > -	}
> > +	if (WARN_ONCE(!name, "Can not register anonymous pmu.\n"))
> > +		return -EINVAL;
> >  
> > -	if (WARN_ONCE(pmu->scope >= PERF_PMU_MAX_SCOPE, "Can not register a pmu with an invalid scope.\n")) {
> > -		ret = -EINVAL;
> > -		goto free;
> > -	}
> > +	if (WARN_ONCE(pmu->scope >= PERF_PMU_MAX_SCOPE,
> > +		      "Can not register a pmu with an invalid scope.\n"))
> > +		return -EINVAL;
> >  
> >  	pmu->name = name;
> >  
> >  	if (type >= 0)
> >  		max = type;
> >  
> > -	ret = idr_alloc(&pmu_idr, NULL, max, 0, GFP_KERNEL);
> > -	if (ret < 0)
> > -		goto free;
> > +	CLASS(idr_alloc, pmu_type)(&pmu_idr, NULL, max, 0, GFP_KERNEL);
> > +	if (pmu_type.id < 0)
> > +		return pmu_type.id;
> >  
> > -	WARN_ON(type >= 0 && ret != type);
> > +	WARN_ON(type >= 0 && pmu_type.id != type);
> >  
> > -	pmu->type = ret;
> > +	pmu->type = pmu_type.id;
> >  	atomic_set(&pmu->exclusive_cnt, 0);
> >  
> >  	if (pmu_bus_running && !pmu->dev) {
> > -		ret = pmu_dev_alloc(pmu);
> > +		int ret = pmu_dev_alloc(pmu);
> >  		if (ret)
> > -			goto free;
> > +			return ret;
> 
> pmu_dev_alloc() can fail before or in device_add(). perf_pmu_free() should
> not call device_del() for such cases. No?

Right you are -- but is this not introduced in the previous patch?

Also, this should cure things, no?

---
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11810,6 +11810,7 @@ static int pmu_dev_alloc(struct pmu *pmu
 
 free_dev:
 	put_device(pmu->dev);
+	pmu->dev = NULL;
 	goto out;
 }
 

