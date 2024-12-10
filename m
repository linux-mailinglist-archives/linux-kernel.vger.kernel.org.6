Return-Path: <linux-kernel+bounces-439168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6B79EABD5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C291635BC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598D2232795;
	Tue, 10 Dec 2024 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="qkooYq8W"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA196232783
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822554; cv=none; b=uJGu3FZ9q1RLeX4V0XYOX1RcljKOB7afrSeAlY1+v59sh0JpOwdB38GHv0n0eMPaRe1maA4Ij6R2zZpqx1DNBjDweH2/8+oPjSjoC3lo6TYZiogKgvjliPSz3xFnfemQzatOYyrVsD4mXEJWSvcbekuXV1fSKMOpf/tchq8gr3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822554; c=relaxed/simple;
	bh=txIcSIRbJGiLatJ4O2paIA6h6w37GdIaCF/465ySMr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPQ/0ExN95FZtCLgNTw5nYDIRVvDCqVgXVuw3WxckfLl0TLNV6MVmeAhCGH5FwCUoiO06EmKQKauzaGQmC5/XZBy1Org+clUD6t++ZCBPSSscfHTbxBDZ+50l0ar85Ja+A/8CuO18/KFpdk533uqnqPiNQt07Zm7dzqodv2v2T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=qkooYq8W; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2161eb95317so34045195ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1733822552; x=1734427352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M8cl2ABtE3d2Hox58Hq8BfKUV3nNnUF99dKqOlggt8c=;
        b=qkooYq8WvTW+tIu99cqd2VeuLqT5YAq44mLVnNV8u1aehPvGuNp6xugnALNlJPg89s
         f3iDu99faHmOT3rR3IXaJb0sPUf8BDp6m+c62l/BZrI3yhzLqGLTHubFw8Zdy7ZCBtyz
         5BVPf98fgTsJFdc4TC2XTGPcngZbfLEcmHpQQn5yy9yW0LW6cZlvtcmk758YsRBdeWTC
         hXQzyQCaykjCJlKf+MdC9UYWDIkxReEYCd6lAF/FBL/2rEnHxP7BTAd7bWbH6bZP2Npp
         XPmH418lYI9EiFF1YR0Kd6BTD3aBpwX6Y9liivBkRzgcyPp26Z6Y8q4RVurTxNt5ZAxz
         9x/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733822552; x=1734427352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M8cl2ABtE3d2Hox58Hq8BfKUV3nNnUF99dKqOlggt8c=;
        b=kMpruLPnvwuxoWQUjkVcaYf0VZOwvu6IAIRmdlY5Q+bgjkj3N5lpa+0AwQCh/lGz45
         WV6USmyhOSuOPZsrHqGq7oJB2BSdkyl2FpGjz7USZQ2itt2fBaWyi9Awx2ureN7h6ofm
         fGMEKtjsj/O0i2yeJeuRhQi9/cS03hYLd1wdjK5+kVj+5Zmci7QadgqL0zqSMRHf0UFr
         x7JUCntMT7JLUSCCV6BOpgYIhhEbRU3FeKFUMjKb1tHyuXpzgyHileHI2DxcD6nuiyEs
         cuOrE7mdj1q8s55LE0Wd4yZfnCnTzJXGXyUvExmWyx8E2tMCfCYSw4g6GY2ZVWNbiUsi
         gAPw==
X-Forwarded-Encrypted: i=1; AJvYcCVAZtNmV0Oo0NCdpVs/HpRB5c3H8bQ3VcHbtAstmw4ocPvhJwOlXqYsjSiYz+BjyFz+20XLOXItuhYrNyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRGoC8FQKtDg3QiLP7P0BVTk237H2C9iahAAyRm5fFi0n55+92
	0JsBo5M2GVU0Y9LCRndxQB5c5AlWI5RkpNcDsmg9h6IxWRFa2DXCR/m8z/BVRA==
