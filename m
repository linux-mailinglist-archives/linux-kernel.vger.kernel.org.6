Return-Path: <linux-kernel+bounces-283265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A4294EF53
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9C70B21DDE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D1817F397;
	Mon, 12 Aug 2024 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="iKxleSi0"
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C4F17D8A9
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723472167; cv=none; b=qg0CQgY91U6D3pzvnpmGoTHb+C2Ch5Bo3a9ludSeSQcI22WkNpNf6jrGjS93s5Y7ti2kXfedjXntoQfkaVdQg52qsgu/M4+T+H76gLY+bAA5UESOkgD5QjWjMfJspud+wHU/e8V1jdavs0HRM9FWsrQzVFnVNsewmlLXY/MEOLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723472167; c=relaxed/simple;
	bh=5uvJIRHlkjf8Lvt2StLoKbbn1d3sQy3a5sWCCj4yqMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJgruW+ddbfWE6oPbK/brdP+Dqy9sOHGXlXAiuuVCruaFTsgIgUFxp07T8ani1G5mxYUjtnS8xtvJQmbtqRYlfM6Qi9uElemG4Z3LKyPt5EAwGieBs7iU2YkcXA8dEsDuTaUG/jMb9DbDX9ba6YL1yZcyYqdPJDbAdD5VJpHY6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=iKxleSi0; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202408121415541c47541ac6c8c0343c
        for <linux-kernel@vger.kernel.org>;
        Mon, 12 Aug 2024 16:15:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=6t4OCL7r2k0BcCZXsgV29+zy3Q4zYlCFqtAXU2nhKaE=;
 b=iKxleSi0LO3bbWjQAZ2jrQNCCbTzL1GxB/6aZDzCNmvFnPZUMZfCp/FNZp6yFtV/isdeoT
 2mOOdNZkqJNJzC1sGa9FjQ2XsBEbQdxGZA17kn7Bv17TIrfIWS11mtzh0037r57+5AMRxP3G
 bYIHFdXQqNlku54q4IUN+kEKPTZCp2Khg/AvcAlN1GKBnr43RH57r8cNHPcrQ3CkSHDp1HQn
 8dJBWUKI29hlc/lYXHqZ8fEyyf1Jc5SPBkfWz4NjnqeaAN4G2efTn3UMA+9kLpiTCg/u1usA
 2gNao8g5mCYvuXKrjPn9MwKaT6KpVx+AuxiiH4C5YUuOfOLejeANWqKw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Minda Chen <minda.chen@starfivetech.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: phy: jh7110-usb-phy: Add sys-syscon property
Date: Mon, 12 Aug 2024 16:15:51 +0200
Message-ID: <30f3ca9f6bd788e16767b36aa22c0e9dc4d1c6a4.1723472153.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1723472153.git.jan.kiszka@siemens.com>
References: <cover.1723472153.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

Analogously to the PCI PHY, access to sys_syscon is needed to connect
the USB PHY to its controller.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>
---
 .../bindings/phy/starfive,jh7110-usb-phy.yaml         | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml b/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
index 269e9f9f12b6..eaf0050c6f17 100644
--- a/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
@@ -19,6 +19,16 @@ properties:
   "#phy-cells":
     const: 0
 
+  starfive,sys-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to System Register Controller sys_syscon node.
+          - description: PHY connect offset of SYS_SYSCONSAIF__SYSCFG register for USB PHY.
+    description:
+      The phandle to System Register Controller syscon node and the PHY connect offset
+      of SYS_SYSCONSAIF__SYSCFG register. Connect PHY to USB controller.
+
   clocks:
     items:
       - description: PHY 125m
@@ -47,4 +57,5 @@ examples:
                  <&stgcrg 6>;
         clock-names = "125m", "app_125m";
         #phy-cells = <0>;
+        starfive,sys-syscon = <&sys_syscon 0x18>;
     };
-- 
2.43.0


