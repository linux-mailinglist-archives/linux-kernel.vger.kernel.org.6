Return-Path: <linux-kernel+bounces-219489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FAD90D353
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14AC1C2497D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917521741F3;
	Tue, 18 Jun 2024 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h/q7QLM6"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D006B16A937
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717881; cv=none; b=rmUuhNkJ/stptnsQCr7Ch8Ru54FgfgboReqkVcX/tCPVyYKlogcz4ChHkpeRQN0yjtEQS5cbljbogZfzozi9gnEjAWEE17rqbhCKt2AL3I9f5f1s/KwkIxaVEo/suSDPD5usbvA++vg8wksjH60m2U4AoLoHQbPfXaEBO6porIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717881; c=relaxed/simple;
	bh=DZjQ6FV3T2FW/P5dZ/rmnh+9n/L8e1/dcKMQojAHidA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SPftZlRa/rB0rvOjh4iJGvhHVOyBBdWuG+X5vZUMGuSkDUirlJ4cSz1sL2aqDmqLJ2QgI4KcAXXkdy3I4U5X/FFufVMCO+zc7CFgSAOAbdqmBlRN0amC8JgRF7q5AkPgQPEf0pz+Hn5NGuE25vK4SlYP+2Iye6A5rIB7n36lQRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h/q7QLM6; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-250671a1bc7so2597350fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718717879; x=1719322679; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A2IFt2EVdi+gZJF4jowtvIlbB+KtHxr9PizWbsBiOL8=;
        b=h/q7QLM6kNjjkD99jkS7jDZvS4Ma4njXAHHAZcMhibE7R4o4NN/sCtPdmK51Lk7snj
         YlOalbEqWwDmgiwNUnPbBuP/m4fW7QNTRocFM7XWxEMNvYUPvc8U8Hm1uboUpxuBebR5
         pyL5NN6H3hpIm/vX6VhE4NaWq7fd3SWlsRqCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718717879; x=1719322679;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2IFt2EVdi+gZJF4jowtvIlbB+KtHxr9PizWbsBiOL8=;
        b=D/RT0ipsXdoFqI0RN2N4iHufvsfFb2j7RxeXurbFo2saEIAgdvLbCspIh8WqGc0p6C
         hxd7u684UVzdY76DEySBlSedKeCiKK02o3XiwMb4uAMdtSrIenZr4lzh8beeb108nx66
         87/0mJP3QwslFeu9dMmFnMxQ2DOY4UFpzgp+ZK3HP79NgqHrFsWhnxfXaiRlviJn0wHk
         A9PdfoWTlgM+hcVcMWLl8ucuW7baYnnMb+v53yp/Se2NG0xiDwS3QQ19ThNFGH9RP9fF
         wplvu++FPPFtQkF4ZCErECiNSC5oIiTZFjtfin/Vo7Y6kATkYd+ww63+rO2mKrocdkYl
         KVSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW91EAbpHgQhSGQLjuo+FK/aXSKoz7ZlWNqr4o0xNuXXCD4+b8m4QzzZpPYDbU4g3wOLxJ2vR07rp7O93uhwa/gjrrm1lp92jX06ixs
X-Gm-Message-State: AOJu0YxTVYzR0vhDNATqHzNmClLthMztkucomwiEb4DTcgO6NbSDvFcX
	rVJum+WH8bLHlFcA/Op1F6WeBzXf3jQiYFjQFf5w+KhI3b7OGnv8ykNm8NSenw==
X-Google-Smtp-Source: AGHT+IFGZzzKWBOJ8T4ois2QX+pNAsJoUQREamSXoXS7bchmzONZY4R+JRX9+M2w5xew57/NtISAyA==
X-Received: by 2002:a05:6870:7b4c:b0:259:8b4e:e71a with SMTP id 586e51a60fabf-2598b4f0ac6mr606072fac.46.1718717878982;
        Tue, 18 Jun 2024 06:37:58 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abc06e93sm521666385a.82.2024.06.18.06.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 06:37:58 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 18 Jun 2024 13:37:52 +0000
Subject: [PATCH v5 09/10] media: venus: Refactor
 hfi_session_fill_buffer_pkt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-cocci-flexarray-v5-9-6a8294942f48@chromium.org>
References: <20240618-cocci-flexarray-v5-0-6a8294942f48@chromium.org>
In-Reply-To: <20240618-cocci-flexarray-v5-0-6a8294942f48@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

The single data array data[1] is only used to save the extradata_size.
Replace it with a single element field.

This fixes the following cocci warning:
drivers/media/platform/qcom/venus/hfi_cmds.h:175:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Acked-by: Vikash Garodia <quic_vgarodia@quicinc.com>
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
2.45.2.627.g7a2c4fd464-goog