X-Gm-Gg: ASbGnctAgT6JYh84r2cM/KK5oHD44wYqKt5m4ywBDkk2VtjeXG5o091JmuewFi+p7oG
	p8EVKGQ4Z1QptriAj92WOL3EHi2B/1rnRF3e06NQ+ZyWrmrM0KqBt/DZmQOSZ3F2wNUVSOltN2a
	sMQ8QMZlXY5qos1V5W5RTW0OYLdKywYI3AsEGVVXhZgaAlYb8NKwmYw28U2vKi9u0fODAk97Gfd
	d9ghR+mpuMc+1sZGS9mUmtt7dcTEQScbIwO4EP8JY5qxYAlOHADBK/LkfIjiMR9DzPM+EYtyu6B
	rWZ2FWE6HykxZ8oSGFa2kxhcgA/r
X-Google-Smtp-Source: AGHT+IFR4RpOio8Ua98EvFQG+NHIjlakZBUY/REjznnr/BHtBjieBarNtOT/+pHkFX6yGtL6+WcDVQ==
X-Received: by 2002:a17:903:2351:b0:216:46f4:7e5a with SMTP id d9443c01a7336-2166a03f010mr45521535ad.45.1733822551911;
        Tue, 10 Dec 2024 01:22:31 -0800 (PST)
Received: from ?IPV6:2401:4900:4451:8982:a0c3:dcc6:3a8d:184? ([2401:4900:4451:8982:a0c3:dcc6:3a8d:184])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216688a6dffsm16838035ad.113.2024.12.10.01.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 01:22:31 -0800 (PST)
Message-ID: <33c61b28-c0b8-478d-8107-c6ed1ff9e466@beagleboard.org>
Date: Tue, 10 Dec 2024 14:52:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] of: overlay: Add support for export-symbols node
 feature
To: Herve Codina <herve.codina@bootlin.com>, Andrew Davis <afd@ti.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20241209151830.95723-1-herve.codina@bootlin.com>
Content-Language: en-US
From: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <20241209151830.95723-1-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/12/24 20:48, Herve Codina wrote:
> Hi,
> 
> At Linux Plumbers Conference 2024, we (me and Luca Ceresolli) talked
> about issues we have with runtime hotplug on non-discoverable busses
> with device tree overlays [1].
> 
> On our system, a base board has a connector and addon boards can be
> connected to this connector. Both boards are described using device
> tree. The base board is described by a base device tree and addon boards
> are describe by overlays device tree. More details can be found at [2].
> 
> This kind of use case can be found also on:
>    - Grove Sunlight Sensor [3]
>    - mikroBUS [4]
> 
> One of the issue we were facing on was referencing resources available
> on the base board device tree from the addon overlay device tree.
> 
> Using a nexus node [5] helps decoupling resources and avoid the
> knowledge of the full base board from the overlay. Indeed, with nexus
> node, the overlay need to know only about the nexus node itself.
> 
> For instance, suppose a connector where a GPIO is connected at PinA. On
> the base board this GPIO is connected to the GPIO 12 of the SoC GPIO
> controller.
> 
> The base board can describe this GPIO using a nexus node:
>      soc_gpio: gpio-controller {
>        #gpio-cells = <2>;
>      };
> 
>      connector1: connector1 {
>          /*
>           * Nexus node for the GPIO available on the connector.
>           * GPIO 0 (Pin A GPIO) is connected to GPIO 12 of the SoC gpio
>           * controller
>           */
>          #gpio-cells = <2>;
>          gpio-map = <0 0 &soc_gpio 12 0>;
>          gpio-map-mask = <0xf 0x0>;
>          gpio-map-pass-thru = <0x0 0xf>;
>      };
> 
> The connector pin A GPIO can be referenced using:
>    <&connector1 0 GPIO_ACTIVE_HIGH>
> 
> This implies that the overlay needs to know about exact label that
> references the connector. This label can be different on a different
> board and so applying the overlay could failed even if it is used to
> describe the exact same addon board. Further more, a given base board
> can have several connectors where the exact same addon board can be
> connected. In that case, the same overlay cannot be used on both
> connector. Indeed, the connector labels have to be different.
> 
> The export-symbols node introduced by this current series solves this
> issue.
> 
> The idea of export-symbols is to have something similar to the global
> __symbols__ node but local to a specific node. Symbols listed in this
> export-symbols are local and visible only when an overlay is applied on
> a node having an export-symbols subnode.
> 
> Using export-symbols, our example becomes:
>      soc_gpio: gpio-controller {
>        #gpio-cells = <2>;
>      };
> 
>      connector1: connector1 {
>          /*
>           * Nexus node for the GPIO available on the connector.
>           * GPIO 0 (Pin A GPIO) is connected to GPIO 12 of the SoC gpio
>           * controller
>           */
>          #gpio-cells = <2>;
>          gpio-map = <0 0 &soc_gpio 12 0>;
>          gpio-map-mask = <0xf 0x0>;
>          gpio-map-pass-thru = <0x0 0xf>;
> 
>          export-symbols {
>            connector = <&connector1>;
>          };
>      };
> 
> With that export-symbols node, an overlay applied on connector1 node can
> have the symbol named 'connector' resolved to connector1. Indeed, the
> export-symbols node available at connector1 node is used when the
> overlay is applied. If the overlay has an unresolved 'connector' symbol,
> it will be resolved to connector1 thanks to export-symbols.
> 
> Our overlay using the nexus node can contains:
>     node {
>        foo-gpio = <&connector 0 GPIO_ACTIVE_HIGH>;
>     };
> It used the GPIO 0 from the connector it is applied on.
> 
> A board with two connectors can be described with:
>      connector1: connector1 {
>          ...
>          export-symbols {
>            connector = <&connector1>;
>          };
>      };
> 
>      connector2: connector2 {
>          ...
>          export-symbols {
>            connector = <&connector2>;
>          };
>      };
> 
> In that case, the same overlay with unresolved 'connector' symbol can be
> applied on both connectors and the correct symbol resolution (connector1
> or connector2) will be done.

