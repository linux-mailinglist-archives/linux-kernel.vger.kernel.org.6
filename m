Return-Path: <linux-kernel+bounces-275277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5883F9482A7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162FA2836D9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D840516BE1D;
	Mon,  5 Aug 2024 19:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9jcgOuA"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9D714A85;
	Mon,  5 Aug 2024 19:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722887553; cv=none; b=OmE1I+b5lUBA55idkf55v5IpZus5B/ELOOqm+G2PKvnMW5jmV0sWKGUsECIsXxNiRhNwP6TMSQ0ObHoKvwQ0MdUZouUxbc+C3VppFPgzLMCFkhKgVa3Jnwc3nAwLipw8bVAirZf+TdmazlDc+L77u/tjEExzWyijUA6EsEg6Va4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722887553; c=relaxed/simple;
	bh=9VSLOEaSeCQsM6p0uLK4UvCRpl1MQVbM/4gE04COamQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3MuevrIwCtGBAgvjvzAeEYiQwAEjwr6RrUCeDNgrlndd4rl+U1XXnSR4M3SQ1hJ+Q8PbaMc+wP0zCkGtLL9a98a2L/GnYOJ+SDj7oPaThXc37gRK1mZKD7Rzf/8rJHfujq87mlBpp661v/C2OrcB0h5ILJJlNJClh/WFEJJR+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9jcgOuA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so7400855b3a.1;
        Mon, 05 Aug 2024 12:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722887551; x=1723492351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HlAePfdGUtDDXh2mo5MYu8Z88Te8t6lOKxNdEz/0mg=;
        b=A9jcgOuAMtZdMTyzPKZg2Eq6A3UHdhCdDr3Y96kWvCeUfJfF1uABc4d4JxWl4tjq0D
         QHmZyP6dcD8MilY6dDixX4fQh+1+gqPPKt8LJsynVDTYhGCuh1Inidrqzz1FGfaVNs03
         zmjBalc7S6o6syBXcaU57OrplICzFpLgDRn9lQgmcCzSsyWN36htqgRnPjWzRhptsc/I
         uJHh5FUBBUzSl+yNpIaZt/mfRjOcWsjdBQGGEcCVzf28KYr3YOzPBPY9j17+FUqk4L77
         1bNwv5YAE5HcI4yXWprP+o+umrZDWGsT2NN5E6JQkNCs0mBGKGIXkDtY6jzS2npDmuUl
         sqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722887551; x=1723492351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0HlAePfdGUtDDXh2mo5MYu8Z88Te8t6lOKxNdEz/0mg=;
        b=L7uLam8uwSMd/HyTjHq6BYLvrGSiDgz6odEkJlW6a8oDI/nSYy+8sk1cYZG3L/3WUM
         +HtHrsktxqgp5rb8lBHAFNXSKgU4npLwoHZejc+CjhKJO3bgz06DAIR7wf/kkYcnn99X
         KyEZ8myeEYXgm3aIACGeoIw7y3QCmhvLy5RKHfApzMC4O+CTShdOCbu7lQTObwhWLzmd
         w2svNAp+BXr2vBqR46Pcu/WgdKDsTEbpSKzMO/xUTEoOF/T+jMABoMj3xlRcjFhbchUh
         9Us+mmeQEObHKTF5FtMwvHyrGu7+QoRQJbTd4woT4TqYp/zFrSAiLnvqvjp67U/qBql/
         Hoow==
X-Forwarded-Encrypted: i=1; AJvYcCW2ShcKINBQ0DlBUcwcDjeaHos4TVHxNOb/4P2N8ZjhCQnop5fOvyBBHH4iGsCWV+v21iVW7UVH5MmpCboevgPVVYpg7a+0cenWJI2p0lLt9BtFESlKWNBbGiAZsVfqhJHqvs5HiiOLlmGVRz8m
X-Gm-Message-State: AOJu0YxEVaDvkPPw//Nf3YbftGftXkb/hXzxH3KSQ/OURzDDOB1kMSGK
	7p8RchyylOLjymlY3FVajAkaBChOT9VrC7cmtGXldf+xEQCNqi5+QCmH3y0TUYDPNXqJmoJag6b
	G7Jn32JmAw9buriPP8TypgBjyQZ0=
X-Google-Smtp-Source: AGHT+IHD6mP8SxzNmBFzhhHmk0yrW6460OtmeCKxd9zkNwGyWG7aj7cAJ++vLvTXwtV9xxS0vkvdBsafUOrPg1LHZz4=
X-Received: by 2002:a05:6a00:a93:b0:70b:a46:7db3 with SMTP id
 d2e1a72fcca58-7106d02ba17mr15666583b3a.19.1722887550766; Mon, 05 Aug 2024
 12:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802114252.449452-1-colin.i.king@gmail.com>
