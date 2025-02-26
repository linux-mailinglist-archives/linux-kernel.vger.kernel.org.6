Return-Path: <linux-kernel+bounces-533584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE28A45C4F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6E81892400
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C79F2676F6;
	Wed, 26 Feb 2025 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YcUOE5w5"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38F524E00E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567358; cv=none; b=KPG6CrSUXkP8cYRhio+LGEfxA3drQkYXRFEb1xGo9aH+awqLL36gx/SxtjZT8USIiUBhkh5MTk14QhyGWxPr7GXSeNAn+ZRyxKOLn0ozgAwf83q0mKnnkqvcSc0UMprhx6VoSEvETyHhtJ9bKvh4g1pxCWylM7ViU2RWNBX+tP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567358; c=relaxed/simple;
	bh=hw4n8uJE0LcLADDBnJlFqcuib42uD/ho8CDkJ6P0W60=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fADUHnl1LSdafepuhHEkhO68P+lF+TqG+DtCHXS4P63HEAJtI/WYvs0oNa/ymLBmwy7Y133Oc44TFKu014+wf9b1dUm+ZRmNmP9XSw5pHHL31W5fIaM2uybBO7kLvqYw8W1n2cYxue5/K2Du9sVBnvtODIYkCfYuCvIguBeRFOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YcUOE5w5; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51QAjN2r1525492
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 04:45:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740566723;
	bh=sjX+tO2Pkybis8N/p9WpJQ8YymWnX6z/Zza9cSgrmoc=;
	h=From:To:CC:Subject:Date;
	b=YcUOE5w5qKcTrnKoP7Up9bzMlwYEtkiQBaR2vB/iRa59e0vTsmjT27bvFTFuI/NRV
	 4FLc5Uu9eYke/d+3c0d26geY+qRJm4Ljc/6aMYJrUlpgajaKMgNe0tk7AiRe+8sPNT
	 S+qsR6i117OMzkBzw3nhIZ43kQ7V0bSTMknClct4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51QAjNxg024798
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Feb 2025 04:45:23 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Feb 2025 04:45:22 -0600
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Feb 2025 04:45:23 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51QAjNrv075701;
	Wed, 26 Feb 2025 04:45:23 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 51QAjMY3014137;
	Wed, 26 Feb 2025 04:45:22 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: <elinor.montmasson@savoirfairelinux.com>, <javier.carrasco@wolfvision.net>,
        <ebiggers@google.com>, <biju.das.jz@bp.renesas.com>,
        <quic_tdas@quicinc.com>, <nfraprado@collabora.com>, <arnd@arndb.de>,
        <dmitry.baryshkov@linaro.org>, <krzysztof.kozlowski@linaro.org>,
        <geert+renesas@glider.be>, <quic_bjorande@quicinc.com>,
        <will@kernel.org>, <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>,
        <m-malladi@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>
Subject: [PATCH v2] arm64: defconfig: Enable HSR driver
Date: Wed, 26 Feb 2025 16:15:17 +0530
Message-ID: <20250226104517.1746190-1-m-malladi@ti.com>
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

Many of TI's K3 SoCs support multi port ethernet controller.
So enable HSR driver inorder to support this protocol on
such SoCs.

Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---

v1: https://lore.kernel.org/all/20240419060013.14909-1-r-gunasekaran@ti.com/

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


