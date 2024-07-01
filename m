Return-Path: <linux-kernel+bounces-236905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 054C591E872
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D271F25285
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5332D16F278;
	Mon,  1 Jul 2024 19:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URjtsM50"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B2B15DBD6
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 19:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719861583; cv=none; b=XA2novjT4s4OMkiC3VhdGFOrh2muwoP07hnR5J3SxM05OUz1vwnQ6ZfaDuBlBWD8I42vX2Xtkbh7qYJ5v+KwICO+3BhMQswmLVRIBT37yaNxEZbj8S6s0bX9jctA7qccZ+kr2I2oIHOs8eQF5uzJuRfSbzIR6CeIX/yAUSOi91E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719861583; c=relaxed/simple;
	bh=pckBVQAzVr8cwtuEZw0i7PNYij6s4gjYYxqZSfZ98lY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OvO7Mj0GjGmEutndg8o0Nh+GXMNEn/At0PChCycSFnHUFrorvsWtYrwD/tbHUrUVsBq7J+M/iHO00gzQqHDnv+bs/5xndJFMuQe2qauFbz97651gCJj70YYKU78aPU63cCkoxtlSSeXZU5AI1glXxp4aC94Q5hod/v+q5YYfmXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URjtsM50; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c7fa0c9a8cso1938365a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 12:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719861581; x=1720466381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7dX91rR++X8l6FgAb2IdZ2jTpqGOU3hxaiyihnGxWg=;
        b=URjtsM50BdIbrleahVegrzo+bCX6UBLdj5eOelrAZn9Fo2BGiMlGySwZbcMlyjk+LA
         cEwGY9FXQUn5SkBW7tiSByznnVvc5bT5dH5BSLGFYMndL2ROV5sWMdjIU/JdNx1Oku/W
         rjNEu3Z07iVfaqjzKOYt9YOwWVESod+ukC5Ox5hOdRn6cCZALzo272J1JCoAdJ8S97be
         giitv4DZFSLa5hBKZaJKp/zS/RjA0MOqGtyCUUk7m+YxwDXEK38jmdPALIiCQCYMeti9
         3yQblNcwQLu57Ks666qw+mz3yuvXOpjxCsD27gThV4j0v64UgSZ2w2694hhFsf3FfC7x
         z4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719861581; x=1720466381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7dX91rR++X8l6FgAb2IdZ2jTpqGOU3hxaiyihnGxWg=;
        b=uX6bXv/3AdlCe0nKvrE/+v69zdtTAga6zGwEl/wjV6kY+AupkRhAifQzeHuRm6K13V
         rkXLEi/GEOEDWC8dyg7rx+LlsZfLM9m5+f4XzkraIZOWCOCEMNFpFSfvD8j2px46oyD0
         pH9YWDhou0uD0a0Nnld1rR32NxlhEUUpJYuzmvM4ROMzS1+lpyy9PlIcDPVE9IlQU6Pa
         p4RupFehdjFHnixXErKCaGV0O6brZ3SFvRrqDOqu8/SPWuoC5MJGswgF2ovPry24RgXf
         ph4AgJC3TUYyr9nETMGSrqgy8oSD3UhQIrzbYWZelf6vR52bieis6W2V0gAcYfhokOEq
         hRlg==
X-Forwarded-Encrypted: i=1; AJvYcCWH1/NGQNp1TW27EsQDr1uKPKtsWbPeLCNGwN56m/5N/LWjuuxOIkzk3KAjoO5hyp3fA4dfia/56ijPQNohITx1dc0vhgBu6E6rqOcd
X-Gm-Message-State: AOJu0YwevxI44UJkZo8syOWq7UHXZiAd1DsYXrbpXNAokilTXBdN1l7r
	e0q2e3N3/1wOeCANI4+6Iyu3J9unXJ7UJ+zhgCE3BKaqO4Vr9n15h/5uc4HE/+cwN8mhv9Pan00
	P2vChm61Xtzh6wa7+WreX5IIMeQ4=
