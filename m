Return-Path: <linux-kernel+bounces-222791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DED9910799
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376EE285766
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D391AD9D3;
	Thu, 20 Jun 2024 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNW5f+4b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FED1AD9CC
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718892558; cv=none; b=kbIGaZlbABKv1dRcYo0wi0XAixJQES/XABHH5KzY1XAM/bGXX2HTXZnEmWZSqI2EQtVH9OsQhR1Kc/oQxcoxOTpS1GKAIZbCPJq+vGBp1E14mrpc1h4Fzz9mt1mKrAEBhYzfKY3adiyg7vg6rqK687PJENc9EmVvJOR2PxATwrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718892558; c=relaxed/simple;
	bh=Mb47V/TtEOTke3i6u+2FiWov3PpilA3tj3biR8NUCHE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=WLhmVbvwa2mu1sutLTVqA2RKhnsghdIYRyB90cdm3XoQupb33yvpZLjFCrZ6IxrORweQeEpWn5M4SGyELEGYBISfy1AyV4/OtCc84hxyd0gh8zQfeB4D9y9a0q/HQP06+2pAcnsM70EZP9iEm78PSADVrhx1Kdf+uc5zcj1dWvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNW5f+4b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78886C2BD10;
	Thu, 20 Jun 2024 14:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718892557;
	bh=Mb47V/TtEOTke3i6u+2FiWov3PpilA3tj3biR8NUCHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qNW5f+4bhHEwW0qLaY3V4ZmgpgyPR/5voNTZycSXO3vvzj5v2O7pi7do0PvO5xcog
	 IKZe2IHTWQ0Utcz725ZsO+fZSuJOJMOiIcqpETafnUNoTHf9ZRvAuhu2QHBtaJ+lWt
	 uinsRk4bnZO88HEpWZOb6PCy+rVeRrU0dR9885KDqrk6yDCzuHO2Dr/NDNybWKFK3G
	 3iuvsyc4fJVvzYIZGZI445r4QotmSA1hBOkZR0d017Os/lP0FKHGrn5Em35KAvroZp
	 2r+g2MSfTcocKi1Qn57px9yjInEFICuzBZxx1egp2AY/zVAjcV7Ec/xjKF1Z2vijBD
	 H2YrHzj+UZCYw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 20 Jun 2024 16:09:13 +0200
From: Michael Walle <mwalle@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, Linus Walleij <linus.walleij@linaro.org>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, e9hack
 <e9hack@gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: winbond: fix w25q128 regression
In-Reply-To: <mafs04j9ng1ay.fsf@kernel.org>
References: <20240610074809.2180535-1-mwalle@kernel.org>
 <76f8be4e-3050-4ae6-93b4-9524a0689022@linaro.org>
 <D233KUGR81P5.1BJ8JSACE7C6A@kernel.org> <mafs04j9ng1ay.fsf@kernel.org>
Message-ID: <91d155ab7526c14e882f7b88a129fbcd@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

>>> > Commit 83e824a4a595 ("mtd: spi-nor: Correct flags for Winbond w25q128")
>>> 
>>> That commit did:
>>> -       { "w25q128", INFO(0xef4018, 0, 64 * 1024, 256)
>>> -               NO_SFDP_FLAGS(SECT_4K) },
>>> +       { "w25q128", INFO(0xef4018, 0, 0, 0)
>>> +               PARSE_SFDP
>>> +               FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
>>> 
> [...]
>>> > diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
>>> > index ca67bf2c46c3..6b6dec6f8faf 100644
>>> > --- a/drivers/mtd/spi-nor/winbond.c
>>> > +++ b/drivers/mtd/spi-nor/winbond.c
>>> > @@ -105,7 +105,9 @@ static const struct flash_info winbond_nor_parts[] = {
>>> >  	}, {
>>> >  		.id = SNOR_ID(0xef, 0x40, 0x18),
>>> >  		.name = "w25q128",
>>> > +		.size = SZ_16M,
>>> >  		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
>>> > +		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
>>> 
>>> and here you add dual and quad to trigger SFDP parsing I guess. All 
>>> fine
>>> if the old flash supports dual and quad read. But please update the
>>> commit message describing the intention. With that ACK. Would be good 
>>> to
>>> have this merged soon.
>> 
>> Right. It's not because it will trigger the SFDP parsing, but
>> because that what was tested by Esben. We're lucky that this will
>> trigger the SFDP parsing ;) I'll explain that in more detail and add
>> a Link: to the bug report mail.
> 
> Should we treat this flash similar to the Macronix ones Esben sent out
> patches for [0]? It seems that there are some old parts without SFDP
> support and new ones with SFDP support. From your comment in [1]:
> 
>> This is an entry matching various flash families from Winbond, see my
>> reply in v1. I'm not sure we should remove these as we could break the
>> older ones, which might or might not have SFDP tables. We don't know.
> 
> Since the entry matches multiple families, do _all_ of them support 
> dual
> and quad read? If not, attempting to enable dual or quad reads on them
> can cause problems.

I rely on the information Helmut provided. Also the w25q64 and the 
w25q256
both have these flags set. So I'd say it's less likely the 128 doesn't
support it.

> Also, for parts that _do_ have SFDP available, won't it be better to 
> use
> the information in SFDP instead of our hard-coded ones anyway? Using
> SPI_NOR_TRY_SFDP here would let us do that.

Sure, but this is about fixing the referenced commit. A later patch will
then move that to TRY_SFDP. We can't fix this regression by introducing
new code IMHO. This seems to be the easiest fix.

-michael

> 
> [0] 
> https://lore.kernel.org/linux-mtd/20240603-macronix-mx25l3205d-fixups-v2-0-ff98da26835c@geanix.com/
> [1] 
> https://lore.kernel.org/linux-mtd/0525440a652854a2a575256cd07d3559@walle.cc/

