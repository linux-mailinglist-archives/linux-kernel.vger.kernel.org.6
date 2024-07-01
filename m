Return-Path: <linux-kernel+bounces-236193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A55F691DE95
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3FA1F23C56
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB8614B08E;
	Mon,  1 Jul 2024 12:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VpJd9+na"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5939914A604
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719835219; cv=none; b=iCks6zkjtrzu44hrHJ+1h1pXwbtq65RUKxodSWiLok6NUaEhws06B6+QT2OqJWvJYZ15Zx68d0p1QIFGSZ1Mxc7mWrm3y3xKmJIuPjSv/DrZEgsGRLLEcsM0hjBCnYcgSiCg5oZPxrVTzCVLRhaWPUT3KDD+2JXJmrdnThW1sbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719835219; c=relaxed/simple;
	bh=RgwvYYJsZCJ7KP+l8g70WaRLVJBKhr42ZIf6nsbta4k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nQYHNphzOvjp5PyzyQ8Bzdf4Rg5ucNefMiJlqI2UoxH4LoB6+6jwThQN5knFlX1Tbrq343hw2XOS05Julh+IEIIx8M27MhnQNS3lTBQf5KgjMJcovXIU95ifn8V2wBCC4ZheBbp9+FRgrlvq6yrdYYxO60AscjfupuS05bJ13Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VpJd9+na; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 78FBBC000E;
	Mon,  1 Jul 2024 12:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719835214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ItJX2QwrJGe03CZSybinYRi4KXjMVifkjIchGCGtND4=;
	b=VpJd9+na/QcwfGaxjFLMIV+MEYzq0/l7d0jM4/KH5CYD93UGFu3KVUwrPIJ2a4rFRjEUFX
	ylpgCBnD4Yy7gaxfQIIQpyhur3yL+ns/yu5oiBz+WUmU9w2ONBJzaA4C5EwEf6/T1uJR0t
	G/w3OzWCRts3eWAPq9dN/YO2e+5LXqMgvMGOiyjZ1s5E1vTdak55heeVlo3gm0VHkD2OXL
	5xywfsjN1vfOA7E+7W9HQk0HFxpak3K1RTExI+OjmvUrRxXu3KiVY6dr8dn12afzqz8o8k
	WoUnSLs4KpMxaeKGdhqAhbSIy1Wbrfmb5TMa1poBZzcQSSsFI+Pa+YfGCPnqbg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Arnd Bergmann <arnd@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	David Woodhouse <David.Woodhouse@intel.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: make mtd_test.c a separate module
Date: Mon,  1 Jul 2024 14:00:13 +0200
Message-Id: <20240701120013.525411-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240529095049.1915393-1-arnd@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'a5cf054d325e6f362e82fe6d124a1871a4af8174'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 2024-05-29 at 09:50:39 UTC, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This file gets linked into nine different modules, which causes a warning:
> 
> scripts/Makefile.build:236: drivers/mtd/tests/Makefile: mtd_test.o is added to multiple modules: mtd_nandbiterrs mtd_oobtest mtd_pagetest mtd_readtest mtd_speedtest mtd_stresstest mtd_subpagetest mtd_torturetest
> 
> Make it a separate module instead.
> 
> Fixes: a995c792280d ("mtd: tests: rename sources in order to link a helper object")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel

