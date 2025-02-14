Return-Path: <linux-kernel+bounces-515785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337D1A36908
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758163A2B90
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902E91FCF6B;
	Fri, 14 Feb 2025 23:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="P9BiM/uf"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196C91FC7CD;
	Fri, 14 Feb 2025 23:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739575345; cv=none; b=GrFFdB9/Gq5JWO5BFrNwEO1dvpUG+Ig6u86GdGrYz+kFQI0qL70elLytqlBJjb7fWdCLsbbW0ZvmLCCg9YjIZakuj5CMFvbo7bTv/O5o+UzoOR2f58pAtoFAmBveW4igzTi0VcPzNXdKJgRivxAz0NIEjdNjExQbTSxIIyeoJgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739575345; c=relaxed/simple;
	bh=i9dVSrdDuxUIzBm4QOmjWQ6YUudmo04HFFKh7K4K70Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EVlC2KeX7U5rKFjjOSpF3AibcmyF+vh4ZOsh21XYl9H2KZeWhC6ftQdFnFkxkKrkfQ7/6iCYwmqezYYRXRlOfNuZVW3qp3rrI28WpP68h6u289NLqTR3xymoDhJVQJ08D4VQqbKS6noAZ/EFqVjXALqNTPBRUofGGaRwxoUo3MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=P9BiM/uf; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51ENMDql941245
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 17:22:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739575333;
	bh=FeyaBUGdJjlkWGW9Mb2IxlcoLsMedTXWODoDc3NaxG0=;
	h=From:To:CC:Subject:Date;
	b=P9BiM/uf60SIVuIQuPsdXSDdSogfHjtvnBd6dpYPS0LQIQva+h8t/Cyi594V/9VA6
	 C2/xIFkTQvJDVzD49aANNt4QCufv4n/+LOCzKOctihvvyh6UW5DR5aHXYmwQCbDxE1
	 M8Wc0eZPsaKOzCgoFOtODWzSrYRq1ZYjk+bJ9LSM=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51ENMDZL014707
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Feb 2025 17:22:13 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Feb 2025 17:22:13 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Feb 2025 17:22:12 -0600
Received: from uda0506412.dhcp.ti.com (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51ENMCYN053254;
	Fri, 14 Feb 2025 17:22:12 -0600
From: Kendall Willis <k-willis@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <msp@baylibre.com>, <khilman@baylibre.com>, <d-gole@ti.com>,
        <k-willis@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2] arm64: dts: ti: k3-am62a7-sk: Add alias for RTC
Date: Fri, 14 Feb 2025 17:22:12 -0600
Message-ID: <20250214232212.1158505-1-k-willis@ti.com>
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
assigned rtc1 so that PMIC RTC gets probed as rtc1. This makes it
consistent for testing rtcwake with other AM62 devices where rtc0
is SoC RTC.

Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
[k-willis@ti.com: Reworded commit message]
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Kendall Willis <k-willis@ti.com>
---
Link to v1:
https://lore.kernel.org/all/20250212210604.745175-1-k-willis@ti.com/

Changes from v1 to v2:
- rebased on latest linux-next
- fix spelling mistake
- add test log

Tested on AM62A with rtcwake [1]. The wakeup source is 0x50 which 
indicates the SoC RTC is used to wakeup the system as detailed in the
TISCI documentation [2].

[1] https://gist.github.com/kwillis01/402aa56d263ef757316f1d6e44dea83f
[2] https://downloads.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html#tisci-msg-lpm-wake-reason
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

base-commit: 0ae0fa3bf0b44c8611d114a9f69985bf451010c3
-- 
2.34.1


