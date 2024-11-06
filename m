Return-Path: <linux-kernel+bounces-397502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2CF9BDCBE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F74EB23E67
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCD42178FC;
	Wed,  6 Nov 2024 02:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtc33L0M"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664711D5CD3;
	Wed,  6 Nov 2024 02:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859248; cv=none; b=OWxRWpGa1WMXvw1OMrhPvfrO/leJL8YPtDCaYz1MzIcW9VEnTEgRXU0oAlRirXMIi1DeG5CSqWaQIFmyoV1pah/DRXlM1O4JtHNFHVRxGacT9UgUm7h2VWco6JCZMp/DE7YjwqtKAn+V+a5tZkU2kHI7NxFEuI9pZEk7MoMM3xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859248; c=relaxed/simple;
	bh=GKx+z2vVNQiCgDOy7U+vN5emM5HYdrNVeyY/5sR7jlw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oS5HijuPMMQRQPQslQqQrVvqGlHDxN5JWLnX/fQcPvgyS6lczx/dFMlV4c/TcnzmwQbyYpd7/ICPpX0s9nRyoS88V3gd1mXpOQCO1W8V+nL3BDWm7WGS0QOFlpImzb2wggrzaXggS9kkiMdW85ZOc1efmSN9kF6vqYQdmyj2OZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtc33L0M; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e2b71fd16fso570799a91.3;
        Tue, 05 Nov 2024 18:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730859246; x=1731464046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yprsd14/UhfMe85vqYoBkjNPR9l/bSjJtwuT1KvvKb4=;
        b=mtc33L0MLsBLfPhBwtUszDLXs0CP8Q5Xi1P8Ml05eUWbL8TnL9Gfbf+9gF+pp9sgVA
         eYNEahfakKtO++AkUZ1yMTSEbJqyJyPgiHe8SCZVdYrCjvkXy0UjqP2v1L4t409wLrKC
         bstC+0amx6qst+whquMKtZtFRDGCQxzkrNAeAECe7CJzx0sxbaJLO39uRuks5f6LUdk2
         cpLUEjczvBFz+wb8w0ZJv/x4LxWI2onJEZJ2FWLklQjhl6i9Da+90QC/CvquNhbZPs3C
         amGQcKdJUjnDtbjbRSSqEc9spg870dDKKl57tOcWmcZsQzmYJ84iTC2W712ICfmaG7GD
         zUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730859246; x=1731464046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yprsd14/UhfMe85vqYoBkjNPR9l/bSjJtwuT1KvvKb4=;
        b=n8SttuqLiNcIOB64ntoxxsyR+kN2JUCHKEwD/+H0gQK3P+PvuBObOqR5LaNYCYc5dC
         s6BweI2E7DrdcEOZK/9GLFEc6kavls5n5K/8FwG3oXt8LP8/xhZk5+gl7wKb/tQFKDAf
         18A3v1ver2KAAWe86yqq9UibAXflffOrYqtnHYzWnzprQQ7VIFQodO5UL/jWv4bkcOZs
         Mc8YfAdW/R95wBFwVgiYiZV7HDsWFyfRHj+8Wi8m0OG6lVr4J1oogyzjD2XXnAEHTuOd
         wf4PVnKv2sCtLXsgEv3NbqbWyE9dv9NwaMZBA5Fx/KMaPjPrIXhfY1hrPWa+5mDaJ7m8
         3UDw==
X-Forwarded-Encrypted: i=1; AJvYcCUYI0IVMa16EZ2xalGH0a0kIvK+5ir5URliU+6n1NLW7sGCHQS0EnQj9N9kJAHq1AS+guS41qrrE3hT@vger.kernel.org, AJvYcCWOGSTz3/BE8nxs++XtSXyUX+iLCIpb8N6Ale1qqjBrO/skqjNbC5eL6YmOsjRi2V2lZEZZQD6LdFrUlUG2@vger.kernel.org
X-Gm-Message-State: AOJu0YwYnGrLjPSi5tMEZIOuT/9jQc2L1ZoV0F5e/50+ssJjswRLV34B
	3EYy6zT7M6kDxDOrMBqruIEU+7uCQ5DZeFgKcDZsGmtTfkdeDdAC
X-Google-Smtp-Source: AGHT+IHoaG7ZRFOmR44C1y2gQzLow7Iwn0nvTGv7MxEG4/TXzxonUkdNRkqGUmhu6MFQ24xwtpa/NQ==
X-Received: by 2002:a17:902:d50c:b0:20c:5da8:47b8 with SMTP id d9443c01a7336-210c689759amr232758795ad.5.1730859245632;
        Tue, 05 Nov 2024 18:14:05 -0800 (PST)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee452a8b3fsm10021131a12.28.2024.11.05.18.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 18:14:05 -0800 (PST)
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
Subject: [RESEND PATCH v3 1/2] dt-bindings: phy: rockchip: add rk3576 compatible
Date: Wed,  6 Nov 2024 10:13:56 +0800
Message-Id: <20241106021357.19782-1-frawang.cn@gmail.com>
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


