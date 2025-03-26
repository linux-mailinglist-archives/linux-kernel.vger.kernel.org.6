Return-Path: <linux-kernel+bounces-577566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B7AA71EDC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B0697A60A3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A93253F26;
	Wed, 26 Mar 2025 19:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+KA4WHP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BF7253B44;
	Wed, 26 Mar 2025 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743016299; cv=none; b=VGUcdQCCQh7nPv14ML/fcP4xTmWfxZylZgBfDtdD18Te/6a+Ih0aBo2Mg5IPfZYZZpHc/+wj3fBwy+l2tzLYUTRvS7oZttFCT8/X6wuzfWLzh0aYpV8q6avU8kB6nbcZLNW0P0JMs1Yfy2IH6q9MFBLQhAfM9P8F/p2PvnnzFik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743016299; c=relaxed/simple;
	bh=oj4iqbWhD0oo3JhqKuqXzaFTz8r7J0/qC5cNn4vk8g8=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=VxxFVFc9aXgUTuvVuH0Tl/aDt1q6UmI+MyQ/QAYl6i9MJ4FTw1VjyNXsLRwjaFyApJ9JJJRno1uZo9u4DjinaMoSZoW3EnnJD4tPP5NKIA0SubSyYoHTF2toQWt+26IN+FX4fha3ynjLrJJWdhSJelRiNNnFX74l/zp/9hDWDO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+KA4WHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947E8C4CEE9;
	Wed, 26 Mar 2025 19:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743016298;
	bh=oj4iqbWhD0oo3JhqKuqXzaFTz8r7J0/qC5cNn4vk8g8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=A+KA4WHPnnFpcUz0ATPC4d60HcbELnz44S+WeX4zpyZfeOaLWVVpBxtKJ12uunQfB
	 lUGYFxlzu4cimHNfwFkWjFSLJP+s3rFWjc3Jo9e6nUrKOr6TVDcSg5vAEsTltv7DK5
	 NpYNeOtd2GPlC6x3D8S6SW1CjUIrZ2+B4XlNdyWSurlhb1GgTSwr5Bdk2AwnfuArKw
	 3X+ueTqE5WanZVd1SJCP8/b9porWEgZt5q2l2a4ijntWNGFgYdokC1E9ToZpBQYgDz
	 bLt0ORALN17vkJrI2hVr9t0KPheF4ijo9hqUSeQTtN5o3vWkN9yHR8NZuScSL+6blg
	 o682l1JJdWTCw==
Date: Wed, 26 Mar 2025 14:11:37 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: mwalle@kernel.org, linux-mtd@lists.infradead.org, 
 claudiu.beznea@tuxon.dev, nicolas.ferre@microchip.com, 
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 tudor.ambarus@linaro.org, linux-arm-kernel@lists.infradead.org, 
 pratyush@kernel.org, alexandre.belloni@bootlin.com, krzk+dt@kernel.org, 
 conor+dt@kernel.org
To: Manikandan Muralidharan <manikandan.m@microchip.com>
In-Reply-To: <20250326072140.172244-1-manikandan.m@microchip.com>
References: <20250326072140.172244-1-manikandan.m@microchip.com>
Message-Id: <174301523860.2716379.13830528080465448868.robh@kernel.org>
Subject: Re: [PATCH v2 0/3] Read MAC Address from SST vendor specific SFDP
 region


On Wed, 26 Mar 2025 12:51:37 +0530, Manikandan Muralidharan wrote:
> This patch series adds support to parse the SFDP SST vendor map, read and
> store the EUI-48 and EUI-64 Address (if its programmed) using the
> resource-managed devm_kcalloc which will be freed on driver detach.
> Register EUI addresses into NVMEM framework for the net drivers to access
> them using nvmem properties.
> This change ensures consistent and reliable MAC address retrieval
> from QSPI benefiting boards like the sama5d29 curiosity and
> sam9x75 curiosity.
> 
> --------
> changes in v2:
> 
> - 1/3 - parse the SST vendor table, read and store the addresses
> 	into a resource - managed space. Register the addresses
> 	into NVMEM framework
> - 2/3 - add support to update the QSPI partition into 'fixed-partition'
> 	binding
> --------
> 
> Manikandan Muralidharan (3):
>   mtd: spi-nor: sfdp: parse SFDP SST vendor map and register EUI
>     addresses into NVMEM framework
>   ARM: dts: microchip: sama5d29_curiosity: update the QSPI partitions
>     using "fixed-partition" binding
>   ARM: dts: microchip: sama5d29_curiosity: Add nvmem-layout in QSPI for
>     EUI48 MAC Address
> 
>  .../dts/microchip/at91-sama5d29_curiosity.dts |  62 ++++---
>  drivers/mtd/spi-nor/sfdp.c                    | 161 ++++++++++++++++++
>  include/linux/mtd/spi-nor.h                   |   7 +
>  3 files changed, 206 insertions(+), 24 deletions(-)
> 
> --
> 2.25.1
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


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: tags/next-20250326 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/microchip/' for 20250326072140.172244-1-manikandan.m@microchip.com:

arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dtb: flash@0: Unevaluated properties are not allowed ('nvmem-layout' was unexpected)
	from schema $id: http://devicetree.org/schemas/mtd/jedec,spi-nor.yaml#






