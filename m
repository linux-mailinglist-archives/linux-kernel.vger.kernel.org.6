Return-Path: <linux-kernel+bounces-380973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB6D9AF870
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 05:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103D51F222E6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 03:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A9218C93B;
	Fri, 25 Oct 2024 03:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YwR3rIDx"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B8218C935
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 03:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729828006; cv=none; b=nitEs5NfIP3My/jFoWoiIERulFOYZ6x+s5req1+CajZEdsiNlGbmqH5PQyJkZvq5slLDrp9aNv4IJs3DCV9kcubVOIKhy53sm1vBe6Ida5gQtJfe9GnNrRwR8YzazyeJl9OXFW2EqKMZHhcgky+W7GHTL/pzC2UivGZM2VKJI4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729828006; c=relaxed/simple;
	bh=RveC5jacooImmHBxMnm+SqvD0OPds08xgXiCC+fcXwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIgOzwNIpHfc+jsiHTcv9LhXLS3KOewSfY79iyQPFegZoOV2p8DxkBSNy51qJoXWPqkGyx5AT0nahOWLALueqjWiXUVgdNmAH4wFe/86HJaTzQL/jq6b8yB8srLjVtm2ba0JFHN9Fr9Qv2ANvMZPdsXX4JOV8utgojUhwCgGMi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YwR3rIDx; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-83ab5b4b048so67759639f.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 20:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729828002; x=1730432802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8O+PQVPJ/vy+FUOPeA37d+cZZmUqt00r3pyhnqMSbPI=;
        b=YwR3rIDx6H3v5vaAmwICnAPpFKUDKeKxZmJ1a4wiMPJ8UkDOo2imzAW5hpRjDbG26n
         6yaSWqwjwlEdRREwCelRyoLxrb3hqiJcImJBT4Wi4QpT+hO1Q/FVaEQedKbA+RbLWSl6
         +tnuDboUEYrzAVP24kED6+hFlTjxZ6utLcqh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729828002; x=1730432802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8O+PQVPJ/vy+FUOPeA37d+cZZmUqt00r3pyhnqMSbPI=;
        b=K8uKwjW/JBtN1BD29afubiJuDQcmKfHLwd2cDQVTGXD7tz7awcU52ezJsIfeThWqUd
         Lf1i31ZyTTI1Q5tT1nWX/0QdnVPSqsBNvDaJ353CKmcK5wKfhuJcqBLUo+m5iraQr+oR
         axnEX+iVah53/roSLoZge+dcdmedPluKH5N9n4bL3KIZeY1LFDWB0jttY+KdfT51bqal
         e/stoVxXxaxrQI7DkMp8XEv5mokI61/rFNOFEJNITSsMHKSK+XxgglHltywEAyNVdSh9
         5ub1+wXv4NJRkQ3mwCdBuBLwiehySB85RPrkQV1iQY3djTTcFe1irjMdrGBSd5Pon+gL
         dZvw==
X-Forwarded-Encrypted: i=1; AJvYcCXqVLM0jvy4lOUrNjmftyJ3EbD33IeEWRmfrTq/eurVtwFb0vhri0d/RoQkaDKusxF3hYsTnKaV0WJa2lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiVCZuTmUv/APUZ8119AUXc3Rx1sNc0z7mFv7y+0clq2DADfne
	LOR4413HhqQf1xkUlh6RU4RhQJdqY76rWXWCoGsvM5EKyKPdakXSc9N8j+3n3w==
X-Google-Smtp-Source: AGHT+IGOPFQzDR92JPbaLzlIZmINd7ceSB06dZyb4vu4bdqgz6NHoI1NwRh9nQR+0y/T4/8AO6Q5DQ==
X-Received: by 2002:a05:6e02:1b03:b0:3a3:4122:b56e with SMTP id e9e14a558f8ab-3a4de840a0bmr43776365ab.26.1729828002698;
        Thu, 24 Oct 2024 20:46:42 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:c7f5:2aa6:333b:bb6d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8696bbbsm185197a12.49.2024.10.24.20.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 20:46:42 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tomasz Figa <tfiga@google.com>
Subject: [PATCHv3 1/3] media: venus: fix enc/dec destruction order
Date: Fri, 25 Oct 2024 12:46:12 +0900
Message-ID: <20241025034629.660047-2-senozhatsky@chromium.org>
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

We destroy mutex-es too early as they are still taken in
v4l2_fh_exit()->v4l2_event_unsubscribe()->v4l2_ctrl_find().

We should destroy mutex-es right before kfree().  Also
do not vdec_ctrl_deinit() before v4l2_fh_exit().

Fixes: 7472c1c69138 ("[media] media: venus: vdec: add video decoder files")
Suggested-by: Tomasz Figa <tfiga@google.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
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
2.47.0.163.g1226f6d8fa-goog


