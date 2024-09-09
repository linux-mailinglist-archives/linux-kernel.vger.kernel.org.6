Return-Path: <linux-kernel+bounces-320957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36936971285
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00292810A3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7271B1D4B;
	Mon,  9 Sep 2024 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DZcqSQ0e"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CBA176237
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725871685; cv=none; b=oDv5PWxZIr3mpFwJ+RmS8cEW0FzyIWjqvBSbzToJ2LcCAx6ksueUlYD/7qg3Zwjl8t+2AD68hC++soH0XIjWbA+KahTsWC/h6WrzVrUQg2m5xlIHa1ABG4wB9T2QDT/09jyIjM8DyWrwsHttumNmLh4PYjFoM1hdxJAFwnzriLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725871685; c=relaxed/simple;
	bh=cI1Oo7wkDpBlnba/DQ4DMEwSaxb9PAp2UzV1h++TkLA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSPDN8Se59VyViNIFMzbXErooDnHdXGgUCmq9u+0HSqez4ikSMGRPlDap0S5L9XeOLEHFsyRCcWYt4cwM4DH+7iz0tJNZ4b2DtakpAGRXwL6AATWGCXtMPkagMKoXMQr8qK/0nx1eKbGznk7VtvpWIU7RRHfTl0UXEd1VfsygaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DZcqSQ0e; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5AE21FF809;
	Mon,  9 Sep 2024 08:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725871675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tt5NAasuaR7WtHvIUNDpIY6Ko//rXYjwz5p1j6j4dU8=;
	b=DZcqSQ0elPS7iA6ohxz2cijQiD1rky9EiPS8bk5jCJ+GDgyQ9tD1zoH9fg6E7QiF2ZKhfP
	/S+eQdq/rQec/fv82l2JMWkKPKaSJmK+aC7zSKFzvmy39/OGnkt/iQ+OqMY/jobF8QJ6Kz
	GZGkVNA4WPDyEx3Ag0rY2gDi0HGA9qSE3DiuytEaJHFbb6kBNQnLdWKQxrrsoJLfs/TM+O
	uRV1z8hwQNbreKnPBKEuN3op0qkIty3JUvrbAiUM0ajD32rie9f5wU5Qfir5zun7dJHMwi
	hXmaCQEMSzNqG0oRcCippD8tPXP+imNjxAmCWQ4SlFsNdHRrjirpG66Zj9xBYQ==
Date: Mon, 9 Sep 2024 10:47:53 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Michael Walle <mwalle@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, Jon Hunter
 <jonathanh@nvidia.com>
Subject: Re: [PATCH] mtd: spi-nor: fix flash probing
Message-ID: <20240909104753.0ce41fb8@xps-13>
In-Reply-To: <b2d0ce1d-fa46-43e9-bb29-c98d1161aae7@linaro.org>
References: <20240909072854.812206-1-mwalle@kernel.org>
	<ad9ee29c-b96a-4861-a7cd-b8649a3d1f3a@linaro.org>
	<20240909095247.48358afa@xps-13>
	<b2d0ce1d-fa46-43e9-bb29-c98d1161aae7@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Tudor,

> >>> Fixes: 2095e7da8049 ("mtd: spi-nor: spansion: Add support for S28HS25=
6T")
> >>> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> >>> Closes: https://lore.kernel.org/r/66c8ebb0-1324-4ad9-9926-8d4eb7e1e63=
a@nvidia.com/
> >>> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> >>> Signed-off-by: Michael Walle <mwalle@kernel.org>   =20
> >>
> >> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org> =20
> >=20
> > This patch will only apply on top of spi-nor/next. It would spend more
> > time in -next if one of you applied it to this branch before sending
> > the MR?
> >  =20
>=20
> The patch is intended for spi-nor/next indeed, as the blamed commit was
> just recently queued. No need to take it through mtd/fixes. Pratyush
> will take it via spi-nor/next.

Ok perfect, thanks!

Miqu=C3=A8l

