Return-Path: <linux-kernel+bounces-300751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4856C95E7E9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 07:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00F81F21620
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 05:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D02E770F3;
	Mon, 26 Aug 2024 05:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="VpMkqhKR"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1BC74416
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 05:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724650201; cv=none; b=RGZidDjOSHUkq4BCi7z72lwloVJRdjVC390AkI6EP86PhAjkLJB/BtTkS4wECjYBHu18lS0uxdSzfro04hjuYZC+NFXrh2W4JFN+tFgRD74XxTyfaVAFsKxPPVENRCpNdT/VGXy8hmXu22YJd8RSeEXX9gRENWSEVn+QpVcqK5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724650201; c=relaxed/simple;
	bh=tqyl9jyvfW5D/WCsL5XIRYk+Gphu2NlhcYsQ0NnaDHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CrFCZePnFFexI1VZL2KT+3rrEkvDJJQhTISMwUOZxyq5fws8IdbgYkkpbKT9AYh+mX88OSiaRONCU416ujg2Qhmbl5kWcXsXDsCaLFY7QvmTMMGbr7i8hRYs+mI347tf4PdWaml2GNd9u8tlMIlmygVfPFVTY+Sz71Rxfc8TrhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=VpMkqhKR; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1724650185; x=1727242185;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tqyl9jyvfW5D/WCsL5XIRYk+Gphu2NlhcYsQ0NnaDHs=;
	b=VpMkqhKRCu+hajpfD4AE96c7Xv97kFUEz01H6KVcrVqZI83Qu1igskJP84aBE+6a
	EJbpKZZQ1TbytktgYgFRSRmkiM5MLVz97ZoIIhFw6/1U/SwbXbZ9op9apG+VusfK
	Okq96ATvZ9Tq1JZKLhB0bKs8VlHqtCJkVtAlf8m1vfA=;
