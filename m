Return-Path: <linux-kernel+bounces-372595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A22F19A4AD1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 03:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99641C21BC0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 01:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2456319924F;
	Sat, 19 Oct 2024 01:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NRAAFdEX"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F4F1922D9
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 01:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729300751; cv=none; b=h9ECPFbt0uOkKzUfoG1VTMFVI329zPXq/u/CJtiEMFg+tK+n4k6ASVgBOU1AroxQmmDgHGDO5ltVGgT8jo5eRKnb41PETnl8L+H5P5vJ1iQhlczxazq8GkRKjvjOTZGtpUqEN7A2TEin5f/GGk3Ah4TgeRJntrNlhjMvjGjYD70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729300751; c=relaxed/simple;
	bh=+XLthAOUfG31WvVPG6FMHA0Fuz0mQE5OctefTN2qrrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2niYfGLTgmlAsoUP9bSGNdk0cYYd3LNk0uKV0Hf7VuoNfDGXmv1fQ2eGtIPT8n+laf3TuYDFUR6SQEnNFOWxEKKyoOK43QHlJ0z38ev06fiUGfONpLSBmUYlzREthP3RUt2TX0nAnheU5v+PzkHMbqJsd00ckyFF02pLl0cYIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NRAAFdEX; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e3b7b3e9acso25316587b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 18:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729300748; x=1729905548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqmN+Pv+ZkLGAVjFOcuodLYBgxnH70IFWhBIjkIvZIA=;
        b=NRAAFdEXd2T0FdtaeOQKQ54IotK4dITG957zdpdi5dUWG73mRgeNqhSl0jYFcThTfu
         1NaSjPYFqFSL5i4qIZ3okOrGlwd6NBMXmGmqFDmhdyAXKUOoPv6HCyptaim7SBcNe/nu
         TOsr+0ajDERLtNxRim8YdVf8v4rxdqFqJXNRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729300748; x=1729905548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqmN+Pv+ZkLGAVjFOcuodLYBgxnH70IFWhBIjkIvZIA=;
        b=BjLz6uCqtYVkC8X0ImQFTVefGq0le6ScY7GXY4zOTOsAg4YJFVaw6Wch1angLqYHr+
         0VWpVlxXvUFKPBaNOduhIUmcG//QMT0dRKQomcsg7HhDZetMHHuSs/sSAPWi59Opg9qI
         Q255T39MtlRGIFW8EJBPo9eHYMvPe/GVtx7AaGA5X7KJTDBcyzwd1jfedJ2MW/ftmWHu
         nyljQzKWQgftbHUHSIuEaCQBPK/fHmPSN6ma3mEu2QJS4PvL5aCkUGcItw5QwihI/ZEX
         ywcmDO7JHnlJ1PLlIPdl5ftO0hBs566J4x2HUBQDpI5wvdXEBZvj2o/ndvrNA5nlP/w6
         dpMg==
X-Forwarded-Encrypted: i=1; AJvYcCVNcGjDM4/jprdvvFFAXK/vtKVNZLq29LWS0n8U0hVRhcJ3DD9lr6Ds/AnI53dJQdcw4kvSbaRNkEsNSSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrDRWemt1rEFGqicRzgs4WQ9WlXlW5NkEX4vNdJhBzSFN11hff
	7oEfr7xgoL0A6HQojjW4IcGwLuY/4ayZZ2h737MKslGw3J5RNb/wDdOnM9xPW4eLVR+OG0g2HFR
	L1zH5xNNGIGLv+VNx08CRMDgycpQ6+/AqUNxv
X-Google-Smtp-Source: AGHT+IHJIDotEBqysnywDOX1fj18ueDufCKbPGiOJRzKcwmzpCSI2hijWJkoHfy4063NVRqBiN9mNe9g5L5dPCK45tE=
X-Received: by 2002:a05:690c:28f:b0:6e2:313a:a022 with SMTP id
 00721157ae682-6e5bfe94d4bmr47875317b3.33.1729300748516; Fri, 18 Oct 2024
 18:19:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018091135.17075-1-xiazhengqiao@huaqin.corp-partner.google.com>
 <172925540039.17739.8191775806524492819.robh@kernel.org>
