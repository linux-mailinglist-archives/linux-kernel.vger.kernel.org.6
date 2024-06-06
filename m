Return-Path: <linux-kernel+bounces-204817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA538FF3DC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD2028DC6F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85D31990B2;
	Thu,  6 Jun 2024 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="YIMRUiFy"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3500E38DC7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 17:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717695312; cv=none; b=RatDhdMbv8XdIeEt4s1xG9C6EV7BMPHsSMQmbFLTDf4DZLgXOrS7RGjYSLtxyb+pMNWpvfqBeisYAvlOqTFdcBfLi7Y5FqVmRoiuqndjumhf95EOynlspEMVUv6PqoRzqLP1I01blum1UhnLgjqs76rp3mV9tdR6V5hqpiN4fzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717695312; c=relaxed/simple;
	bh=uupDSeWXdAPWvc2kL9o+GSBoSZKN1q738oHE+tt4FRc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uJBnImsT+tCEvf/F63DWrMnui/oip6hPFxZJ/ciWHq88+ElAB4pcUH1YaGk6F9DUHME2nVJZvOpBlnpOESd/kMZsfh6oTmXT5HE81pi0ife3g1ed741L7TaJ5ruqFKIzfRbyGPO5KL0D8XV986ULYCwUyWl4hfPl/0CQJwAtS2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=YIMRUiFy; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=CUuCxid6NILsuNvzm9Fa8Mpc8mnuooImrZQ0s/si8+0=; b=YIMRUiFyJNP4LtyC2Zz0njPusb
	6MUnjSmeRNscKJwJrMmBrHRnpon1Cgz7Cn8KEwkebwcL1vh5gf2G3j9pMGGega55FToZdPeziCvCh
	obDd33IkMMavputh8MWl4EMDapomp6o/mdoRY8migmuwuSuFi3TSLW+21zyK+/9JhynVgd7y2Mk8d
	862AkSqVarEEmGYP3/pY0h4Nx3HCzk4vaX9NHTR5dafRvWav361qPlMPsGkVpfQbB0tPcITvYj20P
	zD8pMoz4+L9YFsQ7KR4bofFRUMhHidUAoSlT5JRNg+g1cr9Au/ITNxNg437EZmxe0N8DttoDHPS+e
	DhiVlRaA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sFH15-0004DR-6T; Thu, 06 Jun 2024 19:35:07 +0200
Received: from [80.62.117.184] (helo=localhost)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sFH11-00019h-1M;
	Thu, 06 Jun 2024 19:35:07 +0200
From: Esben Haabendal <esben@geanix.com>
To: "Michael Walle" <mwalle@kernel.org>
Cc: "Tudor Ambarus" <tudor.ambarus@linaro.org>,  "Pratyush Yadav"
 <pratyush@kernel.org>,  "Miquel Raynal" <miquel.raynal@bootlin.com>,
  "Richard Weinberger" <richard@nod.at>,  "Vignesh Raghavendra"
 <vigneshr@ti.com>,  <linux-mtd@lists.infradead.org>,
  <linux-kernel@vger.kernel.org>,  "Rasmus Villemoes"
 <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH] mtd: spi-nor: macronix: workaround for device id re-use
In-Reply-To: <D1SZA4ZDM06P.CJC0EQ9ULA04@kernel.org> (Michael Walle's message
	of "Thu, 06 Jun 2024 15:45:20 +0200")
References: <20240524-macronix-mx25l3205d-fixups-v1-1-ee152e56afb3@geanix.com>
	<D1Q7BU6PJ356.1CTXPUZE8U6XX@kernel.org>
	<8513a828-6669-4bf3-91d3-799771866f32@linaro.org>
	<D1SZA4ZDM06P.CJC0EQ9ULA04@kernel.org>
Date: Thu, 06 Jun 2024 19:35:06 +0200
Message-ID: <87msny9dpx.fsf@geanix.com>
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

