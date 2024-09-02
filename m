Return-Path: <linux-kernel+bounces-311487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CA29689BF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FB46B23640
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743B219E98A;
	Mon,  2 Sep 2024 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kmp7tOfD"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A182719E97C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286735; cv=none; b=ry2E209BN0OCIC2xpHpnOiQqGOcRc595oT5BxBuv5SHC9ljSdQGLt+tqsXMC1XG3oNK6BMv6PfLcl2ks0YxaRqefWLnS5BP3Tnex+t6e2Tpi3+0q85Okz0Hb/Isi2gPcEtls0l26pcnTHWgUWyP6eiAFFs/BJO7J06i8mud6X/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286735; c=relaxed/simple;
	bh=MXUsWjaPweiZIZEehN6iMcKrX5UI1bittIfnLKaBrHI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1Am+30ffc+SymuaWMf19tZ4UO2NCtlBZDDyl5DF7/zThIBSrtcsCUgaCpVXzGXPDSZskRHE7AubHYy14+T/+WOIs8ppMM9vf/ESM4DSGsa9rf589J3v6/JKXLSsMDNUidiTfjubk3WDHg7MLaGF59f3xZ/pp+9Xwr6q7sH3Unc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kmp7tOfD; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F3F6FF802;
	Mon,  2 Sep 2024 14:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725286726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JF7JwMRD9iwv16HTVdkRVbNX1b4HkqNeP3wNC+6sYi4=;
	b=kmp7tOfDYQRIxM4dxZwo5PUGEyMKtUFGcxhq/4Scxhh5ecbzZRxRcFP66Q+agVwruXGj+x
	Q2gIpAICGAs1nXXelxQCG147MmAhje3LnpbbzKWP8xStceAM29ZdMa5/HVJDkzLB1nRLA5
	eNBDokn/ZBHR+eNAJxkSZoBpgivegWpFO1fds1pLxtlFipEgCqAZg34clZvC4DWAQaxbZw
	oRZ2cu/bD4Oea5o9k6xZ16TS29MS4pypNd3uQ5bHSctUZWhZXNZmiO/mxkyJN0q0RONDVh
	pldNef6z3hYC5zowqhrAh/Ky4W52SKIu++f9y5ZNvnXR6jpTLLa0zApqcOCHJg==
Date: Mon, 2 Sep 2024 16:18:44 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Martin Kurbanov <mmkurbanov@salutedevices.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
 <kernel@salutedevices.com>, Richard Weinberger <richard@nod.at>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, Michael Walle <michael@walle.cc>, "Mark
 Brown" <broonie@kernel.org>, Chia-Lin Kao <acelan.kao@canonical.com>, "Md
 Sadre Alam" <quic_mdalam@quicinc.com>, Ezra Buehler
 <ezra.buehler@husqvarnagroup.com>, Sridharan S N <quic_sridsn@quicinc.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: Re: [PATCH v2 2/5] mtd: spinand: add OTP support
Message-ID: <20240902161844.2bf982ef@xps-13>
In-Reply-To: <bb137aef-4ca9-4825-99b7-12f7e17c9550@salutedevices.com>
References: <20240827174920.316756-1-mmkurbanov@salutedevices.com>
	<20240827174920.316756-3-mmkurbanov@salutedevices.com>
	<bb137aef-4ca9-4825-99b7-12f7e17c9550@salutedevices.com>
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

Hi Martin,

mmkurbanov@salutedevices.com wrote on Tue, 27 Aug 2024 20:57:04 +0300:

> Hello, Miquel. Thank you for the review.
> Regarding your question ( https://lore.kernel.org/all/20240717103623.6d6b=
63be@xps-13/ ):
>=20
> >> +int spinand_otp_read(struct spinand_device *spinand, loff_t from, siz=
e_t len,
> >> +		     u8 *buf, size_t *retlen);
> >> +
> >> +int spinand_otp_write(struct spinand_device *spinand, loff_t from, si=
ze_t len,
> >> +		      const u8 *buf, size_t *retlen);
> >> + =20
> >=20
> > Why exposing spinand_otp_read and spinand_otp_write ? =20
>=20
> For the SPI-NAND chips we have (Micron, ESMT, FORESEE), the command
> sequence for reading/writing OTP is the same. I decided to make these
> functions global because other chips probably have similar read/write
> OTP operations as well.

Of course, I understand you might need them, but then the change does
not belong to this patch. Actually you've done that correctly for the
spinand_wait() helper.

You can do all the "make foo() global" operations in a single patch if
you want.

I will soon review more in deep the content of this patchset again.

Thanks,
Miqu=C3=A8l

