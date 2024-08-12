Return-Path: <linux-kernel+bounces-283228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15E694EEE0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B25028212A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70980186295;
	Mon, 12 Aug 2024 13:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zo8s/NLg"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D1417F397;
	Mon, 12 Aug 2024 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470778; cv=none; b=PMM5V9idwnAXi/KQeoVygbwutcbshutYMNvMXgT//kRQGQnJJ8cDaJbu1HMtAmH0FOpFAfhfSsh3q8//0RILWnPErKqV0wDkiATFfMNeSfucjigSpYXBlK/0I+GjDRZJcORdvsPWrYn0EPAhgr259nWmp7Wj3QBqhKAPAcS5W0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470778; c=relaxed/simple;
	bh=jp+geUDZCqTPYYoFzm0i6Cp+RUKDlSua67ltTtH+eKQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7BvoxW9fwc4zmND1WTznKorfEk+MVqGmQUqk5VG1f1UIhIHcBreQy4GnqaOwnhccV9OwxJ6iSOd2MqJcb0Zi8mJP/uJ2t7UvQmFuNXg44TsCd7LEAXP8LpFcLpz0S93X2Mt/BOU65HFIGVL4LbcoH4pcTXsnHnBET2lg19nvho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zo8s/NLg; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723470777; x=1755006777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jp+geUDZCqTPYYoFzm0i6Cp+RUKDlSua67ltTtH+eKQ=;
  b=zo8s/NLgW1Xi4YSWmsJUANaKh89kHiNsbHOm1Fj3prUKqSB2lDNgljeC
   XvgEPDzrq18rhtL6jTkhwKq+CpELDUrOSP7CiFMNSN/rUyFMcVsKH7uES
   /Gj7265Z1iS4Rgp1FyyjAKAf/F61R2glHkUifv1lYU1Ec10woY/HE4V53
   poA1NvLShONo7fG5cpZc0iLtwVpyLImJDcJkwnW/8OI5x4le/891mYpBK
   olSLY/YP5Ifc1oo2kOM3l5I+amCGSm9SEMmzQDbeKT/C9Li+fKVvbnf35
   tqypRKxddzPjC2qNsHyC8DPGa9CcpgSEYfmFLLmlN31Ba/jx5CbP6cqQy
   Q==;
X-CSE-ConnectionGUID: s4TBmy++Rr+nQ8F2ugpKvw==
X-CSE-MsgGUID: Q+ToFOHzSC6AcBeLd4lv7A==
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="261298074"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2024 06:52:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Aug 2024 06:52:43 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 12 Aug 2024 06:52:41 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
	<nicolas.ferre@microchip.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<robh@kernel.org>, <alexandre.belloni@bootlin.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH v2 2/7] regulator: dt-bindings: microchip,mcp16502: Add voltage input supply documentation
Date: Mon, 12 Aug 2024 16:52:26 +0300
Message-ID: <20240812135231.43744-3-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812135231.43744-1-andrei.simion@microchip.com>
References: <20240812135231.43744-1-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Update the yaml schema with info about input supply phandle for
each buck and ldo according with the PMIC MCP16502 Datasheet.

Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
v1 -> v2:
- added in v2
---
 .../regulator/microchip,mcp16502.yaml         | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/microchip,mcp16502.yaml b/Documentation/devicetree/bindings/regulator/microchip,mcp16502.yaml
index 1aca3646789e..c3e1fc6e260e 100644
--- a/Documentation/devicetree/bindings/regulator/microchip,mcp16502.yaml
+++ b/Documentation/devicetree/bindings/regulator/microchip,mcp16502.yaml
@@ -28,6 +28,21 @@ properties:
   reg:
     maxItems: 1
 
+  lvin-supply:
+    description: Input supply phandle for LDO1 and LDO2
+
+  pvin1-supply:
+    description: Input supply phandle for VDD_IO (BUCK1)
+
+  pvin2-supply:
+    description: Input supply phandle for VDD_DDR (BUCK2)
+
+  pvin3-supply:
+    description: Input supply phandle for VDD_CORE (BUCK3)
+
+  pvin4-supply:
+    description: Input supply phandle for VDD_OTHER (BUCK4)
+
   regulators:
     type: object
     additionalProperties: false
@@ -68,6 +83,11 @@ examples:
         pmic@5b {
             compatible = "microchip,mcp16502";
             reg = <0x5b>;
+            lvin-supply = <&reg_5v>;
+            pvin1-supply = <&reg_5v>;
+            pvin2-supply = <&reg_5v>;
+            pvin3-supply = <&reg_5v>;
+            pvin4-supply = <&reg_5v>;
 
             regulators {
                 VDD_IO {
-- 
2.34.1


