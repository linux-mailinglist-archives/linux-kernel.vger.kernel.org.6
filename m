Return-Path: <linux-kernel+bounces-376277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8329AA292
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7FD01F23070
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8246E19DF48;
	Tue, 22 Oct 2024 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hD22HcbC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA68219B3C5
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729601863; cv=none; b=dfbzcYWOEUJAQtfl/EAEPMqAV/JgCTr9UCdAWjeKUBczEZOSNN1PpBDVn286HPk3z7r7dsA7z2AOr2nuhtGVXSXaw8E/eL5zCttvjlyMeltcGXRhCZUcGlSGHdnIafWrz8wf0Fc8wJbRJVPvLXd2lxP8+D4K9AqGG54VX2KBLNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729601863; c=relaxed/simple;
	bh=GhYhjo2Z9FXBqZLMmzftfla/w2fS4jR3pdlc1PSB8Es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/tx1XN2HTivSDRqObukiWlkiqidqgAS715BNk/bDVNsQg3O94p60AnQlUOVB6CsXv7rv3K00k0EijOtDJc0irRUXNGtphmamQ9SnAd29XUZ5NVGDr7fiX2gZh6oMsvnmght5Edp1lcuuywJOQdf+q+1NJ/48Z7Wz+pPTtLIfQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hD22HcbC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BF2C4CEE9
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729601863;
	bh=GhYhjo2Z9FXBqZLMmzftfla/w2fS4jR3pdlc1PSB8Es=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hD22HcbCWYrNyjFqSykKO/nQN74Fjac40Zf+8kuy7rOWNtkb/jtjRbMHwEMoOGuFc
	 FhX2+GLUFrjEDxK2/vOBzAfa1hPa8PLEvmutycNrffhgCrkmes/+30m2KYxzR32E1V
	 Y/kNhRs2yGx9qGuGNjfmhA/uPBsA5bynDhgsaWpMJYob+SxBPeo2uJzk4FbhMCoEF3
	 W29Fi36i0zW3heIsmrxraC2HVXOpyrWPzR03zt+yF0pBX7Kk7pOvX056xxriEcVsXp
	 QdpamNnBKZo7mzYNsTMoQRSTvkejgQHfVlYB43tvHVW8sd0MjJ1nCFEG0csOhLmnHn
	 +HVdT+1FRaHRA==
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c6f492d2dso64364595ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 05:57:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5BUP/uxVJnxyzZjgt/QeBRtLFMbdFX42kfG/YRSck02W8AQq8lBOkScygtoCDGuPCaWjeB5Zw4zJ+AJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMt3JyVUh8UJaRgs08Xlp08CzdKB0I8xsnU9sK452cwFjS7mAe
	91AcBWn3r9/AVD3hVgnROozbWgLMeEN8PHlnP1u5rdeBkwyMp2FoTHPnyMQU/alUkZSMunv2Dg+
	dMpls7kAfGq/ByV7rU2au4xukhw==
X-Google-Smtp-Source: AGHT+IHDPBVccyietVt0eoOPH++rNW8m28x85sMWW+Dmxt+0VFr1aS34/bDRGwrVWPxtoil8Pjk3sREsZd5vx2UMbic=
X-Received: by 2002:a17:90b:1649:b0:2e2:a2f0:e199 with SMTP id
 98e67ed59e1d1-2e5616c543cmr16488894a91.8.1729601862855; Tue, 22 Oct 2024
 05:57:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009034646.13143-1-jason-jh.lin@mediatek.com>
In-Reply-To: <20241009034646.13143-1-jason-jh.lin@mediatek.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Tue, 22 Oct 2024 20:58:03 +0800
X-Gmail-Original-Message-ID: <CAAOTY__fuUpvFeFXZrmvmFAM+92a-UJ9-ye6hQZHS_BHXpbAUA@mail.gmail.com>
Message-ID: <CAAOTY__fuUpvFeFXZrmvmFAM+92a-UJ9-ye6hQZHS_BHXpbAUA@mail.gmail.com>
Subject: Re: [PATCH v11 0/5] Fix degradation problem of alpha blending series
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Cc: Adam Thiede <me@adamthiede.com>, Yassine Oudjana <yassine.oudjana@gmail.com>, 
	Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Shawn Sung <shawn.sung@mediatek.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jason:

Jason-JH.Lin <jason-jh.lin@mediatek.com> =E6=96=BC 2024=E5=B9=B410=E6=9C=88=
9=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8811:46=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Some SoCs do not support the ignore_pixl_alpha flag, which breaks the
> XRGB8888 format. Some SoCs do not support pre-multiplied pixel formats
> and extending configuration of OVL pre-multiplied color formats,
> such as MT8173.
>
> Fix the SoC degradation problem by this series.

For this series, applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>
> Change in v11:
> Fix typo in commit message.
>
> Change in v10:
> 1. Fix the commit message and comment for OVL_CON_AEN
>
> Change in v9:
> 1. Add the fix patch for the XRGB8888 downgrade issue of MT8173
> 2. Add the refine patch for ignore_pixel_alpha statement
>
> Change in v8:
> Remove blend_modes for not supported pre-multiplied SoCs to fix the
> return error from drm_plane_create_blend_mode_property().
>
> Change in v7:
> 1. Add the remove color format comment patch for OVL
> 2. Fix warning: 'const' type qualifier on return type has no effect
>
> Chnage in v6:
> 1. Use blend_modes instead of function pointer in OVL
> 2. Use ethdr instead of mdp_rdma to get blend_modes
> 3. Add 0 checking for adding blend_mode property for mtk_plane
>
> Change in v5:
> Add fix patch for mtk_plane
>
> Change in v4:
> Add lost cases of mtk_ovl_fmt_convert_with_blend
>
> Change in v3:
> Change MACRO approach to function pointer in driver data
>
> Change in v2:
> Fix build error and typo
>
> Change in v1:
> Add fix patch for OVL unsupport color format settings by driver data
>
> ---
>
> Jason-JH.Lin (5):
>   drm/mediatek: ovl: Fix XRGB format breakage for blend_modes
>     unsupported SoCs
>   drm/mediatek: ovl: Refine ignore_pixel_alpha comment and placement
>   drm/mediatek: ovl: Remove the color format comment for
>     ovl_fmt_convert()
>   drm/mediatek: ovl: Add blend_modes to driver data
>   drm/mediatek: Add blend_modes to mtk_plane_init() for different SoCs
>
>  drivers/gpu/drm/mediatek/mtk_crtc.c           |  1 +
>  drivers/gpu/drm/mediatek/mtk_ddp_comp.c       |  2 +
>  drivers/gpu/drm/mediatek/mtk_ddp_comp.h       | 10 +++
>  drivers/gpu/drm/mediatek/mtk_disp_drv.h       |  2 +
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c       | 70 ++++++++++++++-----
>  .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   |  7 ++
>  drivers/gpu/drm/mediatek/mtk_ethdr.c          |  7 ++
>  drivers/gpu/drm/mediatek/mtk_ethdr.h          |  1 +
>  drivers/gpu/drm/mediatek/mtk_plane.c          | 15 ++--
>  drivers/gpu/drm/mediatek/mtk_plane.h          |  4 +-
>  10 files changed, 92 insertions(+), 27 deletions(-)
>
> --
> 2.43.0
>

