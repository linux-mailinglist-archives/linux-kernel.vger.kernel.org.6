Return-Path: <linux-kernel+bounces-353485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E0F992E71
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDEC61F21B25
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE301D47C1;
	Mon,  7 Oct 2024 14:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PrOdVQLw"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AA41D47AC
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310185; cv=none; b=o8o7dEGh7Falvtu+P8sTnaDlEOiCTplYokgLRb0aXeW1ix928u8wUsiWXgSPYej1tg9WcINzJrNXcSO/3m/Q1/6cI+//xm4g/qP4+I8lLDwBgi8cAmdvMzpL3ajLtVCcSMuRy07s44lJ+xxyu/JYHLWX2z5A/XpG5bq3jpajMR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310185; c=relaxed/simple;
	bh=GvNAWjsTO8OmF8M2BEvmxuvQTz7mfmYHmmUAcH3xWjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Cdkd43hK6HLhS+9w2fBebYlAbOpkDZODt1iQZm+FjV+8pavp557GfQdmY01gu5nLUvTdeMjTBYQng6AdEqR5BrUkSEVcj3Q/A1lTDmh/FLxmF6HOzrlOplyDv+SQ0JfZ+eXnv3lsV5N64oc0D4uLgrfmWQOdTx+WDOxAnUIGCzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PrOdVQLw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cbc38a997so27961015e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 07:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728310182; x=1728914982; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9eGAqYpTSnP5IYjr6JkHkKf6Pg0tCBpu2cvMnI7AN5s=;
        b=PrOdVQLwOdTwK9LvUqt8K7sEjjzVeHQAD2KziBaVlHan+7l0koeN0QvS+VL1kZJB6m
         YcekeccfFtDx3/wxC0I1jWlTaZVNt1Tb1xDA1+cxO672kZ/iQve8dq9a8f8znyAFQVYb
         jUVmt4EeQh+Hov7fV5WG4qj3xNu9f86BIhur4to06fcLnFXaki4Sg36uFWb5V2RsFM9n
         zMceQ5pql758zOVldCJveDqkGRfg9wsv22hsbJ8vLzec7ayK0kuCJM+FptVK0FVft8jm
         DoSzfFLoA6qxJ12yb6JOBhuCrRtXhS12rs2tE8QTNDKaYSGB4M8kQbNEdslVoKsT8xZ/
         8lNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728310182; x=1728914982;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9eGAqYpTSnP5IYjr6JkHkKf6Pg0tCBpu2cvMnI7AN5s=;
        b=tI6CqRV4BYMCfBwBxY9OXVgPZJe2MLCM9nNJTtqiwDeQm7OV3ZPjudug7sR+7sXsFY
         IEWUpgiR8rZTBrBWcqCuhdIEhZUO+Y0262p/8DLhb90sbwn3LyaUlQXt5xIf7XofrTp2
         tXhEK7Yscf79uT3md5ivXdkAyF5c2j9qlOZMeMU5j5UDXx7yqVjlHLTBnrh6CeenRXH0
         uYmHYaW1T1lbJw93y2shevtASpMNEoapygTa7J46Lk9zhciwO/ZMjrUbtpnmHIpGSSQG
         IqvxnWmcT/TOGdGOkEXH4GX3xzdJIlbP21DeU5dN3XCk7+MRel5o7SxYEMcUsEIsLvB2
         YW8A==
X-Forwarded-Encrypted: i=1; AJvYcCUt/VU7w6cP+UyvJJmodNDHfWV22HozZ4GPqWheaVjMVez/LXpEEECBr3J8JHILPkQ/Y5oiG1F8KbbZurs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxza0C2njP7RqjGe1NkTb79OOxgIUO/2GNbtWNfpHS/DJo6LLLC
	lUN7NGwiGY9X5JpZ6tNUmKyoyjN5viTx1dG+l7cdEthgFfDGlg1XNX0HMOJM9lM=
