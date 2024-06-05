Return-Path: <linux-kernel+bounces-202677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5C78FCF7C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE29D1F22086
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334CA193085;
	Wed,  5 Jun 2024 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxCXSDuI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695F9143722;
	Wed,  5 Jun 2024 13:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717593095; cv=none; b=bIGEx5xOvAilmazl3gZZL3QcC3DWgwWsJtaF+nS2nf+hft1kA9BRgcTIFB2Eb+OKVstZRbJmFTqaiWX7/yPheCMTYn3mM8DTRe2Q9O7BgUfObuvvE58ji/4qKrl+K5bNMhf2VggS1CGMrUjiqVykbMY2G4yc4VPijt4bs4zf85o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717593095; c=relaxed/simple;
	bh=p1Mf5DG1LhyqB8wXqkjnzUXqy6sag24Z+F1LZfH0pEQ=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=cLWofx8xOal5iu1EA4TVm1VhP++P5t3xxFX4qdETPA08VTGn3StZvBs1jeusYAl/UDBzyg1L1s8TD4bs6WJnWejpug5tQwOH3rQiGJZ0o1p1nUtFXDGd+9Quoolo9BUfFzpZm4HnjWUkdPLbvAqN5AkySEVIWxGp9wU1q6ZEzjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxCXSDuI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E70C3277B;
	Wed,  5 Jun 2024 13:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717593094;
	bh=p1Mf5DG1LhyqB8wXqkjnzUXqy6sag24Z+F1LZfH0pEQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=AxCXSDuIbI9ABphc+MtPB9Swb+NEhUSK4Setoo6PWjDy2kz9THhj9T83HAtduj5zD
	 zCb7UnP/FU46eA80JDJX5jkXO+nn4E+Bx5gFgXIi773vzBj0Q4uwRDSa39NAcb4zcA
	 WuItGcB2a/CHQtIBreJsKho8GZV4Yu04JhhDzudISPRA2Z8BU2Kj0nAJ3X5GuWQhRa
	 RzeMIxE5DmeFsvAh8g8wMpuQ9WbXCdJQDiv7ooeaQcSt91KfgSNxHbo4RNgi3Y+ArJ
	 s+KEhHh4FIk/bEH++xMbh04Xy9iR/Ex2/0jNnHfbjehFDxgsAtwNOrmYN0WAVf8gHv
	 qJ3E5DTkPFSUw==
Date: Wed, 05 Jun 2024 07:11:32 -0600
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
Cc: andrew@codeconstruct.com.au, krzk+dt@kernel.org, conor+dt@kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-aspeed@lists.ozlabs.org, joel@jms.id.au, eajames@linux.ibm.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240604215939.1967329-1-ninad@linux.ibm.com>
References: <20240604215939.1967329-1-ninad@linux.ibm.com>
Message-Id: <171759284804.2200781.9915039390039475490.robh@kernel.org>
Subject: Re: [PATCH v1] ARM: dts: aspeed: System1: Updates to BMC board


On Tue, 04 Jun 2024 16:59:39 -0500, Ninad Palsule wrote:
> - Added new power monitor device max5970
> - Changed temperature sensor monitor chip from tmp423 to tmp432
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
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


New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-ibm-system1.dtb' for 20240604215939.1967329-1-ninad@linux.ibm.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: power-monitor@3a: 'regulators' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/maxim,max5970.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: power-monitor@3a: 'vss1-supply' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/maxim,max5970.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: power-monitor@3a: 'vss2-supply' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/maxim,max5970.yaml#






