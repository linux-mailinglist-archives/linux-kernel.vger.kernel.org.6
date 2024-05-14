Return-Path: <linux-kernel+bounces-178968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E07218C59EC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE0B1C2118B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E36017F38D;
	Tue, 14 May 2024 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o5QPFl7V"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEF217BB3A;
	Tue, 14 May 2024 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715705495; cv=none; b=Bni0bf5NvpXT+fSwq/98B3wmwxlrCQTNM7nxE6CTQA3IZ2JZIDMEw/yCDR6dZvTzUrgXtgT7Vyew04QV/xQErH2IvNNw1O/bPxYodF00Aq7yZhhijZqRg+8e7Hpdpwi6EicbS+dBfi6vhjvuF+B+96nk6rTZG95dZQNTZNMlXwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715705495; c=relaxed/simple;
	bh=/sXWbY5bVwW+QaGOyiEOeOR9BsrXCX5TRvPOb8yS0H0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DswD45doQgx2QumwChnbKmaPUDc3uSSZu5gQAMqBKA2jOsexOxpM/Y5bHFwz50y0jTBUilUpmsTbyBVUKVMsv2cHM475k57LlBXp8NqWTbYcYOr4dtw+CWXEK4gwI5ocKTGMOaJS2Onn6tBnuDleBDIyMavbtnWdaPw6KfJwqDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o5QPFl7V; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6407A1BF204;
	Tue, 14 May 2024 16:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715705490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NVxtV5KZLaCi1f0ZKlrkJa34DV012CIuuGWkdp/l8bM=;
	b=o5QPFl7V6GBCwRqp77iF+T0hrqht+Nq+9S7EKVI10bjf4j9IyPLWQbcpzTDegaXf2TfIT5
	N7yFufPPWW+jnmUGoJ8nX6mLSGvunJrQ5K89AaBY+0M2EHBQzo2AneN7r1n3BV2j9D08VC
	+7borUswfIoF4z6PzmZtLPKf7EvgvP5Or6uceqAXHvLVpbJ9Nh7RdjS9KZAkFgourD4Arv
	hNIXrLBdbK8mCvXdEXYWibx9J2+3IUC6Oaye83+J0kZySO107UzOYXUiE4tskOMHjiMdG0
	xhB6HOZEcPLcelR0ZiBpX2321AUqLG/OoTco4eeEACWbFAPZcwN99vUYZizeFQ==
Date: Tue, 14 May 2024 18:51:25 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Derek Kiernan
 <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, Arnd
 Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Saravana Kannan <saravanak@google.com>, Paul Kocialkowski
 <contact@paulk.fr>, =?UTF-8?Q?Herv=C3=A9?= Codina
 <herve.codina@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Paul
 Kocialkowski <paul.kocialkowski@bootlin.com>, Srinivas Kandagatla
 <srinivas.kandagatla@linaro.org>, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: connector: add GE SUNH hotplug
 addon connector
Message-ID: <20240514185125.58225238@booty>
In-Reply-To: <20240510163625.GA336987-robh@kernel.org>
References: <20240510-hotplug-drm-bridge-v2-0-ec32f2c66d56@bootlin.com>
	<20240510-hotplug-drm-bridge-v2-1-ec32f2c66d56@bootlin.com>
	<20240510163625.GA336987-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Rob,

+cc Srinivas and Miqu=C3=A8l for the NVMEM cell discussion below

On Fri, 10 May 2024 11:36:25 -0500
Rob Herring <robh@kernel.org> wrote:

> On Fri, May 10, 2024 at 09:10:37AM +0200, Luca Ceresoli wrote:
> > Add bindings for the GE SUNH add-on connector. This is a physical,
> > hot-pluggable connector that allows to attach and detach at runtime an
> > add-on adding peripherals on non-discoverable busses.
> >=20
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

[...]

> > +++ b/Documentation/devicetree/bindings/connector/ge,sunh-addon-connect=
or.yaml
> > @@ -0,0 +1,197 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/connector/ge,sunh-addon-connector.y=
aml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: GE SUNH hotplug add-on connector
> > +
> > +maintainers:
> > +  - Luca Ceresoli <luca.ceresoli@bootlin.com>
> > +
> > +description:
> > +  Represent the physical connector present on GE SUNH devices that all=
ows
> > +  to attach and detach at runtime an add-on adding peripherals on
> > +  non-discoverable busses.
> > +
> > +  This connector has status GPIOs to notify the connection status to t=
he
> > +  CPU and a reset GPIO to allow the CPU to reset all the peripherals o=
n the
> > +  add-on. It also has a 4-lane MIPI DSI bus.
> > +
> > +  Add-on removal can happen at any moment under user control and witho=
ut
> > +  prior notice to the CPU, making all of its components not usable
> > +  anymore. Later on, the same or a different add-on model can be conne=
cted. =20
>=20
> Is there any documentation for this connector?
>=20
> Is the connector supposed to be generic in that any board with any SoC=20
> could have it? If so, the connector needs to be able to remap things so=20
> overlays aren't tied to the base dts, but only the connector. If not,=20
> then doing that isn't required, but still a good idea IMO.

