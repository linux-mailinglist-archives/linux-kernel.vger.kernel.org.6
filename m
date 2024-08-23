Return-Path: <linux-kernel+bounces-298931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED0E95CD9D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BB2E1F23A42
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7768F1E4B2;
	Fri, 23 Aug 2024 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggaQ1qHV"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5FF186611
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724419089; cv=none; b=EAx/mOfpt1Ks4LNDxpZLOU5FsNNfkpf1fzxCnu93+M0twaaID1847JcqDJ2leefOwRaIYYPornPnUtBGsPO+BUttYkIUqZAEtbba30v8NHKAVsZuVJOaOarasRobakKeaFMmbHM7jDyiNP/+2wZ4yE0xlfyvj7L4iXJqDIRF22Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724419089; c=relaxed/simple;
	bh=ptNVNaTrQaw1PgLfgnyMXqlQlcvpy/Dg2kkBK8KHcKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGmAbXS1YRkUk9z9/0dc2XPsNHktv6dZyt7k7TvLdtyTUarBxhIg9/muyz0kzwa57fKiIDorzBO0cNmDpxgHEHfggluNVSVIsW2KDU6m17DhNIVi4rIk0psuEtaQQMwuJoNmhlFrALWONQ/o9ZUVa1/Js3Sgoya5OKRD3SCpXo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggaQ1qHV; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7c2595f5c35so196135a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 06:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724419087; x=1725023887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FM9Xtx1WVTxxu5XGhVbKBrKZgXpEQzHjuRapKL7d44=;
        b=ggaQ1qHVJAMZOBqj7fX3uGBtkoridDZp5EkoEEjUENeIxD/rXpNafV9AoARYt84iD+
         wN10T1wLY7sPZJKF82Gsvwnfc3IMf9eWoAu6ilWYzxdYFifAbxJVvt/OddufN2JSZGnt
         i6qb+xCKgbsekxrdMglFki5aizJeUUv024V7+u0lbF5URTxkzLXxboMRzviRH//ykWN4
         /SIPT28qp/xTcbHxESH3zgplwCb5ghnfbDrXbP2b080hO1Y/ZpHMcDna2TkrXNwQHdBZ
         OznN0yXTsQ2SBrik027IqbtNMy12agGloFIeOalr9Ho0RD1R58gNdfbqZi01eoFvzIl7
         C6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724419087; x=1725023887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FM9Xtx1WVTxxu5XGhVbKBrKZgXpEQzHjuRapKL7d44=;
        b=mIMV7r+MUwP9DxKeZKmWydlYQlt0vmsvsKR4TnWUJxBZVHYkM/oMStPGhU78tQJH9q
         c9DMoKbWgY/+uMUSAMCLaJBUflU8/A+FrdLCbOLLb24QgwPYQCnH2PLGKC5WZ1XRyyNa
         M2cIfU+jsrR+K/mu6jVqPMMK6l8Kw68RILrDIH18aHModVtqOUTZhortAngEq4O1CBLb
         oZwO//LbBFysfnUNkaYfzPwnAUcFkIiczjzZ2IbYAx+Lgpo7wbL+H2b29ftxYbHNnEBW
         P94QMHznSttKPj0CmcbrDemDRw6mL3iMty8WEww775PKxld3ii3iwv+5hC8IuM1XtLvD
         rewQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyYp9BFHB/rVx+ZjAMN36i2xP4S9uyctxpznB6/CXH0QtQ7DZHFxV3KaYVhsZq6cpYRQL8Am3KdhKx1Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPa/Jynl1MgmrQIkaAE0RsxS5BI3h7sloAuSi0iT5GTdOl9W9J
	YhEm7ETQxB6I50gvRQ3St/CUVe6uQtrOi1lqaHzSLrDYOgxZEJ8xpGoJ0nEc30rxhUgA0VnnDKs
	eNjJF0GDTsJVGYRheBCSmirJxVSg=
X-Google-Smtp-Source: AGHT+IGGPjPiBjhx/igIgyFZnU5cMDgr5uKwT3YNr6Sp+5Qeksl9DoGAOkexFul1FA5+sXrmVo5msKSxq7/5owzoMFw=
X-Received: by 2002:a17:902:f68d:b0:202:401f:ec8d with SMTP id
 d9443c01a7336-2039e6e6159mr12905495ad.11.1724419086888; Fri, 23 Aug 2024
 06:18:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823091803.3452513-1-11162571@vivo.com>
