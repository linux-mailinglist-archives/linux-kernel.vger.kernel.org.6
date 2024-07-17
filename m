Return-Path: <linux-kernel+bounces-255473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 870EF93412C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 19:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297101F2472A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C441822FA;
	Wed, 17 Jul 2024 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="UeoNRMKq"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F0E1822F4
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721236036; cv=none; b=QmVQARTxrdZoCufvbmmNULnfP74XdqqXbNS4t43M5l4uc7ZeqKtwMcbECBxqNkxboo3+iwI6l9/NlI/m3n39l179Zbqowfb84aC2xUXV7Prkwbsttvwa5xRyqVjoAaQTCaEvJRgunAyQxowVN5kukfMGjGxdKgfy09xLP7H5tlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721236036; c=relaxed/simple;
	bh=91+n6KFfNKvkNioNwUD7kJZ9YWFITtscuS5gveXlq8k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cEG9BCblXNdvpEcxl1OrAkrMNRX1lD9pnGICgku7cm2mp29rE9kwhoMMK2o3LW5Bn7UjdpwWXVKZUMpFWdXhCqz8POGPWTreuRhWUs3FtHfZp6TW7W0s7YcugA+59dDPyLI5JHNJ/nniXslQVsPkLBsvaBCazgbGpSkF7Cd/s6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=UeoNRMKq; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HEiRIO007627;
	Wed, 17 Jul 2024 09:37:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=/w9N6bVR/w5B2kQBXvbQ7jF
	J9MedEFmdeT9HpE1bW38=; b=UeoNRMKqz3Zd1MEsUFSPuzQK/kGX2s+Bw7DCr9k
	8jldBSnr3XlSBnYs/Vt9W4KDyAwwsydntc1ZsfOOXcNjEZ9oe2oty27FQdUcVDet
	mTsBJT/jx+Rl/USdPe4S80cO7OtdnBHQb/dVt7pPjvM4sB/JOlrdowZRj5KtAYEi
	f0bjL4Db0XpuUTwmCRysaOUzSmFmcFRrAeJgfoKQwEWT+R0X71jG+vsMdwapPFAO
	1Pbjc0dVB07A5Beo1oDceLhZaARvqL5ndSbrCZKJ9pts823PRzpWYWP5sKrGFpqX
	efIaaWurK25xAnYW0wJtpINOh/ATi18d1qaZQP/SDQAgNZA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 40efygrgmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 09:37:45 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 17 Jul 2024 09:37:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 17 Jul 2024 09:37:44 -0700
Received: from localhost.localdomain (unknown [10.28.36.156])
	by maili.marvell.com (Postfix) with ESMTP id 7395B3F7085;
	Wed, 17 Jul 2024 09:37:42 -0700 (PDT)
From: Vamsi Attunuru <vattunuru@marvell.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <nathan@kernel.org>,
        <quic_jjohnson@quicinc.com>, <vattunuru@marvell.com>
Subject: [PATCH] misc: Kconfig: exclude mrvl-cn10k-dpi compilation for 32-bit systems
Date: Wed, 17 Jul 2024 09:37:39 -0700
Message-ID: <20240717163739.181236-1-vattunuru@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: wswJ8QPeTFUeH0orTXx_KveJJC2kfioO
X-Proofpoint-ORIG-GUID: wswJ8QPeTFUeH0orTXx_KveJJC2kfioO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_13,2024-07-17_02,2024-05-17_01

Upon adding CONFIG_ARCH_THUNDER & CONFIG_COMPILE_TEST dependency,
compilation errors arise on 32-bit ARM with writeq() & readq() calls
which are used for accessing 64-bit values.

Since DPI hardware only works with 64-bit register accesses, using
CONFIG_64BIT dependency to skip compilation on 32-bit systems.

Fixes: a5e43e2d202d ("misc: Kconfig: add a new dependency for MARVELL_CN10K_DPI")
Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/misc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index f3bb75384627..41c3d2821a78 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -588,7 +588,7 @@ config NSM
 config MARVELL_CN10K_DPI
 	tristate "Octeon CN10K DPI driver"
 	depends on PCI
-	depends on ARCH_THUNDER || COMPILE_TEST
+	depends on ARCH_THUNDER || (COMPILE_TEST && 64BIT)
 	help
 	  Enables Octeon CN10K DMA packet interface (DPI) driver which
 	  intializes DPI hardware's physical function (PF) device's
-- 
2.25.1


