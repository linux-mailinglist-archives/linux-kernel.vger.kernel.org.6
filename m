Return-Path: <linux-kernel+bounces-381553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CC99B00C4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C22F1F25E16
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6F11F8199;
	Fri, 25 Oct 2024 11:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i3CqNp1V"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586CD1FC7C7
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729854129; cv=none; b=f2P6KbRGj5an/65Fu+i0i5YGxdB9l+e8lmhde2U6nkSGWO5+SqcKa54fmDwGupTTcpBq1kIjpffCl2Sl5p8oHaVcRjE4su5BqzY1tYWeGcXPCw/bC5vka8qQUyr7VEY+I9dF4MsC4BuKT4910trrg8+E9zBOQr0j9MjOSK6g6ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729854129; c=relaxed/simple;
	bh=HuI7CfpbXZx89xIg8THe2k/U9xJ6coRkJnZWrnc1Lhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGD3sPMVboR8UXC0nXZf72euwbapxtxgvNAEni6z3+RTI4hFXcWJudXydz+uE/tB9e9xudURShVQQH1lOsRdYd1d8S7Cs1KQ0kEQzVD9TTjJW9BcuoB3PGkNY2EZibiOrL2VtthA19L26dJTKuUZIIVnKK78wwUuTNmBcyYuLJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i3CqNp1V; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c8c50fdd9so18496985ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 04:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729854126; x=1730458926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXrTKO29i+9riFKtMDpzC5dJ0oRASlg4ZqcDveSTxxk=;
        b=i3CqNp1VtJ6FRUOQoQDzJqJt2OCEC6uxLXI+x/eJaRmjwRnHzUho7jex9m0dfn1mdO
         3aXCR09Hz0YB+5ZVgMeStG8HmiL8BvkqqSdHLLiAEc4vaeje8+dD18KysrHqEuRiWAwR
         8ZXA5vtazhxc0nxNg06hWE8QWAl8DS10ptMKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729854126; x=1730458926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXrTKO29i+9riFKtMDpzC5dJ0oRASlg4ZqcDveSTxxk=;
        b=tZIl2ckCDEvEhC49wI/fT7wdH+b1861sEUEX6WMJK+PXGxuDzaS+4T/mBeF2FsBtsE
         GYtRJYS7E5VvKF1chv7GWt9d4UC3x+Eqk1R3UQIjzOHNYcXbLZdIO8YUkYUVc4GUwQO0
         uZsUtdbf/gZWh0diz+oVEsR3HLujB3ix4p+Ko7fSW7Et3qPc14oF++dOhXZ0oelGICBc
         osN3BOMqDatN+skiFW5XwewepSH83tEGESfa/h73bL0tk6pSG0VJiRn+bPgllQktyRVk
         ro+lRZzDVYHES2i2y95DldlWeiVyV8o1gdfRLpVazV/09zKpLBOf6I6Wpjfr8SEc56k8
         SYqg==
X-Forwarded-Encrypted: i=1; AJvYcCXm3CoIMl6qUVcIkb8GpN3Wq26wTPGgUIJcMPh4P1epajCZCYaC0lugDtxxPQhXD6Rs4gyne8DsCMA/VSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTjvBLnJGcAt+J5/0VEKc/ynbOpJ7q9mQaW9VS1MSZpcVHSEdO
	ZZTKh6Yok7iAMKOWfoYylXJBmvpnGEg+3dWy61Tg8Y6CxGYB4vAsyDntaOpJ2Q==
X-Google-Smtp-Source: AGHT+IG4TIqfgI8FWglIjkgZ6paBZxepL1z+0e2SainqCz9RlgYpyONGoQZzrlCGu/COKAqZwdWOEw==
X-Received: by 2002:a17:903:32ce:b0:20c:5990:897c with SMTP id d9443c01a7336-20fb8a5b3c2mr71630985ad.27.1729854126393;
        Fri, 25 Oct 2024 04:02:06 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:ebe1:dd63:343d:8a4c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf4472dsm7588595ad.13.2024.10.25.04.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 04:02:06 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fei Shao <fshao@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Rob Herring <robh@kernel.org>,
	Sean Wang <sean.wang@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: arm: mediatek: Add MT8188 Lenovo Chromebook Duet (11", 9)
Date: Fri, 25 Oct 2024 18:59:35 +0800
Message-ID: <20241025110111.1321704-2-fshao@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241025110111.1321704-1-fshao@chromium.org>
References: <20241025110111.1321704-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add entries for the MT8188-based Chromebook "Ciri", also known as
Lenovo Chromebook Duet (11", 9).

This device features a detachable design with touchscreen, detachable
keyboard and USI 2.0 Stylus support, and has 8 SKUs to accommodate the
combinations of second-source components.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 Documentation/devicetree/bindings/arm/mediatek.yaml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 1d4bb50fcd8d..4b68f0baf010 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -307,6 +307,19 @@ properties:
           - enum:
               - mediatek,mt8186-evb
           - const: mediatek,mt8186
+      - description: Google Ciri (Lenovo Chromebook Duet (11", 9))
+        items:
+          - enum:
+              - google,ciri-sku0
+              - google,ciri-sku1
+              - google,ciri-sku2
+              - google,ciri-sku3
+              - google,ciri-sku4
+              - google,ciri-sku5
+              - google,ciri-sku6
+              - google,ciri-sku7
+          - const: google,ciri
+          - const: mediatek,mt8188
       - items:
           - enum:
               - mediatek,mt8188-evb
-- 
2.47.0.163.g1226f6d8fa-goog


