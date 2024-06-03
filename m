Return-Path: <linux-kernel+bounces-198767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A1E8D7D27
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4A51F23162
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B905674B;
	Mon,  3 Jun 2024 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="ae4voBO8"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5E050281
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717402666; cv=none; b=G/0Jrf2nRnQg/BQAxQ9xw7EFleSIfd42jrs+tp+woMX2GXiIZbvqoM7DZNHVLhDkLinStoth9X9OaKHO7CvR9cpfGOukGRvFW8FCsogLBdj0wRPYtDo4QmDC5TjD1yCYjzVg+UHa9fWW6xB4uLaSWWwcQeR9i8LT74zal0+b/As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717402666; c=relaxed/simple;
	bh=yfRSzrRoL9vy6nbZ+fUhxkdWuu97gBrCpIUgaRTU4+Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gW73Enpj6Y6M2GQ15FQfnAb8H5lEU9qJgd1mYjiMdRVbqIMcIe6RCX79BT3+WuEsrFw6G+A7fnEEuKQCya+Mc503/bzgTGkS9E1IQPQHBKqYH2ga90tffOmRh+rdee2yzTpipZME+rQiXfGImZXXgvx82Wpfm3gOXHJN7wTLg8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=ae4voBO8; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=w6IyClQK/kc4lt86XGWiJYJOQ9Forzheld/77UOVrsM=; b=ae4voBO8kWGkKvdktk/0jaOa7w
	2gnqYNN7o6Pj66YzGtMlheAPGRKISf80F9dBd2714P/AhcwhlWcL9Dd/CZWEQyYdLu0/H/UxZQ7xU
	AjnuEiet7KMcik4MrkbInK5oW+0G9mCwiIayb8QC1trQQIRFDCmWORgATQlBPfpaksKtyX4HB7Ii3
	lkHBrT+q8yr5mOZnVqLgGRjby1fp8Gt0dxXNWIdvsIP4VZN+I53gPZk4Typ1OO2vYVvxAokuFCQeH
	XQtDO93+8ONMV1GKGjWlXdUVu/p2cYB1h6J8kB+ldwL6Li5sSQpNv6Bnz1PYxkSjkBeCDK68o+ElG
	4ombfphw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sE2sr-0000FZ-2d; Mon, 03 Jun 2024 10:17:33 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sE2sn-0000Xn-1Q;
	Mon, 03 Jun 2024 10:17:33 +0200
From: Esben Haabendal <esben@geanix.com>
To: "Michael Walle" <mwalle@kernel.org>
Cc: "Tudor Ambarus" <tudor.ambarus@linaro.org>,  "Pratyush Yadav"
 <pratyush@kernel.org>,  "Miquel Raynal" <miquel.raynal@bootlin.com>,
  "Richard Weinberger" <richard@nod.at>,  "Vignesh Raghavendra"
 <vigneshr@ti.com>,  <linux-mtd@lists.infradead.org>,
  <linux-kernel@vger.kernel.org>,  "Rasmus Villemoes"
 <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH] mtd: spi-nor: macronix: workaround for device id re-use
In-Reply-To: <D1Q7BU6PJ356.1CTXPUZE8U6XX@kernel.org> (Michael Walle's message
	of "Mon, 03 Jun 2024 09:25:42 +0200")
References: <20240524-macronix-mx25l3205d-fixups-v1-1-ee152e56afb3@geanix.com>
	<D1Q7BU6PJ356.1CTXPUZE8U6XX@kernel.org>
Date: Mon, 03 Jun 2024 10:17:32 +0200
Message-ID: <87frtuigo3.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27294/Sun Jun  2 10:29:37 2024)

"Michael Walle" <mwalle@kernel.org> writes:

> Hi,
>
> On Fri May 24, 2024 at 12:48 PM CEST, Esben Haabendal wrote:
>> Macronix engineers apparantly do not understand the purpose of having
>> an ID actually identify the chip and its capabilities. Sigh.
>>
>> The original Macronix SPI NOR flash that identifies itself as 0xC22016
>> with RDID was MX25L3205D. This chip does not support SFDP, but does
>> support the 2READ command (1-2-2).
>>
>> When Macronix announced EoL for MX25L3205D, the recommended
>> replacement part was MX25L3206E, which conveniently also identifies
>> itself as 0xC22016. It does not support 2READ, but supports DREAD
>> (1-1-2) instead, and supports SFDP for discovering this.
>>
>> When Macronix announced EoL for MX25L3206E, the recommended
>> replacement part was MX25L3233F, which also identifies itself as
>> 0xC22016. It supports DREAD, 2READ, and the quad modes QREAD (1-1-4)
>> and 4READ (1-4-4). This also support SFDP.
>
> Thanks for collecting all this info!
>
>> So far, all of these chips have been handled the same way by the Linux
>> driver. The SFDP information have not been read, and no dual and quad
>> read modes have been enabled.
>>
>> The trouble begins when we want to enable the faster read modes. The
>> RDID command only return the same 3 bytes for all 3 chips, so that
>> doesn't really help.
>>
>> But we can take advantage of the fact that only the old MX25L3205D
>> chip does not support SFDP, so by triggering the old initialization
>> mechanism where we try to read and parse SFDP, but has a fall-back
>> configuration in place, we can configure all 3 chips to their optimal
>> configurations.
>
> You are (mis)using the quad info bits to trigger an sfdp read,
> correct?

Correct.

