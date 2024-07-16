Return-Path: <linux-kernel+bounces-254053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB9C932C61
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0012EB23EC5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA3719DFB9;
	Tue, 16 Jul 2024 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QOvwJ7wC"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C801DDCE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145276; cv=none; b=dYLgAvql1/bHO3/CadeG33BGyWG2BWe7Q8T7xFKXB0Tt1HtLMPCmCoWSJyZJupcrWPKVmFQchjEjjWhyI60lXSHnVH4632svpEyj9Vz6QVuOooAcUlvyeal9Klcv5A3MW4gIlxnZmrad5WVHyodfTnoWoVfkZJ3ENu28X9kB8CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145276; c=relaxed/simple;
	bh=tIg+KBziG8ww0T9blgG8uaeLokxnTMdlPzjGxTzxGbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcZcqq1TQmzzaAu1KsuLJp8fVOSVRmng3gYZBEbpkWT9u2p/3vvfADeJn29/+PDKOpZXUpNEZB9DEdnxhidMzZdxkgPh/RHouGWIKTviDmhb3RTS0cVUjfXHqjwAnx68Zgwrci99/tR7O3uTV+ZO5Luz2amMxCMf4W1RWF9sxqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QOvwJ7wC; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-447e02f3ac9so30089941cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 08:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721145271; x=1721750071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Cptj2CuYa/Zbm4OtWYM2fatIt6ccC2m1uYdd4iqOhs=;
        b=QOvwJ7wC1hzOjVGxYvGIqLCCEY5ccpzsehzvvacJh4Rmi7PRhlduh6ksJoKoIZ8b0W
         KanRTc3JnHTQiIb3jkNWvoRgaQvkfT0ZKUqnKmJ1D2MjWvI5bIJE3oMwHLvlYvj1N4K9
         mt1EQ8eQmNvklHKji7A83lyhKbSZamva58a18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721145271; x=1721750071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Cptj2CuYa/Zbm4OtWYM2fatIt6ccC2m1uYdd4iqOhs=;
        b=ezOYa6H2bAJvfSobR8PVlEr5tMkfg2BiGiWtw50mYky6dQbaHY44cHXkHUY+xBs5RI
         WrA5rMYcRbQSGUT6bTjO/Zaw4CMrpVcb/eCP6B8Bxur1zgrV2qqSXNmVYVB481k74zvv
         CFrep7VmPZO43KGFVSCaswf6QKUbKLKiVUZ2h/fMKgZTVmkvot9AA0VOGOWtrlV0Dw/x
         G8BKYna7yVy6lcyaCNuUr9yo8URVvd/WhstBMmSdfC24eNDijZHuYY2dxRgKHekDfWap
         uuqWpg/JmlQyHnw2L2Vr7f9x2+f9hiGdCYgNIt5lvdo38UEh0abUEK2wz9U/uOyM089e
         Avvg==
X-Forwarded-Encrypted: i=1; AJvYcCUON6o34c+kdLG716zF1U11SOF+vicZ6cBvKHm+v8868z2KNxgKdMrdelokfZTBYa2dS7x6nqkrBwirdl8xXWB6wZBR6LGPpicqcy8K
X-Gm-Message-State: AOJu0YyoTSXgRu/bXWc7egEmzX5aYzb4HTmvVl2FfbGBBlfuRGdZZYrH
	cEAQVz3L1+JD5L5svQ/niWNfgMyCSWx0UCAdZaoCRlBA5MuZlj1t3uMW61VE5uTOgBDTzJkGtjY
	=
X-Google-Smtp-Source: AGHT+IFNcaa7s5pC1AZUXwp4WnK4ZL21QExHjhjl0UtIGsF/qmFKhxvHncwES3ndRXYkB6z4FLEOdw==
X-Received: by 2002:ac8:5a85:0:b0:447:e14a:20a3 with SMTP id d75a77b69052e-44f7aed05cdmr31380141cf.55.1721145271362;
        Tue, 16 Jul 2024 08:54:31 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b7e20afsm36398031cf.22.2024.07.16.08.54.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 08:54:30 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44a8b140a1bso384591cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 08:54:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVGL2J+0bI+99waGCyy7dO8TbxkaMw7BuCRoYR+HTVhNPzkuGFKi82LFti8B2s4d52H5hMSnitxpnoerS1WKNltowzcRoz1Nx9lecwT
