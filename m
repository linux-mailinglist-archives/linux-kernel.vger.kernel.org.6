Return-Path: <linux-kernel+bounces-336810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB047984124
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 275121C20B4B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FFA153812;
	Tue, 24 Sep 2024 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsV4WdAE"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A0B450EE;
	Tue, 24 Sep 2024 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168121; cv=none; b=enErK9MtDVJubiEDHYDWO5mqMNtw7Hl1IcYtMUyMatejLULWInvW5GZpQ/X9ZGHdsOtPIvL7hAe9UVv56fFOSXJZQkT2V/Y7yre3Crl8ffpSu+B6bvsos+SpMwhmM4CwXkLAsllXkndoG3T9pG6zJx9uuGQwQtrPWTHTp5q6PUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168121; c=relaxed/simple;
	bh=fGfh0suT4ScgP4IoXIE34R9h64ZSzd4MmffyufB+b64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EkDOe5WeC3yowCQIjTCTUG+6YO62FNgNNhlYLkxjTocZiq2wyymbMvtUC1/k9hwtBcllVE+5geSdN0u/6hmZ6wY60mcDZO4PHK7BGIEXaGGpU34rhHjVk+cQLhkevQuoQ+Jy9GXtHqqYWSUfDN4f12/5c5SfwpW9yfePFpgtu48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsV4WdAE; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7e6b38088f6so104798a12.1;
        Tue, 24 Sep 2024 01:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727168119; x=1727772919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/FI1DcNAuH3qKf7n7Xl/ic4hrmrj7FMsL5tIw63tMgw=;
        b=OsV4WdAEGGjU5HX1nCE00tl89qZGjMcQzm5b7cI6rwXKmj+/oTwBqCcG4ZOjIDxIHl
         m6FVZDZA6Q7K09aEcNIPKROxcgaMZGxjxMDDe2OIg2RcdIXB9r9V2RHq98F4bBfRN0ar
         zxB/yup9YEAvfBOY4i44Lc3kGgawI/wbCy5ES3kNLtxsF8DuFd2O4xH/Cdx7V1ODknEv
         34q4XhotX+2V74nIkui2IuUugPIIRFnWBSzdq4o1y9ILyLvfV+BUXAsnRaRUuyA7PTuu
         eNr74P04K9ETUvgtp4xSfyVdz/NJUH7vQYeR+l0ePufyHTHvgxCmryo1zmvvBmdz+QAD
         JL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727168119; x=1727772919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/FI1DcNAuH3qKf7n7Xl/ic4hrmrj7FMsL5tIw63tMgw=;
        b=MtnisdpQu5M0rYc0eyIapN3T7+rt/QdRfI6PFUK4sucSMs7cUZgv6TVM5+TtVjlXvF
         yEtA0FhjaK8zgzj+ES//4HfdMzauq0GzggQf/lUSFSaa/ks9NFmepAf9sSBx5qgPeHxA
         WoTE1UzGd9ht+B/sAvHwX79o3n8lANGnUpd6ysMgS58XG71KWiDTTWWX/8MBEW9yFTx1
         Gz/Aa9b1b3bd3ljtVv+o4okVCrwjPBkp/uIrp389f8fLc7hpMDuYJnxuWJpmwlgTj3f3
         2F5f4xvEhwo6N+gXyBnXyVjnQPTZ4khenjDoIa005b9PUST5elBV8SAViG58TrXozYho
         FfrA==
X-Forwarded-Encrypted: i=1; AJvYcCUZDRPXAhAtEoCyR7uCe480ZaqjLztc9GauI250l+jx8e5dqYsUTsjcAu+KcS2fyV99uZ/iq5s91iCei8cm@vger.kernel.org, AJvYcCXMsFIC/qLor+dTyB5g2HZg7cv2y7r8wxJ8GngRpX9kCM+oWlcoOoLHY22Ubia7e8HXnN5UU9fnNGmy@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+PeCbHztdaOkerXzZQkN0z00P3h3iiCUO3F4a4CtpEyHWdK41
	TWNVZXN+HEXeoZSxhc1XmjlEFwwIwYZv754frVGjW/YuLhNhNcwp
X-Google-Smtp-Source: AGHT+IHxkIzwP+MOur8ldY/9lqikVaW+SAAtkZjc59TlE/i2ve5nhmTkBi3mBcZoS3Y1WtTQYnYdjg==
X-Received: by 2002:a05:6a20:430e:b0:1cf:4903:7f5f with SMTP id adf61e73a8af0-1d30a8bf46emr10200468637.1.1727168119286;
        Tue, 24 Sep 2024 01:55:19 -0700 (PDT)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc97c18bsm795090b3a.158.2024.09.24.01.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 01:55:18 -0700 (PDT)
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
	wmc@rock-chips.com,
	Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH v2 1/2] dt-bindings: phy: rockchip,inno-usb2phy: add rk3576
Date: Tue, 24 Sep 2024 16:55:09 +0800
Message-ID: <20240924085510.20863-1-frawang.cn@gmail.com>
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

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
Changelog:
v2:
 - Categorize clock names by oneOf keyword.

v1:
 - https://patchwork.kernel.org/project/linux-phy/patch/20240923025326.10467-1-frank.wang@rock-chips.com/

 .../bindings/phy/rockchip,inno-usb2phy.yaml      | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
index 5254413137c64..8af4e0f8637fc 100644
--- a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
@@ -20,6 +20,7 @@ properties:
       - rockchip,rk3366-usb2phy
       - rockchip,rk3399-usb2phy
       - rockchip,rk3568-usb2phy
+      - rockchip,rk3576-usb2phy
       - rockchip,rk3588-usb2phy
       - rockchip,rv1108-usb2phy
 
@@ -34,10 +35,20 @@ properties:
     const: 0
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3
 
   clock-names:
-    const: phyclk
+    minItems: 1
+    maxItems: 3
+    items:
+      oneOf:
+        - description: aclk for USB MMU.
+          const: aclk
+        - description: aclk_slv for USB MMU.
+          const: aclk_slv
+        - description: PHY input reference clocks.
+          const: phyclk
 
   assigned-clocks:
     description:
@@ -143,6 +154,7 @@ allOf:
           contains:
             enum:
               - rockchip,rk3568-usb2phy
+              - rockchip,rk3576-usb2phy
               - rockchip,rk3588-usb2phy
 
     then:
-- 
2.45.2


