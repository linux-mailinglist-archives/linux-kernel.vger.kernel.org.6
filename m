Return-Path: <linux-kernel+bounces-222055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C67190FC35
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 720A21C22EC8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 05:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC1F36126;
	Thu, 20 Jun 2024 05:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OAsfG+pf"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F22A1EEFC;
	Thu, 20 Jun 2024 05:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718861719; cv=none; b=j15qUO3bmuSaNsPe1hutJZIyNtSXbLM0KX69A2GOXJHlBZSw6EOOu8NUY7pC1vf9Zjyp0JD1MWtajGCZfWlYU+8VRiUo9KRRUfz1dwEcOLxqDWvudUP5k4r/OzJkbHFqysM/i2XyByUqycfR/bnl5nZP0Z6wR3/kStPQ+EFtOe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718861719; c=relaxed/simple;
	bh=Vf9T+7tWeRN7n8TUR8lR1u6ymwYkzPDqzSOENXar0KI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O3kdWjc1qnu8ZN7A5XfDhJsCOJqpiBU54j/VWnrNzV5FqT+u2JLB01lz73trs/Ou0AjXZ8aVqgvPVI7KfaBgAopRvIY3aNXwnt+0weCqV8tsEaGR8B6mTxFQBHIkE/IsCqwrbLQsFyuow3ZltITdCVtPKg0z0W3fUecToYPLaB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OAsfG+pf; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45K5YuUr080844;
	Thu, 20 Jun 2024 00:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718861696;
	bh=BShOhwlIAgzIEAPpYVZghIKZCGd+dk13oM7bFUNmrJc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=OAsfG+pfJTyr6H9c2diksIh4WWZ0Ti0QboMH1yfLLlwIppPWGJygS+FIRCOfNGQVE
	 S6kmfK41oysGGtdEfR/pm9DOHjZqOBSW5nHnMkuzvfK94VwEeBwnXqZ1Bb4gzNa0qr
	 aORHupNSOE3wNx19CzFk0zmGjvYlPC7aDfrRdQJE=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45K5YuFM061838
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Jun 2024 00:34:56 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 20
 Jun 2024 00:34:56 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 20 Jun 2024 00:34:56 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45K5YqaG070553;
	Thu, 20 Jun 2024 00:34:52 -0500
Message-ID: <8e49039a-e700-49de-9b95-67babb4f3e8d@ti.com>
Date: Thu, 20 Jun 2024 11:04:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am642-tqma64xxl-mbax4xxl: add PRU
 Ethernet support
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Suman Anna
	<s-anna@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux@ew.tq-group.com>
References: <20240619112406.106223-1-matthias.schiffer@ew.tq-group.com>
 <20240619112406.106223-2-matthias.schiffer@ew.tq-group.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20240619112406.106223-2-matthias.schiffer@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Matthias,

On 19/06/24 4:54 pm, Matthias Schiffer wrote:
> Add PRU Ethernet controller and PHY nodes, as it was previously done for
> the AM64x EVM Device Trees.
> 
> Differing from the EVM, we add the virtual ethernet controller device
> below &icssg1 instead of the top level. Besides being slighly more
> accurate, this has the advantage that the node is implicitly disabled
> when &icssg1 has status = "disabled" (which the TQMa64xxL bootloader
> adds as a fixup when running on an AM64x variant without ICSSG support),
> thus avoiding leaving the ethernet device in EPROBE_DEFER limbo forever.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
> 
> k3-am642-evm.dts uses "ti-pruss/am64x-sr2-*" filenames instead of
> "ti-pruss/am65x-sr2-*", however it is not clear to me where these would
> come from - I'm not aware of any firmwares named like that.
> 

During upstreaming of icssg1-eth node in "k3-am642-evm.dts", it was
raised that the firmware name should be am64x-sr2* instead of am65x-sr2* [1]

> So far, these firmwares are not in mainline linux-firmware; TI's
> reference BSPs include firmware from ti-linux-firmware [1], and the same
> "am65x-sr2" firmwares are used on AM65x and AM64x SoCs.
> 

Yes currently the firmware used for both AM65x and AM64x is am65x-sr2*,
but that firmware name is not taken from device tree. It is directly
encoded in the driver. Plan is to have different firmware for both SoCs
in future and when that happens driver will read the firmware name from
device tree. For that case, the firmware name here is "am64x-sr2*"

[1] https://lore.kernel.org/all/20231207134343.ufiy2owik5kn3y2r@degrease/

