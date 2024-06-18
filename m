Return-Path: <linux-kernel+bounces-218899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D594990C77F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81AF61F223B9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF931BA886;
	Tue, 18 Jun 2024 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LIA+p9e3"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932991552EB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718701073; cv=none; b=EPd064yqmKzoaOLvv7Hs/0Vrc0Z+KYrJvQaM7d6Gf1pWc1r9/uye/CX7fflSA6s8ZYMo6ys1HlM3E7dc1a+0LZbGsaLxJ1UomeyjHAHWrI6KmfIfIcDSB1yRNAzxxtBQPhmDuUDZma36SUxaHPPXi5040OfGFYXRoWUrb9kQLTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718701073; c=relaxed/simple;
	bh=OfhHEECoMTrvbtNrNAx3G4SFmuDhLfL7z/fJS6M2isc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OeEqp05FpWTR9qkC6CpOEV1vZai9QwpEI4RV/z5vgbqQkQcgps1cMxaqFOEtA28RYSFCewQLI20mmi/rlo8pQlixnzoMQ2MTr7DxougYDISrMechJJ+1rvWPd/I/alAJbIkA+f+/IMBtf6I8hKCiEB9AlENn6UGixAytpAn+6/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LIA+p9e3; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6f21ff4e6dso695555966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 01:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718701070; x=1719305870; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gQeZLyvewF8YU8DnwJSqp6ymN/u0iZA0tyrclF4X+xc=;
        b=LIA+p9e3dawrY4Ai3oc55miUebFEArdtSI88Wn4nE+O9TnJrdWUYECoydjTnye9rQG
         ZbCDZgD4m9hd+diZJcO6m9LH7QIiwmhQO9cpufgDqwcVIqjoPXUWyGgl9SwQujLwonrv
         YESWQfdByaEgzXKCInWl5Cfyo/jWzpm5YgVNdrKSOuszhnTnent4J2vU/fNETfP5vhNx
         Uk8iM1L2Fgpfm/6ofVULiVGIaf8DDd9xBU1z6ehb6gYjYe6OZpdqHHugFQqygfHjX7VB
         02SryfF/C2tocWLoRkmaVIFDHUiqg6XBkfoNj6pOXpSz5RsiTx/ZlipCkl0yFtazFToR
         AbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718701070; x=1719305870;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQeZLyvewF8YU8DnwJSqp6ymN/u0iZA0tyrclF4X+xc=;
        b=hedy3Sil7gX4AH4PWZyK4iZLD5vGl0FuHb76EJVNzeDMHYuXqWMj7D+s6iTqGuFySH
         WCE18UGMGAlypDloBDmH6O2739vLjN3d7bWDCbcwjfsn51/hfAwJhd26fjKB29hasvwD
         cBf+mQGkiwiPwOuoZrvdne3cASuVB1X6gCyiLQcZUHev0Th6AQTE3eXeceEeRTDnbULW
         EAmS7zVJdzFx049l7vaem4iGcO/WGOSrw0HKGH2uCTlx6M9fc7LkP9lcw5f2e+uYbPCb
         JPoqK1W8fdhqQB9cJaSSm7oS9fpxaKKQk0X7mGPF97cCAT/dnxzPey4Easg78HxRj7YC
         iEVg==
X-Forwarded-Encrypted: i=1; AJvYcCV+gGX7zRUKZB6L3g5eXc+Bwgdi3FlIlEmeTkr8gWUYKLi4pXurWd+l0ZzV98ujOy1Hlm11S8kVK3JTI0X5yXIzBMxLFDFeIhFBxQGo
X-Gm-Message-State: AOJu0Ywb9hf7pnP8qOvfV+Uxmu9IaJFc9Rv+he473Ogb4t/nOGUZMKvx
	7WO9+fWvc4nHeTXGAXdl7qKJT6og+fHj1cHxkGxIj1tjcpi3+vVeu0lrmiA+B7o=
X-Google-Smtp-Source: AGHT+IGyqZXy5Y18iT2k+UrC5GF8C9JEdIPf7YDm/pJlw1f/llTK2DjwXfZqo1KYV/WwRuZX4jbzEQ==
X-Received: by 2002:a17:906:6894:b0:a6f:33d6:2d45 with SMTP id a640c23a62f3a-a6f60dc4e59mr687544566b.60.1718701069839;
        Tue, 18 Jun 2024 01:57:49 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db681fsm597748766b.72.2024.06.18.01.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 01:57:49 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 18 Jun 2024 09:57:49 +0100
Subject: [PATCH v2] arm64: dts: exynos: gs101-oriole: add placeholder
 regulators for USB phy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240618-gs101-usb-regulators-in-dt-v2-1-85632069201b@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAxMcWYC/42NTQqDMBBGryJZd4ozaP9W3qO4SHSMA5KUiUqLe
 PemnqDL9/h432YSq3Ayj2IzyqskiSEDnQrTjTZ4BukzGyqpKi94BZ+wRFiSA2W/THaOmkAC9DO
 43rmOLdUD300OvJQHeR/xZ5t5lJTXn+NrxZ/9K7siIDBRRXVFXY23ZpJgNZ6jetPu+/4FtBCfy
 MUAAAA=
To: Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, 
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

The USB phy requires various power supplies to work.

While we don't have a PMIC driver yet, the supplies should still be
added to the DT.

Add some placeholders, which will be replaced with the real ones once
we PMIC implemented.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Note that this patch depends on the updated DT binding from
https://lore.kernel.org/r/20240617-usb-phy-gs101-v3-0-b66de9ae7424@linaro.org
---
Changes in v2:
- update commit message to clarify that the regulators added here are
  temporary placeholders only (Krzysztof)
- use fixed placeholder regulators, not <0> (Krzysztof)
- Link to v1: https://lore.kernel.org/r/20240617-gs101-usb-regulators-in-dt-v1-1-e2242542c518@linaro.org
---
 arch/arm64/boot/dts/exynos/google/gs101-oriole.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
index 5e8ffe065081..dec2c6d9619b 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
+++ b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
@@ -145,6 +145,13 @@ &usbdrd31_dwc3 {
 };
 
 &usbdrd31_phy {
+	/* TODO: Update these once PMIC is implemented */
+	pll-supply = <&reg_placeholder>;
+	dvdd-usb20-supply = <&reg_placeholder>;
+	vddh-usb20-supply = <&reg_placeholder>;
+	vdd33-usb20-supply = <&reg_placeholder>;
+	vdda-usbdp-supply = <&reg_placeholder>;
+	vddh-usbdp-supply = <&reg_placeholder>;
 	status = "okay";
 };
 

---
base-commit: 6906a84c482f098d31486df8dc98cead21cce2d0
change-id: 20240617-gs101-usb-regulators-in-dt-bdbbcea25fe9

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


