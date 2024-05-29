Return-Path: <linux-kernel+bounces-194062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 587908D360C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 861F81C23719
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A84F180A90;
	Wed, 29 May 2024 12:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mfW57XT0"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC29738F96
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 12:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716984811; cv=none; b=BON4L6Qk5x1Ccibp5K2srSk+Ec4Ap9Zs7M556Ife9mh7dWiQ6yyixMsh8L+hv7IzYRco86zFCRtYSnZHtJWl8tj0HbRZrHbCCH7gkpm+R07OTtfwOAQHgQfUmKmnsP3JDJvDPGQYHR/DH2H3noK+bM5Gxia1v6xPo1IM3xx6iak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716984811; c=relaxed/simple;
	bh=qPE9lYK/jtCaQQJJj72PN/tJ5wf6JCOgn3hLbpwt2pk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VNLBsMCR3Q4azozV3LOrk2l+0/5NUapXcFsJPuoMz6o0lY/pE6RLsxQ3Dc3drUjVm0aWt2j25IBQpOrmgnMghwiXF+OHMq702r+gW+MRVZireFIx3x146lbzzHqx/WOlFI3XrK4vz3E0r8hn28v4LFy1RWF8v4hNDf6aYSAZmzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mfW57XT0; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 333E51BF20C;
	Wed, 29 May 2024 12:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716984807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPE9lYK/jtCaQQJJj72PN/tJ5wf6JCOgn3hLbpwt2pk=;
	b=mfW57XT0mO3W9hMc7glrP0zAYm1E7+Z3v5Q8jnwOfa06mrDfpmU0coM6lH/iq5tq96vMh3
	+gth/Dq0QThzCc+BLom/aNKoFwiFrxSNu9IMfHdgAwGYYoK9xjmO36V1dNxzv4HjfHvBDd
	VGHQldoYEnRuaYOhN0EzUq4gS+VbagQp65Q6FxXTTLeooike/X6dLExb8FogcoEOdBymMX
	YkpsWvJ4cGJxNpcW7upRdLwOCk29YHwr9FnLWOcxju61DFPb1Mlvlt8GgBTxG2PGps1MJk
	voWeCBh3k3Ov0F3zrjzspcqcp9LxiOytZsRz2vuqaEZRFvug+E8P+59/RON5DA==
Date: Wed, 29 May 2024 14:13:23 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, David Woodhouse <David.Woodhouse@intel.com>, Akinobu
 Mita <akinobu.mita@gmail.com>, Artem Bityutskiy
 <artem.bityutskiy@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: make mtd_test.c a separate module
Message-ID: <20240529141323.7015f3d9@xps-13>
In-Reply-To: <20240529095049.1915393-1-arnd@kernel.org>
References: <20240529095049.1915393-1-arnd@kernel.org>
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

Hi Arnd,

arnd@kernel.org wrote on Wed, 29 May 2024 11:50:39 +0200:

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> This file gets linked into nine different modules, which causes a warning:
>=20
> scripts/Makefile.build:236: drivers/mtd/tests/Makefile: mtd_test.o is add=
ed to multiple modules: mtd_nandbiterrs mtd_oobtest mtd_pagetest mtd_readte=
st mtd_speedtest mtd_stresstest mtd_subpagetest mtd_torturetest

I've never experienced this warning myself, how did you produce it?

> Make it a separate module instead.

I'm not a total fan of this just because it now requires an additional
step to insert these test modules (they are likely used for
debugging/development purposes, so not properly installed in the
rootfs). Is there any chance we can find another way?

Thanks,
Miqu=C3=A8l