> [1] https://git.ti.com/gitweb?p=processor-firmware/ti-linux-firmware.git;a=tree;f=ti-pruss;h=a220bdc6dce5e11845b5c6337ff9b2d329aee196;hb=refs/heads/ti-linux-firmware
> 
>  .../dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts    | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
> index 1f4dc5ad1696a..0eff392a29b00 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
> @@ -24,6 +24,8 @@ / {
>  
>  	aliases {
>  		ethernet0 = &cpsw_port1;
> +		ethernet1 = &icssg1_emac0;
> +		ethernet2 = &icssg1_emac1;
>  		i2c1 = &mcu_i2c0;
>  		mmc1 = &sdhci1;
>  		serial0 = &mcu_uart0;
> @@ -154,6 +156,104 @@ &epwm5 {
>  	status = "okay";
>  };
>  
> +&icssg1 {
> +	icssg1_eth: ethernet {
> +		compatible = "ti,am642-icssg-prueth";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pru_icssg1_rgmii1_pins>, <&pru_icssg1_rgmii2_pins>;
> +		interrupt-parent = <&icssg1_intc>;
> +		interrupts = <24 0 2>, <25 1 3>;
> +		interrupt-names = "tx_ts0", "tx_ts1";
> +		dmas = <&main_pktdma 0xc200 15>, /* egress slice 0 */
> +		       <&main_pktdma 0xc201 15>, /* egress slice 0 */
> +		       <&main_pktdma 0xc202 15>, /* egress slice 0 */
> +		       <&main_pktdma 0xc203 15>, /* egress slice 0 */
> +		       <&main_pktdma 0xc204 15>, /* egress slice 1 */
> +		       <&main_pktdma 0xc205 15>, /* egress slice 1 */
> +		       <&main_pktdma 0xc206 15>, /* egress slice 1 */
> +		       <&main_pktdma 0xc207 15>, /* egress slice 1 */
> +		       <&main_pktdma 0x4200 15>, /* ingress slice 0 */
> +		       <&main_pktdma 0x4201 15>; /* ingress slice 1 */
> +		dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
> +			    "tx1-0", "tx1-1", "tx1-2", "tx1-3",
> +			    "rx0", "rx1";
> +		sram = <&oc_sram>;
> +		firmware-name = "ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
> +				"ti-pruss/am65x-sr2-rtu0-prueth-fw.elf",
> +				"ti-pruss/am65x-sr2-txpru0-prueth-fw.elf",
> +				"ti-pruss/am65x-sr2-pru1-prueth-fw.elf",
> +				"ti-pruss/am65x-sr2-rtu1-prueth-fw.elf",
> +				"ti-pruss/am65x-sr2-txpru1-prueth-fw.elf";
> +		ti,prus = <&pru1_0>, <&rtu1_0>, <&tx_pru1_0>, <&pru1_1>, <&rtu1_1>, <&tx_pru1_1>;
> +		ti,pruss-gp-mux-sel = <2>,	/* MII mode */
> +				      <2>,
> +				      <2>,
> +				      <2>,	/* MII mode */
> +				      <2>,
> +				      <2>;
> +		ti,mii-g-rt = <&icssg1_mii_g_rt>;
> +		ti,mii-rt = <&icssg1_mii_rt>;
> +		ti,iep = <&icssg1_iep0>,  <&icssg1_iep1>;
> +
> +		ethernet-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			icssg1_emac0: port@0 {
> +				reg = <0>;
> +				phy-handle = <&icssg1_phy0c>;
> +				phy-mode = "rgmii-id";
> +				/* Filled in by bootloader */
> +				local-mac-address = [00 00 00 00 00 00];
> +			};
> +
> +			icssg1_emac1: port@1 {
> +				reg = <1>;
> +				phy-handle = <&icssg1_phy03>;
> +				phy-mode = "rgmii-id";
> +				/* Filled in by bootloader */
> +				local-mac-address = [00 00 00 00 00 00];
> +			};
> +		};
> +	};
> +};
> +
> +&icssg1_mdio {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pru_icssg1_mdio_pins>;
> +	status = "okay";
> +
> +	/* phy-mode is fixed up to rgmii-rxid by prueth driver to account for
> +	 * the SoC integration, so the only rx-internal-delay and no
> +	 * tx-internal-delay is set for the PHYs.
> +	 */
> +
> +	icssg1_phy03: ethernet-phy@3 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x3>;
> +		reset-gpios = <&main_gpio1 47 GPIO_ACTIVE_LOW>;
> +		reset-assert-us = <1000>;
> +		reset-deassert-us = <1000>;
> +		ti,rx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> +		ti,tx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> +		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> +		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
> +	};
> +
> +	icssg1_phy0c: ethernet-phy@c {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0xc>;
> +		reset-gpios = <&main_gpio1 51 GPIO_ACTIVE_LOW>;
> +		reset-assert-us = <1000>;
> +		reset-deassert-us = <1000>;
> +		ti,rx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> +		ti,tx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> +		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> +		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
> +	};
> +};
> +
> +
>  &main_gpio0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&main_gpio0_digital_pins>,


-- 
Thanks and Regards,
Danish

