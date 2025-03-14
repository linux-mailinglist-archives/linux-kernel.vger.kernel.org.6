Return-Path: <linux-kernel+bounces-560632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C94A60783
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 03:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE80019C442B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 02:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D06E2AE77;
	Fri, 14 Mar 2025 02:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NnZWisyP"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEAD2D05E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741919606; cv=none; b=K3GZknDY+TH72XmmduuVFs7DbEVEsI1uGDR2Au6DW+JjWQEN8b6hTqB5yIgdElda+wdraH/U4rq/x7BLJVlr9KGwdhn2fWfIDV/9HkB68emkBGqptAR8ISQ7ETjTF6PhftjSRUec+aMDwszVbvWUIPEqX0U1StIATqK7pw9hnaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741919606; c=relaxed/simple;
	bh=Xd6aiicqCrN8dWJ0GM6H7CcuOeCIMgVg/AOHOO6UJqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNQdS54JXfygwY1XK3tRDGqyPLsa0q/XBqdN3FcRlPHYqV8K5HIN+Mx57meySfNevtWWMLHvtmluiWezn5RZ2srb0sBeILqbdZdQteWOWhDFFCgLkbt6rQSlgLMxGOYrUXoe9QqK7MtHQ0OL0w0ecKzpI8NZd+jLV6QtlOKu8p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NnZWisyP; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab771575040so514514166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 19:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741919602; x=1742524402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=il06D9hr0Fc9RDaH12vgTcO4maMntEHFOsv/sipTbFw=;
        b=NnZWisyPUOWG5doWuQCoDzIbReRXqJnxfX0LC1ALQskgOPQ4T9rq+rV8OF4wjQdNrS
         bZHIXTMTG64EKHxXQYGhkzuDc1E3kYcqgJLxwI9aRnciQyh5bfrIzSGiVoXrEHaLmmx1
         ORZydbOMPxXWj4fOoriDh2Zkg9A1Wqk+TzsKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741919602; x=1742524402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=il06D9hr0Fc9RDaH12vgTcO4maMntEHFOsv/sipTbFw=;
        b=DEC+8KLpOYwHb8TmLkLmAui1w0xvEU41C+C59KObxa460UrQ9CaHF6K61B75VrRqPd
         w+xEMkdjnTKVAfXbi0boC7TYH01cH6tLeR6tOGvJiwHjCtgRLmnp88Xlfu5LXlVRu0ms
         uaiR9iwVZXEiG7QbMtGABRoaBXvHt+43SUA0MZULWHJ1zJ80aMI1gAu2lb8tlcYKj6bc
         8zWJqaIwzdqu3BoOMSPxv7rbHWDB807HNlDNbu1XWHKG74VL5gG9+0Dw5cVx334W8Asu
         vPSbtbuUGeqtn6Ajm87JiPvlDi+eCcnsWRJkg4keGOiYcsQJvT4Ub3rBTwPZF19iMpmr
         sb3w==
X-Forwarded-Encrypted: i=1; AJvYcCVdp4XeHhuh9C5d62Zz+6j83YoMI5NFPUxHS4TzgqtiUMVgs2YViti2JUcv7c5cbvhWen3U4ueuYRK/f1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq6ZM7E5lH6+uQ7bScmGnJ8aqlaYk6WZo/0Vm9ZiVK9o2IXyia
	saGCsuZpv/GumF2ZD2b8dEebD39zs1uiAE0ZIYw5027VBOot9mBikRY1ezZb1u10x6TGJv/DKjs
	/5CHY
X-Gm-Gg: ASbGncssbing8aVRL0Y8pLEIirjBJNSQXc4mzcfu+3EpIYHm1tnKebEASDAjCxs+dTn
	Sly3Q/jF4w2dn6fpQyZGpjbpWC3MkCT69R8FjGLtAyZvbkVKiVVp4wp8l6WHyM1uCwHpJz+c6ch
	euRV8CICHEf/uJf00FhrGDvnngOsDyIX19E1dkUwCNq8RPXVAuWxK7mnkzUP32ulnTcFzzc3Hqy
	af+BcgDExwsejxHzePTP8y7YxGVBsPXNrirjavyeVrkPXJNO9U3vTqiQzc+rjcdmBVm7c3YMbqr
	06Dmi9mJOi49UVCoBA5FNAVWBtSuc6uSov+H1dkePbnsEL8+Kd0Mh+UegKhzsCj4eajAviHxq+l
	FvfgZ2gH2
