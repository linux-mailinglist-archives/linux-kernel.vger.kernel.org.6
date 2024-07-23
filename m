Return-Path: <linux-kernel+bounces-259922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC27D939FE9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025481C22192
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5502915383C;
	Tue, 23 Jul 2024 11:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fgsSRuC5"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AC2152DE7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 11:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721734117; cv=none; b=gHMYUC6mrzmjiNLOPgTUUl618OjN9a+g4rJVgOeT8QBPBy8Zr2ZW1kGbxDw6x3pyB04Xbv+C5LSdp5zZFCcb1WMDnI6JBXfRjkszzEN2AMccdWZ+m4KuPDPdewZZ46o7M0ces4fv4w1URZwhhwMpqVJCQ1ONPHohtF9El54Ekp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721734117; c=relaxed/simple;
	bh=TNeB4h9ycrUiNieuk6ijYWqqH0HvXk8DnxEjo8Y8yNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ixZQs+DnM95NbZZ2tvOLocIvaFKm3yvUI+FX1VJwVXQUbkNtISMFMV8fKvqdsTjWDzKAOVjDps0PsVYXFCIBnEzpAWnCFKJqjqSUiGXUQGdpnlw3fX4PBb5Bz5h3ODD0NuTfMh086/ppK5acu89i1DsNSOmF3Oh53egX3Nr3g/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fgsSRuC5; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52efd530a4eso4214763e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 04:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721734113; x=1722338913; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nAlHzLrPx54OlQ0HBTC8gKCozRqM910DErW7ymog2BQ=;
        b=fgsSRuC5ebeWrAFLooOnMCK3CniPYR9SfoodYO7e4wRNJNzC267KLRJ/Jdr7ayCnRt
         wf8f1Me+tPqYKUEaL4+aNOAT8lgdXu2FAnBqVIl377B38NmQDNCj2eRn/JTP44U81XQ3
         pnnBHtQz5S6Cy0T3YFHi2yJxcfnHwc9ak5OHxnOTGYSvwaQjEBQyHpcbqQFeaAzb8uu8
         U7I2bqlLfFDypxlCFoFpDw+ZtJtwm3GK2s0MwbmpYvU1eCC2LdZs6BGXOyBLE0i8lbFl
         HWU5y8Yv1gNnZ2WdP4hjlFza+TNlyNsLMqE0Otnu6R7yo/stNKSi5JNs3oZVB9NAH58A
         ACFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721734113; x=1722338913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAlHzLrPx54OlQ0HBTC8gKCozRqM910DErW7ymog2BQ=;
        b=d7fHqqX2TbLSrOk9M8cUOqcLmoVpTB5LBO8YYecYlsNZja5qkPjl3kikb4SfJdrBP7
         CYoa3h9XrsWVvnCqU/diL277oLZEVMJj59PnxkrjZfXIiwjTPuCib7Mi3q9eyvdNPM0r
         RwnL/d3jMylYgc9dF9kifTpOBsQn3tU3siX4rQfS4NY3V9JRjLqbP+rqxt9BdagdnJnS
         pAy4/t99/e8o00KHgiI3TuuTd83h3jDKFPEEKkfZkLww9PTS/nnX2Aj3Iotgce0jZlWz
         UItWXa9hpJzPkc5+FADsSjMCOpceS4bRpHTJ5/PWtuRYWM46+FYw4g/Sb/PeJZ1eVEsm
         YnJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/VqZX32Ma1DnQaChjV4RZqOQ5xzWKZC2ihz9zsIoFMg+6jzhSLvXJUgwCIk86KJQexCfFn1ZMDD+Zk61mO1p5XLqsi5nYV4I6bYBt
X-Gm-Message-State: AOJu0YyqL+R2PZb2RO4xk/TklpYG6SWZv6hh/nK3wh1ElrxVT7SvI3sV
	0xhdlJQz/F0AdXft0ibjpwDG8cF2dnVKHTKljsb33k110QypE/m9cyLAzeM96tI=
X-Google-Smtp-Source: AGHT+IHna/bk58GBzfxHL6ZNS/OCvnW+Y9Hnj4qheHKHUSEUYFDFtMtAHKf1vn4uCYTyQwoZJERcbw==
X-Received: by 2002:a05:6512:3d90:b0:52c:896f:930d with SMTP id 2adb3069b0e04-52fc4075ba2mr1910381e87.57.1721734112792;
        Tue, 23 Jul 2024 04:28:32 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52f01552b43sm950871e87.286.2024.07.23.04.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 04:28:32 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 23 Jul 2024 14:28:29 +0300
Subject: [PATCH v2 2/5] arm64: dts: qcom: msm8998-lenovo-miix-630: enable
 aDSP and SLPI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-miix630-support-v2-2-7d98f6047a17@linaro.org>
References: <20240723-miix630-support-v2-0-7d98f6047a17@linaro.org>
In-Reply-To: <20240723-miix630-support-v2-0-7d98f6047a17@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=TNeB4h9ycrUiNieuk6ijYWqqH0HvXk8DnxEjo8Y8yNk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmn5PdcKsCltG7dPS9m0tKoFXiB2u4NhwvdCVuX
 3aY1pZGs0aJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZp+T3QAKCRCLPIo+Aiko
 1Uf3B/0SRKqihsb87Ln2bk8vVi3fiyeYYJPHrIGO/VfZ0qcJWLY25iZIJOywITUK9u6iNU01bI+
 zQwX3FX7gm3NqAmRHXXGOJB11UIPE8S+E7gUfBbTR+PBnmhuUavgeByWn97Ta9eqeawuf6Qkf3T
 vH51VzrjocRrSen9v06FmHdb6yV+DJ73Cm5Z65YVJr5XEDAAzbPlbg5l0+B3Nt2IsvVVCcZ+aH3
 DQEKx4T6tUIpkYk7+ueEVDEoWrFX5XRX+MqBeTm256yT3xlyxhZMwUy9pb/QDPo3rCzjBVyUCbD
 u/5TDHSzVdto0DoqXZOIbvn+eRYgvuWEqjHTw3pZGmBLKFf3
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Enable two other DSP instances on this platofm, aDSP and SLPI.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts b/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
index 133999a7ed2a..2430f17b2356 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
@@ -43,11 +43,23 @@ keyboard@3a {
 	};
 };
 
+&remoteproc_adsp {
+	firmware-name = "qcom/msm8998/LENOVO/81F1/qcadsp8998.mbn";
+
+	status = "okay";
+};
+
 &remoteproc_mss {
 	firmware-name = "qcom/msm8998/LENOVO/81F1/qcdsp1v28998.mbn",
 			"qcom/msm8998/LENOVO/81F1/qcdsp28998.mbn";
 };
 
+&remoteproc_slpi {
+	firmware-name = "qcom/msm8998/LENOVO/81F1/qcslpi8998.mbn";
+
+	status = "okay";
+};
+
 &sdhc2 {
 	cd-gpios = <&tlmm 95 GPIO_ACTIVE_HIGH>;
 };

-- 
2.39.2


