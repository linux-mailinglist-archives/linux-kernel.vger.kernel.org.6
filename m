Return-Path: <linux-kernel+bounces-236200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A00C91DEA9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85311B233DC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21D9155A55;
	Mon,  1 Jul 2024 12:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pklm/J+p"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66192155332
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719835236; cv=none; b=lfVqsFudLT9P55+C9sxMaRB1rztvhGmANHmsYDkkj7ncaI2VPiSrSJmxkQUl5EZG5Pwy61Iw2rOp6d5//Il1ojFQW4eWVfg72H695gdfgiVXk6QtU3pfwQ66+KodNLM1c+uKy9ITAdM5F2RdOXz9pXf/Lx0h69rGwvXw7Bh3LhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719835236; c=relaxed/simple;
	bh=cdg3Vn98qZ7oARU4FlI4fkjayGjkqe8AY/54bj/jMvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mE1FcmbcsPffn3jxrvWveUGWyw1L/q3yfICPMTQSdTh78x6K+kHdBuULAgQzVSuB0YusasZFHosWpPGDoqvEomlCOTb4usH2E1rIKcS2cF/maJUpXWGnJW3Lw7CPa+dXQT6WTy9FbuewMeN85BZijDXfMuLSyKABBqak3/UFQZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pklm/J+p; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A4F3160007;
	Mon,  1 Jul 2024 12:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719835233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64LFwUS4Is69wJ6D0Vpr/kBDvHoL1J6TvpQz+n9BfAY=;
	b=pklm/J+pHxLS6jke9M71TPZjw/5/1KY+Hb/WI+jtYFo+73jz/h918s4WeBbz7mpjkfZxEQ
	HXo75L36noysRxjErknWqFPMJXRRf1rccxUi2L/ZBIXatHDcXzIjxRNJOyLivn1jVm5/uP
	Fy4WzsAVoq7jrsMine9OdYsh2uS68vuSObNAjq+f/8w6wZi3rOXOmbhQGApjZ6MMT0htlF
	1QwPaBZyzFzjWp8P3SPS0f5GZQriTAT77HnAQc968mZ4BBmJHkya4ObaKSyb3uT6c6Lhga
	6Z3nGjHt2z2XX2bMCR1P0+j3Ewj4Dgk0msT4NZ1EsClJdr8ZVysGeRMzuzdiHg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sascha Hauer <s.hauer@pengutronix.de>,
	linux-mtd@lists.infradead.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] mtd: nand: mxc_nand: always copy_spare() for page write
Date: Mon,  1 Jul 2024 14:00:32 +0200
Message-Id: <20240701120032.525600-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240528203006.1479230-1-s.hauer@pengutronix.de>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'd3dfbae6d4adee33deb804d28d10045878974471'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Tue, 2024-05-28 at 20:30:06 UTC, Sascha Hauer wrote:
> When doing a page write we always have to copy the OOB data in place,
> as the controller will always write it. Not copying it means we write
> random data to the OOB area.
> 
> Fixes: 3df54960b63cc ("mtd: nand: mxc_nand: implement exec_op")
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