In-Reply-To: <20240823091803.3452513-1-11162571@vivo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 Aug 2024 09:17:55 -0400
Message-ID: <CADnq5_PhMMT1-Xex5eW2unNkhU1gjuEvd9V7PRYfOb+dKJOwNg@mail.gmail.com>
Subject: Re: [PATCH v2] drivers:smumgr:fix up the misspellings
To: Yang Ruibin <11162571@vivo.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 5:30=E2=80=AFAM Yang Ruibin <11162571@vivo.com> wro=
te:
>
> Hightest is a typo.  It should be highest.Please ensure
> the consistency of variable naming.
>
> Signed-off-by: Yang Ruibin <11162571@vivo.com>
> ---
> Changes V2:
> - Replaced the word "hightest_pcie_level_enabled" with "hightest_pcie_lev=
el_enabled".
> ---
>  .../drm/amd/pm/powerplay/smumgr/fiji_smumgr.c    | 16 ++++++++--------
>  .../amd/pm/powerplay/smumgr/polaris10_smumgr.c   | 16 ++++++++--------
>  .../drm/amd/pm/powerplay/smumgr/vegam_smumgr.c   | 16 ++++++++--------
>  3 files changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c b/driv=
ers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
> index 5e43ad2b2..e16efc44d 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
> @@ -1014,7 +1014,7 @@ static int fiji_populate_all_graphic_levels(struct =
pp_hwmgr *hwmgr)
>         struct SMU73_Discrete_GraphicsLevel *levels =3D
>                         smu_data->smc_state_table.GraphicsLevel;
>         uint32_t i, max_entry;
> -       uint8_t hightest_pcie_level_enabled =3D 0,
> +       uint8_t hightest_pcie_level_enabled =3D 0,

This looks like this one didn't get updated properly.

Alex

