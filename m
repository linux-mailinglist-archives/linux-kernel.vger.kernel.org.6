Return-Path: <linux-kernel+bounces-204785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6818FF391
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6691F2755F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DE31990AB;
	Thu,  6 Jun 2024 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="cwVCBBwU"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2AC1953BE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717694408; cv=none; b=NzhLKvGUfCY58+bzHE0z0wuMDT3jD0Z3kohmuTSBf2P0JxFCBpbpwsyRWsIGSZGUkEwUAyu2o6rIMu14F9IbezRd+7EOLTh+cPYs7Eb0M1YGqFxTFqznJlZIs5e0Ull+xWA9jDf+99bvlPqmcdsrZnK8zymMdWzQEsK48ABE3U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717694408; c=relaxed/simple;
	bh=UN7p3cbCWVQOE/v+zSS3+mjmgi2loTXk/FfjqPXg+Ic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=To1S4IStTWSa7yQqu8tUCitHUew3bCed/mnvc2Mpex4uX9nxUIkPFqUApC25/QclZatjPXw1u/awd29Q6YcbeLwM0w6oFNipKYiZQTP2hlPnGyRNnsMgwVoXDdG7Jju9wvwIpK8tMrd+R/SHSZFVA9KUIslF4odq22wngZeR+7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=cwVCBBwU; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=PlE/RgkFbJeiOp5Rojavj8a4V784vhq4kLAdPvB7GYs=; b=cwVCBBwUAzHHbPMFAndj9DM2hC
	f8I6e+jCVQXMdVYG5ab7xKuEUDAythdOnH7SDn+pUwoD11by7Jq0S28kAk808TxrdQi3mVLpLZ2X0
	f8lBp55L/N2LIw0naDo1yYvvKLrkuJxPcQcbljytGtUUCYmqxK2qGQ5gITJ6+6GGMu6wM1qnCU8Vs
	xZRbeTUe7QbiIhjSQwHiowygxVydQhFYjslB4u07dSioqiMryD3tYwoUbGZ++ubSPNBY5Wcecdn4K
	JN4P+WfJLnzyLCj0ZnTgKMEcylj6qPji5owGdbGvR6qP4c6FwGKCu+blOcfLjbIonV/Vc4xkvQmKy
	zGBo6VMw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sFGmV-0002V0-By; Thu, 06 Jun 2024 19:20:03 +0200
Received: from [80.62.117.184] (helo=localhost)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sFGmR-000OQr-1u;
	Thu, 06 Jun 2024 19:20:03 +0200
From: Esben Haabendal <esben@geanix.com>
To: "Michael Walle" <mwalle@kernel.org>
Cc: "Tudor Ambarus" <tudor.ambarus@linaro.org>,  "Pratyush Yadav"
 <pratyush@kernel.org>,  "Miquel Raynal" <miquel.raynal@bootlin.com>,
  "Richard Weinberger" <richard@nod.at>,  "Vignesh Raghavendra"
 <vigneshr@ti.com>,  <linux-mtd@lists.infradead.org>,
  <linux-kernel@vger.kernel.org>,  "Rasmus Villemoes"
 <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: core: add flag for doing optional
 SFDP
In-Reply-To: <D1T10API5U80.1OKB56YTFGMTN@kernel.org> (Michael Walle's message
	of "Thu, 06 Jun 2024 17:06:31 +0200")
References: <20240603-macronix-mx25l3205d-fixups-v2-0-ff98da26835c@geanix.com>
	<20240603-macronix-mx25l3205d-fixups-v2-1-ff98da26835c@geanix.com>
	<a379a411-2c9e-4d9d-aa8f-4c4f3463cc27@linaro.org>
	<D1SZKLZBDDBA.1Z7ZD4UEOX05F@kernel.org>
	<48719b0f-1a7f-47f9-948a-c981a0a29b41@linaro.org>
	<D1T10API5U80.1OKB56YTFGMTN@kernel.org>
Date: Thu, 06 Jun 2024 19:20:02 +0200
Message-ID: <874ja6aszh.fsf@geanix.com>
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

"Michael Walle" <mwalle@kernel.org> writes:

