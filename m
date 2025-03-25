Return-Path: <linux-kernel+bounces-576038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF68A70A2F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7169316F468
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220C71F0E43;
	Tue, 25 Mar 2025 19:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nTbWBWyE"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CEF1E5B96
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 19:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742930507; cv=none; b=DMJB2pUmyPeNhyvHTjFpMuzphH+9rpTwzyo2gdZ8AXnrzDkP1CtMO4/FzQmMNHfKR8/q2whSqqTEHXv7pDQfuUYlKnfUB7+R4IEMl5vEE7CxIQUFb5QW8e6WhJuP+aUzuS+MY6ByLje8A011b/M1gs+3oYmqgEGKHbSJQXVjdJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742930507; c=relaxed/simple;
	bh=Nthaz0NG4GUzoxW0ejlW+T4NO4kSTaE/go27pedcyso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oQE9RyWP9NhPXKZc5i2yJggvJdfdGq7HuroWCPZv4dejLiwbbxQldgmRM6MUOUzSKpq5qPjPH2PDRp0EOzWVxt2S/AnHwq0eUmNVasWJr0z0KIXs16qkbbJpCpZPVeBHsL2EY6dGhWpSZdHK6cwIhXbCeGvQMLqfVkbcgYOoR+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nTbWBWyE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so48082135e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742930503; x=1743535303; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NX3X2Lw9o8HyqDve0bpkran+lwUmFVl0q3xx6EdvBX4=;
        b=nTbWBWyEXtujxkhHLdEeTPAk6HO/p/K4qZKoLHn7vaO1Npw9wE26hO4gw+So701Ib4
         ZTjIzQQY/iQwundgfdjD8WYZNQithihJjt8KFCUsMOw7dhw+5ortYsavPUGEp2hz/eia
         TlAi4A1eMBHR/7KUvct3up6h0pO9qsOlRphgBLI5/pkWDXdlSEcfJUYzYM6XMgU4O6eH
         0kMALtSOTV30krpRM+Ou8SIrsyRhB+ZgzkMWdyiK/wFkJNfhJwRsCU8yec1CMrniu0Nb
         I9HWT893j9cCdvLbskbKDhAwmgB5H7c3ONI1e6/5v5+LBeXFLG3/+7vylsE6saWWJxUg
         w9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742930503; x=1743535303;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NX3X2Lw9o8HyqDve0bpkran+lwUmFVl0q3xx6EdvBX4=;
        b=qeIiQzH2SkEeIoqzMCANVD8HZrr0mCJcH8aOwYFIxcE3K8rWaCcjkkgR3kSAq/IC+u
         OpI3pS7+VBS9Sx4Azf9HJnUIHPhYcaYtp3gRdZZhwjFGeuCZnRLReeBK38iLo2b/5J7f
         DokvqoRXchTMMS1685K1YuMW63Jf+Z1bQKpT33A0Bl15G/FZhphfk5/jmtHW9JJgfwWb
         TzMlRCyB3KeLEuBygXy7S2SYrB5MVEvIniAx0x2aa3mfv5ShwkFhBhLHrwTIu8Qr/ALq
         xqb3SnU0oWNrfyQOcLSApVsgjBOVX7QqMyYuyrj+GkG70+0qweTu2LJD1Guf/Q+F378p
         kLQw==
X-Forwarded-Encrypted: i=1; AJvYcCXh7VlVdjnCch5PVLdfaTGEQzwwWD9+FPSsU0TP/b1DG6JguQ0DRhKOSC+1ZTTy967bumZ1qPDJxZoiQPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhBnWZwRK8LXkR1ZBI+EU03XbDquoAyey9krFAtAfu4nf8+0q7
	wHddaFxcGB0rdeYntvri6q+V1hR+mselCJGqO2LDSzE0BgvF12DgYRb6YXEamrY=
X-Gm-Gg: ASbGncth/cwpwYvMRUdcdPXfqQEWa5RiytLN9N14BWpDC7hSbkpuWQlz9fMcuafdsMr
	Kzj92F7bUSCbKLtLP5K2yLolPibPO1G1A9lo1EH/HNRk4MjSZR+Vuyhx+ZhfoYHalq0sZHlXYIR
	m5wVKm7LtfVWkX+RKvZePxCz1BfLHCorHMRdwK31ps9/4Px7zXAiHyvE+EaNnA7MFzzZnnbOFar
	TPU85Fio9WDNp4y1ewvWwWR4F5h7r4lBKnfW/lHHwSUv+HIF5uRuQ8kE6zeYp3Ev6CGOATCik6a
	9BOWeXxS8QNfaW9yt5dN+LkFRv9xR4FdyDw0KS3oOmGsQ7uyT1hhlHPvRmGbL4Dfc2g=
X-Google-Smtp-Source: AGHT+IHJrql0z1/Oqero5ZGyDYqpm792+Y1VSees9b0ZQC0BjriRq7qtGyhraVJ5zsff8nRKEETpPg==
X-Received: by 2002:a05:600c:12ca:b0:43d:7588:6688 with SMTP id 5b1f17b1804b1-43d75886820mr10210845e9.12.1742930503539;
        Tue, 25 Mar 2025 12:21:43 -0700 (PDT)
