Return-Path: <linux-kernel+bounces-322796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9EE972E32
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33091C2482C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BE918BBAC;
	Tue, 10 Sep 2024 09:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C6ng2Oyn"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FABE18B484
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961214; cv=none; b=pYofhlvJ3EkH87hA7phj9P5/LdzjzrUDM1hRRLyzjqQvOZA8gwNiX8Wtsx2WgVY+xyoiEqTUEwDte2wGda4J4ygWkutH/PJiZoUa5tZDqrQ8xsiu6wUAwoL/4lCXlh1988vxMjg+WcT6t84iUyKQ6ptGJ/JBr0BMv2lJcF5ffes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961214; c=relaxed/simple;
	bh=sAnLe2PjUL4RFxQp9WeBVIf7OFTMARCb205Ut4q8ukY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zy2HKalA8LH1Vw+ykxu07fIZ97s1IxvloBcI5NZ/A7vYiQpCZqu+KPm77BsEes710QmMiDUDcYQFFSWiFB7AITot8aZwhfQjhV4hAISAzkANlOWOxmekQG/20uRfwoKy9+qjYrC9zZHbVCEBOyui5ye22R08iewc4NO+fSx+N3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C6ng2Oyn; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso70050381fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 02:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725961211; x=1726566011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiMIK8K+tyHKozmztV2/CvAPF0ELMWXt09xgTQVIEVU=;
        b=C6ng2OynyREdc2Y+HRzOz+HAn55EhEmTHWWZ4iYafLtiizT8ZJiSj8Lo2/tTxJA8Ov
         Rf7V1UW3VaiTCn+LerGMxc419+zX18aHJwEwpMdjIMmOitr4qApVEyPvEF85cfM4tIej
         eRPt/F3Cw3hxsOuj71d4UVe0wajd+FWRtDpTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725961211; x=1726566011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LiMIK8K+tyHKozmztV2/CvAPF0ELMWXt09xgTQVIEVU=;
        b=i59yPRrLQC36vlXlMkUtlAdQvgaFT8IxiNv2yJWQEBdPlrUYbqTmokW4/s2ylvgaS4
         /jvs4/rmjHPBLs6eXQLgri0XmGKCpFbttMPAk5IfkOrF+azR30yEIGK5zMcrKCLAXhcl
         mSW+hcTRsnhrmR75aXZTM8RSfzoShjnohYTnFlyCy6Re8ppVfvGK93h5/wdXx5EevTDv
         RT20yEQgE+7ARo33cznzaVgmRqBk2G3Y3BW0+ND+bd5rmUfrW6H38nQIalyPM/zYnu+s
         97pPKgiOIAfU6ks8SoUUPFniB1JYWGB/TFuh7gwPZRhRHXSzdX7AOain3GgmpWwHnOxS
         C2Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWCoUWHDyZ+UHT8iRQ/W8WKcOc6DZ2vQYVhBBUcMfqvAApweHvh5IFPSE2W0+RSJUJcIhhJ+YhuKr6gl78=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOZIHLrT6w0M4LR6HvBNHZKITMl8KQWqs20RWC/BZ3QPIfPbJT
	whfqUgBYIchn37tDqgryFC128OEFV7ZgoflEg1+qCH6ebpGHlP4/og2/QzmBviUijHaqOs6HNzK
	krVTzPZFDAp8m4zmhKqXLHVpexTNNZi7IIV85
X-Google-Smtp-Source: AGHT+IFVWniz1szQqlEAvk8g6KrRou2Nr2F1RqJkqQy9ONZmeOXzv2coEQAazzrYAJ3S9J3p1AzhEH1YxuZKWYYev7I=
X-Received: by 2002:a05:6512:3ca2:b0:533:45c9:67fe with SMTP id
 2adb3069b0e04-5365880bbbemr13331488e87.48.1725961210575; Tue, 10 Sep 2024
 02:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <01020191db2ac439-4e2dc95a-6323-4f0f-b9fc-c482948018a8-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020191db2ac439-4e2dc95a-6323-4f0f-b9fc-c482948018a8-000000@eu-west-1.amazonses.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 10 Sep 2024 17:39:59 +0800
