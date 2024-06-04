Return-Path: <linux-kernel+bounces-201404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED938FBE11
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F33428681A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FDB14C5A7;
	Tue,  4 Jun 2024 21:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Nq/kRnQj"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB4C14B97C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 21:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717536570; cv=none; b=H2ZaaAnjASkWSKGzYqKbjkDPem9RH1xG2ynTIx8Qx7plm7m9qAIYsqcxLvHNZyOzxxRNFCDzDO68FWB2n4/hMO2AueFBooKoALm9gptH80FIeEs2piaziIKTmJHvHjlISop1h/v3flvT8npOwQmdJikLdMtG37FIxhySZ+iCor8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717536570; c=relaxed/simple;
	bh=YjEfC9JjEnax5BqhFnJXN1aQoob3eshwGgMKZurw9bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iK3XiFiKfnpidhOldVR9XAJrhBGVC44hPGSvL7ICON/HHG2C78AzJShyjxJZj2yVpdA639ed6QuiVMWK7gtkvdtYpBPdstQEo7Gu8p/KVoLCituZOettcqTilPmAs0aeUtLeGjns5FCtVbpTuc4egpVTkbDaM2nIAEiCp1Ld3kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Nq/kRnQj; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=zA/cvpSqfElfT0r6FDsRgA1YFQJ3P0br6JbLu5Xhd7c=; b=Nq/kRn
	Qjv5PYPTUPiv4Pvop9gisylQDuRVoPvwiFaa09ybKasLtYTUnwumWDaHPLU0nq9t
	9ugMj53sIho7uvTy4XP/5EdRP5Id/GJQenSlicgpgJTnftFRR5UWl+WJlSviex9P
	9GtpGnVphz8FdhlOS/8CKB8VylFXiMRQRXGp8ED979kNa5QeFK03zzM7YZITcNuI
	ZQ/0fj+vMfLiCsTwjRkMXuZsSScZMYkG7tQbLPqFxRgI6kr0WhecWekj/W4Ebmj3
	1baHO3aRQ9RUiFJ56HfuPGg1ex+qNC1rWQCTANRG30u3uIUCfhhZJOffLthBtoml
	0yh165ELd1gIY1XA==
Received: (qmail 2450912 invoked from network); 4 Jun 2024 23:29:26 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Jun 2024 23:29:26 +0200
X-UD-Smtp-Session: l3s3148p1@mF7sJBca9NlehhtB
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Subject: [PATCH 1/2] mtd: nand: mxc_nand: use 'time_left' variable with wait_for_completion_timeout()
Date: Tue,  4 Jun 2024 23:29:20 +0200
Message-ID: <20240604212919.5038-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240604212919.5038-4-wsa+renesas@sang-engineering.com>
References: <20240604212919.5038-4-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_for_completion_timeout() causing patterns like:

	timeout = wait_for_completion_timeout(...)
	if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
self explaining.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mtd/nand/raw/mxc_nand.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index 9d50f41b3d5a..e22fbea970d1 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -457,14 +457,14 @@ static int wait_op_done(struct mxc_nand_host *host, int useirq)
 		return 0;
 
 	if (useirq) {
-		unsigned long timeout;
+		unsigned long time_left;
 
 		reinit_completion(&host->op_completion);
 
 		irq_control(host, 1);
 
-		timeout = wait_for_completion_timeout(&host->op_completion, HZ);
-		if (!timeout && !host->devtype_data->check_int(host)) {
+		time_left = wait_for_completion_timeout(&host->op_completion, HZ);
+		if (!time_left && !host->devtype_data->check_int(host)) {
 			dev_dbg(host->dev, "timeout waiting for irq\n");
 			ret = -ETIMEDOUT;
 		}
-- 
2.43.0


