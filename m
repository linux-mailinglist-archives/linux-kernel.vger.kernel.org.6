Return-Path: <linux-kernel+bounces-533272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A41DA457A9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE9A63A4F35
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD463258CC6;
	Wed, 26 Feb 2025 08:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="fRP53DWu"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E194329D0E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740557240; cv=none; b=X08iYaZVz6xJlEGEBXg9Au0goCcqpYNl65xBAB3ybx+JKtU9EOfrC7OAccZMU/HncIQT3Y4vndzpyEk2vAXWWZc7ZQr5sYUDCjRtTPdZUFtIm/Lp9UPW1viPB0I0r3UnJsWrYHI7qweFvv0EEgvlltFGe4fDRy6iUIexkWRuJ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740557240; c=relaxed/simple;
	bh=RTPCL3bJ22/BfZ0DYy+zPJ2HcQNthlLl55iYHSsXgf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mNdeC42MTrfsB8m5WzOG/6Gqrhvar2ipoJI/EZ1rEkUQOF53emC+SbXFGHYSZ3Ws5HFhXuQFXTccY+xnXrjEiyRWHriRrY5ccSY48CZCWtZA6uVPKL4jS/zVtAMPqXgf0nDEKIsVPGr8+5PSO//oqJw1Lvw/nHvkWlZ4+dxTk64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=fRP53DWu; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RTPCL3bJ22/BfZ0DYy+zPJ2HcQNthlLl55iYHSsXgf4=; b=fRP53DWuVGxiOES0oTWTWO40pa
	aQbMHORaTsVwKaFQnsDdyAO6FV5Pu5jiMrr6lVAfy2+Z3UOfhrHVSanu++BR3slgsrN7yXB4UkSWy
	X2auVT4MHLTC5wBWSrl9he6ntyojDcxdf/j9XUfVnAXBuihGbjgOTsNK39VVVp07tVTJExZ7NYjrk
	jj6pmdh4BqDYXpMB/3bfEcArywK1xToNDaMt+RHVjZzC8v2fKkg34zKyGcre3Rxcj+8j2Puc865/O
	g618ljGYIwK4KWm9Rw9H5xVn1imt6Nmhl6t80evJ8MwT+4pUXVPvr8yIIh8k6Wmcm93lFBLtGi0KK
	KjqbuwqA==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tnCRk-0004zD-A4; Wed, 26 Feb 2025 09:07:12 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Heiko Stuebner <heiko.stuebner@cherry.de>,
 Chen-Yu Tsai <wens@csie.org>
Subject:
 Re: [PATCH v2] arm64: dts: rockchip: add usb typec host support to
 rk3588-jaguar
Date: Wed, 26 Feb 2025 09:07:11 +0100
Message-ID: <1952248.GKX7oQKdZx@diego>
In-Reply-To: <18716872.sWSEgdgrri@diego>
References:
 <20250218211044.2256762-1-heiko@sntech.de>
 <c50c6053-4569-44b0-943d-5450960be147@cherry.de> <18716872.sWSEgdgrri@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Freitag, 21. Februar 2025, 22:53:20 MEZ schrieb Heiko St=C3=BCbner:
> Am Freitag, 21. Februar 2025, 17:43:08 MEZ schrieb Quentin Schulz:
> > Hi Heiko,
> >=20
> > On 2/18/25 10:10 PM, Heiko Stuebner wrote:
> > > From: Heiko Stuebner <heiko.stuebner@cherry.de>
> > >=20
> > > Jaguar has two type-c ports connected to fusb302 controllers that can
> > > work both in host and device mode and can also run in display-port
> > > altmode.
> > >=20
> > > While these ports can work in dual-role data mode, they do not support
> > > powering the device itself as power-sink. This causes issues because
> > > the current infrastructure does not cope well with dual-role data
> > > without dual-role power.
> > >=20
> > > So add the necessary nodes for the type-c controllers as well
> > > as enable the relevant core usb nodes, but limit the mode to host-mode
> > > for now until we figure out device mode.
> > >=20
> > > Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> >=20
> > While the USB functionality does work for both ports, and the=20
> > orientation is properly reported, it seems like there may be some issue=
=20
> > with how the PHY or controller interacts with that info because I do no=
t=20
> > get USB3 speeds when the device is inserted in reverse orientation,=20
> > while I do when it's in normal orientation.
>=20
> I've tested both ports and saw the issue too.
> Interestingly on the usbdp-phy side, orientation detection seems correct
> and also the sbu pins are set accordingly.
>=20
>=20
> > I assume that's the case for the Rock 5 ITX and Orange Pi 5+ as well an=
d=20
> > probably has nothing to do with the DT?
> >=20
> > Should we go still go on with trying to merge this patch knowing that? =
I=20
> > mean USB2 is still better than no USB at all :)
> >=20
> > +Cc Chen-Yu, owner of an Orange Pi 5+, who may be able to confirm the=20
> > issue is widespread.

=46or reference, after digging around I found out that the usbdp-phy does n=
ot
handle the orientation correctly but relies on specific behaviour of the dw=
c3
controller (suspending between unplug and plugin).

usbdp-phy series fixing that is in
https://lore.kernel.org/linux-rockchip/20250225184519.3586926-1-heiko@sntec=
h.de/



