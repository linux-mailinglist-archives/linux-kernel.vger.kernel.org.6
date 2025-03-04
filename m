Return-Path: <linux-kernel+bounces-544208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25104A4DEBB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708A416BFAD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF8A204C0C;
	Tue,  4 Mar 2025 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P2U96kjI"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50691204694
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741093638; cv=none; b=f26oSRKrGSH9ASfgKKpJdqGVXQLSsmG7wmlGJFU0sRqI6WCAjWgc7ftNKm2vnd0GexOG5529TqqPkPi4b59mYxy7Gta84XWYfpHNbcar6OCM86L90B3vMiyfhIpd1ncEJJXpcmabnNchY3xAzgAdim0W4AxSMlmmdAbwNzIBnIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741093638; c=relaxed/simple;
	bh=FaXxWBTtA0V9vWn2OFkttUFzPuAdqQgSnU2vFsSbkqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EdaqchPl5YCt/ZTh7gGyaVSPwt+RNth1lhCQcBhGTwajbAWZCTPBmez30iBwFh8lhqMoUWS4UKFnIE6rltcp5lmX4V8NwyEOT+m4mUDNOMUvXu58fW6KfIbsR/RixRpqQ6mvomEz6DCzz2Ord9RneaetOpRLzZ5HnL+IMUg3FwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P2U96kjI; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-390f69f8083so2898779f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 05:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741093634; x=1741698434; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U6HSOnQBr0FDVpREIMoFhmB69JXqeBMODdqv9u5g3C4=;
        b=P2U96kjImqkUyovt+nf7z/PdDXHS4hm/QKlqa2kM691zNt/05WLjSvlTI/h3uZIfHi
         UQErMq7C3EhO7fEJwHfNV1h42wTwUL9/nsSH6OKVTTdJu/lZIBtSXgmpnXQJaUtNSWF4
         47FBRKvGCqdrqL8kD3iAYlfsggwYvw26tcwdogR/RDCMkK2wMvlDw/B8ADyuLvm3QfGc
         zq6aTEG13xKwfcF1Pcq1gPGlvn8FPLNyWHNnVEkvGp47Z30dcoVLLzitj4D+DKUE/ceJ
         2PumeYTkppHEZWcF+xwieOXkKAuGgoX1gobfjQ9APrphRlSv9iV7Znwj0omtxKYa+ZZr
         kH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741093634; x=1741698434;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6HSOnQBr0FDVpREIMoFhmB69JXqeBMODdqv9u5g3C4=;
        b=Q9rCUf4sUAEPK15fcgAIq5CvYUF9/lY82HAsWg0M2MyfePZA+k0KNUNKiQoz27MSqR
         hSQjbJUthdCTk952UuRizdAZV8OrXaF19tWhpDmBq51HhGIBPo7j//TRCfZuoK8gCGRM
         8ELJYqfareZ1enr0hyPPL8bgVpGGQD/02gSGLgqQ1reWnkxnBU1qpLsQ87nVt0PpqBOP
         RDX+9pFzZU7EHwdzCzxcfK7o3v+Rt65gu9n5e/eDwO7mUiq5O0VEcPxKl3oinhX71hu6
         2AscqdKExsVT3yuulrXrBp3xZzlf1UBLeqYwLz/eHDEDQ3AazyQEtZ8fuRJdbxut22CC
         8r+w==
X-Forwarded-Encrypted: i=1; AJvYcCWEwfpQUH5OASA7hL8Tj5UI0mDUGHH0G51B06W7OqYUwm5qsn3j6+NQ88ypfC81E1vl4IEpnKphVmD3MWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpxNIH27Qbq//nPXCJF8q+q21rFvabY/GVuOUhh4Y2zfjevR8W
	VTm66Gaacn7nWg0ev2DDLOyCmidUeLPPHVFxu8Pq7hgoD/EsRpG9MJ4eCd2gBco=
X-Gm-Gg: ASbGnctsJGiBfXewC/ovmBitAWjp+fS8yaojqXRxWHonzGpJN2l/YmF5g4OwEl4phQL
	aWlCnRXUu1UTTOKjSV3z9Wyj+F8LThGkG1fVtSmuruALPZPcdZaZ/J2UmoEkqHALmlDZnsTRw9e
	HbtjVbxvfeHa6nJezyP8Uto2ebjDvYj3rABwaEvBah0W4WRvtzOO7/Br2wuEFr0WfuZM6f93/SR
	CHxjpL/czABknkYS7WUmjHOZCMQPKpADO/MhuX05qXBGuOhg5rtkSpxizSp5kgBzEJZNHegQ5n2
	K98hlbBFvpXdiV9OPmGglaGjWVRV8KVEglfMWB8bIoCIGVX3oYpL5dkGx0oTffskjgKlfkb3Lg9
	2xDZUrQ==
X-Google-Smtp-Source: AGHT+IFd1jiwpx5EeofZBxtQSONJsTOBslCT9aMW9/Tof0U0ChG1L8NGbIX2J18ydo0KXKMo/1Upcg==
X-Received: by 2002:a05:6000:2a02:b0:390:f412:dd41 with SMTP id ffacd0b85a97d-390f412e13bmr9259864f8f.53.1741093633694;
        Tue, 04 Mar 2025 05:07:13 -0800 (PST)
Received: from [127.0.1.1] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b6cd8sm17401715f8f.44.2025.03.04.05.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 05:07:13 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Tue, 04 Mar 2025 13:07:09 +0000
Subject: [PATCH 3/8] media: venus: hfi_venus: Support only updating certain
 bits with presets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-b4-linux-media-comitters-sc8280xp-venus-v1-3-279c7ea55493@linaro.org>
References: <20250304-b4-linux-media-comitters-sc8280xp-venus-v1-0-279c7ea55493@linaro.org>
In-Reply-To: <20250304-b4-linux-media-comitters-sc8280xp-venus-v1-0-279c7ea55493@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Johan Hovold <johan+linaro@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.15-dev-33ea6

From: Konrad Dybcio <konradybcio@kernel.org>

On some platforms (like SM8350) we're expected to only touch certain bits
(such as 0 and 4 corresponding to mask 0x11). Add support for doing so.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Link: https://lore.kernel.org/r/20230731-topic-8280_venus-v1-3-8c8bbe1983a5@linaro.org
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/venus/core.h      |  1 +
 drivers/media/platform/qcom/venus/hfi_venus.c | 15 ++++++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index abeeafa866971..b595f72b3afc4 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -38,6 +38,7 @@ struct freq_tbl {
 struct reg_val {
 	u32 reg;
 	u32 value;
+	u32 mask;
 };
 
 struct bw_tbl {
diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index a9167867063c4..ef2ea4727758f 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -359,10 +359,19 @@ static void venus_set_registers(struct venus_hfi_device *hdev)
 	const struct venus_resources *res = hdev->core->res;
 	const struct reg_val *tbl = res->reg_tbl;
 	unsigned int count = res->reg_tbl_size;
-	unsigned int i;
+	unsigned int i, val;
+
+	for (i = 0; i < count; i++) {
+		val = tbl[i].value;
 
-	for (i = 0; i < count; i++)
-		writel(tbl[i].value, hdev->core->base + tbl[i].reg);
+		/* In some cases, we only want to update certain bits */
+		if (tbl[i].mask) {
+			val = readl(hdev->core->base + tbl[i].reg);
+			val = (val & ~tbl[i].mask) | (tbl[i].value & tbl[i].mask);
+		}
+
+		writel(val, hdev->core->base + tbl[i].reg);
+	}
 }
 
 static void venus_soft_int(struct venus_hfi_device *hdev)

-- 
2.47.2


