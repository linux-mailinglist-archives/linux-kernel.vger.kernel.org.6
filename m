Return-Path: <linux-kernel+bounces-398462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2758A9BF19F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E071F23736
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155622036E1;
	Wed,  6 Nov 2024 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj5Avv+X"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E72A202F8A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906893; cv=none; b=uiO7c4N47rB0T5GiNoOgV8CPgTJoMGrdC/mxckai9hMSIjGWY/hSBGsMvAj0rQlbNOphm72mun8kPI3Rtk74or1/0l3WmiGDZdcn+lrdtChZ/wfeNbzQ1+o1d8RPtSDulloERePZNj0FUTk1nTA18i91yG/0t/Ss6lDsLDrRidU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906893; c=relaxed/simple;
	bh=/W5dop3JtnhOvqMLIgQwRO1aGAJTJAhygD2zPBA4VgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tSlqs86WNYQjueIU3S/gOF2GYTa4WcSTo8byR4hjtFFAtO1vmwVeCTkJL8YA1qUGqvHoS9r6fHN+uBZKwgZxklRcTgrcylQP9+OTOYfWpRTDWDpLJl1kUB1h+WQ75Zufz1DaNm5EFKU9N/UMT4SoWmVOsa5PIbDfnkWQSux5RYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jj5Avv+X; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e5b1aaad96so693234a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 07:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730906891; x=1731511691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiAwPg/dN01XsDKcD/hhNuHEhhgaqX4CxxQ2uu8RZq0=;
        b=jj5Avv+Xk0dNDEkTHM4PlPLuzbQAI4fbUXVHBuylejtiDjVqhSE4P/6wo5f6oV0XZ1
         M/r2tHGGH2MBfEaH889WJIO1hrje0e4ZYkfWaSyoeuXyJ+QyzK0VItdBMP0Eh90Dm/Hi
         UxrWl/lNymEk5M49blOawwNlbCtfivdaM6VUkRoP+F+g+YgONfTGrcer61BtDIebiig+
         bmAYu2jMYW52jW7nM5ofniBRFCxST1Fd6tm8OoPwKJM8VTyqfZJrS2AqAaJPU9W5TcAE
         wVaKq1mopYNliVindxPK8ooJotck8e9V1AZYqhPchDG38k4N3zR7gb4wBgwg3RhVKkgD
         01xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730906891; x=1731511691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiAwPg/dN01XsDKcD/hhNuHEhhgaqX4CxxQ2uu8RZq0=;
        b=fuAaM7TAyBYLGo/EH/8RGd3oawqk+UBCBV3zVDYVUpNsHAXPTDN8bkaik7nMKlr0a5
         aRvqINi89wXwERAiB2VwEKWk5LPC+DFLSfNAGzHr2B29p9uaYOpu1O87KZVWhiyJIKET
         39GOM+c1ODeDhPpx434agMt8flImz2MhjmPxeyJgtTbkNhUrMPIMY18BgmQjGJhMlupz
         FUjD4dbRZO1ozZJMjbIP5HunnTTe0aWzbKRtmdriddrDJRNnfmS1vCubqYDjcl9JgPjX
         96KPI+PhFcZk5AwU2vqN8QVY8XjAcgY/R4nn20oBb7A4aPuOkmRxFRluf3SprJhKxMcY
         7NRg==
X-Forwarded-Encrypted: i=1; AJvYcCXVyR6YE5AH728iBMSLpSoztN5qWhe2D8VE9HUfm4CBZ3yD4du2g4em25OI6pscUngq7c0D3elXTnOcAhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGrdCtoRbNSdCX110ef0jAqVhsnr8asXiMl/lhyTT9w8MV+KDy
	UfJssz5iQgyyZcKTk1AXXOrlwnKqIOyGaazajEPSjRTSjQGTXWVQCA1KvboR8MzKN9nQYyGi2k7
	IWZYOikxX47odLFfO67SMB/MjvLw=
X-Google-Smtp-Source: AGHT+IG58L8HgQRHpeAKNtWFRdkUYwUsikvjZcJw4/75VbeI8S+hZusMEj43cQ7YI5XM+9OlGuX4GGmLXuCrNR/h61A=
X-Received: by 2002:a17:90a:1549:b0:2e3:1af7:6ead with SMTP id
 98e67ed59e1d1-2e8f11a9c22mr19824833a91.5.1730906891202; Wed, 06 Nov 2024
 07:28:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105140256.2465614-1-quzicheng@huawei.com> <20241105140256.2465614-3-quzicheng@huawei.com>
In-Reply-To: <20241105140256.2465614-3-quzicheng@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Nov 2024 10:27:59 -0500
Message-ID: <CADnq5_Nh8zQ2PE-vAd6BkKGho58DzdjBxEYv3Q1br9AuNyZesg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/display: Fix incorrect power gating
 configuration for DOMAIN11
To: Zicheng Qu <quzicheng@huawei.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, simona@ffwll.ch, Alvin.Lee2@amd.com, 
	chiahsuan.chung@amd.com, alex.hung@amd.com, wenjing.liu@amd.com, 
	Dillon.Varone@amd.com, george.shen@amd.com, mwen@igalia.com, yi-lchen@amd.com, 
	martin.leung@amd.com, yongqiang.sun@amd.com, tony.cheng@amd.com, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, tanghui20@huawei.com, zhangqiao22@huawei.com, 
	judy.chenhui@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 3:24=E2=80=AFAM Zicheng Qu <quzicheng@huawei.com> wr=
ote:
>
> The current implementation incorrectly updates DOMAIN11_PG_CONFIG with
> DOMAIN9_POWER_FORCEON, which is not the intended behavior. This patch
> corrects the power gating configuration by updating DOMAIN11_PG_CONFIG
> with DOMAIN11_POWER_FORCEON, preventing potential issues related to
> power management.

The bitfield is the same for both so there is no functional change.
This is just a cosmetic change to use the right bitfield macro.

Alex

>
> Fixes: 46825fcfbe16 ("drm/amd/display: avoid power gate domains that does=
n't exist")
> Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
> ---
>  drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/dr=
ivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
> index 67a77274d813..bc21eb0b2760 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
> @@ -327,7 +327,7 @@ void dcn20_enable_power_gating_plane(
>         if (REG(DOMAIN9_PG_CONFIG))
>                 REG_UPDATE(DOMAIN9_PG_CONFIG, DOMAIN9_POWER_FORCEON, forc=
e_on);
>         if (REG(DOMAIN11_PG_CONFIG))
> -               REG_UPDATE(DOMAIN11_PG_CONFIG, DOMAIN9_POWER_FORCEON, for=
ce_on);
> +               REG_UPDATE(DOMAIN11_PG_CONFIG, DOMAIN11_POWER_FORCEON, fo=
rce_on);
>
>         /* DCS0/1/2/3/4/5 */
>         REG_UPDATE(DOMAIN16_PG_CONFIG, DOMAIN16_POWER_FORCEON, force_on);
> --
> 2.34.1
>

