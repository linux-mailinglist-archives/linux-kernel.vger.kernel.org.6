Return-Path: <linux-kernel+bounces-259726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0167D939C1A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D88282DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 07:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3914414B960;
	Tue, 23 Jul 2024 07:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="GU+DSSzm"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26B236130
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 07:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721721528; cv=none; b=qqcCJvgIq+PK5gbn7uh6TidXLMcanLIFjSLawlNG5OTw/huvOXrOBcKieV3k4Gbarx0+mnaKap7raAeQRvoSY4FYE876SniaJGh+E6cWIhHrfQzfcOXjSsr122TxyarfUcQiDG2pIwfu8MYV33rmGrahkiomLYeKHbbk9R+ArEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721721528; c=relaxed/simple;
	bh=tezqmdqLpOCk2emgmI+9gn8rvoTmkjtnvW43uwEZ2Is=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LwCl+lwoYxOSeSXbxN5DNPlpCB8eSZppz1/FM1FlO3+0SQzkFOdDaIGc1Dcn5M4sd7J3nJaoJbxuix0Yza3kk7QYKc+Zb7OvILGJi5e+dTjjpaS3vLv/CD9Caj8sXtCQYYDNBAxRd/4BfBsRwA69G4uYgkkMlUfSokDiQjvQnko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=GU+DSSzm; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4266fd39527so38878145e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 00:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1721721525; x=1722326325; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=umNAcUqJdRtZr0xF+y+QGLOd2nx2R4lw7z6ws/NwhSI=;
        b=GU+DSSzmKp6n3OGxgRpdIsfFz/RSGkESr+465j0LwcUR5Am22d/WMtvfnh/FAyT+ly
         gHsnBLqvqmp+jwf6XGFr8syetZcY9mYwkSeuOpTiMal9ZQT3ij+OepU2E3sNHfv+bDQJ
         19rtfTpwL6u7ljRQdOjE4Jb2Edn5PEiME+fwIbviKnqon/NG97U3HQBSL8+VIJdRGSRl
         J1znv9lLdx5G74KVcY+x3T68aIWIliv2/U6ojayulWz4Yh+EfzAlkCE0mghTGBu65xc2
         psF2YUFP2IH9ZOUBfYjlS1vyCRcAQjSn0jyaldkbW6IrblBQAgklM8w4lT72MJT+MUWn
         5CNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721721525; x=1722326325;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=umNAcUqJdRtZr0xF+y+QGLOd2nx2R4lw7z6ws/NwhSI=;
        b=UcuN06kuXt0XhPtkVRN86ruBEY7os9HnhZUIKJ6/BvduF8CiblS+oPzQaGdd1aoO24
         /9UffFkDHj/NGYicj2OPFBP2LTXRles8Q9BboQB7vnEgddzJO6WAJNSpP61evJDDAAYO
         r4sW0YETX/xFA9rfNv1bepPK6FV34xJ2DfHZ/OpFSQHl0fDLw7M8/5LBXEmgRcnPN9K3
         +2oZ72yDjTSZSzrMqcpuFhsA9bSkv5+gzUzUJBLqxBdMwA3ieoJGZCcNg71H4APaDNQh
         V5zDm1OYeOMD0AfYYBSxIQ5B+zbqH8FMrdbGKgXACnOOrWPp+vbNpUxl6QKC4ViBcTb6
         ybUg==
X-Forwarded-Encrypted: i=1; AJvYcCVxLHXRl1ARB2JOLfvzWhkCNmKlc2432dF/dn4nejXLcgYFE8Ep39D4xeZBCiiTwXclk3YZBkGSAKxZfZnuZZvM9RiQgItI+EeOAcUR
X-Gm-Message-State: AOJu0Yz4tbb8Vn8/rHA1BbLsPcqZqxSaH3oN1Mw8+6sO1ithuQW2JZUM
	a0TrlNm+f4XjTEw5qJfzJTmPJaYIO1LIY/Dr/4Xjlf/beacvs8eTPN3tG8z1qL97gSQCD6QeHyV
	Q
