Return-Path: <linux-kernel+bounces-409950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D6C9C9401
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 22:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C2AFB23834
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81371ABEBA;
	Thu, 14 Nov 2024 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1U+qFXA"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AB0189F2A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 21:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731619140; cv=none; b=Jsa9SF9Mhm+29Ftar4MxGXRmb/B4QAXfopMFs5hQwOyfXdFBCsLY3P1sGx0IAfefMtBwJvFRic8Uvyn3NwtuA/dz8Fv2q8xzUEXTLxA7PazRM29NpyrYTp2d1a7l5rUR4W44E1E0RuOX1D8fjkcySqJOxTBGbgLQ7dbjexjcIuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731619140; c=relaxed/simple;
	bh=bDisoOzoY4v4sUgXGaGn+/04/Tm9Eeltx6NyCnLyQQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OdDDSMz+SObOw81rFe9+ngBP2OgZ/piY/G80XhsXfFup8CU1cXOl2EYhUuHruD0Q/UOMtrVzjsBqxeDBh7SPV+gbWOcY4GNLIKi31msVvtlDXVYwVac4eJsuge5TqFtVNPEXaWGYMDT/gxgN/vrnOq4lvtRvGxFc4yPlPUKDxak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1U+qFXA; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ee36621734so134601a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731619138; x=1732223938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjOZE3hisAlCS7qwBlAU3bmbS3PWvwStgDVh9a8JQvs=;
        b=O1U+qFXAy+VLwB8CiNg8FAES1P4cxwQfd/uLB5FXCNE3xUNuORaY9lpU8RpByvHVpB
         KCMhy3p2kUbhueJ/k+K7oXqU0eBhU53zpDkuK769skQr8BTJio3I/2Bm6WsWEGq/twdh
         Dj0HqTtDcMD/Q1DN7wMcth4TMfW/5Pt00YMe1qxkwdJbHyzDOjtSK47o3TCGrTIwqJkL
         I36sAh8xx6ntg5+a2t2uwLwkI9JYEJhFWycgsxPrTb+hXzh+9CD3+0hpwiufA/rcggx2
         AhTyFKpRkK+DwRvhqpJ6dVjsp7RyWM1SakcmUmCkm4Gf2snIxe/eJTJLw6IC1VUPjSom
         Zg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731619138; x=1732223938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjOZE3hisAlCS7qwBlAU3bmbS3PWvwStgDVh9a8JQvs=;
        b=ivvtICRJ2gSo1KRnm9CkbD/1Ctq+j/701lq/62v7R8x7NpCRSNZlY37gC67wMqk0M7
         mbFD36QFaKFDG4J4E7Z0Fhz950MwBcZWbOMyQErR1PqlG0l9Xn3r0lamB30BrlfRaIDq
         EJGUjFW+tE7Gukcju2EqdY63izqxn84Nf2noHf6CDoi+X2FE+ZvlF9B6snZZyggF74NO
         4+YpF67kX8q2NDRolelavv9HCqKDOFkaJHfz+MzU0FbrUFRiztHdWivmZHHVubhp7f7a
         YS0FRWeozXj935DBzexlehNsn81U4OgkMd8+uWFWUKWcxJbxAX7nJS+GBn9AmOjAJoQW
         pITw==
X-Forwarded-Encrypted: i=1; AJvYcCXmw6gCtPI+e1Yk59V3y74m3YyANntWu/Klk3lwHJireLl2RXY0tvkWrzKg9tqUwGOkc7wYRzG3/EvjNPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYxIgresCwkX6pM2nbTGzXlfvYZwWLntQUZ2UAs7Pr2SzvYNiR
	/udqA42XUCtkNKWi+PHuLU2G7W4v6SB8bDFhAPHS4EV5RCV9KCJOVyJI6nTmztslrjq79Z1cm/s
	IG456t7W0U4h4bAAKE87oeU3olUnuyQ==
