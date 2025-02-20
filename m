Return-Path: <linux-kernel+bounces-523792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D21A3DB4E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB6A3B671E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A061FA166;
	Thu, 20 Feb 2025 13:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="bAq+d8G1"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB661F4735
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740058167; cv=none; b=fSDRH2wq4YFaZ6nJwkVvMrboyynSF1TRVgIgnMMFeX+A/zV83VaBhE38HjnPlSn5KUj7sY/M4AUNjWa9pT/KM/VL2IBmBd9AcuaAaXOV/0ADJ8u6aTbocY8uhmHkXEYoSXbzRHZBjyaDOGXozNoqOCX9K/Wtc3Gl7ENCaD6yYjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740058167; c=relaxed/simple;
	bh=J6bsjyQeLdHnJRTVBkMItR55t8OW6cPAjipTajeS9AM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctf1ZfDvJ6WkCaTzvxnBfujfm1061sD4CnONnKSaq0SOIfY3cNyN2ZGWB6zYdFlqWLvVZY1N92SOHZbkMxOgft0WUsHbcSTML0LKO15kASZsuNLZc6o9J33gvtAZnAoyfJzdVARNOQOY7897Tzz5/MiWuTAzx2AzZmm0mOAzciw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=bAq+d8G1; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HmLr8tjvLi4nFvUpNKJ/HEAdoe6aExUh0s+6Zn1EAaU=; b=bAq+d8G1AiMmStyjr3krH99GoU
	tdbcpZH9oz5A5wSWVXfFV3c8YSwBiGFkw9SsKd2q0lyDvFLFGun32AKGNzZBHyqDiDLUmjcbpV8xI
	L31kv8SERLPvmGY7f/80LngTYqkB4asu/v0ieGqfLVVcV3flhEsLhY1QfV2DffR3AxVv0JXJbBL7/
	JOpdaofsdR9jMvpG3XCJOXSIU7Vm6UED8G/IJDg0PuPWeTjTDaGdu+2jAnY3k4ct23YE//GKKsG8+
	rRawGp7RZ8Hf4ZJJOf6ArGZY+W+SG5UbV87p4O22aNP+Sqoe0EkAKpsZXhmZ0sAdX93+BZ7prBtxQ
	Wq+F1xoQ==;
Received: from [187.36.213.55] (helo=[192.168.1.103])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tl6bm-00FMoB-GE; Thu, 20 Feb 2025 14:29:00 +0100
Message-ID: <12c53d41-21c4-443d-a572-fd22c3cc56ad@igalia.com>
Date: Thu, 20 Feb 2025 10:28:53 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] drm/sched: Adjust outdated docu for run_job()
To: Philipp Stanner <phasta@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250220112813.87992-2-phasta@kernel.org>
 <20250220112813.87992-4-phasta@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20250220112813.87992-4-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Philipp,

On 20/02/25 08:28, Philipp Stanner wrote:
> The documentation for drm_sched_backend_ops.run_job() mentions a certain
> function called drm_sched_job_recovery(). This function does not exist.
> What's actually meant is drm_sched_resubmit_jobs(), which is by now also
> deprecated.
> 
> Remove the mention of the removed function.
> 
> Discourage the behavior of drm_sched_backend_ops.run_job() being called
> multiple times for the same job.

It looks odd to me that this patch removes lines that were added in
patch 1/3. Maybe you could change the patchset order and place this one
as the first.

> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>   include/drm/gpu_scheduler.h | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 916279b5aa00..29e5bda91806 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -421,20 +421,27 @@ struct drm_sched_backend_ops {
>   
>   	/**
>   	 * @run_job: Called to execute the job once all of the dependencies
> -	 * have been resolved. This may be called multiple times, if
> -	 * timedout_job() has happened and drm_sched_job_recovery() decides to
> -	 * try it again.
> +	 * have been resolved.
> +	 *
> +	 * The deprecated drm_sched_resubmit_jobs() (called from
> +	 * drm_sched_backend_ops.timedout_job()) can invoke this again with the

I think it would be "@timedout_job".

> +	 * same parameters. Using this is discouraged because it, presumably,
> +	 * violates dma_fence rules.

I believe it would be "struct dma_fence".

> +	 *
> +	 * TODO: Document which fence rules above.
>   	 *
>   	 * @sched_job: the job to run
>   	 *
> -	 * Returns: dma_fence the driver must signal once the hardware has
> -	 *	completed the job ("hardware fence").
> -	 *
>   	 * Note that the scheduler expects to 'inherit' its own reference to
>   	 * this fence from the callback. It does not invoke an extra
>   	 * dma_fence_get() on it. Consequently, this callback must take a
>   	 * reference for the scheduler, and additional ones for the driver's
>   	 * respective needs.

Would it be possible to add a comment that `run_job()` must check if
`s_fence->finished.error` is different than 0? If you increase the karma
of a job and don't check for `s_fence->finished.error`, you might run a
cancelled job.

> +	 *
> +	 * Return:
> +	 * * On success: dma_fence the driver must signal once the hardware has
> +	 * completed the job ("hardware fence").

A suggestion: "the fence that the driver must signal once the hardware
has completed the job".

Best Regards,
- Maíra

> +	 * * On failure: NULL or an ERR_PTR.
>   	 */
>   	struct dma_fence *(*run_job)(struct drm_sched_job *sched_job);
>   


