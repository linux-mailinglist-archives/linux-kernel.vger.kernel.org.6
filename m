Return-Path: <linux-kernel+bounces-190135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A04418CF9FE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 460B5B20376
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C3717C60;
	Mon, 27 May 2024 07:24:03 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0BD1BC3C
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716794643; cv=none; b=PrNycZgcIFY3PSzX5BheqzXkSxcm9qHHxPEEiuQniH8TDGZ2dLlmkXD7jab+g4vWbiZr7FtBkw97m1/g9xGS+8Wo3V+fpz9arli2SJqJMFpLZIzTw0mwbXvMPph3VwN7VyA5FGwsGl6XA1NPEz6jCuIuUVXnC4FD+prbcQabpQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716794643; c=relaxed/simple;
	bh=dlsp9M9N1cGbggf5KH6NHOVp5mV4EajDFt5qSLAL5sE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L9u5akXu7vN5R4lIib+YoQqSMGzF1Ft+Wcmg37LpAOcWu/0yen9UihFZ0RRdGfq/HSgShljtyE5b6Nxu/GRPelxpXjHpVrE7qo6iBEk7xSyAQUJgbB4PJokrhZ6holFSqWVmfQ78w6b36Ya0Yjxh+ioYyzXoS35e2vwiWV9NKzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sBUhx-0007Uf-So; Mon, 27 May 2024 09:23:49 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sBUhw-0039iX-Er; Mon, 27 May 2024 09:23:48 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sBUhw-0001dI-1H;
	Mon, 27 May 2024 09:23:48 +0200
Message-ID: <9b7e1a88a812f5c86ada75b094c95b9cf65891c3.camel@pengutronix.de>
Subject: Re: [PATCH 0/3] reset: Convert to platform remove callback
 returning void
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nishanth Menon <nm@ti.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Tero Kristo <kristo@kernel.org>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Kevin Hilman <khilman@baylibre.com>,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de,  Santosh Shilimkar
 <ssantosh@kernel.org>, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,  Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 27 May 2024 09:23:48 +0200
In-Reply-To: <3emqw7comsegnkso6o3srb3ebeoa7n2m5ckv2ycznu6muh7ydz@krrx33tn4vyv>
References: <cover.1709674157.git.u.kleine-koenig@pengutronix.de>
	 <f35398925846addb282df9c8a6f09d24ecc5c6fc.camel@pengutronix.de>
	 <3emqw7comsegnkso6o3srb3ebeoa7n2m5ckv2ycznu6muh7ydz@krrx33tn4vyv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Uwe,

On Sa, 2024-05-25 at 12:14 +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Philipp,
>=20
> On Tue, Mar 12, 2024 at 09:47:24AM +0100, Philipp Zabel wrote:
> > On Di, 2024-03-05 at 22:32 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > this series converts all platform drivers below drivers/reset to stru=
ct
> > > platform_driver::remove_new(). See commit 5c5a7680e67b ("platform:
> > > Provide a remove callback that returns no value") for an extended
> > > explanation and the eventual goal.
> > >=20
> > > All conversations are trivial, because their .remove() callbacks
> > > returned zero unconditionally.
> > >=20
> > > There are no interdependencies between these patches, so they could b=
e
> > > picked up individually. But I'd hope that they get picked up all
> > > together by Philipp.
> >=20
> > Thank you, I'll pick them up.
> >=20
> > Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
>=20
> These patches made it into next (as v6.9-rc1..6d89df61650d), but not yet
> into Linus's tree for v6.10-rc1. I intend to send a PR to Greg early next=
 week changing
> platform_driver::remove to match remove_new to cook
> long in next for v6.11-rc1. If these reset commits don't make it in in ti=
me,
> I'll be so bold and just include the commits from your for-next branch
> in my PR.

Please do, thank you.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

