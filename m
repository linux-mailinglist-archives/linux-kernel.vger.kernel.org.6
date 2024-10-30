Return-Path: <linux-kernel+bounces-389030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5F89B67BE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66ED31C20947
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED38D2141C9;
	Wed, 30 Oct 2024 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="YzMI9HzI"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CA11EF095;
	Wed, 30 Oct 2024 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301859; cv=none; b=nzGBLEEFIVrtrHWIPM7/+c3RvM4pbmncYnv40lZWZ/pGDdPhCcQrGM8CdVDgV6OXCxHId0kjD6pnRV4BqmPH9Hpi0na2J4aWH9s4bDONji/3yOVOnWl3g9G8i10fX7XOl6TYh3EuqfD7Rj+9u95oB4lUIYt53h9LnbKDwoonz7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301859; c=relaxed/simple;
	bh=CbEpmW7FPn+sPKG8c4xScnPU3gtguAymAaAB367/Few=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=BTqpvp4N/W/VE9DlYV5Ve/n2gy34u+OuYavVEvWkM0p+q1YxnoZjPZAIA4QRoujr+AnTBiMeXK26y+SL//fMGmzxE80jm3psZm7qRjuIu4H1DMxpA0iSxYomLYbfg92ynCnyhgy7CmfxMQ8059/HEENKx8ddkiGbzM8WaSabqcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=YzMI9HzI; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49UAeFcB003959;
	Wed, 30 Oct 2024 15:50:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=QSpvzlUoPaWMaJEafvzzJu
	/6rUnf9nrlpcngc0lyE9U=; b=YzMI9HzIv7fVXIAAFowSIERlQHXvoQ7HZTwwWl
	Gv46rC4Qz5UsmSqIeLVYOGisdfN4VRTsTjgRRfvi7z+KOdvsiEgasD1TAALflZ1D
	SjbudpkqrkvxZC8xcVGAQmKPmkEPsGVygXKnvcjoh00BKyWf8IOt2Bn3iV7QZ2MZ
	idXbUOvvvD29UmN6UsueJTwwCAONV/gjuitN0bPTGSezQx3vRu6Mx/8y0NopUUfD
	LMzjKNLk3qa4podbuUPQLqx5r5/LxzY0l8fpNSVgIQ9++FK1JGRqrCDmVNcJysWg
	AHEpCgMpvtwVKFMudYF3qlbvA9NuQ+D/+YJYPi+MG4zIgLXQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42gqacvqt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 15:50:01 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 309AB4005F;
	Wed, 30 Oct 2024 15:48:43 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E2DDD277227;
	Wed, 30 Oct 2024 15:45:30 +0100 (CET)
Received: from localhost (10.48.87.175) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 30 Oct
 2024 15:45:30 +0100
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Wed, 30 Oct 2024 15:45:30 +0100
Subject: [PATCH v2] dt-bindings: access-controllers: add controller
 configuration property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241030-firewall-conf-v2-v2-1-b531fd2957bb@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAIlGImcC/x3MQQqAIBBA0avErBuwyZC6SrQoG2sgLBQqEO+et
 HyL/xNEDsIRhipB4FuinL6A6grsPvuNUdZiIEW6UdShk8DPfBxoT+/wJrRGGb20qukXByW7Ajt
 5/+U45fwB+zXz+WIAAAA=
X-Change-ID: 20241025-firewall-conf-v2-c7074b3019bf
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Oleksii Moisieiev
	<oleksii_moisieiev@epam.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alvinga@andestech.com>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3659;
 i=gatien.chevallier@foss.st.com; h=from:subject:message-id;
 bh=CbEpmW7FPn+sPKG8c4xScnPU3gtguAymAaAB367/Few=;
 b=owEB7QES/pANAwAKAar3Rq6G8cMoAcsmYgBnIkaJI015nG3ge0UdJzasRkZr+Qiv2E/mehfxH
 QD2tKzIPTeJAbMEAAEKAB0WIQRuDsu+jpEBc9gaoV2q90auhvHDKAUCZyJGiQAKCRCq90auhvHD
 KKvTC/92B9NH44FuhrP6I5qQco0QMia8TYcoRvtzQ5Z25LIiGQ9xgLECNJLqXhUwJ8SQ4EqShP6
 E20hCAXpIVvXT3hEyDiPXQ3w1GgP1xHJXZjmEx9SfYN9OajzwbgdzhoV9J7tcGYTE7xXQAc+WD1
 6Hf9boae8Bvga1bU/IRijcVFB72atj+8yQQq42AE91aXVbX1eNAg8wpy8cvcRW+uAfuMDCPnyjS
 ODvb7BS2PHzhBpuH7ZZ5STorXiYKUM09xNxvNGb/T4xuHpx3AEz3jL6O+AIaVmOldhlmNGlWVOU
 SJf2sXvgQC6Ezt8GJbM/5MDCrMrVxEtywZRUU1rVnS8cXufUkBvY75BprmrKrfUuRpb0HWcsT92
 ra1ZS1NJ13iHxnKwsUPD5ssqCb4gKlFYWyu8gq0fGJJeAq1YaO/jKra3PYRrM24guYPUz3NRque
 IMzcYIMy+LPrCbiyRpTWkSdOTq5ZVLePRfN6kiuZFg2Ungflq2q283oTrft6UnBOexDYA=
