Return-Path: <linux-kernel+bounces-276962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE44949A78
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F08071C21082
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0458170A1C;
	Tue,  6 Aug 2024 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c/5RBt5I"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A38154C11;
	Tue,  6 Aug 2024 21:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722980773; cv=none; b=q4+A7Lt26VOhAb2JyI+y98dp+mwKzRbbNseTMTZr66jYkOa6IriJP9yWyX98HVrc3rjiy4F55LbnXkKm8B7P2GoME8WlUgqBNEWWw2m5ROQFvGrblMczYq5B/pkjP/3UxkG7qEIjvele7LoeyRcKNWp9aNF5kZxPAvuquorKNxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722980773; c=relaxed/simple;
	bh=ynJqiBaS1s9niAG2Sq1clPH+IvaufZCslC+UojQJrLk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S07ftWjpWMs93ii6CW6Whe6mt/n2+qDfDalx81/xOY3SyJHjXxw6bjz9QCZUPPuBaMHYxa70lkjlBZzUMgdpx93sX5+TeD391OuGaKVEtjnDP65BBeTzSKgxWlOcOZ2KFjXwlPOBuQRZlLFNDh5/Aqs2IHBODB3X99rrnbPKD9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=c/5RBt5I; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 476Lk5c4028458;
	Tue, 6 Aug 2024 16:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722980765;
	bh=F29SuFOs4OQfOAOJ4YsJ6xYZwxPOwouKUX/XoB9AI3I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=c/5RBt5IwLC1Xl8ADP+AqWd4qRvBBMEJaLKgX3y9u8fHHcED0UT31PG78VjwBPq0J
	 8DNXgS8pPFEkkcY0ISvMAN7VWxGGPFYm8Ysqee/k8OggWH9ZOjmw3FgJelT+bIjTUC
	 cFKArzo0D8/5uVoKZ0iMRi96Y4f1iKIG4INaO1rs=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 476Lk57o024473
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Aug 2024 16:46:05 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Aug 2024 16:46:05 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Aug 2024 16:46:05 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 476Lk5Qr100327;
	Tue, 6 Aug 2024 16:46:05 -0500
From: Judith Mendez <jm@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Santhosh Kumar <s-k6@ti.com>,
        Bryan Brattlof
	<bb@ti.com>
Subject: [PATCH 2/5] arm64: dts: ti: k3-am62p: Fix ESM interrupt sources
Date: Tue, 6 Aug 2024 16:46:01 -0500
Message-ID: <20240806214605.3379881-3-jm@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806214605.3379881-1-jm@ti.com>
References: <20240806214605.3379881-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Fix interrupt sources routed to the ESM0 as per [0], in
10.4.7 ESM0_INTERRUPT_MAP.

[0] https://www.ti.com/lit/ug/spruj83/spruj83.pdf

Fixes: b5080c7c1f7e ("arm64: dts: ti: k3-am62p: Add nodes for more IPs")
Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
index 9701fc69aed94..dc401290f13dd 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
@@ -260,7 +260,7 @@ main_pmx0: pinctrl@f4000 {
 	main_esm: esm@420000 {
 		compatible = "ti,j721e-esm";
 		reg = <0x00 0x420000 0x00 0x1000>;
-		ti,esm-pins = <160>, <161>, <162>, <163>, <177>, <178>;
+		ti,esm-pins = <224>, <225>, <227>, <241>, <242>, <248>;
 		bootph-pre-ram;
 	};
 
-- 
2.45.2


