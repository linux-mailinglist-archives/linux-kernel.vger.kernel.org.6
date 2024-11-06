Return-Path: <linux-kernel+bounces-398448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B91F9BF170
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437571F21D17
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CC61DF738;
	Wed,  6 Nov 2024 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="p0boApFJ"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20631202636
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906414; cv=none; b=KCABwY38NvJMVmW36RuVif4Y2HOkfgPzFnkDAEO4oWoWCrBNEJH7U9E70AOZSp/BNBS/KXwQ2jc3CHaahaJ6d6cA2m/Zkxo1PTVerF3hPmYEDMXzXO0XPFX/Tor0GsKzf3QUGTHp5r5TBOS1Tw29cEYxldDOkQ9rATzipX6WoUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906414; c=relaxed/simple;
	bh=/JTfVzE7ndYuEakwvhQQZl5z6a3t9taLOo0NBJcHY7E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pEloSTsHGGgcbe3vrZUJFQXuqidGkeasT6Sp+r62h2ptCgp1Bf03YWW6kgkgMCTg3QFiqnHxK/Gg3VZfbNETkuOIcp50qEFRxCKk8f+OyrD37fH2Tohp6FwX6toqDpwwzI8LdzvX7gidlR//DG50QJR1hf86lUhIhiRKwojyA4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=p0boApFJ; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1FA5040007;
	Wed,  6 Nov 2024 15:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730906404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/JTfVzE7ndYuEakwvhQQZl5z6a3t9taLOo0NBJcHY7E=;
	b=p0boApFJ2BQaNnPJoTPYhTIQcDUiL0yp0cf/5Mfg/Lg8eAGgJWouOQxt08pXVChraVKmVE
	yMdCzM4IzDXjH5FTAx4kg6RUbZoHAvWU+RDShCaHkGUs4xFNeR+mP4+jciQnjwUqjdon7c
	zLtPuwOaFgI4bCNn/WV3M+58QoLgoZsIqo8lTMSxKiZtrnuM8r+7Au6TkxSCCS3Fzuz4pB
	dh1d7351wPofXtKRRCjbHFou6KiLG/LIrmMRZg4EIL8ckN2jm/UL1ef/7+aNDRACni7C/x
	dUtT1M+3EIo7zsh0CNeUsCni0XdTx3P2KBEV0ruyonUKRNRap6khEp7xPfzD8g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: SkyLake Huang (=?utf-8?B?6buD5ZWf5r6k?=) <SkyLake.Huang@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
  "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>,  "acelan.kao@canonical.com"
 <acelan.kao@canonical.com>,  "chengminglin@mxic.com.tw"
 <chengminglin@mxic.com.tw>,  "mika.westerberg@linux.intel.com"
 <mika.westerberg@linux.intel.com>,  "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,  "matthias.bgg@gmail.com"
 <matthias.bgg@gmail.com>,  "daniel@makrotopia.org"
 <daniel@makrotopia.org>,  "vigneshr@ti.com" <vigneshr@ti.com>,
  AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
  "richard@nod.at" <richard@nod.at>
Subject: Re: [RFC PATCH nand/next 0/4] mtd: nand: spi: Add CASN page support
In-Reply-To: <e8c1ea093943141b431d8eb3ed3831c50601dfb1.camel@mediatek.com>
	("SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCkiJ3M=?= message of "Mon, 28 Oct
 2024 15:25:59
	+0000")
References: <20241020132722.20565-1-SkyLake.Huang@mediatek.com>
	<e8c1ea093943141b431d8eb3ed3831c50601dfb1.camel@mediatek.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Wed, 06 Nov 2024 16:20:02 +0100
Message-ID: <87ses4jsnx.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com


Hello,

On 28/10/2024 at 15:25:59 GMT, SkyLake Huang (=E9=BB=83=E5=95=9F=E6=BE=A4) =
<SkyLake.Huang@mediatek.com> wrote:

> On Sun, 2024-10-20 at 21:27 +0800, Sky Huang wrote:
>> From: "Sky Huang" <skylake.huang@mediatek.com>
>>=20
>> Hi, this is Qi-Ze Huang(Sky Huang) from MediaTek. On our router
>> platforms
>> chips, we have to quality lots of SPI-NAND devices and are eager for
>> a standard so that we don't need to maintain trivial flash ID table
>> anymore. I also noticed a talk in 2019 Embedded Linux Conference,
>> Memory Technology Devices: what's new, which mentioned "ONFI for
>> SPI-NANDs? Maybe, maybe not".
>>=20
>> So earlier this year, I proposed a bold idea, CASN page (Common
>> Attributes
>> for SPI-NAND). I worked together with top 3 SPI-NAND market share
>> flash
>> vendors and other vendors to integrate CASN page on their SPI-NAND
>> devices
>> including but not limited to:
>>=20
> gentle ping

I had a look at it, it is interesting but I have some questions and need
to come back to it. Unfortunately I was a bit busy these days. Sorry for
the delay.

Thanks,
Miqu=C3=A8l

