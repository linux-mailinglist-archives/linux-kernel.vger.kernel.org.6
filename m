Return-Path: <linux-kernel+bounces-203920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F648FE201
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFE22B25F7D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A81613B5B5;
	Thu,  6 Jun 2024 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Okd0t8ai"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45724168A9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664442; cv=none; b=J8PUKs0gFCI/H3LpvmLDPohPdja+V/QoYlThP7/wpAnqNYWhZlCOvXPjMaP3+XVOHixJfS5m4P2qS1XLTd2+alRquZ/E1+LxWKoR2x+5C4R5dWAfPU9EyuWIS4hxhmZROM0afY1/fgVc/NtSVXa9CEFsr3XYyWZk29YaxVknyAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664442; c=relaxed/simple;
	bh=Z2zgMXfJmu27DbOj5JrH6qEdmkT1Emg/49JfaZUY2TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QD1yl8hRt5AIL4QT/4wc61ajKh9fvJU34JsPTuioFLXR4VyRAaEDCLHGLsSqf5GBQYAiRuANYDYHmvD5JhD7z022DUbbsb2nrrqa8At3NPq//psA9oXIdzOJ7M8MDMPLOfHftHPqNYWluofhxBL6utzLsTXRCtq1RXbpbxWDFhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Okd0t8ai; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f6c7cdec83so565255ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 02:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717664440; x=1718269240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=34i9c6SrAxbvVIYSgNgR0QRNfSIYZYsCpLD0yBLi1hk=;
        b=Okd0t8aidCFhu1ENkKHcnWVHej+OywJtnjCaBg1cfxRlaItm0jN0YpKuoeh1cDV+Du
         7Klt5iU7VX5PqURvDKuDGSZh/Jhsgragbo6px1JalwRypQpSjuQ396Cy+xX/5ChYrNhO
         SYVSBfbNPvoBRGHTXUNuO+bPrdbXIpOmjqOzzPzH7nkXTH8GNSTN33thOSGqoGTzvGSZ
         PPj9uY+bCeW7yugn49g0IEj5BF6uNOf4e5F94WKY1VR1kzh48trunMcX6eXAHXFxVZ4j
         7uhdN36APGbchVdD+18WQ8HEtbZRsUjtH/H/I19JrxOifNX6i1Q3rEmxLEFEJkQvj2zo
         gbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717664440; x=1718269240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34i9c6SrAxbvVIYSgNgR0QRNfSIYZYsCpLD0yBLi1hk=;
        b=UIa+jOUnaEWV1nQ8xllNcwQWC5lRMle4bH8eP3lbBmg4AR7KQufV6qCvLPHWltfSYU
         UaZt9WwO+aTLSlxvesrj5EhHVRlVgG99E8DcF6qKHaoiQggrdPv2kxerCZyc9ZtTUHsn
         8/BwADFpY/f3xCR1v0rT+qxCer0eu1Yso5vKppA5+/2Ohih3bvOclgox9LM+dOxIF1pk
         xNKjwLJ8Kii1B7bjTF98CS3kuglLN8r+CbbCGbEOqkLtSD6KyrPJ9GQpI+PbL6B6Yn7N
         Q0Lq8gEZaJTQOm7KaskGzpnSY2l/zRy4Od7modq6xGW2NtN7+pKNKuNWefpyfZumvA1S
         I77g==
X-Forwarded-Encrypted: i=1; AJvYcCU21IHhHigTFeYns30jMaBwp02SXrN+wGsdbFn6iOvbITOudWTwFTQhbCUbOjgISCmjkNjFGxVzO7IHdALwfvI0ruA1HJX4BJujyRFj
X-Gm-Message-State: AOJu0YxAGF1Uhz0551wczFsnnm8BD1KmRRBIK0o1f/dgxBotp7JqXX4z
	0padLwNyG0vWWIv5gXQkRSkpDqzWFCDohQrkWBfBsgABnLPEpl6k6jZ6GOBFZQg=
X-Google-Smtp-Source: AGHT+IGBaWpCLLyQhhlMrvujsZHTasOuNlHy+sHQPl2a5na2b1UsqMVlY1JnEEXwTi19dHyzxOiSRw==
X-Received: by 2002:a17:90a:8c94:b0:2c2:8655:1742 with SMTP id 98e67ed59e1d1-2c28655180fmr3826407a91.11.1717664440343;
        Thu, 06 Jun 2024 02:00:40 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2806d2936sm2943926a91.53.2024.06.06.02.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 02:00:39 -0700 (PDT)
Date: Thu, 6 Jun 2024 14:30:37 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: Re: [PATCH] cpufreq: ti-cpufreq: Handle deferred probe with
 dev_err_probe()
Message-ID: <20240606090037.2v3sl72rjfzzk4k7@vireshk-i7>
References: <20240606065847.3499145-1-primoz.fiser@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606065847.3499145-1-primoz.fiser@norik.com>

On 06-06-24, 08:58, Primoz Fiser wrote:
> Handle deferred probing gracefully by using dev_err_probe() to not
> spam console with unnecessary error messages.
> 
> Fixes: f88d152dc739 ("cpufreq: ti: Migrate to dev_pm_opp_set_config()")
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
> ---
>  drivers/cpufreq/ti-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index 714ed53753fa..5af85c4cbad0 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -417,7 +417,7 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
>  
>  	ret = dev_pm_opp_set_config(opp_data->cpu_dev, &config);
>  	if (ret < 0) {
> -		dev_err(opp_data->cpu_dev, "Failed to set OPP config\n");
> +		dev_err_probe(opp_data->cpu_dev, ret, "Failed to set OPP config\n");
>  		goto fail_put_node;
>  	}

Applied. Thanks.

-- 
viresh

