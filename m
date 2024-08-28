Return-Path: <linux-kernel+bounces-305068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312029628EE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E40D428365B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871DF188002;
	Wed, 28 Aug 2024 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="h0mGQKeU"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0597F187FE5;
	Wed, 28 Aug 2024 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852491; cv=none; b=JmktABuMQTFB60MKt8tmeovWRJXof4w5fFp5v5w+G4KjOdvOc7XGXuZvVHkP7DfU+qSFwEvcp+5Hz+ysra/Tl+Z29CVNFwEerZPRDPtcTzVFXh8jCTnx+nAjR6kTFd27E276LMdMj9Xmhy7T7uKVxubxP0+46RJHJxPLnTn3n2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852491; c=relaxed/simple;
	bh=qUUiaCfBLXZWpJdappx4+njgqnXxefIpho9blRI4Pes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mQqyO2E0utMOW866xv/cRMIXovGMxU2PTxPK5QG5e6sfsM63FWjl2f0uhnC8njCCWXarhXwYuQOtJ+xMLEK72KMpr0ep6lx9lhwZ62mXp/tpAL6SGhMCV85DkuiUwhmcDEozUO1b5c92oH0QkMv8PXiMIch1F340pmk1iooXpjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=h0mGQKeU; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qUUiaCfBLXZWpJdappx4+njgqnXxefIpho9blRI4Pes=; b=h0mGQKeUHlQIzvXxOw2pBhnXnp
	1gkRnQcgSpBgLRM91xDWAdbouRh+oqwwTl0pRZMjtkidxWkkdlHbym4+zv0vanCYCyAeYpzZMezF/
	IWhrGWqZoOaoIA9mEFfl9dpfMNmjfBHfon0hmHYmuCBg40OjjA3WdeqJZBgYkjIPT8y/hkCUwCkIk
	xMi4a5KnL8Yg7h0GsAr+YWrY7/TqGF3wt9pz5376t0vKzCr5Od12SYu/B55lZEOa1BfdWoQkIHWxG
	2GOOVfMngUSpq1Im2QF2UhWxsQyC+8qArm++5HOahS2BxYwzrXFCB9263I6nvaLXsLoRX9YLwqqFo
	//iudiqg==;
Received: from i5e8616cd.versanet.de ([94.134.22.205] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sjIvL-0005dr-8m; Wed, 28 Aug 2024 15:41:23 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Jonathan Liu <net147@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, FUKAUMI Naoki <naoki@radxa.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2] arm64: dts: rockchip: Enable RK809 audio codec for Radxa ROCK
 4C+
Date: Wed, 28 Aug 2024 15:42:35 +0200
Message-ID: <2576985.vzjCzTo3RI@diego>
In-Reply-To:
 <CANwerB0NUFyJ1egYNEAnhdqSyBTq41cSKKC0bAbKudZAPx8UfA@mail.gmail.com>
References:
 <20240828074755.1320692-1-net147@gmail.com> <2502361.uoxibFcf9D@diego>
 <CANwerB0NUFyJ1egYNEAnhdqSyBTq41cSKKC0bAbKudZAPx8UfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Jonathan,

Am Mittwoch, 28. August 2024, 15:24:56 CEST schrieb Jonathan Liu:
> On Wed, 28 Aug 2024 at 22:59, Heiko St=FCbner <heiko@sntech.de> wrote:
> > Am Mittwoch, 28. August 2024, 09:47:53 CEST schrieb Jonathan Liu:
> > > This adds the necessary device tree changes to enable analog audio
> > > output for the 3.5 mm TRS headphone jack on the Radxa ROCK 4C+ with
> > > its RK809 audio codec.
> > >
> > > Signed-off-by: Jonathan Liu <net147@gmail.com>
> >
> > as it looks like you have one of those boards, could I possibly as you
> > to take a look at the vdd_cpu_b and vdd_gpu nodes?
> >
> > I see (and devicetree check reports it too) a pinctrl-0 for the vsel-gp=
io
> > without accompanying pinctrl-names.
> >
> > Could you check if things fail if you either add pinctrl-names or remove
> > the pinctrl-0 entry?
>=20
> I tried both but neither resulted in any change to the warnings in dtbs_c=
heck.
> Reverting my change also results in the same warnings so I don't think
> it is related to my change.

I was more aiming at a functional test on the board :-) .

You are correct in that this is not related to your change, I was just
seeing someone with the hardware.

I.e. while running dtbs check here I saw those regulator nodes
and didn't want to change stuff without being able to test them.

Heiko



