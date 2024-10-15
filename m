Return-Path: <linux-kernel+bounces-365380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A5499E17A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7C75B227FB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686601CF7AA;
	Tue, 15 Oct 2024 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="OAP9RAR6"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4854B1C3F0A;
	Tue, 15 Oct 2024 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982050; cv=none; b=FqGZvYERVX+jmoLJKRExOE7qK4hAsSaVAD+Fxk2Uz3wnso5zurIAiRUiSx+oUKTc1WZiBmyNxk/f5nMr1MRDfdFUT0qUpWmjCR8GTQoFOe7hSb6xko+VWPgSSI3CxyUHciZG6fgrPZ4/aNILF/LwkKYdg07qEZxfyP/Fq2ebmGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982050; c=relaxed/simple;
	bh=DnIc4xM2zJ+Fy6DQgI0gV5Of6HlbyLsvO0xNd1WYuqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6G3BIDXAkxkDS2EmfEK9pjskf1ESIWcDB+8NB4GSHRxgkRYllYL4TKBiYAe9xhnuEF1h481dxWx/cBYNql8Wa/5tcfDdCChujDUHZYf9jVBr2uNsosK8yyV7izl8tJHqKzs6jjqATDA6DwoeVL/BcWKEAwHMm1MJFsVfxAZMyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=OAP9RAR6; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vpyNKncwLHQJiPMjN9dAouFfUchGeFmb6bGSak7LW2g=; b=OAP9RAR6SKFYIB8O4nUEdjkmAo
	X/KuYnRtEKUT8IoebiLtMthdIVBq9ZFt4TR8FwWTEDSsv9xD0yoRSqv+Y8KhdWz+5u6kG5QnyYdyR
	CCdnG1IiRAWMlDZVYN8pk2T1Fw6DVAOlLFNjq7eNuwq2HDqOcoY8Qc4oR8iU3oxA9yI84nlYpgkXu
	4PNQaRigXOo9stQUxFvwhjSq3L5LiwJeXnpX1sFyPfLHBB/50so58CKtDamMppyzl3U/nYoaf6d28
	nqxkmLwOHmIGf4RAQLoblbB8HBKab9eqvafQBADn/XRyRvnKnKBD9UquC+3JTD83QTQ5kXXmkAaI4
	tNNQrFdA==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t0dDA-00084I-8r; Tue, 15 Oct 2024 10:47:24 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Frank Wang <frawang.cn@gmail.com>,
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: shawn.lin@rock-chips.com, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 william.wu@rock-chips.com, tim.chen@rock-chips.com,
 Kever Yang <kever.yang@rock-chips.com>,
 Frank Wang <frank.wang@rock-chips.com>
Subject: Re: [PATCH 2/2] phy: rockchip-naneng-combo: Support rk3576
Date: Tue, 15 Oct 2024 10:47:23 +0200
Message-ID: <1904911.CQOukoFCf9@diego>
In-Reply-To: <aac59920-db0b-4b3a-af1b-58e8e4d3a08b@rock-chips.com>
References:
 <20241015013351.4884-1-frawang.cn@gmail.com> <1981070.PYKUYFuaPT@diego>
 <aac59920-db0b-4b3a-af1b-58e8e4d3a08b@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi Shawn,

Am Dienstag, 15. Oktober 2024, 10:39:28 CEST schrieb Shawn Lin:
> =E5=9C=A8 2024/10/15 14:15, Heiko St=C3=BCbner =E5=86=99=E9=81=93:
> > Am Dienstag, 15. Oktober 2024, 03:33:51 CEST schrieb Frank Wang:
> >> From: Kever Yang <kever.yang@rock-chips.com>
> >>
>=20
> ...
>=20
> >> +			writel(0x02, priv->mmio + (0xb << 2));
> >> +			writel(0x57, priv->mmio + (0xd << 2));
> >> +
> >> +			writel(0x5f, priv->mmio + (0xf << 2));
> >=20
> > This does includes both the value as well as the register addresses,
> > because a hex-value with a bit shift makes that even less readable.
> >=20
>=20
> Actually, it's more readable when we need to debug, IMO. Because the
> PHY document provided is listing the registers just like what the patch
> did(0xb/0xd/0xf). So for example, we could easily find 0xb in the=20
> document, which refers to su_trim[15:8].

