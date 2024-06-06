Return-Path: <linux-kernel+bounces-204810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4398FF3CC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62271F286FD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9ED38DC7;
	Thu,  6 Jun 2024 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="LXsGgSjC"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D392E639
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717695148; cv=none; b=kX2x2TJO2a6mDGsOblnteP0cpQFLLoc3Ngvp/D0h8xgC2ieb8zbMl81IveHLaJg3kKh1BvR0YBsYyNWR53YUERGfZHgjxxuqk2THiZc8XVtnRrMaFfhQTg64E1x0abElfEdPBQfnVZ0qbnCQQ4joMgfMlF9mVHisOo31cR++u2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717695148; c=relaxed/simple;
	bh=JjUV1nwY2f9Uymu1m1icm3IoD4wI0r477PdKxrY7h+A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rvamdykd8y8eg9Q3mU/ltxT2jHnPcMCXBl9f5xNyz5l/je1ckpKT+EnovkWICkJ5B6wQ4v0ewaS1kRUXjSerpJbPk4bpc6opLWoi1e44L+yT/hBUljE4jOL4yekSX55MmPmh4FP/olFpMg8hIbhKXpIngxfMdtJqT2C5KhcOGkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=LXsGgSjC; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Y733XPBLBlsCRJvCsHFw1IatFR5ZrX9hSMVLNzZBq14=; b=LXsGgSjCSjRcLVaAjOPlzPC8XN
	g/iJ3K58NxblpOgdKs5siF13Ib20wE9x0B8Mo7gwDrVW3DTfkZ3fAhg0+e7/eH/sHhfV2yy2LXCJq
	NfcDUMhXMTrhyNjpvvy15eXEOnpk/PfbrMRr6gmpqGbx8sVkk21xIe5hCfPYchgc7PDSAumVaoiaZ
	hEBF43qi0Djd2WJgswXrhSrxBFUziEhhK1wsQJlUXqxJrOsoy4imqT/xq96zin5nI/2X4u3Lm5SrR
	TFbL8bCSd1zr7RaCOzUw0eiBhKfZuAsx7qcMCNPMMzIDdER2E01PbMidnw7T64b+TaMbeuoT9Nvio
	vVA6HZCQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sFGyR-0003qJ-B2; Thu, 06 Jun 2024 19:32:23 +0200
Received: from [80.62.117.184] (helo=localhost)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sFGyN-0007dL-1o;
	Thu, 06 Jun 2024 19:32:23 +0200