>                         lowest_pcie_level_enabled =3D 0,
>                         mid_pcie_level_enabled =3D 0,
>                         count =3D 0;
> @@ -1054,27 +1054,27 @@ static int fiji_populate_all_graphic_levels(struc=
t pp_hwmgr *hwmgr)
>         } else {
>                 while (data->dpm_level_enable_mask.pcie_dpm_enable_mask &=
&
>                                 ((data->dpm_level_enable_mask.pcie_dpm_en=
able_mask &
> -                                               (1 << (hightest_pcie_leve=
l_enabled + 1))) !=3D 0))
> -                       hightest_pcie_level_enabled++;
> +                                               (1 << (highest_pcie_level=
_enabled + 1))) !=3D 0))
> +                       highest_pcie_level_enabled++;
>
>                 while (data->dpm_level_enable_mask.pcie_dpm_enable_mask &=
&
>                                 ((data->dpm_level_enable_mask.pcie_dpm_en=
able_mask &
>                                                 (1 << lowest_pcie_level_e=
nabled)) =3D=3D 0))
>                         lowest_pcie_level_enabled++;
>
> -               while ((count < hightest_pcie_level_enabled) &&
> +               while ((count < highest_pcie_level_enabled) &&
>                                 ((data->dpm_level_enable_mask.pcie_dpm_en=
able_mask &
>                                                 (1 << (lowest_pcie_level_=
enabled + 1 + count))) =3D=3D 0))
>                         count++;
>
>                 mid_pcie_level_enabled =3D (lowest_pcie_level_enabled + 1=
 + count) <
> -                               hightest_pcie_level_enabled ?
> +                               highest_pcie_level_enabled ?
>                                                 (lowest_pcie_level_enable=
d + 1 + count) :
> -                                               hightest_pcie_level_enabl=
ed;
> +                                               highest_pcie_level_enable=
d;
>
> -               /* set pcieDpmLevel to hightest_pcie_level_enabled */
> +               /* set pcieDpmLevel to highest_pcie_level_enabled */
>                 for (i =3D 2; i < dpm_table->sclk_table.count; i++)
> -                       levels[i].pcieDpmLevel =3D hightest_pcie_level_en=
abled;
> +                       levels[i].pcieDpmLevel =3D highest_pcie_level_ena=
bled;
>
>                 /* set pcieDpmLevel to lowest_pcie_level_enabled */
>                 levels[0].pcieDpmLevel =3D lowest_pcie_level_enabled;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b=
/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
> index ff6b563ec..d785cc646 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
> @@ -1050,7 +1050,7 @@ static int polaris10_populate_all_graphic_levels(st=
ruct pp_hwmgr *hwmgr)
>         struct SMU74_Discrete_GraphicsLevel *levels =3D
>                         smu_data->smc_state_table.GraphicsLevel;
>         uint32_t i, max_entry;
> -       uint8_t hightest_pcie_level_enabled =3D 0,
> +       uint8_t highest_pcie_level_enabled =3D 0,
>                 lowest_pcie_level_enabled =3D 0,
>                 mid_pcie_level_enabled =3D 0,
>                 count =3D 0;
> @@ -1114,27 +1114,27 @@ static int polaris10_populate_all_graphic_levels(=
struct pp_hwmgr *hwmgr)
>         } else {
>                 while (hw_data->dpm_level_enable_mask.pcie_dpm_enable_mas=
k &&
>                                 ((hw_data->dpm_level_enable_mask.pcie_dpm=
_enable_mask &
> -                                               (1 << (hightest_pcie_leve=
l_enabled + 1))) !=3D 0))
> -                       hightest_pcie_level_enabled++;
> +                                               (1 << (highest_pcie_level=
_enabled + 1))) !=3D 0))
> +                       highest_pcie_level_enabled++;
>
>                 while (hw_data->dpm_level_enable_mask.pcie_dpm_enable_mas=
k &&
>                                 ((hw_data->dpm_level_enable_mask.pcie_dpm=
_enable_mask &
>                                                 (1 << lowest_pcie_level_e=
nabled)) =3D=3D 0))
>                         lowest_pcie_level_enabled++;
>
> -               while ((count < hightest_pcie_level_enabled) &&
> +               while ((count < highest_pcie_level_enabled) &&
>                                 ((hw_data->dpm_level_enable_mask.pcie_dpm=
_enable_mask &
>                                                 (1 << (lowest_pcie_level_=
enabled + 1 + count))) =3D=3D 0))
>                         count++;
>
>                 mid_pcie_level_enabled =3D (lowest_pcie_level_enabled + 1=
 + count) <
> -                               hightest_pcie_level_enabled ?
> +                               highest_pcie_level_enabled ?
>                                                 (lowest_pcie_level_enable=
d + 1 + count) :
> -                                               hightest_pcie_level_enabl=
ed;
> +                                               highest_pcie_level_enable=
d;
>
> -               /* set pcieDpmLevel to hightest_pcie_level_enabled */
> +               /* set pcieDpmLevel to highest_pcie_level_enabled */
>                 for (i =3D 2; i < dpm_table->sclk_table.count; i++)
> -                       levels[i].pcieDpmLevel =3D hightest_pcie_level_en=
abled;
> +                       levels[i].pcieDpmLevel =3D highest_pcie_level_ena=
bled;
>
>                 /* set pcieDpmLevel to lowest_pcie_level_enabled */
>                 levels[0].pcieDpmLevel =3D lowest_pcie_level_enabled;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c b/dri=
vers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
> index 34c9f59b8..3e73f380a 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
> @@ -878,7 +878,7 @@ static int vegam_populate_all_graphic_levels(struct p=
p_hwmgr *hwmgr)
>         struct SMU75_Discrete_GraphicsLevel *levels =3D
>                         smu_data->smc_state_table.GraphicsLevel;
>         uint32_t i, max_entry;
> -       uint8_t hightest_pcie_level_enabled =3D 0,
> +       uint8_t highest_pcie_level_enabled =3D 0,
>                 lowest_pcie_level_enabled =3D 0,
>                 mid_pcie_level_enabled =3D 0,
>                 count =3D 0;
> @@ -925,27 +925,27 @@ static int vegam_populate_all_graphic_levels(struct=
 pp_hwmgr *hwmgr)
>         } else {
>                 while (hw_data->dpm_level_enable_mask.pcie_dpm_enable_mas=
k &&
>                                 ((hw_data->dpm_level_enable_mask.pcie_dpm=
_enable_mask &
> -                                               (1 << (hightest_pcie_leve=
l_enabled + 1))) !=3D 0))
> -                       hightest_pcie_level_enabled++;
> +                                               (1 << (highest_pcie_level=
_enabled + 1))) !=3D 0))
> +                       highest_pcie_level_enabled++;
>
>                 while (hw_data->dpm_level_enable_mask.pcie_dpm_enable_mas=
k &&
>                                 ((hw_data->dpm_level_enable_mask.pcie_dpm=
_enable_mask &
>                                                 (1 << lowest_pcie_level_e=
nabled)) =3D=3D 0))
>                         lowest_pcie_level_enabled++;
>
> -               while ((count < hightest_pcie_level_enabled) &&
> +               while ((count < highest_pcie_level_enabled) &&
>                                 ((hw_data->dpm_level_enable_mask.pcie_dpm=
_enable_mask &
>                                                 (1 << (lowest_pcie_level_=
enabled + 1 + count))) =3D=3D 0))
>                         count++;
>
>                 mid_pcie_level_enabled =3D (lowest_pcie_level_enabled + 1=
 + count) <
> -                               hightest_pcie_level_enabled ?
> +                               highest_pcie_level_enabled ?
>                                                 (lowest_pcie_level_enable=
d + 1 + count) :
> -                                               hightest_pcie_level_enabl=
ed;
> +                                               highest_pcie_level_enable=
d;
>
> -               /* set pcieDpmLevel to hightest_pcie_level_enabled */
> +               /* set pcieDpmLevel to highest_pcie_level_enabled */
>                 for (i =3D 2; i < dpm_table->sclk_table.count; i++)
> -                       levels[i].pcieDpmLevel =3D hightest_pcie_level_en=
abled;
> +                       levels[i].pcieDpmLevel =3D highest_pcie_level_ena=
bled;
>
>                 /* set pcieDpmLevel to lowest_pcie_level_enabled */
>                 levels[0].pcieDpmLevel =3D lowest_pcie_level_enabled;
> --
> 2.34.1
>

