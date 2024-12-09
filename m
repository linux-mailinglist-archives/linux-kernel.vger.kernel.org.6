Return-Path: <linux-kernel+bounces-438145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74209E9D68
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA5B2826F0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF7B1C5CB7;
	Mon,  9 Dec 2024 17:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bUF2rChN"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C14923315E;
	Mon,  9 Dec 2024 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766449; cv=none; b=DlGL8qinHaDw01bgkq2e3/0UkQwtyffZJJQhxPjydTApqvA2R0JJX83MmgjPWvH8JDbledRI4Em7v6snxGZxaI+EUgEP+dP95yxgVR2fJEhh1brktAJxZbuJq9+Wq2Y4AM23EyHljAM8ACJZDkxfpxO540erkserJm7O9/qyGvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766449; c=relaxed/simple;
	bh=Y3lRbDCfH3A8PYlYcKSPcUcqsZwGYcTg/9f1bdIxfEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JAaziSHUK99EQxPFlnbZru2H+ld3ORcojsodx10mZHs4rORMKpKxJkBnpPmVv0yyWT8QygCVHd2gp+THnrT/cbvFPkdbGam9fFuWVkiLTEXAAo6cxDZypOioxUtNaFRT9iCwQw4IrmNWnMXAG+kC2PIn8cDn0UByqxfLTJW+Usk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bUF2rChN; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B9HlEDI2341854
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 11:47:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733766434;
	bh=eTG/e2l3KpvcafqmdZO1vCcPlH+GvHFgYJFOv8hUdfs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=bUF2rChNq+1jH5pkJvE33PgFHVGweZHipwwHO1sRFiT/ABjbc/cLZlkz1mx8+B+t2
	 fp7eKaMmPUHZP/wD36Ler7nEo3OkFJAeCZXO5jT5RUG5QN6gA4KVw/6WXkxp1HYBqb
	 aRD67SxPwLY7kWH9RFObyz0/dpu1D26SgYLc9uKg=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B9HlE1S058412
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Dec 2024 11:47:14 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Dec 2024 11:47:14 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Dec 2024 11:47:14 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B9HlDO7044631;
	Mon, 9 Dec 2024 11:47:13 -0600
Message-ID: <2912af91-6012-4e6a-9439-737e319b7724@ti.com>
Date: Mon, 9 Dec 2024 11:47:13 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] of: overlay: Add support for export-symbols node
 feature
To: Herve Codina <herve.codina@bootlin.com>
CC: Ayush Singh <ayush@beagleboard.org>,
        Geert Uytterhoeven
	<geert@linux-m68k.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann
	<arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana
 Kannan <saravanak@google.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20241209151830.95723-1-herve.codina@bootlin.com>
 <5889e0aa-15f9-41fe-9d80-ec59fee2f62b@ti.com>
 <20241209180320.30fc0da6@bootlin.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20241209180320.30fc0da6@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 12/9/24 11:03 AM, Herve Codina wrote:
