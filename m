Return-Path: <linux-kernel+bounces-410873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 787AE9CEBED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED642828A2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0C31D5169;
	Fri, 15 Nov 2024 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMgqNLvI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304F81D515A;
	Fri, 15 Nov 2024 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683586; cv=none; b=PsgxEomrJh9oYz5LWK9slCTPsI58BZMA58PdonuJaFYz5DHDCw+siATqG48exlxwnEivj7TgVHAlQkqcFaUdM7YHdxktMvpYIwPi8AtFGk6OXbMSrZyPB5aO048mZbpLV7IW252PGw98G3ymBZHgFW7+tbX2puWJxthLNF78NiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683586; c=relaxed/simple;
	bh=Hr/+s0xUJhzrAMfMlo9jseH7gO5RsSZov0OYJtU1M40=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=M4tVZBrCYQiSWhkg3TnBv6jCg4ICWsLkHRgRuZxxc25KBjCikqvrAgFdf2ujtZxjkYvHGWX+4NMLUmT3dxZGzOA0dQpIF0gvUrNRND0NIKjEwGDjGagmteXIoWWkSOBC30/TiVcZPgLVk++xpGuLwQSdb7x/ndFDcLPHqiqyZoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMgqNLvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F697C4CED2;
	Fri, 15 Nov 2024 15:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731683585;
	bh=Hr/+s0xUJhzrAMfMlo9jseH7gO5RsSZov0OYJtU1M40=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=bMgqNLvIj0KSNdhi172yJxZJ+4rDfFehZAoc5JIXcq81rGYWCCsDGKJMVHyD1y7kY
	 ZRP+udz5r080bjG93HaFEH0nJyW/qzc5Lj1soWPBPfk9jLhLVusoBPD/+gzvaKsyeB
	 fURhPwM6OTfnd/Ch7ebaKGhmNxgV6PpXZNNARu1duK1UmJomSlZrYDUQogIQ/1YaeR
	 OwHxxKLFRrPHX/t0YEECkRoR1PwGB/VnqqKePeehefOG3aiN9xNn1uTlVWfcJ6opNQ
	 MZ2vGshYIYWTzGdpnwm+jNXpimJ1XMJ8P6+4teqD8Md5NeGhFZH6afRqHLcUe6p8Nh
	 lMqYWQPqcbVfA==
Date: Fri, 15 Nov 2024 09:13:03 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, devicetree@vger.kernel.org, 
 Jisheng Zhang <jszhang@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>, 
 Albert Ou <aou@eecs.berkeley.edu>
To: E Shattow <e@freeshell.de>
In-Reply-To: <20241114201805.24143-2-e@freeshell.de>
References: <20241114201805.24143-2-e@freeshell.de>
Message-Id: <173168321484.2749832.8147306978765028453.robh@kernel.org>
Subject: Re: [PATCH] riscv: dts: starfive: jh7110-milkv-mars: set host mode
 and vbus pin for on-chip USB 2.0


On Thu, 14 Nov 2024 12:13:40 -0800, E Shattow wrote:
> Enable host mode USB for Milk-V Mars by setting host mode and connect vbus
> pinctrl.
> 
> Note that testing this functionality depends on two features:
> 
> 1.  commit e10c52e7e064038d9bd67b20bf4ce92077d7d84e "phy: starfive:
> jh7110-usb: Fix link configuration to controller"
> 
> 2. Setting the USB over-current register to disable. This is done at
> bootloader phase, for example U-Boot:
> https://patchwork.ozlabs.org/project/uboot/patch/20241012031328.4268-6-minda.chen@starfivetech.com/
> 
> If the over-current register is not prepared for us then the result is no
> change in functional outcome with this patch applied; there is an error
> visible to the user and usb configuration fails (same as it is now).
> 
> Signed-off-by: E Shattow <e@freeshell.de>
> ---
>  .../boot/dts/starfive/jh7110-milkv-mars.dts    | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
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


New warnings running 'make CHECK_DTBS=y starfive/jh7110-milkv-mars.dtb' for 20241114201805.24143-2-e@freeshell.de:

arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dtb: pinctrl@13040000: usb0-0: 'driver-vbus-pin' does not match any of the regexes: '-pins$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pinctrl/starfive,jh7110-sys-pinctrl.yaml#






