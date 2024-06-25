Return-Path: <linux-kernel+bounces-229317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E80916E3E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E20C1C21CCF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2952617334B;
	Tue, 25 Jun 2024 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RqQ7l62A"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E46413B2B0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333509; cv=none; b=taXAdhbZFsiMOgFUBM1iscp3Cl/bLM45d0BDEFa7deKt8vp7Y0ENTB0a8NQ/kR0d29DD1oe7leiNTDirpgC0RQs/zatSq3CvZIgtL2B3Nk27kqQ1SaIU1CVG/DuBGCIPinKuxPPXX/t/cfUDvuwWIabxTERvBM8XGMssEXoLzkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333509; c=relaxed/simple;
	bh=sc5AnNeoCclZncrJypDF6bz+oBjcy4G0AFQxCVSZoJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lfcq7Btz256Y97zcLbf8QdUa+Vii5O2/7dnMcHtI27BDdqCQANbHC3Jz7g96st26KUyh+c61twKoCrrK0MgMGe5bRHSGy2LUFzX6vZQ7uxTGWq5j5BmedKlR0L/KMVkfP93jAG1Qow+JG5sPuebspPATDSIEYEja4tw3z7Kctgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RqQ7l62A; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52cdf4bc083so5011395e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719333505; x=1719938305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qEtrqqKgtRO3segRtAhqbjDeDlPr4qQZMrM9hddNVII=;
        b=RqQ7l62AwZDgQOV7KC7HwWiORTkSivT4ApiHpjpHCrV72EQ9rXQMednTw2/JkWg7TE
         F7VQffEPuZLY44w2O2UsFYW2UFo7kiF/rtYSh42cYYYDq+OkQXk3z2KqruUjXGIcuSPj
         7CqLebxMKAgM+AXW3TOlEWd+pF3+zPepVDZoTWNErvXDEX2NHJvXBm38GNMzHbGOKAyv
         8QoOeTi/4Uqz1yZrK0phJJxxZeUBsLdtFPCjof9OIsYn216MoQWmunaUVriA0maaNkFJ
         Fc+TWzBNBoTXoeLvlfoLEexHwc5VJ9RalX3hEJACkHOl9J8uVEqIMLo+4DY/cgP0L2ik
         rHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719333505; x=1719938305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEtrqqKgtRO3segRtAhqbjDeDlPr4qQZMrM9hddNVII=;
        b=DlmTfz9ohV6BZout5dgTqJDjCtIiJf3aKwaCgFcDZxN66MXbxnMs9N2GljBjg04Yjb
         K4my6naHFCGzI5Ae7O9yTspgr0voye5H9GYskzD/0YnlrMrdKXoqA8mwOehBZhdMMaS9
         duq1VxCSANGONZf5mi4uWKZHueBXpBqbJRsT3YH4rMGPmwg8yMKO73oNNUidqJqzcFFj
         Yj32tZGXd0FSq5X1LyVzLaKssiqcdYWkGU5naZM7abswPXGJCHDsPlKE7SJ2Kkmj5ACY
         rUboHqzEBtLNfw8eiZgUeOnVp1+f0aE10YsrPx+qsjF84ox9BcEyvnYsREEB6o1pAwUv
         +SuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjOe+kyuuy5N+kuAPg5RQCmPs35+tYu2krkDL5EEb3rvXWkVpWr2tOUbTmV9etCK4YT9l3+6qxa2u4dzr66bPBAf9iEAHW/Rn7BMOe
X-Gm-Message-State: AOJu0YyD2VyVsHgXk0PIlCN4ndUD12zemCucUEtNWLtnybV/u3e8ux5z
	OyKI/Kd3zmpBY2/hA6dKTnyoiuENfq3X0ujWq3mEDxNTLXbwrAtWFK9KyjvXOJ8=
X-Google-Smtp-Source: AGHT+IGrVM7bxfj5E0NLOizkSNAMbKYyDeP6D7vX6g9112K5WjgHB+dI6y702l8DZVu2A3yUQkzUwA==
X-Received: by 2002:a05:6512:114c:b0:52c:ebd0:609 with SMTP id 2adb3069b0e04-52cebd006bdmr4692306e87.7.1719333505154;
        Tue, 25 Jun 2024 09:38:25 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ce448514fsm675400e87.265.2024.06.25.09.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:38:24 -0700 (PDT)
Date: Tue, 25 Jun 2024 19:38:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm/bridge-connector: reset the HDMI connector
 state
Message-ID: <ov4uvlcyzfqw55g567jikyceivpkl7l3ijuol53fqsv2asdgrl@miggxlyyeiek>
References: <20240623-drm-bridge-connector-fix-hdmi-reset-v2-0-8590d44912ce@linaro.org>
 <20240623-drm-bridge-connector-fix-hdmi-reset-v2-1-8590d44912ce@linaro.org>
 <20240625-feathered-loon-of-health-ec7e6d@houat>
 <CAA8EJpq314tQFZpkXgL1cYDPfoFRukhB_KiaDvmsqdzHFD512g@mail.gmail.com>
 <20240625-jackrabbit-of-major-ampleness-e0becb@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625-jackrabbit-of-major-ampleness-e0becb@houat>

On Tue, Jun 25, 2024 at 05:49:54PM GMT, Maxime Ripard wrote:
> On Tue, Jun 25, 2024 at 06:05:33PM GMT, Dmitry Baryshkov wrote:
> > On Tue, 25 Jun 2024 at 18:02, Maxime Ripard <mripard@kernel.org> wrote:
> > >
> > > Hi,
> > >
> > > On Sun, Jun 23, 2024 at 08:40:12AM GMT, Dmitry Baryshkov wrote:
> > > > On HDMI connectors which use drm_bridge_connector and DRM_BRIDGE_OP_HDMI
> > > > IGT chokes on the max_bpc property in several kms_properties tests due
> > > > to the the drm_bridge_connector failing to reset HDMI-related
> > > > properties.
> > > >
> > > > Call __drm_atomic_helper_connector_hdmi_reset() if there is a
> > > > the drm_bridge_connector has bridge_hdmi.
> > > >
> > > > Note, the __drm_atomic_helper_connector_hdmi_reset() is moved to
> > > > drm_atomic_state_helper.c because drm_bridge_connector.c can not depend
> > > > on DRM_DISPLAY_HDMI_STATE_HELPER. At the same time it is impossible to
> > > > call this function from HDMI bridges, there is is no function that
> > > > corresponds to the drm_connector_funcs::reset().
> > >
> > > Why can't it depend on DRM_DISPLAY_HDMI_STATE_HELPER?
> > 
> > Is it okay to have DRM_KMS_HELPER to depend unconditionally or select
> > DRM_DISPLAY_HDMI_STATE_HELPER?
> 
> No, but it's not clear to me why drm_bridge_connector is part of
> DRM_KMS_HELPER? It doesn't seem to be called from the core but only
> drivers, just like DRM_PANEL_BRIDGE which has a separate config option

But then DRM_PANEL_BRIDGE is also linked into drm_kms_helper.ko. I can't
really say that I understand the definition of various helper modules,
but my taste tells me that code from drm/*.c should not depend directly
on the code from drm/display/*.c.

-- 
With best wishes
Dmitry

