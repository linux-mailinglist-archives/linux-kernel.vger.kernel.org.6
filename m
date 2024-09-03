Return-Path: <linux-kernel+bounces-312449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D28389696C4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8F5283A64
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C3421019F;
	Tue,  3 Sep 2024 08:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XN9Jxqps"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AE4205E10
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725351435; cv=none; b=u6Y238nO0fGSmlLocU6MfHuWBWo2745dSbKX6VVQmjOQ5O0a6NgVz6Ue4C69Q/0YtWG7lxIJ+bBak3WBXoOASL/BloTefa5BrBvW5cURmP7TiCamMYt1uHfLe6iirltGNkqP4IK+i9bWWN68oXQZZcLQlwbzv0NKAaD59wM5yHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725351435; c=relaxed/simple;
	bh=SDvrf8Qpiz7hwXgQkgMbvx6pHfwmjuJf1BI3qF5qsUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PtPXEXR6esj1+xuSixLrwrdPLRC7v6t7O+YmtF8R9HffPh0p/qxrVre+nyZUbDUjeiPYZmhQSeeGTo8q5TC5h4D7c+RMvfxNX5AQWs2z3azy+TEABP6fGdeTjxiGmEnbZ+JLpcchpy4Fey4xs1dRoIqBM63KXyhyAr+gtL63jI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XN9Jxqps; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20688fbaeafso8382755ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 01:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725351432; x=1725956232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibW+O9NpvNOI9jTnJvwxWKx05ZtMP1ehfDgoD0Cwn/o=;
        b=XN9Jxqps54SlOFrHvi6vO+cbKpfK3kPweI6WP6vaDsWZSIFMh+7VsAHJGJYxcMKf97
         2N/z8vP67KV5V6Q5CQn14BWkYGyVreexvTSgms5H52L96pvfEik9tdnq7Xpi58Rvvv8y
         tSAnBPGjEf7f3NGf30cEyvGrdf75SxS1V6d7pxDbx75SL5tEyUp7LYdxWzS9/eXBDcHo
         YLgosILWZaIPKiic/3n8VF1RIL8IiizgViTtkWKuid8WldJYFeCoE7r7z8nZxrkeiPF5
         Ct3QVu5mk52F6egzD1WJHFDYORDJ3G8ZFMH+UukSZmncN1//o6aVsmFdicgkWcGL94MG
         /yEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725351432; x=1725956232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibW+O9NpvNOI9jTnJvwxWKx05ZtMP1ehfDgoD0Cwn/o=;
        b=ohLN2oKBS4+5wNTL16cjT/+jVe6g/F2Dxzh80Kd4c5yMnKD1vRpmMkAEL+g2Nlp+BK
         oweI1o+fGFlg49vjv3grOpO3RteftkENgJ9RjdKQbTsPXqKWOh21JbTMJXyzY9S4WERo
         E122+oORC+O8tgSP6K9wZhH3kk0B0/hrtfBPyU5OcxknnlYs784ZezaSi2JDraX4KmsG
         98hvRLuitZV0v3hurlB6Zv6JtEhy8HjMjBILTWPSNS8OcgE5bGWvhG2etboflELIwefq
         emQMZwvQcdykpbZ+8sAk1p3rcDtnSOTldhhd3NKh/xoTZUP3LI027KUg5x3KC9Zebe/J
         9QUA==
X-Forwarded-Encrypted: i=1; AJvYcCUmLOJDxK1XguhwoHadGTjNjsO4ew1sidJSHjHLLLn6hg62SYS6VmmvO+vQTBp618j0lim7UT0NRmdZHLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVZoVJ/YyTAEkeWX+Vo3bTu7h4WVBqpL5HYQU9HrMPqrTCVhjy
	0l8+cZl+TXonmzOJs3v8idJ+geeT+CYrxji4krHda7RO7OerZgHuCvQ3/Ddr/zY=
X-Google-Smtp-Source: AGHT+IH8T062SK2gcp022LHlt/cN78AcsQ9Ou2pVs6Q14mJRrrNfE/3voyxn4xjoc1ocTKZsy05PnQ==
X-Received: by 2002:a17:903:26c5:b0:202:4666:f018 with SMTP id d9443c01a7336-20584193b42mr34059395ad.15.1725351432090;
        Tue, 03 Sep 2024 01:17:12 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20559cae667sm38155435ad.95.2024.09.03.01.17.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Sep 2024 01:17:11 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: axboe@kernel.dk,
	ming.lei@redhat.com,
	yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] block: fix missing dispatching request when queue is started or unquiesced
Date: Tue,  3 Sep 2024 16:16:51 +0800
Message-Id: <20240903081653.65613-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240903081653.65613-1-songmuchun@bytedance.com>
References: <20240903081653.65613-1-songmuchun@bytedance.com>
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
hardware queue and returns. It misses dispatching a request. Fix it by running
the hardware queue explicitly. And blk_mq_request_issue_directly() should handle
a similar situation. Fix it as well.

Fixes: d964f04a8fde8 ("blk-mq: fix direct issue")
Cc: stable@vger.kernel.org
Cc: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
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


