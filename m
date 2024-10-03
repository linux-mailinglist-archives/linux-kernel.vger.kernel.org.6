Return-Path: <linux-kernel+bounces-349211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8AA98F289
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47BE8281570
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1FF1A2569;
	Thu,  3 Oct 2024 15:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LczFIZBQ"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E9F1A0AF8
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727969305; cv=none; b=B4QWPbK6Fq1itVoHl/XLynZOk8gPzn3IbBBDKOfLlzAayFqfMA4uo5njZ1oKsOz14A1rkxLqjFLtTa2ribyZAP99befBecPJr+IWLCg8I5vgejG5Yosuz9XGbnEJy0/p+aEw6/GZ8UJ8b+r7NAzejo8zf14cPlTEY6Kjnc81eVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727969305; c=relaxed/simple;
	bh=o4tSB0OS+wj4OBBCgHzoXYq0HMKB0OkF9xUGHJud/6w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2PM8aPDFQlZE9pRbcIQ0Is0ClIZAMXqhz5MAaXb8Rq/oWTTneNhheFO6ZomHghJiTcK6vhLhSZYLzdCS6AiWMyZJkeOuBMKwjNobxnfZRTn1IkZ7q3wD9d4dMCOsGFQEYSDFVgxVugN2ztEv7WrWoyxLdaHTF8Ubz40JNAJxiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LczFIZBQ; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 51F40240007;
	Thu,  3 Oct 2024 15:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727969301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uxCb51voBr0vjEKD8Q9WRN/h6yqu39Aa5iGYpPO4WHM=;
	b=LczFIZBQBywG/pvyV+PJInj0A/ure9+4X9XrYO+ADcmJvKs85YwuuAol2kPqw5kC/zAk7W
	KW+K9QESHu6r2EiGFUIFVnR2xswJuJKNFfBhURnd7rjx22L4dGJoUxcKE7Ib48L55oCmtB
	7kGj506/RD6XSv5e0B+P2RFcGv/OHmuD098Um52Wu/EK972kYgJN+S8mL3tfmbGEleeQ/u
	ESrzlctfK9Hvu3DAXUePCOXEKowvT0+/raVHY/H5l/hE/9z18jvTYKfVUs7FOZkzoO8TPB
	v47DIC6MenA9s3iEBG9IAAtLraXOng5wuEkeio166YTAffoiAX+mFCmqctQTxg==
Date: Thu, 3 Oct 2024 17:28:20 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Han Xu <han.xu@nxp.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, imx@lists.linux.dev, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mtd: nand: raw: gpmi: improve power management
 handling
Message-ID: <20241003172820.50324192@xps-13>
In-Reply-To: <20241003150500.uz2efay7kadu47if@cozumel>
References: <20241002153944.69733-1-han.xu@nxp.com>
	<20241002153944.69733-2-han.xu@nxp.com>
	<20241003093840.2965be20@xps-13>
	<20241003150500.uz2efay7kadu47if@cozumel>
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

Hi Han,

han.xu@nxp.com wrote on Thu, 3 Oct 2024 10:05:16 -0500:

> On 24/10/03 09:38AM, Miquel Raynal wrote:
> > Hi Han,
> >=20
> > han.xu@nxp.com wrote on Wed,  2 Oct 2024 10:39:44 -0500:
> >  =20
> > > The commit refactors the power management handling in the gpmi nand
> > > driver. It removes redundant pm_runtime calls in the probe function,
> > > handles the pad control in suspend and resume, and moves the calls to
> > > acquire and release DMA channels to the runtime suspend and resume
> > > functions. =20
> >=20
> > May I know the motivation to acquire and release the DMA channels
> > during suspend? In general it seems like a different change which I'd
> > prefer to see in its own commit with a justification. The rest looks
> > ok otherwise. =20
>=20
> Hi Miquel,
>=20
> Thanks for your comments. IMHO there is no much logic changes indeed, jus=
t move
> the dma channel acquire and release from system pm to the runtime pm, rel=
easing
> the unused resources as early as possible. If you think it's necessary I =
will
> split the patch into two parts.

Actually I don't understand why these channels are released and
acquired again. Does it make sense to do that in the (runtime)
suspend/resume path? I'd be in favor of avoiding this extra
configuration which as a first sight does not seem required here.

Thanks,
Miqu=C3=A8l

