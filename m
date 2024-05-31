Return-Path: <linux-kernel+bounces-196960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFE28D643A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3731C27203
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F841761BC;
	Fri, 31 May 2024 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B71EvWbF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9A9176224;
	Fri, 31 May 2024 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717164827; cv=none; b=l8D8L6Lvrj7xQOwcnc1SiXXrvzhpTAyDf6hifDAViHJ0x1vwqxjF3TFhrfPi0XY2eMNq88khxDHNiIC5QNC8YwOWsKmeky7cabtkAO0zeMMGl77QTUM1Sjxwxb4jxRBmwgn/K4aNKrPV+DBS2PV/+bJsohQRemK2Ojk10JjOS+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717164827; c=relaxed/simple;
	bh=C14r9FmYtbAymOkjt/uxZrZg8hcE5Qe7k9wAzHSGsmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggQUfHlEPEIzNfyqJRt7r7tlW68rNCgcU6U4WG8bD0MJSyZh0aDZtKYh40ObFijp53j4nH3DvyzZ45N6FgbPdUsa0KSGxxyCLZbiFeSFb+zGHcwFBRuweEihwjscBz01aXt0kB7X1KNQpJZeBEvQZMSqwcXzcKL/4xOuW1EEFBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B71EvWbF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89702C32789;
	Fri, 31 May 2024 14:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717164827;
	bh=C14r9FmYtbAymOkjt/uxZrZg8hcE5Qe7k9wAzHSGsmE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B71EvWbFYcnrC1s/wCyUOJm0cAfJo5IkGkcsHonkHxN7bzgqxjFwpKwhagVykzJPW
	 uKopnOInmDG/A9CITXKMB1ktzNnvJYdWKyr05/lBhaXPXJY6JocOk86Qhhe0g356US
	 OWUU0ClvxBVR240PrAzG6ezTVfHDXJ1bDKGCmJXNXK7uGI4BZYrb6eP79JdjucBncy
	 318psGnoEfwVlCDAbkMzG733liaolL/GxxDYy7kwSVJYY7K0B7XQelMDyZDx7JrmY0
	 +gc4GUYoVzdpEXnBAQoCZnb98IVwLRi5vwLbV/QSIZIGUF2K3pKkT3lPkSfjmN6jKy
	 lVYNoWipxB0pg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52b8254338dso2033918e87.2;
        Fri, 31 May 2024 07:13:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVU5Kz4d5WQpeidu9CDsMlZTjAp4UEFgZWheZtXrhCiEb33utyggFaEJRl2d4NhvRT2rAW/qylqT5RPCt8LhtEnm40k1Kcf2dTgglwp68S+48hzxPrVYykbKEuZWUxdu3v5q9wtzIVxZQ==
X-Gm-Message-State: AOJu0Yxc41RcSJe4TVK8pwQXY37MVyYmurGJuWXWk2dUmCy+srgfoie8
	pwQIV6k9LjOqLHgJCd6gJRGPHGFfrTMGRocAmE+/VeG2pGVgtaMY/pWnIJVB9kdhypxq11jol1H
	OHVDqvyH9cf3FqNdDpLO84b6N1A==
X-Google-Smtp-Source: AGHT+IHUlwL3z32dD0Od1b2Bi8JNBTAypQXHyjUufMKO7fZljjcaDf6m6zg3OLTckqlZX1AxA2gLS5ds11gM5rI/2RQ=
X-Received: by 2002:ac2:4eca:0:b0:52b:83c1:3f6c with SMTP id
 2adb3069b0e04-52b89576997mr1438677e87.24.1717164825951; Fri, 31 May 2024
 07:13:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522215043.3747651-1-tharvey@gateworks.com>
In-Reply-To: <20240522215043.3747651-1-tharvey@gateworks.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 31 May 2024 09:13:33 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKtc_65tDMFWT0WroNPmW2R0Dd-4Jw101PnyJcPb=7tJA@mail.gmail.com>
Message-ID: <CAL_JsqKtc_65tDMFWT0WroNPmW2R0Dd-4Jw101PnyJcPb=7tJA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: rename gw7905 to gw75xx
To: Tim Harvey <tharvey@gateworks.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Li Yang <leoyang.li@nxp.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 4:50=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> The GW7905 was renamed to GW7500 before production release.

Maybe some summary of the discussion and how this changed from one-off
to wider availability.

>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