X-Google-Smtp-Source: AGHT+IGh5SVVErDKpfRMcH320xfK+fubRln8dcW8PmujwZANOvUs4TjqYpr90bWsiVfeAm0f4OBdVA==
X-Received: by 2002:a05:600c:1e02:b0:427:9dad:181d with SMTP id 5b1f17b1804b1-427efe253afmr5775285e9.11.1721721524176;
        Tue, 23 Jul 2024 00:58:44 -0700 (PDT)
Received: from [192.168.0.101] ([84.69.19.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a947fasm186525585e9.43.2024.07.23.00.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 00:58:43 -0700 (PDT)
Message-ID: <1fa79ff6-9ab0-4b2f-a776-c90f7ce23a80@ursulin.net>
Date: Tue, 23 Jul 2024 08:58:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] drm/i915/pmu: Let resource survive unbind
To: Lucas De Marchi <lucas.demarchi@intel.com>,
 intel-gfx@lists.freedesktop.org, linux-perf-users@vger.kernel.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20240722210648.80892-1-lucas.demarchi@intel.com>
 <20240722210648.80892-6-lucas.demarchi@intel.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20240722210648.80892-6-lucas.demarchi@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 22/07/2024 22:06, Lucas De Marchi wrote:
> There's no need to free the resources during unbind. Since perf events
> may still access them due to open events, it's safer to free them when
> dropping the last i915 reference.
> 
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>   drivers/gpu/drm/i915/i915_pmu.c | 21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
> index b5d14dd318e4..8708f905f4f4 100644
> --- a/drivers/gpu/drm/i915/i915_pmu.c
> +++ b/drivers/gpu/drm/i915/i915_pmu.c
> @@ -5,6 +5,7 @@
>    */
>   
>   #include <linux/pm_runtime.h>
> +#include <drm/drm_managed.h>
>   
>   #include "gt/intel_engine.h"
>   #include "gt/intel_engine_pm.h"
> @@ -1152,6 +1153,17 @@ static void free_event_attributes(struct i915_pmu *pmu)
>   	pmu->pmu_attr = NULL;
>   }
>   
> +static void free_pmu(struct drm_device *dev, void *res)
> +{
> +	struct i915_pmu *pmu = res;
> +	struct drm_i915_private *i915 = pmu_to_i915(pmu);
> +
> +	free_event_attributes(pmu);
> +	kfree(pmu->base.attr_groups);
> +	if (IS_DGFX(i915))
> +		kfree(pmu->name);
> +}
> +
>   static int i915_pmu_cpu_online(unsigned int cpu, struct hlist_node *node)
>   {
>   	struct i915_pmu *pmu = hlist_entry_safe(node, typeof(*pmu), cpuhp.node);
> @@ -1302,6 +1314,9 @@ void i915_pmu_register(struct drm_i915_private *i915)
>   	if (ret)
>   		goto err_unreg;
>   
> +	if (drmm_add_action_or_reset(&i915->drm, free_pmu, pmu))
> +		goto err_unreg;

Is i915_pmu_unregister_cpuhp_state missing on this error path?

Regards,

Tvrtko

> +
>   	return;
>   
>   err_unreg:
> @@ -1336,11 +1351,7 @@ void i915_pmu_unregister(struct drm_i915_private *i915)
>   	hrtimer_cancel(&pmu->timer);
>   
>   	i915_pmu_unregister_cpuhp_state(pmu);
> -
>   	perf_pmu_unregister(&pmu->base);
> +
>   	pmu->base.event_init = NULL;
> -	kfree(pmu->base.attr_groups);
> -	if (IS_DGFX(i915))
> -		kfree(pmu->name);
> -	free_event_attributes(pmu);
>   }

