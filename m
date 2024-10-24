Return-Path: <linux-kernel+bounces-379136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9AD9ADA74
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB5A128391F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A3F166302;
	Thu, 24 Oct 2024 03:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b="YS1al0VC"
Received: from sonic302-19.consmr.mail.ir2.yahoo.com (sonic302-19.consmr.mail.ir2.yahoo.com [87.248.110.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC8E167D83
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 03:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.248.110.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729740532; cv=none; b=M2Wfpzyts8MVULEw+VP5QkqRJ7R2ZoL0cX7zIHzfeLwgd6HUM8fLnzdTixGL/U4SZuzektQpcCvf+AgZx51lmQkpc/jniKBXAKpVNl8hC3Xccg1DRvHl2Pu23UJk511KTSLXe2oCioUDuagJuwSH+YzXUuJLVZQJr4TRdiSDLqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729740532; c=relaxed/simple;
	bh=YmCLPdVjJlDfGnVCThBsenOfYvoZ0YMHMPohOqFxsHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qejbdoq8ShO/z01nF6huW7kP8/FZEJz7IoKoV7Dw458ShOEx7FQ7RaKxU+YgE+0IbsHpUya5O2Bh06AVnbZVOv3ZGiKwLyIvEFyHqVhsi6Sv3Bf9SqDKpH/8CKhri4gyudKBmMidtX+B4XVB1sJkRe+X7FDMifp8yd/a/FDbYuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com; spf=pass smtp.mailfrom=rocketmail.com; dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b=YS1al0VC; arc=none smtp.client-ip=87.248.110.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rocketmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1729740527; bh=3xzqdMxf/0ZBOH+vce6LxIwlK1/hvHyOLExiGTyiQbQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=YS1al0VCmTBqd3k66373d1KyMSRGIHdnryXwJVVv92sUHHZKerk/5Q41Nq2Qe9ukpZSLchz10bRWfXWX0qnQDtYMvX2eEYc0UxQlVsGTsRvzNLx7wZwPq1iDMraz5dY4vWzhIldzeH6vSkT6i2wVsU2EzKuxZkXR8InulJ/JQ+L1xLuwZ9hun4j17u5bfx+RQOMB+8sQewP9RKhR7dtUHdcKi8vn4AaQm03ht1M/SOpqFSiicM95pPQax4yjXY67uGxVGs88Oc7s9AZO7TISmAnRRTG3aUU6VCAz1TXaOccHZfQXQT6y7f+1VEAtI+lbNoBWmXzAg4Vi+Rs7taTRMw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1729740527; bh=SaBGvPyw/xVueVNBd6qyRXQYidtorsyTGXvI4Lss2we=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=f8SKFIJIEE42FJY0nTWvhL407bcHEZWCmm7/czRJAAjO9Lqy1btgDhw/vXIeuyGkAdb4Sbypq4PxC5irp7e0qHWPOfKCJEQTKKFebd1WrWILeXe9Fw6s1+M7CARgOLqlf7DJB8uOIeOZouiglMtsA/kYOcBWCbxsoGatvI77TZQh8xeGqjWRatGXyvBv6wUkAKtqwd67YGSBmMtiR3WXHtZE+NQLeWqQ6ZP3aV2yTsVsq1dA6riNPkfE0W2G1kVdAi10AQ/pMzsgQQBksyFdfwhsjtiJqNpDGv2DJQpnlpILJbkhliQ0E4UqfA2MToseKeRdBdWATPaUfuxCx4LVXQ==
X-YMail-OSG: aB4uCdQVM1lZaXNaYAagW_h62f55Pz8BI.TllltTGSA3QYgKYBVbAnhk0QBBD3n
 JGyvOBg0501Y_qymG04mGr_8RgtOeJO1MX4qJGPJPH79UgOssUgu7lpz9mZg5_6L8QotXuFgtY_7
 1QmJX3nSo077zgDMaZIiKNrVntmm8YuDxrrLAUsGTBAewDDMTSRVLqj5jfLLUyfOKmyTF0xMwnIs
 WMgS.pKLYjUBtqHaQb2iWK0c3rNTtRT9u.74Lw0_ykjrYfTQQgmxonISRo2hjWgfdiQquAymGSsL
 dLmrdjw7C5qUiUMqytm2zif.C6t2HrxHRuHy17GhXzkqATO.6XOoxfAgxNkeytONLMi_ewJVlTXi
 pG4NL0GwlGHkym7Y3zoUJggR5SE5Ne6T8bv8g.pbZZm0zYfP3IjManDkWoZtFjrVfP2ZQt7fqRlV
 ptRBtlYfKFSAdr55SCIRflQipIFREHD5.P_v7EHwPvCb5kWWjlnr8exRPzeHJxH.4nkgy_1pLdr4
 _5pDRA4qg4a29uXk7oFufx5.F8nXJQ3i7hCSG9CdW0_alQd5w.Rx__eEKWYvjQKgpR7kXnGAR1c8
 B_JqGRYSxMAW95MJDWDy0cAKZ70cI78ZRwe7npPDxtCcrZe9O8tJzTXrrofKyE.ImsUkX8RXosUY
 bI6rUHiK0TrDTt5TCRLBAa7RSihnT1IZFZn0wVBbdkfdvC5fyGgqRsrYySC1xfhP40gmOry15c1F
 6dr3PM6vxdsAj9XEJhDebrRQc..M1hnKZRt6hxFV9j4pLTtHClFnJo59PQtAiJ.HafmCOF4yq7EF
 80wrnqIpoy0jDTxD3S00IxAdxK5UUn57_hSngWyKVMNbcWUDHMgc_4Q2LYJWoA5IEXGeD0n8H0Xy
 lCRKIhUNwobcqT3c4QfGbN3bCWaUdE8QWiHqxQsSU302f7te7RFREcjI5d5iyHzIYBeoJ4zxipgz
 GhodiXtgTv0a0w1AfrtaUOcF0bjXkRIOradq_Gky3boFfOyVj7hkS_Oj31lDZz7GFWEd0JQjGit_
 _j1rogNdFrVPu8mL8PKD4ISlmvKNZniJQi17Qf6VnfUF8jqIYHZPOkliIMTVvJ0qflCuObajKoOS
 VlS4b5ajKrRKgIc09Eel44Qstezkga6auMRLzcoN9tuF80jN0OsLITQTsg_Ysi5kLvDRbqtcQknP
 XCEfpwtkC_SPyXchwJJn_0tHYIcqOrLScerJf0IoRLq1ITgp49g7KEklNNa9n5CnKc.dyOR15NgL
 UeG0bQEEPWQfZFiLCl3FShBtKcqGJOeYeMUKafQPIWmxrArcZNU7Dsqh2UsIbiFYJJdJKBeq_a.j
 3aUHyV.vf_dmixQZjsW9FEIqv_OBna6yvx6fBKMoNvhbzOk3sqlc62e.2nZwsNJHn.FexJFepnPt
 nc779IArzi0eAZfcUald7HSvyXeyQsWgbjOGPdvpReB25yRv6Mw.x2470sddwoEaBL1eD0QMXhsw
 J9BW.gs.uUFj5ih0VK8rSSjM9u5mzvGb7ooNPZmDfZA1gJd2t1ZcKCcwG3R4eXQMs4t6KDYvzIUY
 60zhBWMxyoxrOrBFyTFmiltbrd.i7XZ14E4mBs8HdGNjlQrL4jtl_UZnUAFP.A_eBZSbpJP8ajtD
 lFhXUJ1WIBS1hJE64iKnJPYsRXaY1Jn6W0u_9QalAO2pkVs5U2Wg9QlhpsOrEVnbVJ.wvtLxwNvo
 Ei_gScIxpxXds2_eRyA7NptBYD0hBlhV8.BylnPB2xbwhymDcpdfzXFhncO2PHRt5_IHZhN29vb7
 FOEtwEzf7FZqtH3siOHGlu8oi8ypSHHqnqGe3lvfc3jvF7m7nSmbmRhVirrs5AyIe5llOjTsrPFR
 fuoXYjNGycsKrYAI6LMQmx4dsok3FCrBOfB2tzOroc46Wv9OF4SzahfxZDmeZ17DsiJS3U_U5zIx
 0K8JZMLBtUsjI_ufQSkn5_wMjxA4gaQ.G4ReBMkazTgOGjKsU6xDNlyVg0LNYfyD8wovblB9Z5qa
 ItrsdqJLVpUcg5TxgN2dKKGnUBuJSuQutorgdfxkJKjmzku5zmEzuZNdnC3C7.hfLL1LHs1otDjk
 Gsc2V9CfRsg7DlJ.8hWTG69sTORhpGhAxNG9BZYtxQjHFZP5qkE4HoRZlVUQx_RfOBhj1UkYceP6
 qHW6jKxQ6y4PczjioivpX.3xO8vZM1KmdZFb9j.SLDXnaW4IC5a_1.TSzvyBPEtjrD0DVqzReF_S
 tZjhVkTmtBJXo_8r2IEoh30sLnGbCWEeAco0tjiBie6t7CmCgAJ6IA4sKmy2X4L5vBdQCT2eaXGP
 cLmJ4bswGXGbvGWPQqiV3WA.H7hM6u5jgU1v0gOhVOtZfk4xp2YkkxQ--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: b6346f4f-a635-496f-81ef-aea7606edd5b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Thu, 24 Oct 2024 03:28:47 +0000
Received: by hermes--production-ir2-c694d79d9-2zgj2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 26d1652bc1703d2ade3e89c3cd33808b;
          Thu, 24 Oct 2024 03:18:39 +0000 (UTC)
From: Jakob Hauser <jahau@rocketmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Jakob Hauser <jahau@rocketmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/5] dt-bindings: display: panel: Add Samsung S6E88A0-AMS427AP24
Date: Thu, 24 Oct 2024 05:18:24 +0200
Message-Id: <1a3b08a4bc9944ebe05ee48bcd8ea11bcf3e9103.1729738189.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1729738189.git.jahau@rocketmail.com>
References: <cover.1729738189.git.jahau@rocketmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for Samsung AMS427AP24 panel with S6E88A0 controller.

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Patch is based on current branch drm-misc-next.

Changes in v3:
 - Dropped the second "bindings" in the commit subject.
 - Applied 4 spaces indentation in the example.
---
 .../panel/samsung,s6e88a0-ams427ap24.yaml     | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e88a0-ams427ap24.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e88a0-ams427ap24.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e88a0-ams427ap24.yaml
new file mode 100644
index 000000000000..db284ba5be20
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e88a0-ams427ap24.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/samsung,s6e88a0-ams427ap24.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung AMS427AP24 panel with S6E88A0 controller
+
+maintainers:
+  - Jakob Hauser <jahau@rocketmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: samsung,s6e88a0-ams427ap24
+
+  reg:
+    maxItems: 1
+
+  port: true
+  reset-gpios: true
+  flip-horizontal: true
+
+  vdd3-supply:
+    description: core voltage supply
+
+  vci-supply:
+    description: voltage supply for analog circuits
+
+required:
+  - compatible
+  - reg
+  - port
+  - reset-gpios
+  - vdd3-supply
+  - vci-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "samsung,s6e88a0-ams427ap24";
+            reg = <0>;
+
+            vdd3-supply = <&pm8916_l17>;
+            vci-supply = <&pm8916_l6>;
+            reset-gpios = <&tlmm 25 GPIO_ACTIVE_LOW>;
+            flip-horizontal;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&mdss_dsi0_out>;
+                };
+            };
+        };
+    };
-- 
2.39.5


