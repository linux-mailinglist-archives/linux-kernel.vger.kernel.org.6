Return-Path: <linux-kernel+bounces-283323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B2194F01E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DABFB2538F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA51183CD1;
	Mon, 12 Aug 2024 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWgTjLti"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6619183094
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473948; cv=none; b=X1+eaKnOGpYBMLqGkisBoOdkTdnlZLtJX8eys97sUOiKBgxrzosQTgcD4qxBWQXeUKTKPwwSb5uyGC6sVTcUqvo1f7pPTNi7+WMNlTZoQzldCquDWsy2BK7w6bdxbmyLgRGDlxd56v8QM7KiQia2ZTYhpSO6KbP90YRELSsmZCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473948; c=relaxed/simple;
	bh=WnV0Uspi16IHonX08wdWD+YLO3AeDpfJBCsb8N7KDM0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=icqjXKhCm0eQ/8kNs8qMm1vpVG/8w4TomQmxiUJ6HND42IXZOqCrJvNuN0nCY/0oM6GN8D38NA2v4r/u/UDrY3qIe1Yp/YKfNpiuxiiGYUZMPTX6lU0wxsKmfe7WHTNISh553sduiMJsVxA45Aa+Kl1yNVDI2eQDTqTFnAGBA80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWgTjLti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18100C32782;
	Mon, 12 Aug 2024 14:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723473948;
	bh=WnV0Uspi16IHonX08wdWD+YLO3AeDpfJBCsb8N7KDM0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QWgTjLtiKLHueE1ON3w2Yd3Icg5B0723o51jaQf5d8A57ETidHPPPC9i/H6HKKazl
	 z/8VrCYFr2BzOYQgaiNT9AO03rHsUKr6mtRX25DM/tznWQD8EUKNT0SKidGHs1be+o
	 EJzLkD0JhKUfRAkGVF8dkJwdWWdvMhAMXOn6WxHTCVr87TP5EjxcQlk9zhJXJBlww0
	 P/+9Lkq2buVSyPagr9HM0/WUsDvKFXMiQqDe2nU9ce4X7rA1brL6Klw7kSmaTeRlkS
	 BDAoVvxL3PrQ9XhJYIf1r6Mv0KtrrVjBxIfNi0h7DwC8VOZxoG1qNcXc0Egpim3c9N
	 ZgWmf9b8xvXAQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: "Michael Walle" <mwalle@kernel.org>
Cc: "Pratyush Yadav" <pratyush@kernel.org>,  "Tudor Ambarus"
 <tudor.ambarus@linaro.org>,  "Miquel Raynal" <miquel.raynal@bootlin.com>,
  "Richard Weinberger" <richard@nod.at>,  "Vignesh Raghavendra"
 <vigneshr@ti.com>,  <linux-mtd@lists.infradead.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: winbond: add Zetta ZD25Q128C support
In-Reply-To: <D3E0BKGQIZ9R.1ULZZ93E18VGM@kernel.org> (Michael Walle's message
	of "Mon, 12 Aug 2024 16:36:11 +0200")
References: <20240804221535.291923-1-mwalle@kernel.org>
	<mafs0v805zwlv.fsf@kernel.org> <D3E0BKGQIZ9R.1ULZZ93E18VGM@kernel.org>
Date: Mon, 12 Aug 2024 16:45:45 +0200
Message-ID: <mafs0r0atztnq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 12 2024, Michael Walle wrote:

> Hi,
>
>> > Zetta normally uses BAh as its vendor ID. But for the ZD25Q128C they
>> > took the one from Winbond and messed up the size parameters in SFDP.
>> > Most functions seem compatible with the W25Q128, we just have to fix up
>> > the size.
>> >
>> > Link: http://www.zettadevice.com/upload/file/20150821/DS_Zetta_25Q128_RevA.pdf
>> > Link: https://www.lcsc.com/datasheet/lcsc_datasheet_2312081757_Zetta-ZD25Q128CSIGT_C19626875.pdf
>> > Signed-off-by: Michael Walle <mwalle@kernel.org>
>> > ---
>> [...]
>> > diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
>> > index e065e4fd42a3..9f7ce5763e71 100644
>> > --- a/drivers/mtd/spi-nor/winbond.c
>> > +++ b/drivers/mtd/spi-nor/winbond.c
>> > @@ -17,6 +17,31 @@
>> >  		   SPI_MEM_OP_NO_DUMMY,					\
>> >  		   SPI_MEM_OP_DATA_OUT(1, buf, 0))
>> >  
>> > +static int
>> > +w25q128_post_bfpt_fixups(struct spi_nor *nor,
>> > +			 const struct sfdp_parameter_header *bfpt_header,
>> > +			 const struct sfdp_bfpt *bfpt)
>> > +{
>> > +	/*
>> > +	 * Zetta ZD25Q128C is a clone of the Winbond device. But the encoded
>> > +	 * size is really wrong. It seems that they confused Mbit with MiB.
>> > +	 * Thus the flash is discovered as a 2MiB device.
>> > +	 */
>> > +	if (bfpt_header->major == SFDP_JESD216_MAJOR &&
>> > +	    bfpt_header->minor == SFDP_JESD216_MINOR &&
>> > +	    nor->params->size == SZ_2M &&
>> > +	    nor->params->erase_map.regions[0].size == SZ_2M) {
>> > +		nor->params->size = SZ_16M;
>> > +		nor->params->erase_map.regions[0].size = SZ_16M;
>> > +	}
>>
>> Since the size is 16 MiB for both Zetta and Winbond, why do you have
>> these conditions here? Why not just do it unconditionally? What
>> situation do you want to protect against?
>
> Two things, I want to make sure, the values I'll overwrite (which
> were set indirectly by the SFDP data I check here) are really the
> "before" value I expect them to be. And secondly, I want to
> fingerprint the SFDP as accurately as possible. I mean you wouldn't
> need the SFDP version either. Think of a preparation for a possible
> .match() callback in zetta.c. That would probably look like this,
> i.e. check the flash id and these four conditions.

Hmm, I see. I personally find doing it unconditional a bit easier to
grok but this is fine too I think.

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

> What are your concerns?

None. I was mostly curious why you did it this way.

-- 
Regards,
Pratyush Yadav

