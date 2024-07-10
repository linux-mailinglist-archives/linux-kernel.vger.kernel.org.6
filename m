Return-Path: <linux-kernel+bounces-248108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8C092D87E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C23D1C215A6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EF2198822;
	Wed, 10 Jul 2024 18:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="e+zqpSZ9"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15707197A92
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 18:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720636986; cv=none; b=Q5HqvqS538f9rwPDudLTZE4kTGOZh0tbCqyg9Ru6AlMR6Y5jBXkXMsov4GkvlMBwbaCp8CzO++0J7IskN7t/NrEuAFUus0ufSFGv1l56VXzdacV7DLhV/T8Rt01kjGL79j8VGkAEmq9de+uJbHskl5rIuMQDPAuG0syYCjTiMQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720636986; c=relaxed/simple;
	bh=88Lgzgpa5B7DbnACTJ4woAvKwm19JHnYdVe3dK9AO44=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XFxq+455s6KdoSOxfpig0QJiM+3ZwNHVoImGukm9IxLEwyDRQ+Mij7PJnM5Xzb//zmaKQkstbze1UWvhyBBIMgPXLyz9TD1maHvlJYBhayyvBRMdmfDKrCi2LQTD3DI10MQGqu+L38NaC22Q5Wq3gCpnNQW5RA6aO6EyWl2ZTT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=e+zqpSZ9; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=nyIgQtN8QYgk5tphg5sVnfnZLubXZbbI33/J8ejtOrA=; b=e+zqpSZ9Agv/VKDuPusPOVML4r
	aaUZdNZJmsxdRTCRQe68LKoZeo1rmFZCgz+5n1bKVA3J7JYs8WDaK3D+LfjQ6QHGDmr101AgA2wfc
	WU9InU9XKhddLVRHztOE6alfRQG0aQboM84FheDp2DtjoSQQWiVSWEpw+nEPg5wIJLtPJZYMTa4cw
	q+jHTrmRqQRa0FJIxVt5ODoj0eyVrdDPBAEurIjmM2WGmFucNTpi9FWAb141KOoUSvseKf7Wt77Tf
	jiidHspP/XgJmQbuy9/SsCUOtYcjvlKV4G+z/BeadLBWM98OxHyxA6Eqw3EKNHSn2b8A+aGLQvXAQ
	srUJZ94A==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sRcHK-000C3l-Um; Wed, 10 Jul 2024 20:42:58 +0200
Received: from [87.49.147.209] (helo=localhost)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sRcHJ-000G9H-1y;
	Wed, 10 Jul 2024 20:42:58 +0200
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
In-Reply-To: <D1SZKLZBDDBA.1Z7ZD4UEOX05F@kernel.org> (Michael Walle's message
	of "Thu, 06 Jun 2024 15:59:01 +0200")
References: <20240603-macronix-mx25l3205d-fixups-v2-0-ff98da26835c@geanix.com>
	<20240603-macronix-mx25l3205d-fixups-v2-1-ff98da26835c@geanix.com>
	<a379a411-2c9e-4d9d-aa8f-4c4f3463cc27@linaro.org>
	<D1SZKLZBDDBA.1Z7ZD4UEOX05F@kernel.org>
Date: Wed, 10 Jul 2024 20:42:57 +0200
Message-ID: <871q413x72.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27332/Wed Jul 10 10:36:46 2024)

"Michael Walle" <mwalle@kernel.org> writes:

> On Thu Jun 6, 2024 at 3:31 PM CEST, Tudor Ambarus wrote:
>> On 6/3/24 14:09, Esben Haabendal wrote:
>> > A dedicated flag for triggering call to
>> > spi_nor_sfdp_init_params_deprecated() allows enabling optional SFDP read
>> > and parse, with fallback to legacy flash parameters, without having dual,
>> > quad or octal parameters set in the legacy flash parameters.
>> > 
>> > With this, spi-nor flash parts without SFDP that is replaced with a
>> > different flash NOR flash part that does have SFDP, but shares the same
>> > manufacturer and device ID is easily handled.
>> > 
>> > Signed-off-by: Esben Haabendal <esben@geanix.com>
>> > ---
>> >  drivers/mtd/spi-nor/core.c | 3 ++-
>> >  drivers/mtd/spi-nor/core.h | 1 +
>> >  2 files changed, 3 insertions(+), 1 deletion(-)
>> > 
>> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> > index 3e1f1913536b..1c4d66fc993b 100644
>> > --- a/drivers/mtd/spi-nor/core.c
>> > +++ b/drivers/mtd/spi-nor/core.c
>> > @@ -2933,7 +2933,8 @@ static void spi_nor_init_params_deprecated(struct spi_nor *nor)
>> >  
>> >  	spi_nor_manufacturer_init_params(nor);
>> >  
>> > -	if (nor->info->no_sfdp_flags & (SPI_NOR_DUAL_READ |
>> > +	if (nor->info->no_sfdp_flags & (SPI_NOR_TRY_SFDP |
>>
>> I don't like that we update deprecated methods. The solution though is
>> elegant.
>
> I actually had the same concern. But currently there is no
> non-deprecated way to handle this case, right?
>
> Right now we have the following cases:
>  (1) pure SFDP parsing
>  (2) non-SFDP flashes with static configuration only
>  (3) legacy implementation, where the magic flags decide whether we
>      use SFDP

Actually, in the code we have two variants of 2.

(2a) non-SFDP flashes with SPI_NOR_SKIP_SFDP set
(2b) non-SFDP flashes without SPI_NOR_SKIP_SFDP and with none of the
     DUAL/QUAD/OCTAL read bits set

These almost handled the same way. But
spi_nor_manufacturer_init_params() is only called for 2b, and not for
2a.

Is this desired behavior, or something that we want to align?

> Which case is eventually used depends on the ID of the flash -
> assuming there will only be IDs which either fall into (1) *or* (2).
> That assumption is clearly wrong :)
>
> I'd propose a new case in spi_nor_init_params()
>  (4) try SFDP with a fallback to the static flags from the
>      flash_info db.

/Esben

