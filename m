Return-Path: <linux-kernel+bounces-576243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A548A70CA3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 778577A4EAF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39088269AF8;
	Tue, 25 Mar 2025 22:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WovFY34z"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07693269B0E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 22:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742940738; cv=none; b=StF0NtUzIByD6ATY922tQvdu4YN9nhq+EQJALhA56OPTYQNYCZ5B9QITa6Kk05vG/4BdK4txDy4I0i09S2uL+qEs8zKfT3B9whoFA5x0yotZu4snYQ7IrSgcglu032KCxLIPbCEKqkXNZsXIlbQsxa5+70kubdw4TuIGL6tcvqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742940738; c=relaxed/simple;
	bh=3eslH+t+TbD7LQuwNVVPfVOQ7J3+oAgPrGLbmfz0K7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRj7oZzeOog+gcLI1zYztLgNiCoVnF0kUEFMOEjaNuQjhx4dB2oUv9Di2GMJgrKsibYiGrnbfevlpeY6RUaQCjlZ4IZz+kOLaV6nH1nrK4drc7JMXPpylhE7gOggjFCm7MykhiQ2vFMJO0lEeIOBXqIz9uRGM6rSZCW/qtSKbOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WovFY34z; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff5544af03so1876545a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742940736; x=1743545536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=od9pHwvKTDqtCanN7vue6aidZIC4KSNszNDu5XDL030=;
        b=WovFY34zRUO3te1wozi1027xRzUogCEsf1MnK/f9iSIqFuBy7v83cyKCmjQblhuzIA
         x9iUiTFo/6a/wNFG47zMdv4c/4cE5alWq1hTEO7VvqZwoqDM1nad4gj5WjQjGIH03KV7
         SVEuWs5Skjh/Ke7wDnUmnawhihJUdjsDslWqiQbDGKqksQrz4vrHFvm34p1QoFEkdhUt
         7+1DcGulFu99zfCPGKBQwDZKZXv6iOB/4J6n5BGdyw4O5DCla9wliuPu0B154PxAy4pe
         YncQmeJHWKNYjfRj2omW/ZcSoZez3EFGZ2w7dT3XIX19TFgFV5Y4r2UyXJgCS6tHXG7s
         CKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742940736; x=1743545536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=od9pHwvKTDqtCanN7vue6aidZIC4KSNszNDu5XDL030=;
        b=Yr2IDsetHRaxN1xb92nqbX+xR/4O8x3qAg3NDxT/0HbpqHyE/FwXvS71HU3dkfDHbE
         v8p1D9QmC3RxyVKI/7axCbXrnSMsicbDw4gE8Az3KqgB3+U5p0KTxcHHg9HAxkGw3diZ
         0pzfh4arLgBYNDEfAKsXJLOWdhh8IXab6j6kyQ+bFob7P0/3AqIyYGgjCV29alxIWUzq
         WijgigfxXwzLre57Md6FXvEVb8BOgn7Rxj72RBA14fdqCqF+9d0AjyZz2RGkza2jCX4R
         w7XxShSmjuRv++h/QnnbCtCbud0c41Dqe/jzvRlRMvIGIx5dF2IJOAoXBVIAbFQlt7RD
         iFzw==
X-Forwarded-Encrypted: i=1; AJvYcCXBEKZOwxc0SxXJNo4Pooi3+QI2EuVpWaTpw62Jr3MgCpqcb+HDTGLdGQRR2RbOgr1S2gQoSM5SAGrF7qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQjYYt74AA2c1UucIc50Unh+SP6aM2DkKcyJOL5yYzY6NaQI/x
	BI3IK2hwk9cPKrVS7iki1G91zm65fIb6ibEq9nBVbQlYgmZf4u8DFXspJhSUOWIvsk22gDHKUDd
	mw3+2wRWY422CgzR9m/Bbj9YLizc=
X-Gm-Gg: ASbGncvvcNarXuCbnclV6u5XTC2zAbqa6GwRgcjxMx66AowVcZI1SUdL9fJywmbw9jP
	zSdLxbZQTVCIsb1mceTO4bGY7eM3bnX4H1jMwf8FrbR18jfCQsjzOxPUrXJq35LjsAAHnZcx9C8
	/94PmIIcPS1kWQV4vwcA5tBfWqAw==
X-Google-Smtp-Source: AGHT+IGV1svpZf6dEQvMFQKxRZPRAcOHlrsfO4jmy72XxmgDQa5aB5mBLrtr9kwQGFf0DdhDb+az2tMunqavZTqdyWA=
X-Received: by 2002:a17:90b:4c41:b0:2ff:6666:529d with SMTP id
 98e67ed59e1d1-3030fef4b27mr11159900a91.6.1742940735916; Tue, 25 Mar 2025
 15:12:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325210517.2097188-1-bradynorander@gmail.com>
