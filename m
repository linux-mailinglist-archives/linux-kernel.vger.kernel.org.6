Return-Path: <linux-kernel+bounces-534687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E788A469FC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B42F3A3CD1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D296822D4FB;
	Wed, 26 Feb 2025 18:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+/xF3t4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D83222577;
	Wed, 26 Feb 2025 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595520; cv=none; b=j6p/ly3X96Q3v0r04HmHprV+4V0kCIi0YLCYDlUk+435jM6fn3Nt9M+W191MF7S54dWUebF6hsXChXYksIionxcSPjZSOw562qB4m9Mfsd/2g9TOMV6nEI2DBqpaVQPdOQIAkRXeBqBo6LvouQtWmSgqZrGnPWyf8aGvcRvV8cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595520; c=relaxed/simple;
	bh=ERGSj8UoLV6emwDjg3zTNHnsZejqQWg/I0zbv9GeNbM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=BOx4zq0cGb1E+0tfsXq+2XHAbvpkZbGlt1a7CjiHl3iqd5ssKK+enmKMXjIo9dnLNpI7gN9AMXD26spW/+6eF9n9FGNvqwHBHUR3rVrwkFb7Q7wI4Uj8uc++0Nb5ROKXbywpmG8EfICGILkeXENW+q3serXui7ppl5LLHeO8Dr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+/xF3t4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74BF2C4CED6;
	Wed, 26 Feb 2025 18:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740595519;
	bh=ERGSj8UoLV6emwDjg3zTNHnsZejqQWg/I0zbv9GeNbM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=T+/xF3t4tpA/bM8KzWexhY5qNBzCXfgQ4G02MVaEvRJRJ/N+6fo6LnPJKg/zvWnu5
	 uRXENvWQ/Wc9Wmy5R66SK8d7kaOyHlJftocHLw6W8arDA4WvSwgO9D2ICWPuE9Rto0
	 Jze6dVjvEuoISfK82Q6TL5xD2iYG694Q4BT+ndjZiCvH8CbvpPMi6OhV85MkmJPE+G
	 uUbf0BKxHR3OQK8RUNv/e0CCeLMi927pPpjhAg3b3xQpPRSQJMS5cmbwYEFG+Vhr9R
	 SbEAFRrdq7X92lEobC3h6YeMsckxVCdbuV2e2xSDUieVI3foINpDmJUFpCjK97Dkfm
	 G8achp3TuJCIg==
Date: Wed, 26 Feb 2025 12:45:17 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Richard Weinberger <richard@nod.at>, 
 Michael Ellerman <mpe@ellerman.id.au>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, Crystal Wood <oss@buserror.net>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, linux-mtd@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Naveen N Rao <naveen@kernel.org>, 
 linuxppc-dev@lists.ozlabs.org
To: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
In-Reply-To: <20250226-ppcyaml-elbc-v3-2-a90ed71da838@posteo.net>
References: <20250226-ppcyaml-elbc-v3-0-a90ed71da838@posteo.net>
 <20250226-ppcyaml-elbc-v3-2-a90ed71da838@posteo.net>
Message-Id: <174059551678.3319332.12055848852503108874.robh@kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: nand: Add fsl,elbc-fcm-nand


On Wed, 26 Feb 2025 18:01:41 +0100, J. Neuschäfer wrote:
> Formalize the binding already supported by the fsl_elbc_nand.c driver
> and used in several device trees in arch/powerpc/boot/dts/.
> 
> raw-nand-chip.yaml is referenced in order to accommodate situations in
> which the ECC parameters settings are set in the device tree. One such
> example is in arch/powerpc/boot/dts/turris1x.dts:
> 
> 	/* MT29F2G08ABAEAWP:E NAND */
> 	nand@1,0 {
> 		compatible = "fsl,p2020-fcm-nand", "fsl,elbc-fcm-nand";
> 		reg = <0x1 0x0 0x00040000>;
> 		nand-ecc-mode = "soft";
> 		nand-ecc-algo = "bch";
> 
> 		partitions { ... };
> 	};
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
> 
> V3:
> - remove unnecessary #address/size-cells from nand node in example
> - add Frank Li's review tag
> - add missing end of document marker (...)
> - explain choice to reference raw-nand-chip.yaml
> 
> V2:
> - split out from fsl,elbc binding patch
> - constrain #address-cells and #size-cells
> - add a general description
> - use unevaluatedProperties=false instead of additionalProperties=false
> - fix property order to comply with dts coding style
> - include raw-nand-chip.yaml instead of nand-chip.yaml
> ---
>  .../devicetree/bindings/mtd/fsl,elbc-fcm-nand.yaml | 68 ++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/fsl,elbc-fcm-nand.example.dtb: nand@1,0: $nodename:0: 'nand@1,0' does not match '^nand@[a-f0-9]$'
	from schema $id: http://devicetree.org/schemas/mtd/fsl,elbc-fcm-nand.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250226-ppcyaml-elbc-v3-2-a90ed71da838@posteo.net

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


