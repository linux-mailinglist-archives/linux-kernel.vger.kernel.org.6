Return-Path: <linux-kernel+bounces-511904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F3FA33141
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 22:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE1AD7A1C9E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D803D202F62;
	Wed, 12 Feb 2025 21:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DIx/C20G"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F296B201269;
	Wed, 12 Feb 2025 21:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739394389; cv=none; b=IcxnDrp6y3d57wX+kqBcBPMFt70fCzP5aV30+ynXo29cto5w6wYYbaioaPegc1U3IfH1pFl1N4wwwzIE8H82EA+cEBWO/yqTajgUn279DVbGGU1PO2NrQfLtNMPwdYx3eBtTY3CBduVtfT6FYjskWQgdNcD5u1qBs78k0ASQYbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739394389; c=relaxed/simple;
	bh=rsT7j/zUDwUI/0z6b5BwWt9md/wtWdOMRAVonfKal8o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TgXyompeqeRbG2AyXr9MjbW+Y1jTdcOlqFKp8Z+C/b1HdAn//hwzQQXX9qSFJeqxeFC11qryHj0GB8NVYbouFfDRv9Ea2X+0VrBEj/s7TWzAacKsnuULApgksTQeAzBR44pjcQ3O+qP5hB0kd98v65LXcKmnyaBG+HzpOn7XCjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DIx/C20G; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51CL65Zg3977713
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 15:06:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739394366;
	bh=mMUjaEjJEv8Fp6KTvvVQCD916I1txak6eBFZLlKuOe0=;
	h=From:To:CC:Subject:Date;
	b=DIx/C20G074mRXZ+qV/OZZRuX2jeIExXkklKAsWxLVoIm9fZLiPY/cEcD4syaxae/
	 e5EUiBaKZRUWSRRNZZG1cvOKkumqTB0DJD5Yq8sM76q3JlCm3bQaL9qRxGn4hRVgwN
	 kBhFQCiVubjIIU1ir0QGrIq/XX93H22KeENI5Juw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51CL65lY129213
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Feb 2025 15:06:05 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Feb 2025 15:06:04 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Feb 2025 15:06:04 -0600
Received: from uda0506412.dhcp.ti.com (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51CL64Sc099103;
	Wed, 12 Feb 2025 15:06:04 -0600
From: Kendall Willis <k-willis@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <d-gole@ti.com>, <msp@baylibre.com>, <khilman@baylibre.com>,
        <k-willis@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] arm64: dts: ti: k3-am62a7-sk: Add alias for RTC
Date: Wed, 12 Feb 2025 15:06:04 -0600
Message-ID: <20250212210604.745175-1-k-willis@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Vibhore Vardhan <vibhore@ti.com>

Adds alias for SoC RTC so that it gets assigned rtc0. PMIC node is
assisgned rtc1 so that PMIC RTC gets probed as rtc1. This makes it
consistent for testing rtcwake with other AM62 devices where rtc0
is SoC RTC.

Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
[k-willis@ti.com: Reworded commit message]
Signed-off-by: Kendall Willis <k-willis@ti.com>
---
Tested with rtcwake on AM62A.

Original patch for AM62A existed in the TI Vendor tree with Vibhore's
authorship:
https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/?h=ti-linux-6.6.y&id=f745d9063212d1088dcfb068ecb4b16648b96487
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index a6f0d87a50d8..51ea961f166e 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -22,6 +22,8 @@ aliases {
 		serial3 = &main_uart1;
 		mmc0 = &sdhci0;
 		mmc1 = &sdhci1;
+		rtc0 = &wkup_rtc0;
+		rtc1 = &tps659312;
 	};
 
 	chosen {

base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.34.1


