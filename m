Return-Path: <linux-kernel+bounces-354469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C9F993DD5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 06:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2672861A4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 04:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E72A770FE;
	Tue,  8 Oct 2024 04:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ADK86T6k"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87D23F9FB
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 04:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728360943; cv=none; b=FjAggj9GfPnBq3ARpPXLQtltbGKZjazhu0gbKVSp8zn7mFxW63OGPWKhFpau0QXm5MqJ0/MrWST/r/G3cOdAULi5fozFBzXRrPcxvfOZW+XEFe9j2hDODDp5FUrblAJozBzPh9GUKYkXLT+QTxefoHr7ZgQ3AumAzZi95Y+eyJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728360943; c=relaxed/simple;
	bh=Hgr3I5RZM7oiROcK9XaiQXhfHpCJhshsfreqAT1t6n0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bL1mUmCjJ4ZZJMORzcnYVZ0d7fcSFNUr7J9EVMZMy4VP0JpknKsJE/Gy7f+EO34iMwGCit8L4SS5cXh7ZS9mCl6Wd2hZFndYUnLeZAsgkREwIvkYRRg2xpBatoMeMIEybD2h/00BV/UE6w/popwmK8NPHYJX8YBUC/esHGk2LmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ADK86T6k; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5399675e14cso5885525e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 21:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728360940; x=1728965740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsgypzMnr8s549OvOvjEHy3rmXs4vBQB+7vyfPc71L0=;
        b=ADK86T6kV9fZr8M+Oo0b87WGkTs9tv3LasCuKrljQJVyhJdxk+Q2IrrbH2lv9GpdBC
         +m1n4wx3rpHX9sUma5VCHADeF8LznkSji/rN3Y0Uwwuf+tetX7kwSLNz1bZmbtn4wMer
         bzuDKLYc/CBW7epuShU6QHPFQLNSvBdPKobU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728360940; x=1728965740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsgypzMnr8s549OvOvjEHy3rmXs4vBQB+7vyfPc71L0=;
        b=Dcts/aooAo1RAgeiVSO2M0gwrF9six0YpC8KEVmPHgTuzDWTWPPM2+f/jxhEeYoiSQ
         gr6b5fE7PAX8dhB/VcgIykt2p/EfbVNIunSkNWY3tcZcW0qJncN/xex0viIUYSQXz5C8
         MfBQz9/20GHJ4mQXBS1P9JQQ0p9msBRwe8tJ94fu/0uG2zPx/iI75AScbE9oYPh3YL14
         wR97wHMN/ZN5wT9Wbtqk/NmYFZFfdz4VxnchZwbTxRM0bllHjKl4teV2f4IL1T3aRQjh
         BovFe5xMWa8xd6f2MsAvloBFytnePrNsv2Fq325rT1vOF7A7+HofBuTMj8wQTzFcyQ/s
         VioQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXZ6meo0rj63L2OVG3s7rl2niw4uztCHVXnYaU/LBrOoGBNpZjgl0K62FDRayGPbrJe0jccqHwzoewP1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5oXUqeCkyCYfY/SMp5K/AT+c+DBRBuMV2e4uW1/IKIL/1pLbJ
	Bh/2VcbJvDW4Kq2wv7q2lfs2AR7f6f/x8zTfXwyhmNAdSzm55OD62odjoQWy/I2cFJF8bbKR9LI
	guFvIYA6dmg1szKhO7K96vi5eAW04ubuxzb8d
X-Google-Smtp-Source: AGHT+IH5L+vBThATfCj0naB/bXXgVGLsu0H6B6nI/GfouA1KFBjppbhu47esWrYoxk0NZzfhr9MWJDBe2RWeLpV4zC0=
X-Received: by 2002:a05:6512:308f:b0:539:986e:cd68 with SMTP id
 2adb3069b0e04-539ab9ec4eemr6211095e87.60.1728360939666; Mon, 07 Oct 2024
 21:15:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007070101.23263-1-jason-jh.lin@mediatek.com>
In-Reply-To: <20241007070101.23263-1-jason-jh.lin@mediatek.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 8 Oct 2024 12:15:28 +0800
Message-ID: <CAGXv+5GzmWhs1ZiNtty1eH2h9n7bw-EeAdZQvXaBLMUA5cUuzg@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] Fix degradation problem of alpha blending series
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

On Mon, Oct 7, 2024 at 3:01=E2=80=AFPM Jason-JH.Lin <jason-jh.lin@mediatek.=
com> wrote:
>
> Some SoCs do not support the ignore_pixl_alpha flag, which breaks the
> XRGB8888 format. Some SoCs do not support pre-multiplied pixel formats
> and extending configuration of OVL pre-multiplied color formats,
> such as MT8173.
>
> Fix the SoC degradation problem by this sreies.

The series fixes the display color issue on MT8173. Tested on Hana
Chromebook (Telesu).

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
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

