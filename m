Return-Path: <linux-kernel+bounces-518271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3099A38CB3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98BAD166139
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B477422B5A3;
	Mon, 17 Feb 2025 19:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P+/Mf2xt"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE36372
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 19:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739821679; cv=none; b=qRrzfo8czwe7OQTqZixtMZhWLoLnI8FP901CYL5Pxp4RZuqnTLHuSEPEsrSvdG6xg6KDHUloDv9K3fvwNjWGpRsV8FK4JUX6P/F1z2zMTaD8yzMS52Iul5wAMqeI6vWeBTUFz5kGU0w4flQPvOpwI0OmpfaDKMtiY4d3tpt4ZcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739821679; c=relaxed/simple;
	bh=SkwZ2w0lamryusYY4ciCnWMf1D8dgvFgw4aD7cKPiwA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuKpV8USJoe/49UVRGoSWdjWW4hrxLW9PMUtnWmeNepRBwYFFnUMDNfzOC/MvIt7oGnUi+m1zKu4Y+GoBi62yXS1ooFOVxFLWa7HRNFCkoXlOiciNBRVPl6AA6AkFrSvA7QMUOYidLOnBw5z8ajiWoNOSrcEmrQYKI2bPUfUXJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P+/Mf2xt; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so4727598e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739821675; x=1740426475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p/HiC3hU7W8x9xtMSQInvGC02cUUR7tDCJw/WUMoZi4=;
        b=P+/Mf2xtlHShXB1Z72BAkxlW3pqjyAz8tIoD/UxelmsAVxlbemejoARRMV3O4poskl
         2f7hD+jfiq/KebMq4QqL5jC/5QWC5VHFJCYaVRRpQrJWOHFfUwpyTbeCxWr/rROb8SvT
         i4cHQyP0On62yB3M0WS7l10cMExky8JoqQ5hI3Yv+DqrBqz5Lfev9DRrftfNn2HZXmyh
         FzhRGAw1JJT2Eu/gwVFsLIQBW71tJcpdDrY6FLuH3oF2Ph5ZmrmzXeyMcyiu5fcSLXw5
         SB4LqRmuFIU65y0/EQYpdSK+ECKc9i6VWAbWomqqFtBcSSFVq5MOyTozOEdK1gLTDoXV
         DJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739821675; x=1740426475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/HiC3hU7W8x9xtMSQInvGC02cUUR7tDCJw/WUMoZi4=;
        b=CTYh/7IbzWDVOGFRUHb4JUHGeIQaXjgCXs6uP3Z62oPVK/xR+sqca+O7AqZ3AuLwSn
         pCLBi5NgZ6H9EQ80xDJXB3QDPHtL/Wl/KcJNlAFWD8CkfyYiqiduF2CxnP4jBhf9TK9R
         WpoF0hXkoNy0+ym6/gabXvw8+sw1e4ieRlBZ7m4yR+CBy7EtLywXZ/aUr4MgsNj1oVUi
         X0+wsGYx26uO36Uy8mf29DEccgSWJ96kE/q8+TApPvO9Jao326R6zM320g8Ko3ZBvn4y
         Fm+/m2JBQ31Ef7zPRcOIBDYYJwu85sm0u8Hqu+e7+17bkKErRicwqN1W5lLG93s2izqm
         UfAw==
X-Forwarded-Encrypted: i=1; AJvYcCUx9TRmmzF+uvjQvXAi891XoUiMgpkINGUBbkK+R/8toKuol2Mc0ZI2KcEX1KAWpepe5Jb3dgZXlk//WSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN61QUWWnGbhlhqLMYJbJr2S8ISe5J8CyvtbnEargGxjmIj/YF
	CHTYFJhFhQC20xpeGnVnXghMoyO419GCHrw2F3+XJ491xcAj03U5cz6jOpQA+Q8=
