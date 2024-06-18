Return-Path: <linux-kernel+bounces-219954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DD090DAAF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614971F2376C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74201494A1;
	Tue, 18 Jun 2024 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OSmI5aho"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D562B9A6;
	Tue, 18 Jun 2024 17:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718731895; cv=none; b=et4uMOV2YVp8tZXx5RzxPB5zeW2w8BH9uT3qK0CccUJsT3WA5rRXHliz6m52P5S2MCJTqLnllS4wh4Weiby1i/9Q+yWhkB+wpSQ/hm0LGTuavW0o31ego1fXLsbbXOeLdxkd7IFq+Y28Y6eyXSLktIuRvDyu6O40eqMbUTYDLi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718731895; c=relaxed/simple;
	bh=7D/uyYqJAl2FtsNhGP/cB2ixajK07ArTs3QM1lNtQGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p133fJDegWQCUrqc3zH7eAwX19g3QhVqbzl2sb0gU7zfiStsxsHNlNhW59CVAn2O99p5r83EbFPR2hK1df0Tgs8KkcMhYoh6GUvlG02wUxFZlwBuUJlbYyu+slDgumVZQ+Xfu/9moXroqB7B5ASvQuH/PPKx3iZg7Dl1DS4g8Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OSmI5aho; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45IHVQY2090275;
	Tue, 18 Jun 2024 12:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718731886;
	bh=M8QVNHYjr+eawa2MZqUdlKNAbddNorXVlpiDPBEUakw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=OSmI5ahodJBdO18d/bz7sI6s5ZoF7BFxBuvGFvNtXQs8ejJUNqDQkj3NRqey+RmKX
	 J0D3g2fgbcMyQ6Iun5imXXaOrdvpM2mn9jQaZRQ5ela7KYJtbJJ00BpuasUtJ4n+p9
	 ljFw8Jrq82+r5coUsheCJkgkA7GtS/NXqtMGQU4s=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45IHVQkF048883
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Jun 2024 12:31:26 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Jun 2024 12:31:25 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Jun 2024 12:31:25 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45IHVPgg065564;
	Tue, 18 Jun 2024 12:31:25 -0500
From: Nishanth Menon <nm@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Vaishnav
 Achath <vaishnav.a@ti.com>,
        Jared McArthur <j-mcarthur@ti.com>, Bryan
 Brattlof <bb@ti.com>,
        Dhruva Gole <d-gole@ti.com>
Subject: [PATCH 1/3] arm64: dts: ti: k3-pinctrl: Define a generic GPIO MUX Mode
Date: Tue, 18 Jun 2024 12:31:21 -0500
Message-ID: <20240618173123.2592074-2-nm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618173123.2592074-1-nm@ti.com>
References: <20240618173123.2592074-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Texas Instruments, Inc.
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Introduce a GPIO mux mode macro for easier readability. All K3 devices
use mux mode 7 to switch to GPIO mux.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-pinctrl.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
index 4cd2df467d0b..b1a0415e6611 100644
--- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
+++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
@@ -38,6 +38,8 @@
 #define PIN_DEBOUNCE_CONF5	(5 << DEBOUNCE_SHIFT)
 #define PIN_DEBOUNCE_CONF6	(6 << DEBOUNCE_SHIFT)
 
+#define PIN_GPIO_MUX_MODE	(7)
+
 #define AM62AX_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
 #define AM62AX_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
 
-- 
2.43.0


