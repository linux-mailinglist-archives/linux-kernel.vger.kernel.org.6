Return-Path: <linux-kernel+bounces-271509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E454944F38
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E71728AA7B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4101B32C9;
	Thu,  1 Aug 2024 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKg7xzN0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE3C1B32BA;
	Thu,  1 Aug 2024 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722526177; cv=none; b=rosOIRBymfAiwTwjMJoWXxs7bBoalyRegysjaPVR3vNIUn8jQc8gXr8dFDgkMYM0qoXnWUPNbb5nvdTiOkk3YWXcSEJQ37Re1tVhjuoNcv+B26lZcmd4l9LMbZt1MCRK3auCyVaN4BSE0F7bzn4FTPhJ1ocmfsMgvwwc9+RX0CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722526177; c=relaxed/simple;
	bh=b0dKdpkls/xiHeq62dyi/20Z4CFMsm8c8psfqmbBiF4=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=gX+JyG/Y3Yz3IFouCuWwkTBKlwnpoQDS3s8IPKRhAunTmiKomwRsgtGom/SeW4u5pZF82K8At9dVRFmkQn2pEveE7uyqRjee0UBD5tzbkr74CV4x9X4iNE4QXv0TC7JeUaF18hsUYnmBxfPJd9gptdyD0MumyuzZthTIUHc2Hjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKg7xzN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5BFC4AF0C;
	Thu,  1 Aug 2024 15:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722526177;
	bh=b0dKdpkls/xiHeq62dyi/20Z4CFMsm8c8psfqmbBiF4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=QKg7xzN0ALkHM98XOiofqigRpBDKQ+VWTKgqk7P4ndlaRxn9zFHZq2Qjvq9aGXS5Q
	 3c0W8CtiiFOZ90XfItPioJBnv9L9RpvrEMIFudBJg+qgjnn26LwrbqLfiPsGfZXkUx
	 aWzR4+vo13bTTEmPcMUV6+bRElohC+VKbkXqwu7pobbXHpZ6gMczJduUsYQLPMbUee
	 UYejgKJKP4UqkNuX3xmUotbtMJeJmhxfiQbx/v3dzSYOAid1FtYopNhcrN05TTADf/
	 iTsG5nJ2cibd6g4fz93ej+bKdKJHLScB76kABLjSqKgVtAWCSPsf2Zj1fRS23ZLW9x
	 Tm7llWCtWFV9w==
Date: Thu, 01 Aug 2024 09:29:35 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: andrew@codeconstruct.com.au, conor+dt@kernel.org, eajames@linux.ibm.com, 
 robh+dt@kernel.org, linux-kernel@vger.kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org, 
 joel@jms.id.au, devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
In-Reply-To: <20240731214737.986010-1-ninad@linux.ibm.com>
References: <20240731214737.986010-1-ninad@linux.ibm.com>
Message-Id: <172252600790.120672.12772438670145461296.robh@kernel.org>
Subject: Re: [PATCH v1 0/1] ARM: dts: aspeed: system1: IBM System1 BMC
 update


On Wed, 31 Jul 2024 16:47:28 -0500, Ninad Palsule wrote:
> Hello,
> 
> This patch only applies to openbmc/linux. The max31785 pmbus driver
> changes are not available in the upstream yet. I will try to send those
> changes upstream.
> 
> Ninad Palsule (1):
>   ARM: dts: aspeed: system1: IBM System1 BMC update
> 
>  .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
> --
> 2.43.0
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


New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-ibm-system1.dtb' for 20240731214737.986010-1-ninad@linux.ibm.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/apb/bus@1e78a000/i2c@380/fan-controller@52/fan@0: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/apb/bus@1e78a000/i2c@380/fan-controller@52/fan@1: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/apb/bus@1e78a000/i2c@380/fan-controller@52/fan@2: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/apb/bus@1e78a000/i2c@380/fan-controller@52/fan@3: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/apb/bus@1e78a000/i2c@380/fan-controller@52/fan@4: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/apb/bus@1e78a000/i2c@380/fan-controller@54/fan@0: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/apb/bus@1e78a000/i2c@380/fan-controller@54/fan@1: failed to match any schema with compatible: ['pmbus-fan']






