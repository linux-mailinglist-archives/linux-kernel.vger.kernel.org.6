Return-Path: <linux-kernel+bounces-526140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44400A3FA86
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17DD5442038
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB1C204F8E;
	Fri, 21 Feb 2025 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DtksPI8d"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26281FF7D3
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153791; cv=none; b=XIV7FsGRzo4tc4xa8DqiG5u6ZBBGtsvHh4wv+bEZ/3jA3qZdMnfMALPnDgkF8Go84QoMlKiVM3ep6enoVcGJVnXmM526noQZhLClc1CRZs0nE7BFzaYXSwUN859yEdRNtiJqysjnWpu2pAeP73YxXD8VZKbIABcQjFPz/6iLqtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153791; c=relaxed/simple;
	bh=jNpVKLpJOZImpyW3PpLBE59YQPImFyESp7Aep3FgeYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLr4d2oEFWQ6Q9x4TZrgzaDPX/cd75x5MRK9KF0t1IZUBb9+r2zitrI0E+1fFZ0gp1dLv+3PzHuomFn8HIKW7f7rSqhEqFWB1NcDCTJwjdVjOquWDGGnAgxHNU++fFpnfFDzZhHEDOejANF1oX+FPDHKOAdHIf40fl8P1atJ/eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DtksPI8d; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5dc191ca8baso461312a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740153787; x=1740758587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OXcF/TG2PCFERI1SWimzKBOweiSs1ZB9MJg92lP4jc=;
        b=DtksPI8dHyXYI3s8/lSvEydMFfe1Ml0RKpZXT9qDgs/XJbs+PrPqJzY5eEQljcQ1yq
         jkIpdnxGsPPsDxaLEK8t3ylKrCX2nJuuhcuPj8YYyFaTYR/+vU5ylpUaVN76ck+KBx+A
         fAzUfz7YESVaN7xCiDUNZ2pCB8Epg7QelzWians6hJUKJN0ezGNcA2eE/cOKctmmd7te
         0o0Cz/vNUoBdmG/LXzcjtJuYZcCzh7MAcWajWtjkD6rbTBT9M6HqUlsb53eAdkI8jFoN
         WojTZ7JCLrLBDTkoih+dOtJmhOZ2U4G7JlNpm48UCtY3nTlbDZtXGg/hLwLQGWDgVHIk
         z3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740153787; x=1740758587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OXcF/TG2PCFERI1SWimzKBOweiSs1ZB9MJg92lP4jc=;
        b=QN0hLBmkvtcMhBHw3K+v9+8VUyBjnvh0FPUZWPE9ISsq/vu+besbwdrLMMmXj6ja47
         oF/sW2o2Go3TI2JD/srNkEHwXF5okBjetuRSxz3FnKao0SSplK3A+WfNTvIB9uVCD8FP
         YKJO260HdoMqxHFkMvZRRni9Pqeaa0QcPaknYd6WEmT7UYMaub/og/mXgC6O7CkWv4aX
         5JeAXkT0Eq/MRZe+LuYBtGMdL7/90Jx60LNbKlt2vyHBJkkOxGtugNzDKM86/0pluNyS
         JL0pwBQwaqMw6q8aOmAjIcbOESgk5ddYojcDEVp9M7p9tUcDTuN5NRFxYnOl8usozfAl
         mgnA==
X-Forwarded-Encrypted: i=1; AJvYcCU8/XcItJ99f32co3QZ4ty2LHSImAJIf8DG6oNr087WR8WIUGG5nyKga1aJO5UeqQeNFcYiXP+oBGxjs4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydy2Nn+F96/oCw/MVgt2bfFId1wXpZ+3MD8qqTmG8zcwPUxw87
	Q7Z4ZvvZy35uNWPRPzXXf98lQOhVog7y1KOKdHpm39iogFzPKlyYZiUSCNxp0Ko=
X-Gm-Gg: ASbGnct45TmzxAgaNWpQnW2qQASQQhgU16xaBcHQpYspPx+kbOctbYHlRFPYGpSkjVw
	pA57S7btCXhUE+eTwVLtqNPNultZF6A3Y8CHXM+w1uMAT9og9LjW0tIirswz0qGgtSEknW/mVSk
	/eyI+bw+c3W/96VeU2Y3d/D4jalBs6qWp/uFdw7urftlxqkeZKo6iOArcyTwo1eGEVdpLAXoOuj
	fSAaAfzIZGOJIJD9vpiTwBFeLRFrcN1/cJ2o0GfwBNThfeWMZMSFkt6BuZ4VWIwSJMHivvNJIMi
	W4npmLP6Ft0DYlP3yM0opsDh1Y6gTtg2N/MXtPsao8NrZTYc8mKVyUoTYwkSa3anfCZBBzguSHg
	=
X-Google-Smtp-Source: AGHT+IEkEFcjqxp6Jb7RRhAg97Jh8Ki4FzCRDMhO8xX32MsiOvuIBNnukhiVmbZ0l7ZZyA6t7WA3Rw==
X-Received: by 2002:a05:6402:4406:b0:5e0:803c:2440 with SMTP id 4fb4d7f45d1cf-5e0b72311b3mr1279503a12.8.1740153786941;
        Fri, 21 Feb 2025 08:03:06 -0800 (PST)
Received: from krzk-bin.. (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb98640619sm1040782766b.54.2025.02.21.08.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 08:03:06 -0800 (PST)
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
Subject: [PATCH RFC v2 2/2] remoteproc: qcom: pas: Add SM8750 MPSS
Date: Fri, 21 Feb 2025 17:03:00 +0100
Message-ID: <20250221160300.160404-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250221160300.160404-1-krzysztof.kozlowski@linaro.org>
References: <20250221160300.160404-1-krzysztof.kozlowski@linaro.org>
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

Changes in v2:
None
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


