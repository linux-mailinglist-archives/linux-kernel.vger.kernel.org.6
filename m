Return-Path: <linux-kernel+bounces-211772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB5290569A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA67428930C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34350181B87;
	Wed, 12 Jun 2024 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WvF6Dq2y"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1461717F518;
	Wed, 12 Jun 2024 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718205207; cv=none; b=lN48b5PgsNtoGCOVSfn+TrGlDwFBFr+kPJnqeeDLumowtEow8EK864wtjJYo64e5b651THEAzfur/dLhT4h0ssrXWtgF2SAF+38pni/VcO3X5kJaq30mu5tdsr62EonDO6EsAm4M0t6yJKdd5JteOeyk1mI/gYpEMgS9xcFx4SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718205207; c=relaxed/simple;
	bh=jBJrHF8R/moRIpLahflccAsyPKDx/CY4hVJ6WHaxgmM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQ0TNHUqojAzsGZz70WipiwM+Dv7ykaeDJS5l2PYV2AmVM4rmXclGgcRBylmk3T7kZNOUkEF+LPL4nRWYIiC5oOt5xH2j/C8z8WRjsHOpfW/b42aHOuT8cV2M0oniwn3J4uNrYQZslaD1qYFrgYkzzu7Ks631a2929bdEd4SiwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WvF6Dq2y; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CFDLOG114562;
	Wed, 12 Jun 2024 10:13:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718205201;
	bh=LNxutNtD+VzXTIgFPT13ZqDgJa7HFJpJf0b9oTLqc1Y=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=WvF6Dq2yjvsuL6DfV4l5ypKbCFclhCFFU/UiUAQkeA7Zy0ozkIMknE9NDXMnXfObG
	 JBrc0bh6ijnFWZ7CJM+oZ2lpuE7TJNfGi30IbCEN0wrHzcILadq+32aafB+n6LtnLH
	 6tpuJkr32gqygo1gPwz2ewSo88keeHkr5dLvQWOQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CFDLHK031191
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 10:13:21 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 10:13:21 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 10:13:21 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CFDKD4104005;
	Wed, 12 Jun 2024 10:13:21 -0500
From: Andrew Davis <afd@ti.com>
To: Daniel Tang <dt.tangr@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 2/2] ARM: dts: nspire: Add full compatible for watchdog node
Date: Wed, 12 Jun 2024 10:13:14 -0500
Message-ID: <20240612151314.27967-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240612151314.27967-1-afd@ti.com>
References: <20240612151314.27967-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The watchdog appears to be an ARM SP805, add the full compatible
and the needed clocks properties. Leave this disabled for now
as functionality is not fully tested.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/boot/dts/nspire/nspire.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nspire/nspire.dtsi b/arch/arm/boot/dts/nspire/nspire.dtsi
index d56fef7250dbd..95588b716c6f3 100644
--- a/arch/arm/boot/dts/nspire/nspire.dtsi
+++ b/arch/arm/boot/dts/nspire/nspire.dtsi
@@ -170,9 +170,12 @@ timer1: timer@900d0000 {
 			};
 
 			watchdog: watchdog@90060000 {
-				compatible = "arm,primecell";
+				compatible = "arm,sp805", "arm,primecell";
 				reg = <0x90060000 0x1000>;
 				interrupts = <3>;
+				clocks = <&apb_pclk>, <&apb_pclk>;
+				clock-names = "wdog_clk", "apb_pclk";
+				status = "disabled";
 			};
 
 			rtc: rtc@90090000 {
-- 
2.39.2


