Return-Path: <linux-kernel+bounces-432672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD819E4E85
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934E1283DD8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B10B1B87E6;
	Thu,  5 Dec 2024 07:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zzzAYX+M"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CBD1B6CF5
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 07:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383998; cv=none; b=kTr3gjuG2My/9z4pA7EEtU42QOAO1MPwfDcMvPRUoGUTY2Pc+YAZFCbo3ZI5SsDS9yIZaQcnGP4U7EDsWIzzfNYRpcTJ0Q41s/J2nqJNF4KZ2sqRnoz1W03CS1rqLtlCcHacH3+lYoMfh6viF9Itq1vttJmILiRN8qRxljU6qf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383998; c=relaxed/simple;
	bh=4L1d1fZ/CUtuGNTGhkvnq4cl0ag43qy7j+Nalp/6Vps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FHx8A3f1SGhkZg7UuKfBExt2kgu22XmabglCB0VlEsTmyFrgxUvzOI9gB+c0I0LkMzcVnenOgxc+uDVSUd+3wevux4modr9Z/msWYUldtO+mU/IKRgnomkmOcRmXDua1BsdcD1d3aNMGIQiH0alAjJ6Q/zLeg3pRDlzb4iJmJLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zzzAYX+M; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa5f1909d6fso102092366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 23:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733383994; x=1733988794; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VPcp32i194zjkohuP3ghdoazYclk/zwkpzXjsI6FYvY=;
        b=zzzAYX+M1JXfgq82egqDzRNPTVzp+DJUbvGhE55CUnCey4JjdAe2U0jLE7W+9b4a83
         yQJE3hveCc2utd3uUBX5BteJyxcuAaA6XWVfYaJwY1n/y7xQOsC6Ci8bnNrWzEDKQzfC
         YObqLOtb5Eze2LWfJyM3H9V5j3WfIxkCI0Fyz3PlE6299JUCgTfIYUFib4kVLHHBNtMC
         uJeqjeJYLLXPueeBoZMINhTNgOIsAfmLKOzIG8ozcyXHjM2lI+8aM3vu5h/8lLh2PNGv
         gVVxrs2CPo6/rOZrmPfEqWjyJdDZmgGHAl0d8yV0ezuyTA6SjT15sH12bLMnMRWv3eJ3
         lKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383994; x=1733988794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPcp32i194zjkohuP3ghdoazYclk/zwkpzXjsI6FYvY=;
        b=jH3YL2D9pFAekzXp+7pbqA5KYQjckSwD/HA6/T0BLwwqKphYn6gPbxw80tmJUnjLH5
         fVegKhQP0uoZTYgfsNcyMCEVsKx/f7bZ+DUVaYC5CHnhyq0wLvYTmKQ81INYXUMMm4ac
         DFO4OjahYJZurYWS7RI561EbOVjvHeSc4FfMvN0f5O77mfct2sfkSJW8aMWrkHMePJA0
         gZjcYd3UKibkVXTpOo0fXWFj2R0i72OZHxXeR9TbqmbszAPoZ2OzsyvY/C+j25lSf44N
         q1hvmzaPxvIGLQrDtdWmjY4uZH7te46gM7Bj+TR2qzekLBOYFzYwc6iexeWvEcCyuOcs
         Y0cg==
X-Forwarded-Encrypted: i=1; AJvYcCU2c9b4kIiZwyRbg1yx458N0M59hV/0GnQuob/DIANlXwZek6OfcgL8FdltS492oqnTWULbFNyjkPPJymw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcrBui9MQ7eJRXkg5Ogicj1N7IjrvvAfPTrM6ZCtYtCT3EiGpA
	q3Iql8KAjr8AkBuHh38gTMXJJt5ZPavviU705NoOOOt93pmwbtdW7gmMyju9SfwoqG1yMDZrm8c
	Gu4s=
