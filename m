Return-Path: <linux-kernel+bounces-199139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A16A8D82ED
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475DC1F2232C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A076A12D745;
	Mon,  3 Jun 2024 12:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EGkdIlS0"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2F512D744
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419170; cv=none; b=B2FSDQvMqkp2S1neCFSvpQM8KfNw3GN9i6rRgbCEw0fOPrVOdMVkljJdvYka7vWZziyk/no7Zc/OeA0ZpzfHf35gMepYEalBuaPl+mkHh6yOYL4+72OQY/FALwPjwhmedSy20oqC07BPDePqGYqLJT6SPgV38XHg3Ud2xG9PMxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419170; c=relaxed/simple;
	bh=7v9FKgUqKFbpR+fiy5xFQPfdqVj5LYeiTEIerHmnZCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=r123tT/pPLHnMW4biSxO3/RYgBlKFlc6oG3rKSG6N0riXMOwCQsgW4Gf2uKwjCq/AJoOpORv4kNwIz3H3pl3t3ltn+5uNIX3X/B+mMCi5HEskETjr3/c4Ax18BLMmL4kOjvEdbeckr3BWkulEWFwVAYG6U93jhSvSLT5BMLyAik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EGkdIlS0; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52b950aa47bso2116384e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 05:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717419167; x=1718023967; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uTu5V8RnBUPKj0gRaqvuNUzSh+9gop4uU31wlbyxsg4=;
        b=EGkdIlS0I8XdDD3jNbZgR8rGXhjFZ4Vj04SA7gz2WayV8PvGGbLR1oyJhasptgWfcH
         H8cPOTBVG5MTlpn5p6s4AVwq2jvCnn4n4PdiR0PNTfD9XgWlILWXzbjF+K6JIbAvq6Rb
         lfDLidHFr4By/6MPWEZSBSn7HHa6iFlUgEX+oanMu7FPcZjWRS6eR8OVOWt+K9hFOSIB
         z9EfYcWNldxZxGZaEhFAJrFLzrwQUaSWYG+RMFe3JTiGULwa1P/Ct5p67vtPbMgVlUkz
         Pt/e/whwbEZ7nSNGvrIb28xgdS+Ekgo4lGzX70YJK/P7/PgmZkh6jqeEuUjP9wqJ4cOK
         7evQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717419167; x=1718023967;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uTu5V8RnBUPKj0gRaqvuNUzSh+9gop4uU31wlbyxsg4=;
        b=pBIm62/UKYvloteskXWHeYwS1RAujxAeTJVjtx34vliQgHIf8ca2OHqsREq2Q0tTPR
         Y8m6g+BKmOfi16KYOwD/LnqfuV3OLoznVw0LA52Ee2d1oTMX72J8t/X2sgT/FmCCGh50
         jEIWREPp/OJxD1YFPkcRMh1++G/Z6xTdL65QlcvMXhFebqROKXii5ltVkZy1XWKhm7nR
         SPfwzUP1+R3ntmvvxo7+C5ci7pgRaTIZ9DboIjsp8mjWowwy5RmJKb0YJRBrkz6tCOb0
         F+BB5zQCFQGughgNrSNhkUJyHeT2qKiz7uQAhoFwyeRO4AgfAeFYCbSs64wKO3lReUE9
         rlVA==
X-Forwarded-Encrypted: i=1; AJvYcCUKZbbJ2JB2sZiAqnyacb64h8mGEYONRBPIbvaAGAqxarEAquwyz0ZfaH0OLudRGuPlmr0v+735ErR6sp+dH+YTldyhhyajOWdrxnjo
X-Gm-Message-State: AOJu0YyLUXN+xU+IRmwWw3xmwe8m+zRwBl1Pv4M2OLP3lqgJAWe2gsO+
	1Yk8hg107WJoV6IUysg3fflFz9ZCRKFJiPd+d4EbVYb2sVCw0oejT2zkj+Cc6e0=
