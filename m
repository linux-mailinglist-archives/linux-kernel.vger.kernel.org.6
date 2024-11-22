Return-Path: <linux-kernel+bounces-417972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD129D5B61
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D79E282932
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5A01CEAAC;
	Fri, 22 Nov 2024 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="STjR9WOA"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8989E1C3F0E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732265794; cv=none; b=K1Y3gjzvXV9iOwAIkE2BtTKCESgGadde2AznurjtgUqrESm/NvfAxK6G9yo2B1rDHM3o7UBc0TYrNKBNRIvHajTriZ5/abB5fLlidYpvJuLH3wDTrCiJ0AfZ1TJhsSMCium7c5dThYb/CgudcCUe3BN2dGbfYjjb3jVo5eHjV9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732265794; c=relaxed/simple;
	bh=iDnkUJ6+qKrz4yi0lcczfYKLL8cZ5N7uOIHYPvi8lfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nA8f/jfJmqKHaSY05SAKgE9LvpUJzNcatV0Th81kcjpj1wtXLIbsaRBLJgiIG1h/HIsuETvyYv/dk9dBjo8gED/x++cBRAAgNn61pRhDccnpYWpZTXfk0keyyEed/HlRIz3KUjP6Jp7hoWqa3Hd7bMWh2xX7HpxcYOay1sIBoPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=STjR9WOA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315549c4d5so2796215e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 00:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732265791; x=1732870591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMexPyi4X/XFWoEQeqC/jUtxuZa+FuBdiAX8hec2Nrk=;
        b=STjR9WOAU1BhogK0WnpXaPCmSz1cgKONAl7SKKqFCfjsjl32iab+Ee1O1E3aEguSUd
         U2JJIwWSnM5VrmSt7uMm5JCsXMa1md5h5MEXM700gy4AuFS2xLGqpe+yWyBuDwFeJ4Wu
         b+W23qE0eJYz/AtXgrMlETP+7WF2dfMd7rw3mYE2WknZktk8Dy5BkVhKhPsGj3bK2Srh
         J68olxtQw/Ogs5bOpYFE6Nh9NoEZ9RjN8obApoRsO63CeCGbSyGLOuse0oRiVg8hxhJc
         d4E4RICM+M6A8Jre9OhqYnCDutZtYZ3KV4gj0lHeUWKW4YunDYt/dBhigh+qz2D2g19W
         yVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732265791; x=1732870591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMexPyi4X/XFWoEQeqC/jUtxuZa+FuBdiAX8hec2Nrk=;
        b=OLdOOWi0qsC4JuVrQ0tEPb33eA7R18Orbhs+5GjKrmBBEH5Ebk01V/RVG63uIOGNkG
         7kzYYqsDTVtA7HToP8KoKyzZZeY/D8kxZ5BpL01gFf57KgblqY95oDsYUGbnW70RYmiJ
         Ratp5uPYq4tzBSxnGd31qV+mFX0IuKQYwwCfOzIi4yDK/a5PZb9N6PNHsw6tMir/Jun+
         VajtwiNbePk1Mjh76J5owykm1tCJ5y/D/9dHTRGTuugNPg/yKdnfRjHVqUS8izF36U7h
         p3jsNiqqX+i45z/rZwh9lji3zVc0yHQs2/OA7xDj8H+YdFD3GJuVqqf2V8W8jdLukO2n
         5eEg==
X-Forwarded-Encrypted: i=1; AJvYcCWJlDW2sZWn8HfJSJFszz2iPQtNVmSg7B9h4tRdPw7XV8gfJbb6eqIzEhYnCpshi3WYrJwsgFp9pTQsiIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9DCctsbavfinfJjMwyP5mh99fqPkC66GZUilFiv8B3JKqxGJu
	8LSpz9nHHLglhlp1Z6G3FrAHSHfOqb/v6IZFEaNhiojLwbiCZ6t503Bka5brcZWgRvGyNTl8d/1
	vItU=
X-Gm-Gg: ASbGncuI7GgB6LLzGd+rw80ewLBo338HbmCuj6c58LrHvkopx5WDHbUscRfCZ5XcaAv
	apwGCCOwrT0fCoYSejab5k+XT+NQuJL2vEGzt2QO213/IxsPV/eQoQPED14/X20UFMMCmf4B65k
	2JJI9aGc2PDr77Pr6j+ZrQhVERWdefcidSiG1Vp7SVSKs0W4Sls6E0xJPX/xgsnUI1ZreVws2Tr
	RT6uStDRfsgBZMFYAc85kaIXZlK9L7zwmF2jd1J60xET0dWBFMJmsUEGzfSbehv
X-Google-Smtp-Source: AGHT+IGkV8XGhRtLXA/2oeLLvXbpa9yNqrwoZ1wN+JqNTZm6ToUQ8b+at7MqfHbeoQ8SEFNb6oTHFA==
X-Received: by 2002:a05:6000:4028:b0:382:4e71:1a12 with SMTP id ffacd0b85a97d-38260b465d0mr560916f8f.1.1732265790809;
        Fri, 22 Nov 2024 00:56:30 -0800 (PST)
Received: from krzk-bin.. ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433cde97c68sm20320695e9.36.2024.11.22.00.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 00:56:29 -0800 (PST)
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
Subject: [PATCH 2/2] remoteproc: qcom: pas: Add SM8750 MPSS
Date: Fri, 22 Nov 2024 09:56:23 +0100
Message-ID: <20241122085623.19988-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241122085623.19988-1-krzysztof.kozlowski@linaro.org>
References: <20241122085623.19988-1-krzysztof.kozlowski@linaro.org>
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


