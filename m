Return-Path: <linux-kernel+bounces-362460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2673399B545
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 16:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCFD31F225E3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 14:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C39189B8F;
	Sat, 12 Oct 2024 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="zZyBVo6B"
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705CA149DF0;
	Sat, 12 Oct 2024 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728741633; cv=none; b=FKfOOxPPTWxGtWv6DrIJSv+YOoHoU6CSATHYEG1vdiGpj7HAoMd/q9Yj9j+7MpnRyYraeD2Bzz4d9GpRx1Qq82kJPtGKTXOTR+jttrZtRnxxYhaJ1z1iflJT/0HJcmPq6WHaZ/W/T0CTjgSa98Wxj8n00Q8NZbcRu+7OQwCPya8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728741633; c=relaxed/simple;
	bh=Oko5pEJSjCqvkp/hXyJplBKuu7k81GI8vfiRbw3SQBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiEJsYKx0bzsx9slHvdorocsDWWy3yjWMBZ91MvUCKbwSeeU9f1N3Q3iazymlGpB+TU4XD111tAct8dasDwY3ewln/mZbgTtq94DNyZ/b63QXcLHd8ErlSG/ea60mXMx7qjP7Hkecv5eKHsouU+7Ch1tgut1FXQ6EojZPgNElSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=zZyBVo6B; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=86LUFeiSctauCmIBlqHrJmZxrAIYPqEdqsSwFAfU0sE=; b=zZyBVo6BMQP1cuNJ6PGdOOkOVo
	ypvs/AkLg6J+QUOI6bBBIAxsFKMy1cfReTMN6clE7w0+77K4uGRINpQQfUGAAt2qqg/S5zunkUHh6
	uwsrsThwmHi/OsUz/w5E0TaWs+jfgyoTPWpVTHTH/2Xtwd5cxwUjUvR4M+UUJMZif/9p98mLAs+9G
	Fa8Z88v1Io4Ir1/1Pbe4AfOz+UFIGK7yT+ZGtbJl+/Xpn/g7pasfUzPJn9CFuV1mL949km3xx42VX
	ED6524KlLqGBqX39OOWN3q1ABwJMSkzxg7Fcy4aCa06yP8ebAAEHWsyHA/dbsrbeY2X/Pe+ZgUJ4b
	Ayo0vBAQ==;
Received: from ohm.aurel32.net ([2001:bc8:30d7:111::2] helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1szcBV-000lVG-0Q;
	Sat, 12 Oct 2024 15:29:29 +0200
Date: Sat, 12 Oct 2024 15:29:28 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Jack Zhu <jack.zhu@starfivetech.com>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	E Shattow <lucent@gmail.com>
Subject: Re: [v3] riscv: dts: starfive: jh7110: Add camera subsystem nodes
Message-ID: <Zwp5uFiGqxQa-yC9@aurel32.net>
Mail-Followup-To: Changhuang Liang <changhuang.liang@starfivetech.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jack Zhu <jack.zhu@starfivetech.com>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	E Shattow <lucent@gmail.com>
References: <20240219032741.18387-1-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240219032741.18387-1-changhuang.liang@starfivetech.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

Hi,

On 2024-02-18 19:27, Changhuang Liang wrote:
> Add camera subsystem nodes for the StarFive JH7110 SoC. They contain the
> dphy-rx, csi2rx, camss nodes.
>=20
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  .../jh7110-starfive-visionfive-2.dtsi         | 49 ++++++++++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 67 +++++++++++++++++++
>  2 files changed, 116 insertions(+)

We have been asked to enable CONFIG_VIDEO_STARFIVE_CAMSS in the Debian
kernel, which from my understanding and given the device tree shown
below also requires enabling CONFIG_VIDEO_CADENCE_CSI2RX. That said
doing so triggers the following error in dmesg:

[   25.143282] cdns-csi2rx 19800000.csi: probe with driver cdns-csi2rx fail=
ed with error -22

=46rom a quick look it seems there is something in the port@0 csi2rx
entry. Do you happen to know what is wrong?

Thanks
Aurelien

> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dt=
si b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index b89e9791efa7..737ee97a3577 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -125,6 +125,55 @@ &tdm_ext {
>  	clock-frequency =3D <49152000>;
>  };
>=20
> +&camss {
> +	assigned-clocks =3D <&ispcrg JH7110_ISPCLK_DOM4_APB_FUNC>,
> +			  <&ispcrg JH7110_ISPCLK_MIPI_RX0_PXL>;
> +	assigned-clock-rates =3D <49500000>, <198000000>;
> +	status =3D "okay";
> +
> +	ports {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		port@0 {
> +			reg =3D <0>;
> +		};
> +
> +		port@1 {
> +			reg =3D <1>;
> +
> +			camss_from_csi2rx: endpoint {
> +				remote-endpoint =3D <&csi2rx_to_camss>;
> +			};
> +		};
> +	};
> +};
> +
> +&csi2rx {
> +	assigned-clocks =3D <&ispcrg JH7110_ISPCLK_VIN_SYS>;
> +	assigned-clock-rates =3D <297000000>;
> +	status =3D "okay";
> +
> +	ports {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		port@0 {
> +			reg =3D <0>;
> +
> +			/* remote MIPI sensor endpoint */
> +		};
> +
> +		port@1 {
> +			reg =3D <1>;
> +
> +			csi2rx_to_camss: endpoint {
> +				remote-endpoint =3D <&camss_from_csi2rx>;
> +			};
> +		};
> +	};
> +};
> +
>  &gmac0 {
>  	phy-handle =3D <&phy0>;
>  	phy-mode =3D "rgmii-id";
=20

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

