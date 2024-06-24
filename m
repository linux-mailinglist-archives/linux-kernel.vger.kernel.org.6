Return-Path: <linux-kernel+bounces-227899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4929157E7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6005F28871D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566441A070A;
	Mon, 24 Jun 2024 20:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddr2JY4W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F29262A3;
	Mon, 24 Jun 2024 20:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719260575; cv=none; b=qQan26zUfMCKkI4rl+psN5vJSyncR5V4xr+S8gaybnLESdPizuOy9kUvUiP6eUuNA1J7ydvaSztFkomeuAx8xPWWaDy6dV0GicohwNYO1SCMG9x9M+Me5Dhn1KMNek1SwdkNX85O0sy7iNcKMbbs5erTLiHs+anNUlKXBFH0TEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719260575; c=relaxed/simple;
	bh=A/zQRlEpO+0XlJNbjsusRjw/4ZyJOMZILl5/J9OwYc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhD4UJSUVuMYrRX94jDlM7KskajZ6NIVKqLhIgzsIO0l6crQEGVUUrDPZOPRem10mKy3SejmLm9oWcyUyb02em5HqiaeOwZSo62wcXpe9yMjJFoGe6rmLsdmxRlOR3JgTXbU6C6O6vWnTFX5RCpuJL6odxg4hSHUO+P2BeYRGhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddr2JY4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2038C2BBFC;
	Mon, 24 Jun 2024 20:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719260575;
	bh=A/zQRlEpO+0XlJNbjsusRjw/4ZyJOMZILl5/J9OwYc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ddr2JY4WUSLLjAikiqIr/HMXtEVJZMG3qGxeC3ee7PxQULHLxNtsQio6ov3/BrZqP
	 zlo+W8k0eMJlrUyADp/oypITQhZS5+JGMRdkFvbXeP8/PFa9C1XIP602UHcJcy637r
	 BJ82w+ofKD/S7XJZfSdR5V2C3SRu5lzboedq0dtNTrTQYu4E3wwKq8B8mhOntnZgOt
	 GKDS2Yq2hXlQGVkTG59sK7LrskGO07aqCWZmV71hZZlch6nWir6vpWouILWCsEON6x
	 oeAupQ6230Wivh+K4xqcXvKe7C+14OCd7ExcPrkG/cK80XxllEay2camk+CiMao6vo
	 8BPrBumu5dnRQ==
Date: Mon, 24 Jun 2024 14:22:53 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kanak Shilledar <kanakshilledar@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	kanakshilledar111@protonmail.com,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [RESEND v4 1/2] dt-bindings: interrupt-controller:
 riscv,cpu-intc: convert to dtschema
Message-ID: <171926057171.343236.712031903649658549.robh@kernel.org>
References: <20240615021507.122035-1-kanakshilledar@gmail.com>
 <20240615021507.122035-2-kanakshilledar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240615021507.122035-2-kanakshilledar@gmail.com>


On Sat, 15 Jun 2024 07:45:03 +0530, Kanak Shilledar wrote:
> Convert the RISC-V Hart-Level Interrupt Controller (HLIC) to newer
> DT schema, Created DT schema based on the .txt file which had
> `compatible`, `#interrupt-cells` and `interrupt-controller` as
> required properties.
> Changes made with respect to original file:
> - Changed the example to just use interrupt-controller instead of
> using the whole cpu block
> - Changed the example compatible string.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
> ---
> Changes in v4:
> - Change DCO email to @gmail.com
> Changes in v3:
> - Remove reference to `interrupt-controller` in `riscv/cpus.yaml`.
> Changes in v2:
> - Update the maintainers list.
> - Add reference to `interrupt-controller` in `riscv/cpus.yaml`.
> - Update compatible property with the reference in `cpus.yaml`.
> - Include description for '#interrupt-cells' property.
> - Change '#interrupt-cells' property to have `const: 1` as per the
> text binding.
> - Fixed the warning thrown by `/renesas/r9a07g043f01-smarc.dtb`.
> ---
>  .../interrupt-controller/riscv,cpu-intc.txt   | 52 -------------
>  .../interrupt-controller/riscv,cpu-intc.yaml  | 73 +++++++++++++++++++
>  2 files changed, 73 insertions(+), 52 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.yaml
> 

Applied, thanks!


