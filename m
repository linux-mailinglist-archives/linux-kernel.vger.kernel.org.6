Return-Path: <linux-kernel+bounces-277311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E111949F23
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44BC52884C2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAEB18FDAC;
	Wed,  7 Aug 2024 05:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VGgmofdx"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA9919645D
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 05:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723008314; cv=fail; b=KidGSMIEBCM87D/5c370O1SIYJmH+7n9LOohJmN0EmspOmpw9A9lY1dw4nssMtaH2tBNi1Fx34OCnDDK38ClNuYxcqpCZA5VEKPWPDbGoVNiKtcp+PrV3EHZVu3sGSUv42UI4z00WYx1QwAyFClfGcz+3lBVKko/wWL0CiW6Ugs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723008314; c=relaxed/simple;
	bh=QBMh9an0fCLXBuou/znW/QF2RUyflTvMYJe9JSFGAdQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WBwpyBjnHcchJrZvuMDxMau/S0bawEoKzmNrTz8QTd2UDpu5GcJcsmywPqTpQJQoOcjLq8AKs9VcusD7hII2PyAF2swPNwQNtfWqJWdGdBz8zxH26cCx/dHMilRD393dsGveS172B7lFRE7zbGipQQmF2d7bzTd4gvIQFiJC0R0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VGgmofdx; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSmM+/vdgRtDc05QlncWFgHEeYBZu1jySL/Gv8fGRzwJ1JAQvbUYyEEaMzqfIzeI6rE+hMWDXmHRQarF1wzmfv8rS8rzgKXtjbM2csTGuP5a8V9cNQ36yxvTezwVh2Qj5OeN5CCCyd3SjlNgJ7LGZSxenuzxO1Ar5KMk+EvNHmocAVPF0ziC+BEz3qDCq8mx4QpZkOKXOJPPkZN8mdNkmVBsdHN8osvLrE6XZXdwfF4Kt+R9c/9DfsncCFRo2nxMVRbfcWHGKnHUMas7FqI/nc78+E/YM28Dn6WnAAbyqLEI7PaXUc7zm7pEsPc5RVPYzboqy2SwJPC0UeVx2JhZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOpki+0hB0pDem5UKHVYya5yl2YgcYYMn8pPtyj23yg=;
 b=tl1UscPcVjwnKXCILVuznYKMkOTVRGFtjPhxJlase0KdzLWD92YWVQaOYHt49XGw2KR/u2lxq28JZ5AvJ6i2eevuR0wRs398wVPlkjzSGulqdsxJCO06BgMGo8oBuLGWn1ldmXs++VJfi2C31YCRLg4eoEp+87CpZEETYA1xZLTk5JkW0rTd2la346sTTonp1x2TROMnI5vE/dZbudp8d7C5LGicQZT6cBT8wvHa7Pv0Y4eUDtogQi5lXHaOGGAqh94fCCijX95BcFLmrNiko7YSBGALFnDRM8Bq1oPEc7k8JaaLAaxe9Buv6nEWskbCR+sEBF+A6+lQ752MQvVkrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOpki+0hB0pDem5UKHVYya5yl2YgcYYMn8pPtyj23yg=;
 b=VGgmofdxokwekMLRjLMexRSEJ1buoafFkdNZh8ORv0gUtKUpCY8TNt2QVzrnYYRlDB7s32gXXd8GCxdhHsYIzSzNBEv6gGadmsAjtZv3L+/j4CfKQX82Qlm5GlNFaoCj7B8RR/4odaBTHfyfBQ9kWyM0VDu5iDK/72VcQxvMi+4=
Received: from SA0PR12CA0016.namprd12.prod.outlook.com (2603:10b6:806:6f::21)
 by IA1PR12MB6481.namprd12.prod.outlook.com (2603:10b6:208:3aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 05:25:06 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:6f:cafe::68) by SA0PR12CA0016.outlook.office365.com
 (2603:10b6:806:6f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23 via Frontend
 Transport; Wed, 7 Aug 2024 05:25:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 7 Aug 2024 05:25:05 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 00:25:01 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH RESEND v3 4/6] i3c: mipi-i3c-hci: Relocate helper macros to HCI header file
