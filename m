Return-Path: <linux-kernel+bounces-425329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB4F9DC0A1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE1B281DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 08:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5A1161321;
	Fri, 29 Nov 2024 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uTyFxjVu"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7816165F1F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732869676; cv=none; b=eiVHQopnWU7v7pA9tUniNSGOVTeQ1DjohDDji84uNLTnrePQYhHCoRIqN0RuHJgRebeBCf8FKqhIp9W9fncEoPZJ7OeRV9sOkis7gPStErsLFAmqzk4RmY79PK8AhbodQeyUgPKX+r8KK5OrBpspux6VKmoXzX8yRdh04KXkWGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732869676; c=relaxed/simple;
	bh=7DUtd75xdBGIj0fyWgDLUpPB07zHBJIM/NDe7IrC2jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPqHtS9+oke6vYeG6HQIkc3AZguQqA8d65XxoP4Zs7OuZ6usStMQyaIfUC4xTfvgVlmh0q4bfO5dFg1N0STMFMPCq8v/7NV0LNb3E13jwBcw3Hs46XblvWIeTaFFp9mhQcRMP+mD5RF8/WW9RP6yW9086AQ8LbJnZAH57riiH5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uTyFxjVu; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee397a82f6so849432a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 00:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732869674; x=1733474474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ua08itlNT1SHCtREOy/qtqXKvLOkks4jIn2aZch620M=;
        b=uTyFxjVuWRJytGnI0IwaXSGWxHFViM6d2QVmzsTt6kg2dXlgQGm/CaxqDhy9L7OTeF
         taw9rl6uMw1w3hSUdUWR3ALf0j1LmuopggjQZ5avS7t5KatmoPXEHlrvktGTyP5r8GBB
         4nzj8WS1UiDUdN9aKMr8CMH30i+zhcWHn4UWFFISSmqVxJHWgS6xvFnLERSM+SGsID7s
         chyoa3Gb+nEbQp7VhQ2wJ8a1La+D5MjKmffoDncex8vwty1I9Sfznj3NbMV9GnIiKMdA
         q8+yTTdAfvKoBHgxIxzed4Nf8cjkjew26cQcLfGBksDUjfGRwzaBBvGX5/W5fMegsH6+
         ucLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732869674; x=1733474474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ua08itlNT1SHCtREOy/qtqXKvLOkks4jIn2aZch620M=;
        b=VMtmxrZfABVfFUmXBIz8hYFseklYfCapUF/dZs7GE9tL0+wdCOrOX6sh6QW+fHhyTv
         cBTiAmixzKp2iKjes+3JeJumsv0XGG6K4wZRB4L3DBi2NVmwP3dhMKXA8lrJ5eYXKZWC
         /ShW8cEPONQ6PkvEnMPwsRhnpVp9ULMpemWlbKKdXaq29XPNrShSymZL5TKfSO7f3bGX
         pzhae7cMz6phGO0K3mddTtoKvT9qJsMKWctzj/Xx7bmfQm0/luYKDqSRT3IJJk/70Ixv
         UYD6UF/ow1vnLI6RUEOEfAnXnbpwaGFmMBL5WXM7VjbalL4vJyVlRDF4AmZ/Um74QsAA
         kvOA==
X-Forwarded-Encrypted: i=1; AJvYcCWSNdPQFlYUErQpGpBIExg3rX6jAHKJ/5ZNbzqgA4helnCDJ+cTe2ckyEZTumOTUUmcpxN6w4z4jE4xlng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwONXM8xSqziMEr9wbir59zH8ZQ4hf2wt65bLx9FiQsbwaUrVCq
	ldj/mTmvGc4f2tvkStyg3LaVqq/yMx7/8BczEsMx3pN6vATr0Ugff+Ws5x9Yf6Q=
X-Gm-Gg: ASbGnctmF2FKtC7wacbPwyHwr9orQpaiIwF+5wT2XYeKzHEwW++K4QVvgedIEACXCYf
	yKPNmtiBYNMLzpvqiEbaQlAHhYSwOEEosM/T1rT+GhNH8rLlPZSz0L8zwsD6/ZvKqfBrVUWjoze
	OQsPpwfZIx+AcKJD8ExWKbjnqaOcISTvvDVyjxVOwnfdEmOsETeGg9cS2wySLw1fKxGEGykAxbL
	zvO5apSm+mX7Zm2Xar2dVPojU5vn6qTcJcXE2qEU8kv0z1ZoyXs
