Return-Path: <linux-kernel+bounces-431529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1959E3E8D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD74161C9A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AEF20C479;
	Wed,  4 Dec 2024 15:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YjlXsJ2g"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB5A20C02C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733326971; cv=none; b=curel2cDmTYlZGxfdgyHMJovjWonxfiGBFE4fUTMmu/w2m2bxnGQgIB6AI+XGP1h83jx1ekbXOXcg5dq7ehQRTpqcdqs0d+Yj9EyxZZeoOVm58fkT78uYitWNb6W11OA1bXruRO6qlgGqBLwfTLq3vKhDWYb70bJ0CNfZWBSruU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733326971; c=relaxed/simple;
	bh=Du62ZT7H3KiIEI8S+r1wQl52fLVzJZyyRtxf1lSDWwM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Me8KM8W6PG3AYVzk1w9eOxnWMwzdlkRH1w6aFmWDdO9TlyfF3g2vsCT0bLcCL0uWhAZqmTK4QCmyPo/C0YxmKWZT4ZEF2zShxQwx8R6XLkYj7sLc7gP5cKjhJbzEW+Sr/C3X+zHMimCbVY4S8uwVvfk2klXVfiRWZA22yvTuCi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YjlXsJ2g; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434a14d6bf4so62980395e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 07:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733326968; x=1733931768; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dZ3uPxGHW9GwceDWDOZp20va51AUDdsf3QJ+X4bmhMo=;
        b=YjlXsJ2gkYibaWorTujqFHG+Zo1TPwjt9MkDOpE7AB+0y7EnnXGQEPx2LSnhlmgToE
         qrxsTQTYTLavJzifSeUd4QVcbwbF1g8ZahNL3zBPAm/hpsscN4WPVpuoKIKQJ4E4ONya
         pgYcpuy6vLsgYvRe7b4FV25zGkkeS2W4nJ/rzZ/SasvPrIE7lwCU4h51dp51OKeCOW5x
         Aa/28Bz2xDCFi4FgQwJiIgdgZ3UyY+xHN+ZGoi7frQRSKSqLVU9Uaf0gusRQ4ojjpvkW
         J22K2Jb/keFf7wTfCgAgkREEWZVNsNAAb3oDAMZaAR4FbV5y93a9TrSRGo4etuVDbExZ
         PT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733326968; x=1733931768;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dZ3uPxGHW9GwceDWDOZp20va51AUDdsf3QJ+X4bmhMo=;
        b=sfTlZCp0qXLwIpYqTT49NPtv4pBi9JuAxWz/vkUm+l/msF5Qp7R1dsK1X9cgfL/CZd
         OogUh2+6/jqbKuloiqVdcrmQrGZ3ymPwMwqqUwcqKVHtx3JiaRhRj6OTvBsta0r9kFPH
         JzGYC8U2gIBge37aWr95ncWZIXxgmTFTvmFYCuw6CovVs8rZM7Ce50jcbKyMNc6uq5Nt
         9tKn/GKrN1DQiO5ZhhPlR11L4SLnj3AVB0kG1zjpfMHelQo8THHOpcUQfuPX6K4stUbe
         /RWcZh29Q9wTNBT526T3ikpzbAjGs+g2lt6/Ix74T8r/OHnzcA5ndMenWUBlJmGIjtJW
         JKgw==
X-Forwarded-Encrypted: i=1; AJvYcCU5oRi7+pd5Jxob6Bn/mqposl7KEIH0LAxCh31q9Q9nQibjU//dj8/xHzexAFaW6iVKn8kVPRBhfk9bMts=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrL9vI9LghM726MTpaOc9nrXmdDw/nGQTpYD6nOBwNjO6L3c/i
	qC7AOdsBTQx/PwGN+8xBd78ljEOxVzeVnmYx6Fe+NWNRmKmJFZkp4zVDCxFAyow=
X-Gm-Gg: ASbGncuusotQ0HaFLQF2SvN2pZJjQgm0c2L7VjpUuQS736Cn9MfJemxEf4jS4Q+uU93
	As9WznJkd4cW8hCIVmNmQwKzrXJFrnndM69cGgI3eGjDthJI9vQuhM5R84UpeWUq1+AgVFLPAg1
	UKd7UWQn5h1kvOl0y2o1jHtyS1yzDI4BE/W8Bz2dVKZgcJLU4m5O0F2d4vJb5jBfObTqtGGRYgn
	bWLl7ucOft2/0ucsUSS87rDxr+8y3mHLl+qUzpMqlw/4CoBMQGaFQ==
X-Google-Smtp-Source: AGHT+IG8d+GIp7N1rLmweG1s9QVjHKMOxpL6iKDNzEJzmEVoVKRVhmtWfMeaWkWFRVe64V9BiKR57g==
X-Received: by 2002:a05:600c:4ecf:b0:426:647b:1bfc with SMTP id 5b1f17b1804b1-434d0a14eb7mr70707555e9.30.1733326967904;
        Wed, 04 Dec 2024 07:42:47 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d526b131sm29295485e9.7.2024.12.04.07.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 07:42:47 -0800 (PST)
Message-ID: <8c1c633bbd5a81a06ee9c9f52dfa8b43cf493b7b.camel@linaro.org>
Subject: Re: [PATCH 8/9] phy: exynos5-usbdrd: subscribe to orientation
 notifier if required
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,  Alim Akhtar
 <alim.akhtar@samsung.com>, Peter Griffin <peter.griffin@linaro.org>, Tudor
 Ambarus <tudor.ambarus@linaro.org>, Sam Protsenko
 <semen.protsenko@linaro.org>, Will McVicker <willmcvicker@google.com>, Roy
 Luo <royluo@google.com>, kernel-team@android.com, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org
