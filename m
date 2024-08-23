Return-Path: <linux-kernel+bounces-299433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE4C95D475
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C15928A0C5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C64191F87;
	Fri, 23 Aug 2024 17:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NgRyzyva"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF09191F62
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434514; cv=none; b=vCAIqMQUCTVT9nvsyOst1RhNo6O9NHxojesrUP/T6OVswLJJP0pHsW0IO1YxFDmn30nWoYpbSRhJ2uP5i6eQEOyX1WwRqQkaUGJ+Rr/8hzZKXtG/MIZg3JziszdVXWqYa2WfTnAJErEi0PLgnadS85xbYSfIA8PH0NJvVDmdJRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434514; c=relaxed/simple;
	bh=Ok1rSON6NAB107fePLs5ZggTEkt0eTbnWFQsFg0G8YE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSii73x/6tOjCj6X9u/MovEiTjRd9JsLEUgeOwkpWL17iHINTOlHRCtxGSkeREvfYOS4xaHcDWm2jV6FblPOvQ4vbHlnrrsB1VWOsPsmQ2SqSQW/enuy8PI4btw/xqXOths3RP3S4qOBQ02oED7wb+crRpsP2RbFsGlowx3yhGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NgRyzyva; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 66366FF806;
	Fri, 23 Aug 2024 17:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724434511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NHT1Wq5o5PPv+C7Lif3dYKEgNEol9JXhGL5aV8EY8LI=;
	b=NgRyzyva4Eb6wFBSJyYUhNrI6dAQ5mkNelnNwv/P067aQ6G27jDh31zX0YkOPMT5xyb9gE
	lBUPdJRvLt5mX3nS6U+hoVI9pdigU6IOgGwf/I+YgaiLYuBp8H5XltOIILHuwepPdlLqoh
	0DDEAloF227FqcAP/fUqx3zMSJTiNWtH/kcqbFZHOgSGh4V2wTeYf6VjTCgh9UsbbWeWPK
	q6U7/8tWxzjm6FfWfEiuEQpxd5HfQPNId3IXxAw1z/15qmOCedhB+8mIiJVAEB/PYBhsq2
	2dDeeEoNJQpOBDj0DOiLvdi7XRhHNpQBwTJ3T7Uyqv67sYoZqbiSkP6bNfDvVA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Daniel Golle <daniel@makrotopia.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Chia-Lin Kao <acelan.kao@canonical.com>,
	Martin Kurbanov <mmkurbanov@salutedevices.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spinand: set bitflip_threshold to 75% of ECC strength
Date: Fri, 23 Aug 2024 19:35:08 +0200
Message-ID: <20240823173508.517440-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <2117e387260b0a96f95b8e1652ff79e0e2d71d53.1723427450.git.daniel@makrotopia.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'1824520e7477bedf76bd08c32261c755e6405cd9'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 2024-08-12 at 01:56:41 UTC, Daniel Golle wrote:
> Reporting an unclean read from SPI-NAND only when the maximum number
> of correctable bitflip errors has been hit seems a bit late.
> UBI LEB scrubbing, which depends on the lower MTD device reporting
> correctable bitflips, then only kicks in when it's almost too late.
> 
> Set bitflip_threshold to 75% of the ECC strength, which is also the
> default for raw NAND.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

