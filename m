Return-Path: <linux-kernel+bounces-386622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA72D9B45F3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7677D1F233D4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E863F1E0DE8;
	Tue, 29 Oct 2024 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="SKYZtxN3"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347091DF989
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730195299; cv=none; b=Ee6IAU9EIYoNoc4+56GWIJ56z27MS2x1uS4qvYI2TzV4SsWC3ssFAx6irx//wRyDkK1wOaX+w1T3KI1+bl1a6npzcDNMp83fZDyEfHeGwEAXZlGCnpEPvdN9O8y98TtewVhgcgfQYX/Da6NpFEe5HGTXsEI9dlipDvGa6WDvBQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730195299; c=relaxed/simple;
	bh=q4DQvH1yTgG5s6YS3jDzL8kWS0Q+9gf6Jcq6GQyOq6Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fui3I94I+9Nuwde+cZl9ojUE+xMN4bn4hJ/eJIPwPgMfGTwZsx9NbEmtDFeL7XWUICJLpJcbfMbc6bYZAHnEjKObkN+su2GjEyBrWa0rFudVuaw+X6ieqO0T0YmMFwfgjZYhM4HzVgzPSwyjWE+XAGLv7SgCFbLSiMJ/Q8h+3lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=SKYZtxN3; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=o53zroy6ajgonks5kukapksxvi.protonmail; t=1730195289; x=1730454489;
	bh=q4DQvH1yTgG5s6YS3jDzL8kWS0Q+9gf6Jcq6GQyOq6Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=SKYZtxN3mE3tar1YfOo5pLhOlG+mttIq/SgsTrUVfwGTflWm9nYNvE1mw2m7Gr34U
	 g5n40mS65rQFWoP4aCQ6cimcVqz+7Z17NLi4swjXiZiRlkWbcMugArERgJl4vQcDm5
	 dv5RfcJeQ+uT6lhLCh0CC1xGnldek39Pigi4+0dLvyAv6mahebJaZL+TdiaYAvV6JC
	 /wzah0Egxke/FGxpbxTSqKeJER3BsczWmqxHoZxg6bvcekgh0vEudy/gzjH8/Bx10j
	 aBI/KW5yBGGIo1J7SZrZSFTxpL8i+Fm6kSmSJfMlJQjuBrKJXXMxR0Zy3kv3aNueoK
	 hXCVWS8VVQcbg==
Date: Tue, 29 Oct 2024 09:48:02 +0000
To: Andy Yan <andyshrk@163.com>
From: Piotr Zalewski <pZ010001011111@proton.me>
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, Daniel Stone <daniel@fooishbar.org>, Dragan Simic <dsimic@manjaro.org>, Diederik de Haas <didi.debian@cknow.org>
Subject: Re:Re:Re: [PATCH v6] rockchip/drm: vop2: add support for gamma LUT
Message-ID: <J0qrwbZdhKG3-7KhE30DvtMh7V3jQTrQ8RnHPcIHV_yBxiXRucga5al9iptkXm3NWrGKwuxOqyIOw-HiP5aIXY5D5GUOZ3Fu17rgj8Cy3B4=@proton.me>
In-Reply-To: <6a92e23a.56c.192d5ae32d5.Coremail.andyshrk@163.com>
References: <20241016223558.673145-2-pZ010001011111@proton.me> <DurUfF_0TBHKv4DHKIP3ggQh_85nRY0usYWn_fu_oJ45txO7dGKv-OK5rl6EDEPmX5l8WzrwPCzAvYz0xFPfeKGyx7enu1g-prsWIpilv88=@proton.me> <2bb58a1c.6287.192d1dc9b2d.Coremail.andyshrk@163.com> <6a92e23a.56c.192d5ae32d5.Coremail.andyshrk@163.com>
Feedback-ID: 53478694:user:proton
X-Pm-Message-ID: a2358035855d74cd8a3bb089158398ae3faf8474
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Andy

> =E5=9C=A8 2024-10-28 14:42:28=EF=BC=8C"Andy Yan" andyshrk@163.com =
=E5=86=99=E9=81=93=EF=BC=9A
>=20
> > Hi Piotr=EF=BC=8C
> > Tested on top of Linux 6.12-rc5 with rk3566-box-demo in a buildroot + w=
eston environment:
> > weston --backend=3Ddrm-backend.so -i 0 --continue-without-input
> > weston-simple-egl
> >=20
> > simple-egl will draw a triangle on the desktop.
> > After the patch applied=EF=BC=8Cthe triangle will flicker again and agi=
an=E3=80=82
> > So it break some function=E3=80=82
> > I've been quite busy lately, and it will take some time before I can an=
alyze what the specific reason is.
>=20
>=20
> Sorry, it's my fault. After more experiments, I found that the flickering=
 I observed is not related to your patch.
> This should be a probability-related issue associated with alpha blending=
=EF=BC=8Cwhich can be Fixed with patches in
> my series[0]
> [0] https://lore.kernel.org/linux-rockchip/75a13dbb.acb8.192289a8005.Core=
mail.andyshrk@163.com/#r

Np :)

> And for the gamma patch=EF=BC=8C I think there are still some small areas=
 that can be improved.
> Please see my comment bellow:

Amended! thanks.

I will wait until weekend with next version, maybe there will be more
comments.

