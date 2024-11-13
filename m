Return-Path: <linux-kernel+bounces-407328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0E99C6BFF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A6728300C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD971F9EC1;
	Wed, 13 Nov 2024 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="G6fus04p"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEF31F8F17
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491389; cv=none; b=HY6VRKn9Vb69u+rLlL/EY7sTB9mYgx+ca2ysM4fjvkrxw+lamzfha+/l5DatixNl/QV/r8idBtiAAXpj3cXeTAtlN9fpiL6YxkpAdNx1z5VHAHOvSWwaQTBA3sKTNgrvXb3fzdwpvL/whLT70r2pMdwvim7J26+Mjy7DXtmXL1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491389; c=relaxed/simple;
	bh=deaieWFiVONpNRlAhKMPRKsF7JDojpQ/DZGVZJ9W5Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Atzq7uTcoBiaLvWLeEqj1hL0seLKP6zRCYGGSLHpHMdsosmiWjTcJR7w1ISrRSxYIeSMkHiAPp05CBTtHYiCfh5Tp37EwAPsd/tappm9phCntHB+hNTLwBLEyxRwi9dDcd7dGwWub0F+KEACk5PjS1tPw0Bjni1c3ZCEfijoMm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=G6fus04p; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id B537CC0015;
	Wed, 13 Nov 2024 09:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731491385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=khZM5fFii6r1q+Z9uZi3Zgk6G9+0lCTuTox0qCES4xo=;
	b=G6fus04pgyae3nSlDlFWrBF12kmjcAp2kkEukWQwgsFLZV0EYdZxH/fxAQw+TR+r/UN9eo
	IJm6A0JrbjU7J7KwoGHOgLJJ7Lx83NzMzZtu0n7sDis7qc6E67hrTgoQRpjX4QreskI9MU
	pzANRQZyMR2dorrEPZniD4VCfSBj7TgyJwIRp6+CNaGZ0dsjDQTFKBBp8AZ2bYi4iLOcZt
	VggKgwFoeE93a+1xKcTtgwnMvbrD19exqMCmTjg8/1BU9KNrzfQdBzg6jIYSk1jh9Ge56A
	YjverQ9YVOP2ZXcLVvCoKcXVK5deWTOf265qPcTYCnNN9GTR3jHyY4qiVrtmTg==
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
Subject: [PATCH v3 5/7] mtd: rawnand: davinci: Order headers alphabetically
Date: Wed, 13 Nov 2024 10:49:36 +0100
Message-ID: <20241113094938.44817-6-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113094938.44817-1-bastien.curutchet@bootlin.com>
References: <20241113094938.44817-1-bastien.curutchet@bootlin.com>
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


