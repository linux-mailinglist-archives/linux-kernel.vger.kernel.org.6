Return-Path: <linux-kernel+bounces-299692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BA895D8C1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 327A628376D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 21:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BD01C8705;
	Fri, 23 Aug 2024 21:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GQzB6KVb"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28AE1C8251;
	Fri, 23 Aug 2024 21:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724450092; cv=none; b=XwYwUw6Fqwlid9aCH/t/rmUsyFdX4zhfOlAXb4qvXzLQuacxX0Y90oN12NUlH33I/jj0jiL+4QoOVmrsE9mzsSSHqTgPhtx3dT7EYY4q9iv7w1Ex/eV/WRZlGDLCcqTizuH26pRdREnJiHyqgxYgJ11G3L7pzQGY7JDyj+wwccg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724450092; c=relaxed/simple;
	bh=bXpWBOVIv7fMozer63kJ8yepA9QERXkOsgPC03Pw0Ec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MfvslGxQOkTMpgaLGWy678QfzsPrcMnGPYZFGb5U1aFvBbqz8xZ6ssAA44uh4qCud01faLBnAMQwwr1hIp7BHoW09oOXaH3GkMumnkL/O7sDUAx6gqw2wFVUMO2wbQo9EiGzPtaayME0Fx2fbzodzlbqtP4YrWaH6A9rHFUuVrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GQzB6KVb; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47NLsarR036083;
	Fri, 23 Aug 2024 16:54:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724450076;
	bh=GRJC9SyS9QLJUTZdr4vYma9xz4pt8hEyFK2dYDEhi5k=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=GQzB6KVb2oxapzUCWfcLa1x+rXAbwlDWgRQmW/r6xR2sHTegHNgAahD5z7Q+g4Y6E
	 CGd1bGROW6UmcSLT+vlNUjb3GP9CNOqnKIZyyU1vmKsLqoAWPpw66U1xmVapIVXSo7
	 46N4XCXSS3gDsG3qWYNAwkwzhdOJqw/Cst7DrpO4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47NLsa2q000571
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Aug 2024 16:54:36 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 Aug 2024 16:54:35 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 Aug 2024 16:54:36 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47NLsaSN112989;
	Fri, 23 Aug 2024 16:54:36 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Fri, 23 Aug 2024 16:54:31 -0500
Subject: [PATCH v2 4/4] arm64: dts: ti: k3-am62p5-sk: add 1.4ghz opp entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240823-opp-v2-4-e2f67b37c299@ti.com>
References: <20240823-opp-v2-0-e2f67b37c299@ti.com>
In-Reply-To: <20240823-opp-v2-0-e2f67b37c299@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1016; i=bb@ti.com;
 h=from:subject:message-id; bh=bXpWBOVIv7fMozer63kJ8yepA9QERXkOsgPC03Pw0Ec=;
 b=owNCWmg5MUFZJlNZ3AXP6wAAYX///vbbH/X1rj/e8OXv38Hitv2+V3//De+n/L6r9jfX98WwA
 RswIepkAZNDRoepoADRoDQ00NAAAMjTRoAaGTQBoaNNGjRoMhppp6RoaaPQmT0mMmog0DINGmmg
 0xNNDQGh6EMGkaGjIaAaBoeo0ME0wCGJo0AGjAgYhpkAAAHIaMmmRppoaYQbU0DTTRpgEAGmRoP
 UDI0GQGJiGmARiAAaMEAAABoaYGDTAlFI48gLEgS3ciBclt4dvjQBfEEgQASG2OBhkSRAJN9AVh
 Jg1qMDN7wufW6mWTjA+IKUsEPuzr2iLS4LHntxlD6IMVGwCdH5wKifAVLg2vEgtIlpNeQb44Zcb
 ePvNUEKcD/4HRXdcDm/N4Hlu5Amd1yVW3TYwYPnWURMrCtU7a98AFIwBHpyDDpwMJAsXMO4PMUi
 BCDSz4E06eIW53bGRHCIrtSjnnhycCWYs/JKpv1iTYOrCPhDJtgTMsmIPFsKPlf2M8pyyemFh5Q
 YXpx0AASS0JNkvjpm2qt2ds/RGWW2TIR00kTrVLwpmek2weZU4QOxUYIcE/KZDhtXNPppMEz/b9
 uipUAgxThgLQyh/9IojQrkVXl+D+ZA5TPX8HhS0YPFvUjcOAhyDJIYUfDTUNUXCIQIocZcX4wN2
 B/D1v+LuSKcKEhuAuf1gA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The AM62Px reference board is capable of supplying 0v85 to the VDD_CORE
which allows the Cortex-A53s to operate at 1.4GHz according to chapter
6.6 of the SoC's data sheet[0] . Append the 1.4Ghz entry to the OPP
table to enable this frequency

[0] https://www.ti.com/lit/ds/symlink/am62p-q1.pdf

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index ff65955551a32..ab5d7a5fc6118 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -128,6 +128,15 @@ led-0 {
 		};
 	};
 
+	opp-table {
+		/* Requires VDD_CORE at 0v85 */
+		opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-supported-hw = <0x01 0x0004>;
+			clock-latency-ns = <6000000>;
+		};
+	};
+
 	tlv320_mclk: clk-0 {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";

-- 
2.45.2


