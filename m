Return-Path: <linux-kernel+bounces-330181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A09C979AA4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62D71F21611
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 05:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBD920B22;
	Mon, 16 Sep 2024 05:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g63rxcc6"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513F3134BD
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 05:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726463492; cv=none; b=o73KfnIWJqfvGvNqcB2elq5LGRs44rDzpflbKRT8EocNesNS1MkIBbKQdr7X8vapyG29w2Fe4ZawMinX2TTh7oM5a067nr1aDTUditmR9oXmZ5AnMkns1+8zORV4wJ7BW9pYSrdXY6VKsNVJ7rsujIqCg6z44aiPVtKMIJjIb2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726463492; c=relaxed/simple;
	bh=YGRGCC0OEx1obS/0dhk80ZYpSEy3pP+qpQuAyKAMH7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWnHVcj3h/yEfs/XU5xg9DSiuQlNLtxEwBF14beIUeliKfVA9bvcxAs1rPa73+9XYLfTF7Dk43gjRjZkQ+7TnccxD3yU3kiKtJ4vkKOBTqHhbtRQgYUZSzxt87apPBZ24pV1vLeSZ7LvXCXV2HM4yAW5qHHjRAhrdownBqOhqdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g63rxcc6; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6d74ff7216eso19796617b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 22:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726463489; x=1727068289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xClosrKSKvRQXSe4g+NTsfgEyk3rcyU/wxole1yQDT0=;
        b=g63rxcc61ZaIxmf/xIeSjPz+00rAyv3M+6CZ4W6Ra5cUiN5b65mjA/aVTmj13vXJcF
         9u+Ca9S2HiK4453IsHXP8jeeryPErpqdJp7mWBsiRMylaKVdZJB0nKWYFwRjLV1tsJIV
         zmvU8+E57Cabl5+kFciR4FRI5PUlcWOOPHpaCEUty/XHeqQ5QdzOXT/2hFP36R9QQuKS
         ESUxXGu6V0LZPMTbCdDbloRYTHPWfbJrJjRmQE6tu8WbbUulzjp6rH4MaP3fbU/5T3ld
         IL7b8nY2l4gbLOmrRFPRt+HlIPP5P5wDl6yw2GNcwkxCkoY+pCF46aLPbYsCfpMbpMnZ
         mCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726463489; x=1727068289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xClosrKSKvRQXSe4g+NTsfgEyk3rcyU/wxole1yQDT0=;
        b=NlGBcWbC3s2/X1J4Lg/oL9I/iBMa/PqxVdUue4/D0mckGTO1lBViqvlimgf3IPic3e
         jS4dSq+25etf58w6D0QYDaJ2Fznd/hGfJXtKg6rOmaP7DAV8xPc+W8/TM4y8tMi+i0UN
         RMtxvOM+I+6hO8PU7rVR7skylX40FWvpgW3ItTlQWpZ2onVgsCTU5gP6gPKvG4AkSxxM
         GUqXmtOZ8alU2pQH6msHXCKea1OEHjsNLkUgLxLSNco5m7oZAKD/Iu2+8nBr0oI8gt5P
         owx9GqsEmC2ftH7zAcJp5ZSiunV0Y4img2Ei96oetpwujgBHmisocntnuKxjY9XxdcSA
         3oow==
X-Forwarded-Encrypted: i=1; AJvYcCUSM3vKh3oaufqjPEaa9aNP1dkdHL+R47afxS8TAX6OKDgQa412lnIaQ5RaihKClo9t1nafg/Q6A+TRTME=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWgtFUDkw4Eb1k5jSrKTSrvpCItSwsAb/ru0WfS8odeSWq2fpG
	NhT0kKP+twdljcX2rr71S9fcFz9YZL5Chdho8E1NIhyUb9qbzVyqoKrAme9hBUTMes1YGe7/lzj
	w+5u+vRrzyC27HuRU1i7WOFkJziea3xBMqJ2Kxg==
X-Google-Smtp-Source: AGHT+IHw0+9JwP/NwY/8uibNHIFwJiOUTZZF4F6o99jcFoo8qq9n9ykue29sInrAe1E0S1koV97Qqsuk5tzD/GYpnQE=
X-Received: by 2002:a05:690c:4a10:b0:6d3:be51:6d03 with SMTP id
 00721157ae682-6dbcc3b3a4cmr89104197b3.23.1726463489085; Sun, 15 Sep 2024
 22:11:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915080830.11318-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240915080830.11318-2-lvzhaoxiong@huaqin.corp-partner.google.com>
In-Reply-To: <20240915080830.11318-2-lvzhaoxiong@huaqin.corp-partner.google.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 16 Sep 2024 07:11:17 +0200
Message-ID: <CAA8EJpp1ZHFFY9M3i47d658Q-m3ggJzhxSRUapX=tckgdAwcNg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] drm/panel: jd9365da: Modify Kingdisplay and Melfas
 panel timing
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, sam@ravnborg.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, dianders@chromium.org, hsinyi@google.com, 
	awarnecke002@hotmail.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 15 Sept 2024 at 10:10, Zhaoxiong Lv
<lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
>
> In order to meet the timing, remove the delay between "backlight off"
> and "display off"
>
> Removing variables: display_off_to_enter_sleep_delay_ms

This is not enough. If this is a fix, then describe why the original
commit is incorrect, provide necessary explanation, details, etc.
Otherwise it looks as if you are removing the delay that was necessary
for other panels

Also if this is a fix, it should be properly notated with the Fixes
tag, maybe cc:stable, etc.

In its current state: NAK.

>
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> index 44897e5218a6..2f8af86bc2a0 100644
> --- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> +++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> @@ -31,7 +31,6 @@ struct jadard_panel_desc {
>         bool reset_before_power_off_vcioo;
>         unsigned int vcioo_to_lp11_delay_ms;
>         unsigned int lp11_to_reset_delay_ms;
> -       unsigned int backlight_off_to_display_off_delay_ms;
>         unsigned int display_off_to_enter_sleep_delay_ms;
>         unsigned int enter_sleep_to_reset_down_delay_ms;
>  };
> @@ -69,9 +68,6 @@ static int jadard_disable(struct drm_panel *panel)
>         struct jadard *jadard = panel_to_jadard(panel);
>         struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
>
> -       if (jadard->desc->backlight_off_to_display_off_delay_ms)
> -               mipi_dsi_msleep(&dsi_ctx, jadard->desc->backlight_off_to_display_off_delay_ms);
> -
>         mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
>
>         if (jadard->desc->display_off_to_enter_sleep_delay_ms)
> @@ -858,7 +854,6 @@ static const struct jadard_panel_desc kingdisplay_kd101ne3_40ti_desc = {
>         .reset_before_power_off_vcioo = true,
>         .vcioo_to_lp11_delay_ms = 5,
>         .lp11_to_reset_delay_ms = 10,
> -       .backlight_off_to_display_off_delay_ms = 100,
>         .display_off_to_enter_sleep_delay_ms = 50,
>         .enter_sleep_to_reset_down_delay_ms = 100,
>  };
> @@ -1109,7 +1104,6 @@ static const struct jadard_panel_desc melfas_lmfbx101117480_desc = {
>         .reset_before_power_off_vcioo = true,
>         .vcioo_to_lp11_delay_ms = 5,
>         .lp11_to_reset_delay_ms = 10,
> -       .backlight_off_to_display_off_delay_ms = 100,
>         .display_off_to_enter_sleep_delay_ms = 50,
>         .enter_sleep_to_reset_down_delay_ms = 100,
>  };
> --
> 2.17.1
>


-- 
With best wishes
Dmitry

