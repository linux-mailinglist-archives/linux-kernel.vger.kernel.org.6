Return-Path: <linux-kernel+bounces-403783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7709C3AC6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2161F212F0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C744175D50;
	Mon, 11 Nov 2024 09:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sMBrmZSh"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983A71714C8
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731316916; cv=fail; b=PIamQKdA4Ame9iZ6w4/XHloQ5zSwGOaSJdxHIn7ftrwvbyqckdRpDT1taTic6C3K4QFP1mFmDy+WDhGDZ2YfU24SuqSnwt5tBbUqiiA3eOj09V1sDGIlSY7nJccFIm8ZAg9Up6dMBpLWGsrh0iB5jQy+nwj1nd7PuDObh3FOF9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731316916; c=relaxed/simple;
	bh=0MvO+DxiOw55ntJXzh843IqkExT66CWCZd+p4/T0jaw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qulT7SuiV14K9nKeACqlJdlsvvy6X1lakYppK/nDsxd3WvQpEDYtC1FUuS8rMLF9cvgpKmmW7lZe9bE/65YVN3N4DYinJz66gPQxMezh1nlg71C970nn0hZi2YROoichLGZfUfGT7hly2avdeEtmb/dKS4WdZgFhIyzj2WsL6vY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=sMBrmZSh; arc=fail smtp.client-ip=40.107.20.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryieIdTgvbZpDLbEXLJAI23ifwHD3HmG43yF5U2JmOwLPXTyNegnu9DuqVTx/neRKaGANaz4bo+pWfHh5irxMo9Vkc3ak4I1LCC5ejW/X3Tcm4dJYEAJJzgBZYnKPvd+hzY2G5hHvnaJtvTw3aP2tzlwhO6OPY4d9mEAba2qqv3fO51M9eyeJyR4SKGbd0+jr6nurG5+6JaJxqqSDp/8mZPq/LeW+2VgLaHPgqVPoRtMA7+ctFzltwckvtbK11hEBb1t5IfKZGxG07m1cdtZYoaFCJrb4BcIGwy0xNBlFuZD5+fMA32bprb1e2abmBfj0C67sXb/HvAQa2OnmGSIfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26mzx8U72ym7DAYKm9XN3PLZy2VIPyDm81eWtIdgZdM=;
 b=nSysl4aAGDmqWd1FCqjrGZ35h8ogVQcuHspEz5UZTPw1W85OLrwX1xS2j6DXFeE/dO0ggUuBiJHhWSL9YZTwCxREMM1CNwOdi9eX91tpTQWHzVVwRpHocf4zXtWJ2CPTmeOU9n4LWals2ODaohhnlLjZ6ps4h+BnSdjoerqBjicQrxOoD9GJZo7Vimrw6ZG3M7u/wKLBaPNph+EfJyoB8Eqtb479CIaTaoLNtA8AlppXp/D3ajdlT3m776aDQ4u0rAUIMqszyruuaFz80T57Tt/Us6XCBAfvQQaYP4h0dZwbYGa6GqldQ8dGbtlBlrJUw8re8b/omGChvifnJO5dLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26mzx8U72ym7DAYKm9XN3PLZy2VIPyDm81eWtIdgZdM=;
 b=sMBrmZShr3BmsEO3lstL2KdarKhTxek1SaIKfdFsX+3Bg1tasoYr0MHndEPJyWLEJdPCG0SkbkLIpMXV5pFEEd8Bh/Bpp3IKnHjugEG1E/4hcWWicVHAfsa6epMdmJYL0yAZ/P1trKHtQ2KBtOvQfpZHCv7oVDeIimIwKnriKuLRTDdQeE/HLXtJKld0Ex8GyD9X8dB66z5YpIBCn7Z0Urc2n3EpkPxcMX6buTk4yFW+5VuxiQgktVrdaFxnF1eIwWGapZ7tgMmhxHvoNDow3fSICVSQHOM/w9GMkiXx7xmmAyp/4Jo/j05xkoejHFiqhqzlrqnOHAUXveNHbmqLJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB10032.eurprd04.prod.outlook.com (2603:10a6:102:38d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 11 Nov
 2024 09:21:49 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 09:21:49 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Cc: Peng Fan <peng.fan@nxp.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] drivers: core: clear wake irq in device_unbind_cleanup
