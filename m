Return-Path: <linux-kernel+bounces-574197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A35B6A6E1D8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBAB7188A881
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E2C265CBD;
	Mon, 24 Mar 2025 17:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fyU7VxQS"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D7726562E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742838578; cv=none; b=BlR9ooNdUfM7PHHBpifYL/1eiPxLA3OopIkja6K4qKK1ZkisiNolTvSusVpjiedCfVomkIiLs6j9g8HDoE3hNqqHAPHBoZyIio2mJr4zcZnUAOGpNKIg7oAdPvu1GO8cgKg+z30uxYdGPLB55JZcXL3rBjvU0Spl3wHOGE5+pC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742838578; c=relaxed/simple;
	bh=UzopV+IBmkyiEOtBtpq3AqgbUxWZ5DRVETnY2cybrZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOpLugQhaS110d8KZ7I1MeuaMBeO3E7n7QfElc2Khx/P8AmWNfexpRnDaMjPs7eAlR15oC9xlzsgO6vZnb8pZ8lB8ZIzcoLKupgFxdw9VoZiQuEHimf/V9lPR4w/r+TKayYVUuanTSRhxdY32XmdYfKrgbroxdT+T3b7XinKTnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fyU7VxQS; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ff6e91cff5so8088564a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 10:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742838576; x=1743443376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbKikyrkuQKAbVcAqWwtL5MxvKjcnNKUJ4bcGpnldxg=;
        b=fyU7VxQSN4oQDs9YXf7JgkJIvrxiz3eQx+GRI6Ra7n6ul7wgoJgYv4N7HNnWhf4CXO
         RsevHsNOGhwMCPPw6iCt004ZO0BdtCooRJynw3GuCzCGkG2/0Td+2/Um9wm93OvJ0zUN
         V9MJnaW+bsjPK24pC/x2BCrbo5IIyZMLurLpLJnOSLgXEmVhY7z8TBUaVjY6x9R3HxiY
         uF3a2Werx+5gB8+9cmnUESssilmE+mSf8jFRluNt0lH6ERSvvsBZYRe0y2WGIXsuCk1w
         GRbNPHclpk58N2Cwz7Shv0qhrhdGlsMsjomPwNq4hERgYBSIqXeSpFZXwj7ekgws9F84
         N69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742838576; x=1743443376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbKikyrkuQKAbVcAqWwtL5MxvKjcnNKUJ4bcGpnldxg=;
        b=w07JdNPnKNxlU3oGhRcKNUxrS6Bi9GQsqmKCzbEc8/WDJ7+mebNV73cXDbEc6ZDbFr
         M6D2BgzIf9Iffok5W4EyxF9dra2RlVHIEMseOhjQ+GKhzdsO5LOa4oYuMGnJnDIf5t2h
         rZ/dbYn9jQC/KFBom3VTQhnz9O+QW29ma3de+7AWWyHyDi3O8RMPUPb8xBfix+PhPZep
         scCfWzkVOXYpKHlCnhEAYhjy2t2XU7CTDGkESqvi61rKdrGFVB555Is7jjQ4FMomXkWW
         lwuxCeMUFBMEBH/E3JH786GBfnCj65fG8XGNGZSjzyXpkzA5SGISso2qYjU7A/McX+U8
         XgYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoP7QYCfgVKUS4lWMut8jv8UxrWXJcgHBVLr72AhE7VXBNIlW0JCM/x0sdXe+GUHaNrlRSMPwlVs9QP4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3AH8HmwupVKk8sYP94TXq9FZPdNFR7xE0Wu/o0zn3eaZQmwez
	LSnqqiKbjLfQPlP+Kg3VKyBPqtXgYWuKkCVtTK7osx+1y1Po0wYLTsxr9bSbnlQ=
