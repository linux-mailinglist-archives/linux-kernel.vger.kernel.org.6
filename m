Return-Path: <linux-kernel+bounces-341392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 832CD987F6B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42E812814BB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EAC188CC8;
	Fri, 27 Sep 2024 07:26:40 +0000 (UTC)
Received: from out28-4.mail.aliyun.com (out28-4.mail.aliyun.com [115.124.28.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FECD170A27;
	Fri, 27 Sep 2024 07:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727422000; cv=none; b=UyhGuRCaaao5NIsX23pGy8W8dWAbptj8gI7jkyGyvTQmlG6ckPixpmmSigA5XlLh3XNL4QtUZTpL7DSzrtIVX3tbGkVen6xqntYguh/MNlO9iKBT57Q8gixdJNmCP8tco2L4BbyuCaMaJJdMgRQI5JBeqIOIpKPtmRK2n+cOgYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727422000; c=relaxed/simple;
	bh=cqLnf6PJzL54HgNypeyuYcHmMpeSIn784DzivUwFs0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lQbu6/mxAeMAHD8zL7Qzd4wIpKOkVfeB60nWYrZnfXiEm6UDyqqBmrfCfwTydOgZRCnkNehpaV38sPyqvMkxrEctU7ZVVbQ2anvQrHKvkATfcJgmvHY8YxWKxKLtCKPwibdq59WpThXNRwatplRnXeigC2Cc/tQBiTx078yr0X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com; spf=pass smtp.mailfrom=allwinnertech.com; arc=none smtp.client-ip=115.124.28.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allwinnertech.com
Received: from SunxiBot.allwinnertech.com(mailfrom:michael@allwinnertech.com fp:SMTPD_---.ZUNKLqQ_1727421960)
          by smtp.aliyun-inc.com;
          Fri, 27 Sep 2024 15:26:04 +0800
From: Michael Wu <michael@allwinnertech.com>
To: gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Thinh.Nguyen@synopsys.com,
	balbi@kernel.org
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: usb: snps,dwc3: Add 'snps,inv-sync-hdr-quirk' quirk
Date: Fri, 27 Sep 2024 15:25:57 +0800
Message-Id: <20240927072557.74194-2-michael@allwinnertech.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20240927072557.74194-1-michael@allwinnertech.com>
References: <20240927072557.74194-1-michael@allwinnertech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added the new 'snps,inv-sync-hdr-quirk' DT property to dwc3 core for Gen2
polarity detection.

The link uses data block (0011b) sync header for SYNC OS instead of control
block (1100b). Set this quirk if the third-party PHY does not correct the
sync header of the SYNC OS in the case of inverse polarity.

Signed-off-by: Michael Wu <michael@allwinnertech.com>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 1cd0ca90127d9..e5ed5cca1cf25 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -280,6 +280,12 @@ properties:
       asserts utmi_sleep_n.
     type: boolean
 
+  snps,inv-sync-hdr-quirk:
+    description:
+      Set if the third-party PHY does not correct the sync header of the
+      SYNC OS in the case of inverse polarity.
+    type: boolean
+
   snps,hird-threshold:
     description: HIRD threshold
     $ref: /schemas/types.yaml#/definitions/uint8
-- 
2.29.0


