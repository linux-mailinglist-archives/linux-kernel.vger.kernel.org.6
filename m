Return-Path: <linux-kernel+bounces-177149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5898C3AD1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C640A2812EE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 05:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A699146006;
	Mon, 13 May 2024 05:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="BeEYIHlO"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B540A145FE5
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 05:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715576827; cv=fail; b=JIK15vUuBDTVQJRWEBwpotjMSE8UE4w72ZtKm0No71rZm7vJ9GCaVlYyM8gLotIZ/89da5J7Zvkt9Lq4qT7JOrTZKk4fyR5LNwZTMH7JvGzvPywfY+r8ZN/9BXXKw8DMHRLJ/fiAsiiNhpOdY2sHg2mHhmQqJr4zs+5Vi6cP4Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715576827; c=relaxed/simple;
	bh=Zfn64PcS4yPaWNK0gvJRBtwWnzQzowMeeApiIHsW8hc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hHfFnT3oP2bgwH4Dqo5x2b144ys4mlMQLNsIiTnTvw6Ba4yQT5B1RnIQygHET6NUSd+7wjPwV5vT7leRqwVAumYNW9PH/CbM27+YLcdvknJSjEY/fRloyqaRHhxpe+GJ5defLN7K2S4Z8i2DyCPsljhbmOKOIx4lvn7KhFhMf18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=BeEYIHlO; arc=fail smtp.client-ip=40.107.104.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMmyC9b3la2K6wnnLsulDC+Qn3dTxyjFql1qy5tZE9Qu9s6hE8pWAni30j9hWO5P4vNf/0CmiDQUlI/a3eZoOmcILREOYuv0Od5XBhRV/PZprLSebrQfuMRQx9nsRMuTbzATca0ks3c3Oy263rN4ssZatDZgRRXwwwLjubU6wMISz7pEzQZVKifd8RZapf17iOL+7TzucYiFjgWjVhz04umz2prNLV1i5qGRmDyqN8Is6o/1eI4wAo8/A/SORRtXFEhEYF+GX0OuEFmIVPyRHFo0G0AeOCogpw3TpRPhCmO1WPS6+X7YJm+lYAd/xtlwBz4RNVE5oW6fWtsy8drW9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4YCHX/ZfNYOF8s1odnacnwl2OXQMMIZKdB2IdHASTY=;
 b=Wx2GYLYHcPNvehAOZw/eXD3K4FJ8aqbzOIkwhb5oCdGNFvhPecbM+ij1xDlKVDK9+nxgd8XYvHSS5DyDUO0ef7wqLmvf9+K++pHDgiD2l0brpT3+dfb/v36NBFr3t62LWuvZIua73N1xSNqqiQWXr8ZC1NTH9Mjij4Q5jUU7Lrd8sO49XzesczPrej5B5AxKb/cqdjlkyzfebrJ3/57i/L7RAwEm9VeX/WeLNAaDTkP6rWnPN3aqGlRBGAsmg0mrLIn/QcmLiVnANj0R8wnc1Q8IWlY0t3+ASYMfh9Eg64Hmvh6WscLQt81qocxmxNnID+o4yWjEHPJVDMXvmRgJBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4YCHX/ZfNYOF8s1odnacnwl2OXQMMIZKdB2IdHASTY=;
 b=BeEYIHlOUVIJxCMbl858g+24YDMmiJ/8oLG0PpL5d7APQsOt2k/Z6bI5UUz0oqqLdeoBVAxUV4TLsnLb9GxROHTNFPApmR3aL5no+nTYPquiCPU8VCYfWATVbNj/0tuf2qbDPhrJDFrkzVroqWuLHCUvLtjaDaUXJiILxY+9O+GVBVHyRQsbC2xnV5dau0DmfxJbm+fTMKNQL8WOv7NbV8gciwmMXhLhg0O6r42PUmAyWYkw83VyqYm1/DBsaoOFV1sGOOjexqG5spRybJJZyBdcMjXY9PVuwyp8ui4S3RLb0vUtyzr74ZD1eDILzMjLlvM1oMCsZhRK7pW+t+u26Q==
Received: from DUZP191CA0040.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::18)
 by VI0PR10MB9032.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 05:07:00 +0000
