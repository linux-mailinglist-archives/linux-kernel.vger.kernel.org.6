Return-Path: <linux-kernel+bounces-304369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0680C961F10
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78DDAB23390
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 06:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9DA155316;
	Wed, 28 Aug 2024 06:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ApTn6ikf"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70401799F;
	Wed, 28 Aug 2024 06:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724825328; cv=none; b=NlNPAGdoX+GwicpMvGbXc3WVn0OquXMkYZH3aKBsLdADNeZ6lF003B11fPDAXWnw/jYQVFtzNVrpDBfWiztnoRBIcsRlboE+olrNA2iYRQShekFUyLwl3CifWqvIWZXrcLivYmWtAtmqpU1QtZeGx3zmI1GDjF7k73caGXTTpPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724825328; c=relaxed/simple;
	bh=Pl1+NSifgoRpJ4LlZciVlTEEXJmTEpqOHSiN9reOK54=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jRIxrIEb/NqYfo9YVkBkRbUUj8ix7W2vzZSa4MP7ekJq/f0aWwl+Ge9XwKrRDri6Zu4W/O+OwR80+FmD4yB/EXGY876dZe0vF6M6MTICm94Uj4+GuJKaqZrb4mcQZmpMwNfLn/Mzvk+wPQmbvgXsAADd2KY/j9cvUj7zPOZnRcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ApTn6ikf; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47S68aI7055360;
	Wed, 28 Aug 2024 01:08:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724825316;
	bh=I9CxeLlhRLFlFLlPgD1G7AfcoceYacs6pNC/qxoK6i0=;
	h=From:To:CC:Subject:Date;
	b=ApTn6ikfQxsvUN8bpUk85e4QsZlQYxigQLZeqcbBDcAMJpgN/FfZmv2L3kmJFlJef
	 X/4GATzLKIqnv65X5LIUHsrxNprwl+ABl6ZA3+5P4o+V2EV2bWdhMDrm5GNDJCRwJg
	 nNiuWFkES7sJyq2HCMB2zvNxyl8uq45JuIGApJQA=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47S68a8g029671
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 01:08:36 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 01:08:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 01:08:36 -0500
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com [172.24.227.197])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47S68Wh3037421;
	Wed, 28 Aug 2024 01:08:33 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <vigneshr@ti.com>, <nm@ti.com>, <krzk+dt@kernel.org>, <kristo@kernel.org>,
        <robh@kernel.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>,
        <sinthu.raja@ti.com>, <m-chawdhry@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am68-sk-som: Update Partition info for OSPI Flash
Date: Wed, 28 Aug 2024 11:38:30 +0530
Message-ID: <20240828060830.555733-1-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Commit 73f1f26e2e4c ("arm64: dts: ti: k3-am68-sk-som: Add support
for OSPI flash") introduced the flash node with discontinuous
partitions. Updating the partition offset to be continuous from
the previous partition to maintain linearity.

Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
index 5c66e0ec6e82..2e5730216caa 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
@@ -215,9 +215,9 @@ partition@680000 {
 				reg = <0x680000 0x40000>;
 			};
 
-			partition@740000 {
+			partition@6c0000 {
 				label = "ospi.env.backup";
-				reg = <0x740000 0x40000>;
+				reg = <0x6c0000 0x40000>;
 			};
 
 			partition@800000 {
-- 
2.34.1


