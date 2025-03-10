Return-Path: <linux-kernel+bounces-553546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA1CA58B45
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 05:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99CC41688D0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 04:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422501C1F0F;
	Mon, 10 Mar 2025 04:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eQdw9+J4"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1942C257D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 04:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741581959; cv=none; b=DmnqMsvNDmYihyZl7UvD/W95sTai1AafTAEMf37cMY/6rk8icf8u/iQlNOq+Kz/KgoojPUZAcaLAeJW4VmdTW4JdRvEr6xlWmRzAbmOXYrcoF8bKzM1jDPf0YL/fTLnX/diMV/57ikAIby6kzwqcia+v/NNSt6Tggy5KQwH2hjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741581959; c=relaxed/simple;
	bh=JRAD8UOU585xke1ahIH/tODZNm8+Se7tMxj/ziVkiW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHD1B/34wbK2uBhr9ydtgTqZQLp+bBfcnE9ap0Voq7aLZCQjCeMIplunb23RuMo/CrW9lk2pK+n6rcgsYpig9NCWE53mutW4sKRYe5DPsQ7rJs3Ob3TTnHZvseMA+VOum//YeqBu9Kx4YW4qDU29kx2kBXkMLb1668y+9mPE+5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eQdw9+J4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223959039f4so72509465ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 21:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741581956; x=1742186756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kw2OaaNPvchcmlFrqMHD8BuSkIwCc2oB92xYk20lkhY=;
        b=eQdw9+J4SVp0bTmEc7A/xFr694PsUYJ0T27nxhXZUz1hR07pKkUkNCTChl1OYDo61y
         jT+8x5/62CBQw/bVMeq49hlRflKH55IzEcKOkEMmiRxMslpRBol9wd/heQKQf31sBtdd
         Vcd0M5GsZi8MW9OTTqP+iVrodUAwQOGiATGGalyLFcM/bERc80dACIehiZW/7xtJaPb0
         4gp1d5Uo33oP1VC1WUpB74A7emjUuYIB6hjPpTacElOTc27jvU5eV/hTd554N5CEs1+l
         OTlrXrczYlcPZJ5/yR1yct+1Qzmi//YzMVCQg+2frHJBJxQQJa1zeskllTnO0obh2sJT
         pFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741581956; x=1742186756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kw2OaaNPvchcmlFrqMHD8BuSkIwCc2oB92xYk20lkhY=;
        b=PTRSz1FDm+FbXbh7xQAIY+riHt75+XW0pl4cFC7ItPEZPQump2fcFF6EfAOxfC/Ri2
         7NVnzRWqSAbTDCAUz36PE2pg0VSPwhPUiNU71BmUE9DF1Xd38firb4xyrPOi9VSCC6E7
         6wXKLTq50nSjagewBXWRTvOfGHyLr7/ZEIU3B/UsvrlHo99za0CvmEGIH64IK7NyCVZh
         r0KWT6VCCjiG32EIppYDFddakiIz4VeLYBdX2rmBPByTrMYBWij3xIZ2HkQmgvKDeYvG
         iZDa5rntkW6OsTrfCcvz7KCUosLvvmPzh/yTya6Sv33E1oVHYut04w26+f2NoWB7KTYt
         CEpg==
X-Forwarded-Encrypted: i=1; AJvYcCV1cF0hVGOXjFnEeZfKEsHhTPuvmIjw3QNSiOL+2MHTfh3e8ag3M+EJ1Gn39iy0QgXXtq6jfgSV8u36uaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjArLPxGiAIDUYVGYUmqNbNG9wIPudVR9KT2ae1WQ3HzaY3TFP
	gefwf4cSZWW+K/rwkgU9R4j6/3KruDlphy1hbuqllDiiMnb21an367/BUvCQXw0=
X-Gm-Gg: ASbGncvGruLCOFRcMZQYHaBoyHx0ChwFeOaSfaCVO2j6iztxdmuj3JQIUmyuOKlox70
	7ciH64ACP6klSdKmEPSp3M1s5I0PUJ2hN5NRlWVQVvBjFte4foBkf3SECz2KK7DvcRREAIgOEMi
	MisXSci8SRgBzyZeBJWOVoEN5tfDk76RXX3hDDiM3tX4zsPvArcqoHqGZWeaSklQeTXKFJOzzsw
	nkdRxQqaY9G+8+Pal06w33P1F+s24I6Zn4/SVrHud1nvGW7tPhiXOEdehb5X1aB4k7X2Fbg+opA
	e7mWEEf3KEhLM0utkBUhJuWkDnv2t0gSAHOU8rD1AxYrrQ==
X-Google-Smtp-Source: AGHT+IF5bDU1rFa9VtZpFUs6HfI8CB9JfBOo6glmNRgP0U7OmG53UWM6H0zHVAdiu6JBpq+CGnoHTg==
X-Received: by 2002:a17:903:46c6:b0:220:d257:cdbd with SMTP id d9443c01a7336-22428bf16b4mr222163445ad.48.1741581956321;
        Sun, 09 Mar 2025 21:45:56 -0700 (PDT)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e944csm67848155ad.74.2025.03.09.21.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 21:45:55 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:15:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Aaron Kling <luceoscutum@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Aaron Kling <webgeek1234@gmail.com>, linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: tegra186: Share policy per cluster
Message-ID: <20250310044553.zupmsoi4d3errjvs@vireshk-i7>
References: <20250216160806.391566-1-webgeek1234@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216160806.391566-1-webgeek1234@gmail.com>

On 16-02-25, 10:08, Aaron Kling wrote:
> This functionally brings tegra186 in line with tegra210 and tegra194,
> sharing a cpufreq policy between all cores in a cluster.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  drivers/cpufreq/tegra186-cpufreq.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
> index c7761eb99f3cc..c832a1270e688 100644
> --- a/drivers/cpufreq/tegra186-cpufreq.c
> +++ b/drivers/cpufreq/tegra186-cpufreq.c
> @@ -73,11 +73,18 @@ static int tegra186_cpufreq_init(struct cpufreq_policy *policy)
>  {
>  	struct tegra186_cpufreq_data *data = cpufreq_get_driver_data();
>  	unsigned int cluster = data->cpus[policy->cpu].bpmp_cluster_id;
> +	u32 cpu;
>  
>  	policy->freq_table = data->clusters[cluster].table;
>  	policy->cpuinfo.transition_latency = 300 * 1000;
>  	policy->driver_data = NULL;
>  
> +	/* set same policy for all cpus in a cluster */
> +	for (cpu = 0; cpu < (sizeof(tegra186_cpus)/sizeof(struct tegra186_cpufreq_cpu)); cpu++) {

Can't you use ARRAY_SIZE here ?

> +		if (data->cpus[cpu].bpmp_cluster_id == cluster)
> +			cpumask_set_cpu(cpu, policy->cpus);
> +	}
> +
>  	return 0;

-- 
viresh

