Return-Path: <linux-kernel+bounces-575642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E24A70539
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221653A5471
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702B41A0BFE;
	Tue, 25 Mar 2025 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jf2jLHjO"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DE328DB3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916852; cv=none; b=Ws+2dKDCLpEUExiQ1UnrTOBE3jLevCtXYVaXCed7vtUwQfz5OpkgxTEGYnUyJOfyCO/KNEEio0OwNgh4/kppB43mleGvK4StFtbxCrfJg4SeMDbnyK55W7r5+RtW9l3gSJD/MgW31N7IklKhweo2WzW37uZ8Lg50vD8M8xLuoWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916852; c=relaxed/simple;
	bh=0tjtGHPf+uz3WYTr3/1KUeYJescngqRY+IjfbuzR5Ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGZ8GQMZmDVmBA30F80qC7WiCEgTe3ebT9pL2cXC5ni3p+SWhETAwoOcg7rdKaKMdNRC60jx2SnitIrzgIKsOANctsrFnuxEYAuvO+k+KPupy4WoC8YtGYwgRog0Mh6PuaTz59PnWOws6HiJk6a75FJjnS3+/+s3OcbI/rZmTNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jf2jLHjO; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30db1bd3bebso7762611fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742916845; x=1743521645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1Vc6gMV26ZKRmVjPbIms2/GbFw+3qC8T6sWJSOv4YE=;
        b=jf2jLHjOb8ww4yORnyv3bShw9FKdV7QcbFqUz68/rsFjJhbOPEbUJcYFKNpvZoBot4
         nSa5rBcECBi43r/DwnT4NZKIOx7pjNB4B53fO5M0TCUGf8tQxnNF8j9cRegEFXW2H7pr
         3dBBtkSgEnfnPr2O8F0Wh/ea56GrmjmtxyR7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742916845; x=1743521645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1Vc6gMV26ZKRmVjPbIms2/GbFw+3qC8T6sWJSOv4YE=;
        b=vpHaYC6Uqb/XPvIPcdFXlQcfEprnn7UoPkqpsiKM6yg9UiW7F03rhThFh5WlxJNLXN
         D/xUtX/atiAXYBR6utXMpcUUXFQamYPwKg7mMqfjaa4LKO6mzF2Z9SwJgUqAty1+JI34
         WD/02b52WcntYasfFUx9LmS75sncrn3kU80y8rNQh8cYHSOv11iPVCCEhL9h9iC7sVqN
         X94U3eQ+2zlUbjeNoi7Lmt5QiSWICtYDZIimPhnUIR8aRYRhQHbuNNq/iosITmZKKuse
         fuDCeB4N2VrHN25sGvfam/oz5hDJINduZNA+d5N/wVk9IBwe4demBiw9gVa+Fkb+EKJC
         8rfw==
X-Forwarded-Encrypted: i=1; AJvYcCW55k+4mHRFUuP3IJzc27luB1tbyka0V9MF4jS4QLV3kVzbEdG4JEfpbuhW+BifqKKpDQBbKUkJExmPcj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ucpGeyEducO46rg8T3091VjYNN0NubVz6o1mzHvoZoH/f7L1
	LR5l7mGbjWVdgC8nDOtb1AJ2h6KJCPqhLNTAr0EVYuOftSsRALicwiZKZULrOo8oRzpZlu/aAc5
	8ThYS
X-Gm-Gg: ASbGnctWIH93Zwx80CMq4Ht2CJvub/FlHYSyC8tShwyfYlvDU3yJPl50ZTyzWEgwk7i
	D+Xeyw8OzznrOcFkHuTu5d3ihXe86+hbdZegXUy+rGr8deWfFmDIie1C+xTFpBVuOE8fhnUx8O4
	sKXEib1zaNvdZQERsYD1ejhqspZ5Slbz9jqgYdTPem/woPj01ZV1Q9H0MNm57BbNHj7yLgW9LLc
	dFxezSy5/xwfgmb4Na67jJVnERbarusu5un2B+IHlyQshiTuxyxS/SsifTQ05CG6Jnzza5ILCYv
	UmADJQ2rwdM4Q+cU08Ubi/ZGR7FGXqJj9YbyCPqGh50tr2+Vm9tafS9ywR6SGBsGUo46qCWnKSY
	jvm4hDZzw
