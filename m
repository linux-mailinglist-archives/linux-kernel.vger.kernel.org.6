Return-Path: <linux-kernel+bounces-534688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10972A469FF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C829E3A4556
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035632356B7;
	Wed, 26 Feb 2025 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/DP6f2o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ACF235362;
	Wed, 26 Feb 2025 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595522; cv=none; b=L9KthyhU5UnaqfscL/cT6kzjVdKcgMVu0MtstXwYSx6qD7CkUZIlDdqP5rOVGbDvyJC5B/n8zZY6bEZhOjYxfk4g1MTF6Fz68BqdOVgqQyF35z0HTzm6pcYrcA+TmxNHM5BhpqjWVtcIAq7sTvepMjBcEmmk685hiHyA+OtJjPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595522; c=relaxed/simple;
	bh=UQX5b9FThbfXC5EaNwBLuTStMWQtZPAMy+PEviHm4f0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=d1u8lHVLXP/ANFUc964loIxM2wawsGFTyIU4bUpQSa9o5TphqkZwAO0ZZMKOiTdx/COwMHOMqqc3YITGFcnwUyFFVkG27QZKFl4aS9PdQaypXEddXqsBJDkaNzgyFn2PXjxZbg2Ktz5uVg/UC1IGS5PHL/jCk9G6Jg2p0+bhJ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/DP6f2o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A44C4CED6;
	Wed, 26 Feb 2025 18:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740595521;
	bh=UQX5b9FThbfXC5EaNwBLuTStMWQtZPAMy+PEviHm4f0=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=d/DP6f2odU0xWuLlFFE6Zghy4hWE6i8gZAxfVWux4PC8ZmGdjMjZUyo5cXfbbrofP
	 b7Fs29L3AM4mjfNhTIXqBtTUpfjtlgGg3Ctla5CcVJoRMmqUdIDYh/awr5+l9JRHP+
	 oKBBKsyH1pu9oZdl1XcmaeRdnVKkfFWKh3C8/3S1GrRs6XvjBR1hiIcHi0xF8xWxgx
	 a/4YLkYQJ8GT4MzblzTF7UiDVP0QmzKP8LW7rMQrQXepPrxc6gUkSzgCDakv1zjJll
	 fV/ffE8WEeNXc7t7YQDVPrgPxtPITI3UofFyM+5ychJLfeLwcDWl2oGBipyQTtznQ2
	 w50qawF7ElkMw==
Date: Wed, 26 Feb 2025 12:45:19 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linuxppc-dev@lists.ozlabs.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Crystal Wood <oss@buserror.net>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Richard Weinberger <richard@nod.at>, 
 Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>
To: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
In-Reply-To: <20250226-ppcyaml-elbc-v3-3-a90ed71da838@posteo.net>
References: <20250226-ppcyaml-elbc-v3-0-a90ed71da838@posteo.net>
 <20250226-ppcyaml-elbc-v3-3-a90ed71da838@posteo.net>
Message-Id: <174059551786.3319377.4330281854518280945.robh@kernel.org>
Subject: Re: [PATCH v3 3/3] dt-bindings: memory-controllers: Convert
 fsl,elbc to YAML


On Wed, 26 Feb 2025 18:01:42 +0100, J. Neuschäfer wrote:
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
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/fsl,elbc.example.dtb: nand@1,0: $nodename:0: 'nand@1,0' does not match '^nand@[a-f0-9]$'
	from schema $id: http://devicetree.org/schemas/mtd/fsl,elbc-fcm-nand.yaml#

doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/display/ssd1289fb.txt references a file that doesn't exist: Documentation/devicetree/bindings/powerpc/fsl/lbc.txt
Documentation/devicetree/bindings/display/ssd1289fb.txt: Documentation/devicetree/bindings/powerpc/fsl/lbc.txt

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250226-ppcyaml-elbc-v3-3-a90ed71da838@posteo.net

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