It is not generic. The connector pinout is very specific to this
product, and there is no public documentation.

> > +examples:
> > +  # Main DTS describing the "main" board up to the connector
> > +  - |
> > +    / {
> > +        #include <dt-bindings/gpio/gpio.h>
> > +
> > +        addon_connector: addon-connector { =20
>=20
> Just 'connector' for the node name.

OK

> > +            compatible =3D "ge,sunh-addon-connector";
> > +            reset-gpios =3D <&gpio1 1 GPIO_ACTIVE_LOW>;
> > +            plugged-gpios =3D <&gpio1 2 GPIO_ACTIVE_LOW>;
> > +            powergood-gpios =3D <&gpio1 3 GPIO_ACTIVE_HIGH>;
> > +
> > +            ports {
> > +                #address-cells =3D <1>;
> > +                #size-cells =3D <0>;
> > +
> > +                port@0 {
> > +                    reg =3D <0>;
> > +
> > +                    hotplug_conn_dsi_in: endpoint {
> > +                        remote-endpoint =3D <&previous_bridge_out>;
> > +                    };
> > +                };
> > +
> > +                port@1 {
> > +                    reg =3D <1>;
> > +
> > +                    hotplug_conn_dsi_out: endpoint {
> > +                        // remote-endpoint to be added by overlay
> > +                    };
> > +                };
> > +            };
> > +        };
> > +    };
> > +
> > +  # "base" overlay describing the common components on every add-on th=
at
> > +  # are required to read the model ID =20
>=20
> This is located on the add-on board, right?

Exactly. Each add-on has an EEPROM with the add-on model ID stored
along with other data.

> Is it really any better to have this as a separate overlay rather than=20
> just making it an include? Better to have just 1 overlay per board=20
> applied atomically than splitting it up.

(see below)

> > +  - |
> > +    &i2c1 { =20
>=20
> Generally, I think everything on an add-on board should be underneath=20
> the connector node. For starters, that makes controlling probing and=20
> removal of devices easier. For example, you'll want to handle=20
> reset-gpios and powergood-gpios before any devices 'appear'. Otherwise,=20
> you add devices on i2c1, start probing them, and then reset them at some=
=20
> async time?

This is not a problem because the code is asserting reset before
loading the first overlay. From patch 5/5:

    static int sunh_conn_attach(struct sunh_conn *conn)
    {
	int err;

	/* Reset the plugged board in order to start from a stable state */
	sunh_conn_reset(conn, false);

	err =3D sunh_conn_load_base_overlay(conn);
        ...
    }

> For i2c, it could look something like this:
>=20
> connector {
>   i2c {
> 	i2c-parent =3D <&i2c1>;
>=20
> 	eeprom@50 {...};
>   };
> };

I think this can be done, but I need to evaluate what is needed in the
driver code to support it.

> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        eeprom@50 {
> > +            compatible =3D "atmel,24c64";
> > +            reg =3D <0x50>;
> > +
> > +            nvmem-layout {
> > +                compatible =3D "fixed-layout";
> > +                #address-cells =3D <1>;
> > +                #size-cells =3D <1>;
> > +
> > +                addon_model_id: addon-model-id@400 {
> > +                    reg =3D <0x400 0x1>;
> > +                };
> > +            };
> > +        };
> > +    };
> > +
> > +    &addon_connector {
> > +        nvmem-cells =3D <&addon_model_id>;
> > +        nvmem-cell-names =3D "id";
> > +    }; =20
>=20
> It's kind of sad that an addon board has an eeprom to identify it, but=20
> it's not itself discoverable...

Not sure I got what you mean exactly here, sorry.

The add-on board is discoverable in the sense that it has a GPIO
(actually two) to be notified of plug/unplug, and it has a way to
describe itself by reading a model ID. Conceptually this is what HDMI
monitors do: an HPD pin and an EEPROM at a fixed address with data at
fixed locations.

If you mean the addon_connector node might be avoided, then I kind of
agree, but this seems not what the NVMEM DT representation expects so
I'm not sure removing it would be correct in the first place.

Srinivas, do you have any insights to share about this? The topic is a
device tree overlay that describes a hotplug-removable add-on, and in
particular the EEPROM present on all add-ons to provide the add-on
model ID.

> Do you load the first overlay and then from it decide which=20
> specific overlay to apply?

Exactly.

The first overlay (the example you quoted above) describes enough to
reach the model ID in the EEPROM, and this is identical for all add-on
models. The second add-on is model-specific, there is one for each
model, and the model ID allows to know which one to load.

Luca

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

