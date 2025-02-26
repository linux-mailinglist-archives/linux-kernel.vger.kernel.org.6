Return-Path: <linux-kernel+bounces-534356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A756AA46604
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A33E19E0976
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5E121CA1A;
	Wed, 26 Feb 2025 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="tiHog+I2"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85A821CA09
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585234; cv=none; b=QvmF1Ix/Gx+rYzlVAJbwANO2znUeTXf+sDuLdBFYRUIBrKHiQejQBKc/iu3ywEatgPzn2TuH302EbYAgh8X/RKHMARSzCt/DXafxVJ3nwU/3D2DE67Cu9W9Y5KabU+JOINxDXEqQ7DpmMJKBJ6PhtQduDxjl9cTaXUFjYwmpYCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585234; c=relaxed/simple;
	bh=ACP8bz47YGTzKqzNwMzMejjC9YzYSJC526Xi7vesKBM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9jdstwK85z1pvQs8XgeBoKTvMQFXqD9IjxeMDuKkQiClSB2nm09MtKpMBVUoU8OyUhXmmXuh4vfQRcSk0GpjEMHimODMRo5oafLZKF2Ca94DeOhAL57T2SVrW36DfRC9IOwL55gZQnWUuK8YcH/gs7S8SE03PWtnuF/FAD7ouM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=tiHog+I2; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Sp2RArpH+SxqIvNipgdR8UTH8wCQ4VMdPZhhVAjR59Q=; b=tiHog+I26s/LWX4WCV9x/RGYhw
	HswqddxSRwDVM8cALeNQ12xrX03BBlHKh08VP/8QZG48SCUtBdR1//NT40ic6a73gNbgUqt1kafi0
	ph8mV6VD/8QAa5Ab59TnnaMF52mnKx9qnKanZ9gZqaG4HEW7ci5vEUf2Zz5Ej9dd/MxH98Revgk2q
	1aGgrjTcEz30XpxrQa17d+fMx6EDqvh7FbOwlyRM+kMSNGG1ZFFey8OkJUGVnVs4VByc0N6fe6pbh
	teGYkhKCPoiqCwmKOW3gvw5JEUJR/fIS7BDoMEkIxs1aa2ef4Lsfr27nZvMghozTlqN7cHZvo4jcO
	4tE/+yMw==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tnJjG-0001Ve-KY; Wed, 26 Feb 2025 16:53:46 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: =?UTF-8?B?T25kxZllag==?= Jirman <megi@xff.cz>,
 Heiko Stuebner <heiko@sntech.de>, vkoul@kernel.org, kishon@kernel.org,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 quentin.schulz@cherry.de, sebastian.reichel@collabora.com,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Subject:
 Re: [PATCH 2/2] phy: rockchip: usbdp: re-init the phy on orientation-change
Date: Wed, 26 Feb 2025 16:53:45 +0100
Message-ID: <1878927.BzM5BlMlMQ@diego>
In-Reply-To: <7q5yn466xd7emebhjze4ixkswgyxjjjt5rwvyww2hwbts6bamd@i5vwvegy2os6>
References:
 <20250225184519.3586926-1-heiko@sntech.de>
 <20250225184519.3586926-3-heiko@sntech.de>
 <7q5yn466xd7emebhjze4ixkswgyxjjjt5rwvyww2hwbts6bamd@i5vwvegy2os6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hey Ond=C5=99ej,

Am Mittwoch, 26. Februar 2025, 15:46:11 MEZ schrieb Ond=C5=99ej Jirman:
> On Tue, Feb 25, 2025 at 07:45:19PM +0100, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@cherry.de>
> >=20
> > Until now the usbdp in the orientation-handler set the new lane setup in
> > its internal state variables and adapted the sbu gpios as needed.
> > It never actually updated the phy itself though, but relied on the
> > controlling usb-controller to disable and re-enable the phy.
> >=20
> > And while on the vendor-kernel, I could see that on every unplug the dw=
c3
> > did go to its suspend and woke up on the next device plug-in event,
> > thus toggling the phy as needed, this does not happen in all cases and =
we
> > should not rely on that behaviour.
>=20
> On RK3399 there's a similar issue with the equivalent type-c PHY driver.
> The TRM (part 2) states that:
>=20
> 4.6.1 Some Special Settings before Initialization
>=20
> - Set USB3.0 OTG controller AXI master setting.
> - Clear USB2.0 only mode setting (bit 3 of register GRF_USB3PHY0/1_CON0 i=
n Chapter GRF)
> - USB3.0 OTG controller should be hold in reset during the initialization=
 of the corresponding
>   TypeC PHY until TypeC PHY is ready for USB operation.
> - Set PHYIF to 1 to use 16-bit UTMI+ interface (see register GUSB2PHYCFG0)
> - Clear ENBLSLPM to 0 to disable sleep and l1 suspend (see register GUSB2=
PHYCFG0)
>   ...
>=20
> The PHY for Superspeed signals is expected to be set up while the USB
> controller is held in reset, which makes sense HW wise, and it's what dow=
nstream
> kernel efectivelly does, via its RPM based hack.
>=20
> RK3588 TRM doesn't have very detailed notes on this, but I expect it will=
 be
> similar.
>=20
> So reconfiguring the phy here, while it's actively linked to the USB cont=
roller
> without the controller driver driving the process so it reliably happens =
while
> it's in reset, or at least so that USB controller reset happens afterward=
s, may
> not be correct way to approach this.

the function here, is using infrastructure from the type-c framework.

The function in question tcpm_mux_set(), which then ends up in the
usbdp_phy only gets called from tcpm_reset_port() .

Which I think will do the right already - judging by its name ;-) .
[and also by the fact that the referenced qcom phy behaves similarly
 when talking to the type-c framework]


=46or the rk3399 I would think converting the old typec-phy-driver over to
use the actual kernel type-c framework, might just magically solve the
issue you have on it.

Rockchip actually has converted the rk3399 typec-phy to use the type-c
framework in their vendor kernel.


Heiko



