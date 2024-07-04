Return-Path: <linux-kernel+bounces-240730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116E89271D4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C663F284BA4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9F31A3BD5;
	Thu,  4 Jul 2024 08:35:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0304431
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720082128; cv=none; b=Lrmd++6BAwKPu+AOSKtj1pMPqFAXVWg1WJ6dbJBZ7BOfdnq9ZZ8NroQwPvljfS1feqL7NDcmX5jTu2p5TkPnpuFs2YUQmFxHxjACqDr9neJirWeISpfHUObYc4YM+PkbbfxXu+27rfAtgg5MbsdCAvJWyNT2ZOaAeFhEZIzOQNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720082128; c=relaxed/simple;
	bh=IgZFKoNHGHwPrTwQiBpPaPlJmFgB3AioeqMRFw11oHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nkmTWDPvXczC4BittLMTIsuwwfCs8pXaocD6d1KSCKTJ9BW/FhHrm8G3V0nZ4hcO8APN2qEU1mkZnihoVfNT/Q6cuPxv4Ru3RoHu95JyCKUjWQj6wPCWm7e+YNdc8pmijNP1Je+aKOR2lR/3tpMc6LjcXecVeGD8OWKw/wFT/Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5568367;
	Thu,  4 Jul 2024 01:35:49 -0700 (PDT)
Received: from [10.1.36.26] (e122027.cambridge.arm.com [10.1.36.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FD5B3F766;
	Thu,  4 Jul 2024 01:35:23 -0700 (PDT)
Message-ID: <957a0c8e-f80b-4f6f-ac6f-70398abafd6f@arm.com>
Date: Thu, 4 Jul 2024 09:35:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: Record devfreq busy as soon as a job is
 started
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
References: <20240703155646.80928-1-steven.price@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20240703155646.80928-1-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/07/2024 16:56, Steven Price wrote:
> If a queue is already assigned to the hardware, then a newly submitted
> job can start straight away without waiting for the tick. However in
> this case the devfreq infrastructure isn't notified that the GPU is
> busy. By the time the tick happens the job might well have finished and
> no time will be accounted for the GPU being busy.
> 
> Fix this by recording the GPU as busy directly in queue_run_job() in the
> case where there is a CSG assigned and therefore we just ring the
> doorbell.
> 
> Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 951ff7e63ea8..e7afaa1ad8dc 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -2942,6 +2942,7 @@ queue_run_job(struct drm_sched_job *sched_job)
>  			pm_runtime_get(ptdev->base.dev);
>  			sched->pm.has_ref = true;
>  		}
> +		panthor_devfreq_record_busy(sched->ptdev);
>  	}
>  
>  	/* Update the last fence. */

Pushed to drm-misc-next

Thanks,
Steve

