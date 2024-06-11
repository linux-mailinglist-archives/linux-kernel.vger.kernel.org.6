Return-Path: <linux-kernel+bounces-209820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A98E903B49
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548CE1C23261
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39D817D36C;
	Tue, 11 Jun 2024 11:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lAtvbDY5"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739CB17C7A2
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 11:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107133; cv=none; b=H3SwVRJGod850O8ZiIp3l3pKGOhc3zcpji/gNoCqYu/9gdeb8eLHWBeGSTE02CBP8wVeobBBfIb9iwPKMJOVMpZqoC2EczvrSd3eKSMcrY9lgqTseF8WJBQu2O5cKZjfyweVZFMbjG9AWeS5v7exGJtzdlMGZxv3G1JfQXbhJ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107133; c=relaxed/simple;
	bh=ldn8LUUtjwGIRVr7G7jJRAIBtTNkjEd0Un8CbsxrI0I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=abidvEvLiF485cb0qQsVmpxBv3TAe0pUvOqqsHI15nGwZT+S93WRKbJqGN1FNsvZtR0bR6kd7yk1eSqGU9vYjdA1c23Hjjl0iqWzEYdigHZuyMQ9eymI7cbODJJ8W+lMo/HPdfV2xY5fntA+YizCz7GtywvVsAfSJW352tK6ktE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lAtvbDY5; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45BBwR7I038176;
	Tue, 11 Jun 2024 06:58:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718107107;
	bh=ET59WQAv9RAVHKPtzswW57gWcdNRLaUt0oHMdCRcpYM=;
	h=From:To:CC:Subject:Date;
	b=lAtvbDY5XwBeRPacVuDxYlohsJ845Zj61y3ld80fb/xVTaLD6iU+SPhx4ZBAb/UpH
	 nTZfoo0YsQ51EA34LOV3ftI1HqJQIMsHQY2mTvMbGdNE9kXxAKjkQdDgv63iaf17IU
	 wQtlpNrUP/sHLuNi50/vLrnpTuCff91x2NIiedcM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45BBwQgT094732
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Jun 2024 06:58:26 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Jun 2024 06:58:26 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Jun 2024 06:58:26 -0500
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45BBwLpE065144;
	Tue, 11 Jun 2024 06:58:22 -0500
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <will@kernel.org>, <catalin.marinas@arm.com>
CC: <m.szyprowski@samsung.com>, <arnd@arndb.de>, <neil.armstrong@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski@linaro.org>, <geert+renesas@glider.be>,
        <quic_bjorande@quicinc.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nfraprado@collabora.com>,
        <u-kumar1@ti.com>, <vigneshr@ti.com>, <nm@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH] arm64: defconfig: Enable MTD support for Hyperbus
Date: Tue, 11 Jun 2024 17:28:20 +0530
Message-ID: <20240611115820.1269805-1-vaishnav.a@ti.com>
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

TI Jacinto 7 SoCs (J721E, J7200) have Hyperbus controllers present
which can be used to interface with Hyperflash and HyperRAM storage
devices. Enable the necessary configs for Hyperbus support within
the MTD subsystem and the specific Hyperbus controller as module.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

Tested on J721E EVM : https://gist.github.com/vaishnavachath/d8b2c6df43d8c809027d98087cdaa95f

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 05abba0a0209..dfe62d645648 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -281,6 +281,8 @@ CONFIG_MTD_NAND_FSL_IFC=y
 CONFIG_MTD_NAND_QCOM=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_MTD_UBI=m
+CONFIG_MTD_HYPERBUS=m
+CONFIG_HBMC_AM654=m
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=m
 CONFIG_VIRTIO_BLK=y
-- 
2.34.1


