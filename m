Return-Path: <linux-kernel+bounces-377359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C229ABDC3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF6C4283F78
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 05:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891C3146D45;
	Wed, 23 Oct 2024 05:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q7uksv+D"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7144114600C
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 05:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729661098; cv=none; b=R/CddBRUUuCfXmmgTec4xSNdSWuE20S2sj6NC+1N7Zu1TsHz9iEDTs+yDRTMnj6p0DVkfQdPY1rE36NqGkoAjQCym04ci29VXLA4Wke3jCuI+j6b2bLOw/eVe+LZcHZasq24eTVvI2FS2sRYkMGQgnwU46m3v9JSzmEeHpxXpb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729661098; c=relaxed/simple;
	bh=o/fVb/rPrIPHMs3QGTbUUPiMExCk4zRccUoj0Y/1QDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HF10490rZiE1K7DxPwMxR9kaRctCS1mFdbzOTnes7rX4SUh1rkw578OJ+MCww1nMJF54AVK8CDEcA0c21HRbenNlqawZ3gHExQ5zeXGVgtuMfGqDiR3NGmKNrotLUBeUmVkeiOZ+PXnI90+CoNt1bxe1fhzCU52fV+D0GCVfd8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q7uksv+D; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2cc47f1d7so376607a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 22:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729661095; x=1730265895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9uAXGz+Gbunwh+KLn0sQpSbpt7P3BrgYTjoz3sK6n0=;
        b=Q7uksv+DZwuq/UqU8wfWoISkfS9sEvWbVFX4BqARn7ZXQFRrk7cVCNzO8CFInIc7dR
         yyOCjUQPjNKTcsXOUr6QTxqjCkDrrtS9d0cg1WYgAoNNI2wf2tGpKmrrHqrmfRXzjYx+
         KxQLjKVdNv3lijfgeEFwqqLvysKQY8Pp8XyrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729661095; x=1730265895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9uAXGz+Gbunwh+KLn0sQpSbpt7P3BrgYTjoz3sK6n0=;
        b=Qg61NAEL4vf19w1WtwyuxXM+H9Z+MUO/pIh458mCFxhJuKWismeVwsim3is36+kVm8
         ITbmQ4qEqFQnFhyRcARHm1A/LIfsuYBv2ClcF+Y/ZkKUSHdxXy/4GoKhDaqysHa4W6VV
         IRQliDgh4AnwIPMCKbVXbZh7XalsKbnyIXWuuko3sGBT/C2Fc9NUw8LANiLlWMBOAWvA
         WQr+S6x8p9win+xGZiDLz7NC+Av5PvKMV8BqPrhTFAyk4NXiwmRpvMyT6IDtTYJZBQs7
         zgvnvpvYVVqzRNHgugDsdNbzItvvbS3v4jn4eqjlfVy2K6miv7MFPqdKIx8GFq3X5Ohz
         jhNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9ewO+qD6ASJHBZFTmhXJgfUrW5FhnFqf63r/TogHNtJqQDFxe8oynNp7lsmAogZVK2+OY2Ur63k3WncY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAwYoJpQI5qrU7GL5Sw9/ckcOb9Wnmfb1x+KxF8DspgJHibReW
	d9lTpLlWgxPctAW4L7FPEEhGVe+ObfHClAuvQXj/plhhgDmNAmfLuziTUcHSFg==
X-Google-Smtp-Source: AGHT+IHpp7Yxa5X9fJ+XfPUvT5pFQyWWbt/3ZgxyXYiMvClBkmvZ39OcJGcf98L+305sXmyfNAvYaw==
X-Received: by 2002:a17:90a:ae17:b0:2e2:e086:f5c0 with SMTP id 98e67ed59e1d1-2e5db93c457mr8706469a91.5.1729661094727;
        Tue, 22 Oct 2024 22:24:54 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:eec8:692:e549:d490])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e76e088f1fsm413112a91.56.2024.10.22.22.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 22:24:54 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tomasz Figa <tfiga@google.com>
Subject: [PATCH 1/2] media: venus: fix enc/dec destruction order
Date: Wed, 23 Oct 2024 14:24:21 +0900
Message-ID: <20241023052444.139356-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
In-Reply-To: <20241023052444.139356-1-senozhatsky@chromium.org>
References: <20241023052444.139356-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We destroy mutex-es too early as they are still taken in
v4l2_fh_exit()->v4l2_event_unsubscribe()->v4l2_ctrl_find().

We should destroy mutex-es right before kfree().  Also
do not vdec_ctrl_deinit() before v4l2_fh_exit().

Suggested-by: Tomasz Figa <tfiga@google.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/media/platform/qcom/venus/vdec.c | 7 ++++---
 drivers/media/platform/qcom/venus/venc.c | 6 +++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 6252a6b3d4ba..0013c4704f03 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -1752,13 +1752,14 @@ static int vdec_close(struct file *file)
 	cancel_work_sync(&inst->delayed_process_work);
 	v4l2_m2m_ctx_release(inst->m2m_ctx);
 	v4l2_m2m_release(inst->m2m_dev);
-	vdec_ctrl_deinit(inst);
 	ida_destroy(&inst->dpb_ids);
 	hfi_session_destroy(inst);
-	mutex_destroy(&inst->lock);
-	mutex_destroy(&inst->ctx_q_lock);
 	v4l2_fh_del(&inst->fh);
 	v4l2_fh_exit(&inst->fh);
+	vdec_ctrl_deinit(inst);
+
+	mutex_destroy(&inst->lock);
+	mutex_destroy(&inst->ctx_q_lock);
 
 	vdec_pm_put(inst, false);
 
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 322a7737e2c7..6a26a6592424 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -1519,14 +1519,14 @@ static int venc_close(struct file *file)
 
 	v4l2_m2m_ctx_release(inst->m2m_ctx);
 	v4l2_m2m_release(inst->m2m_dev);
-	venc_ctrl_deinit(inst);
 	hfi_session_destroy(inst);
-	mutex_destroy(&inst->lock);
-	mutex_destroy(&inst->ctx_q_lock);
 	v4l2_fh_del(&inst->fh);
 	v4l2_fh_exit(&inst->fh);
+	venc_ctrl_deinit(inst);
 
 	inst->enc_state = VENUS_ENC_STATE_DEINIT;
+	mutex_destroy(&inst->lock);
+	mutex_destroy(&inst->ctx_q_lock);
 
 	venc_pm_put(inst, false);
 
-- 
2.47.0.105.g07ac214952-goog


