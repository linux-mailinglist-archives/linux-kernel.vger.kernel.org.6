Return-Path: <linux-kernel+bounces-358446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1AA997F84
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53B151F2502F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510A41EF0A8;
	Thu, 10 Oct 2024 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ysohzAvh"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538A81C3F24
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728545746; cv=none; b=lwSzQoK2HpTjKPcpVQt8eAly0+DKT0q6IOXCE3b2A3Ml+NbxmyqesBEbOSOBd+WAjnnSgAKVF34gQM43gV6YrmeGQYb/veYUdga3+S5AWqyox5QpaRLeyLBxYhQg4mOFfT0+s/l7xeVqKGvWZjCc3eChY3FyXPuZJW6Bdy/bODw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728545746; c=relaxed/simple;
	bh=WHca4nLvasoZXyUDE91E9SdwkYbs9yTcrw7N22ZbYzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fzxy0NS1/8slVvzNqNAAdyiukaqn8XsRqI9rZN4RDWzBbZ4FiMZpWihQN5L+YA74yeTSegKL30GCUJOM9ZSkQ95zmDb6/K8IEsvi+Na/w9yJtpMsnLW6d66isyDl5nl40jY2PVi+MiVNp/+miGoQeG093NrdIgczyfjJmj47h48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ysohzAvh; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea06275ef2so391798a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 00:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728545744; x=1729150544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GWdKMxd+214aud7r2B8Ug203fvdDzYTHSUGUottLFgw=;
        b=ysohzAvhleUbsAnTeRtag0FfuuBq6m/O2O1XeXrATFx87Wi5oBnYo0rKbWZx5YJ7ks
         v7LHDuMsJl/Im5kVYiDFK8d2m6KZQBqkE6eqrCDqWJ1FKfLyMXWeMRI7zrEJYBqFb7H/
         NuUr+nCRMBd5DeMs6OffjESP/gDb5QSU4wZj+FJ3eqC5c+CY+kfKpgWNUihkoR19qhQG
         bi0eSBwxFp/z4xwSxIuyf5sPtQH1O5rrcu+5U3qk43y2d7YJsAquSELyzPjLdhVZvA7K
         /YDwlwfErWoZ36cv3EbbcHHNE+npQBuFQzdWX+XSEt8fqiwzBAU2vWVWDaIdrYOcru/o
         X2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728545744; x=1729150544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWdKMxd+214aud7r2B8Ug203fvdDzYTHSUGUottLFgw=;
        b=JqIF5lQMXmcvqJMQ8MsIOeojF7jmyeWaudO1iEJeWv3wseSK20YYexoFvJkXFikmqp
         a8sz8w0PECE3cAo+qxcyp4XLRl91CtuLB5zdagEK/4on5vFLOkIyYQJJK4ZSJDvaqOCl
         NJwl+c/HECth6FQBqX6MgjVHgU9hr6ryzm0QfpjpIxBEBFXNmRfcAvj4DAC4r+dZjI2J
         VKaQu+Cgew5Fc4sRPPOnfmV4q3/LJBaWpWENhrWRNpGIu6wyOyOgNLwWNbC2QO5QVMUB
         ARYhW8fkz7KjGU4L9LGaAB0kdiP6Z23a2xI5Bq5mnYSaBHvegsk5q6Za7p0Ai/gUahCM
         MHHw==
X-Forwarded-Encrypted: i=1; AJvYcCV4MWva/X95s6dg0UiRxrlLGWgfxlTXVjrlL3tJHToHXPeQGddIE0yw2q1T6VfBDAsZGBvRyynX8huohfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXSn+2ZE6ETzrI69wKy8FGugf26iBQzhaFEk7ddHkxqkR5L6Eb
	J9GkztXhr60tKA9Wro5nLxxC7itO1MLOo57uJI4U1ZTc4g+wfe+571r4uhowvnQ=
X-Google-Smtp-Source: AGHT+IGSVLXJCgqTeLzS7fIrZCUsnzwhd+i2I1D/kl/bZZmIc6cfKJeyHEVsD9Hw6XPVRgOfD+0kYw==
X-Received: by 2002:a05:6a21:4581:b0:1cf:3ced:bba3 with SMTP id adf61e73a8af0-1d8a3c4b7dcmr8689059637.36.1728545744636;
        Thu, 10 Oct 2024 00:35:44 -0700 (PDT)
Received: from localhost ([122.172.84.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9e9624sm505582b3a.41.2024.10.10.00.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 00:35:44 -0700 (PDT)
Date: Thu, 10 Oct 2024 13:05:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: gautham.shenoy@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com,
	ray.huang@amd.com, rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] cpufreq: Add a callback to update the min_freq_req
 from drivers
Message-ID: <20241010073541.nxsftik6g3tche7n@vireshk-i7>
References: <20241003083952.3186-1-Dhananjay.Ugwekar@amd.com>
 <20241003083952.3186-2-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003083952.3186-2-Dhananjay.Ugwekar@amd.com>

On 03-10-24, 08:39, Dhananjay Ugwekar wrote:
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index e0e19d9c1323..b20488b55f6c 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -414,6 +414,12 @@ struct cpufreq_driver {
>  	 * policy is properly initialized, but before the governor is started.
>  	 */
>  	void		(*register_em)(struct cpufreq_policy *policy);
> +
> +	/*
> +	 * Set by drivers that want to initialize the policy->min_freq_req with
> +	 * a value different from the default value (0) in cpufreq core.
> +	 */
> +	int		(*get_init_min_freq)(struct cpufreq_policy *policy);
>  };

Apart from Rafael's concern, I don't see why you need to define a callback for
something this basic. If we are going to make this change, why can't we just add
another u64 field in policy's structure which gives you the freq directly ?

-- 
viresh

