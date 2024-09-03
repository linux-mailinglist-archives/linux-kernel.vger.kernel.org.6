Return-Path: <linux-kernel+bounces-313135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAEB96A0B6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B1D8B22C52
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513FF374CC;
	Tue,  3 Sep 2024 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsBnsICj"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3A178C60;
	Tue,  3 Sep 2024 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373935; cv=none; b=hDQdS37s+EicRjIuu7v+95Zk3K6LMdoclERFKBks5WzdWwButk5jqO8QtufsYYN7EUw0jK0qW6FpqY5xwuJScZYcTV1iQhyx451h9XnBDynnWuvwJfcw1nrZcDW5sUxmgr6cd2iF0F1tGQRZkCSUO4hjJ5rRF/myCAVLlU8DphE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373935; c=relaxed/simple;
	bh=G8HaXciLzp4DpHHJ4lF1nDYZc6owSxrwtcIJdBGOaow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pyv4eVKdBBi5UjCfvThQj8wIRJSqm5mVVQ2Was/e7wNabOSJJZndtWfEIE9zkPivScitiVidxgZCoXfZg+A/FgVwQqPjjgzkj34kF5vdUizk2wWtFPpa1ODFvAk6VwXofmk2gY7cl8zmuLOAhkyONMGd7LJpgYLngV2omxV0M+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsBnsICj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20696938f86so6555345ad.3;
        Tue, 03 Sep 2024 07:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725373933; x=1725978733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YIjSe+i6rXNVHkXPvRaS+Rvq2j7U9uYFImded3/VtFE=;
        b=GsBnsICjWLf9i95YDqXfmodpLPnM3Y6iG/OK+/Tca5/Uknc1KLpgtvy90zLZ2H6Rst
         cm4iZ7czCBIYHWaftLRM7RwbRQWhof+4gN66d7SC8GJaXDUVcJycgyHJ4pp+DnmBe519
         x3wp8iEqGiuSIMgbk9suQBBAIA0ZFRtzuRgNfJiMPfbeubaK4pLdHarJf0ZORYrSUmHw
         QUvmhxXyaFWujs3TtKIERYpbj6h0I+w2sw3+WyMsOiEccXZurE7Dg0MpZQyFzWcvqDox
         IW3d3o/Ef78Mss+9FivHicAgBfjo3yh4SFajzQ+uW9boauPbE9F16mh0dn+Ii1GyktS6
         wAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725373933; x=1725978733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YIjSe+i6rXNVHkXPvRaS+Rvq2j7U9uYFImded3/VtFE=;
        b=uA7aO1zJ5mFVl1vQcKydnnGjcs1piqbO8wXfMbIdxv9N5rU5f5K0OWEKKQaUPNP57J
         XDSPz0PjLpQZ6pumup+W6WCKZZQN3T9BGaV+yGtbhHW4ptCLpC4RsyFvVmEnr9jvz6fr
         dhY28t3d2n+QvuypGuucS23AmW/1XHQGm5Y8HRDXKKOFFBKGbbBt0raDB0wGHjBkVOcH
         mkqDv4nXx7g4PCBRXIYFQhW1fl3gwnRMIWOGOHCdNhMGl0RQlXZrJSbnmOUTWu9nCQ0v
         qWXbi1jhU6x9g5BmoCH8IH331c91QBAE2WwO9JzZi5rJEm/aqgnOs36a1LsD9q2izwmB
         iYsw==
X-Forwarded-Encrypted: i=1; AJvYcCUHrhUPeGCivcetpdeOYTj1GhYwWB3AgF0hNLYr4CnfFQrllZ37xbVQgSLhZ4a4VYTezcFrg4WO7TDHvuM=@vger.kernel.org, AJvYcCWlSdVFyPAotICne5H5T9m9S6lDG0ZNHlAw6qszu51zDSI28wrFRkCsapYbw4Qo6f8RYeeFziL6OFa73wI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuMfLyNkBlNyveco8eFYtTorP3+finembrRbSlo1Z191JHzQrF
	hKh9mZUbw8dE49hZ0Oxr0Bsd0+VWkLk+i654yQV/xc13Q+T3Gm+H
X-Google-Smtp-Source: AGHT+IG66vfhTieaPqKoMJl/Vz6d3RJjOUslhRVu7JOgNiEKw3CvpRH/KGu3jzUxEh2G12ZtOwcwBA==
X-Received: by 2002:a17:902:d2ce:b0:202:3e52:e124 with SMTP id d9443c01a7336-2054451b9f9mr90570385ad.31.1725373933064;
        Tue, 03 Sep 2024 07:32:13 -0700 (PDT)
