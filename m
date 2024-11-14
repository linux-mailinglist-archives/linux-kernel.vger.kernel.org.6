Return-Path: <linux-kernel+bounces-409459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7799C8CF6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536431F23265
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1AA42AB1;
	Thu, 14 Nov 2024 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T5bBGjL9"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019DB28E0F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731595010; cv=none; b=GvcLkzDAzeNGWC5qH0ZfuPzATNJ+HdMKmHtnjdLomFZz/+W3adyoZgsQA03vHrtGXXw4wBb+AbeFymvK6ppDMk2x9u42PR72qa76OPELiTXLJCSk9uixvZ38a2lCKl16735T6rnuJWROb0x0lEZzUb82n4nAfT70mcmdWvLM7E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731595010; c=relaxed/simple;
	bh=pMalZ/vuIQMs6OpKEHlJsnbGwzf/ddS4uypgpoq6C84=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=foWan45n52rAQee10+hzpZUw1eAtU3RW2YgEjzRFtuWqor2wlLsnB0PkKrPHtQtDt/XsaIKEUv4EzXDqNwQTwMV7DHj6hKDamfQCDp+6lItGDh0IlrwldV1ZFbtKn54VN77n8NyR7qCMhWjf/8NDcFdfxK89QwA3PTnbz0iMFhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T5bBGjL9; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E7FE440002;
	Thu, 14 Nov 2024 14:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731595006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pMalZ/vuIQMs6OpKEHlJsnbGwzf/ddS4uypgpoq6C84=;
	b=T5bBGjL9fPagGs5rPikIpqPBzdB/wRqgaXkonoxMUwoqhDQCKEG+VbaEGjgvntFQdeEemU
	JvBglsNxyCptT9CDBM/tLDeEiKPRfRaPM84Pw2+jfi33l/KX64qCrVF4yapf3UGIHeSIeu
	rMMxGvCux/eCNINabShKydhHFxGfdal1vbl1WCW4+3hGc27g8X7ZvhoX8ZpVa+pdOLD69C
	07JOCodSppAb8QZfYZcvdW7nv37HJOfLiEvk1SiBpghZQbVnujKXyyaG58bXYfyyfKZsAp
	FxZarToepMkyUPJUwdDB9jUxBLF8J8aT8xHAy8StXojunUH7RouXuJ6MoCQS7g==
Date: Thu, 14 Nov 2024 15:36:45 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] regulator: core: Fix resolve supply
Message-ID: <20241114153645.2bbeb89d@kmaincent-XPS-13-7390>
In-Reply-To: <ZzX6210-5YwmIaba@finisterre.sirena.org.uk>
References: <20241113153614.1755825-1-kory.maincent@bootlin.com>
	<ZzTOWoTT2to6aW5g@finisterre.sirena.org.uk>
	<20241113173642.4d58645b@kmaincent-XPS-13-7390>
	<ZzX6210-5YwmIaba@finisterre.sirena.org.uk>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 14 Nov 2024 13:27:55 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Nov 13, 2024 at 05:36:42PM +0100, Kory Maincent wrote:
>=20
> > My issue is that it does not look for the regulator supply in the OF no=
de
> > described in the regulator_config structure:
> > https://elixir.bootlin.com/linux/v6.11.7/source/include/linux/regulator=
/driver.h#L445
> > It looks at the parent device OF node instead.
> >=20
> > My use case is that a PSE controller have several PIs (Power Interface)
> > which can have different regulator supply. A regulator device is regist=
ered
> > for each PIs. The OF node used by the regulator core to lookup for the
> > regulator supply is the PSE controller node and its children instead of=
 the
> > node of the PI which is described by the regulator_config->of_node. =20
>=20
> Please resubmit with a clearer commit log.

Still I am not sure it is the right way to do it.
In regulator_dev_lookup function if the regulator is not found in the dt it=
 uses
the dev_name string to look for it.
https://elixir.bootlin.com/linux/v6.11.7/source/drivers/regulator/core.c#L2=
035

The dev name of the rdev->dev.parent device or the rdev->dev virtual device=
 is
not the same. I am not regulator expert therefore I am afraid that the sugg=
ested
change could break things.

Maybe this change is safer: https://termbin.com/g0xi

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

