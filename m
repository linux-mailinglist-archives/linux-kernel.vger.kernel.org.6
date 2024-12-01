Return-Path: <linux-kernel+bounces-426670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305C59DF677
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 17:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78D30B2175C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 16:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6813E1D7999;
	Sun,  1 Dec 2024 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOIS/8tU"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D2C1D6DB8;
	Sun,  1 Dec 2024 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733070006; cv=none; b=ZzaSH8YqC/D5HYg6p+R5spPM9xfejXjUFH7Dkyyta0CRYiu4O/kxq4RPw/LKO5OA428pCbKTHumuBpRQNbNjQp75wTALr5mIeQ5nBNDgDctNqj2dcwr4KUttEFVoOl8NzzHQxzUj4K8FMcPaRBSpANQ0jCJTl0GuGKb8zT2GK3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733070006; c=relaxed/simple;
	bh=Xty3yyG4uw16PQiYRVBL79Q4Zlkljc4oAAhNz8vKzKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5NhAma+Ecrg3Sgp15WQKOHsWjxTM7q9dExpvW6BcdDeDKRRxPxuiYZuJ8U82GVKKp5ufKl7WP7vF4neugbFIUEYWbSQg/m9rECZ5mtunIo8WblFh5jkUWdWJaylg6H4vWp++97iT+AvZt5eNaIgZT24bPk3WXOCrbaa8vQsxLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOIS/8tU; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7251331e756so3227868b3a.3;
        Sun, 01 Dec 2024 08:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733070005; x=1733674805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzpydyWYDeRq3YCadaVmg/DECTRQ6H8rjbCBdAJ5buk=;
        b=kOIS/8tU+SdPjA3XbVY1Z/U3YxNaqKRt2jlr4BycprXsOALiZBXYacMRo+Hkb0oyW2
         tKmMNFuXr0xgC4HjgBofXIGE8NdNE4IQZuUIb5Tr/bVZei96GIQOSdJvq3qt5OIlVs5u
         E5MPUM2PFRZj6X3xIwGvlw9BXs9w5Z7yEu9zw61e34PCTZ2JA/Yz8KRHgTf7bHY296mj
         pm3/chlkgN14Ox/ae9yxLX9aoFGAzrC2iOial5Sj/7vfkpyKN3Y4X2p/JjykCKBK/HIn
         yNEOcpF1uQRIGpAwSoWDH/BCdjSNXQayODGH/t3DPBeAAGwdukSdbIqS3gilb7SAw+eA
         RB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733070005; x=1733674805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzpydyWYDeRq3YCadaVmg/DECTRQ6H8rjbCBdAJ5buk=;
        b=VnuN79wDBpLBuAgSaXinZxgCSnxL4TZ2LOqah2/y6xgVcxS8dIxcXzuOqsomi6q6Qv
         EJ1KJhzN3x1K8goEpwJlBKQZnbthwzWKnxm9kYPI7NsI3vR2zDSFC7bJbyEj4RgePCNk
         76TiUNUJ4/Em90MdQXmUKeqvJ58WvuhA39r1ssBhoHNph1PHGpYpY2EZsZYEs5MlYlBE
         eXl6BzJA5W8Dc9REaRKYYWM5dkyHJjSZNKc2zZv+INNvp9opGB5hWKSIL3aLRIgVovBC
         PXR2uO3JWmxTHS4l+3qg8Yhs6PxKtjHej/SYdOPZQfuqYNEpKP1Mpfjay7l1BmsMm6hD
         ncNw==
X-Forwarded-Encrypted: i=1; AJvYcCVFI2BUEtUeo42HHdPPRA2DfzkhuEa6vW61VT+GIArmAfQ2o4mFgx4kDj3z10J9491Ex6+kBMMBtlxe@vger.kernel.org, AJvYcCX3EYGo2UTdSR0Ed1SR/5nk0vxK/Yx3xYrq4PVotbNc59w/U6pxp4oAfHxVNKAR99ArBKptbk/acDYHrJGJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwxNDCex4ibOQTHlM6EyQMdKEGEajVW9KVRL/hXqepSll9zfdKT
	8tg/VCyb4rMnJzUICax6a/gNlzxpqu4GPvpHn2aAo8bXFfzTR2Jp
X-Gm-Gg: ASbGncv41SJoJDQGH/Ln0rMXlckexSNRgqN27Qh7KpIGzJzpf8bc3oigg2aYO4QTliy
	FI8nFoedClUvzD92KVYsABRp+S3vY5gGSyIv/xIshi+4bKx/sNwqmrHxa2nFtdSnbXA5nK0RPAy
	phQhNasrwY7q5z/vX410Q2ukw76TfTccqy3CvRIYfkvS01Bv/vK1AFuna53bGnQVKSvy7s4sSpH
	K6iuBfCXy8AwSCIuGVUK5pI0cimJbEWOOCNz6OvtDqA+xJrM887xR0x5yAhOzT3QQ==
