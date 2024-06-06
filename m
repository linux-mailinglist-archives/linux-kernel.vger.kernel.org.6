Return-Path: <linux-kernel+bounces-204349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6F58FE78A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5109285749
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC5919884D;
	Thu,  6 Jun 2024 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hBvkXsXa"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4112F197A86
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679863; cv=none; b=R8JKSW/x5qTBg4v3wOzKYKuMvbro05YdFBlAmzcFPQcWw2AUDAgvPvLRWt8Odd+1yHWg+Y3eWOpLLjF1IHfl93/Yfn66FBqygwrQJqoqgzYE2a/2Mps4zLvjJ8whpLyCDy/fnt0hikKkrgyLQx3qo+SUU2ZasBbWPuvfkDGXvnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679863; c=relaxed/simple;
	bh=AWMP5+BquLDtzLKwUlgSS7VtSoQfhl9NrOwjnGNd7WI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=on3MBUX8rlTjwiQAgHkthTreZJ9ff43ekpNW+b8RP0M00AjB8aJIjnuZy1Df9yT1BgeHVv9M6JjHVr8Jz77AItxo478rsRIciZFxBDnlK0N5brsdWcxrD35bdZdeCPUh1v018wwYFRejqAwIxdkc7qONWPJNcdNHd5DtzrCTM1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hBvkXsXa; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-43fdb114e07so3977961cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717679861; x=1718284661; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ox++ObHoucj04Nng5whrLexOcEwZLp6Wnb/NRj7bOEs=;
        b=hBvkXsXaGc8ztZwyZdsJtflSByqW+KORAWXRGhyLbOagYTMp8aHnmY9HcV+JCPLtnM
         83YMLcZXDyMC5n9g6dW/ypqZHCeZZOBLwJy9D67FL87T4OS5cNXeEhlqUFqq8FnnwwXL
         /O9LuvK7Hli26AzPKpFkHi63RAZtj7QSyhByo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717679861; x=1718284661;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ox++ObHoucj04Nng5whrLexOcEwZLp6Wnb/NRj7bOEs=;
        b=XsQGn5TyIv2Pq9FtffFViHhLbGR5MeoXTPLPMYiX5SOO4WmgWnjTS0Oi4rqlIihf0u
         AltaXVbLe6dCsWt9Mk0PA9oIN6Agd79ZXEengLYEo5U6eTPdM0tFDea5F7UKMLfO1JUL
         TMlAKmizAuyUmzT9/ZPWFBKC1HSNhEyZ1Itrsg0O5h3z0TxfmP5uKkP7AV/PGAvfW/uN
         gLMm/ENTzZIOHBNqUvYERBiuflSCYzcjzKvRXAGRsgdzydhzRYdfv5anjZpiTw+e8Ldn
         coD0+aOvdfvU6g8JEGMdeokYz1eYZZR56b0Dn6W3WURl4Drccosuhzq2SvUBuf1pErFV
         YA+w==
X-Forwarded-Encrypted: i=1; AJvYcCUrC592wF4FYXb/c/xN+wEbahNwAWLI/4nUvmBdzcDGWFw2kB+IaqWx7ku8PHKm1eQnDkOibxAaKWtK2afBvVfBIRLM8ZSe8SgJjN1n
X-Gm-Message-State: AOJu0YwAWwcfOMCSNn/so7Ma/9fdLBigw4dotQ0RaRqr1Dtcj8okCoLr
	RegTp72rhqAsqjIQjpCze7ML3Sao9ILFR9oGeqop383prnt3zdeg6mnYmCuf2w==
X-Google-Smtp-Source: AGHT+IFzv3hWSZczWB+TZSLeuXfXc1Q2NFlWyqPdthC4uOD9GBvoBOQzGOjMlXNfaGf9AaNt1yvmQA==
X-Received: by 2002:a05:6214:4806:b0:6ae:47b1:58a with SMTP id 6a1803df08f44-6b013913980mr61775836d6.0.1717679861047;
        Thu, 06 Jun 2024 06:17:41 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f6607f5sm6118036d6.31.2024.06.06.06.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 06:17:40 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 06 Jun 2024 13:16:43 +0000
Subject: [PATCH v4 09/11] media: venus: Refactor hfi_sys_get_property_pkt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-cocci-flexarray-v4-9-3379ee5eed28@chromium.org>
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

Replace a single length element array with an element.

This fixes the following cocci warning:
drivers/media/platform/qcom/venus/hfi_cmds.h:77:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi_cmds.c | 2 +-
 drivers/media/platform/qcom/venus/hfi_cmds.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
index 75f4a3d3e748..0a4de8ca1df5 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.c
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
@@ -156,7 +156,7 @@ void pkt_sys_image_version(struct hfi_sys_get_property_pkt *pkt)
 	pkt->hdr.size = sizeof(*pkt);
 	pkt->hdr.pkt_type = HFI_CMD_SYS_GET_PROPERTY;
 	pkt->num_properties = 1;
-	pkt->data[0] = HFI_PROPERTY_SYS_IMAGE_VERSION;
+	pkt->data = HFI_PROPERTY_SYS_IMAGE_VERSION;
 }
 
 int pkt_session_init(struct hfi_session_init_pkt *pkt, void *cookie,
diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
index 2c56ae303989..f91bc9087643 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.h
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
@@ -74,7 +74,7 @@ struct hfi_sys_set_property_pkt {
 struct hfi_sys_get_property_pkt {
 	struct hfi_pkt_hdr hdr;
 	u32 num_properties;
-	u32 data[1];
+	u32 data;
 };
 
 struct hfi_sys_ping_pkt {

-- 
2.45.2.505.gda0bf45e8d-goog


