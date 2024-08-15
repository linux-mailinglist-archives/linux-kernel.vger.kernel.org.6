Return-Path: <linux-kernel+bounces-287616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A93F9529FA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 09:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903E31C20CA6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 07:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE1019AA41;
	Thu, 15 Aug 2024 07:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WH1s4APv"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD0C17B51D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 07:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723707068; cv=none; b=iXuV9dTQgnVtHIWJU9YhUcH54mBI3fjLH11onANMw9ur5TDDLZYf/hUE4ZkUDEfc51FsxTq4cpiGhHFlBZNz1JJ2OGaVsXMm88oGi/+2EipRRprKzN5cWIJYUwMqRsCRJUTFzlPNsvIk4FoLZmIA8Q6+Bu9SUMEi6bh8uzSH4gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723707068; c=relaxed/simple;
	bh=4PE6mZrr8H7PR8eBnAu+UMXSqK7YbiUSYrQYtoLYBqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ow/9g+iqdKNM9Pz3l3nt/i3fy6sUxX7IikVz7S6qZpgTk24tbQRWX7p8j5p2B8UqbaTtgMR03iun8vKGpfsRTi1rKXhaIGc8kGCFusCIn2Z/17dhaxizwd3j9Z4EAA0fctcWLavgvJjKiIzj6emjVVhyMR65B74PC1kDMWpwL4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WH1s4APv; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d1cbbeeaeso531159b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 00:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723707066; x=1724311866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K/0W+4K7PrRjUu9VD4koOfW7NXqyGwydvnf3SEGRUt4=;
        b=WH1s4APveZR5KVVNv/1TAYXGHvxlyaZfFMrIEMtbsEMDA/0j3FSbxs4yAYbrBli1/n
         JInNHnFR+7+LxbNk+739zg6YmNd+dxtPLFvNek6LP/1VCaqXbVX+uENW0moUw9WXyrP5
         +AmG2U6N0CU8D0rZG6N8dh+57sqBSYpCBgVCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723707066; x=1724311866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/0W+4K7PrRjUu9VD4koOfW7NXqyGwydvnf3SEGRUt4=;
        b=lSv/bTCHWCApJMVgWP+AuWn/FJwxleR9ByHfsdGeDB7tWyDvDhxlMnMg/vs25Od3KI
         G0VRSbnoMGCG3To7BMVSuduv491zyORANWUlwEN739cazeufpWyx4i2OeeR0FqGIw16r
         PkCvsMx4/VmhYTKlRC42ELIfH9TPiG0mECQ6MfMiHQ071dW262l3ZCak5G1iLgcjJtFO
         FlX0Q7RTYyCkBHGYpN7h3ZGLxehoT2SCdGLXfHlYBYe/SjyFQ8e/mXCyHEi3qJI+Brjl
         gtFV6JUAWNR1Edbzx/r1mL3ikUJ9rxvhmWuWV0SrBg+JAkYJsumpe5e3C7ZexfpDKInV
         SM9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1H4kdNwfoXGhGjNHpxDbH98stUBwzR7T3P5nqFwQVwmOR2pw03V9MOwhyZ3Pfv6BDiqbjA3cOC+HjbE6V04ULOX7fMJ4KXrwJ4eLb
X-Gm-Message-State: AOJu0Yx7OkzQLQGAE9OzN+yqh7uq5qm4ykhFHme0FNxXPlcfmwZI0/CB
	61PDdqSFeI62vYj5eDfZnc/qGG1wYpVnJJ0z7+GnUItIbhaBlpGLH52MzL9ZOA==
X-Google-Smtp-Source: AGHT+IGej8YvuGdBMRMsXjNlbIbtoIi0LLSQzAkjZWVd/ikaWZkP42kYpFajA9fEuF1NPTDRfj3RWQ==
X-Received: by 2002:a05:6a20:d706:b0:1c6:fc7d:5546 with SMTP id adf61e73a8af0-1c8eaf59d37mr7069297637.37.1723707065853;
        Thu, 15 Aug 2024 00:31:05 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:745d:58f7:b3cd:901f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af188a4sm559611b3a.164.2024.08.15.00.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 00:31:05 -0700 (PDT)
Date: Thu, 15 Aug 2024 15:31:00 +0800
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
Subject: Re: [PATCH 6/7] thermal: tegra: Simplify with scoped for each OF
 child loop
Message-ID: <20240815073100.GF350960@google.com>
References: <20240814-b4-cleanup-h-of-node-put-thermal-v1-0-7a1381e1627e@linaro.org>
 <20240814-b4-cleanup-h-of-node-put-thermal-v1-6-7a1381e1627e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814-b4-cleanup-h-of-node-put-thermal-v1-6-7a1381e1627e@linaro.org>

On Wed, Aug 14, 2024 at 10:17:52PM +0200, Krzysztof Kozlowski wrote:
> Use scoped for_each_child_of_node_scoped() when iterating over device
> nodes to make code a bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
>  drivers/thermal/tegra/soctherm.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
> index a023c948afbd..ff4eedb553fb 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -1651,7 +1651,7 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct tegra_soctherm *ts = dev_get_drvdata(dev);
> -	struct device_node *np_stc, *np_stcc;
> +	struct device_node *np_stc;
>  	const char *name;
>  	int i;
>  
> @@ -1668,7 +1668,7 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
>  		return;
>  	}
>  
> -	for_each_child_of_node(np_stc, np_stcc) {
> +	for_each_child_of_node_scoped(np_stc, np_stcc) {
>  		struct soctherm_throt_cfg *stc;
>  		struct thermal_cooling_device *tcd;
>  		int err;
> @@ -1683,7 +1683,6 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
>  
>  		if (stc->init) {
>  			dev_err(dev, "throttle-cfg: %s: redefined!\n", name);
> -			of_node_put(np_stcc);
>  			break;
>  		}
>  
> 
> -- 
> 2.43.0
> 

