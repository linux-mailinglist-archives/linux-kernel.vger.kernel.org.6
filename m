Return-Path: <linux-kernel+bounces-380974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DBD9AF872
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 05:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C946F1F22CED
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 03:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BAE1B6D16;
	Fri, 25 Oct 2024 03:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YRQ2HTMu"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A521B3940
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 03:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729828008; cv=none; b=QoFkSrnX5lYisIjAO9JY4384vustTF4N+QgU1rt+bXxOXjjEyW4JUJrkHBP9wpa64oD/bB1Whua689Akfr+4PLc0oJcRyHyScY9/a/0IdzaO4w9km4jcqh5wCzlt892zj6VzLr2IS8Ru8xbOJ/e/zo/hEi7ndAMXPcUql6jmtTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729828008; c=relaxed/simple;
	bh=sK3GReGrrBIZCIcruu3To61mhXqDKeErWsYmv/yiG9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HI0h351j6nS83XoQ891IeqESihaFgWQiWBbjlUj2Y2GcFqCkKCuoWpmelSn4209FbCFRZCYlnWqyQpT7JG9wY8CbKxwbyM8ru3Psn6vve6mCRVhBNVg25tC72CT9FFNOYpQm9JLagdI1oC/9QJwNyxIuDEUnUdFULzYqGIRsE58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YRQ2HTMu; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a4e30bffe3so2846715ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 20:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729828005; x=1730432805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZm7zndLXna2WAoQucoUjtozEIUfuaspQMegms8BWLo=;
        b=YRQ2HTMuIkl274RjbOPHdF4O2yyy65Yws84DEz08blJvLOj31oCJL01TKZFXsk4DvK
         vlh92mRDQghUUp2SF8YMmIsI9cKf9S8sqPhZXxGTznvuGZc/vxOZi4tB55PoRd61UELq
         YRrOM8vpIFvEKGO6wNQtfQvb+Z1c9r6DR/ZaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729828005; x=1730432805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZm7zndLXna2WAoQucoUjtozEIUfuaspQMegms8BWLo=;
        b=EiAGdOEk1xpLVPXjWRYrqBf3RwIQKtCO3THTvNAsDQcIyrAjDlLeRKArYpL9e3fqY9
         bxrAU2Pvrn3CVcRDWMa1z2p8IBML8+iIQQ5r+YuDfRRSLd2MNqnbvRVzhbZqA8bSa9Px
         v0ir4yrbEoRw50ntMADTvDvbZweFQxYR3Cz+lNTBdI0gaeekAiVDHT4GgHISmCtwzqtw
         oXg5KDt0ZQ/t07gBzzaXnUplYyLYe/w8N8liKyph13KaRm8sS4+8Pqf1QWl4/7WYBBlQ
         oEbG3SLCCFfbC5cKNUp4ttNrWc83gNySImu0EP3OorAE7O6xdAbjWagbDxAdGCYP0erL
         zQ2A==
X-Forwarded-Encrypted: i=1; AJvYcCVIGgs6U85nLvlP1t+l9DI/99LfHmX0MuPiP1lgcJUOD1UtXp+sR/tpiRdxnoFhhnAybCUadCvzSC7G0Z4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy67/sWAVE5wDk/uWVGBrNjBIomEoKzJkvJ6vFO2lBF4J5b4CyE
	/xm9kme+zoPz4qy5JKxj2ZFA17JUiM67A5iHRivvGwBe6plPvd3Nr5Hmkqp95A==
X-Google-Smtp-Source: AGHT+IHdcS/vIpN3XVv+OeWemH4WjRZPATqKfxhRmZV7ToHVkIcJIB86Kny1wrH9TtF0foLLESWNUQ==
X-Received: by 2002:a05:6e02:17cd:b0:3a3:be8a:8717 with SMTP id e9e14a558f8ab-3a4de7b8c56mr47800925ab.15.1729828005198;
        Thu, 24 Oct 2024 20:46:45 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:c7f5:2aa6:333b:bb6d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8696bbbsm185197a12.49.2024.10.24.20.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 20:46:44 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 2/3] media: venus: sync with threaded IRQ during inst destruction
Date: Fri, 25 Oct 2024 12:46:13 +0900
Message-ID: <20241025034629.660047-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241025034629.660047-1-senozhatsky@chromium.org>
References: <20241025034629.660047-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When destroying an inst we should make sure that we don't race
against threaded IRQ (or pending IRQ), otherwise we can concurrently
kfree() inst context and inst itself.

