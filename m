Return-Path: <linux-kernel+bounces-227191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063D49149BB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296B51C23027
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1EE13C68E;
	Mon, 24 Jun 2024 12:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A+dboVAt"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A3613B58D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 12:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719231830; cv=none; b=UU5A9vJKLTGnpDzgXC03dxAjXiy2t9kVhzSDo0tdfY9mIMKTX/mC0EJfY1R7f1Cs23M7CqjciObWsyPp5SAHWVn955u/O91uk4pMY3pAcmi8Ia63r3taxnkmGkvJKHOpOwkkZkJhSk26WwL5h3+9pGlq5+qdmV7jgy4hC+ZAFVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719231830; c=relaxed/simple;
	bh=0JLcBlxBF1CQ5EouiC1Dz7k1uVMBWlZ5X6xh42cSKM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fCbEN3KJhvGYl4f3AaOfN7Ijo2KbjsgBjJI3r+H01Y1GGtETQRuoh+JP2BcJ8TZYje27rAa2a4sUj19csNxbAnZY1Hagw6ZaCkE438sk8IPGp9XmthFpGmaisZAlMkvG820nh452imcYgeN1XvAs9GP6aArg2+NtGaW3BrCy3vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A+dboVAt; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57d1012e52fso4827337a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 05:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719231827; x=1719836627; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Odx0fLzh+4FMy3cnjjmB3Hy+zkRCziihVyVwsUQEb5w=;
        b=A+dboVAtG+42HQlYWI/SmnVNZwJ1gkm4dTfmsaTPpLonD+2p7XheJpfy4pzqf9YP56
         P1B+3uERrRxdZCAUdvr+8QOPR2GSiVUY7Qy924Qw+dHEUJEodPzOazkcxbrLSzFtrn2y
         UtfkvzSoox9+Hawj8a+euu2d1RUKcPdhUMb78pczBVaPwob8hPpwY6ByOqRaBZqtuXf9
         S1F/04gd5Sr4Idsey9ZUv7rB8a4HUryt7LBhXHU58qMC4cdLnVmdYUPiMEhVEktnEtaq
         8ZWFtMXYa1Dpr8eW2naWaxuD/KsGn7T2EmGeNBdcAgGI1ysARvGwrgEkfzsL4eNEVsQh
         Zrlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719231827; x=1719836627;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Odx0fLzh+4FMy3cnjjmB3Hy+zkRCziihVyVwsUQEb5w=;
        b=W0ws2Fega487fcW+rJ2RQ+nB0T+pUFZR2V1NACjBYAmjfYG2cwy4KCwytwT4UhMQqV
         KhN6oE18dmBjZt4P8M3X1lAMyM9g9jvInBJ0YvhLx3Yf7ecOuOXXadUXca8Xfo70AnNP
         AAoEFeMIRDAvnh9ILPL0oi0Zpz2nvQOGuHkFeiB5cEi1+Vbezqm88gMQ48RD4YTYiAEr
         wNymqxuapwaebYChW4QmtZeMmEHmqpou7DqHpBi+Tv1+eXrl43TeZbudpRh36OWUsaef
         1pwPDy0G29JkpJCataxH363snuvVMFAL1/qDYhvlWnPs+UjuCzLdsnj+OIhSI0CZC2ll
         Vs7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCaowl94pQKEPLevu7GwFlYCKKSMOLIH6MR+tldzciKS5HYXGYXRF4i0TWupolqgoR+7LIlNKha3XTTBeW1wKnMp98DT7Ll207RmP+
X-Gm-Message-State: AOJu0Yy1dV9mC50EtnRIE7wJVavMoMedoW802nNZ0K5yy92fWiGtALzN
	2zZk172VTnFRTfq4z9MEW/hTej3zfw9q4Cnga9zSsq1dYnSA43+1tDI1Owdj2eY=
X-Google-Smtp-Source: AGHT+IGxlFHDX1ADf1sDQI9KjtUXLyAsqamQKZLJTTUq7sQxeUmjX75UnGfM5wS3MaK8MLjowVWIew==
X-Received: by 2002:a50:9b42:0:b0:57d:10d2:23ef with SMTP id 4fb4d7f45d1cf-57d4bdd96aamr2171763a12.42.1719231826709;
        Mon, 24 Jun 2024 05:23:46 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::52af])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d45496336sm2946824a12.22.2024.06.24.05.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 05:23:46 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 24 Jun 2024 14:23:42 +0200
