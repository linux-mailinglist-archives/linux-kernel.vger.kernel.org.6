Return-Path: <linux-kernel+bounces-202640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F8B8FD041
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32A2EB2EBC9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F231A189F;
	Wed,  5 Jun 2024 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MVdWRqOf"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF1E188CA4;
	Wed,  5 Jun 2024 12:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717591750; cv=none; b=qpa/bjyrE7GHhkit/rJRKkmNTIgq5fhsge/SHZrPrVPLF2B+g3906WVnW3S4z0RpolW38Roz7cGqKddf6uEDrwTwXaN+DcH4U99TL/w9G1e70hz0vrijBHtN3jQgMBUGdOwO2zGTOoXCJym0D2vEz+UmCSWseTCZuBndvB3Oy4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717591750; c=relaxed/simple;
	bh=I6p66dNXgWuYF0sjf76h4FVqcCSW0xhy5njB8QURPwg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKI2NazpnsBv672vgybqFD8vepkdWpfD2rA3+KVsGOEArayfr7r99GQdb8w+GDnJSNSw4xTwDzAOBP/cSRuFxY8QLMROkSbakLhcGfK+DanVkPT26XDyIKFsSnGpWLAqb/eur0yhErgXwzUUUp42QfXgrbbf/YkXJLO1EO/By1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MVdWRqOf; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 455Cn0pb006029;
	Wed, 5 Jun 2024 07:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717591740;
	bh=WbdIYS/knOJHqyX7310+VXzxm1AWii1EXvlI4FnfTaU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MVdWRqOfZxXrJK9LsZ7fbKBiKLpAOyk4f1tNXmveXZOeQQv0D5FlCy7oPSvTHgUwS
	 Q0onLgR0ZxoVE3DneGTqvTNMOutd2p/pjUNIhMz6zoAexfExNll3JOoBGaZyWYZfpC
	 xg6Pe64+CiYp5rZ+cksjQk3tl4wOqJV1yYqVlmeg=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 455Cn0Qs006777
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Jun 2024 07:49:00 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Jun 2024 07:49:00 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Jun 2024 07:49:00 -0500
Received: from localhost ([10.249.48.175])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 455Cn0kJ108867;
	Wed, 5 Jun 2024 07:49:00 -0500
From: Hari Nagalla <hnagalla@ti.com>
To: <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nm@ti.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v3 1/4] arm64: dts: k3-am62a-main: Add C7xv device node
Date: Wed, 5 Jun 2024 07:48:56 -0500
Message-ID: <20240605124859.3034-2-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240605124859.3034-1-hnagalla@ti.com>
References: <20240605124859.3034-1-hnagalla@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Jai Luthra <j-luthra@ti.com>

AM62A SoCs have a C7xv DSP subsystem with Analytics engine capability.
This subsystem is intended for deep learning purposes. Define the
device node for C7xv DSP.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index bf9c2d9c6439..0912cc31329c 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -1062,4 +1062,15 @@ vpu: video-codec@30210000 {
 		clocks = <&k3_clks 204 2>;
 		power-domains = <&k3_pds 204 TI_SCI_PD_EXCLUSIVE>;
 	};
+
+	c7x_0: dsp@7e000000 {
+		compatible = "ti,am62a-c7xv-dsp";
+		reg = <0x00 0x7e000000 0x00 0x00100000>;
+		reg-names = "l2sram";
+		ti,sci = <&dmsc>;
+		ti,sci-dev-id = <208>;
+		ti,sci-proc-ids = <0x04 0xff>;
+		resets = <&k3_reset 208 1>;
+		firmware-name = "am62a-c71_0-fw";
+	};
 };
-- 
2.34.1


