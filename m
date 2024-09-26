Return-Path: <linux-kernel+bounces-340439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F60698736E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275271F277E9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50A617557E;
	Thu, 26 Sep 2024 12:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="BHaQpiq/"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3B514F9FD
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727353127; cv=none; b=V+ldbqFY1rKcWg0zajZ2zKx9hKyE3Kxy9FSMG0DMsea7vDCZcQOmqTkAZc+fOA5mvORNi+6fEyPZkuYKDyRJwGApv2Hc32HixSMrflMPznGVwBu5a89f5tTiDz8NjI83+6XdarMK91OWd4zDWgqlnyeEfs14l0kyXpjiJImPqJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727353127; c=relaxed/simple;
	bh=2UmOXdEz4CJIDOrDkKiif+rQZXk8sYyTHxbPYDMhRAk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hBvXHfCTR2WJ2ByhBQl/R/OFA1YEVgdVdqM2JnJX5+Tk/AExl5bNuZV5gYPOsoAV0JPxcoq6GjU8G/lLW9MTIDMeji+6tpsZJDpRtgn2tatjgUvJQe4bj70CTA9SMjsUuskBKj36tAYO8VZpPGYBf6hJgEICyymyrP+UBRLl7ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=BHaQpiq/; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=GtspPkz4ED44hgy2l6w83AQqS3e+5A0pTkCNhVxW6xg=; b=BHaQpiq/vsy+t7Eal2oau12xpW
	hmPVG2yt13UkxZJwruDvHSNwGQ+24TP72lTu9juLpOIKLKYTYW7UF/TGV30Khk+uz7BuwAehtYUmM
	ghzICwqq6doOZDaU3PsDo4eRncak5ETutz5MkTmMqrZhxlFVCVB10MEEPkmK/+zwKsNGerfDhZxvU
	OISzT2BcBxbqgII7xwHitkrghw3piIcVDQrI/N8oQaC5215kc9v9A3W9YFH6DKkSzP138+N9QNbdG
	i2UZrdDcPkQCMl0fYrrlssXoxpkgSoUei01QiZ+wylVPhbwnlFq5FVHe+Pgchh4Hi5vIV5uBJwwIW
	Tp5le0Ug==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1stnSA-000HTd-9i; Thu, 26 Sep 2024 14:18:38 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1stnS9-000Hc0-0F;
	Thu, 26 Sep 2024 14:18:37 +0200
From: Esben Haabendal <esben@geanix.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Michael Walle <mwalle@kernel.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Miquel Raynal <miquel.raynal@bootlin.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Nicolas Ferre <nicolas.ferre@microchip.com>,
  Alexandre Belloni <alexandre.belloni@bootlin.com>,  Claudiu Beznea
 <claudiu.beznea@tuxon.dev>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>,  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 00/15] mtd: spi-nor: macronix: workaround for device
 id re-use
In-Reply-To: <2196b4e8-2c93-4a73-a717-28448d4668ab@linaro.org> (Tudor
	Ambarus's message of "Thu, 26 Sep 2024 11:47:33 +0100")
References: <20240711-macronix-mx25l3205d-fixups-v3-0-99353461dd2d@geanix.com>
	<D2NGXHZ2VTK0.M0AOB4CM7MHM@kernel.org> <87tte2hmq0.fsf@geanix.com>
	<2196b4e8-2c93-4a73-a717-28448d4668ab@linaro.org>
Date: Thu, 26 Sep 2024 14:18:37 +0200
Message-ID: <87v7yifw0y.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27410/Thu Sep 26 11:30:46 2024)

Tudor Ambarus <tudor.ambarus@linaro.org> writes:

> Hi, Esben,
>
> Thank you for the perseverance :D
>
> On 9/26/24 8:56 AM, Esben Haabendal wrote:
>> "Michael Walle" <mwalle@kernel.org> writes:
>> 
>>> Hi,
>>>
>>> On Thu Jul 11, 2024 at 3:00 PM CEST, Esben Haabendal wrote:
>>>> As a consequence, the SPI_NOR_SKIP_SFDP flag is no more, and all
>>>> drivers that have been doing optional SFDP is now marked explicitly to
>>>> do that using the SPI_NOR_TRY_SFDP.
>>>
>>> First, I haven't looked at your patchset at the moment. But I'd like
>>> to take the opportunity to discuss the following (and excuse me that
>>> I didn't had this idea before all your work on this).
>>>
>>> First, I'd like to see it the other way around, that is, doing SFDP
>>> by default and let the driver opt-out instead of opt-in. This will
>>> also align with the current "SFDP only driver", i.e. if a flash is
>>> not known we try SFDP anyway. Going forward, I'd say this is also
>>> the sane behavior and we don't have to add any flags if someone want
>>> to add support for an (older) flash with the same ID but without
>>> SFDP. With the current approach, we'd have to add the TRY_SFDP flag.
>>>
>>> Now we might play it safe and add that SPI_NOR_SKIP_SFDP to any
>>> flash which doesn't do the SFDP parsing (because it has size != 0
>>> and not any of the magic flags set) - or we might just go ahead and
>>> do the probing first for *any* flashes. Yes we might issue an
>>> unsupported opcode, but we already do that with the generic SFDP
>>> flash driver. So no big deal maybe (?). Vendors where we know for a
>>> fact that they don't have any SFDP (Everspin I'm looking at you),
>>> would of course set the SKIP_SFDP flag.
>
> Issuing RDSFDP for flashes that don't support it shouldn't be too bad
> indeed, it's not recommended, but it shall be fine. What I'm worried
> about is flashes with wrong SFDP data (see all the SFDP fixup hooks that
> we have). So my suggestion is to play it safe unless one of you guys
> step up and commit that will fix or help fix each bug that results from
> this.

Sounds like a good idea. I for one will not put my head on the table
like that :D

> I'd like you to also consider the SFDP versions and how many parameters
> they are exposing. I can't tell exactly, but if I remember correctly,
> rev A had 9 dwords for BFPT, revB 16, and revC and other more. If we
> consider static init folowed by SFDP with rollback option, point 3/ in
> your cover letter, are we sure that all the parameters that are
> initialized before parsing SFDP are overwritten at SFDP parsing time? If
> yes, we shall be fine.

How can we be sure of that?

But if you want to be really sure that no static configuraion is left
after SFDP parsing, why are we handing it a copy of nor->params that was
initialized from static configuration?

Why not call spi_nor_parse_sfdp() with nor->params bing basically
uninitialized?

And then, only if spi_nor_parse_sfdp() fails, look into flash_info
static configuration?

> Esben, to speed up the things on both ends, I recommend you for v4 to
> draft just a core patch if you care, then you can handle the vendor
> drivers. Or send us some pseudocode and we can talk on that.

I will see what I can do.

I guess some kind of RFC patch of the core changes for v4 might be a
good next step.

/Esben

