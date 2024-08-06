Return-Path: <linux-kernel+bounces-276833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E639498F8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C78E1F2478F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF15156F57;
	Tue,  6 Aug 2024 20:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWxPVLva"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A4773451;
	Tue,  6 Aug 2024 20:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722975747; cv=none; b=ZHg4Bo+fuuGwPz+0TnEx/NZFjuE9VwO1IgmFdNKpnSBpLOrMQDRFREPL79sskA8Ah4xP5kGIbng/96riFnDFfEqP2LP1kc45tfKEkzIpe2r5lQjw0eXomol5290K7w/IvwcQQzJyIHFUXDRWB8dqHpRj/sMXvdg8exKDE3HNW0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722975747; c=relaxed/simple;
	bh=1UehH1pGCUFdoG0/yVfsbSMh9oR8Ng/paZVkFWPoBUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QuQIpzSRK3kbUGc3jylow2AyvEwIst6rbAsQhARPjgyjquJ9BqWBrpHjbXulWWUdUHbc7EfCbPebjKYbPRTPAT8cuF9TpEt/WzfIaYPwjc5iDLI9yQBqqUC7o/1ekmu7QmCdHI618DTkiwAtI6qr/KLZgi7JQrz4uf4ri93Dzus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWxPVLva; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d2b921cd1so863940b3a.1;
        Tue, 06 Aug 2024 13:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722975744; x=1723580544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hTE2LSD9ZCfRune++U0hEtyJGWxkgZISaVyuwocrVk0=;
        b=AWxPVLvaTb/dMIoO/MmyVkixlJA9ECbl+2SlM2dUnASe4Nj6qYBPpOwY4LjL8GYWn3
         yIxOQBYyOjohLH9dCkXUfGaox9iKzN39YacjukmReR6Y+a6erWjEa4NvELx3T8GT2RCp
         IYu6wMX7acQC6K0SOYzPq2XCFKVTDNahz/eRkniUu73WCPMKJpxkMAgySZqjHaPXhqFu
         VHarZPP4DPkMQOPrQugVQSgeetjUeWdRkv0bzbd27G2IG1yT3ShJW7XUbVbaYUAL9dpk
         EqL98q4vahRMmpo5pxGZbGGMb7nkermc5Gh8epwM/9lo3rSf6QeZO3qGjTeOLQ2B+WRk
         n5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722975744; x=1723580544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hTE2LSD9ZCfRune++U0hEtyJGWxkgZISaVyuwocrVk0=;
        b=u4R0RYyMrZXki038TgeepcetPGuICiiw047AxXFoGpm1SfQx28PJ8/NL/tLd8XPMtj
         71aDFAaGCnAsWc9+wNOWLfUkbtuQnTkaurAwS1R/eAHOiF4UCYJV1TlmZQi1PKmC8VvQ
         32z3vpg++mjveUe/M149iNPTfhzaVtlZhOFJZilTLF/1dPjQG3S5mN11nJccSxfSfu4X
         YimLBFvipIoxstGe52i0qEsSh/5RJWUIG5C3BZDbELpMITsxDWmps9jj06jDAr8YsAV4
         2CeBemAZ4IguWFLHaWFSrmva6nIMDjDi3zNwrtzt9kocuPZ0giNiZjiezgxBeaM6A7Ci
         Vchw==
X-Forwarded-Encrypted: i=1; AJvYcCX+rphnLCd2KIlAgHSEUsoh8cEazV4HTF3CHgIYBGSBVQdcAsHw6+ihC/+1cuYY0EOOkyNIajPO8lfeA0nFSs+PzGtfe3hvyJHZaIU3yCgZ2BlOidyj2Fr1+rGrNR0OeMysLfQmCJI2ZA==
X-Gm-Message-State: AOJu0YyXOawvbWPCzoyW6r/KfnAEGnrnCdRI1thNkdwoXSJ1+kaPxekH
	lRZlvHwNmZIEVd/P/vLea3Ym2XLQf4Fh9bP1hPoei6CqYuA2A2Pghql/Dg==
X-Google-Smtp-Source: AGHT+IHH1qllS350PvhBadejZF+21WBuAZ+wsvQjJCk0aX65nDEnvaPdiw9c/ZGpuDrhp1N0zZzhyg==
X-Received: by 2002:a05:6a00:190e:b0:70e:8d38:2845 with SMTP id d2e1a72fcca58-7106cf930b0mr20751638b3a.1.1722975743480;
        Tue, 06 Aug 2024 13:22:23 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:12e9:d196:a1e9:ab67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec05bf3sm7579626b3a.13.2024.08.06.13.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 13:22:22 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Clark <robdclark@chromium.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4] arm64: dts: qcom: x1e80100-yoga: Update panel bindings
Date: Tue,  6 Aug 2024 13:22:17 -0700
Message-ID: <20240806202218.9060-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

Use the correct panel compatible, and wire up enable-gpio.  It is wired
up in the same way as the x1e80100-crd.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
---
Corresponding schema update is in drm-misc-fixes

[1/2] dt-bindings: display: panel: samsung,atna45dc02: Document ATNA45DC02
      commit: 1c4a057d01f4432704c4dc8842b6e888a91d95df

 .../dts/qcom/x1e80100-lenovo-yoga-slim7x.dts    | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
index 70977e9fa266..3c13331a9ef4 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
@@ -190,7 +190,6 @@ vreg_edp_3p3: regulator-edp-3p3 {
 		pinctrl-0 = <&edp_reg_en>;
 		pinctrl-names = "default";
 
-		regulator-always-on;
 		regulator-boot-on;
 	};
 
@@ -592,9 +591,13 @@ &mdss_dp3 {
 
 	aux-bus {
 		panel {
-			compatible = "edp-panel";
+			compatible = "samsung,atna45dc02", "samsung,atna33xc20";
+			enable-gpios = <&pmc8380_3_gpios 4 GPIO_ACTIVE_HIGH>;
 			power-supply = <&vreg_edp_3p3>;
 
+			pinctrl-0 = <&edp_bl_en>;
+			pinctrl-names = "default";
+
 			port {
 				edp_panel_in: endpoint {
 					remote-endpoint = <&mdss_dp3_out>;
@@ -669,6 +672,16 @@ &pcie6a_phy {
 	status = "okay";
 };
 
+&pmc8380_3_gpios {
+	edp_bl_en: edp-bl-en-state {
+		pins = "gpio4";
+		function = "normal";
+		power-source = <0>;
+		input-disable;
+		output-enable;
+	};
+};
+
 &qupv3_0 {
 	status = "okay";
 };
-- 
2.45.2


