Return-Path: <linux-kernel+bounces-248906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5336492E38B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45091F22ADB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC07156C78;
	Thu, 11 Jul 2024 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iUZ3fhWS"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDD31552E7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 09:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720690687; cv=none; b=fyHwb4uJWb7hf3SR92ZwT1QDUOrGkidpyOwlOe3U5xgbE15Qbul84zmiEF48LaiaHjRWGU1qRLsbAy9RCmAdC0yx13swc+NuHQiaStDlmb1YvhF0URGPGK4By3XMsDYmMGLPgGkhm3aqdl5G4XE8M8COJ7yiMGHfI8Yo1KE56dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720690687; c=relaxed/simple;
	bh=WrqaJmAAllwF2lX26NM6VCkccaq+3XJvLkShVBlREYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uvna6RsBRmDGj9whkoa13PLYcz7z+ILyQhgxvBkgK74LLm6jTqyVwS1wm4T9+kfxByO/xbZXHqwENH3COGRf5/XkYIPu0Z2FgxxXsmOMPeUfbB1zVhfIVdKiaD8So6aOJo00m/vII/Ia1lx2wnUU3rqg9Wa9xdZwrR0KfDIp1e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iUZ3fhWS; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso875963a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 02:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720690684; x=1721295484; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vtm3g0wVvH8T4JQMpomMsIPVuRYp3oJIFms5ruCK3E4=;
        b=iUZ3fhWS+fIBMunjTyHRS9Ac6u2HtaKeBBBCaHU0CctDApvZgXBURbstqbuBxItNdx
         OOo6pO10rKN/8qV1tKZsgcJbMPnLFCmNmL7bP3xgAKoJOKqyQIbFMzJLK6g0M7bIMN3N
         0MOzwGIhqG0qjCTU83ZwmegUiKJOWrM+JRJmS4aVSvUfmYqVSpkLOIRsHttolCppRiFP
         zd1mIDVO1b9zdXdrlf8VCtR5BJeo2RlR61ie7z6YMnB85Bmsj5m+5hu7RS4Fu2jmDM3k
         f96aY977baG9MrD42uzf/DLJdNJ/ykxk0tiRWk+7TxSKgiGAX8BWz4xAHOVFunXpGbtm
         bNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720690684; x=1721295484;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vtm3g0wVvH8T4JQMpomMsIPVuRYp3oJIFms5ruCK3E4=;
        b=LjHPwKaJVzsXHWkUBOkFs9wI9hsbmXhIw3eA/7bMtpp/R/wDpJ0HOL2QJuphcZj2ih
         BOIkIFNIbvgQUlSPbyIqF3/+0MK+5vL+agTFv7YAv6sI0SfVtAoehr3//M9923fDyKuS
         CBenAUdQ8MsT4NfdGlDXJWoLlivFOhcOSCi1IpgXCXMEMrDlJZWjkcwP096Kk8N967yK
         WlPkZ2nEj4YeY6F843ZTlP2tLIn8evCRllxyT0quOgoi1na7cKdUmaNJb7nNZCt3NAD8
         Qi0W6Zr3lnXa0Id9sHzI5fB3/SLYX8b0JmwbulC+zL+pl2rW2n0xw/LzkRd637bBvq98
         C2+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVkUFt8eRsknhlcx3+c0oL7QWns6HroKkqF6BJK7vrRjh/AhIvO3a9JMUqzByRMO73Htk462gbGBU+D+MiRPZtjv4zdYbE/4jlL4Ld
X-Gm-Message-State: AOJu0YymJRpC0BkEDDq4cpRIOalUnVdvdWgvLJuR2SgvOCAtZ/QopcVA
	6lnPTUxuNwaWBLavI/qz9jzU+PDQ4zn/5TML9+MZCz5IstNsd4kogGdX2X3KPRo=
X-Google-Smtp-Source: AGHT+IGWjR2keEOrWBH0DFC0WEy78M3ePZNOnnrC3T9ok1Mer9dBM2kVfoDFXV9MjJM9tjrjw2pK2Q==
X-Received: by 2002:a17:906:c082:b0:a77:c9cc:f971 with SMTP id a640c23a62f3a-a780b89c9a0mr553924066b.65.1720690683859;
        Thu, 11 Jul 2024 02:38:03 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bc3f31d9sm3266753a12.44.2024.07.11.02.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 02:38:03 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Thu, 11 Jul 2024 11:37:57 +0200
Subject: [PATCH] pinctrl: qcom: x1e80100: Update PDC hwirq map
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-topic-x1e_pdc_tlmm-v1-1-e278b249d793@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPSnj2YC/x3MQQqAIBBA0avErBM0oqCrRIiNUw1UikYI4t2Tl
 m/xf4ZIgSnC1GQI9HJkd1eotgE8zL2TYFsNnex6OSolHucZRVKkvUX9nNclzIB2NHIbcLVQQx9
 o4/RP56WUD5rELFRkAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720690682; l=3361;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=WrqaJmAAllwF2lX26NM6VCkccaq+3XJvLkShVBlREYs=;
 b=KDxXbPYT1PbOp7Nc0gylZY0GWjG7XYzgs4e4ix75XpgXP3FQAJ/VtlgqQ1MLuZUXKgtPKPZNC
 OUcVFI02IlwBzSxyjMCamPn+PigzulQQv7Y8+dKkHIEVmuJudjgF9K5
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The current map seems to be out of sync (and includes a duplicate entry
for GPIO193..).

