Return-Path: <linux-kernel+bounces-206162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 572ED9004FA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB78BB28FDB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCC8195F34;
	Fri,  7 Jun 2024 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="WrX6Z9ve"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29008194ACD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767059; cv=none; b=YAo82jEhDw7YUzWSWCxgCcTQRpNcdOkLIb8GuhEue/PWyfBJPOQBOHxabOP5RW6qre/sOCzGxb+byhFRPPXfj9S5hSQU5gFVVJqu3xVEVyu/EJA0o2lAEtudP36M943+7odP1tA+9se1nuoSDPr/wP27ZLv8v0sGBmXysaB3RRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767059; c=relaxed/simple;
	bh=pOpmFmCFocAM6Qwli2bgU/R17K3mZsTuv67wgEL5VOc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m7hdsVY4WA9u9wpRm9+3kgSi5oFZSV3H4cZU2gUJ30abrOBy70S7JH54UDgbwMZ4LyEVHXD2Jel9Jg66E/fBH0WZ38HdtxHuYeoTcxDiZafobEv49U2ouKzSCwOXCLfawJU7suOskx3k8Y7p9n5A2evE3h2N6jvg8h7t2Qj+gJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=WrX6Z9ve; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=4RK0KP7M28kJmksdDmKUG3G7jD95U6jiMrw57i0ZVTM=; b=WrX6Z9ve4U6Im4uuz46Fg4XVd8
	JGVOITQkIYs/cPdZB1J1TAMmvmrvcg6FUzBV5GdtGYXnBM+AcTkOOyotGGRS8x9GbwytmUWIfXkRS
	HvTJKZ3vRzhOpDs6pLBxtbNnp3X112Fr0LMY0Eg0aKgQIfUkaX6H2MJA+xNUYrS15D0kBwfo1l35u
	TxtUrExfdcCpi3N2CY9HRqZ4eOXaFN7qg+c/00ERts9eydWnEl9U0TQVbCI7DXGi1UcHkWg/zktEE
	i0S8TuoQOglfFCQF4Pt6sw8qeTiBvsnN2yWqEDxEB1CTXNX6LhBgBMj0UxuSDjYoYL9amoGnT09G9
	2BAWAMgQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sFZgE-0001N2-De; Fri, 07 Jun 2024 15:30:50 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sFZgA-000BVy-0C;
	Fri, 07 Jun 2024 15:30:50 +0200
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
In-Reply-To: <1d683b33-16db-4d81-92cb-d98e35b87cba@linaro.org> (Tudor
	Ambarus's message of "Fri, 7 Jun 2024 10:22:55 +0100")
References: <20240603-macronix-mx25l3205d-fixups-v2-0-ff98da26835c@geanix.com>
	<20240603-macronix-mx25l3205d-fixups-v2-1-ff98da26835c@geanix.com>
	<a379a411-2c9e-4d9d-aa8f-4c4f3463cc27@linaro.org>
	<D1SZKLZBDDBA.1Z7ZD4UEOX05F@kernel.org>
	<48719b0f-1a7f-47f9-948a-c981a0a29b41@linaro.org>
	<D1T10API5U80.1OKB56YTFGMTN@kernel.org> <874ja6aszh.fsf@geanix.com>
	<1d683b33-16db-4d81-92cb-d98e35b87cba@linaro.org>
Date: Fri, 07 Jun 2024 15:30:49 +0200
Message-ID: <87le3g283a.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27299/Fri Jun  7 10:27:20 2024)

Tudor Ambarus <tudor.ambarus@linaro.org> writes:

