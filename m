Return-Path: <linux-kernel+bounces-317290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D0696DBF4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDFF9B25653
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB55175A1;
	Thu,  5 Sep 2024 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Q4vyRurz"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CB317548;
	Thu,  5 Sep 2024 14:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725547017; cv=none; b=Pii/kFk8IPuqZr0jv5MksZ69X1c0cu5kLxnjRmVpbDMzrVQjz4XD2RxenTyrJlQHHdyV7rgezJo3wQFxt72xLRQNWFVViH0grSv5q8UQvzOc12m8rhR7/QC/FEZqmdU3kOVr/9XZSykvnJHg+nb4JX3tjJIurHaSSQqim/CfboM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725547017; c=relaxed/simple;
	bh=ioOxBTL+YcNfqfyxlm1LH+AxreuQgTq5diXJPly0R9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TbX2brEELHcE5v7oqV3HEmgJSdMHuYzQ2MUR16+kAc9m5fqyJxQGdmF847Koy8friFQGQbtdSuPP5dUbre8rC74fYfnS0iYVxM6SnXf/EpbSwC+jUA9WflZ1loecTY72xRB55LGbw5V5ruapwCaC1ItXs+I7pPLCeknW+/+pA6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Q4vyRurz; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725547015; x=1757083015;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ioOxBTL+YcNfqfyxlm1LH+AxreuQgTq5diXJPly0R9M=;
  b=Q4vyRurzI69r0085c/Lj7p65qevqMGslOIc4ef710eccPSBCad5ks8my
   9KaJW8/bVzKi94L3WSE/QZef6L4TyUMhOKSYPTCK5EXnXyqDRktEjeBYS
   3z8X2CcNNdJdbhCC8wzL6C/uf1D5NFZpkUtMoQrS5wiiqkQoQuK2Hz3um
   fMEpPwBbyjYRLmEAMyZ9HXFNr9WV2u+w1wg7T+CNgMfUXsE213ToCAyQt
   n28Z4SG8Fiupf/GFWJ1UlPSHy0xb1OQrj08xxhX8i053Nc1Yf5E9v12K8
   TpGVBqPA/rHP2IFeLemWVQgicqT873bmn0QkIxdFz5VIWUDIlbuwyejYo
   Q==;
X-CSE-ConnectionGUID: iZMzHRBARyy75LFHdHopJA==
X-CSE-MsgGUID: pYc4MCd7RVaRERYpNZN8uA==
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="34471301"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2024 07:36:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 5 Sep 2024 07:36:44 -0700
Received: from [10.180.116.241] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 5 Sep 2024 07:36:41 -0700
Message-ID: <e477ba59-36e8-4021-b32c-4db10fccea6e@microchip.com>
Date: Thu, 5 Sep 2024 16:37:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: microchip: sam9x60: Add missing property
 atmel,usart-mode
Content-Language: en-US, fr-FR
To: Andrei Simion <andrei.simion@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<alexandre.belloni@bootlin.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
References: <20240905093046.23428-1-andrei.simion@microchip.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20240905093046.23428-1-andrei.simion@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 05/09/2024 at 11:30, Andrei Simion wrote:
> ~: make dtbs_check DT_SCHEMA_FILES=atmel,at91-usart.ymal
> -> for all boards which inherit sam9x60.dtsi: serial@200: $nodename:0:
> 'serial@200' does not match '^spi(@.*|-([0-9]|[1-9][0-9]+))?$
> serial@200: atmel,use-dma-rx: False schema does not allow True
> serial@200: atmel,use-dma-tx: False schema does not allow True
> serial@200: atmel,fifo-size: False schema does not allow [[16]]
> -> Means : atmel,usart-mode = <AT91_USART_MODE_SERIAL> misses for uart:
> 0,1,2,3,4,6,7,8,9,10,11,12
> 
> Add to uart nodes the property atmel,usart-mode to specify the driver to be
> used in serial mode to be compliant to atmel,at91-usart.yaml.
> 
> Fixes: 99c808335877 ("ARM: dts: at91: sam9x60: Add missing flexcom definitions")
> Signed-off-by: Andrei Simion <andrei.simion@microchip.com>