What is the reason for not using symbols directly as described here [3]?

I do like this approach since it does not pollute the global symbols. 
Just want to know if there are any other reasons for it.

> 
> This current series add support for the export-symbols node feature:
>    - Patch 1 describes the export-symbols binding
>    - Patches 2 to 6 prepare and add the support for the export-symbols
>      feature
>    - Patch 7 adds an unittest for the export-symbols feature
> 
> Best regards,
> Hervé
> 
> [1] https://lpc.events/event/18/contributions/1696/
> [2] https://lore.kernel.org/lkml/20240917-hotplug-drm-bridge-v4-0-bc4dfee61be6@bootlin.com/
> [3] https://lore.kernel.org/lkml/20240702164403.29067-1-afd@ti.com/
> [4] https://lore.kernel.org/lkml/20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org/
> [5] https://github.com/devicetree-org/devicetree-specification/blob/v0.4/source/chapter2-devicetree-basics.rst#nexus-nodes-and-specifier-mapping
> 
> Herve Codina (7):
>    dt-bindings: Add support for export-symbols node
>    of: resolver: Introduce get_phandle_from_symbols_node()
>    of: resolver: Add export_symbols in of_resolve_phandles() parameters
>    of: resolver: Add support for the export symbols node
>    of: overlay: Add export_symbols_name in of_overlay_fdt_apply()
>      parameters
>    of: overlay: Add support for the export symbols node
>    of: unittest: Add tests for export symbols
> 
>   .../devicetree/bindings/export-symbols.yaml   | 43 ++++++++++
>   drivers/misc/lan966x_pci.c                    |  3 +-
>   drivers/of/of_kunit_helpers.c                 |  2 +-
>   drivers/of/of_private.h                       |  2 +-
>   drivers/of/overlay.c                          | 30 ++++++-
>   drivers/of/resolver.c                         | 80 ++++++++++++++-----
>   drivers/of/unittest-data/Makefile             |  5 ++
>   .../unittest-data/overlay_export_symbols.dtso | 15 ++++
>   .../of/unittest-data/testcases_common.dtsi    |  1 +
>   .../unittest-data/tests-export-symbols.dtsi   | 30 +++++++
>   drivers/of/unittest.c                         | 76 ++++++++++++++++--
>   include/linux/of.h                            |  6 +-
>   12 files changed, 259 insertions(+), 34 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/export-symbols.yaml
>   create mode 100644 drivers/of/unittest-data/overlay_export_symbols.dtso
>   create mode 100644 drivers/of/unittest-data/tests-export-symbols.dtsi
> 


Ayush Singh

