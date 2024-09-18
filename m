Return-Path: <linux-kernel+bounces-332716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E7597BD99
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 875451C209E4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4215E18A6CD;
	Wed, 18 Sep 2024 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sg62eVdc"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485B9176230
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668217; cv=none; b=O5eEGQXXl2X8Jjq+FmcH3g3XKApBkFflszitWeWqqHBrsUcXz/UYFAYQtl9ILhAp0pDSHsnR2qx/7OREJ5EeFkl5h/afR6GqPPDwQJAff1rmiVSX9BYGs3X0AcE6jtfF5FATm+VPjEXBrul38+QnExCvu4338FF8JySzM1U+Koc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668217; c=relaxed/simple;
	bh=ev0JKR+Ki+wZ1gWeV2zx+R894flbiGpCVAZDVgS9PqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ny4lxMwBUl5cUbAHOUeFmAqmWrOLx/SXP4HQWlmnyJ6FNdrM4NrWHXrSOxZZERPID/LTFgelRxH2aaVil4sdUQbbNCGCVKTvmzU9tAQlzHj/+7Q9V0AN95izbxCNOA6Un5UabhuNIGOwdkzWDMgd2gfA5iUTDspkYZJySZOF9Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sg62eVdc; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-718e55bca81so614662b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 07:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726668215; x=1727273015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWbJgztcoceFfFThLVY5wbXfQyLhn8o8Q6POCrLxBDM=;
        b=Sg62eVdcP1U6tbHdRipUazkrqNt/3TKVTybU5Zpd1LHJNhQ287h/88DzYzFQBjvAG1
         Nw2t46+JPl4v3scQXeYyZTyZD/3+amU54oTZC0ds5oJ1otyPiuWui+1u9RG9CMNf2W14
         zq6gaQUOM/C2tVRzgY4KHHVMx97LdJapg8RCOgQisBttNiqlC2DHti9o8V652ynPGafe
         1dMwXrECefThqU/qbwzXosunFLFQ1zIeX4L1mj46LxKLJXexSjitzu8GtqtgETAasAk3
         C4Qb7F45U7KCom4E2HEC4Q2+YhXyeLP8MS9lUU5/bN09varyWJgZx3Ui8NH7vikdAj6z
         xwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726668215; x=1727273015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWbJgztcoceFfFThLVY5wbXfQyLhn8o8Q6POCrLxBDM=;
        b=Id5ywVKA3lbwPVO9L6KnRFVDyHmLQfQmoBX+/dBQu9AszqXW3mQJ0vRV+zTDSRGWhA
         3EGPZyqdAmZ/DRay3j/7FjDDwZtnidnlFF+dulAXybYunobdxNMocS8abjIzXUKTsq/p
         FClPt8kFMgw1Fu3cvNjKgGJtOP7Ud43SlCtITUV4UVUmfVzaip59xv1EiLGkiuQQ2aQe
         nVpiQd6ZbrXuPhUNaL7tkpHH5s4M1Mr2mqaWRLMOXwqLaAC9lod+UrEQ/YxG0PV38cUr
         3MHBiDH1g+HVbzX/Zrg1ZSZoVy1wV6ctm8KZAlCMv9gyauM23NNhDz/DsONZ99hQB/1f
         WHdQ==
X-Forwarded-Encrypted: i=1; AJvYcCULCoGz8z2Q5RyydXtNSsRowVM8ITtqc5fH3VY0vD4ErTRnCGQlmCY1f77II29akgfng4Q+9WPSmIWvFhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTUoakTVLE7enEvj0YAuVHinnhhW2UTUfk0r4ZV+6T5cSaWEJC
	1X+lfuzNZJ7l8K2AXIml5JFvuxI8xklVetVpTGrAV0TdUKvPclrrxP0CDw2IvC3qxCSqRQgD8lm
	Afjapwu+hHKbdQCJGoguRx29/eyQ=
X-Google-Smtp-Source: AGHT+IHDEMiQCcUgd0quuVe6+gHogtqzPU+y9sOiiTdAPQGGpUctqLcMyAdRZYLEQDqTWWmP+4jGGqEYoYG6oIHKK6k=
X-Received: by 2002:a05:6a00:1256:b0:70d:2289:4c55 with SMTP id
 d2e1a72fcca58-7192633889cmr13505341b3a.5.1726668215320; Wed, 18 Sep 2024
 07:03:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917163119.890276-1-roheetchavan@gmail.com>
In-Reply-To: <20240917163119.890276-1-roheetchavan@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 18 Sep 2024 10:03:21 -0400
Message-ID: <CADnq5_MXmSYf0=Lfb5-bsmuK6m2UEgyeVOMp4hjZcpxU82_Z2A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix unnecessary cast warnings from checkpatch
To: Rohit Chavan <roheetchavan@gmail.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher@amd.com>

Applied.

Thanks!

On Tue, Sep 17, 2024 at 5:58=E2=80=AFPM Rohit Chavan <roheetchavan@gmail.co=
m> wrote:
>
> This patch addresses warnings produced by the checkpatch script
> related to unnecessary casts that could potentially hide bugs.
>
> The specific warnings are as follows:
> - Warning at drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c:16
> - Warning at drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c:20
> - Warning at drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c:30
>
> Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c b/=
drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
> index 41ecf00ed196..3ab401729f9b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
> @@ -13,11 +13,11 @@
>
>  static bool dml21_allocate_memory(struct dml2_context **dml_ctx)
>  {
> -       *dml_ctx =3D (struct dml2_context *)kzalloc(sizeof(struct dml2_co=
ntext), GFP_KERNEL);
> +       *dml_ctx =3D kzalloc(sizeof(struct dml2_context), GFP_KERNEL);
>         if (!(*dml_ctx))
>                 return false;
>
> -       (*dml_ctx)->v21.dml_init.dml2_instance =3D (struct dml2_instance =
*)kzalloc(sizeof(struct dml2_instance), GFP_KERNEL);
> +       (*dml_ctx)->v21.dml_init.dml2_instance =3D kzalloc(sizeof(struct =
dml2_instance), GFP_KERNEL);
>         if (!((*dml_ctx)->v21.dml_init.dml2_instance))
>                 return false;
>
> @@ -27,7 +27,7 @@ static bool dml21_allocate_memory(struct dml2_context *=
*dml_ctx)
>         (*dml_ctx)->v21.mode_support.display_config =3D &(*dml_ctx)->v21.=
display_config;
>         (*dml_ctx)->v21.mode_programming.display_config =3D (*dml_ctx)->v=
21.mode_support.display_config;
>
> -       (*dml_ctx)->v21.mode_programming.programming =3D (struct dml2_dis=
play_cfg_programming *)kzalloc(sizeof(struct dml2_display_cfg_programming),=
 GFP_KERNEL);
> +       (*dml_ctx)->v21.mode_programming.programming =3D kzalloc(sizeof(s=
truct dml2_display_cfg_programming), GFP_KERNEL);
>         if (!((*dml_ctx)->v21.mode_programming.programming))
>                 return false;
>
> --
> 2.34.1
>

