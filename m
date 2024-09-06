Return-Path: <linux-kernel+bounces-319091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B8596F7A1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ADF41F249D0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866221CE706;
	Fri,  6 Sep 2024 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EnpmWgwR"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C426322A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634964; cv=none; b=PwCfM2rX//omcIayyS28dJdlWOVwyrjZ2xvvI43y/BakblBG1mVGZBJEsV31qhqMtC90/76Khuz8iWgGAD//LPGl6e8KFvITyqtxuvoEJ/+yBV05QpEwZ6ZqSduEBTNrPrDHyUuk89VIJPy1b3BTo3B6DsZxTSki8KfKyM2TMOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634964; c=relaxed/simple;
	bh=QxHPqNe7bufMq5480J10xaLieOA4Z7IhaWA/7VpPHNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hnE+F+LWmuRLih4puKS8Om2n/HKgI2cDOrEi9Vj9XHTbD7Ow9ZROtMTuZbU35UWyP9/enGhwDqBUw+cQcQ2dXWlnPvh1Eh0RpDHGQ5BOew1OEui3ZfN/DQsHl3Ibx3ycvQ/yz6SaqaaiR5xpmWUqZ0l2uCjMBFvtBuH3eKXxljs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EnpmWgwR; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CF69C1C0003;
	Fri,  6 Sep 2024 15:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725634959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i4NwCDNbYacNK7slYwJrfHAzDYt4Ot43sYTu2s3f1BI=;
	b=EnpmWgwRxUCAo+2FAFoXoAhJ7OQubPcBPqPcXlifMH+TGXfqBv3qTkPsjTpNwP2mctunYE
	1b7VL+9gSWy/PMEhnMQgHNcVDweXCqdtF15vDc2j8DlSPs9l4PRgpUVFg8nvMnozdOCln/
	iDrgUqU+YIVLFGiuXNsxEm2gm4DGNu5bDmhz1DOGAEuCEVHxLUgogIakvKX+prbOVcsk+Y
	SxQFnwhSwB6+pGzBWxLKrfxpyTbjW2VnINpzr+LCtsdQ+kZhvH1T8Nu247CWLQkn4SqWeK
	HFwZmIc0Xx1JJUhEaJNtMMtrCq7ZKlDzmlz6hQeOncWEXIvNbJKHBoWxoA4hiw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexander Dahl <ada@thorsis.com>,
	linux-mtd@lists.infradead.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v3] mtd: rawnand: atmel: Add message on DMA usage
Date: Fri,  6 Sep 2024 17:02:37 +0200
Message-ID: <20240906150237.734148-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240828063707.73869-1-ada@thorsis.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'9b3c395096dcfd180877776d492173419a5251d2'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 2024-08-28 at 06:37:06 UTC, Alexander Dahl wrote:
> Like for other atmel drivers (serial, crypto, mmc, …), too.
> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

