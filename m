Return-Path: <linux-kernel+bounces-574040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3999A6DFE8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E90018952A7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5EB263F2C;
	Mon, 24 Mar 2025 16:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AeW3Rg2X"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B85025D1E1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834136; cv=none; b=rmPKmvd9bXtJvKC7x75JZGIggH807vM6QqLPxYvRrbUTFtFeqK2CcatMNBkqAnqMXmU3AWLMJembc/md6XPjLMua3LbyXPjFIYn7M0ottO+G9iLh1y1ptVY6H3Hr8APoijAuMPPBCxzEUunjZPxkcBbztzm1V65kDtO2XRuCfzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834136; c=relaxed/simple;
	bh=dDXLvuRUfGoaU06kz+fMRy1AlTPh4DnXNISnjmnW4Yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tM6ylP15ZsJNHf4gMb5B0O8MGHmx6Y5gLTCM+R+bA+yEWZ/Bbw0YQjTnJ24CYCHCPgMbV2MZ+CY1n/jdbidbrcLIVXwiC4IVJarIDeeFr0Rt/Bczo2KTPJvIuznKpONim+fp+QSZqdAwOGnEtee0EjGDN3gIFBMmdIqsoA/SDnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AeW3Rg2X; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30bf7d0c15eso47050831fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 09:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742834127; x=1743438927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EqbuE4QKSA6wina+ZlmUOPRyV7ECRhpq4syhxm86eE=;
        b=AeW3Rg2XtFqtN9wmZ/IUqLwE32bOwzDvYJmJHTj3e18RdWR7tDBIvjELThL9F4qc5d
         QLp20coHURsjyoq9Uf+Fg0wH5aEZtAS/nhyvmehSvwtH07lvw4uG9mNsLjAfwU0KfPib
         SLErA7z4NBs6Bjv07HAhyJXR1Pm0ZNpfLlIWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742834127; x=1743438927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EqbuE4QKSA6wina+ZlmUOPRyV7ECRhpq4syhxm86eE=;
        b=CSIEq9MZSd+CcP8gTj7I9Z2iqAt4k0/NApCPDxe+GRmx2k38z/vUg7afbMlNEHjNb+
         WWQHB6B2fzuI31I5VCc6niSYu2md4KlR5IZxjG1vrHHneg/CDUQ1LYcQN1yOlw6F2lew
         VoqXzglp0EIR7vU4mWKLODaF0y4wFP4UE++2VbAMo+8D8EbT4qPNgoz+7SOzZorgPmYW
         MNRiYyg/8rT/Qp2dhyUds39F5PZT77UusOFUOCcWkcZAikmbpT8ll84bk0nvMoFWMSnR
         /TfSVdpl05BvhSs3plQuPg/q7ogOzcxBBQJEZURiVf7suUMTfJdxdJboJxzckMk1pTzD
         2C2g==
X-Forwarded-Encrypted: i=1; AJvYcCVyS8PoC6KslxUDWCD6ZbRH7gUAY5sZQ6qqYgx5LeBdJve2JCf9JfShAeJFNjKF1cd/fuPV4YZOFuFh/Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YySsp3gdlN35seH/9yXXYOnVXmSFlFGJQ1Mks6vUAhEwu2maNlX
	YjH9RBvBONYZG6XjHOxztWcr06t4NNcgy29IgoAlKH84Md1yPTkVym/8WgxBnTeSTyBFSibmx+t
	1Dg==
X-Gm-Gg: ASbGncsO5GdvCe9IUH9C9+CaPBloR3rpPT4EmAO2unXOAHOJo5kdzcUM3Mjyh3c+sWa
	QMnB8CzQH0WOVikKkes39iE9jIQtR9djnDrY9+KA1JA9NqET9q3pabJTCPmU63GciZdL+0lAbeG
	9qrZ1hruxELqhIi4UHmMrqOMhLpdQzbjeS9aZ4CClkgrikYjFw81HPTEA/JJlmRTQCzElg1sgMf
	pDljxkF12BUGbT87nBFbPTJWo4IdC2iRB6MYzpuFCPUvL1/UlUFEcpwayD+KYCt5upPc2xAF+ol
	Uj5Mezc4EyXAc3yGZNRxkS6MhNNrb6YqCE6f53ISSFz8oEQxRpj4htzlrdsn742pKBtjkxjij1J
	ZVS5sMU1V9Q2B
