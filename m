Return-Path: <linux-kernel+bounces-388364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E419B5E77
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 074EBB21770
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E90E1E200F;
	Wed, 30 Oct 2024 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R9c+h65K"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988721E1A36
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730279343; cv=none; b=TlPHsQGywOaF2Ap4Bm3v+CaNAzQ2EfIgsL3Qb8CnkXj7TgTuA8LSVzSj76s3+ReeLdTjNfjnKPNB+aZP5wCUGjJmI/7xtp/Y+tYyVMh7tbRSsM09zHh+SXyA/ymK3ufVHrZnJFbQLahkWbvjjvW+e50XePlo8Ii3w/Mg3rt+8AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730279343; c=relaxed/simple;
	bh=d3Q+Yytwfe4ckVzNFhYv5nqhXE0KaEIAWOYK18fEHsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUgBVIqqWKxB02E8bj73qtT6R1Pflp+QODbUJMYhlShJDMjWnOpsA3Kv7mDkqa7xmaRFd/zo2HPtJPMIFUkuICMJ7HyioWPfKRaY0MC5KBS5d/oNSCEfxon66TK0ENuoD8fgYyDNE7xDlQgc10f7YYz78rjGO5zM2PGEehTgCjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R9c+h65K; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-210e5369b7dso27328985ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 02:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730279341; x=1730884141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/PW7dWJigQBbEpDGe2vAuK8PqZgGZIhZvDH6evlQM/o=;
        b=R9c+h65KmyeLejilQiW4PYGRz7Vd6UcKvgbp1pSkAOHmTwQsm/bRkS3xFitiobMzPn
         X8/bynSfOkTaxcIT0c/YxtG8QypqOmBnmji2ISg+cMN5ZQj199f8ZxZUpDFkCOg9C6sk
         u8noe6ckfchWmCLXeytMxLC82M2Gbpoc8oQWRkmOyT1f5/ii3YoUGfwUiG/aJ1qIiu3A
         ZrA8md00hy6KSaQSRyHe64MuFxNw0DofITlj0P1rt50y0lKH18h8oVbQQobg+Z8wYFwT
         JiBa6FEgbUqQmjAhk+zWjpTICRHGQIzBokGWBrZVUBkj7+iWAZrDaq125In4etWI8OY9
         89Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730279341; x=1730884141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PW7dWJigQBbEpDGe2vAuK8PqZgGZIhZvDH6evlQM/o=;
        b=hp/0GpIYTVh1dDV8e8Vg/spYDIFhGPU1rQ4n6n+HbvBPUNKWY/Sqp3iaM9z0nh/B6o
         ZXD4IJvt67/XTd0L/Bl96D6wODoRn9tvd+i9TzgzV+kxuD+UgG7wVb5VBbzHvi5OaLZ5
         FiAE9Hg9uZTK+aETwKQ1enmKg7YyjfhDkfx9shJ+OR+aLrmsXWQ11tF7p9nnfxZ32vGI
         RskaVAxtlUtnhwt99Rnwg6Zwf4HJCnvOWp0/3lC9mOSKeU7LXw9wymW+z4p6IxWOah6C
         5OA+pJeZevZK9loQ90/Onjr6JIpPr940MaqwJzhd+7DCO1NJXB3uYP4vXcngI/rYL52o
         1p9A==
X-Forwarded-Encrypted: i=1; AJvYcCVncdU2ctN6yzfqB1o7mx1h2bDGos64bCgN2Sp0tLZHLMcJzPdVSTtHHmGR1nNcn2qTQK/HV53zHJowW5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl7uZ19CD/CFOSgnzhVFx3DbzkvQ3fQDDUPV3ff0RVjHT7X0si
	vQQLpBgYkkuUZIdHSMHFEUx3ujIBws6kzELvQnOjOhWRHkGDG/nhplpP8QBHzpI=
X-Google-Smtp-Source: AGHT+IE/UTz5fNaLTsQYnxAU24zjHRKEz6dWEitgwhKr6IH5FPDOdIQ5v2Yn/2Hrhm8Qg250XXdSJg==
X-Received: by 2002:a05:6a21:4d8b:b0:1d9:1f2f:fbdb with SMTP id adf61e73a8af0-1d9a83ffa57mr20414711637.25.1730279340928;
        Wed, 30 Oct 2024 02:09:00 -0700 (PDT)
Received: from localhost ([122.172.85.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205791e97bsm8755658b3a.34.2024.10.30.02.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 02:09:00 -0700 (PDT)
Date: Wed, 30 Oct 2024 14:38:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: rafael@kernel.org, Pierre.Gondois@arm.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: CPPC: Fix possible null-ptr-deref for
 cppc_get_cpu_cost()
Message-ID: <20241030090857.xbnpfnpi4hp4emkk@vireshk-i7>
References: <20241030082449.2629861-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030082449.2629861-1-ruanjinjie@huawei.com>

On 30-10-24, 16:24, Jinjie Ruan wrote:
> cpufreq_cpu_get_raw() may return NULL if the cpu is not in
> policy->cpus cpu mask and it will cause null pointer dereference,
> so check NULL for cppc_get_cpu_cost().
> 
> Fixes: 740fcdc2c20e ("cpufreq: CPPC: Register EM based on efficiency class information")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 2b8708475ac7..67fa97bbeae7 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -487,6 +487,9 @@ static int cppc_get_cpu_cost(struct device *cpu_dev, unsigned long KHz,
>  	int step;
>  
>  	policy = cpufreq_cpu_get_raw(cpu_dev->id);
> +	if (!policy)
> +		return 0;
> +
>  	cpu_data = policy->driver_data;
>  	perf_caps = &cpu_data->perf_caps;
>  	max_cap = arch_scale_cpu_capacity(cpu_dev->id);

Applied. Thanks.

-- 
viresh