X-Google-Smtp-Source: AGHT+IEoBYrVUhHyrbUNCwAGbXc+NkRoj3HtTAp7KaajIN1+ewQ5hVAOn9cJfZ3bGQRw7ZRGjXLJpA==
X-Received: by 2002:a05:600c:1c87:b0:42c:b98d:b993 with SMTP id 5b1f17b1804b1-42f85690329mr64378395e9.2.1728310181578;
        Mon, 07 Oct 2024 07:09:41 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b4aa8dsm93766905e9.43.2024.10.07.07.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 07:09:41 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 07 Oct 2024 16:09:38 +0200
Subject: [PATCH] dt-bindings: soc: amlogic,meson-gx-hhi-sysctrl: Document
 the System Control registers found on early Meson SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-topic-amlogic-arm32-upstream-bindings-fixes-hhi-sysctrl-meson8-v1-1-896b24e6c3c8@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKHrA2cC/x2NywrCMBAAf6Xk7EJSLab+ivSQJmuy0DzIRlFK/
 93oaRgYmF0wVkIWt2EXFV/ElFMXdRqEDSZ5BHLdxSjHi5LyCi0XsmDilv2PNZ5HeBZuFU2ElZK
 j5Bke9EaGEAj4w7bVDSJyThrUpJ2Z9Yo4T6JPSsV/2x/35Ti+AFN2SJAAAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1630;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=GvNAWjsTO8OmF8M2BEvmxuvQTz7mfmYHmmUAcH3xWjo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnA+ukvWuQSIbIknk0kNg+wTRw4T3VGv05YtnvNaVz
 AuQp8ReJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZwPrpAAKCRB33NvayMhJ0VpuD/
 443JbwqY4DdWhMLpitV/6InB0J6rz62XzKB2baifQG/qEjKcFujPEHzD39Dhhadrmq8qGsnCzxuy2V
 9n7wdZ+T9QjfxJg+c2ZX+0eiApiZHfFAMN7ellGhLa3MbTnslakOdv1a0X56qYz98B5MDLXPIJwG6i
 NVBZDH58RIXQl/EdQ44Yl8iIlyUZg1aO/CPyygA71fdBdRqCFstjOfu74zSvCXv6wG+s7sjA8N/25/
 PsilnikfZo1iAupEz9lLVIpO/fYUqkksXsAhCy26/te0/T+JXxp4sEnQeLSYKQuIwUgGWySb8osdpD
 cear0CD/CRozwXmrLwJyNZc6UK81LTPRE+4jnIarlvOA5D5pc0W60/QhfVD0b0Jevc7rQ9/nFlSmgj
 cQF+/8y/sTvFUDXZR2AGq3jPas8+kLXju4CzItsrXo3l09GjWq1wEdhvc1y+LFxelckJC64ot6+lnE
 6EKDiMo6HrP6iaNEAzCVtJc4mrvUNKs3lVbMlvTOxpF8fYqCBvFIJUg1gjGPxBZz3rmlurjHrY4ZEY
 NVrKivoVJnFIeFDuWXhFW2XD2pywQytAY+pU0wiuk0zJlVqrT4MBPwgkpI9ZppwXc+uI3SgIhTDWg8
 noJG22J465j0iv8XV8ozPVL/7wUQqbec8uvOD0HrXydZqAzAbsnHu3m5ciEQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The early Amlogic SoCs also has a System Control registers register set,
document it in the amlogic,meson-gx-hhi-sysctrl now the clock controller
has been converted to yaml dt-schema.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
index c6bce40946d4..3dc66f1de023 100644
--- a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
@@ -13,6 +13,7 @@ properties:
   compatible:
     items:
       - enum:
+          - amlogic,meson-hhi-sysctrl
           - amlogic,meson-gx-hhi-sysctrl
           - amlogic,meson-gx-ao-sysctrl
           - amlogic,meson-axg-hhi-sysctrl
@@ -36,6 +37,19 @@ properties:
     type: object
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - amlogic,meson-hhi-sysctrl
+    then:
+      properties:
+        clock-controller:
+          $ref: /schemas/clock/amlogic,meson8-clkc.yaml#
+
+        pinctrl: false
+        phy: false
+
   - if:
       properties:
         compatible:

---
base-commit: 2e99ba3e918f5f1a987c86e559fe8f14d9c4048c
change-id: 20241007-topic-amlogic-arm32-upstream-bindings-fixes-hhi-sysctrl-meson8-158da98bee95

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


