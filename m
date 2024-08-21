Return-Path: <linux-kernel+bounces-295205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A13A695989D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645182812C3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA3C1CBEB5;
	Wed, 21 Aug 2024 09:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="jD8X+nIy"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011301E6165
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724231823; cv=none; b=DHxGgptfu0HgnNcCByoRcAEyM7bEUc83PKrN7vNi12O7QcNt7X1HsCZZ7bsMFSpaUZh/yOetltVCGOKbLg4zAMVnDXNzwvE1Rsc9eCRbZa1d5mYww1sy1d8/HQRCPL0GPHXysCSN7u55lLNK7LEJnz3jAfKZaXn6w4GwkpmrdDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724231823; c=relaxed/simple;
	bh=/ANFY0YSdQlKFsj2xPo8JBhZehnFKTn+W+dUuBuiDRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fhqTlLHnTNR4B6IdqA8AUpA9M5oZT58yi3Ew6Szgtihd9reLv1JnSahkkl8wFNumUJKttTkv2S3M13eEdlc5TCCAM8G5exiDS9sZAY4nocSg2QjLoZffjUPG7pq8x+aQQlnW/iywtivaAok/sNCD9w8Bgyt9pWu7G+3mIelbOaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=jD8X+nIy; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HL3tWjS5RaaualvJBFqnJpDTlfqrpp/1GZR+3fI0M9U=; b=jD8X+nIyZb3MnxdtSkrmU8IWXL
	42fNxxi2Z41Y8DmFJwIkkczGgwAxN8hZGDGpP6VtkerHwSmR5W86PRh5xZLz/hoaGwd+RtihnXvAS
	1B7PetzMatkA5tV0cDRhoeY8Z07TTUDgI8J7MsCIJroaMiojhJlKMeQv5/dqYxB+09TBX5reKTB8S
	eNeoj7Lt/OA6tD6x0dZMs/85ylli9/IKdo6uAXpFB3t1HKyQ4V1M7cySacHrAwSKYabgQIWn76THs
	623DZAV8VC0xuVLvjDrJm7SdIuGsBc8HKSjX30Had7nwNauk5ao9cdqdr4dlNKEp5YJsnvNZPyBIW
	0+gkjsgw==;
Received: from i53875aca.versanet.de ([83.135.90.202] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sghSJ-00058Q-48; Wed, 21 Aug 2024 11:16:39 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
 vkoul@kernel.org, kishon@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 3/3] phy: phy-rockchip-inno-usb2: Improve error handling while
 probing
Date: Wed, 21 Aug 2024 11:17:06 +0200
Message-ID: <6073817.31tnzDBltd@diego>
In-Reply-To: <486bddb6aad14d05a3fb2d876d0d9d0d@manjaro.org>
References:
 <cover.1724225528.git.dsimic@manjaro.org> <12869965.VsHLxoZxqI@diego>
 <486bddb6aad14d05a3fb2d876d0d9d0d@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Mittwoch, 21. August 2024, 11:09:03 CEST schrieb Dragan Simic:
> On 2024-08-21 10:44, Heiko St=FCbner wrote:
> > Am Mittwoch, 21. August 2024, 09:37:55 CEST schrieb Dragan Simic:
> >> Improve error handling in the probe path by using function=20
> >> dev_err_probe()
> >> where appropriate, and by no longer using it rather pointlessly in one=
=20
> >> place
> >> that actually produces a single, hardcoded error code.
> >>=20
> >> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> >=20
> >> @@ -1375,8 +1372,10 @@ static int rockchip_usb2phy_probe(struct=20
> >> platform_device *pdev)
> >>  	rphy->irq =3D platform_get_irq_optional(pdev, 0);
> >>  	platform_set_drvdata(pdev, rphy);
> >>=20
> >> -	if (!phy_cfgs)
> >> -		return dev_err_probe(dev, -EINVAL, "phy configs are not=20
> >> assigned!\n");
> >> +	if (!phy_cfgs) {
> >> +		dev_err(dev, "phy configs are not assigned\n");
> >> +		return -EINVAL;
> >> +	}
> >>=20
> >>  	ret =3D rockchip_usb2phy_extcon_register(rphy);
> >>  	if (ret)
> >=20
> > I really don't understand the rationale here. Using dev_err_probe here
> > is just fine and with that change you just introduce more lines of code
> > for exactly the same functionality?
>=20
> As we know, dev_err_probe() decides how to log the received error=20
> message
> based on the error code it receives, but in this case the error code is
> hardcoded as -EINVAL.  Thus, in this case it isn't about keeping the LoC
> count a bit lower, but about using dev_err() where the resulting outcome
> of error logging is aleady known, and where logging the error code=20
> actually
> isn't helpful, because it's hardcoded and the logged error message=20
> already
> tells everything about the error condition.
>=20
> In other words, it's about being as precise as possible when deciding=20
> between
> dev_err() and dev_err_probe(), in both directions.  I hope it makes=20
> sense.

I'd disagree a bit, using one format only creates a way nicer pattern in the
driver, by not mixing different styles.

dev_err_probe documentation seems to agree [0], by stating:

"Using this helper in your probe function is totally fine even if @err is
 known to never be -EPROBE_DEFER.
 The benefit compared to a normal dev_err() is the standardized format
 of the error code, it being emitted symbolically (i.e. you get "EAGAIN"
 instead of "-35") and the fact that the error code is returned which allows
 more compact error paths."



[0] https://elixir.bootlin.com/linux/v6.10.6/source/drivers/base/core.c#L50=
09




