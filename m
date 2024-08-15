Return-Path: <linux-kernel+bounces-287513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BACA9528A8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 06:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F7E6B23474
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 04:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D331E3FBB3;
	Thu, 15 Aug 2024 04:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Llh/s1xx"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEF938DF2
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 04:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723697301; cv=none; b=aok83vKTEKY313ryArQu3HpTqd4Wyqb4uWC/XOsMG+ilGQH7URWApZ6glxMm+sZRPY7GMBA9vBBoX3bwum9unGIOGTVQK5W5jODKbNVsIE7zVb9119KPQBAL3fQIy5T78sL1dJtcl9oScDHO6o+7tRaNVxROPXPxLhKwS3vb0tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723697301; c=relaxed/simple;
	bh=1H8OSJlJ5N02+gXkYla/orQDMo/rMWVcoHt8snd/BFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBbN5V10Goh5+nQ2xNNFll7IDDvC/JbHKj/Ofe9OWhdJO+Rrs96gJr9cimYWtgfRm4Z3qRpKPAbtcUNMP364vLZnlVp4PWb3j8IgmL/vMYEkuer0++P9yHi8740BXLFLvDtw4BDMo0P5DDsxsxGaSsoGs2F8p/VaIkIQY03cqy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Llh/s1xx; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-710d1de6ee5so480886b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 21:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723697299; x=1724302099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/hmiS/G0zKAC5tA9OzOxytrtCGZMWxkCbcEk10y8Ir0=;
        b=Llh/s1xxcFTDiSx+c+Y2xt/dW1sHZniqBxcFg7DkO9kc06Vc5NG7p/Yh0zFzbctfRL
         Mrw/n4SoRlKArZmDhJw9q2N+6oxkR6k+UdxfsD76kNaBe5Bq/DTUJ2A+MRZlKKtoS5B/
         lTQ2865e5zzXSJP/Oy2hvdK0Ha/Aw+QoSZmXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723697299; x=1724302099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hmiS/G0zKAC5tA9OzOxytrtCGZMWxkCbcEk10y8Ir0=;
        b=QtAWJlDWJirVcho571jw6gfF31APdY0ZRMYKaVbt/YMc++aelW5oey3IEuYtwDdL4w
         hqCMAu42X3ef4BjmV69Ketn0m0/MYl5SLTLmt6H2/c/uF9qc9wVXL3t7oMd1ZDpUzgfp
         9mRpadY1IvYrBSVACOyU+hmkBkufpoNjS7qcjg9D/NfqYmx82cCFFQqCgiBAu5uTxBq6
         UDXK5Kb8Kct/VGxlddwIuLxz6Srn9Umf1V2FQwl17mzM6Wc53+Ge6U9XTMty7fUxt9EK
         xJ7g0nlXhbz+cCZl8TOST8Ml/WEuNJAUDtu/yumdVjjG9EpQu7YR4SZEFBo7jTWCXkUG
         E/fQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+lNFLoUOx5LAPD2ADI1YVdBzTy0NOpPsXiL1pgfb0pkzinWgRcWqVrJJdlAktGDRxhAxyoRKvES1EDPJndnzG4jhthTn4sRZbwO8w
X-Gm-Message-State: AOJu0YzSV6fGExV7KicLo5V/Ipdb5AuoKm7jdPfRjCwWyBHOYPqohL69
	lzwyXzom+cwh3nDknB3UaBV8fUDXiO6JFfwfYDn+p5OzEZ9UG/j53T2LzPHAAfnd0KVN9DageFY
	=
X-Google-Smtp-Source: AGHT+IGx1lP4TlGrHuh23iB/99xzj8kXmWkUac5JJk27ttUx5Ghve1MQJhTg2y2w5CMBWQpQv4QJXQ==
X-Received: by 2002:a05:6a00:198e:b0:70d:2892:402b with SMTP id d2e1a72fcca58-71267101635mr5313447b3a.7.1723697299019;
        Wed, 14 Aug 2024 21:48:19 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:745d:58f7:b3cd:901f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae6c0bdsm383551b3a.90.2024.08.14.21.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 21:48:18 -0700 (PDT)
Date: Thu, 15 Aug 2024 12:48:15 +0800
From: Chen-Yu Tsai <wenst@chromium.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] thermal: of: Fix OF node leak in
 thermal_of_trips_init() error path
Message-ID: <20240815044815.GA255011@google.com>
References: <20240814195823.437597-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814195823.437597-1-krzysztof.kozlowski@linaro.org>

On Wed, Aug 14, 2024 at 09:58:21PM +0200, Krzysztof Kozlowski wrote:
> Terminating for_each_child_of_node() loop requires dropping OF node
> reference, so bailing out after thermal_of_populate_trip() error misses
> this.  Solve the OF node reference leak with scoped
> for_each_child_of_node_scoped().
> 
> Fixes: d0c75fa2c17f ("thermal/of: Initialize trip points separately")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
>  drivers/thermal/thermal_of.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index aa34b6e82e26..30f8d6e70484 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -125,7 +125,7 @@ static int thermal_of_populate_trip(struct device_node *np,
>  static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *ntrips)
>  {
>  	struct thermal_trip *tt;
> -	struct device_node *trips, *trip;
> +	struct device_node *trips;
>  	int ret, count;
>  
>  	trips = of_get_child_by_name(np, "trips");
> @@ -150,7 +150,7 @@ static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *n
>  	*ntrips = count;
>  
>  	count = 0;
> -	for_each_child_of_node(trips, trip) {
> +	for_each_child_of_node_scoped(trips, trip) {
>  		ret = thermal_of_populate_trip(trip, &tt[count++]);
>  		if (ret)
>  			goto out_kfree;
> -- 
> 2.43.0
> 

