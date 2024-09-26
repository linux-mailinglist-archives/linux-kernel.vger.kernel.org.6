Return-Path: <linux-kernel+bounces-340403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195369872E5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9048283895
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2CD156228;
	Thu, 26 Sep 2024 11:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="WK97v/Zj"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E0F347B4
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 11:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727350530; cv=none; b=PBpr2XUdakJ/TZlWsefEVzZP16DY2cwyDe0CdLXbs+FVcC8xF+T6EvXpk5YkpO8rg+720LDiAVKU3ek54g09I3rjxj/g0mySWsfBzp3HBF8k10+HZMs8NFtVfHQIDxxZVnLT8mDObnVMAioiAwWpWLnnuc87yxeXszhzwX5Hkck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727350530; c=relaxed/simple;
	bh=sFVyhdm7qTirTBfMbQs7blYXH6B+EZCILufHVXV6/XU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KB3Nkr8fJ13KXqoJAYyMPYdY4WH39sjQJkcWdvzCPA5PAFwsk2QOkwELqDOF469ie81LpikSVCw3SiVyjYeMMIhY+9GEEVIpQpHJEh0UxuZIx9dqlBk0XGUkcIuiLVCIGPvo9rUDAbQIQjYX+st+3c5qM89xfNVpzw6mEQLdLPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=WK97v/Zj; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=MSPzLKZt5pYigqgbYhkoX8b1Yd8XfYEgTnaVcGoTWjI=; b=WK97v/Zjnttkyj5MudRLp1Qh4J
	WUZrrd/Aon2tD48nHGMgje5hFuCnlXssHFZFlZOiUFIB+uvBCsv5BTuYun4TlB2woCMoQt/Aqw5ol
	9iWF3sRTJLyxlSsGuBAzj0EqZkNsL24PBY/wFLTa/FqWx24/jHTnc0IGqyRLZsjvlWQS+XNIIt5Pl
	NmR/CQkfJn9XhenEQ69Ole3J5lvp8H9hJWYniV5F1JTYyB0taWv5FqM1TIcOylj+mkGfbdvsugAic
	4Ci/iSHE5H25rs3eUonjhgLuCYSuMzVBBlZL3PP0f5RVsgZBQHtfEhhW1WmA1jxdZqEmqa/uqDJQq
	k5Rh/bxg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1stmmH-000ABK-9u; Thu, 26 Sep 2024 13:35:21 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1stmmH-000JC1-0p;
	Thu, 26 Sep 2024 13:35:20 +0200
From: Esben Haabendal <esben@geanix.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <mwalle@kernel.org>,  Miquel Raynal <miquel.raynal@bootlin.com>,  Richard
 Weinberger <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,
  Nicolas Ferre <nicolas.ferre@microchip.com>,  Alexandre Belloni
 <alexandre.belloni@bootlin.com>,  Claudiu Beznea
 <claudiu.beznea@tuxon.dev>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>,  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 00/15] mtd: spi-nor: macronix: workaround for device
 id re-use
In-Reply-To: <e079751d-e775-4dec-9959-c9c3fdcc8ecf@linaro.org> (Tudor
	Ambarus's message of "Thu, 26 Sep 2024 11:08:25 +0100")
References: <20240711-macronix-mx25l3205d-fixups-v3-0-99353461dd2d@geanix.com>
	<e079751d-e775-4dec-9959-c9c3fdcc8ecf@linaro.org>
Date: Thu, 26 Sep 2024 13:35:20 +0200
Message-ID: <877cayhclj.fsf@geanix.com>
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

> Hiya, Esben,
>
> On 7/11/24 2:00 PM, Esben Haabendal wrote:
>> Following up to various discussions, this series have now been
>> modified so that it gets rid of the old deprecated approach
>> for detecting when to do optional SFDP parsing.
>> 
>> Before these changes, spi-nor flashes were handled in 4 different
>> ways:
>> 
>
> I'm adding a bit of extra context on each point you made. All your
> points contain static init, you missed spi_nor_init_default_params()

I might be even more confused now :) Let me try to understand...

> There's a 0/ case where we have indeed just SFDP initialized flashes,
> and that is the generic flash driver.
>
> 0/ SFDP only, generic flash driver

Ok. So this is when spi_nor_detect() falls back to
spi_nor_generic_flash, right?

>> (1) SFDP only [size==0]
>
> 1/ static + SFDP

So we have found a matching flash_info, and it has size==0. Right?

> spi_nor_init_default_params(nor);

I guess we can assume that flash_info in this case will always have
something set (other than .name and .size=0)?

> spi_nor_parse_sfdp();

>> (2a) static config only [size!=0 && no_sfdp_flags & SPI_NOR_SKIP_SFDP]
>
> 2a/ is
> spi_nor_init_default_params(nor);
> spi_nor_no_sfdp_init_params(nor);

Got it.

>> (2b) static config only
>>        [size!=0 &&
>>         !(no_sfdp_flags & (SPI_NOR_SKIP_SFDP | 
>>            SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
>>            SPI_NOR_OCTAL_READ | SPI_NOR_OCTAL_DTR_READ))]
>
> 2b/ is
> spi_nor_init_default_params(nor);
> spi_nor_init_params_deprecated(nor); //where parse SFDP is not called
> 	spi_nor_no_sfdp_init_params(nor);
> 	spi_nor_manufacturer_init_params(nor);>

Got it.

>> (3) SFDP with fallback to static config
>>        [size!=0 &&
>>         !(no_sfdp_flags & SPI_NOR_SKIP_SFDP) &&
>>         (no_sfdp_flags & SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
>>            SPI_NOR_OCTAL_READ | SPI_NOR_OCTAL_DTR_READ))]
>> 
>
> 3/ is 2b/ with parse SFDP called and rollback mechanism
> spi_nor_init_default_params(nor);
> spi_nor_init_params_deprecated(nor);
> 	spi_nor_no_sfdp_init_params(nor);
> 	spi_nor_manufacturer_init_params(nor);
> 	spi_nor_sfdp_init_params_deprecated(nor);
>
> All cases from above are followed by a call to spi_nor_late_init_params().

Got it.

Should I move your annotations to the cover letter? If I find it
helpful, I think it might also be helpful to somebody else :)

>> Cases (2a) and (2b) have been handled slightly different, with
>> manufacturer and flash_info ->default_init() hooks being called in
>> case (2b) but not in case (2a).
>
> default_init() was a mistake and we shall remove it and replace it with
> late_init(). The challenge is to do that without affecting backwards
> compatibility. But let's move this aside for the moment
>> 
>> With this series, that is changed to this simpler approach instead:
>> 
>> (1) SFDP only [size==0]
>> 
>> (2) static config only
>>       [size!=0 && !(no_sfdp_flags & SPI_NOR_TRY_SFDP)]
>> 
>> (3) SFDP with fallback to static config
>>       [size!=0 && (no_sfdp_flags & SPI_NOR_TRY_SFDP)]
>> 
>> Existing struct flash_info entries are modified, so that all those
>> that was case (2a) or (2b) are now case (2), and those that were (1)
>> and (3) are still (1) and (3).
>
> We indeed want 2a/ and 2b/ to be squashed, ideally by removing the
> default_init() hook.

But you think we should not remove default_init() hook as part of this
series?

> And if we really want SFDP-only init, we shall not call
> spi_nor_init_default_params() in this case.

So move spi_nor_init_default_params() into the if (spi_nor_needs_sfdp())
else section?
I have pushed a fixup commit doing this to my branch. Should I amend
patch 1/15 with it?

/Esben

