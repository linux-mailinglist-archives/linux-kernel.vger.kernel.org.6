Return-Path: <linux-kernel+bounces-193055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6E48D2639
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD231C25DA7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6EE17F390;
	Tue, 28 May 2024 20:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cExVx9eq"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1C317BB3F
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 20:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716929024; cv=none; b=bBs3hMTIBupUNztSaJGhPq8y+PoBIEWqjauMgqXUg5j74cJ26mMSlqXaSoqf/K4M15dmZ0Az/CKZHlaoiY/R+eggjAvQtFQmEuJs8Nv3G0AWkl9OIE52T7AF9ESj8g+SmgoqMjdSVoo8HtaKfY+0MVf9CTuKa3djMyZpTBVUWPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716929024; c=relaxed/simple;
	bh=07w4w+wcz+s8WoLWWVideIAadh1jMDKIz4U0xNk1izU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RHPq+O+V/oeNdO7xKBH8AHyqEmeERMIybIG32UjpoyBAwg+6NS8cH1bHWkqsdfZEaloJNDO59CDTsKTHZ2bkAcYQeXwCu6OrCnT2lbU0ArdLNqWmeFYB04/WjlyWZasoY8TOPiFdhrABwdomTASLVIxYjPCUYrr8dWzil7m7XRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cExVx9eq; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e95afec7e6so1943351fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716929021; x=1717533821; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jnc5iU5guGKDIIwBfgQZYLnSXcG7LxADDm3Oopk5kxo=;
        b=cExVx9eqjnlbOmrAR8mJcq5WX8qnNs4jmLufT4q5bGUXHibpkHqC4/8Vozhc7IU9eQ
         FMGBCbEfKMIDi6bG51ipKQ+LZkdtdmLmwVrGpGNX24MRt+lcDRsNNfHppeG/MSKTbhet
         Z1/Eo+pdHXl4v5Y/2riXSPu+xYNhpqjajlA1mamQfazKHWCTRwHFPY8us/IzJMUCAsVt
         hz55Pfqi/fv2RAFqPW29+qP1ScT8aBCaBJUJkUVHFB/UwJ989JSIWBnwd8Hxs8B/vmhI
         a9jURHe78BxvmPLniNu18APHrycK/L2HIQaPIbwDeqSJYx4GEpzwgBsNvnzV0Zl/NM+D
         94GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716929021; x=1717533821;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jnc5iU5guGKDIIwBfgQZYLnSXcG7LxADDm3Oopk5kxo=;
        b=wgfbDfADB5vPNS6cFJJF9IfVE9f66WJGwS5pdplR2gonnGyLM0areHmLgLfNlLUnc1
         554CCnOsHZUKmUajKxtdn4OUM8J7ifxK3FbzpZZLCoqFdC0/fw6sI11DLvUmBeA26FMR
         tiBUDeN70MD2PWOagTCO9emBUPBA2ljl9FdmV0fUgimaKD6IoReFqWXMcP1IMFgYoxQx
         Ozyy0mEiq+KVJlPzXWDL+FfVF0YcS0JDfUiWXl0j1c+X4uQP/Dw+2SFNCw7hSHnwD2oc
         ROfrBpSG+pa6EGrIGZy5rLiQ4QwznH2CB1Ca4T9RdmqzpHGRlSxoAAB6G7PsiJq5IH+o
         YDOg==
X-Forwarded-Encrypted: i=1; AJvYcCX2p4hHWLzQFQVCwfoKhbuDizy4HkzwL+ZgbYxqp8QwD2sxtb5RKv92G6T9GRhuzfZT/kA08i9SRlH3HW3A95X6hojOgCcuuN+k732P
X-Gm-Message-State: AOJu0YwagPZsMfjpHf5nyEdx6NRZA28Cks1wghDKK4XQaJEKW26FYjHK
	exRhCItZL78k5V9nY/FDC+pkUsuo8Ru8RYHxuMMx6b9UKycmGCxWplcAqxrDcpo=
X-Google-Smtp-Source: AGHT+IHcIoMb9PrU5vj1YBCtrYjK933S36hCq6C51LCaF3OkaMGsIdxzkjZ0rhqKdYTBNrJV9tOx/Q==
X-Received: by 2002:a19:7606:0:b0:520:ed4e:2206 with SMTP id 2adb3069b0e04-52a7900dcdemr45781e87.17.1716929019918;
        Tue, 28 May 2024 13:43:39 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5297066b885sm1095493e87.127.2024.05.28.13.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 13:43:39 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 28 May 2024 23:43:24 +0300
Subject: [PATCH 06/10] ARM: dts: qcom: apq8064: drop #power-domain-cells
 property of GCC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-qcom-gdscs-v1-6-03cf1b102a4f@linaro.org>
References: <20240528-qcom-gdscs-v1-0-03cf1b102a4f@linaro.org>
In-Reply-To: <20240528-qcom-gdscs-v1-0-03cf1b102a4f@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Robert Marko <robimarko@gmail.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=816;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=07w4w+wcz+s8WoLWWVideIAadh1jMDKIz4U0xNk1izU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmVkH1JVlxhFsDmBqnNXEoEupNMoWbv0zsZYUHR
 jq6uLZmgu2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlZB9QAKCRCLPIo+Aiko
 1bjAB/sF2oaL3QqTuQsxtb9JRW5yMofX0D4ckQRWhuzF65jn3xqEN/qhCXu55vcV6F0wjNScKXQ
 112dQQMozsVEC2O+qlcCc3nOpR3snwQ3ENZwQJ1gLB3igSOGD0XGtmv5m0t6zgdUNKncRq4pQJU
 JjIzct6TiCB5maUvIcUA4vrJE7ot209GHoBEdm0ku/6yu0bs4bbp4MeR+wUuQGTOUBoPX15gAPq
 mTt8OcPoui4hGQz74B7RMM5pCCyxwZ8MgSVSN97MyckDX5xesU+X6x/QRFxg0vsyKj1b6q6KdES
 obR11jgG1szbRyaF7hjDysMlvJSCzVXfOKOBgRbQuwwh8iEj
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On APQ8064 the Global Clock Controller (GCC) doesn't provide power
domains. Drop the #power-domain-cells property from the controller
device node.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index 11e60b74c3c9..178a3b424670 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -684,7 +684,6 @@ gcc: clock-controller@900000 {
 			compatible = "qcom,gcc-apq8064", "syscon";
 			reg = <0x00900000 0x4000>;
 			#clock-cells = <1>;
-			#power-domain-cells = <1>;
 			#reset-cells = <1>;
 			clocks = <&cxo_board>,
 				 <&pxo_board>,

-- 
2.39.2