Received: from fedora.. ([106.219.162.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152cd4dbsm81525575ad.64.2024.09.03.07.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 07:32:12 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: cezary.rojewski@intel.com,
	pierre-louis.bossart@linux.intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH] ASOC: Intel: fix parenthesis alignment and space after cast coding style issue
Date: Tue,  3 Sep 2024 20:01:13 +0530
Message-ID: <20240903143113.18382-1-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adhere to Linux kernel coding style.

Reported by checkpatch:
- CHECK: Alignment should match open parenthesis
- CHECK: No space is necessary after a cast

It has no functional changes.

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
 sound/soc/intel/atom/sst/sst.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
index e0357d257c6c..38d29d545b52 100644
--- a/sound/soc/intel/atom/sst/sst.c
+++ b/sound/soc/intel/atom/sst/sst.c
@@ -50,7 +50,7 @@ static irqreturn_t intel_sst_interrupt_mrfld(int irq, void *context)
 	union sst_imr_reg_mrfld imr;
 	struct ipc_post *msg = NULL;
 	unsigned int size;
-	struct intel_sst_drv *drv = (struct intel_sst_drv *) context;
+	struct intel_sst_drv *drv = (struct intel_sst_drv *)context;
 	irqreturn_t retval = IRQ_HANDLED;
 
 	/* Interrupt arrived, check src */
@@ -60,7 +60,7 @@ static irqreturn_t intel_sst_interrupt_mrfld(int irq, void *context)
 		/* Clear done bit */
 		spin_lock(&drv->ipc_spin_lock);
 		header.full = sst_shim_read64(drv->shim,
-					drv->ipc_reg.ipcx);
+					      drv->ipc_reg.ipcx);
 		header.p.header_high.part.done = 0;
 		sst_shim_write64(drv->shim, drv->ipc_reg.ipcx, header.full);
 
@@ -92,7 +92,7 @@ static irqreturn_t intel_sst_interrupt_mrfld(int irq, void *context)
 			size = header.p.header_low_payload;
 			if (sst_validate_mailbox_size(size)) {
 				memcpy_fromio(msg->mailbox_data,
-					drv->mailbox + drv->mailbox_recv_offset, size);
+					      drv->mailbox + drv->mailbox_recv_offset, size);
 			} else {
 				dev_err(drv->dev,
 					"Mailbox not copied, payload size is: %u\n", size);
@@ -114,7 +114,7 @@ static irqreturn_t intel_sst_interrupt_mrfld(int irq, void *context)
 
 static irqreturn_t intel_sst_irq_thread_mrfld(int irq, void *context)
 {
-	struct intel_sst_drv *drv = (struct intel_sst_drv *) context;
+	struct intel_sst_drv *drv = (struct intel_sst_drv *)context;
 	struct ipc_post *__msg, *msg;
 	unsigned long irq_flags;
 
@@ -146,8 +146,8 @@ static int sst_save_dsp_context_v2(struct intel_sst_drv *sst)
 	int ret = 0;
 
 	ret = sst_prepare_and_post_msg(sst, SST_TASK_ID_MEDIA, IPC_CMD,
-			IPC_PREP_D3, PIPE_RSVD, 0, NULL, NULL,
-			true, true, false, true);
+				       IPC_PREP_D3, PIPE_RSVD, 0, NULL, NULL,
+				       true, true, false, true);
 
 	if (ret < 0) {
 		dev_err(sst->dev, "not suspending FW!!, Err: %d\n", ret);
@@ -228,7 +228,7 @@ static void sst_init_locks(struct intel_sst_drv *ctx)
  * we are fine with using unsigned short as dev_id type.
  */
 int sst_alloc_drv_context(struct intel_sst_drv **ctx,
-		struct device *dev, unsigned short dev_id)
+			  struct device *dev, unsigned short dev_id)
 {
 	*ctx = devm_kzalloc(dev, sizeof(struct intel_sst_drv), GFP_KERNEL);
 	if (!(*ctx))
@@ -242,7 +242,7 @@ int sst_alloc_drv_context(struct intel_sst_drv **ctx,
 EXPORT_SYMBOL_GPL(sst_alloc_drv_context);
 
 static ssize_t firmware_version_show(struct device *dev,
-			    struct device_attribute *attr, char *buf)
+				     struct device_attribute *attr, char *buf)
 {
 	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
 
@@ -302,7 +302,7 @@ int sst_context_init(struct intel_sst_drv *ctx)
 	ctx->ipc_reg.ipcd = SST_IPCD + ctx->pdata->ipc_info->ipc_offset;
 
 	dev_info(ctx->dev, "Got drv data max stream %d\n",
-				ctx->info.max_streams);
+		 ctx->info.max_streams);
 
 	for (i = 1; i <= ctx->info.max_streams; i++) {
 		struct stream_info *stream = &ctx->streams[i];
@@ -325,7 +325,7 @@ int sst_context_init(struct intel_sst_drv *ctx)
 	sst_shim_write64(ctx->shim, SST_IMRX, 0xFFFF0038);
 
 	ctx->qos = devm_kzalloc(ctx->dev,
-		sizeof(struct pm_qos_request), GFP_KERNEL);
+				sizeof(struct pm_qos_request), GFP_KERNEL);
 	if (!ctx->qos) {
 		ret = -ENOMEM;
 		goto do_free_mem;
-- 
2.46.0


