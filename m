Return-Path: <linux-kernel+bounces-174240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6C98C0C06
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC021C2137F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 07:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1BA149C4E;
	Thu,  9 May 2024 07:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOAsEd7P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CEB26AE7;
	Thu,  9 May 2024 07:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715240237; cv=none; b=aWOCx+Qd03mUsTWh000I52yQrieetbB9Odw9vJNqs5uy1f9juO6jfYAhoTuoWMs+FlHFjZWgo+fkX4FoJ8aZQDRyY3qF//6+YkJCbVo/8yHx5Ws+WSK0jTW1HhzHTc2il5m7cgVe+QPERVmI7Sgh6wvQcYAOAKFDQ2vksbBMh54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715240237; c=relaxed/simple;
	bh=qk2+IBmDngaDBCJU7AWu8KKJZ2Rxhc2kyG9HF1G1JBg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=pEPlMX2H6VPvCD4XhABwKnyhZ/yF7pPJvisv3PC3yJVIbXSLGw567lnIH216MJqcrvOTHgN4Wx0LavhwhezDYuXZ8LZsHBjyZtPzVd4qCse/MXZ1/n2gioWeq+N7D9pvHkN8dADTQ/ZaVXoBIpspdCQm3LkByEH6yABvUI94BFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOAsEd7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3EC6C116B1;
	Thu,  9 May 2024 07:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715240237;
	bh=qk2+IBmDngaDBCJU7AWu8KKJZ2Rxhc2kyG9HF1G1JBg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=oOAsEd7PQJIoZ2Vr4Q5rpV1oePjIklqIWCXS8FlQab75d64GDWCB8eUa5P55ZeyQD
	 s0XWc8mGImqVD5UyZP9uXkGUmPKRyyCqC4+YYHq5rQta7obsKDM3GmmBFlD6PRYxtS
	 xpV8tZpda60FRWM491//iijyjJWzvd0sbsvOd3UmUwekPdk6tYzGIDln7JZSqH9tFr
	 IzNZrca1dt4rYw9pjk5FnvoFvM23bUJv7LNZozAu3NCtlzeErQOjwQ0V4R9rVDFCZb
	 vf2MsxLB0Y10AHcRi7X3IOm4uxjqr0sd6Y2VNxkBmZmAVirDLPIGiQt0pFge40JtTT
	 hp4/O84Z3NyPA==
Date: Thu, 09 May 2024 02:37:15 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: kernel@pengutronix.de, imx@lists.linux.dev, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, conor+dt@kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, vkoul@kernel.org, 
 robh+dt@kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, frank.li@nxp.com, kishon@kernel.org
In-Reply-To: <1715234181-672-3-git-send-email-hongxing.zhu@nxp.com>
References: <1715234181-672-1-git-send-email-hongxing.zhu@nxp.com>
 <1715234181-672-3-git-send-email-hongxing.zhu@nxp.com>
Message-Id: <171524023506.3993776.14373949922426519018.robh@kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: phy: Add i.MX8Q HSIO SerDes PHY
 binding


On Thu, 09 May 2024 13:56:20 +0800, Richard Zhu wrote:
> Add i.MX8QM and i.MX8QXP HSIO SerDes PHY binding.
> Introduce one HSIO configuration 'fsl,hsio-cfg', which need be set at
> initialization according to board design.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../bindings/phy/fsl,imx8qm-hsio.yaml         | 142 ++++++++++++++++++
>  1 file changed, 142 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8qm-hsio.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
/Documentation/devicetree/bindings/phy/fsl,imx8qm-hsio.yaml:54:13: [error] string value is redundantly quoted with any quotes (quoted-strings)
/Documentation/devicetree/bindings/phy/fsl,imx8qm-hsio.yaml:54:22: [error] string value is redundantly quoted with any quotes (quoted-strings)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1715234181-672-3-git-send-email-hongxing.zhu@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


