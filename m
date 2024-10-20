Return-Path: <linux-kernel+bounces-373267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCA29A5473
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 15:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F15C1C209E7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D09192D6A;
	Sun, 20 Oct 2024 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X2nKUiBs"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E50192B9E
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729432498; cv=none; b=u15sCzv28d6OSG1emEgyezY7WG+DtmAf8eRZI1cR3ukGTRyDtmuCyiWVwP/+3DvlXxdRyI+QfKvc/861mqOYcD1ZgLr7UPr/8nlxrFpljxRhkgeLrsVEYSTNyD3EeAv8JTwZ4xf3EMUwhRL+CVCzbfk2MTw7iLHbI3gQpp7CIcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729432498; c=relaxed/simple;
	bh=SrYXp9M7SacqKvFP378O+xV/tzQS91EE7kaoqNxIQ20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDX0iQ7mF/saMjJkbU9AofcDjd5oC8+BVghZl6iG6y57ReKAEvo0Ism+4DLfpKQ72ngVoLinlsEDrNtwi9ZkhyISvxG45bI48QVBXhZzdrz7nxtmUhGzZEHxG4cusdrBAIU2JAIiBjWshSTq1ToC9yLW1nRY5qFwkBg1/udoSpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X2nKUiBs; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb5014e2daso36173251fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 06:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729432495; x=1730037295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T0qkFQv52MaG0flixd0cDZSqCxwmqX/oMwO94T/ae90=;
        b=X2nKUiBs5B6mPm8qMWIRK9VR91Ng8+k3fDM741OXFfTkyZxsY6Tm7aju5k1aHIe8B9
         a1l8J6rGDWY7eh6wgp63bZqvltEzdaQYeW5mpiBxsBSv3VBxkP11wM51SPfUax6KhTr1
         Bu2qG1nkqLxvedvm20IJiMa7DpN+uQXzkn9XMCWXAT22nkIpj0LRe7iz9iH+AsbR46By
         1brj2jqdzclmztC3QVmROXYLq9uWBpxdw+9iZuuKsF5cmMk7+B3f6ULAlg/jdVDK43hR
         XQfSU9dT7exewCNnYT5HMmSEnhxXNuROhHLjoCech7by6yRCjf6xoMZ8pR8asd/HVlGs
         ughw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729432495; x=1730037295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0qkFQv52MaG0flixd0cDZSqCxwmqX/oMwO94T/ae90=;
        b=lLALy5juF3cxjmCURqsmc+F8PjZOrVROpmXnuUJ2Phxt8T3d7YTKt8xvLnLNsWL3cy
         Was0Z5voMdajWkYFrARuZvv7/lcNWWqqAYMbtJxzsCC/elAN+iQTHb0BEt+JZkIw7Efo
         A2uUtF2jiFnoC6DPEdVv38iyAC8Fj/kmIKFtLigha+MmLFoWNHZCQIeQ4YpW66DDqqvF
         bB67KsKql/l/HbeotnQMNlyanGtnKCJSJE8aRlNAdn+Ek3mxyhgVYJZEywx8/l0oD3be
         aF5MDm59Q0qvlvPKLj769isgC4kc0KcMowpvhDPn/vJSKimVYlHj4REceFKWHUjIR3xn
         Toug==
X-Forwarded-Encrypted: i=1; AJvYcCVXYKIhGMP/xi3GEqj3EsScgiWKXP+0sqF5HqPVXqq+FDe3X+4YnPz2AyAHyTj6EkePsJRbJC7lR4bXePY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNtHa4Wxe9703x28/gNHlMUEFZ7LfPt2x3sDqlcDWorsb8+U7E
	U9JlRu4yIHnS5fZNiDmm9NR3U2YIJQxynLMLOJpTiXqUIqyckU2RRBYQ+aAt2m8=
X-Google-Smtp-Source: AGHT+IGDStdGKgyHv3SXIy7e4+EzWShj2sn4w9wUPHCPBaolRgoB037SeyWy5j9MZhh6/oL+pTHWsw==
X-Received: by 2002:a2e:a78a:0:b0:2fb:8df2:13e6 with SMTP id 38308e7fff4ca-2fb8df21412mr21354681fa.26.1729432494574;
        Sun, 20 Oct 2024 06:54:54 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9ae24b58sm2366511fa.128.2024.10.20.06.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 06:54:53 -0700 (PDT)
Date: Sun, 20 Oct 2024 16:54:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Hermes.wu@ite.com.tw
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Pin-yen Lin <treapking@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Kenneth Hung <Kenneth.hung@ite.com.tw>, Pet Weng <Pet.Weng@ite.com.tw>
Subject: Re: [PATCH v6 10/10] drm/bridge: it6505: add I2C functionality on AUX
Message-ID: <kiuhxqulo5eatymma25k7za5ca3pjaof436poqhy26tlyatrsq@dez6joc7gddv>
References: <20241016-upstream-v6-v6-0-4d93a0c46de1@ite.com.tw>
 <20241016-upstream-v6-v6-10-4d93a0c46de1@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-upstream-v6-v6-10-4d93a0c46de1@ite.com.tw>

On Wed, Oct 16, 2024 at 03:54:22PM +0800, Hermes Wu via B4 Relay wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> DisplayPort AUX protocol supports I2C transport which is capable of
> reading EDID or supports MCCS.
> 
> In drm_dp_helper, drm_dp_i2c_xfer() packs I2C requests into a
> sequence of AUX requests.
> it6505_aux_i2c_operation() is implemented to match drm_dp_i2c_xfer()
> operactions.
> it6505_aux_i2c_transfer() adds I2C functionality
> for it6505_aux_transfer().
> 
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 177 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 175 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

