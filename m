Return-Path: <linux-kernel+bounces-536134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 658EAA47BE1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBEF33AC66C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFBB225761;
	Thu, 27 Feb 2025 11:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="p2tATMt1"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4CE1DDD1
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 11:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655148; cv=none; b=XZqMH6JlssUWm+q3DJQrFiBJ6nmTUw3jSmILZQw9uEtaao7Hr71uSHR9rG/qbq49wWVajsNByvJlTs7ptDxA/LnqWPgqg3CXMfuK1Eyt9QjKiPqoipsoqYz/iHDA1KZxwJSC7dXCYk67TqkUgZfo1shjlo5Q+r5XtKz3mla0FpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655148; c=relaxed/simple;
	bh=NIwFFDOAtdX58sQ97P6BSld3PtgQ98AR5jSSXK5q7+c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KQEWp3lyjQ1hf+hOeRJaLzQhz8RhLqa4e4i+57YkmleEUBwoe1PF3PL5oiAQDfJYaxD7ZC0E1Mepic/jaeByT1x2naTK7GgqnTMN2Rnq5ZWexELRwfdLJWpCEUPIULMJfgzIRRZAAkvXsLtu1MmrMIRN67XA3rqrrFLIHcqF/Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=p2tATMt1; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51RBIWRP1834296
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 27 Feb 2025 05:18:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740655112;
	bh=/f1+cKU/M6viXrFzxbb0gMnMZp69UChBgNjg7xw4xl4=;
	h=From:To:CC:Subject:Date;
	b=p2tATMt1RtiEGIdVk6HVWi8ZIxBw10QYRerhpww1z5+OpM9HR80QDvJ/R68LmKixq
	 6+4f3nGtgXRjcYR62W2OVncfyd/bXvMpYVuVuEzUdmzePiUCHbIH6tCKZuKC9Izb6a
	 zJ+SenFDasTAojf5lNxYCT6FXh36gmsS6ns4D7Po=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51RBIWjN066956;
	Thu, 27 Feb 2025 05:18:32 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Feb 2025 05:18:31 -0600
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Feb 2025 05:18:31 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51RBIVTi071024;
	Thu, 27 Feb 2025 05:18:31 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 51RBIUKU027731;
	Thu, 27 Feb 2025 05:18:31 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <ebiggers@google.com>, <javier.carrasco@wolfvision.net>,
        <elinor.montmasson@savoirfairelinux.com>, <biju.das.jz@bp.renesas.com>,
        <quic_tdas@quicinc.com>, <nfraprado@collabora.com>, <arnd@arndb.de>,
        <dmitry.baryshkov@linaro.org>, <krzysztof.kozlowski@linaro.org>,
        <geert+renesas@glider.be>, <quic_bjorande@quicinc.com>,
        <will@kernel.org>, <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>,
        <m-malladi@ti.com>, "Ravi
 Gunasekaran" <r-gunasekaran@ti.com>
Subject: [PATCH v3] arm64: defconfig: Enable HSR driver
Date: Thu, 27 Feb 2025 16:48:28 +0530
Message-ID: <20250227111828.1963918-1-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Ravi Gunasekaran <r-gunasekaran@ti.com>

HSR is a redundancy protocol that can be realized with any
two port ethernet controller.

Many of TI's K3 SoCs such as AM64x and AM65x support multi port ethernet
controller. So enable HSR driver inorder to support this protocol for
these SoCs.

Currently HSR is supported on AM654x-EVM and AM64xx-EVM.

Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
Reviewed-by: MD Danish Anwar <danishanwar@ti.com>
---

v2: https://lore.kernel.org/all/20250226104517.1746190-1-m-malladi@ti.com/

v3-v2:
- Mention which TI SoCs are benefited by this defconfig
- Collected RB tag from MD Danish Anwar <danishanwar@ti.com>

v2-v1:
- Rebase to the latest tip
- Included TI specific maintainers in 'to'

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c3df5120b23d..f3afc0ec68f0 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -177,6 +177,7 @@ CONFIG_NET_CLS_FLOWER=m
 CONFIG_NET_CLS_ACT=y
 CONFIG_NET_ACT_GACT=m
 CONFIG_NET_ACT_MIRRED=m
+CONFIG_HSR=m
 CONFIG_NET_ACT_GATE=m
 CONFIG_QRTR_SMD=m
 CONFIG_QRTR_TUN=m

base-commit: 8433c776e1eb1371f5cd40b5fd3a61f9c7b7f3ad
-- 
2.43.0


