Return-Path: <linux-kernel+bounces-324442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF4F974C84
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 580931C20AF1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9C9154C05;
	Wed, 11 Sep 2024 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="Xj3wITdQ"
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net [178.154.239.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A80F2C859;
	Wed, 11 Sep 2024 08:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726042978; cv=none; b=W64LCSb/6BppAf29m77vXksEj6KQu7taGDH6NfiIMR/9gH/dTjsn7CTU7Um00Oq4qvMAbofllwjurQFUHMXjecHARTtY6+jcSSCNDAGWMeA/y9n6+/R7vcf87SMlGdxjRa5ebvQoXb7BAxajzwTS9p+HEdYtGUdmCV/wiMY7xyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726042978; c=relaxed/simple;
	bh=9ncGzqtpiWgjyq35hElyjIoVwEnaH+a6wWns+spW8Jc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nb0qw9JeRHxVT4sJHflPpajsNeIJwAgRdxji25tch1JnH9JZ4btAxsU9GCIG+l/SDzeEAEdynEg2R8WqXcmvltwamoZ9bZ8Ypz7OH8QdQBoE6MhC2srAm7XEAl1HN564uE2pjJK27UFIagoHGyi2S13mOie4reR6Ug8qYwbot3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=Xj3wITdQ; arc=none smtp.client-ip=178.154.239.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:51a0:0:640:3bf:0])
	by forward501d.mail.yandex.net (Yandex) with ESMTPS id 0B9F4614F7;
	Wed, 11 Sep 2024 11:14:25 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id NEer0R0Of8c0-w1ouJzf4;
	Wed, 11 Sep 2024 11:14:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1726042464; bh=9ncGzqtpiWgjyq35hElyjIoVwEnaH+a6wWns+spW8Jc=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=Xj3wITdQtKiEe4f6xbwAU/AQXN4qH3xLcTgo3KdQhAp8z/Ex0Rr5FZN2z772f8Zqg
	 wZNpHTyJR5/gX5XPOW2tUKLZKtqo8zOho31m913ek4l458jxaTCu06wFgJWvnBIB0P
	 YGrMumDa9SgVDO5G1sqB5QFjy1tijTyltW/7Oabo=
Authentication-Results: mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <246de2986dce9d867894bb006a1b2b3601e94a4e.camel@maquefel.me>
Subject: Re: [PATCH] ep93xx: clock: Fix off by one in
 ep93xx_div_recalc_rate()
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Dan Carpenter <dan.carpenter@linaro.org>, Alexander Sverdlin
	 <alexander.sverdlin@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>, Russell King
	 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date: Wed, 11 Sep 2024 11:14:23 +0300
In-Reply-To: <a05454f8-e409-4f60-93f7-6aa2ea0a2a23@stanley.mountain>
References: <a05454f8-e409-4f60-93f7-6aa2ea0a2a23@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Dan!

Reviewed-by: Nikita Shubin <nikita.shubin@maquefel.me>

Alexander, Arnd

unfortunately, the ep93xx DT conversion series is also affected by this
bug.

On Wed, 2024-09-11 at 10:39 +0300, Dan Carpenter wrote:
> The psc->div[] array has psc->num_div elements.=C2=A0 These values come
> from
> when we call clk_hw_register_div().=C2=A0 It's adc_divisors and
> ARRAY_SIZE(adc_divisors)) and so on.=C2=A0 So this condition needs to be
> >=3D
> instead of > to prevent an out of bounds read.
>=20
> Fixes: 9645ccc7bd7a ("ep93xx: clock: convert in-place to COMMON_CLK")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> =C2=A0arch/arm/mach-ep93xx/clock.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-
> ep93xx/clock.c
> index 85a496ddc619..e9f72a529b50 100644
> --- a/arch/arm/mach-ep93xx/clock.c
> +++ b/arch/arm/mach-ep93xx/clock.c
> @@ -359,7 +359,7 @@ static unsigned long
> ep93xx_div_recalc_rate(struct clk_hw *hw,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 val =3D __raw_readl(p=
sc->reg);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 index =3D (val & psc->=
mask) >> psc->shift;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (index > psc->num_div)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (index >=3D psc->num_div)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return DIV_ROUND_UP_ULL(p=
arent_rate, psc->div[index]);


