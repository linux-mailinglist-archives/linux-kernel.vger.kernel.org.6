Return-Path: <linux-kernel+bounces-169928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 591318BCF76
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD091F21A0F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E9080046;
	Mon,  6 May 2024 13:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mauWTkRJ"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD6080026;
	Mon,  6 May 2024 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715003346; cv=none; b=k35EVLpPAIKsaj8hVbZdiLL1B9z4fSskSZwgc69MGTDBiXrgcILBHxH1rtG+nwQy1btCRf4QJGOVtjkLz2/SqlM4F4EUTVRPqXryc8Icr3TCQZVw4QfiZP4RTJay37XVzQov+sgU/NkAS+iJpfltC+vSsDbfFx/eUXu6sSn6LxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715003346; c=relaxed/simple;
	bh=N+8SlHv+BG10Ed56ABIsCFuAhTqmY99V5r9tlcdPXOk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dTyHKyOeCaFWunj+1w+GVbf46mkQZq31vVHU3D747r5jW2AA/HN/G/62mZ8WCM588haleyNwbQOviklhZW31leK8307GhFnSlwqtq8i1XbvsdedsynGtMX3+OCp9nbD+lGTlfbtqAk0rgUW5+ueQdd7JaImAL8H7Om7kuV4gt0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mauWTkRJ; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E3A7F1BF20E;
	Mon,  6 May 2024 13:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715003341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IiYk/OF8J/A5XkO49NEeG0JReklIrIL4u4kDqBfVQe0=;
	b=mauWTkRJEwC2lvjJlXWeuOXCeuQOgxLTQoZe+3vo06UVOGbnAcLbx+bNbmOKRWY6N/2LMh
	ZDPxv8XA2VsvMlJhgiYmdv0114okHcldvzL+KSx6iGlunRr5ydNL7c1Mq0g087+atQRTLh
	Fcxkxsn0rh1VeFRBkpGPfu7kOn8og+qC/lMfPl6ICDW6CAsuZmoH0jM9hFYKEDUbm7LxvN
	r/+W7vfKhw7rXY92GmeNbGyQxRdUAINnUkE2S2ksf/xbJYBm/OOO6MkCinkF6tem/bUGTb
	tYehaTyf0yxIyTjRNJDaA02iiBlYKZzDvBhnU+bDdBPdzk4dlsD1AkVCAv+VZA==
Date: Mon, 6 May 2024 15:48:58 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman
 <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,
 <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <oxffffaa@gmail.com>, <kernel@sberdevices.ru>
Subject: Re: [PATCH v5 1/2] dt-bindings: mtd: amlogic,meson-nand: support
 fields for boot ROM code
Message-ID: <20240506154858.003bab54@xps-13>
In-Reply-To: <20240416085101.740458-2-avkrasnov@salutedevices.com>
References: <20240416085101.740458-1-avkrasnov@salutedevices.com>
	<20240416085101.740458-2-avkrasnov@salutedevices.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Arseniy,

avkrasnov@salutedevices.com wrote on Tue, 16 Apr 2024 11:51:00 +0300:

> Boot ROM code on Meson requires that some pages on NAND must be written
> in special mode: "short" ECC mode where each block is 384 bytes and
> scrambling mode is on.

Ok

> Such pages located with the specified interval within specified offset.

I'm sorry I don't get that sentence.

> Both interval and offset are located in the
> device tree and used by driver if 'nand-is-boot-medium' is set for
> NAND chip.

This sentence is probably not needed.

>=20
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  .../bindings/mtd/amlogic,meson-nand.yaml           | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yam=
l b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> index 57b6957c8415..67b2f7c1259c 100644
> --- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> @@ -64,11 +64,25 @@ patternProperties:
>          items:
>            maximum: 0
> =20
> +      amlogic,boot-pages:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Number of pages starting from 0, where special ECC

from *offset* 0 I guess?

> +          algorithm will be used by the driver.

"where a special ECC configuration must be used because it is accessed
by the ROM code"? Maybe you can even detail what are these values if
they are fixed.

You should probably inform that scrambling shall be on as well.
=20
> +
> +      amlogic,boot-page-step:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Interval between pages, read/written by the driver with
> +          special ECC algorithm.

I'm not sure I fully get the description. What is the unit here? can
you draw a small ascii-art diagram?

> +
>      unevaluatedProperties: false
> =20
>      dependencies:
>        nand-ecc-strength: [nand-ecc-step-size]
>        nand-ecc-step-size: [nand-ecc-strength]
> +      amlogic,boot-pages: [nand-is-boot-medium, "amlogic,boot-page-step"]
> +      amlogic,boot-page-step: [nand-is-boot-medium, "amlogic,boot-pages"]
> =20
> =20
>  required:


Thanks,
Miqu=C3=A8l

