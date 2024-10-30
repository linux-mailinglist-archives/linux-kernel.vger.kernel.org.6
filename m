Return-Path: <linux-kernel+bounces-388369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 685059B5E84
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264A5283358
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEFF1E200F;
	Wed, 30 Oct 2024 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LmE0fSpe"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6601A1E1A37
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730279695; cv=fail; b=kMfCCusWqjNcZoTyxnvPERWAsSmhV9AVfMclnK0H/UpccnoyRWtIgUVnDKXQAlZMe+/y8m4nNaDFmyv4J6ZilTe834HPwDQRkmBTMXset6C4+OAmrjQaV2c7Ig3ZNq3lTV1TLc7l3Ws1Wo8I3/ZkpvqQA2w/LOPsAcxx+MRmcDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730279695; c=relaxed/simple;
	bh=t4Mt03BX4UyT1Fc1DV1hOe9jPQxmPY/RsZXnyRa45h8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dHj9I9h/w6upClFouITN6yWe4Ae8+VPvPtcgn2c1icHc1QUbBtPHb6/vhCJSj9Ejt6A6roIpOwpJI3bNeVt/dgV+/FXoYNRjgINDTOgWS7S4eZbea1PXQ/sYNh1cEwQIbbwxuVIKs5pyaS+/UWEhXC3dJhuSyATITYWPBbbQQeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=LmE0fSpe; arc=fail smtp.client-ip=40.107.21.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5MawZ1qO1+8+pj9Mynzlx5cuJYDsjA9TGgftM/m4UWnPkg6fCRSWK3klD9q+m35MW5+U2wJoPKIp6RZJrnDjQe87WM1Nnw3i8zLcvwTy7H0HsdSvZ2iPVy+Kg7HNvCVBoWJJds7JlIxOxWzxYHLteIVMsoPJEwQ0Sj5sOqXdCtE5AHRuC6QD2t/baLobQp6LvOtNv0DhpJoUVWRzKf8wwy56ZFyt7EztFxfCQhcU78mqXXwpTZq+BaNHTSuc+1f42+rdqQenat7TgbgiWeHi/wNl27xw/MaR/HrKi215BynVRLUuE8FnFIiXDNA4anLjrtBVjEVT8r4s3g61t/BrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XV72DHgs8T/L6w8FCEEKiJy9I1sRnA8ztHbCci/nsvg=;
 b=M16kmMJJurhsJU5qamdq+vWwGBDdro2V8Elk9Vr0B7Srnl/5v5XbzRhCQS97iqPNnFyNj+L9jZkmYjJl8wmzQqeHpvy5yeE57GZD2ddL58tmVm2/MRaHnnUkdjZDz449CvpvbUK39UoTnYO39/crqy50F09uD1lM8Bj9eOTcRuju6NeiRNPVYSrkH+uloO9/ULHCVxfW2w1vf2Xy2CYglbYoQRrsnCBFwFF8JYZBzVZiVHzlZI3GiK/4OCfudWxN7p8jif3rl+AYmrPRF/uToTtxyO9hjUXFS0Z/vkdNTCu/HE1bhyVOF+ifbXz0o1WgEv9bLvuSCnkwE7wKePT6mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XV72DHgs8T/L6w8FCEEKiJy9I1sRnA8ztHbCci/nsvg=;
 b=LmE0fSpepImb+vo/EAxQFcu/SeQWGtg75pfy4AuBE4RDEXhbOu3OhunXiyl9EBHnrY+ZslzG8qQhuCjmyJp0Vk6RnAZEe12k1ZBYup3x06i+kDwwICymh+rAUWohw7Ijz8of3uYZ8Xlf2/abnYKqhIHX13HtQDjO86SmdXBdmru0/jJVThZDQk0B6iNf+OsUzWcFEjzAB/ysD0+P+zkGat5va6q/MRiutYyu8fGYfXrxJpaoklwWtnaeNR3otwxYXLTysImpbQU7aw6ePyHEnI16cQvYANWUkIjSUJysllkF7Qy6ZRIohrHhkXFMYINuRu7m2ro4DFoqT79qOemJ3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS5PR04MB9854.eurprd04.prod.outlook.com (2603:10a6:20b:673::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 09:14:47 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 09:14:47 +0000
From: alice.guo@oss.nxp.com
To: alexander.stein@ew.tq-group.com,
	wahrenst@gmx.net,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"alice.guo" <alice.guo@nxp.com>
Subject: [PATCH v3] soc: imx: Add SoC device register for i.MX9
Date: Wed, 30 Oct 2024 17:13:36 +0800
Message-Id: <20241030091336.3901440-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS5PR04MB9854:EE_
X-MS-Office365-Filtering-Correlation-Id: 99228ab5-1e50-4135-aad1-08dcf8c34ce6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WmppfJxU16UG9aqCbRl99CuOOgsIAIGw1ohYjQFrjXZNINN2OKhlsT8v6LLV?=
 =?us-ascii?Q?qfrphvH2FrEQHIb9j0z7O4wUogsCKf7Tjchi8KR2XBKnjWZXBR7OTnYqXSKi?=
 =?us-ascii?Q?5SAocldvXWIG4AwUKO7Zpt7Wi1g6MJN6A5C8kSpoiLEfjaa+0ekwGgAOQ8Lm?=
 =?us-ascii?Q?53fjJ+c+seksSDz8BM9aPDhW/LIVRFCT3Axu7pS52rsaCp3b9j/ya40utZhA?=
 =?us-ascii?Q?7hswifLEOhoxE5CRGXQe/cN55yAcVENB5AlG+kn+m1djOYa6DQZBGg0EYlJe?=
 =?us-ascii?Q?tgIhGBsHI8V1R4UsPHncUrfmvBuMKzu1EXfkDusGxjd+Rd3jKk65sfc5YEed?=
 =?us-ascii?Q?JoMi3NweTS7ViiJo6wUGODVl97TkCtDyCkvLTvkEvk0Ip1bj9vUtVrtIqUqW?=
 =?us-ascii?Q?hLRvlWN3bR3yWt4BD9wbMzgdr4KPSy10SlG9L8VGwHLu9OtLyod2dMOcTVCi?=
 =?us-ascii?Q?a3fcJio05R57aBw6OjnLjrpLqFlzOr4yF8/SSZ4HyGXLdEUy55QxyiFONwxR?=
 =?us-ascii?Q?kJ++yciQNWD/kkgsgCwn+mO9xgfXgFVxh1Xp1WORV6Qy5jzNKC2Kc3yfwdWT?=
 =?us-ascii?Q?OzRNgNtDiDBXs//yrDbsTHW4rjDqEbCFvuaikEQBHwPZ/l981a3WNqskbCxY?=
 =?us-ascii?Q?sVMqYSIphDKCvBtADFIlffEHkMg4FzQ+DeU1DnkeOkN3ik/QHUIYsb+fe6nK?=
 =?us-ascii?Q?WbzQBcs3jekafOexo5JgxjzHXwP+B89DATZwx2aXT1iuQBa60wRHuj9iBIHV?=
 =?us-ascii?Q?6KVJeRApfmTnp/C6kodRVvv6zRUgG4y61tJzWDx8vt+NidcYikjdyxZbmzBC?=
 =?us-ascii?Q?KXXhwOLmqe4NDKp6YY8dKLkglQgVLP6LeKA9430bRcgUuGv/DWMLVnQOQfr5?=
 =?us-ascii?Q?JkzCr/xK8NtVI7CXITYna05iZWovb8prGEfthp6gz/seZmSwOsuU6C1H3dZX?=
 =?us-ascii?Q?ek/IzqbIxDEeGOTvL+zb2wsGP5RMCpFf9HZ9oYFT6bGtYrXnjRd2Hz7AL7C6?=
 =?us-ascii?Q?64K3VOD12ZF6SWsm1y/ff0Vq0plToGAaLNVB9GY4Fca5ay+9fYZoMUZuJa6X?=
 =?us-ascii?Q?WkNU4GTo4THm/C1nmCMGuQKVoD2IJE7ad5Y88+eS6ZuldfME5Po8vkLaoBm5?=
 =?us-ascii?Q?1HbVMUF/DiPe0WLs0SaX6WWgdCqJa6tfFk4/z9jc7DA/pJMtD8dbH2ol9760?=
 =?us-ascii?Q?5YxeQpIKyqe7hqK2abuY/qRKWaktt57GYEVhewsCDBMS9RZgsEPDzA8PBqzs?=
 =?us-ascii?Q?+QzrFdX8H+KRuX6U2kBAM6s0bU/VUAgj8XHoPeHXpGFhk3qtmPtJFxZB8Vq9?=
 =?us-ascii?Q?D+0BL+VVBSD7mhiSnrSsYxR5ptC1MYkbIp8xrDWVcWjqUYbbtYF/aI3RILL8?=
 =?us-ascii?Q?NTHalQk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mpR1oTFXLqBwcjOyQYgI/rob8dreTpHXoagTLVl67ZoNXs+em1rtjZNYTtr2?=
 =?us-ascii?Q?FiEg1l6lg15X/J5kq01Fbjxu67l/oqnXuUo3KdSgsNo/ZMUJt48VnABDcXWs?=
 =?us-ascii?Q?3Ycqg61AB6kxqqCoWoNOEZ6sx0anBGtxmlaRo7KKW1+K8ZubPJJM4048dPMz?=
 =?us-ascii?Q?fdAyYYzSRJ6vfi3wt51/4Yv81Dp3LELP1m0c+ZvqtL5sMLZ93AUItMbR1BQL?=
 =?us-ascii?Q?vBspsLc7KFS0p2/tTCmrQr/GDGFpAWN6pFzOdedqdxM4PBNVuEld2t1P7d0u?=
 =?us-ascii?Q?0XQS8rC4bHTxul4CnFDWp8N1RQ1RysebRnc6bgZ7PFEgOGeC3GqyCmW5txvV?=
 =?us-ascii?Q?fUO6MNjgqla8Oxyw98awf6R4lD06D2jWAWkIVdz5cthXdeH/REbCx4PiA6YV?=
 =?us-ascii?Q?2+so5RxNGYiAAS8hPlXOqUgtj1S/pwPi+dU0PDPNMBXEGutR/Jt6pIe+30+r?=
 =?us-ascii?Q?vrX+hS1jkAFUwPJA9ynRQZkvjy6F+XPR02tWJVeEDaPW0nKbmTD3FKj0eP4h?=
 =?us-ascii?Q?VbaIyK8lDNoWYk0Sw1eC5vTBpKVw05vlLjAx74Wh+2yEKXuSl2KK6NBfwRNW?=
 =?us-ascii?Q?O7qWYQzHWpOd1kueobTyeixfI92QtoMwb1hJ54yK96tBGaquHT6eyU/xrTnm?=
 =?us-ascii?Q?bIunNOSTRWJp52JrVIbgqKbslO4VNMH5tG1U/O6VCiIHM2GTc5Db3Q4WsGCR?=
 =?us-ascii?Q?SS6KO0fAsDdgunDW5U2z3iGnxhpqK0op3tkSXcx5nlEivJF3I9QP3jTF4U47?=
 =?us-ascii?Q?IP1s3x15+pPMSUsaio8Nk83AmuxweBzTHqJDVHcc1SiPsqczfcd08hnzq+ge?=
 =?us-ascii?Q?QrQr5G/cyBUxemtvqOm20/pvWOqFycetHTVSkRfnDxDhZvGDusLAZjf31LVK?=
 =?us-ascii?Q?CLAFBek3ea7R0MiJyzuCXbpuqLl0JCzENXENxfmozGb/wz8irJrpSnBSg9cZ?=
 =?us-ascii?Q?7m3e3kDAyAmMVmm1qugFLJ0qq+5SQuySMRIm/xz9wHW2Msv7Oxrjs2geG0+f?=
 =?us-ascii?Q?i6LDD5iXnckmYkB/FegRP+2hfuRtV9Kxk6VfM3P1wtcX0VywcZVZ0C5sHjLa?=
 =?us-ascii?Q?R+yhPsYigUIepqAPJGPOlzB9o/5meKmp0CATbANzbrwzFaKnu1+t6cKBC6y9?=
 =?us-ascii?Q?t5Vzm8UskuHbiTTJtbbOVGXtU3gD5nndUoe2kB17aopmmsYf4o0DRLs32grv?=
 =?us-ascii?Q?wi79IGG2jZTBHAmFbZInFmSBukfMf8LsUFAA97kkcXCdbClFUuFDrOA2nYNh?=
 =?us-ascii?Q?jFOYglitABYiyaxtzcxRRMntB0E16cuiTRKM+PWcWth8BX4s3gaJVFKSlPWO?=
 =?us-ascii?Q?ugkT+eYenXvbL5KhTQ26J/p0pn2AiqBNlHnfXAV2ON1+kvq6HaIOmTidizyV?=
 =?us-ascii?Q?ghGAPl6h7ugPcbKXlSnuqgA0E01+D9ATQX4qKle5oPaANtlwLaTjE4PGjqMI?=
 =?us-ascii?Q?WIayOV/Rw3E3gwx+siWzBtfVBpt+LM2BNI798T+OI5O3kZ2LqKdvijn9PhYO?=
 =?us-ascii?Q?lLfU/wsZiLipJrgPz5v0a/ytEchRuHDO7yT0WIUKKM+jRmx+p6L+zoSWnj4w?=
 =?us-ascii?Q?Z3I3q7HIVjD8amU0e9h2A7maQmLMnN46ZBqchEZL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99228ab5-1e50-4135-aad1-08dcf8c34ce6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 09:14:47.6316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XfVPUf2to0LvMXhHwqBFf9tCfBV1Tn6VDPe5bNlMr6mLdpE7NZFL+NwJUC5zXl3kWENbL4ThgN9LnqqscL2s9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9854

From: "alice.guo" <alice.guo@nxp.com>

i.MX9 SoCs have SoC ID, SoC revision number and chip unique identifier
which are provided by the corresponding ARM trusted firmware API. This
patch intends to use SMC call to obtain these information and then
register i.MX9 SoC as a device.

Signed-off-by: alice.guo <alice.guo@nxp.com>
---

Changes for v2:
 - refine error log print
Changes for v3:
 - return -EINVAL when arm_smccc_smc failed
 - fix the build warning caused by pr_err("%s: SMC failed: %d\n", __func__, res.a0);
 - drop the pr_err in imx9_soc_init
 - free the memory in the reverse order of allocation
 - use of_match_node instead of of_machine_is_compatible

 drivers/soc/imx/Makefile   |   2 +-
 drivers/soc/imx/soc-imx9.c | 106 +++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/imx/soc-imx9.c

diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index 3ad321ca608a..ca6a5fa1618f 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -3,4 +3,4 @@ ifeq ($(CONFIG_ARM),y)
 obj-$(CONFIG_ARCH_MXC) += soc-imx.o
 endif
 obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
-obj-$(CONFIG_SOC_IMX9) += imx93-src.o
+obj-$(CONFIG_SOC_IMX9) += imx93-src.o soc-imx9.o
diff --git a/drivers/soc/imx/soc-imx9.c b/drivers/soc/imx/soc-imx9.c
new file mode 100644
index 000000000000..823395584533
--- /dev/null
+++ b/drivers/soc/imx/soc-imx9.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+
+#define IMX_SIP_GET_SOC_INFO	0xc2000006
+#define SOC_ID(x)		(((x) & 0xFFFF) >> 8)
+#define SOC_REV_MAJOR(x)	((((x) >> 28) & 0xF) - 0x9)
+#define SOC_REV_MINOR(x)	(((x) >> 24) & 0xF)
+
+static int imx9_soc_device_register(void)
+{
+	struct soc_device_attribute *attr;
+	struct arm_smccc_res res;
+	struct soc_device *sdev;
+	u32 soc_id, rev_major, rev_minor;
+	u64 uid127_64, uid63_0;
+	int err;
+
+	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
+	if (!attr)
+		return -ENOMEM;
+
+	err = of_property_read_string(of_root, "model", &attr->machine);
+	if (err) {
+		pr_err("%s: missing model property: %d\n", __func__, err);
+		goto attr;
+	}
+
+	attr->family = kasprintf(GFP_KERNEL, "Freescale i.MX");
+
+	/*
+	 * Retrieve the soc id, rev & uid info:
+	 * res.a1[31:16]: soc revision;
+	 * res.a1[15:0]: soc id;
+	 * res.a2: uid[127:64];
+	 * res.a3: uid[63:0];
+	 */
+	arm_smccc_smc(IMX_SIP_GET_SOC_INFO, 0, 0, 0, 0, 0, 0, 0, &res);
+	if (res.a0 != SMCCC_RET_SUCCESS) {
+		pr_err("%s: SMC failed: 0x%lx\n", __func__, res.a0);
+		err = -EINVAL;
+		goto family;
+	}
+
+	soc_id = SOC_ID(res.a1);
+	rev_major = SOC_REV_MAJOR(res.a1);
+	rev_minor = SOC_REV_MINOR(res.a1);
+
+	attr->soc_id = kasprintf(GFP_KERNEL, "i.MX%2x", soc_id);
+	attr->revision = kasprintf(GFP_KERNEL, "%d.%d", rev_major, rev_minor);
+
+	uid127_64 = res.a2;
+	uid63_0 = res.a3;
+	attr->serial_number = kasprintf(GFP_KERNEL, "%016llx%016llx", uid127_64, uid63_0);
+
+	sdev = soc_device_register(attr);
+	if (IS_ERR(sdev)) {
+		err = PTR_ERR(sdev);
+		pr_err("%s failed to register SoC as a device: %d\n", __func__, err);
+		goto serial_number;
+	}
+
+	return 0;
+
+serial_number:
+	kfree(attr->serial_number);
+	kfree(attr->revision);
+	kfree(attr->soc_id);
+family:
+	kfree(attr->family);
+attr:
+	kfree(attr);
+	return err;
+}
+
+static const struct of_device_id imx9_soc_match[] = {
+	{ .compatible = "fsl,imx93", },
+	{ .compatible = "fsl,imx95", },
+	{ }
+};
+
+static int __init imx9_soc_init(void)
+{
+	int ret;
+
+	/* No match means it is not an i.MX 9 series SoC, do nothing. */
+	if (!of_match_node(imx9_soc_match, of_root))
+		return 0;
+
+	ret = imx9_soc_device_register();
+
+	return ret;
+}
+device_initcall(imx9_soc_init);
+
+MODULE_AUTHOR("NXP");
+MODULE_DESCRIPTION("NXP i.MX9 SoC");
+MODULE_LICENSE("GPL");
-- 
2.34.1


