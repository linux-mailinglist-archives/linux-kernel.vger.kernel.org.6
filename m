Return-Path: <linux-kernel+bounces-447218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B52CB9F2F12
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39E27188599B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE99204099;
	Mon, 16 Dec 2024 11:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qrK+pQAe"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC60B2040BC
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348276; cv=none; b=N6n1pO4gQ2zcwXU3pPVtpImcL0RXy7GS2mp+TwBCcH/Jxqz2KxqhWFkSJJm+92mwaM9U9kGrmso7chhzBvucXTGNKHJY8ltfMFf6rgpG/VXvP0FBMOGyf4WhCqqzZelsUWOxN55Xt4m2KWT4MBH7h44fDI4R1JuarN3yVUwZiJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348276; c=relaxed/simple;
	bh=jq98laTSDdK6EMsgM/2lFfGtgYg99v5inkJlY/nCBlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MF/yKQXgvTX2DnC73d5Ep7fnMtSMoniGAZjOjSV7LGVgQ0BvBbHbq1puuTYVOEo0S+brsIaCB2/aKydyCA/Sux7byJS0ETfLDYuonT2f7gjuht4P1rZozHklSXj009UI4LbF5JSqp0PU+OOpThYC0DMn4klezGB3D6JO+fDBKEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qrK+pQAe; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-540215984f0so4567301e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 03:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734348273; x=1734953073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gty21mjzYgvbYsbhfcrs7XMj7b14Ja6LtCdRiQMw9IQ=;
        b=qrK+pQAe+c9kkL/vzhkIxhIDevT08waFBhNaaRGLHHsIvL7XqZ/A6Fh+LR/xnlPZBU
         wF7vjOYg5m3pfspDIyfIa9KxTLs4/NBK+utvxAsyTr9pkMqbJSQlpAstnkesIIYiBQbt
         lewRwjDJyG8pdBCFX+YqFd9fKvlPCeCUlPKG+bFLP5l79yQ7jaowwgWQ+ENe+9LGJWSL
         PnfbrPep7+m5c4Wiit+eTcit75X4O6hWi4cVmsYTdaZPJrih1rSyYixANlEoPEuCVRtz
         i2ZRGy0xsd3SCo4+6eU/tDARDWp7dDAwYFc6pEUC6Pykh7mMJ6ibBKkUHI27US2SvURN
         CzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734348273; x=1734953073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gty21mjzYgvbYsbhfcrs7XMj7b14Ja6LtCdRiQMw9IQ=;
        b=Z8PGg7CQP/WCRCEA4RNan1+HJc25LQdI55gODD+qHI24fkgDOuatJakplCmTPYgWhA
         gq30PNKmYvWgXXVTs7XO6yfGLEIsFNENhW5BWdhWQsto5d57XbkTCLupx5UWGx2J+3p3
         GnIqyu/Gm0MZ4mgwZwxfNzLoQN1WDg3S5+nR0EIYx0EZe+Nl8oS0UxDjGZJD+44CIZ12
         OSNNNEE/uBGtkQZ5cMvjzQORMMFlOl8jsr4eAYmN/sQ+ZCzqfCgpHWOUdzI+Y0m0WNtY
         r9OMFJdEG4q0XAj6HoJiWu+InCeZ3WcVntrPyrBWmqnnoKWbENFPrZhV71a9OPKREKVe
         VtEg==
X-Forwarded-Encrypted: i=1; AJvYcCVYH8v0lugW8PDujwlZCmHWGR2MiKRarh5rn08WY0oXXAB1kTtEypSacs+DcoCS7crI9coTFOfbWEbjohQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTCc2hvMemWkIwa0yD8+FryXn3p8ZQvk70vch+XZi0bvzqKTde
	846kP9s29tCETDThGoWFnbmA5fpkflYFb7SmFOrh2VBLMqS5mO/kQB9kLpSjvgw=
