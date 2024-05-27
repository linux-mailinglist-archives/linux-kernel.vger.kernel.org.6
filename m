Return-Path: <linux-kernel+bounces-190565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA358CFFDD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 602671C21748
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1EB15EFC8;
	Mon, 27 May 2024 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dA5SRJHB"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B73E15E5C6
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812344; cv=none; b=F5DSP+e2ujks2167ZQmY6EswUp4kDxwhl9OsXE0rrvV9HRkrHVZxFRJCi14BYsuMl5b+ZI75CHbCdcyXD1+UF36urS5KBGX9c6xZo7/s89Z8Mw9Mf6qC7JYUXuIaaZ6VPi/yEPPUE1dIPR3goVUFqjojKhV9TrZpaW3T7TglI3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812344; c=relaxed/simple;
	bh=d6onJWQ43ut4FAfzUfVW8Q6OxdDvvmDr+sGo4V+q5v8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n05R6dz92s22ldQRZqBcH6uhHWErG5GP60JqINPJXGktwnI1FZ6EnZMTvfoxJWM6YJ+HeWEzDyPPTaBjqOU2wNuqB4FVAPqq4c+26uO74m3bblKpSp+TSkxEpAkxRQVsF0mFqmvrbqaxLcrwcSfcFnBeIrUOgc8qtVDnISCZ1F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dA5SRJHB; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2210A40009;
	Mon, 27 May 2024 12:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716812335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BFRarOeDypft+k8uWZknOSEqhErJiarm7OGg4vuEPo0=;
	b=dA5SRJHBFM/Ksac4FbUxWjmu9faiatMO/l0ptLDLhHhxxj7MYpix44zim+creA/NvGJU+r
	U4FELk65uKC4JwRY8k40HjlZ1UC955ExFPaFBS+AYxLNIHTf/wg/jZ5rVDnn1PSvMqatwU
	c/nyXJK/qeq7tgYO0tb9z7xwuVLVoevWo165j8z3ntie7QLHhVVM1QhT3relk0G5yhSmEz
	ZtRW8/I2mfKv54TaJtY2imu8wfJfhDL7f5fsG57sPLbOdkAZ/esm5z86VTvtFoUP35Q1Sb
	C0peTfBlt6Xw0JgRCU2itWMAgasokcj8bD9Bts0v59+yhIBVkz2mltib81Qglg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sascha Hauer <s.hauer@pengutronix.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] mtd: nand: mxc_nand: separate page read from ecc calc
Date: Mon, 27 May 2024 14:18:54 +0200
Message-Id: <20240527121854.178599-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To:  <20240522-mtd-nand-mxc-nand-exec-op-v4-1-75b611e0ac44@pengutronix.de>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'022127a167c21dbd474d563c0d28d3c7278c177f'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 2024-05-22 at 05:39:51 UTC, Sascha Hauer wrote:
> Our read_page hook currently reads out a page and also counts and
> returns the number of bitflips. In upcoming exec_op conversion we'll
> need to read the page data in exec_op, but the bitflip information
> will be needed in mxc_nand_read_page(). To ease exec_op conversion
> separate the page read out from the bitflip evaluation.
> 
> For the v2/v3 controllers we can leave the bitflip information in the
> status register for later evaluation. For the v1 controller this is
> not possible, because the status register is overwritten with each
> subpage read. We therefore store the bitflip information in the private
> data.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

