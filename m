Return-Path: <linux-kernel+bounces-533120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EADA455DB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 875DA1720CB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B4026E62A;
	Wed, 26 Feb 2025 06:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i7rLwPr+"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D1626E160
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740552048; cv=none; b=jtQOMS6o879gFWcxplZaG+W+KxDkZQxtk4asgzpBpzQWl4DqTwyjyUYVflQDv1w6y40DV1deSf0eiCI/ankACYMSaY1vpQhT6l3on5oYla4Xr0OTySE0+/CsmpxFi9HEHb/ex5auYQkObAv7PdkATmKkN6ERh22ifq5Wtcy17JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740552048; c=relaxed/simple;
	bh=OJBtOgMaEifZqzNwcLwt0BlEKz0MFMaYaz1CKwpZQS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rt7T22KcrSoi8s4vu3PFDKZj90GkGQVgGaNISbn8YQsRxOZ5XyDoaODYCqSFauSQMniHiDBfl7pVrpWO4cvCsSPdQQb/HfbgnmbMLoNMzkBp8pDMUOhmsFJ3N/445UiQI9DSYEDhNKy5ML4l9EFNtxkN5n5/X+Sl/bwhzy7/zU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i7rLwPr+; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5462a2b9dedso7595501e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740552044; x=1741156844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lvrcxh2NOKDJoqVw96Qhct4iGfREhK0gSFGHNTyZJvg=;
        b=i7rLwPr+LH/kazu05TSZWlam4VVMdFs+q7DNKq+dGDj0ICoTtJQGz1CJmvDTQ4JzKM
         Bi+rr4cTlkMeM/bDcaLn5wXMbJ+UuxUkKjG3FkzLVxRQWZIfcxgUIF0gd9xb4xl9+i7o
         PajI1yEzKeHBXlUyVRZehpQKk0/w+4Y73ItZstooFdU/o0GTMs7aGrWUwFo7N6YMlbU9
         9cMJqLcmMq8ORlH6PcC9UpFz53tM/ETwLfE4HCE7eo1EK5Tqp5j/Z/ntpKx8tpp3lxJU
         I4x47Bta3Y+9NeAOiNc3jF5D8mwkpjhsP68lnJroCghoS6jUp95okq7MqvGsFLLZuxD2
         t7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740552044; x=1741156844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lvrcxh2NOKDJoqVw96Qhct4iGfREhK0gSFGHNTyZJvg=;
        b=h+ufG+kauQj7q2wDwyVepo4dTWitbwEgYzTtHZlxoP947t3zYsit6SlFRH9cZjeQkh
         6QtW6I3mh2I4nVOoz6b9qVfbJ0RuyV0/EIIZfjgVpCAe6v6AwaLzrZpeRCBzEyiTNnLj
         sk/00bpRDFXl5v1a+ihkR18VxsIq1AvcVZ0H5wPb2Tzmeed5+ipVzLvt4ZgEEmhqS0ym
         zl1a1wlOHqtmkSme+NsDdo3D2XcfWVpXQ4mphwChr08/j61isopk0DPoCJsTscYCs8EG
         nkLuDJIQB7uq9Wlx29dBVDNariLwVsIYfZa100J8TXkY6O2AwP51Ies3HuzCqvqoR33O
         qrng==
X-Forwarded-Encrypted: i=1; AJvYcCUiEJ45eQoV2M4geTgNuHTUoNo72cCTs6IxDBaXKyP11S9mU+tyOmbOpEYCXirexi544VVQyLlUzow+Lnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWX/UxFUABVIjCJ5xj43+xA7EkeJ/LGlEYL1n8bi3K1FPKOlyj
	cHv/CzHzHitNGkEJiPpY2F7qghXaPpuPwz0XhFE9KwOPzsRxx4nqUQSQyRpd1GM=
X-Gm-Gg: ASbGncsVvT+xQ2aVjwxR4PNSGavX3AawE7HGMNicMmq/EIBXUeUNlBREr79OQvrObSk
	00ZAq03lLZg9l7Wp/UeIbw8Ud/cHwukZsIjbjlW0w2SpyFNDEuVfY9/PqX4bimX6jBwkBzvVaPK
	32x/RoLz8g0TUij6nhk1j15XphRb2HK8yFCIz/sKVoF+CLIOFbVIVtXUtEXa8dinYlDpsj3KMkk
	hG3yJDDo2LZCFE2WCdFhqSaD6jNheXY6dmnvqOdkcwJs2PxyxGHZSqAedg1hrJPJOjcPmMx7Vi9
	+2yTAogVdAyeVG4P1m/msAHTSxK2hiCNjTLGldSrP/aZhZv9qpOmtx5uydaXFHRm8WT1ljPfhQZ
	aZiwFmw==
X-Google-Smtp-Source: AGHT+IE+UZnvevEs1viGMTJRPBC8JRF4hWUCWXPwjS+7NIlt6UfyZslUh/zC7Mo+N1nw7oya2efNUw==
X-Received: by 2002:ac2:4c2f:0:b0:549:2ae5:a499 with SMTP id 2adb3069b0e04-5492ae5a600mr2619977e87.7.1740552044249;
        Tue, 25 Feb 2025 22:40:44 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514f9e3fsm362150e87.217.2025.02.25.22.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 22:40:42 -0800 (PST)
Date: Wed, 26 Feb 2025 08:40:41 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	Herve Codina <herve.codina@bootlin.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/15] drm/tests: Add kunit tests for bridges
Message-ID: <yzddmmuq4nweiat7zlt7pmac76djx2o5jw4g6rucomasbkiaek@v4hcph45qf74>
References: <20250225-bridge-connector-v4-0-7ecb07b09cad@kernel.org>
 <20250225-bridge-connector-v4-3-7ecb07b09cad@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-bridge-connector-v4-3-7ecb07b09cad@kernel.org>

On Tue, Feb 25, 2025 at 05:43:51PM +0100, Maxime Ripard wrote:
> None of the drm_bridge function have kunit tests so far. Let's change
> that, starting with drm_bridge_get_current_state().
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/Kconfig                 |   1 +
>  drivers/gpu/drm/tests/Makefile          |   1 +
>  drivers/gpu/drm/tests/drm_bridge_test.c | 210 ++++++++++++++++++++++++++++++++
>  3 files changed, 212 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