X-Received: by 2002:a05:622a:5298:b0:447:e01a:de95 with SMTP id
 d75a77b69052e-44f7a30445dmr4001041cf.0.1721145269303; Tue, 16 Jul 2024
 08:54:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716121112.14435-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240716121112.14435-3-lvzhaoxiong@huaqin.corp-partner.google.com>
In-Reply-To: <20240716121112.14435-3-lvzhaoxiong@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 16 Jul 2024 08:54:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U+Y551wC99w4b7Xjv7S7YOG2pYm6t1CpjDGbowbAGxbw@mail.gmail.com>
Message-ID: <CAD=FV=U+Y551wC99w4b7Xjv7S7YOG2pYm6t1CpjDGbowbAGxbw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/panel: boe-th101mb31ig002 : using drm_connector_helper_get_modes_fixed()
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, airlied@gmail.com, 
	mripard@kernel.org, hsinyi@google.com, awarnecke002@hotmail.com, 
	quic_jesszhan@quicinc.com, dmitry.baryshkov@linaro.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>, 
	=?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Andy Yan <andy.yan@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 16, 2024 at 5:11=E2=80=AFAM Zhaoxiong Lv
<lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
>
> Use public functions(drm_connector_helper_get_modes_fixed()) to
> get porch parameters.
>
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
> ---
>  .../drm/panel/panel-boe-th101mb31ig002-28a.c  | 26 ++-----------------
>  1 file changed, 2 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drive=
rs/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> index d4e4abd103bb..4a61a11099b6 100644
> --- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> +++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> @@ -16,6 +16,7 @@
>  #include <drm/drm_mipi_dsi.h>
>  #include <drm/drm_modes.h>
>  #include <drm/drm_panel.h>
> +#include <drm/drm_probe_helper.h>
>
>  struct boe_th101mb31ig002;
>
> @@ -313,31 +314,8 @@ static int boe_th101mb31ig002_get_modes(struct drm_p=
anel *panel,
>                                                       struct boe_th101mb3=
1ig002,
>                                                       panel);
>         const struct drm_display_mode *desc_mode =3D ctx->desc->modes;
> -       struct drm_display_mode *mode;
>
> -       mode =3D drm_mode_duplicate(connector->dev, desc_mode);
> -       if (!mode) {
> -               dev_err(panel->dev, "Failed to add mode %ux%u@%u\n",
> -                       desc_mode->hdisplay, desc_mode->vdisplay,
> -                       drm_mode_vrefresh(desc_mode));
> -               return -ENOMEM;
> -       }
> -
> -       drm_mode_set_name(mode);
> -
> -       connector->display_info.bpc =3D 8;

I notice that drm_connector_helper_get_modes_fixed() doesn't seem to
set bpc. Unless I'm mistaken and that gets set automatically somewhere
else then you should keep that, right?

> -       connector->display_info.width_mm =3D mode->width_mm;
> -       connector->display_info.height_mm =3D mode->height_mm;
> -
> -       /*
> -        * TODO: Remove once all drm drivers call
> -        * drm_connector_set_orientation_from_panel()
> -        */
> -       drm_connector_set_panel_orientation(connector, ctx->orientation);

Are we confident that all the other users of this panel are properly
getting the orientation and we can remove the above bit of code? It
looks like one other user is 'rk3566-pinetab2'.

From what I recall, the relevant commits are commit 15b9ca1641f0
("drm: Config orientation property if panel provides it") and commit
e3ea1806e4ad ("drm/bridge: panel: Set orientation on panel_bridge
connector"). I think in all cases the assumption was that, to get the
right functionality we need to switch to "panel_bridge". That happens
when we use drmm_of_get_bridge() or devm_drm_of_get_bridge(). ...but
it looks like Rockchip DRM is directly using
drm_of_find_panel_or_bridge() and thus hasn't switched to panel
bridge.

...so, unless I'm mistaken, the other users of this panel driver still
need the drm_connector_set_panel_orientation() call here and you
shouldn't remove it. Perhaps Alexander Warnecke could comment about
whether this is still needed. ...or perhaps someone who maintains
Rockchip DRM can say whether they have any plans around this area?

If, for some reason, you do remove it then it should at least be
called out in the description since this is a functionality change.

-Doug

