Return-Path: <linux-kernel+bounces-530366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A09EAA4328D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4D0B7AA7F9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2378186344;
	Tue, 25 Feb 2025 01:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IaBIjkdg"
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF2680BFF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740447702; cv=none; b=bZeoluLkWwUcSvxEx2rzyLTqON7R9Tr1sMDLSLy/ZdYYiJneIHjHxgdg7qsqjJ3bNJc/qSvgOuvzxWPQ8jKzauALX15EhqmtmWLlVuMfb2/Li6WqQpitI2AViVpCQOSWOJqq2XF35r2oRAHdcpOrSZaWz3s45tMY2JrX439i3+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740447702; c=relaxed/simple;
	bh=56s1IC8cuxy/QSKKPimVmdpa8uC9DroFpVGbP/vkGE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/zAfOnuz/e6ZStxX0hpwNPLgUnGuaqWcgqPWGlabN51gaywM/WXco18R2gnhhZfmt6CpBhqTe9n964Ion+x+imw3DB9n90IssPx1s9pjiBz85fM5Vl3SF/zGiyZ6R8GFwMOywgYn9w4wlTe8faBcnFg1qxAcTKJWcscg7ML5E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IaBIjkdg; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-543d8badc30so5861928e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740447695; x=1741052495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpinBTLgUsFr4FW8ynMBn6mnM1bFPNOn+l/M0TzxPak=;
        b=IaBIjkdgaq97QAVgD2fOpYhafzZDvhjFD9l1Wl3G/B4RwF9/TOeh5/A1hczLs0MfsP
         BievUb3Urt3y3AakgWomGh0bjasvm8c+zSmTmqgjLADmW0ugWhq7Dw//ELeO7xQXAkEE
         +BeNXaxT/ewhEseJ6UX3h2bnciNMCpUY2fO/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740447695; x=1741052495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpinBTLgUsFr4FW8ynMBn6mnM1bFPNOn+l/M0TzxPak=;
        b=G0yVSrfXtXkddqGCMfZjkhg6xjahMo1SooZOi5sy/qM2QOoqmniNN0JkAn2372ycFN
         2KIEnrkVcaoBjG0Ce45rE5zf6bPWEpBhn+Gd7+jUjuHG6UyqskpS5R8RuLnGiwpMr8//
         cyib8sFCi1tYumsJDxVPnOsQXt+A9yOosHxtKeGnqURi57K3344KVHBRjf9TdVLG+i1V
         dN65PgGY0VOJLeX7hr6qj+rfwG3W39F9LteTfi1yBOoFqY+DmFVDaMPAhnj+ZZq1egOg
         ocyoz/yTBir4BrzhfisC2EbAcz/K3YulkvMTFHDUYOZRnH/oWpxRfvgU7ELY0qCZLk2O
         n4gw==
X-Forwarded-Encrypted: i=1; AJvYcCXtquVpbEK1CS+kXYBdfeP0hcxbcBS3ye5bAjfKElWibUK1zG9VHZH6AE6QWGqy56eKBeUrS6ohmVbwDdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3oehxJlSPogWRKmiPppsRyAjPUx0JAO5TGuo0MtEvI5mkjNH7
	bYUD3FwrQYanrNM0l9+HGnqsOdssk1FQ8II3KetKBfLY5JK4Gsg4VOzqzcVfdRyVcZaLndORjqd
	WglRC
X-Gm-Gg: ASbGncvD460r6HPd/VRPu5TGuLSkxzGgX88xWstQyLKrfWxDzWMhPUdJ9H8ccEQuYuQ
	DTbtCOVmAopzlnxbDgcdAUQ42ryNfbJOoWChFHkpAmQ/IjT5CWe/UbpOpObHMxhflJ55h9bqewz
	pnrsdSJ2Nzh+WYeU+qnMbAeZZfHe+quZItMlEae4JXe5JyZU5UA+A4vcSleQVQc5fzJrN0dmxCN
	sRc0X2NKX8VHusxlTko5rAS2f1Hnb2JFWsY3hR24mYoCjp6vGCDulh4/x9RvAv2//z/mGfX3/OY
	D48jKOPxp7Bq5gQ7xyZ+YfiTVYGGfnAKokZvhyFJsG5x0RiApSra0gl1z0PKcwoOcUnrcg==