> In that case, I'd rather see a new flag in .no_sfdp_flags
> to explicitly trigger the SFDP read. Then your new flash would only
> need this flag and doesn't require the shenanigans with the fixup,
> right?

I fixup would still be required in order to enable 1-2-2 for MX25L3205D,
as it will fail the SFDP read, but actually does support 1-2-2.

>> With this, MX25L3205D will get the faster 2READ command enabled,
>> speading up reads. This should be safe.
>>
>> MX25L3206E will get the faster DREAD command enabled. This should also
>> be safe.
>>
>> MX25L3233F will get all of DREAD, 2READ, QREAD and 4READ enabled. In
>> order for this to actually work, the WP#/SIO2 and HOLD#/SIO3 pins must
>> be correctly wired to the SPI controller.
>
> That should already be taken care of with the spi-{tx,rx}-bus-width.

Yes. Which defaults to 1, which should take care of the backwards
compatibility.

/Esben

>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> ---
>> I only have access to boards with MX25L3233F flashes, so haven't been
>> able to test the backwards compatibility. If anybody has boards with
>> MX25L3205D and/or MX25L3206E, please help test this patch. Keep an eye
>> for read performance regression.
>>
>> It is worth nothing that both MX25L3205D and MX25L3206E are
>> end-of-life, and is unavailable from Macronix, so any new boards
>> featuring a Macronix flash with this ID will likely be using
>> MX25L3233F.
>> ---
>>  drivers/mtd/spi-nor/macronix.c | 60 +++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 59 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
>> index ea6be95e75a5..c1e64ee3baa3 100644
>> --- a/drivers/mtd/spi-nor/macronix.c
>> +++ b/drivers/mtd/spi-nor/macronix.c
>> @@ -8,6 +8,63 @@
>>  
>>  #include "core.h"
>>  
>> +/*
>> + * There is a whole sequence of chips from Macronix that uses the same device
>> + * id. These are recommended as EoL replacement parts by Macronix, although they
>> + * are only partly software compatible.
>> + *
>> + * Recommended replacement for MX25L3205D was MX25L3206E.
>> + * Recommended replacement for MX25L3206E was MX25L3233F.
>> + *
>> + * MX25L3205D does not support RDSFDP. The other two does.
>> + *
>> + * MX25L3205D supports 1-2-2 (2READ) command.
>> + * MX25L3206E supports 1-1-2 (DREAD) command.
>> + * MX25L3233F supports 1-1-2 (DREAD), 1-2-2 (2READ), 1-1-4 (QREAD), and 1-4-4
>> + * (4READ) commands.
>> + *
>> + * In order to trigger reading optional SFDP configuration, the
>> + * SPI_NOR_DUAL_READ|SPI_NOR_QUAD_READ flags are set, seemingly enabling 1-1-2
>> + * and 1-1-4 for MX25L3205D. The other chips supporting RDSFDP will have the
>> + * correct read commands configured based on SFDP information.
>> + *
>> + * As none of the other will enable 1-1-4 and NOT 1-4-4, so we identify
>> + * MX25L3205D when we see that.
>> + */
>> +static int
>> +mx25l3205d_late_init(struct spi_nor *nor)
>> +{
>> +	struct spi_nor_flash_parameter *params = nor->params;
>> +
>> +	/*                          DREAD  2READ  QREAD  4READ
>> +	 *                          1-1-2  1-2-2  1-1-4  1-4-4
>> +	 * Before SFDP parse          1      0      1      0
>> +	 * 3206e after SFDP parse     1      0      0      0
>> +	 * 3233f after SFDP parse     1      1      1      1
>> +	 * 3205d after this func      0      1      0      0
>> +	 */
>> +	if ((params->hwcaps.mask & SNOR_HWCAPS_READ_1_1_4) &&
>> +	    !(params->hwcaps.mask & SNOR_HWCAPS_READ_1_4_4)) {
>> +		/* Should be MX25L3205D */
>> +		params->hwcaps.mask &= ~SNOR_HWCAPS_READ_1_1_2;
>> +		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_2],
>> +					  0, 0, 0, 0);
>> +		params->hwcaps.mask &= ~SNOR_HWCAPS_READ_1_1_4;
>> +		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_4],
>> +					  0, 0, 0, 0);
>> +		params->hwcaps.mask |= SNOR_HWCAPS_READ_1_2_2;
>> +		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_2_2],
>> +					  0, 4, SPINOR_OP_READ_1_2_2,
>> +					  SNOR_PROTO_1_2_2);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct spi_nor_fixups mx25l3205d_fixups = {
>> +	.late_init = mx25l3205d_late_init,
>> +};
>> +
>>  static int
>>  mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
>>  			    const struct sfdp_parameter_header *bfpt_header,
>> @@ -61,7 +118,8 @@ static const struct flash_info macronix_nor_parts[] = {
>>  		.id = SNOR_ID(0xc2, 0x20, 0x16),
>>  		.name = "mx25l3205d",
>>  		.size = SZ_4M,
>> -		.no_sfdp_flags = SECT_4K,
>> +		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
>> +		.fixups = &mx25l3205d_fixups
>>  	}, {
>>  		.id = SNOR_ID(0xc2, 0x20, 0x17),
>>  		.name = "mx25l6405d",
>>
>> ---
>> base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
>> change-id: 20240524-macronix-mx25l3205d-fixups-882e92eed7d7
>>
>> Best regards,

