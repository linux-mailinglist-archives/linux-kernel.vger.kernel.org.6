Return-Path: <linux-kernel+bounces-283181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7D194EE50
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 516E61C21BDC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C7217E473;
	Mon, 12 Aug 2024 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QARKBhky"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC44617E902;
	Mon, 12 Aug 2024 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723469654; cv=none; b=cSAJMyvd6vUVCRgM4VbCAbglTMSgyqO0tKb21rRSR0QBqFaGN+PXlAPBaSTDN6/FZm7R1Xmfc3xhAN5zDyWQPdiW3oApC7pGVFCTtAX4bMzU3UZxVtV1v7wDuJChdQu9Q19LiEcB9adrD1DclqGZ1024whILjFSfbs9e8VYlx+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723469654; c=relaxed/simple;
	bh=JL8XYXMlmVgvqed30UCj2bKK2g4QBnMop/kHWgz0fEk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=dfKuLp+P+4gEjxJmd7wi392Ja2Bw3WK/X7/vHzTE7PuKLO5MKvuh60kg3xHwW3f656k3xY+WGqTu+AalnA12sN/i3tgAroG3WOT0vp9M9fsw7G7Ih//26TsnJMZILXKSU+t5FkR6HL2Fl9R/z0UXL8rkazUCfrVilkJ12wDmtQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QARKBhky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98A2C32782;
	Mon, 12 Aug 2024 13:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723469654;
	bh=JL8XYXMlmVgvqed30UCj2bKK2g4QBnMop/kHWgz0fEk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=QARKBhkyAN/eafKtlB6M6qiuFUFApRL1r8zWesXVem0VfWgOANHT0y5OWLPfQ7XVy
	 iKSd26sXRNVLGSDVc9ggq6Txbk5pSwe5sTANAE8XoIfHhqeVN2uzLqQDw4Jm/rP8aU
	 kLigtPlx5kj5mLwI1MAvWSDtsdMG+vKjApCGqgYBxn4boPOYjFuRrKKw7L+wbHTirL
	 uoov6jSd7w+Bz4tgKfg8M2COsjaQVvdHGpLM9b8Uy/PV27LvyvrsjE+Bjx1L+2oJbW
	 /hqBTFd6BnfPWnVS2W+mU5wL8KUeb/2D+hvtKsP1Tc/jDlG97v6vJ5Vf6RNOOLz2gb
	 9u3+o4q7U6zdQ==
Date: Mon, 12 Aug 2024 07:34:12 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: kishon@kernel.org, fabrice.gasnier@foss.st.com, 
 linux-stm32@st-md-mailman.stormreply.com, alexandre.torgue@foss.st.com, 
 p.zabel@pengutronix.de, vkoul@kernel.org, devicetree@vger.kernel.org, 
 conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, krzk+dt@kernel.org, mcoquelin.stm32@gmail.com, 
 linux-phy@lists.infradead.org
In-Reply-To: <20240812120529.3564390-3-christian.bruel@foss.st.com>
References: <20240812120529.3564390-1-christian.bruel@foss.st.com>
 <20240812120529.3564390-3-christian.bruel@foss.st.com>
Message-Id: <172346965242.493337.13574697496053856.robh@kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: phy: Add STM32MP25 COMBOPHY bindings


On Mon, 12 Aug 2024 14:05:26 +0200, Christian Bruel wrote:
> Document the bindings for STM32 COMBOPHY interface, used to support
> the PCIe and USB3 stm32mp25 drivers.
> Following entries can be used to tune caracterisation parameters
>  - st,output-micro-ohms and st,output-vswing-microvolt bindings entries
> to tune the impedance and voltage swing using discrete simulation results
>  - st, phy_rx0_eq register to set the internal rx equalizer filter value.
> 
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> ---
>  .../bindings/phy/st,stm32-combophy.yaml       | 178 ++++++++++++++++++
>  1 file changed, 178 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/st,stm32-combophy.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/st,stm32-combophy.yaml: access-controllers: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240812120529.3564390-3-christian.bruel@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