Subject: [PATCH 1/3] arm64: dts: qcom: sm8650: move usb-role-switch to
 sm8650.dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240624-b4-rb2-fixes-v1-1-8d763ee4e42e@linaro.org>
References: <20240624-b4-rb2-fixes-v1-0-8d763ee4e42e@linaro.org>
In-Reply-To: <20240624-b4-rb2-fixes-v1-0-8d763ee4e42e@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2264;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=0JLcBlxBF1CQ5EouiC1Dz7k1uVMBWlZ5X6xh42cSKM4=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmeWVQtP4Ui74DzyiwuAGnvGLYnpA/uUISm/YAt
 jIZHx3GjO6JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZnllUAAKCRAFgzErGV9k
 tuoZD/9TJnnMm4mxFnjTTahkjMfFYZI/4q94ZJ+htE6JvKySoVFp/fODw5NV+Lecy+7UBAvSmVh
 b+zUKk3Bdb72AbLHmrTNEzPPROG3LqwuE+g4GW8PvA+8QELzTmp994LT+5HB/zmlNq8bpUGZw1D
 tbSmPk7JciMBzGxdDZxYElLXIRF1l5otwuCd0u4ysU5Gqwwa1Fs0lytzK+hYHP4RpW0CGuWTGzA
 ZhdQ+EFVyE/uIxdJvAgRPZ4TNo8WW9lefGojHgXI3KPXnpVooIBCcIaYAjqZWLOfX4MCtMfGrOC
 L5IRNgI9NBpg+Aj1twV4ogR6fRTUO7pKhkbDWzFK0mvdZp7/8dKCh6dMV23rgEMy6fkKNrXXS5F
 phy2evxNtTGyoPN3KomZWQwrdq69WDHTud4A91X4kd/9JwnaTp2L/+ZlQHsTr76r1xH3KtNbg5I
 cuk4lp8mwbUkxmJ1UJuvT3XHSJwjHfwqOyXrRvVs8ZOOVkRtCQaLNFkXnCzTEiPo76P4NDkX1yd
 wHcpr7XQtpcpDL7dcs/KWYChRRG7v5umLPcsctn5A9Gavn+R2JljmrQkNBZ6+DJ9cn7AWrgMtOE
 FPcefPjNLWBdPkHd/GOXige1TxAUxY3oeivvJEtbaZ7qDteSnsIA9bFZMXJDdj0qE0P4r8dOayi
 xZ32dbDDOWW7u9w==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47

All sm8650 boards have role switching capabilities, set it in the soc
dtsi to deduplicate things.
And drop the explicit dr_mode = "otg" since it's the default.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650-hdk.dts | 5 -----
 arch/arm64/boot/dts/qcom/sm8650-mtp.dts | 5 -----
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 5 -----
 arch/arm64/boot/dts/qcom/sm8650.dtsi    | 1 +
 4 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
index eb2f910b4f58..092b78fd8a3b 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
@@ -1300,13 +1300,8 @@ &ufs_mem_phy {
 &usb_1 {
 	status = "okay";
 };
 
-&usb_1_dwc3 {
-	dr_mode = "otg";
-	usb-role-switch;
-};
-
 &usb_1_dwc3_hs {
 	remote-endpoint = <&pmic_glink_hs_in>;
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
index fa6c3b397f2d..d6f91580ba8d 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
@@ -839,13 +839,8 @@ &ufs_mem_phy {
 &usb_1 {
 	status = "okay";
 };
 
-&usb_1_dwc3 {
-	dr_mode = "otg";
-	usb-role-switch;
-};
-
 &usb_1_dwc3_hs {
 	remote-endpoint = <&pmic_glink_hs_in>;
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
index 6e3c4d8dcc19..bd60c2770da2 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
@@ -1285,13 +1285,8 @@ &ufs_mem_phy {
 &usb_1 {
 	status = "okay";
 };
 
-&usb_1_dwc3 {
-	dr_mode = "otg";
-	usb-role-switch;
-};
-
 &usb_1_dwc3_hs {
 	remote-endpoint = <&pmic_glink_hs_in>;
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 8af151d924f9..8647ca314506 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -3857,8 +3857,9 @@ usb_1_dwc3: usb@a600000 {
 				snps,usb3_lpm_capable;
 				snps,usb2-lpm-disable;
 				snps,has-lpm-erratum;
 				tx-fifo-resize;
+				usb-role-switch;
 
 				dma-coherent;
 
 				ports {

-- 
2.45.0