X-Gm-Gg: ASbGncuzZyK7O0uCbhRt0zTZ3E3aGW05tsqk8nuEjggLEmi6ymVzcLhEbnWgpYZySVX
	4EKWpqOQx3y4LwafikRWiIndIsElPMeLX6GxMQhsMcpY5P1JrLP56uqE+s+pJ/xU52vrkaHQj5X
	wOm3jAoLCJSj4Z7RyIYShtprDEIlfpBADTNXKaffXxQbHzg+mPAThl/MdI7cbp3gI1VUIkBDNea
	7YnSz+vF+pZawgu/VFC3CFIEV3n/tItmORI8+shbxRcHg1sXyRp0KsGwx4QXxInNWdAo0eheSZk
	6Rdo5L2FanlPOqQNPW30KkeKUg5FjpBRFLyD
X-Google-Smtp-Source: AGHT+IHzioRjGIPfaVwEFSX3By+G0bPm5p1y4IolLwPf7YBpM4LUQ/QUZx/r1EiqpYtLRC9+8oUd8Q==
X-Received: by 2002:a05:6512:2212:b0:540:1a3f:e848 with SMTP id 2adb3069b0e04-5409054bce1mr3948864e87.15.1734348273018;
        Mon, 16 Dec 2024 03:24:33 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c1612asm817266e87.222.2024.12.16.03.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 03:24:31 -0800 (PST)
Date: Mon, 16 Dec 2024 13:24:29 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Phong LE <ple@baylibre.com>, Inki Dae <inki.dae@samsung.com>, 
	Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Alain Volmat <alain.volmat@foss.st.com>, Raphael Gallais-Pou <rgallaispou@gmail.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v2 00/10] drm/connector: add eld_mutex to protect
 connector->eld
Message-ID: <xchjpeykkqwlpniaspbzitaozuoltoq7aturtu7jq6z4lcxh77@y7t5ge2sa4er>
References: <20241206-drm-connector-eld-mutex-v2-0-c9bce1ee8bea@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206-drm-connector-eld-mutex-v2-0-c9bce1ee8bea@linaro.org>

On Fri, Dec 06, 2024 at 11:43:03AM +0200, Dmitry Baryshkov wrote:
> The connector->eld is accessed by the .get_eld() callback. This access
> can collide with the drm_edid_to_eld() updating the data at the same
> time. Add drm_connector.eld_mutex to protect the data from concurrenct
> access.
> 
> The individual drivers were just compile tested. I propose to merge the
> drm_connector and bridge drivers through drm-misc, allowing other
> maintainers either to ack merging through drm-misc or merging the
> drm-misc into their tree and then picking up correcponding patch.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Changes in v2:
> - Also take the mutex in clear_eld() (Jani)
> - Rebased on top of linux-next + drm-misc-next to solve build error
> - Link to v1: https://lore.kernel.org/r/20241201-drm-connector-eld-mutex-v1-0-ba56a6545c03@linaro.org
> 
> ---
> Dmitry Baryshkov (10):
>       drm/connector: add mutex to protect ELD from concurrent access
>       drm/bridge: anx7625: use eld_mutex to protect access to connector->eld
>       drm/bridge: ite-it66121: use eld_mutex to protect access to connector->eld
>       drm/amd/display: use eld_mutex to protect access to connector->eld
>       drm/exynos: hdmi: use eld_mutex to protect access to connector->eld
>       drm/i915/audio: use eld_mutex to protect access to connector->eld
>       drm/msm/dp: use eld_mutex to protect access to connector->eld
>       drm/radeon: use eld_mutex to protect access to connector->eld
>       drm/sti: hdmi: use eld_mutex to protect access to connector->eld
>       drm/vc4: hdmi: use eld_mutex to protect access to connector->eld

Granted the lack of reviews from AMD maintainers and granted that the
rest of the series was reviewed and acked, is it suitable to leave those
two patches out and merge the rest through drm-misc-next?

-- 
With best wishes
Dmitry

