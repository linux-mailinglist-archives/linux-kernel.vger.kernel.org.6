Return-Path: <linux-kernel+bounces-438080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 834C19E9C8C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF9E1889ECF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE7E155325;
	Mon,  9 Dec 2024 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EJBo/UjT"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0627149DFF;
	Mon,  9 Dec 2024 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763806; cv=none; b=W62pi5389dXh92N70BsnnfBWPQ0Tm6Q8v4E2D+KNnCSaLNzOLGg4oenvkOxXDqwMo0X7qcwxS3NqHm2n9Mm6UaAJ3URcksKbocoHyODuUPdU0fHjEgw611fv6mYytJzk3sjDk4J1clcq6Bvg/CYc9sZDxHOwhA4vVxxy8xk6YUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763806; c=relaxed/simple;
	bh=E0p0ikBfC3skqbJxu+XZIRZco62BX86/CaNjGeKHOPk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxDGH+oxg4CLt06F+NOTIQy5g6PGbPzVgcmzMRKlhd4GD6y0YuLsqG+0ipmIVDOY9vgpfbnf+ysNtOjjWVgzfo6vfnFNBmKwD2zn7MlXhzaH2qd1rG4VpSw1CnboEdPk8y14C5AejbigsEOowx8h42wRAhNZVIP+yzugBoOcwqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EJBo/UjT; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D9B6C1C0002;
	Mon,  9 Dec 2024 17:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733763801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kraLaKMNgpS11ew+7seVSsti9dljqUIID3DS17ZcAtA=;
	b=EJBo/UjTD6q9UzHZCqakfl0Gl1D9SZCwSV/DSPT+sr0riiqBFQj9KD8HlVezEnNqJFuxH2
	Nk7+UWK1kBxi3p0V9h8YbJjesuYp8IWqF9NfBsOLym55z01TIbxNiQAP939/wg1EHqKH5u
	xCTnwY+IcL0LOvWIo6xPXqI4jTKtxzW8WudUDlthbg7we9fS20zuj5nNH5MCdVK854w4JF
	lyWn12gShNNCDzw2Y1LoP+DuMNr+9wamHruHZcYJaycP6rSkblb3XUMorq6UUMmDts+zS/
	5P4wENpiWUQUP5ktGjFb3aAjRV7EA5IpPpDEgHe2MevFHta8fKMo9wpBtiFQzA==
Date: Mon, 9 Dec 2024 18:03:20 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Davis <afd@ti.com>
Cc: Ayush Singh <ayush@beagleboard.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Saravana
 Kannan <saravanak@google.com>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/7] of: overlay: Add support for export-symbols node
 feature
Message-ID: <20241209180320.30fc0da6@bootlin.com>
In-Reply-To: <5889e0aa-15f9-41fe-9d80-ec59fee2f62b@ti.com>
References: <20241209151830.95723-1-herve.codina@bootlin.com>
	<5889e0aa-15f9-41fe-9d80-ec59fee2f62b@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

On Mon, 9 Dec 2024 10:47:50 -0600
Andrew Davis <afd@ti.com> wrote:

