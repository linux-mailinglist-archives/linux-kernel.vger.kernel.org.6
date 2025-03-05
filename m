Return-Path: <linux-kernel+bounces-546538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C33A4FBE8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA683A90D3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247E32066F2;
	Wed,  5 Mar 2025 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ED6gCxt9"
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE75205E2B;
	Wed,  5 Mar 2025 10:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170493; cv=none; b=aXXrn+edqwYuds3mA5qWxG+kd7sunGSrkOrzKlHBDHlmvOMwyfrljCJvvScopjErLILrtJyDUU7KgkVlK3gcgNr7+7NHT9m0hgV5zwCSQnijzO5BhBsdTTA6T2tq2OBDPSp9JfcFTG6TcBEOQLrg1XR9hGh+/Xo7SiIRwsYCwys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170493; c=relaxed/simple;
	bh=t/i/ZYSpCCcaalSAZPE6RIBpR+1kehNr94nOWqgWFQo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sDsO82jhxN0nh8spKEBq66UD7XpSaKZ0khES83Y/CmCIJu6A+FMiP0cHMtTond8UrqbK5gevGqpYn/VYXGSmD8lKo78tETeZo82bOFukGMEF+s13gtI+ZpSzj9R9iLy2rKyAzhJIxXW19isqgMlYg47BPYhVFmFBSM0iq25gRiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ED6gCxt9; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id CCD2E5826C1;
	Wed,  5 Mar 2025 10:22:18 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 25A8A204D0;
	Wed,  5 Mar 2025 10:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741170131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/i/ZYSpCCcaalSAZPE6RIBpR+1kehNr94nOWqgWFQo=;
	b=ED6gCxt9+D+E+Xnlpd76DBNkUVjEG/t0SiS3K1jmWMHm21BlSSePusLZ5xQ4KYtIwjO3ri
	DraOId/ugKydAwHutaD3tO1JHenfvXHELPfZf5SKRF2hlcsBQw7FyKXPx23ScoIiwWEUx7
	0VpJ7uy4rnxiZ5yzdqkK0EPiFdG9q1B4SIKPJFmmSiMenCuTx3npfnjW42+R2loxzYYFsa
	lPmRZfJwBnP93F1ciH/UKXT9p1i/kBV8+sqHj9F8BAQJt64Y1CAiuLEh31UIOnr4K4kPOc
	xj/plfY/t8/RqTB/zA5G1f9ruQjYBksXuu/3/1nz/JhuS+8J1OQI9tW5whqkhQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: <robh@kernel.org>,  <krzk+dt@kernel.org>,  <conor+dt@kernel.org>,
  <nicolas.ferre@microchip.com>,  <alexandre.belloni@bootlin.com>,
  <claudiu.beznea@tuxon.dev>,  <tudor.ambarus@linaro.org>,
  <pratyush@kernel.org>,  <mwalle@kernel.org>,  <richard@nod.at>,
  <vigneshr@ti.com>,  <devicetree@vger.kernel.org>,
  <linux-arm-kernel@lists.infradead.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  Varshini Rajendran
 <varshini.rajendran@microchip.com>
Subject: Re: [PATCH 1/2] mtd: spi-nor: sst: register SFDP region into NVMEM
 framework to read MAC Address
In-Reply-To: <20250305100134.1171124-1-manikandan.m@microchip.com> (Manikandan
	Muralidharan's message of "Wed, 5 Mar 2025 15:31:33 +0530")
References: <20250305100134.1171124-1-manikandan.m@microchip.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 11:22:09 +0100
Message-ID: <87ikonydym.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdegheeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledvrddukeegrddutdekrdelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeelvddrudekgedruddtkedrleeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopehmrghnihhkrghnuggrnhdrmhesmhhitghrohgthhhiphdrtghomhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnihgtohhlrghsrdhfvghrrhgvsehmihgtrhhotghhihhprdgtohhmpdhrtghpt
 hhtoheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegtlhgruhguihhurdgsvgiinhgvrgesthhugihonhdruggvvhdprhgtphhtthhopehtuhguohhrrdgrmhgsrghruhhssehlihhnrghrohdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

On 05/03/2025 at 15:31:33 +0530, Manikandan Muralidharan <manikandan.m@micr=
ochip.com> wrote:

> From: Varshini Rajendran <varshini.rajendran@microchip.com>
>
> EUI identifier and the MAC Address of the Ethernet Interface is stored
> after the SFDP table of contents starting at address 0x260 in the
> QSPI memory.
> Register the entire SFDP region read by the spi-nor (nor->sfdp) into the
> NVMEM framework and read the MAC Address when requested using the nvmem
> properties in the DT by the net drivers.
>
> In kernel the Ethernet MAC address relied on U-Boot env variables or
> generated a random address, which posed challenges for boards without
> on-board EEPROMs or with multiple Ethernet ports.
> This change ensures consistent and reliable MAC address retrieval from QS=
PI,
> benefiting boards like the sama5d29 curiosity and sam9x75 curiosity.

Do you mean spi-nor have a programmable area in their SFDP table? Isn't
this supposed to be a read-only area written once in factory?

I am not a big fan of exposing the whole SFDP area. I would suggest to
expose just the MAC address. You can make use of nvmem layout drivers if
that is needed.

Thanks,
Miqu=C3=A8l

