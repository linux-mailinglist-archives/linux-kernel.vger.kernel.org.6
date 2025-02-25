Return-Path: <linux-kernel+bounces-532277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50887A44AF7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6D6E19E01CB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C20B188736;
	Tue, 25 Feb 2025 18:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/NMttvC"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCA61552E3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740509780; cv=none; b=OLuVwY1MKfipC/ssYemoaJw3/mAe9qHShfsSoOEwmnhBBDKCRdB4TmBhSsxBT0cqpiZCpl4XLQj5Ih42dbQVUXpdTVGvCFSpiQNAZMDdWGJxI/BBzPmIk1G1fchIoXiLH/2Cy6UM/GwVrrTeWpmUOqeNhgetDFA44T7W0kn6s00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740509780; c=relaxed/simple;
	bh=o3FsOm0fTAIzQZQgl8z8uv1ktoiIxqkpUMyGsybUgSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hg8dd6oy5q5kdhd0iv7lKSnJYuCJsfo/WprJkQ9GCdjEsOuo2WjQeZol4vq7SPLowPBhHQywDDDhCwNWIQRaGM242uR2vwkXLIklgtYQg+82DtXeweehFX91/nAsj14cWXQYHJtO2omFIFw2fdwNuDXO77FJC6QBoKUN3kE0PVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/NMttvC; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fc288da33eso1630063a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740509778; x=1741114578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LJYpUID6W4I5EJhScurw/AX4q422xg2nTEM2WBLhuA=;
        b=b/NMttvCd2vUc9R1RTEERgQpyt1Y0U0clQstBNm896NdOWnQXPLjczIjnnh9qFrbNV
         rmz9UmiiBLodRiI71s5bEo8uGcs63ugr34rJC5r22KHzv95V13aeyClT/sgMH3m5BFez
         XszmHa/LOv7tB9xGKJmqcF8oCpPQk9ePa8dEzLXw48TFhh272Fa0Gyt3OrirWfEKpl/A
         MmiuDjXd2Tv+mH7UCjZttJUAxxkACZ+LaKD67KPY5rNYCKon5vPOWzRdbhi9jabatzI5
         5K//8dUdtpAXbEBehQdveBYyabuD7g8LVDivfUu0iOKrBoCHyXlvnnELkdL3b8eRAJAE
         4K8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740509778; x=1741114578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5LJYpUID6W4I5EJhScurw/AX4q422xg2nTEM2WBLhuA=;
        b=Eqh4+juuhXzxwsMo9aBvUYDc7ByEBw+ZAfC0dNHQL1D1OeJWTPOHrPkwRu8dzWP87g
         ijZ4SjEUK81z22oVKbNdI0V997mGF56HBOj7/qwsFbGTemu6ZxE6bUTtc+ndI2yFH0A5
         7qJH7CA9OhEXeRyeOWBOT81PcgnzIea5v5vw0eMCHinyYGFuP2zjyXlbcbr8s0p10llk
         0f2cXVTb1k6vsbcey872spN6yVeT0zuTh1EvaMcUYwlU0EtMbM3pUYwSMIQJ/ELslpMN
         iqi97wTuI0C541zdefb6w/BcJTogNie7HqTibFKj/JVt+HyECi7AdiOsjJSIoKv0JiRY
         esIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXd3DroIprT41at3xureKlu5e/RF9u9oICJvprQ2wWdItuFYyVo6eOTN6tl6EsDnae+HgxM+dToamrHXJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD1YINBzn9xt5qXiBnie0WvOHq1KrCvax93v0c6XN9ifCns04Y
	i91QE3lHPbBWrIhuSsgsVk81bd0riCJPPAxyrcPrQRARVdR0ytXaqL66Bw2Jy2Fk79N9P62OsNe
	qLFsQJVfGzUER3dVfxkkKzx4Uf5w=
X-Gm-Gg: ASbGnctuNWpvWgS4e5psCJjgqGuPk8yjmnMon8VakDS0JfjWCn3gYL1SO3hJyJj/GrO
	UeBfdCQFR+T9AvlNd97bFLvTx7yLQHVGZsnG6UMTZHuk6e6tLlyR+xsojamNg/KHibntDSKQJXi
	I75WZuoKE=
X-Google-Smtp-Source: AGHT+IGkDAct65mknFExr5qSoeMevF/bWfU3G2E8vI3pXH1PsZu7yjosujAuCh+2s6GdpE0tBa1Vyokcv8UkFO7+ROg=
X-Received: by 2002:a17:90b:3e8d:b0:2fa:2011:c85d with SMTP id
 98e67ed59e1d1-2fce7b4f29fmr10629837a91.7.1740509778436; Tue, 25 Feb 2025
 10:56:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224014942.193407-1-linux@treblig.org>
In-Reply-To: <20250224014942.193407-1-linux@treblig.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Feb 2025 13:56:04 -0500
X-Gm-Features: AWEUYZkV-VKShpz06myyPBFccE18IuxpHMzvBHAaolC_sSnG3Qgfe_3AzTFlGo4
Message-ID: <CADnq5_MPXqCucYhh1kSCQVOm0QXT00+Bax9G=S9+vRJ2QLB6Sg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove unused optc3_fpu_set_vrr_m_const
To: linux@treblig.org
Cc: alexander.deucher@amd.com, chaitanya.dhere@amd.com, jun.lei@amd.com, 
	harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, 
	christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com, 
	simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Mon, Feb 24, 2025 at 8:43=E2=80=AFAM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> The last use of optc3_fpu_set_vrr_m_const() was removed in 2022's
