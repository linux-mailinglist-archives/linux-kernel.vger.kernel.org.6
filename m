Return-Path: <linux-kernel+bounces-274732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733EB947C03
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE683B20B7E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89693381B9;
	Mon,  5 Aug 2024 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTHUHlN4"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4910B28366;
	Mon,  5 Aug 2024 13:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722865211; cv=none; b=dYoO6lidYZyqyay0MifY4o0SUZLO3yEAr/Ha1hyllImPF/wCt3g/AAz8FKMBV8wYdShecNTNKaqTDd9PerbfBKJOppUCHzZxeW5rc4IGoCbUQJQ1Id8KIK+AGQb6fzH0E88AWvy8Oa7ZXxdjggJwNRZ0WX51hGEexJAZ6e9zhY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722865211; c=relaxed/simple;
	bh=ruk6mOOD/J6EGS1DmhBnxOfoM7b7J30uZ5JPOGJ6aDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPBrEG4cxZV7ppKtbOJK2xghbKQy5E6feS0whx8vtLQRwzPovNMYbPIc2hRA4w4YzppsK5fySxUQQLri/w+7VAoLjuqbO4cfdQQnLfMm/LL7/Eak6jJIrFjtRUcQQQx01QVIglEffsL3AN6zMG34DlYp9WqHdACUiAx9cTz/QKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTHUHlN4; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f166ec1265so4467221fa.3;
        Mon, 05 Aug 2024 06:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722865208; x=1723470008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b46iJ32H/7QhFKQjeBDvVn66a9XBRt1jPCCUgibPNOY=;
        b=PTHUHlN41y6QYqeaGmx6NOUIga+RIfO6JuVkiDUv1VH7Je+P990vZ/pAYD31zhYOg5
         5rKym9aEVa5V/3CayTQ9NgnpNFfT5uaHH3va+AX9k5Xc1N1PWx9L4qvPt1ksimPAtEcY
         PD9zAf9Mwlqxma00X9ay58tgbwKDxiyoprXgGfQNrpuz2UTfGqKmFyPBWED3B1WXrkwz
         mgJk+6tsIZ2qI4vr0lpt4Rf+3UCAklVkHfjxsW2tdDVkfbkmEaZ9BnD3cCV5tlcBe+5W
         Z+dSVsahykiZT/EwdT24mQEYI9S3jIFIOZMAdMmJxmDz594/3v0N5gfMpxZNNuguXigD
         obLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722865208; x=1723470008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b46iJ32H/7QhFKQjeBDvVn66a9XBRt1jPCCUgibPNOY=;
        b=N+zNidqlgRgF80u42Do6UnBcj/e5+g67sTq3tm6XM2vzVDMOc1ETFdzW6/TbIJhnsB
         851jfTemwvJ7zX7cLGTJG5dWmHBfgvug0tAi6kgij4/YnomAcfLHpuAp12soAkpffDEi
         fPmy+lgEHs00n8XskfHZ5aN3kaOFWG7RMZve2JOGoA5CMMWhTKS//4/IRETckdyXPg8r
         3iKttOqU/qbqHaoxKePoJPJAYODyLudZ9c0smlyqbYkzu8hKzZxUoKT6L+GFGgAJ/cwq
         z6DPZqZC8rN7U3nC6NI6DoP68Fys1XNLy6FoPoN5Nf3X788MfHKvxPkigPWlWnfpurED
         nJjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ4HK/le+Ne5gKTJT6NtHRQoTMlcFpnyYzQgZ2GU9K/uAWc+bmlC7JD+q/YtnuVlwQGKMSUHFTOMW3@vger.kernel.org, AJvYcCX/NpbDNZBKIE3ZgMfHllaczcKe8UDAWFKNGOEDjKrplIO6tiDFlcoHmhv4T9VqtiLJXRqRc+BDUTKasoJD@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8E+WgiGg8vUqUbJZokc7tRQTaw/CtlvNkqZLe+GnBzp8HVkBr
	xTSNLcgdAov00wfg616D6jEoEBz0fx3lbF2HJWzQ7L/jYoBSZenH3sApAsU6+EzeGjY6aYSH076
	3wiRyizX3YfTpvC41KHbIihPkPio=
X-Google-Smtp-Source: AGHT+IET0zibODSKGLqBpAyFlOzXNn5BGpAezMR6EMww3A49Me0AsCpIlHGcaMhKnEUXB8jG1dP1asr/bLudntWRt98=
X-Received: by 2002:a05:6512:1307:b0:52e:ccf5:7c3e with SMTP id
 2adb3069b0e04-530bb3bd143mr4066577e87.7.1722865207262; Mon, 05 Aug 2024
 06:40:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805-imx8mp-tpm-v1-1-1e89f0268999@phytec.de>
In-Reply-To: <20240805-imx8mp-tpm-v1-1-1e89f0268999@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 5 Aug 2024 10:39:56 -0300
Message-ID: <CAOMZO5DzH1Ldfg1rr7ET+2Y138Sv+G9HV6iRiTPOaOUgJ+asHQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: freescale: imx8mp-phyboard-pollux: Add and
 enable TPM
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Teresa Remmet <t.remmet@phytec.de>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Benjamin,

On Mon, Aug 5, 2024 at 10:33=E2=80=AFAM Benjamin Hahn <B.Hahn@phytec.de> wr=
ote:

> +/* TPM */
> +&ecspi1 {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <0>;
> +       cs-gpios =3D <&gpio5 9 GPIO_ACTIVE_LOW>;
> +       num-cs =3D <1>;

num-cs is not needed.

The number of chip selects can be retrieved from cs-gpios.

> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_ecspi1 &pinctrl_ecspi1_cs>;
> +       status =3D "okay";
> +
> +       tpm: tpm_tis@0 {

Node names should be generic.

Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml suggests 'tpm', =
so:

tpm: tmp@0 {

>  &iomuxc {
> +       pinctrl_ecspi1: ecspi1grp {
> +               fsl,pins =3D <
> +                       MX8MP_IOMUXC_ECSPI1_MISO__ECSPI1_MISO   0x80
> +                       MX8MP_IOMUXC_ECSPI1_MOSI__ECSPI1_MOSI   0x80
> +                       MX8MP_IOMUXC_ECSPI1_SCLK__ECSPI1_SCLK   0x80
> +               >;
> +       };
> +
> +       pinctrl_ecspi1_cs: ecspi1csgrp {
> +               fsl,pins =3D <
> +                       MX8MP_IOMUXC_ECSPI1_SS0__GPIO5_IO09     0x00

Maybe simpler to put MX8MP_IOMUXC_ECSPI1_SS0__GPIO5_IO09 as part of
pinctrl_ecspi1.

