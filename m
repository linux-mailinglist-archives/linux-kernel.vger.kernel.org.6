Return-Path: <linux-kernel+bounces-438035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA049E9C0A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96DC2283368
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6FA1494DF;
	Mon,  9 Dec 2024 16:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="plfWaEuQ"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1405733A;
	Mon,  9 Dec 2024 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733762888; cv=none; b=Gh8D9jZ+D+Q48eqDWvkbm+oBeK63w1CRlwejxl1bznyZPqBV7ChQBueyprPuJXJkDZ6CCriAYz8voVfQwLUN+2ojQLZYG3ZrO4NYf0Dq9Cy9mgH1vtcRFRU4ny+12WmTyz4AMbVN7QeTXx+uCwdguRyI0MY/PeKWfvvMs/yVRfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733762888; c=relaxed/simple;
	bh=ZdxnxnVZe5p/tnByDnKXy8Z2rRJhWb4NaN76UEl7a8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LLgFHi9xeuweH4IMCuxWkRqMHvYfblFMnlQPK6P52j+1kc9+AQTePqiSXM+dqqp3vEr24G9dVlbTqUfOAVCuzDbCp3OupTqrAI8UOY9M/LM/lQY30jA2N2ZbL+VZnIjy43iBbN3XeZaKbDs1telEll6e+gYxFOA5qme8j8R5tAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=plfWaEuQ; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B9GlpJ72335345
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 10:47:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733762872;
	bh=moRgWpRuMXsSLHrtTMIRtjFHzEe23DdqDsRO7SJspKA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=plfWaEuQG9M4u97DdR0wLtvx1kjctuR9VI0H5eRUhoAtG7jb5Gn7U1FDGlDjDtBh/
	 nIoFMkd+5zgztwuNX4DH/kWU++V+mMODsyO6SW83oEoHLxl0rIfehCQmAglXD/a4/v
	 0fyqLDULJShwXyjRC+NVFPpnvJPqUg09PBP1Ksyc=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B9GlpwM026050
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Dec 2024 10:47:51 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Dec 2024 10:47:51 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Dec 2024 10:47:51 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B9Glon7040033;
	Mon, 9 Dec 2024 10:47:51 -0600
Message-ID: <5889e0aa-15f9-41fe-9d80-ec59fee2f62b@ti.com>
Date: Mon, 9 Dec 2024 10:47:50 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] of: overlay: Add support for export-symbols node
 feature
To: Herve Codina <herve.codina@bootlin.com>,
        Ayush Singh
	<ayush@beagleboard.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan
	<saravanak@google.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Luca
 Ceresoli <luca.ceresoli@bootlin.com>,
        Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>
References: <20241209151830.95723-1-herve.codina@bootlin.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20241209151830.95723-1-herve.codina@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 12/9/24 9:18 AM, Herve Codina wrote:
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
> 

I might be missing something, but how is the correct connector (connector1
or connector2) selected? Let's say I connect my addon board to connector2,
then I apply the addon board's overlay to the base DTB. What connector
just got referenced?

Andrew

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

