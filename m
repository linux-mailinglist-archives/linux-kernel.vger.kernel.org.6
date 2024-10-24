Return-Path: <linux-kernel+bounces-379643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A159B9AE177
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60B0F2851AF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4CC1B85C4;
	Thu, 24 Oct 2024 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="H4JCeKBs"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF921B394E;
	Thu, 24 Oct 2024 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729763556; cv=none; b=W26wJPNC8gsZ7AIwy8Qw8cWxepfcC4fI+hYK5qaWWLrwWf77VmMHyFL4BqtdjSUUYjWGBks+MPaT1aGk5Bcnq4UmaBIWTBNqVNbBBPan3GroBiRgRkNmEdM3tctkKN52383znRg+0hwu2VX3+OlijY1fV/zGy6HNbYEy/Ej3vrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729763556; c=relaxed/simple;
	bh=dZ3hFljZfnDqttLIzKNyi1/vY4cb6ocQjkDgd8euvIQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FcV9eEHe06J0lN1e8iy9SP7/4G99baeS/ifpU4Ve10f362hQkHMqdgGuaagQHDOl/2rwKFQ+hktJ9HFB4atX7EXH2si7K5IsAhcg80q6qqSaW7VcgCMPM+BzwxfdxK6T6okKUHg+OW7fpatVcbezPAgCl92/0JzhS/Lwl61xAmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=H4JCeKBs; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d4b0943c7so461323f8f.1;
        Thu, 24 Oct 2024 02:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1729763552; x=1730368352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zbGlZH2YPT556Yg7F/kd5yHQZFw5b8+sD6ABVMiAEf0=;
        b=H4JCeKBsdDyEoiIqs4jYPYUaYfRCC1kNzdGOJPLZLyd2ZrpZCMIY8z4lxtAW4gXHEK
         FPv0ajdfKBsw79hsPte3jbVs0jsRFvxs9hwhX012L83e3tJqqBnf6/2Evao5tlv+rehH
         bIEQcl7kPlISr+2VJIle1CefOuHWUiFp4EceOAk6/LA3kgBB0LhS7mHEBfpbu0yadH1k
         Se+iukGHWEVD32b+xjikImur2rQW4ObtIfyfVVTkcTuW6CEn29FEUetJBmo2HDzVobg4
         uRel1qRnIXorn6Ci9ZI6sXpGj1Y2CELO5Rj6k/5d3xrtmlabFZleS5poY6qbYCLY/3o6
         UBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729763552; x=1730368352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbGlZH2YPT556Yg7F/kd5yHQZFw5b8+sD6ABVMiAEf0=;
        b=wiRpbK/cSYNjL/SPg04fFhXtrwo9WlG4zF32tgGFj/6DiMNsGz6VR54FAdqqbHo4aS
         IGF9OQX1ieduH5QSE6iX6JUT9/PlihAy4N2Xb/k+Zk+h339IW3wxiGtk8cNFkyJeZhzW
         4LACjIcZQ2CRosp1FO5gxgXaDOpudJMzX2Th35mmtoXcq3gvT6k2DgIj36VMaF26i3Ff
         dTewLiEkkA+m7ApiWOSNdIHGmcJA9DVaVBO5w6cUw6d13yLcPZHL5SSqDUnoS0lWjIWu
         p9o45QHjddWsROW9LNNVy8Mo+vG7l0SutYInz7mkCc0wdtt4ORMvQc2VYG0422/KeVLE
         SFww==
X-Forwarded-Encrypted: i=1; AJvYcCWNq15w2HY2VTnwV9ydEfMP9q6E2qZYvBQEiOX5y/dS1c2cjperGhATWAgF+sVj5HotNR+FqHvxnrZ7wtbN@vger.kernel.org, AJvYcCXopM6e9PJTmbLbTuPi5a8p2xFaZpC5loZltAD95bQtyXN/9vOsjrZ1c7PN23ge58h5tTyZFkG+gcZK@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8XKU2pzjDYX17bp6M6rYH3a+s9O/7nHTnQqTe8/S0ixVewGVo
	44EXeS1YKFqUkXrCykI95olPKi7xYSix+KFsNT/VggLKO3EYwilt
X-Google-Smtp-Source: AGHT+IH6+FDqRxvf+ZtXVfydc1RVsL1eaYqfFGtXJ+QNYha+sQ1JmohsKezDc9XL54BBl2gx5N8lAw==
X-Received: by 2002:adf:fdd1:0:b0:37d:8084:160b with SMTP id ffacd0b85a97d-3804587eed6mr1086117f8f.23.1729763552405;
        Thu, 24 Oct 2024 02:52:32 -0700 (PDT)
Received: from localhost.localdomain ([2a02:908:1587:1e60:e265:6c8b:f62b:1474])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37ac4sm10996286f8f.6.2024.10.24.02.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:52:32 -0700 (PDT)
From: Cenk Uluisik <cenk.uluisik@googlemail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Jimmy Hon <honyuenkwun@gmail.com>,
	Cenk Uluisik <cenk.uluisik@googlemail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/3] dt-bindings: arm: rockchip: Add Orange Pi 5b enum to Orange Pi 5 entry
Date: Thu, 24 Oct 2024 09:50:21 +0000
Message-ID: <20241024095038.42079-2-cenk.uluisik@googlemail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241024095038.42079-1-cenk.uluisik@googlemail.com>
References: <20241024095038.42079-1-cenk.uluisik@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This extends the Xunlong Orange Pi 5 device tree binding
with an enum for the Orange Pi 5b, which is implemented
before the device tree.

How does this board differ from the original Orange Pi 5?
  - the Orange Pi 5 has a M.2 NVMe M-key PCI 2.0x1
    slot (hooked to combphy0_ps) whereas the Orange Pi 5b uses combphy0_ps
    for the WiFi.
  - The Orange Pi 5 with the M.2 socket has a regulator defined hooked to
    "GPIO0_C5" (i.e. PCIE_PWREN_H) whereas the Orange Pi 5B has GPIO0_C5
    hooked to BT_WAKE_HOST.
  - builtin eMMC storage
  - no SPI NOR flash (u-boot, preboot etc. initiates
      from within the eMMC
      storage)
  - ap6275p Wifi module (like the Orange Pi 5 Plus)
  - builtin BlueTooth module

Signed-off-by: Cenk Uluisik <cenk.uluisik@googlemail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes in v7:
- No changes to this patch (same as v6)

 Documentation/devicetree/bindings/arm/rockchip.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index b7c4de06b..2f9fcc634 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -1079,7 +1079,9 @@ properties:
 
       - description: Xunlong Orange Pi 5
         items:
-          - const: xunlong,orangepi-5
+          - enum:
+              - xunlong,orangepi-5
+              - xunlong,orangepi-5b
           - const: rockchip,rk3588s
 
       - description: Zkmagic A95X Z2
-- 
2.46.1