BUG: KASAN: slab-use-after-free in vb2_queue_error+0x80/0x90
Call trace:
dump_backtrace+0x1c4/0x1f8
show_stack+0x38/0x60
dump_stack_lvl+0x168/0x1f0
print_report+0x170/0x4c8
kasan_report+0x94/0xd0
__asan_report_load2_noabort+0x20/0x30
vb2_queue_error+0x80/0x90
venus_helper_vb2_queue_error+0x54/0x78
venc_event_notify+0xec/0x158
hfi_event_notify+0x878/0xd20
hfi_process_msg_packet+0x27c/0x4e0
venus_isr_thread+0x258/0x6e8
hfi_isr_thread+0x70/0x90
venus_isr_thread+0x34/0x50
irq_thread_fn+0x88/0x130
irq_thread+0x160/0x2c0
kthread+0x294/0x328
ret_from_fork+0x10/0x20

Allocated by task 20291:
kasan_set_track+0x4c/0x80
kasan_save_alloc_info+0x28/0x38
__kasan_kmalloc+0x84/0xa0
kmalloc_trace+0x7c/0x98
v4l2_m2m_ctx_init+0x74/0x280
venc_open+0x444/0x6d0
v4l2_open+0x19c/0x2a0
chrdev_open+0x374/0x3f0
do_dentry_open+0x710/0x10a8
vfs_open+0x88/0xa8
path_openat+0x1e6c/0x2700
do_filp_open+0x1a4/0x2e0
do_sys_openat2+0xe8/0x508
do_sys_open+0x15c/0x1a0
__arm64_sys_openat+0xa8/0xc8
invoke_syscall+0xdc/0x270
el0_svc_common+0x1ec/0x250
do_el0_svc+0x54/0x70
el0_svc+0x50/0xe8
el0t_64_sync_handler+0x48/0x120
el0t_64_sync+0x1a8/0x1b0

Rearrange inst destruction.  First remove the inst from the
core->instances list, second synchronize IRQ/IRQ-thread to
make sure that nothing else would see the inst while we take
it down.

Fixes: 7472c1c69138 ("[media] media: venus: vdec: add video decoder files")
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/venus/vdec.c | 12 +++++++++++-
 drivers/media/platform/qcom/venus/venc.c | 12 +++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 0013c4704f03..b3192a36f388 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -1750,10 +1750,20 @@ static int vdec_close(struct file *file)
 	vdec_pm_get(inst);
 
 	cancel_work_sync(&inst->delayed_process_work);
+	/*
+	 * First, remove the inst from the ->instances list, so that
+	 * to_instance() will return NULL.
+	 */
+	hfi_session_destroy(inst);
+	/*
+	 * Second, make sure we don't have IRQ/IRQ-thread currently running
+	 * or pending execution, which would race with the inst destruction.
+	 */
+	synchronize_irq(inst->core->irq);
+
 	v4l2_m2m_ctx_release(inst->m2m_ctx);
 	v4l2_m2m_release(inst->m2m_dev);
 	ida_destroy(&inst->dpb_ids);
-	hfi_session_destroy(inst);
 	v4l2_fh_del(&inst->fh);
 	v4l2_fh_exit(&inst->fh);
 	vdec_ctrl_deinit(inst);
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 6a26a6592424..36981ce448f5 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -1517,9 +1517,19 @@ static int venc_close(struct file *file)
 
 	venc_pm_get(inst);
 
+	/*
+	 * First, remove the inst from the ->instances list, so that
+	 * to_instance() will return NULL.
+	 */
+	hfi_session_destroy(inst);
+	/*
+	 * Second, make sure we don't have IRQ/IRQ-thread currently running
+	 * or pending execution, which would race with the inst destruction.
+	 */
+	synchronize_irq(inst->core->irq);
+
 	v4l2_m2m_ctx_release(inst->m2m_ctx);
 	v4l2_m2m_release(inst->m2m_dev);
-	hfi_session_destroy(inst);
 	v4l2_fh_del(&inst->fh);
 	v4l2_fh_exit(&inst->fh);
 	venc_ctrl_deinit(inst);
-- 
2.47.0.163.g1226f6d8fa-goog


