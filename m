Return-Path: <linux-kernel+bounces-237050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EDA91EA4D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1AC11F247A9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33838171650;
	Mon,  1 Jul 2024 21:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TL55bQYe"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF7A84A3F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 21:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719869184; cv=none; b=vD2emSDc8u8ApQJPPvJiR6/X6zHvnsbDgvZqCXFrX4LNiZtNmKbOXg9/x8q7LhxeUdyOyLDWAKVol3ztdhyWObncat0iRcaygGqC/Sk/mP/zD3TJQPV4IWDXta8IoDZKA2MuvnqrcnrbPbidZzfVpnwBBHVZ4/PXdkYt16FIQ/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719869184; c=relaxed/simple;
	bh=mMRjGXKhsZYBPdgOQ/Jd0frbJACaAjCqltLha+ORcts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVsz6HRC6S72kLzvKp9qdG4caCL3KAT/dK7N5Yg2MAeaEu/cOcJx1gJJ9Kre0cF2XrtYeYQ86PvA84pDpPD9fs8p7y81445GB+WCC6JiBFIWWi5vfkY3C8twxEOOp3MF8+T3HjCycMwcuWi2aszO2B+37eP2SSYtUA4l9dedSok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TL55bQYe; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so46520911fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 14:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719869181; x=1720473981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lG+JTJvNaTsx2cpjMTyaI6tn2wbOXbE/jDkjfJHAqlg=;
        b=TL55bQYexcLJZzjJfOw+zuxvd83bJVuleb3i1ZP4jc4vLpookoDM/P5MFhJ67e6dKn
         qkbOGUm38c4Grz1X3PLUBY+r6vCHcfhzK6KRPj90C9n6P1nWz0sJZn8oKBRvOVajtW7V
         7U8kcu7ULIDEJzyxpPdmrH8HAsU4lcIE97uJ+Tz5ixQfgozJnMJIiKaY3QGuH7+Vg2FQ
         bHwOJStAvWfXblf70uOooR2hJbbBlsLdSzkTrD/qpmKHTq7SFUnYIAGHC863OeSeabPa
         Q9fqC22zIQQnDqqUycfy+13S1MmIXsVl4o4p3mb4jQspihif8YWVM1VygPQFXMwUW2Ec
         FLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719869181; x=1720473981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lG+JTJvNaTsx2cpjMTyaI6tn2wbOXbE/jDkjfJHAqlg=;
        b=mBDHeVrTCo8EMiQvT48vEBaKPpQ41S7tojBsMbj5X40P8iboMqL/3gOEZ9w47ByRcQ
         RNk3mHB3A2VF+i81MW8QFzvrLl1WgOvCzGAqpbRVAb6oEOrTdeUQR9J5SZvnzdhdN45A
         Yc8/b41Nz3CvbpeLcTzzFqj17yzL0qpJ5Guh05z//9qLpLxZAymep+FWn4h/uq/EXk2M
         w0o+UzzKap2LiU7/QKIdmh3+6KPK1XIHxnoPqxa6XgMTsaEr//wMheUZsZrzxEeuF7Np
         Ca/TrakTr745Uk0+9ofXPM0Ee41XKYoGwdXmGwPHTRwrWo7p1xvHDthmuuTlwNPciLCd
         j2Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXX2XnSvyqm8bdJEB12MATqRJvexzZ5tqxkdXjVDNsyv6yw6Ni++Dw6Q6IsI7lQVxcWekvMqt1rT7JwiBrdMsmWfdFFvxM1t4YctSiT
X-Gm-Message-State: AOJu0YyABWM2dm6I/+CMc/xYfTV0lp7MCeKdEd9TcYJDwGb0l/NUnJqq
	HmFsQ/SdsRfjIJR70OdZDErKWpT+Hi4HlAa9RvradKqaJeUkymrmklrSAZyNf2k=
X-Google-Smtp-Source: AGHT+IEOaI0UGr5D8W4vE8UUdTiDNkZ7ce5/GmxI2Bt3GxosQ91A560A6XtUvaXsnfS/pDrDtd0Xpg==
X-Received: by 2002:a2e:7c02:0:b0:2ec:51b2:2cb6 with SMTP id 38308e7fff4ca-2ee5e3754e4mr40498301fa.27.1719869181101;
        Mon, 01 Jul 2024 14:26:21 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee6a86f339sm5528391fa.6.2024.07.01.14.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 14:26:20 -0700 (PDT)
Date: Tue, 2 Jul 2024 00:26:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Adam Ford <aford173@gmail.com>
Cc: dri-devel@lists.freedesktop.org, aford@beaconembedded.com, 
	Liu Ying <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] drm/bridge: adv7511: Fix Intermittent EDID failures
Message-ID: <4qarlw55zijv7vgl3q4t4cvxlzjeql4cr5734bgozhc7ddc7q2@2f3wis3c64cq>
References: <20240630221931.1650565-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240630221931.1650565-1-aford173@gmail.com>

On Sun, Jun 30, 2024 at 05:19:31PM GMT, Adam Ford wrote:
> In the process of adding support for shared IRQ pins, a scenario
> was accidentally created where adv7511_irq_process returned
> prematurely causing the EDID to fail randomly.
> 
> Since the interrupt handler is broken up into two main helper functions,
> update both of them to treat the helper functions as IRQ handlers. These
> IRQ routines process their respective tasks as before, but if they
> determine that actual work was done, mark the respective IRQ status
> accordingly, and delay the check until everything has been processed.
> 
> This should guarantee the helper functions don't return prematurely
> while still returning proper values of either IRQ_HANDLED or IRQ_NONE.
> 
> Reported-by: Liu Ying <victor.liu@nxp.com>
> Fixes: f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to share GPIO pins")
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Tested-by: Liu Ying <victor.liu@nxp.com> # i.MX8MP EVK ADV7535 EDID retrieval w/o IRQ
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> V3:  Remove unnecessary declaration of ret by evaluating the return
>      code of regmap_read directly.
> 
> V2:  Fix uninitialized cec_status
>      Cut back a little on error handling to return either IRQ_NONE or
>      IRQ_HANDLED.
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

