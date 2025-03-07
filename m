Return-Path: <linux-kernel+bounces-551716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC8AA56FCE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 340827A5120
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045E31A00D1;
	Fri,  7 Mar 2025 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DhMHpvvu"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E90241687
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370275; cv=none; b=eU48+lKBNoRjTD6cFjiW7DxVurxnH1tljeO1pqWULGDRsQXMSEgpKMcL1ePZuA0gw4pIpWJNB3u1B+hh3FSYq+N99unM0llsIg9hhiexLTmCVlJcaHPZ9KoVefULuJLF4kh3s2Z/URozqNHzC5HsXNjCEZcQTy78uKxADhdQBWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370275; c=relaxed/simple;
	bh=IbCqT9Qj0SRvRVX35LE4R/zFAo0wm/0sOgn3wEptBnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ih3IRtHvWJHozNj1qleZShDClx69ORf8uHWwBXYb31WrTaaDxafCNZq7ZQJIV7dooE0fa9TsTfpUBed+1UTKw9cGEothg0jCnCp4o4MwSeDKYypCMOy5ZJL0Qn7Xr45nHyIJJl2LRx16lTmVG/hjjEn7RSo29khPD19RveHThWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DhMHpvvu; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e5e7fd051bso1192167a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 09:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741370272; x=1741975072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvuT5K4ef7yME+rjzaW3Rw8HkErqmqjuXIV88zDMXzk=;
        b=DhMHpvvuXOsQfGwyUFJtDwVPMU1yMXPcY2NIEddkUr/ah0bODIanyJt4Z9VG0wzoi6
         8Jd918NfuiviSU/7gj39RYsuaJuEfuk8TwB2tZMs0MnTy1wBPSzMxc+CbJg+PV1THYN/
         laQD8GwXuI+8gaZTcX/XMfP4OvO/uv9QjeKqzaZp2LqbAjqg4ZM0FmWG6elBmYU+yGYu
         klP0vRAFkcCv0EaNeO8W31J4OtERda/GgdytQS6Or7ZrMPGaWqXuduJB1tX4KJNLescs
         CfENlVW3PZ0LNvPinJee4Sh/4Cdo5W0vxxHCwKv3syt0T84U9WhCVIoqRXY/k1LzsTl9
         DXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741370272; x=1741975072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DvuT5K4ef7yME+rjzaW3Rw8HkErqmqjuXIV88zDMXzk=;
        b=lUVG3+j8j/56N/godMaoLd8jXgilPzCg5YmESpWJzeT+MNXh3YkvU6LSJC99y60FR3
         GN5OpkfuO+J53mLy43kEVD1sBAmp7jQHy7lPEnYEdRCZ78dspj0N4hfYb2lVB2dM/MC/
         9GvYGU+yJU9aeBqT7+RrbYHYedoWVpbcRfOQmDuoS+JBdbcExkZ802rDPi/dnMq2ZP79
         DK7Jb2nlDzOvL1RniYIAdtw0yCQk4DE3yP9TfgWXrzfBxWtVoDgzJ5oAHOayDnszE6Ez
         am6xEzgcMh3bI7ws7JU7wP1AkXF/H7BNuNhVZOhf81OBb2tj3xHTNhVVLu0i5kAppJD5
         w0Sw==
X-Gm-Message-State: AOJu0YzRDvKcaoYZXuEtGQALEbk6Qtp1pjCSt7HrOJyrNpf08SoZSmnR
	rmnr9ZLCmX1Z/dRGH8jm7NmyExqncp+/o5U5A0ARNCFDiT2MGwqDob4fKTPEWvk=
X-Gm-Gg: ASbGncuPxoEOCNg2kvw24TA6Q4XxjX4/kjj+FPowfP8hWwl9YQa26pOWKY70bmC0fWy
	aVcKw4coi5cQcBJDzEDv3HDgPtkMiR32h6fAsRXisWi6o4wp18pqXMqlr8BvRm/auJf6npPlqfZ
	1kFWR5p7Pzuw+7i9LB4OJ8BqLgoHXmq+1i6kqTlHvevPQWRjI/UfHHssAtnGokAuNBFh6qxeKeJ
	7sdZKbjKSQqzrGAiT3J1jMTuMPn9gA0qHZeMnHgmhBJO2Vw7zJ++Xw6f0Uz2C2cI1svPNCNZD0P
	dsj8Yg16OcFWFS1G3UjUY5szDfGnMPSGnG6tZ4+CD8JWmAS6TJ5Bc0qhi/nbe6Aws5R4uQ==
X-Google-Smtp-Source: AGHT+IE4ezw8FQ24JlyTkcBqW5rO0yD2B4p1ijOda+WutzkC0kkpnBBUUPFAPtTVt7zgWVJzjzI6Gg==
X-Received: by 2002:a05:6402:2115:b0:5e0:69b3:441c with SMTP id 4fb4d7f45d1cf-5e5e24c5d92mr5592281a12.26.1741370271789;
        Fri, 07 Mar 2025 09:57:51 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c745c5afsm2803622a12.18.2025.03.07.09.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 09:57:51 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor.dooley@microchip.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 03/14] dt-bindings: nvmem: rockchip,otp: Add compatible for RK3576
Date: Fri,  7 Mar 2025 17:57:13 +0000
Message-Id: <20250307175724.15068-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250307175724.15068-1-srinivas.kandagatla@linaro.org>
References: <20250307175724.15068-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1584; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=315j7te8DHIX7CoOXD6y1qrlOdPkjXrIr2YKi7/ZYms=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnyzN8X2vpbjTlrfTExYn+V6o2x+tqTgVZJEb2u /xU1V4GdbKJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZ8szfAAKCRB6of1ZxzRV N1S0CACcUBD04S+V8BMsZYzmRD3TpEB+vg9kcD+UR+RAvlau+hdwjX7bnZ2dvDdXYeTvWRf9FVK F3f/nYDJMtgfSd4ezqGGEfrQmBRmUwqLGg6OCXHx41H7KyuIF72YddGNuzDuBo5MYLS4NxYJtDy bWvA7b21AZ5WkzVrnAwfRo/qFkumOFatKXMCN9m8B90znsyEAruGzN77GehLJPWr414LS8cLMwF /d9JqiWOvlv4UKbEoQhq6Ouv0DzgEDMPDl0QlX+uxBm/hufDpyg3UDCmsN8V0dPp5MVOidBybwt LFWEzy03WcxIdY8JuVxosEec6JLVJq68Ch8ce2QTaO8ZaSCk
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko@sntech.de>

Document the OTP memory found on Rockchip RK3576 SoC.

The RK3576 uses the same set of clocks as the px30/rk3308
but has one reset more, so adapt the binding to handle this
variant as well.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/nvmem/rockchip,otp.yaml          | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml b/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
index 3201ff8f9334..dc89020b0950 100644
--- a/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
@@ -14,6 +14,7 @@ properties:
     enum:
       - rockchip,px30-otp
       - rockchip,rk3308-otp
+      - rockchip,rk3576-otp
       - rockchip,rk3588-otp
 
   reg:
@@ -70,6 +71,26 @@ allOf:
           items:
             - const: phy
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,rk3576-otp
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          maxItems: 3
+        resets:
+          minItems: 2
+          maxItems: 2
+        reset-names:
+          items:
+            - const: otp
+            - const: apb
+
   - if:
       properties:
         compatible:
-- 
2.25.1


