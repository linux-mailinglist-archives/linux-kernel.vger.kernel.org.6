Return-Path: <linux-kernel+bounces-515053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBA3A35F40
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18290163B0B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851F4263F2E;
	Fri, 14 Feb 2025 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U4aW2yiX"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16597263C69
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539692; cv=none; b=LwamkF0ICqXG8x8c7B7p3Tz/EBnasp64CuibbfKM2lxZTONaf1tDFHvkMkHFkngSocvllv01koDZ+XegbX50hSBYqSvI1sT1GZHJGNLRn8+Us/xpvVOdgSlAFsG/YD2lsV6uDUYuNKYE7+RSbOPRo9KDxGMPNLI9R4vY3vQWuNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539692; c=relaxed/simple;
	bh=CPYek+hYliRAX5o8ZnuaBrVKcYxaZMouqyYaL/+IslA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHy5BlVQbuNFKSrcrHnE5RS4NBspbylOyekW2EVOT8Lt3QWlfgqZ6lqdJkSQKZhXKHxsATuxMz9AvJfNY3TgHCHijTFJocRjI9md0LX0LL5mLdBKEc7TPfjyTEb988nNAJ4LYQi5o2eGlP4X+s62FLTolKZT6joePEEasG/Kv+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U4aW2yiX; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54298ec925bso2877156e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 05:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739539688; x=1740144488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FQxy+yN7dDezeAO1BEXInClcUYOsHYnJkVVioVQo5MU=;
        b=U4aW2yiXUtxHqC9qZ4E1+b6kznAzsXjgGlNfbBUfHuq0hUWguMLZsx76NrQjQ06jPY
         3ULbc7S0fQ/s63zyn1PUEhmx5YFLIW8rPODP0qTv2gYRvsz7ul3ArkVXio5LjWcFzgi9
         cbaMJAuENOVujr7Kw05hShMxQiGp4yBksCsZMBtWUbOKGnoHf1mthToZZnNuKUr7dGvx
         yFfgb9cjQ3McovF3r4cF33q43a6Lwvr3R4uADlr68iNMUEaTsy3g3c5+kao2mpTYIBQW
         4YBSIEaRm0LK8csAOpB9ZQgmmtDLRZITn9AqTekroC1JTox9lpf/4wzwTcQeRK4eZBlA
         8e1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739539688; x=1740144488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQxy+yN7dDezeAO1BEXInClcUYOsHYnJkVVioVQo5MU=;
        b=q8mJJRi4/kHP1uu5QShFdl7FGACMxXndH/HcIirfyWmP9ueRxpp/oOUG/ovn6p/xfT
         SiXiW73p0x8sYT0nNSSUUTwCxcmUnOZipQ1jei/dOpCw4slStUmHYVykSClfsAFJKDE8
         e7C72zs2ZTRfO1XiAw/d2R6tQSsiVa82kt0Nwq9irKJJ/GHeXfQc9+mCUKi3xpHoKcdY
         89KX/9ONEC87X8RCvW+DsYsPHS1XLbuPmsYEY9GcjGnjgcTxl4rIrf2sCQXuHxp7rDB8
         ux9ZNuPXWdaP+eWTHaoUiHytQSnpV/P5hEXkO4w10mcJPrpjBm9LtAWqsz+YXuLyBiu4
         gl2w==
X-Forwarded-Encrypted: i=1; AJvYcCVOefUjHuLd+W5lNOqHh1xW4/VL8UnVh4yw/kt70DhPdB4AQVp7Z2U7HbxVXL09qdf7HcomQSmDJ0O6eP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx47Vuc8TPAK/j+8KVnnxMsRs1S6XOuNfCPLLlqgdh7g9GCOIJ/
	MaPcAwnLNRvU8T+IMPT/HqUixc1FrbURH6MvO554ums8+asbiSmOR5EhG1WMRL8=
X-Gm-Gg: ASbGncsxeRfNu/DBKgrr7pFbJMoMyrH/ZXXqYYvxOSS3MTI75mNeVywq99CEnDjBrcM
	sk3ut300xBhvMB7MUod0VkzJvuxDymDsJKep+GOasyQkp2Imp/lOeFGrRlUx1gxYoMHXxaw+Pxz
	ar5GwF18J47vpH904AwAe8vqRh8dsOLThCaQ+l3Tan0TAS1B8vxCKIpm/pAdyXsOmuEA/LraDni
	urQS3BTMA3KR2yEercuR97wv+kQ1U5AAQmAI+S5AzUC/L1UrvBAdbziQos4RZZN0KJK0Um9K6VZ
	/dRdOx7yChfwQZR71nku9RksUOEHcJy7tCBV6F3dAzClkDmFsHF0uFaLeYomE69sFLyY+po=
X-Google-Smtp-Source: AGHT+IE+/yVqkSlc/szw0oxVKt3XobQ/Da8KVl8Esh/I9HvZM5iaCR0ebQNJvarLi+5UvEJcAruV/w==
X-Received: by 2002:a05:6512:4026:b0:545:48c:6352 with SMTP id 2adb3069b0e04-54518185a7bmr4330037e87.43.1739539688223;
        Fri, 14 Feb 2025 05:28:08 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54526745abcsm282948e87.252.2025.02.14.05.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 05:28:06 -0800 (PST)
Date: Fri, 14 Feb 2025 15:28:04 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 31/37] drm/bridge: Provide pointers to the connector
 and crtc in bridge state
Message-ID: <h6nqaxoq5eohevpdlym4g24lqeeqhapzmbjdi2lyyjrhyu7wrj@omypjnlxniz2>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
 <20250213-bridge-connector-v3-31-e71598f49c8f@kernel.org>
 <gyfchljgrqamb26sot4c26gcwupbst2zuu5fw6el5wsl6gl5xp@ruqbpsn4lpvx>
 <20250214-evasive-eel-of-piety-d59e46@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-evasive-eel-of-piety-d59e46@houat>

On Fri, Feb 14, 2025 at 02:06:34PM +0100, Maxime Ripard wrote:
> On Thu, Feb 13, 2025 at 06:32:39PM +0200, Dmitry Baryshkov wrote:
> > On Thu, Feb 13, 2025 at 03:43:50PM +0100, Maxime Ripard wrote:
> > > Now that connectors are no longer necessarily created by the bridges
> > > drivers themselves but might be created by drm_bridge_connector, it's
> > > pretty hard for bridge drivers to retrieve pointers to the connector and
> > > CRTC they are attached to.
> > > 
> > > Indeed, the only way to retrieve the CRTC is to follow the drm_bridge
> > > encoder field, and then the drm_encoder crtc field, both of them being
> > > deprecated.
> > > 
> > > And for the connector, since we can have multiple connectors attached to
> > > a CRTC, we don't really have a reliable way to get it.
> > 
> > The same comment as for v2:
> > 
> > It's not very precise:
> > 
> >  connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
> > 
> > Is that unreliable somehow?
> 
> Then I'm not sure what you want here (and in v2) either. Do you want me
> to drop this patch because it's redundant, drop it, something else?

No, basically to expand the commit message. It states that there was no
reliable way to get the connector, but there was one. I'd mention that
getting CRTC and connector via the state results in a boilerplate code
and complicates bridge drivers.

-- 
With best wishes
Dmitry