From: Esben Haabendal <esben@geanix.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Michael Walle <mwalle@kernel.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Miquel Raynal <miquel.raynal@bootlin.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH] mtd: spi-nor: macronix: workaround for device id re-use
In-Reply-To: <8513a828-6669-4bf3-91d3-799771866f32@linaro.org> (Tudor
	Ambarus's message of "Thu, 6 Jun 2024 14:29:44 +0100")
References: <20240524-macronix-mx25l3205d-fixups-v1-1-ee152e56afb3@geanix.com>
	<D1Q7BU6PJ356.1CTXPUZE8U6XX@kernel.org>
	<8513a828-6669-4bf3-91d3-799771866f32@linaro.org>
Date: Thu, 06 Jun 2024 19:32:22 +0200
Message-ID: <87r0da9duh.fsf@geanix.com>
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

> On 6/3/24 08:25, Michael Walle wrote:
>> Hi,
>> 
>> On Fri May 24, 2024 at 12:48 PM CEST, Esben Haabendal wrote:
>>> Macronix engineers apparantly do not understand the purpose of having
>>> an ID actually identify the chip and its capabilities. Sigh.
>>>
>>> The original Macronix SPI NOR flash that identifies itself as 0xC22016
>>> with RDID was MX25L3205D. This chip does not support SFDP, but does
>>> support the 2READ command (1-2-2).
>
> and it lacks support for 1-1-2?

Yes.

>>> When Macronix announced EoL for MX25L3205D, the recommended
>>> replacement part was MX25L3206E, which conveniently also identifies
>>> itself as 0xC22016. It does not support 2READ, but supports DREAD
>>> (1-1-2) instead, and supports SFDP for discovering this.
>>>
>>> When Macronix announced EoL for MX25L3206E, the recommended
>>> replacement part was MX25L3233F, which also identifies itself as
>>> 0xC22016. It supports DREAD, 2READ, and the quad modes QREAD (1-1-4)
>>> and 4READ (1-4-4). This also support SFDP.
>> 
>> Thanks for collecting all this info!
>> 
>>> So far, all of these chips have been handled the same way by the Linux
>>> driver. The SFDP information have not been read, and no dual and quad
>>> read modes have been enabled.
>>>
>>> The trouble begins when we want to enable the faster read modes. The
>>> RDID command only return the same 3 bytes for all 3 chips, so that
>>> doesn't really help.
>>>
>>> But we can take advantage of the fact that only the old MX25L3205D
>>> chip does not support SFDP, so by triggering the old initialization
>>> mechanism where we try to read and parse SFDP, but has a fall-back
>>> configuration in place, we can configure all 3 chips to their optimal
>>> configurations.
>> 
>> You are (mis)using the quad info bits to trigger an sfdp read,
>
> right, not ideal.
>
>> correct? In that case, I'd rather see a new flag in .no_sfdp_flags
>> to explicitly trigger the SFDP read. Then your new flash would only
>
> I hate to update the core for vendor's madness.

Me too. But on the other hand, it would be ashame to not support such
common parts.

>> need this flag and doesn't require the shenanigans with the fixup,
>> right?
>> 
>>> With this, MX25L3205D will get the faster 2READ command enabled,
>>> speading up reads. This should be safe.
>>>
>>> MX25L3206E will get the faster DREAD command enabled. This should also
>>> be safe.
>>>
>>> MX25L3233F will get all of DREAD, 2READ, QREAD and 4READ enabled. In
>>> order for this to actually work, the WP#/SIO2 and HOLD#/SIO3 pins must
>>> be correctly wired to the SPI controller.
>> 
> don't add superfluous info. we already know how quad works.

Noted. And I already did drop that part in v2.

>> That should already be taken care of with the spi-{tx,rx}-bus-width.
>> 
>> -michael
>> 
>>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>>> ---
>>> I only have access to boards with MX25L3233F flashes, so haven't been
>>> able to test the backwards compatibility. If anybody has boards with
>>> MX25L3205D and/or MX25L3206E, please help test this patch. Keep an eye
>>> for read performance regression.
>>>
>>> It is worth nothing that both MX25L3205D and MX25L3206E are
>>> end-of-life, and is unavailable from Macronix, so any new boards
>>> featuring a Macronix flash with this ID will likely be using
>>> MX25L3233F.
>>> ---
>>>  drivers/mtd/spi-nor/macronix.c | 60 +++++++++++++++++++++++++++++++++++++++++-
>>>  1 file changed, 59 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
>>> index ea6be95e75a5..c1e64ee3baa3 100644
>>> --- a/drivers/mtd/spi-nor/macronix.c
>>> +++ b/drivers/mtd/spi-nor/macronix.c
>>> @@ -8,6 +8,63 @@
>>>  
>>>  #include "core.h"
>>>  
>>> +/*
>>> + * There is a whole sequence of chips from Macronix that uses the same device
>>> + * id. These are recommended as EoL replacement parts by Macronix, although they
>>> + * are only partly software compatible.
>>> + *
>>> + * Recommended replacement for MX25L3205D was MX25L3206E.
>>> + * Recommended replacement for MX25L3206E was MX25L3233F.
>>> + *
>>> + * MX25L3205D does not support RDSFDP. The other two does.
>>> + *
>>> + * MX25L3205D supports 1-2-2 (2READ) command.
>>> + * MX25L3206E supports 1-1-2 (DREAD) command.
>>> + * MX25L3233F supports 1-1-2 (DREAD), 1-2-2 (2READ), 1-1-4 (QREAD), and 1-4-4
>>> + * (4READ) commands.
>>> + *
>>> + * In order to trigger reading optional SFDP configuration, the
>>> + * SPI_NOR_DUAL_READ|SPI_NOR_QUAD_READ flags are set, seemingly enabling 1-1-2
>>> + * and 1-1-4 for MX25L3205D. The other chips supporting RDSFDP will have the
>>> + * correct read commands configured based on SFDP information.
>>> + *
>>> + * As none of the other will enable 1-1-4 and NOT 1-4-4, so we identify
>>> + * MX25L3205D when we see that.
>
> I find this description more clear than the commit message. I've written
> some questions for the commit message, then I removed them once I read
> this description.
>
>>> + */
>>> +static int
>>> +mx25l3205d_late_init(struct spi_nor *nor)
>>> +{
>>> +	struct spi_nor_flash_parameter *params = nor->params;
>>> +
>>> +	/*                          DREAD  2READ  QREAD  4READ
>>> +	 *                          1-1-2  1-2-2  1-1-4  1-4-4
>>> +	 * Before SFDP parse          1      0      1      0
>>> +	 * 3206e after SFDP parse     1      0      0      0
>>> +	 * 3233f after SFDP parse     1      1      1      1
>>> +	 * 3205d after this func      0      1      0      0
>>> +	 */
>>> +	if ((params->hwcaps.mask & SNOR_HWCAPS_READ_1_1_4) &&
>>> +	    !(params->hwcaps.mask & SNOR_HWCAPS_READ_1_4_4)) {
>>> +		/* Should be MX25L3205D */
>>> +		params->hwcaps.mask &= ~SNOR_HWCAPS_READ_1_1_2;
>>> +		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_2],
>>> +					  0, 0, 0, 0);
>>> +		params->hwcaps.mask &= ~SNOR_HWCAPS_READ_1_1_4;
>>> +		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_4],
>>> +					  0, 0, 0, 0);
>>> +		params->hwcaps.mask |= SNOR_HWCAPS_READ_1_2_2;
>>> +		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_2_2],
>>> +					  0, 4, SPINOR_OP_READ_1_2_2,
>>> +					  SNOR_PROTO_1_2_2);
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct spi_nor_fixups mx25l3205d_fixups = {
>>> +	.late_init = mx25l3205d_late_init,
>>> +};
>>> +
>>>  static int
>>>  mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
>>>  			    const struct sfdp_parameter_header *bfpt_header,
>>> @@ -61,7 +118,8 @@ static const struct flash_info macronix_nor_parts[] = {
>>>  		.id = SNOR_ID(0xc2, 0x20, 0x16),
>>>  		.name = "mx25l3205d",
>>>  		.size = SZ_4M,
>>> -		.no_sfdp_flags = SECT_4K,
>>> +		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
>>> +		.fixups = &mx25l3205d_fixups
>>>  	}, {
>>>  		.id = SNOR_ID(0xc2, 0x20, 0x17),
>>>  		.name = "mx25l6405d",
>>>
>
> If all support 1-1-2, (seems MX25L3205D doesn't), then we may have a
> change to don't update the core.
>
> Frankly I don't care too much about what happens in the manufacturer
> drivers, but I do care about the core and to not extend it with . This
> patch is not too heavy to be unmaintainable and shows clear where the
> problem is, we can keep this as well.
>
> Other option that I'd like you to consider is whether we just remove
> support for MX25L3205D, thus the entry altogether, and instead rely on
> SFDP to set everything.

I won't mind for the hardware I am involved with. But on the
other hand, I personally don't think it is right to cause problems for
anyone upgrading the kernel to boards using MX25L3205D. But I will leave
that to you maintainers, as you both have to bear the maintance burden
and will be the ones to get the blame if the change upsets someone :)

/Esben

