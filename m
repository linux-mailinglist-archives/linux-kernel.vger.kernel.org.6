Return-Path: <linux-kernel+bounces-428654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A87F9E11DA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 04:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 823FEB22FB6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69402905;
	Tue,  3 Dec 2024 03:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2RIWTeY"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B2C17BB1C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 03:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733196895; cv=none; b=Ut7rTlxU27CQR1XrneDTPEArqDcUSjpuOW2QFB3OjI+Qi3LN2zTI4SAJ3EUgP8RUSIRU8pQpXBN083QdkXP+92Qxtr/+xmZgt28mYqcQPqDb4aid/3GhcCGahPIcJJEV3zWGAtYcbSGaJnF3JGSIEBpDi77QnxTX6tAwTs/P9C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733196895; c=relaxed/simple;
	bh=CUhS4LCnPr4917pX7wfMGN/U4666R2kGGQUuNdvs5Fg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eJFtd5SJAA43WsLK9SeyRRqCfg8/Mfd1r9ssGA7+eyFRues3ccC0XjBBsul2OKM9Pp6HQK3+6nIPrrZwL2sIFd84L2u1btum3DDYXA7QZyMctPzmfHbbGlW5Ax1cVtKpuEi5BTKve4rvj29EfVf3uKM5aWG4l/YDMhbnr7E3nLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2RIWTeY; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fbce800ee5so4978111a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 19:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733196893; x=1733801693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmxvTcrzfwp5mh+amZ33Odw2AKzrv2TrqCm0sLIaCwc=;
        b=T2RIWTeYFrgh3/PcXfMjZTIorSW87xwhgniLurZ99rW9JImdWCsy/DdgjyF1vLXk6u
         INw9xN8ZTT21nhfxxWzR+6wkL1xfgrUMfrK0UB7TmLjTlXj7J1kYHJS3AIocrweogyph
         mSiFCsmoiFXJwh8NmEsSvbp4Wbx6sRarpVqxb7z85/Pp6K7tX/VlOnUGMbymz/NV3RyW
         PK888UovP18EaXmPXmVpaa2F3MTekQt9Smxu59A/9blSZSBrwWX7Y/iyQ0JluAsRN/z7
         bhUtKmRowJPhJ7t3nJr4q3ptuWqK6gZGRj6oOFlRLMiFDtTHl1/oQ+CfrFD5A67ZPkxd
         8rsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733196893; x=1733801693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XmxvTcrzfwp5mh+amZ33Odw2AKzrv2TrqCm0sLIaCwc=;
        b=GtIqWw7a2XgeJag9uc0AgXKK8ODJeA64wBBSF6Cz0eRXtpAFtGbjPgl/FNy3/DAbyd
         Y2FRVboasJQ6BJSuh4lPC4pEAeFj88sla05W+WewLXBEyqtNGfKkRv23vjslIEW/0ZXB
         QqQhLqe1EovVVP76i2rKToKcOF+ytVwubRC9HbUfP+1xzTzB9N0jCJPsR/7OCmxVK6HZ
         juOIvKucv0Ov0hbDOh2UbN4eF480bSFDpgyKNJ+ZUeLEDEEtpbcW5WK+TxyEGT/tdBTh
         psQjRWeWh/our2AKT5KRdfEIE1uFpAIkjbvuFXFH3SLixhQpYyHZG+pjmDjjhg0J3i9P
         sWmA==
X-Forwarded-Encrypted: i=1; AJvYcCWN7XQN+qV/gUybThtFbLGgyKqfd3yb4Mkq4eb+tHLj8wuueNJZW9ILhoOvKlpZW4wr4TmuBLXBBDV/g0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO53/EiSmYK4fmmP7FAT6RU+Uc+52FRPaDvbtQmT6cYViRFzRJ
	7uIWQ1jiZ/h4FISUouG9YnsSu4KElvmT7i5c+Nexyh7vhbLsdBd8
X-Gm-Gg: ASbGnctV41V9sfJX73fE/bAl3hiJjM6ulOqjpjMcYCieVGtl82/ub9JcwB+2DIGR8gn
	dRzTBXhr8BoLqUuZcDlcsfw7IDhc93n4UY44RXIBqW6565CmblYAbnRm1A8wLBqUuAmgBB+AWAX
	38X95gNTc14MogVsc20BlDBTYB3adMM0Kv0iIXSUF/a9eJHjZrTkXY9Hzq22pNyF9ZZOyhiYIyS
	bzDhULR7UDz1fb5RHzl3C7TIPN5NOYzYMRSyH0qG82PCDTOvh/8vf0kzjE+PQ==
X-Google-Smtp-Source: AGHT+IFm0LGFirXaTvKZaSoFvKfpRDLZlmiFQ/VjBQ22pAFs7108tr2ExxyERlRXw4lHHOX4mkDyBg==
X-Received: by 2002:a05:6a20:6a28:b0:1db:f01a:cf12 with SMTP id adf61e73a8af0-1e1653f28e6mr1801738637.34.1733196893014;
        Mon, 02 Dec 2024 19:34:53 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215a17a7be1sm20749645ad.255.2024.12.02.19.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 19:34:52 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: hare@suse.de,
	lengchao@huawei.com
Subject: [PATCH v3 2/4] nvme-rdma: unquiesce admin_q before destroy it
Date: Tue,  3 Dec 2024 11:34:41 +0800
Message-Id: <4ba9a8547c5cce3ee358e26890e16edbba94f789.1733196360.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1733196360.git.chunguang.xu@shopee.com>
References: <cover.1733196360.git.chunguang.xu@shopee.com>
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
 #5 [ff61d23de260fcb0] nvme_rdma_destroy_admin_queue at ffffffffc12686ce
 #6 [ff61d23de260fcc8] nvme_rdma_setup_ctrl at ffffffffc1268ced
 #7 [ff61d23de260fd28] nvme_rdma_create_ctrl at ffffffffc126919b
 #8 [ff61d23de260fd68] nvmf_dev_write at ffffffffc024f362
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

Fixes: 958dc1d32c80 ("nvme-rdma: add clean action for failed reconnection")
Reported-by: Yingfu.zhou <yingfu.zhou@shopee.com>
Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
Signed-off-by: Yue.zhao <yue.zhao@shopee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/rdma.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index baf7d2490152..86a2891d9bcc 100644
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


