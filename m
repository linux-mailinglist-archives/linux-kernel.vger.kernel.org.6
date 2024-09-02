Return-Path: <linux-kernel+bounces-310981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C5D96838A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FE0AB21B93
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21FC187338;
	Mon,  2 Sep 2024 09:47:42 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A0644C76
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725270462; cv=none; b=I0flM2KRu783Q9PvZOcEtuzRqUSYaLwGu5sYh52to0/BpTTOVIAPqp+A+zJ6Y3A1rsUr4b0Kd+c5GnHyvsDeBFL/AqgS/eGzKKXTGzFQnEdvvSdetz9HoO8CMrEsNi4RbBqGnKrRq5ZIBtYcbMVSO2V0z2SsZ/8ipgggg9zZffU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725270462; c=relaxed/simple;
	bh=HiqNHCQK+1DowJhE+PJamRZymKe3J4WfIfsxrG0iR2g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KdOIfbb/9X/qhHwf0u5oAKdZxqZpF0W4q7Z7+Q+MAvwjHQM1jZ/HQbGGuV677EBefujsPWXFmNJGlzW3U1YYijdcB/QBp9gQkRWefLjNMt5NvBhCgiwuVYBM9sHdc6teac8RVXA9++pbxHbtucallGZo2Ly0nHpCeT5TMKlt1E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl3eo-0000BQ-Rt; Mon, 02 Sep 2024 11:47:34 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl3eo-004s4j-C0; Mon, 02 Sep 2024 11:47:34 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl3eo-000fuy-0x;
	Mon, 02 Sep 2024 11:47:34 +0200
Message-ID: <34bc2d1ceef7bcab3d9b78de588e996c2d2ecdd3.camel@pengutronix.de>
Subject: Re: [PATCH v3 8/9] reset: amlogic: split the device core and
 platform probe
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong
	 <neil.armstrong@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
Date: Mon, 02 Sep 2024 11:47:34 +0200
In-Reply-To: <1jsev0wj8y.fsf@starbuckisacylon.baylibre.com>
References: <20240808102742.4095904-1-jbrunet@baylibre.com>
	 <20240808102742.4095904-9-jbrunet@baylibre.com>
	 <812c6ddc-1929-46c4-bac7-4bd0f5ccc213@linaro.org>
	 <1jsev0wj8y.fsf@starbuckisacylon.baylibre.com>
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

On Mo, 2024-08-19 at 18:49 +0200, Jerome Brunet wrote:
> On Mon 19 Aug 2024 at 18:33, Neil Armstrong <neil.armstrong@linaro.org> w=
rote:
>=20
> > On 08/08/2024 12:27, Jerome Brunet wrote:
> > > To prepare the addition of the auxiliary device support, split
> > > out the device core function from the probe of the platform device.
> > > The device core function will be common to both the platform and
> > > auxiliary
> > > driver.
> > > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > > ---
> > >   drivers/reset/amlogic/Kconfig                 |  10 +-
> > >   drivers/reset/amlogic/Makefile                |   3 +-
> > >   .../{reset-meson.c =3D> reset-meson-core.c}     | 101 +++----------=
-----
> > >   drivers/reset/amlogic/reset-meson-pltf.c      |  92 +++++++++++++++=
+
> >=20
> > Are we still in 1983 ?
>=20
> I don't quite get that remark or how it is helping the review.
>
> > please use reset-meson-platform and drop pltf completely
>=20
> You are requesting auxiliary -> aux on the patch.
> So which one will it be ?

I would prefer to drop the -pltf suffix completely and also to drop the
"reset driver" -> "reset platform driver" documentation changes.

regards
Philipp

