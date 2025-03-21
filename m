Return-Path: <linux-kernel+bounces-571606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68561A6BF8F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE526172AE5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A4C22B8C4;
	Fri, 21 Mar 2025 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b="RIEU0z+p"
Received: from p00-icloudmta-asmtp-us-central-1k-100-percent-8.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-central-1k.k8s.cloud.apple.com (p-east1-cluster2-host3-snip4-1.eps.apple.com [57.103.88.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D101D6195
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.88.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573850; cv=none; b=HNw/aDTV5da6CJb1rKFvugNe26BMBymMiodop3U80IDK8vg+lhl3sq1l8Cw2lkB4bYd1FBZb81NfmvIsq24vdOcPtLwM/MIof5Pg396jXvfBEpUkgVEsb8dlpuNzSY2+w9EruPvkghpMljlIsg6yhIv14LQOf6AeDpAxg15i7sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573850; c=relaxed/simple;
	bh=OeIjux2L+VD6vXxq8q41IkwVOrxAsgrjCtTRW+6pDr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MeJeKUwHQwgL9Ex/PIcfGR+zBJ0aSYyCqNK8Y0S2giM3fKgOfgUVAdjxwmSfMSzL09qPDVPqZab0Jx0iKAARcWBi/Hu4JSFdEw/V3hGcldzpK2647xgLSEvmK8Uz5X88kvvoGDS0O4kvRP9WOJtWriCp706aFrX2IGaIgnPPwCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es; spf=pass smtp.mailfrom=pereznus.es; dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b=RIEU0z+p; arc=none smtp.client-ip=57.103.88.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pereznus.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pereznus.es; s=sig1;
	bh=YVvZ4UL0bFTiJFwO9+ZDas4+KDymXBDJvT0ZeYG903g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=RIEU0z+pvlB1ltSuS8t3rOQ6U13ryJA9kAqfq8LoV3H1i0Bm4BEngIec1m2AkJLAQ
	 v4KeIagjFybg48sxu1/dNpDGypCCtN0NiTxL8aKyNbbu6kf1cOaOV3IQtZKHGpgQf5
	 lh8BFvIiYUgGL7luc6Ou7i+i2TbmgyMerFZ7A4TopqBciRRKL/UwWC2x3c+W+Gezot
	 CpvNs7UC3urWXE1S3kb0nwuTMsoYHmtEl4kD/HDbdiOt7ql0/kJgs1o7hTOKzYnb4G
	 C1ZiTtWy3wWV4BWNxxv6qrrmzCTgQeAqayXN5cMWT5Aha5CQte0gQUBBJRB7NcPm5e
	 88ksjTGgWHdPQ==
Received: from localhost.localdomain (ci-asmtp-me-k8s.p00.prod.me.com [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-8.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-central-1k.k8s.cloud.apple.com (Postfix) with ESMTPSA id 131D618004B3;
	Fri, 21 Mar 2025 16:17:22 +0000 (UTC)
From: Sergio Perez <sergio@pereznus.es>
To: Tomasz Duszynski <tduszyns@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sergio Perez <sergio@pereznus.es>
Subject: [PATCH v5 1/2] dt-bindings: iio: light: bh1750: Add reset-gpios property
Date: Fri, 21 Mar 2025 17:16:08 +0100
Message-ID: <20250321161609.3662-1-sergio@pereznus.es>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5VrYs6qDqU4-cOfEbqjs0JNSdM9txB9Q
X-Proofpoint-ORIG-GUID: 5VrYs6qDqU4-cOfEbqjs0JNSdM9txB9Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2503210119

Some BH1750 sensors require a hardware reset via GPIO before they can
be properly detected on the I2C bus. Add a new reset-gpios property
to the binding to support this functionality.

The reset-gpios property allows specifying a GPIO that will be toggled
during driver initialization to reset the sensor.

Signed-off-by: Sergio Perez <sergio@pereznus.es>
---
Revision history:
v4 => v5:
 - Update description to reflect "active low" on reset signal as indicated by Krzysztof Kozlowski
 - Update description to clarify what pin of sensor is used to do reset (DVI) as mentioned by Krzysztof Kozlowski
 - Edit example to be coherent with "active low" as informed by Krzysztof Kozlowski
 - Added necessary include on example
v3 => v4:
 - No changes
v2 => v3:
 - Split in two patches: dtbinding and code
 - Ensure list off mantainers following instructions by Krzysztof Kozlowski
 - Delete redundant details on description as suggested by Jonathan Cameron
 - Added related example to existing one as suggested by Jonathan Cameron
v1 => v2:
 - Ensure check tests as commented by Rob Herring
 - Fixes some whitespaces and end lines
---
 Documentation/devicetree/bindings/iio/light/bh1750.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/bh1750.yaml b/Documentation/devicetree/bindings/iio/light/bh1750.yaml
index 1a88b3c253d5..e388610d3741 100644
--- a/Documentation/devicetree/bindings/iio/light/bh1750.yaml
+++ b/Documentation/devicetree/bindings/iio/light/bh1750.yaml
@@ -24,6 +24,10 @@ properties:
   reg:
     maxItems: 1
 
+  reset-gpios:
+    description: GPIO connected to the DVI reset pin (active low)
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -36,9 +40,12 @@ examples:
       #address-cells = <1>;
       #size-cells = <0>;
 
+      #include <dt-bindings/gpio/gpio.h>
+
       light-sensor@23 {
         compatible = "rohm,bh1750";
         reg = <0x23>;
+        reset-gpios = <&gpio2 17 GPIO_ACTIVE_LOW>;
       };
     };
 
-- 
2.43.0


