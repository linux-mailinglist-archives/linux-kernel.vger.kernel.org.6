Return-Path: <linux-kernel+bounces-412789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0EC9D0F70
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90AAAB31C63
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2EC194A63;
	Mon, 18 Nov 2024 10:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lWsTJ83Z"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592EE194C62
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731927227; cv=none; b=fqHY0corZCdLqY0+/euaY1ECOT1ySyineuvWCF/nkNJ6SOldEHGUtOVXY2jeS3lQl08EZIEO2VKNlk9ySfVWS+ek7NN0HZ8/uk1Nz6FjADXP2nwC9PObkdC98VISi77U2lJT6pvzEm3fLmchUyqqTJm40OVk1Wv5c8UJHA9EsuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731927227; c=relaxed/simple;
	bh=qMNhhf4AJiQlf8seJMUUIANSuBH8/Hc53QQnO/Pwl2s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EKYiR3kDLuxO5SUXh/sDH3RarlPftxH0J3mT2tcHeOSC/n9YZflbwRRUzPmm1DeHRxPhsr9xuHhcShxalU4OK2NCyL4HsiTpUO7lAFj2x/37rjW53XNHwmJzZpqs0TeLrlstAK+bM/Z6DBCre/FZ+PpB9fHPDdRLBpjI3uAP26M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lWsTJ83Z; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 171D4E000A;
	Mon, 18 Nov 2024 10:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731927223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMNhhf4AJiQlf8seJMUUIANSuBH8/Hc53QQnO/Pwl2s=;
	b=lWsTJ83Z7/D+bGIImekxeCyyueE+xJcz98Pb44JXUiEJmRV7QrJZGzx3WJ2lS8lDLS/QXi
	yXY9qgssIyx/qIwEiERDdhJtfJy30kNlyobMcraZR+wbSZNKwUULdpAYtjE22GzWMmJq8A
	WmTNDd5TivV0/xPtYz106JuRfDnuXjMBUdW1gmerJ13Mvh7ogKHSHsVfhBEG+sXJruaOLL
	FymCMg8v+4HxTo5WzpY6QNX93F50/CmK/0fH1+i/9Rw3ruos41ZOE568AFtLtMjuhdYk6U
	US8m0wb7AiJ06zHMUwopSR3MYjzD+BT9MIdWk2jNJntChaFkq0dB0ovUfpvQgg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,  Richard Weinberger
 <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,  Daniel Golle
 <daniel@makrotopia.org>,  Chia-Lin Kao <acelan.kao@canonical.com>,  Mika
 Westerberg <mika.westerberg@linux.intel.com>,  Cheng Ming Lin
 <chengminglin@mxic.com.tw>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <linux-arm-kernel@lists.infradead.org>,
  <linux-mediatek@lists.infradead.org>,  Steven Liu
 <Steven.Liu@mediatek.com>
Subject: Re: [RFC PATCH nand/next 0/4] mtd: nand: spi: Add CASN page support
In-Reply-To: <20241020132722.20565-1-SkyLake.Huang@mediatek.com> (Sky Huang's
	message of "Sun, 20 Oct 2024 21:27:18 +0800")
References: <20241020132722.20565-1-SkyLake.Huang@mediatek.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Mon, 18 Nov 2024 11:53:35 +0100
Message-ID: <87jzd0zuc0.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

On 20/10/2024 at 21:27:18 +08, Sky Huang <SkyLake.Huang@mediatek.com> wrote:

> From: "Sky Huang" <skylake.huang@mediatek.com>
>
> Hi, this is Qi-Ze Huang(Sky Huang) from MediaTek. On our router platforms
> chips, we have to quality lots of SPI-NAND devices and are eager for
> a standard so that we don't need to maintain trivial flash ID table
> anymore. I also noticed a talk in 2019 Embedded Linux Conference,
> Memory Technology Devices: what's new, which mentioned "ONFI for
> SPI-NANDs? Maybe, maybe not".
>
> So earlier this year, I proposed a bold idea, CASN page (Common Attributes
> for SPI-NAND). I worked together with top 3 SPI-NAND market share flash
> vendors and other vendors to integrate CASN page on their SPI-NAND devices
> including but not limited to:
> [ESMT]
> F50L1G41LB
> F50L2G41KA
>
> [Etron]
> EM73C044VCF-H
> EM73D044VCO-H
> EM73E044VCE-H
> EM73F044VCA-H
>
> [GigaDevice]
> GD5F1GM7UE
> GD5F1GQ5UEYIG
> GD5F2GM7UE
> GD5F2GQ5UEYIG
> GD5F4GM8UE
> GD5F4GQ6UEYIG
>
> [Macronix (MXIC)]
> MX35LF1GE4ABZ4IG
>
> [Winbond]
> W25N01GV
> W25N01KV
> W25N02KV
> W25N04KV
>
> A document of CASN is hosted on github(https://github.com/mtk-openwrt/
> doc/blob/main/CASN%20Page%20Introduction.pdf) So I'll try to keep it
> simple here.
>
> With CASN page, we don't need to maintain SPI-NAND flash ID table anymore.
> Currently, it's integrated in 3.3V SPI-NANDs of small density and it's not
> JEDEC standard yet. But it should be able to handle 1.8V and can be easily
> integrated by flash vendors.
>
> I believe this idea and implementation have room for improvement. Hope to
> hear you open source community's comments soon.

I think this is a bright initiative. I'd welcome some standardisation on
the discovery indeed.

But to be really useful, I believe this table must be really complete,
otherwise ID's will remain. For instance SDR/DDR modes are not entirely
defined as we already have mixed modes. There is also no information
about what maximum frequencies can be used with each operation. As
another example, there is no read retry information. Nor anything about
the fact that the on-die ECC engine might not be disabled.

Overall I think this is an interesting initiative but I would like it to
be more advanced. Is there a plan on getting this standardized through
eg. a JEDEC spec?

Thanks,
Miqu=C3=A8l

