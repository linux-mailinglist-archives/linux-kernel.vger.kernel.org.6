Return-Path: <linux-kernel+bounces-410343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471469CDA24
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0696A2831A0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD26617BED0;
	Fri, 15 Nov 2024 08:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZ4q4fdb"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2EE2AF05
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 08:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731657712; cv=none; b=rOCChvb+8svb1NJsyGhtp1XnjwAKQbSiOZec8RyYVgcEodFz930HQNJX3fU/nQKMpvjMufhzUyuZ6MFRX8lENYsqrdc0fQVGjnOpV4+8XUmZQ/knG0eb4/nUr2vtZnPOnyB0YKlsAuQjfKRs7damQJ3+Is3vtxr9w6XgALA3lBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731657712; c=relaxed/simple;
	bh=eJdvgbWglYc64SjuPYn4iCjmk5B07aJPPbFGx0gCFq0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C8iUSj5CNiN/L4GXGtH/j2Yt57Q1s9qonmQu4Qu8Hfn/bQZ7f0EDGjoBKVl1NvUrKHzCS3p17nkadl/Hl9Cls/lZ8Dk+HmNlmn4tP0VCNVu74lYPEGRT4p3a07j+9lbZFL3W3bv/eKwYQZtuOinUTn2VvqrEDXXLIBH0nHOhoJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZ4q4fdb; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ee020ec76dso1106838a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 00:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731657710; x=1732262510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YQPyex0bJfNxoqNLhhDYmIY7JYJjX/+VF6K867de6e4=;
        b=OZ4q4fdbd+XkpgTapmXhdWPd5m95Ef9MGuZS1+C8X0NEoytGhMMoq5CeqSo9LD35RY
         OXp/ogqA9nUtyRzUkq4fGZbXZyTEfwr62r1kP1ZCbLdPT7jJjmvdKh9Amxagtjjp0a3A
         XiWPmEPS484E+3u3c/96EZC3jgQrw5Nv67H+ixxt1X13mAn0K5nUcl3fWTp0mY95tUYn
         zUk54LwZuVMvUpTPyX7QQ71x4eaH2yVUf/nAYTRmokkUzazAdPrNiMTfzfSWuKTpXebp
         mhBeCPxZDm1FLuWEDDQ0BLChNT6VJzKTzdaspTxjCZ+BGP5GZhv+JI2i3lwPymX3slqw
         UVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731657710; x=1732262510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YQPyex0bJfNxoqNLhhDYmIY7JYJjX/+VF6K867de6e4=;
        b=rYeiLUZFBSKKIc6CRpuvpDrjUrHE9i7t4yGeENvDo9r37ZNm4AF9S+1n0M5lPT9ovf
         vpr9+suovTY+RKf0gn0abazI/4oWXEzSR1A7y2agU1NFeKrptgSq8QyjbaB6+aR1e6HA
         6srcttyWC+kLXNCGFeGkeEX3ZPICMuLVrChSM75WbZB/Yk63Vtu7LYiXkUEgSN0mZXZV
         LNi8P81h7bV/wFhT+B0ucCvzsnOxUx6j4Ydik33x92kYgo2Bjux+2ZH4YtX9zbzWaX7Z
         ET3hbOc/nC472zr5oH+S7wd97YvePi1J0s+fjpJmmxT/6UGHpq5/2KTJJQNKwIx1dh6f
         XsfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaoIx4dDazk+pK3ap7Ehh6pknwSZSCy1aWo34kG1f29Mmckeyvtite16J2udHCNGoDabTSO8XJ+0H0AHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO73rXsEteXWg3/vT9iis7freGxd9qDkMT+YZBZGqF1g3BnPiR
	NvHqtJIi/J5Uq8zEA8s//nvKGvgG5EtoW2US0LQ4A3FKrkRhygAU
X-Google-Smtp-Source: AGHT+IGlhh57+NslnLvNLqxVjyA+6H7jQH044HGNOiok6gSn8PT1nNDQvtUE2sWpcRVgeOAlla5AXA==
X-Received: by 2002:a05:6a20:6a1a:b0:1d9:239b:a125 with SMTP id adf61e73a8af0-1dc90b1cd64mr2503739637.15.1731657710079;
        Fri, 15 Nov 2024 00:01:50 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724770eefe7sm788871b3a.31.2024.11.15.00.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 00:01:49 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] nvme-core: auto add the new ns while UUID changed
Date: Fri, 15 Nov 2024 16:37:27 +0800
Message-Id: <20241115083727.30005-1-brookxu.cn@gmail.com>
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

Reported-by: Yingfu.zhou <yingfu.zhou@shopee.com>
Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/core.c | 45 ++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

V2: Add missed reporter

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


