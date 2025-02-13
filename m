Return-Path: <linux-kernel+bounces-513477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A67A34AAE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242CA1892FFF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D292C266197;
	Thu, 13 Feb 2025 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pRAbFqoU"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761192222BB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464853; cv=none; b=Jxm6MJm1+u8NFpwy1ckWE3O2FZG7cMj7FeB0TbPHhkaerQMNdEs2sKQY7y2qZZjctzc/0Q75Wb4Ow1XNDJcaIhdYlavTWl69K/kyaCosSHDhrhfvKnQ99F0wtvFcIYhdNyJ/fbSffpQ5/Ib8TjZ3B34xcr3f6/yKCzWD89ynGyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464853; c=relaxed/simple;
	bh=ilVtVdtqcdvqiRvrD72tm27UFvZ1C8aH9lSN5V+V/uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8azuRPDZifSMLgfDET/KFVavGdbUPN3HnWrw0NCLZhaUGLtdDldePJoYq/A0PAbHKdCXnqsF+EiUr8Gl+twO7JlAWMwpRuUAZaXr0JagJYGmTut7AUHJgFakiz2mLKFFEdjT5YqlzCivPK7uTTLeJ+50s3ypcT6vhJb9M6hsy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pRAbFqoU; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-308eebd4938so10867551fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739464850; x=1740069650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nsPlqa+XTMTRmx7s7nIfzGqoebmJYSoLC3HQNsZuS7I=;
        b=pRAbFqoUbKS+BBxStE2Y2crUMkTOCOHTYtO1zsj1vYuVhkvkup3OZf8ZQM4B5udmW7
         lf+NRVZ1zHlP5S1MziHn3IxEpnLiFdTUR4bC8YfTmY4S4VGm1ySXk5WfRi+k/ZApSlYP
         7YvU/K0NrL5NnZELwmRL8cuViK+LHvLPLCSXhGz0LZ908O7dmhqqV2nDDSGlztJue9bp
         QncGtCaP2wW+JM0X4qT3e3mQWQGyn/Fk/Y8ZIghGUd9+sGv3tTaWapQKY7bCUMW7+4VK
         566e04xE+Oxtq8issZrtySht+pSy7R1XVzsOlgaqRWQ8fKf6lgzGNnMrdsvMzSrC78xD
         5pnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739464850; x=1740069650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsPlqa+XTMTRmx7s7nIfzGqoebmJYSoLC3HQNsZuS7I=;
        b=sdBNE6tavNDK7T6vLj2XMu40TKvj6v/PLEl+X+MFY4ulamvOp7j6cfqJRtw92+yCrH
         12rVWHoec3fux5C9QXdJ24kp6AKWj6ywcN9hUyiRXgoSGLgqjRnw+49MgANK0jJlnH4L
         gdfzp7gWNzmov5ogqAGPTV+KEzNrdEMM3avWVMYJ88PD0IjtMKup6UxWBCFvTR8lC6XC
         ulgc8qLGlxYW9g0PJGMeefXSW/lDU2sgZPkL8LRrOr+x0xS3K9J3z8dcp/MouR5y5ysi
         iUlJCAB/hF9eRKMp2vcJCGWDjVZYBSVuBOY+9dG1ZiPEShyZU5S1CbpXjhMRt5u/GFBp
         OU2A==
X-Forwarded-Encrypted: i=1; AJvYcCUa8fZi4gBjHATyLaHpsL7iki4fhHq8XuyrwFhexJcGbLJr2BG4YLyfVq7ghThW9aBX8BKL9o9ZYsGkhgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9yhiEIIR93yjq2y+RUzMoOaO9PBNrZSE+vUBgXTkiuLEftPwQ
	SJMjxJESds8sj3T1RGW3V936La5/iIp9TG3grDOHbY+hNabNn2VEBun3+/GpjUE=
X-Gm-Gg: ASbGnctHRcG4tdDFdyuWp6M0xGBirOalL45jaL4Ov3z4No6pJYPTSzjUjcKwG5uWU9M
	6+KTkzxx8aNhNpcroSzhuHPGGM0FvPPw7opfEvlU1X+uFiQZsxrnDM3J1YSPzoUdh2Rc+wQZafV
	4cV96SIxCPxTXG2LY2SWkXOKC43INHA2tmIaf8/ZzMftBEgkKA+HhiySuToyDf23/m+Yv2SOw2y
	qxczCSnQ2q/y9Xg87liBBZnL40i151FVODu++XA4xkZq3hygHs3cFA0ijSviLsBO+Sz5O7NDqUB
	KoLa4ymQrA7wjERMoGjw3unGKDMLKdOiCNIAl4PiJPMjhzPpBzKj0MUYkgekd9iVSB7Y9Gc=
X-Google-Smtp-Source: AGHT+IGip08e5QTGk3qyb9I5cPtwD3jegXUdt4j8V13l5pv6V2QbFSdwK/CpTAFSowcbbEVHqypdqg==
X-Received: by 2002:a2e:7c14:0:b0:308:f580:72a8 with SMTP id 38308e7fff4ca-309037c2656mr26625411fa.11.1739464849643;
        Thu, 13 Feb 2025 08:40:49 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309102767b4sm2462881fa.78.2025.02.13.08.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:40:48 -0800 (PST)
Date: Thu, 13 Feb 2025 18:40:47 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 23/37] drm/atomic-helper: Change parameter name of
 drm_atomic_helper_wait_for_vblanks()
Message-ID: <demffp3zswofiu6e2mee6g3p42k6qvfchnbgirn2xok47t477i@aodrfqjpejho>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
 <20250213-bridge-connector-v3-23-e71598f49c8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-bridge-connector-v3-23-e71598f49c8f@kernel.org>

On Thu, Feb 13, 2025 at 03:43:42PM +0100, Maxime Ripard wrote:
> drm_atomic_helper_wait_for_vblanks() waits for vblank events on all the
> CRTCs affected by a commit. It takes the drm_atomic_state being
> committed as a parameter.
> 
> However, that parameter name is called (and documented) as old_state,
> which is pretty confusing. Let's rename that variable as state.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

