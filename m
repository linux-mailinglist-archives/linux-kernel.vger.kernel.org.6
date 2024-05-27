Return-Path: <linux-kernel+bounces-190247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E978CFBEE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484611C21587
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473A913BC30;
	Mon, 27 May 2024 08:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V1ZjYX01"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A7D13BACE
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716799373; cv=none; b=QKq4IFFO0CbruYVnTxM58azsjy8TwJTNcEfoJkY84wc8CKDAJYtseG4N9JYfMGEjZ3OJ/eB/u6HYRwXErkCo9elXQ2c3THgYtlTGUIaBs+H2pMjzCUyNON5JZpQmz4steuhn8UdPYxea0j5xN3UjaDrYlDLqbiXuh5elusQTaxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716799373; c=relaxed/simple;
	bh=NP7tAZcAVmpxoSMiDaYof/jNrt5rk0QngILAlS00ha8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CYbQPOD2I3Nx8AkcRQleA0TICqS+Nl59guCQidWAQJ7AONdl5SblcZ9J2fP2NHFj6NjCnwmUZaXUJKGDpQO3bNCb4Bn7DIMs5dQQo4rwk5nDp2/Jit24AJgWyCDsIrMxaCtYdXrUJ8cU5t8OMh5HA28TA8rc+BpH/LJCXHhJL6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V1ZjYX01; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-351d309bbcfso3625737f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 01:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716799370; x=1717404170; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D2LJ1RO9W9ZmiplNXqoAHVuLIaBqUKAjCRHOSbo1zRE=;
        b=V1ZjYX01Mr0vVSKeHXfx6yyysTwL3OK5RyK1iRr/PDjnG2wupcLPmzBcEMdQm/H3AQ
         i68tKlr0UsTTtasukbSal/WnQyC7sow7ZYjqnHC34QH2NK+BrTU+1xl0hQuuvB+QNgUC
         cYBslXbGDT/AOo/3gTggv9hnfH+Ro1p9qesKohlnyIS968TiIZdPH99xeU6k9ouZhzHH
         V4WBbVPP+74jdGg5RMovaO7IQMwPfj7kXzSccLh6r8wzXguHza+rqFDr0CdnBor14hF3
         HjqnxtENXer8VAoJfYpVJAEZotLg4KcbXdMEMQm2sT1fSr4aFHdP5gLgT0iSdF0fBDlD
         2zYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716799370; x=1717404170;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2LJ1RO9W9ZmiplNXqoAHVuLIaBqUKAjCRHOSbo1zRE=;
        b=uDumkL29kbrypClISgvk/WvgreymS1ti/FWS1yInbbsLK1WcchVJh7ZdSG9fCXy2ss
         sFWk28waAzl+POxWnbjAie9A/zlchDsSVW8tpRQIfsHdcT4C3xRjYjGQVKScGiSlt+HQ
         rukRjQb/oaEuQLWiSr7CG8DqdMt3mODDWo6FlBBUTjUniCEefV/qeUqQi6bJtHr3S7O2
         GiiHg9vxVNfJ7VkszNEhkeRpuwWswzRCy/0mAJDK4ykhdkJ46AnN814As76z0rn8HHd2
         KnZA51pBiXo2IZaKgKjUvF5jI/yY4ivnO1AMhYQGwncVX4yAzWXolT/jKG/YCGxA200x
         +DEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN8qNMkH5BYzgfsHnGUL8EY+dPvBs6jF2Dx1W4+9KfC7TZavuE3sL2c1Qxkc9NBLppJPBEl8xYwCj8jJE+xX2+2mRJ3ARLYEDEBFuS
X-Gm-Message-State: AOJu0YxG9HgDH3aQwA/Kvigt3SCMMKQ6lqiHPmLRh1davBxsq49+3nU9
	olDX+U8BRgtEdcUlf2juKQlruR53BnTk43qE7meIk70HvSAr+FnJhdGOJKgcZac=
