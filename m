Return-Path: <linux-kernel+bounces-353003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D727A992725
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819311F21431
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DF918C32B;
	Mon,  7 Oct 2024 08:38:04 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC3C18B48F
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290284; cv=none; b=IgterDJfEjQ54xWXKpzjl8BxNSiJO2+mCwD2ELlb9W40kZD31njelTeoFMLF4vjgRTwARmBDdIRYnx9Ha3vAIgSWrphaK3WZNQxwYqAKOwV/keb4iT/1p/F9c55hLSoILJ4MN33lHDq+30C9jElvRg+ZCl3c2e4bFGiQD/uTu8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290284; c=relaxed/simple;
	bh=V8UfAJBdqwuB5jom1zfhCOfgs2dm4sGPBIftXlrdBpA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QTjVyjJjLJOqDnfeBc2+aaB3xdelsMWFpKo1hbwV1ccFkxXX4P6gnbRToMv53sY1N8Qth3NQPqNzTi1xpITC3w6+9n75cfQQHv4CRYF3ynQHcidllyrXqK8k7+KP8t5IjAmUcdOyGkm2dQM1zhn8LMfr+FzED2idzHuGpZ6GUSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sxjFT-00008l-7N; Mon, 07 Oct 2024 10:37:47 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sxjFS-0005N3-9U; Mon, 07 Oct 2024 10:37:46 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sxjFS-000BeK-0i;
	Mon, 07 Oct 2024 10:37:46 +0200
Message-ID: <21c65903b243b677d8e84c84acf89c93a45ab1e5.camel@pengutronix.de>
Subject: Re: [PATCH v5 8/9] reset: amlogic: split the device core and
 platform probe
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>,  Kevin Hilman <khilman@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Jiucheng Xu
 <jiucheng.xu@amlogic.com>, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Mon, 07 Oct 2024 10:37:46 +0200
In-Reply-To: <1jsetcro5n.fsf@starbuckisacylon.baylibre.com>
References: <20240910-meson-rst-aux-v5-0-60be62635d3e@baylibre.com>
	 <20240910-meson-rst-aux-v5-8-60be62635d3e@baylibre.com>
	 <8cb81058c8f45e378675e078e296336a2cf74308.camel@pengutronix.de>
	 <1jldzwkpsu.fsf@starbuckisacylon.baylibre.com>
	 <01aff9c0f129f8c1cf41c7ae53dac38048aa34a8.camel@pengutronix.de>
	 <1jsetcro5n.fsf@starbuckisacylon.baylibre.com>
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

Hi Jerome,

On Fr, 2024-10-04 at 15:30 +0200, Jerome Brunet wrote:
> On Mon 30 Sep 2024 at 18:56, Philipp Zabel <p.zabel@pengutronix.de> wrote=
:
>=20
>=20
> > I've applied them to reset/next them unchanged, at:
> > https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D5b93105afcdc
> > and sent a follow-up patch to fix the alignment.
>=20
> Thanks Philipp.
>=20
> Would it be possible for you to tag it, so I can pull it the amlogic
> without waiting for the next rc1 ?
>=20
> We have couple of changes pending depending on this.

Stable tag at

  git://git.pengutronix.de/pza/linux.git tags/reset-amlogic-aux


regards
Philipp