X-Google-Smtp-Source: AGHT+IE1BEKoZRYDbW5hxVR1pX5u20qC6T3Vipt4QAhlPzMJacpQ0FKYnbjre5Sw+WPuPojCbFWiuQ==
X-Received: by 2002:a05:6512:3145:b0:52a:f859:fe4 with SMTP id 2adb3069b0e04-52b8958ba08mr5536679e87.7.1717419167248;
        Mon, 03 Jun 2024 05:52:47 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b9a93d408sm295804e87.304.2024.06.03.05.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 05:52:46 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 03 Jun 2024 15:51:49 +0300
Subject: [PATCH] arm64: defconfig: enable several Qualcomm interconnects
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-icc-msm8996-builtin-v1-1-3e3d1b0a78ee@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGS8XWYC/x3MTQqAIBBA4avErBsw++8q0aJ0rIGy0IogvHvS8
 lu894Inx+ShS15wdLPn3UZkaQJqGe1MyDoapJCFqESOrBRufmvatsLp4vVki0oaMk1dSp0ZiOX
 hyPDzX/shhA9ZdhGIZQAAAA==
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1388;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=7v9FKgUqKFbpR+fiy5xFQPfdqVj5LYeiTEIerHmnZCs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmXbyezRg2NvWoC/NVyWFt2Hij37OOgNDKwEMK6
 dH+jGLqhQmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZl28ngAKCRCLPIo+Aiko
 1SlhCACyo+rw+aQQ/5D9jp16CjycJtktp/q5cCsnW0GxjWkDu0sDvTxVmqBzM+xqGvuS4lTHBn8
 4zO25no5hGLgkei7dJluN9R7SXwQkMg9WDWEVM8CuDEPPISjgmN1C3hEP/DZAkvTQBIQ3lTRDFb
 sEW4sB48qBmToBC485tb6t38MqOHwBCc+eCeW9HXNRkHC72TnpitNQcy77V2FE4tYLscKFa1OLq
 2RvxoHZAn1oJWWz+WJXaZWiFNd6KyjBl03KS6fma8g7QpGvh9GKcEIeu+apSAEznmZ33JhXPxKM
 nbjj25IPZ93D99uVyeWbtwqI7UIZgPH62/NYohsxDu+/WEIM
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Enable drivers for interconnects on Qualcomm MSM8996 (Dragonboard 820c)
and SM8150 (SM8150 HDK) to be built-in. Otherwise boot time issues are
observed on these platforms.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/configs/defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 9a467dec78b7..d4d0f8e05dce 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1597,7 +1597,7 @@ CONFIG_INTERCONNECT_IMX8MQ=m
 CONFIG_INTERCONNECT_IMX8MP=y
 CONFIG_INTERCONNECT_QCOM=y
 CONFIG_INTERCONNECT_QCOM_MSM8916=m
-CONFIG_INTERCONNECT_QCOM_MSM8996=m
+CONFIG_INTERCONNECT_QCOM_MSM8996=y
 CONFIG_INTERCONNECT_QCOM_OSM_L3=m
 CONFIG_INTERCONNECT_QCOM_QCM2290=y
 CONFIG_INTERCONNECT_QCOM_QCS404=m
@@ -1610,7 +1610,7 @@ CONFIG_INTERCONNECT_QCOM_SC8280XP=y
 CONFIG_INTERCONNECT_QCOM_SDM845=y
 CONFIG_INTERCONNECT_QCOM_SDX75=y
 CONFIG_INTERCONNECT_QCOM_SM6115=y
-CONFIG_INTERCONNECT_QCOM_SM8150=m
+CONFIG_INTERCONNECT_QCOM_SM8150=y
 CONFIG_INTERCONNECT_QCOM_SM8250=y
 CONFIG_INTERCONNECT_QCOM_SM8350=y
 CONFIG_INTERCONNECT_QCOM_SM8450=y

---
base-commit: 0e1980c40b6edfa68b6acf926bab22448a6e40c9
change-id: 20240603-icc-msm8996-builtin-c2fef8752d1f

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


