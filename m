Return-Path: <linux-kernel+bounces-178558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616288C5005
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92EBF1C21337
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787391353F4;
	Tue, 14 May 2024 10:34:12 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F9C134CFE
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715682852; cv=none; b=jBa389sZLpMWa2JmwepQ4DrGrUkG6EecIf0igljWLQCzAQmRHj+zqCmJJ/diFJp92T6q7YrnMW5AQ9/bD/HSJwx3vbDM35/Oty+6f5iM/oHZjI6OXOhnrRlBv628p2zIhpgXJ9HgEDdKBQvOksbBh9KbbC81cIqymzZ4yqZuvcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715682852; c=relaxed/simple;
	bh=aRk6NvPZjBiEJiRpLJXdgQJsFiOoBHTdq0kSIFpu1og=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D/XwNpYqAgR0R23Gm3zQxOvJ1eZ5/r/onzUvUr4buhw3mi4B1GSM+hZwLBCj+8CiqVvFv07avAahiybqFOZXMLCynPcd/JBcaFcqJXDcrqU3AOJeBlAvbWTIsn5pe4X549oInQni6Sraq4eUR9wRbu8EGhhG0yY9jXY6r38Lys0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1s6pTv-0006iz-Tn; Tue, 14 May 2024 12:34:03 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1s6pTv-001KzM-C5; Tue, 14 May 2024 12:34:03 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1s6pTv-003QYu-0p;
	Tue, 14 May 2024 12:34:03 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] mtd: rawnand: make rawnand_check_data_only_read_support() work
Date: Tue, 14 May 2024 12:33:55 +0200
Message-Id: <20240514103355.817056-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

rawnand_check_data_only_read_support() calls nand_read_data_op() with a
NULL pointer as buffer which will immediately return an error. Allow a
NULL buffer pointer when check_only is requested. This should be safe to
do as nand_read_data_op() has no business in touching the buffer in
check_only mode.

Fixes: 9f820fc0651c ("mtd: rawnand: Check the data only read pattern only once")
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mtd/nand/raw/nand_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index d7dbbd469b892..a5e7d8deafbbe 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -2173,7 +2173,7 @@ EXPORT_SYMBOL_GPL(nand_reset_op);
 int nand_read_data_op(struct nand_chip *chip, void *buf, unsigned int len,
 		      bool force_8bit, bool check_only)
 {
-	if (!len || !buf)
+	if (!len || (!buf && !check_only))
 		return -EINVAL;
 
 	if (nand_has_exec_op(chip)) {
-- 
2.39.2


