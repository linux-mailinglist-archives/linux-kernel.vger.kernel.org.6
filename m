Return-Path: <linux-kernel+bounces-275350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B85B89483C4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 22:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E870B22857
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB68816BE32;
	Mon,  5 Aug 2024 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajw9bP4p"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B49C14AD30;
	Mon,  5 Aug 2024 20:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722891388; cv=none; b=ds34CPYA3b1oMicX7Zi613djVcfiEzwE7HDRGrJXpkKpvvYu9kPTVXHbYCOoQFUWRCRbyrGe4EcSot5M99P5KdKsDxcWNdGWe8iJMH3vuWZnlAug933/nzXaePGjATj/2Oun9pis9o9GPBt3aaSQHsbtw8zcpOZz2T2wMLn55ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722891388; c=relaxed/simple;
	bh=AaYXg8/2JDOnLHeVXstBJfExwJcUkxzmzeODXg8nuy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZ7w/MsBsZ6TImQFNVbfR2Oyt/k319Hg2xCEFcJpyaIIIPXD7VHBH73MNBxLLkzWdrpXw/0bm8pxCUtp0lxzAiDFn7BMjtP6Le5PYDrmNVA/6BF+7RjnmNYu10eskvZG+PIL3cNkYVudnT3G9nHJ6gZpWQGDS9oKq0h0gol5baQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajw9bP4p; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70d1cbbeeaeso7623080b3a.0;
        Mon, 05 Aug 2024 13:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722891387; x=1723496187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zps7GFsPk6v3LICq084Feq4cUqxiv2Dwwm6SIzfyvM=;
        b=ajw9bP4p7Z7Ju5ZHldNU0MX+D4Qzvi12d6dy4O6/wvl+Lvgd19VhyRz2TluycG9eyL
         5jsb75n7q2Gvbx2btiGzHw/IepeRi6GS8lu89WxGP4qxz2drwHc5xiKeWH2HG+shFRck
         F0zNJPSNB1iHnpHmCEDw10Tzr5tv4fSWwJqjDICjRFsohzWxZf+HYQuZXmfslMf5IiXp
         NGa4RbpfmphV2Vta+Dv3L+NtKMkJZLSxW2jBLIwUrLKTmrJockLEbsPGzXEP/ge++TTx
         soRlxk2ZV40kOjWPESlm2MHWvvA1JPWFB/0ty6Arxt4+RUyETExGZRZw5qAerfJ1S3sW
         yf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722891387; x=1723496187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zps7GFsPk6v3LICq084Feq4cUqxiv2Dwwm6SIzfyvM=;
        b=sLrmiBx3BnhiypGrmLM0Tv0PF/3V4gLzrsUD6sDTpLsP6nYDYU1FiXQSFu2nD5evvI
         JcQS4G8gYA//iJJkjZycrOmJtUP4tIkLbq6y0hJtuTX2LC9z/qEX+YULPs5fnMM0eDz+
         tJQeDo7xzAtbQgw6SgrGPv2Ra+iNQtL0wc890nHT3LoVYlGW2UIfH0uLUldPE8iLPSNi
         Xr0z8rGPlAK2drzAgfkyn6jWHaFiCWjgCZXYB0S+8l48TjFReU12wtEXy/LA+yISvelW
         zb6ismOAFbMZmH5bvgjl9NNeHC6tSBM8la9uXjicHkMESsjSJQSU1eHgT0dZ1XBonuEB
         bGCA==
X-Forwarded-Encrypted: i=1; AJvYcCU8a5WZtk/WJ3asHkZ56ChrAnTwc+g9M9YWj/1okEBFqWNFwlWf72E8nMNXtw1WVZ9u/j1XQ5cqwZoCs4aG@vger.kernel.org, AJvYcCWl/jJMWP4v46ti0SK1AOf7lIKNz59M9fQVVOrPGwMtsYCoO2enH2qA6+apAQjBCarhrck+SBVoqe9H1/MFDmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlGC0elZlGLjx+ut4+5xuaIan2LmuOcaZTWXF5WIqSh9tDrM1B
	8kCtJ0AwPCm5BsnYi8WUCOeUeit+huwO+msJMPu4LSpz2XYIk6vDAGGRZV4AzcLnISu0oWcUD2v
	ChoyujJE4pM0W2BNAz86K2iBV83I=
X-Google-Smtp-Source: AGHT+IFygedKrccRzQ249fvxaiX09MI78DbeR6+nvbdpDPownt8LElhPJvJc8lssc8mUsZ3Uop8gA2HzGxUxwbL7zaw=
X-Received: by 2002:a05:6a00:ccb:b0:705:c029:c993 with SMTP id
 d2e1a72fcca58-7106cfcd2fcmr12248847b3a.14.1722891386536; Mon, 05 Aug 2024
 13:56:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ae4d951d022e6c34b87ae46e15f1522f8d6d3480.1722355024.git.geert+renesas@glider.be>
