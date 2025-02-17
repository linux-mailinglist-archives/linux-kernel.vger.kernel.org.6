Return-Path: <linux-kernel+bounces-517468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2481A3814F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1489616EF9F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4120621771F;
	Mon, 17 Feb 2025 11:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BveExQw5"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AA02165E2;
	Mon, 17 Feb 2025 11:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790120; cv=none; b=ov/BJBt+o90XGIgXBWbNW0/dGZtoYyPJ13FpmmP3LQxss9K6zmY3Ex6jt8a/7vfGL0L9Spi4F75py+aYZ5ztb1L3aK39QCEtpMhIYpmIqHFhJEDCkxJwxiK0QRzRnv/Ulyaog/ufh+ZzMpHzzSjU7uyuPEJQ/ltNdSGg6iQk1k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790120; c=relaxed/simple;
	bh=Tu48/rbE2ubClX8pcW9lLN49ds9R7q4WjcD1+R9Wd3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cB129Yf1iZe97EzMyPDAjo/jAKhGM4iZZ8nI2fF2Dh66TbRrev9NXQc7LUkqpJrPjX0LCpf78SNaZfTmBhRhLm29R082yEhYEBNtutCxRBqHYuEgmijdID3FcTyCX8XikrHCWMo/TTySQOAb6EtApVgeY/9FRCN5TTQt8b/WRcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BveExQw5; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51HB1dqQ645577
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 17 Feb 2025 05:01:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739790099;
	bh=BpLhwj82ljP6BWCPze3kv+WGHqGB/Kweoia9J1dReqA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=BveExQw5MYWQ53bkpSQsvFS2hbRkI1cl9dY5MXbI95HsbRRGtjPP1nK/B0Pdb07um
	 a87ZiVE1c9SiELSdDe0m55SzRf++EcfPubzFNil+ndbIkOys9yWXpFX0W0TsrxKvxp
	 Elof3S/hqB9mcpwZFD/OD2+ft6ja3zmyxGWnlgX8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51HB1dhI122938;
	Mon, 17 Feb 2025 05:01:39 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 17
 Feb 2025 05:01:38 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 17 Feb 2025 05:01:39 -0600
Received: from [172.24.22.234] (lt5cd2489kgj.dhcp.ti.com [172.24.22.234])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51HB1Zg9077443;
	Mon, 17 Feb 2025 05:01:35 -0600
Message-ID: <d4a4c96a-819b-4332-9a8b-5eab0fc7e78f@ti.com>
Date: Mon, 17 Feb 2025 16:31:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-j742s2-main-common: Correct the
 GICD size
To: Keerthy <j-keerthy@ti.com>, <robh+dt@kernel.org>, <nm@ti.com>,
        <vigneshr@ti.com>, <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzk+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
References: <20250217103814.2657-1-j-keerthy@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250217103814.2657-1-j-keerthy@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 2/17/2025 4:08 PM, Keerthy wrote:
> Currently we get the warning:
>
> "GICv3: [Firmware Bug]: GICR region 0x0000000001900000 has
> overlapping address"
>
> As per TRM GICD is 64 KB. Fix it by correcting the size of GICD.

Please add fixes tag

Fixes: 9cc161a4509c ("arm64: dts: ti: Refactor J784s4 SoC files to a 
common file")
Fixes: 4664ebd8346a ("arm64: dts: ti: Add initial support for J784S4 SoC")


>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> index 83bbf94b58d1..3b72fca158ad 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> @@ -193,7 +193,7 @@
>   		ranges;
>   		#interrupt-cells = <3>;
>   		interrupt-controller;
> -		reg = <0x00 0x01800000 0x00 0x200000>, /* GICD */
> +		reg = <0x00 0x01800000 0x00 0x10000>, /* GICD */
>   		      <0x00 0x01900000 0x00 0x100000>, /* GICR */
>   		      <0x00 0x6f000000 0x00 0x2000>,   /* GICC */
>   		      <0x00 0x6f010000 0x00 0x1000>,   /* GICH */

