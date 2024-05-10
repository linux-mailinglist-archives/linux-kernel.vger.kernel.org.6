Return-Path: <linux-kernel+bounces-175912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF208C270D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9992B23E08
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697B71708B5;
	Fri, 10 May 2024 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XDQsiUrF"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0092E12C526;
	Fri, 10 May 2024 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715352006; cv=none; b=FE3M2/V+5krgO18rHwSnODjbO5Nxxy+ppBxzG+vciubB+kqNtjzhZGA1XUYFUU4nYBXNWhEK74YnQAHH0BXeVMaDcRAgXdGAnKoJl74RwI3TH5pBwiZIuloJ+mZ466t+GcC/joq4JK8081Bj8G02SS+2x+UwvDMHgfA/yHGx0+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715352006; c=relaxed/simple;
	bh=7PvafIFPj4pefeXLWZ2W/aZ/FA/ODCICCZ5HhbwXLIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M677Jlo7tN5rI16CY5NQ5dEAE9HFubENtP2W9WfgB4aN9SffdH2gR5zdU5pAec9m9rmuSbUzhc1SWHbC4aViyziZUtMU/dsTig18ahn6Fy7+MSi/voq1TDeSxt8JR/oV4cFh6EOpyU1NkrUdb7zhntYUqQrEoPuInR9Vh2I1ncU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XDQsiUrF; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E4064FF802;
	Fri, 10 May 2024 14:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715351995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+nU+cv0q1WloDIweY2B89rAwtbFBH/RqHcw3iJ3zTk=;
	b=XDQsiUrF6t6akEGF/z9RwiSoxCjD1Li48g0UfH+o4nEZKozMhwN6If3xDm0x7YstbP2Wgq
	dzsedvzzGAhaxjq0ZmF8gijW5sMTk0onpg1sgTHKHB/hSMNy0nGwtSr82pO3WQuerJUFqQ
	ZrbowCsVngaY/RCxd5AlXI/0OhOw/eHH2btD7LutjPNzlV/BA7W1JoEN20UtQuVf0dZJSZ
	kAV0YmYOQeSq4CiYz8GQaC6MYrqTr7M0rBqlKB6R9Yc7oMqn37PJTns4Da9P8iCimVjgUi
	6v7CSPIgDg4QdXoqOu+Ul5wsP7GmBvdfEmKI67hVirLqf3tComObMiIKfvmCDg==
Date: Fri, 10 May 2024 16:39:51 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Maxime Ripard <mripard@kernel.org>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Paul Kocialkowski
 <paul.kocialkowski@bootlin.com>, Robert Foss <rfoss@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9?= Codina <herve.codina@bootlin.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Derek Kiernan
 <derek.kiernan@amd.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Saravana Kannan <saravanak@google.com>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Paul Kocialkowski
 <contact@paulk.fr>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>, Jonas
 Karlman <jonas@kwiboo.se>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: connector: add GE SUNH hotplug
 addon connector
Message-ID: <20240510163951.37817e41@booty>
In-Reply-To: <CAL_Jsq+mZLkq16OcVBcspxLrMZ=M+h57yOQohhsgn3VXVfyiLQ@mail.gmail.com>
References: <20240510-hotplug-drm-bridge-v2-0-ec32f2c66d56@bootlin.com>
	<20240510-hotplug-drm-bridge-v2-1-ec32f2c66d56@bootlin.com>
	<171533049583.3304069.11759668175103213313.robh@kernel.org>
	<20240510123717.437ffe6e@booty>
	<CAL_Jsq+mZLkq16OcVBcspxLrMZ=M+h57yOQohhsgn3VXVfyiLQ@mail.gmail.com>
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

On Fri, 10 May 2024 08:22:53 -0500
Rob Herring <robh@kernel.org> wrote:

> On Fri, May 10, 2024 at 5:37=E2=80=AFAM Luca Ceresoli <luca.ceresoli@boot=
lin.com> wrote:
> >
> > Hello Rob,
> >
> > On Fri, 10 May 2024 03:41:35 -0500
> > "Rob Herring (Arm)" <robh@kernel.org> wrote:
> > =20
> > > On Fri, 10 May 2024 09:10:37 +0200, Luca Ceresoli wrote: =20
> > > > Add bindings for the GE SUNH add-on connector. This is a physical,
> > > > hot-pluggable connector that allows to attach and detach at runtime=
 an
> > > > add-on adding peripherals on non-discoverable busses.
> > > >
> > > > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > > >
> > > > ---
> > > >
> > > > NOTE: the second and third examples fail 'make dt_binding_check' be=
cause
> > > >       they are example of DT overlay code -- I'm not aware of a way=
 to
> > > >       validate overlay examples as of now =20
> >
> > As mentioned here...
> > =20
> > > >
> > > > This patch is new in v2.
> > > > ---
> > > >  .../connector/ge,sunh-addon-connector.yaml         | 197 +++++++++=
++++++++++++
> > > >  MAINTAINERS                                        |   5 +
> > > >  2 files changed, 202 insertions(+)
> > > > =20
> > >
> > > My bot found errors running 'make dt_binding_check' on your patch:
> > >
> > > yamllint warnings/errors:
> > >
> > > dtschema/dtc warnings/errors:
> > > Error: Documentation/devicetree/bindings/connector/ge,sunh-addon-conn=
ector.example.dts:49.9-14 syntax error
> > > FATAL ERROR: Unable to parse input tree =20
> >
> > ...this is expected.
> >
> > Any hints on how this can be managed in bindings examples would be very
> > useful. =20
>=20
> Overlays in examples are not supported. Add actual .dtso files if you
> want examples of overlays (maybe you did, shrug).
>=20
> Overlays are somewhat orthogonal to bindings. Bindings define the ABI.
> It only makes sense to validate applied overlays. Now maybe overlays
> contain complete nodes and we could validate those, but that's a
> problem for actual overlay files and not something we need to
> complicate examples with.

Many thanks for the insights.

The reason I added overlays in the bindings examples is that this
specific device calls for overlays by its very nature. And in fact the
implementation is based on overlays.

However I understand the reasons for not having overlays in examples. I
think I can just remove the two examples and mention the nvmem-cells
and nvmem-cell-names nodes as regular properties, and explain in their
descriptions that these are supposed to be loaded via overlays. Quick
draft:

properties:
  nvmem-cell-names:
    items:
      - const: speed-bin

  nvmem-cells:
    maxItems: 1
    description:
      NVMEM cell containing the add-on model ID for the add-on that is
      inserted. Multiple add-on models can be connected, and in order
      to find out the exact model connected all of them have an EEPROM
      at the same I2C bus and address with an ID at the same offset. By
      its nature, this and the nvmem-cell-names nodes are supposed to be
      added by an overlay once ad add-on is detected. So they must not
      be present in the initial device tree, and they must be added by
      an overlay before the add-on can be used.

Looks reasonable?

Best regards,
Luca

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

