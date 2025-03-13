Return-Path: <linux-kernel+bounces-560470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A91DBA604BC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6587D189789C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C357E1F872C;
	Thu, 13 Mar 2025 22:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uo+ZoH8D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222F11F791E;
	Thu, 13 Mar 2025 22:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741906271; cv=none; b=FY3hyE5ndV6W419sMuDDtHqTE8BVjIStkRD8USFonBltm33GmSDIhqKnTgTiOdBWDR52wO3q3vA39cHffM/ySqSrPFmZIqa6S76NMz7W2uh5nq8fjVjKH4VV7iXwk2tEcifKxIj93e4//27GeJ9+ln9eIwze5wsgcZZCXbS/+3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741906271; c=relaxed/simple;
	bh=k+D1DYsJJtPHtdNWmrJpXnR7aYZC7cxXGtQBxIHdhTc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=q90uFngvOKvMbxRR9RW5SQDB32DaX0sDLQ6ahrgsCA0x8TUrzvHO3wID5GKLxMNSlZd6e+Vgfgje8hICucj9QguKabVpAAdZG6Mw4IoJXx8kZN7kkqGbVM9PHxPKdKE7nMQ5u5U3dN7Q/KLY/o4FLpEEPs6FGm/V+ahujZP1Wxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uo+ZoH8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B44AC4CEDD;
	Thu, 13 Mar 2025 22:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741906269;
	bh=k+D1DYsJJtPHtdNWmrJpXnR7aYZC7cxXGtQBxIHdhTc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Uo+ZoH8D60bULMR/Z7T4I8xA3fsPkSjE5yfqOon/YjEcGXxMvg7YZb06xfS22P2Gt
	 cLUOdfmMfbFprxJw3OQVHZw9qNX9TyjM5ar7vOJmvWE8QXKqRVcFN9DXnhMn0fZCby
	 9LrWxJTFtMl90r4z2tcD5QX7wNpCFjZDRG0KGYLqnT56LJGqH+BQDqXArzCp2D6RlN
	 HYwKa77PcuqPXFopfYW9pjtBvQkpMoK+GBmriMVnC9MJOOAudxtawlUXYQU5xPYp6A
	 iKed2qW1JaTbayoeuKvba2liRmwE2dBV9Xp/MGwkmytGzpGwn7aWht1DKAyxZolXFU
	 d6t1jctx8+5CA==
Date: Thu, 13 Mar 2025 17:51:08 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Richard Weinberger <richard@nod.at>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Crystal Wood <oss@buserror.net>, 
 Naveen N Rao <naveen@kernel.org>, devicetree@vger.kernel.org, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linuxppc-dev@lists.ozlabs.org, Frank Li <Frank.Li@nxp.com>, 
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Conor Dooley <conor+dt@kernel.org>
To: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
In-Reply-To: <20250313-ppcyaml-elbc-v4-4-55903722d9ea@posteo.net>
References: <20250313-ppcyaml-elbc-v4-0-55903722d9ea@posteo.net>
 <20250313-ppcyaml-elbc-v4-4-55903722d9ea@posteo.net>
Message-Id: <174190626852.565.9247018798608897062.robh@kernel.org>
Subject: Re: [PATCH v4 4/4] dt-bindings: memory-controllers: Convert
 fsl,elbc to YAML


On Thu, 13 Mar 2025 22:35:47 +0100, J. Neuschäfer wrote:
> Convert the Freescale localbus controller bindings from text form to
> YAML. Compared to the .txt version, the YAML binding contains a new
> usage example with FCM NAND flash, and a full list of compatible strings
> based on current usage in arch/powerpc/boot/dts/.
> 
> Note that the both the compatible strings and the unit address format
> are kept as-is, for compatibility with existing kernels and device
> trees, as well as unit address readability. This results in dts
> validation warnings:
> 
>   Warning (simple_bus_reg): /example-0/localbus@f0010100/board-control@1,0:
>   simple-bus unit address format error, expected "100000000"
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
> 
> V4:
> - no changes
> 
> V3:
> - move this patch after the GPCM/FCM patches to dtschema/dtc warnings
>   due to missing bindings for fsl,elbc-gpcm-uio and fsl,elbc-fcm-nand
> - add "simple-bus" again, for compatibility with existing DTs/drivers
>   based on discussion with Crystal Wood and Rob Herring
> - fix fsl,pq2-localbus compatible properties based on mgcoge.dts / ep8248e.dts
>   (was missing "simple-bus")
> - add board-control (bcsr) example again, now using the compatible
>   string listed in Documentation/devicetree/bindings/board/fsl,bcsr.yaml
> - remove interrupt-parent property from example
> - rework the commit message
> 
> V2:
> - fix order of properties in examples, according to dts coding style
> - move to Documentation/devicetree/bindings/memory-controllers
> - clarify the commit message a tiny bit
> - remove unnecessary multiline markers (|)
> - define address format in patternProperties
> - trim subject line (remove "binding")
> - remove use of "simple-bus", because it's technically incorrect
> ---
>  .../bindings/memory-controllers/fsl,elbc.yaml      | 158 +++++++++++++++++++++
>  .../devicetree/bindings/powerpc/fsl/lbc.txt        |  43 ------
>  2 files changed, 158 insertions(+), 43 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/memory-controllers/fsl,elbc.example.dts:29.23-34.15: Warning (simple_bus_reg): /example-0/localbus@f0010100/flash@0,0: simple-bus unit address format error, expected "0"
Documentation/devicetree/bindings/memory-controllers/fsl,elbc.example.dts:36.31-39.15: Warning (simple_bus_reg): /example-0/localbus@f0010100/board-control@1,0: simple-bus unit address format error, expected "100000000"
Documentation/devicetree/bindings/memory-controllers/fsl,elbc.example.dts:41.31-46.15: Warning (simple_bus_reg): /example-0/localbus@f0010100/simple-periph@2,0: simple-bus unit address format error, expected "200000000"
Documentation/devicetree/bindings/memory-controllers/fsl,elbc.example.dts:82.23-89.15: Warning (simple_bus_reg): /example-1/localbus@e0005000/flash@0,0: simple-bus unit address format error, expected "0"
Documentation/devicetree/bindings/memory-controllers/fsl,elbc.example.dts:91.22-97.15: Warning (simple_bus_reg): /example-1/localbus@e0005000/nand@1,0: simple-bus unit address format error, expected "100000000"

doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/display/ssd1289fb.txt references a file that doesn't exist: Documentation/devicetree/bindings/powerpc/fsl/lbc.txt
Documentation/devicetree/bindings/display/ssd1289fb.txt: Documentation/devicetree/bindings/powerpc/fsl/lbc.txt

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250313-ppcyaml-elbc-v4-4-55903722d9ea@posteo.net

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