Date: Mon, 11 Nov 2024 17:21:30 +0800
Message-Id: <20241111092131.1693319-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB10032:EE_
X-MS-Office365-Filtering-Correlation-Id: eab249c2-03d7-44e7-99ec-08dd023244cd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?glDsLXavZkP/fWGavNMbQsocRRDBaFUTF+C1msK7yhP6SFmVTietqwvLV9qX?=
 =?us-ascii?Q?jAgK5z01coTLAjmQ6C1BtrHY9CzW7RKXQIcnmQqZH0EHH3QR2zKE6LKgrEMp?=
 =?us-ascii?Q?9+9F4PnpI5SUtCUIYz9jW1++NHQJG5RE7LmCsY4LbLx+1gMEBOxjcxOcBp4F?=
 =?us-ascii?Q?VeX3KDs5cdeP+8ikJO5Kb2rp/7Gy+/868i0LRJEdMXjvM9GjW1MIrlBpf8Ru?=
 =?us-ascii?Q?iWbiOFTV81uzbTxh7FTBFd1Htgx9aKOcgDJRw0ftFLKVnpssVzh77BNRYgxE?=
 =?us-ascii?Q?uUs74ZRJBfWjk52ASyOSvSBaVa6DZUBCz+odfNviEKtIpgCSQMS/SyGawhAe?=
 =?us-ascii?Q?4YL2zS6Bw3YHc5UXjLluqK3fc43RLwjcktFSAt9TUlJLo3PHI2u7Fadl7UOm?=
 =?us-ascii?Q?OacIF1Uar1gCAgdJX3F0fsI3zHTZU7iv7Tsn150wscF1blDF5nWZqkZGz2Kh?=
 =?us-ascii?Q?hiOd7eGJ9Ze1kqlr69nuWEYyyWnKX1+91ukLI2Nk95ey6XXD9Mm/7AU5Z3l3?=
 =?us-ascii?Q?5Qz82rtJgS1GlY1XErNySnPa/tVVHTlEJq27f2Fm1CPVnaCswZCfNY2gSB9A?=
 =?us-ascii?Q?1Zq92nmazt1TyLpixRy+WDBsT1wemeISdPELOVQRG0UN3FGjhM8pvwSe38m0?=
 =?us-ascii?Q?53u6VmYW2xvZVZ7BW9EahANnz1u4kVBpULwuR1iAZ/9nVyK9HsgaKJOJgTQ7?=
 =?us-ascii?Q?gX/F5R7S8btaXYYPS/oDdpwHYnXwjf5Y+LGXSlMrYesPbhDQH29oF8XB/BUa?=
 =?us-ascii?Q?2epVMjy6C1ekf5X1ZPRddkwJYUfD49gfUy2Mbxqf/UQztxRN9T/snU/BSMo7?=
 =?us-ascii?Q?/+OBJmJ1yGeLAxo8gzqjfC+5Rr+rn7N+N4VaT8U0Hfrvjm1Uc/qmxdJT6jK3?=
 =?us-ascii?Q?TTCvWW+UCGvW0syVWa4ZFfIeY2PLJDtbxq/ogHns3Q7Rkb6qN+A/wdemhkGu?=
 =?us-ascii?Q?RqHRCxUzUp5NbAQN2nuuJ5imI2GafI2V7Z27dxN2+4DxJbvaNNB9DDtARcct?=
 =?us-ascii?Q?rfWPqsnMC+WyhJtvgfGVK/XSMjjIjFtXuObSl5xOK+qSI+V00Yikqu8m1T44?=
 =?us-ascii?Q?uCtAGAoMmjnHlczl1A3SToKmnx8uDgj8ioR2ycDewo8elduBubvv8f7WxGSK?=
 =?us-ascii?Q?EO01VU7642QzM8XcsCbecjJYxMWr25Yt0F709nk4nvpgonvlp8gJ3tTLmJ3M?=
 =?us-ascii?Q?pH7472wXpyYGhdiXqnKJQx+TEJkxJoHpP45vEJK/NLndFfqC+n0Z28KkkOyK?=
 =?us-ascii?Q?mFPg99TZUl8RKzcNNjUgnn9R1KYHAwCAMWN/lQx8Db7vOj3W72X7mbi30/kI?=
 =?us-ascii?Q?T9CMCQEI52BH0I31Dr+2yUsuvO5wOSNXeBgKUG5XEefGUGLPC1+cDzkka8el?=
 =?us-ascii?Q?c28PyK8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iBBDCWG/xBTCcz8CWYG3gppUqvx7Q9emx9qfY01H7LAp8RxqQuvgy16DsxvU?=
 =?us-ascii?Q?rifgdtsSDoTQ1h3Ztga5hXz4I5e0BqxSBV3cyENRmU19DAO5b7K/G9xuTEdo?=
 =?us-ascii?Q?h/mV1J7e++vHLwX0FfssbGtwfoXUI8L9sqpvGZ6/vCZL8iDTW5YQVFBa/IE2?=
 =?us-ascii?Q?q5KuMk2KZmOwVlo/zGwZdibO9N8ZkbIlrcBXzCvh9XFjdOzO9GNDF4OJiMpN?=
 =?us-ascii?Q?g5erSRb4rnYRMmX69ceseYuGnReE2t7XK9mY35SAKHBbPmoSwZuo2rOUCm94?=
 =?us-ascii?Q?dNazIaGU1KoFxLPRhrh4+/1BQEIfVLdYZMh29H/9msn0iLggq3Lr595JAaII?=
 =?us-ascii?Q?d+1Cp3Y8h6itqnhwdX9VtRvnRvx6fmzO6XNZKHShikz7oXeexZAa+x347g5e?=
 =?us-ascii?Q?IuwJfXTCDLUNVjA1+u+rnkNXoq1LANHjfzkHK44JM1JzXw8/9Ih+CLm4L9br?=
 =?us-ascii?Q?qgtvZYLLoiBSoQjG6d/twNEJfBV/He9ckhBxWwgDgqgknnCkwMUQaBtsvqUq?=
 =?us-ascii?Q?gwmg6jSlz2bS5pIU3S4+BSDiaMCO5whk1ytIjenombEhaKa97oMYRfZM8VvX?=
 =?us-ascii?Q?TuDjL4LI2ZZyEIvL67wRYsfnzyx/ESpGFLDv1JLDlwUJ1jjKsWwcPo92cs7a?=
 =?us-ascii?Q?MOpLs0HUBFk/Pouwq1mb0VkyqnvrEzlI6g7JLVQOIdofJMySS43XhJIEz8Zq?=
 =?us-ascii?Q?WRx3TGGtTEJPHD2bhd+rCxiOhRyXcWNOji7R1n6gS5WRE2QfQkyLeuqYfhvz?=
 =?us-ascii?Q?uu3I3kJ9HyviTNBmS92YF3Fhf6IHOeAHPDDT9D/XZqo9iSHkWbkZ2LpaKZIW?=
 =?us-ascii?Q?53gzvF8nALMAHcO3b89tes9LsQpkTboNMuT6vArTN7Qd8ZwrT+wj0CfPceos?=
 =?us-ascii?Q?R0UTb296VkXVMsERGQY3W6mMEI1Aw9EntWf8rE3NhRj7AoMJ6SmbXWOM6RVJ?=
 =?us-ascii?Q?lr1lD8drTRYWcpWn7buAvgo78RN+nyka41Gbx7sOeDFgFMmknHPEPalg6CIR?=
 =?us-ascii?Q?t2LAkRhA3VN22BzufTmv3BUKWhi54wdwFg5miJz5KVvDX1tF2bcv2nqOqQqS?=
 =?us-ascii?Q?jrKgK6JSBqAOH31RGgGO0a53wHDqn74dQv4nTLO0c40yVBnVoDGkk5on2YN7?=
 =?us-ascii?Q?TO+2C0CMlllhfvrVi8Xi7mJqLH3r310TtBkDdHuEyVsk7CNVPNF8iONqr08w?=
 =?us-ascii?Q?1Ap6cb6Vw+r7nHoUCWEq9dcnDZXdzud1d6Gwv5DzYNVPPVc7yCduAL0jY9aZ?=
 =?us-ascii?Q?WZBfAdiWOLuikrOL6BER5Xlvj4w8v7YTnPure1oVQBNSnhnTjJj6mwgFL4DP?=
 =?us-ascii?Q?7uCMuob0SqGBN/Pi3kKMY4z5LDTfzSOdm6EZlZkS7X8TGwc/uON/5EAh0a+v?=
 =?us-ascii?Q?5cdfFkvKaFO0B+OUaqCP2FE6k0HOMRQCUb6xDOJzxAaD0dNhlA1Yjtdi1Ja1?=
 =?us-ascii?Q?IUi+IbONGyTDzrN1S8eto4rhkDJv9YCG5qsckcxa9xTozMEJx6t0VYViTfHS?=
 =?us-ascii?Q?4Pv/+vxdoqZnp0REzzsfaBiW+kqBzEWZaTUNpQ3XGWt4RUvAc/Rj+F/Lnz6w?=
 =?us-ascii?Q?qaE0r5Qu6QXH7S26FCsckKmzQ/sxe7Qp9VKnEu2Y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab249c2-03d7-44e7-99ec-08dd023244cd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 09:21:48.9300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ac+VCmrtQqyt92pQuB/+YJhfkRFdLCjQyVB7n0gd11n76dAVRpMPArrRpRH2P5Sp+tJOfOu+dDT3TIOoH+pn9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10032

From: Peng Fan <peng.fan@nxp.com>

With dev_pm_clear_wake_irq in device_unbind_cleanup, there is no need
to invoke dev_pm_clear_wake_irq in driver remove hook explicitly.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/base/dd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index f0e4b4aba885..ea3a871bdd11 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -26,6 +26,7 @@
 #include <linux/wait.h>
 #include <linux/async.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/pinctrl/devinfo.h>
 #include <linux/slab.h>
 
@@ -556,6 +557,7 @@ static void device_unbind_cleanup(struct device *dev)
 		dev->pm_domain->dismiss(dev);
 	pm_runtime_reinit(dev);
 	dev_pm_set_driver_flags(dev, 0);
+	dev_pm_clear_wake_irq(dev);
 }
 
 static void device_remove(struct device *dev)
-- 
2.37.1


