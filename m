Return-Path: <linux-kernel+bounces-302079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02CE95F992
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A76528418F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCB219923D;
	Mon, 26 Aug 2024 19:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJtPsGt6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F65D17ADF7;
	Mon, 26 Aug 2024 19:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724700058; cv=none; b=mJdSheQlBRdK39r4Y/im7RfP5yNXyGEqs8iSsck4LmD0UeyYEZ6H1Mpz2QSsgjsWkAcpKZLTUryDO6mxAetrO1nHA64xcEaQAyfukUt7xjTfFtBqrdd6YriSoB4MXBUgNRJLAXSy7CwcN8JGCcFYXB1F+VoHa37ApstdQN6LeW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724700058; c=relaxed/simple;
	bh=e5L3wYQXslcAldjDgB0xLPod6k8xfJvpJvmEBAIjTig=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=E/SNRNFjROwpl5aSKRsy0Vvvc7Bu9D+NNJxjsEQDphu3q6B7WUTcA/Ssi/VxFPOH4lRx9u9euOOAanehGADj9fe3wrPRPfAXAt0sye5ECd7WPmz7bAHUti9YCA+Q847XjULMZNsgX8PnIQXaUBrspVGF/DkXl9/vWhkz/bfuGAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJtPsGt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F35C4FF75;
	Mon, 26 Aug 2024 19:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724700058;
	bh=e5L3wYQXslcAldjDgB0xLPod6k8xfJvpJvmEBAIjTig=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=XJtPsGt6J3unqn9vRE47ArCyOPq3xHIvWaE/A+0gLiaZa0wVOUeXUviGaH8zkg8Op
	 Ur8japgzEQq+z/85Q7+vi+nJ3mQr86bishkqvv6+/G8xoWwH5/nO+hAwQZpkSS8Tor
	 4LQUWQmUaO8amy9SIAh0oVehALoiQzdzzIAeEQAgPR/aX2R1NjJwBrcIgkkPNv1u8t
	 6MU3N7cHrhC4mgoRwWxJ6FpM/KkPVbptiaCSZ0U2gYeFuSJIDd+aFS2gf23D3Ctpet
	 1cIASjdcx6ZpS9bNEPzT8wMcNKS4omqaSNq4Pp+HVCFCaNFxnQhJW0fS16HY2qDAEW
	 nnP/xnNr0SHeQ==
Date: Mon, 26 Aug 2024 14:20:56 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Bao Cheng Su <baocheng.su@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>, 
 Hua Qian Li <huaqian.li@siemens.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Conor Dooley <conor+dt@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <f8e45e550687464e51697d96e345bbfe69b6044a.1724694969.git.jan.kiszka@siemens.com>
References: <cover.1724694969.git.jan.kiszka@siemens.com>
 <f8e45e550687464e51697d96e345bbfe69b6044a.1724694969.git.jan.kiszka@siemens.com>
Message-Id: <172470005601.1418853.8269569024831474469.robh@kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: soc: ti: Add AM65 peripheral
 virtualization unit


On Mon, 26 Aug 2024 19:56:05 +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> The PVU allows to define a limited set of mappings for incoming DMA
> requests to the system memory. It is not a real IOMMU, thus hooked up
> under the TI SoC bindings.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  .../bindings/soc/ti/ti,am654-pvu.yaml         | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml: 'maintainers' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/pci/ti,am654-pvu.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.example.dtb: ti-pvu@30f80000: reg: [[0, 821559296], [0, 4096], [0, 905969664], [0, 1048576]] is too long
	from schema $id: http://devicetree.org/schemas/pci/ti,am654-pvu.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/f8e45e550687464e51697d96e345bbfe69b6044a.1724694969.git.jan.kiszka@siemens.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


