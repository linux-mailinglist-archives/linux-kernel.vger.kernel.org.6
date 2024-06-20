Return-Path: <linux-kernel+bounces-222846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA32291088B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F411C2320B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B521AE08E;
	Thu, 20 Jun 2024 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHqkRDUb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2A61AD4B5
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894134; cv=none; b=eit/SRA2uJtNYazWIKxtZSUjxj6T15Xa+Z3AMXRIQYuoGWeqVE1rOOoicLvwsoYVxm1v9whaqBkgfJT8ExSryXr9qhbg5pla12ogpT0BpEOSpkPF76y5fAx4Sr5LnE+Ek2be10l1ONe5GVQa69EJPUDPvLKrWw9YUXjKjnjtLtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894134; c=relaxed/simple;
	bh=EUEYZw/kD9IsbumaJrAAUG5hqVgcrDB6vpnPWq6BWs0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bV/9NbfMRilAQirK7im0PfsMoXjx7r0iTR49/krSCsPwFHYnHs4aX32ZOkqgy4JHH2CXwHQZ/YXOrXCFQQzTo9//Kx7dUkkBTZh8OsbWrIK4REJQTVq9TyYau2kxzKP4lH5xrv5poPzxXxZuySwKO24cTfJ7UvF0HF9gOswh61A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHqkRDUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1637C2BD10;
	Thu, 20 Jun 2024 14:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718894134;
	bh=EUEYZw/kD9IsbumaJrAAUG5hqVgcrDB6vpnPWq6BWs0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YHqkRDUb3YBDlGNlITyO0ypBjBWRg7S+fvdUj9JkmK+o7w4D/7yhz62NFEyukaTu+
	 m+AHZmoOGoz9LpwL4NcjHXVqx4lc5bb4u7SDvMv0IYLhZYeisQhNMPDaxUDdTclPGh
	 7g9aCowhLqvVxm9D6po9o26w+5gRNyMf7mpQ4iaWqhDCm3UslpN1MxYsLaRI/uNwwu
	 qou4h42lp7jT7cq0hOjaXOdYdYVe7RnKeZSgxvJNZP26CfzI9cJ8BzDup+0k6fqBdW
	 Z4LBTP9O1tHLPih048EyJ2K8IcmF0bRa6CkqR5ysWCwXo1iAq25RjRrf4Jk670jX/p
	 fLqJ9JLV8F7mg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Tudor Ambarus
 <tudor.ambarus@linaro.org>,  Miquel Raynal <miquel.raynal@bootlin.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Linus Walleij <linus.walleij@linaro.org>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,  e9hack
 <e9hack@gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: winbond: fix w25q128 regression
In-Reply-To: <91d155ab7526c14e882f7b88a129fbcd@kernel.org> (Michael Walle's
	message of "Thu, 20 Jun 2024 16:09:13 +0200")
References: <20240610074809.2180535-1-mwalle@kernel.org>
	<76f8be4e-3050-4ae6-93b4-9524a0689022@linaro.org>
	<D233KUGR81P5.1BJ8JSACE7C6A@kernel.org> <mafs04j9ng1ay.fsf@kernel.org>
	<91d155ab7526c14e882f7b88a129fbcd@kernel.org>
Date: Thu, 20 Jun 2024 16:35:31 +0200
Message-ID: <mafs0zfrfel70.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jun 20 2024, Michael Walle wrote:

>>>> > Commit 83e824a4a595 ("mtd: spi-nor: Correct flags for Winbond w25q128")
>>>> That commit did:
>>>> -       { "w25q128", INFO(0xef4018, 0, 64 * 1024, 256)
>>>> -               NO_SFDP_FLAGS(SECT_4K) },
>>>> +       { "w25q128", INFO(0xef4018, 0, 0, 0)
>>>> +               PARSE_SFDP
>>>> +               FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
>>>> 
>> [...]
>>>> > diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
>>>> > index ca67bf2c46c3..6b6dec6f8faf 100644
>>>> > --- a/drivers/mtd/spi-nor/winbond.c
>>>> > +++ b/drivers/mtd/spi-nor/winbond.c
>>>> > @@ -105,7 +105,9 @@ static const struct flash_info winbond_nor_parts[] = {
>>>> >  	}, {
>>>> >  		.id = SNOR_ID(0xef, 0x40, 0x18),
>>>> >  		.name = "w25q128",
>>>> > +		.size = SZ_16M,
>>>> >  		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
>>>> > +		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
>>>> and here you add dual and quad to trigger SFDP parsing I guess. All fine
>>>> if the old flash supports dual and quad read. But please update the
>>>> commit message describing the intention. With that ACK. Would be good to
>>>> have this merged soon.
>>> Right. It's not because it will trigger the SFDP parsing, but
>>> because that what was tested by Esben. We're lucky that this will
>>> trigger the SFDP parsing ;) I'll explain that in more detail and add
>>> a Link: to the bug report mail.
>> Should we treat this flash similar to the Macronix ones Esben sent out
>> patches for [0]? It seems that there are some old parts without SFDP
>> support and new ones with SFDP support. From your comment in [1]:
>> 
>>> This is an entry matching various flash families from Winbond, see my
>>> reply in v1. I'm not sure we should remove these as we could break the
>>> older ones, which might or might not have SFDP tables. We don't know.
>> Since the entry matches multiple families, do _all_ of them support dual
>> and quad read? If not, attempting to enable dual or quad reads on them
>> can cause problems.
>
> I rely on the information Helmut provided. Also the w25q64 and the w25q256
> both have these flags set. So I'd say it's less likely the 128 doesn't
> support it.

Okay, fair enough.

>
>> Also, for parts that _do_ have SFDP available, won't it be better to use
>> the information in SFDP instead of our hard-coded ones anyway? Using
>> SPI_NOR_TRY_SFDP here would let us do that.
>
> Sure, but this is about fixing the referenced commit. A later patch will
> then move that to TRY_SFDP. We can't fix this regression by introducing
> new code IMHO. This seems to be the easiest fix.

New code will make it harder to backport to stable kernels. Beyond that,
I don't see why we can't fix a regression with new code.

Here's why I suggested this: before 83e824a4a595 ("mtd: spi-nor: Correct
flags for Winbond w25q128"), all flashes with this ID got only the
SECT_4K flag -- and thus only single SPI mode. After that commit, all
flashes with this ID got their settings configured via SFDP. Using the
TRY_SFDP approach allows both of those configurations to co-exist. Old
ones still use the old configuration, new ones get to use SFDP.

Now we add a different configuration that adds dual and quad reads to
these old flashes. As mentioned above, this is unlikely to cause
problems, but a new configuration regardless. So _in principle_ I think
TRY_SFDP would be the best balance.

But I get your point -- since both w25q64 and w25q256 have these flags,
it is likely someone just never bothered updating w25q128. So this patch
LGTM. I'll apply it once you send a new version with an updated commit
message.

>
> -michael
>
>> [0]
>> https://lore.kernel.org/linux-mtd/20240603-macronix-mx25l3205d-fixups-v2-0-ff98da26835c@geanix.com/
>> [1]
>> https://lore.kernel.org/linux-mtd/0525440a652854a2a575256cd07d3559@walle.cc/
>

-- 
Regards,
Pratyush Yadav

