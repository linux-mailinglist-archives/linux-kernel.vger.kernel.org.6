Return-Path: <linux-kernel+bounces-320798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE3E971056
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E74E01C22287
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7B81B010A;
	Mon,  9 Sep 2024 07:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jz/w9S0U"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BFB1AF4DC
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868379; cv=none; b=MW3X3o2pKmrQu5T/FwqvuiDGP0VD/fSgfXFOlQ/RfVPmXrVCjKq1IMtY74DLRH8LZfKK5F6ROUlTkZ7f8k5uFcE4WJM3nTm67rG5OLvVYJE371hn/uIuOD6fUuvGy6cEMQwT7sLiC3vq/K5s4DQF44MSjHmHEhpFj29cQcksLBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868379; c=relaxed/simple;
	bh=mlxlmUquTmFkGQqdmXvdPV3nUNa9fBi5zLHacZJ5o/8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LdF1U+h/9LxLlhepyoLYK64FirZWOT5KvhicK8alHo5VpUn4TjtychkGLJBGXre8RCMw8N4xWHSqp0uiZY++32Qs7r9F675dEyXJdZ5AyTSN3neqqrcHT09HUSudi1zytJwZ/Yh1HW0MhTDpfKTSgzW6OwCSPnNBmTdK5+WDct0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jz/w9S0U; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 63215E0002;
	Mon,  9 Sep 2024 07:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725868370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mlxlmUquTmFkGQqdmXvdPV3nUNa9fBi5zLHacZJ5o/8=;
	b=jz/w9S0UQaB4D8O0Wr59wr3duykztU3f2WTxMBQ0sM6bQJT53Rb9IgVadC5YSYXscBy1iJ
	tEkekPl2LG5xUJBLtFZSXyCfk9iK/++xGGAkvZMyrt4R9M7OMfD5C+glg5gWPiOxRpw2cJ
	2pGMOK1eHHLY0aX6D+DxTA4khYh+i9eLwXdk2tsKH5aK9fpxsYmO4qp4sg/KXDkxZ4wNFn
	8hEYruSZU1HrWuwKoqUv7ONkscsX3IgrQGnp4+wKaPmBEedzSKcMFvGBP1yVDOou37RK8w
	mK9ZHGa3sy5pTppMsbiGKqLbA+Fg5SzaM/yWl9ItW8DtAMmT9mE+vcEoc5RHBQ==
Date: Mon, 9 Sep 2024 09:52:47 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Michael Walle <mwalle@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, Jon Hunter
 <jonathanh@nvidia.com>
Subject: Re: [PATCH] mtd: spi-nor: fix flash probing
Message-ID: <20240909095247.48358afa@xps-13>
In-Reply-To: <ad9ee29c-b96a-4861-a7cd-b8649a3d1f3a@linaro.org>
References: <20240909072854.812206-1-mwalle@kernel.org>
	<ad9ee29c-b96a-4861-a7cd-b8649a3d1f3a@linaro.org>
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

Hey,

tudor.ambarus@linaro.org wrote on Mon, 9 Sep 2024 08:35:23 +0100:

> On 9/9/24 8:28 AM, Michael Walle wrote:
> > Fix flash probing by name. Flash entries without a name are allowed
> > since commit 15eb8303bb42 ("mtd: spi-nor: mark the flash name as
> > obsolete"). But it was just until recently that a flash entry without a
> > name was actually introduced. This triggers a bug in the legacy probe by
> > name path. Skip entries without a name to fix it.
> >=20
> > Fixes: 2095e7da8049 ("mtd: spi-nor: spansion: Add support for S28HS256T=
")
> > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > Closes: https://lore.kernel.org/r/66c8ebb0-1324-4ad9-9926-8d4eb7e1e63a@=
nvidia.com/
> > Tested-by: Jon Hunter <jonathanh@nvidia.com>
> > Signed-off-by: Michael Walle <mwalle@kernel.org> =20
>=20
> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

This patch will only apply on top of spi-nor/next. It would spend more
time in -next if one of you applied it to this branch before sending
the MR?

Cheers,
Miqu=C3=A8l

