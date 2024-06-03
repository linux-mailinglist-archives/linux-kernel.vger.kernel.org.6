Return-Path: <linux-kernel+bounces-199131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AED738D82C0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A88728946B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6D1129A78;
	Mon,  3 Jun 2024 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TwXyOVrZ"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDF984A50
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717418955; cv=none; b=fV8ZGpGO5O4xztXlnotYugUTQw1fPwrfaa5GI7aRTSC+a1cro2BAbuy7l6bsA3j/dKK0p+IdGgsXE9j6VXEn56uZynVZXh7FUwU8qnQ51UhisKvREnh3/VpAXtU/+kL0XZN8uixS338xHbJiOcJxEKwVPtg7/aMEbU4yJy6FFyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717418955; c=relaxed/simple;
	bh=j8KndF6/ZOHYOE01U5ocmBeiSxz+EVrLkoFMPmuBDwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=p8Ywfd9FMh14jAQ3cKqyEWfT9RX01B0CC/+lKW10ij8GssiSrLztINIRu9CEC1aGXhCWXP7RZAHNNEXxu9zjOngPS7yIZRQJF0oVy27fVeNinPHV1j8aHd9PKUgieP7eD1j2THA3z5lQdYIecjDCvROrIlfMGhkBIVNZBZ8BYIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TwXyOVrZ; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eaafda3b90so12130301fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 05:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717418952; x=1718023752; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fHP7lEVpq4ve8OrCbUPc3mP38ofIqfLhRNWA+cJRRKo=;
        b=TwXyOVrZQx8F8m+XhEWOJfdty07OwqHSRH5waL6YCiQoaYTGTTFrXGMkwLt55NB7Uf
         uIcllUznN8gUDnZ3nPs91/gX9Z5Qz/hOxO3vFZMM/bg8OVDuzpunl/xU7noHljXYlOTp
         lyuaGzz7uzB87Cjwj1yPVRad7CQeZxz2V7CeKmbQII67EEjS+mvMxXLqHoJ4yGXiy1zi
         J5D0vaEhB4JWeDqJaa3IhG/uoVU/tJn5JALAkxJstJn6p0+UKLBl6iFT/ivtR7i5Epaj
         ZxRDzPN9aXp3K6F0k5hnupdS0xuKAhKULz74FpZyVHngzCDoz2Yzxb3ICBcwmkwj6wl3
         YEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717418952; x=1718023752;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fHP7lEVpq4ve8OrCbUPc3mP38ofIqfLhRNWA+cJRRKo=;
        b=B5KPCw5NkTNIPEzyi1uetXesKEbyfuXEfI4yd5VTD1hMBgPp6M+6XCsnQwKesamE/P
         cws5Sojjr5FJ60d7AJ6R7sw4HlExX/3mmS2kDyzlZ8RfIWKPvpVXNUkJ6QUFoQLK4NH0
         vBLDATzXs9ghc5Ug+mu5bJk8l5utkDnc+kPxIFk7dKrgf7H+OV2V7SeNMGN19+16Vy6h
         ymoeErVIByMJHet41yArbGSUkhMiohQ1Msr9ObwwxiW9CSSGbB5unl2b19HhAo2TtUCw
         1crH6ZArAE1VaTY16lDsEMQFfFTb14cf2aFawkmUDbvcmdhFcCMHCYE75ug3isO3mCug
         kxwg==
X-Forwarded-Encrypted: i=1; AJvYcCVoWOMHlJTLLEAxA+JQy7oR13poXZDMiKDBQDBlxw+LsRnDffbritapXbdq+lh79knkd0LMHJzMp3NhAWs5PQq70Nmmu/Y4GOypfi4T
X-Gm-Message-State: AOJu0Yzl1eeTTH6dNlx6EDdXFTi5NUUts81LiOB5VSjGk4VfB4jK2a11
	ASEbWoZfJI5knD3n2p/lixOXUH3KxvlgliAdcRcdry0j9kJKWco2iPuu1+62JN0=
X-Google-Smtp-Source: AGHT+IE9Ayc4DcHcWLO5HTV2h0JFcg5QofiXmQEC4LCodFPNyXjy+AkOroRghE76gjgv7iVUiVX2Sg==
X-Received: by 2002:a2e:920e:0:b0:2ea:78e2:6a5e with SMTP id 38308e7fff4ca-2ea951ab3c1mr63789471fa.34.1717418951920;
        Mon, 03 Jun 2024 05:49:11 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91cefc4fsm12124101fa.118.2024.06.03.05.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 05:49:11 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 03 Jun 2024 15:49:10 +0300
Subject: [PATCH] arm64: dts: qcom: qrb4210-rb2: make L9A always-on
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-rb2-l9a-aon-v1-1-81c35a0de43d@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMW7XWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMwNj3aIkI90cy0TdxPw83RRDI0ujpMQU08TERCWgjoKi1LTMCrBp0bG
 1tQCVf3wxXQAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1048;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=j8KndF6/ZOHYOE01U5ocmBeiSxz+EVrLkoFMPmuBDwk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmXbvHIcYofH2bj8VO/+xEtwQYlhU4A6Umt5Ut7
 Ikpev1osh2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZl27xwAKCRCLPIo+Aiko
 1QRvB/9yr7FrJBNhg2KTb9jCzq7wrhohXwu1iHX1Tbq86qWBy4O6IHYuNTCyyCgjYu6pJlaUZZ4
 iKRhK8JSGHCDOjD6yrsoAYOIL6tpo0ACfBQwDpvgk7DDMwfIjN+E3rIliicnAPd1nC6wVtnC5Hs
 ZuNT8Ev8dC/9EppIiBBMS+KYFSDEaZujejcF5Zgjuq0e+E/hq4Q9SiiVpamrLkUP5rEAnqCJ9KC
 TDPdi305J3i1eVRi2p0bNPqWrKooaq9jSC7MTe1YQJt7mliF62inXa9OAd0/da6JAk3cplpyZ9V
 C5ewJJ9LUn82LSRO40W/MI3IGZLmtqhFdeGIjOkrDXFpbdFK
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The L9A regulator is used to further control voltage regulators on the
board. Make sure that is stays always on to prevent undervolting some of
the volage rails.

Fixes: 8d58a8c0d930 ("arm64: dts: qcom: Add base qrb4210-rb2 board dts")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index 2c39bb1b97db..e0c14d23b909 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -403,6 +403,8 @@ vreg_l9a_1p8: l9 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-allow-set-load;
+			regulator-always-on;
+			regulator-boot-on;
 		};
 
 		vreg_l10a_1p8: l10 {

---
base-commit: 0e1980c40b6edfa68b6acf926bab22448a6e40c9
change-id: 20240603-rb2-l9a-aon-d1292bad5aaa

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


