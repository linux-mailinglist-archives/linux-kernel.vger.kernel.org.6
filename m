Return-Path: <linux-kernel+bounces-298345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF89D95C60A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F3AD1F23A34
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F46D4CDE0;
	Fri, 23 Aug 2024 07:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Meup4+7J"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFE27345B
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 07:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724396670; cv=none; b=cZQ/UCVyR35EgKb/8zMN3RJI3YVihWyxX2ARDjNFHMNsTtG551bK9g2PQCWTW8II83SP7lvoXkp5GmIpxk9m6jmOqvEBubaT7GIrYIrywMzkG/UjM+JJ3uGXE+5kKUJUzqo8pdG38K8tktXZg6vYikPz0szXejUwgXvKuVT+ovQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724396670; c=relaxed/simple;
	bh=WTyLfsiYFOCQpAv2bKcQ9v9a4Pc0v6j5pZTdsIRc/X0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eJUE6/DnuWmkeFrmMWSnPDOXZlpaQpns/ob0d4Cm+C4KNpVzD1Nqfdc70c55yqfHywwAFkSgi604E54EiMInJRmg7Adc+cPlTkA+TcESNsGGQN7IS70iApMwzcgiEnKq0MA1ZZZ8K4w0kNks/vv7WlBd0iTcPgdPZ1cgWIzKcmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Meup4+7J; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7d26c2297eso211466466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 00:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724396667; x=1725001467; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MQ7mhyA2j0MFrl3QJkg/ME/SpNMRr31BDPIhEa0SBMU=;
        b=Meup4+7JH1JztpdQP3CG7PuJhWauc61QPkLdgH6Q9BECYeO8RTnIencrtG49ltZb1d
         AI0v376CJ6nC5QDJEP+QUOLjBM6bQoa8eGTvt18ZfxHy3na/qYXUl6cxTE6oo9eyuKky
         WXdKCQkeTJwnod9m1gOFX7qeBDkBfwBROZWjMs0FIayxASt7NZOnW9E6WU1u0CGHbJwh
         EPpr7puogmz8q+OM6BycKa89vgITb3M2b8ynLTMShWzny8KV6iIFj8ZURHb5sJuwb6x4
         XcLc4Px8d4aJJNhTsr8tpKwLJlHFqjbcVj7wO19sZBlFdqZVEvTA20tLfjY73XUxyY8C
         5BTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724396667; x=1725001467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQ7mhyA2j0MFrl3QJkg/ME/SpNMRr31BDPIhEa0SBMU=;
        b=fvCAJbDLZrN8uYXYU0xRXnSH7qpXm6fPbGxqIcxCX1nNOGc1LdslerT5/usJAAiDq3
         zoqrSZMsxYzFIVoyazZTBmWgS3uQ2DNMQcDCGJF5LMRBvAXFCl06kTFVMt9s7w6tvz1r
         NSOWzZXJGlB1CXavXI8+B4/Ke5S9/LrGko0rtkGaiEAr+LJFOAY4nhe7dH5KjQ2+llcQ
         0HS34SmOvo04tTITo+Sk0TQQn5kXDpqsm795jt7IoHYP1nKBBd+/nsl7MJV8XSZ53yBv
         YnjBAri9GgCut1Ifg3oJDCSWDUAp/XO19dDK/tCraAzzdOJ1LIYB7dYEHiH6Xe84bjNH
         QRmA==
X-Forwarded-Encrypted: i=1; AJvYcCW2CQ+UCVJ5k/X9e14itCxJoviDRjtaoPQPY/pJskWJlnCtVcAisBbDGC1CGIbGzSB0x+h3WDRbskSp6+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoeWOYjeNXGDfsv8hkdMOaI/snJOPApN9bsUWJQKJ9n/1zA06Z
	zaQVA1QE9GSWiM82XbdaSk+p7YKTxw+7M5zD/V8sF8fIkhiW0BplI5JwSmGqyeQ=
X-Google-Smtp-Source: AGHT+IG6TdK5Q7DjQm/i9MCekRmwMaeOSrcst0icfF0xCCZTYGQ5AUTD0MHIKbFJ1vzZIBV5S7IfYQ==
X-Received: by 2002:a17:906:fe4b:b0:a7a:bae8:f2a1 with SMTP id a640c23a62f3a-a86a54899f5mr91060166b.42.1724396667187;
        Fri, 23 Aug 2024 00:04:27 -0700 (PDT)