Thanks Andrei:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Best regards,
   Nicolas

> ---
>   arch/arm/boot/dts/microchip/sam9x60.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> index 04a6d716ecaf..0ba424bba7cc 100644
> --- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
> +++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> @@ -174,6 +174,7 @@ flx4: flexcom@f0000000 {
>   				uart4: serial@200 {
>   					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
>   					reg = <0x200 0x200>;
> +					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
>   					interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
>   					dmas = <&dma0
>   						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -376,6 +377,7 @@ flx11: flexcom@f0020000 {
>   				uart11: serial@200 {
>   					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
>   					reg = <0x200 0x200>;
> +					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
>   					interrupts = <32 IRQ_TYPE_LEVEL_HIGH 7>;
>   					dmas = <&dma0
>   						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -427,6 +429,7 @@ flx12: flexcom@f0024000 {
>   				uart12: serial@200 {
>   					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
>   					reg = <0x200 0x200>;
> +					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
>   					interrupts = <33 IRQ_TYPE_LEVEL_HIGH 7>;
>   					dmas = <&dma0
>   						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -586,6 +589,7 @@ flx6: flexcom@f8010000 {
>   				uart6: serial@200 {
>   					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
>   					reg = <0x200 0x200>;
> +					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
>   					interrupts = <9 IRQ_TYPE_LEVEL_HIGH 7>;
>   					dmas = <&dma0
>   						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -637,6 +641,7 @@ flx7: flexcom@f8014000 {
>   				uart7: serial@200 {
>   					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
>   					reg = <0x200 0x200>;
> +					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
>   					interrupts = <10 IRQ_TYPE_LEVEL_HIGH 7>;
>   					dmas = <&dma0
>   						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -688,6 +693,7 @@ flx8: flexcom@f8018000 {
>   				uart8: serial@200 {
>   					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
>   					reg = <0x200 0x200>;
> +					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
>   					interrupts = <11 IRQ_TYPE_LEVEL_HIGH 7>;
>   					dmas = <&dma0
>   						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -739,6 +745,7 @@ flx0: flexcom@f801c000 {
>   				uart0: serial@200 {
>   					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
>   					reg = <0x200 0x200>;
> +					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
>   					interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
>   					dmas = <&dma0
>   						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -809,6 +816,7 @@ flx1: flexcom@f8020000 {
>   				uart1: serial@200 {
>   					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
>   					reg = <0x200 0x200>;
> +					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
>   					interrupts = <6 IRQ_TYPE_LEVEL_HIGH 7>;
>   					dmas = <&dma0
>   						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -879,6 +887,7 @@ flx2: flexcom@f8024000 {
>   				uart2: serial@200 {
>   					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
>   					reg = <0x200 0x200>;
> +					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
>   					interrupts = <7 IRQ_TYPE_LEVEL_HIGH 7>;
>   					dmas = <&dma0
>   						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -949,6 +958,7 @@ flx3: flexcom@f8028000 {
>   				uart3: serial@200 {
>   					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
>   					reg = <0x200 0x200>;
> +					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
>   					interrupts = <8 IRQ_TYPE_LEVEL_HIGH 7>;
>   					dmas = <&dma0
>   						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -1074,6 +1084,7 @@ flx9: flexcom@f8040000 {
>   				uart9: serial@200 {
>   					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
>   					reg = <0x200 0x200>;
> +					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
>   					interrupts = <15 IRQ_TYPE_LEVEL_HIGH 7>;
>   					dmas = <&dma0
>   						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -1125,6 +1136,7 @@ flx10: flexcom@f8044000 {
>   				uart10: serial@200 {
>   					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
>   					reg = <0x200 0x200>;
> +					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
>   					interrupts = <16 IRQ_TYPE_LEVEL_HIGH 7>;
>   					dmas = <&dma0
>   						(AT91_XDMAC_DT_MEM_IF(0) |
> 
> base-commit: fdadd93817f124fd0ea6ef251d4a1068b7feceba


