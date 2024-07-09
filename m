Return-Path: <linux-kernel+bounces-246271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308A992BFC5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540941C22B51
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE3719D8A3;
	Tue,  9 Jul 2024 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tlt2rn8H"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19F21A2C35;
	Tue,  9 Jul 2024 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542047; cv=none; b=melBpF0An53hd3AFK1pR6RewBmBDbo/p4/WQXZKTNK0i3vuHy3FckZjxm6/MCiZW72qikRCKQ7pgiU3WL5DA4mG66gWqVOiutA2205Hzqvenx9hsonqbGD3Prw1AjvMFPHJqjBNypQXaZ9enwkUpoIJdETXvWPycL1murp8ARr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542047; c=relaxed/simple;
	bh=7JggO4BRzdi2AqeYicUOcBvjZlLMdDTqsf0iTuXRHl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cb3T9fgwru6iwh4RLaCLoUlbHbmKnsHrs+rxCPOgR+GYIOts6sR70v8wLb0GSX+lN1e/MkGqcbQ4RSBl6sdVX+owAa6s2KjxiLTrW4W1Tif451+ZH9tW5+qpFajut1ss07b3TSuMKA67vKizsj5oGaRNmF0lMXv8vQMz24pxaMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tlt2rn8H; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 469GKPTj064227;
	Tue, 9 Jul 2024 11:20:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720542025;
	bh=AS0GpqVE9o6QlvaDW+hyAp+TrL2xhDX4xXkz0PMUlfI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=tlt2rn8HujVw83Z12NCYe7Hx7UmyUfp+n62hF1uHxwb2vlYDAgu9HW02+bJL3PO1E
	 E6FbQjA2siru+0zuI369xqNN9Ju6XCZZfIKuj/C7hgGf419OTNj/eJRcxWwpQcaia+
	 qZ+FuJRrh/GqTSqG9wVtP5QjM60zLmSmJYXza8Dk=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 469GKPQd090622
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jul 2024 11:20:25 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jul 2024 11:20:25 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jul 2024 11:20:25 -0500
Received: from [128.247.75.151] (ula0511493.dhcp.ti.com [128.247.75.151])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 469GKP26011586;
	Tue, 9 Jul 2024 11:20:25 -0500
Message-ID: <766dceb1-222a-401b-95e3-69b7fb331411@ti.com>
Date: Tue, 9 Jul 2024 11:20:24 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] arm64: dts: ti: introduce a minimal am642 device tree
To: Krzysztof Kozlowski <krzk@kernel.org>, Bryan Brattlof <bb@ti.com>,
        Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220321155417.13267-1-bb@ti.com>
 <55e161d1-face-6958-1d86-8a85b82e8485@kernel.org>
Content-Language: en-US
From: Logan Bristol <l-bristol@ti.com>
In-Reply-To: <55e161d1-face-6958-1d86-8a85b82e8485@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


Hi all,

On 3/22/22 13:14, Krzysztof Kozlowski wrote:
> On 21/03/2022 16:54, Bryan Brattlof wrote:
>> Texas Instrument's am642 is one of many k3 based, low cost, low power,
>> chips designed to work in a wide range of applications spanning an even
>> wider range of industries that TI is actively developing
>>
>> With its pin-mux and peripheral rich designs, these chips will likely
>> have a multitude of custom device trees that range wildly from one
>> another and (hopefully) guarantee an influx of variants into the kernel
>> in the coming years
>>
>> With overlays no longer a thing, I wanted to ask for opinions on how
>> we can best help integrate these dt files as they begin to be developed
>>
>> I also wanted to introduce a skeletonized (nothing but uart) device tree
>> to give others a good starting point while developing their projects.
> 
> Real hardware as DTS please. There is no need to add some skeleton for
> specific SoC. What if every SoC goes that way?
> 
> Feel free to create re-usable components in DTSI ways, still reflecting
> some hardware parts.
> 

I am working on a project for the AM62 and came across this email thread.

Following Krzysztof's direction, I am wanting to submit a DTSI to serve
as a minimal configuration for the existing boards based on the AM62
SoC, which are currently defined by bloated DTS files.

This DTSI file can be consumed by other board DTS files to reduce the
configuration. Krzysztof, could this be merged upstream?

