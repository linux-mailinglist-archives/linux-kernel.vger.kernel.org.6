Return-Path: <linux-kernel+bounces-423197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7C89DA429
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33E8EB223E2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D44192593;
	Wed, 27 Nov 2024 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7vQnfcG"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E696B1917F0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732697546; cv=none; b=EDUtx6R/zauu+rtbLyI90V3YotH5JjQhUCPIRhUkYDxwd3r+wm4sVVDs1KXQOrcssHLRyS4YUl+4QnghL4mtEBVaOmZibBMTn4jHuwY7d+XcFBo8Q57QKQkHiXEx59GYDzkCFGNcUdp4ASacHJOij8jXEnDH1pQsR+HnGVkjZJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732697546; c=relaxed/simple;
	bh=paxDOqh2qSf2kzQc5voZMVG473IaskEVDZOMOwSPc2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f3bpP4QsT8U4tcteW+lgLMbRb7Qs4DNEuYj8aXMGIXONLEa965f+XInxM8bf96eyC9ekEud8JvTExqjGCYQcaiJEX96mv2+3ow6coy8kBkgytfmS4Ap3zVY5R8+9oeF92S1XPqzzwwWdi6hyMFhXvvsTpz7+625FHLhR6X0Xuxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7vQnfcG; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fc2dbee20fso2559655a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 00:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732697544; x=1733302344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpmERBoqTwRUxsoOOwQBdGMoKAty6EzjZaeUApmpNRM=;
        b=L7vQnfcGWZUO7HUn/Ypxl1LEJ8tTVDd6jXXePCVth3KfbI5svKPiCTONHNXUiLSd2D
         q2fFlJCW8wic+dsP+WY26yT06vt2i5VdA9BahGATrEdTre1Nj3vXridN1FbZm1Z6EQ3Q
         hUadTF5lTMgHk3Usn3xm4TaFtgJY1sb0dfrHVIFs/VUGGRac0TVw/KYd7rRx97LzBoMM
         hFqQ0x+BF8w8vNX7Iqx4VlAp262A6hiWgTBI5DcXJT2O43M+ADcgML4eHA7qQum04UwV
         4JPXKFVyG78Zzrt5TvB2vwWwnFdGIM1SAVs0Kq4z/dZnG7KZISRS+UhnpBxGE9xrvBk6
         Uilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732697544; x=1733302344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpmERBoqTwRUxsoOOwQBdGMoKAty6EzjZaeUApmpNRM=;
        b=tNN7uKEfIYFOxJJVMpbO5uKg6JxSU9t3MfWK9mAqtfuz55C1U3Ke29MPdD27OfZluR
         /RYFmhEcRboOS1HKQ+uHOkx/EbDRw6FFecF8iG461BpNVPQPboIUy19CVI9vJbwij3KN
         n7BGpD8J8zkS7tWEPrf+XMWHlCg4InALmLjAPsTG80ZgT7pN0M9qiEpp2AR2i7Ksw3qx
         swohLP2XRwP8J5WofHzE3edsx1M5C0tAJQD17o088qh46sdN4oMk9mNvKjVKEZh/auRS
         jVAQpiRFaUenD1Xbexv54S5CfXkj4MC3ufCwsEQIqBqNhxoU7vaYe2xaL+VeDWMdkSv2
         cZdg==
X-Forwarded-Encrypted: i=1; AJvYcCUAsGozuSbNJ7/CNJSGG48gGObiyKECcUNtTH4lVS/UD8sln6F6ztdYcwBgXmIM7r8yYqJsoMF3Ew8t5iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuOo3XJrlvi3ALjopFk9tGF9uAvqoj3BXJPyFeXWVmj8p5InFi
	HBhhDfwufSKqUFdnXGXADLPQRBRI0DFaPDZvsI/IvhvlytlpX7Z0
X-Gm-Gg: ASbGncufOFXfO1UmCMM797+9r7EZ7Q3w5OX2FyDTy5yattl28n/CjjeFU6jxjd/UrXR
	LPopM1CqyMDbJa94sjiA+KLZ27eF3dXeNMZawq4on1QZ1Ly038WnTKqqPi4TkN1k1FC1+DLhj1J
	GJNpRGkZA2DnHT4qTC2dpUCcTUwYnSY8jucDVsuYyE6ZzB+zC72DyrlRNB+NxIdflBlgqikZ4aO
	KNowtGzGjHkQVoI8Rq7quOEHAJWX1XdzfJENS7GzSer8Vg7Ov5bJRWLvagcZA==
