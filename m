Return-Path: <linux-kernel+bounces-331325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BBD97AB55
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88FBE1F219F7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 06:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB9D60DCF;
	Tue, 17 Sep 2024 06:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IK71HTX/"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382E7A923
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 06:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726553839; cv=none; b=h5+gSVAy1pho0dix+B0m4W0ae6x4ThVaKmYbms13UzLsoTIIolpG4iIjNodtIDFLh8nL+ntR1Hg3DJdeI9F9J3zanrIJ7kN6JIN1SkZwDMc8VJ7uUo9yl/4xUrDBB2S4mSzjt1mqQJealbVbbXrx8+KGrcw+NZIVdK9dE7Y/e5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726553839; c=relaxed/simple;
	bh=41zBckapI1zdY0Ufgs6fzvKQKJoH4GLXK0RGx/E1nSI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sd23XGMrEzD7XFMNQ8+QA7IZp/TLXJUQeqdSER2bionQm01BPETYvVDyLQoGUzdt7qq4uvG1sI1UjkF2OBIXTMkcQEaeXjUAOxyj86KsbVxTUndDRjmVxWaraPIysa7cDHQC6OzHfpLVlhvKR/Z25twl+9JvAshSwq1zsRT+6zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IK71HTX/; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8ce5db8668so915939266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 23:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726553835; x=1727158635; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=41zBckapI1zdY0Ufgs6fzvKQKJoH4GLXK0RGx/E1nSI=;
        b=IK71HTX/ETfzMD/Khp3sXz1FXbf8zROxe87wQ6jGqxvbWkehCUj/neILVRbBKrVG/p
         QS1qXmr5vj7N530PTwozmy+FkL1M6tTQyhiVswsJ8XlVA32VmJsJEbEbVLxi6XHtggel
         SqIEXa4MHLPo8z6mzBY8Pqz1qXaYl7xLK2geknx0TDO0T8REJp0Jmg95q1Tx2Yqp3pSv
         05nbnD5iaXZasj10smxGKeHEOLoT6WSZTgf9iTr898KbgdHwZDHXFjQ09PGuko1eXPjR
         H8IgcYxZ24SpqCkPt496JO1ORQl5gTBXlQ2MTuFgeP1Yuk1rUAhK0UWDShrdZigmChdw
         paMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726553835; x=1727158635;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=41zBckapI1zdY0Ufgs6fzvKQKJoH4GLXK0RGx/E1nSI=;
        b=fY+xEfpLL2vDJDD+aZIWE2vLmz1f5vgu3/93jS1fxvfbD5G2Qqm50Cko6scJz9ns62
         Lth+E9eIIVJlu7pnHuaC+U2c54ZVojDINeBEud6lczAbmfu/gbygh4NiIQC9H1BmRTKo
         qPaU31O1p1QNO8VSjisCmBCi0FlPZ+EjfiyycwSWy+d5OA8YiElLLnVWmv6uRmx9x6yX
         UTZTrMJNC52klj+z5E2jYsvZEgmv1SyR/JMPreBQSNxy+Dbk8PncL2bYCuQlLu+be/Mx
         4YMCARiLpwZrkxHsDJn2f0sPJjcda4gSLzNM5OomtQsfeA4PfF+yhkEmOYUsgjEt3nX4
         ePrg==
X-Forwarded-Encrypted: i=1; AJvYcCWSKegL6zF5B6Z/9qg5dbL4RQc0plo1o2hY6QcVJQE6PJeHcrimXft0SY/zaCZ0V43otympnBA19F8TTqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9hujkyxY/XpHvn2UCaklfLQYnU0LWX5OCx0DEsiwbr8DswjfW
	d9kpH9HDZIDAqtFDCbYhbxvbsg+igth+Qsuvkh0tv/kPle5k3GnpgxoUjfm1c98=
X-Google-Smtp-Source: AGHT+IHF5hl3cT2PzdmSFXZrndgFb+M9Uh7OKs+GmXCHcgWfjlIIAOiT2Fo8vLdRF0d7sH0DbpoGDA==
X-Received: by 2002:a17:906:fe47:b0:a86:a41c:29b with SMTP id a640c23a62f3a-a90293c50d9mr1987242066b.8.1726553834998;
        Mon, 16 Sep 2024 23:17:14 -0700 (PDT)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90613338f4sm401183366b.216.2024.09.16.23.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 23:17:13 -0700 (PDT)
Message-ID: <a4c36c387557ffc1690c30a666a607f2fc19dbc2.camel@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: regulator: add max20339 binding
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>,  Mark Brown <broonie@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>, Michael Walle <mwalle@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus
	 <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Date: Tue, 17 Sep 2024 07:17:12 +0100
In-Reply-To: <90c9f1a8-fcfb-49f5-803e-cb0ec14463cb@kernel.org>
References: <20240916-max20339-v1-0-b04ce8e8c471@linaro.org>
	 <20240916-max20339-v1-1-b04ce8e8c471@linaro.org>
	 <90c9f1a8-fcfb-49f5-803e-cb0ec14463cb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Krzysztof,

