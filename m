Return-Path: <linux-kernel+bounces-410337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B91599CDA18
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9471F22005
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E819D174EE4;
	Fri, 15 Nov 2024 07:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQSjXqZX"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B7C288DA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731657220; cv=none; b=eZWf+dqJ+YCbWnuvbg7tgFvn+4uFBYJfzsld13TYZo/ZCIG51O2W9XxPKrLeX2GdLTQXDIJgOW+q7La6+d5u84KPv3oDOfNSjKmamRf8UU2spkxMZPhGHqoMJI6vihPI/HNL69CSzVNWD1ExKGmYm+X6c+c+AQfw1Am/myyW76I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731657220; c=relaxed/simple;
	bh=zXTOAVa/V9gsf4O3NXtmjVCo4do0tKaveeiBZFbX0xs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rdWFAiR2ySSTJa9nhad/G1I2UvMu1NrPPtp5qzYfmo6gAll9Yt8XvDSjKa0nQtHkoMthhbkbowrkfAZw6jxooYiTXhHoXJhb7lDdcMWpuI/wiAWvEiV1HSfBfIahNEJzGnaaVe9tx1HXc23OYpPdcc/P/tISdAWtUkXCltj1LNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQSjXqZX; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ee020ec76dso1102209a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 23:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731657218; x=1732262018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p99ODvIJPrktbcv8eF11YBYTGZSaidlg1QybrmKvuyQ=;
        b=KQSjXqZXuITHhO9uSQXi61j/fTyvF9Z4kPnpnDHSoAjMHPPCwp5pSnilcWrtSraNw0
         gQcRAN8q85+RNdHZSGSkOKSZlVP3SjdO8Br+gGnkB0ECVjxd2O/W0IFUOQzKIhOUrs+U
         H6+jrkr23GTlBBDsytjOI0v9dKzZlXlukAKfukEmjStgV4aqSBLQ2hsi1dzqGIg+F77U
         J/a4kbkY+lJQbc2GzGVuFLF/bfdTUjozwC28WvM3gVlCcqbh3EC7tiYcYpSJ4ojH6ZOZ
         qoclKIJyYZUZGfNOPMIE94IQ6kTWgOV93z8oN+rOg7Pjp7pEIMxLdSzf5pfG/bQhsJxg
         p7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731657218; x=1732262018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p99ODvIJPrktbcv8eF11YBYTGZSaidlg1QybrmKvuyQ=;
        b=Y6Oa4YP1LfYDmB0gV6VHPmTw5FvJYNdrnQ0oPDptHEM23JwQAMkf4fT7zzAEbCQoOS
         7GzmdqKhtBXJdKp5PeMf9oAFGiru9WevdwdLwEQH64YitEivAeyCAApm3SFitPndxLqX
         adGqLrGz1P6fAGl+MJKI4UfF7/QgCL5LEIwdjYUh7BkbnNhRq/8EGqOINt5tH4D8qBAj
         R8q7wmZ0podBfC3YmvoMiicZ8bwdFguga2ePrFZ7ljs+LWq8/ugztTQOiuMlpCcF9G/0
         Jkgk+DQ8IQzhA7hSueXPPY90zQVdxRKkVAxJJkoVDBpgh1+9GO3OAJTMA03BOKHOFDuA
         4A3g==
X-Forwarded-Encrypted: i=1; AJvYcCX7mnWdc5FBUXjpflsPUUjfBKpqSflMvzPXfYE6vr2ypfsN0nCBTHKAsSOWzEFGrhyA98nmnP2Ps8clTbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMdeNzf5Rl3EI0b91/IavkrTSfVcFv/NXGHaKQ+jnJyWapvX18
	P2XQCSAOm5W1VZg7fZOjsTeWRHsokeMhwHaBGCl0qXRGDiindLx9
X-Google-Smtp-Source: AGHT+IFCNHN4gZOTQPJBOR8vXGarFpDWwt0EKC2lT0y1pesBteQ3zcoQe0k3zXMAysbZymytCRDFrw==
X-Received: by 2002:a05:6a20:7484:b0:1d9:c753:6bad with SMTP id adf61e73a8af0-1dc90b1c045mr2236352637.10.1731657217960;
        Thu, 14 Nov 2024 23:53:37 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771e1fdbsm773825b3a.154.2024.11.14.23.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 23:53:37 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-core: auto add the new ns while UUID changed
Date: Fri, 15 Nov 2024 16:29:15 +0800
Message-Id: <20241115082915.22380-1-brookxu.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Chunguang.xu" <chunguang.xu@shopee.com>

Now spdk will change UUID of ns while restarted if we have not
specified one. At this time, while host try to reconnected to target,
as UUID have changed, we will remove the old ns, but not add the ns
with the new UUID. As a result ctrl with no ns, and we need to
disconnect and connect to get the new ns. Here try to add ns with the
new UUID automatically.

Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/core.c | 45 ++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 855b42c92284..425f59fc80d5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3991,28 +3991,6 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
 	}
 }
 
-static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
-{
-	int ret = NVME_SC_INVALID_NS | NVME_STATUS_DNR;
-
-	if (!nvme_ns_ids_equal(&ns->head->ids, &info->ids)) {
-		dev_err(ns->ctrl->device,
-			"identifiers changed for nsid %d\n", ns->head->ns_id);
-		goto out;
-	}
-
-	ret = nvme_update_ns_info(ns, info);
-out:
-	/*
-	 * Only remove the namespace if we got a fatal error back from the
-	 * device, otherwise ignore the error and just move on.
-	 *
-	 * TODO: we should probably schedule a delayed retry here.
-	 */
-	if (ret > 0 && (ret & NVME_STATUS_DNR))
-		nvme_ns_remove(ns);
-}
-
 static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns_info info = { .nsid = nsid };
@@ -4051,11 +4029,28 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	ns = nvme_find_get_ns(ctrl, nsid);
 	if (ns) {
-		nvme_validate_ns(ns, &info);
+		if (!nvme_ns_ids_equal(&ns->head->ids, &info.ids)) {
+			dev_err(ns->ctrl->device,
+				"identifiers changed for nsid %d\n", ns->head->ns_id);
+			nvme_ns_remove(ns);
+			nvme_put_ns(ns);
+			goto alloc;
+		}
+
+		ret = nvme_update_ns_info(ns, &info);
+		/*
+		 * Only remove the namespace if we got a fatal error back from the
+		 * device, otherwise ignore the error and just move on.
+		 *
+		 * TODO: we should probably schedule a delayed retry here.
+		 */
+		if (ret > 0 && (ret & NVME_STATUS_DNR))
+			nvme_ns_remove(ns);
 		nvme_put_ns(ns);
-	} else {
-		nvme_alloc_ns(ctrl, &info);
+		return;
 	}
+ alloc:
+	nvme_alloc_ns(ctrl, &info);
 }
 
 /**
-- 
2.25.1