X-Google-Smtp-Source: AGHT+IHa2r7vMr69NZ9duveiE0t6gRJenjwxUJt0cCkEIONeDcGd9kBk/y7KPM1TxObKkB7ofxGepw==
X-Received: by 2002:a05:6512:39d0:b0:545:2b24:c714 with SMTP id 2adb3069b0e04-548510d283cmr441034e87.18.1740447694793;
        Mon, 24 Feb 2025 17:41:34 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5485147ad5esm52390e87.0.2025.02.24.17.41.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 17:41:31 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30918c29da2so53677791fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:41:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVffflWJo1DsUzrnP7cTXA0CVeF2SL+T53+3k21H0NHK6eSzBRwsuIuZjIIIq+Jgk1ZIhwquWkhriA1kvU=@vger.kernel.org
X-Received: by 2002:a05:6512:12d3:b0:545:5a5:b69f with SMTP id
 2adb3069b0e04-548510cd51bmr337321e87.9.1740447688736; Mon, 24 Feb 2025
 17:41:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224081325.96724-1-damon.ding@rock-chips.com> <20250224081325.96724-10-damon.ding@rock-chips.com>
In-Reply-To: <20250224081325.96724-10-damon.ding@rock-chips.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 24 Feb 2025 17:41:17 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WoigDDTG6wTK0smsxASVfK5BzzW6KNpKWq97v4GAgvmw@mail.gmail.com>
X-Gm-Features: AWEUYZnKr8Y-H4FsK-guhyhHxicg1iDHnSI-Q2A1gzO1kxk46bWqe3yORiZ3SvY
Message-ID: <CAD=FV=WoigDDTG6wTK0smsxASVfK5BzzW6KNpKWq97v4GAgvmw@mail.gmail.com>
Subject: Re: [PATCH v7 09/15] drm/bridge: analogix_dp: Add support to get
 panel from the DP AUX bus
To: Damon Ding <damon.ding@rock-chips.com>
Cc: heiko@sntech.de, andy.yan@rock-chips.com, hjc@rock-chips.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	dmitry.baryshkov@linaro.org, sebastian.reichel@collabora.com, 
	cristian.ciocaltea@collabora.com, boris.brezillon@collabora.com, 
	l.stach@pengutronix.de, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 24, 2025 at 12:14=E2=80=AFAM Damon Ding <damon.ding@rock-chips.=
com> wrote:
>
> The main modification is moving the DP AUX initialization from function
> analogix_dp_bind() to analogix_dp_probe(). In order to get the EDID of
> eDP panel during probing, it is also needed to advance PM operations to
> ensure that eDP controller and phy are prepared for AUX transmission.
>
> Additionally, add support for &drm_dp_aux.wait_hpd_asserted() to help
> confirm the HPD state before doing AUX transfers.

Maybe move the addition of the analogix_dpaux_wait_hpd_asserted() to a
separate patch?


> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
>
> ---
>
> Changes in v4:
> - Use done_probing() to call drm_of_find_panel_or_bridge() and
>   component_add() when getting panel from the DP AUX bus
>
> Changes in v5:
> - Advance PM operations to make eDP AUX work well
>
> Changes in v6:
> - Use devm_pm_runtime_enable() instead of devm_add_action_or_reset()
> - Add a new function analogix_dp_remove() to ensure symmetry for PM
>   operations
>
> Changes in v7:
> - Fix the misspelling of word 'operations' in commit message
> - Remove the check related to CONFIG_PM
> - Remove the unnecessary call to pm_runtime_dont_use_autosuspend() if
>   devm_pm_runtime_enable() fails
> - Remove unnecessary function analogix_dp_remove()
> - Add new function analogix_dpaux_wait_hpd_asserted()
> ---
>  .../drm/bridge/analogix/analogix_dp_core.c    | 37 ++++++++++++++-----
>  1 file changed, 28 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index a57e06d303a1..ff81c37dbe1d 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1548,6 +1548,22 @@ static ssize_t analogix_dpaux_transfer(struct drm_=
dp_aux *aux,
>         return ret;
>  }
>
> +static int analogix_dpaux_wait_hpd_asserted(struct drm_dp_aux *aux, unsi=
gned long wait_us)
> +{
> +       struct analogix_dp_device *dp =3D to_dp(aux);
> +       int val;
> +       int ret;
> +
> +       pm_runtime_get_sync(dp->dev);
> +
> +       ret =3D readx_poll_timeout(analogix_dp_detect_hpd, dp, val, !val,=
 wait_us / 100, wait_us);

More than happy if someone else wants to overrule me, but it seems
weird that you're looping over a function that already has a loop.
Shouldn't you be calling analogix_dp_get_plug_in_status() directly?
...and if "dp->force_hpd" you probably shouldn't be polling at all. If
HPD is not hooked up I think we decided in sn65dsi86 that we should
just sleep for the maximum time (choosing a conservative value if told
to wait forever).


Aside from that and the idea of moving
analogix_dpaux_wait_hpd_asserted() to a separate patch this looks good
to me.


-Doug