X-Gm-Gg: ASbGncuTTlpKOHelUcZyr3u5P9xUfDpPPbU473p9m+rIkXnXO2Y7UyeXL6AC1qJFHiT
	k6O6pKQUgDnSeX9QXIWRV/H1uMDy+HEOcvaNGDkjTaWXN9ANm//d6l7cqo68FsLtPK0u01FGhDg
	Fc1DZ2reB5Zxf3TveQIG+q6l/QR3a+1ch/zgbhJeEP9wJSR+qIV+1LuvK26CG2tO6GU4TnqqLSg
	nHzHtqi3AoQUs3NETuegw+Szue9S97wWglmOYBDOKj/MpHQ7s7RohRPNt6ZMSNPMSvJ/eNjzH1x
	esNorMoqZmlZq8ZqHJnlyVqZzmto0MTuqA==
X-Google-Smtp-Source: AGHT+IG2cRFoErHvd+1EuK9aLmhx/7F0pkt3orG+NahV6/yW750scFnzkpmch+QEqJyukIDF69QaRw==
X-Received: by 2002:a17:906:328d:b0:aa5:30c0:384b with SMTP id a640c23a62f3a-aa5f7d4d1f6mr732358166b.24.1733383993763;
        Wed, 04 Dec 2024 23:33:13 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260888casm53371766b.133.2024.12.04.23.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 23:33:13 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 05 Dec 2024 07:33:12 +0000
Subject: [PATCH v3 1/8] dt-bindings: phy: samsung,usb3-drd-phy: add blank
 lines between DT properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241205-gs101-phy-lanes-orientation-phy-v3-1-32f721bed219@linaro.org>
References: <20241205-gs101-phy-lanes-orientation-phy-v3-0-32f721bed219@linaro.org>
In-Reply-To: <20241205-gs101-phy-lanes-orientation-phy-v3-0-32f721bed219@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, 
 kernel-team@android.com, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

In [1], Rob pointed out that we should really be separating properties
with blank lines in between, which is universal style. Only where
properties are booleans, empty lines are not required.

Do so.

Link: https://lore.kernel.org/all/20240711212359.GA3023490-robh@kernel.org/ [1]
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v3:
* update subject line (Rob)
* collect tags

v2:
* collect tags
---
 .../devicetree/bindings/phy/samsung,usb3-drd-phy.yaml     | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
index 16321cdd4919..1f8b35917b11 100644
--- a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
@@ -83,14 +83,19 @@ properties:
 
   pll-supply:
     description: Power supply for the USB PLL.
+
   dvdd-usb20-supply:
     description: DVDD power supply for the USB 2.0 phy.
+
   vddh-usb20-supply:
     description: VDDh power supply for the USB 2.0 phy.
+
   vdd33-usb20-supply:
     description: 3.3V power supply for the USB 2.0 phy.
+
   vdda-usbdp-supply:
     description: VDDa power supply for the USB DP phy.
+
   vddh-usbdp-supply:
     description: VDDh power supply for the USB DP phy.
 
@@ -117,6 +122,7 @@ allOf:
             - description: Gate of control interface AXI clock
             - description: Gate of control interface APB clock
             - description: Gate of SCL APB clock
+
         clock-names:
           items:
             - const: phy
@@ -124,10 +130,13 @@ allOf:
             - const: ctrl_aclk
             - const: ctrl_pclk
             - const: scl_pclk
+
         reg:
           minItems: 3
+
         reg-names:
           minItems: 3
+
       required:
         - reg-names
         - pll-supply
@@ -149,6 +158,7 @@ allOf:
         clocks:
           minItems: 5
           maxItems: 5
+
         clock-names:
           items:
             - const: phy
@@ -156,8 +166,10 @@ allOf:
             - const: phy_utmi
             - const: phy_pipe
             - const: itp
+
         reg:
           maxItems: 1
+
         reg-names:
           maxItems: 1
 
@@ -174,12 +186,15 @@ allOf:
         clocks:
           minItems: 2
           maxItems: 2
+
         clock-names:
           items:
             - const: phy
             - const: ref
+
         reg:
           maxItems: 1
+
         reg-names:
           maxItems: 1
 

-- 
2.47.0.338.g60cca15819-goog


