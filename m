Return-Path: <linux-kernel+bounces-551741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63259A57029
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59B1189885B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44145241667;
	Fri,  7 Mar 2025 18:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Fji5kqzS"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCF223E229
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 18:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741371019; cv=none; b=WK6PUG5Hfvwzc/pHFIYVAgft9rJVn+0NVaraIC5u58tQ8OLJfPN2xqCVzyo2C+qdWcDOTVUG3NTfuM7Lcz46rDZfKqHuDXyx0JlG6ACpFQ0+3SkIcX4h80J4lgku1M/aFlKziRyNLTJUpXTrGI1yMof6QOzuQGouuMLPmfAcPdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741371019; c=relaxed/simple;
	bh=nj7VbPnX+Wt507UK82xLbOMazsEbXI7or4ZHBYv0ahw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fcB8Yqd0yTshNDKyKPBfCvWVArIRXiVL5ZW154aGofYCtDfur3rg4BbUyzd3v6NcmYwaTPRnmxZexxI8IpRYqhrH9EUweJ/F8IIjdZ1RG2CSEBqsa3xg0WYPFKS+zyc901ANEx6k444ehMl9SKE1BftShSXuBJl6rbP72+TGAyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Fji5kqzS; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4hMBSR6a742363nCujmsUyxpy/ct/roqWkQT1nfgQbc=; b=Fji5kqzSnmSbBnKJJTQzYEgzh9
	RB0f4J7Qvv204sKyCH9QdaYc6glzjc06PGQBPzZ90tdxazgiH8XkwbBj7ghIUketh67S8p425NQV0
	uLDhbgUB3mSuDwZL++Bu3Vnm29IqbAYy27GmYOTM8MWYn2S6B04WIhXW1VT21Q0tnQwGGhnEvGhiJ
	DXSh+tSQU68qsQAqw5m9TYj9gOPKKXqX8ho3nRtGKq/rpsPyOAMw6psrLGg+FJAPkI6ejracrpTzb
	iQdS2YYYZvFbGads5NeVQBuZ8dAfc9IbtWYvJv6xqWFFXE9uz7HVWw+6HzY//V0B21c0W+399atZK
	n2rrOLcw==;
Received: from [189.7.87.170] (helo=[192.168.0.224])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tqc8t-005TCi-No; Fri, 07 Mar 2025 19:09:57 +0100
Message-ID: <7502a793-4e92-4bfc-9c87-66bd7fdd88ce@igalia.com>
Date: Fri, 7 Mar 2025 15:09:50 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] drm/sched: Adjust outdated docu for run_job()
To: Philipp Stanner <phasta@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250305130551.136682-2-phasta@kernel.org>
 <20250305130551.136682-3-phasta@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20250305130551.136682-3-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Philipp,

On 05/03/25 10:05, Philipp Stanner wrote:
> The documentation for drm_sched_backend_ops.run_job() mentions a certain
> function called drm_sched_job_recovery(). This function does not exist.
> What's actually meant is drm_sched_resubmit_jobs(), which is by now also
> deprecated.
> 
> Furthermore, the scheduler expects to "inherit" a reference on the fence
> from the run_job() callback. This, so far, is also not documented.
> 
> Remove the mention of the removed function.
> 
> Discourage the behavior of drm_sched_backend_ops.run_job() being called
> multiple times for the same job.
> 
> Document the necessity of incrementing the refcount in run_job().
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>   include/drm/gpu_scheduler.h | 34 ++++++++++++++++++++++++++++++----
>   1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 50928a7ae98e..6381baae8024 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -410,10 +410,36 @@ struct drm_sched_backend_ops {
>   					 struct drm_sched_entity *s_entity);
>   
>   	/**
> -         * @run_job: Called to execute the job once all of the dependencies
> -         * have been resolved.  This may be called multiple times, if
> -	 * timedout_job() has happened and drm_sched_job_recovery()
> -	 * decides to try it again.
> +	 * @run_job: Called to execute the job once all of the dependencies
> +	 * have been resolved.
> +	 *
> +	 * @sched_job: the job to run
> +	 *
> +	 * The deprecated drm_sched_resubmit_jobs() (called by &struct
> +	 * drm_sched_backend_ops.timedout_job) can invoke this again with the
> +	 * same parameters. Using this is discouraged because it violates
> +	 * dma_fence rules, notably dma_fence_init() has to be called on
> +	 * already initialized fences for a second time. Moreover, this is
> +	 * dangerous because attempts to allocate memory might deadlock with
> +	 * memory management code waiting for the reset to complete.

Thanks for adding this paragraph! Also, thanks Christian for providing
this explanation in v5. It really helped clarify the reasoning behind
deprecating drm_sched_resubmit_jobs().

Best Regards,
- Maíra

> +	 *
> +	 * TODO: Document what drivers should do / use instead.
> +	 *
> +	 * This method is called in a workqueue context - either from the
> +	 * submit_wq the driver passed through drm_sched_init(), or, if the
> +	 * driver passed NULL, a separate, ordered workqueue the scheduler
> +	 * allocated.
> +	 *
> +	 * Note that the scheduler expects to 'inherit' its own reference to
> +	 * this fence from the callback. It does not invoke an extra
> +	 * dma_fence_get() on it. Consequently, this callback must take a
> +	 * reference for the scheduler, and additional ones for the driver's
> +	 * respective needs.
> +	 *
> +	 * Return:
> +	 * * On success: dma_fence the driver must signal once the hardware has
> +	 * completed the job ("hardware fence").
> +	 * * On failure: NULL or an ERR_PTR.
>   	 */
>   	struct dma_fence *(*run_job)(struct drm_sched_job *sched_job);
>   


