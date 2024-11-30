Return-Path: <linux-kernel+bounces-426163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FBD9DEFB7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 10:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49A5416304C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 09:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5307C1537CE;
	Sat, 30 Nov 2024 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XbDEEXs2"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D515533F9
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 09:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732960458; cv=none; b=tAic9cptowuuKLx/fZm/Ql9nG/0HTQ6QSxAk+nLjLBzTKBW+QOwft+D68b4r3CtTJl9g5A4txlJTGNgQqXZ+xJCrMSeVjQQ7xC1yvTFqT0Wx5T10WdDJ8csz+ze9r8AjCdtYKRZrz1aw0Vl9vkZWnjZLDzZ8/A9YXX/M8ltPhqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732960458; c=relaxed/simple;
	bh=HDqXuqlxiaDPte0W46BTkT66Qu1FiJgD8ZkENUx5qKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsDA7GDATH8zKZ9XzTb5MqwAno99/fKjrPvPfNrKARk7mMXMgGtYJpJMHwEBI4mrfrMnCmLmhD/EOMbVtMnpbtUuOMQ1WxLAazWow1fBAz6HwPeDeHAKKCb7211GIMaUsGmoqPH4ofbK4ZGWMstc4DdtIFYj0mlGC/0EzHVRHGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XbDEEXs2; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ffd711274dso31370311fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732960455; x=1733565255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Lc9DfCXaFvHVBMdEeSwVvJlevNEtc41NoCu48KM7Oc=;
        b=XbDEEXs2iMEiWiYU3Jbjb29viXcNK3i/s4a1DYZ+quROx9aqLMC88IeDXJE56O7pK5
         P2kvyiBzZgxkbflezUmnoch9EuoDi4LhQEkYNhOR65xe19MCRS73QK8Il5hdglu0M79C
         3KP5OHeba+tZY8KE/jqwqw/kfvn8s3irn7Xx72x/9UhGx56PIfLif0xiXH8p2g33brjO
         pdNpGC9EhoSe0CI7e7zgVa/j91r0o69RVFp84Ysi/6VlmWT/K4Fvi+15QvimaMg2SiwY
         vqdeyuHTyrhRU0ezzXUefZWcL7YcJE+N4saY5i5apNeO0To+rCkTZYRGyCdUU9tglrZA
         Lo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732960455; x=1733565255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Lc9DfCXaFvHVBMdEeSwVvJlevNEtc41NoCu48KM7Oc=;
        b=o++S4uoKHqjmiR04IceUKyGhjos19YVcYAuH0EWk/PIyxL6bOrJN3S0YKdlmYItHBL
         AcG7T9WHT9o4CkwBZ9EaiXjL/8xptGgclB2baRDNTr7fyhZqKYD6eMCPT0SVLy9tx1/i
         Hs6qzb4d26W4FFeyp9fnQU5WZ20Pqj1I2gk9W3oyxqCBRe8cwua8odWKKntRL6ayXLJ2
         TjmzATwPl2HjsfGSEkLF425GrHQ7YCgYcfnggSDMTPfuYICjkUvs0RTAODVdQ2Fk6psb
         kB8C4VvpPs4vxUphf/7+HRbU5gRzPLrmnBbxiErKWNt9QunxDw5r3klwAJ8tjYNwJddR
         Ys2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxH4d6qK6WpRiroZ1Bx+jDqg3SFktI2LS2Lfgr4OAqcLebnZm65jXOL+4I0hRdKKXILS/GRRu11mrr0bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuVzOEd+qaCSPjQRJa+XLZZvk3rjD2SzO1FX6afH5Car+DjzQT
	BwwEPSKs96WkzsiNJeSLeKFieOnB1KZt5U4DwA4ZKWM8Ev4CTZz8+m4DwLomc+k=
X-Gm-Gg: ASbGncuR89GXEkf0US5600ZfrKufROGmy5R9brgHVvdCvP00V1jAUD6wQ1wOjfXok1n
	fqVpoCsU2sdT7JMYSKlhEUYahCI48X3J1OgcoUJRL0TtqeRQejZXKN/ituvBlLyqXiq256CFN6X
	B1Otz97JwYRJDcv5D1q513JBBPSjo/MBCW2R399kpPf0cP37+V5w08QIO90qyB4U/Vb78frj4lJ
	TUG+9mYiS63SedPhvthYRFhCD1wcahXW2N/dGtveun4c14MLkLvGQ4JSPQugbyhAaqkYSzc0Whx
	vk2r3kYlxayLdZqtWKFIFAkTBvLS8g==
