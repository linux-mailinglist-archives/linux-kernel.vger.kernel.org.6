Return-Path: <linux-kernel+bounces-572055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A5EA6C5F1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7835189FEE0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6360D231A30;
	Fri, 21 Mar 2025 22:26:00 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293821519BE;
	Fri, 21 Mar 2025 22:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742595960; cv=none; b=j06vw86zC/fQ6UtjmxuTT0fw5ctGgW+GRf+kI5j49xRXp4Cx4rcSZs6tKyc2XV12+4mHGYFQjFHwksKlHuSP4a7S1cxP7FXCELAxAek6OCjQbuwlFsGetXRJnORm1kD6KEWbv5ZLyX/4ar9w1/GdlpqRVzDvjHF1c4PUEh8mIJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742595960; c=relaxed/simple;
	bh=vYmiiL+JAp1wGAkVFDCwFvS+vkrR9HpnBuY5stT1Bsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGUwkudF2a1IGQfJm7uudH6DHtmY1m1YmmSR61ZlLMkOcYj2tAhlY+mwGFsVuDI1QloD3/NwjEPkelVkwbcPYUJ/hruRMT+tFQMNsis3VonXkB8ctcv40paHQC8DVOuZO3uI83Agkq+xLB3niJZ0J48XMJcJA1ZPJ50ht0dX7oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 17D023430C5;
	Fri, 21 Mar 2025 22:25:56 +0000 (UTC)
Date: Fri, 21 Mar 2025 22:25:46 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Alex Elder <elder@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
	heylenay@4d2.org, guodong@riscstar.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, spacemit@lists.linux.dev,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 1/7] dt-bindings: soc: spacemit: define
 spacemit,k1-ccu resets
Message-ID: <20250321222546-GYA11633@gentoo>
References: <20250321151831.623575-1-elder@riscstar.com>
 <20250321151831.623575-2-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321151831.623575-2-elder@riscstar.com>

hi Alex:

On 10:18 Fri 21 Mar     , Alex Elder wrote:
> There are additional SpacemiT syscon CCUs whose registers control both
> clocks and resets:  RCPU, RCPU2, and APBC2. Unlike those defined
> previously, these will initially support only resets.  They do not
> incorporate power domain functionality.
> 
> Define the index values for resets associated with all SpacemiT K1
> syscon nodes, including those with clocks already defined, as well as
> the new ones (without clocks).
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  .../soc/spacemit/spacemit,k1-syscon.yaml      |  13 +-
>  include/dt-bindings/clock/spacemit,k1-ccu.h   | 134 ++++++++++++++++++
>  2 files changed, 143 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
> index 07a6728e6f864..333c28e075b6c 100644
> --- a/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
> +++ b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
> @@ -19,6 +19,9 @@ properties:
>        - spacemit,k1-syscon-apbc
>        - spacemit,k1-syscon-apmu
>        - spacemit,k1-syscon-mpmu
> +      - spacemit,k1-syscon-rcpu
> +      - spacemit,k1-syscon-rcpu2
> +      - spacemit,k1-syscon-apbc2
>  
>    reg:
>      maxItems: 1
> @@ -57,13 +60,15 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: spacemit,k1-syscon-apbc
> +            enum:
> +              - spacemit,k1-syscon-apmu
> +              - spacemit,k1-syscon-mpmu
>      then:
> -      properties:
> -        "#power-domain-cells": false
> -    else:
>        required:
>          - "#power-domain-cells"
> +    else:
> +      properties:
> +        "#power-domain-cells": false
>  
>  additionalProperties: false
>  
> diff --git a/include/dt-bindings/clock/spacemit,k1-ccu.h b/include/dt-bindings/clock/spacemit,k1-ccu.h
> index 4a0c7163257e3..a1e1b1fe714ce 100644
> --- a/include/dt-bindings/clock/spacemit,k1-ccu.h
> +++ b/include/dt-bindings/clock/spacemit,k1-ccu.h
> @@ -78,6 +78,9 @@
>  #define CLK_APB			31
>  #define CLK_WDT_BUS		32
>  
> +/*	MPMU resets	*/
> +#define RST_WDT			0
> +
>  /*	APBC clocks	*/
>  #define CLK_UART0		0
>  #define CLK_UART2		1
> @@ -109,6 +112,7 @@
>  #define CLK_PWM17		27
>  #define CLK_PWM18		28
>  #define CLK_PWM19		29
> +
as Rob point out, this isn't necessary, not related to reset

