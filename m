Return-Path: <linux-kernel+bounces-185937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD028CBD12
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90D2281CA1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 08:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90B37F7F7;
	Wed, 22 May 2024 08:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="d/jWhR9j"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6721A2262B;
	Wed, 22 May 2024 08:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716367003; cv=none; b=U9VaOOOYaWBy187bHeslg0IBuLmbU4FF8xixPtE0NDA/yurcfWh0l2Wyj1t7E+CgcZxHzCvdavCrvl3HIA2U+10Ci/E+fYygcslSV72vhdB092mZWsgqnJWp41TSrPoFCE1zzqp1X/tgDeB9UDAmocCw+tCGMHtKzRNUb2TttP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716367003; c=relaxed/simple;
	bh=G5Sh2d9Xq79Hi6W8v/uzk298wFlWep6o+iThnMQq4yQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k2EI7Rht8Enyvmw6pIIS987K+UoGJA0XX17qXH+ufmxOazre3ORI/hTwNT86twGz2b7tIf6hL/UbGk0g0aC09rG7hYcI5zpIAgy/wJTI7NfLBLlzDNDBo36tvDYTDqtIJV+JKsOf9uBXBvNOcnlYe1/g8MOSt5QsA7oL3zbcB0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=d/jWhR9j; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44M8aWeK049185;
	Wed, 22 May 2024 03:36:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716366992;
	bh=n8oBR7JoDKyKvVrxrHX/RxpGuTR/rtSwQ+FaAI9ezQE=;
	h=From:To:CC:Subject:Date;
	b=d/jWhR9j0O/J+DLMHiXvg0imgN07TqEP16yQRTFjHep5Fut22FukOBXNJBsf0oovp
	 3OVJRjhkjVcuP4PrZIZ/ic53DUQ99C1RfdjM+xoEFJexTzGt3dM/DMJR4jDhi0SBU1
	 Kv28qHuXhFIdkH1XVIwVibVLh8vaub4nTClsh7dU=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44M8aWpH004411
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 May 2024 03:36:32 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 May 2024 03:36:32 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 May 2024 03:36:32 -0500
Received: from localhost (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44M8aVA1050180;
	Wed, 22 May 2024 03:36:32 -0500
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <b-kapoor@ti.com>, <jm@ti.com>, <vigneshr@ti.com>, <nm@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j722s-evm: Mark eMMC as non removable
Date: Wed, 22 May 2024 14:06:31 +0530
Message-ID: <20240522083631.1015198-1-b-kapoor@ti.com>
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

Mark the eMMC module on J722S as non removable since it
is always present on the evm.

Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index bf3c246d13d1..fe810e32cb7a 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -369,6 +369,7 @@ partition@3fc0000 {
 &sdhci0 {
 	disable-wp;
 	bootph-all;
+	non-removable;
 	ti,driver-strength-ohm = <50>;
 	status = "okay";
 };
-- 
2.34.1


