Return-Path: <linux-kernel+bounces-440292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 177D59EBB58
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ADB3284491
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A8422CBF2;
	Tue, 10 Dec 2024 20:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EkmjFN0m"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB4B22B5A2;
	Tue, 10 Dec 2024 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864388; cv=none; b=QXG7pmyNWPXccmUawRp5g+g5q7QjuKJbEz69V4m2ay6AWEE1ZzCqccWrP3ljdR/aQjFwUNVpWRU8vqiUY+RdHAsPCptbJVcylrsBMabkdbToP6KBtproAPrVUdR+BlwpiKi8utiTTIS/1hd2ENQWRWj5nkk1r9PdJy6je+2GuO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864388; c=relaxed/simple;
	bh=Z6TrSCMqbMcQVffARb+h+rS3MaWBdwEX6yBNrQmJbTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=L5sg/MzYiO1uiJROUf5w/izOh9aHcXnW83AoVaQqrPird9Xf3HdaNNfUXi1+McyeMzp/n07rhNhJwsVQtr1EtyS+y1GkpHMMJZ44rY5wfX/FDN+yKXlaKCOdpFDSBQSAhW3klkaflzy2kgOXpjsVZp3CmbVI/09vfXTRY2ke4zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EkmjFN0m; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BAKxWqL2984166
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 10 Dec 2024 14:59:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733864372;
	bh=O0iJpfr132f+XUsNEv0Nw3kBjj9h/tNGsFdXnT0fSYI=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=EkmjFN0mmfajeOwu2XwM21QCYM2i+FVQDBmbrfuNGAGHfCICYVksCzGGhA1ZuAQq2
	 PGzz6qEwZ0S6jXkQorXyC+I4Sqom0yBXZq6GWJ3yiM2PfZXtG0yr4h3MQIHTAwttX7
	 mYUoKiZo5tfjJePlNxj6zdPeYLdnJkIGItObCdEg=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BAKxWIT043829;
	Tue, 10 Dec 2024 14:59:32 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Dec 2024 14:59:31 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Dec 2024 14:59:31 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BAKxVle100283;
	Tue, 10 Dec 2024 14:59:31 -0600
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 10 Dec 2024 14:59:24 -0600
Subject: [PATCH 1/2] arm64: dts: ti: k3-am62: remove duplicate GICR reg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241210-am62-gic-fixup-v1-1-758b4d5b4a0a@ti.com>
References: <20241210-am62-gic-fixup-v1-0-758b4d5b4a0a@ti.com>
In-Reply-To: <20241210-am62-gic-fixup-v1-0-758b4d5b4a0a@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bin Liu <b-liu@ti.com>,
        Bryan Brattlof
	<bb@ti.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=939; i=bb@ti.com;
 h=from:subject:message-id; bh=Z6TrSCMqbMcQVffARb+h+rS3MaWBdwEX6yBNrQmJbTg=;
 b=owNCWmg5MUFZJlNZTCxWfwAAaf///vfr/308v7+Rz+Nf8t9/stS//dd/+9bf0/w/k/xxq88wA
 RmwIekAAA0DTQYQaDIMgGho0DIAyaAAyDRoGg0yMgDBMQGhoPRDE0NNpMyRBoADQGRoNGQBoyaA
 wmQMQAAaGmCYmmAEaNNoIDQNMIDCZA0AaGg0B002iYmIaNGIaNBpppkPU0aAaAyAyZAwQAYmQyA
 AGgAGmmmQGRk0PSBoaDQAA2hrmxZQiusFQ/EQzYkIFawMjDUkUHzJMiG9yDwMyD5CD5oLx9KAz/
 nBHnVXNiq8tqoNyoALsd5q9GR70ITApabdoR7E1UlEOxywegTMt9m7gZjWc0QgWBe+vQCXUjX7s
 TG3A3++mkGraTNUy4wjZZzAGn0FhwMtsJplsWRA2Ybw0VqSb1bu5j0TNGnTWhBscLIkDlYLJ07y
 NvvBmMkzKw6EYWuC9S1Pqeo7OLV6udLNeR0Secus6dCmPt8mnCQ6wSYA1Su30vl2OAfQIibRsig
 TpkXVKzzgcCebt21CHuD0T0Wa+H4QAgzGgtKTGDCfCstKc4rY0vaKLJQ7384wxcjob+SBZqjXCV
 GGH0ZBipd5pbLwSVSkQPwN65DeuwChKam0L1ON7ipOjAZiFfv3Gbz6QPphFInQ0XN0A8CDfc9qb
 Qvgf8XckU4UJBMLFZ/A
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The GIC Redistributor control register range is mapped twice. Remove the
extra entry from the reg range.

Reported-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 7cd727d10a5f2..7d355aa73ea21 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -23,7 +23,6 @@ gic500: interrupt-controller@1800000 {
 		interrupt-controller;
 		reg = <0x00 0x01800000 0x00 0x10000>,	/* GICD */
 		      <0x00 0x01880000 0x00 0xc0000>,	/* GICR */
-		      <0x00 0x01880000 0x00 0xc0000>,   /* GICR */
 		      <0x01 0x00000000 0x00 0x2000>,    /* GICC */
 		      <0x01 0x00010000 0x00 0x1000>,    /* GICH */
 		      <0x01 0x00020000 0x00 0x2000>;    /* GICV */

-- 
2.47.1


