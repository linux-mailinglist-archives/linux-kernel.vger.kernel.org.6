Return-Path: <linux-kernel+bounces-286367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DC3951A21
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DDA81F22778
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8531B32AB;
	Wed, 14 Aug 2024 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bnorKWXa"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0248F1B150A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635576; cv=none; b=n+YqtB66CLaBy76K1krP30JK9ug3CpjnAKkC1HdwMpOSvKLV9c0UHEXi8wnOewDTxPXV/m1BTXEuITSVSQLqL4TX37QfOWgFC2ufLfM4dGorJY401SkxH1ZuFDyr5rFwFBFm+NBARU/Q+PXK5oKDRkNOx4TXVjBxJo45PYTm010=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635576; c=relaxed/simple;
	bh=gk4QNEzmTFA+fqvMiqWZtz5y8Ao9GZS0y5Lg+TJlg/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VBeN1Db68BXG9bhSo9CKZI++npOk21mrrXhT+RZ+arKI7YZEg44LJM2ZBDXEnNlH4WOgWKjNnJVoFAM/VEcxfGKBkiK10I8gz5IIK3ltpMLUw2WxGQGSXMSNF4W6odixx5budLMKoc5HXWxdy5ETQen8lJwnxEfIiZc2vNVEWFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bnorKWXa; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b7a36f26f3so6953716d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723635574; x=1724240374; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZhV7hkPV5YlSdrc3t2vELDUUGpk4drcpL8ab8KCXVM=;
        b=bnorKWXaAvYFa9Jz8Nc9eaADLQPX6cQwIzLrPwWDeKMUajrTuFM1e3qqhyfLiDJPkX
         P3aptWaC3SB5e8y0PQTsfNEpSrQXLbhpj/dt9Mvrm/eKP1tJVP7bPf8i1mSxn+GmZ4Ul
         wRB/uisJx1gM+WVJ4Qh47xzpc2pMtZSuueZwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723635574; x=1724240374;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZhV7hkPV5YlSdrc3t2vELDUUGpk4drcpL8ab8KCXVM=;
        b=uVKrNmaWd0CAFcpta0XRBKsD8fjHtGn3FH8fdrRGdUb0dTWapRZkG91Qxna4wqZudd
         QhNBBX8TRGObbt+9zfij+tnhcB7BvGL7EXO10dqBg2YoGi/gGTYDfWgNH1gwNwYaRkCY
         U6AeFlQ8xvj0sbQxNKjoa1nlELe4M9wgTkDnmCJN6l/ZpXmmMi+1A4ndt/jc62g+G4bB
         vDC38wF5OhHxFH8ToOsZzce+nSA9ocBb2kX7EYgiW5/bBNmfBA6pRfMtDx1K5GJm7VE+
         kSJf/rkYCc7GY/dW+vCnIj8HKlwvlAJFdbUKK9vhGYIJ0uZhDudNjSwVRZBgpMBbAzJx
         Ifaw==
X-Forwarded-Encrypted: i=1; AJvYcCW4/jbfGbCaePjT71Fw6cryCwk3RSrwE02pBGsJafuxgBwBHdIom7GyMRlYbY6GVDn65JteSgdtN+pOS7x2VOoT/Ih2PwfTH2C7jQjq
X-Gm-Message-State: AOJu0YzH0vOY8OT1tKVxTIS4McvqNc9YUx/4gN1C0VMkDui880vJKvZm
	0UGd8KxPv0aKK4cKJNHuNvqKtS5eOJJpXJFFDwA7WvYfKZxpqfVAlZEOXTLXPw==
X-Google-Smtp-Source: AGHT+IHU2rwzo/jfsznQsavVkiDnzev6AHoPcWEldqEoikU9zq/6RhKey9BfzttvpRF+80edEWKwPQ==
X-Received: by 2002:a05:6214:3bc3:b0:6b5:2f57:1a63 with SMTP id 6a1803df08f44-6bf5fa5be80mr30493486d6.21.1723635573948;
        Wed, 14 Aug 2024 04:39:33 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82ca0daasm42167916d6.68.2024.08.14.04.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 04:39:32 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 14 Aug 2024 11:39:27 +0000
Subject: [PATCH v7 07/10] media: venus: Refactor hfi_sys_get_property_pkt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-cocci-flexarray-v7-7-8a1cc09ae6c4@chromium.org>
References: <20240814-cocci-flexarray-v7-0-8a1cc09ae6c4@chromium.org>
In-Reply-To: <20240814-cocci-flexarray-v7-0-8a1cc09ae6c4@chromium.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Replace a single length element array with an element.

This fixes the following cocci warning:
drivers/media/platform/qcom/venus/hfi_cmds.h:77:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Acked-by: Vikash Garodia <quic_vgarodia@quicinc.com>
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
index de0bf2399505..615ac8d156a5 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.h
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
@@ -74,7 +74,7 @@ struct hfi_sys_set_property_pkt {
 struct hfi_sys_get_property_pkt {
 	struct hfi_pkt_hdr hdr;
 	u32 num_properties;
-	u32 data[1];
+	u32 data;
 };
 
 struct hfi_sys_set_buffers_pkt {

-- 
2.46.0.76.ge559c4bf1a-goog


