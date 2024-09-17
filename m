Return-Path: <linux-kernel+bounces-331555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B39A97AE3C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E0AD1C23683
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6E0165F0E;
	Tue, 17 Sep 2024 09:50:49 +0000 (UTC)
Received: from chessie.everett.org (chessie.fmt1.pfcs.com [66.220.13.234])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F382415F41B;
	Tue, 17 Sep 2024 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.13.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726566649; cv=none; b=Q0w6Tk0Xa3qZVdu6tcodmNWa+NCsqS6eKKiY+0US12c4n6s/z+aELQWrWwsTzUbQ1Ul1TUqsWySdRcOBucjo1PPMYBedynphuT6Txgu3tLso0zPBeZyUAvPkvgXjWcFxcQOMmzR4igsKNVYBQGBDT0BlxrC1ux3vqtqK5inHbLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726566649; c=relaxed/simple;
	bh=guGl3BlrqNv+pV6KuIUaBuZzzAE6v1eurl18wx/Xh4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j76pN80+TwfNRvWoK7GpsIgR1wtwVF08h7hXZhv/bRoqq033Z3OHdhHBGk6gpSwKb5biF3aiTWRgEk2WBUou6fiPUv2SLBcZnkVBpnyFRRJWt63rU0/P1rmeREYPVxdxc+vBkJkpHhPdFX9DtidQaxDGkLGEmpVNjeOYyKgRvtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org; spf=pass smtp.mailfrom=nwtime.org; arc=none smtp.client-ip=66.220.13.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwtime.org
Received: from localhost.localdomain (unknown [31.16.248.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by chessie.everett.org (Postfix) with ESMTPSA id 4X7H8Z2M2lzMR5s;
	Tue, 17 Sep 2024 09:50:38 +0000 (UTC)
From: Erez Geva <erezgeva@nwtime.org>
To: linux-mtd@lists.infradead.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Esben Haabendal <esben@geanix.com>,
	Erez Geva <ErezGeva2@gmail.com>
Subject: [PATCH v4 3/5] dt-bindings: mtd: spi-nor: add OTP parameters
Date: Tue, 17 Sep 2024 11:49:54 +0200
Message-Id: <20240917094956.437078-4-erezgeva@nwtime.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240917094956.437078-1-erezgeva@nwtime.org>
References: <20240917094956.437078-1-erezgeva@nwtime.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Erez Geva <ErezGeva2@gmail.com>

Some flash devices need OTP parameters in device tree.
As we can not deduce the parameters based on JEDEC ID or SFDP.

Signed-off-by: Erez Geva <ErezGeva2@gmail.com>
---
 .../bindings/mtd/jedec,spi-nor.yaml           | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index 6e3afb42926e..d502b7fab2ce 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -90,6 +90,43 @@ properties:
       the SRWD bit while writing the status register. WP# signal hard strapped to GND
       can be a valid use case.
 
+  opt_n_regions:
+    type: u32
+    description:
+      Some flash devices need OTP parameters in the device tree.
+      As we can not deduce the parameters based on JEDEC ID or SFDP.
+      This parameter indicates the number of OTP regions.
+      The value must be larger than 1 and mandatory for OTP.
+
+  otp_len:
+    type: u32
+    description:
+      Some flash devices need OTP parameters in the device tree.
+      As we can not deduce the parameters based on JEDEC ID or SFDP.
+      This parameter indicates the size (length) in bytes of an OTP region.
+      Currently the driver supports symmetric OTP,
+       which means all regions must use the same size.
+      The value must be positive and mandatory for OTP.
+
+  otp_offset:
+    type: u32
+    description:
+      Some flash devices need OTP parameters in the device tree.
+      As we can not deduce the parameters based on JEDEC ID or SFDP.
+      This parameter indicates the offset in bytes of
+       an OTP region relative to its previous.
+      User can omit it if the offset equals the length.
+      Or in case we have a single OTP region.
+
+  otp_base:
+    type: u32
+    description:
+      Some flash devices need OTP parameters in the device tree.
+      As we can not deduce the parameters based on JEDEC ID or SFDP.
+      This parameter indicates the base in bytes of the first OTP region.
+      User can omit it if the base is zero.
+      I.e. the address of the first OTP region starts from 0.
+
   reset-gpios:
     description:
       A GPIO line connected to the RESET (active low) signal of the device.
-- 
2.39.5


