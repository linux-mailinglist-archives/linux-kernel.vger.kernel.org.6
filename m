Return-Path: <linux-kernel+bounces-204345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9076F8FE77C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E53A1F27042
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA94197500;
	Thu,  6 Jun 2024 13:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UkKa/XJl"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47E9196C7C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679857; cv=none; b=AbGm83tfq7JguWePaqgmUEcMVa7/H+k+CwhC7jqZUNhP2BKVr4ar5sFxuVh+fjw9Non8cnZFtIgEw2bLFfApmurj2XQ0HQnqikGU1U1nuWKV1h0KxE370OAPZE+u4L5Q0JX2SqjcHuaiZA7KTLAsxxtB+RB5Ibkni+w4Fn3r+PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679857; c=relaxed/simple;
	bh=q/yIjMSqnXj8v7L7GkQC3K27otk7HPW5heUqxBmLTVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=isX+32bpoAs/KtLyeMv+GswDxC/Kn3tVhWhKsq3p5Xe4zKQZSE+DsitaNC/kRqCpi3s3WTsSW0ue6jEytsFCjH2FjTgQHCZ+WzHkkQ/MtjA1KxOSvUE6n1qQj02ENKdbl29oyBYOsqOaEroN35FKotAQQ+wlXaksh8b+UyYR/mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UkKa/XJl; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6afbadc33e8so5163506d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717679855; x=1718284655; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e2AAUOSqY0VuuUiDfECnNkpzmbnAcXOGiikRuWRSAa4=;
        b=UkKa/XJlLcI5Ssyawo/sbucMPb9oT0FmCygLPm740rx/AcjqYX++l6CaF6nYEkSLZ4
         CyxYLm0jWtaboiQXA4KL+w62uvipVV1pstDxFK/us1gRV12IDaLlj8k1OqSp3MWfu8nv
         Q4WdCbzl9rY85sr8hcO18Mq/E5nB1v0P46+RI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717679855; x=1718284655;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2AAUOSqY0VuuUiDfECnNkpzmbnAcXOGiikRuWRSAa4=;
        b=KIo0UrDzEEdD1+N3hjScKghmKiSFE2PaJlNU5PMUZOVdBcEWiRPd9imJNpE2BxWghe
         NheEENjvjApnhv5OBKegjlj3437E232+S7IGhT1Bk/5r3n1P5cC0auhAPDk546Kw78bk
         /lSQYixaM/at1oiks8wAjwaQfRPT4M/bpcV3FMnt5vLMG8DKpZwjEsp4wiVIRRbKFWgK
         gvyhWQWISH9r8PSFm+pSFPGHUGT1zVL6UqGZQPcGHbtZu5MOrlS4NHSTcsCTwBgHlHSo
         XISC8ZoSsXWCSVq9j91oYIPtULmgejhEkW2C+7J4zX0AfuCfpCPS3btEfLyMDk28aziW
         HABw==
X-Forwarded-Encrypted: i=1; AJvYcCVwIKYrmFNam2+yQASp3mfxjm+BlY2tr9hDSGAN545M/WTltdNtp8Nx41243r1yFzDBn7Xwv5YM4O182+V5emteWZa+BDaY+8cuDO6P
X-Gm-Message-State: AOJu0YzYjINEvc3N9TqS7VRIQBRhwXQzdxoJ0w1Rb+ysH2om+QHZG02c
	Xo/Mg+01gnngL1lwe9vo2lkoH1YFo9fzlLiZ3YhC/VjEC4JToPEY/ipYK6uQwg==
X-Google-Smtp-Source: AGHT+IF2SHvoVvYn/P2leNQvN1o8bRfjg6tCknHvek81SGWfjCxGxX7kcfXDgqQa2sakPR4YvGy8vg==
X-Received: by 2002:a05:6214:3d8b:b0:6a9:b253:58d5 with SMTP id 6a1803df08f44-6b02bf1eb0amr54587866d6.17.1717679854725;
        Thu, 06 Jun 2024 06:17:34 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f6607f5sm6118036d6.31.2024.06.06.06.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 06:17:34 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 06 Jun 2024 13:16:39 +0000
Subject: [PATCH v4 05/11] media: venus: Refactor struct
 hfi_session_get_property_pkt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-cocci-flexarray-v4-5-3379ee5eed28@chromium.org>
References: <20240606-cocci-flexarray-v4-0-3379ee5eed28@chromium.org>
In-Reply-To: <20240606-cocci-flexarray-v4-0-3379ee5eed28@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

The struct hfi_session_get_property_pkt is always used to fectch a
single property. Make that explicit in the code and avoid a single
element array at the end of the struct.

This change fixes the following cocci warning:
drivers/media/platform/qcom/venus/hfi_cmds.h:194:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi_cmds.c | 4 ++--
 drivers/media/platform/qcom/venus/hfi_cmds.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
index 3418d2dd9371..75f4a3d3e748 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.c
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
@@ -402,7 +402,7 @@ static int pkt_session_get_property_1x(struct hfi_session_get_property_pkt *pkt,
 	pkt->shdr.hdr.pkt_type = HFI_CMD_SESSION_GET_PROPERTY;
 	pkt->shdr.session_id = hash32_ptr(cookie);
 	pkt->num_properties = 1;
-	pkt->data[0] = ptype;
+	pkt->data = ptype;
 
 	return 0;
 }
@@ -1110,7 +1110,7 @@ pkt_session_get_property_3xx(struct hfi_session_get_property_pkt *pkt,
 
 	switch (ptype) {
 	case HFI_PROPERTY_CONFIG_VDEC_ENTROPY:
-		pkt->data[0] = HFI_PROPERTY_CONFIG_VDEC_ENTROPY;
+		pkt->data = HFI_PROPERTY_CONFIG_VDEC_ENTROPY;
 		break;
 	default:
 		ret = pkt_session_get_property_1x(pkt, cookie, ptype);
diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
index 6dff949c4402..f5708fdfb197 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.h
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
@@ -191,7 +191,7 @@ struct hfi_session_resume_pkt {
 struct hfi_session_get_property_pkt {
 	struct hfi_session_hdr_pkt shdr;
 	u32 num_properties;
-	u32 data[1];
+	u32 data;
 };
 
 struct hfi_session_release_buffer_pkt {

-- 
2.45.2.505.gda0bf45e8d-goog


