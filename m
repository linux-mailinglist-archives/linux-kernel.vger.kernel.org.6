Return-Path: <linux-kernel+bounces-297654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3522C95BC0E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E298E2818F6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86631CDA11;
	Thu, 22 Aug 2024 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jweeJ+aC"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA8B282FC
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724344525; cv=none; b=lEyCd0/02/0SxXydyFOF4tBnPxEy5OTKazydv7NbqOjozhWVPsWHLVvAu2Z8mlh3dTpFJZltevJgh5ffiw9NMXqrqNSpyGdv8+ZbWZLlUqH1gFl1n596vykvUkaPUftfQW/cEFjYZtrib7AzltR+R7vIbABUJeF0s18RC04VnkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724344525; c=relaxed/simple;
	bh=MDwjZuVPUKrZ/MWj2oKE3XM3L5jaRI5PByWz40tLNmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fOvWKvrxuBzO8gdH7+KFz9viE+rSZ8iHeVC+XpWvUjz4cl6y9rl4dDvbiFF4X/L7D4fISQcSAqHwUJ4Xros8jvhEjcggdW8YpqxP7hx4bbwvoKgadcWvGKT2Slmkp7klDX7ztmMyOJ/Ni071VBq/MtygVTxo12y8imRruEore1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jweeJ+aC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-201eb53ddbeso569335ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724344524; x=1724949324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiD4ntFACWV2hnSlKy5BrlAt61hKhmJmLjHhc03SnZA=;
        b=jweeJ+aCMJGHu8tX4nKBCb8J1zZorOGT0rOpmEGWvRlcdN6VXS6vCWpl1v+QVe+jax
         tgOksU++qnnEcQCNH6iSjK15geHbRfxN2jIGZx09abgDCSAlQCzUJ+GOAWGznXj7o3kz
         DiC73pRMGZJOZgJl9vk8Hg8C80W7HKi9PEjssAbYApbNOCgGLKTMdvtDGEMR27/VqNmj
         LuDMnF379nSmN6BkLAXH+X+Hj2gjQYpWuWL7yfq49EAND8JXwOz6Ej/JlJ0N0sSyi9ZF
         gvjo7d3guwdPaChFd61z467n41J7hY/3HGBDRg+lGaST92FBqI4Addoa8D/lHgENXvW/
         sKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724344524; x=1724949324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QiD4ntFACWV2hnSlKy5BrlAt61hKhmJmLjHhc03SnZA=;
        b=kzSXoZ/SEGdGwdNL80evKDxw2tzw+8CUZzp/1YZlzI3f4FgTXGVsRrbMjECjuLKBs/
         2BuZmY5zY5M9u8BoyLA/pR//m99BXHGdfyqlYqM0+HnfZQZh7GsLEcBMCCkWMBNPAWbk
         X0uUW28rdRAY4PB62LttCLafElnwUsQlv4c1uJmiVKgU3Bzv9FDFcQ5BtwRqEvcrM3hV
         CKVPxR9k7POxkLkxQwq+Af+O9g8E7jYsVpgOfzgYwEO6kJOKgDCdskTwCbw/0ooI5yzS
         O7eVsShhLp/3ZICC8LzVTavLxQJS8pjEIoaG1avTkqo5cOxDHQYgtju1tL+6XV9kss09
         WJMg==
X-Forwarded-Encrypted: i=1; AJvYcCVlOHeM7q/uQ72h4oJsP268pO4jn0dtQaHvfr6JFwt9Lu9lLlT+WtrD7qrlNgfchNqw4tI1hnXkRlrD4Aw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7La7lVJhqFYxvci8CKe79aCIyLlxMQbc5Q3IAWdTZZH/TYtL1
	8rYtvVGuYdYHy6k1M8lY4nc1StzvFa1HivAaUORxJn2I6x/C0+qbMPK5kmn+5VtE+mBi1rmQzru
	EMccZQE1x0lvhe+/ydPC2XhTdysg=
X-Google-Smtp-Source: AGHT+IFxLKfq7mdRccptIMwf0Pvk4M1DcaSR/NtNNBaWcSQgMUoZ2GChOMAcntoy+JSmjsICxfI4gxfzq2kwtq/6Xko=
X-Received: by 2002:a17:902:c947:b0:1fc:5cc8:bb1b with SMTP id
 d9443c01a7336-2036808e83dmr39151925ad.7.1724344523239; Thu, 22 Aug 2024
 09:35:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822073011.1352849-1-11162571@vivo.com>