> On 6/6/24 18:20, Esben Haabendal wrote:
>> "Michael Walle" <mwalle@kernel.org> writes:
>> 
>>> On Thu Jun 6, 2024 at 4:52 PM CEST, Tudor Ambarus wrote:
>>>> On 6/6/24 14:59, Michael Walle wrote:
>>>>> On Thu Jun 6, 2024 at 3:31 PM CEST, Tudor Ambarus wrote:
>>>>>> On 6/3/24 14:09, Esben Haabendal wrote:
>>>>>>> A dedicated flag for triggering call to
>>>>>>> spi_nor_sfdp_init_params_deprecated() allows enabling optional SFDP read
>>>>>>> and parse, with fallback to legacy flash parameters, without having dual,
>>>>>>> quad or octal parameters set in the legacy flash parameters.
>>>>>>>
>>>>>>> With this, spi-nor flash parts without SFDP that is replaced with a
>>>>>>> different flash NOR flash part that does have SFDP, but shares the same
>>>>>>> manufacturer and device ID is easily handled.
>>>>>>>
>>>>>>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>>>>>>> ---
>>>>>>>  drivers/mtd/spi-nor/core.c | 3 ++-
>>>>>>>  drivers/mtd/spi-nor/core.h | 1 +
>>>>>>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>>>>>>> index 3e1f1913536b..1c4d66fc993b 100644
>>>>>>> --- a/drivers/mtd/spi-nor/core.c
>>>>>>> +++ b/drivers/mtd/spi-nor/core.c
>>>>>>> @@ -2933,7 +2933,8 @@ static void spi_nor_init_params_deprecated(struct spi_nor *nor)
>>>>>>>  
>>>>>>>  	spi_nor_manufacturer_init_params(nor);
>>>>>>>  
>>>>>>> -	if (nor->info->no_sfdp_flags & (SPI_NOR_DUAL_READ |
>>>>>>> +	if (nor->info->no_sfdp_flags & (SPI_NOR_TRY_SFDP |
>>>>>>
>>>>>> I don't like that we update deprecated methods. The solution though is
>>>>>> elegant.
>>>>>
>>>>> I actually had the same concern. But currently there is no
>>>>> non-deprecated way to handle this case, right?
>>>>>
>>>>> Right now we have the following cases:
>>>>>  (1) pure SFDP parsing
>>>>>  (2) non-SFDP flashes with static configuration only
>>>>>  (3) legacy implementation, where the magic flags decide whether we
>>>>>      use SFDP
>>>>>
>>>>> Which case is eventually used depends on the ID of the flash -
>>>>> assuming there will only be IDs which either fall into (1) *or* (2).
>>>>> That assumption is clearly wrong :)
>>>>>
>>>>> I'd propose a new case in spi_nor_init_params()
>>>>>  (4) try SFDP with a fallback to the static flags from the
>>>>>      flash_info db.
>>>>>
>>>>
>>>> that's not that bad, but I would avoid doing it if it's not common. You
>>>> also have to update the core a bit, you can't use no_sfdp_flags &
>>>> TRY_SFDP, it's misleading. Does it worth it?
>>>
>>> IMHO no_sfdp_flags is the correct place (maybe TRY_SFDP is wrong,
>>> maybe SFDP_FALLBACK?)
>> 
>> TRY_SFDP might not be the best choice. But SFDP_FALLBACK sounds to me
>> like it is fallback _to_ SFDP, so rather counter-intuitive.
>> 
>>> because the flash is first treated like in
>>> case (2). Then SFDP is tried based on that flag.
>> 
>> It is first treated like in case (2), and then tried for case (1),
>> falling back to the result from case (2) if/when case (1) fails.
>> 
>>> Is it worth it? I
>>> don't know, Esben is doing the development here ;) So up to him.
>> 
>> I am not sure exactly how it should look like, but I do like the idea
>> proposed above, case (4). It is easier to describe and understand than
>> the current legacy implementation.
>> 
>>>> I won't oppose too much, but to me it feels that we're trying to keep
>>>> alive a dead man.
>>>
>>> Maybe, but we'd have a readily solution if we face a similar
>>> problem in the future. I'm really not sure, how many flashes there
>>> are, but I think these magic bits (which tells the legacy
>>> implementation to try SFDP) will mask quite a few of these.
>>> I.e. in an ideal world where we could finally drop case (3) and
>>> you'd need to split the flashes between case (1) or (2), I think
>>> there will be quite some in (4).
>> 
>> I like this. Judging by the way Macronix is handling this particular
>> chip, I strongly assume that there are several other examples of this
>> for other Macronix parts. Of-course, as long as the original part using
>> the particular flash id supported SFDP, and all later flashes using the
>> same id also does, none of this is needed.
>
> okay, let's implement 4/

Great. Let's do that.

But other than avoiding the "magic flags decide whether we use SFDP",
should I be doing anything different?

I assume we should still be calling the default_init() fixup functions,
both for manufacturer and flash level. Or should we leave this for the
deprecated case only?

If the semantics is basically the same as for the deprecated, why not
simply change the implementation of the deprecated approach to what we
need? So having 3 cases:

(1) SFDP only [indicated by size==0]
(2) static config only [indicated by no_sfdp_flags & SPI_NOR_SKIP_SFDP]
(3) SFDP with fallback to static config [indicated with size!=0 and
    !(no_sfdp_flags & SPI_NOR_SKIP_SFDP]

Any reason that we should not be able to easily convert existing
depracted flash info specifications to the new SFDP with fallback to
static config?

Also I am wondering if anyone can remember or otherwise figure out why
we are doing this memcpy() dance with nor->params in
spi_nor_sfdp_init_params_deprecated()? Why not simply call
spi_nor_parse_sfdp() before
spi_nor_no_sfdp_init_params()/spi_nor_manufacturer_init_params()?

/Esben

