Return-Path: <linux-kernel+bounces-548494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBED6A5459D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E343E18925EE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11E52080F2;
	Thu,  6 Mar 2025 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bcsa9PFy"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D364E209F31;
	Thu,  6 Mar 2025 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251408; cv=none; b=KhoFfwHBoJZlL9zS/QRlWNtnCvWDJUib+owvpg2QDdeySkBQS9QUjNXEdxRuVLfUc2qM6DG8TbUlbPydunLAbaaBjJCdSmNAtE3OeRuzwjzHRTIq51dNDfpPTO/mtZAHK43lhrynHZYryU9U7XaipeaD4h0yIc1PBGVxPXiFx8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251408; c=relaxed/simple;
	bh=nGwcEVedx/JIyaFBS6j1W8a/OxxJvsbDFiq4EOhTUjo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FLYrtoTRTqml0sbq3LcqbzxGKgQTOzTj+Ox+klNnl2rbJk2yqSeKS7i0U13toAyTCShji0bKyc2xMqPzZZ3mNslEzGpQswULJ/QttWI4mvld5mTxtfrFxt/7gDssxbha6Ha2Pu2QJEaPTQV/pGLUwZsdC43tqIT+2dQLeGrqcDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bcsa9PFy; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 095C644346;
	Thu,  6 Mar 2025 08:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741251403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nGwcEVedx/JIyaFBS6j1W8a/OxxJvsbDFiq4EOhTUjo=;
	b=bcsa9PFyZi1TSiKo447e1/X2al16CgcgnqKVunZQwmCl3qnrX42lHDEfhvyrbmi8JXKkhB
	n46Csjqw3jAiRBM19KIhHdgmgeuOcDB9nXpJmo2rqQc6VkrgUp7DkciYqtcArEWHn73+zs
	vOaVZVP1a9rn2+5TNQVfaCcttQlc7xWDfaaCNHhImxl/3QrjVunzqykZTzJ+uZrQDZpbrk
	mQc62IoiFiU82VxHheDJGLNJIe17Q+EtySnPObBAlP183ahUQNB1rJMFzBM0rLgZNyf9gN
	ihY0C10PIAZEEmNNvFV5HSlCP3iqRxg87xIM0B21c1zjCt7p66avf6QbXYbKxg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Michael Walle" <mwalle@kernel.org>
Cc: <Manikandan.M@microchip.com>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <Nicolas.Ferre@microchip.com>,
  <alexandre.belloni@bootlin.com>,  <claudiu.beznea@tuxon.dev>,
  <tudor.ambarus@linaro.org>,  <pratyush@kernel.org>,  <richard@nod.at>,
  <vigneshr@ti.com>,  <devicetree@vger.kernel.org>,
  <linux-arm-kernel@lists.infradead.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <Varshini.Rajendran@microchip.com>
Subject: Re: [PATCH 1/2] mtd: spi-nor: sst: register SFDP region into NVMEM
 framework to read MAC Address
In-Reply-To: <D891QPQIT13L.1S55ZM1J286PE@kernel.org> (Michael Walle's message
	of "Thu, 06 Mar 2025 09:39:31 +0100")
References: <20250305100134.1171124-1-manikandan.m@microchip.com>
	<D889CRJC6W19.2LDQCDVG7BLNG@kernel.org>
	<6fee6e71-106f-474b-9a0c-5df5fb0caa00@microchip.com>
	<87eczawo9q.fsf@bootlin.com> <D891QPQIT13L.1S55ZM1J286PE@kernel.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 06 Mar 2025 09:56:42 +0100
Message-ID: <87o6yev8ol.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejfedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopehmfigrlhhlvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepofgrnhhikhgrnhgurghnrdfosehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheppfhitgholhgrs
 hdrhfgvrhhrvgesmhhitghrohgthhhiphdrtghomhdprhgtphhtthhopegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheptghlrghuughiuhdrsggviihnvggrsehtuhigohhnrdguvghv
X-GND-Sasl: miquel.raynal@bootlin.com


>> >> I don't think it makes sense to have this one-off in a particular
>> >> driver. If at all, this should be handled in the core. Sorry, but
>> >> this really looks like an ugly hack.
>> >>=20
>> >
>> > Because the EUI identifier within the SFDP is unique to the=20
>> > SST26VF064BEUI flash, I opted to handle it here rather than in the cor=
e.
>> >
>> > Also here the MAC address data resides within the 0x260-0x26F range, I=
=20
>> > will resize the nvmem_config.size to 0x10 instead of registering the=20
>> > full SFDP region as NVMEM.
>>
>> Open question to all parties in this thread: how do we give an offset in
>> the device tree that is relative to the sfdp region and not the data
>> region? I believe we care not to mix these areas while describing.
>
> You don't do it, because there is not even a relative offset that is
> fixed. There should be a pointer to the vendor table inside the SFDP
> structure. Thus, you need to properly parse it.

If there is nothing static and the location can be derived by reading
the chip tables, I'd suggest to offload this out of the spi-nor core and
instead use some kind of an nvmem layout driver to retrieve the
corresponding region?

> Regarding how to reference it within the device tree, I'd assume
> something along 'compatible =3D "jedec,sfdp-vendor-table-NNN";' or
> similar. But no static/relative offsets.

I see. We need to invoke our DT binding gurus.

Cheers,
Miqu=C3=A8l

