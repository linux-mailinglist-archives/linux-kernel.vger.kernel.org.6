Return-Path: <linux-kernel+bounces-295579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5949B959E89
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCFB7B22D9F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7953D199955;
	Wed, 21 Aug 2024 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="cxKl84oD"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD4918991D
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724246429; cv=none; b=CD51id7UVSWdL1/U4/Ee6xM9x+png4tbGZdOrfk8nx4d2tF18aSPYQuJ3IeeO7Gn98J1adq++UF6nrSVAapHS3ABbgVl3ygpU7pa2Q3F90P3h3h8PGlYBA9WbbYLqDXC99hN97TT4es7ncCVdcansO5eD5cvqatUFcSJaoxWh9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724246429; c=relaxed/simple;
	bh=hJZo6AyuOJCLupMjpQE1kczHrqcx8NFu543znMu+X8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgyrpfWOWqG+rhatXE8gDUnMeEYGTnJVqyD/BachprfoELkmBKdbF3myFrCKEP2iygqei/xDsmfFj3L26SPCt6k1fbh/6RW9Khp3bX3gCdPKI5FBURxZXeJVtjmUR3AElYJTxTh5kfzjQkdurYluV/0CAZ6a/TxjNVZEf4UZdBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=cxKl84oD; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D3534148346C;
	Wed, 21 Aug 2024 15:20:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1724246423; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/6SAo6PVLWJClsfzyHrkHAJBVOy5N9kixDFuGn0CPGk=;
	b=cxKl84oDc8cT8pEQQDsgrozKSItB2ILu/jt0c2SHQi+SwwmhJ1Z35VnI6jHI99ZsltSM+o
	yDO/L8ok/4ZwRMGOIfx3uFK9fwH9u5ywGxu+/1gB8ATgSMQ3pT8spAQ9mC+GLyfG5lE2v/
	WwMjYUFBZTNilPD14KuKtRPd69L1oqrI2cAV/AQ8S3wZnMqVhkVyYq52Bn/V07pMmQDkfi
	gLCxrqILoyWW/lKXjd1DRzUCrfNPs/pUUMX0zGTCH0WSl7MXxj+mxw8GthgfhQD5qmiCBh
	zz4NPPbanwtTpEqA+HEcU8PqvG8OCNyUUU4TKHYRWkCgyoAg3q5WD/6MHR/kOg==
Date: Wed, 21 Aug 2024 15:20:19 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Alexander Dahl <ada@thorsis.com>, linux-mtd@lists.infradead.org,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: nand: raw: atmel: Add message on DMA usage
Message-ID: <20240821-ouch-tanned-fed30ba26700@thorsis.com>
Mail-Followup-To: Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20240821120517.330868-1-ada@thorsis.com>
 <20240821151701.6bde9aba@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240821151701.6bde9aba@xps-13>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hi Miquel,

Am Wed, Aug 21, 2024 at 03:17:01PM +0200 schrieb Miquel Raynal:
> Hi Alexander,
> 
> ada@thorsis.com wrote on Wed, 21 Aug 2024 14:05:16 +0200:
> 
> > Like for other atmel drivers (serial, crypto, mmc, …), too.
> > 
> > Signed-off-by: Alexander Dahl <ada@thorsis.com>
> > ---
> >  drivers/mtd/nand/raw/atmel/nand-controller.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
> > index dc75d50d52e8..9e6dea2cf140 100644
> > --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> > +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> > @@ -2051,6 +2051,8 @@ static int atmel_nand_controller_init(struct atmel_nand_controller *nc,
> >  		nc->dmac = dma_request_channel(mask, NULL, NULL);
> >  		if (!nc->dmac)
> >  			dev_err(nc->dev, "Failed to request DMA channel\n");
> > +		dev_info(nc->dev, "using %s for DMA transfers\n",
> > +			 dma_chan_name(nc->dmac));
> 
> 
> The message here would be misleading if !nc->dmac.

Of course you're right, this is somewhat embarassing.  I'll send a v2.

Thanks for reviewing.
Alex

> 
> >  	}
> >  
> >  	/* We do not retrieve the SMC syscon when parsing old DTs. */
> > 
> > base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
> 
> 
> Thanks,
> Miquèl

