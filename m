Return-Path: <linux-kernel+bounces-319924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0659703C6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 20:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BAD91C212F8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 18:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1644016BE26;
	Sat,  7 Sep 2024 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F2OW4QDQ"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2B7167296
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 18:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725734908; cv=none; b=AIuK3BKZRRO13ooPKYU1nEHseWtAIsq90Kh4/ZC9TwoBeOQNXLvBGS3jJZUGPGOcVLQy832xQ4cVzL3nzZr/zAZr7KQQxpwX5hJCxEcNWiw046+hOwr8Lvu5fNgsw7rj9mFwNFXYhPpIK0GsAWSFV+/TcKexN4V47pJ0x1OMyFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725734908; c=relaxed/simple;
	bh=m8Zi+I7r4mzRkaQx4Q0uAvjUN8Er2tlAYnR9jC1UHiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O+U955JoGmTvyFu/XU+pJah3DM/EcyHbcrQZbx9drp/l3fTE7yeYeUlya212pDyF+CWxB37t3UpnT5U9P6XpBj2Ez191IqHJeRKL8NY4Uu2+LFzxNmpig0JahLz8clyXoBLaPM4FRJqSFbkFMqMNqsM1ra1/4HT+pWmG20eMJlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F2OW4QDQ; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f752d9ab62so21418331fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 11:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725734904; x=1726339704; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hL1dl2amOVSJoO70LsDuP43oRXVn+WYe2abWDJx9WBc=;
        b=F2OW4QDQQHDhtnUmOQolvCbBFVIpg+FVfuWCqYm0wmtSJvSEBPzc1JAPSewtb2UMc/
         JnxchQrEhnGFUz/uzMwoyeQAadTIov45F77s2ghgV4Al1RkMlYg2bEcnJMRfGMZLcqct
         teJ7HYyzwe9tLvL4/HHWBQ66GXfoxsPz34K+yGqFwFTyZsPcqlNS3LIywYhYT9hW1owj
         i3ZRCeBdEmEVvC1DZZIUX2VMMe7IsiqaDu3rF+rpFtl1vufLTiYiA+cKoHTGSoDJORfz
         g/DehRAjU02F+xgaWNLJhTQjElbFu5U6yuNWiCYElosVhfSoE1+Larun77dtwp3c1aNb
         uzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725734904; x=1726339704;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hL1dl2amOVSJoO70LsDuP43oRXVn+WYe2abWDJx9WBc=;
        b=COPJUCh4uBJg6ErW/PX/zunlsiIzxUemlHQO/2Q8j0IilF+OFtHwXwOZLsb2nxvz02
         d4FOVDGNtR6TtltgXWHZ1a7+DWdiVJKXXtjQXYgGPT33txPvjrD/8TBP89Z6FLsjbX5l
         tltb+G5mj1ulFV3SxvIsoVWywDenN+VxACPCU+tw0Ezl0d5TMNuS4F0JTTMwukVb2YET
         FIvYMmP/AVaFHTlKUcvqe4t6JXJlt5hX0sr5Y5X4N35ugY4GvpD7eC6iG2yuMac6BZnL
         Cd/9tLf+kEasc1CbGvj9j5NITvvBqggT+E7KDxerh0WNoPXeNEtMOkLOgwiRlQt3ZaAr
         7fSQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6b101Wmj8b+ZBOrGNdJLjkEucijrSPLlup8B8kMrstIVh42DsJF9nBCXRbEWfHAUTRIhVELcnTxotORA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo8UxM+peu7sXmvwpP5D7pCgphUzYJEFivOU6pCaygtHOiMsWR
	/dz1iL7U+8PyOE6sUYEFAyAeQ8xJbBQXvKXb86LH00wXBQYqgUjw96gBmsWT9D5/VzPHgH3G9Pc
	9
X-Google-Smtp-Source: AGHT+IG58gmWVk9fhlraqb5aPvd2mdHJvcE/HBMUnVruL6uhb+sYPDa968ikGXxOgKNrOey3AJXC2A==
X-Received: by 2002:a2e:be9e:0:b0:2f7:5914:c22e with SMTP id 38308e7fff4ca-2f75b87ec72mr17930011fa.6.1725734903789;
        Sat, 07 Sep 2024 11:48:23 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f75c0b1af3sm2271861fa.129.2024.09.07.11.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 11:48:23 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 07 Sep 2024 21:48:17 +0300
Subject: [PATCH 6/7] arm64: dts: qcom: sdm630: add WiFI device node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240907-sdm660-wifi-v1-6-e316055142f8@linaro.org>
References: <20240907-sdm660-wifi-v1-0-e316055142f8@linaro.org>
In-Reply-To: <20240907-sdm660-wifi-v1-0-e316055142f8@linaro.org>
To: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1627;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=m8Zi+I7r4mzRkaQx4Q0uAvjUN8Er2tlAYnR9jC1UHiY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBm3J/ySmr6XcpVpgukwQyVFouN74yoqzLc+oHg4
 jmtygX/pVqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZtyf8gAKCRCLPIo+Aiko
 1dPwCACKHKRnAYP+o0a7nDiomZPJ1StU5CG1h4B+3pdo2s5q7n4Cbpk91b5RsdifWtVHW4QQO4K
 vnX2NV+OIvBQhHNbNCSANijMPk8Hf4DbIinGV1I9G1ShIdGjvv7rfq9Su2OPFFg1WOussGxre+E
 6hGbLT2YrlZKtO5HKTYhEC7IrlftsXKHlCPxZeld61nTxWJZNvzJoifbqZMCT3UCIy8SWngE7j2
 YOKLzOU67j4Li2c1yO/AaIGhjx1DYnn9rOP6hAe+cmgxifCW0XjMTv4uEqV06Ulh8b2qFaSWHZh
 QCeOWE4asT4+t9tcQaVmspLRVXYSq5CtCSAJNYxAMMUcHmts
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add device node for the WiFi device being a part of the integrated
SDM660 / SDM630 platforms.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index dc8bc63bdc70..4536fa45869a 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -2412,6 +2412,33 @@ intc: interrupt-controller@17a00000 {
 			redistributor-stride = <0x0 0x20000>;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		wifi: wifi@18800000 {
+			compatible = "qcom,wcn3990-wifi";
+			reg = <0x18800000 0x800000>;
+			reg-names = "membase";
+			memory-region = <&wlan_msa_mem>;
+			clocks = <&rpmcc RPM_SMD_RF_CLK1_PIN>;
+			clock-names = "cxo_ref_clk_pin";
+			interrupts =
+				<GIC_SPI 413 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 415 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>;
+			iommus = <&anoc2_smmu 0x1a00>,
+				 <&anoc2_smmu 0x1a01>;
+			qcom,snoc-host-cap-8bit-quirk;
+			qcom,no-msa-ready-indicator;
+			status = "disabled";
+		};
 	};
 
 	sound: sound {

-- 
2.39.2


