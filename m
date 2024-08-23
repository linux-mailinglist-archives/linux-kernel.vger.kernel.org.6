Return-Path: <linux-kernel+bounces-299434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A8495D476
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FF3A1F2441F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE48519258E;
	Fri, 23 Aug 2024 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kHcwluRr"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646C81922CF
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 17:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434518; cv=none; b=lOZD98QhFNTlz47DWxc/Rv8mg1wuGroHW6jgbzzF+hEvzZV3Sgh0Tf4MOya1n8DTIgdQBjiBi5ceqUaBACJ3364YtlauJCfgzjXNRtnx3RJGxLgtnbc1f4MF5ELpMDWau4RfKzG8tmJLHzjQmq4JjR/9tqNav7yrX+zS6gJR570=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434518; c=relaxed/simple;
	bh=NrfIabSuSd1R/JPQ80LjC75ZQ+ugxmcPrELoJKlEUoQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SsqVbvGa2IpJrtfMq31woccWzlszpf2h/0expVZU+jThDJwuVPug++e49VQ1FTgp8KXXRL9f6yHTLOkHtFqOhsjiNNkntrdlP2Tc17daJx/6SSaoUbfYcoHLbSXwOf8/5kqv3hc4hhEcw4DHA+TIJDLBH8nec0DrffICT2CrRVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kHcwluRr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E50C040007;
	Fri, 23 Aug 2024 17:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724434514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nak4z/1artOEKYnquWyMtHGZNqWW8VcXZpYkd6Npm4Y=;
	b=kHcwluRrRyOHi5BCU4EXFlNkHZQSSziNXfIn+cxt1bQ33wbreHG0S3ccwM6ynVHPcmGBIb
	LYACgRa6Lg6g3wzLHqYXwOGyW4Jcu9FGHuaohDRkGwUgCosLYFg7sgdUDTB+o521XM0kH3
	FUm93HTuYWOP6dnbzbpF4G2TTXRP+EK5+W8fdIbd+QYc7Zqmql8b+N3mKzBPm5IY5yU8NN
	sE1RYWdnscyLrR7aEsjZSYOsTRh0NgsHSrOzWBwGRA4YdP5zyOh10bQavX/YUDTkexX0O3
	7eGdDRjBsn2ROovhPNklGZ+fbJFEcM0diuZ7eLTIWZYPekinrRHAGVvq8G3FQQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Robert Marko <robimarko@gmail.com>,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spinand: winbond: add support for W25N01KV
Date: Fri, 23 Aug 2024 19:35:13 +0200
Message-ID: <20240823173513.517469-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805175125.6658-1-robimarko@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'e2a9fcb36e851adb5b25c4acea53a290fd48a636'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 2024-08-05 at 17:51:02 UTC, Robert Marko wrote:
> Add support for Winbond W25N01KV 1Gbit SPI-NAND.
> 
> It has 4-bit on-die ECC.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

