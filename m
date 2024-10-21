Return-Path: <linux-kernel+bounces-374050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B58F9A6130
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 519B4B2858F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2951E8840;
	Mon, 21 Oct 2024 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NuURmxs8"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B14F1E32CC
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504977; cv=none; b=sPlQtWRAQJxzZQoo2PGf4P/KDGvDuP4jXPPb9H1o4zeg8Z7JIFC9qSgs8sKO5t2nwvYx/k2tHXnEFf6xfb5VozGKnIN42e0ZpQSsaltRQ8nFIGuk4Ysu132zSW/EAZ+TkPwyp13grAAxRpyD90pK/Qjzgs62KJ4YFdyzv6+HaMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504977; c=relaxed/simple;
	bh=dXHUShCn2dfNOye5k867IyEiPMYlYRMMGeC2l1xpSDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7hR1SX9TIgvQ5SVqzUlC210xua9In4RW4bECpoIypvX6jUkr7KkUjnK+RXRCGtMeES5iAN7fdJAfr1c9VeFyIn/x/axJMTKY21TP/oPbLcL5LAdyAFSBegwlNwu4BtOH9HPypvmTnEMeg0dIRPwFnqBuNr+ToHmdsXH4aDQ1q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NuURmxs8; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AAA3024000E;
	Mon, 21 Oct 2024 10:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729504973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oCHkWoiDZ2NL3DMs2gZVGmNiyeQybxl46/EswM89aLQ=;
	b=NuURmxs85KKQufA0vlRiH+G3HW5xoQTCY3IrCYwIrctoD7O3Q4AzVeQ3REZ8qarMuipoWw
	ZQSthDhCPVQobAka3sbDgCpgVTOHQS85K9+OZ5rZOxrCCrc2lE6MwLj5GyzUE1JiJZ0dra
	aMMS3+yA3ZXc9GCCHGmbEQvBaCGxTzcCwhDwYzME2ZEo5YwxOYtrX1xJZkZ9c93L0OSTHp
	vWV+KAYTdvA8UiKSb79ouK2EAL8980NgDoSKLieSR35qJ8BTosiCiGmWJGJetvTNQuFFD7
	BsErEULVuNyCDk8g0BBKRViK8fvKtlIYe2zCWmemUuv/jFhonlezLMHg3N6gJA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/3] mtd: rawnand: davinci: order headers alphabetically
Date: Mon, 21 Oct 2024 12:02:52 +0200
Message-ID: <20241021100252.173482-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007122350.75285-1-brgl@bgdev.pl>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'03dbf1c9fe32c051c3e96034e196cc1054602451'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 2024-10-07 at 12:23:48 UTC, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> For better readability, put all includes in alphabetical order.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

