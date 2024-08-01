Return-Path: <linux-kernel+bounces-271704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA1A945240
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC0228288B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1E91BBBD3;
	Thu,  1 Aug 2024 17:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X/o3df7Y"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6521B3742;
	Thu,  1 Aug 2024 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534616; cv=none; b=CChIoYlQ2Xu9fUa6iPQD5R4yZr/dU1TvDnUD6OLHMg46gnqItsBzwnmbuV1PSnVmXZFKdJEbYJGnCetgq2OFf116WP0rLDAPtiP2kpjNr+CXTc4a809r4jQUZ1nRnd+F8VwjSiW/hy0MczMUkiUwjWSnQit25942hDeuewInQ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534616; c=relaxed/simple;
	bh=tWD/L03iWpeXfuZYMTlShuelvT8w+fpQtRxUbtJPvmM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EqG3OMEfItQEyDkS8bmlbQGNv/uIOClk8gdySIwa0ZGjXuXDh5HwLbt/ZovcY+pCLV0wUL1NuBlfCdHTLdaWZzzsMGNcq8YElvIjF5xQsJZEpWdugkKfGwo6ECyvy7G0C7T1otz0GL9DsTt1fLHhhO/ARVtgBrDz6IkW6j+AvPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=X/o3df7Y; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 471Hnhis116293;
	Thu, 1 Aug 2024 12:49:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722534583;
	bh=WOCm1cOKCu8ByKrvt8eLtc/WTFMkmgVdarAvTRCMJ1o=;
	h=From:To:CC:Subject:Date;
	b=X/o3df7Yjac0ciiMuKzPoo/wRMpBUUvv86hWs23mVlXV8L0qa15uj+wFd3fbwGCS2
	 tOcNsrXxtAbuDeU7YRJ14w0kVMx0y2uu82uCKT3kjAIR6rCYsWgdcM+/FUP2cM303B
	 aGVVA1zhJ0rJin/FGpIMwJA5CH3wYDC1Dk6BtcN4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 471Hnhae001727
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Aug 2024 12:49:43 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Aug 2024 12:49:42 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Aug 2024 12:49:42 -0500
Received: from localhost.localdomain ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 471Hngkg067627;
	Thu, 1 Aug 2024 12:49:42 -0500
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Jonathan Humphreys <j-humphreys@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 0/4] K3 include entire FSS region in ranges
Date: Thu, 1 Aug 2024 12:49:37 -0500
Message-ID: <20240801174941.41002-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello all,

These add the full FSS region to the ranges properties. For Linux
currently this should cause no changes, but testing very welcome.
Software running on the R5 such as U-Boot makes more complete use
of the lower FSS data regions and needs these ranges.

Thanks,
Andrew

Andrew Davis (4):
  arm64: dts: ti: k3-am65: Include entire FSS region in ranges
  arm64: dts: ti: k3-j721e: Include entire FSS region in ranges
  arm64: dts: ti: k3-j721s2: Include entire FSS region in ranges
  arm64: dts: ti: k3-j784s4: Include entire FSS region in ranges

 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi          |  8 ++++----
 arch/arm64/boot/dts/ti/k3-am65.dtsi              | 13 ++++++-------
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi  | 14 +++++++++-----
 arch/arm64/boot/dts/ti/k3-j721e.dtsi             |  8 +++-----
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi |  4 ++--
 arch/arm64/boot/dts/ti/k3-j721s2.dtsi            |  8 +++-----
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 14 +++++++-------
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi            |  8 +++-----
 8 files changed, 37 insertions(+), 40 deletions(-)

-- 
2.39.2


