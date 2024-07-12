Return-Path: <linux-kernel+bounces-250802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D78D092FCFD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F16F11C23081
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1672E173336;
	Fri, 12 Jul 2024 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dwe/ODxS"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A384172791
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720796096; cv=none; b=Vlmt8BFeZnGGmHBxTSK1n0ROYh0L8i9EkuOGKrYy7mQZAf+b8V8Rt9OKAWI+wB4b8IpjiyuET+ft6xDjvwsDiUDK73pwdeZliMVzXqkAuSeTRthC3ti2OE0UmnTT9TWV/LTPAe+b7oR8pXu0h1J8Qagi8sleb3T5Vx0gdyvEU74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720796096; c=relaxed/simple;
	bh=WDglpmo/fuT9b60jkJXCilxw4M6p9jGli+nqE9TxKz0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LoCUAbMd742xr/H1EJtei+6dBbx6aaeZqrZvCMD8/5hfphL4vfA7wSVqPoKBkS9Z9u6iX5BjyNWqyPzou54mrlEkHFqyxu76AgQBjscHfpqpZYIXsL+jDX4uJerahhgQjDcFhEb6fv0UgPXT032fA9SS3MqZL9cOFC+qpnpI4ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dwe/ODxS; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eeb1ba0468so23368361fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720796093; x=1721400893; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WDglpmo/fuT9b60jkJXCilxw4M6p9jGli+nqE9TxKz0=;
        b=dwe/ODxSoHzs57C2ar+EytAtmV/DwRbrKTn3lVdr1EXQSqbLHVGI6ihfqChwyAPE2b
         nKVGgmwIebc1dz2nimDeb9TbwGEyq4bMdFUbZmkK6kZYoUJL5mckrE/7U5wcLzQqe9/o
         BOe5dOSE8/Xn5w0Bt+PHMF0ZguC8sQJ/XoItHZV9+x3+pzuxPZhVOsy1vjJbiV/ZtCTU
         eHf6ZIyWCaY+hiyCp3MB7M0Y6AJVtFkyLnrY1fqmsD7v2jYlJ43yfZrXopmzZc2Dgw+p
         +3rrm4hgxSj1WC5oyo7yoi2sCRUktEWyp3zPDlL22MYYBzYzuED0G3rdbwVmdUmGsU2U
         6azw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720796093; x=1721400893;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WDglpmo/fuT9b60jkJXCilxw4M6p9jGli+nqE9TxKz0=;
        b=ORBfbHl1L/LEFXdoLdi38vdsLCapTKymZtIcRIJyl4nL0F77pta6+4YR9m+ztK06Tl
         1ab4N9mZmDVv1UXUqK7zU0OIRpYFIutzhH7jZElgPBzxPKydP/nMn4SfDRGv55REkBAN
         rDntW1oxuajRKJbSEsneVrjCkRDAw86QjGykIyU7e0rQmiSnhkiXeaRBJlJXqq/NHKUy
         AmfrJPh/TXkl+HHaiKa8jvrYmrv1IUnbNAgQDTn2mUxQgTfDNSFkzOAqfysqBfEsuRd6
         3XgU/r9wZs6onpIleSzjUsnDu2z6Zoz7BsLqNjklHm4d+sqMnLs2ZXsHzXcjJhtAphui
         F6pA==
X-Forwarded-Encrypted: i=1; AJvYcCUvbWnewcbQtqjNLnU3j2j9dRxElszHq8dUwJBo9fXvYZVtROVLwk7p2GH/hn6iSaoJHGH2Q7RfLvCJ9OfMktqaW0RNlF9XlSMdf0gd
X-Gm-Message-State: AOJu0YzvCKv7BBDTZVLg5SDJyhTv/fap8BZycjIWGG9wBOcEVj6k6aqV
	VAJsx8zPJ/RavNQMUklM68FqllWoyW+tdZM0FqUL5ipQcDKeVCARBiPxKlWqdCs=
X-Google-Smtp-Source: AGHT+IHvPxH1nBAWvxsjHSCNyZ9t61rhyU1cxyB6YJQEzy0OWWC+/dfZi6vmuDEorYBOF0SyCrzU7w==
X-Received: by 2002:a2e:3c16:0:b0:2ec:4d48:75f3 with SMTP id 38308e7fff4ca-2eeb3198617mr74112911fa.45.1720796091727;
        Fri, 12 Jul 2024 07:54:51 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde8491dsm10421734f8f.45.2024.07.12.07.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:54:51 -0700 (PDT)