In-Reply-To: <172925540039.17739.8191775806524492819.robh@kernel.org>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Fri, 18 Oct 2024 18:18:42 -0700
Message-ID: <CAJMQK-j7maS3_kRLTAiEow5dNP7422jdJ0HKSRyJmc_Eay3zvA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] arm64: dts: mediatek: Add MT8186 Chinchou
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>, devicetree@vger.kernel.or, 
	wenst@chromium.org, matthias.bgg@gmail.com, 
	linux-mediatek@lists.infradead.org, angelogioacchino.delregno@collabora.com, 
	sean.wang@mediatek.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 5:52=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
>
> On Fri, 18 Oct 2024 17:11:32 +0800, Zhengqiao Xia wrote:
> > This is v2 of the MT8186 Chromebook device tree series to support
> > MT8186 chinchou platform. It is based on the "corsola" design.
> > It includes chinchou and chinchou360, including LTE, stylus,
> > touchscreen combinations.
> >
> > Changes in v2:
> > - Modify location of "const: google,chinchou-sku17" in mediatek.yaml
> > - rename "pin-report" to "pin-report-pins"
> > - add "vcc33-supply" and "vcc33-supply"
> > - rename "cbj-sleeve-gpio" to "cbj-sleeve-gpios"
> > - modify subnode of sound
> > - Link to v1: https://lore.kernel.org/all/172900161180.733089.896354374=
5385219831.robh@kernel.org/
> >
> > Zhengqiao Xia (3):
> >   dt-bindings: arm: mediatek: Add MT8186 Chinchou Chromebook
> >   arm64: dts: mediatek: Add MT8186 Chinchou Chromebooks
> >   arm64: dts: mediatek: Add exton node for DP bridge
> >
> >  .../devicetree/bindings/arm/mediatek.yaml     |  29 ++
> >  arch/arm64/boot/dts/mediatek/Makefile         |   3 +
> >  .../mediatek/mt8186-corsola-chinchou-sku0.dts |  18 +
> >  .../mediatek/mt8186-corsola-chinchou-sku1.dts |  35 ++
> >  .../mt8186-corsola-chinchou-sku16.dts         |  29 ++
> >  .../dts/mediatek/mt8186-corsola-chinchou.dtsi | 321 ++++++++++++++++++
> >  .../boot/dts/mediatek/mt8186-corsola.dtsi     |   6 +
> >  7 files changed, 441 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chincho=
u-sku0.dts
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chincho=
u-sku1.dts
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chincho=
u-sku16.dts
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chincho=
u.dtsi
> >
> > --
> > 2.17.1
> >
> >
> >
>
>
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
>
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>
>   pip3 install dtschema --upgrade
>
>
> New warnings running 'make CHECK_DTBS=3Dy mediatek/mt8186-corsola-chincho=
u-sku0.dtb mediatek/mt8186-corsola-chinchou-sku1.dtb mediatek/mt8186-corsol=
a-chinchou-sku16.dtb' for 20241018091135.17075-1-xiazhengqiao@huaqin.corp-p=
artner.google.com:
>
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dtb: pmic: 'cod=
ec' does not match any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt639=
7.yaml#
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dtb: pmic: 'cod=
ec' does not match any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt639=
7.yaml#
> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dtb: pmic: 'co=
dec' does not match any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt639=
7.yaml#
>

hi Zhengqiao,

This appears after
https://patchwork.kernel.org/project/linux-mediatek/patch/20241001104145.24=
054-3-macpaul.lin@mediatek.com/.
To avoid this warning, change `codec` in pmic (in mt8186-corsola.dtsi)
to `audio-codec`, though this is not caused by this series.

>
>
>
>