X-Google-Smtp-Source: AGHT+IFckzcqlHrgCtHrOGDdLuz7Bh0e52X+1RruOqUKX2Q4n5h5RB1tl+C5dJDwLZguTCRSPYYJhg==
X-Received: by 2002:a2e:bd0f:0:b0:308:e54d:61b1 with SMTP id 38308e7fff4ca-30d7e2f8c96mr92135491fa.34.1742916845090;
        Tue, 25 Mar 2025 08:34:05 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d7c19c3sm19165501fa.4.2025.03.25.08.34.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 08:34:01 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-549b159c84cso6466167e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:34:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXrdHUGH7hCl2Gg9+j48R6PFP1ss2wWvIYdmfofOe3DVFTtPLDqOBQxrfmpqnINKm+CU9G/PIoOEEknmXk=@vger.kernel.org
X-Received: by 2002:a05:6512:2311:b0:549:b10b:1efe with SMTP id
 2adb3069b0e04-54ad64f586fmr6578104e87.32.1742916840580; Tue, 25 Mar 2025
 08:34:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324-b4-panel-ls043t1le01-v2-1-e43aedc115be@redhat.com>
In-Reply-To: <20250324-b4-panel-ls043t1le01-v2-1-e43aedc115be@redhat.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 25 Mar 2025 08:33:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XXHOjpZUrb5BGSZ-OqaCdmzqwDnVx5zcnV3BEOyjuByQ@mail.gmail.com>
X-Gm-Features: AQ5f1JpZr2gzmB5abncfLOXiL0cPD4zsNTKaXEm7_4Suw0CNS-ckPxaE1sycxXk
Message-ID: <CAD=FV=XXHOjpZUrb5BGSZ-OqaCdmzqwDnVx5zcnV3BEOyjuByQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel/sharp-ls043t1le01: Use _multi variants
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Tejas Vipin <tejasvipin76@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 24, 2025 at 1:31=E2=80=AFPM Anusha Srivatsa <asrivats@redhat.co=
m> wrote:
>
> Move away from using deprecated API and use _multi
> variants if available. Use mipi_dsi_msleep()
> and mipi_dsi_usleep_range() instead of msleep()
> and usleep_range() respectively.
>
> Used Coccinelle to find the _multi variant APIs,
> replacing mpi_dsi_msleep() where necessary and for returning
> dsi_ctx.accum_err in these functions. mipi_dsi_dcs_write()
> does not have a corresponding _multi() variant. Replacing it with
> mipi_dsi_dcs_write_buffer_multi() instead. This change is manual
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

This is the exact same script as last time, right? Rather than
duplicate it, you can just reference the previous patch that already
landed. You'd say something like:

The Coccinelle script is the same as the one in commit c8ba07caaecc
("drm/panel/synaptics-r63353: Use _multi variants")


> v2: Use mipi_dsi_dcs_write_buffer_multi() in place of
> mipi_dsi_dcs_write(). (Dmitry)
>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Tejas Vipin <tejasvipin76@gmail.com>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
> ---
> Changes in v2:
> - While mipi_dsi_dcs_write() does not have a corresponding _multi()
>   variant replace it with mipi_dsi_dcs_write_buffer_multi() to have all
>   APIs following _multi() usage for easier error handling
>
> - Link to v1: https://lore.kernel.org/r/20250316-b4-panel-ls043t1le01-v1-=
1-ee38371b0ba0@redhat.com
> ---
>  drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c | 42 ++++++++++---------=
------
>  1 file changed, 16 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c b/drivers/gp=
u/drm/panel/panel-sharp-ls043t1le01.c
> index 729cbb0d8403ff7c0c4b9d21774909cc298904a2..e3dc99ff711e388660d6d3925=
1876de8cec50dbc 100644
> --- a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
> +++ b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
> @@ -36,60 +36,50 @@ static inline struct sharp_nt_panel *to_sharp_nt_pane=
l(struct drm_panel *panel)
>  static int sharp_nt_panel_init(struct sharp_nt_panel *sharp_nt)
>  {
>         struct mipi_dsi_device *dsi =3D sharp_nt->dsi;
> -       int ret;
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi };
>
> +       static const u8 d[] =3D { 0xae,  0x03 };
>         dsi->mode_flags |=3D MIPI_DSI_MODE_LPM;
>
> -       ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
> -       if (ret < 0)
> -               return ret;
> +       mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
>
> -       msleep(120);
> +       mipi_dsi_msleep(&dsi_ctx, 120);
>
>         /* Novatek two-lane operation */
> -       ret =3D mipi_dsi_dcs_write(dsi, 0xae, (u8[]){ 0x03 }, 1);
> -       if (ret < 0)
> -               return ret;
> +       mipi_dsi_dcs_write_buffer_multi(&dsi_ctx, d, ARRAY_SIZE(d));

Can't the above just be:

mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xae, 0x03);

?


-Doug

