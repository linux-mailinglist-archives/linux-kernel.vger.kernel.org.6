Return-Path: <linux-kernel+bounces-347472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC52E98D32D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F8E1F210C1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAD51D043C;
	Wed,  2 Oct 2024 12:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="X5COiSNU"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A5E1CF7CD
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727871859; cv=none; b=QEisqrHZ6UxcMkOfp3PnfVENkh00uDvnpXrbQN+GbJ/yM3shW1jdHWG8WvFbTh88xPef9NIc+T/NiFgyFBluLG+MrWx8WxjIIEZF1M2WAiLKMH9GHVm9AJY+9J0yFOUqyTPUgzscJXxFo6SWr7Im7Z7ruMI30V+5LnViFdWzaD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727871859; c=relaxed/simple;
	bh=AXfgQFgrYOWrr1JI0a2AUh317kck3OzTKiZdxvH344w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bGraE1ggcxpzo/pXRaJ2Mwwt1Y6wNxAhH5wzqalBovQGPiOk+Fu4xuYnvjstFXnK1uu7+GEI9i4kFTHNH7OV2Tg0ReEPj3UT26nN4Mqa0+E2n+J+9mrItufMXlc9h2lAz4NMsq4hwvUwVxI/D6qPihLfeFnL6IP/nHyVWC2DYEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=X5COiSNU; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20b4a0940e3so49111755ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 05:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1727871857; x=1728476657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kA+m8L+34Dl8O49FU4PLpLTBcMA/CbhBqEQpr8t9PhM=;
        b=X5COiSNUO1jubtf/RZP48gYL1T72GZ1N1vpOIcu0pP1dsbIoXUytpRCqGYyIjg9tRa
         mIKpaWwA40Vztnd6p8o7HWfnHCsnBjY5K49Nd3Adl/kWIo5sFCWVFXV1ZWe5C55Oq9sp
         ah9/6cIWPalpq2Nph6xU0F12xD3nSTkqhXXHmJ0oinNh41q+cI4AhPB/Pok5Uv7SFNxT
         lplA5vMI/PuPkArhqGhs+K1gE1UykR4hjmOwo0pa95HPyMpcOwW2M+PiRiuKQJWDzei5
         KdgQHRAIy22a1nu9n0AiRc2QgYfAvOo2WzuUe5AmuUtLgqmKJkpm2Sg6BUBJIB8VCslj
         PiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727871857; x=1728476657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kA+m8L+34Dl8O49FU4PLpLTBcMA/CbhBqEQpr8t9PhM=;
        b=PX3yRePonJJfMq2dpPzo9bYj8dyfVu8CrI7evRO5Rverd0OiEKbwXnJoXU2lvjj3dM
         bByvAWw/6p3EzR7gu6otKlj04X1OydoWFnqvtbh7DNkRtO3mZ5r9kJLmXMBsC0CNTLPV
         D1cKxDEr5yHB5HFT3EpiPJJq0pcRW4htZLb+8Yv3D9//5p6yB/q7VJXDYxQNZ0zplR/F
         4XN7aHF5nTM7vhrkt4z+POATfGItceoGsnPUVAM+YEL6Z3k/p+lyUAxHt651zKEoG6Y+
         puS+vmrPF0nJkb0MMflSZkIRJBM8IOuXlhuwehOx+haaCtvoJyzm9QDT5evCjYvqMZtp
         ZFuQ==
X-Gm-Message-State: AOJu0Ywt+JxnxQ/Kb6v80xSIVqp3SSXb+hksUkBD1fCCTAxJcDpzzfbi
	22lNxxp7K3GG7NfnP59QdGQeTwBW3aHd2oT/FtFe2HbQtNGO5gWIJMmMXFgjugY=
