Return-Path: <linux-kernel+bounces-363403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAF699C1DB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A9D11C24932
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D478F155300;
	Mon, 14 Oct 2024 07:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eg6ASBCo"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87881552FD;
	Mon, 14 Oct 2024 07:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728891958; cv=none; b=s4b/G057jHICNQqwIYtAeLMdZTRvI9aRzkrMvdK+DsZC1tqMx81JSu8w1FOH+i4p5cO5TbI4cZoIZmsdhr+XLPbhaD+MLQHKdYSaJ0G8XuUeZX+K7ByyFFau/UeePpf/9kEHeFTBfl/dVdn981oRH978Pz05VxdGuLcXsBwGO44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728891958; c=relaxed/simple;
	bh=lYxPTbt0uh80QOuOxyuH3b79+28SfI6ndyTIRLwlXPk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYClK4Z/uZMWQfF6jIFRpEuhfELCE0uo/e4RlDaorP//gvebVuPuGUy8qGOA9FhUxC6P2R0KIDpSaZAPHdd5DV5nkZ6L6IVfQ0VZekgvDrGk7xa6nZx1C4UqsmxAP+DgzBdaxjE2ckAM7W5BYFOyT5+tdt63ZlTX9NUNO/XdUqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eg6ASBCo; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49E7jbeP087305;
	Mon, 14 Oct 2024 02:45:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728891937;
	bh=r+Yyd9lhOdy0W89Tjk571OY8Aplw81FOM7YKqkwKPMs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=eg6ASBCoyFq1zY19mdxv8FSZY4ntw8f3FT0rXzbBndpc2+TjPGlF8gQ6TvIAaBWyf
	 F3Z+4uDoZaB4yiqjN/I2YRieLmIsDfL1iWVRh23SIJH69QmVOlonAjfDQnWnLZF+pV
	 AU6UQBrC2+I8fMpgbbXl0w5P9TchnpTgxhyV2QQs=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49E7jaM8020710;
	Mon, 14 Oct 2024 02:45:37 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Oct 2024 02:45:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Oct 2024 02:45:36 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49E7javO011797;
	Mon, 14 Oct 2024 02:45:36 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 49E7jZi4025338;
	Mon, 14 Oct 2024 02:45:36 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kristo@kernel.org>,
        <srk@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH 2/4] arm64: dts: ti: k3-am654-icssg2: Add ti,pa-stats property
Date: Mon, 14 Oct 2024 13:15:25 +0530
Message-ID: <20241014074527.1121613-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014074527.1121613-1-danishanwar@ti.com>
References: <20241014074527.1121613-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add ti,pa-stats phandles to AM65x device trees. This is a phandle to
PA_STATS syscon regmap and will be used to dump IET related statistics
for ICSSG Driver

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso | 1 +
 arch/arm64/boot/dts/ti/k3-am654-idk.dtso    | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso b/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso
index 0a6e75265ba9..66bb0b913d49 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso
@@ -41,6 +41,7 @@ icssg2_eth: icssg2-eth {
 
 		ti,mii-g-rt = <&icssg2_mii_g_rt>;
 		ti,mii-rt = <&icssg2_mii_rt>;
+		ti,pa-stats = <&icssg2_pa_stats>;
 		ti,iep = <&icssg2_iep0>, <&icssg2_iep1>;
 
 		interrupt-parent = <&icssg2_intc>;
diff --git a/arch/arm64/boot/dts/ti/k3-am654-idk.dtso b/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
index b0ce2cb2fdc8..6cb44dae9f90 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
@@ -43,6 +43,7 @@ icssg0_eth: icssg0-eth {
 
 		ti,mii-g-rt = <&icssg0_mii_g_rt>;
 		ti,mii-rt = <&icssg0_mii_rt>;
+		ti,pa-stats = <&icssg0_pa_stats>;
 		ti,iep = <&icssg0_iep0>,  <&icssg0_iep1>;
 
 		interrupt-parent = <&icssg0_intc>;
@@ -109,6 +110,7 @@ icssg1_eth: icssg1-eth {
 
 		ti,mii-g-rt = <&icssg1_mii_g_rt>;
 		ti,mii-rt = <&icssg1_mii_rt>;
+		ti,pa-stats = <&icssg1_pa_stats>;
 		ti,iep = <&icssg1_iep0>,  <&icssg1_iep1>;
 
 		interrupt-parent = <&icssg1_intc>;
-- 
2.34.1


