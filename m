Return-Path: <linux-kernel+bounces-302240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38B095FB81
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 23:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139FB1C21CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB1119AA58;
	Mon, 26 Aug 2024 21:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utexas.edu header.i=@utexas.edu header.b="WqLVXRNM"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2357B1991BA
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724707032; cv=none; b=O3djTK62AYKT50qSLiYc2sYFOwghVKKhfk/vJBaKutlj9utt7kuVpcBfZzawzYKzpyXqX+sve0jMg9BQx3L/HTx+yCIct9RAPIa0CvInP2LG6vHgePln5fwrM1KAjWqBJGTYRiIskBsCB2K9lSpowK4qniZRnZ8AkVl0LUtaFeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724707032; c=relaxed/simple;
	bh=FhTzidoSUYLZDObr2WcvQXGjHBAI1n6yUzxAH0d1kww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mEatezBkGF9mXOlKZDec4Axt8u/OWryOYimuby5O6xIWh0FXXJGTldR28RBevSjMXna9P7wTh12yAp16aBPh4IpZiGjV4GyUhoQpUhPy4lLZ0ykaN+p0T5R9SuSMV6MrGfQDpXk0b4HwsAw840nw4ndQLcft6JK02ncvomGYRjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utexas.edu; spf=pass smtp.mailfrom=utexas.edu; dkim=pass (2048-bit key) header.d=utexas.edu header.i=@utexas.edu header.b=WqLVXRNM; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utexas.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utexas.edu
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-27012aa4a74so3150295fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=utexas.edu; s=google; t=1724707029; x=1725311829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6wjHzAlh5dkBjrNMWPUKIDb8/9mZDWF/BmOsPcKItXk=;
        b=WqLVXRNM2L4zJZc80Zpzd7QNCr5/3T/WcBpNtTeOptbvriVoEb3qOkDPgNh1ti2swj
         VFsEUtEWs6IQ6DklLDCzAzR5p3lpko+d/Ds9veb0h2ZS9/ClXDaa7a3Tpaiet8cffDmG
         lHEPxqOD004CzbMPTYgbEmkYD/Ptw3rDH9P8H3ITfwCf6in4SJBbA/vZsh8Zhgj3fnHF
         OFJOzbVf+/OwFXhdhgfkbdca7KqVAWIbM6qTgUPwYh1uGvIpKb5mOebhr1rn7OIas+KR
         qLyD7EEVnqDVa4Wb9YCpd2jvxY5QQ2Wv6CWxgymEZkbq5tCtnTUcubuNNHw2ynEL4tfH
         nKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724707029; x=1725311829;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wjHzAlh5dkBjrNMWPUKIDb8/9mZDWF/BmOsPcKItXk=;
        b=tuaP3FhusXfP+f8helvd9qHRFugAv2OzltP0Jvryixw+3UEM7vchDqiUSABAY1CjK6
         or2oR22420khI/HM//61YsA57kPjKvnf67x+cjsEzGsbx2V5ZvPoh0JARJvqbvJWqNN5
         GmgGRlB+G3T7hzetl6hRB2/PyPeHIE1scYlZyNtwT32z5Zb6JEI2BcyYjg1Apx1aA8Hm
         Db9B1puM7um6oO3UZqvvL62Ieigy7QreT/0T9pVmrHXksso/ajraCZw+79MCBuOVMyPS
         uGdQ4EFfyLxv6lLsUhXeywW2eqZ2ctcL5wNa0a4UJmL4FxK5IEl82EBSvmaumWZg/jf+
         rDiw==
X-Forwarded-Encrypted: i=1; AJvYcCX1YYmO66lOqZnHi8mRPDqkq19fXZ125gkdGE4/D8C8idVEwdrJ4cPNjzZ4X86kBHBsvFLnPCdoD3sc42Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzuZhI7eTHX3wxkmlBtsawGt/ACSQpUSnDRyIky6EDGdvCWtBC
	6cisr2ZVc5+cjWjQjRHNw/mj4WxsAACAmH/PYQscAMyAWG8xGV5bBvh4hyowWR8=
X-Google-Smtp-Source: AGHT+IE+VqIT7vTmF8ezn+F1ZGxsArBTbxlssPG2IpR2sbFySryxvu3aXD+F6VGAslKGkRyTzyn/DA==
X-Received: by 2002:a05:6870:82a1:b0:270:735:96e with SMTP id 586e51a60fabf-273e6465ed4mr12975071fac.12.1724707029195;
        Mon, 26 Aug 2024 14:17:09 -0700 (PDT)
