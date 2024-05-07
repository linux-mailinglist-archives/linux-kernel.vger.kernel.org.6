Return-Path: <linux-kernel+bounces-171814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFAB8BE908
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D6C1F2193D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C64173320;
	Tue,  7 May 2024 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VVhua+f2"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE55316F836
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099245; cv=none; b=n3+WaHnaOVaBf390tkYuD4Y8TZJy+3Gr17aaYL6u2StIcOeMmBUgAsdfsu4Co9MBS8lT9usfcBIMd1u6oBj85wg0hnpAFwmn5k5HYIFj4JUAwqKH+SiOV9VbtBA32MA02r3Z3/UNHieU/7YKNRyy7VGFeaniCWBlZFB0S7+CUqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099245; c=relaxed/simple;
	bh=P3Bstv/vPDiw+M+/G70Utl3bAIKOevXPnXzJX41+MtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oQBIYB6GeFVmL/VoZROtXHLkbrIr4EeSz/imF9yooj7zsnV4qaY6RrKPDhQxiGG0cEfxwl4TX/KjWXUiTFQ+vMbTFlBAkai4foiGfzzWWqgKO1PbAxq1GdY3oHymQOMFyzZEkpGVpcYDSxeWfJxNKif59n80ESU26Cjf62a3j+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VVhua+f2; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43ad4097aefso10278811cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 09:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715099243; x=1715704043; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AxOzymIGy9oIqpVIjgGXcOBfnvf3rPmoINBWnjxn4+k=;
        b=VVhua+f2IRXtWZm+z2Ufi8G5EGsfSiIA5IyT/ME88xa87qP99xZm8fXUJXyPEJSpkZ
         69D93gy9FlyCa2/++yv9qeL2jWnyKnVXaex1/IXCh8AYJlM5tmHUVze64Sgxg5o52nGk
         Sdav2TsI0a2gIboyQE+C4ZRc9pzpK82o+k7jE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715099243; x=1715704043;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxOzymIGy9oIqpVIjgGXcOBfnvf3rPmoINBWnjxn4+k=;
        b=AzWZuShTwKYIaNRRRv+Esih4kOU/VYiN/iTQQh3INZwYPp8zCT7dPDg7ZXb0Pitu+H
         4VwZGtFAReBbXGDO6WGBc2Omvb3Qa8FkSvJldCDLy7l/LHfbw3APH4j76S8wnbRmu/op
         ikxfhthNxmHTSeUrWLcxfTlUduWMwgWeykgTMvOY8ito1Ju5t68EPkKfwk9JHeIjAFAp
         wINYTLx8I8sYds9oiiGzcTxSXCUpGWfSHFTIaUgUBQWOQfs9wtTQMWlZ0Xznuj0wAq4f
         OHOJzhIRckFtpwPLh9+OY8jjMU/lz+i6EMNdDl8Ou+mSkJ9TblaZsnXkmH9+iGeCq5I8
         EAQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqDvehoH9pWuai5meec1G/8NPCuu4WRfyGuTkvxX7qT7iQ6fIZSdLk+qGtPcqJiU8IRufTdrnUq2HKQLwXm683o53yIBXLpjrBAmuz
X-Gm-Message-State: AOJu0YxkzqotHyJpB9KsPvcOmbKiXYomuioYd+Mk52RWnU59sWIVt+JQ
	Amt7zSZQdutE7FvDOyY8Am4qVp+fKasnniuDBFJXHzB4DyOlCL8Y9F14WnMWfvA5yGANkj2u/40
	N+g==
X-Google-Smtp-Source: AGHT+IFMJpzLoBuvnKke7M8L8J1XyGnz4DA/DXF7pnXaUcfUvIroWGA26PbBGScPt2HZrKUNAeWChg==
X-Received: by 2002:a05:622a:40f:b0:43a:ecfb:8a5c with SMTP id d75a77b69052e-43dbed33436mr2631381cf.40.1715099242710;
        Tue, 07 May 2024 09:27:22 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id hf23-20020a05622a609700b0043d1fc9b7d9sm4160597qtb.48.2024.05.07.09.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 09:27:22 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 07 May 2024 16:27:21 +0000
Subject: [PATCH v2 16/18] media: venus: Refactor hfi_sys_get_property_pkt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-cocci-flexarray-v2-16-7aea262cf065@chromium.org>
References: <20240507-cocci-flexarray-v2-0-7aea262cf065@chromium.org>
In-Reply-To: <20240507-cocci-flexarray-v2-0-7aea262cf065@chromium.org>
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

This struct was only used to get the version from the core. Make that
explicit.

This fixes the following cocci warning:
drivers/media/platform/qcom/venus/hfi_cmds.h:77:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi_cmds.c  | 6 +++---
 drivers/media/platform/qcom/venus/hfi_cmds.h  | 8 ++++----
 drivers/media/platform/qcom/venus/hfi_venus.c | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
index 520ff8a587e6..c5123f2e76fe 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.c
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
@@ -151,12 +151,12 @@ int pkt_sys_ssr_cmd(struct hfi_sys_test_ssr_pkt *pkt, u32 trigger_type)
 	return 0;
 }
 
-void pkt_sys_image_version(struct hfi_sys_get_property_pkt *pkt)
+void pkt_sys_image_version(struct hfi_sys_get_version_pkt *pkt)
 {
 	pkt->hdr.size = sizeof(*pkt);
 	pkt->hdr.pkt_type = HFI_CMD_SYS_GET_PROPERTY;
-	pkt->num_properties = 1;
-	pkt->data[0] = HFI_PROPERTY_SYS_IMAGE_VERSION;
+	pkt->one = 1;
+	pkt->version = HFI_PROPERTY_SYS_IMAGE_VERSION;
 }
 
 int pkt_session_init(struct hfi_session_init_pkt *pkt, void *cookie,
diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
index 02e9a073d0c1..cd7902743f62 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.h
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
@@ -71,10 +71,10 @@ struct hfi_sys_set_property_pkt {
 	u32 data[];
 };
 
-struct hfi_sys_get_property_pkt {
+struct hfi_sys_get_version_pkt {
 	struct hfi_pkt_hdr hdr;
-	u32 num_properties;
-	u32 data[1];
+	u32 one;
+	u32 version;
 };
 
 struct hfi_sys_ping_pkt {
@@ -239,7 +239,7 @@ void pkt_sys_debug_config(struct hfi_sys_set_property_pkt *pkt, u32 mode,
 			  u32 config);
 void pkt_sys_coverage_config(struct hfi_sys_set_property_pkt *pkt, u32 mode);
 void pkt_sys_ping(struct hfi_sys_ping_pkt *pkt, u32 cookie);
-void pkt_sys_image_version(struct hfi_sys_get_property_pkt *pkt);
+void pkt_sys_image_version(struct hfi_sys_get_version_pkt *pkt);
 int pkt_sys_ssr_cmd(struct hfi_sys_test_ssr_pkt *pkt, u32 trigger_type);
 int pkt_session_init(struct hfi_session_init_pkt *pkt, void *cookie,
 		     u32 session_type, u32 codec);
diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index f9437b6412b9..745c2c0c0d55 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -1142,7 +1142,7 @@ static int venus_core_init(struct venus_core *core)
 {
 	struct venus_hfi_device *hdev = to_hfi_priv(core);
 	struct device *dev = core->dev;
-	struct hfi_sys_get_property_pkt version_pkt;
+	struct hfi_sys_get_version_pkt version_pkt;
 	struct hfi_sys_init_pkt pkt;
 	int ret;
 

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


