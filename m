Return-Path: <linux-kernel+bounces-180747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B427F8C728D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ACCC281942
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE266CDA8;
	Thu, 16 May 2024 08:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UyB1VdKz"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA958282EF
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847242; cv=none; b=kA+7oKapAH866Sd9ky2EbEpEn2qRGP9IvVe7ccpEY/0hW3ryVW10Jm1CoCTEPjXdU+E+M+xhXPyff/vAmQuf5ZKH2JcJc2OgA8W6wVtfgwtdPe5/+ObjZqX1RqSSOwXR44viaijWRq3cqa6Xj2yzNY+ZJvEKbfTD6OxBTnd4Mvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847242; c=relaxed/simple;
	bh=vy3R1czSIAJZEiVCrAT1VQrBFnTqvQtDzBodaJ2eSSk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZQGySovGTxkURK1qzfNj/YR0D1xKeuvCeh79PjFQ3bhZpVl1h9+QRoREErN+TOAop8GxZTqqSBqGT+nK2g9OoG+xO0axPdoWoXl2/csQtdUWPrz557PlMxbcrjs04g3HwLXh2YZ6Rn/F5cQxkWqJbAKcinWEypMTQ0X4R2sn0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UyB1VdKz; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E7944000E;
	Thu, 16 May 2024 08:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715847232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b2/hxtco63GpIUnQcjEi0uFkar4EC6MCevZBbmlEDM0=;
	b=UyB1VdKzA0phoZwd5f/TyztFgpciJgn+VkO5SmFhGe/GlhAAUhhrLF0Dxk++huzIc26wpH
	FA1XobuAYg4v9grOecv+It4WAvAeOo+E3uluRP5RyiE1tMlT8WoPIQjO1azQfDt2qQI2y1
	Afjeg2XkSxv9WwRbWB3aGJA4dJI4kdcRM40RMTjXWjm3RV+udFf+fLLtzyT5RSraZc2Y8F
	+7bL+FYE6HzDkU+RvoTiJ73zIM4//cWhk0cTURMcOV6YS2j5msP4AGMsywOckCY/LRDNM1
	DbFjOTwHfGJq9wu9ewBqpnc0KezSnkrcC87hVbaOgokllQr/Bn/XqIzrn0xieQ==
Date: Thu, 16 May 2024 10:13:50 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, Richard
 Weinberger <richard@nod.at>
Subject: Re: [PATCH] mtd: rawnand: onfi: read parameter pages in one go
Message-ID: <20240516101350.78e5ee29@xps-13>
In-Reply-To: <20240514134140.1050141-1-s.hauer@pengutronix.de>
References: <20240514134140.1050141-1-s.hauer@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Sascha,

s.hauer@pengutronix.de wrote on Tue, 14 May 2024 15:41:40 +0200:

> nand_read_data_op() is not supported by all NAND controllers.
> nand_change_read_column_op() is not supported or at least is hard to
> support by NAND controllers that use a different page layout than
> expected by the NAND core.

I'm sorry but RNDOUT is not so hard to support, and I know no NAND
controller without this feature (I think even the first mxc controller
supports it?). However, the command does not exist on small page NANDs
(512 bytes). TBH I have never seen such a device myself, so I wonder
how spread they still are.

What may not be supported however are the DATA_IN cycles.

> Instead of relying on these functions
> just read the three parameter pages in one go.

Bitflips in parameter pages are very rare, they are normally quite
robust. The proposed solution impacts *all* NANDs, because the I/O
chip speed is at its lowest. There is no reason in most cases to do
that.

I agree there is a problem with the patch I proposed and we need to
settle. And we simply cannot make RNDOUT calls randomly here as long as
we want to support small page NANDs.

I believe we should do something like:

nand_read_param_page_op(0)
if (corrupted) {
	if (supported.datain)
		data_in(); /* this is faster */
	else	=09
		nand_read_param_page_op(1)
}

I'll try to draft something (also applies to the jedec discovery).

Thanks,
Miqu=C3=A8l

