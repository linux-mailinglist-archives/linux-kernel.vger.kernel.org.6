Return-Path: <linux-kernel+bounces-371024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4861A9A354F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F300F28369B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B63184535;
	Fri, 18 Oct 2024 06:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cu8EHgF/"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44F82BAEF;
	Fri, 18 Oct 2024 06:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729232737; cv=none; b=VbADQUXsUBex6AuUXuG0bJyyAPJn8V8diGw2QzHzZfnN896W4LP5UDkj71B0Yd5k3RT/sJBq86TTsg1kfiCyigQLC9v/d2LjmqGvbBZ0ZIb5xIBWozNM5CAw8xS520xkA3amLAwHgFFBKbkOAl3RR0ATqN0dxjB1FCt1MUp3tAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729232737; c=relaxed/simple;
	bh=GKx+z2vVNQiCgDOy7U+vN5emM5HYdrNVeyY/5sR7jlw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dsJFZpKzt2a1anHZp3AgSfvTrVT0vJJ3kuYTPX96lCxuvuSQ9tb4qGeCQGYSK2HuSq2aIlrdK4SZ896uASOQGKa/nnrPt0CSNPhw6b+NkjrSyPUojqE+DdACFBLrptBjG/y74C41Mgp4SNcMq8y51hOE+cHIXcH7aLy1udK+l30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cu8EHgF/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c83c2e967so888235ad.1;
        Thu, 17 Oct 2024 23:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729232735; x=1729837535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yprsd14/UhfMe85vqYoBkjNPR9l/bSjJtwuT1KvvKb4=;
        b=cu8EHgF/ofQ7e+qnfDGb/a5FdNk2ipdhsvgzNaynDrWv2d/5JPVED/CnIwfQtItRBq
         1Re+njw3TuqG015JPLVROXCkkSJBQxyPhNCqhTd4QXuUBq5aPmlpdJ8yozPP+y1gLmSi
         9X7sXrJ6dTReiWgcn852OZ6pxh3JN+d7AeWvijmjBP+KoNoj3tTjuTdtdnQmKmr4fkkR
         QipjZzMWp2gu3R85z14HxJc8Ql9zCYgQRo+hVJyIR9me2vR1P3n8zmmLfDHCsNvc6u3W
         CnHKZykj9QIzQnbzw3bOIBS9mHHbrHq+/h0n0ha46yx4Ug/WJfYSPR7N8ycHz4n6xBNO
         DERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729232735; x=1729837535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yprsd14/UhfMe85vqYoBkjNPR9l/bSjJtwuT1KvvKb4=;
        b=NYMG75HawAJTwdUVJnIkDgwy7KQzV9b8ztPsd2jsswh90dE+fY6SqDUMiKVTssDbYL
         GW6NGvnuXlxhkI62j9KMQQCiqnw/rVhbBYctoHPSyBZIVScWYLE63KjSuIVgEQ/83Idx
         Q0xKGjpIGqSMPjjW4hynxHLkNTXbOEVmIoVtizVoZateI+IIvrLgjdIHiIarI3Bjx60y
         05SAiiuZCWxVqHkgetAPQ3b7LNfTXpM1J92IecLla8YEP14AFrcEzYOzLV/AaaHGqNSO
         H2kSKQ5os4dOEW6u3ukJAdoeEVHnNgZiKeLM0j1/H0KpQ6LWGwHxAfPqKNgkjXOI2Ci9
         ZLnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+uOEVvxr+uFdUWmqnI8Skhi2wbDRTp/kJn/QItLCRjC61/2vcFEGkIEYsDwRNLz4BEsfSXZs6ZI6lVr30@vger.kernel.org, AJvYcCURQU1QYM6f/FrqjZUGgJc1To415abkOZR5JfKfK9csRgmYPEqwYAdAjqgguHdUtvCbMD3+0ZPqzVQY@vger.kernel.org
X-Gm-Message-State: AOJu0YxWWdHhgYDeDbZdq/5YfE4i7SfqPOtG3okThCXI2U0lCmxJhyFA
	c9mLP9uwNEPn3qaehQT94whE5aGy8oWl2mNabfpkdfz9LPEjZU08
X-Google-Smtp-Source: AGHT+IF2dAmotnh0dOAlrxHeuqFrtsRPsBS3jwrI7opSJUH6miisW1J66g1K8gQ4g+ORdHqWo93q7w==
X-Received: by 2002:a17:902:f0d4:b0:20c:d8d8:226f with SMTP id d9443c01a7336-20e5a91bd91mr8171395ad.12.1729232734831;
        Thu, 17 Oct 2024 23:25:34 -0700 (PDT)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a8d6579sm5988405ad.172.2024.10.17.23.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 23:25:33 -0700 (PDT)
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
	Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH v3 1/2] dt-bindings: phy: rockchip: add rk3576 compatible
Date: Fri, 18 Oct 2024 14:25:25 +0800
Message-Id: <20241018062526.33994-1-frawang.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wang <frank.wang@rock-chips.com>

Adds the compatible line to support RK3576 SoC.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
Changelog:
v3:
 - no changes.

v2:
 - add Reviewed and Acked tag.

v1:
 - https://patchwork.kernel.org/project/linux-phy/patch/20241015013351.4884-1-frawang.cn@gmail.com/

 .../devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
index d3cd7997879f7..1b3de6678c087 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
@@ -13,6 +13,7 @@ properties:
   compatible:
     enum:
       - rockchip,rk3568-naneng-combphy
+      - rockchip,rk3576-naneng-combphy
       - rockchip,rk3588-naneng-combphy
 
   reg:
-- 
2.25.1