X-Google-Smtp-Source: AGHT+IG5+yZI4SRXCP1ZRSO57iNkvyORgQdxHHwZ6QNuY1DRKJ4lk+z/+oxiPHPCnZXrnlpXT/gQVlhMBabT1lU/5O4=
X-Received: by 2002:a17:90b:e0f:b0:2c8:a8f:45fa with SMTP id
 98e67ed59e1d1-2c93d6c650cmr3631105a91.2.1719861581296; Mon, 01 Jul 2024
 12:19:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701025028.36072-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20240701025028.36072-1-jiapeng.chong@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 1 Jul 2024 15:19:29 -0400
Message-ID: <CADnq5_N3wS=dbg5cfjKdqnU+JmCw80Evat_3-H_RJ3Aus7CfyA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix unsigned comparison with less than zero
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Sun, Jun 30, 2024 at 11:10=E2=80=AFPM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> The return value from the call to dml21_find_dc_pipes_for_plane() is int.
> However, the return value is being assigned to an unsigned int variable
> 'num_pipes', the condition if(num_pipes <=3D 0) is not rigorous enough,
> so making 'num_pipes' an int.
>
> ./drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c:318:6-15: WAR=
NING: Unsigned expression compared with zero: num_pipes <=3D 0.
> ./drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c:360:6-15: WAR=
NING: Unsigned expression compared with zero: num_pipes <=3D 0.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D9454
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  .../drm/amd/display/dc/dml2/dml21/dml21_wrapper.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c b/=
drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
> index c310354cd5fc..9d96a31419fa 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
> @@ -280,7 +280,8 @@ bool dml21_validate(const struct dc *in_dc, struct dc=
_state *context, struct dml
>
>  void dml21_prepare_mcache_programming(struct dc *in_dc, struct dc_state =
*context, struct dml2_context *dml_ctx)
>  {
> -       unsigned int num_pipes, dml_prog_idx, dml_phantom_prog_idx, dc_pi=
pe_index;
> +       unsigned int dml_prog_idx, dml_phantom_prog_idx, dc_pipe_index;
> +       int num_pipes;
>         struct pipe_ctx *dc_main_pipes[__DML2_WRAPPER_MAX_STREAMS_PLANES_=
_];
>         struct pipe_ctx *dc_phantom_pipes[__DML2_WRAPPER_MAX_STREAMS_PLAN=
ES__] =3D {0};
>
> @@ -314,10 +315,8 @@ void dml21_prepare_mcache_programming(struct dc *in_=
dc, struct dc_state *context
>                 }
>
>                 num_pipes =3D dml21_find_dc_pipes_for_plane(in_dc, contex=
t, dml_ctx, dc_main_pipes, dc_phantom_pipes, dml_prog_idx);
> -
> -               if (num_pipes <=3D 0 ||
> -                               dc_main_pipes[0]->stream =3D=3D NULL ||
> -                               dc_main_pipes[0]->plane_state =3D=3D NULL=
)
> +               if (num_pipes <=3D 0 || dc_main_pipes[0]->stream =3D=3D N=
ULL ||
> +                   dc_main_pipes[0]->plane_state =3D=3D NULL)
>                         continue;
>
>                 /* get config for each pipe */
> @@ -356,10 +355,8 @@ void dml21_prepare_mcache_programming(struct dc *in_=
dc, struct dc_state *context
>                 pln_prog =3D &dml_ctx->v21.mode_programming.programming->=
plane_programming[dml_prog_idx];
>
>                 num_pipes =3D dml21_find_dc_pipes_for_plane(in_dc, contex=
t, dml_ctx, dc_main_pipes, dc_phantom_pipes, dml_prog_idx);
> -
> -               if (num_pipes <=3D 0 ||
> -                               dc_main_pipes[0]->stream =3D=3D NULL ||
> -                               dc_main_pipes[0]->plane_state =3D=3D NULL=
)
> +               if (num_pipes <=3D 0 || dc_main_pipes[0]->stream =3D=3D N=
ULL ||
> +                   dc_main_pipes[0]->plane_state =3D=3D NULL)
>                         continue;
>
>                 /* get config for each pipe */
> --
> 2.20.1.7.g153144c
>

