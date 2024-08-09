Return-Path: <linux-kernel+bounces-280479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A6394CB31
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43E9A1C20949
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88147175D2F;
	Fri,  9 Aug 2024 07:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IHORrpWS"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A631741D5;
	Fri,  9 Aug 2024 07:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188164; cv=none; b=nzb74v95ds/BNKpJ4WJ/kMFzxTYhprc+Vy2wqy5ErnvH5Zr6bBKWVdowx0eH+e0OR/uXLAZ3fNSeydnKgeKOqtH4PeE8YX+EGQn+ZdHnhst9XchAT+nTqR7NkLmdfChlcDyiLI4Zg9Jhmaz/NCmpyYvK8lxZZmXUbd7LJJDQvbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188164; c=relaxed/simple;
	bh=TuMqrgVIr8E9q9EsdFB9v+Jx0nSxfmCGPiIHOQEftz0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rM1D3w5Yw/vwqSekVLQLQlEyZTin4DTTJXjsHzT7e4rBKicrgNxWrJRvYeJRnh03Ea8fEfnIlrsqTidUbaTDYkRUwzSNFKgpmUyBd3UP1f1WOUp8a0CaXp8dUGIHozmSA/yt/xN2r13K+OX1SbwM4M1SdbUamBD4z9kGBrRvYCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IHORrpWS; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4797MXi1117657;
	Fri, 9 Aug 2024 02:22:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723188153;
	bh=ZG/0jB8mWL0o3rsWjfA5iA0GkrLkxAWfJWlNCkuR2Cc=;
	h=From:To:CC:Subject:Date;
	b=IHORrpWSviqSByHVC/JEoYJEwCQMCNDw9jS7+5tSYo/7IGeY5sSuoYmFnoomKJuOC
	 J+ypqHTlnRlrZp6v5/J4SdqptrhEPwo6+o0tyEq0dktp0yN66A42a7zBvceaO66tdl
	 G0vcjUxCC2IWA2yEGX8NU8NKT0scZK6XoB1ML8xc=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4797MWRY096737
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 Aug 2024 02:22:33 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 9
 Aug 2024 02:22:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 9 Aug 2024 02:22:32 -0500
Received: from localhost (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4797MVBf072002;
	Fri, 9 Aug 2024 02:22:32 -0500
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <b-kapoor@ti.com>, <m-chawdhry@ti.com>, <vigneshr@ti.com>, <nm@ti.com>,
        <sinthu.raja@ti.com>, <n-francis@ti.com>
Subject: [PATCH v2] arm64: dts: ti: k3-am68-sk-base-board: Add clklb pin mux for mmc1
Date: Fri, 9 Aug 2024 12:52:31 +0530
Message-ID: <20240809072231.2931206-1-b-kapoor@ti.com>
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

mmc1 is not functional and needs clock loopback so that it can
create sampling clock from this for high speed SDIO operations.
Thus, add clklb pin mux to get mmc1 working.

Fixes: a266c180b398 ("arm64: dts: ti: k3-am68-sk: Add support for AM68 SK base board")
Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
---

changelog v1->v2 : 
- updated the commit message for better explanation

link to v1 : https://lore.kernel.org/all/20240807101624.2713490-1-b-kapoor@ti.com/

Rebased to next-20240809

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