In-Reply-To: <20240802114252.449452-1-colin.i.king@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 5 Aug 2024 15:52:18 -0400
Message-ID: <CADnq5_Ouob7zaqF1uTwL70QnWegEpvi0kkJY42yULPfCoW5d_Q@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: remove extraneous ; after statements
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Chaitanya Dhere <chaitanya.dhere@amd.com>, Jun Lei <jun.lei@amd.com>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui.Pan@amd.com, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Fri, Aug 2, 2024 at 8:00=E2=80=AFAM Colin Ian King <colin.i.king@gmail.c=
om> wrote:
>
> There are a several statements with two following semicolons, replace
> these with just one semicolon.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  .../drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c  | 2 +-
>  .../dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c        | 2 +-
>  .../display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c    | 4 ++--
>  drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c              | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_=
helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_help=
er.c
> index 65776602648d..9956974c4527 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.=
c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.=
c
> @@ -1040,7 +1040,7 @@ void dml21_copy_clocks_to_dc_state(struct dml2_cont=
ext *in_ctx, struct dc_state
>  void dml21_extract_legacy_watermark_set(const struct dc *in_dc, struct d=
cn_watermarks *watermark, enum dml2_dchub_watermark_reg_set_index reg_set_i=
dx, struct dml2_context *in_ctx)
>  {
>         struct dml2_core_internal_display_mode_lib *mode_lib =3D &in_ctx-=
>v21.dml_init.dml2_instance->core_instance.clean_me_up.mode_lib;
> -       double refclk_freq_in_mhz =3D (in_ctx->v21.display_config.overrid=
es.hw.dlg_ref_clk_mhz > 0) ? (double)in_ctx->v21.display_config.overrides.h=
w.dlg_ref_clk_mhz : mode_lib->soc.dchub_refclk_mhz;;
> +       double refclk_freq_in_mhz =3D (in_ctx->v21.display_config.overrid=
es.hw.dlg_ref_clk_mhz > 0) ? (double)in_ctx->v21.display_config.overrides.h=
w.dlg_ref_clk_mhz : mode_lib->soc.dchub_refclk_mhz;
>
>         if (reg_set_idx >=3D DML2_DCHUB_WATERMARK_SET_NUM) {
>                 /* invalid register set index */
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2=
_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_cor=
e/dml2_core_dcn4_calcs.c
> index 13f2c80bad4c..54197d18ab19 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_d=
cn4_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_d=
cn4_calcs.c
> @@ -7218,7 +7218,7 @@ static bool dml_core_mode_support(struct dml2_core_=
calcs_mode_support_ex *in_out
>  #if defined(DV_BUILD)
>                 // Assume a memory config setting of 3 in 420 mode or get=
 a new ip parameter that reflects the programming.
>                 if (mode_lib->ms.BytePerPixelC[k] !=3D 0.0 && display_cfg=
->plane_descriptors[k].pixel_format !=3D dml2_rgbe_alpha) {
> -                       lb_buffer_size_bits_luma =3D 34620 * 57;;
> +                       lb_buffer_size_bits_luma =3D 34620 * 57;
>                         lb_buffer_size_bits_chroma =3D 13560 * 57;
>                 }
>  #endif
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2=
_core_shared.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dm=
l2_core_shared.c
> index c54c29711a65..8f3c1c0b1cc1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_s=
hared.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_s=
hared.c
> @@ -6464,8 +6464,8 @@ static void CalculateSwathAndDETConfiguration(struc=
t dml2_core_internal_scratch
>                         p->SwathHeightC[k] =3D l->MaximumSwathHeightC[k] =
/ 2;
>                         l->RoundedUpSwathSizeBytesY[k] =3D p->full_swath_=
bytes_l[k] / 2;
>                         l->RoundedUpSwathSizeBytesC[k] =3D p->full_swath_=
bytes_c[k] / 2;
> -                       p->request_size_bytes_luma[k] =3D ((p->BytePerPix=
Y[k] =3D=3D 2) =3D=3D dml_is_vertical_rotation(p->display_cfg->plane_descri=
ptors[k].composition.rotation_angle)) ? 128 : 64;;
> -                       p->request_size_bytes_chroma[k] =3D ((p->BytePerP=
ixC[k] =3D=3D 2) =3D=3D dml_is_vertical_rotation(p->display_cfg->plane_desc=
riptors[k].composition.rotation_angle)) ? 128 : 64;;
> +                       p->request_size_bytes_luma[k] =3D ((p->BytePerPix=
Y[k] =3D=3D 2) =3D=3D dml_is_vertical_rotation(p->display_cfg->plane_descri=
ptors[k].composition.rotation_angle)) ? 128 : 64;
> +                       p->request_size_bytes_chroma[k] =3D ((p->BytePerP=
ixC[k] =3D=3D 2) =3D=3D dml_is_vertical_rotation(p->display_cfg->plane_desc=
riptors[k].composition.rotation_angle)) ? 128 : 64;
>                 }
>
>                 if (p->SwathHeightC[k] =3D=3D 0)
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c b/drivers/g=
pu/drm/amd/display/dc/dml2/dml2_utils.c
> index 7655501e75d4..9e8ff3a9718e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
> @@ -421,7 +421,7 @@ unsigned int dml2_calc_max_scaled_time(
>
>  void dml2_extract_writeback_wm(struct dc_state *context, struct display_=
mode_lib_st *dml_core_ctx)
>  {
> -       int i, j =3D 0;;
> +       int i, j =3D 0;
>         struct mcif_arb_params *wb_arb_params =3D NULL;
>         struct dcn_bw_writeback *bw_writeback =3D NULL;
>         enum mmhubbub_wbif_mode wbif_mode =3D PACKED_444_FP16; /*for now*=
/
> --
> 2.39.2
>

