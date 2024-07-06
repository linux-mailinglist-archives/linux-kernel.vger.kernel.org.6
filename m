Return-Path: <linux-kernel+bounces-243210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAB7929317
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 13:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BD1A1F21CAA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0562158DB9;
	Sat,  6 Jul 2024 11:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="R2Hfadrr"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C86315624B
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 11:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720264924; cv=none; b=UMd5FY11/Zt/sjPXLQNhEXlA1i7q/hUvMKCLaQNO3XPfj78nlIvwqBUVGSyhkUiuy6ZSfAHuOwkjB2NhncUSttJH0mQ9YRnGrUkVnTuMp6+J7paMI3aS2GTAk2xy+s1ye66d9LktfcQA7OmGMDWRU2mGbOSmeYIenpp2oJhnANs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720264924; c=relaxed/simple;
	bh=FZluNKjq2UTA1D7/cQ+l7ws3ClAxigdEED5x/EbY778=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVnSgEFt+svMo7R6cCbCnRea/JvN9H2HgGTXvws/x2oPMnsDM1FogkS78dTlaP5ddfbVgdypcIueRVcXhmOuv71pXxFJidDTikf6KF2qSJ3hnVqPrwwG7wooyKVHGVOOR/xG1Pnw0VK93nxSVCRP/NXLs9cZI4mBZqqJlREXQns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=R2Hfadrr; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=N1PwxPL8CNJDYeVjR4HvcrKu3KtQLbZ1YXWFnBOhDwg=; b=R2Hfad
	rrwV2VX2Umk6bQIuY75BclpPhx39JqCqWHxa4ZAbZtgkhcfQfBNLtOhomt+zQqqf
	SgipuchQtXWPJWWLRkIq0hG8OOLKh+y1qvjn25UYpRDE1ixSKfuVtgSQbG/5SJOz
	wQmEQdIcnbxkV7VXmeYFXy6b2WzCwKzBL0FPKuetLWIZuUuzaa+lAJHSzhkTYpFM
	Kn9oujkJ8oSwxYwPgrhRH8iQ7Lmhkbtw0xNu3v8rhMxgtSx+tS/ed2zt7aqeCiwX
	XxGMCtgMKna4Rd8bappvQxQdot4cC66sUQcnNixfC+yL1RyI/54G2HdG78vh5hcq
	wu9l67GQSlqpsZHw==
Received: (qmail 3810488 invoked from network); 6 Jul 2024 13:21:46 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Jul 2024 13:21:46 +0200
X-UD-Smtp-Session: l3s3148p1@7AOoYpIcAsJQT+F6
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Robert Richter <rric@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 34/60] i2c: octeon: reword according to newest specification
Date: Sat,  6 Jul 2024 13:20:34 +0200
Message-ID: <20240706112116.24543-35-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240706112116.24543-1-wsa+renesas@sang-engineering.com>
References: <20240706112116.24543-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the wording of this driver wrt. the newest I2C v7 and SMBus 3.2
specifications and replace "master/slave" with more appropriate terms.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-octeon-core.c    | 6 +++---
 drivers/i2c/busses/i2c-octeon-core.h    | 4 ++--
 drivers/i2c/busses/i2c-octeon-platdrv.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
index 5b7b942141e7..16cc34a0526e 100644
--- a/drivers/i2c/busses/i2c-octeon-core.c
+++ b/drivers/i2c/busses/i2c-octeon-core.c
@@ -221,14 +221,14 @@ static int octeon_i2c_check_status(struct octeon_i2c *i2c, int final_read)
 	case STAT_LOST_ARB_B0:
 		return -EAGAIN;
 
-	/* Being addressed as slave, should back off & listen */
+	/* Being addressed as local target, should back off & listen */
 	case STAT_SLAVE_60:
 	case STAT_SLAVE_70:
 	case STAT_GENDATA_ACK:
 	case STAT_GENDATA_NAK:
 		return -EOPNOTSUPP;
 
-	/* Core busy as slave */
+	/* Core busy as local target */
 	case STAT_SLAVE_80:
 	case STAT_SLAVE_88:
 	case STAT_SLAVE_A0:
@@ -608,7 +608,7 @@ static int octeon_i2c_hlc_comp_write(struct octeon_i2c *i2c, struct i2c_msg *msg
 }
 
 /**
- * octeon_i2c_xfer - The driver's master_xfer function
+ * octeon_i2c_xfer - The driver's xfer function
  * @adap: Pointer to the i2c_adapter structure
  * @msgs: Pointer to the messages to be processed
  * @num: Length of the MSGS array
diff --git a/drivers/i2c/busses/i2c-octeon-core.h b/drivers/i2c/busses/i2c-octeon-core.h
index 7af01864da75..b265e21189a1 100644
--- a/drivers/i2c/busses/i2c-octeon-core.h
+++ b/drivers/i2c/busses/i2c-octeon-core.h
@@ -39,8 +39,8 @@
 /* Controller command and status bits */
 #define TWSI_CTL_CE		0x80	/* High level controller enable */
 #define TWSI_CTL_ENAB		0x40	/* Bus enable */
-#define TWSI_CTL_STA		0x20	/* Master-mode start, HW clears when done */
-#define TWSI_CTL_STP		0x10	/* Master-mode stop, HW clears when done */
+#define TWSI_CTL_STA		0x20	/* Controller-mode start, HW clears when done */
+#define TWSI_CTL_STP		0x10	/* Controller-mode stop, HW clears when done */
 #define TWSI_CTL_IFLG		0x08	/* HW event, SW writes 0 to ACK */
 #define TWSI_CTL_AAK		0x04	/* Assert ACK */
 
diff --git a/drivers/i2c/busses/i2c-octeon-platdrv.c b/drivers/i2c/busses/i2c-octeon-platdrv.c
index 7d54b3203f71..dc6dff95c68c 100644
--- a/drivers/i2c/busses/i2c-octeon-platdrv.c
+++ b/drivers/i2c/busses/i2c-octeon-platdrv.c
@@ -122,7 +122,7 @@ static u32 octeon_i2c_functionality(struct i2c_adapter *adap)
 }
 
 static const struct i2c_algorithm octeon_i2c_algo = {
-	.master_xfer = octeon_i2c_xfer,
+	.xfer = octeon_i2c_xfer,
 	.functionality = octeon_i2c_functionality,
 };
 
-- 
2.43.0


