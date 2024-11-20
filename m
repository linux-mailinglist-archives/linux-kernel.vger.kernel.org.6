Return-Path: <linux-kernel+bounces-415885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DA09D3D92
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135291F2273F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AD2174EDB;
	Wed, 20 Nov 2024 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2v+6I6S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7C21A76C4;
	Wed, 20 Nov 2024 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732112989; cv=none; b=LGZI2YCgPuPv8Qzmu0oJX+aBKZc7GRy4f5THMkvxvX+K18aplnkPw4MUAg0ptXygKPCfWwqhWIJRMTAUhCovMfSooq/oZw7bBnpLZylEXx8ekEbQmOcB5k0/dwNS/0zDPKdg2NmPsSbpDQ1AptMwx3HYmmeppOMQze7tbaF6Leg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732112989; c=relaxed/simple;
	bh=E3SCFt2aP8soC2dbkMLFMLoGhCfGpNlFOSTRpOtTPrE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=ncxp1diqSn3gjlKawLZzc3f6pTXMNYyQ9Yr/8rfM9PV2Hffy4oYjyaNZ89hoTszFPrklrGBbJWgn8Zj5un2z3CZK+OYmpqgY47xHB0YFLZ9c6yDL+Vm85doT6R5VUxeptt5AHuYhyLWBkqIfpbAcgvlSGItCUBFw2pOxVVpOas8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2v+6I6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82D1C4CECD;
	Wed, 20 Nov 2024 14:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732112988;
	bh=E3SCFt2aP8soC2dbkMLFMLoGhCfGpNlFOSTRpOtTPrE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Y2v+6I6SsDvnrNk8t/oeMHqMxN6BB6bya1x4af5bacX9K1VRoCuOCrdbxeXywPhlj
	 +Kfun/G8dCd7C/UXNWavt9g7BWaJOCX0adhXbd0PV3UedjjlP2uNfAyBtPxlWqn33i
	 zdw8J+j2mPeiq7V2dcdk2t+upnzSN7JYYnXgAokVSOLikqsTjbczWCwjqXW8NH6Iag
	 wP9TDlAU+NNk+G4jaOQfXeVEFFaCMhGi7w0KRKbQtHP0PI5VT1k46CvVZFdpmXogLB
	 1PaQbAGdOC4DWu714UMmgdt+4zW48n+bZ1lKHAoe8a4AdIulorZ4Z/GbxXSbCg/VmR
	 TnmKzPb3FSaQQ==
Date: Wed, 20 Nov 2024 08:29:47 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: tzimmermann@suse.de, conor+dt@kernel.org, matthias.bgg@gmail.com, 
 airlied@gmail.com, simona@ffwll.ch, linux-mediatek@lists.infradead.org, 
 p.zabel@pengutronix.de, mripard@kernel.org, chunkuang.hu@kernel.org, 
 ck.hu@mediatek.com, linux-arm-kernel@lists.infradead.org, 
 kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, krzk+dt@kernel.org, 
 maarten.lankhorst@linux.intel.com, dri-devel@lists.freedesktop.org
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20241120124512.134278-3-angelogioacchino.delregno@collabora.com>
References: <20241120124512.134278-1-angelogioacchino.delregno@collabora.com>
 <20241120124512.134278-3-angelogioacchino.delregno@collabora.com>
Message-Id: <173211298701.771700.9734039519570659117.robh@kernel.org>
Subject: Re: [PATCH v1 2/7] dt-bindings: display: mediatek: Add binding for
 MT8195 HDMI-TX v2


On Wed, 20 Nov 2024 13:45:07 +0100, AngeloGioacchino Del Regno wrote:
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
>  .../mediatek/mediatek,mt8195-hdmi.yaml        | 150 ++++++++++++++++++
>  1 file changed, 150 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi.example.dtb: hdmi-tx@1c300000: Additional properties are not allowed ('#sound-dai-cells' was unexpected)
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,mt8195-hdmi.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241120124512.134278-3-angelogioacchino.delregno@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


