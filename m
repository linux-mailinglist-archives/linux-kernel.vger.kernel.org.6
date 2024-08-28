Return-Path: <linux-kernel+bounces-304555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645A89621C2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D525287628
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B90D15AAC1;
	Wed, 28 Aug 2024 07:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="BDKwDsyF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="MkpGsK4/"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD53A159596;
	Wed, 28 Aug 2024 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724831393; cv=none; b=fEwnYk34+zKFpnRbiKSDWDUR6jmcTUY/Tj9en1q7rpknPnE6NeZvdmZHJ49SD3jy73gXy6tdJjleJjfII91wFImh2B9u4af9Y53vJsWQfoGQjkLH0gVg+IJfAv7jKGFWOkFOqaNsIg4iuq+bJMjkE+joyag5md44D9UaaoQbL+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724831393; c=relaxed/simple;
	bh=Rv3qTmRUBeZwN6rhOjdvXGQsaHueyAzsFZN+jNQkhK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tt8AATP5NRa/jjEDBtDnblibc70ZpMoqTr+8a5GxmTMn5XuMMddJmeLolkvipVMMw/RPCJR6HAqmzmgmDR4l03CV6y6dwVTnYRyDDk6WUxSGx5cFlsKx7qtx7O++lWYuO0enTb9o2u1mxvHpG4l2I5xB8X/XQzRhue1H214GIJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=BDKwDsyF; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=MkpGsK4/ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1724831390; x=1756367390;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o/dgLyC7mY4Z5ZSkBhiWo3QczPmuWbYX1lDKIXDvn6s=;
  b=BDKwDsyF86XfrvCdQgHpT1q4DnvmudxmaLbiMIIf2AsF0IVviPthOb5F
   QBQkSjlx2s7lSBQ7Q0T8VvjD9mny92N3iBVclvAiFaxTYQvXXaphT2i5l
   FgOOrCujtdRVpFrXZEMvTZvU/if4HZfc69FfhiU8rHddEwdwC+s34YPj1
   OPJoyfG2RaM3GK7XyjCimz3Qzc+DA1a819XTBjQ5NZkvA95zdwh3e3pbk
   EmF5rAsfvM9kH5359ov+YZ68SDyCol6FpNAxI6fZcZG47U76u6FB7M7Tu
   rc1eU+/ML6adBwqfaCbMY0gdPeRFzL7g/zx3/llhdJMGur4MkyICg2/br
   A==;
X-CSE-ConnectionGUID: zcQljSgiTC+xTllxrQPQSA==
X-CSE-MsgGUID: XI7VxYhET8OWizceL+T+/A==
X-IronPort-AV: E=Sophos;i="6.10,182,1719871200"; 
   d="scan'208";a="38627529"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 28 Aug 2024 09:49:42 +0200
X-CheckPoint: {66CED695-2A-22BB8E18-F5F6D0B4}
X-MAIL-CPID: D2B6D901E25C8B78085EF8CCF03AB4BC_5
X-Control-Analysis: str=0001.0A782F1E.66CED696.0072,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B9FBD169E7B;
	Wed, 28 Aug 2024 09:49:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1724831377;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=o/dgLyC7mY4Z5ZSkBhiWo3QczPmuWbYX1lDKIXDvn6s=;
	b=MkpGsK4/qgFIErJorzcI/O8lEPRTQVC3e6Ue7BmxnYHfPebKZb+yaofpHJbL7fAHBb4dyq
	kSNdEBq9H2t3vC7pht715ON3uDnkFFUbB9O/hoPJW4k+Jw5YVBHQurjVTBMlLBznpOcSTV
	pAVk9sN9+GTOIuaOf6NZv3lum82HI0BpfUu7MzgIDLd6zWfKh29t/4orUWynbZrUYhbC0M
	rRt7F5MnSX7rQi1NhcK77cdVilHdJbv+u1uZbsRMuYjt3GA/tQF6vJhqvMpoJgWDPwf/DB
	9euwkZVjWzzbIlr59LVopmH4aUGzh84i8wp0cVv3MtFKZS/USAb3KkiWr9oJbA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
Cc: linux@ew.tq-group.com, devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ARM: dts: imx6qdl: Add reserved memory area for CMA memory
Date: Wed, 28 Aug 2024 09:49:36 +0200
Message-ID: <10526262.nUPlyArG6x@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240827142458.265558-1-alexander.stein@ew.tq-group.com>
References: <20240827142458.265558-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Am Dienstag, 27. August 2024, 16:24:58 CEST schrieb Alexander Stein:
> Default CMA size is too small for HDMI output and VPU usage. Increase the
> default size by providing a CMA memory area.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> Smallest RAM variant has 512MiB.
>=20
>  arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi b/arch/arm/boot/=
dts/nxp/imx/imx6qdl-mba6.dtsi
> index d03f7065ddfd7..8ba3ec27bee07 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi
> @@ -106,6 +106,20 @@ reg_vcc3v3_audio: regulator-vcc3v3-audio {
>  		vin-supply =3D <&reg_mba6_3p3v>;
>  	};
> =20
> +	reserved-memory {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		ranges;
> +
> +		linux,cma {
> +			compatible =3D "shared-dma-pool";
> +			reusable;
> +			size =3D <0x14000000>;
> +			alloc-ranges =3D <0x10000000 0x20000000>;
> +			linux,cma-default;
> +		};
> +	};
> +

Please do not merge yet.
I just noticed that this breaks mmap'ed fbdev usage. It only works when CMA
area is in HighMem.

Best regards,
Alexander

>  	sound {
>  		compatible =3D "fsl,imx-audio-tlv320aic32x4";
>  		pinctrl-names =3D "default";
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



