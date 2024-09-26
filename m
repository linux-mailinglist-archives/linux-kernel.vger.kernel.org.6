Return-Path: <linux-kernel+bounces-340322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 058CB98718C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B704928327D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5219C1AD3E8;
	Thu, 26 Sep 2024 10:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLuy/Adc"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19057101EE;
	Thu, 26 Sep 2024 10:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727346754; cv=none; b=QdokT18m4IS6loKaM6j9NSl/LYkwnQiMTBzkXIECGeyleBHEXlossxk0fFCxJ7j8E5YbNnbSm5lfVWfppDtdxq/O0i5jJbcP/1UQs2nUoYYQuW+FVGi5j6W+NJsQ0iJ9ah17PLWTYCqAqFPN47wwJfP2ddhecWugo/I/xsjn3LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727346754; c=relaxed/simple;
	bh=gqJf4ubvYAZqo3R+fl9mb0Df5UDEKLggGt0IO2JB8ho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CskDpElXRoRUkYxiV9irRbQO8ACW0LC1jeQVrO4M08OpW8noKjEpJRPIyutzmW+gZEXSPTJRexmqfNlChxKdWAMSU6S5d+Qkab9na3HN6JkdSUqJ9EUDd441oNpghQwCejBCbxQe6gKf2xY+6Oc+G1kqCR6wuuSg+esvir0h8nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLuy/Adc; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e0752be2d1so162951a91.1;
        Thu, 26 Sep 2024 03:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727346752; x=1727951552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yplOqESzYqLDvQmwdZgALdv94fRWUFq6dl6xc+7Ckb8=;
        b=nLuy/AdcDcF5HcH7GK5QN2JmnktYSr0aP3tWMn++aEQMxG2cM0BaxZkRiuOcqjjrRV
         ODmSNWt3kFN1HZkHzi+1/2LqT6cH/wILt9zrPBNihaXS2dxbETzihmCnjYATA7El2yf4
         x0X7rIsWQa2LUu+onmoGxFMdpVqqN+MTH3VN0cmf3eJw9NjEwX3UmM1mrcIrL2LQygNf
         6l8JEpi5GVZDpVjazye4ii+tYzuoFYGLwrWq6fkAy0bCggeFEOoGtyn27/Efw3fj6dAj
         EUqWQhx2qGs/9wpDOrX9wc4uIWdIB0jmXGs9rNQ4Q5bUVGSu5FFUQcNljBxFRnT67qG0
         wdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727346752; x=1727951552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yplOqESzYqLDvQmwdZgALdv94fRWUFq6dl6xc+7Ckb8=;
        b=i55NvQ7xLldQ/0FdtQTms9QyvkQOF/a2HX3x9jkh8CFA6JCOBk2/n7HEjx364VY+9D
         zogbh3PHB2HLtRb8viHOVyK+YK1L4O+lo5i+W+/d1GUnAKQge64VE55Ro9RjHxe1tREA
         BYBtmV8D8pR0cdG+ZlXAk5RImUBbsLcxH8KP2Q/W9SJo0CMZb4GBiaayaRfTWxltdMEx
         OMFWbsrp3DkS1TesdQePArI/2mEPWoPtu9pfq+sC7iE4f5mofBHUg4tZRuwv1xOQwc+g
         ZaJssgIPV9M3XWaCbgsThppoaYgw9EMJ6S/NtYqj8qV0HDKqEV63XbWc1CdLJo1udz2l
         +OPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbH9xwV3iYP3ExyvRXgKbgV8jYzxD+F/OoixFm+Eg3VXtynLdrpp6eRH7kGZH6TB8AdjqZsdm7u4kNJIRx@vger.kernel.org, AJvYcCWlK/nP3wp9Y9Bv5FKdKcys5CboiH0ziYcKI36oIeWWMkdbTP3PCgq9UCXX/txalikdyuIlS6xWCAtr@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Oq2rK5FeCSCtSbrrtkUp6kF+uvUR4Qbk082+aHcz+E4KQU81
	j9KenlKuFkWyq+dn9C1iU9kttaBQhYLqGdhshQlFfQsHK9VgUl0I
X-Google-Smtp-Source: AGHT+IEFSkZQ25a/ZxAw8mKQA+KcnhyJc9/yGZ1kvTCmns89prNEmc17sfecAtsdnCz6aT9GxWyt5A==
X-Received: by 2002:a17:903:183:b0:207:14b3:11a7 with SMTP id d9443c01a7336-20afc6a1d36mr37790185ad.14.1727346752184;
        Thu, 26 Sep 2024 03:32:32 -0700 (PDT)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b002aaa8fsm22109335ad.240.2024.09.26.03.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 03:32:31 -0700 (PDT)
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
Subject: [PATCH v3 1/2] dt-bindings: phy: rockchip,inno-usb2phy: add rk3576
Date: Thu, 26 Sep 2024 18:32:22 +0800
Message-ID: <20240926103223.29538-1-frawang.cn@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wang <frank.wang@rock-chips.com>

Add compatible for the USB2 phy in the Rockchip RK3576 SoC.

In addition, since the RK3576 introduced the USB MMU, this change
also add the related clock properties for it.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
Changelog:
v3:
 - narrowed rk3576 clocks by compatible property.

v2:
 - Categorize clock names by oneOf keyword.

v1:
 - https://patchwork.kernel.org/project/linux-phy/patch/20240923025326.10467-1-frank.wang@rock-chips.com/

 .../bindings/phy/rockchip,inno-usb2phy.yaml    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
index 5254413137c6..d286753bd53f 100644
--- a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
@@ -20,6 +20,7 @@ properties:
       - rockchip,rk3366-usb2phy
       - rockchip,rk3399-usb2phy
       - rockchip,rk3568-usb2phy
+      - rockchip,rk3576-usb2phy
       - rockchip,rk3588-usb2phy
       - rockchip,rv1108-usb2phy
 
@@ -143,6 +144,7 @@ allOf:
           contains:
             enum:
               - rockchip,rk3568-usb2phy
+              - rockchip,rk3576-usb2phy
               - rockchip,rk3588-usb2phy
 
     then:
@@ -171,6 +173,22 @@ allOf:
           required:
             - interrupts
             - interrupt-names
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
 
 additionalProperties: false
 
-- 
2.34.1


