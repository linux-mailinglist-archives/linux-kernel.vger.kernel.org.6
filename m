Return-Path: <linux-kernel+bounces-326992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F3B976F90
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CE53B243BD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B03C2C190;
	Thu, 12 Sep 2024 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YK+x4gfo"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1300149C50
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726162223; cv=none; b=Zu5bW/z+339S3NrD3HHsnwLk8VTXTb4ckjPW/H0HTFYqoQzFnl6md2kqsrfSkqhssJek6lFhfA5/WZkjtgnYaHIg0FdL0QSaPr1RrgkeexTBTSecD/4pqKg+iane/tMqMW3uBrTTxFUeYiwFfqZj1IuHSVAMCLl5/Md8slVp6hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726162223; c=relaxed/simple;
	bh=Uu8xl6fxyDyZsGVuZMvMLTJkeYGNLs7n4GLdiKTShmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4nBtlRSFCoFxakWoNyXLerYgJ5yWv5u0pyzY8LuhmaHVGuOYVU5d75UmYvIjXG0ZOiCP993wxuXRCO7SBLn8lAnZYTkA8q9hfLZMJIlZa7LFbfzLrVP8qR9Cz5fwzdCDGxEBvv6qiCX14uHxbwv181WrF4naj7xqck1KtKBuQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YK+x4gfo; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-718e55bca81so153135b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 10:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726162221; x=1726767021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5F3cwHqLIvvWEHInKjD1ssV8fBJH4qpK4XgV402VIkk=;
        b=YK+x4gfocHMDtMgvoY8svw/FRka3DBOGCIWCSKg+2Ix0Q8LlMNw3wu3ZbbyGZexJu5
         HSiFNL+5yeDV86zwDzHepvJBbQJMBh7lVtOQ8kRmuRucW5Mml3Q7ZwY1Sb/wGrqUSGMZ
         rRn48BqkWxJsxaAr3VFCH4Qh53eb4WSPQt6tHrpPAJTtq9+uO0mzDRiWAHLhLHVSBZIs
         7cjs9lOUTVUVnONTM+aeOL/DAJ5pubtipB3TBry/wPXcC1Elislx2AE9BrNbY38a0L7g
         POwGKb3UqWOhoDTLg4CbOPgLljAldSiHRIX1xHPusSJ76jWFGMwt/I00QH1cFOxt4tj4
         lvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726162221; x=1726767021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5F3cwHqLIvvWEHInKjD1ssV8fBJH4qpK4XgV402VIkk=;
        b=siKRNOl72ca/jHZ4ji8SFht0zFMCDCxTGZR5sPp6TrxbYxb0SvFYvBEQrWJKxUy68r
         YLvUd0BJPEDiQaREaWlCsF/9PG17BkzWJLsjCroQ7aQOgFqdSrQ9JMQh1iScjjH/MH+A
         Y5u8sQLrt1Ue/WIaMi9oEv2iDL90sfdU1RkMUSyZ+KClOrY0uJT2pC6vrhTK57BzVWCi
         RDtLZJgqqEkSiWwbVLrm015q05BpO0G9xQ4bUKL5ELo5x92RATparsTSE5zflvmTuhSB
         sQNeKBw5Wl0YrhZkduiQCssJo4r92umqPDV0jj4cRzZK+3U6j2pf/o3PvZOVbo+dbuyM
         6CjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVvwbSEYgpDr1mp1taehWn3F3XXwulQymnzpOd23o7mExX8MG9UvcLn+15jdntxaP0a5cBLtk71oSc5CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFfkxyXdGVUYldnRVymIk1HMNux6AHBwv+Z+y8ox8RuCDFO8qN
	uo5m/waRLwRxsHqMw3M15lTOf4TYTC1oR+fsqxaDelVsra2MaaGjYEWYnL++Zop3kukyFP2lWHH
	8muN/tSkKORmn+tkx7hO1pyajDVV0Yw==
X-Google-Smtp-Source: AGHT+IGGiDi0tH8UV4EuWDX58S3nFgVRaPtWI9WGPWNW+X4EpxgPlMehAnglZMQ4o5KE9POyTj+ZtG1pR9gUlGwq5qE=
X-Received: by 2002:a05:6a00:3990:b0:718:e49f:137b with SMTP id
 d2e1a72fcca58-7192634966dmr2222197b3a.7.1726162221032; Thu, 12 Sep 2024
 10:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912071209.47240-1-yanzhen@vivo.com>
