Return-Path: <linux-kernel+bounces-334605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECA397D98A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 20:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5B3FB21E5E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 18:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3074018592C;
	Fri, 20 Sep 2024 18:13:25 +0000 (UTC)
Received: from chessie.everett.org (chessie.fmt1.pfcs.com [66.220.13.234])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB14181D00;
	Fri, 20 Sep 2024 18:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.13.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726856004; cv=none; b=KhDYm7dJQMQUJ16MpztRn/SzOzdmDx1m8vHX/L8A2vvxXvg3GbfbzGDG/D4D/nt8qHSZzD+gH9biV/0rk83O6s3JpjeO1JHQDH1R0nKrXe3Qq61u+X6Bx0vrAEoXcXbf9N0tiHrmpzereONWbgusLiibJFVYQgdSVDyFBzDsGoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726856004; c=relaxed/simple;
	bh=fmS5M3ZnML9s29Jj4XLNL+uYsWzbkpFJqIRrnO9wJCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f1EVKM4V3NpUc5iYWHHqzMXqxU+YacXuWt8Au778TwXquEo9CbBcd/KuH9MdO/1z9tACo3EjymTeDC6F05axNfoH2C13TwsisnbklYr6eQTOyglDK/U0Ph5QLTwQ5LEmMWxz9xOYBSte7AErx3gZwFChD8aBpa95jCy29T4/rA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org; spf=pass smtp.mailfrom=nwtime.org; arc=none smtp.client-ip=66.220.13.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwtime.org
Received: from localhost.localdomain (ip-77-25-16-238.web.vodafone.de [77.25.16.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by chessie.everett.org (Postfix) with ESMTPSA id 4X9L932C89zMR7p;
	Fri, 20 Sep 2024 18:13:11 +0000 (UTC)
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
Subject: [PATCH v5 3/5] dt-bindings: mtd: spi-nor: add OTP parameters
Date: Fri, 20 Sep 2024 20:12:29 +0200
Message-Id: <20240920181231.20542-4-erezgeva@nwtime.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240920181231.20542-1-erezgeva@nwtime.org>
References: <20240920181231.20542-1-erezgeva@nwtime.org>
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
 .../bindings/mtd/jedec,spi-nor.yaml           | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index 6e3afb42926e..4f7bb3f41cb1 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -90,6 +90,43 @@ properties:
       the SRWD bit while writing the status register. WP# signal hard strapped to GND
       can be a valid use case.
 
+  otp-n-regions:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Some flash devices need OTP parameters in the device tree.
+      As we can not deduce the parameters based on JEDEC ID or SFDP.
+      This parameter indicates the number of OTP regions.
+      The value must be larger or equal to 1 and mandatory for OTP.
+
+  otp-len:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Some flash devices need OTP parameters in the device tree.
+      As we can not deduce the parameters based on JEDEC ID or SFDP.
+      This parameter indicates the size (length) in bytes of an OTP region.
+      Currently the driver supports symmetric OTP,
+       which means all regions must use the same size.
+      The value must be positive and mandatory for OTP.
+
+  otp-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Some flash devices need OTP parameters in the device tree.
+      As we can not deduce the parameters based on JEDEC ID or SFDP.
+      This parameter indicates the offset in bytes of
+       an OTP region relative to its previous.
+      User can omit it if the offset equals the length.
+      Or in case we have a single OTP region.
+
+  otp-base:
+    $ref: /schemas/types.yaml#/definitions/uint32
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
@@ -118,6 +155,8 @@ examples:
             spi-max-frequency = <40000000>;
             m25p,fast-read;
             reset-gpios = <&gpio 12 GPIO_ACTIVE_LOW>;
+            otp-len = <512>;
+            otp-n-regions = <1>;
         };
     };
 ...
-- 
2.39.5