X-Google-Smtp-Source: AGHT+IHt88htp1V5FejLAaRGGVGWdc3kx1MdmnWhz5bW4J4RdhEdxoxP75JgbFzMrURNpD1QDKs5JQ==
X-Received: by 2002:a17:90b:1dd2:b0:2ea:4578:46cf with SMTP id 98e67ed59e1d1-2ee094cb814mr13155649a91.30.1732869674054;
        Fri, 29 Nov 2024 00:41:14 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee2b01af0fsm2739995a91.22.2024.11.29.00.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 00:41:13 -0800 (PST)
Date: Fri, 29 Nov 2024 14:11:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] OPP: fix dev_pm_opp_find_bw_*() when bandwidth table
 not initialized
Message-ID: <20241129084111.ifwak4y4irxjnpru@vireshk-i7>
References: <20241128-topic-opp-fix-assert-index-check-v1-0-cb8bd4c0370e@linaro.org>
 <20241128-topic-opp-fix-assert-index-check-v1-2-cb8bd4c0370e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128-topic-opp-fix-assert-index-check-v1-2-cb8bd4c0370e@linaro.org>

On 28-11-24, 11:07, Neil Armstrong wrote:
> If a driver calls dev_pm_opp_find_bw_ceil/floor() the retrieve bandwidth
> from the OPP table but the bandwidth table was not created because the
> interconnect properties were missing in the OPP consumer node, the
> kernel will crash with:
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
> ...
> pc : _read_bw+0x8/0x10
> lr : _opp_table_find_key+0x9c/0x174
> ...
> Call trace:
>   _read_bw+0x8/0x10 (P)
>   _opp_table_find_key+0x9c/0x174 (L)
>   _find_key+0x98/0x168
>   dev_pm_opp_find_bw_ceil+0x50/0x88
> ...
> 
> In order to fix the crash, create an assert function to check
> if the bandwidth table were created before trying to get a
> bandwidth with _read_bw().
> 
> Fixes: add1dc094a74 ("OPP: Use generic key finding helpers for bandwidth key")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/opp/core.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 8692e8ce05b7c31a725ea3a7928f238c7a1d6f51..178780e294dad49c22d866930efb7b8b13ae2d61 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -114,6 +114,14 @@ static bool assert_clk_index(struct opp_table *opp_table, int index)
>  	return opp_table->clk_count > index;
>  }
>  
> +/*
> + * Returns true if bandwidth table is large enough to contain the bandwidth index.
> + */
> +static bool assert_bandwidth_index(struct opp_table *opp_table, int index)
> +{
> +	return opp_table->path_count > index;
> +}
> +
>  /**
>   * dev_pm_opp_get_bw() - Gets the bandwidth corresponding to an opp
>   * @opp:	opp for which bandwidth has to be returned for
> @@ -913,7 +921,8 @@ struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev, unsigned int *bw,
>  	unsigned long temp = *bw;
>  	struct dev_pm_opp *opp;
>  
> -	opp = _find_key_ceil(dev, &temp, index, true, _read_bw, NULL);
> +	opp = _find_key_ceil(dev, &temp, index, true, _read_bw,
> +			     assert_bandwidth_index);
>  	*bw = temp;
>  	return opp;
>  }
> @@ -944,7 +953,8 @@ struct dev_pm_opp *dev_pm_opp_find_bw_floor(struct device *dev,
>  	unsigned long temp = *bw;
>  	struct dev_pm_opp *opp;
>  
> -	opp = _find_key_floor(dev, &temp, index, true, _read_bw, NULL);
> +	opp = _find_key_floor(dev, &temp, index, true, _read_bw,
> +			      assert_bandwidth_index);
>  	*bw = temp;
>  	return opp;
>  }

Applied. Thanks.

-- 
viresh

