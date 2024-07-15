Return-Path: <linux-kernel+bounces-252442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D707C931320
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1DC1F23B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D8E188CCE;
	Mon, 15 Jul 2024 11:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HzwBPX++"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8081E89C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 11:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721043162; cv=none; b=q8RRqXC0p8ckP9aO8rzST+C8aGUCuKdRMYbrkSET/R13xOsAzv0osM1riFzKALJapHU6VkvSvK1rN7oL7CP4wJR7EGtZOcoJh5ptwzTz3J5+EOt1GAJZ7ddRo15OJ7DGlICv0vGgW8CbYn1SMjFyhbnuIyymUNNmVlqjxE10fmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721043162; c=relaxed/simple;
	bh=PXPBVmU9s68tux9iTpqyeS/tkuQKoau0BnAS4oqGhT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+BFIgn8PTK2X3vAzN2A3+7Ue5/4/OzxjgcEkK+dPvyQnLE/jFewfNWTO08YQF5D6gHxQH+iPy0GOtHgg29T6Ke3SxH0+0Wonc/uBo1KnjNrwSI2umlufoDUtgm5PRnwqQ3v2ZRjG1MrG4ywh1zO55iUZppHFzCo8um1+69zKr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HzwBPX++; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e04196b7603so4174506276.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 04:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721043159; x=1721647959; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jogpdw07nqWdBOTLr4+aPckD0RPbKM+NzNUz/Z1iCeg=;
        b=HzwBPX++brdOLUXvFsP/TG5qJ5s1QZXnDrvLr1t4ANmZbG+ak8ZY1du9quhCuNPUVM
         d69P5SeJz9uiUMz7EAuG/35iVKnRotI/ewfuSr9AwxGlMHVo/b0WRlHFIjiy1s/6C91d
         3O25wvWznDTNVLs5cVsavFRtWy0XZ1kXHOevvcXCNOev5NWQ4IizYvS1101s1p1dVhEG
         DqEUYpd99Ad+ChOSS2T/rhMY8lD1UQzVQ3Ep/ajLiyTfw00umlaqsvtd4xGnm4cm7rjg
         34R2Jc1XFz2lUTbDx3nf5l4aQQYaoyX1TW6XwTysChBrBqhKyGqnD0cL9u4VeZnMT9kv
         Pxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721043159; x=1721647959;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jogpdw07nqWdBOTLr4+aPckD0RPbKM+NzNUz/Z1iCeg=;
        b=YjihGuspAnPEWEIFiVk3z4p4KYIapzYp74JsR6Oz1eJQAZiSGIdZrjW6UhOm12MenA
         ZaBhVAvrOTxB/Qyfi+BGjOEBqaASO7onK2Tz1mk0MVzM1B7f8o0JxdsI+4rhru9CKc2W
         dLAbBnBCz3NEDEbhCrXcHIESX9FOgow77udYhUzS/PpwEXCm/64DOTkqTKAhgDr+w8Bx
         1Kcrt7ZKbJx++oyPU3DV2qZESK69Rv4PZG2WKtS35fapgTcH9cUI63Qk9KcXFGSjBp/q
         eWaeB4zz9TnRD+6XzkgtkRlgP713fbOw3qvlpvKoeMm+gg5soNKkH6v4U5RQGiU0fQXx
         4i2A==
X-Forwarded-Encrypted: i=1; AJvYcCVMiW7sF8p5CTN7pLA8G34pOYf80JSRp4Mi3WD0hxwCRxbr+28GZ6KAR0uB9660zlGKiz5SL3LVBns2eggqixS3ScyMrCtqkChh3zV2
X-Gm-Message-State: AOJu0YzWPWLrKI8ylNCF+mPek8lNhB7Pd2dVg/LBEWqea4+Uv7jRqjFa
	jy9Phk7Xvu2id2I/Gk2aibCGYrEb/46t+pba+eoZod0o2gUw86wGk55xYvQ1R02a86K0A8iXVpk
	e6/3FyWkfQ9+bD2dr+Z/25IduHyqucr1SKgU98g==
X-Google-Smtp-Source: AGHT+IF9lmgFAw7fB03mWJ+kiazuSLnjkXpBjqshoqF+XqRzDmcbRiL7gcCzcPqwVVHx94WtpgGBV68SYHs6dWv1J/U=
X-Received: by 2002:a25:2704:0:b0:e03:5f7f:1215 with SMTP id
 3f1490d57ef6-e041b095eb0mr21171574276.38.1721043158913; Mon, 15 Jul 2024
 04:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715031845.6687-1-lvzhaoxiong@huaqin.corp-partner.google.com> <20240715031845.6687-2-lvzhaoxiong@huaqin.corp-partner.google.com>
In-Reply-To: <20240715031845.6687-2-lvzhaoxiong@huaqin.corp-partner.google.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 15 Jul 2024 14:32:26 +0300
Message-ID: <CAA8EJpp8LvzKdHR2y-f-qtfx-fLSOwxG_CXTCrtV6JWnzX_YmQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] drm/panel: boe-th101mb31ig002 : Fix the way to get
 porch parameters
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, airlied@gmail.com, 
	mripard@kernel.org, dianders@google.com, hsinyi@google.com, 
	awarnecke002@hotmail.com, quic_jesszhan@quicinc.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jul 2024 at 06:19, Zhaoxiong Lv
<lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
>
> The current driver can only obtain the porch parameters
> of boe-th101mb31ig002. Modify it to obtain the porch
> parameters of the panel currently being used.
>
> Fixes: 24179ff9a2e4524 ("drm/panel: boe-th101mb31ig002 : Make it compatible with other panel.")
>
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>

No empty line between Fixed and Sign-off-by


> ---
>  drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> index b55cf80c5522..d4e4abd103bb 100644
> --- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> +++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> @@ -312,15 +312,14 @@ static int boe_th101mb31ig002_get_modes(struct drm_panel *panel,
>         struct boe_th101mb31ig002 *ctx = container_of(panel,
>                                                       struct boe_th101mb31ig002,
>                                                       panel);
> +       const struct drm_display_mode *desc_mode = ctx->desc->modes;
>         struct drm_display_mode *mode;
>
> -       mode = drm_mode_duplicate(connector->dev,
> -                                 &boe_th101mb31ig002_default_mode);
> +       mode = drm_mode_duplicate(connector->dev, desc_mode);
>         if (!mode) {
>                 dev_err(panel->dev, "Failed to add mode %ux%u@%u\n",
> -                       boe_th101mb31ig002_default_mode.hdisplay,
> -                       boe_th101mb31ig002_default_mode.vdisplay,
> -                       drm_mode_vrefresh(&boe_th101mb31ig002_default_mode));
> +                       desc_mode->hdisplay, desc_mode->vdisplay,
> +                       drm_mode_vrefresh(desc_mode));
>                 return -ENOMEM;

Please add a followup switching to drm_connector_helper_get_modes_fixed()

>         }
>
> --
> 2.17.1
>


-- 
With best wishes
Dmitry