X-Google-Smtp-Source: AGHT+IHhzXPmMku0cg2aQkWtxHrVmoYB4Za4dM8qFfs1SAu2VpW3gDJitADrhTqzXMtr1h9ZsN641VCvr03wtASGca4=
X-Received: by 2002:a17:903:2b08:b0:20c:b527:d460 with SMTP id
 d9443c01a7336-211d0d77e16mr1681805ad.6.1731619137932; Thu, 14 Nov 2024
 13:18:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114151150.19576-1-bhavin.sharma@siliconsignals.io> <20241114151150.19576-3-bhavin.sharma@siliconsignals.io>
In-Reply-To: <20241114151150.19576-3-bhavin.sharma@siliconsignals.io>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Nov 2024 16:18:40 -0500
Message-ID: <CADnq5_OmxZ=tHrByQkDiFdwydpvunpkGWTsb8sLq9zb9ajXdkQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/amd/pm: remove redundant tools_size check
To: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
Cc: alexander.deucher@amd.com, alex.hung@amd.com, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Kenneth Feng <kenneth.feng@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Leo Ma <hanghong.ma@amd.com>, 
	Ryan Seto <ryanseto@amd.com>, Jose Fernandez <josef@netflix.com>, 
	Ilya Bakoulin <ilya.bakoulin@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Thu, Nov 14, 2024 at 10:12=E2=80=AFAM Bhavin Sharma
<bhavin.sharma@siliconsignals.io> wrote:
>
> The check for tools_size being non-zero is redundant as tools_size is
> explicitly set to a non-zero value (0x19000). Removing the if condition
> simplifies the code without altering functionality.
>
> Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
> ---
>  .../amd/pm/powerplay/smumgr/vega12_smumgr.c   | 24 +++++++++----------
>  1 file changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c b/dr=
ivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c
> index b52ce135d84d..d3ff6a831ed5 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c
> @@ -257,20 +257,18 @@ static int vega12_smu_init(struct pp_hwmgr *hwmgr)
>         priv->smu_tables.entry[TABLE_WATERMARKS].size =3D sizeof(Watermar=
ks_t);
>
>         tools_size =3D 0x19000;
> -       if (tools_size) {
> -               ret =3D amdgpu_bo_create_kernel((struct amdgpu_device *)h=
wmgr->adev,
> -                                             tools_size,
> -                                             PAGE_SIZE,
> -                                             AMDGPU_GEM_DOMAIN_VRAM,
> -                                             &priv->smu_tables.entry[TAB=
LE_PMSTATUSLOG].handle,
> -                                             &priv->smu_tables.entry[TAB=
LE_PMSTATUSLOG].mc_addr,
> -                                             &priv->smu_tables.entry[TAB=
LE_PMSTATUSLOG].table);
> -               if (ret)
> -                       goto err1;
> +       ret =3D amdgpu_bo_create_kernel((struct amdgpu_device *)hwmgr->ad=
ev,
> +                                     tools_size,
> +                                     PAGE_SIZE,
> +                                     AMDGPU_GEM_DOMAIN_VRAM,
> +                                     &priv->smu_tables.entry[TABLE_PMSTA=
TUSLOG].handle,
> +                                     &priv->smu_tables.entry[TABLE_PMSTA=
TUSLOG].mc_addr,
> +                                     &priv->smu_tables.entry[TABLE_PMSTA=
TUSLOG].table);
> +       if (ret)
> +               goto err1;
>
> -               priv->smu_tables.entry[TABLE_PMSTATUSLOG].version =3D 0x0=
1;
> -               priv->smu_tables.entry[TABLE_PMSTATUSLOG].size =3D tools_=
size;
> -       }
> +       priv->smu_tables.entry[TABLE_PMSTATUSLOG].version =3D 0x01;
> +       priv->smu_tables.entry[TABLE_PMSTATUSLOG].size =3D tools_size;
>
>         /* allocate space for AVFS Fuse table */
>         ret =3D amdgpu_bo_create_kernel((struct amdgpu_device *)hwmgr->ad=
ev,
> --
> 2.43.0
>

