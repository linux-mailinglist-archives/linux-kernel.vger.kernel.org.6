Return-Path: <linux-kernel+bounces-322662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E939972C00
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8040F1C21579
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AD617D35C;
	Tue, 10 Sep 2024 08:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=martyn.welch@collabora.com header.b="CvAz5FTa"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC41210F8;
	Tue, 10 Sep 2024 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725956402; cv=pass; b=bDxOyhMhqgN0M20i391f3XSiZAS0Z7SSet+xCNELTOwz+W+22JcSbrE4NZuEicFJ0GJGPeBV9HqGWheVkBwnnGPEwBenpK8y3/VABZWz/Jm+QDBSUgyc/uRKq3VojEIbP2cnHmbHnM+1QBKrIGxDUv8cUzsoSCGzFHHZPL+Myaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725956402; c=relaxed/simple;
	bh=4N/h4GryGD5oojb02XrlbTmqShm0p7D+nkc8SsK6das=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iEoIPcCM++rOmczaVysXcYFWwOMdLnI0o1H1J7/e1usWOw+kXf5IkIh72BogQazuRYJHUbY3wGuI1h/QWknyFgWhVM8WRPeG9DCV4wFWnrMavuUjt1nzKdmpcrYaoVyzTMcXRsUEp9FEtYQ14xbIQcMxq+0B93e/lcb3wYA6BGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=martyn.welch@collabora.com header.b=CvAz5FTa; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1725956385; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Q5W8x46CwBN7kFYHePN0Z68pzr3KOcB+6hqRc51Av5O+Ib8LzZv2Xe5PNin06PtsbMaopaKuI22hLpa0l9u3qN8IoIVd96LQSJ6oY+miQBOuUNCQjqscJt3CR/9Nklou6UNrXgy12WPBQOzGteRf8Z47iN6I95IuvHWHYtIpAz8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725956385; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ubA4UwrqmU0jIPeodmUv/1P32AE7YKaWXBvt2qoh1Iw=; 
	b=a/1Z6LftVCuWXfx+4zyPKy5rlF1qt7vI6386huSmoll5aNar2+WmMte3lawbJmWdP2GlwUOWJ1L9YK5TkcQYgDMtUFWaWNvz/OlmiCGj9ndkMvvfFUaJaVd1VqqvwY01tkfEArqt21kEjy6zp0057uZSqjIiIPn0HAeq7JbsXQY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=martyn.welch@collabora.com;
	dmarc=pass header.from=<martyn.welch@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725956385;
	s=zohomail; d=collabora.com; i=martyn.welch@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=ubA4UwrqmU0jIPeodmUv/1P32AE7YKaWXBvt2qoh1Iw=;
	b=CvAz5FTad3pp84rTkWC6fAn2cVMIkVb4zrBQ+Z447mXrGTt2U7xtzYiDJOOv+Ns4
	r0mkyYlodC9laEvWQ7pTHtDjeFLay4T+7DzSEm85+Mnc51vjDrQ2QwvtfEWIIbK6fe2
	1vw4lZdffp46yPbju8OqWSSXL3oO7gMdUqPsMdzs=
Received: by mx.zohomail.com with SMTPS id 1725956384778375.29161985115456;
	Tue, 10 Sep 2024 01:19:44 -0700 (PDT)
Message-ID: <d161352f2bdf7da1b6d299818c6c665ad48ab665.camel@collabora.com>
Subject: Re: arm64: dts: ls1028a-rdb: Add iio-hwmon compatibility table
From: Martyn Welch <martyn.welch@collabora.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, kernel@collabora.com, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 10 Sep 2024 09:19:41 +0100
In-Reply-To: <Zt87n+NTaN7qSQTS@lizhi-Precision-Tower-5810>
References: <20240909163608.80541-1-martyn.welch@collabora.com>
	 <Zt87n+NTaN7qSQTS@lizhi-Precision-Tower-5810>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

On Mon, 2024-09-09 at 14:17 -0400, Frank Li wrote:
> On Mon, Sep 09, 2024 at 05:36:07PM +0100, Martyn Welch wrote:
> > The ls1028ardb uses the TI ina220 power monitor. This device has an
> > IIO and
> > hwmon drivers, but can't be used with both at the same time.
>=20
> > To enable us
> > to utilise the iio framework, but also access power information via
> > the
> > hwmon framework, add an iio-hwmon map. This allows the IIO driver
> > to be
> > used for the ina220, with the iio-hwmon driver mapping the data
> > from the
> > IIO framework into hwmon.
>=20
> Can you simply said:
>=20
> Add an iio-hwmon map to utilise the iio framework and access power
> information via the hwmon framework at the same time.
>=20
> Frank
>=20

Sure

Martyn

> > Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> > ---
> > =C2=A0arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 9 ++++++++-
> > =C2=A01 file changed, 8 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> > b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> > index ecd2c1e..b062de5 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> > @@ -94,6 +94,12 @@ simple-audio-card,codec {
> > =C2=A0			system-clock-frequency =3D <25000000>;
> > =C2=A0		};
> > =C2=A0	};
> > +
> > +	iio-hwmon {
> > +		compatible =3D "iio-hwmon";
> > +		io-channels =3D <&ina220 0>, <&ina220 1>,
> > +			<&ina220 2>, <&ina220 3>;
> > +	};
> > =C2=A0};
> >=20
> > =C2=A0&can0 {
> > @@ -222,8 +228,9 @@ i2c@2 {
> > =C2=A0			#size-cells =3D <0>;
> > =C2=A0			reg =3D <0x02>;
> >=20
> > -			current-monitor@40 {
> > +			ina220: current-monitor@40 {
> > =C2=A0				compatible =3D "ti,ina220";
> > +				#io-channel-cells =3D <1>;
> > =C2=A0				reg =3D <0x40>;
> > =C2=A0				shunt-resistor =3D <500>;
> > =C2=A0			};


