Return-Path: <linux-kernel+bounces-423200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B80699DA42D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7893C284D57
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AFC194085;
	Wed, 27 Nov 2024 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaG+uFWb"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A712C19340C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 08:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732697554; cv=none; b=BVGbh1vRlgaWr54dJ9ry4nmczG/e6ilN39bHOOcUWsEdJuxGA6vsknZP93hKFuJ8WnXv8xbrZ/6PVn0m5ELhYuJAta3o346UkC0x1lXytzGTanjN4Hr7/I0IzT04viyizNy69we93nlZuVkawHF9qWVdznlPa5Vvl5vjZy8WzXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732697554; c=relaxed/simple;
	bh=02JUn+UocIGDebOBg43HAGjPIitOi8jA4J/kRnAkAbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y+nZNZc/yrZVSvMjy7fwqsFEmLj1JzC2czb3GcK5Tx0clvP6Kxfvb/aRAhZ/QQEW0EYUXfqgcgDe7a65fUDiFeWvYYW3WNGaXtbdDs4Hy4MLZy+9RAChP3SnGScDVMiY/XfVP/JxvEczHOH8akfPCaeCvMpXZauI5MEjozsAgT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaG+uFWb; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7f8b37edeb7so5654948a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 00:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732697552; x=1733302352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GtxWVprwFSDZdPsXr7xdLKUG1hqK8KBIerN+AEHe+w=;
        b=SaG+uFWbVthGRlaQDdGbWy1re84TMaC3y+6sdp17lhPFY0cmVcYO/n1KwRiNWlMNhW
         nay75Bx7u4z4YIQHTfr4bWguSDDXa0+opFl7ct84fofAMFJXXd5Ury8RFExE/xnnBp9o
         V/QT5nz4lKK4bXe1q9b+XKXLcwZGzMFosttIS45jvqwmyGgdWCI1bvmj7DxD3gQSplu2
         Hr0AjP7kwyerEAiPnyxckwCjlCc+8/PFIbPxX8/fuhrnTr/kGPfgReoPED0Mu/ZHswR9
         mNxEZt/6ny/05x42HAQbeKCtc3fyD4wYU31FLA17R6wlKezI/YvIYV3BnrtTnVP0CjzM
         L5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732697552; x=1733302352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GtxWVprwFSDZdPsXr7xdLKUG1hqK8KBIerN+AEHe+w=;
        b=b/HCpJZRcbMhexKGXfIy94fLUBPQddCnLB/b5npSpylf41AbDzxdTV6jp+GmRMRuc4
         bF1YPMl96yjeNWn9etiP/JHie9GybO9P448c+2d/PUgj3B8p+ZBYyz3ywAAuKAe7Ec/T
         GCzEJb3WHHIJCwQf/oq6U00+urQ6fsi5em/M6ZQIhhpjltHnZ7flg8ajgvqKw5eR1ixC
         eqT99cO0ElTCLfSX7sPuSTe0D67Qc9u8tlx6iN6Ec+mDoBZXkJB8Se3dtG6lINWektuQ
         cYXPuWFHU2GmMzXe2WE8h2l3nVXYNknVLj7il/ulFpN3WnUueenFV6JfrgU+Cu1fEJEY
         m2Gg==
X-Forwarded-Encrypted: i=1; AJvYcCXmYX2Oby417KgDn3cIOsZFffgqT5rlIVBpTreBHQR7lbux3DKA5CkrmWH7abqY1DNAT7fDNHTjgYLRW5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg+ud1EC+7LH1CEOAk54E4Z+n/zQ5+vkN/e8I0NHEtkcFhFyKK
	0KoFsyYlnoQC8YdSKGK6pRbT1dnFDKbDTDXM7eM5CzMR3d8w0l/Q
X-Gm-Gg: ASbGncuFtWBDlUVU6jEdKD89Yeg9Z1XV+gzcXeagwQK+C3s5AvfrFVCYRmSjOyUZzwS
	KwFndH9sPwqLY5Jfb+c0UJ9kXFy9Rso5u+XG/NcroDMIkt/yMy2dpnoy9+NcRa0eIpdg0q3fxyV
	7YLhYKHPf3MZsxtf7JNppTN4wfHNRiFBbDmcA42tZN1VYGfCTT60znUaTgBBda315h8iExYZPwr
	PuLnzZ3lMqUqcChfrD8XrC6AgeK9nCsL3s0gVEuyXU/LAaVXGlWN+Zz6f76/g==
X-Google-Smtp-Source: AGHT+IFWgNHtIL4lvZGnwj9qigjzUulsGL+kOLu8IJhe2WdfqgdGC624KR6Weud4TWGjUNI3BzGSWA==
X-Received: by 2002:a17:90b:4d0d:b0:2ea:a7c7:1b8d with SMTP id 98e67ed59e1d1-2ee08e9f0a5mr3324430a91.1.1732697551857;
        Wed, 27 Nov 2024 00:52:31 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa60091sm960531a91.20.2024.11.27.00.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 00:52:31 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] nvme-tcp: remove nvme_tcp_destroy_io_queues()
Date: Wed, 27 Nov 2024 17:27:51 +0800
Message-Id: <9393a06d3fa651f9e68863b3cb9d952254f65e5a.1732699313.git.chunguang.xu@shopee.com>
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

Now when destroying the IO queue we call nvme_tcp_stop_io_queues() twice,
nvme_tcp_destroy_io_queues() has an unnecessary call. Here we try to remove
nvme_tcp_destroy_io_queues() and merge it into nvme_tcp_teardown_io_queues(),
simplify the code and align with nvme-rdma, make it easy to maintaince.

Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/tcp.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 28c76a3e1bd2..36c7e49af38a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2024,14 +2024,6 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 	return __nvme_tcp_alloc_io_queues(ctrl);
 }
 
-static void nvme_tcp_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
-{
-	nvme_tcp_stop_io_queues(ctrl);
-	if (remove)
-		nvme_remove_io_tag_set(ctrl);
-	nvme_tcp_free_io_queues(ctrl);
-}
-
 static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 {
 	int ret, nr_queues;
@@ -2170,15 +2162,17 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 		bool remove)
 {
-	if (ctrl->queue_count <= 1)
-		return;
-	nvme_quiesce_io_queues(ctrl);
-	nvme_sync_io_queues(ctrl);
-	nvme_tcp_stop_io_queues(ctrl);
-	nvme_cancel_tagset(ctrl);
-	if (remove)
-		nvme_unquiesce_io_queues(ctrl);
-	nvme_tcp_destroy_io_queues(ctrl, remove);
+	if (ctrl->queue_count > 1) {
+		nvme_quiesce_io_queues(ctrl);
+		nvme_sync_io_queues(ctrl);
+		nvme_tcp_stop_io_queues(ctrl);
+		nvme_cancel_tagset(ctrl);
+		if (remove) {
+			nvme_unquiesce_io_queues(ctrl);
+			nvme_remove_io_tag_set(ctrl);
+		}
+		nvme_tcp_free_io_queues(ctrl);
+	}
 }
 
 static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl,
@@ -2267,7 +2261,9 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 		nvme_sync_io_queues(ctrl);
 		nvme_tcp_stop_io_queues(ctrl);
 		nvme_cancel_tagset(ctrl);
-		nvme_tcp_destroy_io_queues(ctrl, new);
+		if (new)
+			nvme_remove_io_tag_set(ctrl);
+		nvme_tcp_free_io_queues(ctrl);
 	}
 destroy_admin:
 	nvme_stop_keep_alive(ctrl);
-- 
2.25.1


