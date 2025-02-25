Return-Path: <linux-kernel+bounces-531288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98817A43E9F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD56D3A968F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2A4267B1A;
	Tue, 25 Feb 2025 11:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QdASPCFm"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779DD24EF9B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484661; cv=none; b=NU1kE9y1ltLovV8G9ySJUP29DjObo5G11oqovuzEwlw9N8SM2n5mzjYPvL3gQ5t1f/nKbzwIlWbRyUtKyF/UUzXxTz0LXY3PNahHSksqYkgXJNngejaJ6tzKMETV1nfKWqKkV/wDF93QEoVbkdEZCOcrxwCE8AF5hNHjKneDeSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484661; c=relaxed/simple;
	bh=0ejaQvRgvD/39Cpjo9LWMBffWmj8mem5cTlbNfG0LaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6LybF/ME8waLGYQ5XMYogt46fDyuOASGq4ODzQ2LiXYXMqniHXTWArJzzOL/ywJDJh48rFttmLYTidFjjTEpSogeNjIzAvagsYaKQKfjrCsjoYACvusnPOn1ROsbTOeqG1o78szwKeyNfNmz6S4lyl5i0J/uH2gm5ujGws7hKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QdASPCFm; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5439a6179a7so6124474e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740484657; x=1741089457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BJdxb9d2Qc7/mEkgivvxiQHCCJjZY2RUEpoG9MQvZUI=;
        b=QdASPCFmvY0kmiBGFkfLYbccilBrK/x1p/YrUfUijy9lOZsV8J2PugjpT/T+E9UA3G
         O2p2rQ+XGfu1eEIwuKTVLbGqsxgUErD6aTqUqKt+nw4P93gOKFrsRZWD/8LEgOkg0wL6
         7cmpVuEMMHg4/7LBmMaBHXHuDuY+CBe5Y3zyY4KPv6/cXMVcXSmsa2EkjJZW8DgAcpcw
         /0dfwpRz4yPAoVNw+3DmUf/DMiIzE9bOyHE7S1R3tAyk+N3L867M2hVEd4mARY5yNYjS
         H28nFe10GNUrxCdGVI3rkPCFdLP+/z3G5POkfBBg+q+X0WP1ouj+IyNVxHuDUWvLtIM4
         PhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740484657; x=1741089457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJdxb9d2Qc7/mEkgivvxiQHCCJjZY2RUEpoG9MQvZUI=;
        b=kas1hE6EWwiApLiM6xSQiSf+5MO73SdAIouXbsN3ismApUVzYIbRvxwPsNi8za3lU5
         SUgPiHq95BptehVOKbSgsyLy+mEAMcyrFulDygaIUl7izvwNpepxSHTN+5k2cVmo8WXC
         3vjayRWL0tZn/kPW9sLNI1/aKYI8HYAtI2OcVqxxrVjJVPi7UnPr63D0AQQL+n13HZQf
         Zc1f3FDfemiScRc745OrJpgyLdYa8RBp1IQwemEVvXccwaHyEG0pmfltI5TPvP7szAjZ
         PklhyaN4WLqsTh9dpWcRAqcsmjuEOguTCvhdtRxkzjQfoFGoE62hXNRArARnZ264W/xv
         9NBw==
X-Forwarded-Encrypted: i=1; AJvYcCWtBgEIKQmQV2fmJ3U2mmHmztJ6NVO2SSBkdzwHLkU2/hkeDkOOXXKPWz7lNuAjQrDAkwle7HekMmUyh2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz80A01NY/OqKYCb2e7oz4IRae3kHEpBL35T4UzwWTvZ+wwxrwe
	elcdsf2resJ3Rc8onrUvlBYaGTcUwpIYe/mIDcdsCfisIQamvDap4iqUPIlNNek=
X-Gm-Gg: ASbGnct2KDggIXn8waplrf7NHHXyRdlwmBYFpH1XXOwHdOuvr8sjygdmh0oT0tMhX10
	7xzRs+v4R5GXJenRCOqziW6u8Km+PU8c2OfXMGzx0TmVdAmarIH2N7SpiBVYf8y494NlAwOv0lT
	FHjBhfcFIwPiP2/RWDG/lDroCX4oJ4jibcYLtYsaOu/97NSZcW6HSYMMTd1uSCq5z3Aq4jsxW3P
	gGJN5gOAPnnEgts0HegsdQMwIDq1LciTgl3yx2LqxBnWgY5fK/SXTmpeXwr8jhk0UuVjEluO893
	M6cUrDFRqb2J2o+4snnFjQoHS1C/g0Y/nsoJ7YwpJ6AvQbgZGZvJQ31QqEwf//KfTqz9+8lISKk
	/M7Rkiw==
X-Google-Smtp-Source: AGHT+IFbqdYh8fwBrlR0bY7/Z36QCpnKteDFdIRRsnwu1FwaNfeJZqynpnHdLJr5tV947+xq6nGVtQ==
X-Received: by 2002:a05:6512:280a:b0:545:8f7:8596 with SMTP id 2adb3069b0e04-54838cb6287mr5705354e87.17.1740484657548;
        Tue, 25 Feb 2025 03:57:37 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548794c6a73sm95082e87.250.2025.02.25.03.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 03:57:36 -0800 (PST)
Date: Tue, 25 Feb 2025 13:57:34 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxim Schwalm <maxim.schwalm@gmail.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] drm/bridge: simple-bridge: Add support for MStar
 TSUMU88ADT3-LF-1
Message-ID: <lkfxsq3daspjxdw43dofch3nulprpmg4soxsgflsypu3kem4ok@utt6rfdtbg7j>
References: <20250225083344.13195-1-clamor95@gmail.com>
 <20250225083344.13195-4-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225083344.13195-4-clamor95@gmail.com>

On Tue, Feb 25, 2025 at 10:33:44AM +0200, Svyatoslav Ryhel wrote:
> From: Maxim Schwalm <maxim.schwalm@gmail.com>
> 
> A simple HDMI bridge used in ASUS Transformer AiO P1801-T.
> 
> Signed-off-by: Maxim Schwalm <maxim.schwalm@gmail.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Robert Foss <rfoss@kernel.org>
> ---
>  drivers/gpu/drm/bridge/simple-bridge.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
> index ab0b0e36e97a..c0f1f7baaa37 100644
> --- a/drivers/gpu/drm/bridge/simple-bridge.c
> +++ b/drivers/gpu/drm/bridge/simple-bridge.c
> @@ -277,6 +277,11 @@ static const struct of_device_id simple_bridge_match[] = {
>  			.timings = &ti_ths8134_bridge_timings,
>  			.connector_type = DRM_MODE_CONNECTOR_VGA,
>  		},
> +	}, {
> +		.compatible = "mstar,tsumu88adt3-lf-1",
> +		.data = &(const struct simple_bridge_info) {
> +			.connector_type = DRM_MODE_CONNECTOR_HDMIA,
> +		},

This entry should also come between adi,adv7123 and ti,opa362.

>  	},
>  	{},
>  };
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

