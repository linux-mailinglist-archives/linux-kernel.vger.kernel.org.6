Return-Path: <linux-kernel+bounces-388082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F15E39B5A43
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 04:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2539284515
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 03:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA3218B09;
	Wed, 30 Oct 2024 03:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SouUv5tS"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F1015B0F7
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 03:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730258377; cv=none; b=YFrP8AhMvXqM9rbotp/it9FdT+QlQaNFwXRdWKizDLjb0roNpxzL2UaRi7IApxyel7o7qcEHaj4XK0YFQjUqHK1Joz9BRuqe0CFVxFThYchg6qSH8v1r4rZApwsYNmVMHMkvvMmNcIp+pauR7c+CLdt7tck5z2BXnSWfkM5NaZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730258377; c=relaxed/simple;
	bh=0TirbDMcHYPL5m6+j/2iCqfqiLEHJ+yA6VrynrkufZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQoosf1xE1SeFFNOrcGjTWq01CcUO+aP0eOKGzdAQOhHWJQQqUgEbLqPp/C2htAor2O5JgYKSRQFuKY8jzq2HEN+0QXakTF2mrOXx6uuGYz8ugR137/YvzzUQFdcOCmZdfzbJpAbIKGxsnrXvz+8rC71BIuCpZFN8NjF1mVsCEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SouUv5tS; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7e6cbf6cd1dso4230052a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 20:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730258374; x=1730863174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/m/pMKA42hUrPTBvxDfREd2O6bHEOtjTTtMPu4AReeE=;
        b=SouUv5tSLuYLSLMl9kIlJWVsoQ4PEW49hBEWBn5mKMc3WpYUVJtOCkm0YnyF8E1aSA
         09Crh5kMd/clEUQt2pAn4kKQsSkqMbcmol7UiCkhGJU0SbSPSCD9yRicrR1OjMlIFVcA
         5BOJf8pMrNU0LJx3Obu4O5fHbE0gtY27yuOjU6Z6GKg9vQ85I5RLE4VU0TH8Kh1kwdRH
         cT4RSYXBuItjjsGSx6AGD2VAlZtt/UfErFvRMNzHXQ5D+HkLMChax6ECx5x5c7acYsUH
         Oo1h97hVyeKiuV2A+FPIZ3HeKMlF7D+eoLH1I8Rhb2glwjzxTpKT6hHBddMyv4j/zjHh
         FkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730258374; x=1730863174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/m/pMKA42hUrPTBvxDfREd2O6bHEOtjTTtMPu4AReeE=;
        b=EhSqpePFUC2mQPIEt3AbyCmyBW5FQoJxfz35TMm9cxNvzYbNB1jWVS7WqbVlyBPqeJ
         T/tQkbWK3zO5r76Rya0n+5zslYZGKgg3ya/XGL8pswDYT+pY1k2CRLBOS+kawBFc3eez
         Tqic951cu76Q3c8KyMKlPpIeB1r6w7Ltrx+g0XUkBSQSDkQoe47ejFiAi6kDw53IrOhy
         JtT6dUK7z6/rPoxNkhXAyPrE5SyE5DtO9CRcSSgtJJF7QnNQBYYwF4qDrMbhSrJO6Ies
         0SuLeYMpp62x/s+gbj12RSybqjcjEeytFGt9bN3qJC4MMnlioy38zKq8HGid3w3zXxHu
         8wNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWixStI5KZIXe71QmzPzcmRBgu8KXDLk7F2zq9yHR1qsqkhrDp4ZtILK2Bp7vBfMsj1CqW6ByXJZuySWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ZSicOdsmYo94pyTNkJ1eKhg+jz/8ZghdLmr+oCM5NhNSr0no
	RzSIUk62vu4t/VIGR9qrQwAt9iBuVfhKU1X3iAdstokbnuq7PC5/k4tfntrgJNM=
X-Google-Smtp-Source: AGHT+IGx2HRuW/n17CdE1e0r2AJfer/8GdFjj5WJLHmVY6odjrUOSRhJHSNs1GfiMM45GLtews0p7w==
X-Received: by 2002:a05:6a20:9f04:b0:1d9:911:af03 with SMTP id adf61e73a8af0-1d9eeeab5camr3116677637.49.1730258374587;
        Tue, 29 Oct 2024 20:19:34 -0700 (PDT)
Received: from localhost ([122.172.85.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0bc94sm8319431b3a.119.2024.10.29.20.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 20:19:33 -0700 (PDT)
Date: Wed, 30 Oct 2024 08:49:32 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: rafael@kernel.org, Pierre.Gondois@arm.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: CPPC: Fix possible null-ptr-deref for
 cpufreq_cpu_get_raw()
Message-ID: <20241030031932.ymb46qimoaymiibm@vireshk-i7>
References: <20241030012019.357039-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030012019.357039-1-ruanjinjie@huawei.com>

On 30-10-24, 09:20, Jinjie Ruan wrote:
> cpufreq_cpu_get_raw() may return NULL if the cpu is not in
> policy->cpus cpu mask and it will cause null pointer dereference.
> 
> Fixes: 740fcdc2c20e ("cpufreq: CPPC: Register EM based on efficiency class information")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 2b8708475ac7..01c24c0ee9b3 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -420,6 +420,9 @@ static int cppc_get_cpu_power(struct device *cpu_dev,
>  	struct cppc_cpudata *cpu_data;
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

