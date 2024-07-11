Return-Path: <linux-kernel+bounces-249168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6203A92E7E2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB7228761E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DB115FCEB;
	Thu, 11 Jul 2024 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Cqy1HJFU"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E0A156C61
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720699309; cv=none; b=nk57hH74NJvUarW767iqVJU9d++TfsQzsvtRvrDgo+NKg8rHPpZCoG4K/mOtSSHf9n/1EdNMwSO1omZNwiRBkBPERP335QtnfiQWwTtwwivf6kUp8GgOBh+xVTJrhHbcEs1LaHpqTS1pH8Ubsiq+8GHwXlvtdEouOw6yLxdeuJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720699309; c=relaxed/simple;
	bh=YqvdRqli3JiPIPEXNQZ5ncC0zMSvrBCdwSmE95Mg5SI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rytb1C7hqGi0mqp9+nuIGYfJngU/DDVfj8nBie1F+h9lSbDVhOsOueVrWwIoQH2J8JxbVmSIRlnKOGWtItwhhJnTPlAeXWPfTl0wph85GbAWqAY3QVqt5ZHF1o4m1geTZ0zZ8wKn94CPPQcb7ekQNWp2LKkSj9gfEPg9vLushNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Cqy1HJFU; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BA6xNV013090;
	Thu, 11 Jul 2024 05:01:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=1Qoy7KYEQ9s+6+w6zmzcugv
	BQaIE9TKnoB8ckAHKCLc=; b=Cqy1HJFUGcI2XLfoBbsKNr2BzdbkajcDPznkWCA
	KZjpELyxgv5489zP7z1FRD8NHxaLP6axrrQduoNn6Qv8al1Hm9BKwSfd3C79w2iM
	hZXjl4J+4UkmaPicDc/dPIQx8kizhm1vx8aQoPFMmNQXhMJeti8G2NSCR0CvMvhx
	xc0YWbe8b7Lr5EbfjOVFJT9ZGt6SXb6PljrUApuk/XGAbt3BflR5PgujQvnNPfOk
	ZBZ6Gvtrh9s3rDy6QtW5V7zNWfbEuRIyy9qf8NznAa8qqrxwU/klkZCaBsLP5PK2
	jsYOi4kpjRfKQMAl4yplDDafAxMhI5iJl3almyPrgn1hogw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 40adbv09kn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 05:01:37 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 11 Jul 2024 05:01:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 11 Jul 2024 05:01:36 -0700
Received: from localhost.localdomain (unknown [10.28.36.156])
	by maili.marvell.com (Postfix) with ESMTP id A13F33F7040;
	Thu, 11 Jul 2024 05:01:34 -0700 (PDT)
From: Vamsi Attunuru <vattunuru@marvell.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <vattunuru@marvell.com>
Subject: [PATCH] misc: Kconfig: add a new dependency for MARVELL_CN10K_DPI
Date: Thu, 11 Jul 2024 05:01:15 -0700
Message-ID: <20240711120115.4069401-1-vattunuru@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: u-3Jof4d0rkGRqf5M8aMMpZWDN-K1ON1
X-Proofpoint-GUID: u-3Jof4d0rkGRqf5M8aMMpZWDN-K1ON1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_08,2024-07-11_01,2024-05-17_01

DPI hardware is an on-chip PCIe device on Marvell's arm64 SoC
platforms. As Arnd suggested, CN10K belongs to ARCH_THUNDER
lineage.

Patch makes mrvl_cn10k_dpi driver dependent on CONFIG_ARCH_THUNDER.

Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
---
 drivers/misc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 64fcca9e44d7..f3bb75384627 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -588,6 +588,7 @@ config NSM
 config MARVELL_CN10K_DPI
 	tristate "Octeon CN10K DPI driver"
 	depends on PCI
+	depends on ARCH_THUNDER || COMPILE_TEST
 	help
 	  Enables Octeon CN10K DMA packet interface (DPI) driver which
 	  intializes DPI hardware's physical function (PF) device's
-- 
2.25.1


