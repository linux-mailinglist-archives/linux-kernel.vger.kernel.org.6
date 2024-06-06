Return-Path: <linux-kernel+bounces-203798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDE78FE099
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40844B23C64
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEFF13C695;
	Thu,  6 Jun 2024 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="I8DDZcSz"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBDA13BC02;
	Thu,  6 Jun 2024 08:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717661366; cv=none; b=et5jE39mLUrF1rObMX5wNUKvEgqqJgIoEYBhdsc8ouMSZtdociv3a1F1qs72BUYUSwM0/2LqYyxfL3ZFSOuTHyimrnyIHg336QtlUWS3Wd82U5vipECGFhk++M4z2oFmSWvns2I0FH3xiLXue5OaOnkg3K8Xjkc6XVOjYJCS5VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717661366; c=relaxed/simple;
	bh=qY3umndjmRrvxBhSXT55EnaF4v5P37KrMJPjNpJppPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=l1deifwZ3F8Kty1NbcGsrdVX7ISLqJIr3IYo561gcx2NhzSVogv3tgzmHxOHnkePmCMuOt3/nKzjN8qvVkwCaH2RD7Ge2+3UNaKYhBuXCxD4MZj4LB5q3i5BAFAzLTuxvuxX1uAh54eo3y60JvrJmTlPDyRHuy7xcaaSP7PVo+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=I8DDZcSz; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45689FLW089379;
	Thu, 6 Jun 2024 03:09:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717661355;
	bh=/SU6m88tf4FLwkWgwPQaXDiFZTJzDWwX7r/95gmzv9M=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=I8DDZcSzgKQ+GCj2z60+EvIPfJRxrUgcv4WAw2DFCGDQD5quNK/doCijZoO6WMhLG
	 Jyebw/kpoSZimbJc6eU1y8eNMj6l2c6AhHLJgTx0akCMeLnEpfn0OWEtiHhraMgIaV
	 xlnyvJog971wF5SMDkz19y99+bPKDyOoZ/xf9I34=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45689FLL016084
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Jun 2024 03:09:15 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 6
 Jun 2024 03:09:15 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 6 Jun 2024 03:09:15 -0500
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.116])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45689EL3072679;
	Thu, 6 Jun 2024 03:09:14 -0500
From: Jai Luthra <j-luthra@ti.com>
Date: Thu, 6 Jun 2024 13:37:42 +0530
Subject: [PATCH v2 3/7] arm64: dts: ti: k3-am62p5: Drop McASP AFIFOs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240606-mcasp_fifo_drop-v2-3-8c317dabdd0a@ti.com>
References: <20240606-mcasp_fifo_drop-v2-0-8c317dabdd0a@ti.com>
In-Reply-To: <20240606-mcasp_fifo_drop-v2-0-8c317dabdd0a@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jayesh
 Choudhary <j-choudhary@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>, Bryan
 Brattlof <bb@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Francesco Dolcini
	<francesco.dolcini@toradex.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra
	<j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

McASP AFIFOs are not necessary with UDMA-P/BCDMA as there is buffering
on the DMA IP. Drop these for better audio latency.

Fixes: c00504ea42c0 ("arm64: dts: ti: k3-am62p5-sk: Updates for SK EVM")
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index 6e7234659111..78d4d44e8bd4 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -549,8 +549,6 @@ &mcasp1 {
 	       0 0 0 0
 	       0 0 0 0
 	>;
-	tx-num-evt = <32>;
-	rx-num-evt = <32>;
 };
 
 &fss {

-- 
2.43.0


