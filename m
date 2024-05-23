Return-Path: <linux-kernel+bounces-187467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 563C68CD242
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C6B11F22F3E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FFC1487F2;
	Thu, 23 May 2024 12:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3uPRWnb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D0713B5B1;
	Thu, 23 May 2024 12:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467129; cv=none; b=fO6maEGatpa6fL1URq3mqaZG0HFQ9xp1bhtt9GynTJqfCru8OR71l03PkLJOy/r/hdMK7dC8VKpdmYfJztESBzMCic61+7sOpaA0ysHiFgptxcu8cOzk9YvH4RbRgWIQho0weXRSkeogm3C9IgwC+lX8bR0bTBhQX9HBGiChRDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467129; c=relaxed/simple;
	bh=634cOFOD65tGG3cW/Dv64LlAod66RbAwHRiThD4dagg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=qT566RiPqvEpPdbCRlBUTEAuxpJ+WyzGHGgXcXEmRfjbgk+iyNiofQjSNHAx5cIMk8LqU3r0yPI1JuqXysEhyr2ewMCNreNWKK/66bTrFnrhnd1lEkuNscXa1F93p4QwvTCbt+B3rzihI/WS37ZhR/q9hwXF8Y8yzdYTHE7DYrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3uPRWnb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55492C2BD10;
	Thu, 23 May 2024 12:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716467128;
	bh=634cOFOD65tGG3cW/Dv64LlAod66RbAwHRiThD4dagg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=K3uPRWnbzmbBCCxHrhCweOvj1zOzly6hK6JSpQO0p0vTbpTOrhCZlVNzqvIkm0XKh
	 wj8i3qUozdrul3DtZx358q8nTvtxSBg4y/vC+19AEqUkeo7W6fUQKT0GFh0Ipm8vUk
	 x9ZW/y7dmTa+nUByIyXpFeUCzeDu1HGHSN21nJDVJnPFhWwe9iw6GMxWLWxm+fXITP
	 eH7DsDkn1EY32TOBGnphvLPVQwdYE9m7uPm80in8o8WrKXUuwTeq2uMKmqzFF9DG3Z
	 O0Wd/xbKWCnbaLrHMHN2GkHjRGc95kCEMaudy1tjZE3wDT6SBgjioA2yJVA0P6T8S3
	 3bEilVfQLCifQ==
Date: Thu, 23 May 2024 07:25:27 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, imx@lists.linux.dev, 
 Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
 linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>
In-Reply-To: <20240523-imx-se-if-v2-2-5a6fd189a539@nxp.com>
References: <20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com>
 <20240523-imx-se-if-v2-2-5a6fd189a539@nxp.com>
Message-Id: <171646712724.2026308.5404698488082776575.robh@kernel.org>
Subject: Re: [PATCH v2 2/5] dt-bindings: arm: fsl: add imx-se-fw binding
 doc


On Thu, 23 May 2024 16:19:33 +0530, Pankaj Gupta wrote:
> The NXP security hardware IP(s) like: i.MX EdgeLock Enclave, V2X etc.,
> creates an embedded secure enclave within the SoC boundary to enable
> features like:
> - HSM
> - SHE
> - V2X
> 
> Secure-Enclave(s) communication interface are typically via message
> unit, i.e., based on mailbox linux kernel driver. This driver enables
> communication ensuring well defined message sequence protocol between
> Application Core and enclave's firmware.
> 
> Driver configures multiple misc-device on the MU, for multiple
> user-space applications, to be able to communicate over single MU.
> 
> It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 154 +++++++++++++++++++++
>  1 file changed, 154 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/firmware/fsl,imx-se.example.dtb: /example-2/firmware/v2x-if@0: failed to match any schema with compatible: ['fsl,imx95-v2x']
Documentation/devicetree/bindings/firmware/fsl,imx-se.example.dtb: /example-2/firmware/v2x-if@1: failed to match any schema with compatible: ['fsl,imx95-v2x']
Documentation/devicetree/bindings/firmware/fsl,imx-se.example.dtb: /example-2/firmware/v2x-if@2: failed to match any schema with compatible: ['fsl,imx95-v2x']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240523-imx-se-if-v2-2-5a6fd189a539@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


