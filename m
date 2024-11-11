Return-Path: <linux-kernel+bounces-404615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C94089C45B0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 822801F22401
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D291AA7BA;
	Mon, 11 Nov 2024 19:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nx+GDnf9"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300E31A76B2
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 19:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731352602; cv=none; b=CQRIRTSuzHU8AZm9SI5pqTOau5zTiotE36LaLHP9KdhhgrhK6mOqEvf9HAawOegXvHynPx+K5k+AHlhs9aYOLJCAnO+E0kPxqYslaOFUsAKxP9K1C/9MyYQhICbDDWdBkuIfwQQEiS/g7/mXqIY0CnLcPG20VrFvEv7jjXOaYD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731352602; c=relaxed/simple;
	bh=U8pDdN/y1X2d8cg8sXLonqZDBZjGjLP0o9eMqkSI3OI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qKYjfDn3KatjWDrJM/J/WRidgrKXCGkVNlFzYtIkIIeFR8pnuB01PKebGbOLl2LHkxjFe1w1NTqi/e0oxM0juj86gAOXHJ/ywzbOThjOZKzFmMEYGxKasB/+jMXsMudNmxAGMQXv8TijeMWBryiBedi+RoO/P4jcsksv3G/8QOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nx+GDnf9; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7763A40002;
	Mon, 11 Nov 2024 19:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731352598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d09C2IoK4+xkMEC1zVUKygGlrrSSMKoQFIvPALJmqwU=;
	b=nx+GDnf9lIHs25NLlu0g15jllh4b01LqYMOwt31eePV7VeOYP3SfgDgUdiQj9F5A6MEAi1
	PLTRxKbQvC+aMaV8Mr1zw0W08PkDosLWCcjPuoK9SBAFVPq4H5oINE0pYEeew41X5rWI9K
	xs2BVbs0fVBLw3G2YSp1kYh6MSpl69ttwq3nhm+XFb49Dzt6D5yoAJ9B3GWjPWT82iK+gu
	E3fJmCR8q5t1YuYzUk2j/jopoRwuXZFdU/6ChawefqunZg2Z5MF4njMOOZrTV7srN1IWBh
	lmAGax7wvtvAiWLpQfgizLvKSPiGkMf2dXtrLYQdm+5I8JABnrNM52gxHeAHIw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>,  Krzysztof Kozlowski
 <krzk@kernel.org>,  Richard Weinberger <richard@nod.at>,  Vignesh
 Raghavendra <vigneshr@ti.com>,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Herve Codina <herve.codina@bootlin.com>,
  Christopher Cordahi <christophercordahi@nanometrics.ca>
Subject: Re: [PATCH v2 1/6] memory: ti-aemif: Create aemif_set_cs_timings()
In-Reply-To: <20241106085507.76425-2-bastien.curutchet@bootlin.com> (Bastien
	Curutchet's message of "Wed, 6 Nov 2024 09:55:02 +0100")
References: <20241106085507.76425-1-bastien.curutchet@bootlin.com>
	<20241106085507.76425-2-bastien.curutchet@bootlin.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Mon, 11 Nov 2024 20:16:34 +0100
Message-ID: <8734jxshrh.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Bastien,

2 very minor nits

> +/**
> + * struct aemif_cs_timings: structure to hold cs timing configuration

Nitpick: s/cs/CS/ in plain english?


...

> +/**
> + * aemif_set_cs_timings - Set the timing configuration of a given chip s=
elect.
> + * @aemif: aemif device to configure
> + * @cs: index of the chip select to configure.

Nit: Spurious dot                               ^


...

> -	/* ... But configuring tighter timings is not an option. */
> -	else if (result > max)
> -		result =3D -EINVAL;
> -

Maybe this is too early to remove the check? If someone bisects and
falls in-between the patches of your series, NAND support would be
broken I guess?

With this fixed, feel free to add my:

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

