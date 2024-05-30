Return-Path: <linux-kernel+bounces-195674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D768D501E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 18:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0134F2831E9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0D83B182;
	Thu, 30 May 2024 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wIsyQRLi"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C676836AF8
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717087736; cv=none; b=EfQaZCCaUk2N5+BudcWoAPNpW8CxHF2FVgflSucfCmBmwnGLbYcQFYH923nPMwVLcHlNJLe+AhsbWamcijpV9r3qkpK4XxrMKCq4U24nBid5QhDgN68q4eHIgOaDHUfadm6FTmLaZjoTzfnuw/TFzwAmi/av/eiaXUK1vWpUCTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717087736; c=relaxed/simple;
	bh=Ly2L242GxHMIF6bws/UEb4G+Luoe3LUDH/lBlpCDr0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Qf+lnYk7fylyd12Z0Ckst2CeX//TsAP0bMatqdv0OrVq3NJB1+hK8M1G+R9ACS38eYZ+Q+6SVrOJoB1yMDd5NEvjReGsjq4FanI2GtDU8Tr3MvcHNCxxVaPwwVwnW3rsV3af2/ef4RJCw3v82dSNfoh2W7KKBFucyR/dVH8Cq08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wIsyQRLi; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a66e9eac48fso50897666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717087733; x=1717692533; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Om7hhoOcUSUWV8gAap1fMTgLyjeDTgTrOUFgaKi03cU=;
        b=wIsyQRLi0emGlIpAzN3LA0ClAocAaD72is0N3Pf4UU7dx/+1Sjm2y9kd55db/tBp/3
         QbIiXSeoqnrIzmvAi8s9a54moTugdiOr0zO+7LNgXdYWGXkrVBavjbuj9gDodkvRaDIi
         TzG3YlVI2VDIYoVEj3ljJaZqFLALi9scR0IiiBbgGddVNSA1+hTwUGwCsGPXROE7CUHX
         MYzt/tHViTVk+Q+vbgAmGyQZ3/LZoACfFVs7LHaBd9VBBLTsQD/rAeJfEFY7TWxX1KUX
         423N1JrrBKRPczcqPpX6hv6OX17oKTncz6V9qf2GJauyLCTUafL4m64ShUwB10r9aK/D
         1qNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717087733; x=1717692533;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Om7hhoOcUSUWV8gAap1fMTgLyjeDTgTrOUFgaKi03cU=;
        b=YjpcWe7juTFb0afcxGcQqzP4uInkAOczdzHVtAbEH4vXn/FwJzT0XQvVGflbIejmz6
         X2CdMJRuWN5TrgV0X/Pn/3dGbthrGenWESpY5W3xQ5SciIzb2pv9MYzDzZh79zRisGXA
         i404dH9JEBTMzouHzxDnsdg+3iEfvL1PIfKimbzNc2VkjqFi5laG86XR5NC/GprdsTiA
         2bp1pU89HCyuqBiSYzDfYlutPZZGPQZkEpQUXSrF70bBPNEbuGD4OOsem3I62K3XutRD
         WTQezd3KJ0457jXrNB5f/azwmeULl5Q3kGmHwb5zo82Je1OKoQemebH3wEVX0AQ+iTtZ
         +qfw==
X-Forwarded-Encrypted: i=1; AJvYcCXhWL6I6W/APxK/gjwDWe4nC/QeBNDg/YxxHy99lyR+u5a6n2tOaD5JJI2G7eCY0fzSvWW8chWEKywwqvx8eHUhJBJeeVnrqb1bhKXh
X-Gm-Message-State: AOJu0YwgbLuv/cq9+OaaC6cd4rtFFp1VDESjnZg6p0izdjc1xmyBaG0X
	0oAJKk5i8u1GEU07PvkvGh1q/ZFVnO3055bFEFSD2xSRJwWrdQXJgyNHvd/VAOg=
X-Google-Smtp-Source: AGHT+IGOdW0rL+CG+2TxT+B5IJwuYU4JCsP/KJ3DZR0Uqrkb20mrEsEOuuSMX9bBLg43COFnBMG4eQ==
X-Received: by 2002:a17:906:f5a9:b0:a63:3702:def0 with SMTP id a640c23a62f3a-a65e8e4083amr240447366b.30.1717087732909;
        Thu, 30 May 2024 09:48:52 -0700 (PDT)
