Return-Path: <linux-kernel+bounces-277717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9488294A53A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA59283520
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B731DD39A;
	Wed,  7 Aug 2024 10:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hkHQz2bR"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB53D1C9DC9;
	Wed,  7 Aug 2024 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723025795; cv=none; b=ULar2xLJfCQZbu077mhADqZ4+UnMDTpMmGTsvvJYhILV4UDO5blNHT4hVS+pvDMOd36q2zVFdbefyVHFDvX2dfEUGDIN3UD8rPORSMMhXDORuO2eTH2WusIJOkxvPgE6ubij5TNWzhywr2/wGivMHLM2QzbMh53c4VIXzQ9df7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723025795; c=relaxed/simple;
	bh=YfR2jY2qscMa1IgoTaT68V9oQ6uc3HWH7CZnaqqVT6w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aGMmj4ShqMd1hOVnNgIDgvrtiPzuQKS3ZZ3caIO4GvPBGIRmqJzCOMXXYri/o0NBqn8AgdEhSxa3uIYiQ8tXymVSICqG19igqMMlEjaUueuPUvn7xfcVWz7AHHvB+Mk1YSP8z6tM0QSERa8m13R6/YfdFjRGUUjER0It0vsVz28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hkHQz2bR; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 477AGQtc098345;
	Wed, 7 Aug 2024 05:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723025786;
	bh=jMbWo6iNh4Mauc1hFr13WYbvGFFAdwjRNSu0cDvnsf4=;
	h=From:To:CC:Subject:Date;
	b=hkHQz2bRJQnauPuejTgYs5mARGzPurx4cIm+dBjOQJ8Y0JJmCSQQe8oqu/NvVSw0O
	 4+GzxoYHsl7P86BOZTVK06VaHLb7bwyNA1dRWcXXv8Ti4OrBHEVdiQ0BzXajql50f5
	 /MCX99rvOxM9dbhxBY3boIonc7ZKzHDAKXqeeKw0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 477AGQgW005714
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 05:16:26 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 05:16:25 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 05:16:25 -0500
Received: from localhost (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 477AGPH0096649;
	Wed, 7 Aug 2024 05:16:25 -0500
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <b-kapoor@ti.com>, <m-chawdhry@ti.com>, <vigneshr@ti.com>, <nm@ti.com>,
        <sinthu.raja@ti.com>, <n-francis@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am68-sk-base-board: Add clklb pin mux for mmc1
Date: Wed, 7 Aug 2024 15:46:24 +0530
Message-ID: <20240807101624.2713490-1-b-kapoor@ti.com>
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

mmc1 was not functional since pin mux for clklb was not present.
Thus, add clklb pin mux to get MMC working.

Fixes: a266c180b398 ("arm64: dts: ti: k3-am68-sk: Add support for AM68 SK base board")
Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---

rebased to next-20240807

 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
index 90dbe31c5b81..d5ceab79536c 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
@@ -204,6 +204,7 @@ main_mmc1_pins_default: main-mmc1-default-pins {
 		pinctrl-single,pins = <
 			J721S2_IOPAD(0x104, PIN_INPUT, 0) /* (P23) MMC1_CLK */
 			J721S2_IOPAD(0x108, PIN_INPUT, 0) /* (N24) MMC1_CMD */
+			J721S2_IOPAD(0x100, PIN_INPUT, 0) /* (###) MMC1_CLKLB */
 			J721S2_IOPAD(0x0fc, PIN_INPUT, 0) /* (M23) MMC1_DAT0 */
 			J721S2_IOPAD(0x0f8, PIN_INPUT, 0) /* (P24) MMC1_DAT1 */
 			J721S2_IOPAD(0x0f4, PIN_INPUT, 0) /* (R24) MMC1_DAT2 */
-- 
2.34.1


