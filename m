Return-Path: <linux-kernel+bounces-204378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2628FE7F0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16569B273C3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CCA19643F;
	Thu,  6 Jun 2024 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ml1eOfci";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ipMSiLDK"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175C1195FD9;
	Thu,  6 Jun 2024 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680899; cv=none; b=Mb5mXlbzB6do3QsZgIABYRi9dE4RCoeedEy9BrCNEUGr1fRN9oVgzrwzzpkjjbrGDzYwMtIqPbbwJBinoLETsI+h3cOXko0Z2o+0U5r4puAeYxyOyHgmMpP9vwqIP3vJO0ZMKqSOvzTqEVkc8JFKYZqmMfK5REcTSTv4gTz6oW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680899; c=relaxed/simple;
	bh=rwUDRgOE0g4IgjJwSHjyICbUSGGmHGx7b0GMJ3hLNNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LY+72qKB4Ee2rBYNFeDPiTkUz0OgAAnxbbENxlXyyc0m2NLrXYZPIlaQs7GjIa0IW8XbeRMhlD7QgAnBFUdfK5TfqWWoD9MKS0ylLZIdHQye0c9jBjnXmJrvRgSwwwqMGmli64hId3hXf65juiix1N/CA7Kl4SEWpYFMfZRnEyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ml1eOfci; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ipMSiLDK reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1717680896; x=1749216896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O3hYsokB6g9yjbSVd+FECl8ByMyjSc1GdXfnu8/iMsI=;
  b=ml1eOfciYhWnP80mOS4MHjAC9YAC+h0OvagEU4SlxL58GPtumPHbZflf
   m3eDJg/F9BO+Oc6jTVUzzxAYExGhaibS7a8KUXeujOOOF3QahYTX0vZ7T
   6V8duqHDCEKMLQySb54beqmxy/U3j26AEcFIfc0R9L3UdRNY/wd6bUEOP
   DEBXdsCJOqBYV2m5nzH1qrRtxICkFlkGx3rz5TemJRuQDFwDKJiXCYRE9
   RdgAcq2Ax8hbDOURANLawXf4I/FgBcvWrYAhyq6d0CYGrC8+ZAyT0Pz/7
   uYm1XMzu2ePio6QbQzW5E/X7Bk0210QDKNQRzGt56ozmP925LN8AYLzwH
   g==;
X-CSE-ConnectionGUID: yoShREV9TgqZmY6qnePSaw==
X-CSE-MsgGUID: tQSVBPAPQkS6XAOKDhkxXA==
X-IronPort-AV: E=Sophos;i="6.08,219,1712613600"; 
   d="scan'208";a="37263912"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 06 Jun 2024 15:34:48 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E763216E02E;
	Thu,  6 Jun 2024 15:34:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1717680883;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=O3hYsokB6g9yjbSVd+FECl8ByMyjSc1GdXfnu8/iMsI=;
	b=ipMSiLDKM0bcul7VycARroxu/EXpYbFvkR6uhCtgBGQY6GE8LZ5ec6m9lf+oxrPSQrK6uU
	WlJTjowqSP5OXGWjK/I54Llxi8xgIngIecazmedbB3Y1G3Qrr2gfKptMObUgffFjK1tOqc
	PTRa7F/AMFPvXM3zQHZCj+aLdU2EnFa5v6e1t6ocLIi+yPCNSYDlb2WWKqFzQ2mavRIQCp
	Vsf0SdFA/Bt8a6E+FjSGq6ptQLJ0g1mN4qg2H3Oj7TESae+8L+9LjvzfVC+pXL7V1T3NeJ
	VW0rQtmXWf5nFqXZyMcejtRQQLw6jzm6xRjnQIwHh7F4bcz7ggHVX9BW95w64Q==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/2] arm64: dts: imx8mp: Add imx8mp-specific irqsteer compatible
Date: Thu, 06 Jun 2024 15:34:42 +0200
Message-ID: <2690282.X9hSmTKtgW@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240528071141.92003-3-alexander.stein@ew.tq-group.com>
References: <20240528071141.92003-1-alexander.stein@ew.tq-group.com> <20240528071141.92003-3-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Am Dienstag, 28. Mai 2024, 09:11:41 CEST schrieb Alexander Stein:
> i.MX8MP irqsteer has power-domain support, so use a dedicated compatible.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/=
dts/freescale/imx8mp.dtsi
> index 8eb9f24007d00..fdaf7d5314384 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -1996,7 +1996,7 @@ hdmi_blk_ctrl: blk-ctrl@32fc0000 {
>  			};
> =20
>  			irqsteer_hdmi: interrupt-controller@32fc2000 {
> -				compatible =3D "fsl,imx-irqsteer";
> +				compatible =3D "fsl,imx8mp-irqsteer", "fsl,imx-irqsteer";
>  				reg =3D <0x32fc2000 0x1000>;
>  				interrupts =3D <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
>  				interrupt-controller;
>=20

Any feedback on this?
Thanks,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