Received: from localhost ([2a00:23c8:b70a:ae01:9cf7:b69:fc50:980f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d43fdaca8sm213330615e9.28.2025.03.25.12.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 12:21:43 -0700 (PDT)
From: Christopher Obbard <christopher.obbard@linaro.org>
Date: Tue, 25 Mar 2025 19:21:27 +0000
Subject: [PATCH v2 2/4] arm64: dts: qcom: x1e78100-t14s: add hpd gpio to
 LCD panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-wip-obbardc-qcom-t14s-oled-panel-v2-2-e9bc7c9d30cc@linaro.org>
References: <20250325-wip-obbardc-qcom-t14s-oled-panel-v2-0-e9bc7c9d30cc@linaro.org>
In-Reply-To: <20250325-wip-obbardc-qcom-t14s-oled-panel-v2-0-e9bc7c9d30cc@linaro.org>
To: Douglas Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Johan Hovold <johan@kernel.org>, 
 Rui Miguel Silva <rui.silva@linaro.org>, Abel Vesa <abel.vesa@linaro.org>, 
 devicetree@vger.kernel.org, 
 Christopher Obbard <christopher.obbard@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1609;
 i=christopher.obbard@linaro.org; h=from:subject:message-id;
 bh=Nthaz0NG4GUzoxW0ejlW+T4NO4kSTaE/go27pedcyso=;
 b=owEBbQKS/ZANAwAKAWNNxPBocEb4AcsmYgBn4wJFj2X98t0uiYe+j1XPDXnRw/zysHE5UWqp9
 uWjnbfunrGJAjMEAAEKAB0WIQTxi9yLbCX5CqI9UXRjTcTwaHBG+AUCZ+MCRQAKCRBjTcTwaHBG
 +JOrD/955KOQMYKGtxljAeIGHuWcjZ/P6LUTLpHgKDYqJKaM1/qzI+OfEzxDXv8lAUEz6+p/sQ7
 2jd0yryGySf26uxgE3BSbey1ETdbGTpjGSuR4t5SQyyYwM3A4kXFTZWcdCIKLO8IqOr/RzAL4vV
 vPN/pBcgjf7sgC5+Kw5MMi0MpgNf/b8SG8aOgOsDOLqUP9jJr976gqMSNJ4VkFamqYO9PkOSxME
 AVznSLYk7G8WB50xbnZ28hagju3n2WfXzLrGCmHLs+XM6fj2C5VhczeYVCO0zbA/nSb9UQvzQfT
 V7nIm4fYZh2BAJ/+++624WOpJjDaGigsZ0EplgXHA59yO3gxk2LDVkfXZURyZFUn5mGv+4nMfBl
 WW7hS7rfxc36vo5rAbSSUBFamyQ6GTEXYMFDNnPUVXPPduvSNqeWSbC4WWKyGVziWONuyd93B2B
 owKQqdtIPDr1cRf9jd0WWClG/uzUTzGY76XLY2gNKN20EN/xRsMylfjsg+a1ISyrZNGVDsq7xDF
 9lHJsZibfyaGzYZujO9zMT42/YP4fH4ByREnqqOdK9t01FQJEQjzA7QvnGEhLT+jOqzKifGd2jQ
 +kfCfPPgK8NsNVH+3+kNJUI+NqIsPEzVQ7KF+XTtBE40CRSWaGj5Ce8YXZhSWAnDd2Foz4aVTK3
 WGWgvoArKHax4Jw==
X-Developer-Key: i=christopher.obbard@linaro.org; a=openpgp;
 fpr=F18BDC8B6C25F90AA23D5174634DC4F0687046F8

The eDP panel has an HPD GPIO. Describe it in the devicetree.

Unfortunately I cannot test this on the non-OLED model since I
only have access to the model with OLED (which also uses the
HPD GPIO).

I believe this could be split into two patches; one adding the
pinctrl node and one adding the hpd gpio to the T14s devicetree.
But I will wait for your comments on this ;-).

Signed-off-by: Christopher Obbard <christopher.obbard@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
index 962fb050c55c4fd33f480a21a8c47a484d0c82b8..46c73f5c039ed982b553636cf8c4237a20ba7687 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
@@ -980,8 +980,12 @@ &mdss_dp3 {
 	aux-bus {
 		panel: panel {
 			compatible = "edp-panel";
+			hpd-gpios = <&tlmm 119 GPIO_ACTIVE_HIGH>;
 			power-supply = <&vreg_edp_3p3>;
 
+			pinctrl-0 = <&edp_hpd_n_default>;
+			pinctrl-names = "default";
+
 			port {
 				edp_panel_in: endpoint {
 					remote-endpoint = <&mdss_dp3_out>;
@@ -1286,6 +1290,13 @@ hall_int_n_default: hall-int-n-state {
 		bias-disable;
 	};
 
+	edp_hpd_n_default: edp-hpd-n-state {
+		pins = "gpio119";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
 	pcie4_default: pcie4-default-state {
 		clkreq-n-pins {
 			pins = "gpio147";

-- 
2.49.0


