Return-Path: <linux-kernel+bounces-440315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6349EBBB9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F811641D2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA118230270;
	Tue, 10 Dec 2024 21:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cAZPPXkL"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E1E23026D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733865634; cv=none; b=DmGnjVup9lqzyJ3TG4ivQD3LztnrFoBWFcD55PQ8pTMLEZGgztY5cC2EaVltzZAH0WlkXnQbqoC9iSBq3yMCU7Y96jURL2z0SMUfNq0Yo7FunVhsCgPQrNbvrpJm2qg6Oq9utlZQNY04ous8vYmwyF4MzvyK/cdHEiDw1ACMNTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733865634; c=relaxed/simple;
	bh=LV357DiRMd/D1axwAIAqWggD9i3wgG9VYZQtR6NIW8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldYB0mQFR/9kh3EGM2CWvR4TOcCS8x0buoP7v9tS4UTa5gKxk3ZT//Wls0I27zTcOrPSrwDvpSz+tqLCdUGwuBYqIRfOpCEVuajJHD9M6lyAtCqjOzDTbgrX4SlOYnu/E5EpQ7swzxovYPwywY98Vz3q10MOuO0DPtO4MIJavM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cAZPPXkL; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53ffaaeeb76so3337013e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733865630; x=1734470430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yF3vBmNZS9MU6AYhmkZOCnnb/mhvQHCH0jIPUUHFQrU=;
        b=cAZPPXkLE8AeyMHkIKnZx5r5lUA03pLx3rgzuoNVrTpgYRDY9s37+ftQtPc6Mih6Iu
         8iNtCyfQWTSadjxGQdpliJAGoRGs8wD3qhLREfBJtq5T5ue7a/87RghQpneDpnu3LZHh
         0NonQmxpjkB9fUD1xA4Uwc8IpytJXcWdcEAuOIMz6+1zXDkemNMzRu37JMDHVqSUQnWk
         k1vr15DkhhdMFzARVHqImQwDmrZHkCq51mgDMSiq+0pXAEKBzeuSS1TfEdAzG4Ia+iNR
         M6vZ+ECwMnxf2RnC8ZvLI/r9OglgVz9AXBjpb71TJKtYIjtIJTl0ZGSHi2JwhaMa5zoL
         JuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733865630; x=1734470430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yF3vBmNZS9MU6AYhmkZOCnnb/mhvQHCH0jIPUUHFQrU=;
        b=EJDCuNQHyuNr+F1mLg3OOjxpoJtKUBA9WIY0P3FOHoZJ1SjjrMgULMvu5xShxqv2/z
         QlkuLFJda+YqDZw20IvASH37jj9PDxbn51kRugv30JebdkFPax5IpJl1LfyogP3v+UOL
         4bJdCmKGH+ZbrdE1bd1dITV95TwdKR+RX8szRd1saD3QsUeixlsej5ITiclRwHEht4XP
         kJCu4cM2YHu0c+zQax5W/byao35XeFjW73ST3lz+L+eUd/UpXnxbogXHyMPQ79O/u7tY
         /x5hv0D6FfMz/Kn9fTb4ppSojTZymX6GwfhFJQ1rgEyn5DmrJehLEohgLp0p7iwp21B+
         /kPA==
X-Forwarded-Encrypted: i=1; AJvYcCVEMYlR2bLACCGw4cCd1rjW+U928PWwg6pJQ0WhDAcJOk+858A4M0mfr1sYOENpkfIZvBwxEWvHDeQ7DA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7oyxeQ9ny4zvSUt5gBxQDUR+hvnbaCm6EiN/wZqZ7piKW3Gnl
	3swh18oeqjgyB4OPsUMwallOh0lQcbwWUxTRi5swm6bjNjRbqASIFXceLk/WHE4=
X-Gm-Gg: ASbGncvzpnt88r/2PwwIK53jzjfxkvJUCS/7ymu53jI1epwC5ozGAq+ZehDfsODIdJH
	NOd0m7CGMf9fQ8gPeC2SaWrnGAofgijb8mjfyOLe2usGR1QHzOj65rrkx1VA4EAU6819cdYvhN9
	Y3nOhulQydKi1fw7eDJmWU002OsoMbzdw1kVRLwNvzfQ6GPyR1lzpheSccygJx6p08ZgOeKutgR
	MU5yb4JdIL+2f8AqisV9SvJhzcGzsl73sll8nodGLmShQnEMqeKkaOaTC3G2A9czz0FYbvmiki3
	OZjZlcnlUhnqiYYrNCaimoAgRPalIi358w==
X-Google-Smtp-Source: AGHT+IHCODZIQ0z4mmWtV1wEX8j8zg9S/BNFluONyQd2XvnZpEGUwS4bPVxg3YoPJtWqjVmMgWar/A==
X-Received: by 2002:a05:6512:3990:b0:53e:368c:ac4f with SMTP id 2adb3069b0e04-5402a5d3d6cmr107076e87.9.1733865629981;
        Tue, 10 Dec 2024 13:20:29 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e34569209sm1395827e87.128.2024.12.10.13.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 13:20:28 -0800 (PST)
Date: Tue, 10 Dec 2024 23:20:26 +0200
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
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH v2 04/10] drm/amd/display: use eld_mutex to protect
 access to connector->eld
Message-ID: <pgi7p3aemxm3db2k27vi5euh6q6ppayrw6y7tcfeq4g5z23hzr@xousag2qhobp>
References: <20241206-drm-connector-eld-mutex-v2-0-c9bce1ee8bea@linaro.org>
 <20241206-drm-connector-eld-mutex-v2-4-c9bce1ee8bea@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206-drm-connector-eld-mutex-v2-4-c9bce1ee8bea@linaro.org>

On Fri, Dec 06, 2024 at 11:43:07AM +0200, Dmitry Baryshkov wrote:
> Reading access to connector->eld can happen at the same time the
> drm_edid_to_eld() updates the data. Take the newly added eld_mutex in
> order to protect connector->eld from concurrent access.
> 
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
>  1 file changed, 2 insertions(+)

Harry, Leo, Rodrigo, Alex, Christian, Xinhui, any response to this one
and to the radeon patches? I'd like to be able to pick the series for
drm-misc and these two are not reviewed by you.

> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 19a58630e774029767bf2a27eb4ddf17e3c21129..04c68c320252b5ce9647f0606fb86fe57f347639 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1037,8 +1037,10 @@ static int amdgpu_dm_audio_component_get_eld(struct device *kdev, int port,
>  			continue;
>  
>  		*enabled = true;
> +		mutex_lock(&connector->eld_mutex);
>  		ret = drm_eld_size(connector->eld);
>  		memcpy(buf, connector->eld, min(max_bytes, ret));
> +		mutex_unlock(&connector->eld_mutex);
>  
>  		break;
>  	}
> 
> -- 
> 2.39.5
> 

-- 
With best wishes
Dmitry

