Return-Path: <linux-kernel+bounces-224712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73D09125F1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139B61C2342B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD14615F31D;
	Fri, 21 Jun 2024 12:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="LI5Fi8CI"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CCC14D45A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718973951; cv=none; b=Ra118/fE2U0j+jj7lh6HyrFn1+U6Gej5v5HRzZQyf5qRshnhmP7105ASOGFLNUJ97XPP/JLuqyGcB1pchxq9Gcp3+5ofeO4n5Tz+TL+9Y1q9qTNj0DoH4csRuXKo3Sfykl7BT9WxWUqYK0//6SVON2aGkuB5T2xxR5kizbCjrQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718973951; c=relaxed/simple;
	bh=6NwreloHsiV0gBn7RVmYZnNCuQDF7PlKbG//1DTYq1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y5oRgCMZ6j6dNvguxgIxCx7McDCIMgYiA8LWrVHvW2Mjdooq1TNxSIg80Vj0Z9s2rKvVqQ3pNPHmd1oxTGq6dcF+w91VJ9I9JGtWr+00vo71UU5ST6TA4yX644VgTaoE+ihAcV4a3aqqI2ifkS8udffLPHNhsUHw2qbGT+PITdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=LI5Fi8CI; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=L8yrHVsxWDH2FoC1Mf/LumUyyPNxnkuSsKX0JVFnSLs=; b=LI5Fi8CIqHGk5NPzr8o6CPTndY
	4Ozmj32DSyAwa/mCoz92cGmhYl9hH5sQPh/+CFiFZY9xvHFv0mM6HhTFNjlqrQ6iaCh2C56CuK4Dj
	kGCG3kcNu3bm+bysPynf0aCorDfFfb962S4D+NnSeaS0ML76kd/MgeC41xxgSbrgtq30aQGKRqyJ9
	XVw2Bi+A9Ye1fOk7fs5QwdUraGbLwwsjb4MUZsd2iK1RKeRhKQNHvNvy13Q3RemSpU8fh/HYfXJ89
	45DS4BRRgoDgdRPOl79okVeWCml3wvPespksYcSPOm4KS8RagpdoFneWoAx+2wOMu+f7VdxF5LozU
	dwdSHsIQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sKde7-000KRb-8W; Fri, 21 Jun 2024 14:45:39 +0200
Received: from [80.62.116.144] (helo=localhost)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sKde7-0009LS-0d;
	Fri, 21 Jun 2024 14:45:38 +0200
From: Esben Haabendal <esben@geanix.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Miquel Raynal <miquel.raynal@bootlin.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Linus Walleij <linus.walleij@linaro.org>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,  Hartmut
 Birr <e9hack@gmail.com>
Subject: Re: [PATCH v2] mtd: spi-nor: winbond: fix w25q128 regression
In-Reply-To: <20240621120929.2670185-1-mwalle@kernel.org> (Michael Walle's
	message of "Fri, 21 Jun 2024 14:09:29 +0200")
References: <20240621120929.2670185-1-mwalle@kernel.org>
Date: Fri, 21 Jun 2024 14:45:38 +0200
Message-ID: <8734p679cd.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27313/Fri Jun 21 10:28:08 2024)

Michael Walle <mwalle@kernel.org> writes:

> Commit 83e824a4a595 ("mtd: spi-nor: Correct flags for Winbond w25q128")
> removed the flags for non-SFDP devices. It was assumed that it wasn't in
> use anymore. This wasn't true. Add the no_sfdp_flags as well as the size
> again.
>
> We add the additional flags for dual and quad read because they have
> been reported to work properly by Hartmut using both older and newer
> versions of this flash, the similar flashes with 64Mbit and 256Mbit
> already have these flags and because it will (luckily) trigger our
> legacy SFDP parsing, so newer versions with SFDP support will still get
> the parameters from the SFDP tables.
>
> Reported-by: Hartmut Birr <e9hack@gmail.com>
> Closes: https://lore.kernel.org/r/CALxbwRo_-9CaJmt7r7ELgu+vOcgk=xZcGHobnKf=oT2=u4d4aA@mail.gmail.com/
> Fixes: 83e824a4a595 ("mtd: spi-nor: Correct flags for Winbond w25q128")
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Reviewed-by: Esben Haabendal <esben@geanix.com>

> ---
> As mentioned this is for fixing the regression and a proper fix will
> make use of the TRY_SFDP (or whatever it will be named) mechanism.
> ---
>  drivers/mtd/spi-nor/winbond.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
> index ca67bf2c46c3..6b6dec6f8faf 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -105,7 +105,9 @@ static const struct flash_info winbond_nor_parts[] = {
>  	}, {
>  		.id = SNOR_ID(0xef, 0x40, 0x18),
>  		.name = "w25q128",
> +		.size = SZ_16M,
>  		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
> +		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
>  	}, {
>  		.id = SNOR_ID(0xef, 0x40, 0x19),
>  		.name = "w25q256",

