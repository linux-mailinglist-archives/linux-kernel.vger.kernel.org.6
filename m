Return-Path: <linux-kernel+bounces-433182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C074C9E54D6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8054F2855FD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024242144D6;
	Thu,  5 Dec 2024 12:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sb+0/sQB"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48433217701;
	Thu,  5 Dec 2024 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400111; cv=none; b=UV8TSAMlxEa4fDYzErbDKvXwf3f5zzNWinL0NlHIr2lXDZjnm6xY7NHn+jZWOMsxjZ7D+O1g0gxW3MHtmlNKJyDRJRDcolRSxeZuMtud9fQGiQAMRnKoLaAVnfFApHHZyuaU2bvuv7Eq5npj2Wl3K3imYp9V1WFqCpp70FedW/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400111; c=relaxed/simple;
	bh=hvc7j05VnMVHPY5xq5YcKLJKta8IdQmWXw09bxY2p9Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KCDnwy0BHCgPX0EfF9Xe0im5C6569wGd7HZDzBSWkFMaaqV6wCCOTi0J0IyRSC8LU9AGvS1UAKHkzY1qQAuU537YMRIdIW3fYlocfA2p+T2yuxVbSLwv7wmnHu7WdyiMi+SHVEO4SPYLAtlLV7KfF3jfn2cctHakQKNVRmrAPVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sb+0/sQB; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B5C1gFY2198093
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Dec 2024 06:01:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733400103;
	bh=aujwLeQT3HzYwdCgr/y0T0q1JE+aR67oIysdUNWWl/w=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=sb+0/sQBJmqWOA3hNiias5WYz3eCqUyeDk0dVWUtRzBnb/0ThBXNoXqhO67oi4qUF
	 /2xhPYYjYAT9Gz2gIj8QEMAwO/T4omipPjiIGJM9NE4agvhqA+x44TRKSkgWiNxXPk
	 16xPa/pCX3hqhctvKE4cR6IufXwIJrdkzJPj5xJ0=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B5C1gGd002276
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Dec 2024 06:01:42 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Dec 2024 06:01:42 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Dec 2024 06:01:42 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B5C1Zp8018608;
	Thu, 5 Dec 2024 06:01:39 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v2 1/2] arm64: dts: ti: k3-pinctrl: Introduce deep sleep macros
Date: Thu, 5 Dec 2024 17:31:28 +0530
Message-ID: <20241205120134.754664-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241205120134.754664-1-s-vadapalli@ti.com>
References: <20241205120134.754664-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The behavior of pins in deep sleep mode can be configured by programming
the corresponding bits in the respective Pad Configuration register. Add
macros to support this.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v1:
https://lore.kernel.org/r/20241112115650.988943-2-s-vadapalli@ti.com
Changes since v1:
- Rebased on next-20241204.

While Rob had suggested dropping the zero defines at:
https://lore.kernel.org/r/20241115154822.GA2954187-robh@kernel.org/
I had pointed out the inconsistency with existing convention at:
https://lore.kernel.org/r/5b35c736-74d6-4fe9-ae82-272dc2e98b82@ti.com/
asking for Rob's opinion. Since I didn't receive a reply, I assumed that
the patch is fine in terms of being consistent and hence haven't dropped
the zero defines in the current version.

Regards,
Siddharth.

 arch/arm64/boot/dts/ti/k3-pinctrl.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
index 22b8d73cfd32..cac7cccc1112 100644
--- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
+++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
@@ -12,6 +12,12 @@
 #define PULLTYPESEL_SHIFT	(17)
 #define RXACTIVE_SHIFT		(18)
 #define DEBOUNCE_SHIFT		(11)
+#define FORCE_DS_EN_SHIFT	(15)
+#define DS_EN_SHIFT		(24)
+#define DS_OUT_DIS_SHIFT	(25)
+#define DS_OUT_VAL_SHIFT	(26)
+#define DS_PULLUD_EN_SHIFT	(27)
+#define DS_PULLTYPE_SEL_SHIFT	(28)
 
 #define PULL_DISABLE		(1 << PULLUDEN_SHIFT)
 #define PULL_ENABLE		(0 << PULLUDEN_SHIFT)
@@ -38,6 +44,19 @@
 #define PIN_DEBOUNCE_CONF5	(5 << DEBOUNCE_SHIFT)
 #define PIN_DEBOUNCE_CONF6	(6 << DEBOUNCE_SHIFT)
 
+#define PIN_DS_FORCE_DISABLE		(0 << FORCE_DS_EN_SHIFT)
+#define PIN_DS_FORCE_ENABLE		(1 << FORCE_DS_EN_SHIFT)
+#define PIN_DS_IO_OVERRIDE_DISABLE	(0 << DS_IO_OVERRIDE_EN_SHIFT)
+#define PIN_DS_IO_OVERRIDE_ENABLE	(1 << DS_IO_OVERRIDE_EN_SHIFT)
+#define PIN_DS_OUT_ENABLE		(0 << DS_OUT_DIS_SHIFT)
+#define PIN_DS_OUT_DISABLE		(1 << DS_OUT_DIS_SHIFT)
+#define PIN_DS_OUT_VALUE_ZERO		(0 << DS_OUT_VAL_SHIFT)
+#define PIN_DS_OUT_VALUE_ONE		(1 << DS_OUT_VAL_SHIFT)
+#define PIN_DS_PULLUD_ENABLE		(0 << DS_PULLUD_EN_SHIFT)
+#define PIN_DS_PULLUD_DISABLE		(1 << DS_PULLUD_EN_SHIFT)
+#define PIN_DS_PULL_DOWN		(0 << DS_PULLTYPE_SEL_SHIFT)
+#define PIN_DS_PULL_UP			(1 << DS_PULLTYPE_SEL_SHIFT)
+
 /* Default mux configuration for gpio-ranges to use with pinctrl */
 #define PIN_GPIO_RANGE_IOPAD	(PIN_INPUT | 7)
 
-- 
2.43.0


