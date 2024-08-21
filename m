Return-Path: <linux-kernel+bounces-295655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C72959FB2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E75F1F241D7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8551B2536;
	Wed, 21 Aug 2024 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnuo5ldv"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810CF1B250C;
	Wed, 21 Aug 2024 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250259; cv=none; b=J0kNhAN+bCkoz691HgfGumnEG4sPjiUnWm6zezIPSUzAmwVSHkGJy1tNAqLQZfj6h/HxPVNZjPMnPms3JC1HgL/FFvqB6qekxVql4Vu/00Nl+1akRwna0+kh6/V+maiL1CKmlB2L1F2pERd69D77jJcajXxZzxx1QHxac71mMm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250259; c=relaxed/simple;
	bh=LQi6n4yMSVAfqtfuPS2JswfGIu0Wscw3/kexTT4Dk+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRVjf6vztxDW+rzsGWZVB+jGdMlppPnWnSzl7LYrg65x9RgDF3ryD45HgMpvRXdXLA0SvbWHkh6B6ap6BbtjQ33jzr13DMBZ5ahO4sKAAZ/7pkE+rUmwU+EUb0Vb4B8id8qKfKGj2W7eSE4R+lyZtCys5dxkiI/I2yh1hXkv8ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnuo5ldv; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53345dcd377so2276465e87.2;
        Wed, 21 Aug 2024 07:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724250256; x=1724855056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlbE1ZVUp8r5d/u+xc6LD6T9os/TKYS6UASL1EJLs8Q=;
        b=mnuo5ldvgoQJcmp8ljqZ8LS5bjJKhyfc+O71UxR2sziahMOjg5RmBe8U03S/ZUBhdQ
         AHPbBlhM0UIbAVi3gFUON7CWTnPgMlGYTFa72k4Glyu3H5iN9c6VpBRSZBA/RZNo50O0
         tu4qmGiBSWUhq/8kg0RH7pwFXbGPg2CCYYvXDMZmEHRny6qHf8va3BVysVzTagbUZPYt
         gA1NU4O0y7rGathp2pfJ4dkT4WlJF9NCbLwphsDBYLQtfE94q6WPvu3Z70Kib01DlZbY
         wFxOBVmkfpshBhp0XXvJwKgImD7p4vKY7YmRhubd9YSr8H9uI2c6U1bqrq+PHUZK4VRr
         QF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724250256; x=1724855056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LlbE1ZVUp8r5d/u+xc6LD6T9os/TKYS6UASL1EJLs8Q=;
        b=cO2FbcZrppz2TEv/3dueOosq5uJOrKeTLXE0/ZJ+PBUSDeJL8UTnDeaCEaOmaEFXAb
         CIF2pi7MsGlP1Fz8L4UPq/FTQOZCynV1ftWjGGI0JqlpYmIIzHTyeYxdFcgalVXP4EH0
         XxuwRkelfQFucJKQE/1ydnrLDHERsu9UGWzh+693Pa1tesxTSeX4TjjV705AIdtZXNeQ
         2KffL55rQfMPBVmWI99XcIwHSz8z60EBdIS2+XJrh1x3E7XySkUGm93oWQFgorahNFY2
         HsmC5Jwt6NWDglKgq9E00O0j7P+4C29VlkNnxwo6yNJ2TQdcL83DizpgA0FNEN1oQIyG
         v1ig==
X-Forwarded-Encrypted: i=1; AJvYcCVMRR7fiSp0vBxGHvaPV3ynBZKN9ejqN2kGb0/6pBms/xIIl+C+klY+Z1rZf+w8rbShkI70++Kld5Xr@vger.kernel.org, AJvYcCWF8Lt11g6baiqPz6zOWsh7naevLgPMTcmlZy+8TA/ThWaofXyq+i+JSzQgdAK2xlQRsClChGm/N1FhJbO0@vger.kernel.org
X-Gm-Message-State: AOJu0YwebmZdYBuMcwmVmwLopfwwG5nlS/ILUVwSuYU0WfNPiJ4NdK/o
	2RPpn7KAdxvSkgD0hm7ZKWWXBrJjNkskg4Ldy7WhxfLKueIPlQ437UcFyUKChGU8QTi37hNnUTY
	jOjzUTFcR2BfeBJz2xwOLqQ1bEL0=
X-Google-Smtp-Source: AGHT+IEo2C4tLGErKbN36oFT83s+fOENUqZMA6ZnvUMnZOe6yCITNZ+3R77DMVBR+1CUyo7ZuXGHZL17izwR69jEvVo=
X-Received: by 2002:a05:6512:1103:b0:533:47ca:9773 with SMTP id
 2adb3069b0e04-533485fe302mr1783670e87.57.1724250255178; Wed, 21 Aug 2024
 07:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821135817.56393-1-tarang.raval@siliconsignals.io>
In-Reply-To: <20240821135817.56393-1-tarang.raval@siliconsignals.io>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 21 Aug 2024 11:24:03 -0300
Message-ID: <CAOMZO5BJQ4RVRqvpcdAdXqhcfP6b7NbN-0VQZB7sBfYGKr8phw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals Support
To: Tarang Raval <tarang.raval@siliconsignals.io>
Cc: krzk+dt@kernel.org, shawnguo@kernel.org, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tarang,

On Wed, Aug 21, 2024 at 10:58=E2=80=AFAM Tarang Raval
<tarang.raval@siliconsignals.io> wrote:

> +       can-control {
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pinctrl_cancontrol>;
> +               reset-gpios =3D <&gpio1 15 GPIO_ACTIVE_HIGH>;
> +       };

This does not have any compatible string, so this can-control block
should be removed.

> +        can: can@0 {
> +                compatible =3D "microchip,mcp2515";
> +                pinctrl-names =3D "default";
> +                pinctrl-0 =3D <&pinctrl_canbus>;
> +                reg =3D <0>;

reg should come right after compatible.

> +       rtc@32 {
> +               compatible =3D "rx8025";

This gives a warning as rx8025 does not exist.

It should be "epson,rx8025" instead.

> +/* Wifi */
> +&usdhc1 {
> +       pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> +       pinctrl-0 =3D <&pinctrl_usdhc1>, <&pinctrl_usdhc1_gpio>;
> +       pinctrl-1 =3D <&pinctrl_usdhc1_100mhz>, <&pinctrl_usdhc1_gpio>;
> +       pinctrl-2 =3D <&pinctrl_usdhc1_200mhz>, <&pinctrl_usdhc1_gpio>;

pinctrl_usdhc1_gpio is not being used as you only pass pinctrl-names =3D
"default". Remove pinctrl_usdhc1_gpio.

> +/* SD-card */
> +&usdhc2 {
> +        pinctrl-names =3D "default";
> +        pinctrl-0 =3D <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +        pinctrl-1 =3D <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
> +        pinctrl-2 =3D <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;

pinctrl_usdhc2_gpio is not being used as you only pass pinctrl-names =3D
"default". Remove pinctrl_usdhc2_gpio.

> +        cd-gpios =3D <&gpio2 12 GPIO_ACTIVE_LOW>;
> +        bus-width =3D <4>;
> +        status =3D "okay";
> +};
> +
>  &iomuxc {
> +
> +       pinctrl_canbus: canbusgrp {
> +               fsl,pins =3D <
> +                       MX8MM_IOMUXC_GPIO1_IO14_GPIO1_IO14              0=
x14
> +               >;
> +       };

Please add blank lines to separate the pinctrl groups.

> +       pinctrl_cancontrol: cancontrolgrp {

