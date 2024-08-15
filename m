Return-Path: <linux-kernel+bounces-287595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ED09529B2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 09:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DAACB21425
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 07:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9963CF5E;
	Thu, 15 Aug 2024 07:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fPW+DK/z"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF5D381AA
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 07:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723706146; cv=none; b=oAbPqPWBXRGNXKoS9kuEBwknLHjhAZSANs/0bd3/+WIlMvccYRV+9n+C4iqT7FtrwTaZO9SCSTH0NhL1C+Eo+6/u4XcpS61VqXob5ELf0x5Zj3qY0bPJa8N+zEllPqemVgUBSuMSOVJgaKTwJNS8w8ZQPwWs6+zMY9gHZXFSCp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723706146; c=relaxed/simple;
	bh=GiHqZmyxScam6mzZQKuZVjPKqh8K83cFLfgDpQE6uR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjjCyTtFBJA7JDrkPF6nmBBT/45ItePnlJag6CGtgxVNoBhEy/LhQt6k2oU6drFxoBTRTiIYarHignv05np2jwNf+1DXFHbk1FUu6xPhSHmfrl8XcOrHS9S+IJDRZ8TfzG0C9UIdZV7MXbTeKX7ywQ08wSaLXgjmnJk3ki2btf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fPW+DK/z; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7c3ebba7fbbso564451a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 00:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723706144; x=1724310944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R9JmgHsK2eXcLrFjeKXovclXcr+2gfKF6M2PZSpS0PY=;
        b=fPW+DK/zVU9Xc1UVAto7c1CMd3pxUGZ6I2xZITNJFy6Jntpq5LWymqrVkjyOMNkWtS
         RPWyTApTs3kwg5fjbWJLmSibPlBaMnKvd60jo1VUqqloPp8TM+kTrLIBYoYobYJTVQZA
         cMSSpcpWqv+PFOl8DKIozBK7Gp3+l9cQP5xVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723706144; x=1724310944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9JmgHsK2eXcLrFjeKXovclXcr+2gfKF6M2PZSpS0PY=;
        b=aOPWndFDZb13eOsCKdiiX4MjL9DS2f+fOMACE5d66e3lhU37/h5jM5sE2ne1zH61Yi
         Wl5chjlqmZw1UmMlTv7FGU/DQS5oQpeMdjV66OTP7FOOCVx1E2Vvwv4jVDio5iPuW6ix
         +geoyRof8snzIIZDrzkxQhMuAV8cglM6owsq3+ENu3TLBZR1f/clAk2vA2ikIJRTu5lS
         jLPH+L6xbZqJsH3QmR3+gn6bXMPdrFezCx22HQXIm63n/U1J2lXndzC2FRLxjw3K5qg2
         quEf5OXatelaWW7+H1gfPnYgr60LcbDNfYjJmjoVm0JrzbbJzx7FwlhawsTpew7+1W4a
         QzkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0vmd5q8Ch2oITF25NBf1PgAG8FlYh/jbNTmnxs2J+l1srB3raCuh32NQDEr6TA9PQRvAVHQCkCTiTg9stJdkSU2GuKhDUFzCUFIj+
X-Gm-Message-State: AOJu0YwY1lAmcBAaj1+XVpcJbATIxyvQSAx2SgSqeE223MIdY+AhVQsY
	BGbcEnXbyhyYmiVJIp6Nj0vfviksGDSX3j/yX8Rz7s+G8cBRi84s2U0SJCOM8A==
X-Google-Smtp-Source: AGHT+IGNNH+hyCCACdJtYZXI0gh62w46gVKcCAEgz5OV9CHzEwQIVxs+/U2Ky/c7OF20qNjl/7/JGQ==
X-Received: by 2002:a17:90b:2dc8:b0:2d3:b976:e30e with SMTP id 98e67ed59e1d1-2d3b976e58emr4016575a91.37.1723706143698;
        Thu, 15 Aug 2024 00:15:43 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:745d:58f7:b3cd:901f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac845f55sm2898845a91.36.2024.08.15.00.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 00:15:43 -0700 (PDT)
Date: Thu, 15 Aug 2024 15:15:38 +0800
From: Chen-Yu Tsai <wenst@chromium.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 2/7] thermal: of: Use scoped device node handling to
 simplify thermal_of_trips_init()
Message-ID: <20240815071538.GB350960@google.com>
References: <20240814-b4-cleanup-h-of-node-put-thermal-v1-0-7a1381e1627e@linaro.org>
 <20240814-b4-cleanup-h-of-node-put-thermal-v1-2-7a1381e1627e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814-b4-cleanup-h-of-node-put-thermal-v1-2-7a1381e1627e@linaro.org>

On Wed, Aug 14, 2024 at 10:17:48PM +0200, Krzysztof Kozlowski wrote:
> Obtain the device node reference with scoped/cleanup.h to reduce error
> handling and make the code a bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/thermal/thermal_of.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index a2278d4ad886..c8ded4462bb8 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -117,10 +117,9 @@ static int thermal_of_populate_trip(struct device_node *np,
>  static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *ntrips)
>  {
>  	struct thermal_trip *tt;
> -	struct device_node *trips;
>  	int ret, count;
>  
> -	trips = of_get_child_by_name(np, "trips");
> +	struct device_node *trips __free(device_node) = of_get_child_by_name(np, "trips");
>  	if (!trips) {
>  		pr_err("Failed to find 'trips' node\n");
>  		return ERR_PTR(-EINVAL);
> @@ -129,15 +128,12 @@ static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *n
>  	count = of_get_child_count(trips);
>  	if (!count) {
>  		pr_err("No trip point defined\n");
> -		ret = -EINVAL;
> -		goto out_of_node_put;
> +		return ERR_PTR(-EINVAL);
>  	}
>  
>  	tt = kzalloc(sizeof(*tt) * count, GFP_KERNEL);
> -	if (!tt) {
> -		ret = -ENOMEM;
> -		goto out_of_node_put;
> -	}
> +	if (!tt)
> +		return ERR_PTR(-ENOMEM);
>  
>  	*ntrips = count;

Also drop the "of_node_put(trips);" in the successful path?

Once fixed,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

And I plan to send a patch on top of this making "tt" auto released,
thereby eliminating the error path.

>  
> @@ -155,8 +151,6 @@ static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *n
>  out_kfree:
>  	kfree(tt);
>  	*ntrips = 0;
> -out_of_node_put:
> -	of_node_put(trips);
>  
>  	return ERR_PTR(ret);
>  }
> 
> -- 
> 2.43.0
> 