Message-ID: <58e355454db3670157645c0b6e727d8058ef0324.camel@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: serial: samsung: fix maxItems for
 gs101 & document earlycon requirements
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi
 <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, Michael
 Turquette <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>, Sam
 Protsenko <semen.protsenko@linaro.org>, Tudor Ambarus
 <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
 kernel-team@android.com, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org
Date: Fri, 12 Jul 2024 15:54:50 +0100
In-Reply-To: <20240711212359.GA3023490-robh@kernel.org>
References: 
	<20240710-gs101-non-essential-clocks-2-v3-0-5dcb8d040d1c@linaro.org>
	 <20240710-gs101-non-essential-clocks-2-v3-1-5dcb8d040d1c@linaro.org>
	 <CAL_JsqLsZAEx-c_12RPcR+HCjPcA_d12oKgZ7frX2Wo47sGTnA@mail.gmail.com>
	 <e2f4a37e7c31d26449125a6265239c88162a1085.camel@linaro.org>
	 <20240711212359.GA3023490-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Rob,

On Thu, 2024-07-11 at 15:23 -0600, Rob Herring wrote:
> On Thu, Jul 11, 2024 at 05:09:50PM +0100, Andr=C3=A9 Draszik wrote:
> > Hi Rob,
> >=20
> > On Thu, 2024-07-11 at 09:51 -0600, Rob Herring wrote:
> > > On Wed, Jul 10, 2024 at 7:29=E2=80=AFAM Andr=C3=A9 Draszik <andre.dra=
szik@linaro.org> wrote:
> > > > --- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> > > > +++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> > > > @@ -145,6 +145,20 @@ allOf:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - samsung,uart-fif=
osize
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg-io-width: fals=
e
> > >=20
> > > blank line between properties
> >=20
> > Do mean before clocks: below and before clock-names: below?=20
>=20
> Yes.
>=20
> > We don't do that normally,
> > at least none of the bindings I looked at do that. Or did I misundersta=
nd?
>=20
> That style is pretty universal. If in doubt, look at example-schema.yaml=
=20
> for best practices. The exception is only for cases like this:
>=20
> =C2=A0 foo: true
> =C2=A0 bar: true

example-schema.yaml doesn't have an example for that, so I suspect that's w=
hy
many (Samsung?) bindings ended up without the blank line. I have fixed it f=
or
this schema in the next version in
https://lore.kernel.org/all/20240712-gs101-uart-binding-v4-1-24e9f8d4bdcb@l=
inaro.org/

> > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 2
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-names:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 - const: uart
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 - const: clk_uart_baud0
> > >=20
> > > Which clock is pclk and ipclk?
> >=20
> > uart is pclk, clk_uart_baud0 is ipclk.
> >=20
> > > 'baud' would be sufficient for the
> > > name. 'clk_' and 'uart' are redundant because it's all clocks and the=
y
> > > are all for the uart.
> >=20
> > TBH, this patch is just following the existing style & names as already=
 exist for
> > various other SoCs in this same file. Furthermore, up until this patch =
the default
> > from this file applies, which is:
> >=20
> > =C2=A0 clock-names:
> > =C2=A0=C2=A0=C2=A0 description: N =3D 0 is allowed for SoCs without int=
ernal baud clock mux.
> > =C2=A0=C2=A0=C2=A0 minItems: 2
> > =C2=A0=C2=A0=C2=A0 items:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: uart
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - pattern: '^clk_uart_baud[0-3]$'
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - pattern: '^clk_uart_baud[0-3]$'
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - pattern: '^clk_uart_baud[0-3]$'
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - pattern: '^clk_uart_baud[0-3]$'
>=20
> Then don't duplicate it. Ideally, the names are defined at the top level=
=20
> and the conditional schema just limits the number of clocks, and this is=
=20
> an example of why we want it that way. I have no context to see if this=
=20
> is consistent or not.

I've fixed it in https://lore.kernel.org/all/20240712-gs101-uart-binding-v4=
-1-24e9f8d4bdcb@linaro.org/

Hopefully you'll that's more acceptable :-)

Cheers,
Andre'


