Return-Path: <linux-kernel+bounces-339261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F14389861CC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A758328919F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E02918DF9C;
	Wed, 25 Sep 2024 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9FsN7sR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF8D18DF83;
	Wed, 25 Sep 2024 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727275002; cv=none; b=mRJM4QoQB6kBWZ2v25/BFHKmeMh5HRi6nIY8ylsMqO2C4jq4GFfJFDtRpKL7YresjgCWvuj4FUGQJsC7c1KAqSfjPu8m8YhwDFmj7r53lw1qgDuqr1M1bqyb8tdDvvrOg0hY7IJFhsEm7fhLCt/QM5has1goxD1WfhQQP/3fPFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727275002; c=relaxed/simple;
	bh=JWmdh7A01tfztYB9pqxCAJiTL8p44I/Kc7cDX8hcRIo=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=FyCRX0Kj2LXfT9WiH+z0aPyWYX0oL0P+cNSQT0TPp1es61IUIVe1zu2wM+8PnkhNEUICBJNPWKlQty4leIbyzps9hn8gmDTtnfS1CUjn5YFHctf9jspoDv5Vu3JhhTsygRnrBPwm9E9EC/ZxzYrk8MszryiywVXGPaAFSL+9FPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9FsN7sR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E026DC4CEC3;
	Wed, 25 Sep 2024 14:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727275002;
	bh=JWmdh7A01tfztYB9pqxCAJiTL8p44I/Kc7cDX8hcRIo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=T9FsN7sRoR0szzFVuu9nIQRq0qy8q+DLT0k5B1kV256MTRrEGkDeL9GJ1t4SPDItw
	 dvFjZX2FADcny4kqznGxavW61J/NpL9JIJGdr+6bytLo7Bj1QeCc4zGZpGxfVPaHks
	 ukydyrbMap3O1Tku+e2+o6mtIWGLQK3tbVAmJ5I78dH/wcJEbX1NdIffNitx0qyqui
	 I/ZGtklzTemACkCijfm3tk24Uv58/Q7wEEufVrVPqw4ZYS9jk+FmocYAXEEsE7I14z
	 OnbvDkpiZ7iZPG0ao2W1abiqkSFMiRdLlMMjM4YcnUYiwhC6/JHdkNQu1ONLu/OrFg
	 v/4iAVX/1NTeA==
Date: Wed, 25 Sep 2024 09:36:41 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sandie Cao <sandie.cao@deepcomputing.io>
Cc: yuning.liang@deepcomputing.io, Conor Dooley <conor@kernel.org>, 
 Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Drew Fustini <drew@beagleboard.org>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, gregkh@linuxfoundation.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, rafal@milecki.pl, 
 dhs@frame.work, linux-riscv@lists.infradead.org, 
 Emil Renner Berthing <kernel@esmil.dk>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Michael Zhu <michael.zhu@starfivetech.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, huiming.qiu@deepcomputing.io, 
 ams@frame.work
In-Reply-To: <20240925053123.1364574-4-sandie.cao@deepcomputing.io>
References: <20240925053123.1364574-4-sandie.cao@deepcomputing.io>
Message-Id: <172727480703.1213985.11388868881210687280.robh@kernel.org>
Subject: Re: [PATCH v3 3/3] riscv: dts: starfive: add framework dts


On Wed, 25 Sep 2024 13:31:23 +0800, Sandie Cao wrote:
> Add framework dts to support RISC-V Framework Laptop 13 Mainboard.
> 
> 
> DeepComputing is creating a RISC-V Framework Laptop 13 Mainboard
> powered by a StarFive JH7110 processor.This is a developer-focused
> product, aimed at making tinkering with RISC-V more accessible.
> The Mainboard is under development and we'll share more on functionality,
> compatibility, and availability as the program progresses.
> 
> For this Mainboard, the Model name in Framework is Framework FRANME0000;
> the Model name in DeepComputing is DeepComputing fm7110.
> 
> The board features:
> 
> - JH7110 SoC
> - 8 GiB LPDDR4 DRAM
> - 1x Type-c(PD3.0:60W Max;usb3.2 Gen1;usb2.0;DP1.4:4K@30Hz/2.5K@60Hz)
> - 1x Type-c(PD3.0:60W Max,usb3.2 Gen1;usb2.0)
> - 2x Type-c(usb3.2 Gen1;usb2.0)
> - 1x eMMC slot Support 32G/128G
> - 1x MicroSD slot
> - 1x QSPI Flash
> - 1x PCIe Wi-Fi (Support AMD RZ616 Wi-Fi 6E,Intel Wi-Fi 6E AX210 No vPro)
> 
> Signed-off-by: Sandie Cao <sandie.cao@deepcomputing.io>
> ---
>  arch/riscv/boot/dts/starfive/Makefile         |  1 +
>  .../boot/dts/starfive/jh7110-framework.dts    | 34 +++++++++++++++++++
>  2 files changed, 35 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-framework.dts
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


New warnings running 'make CHECK_DTBS=y starfive/jh7110-framework.dtb' for 20240925053123.1364574-4-sandie.cao@deepcomputing.io:

arch/riscv/boot/dts/starfive/jh7110-framework.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
	'deepcomputing,fm7110' is not one of ['beagle,beaglev-starlight-jh7100-r0', 'starfive,visionfive-v1']
	'deepcomputing,fm7110' is not one of ['milkv,mars', 'pine64,star64', 'starfive,visionfive-2-v1.2a', 'starfive,visionfive-2-v1.3b']
	'starfive,jh7100' was expected
	from schema $id: http://devicetree.org/schemas/riscv/starfive.yaml#
arch/riscv/boot/dts/starfive/jh7110-framework.dtb: /: failed to match any schema with compatible: ['deepcomputing,fm7110', 'starfive,jh7110']