Documentation-wise the rk3576 has gotten worse, compared to the
rk3588 and before.  I guess you're refering to a document that is not
part of the trm-part1 pdf I guess.

So I guess using register numbers somewhat matching the sparse
document you have can be fine, but I guess try to use constants where
possible.

The block above though at least needs a comment about what is
happening there.


Heiko

> >> +		}
> >> +		break;
> >> +	case REF_CLOCK_25MHz:
> >> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_25m, tru=
e);
> >> +		break;
> >> +	case REF_CLOCK_100MHz:
> >> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_100m, tr=
ue);
> >> +		if (priv->type =3D=3D PHY_TYPE_PCIE) {
> >> +			/* gate_tx_pck_sel length select work for L1SS */
> >> +			writel(0xc0, priv->mmio + 0x74);
> >> +
> >> +			/* PLL KVCO tuning fine */
> >> +			rockchip_combphy_updatel(priv, GENMASK(4, 2), 0x4 << 2, 0x20 << 2);
> >> +
> >> +			/* Set up rx_trim: PLL LPF C1 85pf R1 1.25kohm */
> >> +			writel(0x4c, priv->mmio + (0x1b << 2));
> >> +
> >> +			/* Set up su_trim: T3_P1 650mv */
> >> +			writel(0x90, priv->mmio + (0xa << 2));
> >> +			writel(0x43, priv->mmio + (0xb << 2));
> >> +			writel(0x88, priv->mmio + (0xc << 2));
> >> +			writel(0x56, priv->mmio + (0xd << 2));
> >> +		} else if (priv->type =3D=3D PHY_TYPE_SATA) {
> >> +			/* downward spread spectrum +500ppm */
> >> +			rockchip_combphy_updatel(priv, GENMASK(7, 4), 0x50, 0x1f << 2);
> >> +
> >> +			/* ssc ppm adjust to 3500ppm */
> >> +			rockchip_combphy_updatel(priv, GENMASK(3, 0), 0x7, 0x9 << 2);
> >> +		}
> >> +		break;
> >> +	default:
> >> +		dev_err(priv->dev, "Unsupported rate: %lu\n", rate);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	if (priv->ext_refclk) {
> >> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_ext, tru=
e);
> >> +		if (priv->type =3D=3D PHY_TYPE_PCIE && rate =3D=3D REF_CLOCK_100MHz=
) {
> >> +			writel(0x10, priv->mmio + (0x20 << 2));
> >> +
> >> +			writel(0x0c, priv->mmio + (0x1b << 2));
> >> +
> >> +			/* Set up su_trim: T3_P1 650mv */
> >> +			writel(0x90, priv->mmio + (0xa << 2));
> >> +			writel(0x43, priv->mmio + (0xb << 2));
> >> +			writel(0x88, priv->mmio + (0xc << 2));
> >> +			writel(0x56, priv->mmio + (0xd << 2));
> >> +		}
> >> +	}
> >> +
> >> +	if (priv->enable_ssc) {
> >> +		rockchip_combphy_updatel(priv, GENMASK(4, 4), BIT(4), 0x7 << 2);
> >> +
> >> +		if (priv->type =3D=3D PHY_TYPE_PCIE && rate =3D=3D REF_CLOCK_24MHz)=
 {
> >> +			/* Xin24M T0_1 650mV */
> >> +			writel(0x00, priv->mmio + (0x10 << 2));
> >> +			writel(0x32, priv->mmio + (0x11 << 2));
> >> +			writel(0x00, priv->mmio + (0x1b << 2));
> >> +			writel(0x90, priv->mmio + (0x0a << 2));
> >> +			writel(0x02, priv->mmio + (0x0b << 2));
> >> +			writel(0x08, priv->mmio + (0x0c << 2));
> >> +			writel(0x57, priv->mmio + (0x0d << 2));
> >> +			writel(0x40, priv->mmio + (0x0e << 2));
> >> +			writel(0x5f, priv->mmio + (0x0f << 2));
> >> +			writel(0x10, priv->mmio + (0x20 << 2));
> >> +		}
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >=20
> >=20
> >=20
> >=20
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
>=20
>=20





