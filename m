Return-Path: <linux-kernel+bounces-311110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C239684F6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ACDB289930
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AEA15FD13;
	Mon,  2 Sep 2024 10:40:10 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BA51487CD
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273610; cv=none; b=BsMsrDUsuBa3EC7KVRUFd5nT8qi0Iz05ZV6nTsPuzGG0dQWFhrv3XrZjUO47mECBLzFt8YeLVayQZszkrFZIC5jM0mXXWqAkp2S20j/UWmSfR8vAeMhoYbvB9MQfugiot4z1OE70SR4QIYijiL/FhZUumLXWynypfUThk5lbye4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273610; c=relaxed/simple;
	bh=n8u6LZd+xbNxtLuqcpnJybmt8QHt7gi6eDc0G6kzSzQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RjElBiiOyFqs/fjk4Y3P7Q/xGOV+esse29mp+1LC9yDG1st7uc4fVGUjBncp85NeScd/P3vKRStZiH9qS7A5G/TpyYFRcLGeRjvPgz+flkkcRsfo4dz69nUHNJngy+wVqpOaeV5fN4LXQVs4F8yc0D2BQydcHpYA+jCuAjTcneM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl4Tb-0003TF-PN; Mon, 02 Sep 2024 12:40:03 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl4Tb-004smZ-Bp; Mon, 02 Sep 2024 12:40:03 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl4Tb-000hZg-0w;
	Mon, 02 Sep 2024 12:40:03 +0200
Message-ID: <e99c50a2200247abc2df570d3b6bc03d3954fb7d.camel@pengutronix.de>
Subject: Re: [PATCH v3 8/9] reset: amlogic: split the device core and
 platform probe
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Stephen Boyd
 <sboyd@kernel.org>,  linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org,  linux-clk@vger.kernel.org
Date: Mon, 02 Sep 2024 12:40:03 +0200
In-Reply-To: <1jbk16s7oo.fsf@starbuckisacylon.baylibre.com>
References: <20240808102742.4095904-1-jbrunet@baylibre.com>
	 <20240808102742.4095904-9-jbrunet@baylibre.com>
	 <812c6ddc-1929-46c4-bac7-4bd0f5ccc213@linaro.org>
	 <1jsev0wj8y.fsf@starbuckisacylon.baylibre.com>
	 <34bc2d1ceef7bcab3d9b78de588e996c2d2ecdd3.camel@pengutronix.de>
	 <1jbk16s7oo.fsf@starbuckisacylon.baylibre.com>
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

On Mo, 2024-09-02 at 11:53 +0200, Jerome Brunet wrote:
> On Mon 02 Sep 2024 at 11:47, Philipp Zabel <p.zabel@pengutronix.de> wrote=
:
>=20
> > On Mo, 2024-08-19 at 18:49 +0200, Jerome Brunet wrote:
> > > On Mon 19 Aug 2024 at 18:33, Neil Armstrong <neil.armstrong@linaro.or=
g> wrote:
> > >=20
> > > > On 08/08/2024 12:27, Jerome Brunet wrote:
> > > > > To prepare the addition of the auxiliary device support, split
> > > > > out the device core function from the probe of the platform devic=
e.
> > > > > The device core function will be common to both the platform and
> > > > > auxiliary
> > > > > driver.
> > > > > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > > > > ---
> > > > >   drivers/reset/amlogic/Kconfig                 |  10 +-
> > > > >   drivers/reset/amlogic/Makefile                |   3 +-
> > > > >   .../{reset-meson.c =3D> reset-meson-core.c}     | 101 +++------=
---------
> > > > >   drivers/reset/amlogic/reset-meson-pltf.c      |  92 +++++++++++=
+++++
> > > >=20
> > > > Are we still in 1983 ?
> > >=20
> > > I don't quite get that remark or how it is helping the review.
> > >=20
> > > > please use reset-meson-platform and drop pltf completely
> > >=20
> > > You are requesting auxiliary -> aux on the patch.
> > > So which one will it be ?
> >=20
> > I would prefer to drop the -pltf suffix completely and also to drop the
> > "reset driver" -> "reset platform driver" documentation changes.
>=20
> Hi Philipp,
>=20
> I'm not sure what you mean with the last documentation bit ? Could you ad=
d some
> details, I'd like to get the next version right.

Of course, sorry for being vague. I've replied to the patch with some
comments.

regards
Philipp

