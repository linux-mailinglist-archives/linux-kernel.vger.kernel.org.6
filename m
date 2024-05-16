Return-Path: <linux-kernel+bounces-180874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5898C743C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7A5281CA1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 09:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9863F143882;
	Thu, 16 May 2024 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tdzq5yQj"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA26143873
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 09:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715853487; cv=none; b=QtUXJwdluBG0CaUc7eW/p/1PszJN8HfcZjebgf6Zgs+0SK9tQIQDuYx2mUif6lr35NH8QARsnCD+bxCZq3PUXbukczlgOtX8/n9mg4A9O/e8RODRlp+uRoigJ5YSy1hW4BkmL4IAM/5TywEZgQnv+EFmUYVWwYz2uwUv1Hu4J0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715853487; c=relaxed/simple;
	bh=e4zUva1NbLzeDTbMv1G2fWvTO3gozXWsyNxWiitwoVo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ar+o1E1CFAdN74HN0AoJxtNz+ZHY5gLxOOPgBp3cJMhd4cU89LBH6dM7RKvv9u6ngC4HLJJleS7eXYOQUreexvtAq7NhC/7QY4Gh4AvXo8ct4DuKlbwhZWe+RGpwN8TGf3tjrqiKF6UEM4YDk1kcLQb8IErpUNiYig1XJ0tXofw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tdzq5yQj; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44G9vZq6009811;
	Thu, 16 May 2024 04:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715853455;
	bh=kOxhi1dJpm9sGXBMlq//0Hp1PjScXmo73Ad9n4+qow0=;
	h=From:To:CC:Subject:Date;
	b=tdzq5yQjXRGyjJuTZKGSO8EM82k08uWW6CkJQf5ybksaZ8VNaNZIW1qC4ZwKrszKs
	 uLLEZf6bKbadr3bk1G/zFXw8q1kX+yn9mA3cqgVYQABLvaWgvIdP5TDpTeesBffhG1
	 OqpmlRwrYoUNeJkl1EC0O80PKcBx4fK3QJYnrK50=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44G9vZQT032139
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 May 2024 04:57:35 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 16
 May 2024 04:57:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 16 May 2024 04:57:34 -0500
Received: from localhost (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44G9vYAK096386;
	Thu, 16 May 2024 04:57:34 -0500
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <u-kumar1@ti.com>, <nfraprado@collabora.com>, <m.szyprowski@samsung.com>,
        <arnd@arndb.de>, <biju.das.jz@bp.renesas.com>,
        <neil.armstrong@linaro.org>, <shawnguo@kernel.org>,
        <konrad.dybcio@linaro.org>, <geert+renesas@glider.be>,
        <krzysztof.kozlowski@linaro.org>, <quic_bjorande@quicinc.com>,
        <will@kernel.org>, <catalin.marinas@arm.com>, <b-kapoor@ti.com>
Subject: [PATCH] arm64: defconfig: Modify number of usable 8250 uart ports
Date: Thu, 16 May 2024 15:27:33 +0530
Message-ID: <20240516095733.276807-1-b-kapoor@ti.com>
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

Jacinto SoCs have a total of 12 serial uart ports. But only 8 out
of these 12 uarts can be used at a time.

Thus, Modify maximum number of 8250 serial uart ports which can be
supported as well as modify how many 8250 serial uart ports which
we can use in the runtime to 12 for all the SoCs.

Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---
 arch/arm64/configs/defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 57a9abe78ee4..c693736909bc 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -454,7 +454,8 @@ CONFIG_SERIO_AMBAKMI=y
 CONFIG_LEGACY_PTY_COUNT=16
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=8
+CONFIG_SERIAL_8250_NR_UARTS=12
+CONFIG_SERIAL_8250_RUNTIME_UARTS=12
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_8250_BCM2835AUX=y
-- 
2.34.1


