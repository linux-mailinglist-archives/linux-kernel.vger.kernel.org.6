Return-Path: <linux-kernel+bounces-194296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0FB8D39A5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22A58B24942
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D7F15A861;
	Wed, 29 May 2024 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d35mEair"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F11C79DC
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716994001; cv=none; b=AVLhIBXn1ts1wGbtXCzcj6DtvzuedJM6Clw1CT0SeV1ir7zrbt+SL1i0yoocfKvqHhQ/W8I1pq6a0cwZFJXGvPAftd04PiSIfxroXulVVDyU4S3JabGa/sqpbYYEAVW6Zj09/x+L0fzfWnP1o5jLrBzDwMoC0H+vdWlGy6gPN6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716994001; c=relaxed/simple;
	bh=S2XYz5b0N/Y9h2Cc2CdEvH/yAKGdPfLmjj5e1nJ2VWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fDBrbwy2WTbEv0X+iJ6MRBY5Nlt3mXBuiXSuox2W7/3QFF8Q3oV2q2/Qyssv7NHNjIkkr29fGItFGnnFnQd3n6bnWyTng6nJjrZt2QFAA856dEjnoroQsmQet8EfGGsdv71Sd1l4QhlFlS2TbO7onLfz9As5W4BmSJ42ync4LTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d35mEair; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6bec8c86b48so73618a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 07:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716993999; x=1717598799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvVzHd5AxSKnApKESDyHK3nerTyOYWeW+tQfkc76wG0=;
        b=d35mEairzd2mVHclJARm0I7KYGnvonv6GLsraMJC9ovgiYtDzzIQk318m/19Y0wZT8
         Bh+YViBg1j+QJAk6tSCVKePkvDgpV0Yk+c3gsDaiFbOYwImS7aY5FcZHMuvI1+es9NVr
         QTv/ivPYWm7yS3lM8jIADkOK4iX/00Wmn/R/uzLuYWEU5wvdsuzBYV6FmBCFz7G28iXw
         YzHvtqI8AO5iuUsh1pHQqwZNhDLHB17KYYbTSNtcBv4OfkuArGcK47p0ngloMEbdteWy
         OWftXaP167GlQFAGucqcVDjntcXBZoBGCbjvl1QjA3OizhsSdvXyv1QymrwEbOwtBfOg
         FTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716993999; x=1717598799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvVzHd5AxSKnApKESDyHK3nerTyOYWeW+tQfkc76wG0=;
        b=b9lna5augEjMP0g3udMjI8gB2vj5hQJ0YfcdpStLCTTe2KCwsmWTvbjLB//iSJFBLn
         Mz/TyKqbVSm61hf968GsC84M+bnVH2LjL0IZWAkEegGL/IQe7bC1b33C50MOg5iKlFM1
         YAa9eAoblmy9VYXC9fsL2WMQLPAr+PwjD+Ut1CRAR0ZLVTIX5JRuY8YrvFFBwxK8HUlx
         /dYwIqMxVcDIP7Q1KBKA1rMEWRoFrU/akSajjZUNgBcZocA0tLIeaCM3Lw47MiB7zGhu
         rFaRXmWt+iU7GLv+/iq8cdF8AzXdTfFP4yTdttf/UtP72qJUOArXeKYazku4KrbDv6Is
         0xuA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ72GmH/4ZqLtxIqtujEO7A4T2C8YbeDE3+IEjqAmbHAQ6JAG5dL39VROeAti4QKDgWRv/aNjC59QjXqHb5BwlQ0qRy+lCEIP0C01R
X-Gm-Message-State: AOJu0YxnFqHeIim2os/iUMKSKT+0xHNklNO5Bu/slcDuKXDblHJ2BlVT
	/CP5KcYHDOBlYM5JTdZzo8b238FLeOeEHJWiMOF9CefuXN4YOFWpKj9XuZaLFaD6LLS+wZbrrs8
	pEqwG9DoRp+pgtBEAD2WUpnYplR0=
X-Google-Smtp-Source: AGHT+IHB40gqF5o5YJJk218HRfK46Q5oKExKxc9X5bl9vAXS05a8NVPXgx8Ecwt6Mp58v7Qb3PXOwkGnAsNDaWJCJz8=
X-Received: by 2002:a17:90b:400a:b0:2bd:5c9c:b080 with SMTP id
 98e67ed59e1d1-2bf5ed1e3b6mr16295128a91.12.1716993998803; Wed, 29 May 2024
 07:46:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528115146.2870032-1-arnd@kernel.org>
In-Reply-To: <20240528115146.2870032-1-arnd@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 May 2024 10:46:27 -0400
Message-ID: <CADnq5_OtL0D+mE8bsoWmPz0e7USC=UrpFjcZZ2LTeaHePToBxQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] [RESEND] drm/amd/display: dynamically allocate
 dml2_configuration_options structures
To: Arnd Bergmann <arnd@kernel.org>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Wenjing Liu <wenjing.liu@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Jun Lei <jun.lei@amd.com>, 
	Hamza Mahfooz <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, 
	Dillon Varone <dillon.varone@amd.com>, Qingqing Zhuo <Qingqing.Zhuo@amd.com>, 
	Roman Li <roman.li@amd.com>, Aric Cyr <aric.cyr@amd.com>, 
	Joshua Aberback <joshua.aberback@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied the series.  Thanks!

