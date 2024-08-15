Return-Path: <linux-kernel+bounces-287592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF03A9529A7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 09:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9561C22188
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 07:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBE215E5D3;
	Thu, 15 Aug 2024 07:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q0d8xHct"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D255BA20
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 07:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723705827; cv=none; b=LHInijWzWHP5WYXmcQDQ+lmDGKSJCVcyt8YDlriVeyRQbf3yKCmg4fiKGfC/rzzXrd1Mg6vMIOIEhLi7SW05KqiZ7CKXRYKiZV0eo+hq2uMpeHDGpQTtn8a55DhP2eCtSTO0MNcHqNBp+JETFTbvEAZBPOKxO3CDK0Zu8EQO068=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723705827; c=relaxed/simple;
	bh=+G2x58+Rfzt9S7NTB27xB1O9RQRhx/e+CR+izCKso3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyZmcShUk2NpygAMZpH+dxBXk0APd1/xStJvPPU6B6PYGmbgbN/UbqhnhawdbM26t2pJIvFKgPw4izS9rnmYECcusyOKs7uGD1xxWd/xT3Avrh2s/33FP01chg8WJbt7JFd2G30H59JSL/8yI5ExSI4mcbDyBg58R9FV0qA3JM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q0d8xHct; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d1cbbeeaeso520778b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 00:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723705825; x=1724310625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J08p29teShFomh8KvO2Ddu4MMDaSeQCVywSAkToMLKQ=;
        b=Q0d8xHctEB6TqR/kumIhzB32FPnELvdKJd1/6UhA2j51oN+4gdVxf0Vp6EChj3vALB
         JMgdR7kUxiOED+MIiWRGqU/LOtG9sm6D3V7TOd9cYdyOBiG3aE4g8YFDWNYhq+bUIpUa
         9MsG7z45weW1omActBTPEfF2EonvbZvcPos/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723705825; x=1724310625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J08p29teShFomh8KvO2Ddu4MMDaSeQCVywSAkToMLKQ=;
        b=xUmZNta9TdWujAdTjA5BUaOANtul9tsu0u56cSRrgATjXlcD/wHbL2dmt9skCXSKDe
         m0/zgEh479+Z73ry33Mt+1r66VAx3XjiAh8VJoQb4LQNzL/0lyJufbp9p1zI5V3KMNQt
         qo5zkeoztJ1MgH9mLhFpazo/c5m+fnuffh9MB/GwgD05KKC6Ge/q2MCn7aGslVsWMoj2
         YDI0yPwm+swj8I6QzdTCEaqL4aV7VeLabZAX5n+Wm1Um6OATvjcAFkyPGm5fE1h/7xcu
         +DUOjQhbFP49E4cdewf6ivlLLoo853y04fJgJaLCaznCompUgRtYrAB4g0n1cSa54viA
         5XCg==
X-Forwarded-Encrypted: i=1; AJvYcCWP7599MZlcmsXOD1sJJvLTihsNDvpYxfsFq4lqeUZnZeAknFe9/5FQIPXjXj5PKpTz5sJ0l410K4ChMqxlc3ut34i3j2txykX5qQYH
X-Gm-Message-State: AOJu0Yx+3NGzwjidEYGKn1qXFe8zk+DEVG8ynsI+HCsYa0qn9BOk0KJC
	4K1TbSmIfFKZm9jSI9IEnIRAE/9T2HqFtkn4JJx98rA4SRmJ9R73vu9Et6J3iw==
X-Google-Smtp-Source: AGHT+IHiXJsW+fRg102OhEnKAhvxwqG0Aaky2UVkllFzxbNrNdYCyuMBqkLJT5RdAPJhpDiPBU7AYw==
X-Received: by 2002:a05:6a00:4b49:b0:70e:8070:f9d0 with SMTP id d2e1a72fcca58-7126710d3a1mr6179895b3a.9.1723705824996;
        Thu, 15 Aug 2024 00:10:24 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:745d:58f7:b3cd:901f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af19683sm536163b3a.163.2024.08.15.00.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 00:10:24 -0700 (PDT)
Date: Thu, 15 Aug 2024 15:10:19 +0800
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
Subject: Re: [PATCH 1/7] thermal: of: Use scoped device node handling to
 simplify of_find_trip_id()
Message-ID: <20240815071019.GA350960@google.com>
References: <20240814-b4-cleanup-h-of-node-put-thermal-v1-0-7a1381e1627e@linaro.org>
 <20240814-b4-cleanup-h-of-node-put-thermal-v1-1-7a1381e1627e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814-b4-cleanup-h-of-node-put-thermal-v1-1-7a1381e1627e@linaro.org>

On Wed, Aug 14, 2024 at 10:17:47PM +0200, Krzysztof Kozlowski wrote:
> Obtain the device node reference with scoped/cleanup.h and use scoped
> for_each_child_of_node_scoped() to reduce error handling in
> of_find_trip_id() and make the code a bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
>  drivers/thermal/thermal_of.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 1f252692815a..a2278d4ad886 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -8,6 +8,7 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#include <linux/cleanup.h>
>  #include <linux/err.h>
>  #include <linux/export.h>
>  #include <linux/of.h>
> @@ -22,11 +23,9 @@
>  
>  static int of_find_trip_id(struct device_node *np, struct device_node *trip)
>  {
> -	struct device_node *trips;
> -	struct device_node *t;
>  	int i = 0;
>  
> -	trips = of_get_child_by_name(np, "trips");
> +	struct device_node *trips __free(device_node) = of_get_child_by_name(np, "trips");
>  	if (!trips) {
>  		pr_err("Failed to find 'trips' node\n");
>  		return -EINVAL;
> @@ -35,20 +34,13 @@ static int of_find_trip_id(struct device_node *np, struct device_node *trip)
>  	/*
>  	 * Find the trip id point associated with the cooling device map
>  	 */
> -	for_each_child_of_node(trips, t) {
> -
> -		if (t == trip) {
> -			of_node_put(t);
> -			goto out;
> -		}
> +	for_each_child_of_node_scoped(trips, t) {
> +		if (t == trip)
> +			return i;
>  		i++;
>  	}
>  
> -	i = -ENXIO;
> -out:
> -	of_node_put(trips);
> -
> -	return i;
> +	return -ENXIO;
>  }
>  
>  /*
> 
> -- 
> 2.43.0
> 

