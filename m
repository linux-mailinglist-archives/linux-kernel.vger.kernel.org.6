Return-Path: <linux-kernel+bounces-449911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDC69F57D9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE601891C96
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 20:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A651F9A99;
	Tue, 17 Dec 2024 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kirq7Q2L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547501F8EFF;
	Tue, 17 Dec 2024 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734467759; cv=none; b=b3x0T3G3EJ36sxoMtI23N7xyVy9VBTfPl8xBhmA/GitvcNVIFfAOCQS8ZT+i/NwNN9l8IvRG/Ncj9vlBDipy+ikvfiPOOrWWrdsKRgijemMKO53qvMDGV3Enlio8ZUCHjN+ZZN0kxz5gR3KsULMAqVhA+RTlj0BcZyvZZ+xEzMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734467759; c=relaxed/simple;
	bh=SZGp4CTjOcCd0WqvLX/C50ngjabrzlSD0TRHgdbC4BE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=tvVyebE0j1z0L4Tno53XpMJW/1gedRM6n95N3PmKA1iiXdHmQ/H1EQ5zEp7Mcgufs+No9WenpmBhv7ZH1cToVAugicZwfGdF1gMArJzqwYnnYeOOOVBLg/NljEBoF5MF8+P7V1zExcCcyOBnR/apcG8+TGC6C50vf8tP2u0PZmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kirq7Q2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871DEC4CED3;
	Tue, 17 Dec 2024 20:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734467758;
	bh=SZGp4CTjOcCd0WqvLX/C50ngjabrzlSD0TRHgdbC4BE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=kirq7Q2LQQV5FEB/0mqwL3QNWxPg7bH1f2k3Ek3ba/2d/H3SX/cfJH2oAP2ou8IhT
	 xO1LjRCc8CNQvlQMLtV/Vad2wYLQ4mskd+a8z+YrJ+SG7tJfs3vtyvnMJJ+RbhJQqU
	 aI3JOiN7Y7as2Izf1VzA1xn/noqhxMTAQ1SK6A7dZzHKRDg8foTzsPv7meNZlEEXY4
	 Hla0/QiSB+/dWJWBEW9eL2NYgcJvgypIQrrWJepWaME9j1v+VEw3Uc9Cfoyr72GIm1
	 YHzs9lRzlfiqkk4/wZo0lhlJ5j+Nh1JDjctClGWKbiEk5bgZfy7x9LSvBor3fac9qL
	 cdWJb/0fXU0fw==
Date: Tue, 17 Dec 2024 14:35:57 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org, 
 tzimmermann@suse.de, mripard@kernel.org, junzhi.zhao@mediatek.com, 
 simona@ffwll.ch, p.zabel@pengutronix.de, airlied@gmail.com, 
 linux-mediatek@lists.infradead.org, maarten.lankhorst@linux.intel.com, 
 matthias.bgg@gmail.com, kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org, 
 jie.qiu@mediatek.com, ck.hu@mediatek.com, krzk+dt@kernel.org, 
 chunkuang.hu@kernel.org, dri-devel@lists.freedesktop.org, 
 jitao.shi@mediatek.com
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20241217154345.276919-8-angelogioacchino.delregno@collabora.com>
References: <20241217154345.276919-1-angelogioacchino.delregno@collabora.com>
 <20241217154345.276919-8-angelogioacchino.delregno@collabora.com>
Message-Id: <173446775715.3082463.16696683643191966577.robh@kernel.org>
Subject: Re: [PATCH v3 07/33] dt-bindings: display: mediatek: Add binding
 for MT8195 HDMI-TX v2


On Tue, 17 Dec 2024 16:43:19 +0100, AngeloGioacchino Del Regno wrote:
> Add a binding for the HDMI TX v2 Encoder found in MediaTek MT8195
> and MT8188 SoCs.
> 
> This fully supports the HDMI Specification 2.0b, hence it provides
> support for 3D-HDMI, Polarity inversion, up to 16 bits Deep Color,
> color spaces including RGB444, YCBCR420/422/444 (ITU601/ITU709) and
> xvYCC, with output resolutions up to 3840x2160p@60Hz.
> 
> Moreover, it also supports HDCP 1.4 and 2.3, Variable Refresh Rate
> (VRR) and Consumer Electronics Control (CEC).
> 
> This IP also includes support for HDMI Audio, including IEC60958
> and IEC61937 SPDIF, 8-channel PCM, DSD, and other lossless audio
> according to HDMI 2.0.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../mediatek/mediatek,mt8195-hdmi.yaml        | 154 ++++++++++++++++++
>  1 file changed, 154 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi.yaml:
Error in referenced schema matching $id: http://devicetree.org/schemas/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi.example.dtb: hdmi-tx@1c300000: i2c: False schema does not allow {'compatible': ['mediatek,mt8195-hdmi-ddc'], 'clocks': [[4294967295]]}
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,mt8195-hdmi.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi.example.dtb: hdmi-tx@1c300000: i2c: Unevaluated properties are not allowed ('clocks', 'compatible' were unexpected)
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,mt8195-hdmi.yaml#
Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi.example.dtb: /example-0/soc/hdmi-tx@1c300000/i2c: failed to match any schema with compatible: ['mediatek,mt8195-hdmi-ddc']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241217154345.276919-8-angelogioacchino.delregno@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


