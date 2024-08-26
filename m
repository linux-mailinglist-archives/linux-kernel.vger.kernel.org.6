Return-Path: <linux-kernel+bounces-302224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DF495FB4E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 23:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435391F22C23
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFB6199238;
	Mon, 26 Aug 2024 21:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utexas.edu header.i=@utexas.edu header.b="ght4RMMq"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C15F143757
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 21:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724706742; cv=none; b=S6SqtWFF/8bySUK2ZEUB4EAPFNmIhHDZB1BWk7KKJg1M5CUpUgkTkSVI2WMR1O01r4rcP+V55RHhie669BIexSdnIfUf11CGWv3wqlhk9c01TA/kTtP5hbyPZ5ApvTQhYnrckNTmlCrOrN8nuulMKz1SlhmsAx/sIPWWjr4kU8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724706742; c=relaxed/simple;
	bh=eFo/M3JU62g2QM+7xDknS9vaGBXf1dsyv6HebcWtjWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uI2mYwQkPDICoH1gSxm5krMJniGtWiFbiSFFX6RpWZ3mOCson6GCQV9PhRme4oB80suPCoa7ZsxJoOQldxGNFM9U0/ghXhEYvCXMMFhfA5M15gbYQMYwnuImr7leee6PnZY81EHLdcUVid3HacAooBxxJ2a0KR1tm5i8r9bA3fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utexas.edu; spf=pass smtp.mailfrom=utexas.edu; dkim=pass (2048-bit key) header.d=utexas.edu header.i=@utexas.edu header.b=ght4RMMq; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utexas.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utexas.edu
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-709485aca4bso3466270a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=utexas.edu; s=google; t=1724706739; x=1725311539; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=huxWA4PjRpa889x+lqZrlufS03FFJ64qMeb6w0dqMwQ=;
        b=ght4RMMq63RFoQXlPBx35eaiedPuHw18D26Dh1zGPLeRP2RCOOmVZaGLoYoFSS9SQy
         8n53aTc3iD57u3fLW1F/pJL8RR5kZIcsZpnG4TeqfNcp4y6U/rcTGFwvKtk83vy8YV7D
         0NaVPTFFlQtUqT/pmTbG/lb2uLIqzLzUr9/t/SfDd/5FXVAAeWvt4q1pL1juq9+NPKyD
         jV7uLa9JzLDfltd4RIpaD353fWTnpPBGrSaPtInRyCWJ5e4rdPl+/LP6wTLAVVjoxJR9
         pqL9EQzKv3RL9BPOpiDXrVe8XiJcZPlWfD57+sQ/0fSR6+rY4T2ggVoA5SYsp9+//FKg
         jb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724706739; x=1725311539;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=huxWA4PjRpa889x+lqZrlufS03FFJ64qMeb6w0dqMwQ=;
        b=uvknDd6eqzNFVwFq/WQn5ExL21Jy4BrD7m+2fcRbCOXziXS0MBlFgTayclWpsUf6i6
         6iw19lAoOZq3pW5n99111AucOm4HffrPJOz2hk0bOvv7r+Mp0DRr5ElicwcP30faeyek
         v1BPcdY/VSNyCB/yDzgUtzxO1uaYEfWpenmTMzNs2IRNFOFY8Dui3qETuWZTTs0stkaD
         J4JIln9+QgBCO/R8BUe1rCxsuBMa1WrQzT23sWNY3X0CXSYQxrVOq+awQUfg4ktvvsvH
         XsiXGctR5RkJqGx+4luLFG6S68QrqCN8LJ4CBWniuOvYGTVwi9nkO3UtAVDfeyR4F9Y3
         s16Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfpf8IAgK/7BDI6JBZ1JQ6iRen9TbhQTChkJxTC9CYQjIICE0fvp3UReiqUFyRu5FZf95vFBQNSgwDgn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP2eRnNYcmKmwWK0flnS5rGrNj7Y19VkjJkGbJHDDDBEiLczSe
	Qmvqc6mg1ca7m9ou3davTS+metsLBqLLdszWmE+G6Xmhax6BG+mhZHiKlZmpX9U=