>  #define CLK_SSP3		30
>  #define CLK_RTC			31
>  #define CLK_TWSI0		32
> @@ -180,6 +184,60 @@
>  #define CLK_TSEN_BUS		98
>  #define CLK_IPC_AP2AUD_BUS	99
>  
> +/*	APBC resets	*/
> +
I'd also suggest to drop above blank line, keep style consistent
with others in this file, some same below that I won't comment
> +#define RST_UART0		0
> +#define RST_UART2		1
> +#define RST_UART3		2
> +#define RST_UART4		3
> +#define RST_UART5		4
> +#define RST_UART6		5
> +#define RST_UART7		6
> +#define RST_UART8		7
> +#define RST_UART9		8
> +#define RST_GPIO		9
> +#define RST_PWM0		10
> +#define RST_PWM1		11
> +#define RST_PWM2		12
> +#define RST_PWM3		13
> +#define RST_PWM4		14
> +#define RST_PWM5		15
> +#define RST_PWM6		16
> +#define RST_PWM7		17
> +#define RST_PWM8		18
> +#define RST_PWM9		19
> +#define RST_PWM10		20
> +#define RST_PWM11		21
> +#define RST_PWM12		22
> +#define RST_PWM13		23
> +#define RST_PWM14		24
> +#define RST_PWM15		25
> +#define RST_PWM16		26
> +#define RST_PWM17		27
> +#define RST_PWM18		28
> +#define RST_PWM19		29
> +#define RST_SSP3		30
> +#define RST_RTC			31
> +#define RST_TWSI0		32
> +#define RST_TWSI1		33
> +#define RST_TWSI2		34
> +#define RST_TWSI4		35
> +#define RST_TWSI5		36
> +#define RST_TWSI6		37
> +#define RST_TWSI7		38
> +#define RST_TWSI8		39
> +#define RST_TIMERS1		40
> +#define RST_TIMERS2		41
> +#define RST_AIB			42
> +#define RST_ONEWIRE		43
> +#define RST_SSPA0		44
> +#define RST_SSPA1		45
> +#define RST_DRO			46
> +#define RST_IR			47
> +#define RST_TSEN		48
> +#define RST_IPC_AP2AUD		49
> +#define RST_CAN0		50
> +
>  /*	APMU clocks	*/
>  #define CLK_CCI550		0
>  #define CLK_CPU_C0_HI		1
> @@ -244,4 +302,80 @@
>  #define CLK_V2D			60
>  #define CLK_EMMC_BUS		61
>  
> +/*	APMU resets	*/
> +
> +#define RST_CCIC_4X		0
> +#define RST_CCIC1_PHY		1
> +#define RST_SDH_AXI		2
> +#define RST_SDH0		3
> +#define RST_SDH1		4
> +#define RST_SDH2		5
> +#define RST_USBP1_AXI		6
> +#define RST_USB_AXI		7
> +#define RST_USB3_0		8
> +#define RST_QSPI		9
> +#define RST_QSPI_BUS		10
> +#define RST_DMA			11
> +#define RST_AES			12
> +#define RST_VPU			13
> +#define RST_GPU			14
> +#define RST_EMMC		15
> +#define RST_EMMC_X		16
> +#define RST_AUDIO		17
> +#define RST_HDMI		18
> +#define RST_PCIE0		19
> +#define RST_PCIE1		20
> +#define RST_PCIE2		21
> +#define RST_EMAC0		22
> +#define RST_EMAC1		23
> +#define RST_JPG			24
> +#define RST_CCIC2PHY		25
> +#define RST_CCIC3PHY		26
> +#define RST_CSI			27
> +#define RST_ISP_CPP		28
> +#define RST_ISP_BUS		29
> +#define RST_ISP			30
> +#define RST_ISP_CI		31
> +#define RST_DPU_MCLK		32
> +#define RST_DPU_ESC		33
> +#define RST_DPU_HCLK		34
> +#define RST_DPU_SPIBUS		35
> +#define RST_DPU_SPI_HBUS	36
> +#define RST_V2D			37
> +#define RST_MIPI		38
> +#define RST_MC			39
> +
> +/*	RCPU resets	*/
> +
> +#define RST_RCPU_SSP0		0
> +#define RST_RCPU_I2C0		1
> +#define RST_RCPU_UART1		2
> +#define RST_RCPU_IR		3
> +#define RST_RCPU_CAN		4
> +#define RST_RCPU_UART0		5
> +#define RST_RCPU_HDMI_AUDIO	6
> +
> +/*	RCPU2 resets	*/
> +
> +#define RST_RCPU2_PWM0		0
> +#define RST_RCPU2_PWM1		1
> +#define RST_RCPU2_PWM2		2
> +#define RST_RCPU2_PWM3		3
> +#define RST_RCPU2_PWM4		4
> +#define RST_RCPU2_PWM5		5
> +#define RST_RCPU2_PWM6		6
> +#define RST_RCPU2_PWM7		7
> +#define RST_RCPU2_PWM8		8
> +#define RST_RCPU2_PWM9		9
> +
> +/*	APBC2 resets	*/
> +
> +#define RST_APBC2_UART1		0
> +#define RST_APBC2_SSP2		1
> +#define RST_APBC2_TWSI3		2
> +#define RST_APBC2_RTC		3
> +#define RST_APBC2_TIMERS0	4
> +#define RST_APBC2_KPC		5
> +#define RST_APBC2_GPIO		6
> +
>  #endif /* _DT_BINDINGS_SPACEMIT_CCU_H_ */
> -- 
> 2.43.0
> 
> 

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