X-Google-Smtp-Source: AGHT+IFkfMrwigSf+zgzstB/hgJoOKRZVbjeqFCsdGsPsNseLBJrUIenMSlGkjvt/K+9OUdn2YEiGQ==
X-Received: by 2002:a05:651c:2220:b0:2ff:d728:bbc1 with SMTP id 38308e7fff4ca-2ffde1f3281mr37422461fa.5.1732960455087;
        Sat, 30 Nov 2024 01:54:15 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfbb8f59sm6538471fa.17.2024.11.30.01.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 01:54:13 -0800 (PST)
Date: Sat, 30 Nov 2024 11:54:11 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: "Bauer, Markus" <Markus.Bauer2@avnet.eu>
Cc: "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>, 
	"airlied@gmail.com" <airlied@gmail.com>, "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>, 
	"neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, 
	"Laurent.pinchart@ideasonboard.com" <Laurent.pinchart@ideasonboard.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] sn65dsi83.c: fix dual-channel LVDS output also divide
 porches
Message-ID: <4iow25webuwskjbx6gfft45x3jhxvg3diulfpjzonesgjmszhz@dk54ylmq7tnd>
References: <BE0P281MB0211EB59ADE02F4DB8F9D0CDC22F2@BE0P281MB0211.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BE0P281MB0211EB59ADE02F4DB8F9D0CDC22F2@BE0P281MB0211.DEUP281.PROD.OUTLOOK.COM>

On Tue, Nov 26, 2024 at 09:42:45AM +0000, Bauer, Markus wrote:
> sn65dsi83.c: fix dual-channel LVDS output also divide porches

Please use drm/bridge: ti-sn65dsi83: as subject prefix. Drop the first
line of the commit message.

> 
> When generating dual-channel LVDS to a single display, the
> horizontal part has to be divided in halves for each channel.
> This was done correctly for hactive, but not for the porches.

I don't see this being handled for hactive. Could you please point out
the code?

> 
> Of course this does only apply to sn65dsi84, which is also covered
> by this driver.
> 
> Cc: stable@vger.kernel.org

Also:

Fixes: ceb515ba29ba ("drm/bridge: ti-sn65dsi83: Add TI SN65DSI83 and SN65DSI84 driver")

> Signed-off-by: Markus Bauer <markus.bauer2@avnet.com>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> index ad73f69d768d..d71f752e79ec 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -399,7 +399,7 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
>  	unsigned int pval;
>  	__le16 le16val;
>  	u16 val;
> -	int ret;
> +	int ret, hfront, hback;
>  
>  	ret = regulator_enable(ctx->vcc);
>  	if (ret) {
> @@ -521,12 +521,22 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
>  	le16val = cpu_to_le16(mode->vsync_end - mode->vsync_start);
>  	regmap_bulk_write(ctx->regmap, REG_VID_CHA_VSYNC_PULSE_WIDTH_LOW,
>  			  &le16val, 2);
> +
> +	hback = mode->htotal - mode->hsync_end;
> +	if (ctx->lvds_dual_link)
> +		hback /= 2;
> +
>  	regmap_write(ctx->regmap, REG_VID_CHA_HORIZONTAL_BACK_PORCH,
> -		     mode->htotal - mode->hsync_end);
> +		     hback);
>  	regmap_write(ctx->regmap, REG_VID_CHA_VERTICAL_BACK_PORCH,
>  		     mode->vtotal - mode->vsync_end);
> +
> +	hfront = mode->hsync_start - mode->hdisplay;
> +	if (ctx->lvds_dual_link)
> +		hfront /= 2;
> +
>  	regmap_write(ctx->regmap, REG_VID_CHA_HORIZONTAL_FRONT_PORCH,
> -		     mode->hsync_start - mode->hdisplay);
> +		     hfront);
>  	regmap_write(ctx->regmap, REG_VID_CHA_VERTICAL_FRONT_PORCH,
>  		     mode->vsync_start - mode->vdisplay);
>  	regmap_write(ctx->regmap, REG_VID_CHA_TEST_PATTERN, 0x00);
> -- 
> 2.34.1
> 
> 
> --
> Markus Bauer
> 
> Avnet Embedded is becoming TRIA:
> www.tria-technologies.com
> 
> 
> 
> We continuously commit to comply with the applicable data protection laws and ensure fair and transparent processing of your personal data. 
> Please read our privacy statement including an information notice and data protection policy for detailed information on our website.

-- 
With best wishes
Dmitry

