Return-Path: <linux-kernel+bounces-545614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE862A4EF4C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6D2188DB58
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB9424EAAA;
	Tue,  4 Mar 2025 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="2lT3k8ic"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4BA42AAF;
	Tue,  4 Mar 2025 21:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741123016; cv=none; b=M4Rvt6h+ItlXYzWv+jeEP5DER27fj/VdCpbKkQMqrkimMqqZVE+hOB//uxeGF2PSyOFvsgNrK8Ws8T+9eyYnU4byAKHGWDYmYNIODVk4g0rQHnO2mNoTpfNJAebHO8pea7inpYj9262VaBDXTmbCC7L/WvRjZmDqNM+v0psJZr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741123016; c=relaxed/simple;
	bh=k7Yxk6Ga0c64Kynk4TxaNnZZ+myD2DkhpD8zAdsm6FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RMnjwjebxQ0tj+bXeTYBct281Hz8iR7LGEtzoBf+LIvlbgy1y9f9oxeUUPMmdICbfGAhtez5+Djg0jU3O+Y/U0qUjofKqctjci/mzKH4Dcfy97DtIRFC0NjaVXFY+vbjB5T/WxDZqY0banCpNawVUnEIf29edTjkoWBL452OTHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=2lT3k8ic; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uxNa2xeS196LOQdsSVTCf0UBNg0lInB0Ngjf92IZMMQ=; b=2lT3k8ic7danUGuqxwuLtt6Iw8
	t6+7hypSeCHM7GIXT3rORlcEucP11RGm/xAEkiaodt3/JNB7pEc5SmliOv90QkC3ZHs8nX6kTVeEw
	9rJqE3p85oGvqhdq6UEWGDTQjHhkITxRNlax1rnIXngZdrnc2kLSFLbkDU3xKh6wuWIYczPohm9Bc
	tNUWr7Be/mKuirvsFU3fWTdrDgjXSUooU1/Nk7rgOAwcvz0v+VOulyfGBY5OS4nmkSRm1xPH8Zc+T
	ByGnUVS7Dx9+o46rtAEppq8QgUTiQji1M+TIgsTMWl5ZWYuv4klJdsBUge5z1hbtHMZFcGMr/5dEN
	QImZ8Dwg==;
Received: from i53875a38.versanet.de ([83.135.90.56] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tpZdB-0006GI-Qt; Tue, 04 Mar 2025 22:16:49 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 detlev.casanova@collabora.com, linux-rockchip@lists.infradead.org,
 Andy Yan <andy.yan@rock-chips.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Add display subsystem dt node on rk3576
Date: Tue, 04 Mar 2025 22:16:49 +0100
Message-ID: <2627393.Mh6RI2rZIc@diego>
In-Reply-To: <lfmhqurnpjmfy6pfjxd5aczxujislv2p5bsurcbl7capyt7zv3@hy2twvjj53uz>
References:
 <20241231095728.253943-1-andyshrk@163.com>
 <173564980410.21979.2947276365464229762.robh@kernel.org>
 <lfmhqurnpjmfy6pfjxd5aczxujislv2p5bsurcbl7capyt7zv3@hy2twvjj53uz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 4. M=C3=A4rz 2025, 15:47:28 MEZ schrieb Sebastian Reichel:
> Hello,
>=20
> On Tue, Dec 31, 2024 at 06:57:21AM -0600, Rob Herring (Arm) wrote:
> > On Tue, 31 Dec 2024 17:57:17 +0800, Andy Yan wrote:
> > > As the VOP[0] and HDMI[1] driver have already been submitted for revi=
ew.
> > > This series enable hdmi display on sige5 board.
> > >=20
> > > [0] https://lore.kernel.org/linux-rockchip/20241231090802.251787-1-an=
dyshrk@163.com/T/#t
> > > [1] https://lore.kernel.org/linux-rockchip/20241231094425.253398-1-an=
dyshrk@163.com/T/#t
> > >=20
> > > Changes in v3:
> > > - Split from https://lore.kernel.org/linux-rockchip/3330586.aeNJFYEL5=
8@diego/T/#t
> > >=20
> > > Andy Yan (3):
> > >   arm64: dts: rockchip: Add vop for rk3576
> > >   arm64: dts: rockchip: Add hdmi for rk3576
> > >   arm64: dts: rockchip: Enable hdmi display on sige5
> > >=20
> > >  .../boot/dts/rockchip/rk3576-armsom-sige5.dts |  47 +++++++
> > >  arch/arm64/boot/dts/rockchip/rk3576.dtsi      | 126 ++++++++++++++++=
++
> > >  2 files changed, 173 insertions(+)
> >
> > [...] (a bunch of warnings due to dependency patch series not yet
> > being in linux-next)
>=20
> I think all dependencies have landed now. But it might be sensible
> to do a quick resend considering how old this is.
>=20
> Would be nice to have initial RK3576 HDMI support in 6.15 :)

now we can :-)

The update was not that difficult, so did it myself when applying.


Heiko



