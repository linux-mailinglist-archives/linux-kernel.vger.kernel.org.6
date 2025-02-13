Return-Path: <linux-kernel+bounces-513481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 948A9A34A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 578B37A6472
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208B9245AE9;
	Thu, 13 Feb 2025 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WKMgAYSR"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AF828A2A4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464885; cv=none; b=RK/wbOv9KYd6Ilt1bKKdqeLExbnUzJT8g833dXu9AZF1yzIMCbqKKxzz6ifKcet2pMPOJkMcMRJvHjCVQZrdNHD5lewIE2ebI2zbZlr6hhg8VHzy09OsaiWTVW7sGkYV8iWZwFTFsF/wHyC/dQUHq8lDUtBrMHq9hkpIog0M8b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464885; c=relaxed/simple;
	bh=L3tlILKssZw4sppldvld5Jyilak/SWu7knDZRIgo1FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVLFTsem/AF3Ay/BzyHNo6ufMr6g5ZLXp8npjchAmuhMbGoUzgJ0Ny8s3cDIsuCSoleUXppqWT6dJ7QyZx7XM/5rWNr3FoTBMfCdz4XkvKpnlfWEMXr4ewC8vzgxOuPIFQczEiYSjDXY/ZiAJLT5YGGYZsGhceRK6b+NYQ78Ulo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WKMgAYSR; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5450d56199cso2488838e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739464882; x=1740069682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tcccG4tkgvLDNi79n5bTiw8cyzoNORWz81wxKbGGu5g=;
        b=WKMgAYSRQgwG72QXfP8dwXwNAi9Yj88U8LDR58FWHE4g40yeLNhiJ9FsrlgQMFG/cO
         7sxMjFKfiod0xl7hI5+n5E7OdUACDgVOF41KloQa5BdGYlfDjIWPcoJw5Hm2fOJzmotN
         CzzgxEwKc/Vcp59qE4LC4EuLdN1Ym8XZrI3dZTTyW15kTdq37bpNV2UuWXaXw3ibVptg
         rgUL4crhunUkSsN3AH00q22sOVdIO1q0c7bGCXtFkDDuXQXGBomB87B7f5bTPQy9SPO5
         kj0Ly+R08UIND90vhjUWsHCxK3kEipTEGeuv+2f8lKX9sS6dk1pkesvHhDn4c4f08qVY
         BBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739464882; x=1740069682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcccG4tkgvLDNi79n5bTiw8cyzoNORWz81wxKbGGu5g=;
        b=I/FDTvH0qczfjDzGxziKIPoEtPgDyQ1MVjQiLGWOE6OcKtqIfpv9C9eDWdHKRTQMpO
         PERf1SHbagjBJg8uDs8dxXNzGabtugzLgVTE12CugNw6oxehnRGuKv2U0lvotGG5Jswq
         meUIpE+wXpPYCeQz7xayZ2ZsDt6Tc/wAlsMh5bq5VYn+lDV/UHPAAoxAyZWuayUuy9eK
         jmrSEjFHPFgdSkGZFeVmaYC+UkYOrgUJqLV9VTEo/ZCuy2cFV5fUhjfrGbFzAqo14fdS
         mrXvHmhAElCNElFehGb5H4J7bTOeeVgF7zkA36bifhU9oREJd6+Zrnyr3C+Hq+2p72Jq
         Se8A==
X-Forwarded-Encrypted: i=1; AJvYcCUX+Ofa6eIF/5LoMI47EzdNW9n3g1Y4jv2czqEN3nOgB89fbGwfXpTpE7JbPEyIXIhreX5pajrWCqCv0CA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxENxDT/qjzt2h0s0HGeK5EE0dLlAu2mxkbV/oUqPVFu3M99ykw
	kcuszen7LxCqbsHszCJ8+lorx06cKMx6tlemfE4HDygBSJ6EtQW3DteX7tuetQ+Qk8To3tz2gpz
	edLM=
X-Gm-Gg: ASbGnctGi1eYyxU4mqX9oUdCr3494u54RTUAeTm++HaiZhqCHaQaWo/Z3C9mSAOHSPk
	6bj87ivUeNTPifLlLiTy4kupLx3f7BUMavPlCTxUg0sCK+5DkoMiDKNZp/4UjKRfVjvZm+gPj7f
	OpnnEhp/M3Y2uHhPUsram7qR0cx6Yop2FCAYtuXHDC8gXD/19KCcI3MBF0aRL4hpuHHPEq0+E7j
	ZC9S8WnDZfdWNIj/kpKmVt3PFTYzwDw5NR0/qSeG8cC4MIUsyZ2Iq7kumEEvWhhKRCuapeJz/dB
	BwxacfHYGWpfFkRSLvz6Uxeuy/5Mpo+idiE7phAQefNaqWy6NOA1g+Jj7hSOzpxhjENgZYw=
X-Google-Smtp-Source: AGHT+IFeJUWEa60UQpI6q9YZql9YHNj9VRLqAC+Y3g1xdOcLPb+4FEU17zsKE+0JX60NmALo7RBecA==
X-Received: by 2002:ac2:4c48:0:b0:545:d70:93f1 with SMTP id 2adb3069b0e04-5451dfdc2ebmr1248900e87.11.1739464881766;
        Thu, 13 Feb 2025 08:41:21 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f11ee21sm215018e87.256.2025.02.13.08.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:41:20 -0800 (PST)
Date: Thu, 13 Feb 2025 18:41:18 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 26/37] drm/atomic-helper: Change parameter name of
 drm_atomic_helper_wait_for_flip_done()
Message-ID: <36rwa43xngtbmpelvnvvrzuk375ssguxkicbs5gy2phwhxk7yb@clooqmxvt5uv>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
 <20250213-bridge-connector-v3-26-e71598f49c8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-bridge-connector-v3-26-e71598f49c8f@kernel.org>

On Thu, Feb 13, 2025 at 03:43:45PM +0100, Maxime Ripard wrote:
> drm_atomic_helper_wait_for_flip_done() will wait for pages flips on all
> CRTCs affected by a given commit. It takes the drm_atomic_state being
> committed as a parameter.
> 
> However, that parameter name is called (and documented) as old_state,
> which is pretty confusing. Let's rename that variable as state.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