X-Gm-Gg: ASbGncu2zT5MFvxEjGa7jtm78/Azxn0EuWsaOgzZP3bLnKr7tealinX8n4Uge8me+cq
	lpj/4PUnJf3Kv2XJJ0/p3OGwQYE5rzO8fqg9wQ5kiRf/460PiFFksuDnqv2qAfdENsyGOVDyfdq
	1pUHB5xUpD3EEctKSjHLZvginqEBj94uPo0fdLK93cwgFE178gq1PCeWoPI9a/qEVBEk3UibTkN
	hNVBUfkrGN554TV43o+lo3qWL27D01+0JEBZGi9kZWkOtp8+dxKiO13Io32jIlUJ+LEoWh738Dg
	/6aHnF9cbh/0uUT+JdTBL53V40QJRoz8o2CO3uIrotSO4M4lTa8=
X-Google-Smtp-Source: AGHT+IEa1vT6cpVDLe0ags7PxHVLo5gJ1K8CS9xAHU/xWCcEk9aWqc+j3Ou83FOXQmtPg3nh0oY0xQ==
X-Received: by 2002:a17:90b:54c7:b0:2fe:dd2c:f8e7 with SMTP id 98e67ed59e1d1-3030fe94fe8mr22634637a91.10.1742838575561;
        Mon, 24 Mar 2025 10:49:35 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8900:32c0::e120])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-301bf576c7dsm12505821a91.3.2025.03.24.10.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 10:49:35 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <wagi@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	randyj@purestorage.com,
	adailey@purestorage.com,
	jrani@purestorage.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com
Subject: [RFC PATCH v1 3/7] nvme-tcp: Move freeing tagset out of nvme_tcp_teardown_io_queues()
Date: Mon, 24 Mar 2025 10:48:56 -0700
Message-ID: <20250324174909.3919131-4-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324174909.3919131-1-mkhalfella@purestorage.com>
References: <20250324174909.3919131-1-mkhalfella@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update nvme_tcp_teardown_io_queues() to only tear down IO queues.
Let the caller take care of freeing the tagset if needed. This change
prepares the code to inject the delay described in TP4129 after IO
queues are tron down and before IO tagset is freed.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/tcp.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 327f3f2f5399..d12b51ed1a9e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2271,8 +2271,7 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 	}
 }
 
-static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
-		bool remove)
+static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl)
 {
 	if (ctrl->queue_count <= 1)
 		return;
@@ -2280,10 +2279,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	nvme_sync_io_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
 	nvme_cancel_tagset(ctrl);
-	if (remove) {
-		nvme_unquiesce_io_queues(ctrl);
-		nvme_remove_io_tag_set(ctrl);
-	}
 	nvme_tcp_free_io_queues(ctrl);
 }
 
@@ -2417,7 +2412,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 
 	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
-	nvme_tcp_teardown_io_queues(ctrl, false);
+	nvme_tcp_teardown_io_queues(ctrl);
 	/* unquiesce to fail fast pending requests */
 	nvme_unquiesce_io_queues(ctrl);
 	nvme_tcp_teardown_admin_queue(ctrl, false);
@@ -2438,7 +2433,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 
 static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 {
-	nvme_tcp_teardown_io_queues(ctrl, shutdown);
+	nvme_tcp_teardown_io_queues(ctrl);
 	nvme_quiesce_admin_queue(ctrl);
 	nvme_disable_ctrl(ctrl, shutdown);
 	nvme_tcp_teardown_admin_queue(ctrl, shutdown);
@@ -2447,6 +2442,10 @@ static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 static void nvme_tcp_delete_ctrl(struct nvme_ctrl *ctrl)
 {
 	nvme_tcp_teardown_ctrl(ctrl, true);
+	if (ctrl->queue_count > 1) {
+		nvme_unquiesce_io_queues(ctrl);
+		nvme_remove_io_tag_set(ctrl);
+	}
 }
 
 static void nvme_reset_ctrl_work(struct work_struct *work)
-- 
2.48.1


