Return-Path: <linux-kernel+bounces-201038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5632C8FB8C6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95A3FB32DB7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2275149C44;
	Tue,  4 Jun 2024 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RcIK3ePu"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBCC148305
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717517124; cv=none; b=UaaI0BapAt/T0pGrtGqQMobZyhn89gZQoyjN7QtG4Y+8p2IjrxPEnzDNovAn9cobbFcA+UCEEUUtbiRgBIVSqRXcyczVHkP/+p0waGDigUQ6J8RUBovJgvwXgGNVNTyzSPn37MCU/dZ1T8n+h9qClnBe8P0rXObXaQ+P2RoCrYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717517124; c=relaxed/simple;
	bh=lK7XgRDgm6NLV9YDi+57KADrhvh+ft7/KXPT0pDDjfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=A/95LJ4RrOUzlU/vy0o7n3qN/NaJ/JZ9JJ6Y94ODhKdhBuBMJnbW5TSOuXOfTmkL8oI5kjZ1mU4Gwn2IJieB097nRyGWOYiTy3EfvpthTa2gn6+epGlWGWfX3vgddrJU7aEo2fdIPFB70pkJ+krAjeNCg9EO+P1Epv+pzl6/Ur8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RcIK3ePu; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57a32b0211aso1511123a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 09:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717517120; x=1718121920; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h6I7pG6ei8jb1MvrUAVB+vxp5YXuMn0OESUr7tOflIE=;
        b=RcIK3ePuC7acSR9Fg5mys5wB3ZWfQkloziasgCGx5i8HumOfkLsQtIVxL4ANs31hyj
         2dXTL6xQ0usJgh7Z9y9FisE3hJnZJxW0Ac5RUyfblNXHmvf7jZyZ7kfVogSeq1yFe+iA
         zEWNLR1BbNJLmpAZu3v12dtGVUo1q5ICV25oOD3XMD2AZ+zQEvwMA+95csoSS+/kIlm0
         rDjQd7QTrzd+YRRYEbEEXWYE0w1lJqpvYBEoxD5NW2uWonkZtfY8fGytGaKovXxxpw9E
         JbEGV+RbI9Myax3uFYP164Xq6GO1VkvZp4RFCWx7jRF7mdL1oZS8Qk5Xzw0bbfExq28G
         o4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717517120; x=1718121920;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h6I7pG6ei8jb1MvrUAVB+vxp5YXuMn0OESUr7tOflIE=;
        b=rJyKaGu7AOXzgI5WNHDz1+CAfJgIwfoqU6cA0VG4YeYWDqHHsxpT/IidwkQNyEopr/
         1UFzqMrUnb8HOSieknhMg5pJiU0HK/BLHWAqMhtoWoMf2+yhe5CxfgX590HKNI1JrmgL
         0hVEiSvYbey26gMtbAW3oXMghGsfU+11c5C7fMECqnVoAYyTWlF+dCDk4r7+q0IsFPix
         ePlCBOu62fluHmuEP6JSr6RM1Zu9AhIsdoRqj6vkSjAAisJQIfx77cnqzhPTDajZ4gSo
         9jYTXzKrU4M5jO6zBkrPlc73MlFJ8G+05bF3xT1OHVeFKIy5pffvQJiaJBHVysiU9U30
         yDtw==
X-Forwarded-Encrypted: i=1; AJvYcCXxLRdd74JTDdGm2uBNB8s6sgNu3sax5L5KQEmw4HXaInKs3NNf02I1b1Q9+8PSXKAzXfktsJu6H7BZ4Bvbrpl+voUGHfU/8wHEUy15
X-Gm-Message-State: AOJu0Yz7N6rX4YGeynAnGDufBImQejMazlRaOmpZqgMVW5QI6UXiSOE+
	zIQq5GVYAqYMPTvcvt0fYTTxJ3EsyiBaBJb2atKqiAK2hPP2Py4P13C1W2phevM=
X-Google-Smtp-Source: AGHT+IGyFpwLh8EYFqnnvBFP2+xBQeKzRmSmqbTGHmWaAzgXn4hhyh1OwJsjh8oQyEmDxBv146JrxQ==
X-Received: by 2002:a50:c303:0:b0:57a:2de8:c47d with SMTP id 4fb4d7f45d1cf-57a8b6b88b6mr52931a12.21.1717517119629;
        Tue, 04 Jun 2024 09:05:19 -0700 (PDT)
