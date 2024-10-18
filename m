Return-Path: <linux-kernel+bounces-371711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE8A9A3EF3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6902C286F95
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4BD1D0DF7;
	Fri, 18 Oct 2024 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ORE/p3mb"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C131D1E64
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729256219; cv=none; b=SBjM0njC9wCS7QB/RjPxnUkUJs+3qXCfJW3IxI0pv5oV6+Cg4tRoH/pue399+Bp8zWDgB+tcq3PxT+McG+HRoK6xNQT2Chqn5FaIHxUgyyKMJQtUQJFSxBidVeDs5rKnOPdBcIwvccb9B8A1CbfpXbHLb12jGoywTAxt++cAuJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729256219; c=relaxed/simple;
	bh=8hryLUhjN9466aZtzGzJpDJXDvNAOUSxrMdam0RQjhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZum98lAeVF8i9kHVofEeMzblCUkQ7yeSWAxtMIzWvfI6NaYSzsfnVNtp+3zSQ3YnLqUz18RsF728/lZUMK2p8cqe8/aDQz9kF11JrM5U29+E04MAu9mN36aVUGtQrwMzsCFeKa3st4mpJHQu2Ur1NY1c8OHRfJjVnUB2GPdw+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ORE/p3mb; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e3f35268so2700552e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 05:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729256215; x=1729861015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tlmikyeHLA1R+v/SeMY82cfNuK9qeutuFdS/0zXyK7I=;
        b=ORE/p3mbnVGm2zPiShyCv3oV+QeaiXa1ArLeJDIKmaKjg5uhugBkhsOoJ8mGVuHGsc
         /OTqYFeU4ikcnR9S2feBxpQV9VzrbNJuB49h6wZDEiNt+VtcVJn3hk9PcUdsOoasTvjB
         nMoYwDJL2tJBvTj5rlHafmH82fIw/CL1zUYIOVxRR3kBx1RaEvvQ/tCAotIoOajddiDV
         H52zl+H76Xb+XhjY5a72uuXRnOvpXieLDbGR5c6T+7gVgSAxNtLgQpOurXUY5b1qMrDf
         ZzIyR995WVZKIC91inNbdh0k9x9ZlWJvJOZPFwS8dKIa8FVniRq9Zk+TSNNKZI/6RNis
         Uv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729256215; x=1729861015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlmikyeHLA1R+v/SeMY82cfNuK9qeutuFdS/0zXyK7I=;
        b=IEcpWnjJ4RBmffmim72AcXvGijKe9VleKugsYi6uCJ322nTV6JmnYLBS8V689jrS++
         q4JSHCXvNG6dRQFh0XH4DFvKiyp/33wW8Scg1Bo6pa+9w8z/E4JxUwwkPrA1AsKBGfwL
         CAOC9eEYfDOWNbK2QfxC3ZYTM6pE3mnfYhJWDEuRxrGIvNxc6Nv2ZLBjDqg8lN6T8GUB
         5CfEU9eAx6XE0kOfbruOplSBjMSRxYOsSKKcqCdxnEF9STSPbfBS9nna8EF27QJFqM/C
         BMDV6qR8TwTOD0cuJQEq/OAyo3pWZlRosM5blcsUzmsOLqZarOM0epfw1/C7rb9gHM1t
         eFhg==
X-Forwarded-Encrypted: i=1; AJvYcCVKDQGhMXK4pY0+psEoW4FRu99E7D+ekDEQd4lpyDEyeQ9awxC6ROVwIhqNLV4+rkHJ8SE5Xg1w1Nuf6tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVwl5uMC6PZkBOsRGdAEaKPRU2WFytQqHw14EsulpfyvEaT8Ek
	VNbBnp0Dn7CxE2+h4icr3kyLQgVDka2GjbQpxYTvuRXRe2jVyiHwszFXuTycsGg=
X-Google-Smtp-Source: AGHT+IGp8BKiU5zwSiuqZHuPvclHSa+AFjqYaVWitnIZIJPqHYxSdeACmZOkLV/f3MXQCGakP7kHZg==
X-Received: by 2002:a05:6512:1051:b0:539:f10b:ff93 with SMTP id 2adb3069b0e04-53a15229dc3mr1673369e87.27.1729256214774;
        Fri, 18 Oct 2024 05:56:54 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a15211bb0sm210724e87.260.2024.10.18.05.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 05:56:54 -0700 (PDT)
Date: Fri, 18 Oct 2024 15:56:52 +0300
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
Subject: Re: [PATCH v6 01/10] drm/bridge: it6505: Change definition of
 AUX_FIFO_MAX_SIZE
Message-ID: <zltdkt5ynnfyetrxbqmazkj7l36olxueqkynka2orqzd4v6ji3@4odws5t4k4dt>
References: <20241016-upstream-v6-v6-0-4d93a0c46de1@ite.com.tw>
 <20241016-upstream-v6-v6-1-4d93a0c46de1@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-upstream-v6-v6-1-4d93a0c46de1@ite.com.tw>

On Wed, Oct 16, 2024 at 03:54:13PM +0800, Hermes Wu via B4 Relay wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> The hardware AUX FIFO is 16 bytes
> Change definition of AUX_FIFO_MAX_SIZE to 16
> 
> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