Received: from [127.0.1.1] ([82.79.186.176])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f48ae0dsm214820766b.184.2024.08.23.00.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 00:04:26 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 23 Aug 2024 10:04:15 +0300
Subject: [PATCH v3 1/2] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Document the X1E80100 QMP PCIe PHY Gen4 x4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-x1e80100-phy-add-gen4x4-v3-1-b7765631ca01@linaro.org>
References: <20240823-x1e80100-phy-add-gen4x4-v3-0-b7765631ca01@linaro.org>
In-Reply-To: <20240823-x1e80100-phy-add-gen4x4-v3-0-b7765631ca01@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Johan Hovold <johan+linaro@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1524; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=WTyLfsiYFOCQpAv2bKcQ9v9a4Pc0v6j5pZTdsIRc/X0=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmyDR1Nny/j5fvOoS5x44kAo7U1DbCsp09QLnZ7
 bib2dHHXTSJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZsg0dQAKCRAbX0TJAJUV
 VnGlEACigT4aIoteJz1UrJ7BeFhqxU88FSKULM1LejKWaaiXbnlojm5febRgfevLieXNjMEUcfu
 85xxfk2w7CCcRqWXRoLGbknc0WHFAEOCty1UpZUO7/s/Qx2Yae2jHjYn7hLwbsL9l+Nyp+i/osG
 qXEUsbKIwTZOCqOxTTYsj0GpeoCuTbv9Y8AojqWNDQ2gGowGPCIRjAEwTyhVoyuY1qt6AnDm2mX
 MJJImUK4VnGZtbnkHsfY+K20hASz9PO9es/IMNz6y/DECJ9uXTeKvRVVxLwDHUS6gZeascllYzm
 dEC+DT/5b6ToM5Kkom2wR0mGxrS7lOBTPUE+iPS5D9ZG150ClgPkoIfWXOPflZXyy94FQM5kS8G
 92vYi09EcVxVG8JHSC8vaa1I/Q5VEN/v880Q0C5gT7eU/a8VgxiTRXCo53oOUoPp+ZHl3V4Iy4h
 rZZntxKUUJeA73CZCvokq7VAQK+/z52YKWmBHnXGIY7IaR6NgqnBhnMg9zufAv4VzF87mGTSZI/
 Qp4ykkCv9vxhOEruLdMFWUbwQi9F2ZksA9WOUrHK0HrB3HC8XC/B/dNjOy6j09XEfIA/nx24Rwm
 atxOZPEV3A5SzuAsFv68vO4+C7EUQYSIJUBww2L6x+mMEgLUVi90frQz2cjbvjmRYNvC1sKkcj1
 /0iATzZPlgGYJsA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The sixth PCIe instance on X1E80100 can be used in either 4-lane mode or
2-lane mode. Document the 4-lane mode as a separate compatible.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index 03dbd02cf9e7..dcf4fa55fbba 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -40,6 +40,7 @@ properties:
       - qcom,sm8650-qmp-gen4x2-pcie-phy
       - qcom,x1e80100-qmp-gen3x2-pcie-phy
       - qcom,x1e80100-qmp-gen4x2-pcie-phy
+      - qcom,x1e80100-qmp-gen4x4-pcie-phy
 
   reg:
     minItems: 1
@@ -118,6 +119,7 @@ allOf:
           contains:
             enum:
               - qcom,sc8280xp-qmp-gen3x4-pcie-phy
+              - qcom,x1e80100-qmp-gen4x4-pcie-phy
     then:
       properties:
         reg:
@@ -169,6 +171,7 @@ allOf:
               - qcom,sc8280xp-qmp-gen3x1-pcie-phy
               - qcom,sc8280xp-qmp-gen3x2-pcie-phy
               - qcom,sc8280xp-qmp-gen3x4-pcie-phy
+              - qcom,x1e80100-qmp-gen4x4-pcie-phy
     then:
       properties:
         clocks:

-- 
2.34.1


