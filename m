Return-Path: <linux-kernel+bounces-247126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D0292CB8E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F421F2347E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B797480BF8;
	Wed, 10 Jul 2024 07:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="EOU/33GD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="baMM5hTK"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED518522E;
	Wed, 10 Jul 2024 07:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720594970; cv=none; b=Plual1z1cEBBvW5XD8X89SC1cIV+cGaIO0084yeEvGcjNw+uynF7vnsZd17DzbqxP1n3mWsK13y2enA8Cj5hF0LpncfHy8e4jFWPQrjrdn4YhWd0YPubABLgyGJpGwDSrLYzRLoOFYJvihPkDJkxBuJfraSUe+hy+cpXvw5rXmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720594970; c=relaxed/simple;
	bh=sJl7Rz+GcER65wxtjYPs/fPGXxgpyGib7ftBsz5718A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r4Tp+gY5vWwvQwmaO07gFuJPge/VuPfyZh1qpdEZ/2Ph2XXoZseja57jcxB51cE4+Fdz67QlHE0/FkOEwXmKDx2EI9K+I51XJJCbMDn5vgIW5a+iwv2dSPmpjnlo73UxpPwBGxsmg4iaD7IqplRSc/x8Mm/VE/bDMqWrgv4apAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=EOU/33GD; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=baMM5hTK reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1720594966; x=1752130966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w75KCVl1Td1dl0039xM1BsGqYrMvcTNH87jh0lAScys=;
  b=EOU/33GD4l/N94zDVdbrzg56eZlYOHi9p6abo/LbQnwr1THn1A09iyz7
   nRIupboBxGxISYE4pWQGbPhttmNPH3pSrh3oEb7tusxL6YYROlyjooMlr
   1eVhhi1Kc5o0FYlOzxUOvw38n03XBSHRD2yjXZMjrDaRnY/0sqYwLOLk9
   fo1UlbuEUdRty62sHy4LofGeBOP1nG07Xfua/mlheZJZpuwASZHSe7YV8
   t9ppN2KR7Va/Tijs54BsAt/WkyNMwcBhPShaIbbhJETxeTgn8rYW4uotv
   y4GfRRIUWUglJkP5CgOcmomOOSxXm87p06FoT41qwQ9IVW1H/vzf3em6Y
   Q==;
X-CSE-ConnectionGUID: 2yIqFFj+QO6gEzYvhSB3Wg==
X-CSE-MsgGUID: atSQGguxQDaJCRTyhvgKTw==
X-IronPort-AV: E=Sophos;i="6.09,197,1716242400"; 
   d="scan'208";a="37830570"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 10 Jul 2024 09:02:37 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 97D90160B01;
	Wed, 10 Jul 2024 09:02:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1720594953;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=w75KCVl1Td1dl0039xM1BsGqYrMvcTNH87jh0lAScys=;
	b=baMM5hTKK9U7Kk5F66IsBtrSnvDEhXUiejxLGjkaw95uST9cvyVdd3IxVt090QStWpibyV
	VJZcGODYCWb/Bx+Lh456quPMQSVTAf5XxJSeSVoGWjSlF+KJ629MalaZPPfEFct9L7NQb6
	pNVqBRZ6Q2WEgrox/ZQF0CBgdrven+rhl6d5JwnAvBllYr7AfNWYcQxIqbFnCZwYCVuMEt
	dWKJCxIng/pTW2Uv+Zn0abkCi/lvVqtLonOOY/16o+ZWGaIRXLEQIhC9+kkN/nqx0tHQdM
	Ku2kz+RQhsyw6j3crdk2XhXf0WcXVINXstho9z3T+Gbg4v1/gbkKRLjyORU0lw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: mturquette@baylibre.com, sboyd@kernel.org, Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, quentin.schulz@cherry.de, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/6] dt-bindings: clocks: add binding for generic clock-generators
Date: Wed, 10 Jul 2024 09:02:34 +0200
Message-ID: <12478313.O9o76ZdvQC@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240709123121.1452394-2-heiko@sntech.de>
References: <20240709123121.1452394-1-heiko@sntech.de> <20240709123121.1452394-2-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hello Heiko,

Am Dienstag, 9. Juli 2024, 14:31:16 CEST schrieb Heiko Stuebner:
> In contrast to fixed clocks that are described as ungateable, boards
> sometimes use additional clock generators for things like PCIe reference
> clocks, that need actual supplies to get enabled and enable-gpios to be
> toggled for them to work.

=46ixed clocks are intended to be ungateable? Where does this come from?

> This adds a binding for such clock generators that are not configurable
> themself, but need to handle supplies for them to work.
>=20
> While in a lot of cases the type of the IC used is described in board
> schematics, in some cases just a generic type description like
> "100MHz, 3.3V" might also be used. The binding therefore allows both
> cases. Specifying the type is of course preferred.
>=20
> The clock-frequency is set in devicetree, because while some clock
> generators have pins to decide between multipls output rates, those
> are generally set statically on the board-layout-level.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../bindings/clock/clock-generator.yaml       | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/clock-generat=
or.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/clock/clock-generator.yaml=
 b/Documentation/devicetree/bindings/clock/clock-generator.yaml
> new file mode 100644
> index 0000000000000..f44e61e414e89
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/clock-generator.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/clock-generator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Simple clock generators
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  $nodename:
> +    anyOf:
> +      - description:
> +          Preferred name is 'clock-<freq>' with <freq> being the output
> +          frequency as defined in the 'clock-frequency' property.
> +        pattern: "^clock-([0-9]+|[a-z0-9-]+)$"
> +      - description: Any name allowed
> +        deprecated: true
> +
> +  compatible:
> +    oneOf:
> +      - const: clock-generator
> +      - items:
> +          - enum:
> +              - diodes,pi6c557-03b
> +              - diodes,pi6c557-05b
> +          - const: clock-generator
> +
> +  "#clock-cells":
> +    const: 0
> +
> +  clock-frequency: true
> +
> +  clock-output-names:
> +    maxItems: 1
> +
> +  enable-gpios:
> +    description:
> +      Contains a single GPIO specifier for the GPIO that enables and dis=
ables
> +      the clock generator.
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: handle of the regulator that provides the supply voltage

So essentially only enable-gpios and vdd-supply is added in comparison to
fixed-clock. Does it make sense to add that to the fixed-clocks instead?
Similar to fixed-regulator.

> +
> +required:
> +  - compatible
> +  - "#clock-cells"
> +  - clock-frequency

With this list it's essentially the same as fixed-clock.

Best regards,
Alexander

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock {
> +      compatible =3D "clock-generator";
> +      #clock-cells =3D <0>;
> +      clock-frequency =3D <1000000000>;
> +    };
> +...
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