X-Google-Smtp-Source: AGHT+IHq9b8W+oSYCY1CBrS1ggU9W4leeGRpQXf5UGHbqBGatazOzI4Ta2e2XSmCmZ/hxVKKjaERsQ==
X-Received: by 2002:a17:90b:4ad1:b0:2ee:b2e6:4276 with SMTP id 98e67ed59e1d1-2eeb2e64643mr3056803a91.27.1733070004725;
        Sun, 01 Dec 2024 08:20:04 -0800 (PST)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2ee78834450sm3007392a91.6.2024.12.01.08.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 08:20:03 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH 1/3] dt-bindings: arm: apple: Add T2 devices
Date: Mon,  2 Dec 2024 00:18:41 +0800
Message-ID: <20241201161942.36027-2-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241201161942.36027-1-towinchenmi@gmail.com>
References: <20241201161942.36027-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the following apple,t8012 based platforms:

- Apple T2 MacBookPro15,2 (j132)
- Apple T2 iMacPro1,1 (j137)
- Apple T2 MacBookAir8,2 (j140a)
- Apple T2 MacBookAir8,1 (j140k)
- Apple T2 MacBookPro16,1 (j152f)
- Apple T2 MacPro7,1 (j160)
- Apple T2 Macmini8,1 (j174)
- Apple T2 iMac20,1 (j185)
- Apple T2 iMac20,2 (j185f)
- Apple T2 MacBookPro15,4 (j213)
- Apple T2 MacBookPro16,2 (j214k)
- Apple T2 MacBookPro16,4 (j215)
- Apple T2 MacBookPro16,3 (j223)
- Apple T2 MacBookAir9,1 (j230k)
- Apple T2 MacBookPro15,1 (j680)
- Apple T2 MacBookPro15,3 (j780)

These devices have no offical names, the naming scheme is from
libirecovery.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../devicetree/bindings/arm/apple.yaml        | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index dc9aab19ff11..da60e9de1cfb 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -57,6 +57,25 @@ description: |
   - iPad Pro (2nd Generation) (10.5 Inch)
   - iPad Pro (2nd Generation) (12.9 Inch)
 
+  Devices based on the "T2" SoC:
+
+  - Apple T2 MacBookPro15,2 (j132)
+  - Apple T2 iMacPro1,1 (j137)
+  - Apple T2 MacBookAir8,2 (j140a)
+  - Apple T2 MacBookAir8,1 (j140k)
+  - Apple T2 MacBookPro16,1 (j152f)
+  - Apple T2 MacPro7,1 (j160)
+  - Apple T2 Macmini8,1 (j174)
+  - Apple T2 iMac20,1 (j185)
+  - Apple T2 iMac20,2 (j185f)
+  - Apple T2 MacBookPro15,4 (j213)
+  - Apple T2 MacBookPro16,2 (j214k)
+  - Apple T2 MacBookPro16,4 (j215)
+  - Apple T2 MacBookPro16,3 (j223)
+  - Apple T2 MacBookAir9,1 (j230k)
+  - Apple T2 MacBookPro15,1 (j680)
+  - Apple T2 MacBookPro15,3 (j780)
+
   Devices based on the "A11" SoC:
 
   - iPhone 8
@@ -211,6 +230,28 @@ properties:
           - const: apple,t8011
           - const: apple,arm-platform
 
+      - description: Apple T2 SoC based platforms
+        items:
+          - enum:
+              - apple,j132  # Apple T2 MacBookPro15,2 (j132)
+              - apple,j137  # Apple T2 iMacPro1,1 (j137)
+              - apple,j140a # Apple T2 MacBookAir8,2 (j140a)
+              - apple,j140k # Apple T2 MacBookAir8,1 (j140k)
+              - apple,j152f # Apple T2 MacBookPro16,1 (j152f)
+              - apple,j160  # Apple T2 MacPro7,1 (j160)
+              - apple,j174  # Apple T2 Macmini8,1 (j174)
+              - apple,j185  # Apple T2 iMac20,1 (j185)
+              - apple,j185f # Apple T2 iMac20,2 (j185f)
+              - apple,j213  # Apple T2 MacBookPro15,4 (j213)
+              - apple,j214k # Apple T2 MacBookPro16,2 (j214k)
+              - apple,j215  # Apple T2 MacBookPro16,4 (j215)
+              - apple,j223  # Apple T2 MacBookPro16,3 (j223)
+              - apple,j230k # Apple T2 MacBookAir9,1 (j230k)
+              - apple,j680  # Apple T2 MacBookPro15,1 (j680)
+              - apple,j780  # Apple T2 MacBookPro15,3 (j780)
+          - const: apple,t8012
+          - const: apple,arm-platform
+
       - description: Apple A11 SoC based platforms
         items:
           - enum:
-- 
2.47.1