> On Mon, 9 Dec 2024 10:47:50 -0600
> Andrew Davis <afd@ti.com> wrote:
> 
>> On 12/9/24 9:18 AM, Herve Codina wrote:
>>> Hi,
>>>
>>> At Linux Plumbers Conference 2024, we (me and Luca Ceresolli) talked
>>> about issues we have with runtime hotplug on non-discoverable busses
>>> with device tree overlays [1].
>>>
>>> On our system, a base board has a connector and addon boards can be
>>> connected to this connector. Both boards are described using device
>>> tree. The base board is described by a base device tree and addon boards
>>> are describe by overlays device tree. More details can be found at [2].
>>>
>>> This kind of use case can be found also on:
>>>     - Grove Sunlight Sensor [3]
>>>     - mikroBUS [4]
>>>
>>> One of the issue we were facing on was referencing resources available
>>> on the base board device tree from the addon overlay device tree.
>>>
>>> Using a nexus node [5] helps decoupling resources and avoid the
>>> knowledge of the full base board from the overlay. Indeed, with nexus
>>> node, the overlay need to know only about the nexus node itself.
>>>
>>> For instance, suppose a connector where a GPIO is connected at PinA. On
>>> the base board this GPIO is connected to the GPIO 12 of the SoC GPIO
>>> controller.
>>>
>>> The base board can describe this GPIO using a nexus node:
>>>       soc_gpio: gpio-controller {
>>>         #gpio-cells = <2>;
>>>       };
>>>
>>>       connector1: connector1 {
>>>           /*
>>>            * Nexus node for the GPIO available on the connector.
>>>            * GPIO 0 (Pin A GPIO) is connected to GPIO 12 of the SoC gpio
>>>            * controller
>>>            */
>>>           #gpio-cells = <2>;
>>>           gpio-map = <0 0 &soc_gpio 12 0>;
>>>           gpio-map-mask = <0xf 0x0>;
>>>           gpio-map-pass-thru = <0x0 0xf>;
>>>       };
>>>
>>> The connector pin A GPIO can be referenced using:
>>>     <&connector1 0 GPIO_ACTIVE_HIGH>
>>>
>>> This implies that the overlay needs to know about exact label that
>>> references the connector. This label can be different on a different
>>> board and so applying the overlay could failed even if it is used to
>>> describe the exact same addon board. Further more, a given base board
>>> can have several connectors where the exact same addon board can be
>>> connected. In that case, the same overlay cannot be used on both
>>> connector. Indeed, the connector labels have to be different.
>>>
>>> The export-symbols node introduced by this current series solves this
>>> issue.
>>>
>>> The idea of export-symbols is to have something similar to the global
>>> __symbols__ node but local to a specific node. Symbols listed in this
>>> export-symbols are local and visible only when an overlay is applied on
>>> a node having an export-symbols subnode.
>>>
>>> Using export-symbols, our example becomes:
>>>       soc_gpio: gpio-controller {
>>>         #gpio-cells = <2>;
>>>       };
>>>
>>>       connector1: connector1 {
>>>           /*
>>>            * Nexus node for the GPIO available on the connector.
>>>            * GPIO 0 (Pin A GPIO) is connected to GPIO 12 of the SoC gpio
>>>            * controller
>>>            */
>>>           #gpio-cells = <2>;
>>>           gpio-map = <0 0 &soc_gpio 12 0>;
>>>           gpio-map-mask = <0xf 0x0>;
>>>           gpio-map-pass-thru = <0x0 0xf>;
>>>
>>>           export-symbols {
>>>             connector = <&connector1>;
>>>           };
>>>       };
>>>
>>> With that export-symbols node, an overlay applied on connector1 node can
>>> have the symbol named 'connector' resolved to connector1. Indeed, the
>>> export-symbols node available at connector1 node is used when the
>>> overlay is applied. If the overlay has an unresolved 'connector' symbol,
>>> it will be resolved to connector1 thanks to export-symbols.
>>>
>>> Our overlay using the nexus node can contains:
>>>      node {
>>>         foo-gpio = <&connector 0 GPIO_ACTIVE_HIGH>;
>>>      };
>>> It used the GPIO 0 from the connector it is applied on.
>>>
>>> A board with two connectors can be described with:
>>>       connector1: connector1 {
>>>           ...
>>>           export-symbols {
>>>             connector = <&connector1>;
>>>           };
>>>       };
>>>
>>>       connector2: connector2 {
>>>           ...
>>>           export-symbols {
>>>             connector = <&connector2>;
>>>           };
>>>       };
>>>
>>> In that case, the same overlay with unresolved 'connector' symbol can be
>>> applied on both connectors and the correct symbol resolution (connector1
>>> or connector2) will be done.
>>>    
>>
>> I might be missing something, but how is the correct connector (connector1
>> or connector2) selected? Let's say I connect my addon board to connector2,
>> then I apply the addon board's overlay to the base DTB. What connector
>> just got referenced?
>>
> 
> A driver for the connector is needed.
> The driver applies the overlay using of_overlay_fdt_apply().
> The node the overlay has to be applied to is passed by the driver to
> of_overlay_fdt_apply().
> 

So every connector needs a driver? Most connectors are dumb connectors,
just a bunch of wires broken out to a header.

What if an addon board overlay uses multiple connectors?

If you need a connector-specific driver, and that driver needs to know
which node this overlay will be applied to, then why not just do a
fixup directly to the overlay in the driver?

Andrew

> Even if obsolete because I added one more parameter (export_symbols_name)
> in of_overlay_fdt_apply() in this current series, you can have a look at the
> following patch to see the connector driver:
>    https://lore.kernel.org/lkml/20240917-hotplug-drm-bridge-v4-8-bc4dfee61be6@bootlin.com/
> 
> Best regards,
> Hervé
> 

