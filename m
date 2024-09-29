Return-Path: <linux-kernel+bounces-342814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69E9989339
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 08:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 849D2282C3C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 06:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CEF13D524;
	Sun, 29 Sep 2024 06:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2rymCGj"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B2013D28A;
	Sun, 29 Sep 2024 06:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727590240; cv=none; b=lHxRyEGq4T1G+8uYpkjZmuiB61raKcakwoOIhsYTw49zOMOrTEXHhfwaej3FMnQBwhsrgxsn/Oqmqsc7C3K6ZEKk8HwzIVF5EhdiGndFjIYj4oSnM20V4wruoUsrUyk5C4PtWTj3Nsub9kznHhyg5pR21Ff2Firco6Xnj9xQWUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727590240; c=relaxed/simple;
	bh=2xW7HYcBiqEFDN5XOOyYv5nkdJclAF+R7hrvIKPBs3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9xSU+ESPGwLQDMOo5OQIt0a+T2X/CMnCdwC7cBAciqv1t97ejQOkeoSRzx29zzunX9i3V+uSwD3qWCRWXuUyqHDH3c32SwRJMdzPHHsStwEycalGlhE1cIkO0ZEMVGQzy9qychLNZpBvWVhHc8aJ7s86mU7NQMEjo/BQg6wSgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2rymCGj; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2db6e80555dso717671a91.0;
        Sat, 28 Sep 2024 23:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727590238; x=1728195038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKZkhBzFBP4JhC5YWwmTbC/Q9z4TwAHwN6I2TQdXXDc=;
        b=V2rymCGjOFp2yqJRKycqxKtYEo3kBc57XE0D81GNZNB2eYMev9DJ8Y4VQohaqWmmts
         jEqhdZkA0hh1RQdAksjnvxghdylDGRvOsjkJ6FmWhKtSNVjpI4JUWdLf+Bcie8Fo1470
         d7QzU6vy+PbitQIGa0tX/s+ynyIXPVUsO+yklD72MZXnCLHVTpJfLPAn/oMO4h2RdLr9
         YI20311hQ4GQ1qvmY9T3wNmDR6xB5jPysQXCacsfHwlLiMpDx/vec5q8Be8t02xFnlrP
         KpT7a7RkjrVjTWbSjVu4lt+q5A1mFebC14HX7EfhdZM6BvpFVxfj9Z9UlcB6X40Dr48L
         0Mow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727590238; x=1728195038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKZkhBzFBP4JhC5YWwmTbC/Q9z4TwAHwN6I2TQdXXDc=;
        b=SeXlRsgzdx5pvRbVL8z2ptQhKH8PHldsluH8/9mJu4l7Co9pMt77vK2+21s4cI/iGD
         9e1HYaC5akts+COzKpfVEF9ydTezjcu737IWVnzKI35cWPavWN6XZ0BPeX8kEgqF/gKD
         H+1mL5UUz6RorHPDd6ceyT5TR2ZiXLycbYbQfKIs9Vd/zDhrDj0UZNpHFVuXe9Nmu+WF
         YCizcjhgrUHnLY080VYW1BQ9mUl39apXaL4Be4pFbRJv1wkH6DXTxaEPYevrmiU/FoBC
         V+k+XeQ2A9teJ1kYl98qZ8q4PCVsg6aYiI2AdjU/uO9S2AP2X7VAA+n9+p+6P+syqVGt
         yNLw==
X-Forwarded-Encrypted: i=1; AJvYcCWNhl73KTmHdyxzk/B4OpoTJ30KyJt3628Oq9TpD1If1Quh3hEG6thPeePvwnd7Q6qKLUZwq4Zg6QS3pBCQ@vger.kernel.org, AJvYcCXYM3RLT4bfeBjqocstOldFo44OS17RvSfSRB9vLro8InUkeQ+mnt4t6C+eVZGE2iBkmP0h39dX6PHA@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ/FsgYHChYqQSEz9tRHl3pRSk/+bXGjOTrF/DbbK+CKk+izcr
	8j1K/v5aa2nB1VJ26Fa94YMRAYonbjyCz6RVg+xWlVYuFKZFOegn
X-Google-Smtp-Source: AGHT+IE/hAsWcepkQrvYbUPM/E44kL/wr6eljuSNfdhzQXdTFpjJ6T8n0NU2RcJpW1S49Y+mbmcuAw==
X-Received: by 2002:a05:6a21:6da1:b0:1cf:3130:9966 with SMTP id adf61e73a8af0-1d509b1c253mr2953358637.3.1727590238089;
        Sat, 28 Sep 2024 23:10:38 -0700 (PDT)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2b974bsm4269584a12.34.2024.09.28.23.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 23:10:37 -0700 (PDT)
From: Frank Wang <frawang.cn@gmail.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	william.wu@rock-chips.com,
	tim.chen@rock-chips.com,
	frank.wang@rock-chips.com
Subject: [PATCH v4 2/3] dt-bindings: phy: rockchip,inno-usb2phy: add rk3576
Date: Sun, 29 Sep 2024 14:10:24 +0800
Message-ID: <20240929061025.3704-2-frawang.cn@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240929061025.3704-1-frawang.cn@gmail.com>
References: <20240929061025.3704-1-frawang.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wang <frank.wang@rock-chips.com>

Add compatible for the USB2 phy in the Rockchip RK3576 SoC.

This change also refactor the clocks list as there are new clocks
adding used for the USB MMU in RK3576 SoC.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
Changelog:
v4:
 - refactor the clocks list used if:then:

v3:
 - narrowed rk3576 clocks by compatible property.

v2:
 - Categorize clock names by oneOf keyword.

v1:
 - https://patchwork.kernel.org/project/linux-phy/patch/20240923025326.10467-1-frank.wang@rock-chips.com/

 .../bindings/phy/rockchip,inno-usb2phy.yaml   | 46 ++++++++++++++++++-
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
index 5254413137c6..fc2c03d01a20 100644
--- a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
@@ -20,6 +20,7 @@ properties:
       - rockchip,rk3366-usb2phy
       - rockchip,rk3399-usb2phy
       - rockchip,rk3568-usb2phy
+      - rockchip,rk3576-usb2phy
       - rockchip,rk3588-usb2phy
       - rockchip,rv1108-usb2phy
 
@@ -34,10 +35,12 @@ properties:
     const: 0
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3
 
   clock-names:
-    const: phyclk
+    minItems: 1
+    maxItems: 3
 
   assigned-clocks:
     description:
@@ -172,6 +175,45 @@ allOf:
             - interrupts
             - interrupt-names
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,px30-usb2phy
+              - rockchip,rk3128-usb2phy
+              - rockchip,rk3228-usb2phy
+              - rockchip,rk3308-usb2phy
+              - rockchip,rk3328-usb2phy
+              - rockchip,rk3366-usb2phy
+              - rockchip,rk3399-usb2phy
+              - rockchip,rk3568-usb2phy
+              - rockchip,rk3588-usb2phy
+              - rockchip,rv1108-usb2phy
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          const: phyclk
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,rk3576-usb2phy
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          items:
+            - const: phyclk
+            - const: aclk
+            - const: aclk_slv
+
 additionalProperties: false
 
 examples:
-- 
2.34.1


