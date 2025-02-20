Return-Path: <linux-kernel+bounces-524085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E2DA3DEF3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35D719C2FA7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20271FDA9D;
	Thu, 20 Feb 2025 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vINIICQt"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309031DE4CE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066101; cv=none; b=BwWNgUdB4s4Ki6pVkfCIPpo8EsaZmjoVl1SJp9KZcKjErSHSlrcmuwu0d/nsBPf5J5acxuUaIkmhcdrF9KkTr7HbvhRB56oAF1fZjIeFsHPZOUc+fpUeR4Wh2SmOWWxRn33V6ME5bhwlO3LhtBVq686yCQMXnRVsa0SGzkIFga0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066101; c=relaxed/simple;
	bh=iDnkUJ6+qKrz4yi0lcczfYKLL8cZ5N7uOIHYPvi8lfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3KVXJcP4zV5AILrVWI1cI/deq6xtBWCsgPGnmsq8sKJ/erJBQlORqF6RhyiqLiOtWWuXOJqzpRnphBOtTFp5kex2GTiTXc2kMor7G6PNEqSBwrD7Ph07Qd5eGM4BkDVyN9SBjnNUU17pDd/JoxkQ7UXg/+OneZ3ddJ+f8zIhDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vINIICQt; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e064eff5daso168479a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740066097; x=1740670897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMexPyi4X/XFWoEQeqC/jUtxuZa+FuBdiAX8hec2Nrk=;
        b=vINIICQtPZ1LNH+8AZ6DutURhlBEGPHhCRB47+ys321ojK3YzSDKPV5H5hrSbxR0or
         SmqhQhbE9yIWLF5ezIv/62pwlG9TJ4Zht50l2IfFW14pDtR4iWlfzNRm/uJSE6cFwFW1
         3ZoX9aLGWHGkGcbhyfWj9qCgmaMuPd/skOk8fRtHlUsp4ZI/7gOSkobWJNaqvo+CdJu0
         /ZbfXMYWqyYqg75DfU0KEhaWDOrlJAyzZdmX4QGAZGzEBYKl2QG9NY+e0H+gPbffpl/M
         u+I+p/cBh8HjNSZx4myrleNepUIbUJA659TyNgeQp+gVo3KNIj1L2AvW5i/14gygDM0p
         hKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740066097; x=1740670897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMexPyi4X/XFWoEQeqC/jUtxuZa+FuBdiAX8hec2Nrk=;
        b=NoRqwXWzzWdkiiZ8zov4ctckDU9/EQyUDjCPWEtqyzHbdzzQQMl0cYKoxXzI3EbL1a
         TH6okYjb0Qil1nFfwhpdcHJvUyux4xq1OYBwfh8naZdok7opWCFhz3KrgQHapf5EDteJ
         1Q7nCNGScu2QLK1JrvBb6PY9L3kLnrY+DTWsVUxmVS1bgX+NOeSKomX1d6I4JTYNLd10
         csUABKkc/uxvrvM5Z5+WpkU49hWNjx65Ugw0xCWgyTqwzE2qbWOlxxyi1p1REaYq23xJ
         s8n3OZTSTct8ON0C3DRpoj6WZsjt7D9xQM4EgDGDanrQ+CPsP/5FffX9KkTP7fI3OqDz
         OXZg==
X-Forwarded-Encrypted: i=1; AJvYcCVv/7SxiqgQqK2aCwPsygPQ0A/qUt/Mku8LD/tUPCsV3x4xxPx4KHFmrLUbzyYMJKL1Fro+aut1ozEZt9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrN5n1XI0eGa1Y+sBLgGiKjFVORT/71PRCug6Bsz2Wh1ddWa5w
	rQuuiPc8bfPP7pR987tJIB4q15XNcclxJw7nuUxhJgbmsZWZah2S0S+hbUIOOpI=
