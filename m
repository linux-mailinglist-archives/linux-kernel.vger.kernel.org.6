Return-Path: <linux-kernel+bounces-254072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E265932E37
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA080282417
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C9519E7E2;
	Tue, 16 Jul 2024 16:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="HQKLbyXE"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1F047A5D;
	Tue, 16 Jul 2024 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721146553; cv=none; b=ilLTtH45D/Gm4I+nVCL64pnbaBL70Kd+F4QVwsaNEu4qpAxJCIXPuRA5fXhlUbl8eGFypiHfM00FMLwKp263I0l1O4BgdgVEn0WR2wb/HXCf5Cm7bFzKJJdeyWMh2qaik457iBNpeS17gO3gRtfHJkvdbxcvRQldHbp3Jqt00J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721146553; c=relaxed/simple;
	bh=zqcG5WvWEBctvJzdJ28yyNqS+q9rr/LSoec3f94MTcU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e3Gx5tKtSw+433ecSgOzotmAWIFsPjfPDdxcLUGmNMUd+EPtWqYiVLbcqO4sZJUp/p9yHunHd58lkEro+19KRV7riZ8U713Y7ak3BHdE24+s9D0I6BR2P4uMlbIevgVTE1t9seOriQpiWlANM3JqgBWhaRizHPhbnD7ra3iqqrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=HQKLbyXE; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46GCOBXT011873;
	Tue, 16 Jul 2024 18:15:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=EXkol/iSNuZDBvekyCRYXN
	9VZCnXUWDsY7AXfcwYUfY=; b=HQKLbyXE2tGfUMPW/z+4iIRiDuGjGRLRNcraNJ
	QAFRWvent5ZHO/rg/HApgJdCowWebfv/C8URnUvpwV7WznP95/tf1h2EZCtaCi2v
	skI+fN0kBCObLmKVY5nI1Msl4HQQCwM7GbhowoJvkZkZUnr52VIldpjOpyjdUtCv
	QeDVd6T9DBMuMczs1+/sf96kBHqDoIFvjhnO/ripx573GpUWT0eHMsm+QD8H4Eap
	DohQOM/D4Gi9wJJRMEwgmLRxNYrcI7miPTo9UHzL08vyXN4+mNYk5wdQglhf1/0p
	Xd6Fy3UKN/5A7EeOj6/NHipWv18C9S6Xnkw/yQIX1nQisMKg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40bf0gcqd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 18:15:30 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AD6254002D;
	Tue, 16 Jul 2024 18:15:25 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B17E82535CF;
	Tue, 16 Jul 2024 18:15:00 +0200 (CEST)
Received: from localhost (10.48.87.204) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 16 Jul
 2024 18:15:00 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Gatien Chevallier
	<gatien.chevallier@foss.st.com>
Subject: [PATCH] dt-bindings: access-controllers: add controller configuration property
Date: Tue, 16 Jul 2024 18:14:27 +0200
Message-ID: <20240716161427.237825-1-gatien.chevallier@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_02,2024-05-17_01

Add a pattern property that allows to define several controller
configuration in the device tree. It allows run-time controller
reconfiguration for an authorized entity as in OP-TEE OS [1].

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
Link: https://github.com/OP-TEE/optee_os/pull/6946 [1]
---
 .../access-controllers/access-controllers.yaml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/access-controllers/access-controllers.yaml b/Documentation/devicetree/bindings/access-controllers/access-controllers.yaml
index 99e2865f0e46..88824719bb73 100644
--- a/Documentation/devicetree/bindings/access-controllers/access-controllers.yaml
+++ b/Documentation/devicetree/bindings/access-controllers/access-controllers.yaml
@@ -58,6 +58,13 @@ properties:
       A list of access controller specifiers, as defined by the
       bindings of the access-controllers provider.
 
+patternProperties:
+  ".*(?<=)-access-conf$":
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Contains a list of inseparable access controller specifiers that forms
+      an access controller configuration.
+
 additionalProperties: true
 
 examples:
@@ -81,4 +88,15 @@ examples:
                                  <&bus_controller 1 3 5>;
             access-controller-names = "clock", "bus";
         };
+
+        uart5: serial@60200 {
+          reg = <0x60200 0x400>;
+          clocks = <&clk_serial2>;
+          access-controllers = <&bus_controller 0 0 0>, <&bus_controller 1 0 0>,
+                               <&clock_controller 2 3>;
+          default-access-conf = <&bus_controller 0 10 0>,
+                                <&bus_controller 1 10 0>;
+          shared-access-conf = <&bus_controller 0 256 4>,
+                               <&bus_controller 1 256 4>;
+        };
     };
-- 
2.25.1