Alex

On Tue, May 28, 2024 at 7:52=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> This structure is too large to fit on a stack, as shown by the
> newly introduced warnings from a recent code change:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn32/dcn32_resource.c:=
 In function 'dcn32_update_bw_bounding_box':
> drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn32/dcn32_resource.c:=
2019:1: error: the frame size of 1180 bytes is larger than 1024 bytes [-Wer=
ror=3Dframe-larger-than=3D]
> drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn321/dcn321_resource.=
c: In function 'dcn321_update_bw_bounding_box':
> drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn321/dcn321_resource.=
c:1597:1: error: the frame size of 1180 bytes is larger than 1024 bytes [-W=
error=3Dframe-larger-than=3D]
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_state.c: In function 'dc=
_state_create':
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_state.c:219:1: error: th=
e frame size of 1184 bytes is larger than 1024 bytes [-Werror=3Dframe-large=
r-than=3D]
>
> Instead of open-coding the assignment of a large structure to a stack
> variable, use an explicit kmemdup() in each case to move it off the stack=
.
>
> Fixes: e779f4587f61 ("drm/amd/display: Add handling for DC power mode")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Originally sent as https://lore.kernel.org/all/20240418083421.3956461-1-a=
rnd@kernel.org/
> ---
>  .../display/dc/resource/dcn32/dcn32_resource.c   | 16 +++++++++++-----
>  .../display/dc/resource/dcn321/dcn321_resource.c | 16 +++++++++++-----
>  2 files changed, 22 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource=
c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> index 022d320be1d5..0f11d7c8791c 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> @@ -2007,21 +2007,27 @@ void dcn32_calculate_wm_and_dlg(struct dc *dc, st=
ruct dc_state *context,
>
>  static void dcn32_update_bw_bounding_box(struct dc *dc, struct clk_bw_pa=
rams *bw_params)
>  {
> -       struct dml2_configuration_options dml2_opt =3D dc->dml2_options;
> +       struct dml2_configuration_options *dml2_opt;
> +
> +       dml2_opt =3D kmemdup(&dc->dml2_options, sizeof(dc->dml2_options),=
 GFP_KERNEL);
> +       if (!dml2_opt)
> +               return;
>
>         DC_FP_START();
>
>         dcn32_update_bw_bounding_box_fpu(dc, bw_params);
>
> -       dml2_opt.use_clock_dc_limits =3D false;
> +       dml2_opt->use_clock_dc_limits =3D false;
>         if (dc->debug.using_dml2 && dc->current_state && dc->current_stat=
e->bw_ctx.dml2)
> -               dml2_reinit(dc, &dml2_opt, &dc->current_state->bw_ctx.dml=
2);
> +               dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2=
);
>
> -       dml2_opt.use_clock_dc_limits =3D true;
> +       dml2_opt->use_clock_dc_limits =3D true;
>         if (dc->debug.using_dml2 && dc->current_state && dc->current_stat=
e->bw_ctx.dml2_dc_power_source)
> -               dml2_reinit(dc, &dml2_opt, &dc->current_state->bw_ctx.dml=
2_dc_power_source);
> +               dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2=
_dc_power_source);
>
>         DC_FP_END();
> +
> +       kfree(dml2_opt);
>  }
>
>  static struct resource_funcs dcn32_res_pool_funcs =3D {
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> index e4b360d89b3b..07ca6f58447d 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> @@ -1581,21 +1581,27 @@ static struct dc_cap_funcs cap_funcs =3D {
>
>  static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_p=
arams *bw_params)
>  {
> -       struct dml2_configuration_options dml2_opt =3D dc->dml2_options;
> +       struct dml2_configuration_options *dml2_opt;
> +
> +       dml2_opt =3D kmemdup(&dc->dml2_options, sizeof(dc->dml2_options),=
 GFP_KERNEL);
> +       if (!dml2_opt)
> +               return;
>
>         DC_FP_START();
>
>         dcn321_update_bw_bounding_box_fpu(dc, bw_params);
>
> -       dml2_opt.use_clock_dc_limits =3D false;
> +       dml2_opt->use_clock_dc_limits =3D false;
>         if (dc->debug.using_dml2 && dc->current_state && dc->current_stat=
e->bw_ctx.dml2)
> -               dml2_reinit(dc, &dml2_opt, &dc->current_state->bw_ctx.dml=
2);
> +               dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2=
);
>
> -       dml2_opt.use_clock_dc_limits =3D true;
> +       dml2_opt->use_clock_dc_limits =3D true;
>         if (dc->debug.using_dml2 && dc->current_state && dc->current_stat=
e->bw_ctx.dml2_dc_power_source)
> -               dml2_reinit(dc, &dml2_opt, &dc->current_state->bw_ctx.dml=
2_dc_power_source);
> +               dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2=
_dc_power_source);
>
>         DC_FP_END();
> +
> +       kfree(dml2_opt);
>  }
>
>  static struct resource_funcs dcn321_res_pool_funcs =3D {
> --
> 2.39.2
>

