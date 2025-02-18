Return-Path: <linux-kernel+bounces-519672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25080A3A08A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA257165641
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CD226A1BF;
	Tue, 18 Feb 2025 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="yCHNif8/"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E243314E2E2;
	Tue, 18 Feb 2025 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890403; cv=none; b=sb1SCpQR1B3OEtKadwIZbyoyF2Zg95bpAeLyNKwoxbZmiaJG//UBjWIhlcKainoeEptoAsA+hL+6imfyf9jyjMxKrKdcu6x9JU4/U5ajAFkfVQ+b7RX0IkWLdjLi6FJ+M06WLO2BMkjuF2qV1fA4zIDNSlgx1qLkBT39KN2wkSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890403; c=relaxed/simple;
	bh=P+7QJZdrIn/7rh4swmav3TwczRr2A3EEHX94fKIyyiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJ4/QChVHNIIU9COZak/6g597wFtLSp80geGpsUiy7OQSdNowP3fZ2FI7FEXl1Wp+dFE9CJOnHS7D0vmegzfixa5vAkapLfsJF/D338rZN26sWIonE77Iyk43NQXzZ7+5Vv5ie48r9i8tbWYLyYmhVc3vT/t3b6dvMneCFf6UG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=yCHNif8/; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0vWS+jJLGaUznhkUfulRmF74wnw6+simbpz7/+3zlNU=; b=yCHNif8/OzKbJ8qOOHLZC7ehTA
	zdS8Ay0sBcb8JU2WO/UQqqsK68gdfuNU0GOadhvfFzsvvbJjgwWUmCPjoLBXYXVCfWkAClMQ2hCMv
	PdJk1AYucpPORfkt3caFGB1hO1/Ovl8P1W76OSLXbFRg+M0bSYTBSMcERhZDq2L5JXKU6AM/yoWUU
	uTEM13NnKraf0E1QhGoPLP8LWNWELxhHs2WsPUkU9IuxgXJeHVDfBeueJ58YMIcabdv8YFa0LEgO0
	6BUKBEGgN2ODQLuuVe4eto3M4Ba5Xjz4DZ7My9cqydE6khcMBrsiN1XNbTA8LYu8hQEmet7cmoGAW
	R4NEnpzg==;
Received: from i53875bc0.versanet.de ([83.135.91.192] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tkOyB-0005uw-A9; Tue, 18 Feb 2025 15:53:07 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Jianfeng Liu <liujianfeng1994@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: airlied@gmail.com, andy.yan@rock-chips.com, conor+dt@kernel.org,
 cristian.ciocaltea@collabora.com, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, hjc@rock-chips.com, kernel@collabora.com,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, robh@kernel.org,
 simona@ffwll.ch, tzimmermann@suse.de
Subject:
 Re: [PATCH 3/4] arm64: dts: rockchip: Add HDMI1 PHY PLL clock source to VOP2
 on RK3588
Date: Tue, 18 Feb 2025 15:53:06 +0100
Message-ID: <2425191.NG923GbCHz@diego>
In-Reply-To: <lnuceofdwm6lgibworaghcujp6rrncvn4e2xc2vzltimjw3rqu@jur7x5cxt5ue>
References:
 <1919367.CQOukoFCf9@diego>
 <20250218121749.1382322-1-liujianfeng1994@gmail.com>
 <lnuceofdwm6lgibworaghcujp6rrncvn4e2xc2vzltimjw3rqu@jur7x5cxt5ue>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 18. Februar 2025, 15:13:07 MEZ schrieb Sebastian Reichel:
> Hi,
>=20
> On Tue, Feb 18, 2025 at 08:17:46PM +0800, Jianfeng Liu wrote:
> > On Tue, 18 Feb 2025 11:00:57 +0100, Heiko St=C3=BCbnerwrote:
> > >So I guess step1, check what error is actually returned.
> >=20
> > I have checked that the return value is -517:
> >=20
> > rockchip-drm display-subsystem: [drm] *ERROR* failed to get pll_hdmiphy=
1 with -517
> >=20
> > >Step2 check if clk_get_optional need to be adapted or alternatively
> > >catch the error in the vop2 and set the clock to NULL ourself in that =
case.
> >=20
> > I tried the following patch to set the clock to NULL when clk_get_optio=
nal
> > failed with value -517, and hdmi0 is working now. There are also some
> > boards like rock 5 itx which only use hdmi1, I think we should also add
> > this logic to vop2->pll_hdmiphy0.
> >=20
> > @@ -3733,6 +3751,15 @@ static int vop2_bind(struct device *dev, struct =
device *master, void *data)
> >  		return PTR_ERR(vop2->pll_hdmiphy0);
> >  	}
> > =20
> > +	vop2->pll_hdmiphy1 =3D devm_clk_get_optional(vop2->dev, "pll_hdmiphy1=
");
> > +	if (IS_ERR(vop2->pll_hdmiphy1)) {
> > +		drm_err(vop2->drm, "failed to get pll_hdmiphy1 with %d\n", vop2->pll=
_hdmiphy1);
> > +		if (vop2->pll_hdmiphy1 =3D=3D -EPROBE_DEFER)
> > +			vop2->pll_hdmiphy1 =3D NULL;
> > +		else
> > +			return PTR_ERR(vop2->pll_hdmiphy1);
> > +	}
> > +
>=20
> This first of all shows, that we should replace drm_err in this
> place with dev_err_probe(), which hides -EPROBE_DEFER errors by
> default and instead captures the reason for /sys/kernel/debug/devices_def=
erred.
>=20
> Second what you are doing in the above suggestion will break kernel
> configurations where VOP is built-in and the HDMI PHY is build as a
> module.
>=20
> But I also think it would be better to have the clocks defined in the
> SoC level DT. I suppose that means vop2_bind would have to check if
> the HDMI controller <ID> is enabled and only requests pll_hdmiphy<ID>
> based on that. Considering there is the OF graph pointing from VOP
> to the enabled HDMI controllers, it should be able to do that.


I was more thinking about fixing the correct thing, with something like:

=2D---------- 8< ----------
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index cf7720b9172f..50faafbf5dda 100644
=2D-- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -5258,6 +5258,10 @@ of_clk_get_hw_from_clkspec(struct of_phandle_args *c=
lkspec)
        if (!clkspec)
                return ERR_PTR(-EINVAL);

+       /* Check if node in clkspec is in disabled/fail state */
+       if (!of_device_is_available(clkspec->np))
+               return ERR_PTR(-ENOENT);
+
        mutex_lock(&of_clk_mutex);
        list_for_each_entry(provider, &of_clk_providers, link) {
                if (provider->node =3D=3D clkspec->np) {
=2D---------- 8< ----------

Because right now the clk framework does not handle nodes in
failed/disabled state and would defer indefinitly.




