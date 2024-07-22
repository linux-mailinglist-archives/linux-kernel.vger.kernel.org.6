Return-Path: <linux-kernel+bounces-259269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4476F939346
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0FEE1F219D2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FA716EC05;
	Mon, 22 Jul 2024 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SXO0zsi3"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2DD16E86E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721669969; cv=none; b=isTd/z9JhnayEah9+C/g+calVdzOUYh5OzgrY40bwOG3tXwBXsAfjaJN5epRC5PwY+453aZeFwsILTzutj3xhwMXPYl1oxPseT8m04ByUzpExHc61CaAWA/RoS23gVc+wLa4P6smCn+tAAjfW4JvBrmDMtNsEcoW+9vsWmS5cVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721669969; c=relaxed/simple;
	bh=65iTKYYs1FPFTCm4dxrL53l3ExT8aiufqd8CnAnUw5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILDSB2Lu7Cp8tZSqn94ng2L4bbtwAapKXS4wGkGhX7izXNBkhj80x+LNGqqKFgHzK8RXfXIiZCXv4C2qFcq6VaGz6XG47LW0CcFIItkfub/2PIzr1mmVOUacRGAQa67UfqtaYGNq3Ux5LiEC8paRjJlfZZCvjRQZoYWMPer4AZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SXO0zsi3; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a20de39cfbso3779508a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721669965; x=1722274765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ku6pNJoPik/cEYLloIWSNS5pM+cd3LpY0Ys/ukb76Ww=;
        b=SXO0zsi3ff1sV/arit5AGZvaTBIOLZWrz6wu1XF01Hw6KT7awKOno+j/H4JmIcNAOc
         FnSK1LwGfBsScGk2rIn/A71D/wGzDPqAYKqeDdd6f7SvcxFXUWJmB+bRk4fkowWjP4I3
         UWGnDfF70RRdRxybH8IOJ6aV8JC4uu2WDamVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721669965; x=1722274765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ku6pNJoPik/cEYLloIWSNS5pM+cd3LpY0Ys/ukb76Ww=;
        b=vEX7Cg2m3tIeRAQgdm/6iIU+jvTwhGwUPFLd/iupULOGXcZ1Ol/PzGXrBRhwQZHWsq
         7t9q2spIy29y/qHDnAbIWWYMu1dmB5IrDNtTq3+6iCrOTSJh62TMXA689wvEYnu5lrG9
         +yoICL9eajZu7BajcR90yOU2s5+p2ci1henCAAJjm8GwUSjPnB3dyqYSZFLNdSiR+4ZU
         Hsay7YbllS+l7FCb4t9PKW6FlskIGmOY6B82XO+F0Nbe38Cn6N26oQ6v90wuU4w/kn9W
         mnX3j6WI0m3dG414uu5NgJt7JYXP+1j1aKKglT/Z1Za9PxXa5ztgM0/TB7vEV4g2DByt
         Glxg==
X-Forwarded-Encrypted: i=1; AJvYcCXjXf9M4loIIVKB7yPAPn7IGmW2w7g7QseGzGoitpkTkVEprm4oT19U090cm3rSmtWpBVvF7CGh8cDaOpjzs6LdyFG7OQNcfiZ6wdyv
X-Gm-Message-State: AOJu0YytnnGSDghtcdGs2iuN27PvTlf1jk2pc5TDcfkV48jbVBiAJoBC
	zzZ8P87ZkrZfFTkPfUv3DLbCG6rob7YRKEkQzaxmpT0R/XKfQkNZbwF1dhA/G8Y4ZFgbxg+ZKgJ
	F2t6Z
X-Google-Smtp-Source: AGHT+IF4CzTL1rLpYbwUx0tGIAxSKU99FNeTb1crHRT+gUHFVUwP+tDoWgt3vN/3C2/cgmzqyK5SWQ==
X-Received: by 2002:a05:6402:35c7:b0:5a0:e4a6:b3c9 with SMTP id 4fb4d7f45d1cf-5a3ee8a9ed7mr6605731a12.7.1721669960708;
        Mon, 22 Jul 2024 10:39:20 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30aaa2d48sm6387105a12.32.2024.07.22.10.39.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 10:39:20 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso1519a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:39:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrYtr0Unf3YiC8c2NXT3Zt6nYt/1YT/VkzjOKD9sxPLPIOfqOhbc4rg5DZ1n84IEkqsJ0+ydpuFNWNl7TFPk2sbcCF7u/wK1eL0ug6
X-Received: by 2002:a05:6402:2547:b0:57c:c5e2:2c37 with SMTP id
 4fb4d7f45d1cf-5a4a842853dmr284928a12.3.1721669958715; Mon, 22 Jul 2024
 10:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722092428.24499-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240722092428.24499-3-lvzhaoxiong@huaqin.corp-partner.google.com>
In-Reply-To: <20240722092428.24499-3-lvzhaoxiong@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Jul 2024 10:39:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VZ8SuBnPjSTLeCjPUnzFxgTkxUb+BC5+nKs9ECiy3zsw@mail.gmail.com>
Message-ID: <CAD=FV=VZ8SuBnPjSTLeCjPUnzFxgTkxUb+BC5+nKs9ECiy3zsw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/panel: boe-th101mb31ig002 : using drm_connector_helper_get_modes_fixed()
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, sam@ravnborg.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	hsinyi@google.com, awarnecke002@hotmail.com, dmitry.baryshkov@linaro.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 22, 2024 at 2:24=E2=80=AFAM Zhaoxiong Lv
<lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
>
> @@ -313,29 +314,15 @@ static int boe_th101mb31ig002_get_modes(struct drm_=
panel *panel,
>                                                       struct boe_th101mb3=
1ig002,
>                                                       panel);
>         const struct drm_display_mode *desc_mode =3D ctx->desc->modes;
> -       struct drm_display_mode *mode;
> -
> -       mode =3D drm_mode_duplicate(connector->dev, desc_mode);
> -       if (!mode) {
> -               dev_err(panel->dev, "Failed to add mode %ux%u@%u\n",
> -                       desc_mode->hdisplay, desc_mode->vdisplay,
> -                       drm_mode_vrefresh(desc_mode));
> -               return -ENOMEM;
> -       }
> -
> -       drm_mode_set_name(mode);
>
>         connector->display_info.bpc =3D 8;
> -       connector->display_info.width_mm =3D mode->width_mm;
> -       connector->display_info.height_mm =3D mode->height_mm;
> -
>         /*
>          * TODO: Remove once all drm drivers call
>          * drm_connector_set_orientation_from_panel()
>          */
>         drm_connector_set_panel_orientation(connector, ctx->orientation);
>
> -       drm_mode_probed_add(connector, mode);
> +       drm_connector_helper_get_modes_fixed(connector, desc_mode);
>
>         return 1;

Don't always return 1. This should be:

return drm_connector_helper_get_modes_fixed(connector, desc_mode);

...so if it fails to add a mode then you'll return 0.

-Doug