X-AuditID: ac14000a-03e52700000021bc-e1-66cc12c916f3
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 5B.37.08636.9C21CC66; Mon, 26 Aug 2024 07:29:45 +0200 (CEST)
Received: from [192.168.178.33] (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 26 Aug
 2024 07:29:44 +0200
Message-ID: <4e884c6c-ec82-4229-a2a4-55da66cc284f@phytec.de>
Date: Mon, 26 Aug 2024 07:29:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am64* Disable ethernet by default
 at SoC level
To: Logan Bristol <logan.bristol@utexas.edu>
CC: Josua Mayer <josua@solid-run.com>, Wadim Egorov <w.egorov@phytec.de>,
	<linux@ew.tq-group.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, Conor
 Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
References: <20240809135753.1186-1-logan.bristol@utexas.edu>
Content-Language: en-US
From: Daniel Schultz <d.schultz@phytec.de>
In-Reply-To: <20240809135753.1186-1-logan.bristol@utexas.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWyRpKBR/ek0Jk0g67LwhZr9p5jsph/5Byr
	xfLJC9gtXs66x2ax6fE1VovLu+awWXxdd4bV4k/3ViaLNz/OMln8P/uB3YHL48WEf0wem1Z1
	snlsXlLv8a/1MbPH8RvbmTza9gV6fN4kF8AexWWTkpqTWZZapG+XwJWxczF/wUPxijcXVrA3
	MK4X6mLk5JAQMJHYf72RtYuRi0NIYAmTxM/+6ewQzn1GiWONHewgVbwCNhKPL09kBbFZBFQl
	Ht35ABUXlDg58wkLiC0qIC9x/9YMsLiwQLTEzUnnmEFsEQEdiadbO8CGMgs8YJKY+xqiSAho
	6LqVP8CamQXEJW49mc8EYrMJaEnc2TIXrJlTwFZi89tWRogaC4nFbw6yQ9jyEtvfzmGGmKMg
	MXvbZEaId+Qlpp17zQxhh0oc2bSaaQKj8Cwkt85Csm4WkrGzkIxdwMiyilEoNzM5O7UoM1uv
	IKOyJDVZLyV1EyMo3kQYuHYw9s3xOMTIxMF4iFGCg1lJhFfu8sk0Id6UxMqq1KL8+KLSnNTi
	Q4zSHCxK4ryrO4JThQTSE0tSs1NTC1KLYLJMHJxSDYyx65y6SzZvmcjgXsM07diNevHkx1v2
	ehX+7HOaE/ZgWfYF67/7uI+2OH0MWK5xrW0HwwIftc1aG4I/iU1xe3hwxvXdUfe/r1q3zDHw
	5cOwunpekW4+3diHRw9mSqf9+PrM4bfFdEH5EAW1itdnDjGJpV3raq+7FHtou8yLzBhLYxO5
	jXtSU7mUWIozEg21mIuKEwF15CJXpQIAAA==

Hey Logan,

my feedback is similar to Josua's.

On 09.08.24 15:57, Logan Bristol wrote:
> External interfaces should be disabled at the SoC DTSI level, since
> the node is incomplete. Disable Ethernet switch and ports in SoC DTSI
> and enable them in the board DTS. If the board DTS includes a SoM DTSI
> that completes the node description, enable the Ethernet switch and ports
> in SoM DTSI.
>
> Reflect this change in SoM DTSIs by removing ethernet port disable.
>
> Signed-off-by: Logan Bristol <logan.bristol@utexas.edu>
> ---
> Changes since v1:
> - Enabled cpsw3g and cpsw_port1 in SoM DTSI instead of board DTS
> if board DTS included SoM DTSI
> ---
>   arch/arm64/boot/dts/ti/k3-am64-main.dtsi               | 3 +++
>   arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi        | 6 ++----
>   arch/arm64/boot/dts/ti/k3-am642-evm.dts                | 3 +++
>   arch/arm64/boot/dts/ti/k3-am642-sk.dts                 | 3 +++
>   arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi            | 6 ++----
>   arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts | 6 ++----
>   6 files changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index f8370dd03350..69c5af58b727 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -677,6 +677,7 @@ cpsw3g: ethernet@8000000 {
>   		assigned-clock-parents = <&k3_clks 13 9>;
>   		clock-names = "fck";
>   		power-domains = <&k3_pds 13 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
>   
>   		dmas = <&main_pktdma 0xC500 15>,
>   		       <&main_pktdma 0xC501 15>,
> @@ -701,6 +702,7 @@ cpsw_port1: port@1 {
>   				phys = <&phy_gmii_sel 1>;
>   				mac-address = [00 00 00 00 00 00];
>   				ti,syscon-efuse = <&main_conf 0x200>;
> +				status = "disabled";
>   			};
>   
>   			cpsw_port2: port@2 {
> @@ -709,6 +711,7 @@ cpsw_port2: port@2 {
>   				label = "port2";
>   				phys = <&phy_gmii_sel 2>;
>   				mac-address = [00 00 00 00 00 00];
> +				status = "disabled";
>   			};
>   		};
>   
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> index ea7c58fb67e2..6bece2fb4e95 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> @@ -185,6 +185,7 @@ AM64X_IOPAD(0x0278, PIN_INPUT, 7)	/* (C19) EXTINTn.GPIO1_70 */
>   &cpsw3g {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&cpsw_rgmii1_pins_default>;
> +	status = "okay";
>   };
>   
>   &cpsw3g_mdio {
> @@ -208,10 +209,7 @@ cpsw3g_phy1: ethernet-phy@1 {
>   &cpsw_port1 {
>   	phy-mode = "rgmii-rxid";
>   	phy-handle = <&cpsw3g_phy1>;
The connected phy is located on the SOM and should be enabled by default.
> -};
> -
> -&cpsw_port2 {
> -	status = "disabled";
> +	status = "okay";
>   };

This port is routed to the carrier-board. Please drop this node.

Regards,
Daniel


