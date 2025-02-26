Return-Path: <linux-kernel+bounces-533112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AB7A455DD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35BF1898C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7A526A1BD;
	Wed, 26 Feb 2025 06:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fgA36R8j"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2132026A0C7
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740551926; cv=none; b=uVll3uRLxa5V1fmJ2YdtcoCk3cmMEPfp5Jmvu3HD8IEHMMrtwoAL6Lc/NxvUFX6l9Tt3wFQYOLcNFpvn+A3XMVT5F/iUcY83GvKFaKFN5YicopPRD5VeofVSF596WIRwUqed2TcitttXTv55DiLsX3xo4Up+a1bZ39qJwADPBc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740551926; c=relaxed/simple;
	bh=4zHr+lKCZGLp+AVj3GLsr40g87x+7GH7RBtFf2xj2yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LITIUiz2jL9JtSfUUrc989O6o38N3wmYm7oSZ8gdfrYLGmSUUrV0VJ/F9Mxx7E/tU8W9EFryHE6NIPpWBkv9eYf4AT7ChTdBH7FKAGYuwmxOKTjWvsB1UZbWOT+a/ToH5xNYs6qZfa7HTFgpn3bUQOliVW1juapnPbvfc1IMcWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fgA36R8j; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54622829175so6051344e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740551922; x=1741156722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vdAWglkpNWkKlfVQY0b30qa+fHtrIyjn4IdPv+J5KmY=;
        b=fgA36R8jD1+xHXkh4uHxxApxkvXsGB16E+q1a8FR/pnqQdTSCZRuywp1vQeY+Qwo2k
         2Veh7P++jd93iHwBIoDIWnqz2yNgSw6MMdARwk44Q1knmr+MDVPd35VmG1P8VP8J68/3
         EkiuWFX0xyGbDWlxOkXMIqVqFIdGi72Pd7tkOLHSf8AdAcKviwVq2sMc00ikWZ2gKGA8
         tfl6pL+mci6AQ0vxEdwEAC9yedLKAY/sSauWPKOHE9LzrRlMPyLNxeo3z0CQfF/poFLU
         yogQSIzSQX0bkYvhWbqp9VA4RAQxeF6oioNQ9hLGJGnsgExFNHQT1WoUCyEkvuZHVAxc
         zNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740551922; x=1741156722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdAWglkpNWkKlfVQY0b30qa+fHtrIyjn4IdPv+J5KmY=;
        b=RO8K/QOafQ+bxdYkRpU1jb1G2tKYrO49d/hP0Ds+RphC2Y9Jwc7G13pWy/1I+HsnPU
         tLzf0lygEScXX07AKFHu7ZcdZzIimQYLrhwUIOmaxNVCSY1EtKQ6OeUXiq+KI49032cd
         iJioGl8hPqrUgZwT9S53KfThXhYGI4lA0LIWg1kJGIWeKCFxRXcI8otEjDa2ah4mOvNT
         PIC5IcXL3Sy7Pgo9urwdxwhLz/4EtQMXiOi8/nTH4PwbGj4yAH+LN/24FTwUhhU/dHxa
         wiVxjz1ZUBEogbiFszaaIPIzX8y2raHCF+gofHJmW9/1BuGE4JmbEo5LXls3Yq57K/0W
         WQcw==
X-Forwarded-Encrypted: i=1; AJvYcCXZltB8ytMVe4ZoB0Usrv6NbV4v9vwbKpvcMgiqg+uLSvVtuDIWTilYt6fMF4GMyqIdDCS2jl1pPjcACM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8LjN3wXpFo+sRmlozJIY4EDklFkiz26aW4c2+th6fZGprwSRF
	E1E3COFzznBMKylp12goTvpguc0bdVFugmuhMN85EWawjjWXomRjcbwunqbiI+g=
X-Gm-Gg: ASbGncvXdvKKnhiVQc5va+5qk92wxYJNYFQE1hGqyJ3ONwcPPFEI62o1jI63rw8qDzv
	bSWDeP5jBb7K045uht+tbtph9VuC8/dhPiyfNrzFHyXA48BG2cpy1AxhE24zefCe4Dk+QDAwhxN
	3lw+ThYSNjRFYwtdcriCoZbMyuzqCyekLSw5rG2HbAGyr/RnA6uyZMPGR0KfPWJQj/Puqa6cCRH
	ZdYax416DlxInsIOLnsFYy/NIrYwBAoQOijA5jrmgN7YuQ3f7bulf2Pym2ZufJTrTM23r22JD6/
	lFpl6+zU52t72RiuPp66JwW+WlGCo5EevYhcVCLGrWOA5D5SHPDCYt6uaMXfjWzCOSuT0Z74FPW
	oRvuhvw==
X-Google-Smtp-Source: AGHT+IGIr+d6iAad7GGGqJtdFIIrbosoSV2T/fF6VruZ1PJO3g36OWay8E3V9QE+EEdkJZgWoEXISg==
X-Received: by 2002:a19:4314:0:b0:548:f3f5:b26a with SMTP id 2adb3069b0e04-548f3f5b333mr2954664e87.50.1740551922133;
        Tue, 25 Feb 2025 22:38:42 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514fa94bsm353388e87.249.2025.02.25.22.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 22:38:40 -0800 (PST)
Date: Wed, 26 Feb 2025 08:38:39 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	Herve Codina <herve.codina@bootlin.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v4 04/15] drm/atomic: Introduce helper to lookup
 connector by encoder
Message-ID: <qskzti5jawqioug2jw46zylnax4uxoczvqolwqgbseflqaddze@3uke3rkwbpzs>
References: <20250225-bridge-connector-v4-0-7ecb07b09cad@kernel.org>
 <20250225-bridge-connector-v4-4-7ecb07b09cad@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-bridge-connector-v4-4-7ecb07b09cad@kernel.org>

On Tue, Feb 25, 2025 at 05:43:52PM +0100, Maxime Ripard wrote:
> With the bridges switching over to drm_bridge_connector, the direct
> association between a bridge driver and its connector was lost.
> 
> This is mitigated for atomic bridge drivers by the fact you can access
> the encoder, and then call drm_atomic_get_old_connector_for_encoder() or
> drm_atomic_get_new_connector_for_encoder() with drm_atomic_state.
> 
> This was also made easier by providing drm_atomic_state directly to all
> atomic hooks bridges can implement.
> 
> However, bridge drivers don't have a way to access drm_atomic_state
> outside of the modeset path, like from the hotplug interrupt path or any
> interrupt handler.
> 
> Let's introduce a function to retrieve the connector currently assigned
> to an encoder, without using drm_atomic_state, to make these drivers'
> life easier.
> 
> Co-developed-by: Simona Vetter <simona.vetter@ffwll.ch>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_atomic.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
>  include/drm/drm_atomic.h     |  3 +++
>  2 files changed, 48 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

