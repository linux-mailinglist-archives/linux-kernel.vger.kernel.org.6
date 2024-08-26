Return-Path: <linux-kernel+bounces-302018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CA095F8C3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3985281D7B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930DF1991C6;
	Mon, 26 Aug 2024 18:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Gp9pcWAV"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076221990DD;
	Mon, 26 Aug 2024 18:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724695680; cv=none; b=pMuhFJ/Zr143eJ8HHAlSDMc0ifhnf7xplQWvu1z+7MWtK9yYmQZE0b3OP6gT6T9eCS5Sp1r0up0vzk/Yq0hqbw1M84230HvYBsZFTV18JnW9kZu7JRbyMjDal9w8ogSBmWwoczZvGaJaY1aoZhTTvelCWTRlw1q8h456TXjkc18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724695680; c=relaxed/simple;
	bh=Er/2jR/5Jz557dqMgAoXj6xbxU6wZWuzU9zvcQxRlKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=tvnGhHj85S5kLHrIpVMHntQyKU1S9Mcw0vKFlCk++JTmi3bnPZW/t6mMrWgP+y+RyU8j40s9Ly/+6w5Y0JoAqD2Yu09AL4F4cGTWjVXTeHwo+0pSl+PzUlYoMBfGus2IP19m0nW5vDVjnrnvq0e/e0CPd7XUMkF5QnaU5Wk/P9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Gp9pcWAV; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QI7qmj077456;
	Mon, 26 Aug 2024 13:07:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724695672;
	bh=aKOhReHhfkFqY/b6mLNIi1grS6Sxo6McapeRea5WrKw=;
	h=From:Date:Subject:To:CC;
	b=Gp9pcWAVBNUiW9TRsMbxx3kMHEWhi+A9KRnUHPwU+bLALVSiRwSQQq0X/EBAJmNRt
	 MLNTjmhZPmvSsKK0TEOxy0go20narWai6WpLjfrjqrb2gGwLp1yCpK0xzaxwJhKeg5
	 9tWHQy+b7iHuqX5EvTmvEIHiNUFazVZWdqOTNSMo=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QI7q7g025084
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 13:07:52 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 13:07:52 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 13:07:52 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QI7qV6046687;
	Mon, 26 Aug 2024 13:07:52 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Mon, 26 Aug 2024 13:07:48 -0500
Subject: [PATCH] arm64: dts: ti: k3-am62p5-sk: Remove CTS/RTS from
 wkup_uart0 pinctrl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240826-am62p-v1-1-b713b48628d1@ti.com>
X-B4-Tracking: v=1; b=H4sIAHPEzGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCyNj3cRcM6MCXVNzQ+PENMNkS+NUAyWg2oKi1LTMCrA50bG1tQBnLos
 +VwAAAA==
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vibhore Vardhan <vibhore@ti.com>,
        Bryan
 Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1157; i=bb@ti.com;
 h=from:subject:message-id; bh=E4YxGbjfEXXJZ1nzZfL5G0JK0+K3hJsoTdQGfMm3r/k=;
 b=owNCWmg5MUFZJlNZImlXeQAAaX///vfp/2Vt6N/9zzMUf//W9PX/bv7eqc9/xO5u/plPn++wA
 RswGRAaGg0DRoDTQDQaNABiAA00NA0yABhGgBo0xAaDIDTJo0eptTJp6gyemk8odA00Mho0GEDI
 DQBpgmmTQaZDQNNAANGg2iYINNMNIGg0NDIDQZHqNAMjTCBpgmmjJoyYgMmjIGTJiZDIaaZAMIZ
 NAaMQYgYjTJhAaAGQGCAAyADQBA3gZCG+h4VYDESgmExZxipILv3B3+T7wgcKjp3NquiPAJhOgK
 BZRckMv+aF3xGwVUmEM+6ASF4EWzvGU55Sz5kmCO5qL2SwJsMkauP1G/y2r3h6rCC5e7dKaX14K
 d+BYz2eawGwZMDJs4kAJyl4uOPModYpBKZTZxhLORfaOmj5aJx+cGgC0rZUFKu78tHGi6tgYbtN
 w6f25x12kWMOy5zYJuRecLZ58L4JwVWqCRluxxvfsrOroqE5NMLGTJYPHay+GOxuXJ4G3scE589
 Y7bzC8psL0ZBxZRwTwFvsIkIbqxCnRIngSwFhpPdhqGeVPmTmwdHxihJ7CbylGKBVVYocHXzQAi
 aIGRikLwilhiDtR6nEGmtQtGYi8c0CAASuooq/MBDph6Z0P4fiUpFz4uzGHhUq7wuCE6gjxrtXe
 qhB+D7/xdyRThQkCJpV3kA=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Vibhore Vardhan <vibhore@ti.com>

wkup_uart0 is a reserved node that is used by Device Manager firmware.
Enabling pinctrl for CTS and RTS breaks the wakeup functionality of
wkup_uart0. Hence they have been dropped.

Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index ff65955551a32..3efa12bb72546 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -645,8 +645,6 @@ &mcu_pmx0 {
 
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
 		pinctrl-single,pins = <
-			AM62PX_MCU_IOPAD(0x02c, PIN_INPUT, 0)	/* (C7) WKUP_UART0_CTSn */
-			AM62PX_MCU_IOPAD(0x030, PIN_OUTPUT, 0)	/* (C6) WKUP_UART0_RTSn */
 			AM62PX_MCU_IOPAD(0x024, PIN_INPUT, 0)	/* (D8) WKUP_UART0_RXD */
 			AM62PX_MCU_IOPAD(0x028, PIN_OUTPUT, 0)	/* (D7) WKUP_UART0_TXD */
 		>;

---
base-commit: 182a862560097dec7adf774af58076984cd6c1ed
change-id: 20240823-am62p-5713af1c93e0

Best regards,
-- 
Bryan Brattlof <bb@ti.com>


