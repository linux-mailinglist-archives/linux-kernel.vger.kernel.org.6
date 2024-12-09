Return-Path: <linux-kernel+bounces-438357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B1E9EA016
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61111887B3B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B060B199EA3;
	Mon,  9 Dec 2024 20:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPWV71do"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DB8184556;
	Mon,  9 Dec 2024 20:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733775082; cv=none; b=ErFL1TMTw9Y4rcTdHQIBLvMJBo3esIKc+6KNjudvmjXDCeJReuJ+YUaI92712Rm8hNJt4KqLfTHSdhf1+7lp3BYaZZEAULkYQFfWrf5+4IDz05kWpPx7CT7pUzFOZqaJAMmmufv1dq7IJykuRc7zxgu55F8mEgF10frp1SJaKjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733775082; c=relaxed/simple;
	bh=SnNUN5n6ZYtHkK4rNt8bqPhiFYzLf9fGp7kgJCZ6H10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDa580noWbc2YT1wijDRJ54VtGZakRFJ6zgTU9mSepDFywF1Z+swQKckMEhueencWS7nYLN68bLy1QWavk0728QmBCk5iPEDlcNCG2xMKq2Ev5OfZK826Ceky6GBfxBVHf0vGsyotbNqZ0cOQWKHbBamUSRLs2BFT9811QORORk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPWV71do; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F9BC4CEE0;
	Mon,  9 Dec 2024 20:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733775081;
	bh=SnNUN5n6ZYtHkK4rNt8bqPhiFYzLf9fGp7kgJCZ6H10=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lPWV71dobacR80gF+2TwZnLjo8OE0mrywikfN06qdjAVfMQPrFxGI0C9oPvjsoFBz
	 FjsRGLOQN9AifUoppDCRYzGGs2rzDxyORPXZW4hib0reJgQtvzEsgxkT+Ea9z6BGwn
	 JAPhuRVTVzqKjAoiwke7hYugEQrq5bD6R0lqjMW9rKIJdIWfREkq0VGQiDvklLWT+1
	 7OVPnH5twBmVbZJmAthUpIZmRJT8wOsYTuZGufbRZQx16XKf8qxDbGZjnDd5fs39O2
	 RzrPI5WpyN3stUdmfawo+snU5kLYO8WkcN24OotjUi94oOuFb2KoirpVS39nWhEwo0
	 Y4iio7z5XapKg==
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e3a0acba5feso2464529276.2;
        Mon, 09 Dec 2024 12:11:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVIV+WXHPbiVc/2SoW3u/uQrwbJ2cdfKU9lObapeFDIRrwqVECk+8hJede+M5KZyh+BrkI0gFafo9xesoDq@vger.kernel.org, AJvYcCW5HgGzhW4McO/cBz0KVwUJhjKPZ9TdEpiygB0PM3duFo1vUvLuLNLEZGWt7ymJbhQfn3asmVBf1ULB@vger.kernel.org
X-Gm-Message-State: AOJu0YxBa45b0y4PYRZr/AU+lYIBRL4TGPLQOMzpF6CEebiPg8tWoQyn
	4F1WWjQ0uYSr3dGt3htgBctucXrr0L0Cgsm+dloSkr2ZMGvgta9I9OMgowTmskGcN3LOd8XuPLk
	8EEpLXLJR+glXdPbLejS6EOrvvQ==
X-Google-Smtp-Source: AGHT+IGv/NmqqGVG5bLKOCoZkULGbmKUllappSjoyh5+B0mjg69ebx4vEE79xCMhO6k+AgdLnDvN43NwxuciYbYFVsE=
X-Received: by 2002:a05:6902:15c2:b0:e3a:3a3d:40c3 with SMTP id
 3f1490d57ef6-e3a59bacc42mr1534956276.40.1733775080663; Mon, 09 Dec 2024
 12:11:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209151830.95723-1-herve.codina@bootlin.com>
In-Reply-To: <20241209151830.95723-1-herve.codina@bootlin.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 9 Dec 2024 14:11:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLT3prYBcxnsUwAShULCLJScYoU29ta29RJLGyiNkCrTg@mail.gmail.com>
Message-ID: <CAL_JsqLT3prYBcxnsUwAShULCLJScYoU29ta29RJLGyiNkCrTg@mail.gmail.com>
Subject: Re: [PATCH 0/7] of: overlay: Add support for export-symbols node feature
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Davis <afd@ti.com>, Ayush Singh <ayush@beagleboard.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Saravana Kannan <saravanak@google.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 9:18=E2=80=AFAM Herve Codina <herve.codina@bootlin.c=
om> wrote:
>
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
>   - Grove Sunlight Sensor [3]
>   - mikroBUS [4]
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
>     soc_gpio: gpio-controller {
>       #gpio-cells =3D <2>;
>     };
>
>     connector1: connector1 {
>         /*
>          * Nexus node for the GPIO available on the connector.
>          * GPIO 0 (Pin A GPIO) is connected to GPIO 12 of the SoC gpio
>          * controller
>          */
>         #gpio-cells =3D <2>;
>         gpio-map =3D <0 0 &soc_gpio 12 0>;
>         gpio-map-mask =3D <0xf 0x0>;
>         gpio-map-pass-thru =3D <0x0 0xf>;
>     };
>
> The connector pin A GPIO can be referenced using:
>   <&connector1 0 GPIO_ACTIVE_HIGH>
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
>     soc_gpio: gpio-controller {
>       #gpio-cells =3D <2>;
>     };
>
>     connector1: connector1 {
>         /*
>          * Nexus node for the GPIO available on the connector.
>          * GPIO 0 (Pin A GPIO) is connected to GPIO 12 of the SoC gpio
>          * controller
>          */
>         #gpio-cells =3D <2>;
>         gpio-map =3D <0 0 &soc_gpio 12 0>;
>         gpio-map-mask =3D <0xf 0x0>;
>         gpio-map-pass-thru =3D <0x0 0xf>;
>
>         export-symbols {
>           connector =3D <&connector1>;
>         };
>     };
>
> With that export-symbols node, an overlay applied on connector1 node can
> have the symbol named 'connector' resolved to connector1. Indeed, the
> export-symbols node available at connector1 node is used when the
> overlay is applied. If the overlay has an unresolved 'connector' symbol,
> it will be resolved to connector1 thanks to export-symbols.
>
> Our overlay using the nexus node can contains:
>    node {
>       foo-gpio =3D <&connector 0 GPIO_ACTIVE_HIGH>;
>    };

Couldn't we make something like this work:

connector: __overlay__ {

   node {
      foo-gpio =3D <&connector 0 GPIO_ACTIVE_HIGH>;
   };
};

We already have to process all the phandles in the overlay. So this
just changes handling of 'connector' from being a local phandle which
we just renumber to an unresolved phandle which we have to lookup and
replace the phandle uses with.

Rob

