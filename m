Return-Path: <linux-kernel+bounces-180293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6B58C6C8C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604251F2179D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB5C15921D;
	Wed, 15 May 2024 19:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="G9h+Yh3V"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157463BBF6;
	Wed, 15 May 2024 19:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715799623; cv=none; b=Qs8XzCvAjFCqwjxqgpgX6MfBLbyCj4aZY1qQ3QwKXz9oq5IWJkBzvvhqreR+u0PyNWAixaOcYHZHttXIbBuQEZ+Vper3Lh03pXKzUgRK2h64qYQxdFoyfUubhz9zihC1gueK6HuBruCdVcjWyZx0QdSNqoTWL06ckDeC2/mlRf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715799623; c=relaxed/simple;
	bh=+CdgUsXw1OhIz25aaCIoQRzZkGyYOFy1X/rExwEpLhQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnqTi4KIynLhx25BQ5BFOrvwK3GPBVMyEol812qyObGJ2cWGIbz7dyD1V05gaC9C4XzY4Bza0ILhVX2bIvF2sTDTkW+nEbgaOXrd+htJ4cM2k9qyKd1d3ygChkXJnJ5hBOCi7W7nKlWWNJxlWiRFzKffdiXZl/+XGswew4in/E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=G9h+Yh3V; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 043FE120027;
	Wed, 15 May 2024 22:00:09 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 043FE120027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715799609;
	bh=ckMuf6MQpe0iaEm+Ee1bWyCe6cbGhXBFqyXa+u+DXDg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=G9h+Yh3V6+EoUpaCL8Gx2lI6b1PAKwPVu4jv+o5GSnstdVQRIsZtZTDfZIF/Gx62e
	 unpe5MWUmH102RY8ptwZ43jwEr1D6ftLkN5iDLMM768Jp8mUn1JoviQL9nLFVJptn/
	 JKIrWOT0m4j/B2Fx1XBv+hZnbKhw4oUY4Jq1PRYNzF633XkHNAFpPtANax8uvlGGT6
	 K8l18vtp0Ya6OHmu7yslcvY4nozwY908gGSpQMRV1b/8cB0ovj12RpcautQr9xFf1w
	 QKbZXNaA7Lk4W/GNaFRJhaBVV4sSEqV91qIjubBVcbQdFJ7RPj1q2DH6wPPQEbNLuG
	 l8MNx3y5IuX3g==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 15 May 2024 22:00:08 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 15 May
 2024 22:00:08 +0300
Date: Wed, 15 May 2024 22:00:08 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <conor@kernel.org>
CC: <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <jian.hu@amlogic.com>,
	<kernel@sberdevices.ru>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 4/7] dt-bindings: clock: meson: a1: peripherals:
 support sys_pll input
Message-ID: <20240515190008.cbv4kj4inkg2bm56@CAB-WSD-L081021>
References: <20240515185103.20256-1-ddrokosov@salutedevices.com>
 <20240515185103.20256-5-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240515185103.20256-5-ddrokosov@salutedevices.com>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185260 [May 15 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/15 13:12:00 #25231738
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Conor,

On Wed, May 15, 2024 at 09:47:27PM +0300, Dmitry Rokosov wrote:
> The 'sys_pll' input is an optional clock that can be used to generate
> 'sys_pll_div16', which serves as one of the sources for the GEN clock.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

I didn't tag this patch with your Acked-by because I've changed the
connection between the A1 PLL and the A1 peripherals controllers from
'sys_pll_div16' to 'sys_pll'.

Please review this patch again, if possible.

> ---
>  .../bindings/clock/amlogic,a1-peripherals-clkc.yaml      | 9 +++++++--
>  include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h  | 1 +
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc.yaml
> index 6d84cee1bd75..2568ad7dd0ac 100644
> --- a/Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc.yaml
> +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc.yaml
> @@ -30,6 +30,8 @@ properties:
>        - description: input fixed pll div7
>        - description: input hifi pll
>        - description: input oscillator (usually at 24MHz)
> +      - description: input sys pll
> +    minItems: 6 # sys_pll is optional
>  
>    clock-names:
>      items:
> @@ -39,6 +41,8 @@ properties:
>        - const: fclk_div7
>        - const: hifi_pll
>        - const: xtal
> +      - const: sys_pll
> +    minItems: 6 # sys_pll is optional
>  
>  required:
>    - compatible
> @@ -65,9 +69,10 @@ examples:
>                       <&clkc_pll CLKID_FCLK_DIV5>,
>                       <&clkc_pll CLKID_FCLK_DIV7>,
>                       <&clkc_pll CLKID_HIFI_PLL>,
> -                     <&xtal>;
> +                     <&xtal>,
> +                     <&clkc_pll CLKID_SYS_PLL>;
>              clock-names = "fclk_div2", "fclk_div3",
>                            "fclk_div5", "fclk_div7",
> -                          "hifi_pll", "xtal";
> +                          "hifi_pll", "xtal", "sys_pll";
>          };
>      };
> diff --git a/include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h b/include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
> index 06f198ee7623..2ce1a06dc735 100644
> --- a/include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
> +++ b/include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
> @@ -164,5 +164,6 @@
>  #define CLKID_DMC_SEL		151
>  #define CLKID_DMC_DIV		152
>  #define CLKID_DMC_SEL2		153
> +#define CLKID_SYS_PLL_DIV16	154
>  
>  #endif /* __A1_PERIPHERALS_CLKC_H */
> -- 
> 2.43.0
> 

-- 
Thank you,
Dmitry

