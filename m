Return-Path: <linux-kernel+bounces-340069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DD4986E43
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4F2F1F273DB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2336F190686;
	Thu, 26 Sep 2024 07:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RbtTUJgA"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91B018FDBE
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337188; cv=none; b=q0J27fkVSFV9dJ2HZb0mj4iDOHSw0nF+12E91qh0KISxckAAEryMIFohtMH8tuLDeMRoutrXaCQZaZ0QOSZwlQkMNvCOnnkPf8W0d+CqvwuiniOLU4aH9nq0BVjtecPfC4gGBEBWY+g6f3ychVwrqiGDVMSekiMvtN/5DIStxqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337188; c=relaxed/simple;
	bh=1isdw3Q+5vpMfyqZnU66/fL378h9AFsRhVFHMPQjf8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQ7/xCYVPJ3S8t/6x8ATIgwf2xwNp6Q9BlSx0SIJ22FSSKkEQI4rRYSoErsWmLXnpf6BTfenWoTxf9YaozkHA7vh5aafucEDElEE7gn1+ny4Uo3JjrXc+L60LPZs5cTHK0csTrOT6ygxOxAWS1cdnDgRz8f4X4kfF6Q2dyPfJ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RbtTUJgA; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f75e5f3debso5955021fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 00:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727337185; x=1727941985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4fBsPek7VpeTc/nJeOEHwHry6rvfWUqED/90OQk7PRY=;
        b=RbtTUJgAGKs6E7yEMRdLBHRAMyqP23EZw1KbF43QUhJht/Tr3ylIotA7Q2nXHKeSyM
         cMRmhSR6bFS5EY0eyNiK7MkuL58DhcEEg6NBjHk2i8r1oTxfRoaPXezKOs7ObZ+C2ZzQ
         xLcgLkU6FQNqo1NWmb1LVOnYaLDd14oGrOVYkyvHH/WYA//WPdrsSYbxw+JkGImSIhVZ
         OJLaYoyzaeKen0OMO6P3eooZCwMUTzA4/LhJWYt6tQpa7Naw0vHhYfO8X+NkCfXNJtBr
         cqp0WNsI4B8qsIE9nXnum866YUb7jfxZcYc0vjBLODyCySuOx7NJdtcszRftIEwVggvK
         i+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727337185; x=1727941985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fBsPek7VpeTc/nJeOEHwHry6rvfWUqED/90OQk7PRY=;
        b=InHzgqrCDvnrXOHzE1i4MkDOmeHDUjXvX4XW+DmrzmiL8vN/GGAKy+Lbu57OCo37xX
         bp7Ofjc/35wIazfiCL+gf0utDwgrqV8JYxmO7K8J/UXlH8dqBAnLeMFXCGmkDAifhmZU
         4G1SMtAxfxx0aF6WVUj1zlxmFJ6E/gY08LH4qkRFtASvJDqQXoSkZDZxxlTE0umauvcF
         5iEfmO3BEYYW6oK5LaC7ZqJgREq+vTdmu7Z7+0PX9UUqNc2hrLPbcBwjcSgBMbpfR2cF
         om3Rs/nYIOpERfU37igt2vxPJThtyueivDQOmrC0LCWQ52zO8qGttRmVgTrJDk7HMuxD
         KkoA==
X-Forwarded-Encrypted: i=1; AJvYcCVlNAa14ih7/jVK/4ccOJcdRZMydUqmny5PPApf2DsOdNmJebCKt+taGBFYGtqmGJoe/v+g2ukz089LO58=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4uK4tLhYy6hkQiXofjpwebgolcLr5nl0zz69wZC699oREAaM3
	hCV7R8nZTvfdfX/+65mkUua4//KxySFg29TVc1HpciYqpsD9+OqZqirC9KSW3uE=
X-Google-Smtp-Source: AGHT+IE90oRm7Z3WEYstxEPLQwp1iD/xSK5xtMm1LC1hvJbkgsWGy6uGFmf7VRb6dGqjmbezndOOtQ==
X-Received: by 2002:a2e:510a:0:b0:2f7:5f6e:d894 with SMTP id 38308e7fff4ca-2f91600c868mr25456061fa.25.1727337184641;
        Thu, 26 Sep 2024 00:53:04 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d289f159sm7435071fa.128.2024.09.26.00.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 00:53:03 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:53:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Hermes Wu <Hermes.Wu@ite.com.tw>
Cc: Kenneth Hung <Kenneth.hung@ite.com.tw>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Allen Chen <allen.chen@ite.com.tw>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 02/11] drm/bridge: it6505: fix aux operation for edid
 read
Message-ID: <ngr25a4x3s6hd3ztmj7h5y6zp3fxw3ojm4ax5wpk45iqdfkvwe@piznnnlyudmv>
References: <20240926074755.22176-1-Hermes.Wu@ite.com.tw>
 <20240926074755.22176-3-Hermes.Wu@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926074755.22176-3-Hermes.Wu@ite.com.tw>

On Thu, Sep 26, 2024 at 03:47:52PM GMT, Hermes Wu wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> The EDID read operation can reach the maximum size of the AUX FIFO buffer.

And? Commit message should describe why the change is necessary and what
is being done. Just providing a statement is not enough.

> 
> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index 28a8043229d3..b451d3c2ac1d 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -1078,8 +1078,11 @@ static ssize_t it6505_aux_do_transfer(struct it6505 *it6505,
>  	int i, ret_size, ret = 0, request_size;
>  
>  	mutex_lock(&it6505->aux_lock);
> -	for (i = 0; i < size; i += 4) {
> -		request_size = min((int)size - i, 4);
> +	for (i = 0; i < size; ) {
> +		if (cmd == CMD_AUX_I2C_EDID_READ)
> +			request_size = min_t(int, (int)size - i, AUX_FIFO_MAX_SIZE);
> +		else
> +			request_size = min_t(int, (int)size - i, 4);
>  		ret_size = it6505_aux_operation(it6505, cmd, address + i,
>  						buffer + i, request_size,
>  						reply);
> @@ -1088,6 +1091,7 @@ static ssize_t it6505_aux_do_transfer(struct it6505 *it6505,
>  			goto aux_op_err;
>  		}
>  
> +		i += request_size;
>  		ret += ret_size;
>  	}
>  
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

