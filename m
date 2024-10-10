Return-Path: <linux-kernel+bounces-359294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 036A79989D7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2DA1F28D1D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE921CF2B4;
	Thu, 10 Oct 2024 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLCXg63I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D96C1CF2AC;
	Thu, 10 Oct 2024 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570604; cv=none; b=ihnfdfGJsueBzUuugLU9V9FGdxgkmrylwPTeYGH5kRVeQ3CcLV9g/6GhFriB0aciBw1CQnO1nFfEybxHjDGuzSEKg59huOexuBaKm39YiIbdB+YUcVgVcjNs2fPL+4FGQCfjYVKvXhFx7ouBa6qQHMIuItERKIilm2eJl7BHpuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570604; c=relaxed/simple;
	bh=S+pL9ymaMliPbsHp6fyiRjsU/ZHVCmakLNc028gvdJg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ePUUG+b6xy5vbPrfHhqWHxJowdBIcZ+RmFIhPCDgs4vIw+WZPsUygsY0yQFU5rBHtxRQ3MoxeeYjRK6Jm+dYUzNS7A7kGh8F7laKeiYEZWUZ+tFOOISgRl4MatSGrzdaQZHNpJrPdh36Nq46d02c9SXvmMwtkowrrP1IyrS3MIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLCXg63I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E235CC4CEC5;
	Thu, 10 Oct 2024 14:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728570604;
	bh=S+pL9ymaMliPbsHp6fyiRjsU/ZHVCmakLNc028gvdJg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=PLCXg63IgNs94A+VSleneF+1TFboUDGvN12W4EoDm37MfP+TnGIpxHVpNFyhBNFXs
	 FlsX/FY6F2+tjzGRCTYWteIhvjEtSXt4spK5CEWRJI7GPBJp2jnzurp6yI01RIyX+d
	 M7UOKr3/sMh1kTL3OHfHUy8+7m9w5C+PekVAFUoxdqeBRqOwdbIFPoekWUvPrKvK6C
	 /iMZFZTwF6sXxwH6899ZtawmivXLbXviutllauG5tpDlp1mb+sWrJgg33L5fXZA9Gd
	 1B6ZNQuZzjlaspxHgNwDTOwEW1I+ra4vLSCVHt7qj+J+EdNUnjdVqfsgYryYvVTgPp
	 QV5Fng54MA6wQ==
Date: Thu, 10 Oct 2024 09:30:03 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sam Edwards <cfsworks@gmail.com>
Cc: linux-kernel@vger.kernel.org, Kursad Oney <kursad.oney@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, 
 William Zhang <william.zhang@broadcom.com>, 
 Conor Dooley <conor+dt@kernel.org>, Anand Gore <anand.gore@broadcom.com>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 devicetree@vger.kernel.org, Sam Edwards <CFSworks@gmail.com>
In-Reply-To: <20241009215454.1449508-1-CFSworks@gmail.com>
References: <20241009215454.1449508-1-CFSworks@gmail.com>
Message-Id: <172857035808.1533132.3589155892094687895.robh@kernel.org>
Subject: Re: [PATCH v2 0/2] Add support for Zyxel EX3510-B


On Wed, 09 Oct 2024 14:54:52 -0700, Sam Edwards wrote:
> Hello BCMBCA maintainers,
> 
> This is a second, very minor revision of my previous series for introducing
> support for the Zyxel EX3510-B "series," largely motivated by my earlier
> patchset [1] that resolves validation errors in the BCMBCA DTs. If checking the
> DT, please apply that other patchset first. These changes do not depend on the
> other patchset to build correctly or apply cleanly; only to pass validation.
> 
> Happy spooky month,
> Sam
> 
> [1]: https://lore.kernel.org/linux-devicetree/20241009215046.1449389-1-CFSworks@gmail.com/T/
> 
> Changes v1->v2:
> - Rolled-in commit tags from previous version
> - Stylistic change to memory: s/0/0x0
> - Delete `range` property from the `nvmem-cells` node, in order to pass DT
>   checks.
> 
> COMMITTER NOTE: Email being what it is, the capitalization of my email address
> is apparently getting discarded. If it is important that the author email
> address have identical capitalization to the Signed-off-by, please explain why
> so I can investigate why this is happening and/or get these patches to you in a
> desired format.
> 
> Sam Edwards (2):
>   dt-bindings: arm64: bcmbca: Add Zyxel EX3510-B based on BCM4906
>   arm64: dts: broadcom: bcmbca: bcm4908: Add DT for Zyxel EX3510-B
> 
>  .../bindings/arm/bcm/brcm,bcmbca.yaml         |   1 +
>  arch/arm64/boot/dts/broadcom/bcmbca/Makefile  |   1 +
>  .../broadcom/bcmbca/bcm4906-zyxel-ex3510b.dts | 196 ++++++++++++++++++
>  3 files changed, 198 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-zyxel-ex3510b.dts
> 
> --
> 2.44.2
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y broadcom/bcmbca/bcm4906-zyxel-ex3510b.dtb' for 20241009215454.1449508-1-CFSworks@gmail.com:

arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-zyxel-ex3510b.dtb: nand-controller@1800: nand@0:partitions: 'oneOf' conditional failed, one must be fixed:
	'#address-cells', '#size-cells', 'partition@0', 'partition@100000', 'partition@6080000' do not match any of the regexes: 'pinctrl-[0-9]+'
	'#address-cells', '#size-cells', 'partition@0', 'partition@100000', 'partition@6080000' do not match any of the regexes: '^partition-[0-9a-z]+$', 'pinctrl-[0-9]+'
	'fis-index-block' is a required property
	'partitions-table-offset' is a required property
	'#address-cells', '#size-cells', 'partition@0', 'partition@100000', 'partition@6080000' do not match any of the regexes: '^partition-.*$', 'pinctrl-[0-9]+'
	False schema does not allow 1
arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-zyxel-ex3510b.dtb: nand-controller@1800: nand@0:partitions:compatible: 'oneOf' conditional failed, one must be fixed:
		['brcm,bcm4908-partitions'] is too short
		'fixed-partitions' was expected
		'sercomm,sc-partitions' was expected
	'arm,arm-firmware-suite' was expected
	'brcm,bcm947xx-cfe-partitions' was expected
	'linksys,ns-partitions' was expected
	'qcom,smem-part' was expected
	'redboot-fis' was expected
	'tplink,safeloader-partitions' was expected
	Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'compatible', 'mac@106a0' were unexpected)
	['nvmem-cells'] is too short
	'brcm,bcm4908-firmware' was expected
	'linksys,ns-firmware' was expected
	Unevaluated properties are not allowed ('compatible' was unexpected)
	['brcm,bcm4908-firmware'] is too short
	from schema $id: http://devicetree.org/schemas/mtd/brcm,brcmnand.yaml#
arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-zyxel-ex3510b.dtb: nand-controller@1800: nand@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'nand-ecc-strength', 'partitions' were unexpected)
	from schema $id: http://devicetree.org/schemas/mtd/brcm,brcmnand.yaml#
arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-zyxel-ex3510b.dtb: nand-controller@1800: nand@0:partitions: 'oneOf' conditional failed, one must be fixed:
	'#address-cells', '#size-cells', 'partition@0', 'partition@100000', 'partition@6080000' do not match any of the regexes: 'pinctrl-[0-9]+'
	'#address-cells', '#size-cells', 'partition@0', 'partition@100000', 'partition@6080000' do not match any of the regexes: '^partition-[0-9a-z]+$', 'pinctrl-[0-9]+'
	'fis-index-block' is a required property
	'partitions-table-offset' is a required property
	'#address-cells', '#size-cells', 'partition@0', 'partition@100000', 'partition@6080000' do not match any of the regexes: '^partition-.*$', 'pinctrl-[0-9]+'
	False schema does not allow 1
arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-zyxel-ex3510b.dtb: nand-controller@1800: nand@0:partitions:compatible: 'oneOf' conditional failed, one must be fixed:
		['brcm,bcm4908-partitions'] is too short
		'fixed-partitions' was expected
		'sercomm,sc-partitions' was expected
	'arm,arm-firmware-suite' was expected
	'brcm,bcm947xx-cfe-partitions' was expected
	'linksys,ns-partitions' was expected
	'qcom,smem-part' was expected
	'redboot-fis' was expected
	'tplink,safeloader-partitions' was expected
	Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'compatible', 'mac@106a0' were unexpected)
	['nvmem-cells'] is too short
	'brcm,bcm4908-firmware' was expected
	'linksys,ns-firmware' was expected
	Unevaluated properties are not allowed ('compatible' was unexpected)
	['brcm,bcm4908-firmware'] is too short
	from schema $id: http://devicetree.org/schemas/mtd/brcm,brcmnand.yaml#
arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-zyxel-ex3510b.dtb: nand-controller@1800: Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
	from schema $id: http://devicetree.org/schemas/mtd/brcm,brcmnand.yaml#
arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-zyxel-ex3510b.dtb: nand-controller@1800: nand@0:partitions: 'oneOf' conditional failed, one must be fixed:
	'#address-cells', '#size-cells', 'partition@0', 'partition@100000', 'partition@6080000' do not match any of the regexes: 'pinctrl-[0-9]+'
	'#address-cells', '#size-cells', 'partition@0', 'partition@100000', 'partition@6080000' do not match any of the regexes: '^partition-[0-9a-z]+$', 'pinctrl-[0-9]+'
	'fis-index-block' is a required property
	'partitions-table-offset' is a required property
	'#address-cells', '#size-cells', 'partition@0', 'partition@100000', 'partition@6080000' do not match any of the regexes: '^partition-.*$', 'pinctrl-[0-9]+'
	False schema does not allow 1
arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-zyxel-ex3510b.dtb: nand-controller@1800: nand@0:partitions:compatible: 'oneOf' conditional failed, one must be fixed:
		['brcm,bcm4908-partitions'] is too short
		'fixed-partitions' was expected
		'sercomm,sc-partitions' was expected
	'arm,arm-firmware-suite' was expected
	'brcm,bcm947xx-cfe-partitions' was expected
	'linksys,ns-partitions' was expected
	'qcom,smem-part' was expected
	'redboot-fis' was expected
	'tplink,safeloader-partitions' was expected
	Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'compatible', 'mac@106a0' were unexpected)
	['nvmem-cells'] is too short
	'brcm,bcm4908-firmware' was expected
	'linksys,ns-firmware' was expected
	Unevaluated properties are not allowed ('compatible' was unexpected)
	['brcm,bcm4908-firmware'] is too short
	from schema $id: http://devicetree.org/schemas/mtd/nand-controller.yaml#
arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-zyxel-ex3510b.dtb: nand@0: partitions: 'oneOf' conditional failed, one must be fixed:
	'#address-cells', '#size-cells', 'partition@0', 'partition@100000', 'partition@6080000' do not match any of the regexes: 'pinctrl-[0-9]+'
	'#address-cells', '#size-cells', 'partition@0', 'partition@100000', 'partition@6080000' do not match any of the regexes: '^partition-[0-9a-z]+$', 'pinctrl-[0-9]+'
	'fis-index-block' is a required property
	'partitions-table-offset' is a required property
	'#address-cells', '#size-cells', 'partition@0', 'partition@100000', 'partition@6080000' do not match any of the regexes: '^partition-.*$', 'pinctrl-[0-9]+'
	False schema does not allow 1
arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-zyxel-ex3510b.dtb: nand@0: partitions:compatible: 'oneOf' conditional failed, one must be fixed:
		['brcm,bcm4908-partitions'] is too short
		'fixed-partitions' was expected
		'sercomm,sc-partitions' was expected
	'arm,arm-firmware-suite' was expected
	'brcm,bcm947xx-cfe-partitions' was expected
	'linksys,ns-partitions' was expected
	'qcom,smem-part' was expected
	'redboot-fis' was expected
	'tplink,safeloader-partitions' was expected
	Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'compatible', 'mac@106a0' were unexpected)
	['nvmem-cells'] is too short
	'brcm,bcm4908-firmware' was expected
	'linksys,ns-firmware' was expected
	Unevaluated properties are not allowed ('compatible' was unexpected)
	['brcm,bcm4908-firmware'] is too short
	from schema $id: http://devicetree.org/schemas/mtd/raw-nand-chip.yaml#