>> >> + */
>> >> +static int
>> >> +mx25l3205d_late_init(struct spi_nor *nor)
>> >> +{
>> >> +	struct spi_nor_flash_parameter *params = nor->params;
>> >> +
>> >> +	/*                          DREAD  2READ  QREAD  4READ
>> >> +	 *                          1-1-2  1-2-2  1-1-4  1-4-4
>> >> +	 * Before SFDP parse          1      0      1      0
>> >> +	 * 3206e after SFDP parse     1      0      0      0
>> >> +	 * 3233f after SFDP parse     1      1      1      1
>> >> +	 * 3205d after this func      0      1      0      0
>> >> +	 */
>> >> +	if ((params->hwcaps.mask & SNOR_HWCAPS_READ_1_1_4) &&
>> >> +	    !(params->hwcaps.mask & SNOR_HWCAPS_READ_1_4_4)) {
>> >> +		/* Should be MX25L3205D */
>> >> +		params->hwcaps.mask &= ~SNOR_HWCAPS_READ_1_1_2;
>> >> +		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_2],
>> >> +					  0, 0, 0, 0);
>> >> +		params->hwcaps.mask &= ~SNOR_HWCAPS_READ_1_1_4;
>> >> +		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_4],
>> >> +					  0, 0, 0, 0);
>> >> +		params->hwcaps.mask |= SNOR_HWCAPS_READ_1_2_2;
>> >> +		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_2_2],
>> >> +					  0, 4, SPINOR_OP_READ_1_2_2,
>> >> +					  SNOR_PROTO_1_2_2);
>> >> +	}
>> >> +
>> >> +	return 0;
>> >> +}
>> >> +
>> >> +static const struct spi_nor_fixups mx25l3205d_fixups = {
>> >> +	.late_init = mx25l3205d_late_init,
>> >> +};
>> >> +
>> >>  static int
>> >>  mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
>> >>  			    const struct sfdp_parameter_header *bfpt_header,
>> >> @@ -61,7 +118,8 @@ static const struct flash_info macronix_nor_parts[] = {
>> >>  		.id = SNOR_ID(0xc2, 0x20, 0x16),
>> >>  		.name = "mx25l3205d",
>> >>  		.size = SZ_4M,
>> >> -		.no_sfdp_flags = SECT_4K,
>> >> +		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
>> >> +		.fixups = &mx25l3205d_fixups
>> >>  	}, {
>> >>  		.id = SNOR_ID(0xc2, 0x20, 0x17),
>> >>  		.name = "mx25l6405d",
>> >>
>>
>> If all support 1-1-2, (seems MX25L3205D doesn't), then we may have a
>> change to don't update the core.
>>
>> Frankly I don't care too much about what happens in the manufacturer
>> drivers, but I do care about the core and to not extend it with . This
>> patch is not too heavy to be unmaintainable and shows clear where the
>> problem is, we can keep this as well.
>
> It's a horrible hack. For example I'm working on a patch to clean up
> the spi_nor_set_read_settings() handling. So just throwing any code
> into vendor drivers doesn't make it any better in terms of
> maintainability. I'd need to touch all the code anyway. In fact it
> makes it even worse, because it looks like the manufacturer drivers
> are just a dumping ground for bad things. Thus, I'd really have it
> handled in a correct way inside the core.
>
> Also, this is not device specific. Let there be two different
> flashes with the same ID, but one support SFDP and one doesn't.
> Right now, you have to have any of the magic flags (dual, quad,
> etc) set to trigger an SFDP parsing. If the flash without SFDP
> doesn't support any of these, like in this case, we are screwed.
> Hence we might need such a flag also for other flashes.

Also, it is not very obvious that you can trigger SFDP parsing by
setting these dual/quad bits.  Having an explicit flag to cause this
behvaiour would be much better IMHO.

>> Other option that I'd like you to consider is whether we just remove
>> support for MX25L3205D, thus the entry altogether, and instead rely on
>> SFDP to set everything.
>
> Well, this will break boards with this flash :) And we don't know if
> there are any.