Replace it with the map present in shipping devices' ACPI tables.

This new one seems more complete, as it e.g. contains GPIO145 (PCIE6a
WAKE#)

Fixes: 05e4941d97ef ("pinctrl: qcom: Add X1E80100 pinctrl driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-x1e80100.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-x1e80100.c b/drivers/pinctrl/qcom/pinctrl-x1e80100.c
index e30e93840357..6cd4d10e6fd6 100644
--- a/drivers/pinctrl/qcom/pinctrl-x1e80100.c
+++ b/drivers/pinctrl/qcom/pinctrl-x1e80100.c
@@ -1813,18 +1813,21 @@ static const struct msm_pingroup x1e80100_groups[] = {
 
 static const struct msm_gpio_wakeirq_map x1e80100_pdc_map[] = {
 	{ 0, 72 }, { 2, 70 }, { 3, 71 }, { 6, 123 }, { 7, 67 }, { 11, 85 },
-	{ 15, 68 }, { 18, 122 }, { 19, 69 }, { 21, 158 }, { 23, 143 }, { 26, 129 },
-	{ 27, 144 }, { 28, 77 }, { 29, 78 }, { 30, 92 }, { 32, 145 }, { 33, 115 },
-	{ 34, 130 }, { 35, 146 }, { 36, 147 }, { 39, 80 }, { 43, 148 }, { 47, 149 },
-	{ 51, 79 }, { 53, 89 }, { 59, 87 }, { 64, 90 }, { 65, 106 }, { 66, 142 },
-	{ 67, 88 }, { 71, 91 }, { 75, 152 }, { 79, 153 }, { 80, 125 }, { 81, 128 },
-	{ 84, 137 }, { 85, 155 }, { 87, 156 }, { 91, 157 }, { 92, 138 }, { 94, 140 },
-	{ 95, 141 }, { 113, 84 }, { 121, 73 }, { 123, 74 }, { 129, 76 }, { 131, 82 },
-	{ 134, 83 }, { 141, 93 }, { 144, 94 }, { 147, 96 }, { 148, 97 }, { 150, 102 },
-	{ 151, 103 }, { 153, 104 }, { 156, 105 }, { 157, 107 }, { 163, 98 }, { 166, 112 },
-	{ 172, 99 }, { 181, 101 }, { 184, 116 }, { 193, 40 }, { 193, 117 }, { 196, 108 },
-	{ 203, 133 }, { 212, 120 }, { 213, 150 }, { 214, 121 }, { 215, 118 }, { 217, 109 },
-	{ 220, 110 }, { 221, 111 }, { 222, 124 }, { 224, 131 }, { 225, 132 },
+	{ 13, 86 }, { 15, 68 }, { 18, 122 }, { 19, 69 }, { 21, 158 }, { 23, 143 },
+	{ 24, 126 }, { 26, 129 }, { 27, 144 }, { 28, 77 }, { 29, 78 }, { 30, 92 },
+	{ 31, 159 }, { 32, 145 }, { 33, 115 }, { 34, 130 }, { 35, 146 }, { 36, 147 },
+	{ 38, 113 }, { 39, 80 }, { 43, 148 }, { 47, 149 }, { 51, 79 }, { 53, 89 },
+	{ 55, 81 }, { 59, 87 }, { 64, 90 }, { 65, 106 }, { 66, 142 }, { 67, 88 },
+	{ 68, 151 }, { 71, 91 }, { 75, 152 }, { 79, 153 }, { 80, 125 }, { 81, 128 },
+	{ 83, 154 }, { 84, 137 }, { 85, 155 }, { 87, 156 }, { 91, 157 }, { 92, 138 },
+	{ 93, 139 }, { 94, 140 }, { 95, 141 }, { 113, 84 }, { 121, 73 }, { 123, 74 },
+	{ 125, 75 }, { 129, 76 }, { 131, 82 }, { 134, 83 }, { 141, 93 }, { 144, 94 },
+	{ 145, 95 }, { 147, 96 }, { 148, 97 }, { 150, 102 }, { 151, 103 }, { 153, 104 },
+	{ 154, 100 }, { 156, 105 }, { 157, 107 }, { 163, 98 }, { 166, 112 }, { 172, 99 },
+	{ 175, 114 }, { 181, 101 }, { 184, 116 }, { 193, 117 }, { 196, 108 }, { 203, 133 },
+	{ 208, 134 }, { 212, 120 }, { 213, 150 }, { 214, 121 }, { 215, 118 }, { 217, 109 },
+	{ 219, 119 }, { 220, 110 }, { 221, 111 }, { 222, 124 }, { 224, 131 }, { 225, 132 },
+	{ 228, 135 }, { 230, 136 }, { 232, 162 },
 };
 
 static const struct msm_pinctrl_soc_data x1e80100_pinctrl = {

---
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20240711-topic-x1e_pdc_tlmm-a6cd7a0f6cbd

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