X-Gm-Gg: ASbGnctCK3TXk0pEadrPfwsDeu9B/ucRyfMbFS4uGc1Spf2Ks3c3R1upI11EOHctBxG
	GrMu1rEQQZHJlY3IqN6NwFx+nW2L+RZVzN9y/gbhuaVymeFZNiRqHgQMVdq+ssut6GWrHTsZCTr
	9DH+FjaWJqF5fhpwiUmOp8QrMjGJ9ri/YzEkmCUkxERsrdivJf2we4gfwZtUpayRCDoTzBouI0s
	Z1tVrSC9mqdaPjeMT1tcBWwjOn1cc3IJLwDQIv2T7DYVzWePPG5fxJ6xdlQLqNfi91ohEQMBdU9
	P19G+x7d5nRsytYfdeaH1PVuqDSOyuJkUJw/XTn3716VbwwKvwSMT7BapoZK3vZtiVTBFmg=
X-Google-Smtp-Source: AGHT+IEyW9gnl6AxRgNf+cTRw4yWiriWXFGVNouMOXVj5teJibUT/tWX/bcCfAWYd9bPM73A2ArFrg==
X-Received: by 2002:a05:6512:ba6:b0:545:2fa7:5a8b with SMTP id 2adb3069b0e04-5452fe3aaafmr3876097e87.27.1739821675112;
        Mon, 17 Feb 2025 11:47:55 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452684a9eesm1408371e87.32.2025.02.17.11.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 11:47:53 -0800 (PST)
Date: Mon, 17 Feb 2025 21:47:51 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 32/37] drm/bridge: Make encoder pointer deprecated
Message-ID: <dksptjtgipcuuivp3tud5lhghoiqrak5t33m5pz4jtssegz75t@fanvtjdmy2pp>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
 <20250213-bridge-connector-v3-32-e71598f49c8f@kernel.org>
 <nfb4fb6lzjw4j5brsh242htgw3au2moklqjalfa3zzxjsi2qn5@l3censelmgbz>
 <20250214-arrogant-strong-hoatzin-efdcd8@houat>
 <yy37e4kne7i2hl7coix6v7vajb5bm4zohod4fdzayvxr52l57u@cxturs2uxgcm>
 <Z7Nl8JiFncngynNy@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7Nl8JiFncngynNy@phenom.ffwll.local>

On Mon, Feb 17, 2025 at 05:38:08PM +0100, Simona Vetter wrote:
> On Fri, Feb 14, 2025 at 03:29:12PM +0200, Dmitry Baryshkov wrote:
> > On Fri, Feb 14, 2025 at 02:07:18PM +0100, Maxime Ripard wrote:
> > > On Thu, Feb 13, 2025 at 06:35:15PM +0200, Dmitry Baryshkov wrote:
> > > > On Thu, Feb 13, 2025 at 03:43:51PM +0100, Maxime Ripard wrote:
> > > > > Other entities (drm_connector.crtc, drm_encoder.crtc, etc.) have
> > > > > pointer to other currently bound entities. They are all considered
> > > > > relevant only for non-atomic drivers, and generally perceived as
> > > > > deprecated in favour of the equivalent pointers in the atomic states.
> > > > 
> > > > I think there is a significant difference between mentioned fields and
> > > > drm_bridge.encoder: the former fields are variable and can change. The
> > > > latter one is static and set at the bridge attachment time. Nevertheless
> > > > I think it is a good idea to deprecate it.
> > > 
> > > I'm sorry, it's not clear to me here what you want here either. Do you
> > > want me to change anything to that patch?
> > 
> > Well... I was thinking if we should expand the commit message. Most
> > likely it's fine though. In the end, I've r-b'ed the patch.
> 
> I think this one is wrong, since the bridge->encoder link is static. This
> is unlike the connector->encoder->crtc chain, which isn't, and where you
> really want to go through the atomic states or you get funny stuff.
> 
> I don't think we have bridge chains with multiple connectors though, so
> this is fairly academic and so maybe still a good idea to make this all
> more flexible? Unless I've missed the memo and atomic bridges have
> flexible routing, and in that case yes this shouldn't be used.

No, bridges are still attached to a single encoder, however I see
Maxime's idea in uniformity. It's easier to remember that all direct
pointers are deprecated rather than remembering that bridge->encoder is
static, but everything else is dynamic and should be accessed through
the state.

> 
> Mildly confused ...
> -Sima
> -- 
> Simona Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
With best wishes
Dmitry

