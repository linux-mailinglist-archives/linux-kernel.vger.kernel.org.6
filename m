Return-Path: <linux-kernel+bounces-234895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD30B91CC25
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 12:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34DDEB216B2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 10:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7799D558A5;
	Sat, 29 Jun 2024 10:39:52 +0000 (UTC)
Received: from chessie.everett.org (chessie.fmt1.pfcs.com [66.220.13.234])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13924DA00;
	Sat, 29 Jun 2024 10:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.13.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719657592; cv=none; b=rwLULi/TOl754/NFCiFaoMgZsSXgGj4Zixtax5PSLscBiJ7Q0fC4YaZVaUL5ZeaW8G1v1+uIcf5Sj3qk4RuEpS9DcfbRUxhpC3QV0MxaRoYH0K2z9uTiLmYs13MDyy4Ad6G+/cyETro+UldUsudOaFNqAXx5E4g+I+ryVo24Zqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719657592; c=relaxed/simple;
	bh=3L85TKkLLTgbl2Qz3WciGX78hYPgRZKrh89XtjYinJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FEhk2u1Vm2Zl87v5w7+upKHzv2oNj+NZhu7x0k51rM9u0LVhiHsaLpiufYWaJc8chummsHRFSSyOySp4/nqSpmbqyeI8ZAlRDciAklrjxQs1vokvbSKoxqRu/QUT9kc+LifcKE/CYZqTcV81DYtzmXFqgfflqSPipJ+Tq0PfC5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org; spf=pass smtp.mailfrom=nwtime.org; arc=none smtp.client-ip=66.220.13.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwtime.org
Received: from localhost.localdomain (unknown [31.16.248.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by chessie.everett.org (Postfix) with ESMTPSA id 4WB8212wC9zMQLv;
	Sat, 29 Jun 2024 10:39:37 +0000 (UTC)
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
	Erez Geva <ErezGeva2@gmail.com>
Subject: [PATCH v2 3/4] dt-bindings: mtd: macronix,mx25l12833f: add SPI-NOR chip
Date: Sat, 29 Jun 2024 12:39:12 +0200
Message-Id: <20240629103914.161530-4-erezgeva@nwtime.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240629103914.161530-1-erezgeva@nwtime.org>
References: <20240629103914.161530-1-erezgeva@nwtime.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Erez Geva <ErezGeva2@gmail.com>

Add Macronix SPI-NOR mx25l12833f.

mx25l12833f uses the same JEDEC ID as mx25l12805d.

Although mx25l12833f is a new chip that support read ID and SFDP,
 users might want to specify it in the device tree,
 to differ it from the old mx25l12805d chip.

Macronix annonce the end of life of mx25l12805d in 2010.

See:
  "https://www.macronix.com/Lists/TechDoc/Attachments/9861/PCN31_2009 PCN_MX25L6405D and MX25L12805D.pdf"

Signed-off-by: Erez Geva <ErezGeva2@gmail.com>
---
 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index 6e3afb42926e..625a618a7992 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -22,7 +22,7 @@ properties:
               n25q(32b|064|128a11|128a13|256a|512a|164k)))|\
               atmel,at25df(321a|641|081a)|\
               everspin,mr25h(10|40|128|256)|\
-              (mxicy|macronix),mx25l(4005a|1606e|6405d|8005|12805d|25635e)|\
+              (mxicy|macronix),mx25l(4005a|1606e|6405d|8005|12805d|12833f|25635e)|\
               (mxicy|macronix),mx25u(4033|4035)|\
               (spansion,)?s25fl(128s|256s1|512s|008k|064k|164k)|\
               (sst|microchip),sst25vf(016b|032b|040b)|\
-- 
2.39.2


