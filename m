Return-Path: <linux-kernel+bounces-428742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740A49E12C9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 06:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 347BC282754
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 05:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93642186287;
	Tue,  3 Dec 2024 05:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9JCfMqT"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D5E175D48;
	Tue,  3 Dec 2024 05:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733202730; cv=none; b=Zj0niV7GUqdX/6y1Vu5kVg2tcHoMpEbqrw14LWBI7YZJCpvHfjQxrSHbKCz9f3kT0JlHeDwWHq6PO76OKUTe6p+3XdRjupu5BHZ/TfsMpedrQh8BUU6Vg32jp2uvB+NJT6B0ICNEcgxp3xRAc1tFpr5s0YoYkQq00Et/jFrvnLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733202730; c=relaxed/simple;
	bh=kBlnPxGq6ChsufaUKBSLw6uMgtG56pxCd36D5k6/w5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+8uFnp/n4CzLIl00/l+vXhgu6GLgilUt13lbdMI6QcGmnINOUH1pHe30BfNg6Vo+ol9GTXsJpxfAEx6WCBlPY0fsPITEgbtvllZVVvY7frA0HmF46HH+RMcZcPHrd+/ObmdjCc7Jb6GdbHYfDDeEuKxRyx/G4LxkIkKbjokdiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9JCfMqT; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-724f383c5bfso3886281b3a.1;
        Mon, 02 Dec 2024 21:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733202729; x=1733807529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbp/SL17C/U69/mM4spr+KWpbV3+Jo5FoO9b1T7Q5mk=;
        b=i9JCfMqTi+skQPxvIZRGbC9Hxb6XjY4Lm9otgpV4pcE+Bc/Yj8CzgKKkZp6L4XIE7N
         U+4tXWMQZPcg8YzMzS0AH+MEKr5PMiWbTRAYPPnXIkj+PyiAvg2sAzOGQP0QP1HQL5Xm
         YGm4laGinh2izfFCv5jWZ9lUF75Z6jj4WyK800VPJQs3EryvqXhPGamo4MHvziMi1uQN
         9I/Er20CjAM6mZIG/mfNt6zWPBndv6VbWP00RiSqR4PpI6YLgnnuzk6m36/CLVuWXeZC
         IE3NI2Ti/6P/1hiBx+keCUePE+otdigRxrS70YXySLsxQ3PwjM4Fe8qctSnUG0m6W2Vr
         9GnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733202729; x=1733807529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbp/SL17C/U69/mM4spr+KWpbV3+Jo5FoO9b1T7Q5mk=;
        b=p7q2T6SuBJMvegz8Xq3lqvQrO4xYu93WJ4DMCa5LRmdCamwEssiHoVA0RsKPbo/M2M
         /RCgazB5nr9g4AQDMdOhV7/3s+rjECZilOmc/6KH1KXRyraV65yeZYacvZw6Ok1pIOVW
         HK6uBaA/bIVvnWbaVCpbpxQ7ZiInSDgeu4xfAKiBPLxgM2nQ//1xGlt+MGzyM1PqRL0Z
         mLY8+FoCluit9oqIntAGXPkCgIItb2slAGGGlWG2tYHSJ2k5mXW+jzqoSkLRuxDuvZ2e
         bIctMmQAtGOF+Xv3NBFnhM7A6Db+rJx/RpUrmaMd9tVNsJv7leh62AMIvYBr/y3A+ZPA
         U5Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVSKb3PiDwaQKiNI6RvRxQOHHMf4IBOZ1S/3oi9NHX3zwpfrZruFZMC3Gtffy24Kvf01UqIeh+KqPgw@vger.kernel.org, AJvYcCXhqPgpFstaZdizDIxOmFdUyPIBs4gpf6VyiCPagcimtqm87jA3iGL4FqVavn3nxW8hQxi0AbLV229jztbA@vger.kernel.org
X-Gm-Message-State: AOJu0YwlssEQeR2RBkvfDrK82EL42ebjMDWf5l7rvqbuEIF9N1QOUF+k
	+LGyLZYf31seBddgQsP8ZnRJ1ymZCChlSU2d228ELbWff0cAljtw
X-Gm-Gg: ASbGncuijt7myFugO5On7cWfLOZpjdgBQaNhNGFUahSHd3KLtiuhNmjAesIeHadHStO
	Jr+etgv8gZemEOZ6ejfT1kRpL6qLONM+X4XPFGGYwfGt3SKSmcz1cZCnxmcG21wKoj41/tBgbXr
	+B439ut57oOMbUpN+tJcJGrgt6ZKQgxkmBLfmn3q1Nspte2PlIOKeSeihVvQbmMyljfzk9dIOfH
	3jQ1venY9BNYRo3i+ev9OpE+UMTTHSEhuIqE9CW8vEJuRrJ7+yvCikwHdzX3VKJHA==
X-Google-Smtp-Source: AGHT+IHa2D6F1wVcNR9basJsPDGbsJTvLncGUr3XXRt4xi82659gCSs3b7qvxB6i6firh4TNGuWY5g==
X-Received: by 2002:a05:6a00:1893:b0:71e:7294:bbc4 with SMTP id d2e1a72fcca58-7257fa753f8mr1643490b3a.13.1733202728883;
        Mon, 02 Dec 2024 21:12:08 -0800 (PST)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72541848916sm9525047b3a.172.2024.12.02.21.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 21:12:08 -0800 (PST)
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
Cc: Aun-Ali Zaidi <admin@kodeit.net>,
	Paul Pawlowski <paul@mrarm.io>,
	Nick Chan <towinchenmi@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/3] dt-bindings: arm: apple: Add T2 devices
Date: Tue,  3 Dec 2024 13:10:27 +0800
Message-ID: <20241203051147.110980-2-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203051147.110980-1-towinchenmi@gmail.com>
References: <20241203051147.110980-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the following apple,t8012 based platforms:

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

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


