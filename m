Return-Path: <linux-kernel+bounces-381523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E2F9B007C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 228A828403D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97841F9ECE;
	Fri, 25 Oct 2024 10:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b0S0/ROI"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17A01F708E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729853480; cv=none; b=R8obA2Nzw7eXu2QPJOxTOhIUkvj/t3+v9pv5ZdClgoOqFRIsUroJDEYuWDvo/2Ws5/a8wSaBN94hA5IdR8eUw+xWD5sbivO8QZJox5PLJcdfellnDfHcVKgVOcoPhVCWizpGHYd+RzW4MuKY1zk+QSfExEE4fBjRinM/vNn30Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729853480; c=relaxed/simple;
	bh=RveC5jacooImmHBxMnm+SqvD0OPds08xgXiCC+fcXwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHSajN35sEfJQvoSPGLoQoeLVDTjXmkdB5+1yz5O//49TkQFZyDwW+2TTCLkRoYn9qEEZueOYW5jTS57YGkZOZCjxUcMUsgSmH7+GX3D45GarKRF/K9XCa9HE0jMuE0mxFsQYI1fjXq/mhJt7UJAi+cCEoJC/BFuFCsaf3DaMn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=b0S0/ROI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c8b557f91so15655675ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 03:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729853476; x=1730458276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8O+PQVPJ/vy+FUOPeA37d+cZZmUqt00r3pyhnqMSbPI=;
        b=b0S0/ROILeow1iJnD8ZCF2KFrGjYDzHh665t662YB2KCXqvEpAD1aac+sXa2BrxPG6
         zoesVrPz/2ixHXGmTfmyLAYUyr4VvgBnaCHxQfSdAnsIVPc8kGKqjXJU8almX6qSWlfL
         dleKArHemmgHuwekTGEMVihUl3pCZfnq6D0b8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729853476; x=1730458276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8O+PQVPJ/vy+FUOPeA37d+cZZmUqt00r3pyhnqMSbPI=;
        b=AJrW5JJwzRBn4UfV6QKn5Q9lr9aDDebLGFomSszDNkIJgnM4ETQ9AI6sXk9fOwyzCk
         B10+Qrm4R23u/JW0hGv+C18pa35WWairCn8J2Xme7PqUuYPpJsz62pD/ntWtjEB7PQD6
         uLfIgdvzz6Z8YcQb5cFPVEWOmV6usAyMlAmK8+QWH26BMDK72kp0hLM6DfKS+TxFfCsc
         rGygKVSJalnIhkLiGaBtVo0/T/KgAOldV4aerIi6hU0vwXnHH3/zRgXIFmhPrbrNWEj6
         PcozKTwPk268g1bxJ3MNlGBY+jehMjKuAQgR3DXTBJqtredWWI3oSjaSP5qYd8czeyeC
         /1Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVxTVX8Jlqzf4YVTdD6eZdif5e8R/fihZ+gNQlDxEMZaLVlx024c5ZQEU+ByiNRv9+YNJb7h5R1RTungks=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPrEyIzq4Uj1erEYuc01Pt79nfN+dOfohz3XS+gBjtlpa7vAYC
	umqG3eHw+WHWagrSjtO3wOLXRk8PpCwTzg7Wr+EfXJ7V/YZU2qU35ShrspEvgA==
X-Google-Smtp-Source: AGHT+IFZfuxzfCsukd1NHY0fOBAqzPX1aKEEz99SK5/ea2onRaS1TSBdTnV3NHaIcYuANRhG9C0GdA==
X-Received: by 2002:a17:903:22ca:b0:20c:8a91:3b43 with SMTP id d9443c01a7336-20fb98ea228mr64638325ad.16.1729853476260;
        Fri, 25 Oct 2024 03:51:16 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:bd37:bccf:f3e:a9ef])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc030809sm7326755ad.227.2024.10.25.03.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 03:51:15 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tomasz Figa <tfiga@google.com>
Subject: [PATCHv4 1/3] media: venus: fix enc/dec destruction order
Date: Fri, 25 Oct 2024 19:50:37 +0900
Message-ID: <20241025105104.723764-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241025105104.723764-1-senozhatsky@chromium.org>
References: <20241025105104.723764-1-senozhatsky@chromium.org>
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


