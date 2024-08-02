Return-Path: <linux-kernel+bounces-273138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0359464E1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E4921C21CEE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21222770F9;
	Fri,  2 Aug 2024 21:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MdBNH8K2"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54538131E2D;
	Fri,  2 Aug 2024 21:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722633007; cv=none; b=CXsFYX2vnSuEz74M2Z3FyMWZc1kxpuTyap28W+egfi6InMimAg1a+vSoUGx+nkx8KJmiy45ZKY/IAitVE4+Z9Ann8IBQSMME/M8oRa1YQKIj2g6vgh0h+9cUEilkooQCCiNxusx+lt+IyW6nxWVP3+ObTZnftEFCQXhsJp6bVR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722633007; c=relaxed/simple;
	bh=9dKMte5AFbMCPQcb5CrWmFpJYPJ6uvTEhFLt0GaO98w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t3hu/Ra1wbjX0VlP0yAVwStJVD6oF18Pw73wVzLaFboeov5aat+qBCGagqewBtuyInlj6rypjanOkt08yspsFQAkbizGIsCHo6besIqftbVctLxmkVOWZKL/Ocl9fMl6pD5P4cJxuv+n/Q4e6yFjSojq3V7QEW0UKAJwn1p+B+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MdBNH8K2; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722633003;
	bh=9dKMte5AFbMCPQcb5CrWmFpJYPJ6uvTEhFLt0GaO98w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MdBNH8K2NbSu7puBPIhq9BT+s8UodLsfqUuytnQE9ngLkHKqWrndo8AqdgDEALFJ1
	 F21lcjmTHZDtFFj8aK9vG6578iFD3r4Q/3sWIekd7/KIU8N72B/EdVr8DGP+3Qb0FY
	 d32IhXbsBWzWsrO8WM1pCPIpia5CkIbb1zaKZ+1crv1KPgmGIJ+wYeszRNrbKfvIYt
	 XArxZtNaijg4BGgPklQKOXa3JPycs32d9xTjH4wdHSg54rg6TnlKJAqugsEFnsNq/L
	 +Nql8GU376VHotpO8BGbvC8acb8gACRzncNRUxHWGV3xdJzz898D2VRMGBvWYD2sUF
	 Kv5YAgQuJCusw==
Received: from trenzalore.localnet (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 909C53782218;
	Fri,  2 Aug 2024 21:10:01 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org,
 Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Elaine Zhang <zhangqing@rock-chips.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, Sugar Zhang <sugar.zhang@rock-chips.com>,
 kernel@collabora.com
Subject: Re: [PATCH 2/3] clk: rockchip: Add dt-binding header for rk3576
Date: Fri, 02 Aug 2024 17:11:09 -0400
Message-ID: <3308850.44csPzL39Z@trenzalore>
In-Reply-To: <4084310.iTQEcLzFEP@diego>
References:
 <20240802141816.288337-1-detlev.casanova@collabora.com>
 <20240802141816.288337-3-detlev.casanova@collabora.com>
 <4084310.iTQEcLzFEP@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Heiko,

On Friday, 2 August 2024 10:34:07 EDT Heiko St=C3=BCbner wrote:
> Hi Detlev,
>=20
> Am Freitag, 2. August 2024, 16:12:49 CEST schrieb Detlev Casanova:
> > From: Elaine Zhang <zhangqing@rock-chips.com>
> >=20
> > Add the dt-bindings header for the rk3576, that gets shared between
> > the clock controller and the clock references in the dts.
> >=20
> > Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> > Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > ---
> >=20
> >  .../dt-bindings/clock/rockchip,rk3576-cru.h   | 1149 +++++++++++++++++
> >  1 file changed, 1149 insertions(+)
> >  create mode 100644 include/dt-bindings/clock/rockchip,rk3576-cru.h
> >=20
> > diff --git a/include/dt-bindings/clock/rockchip,rk3576-cru.h
> > b/include/dt-bindings/clock/rockchip,rk3576-cru.h new file mode 100644
> > index 0000000000000..19d25f082dc57
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/rockchip,rk3576-cru.h
> > @@ -0,0 +1,1149 @@
> >=20
> > +#define CLK_NR_CLKS			(ACLK_KLAD + 1)
>=20
> this needs to go please. Take a look at how Sebastian got rid of needed
> that max-constant for rk3588.

Oh indeed, that looks better, I'll port it to using the same functions as i=
n=20
rk3588.

I'll also separate clocks and resets as done in rk3588 and improve the list=
ing=20
of those resets as in rst-rk3588.c

> [...]
>=20
> > +#define SRST_H_VEPU1			1267
> > +#define SRST_A_VEPU1			1268
> > +#define SRST_VEPU1_CORE			1269
> > +
> > +/********Name=3DPHPPHYSOFTRST_CON00,Offset=3D0x8A00********/
> > +#define SRST_P_PHPPHY_CRU		131073
> > +#define SRST_P_APB2ASB_SLV_CHIP_TOP	131075
> > +#define SRST_P_PCIE2_COMBOPHY0		131077
> > +#define SRST_P_PCIE2_COMBOPHY0_GRF	131078
> > +#define SRST_P_PCIE2_COMBOPHY1		131079
> > +#define SRST_P_PCIE2_COMBOPHY1_GRF	131080
>=20
> this seems to lump together different components and with that creates
> these gaps. I.e. I really don't think the phpphy in these registers is pa=
rt
> of the core CRU.
>=20
> That huge memory length of 0x5c000 in your dt-binding is also a good
> indicator that this needs to have more separation and not span multiple
> devices.

It is not really clear if those are different devices, but they can possibl=
y be=20
seen as different instances of the same device. I'll just remove those extr=
a=20
resets for now and add them with the correct device when support is=20
implemented.

> > +/********Name=3DPHPPHYSOFTRST_CON01,Offset=3D0x8A04********/
> > +#define SRST_PCIE0_PIPE_PHY		131093
> > +#define SRST_PCIE1_PIPE_PHY		131096
> > +
> > +/********Name=3DSECURENSSOFTRST_CON00,Offset=3D0x10A00********/
> > +#define SRST_H_CRYPTO_NS		262147
> > +#define SRST_H_TRNG_NS			262148
> > +#define SRST_P_OTPC_NS			262152
> > +#define SRST_OTPC_NS			262153
> > +
> > +/********Name=3DPMU1SOFTRST_CON00,Offset=3D0x20A00********/
> > +#define SRST_P_HDPTX_GRF		524288
>=20
> same here, that is also most likely not part of the CRU but a different
> block. Other socs already implement separate clock controllers for
> different parts, so please take a look there.

Let's add those resets when the device they are linked to is actually=20
supported then.

> Thanks
> Heiko

Regards,
Detlev.





