Return-Path: <linux-kernel+bounces-536097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD32A47B83
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C3F16D4D7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41DF2253BC;
	Thu, 27 Feb 2025 11:08:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DAB224226;
	Thu, 27 Feb 2025 11:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654519; cv=none; b=FLscyB33n+Cd0LU0iGXazPvtNOQ3zY49Urc0XOXljg2ldgicOA/IAE9BTiddFisuL1B2N2hnRs4KvPF1VwF0LKUQAL5TR5qzEDNKHSzR3xKSGL8+24CEIZvzdN81Kkf2Y9XYV4Ix0fdKtAXL/cKbc5InITo7c/hxRXvaM9bqAZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654519; c=relaxed/simple;
	bh=XO2jfTI107R+rb5azefOUZU+vtLmfEnZbkQ+3/fyhEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bz+/Vf5j79P0zltP8b0YAujVRO2s1BlAEkSSlLHabnBDyWW5xC1/0EiVmqInkvisAOAUtP8pRoLbbwj2GcYi4A8sxG7n4EA8hSyjtLqGI50bHlJyL15jaWNR6UCVGz4POQjEY5b4HlzGGigWJgXXXF2tZqj+W6TFxkc8rP0qCMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D84A2BCC;
	Thu, 27 Feb 2025 03:08:51 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C90A3F6A8;
	Thu, 27 Feb 2025 03:08:33 -0800 (PST)
Date: Thu, 27 Feb 2025 11:08:30 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jessica Clarke <jrtc27@jrtc27.com>
Subject: Re: [PATCH v7 07/10] arm64: dts: morello: Add support for common
 functionalities
Message-ID: <Z8BHrrL0kXeBmRpx@bogus>
References: <20250221180349.1413089-1-vincenzo.frascino@arm.com>
 <20250221180349.1413089-8-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221180349.1413089-8-vincenzo.frascino@arm.com>

On Fri, Feb 21, 2025 at 06:03:46PM +0000, Vincenzo Frascino wrote:
> The Morello architecture is an experimental extension to Armv8.2-A,
> which extends the AArch64 state with the principles proposed in
> version 7 of the Capability Hardware Enhanced RISC Instructions
> (CHERI) ISA.
> 
> The Morello Platform (soc) and the Fixed Virtual Platfom (fvp) share
> some functionalities that have conveniently been included in
> morello.dtsi to avoid duplication.
> 
> Introduce morello.dtsi.
> 
> Note: Morello fvp will be introduced with a future patch series.
> 
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/boot/dts/arm/morello.dtsi | 323 +++++++++++++++++++++++++++
>  1 file changed, 323 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/arm/morello.dtsi
> 
> diff --git a/arch/arm64/boot/dts/arm/morello.dtsi b/arch/arm64/boot/dts/arm/morello.dtsi
> new file mode 100644
> +
> +		gic: interrupt-controller@2c010000 {
> +			compatible = "arm,gic-v3";
> +			reg = <0x0 0x30000000 0x0 0x10000>,	/* GICD */
> +			      <0x0 0x300c0000 0x0 0x80000>;	/* GICR */

[...]

> +
> +
> +		sram: sram@45200000 {
> +			compatible = "mmio-sram";
> +			reg = <0x0 0x06000000 0x0 0x8000>;
> +			ranges = <0 0x0 0x06000000 0x8000>;
> +

[...]

Not sure if you are not seeing these warnings from DTC. Looks pretty clear
to me. May be you missed or using some old DTC. I don't know why though.
If you agree, I can patch it up with below patch and no need to repost:

morello.dtsi:227.38-272.5: Warning (simple_bus_reg): /soc/interrupt-controller@2c010000: simple-bus unit address format error, expected "30000000"
morello.dtsi:296.23-313.5: Warning (simple_bus_reg): /soc/sram@45200000: simple-bus unit address format error, expected "6000000"
morello.dtsi:227.38-272.5: Warning (simple_bus_reg): /soc/interrupt-controller@2c010000: simple-bus unit address format error, expected "30000000"
morello.dtsi:296.23-313.5: Warning (simple_bus_reg): /soc/sram@45200000: simple-bus unit address format error, expected "6000000"

Regards,
Sudeep

-->8

diff --git i/arch/arm64/boot/dts/arm/morello.dtsi w/arch/arm64/boot/dts/arm/morello.dtsi
index e35e5e482720..0bab0b3ea969 100644
--- i/arch/arm64/boot/dts/arm/morello.dtsi
+++ w/arch/arm64/boot/dts/arm/morello.dtsi
@@ -224,7 +224,7 @@ uart0: serial@2a400000 {
                        status = "disabled";
                };

-               gic: interrupt-controller@2c010000 {
+               gic: interrupt-controller@30000000 {
                        compatible = "arm,gic-v3";
                        reg = <0x0 0x30000000 0x0 0x10000>,     /* GICD */
                              <0x0 0x300c0000 0x0 0x80000>;     /* GICR */
@@ -293,7 +293,7 @@ mailbox: mhu@45000000 {
                        clock-names = "apb_pclk";
                };

-               sram: sram@45200000 {
+               sram: sram@6000000 {
                        compatible = "mmio-sram";
                        reg = <0x0 0x06000000 0x0 0x8000>;
                        ranges = <0 0x0 0x06000000 0x8000>;


