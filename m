Return-Path: <linux-kernel+bounces-315407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0325896C238
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B891C243C6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721951DEFC1;
	Wed,  4 Sep 2024 15:25:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56011DCB30;
	Wed,  4 Sep 2024 15:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463543; cv=none; b=nCyI7GKBmEvbxZ2b+E+4GaPsQ35j+rdkdJQRh9Cdw3Hbq1C8NdykUhouRrYlpMqJYnp7hOrDmilYwKAChPd3TWTuthpluOCmJSVMo+ewT0g5Z+4KvwRmRy4eKGFdXkTeSIZTw/i2qIu/v+SmNx3EVwo+/b9060ULmn50pTkgwgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463543; c=relaxed/simple;
	bh=ifxgjEccOr8RkbLDnBKxwD6q3g/9xI4LSU9D/3sJLuc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=raIzWaWmZu6+zYMBzWrssYXFEa3pT6CZ82gBdOFUpcRsvUhWvEdq5FObLX94HtQePB1UjEH8KvparXqqVpi3xKVQSbCYnyTE/U0rfSprutPcd8ht89FHC+t7X3afrynInVgq9tJSHizxhYw8fsyeNU+D7PhnAIR2wFiFU6sYEOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4D50FEC;
	Wed,  4 Sep 2024 08:26:05 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 171273F73F;
	Wed,  4 Sep 2024 08:25:37 -0700 (PDT)
Date: Wed, 4 Sep 2024 16:25:35 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: =?UTF-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] Add vqmmc-supply on NanoPi NEO Plus2
Message-ID: <20240904162535.48640243@donnerap.manchester.arm.com>
In-Reply-To: <20240827-nanopi-neo-plus2-regfix-v2-3-497684ec82c7@gmail.com>
References: <20240827-nanopi-neo-plus2-regfix-v2-0-497684ec82c7@gmail.com>
	<20240827-nanopi-neo-plus2-regfix-v2-3-497684ec82c7@gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Aug 2024 23:00:45 +0200
Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com> wrote:

> Adds missing vqmmc-supply for mmc2.

Does that patch actually fix anything? Does the kernel complain about the
missing vqmmc regulator?
I am asking because I wonder if we need this patch in the first place. The
generic MMC DT binding marks the vqmmc property as optional.

So I appreciate the idea of making everything neat and tidy, but after all
we have little actual proof that the voltage is really 3.3V, so I'd just
leave it as it is.

Cheers,
Andre

>=20
> Signed-off-by: Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts=
 b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
> index 526443bb736c..609560a9d6dc 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
> @@ -157,6 +157,7 @@ &mmc2 {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&mmc2_8bit_pins>;
>  	vmmc-supply =3D <&reg_vcc3v3>;
> +	vqmmc-supply =3D <&reg_vcc3v3>;
>  	bus-width =3D <8>;
>  	non-removable;
>  	cap-mmc-hw-reset;
>=20


