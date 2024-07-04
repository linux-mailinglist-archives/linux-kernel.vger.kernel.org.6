Return-Path: <linux-kernel+bounces-241296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1E9927976
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7091C217EA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41361B1419;
	Thu,  4 Jul 2024 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VSiwg0MJ"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4221AED2C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720105382; cv=none; b=lqPj1Muv97qgFFwYJYjawzxLH3G13lqQu0tApY2wpODthf6MmyfaFRDBLM1kdfARwqi6UHU8RgW6oBvTWzx72PCOoYkW92eDs4xwH6ymND3Vf2ztYKfUsz52PoQX488A2QpwYNCbHky4msIJn9G7NxA0GHf08cd3kUt+F995xAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720105382; c=relaxed/simple;
	bh=0XWkE0pJ7/cpA9XrXlWZ+Q4A0jXvmbotHwJ8Yt52BQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MkzTWqXn1HfZWodc/vEa494OmFQisuhHydlEm688V2XuXvnsggwykIh456gdIhzrVk+NjoWdJ6TdZGIiPkiSH8b8QhJq51a5KcMzoCFgvE3x1V5QLTxdutwsIp3UZxe+u7Uxit/RVhs0MLWyg/nDSUiGI5jj0We6Eu5Tps6fEA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VSiwg0MJ; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6515867cf33so6075577b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 08:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720105379; x=1720710179; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3RpEult+PpmNSByOOg7rpoXoPutAbjsE547878wS6dE=;
        b=VSiwg0MJQlS1RpLMLF7q2XaW1lxVw68L1GHEX62XA6zDwXKvsjEGhC5EAOTVril6B+
         FvbVlV59ALIe6Wxhfrno35qNUgCza7lL4XNGJruJ7e36Gp1Th4P0GM8Gp9SzATt54YNu
         wm5zR62DDQZPAmnGfu0fCcIWL+ZynO5Wool9zgaccVDG5mzp5DjGl7jiNlTLbln5xche
         +ph8uFnSSjXM/GSE1D7jqdV0hPZG41SGzqZ5pyaPZIHvWisJvwvSDBaK1hWZHkqodmTH
         5uUgPr6yKFoEpdpt5d2mnKVWUC5jxdk7QrpaKI00qpBnF6pPI508x1yhqcagfEjSJqAO
         aiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720105379; x=1720710179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3RpEult+PpmNSByOOg7rpoXoPutAbjsE547878wS6dE=;
        b=C94eSX/yJykeOEjzvGnQ+6vJGYphGkd3vktTodCnzh9zh69epXwXxAxlS9AUmwGDjt
         qi3DkMTXy/vdSFz8H+UjZrP60bjMfJoKQ99KRZFcYRbU9bPZRfG0G4N77mVprJ5PmFec
         /lVb3WuBC7wnwKRn2J76VQTYsPFnwEJq1eGEO2UAKnX6mQ6+gQc6SM4D87BWhWfDWCkj
         HIm/XQEDVqC0nQYNYbz38MaxvPvIP9qkNL8cHOkQDt+EINaQsGbQN96n/3QoWD9XWRu1
         /H9xTemNvWpqizWKz0TOZR5DWn0sMY7yibrzHbwiEN9k6qTS1b1LKXNnbR1of5xdsHOG
         X8RA==
X-Forwarded-Encrypted: i=1; AJvYcCWGWfHMQSLn+qKD52eyN8BJNND4lcNYQ1kap6VHr46AcJrqL870BGSDwRNTGx1R6XIljyj+fIwUbMLQNe1yerViuGrGTObWEnFj4SR/
X-Gm-Message-State: AOJu0Yxqr0++z617yX7shFdT4jQ/5BU9/PZckXVyraHca5nOYUoMZaRS
	L801nZjJ60/oIhttb9Vbs71EjFKVL0cYTPzVH5Ko94FS9UUXh3Z7n3H7BI4Nq0cZUgMHz3yiJ1k
	WTRYim7wsNFhSArn8H25oefDAT4lAFuzBp9OnvA==
X-Google-Smtp-Source: AGHT+IEWiF8dmPUqO+MUVzpDwFotNDbkSv6rqQebrqrFFAWqvUWEde+EB1RkSLi4dXNcJF3GY4kgFC/uaKR3DkS8eNU=
X-Received: by 2002:a81:431f:0:b0:633:8b49:f97c with SMTP id
 00721157ae682-652d842fd27mr19039267b3.37.1720105379294; Thu, 04 Jul 2024
 08:02:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-drm-bridge-connector-fix-hdmi-reset-v3-0-12b0e3124ca4@linaro.org>
 <20240702-drm-bridge-connector-fix-hdmi-reset-v3-4-12b0e3124ca4@linaro.org> <20240704-jumping-saffron-shrew-d5f3b7@houat>
In-Reply-To: <20240704-jumping-saffron-shrew-d5f3b7@houat>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 4 Jul 2024 18:02:47 +0300
Message-ID: <CAA8EJpr69SoJFu0DMN0+Sk3Ayd7VQG_hPiy3MCfPnN34sR5ADg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drm/bridge-connector: reset the HDMI connector state
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, dri-devel@lists.freedesktop.org, 
	igt-dev@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jul 2024 at 15:56, Maxime Ripard <mripard@kernel.org> wrote:
>
> hi,
>
> On Tue, Jul 02, 2024 at 12:48:55PM GMT, Dmitry Baryshkov wrote:
> > On HDMI connectors which use drm_bridge_connector and DRM_BRIDGE_OP_HDMI
> > IGT chokes on the max_bpc property in several kms_properties tests due
> > to the the drm_bridge_connector failing to reset HDMI-related
> > properties.
> >
> > Call __drm_atomic_helper_connector_hdmi_reset() if the
> > drm_bridge_connector has bridge_hdmi.
> >
> > It is impossible to call this function from HDMI bridges, there is is no
> > function that corresponds to the drm_connector_funcs::reset().
> >
> > Fixes: 6b4468b0c6ba ("drm/bridge-connector: implement glue code for HDMI connector")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/gpu/drm/display/Kconfig                |  1 +
> >  drivers/gpu/drm/display/drm_bridge_connector.c | 13 ++++++++++++-
> >  2 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/display/Kconfig b/drivers/gpu/drm/display/Kconfig
> > index 1a192a45961b..bfd025f8c7b5 100644
> > --- a/drivers/gpu/drm/display/Kconfig
> > +++ b/drivers/gpu/drm/display/Kconfig
> > @@ -9,6 +9,7 @@ config DRM_DISPLAY_HELPER
> >  config DRM_BRIDGE_CONNECTOR
> >       bool
> >       depends on DRM && DRM_BRIDGE && DRM_DISPLAY_HELPER
> > +     select DRM_DISPLAY_HDMI_STATE_HELPER
>
> Sorry, I notice it on that patch, but it's really on the previous one:
> both DRM_BRIDGE and DRM_DISPLAY_HELPER are meant to be selected, not
> depended on.

I think they are selected by the 'driver' drivers, but they are
depended upon by the sub-devices. So all bridges depend on DRM_BRIDGE
(either directly or via the menu entry).
All drm/display modules depend on DRM_DISPLAY_HELPER. I agree that it
might be worth changing the second part (most likely in a separate
series, ok), but I'm sure that the DRM_BRIDGE part is correct.


>
> Otherwise,
>
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
>
> Maxime



-- 
With best wishes
Dmitry

