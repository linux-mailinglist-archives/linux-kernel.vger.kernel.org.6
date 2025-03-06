Return-Path: <linux-kernel+bounces-548448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14095A544FC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 249743A18DD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE16E207A03;
	Thu,  6 Mar 2025 08:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mF8P6ZyA"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F1C19C54C;
	Thu,  6 Mar 2025 08:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741250087; cv=none; b=agbD6cDchAX6IXpSnL3hHBAamGQvLZq034GWGTAnxNDgE0AMccaoosSD8AhcjlBh1MWmk6gDDCXHgpfYx4VbZZdZjkHX5qgQpWrEThxrNF4uPyaESUuYcD3Kpa3FrBRUM0PgUURtlpxVxbsuAvfn338OCDzqgKa3iYYMPQ7lFAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741250087; c=relaxed/simple;
	bh=gBbw0fjQDznlJtTVw1BdqqMtyMCcthJvjl2WCmyzYyU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=enK1d1v64yVmfeRsCsU1lAtkbQlNTr4CAK7pM5DfarXoY/2ZW/zeB5wEbLoicmV4XlEzNodsNLp3BP8uT6VJC313dvd57Wq0lPG5O7U8df8hv1IOTLdZch/h0mNODFJpi1e+Fin/cZH52dNcp3dwQNw/t3RvHXQXa0hZN4og1O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mF8P6ZyA; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 435F744267;
	Thu,  6 Mar 2025 08:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741250083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4X+FnHVpWzWW4W0hGDVyaY0sBAjRDXZg/ShUEe46pbo=;
	b=mF8P6ZyAPX08OLt4l16Kpo2v7XG2grorpNpUUF2ND52CndXRHfjFV0oy/0WjBehTD5VZE7
	f+mraZVyAQQPAt4SFEev/YX24UWI4LhjvB3GTRNaQ4YNrbhNUIVGK3QsMawpwpYOW9obEh
	RsMG6stsKk68DAv6eZY+InvMQF3LSz7/wKKtC+ZkE41HylBQNUuEYyUYSSnscCKfXdnNsV
	DWqFrp872aRrtLF8IuGFzj8oqNxq61u+Kl1ye0+RDclKmW4kGejtdp8d/4RwrLRPeiOhiS
	DLrtSBWgq6iM6miU7AmQNzvXBkHjT5nT88HacGvinpbJAQMAPOlu57ikZO4d+A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: <Manikandan.M@microchip.com>
Cc: <mwalle@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <Nicolas.Ferre@microchip.com>,
  <alexandre.belloni@bootlin.com>,  <claudiu.beznea@tuxon.dev>,
  <tudor.ambarus@linaro.org>,  <pratyush@kernel.org>,  <richard@nod.at>,
  <vigneshr@ti.com>,  <devicetree@vger.kernel.org>,
  <linux-arm-kernel@lists.infradead.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <Varshini.Rajendran@microchip.com>
Subject: Re: [PATCH 1/2] mtd: spi-nor: sst: register SFDP region into NVMEM
 framework to read MAC Address
In-Reply-To: <6fee6e71-106f-474b-9a0c-5df5fb0caa00@microchip.com> (Manikandan
	M.'s message of "Thu, 6 Mar 2025 07:09:44 +0000")
References: <20250305100134.1171124-1-manikandan.m@microchip.com>
	<D889CRJC6W19.2LDQCDVG7BLNG@kernel.org>
	<6fee6e71-106f-474b-9a0c-5df5fb0caa00@microchip.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 06 Mar 2025 09:34:41 +0100
Message-ID: <87eczawo9q.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejvdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffeghfejtdefieeguddukedujeektdeihfelleeuieeuveehkedvleduheeivdefnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudejpdhrtghpthhtohepofgrnhhikhgrnhgurghnrdfosehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtohepmhifrghllhgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopefpihgtohhlrghsrdfhvghrrhgvsehmihgtrhhotghhihhprdgto
 hhmpdhrtghpthhtoheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegtlhgruhguihhurdgsvgiinhgvrgesthhugihonhdruggvvh
X-GND-Sasl: miquel.raynal@bootlin.com


>>> +static int sst26vf_nor_post_sfdp(struct spi_nor *nor)
>>> +{
>>> +     struct nvmem_device *nvmem;
>>> +
>>> +     sst26vf_sfdp_nvmem_config.dev =3D nor->dev;
>>> +     sst26vf_sfdp_nvmem_config.size =3D nor->sfdp->num_dwords * sizeof=
(*nor->sfdp->dwords);
>>> +     sst26vf_sfdp_nvmem_config.priv =3D nor;
>>> +     sst26vf_sfdp_nvmem_config.reg_read =3D sst26vf_sfdp_mac_addr_read;
>>> +
>>> +     nvmem =3D devm_nvmem_register(nor->dev, &sst26vf_sfdp_nvmem_confi=
g);
>>> +     if (IS_ERR(nvmem)) {
>>> +             dev_err(nor->dev, "failed to register NVMEM device: %ld\n=
", PTR_ERR(nvmem));
>>> +             return PTR_ERR(nvmem);
>>=20
>> I don't think it makes sense to have this one-off in a particular
>> driver. If at all, this should be handled in the core. Sorry, but
>> this really looks like an ugly hack.
>>=20
>
> Because the EUI identifier within the SFDP is unique to the=20
> SST26VF064BEUI flash, I opted to handle it here rather than in the core.
>
> Also here the MAC address data resides within the 0x260-0x26F range, I=20
> will resize the nvmem_config.size to 0x10 instead of registering the=20
> full SFDP region as NVMEM.

Open question to all parties in this thread: how do we give an offset in
the device tree that is relative to the sfdp region and not the data
region? I believe we care not to mix these areas while describing.

Thanks,
Miqu=C3=A8l

