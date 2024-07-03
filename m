Return-Path: <linux-kernel+bounces-239824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0599265D0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDC2DB22811
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D003181CF9;
	Wed,  3 Jul 2024 16:14:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EEB442C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023292; cv=none; b=AAHEZG3NYo5ApNuhfqN6SIuPvY0tUOYgTL6X4KZcFyERXX+sJub7EE76s1rwgxyVUQCruF2uxMP+/i/gWXuURoFceTh5cpiZpqZ0yNp5yh/O/efbGe6wFR6797/CPIHP2x/KG2YIywMT1//LulWJh/Urj56MzIPBg5KCYc1JWQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023292; c=relaxed/simple;
	bh=FvLLVaWSE/3Waw29kXFeMeKmkQns+0BkGpJhRraPJw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knslzCb6AckaLIKlRAEcisQHtSpUg0J3zXkat3UOPWZX7YKpXMWmvTS8dDxm2CBd7JghBUUcDOFI5Zy2A9sj6AtP4wcTZssgY8EF4asNim1KV7HAylOamtau5fXLxpHmwdGPCoB7fybnqihGb5fSWRLDupbGZbT8kL+P9eeLobY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E378367
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 09:15:14 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 368653F766
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 09:14:49 -0700 (PDT)
Date: Wed, 3 Jul 2024 17:14:41 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Steven Price <steven.price@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	=?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
Subject: Re: [PATCH] drm/panthor: Record devfreq busy as soon as a job is
 started
Message-ID: <ZoV48WcKj1hz80sd@e110455-lin.cambridge.arm.com>
References: <20240703155646.80928-1-steven.price@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240703155646.80928-1-steven.price@arm.com>

On Wed, Jul 03, 2024 at 04:56:46PM +0100, Steven Price wrote:
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

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

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
> -- 
> 2.39.2
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