X-Google-Smtp-Source: AGHT+IHbjj1s3bOiTjaRM8dR2avr6ghTSkJJxlvBY1xI5DCgXw1DDRUAVay3i1zZE90Vl47gEBR8DA==
X-Received: by 2002:a05:6830:3104:b0:704:3fea:5354 with SMTP id 46e09a7af769-70f48307592mr691042a34.10.1724706739397;
        Mon, 26 Aug 2024 14:12:19 -0700 (PDT)
Received: from [192.168.86.42] ([136.62.208.201])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70e03acd48esm2122677a34.44.2024.08.26.14.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 14:12:19 -0700 (PDT)
Message-ID: <c6cca5d2-45f6-4a2c-86f5-cdcb0db9e936@utexas.edu>
Date: Mon, 26 Aug 2024 16:12:18 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am64* Disable ethernet by default
 at SoC level
To: Josua Mayer <josua@solid-run.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 Nishanth Menon <nm@ti.com>
Cc: Matt McKee <mmckee@phytec.com>, Wadim Egorov <w.egorov@phytec.de>,
 "linux@ew.tq-group.com" <linux@ew.tq-group.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20240809135753.1186-1-logan.bristol@utexas.edu>
 <23ac5cfb-dc5d-422b-925b-ab3f7cfae622@solid-run.com>
Content-Language: en-US
From: Logan Bristol <logan.bristol@utexas.edu>
In-Reply-To: <23ac5cfb-dc5d-422b-925b-ab3f7cfae622@solid-run.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Josua,

On 8/25/2024 6:18 AM, Josua Mayer wrote:
> Hi Logan,
> 
> Tank you for incorporating the requested changes,
> unfortunately I found another mistake ... see below.
> 
> Am 09.08.24 um 16:57 schrieb Logan Bristol:
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
>>    arch/arm64/boot/dts/ti/k3-am64-main.dtsi               | 3 +++
>>    arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi        | 6 ++----
>>    arch/arm64/boot/dts/ti/k3-am642-evm.dts                | 3 +++
>>    arch/arm64/boot/dts/ti/k3-am642-sk.dts                 | 3 +++
>>    arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi            | 6 ++----
>>    arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts | 6 ++----
>>    6 files changed, 15 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> index f8370dd03350..69c5af58b727 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> @@ -677,6 +677,7 @@ cpsw3g: ethernet@8000000 {
>>    		assigned-clock-parents = <&k3_clks 13 9>;
>>    		clock-names = "fck";
>>    		power-domains = <&k3_pds 13 TI_SCI_PD_EXCLUSIVE>;
>> +		status = "disabled";
>>    
>>    		dmas = <&main_pktdma 0xC500 15>,
>>    		       <&main_pktdma 0xC501 15>,
>> @@ -701,6 +702,7 @@ cpsw_port1: port@1 {
>>    				phys = <&phy_gmii_sel 1>;
>>    				mac-address = [00 00 00 00 00 00];
>>    				ti,syscon-efuse = <&main_conf 0x200>;
>> +				status = "disabled";
>>    			};
>>    
>>    			cpsw_port2: port@2 {
>> @@ -709,6 +711,7 @@ cpsw_port2: port@2 {
>>    				label = "port2";
>>    				phys = <&phy_gmii_sel 2>;
>>    				mac-address = [00 00 00 00 00 00];
>> +				status = "disabled";
>>    			};
>>    		};
>>    
> ...
>> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
>> index c19d0b8bbf0f..a5cec9a07510 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
>> @@ -177,6 +177,7 @@ vdd_mmc0: regulator-vdd-mmc0 {
>>    &cpsw3g {
>>    	pinctrl-names = "default";
>>    	pinctrl-0 = <&rgmii1_default_pins>;
>> +	status = "okay";
> correct
>>    };
>>    
>>    &cpsw3g_mdio {
>> @@ -210,10 +211,7 @@ ethernet_phy0: ethernet-phy@0 {
>>    &cpsw_port1 {
>>    	phy-mode = "rgmii-id";
>>    	phy-handle = <&ethernet_phy0>;
> We use this port on the SoM, please set status okay.
>> -};
>> -
>> -&cpsw_port2 {
>> -	status = "disabled";
>> +	status = "okay";
> We are not using this port on the SoM, drop node to keep status disabled.

My understanding is that the cpsw_port1 node should be enabled and the 
cpsw_port2 node should not exist in this DTSI. If my understanding is 
correct, isn't that shown in this diff?

Thank you,
Logan Bristol


