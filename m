Return-Path: <linux-kernel+bounces-175892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A178C26B7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870A51C21484
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DA916F90D;
	Fri, 10 May 2024 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rf2yhUfn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CF312C7E8;
	Fri, 10 May 2024 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350949; cv=none; b=IDVnZoUMAoz90WHuycBLuztZ+7Xhk0j9ShT3kj6Hx4Em+6MV4aOGHkFl9aSYUk+M6k9UdnJO6xDTNTqXunzVKBw51ZBsDqjLhPNVtzrGd2vViuBsS5llPLWhF2WqzIXJP9EjiFoPrFzDnKOuJXlWztp8lpWPvAhipKBrE6CSOAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350949; c=relaxed/simple;
	bh=oq2wm3Lbj4UkoA0P6JiSrXaZwpRiR7h5cZJSyLcveLU=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Xq+a+ti3UrOpbnSZ/CYCEkaiSshuzTwYqLC1VApfqy2HdVSRWQCcnQPFwtS6AvuamMsESmDB5LS3T8j9vhR6JkVeOQ14uPgNpxGJLppdF50ONg8/Wzlvrtff0+MOk9SG3Xsd8PxASkynfGpo1Nk8g67E++OWVorjwsjmt6Ny2SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rf2yhUfn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251C8C2BBFC;
	Fri, 10 May 2024 14:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715350948;
	bh=oq2wm3Lbj4UkoA0P6JiSrXaZwpRiR7h5cZJSyLcveLU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=rf2yhUfnqZaPF/0sD21fkyCkLbHrpaiKcdoCjQEamkpFp2lgaTuGTWar+R+glsnZo
	 Ce045If8KIQHEJIfTkChQ/oaBv1Qm8FkL3N4UO/SmJ8j8Eb6XotYTTb2tYcZz2b4xM
	 S+Ic5N7LATP6lVzYlmQxR5DN0Fo7/mSjhd5QOUqPjtYWN5511i93zr98Agun4qDlpT
	 /uAQ/4T6OI+95d9u16EfPiNLaDFQj7W7e9yEtCf3UM9dvlhEut7yOALR1X7ARsrURu
	 k1e/ygT/ohuhgdilPLv6TbPn3D+OrbmHQg41D7hb2UsWxreQon161OMlonPDRfmlb/
	 sBGVVwLHVIkeQ==
Date: Fri, 10 May 2024 09:22:26 -0500
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
Cc: linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, linux-doc@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20240510-imx-se-if-v1-2-27c5a674916d@nxp.com>
References: <20240510-imx-se-if-v1-0-27c5a674916d@nxp.com>
 <20240510-imx-se-if-v1-2-27c5a674916d@nxp.com>
Message-Id: <171535094644.45933.7938748436310737402.robh@kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: arm: fsl: add imx-se-fw binding doc


On Fri, 10 May 2024 18:57:28 +0530, Pankaj Gupta wrote:
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
>  .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 186 +++++++++++++++++++++
>  1 file changed, 186 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/firmware/fsl,imx-se.example.dtb: /example-2/v2x: failed to match any schema with compatible: ['fsl,imx95-v2x']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240510-imx-se-if-v1-2-27c5a674916d@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


