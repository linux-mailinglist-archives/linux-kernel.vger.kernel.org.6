Return-Path: <linux-kernel+bounces-204350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B50648FE78C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D061F225E1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227CB198A19;
	Thu,  6 Jun 2024 13:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B0m2W8Yc"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07037197A98
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679864; cv=none; b=QVSulw1ucrAiVv5SgaeA5oll8hQTpMVM4YYt4m3o08+8h4+36/yoOaRsoXWGiHncyUzsQf3aR2CUXZ4LqRSgEvx1MwnNBVlkK10eh3z/mWR9j0cy4gD7p/qH8egUUT+wNMPSsJjZwsHUyKUNBlLFuBtnuXOKLvH5J+f8NDFaoQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679864; c=relaxed/simple;
	bh=/NolsqpFl438TCqFo9LQEcg+v+sNSkqQj0PpqvI4hys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=duuPZ71eA2IR4pUeex0jGKNTqyMrvusssBt1+cMbKvNQd8J1bAmr1H1Flz4cYnlGoaDYQD5hKcaFNMfq0RLHa+06iY17H8u04PFe4AnjTsg5GJIrF70LObQl3BDrqs/YxEzOhVUR8Dzu5CxXWNzoOKkD0tLTiKcGeC65dlBlSq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B0m2W8Yc; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b97b5822d8so389256eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717679862; x=1718284662; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9kZibIjO2Z4ZCSJlx2Ohq41MEqbhxGGlKtW/qmnnTcc=;
        b=B0m2W8YcCHfDC4u1Xmsgo73tUGvDyueDVroXxO9OL8c342QQY+D0w+AqzlzB+FSepg
         VYNOz4WDZiEH6usVHvTAWUl3MOIQ2nEr/4wmyDbdflv7Al9aaOvfC1TVesXa5ePhTpEz
         BgPlKq1RuHWbcY9EjEXv2fZG+eB8iT8cj61eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717679862; x=1718284662;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kZibIjO2Z4ZCSJlx2Ohq41MEqbhxGGlKtW/qmnnTcc=;
        b=L+TOalEJvKBGQa1NY9Auh9TzIYEts+YQQmjF0ycMcDQJJFMskZisIhcD1vwD8BxtV8
         3XWEoYsv429OPCXpph0tiSR6NG6YzYxQfC73ttKla+PaabuNl+f1IAmTjFTGdfn/dvA7
         Y496pmWPnBq2mbMEvynvT6FXvuzkBgidpLrL2BdB2KaKs/8r7pf5WFMrzDzteBQId+R0
         cVkJS7MSfhRdUakjpnRbleo8aBGbTKbS+4454eGW6UxWRmSTg5Z1EKOKEydn09PruwEC
         9i6AotYU74Kqgnnth4jec28z3zpSq8QWi6dzr0L8D1UzAENMoeTyPEAYdQgo6ZN0uuav
         uIgg==
X-Forwarded-Encrypted: i=1; AJvYcCVOIlMGZGPH1Nl5pFLtkGDzsnP6HpysgQPXZZeOcjTuF9biVtKlh4uE5N0ghEc6hM29nwcPaHDte5Aa6zawf9N8J29HiSqVZGt+/RGH
X-Gm-Message-State: AOJu0YyTnCKbnCSScnS3ZfUCfIBspOTy6UmURxOg/35MtJDhr/BYSUBi
	MBH0l3QJnEz53gn03D4+h765CB9ah7/NDy59EHAgZIW5AH/sAxWUjj/1x2JsVQ==
X-Google-Smtp-Source: AGHT+IEGO3j4JeIIT057xPo5p1aauD1hqTN0PU5iBBrHrF1scvkyvtDkNWbpsNVMkjbf/7njNIrIMA==
X-Received: by 2002:a05:6358:72a:b0:19f:13dd:b7a7 with SMTP id e5c5f4694b2df-19f13ddbb03mr111660555d.29.1717679862024;
        Thu, 06 Jun 2024 06:17:42 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f6607f5sm6118036d6.31.2024.06.06.06.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 06:17:41 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 06 Jun 2024 13:16:44 +0000
Subject: [PATCH v4 10/11] media: venus: Refactor
 hfi_session_fill_buffer_pkt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-cocci-flexarray-v4-10-3379ee5eed28@chromium.org>
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

The single data array data[1] is only used to save the extradata_size.
Replace it with a single element field.

This fixes the following cocci warning:
drivers/media/platform/qcom/venus/hfi_cmds.h:175:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi_cmds.c | 2 +-
 drivers/media/platform/qcom/venus/hfi_cmds.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
index 0a4de8ca1df5..3ae063094e3e 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.c
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
@@ -331,7 +331,7 @@ int pkt_session_ftb(struct hfi_session_fill_buffer_pkt *pkt, void *cookie,
 	pkt->alloc_len = out_frame->alloc_len;
 	pkt->filled_len = out_frame->filled_len;
 	pkt->offset = out_frame->offset;
-	pkt->data[0] = out_frame->extradata_size;
+	pkt->data = out_frame->extradata_size;
 
 	return 0;
 }
diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
index f91bc9087643..daba45720ddc 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.h
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
@@ -172,7 +172,7 @@ struct hfi_session_fill_buffer_pkt {
 	u32 output_tag;
 	u32 packet_buffer;
 	u32 extradata_buffer;
-	u32 data[1];
+	u32 data;
 };
 
 struct hfi_session_flush_pkt {

-- 
2.45.2.505.gda0bf45e8d-goog