On Mon, 2024-09-16 at 21:56 +0200, Krzysztof Kozlowski wrote:
> On 16/09/2024 18:48, Andr=C3=A9 Draszik wrote:
> > Add device tree binding for Maxim MAX20339 overvoltage protector with
> > load switches.
>=20
> Subject:
> regulator: dt-bindings:
>=20
> See submitting patches.

OK

> > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > ---
> > =C2=A0.../bindings/regulator/maxim,max20339.yaml=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 171 +++++++++++++++++++++
> > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +
> > =C2=A02 files changed, 177 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/regulator/maxim,max20339=
.yaml
> > b/Documentation/devicetree/bindings/regulator/maxim,max20339.yaml
> > new file mode 100644
> > index 000000000000..ef6490cf5a6b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/regulator/maxim,max20339.yaml
> > @@ -0,0 +1,171 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/regulator/maxim,max20339.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Maxim Integrated MAX20339 overvoltage protector with load switc=
hes
> > +
> > +maintainers:
> > +=C2=A0 - Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > +
> > +description: |
>=20
> Do not need '|' unless you need to preserve formatting.

Will drop.

> > +=C2=A0 The MAX20339 is an overvoltage protection (OVP) device with int=
egrated load
> > +=C2=A0 switches and ESD Protection for USB Type-C applications. It pro=
tects low
> > +=C2=A0 voltage systems against voltage faults and surges. It also inte=
grates two
> > +=C2=A0 load switches with current limiting, configurable by hard- and =
software.
> > +
> > +properties:
> > +=C2=A0 compatible:
> > +=C2=A0=C2=A0=C2=A0 enum:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - maxim,max20339
> > +
> > +=C2=A0 dig-supply:
> > +=C2=A0=C2=A0=C2=A0 description:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Input supply for the device itself (DIG=
 pin, 1.7V to 1.9V). In absence of
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Vdig, the IN pin will power the device.
> > +
> > +=C2=A0 gpio:
> > +=C2=A0=C2=A0=C2=A0 type: object
> > +
> > +=C2=A0=C2=A0=C2=A0 properties:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "#gpio-cells":
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const: 2
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpio-controller: true
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpio-line-names:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: Strings descri=
bing the names of each gpio line.
>=20
> Drop description.

OK.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0=C2=A0=C2=A0 required:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - "#gpio-cells"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - gpio-controller
> > +
> > +=C2=A0=C2=A0=C2=A0 additionalProperties: false
>=20
> Does any existing driver require this to be separate node? I don't see
> here any resources, so these properties should be in main device node.

OK. There was no specific reason, other than visual separation, and easier
'required' handling; will update.

> > +
> > +=C2=A0 insw-supply:
> > +=C2=A0=C2=A0=C2=A0 description:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Input supply for the outputs (IN pin, 3=
.9V to 28.0V). Also used as supply
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for the device itself in case dig-suppl=
y is not wired up.
> > +
> > +=C2=A0 interrupts:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0 lsw1-supply:
> > +=C2=A0=C2=A0=C2=A0 description: Input supply for the outputs (LSW1IN p=
in, 4.0V to 10.0V)
> > +
> > +=C2=A0 lsw2-supply:
> > +=C2=A0=C2=A0=C2=A0 description: Input supply for the outputs (LSW2IN p=
in, 4.0V to 10.0V)
> > +
> > +=C2=A0 reg:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0 regulators:
> > +=C2=A0=C2=A0=C2=A0 type: object
> > +
> > +=C2=A0=C2=A0=C2=A0 properties:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 insw:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type: object
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ref: regulator.yaml#
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: Represents the=
 switch connecting IN to OUT, INSW.
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator-ov-pr=
otection-microvolt:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enu=
m: [5850000, 9700000, 14500000]
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unevaluatedProperties: fals=
e
> > +
> > +=C2=A0=C2=A0=C2=A0 patternProperties:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "^lsw[12]$":
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type: object
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ref: regulator.yaml#
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: Represents the=
 load switches LSW1 and LSW2.
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator-ov-pr=
otection-microvolt:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enu=
m: [0, 1]
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shunt-resistor-=
micro-ohms:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 des=
cription:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Value in micro Ohm of the resistor connected between the SETx
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 pin and GND. This value is required to be able to calculate and
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 program the current limiting threshold register.
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 required:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - shunt-resisto=
r-micro-ohms
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unevaluatedProperties: fals=
e
> > +
> > +=C2=A0=C2=A0=C2=A0 required:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - lsw1
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - lsw2
> > +
> > +=C2=A0=C2=A0=C2=A0 additionalProperties: false
> > +
> > +anyOf:
> > +=C2=A0 - oneOf:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - required:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - dig-supply
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - required:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - insw-supply
> > +=C2=A0 - required:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - dig-supply
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - insw-supply
>=20
> oneOf looks redundant here. you allow any combination, right?

You're right, and yes, I allow either dig-supply, or insw-supply, or both,
and at least one of them must be specified.

Thanks,
Andre'

> > +
> > +required:
> > +=C2=A0 - compatible
> > +=C2=A0 - reg
> > +=C2=A0 - regulators
>=20
>=20
> Best regards,
> Krzysztof
>=20


