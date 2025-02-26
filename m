Return-Path: <linux-kernel+bounces-534576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D13A468B3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295583ADB0B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C30822FE13;
	Wed, 26 Feb 2025 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QlH9EHuA"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8398522F3B8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592609; cv=none; b=UOR6mWwa6trKm9D2LGNnwstWxt+Qfp77Wwc06JmUgs2V8l03A47/80dPopp1qsHrch9QXAQT16a92bokotza9gpbzPa9GGIwIVd4FPHO0LaAl4h+lLdZOayG1TycSePT7q5Pckpy7yOPaTElKFQKUe2RoXIdG/dqQjDera/ZPNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592609; c=relaxed/simple;
	bh=U8EjsXn8hthZd5WnCdsOmkpAAV6+VKIGUBqWIRaY+iI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l1bRw3osNrbIUaJAQC9vC8BgIPLsA4etVOhSjOWYJeWzyYs+6rAz78rzxPIZWzkqOcQuOyc2wE/pEe0hEzvjFDCTbcKGwTv4dlPbb5/2lSj3KO6FC8dKwt7h2G+vt+CpPBEloZgyt37Xp6b/S/dK6mlJBHyGPAndShqwaAXgObY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QlH9EHuA; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-390d6426f1bso630742f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740592606; x=1741197406; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IQ1ie5P4f3zQ3Bmnzk4jBndSv2upreQmxRiSWOb230I=;
        b=QlH9EHuAuRerdMHTmbjR5b8xrxGgRglOzbY/6+i41QNkpwbb/RRITEgnpl3vOymKVu
         DhCn3Bsd5mdsHGuWbkibasoIah8vs5Q561WoDUVd2WCFH+ofCtLyYCU6JAZy/cKdmvsY
         tG2oXY0OEqety8VFf76JwAAUA6azcRqN6+F4J4u2R3EHFV538GOUo0CM0iDJTEA2eMvz
         d2BtMd4eaZ9ii6qm96E5WpGJsWBQd6FlEpcyZsKkkpFxNgHqYfBNAkDS7TR3jt0aISUI
         ev6qJMCKIzaeO0jNDx3ZLuWnkdEnuQBkim6nZYBxssGlNlRwswBHz5EsQvhVNoYaMZ9K
         3iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740592606; x=1741197406;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IQ1ie5P4f3zQ3Bmnzk4jBndSv2upreQmxRiSWOb230I=;
        b=p2gVtJRk8JVdLF9rpjCUxz9JYDhtfjPx5FPGBVz3Sm4MSOCa2FTcmd6TsCaCvliuQs
         0xxPZhER+IfSHzUUHDp8jk8t0SWR0v1+ZqXihDf7iv49RzaN1zn0TZ91WAr9Vu8Hu6WL
         SNBejTsMQzU8fpXAmpRQ0i1wrO++Bc1R/p7KFRREHWR6m60t9icvK5ouhC7NrtUhjdd3
         aIHBRLOSlFuD8kHQSu2z+KlzU+a1thbxXNJGRX0JdwEqWr2G+D15B0nYe90OyfS0oIc4
         tubPt4ixHU57HJyxuZj1ee2TOx3qkalm1vcy9x//QSj9ov0Eqz7FezdKgfQyA8KzVrwm
         vgJg==
X-Forwarded-Encrypted: i=1; AJvYcCXfrcH17TqE9Ich9h+Gc4NuGD4hScf6CbdIEy2FfuOQFywc+gYevwQ7qmHXzG4Bu626MU8uZflY7pVTzv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfQKxh/ElT2CjwA7Tm2OcsmnMLPHcsnIcQahX4lCOgZTzo6mve
	Ona8C6Rk0tkQmBSUMgVCn+yrL9UGFDd0f+QnA6nkYjVcjf97MSCLDZyn10xERPA=
X-Gm-Gg: ASbGncuP8oFw/eAKeHcSrBkfmY4rmm1FcvDq3bpNVzkSS77cpLuFjBJiH5lYp636JHg
	pqJAtUbR3W4GLbsJK5QcSlXoCryvcAwWg5iVIq+8oY52WK3DQWsVY3PKbjUsXVSEHxcwAdjFz09
	Dg20iEghgogOr/dp+VQbeN7KhW3T40L2g0+N+KR9TR2N8GGNuhr6/mwoCWwbHGABct9t3vQ7sBU
	ASJiQW+q+R3qbP3BBSPXcUm29XaSHf4UFZN6NOwB0P2VsqkX7Z0IdZa7VwqccvGk41iW/L80vr+
	iS5juq3qY4KrUwvjc6zU0ekChKTHTQ==
X-Google-Smtp-Source: AGHT+IEBNkLMPMj9+puIgcT6KXydMqr4dpitTxkeEa4qusNjXwjam9ho838YGBqllbydfQzyijAD/g==
X-Received: by 2002:a5d:64e5:0:b0:38d:e3fd:1990 with SMTP id ffacd0b85a97d-38f6e4b223bmr20340023f8f.0.1740592605805;
        Wed, 26 Feb 2025 09:56:45 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5442c0sm28868475e9.32.2025.02.26.09.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 09:56:45 -0800 (PST)
