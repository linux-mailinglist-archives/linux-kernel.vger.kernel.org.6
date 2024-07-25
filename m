Return-Path: <linux-kernel+bounces-262592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDD893C923
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 21:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F37283E50
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363F44D8CB;
	Thu, 25 Jul 2024 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqpyNEws"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4E01876
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721937010; cv=none; b=CmXS6k9g+8j68zFe+jvJTS8yGK3YDaEynJ2b1E8KT6TMW7BFRxgovMCdcpOLIlFkCnScqu7a6s2JHP66Co1Ip0cBGFkeBDUPI7yxIbSjJleeEt9MAB8lBTBJ2turjtzF7pm/MedNA5jkkQaFFUKUUikVXvegszgLv4rnIfxQpfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721937010; c=relaxed/simple;
	bh=R4VGT4D19pNcwKck/6HwwlG+htaH3no7/Rl2nb/fSxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hX0d3WH31xL3jkNKEYnv6DfC5/Hvcomd0p+xb49uTpkZEEImqDdMDR0IGfYlfI45IxnHi3pIa9xwu9tPTXPwoIjBPVYIuB5RAVBcJnKUq5Eq0+O/KzZ754sBcfc9MBfVeBOavMw3wO7f4OhJu0AGeWmquv/8tJxMQpHH45UBpgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqpyNEws; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7a0c6ab3354so226651a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 12:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721937008; x=1722541808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VSUodCp0iyrPyR9RoEZrdu/UPubf2TKzJKuqkmoXBY=;
        b=JqpyNEwsgoa1e+eHZh+WQ4dHZNj6JsgJ9SGWyiIkYBsBv8qAmOlFXBlmsMkcuIJYk5
         NkH8MSEbjUKjCBtse7jnbDTmXBB4Vk+18oC65g0YagXmDvKy6MQByz06TkhLq5hszCK0
         LH9s3/kIZKknXew228UgZWfODAYOu7sqjc1qcw6gudT57VeBZonjxIp2CknyJ1MYZfOQ
         nG5jK9k4rALMaivCbIN27xfC/0E2HoFyr0A8ua6baHzV1Lj5h3Bt2TBoWPEq6KCFdmqR
         mDS6p6IXBWiaDT8Hr/eBUpie4x4xqXJfk2m7XFXFUDVRk4qyF2xXV/I5x7rdBkgVphWY
         XEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721937008; x=1722541808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VSUodCp0iyrPyR9RoEZrdu/UPubf2TKzJKuqkmoXBY=;
        b=A7vrPIFRioI9eodjxoGYipeuIbK5fekt9OzUffQQtYM1TH59DA2bHN+3cFKyW6vp3A
         /TGpvp7XzREjUjPDtyYbJrmO4g7jgLGpuUJZ8/R+xh93XQEc+NvlesWQGJ6CW09eBDlG
         c4bXu4XxPu0IjH9aWGNZfsiFKUIhzeLgbEc/aWdTEB0jZSG6O4nIQ9cgzQTtIx/7m2Ur
         Iok8r+wv8AF9MHDZRTB9QQ1F9hKeCb1a8ABQKabkPDQ0NS9fe+CjcbxuZYjd44gx6xrM
         p1BBDD6aViqmpUtsNAelEBpvlJkLNIrWUgiF78AKTTR8Ae/1f238LV1MfFehT/gShe3e
         diZA==
X-Forwarded-Encrypted: i=1; AJvYcCUmSUUDHoS4PIR/V+AwXHbkwVTDvNVO9J8zmeXFhmajeQAf9M9EnY2ef1mJ+K7b4L/B9PvLR6wnxEjEzespcNTMwhrKhYjRZUKEviFW
X-Gm-Message-State: AOJu0YwKavvfuPE0Rhre6F0kHUI5lS7W5x8j+MwZE6e/TQuaAD49fqkw
	/kMs/XE0o37ldnzqluLklR7M7F1sIdenfZRmE0FGX/HIynIrR4i3+7IinFAuBM/xLO4aX5XDDx5
	tbPoTLCrrwbOQyzvaju0OEOmU/ko=
X-Google-Smtp-Source: AGHT+IHgrjq7amGcLdexxOnkH/4BLZ1r74+ivIwi5/7IOAGm0XWiiMDVklCFBl5hy5edRCK2xCjHv4+HekMm+tQmBvM=
X-Received: by 2002:a17:902:e550:b0:1fc:4763:445c with SMTP id
 d9443c01a7336-1fed92752c3mr33830085ad.32.1721937008312; Thu, 25 Jul 2024
 12:50:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725015712.50237-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20240725015712.50237-1-jiapeng.chong@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Jul 2024 15:49:55 -0400
Message-ID: <CADnq5_NkOR12Dxcpo6wZe4Act3-4JSoF=oC37464XfwVSqnrqA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: remove unneeded semicolon
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Wed, Jul 24, 2024 at 10:35=E2=80=AFPM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> No functional modification involved.
>
> ./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_=
calcs.c:481:2-3: Unneeded semicolon.
> ./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_=
calcs.c:3783:168-169: Unneeded semicolon.
> ./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_=
calcs.c:3782:166-167: Unneeded semicolon.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D9575
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  .../dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c      | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2=
_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_cor=
e/dml2_core_dcn4_calcs.c
> index 0b671c665373..e4a14d41fb85 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_d=
cn4_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_d=
cn4_calcs.c
> @@ -478,7 +478,7 @@ static unsigned int dml_get_tile_block_size_bytes(enu=
m dml2_swizzle_mode sw_mode
>         default:
>                 DML2_ASSERT(0);
>                 return 256;
> -       };
> +       }
>  }
>
>  static bool dml_is_vertical_rotation(enum dml2_rotation_angle Scan)
> @@ -3779,8 +3779,8 @@ static void CalculateSwathAndDETConfiguration(struc=
t dml2_core_internal_scratch
>                         p->SwathHeightC[k] =3D MaximumSwathHeightC[k] / 2=
;
>                         RoundedUpSwathSizeBytesY[k] =3D p->full_swath_byt=
es_l[k] / 2;
>                         RoundedUpSwathSizeBytesC[k] =3D p->full_swath_byt=
es_c[k] / 2;
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
> --
> 2.32.0.3.g01195cf9f
>

