Return-Path: <linux-kernel+bounces-387077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5848C9B4B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FE4C1C22856
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A2920696B;
	Tue, 29 Oct 2024 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHxffMUg"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBC020694B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730210413; cv=none; b=PulIBGoGFZ48yrbuhZ/E6kcfDcF5sQc5/jRXEJPU7wRVWGttEGaq7aIUt84tglJQhw3aKyYL52CocrLab6VY+PEIpTlEsKb+dg+PftKV5RciQAeP3wY/ARyAGaeNvOZHoTWyCnsb4JM8SyJtE/Vj8CVZUy+u0CbkOEu5DV58078=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730210413; c=relaxed/simple;
	bh=nnR11+f9keATOzkEQC1nKkxPmkVJ/WMAbUXmr1fERDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pa+pdVmcdN6elzr2l/NNR67ypHmpjlQ8pGRI3Zp264+cglGLMT86I+O/9pEsXa/QNCQTBvLXt5fZVePUuwUw9xhIAyLsj/l55qjMCpV+jmWA9Y1zqigPDJa3YJq7IdFZXYcWYBN3HZ/GeB4azrlqSYH3xrhQein5Woz+YBtlXFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHxffMUg; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-72088a79f57so151925b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 07:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730210409; x=1730815209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRzQWzkzVI0fNiNgdZexP1F+fhwsUnCCzVqowPLugVQ=;
        b=hHxffMUg+2W9+zGbTNXcFu06TS7C9Nq2qVITSqR32JoEEGYvkzF/HYjf97kikYrFgY
         t7ZphS5YpbguVgEuWmY5E1CwKqo/ZJyuWA+0mAEKFRzfoS0KkUdzL06YloOWT3XkTh0D
         VkLHa2VQZmO2wUb9l1/Zkkyzupwc+u3ylhH7Rr9ZWJ39G9qJY0Y4HUiqy7Jn2c2YKmE3
         Vp5oBWuF++7N9oVAjTK8ZDj5aDJqjq4bdbLfSqLe0XqopL63kkUP+YMV/fI7WEzWhgVK
         z/5Fx2YtcY9/c1UvpDgF7wz5ZcUHBLp4myLacLqyaEcNS/MmnGfvFy2jMsn5EXPY70tx
         p04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730210409; x=1730815209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRzQWzkzVI0fNiNgdZexP1F+fhwsUnCCzVqowPLugVQ=;
        b=kapNcJDFuQ3fEmoi5dg8Fu1g5jAkooMAK0RHlTelDmCxpshXu5vx/ZTZQk0HXWFAvP
         PSM/YzxFda50GY3in+P7RiJR6bafT159C9vJUCvYeUZ4VuDcOeHDU8gC62sXHysX4V45
         FCNbvgn2biSbXZsnznHXnUTy2qOZPQpuG+lNlVywIL39IrGJlMV8nMfkQST0qqplV2b5
         9uYiMvFAQxl3EAj1rZTwmRFEh8Y6dV/UNLsMQ+nisx20VjKGoQy3MVDKfohnJLWaPLzL
         3gcfi+ZnQzGdcs65Gef31BuKwydCdYTdadKQXPteJeLUZQ4qAEbz4fiUfEuvM5HiRY4a
         wG+g==
X-Forwarded-Encrypted: i=1; AJvYcCVKAyE7/DgvANh1GIab/Jvgx+Wg7/McWTkzbX/9q24LWkLiEJIUrf9fzOXAr9/QFteMLuGu10ElRhcOR1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9XgAhcKUOh/Fv8xscvbtUED6pTCw/QxgeaESsCkn3/u+Vikt+
	QsHsug0Aan+j1KxGecOo3Mzg/rYmWUpJ+RQp8AaPpmqSgrG1S1dvqFfq0AJZca6kiRULo2kKSyr
	p3KaVMBfMhz5Lb0sFsEOae928dGk=
