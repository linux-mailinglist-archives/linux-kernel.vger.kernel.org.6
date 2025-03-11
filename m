Return-Path: <linux-kernel+bounces-556343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A67C7A5C43E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDB5B1899AC6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D479625D8F8;
	Tue, 11 Mar 2025 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFXE9Zei"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADB125D8E2;
	Tue, 11 Mar 2025 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741704772; cv=none; b=bFJHe680mXhFdUVSxmGEFGjZZ3M1vlad8ZorvdNJ6rL0PpgY5C7lMykJE7htHj3I4ogf6bonEP6g+e6DAFo0qOIDOsvdOy0WpQZWvFqXTA3+lxvwhU96FKs87IOGJrfF2abjYPkldFHSDQYaiXs2XM5a7LwFxb3Jnp69hALrZf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741704772; c=relaxed/simple;
	bh=przUIjrGBeRn2NFdoDvfHg0XkuwpE3kxzoY/NM9thYQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Bj7icpMPf1grVfHSFaj7S0YNTRf/MPTGv+dWsXFdivumYs49ns5hT+Wfw0YtbponuQSMf2UrWxUxqoBvVwKzfACgL1eR5pethG95RWl9gXWHe/o6Nwm4UuRejStYZEwcDohFZdtx4M2AeGrW5MM0ko+kwEvZaDE+KJU2bim67ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFXE9Zei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE29C4CEE9;
	Tue, 11 Mar 2025 14:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741704772;
	bh=przUIjrGBeRn2NFdoDvfHg0XkuwpE3kxzoY/NM9thYQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=KFXE9Zeihos+lajupK4gUTerAD9SsbPG4vZhTreuJpHhiLjGkJUi22Krq41eOOrpz
	 oHd21OBdT3uLqgMu9om9jcqqHzzC+gPHTX0uCdswFtL9cp2NWHSNZYn5IW9ZPj2Im/
	 518d+YXAAQgst7dkw/SoDL/cU0PkbEZqG2OVQn9A50JhSu3fJJZKMZQChPE2R0Kw1T
	 Ose7wBG99V2VuTOS7cvHkv2DdLSOCqUXEUXg9is8tIRDRSc2dpG/4g8hCVHBA3hTgO
	 u0FM+dtZEyZ6jx+nGH/D3TalLHGxnUdSHe0otovpN6yOdRglWV6OaZKQEjCUEZaUxh
	 FFBRwmdKZNeiQ==
Date: Tue, 11 Mar 2025 09:52:50 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-mtd@lists.infradead.org, krzysztof.kozlowski+dt@linaro.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 richard@nod.at, miquel.raynal@bootlin.com, krzk+dt@kernel.org, 
 claudiu.beznea@tuxon.dev, vigneshr@ti.com, linux-kernel@vger.kernel.org, 
 nicolas.ferre@microchip.com, conor+dt@kernel.org, 
 alexandre.belloni@bootlin.com
To: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
In-Reply-To: <20250311122847.90081-2-balamanikandan.gunasundar@microchip.com>
References: <20250311122847.90081-1-balamanikandan.gunasundar@microchip.com>
 <20250311122847.90081-2-balamanikandan.gunasundar@microchip.com>
Message-Id: <174170473601.3452705.4276708145941047362.robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: microchip-nand: convert txt
 to yaml


On Tue, 11 Mar 2025 17:58:45 +0530, Balamanikandan Gunasundar wrote:
> Convert text to yaml for microchip nand controller
> 
> Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
> ---
> 
> Changes in v2:
> 
> - Change the filename to match the compatible string
> - Drop items and oneOf in the compatible property as it is just an enum
> - Remove the if in the #address-cells and #size-cells
> - Remove the unwanted comments that refers to .txt files
> - Fix reg property description
> - Define the properties in a list and add constraints
> - Fix DT coding style and droped unused labels
> 
>  .../devicetree/bindings/mtd/atmel-nand.txt    |  50 -----
>  .../mtd/microchip,nand-controller.yaml        | 175 ++++++++++++++++++
>  2 files changed, 175 insertions(+), 50 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/microchip,nand-controller.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mtd/microchip,nand-controller.example.dtb: /example-0/ecc-engine@ffffc070: failed to match any schema with compatible: ['atmel,at91sam9g45-pmecc']
Documentation/devicetree/bindings/mtd/microchip,nand-controller.example.dtb: /example-0/ebi@10000000: failed to match any schema with compatible: ['atmel,sama5d3-ebi']
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/microchip,nand-controller.example.dtb: nand-controller: #address-cells: 1 was expected
	from schema $id: http://devicetree.org/schemas/mtd/nand-controller.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/microchip,nand-controller.example.dtb: nand-controller: #size-cells: 0 was expected
	from schema $id: http://devicetree.org/schemas/mtd/nand-controller.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250311122847.90081-2-balamanikandan.gunasundar@microchip.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


