Return-Path: <linux-kernel+bounces-204342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C17168FE775
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CCC21F27325
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB85D196C79;
	Thu,  6 Jun 2024 13:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NvYMBhPb"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1B2195B34
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679855; cv=none; b=F1XDn82Eoxx19xJNhHyxLFcvyJimwx/QcMwLa1ndcugvDH32lGHx951zk/k3IUdgdDx/uwiJ6yHJ4d8EfSSnM6wbWLHsa6fPG3CELpovd+IOWYsXMVCR5LLBVYOEAhrYfPQGloBcg77M/VRJ3uf5gtxKmjtsltIMUjaLv2zTYHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679855; c=relaxed/simple;
	bh=9Ex/psXstRZqGMxxPJ0VpkCq64t7rGKg+zLLyU8qbQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d/ubcXedFIkXevZERYnMYA8q/zBEG7+vk7tmZnyvPFtOlxWdkN2k0CduYDKXY94WcnDQejRi7iua1/xG4uoe2RcpqhYHL3UmznBgWSmPj2/LU4lf26kByMPmAppR9hLtwi1jF6V6+8yKLoEZ3lzSJ+U6gRzZFcXPzT6uMfP0OUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NvYMBhPb; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5ba6c41e1a7so524878eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717679850; x=1718284650; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AAL4006xAnRJyzvWwdXcDdqMP35ODneV2/4JxIJoTYE=;
        b=NvYMBhPbL4ddCR1Xdo0TVjY2+0mkBDXcQoJmDaBfuAgBEBD5KBI+0Vy9Ew7LZ3U64g
         gqGYDYnPcUh6vAl+FOBCQdz9IbPMcv32KFFTjVy5vxB7Y0wv7ovxcZgmcRTNmJFVjL00
         7szNGD1s7aojdVbkjcCPwbxa2KzrH/8JTxr2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717679850; x=1718284650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AAL4006xAnRJyzvWwdXcDdqMP35ODneV2/4JxIJoTYE=;
        b=DOcevrhSEmXjDqbwi3jbOxskY+vMhjH0mHd5VU54muxy4s+OI5U8KRVtkWuVPCHvkZ
         bduPv4X/adugHgwA/iFyq54qc8JhMCW1nr7JdE3ERtE5X3DlG0AQH057AljeXY9j1HtV
         3vC20WsAmkkHxuxdrPvl6q2VzYPLf5HXlBAP+OHlIVgDHYR6u0lbgF+/rCDp6mHd3q2n
         48ojAwSVgKvo7qGvKFMroWjNCh9vP64xUOdM0mPoTWxfGuucQYGE5QHdjrNu3y1yGaSQ
         UjVfHYbUzNlPTdThSpst3uQ5bBE1daneJjQ+DSVItNFrNXlX3zN/4BPbQtcGoasyAxSK
         hBKg==
X-Forwarded-Encrypted: i=1; AJvYcCUi9mCqxgDzkm9x8IMLjDM4DWhbBdy8U9Jt2FxAKpaYKT21K2kRGkv5DtfsJCxDV+kWIHLEmn0taxBlM32WnP1SoMuf5DKV0kRGCfLt
X-Gm-Message-State: AOJu0YwQ6hnz1jaZ+F89CectVcaHihgdEkYJPu8llhmC3U9JJHG5Sw/o
	DsQJi8xMGtDnQ5BmHiW6XSCsJpdIqi44qfeelZqJyPKO2tyuIB72oefLV9RfATrADiXD9bWNg+p
	MOIsJ
X-Google-Smtp-Source: AGHT+IFMfHqWudPNwZ7gEE3WDMg2/DCijf/SGmLWSwqmxlW9rIKDz6JeqdjExEkt/BTcjfNpWLogIg==
X-Received: by 2002:a05:6358:2609:b0:199:2b63:9f42 with SMTP id e5c5f4694b2df-19c6c68a2femr652957255d.10.1717679850292;
        Thu, 06 Jun 2024 06:17:30 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f6607f5sm6118036d6.31.2024.06.06.06.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 06:17:29 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 06 Jun 2024 13:16:35 +0000
Subject: [PATCH v4 01/11] media: dvb-frontend/mxl5xx: Refactor struct
 MBIN_FILE_T and MBIN_SEGMENT_T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-cocci-flexarray-v4-1-3379ee5eed28@chromium.org>
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

Replace the older style one-element array with a flexible array member.
There does not seem to be any allocation for these structs in the code, so
no more code changes are required.

The following cocci warnings are fixed:
drivers/media/dvb-frontends/mxl5xx_defs.h:182:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/dvb-frontends/mxl5xx_defs.h:171:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/dvb-frontends/mxl5xx_defs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/mxl5xx_defs.h b/drivers/media/dvb-frontends/mxl5xx_defs.h
index 097271f73740..bf08d82ba2cc 100644
--- a/drivers/media/dvb-frontends/mxl5xx_defs.h
+++ b/drivers/media/dvb-frontends/mxl5xx_defs.h
@@ -168,7 +168,7 @@ struct MBIN_FILE_HEADER_T {
 
 struct MBIN_FILE_T {
 	struct MBIN_FILE_HEADER_T header;
-	u8 data[1];
+	u8 data[];
 };
 
 struct MBIN_SEGMENT_HEADER_T {
@@ -179,7 +179,7 @@ struct MBIN_SEGMENT_HEADER_T {
 
 struct MBIN_SEGMENT_T {
 	struct MBIN_SEGMENT_HEADER_T header;
-	u8 data[1];
+	u8 data[];
 };
 
 enum MXL_CMD_TYPE_E { MXL_CMD_WRITE = 0, MXL_CMD_READ };

-- 
2.45.2.505.gda0bf45e8d-goog