X-Google-Smtp-Source: AGHT+IGt1z9+omq+f5JaU2ZY1Ce+XkUfn+29/8n0xvI3+pkAWKeOkerZ/xgR4+AORmpbU5JcYBBz7Q==
X-Received: by 2002:a17:902:da8e:b0:20b:9062:7b08 with SMTP id d9443c01a7336-20bc5a94f9dmr46308555ad.45.1727871857345;
        Wed, 02 Oct 2024 05:24:17 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e33852sm83508625ad.199.2024.10.02.05.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 05:24:16 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: willy@infradead.org,
	akpm@linux-foundation.org,
	chandan.babu@oracle.com
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH 1/3] mm/page-writeback.c: Rename BANDWIDTH_INTERVAL to UPDATE_INTERVAL
Date: Wed,  2 Oct 2024 21:00:02 +0800
Message-Id: <20241002130004.69010-2-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241002130004.69010-1-yizhou.tang@shopee.com>
References: <20241002130004.69010-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

The name of the BANDWIDTH_INTERVAL macro is misleading, as it is not
only used in the bandwidth update functions wb_update_bandwidth() and
__wb_update_bandwidth(), but also in the dirty limit update function
domain_update_dirty_limit().

Rename BANDWIDTH_INTERVAL to UPDATE_INTERVAL to make things clear.

This patche doesn't introduce any behavioral changes.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 mm/page-writeback.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index fcd4c1439cb9..a848e7f0719d 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -54,9 +54,9 @@
 #define DIRTY_POLL_THRESH	(128 >> (PAGE_SHIFT - 10))
 
 /*
- * Estimate write bandwidth at 200ms intervals.
+ * Estimate write bandwidth or update dirty limit at 200ms intervals.
  */
-#define BANDWIDTH_INTERVAL	max(HZ/5, 1)
+#define UPDATE_INTERVAL		max(HZ/5, 1)
 
 #define RATELIMIT_CALC_SHIFT	10
 
@@ -1331,11 +1331,11 @@ static void domain_update_dirty_limit(struct dirty_throttle_control *dtc,
 	/*
 	 * check locklessly first to optimize away locking for the most time
 	 */
-	if (time_before(now, dom->dirty_limit_tstamp + BANDWIDTH_INTERVAL))
+	if (time_before(now, dom->dirty_limit_tstamp + UPDATE_INTERVAL))
 		return;
 
 	spin_lock(&dom->lock);
-	if (time_after_eq(now, dom->dirty_limit_tstamp + BANDWIDTH_INTERVAL)) {
+	if (time_after_eq(now, dom->dirty_limit_tstamp + UPDATE_INTERVAL)) {
 		update_dirty_limit(dtc);
 		dom->dirty_limit_tstamp = now;
 	}
@@ -1928,7 +1928,7 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 		wb->dirty_exceeded = gdtc->dirty_exceeded ||
 				     (mdtc && mdtc->dirty_exceeded);
 		if (time_is_before_jiffies(READ_ONCE(wb->bw_time_stamp) +
-					   BANDWIDTH_INTERVAL))
+					   UPDATE_INTERVAL))
 			__wb_update_bandwidth(gdtc, mdtc, true);
 
 		/* throttle according to the chosen dtc */
@@ -2705,7 +2705,7 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
 	 * writeback bandwidth is updated once in a while.
 	 */
 	if (time_is_before_jiffies(READ_ONCE(wb->bw_time_stamp) +
-				   BANDWIDTH_INTERVAL))
+				   UPDATE_INTERVAL))
 		wb_update_bandwidth(wb);
 	return ret;
 }
@@ -3057,14 +3057,14 @@ static void wb_inode_writeback_end(struct bdi_writeback *wb)
 	atomic_dec(&wb->writeback_inodes);
 	/*
 	 * Make sure estimate of writeback throughput gets updated after
-	 * writeback completed. We delay the update by BANDWIDTH_INTERVAL
+	 * writeback completed. We delay the update by UPDATE_INTERVAL
 	 * (which is the interval other bandwidth updates use for batching) so
 	 * that if multiple inodes end writeback at a similar time, they get
 	 * batched into one bandwidth update.
 	 */
 	spin_lock_irqsave(&wb->work_lock, flags);
 	if (test_bit(WB_registered, &wb->state))
-		queue_delayed_work(bdi_wq, &wb->bw_dwork, BANDWIDTH_INTERVAL);
+		queue_delayed_work(bdi_wq, &wb->bw_dwork, UPDATE_INTERVAL);
 	spin_unlock_irqrestore(&wb->work_lock, flags);
 }
 
-- 
2.25.1


