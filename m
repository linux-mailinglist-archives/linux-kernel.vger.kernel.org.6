Return-Path: <linux-kernel+bounces-189996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9548CF83B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ACAF1C20C4F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 04:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8618C07;
	Mon, 27 May 2024 04:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GVb0kHuM"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA471A2C06
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 04:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716782435; cv=none; b=dKegtWNACedpAkIfh3y8xnnGLg0sS2ChQ7UugJpkYIh4O75ZEmim/0DLTAjiGLa7CwgY5nsmlLO/4mb7Gv6gyZxIx3TFxYMV2Dy0X9DxSpCZ8Uxi2a9FywDYsbSiZOT0kZDepDbrZYxgARZ5GQOmfF3opHjaSRNc5bdR+MW0fxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716782435; c=relaxed/simple;
	bh=vpapg2UevpSKJYzb5JyThjyZeYx4tkUFrSR1WEmKFnk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ChAjUeYvXvg3Z0EZl1dL8B07kx8raKZWwPcKXUbbOc/h5J3XYhBZxf+fqWWt5qEWvDM1qwSOzkAlNs/Ez52DAljFSf1sFcr345TtygXma3HC7FRoB8vrnQuFNyAxKMPnczmKeYeQwc7vov8C0WRGaOXiv5HdOsWiMdgHKpG7Tbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GVb0kHuM; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5295dadce7fso3534431e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 21:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716782431; x=1717387231; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tRuvZhJPDoNLCNwIjcJF1I2bXe4M5YSZZXOsUihzxa8=;
        b=GVb0kHuM/mAxpLgVNmaCHQ9ScIBWuLGcs47awJskLfzd3c0F8E4GBwoyYDAMSB+Ern
         FooxBvpEmgc6GRDy0ithog2tzRPOGEm53tSY1J9Vu1Y65frxu103HbQqt37jQEsm92Yi
         NyriMjwnMWESONDAOpJfGjz0VXXHtehHvpO80dujkt1txamUxW6USSNgI3p3U8Jm1Ehk
         ViGgHruCHDLOiZykBMytODQDbyLPUAOw9OHGbHcAShkMcOrhwEN6L2klFyG3SqfHn0lg
         AZXnmFuwjSsiA9XwIaBKYjHaEmdQFGtX6fAOvHqMU3kFXX1LdqIZo47dIJQCk9qE2vmk
         Rwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716782431; x=1717387231;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRuvZhJPDoNLCNwIjcJF1I2bXe4M5YSZZXOsUihzxa8=;
        b=J0A87KEItiHCsxg4kT062NofP4g05MyWpscuGFg4+g91y9ayBukHh+R+2zzEAvxCrF
         Y4sr9wNTNpUZbtPHzmhnm2q4sVZAtZxlET5bcODX+7MkWYirMWj28ZqmyD7F0Wwagcm9
         ix8Y7oU9MdBxWUaBP5QO2XvjKKpdWIGwKECJDWOCs1GkEGhCgNbYaF5fXwngqSoCZagV
         N89FuwQgTcTcJH72YbnwkYtj7fed8tIfcqqYCU9++mi34lyM8K+2kwMh6LI6ctrk5O+u
         G6XHy57jNjGJDR/fSYMXbMvtLo/g5vPFU3XdHtg/YsbdfLhUIyWvbUSkPPRp40HJd7FC
         NTmw==
X-Forwarded-Encrypted: i=1; AJvYcCWwgxS0WzXrFFdivEIfec4bXnlEx/+9zW0YXpSAVSTz0WcQFugvdQsE7PTMPbNPvyV0QJ61QZlS9U5wKbZ4v+V9Pae1Y9e4o6LYDVT5
X-Gm-Message-State: AOJu0YyK0acIgmzCAby+atO8CI7u2oKbew1c/LB5Vd41N5oVEmTIQLux
	QEdPCjr7Z2A1cyquurP9Xwvnb8zilRJ5Nknm++sS7nqUJMJF7KX7nODxEakqgz5o8RauUJyO9hP
	C
X-Google-Smtp-Source: AGHT+IFIBuHRkJmbDJ79c+HEEn+ra39J5KYtIkFUNbnYVhpVLECmUerJTblEmBKdwbPjKNZ9I4Wa4A==
X-Received: by 2002:a05:6512:388b:b0:523:aac1:b559 with SMTP id 2adb3069b0e04-529663e6304mr4842739e87.44.1716782431209;
        Sun, 26 May 2024 21:00:31 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52970d2a06asm457497e87.218.2024.05.26.21.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 21:00:30 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 27 May 2024 07:00:22 +0300
Subject: [PATCH] arm64: dts: qcom: sdm850-lenovo-yoga-c630: fix IPA
 firmware path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-yoga-ipa-fw-v1-1-99ac1f5db283@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFUFVGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUyNz3cr89ETdzIJE3bRyXTPLZIM0I1NTgxRTcyWgjoKi1LTMCrBp0bG
 1tQCgiMw9XQAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1076;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=vpapg2UevpSKJYzb5JyThjyZeYx4tkUFrSR1WEmKFnk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmVAVeOJ6pMoWF+xS78t1AVN0GigeUilbNbYf4i
 kNeue2o6biJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlQFXgAKCRCLPIo+Aiko
 1dh2B/0d0+t6zdU9S5h+hOk+MiUnjCaNZRoq7S2IJuNSFe3UltJ+LwomuMFP5tzufF8k6Dk6JLV
 jccs86EQV9SnErMGKbSD6kyPfAmk9mG+CvPd4UflmXGX0jix5euZA/EFoxDXBU+9VuHD/Z6bmC3
 dFHDtclOc9dB05NTerle8oRi7lNTEh8rbWv1bIFKnHW/00MtJt6XEtniyniE8AcubodjNUDr3Di
 Fy5uK9ycydo5/JaO7npZz1DZNarTaJScBHpSBPv598UP30Y32zx5BICkcAeEE7A75n73xoA+QWg
 WCQeCXrflZqFJf9UKwxVHDxgyh/FTbjc9GBlZtLAnIv3+Fh3
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Specify firmware path for the IPA network controller on the Lenovo Yoga
C630 laptop. Without this property IPA tries to load firmware from the
default location, which likely will fail.

Fixes: 2e01e0c21459 ("arm64: dts: qcom: sdm850-yoga: Enable IPA")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index 47dc42f6e936..8e30f8cc0916 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -494,6 +494,7 @@ ecsh: hid@5c {
 &ipa {
 	qcom,gsi-loader = "self";
 	memory-region = <&ipa_fw_mem>;
+	firmware-name = "qcom/sdm850/LENOVO/81JL/ipa_fws.elf";
 	status = "okay";
 };
 

---
base-commit: 8314289a8d50a4e05d8ece1ae0445a3b57bb4d3b
change-id: 20240527-yoga-ipa-fw-69c0f2550d57

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


