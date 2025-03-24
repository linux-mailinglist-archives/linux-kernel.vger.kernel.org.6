Return-Path: <linux-kernel+bounces-574201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6657EA6E1D1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52B85168FCB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33664266B45;
	Mon, 24 Mar 2025 17:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="eqdm2IRx"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3145265CDE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742838584; cv=none; b=rTlHT+pZV5SjrXx6gDFhrrnWAjON0/Z4Zf9MqYI4MNCVtGRWHMy0MjovZoFTsM20RLNOFOXUxWOF8tnJ94ZH3ahyxaSo5l1u9UndnUk/CbXTDO5Or1NbzmepItsAJ8f8rURV5FbFONGXQqj3+453HucdSwyq9M1PUPbN5w/Ct/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742838584; c=relaxed/simple;
	bh=dVGPX7JGPkIN+0UvwddpfThGx7do2Vbuy+auXYK06L4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gp+7cbt05ut3oLw+UjeoCqI8icLIJmmCx/MH3v7BuanMzkpp9DSxpJ7R23ExgI7JHQVgqqQVxfHkG/6W/Fuko1FV4K6l/Af3linjjcqZNgNA7modY0xC24w6jX6dW9bfBtG9FZv5MTe4cC6aLwTuVv4fnxm9m2Q+FyX4SB7g96c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=eqdm2IRx; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22438c356c8so93251385ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 10:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742838582; x=1743443382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOiHfP9p0mlqSIoELkUxcyuZubPUyJkOsyllMOrSXD8=;
        b=eqdm2IRxN1n58gZiYHjzH8uoX2NpCnis1KxqTK6xLnlUpDdEWbtBxleMraE/ocRI4Z
         6Va+M+/amSpTukfibyPr5pnz/gC5MGOutTMxB+VYmHl3nZyq2U08yNsT03ax12C2ThqR
         KeeFIhkzZdypK4bkd4oswkYzv9UWZTcaGZHZTs8FZ1uDF8xKkpzWJVN8PcnhOxFL9Zvs
         I0KkN0X2rsmDjGYU5Hrs2vbxGQ6QRF0E9bRLBOXt20JWiNxyb+ghcdFxBmNi0ovIh76v
         w66cY6wGbifALFIUzahjrHhdVoGK0aIqyQsEd2eLBzZRBQClQ6ToqqzGASuQ1VqVf1oC
         5nQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742838582; x=1743443382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOiHfP9p0mlqSIoELkUxcyuZubPUyJkOsyllMOrSXD8=;
        b=h4oN1a6PnJlQtug8dPfrzOeuqUQqJcydilxigB9w8vxFZDVToOtbiCylreRsfCrRKr
         EdhasNnFscf7KYN9HNjG9k/M4zKKypuPde7Kdtbwqe+lSpQLab4ZWEMbcfZMwYuaivgi
         WIW5KLh7zSrDH3lDlZfuw//cmQNwyaCohvAEi7qxnONeqThukD6H4C8KNcpJaZBSKiDi
         7TgefCbbjlrcUWN3dK2GpJ7I9D2Jng91kCfaLa3rf1QrkWTSO7KfSBprYVRQKcGz5nQ8
         3+gCOAodBEx5CFqkBdwJT98xoJxQYLw7XCgRWE98CwazeIXXevftoIJYgYZ3PdLiTxhX
         88FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWazRUFSPwKonVQt11O2mKzWgD86lf7lHPBpFmI32EtDJoP6gxvd6LVe45ZdndInB/Afc1pHQ+PoYoGbsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1oCeHom0crGAhlJzN+rSEuhG40NSx1ZuYwO01ojAauaaGfQt3
	it5zhreZ5SpKBUTT+ZkjjQn7SB/Ez65jKj4Br9HLOx6qRsW1G9D3nXbqofIYium9/YCZXp96vCg
	h
X-Gm-Gg: ASbGncuHuYPUMX6MYF4KnQP47zQaaCm+kUpE8Hi1+hoKBCc3yOvhRGfqUk0xC0XSdwi
	GRx1Q21KQ68VHQcVaDMRzAsjntEKtphBrmd/bp7YBk3c3ssAZOZB+p4+zC4zYsRQM/6uwoqMQgR
	hBRArDuvomXUk/I8tYevq39LbF4+cqXepmwSEYYcOLiamX8Sj6JS/4EkEgeaHW9gsQ71RjmRYlN
	nptcxWQhWpTbBh08BOOM1F116CRf3sGK2KjPmAuch+i3ko88t5MPI0DwRpb34HQP64/oYabo2lv
	AkAVTfC9EWcSxptGelqgOqtQWgj32DVJlizM0Ma9BdfsrnfeMfM=