In-Reply-To: <20250325210517.2097188-1-bradynorander@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Mar 2025 18:12:04 -0400
X-Gm-Features: AQ5f1Jq62_XuZD0k3dE4N_FzF_eoMBk1GYehLCaicuweyhrZdp2RKX8gCq_kFNs
Message-ID: <CADnq5_MNBUY=jWbnq-gZQ_4_M_sBJGAgMD0bj2cMdnkoU9G=HA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: use static ids for ACP platform devs
To: Brady Norander <bradynorander@gmail.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, alexander.deucher@amd.com, 
	christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
	sunil.khatri@amd.com, boyuan.zhang@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 6:07=E2=80=AFPM Brady Norander <bradynorander@gmail=
.com> wrote:
>
> mfd_add_hotplug_devices() assigns child platform devices with
> PLATFORM_DEVID_AUTO, but the ACP machine drivers expect the platform
> device names to never change. Use mfd_add_devices() instead and give
> each cell a unique id.

While you are at it, can you take a look at
drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c and
drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c as well?

Alex

>
> Signed-off-by: Brady Norander <bradynorander@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_acp.c
> index deb0785350e8..9c657637d317 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> @@ -302,17 +302,19 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_b=
lock)
>                 adev->acp.acp_res[2].end =3D adev->acp.acp_res[2].start;
>
>                 adev->acp.acp_cell[0].name =3D "acp_audio_dma";
> +               adev->acp.acp_cell[0].id =3D 0;
>                 adev->acp.acp_cell[0].num_resources =3D 3;
>                 adev->acp.acp_cell[0].resources =3D &adev->acp.acp_res[0]=
;
>                 adev->acp.acp_cell[0].platform_data =3D &adev->asic_type;
>                 adev->acp.acp_cell[0].pdata_size =3D sizeof(adev->asic_ty=
pe);
>
>                 adev->acp.acp_cell[1].name =3D "designware-i2s";
> +               adev->acp.acp_cell[1].id =3D 1;
>                 adev->acp.acp_cell[1].num_resources =3D 1;
>                 adev->acp.acp_cell[1].resources =3D &adev->acp.acp_res[1]=
;
>                 adev->acp.acp_cell[1].platform_data =3D &i2s_pdata[0];
>                 adev->acp.acp_cell[1].pdata_size =3D sizeof(struct i2s_pl=
atform_data);
> -               r =3D mfd_add_hotplug_devices(adev->acp.parent, adev->acp=
.acp_cell, 2);
> +               r =3D mfd_add_devices(adev->acp.parent, 0, adev->acp.acp_=
cell, 2, NULL, 0, NULL);
>                 if (r)
>                         goto failure;
>                 r =3D device_for_each_child(adev->acp.parent, &adev->acp.=
acp_genpd->gpd,
> @@ -410,30 +412,34 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_b=
lock)
>                 adev->acp.acp_res[4].end =3D adev->acp.acp_res[4].start;
>
>                 adev->acp.acp_cell[0].name =3D "acp_audio_dma";
> +               adev->acp.acp_cell[0].id =3D 0;
>                 adev->acp.acp_cell[0].num_resources =3D 5;
>                 adev->acp.acp_cell[0].resources =3D &adev->acp.acp_res[0]=
;
>                 adev->acp.acp_cell[0].platform_data =3D &adev->asic_type;
>                 adev->acp.acp_cell[0].pdata_size =3D sizeof(adev->asic_ty=
pe);
>
>                 adev->acp.acp_cell[1].name =3D "designware-i2s";
> +               adev->acp.acp_cell[1].id =3D 1;
>                 adev->acp.acp_cell[1].num_resources =3D 1;
>                 adev->acp.acp_cell[1].resources =3D &adev->acp.acp_res[1]=
;
>                 adev->acp.acp_cell[1].platform_data =3D &i2s_pdata[0];
>                 adev->acp.acp_cell[1].pdata_size =3D sizeof(struct i2s_pl=
atform_data);
>
>                 adev->acp.acp_cell[2].name =3D "designware-i2s";
> +               adev->acp.acp_cell[2].id =3D 2;
>                 adev->acp.acp_cell[2].num_resources =3D 1;
>                 adev->acp.acp_cell[2].resources =3D &adev->acp.acp_res[2]=
;
>                 adev->acp.acp_cell[2].platform_data =3D &i2s_pdata[1];
>                 adev->acp.acp_cell[2].pdata_size =3D sizeof(struct i2s_pl=
atform_data);
>
>                 adev->acp.acp_cell[3].name =3D "designware-i2s";
> +               adev->acp.acp_cell[3].id =3D 3;
>                 adev->acp.acp_cell[3].num_resources =3D 1;
>                 adev->acp.acp_cell[3].resources =3D &adev->acp.acp_res[3]=
;
>                 adev->acp.acp_cell[3].platform_data =3D &i2s_pdata[2];
>                 adev->acp.acp_cell[3].pdata_size =3D sizeof(struct i2s_pl=
atform_data);
>
> -               r =3D mfd_add_hotplug_devices(adev->acp.parent, adev->acp=
.acp_cell, ACP_DEVS);
> +               r =3D mfd_add_devices(adev->acp.parent, 0, adev->acp.acp_=
cell, ACP_DEVS, NULL, 0, NULL);
>                 if (r)
>                         goto failure;
>
> --
> 2.48.1
>