X-Google-Smtp-Source: AGHT+IFdORbL0x+whnPJfYGPCVw/jWchVW0zPlS/w0jEjLQix7QZp7p2sKG8QPCYe49sDQQDgjJXgg==
X-Received: by 2002:adf:f707:0:b0:356:49a8:7e0a with SMTP id ffacd0b85a97d-35649a881f9mr5480493f8f.11.1716799369998;
        Mon, 27 May 2024 01:42:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3558889fb57sm8447292f8f.114.2024.05.27.01.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 01:42:49 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 27 May 2024 10:42:38 +0200
Subject: [PATCH v2 6/7] arm64: dts: qcom-sm8650: allow 4 lanes for
 DisplayPort and enable QMP PHY mode-switch
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-topic-sm8x50-upstream-phy-combo-typec-mux-v2-6-a03e68d7b8fc@linaro.org>
References: <20240527-topic-sm8x50-upstream-phy-combo-typec-mux-v2-0-a03e68d7b8fc@linaro.org>
In-Reply-To: <20240527-topic-sm8x50-upstream-phy-combo-typec-mux-v2-0-a03e68d7b8fc@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1513;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=NP7tAZcAVmpxoSMiDaYof/jNrt5rk0QngILAlS00ha8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmVEd/GpAuxlZ3geRUZpWH7CVDUJQ+wF4m4uHJPlkw
 xEjpF7aJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZlRHfwAKCRB33NvayMhJ0QqwD/
 4whHfSuSohMllMQlciqb8HcpyxsE0IsTyef8jOv1thGDKh2GRgoQfuBVFEmnGOWKm6lXQnbsSWT5A7
 VxKpp3BJsajvzeHB5r8mXfbORE7U50+q+/C5SStC1d+PYO2PRPiVufnyTAH4NSEiAs3gvvrvNFf3Nq
 u/P9uNDjYvlKjaKkDSjeDZFEEBcIE7rTROL7WHUVG0iQn38HH6vdSW1q9MpbLkHJqBYmxFPRUoMWwx
 6vf5kUiJTMlJp3+1TRMAq4+V4tN9UdAu2clLHDOXU/AQVaYMjFi+FU0n1daQ6XvMNBZFRaenmldfg1
 SXI5HgnvaYA44fffD8YXljYmoG9BOiIYQva87CQNrRkqi7VHfI3yj6qDuiHHD76T8yMTMy0a+7oaOL
 qJnQGpUaKXR1adDbrD7z3ldmWIlba0szOiUi4frySzyR/b3sbvoGsyWv2nsH7XDsZovk+3o0yUV9g0
 JPIEwV16rHsse4bMc7wnZnnzthXtaupo2AS8BuC4uQ1oB86rKkd/a7mP6qHw21Y23w5hYF7/5l2dH5
 11kg31CAn9m3ZL80ckaVmCKhVZqHZBUwJEY6I1xgEXI9LN5DxBcQjVJm8zFOQSIK3SXuwuHs1nrxeu
 4wJjofJsorZ7Q2uSX4uDdzwb5dWmrU1X56HM8EVsDQ8LeOx8FiKQEzzjpS1Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Allow up to 4 lanes for the DisplayPort link from the PHY to the Controller
and allow mode-switch events to the QMP Combo PHY.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650-hdk.dts | 3 ++-
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
index 3791c36579be..9ab07e265321 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
@@ -872,7 +872,7 @@ &mdss_dp0 {
 };
 
 &mdss_dp0_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	remote-endpoint = <&usb_dp_qmpphy_dp_in>;
 };
 
@@ -1229,6 +1229,7 @@ &usb_dp_qmpphy {
 	vdda-phy-supply = <&vreg_l3i_1p2>;
 	vdda-pll-supply = <&vreg_l3g_0p91>;
 
+	mode-switch;
 	orientation-switch;
 
 	status = "okay";
diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
index bd87aa3aa548..884e846842f5 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
@@ -831,7 +831,7 @@ &mdss_dp0 {
 };
 
 &mdss_dp0_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	remote-endpoint = <&usb_dp_qmpphy_dp_in>;
 };
 
@@ -1224,6 +1224,7 @@ &usb_dp_qmpphy {
 	vdda-phy-supply = <&vreg_l3i_1p2>;
 	vdda-pll-supply = <&vreg_l3g_0p91>;
 
+	mode-switch;
 	orientation-switch;
 
 	status = "okay";

-- 
2.34.1


