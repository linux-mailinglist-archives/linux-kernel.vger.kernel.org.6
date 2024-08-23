Return-Path: <linux-kernel+bounces-299412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AFE95D442
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC56283B99
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB50D18E764;
	Fri, 23 Aug 2024 17:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fSTwPzVl"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC44318594C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 17:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434122; cv=none; b=LmDFqqKuvKQge2wnnXl/VGmUpELo8maE+1lbMnc8+0iZDBh7XdRQDwLbdR5Gz5H2NJvEeC278YP3AXGONhhC49MfMmP3weY9QVyuwuihL1uuyFxuRe9u/GhEXDp4/xqlUVKTf9nJtZnZ78mRFeOymrZxF2VVCwO91fugZjReFCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434122; c=relaxed/simple;
	bh=39K7tc3e0+c8JsHHlSNsIL/mIOqCw4GElUEw8pk8bv0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QK0mHckrL1TIkL/TOwH8mabniQ0tdqD/fnjQz58JN0U2HjPm03Nl1Fo5EMQigVWap18/i5pHYJx3hNuUiKyH1wI8Q3aTsQLtBD/u+B9XJzTlEV/XW8qDUwxT3cx+ADFQ/HSNmu2Dzdud11BCfD/2SN9B0EZd3aRVDE+KmNGqWUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fSTwPzVl; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F5A81BF205;
	Fri, 23 Aug 2024 17:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724434117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=39K7tc3e0+c8JsHHlSNsIL/mIOqCw4GElUEw8pk8bv0=;
	b=fSTwPzVlyfxghOmNiW7wuk/STl7UuDpohlbS+JLl2wHwaluRPYUnz1DEJwldEgeRvdN2kD
	l1m5EeLpUxN1tZolMidPQqNPKEWckaHlRZpHpy1BpAg+fl2VepPB00G0gR9Qf4efLqbM71
	yoBto3N+tevNZMaIFZ5blMkH1YWcmd80bGH0o+qm0HlBHwbZ+aI/3YVueF1tkG49QNgEws
	YFbu52WuAAZPyrF3pQ/+IuW8A/WCOM2r76eHPrw5L+SvY/Y4eBbL4uX83Qs5+nmaiHSjQn
	5e07aJWZSa7y6Y6P2y7xmDejt+H0gZsaWfKSVuCqSCzXqIo1VtSLegGdxWdAWA==
Date: Fri, 23 Aug 2024 19:28:36 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexander Dahl <ada@thorsis.com>
Cc: linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Kees Cook <kees@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91)
 SoC support), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2] mtd: nand: raw: atmel: Add message on DMA usage
Message-ID: <20240823192836.0e7ddbb0@xps-13>
In-Reply-To: <20240821142006.645306-1-ada@thorsis.com>
References: <20240821142006.645306-1-ada@thorsis.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Alexander,

ada@thorsis.com wrote on Wed, 21 Aug 2024 16:20:05 +0200:

> Like for other atmel drivers (serial, crypto, mmc, =E2=80=A6), too.

I was about to take the patch but I figured out the prefix was wrong,
please change it to "mtd: rawnand: atmel:" (and don't forget to collect
Nicola's tag).

>=20
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---

Thanks,
Miqu=C3=A8l

