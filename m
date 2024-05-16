Return-Path: <linux-kernel+bounces-181589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BF38C7E00
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 23:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE081C21064
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 21:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC051586F6;
	Thu, 16 May 2024 21:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvumjN6Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34FD15821F;
	Thu, 16 May 2024 21:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715894545; cv=none; b=U5Cg/uzxlrXnQQLXApTb2MZibrLUGTSlivS7vVipZNkhIbmvN+7/chHUem8pm80CwvCZqhk1xhAkPKr7vSU7cTENcc1hztPvuzby/CqVckXe+un7dXkjHrIwbm1RkATogGVNmSvfGdrg3VG2q8tNfyGeTmPfBueF+peWjPWievM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715894545; c=relaxed/simple;
	bh=cSISbgkmxyD6+BUVKtX6e2T66hSdKGi2A1MglfvVZy0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=O494kQ2dcDwibMw6GTpsQZgJ4QtAgyBlNGbbM9Y/PfkKQPvIBekJKqc7S6J0m+ZhH+ybAQYit7tf9Y6eKzx1p5qtoF2vV/jftsp1lwjliPmYsxkZRgFdSxDN4T6bBTgEB8S3c9u5EK0zV7xf3MHkT324p8xNlcrEO2l82FD1Lf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvumjN6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFC5C4AF0E;
	Thu, 16 May 2024 21:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715894545;
	bh=cSISbgkmxyD6+BUVKtX6e2T66hSdKGi2A1MglfvVZy0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=DvumjN6ZJru1RWG+0DS5uHbDX+0i1o/DVMpqobBSrEg7iYUz26c4q6YewJ5BVcuTw
	 RIyiVgFGjaBsI5EJgJOuwWdVwLGX0qUAYhiE1BwRHynVTy5uIve3cxmBKCUTy6UM+k
	 MotuFfyS6E90YIsSGuUk6W8O4v2eVJaJAWtLYxd3SxwBbxE8N/eiqjOY13J0kksFRh
	 tQZ5KAmfJy40AmpzCLVvSaHjx86jvUoOEoPYroYMiez194AxPBeadhD2USNsVEoucw
	 FksB/zma+KxK1n/ApFuIApIVfpFqc8bawqNs89SQI2QMlYL8c6qYKCd1I2uRZ9GNDJ
	 cymQ2jglutopQ==
Date: Thu, 16 May 2024 16:22:24 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
 Conor Dooley <conor+dt@kernel.org>, laurentiu.mihalcea@nxp.com, 
 Lee Jones <lee@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 imx@lists.linux.dev, Shawn Guo <shawnguo@kernel.org>, 
 Liu Ying <victor.liu@nxp.com>, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240516204031.171920-4-laurentiumihalcea111@gmail.com>
References: <20240516204031.171920-1-laurentiumihalcea111@gmail.com>
 <20240516204031.171920-4-laurentiumihalcea111@gmail.com>
Message-Id: <171589454264.3876920.17534704607181963871.robh@kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: mfd: add schema for 8ulp's SIM


On Thu, 16 May 2024 23:40:30 +0300, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> Add schema for i.MX8ULP's SIM.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  .../bindings/mfd/nxp,imx8ulp-sim.yaml         | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/nxp,imx8ulp-sim.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/reset/nxp,imx8ulp-sim-reset.example.dtb: syscon@2da50000: 'mux-controller' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/nxp,imx8ulp-sim.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240516204031.171920-4-laurentiumihalcea111@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


