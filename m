Return-Path: <linux-kernel+bounces-525498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB8EA3F0A1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42B5B7AAA24
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8345E204691;
	Fri, 21 Feb 2025 09:39:31 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DCE205E1A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130770; cv=none; b=JE/IQ8S568k0hJI1Om5NqwBltOby3nDBOCEugxXB6LqtFo5ctEuVA7ltVHtGXFRBXriceuMK7GKWzJv3x0nMhxbMaSVZKSX/vlkdP3MFAyOSRpStGZVn70ZfxuHus2xPWgebrhmkYMq4ufUduzndwmJYSLrGq9x/X3Hf54ttD4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130770; c=relaxed/simple;
	bh=jBP3yn8EoczVygvEooEdxOeCaOGnWGEZlmynb+kkie8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VsPMEo7iRQ1Y97P8VV8/V4qOkCPt+ftIMKCEXjszyCx1PlkiTTDL4uhAPTSfcm4s5RnWyVk/Veoai2udzA0hw79Jjxnut0SqfG7n+xBA2qBYnl+nnskK5UiMCOF89Hq5se5gq13PCrqQ14EzipiqlgiLmUmKFY1sFT+AWN+U41A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tlPV9-0001zX-QE; Fri, 21 Feb 2025 10:39:19 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tlPV9-0024uy-1S;
	Fri, 21 Feb 2025 10:39:19 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tlPV9-00GXc4-1F;
	Fri, 21 Feb 2025 10:39:19 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v3 5/6] mmc: block: abort requests and suppress errors after undervoltage shutdown
Date: Fri, 21 Feb 2025 10:39:17 +0100
Message-Id: <20250221093918.3942378-6-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250221093918.3942378-1-o.rempel@pengutronix.de>
References: <20250221093918.3942378-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Extend the existing card removal checks in mmc_blk_mq_complete_rq() and
mmc_mq_queue_rq() to also account for the undervoltage state. If the host
has entered undervoltage shutdown, mark requests as quiet and abort them
early to prevent unnecessary retries and error logging. This ensures no
further operations are attempted on the card after an emergency stop.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/mmc/core/block.c | 2 +-
 drivers/mmc/core/queue.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 4830628510e6..ecb87da0e257 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2129,7 +2129,7 @@ static void mmc_blk_mq_complete_rq(struct mmc_queue *mq, struct request *req)
 	} else if (mqrq->retries++ < MMC_MAX_RETRIES) {
 		blk_mq_requeue_request(req, true);
 	} else {
-		if (mmc_card_removed(mq->card))
+		if (mmc_card_removed(mq->card) || mq->card->host->undervoltage)
 			req->rq_flags |= RQF_QUIET;
 		blk_mq_end_request(req, BLK_STS_IOERR);
 	}
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index ab662f502fe7..f46e01988fe8 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -239,7 +239,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 	bool get_card, cqe_retune_ok;
 	blk_status_t ret;
 
-	if (mmc_card_removed(mq->card)) {
+	if (mmc_card_removed(mq->card) || mq->card->host->undervoltage) {
 		req->rq_flags |= RQF_QUIET;
 		return BLK_STS_IOERR;
 	}
-- 
2.39.5