X-Google-Smtp-Source: AGHT+IGo/7Y0xPUfgHfDCSbjDLmk6Rq7oDjCUxk5SXLAvGO7m1ev2DaZBvs94gtMYt5DcNGKCSHd9A==
X-Received: by 2002:a2e:a581:0:b0:30b:f274:d1ea with SMTP id 38308e7fff4ca-30d7e206a31mr44493701fa.3.1742834127294;
        Mon, 24 Mar 2025 09:35:27 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d7fe7b4sm14771581fa.53.2025.03.24.09.35.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 09:35:26 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30bfc8faef9so47537131fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 09:35:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXxeRiWrSRiUCKT3teWv7QxE+T1sEgZf0jqJmrhZpv6D+NBX9+PSWFiOkAughGvU6LNzEZBGxrMh3AsRxk=@vger.kernel.org
X-Received: by 2002:a2e:bc08:0:b0:30a:4428:dea9 with SMTP id
 38308e7fff4ca-30d7e2ba31bmr57231481fa.30.1742834124892; Mon, 24 Mar 2025
 09:35:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318-synaptic-expt-v1-1-fa3831a7d883@redhat.com>
In-Reply-To: <20250318-synaptic-expt-v1-1-fa3831a7d883@redhat.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 24 Mar 2025 09:35:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WqN0XVse0HvdzeSqi+rJ0X0zoXb718+FBr_44TPbBX5A@mail.gmail.com>
X-Gm-Features: AQ5f1JqNq1lS2CtrAR4jlSIscWwBK3GQhAIHOAxkhnKx3a3XI2tYTZa6bM4a9Do
Message-ID: <CAD=FV=WqN0XVse0HvdzeSqi+rJ0X0zoXb718+FBr_44TPbBX5A@mail.gmail.com>
Subject: Re: [PATCH v4] drm/panel/synaptics-r63353: Use _multi variants
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Tejas Vipin <tejasvipin76@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 18, 2025 at 7:37=E2=80=AFAM Anusha Srivatsa <asrivats@redhat.co=
m> wrote:
>
> Move away from using deprecated API and use _multi
> variants if available. Use mipi_dsi_msleep()
> and mipi_dsi_usleep_range() instead of msleep()
> and usleep_range() respectively.
>
> Used Coccinelle to find the _multi variant APIs,
> replacing mpi_dsi_msleep() where necessary and for returning
> dsi_ctx.accum_err in these functions. Manually handled the
> reset step before returning from r63353_panel_activate()
>
> v2: Do not skip the reset in case of error during
> panel activate (Dmitry)
> - Convert all usleep_range()
>
> v3: mipi_dsi_usleep_range() is to be used only when in
> between _multi commands(Doug)
> - Check for error once in the end while using _multi
> variants (Doug)
>
> v4: Change return type of r63353_panel_deactivate() to void (Doug)
>
> @rule_1@
> identifier dsi_var;
> identifier r;
> identifier func;
> type t;
> position p;
> expression dsi_device;
> expression list es;
> @@
> t func(...) {
> ...
> struct mipi_dsi_device *dsi_var =3D dsi_device;
> +struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_var };
> <+...
> (
> -r =3D mipi_dsi_dcs_nop(dsi_var)@p;
> +mipi_dsi_dcs_nop_multi(&dsi_ctx);
> |
> -r =3D mipi_dsi_dcs_exit_sleep_mode(dsi_var)@p;
> +mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> |
> -r =3D mipi_dsi_dcs_enter_sleep_mode(dsi_var)@p;
> +mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> |
> -r =3D mipi_dsi_dcs_write_buffer(dsi_var,es)@p;
> +mipi_dsi_dcs_write_buffer_multi(&dsi_ctx,es);
> |
> -r =3D mipi_dsi_dcs_set_display_off(dsi_var,es)@p;
> +mipi_dsi_dcs_set_display_off_multi(&dsi_ctx,es);
> |
> -r =3D mipi_dsi_compression_mode_ext(dsi_var,es)@p;
> +mipi_dsi_compression_mode_ext_multi(&dsi_ctx,es);
> |
> -r =3D mipi_dsi_compression_mode(dsi_var,es)@p;
> +mipi_dsi_compression_mode_multi(&dsi_ctx,es);
> |
> -r =3D mipi_dsi_picture_parameter_set(dsi_var,es)@p;
> +mipi_dsi_picture_parameter_set_multi(&dsi_ctx,es);
> |
> -r =3D mipi_dsi_dcs_set_display_on(dsi_var,es)@p;
> +mipi_dsi_dcs_set_display_on_multi(&dsi_ctx,es);
> |
> -r =3D mipi_dsi_dcs_set_tear_on(dsi_var)@p;
> +mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx);
> |
> -r =3D mipi_dsi_turn_on_peripheral(dsi_var)@p;
> +mipi_dsi_turn_on_peripheral_multi(&dsi_ctx);
> |
> -r =3D mipi_dsi_dcs_soft_reset(dsi_var)@p;
> +mipi_dsi_dcs_soft_reset_multi(&dsi_ctx);
> |
> -r =3D mipi_dsi_dcs_set_display_brightness(dsi_var,es)@p;
> +mipi_dsi_dcs_set_display_brightness_multi(&dsi_ctx,es);
> |
> -r =3D mipi_dsi_dcs_set_pixel_format(dsi_var,es)@p;
> +mipi_dsi_dcs_set_pixel_format_multi(&dsi_ctx,es);
> |
> -r =3D mipi_dsi_dcs_set_column_address(dsi_var,es)@p;
> +mipi_dsi_dcs_set_column_address_multi(&dsi_ctx,es);
> |
> -r =3D mipi_dsi_dcs_set_page_address(dsi_var,es)@p;
> +mipi_dsi_dcs_set_page_address_multi(&dsi_ctx,es);
> |
> -r =3D mipi_dsi_dcs_set_tear_scanline(dsi_var,es)@p;
> +mipi_dsi_dcs_set_tear_scanline_multi(&dsi_ctx,es);
> )
> -if(r < 0) {
> -...
> -}
> ...+>
> }
>
> @rule_2@
> identifier dsi_var;
> identifier r;
> identifier func;
> type t;
> position p;
> expression dsi_device;
> expression list es;
> @@
> t func(...) {
> ...
> struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_var };
> <+...
> (
> -r =3D msleep(es)@p;
> +r =3D mipi_dsi_msleep(&dsi_ctx,es);
> |
> -msleep(es)@p;
> +mipi_dsi_msleep(&dsi_ctx,es);
> |
> -r =3D usleep_range(es)@p;
> +r =3D mipi_dsi_usleep_range(&dsi_ctx,es);
> |
> -usleep_range(es)@p;
> +mipi_dsi_usleep_range(&dsi_ctx,es);
> )
> ...+>
> }
>
> @rule_3@
> identifier dsi_var;
> identifier func;
> type t;
> position p;
> expression list es;
> @@
> t func(...) {
> ...
> struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_var };
> ...
> -return 0;
> +return dsi_ctx.accum_err;
> }
>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Tejas Vipin <tejasvipin76@gmail.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
> ---
> Previous attempt for this change was addressed in:[1]
> The series did not handle returns properly and still
> used msleep() and usleep_range() API.
> It also collided with an Tejas's similar efforts.
>
> Will be sending the patches per driver instead of
> major haul of changes.
>
> Following [2] for reference.
>
> [1] -> https://patchwork.freedesktop.org/series/144824/
> [2] -> https://lore.kernel.org/dri-devel/20250220045721.145905-1-tejasvip=
in76@gmail.com/#iZ31drivers:gpu:drm:panel:panel-sony-td4353-jdi.c
> ---
> Changes in v4:
> - Change return type for r63353_panel_deactivate() from int to void
> - Link to v3: https://lore.kernel.org/all/20250314-b4-mipi-synaptic-v1-1-=
a64ccb5e5c66@redhat.com/
>
> Changes in v3:
> - Modify the script to handle returns and msleeps ()
> - handle reset in case of error properly
>
> - Link to v2: https://lore.kernel.org/all/20250310-mipi-synaptic-1-v2-1-2=
0ee4397c670@redhat.com/
>
> Changes in v2:
> - Handle the reset case properly
> - Handle msleep() and  usleep_range()
>
> - Link to v1: https://lore.kernel.org/r/20250305-mipi-synaptic-1-v1-1-920=
17cd19ef6@redhat.com
> ---
>  drivers/gpu/drm/panel/panel-synaptics-r63353.c | 68 +++++++-------------=
------
>  1 file changed, 19 insertions(+), 49 deletions(-)

Pushed to drm-misc-next:

[1/1] drm/panel/synaptics-r63353: Use _multi variants
      commit: c8ba07caaecc622a9922cda49f24790821af8a71

