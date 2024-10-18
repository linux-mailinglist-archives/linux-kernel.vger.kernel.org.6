Return-Path: <linux-kernel+bounces-371969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB489A42BD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 535BFB2232C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CACC2022F7;
	Fri, 18 Oct 2024 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rxFFjm9I"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A8C201267
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729266196; cv=none; b=RMNA227vesObqs0lwMqg8qwUtreeKw1kVkgnEy3Abum+R/0/HMlDYp8ruA7npStVEsn8RkAvcujoZbml/NFAjGxgqScXCO2mj4YlVNSqzj2ievG1uYvAq/NeG/ZBocHh78fUwb/BK6k8ra8ZKX6Co1iufH4YN38Nw5ZKFeA6ruE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729266196; c=relaxed/simple;
	bh=yrAJt130zhNnFNLgz1MFQ6eVo/8vhXTxPNhNHqInfis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJ+Sn+p3kL5CftT0tHlDQq1Yf6HMwlXZeWlWlGngJf9K/O1YrgV07CQ9myajVdznU8QGCQ22aJXNQhHjhNo8hM2tyDn9ANrqz+HjKxI8D3juJyPh/sXSNJF/UyEL4dGEuK1OCTn3JWeFunNWoaq35/NaZfsaL2Fix4259Xi7fmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rxFFjm9I; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so24649611fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 08:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729266192; x=1729870992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i/v9F36+wCfWTJvKnnFi5Fi92/EQ/UbzdjUVtyo+GVs=;
        b=rxFFjm9IBPOL8gYxlMWDFcanXjgR/FgmouEseT0Q7VfqaJp6rNQu8V8m4FD5OoWA89
         ZoXYK2fgvp6b1j+nNZEDvqAF4u3n6YHR10DlfkoND7+YxC+vBxiGeUwssBK1Y1IWZOgo
         lh5SbEBcxR2fNIqeqhoz5ncYwRbo/E5yYbY7pgcnEwrb3Qrybkqp5rLvOeo+8W9nAUDp
         e55AAGhlJ2CxCuKwnSEtUmGAuz5wbVZl4Y2BLuV34gI4IDuD7gvHFqE5Jnj3lpt+FJA8
         Q1wrZSlx8NbJEtGvfScPdnkIC1c+B3HI5HcuUr2m3ObcTmo8IJ5qxTw3bh6kYRcGI94Q
         J0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729266192; x=1729870992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/v9F36+wCfWTJvKnnFi5Fi92/EQ/UbzdjUVtyo+GVs=;
        b=HSVm4nRmfwBdrGFuec8AD9AmFlyj0sDClXJHu7M+AEVi+oi9bRipvNopmiJ8nerdVX
         B/tLDu4r2heykwukVaRkquGWDeDG47Lz2QmLC+URGPPlxjGKkLIcWQBI2DpZ7MdN8IS+
         JJ89Z3WQ46WAETdVIzSSwvvvR9peYY5BFCauTQDKfNGBphLuRzcN4poecIIo0e7BxHUX
         TQajtFhFZmMomMOkxorGNXWi7pXsoFSwif/wU0UcFgZWymNbMh6mzh2lV5dojHGwu3VB
         HTO7SxCtesR3c6a5/GbsVo5iFB6assdHJkk+apxw8MeULI0bTa2PVoIT/TGkNTwR8pqa
         RZmA==
X-Forwarded-Encrypted: i=1; AJvYcCXhcuy+xuj1bpHwEE5W3e5UCx57pUvNJEuOiU3z57gBeVBgAeGaGDT1J6OW/5FMfVZL0pEz9L/F/GbYuS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH7mfJdR37fWv1VlS3NxYR8lKarBnjPhQzK3vmWIhbaYxnAJqc
	9lwG0syQFcXeNfmDuioTFKy4CbSVUIRMF6VfBPdc22+tyHBbnykVNEnk3y2XiWw=
X-Google-Smtp-Source: AGHT+IGPiDRkwHnl+SqRQmTMCADDN4QAteA+dBcwkasQ1KTbWV4DVUcPcCzqNj5AV25OW6qHaXwpQA==
X-Received: by 2002:a2e:b8d0:0:b0:2f9:cc40:6afe with SMTP id 38308e7fff4ca-2fb82ea23f4mr18378251fa.14.1729266192256;
        Fri, 18 Oct 2024 08:43:12 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb809bb125sm2247151fa.69.2024.10.18.08.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 08:43:10 -0700 (PDT)
Date: Fri, 18 Oct 2024 18:43:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Johan Hovold <johan@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: Fix assignment of the of_node of the
 parent to aux bridge
Message-ID: <ux2lfkaeoyakulhllitxraduqjldtxrcmpgsis3us7msixiguq@ff5gfhtkakh2>
References: <20241018-drm-aux-bridge-mark-of-node-reused-v2-1-aeed1b445c7d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018-drm-aux-bridge-mark-of-node-reused-v2-1-aeed1b445c7d@linaro.org>

On Fri, Oct 18, 2024 at 03:49:34PM +0300, Abel Vesa wrote:
> The assignment of the of_node to the aux bridge needs to mark the
> of_node as reused as well, otherwise resource providers like pinctrl will
> report a gpio as already requested by a different device when both pinconf
> and gpios property are present.
> Fix that by using the device_set_of_node_from_dev() helper instead.
> 
> Fixes: 6914968a0b52 ("drm/bridge: properly refcount DT nodes in aux bridge drivers")
> Cc: stable@vger.kernel.org      # 6.8
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> Changes in v2:
> - Re-worded commit to be more explicit of what it fixes, as Johan suggested
> - Used device_set_of_node_from_dev() helper, as per Johan's suggestion
> - Added Fixes tag and cc'ed stable
> - Link to v1: https://lore.kernel.org/r/20241017-drm-aux-bridge-mark-of-node-reused-v1-1-7cd5702bb4f2@linaro.org
> ---
>  drivers/gpu/drm/bridge/aux-bridge.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

