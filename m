Return-Path: <linux-kernel+bounces-268599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7A79426AA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE3A61F260F6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 06:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C462716D32E;
	Wed, 31 Jul 2024 06:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d+etlb/B"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA8F16C69B
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722407208; cv=none; b=ttKTCBLiHqfDlKdC3juegefx6prjJ+FIIu/aYfDlewyeh1N3KIfncs+pTaXrNGSsOp3prQiB0/koZX9aUfGOW6Vly6YWqN/Dk+IVhy/DziwwrL0eSCyIkk36phFEpTiZY2M8xh09qHGT74edn2V+OX0WHBD7FLLOj0MYqWPnXjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722407208; c=relaxed/simple;
	bh=gN+pByoqcvM3L5Qti+k0iekH32RjU9EFODfZ4olPsFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ctOhy0vYg+e2zRPLVCTxQ5ORZMnYqujjrmGmS6mcExogsjzDXV+p814UVpjFfPxhQnE6OEKSSrl1iKezNKeFiR/LLfkEnXXNRpaURqiGxqa5H+osA5K/Ggw6v7lxHk5WYfnsrO/0B4XSNgYO0ow380M5v90IZhczoj8g/77XeYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d+etlb/B; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d1a74a43bso3783304b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 23:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722407205; x=1723012005; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6mTCTozL1kMNiDQohIkyeCe1qQLXGcgts2Oa5sMWeIQ=;
        b=d+etlb/Bk11p16l6WHTkVHcjAe7dKQZiwLjprVAkMQyxgUYuFpI32k7acSrFaULeqZ
         RzF7XERdr1Y32X59sbY6tsRPqp2LEsCq9qBIMd/OlIq21H83uNoLaUHK6eRRjjr4KWB4
         Au9XZ6kNVn4vZoWWmhb/F5KNg73PJUQ3N2K40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722407205; x=1723012005;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mTCTozL1kMNiDQohIkyeCe1qQLXGcgts2Oa5sMWeIQ=;
        b=a+GzFj2vG5kgTwVPXcPP14mRY5Qs7f+jPtu92ZYMFG54swEb6o/zAso955f8I5SlKS
         ja3OUJfzVjoWQfyaHTA4b4uSpdXbBwRVYMcCwRbhxKZ2TnMdpBR+1CioQInzr3SNn7O1
         zjyOZCdigedgAwp4H8CyObbT5W3Fz3seomwUhte+Cflrc4eTQqYrdL/rLNuGRhbspBC+
         REIy0o9nu34+uPyCnnN+GF82p8/sAf8C50yVbH8s2yR4+1Ptm4XAoenNbH60Z0hwb3hk
         TkWSRM+Y3mc/+tmviTxBNmmG1y4wtJGS9K1bTskoPrzd8qPCQawb1zErBBjpDTDZqNa5
         pkdw==
X-Forwarded-Encrypted: i=1; AJvYcCXs3iYTGmBP79TSCO+Qv6+xEi5psRcoynR8Dt2j6OPxAtvIyNTL01bQqVPRFaOaetd507kZYrus7vGbZXPHdY84RsFAZ+fWmercSong
X-Gm-Message-State: AOJu0YyxsWiZQadDZmJZ05+n6o/heaod8M9lZpN0wUU/IeZN84sFgFr0
	v4QwSdXqlKlEf1H5MB2hEZGW53J0E9E5orsq0WUTTfvW5CRxRrWG90xJGUalrA==
X-Google-Smtp-Source: AGHT+IFmp3+Q0xJ6154cwrPQLay9JBsUxdGaxHPITgVws1imP/cPhOraXxHtZKMmmYBhj+WRwQV++g==
X-Received: by 2002:a05:6a00:391e:b0:70d:3420:931e with SMTP id d2e1a72fcca58-70ecea2eea9mr11327502b3a.15.1722407205065;
        Tue, 30 Jul 2024 23:26:45 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (46.165.189.35.bc.googleusercontent.com. [35.189.165.46])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead6e1084sm9322308b3a.25.2024.07.30.23.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 23:26:44 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Wed, 31 Jul 2024 06:26:36 +0000
Subject: [PATCH v2 2/2] dt-bindings: arm64: mediatek: Add
 kukui-jacuzzi-cerise board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-jacuzzi_dt-v2-2-4995335daa30@chromium.org>
References: <20240731-jacuzzi_dt-v2-0-4995335daa30@chromium.org>
In-Reply-To: <20240731-jacuzzi_dt-v2-0-4995335daa30@chromium.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.13.0

Cerise is known as ASUS Chromebook CZ1.
Stern is known as ASUS Chromebook Flip CZ1.

They are almost identical. The only difference is that Cerise is a
clamshell device without touchscreen and Stern is a convertible device.

Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 1d4bb50fcd8d..087773a43673 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -146,6 +146,20 @@ properties:
         items:
           - const: google,burnet
           - const: mediatek,mt8183
+      - description: Google Cerise (ASUS Chromebook CZ1)
+        items:
+          - enum:
+              - google,cerise-sku0
+              - google,cerise-rev3-sku0
+          - const: google,cerise
+          - const: mediatek,mt8183
+      - description: Google Stern (ASUS Chromebook Flip CZ1)
+        items:
+          - enum:
+              - google,cerise-sku1
+              - google,cerise-rev3-sku1
+          - const: google,cerise
+          - const: mediatek,mt8183
       - description: Google Cozmo (Acer Chromebook 314)
         items:
           - const: google,cozmo

-- 
2.46.0.rc1.232.g9752f9e123-goog


