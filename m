Return-Path: <linux-kernel+bounces-301953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E508095F7EC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5987FB221AB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5CD199E94;
	Mon, 26 Aug 2024 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xD7iYwVL"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C9C1990CF;
	Mon, 26 Aug 2024 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692944; cv=none; b=VY6u+hdLDNj4Uj717k95ESvlZ1y2zsaE4p1oA8hdLT6T61uCO8LiEQq5vSTgob9ICigBrWOO0jYMm+gCypQY8WWMp7tlsdZ+3l37mkrkaM79z1Fl2yfVgSRFv5gk3ycFvWbvG5aSzdICQbMPrkAHeGXm3zFqE8sW2bFdaJ6CS9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692944; c=relaxed/simple;
	bh=55LAEgYpKeVmBYii6puZg1JaRwJFcHtkBlChn6ZuoCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=q6Za6zZMYpFq/1FRd5hsmntK5uv1qeDxUvmzCZbgYPCPTlgW3lViTkRkYB8TEfiA881ACQlR6/sfVLK5ZRoFZ7Hi7mFqk9me0l44SqfteYC/cOD5n0QXnDTKP850tMk4gSiNpEPLgbrBAmA+pLWmLXtOLANp5JUVFiUp+criuxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xD7iYwVL; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QHMBCr069748;
	Mon, 26 Aug 2024 12:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724692931;
	bh=qp02StfyHCxLtQVSInZ0qiOP+VS0thMZCKNak3f8ISs=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=xD7iYwVLM1tmGQLdo3QoFV7kXaY9fugdIV69S1m904Gp3ELyMx1IwFTtAzeuLmrSd
	 DY4m1KC7pF3epjYrripQ5/cOG/qy9hbZcrh83gnTovumyt5pflNSEzt/8PXdGlrt2t
	 vmlS7bPVw8wuORBCH8WyoPlNF2t77blJ855OTIaU=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QHMBiJ007848
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 12:22:11 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 12:22:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 12:22:11 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QHMBc3123045;
	Mon, 26 Aug 2024 12:22:11 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Mon, 26 Aug 2024 12:22:08 -0500
Subject: [PATCH v3 2/4] arm64: dts: ti: k3-am62a7-sk: add 1.4ghz opp entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240826-opp-v3-2-0934f8309e13@ti.com>
References: <20240826-opp-v3-0-0934f8309e13@ti.com>
In-Reply-To: <20240826-opp-v3-0-0934f8309e13@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1079; i=bb@ti.com;
 h=from:subject:message-id; bh=55LAEgYpKeVmBYii6puZg1JaRwJFcHtkBlChn6ZuoCA=;
 b=owNCWmg5MUFZJlNZd0PjZQAAYn////97nnt8z83hvbm3sbln3X//yr5c3O+v9y/s9f/rn/WwA
 RszRD1NGgGhoBoaAAD1AGjJoAAAANAAAaAANB6Q0ZPUaBo9QDQGnqaPU00eZKINMgyDQMg0Mg00
 GQNMIGmTTCAyABkZAaGg0AMmQek0aaZA0B6jQMmBMjIaCpRtJkaPU0yMgGmmTJoAMgGjQ0ZNNGh
 oDIAeoNNBiBoA0BkZNA0aABoNABiAYbIo/89RijxRpKAJmBiaTMDBUcil+Z7hEz4YkBK25QmS10
 8+zVivuqfvCEm9z2tjJ+TDxTfHQ1qY58Z1YgPgAhXQAe6K8pPz2RMSzpCKjjXgqh7WjbBhyic8P
 cMuYs2S6mScOxUDtXA3nMe6yH9xSoNHP2s0eaZc4RaAUBT6EJXBcmg72D35w441dHWjVtlKWtVe
 MdhYRmgryVfkOeQlVyyCYqtN86LEx7FzoE+Dh5rIk0DnzpOBwHW9K6R9V7R7ee0d1ZcXlvQvA3j
 GXQ5ZUawRCa9WBmdIZZnF7nla/QAWlGdAadgExWHaLYHQ64ooCOhUZNzVvPrMM+ImiDzXjfYhYQ
 foz5gotv5BbdlBapoZETvwdh3fLLSIAIYkvmdB/FbP6ECa3YGlioJpaGSOUaE+jCpRhGNEbX8xM
 nORYUFQb/i7kinChIO6Hxso
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The AM62Ax reference board is capable of supplying 0v85 to the VDD_CORE
which allows the Cortex-A53s to operate at 1.4GHz according to chapter
7.5 of the SoC's data sheet[0]. Append the 1.4Ghz entry to the OPP table
to enable this OPP

[0] https://www.ti.com/lit/ds/symlink/am62a3.pdf

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index 67faf46d7a35a..a6f0d87a50d8a 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -68,6 +68,15 @@ wkup_r5fss0_core0_memory_region: r5f-dma-memory@9c900000 {
 		};
 	};
 
+	opp-table {
+		/* Requires VDD_CORE at 0v85 */
+		opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-supported-hw = <0x01 0x0004>;
+			clock-latency-ns = <6000000>;
+		};
+	};
+
 	vmain_pd: regulator-0 {
 		/* TPS25750 PD CONTROLLER OUTPUT */
 		compatible = "regulator-fixed";

-- 
2.46.0


