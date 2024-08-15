Return-Path: <linux-kernel+bounces-287604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7AE9529D1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 09:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2320F1F23A84
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 07:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6FA17AE03;
	Thu, 15 Aug 2024 07:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hsaF2IFw"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBF717ADF4
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 07:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723706556; cv=none; b=iVqj/zKcKSSQA2vgwE/xNqP2q3hOqzGdjRZhk7wU+1llTWkb8CeZChtCd6PrJb4vSU6lpPMfOKfbsVqA/7s2lIzrTCg9FyINEcDGTz3rjtHigmn23DUjcZEjPNfYEdgcJ+x4A1Xn+xKrEDJ9z8NbmOCax1lvDdlj4UM5FeLM79w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723706556; c=relaxed/simple;
	bh=J0JnP5sTSbfqtp9rSEsTZC/IZ9oSMYmaRLemBLu7fF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsiYWUgxfHhAH8aHaBtO4pX6Od7um3+V6nGpXrDIPNsiNKk2LnXInN4ScFdkTSUDjBCwg1qjnIVM/EuJpeDsVIKctNuBFaCTJgW3sD4fZBoUeazcLFaMszGhS/Hqx4dVO6CoYyS0txpjYaR5uitDAk+d+5AMH0K3UU81vWCBJ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hsaF2IFw; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7a263f6439eso534668a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 00:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723706555; x=1724311355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPQgXt+/K8hdVrtKvDp/K2jbzvYRDCrHGMGcHAQLofc=;
        b=hsaF2IFwbkorPvGQU47jiZOx4jj1zHMvOl5OovEuS0a5vDneqigM0igNKCZRv7kPxS
         U/sd0FonMmLaUMAyOYHdD4JgyM7mOerHyGtsLHc2BKkJhul2bHiAUnDoIkUf9R/eg6T1
         JyZnC72FD3cG1woTR49VJpelWLO2eP5JYSmBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723706555; x=1724311355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPQgXt+/K8hdVrtKvDp/K2jbzvYRDCrHGMGcHAQLofc=;
        b=QwKSweubnCkidBY4/xxaD+bIKRM65qkaYlwo35s42IzI/aH7xqW7ngrRrSd4eyecZ1
         5ln+4kFmZHbNgbXqlhLERPT4ZoX9mqbXnRvKpkjx0qvlH50Q23QLbEy4RCVW1+KlCKGG
         hhYXrwJ7kBtY5EOi9SxjDQvGHGQeulBZ5995DpIwQGbDHk87Dh0rW1YcB7OuSxUt6Iv/
         vyjdoQ8sErx+iSPjekvRs9+4I9m5WP55A+lBJTbJ/tEgFRFIl6UTqbVX0HT8yntPnwDQ
         VPpslDxUpp5fdustlAT6eTFxQlYW+N5LPICtqyBswIerJOAapQ9t3rFcAP1p94Pkmsl6
         2kDw==
X-Forwarded-Encrypted: i=1; AJvYcCUH/+CFSSbW6lPTaCHoTVPzP+Av6xviE1CYvD+TE33OPTixvadZxdhIUE8mh4d2m4VT4RLWO/JafDfAyzaJxGGt5bhwZq0okWUAAAgp
X-Gm-Message-State: AOJu0YxyvmxuNMYBKCmjjNp1E3cONF8YJ0GmctFPifYy8L0Pkfuksr9K
	7HNo6qtnIOnruqnGXIlPsS0JC+wCywRMf74CaS8YPFpPkdHOUJzbF2ePgTukOA==
X-Google-Smtp-Source: AGHT+IF/aGc6hHkocmjJlKEUqA+vIlBn3QfPHZ/jI+SDNYKCem3sbWEWjaXISqMqkijXU5e/Tig7ew==
X-Received: by 2002:a17:90a:b392:b0:2c9:359c:b0c with SMTP id 98e67ed59e1d1-2d3aab60a01mr5682803a91.28.1723706554713;
        Thu, 15 Aug 2024 00:22:34 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:745d:58f7:b3cd:901f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7dd457sm2930469a91.21.2024.08.15.00.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 00:22:34 -0700 (PDT)
Date: Thu, 15 Aug 2024 15:22:29 +0800
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
Subject: Re: [PATCH 4/7] thermal: of: Simplify
 thermal_of_for_each_cooling_maps() with scoped for each OF child loop
Message-ID: <20240815072229.GD350960@google.com>
References: <20240814-b4-cleanup-h-of-node-put-thermal-v1-0-7a1381e1627e@linaro.org>
 <20240814-b4-cleanup-h-of-node-put-thermal-v1-4-7a1381e1627e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814-b4-cleanup-h-of-node-put-thermal-v1-4-7a1381e1627e@linaro.org>

On Wed, Aug 14, 2024 at 10:17:50PM +0200, Krzysztof Kozlowski wrote:
> Use scoped for_each_child_of_node_scoped() when iterating over device
> nodes to make code a bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
>  drivers/thermal/thermal_of.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index fb5472d6ffea..d277165746d5 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -375,7 +375,7 @@ static int thermal_of_for_each_cooling_maps(struct thermal_zone_device *tz,
>  					    int (*action)(struct device_node *, int, int,
>  							  struct thermal_zone_device *, struct thermal_cooling_device *))
>  {
> -	struct device_node *tz_np, *cm_np, *child;
> +	struct device_node *tz_np, *cm_np;

Looks like the remaining two pointers are also candidates for cleanup?

>  	int ret = 0;
>  
>  	tz_np = thermal_of_zone_get_by_name(tz);
> @@ -388,12 +388,10 @@ static int thermal_of_for_each_cooling_maps(struct thermal_zone_device *tz,
>  	if (!cm_np)
>  		goto out;
>  
> -	for_each_child_of_node(cm_np, child) {
> +	for_each_child_of_node_scoped(cm_np, child) {
>  		ret = thermal_of_for_each_cooling_device(tz_np, child, tz, cdev, action);
> -		if (ret) {
> -			of_node_put(child);
> +		if (ret)
>  			break;
> -		}
>  	}
>  
>  	of_node_put(cm_np);
> 
> -- 
> 2.43.0
> 