X-Gm-Gg: ASbGncttDBn5+oXtk3xHUsHB5Pz4UELegrtpYiI78rOcG8NVpTCdEU7MIfaSfaqN9P+
	xSWbiBOBGpmNo5yB6VQH4DqWMCccDrR6JnNw6Qm9f3mKrjtyEie6uQGZOQboIIO4gZZ9lVAZSOs
	/ekFZ+CVNV35VE5u0Hyw3+2P4Sc6T9V5XWPUg5VtElRYke9iZTcInkItO6edhnx+sPA1dqToZov
	qaSQ38LT4P6MBqApbImlCAbwcE/O8JOXfUuJ8m8b7+qm2dLGDeJ0fsXW6TF/2xm2fzHwGekxyWm
	ciNHMEvtCAFUySKWo/ayCYnlYwJ3n1ABsd5GMGwiGNOQh0cyK2eXsdDAzXMBk69h
X-Google-Smtp-Source: AGHT+IHVrRSBtxWk0xruTGzrrqWlO/GFxEj4pebcghpMR+QZr6zgSIjoWLBIHWmQUFf2sytBbCsuiQ==
X-Received: by 2002:a05:6402:234f:b0:5de:ba38:b691 with SMTP id 4fb4d7f45d1cf-5e0361db9f3mr8506084a12.9.1740066097529;
        Thu, 20 Feb 2025 07:41:37 -0800 (PST)
Received: from krzk-bin.. (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece287c7fsm12097608a12.70.2025.02.20.07.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:41:37 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH 2/2] remoteproc: qcom: pas: Add SM8750 MPSS
Date: Thu, 20 Feb 2025 16:41:32 +0100
Message-ID: <20250220154132.199358-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220154132.199358-1-krzysztof.kozlowski@linaro.org>
References: <20250220154132.199358-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add remote processor PAS loaders for SM8750 MPSS (modem), which differs
from SM8650 by lack of fifth memory region for Qlink Logging.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 97c4bdd9222a..c34b7780f786 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -1409,6 +1409,30 @@ static const struct adsp_data sm8650_mpss_resource = {
 	.region_assign_vmid = QCOM_SCM_VMID_MSS_MSA,
 };
 
+static const struct adsp_data sm8750_mpss_resource = {
+	.crash_reason_smem = 421,
+	.firmware_name = "modem.mdt",
+	.dtb_firmware_name = "modem_dtb.mdt",
+	.pas_id = 4,
+	.dtb_pas_id = 0x26,
+	.minidump_id = 3,
+	.auto_boot = false,
+	.decrypt_shutdown = true,
+	.proxy_pd_names = (char*[]){
+		"cx",
+		"mss",
+		NULL
+	},
+	.load_state = "modem",
+	.ssr_name = "mpss",
+	.sysmon_name = "modem",
+	.ssctl_id = 0x12,
+	.smem_host_id = 1,
+	.region_assign_idx = 2,
+	.region_assign_count = 2,
+	.region_assign_vmid = QCOM_SCM_VMID_MSS_MSA,
+};
+
 static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,msm8226-adsp-pil", .data = &adsp_resource_init},
 	{ .compatible = "qcom,msm8953-adsp-pil", .data = &msm8996_adsp_resource},
@@ -1474,6 +1498,7 @@ static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,sm8650-adsp-pas", .data = &sm8550_adsp_resource},
 	{ .compatible = "qcom,sm8650-cdsp-pas", .data = &sm8650_cdsp_resource},
 	{ .compatible = "qcom,sm8650-mpss-pas", .data = &sm8650_mpss_resource},
+	{ .compatible = "qcom,sm8750-mpss-pas", .data = &sm8750_mpss_resource},
 	{ .compatible = "qcom,x1e80100-adsp-pas", .data = &x1e80100_adsp_resource},
 	{ .compatible = "qcom,x1e80100-cdsp-pas", .data = &x1e80100_cdsp_resource},
 	{ },
-- 
2.43.0


