Return-Path: <linux-kernel+bounces-547188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3458BA503FB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D0F77A3C74
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36CD2505C4;
	Wed,  5 Mar 2025 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEzTjKoL"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7495218FC90
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190250; cv=none; b=rknR0j9785UQLseOnfTQUCMiFf1uqK85HIqeTNoQEZYTzwskRgzwuYakLskdcJt/IUsHZNND1Vv9/d5VvGfUDc3n0GWGjQhfqFhUTf8g0sXPHbVFJMqqVaXeGSMdaYT1aQpZiQcSlRK8EPOibt4KoLipri40/7X/JPkO9Z/GQ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190250; c=relaxed/simple;
	bh=rm0St075dWDOE0wO9ICObW1pv94kcsYVDUSel8Aq/W8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pF7oseuPNz+e2nTP5AnPGMv5tvNcyQ23kLSIX2cJpZBuQMl4EgfaXnKhitsJzm2vvDcdYmg2kcP+drBlEy8i6P4BxXqob1SomtOKYWObLGVQVn9ewnJm+SL4eqKokTS4BNlip3WrFt7886cnTsvZRaWAg1atlrIgde8wHZjnEO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEzTjKoL; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38dcac27bcbso703249f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 07:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741190246; x=1741795046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XI41wk7TJF7vmtgJL7omJXUR4bG71r2Wzk7v83CVjD0=;
        b=DEzTjKoL9kyI6yvpo9oayVrnEc/SU7GsMsHNtGCXWp6hYBNl4cuuEXTopyeFtdKIez
         ARbqBLAWQdpLKJ7jhM7EQfI00ZuwHobRKsux66nmVJd/TooZRJ9mJt07rvRrrrMQD9r5
         yKJYHQ/stOwajgfntidtG8fK1Xl2qyBNj5rykg8dCVyI4yN1VHHxsKPaMEgepmJKmYG1
         MVruv+IKdEcRr0dukFE96s019pn2BmEJvOx7msBfscok9DHsZ4ov9G2YyvlubsOOlcsr
         Zr6+SFNbrFQhItuVr9JYNXUn90e6f1h+eRwryQH37lgJWEIoJhOhYqNpJ8Qwfgmqllrr
         NnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741190246; x=1741795046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XI41wk7TJF7vmtgJL7omJXUR4bG71r2Wzk7v83CVjD0=;
        b=MSv/Ju+3di8qcyVlzxSxRJNfLoT+FDHTd70VAyIASnRCjXDqCdc8WNrR9J38MF0gsT
         NsDmkGH0bbE027kg7qTVN9sRAbT5F5jA4OcmVYI7+6yIb6fgblFee9H5QmoTIe2LT4Sh
         zaTEuquMl/Zi0wK+PI10Y8kM+3gnRUh0+tbObUCCIqbGyyvFy9S7w3Ox7eie/osQS/lO
         RiktC2rVG19/MljgvJh/s9usj7vwd3IPN84N6amfGM6JyxoWCTumdfZRG6AjnDweHMCY
         EQlfpawrm/yD2eVZ9towXdNV4YUTbXMFLApH/s/BnD0Vg/2kTo1Y42WNvKc17ih5aM3i
         WD/g==
X-Forwarded-Encrypted: i=1; AJvYcCWXltZK2XHIkLY/lNqPbPDqT97YREyX0UcsumWqsVjZF+0tImNH4F5IjmMNvit1Hwc6pv8bhPOHiUXZP+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD53AsrHM3veqaNBvhY3tNsWIeo+oiIGewdEuhNqLiginkSito
	W4eofBOKxQ1cFl6lz22iPQovWSrivsigEBNVwNnAQKuWa5KC0zZ7
X-Gm-Gg: ASbGncusvPZBLwzrfr/jQvXKX6GkPWX+HjiuSd1NsY1X0JhkjwbDfvrrzpdP/fdGC9b
	FXu4CzQEgkJtjVOecAc4MxFOiyZyBogGqhnkOdrP80jZEx5LKj7pXhl99z/O8jvHChfhNTrNsAO
	1U4Fubew9hD+dwW9p0b1/+CKfxauiOVttzn7Q7U5ogq+psHCekPU/1oNo4sBTDqQhTyJjBFLmix
	mom9dln4m+fm8EaY/lT/tYQII/1GX3waJi+qw+Y9lpFgJACGduzjPbD2J1UzJBbvYtaXGDBclwC
	uE3Nu0mJ/KmNTQ8o5qT2Bnen+eB2yau6sJEoPIYugNDrlr6CzJ1LWT5ofMRMjMgzgsy0x/01tA=
	=
X-Google-Smtp-Source: AGHT+IG8pXdepBcJ1AR4MauBkYvzdHDIviuaQyGBb5FOBK8tpHOPFUi2Wq2zbnf73b21vVo0+XSzYA==
X-Received: by 2002:a5d:64cf:0:b0:385:faf5:ebb8 with SMTP id ffacd0b85a97d-3911e9df687mr3609690f8f.7.1741190244836;
        Wed, 05 Mar 2025 07:57:24 -0800 (PST)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a7b88sm21222369f8f.40.2025.03.05.07.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 07:57:24 -0800 (PST)
Message-ID: <f54b78d8-2f10-484f-a1a9-4659aac2b251@gmail.com>
Date: Wed, 5 Mar 2025 16:57:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/sched: drm_sched_job_cleanup(): correct false doc
To: Philipp Stanner <phasta@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250304141346.102683-2-phasta@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20250304141346.102683-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 04.03.25 um 15:13 schrieb Philipp Stanner:
> drm_sched_job_cleanup()'s documentation claims that calling
> drm_sched_job_arm() is a "point of no return", implying that afterwards
> a job cannot be cancelled anymore.
>
> This is not correct, as proven by the function's code itself, which
> takes a previous call to drm_sched_job_arm() into account. In truth, the
> decisive factors are whether fences have been shared (e.g., with other
> processes) and if the job has been submitted to an entity already.
>
> Correct the wrong docstring.
>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> Changes in v2:
>   - Also adjust comment about arm inside function's body. (Tvrtko)
> ---
>  drivers/gpu/drm/scheduler/sched_main.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index c634993f1346..7e71e89cea89 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -1013,11 +1013,13 @@ EXPORT_SYMBOL(drm_sched_job_has_dependency);
>   * Cleans up the resources allocated with drm_sched_job_init().
>   *
>   * Drivers should call this from their error unwind code if @job is aborted
> - * before drm_sched_job_arm() is called.
> + * before it was submitted to an entity with drm_sched_entity_push_job().
>   *
> - * After that point of no return @job is committed to be executed by the
> - * scheduler, and this function should be called from the
> - * &drm_sched_backend_ops.free_job callback.
> + * Since calling drm_sched_job_arm() causes the job's fences to be initialized,
> + * it is up to the driver to ensure that fences that were exposed to external
> + * parties get signaled. drm_sched_job_cleanup() does not ensure this.
> + *
> + * This function must also be called in &struct drm_sched_backend_ops.free_job
>   */
>  void drm_sched_job_cleanup(struct drm_sched_job *job)
>  {
> @@ -1028,7 +1030,7 @@ void drm_sched_job_cleanup(struct drm_sched_job *job)
>  		/* drm_sched_job_arm() has been called */
>  		dma_fence_put(&job->s_fence->finished);
>  	} else {
> -		/* aborted job before committing to run it */
> +		/* aborted job before arming */
>  		drm_sched_fence_free(job->s_fence);
>  	}
>  


