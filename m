Return-Path: <linux-kernel+bounces-295293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1E6959960
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1B2BB268E7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E6720862A;
	Wed, 21 Aug 2024 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qzj/1W7j"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7D3208604;
	Wed, 21 Aug 2024 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233945; cv=none; b=orh/sJVJxdR9h2Q6XJhyCaGAb2FAu/J3kOD4U5t9rAzcHxr4uyWYwSpI6DB0wlS86L5OUgCFkKyKjKJi+YY9v3B/8wUt06oTeKOEqAdN6vgci3lkSR21VtRXqeUByLoCJQuAnfz5e3QhHcjQw+amppsI5254k7HvJay0H2d8QG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233945; c=relaxed/simple;
	bh=sQJexEHdwrq1xx+oniJyEZM3deRjSiOMFPJP4LBldBk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwl2+px76QQHfFepZXcq0sAC7qUuJf/EX8YWa1s3ZzoVZL/XFviXrMQ+YHWCIA0mOv6jm7lIsXRU0Ok/wg2mHrgjLO+QxBY5MFDSDdV1ban9Y/mvj2taia666/RHCb/SX0/kJJtq/h+EnBwCG8uMR6zyuvM4V9rgBQIMzbgUoNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qzj/1W7j; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47L9qJtZ016938;
	Wed, 21 Aug 2024 04:52:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724233939;
	bh=U7+4yh76QMk2xPsJQoG0uY1JvMgHcg+edVAPp2ZREwI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=qzj/1W7jiic8vWa6dZxgekb25icWgErx948NAnrIA1n71FagtASNGgDiWIrxYK2Lm
	 IrWemxmRqDjTylw0amitcGpE9W3Rsv3JLmKRZYO28PV1eikIUciiDQTkqirlAK6VuF
	 djX2Jaty1oE03BQp0sJ0k8tlj7dDNz8S+gnKKJ94=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47L9qJUe039963
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 21 Aug 2024 04:52:19 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Aug 2024 04:52:18 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Aug 2024 04:52:19 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47L9q1n5066254;
	Wed, 21 Aug 2024 04:52:15 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <s-anna@ti.com>, <hnagalla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/4] arm64: dts: ti: k3-j784s4-main: Switch MAIN R5F clusters to Split-mode
Date: Wed, 21 Aug 2024 15:22:00 +0530
Message-ID: <20240821095200.3050878-5-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821095200.3050878-1-b-padhi@ti.com>
References: <20240821095200.3050878-1-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Apurva Nandan <a-nandan@ti.com>

J784S4 SoCs have three R5F clusters in the MAIN domain, and all of
these are configured for LockStep mode at the moment. Switch both
of these R5F clusters to Split mode by default to maximize the number
of R5F cores.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
[ Commit message cleanup ]
Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index d4ac1c9872a5..2c1d0c41f476 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -2248,7 +2248,7 @@ ufs@4e84000 {
 
 	main_r5fss0: r5fss@5c00000 {
 		compatible = "ti,j721s2-r5fss";
-		ti,cluster-mode = <1>;
+		ti,cluster-mode = <0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x5c00000 0x00 0x5c00000 0x20000>,
@@ -2288,7 +2288,7 @@ main_r5fss0_core1: r5f@5d00000 {
 
 	main_r5fss1: r5fss@5e00000 {
 		compatible = "ti,j721s2-r5fss";
-		ti,cluster-mode = <1>;
+		ti,cluster-mode = <0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x5e00000 0x00 0x5e00000 0x20000>,
@@ -2328,7 +2328,7 @@ main_r5fss1_core1: r5f@5f00000 {
 
 	main_r5fss2: r5fss@5900000 {
 		compatible = "ti,j721s2-r5fss";
-		ti,cluster-mode = <1>;
+		ti,cluster-mode = <0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x5900000 0x00 0x5900000 0x20000>,
-- 
2.34.1


