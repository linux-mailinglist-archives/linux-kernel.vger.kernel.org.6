Return-Path: <linux-kernel+bounces-387216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEA39B4E0A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCB151C226F7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B071957E2;
	Tue, 29 Oct 2024 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="OVNmKCRk"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F4A194AE2;
	Tue, 29 Oct 2024 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215874; cv=none; b=Bjyg2CaGYMfk3cGsqabD5JLZcGBHstiJ48QxvK6cETKVzAdBWwqJ9/JSWg3xYbFl6OxMhdjwMzK0I4oaHwQXVWn42Lj+XeHYYfzmW19QxJP3W1aaFDyqlqXJtoh9YPrlWBARLSGwwWSCDp2xdelOV6AXPvJOrid9994mEavooe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215874; c=relaxed/simple;
	bh=u0a3xitznGjPe3Siy+gZjTTUWi1lTkXvONBb6XAU1Cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ApOSu4Od8oqB/vxFbiiX8TiVxHqxsjUMYVCWwHoDpdgVCSF1LX2me6299WfCD9MG1dAs5RI0ZLxpRMQykv1VlBlhichEUCnZamUxNmst7TIchi7OjDJA91HYoWSJ3Afa7JtlsKQw7mxAxe/3vkgS6xYnQZoGQ9Xs0LspFy4ARss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=OVNmKCRk; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TCRjnj014244;
	Tue, 29 Oct 2024 16:30:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	R+/H3pqYnfyIgN4uUTX5uKa1/8V4zVKPQSaYRI/UZRA=; b=OVNmKCRko1YzY2kL
	5Z4zEd9acvr9AXfrhBP3j4XJ3vOlg+SkFkMqjbC+p1GB9ZRKKothnz5GqlN3nfJn
	t/lqY+G/f7lpgiWsV7KBtugZaU3rM+eUeqqNA1IOLhTo9WNP+SEgCADKeHTPuR16
	5soEjoVxw5N7CB9ARbgnYVP+md1s4/N6hgsNbCsVHRT32l2l5kfTCXzZGEHgxm75
	tQgg4K3mfTDS1mReIuphJvwgxKfEUKSPcwLNzBONVDEx+dboffGGBRrFnRTZq2qe
	Py9bM3Ptf6tXUgobwCmE7/kDZEgvdWca6f3nqIMMdxRubBEIqEv3jd6Y0a6SLUXB
	aPdH5A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42hbchmh24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 16:30:44 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 10C8540044;
	Tue, 29 Oct 2024 16:29:33 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2CB95263877;
	Tue, 29 Oct 2024 16:28:47 +0100 (CET)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 29 Oct
 2024 16:28:46 +0100
Message-ID: <b616628b-f9e3-42dd-b5dd-e7aa0235daae@foss.st.com>
Date: Tue, 29 Oct 2024 16:28:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ARM: dts: stm32: Describe M24256E write-lockable page
 in DH STM32MP13xx DHCOR SoM DT
To: Marek Vasut <marex@denx.de>, <linux-arm-kernel@lists.infradead.org>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>,
        <kernel@dh-electronics.com>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20241017190933.131441-1-marex@denx.de>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20241017190933.131441-1-marex@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi Marek

On 10/17/24 21:09, Marek Vasut wrote:
> The STM32MP13xx DHCOR SoM is populated with M24256E EEPROM which has
> Additional Write lockable page at separate I2C address. Describe the
> page in DT to make it available.
> 
> Note that the WLP page on this device is hardware write-protected by
> R37 which pulls the nWC signal high to VDD_3V3_1V8 power rail.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: kernel@dh-electronics.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> ---
> V2: Fix up the M25256E in Subject
> ---
> DEPENDS:
> - https://lore.kernel.org/linux-i2c/20241017184152.128395-1-marex@denx.de/
> - https://lore.kernel.org/linux-i2c/20241017184152.128395-2-marex@denx.de/
> ---
>   arch/arm/boot/dts/st/stm32mp13xx-dhcor-som.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/st/stm32mp13xx-dhcor-som.dtsi b/arch/arm/boot/dts/st/stm32mp13xx-dhcor-som.dtsi
> index 5c633ed548f37..07133bd82efa6 100644
> --- a/arch/arm/boot/dts/st/stm32mp13xx-dhcor-som.dtsi
> +++ b/arch/arm/boot/dts/st/stm32mp13xx-dhcor-som.dtsi
> @@ -202,6 +202,12 @@ eeprom0: eeprom@50 {
>   		pagesize = <64>;
>   	};
>   
> +	eeprom0wl: eeprom@58 {
> +		compatible = "st,24256e-wl";	/* ST M24256E WL page of 0x50 */
> +		pagesize = <64>;
> +		reg = <0x58>;
> +	};
> +

You could have sorted nodes by I2C addresses.
Anyway, applied on stm32-next (as dependencies have been applied by 
Bartosz).

Cheers
Alex


>   	rv3032: rtc@51 {
>   		compatible = "microcrystal,rv3032";
>   		reg = <0x51>;