X-Google-Smtp-Source: AGHT+IH34NWKwvBHsnVnhdlIMIl4rhW1PW6e4IukPemaAMa7/F5Lg4zlP2yVdkHmmI+cYdZSfrEs2Q==
X-Received: by 2002:a17:907:8945:b0:abf:24f8:cc1e with SMTP id a640c23a62f3a-ac31225cd52mr458792366b.2.1741919602573;
        Thu, 13 Mar 2025 19:33:22 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816968aefsm1440933a12.20.2025.03.13.19.33.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 19:33:22 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so3130926a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 19:33:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfTIndquwcx3/WQAcgF55E1ptB81YPbZunb9niHTHAsprq1IBPZ6wOigyLcpezuV624+PY6W//rWAwzXE=@vger.kernel.org
X-Received: by 2002:a05:6512:238b:b0:549:88b8:ccad with SMTP id
 2adb3069b0e04-549c3f97e1amr221177e87.20.1741919289506; Thu, 13 Mar 2025
 19:28:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310104114.2608063-1-damon.ding@rock-chips.com> <20250310104114.2608063-9-damon.ding@rock-chips.com>
In-Reply-To: <20250310104114.2608063-9-damon.ding@rock-chips.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 13 Mar 2025 19:27:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XYt894pPyvRxHAe1LjCXEorzB3xBkAKZzE6Fntfac5GQ@mail.gmail.com>
X-Gm-Features: AQ5f1JrcEIf4cAvd2mSC-J3hgcRSHWlS6TAPo8G1EtX7yAuKQEhPcQq-mGynGdM
Message-ID: <CAD=FV=XYt894pPyvRxHAe1LjCXEorzB3xBkAKZzE6Fntfac5GQ@mail.gmail.com>
Subject: Re: [PATCH v8 08/13] drm/rockchip: analogix_dp: Add support to get
 panel from the DP AUX bus
To: Damon Ding <damon.ding@rock-chips.com>
Cc: heiko@sntech.de, andy.yan@rock-chips.com, hjc@rock-chips.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
	rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
	jernej.skrabec@gmail.com, dmitry.baryshkov@linaro.org, 
	sebastian.reichel@collabora.com, cristian.ciocaltea@collabora.com, 
	boris.brezillon@collabora.com, l.stach@pengutronix.de, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 10, 2025 at 3:42=E2=80=AFAM Damon Ding <damon.ding@rock-chips.c=
om> wrote:
>
> Move drm_of_find_panel_or_bridge() a little later and combine it with
> component_add() into a new function rockchip_dp_link_panel(). The functio=
n
> will serve as done_probing() callback of devm_of_dp_aux_populate_bus(),
> aiding to support for obtaining the eDP panel via the DP AUX bus.
>
> If failed to get the panel from the DP AUX bus, it will then try the othe=
r
> way to get panel information through the platform bus.
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
>
> ---
>
> Changes in v4:
> - Use done_probing() to call drm_of_find_panel_or_bridge() and
>   component_add() when getting panel from the DP AUX bus
>
> Changes in v5:
> - Use the functions exported by the Analogix side to get the pointers of
>   struct analogix_dp_plat_data and struct drm_dp_aux.
> - Use dev_err() instead of drm_err() in rockchip_dp_poweron().
>
> Changes in v6:
> - Keep drm_err() in rockchip_dp_poweron()
> - Pass 'dp' in drm_...() rather than 'dp->drm_dev'
>
> Changes in v7:
> - Include the drm_dp_aux_bus.h for devm_of_dp_aux_populate_bus()
> - Use dev_err_probe() for the return value check of
>   devm_of_dp_aux_populate_bus()
> - Select DRM_DISPLAY_DP_AUX_BUS if ROCKCHIP_ANALOGIX_DP
> - Restore the error check for drm_of_find_panel_or_bridge() which was
>   removed by mistake
>
> Changes in v8:
> - Add comments when drm_of_find_panel_or_bridge() returns -ENODEV
> - Remove some redundant return cases
> - Add comments when devm_of_dp_aux_populate_bus() returns -ENODEV
> ---
>  drivers/gpu/drm/rockchip/Kconfig              |  1 +
>  .../gpu/drm/rockchip/analogix_dp-rockchip.c   | 42 +++++++++++++++----
>  2 files changed, 34 insertions(+), 9 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

