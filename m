Return-Path: <linux-kernel+bounces-364960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2992B99DBB3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2717287CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C952116EBE8;
	Tue, 15 Oct 2024 01:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaF7cEaG"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E5016B75C;
	Tue, 15 Oct 2024 01:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728956042; cv=none; b=ueC/JPoyCangXc4qzksiwAT1iS5HjqKdfnmCWVb0QYIFs1Nf22W4HMOt0qUd1a0BE+OXytT3HstQjBDp0sWlBHIWrHB0LfPqvDxPqq5m7ci5eew6h1tmNGGrmLbpNuFfgP3zDT0GE71UQJAU9WUmvM4ravkKPDSauA9e7qEIk64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728956042; c=relaxed/simple;
	bh=gzHnp+3yMDFyb1aq5Af5ScCbVvvT50R0x4jVCSlYl+w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RYQDwusXsLMw1wY2kS326+4ZtPpxV0YDQjT0RNQwes/9XavXKB6V3jnmYnmrRz9iUtPekvtuwGeq8ES+X1beMktlxM0GIFZBZIzgMC8P1GGFrdtVD31ats3V6vcJUeF8lQ1XdVjAZbuekAMV/1JLl5JyAfludmkROmkV9zR8ouM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaF7cEaG; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2a96b242cso934895a91.3;
        Mon, 14 Oct 2024 18:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728956040; x=1729560840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mUSB48jKblX+14i4so+c9Ta99trL5DpEUPdHUcI05hk=;
        b=DaF7cEaGagXN3tvpjbjFqmq5cYH94V5IKxvhCxCUtzLwCiDuk59UYTp7ut5wOHlSRs
         JFsgkMu/YsokB3bHBjbEcrbIpuwgnjZuGWY6ZJq5RjR9t0eSPobEiDr81I3ZinOycvl+
         bJomR0q2/3e/Fu67Rbhgo7XtpvlsMiTJA+bmnTzNiJ8pO6F/B6J23Wlrn6uia7Z49TWs
         FCesnew310KxMTMv4kObQcj57FpyNeUTciJVRmTSnsDMx+cVABz0LnsAJCz4XK6A3z7O
         5Y/9AfhYYObHDFLkNTJWWoptD+27NRpdMgRjlc70PxTlcqQkIkruOOzojdDMttXfPnKi
         VI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728956040; x=1729560840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mUSB48jKblX+14i4so+c9Ta99trL5DpEUPdHUcI05hk=;
        b=fZQfXdP4eOv7PWSh8dxWFR5EdIvP9th3ZUzdk0LJipOwei5JsSx7DD0mprO5iEzpFX
         WUZ1Fq/Q2j37T3Jy6bZg253Sf/YMAbFGnrCJYFbhnMRLu7w5J+8HfWQkbmyMi0sEe4He
         sums4nNJWLshvrjiovdmvurY8PWefFiMMibWmVene8lDwU3r5dE2EKTgJukM44P9jZHV
         2E/XXXd0AzLq8/EIUAavHwOyF5VecyNd3rPmg+YWTZ7dE+wfFZFGBR9rhvHkZ73+2P26
         KPCA8bHKvZZpUDbecEoisYuCokwBYvRvyc4uSQfboCKBTalVAAXTjnDP4R3SZ8OVcos7
         QChg==
X-Forwarded-Encrypted: i=1; AJvYcCUfJV6FUICQrhwFm+WplPDXnByoVVb4Z70vbHJw/bzS2gjpebkl8zKKEyRXYAIu46DobhTHchOh7s23o8sf@vger.kernel.org, AJvYcCX6sQG0Lv0JtLTKwGfAvolCn+4ULqrU2mYhgRFDOm8WAmNmQ7pOaRYTjuOcDxaC/DbSjXwyP7R4j6SD@vger.kernel.org
X-Gm-Message-State: AOJu0YzgAyPdoJJDh1tQPszODS5i92usq1onjVSCd/28vjeCDjmlR7Jo
	ra4ABiWY+1CLKDyuO3sVLtXppylYmeY/mAxHlVnxJi5uY4wluGfZ
X-Google-Smtp-Source: AGHT+IGHSXYIt7zYTJi5YPOTp8mHB8F80Y8Z2Q2SeynbWepdjfTvIM3szHaTplQkTC5IisNHG/HBJg==
X-Received: by 2002:a05:6a20:728c:b0:1cf:37d4:c50b with SMTP id adf61e73a8af0-1d8bcf14532mr10497697637.4.1728956039884;
        Mon, 14 Oct 2024 18:33:59 -0700 (PDT)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774a4243sm189713b3a.131.2024.10.14.18.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 18:33:59 -0700 (PDT)
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
Subject: [PATCH 1/2] dt-bindings: phy: rockchip: add rk3576 compatible
Date: Tue, 15 Oct 2024 09:33:50 +0800
Message-Id: <20241015013351.4884-1-frawang.cn@gmail.com>
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
---
 .../devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
index d3cd7997879f..1b3de6678c08 100644
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
2.34.1


