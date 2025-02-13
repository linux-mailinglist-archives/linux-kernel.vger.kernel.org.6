Return-Path: <linux-kernel+bounces-513458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECF2A34AAF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B57773AAA69
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC53328A2A0;
	Thu, 13 Feb 2025 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x7rlWs85"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547D228A2AC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464523; cv=none; b=RkE8M2Z8SNDPvAgZaY28oedRuIRsZsLxfIYuPbI7PDLPEyjJgWAAZMQIxTUZKyiBBvWFZnHVl7LC7jW206tmLURsjyrovFoenqmB2Q13BQ3i99p9FS7yNwgSRFYIRT+DBKKHXK2S01+g2DVylfaF110aKwnm2vFaiLqNZ0ZPEks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464523; c=relaxed/simple;
	bh=yWnW/kJAYxgrx6fkyYdIWUpHfXoeR6EtTDT6T9Ppp8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoV3dHoID3PiFovogZsjqDaFLwrpk7cPhgg4Alp9PIIAeCUyK7v2/Lpc+kineWXEoG/+JbNhAlly+efKlp+6fZjSM4cbwlS1jRLThYW/5wzVgN0u264WlEkEAJKJ7YnZmC6Vb5W4FIOUzlPlIos8zaO8UL65a/hg8W8HPANmyss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x7rlWs85; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5450475df04so1089378e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739464519; x=1740069319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+g5BZbHHAPB1An6Dt98zb4sht9CAKT/HIRa43hMPclQ=;
        b=x7rlWs85AjPPRdmuZ3507bvAb0GqWEDHf23WZVr8/YZJAd2vML1r8Ijzyrfxt/zzoX
         cOotb1OLq4JI7wsGXBpdTIU+xCQKKnDpR643+50s8Y0mjNr9RfLbW0zQ1Bvh3KrRWewQ
         A32K8r/lLsV8LgPJ4dAszHuhNW6dtjOsgy9hLjyO0uD/c5XYaTqPSC2Aa9A3UaJwNkRO
         95GWRanIXC/0sUnp4cRUBey80P5gnN9q1edMJICmciAlnaPioYCkWLO/55k5CvTfcFhx
         7KGSHuM/M5Fq+hxUC09pRT6Ah/FksZYq42tiqUZLrqPRhqMRnAyfAz0p4iGFtLpgnYiG
         Iu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739464519; x=1740069319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+g5BZbHHAPB1An6Dt98zb4sht9CAKT/HIRa43hMPclQ=;
        b=DAO3h53/KQKKKiS11ki9RSoowzZrY1DtWXQDOypg2KJddYXWMUH+sLa/V2uqTi4IaT
         mCXJg0DzGmfdKUAxhVxyJPJbFRKT67RBd2p7WW/jmtgm1074l7AAukikZyMUrPGKfS1W
         HsyuaVTTeTTqNXGK5qGS9/ieG7MbpQa+7UYjUws0WkHC6zZaItwUWkLAEzPmO7LKgKw0
         eS9bvpt+UWS/pEG5Vs/SZmvMm8/lJ45r9LQHHP0IHmOwQlrHyxrw9LBD2wxz1idzklRQ
         bq2H1CmIMb26T772f4X4PwimZAwePGstINPIr3mFUQspe1LstP4A2AZKIqYp9gz7m0K0
         ohsg==
X-Forwarded-Encrypted: i=1; AJvYcCVvaKIcn8UerypbSpvzyPkWC3RKsK6AtAmblzC0eYw0bTeZ2JuD6517R3DoFfJwGdy9ExVLCuhYKeedoPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4+TROgVOUWEtWHXUS99LpEv6eN/NYla39n/ZNoKC53OnPXMpk
	3niQKHzfMbKwj4L49sF/ZAgkJVZRaiInk7cYiE4EaBSRv0jNd9u9kS8CrocJiSA=
X-Gm-Gg: ASbGncvxz7ME+Z3vmlitV2AU+Sgg/aywcai9cSEhlGCY/HlKloAh6EB+A/gzOUOgkja
	xrC6inUlFAv4wnAhRySwi60zPyac90t2XzKKjWg1+VNeqQubwY3pBlX991CNx7/yWRnuOYE7epn
	m3ZyyiJ7cwxZWwIkwIftb6jVlW3FQkCr+/JHFOMLTZaACQMSGgh5p3byGU3xbEjqAWuFfiFeyaK
	BZIN/twtjt7frxLqLWOdwmCR+h2YfCiC0fIaseHA89NE+GHdggMrHPcII7PDKH1sGZWaseRlM+D
	ZYuAw/lZy7CIX/iAvbMMVz+K3kqrOPOC+taDheK/L6rQXV27BeP55Wiukpv46mNyZPKFZWM=
X-Google-Smtp-Source: AGHT+IGKjcVYYqdaHVsMaxCCVB5KBYPSpTeBQ8LjU/GvaZgQpd6IvYwsCf50qVtW9DHkVjgHmROd7w==
X-Received: by 2002:a05:6512:3b2c:b0:545:95b:a335 with SMTP id 2adb3069b0e04-5451810cb35mr2704828e87.14.1739464519298;
        Thu, 13 Feb 2025 08:35:19 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f11ebd6sm215877e87.214.2025.02.13.08.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:35:17 -0800 (PST)
Date: Thu, 13 Feb 2025 18:35:15 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 32/37] drm/bridge: Make encoder pointer deprecated
Message-ID: <nfb4fb6lzjw4j5brsh242htgw3au2moklqjalfa3zzxjsi2qn5@l3censelmgbz>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
 <20250213-bridge-connector-v3-32-e71598f49c8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-bridge-connector-v3-32-e71598f49c8f@kernel.org>

On Thu, Feb 13, 2025 at 03:43:51PM +0100, Maxime Ripard wrote:
> Other entities (drm_connector.crtc, drm_encoder.crtc, etc.) have
> pointer to other currently bound entities. They are all considered
> relevant only for non-atomic drivers, and generally perceived as
> deprecated in favour of the equivalent pointers in the atomic states.

I think there is a significant difference between mentioned fields and
drm_bridge.encoder: the former fields are variable and can change. The
latter one is static and set at the bridge attachment time. Nevertheless
I think it is a good idea to deprecate it.

> 
> It used to be useful because we didn't have alternatives, but now that
> we do, let's make sure it's done for drm_bridge.encoder too.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  include/drm/drm_bridge.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

-- 
With best wishes
Dmitry

