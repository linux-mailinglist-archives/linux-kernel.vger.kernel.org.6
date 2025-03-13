Return-Path: <linux-kernel+bounces-559143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF09A5EFF9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4691897C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4269A2641D4;
	Thu, 13 Mar 2025 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="PGylW7eo"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86061C1F0C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741859641; cv=none; b=K/f7uAUEpPBglU1svT5CUJgY8lNFDacZasW1aZLAJqGwpC6HiM9CAGk6LjuRj49a4QyZPL4TCmIIHXQjyNdXOBiDEY1ubw12EjOicwTOT2wOMWPPlSdPGFfFmsCI5Ov5yI/x08WaC9a3MhDOscKiPZzzWaskWGwXpwKskDnm+8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741859641; c=relaxed/simple;
	bh=iIU9WP6zvjQquq+s7GzSKkfGvC6NNu1FQq0+12aU6iM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZgc+tHAdTXqnJ/I0d8XAU2eMV03OfbJ6hVVvEbAPJNyGvrDnqrwpSwA7rKeGy/J0UA6yKo4bqwghtVg8eIMY4DfcQClDe4n2Jky4uudd6ZApwXh2M5hUQiGkICLdrqWTtPtf75/TnVbzTZQp7ITiJogu7brPXDCCe6f9iuZh6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=PGylW7eo; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43690d4605dso4585175e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 02:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1741859638; x=1742464438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bkj3D7HWqdTM0cPpPrir4nDCLwOAsHNRg+iHEHjJvgA=;
        b=PGylW7eoC+bbMgXy7YJsKD0Kjjm8SVuYxwxUqLMIoZGrUDmycLDQKH/PetAj7+aRPN
         rUnyRDPdcSPl1vu+9y0MZGN9FomeR2LAqGqdX/V0rbQ9iOvs0AnHl3Nk/RgtUPxlc2bu
         /F+qbLjTN/tTWbBzKevR+2unfxToDAMAuwV6Ubmq/Q8Ht/Ht6JsQrDGa8eBpQkXeogC1
         ndTF9URMxFm2paFjb/DGwlD7tq4ihrJh8nO11J7LLByQ3SY1I8hu+uH7doS9I8ezAxLF
         C2XLWlM1yYS/jPz+RhHz4XwzGtAfeov/WuCq0P0nFcqKdmtrk9KmpDc9Z1H245S1h52I
         odIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741859638; x=1742464438;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bkj3D7HWqdTM0cPpPrir4nDCLwOAsHNRg+iHEHjJvgA=;
        b=xFj/D7lSLSaJJF4BM6lp0Dw3rqZK4b5TnsDFV1GQaNLEypE7BUA6GQ5CxoXGlaJrwS
         3rYG5XVKeWmL1hVoyL/ewjuWA82XNiZMLvZ4hY59PWVkqLXE5PXhmKAwkc9AtB9QMWRJ
         O2/TrJ/ST66pS/Yg+vSrR0uTSMKK3cnM95UK+5pvNv7WaP/NQYKn9F485UcgjHw4OcwY
         F8dVCXrU+QjYS8YbYxzinNk842yCC3oGpOlLc+pn9z8QpT9cthtr8s+cx04ssq3nJvBU
         4bP/uiJbz990JOcyKXNCpwcv14wW72o728HLGIxJg5EU5MC5sDLv8cBZWnu25yKqdaQt
         skmA==
X-Forwarded-Encrypted: i=1; AJvYcCVDZKwDyxcXtBOrwV6zJKAtR1dwZailmzjSNCwbJXQcRK7/CWzlug3nen8q1joS3cfSpMeJsyGRoTvxt+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGpDToW0hQriSoBepWz53drU/9hDti3wi2zmXsw5TWrHSNI4AQ
	WHdyZaPP8GhKYMhNMZs5q2FrHw9R/+80KuG+NE+tC78xGOAKlcvWbvQoyXgPRtk=
X-Gm-Gg: ASbGncvm0qXrEjOY9JafIi/bjj9gQY+OvgGM3OJU1mHDt3Zo5V+kBLy9V4iASn0YQqQ
	oJzJ+TcScDgpdoW6GmAky3xlZYu5IqizCuOrEDlu05RyUvnSfi7jGmHuHCirvx1jKx9rjUoSdKN
	gnEyARgyXzUOVQ2mabMLWx33crjTzeWzF1hoslGlDy4HfUwJiF74p3cGDRbuucPuP3/jYGiKhhn
	SMMWsWkzLJyelrMFYE8gKm6zQR32AkoTnnE6aWBKkLXMFOag2vFRkyHIM3SrNJdJm3Lst171c1O
	niPcvR5mKvLwXC1JxLBGbgu7VOf3dV/mGxeae+lT2LQPIc/n8YzZ+gY/vGg0BythfAdi+Kg=
X-Google-Smtp-Source: AGHT+IGFah8rosyfcYtPjUa18Cm/2jw3dX6OMmMtmKOZgN/CnODc8pdsRob3xheHOpbGu6piHsVtOA==
X-Received: by 2002:a05:600c:3b10:b0:43d:47e:3205 with SMTP id 5b1f17b1804b1-43d047e37d8mr105284545e9.11.1741859637901;
        Thu, 13 Mar 2025 02:53:57 -0700 (PDT)
Received: from [192.168.0.101] ([90.241.98.187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a8d1666sm48277205e9.40.2025.03.13.02.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 02:53:57 -0700 (PDT)
Message-ID: <0e3c8abc-7ccf-4a02-bec2-ddb0c7276d9d@ursulin.net>
Date: Thu, 13 Mar 2025 09:53:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/sched: Remove kthread header
To: Philipp Stanner <phasta@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250305155326.153596-2-phasta@kernel.org>
 <20250305155326.153596-3-phasta@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20250305155326.153596-3-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 05/03/2025 15:53, Philipp Stanner wrote:
> The kthread header doesn't need to be included anymore. It's a relict
> from commit a6149f039369 ("drm/sched: Convert drm scheduler to use a
> work queue rather than kthread").
> 
> Remove the unneeded includes.
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>   drivers/gpu/drm/scheduler/sched_entity.c | 1 -
>   drivers/gpu/drm/scheduler/sched_fence.c  | 1 -
>   2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index f9811420c787..e55b98af8a50 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -21,7 +21,6 @@
>    *
>    */
>   
> -#include <linux/kthread.h>
>   #include <linux/slab.h>
>   #include <linux/completion.h>
>   
> diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
> index e971528504a5..d6239e015b66 100644
> --- a/drivers/gpu/drm/scheduler/sched_fence.c
> +++ b/drivers/gpu/drm/scheduler/sched_fence.c
> @@ -21,7 +21,6 @@
>    *
>    */
>   
> -#include <linux/kthread.h>
>   #include <linux/module.h>
>   #include <linux/sched.h>
>   #include <linux/slab.h>

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