X-Google-Smtp-Source: AGHT+IF/cp5rzTT3tE1mP8JhClMCc7LgiUCv5UBMIenswP4dQfK1tVc737MNwzcTj7GoQFR/nN2XrQ==
X-Received: by 2002:a05:6a21:78b:b0:1d9:6a6b:faf4 with SMTP id adf61e73a8af0-1e0e0b2c903mr3625688637.15.1732697544232;
        Wed, 27 Nov 2024 00:52:24 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa60091sm960531a91.20.2024.11.27.00.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 00:52:23 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] nvme-rdma: unquiesce admin_q before destroy it
Date: Wed, 27 Nov 2024 17:27:48 +0800
Message-Id: <1be6b47b5d05975d7ac7ffbc20257c283b179491.1732699313.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1732699313.git.chunguang.xu@shopee.com>
References: <cover.1732699313.git.chunguang.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Chunguang.xu" <chunguang.xu@shopee.com>

Kernel will hang on destroy admin_q while we create ctrl failed, such
as following calltrace:

PID: 23644    TASK: ff2d52b40f439fc0  CPU: 2    COMMAND: "nvme"
 #0 [ff61d23de260fb78] __schedule at ffffffff8323bc15
 #1 [ff61d23de260fc08] schedule at ffffffff8323c014
 #2 [ff61d23de260fc28] blk_mq_freeze_queue_wait at ffffffff82a3dba1
 #3 [ff61d23de260fc78] blk_freeze_queue at ffffffff82a4113a
 #4 [ff61d23de260fc90] blk_cleanup_queue at ffffffff82a33006
 #5 [ff61d23de260fcb0] nvme_rdma_destroy_admin_queue at ffffffffc12686ce [nvme_rdma]
 #6 [ff61d23de260fcc8] nvme_rdma_setup_ctrl at ffffffffc1268ced [nvme_rdma]
 #7 [ff61d23de260fd28] nvme_rdma_create_ctrl at ffffffffc126919b [nvme_rdma]
 #8 [ff61d23de260fd68] nvmf_dev_write at ffffffffc024f362 [nvme_fabrics]
 #9 [ff61d23de260fe38] vfs_write at ffffffff827d5f25
    RIP: 00007fda7891d574  RSP: 00007ffe2ef06958  RFLAGS: 00000202
    RAX: ffffffffffffffda  RBX: 000055e8122a4d90  RCX: 00007fda7891d574
    RDX: 000000000000012b  RSI: 000055e8122a4d90  RDI: 0000000000000004
    RBP: 00007ffe2ef079c0   R8: 000000000000012b   R9: 000055e8122a4d90
    R10: 0000000000000000  R11: 0000000000000202  R12: 0000000000000004
    R13: 000055e8122923c0  R14: 000000000000012b  R15: 00007fda78a54500
    ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b

This due to we have quiesced admi_q before cancel requests, but forgot
to unquiesce before destroy it, as a result we fail to drain the
pending requests, and hang on blk_mq_freeze_queue_wait() forever. Here
try to reuse nvme_rdma_teardown_admin_queue() to fix this issue and
simplify the code.

Reported-by: Yingfu.zhou <yingfu.zhou@shopee.com>
Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
Signed-off-by: Yue.zhao <yue.zhao@shopee.com>
---
 drivers/nvme/host/rdma.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 24a2759798d0..913e6e5a8070 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1091,13 +1091,7 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 	}
 destroy_admin:
 	nvme_stop_keep_alive(&ctrl->ctrl);
-	nvme_quiesce_admin_queue(&ctrl->ctrl);
-	blk_sync_queue(ctrl->ctrl.admin_q);
-	nvme_rdma_stop_queue(&ctrl->queues[0]);
-	nvme_cancel_admin_tagset(&ctrl->ctrl);
-	if (new)
-		nvme_remove_admin_tag_set(&ctrl->ctrl);
-	nvme_rdma_destroy_admin_queue(ctrl);
+	nvme_rdma_teardown_admin_queue(ctrl, new);
 	return ret;
 }
 
-- 
2.25.1