X-Google-Smtp-Source: AGHT+IH0d58rGWHCXEpkj7PaCzoJMt0vqxtCsjEoJi4vb1FwzxgpckX9h31G9WT2Is6kAP/nriGNww==
X-Received: by 2002:a17:902:f605:b0:224:2207:5130 with SMTP id d9443c01a7336-22780e260d3mr210963105ad.45.1742838581913;
        Mon, 24 Mar 2025 10:49:41 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8900:32c0::e120])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-301bf576c7dsm12505821a91.3.2025.03.24.10.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 10:49:41 -0700 (PDT)
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
Subject: [RFC PATCH v1 7/7] nvme-tcp: Do not immediately cancel inflight requests during recovery
Date: Mon, 24 Mar 2025 10:49:00 -0700
Message-ID: <20250324174909.3919131-8-mkhalfella@purestorage.com>
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

In case of controller recovery, reset, or deletion it is possible there
are inflight requests for which no response was received from target
controller. TP4129 requires such inflight requests to not be canceled
immediately. Instead these requests should be held until the target
learns about disconnection and quiesce pending nvme commands. Implement
this for nvme-tcp.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/tcp.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 327e37a25281..822e6329e332 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2252,12 +2252,14 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 	return error;
 }
 
-static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl)
+static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
+					  bool hold_reqs)
 {
 	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
 	nvme_tcp_stop_queue(ctrl, 0);
-	nvme_cancel_admin_tagset(ctrl);
+	if (!hold_reqs)
+		nvme_cancel_admin_tagset(ctrl);
 	nvme_tcp_free_admin_queue(ctrl);
 	if (ctrl->tls_pskid) {
 		dev_dbg(ctrl->device, "Wipe negotiated TLS_PSK %08x\n",
@@ -2274,12 +2276,14 @@ static void nvme_tcp_suspend_io_queues(struct nvme_ctrl *ctrl)
 	nvme_sync_io_queues(ctrl);
 }
 
-static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl)
+static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
+					bool hold_reqs)
 {
 	if (ctrl->queue_count <= 1)
 		return;
 	nvme_tcp_stop_io_queues(ctrl);
-	nvme_cancel_tagset(ctrl);
+	if (!hold_reqs)
+		nvme_cancel_tagset(ctrl);
 	nvme_tcp_free_io_queues(ctrl);
 }
 
@@ -2375,7 +2379,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 	}
 destroy_admin:
 	nvme_stop_keep_alive(ctrl);
-	nvme_tcp_teardown_admin_queue(ctrl);
+	nvme_tcp_teardown_admin_queue(ctrl, false);
 	if (new) {
 		nvme_unquiesce_admin_queue(ctrl);
 		nvme_remove_admin_tag_set(ctrl);
@@ -2418,10 +2422,12 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
 	nvme_tcp_suspend_io_queues(ctrl);
-	nvme_tcp_teardown_io_queues(ctrl);
+	nvme_tcp_teardown_io_queues(ctrl, true);
+	nvme_tcp_teardown_admin_queue(ctrl, true);
+	if (nvme_queue_held_requests_work(ctrl))
+		nvme_wait_for_held_requests(ctrl);
 	/* unquiesce to fail fast pending requests */
 	nvme_unquiesce_io_queues(ctrl);
-	nvme_tcp_teardown_admin_queue(ctrl);
 	nvme_unquiesce_admin_queue(ctrl);
 	nvme_auth_stop(ctrl);
 
@@ -2439,11 +2445,15 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 
 static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 {
+	bool hold_reqs;
+
 	nvme_tcp_suspend_io_queues(ctrl);
-	nvme_tcp_teardown_io_queues(ctrl);
 	nvme_quiesce_admin_queue(ctrl);
-	nvme_disable_ctrl(ctrl, shutdown);
-	nvme_tcp_teardown_admin_queue(ctrl);
+	hold_reqs = nvme_disable_ctrl(ctrl, shutdown);
+	nvme_tcp_teardown_io_queues(ctrl, hold_reqs);
+	nvme_tcp_teardown_admin_queue(ctrl, hold_reqs);
+	if (hold_reqs && nvme_queue_held_requests_work(ctrl))
+		nvme_wait_for_held_requests(ctrl);
 }
 
 static void nvme_tcp_delete_ctrl(struct nvme_ctrl *ctrl)
-- 
2.48.1


