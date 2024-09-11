Return-Path: <linux-kernel+bounces-325150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B6D975599
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0F31F22659
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4083C1A38D9;
	Wed, 11 Sep 2024 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AuHcxdaL"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2C21A3AB7
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065316; cv=none; b=AysX0NiGlb4GHPXtOBTYZ5phmWJBFOS/CibqZ4rieyRkXnAlEdbjb52ZjGzJOdJc00ppitPV0s3IuaTIR5iRCTADaUUDUS92YgrWo4TZ91gbvf1FN6QrQ4Jt9/P8/2G5MW4iKFWF9ohcQ4puJ6HLv+8c36SGnmzi5AddgYF3uqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065316; c=relaxed/simple;
	bh=J9PzHNjcSXRe0BOH9Zo8tAkuChRIs4CD84FEYrD8wQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNX0Ss5WUkVUogYBs5hcMJRkCT8Js/w6Jtm6yMNc6BRbPXOaaNG1jryAQ9OM6Sl4b5/MCIgiGBV0fMriLhVB6K7OL9Y2DInXPeXCD/h4XxMuP1w5zD0hxjUMgy65MRs7wuf1w3NSZk5eTO2PE4M5kZwDNSdR5WQlC0GupZeXw3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AuHcxdaL; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3e0379a8d96so2286329b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726065314; x=1726670114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnPQW7Y4BtUSgD7VL5z1FONolY3V9ZDMRIrGcpJjXnE=;
        b=AuHcxdaLO2WPQ+HJSj5/8SVFYpJGRIub1WbNUE1x3TtOft9R/omaRb0S6/sfGfkN5y
         21TYSEUUCJyIm6gNty0Jd3G5SISaqqd5ThrpNsuDk/LafiicDHSGdZcfXPS7XSVbbD3J
         WuQQbKaB0zF0Rr0tHa6zCHAOIOiKiWf79KYXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726065314; x=1726670114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnPQW7Y4BtUSgD7VL5z1FONolY3V9ZDMRIrGcpJjXnE=;
        b=bC2TxuAm/QU+EKl4WTGR3JvHrrpjJagWl/6uDtuBmIugjf8wWkII+k6BxCGrrw2cjQ
         yZAqOVRimhox2CPrtc+z8fXQM6llkHiDPT76ih7HKYPNIrqWF5mFa++xaAz7aETjSomq
         VapiF0iGNrJuUU2cHTNWOV5dVye2BQ9d1FvXXTLyG2IKu5OJFkcMe1qOkgWlO+TaJT9b
         8oEw9uE9ovnr2YCxWlIOthcY5mhA6+iAg0f27psr7PUNaM5/mHJOA6FDeZsZtckGa5LJ
         2tQkR/BXlkBhpnGssLeLzrhwGPULm/mutRVSjg+juKugs26DQYWyGTTqMcs9++JbIlPz
         M8WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSAJLiNG8lG4mPxwO3MrVCikk/jaTzUS+B0gKxfIezMT5CkBrfVQR1R2UWltv/Ie0kLdOQEqJbG68SA2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YznK66a4bv727pPxu/W+yJIymdL2tfmuouw6tZaTo4R+DGR71Iy
	gK76Hj6Gvg5onJo3xvQ6pW9v+JzRg3FZI9lKAGuEC/lfi8wPYpiv8ROAr9fP1Q==
X-Google-Smtp-Source: AGHT+IHHUCdHBp5uv6ADa0vxA18vvNpQp5qn4oDl6lTmb8iv0NjjXhkphjoMY82rsiFzMfvLj5l/lg==
X-Received: by 2002:a05:6808:3206:b0:3e0:6a7f:4752 with SMTP id 5614622812f47-3e06a7f4a48mr875938b6e.41.1726065314162;
        Wed, 11 Sep 2024 07:35:14 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:102f:d738:6069:fd4b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fbb5901sm46620a12.24.2024.09.11.07.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:35:13 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fei Shao <fshao@chromium.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 2/8] dt-bindings: mailbox: mtk,adsp-mbox: Add compatible for MT8188
Date: Wed, 11 Sep 2024 22:33:55 +0800
Message-ID: <20240911143429.850071-3-fshao@chromium.org>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240911143429.850071-1-fshao@chromium.org>
References: <20240911143429.850071-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible string for ADSP mailbox on MT8188 SoC, which is
compatible with the one used on MT8186.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Fei Shao <fshao@chromium.org>
---

(no changes since v1)

 .../devicetree/bindings/mailbox/mtk,adsp-mbox.yaml   | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/mtk,adsp-mbox.yaml b/Documentation/devicetree/bindings/mailbox/mtk,adsp-mbox.yaml
index 72c1d9e82c89..8a1369df4ecb 100644
--- a/Documentation/devicetree/bindings/mailbox/mtk,adsp-mbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/mtk,adsp-mbox.yaml
@@ -17,9 +17,15 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - mediatek,mt8195-adsp-mbox
-      - mediatek,mt8186-adsp-mbox
+    oneOf:
+      - enum:
+          - mediatek,mt8186-adsp-mbox
+          - mediatek,mt8195-adsp-mbox
+      - items:
+          - enum:
+              - mediatek,mt8188-adsp-mbox
+          - const: mediatek,mt8186-adsp-mbox
+
 
   "#mbox-cells":
     const: 0
-- 
2.46.0.598.g6f2099f65c-goog


