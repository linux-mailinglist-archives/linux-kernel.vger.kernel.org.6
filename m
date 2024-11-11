Return-Path: <linux-kernel+bounces-403575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA619C3773
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 05:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8A94B21851
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D95D3E47B;
	Mon, 11 Nov 2024 04:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Du5Beo5u"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6014595B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 04:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731298556; cv=none; b=dPa9y5b+W/DLQqyDm1eRwIpWvLwoCz2pmL0kkrlN5u8HSEQrdD7Ithh1Hvor9TT/gUJelVXqPq/82/fRoGSCYrQTv24dpm4cdWgaq/u9jisqZy4RrihFghm0PjwEUUFKPmMJpurf5TqtBN0+mcwRUDNtOjVa6MZa17km+pR2k30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731298556; c=relaxed/simple;
	bh=WbiDftJx9bFeENC4V0ZAOBz1aUB5u4vwB8PEVM89C9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G789Czx+BBcAsioC5nBmJlNFmEBgmYfvv45IKaRlG1Sr3SDqwLj1PMDeo2kINudTrHRqtTeLDuTTqvi0SnUyhJwPl64KygZyj6iz70px8NP23fj4AL7mgnZAOoGPxyWR2g962nmyHS1huGoNENvAIqEGqObky5ZZsa8DUqx6dLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Du5Beo5u; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-720be27db27so3247112b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 20:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731298554; x=1731903354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JQqiIEOanUS0Bcohraclo/HNFDw3Nm/rKQFhvAnqajw=;
        b=Du5Beo5uzuebhKxRIGNNtQ9NmfM6ko/RKAuYvb5mru5l50hRMUU5bWKprHFv0DBCAZ
         kGTtZ1jFbhHwooAeFeEWUZcqVFCaOq+spnkEPhmSrczoV3Gkn7+qQUbZ7vdo6/C5PPZi
         ELfEneTRwpWYsKkT5HsStSHeGrUdgBoGMn5KUnQRvjUatc7A1ypN2MnmY24U+Esr9KMK
         a0oHQyJsW33zcUeHSSnKv8BW0kgNzhm+KVskebjVUrwCIxNv38XeS+YigoUKSVMX+pbw
         O4pRI9SJvURwZQLcmNXSNiJWWtLraaah9zVmfFC9cn3Ehe1w73ssmhLjHo/l1Sjk6S3E
         XXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731298554; x=1731903354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQqiIEOanUS0Bcohraclo/HNFDw3Nm/rKQFhvAnqajw=;
        b=lNo1d8vh5m4youuvouucWTs/TVQdZNBm5u3Jpoj0bQUOh+f4R8OUqMrEW0DKLtHPMi
         PQarkJ/FpLI8rdbsfd8PEKTIKHWUuTuRQdkA/BvmCXdK1hhgIFy0IMJathutXj710cUi
         y5OrcMu5Mf/soO9F739Mtk3mCCdG+w5zDPVBJEqiKPdh7ntaw6DJUelccE4fpSlsbYk0
         bvuiNZjXMmadFnHjeRVnjoGK0wxr4glpuSbkeh/C6Lz5+aptcFYtl5DdnpQacK3GCdas
         fbM2vobue81Q8V2nRxTY8WsqrzHffLP64qbQlFDYTbeawkF4WrumAZ1jUn6wc62+S4jO
         xpSw==
X-Forwarded-Encrypted: i=1; AJvYcCWusAlunw9eqoJlyQMqQMfo09d8vUWRH5QkAkshdBcTTmlEO5v2KjZyc2GYaneMe07D44BW81PqkWfpW2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCNR/ED2xkCX2YycWYzhgeG8sSiOJUrptkOzlsknSO32bqWrGg
	wH6jRTquQ+wZv7aAbdjkFfq61Rtoct49SqwypWH3BD00DREjWiKZ0qT75bQFw6g=
X-Google-Smtp-Source: AGHT+IHaye9+95br80ilXq0UAgW/RS8BZnKVf9PjOkM2+kqV/D26Esutj25h9AnyilfmJ1f6bOMOnQ==
X-Received: by 2002:a05:6a20:d80d:b0:1db:ddde:33e2 with SMTP id adf61e73a8af0-1dc22b508a4mr15709373637.29.1731298553884;
        Sun, 10 Nov 2024 20:15:53 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a56048sm7974865b3a.174.2024.11.10.20.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 20:15:53 -0800 (PST)
Date: Mon, 11 Nov 2024 09:45:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, qperret@google.com
Subject: Re: [PATCH -next] cpufreq: CPPC: Fix wrong return value in
 cppc_get_cpu_power()
Message-ID: <20241111041551.lfgduu4m7ddckn2x@vireshk-i7>
References: <20241106010111.2404387-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106010111.2404387-1-ruanjinjie@huawei.com>

On 06-11-24, 09:01, Jinjie Ruan wrote:
> cppc_get_cpu_power() return 0 if the policy is NULL. Then in
> em_create_perf_table(), the later zero check for power is not valid
> as power is uninitialized. As Quentin pointed out, kernel energy model
> core check the return value of active_power() first, so if the callback
> failed it should tell the core. So return -EINVAL to fix it.
> 
> Fixes: a78e72075642 ("cpufreq: CPPC: Fix possible null-ptr-deref for cpufreq_cpu_get_raw()")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Suggested-by: Quentin Perret <qperret@google.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index cdc569cf7743..bd8f75accfa0 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -405,7 +405,7 @@ static int cppc_get_cpu_power(struct device *cpu_dev,
>  
>  	policy = cpufreq_cpu_get_raw(cpu_dev->id);
>  	if (!policy)
> -		return 0;
> +		return -EINVAL;
>  
>  	cpu_data = policy->driver_data;
>  	perf_caps = &cpu_data->perf_caps;

Applied. Thanks.

-- 
viresh