> On 12/9/24 9:18 AM, Herve Codina wrote:
> > Hi,
> > 
> > At Linux Plumbers Conference 2024, we (me and Luca Ceresolli) talked
> > about issues we have with runtime hotplug on non-discoverable busses
> > with device tree overlays [1].
> > 
> > On our system, a base board has a connector and addon boards can be
> > connected to this connector. Both boards are described using device
> > tree. The base board is described by a base device tree and addon boards
> > are describe by overlays device tree. More details can be found at [2].
> > 
> > This kind of use case can be found also on:
> >    - Grove Sunlight Sensor [3]
> >    - mikroBUS [4]
> > 
> > One of the issue we were facing on was referencing resources available
> > on the base board device tree from the addon overlay device tree.
> > 
> > Using a nexus node [5] helps decoupling resources and avoid the
> > knowledge of the full base board from the overlay. Indeed, with nexus
> > node, the overlay need to know only about the nexus node itself.
> > 
> > For instance, suppose a connector where a GPIO is connected at PinA. On
> > the base board this GPIO is connected to the GPIO 12 of the SoC GPIO
> > controller.
> > 
> > The base board can describe this GPIO using a nexus node:
> >      soc_gpio: gpio-controller {
> >        #gpio-cells = <2>;
> >      };
> > 
> >      connector1: connector1 {
> >          /*
> >           * Nexus node for the GPIO available on the connector.
> >           * GPIO 0 (Pin A GPIO) is connected to GPIO 12 of the SoC gpio
> >           * controller
> >           */
> >          #gpio-cells = <2>;
> >          gpio-map = <0 0 &soc_gpio 12 0>;
> >          gpio-map-mask = <0xf 0x0>;
> >          gpio-map-pass-thru = <0x0 0xf>;
> >      };
> > 
> > The connector pin A GPIO can be referenced using:
> >    <&connector1 0 GPIO_ACTIVE_HIGH>
> > 
> > This implies that the overlay needs to know about exact label that
> > references the connector. This label can be different on a different
> > board and so applying the overlay could failed even if it is used to
> > describe the exact same addon board. Further more, a given base board
> > can have several connectors where the exact same addon board can be
> > connected. In that case, the same overlay cannot be used on both
> > connector. Indeed, the connector labels have to be different.
> > 
> > The export-symbols node introduced by this current series solves this
> > issue.
> > 
> > The idea of export-symbols is to have something similar to the global
> > __symbols__ node but local to a specific node. Symbols listed in this
> > export-symbols are local and visible only when an overlay is applied on
> > a node having an export-symbols subnode.
> > 
> > Using export-symbols, our example becomes:
> >      soc_gpio: gpio-controller {
> >        #gpio-cells = <2>;
> >      };
> > 
> >      connector1: connector1 {
> >          /*
> >           * Nexus node for the GPIO available on the connector.
> >           * GPIO 0 (Pin A GPIO) is connected to GPIO 12 of the SoC gpio
> >           * controller
> >           */
> >          #gpio-cells = <2>;
> >          gpio-map = <0 0 &soc_gpio 12 0>;
> >          gpio-map-mask = <0xf 0x0>;
> >          gpio-map-pass-thru = <0x0 0xf>;
> > 
> >          export-symbols {
> >            connector = <&connector1>;
> >          };
> >      };
> > 
> > With that export-symbols node, an overlay applied on connector1 node can
> > have the symbol named 'connector' resolved to connector1. Indeed, the
> > export-symbols node available at connector1 node is used when the
> > overlay is applied. If the overlay has an unresolved 'connector' symbol,
> > it will be resolved to connector1 thanks to export-symbols.
> > 
> > Our overlay using the nexus node can contains:
> >     node {
> >        foo-gpio = <&connector 0 GPIO_ACTIVE_HIGH>;
> >     };
> > It used the GPIO 0 from the connector it is applied on.
> > 
> > A board with two connectors can be described with:
> >      connector1: connector1 {
> >          ...
> >          export-symbols {
> >            connector = <&connector1>;
> >          };
> >      };
> > 
> >      connector2: connector2 {
> >          ...
> >          export-symbols {
> >            connector = <&connector2>;
> >          };
> >      };
> > 
> > In that case, the same overlay with unresolved 'connector' symbol can be
> > applied on both connectors and the correct symbol resolution (connector1
> > or connector2) will be done.
> >   
> 
> I might be missing something, but how is the correct connector (connector1
> or connector2) selected? Let's say I connect my addon board to connector2,
> then I apply the addon board's overlay to the base DTB. What connector
> just got referenced?
> 

A driver for the connector is needed.
The driver applies the overlay using of_overlay_fdt_apply().
The node the overlay has to be applied to is passed by the driver to
of_overlay_fdt_apply().

Even if obsolete because I added one more parameter (export_symbols_name)
in of_overlay_fdt_apply() in this current series, you can have a look at the
following patch to see the connector driver:
  https://lore.kernel.org/lkml/20240917-hotplug-drm-bridge-v4-8-bc4dfee61be6@bootlin.com/

Best regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

