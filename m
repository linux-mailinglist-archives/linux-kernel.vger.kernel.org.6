Return-Path: <linux-kernel+bounces-287249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F95952557
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC181C20B28
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 22:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AC114A093;
	Wed, 14 Aug 2024 22:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QJ4rGgLN"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2565D149C43
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 22:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723673659; cv=none; b=MQEiUVW8fX7CPS4vxGyqjyPwaYmaLXYNld2md4fsrklzSykw3MDn2mOegPax7f4JzHPlsAYKSgTMAImCYi5lSPnhL/tyyiB4gvKboyv3qf6elsCnObjL5FX2XkW2TRCl5RO8BKz5+f2iPbQKQXEmey9RQ147MCvLS1HDAed7RRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723673659; c=relaxed/simple;
	bh=8gV0ItKrwqYDT8zD5KqT8goQykbTT6iJU2la2paZJck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BfpayFzIeukIwMa84/awmefehuLtF2mK3jpn3GZmqIk9QGuk/DAgJ4qgHOez4VPcKvzoqiKgtdcda2PmxJ9GcDmTd5KKS2WFlfCwrUUmjXSlBmptTKL68VX7GGA9IIbKnC6IOVz5HSa5kByfkzfLyI4uUgCTB6Cl8b2PdDHfHNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QJ4rGgLN; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc65329979so3518115ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723673655; x=1724278455; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EXHXVreezWNC5EHxJgjqT1mvVrC/aYQyKnBr40aFpQA=;
        b=QJ4rGgLNsP2HfzxSxzDmW4ZRtC/RPpF/olWsIC7au7j3oYQrc00rQckCUK+qGyq/HC
         2ekXkKlDcOC2vale51Ip/clnEZiXtSzGY4wAc3QjQ4lRe8E+1xMFbRx1fkzymkv1Ahkr
         g//HyasKlTxBUgnLloExSa6Apz/fxnMCA8w2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723673655; x=1724278455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXHXVreezWNC5EHxJgjqT1mvVrC/aYQyKnBr40aFpQA=;
        b=OCqSjFqvo/jsAmudP1KenT++gaaN6RBeboFXynHmuhUkOQ0/sbW+gaaZdMNAZHu7hu
         29xvVBKfPMbeyvtkla8smhISYjPdoDcf78o+uQWRomSYewfQVjv5ky0FQqK6SP4iI9co
         s+I8jaOJsDfxRbrZeYFb/BW/irIyFpldoRM6ywETs+1XDCaH3zAblsdstbtIukqbIJeV
         cQ/c33oVEBzzRlnPAHgdDyAPeboWTCKEAXcADKkEfwi41VSt8agjWWP5ZuP41HcVPJGs
         sNlYm6kf8wzcc0ajV+SBgGCBEgM32/7dQXaPkJhnDfB0Mm1RKb1ql5NSW6hDOaTX7VGr
         05WQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5dTD4iwd7FgBfdCN7w668YYQvm5FyloOtWzoOxEicG17v08r1cKAtwyM9Vu9NOHQzCHbce5Gs8luXAZ2f1yJ44vSKdA5AgBG/9B+1
X-Gm-Message-State: AOJu0YxcnAqjJ8IKSBTHcM9cxgrtS0u8dkF/ghlAhnSEKSYYrwj9Pw72
	8jX893MawGRuTd1yHgCifwpwjR0PkJt9/EEwN7/HtxwdsYuX2s5a+xtxF3c3Yw==
X-Google-Smtp-Source: AGHT+IG1dLi1vpHge3g4ia/y7OQ39uKNyxTgRTDNKEiBk3r+oe9MbbtSjtb2Ij3jgSmwRLV8Zw3NBQ==
X-Received: by 2002:a17:903:244e:b0:1fa:8f64:8b0d with SMTP id d9443c01a7336-201d63b3eb8mr58544065ad.4.1723673655410;
        Wed, 14 Aug 2024 15:14:15 -0700 (PDT)
Received: from zipper.pdx.corp.google.com ([2a00:79e0:2e13:6:aab8:3da7:4601:820d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0375725sm1046595ad.132.2024.08.14.15.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 15:14:14 -0700 (PDT)
From: Fritz Koenig <frkoenig@chromium.org>
Date: Wed, 14 Aug 2024 15:14:04 -0700
Subject: [PATCH v3 1/2] media: venus: Helper function for dynamically
 updating bitrate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-submit-v3-1-f7d05e3e8560@chromium.org>
References: <20240814-submit-v3-0-f7d05e3e8560@chromium.org>
In-Reply-To: <20240814-submit-v3-0-f7d05e3e8560@chromium.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: Nathan Hebert <nhebert@chromium.org>, linux-media@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Fritz Koenig <frkoenig@chromium.org>
X-Mailer: b4 0.13.0

Move the dynamic bitrate updating functionality to a separate function
so that it can be shared.

No functionality changes.

Signed-off-by: Fritz Koenig <frkoenig@chromium.org>
---
 drivers/media/platform/qcom/venus/venc_ctrls.c | 34 +++++++++++++++-----------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
index d9d2a293f3ef..3e1f6f26eddf 100644
--- a/drivers/media/platform/qcom/venus/venc_ctrls.c
+++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
@@ -67,12 +67,28 @@ static int venc_calc_bpframes(u32 gop_size, u32 conseq_b, u32 *bf, u32 *pf)
 	return 0;
 }
 
+static int dynamic_bitrate_update(struct venus_inst *inst, u32 bitrate,
+				  u32 layer_id)
+{
+	int ret = 0;
+
+	mutex_lock(&inst->lock);
+	if (inst->streamon_out && inst->streamon_cap) {
+		u32 ptype = HFI_PROPERTY_CONFIG_VENC_TARGET_BITRATE;
+		struct hfi_bitrate brate = { .bitrate = bitrate, .layer_id = layer_id };
+
+		ret = hfi_session_set_property(inst, ptype, &brate);
+	}
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
 static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct venus_inst *inst = ctrl_to_inst(ctrl);
 	struct venc_controls *ctr = &inst->controls.enc;
 	struct hfi_enable en = { .enable = 1 };
-	struct hfi_bitrate brate;
 	struct hfi_ltr_use ltr_use;
 	struct hfi_ltr_mark ltr_mark;
 	u32 bframes;
@@ -85,19 +101,9 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	case V4L2_CID_MPEG_VIDEO_BITRATE:
 		ctr->bitrate = ctrl->val;
-		mutex_lock(&inst->lock);
-		if (inst->streamon_out && inst->streamon_cap) {
-			ptype = HFI_PROPERTY_CONFIG_VENC_TARGET_BITRATE;
-			brate.bitrate = ctr->bitrate;
-			brate.layer_id = 0;
-
-			ret = hfi_session_set_property(inst, ptype, &brate);
-			if (ret) {
-				mutex_unlock(&inst->lock);
-				return ret;
-			}
-		}
-		mutex_unlock(&inst->lock);
+		ret = dynamic_bitrate_update(inst, ctr->bitrate, 0);
+		if (ret)
+			return ret;
 		break;
 	case V4L2_CID_MPEG_VIDEO_BITRATE_PEAK:
 		ctr->bitrate_peak = ctrl->val;

-- 
2.46.0.184.g6999bdac58-goog