Message-ID: <CAGXv+5Ff4+HS5_DSTX2U7SaCnZhWMWTN44wr+4_vYNrQQm_mDA@mail.gmail.com>
Subject: Re: [PATCH v9 0/3] drm/mediatek: Add support for OF graphs
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	matthias.bgg@gmail.com, shawn.sung@mediatek.com, yu-chang.lee@mediatek.com, 
	ck.hu@mediatek.com, jitao.shi@mediatek.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	kernel@collabora.com, sui.jingfeng@linux.dev, michael@walle.cc, 
	sjoerd@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 5:01=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Changes in v9:
>  - Rebased on next-20240910
>  - Removed redundant assignment and changed a print to dev_err()
>  - Dropped if branch to switch conversion as requested; this will
>    be sent as a separate commit out of this series.
>
> Changes in v8:
>  - Rebased on next-20240617
>  - Changed to allow probing a VDO with no available display outputs
>
> Changes in v7:
>  - Fix typo in patch 3/3
>
> Changes in v6:
>  - Added EPROBE_DEFER check to fix dsi/dpi false positive DT fallback cas=
e
>  - Dropped refcount of ep_out in mtk_drm_of_get_ddp_ep_cid()
>  - Fixed double refcount drop during path building
>  - Removed failure upon finding a DT-disabled path as requested
>  - Tested again on MT8195, MT8395 boards
>
> Changes in v5:
>  - Fixed commit [2/3], changed allOf -> anyOf to get the
>    intended allowance in the binding
>
> Changes in v4:
>  - Fixed a typo that caused pure OF graphs pipelines multiple
>    concurrent outputs to not get correctly parsed (port->id);
>  - Added OVL_ADAPTOR support for OF graph specified pipelines;
>  - Now tested with fully OF Graph specified pipelines on MT8195
>    Chromebooks and MT8395 boards;
>  - Rebased on next-20240516
>
> Changes in v3:
>  - Rebased on next-20240502 because of renames in mediatek-drm
>
> Changes in v2:
>  - Fixed wrong `required` block indentation in commit [2/3]
>
>
> The display IPs in MediaTek SoCs are *VERY* flexible and those support
> being interconnected with different instances of DDP IPs (for example,
> merge0 or merge1) and/or with different DDP IPs (for example, rdma can
> be connected with either color, dpi, dsi, merge, etc), forming a full
> Display Data Path that ends with an actual display.
>
> This series was born because of an issue that I've found while enabling
> support for MT8195/MT8395 boards with DSI output as main display: the
> current mtk_drm_route variations would not work as currently, the driver
> hardcodes a display path for Chromebooks, which have a DisplayPort panel
> with DSC support, instead of a DSI panel without DSC support.
>
> There are other reasons for which I wrote this series, and I find that
> hardcoding those paths - when a HW path is clearly board-specific - is
> highly suboptimal. Also, let's not forget about keeping this driver from
> becoming a huge list of paths for each combination of SoC->board->disp
> and... this and that.
>
> For more information, please look at the commit description for each of
> the commits included in this series.
>
> This series is essential to enable support for the MT8195/MT8395 EVK,
> Kontron i1200, Radxa NIO-12L and, mainly, for non-Chromebook boards
> and Chromebooks to co-exist without conflicts.
>
> Besides, this is also a valid option for MT8188 Chromebooks which might
> have different DSI-or-eDP displays depending on the model (as far as I
> can see from the mtk_drm_route attempt for this SoC that is already
> present in this driver).
>
> This series was tested on MT8195 Cherry Tomato and on MT8395 Radxa
> NIO-12L with both hardcoded paths, OF graph support and partially
> hardcoded paths, and pure OF graph support including pipelines that
> require OVL_ADAPTOR support.
>
> AngeloGioacchino Del Regno (3):
>   dt-bindings: display: mediatek: Add OF graph support for board path
>   dt-bindings: arm: mediatek: mmsys: Add OF graph support for board path
>   drm/mediatek: Implement OF graphs support for display paths
>
>  .../bindings/arm/mediatek/mediatek,mmsys.yaml |  28 ++
>  .../arm/mediatek/mediatek,mmsys.yaml.orig     | 140 ++++++++++
>  .../display/mediatek/mediatek,aal.yaml        |  40 +++
>  .../display/mediatek/mediatek,aal.yaml.orig   |  93 +++++++
>  .../display/mediatek/mediatek,ccorr.yaml      |  21 ++
>  .../display/mediatek/mediatek,ccorr.yaml.orig |  88 ++++++
>  .../display/mediatek/mediatek,color.yaml      |  22 ++
>  .../display/mediatek/mediatek,color.yaml.orig |  96 +++++++
>  .../display/mediatek/mediatek,dither.yaml     |  22 ++
>  .../mediatek/mediatek,dither.yaml.orig        |  87 ++++++
>  .../display/mediatek/mediatek,dpi.yaml        |  25 +-
>  .../display/mediatek/mediatek,dpi.yaml.orig   | 122 +++++++++
>  .../display/mediatek/mediatek,dsc.yaml        |  24 ++
>  .../display/mediatek/mediatek,dsi.yaml        |  27 +-
>  .../display/mediatek/mediatek,dsi.yaml.orig   | 126 +++++++++
>  .../display/mediatek/mediatek,ethdr.yaml      |  22 ++
>  .../display/mediatek/mediatek,gamma.yaml      |  19 ++
>  .../display/mediatek/mediatek,gamma.yaml.orig |  96 +++++++
>  .../display/mediatek/mediatek,merge.yaml      |  23 ++
>  .../display/mediatek/mediatek,merge.yaml.orig | 110 ++++++++
>  .../display/mediatek/mediatek,od.yaml         |  22 ++
>  .../display/mediatek/mediatek,ovl-2l.yaml     |  22 ++
>  .../mediatek/mediatek,ovl-2l.yaml.orig        |  78 ++++++
>  .../display/mediatek/mediatek,ovl.yaml        |  22 ++
>  .../display/mediatek/mediatek,ovl.yaml.orig   | 109 ++++++++
>  .../display/mediatek/mediatek,postmask.yaml   |  21 ++
>  .../display/mediatek/mediatek,rdma.yaml       |  22 ++
>  .../display/mediatek/mediatek,rdma.yaml.orig  | 122 +++++++++
>  .../display/mediatek/mediatek,ufoe.yaml       |  21 ++
>  .../display/mediatek/mediatek,wdma.yaml.orig  |  76 ++++++
>  .../bindings/gpu/arm,mali-bifrost.yaml.orig   | 250 +++++++++++++++++
>  .../bindings/leds/leds-mt6323.txt.orig        |  60 +++++
>  .../bindings/ufs/mediatek,ufs.yaml.orig       |  71 +++++
>  drivers/gpu/drm/mediatek/mtk_disp_drv.h       |   1 +
>  .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   |  40 ++-
>  drivers/gpu/drm/mediatek/mtk_dpi.c            |  21 +-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c        | 253 +++++++++++++++++-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h        |   2 +-
>  drivers/gpu/drm/mediatek/mtk_dsi.c            |  14 +-
>  39 files changed, 2433 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediat=
ek,mmsys.yaml.orig
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/me=
diatek,aal.yaml.orig
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/me=
diatek,ccorr.yaml.orig
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/me=
diatek,color.yaml.orig
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/me=
diatek,dither.yaml.orig
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/me=
diatek,dpi.yaml.orig
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/me=
diatek,dsi.yaml.orig
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/me=
diatek,gamma.yaml.orig
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/me=
diatek,merge.yaml.orig
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/me=
diatek,ovl-2l.yaml.orig
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/me=
diatek,ovl.yaml.orig
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/me=
diatek,rdma.yaml.orig
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/me=
diatek,wdma.yaml.orig
>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-bifros=
t.yaml.orig
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-mt6323.tx=
t.orig
>  create mode 100644 Documentation/devicetree/bindings/ufs/mediatek,ufs.ya=
ml.orig

It looks like you accidentally imported a bunch of files from Git.

ChenYu

>
> --
> 2.46.0
>

