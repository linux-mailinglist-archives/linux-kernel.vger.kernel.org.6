Return-Path: <linux-kernel+bounces-192817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1848D22A6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB471C22D11
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F9E45C07;
	Tue, 28 May 2024 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7OLECoC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2AE44C8C;
	Tue, 28 May 2024 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716918104; cv=none; b=R+1H+C3xMP70hvFLYcMqO++kCZbpUuIb1aok8TEYM8tNxZYhtHmIrgdcBqle+phTEXwdlKQxrG8F9rDkAaYc4VACgLj25c33v4f7xH/OUyQREWOYT/X2uSd4MWek/c6OrXHR8KxfDAMrz+29ic/HtimxYGUWWib2D+ziVDJ+5+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716918104; c=relaxed/simple;
	bh=e+BPjxe3d8PDjUGG2dqqLNc9UzdlT+DF7Tk18em5PEk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=QVNlXzmXYCDBU5Q8RVgQtqb5AxpTnwclFRuj5ZorGnlZlr3HFzvRziNnLzp0PPVAXglvuDXxmMNln+yY29H+7srLPG8Xn/AQx18CctNIPx1L5ewlr2E+c9omr89ToV+ctvnk9gtSHl12wrxnj6A9B7ZJtx17uvUONUtAE4iTYgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7OLECoC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CA8C4AF09;
	Tue, 28 May 2024 17:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716918103;
	bh=e+BPjxe3d8PDjUGG2dqqLNc9UzdlT+DF7Tk18em5PEk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=U7OLECoCWbZiaYv+ryxiyHK1n+Y0z/uH3yfXA6PVTjY/g6ij6djKqsjTCe+cffQGY
	 IouzQ5ETeMSItUIxySzKTiQoWxOE16q/nUehVNwRo/P+79uqhLVMKYskfWki4d/02T
	 sTXGXacuSwsWUIT3XIePlA+tTmkNvHyYS6aQOngKWrn7HRzZdzKpnW5zNLpOn1u4SF
	 Hv9Df/Q1zvidvjytHUQl9bRNxl9+i8JfMiJfV1/8/P1UOMV1Q/qhhH5iDa4jqQ7R/9
	 qvo9IfiLXANgo5awACX4faw6ujMh6g94vZYLurtC/FkQuCnBcb39GFoTIRi228+gXs
	 rfVkrxsxBGugw==
Date: Tue, 28 May 2024 12:41:42 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Chao Wei <chao.wei@sophgo.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Inochi Amaoto <inochiama@outlook.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Conor Dooley <conor+dt@kernel.org>, 
 Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Chen Wang <unicorn_wang@outlook.com>, devicetree@vger.kernel.org, 
 Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240527-sg2002-v1-0-1b6cb38ce8f4@bootlin.com>
References: <20240527-sg2002-v1-0-1b6cb38ce8f4@bootlin.com>
Message-Id: <171691793360.1180650.2832719288980549545.robh@kernel.org>
Subject: Re: [PATCH 0/5] Add board support for Sipeed LicheeRV Nano


On Mon, 27 May 2024 12:28:16 +0200, Thomas Bonnefille wrote:
> The LicheeRV Nano is a RISC-V SBC based on the Sophgo SG2002 chip. Adds
> minimal device tree files for this board to make it boot to a basic
> shell.
> 
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> ---
> Thomas Bonnefille (5):
>       dt-bindings: interrupt-controller: Add SOPHGO SG2002 plic
>       dt-bindings: timer: Add SOPHGO SG2002 clint
>       dt-bindings: riscv: Add Sipeed LicheeRV Nano board compatibles
>       riscv: dts: sophgo: Add initial SG2002 SoC device tree
>       riscv: dts: sophgo: Add LicheeRV Nano board device tree
> 
>  .../interrupt-controller/sifive,plic-1.0.0.yaml    |  1 +
>  .../devicetree/bindings/riscv/sophgo.yaml          |  4 +++
>  .../devicetree/bindings/timer/sifive,clint.yaml    |  1 +
>  arch/riscv/boot/dts/sophgo/Makefile                |  1 +
>  .../boot/dts/sophgo/sg2002-lichee-rv-nano.dts      | 25 ++++++++++++++++++
>  arch/riscv/boot/dts/sophgo/sg2002.dtsi             | 30 ++++++++++++++++++++++
>  6 files changed, 62 insertions(+)
> ---
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
> change-id: 20240515-sg2002-93dce1d263be
> 
> Best regards,
> --
> Thomas Bonnefille <thomas.bonnefille@bootlin.com>
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


New warnings running 'make CHECK_DTBS=y sophgo/sg2002-lichee-rv-nano.dtb' for 20240527-sg2002-v1-0-1b6cb38ce8f4@bootlin.com:

arch/riscv/boot/dts/sophgo/sg2002-lichee-rv-nano.dtb: oscillator: 'clock-frequency' is a required property
	from schema $id: http://devicetree.org/schemas/clock/fixed-clock.yaml#






