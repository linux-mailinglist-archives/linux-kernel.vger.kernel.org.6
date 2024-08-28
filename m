Return-Path: <linux-kernel+bounces-305029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E281A962860
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35238B20EB1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE0F183CC6;
	Wed, 28 Aug 2024 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M4ADynBe"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC90242AB3
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724850969; cv=none; b=fdcAltHjxyHon2qLCSeri3+nUJoebe8z+1c2MQipK/Dxsy+tj4ZfnTmDFfv8Isqp5nX5ReFWirH+6PoZ88tKhCHh7oOje/As1f+5OCtrw/cpkFLYSAwRXcejoMYH54BSDxB4yK2HWVLt/cBMqDggn9GneNI5REJvilxYBoHtzoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724850969; c=relaxed/simple;
	bh=13n8wvfwgw4WzmNh3YiRnaPdFHWC2d8jSAq3Dzjd8yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hiUcdt7xxMewE2aqY6Cy2akwT9cDYNabAM0+9yCdDWiuTUWInuILq4bkHZJj1ew9D3YyKhyT9bVk4bbWuWe8ZzEtFVSde6R8bvepeN3+s21lmp1/DJ9fS/TZHWZ2u9IBnZV9pYLrNeu3Kq3jLGXqVVrRT6PpcJIv3qZ5ptrj6IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M4ADynBe; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5befe420fc2so8282093a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 06:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724850964; x=1725455764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6xEfuOHBth+tI57VpPJ0AWA/OJxnz2o5qbCySLyaKbU=;
        b=M4ADynBeQaRFnOTxI5fQTL39dftG7JP/kIJUruebW4N93OS4EcB6j1r5GygAMZUuGP
         kAhEVmCjoksVFrF0ikJLbIhJP6+Q+w5KRRP9guud9feTAPtOxXYIlZzpwC1z3iFLCDmo
         GzQFJXRoIJHl9N0wI08muqr7MrVWXYxpeoAqSgfnhYMxMZlk5fpEls50gYkDFCj2PieF
         qS5f0nE6CMxRpy+Icrh4nKZG/qXZ8A5OtGKi8Lz2k+spycKQvmWX/vxZoAqPtWx+McgI
         UQvTd20w5m0Jam8e+TMSQS1SCGOt2MjGbyu+dQc3yhRHmnIQoFoKpWUv8arakP4TaY2x
         YegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724850964; x=1725455764;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6xEfuOHBth+tI57VpPJ0AWA/OJxnz2o5qbCySLyaKbU=;
        b=HviMrnQYiHM+cv2LNldsOdbZXNEp1E/wL3KIEORX5MJC7coTRKfdSqckTaRluwgzCo
         ANwkJLIjP7Nr5Xe7FjNO1MXg7BVrvXoOHedBX9iKOcXbdS6V4MAuBsGq9GGXkJgf4QJg
         B3J8LTXSEDx3kuUSCX6zEioyA8sRfyFbHiOHS/gdv9PQquogk6zCeQYM8wnvTn5rkoOJ
         qGhm870eNQyplXmsPrHX5hdg2GJx/4x98oxMuj7b5sCss+OJv2lEM06IgxDzIxgRp7Tw
         J9sVJgVr94aYtA+zGAKWZNHeHUfj0oH30kg3Fivsh7WzpZcMOQO9XLyBEfwnt9brH8I0
         Lmqw==
X-Forwarded-Encrypted: i=1; AJvYcCWiALzYHwUK0BxcJJ/HoctTjwY8/otsaA70PkjpzJDmqJL/DdHxHXKXGJhGxbadKmLKYnVILaG/8btO5Zg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww2zGvQDUGYdX0bBDTsUJwKileLQmOaa0EySHMSxEP6B+d6/YQ
	AE+gp65/4TmqrOn3IMZyi6fON73xA81AmYioseXl2+Q25yiI6/jS05m1mdCVl9M=
X-Google-Smtp-Source: AGHT+IE5BUYKTG9gsKwbU0VFLLV4P4FQ2LNHwR9u+1yhdyQpzmQCNC/29xlc3hFtTQ2z80ZlRg8VzA==
X-Received: by 2002:a17:907:f79e:b0:a86:80a8:cee7 with SMTP id a640c23a62f3a-a86a52bb629mr1235706466b.27.1724850963651;
        Wed, 28 Aug 2024 06:16:03 -0700 (PDT)