Received: from DU6PEPF0000A7E0.eurprd02.prod.outlook.com
 (2603:10a6:10:4f8:cafe::8d) by DUZP191CA0040.outlook.office365.com
 (2603:10a6:10:4f8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Mon, 13 May 2024 05:06:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 DU6PEPF0000A7E0.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 05:06:59 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 13 May
 2024 07:06:48 +0200
Received: from HI7-C-0001H.de.bosch.com (10.139.217.196) by
 SI-EXCAS2000.de.bosch.com (10.139.217.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.37; Mon, 13 May 2024 07:06:48 +0200
From: Dirk Behme <dirk.behme@de.bosch.com>
To: <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <dirk.behme@de.bosch.com>, Rafael J Wysocki <rafael@kernel.org>, "Eugeniu
 Rosca" <eugeniu.rosca@bosch.com>,
	<syzbot+ffa8143439596313a85a@syzkaller.appspotmail.com>, Ashish Sangwan
	<a.sangwan@samsung.com>, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v2] drivers: core: synchronize really_probe() and dev_uevent()
Date: Mon, 13 May 2024 07:06:34 +0200
Message-ID: <20240513050634.3964461-1-dirk.behme@de.bosch.com>
X-Mailer: git-send-email 2.28.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E0:EE_|VI0PR10MB9032:EE_
X-MS-Office365-Filtering-Correlation-Id: c3e445e8-5104-41ab-c6ce-08dc730a84f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S2qdZ+XLIWJGVymEdnVF6B2DXJop0NEUiVkOCJYkZ/uwVN6JFxV+6NwasD1L?=
 =?us-ascii?Q?ggxwFe9S4MiLD37ys0QKTNCfrUMC3iEm5XYtz6hvip573gen3cR6XPkbNWGk?=
 =?us-ascii?Q?kYTQzaYnjPVCtns1cZKNZ2E233UNVd6avy+qXvHxjRKe3h/ekgLpG0b05xpg?=
 =?us-ascii?Q?86QJHxGDGzBgI+sNzj+CLCLTFIRptyQF06pbfu7CZa5gsCP2fx+nxjf7gPrA?=
 =?us-ascii?Q?J2AEuom21d8pJ2oxxaFPaxKQ/LkWtgnUJQQLjRBKz9gVSGiRDUJQ1j/t20Xy?=
 =?us-ascii?Q?YWopbBkg+dGM3/ACycAZiE4q3PJzV+g6uPcNv+GqoXAEHlxECz2OyI9xCpdW?=
 =?us-ascii?Q?LzVLhfV/mfA0NABk/hJ2RbOSO1tUYN3elWJSLbABAtxq+OAJMNitw8dlmgGi?=
 =?us-ascii?Q?sH8OW/LywCNYCYPHEOEQdUbW59MoUWThkfkCaXfQiB+QaHhIN9tEByNFu0+1?=
 =?us-ascii?Q?ELtwEsZpgQfD3DGDltlm7D0sxX6oYBvTs9sdQ7kDZ/SaHbonRMP3pw/YRtyI?=
 =?us-ascii?Q?EbsrIktDNBF4G8S/flSN4Q7hEbc+V4Le6mgG1z7lYV6fTpR62YG0PeDQMFK2?=
 =?us-ascii?Q?bYmE0R6bJ4iV+vMEP4sPx6DtXGv9rIbHvH3e8ovPlA2SL5h7WInXjUXUvmq1?=
 =?us-ascii?Q?cHIrR8w+c/Rf8iEyx3x7rwb56PMM5G6nwQD4hfa4YBDp2SWsftgkRjc9Qlcu?=
 =?us-ascii?Q?n6wgb5eNksEiEpsU32kDWwEtRjkxkJMcox/ofjdEs+i58lc9/vT6nSEHDDTq?=
 =?us-ascii?Q?nTxtbRAdGLlh6z6VGV3UQG5wmcOF3f21iPEGi3IH/1ekvaKdiZL0EyFN0ADv?=
 =?us-ascii?Q?P/MpLGA+QI+nRlS65dZ2Htf+3/T9D+8SdwHZlVK7+7jOkgwgBm+TSz2lI3uf?=
 =?us-ascii?Q?0plJ3g5/RqpFx82WRD5l10A4tdNM7lvjQkU2PsNOQlrqlaOEADoG3d5cr8w5?=
 =?us-ascii?Q?jIUjGDF5D0AyXeRt7jtdjXwBg0D64IKuAb5Qly4w6TMR8OJyYM51v5yN21LY?=
 =?us-ascii?Q?qqyCgboNWTRT5Nkqg+YBPdNRalfR6ZlUBIot0V71xNlPC2VY1jQbBW72MmSb?=
 =?us-ascii?Q?9uOhI+ZYk1g6djHR1sQeimB7/xv5sDoVSVpqZJvZsGn0+xyFOt7oyro6ISiI?=
 =?us-ascii?Q?KVepCYPMEX/tuWDIF74v7FbnZLq9wrO+rS2K9WzptphGE8HyT5oy/MgCuLkv?=
 =?us-ascii?Q?aclSjJbLIKTybicaLJwc78+9abTp0NCPh0ZoylFU5rQrXVfJaBz2pHXnKF7T?=
 =?us-ascii?Q?eC5sX4JwPWnZEOq7x1Z5JRjLTyEF3pKXXAppZi/ZzAJAUKKJ0lPilC4rvouF?=
 =?us-ascii?Q?qf8EIBz/Os0CaxRb8j8691wW?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 05:06:59.6659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e445e8-5104-41ab-c6ce-08dc730a84f9
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E0.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9032

Synchronize the dev->driver usage in really_probe() and dev_uevent().
These can run in different threads, what can result in the following
race condition for dev->driver uninitialization:

Thread #1:
==========

really_probe() {
..
probe_failed:
..
device_unbind_cleanup(dev) {
    ...
    dev->driver = NULL;   // <= Failed probe sets dev->driver to NULL
    ...
    }
..
}

Thread #2:
==========

dev_uevent() {
..
if (dev->driver)
      // If dev->driver is NULLed from really_probe() from here on,
      // after above check, the system crashes
      add_uevent_var(env, "DRIVER=%s", dev->driver->name);
..
}

really_probe() holds the lock, already. So nothing needs to be done
there. dev_uevent() is called with lock held, often, too. But not
always. What implies that we can't add any locking in dev_uevent()
itself. So fix this race by adding the lock to the non-protected
path. This is the path where above race is observed:

 dev_uevent+0x235/0x380
 uevent_show+0x10c/0x1f0  <= Add lock here
 dev_attr_show+0x3a/0xa0
 sysfs_kf_seq_show+0x17c/0x250
 kernfs_seq_show+0x7c/0x90
 seq_read_iter+0x2d7/0x940
 kernfs_fop_read_iter+0xc6/0x310
 vfs_read+0x5bc/0x6b0
 ksys_read+0xeb/0x1b0
 __x64_sys_read+0x42/0x50
 x64_sys_call+0x27ad/0x2d30
 do_syscall_64+0xcd/0x1d0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Similar cases are reported by syzkaller in

https://syzkaller.appspot.com/bug?extid=ffa8143439596313a85a

But these are regarding the *initialization* of dev->driver

dev->driver = drv;

As this switches dev->driver to non-NULL these reports can be considered
to be false-positives (which should be "fixed" by this commit, as well,
though).

The same issue was reported and tried to be fixed back in 2015 in

https://lore.kernel.org/lkml/1421259054-2574-1-git-send-email-a.sangwan@samsung.com/

already.

Fixes: 239378f16aa1 ("Driver core: add uevent vars for devices of a class")
Cc: syzbot+ffa8143439596313a85a@syzkaller.appspotmail.com
Cc: Ashish Sangwan <a.sangwan@samsung.com>,
Cc: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
Changes in v2: Use locking instead of READ_ONCE().

 drivers/base/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index b93f3c5716ae..e2a1dd015074 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2723,8 +2723,11 @@ static ssize_t uevent_show(struct device *dev, struct device_attribute *attr,
 	if (!env)
 		return -ENOMEM;
 
+	/* Synchronize with really_probe() */
+	device_lock(dev);
 	/* let the kset specific function add its keys */
 	retval = kset->uevent_ops->uevent(&dev->kobj, env);
+	device_unlock(dev);
 	if (retval)
 		goto out;
 
-- 
2.28.0


