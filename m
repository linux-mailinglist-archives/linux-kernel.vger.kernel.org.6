Return-Path: <linux-kernel+bounces-385872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 748B89B3CCC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AACCB21E57
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357451EE010;
	Mon, 28 Oct 2024 21:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmKIDUhW"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A76A1EC01D;
	Mon, 28 Oct 2024 21:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730151229; cv=none; b=FnW3B/8SlDyM8ewn9MgbRmF28cdXChYt+7X9MLcSGY6LI1+wQZZx5I154s8l3sN62dkGk7KCeq7z8rc1IHdJtfrxo8FKZi/kfPWkaWzmUvFr2YlLss1xZWATvdnyx4eXxveIU/ABNMEEm2+Q8wTALTnn+q2kpUBscHWoKwhUmlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730151229; c=relaxed/simple;
	bh=uyl6bDyVF7nQDAug5sFX4y1SJJ2HMJQyu9QDFJvMUgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naTrFoyvBJ7w+1KEsDx1QQm/JbbWUTi7uk3Lejw/TiUA0q3BlAf13gOEzjqSnpZmuVF+uXVN8DuFplYChT+1CWkGcNv9UJuoRB4/zu7mZz77SDeEnXWihzV9vVzxY+3lnVJz2Tx1lYjPK8qNV59SyJb3vyusf6HcGG6h+N10rX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmKIDUhW; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539fbbadf83so6135661e87.0;
        Mon, 28 Oct 2024 14:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730151225; x=1730756025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohUz9CtNZvlwl/uKjQaJUL1p7+iSw3LXALabDVJ8WTI=;
        b=CmKIDUhWQOKt9opkvVh6CXYuP4wROAOcVDMRo3JhCYsTYwHU2xgiM5hVC0qm24d543
         7aAcGDp+iWuXROV1Aq3EfuhiKHkckgnvy/Hpla/+zynR7XbDyGwzzl+E6UrMW+a3XHm6
         uKurGCEtFRa4LAfuSak/q8/ZTHPf7ewfmDJdgrRwa+GCOyGRlTcSRL/dlgGDqSPUzEk0
         lafdsDFT5NpZGlia/52o2ZMyX/1r9d2dmriSsJZjIt+6BzWH1cWuByXzmnX01+kvzPEG
         NDFGt0fIFjyAFPGRrsgivZiIV12jkmk70CzpiDUEV5fST00Q64kzrff0C3bGn+JPR22X
         ux3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730151226; x=1730756026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohUz9CtNZvlwl/uKjQaJUL1p7+iSw3LXALabDVJ8WTI=;
        b=RKsxiEKPu/HkfGeLHAx1tPc81Ubmw9wo35B6S6ShNmqKwo1ylB+45M6tdMNZE/N2c2
         I45/faxal/niSdZ9pQmUGFCV+Non7ARjS6ZnfckGHyaPR/DGTqXh1xFVs1ZXIzPctj2a
         kPlO9U5uOPNp7Zkz8xv5GN8+wTPKA1NAvlP/M5w3GX+k5GCE+4PnEZLCgQZdFIXcF2bR
         +OdXyFl+wGiHGiBV4PA8i+tBNREp1a3PWW1+2z5ekFMdojZ4IRchJFTsw7buMpgkmKry
         XNaMUc+NiXRPSA+zUss4QYDvQ6+825IAWYb5zH04ukqZijDe4cpI6CRZnnkhimldG9t1
         CmTg==
X-Forwarded-Encrypted: i=1; AJvYcCVZX9vl3N/zDl3Av5kFyO93L91nqy4E8nt426FJN/N7A7+yqNT+x3/WUG5KSO2BMzDSr8qpvUyjsD/s@vger.kernel.org, AJvYcCWVchA2Sbha2RiDPl8NN4NLEMpkDN7lmdV4MIGaC5f54BggJlMznquiVnuPBshQb4bMH0e+tCo354LD1WL5@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw845tODfXVZEoZPlBlttIpc54NNzWlTsdtWFogQLzBeQO38+A
	mBguy4LMDjhYis8pL82nBvYYHEzBVcuumCGg/VSfRlw44te9enn8
X-Google-Smtp-Source: AGHT+IHboX6tF/kL9fw5rWbEKTXeKT55CdmXXqd4xEFP/Q2yeXehfeAx1CdLdWoclTqVwxmFpiSWXA==
X-Received: by 2002:a05:6512:2820:b0:539:9505:7e5 with SMTP id 2adb3069b0e04-53b348e59a7mr4446540e87.36.1730151225390;
        Mon, 28 Oct 2024 14:33:45 -0700 (PDT)
Received: from localhost.localdomain ([91.90.219.38])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1c98b9sm1204625e87.224.2024.10.28.14.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 14:33:44 -0700 (PDT)
From: Dmitry Yashin <dmt.yashin@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dmitry Yashin <dmt.yashin@gmail.com>
Subject: [PATCH 2/3] dt-bindings: arm: rockchip: add Banana Pi BPI-P2 Pro board
Date: Tue, 29 Oct 2024 02:33:13 +0500
Message-ID: <20241028213314.476776-3-dmt.yashin@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028213314.476776-1-dmt.yashin@gmail.com>
References: <20241028213314.476776-1-dmt.yashin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Banana Pi BPI-P2 Pro is the SBC made by Shenzhen SINOVOIP based on
Rockchip RK3308.

Banana Pi BPI-P2 Pro features:
- Rockchip RK3308B-S
- DDR3 512 MB
- eMMC 8 GB
- 100M lan + onboard PoE
- 40 pin and 12 pin headers
- AP6256 BT + WIFI
- TF card slot
- 2x USB 2.0 (Type-C OTG and Type-A)
- Headphone jack

Add devicetree binding for Banana Pi BPI-P2 Pro.

Signed-off-by: Dmitry Yashin <dmt.yashin@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 1e3eceb266b7..0c85c15d5c04 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -1104,6 +1104,11 @@ properties:
           - const: rockchip,rk3568-evb1-v10
           - const: rockchip,rk3568
 
+      - description: Sinovoip RK3308 Banana Pi BPI-P2 Pro
+        items:
+          - const: sinovoip,rk3308-bpi-p2pro
+          - const: rockchip,rk3308
+
       - description: Sinovoip RK3568 Banana Pi R2 Pro
         items:
           - const: sinovoip,rk3568-bpi-r2pro
-- 
2.39.5


