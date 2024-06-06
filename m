Return-Path: <linux-kernel+bounces-204777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5870A8FF36E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67EF2845A5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C6E198E8B;
	Thu,  6 Jun 2024 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="kpWsQY2+"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF18196DA2
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 17:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717694045; cv=none; b=insb8AYysl0ZpVqaEJRj0FneIIO6GqbRDvsSI8fAqtuMfbCLlGiecF+7o7J+J1ITqmVQlsvdMn6+tFKD4JmLEUwHZkNXeMyuCd9VeL+JRE67PM3Eo8SzX6BgsJC7rNxYUpmsZM88rk/fGuLdtlpu/tvmPmlXphHfprE8p5oAyyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717694045; c=relaxed/simple;
	bh=2J55QsUu0z3E0qDgXwQdGuYSG3si4g5PUGdsDhCwlfw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Em0hCx9DYCKGa8x8gYT4F1r1yzv/0zZq7KZVOeWn22my4AuUbXLes6QyT40tDR7lsI64xFFkyBXcIw0nGGaBsfjuubMIQrDOui2vyw/t3t1Hbjpo1fVnrJwrIDykEewxDDUMfQtvHyGWrWTekfZcy7CNCOdA3UgJSv+8Sig5ats=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=kpWsQY2+; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=1vBrOmztxvBw+j73gnLOXwBxCVfezAXKUqEGyYm7Fts=; b=kpWsQY2+cY0zYTy6UinHv5YmIN
	7lP0AP1opPSmrj4ovt/CwCKTZohixjRO7oMjFCcjLYw8kr+4g3O5cdCWB4mGLZUKSqeN1pf6GiVvB
	DjfOkZH3NmsY/wkBRwI/ZvJcXQu8s6WHDB2JSaOi+DDhmlxEqepkAT0BQUVOahnBi1psQdjSEGBzD
	hc83WZfTHp/lJAFHkkLD8drOP+V/fEtkCOLDmqEtoItOXinUlU4VJO3JodLHl9kvUR3gaH+QSId3P
	fO6mLgGyn4V3mdZTj60sC/ARwDW0j199MLwzWuyHuIXvwBPD9HYSEwO2js1iOGROEzJAGYVB9+gxc
	b4goRBQg==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sFGgb-00012F-Sw; Thu, 06 Jun 2024 19:13:58 +0200
Received: from [80.62.117.184] (helo=localhost)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sFGgY-0005oY-0K;
	Thu, 06 Jun 2024 19:13:57 +0200
From: Esben Haabendal <esben@geanix.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <mwalle@kernel.org>,  Miquel Raynal <miquel.raynal@bootlin.com>,  Richard
 Weinberger <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,  Rasmus
 Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: core: add flag for doing optional
 SFDP
In-Reply-To: <a379a411-2c9e-4d9d-aa8f-4c4f3463cc27@linaro.org> (Tudor
	Ambarus's message of "Thu, 6 Jun 2024 14:31:22 +0100")
References: <20240603-macronix-mx25l3205d-fixups-v2-0-ff98da26835c@geanix.com>
	<20240603-macronix-mx25l3205d-fixups-v2-1-ff98da26835c@geanix.com>
	<a379a411-2c9e-4d9d-aa8f-4c4f3463cc27@linaro.org>
Date: Thu, 06 Jun 2024 19:13:57 +0200
Message-ID: <878qziat9m.fsf@geanix.com>
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

> On 6/3/24 14:09, Esben Haabendal wrote:
>> A dedicated flag for triggering call to
>> spi_nor_sfdp_init_params_deprecated() allows enabling optional SFDP read
>> and parse, with fallback to legacy flash parameters, without having dual,
>> quad or octal parameters set in the legacy flash parameters.
>> 
>> With this, spi-nor flash parts without SFDP that is replaced with a
>> different flash NOR flash part that does have SFDP, but shares the same
>> manufacturer and device ID is easily handled.
>> 
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> ---
>>  drivers/mtd/spi-nor/core.c | 3 ++-
>>  drivers/mtd/spi-nor/core.h | 1 +
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> index 3e1f1913536b..1c4d66fc993b 100644
>> --- a/drivers/mtd/spi-nor/core.c
>> +++ b/drivers/mtd/spi-nor/core.c
>> @@ -2933,7 +2933,8 @@ static void spi_nor_init_params_deprecated(struct spi_nor *nor)
>>  
>>  	spi_nor_manufacturer_init_params(nor);
>>  
>> -	if (nor->info->no_sfdp_flags & (SPI_NOR_DUAL_READ |
>> +	if (nor->info->no_sfdp_flags & (SPI_NOR_TRY_SFDP |
>
> I don't like that we update deprecated methods. The solution though is
> elegant.

Maybe we should un-deprecate it? I don't understand why it should be
deprecated. It obviously has a valid purpose.

>> +					SPI_NOR_DUAL_READ |
>>  					SPI_NOR_QUAD_READ |
>>  					SPI_NOR_OCTAL_READ |
>>  					SPI_NOR_OCTAL_DTR_READ))
>> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
>> index 442786685515..77f61a984cb3 100644
>> --- a/drivers/mtd/spi-nor/core.h
>> +++ b/drivers/mtd/spi-nor/core.h
>> @@ -535,6 +535,7 @@ struct flash_info {
>>  	u8 no_sfdp_flags;
>>  #define SPI_NOR_SKIP_SFDP		BIT(0)
>>  #define SECT_4K				BIT(1)
>> +#define SPI_NOR_TRY_SFDP		BIT(2)
>>  #define SPI_NOR_DUAL_READ		BIT(3)
>>  #define SPI_NOR_QUAD_READ		BIT(4)
>>  #define SPI_NOR_OCTAL_READ		BIT(5)
>> 

