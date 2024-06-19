Return-Path: <linux-kernel+bounces-220934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A4390E959
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29F691C233DD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D960213D880;
	Wed, 19 Jun 2024 11:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="EqkygcD9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="YoBm1bkm"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63A413B290;
	Wed, 19 Jun 2024 11:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718796275; cv=none; b=CF4jHzEvGfd6cJYglx7SALkaz673bMcmkrCqoVHVfO5A8Qve5cbzJKc0oHSMc7EOaF5GO7LuH0/etmaMptvoSRpd2Jgg9d0mDv5+fgyavNxai9CMZIdXAhXQdzt85XDfg4rnva9Jy4FvkrNsMDESkbMd+Ib+98GOdYZ0l8xQJd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718796275; c=relaxed/simple;
	bh=lWyO75Xj3hzfTx0/HcDICshFRxN3psaKa4xdf5PPu2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FldbyEFZQ5XpdHaFCYD3apURDHZ5DvVaKph7GLZBeVwCXPXCGe1ilH8EM1w82T5VAbhDtbxWRlRY59KzuAXEBgKml/IJU6Ioeo6UXRK5fF9p0JmKMhNcwwU1DZDE9gSqC708YcAUz98HpMm3dNU+nXXQfq5os+Mhdx/gaUcKoyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=EqkygcD9; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=YoBm1bkm reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1718796272; x=1750332272;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xZufrVenZZNOki6ThkT5V784LHMR0r2wNvufJAnx7Y8=;
  b=EqkygcD932UwBC49kxJK8L2XABv+kUhV/nuzwZ6islO631K57qtacOjA
   NSz8pf4a5J3oXTVgQchpHHwPgAb1wlzViXejgPbqWwE9tNyintw/znkmE
   P7yk+Z5HR6GZ5Tl8ssawEZjMcUDnco2LT605G8WuL762Xic8G/CSU6oAF
   MJAvY4aF+JyNnwVhjWPS4EwaghI8b6lm4N2Z0854lbVEwiz5EdPBdPM0n
   XWG4BXFC31rtZbuw9GId5lp0xF+pf5VDVdKq8+E2YvSy5Z3VxRABL13oG
   aWvZs38E3QvXqnKuQ6EJamOt/Wz7L1cYIVCKO/1OaWXcwhtzhQBset8r8
   A==;
X-CSE-ConnectionGUID: KtG8NCUNS6OqyLTOH1tEbw==
X-CSE-MsgGUID: TnTC/eVQQlSgSps1kOY4xA==
X-IronPort-AV: E=Sophos;i="6.08,250,1712613600"; 
   d="scan'208";a="37474780"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Jun 2024 13:24:29 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 00F14165949;
	Wed, 19 Jun 2024 13:24:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1718796265;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=xZufrVenZZNOki6ThkT5V784LHMR0r2wNvufJAnx7Y8=;
	b=YoBm1bkm65S2SF3FEZHDxxzFsGx6IuEcYgJl3WLnSg1dVr4Xgfzze1KcgAtq5O5xPYZp37
	zLaYKOTD34GxPwkf1Dw67kHtdDhnzXx1eTQuTJqnGqv8NLqYrXlN64HeC1BfpM615LMki9
	OjPHwJe8bq2OGs8+wZ41qBQlFX3hJg3FhTW4AHZrLMihFjrKYibvLmyLcrehel3WWMgYxB
	TnhPg4C3ml35HPj31Klr2SatE93oIB059w1ZDQpoT9Q0dBI6ncrZENq2ZTSpeyYcOHX7EK
	reHfywshrEjGOLSMuGxVrWLs5KjxK1XPImZjFt3clW0+iWMA9DQ2r5bcJohCUA==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Suman Anna <s-anna@ti.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 1/2] dt-bindings: soc: ti: pruss: allow ethernet controller in ICSSG node
Date: Wed, 19 Jun 2024 13:24:05 +0200
Message-ID: <20240619112406.106223-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

While the current Device Trees for TI EVMs configure the PRUSS Ethernet
controller as a toplevel node with names like "icssg1-eth", allowing to
make it a subnode of the ICSSG has a number of advantages:

- It makes sense semantically - the Ethernet controller is running on
  the ICSSG/PRUSS
- Disabling or deleting the ICSSG node implicitly removes the Ethernet
  controller node when it is a child node. This can be relevant on SoCs
  like the AM64x which come in variants with and without ICSSG; e.g., on
  the TQMa64xxL the ICSSG node will be disabled on variants without as a
  bootloader fixup.
  On Linux, this avoids leaving the Ethernet controller in deferred
  state forever while waiting for the ICSSG to become available
  (resulting in a warning on newer kernels)

The node name "ethernet" is chosen as it nicely matches the regular
"ethernet@<reg>" format of many Ethernet controller nodes, and is also
what the prueth binding example (/schemas/net/ti,icssg-prueth.yaml) uses.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
index c402cb2928e89..89dfcf5ce8434 100644
--- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
@@ -92,6 +92,13 @@ properties:
     description: |
       This property is as per sci-pm-domain.txt.
 
+  ethernet:
+    description: |
+      ICSSG PRUSS Ethernet. Configuration for an Ethernet controller running
+      on the PRU-ICSS.
+    $ref: /schemas/net/ti,icssg-prueth.yaml#
+    type: object
+
 patternProperties:
 
   memories@[a-f0-9]+$:
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