Received: from [10.20.4.146] (212-5-158-46.ip.btc-net.bg. [212.5.158.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e5878562sm243184966b.156.2024.08.28.06.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 06:16:03 -0700 (PDT)
Message-ID: <c613d2d5-cb7b-40fe-b322-45ddb43c6382@suse.com>
Date: Wed, 28 Aug 2024 16:16:00 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] cacheinfo: Allocate memory for memory if not done
 from the primary CPU
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, x86@kernel.org
Cc: Andreas Herrmann <aherrmann@suse.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Chen Yu <yu.c.chen@intel.com>,
 Len Brown <len.brown@intel.com>, Radu Rendec <rrendec@redhat.com>,
 Pierre Gondois <Pierre.Gondois@arm.com>, Pu Wen <puwen@hygon.cn>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Huang Ying <ying.huang@intel.com>, Ricardo Neri <ricardo.neri@intel.com>,
 linux-kernel@vger.kernel.org
References: <20240827051635.9114-1-ricardo.neri-calderon@linux.intel.com>
 <20240827051635.9114-3-ricardo.neri-calderon@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240827051635.9114-3-ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 27.08.24 г. 8:16 ч., Ricardo Neri wrote:
> Commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU")
> adds functionality that architectures can use to optionally allocate and
> build cacheinfo early during boot. Commit 6539cffa9495 ("cacheinfo: Add
> arch specific early level initializer") lets secondary CPUs correct (and
> reallocate memory) cacheinfo data if needed.
> 
> If the early build functionality is not used and cacheinfo does not need
> correction, memory for cacheinfo is never allocated. x86 does not use the
> early build functionality. Consequently, during the cacheinfo CPU hotplug
> callback, last_level_cache_is_valid() attempts to dereference a NULL
> pointer:
> 
>       BUG: kernel NULL pointer dereference, address: 0000000000000100
>       #PF: supervisor read access in kernel mode
>       #PF: error_code(0x0000) - not present page
>       PGD 0 P4D 0
>       Oops: 0000 [#1] PREEPMT SMP NOPTI
>       CPU: 0 PID 19 Comm: cpuhp/0 Not tainted 6.4.0-rc2 #1
>       RIP: 0010: last_level_cache_is_valid+0x95/0xe0a
> 
> Allocate memory for cacheinfo during the cacheinfo CPU hotplug callback if
> not done earlier.

I assume instead of duplicating "memory" in the subject you meant 
"cacheinfo" ?

Otherwise LGTM:

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

> 
> Reviewed-by: Radu Rendec <rrendec@redhat.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Fixes: 6539cffa9495 ("cacheinfo: Add arch specific early level initializer")
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Cc: Andreas Herrmann <aherrmann@suse.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Chen Yu <yu.c.chen@intel.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Nikolay Borisov <nik.borisov@suse.com>
> Cc: Radu Rendec <rrendec@redhat.com>
> Cc: Pierre Gondois <Pierre.Gondois@arm.com>
> Cc: Pu Wen <puwen@hygon.cn>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: stable@vger.kernel.org # 6.3+
> ---
> The motivation for commit 5944ce092b97 was to prevent a BUG splat in
> PREEMPT_RT kernels during memory allocation. This splat is not observed on
> x86 because the memory allocation for cacheinfo happens in
> detect_cache_attributes() from the cacheinfo CPU hotplug callback.
> 
> The dereference of a NULL pointer is not observed today because
> cache_leaves(cpu) is zero until after init_cache_level() is called (also
> during the CPU hotplug callback). A subsequent changeset will set the
> number of cache leaves earlier and the NULL-pointer dereference will be
> observed.
> ---
> Changes since v4:
>   * None
> 
> Changes since v3:
>   * Added Reviewed-by tag from Radu and Sudeep. Thanks!
> 
> Changes since v2:
>   * Introduced this patch.
> 
> Changes since v1:
>   * N/A
> ---
>   drivers/base/cacheinfo.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index 77f2e0f91589..0332148691f9 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -554,7 +554,11 @@ static inline int init_level_allocate_ci(unsigned int cpu)
>   	 */
>   	ci_cacheinfo(cpu)->early_ci_levels = false;
>   
> -	if (cache_leaves(cpu) <= early_leaves)
> +	/*
> +	 * Some architectures (e.g., x86) do not use early initialization.
> +	 * Allocate memory now in such case.
> +	 */
> +	if (cache_leaves(cpu) <= early_leaves && per_cpu_cacheinfo(cpu))
>   		return 0;
>   
>   	kfree(per_cpu_cacheinfo(cpu));

