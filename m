Return-Path: <linux-kernel+bounces-171411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF828BE3FC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE0F2862CD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A50E179958;
	Tue,  7 May 2024 13:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nZYAGeqY"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D207316F837
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715087929; cv=none; b=IVVeJbyDZCdiQm4Yf21a1KoYxHoRu5j2Qz+xHw8ZIDvg5ZFmpYdMPnR2YmQYe0gkLlPGMPjXeOaHHLnl4QsqOvG319x2H1+glSqB38p5VsNiDFwtg0xtkHzsq03iVzl7bQUZuoihby6m4+Fpbuwfyy1XvuFpah4JiDuJvU2T780=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715087929; c=relaxed/simple;
	bh=elaKiW1ZWISf7j4z+HRijCG6vyiv0mxL1YyGQ0pIffU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=omFR3ImYfqSGZbnTz4k19cjLLKMTfe3JLEM7Bg8kjEuEBLzSH6KAwcC1Wubsi4OYwXZyPtjFE9D4zvx3cD5hcNGiNRrbqI2jIb8dzJ9KJ3ka2b3AU2BzubVIbqslWGk8WDXb9/cRm6Bu3Bb70QTv+gjavr4eA58ghfYWqsrrWzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nZYAGeqY; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c963880aecso1113079b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 06:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715087926; x=1715692726; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LytlgeivFEVadVFPCSFVFsEkz0aZMS5bY0SwfM06VYA=;
        b=nZYAGeqY3KsuXviL/MhKELUaufwc5kYqtWJO7OylzglCLXWkJHdLNCK6vbQqX/WS1E
         xHpXeaz9GtHx+TB9rqJLucFJT14yKWSOXxt1bE0otb8xib8e+S6cnGYJ4wE6epOsEqk5
         g8i0q7/DL65FJJLy5Ltj+3Sz2Lq8267JZY2Ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715087926; x=1715692726;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LytlgeivFEVadVFPCSFVFsEkz0aZMS5bY0SwfM06VYA=;
        b=G/s7Efyofk1lp6FLaxe/istVZkCtWVgOUBPRdFGWZgQmuFPGDKQWz8r/jqGnBnzIUe
         ojxMmTUVx9g8Zsqwhms6JQJg+cXK83R7Bguv20qZZVhq44OyxEdl6PQ7KgkAQ/1075xc
         Fe71zJyj8J51hvCOoLfx7/ZWV4OLsEtcK5dSg5mEpF5qb1e6R8rrKL95zwPykvsLu0he
         W2o3rPEkTwwh9LtHp8l53TU4WacXoegpkq6JYrxbykxUfq6LlVCuTflOWiH7KAhKLidg
         O+1uyyV7TcEgSLGKmWf5cLi2iJURDHHXTdpXilz/+0aK3JgcMQk32s48Bhusl88rwxOG
         8g9A==
X-Forwarded-Encrypted: i=1; AJvYcCWM+K20YdxwhP6QH34y1W8D/FD8cjye4sKvjC6t//TFsXgtMrl/nTduwMDhABHfZWfgNRZSJHkqYPK4Ahq7mYcEO6CI0PxjT/yVJJBO
X-Gm-Message-State: AOJu0YxhHzxBo+QSdDM/aqk+a2QQn3cYQDjyzPRS5k5bI9B1JzwNbmU+
	meBrNDDM1WerYuUD+gTS0B0fiCpA72wBKnljVuh6RtVyk94SOLRPbVRc5zrX1g==
X-Google-Smtp-Source: AGHT+IGZMw5Pha/VROCdriiOpH8uUYadLoc23B2z0lYFRFwtANajXpC+2XNhKb0eZC6xMtAWx6sdeA==
X-Received: by 2002:a05:6808:4d3:b0:3c9:70eb:151b with SMTP id a19-20020a05680804d300b003c970eb151bmr4342969oie.59.1715087925910;
        Tue, 07 May 2024 06:18:45 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id t15-20020a05621405cf00b006a0d19c3139sm4655105qvz.118.2024.05.07.06.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 06:18:45 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 07 May 2024 13:18:43 +0000
Subject: [PATCH 17/18] media: venus: Refactor hfi_session_fill_buffer_pkt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-cocci-flexarray-v1-17-4a421c21fd06@chromium.org>
References: <20240507-cocci-flexarray-v1-0-4a421c21fd06@chromium.org>
In-Reply-To: <20240507-cocci-flexarray-v1-0-4a421c21fd06@chromium.org>
To: Michael Tretter <m.tretter@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>, Andy Walls <awalls@md.metrocast.net>, 
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

The single data array data[1] is only used to save the extradata_size.
Replace it with a single element field.

This fixes the following cocci warning:
drivers/media/platform/qcom/venus/hfi_cmds.h:175:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi_cmds.c | 2 +-
 drivers/media/platform/qcom/venus/hfi_cmds.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
index c5123f2e76fe..35423e211ddd 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.c
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
@@ -331,7 +331,7 @@ int pkt_session_ftb(struct hfi_session_fill_buffer_pkt *pkt, void *cookie,
 	pkt->alloc_len = out_frame->alloc_len;
 	pkt->filled_len = out_frame->filled_len;
 	pkt->offset = out_frame->offset;
-	pkt->data[0] = out_frame->extradata_size;
+	pkt->extradata_size = out_frame->extradata_size;
 
 	return 0;
 }
diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
index cd7902743f62..0ccc4102ac3d 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.h
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
@@ -172,7 +172,7 @@ struct hfi_session_fill_buffer_pkt {
 	u32 output_tag;
 	u32 packet_buffer;
 	u32 extradata_buffer;
-	u32 data[1];
+	u32 extradata_size;
 };
 
 struct hfi_session_flush_pkt {

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


