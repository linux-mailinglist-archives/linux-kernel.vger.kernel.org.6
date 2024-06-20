Return-Path: <linux-kernel+bounces-222779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B8191075F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E82286CB3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0541AD9CC;
	Thu, 20 Jun 2024 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhNn98oW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC1C30358
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718892136; cv=none; b=uDMlBgDwbhJYGcTY8G1O/23C5MmUfC/6uBh/FMYXpqZcxTOWMVe3YllySvjPDWNmcFJcy5SunC9HSJFiFAWVC3lsnG7+vgRuY34RdiOZqIF+YK8EiSF/uP6Ty/iMEuPR8Kv3RUpj3k+H2D9h9+PZImLDvK3Q5bG7/nSnMMCasmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718892136; c=relaxed/simple;
	bh=RwCFKECv1FH8ndgP92pPiQzSzdHIVvEvgd22L++EPMQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BbgDJtK202JrELfLZBCeN22KCYEBNk+BmJI3o3yvSUbPHtWZigPANPuEPh4Sc6xhnlmgI0KveUD+90Jx8FgCZQ/v/Hb8Yudj1/dc/9XOQG6iUCcB6HBZ3LP3t0j/fh1IFiGYScN53+0RpAoYndMEuzmdT/lWkUcpFh/nHaKZj+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhNn98oW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA805C2BD10;
	Thu, 20 Jun 2024 14:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718892136;
	bh=RwCFKECv1FH8ndgP92pPiQzSzdHIVvEvgd22L++EPMQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JhNn98oWOpK9K8Rg6GmI2o/wCl++W3pp1zyP2/2tGdVRqfospX6GHU0fgWs36r5ov
	 TGBk3T5QtQsa5PsRQK6FvhegAol+oHADaTWPEUxVjJWPyZaQqWU2sreL2DEwsffqr9
	 +9Czj7GYW6z7DV7X66t8LGojEC5JzwukYKQausHjEcW4MTuyShkljbIcCu7QegYDhS
	 vImFL81L1TVMSNCX7gFjJ+ulfFeSPiJXbOF6veIpU+/l9SW8EEJ+7XXTvl/6tY89d3
	 ExesLjO0CsO1VMUvUk4uwCmkIo0OuaAzE43Vb+/gc8wk/gUGkYmF+7ZUMMBgW/Gptu
	 YWN1pGLE1IQGw==
From: Pratyush Yadav <pratyush@kernel.org>
To: "Michael Walle" <mwalle@kernel.org>
Cc: "Tudor Ambarus" <tudor.ambarus@linaro.org>,  "Pratyush Yadav"
 <pratyush@kernel.org>,  "Miquel Raynal" <miquel.raynal@bootlin.com>,
  "Richard Weinberger" <richard@nod.at>,  "Vignesh Raghavendra"
 <vigneshr@ti.com>,  "Linus Walleij" <linus.walleij@linaro.org>,
  <linux-mtd@lists.infradead.org>,  <linux-kernel@vger.kernel.org>,
  "e9hack" <e9hack@gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: winbond: fix w25q128 regression
In-Reply-To: <D233KUGR81P5.1BJ8JSACE7C6A@kernel.org> (Michael Walle's message
	of "Tue, 18 Jun 2024 13:14:03 +0200")
References: <20240610074809.2180535-1-mwalle@kernel.org>
	<76f8be4e-3050-4ae6-93b4-9524a0689022@linaro.org>
	<D233KUGR81P5.1BJ8JSACE7C6A@kernel.org>
Date: Thu, 20 Jun 2024 16:02:13 +0200
Message-ID: <mafs04j9ng1ay.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jun 18 2024, Michael Walle wrote:

> Hi Tudor,
>
> On Tue Jun 18, 2024 at 12:33 PM CEST, Tudor Ambarus wrote:
>> On 6/10/24 8:48 AM, Michael Walle wrote:
>> > Commit 83e824a4a595 ("mtd: spi-nor: Correct flags for Winbond w25q128")
>>
>> That commit did:
>> -       { "w25q128", INFO(0xef4018, 0, 64 * 1024, 256)
>> -               NO_SFDP_FLAGS(SECT_4K) },
>> +       { "w25q128", INFO(0xef4018, 0, 0, 0)
>> +               PARSE_SFDP
>> +               FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
>>
[...]
>> > diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
>> > index ca67bf2c46c3..6b6dec6f8faf 100644
>> > --- a/drivers/mtd/spi-nor/winbond.c
>> > +++ b/drivers/mtd/spi-nor/winbond.c
>> > @@ -105,7 +105,9 @@ static const struct flash_info winbond_nor_parts[] = {
>> >  	}, {
>> >  		.id = SNOR_ID(0xef, 0x40, 0x18),
>> >  		.name = "w25q128",
>> > +		.size = SZ_16M,
>> >  		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
>> > +		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
>>
>> and here you add dual and quad to trigger SFDP parsing I guess. All fine
>> if the old flash supports dual and quad read. But please update the
>> commit message describing the intention. With that ACK. Would be good to
>> have this merged soon.
>
> Right. It's not because it will trigger the SFDP parsing, but
> because that what was tested by Esben. We're lucky that this will
> trigger the SFDP parsing ;) I'll explain that in more detail and add
> a Link: to the bug report mail.

Should we treat this flash similar to the Macronix ones Esben sent out
patches for [0]? It seems that there are some old parts without SFDP
support and new ones with SFDP support. From your comment in [1]:

> This is an entry matching various flash families from Winbond, see my
> reply in v1. I'm not sure we should remove these as we could break the
> older ones, which might or might not have SFDP tables. We don't know.

Since the entry matches multiple families, do _all_ of them support dual
and quad read? If not, attempting to enable dual or quad reads on them
can cause problems.

Also, for parts that _do_ have SFDP available, won't it be better to use
the information in SFDP instead of our hard-coded ones anyway? Using
SPI_NOR_TRY_SFDP here would let us do that.

[0] https://lore.kernel.org/linux-mtd/20240603-macronix-mx25l3205d-fixups-v2-0-ff98da26835c@geanix.com/
[1] https://lore.kernel.org/linux-mtd/0525440a652854a2a575256cd07d3559@walle.cc/

-- 
Regards,
Pratyush Yadav

