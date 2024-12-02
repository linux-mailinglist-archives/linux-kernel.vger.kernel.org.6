Return-Path: <linux-kernel+bounces-427305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30829DFF98
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E7F28188D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7087B1FCF78;
	Mon,  2 Dec 2024 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IDsrlJbD"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114CD1FBC8B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 11:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733137397; cv=none; b=XzElrLNZoUJGHUeBlj9bA9l1Rrx6qYOowOXCS3FIP3T4HxXavlCQ2h4AhFIuR5no/KfdwelIhyJTkxPN6LWUw/6pZXU55PJUNwsizQFwfzXeFP9SYRTghVXuiKMx4JJouoWp+d8xQvh8l0riHBEHU3TgXD6B8ulq99thdzzj96E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733137397; c=relaxed/simple;
	bh=mM8Ty9zubi84Tu0ptmDRpums5gqswtEyzEignt+0538=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5hhRWwaqMykUMEsshsWCoBWi5dvAltPtTo718/qMPSQXZMYs0W45KOgiOZWvhTe81SKwY7153+jf/QGxoUAzB25O4BLmwSmytdxLqIMolsQ5eV8SZR5qD3nzTKdYe0tGg8TqIkTQsF1et/Z8QSbmCTg3Cmt+MByONtRLsdpo04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IDsrlJbD; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53de852a287so4604013e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 03:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733137393; x=1733742193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6X4f5B7p/4ISxO7icMRqa8h5IT36sTqoFNtM1b1oYjE=;
        b=IDsrlJbDff79X2j55Ye6ngR9Wa3zOFgJjfpt3jK4Q02vAjkiUUQxO4Aga2PQ9/7Ol5
         XR1EJQtCpWKz4DQ1FxtHPHE3xjp3Hv2No0x5t5j2KYT/4k4bjHmRA7yEJE64BPigYEBZ
         NiEjZCW8liPAOrVgkje9OTalgmS7OVTnySgzQlxipWXak6QsRwUv85yW/HHMwLZ7MSEl
         Y/ZAeOa1fBHCv9fdx8YLK/sCzak0FMrOGbJAWSlfOtWGUUN2NdEIAle01a3DcNo+ThxW
         I9YDzf3i+4eoV33dhY2ML4kbaU8+n0NFpLK5SnIhb9a8+/T3/tWbOLYmY0uocQr6U4cI
         uenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733137393; x=1733742193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6X4f5B7p/4ISxO7icMRqa8h5IT36sTqoFNtM1b1oYjE=;
        b=j1VZ5WRO/cGylbbnK6C9nngAPLV6BaUjM843mlnBcq++d7hszba0GRaSNJCAKAReSA
         UPZNoz2CpI/pnb4EvBRJ+Fny3Q1GzAjTWQf5Qc1BNRd8TfEmnD3xqbTAvf6WhYQkC0od
         EffKRj01uLHKea/Wuj4VwZ0THKb+hMXmPVo74erw2clp2s2WOOF1rMh4+nJ6uvotC2Sz
         7pAHSqG2+5ju1PONsXiRhpi0He5Kmm6Vz9IsvmNgwMoeSGyEBCTEQDoQzloQVhMValXm
         bsMUrTX3KIEaaHRHjWJDBHCS/CejuKHMTxsRbIevkjfwVEKuuanhFLRytZA/gUy7xhsQ
         1yiA==
X-Forwarded-Encrypted: i=1; AJvYcCWwxDLkDbmHuq2VI8Q1oZXWC9LmUzo8UONnL13m4SBy4nf6UwwcpejFOHNZBVoEN+EROnjrypvNfBQiqDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YygP6hDe+UGBvZjVz8v6dYWkf1RdQ38wa/huiOGowqNW0UtbSXH
	ooiOfcjGreH3cT1M4TvW+feU2trAbWxCpBx+3Xu5zd8aYVorhHXSRC2omUrGmms=
X-Gm-Gg: ASbGnctMvCXDFVKdu8NfZmR3VzfOE42PsmGweiXV0cjjKRncnwkdyQd3tqXRNtLe8X6
	252wbcq+GT4KcRS1q0rejOqJ+yp/gQa47I6Bit9H+IKzaoTxU0d/BsbQ6UsNAuwBGFbk/mWRYwW
	prvZ+i0UorPFow3YvPJEXXRXO7q7TC7L7aDc7N9GLmM/XhlVRmYkuMKoVHdONe7oIDQxBjm6wmf
	jGrSi4v9BgTaqMaVi7Yy4yOoWXAG9PMye415O2S5MIwYixN2Zcg3j7FQJkhnv39IHzDRxEKP0lG
	lvP4DXMCpGXMK7rTCYB70RIUodmjcg==
X-Google-Smtp-Source: AGHT+IFGDFefBhtw1PCqTOI5KhQIlj3rWjRnFP/b36RPBBTJEaQRx6orQjZk5ZBCQurK/QAedMSg2Q==
X-Received: by 2002:a05:6512:2385:b0:53d:ed25:fb75 with SMTP id 2adb3069b0e04-53df00d3e65mr7699888e87.15.1733137392309;
        Mon, 02 Dec 2024 03:03:12 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df646efd9sm1443877e87.143.2024.12.02.03.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 03:03:10 -0800 (PST)
Date: Mon, 2 Dec 2024 13:03:07 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Alain Volmat <alain.volmat@foss.st.com>, Alex Deucher <alexander.deucher@amd.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	David Airlie <airlied@gmail.com>, Harry Wentland <harry.wentland@amd.com>, 
	Inki Dae <inki.dae@samsung.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Leo Li <sunpeng.li@amd.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Phong LE <ple@baylibre.com>, 
	Raphael Gallais-Pou <rgallaispou@gmail.com>, Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Rob Clark <robdclark@gmail.com>, Robert Foss <rfoss@kernel.org>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Sean Paul <sean@poorly.run>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
	Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Xinhui Pan <Xinhui.Pan@amd.com>
Subject: Re: [PATCH 00/10] drm/connector: add eld_mutex to protect
 connector->eld
Message-ID: <ohbtatnn33jj6y3q4milf4txi4n7yirnny2eefdjddlkn2dnhp@eqjedetct4q3>
References: <20241201-drm-connector-eld-mutex-v1-0-ba56a6545c03@linaro.org>
 <77545786331df8bfaf5fdcb309437358@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77545786331df8bfaf5fdcb309437358@kernel.org>

On Mon, Dec 02, 2024 at 10:19:41AM +0000, Maxime Ripard wrote:
> On Sun, 1 Dec 2024 01:55:17 +0200, Dmitry Baryshkov wrote:
> > The connector->eld is accessed by the .get_eld() callback. This access
> > can collide with the drm_edid_to_eld() updating the data at the same
> > time. Add drm_connector.eld_mutex to protect the data from concurrenct
> > access.
> > 
> > 
> > [ ... ]
> 
> Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!

I'm going to post v2 to fix Jani's comment, but what should be the merge
strategy? Merge patches 1-3, 5, 9-10 through drm-misc and the rest (AMD,
i915, MSM, radeon) through the driver trees?

-- 
With best wishes
Dmitry

