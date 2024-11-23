Return-Path: <linux-kernel+bounces-419071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCEC9D6928
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 14:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E29CEB21AA7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 13:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F13E19DF45;
	Sat, 23 Nov 2024 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JupIKjXk"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C05719340F
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 13:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732366932; cv=none; b=rYyqzUZJ897eRoH1eJfVlqa0KPraxE1jV2JSTyygcx5Q7JBcJfiCQsyy/E7gAOsZoOW3Ss4ohqozsA/GHXOdx3ZbcPkmOWojVw6aNgq68DJNcJsfDpOHkEDCtxrQJicPpl+Wp4EyaV2kXdb1rpgMz/oaLMsNHV0nVgHk6fV5Btw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732366932; c=relaxed/simple;
	bh=paxDOqh2qSf2kzQc5voZMVG473IaskEVDZOMOwSPc2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D2QqTyI6fYyPa3AucX7sK9EW/K+AZ+PVgkwv2uH+pg5Xw2ZZojLS2KmjEisbxKlS3EasP0uHz5iDfq6rhtzSDdqvXr1Sd9BuP8QMsOy2DOdmcDg2I7C+YS2yoUUdlHESkVYix84DOPEO4AWFRWO8PhI3qzwq8+zekAWe26GLJDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JupIKjXk; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7f71f2b136eso2506977a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 05:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732366930; x=1732971730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpmERBoqTwRUxsoOOwQBdGMoKAty6EzjZaeUApmpNRM=;
        b=JupIKjXkAvFNU6mQUgUocaPFeFxyi4YCh59VEwE4WpjPT36EJDYMDzlhVWZXcnFR2/
         mlFALkmSaPWvPOyEmNJRL2vkboAgfqcKLS+ki2KZMqN9wOrjvTCeWuz/vgVKm2cz4SAt
         AuXYcwT2JuqtXUzLQsG8nb1yMPX+oq23HdITht/c5SwbyvFK44XaU6i7bA61c5arwwEU
         MM+BpKoAPSNPojHFYHZscGQVMEq+6mQnn79+M8BCNxtKd9UAMW6HbWVoIzzeg8vHHnvR
         4lRPmuE5g6DafCVKJFGrGFIdvGI+fVHfvyj2Q2WqMzBalQOtsSWjhMnka0no2PAJBZpG
         9UZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732366930; x=1732971730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpmERBoqTwRUxsoOOwQBdGMoKAty6EzjZaeUApmpNRM=;
        b=de9WTG1aouTCcM2Ig/FHY38kvE/q5y4IbZkBAVOdmmmxZgPGOQNWbgT5kTmlRCaJOh
         ZvkN1cCip/syKnl4M0tzefB1wL34lE2EJS1E50UWG+A9qeLhhl+7SSPBs250xXCB4XAW
         RGFzz7upvqTMxzn0drEeqwJm7XV51Ho0djtcpUFESNfQNQZwi5b0Z6mVoTdRzSTFS9Zd
         saGNnwIjRFCIaPEhjiaGnjDDQtqZkIP7r0GrhDN4y4mlNA89KCPi8iRy3bfqzS15yIUL
         UzzUTtOHc71+mJfwgsm8uH9PwYMrs3nnjrOcpW3VI8gfNKgOSPZD4KChZ0QjN0KozSnH
         Z8kQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+sHwKjQtRhfwNEW/vvHD7sSDfDDHh+HUpyeKH7JfG12fyhxCAxVV35SxAdoU11QTGIu3i4m/Qvlr5VIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyapGUJmfoR9yPbxvDr8xdvGQgYiYqdcbwlAqKNFsgd341GUxR9
	4lSt0RdwR4WWk+UklaB746q2jcqPu59p3QHGS3ZwXlJGo8AofCCd
X-Gm-Gg: ASbGnct/1X6ElDM2Jc+UYSD3bbFhTJQaVCOqmp9GwKvSnaIMt7shx8p/amcP1SNisp7
	gR3LYjNgCOgur3pg2B1+b96UCSgAIcaBG0lYz+9yiYMmGlX5xCOjO5uqM+gcxKl8snd73iT+Gre
	pvvlHsVwiGdhLzZyab7yo3LSk81Fbe8nHCCznM0EJ0o1/DobPjiiGsd/1IbSzCcX8zjSGO8wrJl
	9fJupaCyMThtRgYcN0FF2fK49SVFDL6WxDXJsUCWL2vzeoqcMu5ujU2QPw9gQ==
X-Google-Smtp-Source: AGHT+IHN1KnxNuN0h9IWrcLc767Cg28zWfmxg2oWBIUrJnGOr+F9L16qXfjIjHvwcl/xeP3fhKiWJg==
X-Received: by 2002:a17:90b:224a:b0:2ea:aa56:4b0 with SMTP id 98e67ed59e1d1-2eb0e1269eemr8048875a91.3.1732366930176;
        Sat, 23 Nov 2024 05:02:10 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0cff8fe8sm3295226a91.14.2024.11.23.05.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 05:02:09 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] nvme-rdma: unquiesce admin_q before destroy it
Date: Sat, 23 Nov 2024 21:37:37 +0800
Message-Id: <9379940137a8dfddb451917c1d069eebaf3c209e.1732368538.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1732368538.git.chunguang.xu@shopee.com>
References: <cover.1732368538.git.chunguang.xu@shopee.com>
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


