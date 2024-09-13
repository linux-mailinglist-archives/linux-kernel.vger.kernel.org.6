Return-Path: <linux-kernel+bounces-328114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3371C977F0E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97469B22E30
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397F51D932A;
	Fri, 13 Sep 2024 11:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="BsYxhAdM"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DF81D9323
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 11:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726228591; cv=none; b=t1wdMJHX2jFap5bI/pGWDQU7S+Qdo0D+7MMjPZBGI0YWlhJ74pG2dehp+ZUQczHsGFVZe/fjmZsQtb68I3N3Vx7CVDKWXXZp8oUmlxAJ1JPKcGA2GKG17/3uNoCDAfu7siGGEc+wEUVC+UO/tBYEsAheYGFyrQNSsQxP7AsFGXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726228591; c=relaxed/simple;
	bh=avfI9NP7nnkIB/v2i9vFydmiMri+7Ngcy+APR4Q4/No=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nXgiP9uXybCX0nwYegllaY6WTKtwbiYI1E8/jY1bB6zytanfv6rIS6P18zrqXVti2fo8ggHZbpi9bgmvly357aKbj+c0va+R1AjNtLggEKhqJQvaxymJuHRjtYe487Lqsi2ibueR4v7Uo5T5v+U5zVZlUKnO7Olj1YV3XdaE7Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=BsYxhAdM; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso19816595e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 04:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1726228588; x=1726833388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b28g9Qh6wbp8sFAAmBj0WXV4vMJYAGNB1czPJCNOJh8=;
        b=BsYxhAdM5R4iyXPCy/gQI5FtOO39XuVhEExh3X+uUEYkl/OYYuUx4rgSTDXnZEwRES
         r6k3EqliM8SFxSj3JHQlK9u5D5T0mIyWtZcShiv0sIuX/HQginhlXvI1z6UXaU3iMcjD
         eTL1tY/tKdFxMTkXN/+jIW/PtsxAstlsqwzIEq/LnJTH/GxkufAznK4vLxbpXEZybZIA
         3nII60rc7TPPAVetArZCGKDKih1yWytnn8tiRIYKDfuc3gDGripQ3zOOHjmAvwbUlEYo
         2S1I9NFmcjZeztRP+xB4j0N960M4sct8/eDASn9T2QR8/YeUF8uAXUJKTbk61a8cYxS1
         LcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726228588; x=1726833388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b28g9Qh6wbp8sFAAmBj0WXV4vMJYAGNB1czPJCNOJh8=;
        b=rtasKUrwt7OUkQVjqUWkOAmCREp+f2XaxzW/Gap9+UX6TojLRf54UnSalEk5V3V9zb
         HEuPOVUMCJvRfJri9jHYxujGHn9GpvLKORDwUf160lrYIKWcvf2cdvdhEwVTBQnDlDHo
         tonAMrRWbRBLWXmip5/US78cruz8C5Rfwhf5gJ4qqDP+jqfUWTFvNR8H+doqdwdA5I6u
         MTm4gcoE4HL5PKZMqxezYOqN4yYply+sWs5x//LhNjS1GUsiFraU1wd6rBAIQpVCiqAY
         EFcXKU0qGliZ5pvErQ6Y5e7waJznk9Hu0XKL2T5FmYDrYV0JPH5Tr4JIgz4MkY7WB3DU
         RU1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFBM0bqChkzIXncM9kxpHThNWiDYImMVLKDX7lTzv9DuULVPQwIFE/zaRHV1yx9W+AEaY8Q5W0sdcECBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT+8wSeaqGXW3WjeUiL3IeD/Bk4BTe+9IwmEEEIFpIqPQrF/Sg
	W+UjJBSS7P+GqgIS9CBO/EXDCKkBg/cZVZP9K6BkA4XbVS8iHUCXlW+3obAzWp4=
X-Google-Smtp-Source: AGHT+IHcUXeBZBOEM+H7QN71Pqp8IN5OgZbq+vY6D+e8DBFynITqywYcxExRNOpgBMESa2uv7BiL6g==
X-Received: by 2002:a05:600c:19ce:b0:42c:b4f2:7c30 with SMTP id 5b1f17b1804b1-42cdb56ae9bmr50228735e9.23.1726228587234;
        Fri, 13 Sep 2024 04:56:27 -0700 (PDT)
Received: from [192.168.0.101] ([90.241.98.187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b05a6f5sm22478835e9.4.2024.09.13.04.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 04:56:26 -0700 (PDT)
Message-ID: <92a123f1-73c9-45a1-8e0a-af72dd0a70e7@ursulin.net>
Date: Fri, 13 Sep 2024 12:56:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/sched: memset() 'job' in drm_sched_job_init()
To: Philipp Stanner <pstanner@redhat.com>, Luben Tuikov
 <ltuikov89@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Danilo Krummrich <dakr@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240828094133.17402-2-pstanner@redhat.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20240828094133.17402-2-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

On 28/08/2024 10:41, Philipp Stanner wrote:
> drm_sched_job_init() has no control over how users allocate struct
> drm_sched_job. Unfortunately, the function can also not set some struct
> members such as job->sched.

job->sched usage from within looks like a bug. But not related to the 
memset you add.

For this one something like this looks easiest for a start:

diff --git a/drivers/gpu/drm/scheduler/sched_main.c 
b/drivers/gpu/drm/scheduler/sched_main.c
index ab53ab486fe6..877113b01af2 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -788,7 +788,7 @@ int drm_sched_job_init(struct drm_sched_job *job,
                  * or worse--a blank screen--leave a trail in the
                  * logs, so this can be debugged easier.
                  */
-               drm_err(job->sched, "%s: entity has no rq!\n", __func__);
+               pr_err("%s: entity has no rq!\n", __func__);
                 return -ENOENT;
         }

Fixes: 56e449603f0a ("drm/sched: Convert the GPU scheduler to variable 
number of run-queues")
Cc: <stable@vger.kernel.org> # v6.7+

> This could theoretically lead to UB by users dereferencing the struct's
> pointer members too early.

Hmm if drm_sched_job_init returned an error callers should not 
dereference anything. What was actually the issue you were debugging?

Adding a memset is I think not the best solution since it is very likely 
redundant to someone doing a kzalloc in the first place.

Regards,

Tvrtko

> It is easier to debug such issues if these pointers are initialized to
> NULL, so dereferencing them causes a NULL pointer exception.
> Accordingly, drm_sched_entity_init() does precisely that and initializes
> its struct with memset().
> 
> Initialize parameter "job" to 0 in drm_sched_job_init().
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
> No changes in v2.
> ---
>   drivers/gpu/drm/scheduler/sched_main.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 356c30fa24a8..b0c8ad10b419 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -806,6 +806,14 @@ int drm_sched_job_init(struct drm_sched_job *job,
>   		return -EINVAL;
>   	}
>   
> +	/*
> +	 * We don't know for sure how the user has allocated. Thus, zero the
> +	 * struct so that unallowed (i.e., too early) usage of pointers that
> +	 * this function does not set is guaranteed to lead to a NULL pointer
> +	 * exception instead of UB.
> +	 */
> +	memset(job, 0, sizeof(*job));
> +
>   	job->entity = entity;
>   	job->credits = credits;
>   	job->s_fence = drm_sched_fence_alloc(entity, owner);

