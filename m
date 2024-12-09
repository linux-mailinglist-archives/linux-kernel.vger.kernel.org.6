Return-Path: <linux-kernel+bounces-438115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 450FD9E9D0E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F04D163A9F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CAA154BFC;
	Mon,  9 Dec 2024 17:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JyWXcDkb"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DA3153BFC;
	Mon,  9 Dec 2024 17:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733765249; cv=none; b=m9s2EYSP4zNAh3DYmKC+cubkxDYpjaD3q40hEDSPgWL0W+j2eTexdL/NrQ4R17+FFzEz8iVwllSLcR6Dwy+Qz1u8b//6cql23+gwxBXqcNi8mxfJX59GRkvnZGLqnhkJEIvcARLIsAMx1GMX++i3OKu9pin4TZoYg8bNwH/sklY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733765249; c=relaxed/simple;
	bh=St0uqfcpmdji8WcvArFAHVikFPwGRX19imL3bBLhOa4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k9EkoGT9HBMmMWs/94ylkByPk+cvqo6eQSllHkBKT5HL+YUDbDsTgxi2UrXsIimfGSwWI+pxenl9G9tk2CdR6H7x9EzqHUCVertjZaVSJvPqbY6V+lzj+9CzFkXoph8vFGkRh9ZjArOnFSs7osl5vQckZkBXEOTCZViaUj6EN9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JyWXcDkb; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1457C20002;
	Mon,  9 Dec 2024 17:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733765245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PrxbG+h4OOZqHNO6Sq1UiuElNh+yNP69221qAXKz+OQ=;
	b=JyWXcDkbSkhy3qFWt8WQSnge4gZ+4wJjb+GI0RY9k4g9/KnQp0pa+DLr3i9F3brwNVFVKJ
	71280VN1jHbR9HNp5ayIGRWm7QVagX1ziBbwthbrhkCSXfH4ZcoAtVzzbPpUz/eriSRlDH
	qfUmMx716r/1Pl9+jUe6UjvxMfDb7QS8RxsC4vU2aZrH+VtL2KbEDcqSZRjKN8YmtC+q7T
	Jfto1WFzH7VT3G0BcrU/1ZGO1tgE02+1uo9G7v4wF2Zgm9g4P6cCRJf16wdOQ/mnj7UmzW
	YRFvm/8SiG7ImijmX06RbdmbfNKyHlm1v2ULPUBNAHCvxl/lWcm688sYGt+RgQ==
Date: Mon, 9 Dec 2024 18:27:22 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Davis <afd@ti.com>, Ayush Singh <ayush@beagleboard.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Saravana Kannan <saravanak@google.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/7] dt-bindings: Add support for export-symbols node
Message-ID: <20241209182722.2dd15f7a@booty>
In-Reply-To: <20241209151830.95723-2-herve.codina@bootlin.com>
References: <20241209151830.95723-1-herve.codina@bootlin.com>
	<20241209151830.95723-2-herve.codina@bootlin.com>
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

Hi Herv=C3=A9,

On Mon,  9 Dec 2024 16:18:19 +0100
Herve Codina <herve.codina@bootlin.com> wrote:

> An export-symbols node allows to export symbols for symbols resolution
> performed when applying a device tree overlay.
>=20
> When a device tree overlay is applied on a node having an export-symbols
> node, symbols listed in the export-symbols node are used to resolve
> undefined symbols referenced from the overlay.
>=20
> This allows:
>   - Referencing symbols from an device tree overlay without the need to
>     know the full base board. Only the connector definition is needed.
>=20
>   - Using the exact same overlay on several connectors available on a giv=
en
>     board.
>=20
> For instance, the following description is supported with the
> export-symbols node:
>  - Base device tree board A:
>     ...
>     foo_connector: connector1 {
>         export-symbols {
>            connector =3D <&foo_connector>;
>         };
>     };
>=20
>     bar_connector: connector2 {
>         export-symbols {
>            connector =3D <&bar_connector>;
>         };
>     };
>     ...
>=20
>  - Base device tree board B:
>     ...
>     front_connector: addon-connector {
>         export-symbols {
>            connector =3D <&front_connector>;
>         };
>     };
>     ...
>=20
>  - Overlay describing an addon board the can be connected on connectors:
>     ...
>     node {
>         ...
>         connector =3D <&connector>;
>         ...
>     };
>     ...
>=20
> Thanks to the export-symbols node, the overlay can be applied on
> connector1 or connector2 available on board A but also on
> addon-connector available on board B.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../devicetree/bindings/export-symbols.yaml   | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/export-symbols.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/export-symbols.yaml b/Docu=
mentation/devicetree/bindings/export-symbols.yaml
> new file mode 100644
> index 000000000000..0e404eff8937
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/export-symbols.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/export-symbols.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Export symbols
> +
> +maintainers:
> +  - Herve Codina <herve.codina@bootlin.com>
> +
> +description: |
> +  An export-symbols node allows to export symbols for symbols resolution
> +  performed when applying a device tree overlay.
> +
> +  When a device tree overlay is applied on a node having an export-symbo=
ls
> +  node, symbols listed in the export-symbols node are used to resolve un=
defined
> +  symbols referenced from the overlay.
> +
> +properties:
> +  $nodename:
> +    const: export-symbols
> +
> +patternProperties:
> +  "^[a-zA-Z_]?[a-zA-Z0-9_]*$":

I think the '?' should not be there: "^[a-zA-Z_][a-zA-Z0-9_]*$".

Otherwise LGTM.

Luca

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

