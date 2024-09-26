Return-Path: <linux-kernel+bounces-339816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B30B4986AF0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 04:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 137C6B24945
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 02:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A03D175D2C;
	Thu, 26 Sep 2024 02:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZVLq0Vy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A707C37B;
	Thu, 26 Sep 2024 02:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727317645; cv=none; b=gLoWPf0dz4H5YYHIqUAEm1H7E6//tZm6FOIav+ejj3HO6+ykI8LKlv5VAF2W9D/f+xVoQ1o7rpStWmjyhxY58pvgfP3RM5kaM80ZsAAkJnqMQDIfNHnBEr1rldYibsegGAoe+iKEy1GB/mkiaN0UTk9QEoQNWh/vMyLrib6yd5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727317645; c=relaxed/simple;
	bh=oAyorxBPm/Cikm3nZpdbR5EcjR6Sl2EVi3nU6qHTpJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNOnXK1n5aGBLikDaXHdsHskOmKo6dRkgNcVA2+G13MWsrQocKiJ/yerk9HtTN3yvnvr1QTv/LRrfHU/Q+BRRYvY8XAEOu+byC3PUXYLTOQwQeKy57GLHn4+qI6XCGsMl99QMWVpos+jebbbtLXiFvemMtc3N/EWP+6BspC1Rs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZVLq0Vy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C276C4CEC3;
	Thu, 26 Sep 2024 02:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727317645;
	bh=oAyorxBPm/Cikm3nZpdbR5EcjR6Sl2EVi3nU6qHTpJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MZVLq0Vy+vdaWyht46uOgx/XtHk9NtrDA9rxwmswKHp7HNhxpPntd6umjikaEY9+Y
	 sIRs3cmIPCvfEiK6DdfiNaIWy/3KyWSZHW58ApaDFvpuQSniX0qKqa8skFnZUbUczm
	 NIpURJkKWJMEHK/+CNqH8tpb1J4bUbo4qJteFxkIjM1cwWQU3pdeB/euIEMi19XJNW
	 nT8PX/OpxeYdQpLE4Q7tEsP22wBPKyEift32WVp6NFLJvG7R1x0ml8gRHLC1SZUFLp
	 +lZRxq7Wxgy6PzwfWItXQtcsBdgyoOF/MbAPyXRhKP8ySbb9OhxaBJJuxyE4WDvGMX
	 k6cN29VoFUUFQ==
Date: Wed, 25 Sep 2024 21:27:24 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sandie Cao <sandie.cao@deepcomputing.io>
Cc: Heiko Stuebner <heiko.stuebner@cherry.de>, huiming.qiu@deepcomputing.io,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Drew Fustini <drew@beagleboard.org>, devicetree@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>, ams@frame.work,
	linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
	yuning.liang@deepcomputing.io, Palmer Dabbelt <palmer@dabbelt.com>,
	dhs@frame.work, Emil Renner Berthing <kernel@esmil.dk>,
	gregkh@linuxfoundation.org, rafal@milecki.pl,
	Michael Zhu <michael.zhu@starfivetech.com>,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 2/3] dt-bindings: riscv: starfive: add
 deepcomputing,fm7110
Message-ID: <172731764343.2408451.17518519713927654729.robh@kernel.org>
References: <20240925053123.1364574-3-sandie.cao@deepcomputing.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925053123.1364574-3-sandie.cao@deepcomputing.io>


On Wed, 25 Sep 2024 13:31:22 +0800, Sandie Cao wrote:
> Add deepcomputing,fm7110 into compatible list.
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
>  Documentation/devicetree/bindings/riscv/starfive.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


