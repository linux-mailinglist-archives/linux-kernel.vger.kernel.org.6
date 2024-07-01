Return-Path: <linux-kernel+bounces-236673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D6791E5A5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E959E1C21B79
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A7316E875;
	Mon,  1 Jul 2024 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PA7lOMC2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA6116DC1D;
	Mon,  1 Jul 2024 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852227; cv=none; b=Ak6RAooBXBP0ADtDNPTHcq/p8LSAG4ZxZZ8YZkkFWo+HJdb5RdK8xyw7IEhILT53SK1oAbL9IsnVZp4KqFWeZrBsr6C+kwQgpfhNITTnZ8v7G+ZNpYrQmXGK6zyOquFIIjDZN37VhXjmeblEKyFLp5nZ4G6LLnqBYV02pnIVoCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852227; c=relaxed/simple;
	bh=RhesN34OZXRCLFEIbStTuwHzFvllKCOmzyEKt6ScGKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JnXMfylrvWPGoDkPIX2b/oVMWUoLaQ3SVqUziY5B9YXvfrRyjOGV7fZgRtfbKTA7i90vIn7bLMIdiLrV7zllJwHcYDKL086/rAjyu9UkkRPavCMGB3xytiVhZNStbNuNM089K6iAlkSCe/rNzyXez10yI1DwkHbgXTEHQOAepwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PA7lOMC2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19736C4AF0D;
	Mon,  1 Jul 2024 16:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719852227;
	bh=RhesN34OZXRCLFEIbStTuwHzFvllKCOmzyEKt6ScGKQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PA7lOMC2yeT5jHq4YyMbgHj+ebNMg5lGTkbWWSUdr+Vp0Lv7dXhP4eHYPkazqLK+W
	 DAqKl3xuorgsLurLjSt8NruWVqV1BtvSVUXft3JWmux9S0Qa8S38Obs4yAPrQ8DL2M
	 Re/wxgG+ko3t1z/p0edpbgA5l62Ty8eW+Y8DJe4tBE/ypxtQH5G0TUerwgMbJ8oLwg
	 CRnGI/LYdDbQXV4TAXGHif4OKddS1ZGPR1AEkF+6tIeLzysR7KNG10ScFYDPPuWuc5
	 3f7RQa0TJOrjCOFqLQDHQpxdLoEVy9X7iAHo4TnY+GqpcLhtRAKUWpOu7a8i8xNVKO
	 V/b/1WQTXErDA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52cd87277d8so3274884e87.2;
        Mon, 01 Jul 2024 09:43:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXorbEBLUZFDySvziAjLIeZiQSxyibAuzqK9a86vSLXKk/i5xYKfgYMpXtbLz4N90mTuYgRvRmdwsXOXN92ry9Zu/Z6aUPU5ttMzpKVWm5pmYK/A+ptQ9Q8m8yRns6hcOOgFxl51AgGPA==
X-Gm-Message-State: AOJu0YwjycOvMf4R31LSyb2JoIC8VBlYti9SWY3WEYPLu8u02y0bJeSN
	cXIt/K5K5Eqebv6OsPcMKHACxBA61tRSmxB83l0clyprCOa9SF7eaHaFtWudO8ip47lw4zbBfM0
	HV8HxxiqcbZLD1Timgj/a48OdtA==
X-Google-Smtp-Source: AGHT+IFG5Mq0obsNWQtCBZPRbzAd+loy81MuYfKp3AnfwKzL/l+yMY2HM7soGl/xhylLHC0NirhzM3BijXPSGg4CMbw=
X-Received: by 2002:a19:c214:0:b0:52c:e132:799f with SMTP id
 2adb3069b0e04-52e82691aa8mr3365838e87.31.1719852225386; Mon, 01 Jul 2024
 09:43:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626202533.2182846-1-Frank.Li@nxp.com> <20240626202533.2182846-3-Frank.Li@nxp.com>
In-Reply-To: <20240626202533.2182846-3-Frank.Li@nxp.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 1 Jul 2024 10:43:32 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+YpLk4E-Sk7otOtbZo8FKYb-9GuPC1ie3aRauP=7_1HA@mail.gmail.com>
Message-ID: <CAL_Jsq+YpLk4E-Sk7otOtbZo8FKYb-9GuPC1ie3aRauP=7_1HA@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] arm64: dts: layerscape: add platform special
 compatible string for gpio
To: Frank Li <Frank.Li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	"moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 2:26=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:
>
> Add platform special compatible string for all gpio controller to fix
> below warning.
>
>  gpio@2300000: compatible: 'oneOf' conditional failed, one must be fixed:
>         ['fsl,qoriq-gpio'] is too short
>         'fsl,qoriq-gpio' is not one of ['fsl,mpc5121-gpio', 'fsl,mpc5125-=
gpio', 'fsl,mpc8349-gpio', 'fsl,mpc8572-gpio', 'fsl,mpc8610-gpio', 'fsl,pq3=
-gpio']
>         'fsl,qoriq-gpio' is not one of ['fsl,ls1021a-gpio', 'fsl,ls1028a-=
gpio', 'fsl,ls1043a-gpio', 'fsl,ls1088a-gpio', 'fsl,ls2080a-gpio']
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 4 ++--
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 8 ++++----
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 8 ++++----
>  3 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/=
boot/dts/freescale/fsl-ls1012a.dtsi
> index 2e1cddc11bf47..1b6ab9550cce9 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> @@ -407,7 +407,7 @@ duart1: serial@21c0600 {
>                 };
>
>                 gpio0: gpio@2300000 {
> -                       compatible =3D "fsl,qoriq-gpio";
> +                       compatible =3D "fsl,ls1021a-gpio", "fsl,qoriq-gpi=
o";
>                         reg =3D <0x0 0x2300000 0x0 0x10000>;
>                         interrupts =3D <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
>                         gpio-controller;
> @@ -417,7 +417,7 @@ gpio0: gpio@2300000 {
>                 };
>
>                 gpio1: gpio@2310000 {
> -                       compatible =3D "fsl,qoriq-gpio";
> +                       compatible =3D "fsl,ls1021a-gpio", "fsl,qoriq-gpi=
o";
>                         reg =3D <0x0 0x2310000 0x0 0x10000>;
>                         interrupts =3D <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
>                         gpio-controller;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/=
boot/dts/freescale/fsl-ls1046a.dtsi
> index f8c9489507e7a..524b44f424272 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -589,7 +589,7 @@ duart3: serial@21d0600 {
>                 };
>
>                 gpio0: gpio@2300000 {
> -                       compatible =3D "fsl,qoriq-gpio";
> +                       compatible =3D "fsl,ls1046a-gpio", "fsl,qoriq-gpi=
o";

ls1046a isn't documented.

Rob

