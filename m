Return-Path: <linux-kernel+bounces-330185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D4D979AAE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8EC4B23101
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 05:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F95A3A28B;
	Mon, 16 Sep 2024 05:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u+nd4VZI"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3C438F83
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 05:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726463718; cv=none; b=cQSVoKBcGHzpSA2gZSFmp6KcwKrtYq230LuoI5cLayqMDsh9Wu5wwZjhZBSBEmSRZC+oHLo5CuyVQRS8TVt5TGjuzJmXLmFBtWh7+akm53W8s8O1gePiI+jZovXcqg0MwCMDVsWhaA8kr88OtiNGQ/EJObENBryDqyh3uNXqR6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726463718; c=relaxed/simple;
	bh=PGAxRwXCRUpEzpA9Gt53PMMTIGadb2G5b1xrSWIyFGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b0J6JPnYfb2AJUjrs4Mm9ftaQHNda9LdZGyaD+sUK2lgvVWQ8/y015MxM1OFCjiSU/7kEfv5ZSIfCfxk8c3QPoaltomn9hAgJpvAQNMbPJdlrNdSIREu408ZCRH0Bca+n3EFi7p2KPLVxZlg2w5l7KitrgmNR42FpLLQoV7wW2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u+nd4VZI; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6db836c6bd7so38042057b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 22:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726463714; x=1727068514; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yrR+EZEGlODA53oQ2phxVg0Pf18MwT6amUL7GRN1Q4c=;
        b=u+nd4VZIkfQ0eTT5+cHMvdMMDUYd8IJAanetjsZBMhy+H9gNAx9aqwnHggUtGE1Z7o
         CSH6e6hZof+4w06ug7Eiduj73CztjIoleWiwfci2G/arct/v+S0e6BRIG++jnZtJlHgj
         vhOt5fusD6B1GYT7R2SdJJSKBgZu1IPcDzpb73Ah/IUsGzl9j1dJp581bMXG8bVzChkx
         rIl81Um+x8hsddMlq7jurT/N+MoexU+MuAb26CvHc60b1BonTeUAdjJ8pwl+EVvJ9wum
         gbyDEe+QOV+Lp3hbQti5o59KGgjBZBxZlkNdor/pSLJf4xz2kNYfn8oa3PU8oDbUOHlU
         qDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726463714; x=1727068514;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yrR+EZEGlODA53oQ2phxVg0Pf18MwT6amUL7GRN1Q4c=;
        b=j4LDEpdU08ZW59ad7FFWYw9hXZeOD13Hfg9thEi/pr54aEU0zLQBHO7Euy5/Bb53qs
         p2/6WOqjrE5vbM5YmldvXIWgo/mwnIH1EWOykANrZco6g3adwDP5XMLQ16KSiOaGFWhf
         GdpGmGgGQ2etAH/KmjJyylWOXDJHC5bA69V3JI0OyLIJGD4K3KSstDT6nfub1sRQOKUh
         M++xWXdmndrrKjcOWk99L2X7LkbUysdPyqIOb4RLPuH1iT6vd317OESEXEx5gP5Oa6Rh
         3ADh7JgllFKqwMig5SlwSNie1hMJKnFEwqFpyimI/DNQbRlpesney6ZOj7jzXojsJsNU
         DfYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0npgRa/OHRh1tlJlFhpu1kGPgYfJ6Jzsr7bGDwNnctXHMkoFLnCjCCZZPcMhkUkWk7UcRT7IQWoDqZ+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7f+XmZycYwqkUF1+D9DQteuV1OWI7mQn8VKShbccVJkI5bC4X
	6arOcGVyAB9xMj6fTSyZ5SECuLVEtTBRzcpYpDKD07ISqqluR47gB7RpHHx+RHB0hA6dWCc1xrc
	o9Sac+CMPRxZ6WJRHmcHCJvLvTvl3q1caghNpKg==
X-Google-Smtp-Source: AGHT+IE1BD0gww+GsvJt2s2A6MI3g0bWI4tMgjSI2z12kTREulECla62TeLkViBP3+qyc5475k+sZk0eMJp2U5UCCbM=
X-Received: by 2002:a05:690c:f02:b0:6b2:28c3:b729 with SMTP id
 00721157ae682-6dbb6add252mr146179877b3.4.1726463714100; Sun, 15 Sep 2024
 22:15:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915080830.11318-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240915080830.11318-3-lvzhaoxiong@huaqin.corp-partner.google.com>
In-Reply-To: <20240915080830.11318-3-lvzhaoxiong@huaqin.corp-partner.google.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 16 Sep 2024 07:15:03 +0200
Message-ID: <CAA8EJpqC5tQ45gj8-0bDutinCs7CoxiQVL1EAzwDK9RJTXYMcQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm/panel: boe-th101mb31ig002: Modify Starry panel timing
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, sam@ravnborg.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, dianders@chromium.org, hsinyi@google.com, 
	awarnecke002@hotmail.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Same comment as the one that I've provided to the other patch, plus:

On Sun, 15 Sept 2024 at 10:11, Zhaoxiong Lv
<lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
>
> In order to meet the timing, remove the delay between "backlight off"
> and "display off", and reduce the delay between "display_off" and
> "enter_sleep"

Separate commit, separate _justification_. Why, not what.

>
> Removing variables: display_off_to_enter_sleep_delay_ms

This phrase is useless.

>
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> index 0b87f1e6ecae..c2d0ec199829 100644
> --- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> +++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> @@ -29,7 +29,7 @@ struct panel_desc {
>         bool lp11_before_reset;
>         unsigned int vcioo_to_lp11_delay_ms;
>         unsigned int lp11_to_reset_delay_ms;
> -       unsigned int backlight_off_to_display_off_delay_ms;
> +       unsigned int display_off_to_enter_sleep_delay_ms;
>         unsigned int enter_sleep_to_reset_down_delay_ms;
>         unsigned int power_off_delay_ms;
>  };
> @@ -184,12 +184,10 @@ static int boe_th101mb31ig002_disable(struct drm_panel *panel)
>                                                       panel);
>         struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
>
> -       if (ctx->desc->backlight_off_to_display_off_delay_ms)
> -               mipi_dsi_msleep(&dsi_ctx, ctx->desc->backlight_off_to_display_off_delay_ms);
> -
>         mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
>
> -       mipi_dsi_msleep(&dsi_ctx, 120);
> +       if (ctx->desc->display_off_to_enter_sleep_delay_ms)
> +               mipi_dsi_msleep(&dsi_ctx, ctx->desc->display_off_to_enter_sleep_delay_ms);
>
>         mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
>
> @@ -275,6 +273,7 @@ static const struct panel_desc boe_th101mb31ig002_desc = {
>                           MIPI_DSI_MODE_NO_EOT_PACKET |
>                           MIPI_DSI_MODE_LPM,
>         .init = boe_th101mb31ig002_enable,
> +       .display_off_to_enter_sleep_delay_ms = 120,
>  };
>
>  static const struct drm_display_mode starry_er88577_default_mode = {
> @@ -302,7 +301,7 @@ static const struct panel_desc starry_er88577_desc = {
>         .lp11_before_reset = true,
>         .vcioo_to_lp11_delay_ms = 5,
>         .lp11_to_reset_delay_ms = 50,
> -       .backlight_off_to_display_off_delay_ms = 100,
> +       .display_off_to_enter_sleep_delay_ms = 50,
>         .enter_sleep_to_reset_down_delay_ms = 100,
>         .power_off_delay_ms = 1000,
>  };
> --
> 2.17.1
>


--
With best wishes
Dmitry