Received: from [127.0.1.1] ([188.27.161.69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6555bc091asm164155566b.138.2024.05.30.09.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 09:48:52 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 30 May 2024 19:48:44 +0300
Subject: [PATCH] clk: qcom: gcc-x1e80100: Fix halt_check for all 3 USB PHY
 pipe clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-x1e80100-clk-gcc-fix-halt-check-for-usb-phy-pipe-clks-v1-1-16c6f4dccbd5@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOutWGYC/x2N0QrCMBAEf6XcswuX1kjxV8SH5rw0oaUNiUql9
 N+NPg7s7OxUNEctdG12yvqOJa5LBXNqSMKwjIr4qEwtt2e2HWMz2rNhhswTRhH4uCEM8xMSVCb
 4NeNVHFL4IMWkv12B+l68dfbSGUf1O2Wt3r97ux/HF+D383OHAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1839; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=Ly2L242GxHMIF6bws/UEb4G+Luoe3LUDH/lBlpCDr0Q=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmWK3tl6uah8YmriTt3lwjpsK8x6CjrQVSP9BIS
 odeQ7reUGaJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZlit7QAKCRAbX0TJAJUV
 VuptEAC5WMgOjmsUB8qckUbsaskWG7PgeQwoMiZftXJw1gCuaEOOw6UtJJeSxGc5kVgvMgR2hft
 JvEvmNOZswIN/m0gTBcZcpC8DnGiIInTfbMDKkdkGP9/0EMG9VMJ4JpptjS//XrQUN6pAKMv42U
 tuioLIWwfrgCpFheWQhw4XSToWBzFgvuqJMYLhsqBvFDt5AApOXl9L+43b7rwoJMKXeCYK9jAPS
 fBdi6Fd1rfLHs1IwPzGQNSsWXI7QLcdLHlGqTzyAas/QLfKMAk+2lxBc1OWyHyaNTopyOPzCzfb
 LWnE+1IS6gvDy0iG4eYwxwmWF9JGSgI2DBs5sRXrjzWAVtREb7u6wbv9NfSFW6YZcQX8s06BarG
 yN9Go/2Pcd0RlcWcs56zpAIcMO4nKr3JlNU/CxWAOB9ne+Cphpw+DvThX7ZE9LNHI+RCwMnDjNi
 g1e8qkKLsuIDKa+m6spe0+qZRi0qmSucPahTkZJm7hWFciku+Et8rEKDSLLF1c+1xqcX1HdOD3e
 JjmdwKua3RK6tww7/e9iLWpTXUoHJ7sEQ2v3tAg4yTL1rZ82KXU6fGKglSSDjkP50KWrxFfJ7PZ
 LAE6s1iZ7QbLcIDEb4+B0BUVzsolewU7DY1P34exI+9XI+aq+vNuiv4LFgY/9HxV/eL8zdDDbsm
 KZVA65W0E073lHw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Since the pipe clocks are fed by the QMP PHYs, they are not under the
GCC control, therefore the halt bit might not get. This will lead to
the clock driver reporting the clock as stuck, but that is inaccurate.
So instead of waiting for the halt bit to get set, just use the
HALT_DELAY flag.

Fixes: 161b7c401f4b ("clk: qcom: Add Global Clock controller (GCC) driver for X1E80100")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/qcom/gcc-x1e80100.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/gcc-x1e80100.c b/drivers/clk/qcom/gcc-x1e80100.c
index 1404017be918..afff7cd14848 100644
--- a/drivers/clk/qcom/gcc-x1e80100.c
+++ b/drivers/clk/qcom/gcc-x1e80100.c
@@ -5186,7 +5186,7 @@ static struct clk_regmap_mux gcc_usb3_prim_phy_pipe_clk_src = {
 
 static struct clk_branch gcc_usb3_prim_phy_pipe_clk = {
 	.halt_reg = 0x39068,
-	.halt_check = BRANCH_HALT_VOTED,
+	.halt_check = BRANCH_HALT_DELAY,
 	.hwcg_reg = 0x39068,
 	.hwcg_bit = 1,
 	.clkr = {
@@ -5257,7 +5257,7 @@ static struct clk_regmap_mux gcc_usb3_sec_phy_pipe_clk_src = {
 
 static struct clk_branch gcc_usb3_sec_phy_pipe_clk = {
 	.halt_reg = 0xa1068,
-	.halt_check = BRANCH_HALT_VOTED,
+	.halt_check = BRANCH_HALT_DELAY,
 	.hwcg_reg = 0xa1068,
 	.hwcg_bit = 1,
 	.clkr = {
@@ -5327,7 +5327,7 @@ static struct clk_regmap_mux gcc_usb3_tert_phy_pipe_clk_src = {
 
 static struct clk_branch gcc_usb3_tert_phy_pipe_clk = {
 	.halt_reg = 0xa2068,
-	.halt_check = BRANCH_HALT_VOTED,
+	.halt_check = BRANCH_HALT_DELAY,
 	.hwcg_reg = 0xa2068,
 	.hwcg_bit = 1,
 	.clkr = {

---
base-commit: 9d99040b1bc8dbf385a8aa535e9efcdf94466e19
change-id: 20240530-x1e80100-clk-gcc-fix-halt-check-for-usb-phy-pipe-clks-ef8cf5b5631b

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


