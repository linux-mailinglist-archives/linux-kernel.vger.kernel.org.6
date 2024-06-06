Return-Path: <linux-kernel+bounces-204787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 729858FF395
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983EA1C26456
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4881990B0;
	Thu,  6 Jun 2024 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="G6JZwJS/"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DCD197A8F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717694457; cv=none; b=o7+7rg0V27gHOuIIWV3HU9oPZDBu5hHDsoaAhKLBw20E7DFtVDyVCw6HpB6WBReCAyiAHOtiuoWO1wxAHMGbzg8JJuWiBx7HRdj1VLL0YBdcFlCvqcndGDlLm6Od5xx+prAviyPXh62/d8402cBD/755bBWyFr8Q72IeCYC7LKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717694457; c=relaxed/simple;
	bh=o6l8Q90eG0SC0p7aKRIvyUpjH+PHEbLFWDBdZ0rdMHI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fQzcg1MvMiSNQL1sn1fbZzf/6gLP31SuQNPYV6thAuAr3r51zAKi5qlBWlKvxt6W3Y5ev69x3Kq/ommBqBjIDqbyMcP6gMHJ2KJySq+EF7f/bO1sUR95zhv/Dvxs2VXleEoWUEJ77AxSKKSJ4fcjSLpcJP0MAwDzJTto3QVChU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=G6JZwJS/; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=uh6hmNB3/hOoQGCh2kYcY8ljw2iK4guW9QdsRKpcjAk=; b=G6JZwJS//bgOQ0onfnj9tl/maL
	Tjc/+1Q2C/xDcPsW4uHMsBPZF6Gtmf/T8YnmluG1Im5xep2rTE3d0vKQbNp+6V5OAlzgA7r0qMFQB
	hRMEHyGmMyYaHHMExZ026+t+kmybyRuQcgb+q2pXD2n/5Am7LahPuf6rWAwXXcb93jRPZfM9H8bt3
	M8RqCFfK3m/cXS7XnpskiFR8/yz2HQpDUn6YrqbG1RY8uL7IP0d40jcTRKVSbFE/HkQwxjkATd8Yz
	m+6FxijHUNXJJBUfSHv8Fjmy5rXaO7FmFFXAyyrKdOf2xwrnXHtkkEPIH6sDjHj+pCLWfxW8eikXC
	+yYH94KQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sFGnJ-0002at-BP; Thu, 06 Jun 2024 19:20:53 +0200
Received: from [80.62.117.184] (helo=localhost)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sFGnF-000484-1p;
	Thu, 06 Jun 2024 19:20:53 +0200
From: Esben Haabendal <esben@geanix.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Michael Walle <mwalle@kernel.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Miquel Raynal <miquel.raynal@bootlin.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: core: add flag for doing optional
 SFDP
In-Reply-To: <48719b0f-1a7f-47f9-948a-c981a0a29b41@linaro.org> (Tudor
	Ambarus's message of "Thu, 6 Jun 2024 15:52:35 +0100")
References: <20240603-macronix-mx25l3205d-fixups-v2-0-ff98da26835c@geanix.com>
	<20240603-macronix-mx25l3205d-fixups-v2-1-ff98da26835c@geanix.com>
	<a379a411-2c9e-4d9d-aa8f-4c4f3463cc27@linaro.org>
	<D1SZKLZBDDBA.1Z7ZD4UEOX05F@kernel.org>
	<48719b0f-1a7f-47f9-948a-c981a0a29b41@linaro.org>
Date: Thu, 06 Jun 2024 19:20:52 +0200
Message-ID: <87zfry9edn.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27298/Thu Jun  6 10:30:08 2024)

Tudor Ambarus <tudor.ambarus@linaro.org> writes:

> On 6/6/24 14:59, Michael Walle wrote:
>> On Thu Jun 6, 2024 at 3:31 PM CEST, Tudor Ambarus wrote:
>>> On 6/3/24 14:09, Esben Haabendal wrote:
>>>> A dedicated flag for triggering call to
>>>> spi_nor_sfdp_init_params_deprecated() allows enabling optional SFDP read
>>>> and parse, with fallback to legacy flash parameters, without having dual,
>>>> quad or octal parameters set in the legacy flash parameters.
>>>>
>>>> With this, spi-nor flash parts without SFDP that is replaced with a
>>>> different flash NOR flash part that does have SFDP, but shares the same
>>>> manufacturer and device ID is easily handled.
>>>>
>>>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>>>> ---
>>>>  drivers/mtd/spi-nor/core.c | 3 ++-
>>>>  drivers/mtd/spi-nor/core.h | 1 +
>>>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>>>> index 3e1f1913536b..1c4d66fc993b 100644
>>>> --- a/drivers/mtd/spi-nor/core.c
>>>> +++ b/drivers/mtd/spi-nor/core.c
>>>> @@ -2933,7 +2933,8 @@ static void spi_nor_init_params_deprecated(struct spi_nor *nor)
>>>>  
>>>>  	spi_nor_manufacturer_init_params(nor);
>>>>  
>>>> -	if (nor->info->no_sfdp_flags & (SPI_NOR_DUAL_READ |
>>>> +	if (nor->info->no_sfdp_flags & (SPI_NOR_TRY_SFDP |
>>>
>>> I don't like that we update deprecated methods. The solution though is
>>> elegant.
>> 
>> I actually had the same concern. But currently there is no
>> non-deprecated way to handle this case, right?
>> 
>> Right now we have the following cases:
>>  (1) pure SFDP parsing
>>  (2) non-SFDP flashes with static configuration only
>>  (3) legacy implementation, where the magic flags decide whether we
>>      use SFDP
>> 
>> Which case is eventually used depends on the ID of the flash -
>> assuming there will only be IDs which either fall into (1) *or* (2).
>> That assumption is clearly wrong :)
>> 
>> I'd propose a new case in spi_nor_init_params()
>>  (4) try SFDP with a fallback to the static flags from the
>>      flash_info db.
>> 
>
> that's not that bad, but I would avoid doing it if it's not common. You
> also have to update the core a bit, you can't use no_sfdp_flags &
> TRY_SFDP, it's misleading. Does it worth it?
>
> I won't oppose too much, but to me it feels that we're trying to keep
> alive a dead man.

Which dead man are you referring to? The legacy implementation or the
old non-SFDP Macronix part?

/Esben