Received: from [127.0.1.1] ([188.27.161.69])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a4f172062sm5872471a12.90.2024.06.04.09.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:05:19 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 04 Jun 2024 19:05:12 +0300
Subject: [PATCH] dt-bindings: PCI: qcom: Fix register maps items and add
 3.3V supply
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-x1e80100-pci-bindings-fix-v1-1-f4e20251b3d0@linaro.org>
X-B4-Tracking: v=1; b=H4sIADc7X2YC/x2MQQqAMAzAviI9W2iHDvUr4kFdnb1M2UCEsb87P
 CaQZEgSVRJMTYYojya9QgVuG9jPNXhBdZXBkOnIUocvy0BMhPeuuGlwGnzCQ1/k0Y6md9wbS1D
 7O0rV/3teSvkA3d08gGsAAAA=
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1740; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=lK7XgRDgm6NLV9YDi+57KADrhvh+ft7/KXPT0pDDjfQ=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmXzs9IM2pMk4U72XrkJ7mmaIAX9bV3TjQqNqEv
 KiYUrDwv/2JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZl87PQAKCRAbX0TJAJUV
 VtpeEACCJhIqJeqoq2V2hr8/xu6fMUfQl04+UrveMvK32zf8IaySoCABSQ17NKCBygP7j4M19+5
 zJgdf5QP178RvQ5cZ8KWLSSxFFUSKUbq96DP/rJ86xpARajp7O1OH2hW+Kjk545QXZVz3Aiof05
 r4hyMCjNUmHuKODFTrtua0BR2TcQGak6LabwaQ8LVCOTP4rRr/OYdNeKq0AVPHxarZ3Qdo0mAmi
 ZRhbHhCzc6Th+uBaJeFGzvArY2ZRWQLkadiuCux16f5MXNYBpamAGyFpeeI1PJcmZIC2ODg7Yxi
 7J0JW0SIPdJ9DW5fiLbdvFe5GNb0AjoLuJnZ7QnfCkc8x+BHmL6lI3BdAVmMVxc5G2w7DFrkuKn
 /yhhlptuBtnLHAafCfEX3pTbDETOAoSEENng4qbTOBZki/i2gomuSM7UNlw79cXwuUuMIUEVcDs
 0ChnaOCfQHIUrEgreRao8tI9nHdhI6e7zTi24pqfSgy2oq4ACmTisUx2ow9WRx21rT/O9Vr8NBF
 43+ZjdrFrIl35cnB5pT1JkzQPuaqgpcXqFSAX3JwjL6WobjhpjyuaK0qJwow3YkGFbGnz2/1mrG
 c0Q4Gs2TaOsMRKRFofZ2PS8aN7pevaO99VawgmFGLdx2TX3raE6xYqlOM0UfEqOS7SpQty7axjV
 5AAl6YeGHFetKnQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

All PCIe controllers found on X1E80100 have MHI register region and
VDDPE supplies. Add them to the schema as well.

Fixes: 692eadd51698 ("dt-bindings: PCI: qcom: Document the X1E80100 PCIe Controller")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
This patchset fixes the following warning:
https://lore.kernel.org/all/171751454535.785265.18156799252281879515.robh@kernel.org/

Also fixes a MHI reg region warning that will be triggered by the following patch:
https://lore.kernel.org/all/20240604-x1e80100-dts-fixes-pcie6a-v2-1-0b4d8c6256e5@linaro.org/
---
 Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
index 1074310a8e7a..7ceba32c4cf9 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
@@ -19,11 +19,10 @@ properties:
     const: qcom,pcie-x1e80100
 
   reg:
-    minItems: 5
+    minItems: 6
     maxItems: 6
 
   reg-names:
-    minItems: 5
     items:
       - const: parf # Qualcomm specific registers
       - const: dbi # DesignWare PCIe registers
@@ -71,6 +70,9 @@ properties:
       - const: pci # PCIe core reset
       - const: link_down # PCIe link down reset
 
+  vddpe-3v3-supply:
+    description: A phandle to the PCIe endpoint power supply
+
 allOf:
   - $ref: qcom,pcie-common.yaml#
 

---
base-commit: d97496ca23a2d4ee80b7302849404859d9058bcd
change-id: 20240604-x1e80100-pci-bindings-fix-196925d15260

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


