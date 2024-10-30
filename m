Return-Path: <linux-kernel+bounces-388499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1109B606D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0AC21C212CE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AA71E04B6;
	Wed, 30 Oct 2024 10:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="j2Wzx280"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2B71E3DFD
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730285250; cv=none; b=fZOXJIwbpGJHhNjA2NSny5JcbifRz5/HU1NYJa3vvFmwQTWreOHJPxTpOUpi04ZPgeh+T86pCo8kxPI6uzN7u2p5QrJ6WmxVILwDkjik4AuIe5vYPnZPlGUYRfnbjdC5K9GpD3PfWkhQcI4YUM2MjpbXYdPSMXSj83/l/gZ1sOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730285250; c=relaxed/simple;
	bh=deaieWFiVONpNRlAhKMPRKsF7JDojpQ/DZGVZJ9W5Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=paWkddUkrOMUcPRW7C6+INn7eogAUFIV6U8AThi47n127eJmFyjGE6/mrgVcQosUz6R9pHMKhwMyTQO/kEtD+cZLw+yHkaLUl6JE8FQMl4CrGcydwqLqK0C63fOh2ZiB1AuOBtAXsS9X0i4AvjKaiONeAqoVQgU6P0waonqD5Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=j2Wzx280; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id C87FBC0009;
	Wed, 30 Oct 2024 10:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730285245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=khZM5fFii6r1q+Z9uZi3Zgk6G9+0lCTuTox0qCES4xo=;
	b=j2Wzx280k2XQM968sbuT1U2dYsnCPm2HLQU44ngdEJm5ohLBShOcnDn0Q8BiPY4sDbgywE
	vQ0iBf2JEtODkaqrQVeN2/BgUMxAfCjO5MG06L6KxFxBqhR8LpJRNiDcdsclMgTZh4hn3e
	I8dZbmyPUNWZoxXuR50KbLCpc2XnpGplT3QV9fclVnA/T5umEx3j5Dvet1COyfBQKpGele
	xaMxoqjVViK93DS3kgwOCpSU1NE3s2Yv3XOx3J6Jt2LoRX/Tyepf5p4aM3ojMnCZsbSTTl
	HZK+QqgIL/fo3mR6lyGQB89GBkcz9ndKpELVpfAlIPVmzPMtbKX7xz0PNXge3g==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Santosh Shilimkar <ssantosh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Christopher Cordahi <christophercordahi@nanometrics.ca>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH 3/5] mtd: rawnand: davinci: Order headers alphabetically
Date: Wed, 30 Oct 2024 11:47:15 +0100
Message-ID: <20241030104717.88688-4-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030104717.88688-1-bastien.curutchet@bootlin.com>
References: <20241030104717.88688-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Order headers alphabetically for better readability.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/mtd/nand/raw/davinci_nand.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index 392678143a36..3c0efbdd789e 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -10,15 +10,15 @@
  *   Dirk Behme <Dirk.Behme@gmail.com>
  */
 
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
 #include <linux/err.h>
 #include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
-#include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
 
 #define NRCSR_OFFSET		0x00
 #define NANDFCR_OFFSET		0x60
-- 
2.47.0


