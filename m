Return-Path: <linux-kernel+bounces-283226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE1A94EEDB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56ED71F210C8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DF317C7C2;
	Mon, 12 Aug 2024 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uG4ez6ll"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4FB17E902;
	Mon, 12 Aug 2024 13:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470776; cv=none; b=QdyZ6I1rfkOm3ByMc3/Kuoau+hbG/6LDqtpdbQGaaHXmXxITznSqNJUjzrDL5E6YY/zf6d+wgNHD+n0Ff/Gj2q//0R7a1J0vYK8Xc1Spg0jJBvGMY5KrUZOTYIn527Sei3moBLfw8uNfRSs4U0P3h5wmx/mvkL090i4PbzKbAqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470776; c=relaxed/simple;
	bh=ykeS6VoIwd0uuNUslgahaQuM8F5Z+YJ644IDPqbNm04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UnZ5reSZa/DHmCN9BrpTR7voBAxhgoTjYMghGd4Ie0e7MBPIxCkZVhTAwkq+X50GTahH8+P0iIkZ8/KfIFOX02ESdNuwXSf7pIjzFBJUZQ48Ha5NuVoBzqjA6LZpPT/VhCYCqM7eUNZDLtILbFSxXmJuyZaiQ68XovzR78xxQuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uG4ez6ll; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723470775; x=1755006775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ykeS6VoIwd0uuNUslgahaQuM8F5Z+YJ644IDPqbNm04=;
  b=uG4ez6ll8Iysz1sha3wFDQ1fnTgPmqW6SJr+LysbZ3McSBbXKumtq/RB
   QEM+qtVdT0GsbXAp15/w6sSzJz/Hbrp/p3dRHq7SIF+J4mWxgFQDnJeAs
   w32AQtws/Tj/fr6Od6NrfdyttSvEc5QnPTvczb/t+rmoab6dFuBhrBR8S
   kSALe0fhwmeN6GKVGD36qAmrRiwrGYvfFvQ203+3jsxaMcpgI4xEQkPTC
   csi/0SH4th1Dusy28xQVIt5Y2qKodIe7iuyutTEc1Zqm42vZJaX3609t7
   lvnJElVCE6bnWLiUNkFN/4NE8h/i+NU/qHgSUOzdQBenVY8SHO1mAcEfO
   A==;
X-CSE-ConnectionGUID: s4TBmy++Rr+nQ8F2ugpKvw==
X-CSE-MsgGUID: a4vGk6CoTiGArcdctt08SA==
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="261298073"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2024 06:52:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Aug 2024 06:52:40 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 12 Aug 2024 06:52:38 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
	<nicolas.ferre@microchip.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<robh@kernel.org>, <alexandre.belloni@bootlin.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>,
	Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v2 1/7] regulator: mcp16502: Add supplier for regulators
Date: Mon, 12 Aug 2024 16:52:25 +0300
Message-ID: <20240812135231.43744-2-andrei.simion@microchip.com>
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

Based on the datasheet [1] (Block Diagram) PVIN[1-4] and LVIN
represent the input voltage supply for each BUCKs respective LDOs.
Update the driver to align with the datasheet [1].

[1]: https://ww1.microchip.com/downloads/aemDocuments/documents/APID/ProductDocuments/DataSheets/MCP16502-Data-Sheet-DS20006275.pdf

Co-developed-by: Mihai Sain <mihai.sain@microchip.com>
Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
v1 -> v2:
- no update
---
 drivers/regulator/mcp16502.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index 5de9d4fa5113..b34ae0bbba6f 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -107,9 +107,10 @@ static unsigned int mcp16502_of_map_mode(unsigned int mode)
 	return REGULATOR_MODE_INVALID;
 }
 
-#define MCP16502_REGULATOR(_name, _id, _ranges, _ops, _ramp_table)	\
+#define MCP16502_REGULATOR(_name, _id, _sn, _ranges, _ops, _ramp_table)	\
 	[_id] = {							\
 		.name			= _name,			\
+		.supply_name		= #_sn,				\
 		.regulators_node	= "regulators",			\
 		.id			= _id,				\
 		.ops			= &(_ops),			\
@@ -467,18 +468,18 @@ static const struct linear_range b234_ranges[] = {
 };
 
 static const struct regulator_desc mcp16502_desc[] = {
-	/* MCP16502_REGULATOR(_name, _id, ranges, regulator_ops, ramp_table) */
-	MCP16502_REGULATOR("VDD_IO", BUCK1, b1l12_ranges, mcp16502_buck_ops,
+	/* MCP16502_REGULATOR(_name, _id, _sn, _ranges, _ops, _ramp_table) */
+	MCP16502_REGULATOR("VDD_IO", BUCK1, pvin1, b1l12_ranges, mcp16502_buck_ops,
 			   mcp16502_ramp_b1l12),
-	MCP16502_REGULATOR("VDD_DDR", BUCK2, b234_ranges, mcp16502_buck_ops,
+	MCP16502_REGULATOR("VDD_DDR", BUCK2, pvin2, b234_ranges, mcp16502_buck_ops,
 			   mcp16502_ramp_b234),
-	MCP16502_REGULATOR("VDD_CORE", BUCK3, b234_ranges, mcp16502_buck_ops,
+	MCP16502_REGULATOR("VDD_CORE", BUCK3, pvin3, b234_ranges, mcp16502_buck_ops,
 			   mcp16502_ramp_b234),
-	MCP16502_REGULATOR("VDD_OTHER", BUCK4, b234_ranges, mcp16502_buck_ops,
+	MCP16502_REGULATOR("VDD_OTHER", BUCK4, pvin4, b234_ranges, mcp16502_buck_ops,
 			   mcp16502_ramp_b234),
-	MCP16502_REGULATOR("LDO1", LDO1, b1l12_ranges, mcp16502_ldo_ops,
+	MCP16502_REGULATOR("LDO1", LDO1, lvin, b1l12_ranges, mcp16502_ldo_ops,
 			   mcp16502_ramp_b1l12),
-	MCP16502_REGULATOR("LDO2", LDO2, b1l12_ranges, mcp16502_ldo_ops,
+	MCP16502_REGULATOR("LDO2", LDO2, lvin, b1l12_ranges, mcp16502_ldo_ops,
 			   mcp16502_ramp_b1l12)
 };
 
-- 
2.34.1


