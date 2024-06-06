Return-Path: <linux-kernel+bounces-203919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347978FE1FF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7732B28ABA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE56C6D1B9;
	Thu,  6 Jun 2024 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aIiSVzQz"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EDD13C909
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664401; cv=none; b=d+dlUzDPaf5hnadwpR3X05n7dy/ebIC2pMtIjXfTos9IJum6tMJf8NJBfHHllQB6wWauvU2nq3AaUw8Ob6jC3SqmrSIp3W0+yF5l9N1yyOjfXCaauIzcc7VbtT8aMyUrYq4wKniVKbp+mpoqTy8TfTyyM57uXexZk3BVO3/pKoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664401; c=relaxed/simple;
	bh=MIkVsh90cZYsfiJEcuAev6ZbCKUDyfWwMzVW2oKJagk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJJt93toJdbKhrQVITwZ3ICfjZ22Uo3MihTraHMRFPJpmMfzHTiOuIOlM4Om4MwWTrKXBvaSrqmHZOEaNfMZNghdnINmAmF7XuM6FWvOnj/TSVJPYkDc7Fs9RDYUkaeeYpJPcrN1mUVPAlfu+uklYPfjTUD9Z27Lsgpz9iLPpJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aIiSVzQz; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f6ad2e2f5bso6657455ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717664399; x=1718269199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vw9Z+lFOo3E2YVWKkVppwVo7xlwDWzE151RHv8U1WZM=;
        b=aIiSVzQzyseRDCaGbgrcj+FaQyda5eKg7ieegdAJT+IjWQU/De5CHyjyEdzZNRPbBo
         mql1sJxiEQf1OLFvxY1nPh7rADfjEeolGGcDgQ3/DGHgWCGE59Ljp2zkDKsoK8m4Nsu+
         kIfeMln1Vp4sjftFnp7CTgczXRklr+XDt8ZDHlMWnTILuZbcwZyYXJWUW7axmaQpjCd8
         UBbIMDGodQGkGvdUuL5tCtEa2xpZ9Z/GwSdPDJUP52m4t+nBJqlpuy0Qd+G5ei0M/s+T
         lLUmUyGj/vYhAsBSUDojAx0s5bK159VM9VzDUaHmksQTQK/mqCP2okodM92tQyP+CZTv
         5RDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717664399; x=1718269199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vw9Z+lFOo3E2YVWKkVppwVo7xlwDWzE151RHv8U1WZM=;
        b=cZ8roqkcxqq7KyH2vVPP6tQCEfEwepD0cjAhlrJqdXcC+4krmnkk4hY6VfOYanxOKD
         WxCtIN5C4+fJa7Z1sExAI/oTMlEUvQSck+JUxaHDcv3KzGUqtJvPjai712wRZgJNpeRC
         dOzKpSLYa8WgE0IUAIFHkVKC2YhYaGWjuHzH4zWMPWgk1v6zYfHVSQUIchR2wbDqHTiI
         JdPPS3ayw5NTLpC2ZHJbng+quDGMUn0sTnZAQ/ZA11Tnh2pBK82VK1LNlm6cAYCQQ6Ki
         coSe4qRZLCyMdq+QrWo9t9KVXC6Os3SiJWJhzsrJx0wFXUBrVouVU2Z7rDsk+V7HdehG
         JOWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD1/XWpJpii9dzdL9n5fxIWk5KaTh6TKBTjHQGCt6B/Yi4CDSokw8o8VeyPXicVdgrNjWepLWdanAOTPQSuhxpwq/Bwr6sySdPxijC
X-Gm-Message-State: AOJu0Yyd93H+6fXXLhv2dnP4+nGe4nEd2lazgJ3EzoZbYGxfsCNOsfHw
	HH5aTYX7krqGRhNRjdFhrM6A1Rj2aG3kiFfD0peZzz5hf5BkvRT2jG540dqKQO0=
X-Google-Smtp-Source: AGHT+IE39p37NlfYz4LfxSVVQVjRwkUq0LK/SbHpmvooozbDV3rLQcLApIqiilLJoWVb3k4adBC8rg==
X-Received: by 2002:a17:902:e84d:b0:1f6:7fee:8fda with SMTP id d9443c01a7336-1f6a5a86ac4mr59382055ad.64.1717664398909;
        Thu, 06 Jun 2024 01:59:58 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7d2d33sm9468695ad.126.2024.06.06.01.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:59:58 -0700 (PDT)
Date: Thu, 6 Jun 2024 14:29:56 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: Re: [PATCH] OPP: ti: Fix ti_opp_supply_probe wrong return values
Message-ID: <20240606085956.wsp3ecyfqck5tltt@vireshk-i7>
References: <20240606070127.3506240-1-primoz.fiser@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606070127.3506240-1-primoz.fiser@norik.com>

On 06-06-24, 09:01, Primoz Fiser wrote:
> Function ti_opp_supply_probe() since commit 6baee034cb55 ("OPP: ti:
> Migrate to dev_pm_opp_set_config_regulators()") returns wrong values
> when all goes well and hence driver probing eventually fails.
> 
> Fixes: 6baee034cb55 ("OPP: ti: Migrate to dev_pm_opp_set_config_regulators()")
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
> ---
>  drivers/opp/ti-opp-supply.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
> index e3b97cd1fbbf..ec0056a4bb13 100644
> --- a/drivers/opp/ti-opp-supply.c
> +++ b/drivers/opp/ti-opp-supply.c
> @@ -393,10 +393,12 @@ static int ti_opp_supply_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = dev_pm_opp_set_config_regulators(cpu_dev, ti_opp_config_regulators);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		_free_optimized_voltages(dev, &opp_data);
> +		return ret;
> +	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static struct platform_driver ti_opp_supply_driver = {

Not sure I understand the problem here. Can you please explain with an
example ?

-- 
viresh

