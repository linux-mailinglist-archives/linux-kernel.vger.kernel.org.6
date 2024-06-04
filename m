Return-Path: <linux-kernel+bounces-200368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0908FAF0A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FAAAB21444
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B089143860;
	Tue,  4 Jun 2024 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OJA7wlae"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDF115E97;
	Tue,  4 Jun 2024 09:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717494098; cv=none; b=N/vRHxBm48uHr/nFURqw7zuSzyWSM34N0FeFVhW8FDxOJCHXeeGyMFJtBNdsubPSKJPj1Iek2lvxf8oLO/k/aV/2LMhPbaWWKKL3OAR7CFEwZjUmDg5OWHiEwgbf8chvtJ+VIk8aQ2+3npCDxeKWDLFNfIeco/O3AklSQGetQ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717494098; c=relaxed/simple;
	bh=ZxQhKpsbLY4pPKXM71CVrzothjWL47SYEc5fGJ0P1KU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=N6HTaPiJ4gAEPLw23a862WtwXur73jAtc1pZ9VeDuIVutmpK5WE9btJmX7/SazJQi3Z34r0EDITHztd1x8JBTaR0lMChHrJfjztcoqbj6LaoTzCSE5kc1pDfsmACNdlfWCoroKO0J/+nmlkAOu4mABQB6oZ4FHrzcK3SBvMasn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OJA7wlae; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4549fRmV069641;
	Tue, 4 Jun 2024 04:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717494087;
	bh=zGnIUAY1XDQUTcsOHz75OoXXZY2ImQTC5Kh0K48rUSs=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=OJA7wlaew0jm0G+6M6HaViPFd5bxCtZIXW0aKWBoP7xH4eFt6qMspeg7CsjVggGbo
	 sln8kofZ4fDhlpr7mu+0AS1IE8JVZwISJPvJOzOhD7kNzZE/VHWjw6XM+arvM/tubQ
	 In5olgWT3ribVTWx8JV74XsmgRNbfkfA/zhNB2EU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4549fRFd024820
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Jun 2024 04:41:27 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jun 2024 04:41:27 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Jun 2024 04:41:27 -0500
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.116])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4549fQmO011712;
	Tue, 4 Jun 2024 04:41:27 -0500
From: Jai Luthra <j-luthra@ti.com>
Date: Tue, 4 Jun 2024 15:11:02 +0530
Subject: [PATCH 1/7] arm64: dts: ti: k3-am62x: Drop McASP AFIFOs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240604-mcasp_fifo_drop-v1-1-03ebe25f47db@ti.com>
References: <20240604-mcasp_fifo_drop-v1-0-03ebe25f47db@ti.com>
In-Reply-To: <20240604-mcasp_fifo_drop-v1-0-03ebe25f47db@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=807; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=ZxQhKpsbLY4pPKXM71CVrzothjWL47SYEc5fGJ0P1KU=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBmXuE9v7QpROa/rehJF0u407NSdnlpgDutQv4I2
 iSb1/MYOHaJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZl7hPQAKCRBD3pH5JJpx
 RZddD/9sibnNkrVm2P85x80eiwoI8iPR1nDGXrobNpzIGZJH2HJnSTTQZKwa54J9Pe/9iBs5oUl
 izjMFxUfNu6vGoI/m5QxY91HUVgRK916R9KclXtWrD7dtcdPM5KqLsk+mZ29hSiXXapSatz2Zsf
 43C5z0vWF8+XoPcGVm9iVSx5LV8GoDq1oUeny+7FjwAlKPCgsqYZpzEa/wUpD6BS3NYDn6DTlzG
 tnBOyQzFVvTqaitw/JAIFjS1ux0hbhE9cp0Hn++5XeY5e5GC5ly8DZmB4Mg6q4qriDjabhxZvFg
 ezaWnx4bEEYj4rlreyEu3sGPGpFcFQsYgBSzG7pVO3OsWZFcBcn+RqArYKaEc3VWdUPRKm+/+xU
 HJsw2T6Maa0mJSQksHUk4hKB0yeMeTEoAK9S5kRy0/DqyiNkS7W/gCc6vRNil6Lvp/4+ayjUVNP
 WQ0/Y14IV7W11uSFxmOPjymFmTOSSSSwsDX2r0Q9XZuuMwFWQNpvwCcNo+tOoFTTT8nKBJkDKrK
 yQNU/V0JjdBsx3sT4LnyPLZccXm4gqM81qqzk7Ofx5piNiDcJC9Jn7FQq+9vaMrpPU3ykXTUkpu
 uyUGmMkPFi+XjBuHEHWVPV8P3xLW3VXEWlJdfvUkOkeH//p5NZepuoLFMZiCIDFLwBi+NWBzrv6
 TcGNsfz4lmnn8Aw==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

McASP AFIFOs are not necessary with UDMA-P/BCDMA as there is buffering
on the DMA IP. Drop these for better audio latency.

Fixes: b94b43715e91 ("arm64: dts: ti: Enable audio on SK-AM62(-LP)")
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 3c45782ab2b7..07e739573d84 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -504,8 +504,8 @@ &mcasp1 {
 	       0 0 0 0
 	       0 0 0 0
 	>;
-	tx-num-evt = <32>;
-	rx-num-evt = <32>;
+	tx-num-evt = <0>;
+	rx-num-evt = <0>;
 };
 
 &dss {

-- 
2.43.0


