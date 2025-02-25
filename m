Return-Path: <linux-kernel+bounces-532372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB01FA44C24
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50BF816C4B8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD39920E71E;
	Tue, 25 Feb 2025 20:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8L2oxFu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BADA20E028;
	Tue, 25 Feb 2025 20:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514353; cv=none; b=ui01Ncshj6WEayBTv01PPMCc4WDxVsMA4auj1GqrQhJbdOwkX8Po6hPzhJUdQ1nC5T5Vha5932fm7wFLEoclC3TsFPhSw0V907LliLvblOvdW4cUPAcG0j7hZ6pCaEu22j/662yiXidpfFPtijhj4x5sNMBlEEbNy518DAdqu68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514353; c=relaxed/simple;
	bh=jkFZlDqbRxwvpb/csXsZpILkgeKZJ+LCenzb2959lCs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=hSacpegJFeMCpOc4nWWQpBQDIub0sxuVIPBzsNboNPy/+/Cg9PcyDisVaWb/axuYfasAj4yIkmyxjNRFQ4sw9CL39pjfYF7OJvJVkwFbMRpVQch51LJwxLjn3ZaILeI7ACj+/241zFyVsVVghTiWVRGz0C0yHZnFah03QBvRwG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8L2oxFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E3DC4CEDD;
	Tue, 25 Feb 2025 20:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740514352;
	bh=jkFZlDqbRxwvpb/csXsZpILkgeKZJ+LCenzb2959lCs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=S8L2oxFuJZ076tqLRePqBT4wMo9eOqzMOB4Q1TcVSLoS7Zpqwu5YE2GH+sncwuhvC
	 3c+dyESCbHV1m4UFb/DIEwxeQ8ylalFEmT+DkxmSMG/5B6MdEMpSrrru4Q2wTFks/E
	 jczAjUFLX13PDqfxERqNb5wvfm1zEEZOusz0OFUJ32sWPyhRhZJwpiMfvLzS6OQBtK
	 a39dmCkae/21f9WjnAgOTdUj0oBc8aIMx61uvHlb446t9GoNU9KthYPNUccMvmnbkZ
	 jrdsAwa+mhrizWxrAFZnqsDK4loMbFOe+ZSaS3uK9PtI6f3F4yiwuaQ7z4sDosASsL
	 xsNva4+vPmXDg==
Date: Tue, 25 Feb 2025 14:12:30 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Chester Lin <chester62515@gmail.com>, 
 Matthias Brugger <mbrugger@suse.com>, Conor Dooley <conor+dt@kernel.org>, 
 imx@lists.linux.dev, Enric Balletbo <eballetb@redhat.com>, 
 linux-arm-kernel@lists.infradead.org, Christophe Lizzi <clizzi@redhat.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Alberto Ruiz <aruizrui@redhat.com>, NXP S32 Linux <s32@nxp.com>, 
 devicetree@vger.kernel.org
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20250224134016.3921196-1-ciprianmarian.costea@oss.nxp.com>
References: <20250224134016.3921196-1-ciprianmarian.costea@oss.nxp.com>
Message-Id: <174051414934.2971045.13322665811292325537.robh@kernel.org>
Subject: Re: [PATCH] arm64: dts: s32g: add FlexCAN[0..3] support for s32g2
 and s32g3


On Mon, 24 Feb 2025 15:40:16 +0200, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> Add FlexCAN[0..3] for S32G2 and S32G3 SoCs.
> 
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/s32g2.dtsi      | 52 ++++++++++++++
>  arch/arm64/boot/dts/freescale/s32g3.dtsi      | 56 +++++++++++++++
>  .../boot/dts/freescale/s32gxxxa-evb.dtsi      | 72 +++++++++++++++++++
>  .../boot/dts/freescale/s32gxxxa-rdb.dtsi      | 48 +++++++++++++
>  4 files changed, 228 insertions(+)
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


New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/freescale/' for 20250224134016.3921196-1-ciprianmarian.costea@oss.nxp.com:

arch/arm64/boot/dts/freescale/s32g399a-rdb3.dtb: /soc@0/can@401b4000: failed to match any schema with compatible: ['nxp,s32g3-flexcan', 'nxp,s32g2-flexcan']
arch/arm64/boot/dts/freescale/s32g399a-rdb3.dtb: /soc@0/can@401b4000: failed to match any schema with compatible: ['nxp,s32g3-flexcan', 'nxp,s32g2-flexcan']
arch/arm64/boot/dts/freescale/s32g399a-rdb3.dtb: /soc@0/can@401be000: failed to match any schema with compatible: ['nxp,s32g3-flexcan', 'nxp,s32g2-flexcan']
arch/arm64/boot/dts/freescale/s32g399a-rdb3.dtb: /soc@0/can@401be000: failed to match any schema with compatible: ['nxp,s32g3-flexcan', 'nxp,s32g2-flexcan']
arch/arm64/boot/dts/freescale/s32g399a-rdb3.dtb: /soc@0/can@402a8000: failed to match any schema with compatible: ['nxp,s32g3-flexcan', 'nxp,s32g2-flexcan']
arch/arm64/boot/dts/freescale/s32g399a-rdb3.dtb: /soc@0/can@402a8000: failed to match any schema with compatible: ['nxp,s32g3-flexcan', 'nxp,s32g2-flexcan']
arch/arm64/boot/dts/freescale/s32g399a-rdb3.dtb: /soc@0/can@402b2000: failed to match any schema with compatible: ['nxp,s32g3-flexcan', 'nxp,s32g2-flexcan']
arch/arm64/boot/dts/freescale/s32g399a-rdb3.dtb: /soc@0/can@402b2000: failed to match any schema with compatible: ['nxp,s32g3-flexcan', 'nxp,s32g2-flexcan']
arch/arm64/boot/dts/freescale/s32g274a-evb.dtb: /soc@0/can@401b4000: failed to match any schema with compatible: ['nxp,s32g2-flexcan']
arch/arm64/boot/dts/freescale/s32g274a-evb.dtb: /soc@0/can@401be000: failed to match any schema with compatible: ['nxp,s32g2-flexcan']
arch/arm64/boot/dts/freescale/s32g274a-evb.dtb: /soc@0/can@402a8000: failed to match any schema with compatible: ['nxp,s32g2-flexcan']
arch/arm64/boot/dts/freescale/s32g274a-evb.dtb: /soc@0/can@402b2000: failed to match any schema with compatible: ['nxp,s32g2-flexcan']
arch/arm64/boot/dts/freescale/s32g274a-rdb2.dtb: /soc@0/can@401b4000: failed to match any schema with compatible: ['nxp,s32g2-flexcan']
arch/arm64/boot/dts/freescale/s32g274a-rdb2.dtb: /soc@0/can@401be000: failed to match any schema with compatible: ['nxp,s32g2-flexcan']
arch/arm64/boot/dts/freescale/s32g274a-rdb2.dtb: /soc@0/can@402a8000: failed to match any schema with compatible: ['nxp,s32g2-flexcan']
arch/arm64/boot/dts/freescale/s32g274a-rdb2.dtb: /soc@0/can@402b2000: failed to match any schema with compatible: ['nxp,s32g2-flexcan']






