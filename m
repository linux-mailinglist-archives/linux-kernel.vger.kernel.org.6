Return-Path: <linux-kernel+bounces-182818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABB18C9068
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 12:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06FD2825B3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 10:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E35C1D688;
	Sat, 18 May 2024 10:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dJ1HM4sV"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2707946F
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 10:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716029067; cv=none; b=YgdvwbXqYHN1CMExEuxTaPVTlnOeHVAbrMEx3b9wATuKqpVZbJNaLpHBERxfOuNTGMNBqu3WFFaIeRxB22ENm7a9N4C7lu3Lc9MKGbLpNHsvDsUemXS1bBVxxTu03umQZnqX50drAGsP31jl04I33dP8FvsVqoIlYM3V+ZHvhoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716029067; c=relaxed/simple;
	bh=+g0Djet6VPor+0w2My6R6Rpd8gd93fTaLQzxiswyYc8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FGuhWUteIBkmiY1qJNB34bNMxES8z4nF47N0R6dC3lrg0deEoicY9qSPjSpNGT1zIEywoFj6dCaYhoIh06J09hsHV/ivhS5Rl3nyWrysN+342dQGiCQPliKiyM+Oc1PMJ4V30sMQibz5tBTUIOxLS2lnMJCPRf6WK6o0ygL98gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dJ1HM4sV; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0661D40003;
	Sat, 18 May 2024 10:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716029063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+g0Djet6VPor+0w2My6R6Rpd8gd93fTaLQzxiswyYc8=;
	b=dJ1HM4sVgpsZAO+szA2uDJZWhF2Xaigaf8SQ/cwA6DxsJD9fN3RFW2thSnsxioBdD11sGy
	m6zCzsjLDg1wSAwYoYRgiJlLNL9RdmRqKXLyfg1Xvmo8Z0uJBrf/agKf0X3vrBcBqnPit3
	mYxHPYcpDMpZIee5Z1IShXvt8EPkNr1q6v6JsmdVRQL2FCkNSuLAJZtvrYeNKB2akQLd6r
	+quT7wUKLbNb66kNqBsVo4hweJrp+vOtpd2IBzMFfK1sU+0B1NQdhmuc1KJZoB8LePNocv
	AUZGzIbI2LbNdabEAX3+TlI1kURXa5IfohYgK5b1glIkgNMAgynbvHeCY9fZNg==
Date: Sat, 18 May 2024 12:44:19 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Val Packett <val@packett.cool>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Heiko Stuebner <heiko@sntech.de>, Stephen Rothwell
 <sfr@canb.auug.org.au>, linux-mtd@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: rockchip: reject NVDDR timings when
 checked
Message-ID: <20240518124404.472eb60b@xps-13>
In-Reply-To: <20240518033923.5577-2-val@packett.cool>
References: <20240518033923.5577-2-val@packett.cool>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Val,

I might propose a slightly different title which I think better
describes the situation:
"mtd: rawnand: rockchip: ensure NVDDR timings are rejected"

val@packett.cool wrote on Sat, 18 May 2024 00:31:13 -0300:

> .setup_interface first gets called with a negative "target" value

Just as an FYI, the fact that it is negative is an implementation
detail, but you mention the #define of the value below, so that's fine.
=20
> NAND_DATA_IFACE_CHECK_ONLY, in which case an error is expected
> if the controller driver does not support the timing mode (NVDDR).
>=20

Here I would welcome two tags in order to get this backported as early
as needed in stable kernels:

Cc: stable@vger.kernel.org
Fixes: a9ecc8c814e9 ("mtd: rawnand: Choose the best timings, NV-DDR include=
d")

> Signed-off-by: Val Packett <val@packett.cool>
> ---
> Hello everyone, first Linux patch from a long time FreeBSD person :)
>=20
> This was required to get the NAND controller to attach on the random
> old RK3066 tablet I'm bringing up mainline on.

Welcome! The fix looks right besides minor nits in the commit log. I'll
probably take the v2 when it's out after -rc1 has been tagged.

Thanks,
Miqu=C3=A8l

