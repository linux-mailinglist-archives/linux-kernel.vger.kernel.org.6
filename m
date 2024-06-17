Return-Path: <linux-kernel+bounces-218213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3895E90BB2F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 21:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1DE11F224DE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CDA17F397;
	Mon, 17 Jun 2024 19:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qSw/oNcY"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFFE1BDEF
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718652893; cv=none; b=YszCjevBHLje4eHNxYTiDGZ+zRxMW/ghsbLJJQdz26gzdH6JxIy2SuJ0I4lJtuA62L3XZisJuz968MdXKbGu+7RU/0AYxx/0XG0AsNuSu/aFUR0n1c4mbT+XfOiEHpkfGPu5vbpQ744ASstWGs9inG8klAKH1aOW+BjXs4WTLE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718652893; c=relaxed/simple;
	bh=yl7ygd5G6+q2p+AP/NYwNytu/Og8YgGncMLlyYxjxuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLmgFF8S1eNI0VTgkfWeflkynvjKYKiUTQAs+voFWF516agMbFLf6XmxwdwU/4c4j3e8c1ZMH56jC9kIKq0fhc7e6yAvze8TqygBCBdyqXziDdyNMmGLtefe8ZHCu6GerC9ecUuILLPV5qSkbtXFfl5eRgCYLHZAiMPS/6CWyW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qSw/oNcY; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dfab5f7e749so4600624276.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 12:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718652890; x=1719257690; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lTah/B+6o/9BifqLB2EY6X3bjK54colO4RjpfhkqoEY=;
        b=qSw/oNcY412RSc+9TaPm4lt+2XEmSkJ0lzWDtxVBBZi+CWv8NIEGw0LHUnYZTJdscB
         UbggU5qAP7sck3/ylPSoUwQdwMzbK/JBOHt/oF/OQWT5dGiUWXs8dpB1tTY2Ampr/3Nm
         y25/8LXMUGsp7uDpA5mvp5v6UTZaOXFxsADQWJr5sqXo8JGb0kk3qKHC/L6fpvfpxXVQ
         Deo8UVGHZM8NjPd8OqHBZA167TkkWDs7O5g50q8bkfs80az6Ivx3QDd3V9qWmkgtnMTd
         3g2lUmkTgKX0S/8m/C8L9z4nAm7n++bnewXNFPYzNR5VLW8XdRqt9DtapNzWjLgE4150
         Osdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718652890; x=1719257690;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lTah/B+6o/9BifqLB2EY6X3bjK54colO4RjpfhkqoEY=;
        b=mAKE82Pmg1FVijLOgDg8epsvxgs8oIIMxaobgbFe3tU2ltZeRuY/vfTsUtaqverQMZ
         iRYS7SHejM1LkklEA0TbA7y+gZUL1ZlOkyuXK6+HljvvKt49HeNc2iGb2v8W4UsNS0Jj
         CvgtlQ554yq3tVegN8izElx6hlsYSJPIwY6LJ1VsaMAbXOgxBdWMUN9O+2f48mreOXZQ
         eme9KMiPe09otwAnO94QXVFbCtwpk6AvYJzxDljyH935rmbmA7HpqzM3th2nRxiXp3BH
         1r2F3ZlOEDmAztjRv8tAWnRS8Ru9siwkre9mBkbc4qyr2LKyTYqfXG9dyHH2ExUkOvDw
         N2jw==
X-Forwarded-Encrypted: i=1; AJvYcCWgjKMwlmdpS/8i7Gckm/uhaSh6ZGVDVt4P4oNhHvoEPymhXazztS0EAuMDBjeP5SGzqikDDQQ5g2/Ig8KSkTKOizABYVqgTR5zbHSO
X-Gm-Message-State: AOJu0YzXw2xjAD7BaurqcwbZXxwe7SKGvMu0Gk3P8FKRkuSULMv8vdel
	W2kGNpgXkycJhHDn8riZLHRa18WBS70PVyN1sXnc8CJ5Myd8hWyC9OBU/NIpQ5LhrUSniP75fUf
	SP9sf5VjX9xaSoO+vs/e2kJNZRuczSxKVeuqNfw==
X-Google-Smtp-Source: AGHT+IETQc6YgGmsfsXMKMUHNOkYN7aTQy9yPirXNwAulNuwGSkh6KBKg+P+Bnjk61peJb2wqP71cDS5gMSMhNkLmdA=
X-Received: by 2002:a25:d885:0:b0:dff:3ea5:c4a0 with SMTP id
 3f1490d57ef6-dff3ea5c6efmr3873797276.59.1718652890295; Mon, 17 Jun 2024
 12:34:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617105311.1587489-1-a-bhatia1@ti.com> <20240617105311.1587489-3-a-bhatia1@ti.com>
 <fyxer3rl54uq7qemgjx7htykgsnwgg5ywda2d5f4fhzd6ksjfg@blvkbzdy6op5> <41fd6509-33fd-4e7f-9889-e7e9acd928d8@ti.com>
In-Reply-To: <41fd6509-33fd-4e7f-9889-e7e9acd928d8@ti.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 17 Jun 2024 22:34:37 +0300
Message-ID: <CAA8EJpqt5FVjP+MP6kf6KaMi_OtEXQ2FgoqVfJCxRuLGfMOkFg@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] drm/bridge: cdns-dsi: Fix the phy_initialized variable
To: Aradhya Bhatia <a-bhatia1@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Jyri Sarha <jyri.sarha@iki.fi>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	DRI Development List <dri-devel@lists.freedesktop.org>, 
	Linux Kernel List <linux-kernel@vger.kernel.org>, Dominik Haller <d.haller@phytec.de>, 
	Sam Ravnborg <sam@ravnborg.org>, Thierry Reding <treding@nvidia.com>, 
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>, 
	Devarsh Thakkar <devarsht@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, Jai Luthra <j-luthra@ti.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Jun 2024 at 17:16, Aradhya Bhatia <a-bhatia1@ti.com> wrote:
>
> Hi Dmitry,
>
> Thanks for reviewing the patches!
>
> On 17/06/24 17:29, Dmitry Baryshkov wrote:
> > On Mon, Jun 17, 2024 at 04:23:03PM GMT, Aradhya Bhatia wrote:
> >> Update the Phy initialized state to "not initialized" when the driver
> >> (and the hardware by extension) gets suspended. This will allow the Phy
> >> to get initialized again after resume.
> >>
> >> Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
> >> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> >> ---
> >>  drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> >> index b016f2ba06bb..42565e253b2d 100644
> >> --- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> >> +++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> >> @@ -1153,6 +1153,7 @@ static int __maybe_unused cdns_dsi_suspend(struct device *dev)
> >>      clk_disable_unprepare(dsi->dsi_p_clk);
> >>      reset_control_assert(dsi->dsi_p_rst);
> >>      dsi->link_initialized = false;
> >
> > Most likely you should also call phy_exit() here. And in _remove() too.
>
> I agree that phy_exit should be called here. But why in _remove()?
> Wouldn't having phy_exit in 2 places mess up the internal ref count?

If suspend() is going to be called in the teardown path, then it's
fine to have just one call here. Otherwise you might add one guarded
with if (phy_initialized) to _remove() too.

>
> >
> >> +    dsi->phy_initialized = false;
> >>      return 0;
> >>  }
> >>
> >> --
> >> 2.34.1
> >>
> >
> --
> Regards
> Aradhya



-- 
With best wishes
Dmitry

