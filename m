Return-Path: <linux-kernel+bounces-533062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEC3A45553
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67F0F188BF4F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1162E267399;
	Wed, 26 Feb 2025 06:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IIh1lWDD"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A913596D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550356; cv=none; b=Wrd+2CuH1Olm2U5i1uplV+rC1e17ELpc16n8b6tIfmm/Ul8V+CrvvUgbnUkhOWD2zZxjabUuwFBahCSVfvBL0hM8qRD4S0KOJMNg4nSDijHJwxSTE55NYJO+wigoJrp2M9Yt7cvDHxseDhwa0z4TN4vtQVE2jfDY/RIoCSOCwz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550356; c=relaxed/simple;
	bh=WOQXDp5riDI+4FrPcTDf1jOFc5q0usC0W0DmxIklFWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4sunEZEAntREaF5GNRUHCDKM59Vl+m2wo/qHALH1Uz74xmMafa1cx0InPOgVQRgs9C9scNRB2wpWo8yoJZiqEngmpy3LDQ8Dw62G2ugsTepPmqVxDV31/PvmMcTDaeWQLlRfvNuswgfD7LsYmgLuPeJbpFcfhz71bQlUYFMRkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IIh1lWDD; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30613802a04so68315221fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740550353; x=1741155153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IaruDcylLEm+Tejyz9t/dN5GAS7R88L1RYxNud2d5xM=;
        b=IIh1lWDDQ2/nzfzvfAWUOd0lkeMG9MAiigRm+LGIexuzCnBe4XkluhsWLJo8NhJSlH
         b8pi4AdcSDAGFfpVvMwUSrGq+4yDzpGiQ+woSlUctL7YgyhQsKi3tASbhrY6+GMsi4cx
         F4p9qXqyCxzGYVTX78m2ChV+8W8g4bNXGhykVqaqhFGKrvcAYOBvsY4DuK790Is9WOxL
         y6qY8nymHnxI+n3HjRHB7caMRVWbZrWNt/c6cZK/gyIhaJ+fo2IviqUkF1t4upAMlB6x
         ZmyWzSz9+facOyOWaq6RclACb/ECRFuQGMMNWRSZ7PGEzEEvWGp9fkMnMnYuvO8CdN0/
         DEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740550353; x=1741155153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaruDcylLEm+Tejyz9t/dN5GAS7R88L1RYxNud2d5xM=;
        b=YOcz3BI0DTp4U3a8kH02edAybgpMpwW3CXhxZqnW28xG+ZONxVA86DJkqx+SMY8jL2
         RZeziqFi4xlA8hOZrDtvQCKnY91W8KTcSL1+2fXGI6lW5ew9eD1HD/+wMA+LZxJv4lG8
         wxK+hrJY3H7KB+Pza/OtTgFDMQA66ShoFHIXvFj4sPP+NPqKJx3XzivU8f8+INqe/ObB
         xCgsHy2tMNRM2EQoju9QGRQTzUp8f9gNCF1lwHRidPUBneEwO0CJ/b3Wx7Y6rx5aHsYI
         ofAsvgpiViAjzLgf4ORJFEvWCGXpNx13AaBGP3+vjG63+/BH3VBf6fYabY9DmHpcImq2
         n0qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU15Vb07mhipDK1LkbqxoOj0TbcMjckB79d/Sh5/lW0/N1PiQVSirNQq6xVXfbi9H9h9N9UjYmD0fw27Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq6Ergwz2VJdDeoTPemMfdvRlzvH4M86TBWMtt/zi08PbMunyO
	8pmhwgRB4FTwfB/ioXMOK4oSwKjtlAzTFP3j5r3K5gVQfjQkzhMV1y3J7bRdxJw=
X-Gm-Gg: ASbGncvGRZ9cOhpunzhQ+EcER5CmyoVV9Se4H5bdE09xRRwIwrNADd3Ck6iSiE8aicJ
	ZFuPFhoiGA04B8RCu7UkAH5T06e6qMlykyZXlrjZi9e/2KNyh4EOinCywaa7Kp9g8EkiqyhroCl
	ihayzR0lH6bQm4Q6cJbtyuIwqKlurLyd6JfLLjTDmgxBJRzdNooEKnzC44Oor/T+l6fuZa5cnZa
	RP9UHFf+zjQW/waDTrMKz6kvXDMhXURJtLamYEkKfxhLvs5aA5S7FFZtVhygSgVbuEQPg8VeWTV
	NHjNWOUce4KtQpoNJ+s0anDQ4NfW015rI5qpp93xsCb4ffsWXXOVuoND2RfhFlAO8iIo/sME06a
	TRph27g==
X-Google-Smtp-Source: AGHT+IFz6ZRFFfoWvl+wT0LHyq+EB0DTesxFaL6W97Z42BiDtgdF9wEmDGfGKV2JzCVZFJiUcR0nIQ==
X-Received: by 2002:a05:651c:213:b0:308:f6cf:3602 with SMTP id 38308e7fff4ca-30a5b2046d6mr91106011fa.25.1740550352580;
        Tue, 25 Feb 2025 22:12:32 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a81ae8193sm4086641fa.105.2025.02.25.22.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 22:12:31 -0800 (PST)
Date: Wed, 26 Feb 2025 08:12:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	Herve Codina <herve.codina@bootlin.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/15] drm/bridge: cdns-csi: Switch to atomic helpers
Message-ID: <g4jq5pntacp6alieq6uejskblmu2hnvvdvf3k4e54yvnjl65m4@xqs5yrcptpmz>
References: <20250225-bridge-connector-v4-0-7ecb07b09cad@kernel.org>
 <20250225-bridge-connector-v4-11-7ecb07b09cad@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-bridge-connector-v4-11-7ecb07b09cad@kernel.org>

On Tue, Feb 25, 2025 at 05:43:59PM +0100, Maxime Ripard wrote:
> The Cadence DSI driver follows the drm_encoder->crtc pointer that is
> deprecated and shouldn't be used by atomic drivers.
> 
> This was due to the fact that we did't have any other alternative to
> retrieve the CRTC pointer. Fortunately, the CRTC pointer is now provided
> in the bridge state, so we can move to atomic callbacks and drop that
> deprecated pointer usage.

Here and in the next several patches: commit message in no longer
accurate. You've dropped the drm_bridge_state.crtc change.

> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 31 ++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 9 deletions(-)
> 

[...]

> -	mode = &bridge->encoder->crtc->state->adjusted_mode;
> +	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
> +	conn_state = drm_atomic_get_new_connector_state(state, connector);
> +	crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
> +	mode = &crtc_state->adjusted_mode;
>  	nlanes = output->dev->lanes;
>  
>  	WARN_ON_ONCE(cdns_dsi_check_conf(dsi, mode, &dsi_cfg, false));
>  
>  	cdns_dsi_hs_init(dsi);

-- 
With best wishes
Dmitry