In-Reply-To: <20240822073011.1352849-1-11162571@vivo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 Aug 2024 12:35:11 -0400
Message-ID: <CADnq5_PopUBCLimGUtNJqbwMb4XpdBeHrMZT0vJfQitmQ=uoZw@mail.gmail.com>
Subject: Re: [PATCH v1] drivers:smumgr:Variable names should be consistent
To: Yang Ruibin <11162571@vivo.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 3:49=E2=80=AFAM Yang Ruibin <11162571@vivo.com> wro=
te:
>
> The variable highest_pcie_level_enabled is named
> hightest_pcie_level_enabled in other modules.

hightest is a typo.  It should be highest.  Please fix up the
misspellings instead.

Alex

> Please ensure the consistency of variable naming
> and use min macros instead of the triadic operator.
>
> Signed-off-by: Yang Ruibin <11162571@vivo.com>
> ---
>  .../drm/amd/pm/powerplay/smumgr/tonga_smumgr.c  | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c b/dri=
vers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
> index 6fe6e6abb..60b1387f6 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
> @@ -700,7 +700,7 @@ static int tonga_populate_all_graphic_levels(struct p=
p_hwmgr *hwmgr)
>         SMU72_Discrete_GraphicsLevel *levels =3D smu_data->smc_state_tabl=
e.GraphicsLevel;
>
>         uint32_t i, max_entry;
> -       uint8_t highest_pcie_level_enabled =3D 0;
> +       uint8_t hightest_pcie_level_enabled =3D 0;
>         uint8_t lowest_pcie_level_enabled =3D 0, mid_pcie_level_enabled =
=3D 0;
>         uint8_t count =3D 0;
>         int result =3D 0;
> @@ -747,8 +747,8 @@ static int tonga_populate_all_graphic_levels(struct p=
p_hwmgr *hwmgr)
>
>                 while (data->dpm_level_enable_mask.pcie_dpm_enable_mask &=
&
>                                 ((data->dpm_level_enable_mask.pcie_dpm_en=
able_mask &
> -                                       (1<<(highest_pcie_level_enabled+1=
))) !=3D 0)) {
> -                       highest_pcie_level_enabled++;
> +                                       (1<<(hightest_pcie_level_enabled+=
1))) !=3D 0)) {
> +                       hightest_pcie_level_enabled++;
>                 }
>
>                 while (data->dpm_level_enable_mask.pcie_dpm_enable_mask &=
&
> @@ -757,18 +757,19 @@ static int tonga_populate_all_graphic_levels(struct=
 pp_hwmgr *hwmgr)
>                         lowest_pcie_level_enabled++;
>                 }
>
> -               while ((count < highest_pcie_level_enabled) &&
> +               while ((count < hightest_pcie_level_enabled) &&
>                                 ((data->dpm_level_enable_mask.pcie_dpm_en=
able_mask &
>                                         (1<<(lowest_pcie_level_enabled+1+=
count))) =3D=3D 0)) {
>                         count++;
>                 }
> -               mid_pcie_level_enabled =3D (lowest_pcie_level_enabled+1+c=
ount) < highest_pcie_level_enabled ?
> -                       (lowest_pcie_level_enabled+1+count) : highest_pci=
e_level_enabled;
>
> +               mid_pcie_level_enabled =3D min(lowest_pcie_level_enabled+=
1+count,
> +                                       hightest_pcie_level_enabled);
>
> -               /* set pcieDpmLevel to highest_pcie_level_enabled*/
> +               /* set pcieDpmLevel to hightest_pcie_level_enabled*/
>                 for (i =3D 2; i < dpm_table->sclk_table.count; i++)
> -                       smu_data->smc_state_table.GraphicsLevel[i].pcieDp=
mLevel =3D highest_pcie_level_enabled;
> +                       smu_data->smc_state_table.GraphicsLevel[i].pcieDp=
mLevel =3D
> +                                       hightest_pcie_level_enabled;
>
>                 /* set pcieDpmLevel to lowest_pcie_level_enabled*/
>                 smu_data->smc_state_table.GraphicsLevel[0].pcieDpmLevel =
=3D lowest_pcie_level_enabled;
> --
> 2.34.1
>