Date: Wed, 04 Dec 2024 15:42:46 +0000
In-Reply-To: <Z1Bi2gRJefYy1tyo@vaman>
References: 
	<20241127-gs101-phy-lanes-orientation-phy-v1-0-1b7fce24960b@linaro.org>
	 <20241127-gs101-phy-lanes-orientation-phy-v1-8-1b7fce24960b@linaro.org>
	 <Z1Bi2gRJefYy1tyo@vaman>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Vinod,

Thanks for your review.

On Wed, 2024-12-04 at 19:40 +0530, Vinod Koul wrote:
> On 27-11-24, 10:58, Andr=C3=A9 Draszik wrote:
> > gs101's SS phy needs to be configured differently based on the
> > connector orientation, as the SS link can only be established if the
> > mux is configured correctly.
> >=20
> > The code to handle programming of the mux is in place already, this com=
mit
> > now adds the missing pieces to subscribe to the Type-C orientation
> > switch event.
> >=20
> > Note that for this all to work we rely on the USB controller
> > re-initialising us. It should invoke our .exit() upon cable unplug, and
> > during cable plug we'll receive the orientation event after which we
> > expect our .init() to be called.
> >=20
> > Above reinitialisation happens if the DWC3 controller can enter runtime
> > suspend automatically. For the DWC3 driver, this is an opt-in:
> > =C2=A0=C2=A0=C2=A0 echo auto > /sys/devices/.../11110000.usb/power/cont=
rol
> > Once done, things work as long as the UDC is not bound as otherwise it
> > stays busy because it doesn't cancel / stop outstanding TRBs. For now
> > we have to manually unbind the UDC in that case:
> > =C2=A0=C2=A0=C2=A0=C2=A0 echo "" > sys/kernel/config/usb_gadget/.../UDC
> >=20
> > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > ---
> > =C2=A0drivers/phy/samsung/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > =C2=A0drivers/phy/samsung/phy-exynos5-usbdrd.c | 60 +++++++++++++++++++=
+++++++++++++
> > =C2=A02 files changed, 61 insertions(+)
> >=20
> > diff --git a/drivers/phy/samsung/Kconfig b/drivers/phy/samsung/Kconfig
> > index f10afa3d7ff5..fc7bd1088576 100644
> > --- a/drivers/phy/samsung/Kconfig
> > +++ b/drivers/phy/samsung/Kconfig
> > @@ -80,6 +80,7 @@ config PHY_EXYNOS5_USBDRD
> > =C2=A0	tristate "Exynos5 SoC series USB DRD PHY driver"
> > =C2=A0	depends on (ARCH_EXYNOS && OF) || COMPILE_TEST
> > =C2=A0	depends on HAS_IOMEM
> > +	depends on TYPEC || (TYPEC=3Dn && COMPILE_TEST)
> > =C2=A0	depends on USB_DWC3_EXYNOS
> > =C2=A0	select GENERIC_PHY
> > =C2=A0	select MFD_SYSCON
> > diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/sam=
sung/phy-exynos5-usbdrd.c
> > index 1a34e9b4618a..2010d25ee817 100644
> > --- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
> > +++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> > @@ -394,6 +394,7 @@ struct exynos5_usbdrd_phy_drvdata {
> > =C2=A0 * @extrefclk: frequency select settings when using 'separate
> > =C2=A0 *	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reference clocks' for SS =
and HS operations
> > =C2=A0 * @regulators: regulators for phy
> > + * @sw: TypeC orientation switch handle
> > =C2=A0 * @orientation: TypeC connector orientation - normal or flipped
> > =C2=A0 */
> > =C2=A0struct exynos5_usbdrd_phy {
> > @@ -415,6 +416,7 @@ struct exynos5_usbdrd_phy {
> > =C2=A0	u32 extrefclk;
> > =C2=A0	struct regulator_bulk_data *regulators;
> > =C2=A0
> > +	struct typec_switch_dev *sw;
> > =C2=A0	enum typec_orientation orientation;
> > =C2=A0};
> > =C2=A0
> > @@ -1400,6 +1402,60 @@ static int exynos5_usbdrd_phy_clk_handle(struct =
exynos5_usbdrd_phy *phy_drd)
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> > +#if IS_ENABLED(CONFIG_TYPEC)
> > +static int exynos5_usbdrd_orien_sw_set(struct typec_switch_dev *sw,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum typec_orientation orient=
ation)
> > +{
> > +	struct exynos5_usbdrd_phy *phy_drd =3D typec_switch_get_drvdata(sw);
> > +
> > +	scoped_guard(mutex, &phy_drd->phy_mutex)
> > +		phy_drd->orientation =3D orientation;
> > +
> > +	return 0;
> > +}
> > +
> > +static void exynos5_usbdrd_orien_switch_unregister(void *data)
> > +{
> > +	struct exynos5_usbdrd_phy *phy_drd =3D data;
> > +
> > +	typec_switch_unregister(phy_drd->sw);
> > +}
> > +
> > +static int exynos5_usbdrd_setup_notifiers(struct exynos5_usbdrd_phy *p=
hy_drd)
> > +{
> > +	int ret;
> > +
> > +	phy_drd->orientation =3D (enum typec_orientation)-1;
>=20
> Should this be TYPEC_ORIENTATION_NONE?

It's -1 so that exynos5_usbdrd_orien_sw_set() (patch 9) can
check against the current value after driver load.

That said, it should probably be moved into patch 9 where it
actually matters, or even be removed altogether, in combination
with that check in exynos5_usbdrd_orien_sw_set() from patch 9.

I had added the check because some (not all) other phy drivers
do that, but looking further at that, I believe it's not
actually necessary, exynos5_usbdrd_orien_sw_set() can execute
unconditionally.

Will remove this and related code in next version.

Cheers,
Andre'