X-Google-Smtp-Source: AGHT+IF8EmYCCix2LYg3DJ33AP+Pal3sY4n0LMPNaS6LipuMpYMeomJ/gVgbaq7VmOk1rqHkC33kd8GQb9HNTWZ+GSk=
X-Received: by 2002:a05:6a00:4613:b0:71e:5132:da7b with SMTP id
 d2e1a72fcca58-72063004c28mr7327479b3a.3.1730210407492; Tue, 29 Oct 2024
 07:00:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010205154.278023-1-linux@treblig.org>
In-Reply-To: <20241010205154.278023-1-linux@treblig.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Oct 2024 09:59:56 -0400
Message-ID: <CADnq5_PP7zZ3-=4UmOc+eKyywo0oJKZw6BGV5+YbmFPnB0p7Mw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove last parts of timing_trace
To: linux@treblig.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Thu, Oct 10, 2024 at 4:52=E2=80=AFPM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> Commit c2c2ce1e9623 ("drm/amd/display: Optimize passive update planes.")
> removed the last caller of context_timing_trace.
> Remove it.
>
> With that gone, no one is now looking at the 'timing_trace' flag, remove
> it and all the places that set it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  .../gpu/drm/amd/display/dc/core/dc_debug.c    | 42 -------------------
>  drivers/gpu/drm/amd/display/dc/dc.h           |  1 -
>  .../dc/resource/dcn10/dcn10_resource.c        |  2 -
>  .../dc/resource/dcn20/dcn20_resource.c        |  1 -
>  .../dc/resource/dcn201/dcn201_resource.c      |  1 -
>  .../dc/resource/dcn21/dcn21_resource.c        |  1 -
>  .../dc/resource/dcn30/dcn30_resource.c        |  1 -
>  .../dc/resource/dcn301/dcn301_resource.c      |  1 -
>  .../dc/resource/dcn302/dcn302_resource.c      |  1 -
>  .../dc/resource/dcn303/dcn303_resource.c      |  1 -
>  .../dc/resource/dcn31/dcn31_resource.c        |  1 -
>  .../dc/resource/dcn314/dcn314_resource.c      |  1 -
>  .../dc/resource/dcn315/dcn315_resource.c      |  1 -
>  .../dc/resource/dcn316/dcn316_resource.c      |  1 -
>  .../dc/resource/dcn32/dcn32_resource.c        |  1 -
>  .../dc/resource/dcn321/dcn321_resource.c      |  1 -
>  .../dc/resource/dcn35/dcn35_resource.c        |  1 -
>  .../dc/resource/dcn351/dcn351_resource.c      |  1 -
>  .../dc/resource/dcn401/dcn401_resource.c      |  1 -
>  .../amd/display/include/logger_interface.h    |  4 --
>  20 files changed, 65 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c b/drivers/gpu=
/drm/amd/display/dc/core/dc_debug.c
> index 801cdbc8117d..0bb25c537243 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
> @@ -46,11 +46,6 @@
>                         DC_LOG_IF_TRACE(__VA_ARGS__); \
>  } while (0)
>
> -#define TIMING_TRACE(...) do {\
> -       if (dc->debug.timing_trace) \
> -               DC_LOG_SYNC(__VA_ARGS__); \
> -} while (0)
> -
>  #define CLOCK_TRACE(...) do {\
>         if (dc->debug.clock_trace) \
>                 DC_LOG_BANDWIDTH_CALCS(__VA_ARGS__); \
> @@ -306,43 +301,6 @@ void post_surface_trace(struct dc *dc)
>
>  }
>
> -void context_timing_trace(
> -               struct dc *dc,
> -               struct resource_context *res_ctx)
> -{
> -       int i;
> -       int h_pos[MAX_PIPES] =3D {0}, v_pos[MAX_PIPES] =3D {0};
> -       struct crtc_position position;
> -       unsigned int underlay_idx =3D dc->res_pool->underlay_pipe_index;
> -       DC_LOGGER_INIT(dc->ctx->logger);
> -
> -
> -       for (i =3D 0; i < dc->res_pool->pipe_count; i++) {
> -               struct pipe_ctx *pipe_ctx =3D &res_ctx->pipe_ctx[i];
> -               /* get_position() returns CRTC vertical/horizontal counte=
r
> -                * hence not applicable for underlay pipe
> -                */
> -               if (pipe_ctx->stream =3D=3D NULL || pipe_ctx->pipe_idx =
=3D=3D underlay_idx)
> -                       continue;
> -
> -               pipe_ctx->stream_res.tg->funcs->get_position(pipe_ctx->st=
ream_res.tg, &position);
> -               h_pos[i] =3D position.horizontal_count;
> -               v_pos[i] =3D position.vertical_count;
> -       }
> -       for (i =3D 0; i < dc->res_pool->pipe_count; i++) {
> -               struct pipe_ctx *pipe_ctx =3D &res_ctx->pipe_ctx[i];
> -
> -               if (pipe_ctx->stream =3D=3D NULL || pipe_ctx->pipe_idx =
=3D=3D underlay_idx)
> -                       continue;
> -
> -               TIMING_TRACE("OTG_%d   H_tot:%d  V_tot:%d   H_pos:%d  V_p=
os:%d\n",
> -                               pipe_ctx->stream_res.tg->inst,
> -                               pipe_ctx->stream->timing.h_total,
> -                               pipe_ctx->stream->timing.v_total,
> -                               h_pos[i], v_pos[i]);
> -       }
> -}
> -
>  void context_clock_trace(
>                 struct dc *dc,
>                 struct dc_state *context)
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/di=
splay/dc/dc.h
> index 3992ad73165b..eb00ee73a8f2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -862,7 +862,6 @@ struct dc_debug_options {
>         bool sanity_checks;
>         bool max_disp_clk;
>         bool surface_trace;
> -       bool timing_trace;
>         bool clock_trace;
>         bool validation_trace;
>         bool bandwidth_calcs_trace;
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
> index 563c5eec83ff..0098b3e72e85 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
> @@ -533,7 +533,6 @@ static const struct dc_debug_options debug_defaults_d=
rv =3D {
>                 .sanity_checks =3D true,
>                 .disable_dmcu =3D false,
>                 .force_abm_enable =3D false,
> -               .timing_trace =3D false,
>                 .clock_trace =3D true,
>
>                 /* raven smu dones't allow 0 disp clk,
> @@ -563,7 +562,6 @@ static const struct dc_debug_options debug_defaults_d=
rv =3D {
>  static const struct dc_debug_options debug_defaults_diags =3D {
>                 .disable_dmcu =3D false,
>                 .force_abm_enable =3D false,
> -               .timing_trace =3D true,
>                 .clock_trace =3D true,
>                 .disable_stutter =3D true,
>                 .disable_pplib_clock_request =3D true,
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
> index eea2b3b307cd..46c38fd9288d 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
> @@ -706,7 +706,6 @@ static const struct resource_caps res_cap_nv14 =3D {
>  static const struct dc_debug_options debug_defaults_drv =3D {
>                 .disable_dmcu =3D false,
>                 .force_abm_enable =3D false,
> -               .timing_trace =3D false,
>                 .clock_trace =3D true,
>                 .disable_pplib_clock_request =3D true,
>                 .pipe_split_policy =3D MPC_SPLIT_AVOID_MULT_DISP,
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
> index fc54483b9104..5b87dfea62e4 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
> @@ -600,7 +600,6 @@ static const struct dc_plane_cap plane_cap =3D {
>  static const struct dc_debug_options debug_defaults_drv =3D {
>                 .disable_dmcu =3D true,
>                 .force_abm_enable =3D false,
> -               .timing_trace =3D false,
>                 .clock_trace =3D true,
>                 .disable_pplib_clock_request =3D true,
>                 .pipe_split_policy =3D MPC_SPLIT_DYNAMIC,
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
> index 347e6aaea582..135671d12c45 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
> @@ -610,7 +610,6 @@ static const struct dc_plane_cap plane_cap =3D {
>  static const struct dc_debug_options debug_defaults_drv =3D {
>                 .disable_dmcu =3D false,
>                 .force_abm_enable =3D false,
> -               .timing_trace =3D false,
>                 .clock_trace =3D true,
>                 .disable_pplib_clock_request =3D true,
>                 .min_disp_clk_khz =3D 100000,
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
> index 5040a4c6ed18..28c4ad289e54 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
> @@ -711,7 +711,6 @@ static const struct dc_plane_cap plane_cap =3D {
>  static const struct dc_debug_options debug_defaults_drv =3D {
>         .disable_dmcu =3D true, //No DMCU on DCN30
>         .force_abm_enable =3D false,
> -       .timing_trace =3D false,
>         .clock_trace =3D true,
>         .disable_pplib_clock_request =3D true,
>         .pipe_split_policy =3D MPC_SPLIT_DYNAMIC,
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
> index 7d04739c3ba1..b82a0559531a 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
> @@ -682,7 +682,6 @@ static const struct dc_plane_cap plane_cap =3D {
>  static const struct dc_debug_options debug_defaults_drv =3D {
>         .disable_dmcu =3D true,
>         .force_abm_enable =3D false,
> -       .timing_trace =3D false,
>         .clock_trace =3D true,
>         .disable_dpp_power_gate =3D false,
>         .disable_hubp_power_gate =3D false,
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
> index 5791b5cc2875..f272665aa6a8 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
> @@ -81,7 +81,6 @@
>  static const struct dc_debug_options debug_defaults_drv =3D {
>                 .disable_dmcu =3D true,
>                 .force_abm_enable =3D false,
> -               .timing_trace =3D false,
>                 .clock_trace =3D true,
>                 .disable_pplib_clock_request =3D true,
>                 .pipe_split_policy =3D MPC_SPLIT_DYNAMIC,
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
> index 63f0f882c861..ee9bc725a30e 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
> @@ -82,7 +82,6 @@
>  static const struct dc_debug_options debug_defaults_drv =3D {
>                 .disable_dmcu =3D true,
>                 .force_abm_enable =3D false,
> -               .timing_trace =3D false,
>                 .clock_trace =3D true,
>                 .disable_pplib_clock_request =3D true,
>                 .pipe_split_policy =3D MPC_SPLIT_AVOID,
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
> index ac8cb20e2e3b..95213c7160c6 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
> @@ -858,7 +858,6 @@ static const struct dc_plane_cap plane_cap =3D {
>  static const struct dc_debug_options debug_defaults_drv =3D {
>         .disable_dmcu =3D true,
>         .force_abm_enable =3D false,
> -       .timing_trace =3D false,
>         .clock_trace =3D true,
>         .disable_pplib_clock_request =3D false,
>         .pipe_split_policy =3D MPC_SPLIT_DYNAMIC,
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
> index 169924d0a839..44c52fcfc87d 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
> @@ -876,7 +876,6 @@ static const struct dc_debug_options debug_defaults_d=
rv =3D {
>         .replay_skip_crtc_disabled =3D true,
>         .disable_dmcu =3D true,
>         .force_abm_enable =3D false,
> -       .timing_trace =3D false,
>         .clock_trace =3D true,
>         .disable_dpp_power_gate =3D false,
>         .disable_hubp_power_gate =3D false,
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
> index 3f4b9dba4112..432af4fabdb2 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
> @@ -858,7 +858,6 @@ static const struct dc_debug_options debug_defaults_d=
rv =3D {
>         .disable_z10 =3D true, /*hw not support it*/
>         .disable_dmcu =3D true,
>         .force_abm_enable =3D false,
> -       .timing_trace =3D false,
>         .clock_trace =3D true,
>         .disable_pplib_clock_request =3D false,
>         .pipe_split_policy =3D MPC_SPLIT_DYNAMIC,
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
> index 5fd52c5fcee4..295065b1f206 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
> @@ -853,7 +853,6 @@ static const struct dc_debug_options debug_defaults_d=
rv =3D {
>         .disable_z10 =3D true, /*hw not support it*/
>         .disable_dmcu =3D true,
>         .force_abm_enable =3D false,
> -       .timing_trace =3D false,
>         .clock_trace =3D true,
>         .disable_pplib_clock_request =3D false,
>         .pipe_split_policy =3D MPC_SPLIT_DYNAMIC,
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> index a124ad9bd108..01cc6b76cd0e 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> @@ -689,7 +689,6 @@ static const struct dc_plane_cap plane_cap =3D {
>  static const struct dc_debug_options debug_defaults_drv =3D {
>         .disable_dmcu =3D true,
>         .force_abm_enable =3D false,
> -       .timing_trace =3D false,
>         .clock_trace =3D true,
>         .disable_pplib_clock_request =3D false,
>         .pipe_split_policy =3D MPC_SPLIT_AVOID, // Due to CRB, no need to=
 MPC split anymore
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> index 827a94f84f10..9da8e4579f91 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> @@ -686,7 +686,6 @@ static const struct dc_plane_cap plane_cap =3D {
>  static const struct dc_debug_options debug_defaults_drv =3D {
>         .disable_dmcu =3D true,
>         .force_abm_enable =3D false,
> -       .timing_trace =3D false,
>         .clock_trace =3D true,
>         .disable_pplib_clock_request =3D false,
>         .pipe_split_policy =3D MPC_SPLIT_AVOID,
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> index 893a9d9ee870..5a275883c144 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> @@ -712,7 +712,6 @@ static const struct dc_plane_cap plane_cap =3D {
>  static const struct dc_debug_options debug_defaults_drv =3D {
>         .disable_dmcu =3D true,
>         .force_abm_enable =3D false,
> -       .timing_trace =3D false,
>         .clock_trace =3D true,
>         .disable_pplib_clock_request =3D false,
>         .pipe_split_policy =3D MPC_SPLIT_AVOID,
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> index 70abd32ce2ad..51070b09a831 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> @@ -692,7 +692,6 @@ static const struct dc_plane_cap plane_cap =3D {
>  static const struct dc_debug_options debug_defaults_drv =3D {
>         .disable_dmcu =3D true,
>         .force_abm_enable =3D false,
> -       .timing_trace =3D false,
>         .clock_trace =3D true,
>         .disable_pplib_clock_request =3D false,
>         .pipe_split_policy =3D MPC_SPLIT_AVOID,
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
> index 9d56fbdcd06a..cfc1b77f5460 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
> @@ -685,7 +685,6 @@ static const struct dc_plane_cap plane_cap =3D {
>  static const struct dc_debug_options debug_defaults_drv =3D {
>         .disable_dmcu =3D true,
>         .force_abm_enable =3D false,
> -       .timing_trace =3D false,
>         .clock_trace =3D true,
>         .disable_pplib_clock_request =3D false,
>         .pipe_split_policy =3D MPC_SPLIT_AVOID,
> diff --git a/drivers/gpu/drm/amd/display/include/logger_interface.h b/dri=
vers/gpu/drm/amd/display/include/logger_interface.h
> index 02c23b04d34b..058f882d5bdd 100644
> --- a/drivers/gpu/drm/amd/display/include/logger_interface.h
> +++ b/drivers/gpu/drm/amd/display/include/logger_interface.h
> @@ -52,10 +52,6 @@ void update_surface_trace(
>
>  void post_surface_trace(struct dc *dc);
>
> -void context_timing_trace(
> -               struct dc *dc,
> -               struct resource_context *res_ctx);
> -
>  void context_clock_trace(
>                 struct dc *dc,
>                 struct dc_state *context);
> --
> 2.47.0
>

