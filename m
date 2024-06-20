Return-Path: <linux-kernel+bounces-223252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A001911036
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEF941F21A89
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E221BA899;
	Thu, 20 Jun 2024 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gj9vD1Sj"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C961D0F4F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906340; cv=none; b=F+sBc1IgvCMq1I5/c8muZJzUQZZy8uHxkdeeZY6tLaRRFOFglPEXWsbKqztfpt42eVrZsUGrXiYpQ4dpFIG3f3ZYdQECmsAL0AATNVoyn2M6aylAjVHrxenejFMjiojboKUAI5ssO93FKs0wjoBWcrQB8w0hr1K/QdJ1lyU4Kbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906340; c=relaxed/simple;
	bh=43PCcVjF9LLFxFCfleFm+1u6w23B3SV5aS208ZW0XBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBIEhJDguYFnWdclQdavgyaCwypCtapKBi83oz3Z6Ls/bkMBGiZp53hJgxFdSR/r3gaxxpGHLxZwL1Zo+VOW0ppYfYGYA2Yv0R0f6gsPXVER4VgZyP7SIUIkIJJdcqWP8b4QaCaIhe8HaZbrtf8sMe2G/yy10icqZOIxIKj6wlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gj9vD1Sj; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-6eab07ae82bso830769a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 10:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906339; x=1719511139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ipwGbR+ze0Ay3Tr6YsAi2mpOH1rdNvZeMvAJD4j/30=;
        b=Gj9vD1SjxHxZ+TirGvC0rVtBrKM6JbbeWL69QgCnI6sW8p6uEwo5tWtu4UmoHWeeI7
         EE7Kn34oVvKwx3OZ47TTv4Poc/P4dCgzZLpKuPmWBGer3UG1t8iGgPOWPaphUou/o1jx
         ouD1zbpmS3PG7CawAmLx/LvE67yoEhgCb+xfr3RRNgKJjB70IPRnaUpN+aIwUU7RBtJe
         C63Nt+nIg8Acm5uvUOE5fOa8FW+o11L/OI3xe2sO66lU5j8nAL9ZN8KUDFpMwCeYNY0S
         L3G6r61YO/n85ifEnOu8PEbS/c/rWy7O7AreCWY+HdTObOSZQB+NGogUTGO5S5OESsBL
         8VDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906339; x=1719511139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ipwGbR+ze0Ay3Tr6YsAi2mpOH1rdNvZeMvAJD4j/30=;
        b=DWw3kXrvE5G7fjVUBK/LQs057Nh1kN388cDkPonMM489Xul5oicfQdEzwNRtMUrGQ1
         /hmUyHHMrSvoAo9EMNEYNf+J9+XPUHdJvy1gc0adhqEQ/JmQ4/efLOQxbhLPWUyOQVo8
         XbJAdITbp2mi2pb5Fx+MpQM3P1rajwsKsX4RQAuTRzCGYVYHYs2JbbPSfQ6Vrdck3nGL
         rdp0EmBMI7lkMaWmtWArQvI7Ubahl7UVCAPIudNLUEnOiCO/hj9UErYFoR75T0kyMPvb
         T0bachnOiwGosXoQK/JINk4P5reYtN1P0ax+NRgI5N1MrO8vRQkdWoNJEA6jAJN357Mg
         JTnA==
X-Gm-Message-State: AOJu0Yx54c0uAlP1E80Ie+iofd2aKHUSxsG4T5a+mzhC1GVl87UxmHQ2
	hnquTyhqrgCeJyE+p/iiQ6FJkpHOblR9qQHzMXp1w0KiXBdx1pjspBcMZYK3DVw=
X-Google-Smtp-Source: AGHT+IEfVgCYhizW2aBSpfFWamrwpAlGma5UzQVQzhVAXMNPxrw0Ml+8Pulc0jdTKXgia5DGvnGynA==
X-Received: by 2002:a17:90b:e89:b0:2c7:b17c:dfc3 with SMTP id 98e67ed59e1d1-2c7b5b569aemr5726138a91.15.1718906338696;
        Thu, 20 Jun 2024 10:58:58 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e55e1846sm2010484a91.28.2024.06.20.10.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:58:58 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Jassi Brar <jassisinghbrar@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v4 39/40] mailbox: bcm-flexrm: simplify locking scheme
Date: Thu, 20 Jun 2024 10:57:02 -0700
Message-ID: <20240620175703.605111-40-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620175703.605111-1-yury.norov@gmail.com>
References: <20240620175703.605111-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use atomic find_and_set_bit() and drop locking around
ring->requests_bmap.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/mailbox/bcm-flexrm-mailbox.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index b1abc2a0c971..7aca533a1068 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -23,6 +23,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
 #include <linux/err.h>
+#include <linux/find_atomic.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mailbox_controller.h>
@@ -989,21 +990,17 @@ static int flexrm_new_request(struct flexrm_ring *ring,
 	msg->error = 0;
 
 	/* If no requests possible then save data pointer and goto done. */
-	spin_lock_irqsave(&ring->lock, flags);
-	reqid = bitmap_find_free_region(ring->requests_bmap,
-					RING_MAX_REQ_COUNT, 0);
-	spin_unlock_irqrestore(&ring->lock, flags);
-	if (reqid < 0)
+	reqid = find_and_set_bit(ring->requests_bmap, RING_MAX_REQ_COUNT);
+	if (reqid >= RING_MAX_REQ_COUNT)
 		return -ENOSPC;
+
 	ring->requests[reqid] = msg;
 
 	/* Do DMA mappings for the message */
 	ret = flexrm_dma_map(ring->mbox->dev, msg);
 	if (ret < 0) {
 		ring->requests[reqid] = NULL;
-		spin_lock_irqsave(&ring->lock, flags);
-		bitmap_release_region(ring->requests_bmap, reqid, 0);
-		spin_unlock_irqrestore(&ring->lock, flags);
+		clear_bit(reqid, ring->requests_bmap);
 		return ret;
 	}
 
@@ -1063,9 +1060,7 @@ static int flexrm_new_request(struct flexrm_ring *ring,
 	if (exit_cleanup) {
 		flexrm_dma_unmap(ring->mbox->dev, msg);
 		ring->requests[reqid] = NULL;
-		spin_lock_irqsave(&ring->lock, flags);
-		bitmap_release_region(ring->requests_bmap, reqid, 0);
-		spin_unlock_irqrestore(&ring->lock, flags);
+		clear_bit(reqid, ring->requests_bmap);
 	}
 
 	return ret;
@@ -1130,9 +1125,7 @@ static int flexrm_process_completions(struct flexrm_ring *ring)
 
 		/* Release reqid for recycling */
 		ring->requests[reqid] = NULL;
-		spin_lock_irqsave(&ring->lock, flags);
-		bitmap_release_region(ring->requests_bmap, reqid, 0);
-		spin_unlock_irqrestore(&ring->lock, flags);
+		clear_bit(reqid, ring->requests_bmap);
 
 		/* Unmap DMA mappings */
 		flexrm_dma_unmap(ring->mbox->dev, msg);
-- 
2.43.0


