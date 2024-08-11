Return-Path: <linux-kernel+bounces-282203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9976994E0CF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 12:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B2D1C20618
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 10:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C86746B91;
	Sun, 11 Aug 2024 10:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Es5d83oS"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FCF3D982
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723371579; cv=none; b=lDgH6TUhUPWaOYG991Szlq3eOnHigdWjGL7vn6UVMROHynjjDpX8gpryB8oo8cPLeozH695m0+ll6vic9/d7Xtc7TrM5+gGHzhp+E9WIcGc2xZSYdyBBhfFfd+oy04yDiZ7ZnPsK9lJPyuVztvYumfNRxDLzkcseKiV4nFk+2Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723371579; c=relaxed/simple;
	bh=jYIWF+d8RtT7CApAhcVVOIWuKzK336s2dIOxS36Vebo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y9H6JbxYSL04QkXZGVpbflIQjzKcx2GzxEP+NOuxWivQ5aM+XvdSGOmsPnsyx3mnAag+hUewxtD1TCsUiVJo08BcTZJkgVN9Bd0etMYPcY1Wsn9QKcVMx4Do/gn/R3cucs4V9KQ4+ulAYytQuj7RYS1JhWKD+Z1iGd6ZDtaCNGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Es5d83oS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ff4fa918afso20372765ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 03:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723371577; x=1723976377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ds1ze48w37yLgthqPugWbimWqZx+HO9a59JENpUWbI8=;
        b=Es5d83oS7dIE8k3gu8bnmEXEzY0ILq8dlhLPRwcOaE+mZB5NWye0KCTTRJnnhcXSMI
         dGScq+I4CgBBJUGMobo+AaJXidin9E+eotvaSevl+wjFFH4b/INU+Ps6m2uiPljhq0c8
         B/8Xo8HdbK04PVYCPd5UPhJc5lVwgyjAV5tq0Zc2f726EfVygyHCRdWg7zqW1xsmAGdu
         5+6Feo9/D1I7Gwe+w7u9OjNqvotrk3SUuka+wwWlzzfL+BDf/RhvoOWOOcE+byRLyYBI
         f8ANMxKoLAYxCVxWNY0el1OP0rCzAoaYGH15VIPA0+nsR2Y5NxXB/MyxHO/iHyg/RW+8
         LMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723371577; x=1723976377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ds1ze48w37yLgthqPugWbimWqZx+HO9a59JENpUWbI8=;
        b=rDacug2jMj8GXYT0xxfaOy85lfdhvyOAlQxV/WT2JuWxFqxZUCp3oHozETKoD+UvVg
         DpBAfoZMOet13ZoX3EoV2nrX7AAWCy2aS0POBS/fxUEHYcdtYM49yG4N7zkGCnNWwffS
         eMf4vx4uSnF7wWEGuC3jHTpIgQejcSf2QQgu8R27VD78bIJpO6nIzYcO5zppPnlTvDbU
         PP6ugWZfN9X7DeblaYYCM+jZoc4b6SEEXAPJmtGI+aNditZjQD+kbWAmZuCXXZ5qYLil
         DAzXYKbsMyyaKYP0ry4IkTbhm49GKu+YggC2G1Nfa2i/jJ5u/xQcSBPV7KcJDzCodHD8
         5gMg==
X-Forwarded-Encrypted: i=1; AJvYcCVdByEf4tKyBbd4AK3dJwOT7SUeVluifgR7KDToRMeaxlZIP1UYhKXNUO5YHLr+qpskyhvlaVg2dUG4nQY7I9zR3k0dIUAyWd0zOe+q
X-Gm-Message-State: AOJu0YyUGDsxumHG/QEe2buvkOCIELQxyaIkOFBdGrBbnzhb9WxPEIa5
	rJivgYtjwP7EQj0Mh6UaNU0dax1AdRoCx8dZk5uR98HQ4CVFWakGEBpeINP9PKs=
X-Google-Smtp-Source: AGHT+IHrhGO7FADS+Xso42jN4oliqSfyeCN/hga1nn4ByOZpRGS4MDU9GUc15B1hCpOlbLBBamKaog==
X-Received: by 2002:a17:903:41d2:b0:1fa:7e0:d69a with SMTP id d9443c01a7336-200ae5cf5b0mr55765245ad.46.1723371576935;
        Sun, 11 Aug 2024 03:19:36 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bbb48b81sm20992155ad.297.2024.08.11.03.19.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 Aug 2024 03:19:36 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 1/4] block: fix request starvation when queue is stopped or quiesced
Date: Sun, 11 Aug 2024 18:19:18 +0800
Message-Id: <20240811101921.4031-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240811101921.4031-1-songmuchun@bytedance.com>
References: <20240811101921.4031-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Supposing the following scenario with a virtio_blk driver.

CPU0                                    CPU1                                    CPU2

blk_mq_try_issue_directly()
    __blk_mq_issue_directly()
        q->mq_ops->queue_rq()
            virtio_queue_rq()
                blk_mq_stop_hw_queue()
                                        blk_mq_try_issue_directly()             virtblk_done()
                                            if (blk_mq_hctx_stopped())
    blk_mq_request_bypass_insert()                                                  blk_mq_start_stopped_hw_queue()
    blk_mq_run_hw_queue()                                                               blk_mq_run_hw_queue()
                                                blk_mq_insert_request()
                                                return // Who is responsible for dispatching this IO request?

After CPU0 has marked the queue as stopped, CPU1 will see the queue is stopped.
But before CPU1 puts the request on the dispatch list, CPU2 receives the interrupt
of completion of request, so it will run the hardware queue and marks the queue
as non-stopped. Meanwhile, CPU1 also runs the same hardware queue. After both CPU1
and CPU2 complete blk_mq_run_hw_queue(), CPU1 just puts the request to the same
hardware queue and returns. Seems it misses dispatching a request. Fix it by
running the hardware queue explicitly. I think blk_mq_request_issue_directly()
should handle a similar problem.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 block/blk-mq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e3c3c0c21b553..b2d0f22de0c7f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2619,6 +2619,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 
 	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(rq->q)) {
 		blk_mq_insert_request(rq, 0);
+		blk_mq_run_hw_queue(hctx, false);
 		return;
 	}
 
@@ -2649,6 +2650,7 @@ static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 
 	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(rq->q)) {
 		blk_mq_insert_request(rq, 0);
+		blk_mq_run_hw_queue(hctx, false);
 		return BLK_STS_OK;
 	}
 
-- 
2.20.1


