Return-Path: <linux-kernel+bounces-438326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1909E9FC8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A8E281B06
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F000198E63;
	Mon,  9 Dec 2024 19:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRIsoSC2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B798015853B;
	Mon,  9 Dec 2024 19:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733773193; cv=none; b=CpRVi97t8WP3fSfoxzkMLADcHGJEA6HikbouI3wLxoTnxPATTzmtJ/kSYlyY5MHK5A0p2k2N6bcBir8JA+b9tp/ide/s5j9MIcyfa+IYEuScBoOtdvKAE3xZfbuJiuxDhDLnYhbFgbep+T0BO7xFgfs6XdFhq/LVDOwLDoMdWGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733773193; c=relaxed/simple;
	bh=dMc2WRWpZ0/k/Q4HK4bCVYHNe58Od5MxNMvKDHwTLTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBisck/4H/ZahLjfkg1lIR9rOYBX2q04/sjVXfBd/tIeNfHXF+ExzO2fDRelOxcMFmJNhLFZVQ3rC0aW6xbQh/v2fGPwNmWFrjWcMjc8jJNlZ4ziM/u2PxTmHI8kDcti7QXDf/Y2Ubl5imBsyMBYbBnU5VBPodkXt9li10tpRCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRIsoSC2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC17C4CEE0;
	Mon,  9 Dec 2024 19:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733773193;
	bh=dMc2WRWpZ0/k/Q4HK4bCVYHNe58Od5MxNMvKDHwTLTs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LRIsoSC2OqGCNRy7+/UG751xDc9BADfbru6DzVH+ZWegnCC13n4VF2V/04ma/yAVC
	 ISALpG69njscyJ+XCTfR98oiuucwr0ep7MHBCtiSrR3EJDW7es2R6+snN6zzerriwp
	 2gdvX6nUNPMJXYtAD5UPbctzRYARg9adRMLVSAM6ZZmAel3e8tzboyRbop/hS44j/F
	 Ig/qDjldVwIeQy6ZZtGhxJxF8OWSGEgLT3d3v7uBEagPsJUN46KPmeScSUBIM2pS4L
	 ZjED9Y4JateT5NuZQV+XkhiveAP9B7VN6nr6fhhlHhVhhwuLohaJ5ENxS5m0EPbl5G
	 z4oZ3LJIY7UHQ==
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6efc58fae20so44289767b3.0;
        Mon, 09 Dec 2024 11:39:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXBR4qWVs80X5qdHw+eehPlSqr8jpapFeilvftHSAzRuV+eClQTf+VHMZ4pUUfMcoAyTHSg1XIdOCSq9czW@vger.kernel.org, AJvYcCXimQ5rX3ZRzDD5f/WhpmY1c6mZ6SzjF7hZDZtHTEfTTYM8R+UYQuY6HcMdLlw6mUZeDH9paKaXICik@vger.kernel.org
X-Gm-Message-State: AOJu0YwgmC03Ts1oJM4yVE09lnu7SdLe9dtA2EOKMJvehiMzgQGVcWgy
	Ufz5vuczsJB6CuKpdTjs/NwXFiMlPdMEF2JzdyEEQsyWYKlAZW0cQCyCxUix04e1BGq4a693YES
	n9NAY/3ILE11zq+2WT4hMar4l2A==
X-Google-Smtp-Source: AGHT+IFHRcFDx7A3bDa/RTT5Au96A/G/vJcEmJ/aW6pzuUasYiHXNzlGvdG+gjunw22MChCuisZdpdKPIbDnxF55Uyw=
X-Received: by 2002:a05:690c:46c7:b0:6ef:57f9:ec4 with SMTP id
 00721157ae682-6efe3bcf570mr121687677b3.5.1733773192223; Mon, 09 Dec 2024
 11:39:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209151830.95723-1-herve.codina@bootlin.com>
 <5889e0aa-15f9-41fe-9d80-ec59fee2f62b@ti.com> <20241209180320.30fc0da6@bootlin.com>
 <2912af91-6012-4e6a-9439-737e319b7724@ti.com>
