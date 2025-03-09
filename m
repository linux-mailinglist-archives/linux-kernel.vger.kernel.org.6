Return-Path: <linux-kernel+bounces-553170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDDCA58522
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F04316B57A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975C21DF26E;
	Sun,  9 Mar 2025 14:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w35sE8cB"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367891DE8AD
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741532257; cv=none; b=DwNkehaMu4ta3S+f71EVrafSaBx010fdf03sXQmNcyahsbGnsX1U3U5z/6pBxkQO4BOTaBtWNxkebEb9OLvS+v3xjkRw4JgynFBTwF2WfpZpYZRjs0Ab7EzhI535FnH71sJbZw8a1AjNyG0A3g6Ro8IMYefWcy9HYuCXIFI0xPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741532257; c=relaxed/simple;
	bh=IbCqT9Qj0SRvRVX35LE4R/zFAo0wm/0sOgn3wEptBnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jXTa3vVKEApLtdlD6dEqRSTun8o05ZH0GrW3CTOgQVhuWAxkyhsg8YXBuNFWQBXvx+9aIGc/zESuZRhN7zltHEznkVMcJwlZaNC+g0GIlgaNTaNV8UQMPORvrb0dlsYl7WUXnza9vwkaV/f9DRaSPoldtqO/LBBGYpSp27xss7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w35sE8cB; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3912e96c8e8so1778226f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 07:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741532253; x=1742137053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvuT5K4ef7yME+rjzaW3Rw8HkErqmqjuXIV88zDMXzk=;
        b=w35sE8cBCLe4/xzsZSpcx1s9I7nL9YCQSk96kezHKA6pWpDdsj0OJ3kZXcrQjPWY6P
         E4k34xvLyiXdVM3J/vd5vAu3oOTEFz5c2ueOeluVbb1K2MXy0YFDFT5L7atHy3sP73u5
         sqKYo1zzwLEHX2p75sa6I31HsJIcFEaGovHzxNo0fMGTADLaKzOQIrWgxVjs1S+HeVuu
         MvN+haDJXC3OVPGsOp2buSL24/BnTrGxefDGW7dvotpif6D1ok7eoUwcOAt0VlqQbbMF
         eTNaPo8kN+3Jpfk27w7bMwb9DtA4G9nMdNuQHA2hlj3PltZKyJFKLVMUNul/xBV5JF+x
         IWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741532253; x=1742137053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DvuT5K4ef7yME+rjzaW3Rw8HkErqmqjuXIV88zDMXzk=;
        b=ZprVB9YKuB50l+rGpziTvC4lAFZHVyOlrO1KLuBWOWEo8dn+cBQz7iHauZ3jHIKvnc
         zD38q1f64lqYXqVBYxvpg+BJLSv6teroBBNHdhY3tCeoDDytWViJVkg3pKMKXi1/fDYz
         ErYfBLTzxN9zMyQQA9CXlr4DdJ5H07hx5rP59QJOx90Tt2E/AWq6eohrQLASFbroeVXl
         VwxjHPOMNMN9c6RPGl/ihYp4RUFxlnUTjzG6TBi4mSdW9Xw81zasyei8Mfp9EKG2/FlK
         9VcZKjJatUmQDSxsNzCto8ogHDtHs/sVu3dsiagWG8nCzz5i3CIv472m0AuEYZ8EespT
         kfRw==
X-Gm-Message-State: AOJu0YwaV2qWaohCL6VSnENjfdj5YOly0r49Uz53dlzOnQub9uiXnwIA
	F2rN/F+uGEfXwEaYtBrXZoN3278Fg1rteHFAQ8uWmUKuxbiStmckOTo6kZgeUIs=
X-Gm-Gg: ASbGnctZpZ0xztfpnzKjlkh8IEnRi6UuhfyW52MCVWDcLRG8oda367hrSt1pS8AI/xT
	tWzPhzEDWt0JqCCnydS87/1cND2HHn2+exTBhgtZQNBw0GiLGxYfE81qazf4EDtiemudkQELgEw
	c+ZAZcuA4Pv6ffjyvjsTIUaw7gWRn3/9hUpNsgjZyksmwYxSUo1IJezSemu+GKc/I3PvaEGo9xh
	rV5HgJEOmG0koUwvy9K4Vhsq2psD625sH6IKzbwwi+ErbvPC8JPi3xtlG/YjiPgy+llc6WQGK7+
	UmpIXUZ6nlfSty4SZLdE0mV7FqX5A1IrA3s5VOB3tzLKkD4VPAPayGnsfjvKYloCuBcFhQ==
X-Google-Smtp-Source: AGHT+IHj8Yxp8xFaWltHqDGJXcBZqAKD71aqnMTh6a8tAGK16l3ggJ3eIqCi4oIfwPA04cTyAxrChA==
X-Received: by 2002:a5d:588f:0:b0:38f:3b9b:6f91 with SMTP id ffacd0b85a97d-39132d31b0emr5193500f8f.12.1741532253577;
        Sun, 09 Mar 2025 07:57:33 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1031fdsm11744899f8f.89.2025.03.09.07.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 07:57:32 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor.dooley@microchip.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 03/13] dt-bindings: nvmem: rockchip,otp: Add compatible for RK3576
Date: Sun,  9 Mar 2025 14:56:53 +0000
Message-Id: <20250309145703.12974-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250309145703.12974-1-srinivas.kandagatla@linaro.org>
References: <20250309145703.12974-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1584; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=315j7te8DHIX7CoOXD6y1qrlOdPkjXrIr2YKi7/ZYms=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnzaw5X2vpbjTlrfTExYn+V6o2x+tqTgVZJEb2u /xU1V4GdbKJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZ82sOQAKCRB6of1ZxzRV N8hyB/9iVK2q4Kk+Igvvu/7iHePoJsUu2YwZSq/al4oDcINh4d6rjW+hQ3V3auLhyP+MV1FxpmZ L18KEE8Rn6HIYRbZC1f3gAivT9LAR4S8rHFcmUla5Czs0W+zEqGSErRdDdxWZiN7a8cMD2ovgVD JJKTp9wCtoqWayTd/779zVt8bPy0fAM9j6UGy1hu0jaBmhOIYXtuNpCpzxTV8FCjXzFeU960GUl ZFrFii11GN/NIO76wXIhNZeVnaIUEuSEgWZuNRZ/oauXyfeb0zmnit77EZi0LVbEmltuU+38Dai 2MzignjYq6037BKs7X1ZnxjjDon1/4VXiU37uXw1IhzvXJ5v
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