X-Developer-Key: i=gatien.chevallier@foss.st.com; a=openpgp;
 fpr=6E0ECBBE8E910173D81AA15DAAF746AE86F1C328
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Add a pattern property to allow a device to request an alternate
access rights configuration to one or more firewall controllers.
It allows run-time controller reconfiguration of access rights
to an authorized entity as use in OP-TEE OS [1].

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
Link: https://github.com/OP-TEE/optee_os/pull/6946 [1]
---
Changes in V2:
	- Addition of #access-conf-cells property
---
 .../access-controllers/access-controllers.yaml     | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/access-controllers/access-controllers.yaml b/Documentation/devicetree/bindings/access-controllers/access-controllers.yaml
index 99e2865f0e46a0600ebbba3bc5771dc63d578c8b..304eecc79db8ae98a0330b3ec186e29832fb8c87 100644
--- a/Documentation/devicetree/bindings/access-controllers/access-controllers.yaml
+++ b/Documentation/devicetree/bindings/access-controllers/access-controllers.yaml
@@ -45,6 +45,12 @@ properties:
       Can be any value as specified by device tree binding documentation
       of a particular provider. The node is an access controller.
 
+  "#access-conf-cells":
+    description:
+      Number of cells in an *(?<=)-access-conf$ specifier;
+      Can be any value as specified by device tree binding documentation
+      of a particular provider. The node is an access controller.
+
   access-controller-names:
     $ref: /schemas/types.yaml#/definitions/string-array
     description:
@@ -58,6 +64,16 @@ properties:
       A list of access controller specifiers, as defined by the
       bindings of the access-controllers provider.
 
+patternProperties:
+  ".*(?<=)-access-conf$":
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      An access controller configuration contains a list of inseparable entries.
+      A configuration may reference multiple access controllers. Therefore, each
+      entry content may vary accordingly to the access controller
+      "#access-conf-cells" value. A consumer will use this property to be able
+      to dynamically query for an access rights update.
+
 additionalProperties: true
 
 examples:
@@ -65,6 +81,7 @@ examples:
     clock_controller: access-controllers@50000 {
         reg = <0x50000 0x400>;
         #access-controller-cells = <2>;
+        #access-conf-cells = <2>;
     };
 
     bus_controller: bus@60000 {
@@ -73,6 +90,7 @@ examples:
         #size-cells = <1>;
         ranges;
         #access-controller-cells = <3>;
+        #access-conf-cells = <2>;
 
         uart4: serial@60100 {
             reg = <0x60100 0x400>;
@@ -81,4 +99,17 @@ examples:
                                  <&bus_controller 1 3 5>;
             access-controller-names = "clock", "bus";
         };
+
+        uart5: serial@60200 {
+          reg = <0x60200 0x400>;
+          clocks = <&clk_serial2>;
+          access-controllers = <&bus_controller 0 0 0>, <&bus_controller 1 0 0>,
+                               <&clock_controller 2 3>;
+          default-access-conf = <&bus_controller 0 10>,
+                                <&bus_controller 1 10>,
+                                <&clock_controller 0 0>;
+          shared-access-conf = <&bus_controller 0 256>,
+                               <&bus_controller 1 256>,
+                               <&clock_controller 0 256>;
+        };
     };

---
base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
change-id: 20241025-firewall-conf-v2-c7074b3019bf

Best regards,
-- 
Gatien Chevallier <gatien.chevallier@foss.st.com>