Received: from [192.168.86.42] ([136.62.208.201])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-273ce99851fsm2666949fac.10.2024.08.26.14.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 14:17:08 -0700 (PDT)
Message-ID: <6fa4f5e5-7f7b-495a-a95a-82d7b105d2d7@utexas.edu>
Date: Mon, 26 Aug 2024 16:17:07 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am64* Disable ethernet by default
 at SoC level
To: Daniel Schultz <d.schultz@phytec.de>
Cc: Josua Mayer <josua@solid-run.com>, Wadim Egorov <w.egorov@phytec.de>,
 linux@ew.tq-group.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 Nishanth Menon <nm@ti.com>
References: <20240809135753.1186-1-logan.bristol@utexas.edu>
 <4e884c6c-ec82-4229-a2a4-55da66cc284f@phytec.de>
Content-Language: en-US
From: Logan Bristol <logan.bristol@utexas.edu>
In-Reply-To: <4e884c6c-ec82-4229-a2a4-55da66cc284f@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Daniel,

On 8/26/2024 12:29 AM, Daniel Schultz wrote:
> Hey Logan,
> 
> my feedback is similar to Josua's.
> 
> On 09.08.24 15:57, Logan Bristol wrote:
>> External interfaces should be disabled at the SoC DTSI level, since
>> the node is incomplete. Disable Ethernet switch and ports in SoC DTSI
>> and enable them in the board DTS. If the board DTS includes a SoM DTSI
>> that completes the node description, enable the Ethernet switch and ports
>> in SoM DTSI.
>>
>> Reflect this change in SoM DTSIs by removing ethernet port disable.
>>
>> Signed-off-by: Logan Bristol <logan.bristol@utexas.edu>
>> ---
>> Changes since v1:
>> - Enabled cpsw3g and cpsw_port1 in SoM DTSI instead of board DTS
>> if board DTS included SoM DTSI
>> ---
>>   arch/arm64/boot/dts/ti/k3-am64-main.dtsi               | 3 +++
>>   arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi        | 6 ++----
>>   arch/arm64/boot/dts/ti/k3-am642-evm.dts                | 3 +++
>>   arch/arm64/boot/dts/ti/k3-am642-sk.dts                 | 3 +++
>>   arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi            | 6 ++----
>>   arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts | 6 ++----
>>   6 files changed, 15 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/ 
>> boot/dts/ti/k3-am64-main.dtsi
>> index f8370dd03350..69c5af58b727 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> @@ -677,6 +677,7 @@ cpsw3g: ethernet@8000000 {
>>           assigned-clock-parents = <&k3_clks 13 9>;
>>           clock-names = "fck";
>>           power-domains = <&k3_pds 13 TI_SCI_PD_EXCLUSIVE>;
>> +        status = "disabled";
>>           dmas = <&main_pktdma 0xC500 15>,
>>                  <&main_pktdma 0xC501 15>,
>> @@ -701,6 +702,7 @@ cpsw_port1: port@1 {
>>                   phys = <&phy_gmii_sel 1>;
>>                   mac-address = [00 00 00 00 00 00];
>>                   ti,syscon-efuse = <&main_conf 0x200>;
>> +                status = "disabled";
>>               };
>>               cpsw_port2: port@2 {
>> @@ -709,6 +711,7 @@ cpsw_port2: port@2 {
>>                   label = "port2";
>>                   phys = <&phy_gmii_sel 2>;
>>                   mac-address = [00 00 00 00 00 00];
>> +                status = "disabled";
>>               };
>>           };
>> diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/ 
>> arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
>> index ea7c58fb67e2..6bece2fb4e95 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
>> @@ -185,6 +185,7 @@ AM64X_IOPAD(0x0278, PIN_INPUT, 7)    /* (C19) 
>> EXTINTn.GPIO1_70 */
>>   &cpsw3g {
>>       pinctrl-names = "default";
>>       pinctrl-0 = <&cpsw_rgmii1_pins_default>;
>> +    status = "okay";
>>   };
>>   &cpsw3g_mdio {
>> @@ -208,10 +209,7 @@ cpsw3g_phy1: ethernet-phy@1 {
>>   &cpsw_port1 {
>>       phy-mode = "rgmii-rxid";
>>       phy-handle = <&cpsw3g_phy1>;
> The connected phy is located on the SOM and should be enabled by default.
>> -};
>> -
>> -&cpsw_port2 {
>> -    status = "disabled";
>> +    status = "okay";
>>   };
> 
> This port is routed to the carrier-board. Please drop this node.

I replied similarly to Josua's comments, but if cpsw_port1 is to be 
enabled and cpsw_port2 should be dropped from this DTSI, isn't that 
shown in this diff?

Thank you,
Logan Bristol


