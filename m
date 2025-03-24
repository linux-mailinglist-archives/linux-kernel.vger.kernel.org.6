Return-Path: <linux-kernel+bounces-574198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF1FA6E1E6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E7E3AFA78
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466F4265CD4;
	Mon, 24 Mar 2025 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="JkNco1Lo"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ADC265CA6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742838579; cv=none; b=R3bZRm4pXtp1fEEUwjPRqMPYtgjMySqM4U0aG3qXpWarhZBNV+dhqDTr7WiMdzb3WUmJxtxRqMGiRkO09S1+KKWAnV/0iYrMRmVDQtbx9D5qieYdDmNWLRTi9FfPy0q8ilogfP71Im8NxzwNzHIW5L4rIeHI0USgNpjsNJV0EAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742838579; c=relaxed/simple;
	bh=6Tsal6dbPDFKDA1fRnQtE15xj90d72GiBpu7tB6EoDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLkk/FhhGzh9ku5nttLsaClKMpQ50R/QyyPQf0MjLYmjY4ZnDVJjJXDBd6UJiNCHSdvDpf84sMXnGz6mNsfPd2PjuNE89i5R5bLNKgSdjzUMeL3abSfY/5X9CPKtE7MBWb0Ze/cYj135nssBbv+uhSyf4G03Nj30O0rWgN47Lek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=JkNco1Lo; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff797f8f1bso7816458a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 10:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742838577; x=1743443377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tXONZUZjibgEYj/WgZOKQeD7z/HbOhxU4kuAFBXA/g=;
        b=JkNco1LoIpn26wv51QRCoBH5wueOJvYPEdrMb+sKMNTX0aOQEiOR8olbiN9WyWWWZO
         9I8J7HM/QkAUIHtvMxtd/SpdNGxQNesBPrxUHbZ/hliGc9nUU25QQi35e+YTq+zEDm2F
         lvWb1y6QAimZcXnyMVkx+4wU6K2UuLwrh4QD/nt2IS7sjAYVmfo71tQ2sujIw0qdYl93
         E3ELMaK8b64dFbee8OYE8G/Bw5OMzAcYNtFsLx8Z9XHm6Nl4DDAvfjJ7U9y/0evojPH8
         03qwsvqukBg/QyhxkL8piosQ81/fqyRgryTNhjVAMxotiaxW2sToUCjA7RDcJlmRSOB8
         iUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742838577; x=1743443377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tXONZUZjibgEYj/WgZOKQeD7z/HbOhxU4kuAFBXA/g=;
        b=p8nS2Vmw9vQ8SB/wfdaOh/XQBUurd+q8FrKNiONdWqX5hSCW5d6XiMZc5ftFVfdsE6
         LgFVC6epMDS4XtjwvqCrwqOudFSa18ndDaoOUL3XHqaN0lPb4y8Yvtk+pDGlHlCJSBO0
         GFBiXIUoer3b6d11lTXNVbvZqpT5L3/fy0JEvKj8/NPEAcbIatXqKrZ76pJe6Df0WMxG
         8snJ5HdtsIMT0WgsFvnERbv8vJJx0+Ol0YahTdz0QcGYPeMtD3Hlh8htuC6CpKHfTbI/
         LMYza6wPyewNgm19ZAfoASqmoQilGFbu2wM4MnFBEOmh9+4nqzp/cFhJbDckd5R+Xl34
         njCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUARld0N2uoFe85U3lMwnz06N/cAMN2tOwjO9L31CkZ1smCxV8lD18NVPTTLwJLuAtekgr8gZOK66EmrCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9u0S7NSYv2w1DPOVSsFAFJ9bjIYd3MbMDDpeArueQQ6xft0DX
	Kzp2RTZyrU/h1CubHXNqcdyUIh7AV5dFmEfSin8LJnELR1cOMzoDYy7finf8Jb0=
