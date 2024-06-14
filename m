Return-Path: <linux-kernel+bounces-214903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD09D908BD5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75B541F2428A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FB119AA70;
	Fri, 14 Jun 2024 12:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EetvqcnY"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9CC19A29F;
	Fri, 14 Jun 2024 12:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718368543; cv=none; b=ACb9D6srCIZoucG4KL+7vXpHPEno/gwfbQyKT8RFCuThBVPfUfC72iHoZvJnaV20NNvN4cu/xVJxG70gBsbd2iQOGhrF/BlPA8H5D4zUdFDwosMaQxxvke8OC/eL827KOOXF/DQnQvVVyaHwpO6eT/0DzRIJr5b5Xf7EuHIlpaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718368543; c=relaxed/simple;
	bh=IbtBPRoyFXCs87LWeIWDZbEJ9oo6tXVOgMrbPvuKucw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AsEuCj7nuIvj9YwC1/HeIsh3u3ewoV9wKPfl9TvYTtYygbhyejyIx012sez2ssxbWv2zapAgvRFTZvSLOKXZQUsccSCK5ClAHiW9uVqUwOnZDR7BU8QZLgfQMRCqTjL9q/0hbTmKkbQO5fvPGpG0A5RpOs+txrRRH9Xe+6TMjOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EetvqcnY; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45ECZY15124199;
	Fri, 14 Jun 2024 07:35:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718368534;
	bh=Xvl6MWSzL1Ip/Pwqt0EGpSh5XBn8DsBko9UP4NmzQwA=;
	h=From:To:CC:Subject:Date;
	b=EetvqcnYjxvohUSjpC/3DGcV5O6Ru1yclR7O9I8A9nvdHcvxMBm2Wz1kmjFtkqpBU
	 iR9KTk2C4xDGlFi2wiwTaMqF+r1GB15yZzrnlj/1dfBlnGC/XZQ3YtFNaBX5cdIYKF
	 gZp/W1MwDmKWGbRhp59y/qyrRHNZceu1IruqTA78=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45ECZY8B039985
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Jun 2024 07:35:34 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jun 2024 07:35:34 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jun 2024 07:35:34 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45ECZXaD130405;
	Fri, 14 Jun 2024 07:35:33 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <praneeth@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <devarsht@ti.com>, <d-gole@ti.com>, <bb@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am62x-sk-common: Add bootph-all for I2C1 instance pinmux
Date: Fri, 14 Jun 2024 18:05:32 +0530
Message-ID: <20240614123532.203983-1-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

I2C1 controller controls io-expander which provides power to voltage
regulator vdd_mmc1 for MMC SD using a gpio line.

Add bootph-all to the pinmux node for this instance, as this is used during
SPL stage too by the bootloader while using SD boot mode as without this
the SD boot mode fails with below error when using this device-tree in
u-boot:

"Timed out in wait_for_event: status=0000
Check if pads/pull-ups of bus are properly configured
Timed out in wait_for_event: status=0000
Check if pads/pull-ups of bus are properly configured
"
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 52231bfe60fe..ec32fd9791f8 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -168,6 +168,7 @@ AM62X_IOPAD(0x1e4, PIN_INPUT_PULLUP, 0) /* (A16/D14) I2C0_SDA */
 	};
 
 	main_i2c1_pins_default: main-i2c1-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x1e8, PIN_INPUT_PULLUP, 0) /* (B17/A17) I2C1_SCL */
 			AM62X_IOPAD(0x1ec, PIN_INPUT_PULLUP, 0) /* (A17/A16) I2C1_SDA */
-- 
2.39.1


