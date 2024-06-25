Return-Path: <linux-kernel+bounces-229178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9078C916C7F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AC13B23CF1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEB018E756;
	Tue, 25 Jun 2024 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cxe9x4mm"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889B017D341
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 15:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327947; cv=none; b=Yddx4jTMsJCNILNpVcGbZ+1EbdloZScMk0Y4vvrDI97qqNCQZYutvsPr5o88K3Ekz0NQ7fPWwA5M2liKoAikuLnUpta8RIv++qgMpJQXAUo1NV+aKhX2e0pNgOlcQTtT9OD41kWJE5vwy9eI+qBTC1VzfBAmzfw4Le3Km+RR+jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327947; c=relaxed/simple;
	bh=3LwE2V9f4tQOo23p5aFAX93ueL2Lgaphlhtznmc/PnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3NLENqGl1PD+lBiDaQ4wZlUKfpo+UU/yTfe+8dIniRM8D8I01VMy0Xvlrz/1MiAwd7pqOd5mf9iGSpm41R4JQZ+qc4g9E5hDKrRU8Kuri+fUQBl6MoSJ5rVGR8OU3/+QMBF16ncYWO/SK+56v+SWVI1g10m/YfQJ8A8uvv5Kq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cxe9x4mm; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-630daaec9c7so51010217b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 08:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719327944; x=1719932744; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JunNWwGKBRTYr5Pcd5O5SWyjr+J71GISSn9v9GBzIls=;
        b=cxe9x4mmBVDtN1iTTyYcOBgVOM5KL3sBiSf58NKGzXsmaNtzqvH8Cx4qLrEo2C9VZ+
         XAVIvU20YSLCzmzvTcorkPhReEE7uEoucpofRhKXloFiiWwlLOQmtDY9BAyj421h4+yJ
         2x2eC/rY5naHtdmcXgsHOvuHBHeRLeVJQBlKzoyZXaJb8KGkIfLfZNQWxKMyzKp812GC
         1aq4NMbUxS3m0LYocI6rdNP76X/SjysWoX/uuz6/bdbEb/O0xlLzatoPxIvID2EFSMLf
         obaIX2+I2KXeKn9/pj/t1pl0APQEz+0VYM3QW2Qu57sVx7CNCIXY/D4jUASD5R52cN8o
         KXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719327944; x=1719932744;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JunNWwGKBRTYr5Pcd5O5SWyjr+J71GISSn9v9GBzIls=;
        b=Xo51Gk9JtTkVOJrEndvCZy6QrUBz9AS8TGbbMw986xlODSAAwRPIDhysWVGAS3ADyt
         QSlqo01CpcDa3sF0mddQ8Yg7Gny3mYqNORebvgMXKlvPIX1zmOpjLEqGNtBVUN0lVHVl
         SN1g8YL7OiIhTaIwMFgGaxFOc3QiMqHpCsjGfe5SQyzru74pMw0buvM5PT5fm3/izOoa
         Pzh1C86edxM98KT8PKC5sL8vAjSSNxbD1HLqlDaGEy80gWqPsiMX7sAEgPvhfACKdqMJ
         PrjG7Ttp2PmK0lPK1F9l32ahc6u7POpxZVDVOZ6n2+Acl+SbZx/Tawsjfb1TGGwaGcWI
         jHLA==
X-Forwarded-Encrypted: i=1; AJvYcCX4OdbYNpLGIpaZwuMj82cLQ7V+PEvs4CoP7UXmQg7MzvohXdwArooeg3sUGKqULwp2xjCtcHnSqYR23bec1sGkRSc+KVDQdqGtrZPq
X-Gm-Message-State: AOJu0Yw+sivACBT76zkJeKlR6bYD+IETTHZzObn/Am5eythaTFFZX0du
	fMnWKl1j4uCo8Z/NK7DiFPV7CG2qLDkVee5fQZCxKloepvEvbjugbFDaTXIG3EUDVkjZVRwg33B
	UXVI9USybKaWre5BzDg9xLGei5JpqeMRHBm2R3Q==
X-Google-Smtp-Source: AGHT+IFe9ebZjIjKe3yw6sqBV3bTmm2If8WOtZ4l30oH3MpOHUQh7AQDYHW3owX9fbwtm1v9DNf0ncg1El4NCsVswYw=
X-Received: by 2002:a81:c313:0:b0:618:2381:2404 with SMTP id
 00721157ae682-643ac72278amr86606087b3.44.1719327944523; Tue, 25 Jun 2024
 08:05:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240623-drm-bridge-connector-fix-hdmi-reset-v2-0-8590d44912ce@linaro.org>
 <20240623-drm-bridge-connector-fix-hdmi-reset-v2-1-8590d44912ce@linaro.org> <20240625-feathered-loon-of-health-ec7e6d@houat>
In-Reply-To: <20240625-feathered-loon-of-health-ec7e6d@houat>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 25 Jun 2024 18:05:33 +0300
Message-ID: <CAA8EJpq314tQFZpkXgL1cYDPfoFRukhB_KiaDvmsqdzHFD512g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/bridge-connector: reset the HDMI connector state
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jun 2024 at 18:02, Maxime Ripard <mripard@kernel.org> wrote:
>
> Hi,
>
> On Sun, Jun 23, 2024 at 08:40:12AM GMT, Dmitry Baryshkov wrote:
> > On HDMI connectors which use drm_bridge_connector and DRM_BRIDGE_OP_HDMI
> > IGT chokes on the max_bpc property in several kms_properties tests due
> > to the the drm_bridge_connector failing to reset HDMI-related
> > properties.
> >
> > Call __drm_atomic_helper_connector_hdmi_reset() if there is a
> > the drm_bridge_connector has bridge_hdmi.
> >
> > Note, the __drm_atomic_helper_connector_hdmi_reset() is moved to
> > drm_atomic_state_helper.c because drm_bridge_connector.c can not depend
> > on DRM_DISPLAY_HDMI_STATE_HELPER. At the same time it is impossible to
> > call this function from HDMI bridges, there is is no function that
> > corresponds to the drm_connector_funcs::reset().
>
> Why can't it depend on DRM_DISPLAY_HDMI_STATE_HELPER?

Is it okay to have DRM_KMS_HELPER to depend unconditionally or select
DRM_DISPLAY_HDMI_STATE_HELPER?

-- 
With best wishes
Dmitry