In-Reply-To: <20240912071209.47240-1-yanzhen@vivo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Sep 2024 13:30:09 -0400
Message-ID: <CADnq5_PNCJ2oGBN0x3CFQsY4Ufw3=_LLc1tHEWhaoMFHYtOvrw@mail.gmail.com>
Subject: Re: [PATCH v1] drm/amd/display: fix typo in the comment
To: Yan Zhen <yanzhen@vivo.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, simona@ffwll.ch, chaitanya.dhere@amd.com, jun.lei@amd.com, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Thu, Sep 12, 2024 at 3:56=E2=80=AFAM Yan Zhen <yanzhen@vivo.com> wrote:
>
> Correctly spelled comments make it easier for the reader to understand
> the code.
>
> Replace 'maxium' with 'maximum' in the comment &
> replace 'diffculty' with 'difficulty' in the comment &
> replace 'suppluy' with 'supply' in the comment &
> replace 'Congiuration' with 'Configuration' in the comment &
> replace 'eanbled' with 'enabled' in the comment.
>
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> ---
>  drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c       | 2 +-
>  drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c | 6 +++---
>  drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c b/drivers/=
gpu/drm/amd/display/dc/basics/dce_calcs.c
> index e47e9db062f4..d70a3549e05a 100644
> --- a/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
> @@ -569,7 +569,7 @@ static void calculate_bandwidth(
>                                 break;
>                         }
>                         data->lb_partitions[i] =3D bw_floor2(bw_div(data-=
>lb_size_per_component[i], data->lb_line_pitch), bw_int_to_fixed(1));
> -                       /*clamp the partitions to the maxium number suppo=
rted by the lb*/
> +                       /* clamp the partitions to the maximum number sup=
ported by the lb */
>                         if ((surface_type[i] !=3D bw_def_graphics || dcei=
p->graphics_lb_nodownscaling_multi_line_prefetching =3D=3D 1)) {
>                                 data->lb_partitions_max[i] =3D bw_int_to_=
fixed(10);
>                         }
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/dr=
ivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
> index 547dfcc80fde..d851c081e376 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
> @@ -8926,7 +8926,7 @@ void dml_core_mode_programming(struct display_mode_=
lib_st *mode_lib, const struc
>
>         // The prefetch scheduling should only be calculated once as per =
AllowForPStateChangeOrStutterInVBlank requirement
>         // If the AllowForPStateChangeOrStutterInVBlank requirement is no=
t strict (i.e. only try those power saving feature
> -       // if possible, then will try to program for the best power savin=
g features in order of diffculty (dram, fclk, stutter)
> +       // if possible, then will try to program for the best power savin=
g features in order of difficulty (dram, fclk, stutter)
>         s->iteration =3D 0;
>         s->MaxTotalRDBandwidth =3D 0;
>         s->AllPrefetchModeTested =3D false;
> @@ -9977,7 +9977,7 @@ void dml_core_get_row_heights(
>         dml_print("DML_DLG: %s: GPUVMMinPageSizeKBytes =3D %u\n", __func_=
_, GPUVMMinPageSizeKBytes);
>  #endif
>
> -       // just suppluy with enough parameters to calculate meta and dte
> +       // just supply with enough parameters to calculate meta and dte
>         CalculateVMAndRowBytes(
>                         0, // dml_bool_t ViewportStationary,
>                         1, // dml_bool_t DCCEnable,
> @@ -10110,7 +10110,7 @@ dml_bool_t dml_mode_support(
>  /// Note: In this function, it is assumed that DCFCLK, SOCCLK freq are t=
he state values, and mode_program will just use the DML calculated DPPCLK a=
nd DISPCLK
>  /// @param mode_lib mode_lib data struct that house all the input/output=
/bbox and calculation values.
>  /// @param state_idx Power state idx chosen
> -/// @param display_cfg Display Congiuration
> +/// @param display_cfg Display Configuration
>  /// @param call_standalone Calling mode_programming without calling mode=
 support.  Some of the "support" struct member will be pre-calculated befor=
e doing mode programming
>  /// TODO: Add clk_cfg input, could be useful for standalone mode
>  dml_bool_t dml_mode_programming(
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/dr=
ivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> index 42c52284a868..355823530aa4 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> @@ -455,7 +455,7 @@ bool dcn30_mmhubbub_warmup(
>         struct mcif_wb *mcif_wb;
>         struct mcif_warmup_params warmup_params =3D {0};
>         unsigned int  i, i_buf;
> -       /*make sure there is no active DWB eanbled */
> +       /* make sure there is no active DWB enabled */
>         for (i =3D 0; i < num_dwb; i++) {
>                 dwb =3D dc->res_pool->dwbc[wb_info[i].dwb_pipe_inst];
>                 if (dwb->dwb_is_efc_transition || dwb->dwb_is_drc) {
> --
> 2.34.1
>