Message-ID: <5cce915b5a22cff1d538059d79c152b83c99a265.camel@linaro.org>
Subject: Re: [PATCH 1/6] dt-bindings: mfd: add max77759 binding
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski	 <brgl@bgdev.pl>, Srinivas
 Kandagatla <srinivas.kandagatla@linaro.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Peter Griffin	
 <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, Will
 McVicker <willmcvicker@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, 	linux-hardening@vger.kernel.org
Date: Wed, 26 Feb 2025 17:56:44 +0000
In-Reply-To: <865e878e79a4e5c3a7619bedd81cc8bdb00a4914.camel@linaro.org>
References: <20250224-max77759-mfd-v1-0-2bff36f9d055@linaro.org>
		 <20250224-max77759-mfd-v1-1-2bff36f9d055@linaro.org>
		 <20250224153716.GA3137990-robh@kernel.org>
	 <865e878e79a4e5c3a7619bedd81cc8bdb00a4914.camel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-24 at 16:05 +0000, Andr=C3=A9 Draszik wrote:
> Hi Rob,
>=20
> Thanks for the review!
>=20
> On Mon, 2025-02-24 at 09:37 -0600, Rob Herring wrote:
> > On Mon, Feb 24, 2025 at 10:28:49AM +0000, Andr=C3=A9 Draszik wrote:
> > > Add device tree binding for the Maxim MAX77759 companion PMIC for USB
> > > Type-C applications.
> > >=20
> > > The MAX77759 includes Battery Charger, Fuel Gauge, temperature sensor=
s,
> > > USB Type-C Port Controller (TCPC), NVMEM, and a GPIO expander.
> > >=20
> > > This describes the core mfd device.
> > >=20
> > > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > > ---
> > > =C2=A0.../devicetree/bindings/mfd/maxim,max77759.yaml=C2=A0=C2=A0=C2=
=A0 | 104 +++++++++++++++++++++
> > > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 ++
> > > =C2=A02 files changed, 110 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77759.yam=
l
> > > b/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml
> > > new file mode 100644
> > > index 000000000000..1efb841289fb
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml
> > > @@ -0,0 +1,104 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/mfd/maxim,max77759.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Maxim Integrated MAX77759 PMIC for USB Type-C applications
> > > +
> > > +maintainers:
> > > +=C2=A0 - Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > > +
> > > +description: |
> > > +=C2=A0 This is a part of device tree bindings for the MAX77759 compa=
nion Power
> > > +=C2=A0 Management IC for USB Type-C applications.
> > > +
> > > +=C2=A0 The MAX77759 includes Battery Charger, Fuel Gauge, temperatur=
e sensors, USB
> > > +=C2=A0 Type-C Port Controller (TCPC), NVMEM, and a GPIO expander.
> > > +
> > > +properties:
> > > +=C2=A0 compatible:
> > > +=C2=A0=C2=A0=C2=A0 const: maxim,max77759
> > > +
> > > +=C2=A0 interrupts:
> > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > +
> > > +=C2=A0 interrupt-controller: true
> > > +
> > > +=C2=A0 "#interrupt-cells":
> > > +=C2=A0=C2=A0=C2=A0 const: 2
> > > +
> > > +=C2=A0 gpio-controller: true
> > > +
> > > +=C2=A0 "#gpio-cells":
> > > +=C2=A0=C2=A0=C2=A0 const: 2
> > > +
> > > +=C2=A0 gpio:
> > > +=C2=A0=C2=A0=C2=A0 $ref: /schemas/gpio/maxim,max77759-gpio.yaml
> > > +
> > > +=C2=A0 reg:
> > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > +
> > > +=C2=A0 pmic-nvmem:
> >=20
> > Just 'nvmem'
>=20
> TBH, I'd prefer that as well, and I had just 'nvmem' initially,
> but that doesn't work:
>=20
> .../maxim,max77759.example.dtb: pmic@66: nvmem: {'compatible': ['maxim,ma=
x77759-nvmem'], 'nvmem-layout': {'compatible': ['fixed-
> layout'], '#address-cells': 1, '#size-cells': 1, 'reboot-mode@0': {'reg':=
 [[0, 4]]}, 'boot-reason@4': {'reg': [[4, 4]]},
> 'shutdown-user-flag@8': {'reg': [[8, 1]]}, 'rsoc@10': {'reg': [[10, 2]]}}=
} is not of type 'array'
> 	from schema $id: http://devicetree.org/schemas/nvmem/nvmem-consumer.yaml=
#
>=20
> I don't know if this can be made to work, i.e. can you have both
> in yaml? Can a type be declared as a oneOf or something like that?

I wasn't able to get this to work with a node name of just
'nvmem'.

If anybody has any suggestions, I'll gladly try them.

I've renamed the node from pmic-nvmem to nvmem-0 in v2, though.

https://lore.kernel.org/all/20250226-max77759-mfd-v2-3-a65ebe2bc0a9@linaro.=
org/

Cheers,
Andre