Date: Wed, 7 Aug 2024 10:53:57 +0530
Message-ID: <20240807052359.290046-5-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240807052359.290046-1-Shyam-sundar.S-k@amd.com>
References: <20240807052359.290046-1-Shyam-sundar.S-k@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|IA1PR12MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c66945-16fa-41be-393e-08dcb6a14be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RKM8DQhkGIB0Mul2SpnjMe9vbxv0s1oWSY3hGgd6iGFYV9srrFojH+Xb0n7D?=
 =?us-ascii?Q?Tg77VIXdvEkRybYDItcANQshvLzQDmIFV+qSQMOoRi0wYUV7GVO8vsyKeO6R?=
 =?us-ascii?Q?uJmY808M6Tg36UqdqBQ4XUg1UJKswq4pVtebg7hszDew7O30r2U0rK7DgzOr?=
 =?us-ascii?Q?h8fznKlFe/icNkHd39f0k5PGw7YjnOSrY1muZ4r3w+uzxZNw99eE0O3+//Sq?=
 =?us-ascii?Q?UiSrPhPqyMsLL6j2+Cn/sUZPOz8xjmdwTOB+lBTTt8L9lR+m4bn58NeswanN?=
 =?us-ascii?Q?KGnFhiFbh6i2GyhStHiLO9jnwUDo/m7EeeOdwlw9xT2WF0wureQ/Yp77/OKG?=
 =?us-ascii?Q?dR8SHV2twcSwssUYPHxheTTf4UqNNKCUtm23VeSe8H3wCI8gj+wxxfSalBCM?=
 =?us-ascii?Q?f8iKqIeWxQK7cKLNIdcRLyOpw8RJLC+n7VN3JHmU/AouLNJ9k2rA1xOj1uJ/?=
 =?us-ascii?Q?rgiWuNgthKaRvNEfwYlvPl9ytSJM1hYtgs76LxAVeAUGjSYUZOjEWGlLWJpW?=
 =?us-ascii?Q?Qw0jZiYkpzrvOrnlUOLExDxvQr3HRDxYmgK0orGvdRJyOirfNXq6zZfF0VhA?=
 =?us-ascii?Q?UgoRzAxao7OxAEaPQbLf2yMuGvaOg/LE9GCakS9sv2RHACXa5WvLbhsiQyZU?=
 =?us-ascii?Q?ER5nl6N6+W6dw7ax6npxVtvdPeDhjeDXlGuEUanv/19D85fjZyxuRZoQwkcV?=
 =?us-ascii?Q?wzS8/ABtzOLzNbhd3vny1ouCoweAXgtq6L9gVFxvDan7bu2Mobn9rYaox6Ay?=
 =?us-ascii?Q?BCrW5KrjDCibaRSxWgQam1+oVPK2zymrfeT3hfHVlHmUQH4DsnCzrq/Gpc+A?=
 =?us-ascii?Q?MO80ZiL2wKUuHB1znJPn4McHbFYY+ebqf06OkdAJLPMrcW/mVNLi7OztunR9?=
 =?us-ascii?Q?llATmvCI1mY0is4IpoPzt9WfwbKCTa74zbErDAuSIKjxZJ5/BkJzZ0ryalRt?=
 =?us-ascii?Q?6yhtCowltUOlOmJ8zrpVVxnlgVzboiKirHRyni9E7FAv57t7o2SASggbzS/2?=
 =?us-ascii?Q?MJTgs/QlW3Vwfiu4ouWUtOx4d0XFbj272ZduteY9nTOKam4ipPmeqED3uMsx?=
 =?us-ascii?Q?TruzqDt6g2zcTHnuK3Nt4ZTJV8Bc2ku3sFkHOWMKnsFw8sFFTHmc/sSJoJow?=
 =?us-ascii?Q?kjjGKXKN6RQrgNY8BxN9yWRLfeuGQ86Yi4mPtYlowaGgv+LXcU6ECKST3xvW?=
 =?us-ascii?Q?ulF1z3IyNiWjYvJDBhrzP3MeyAdAVMx3G4Clt81zbeN+/lefu+WPFEFjti4j?=
 =?us-ascii?Q?zk8/6PhDRrMFzdhOTfJMJ5v65JwZTtWkzOFTPxT45aMifGl0FxTYrfc473Dc?=
 =?us-ascii?Q?jCvhM+HPIdQ80wgIv+i49EUBinQx1YiwE4ZJL2tMLtGOL2faw7Oxx/vmNTPD?=
 =?us-ascii?Q?cnoHKhxBVGrF7d4g8NlFFIu9curCY6vAe7A5mZtlyKDiTjHUGI5Okz/GU78D?=
 =?us-ascii?Q?IopztZlkEKAZJs3D6uAYb3k+BXH/3UFD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 05:25:05.8068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c66945-16fa-41be-393e-08dcb6a14be4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6481

The reg_* helper macros are currently limited to core.c. Moving them to
hci.h will allow their functionality to be utilized in other files outside
of core.c.

Co-developed-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/i3c/master/mipi-i3c-hci/core.c | 6 ------
 drivers/i3c/master/mipi-i3c-hci/hci.h  | 5 +++++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index 4926fde6087d..0dbaa1333a0c 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -12,7 +12,6 @@
 #include <linux/errno.h>
 #include <linux/i3c/master.h>
 #include <linux/interrupt.h>
-#include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -27,11 +26,6 @@
  * Host Controller Capabilities and Operation Registers
  */
 
-#define reg_read(r)		readl(hci->base_regs + (r))
-#define reg_write(r, v)		writel(v, hci->base_regs + (r))
-#define reg_set(r, v)		reg_write(r, reg_read(r) | (v))
-#define reg_clear(r, v)		reg_write(r, reg_read(r) & ~(v))
-
 #define HCI_VERSION			0x00	/* HCI Version (in BCD) */
 #define HCI_VERSION_V1			0x100   /* MIPI HCI Version number V1.0 */
 
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
index a7ea37f8f8e0..d94e49be3091 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -10,6 +10,7 @@
 #ifndef HCI_H
 #define HCI_H
 
+#include <linux/io.h>
 
 /* Handy logging macro to save on line length */
 #define DBG(x, ...) pr_devel("%s: " x "\n", __func__, ##__VA_ARGS__)
@@ -26,6 +27,10 @@
 #define W2_BIT_(x)  BIT((x) - 64)
 #define W3_BIT_(x)  BIT((x) - 96)
 
+#define reg_read(r)		readl(hci->base_regs + (r))
+#define reg_write(r, v)		writel(v, hci->base_regs + (r))
+#define reg_set(r, v)		reg_write(r, reg_read(r) | (v))
+#define reg_clear(r, v)		reg_write(r, reg_read(r) & ~(v))
 
 struct hci_cmd_ops;
 
-- 
2.25.1