In-Reply-To: <2912af91-6012-4e6a-9439-737e319b7724@ti.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 9 Dec 2024 13:39:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKg0NpDi1Zf1T+f2rYw5UuVfK7+kjWj1_edFWH8EStjXw@mail.gmail.com>
Message-ID: <CAL_JsqKg0NpDi1Zf1T+f2rYw5UuVfK7+kjWj1_edFWH8EStjXw@mail.gmail.com>
Subject: Re: [PATCH 0/7] of: overlay: Add support for export-symbols node feature
To: Andrew Davis <afd@ti.com>
Cc: Herve Codina <herve.codina@bootlin.com>, Ayush Singh <ayush@beagleboard.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Saravana Kannan <saravanak@google.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 11:47=E2=80=AFAM Andrew Davis <afd@ti.com> wrote:
>
> On 12/9/24 11:03 AM, Herve Codina wrote:
> > On Mon, 9 Dec 2024 10:47:50 -0600
> > Andrew Davis <afd@ti.com> wrote:
> >
> >> On 12/9/24 9:18 AM, Herve Codina wrote:
> >>> Hi,
> >>>
> >>> At Linux Plumbers Conference 2024, we (me and Luca Ceresolli) talked
> >>> about issues we have with runtime hotplug on non-discoverable busses
> >>> with device tree overlays [1].
> >>>
> >>> On our system, a base board has a connector and addon boards can be
> >>> connected to this connector. Both boards are described using device
> >>> tree. The base board is described by a base device tree and addon boa=
rds
> >>> are describe by overlays device tree. More details can be found at [2=
].
> >>>
> >>> This kind of use case can be found also on:
> >>>     - Grove Sunlight Sensor [3]
> >>>     - mikroBUS [4]
> >>>
> >>> One of the issue we were facing on was referencing resources availabl=
e
> >>> on the base board device tree from the addon overlay device tree.
> >>>
> >>> Using a nexus node [5] helps decoupling resources and avoid the
> >>> knowledge of the full base board from the overlay. Indeed, with nexus
> >>> node, the overlay need to know only about the nexus node itself.
> >>>
> >>> For instance, suppose a connector where a GPIO is connected at PinA. =
On
> >>> the base board this GPIO is connected to the GPIO 12 of the SoC GPIO
> >>> controller.
> >>>
> >>> The base board can describe this GPIO using a nexus node:
> >>>       soc_gpio: gpio-controller {
> >>>         #gpio-cells =3D <2>;
> >>>       };
> >>>
> >>>       connector1: connector1 {
> >>>           /*
> >>>            * Nexus node for the GPIO available on the connector.
> >>>            * GPIO 0 (Pin A GPIO) is connected to GPIO 12 of the SoC g=
pio
> >>>            * controller
> >>>            */
> >>>           #gpio-cells =3D <2>;
> >>>           gpio-map =3D <0 0 &soc_gpio 12 0>;
> >>>           gpio-map-mask =3D <0xf 0x0>;
> >>>           gpio-map-pass-thru =3D <0x0 0xf>;
> >>>       };
> >>>
> >>> The connector pin A GPIO can be referenced using:
> >>>     <&connector1 0 GPIO_ACTIVE_HIGH>
> >>>
> >>> This implies that the overlay needs to know about exact label that
> >>> references the connector. This label can be different on a different
> >>> board and so applying the overlay could failed even if it is used to
> >>> describe the exact same addon board. Further more, a given base board
> >>> can have several connectors where the exact same addon board can be
> >>> connected. In that case, the same overlay cannot be used on both
> >>> connector. Indeed, the connector labels have to be different.
> >>>
> >>> The export-symbols node introduced by this current series solves this
> >>> issue.
> >>>
> >>> The idea of export-symbols is to have something similar to the global
> >>> __symbols__ node but local to a specific node. Symbols listed in this
> >>> export-symbols are local and visible only when an overlay is applied =
on
> >>> a node having an export-symbols subnode.
> >>>
> >>> Using export-symbols, our example becomes:
> >>>       soc_gpio: gpio-controller {
> >>>         #gpio-cells =3D <2>;
> >>>       };
> >>>
> >>>       connector1: connector1 {
> >>>           /*
> >>>            * Nexus node for the GPIO available on the connector.
> >>>            * GPIO 0 (Pin A GPIO) is connected to GPIO 12 of the SoC g=
pio
> >>>            * controller
> >>>            */
> >>>           #gpio-cells =3D <2>;
> >>>           gpio-map =3D <0 0 &soc_gpio 12 0>;
> >>>           gpio-map-mask =3D <0xf 0x0>;
> >>>           gpio-map-pass-thru =3D <0x0 0xf>;
> >>>
> >>>           export-symbols {
> >>>             connector =3D <&connector1>;
> >>>           };
> >>>       };
> >>>
> >>> With that export-symbols node, an overlay applied on connector1 node =
can
> >>> have the symbol named 'connector' resolved to connector1. Indeed, the
> >>> export-symbols node available at connector1 node is used when the
> >>> overlay is applied. If the overlay has an unresolved 'connector' symb=
ol,
> >>> it will be resolved to connector1 thanks to export-symbols.
> >>>
> >>> Our overlay using the nexus node can contains:
> >>>      node {
> >>>         foo-gpio =3D <&connector 0 GPIO_ACTIVE_HIGH>;
> >>>      };
> >>> It used the GPIO 0 from the connector it is applied on.
> >>>
> >>> A board with two connectors can be described with:
> >>>       connector1: connector1 {
> >>>           ...
> >>>           export-symbols {
> >>>             connector =3D <&connector1>;
> >>>           };
> >>>       };
> >>>
> >>>       connector2: connector2 {
> >>>           ...
> >>>           export-symbols {
> >>>             connector =3D <&connector2>;
> >>>           };
> >>>       };
> >>>
> >>> In that case, the same overlay with unresolved 'connector' symbol can=
 be
> >>> applied on both connectors and the correct symbol resolution (connect=
or1
> >>> or connector2) will be done.
> >>>
> >>
> >> I might be missing something, but how is the correct connector (connec=
tor1
> >> or connector2) selected? Let's say I connect my addon board to connect=
or2,
> >> then I apply the addon board's overlay to the base DTB. What connector
> >> just got referenced?
> >>
> >
> > A driver for the connector is needed.
> > The driver applies the overlay using of_overlay_fdt_apply().
> > The node the overlay has to be applied to is passed by the driver to
> > of_overlay_fdt_apply().
> >
>
> So every connector needs a driver? Most connectors are dumb connectors,
> just a bunch of wires broken out to a header.

Yes. So write a dumb-connector driver for all the dumb/simple/generic
connectors.

Though once pinmuxing comes into play, I'm not sure that anything will
be dumb or generic.

Rob