In-Reply-To: <ae4d951d022e6c34b87ae46e15f1522f8d6d3480.1722355024.git.geert+renesas@glider.be>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 5 Aug 2024 16:56:13 -0400
Message-ID: <CADnq5_Ng1pLTYaP9k5jY1Cka=PfR9xhBzs0xWG+hK-CKO3cH1w@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon/r100: Handle unknown family in r100_cp_init_microcode()
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Chris Down <chris@chrisdown.name>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Tue, Jul 30, 2024 at 12:05=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> With -Werror:
>
>     In function =E2=80=98r100_cp_init_microcode=E2=80=99,
>         inlined from =E2=80=98r100_cp_init=E2=80=99 at drivers/gpu/drm/ra=
deon/r100.c:1136:7:
>     include/linux/printk.h:465:44: error: =E2=80=98%s=E2=80=99 directive =
argument is null [-Werror=3Dformat-overflow=3D]
>       465 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__=
VA_ARGS__)
>           |                                            ^
>     include/linux/printk.h:437:17: note: in definition of macro =E2=80=98=
printk_index_wrap=E2=80=99
>       437 |                 _p_func(_fmt, ##__VA_ARGS__);                =
           \
>           |                 ^~~~~~~
>     include/linux/printk.h:508:9: note: in expansion of macro =E2=80=98pr=
intk=E2=80=99
>       508 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>           |         ^~~~~~
>     drivers/gpu/drm/radeon/r100.c:1062:17: note: in expansion of macro =
=E2=80=98pr_err=E2=80=99
>      1062 |                 pr_err("radeon_cp: Failed to load firmware \"=
%s\"\n", fw_name);
>           |                 ^~~~~~
>
> Fix this by converting the if/else if/... construct into a proper
> switch() statement with a default to handle the error case.
>
> As a bonus, the generated code is ca. 100 bytes smaller (with gcc 11.4.0
> targeting arm32).
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Compile-tested only.
> ---
>  drivers/gpu/drm/radeon/r100.c | 70 ++++++++++++++++++++++-------------
>  1 file changed, 45 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.=
c
> index 0b1e19345f43a771..bfd42e3e161e984f 100644
> --- a/drivers/gpu/drm/radeon/r100.c
> +++ b/drivers/gpu/drm/radeon/r100.c
> @@ -1016,45 +1016,65 @@ static int r100_cp_init_microcode(struct radeon_d=
evice *rdev)
>
>         DRM_DEBUG_KMS("\n");
>
> -       if ((rdev->family =3D=3D CHIP_R100) || (rdev->family =3D=3D CHIP_=
RV100) ||
> -           (rdev->family =3D=3D CHIP_RV200) || (rdev->family =3D=3D CHIP=
_RS100) ||
> -           (rdev->family =3D=3D CHIP_RS200)) {
> +       switch (rdev->family) {
> +       case CHIP_R100:
> +       case CHIP_RV100:
> +       case CHIP_RV200:
> +       case CHIP_RS100:
> +       case CHIP_RS200:
>                 DRM_INFO("Loading R100 Microcode\n");
>                 fw_name =3D FIRMWARE_R100;
> -       } else if ((rdev->family =3D=3D CHIP_R200) ||
> -                  (rdev->family =3D=3D CHIP_RV250) ||
> -                  (rdev->family =3D=3D CHIP_RV280) ||
> -                  (rdev->family =3D=3D CHIP_RS300)) {
> +               break;
> +
> +       case CHIP_R200:
> +       case CHIP_RV250:
> +       case CHIP_RV280:
> +       case CHIP_RS300:
>                 DRM_INFO("Loading R200 Microcode\n");
>                 fw_name =3D FIRMWARE_R200;
> -       } else if ((rdev->family =3D=3D CHIP_R300) ||
> -                  (rdev->family =3D=3D CHIP_R350) ||
> -                  (rdev->family =3D=3D CHIP_RV350) ||
> -                  (rdev->family =3D=3D CHIP_RV380) ||
> -                  (rdev->family =3D=3D CHIP_RS400) ||
> -                  (rdev->family =3D=3D CHIP_RS480)) {
> +               break;
> +
> +       case CHIP_R300:
> +       case CHIP_R350:
> +       case CHIP_RV350:
> +       case CHIP_RV380:
> +       case CHIP_RS400:
> +       case CHIP_RS480:
>                 DRM_INFO("Loading R300 Microcode\n");
>                 fw_name =3D FIRMWARE_R300;
> -       } else if ((rdev->family =3D=3D CHIP_R420) ||
> -                  (rdev->family =3D=3D CHIP_R423) ||
> -                  (rdev->family =3D=3D CHIP_RV410)) {
> +               break;
> +
> +       case CHIP_R420:
> +       case CHIP_R423:
> +       case CHIP_RV410:
>                 DRM_INFO("Loading R400 Microcode\n");
>                 fw_name =3D FIRMWARE_R420;
> -       } else if ((rdev->family =3D=3D CHIP_RS690) ||
> -                  (rdev->family =3D=3D CHIP_RS740)) {
> +               break;
> +
> +       case CHIP_RS690:
> +       case CHIP_RS740:
>                 DRM_INFO("Loading RS690/RS740 Microcode\n");
>                 fw_name =3D FIRMWARE_RS690;
> -       } else if (rdev->family =3D=3D CHIP_RS600) {
> +               break;
> +
> +       case CHIP_RS600:
>                 DRM_INFO("Loading RS600 Microcode\n");
>                 fw_name =3D FIRMWARE_RS600;
> -       } else if ((rdev->family =3D=3D CHIP_RV515) ||
> -                  (rdev->family =3D=3D CHIP_R520) ||
> -                  (rdev->family =3D=3D CHIP_RV530) ||
> -                  (rdev->family =3D=3D CHIP_R580) ||
> -                  (rdev->family =3D=3D CHIP_RV560) ||
> -                  (rdev->family =3D=3D CHIP_RV570)) {
> +               break;
> +
> +       case CHIP_RV515:
> +       case CHIP_R520:
> +       case CHIP_RV530:
> +       case CHIP_R580:
> +       case CHIP_RV560:
> +       case CHIP_RV570:
>                 DRM_INFO("Loading R500 Microcode\n");
>                 fw_name =3D FIRMWARE_R520;
> +               break;
> +
> +       default:
> +               DRM_ERROR("Unsupported Radeon family %u\n", rdev->family)=
;
> +               return -EINVAL;
>         }
>
>         err =3D request_firmware(&rdev->me_fw, fw_name, rdev->dev);
> --
> 2.34.1
>