Thanks,
Logan Bristol

>>
>> Let me know what you think :)
>>
>> Signed-off-by: Bryan Brattlof <bb@ti.com>
>> ---
>>  .../devicetree/bindings/arm/ti/k3.yaml        |   1 +
>>  arch/arm64/boot/dts/ti/Makefile               |   1 +
>>  arch/arm64/boot/dts/ti/k3-am642-skeleton.dts  | 335 ++++++++++++++++++
>>  3 files changed, 337 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/ti/k3-am642-skeleton.dts
>>
>> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
>> index 61c6ab4f52e26..e65053d6465bd 100644
>> --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
>> +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
>> @@ -55,6 +55,7 @@ properties:
>>        - description: K3 AM642 SoC
>>          items:
>>            - enum:
>> +              - ti,am642-generic
> 
> Real hardware is needed.
> 
>>                - ti,am642-evm
>>                - ti,am642-sk
>>            - const: ti,am642
>> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
>> index 02e5d80344d00..df7bdf087558c 100644
>> --- a/arch/arm64/boot/dts/ti/Makefile
>> +++ b/arch/arm64/boot/dts/ti/Makefile
>> @@ -19,6 +19,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
>>  
>>  dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb
>>  
>> +dtb-$(CONFIG_ARCH_K3) += k3-am642-skeleton.dtb
>>  dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
>>  dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
>>  
>> diff --git a/arch/arm64/boot/dts/ti/k3-am642-skeleton.dts b/arch/arm64/boot/dts/ti/k3-am642-skeleton.dts
>> new file mode 100644
>> index 0000000000000..2b789c9c25ced
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-am642-skeleton.dts
>> @@ -0,0 +1,335 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * The absolute minimum DTS file needed for an AM642
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/pinctrl/k3.h>
>> +#include "k3-am642.dtsi"
>> +
>> +/ {
>> +	compatible = "ti,am642-generic", "ti,am642";
>> +	model = "Texas Instruments AM642 Generic";
>> +
>> +	chosen {
>> +		stdout-path = "serial2:115200n8";
>> +		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
> 
> 
> No development bootargs.
> 
>> +	};
>> +
>> +	cpus {
>> +		/delete-node/ cpu@1;
> 
> A bit weird... especially without any comment.
> 
>> +	};
>> +
>> +	memory@80000000 {
>> +		device_type = "memory";
>> +		reg = <0x00000000 0x20000000 0x00000000 0x20000000>;
>> +	};
>> +
>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		secure_ddr: optee@9e800000 {
>> +			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
>> +			alignment = <0x1000>;
>> +			no-map;
>> +		};
>> +	};
>> +};
>> +
>> +/* reserved for mcu firmware */
>> +&mcu_gpio0 {
>> +	status = "reserved";
>> +};
>> +
>> +&mcu_i2c0 {
>> +	status = "disabled";
>> +};
>> +
> 
> Judging by this file - several disabled or reserved blocks - this does
> not look at all usable. What's the point? How does it even help anyone?
> 
> 
> Best regards,
> Krzysztof
> 
> From mboxrd@z Thu Jan  1 00:00:00 1970
> Return-Path: <linux-arm-kernel-bounces+linux-arm-kernel=archiver.kernel.org@lists.infradead.org>
> X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
> 	aws-us-west-2-korg-lkml-1.web.codeaurora.org
> Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
> 	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
> 	(No client certificate requested)
> 	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5064FC433EF
> 	for <linux-arm-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 18:15:38 +0000 (UTC)
> DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
> 	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
> 	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
> 	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
> 	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
> 	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
> 	List-Owner; bh=b11MEVmqRLF+jj9/rtqsBkiDpamrd5oQVRiYmZE68eM=; b=kz+0d/sZgV7fS+
> 	hqxQmmiX+UhdZGQhPjCB0vDywhWUFM5N9LXvCjVmAPIiW73+5d20vKI35Pqzq7FhUvt0abI212Omq
> 	xA70WW5t27CGolgST7/t763EBk3qS5HrPcHbh3cF6I5IBGSC1COOoieUaMOKGT3eOPd77BRYpUZX5
> 	ZOFBtgYAkU+AACb1SfxOjpFwxJAXgRNYJMdKeaTiDzEwUAGKWvnR34WkUj9y3vMXaxxxQ3GOC+25r
> 	iEk4YUSWRTYNHFiRi0VumbUM7KW5EMAZHD1WK3qoGybpEF+jMYaIrM6/F3/7vSkAcZ3FXphIMeUmx
> 	K2G+NXzpQXNDdh6eRAgw==;
> Received: from localhost ([::1] helo=bombadil.infradead.org)
> 	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
> 	id 1nWj1Q-00BqZe-Th; Tue, 22 Mar 2022 18:14:21 +0000
> Received: from mail-ed1-f42.google.com ([209.85.208.42])
>  by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
>  id 1nWj1M-00BqYR-K6
>  for linux-arm-kernel@lists.infradead.org; Tue, 22 Mar 2022 18:14:18 +0000
> Received: by mail-ed1-f42.google.com with SMTP id a17so21661927edm.9
>  for <linux-arm-kernel@lists.infradead.org>;
>  Tue, 22 Mar 2022 11:14:11 -0700 (PDT)
> X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
>  d=1e100.net; s=20210112;
>  h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
>  :content-language:to:cc:references:from:in-reply-to
>  :content-transfer-encoding;
>  bh=YSNtfm2I+E7ZPtbQKZG0Nrw6hi+P+RYiX3Pd+JP3Ab4=;
>  b=b5L7SUGqENepcUJ0I+stC8g2ipIMnL1DYhzdPZ6mlga1Cr13e9v83P4vidTkvI3NiK
>  8RZ8kgLc7rPTD5QTkequIpqKxok3PJQe+BKY5m/AVFwiXGrODsf1cs6CUp4G0kyFZ51v
>  S2ugShWorsaWP/gkaHrt/FqIPCZiCJd8WM+eyL/VV0V5NqzdLMeGpNvDa3VX9G8t3kAk
>  J9KuLqVsjQNerDbjLoW+jAheXgPfrjQZsKLCX1xmxL/83wYrw3JSr/ee0TZAGmM74px4
>  /QrmDYnv4nR5k7tS8ziD5OByuFsm1BVEkA4lDrl/Y4G0N5IflRPp483Ld7GiQsqubjOV
>  3jzA==
> X-Gm-Message-State: AOAM530bVfXqqu36LMJh9oigYabIp8MnyKdNFRYuxTvWlvdXcgcF5FEd
>  AnclY4HUCVnXYTMijnwCBk8=
> X-Google-Smtp-Source: ABdhPJwdUri/i8z1B7zh8yu0O1Iy/wywZGubvdSv0lI+ID/JVL2IS4yIxLLkfnX8yWWh3ln4JtofCQ==
> X-Received: by 2002:a50:c00a:0:b0:418:f10f:b27c with SMTP id
>  r10-20020a50c00a000000b00418f10fb27cmr29450490edb.204.1647972850517; 
>  Tue, 22 Mar 2022 11:14:10 -0700 (PDT)
> Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl.
>  [78.11.189.27]) by smtp.googlemail.com with ESMTPSA id
>  n24-20020a17090673d800b006df8ec24712sm7481201ejl.215.2022.03.22.11.14.09
>  (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
>  Tue, 22 Mar 2022 11:14:09 -0700 (PDT)
> Message-ID: <55e161d1-face-6958-1d86-8a85b82e8485@kernel.org>
> Date: Tue, 22 Mar 2022 19:14:08 +0100
> MIME-Version: 1.0
> User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
>  Thunderbird/91.5.0
> Subject: Re: [RFC] arm64: dts: ti: introduce a minimal am642 device tree
> Content-Language: en-US
> To: Bryan Brattlof <bb@ti.com>, Nishanth Menon <nm@ti.com>,
>  Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
>  <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
>  devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
> References: <20220321155417.13267-1-bb@ti.com>
> From: Krzysztof Kozlowski <krzk@kernel.org>
> In-Reply-To: <20220321155417.13267-1-bb@ti.com>
> X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
> X-CRM114-CacheID: sfid-20220322_111416_699438_4DF67032 
> X-CRM114-Status: GOOD (  27.85  )
> X-BeenThere: linux-arm-kernel@lists.infradead.org
> X-Mailman-Version: 2.1.34
> Precedence: list
> List-Id: <linux-arm-kernel.lists.infradead.org>
> List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
>  <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
> List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
> List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
> List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
> List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
>  <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
> Content-Type: text/plain; charset="us-ascii"
> Content-Transfer-Encoding: 7bit
> Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
> Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=archiver.kernel.org@lists.infradead.org
> 
> On 21/03/2022 16:54, Bryan Brattlof wrote:
>> Texas Instrument's am642 is one of many k3 based, low cost, low power,
>> chips designed to work in a wide range of applications spanning an even
>> wider range of industries that TI is actively developing
>>
>> With its pin-mux and peripheral rich designs, these chips will likely
>> have a multitude of custom device trees that range wildly from one
>> another and (hopefully) guarantee an influx of variants into the kernel
>> in the coming years
>>
>> With overlays no longer a thing, I wanted to ask for opinions on how
>> we can best help integrate these dt files as they begin to be developed
>>
>> I also wanted to introduce a skeletonized (nothing but uart) device tree
>> to give others a good starting point while developing their projects.
> 
> Real hardware as DTS please. There is no need to add some skeleton for
> specific SoC. What if every SoC goes that way?
> 
> Feel free to create re-usable components in DTSI ways, still reflecting
> some hardware parts.
> 
>>
>> Let me know what you think :)
>>
>> Signed-off-by: Bryan Brattlof <bb@ti.com>
>> ---
>>  .../devicetree/bindings/arm/ti/k3.yaml        |   1 +
>>  arch/arm64/boot/dts/ti/Makefile               |   1 +
>>  arch/arm64/boot/dts/ti/k3-am642-skeleton.dts  | 335 ++++++++++++++++++
>>  3 files changed, 337 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/ti/k3-am642-skeleton.dts
>>
>> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
>> index 61c6ab4f52e26..e65053d6465bd 100644
>> --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
>> +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
>> @@ -55,6 +55,7 @@ properties:
>>        - description: K3 AM642 SoC
>>          items:
>>            - enum:
>> +              - ti,am642-generic
> 
> Real hardware is needed.
> 
>>                - ti,am642-evm
>>                - ti,am642-sk
>>            - const: ti,am642
>> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
>> index 02e5d80344d00..df7bdf087558c 100644
>> --- a/arch/arm64/boot/dts/ti/Makefile
>> +++ b/arch/arm64/boot/dts/ti/Makefile
>> @@ -19,6 +19,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
>>  
>>  dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb
>>  
>> +dtb-$(CONFIG_ARCH_K3) += k3-am642-skeleton.dtb
>>  dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
>>  dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
>>  
>> diff --git a/arch/arm64/boot/dts/ti/k3-am642-skeleton.dts b/arch/arm64/boot/dts/ti/k3-am642-skeleton.dts
>> new file mode 100644
>> index 0000000000000..2b789c9c25ced
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-am642-skeleton.dts
>> @@ -0,0 +1,335 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * The absolute minimum DTS file needed for an AM642
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/pinctrl/k3.h>
>> +#include "k3-am642.dtsi"
>> +
>> +/ {
>> +	compatible = "ti,am642-generic", "ti,am642";
>> +	model = "Texas Instruments AM642 Generic";
>> +
>> +	chosen {
>> +		stdout-path = "serial2:115200n8";
>> +		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
> 
> 
> No development bootargs.
> 
>> +	};
>> +
>> +	cpus {
>> +		/delete-node/ cpu@1;
> 
> A bit weird... especially without any comment.
> 
>> +	};
>> +
>> +	memory@80000000 {
>> +		device_type = "memory";
>> +		reg = <0x00000000 0x20000000 0x00000000 0x20000000>;
>> +	};
>> +
>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		secure_ddr: optee@9e800000 {
>> +			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
>> +			alignment = <0x1000>;
>> +			no-map;
>> +		};
>> +	};
>> +};
>> +
>> +/* reserved for mcu firmware */
>> +&mcu_gpio0 {
>> +	status = "reserved";
>> +};
>> +
>> +&mcu_i2c0 {
>> +	status = "disabled";
>> +};
>> +
> 
> Judging by this file - several disabled or reserved blocks - this does
> not look at all usable. What's the point? How does it even help anyone?
> 
> 
> Best regards,
> Krzysztof
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


