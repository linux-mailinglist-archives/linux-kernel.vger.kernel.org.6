Return-Path: <linux-kernel+bounces-350333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0BF99039A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6697B1C21BB6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D8A21018D;
	Fri,  4 Oct 2024 13:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="swTec+dz"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD63F20FAAE
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 13:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728047336; cv=none; b=HH/d20mShavM955OIW4Ings/k2Wg3iS9+Mv5Lf9R5HC50Vxb9sT7F7kWLag7HDvxRi35YFMFGUeWJ94m2vM3LXFgh/4/PaFlLs+Xz/dP3QO/rM8GFBbkaP0pNKeamJQIT8Rflk0GCUiAkUJpBG87e8/T6JVmQYuZkPq/kaaf7OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728047336; c=relaxed/simple;
	bh=tF/nPfzcP4R3ACI8M/wyhrpEI3K4Z4ckVMNRUoBu3FA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PZsPdnihWHjd0mlamjpxgP7qSJ2Jvp/dciH2ZwFJp67xyNu8mI3mgXDkm52X/0/Uc65qb6tOHTeedD7SCe/hIfRit3a18f1cK1N//AEK2lHYjH10EghZ+pCGunFUP1bTdfX/nARrxgkYfQttW3TKStSl1TMxj/mRl87oUpHPvL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=swTec+dz; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8a789c4fc5so554149266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 06:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728047333; x=1728652133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L4/AYJ0iM81mUlzV+Cv9ihjHBRLe4vDHy6tsndRIor4=;
        b=swTec+dzqbOKXdDH0yRc/7/GXtrHKjhcwpVfEHRq70oKRrfbwP/u9koyefhvNpwQgL
         kep7MCft0GIKS+17QNu/j3xvXakLFc64FcBhlbvKRAea7xUITEmtJyxXIKi3BmXjNpJZ
         ItjB9zGbhxXpAeiNKzKQevHC2JF3dH6t+4sMI+fNaYv5MsvB9xdyhRaMB6uzAmk+1OMT
         uyLtSBUOGFgEJ400wvojzPLsflNUTaGRzHSfVrzoMg6HjshnKQIQLay/DJhZluJOKPv5
         GB4XFvmnp3lPE3JPGQ1Hs5KX0ANYRXiBMvuiK0M3YszYCy8wTSZR2FrGtAdXJ3dCwO7J
         3tjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728047333; x=1728652133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L4/AYJ0iM81mUlzV+Cv9ihjHBRLe4vDHy6tsndRIor4=;
        b=vazXSjJW29U6DyrOafnJlzZVPVCleOYLvm0U1BhTw43yDobq2DhafXGp2kmjQTkxSO
         qrmJllDwQKZkjT8+X5IoQV99cxB1eTD7UxvxC292pNGYopX3WITExKI5MMy+XapekEuv
         7VPTtp6AKUMR+urwULpeAG3wVFu1z9RWUkyOo5o3ksi8fa/OzU+sk0U7JaBFGc65hkY9
         Utk4segSrYxd+0+PpT+lSqhoqfVolwUrck369H0jdmydKdjZCzJOFc4/vmjxP+QQnQgI
         gq5AGOXfwFSBbzDqb99tjbw1jwkcYRL387vfFRmjgNjWLinkWJ6qsb64jiSELOT8iSm8
         rNwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhkjG7AdWbZVrgxvyivUDU7zkNXFtDDJn85eZhFqO4cnaEptJH9DCs+vh+Yhw4wpoaS1W20H8b0pcAAa4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwr8vaZSPTu4zXQeAtee/TP33eBXpc41VklfYrGCSTu1rHCJuk
	FIvsNsq9iilPh9FfbsTq23GHJJc5EHmc0H0fxpQvJbDzwlD1txxiKuKAC88Ke3I=
X-Google-Smtp-Source: AGHT+IHiJ3v9CjBWrTt3qRr2xzF/A7zLY9mPcR2zAOy1KSRnmopFSHDNXZvYDIFtDM+HRc42v+GGqA==
X-Received: by 2002:a17:907:7e82:b0:a8d:4c83:d85d with SMTP id a640c23a62f3a-a990a04e25bmr686995066b.12.1728047332978;
        Fri, 04 Oct 2024 06:08:52 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99102859casm222477766b.47.2024.10.04.06.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 06:08:52 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: andersson@kernel.org
Cc: konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	johan+linaro@kernel.org,
	abel.vesa@linaro.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3] arm64: dts: qcom: x1e80100-t14s: add another trackpad support
Date: Fri,  4 Oct 2024 14:08:49 +0100
Message-Id: <20241004130849.2944-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Trackpad HID device on T14s could be found on two possible slave addresses
(hid@15 and hid@2c) on i2c0 instance.
With the current state of DT boot, there is no way to patch the device
tree at runtime during boot. This, however results in non-functional
trackpad on Product Models 21N2ZC5PUS which have trackpad on hid@2c
slave address.

This patch adds hid@2c device along with hid@15 to get it working on
both the variants. This should work as i2c-hid driver will stop
probing the device if there is nothing on the slave address, we can
actually keep both devices enabled in DT, and i2c-hid driver will
only probe the existing one.

The only problem is that we cannot setup pinctrl in both device nodes,
as two devices with the same pinctrl will cause pin conflict that makes
the second device fail to probe.  Let's move the pinctrl state up to
parent node along with the parent pinctrl to solve this problem.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---

Changes since v2:
- updated commit log
- added missing parent pinctrl

 .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts  | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
index 08ec2419f95f..5aa295404800 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
@@ -551,6 +551,9 @@ zap-shader {
 &i2c0 {
 	clock-frequency = <400000>;
 
+	pinctrl-0 = <&qup_i2c0_data_clk>, <&tpad_default>;
+	pinctrl-names = "default";
+
 	status = "okay";
 
 	/* ELAN06E2 or ELAN06E3 */
@@ -561,13 +564,19 @@ touchpad@15 {
 		hid-descr-addr = <0x1>;
 		interrupts-extended = <&tlmm 3 IRQ_TYPE_LEVEL_LOW>;
 
-		pinctrl-0 = <&tpad_default>;
-		pinctrl-names = "default";
-
 		wakeup-source;
 	};
 
-	/* TODO: second-sourced SYNA8022 or SYNA8024 touchpad @ 0x2c */
+	/* SYNA8022 or SYNA8024 */
+	touchpad@2c {
+		compatible = "hid-over-i2c";
+		reg = <0x2c>;
+
+		hid-descr-addr = <0x20>;
+		interrupts-extended = <&tlmm 3 IRQ_TYPE_LEVEL_LOW>;
+
+		wakeup-source;
+	};
 
 	/* ELAN06F1 or SYNA06F2 */
 	keyboard@3a {
-- 
2.39.2


