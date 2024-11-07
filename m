Return-Path: <linux-kernel+bounces-399683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DA89C02C8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBB22B212B4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF8B1E25F5;
	Thu,  7 Nov 2024 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FfWFHGxu"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F47126C01;
	Thu,  7 Nov 2024 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730976386; cv=none; b=iyLPVTdjfUT5PhPhZQODUiv68hcHBSRF+0ONJj+diI0BVE+fyoFZ3RJv7nStjbm0rxrcdElY0PnBtOHZLR70Go9OwbPZKFlQ5IlIexHCriIV44kVTp9xn6ANgf3Dmnax7yz830LP0Pr8Aaq+RE+Am44PgSMttXBnRz2O/7YRb6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730976386; c=relaxed/simple;
	bh=+6pDTLKZthsabEIPthHgfu4l9mdML6ORkKJJ0x+bdpo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hfazl/CerB7XyqJguKc1p/yApWKxWo41AuOfeWGFYjRpQKMK8sOaDkBrMeKCC6xrInANagpACAd0S35AYYIwaMHnNXZFFkUNFjn+baC7DqNL+gvlvhekSMBaifzBhc53rCdPXgOmOWwFMKCFpCcvBE3O46GnDYrN2h3mia/Puz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FfWFHGxu; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A7Ak3Xg015686;
	Thu, 7 Nov 2024 04:46:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730976363;
	bh=vO0MESgsgLkTpVmNqLDGha22m3x3mvwC2DB8NHaOqzc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=FfWFHGxu3GqMgK8jMJPbHlQbE/92Vq4Z9xyIsV/1r4BpEPl74O0M4AgyyfI4HhDn/
	 nK4PHPDyqS51FHahQziaw01oULyAImUzrakax64UAYnJnz0KVXdjcqb4+p683TJp37
	 dj2AE4JXvodkbPRPF77Hf+N844Flu3ewtEUWBTs0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A7Ak3ih003572
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 7 Nov 2024 04:46:03 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Nov 2024 04:46:03 -0600
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Nov 2024 04:46:03 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A7Ak3sK123466;
	Thu, 7 Nov 2024 04:46:03 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4A7Ak2P4019858;
	Thu, 7 Nov 2024 04:46:02 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
        <ssantosh@kernel.org>, <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-anna@ti.com>, <kristo@kernel.org>,
        <srk@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH 1/2] dt-bindings: soc: ti: pruss: Add clocks for ICSSG
Date: Thu, 7 Nov 2024 16:15:56 +0530
Message-ID: <20241107104557.1442800-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107104557.1442800-1-danishanwar@ti.com>
References: <20241107104557.1442800-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add clocks, assigned-clocks and assigned-clock-parents for ICSSG

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 .../devicetree/bindings/soc/ti/ti,pruss.yaml          | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
index 3cb1471cc6b6..cf4c5884d8be 100644
--- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
@@ -92,6 +92,17 @@ properties:
     description: |
       This property is as per sci-pm-domain.txt.
 
+  clocks:
+    items:
+      - description: ICSSG_CORE Clock
+      - description: ICSSG_ICLK Clock
+
+  assigned-clocks:
+    maxItems: 1
+
+  assigned-clock-parents:
+    maxItems: 1
+
 patternProperties:
 
   memories@[a-f0-9]+$:
-- 
2.34.1


