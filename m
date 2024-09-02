Return-Path: <linux-kernel+bounces-310501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9456967DCD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 04:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEFA11C21C62
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 02:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2E72B9A2;
	Mon,  2 Sep 2024 02:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrM5O5Z4"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE6514F6C;
	Mon,  2 Sep 2024 02:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725244045; cv=none; b=Vo4ARKJPCTwrXtzcq11dlZwqheq/x7PZmR7wWI0IRLkoUKwrxU7k1rjuYEwSfeBXZfm4VzbT3hzUHyeYHIsNjdTN8srr/cIOk4shXi9YagmYAh0/U7zOWlMq+zDyrzjPUJYoq4qgls5zCY5bwThmf8Xyr3ZlCFyO5qDI4UjIrik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725244045; c=relaxed/simple;
	bh=6uXzDuukT06K/e0mD6kUxxCTG5GVtuUs0UdEPTpX7yY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gTn7n6xd8svPnTWt02eX3oTHOIZKy7oaMrRjEmMhudlHs59qzPKIPF7IMbSHE4uxpFnyunAa259Z9+uDJ166EkhrL6e7hF2aYc3DGzIOSjT/S7Mi8WA+wS+t6I6F2l1+Ejr7hsecWM4DPqTeh/+/5bQzp2+BH0PsHiIhQhmIKCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrM5O5Z4; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7b0c9bbddb4so2525329a12.3;
        Sun, 01 Sep 2024 19:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725244043; x=1725848843; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lP6iyq27B8amEKaoxtMrq0+PUOBgmpM3wd8mINZj5Fo=;
        b=FrM5O5Z4lFPzvBDMIJGdGbITu8OAGTF6o+DxAv2xwHLwl9whaAsb5nsjZeTNsIe69m
         nX15gfLxjofxRuYco4ZE9uavbaMOl1PM0z5EBYcpbS7WgvDqxL0qlOIs3ubBx04gpTtt
         8auHoK+34MGn63KqFpK19kABS1PVgXaLgHrW0DLqlFwFKjt+VdsyX0vg8Kp4QWTe4G7b
         SjuT16E1WRIR6FtuzpJBMRZmjAtddGUa0hBpUvcZTuTpUI4oRJ25PiUIKQBTjog5PXS4
         P+u1z7R1/zWOcqrzsWnqHS4GaXzzDLaFjW0+I1fVKddFYBGljgyOn7ZJuCnU69LchBVn
         j3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725244043; x=1725848843;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lP6iyq27B8amEKaoxtMrq0+PUOBgmpM3wd8mINZj5Fo=;
        b=fwMfDQz2fGnVT0Aa+wqByAg9eXOSU5UC8d7k1/1EQozGG5BNDEqzCtDerD3LVJOpXw
         vCfOW+4mkP2PqqzbZa2PzZNhXnvEQZe50eanxd6WlS3ykUZTx6UjvvIfPr1MitIlBoxC
         yHvgRbrwBeAfIXSSaiLoTUbTspgUESonksMh0fTCDyv/9QMev32JZwX2c0NRihTDbuAm
         GftGx/LQSuJSSKMdz3Msu92M2UdtPh7yxbqOtG0UgkMraTzbn/hmDvOGXiA8ALPP5fUR
         qmM1L5iThYTgpdfkIMa30BGINUVpDyDg320kogkMkrucAcukpOkoRpivxTkXY18opvp9
         oLNw==
X-Forwarded-Encrypted: i=1; AJvYcCWLP/0jfLYIfJVgp7hzqJIeZSeFcqJN1H39kB2/ZVg8p62lYlqFACZdFWjz97SvwmAPSZGee3ioknLBfJ4S@vger.kernel.org, AJvYcCX4nkMQuF+H9+tE7yhb8E21EvMJ7Uma/RHM9b94wnK5zq2gSRDTEaOr/pbJVQREta/dgYDHOVE3UgMu@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9LrdpKn1FEOZpRQvGO3wwPFRW51XXKKWH8+5J6OT1/I4W8Zcf
	jWoVhZ3d3OIgxDm0Tuj1oMeCrcuuQfuqqpWZju0aJNJEFWrlLhGg
X-Google-Smtp-Source: AGHT+IFjdYRm46ZcbzwSe/jl7unfRLbs8ZlkF+FaYXP25VQ74fwCcH/NCNgMEv4BaYmCARwFKjWwrA==
X-Received: by 2002:a05:6a20:9f90:b0:1c8:99b1:6375 with SMTP id adf61e73a8af0-1cce10ed7femr11542416637.47.1725244042902;
        Sun, 01 Sep 2024 19:27:22 -0700 (PDT)
Received: from localhost ([115.96.113.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2054e2ff670sm25217195ad.183.2024.09.01.19.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 19:27:22 -0700 (PDT)
Date: Mon, 2 Sep 2024 07:53:43 +0530
From: Aryabhatta Dey <aryabhattadey35@gmail.com>
To: andrew@lunn.ch, gregory.clement@bootlin.com, 
	sebastian.hesselbarth@gmail.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] dt-bindings: arm: marvell: convert armada-375.txt to yaml
Message-ID: <pncbkuiub6sr3gn2okzdfxiknwypi3gcdw3av3eynniacvrcew@nwfye2jkvgmv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert dt-binding armada-375 from txt to yaml format.

Signed-off-by: Aryabhatta Dey <aryabhattadey35@gmail.com>
---
 .../bindings/arm/marvell/armada-375.txt       |  9 --------
 .../bindings/arm/marvell/armada-375.yaml      | 23 +++++++++++++++++++
 2 files changed, 23 insertions(+), 9 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-375.txt
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-375.yaml

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-375.txt b/Documentation/devicetree/bindings/arm/marvell/armada-375.txt
deleted file mode 100644
index 867d0b80cb8f..000000000000
--- a/Documentation/devicetree/bindings/arm/marvell/armada-375.txt
+++ /dev/null
@@ -1,9 +0,0 @@
-Marvell Armada 375 Platforms Device Tree Bindings
--------------------------------------------------
-
-Boards with a SoC of the Marvell Armada 375 family shall have the
-following property:
-
-Required root node property:
-
-compatible: must contain "marvell,armada375"
diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-375.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-375.yaml
new file mode 100644
index 000000000000..d56d3d6d40d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-375.yaml
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/marvell/armada-375.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Armada 375 Platforms
+
+maintainers:
+  - Aryabhatta Dey <aryabhattadey35@gmail.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+
+      - description:
+          Marvell Armada 375
+        items:
+          - const: marvell,armada375
+
+additionalProperties: true
-- 
2.46.0