X-Gm-Gg: ASbGncuvuGCgIhsPOFV3GuHOmxmuIX0L28/IK4Sd1/7uiEN8jD2Rq4cECWUg/mbCYOR
	YRIKSbKbWiPz5jqNgr0iSGgR/lck1XslMrLGuTptMGcCjnJx/A6Sggi/Neu9MibyU2cL+2WquX+
	IoVbcuRmIIQa06gOn/pOys0mLeGT+R6QfysHjftybXFSmDZUEE6oc6sRaZ78I/56/JXSVcluTjm
	8G4rjjzUYX2JNOGfJylNiigYXj5oynG/TarItZ4onL/+WRDSBjN6XsTd5/ITOEj77M/ZCkquEZt
	tsy7Z5wnZDjHX9gykGFJ5r1tM+GvEIeqDH6CTEhBfjgk7GTG1PIGDRTcnV97OA==
X-Google-Smtp-Source: AGHT+IFbL79g6cqinOTtCUsCU8CN6KpUY9mimdkEF3cRlYokJ0E4qTs9zViNVaPRI+5PA8mVOPtiCA==
X-Received: by 2002:a17:90b:1dd2:b0:2fe:9e6c:add9 with SMTP id 98e67ed59e1d1-3030fea2e9cmr24583048a91.18.1742838577140;
        Mon, 24 Mar 2025 10:49:37 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8900:32c0::e120])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-301bf576c7dsm12505821a91.3.2025.03.24.10.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 10:49:36 -0700 (PDT)
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
Subject: [RFC PATCH v1 4/7] nvme-tcp: Move freeing admin tagset out of nvme_tcp_teardown_admin_queue()
Date: Mon, 24 Mar 2025 10:48:57 -0700
Message-ID: <20250324174909.3919131-5-mkhalfella@purestorage.com>
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

Update nvme_tcp_teardown_admin_queue() to only tear down admin queue.
Let the caller take care of freeing the tagset if needed. This change
prepares the code to inject the delay described in TP4129 after admin
queue is tron down and before admin tagset is freed.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/tcp.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d12b51ed1a9e..99533ff1ea20 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2252,17 +2252,12 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 	return error;
 }
 
-static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
-		bool remove)
+static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl)
 {
 	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
 	nvme_tcp_stop_queue(ctrl, 0);
 	nvme_cancel_admin_tagset(ctrl);
-	if (remove) {
-		nvme_unquiesce_admin_queue(ctrl);
-		nvme_remove_admin_tag_set(ctrl);
-	}
 	nvme_tcp_free_admin_queue(ctrl);
 	if (ctrl->tls_pskid) {
 		dev_dbg(ctrl->device, "Wipe negotiated TLS_PSK %08x\n",
@@ -2374,7 +2369,11 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 	}
 destroy_admin:
 	nvme_stop_keep_alive(ctrl);
-	nvme_tcp_teardown_admin_queue(ctrl, new);
+	nvme_tcp_teardown_admin_queue(ctrl);
+	if (new) {
+		nvme_unquiesce_admin_queue(ctrl);
+		nvme_remove_admin_tag_set(ctrl);
+	}
 	return ret;
 }
 
@@ -2415,7 +2414,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 	nvme_tcp_teardown_io_queues(ctrl);
 	/* unquiesce to fail fast pending requests */
 	nvme_unquiesce_io_queues(ctrl);
-	nvme_tcp_teardown_admin_queue(ctrl, false);
+	nvme_tcp_teardown_admin_queue(ctrl);
 	nvme_unquiesce_admin_queue(ctrl);
 	nvme_auth_stop(ctrl);
 
@@ -2436,7 +2435,7 @@ static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 	nvme_tcp_teardown_io_queues(ctrl);
 	nvme_quiesce_admin_queue(ctrl);
 	nvme_disable_ctrl(ctrl, shutdown);
-	nvme_tcp_teardown_admin_queue(ctrl, shutdown);
+	nvme_tcp_teardown_admin_queue(ctrl);
 }
 
 static void nvme_tcp_delete_ctrl(struct nvme_ctrl *ctrl)
@@ -2446,6 +2445,8 @@ static void nvme_tcp_delete_ctrl(struct nvme_ctrl *ctrl)
 		nvme_unquiesce_io_queues(ctrl);
 		nvme_remove_io_tag_set(ctrl);
 	}
+	nvme_unquiesce_admin_queue(ctrl);
+	nvme_remove_admin_tag_set(ctrl);
 }
 
 static void nvme_reset_ctrl_work(struct work_struct *work)
-- 
2.48.1


