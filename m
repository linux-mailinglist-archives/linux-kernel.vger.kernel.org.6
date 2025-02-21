Return-Path: <linux-kernel+bounces-526645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D420A40184
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6462864628
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC51254B17;
	Fri, 21 Feb 2025 20:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=denx.de header.i=@denx.de header.b="XaWOyyQC"
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136FD253F00;
	Fri, 21 Feb 2025 20:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171427; cv=none; b=ew18Ulu/+13SQ39BnRdRzkiqqLpcUJnaQ1lalA2MGNkAT+KMEAkrXRhUfJ/aCc2s5qGacZbLHxGKF4tHUzSgCPzdJZ+pnQ/X9nFUSbGtZzgHU2RTc5n40rteaKSLQ/s15K3dWuaPy0hknfD5Q64XeN4xd0fdJYtwMMVuEsB9paI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171427; c=relaxed/simple;
	bh=kOHyjkAbVvoXX9gGg/hCrX4B5PRYKw39p/lfXQa348Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b61eod0lqZ1IWPGPe/5SMLOL30QBnenqoN4wmdifGy0DG5ZZfPY4jzRjzrXo/ySup0Vai1dgvfO38orUi7aMEZD72Tou7WHULLpuZXdU3MKfqqDNT6aQAVhYZuVODNFCbPqV7XlfSFIhU2RZznItlEM5T4QqURmPTqDbZ1i21mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=XaWOyyQC; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7102210382D37;
	Fri, 21 Feb 2025 21:57:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1740171423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+4P3zUmOi3UZOMRfYiGLCxCaTB0yCp04qj61xUw8Zww=;
	b=XaWOyyQCdjUl7qg/VkPioYDwaSF252DLdpXA541hXRWeuRNS6m01jwoFYhAsxZKlO3HHPP
	tsDvh7NthvGV4lyOofw09c6I5DzKgMauR3FstuCw66M7IWPO0KDHq3sXtiz/5Es5V6yY+R
	3hmJn/Vs+jGP/PS50iuJsKsxSkEyPkgLHAA7kFu0hVCbPhTozlSkidXoQmcH8v9tvT1u+c
	VwPbzsp7woswVBRySFrcl0XHLZgsh7vTcSLu3u+WmO54BsQHvwP2jdl6ouSiQl3sBFHgOt
	0Vg1kxNth4SbtSpRsSmFHUO06cfJfT/QOPe+1e84WI+7lohIpLZiPJiAWZnBTQ==
Date: Fri, 21 Feb 2025 21:56:59 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof@spud.smtp.subspace.kernel.org,
	Kozlowski@spud.smtp.subspace.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>, Aradhya Bhatia <a-bhatia1@ti.com>,
	rafal@milecki.pl, devicetree@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Noah Wang <noahwang.wang@outlook.com>, linux-kernel@vger.kernel.org,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Alex Vdovydchenko <xzeol@yahoo.com>,
	Grant Peltier <grantpeltier93@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 2/2] dt-bindings: trivial-devices: Document SPI
 measurement on LWE boards
Message-ID: <20250221215659.61ecc523@wsk>
In-Reply-To: <20250221-scuba-rematch-ada1a9b750b1@spud>
References: <20250221155418.1167670-1-lukma@denx.de>
	<20250221155418.1167670-2-lukma@denx.de>
	<20250221-scuba-rematch-ada1a9b750b1@spud>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+8m2XaJSdgbNjty+rTzoe70";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/+8m2XaJSdgbNjty+rTzoe70
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Conor,

> On Fri, Feb 21, 2025 at 04:54:18PM +0100, Lukasz Majewski wrote:
> > The measurement device on Liebherr's (LWE) boards is used to monitor
> > the overall state of the device. It does have SPI interface to
> > communicate with Linux host via spidev driver. Document the SPI DT
> > binding as trivial SPI device.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml
> > b/Documentation/devicetree/bindings/trivial-devices.yaml index
> > fadbd3c041c8..5d736a9792c2 100644 ---
> > a/Documentation/devicetree/bindings/trivial-devices.yaml +++
> > b/Documentation/devicetree/bindings/trivial-devices.yaml @@ -161,6
> > +161,8 @@ properties:
> >            - jedec,spd5118
> >              # Linear Technology LTC2488
> >            - lineartechnology,ltc2488
> > +            # Liebherr on-board measurement SPI device
> > +          - lwe,btt =20
>=20
> How does "btt" translate to what the device actually is? Seems kinda
> random!

Btt is a family of devices (bttc, btt3, xea) - to control heavy duty
machines.

That was the original codename - conceived probably 30+ years ago.

> Also, where is patch 3, adding the lwe,btt to the spidev driver so
> that it will probe?

I've posted it to Mark Brown (and also linux-spi ML) for review.

>=20
> Cheers,
> Conor.
>=20
> >              # 5 Bit Programmable, Pulse-Width Modulator
> >            - maxim,ds1050
> >              # 10 kOhm digital potentiometer with I2C interface
> > --=20
> > 2.39.5
> >  =20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/+8m2XaJSdgbNjty+rTzoe70
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAme46JsACgkQAR8vZIA0
zr1VUwgAwBZajgQjcPFeaU3Q6nMY3VKiS77ZAR4yoPeC45gwkOj42VXAhLOxvL7t
V9d1ELcUIonegBxDDSLpOytEbvhLMTP6A+udP+BJumsGPq7NA2zaSNsf1Fi1QU15
bYzbZBmIjzNKLsL8qAE5kr9qpZgHuqZEJRh8TGyVwCFiRbM9I5Jyy+JlUfFUWSv5
t/bEwXxa52JKDhqD0I7N444kw6mkigdtpcRRV8U+Yex7c2TJcWn/M8agnRVoMF25
0yJS32kMNvZpek79cMxstz4vuJdizRUhmU09ms74bPXxfgPTn224u/YCfAGkEPGU
ylQa/z2zesFufBZXdQAfWV65b6xHtA==
=AFkW
-----END PGP SIGNATURE-----

--Sig_/+8m2XaJSdgbNjty+rTzoe70--