> commit 64f991590ff4 ("drm/amd/display: Fix a compilation failure on Power=
PC
> caused by FPU code")
> which removed the only caller (with a similar) name.
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  | 76 -------------------
>  .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.h  |  3 -
>  2 files changed, 79 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drive=
rs/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> index aac0a0ae2966..88789987bdbc 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> @@ -178,82 +178,6 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_0_soc =3D {
>  };
>
>
> -void optc3_fpu_set_vrr_m_const(struct timing_generator *optc,
> -               double vtotal_avg)
> -{
> -       struct optc *optc1 =3D DCN10TG_FROM_TG(optc);
> -       double vtotal_min, vtotal_max;
> -       double ratio, modulo, phase;
> -       uint32_t vblank_start;
> -       uint32_t v_total_mask_value =3D 0;
> -
> -       dc_assert_fp_enabled();
> -
> -       /* Compute VTOTAL_MIN and VTOTAL_MAX, so that
> -        * VOTAL_MAX - VTOTAL_MIN =3D 1
> -        */
> -       v_total_mask_value =3D 16;
> -       vtotal_min =3D dcn_bw_floor(vtotal_avg);
> -       vtotal_max =3D dcn_bw_ceil(vtotal_avg);
> -
> -       /* Check that bottom VBLANK is at least 2 lines tall when running=
 with
> -        * VTOTAL_MIN. Note that VTOTAL registers are defined as 'total n=
umber
> -        * of lines in a frame - 1'.
> -        */
> -       REG_GET(OTG_V_BLANK_START_END, OTG_V_BLANK_START,
> -               &vblank_start);
> -       ASSERT(vtotal_min >=3D vblank_start + 1);
> -
> -       /* Special case where the average frame rate can be achieved
> -        * without using the DTO
> -        */
> -       if (vtotal_min =3D=3D vtotal_max) {
> -               REG_SET(OTG_V_TOTAL, 0, OTG_V_TOTAL, (uint32_t)vtotal_min=
);
> -
> -               optc->funcs->set_vtotal_min_max(optc, 0, 0);
> -               REG_SET(OTG_M_CONST_DTO0, 0, OTG_M_CONST_DTO_PHASE, 0);
> -               REG_SET(OTG_M_CONST_DTO1, 0, OTG_M_CONST_DTO_MODULO, 0);
> -               REG_UPDATE_3(OTG_V_TOTAL_CONTROL,
> -                       OTG_V_TOTAL_MIN_SEL, 0,
> -                       OTG_V_TOTAL_MAX_SEL, 0,
> -                       OTG_SET_V_TOTAL_MIN_MASK_EN, 0);
> -               return;
> -       }
> -
> -       ratio =3D vtotal_max - vtotal_avg;
> -       modulo =3D 65536.0 * 65536.0 - 1.0; /* 2^32 - 1 */
> -       phase =3D ratio * modulo;
> -
> -       /* Special cases where the DTO phase gets rounded to 0 or
> -        * to DTO modulo
> -        */
> -       if (phase <=3D 0 || phase >=3D modulo) {
> -               REG_SET(OTG_V_TOTAL, 0, OTG_V_TOTAL,
> -                       phase <=3D 0 ?
> -                               (uint32_t)vtotal_max : (uint32_t)vtotal_m=
in);
> -               REG_SET(OTG_V_TOTAL_MIN, 0, OTG_V_TOTAL_MIN, 0);
> -               REG_SET(OTG_V_TOTAL_MAX, 0, OTG_V_TOTAL_MAX, 0);
> -               REG_SET(OTG_M_CONST_DTO0, 0, OTG_M_CONST_DTO_PHASE, 0);
> -               REG_SET(OTG_M_CONST_DTO1, 0, OTG_M_CONST_DTO_MODULO, 0);
> -               REG_UPDATE_3(OTG_V_TOTAL_CONTROL,
> -                       OTG_V_TOTAL_MIN_SEL, 0,
> -                       OTG_V_TOTAL_MAX_SEL, 0,
> -                       OTG_SET_V_TOTAL_MIN_MASK_EN, 0);
> -               return;
> -       }
> -       REG_UPDATE_6(OTG_V_TOTAL_CONTROL,
> -               OTG_V_TOTAL_MIN_SEL, 1,
> -               OTG_V_TOTAL_MAX_SEL, 1,
> -               OTG_SET_V_TOTAL_MIN_MASK_EN, 1,
> -               OTG_SET_V_TOTAL_MIN_MASK, v_total_mask_value,
> -               OTG_VTOTAL_MID_REPLACING_MIN_EN, 0,
> -               OTG_VTOTAL_MID_REPLACING_MAX_EN, 0);
> -       REG_SET(OTG_V_TOTAL, 0, OTG_V_TOTAL, (uint32_t)vtotal_min);
> -       optc->funcs->set_vtotal_min_max(optc, vtotal_min, vtotal_max);
> -       REG_SET(OTG_M_CONST_DTO0, 0, OTG_M_CONST_DTO_PHASE, (uint32_t)pha=
se);
> -       REG_SET(OTG_M_CONST_DTO1, 0, OTG_M_CONST_DTO_MODULO, (uint32_t)mo=
dulo);
> -}
> -
>  void dcn30_fpu_populate_dml_writeback_from_context(
>                 struct dc *dc, struct resource_context *res_ctx, display_=
e2e_pipe_params_st *pipes)
>  {
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h b/drive=
rs/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h
> index cab864095ce7..e3b6ad6a8784 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h
> @@ -29,9 +29,6 @@
>  #include "core_types.h"
>  #include "dcn20/dcn20_optc.h"
>
> -void optc3_fpu_set_vrr_m_const(struct timing_generator *optc,
> -               double vtotal_avg);
> -
>  void dcn30_fpu_populate_dml_writeback_from_context(
>                 struct dc *dc, struct resource_context *res_ctx, display_=
e2e_pipe_params_st *pipes);
>
> --
> 2.48.1
>

