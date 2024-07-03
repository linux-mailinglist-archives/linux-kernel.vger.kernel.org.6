Return-Path: <linux-kernel+bounces-239793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB36A926560
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87BAA28375F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4195918132E;
	Wed,  3 Jul 2024 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NsIDCdv6"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A1179E1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720022330; cv=none; b=k5eqVtrSwlI92zgx3cAVWtg1rA0dr0ZQ/sxodj8HpkJ7nTiu4kG/22euI2QAVab0ac/mclkQQx+Oh1QW8+jcUPMvs89mfgTn8fRCsuU7O7zC+mHcrqBhogFWSFsOECDWiszxNr9PoVZ77tWFO9/Q2cQP9Zo/Gls3+Xl/KnbIbuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720022330; c=relaxed/simple;
	bh=5JRPgysfabq+bO5Avj1lkdsGmnq/d+cFT7Ou4T4oFTs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zwb0ZgkkRDnEeKM49eV1L6QQlzXDpySbdI3+1vm7vaOwuMTJyebS+RW+Cokxbyqqv6vGLpyMzkCbi1ZUHt2a29HBsTdF4TdzhmgNFb6TBhFK1Zx1J8nuU4cv0YHhG39NS7pWxNMxxopHLiw+NwlZOEFPrtBGIhhjVrGzwEC+w4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NsIDCdv6; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720022327;
	bh=5JRPgysfabq+bO5Avj1lkdsGmnq/d+cFT7Ou4T4oFTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NsIDCdv6y1vFaehheLrd6HmDeUq/2CVHjwGG+SzVr1as+ZcUgkRnGZlMkjiIoeyCv
	 zfxRpmLYb6rYJ8xzsXT9SRPDia8ryZkmWIP9u71Q5/BfJni7vcVr826EDE45KlpV2C
	 ArfooN61Xz9g92w4ZOGDqN+leAf1jhS8W56k0NtY8qQPW7wjq37ClL5e3b6VhnViKY
	 GJZ9Xhm11EPJ9tqpBGYKtfcqbo77wTu/KE58aYMUS651H4zvkeHhadxbr1bhNJDapV
	 JLyhb0oB5xpqU6aZdOHw8yj3xI6658rCTUvMAt66KVdkR5YSBdSbCBxxqz9yRqzwHi
	 ofqeRkGwZxGig==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C84B53782039;
	Wed,  3 Jul 2024 15:58:46 +0000 (UTC)
Date: Wed, 3 Jul 2024 17:58:45 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?QWRyacOhbg==?= Larumbe
 <adrian.larumbe@collabora.com>
Subject: Re: [PATCH] drm/panthor: Record devfreq busy as soon as a job is
 started
Message-ID: <20240703175845.2268b890@collabora.com>
In-Reply-To: <20240703155646.80928-1-steven.price@arm.com>
References: <20240703155646.80928-1-steven.price@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Jul 2024 16:56:46 +0100
Steven Price <steven.price@arm.com> wrote:

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

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

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