> On Thu Jun 6, 2024 at 4:52 PM CEST, Tudor Ambarus wrote:
>> On 6/6/24 14:59, Michael Walle wrote:
>> > On Thu Jun 6, 2024 at 3:31 PM CEST, Tudor Ambarus wrote:
>> >> On 6/3/24 14:09, Esben Haabendal wrote:
>> >>> A dedicated flag for triggering call to
>> >>> spi_nor_sfdp_init_params_deprecated() allows enabling optional SFDP read
>> >>> and parse, with fallback to legacy flash parameters, without having dual,
>> >>> quad or octal parameters set in the legacy flash parameters.
>> >>>
>> >>> With this, spi-nor flash parts without SFDP that is replaced with a
>> >>> different flash NOR flash part that does have SFDP, but shares the same
>> >>> manufacturer and device ID is easily handled.
>> >>>
>> >>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> >>> ---
>> >>>  drivers/mtd/spi-nor/core.c | 3 ++-
>> >>>  drivers/mtd/spi-nor/core.h | 1 +
>> >>>  2 files changed, 3 insertions(+), 1 deletion(-)
>> >>>
>> >>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> >>> index 3e1f1913536b..1c4d66fc993b 100644
>> >>> --- a/drivers/mtd/spi-nor/core.c
>> >>> +++ b/drivers/mtd/spi-nor/core.c
>> >>> @@ -2933,7 +2933,8 @@ static void spi_nor_init_params_deprecated(struct spi_nor *nor)
>> >>>  
>> >>>  	spi_nor_manufacturer_init_params(nor);
>> >>>  
>> >>> -	if (nor->info->no_sfdp_flags & (SPI_NOR_DUAL_READ |
>> >>> +	if (nor->info->no_sfdp_flags & (SPI_NOR_TRY_SFDP |
>> >>
>> >> I don't like that we update deprecated methods. The solution though is
>> >> elegant.
>> > 
>> > I actually had the same concern. But currently there is no
>> > non-deprecated way to handle this case, right?
>> > 
>> > Right now we have the following cases:
>> >  (1) pure SFDP parsing
>> >  (2) non-SFDP flashes with static configuration only
>> >  (3) legacy implementation, where the magic flags decide whether we
>> >      use SFDP
>> > 
>> > Which case is eventually used depends on the ID of the flash -
>> > assuming there will only be IDs which either fall into (1) *or* (2).
>> > That assumption is clearly wrong :)
>> > 
>> > I'd propose a new case in spi_nor_init_params()
>> >  (4) try SFDP with a fallback to the static flags from the
>> >      flash_info db.
>> > 
>>
>> that's not that bad, but I would avoid doing it if it's not common. You
>> also have to update the core a bit, you can't use no_sfdp_flags &
>> TRY_SFDP, it's misleading. Does it worth it?
>
> IMHO no_sfdp_flags is the correct place (maybe TRY_SFDP is wrong,
> maybe SFDP_FALLBACK?)

TRY_SFDP might not be the best choice. But SFDP_FALLBACK sounds to me
like it is fallback _to_ SFDP, so rather counter-intuitive.

> because the flash is first treated like in
> case (2). Then SFDP is tried based on that flag.

It is first treated like in case (2), and then tried for case (1),
falling back to the result from case (2) if/when case (1) fails.

> Is it worth it? I
> don't know, Esben is doing the development here ;) So up to him.

I am not sure exactly how it should look like, but I do like the idea
proposed above, case (4). It is easier to describe and understand than
the current legacy implementation.

>> I won't oppose too much, but to me it feels that we're trying to keep
>> alive a dead man.
>
> Maybe, but we'd have a readily solution if we face a similar
> problem in the future. I'm really not sure, how many flashes there
> are, but I think these magic bits (which tells the legacy
> implementation to try SFDP) will mask quite a few of these.
> I.e. in an ideal world where we could finally drop case (3) and
> you'd need to split the flashes between case (1) or (2), I think
> there will be quite some in (4).

I like this. Judging by the way Macronix is handling this particular
chip, I strongly assume that there are several other examples of this
for other Macronix parts. Of-course, as long as the original part using
the particular flash id supported SFDP, and all later flashes using the
same id also does, none of this is needed.

/Esben

