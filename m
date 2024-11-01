Return-Path: <linux-kernel+bounces-392588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B729B95E1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B619D282BDC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A0019D089;
	Fri,  1 Nov 2024 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cUbBQG63"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED1A155324
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730479827; cv=fail; b=XS83irU5Vr4i1aM3K8asaX8/UZq0XCxvuxdQaxkuUHBulBmHIJlISL6xSBoGT6/7ghNLKqSBLPhx9crhJNMQryvPU8llmTppHNz8qed7pEFvft6Xpnltu9g8NXydSXTgbA7E6iBRSxUWd4Yxi8x+fBtb653MgiI9TyF4TrTe+MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730479827; c=relaxed/simple;
	bh=MYVWkobQ46xnf1oTLC4Zx59IeCfJbBMF8dvp2yQlUco=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=P7h43NtOqWFbbsR+wNlNu1Q0+jgusnDl7XTqmrwy16PxHD8ROEqKXJfiOLUzp7a1yU2qicC+7PQdGJ4XBElCOxidtjv2LAAh6wt+IYzYVG3RKgMER4yD36EkVLzGUDuYmFGHVysbNylmtn7aUk0Ga2nQjO6WbNKTIbukb2kbJIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cUbBQG63; arc=fail smtp.client-ip=40.107.20.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1kM7Vj+fyOyC7KY1dgCJuXcrmSP9xyupoEA0/J9Hl/4KfgMlvpElj/uK5xsKiLyGlrDXH45aEsuw5vuK71uwc9ZmSIOUzof8YLOTO9OjBUGNQ3ydfdDC/ANK8Uhe1/D7tHGt5BdTMKSB4/klexI1gPTEfvJz35AivND+S/w8P0WWzhqvsHzk7nMXMxLG+3OAkdq7Qs0PCfyc/I+MZ6DJv/8Pi948bVWTqqr9nU90adFh/Fd8zP4dOLVVNIaFyk5gpDSP2sfRcBKUJW5/4/ti8+R3s0GS9SYYC1EAVeA5VGV2x4EJnB/3Y7NTPWwr9AkmYnTHioUujn3qG7g1i4uIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KBgxRO4NBY42OTzZaW0c4I8dLq1r+LVI+ujJGeJmig=;
 b=X/qYUakqL460XA0FjZL6H4d1vtJPrJLlIo9zHKJK6nLMPIU8S5XFtmZ9G0ApYVuZJC1KNcQoSMVZizVIM2PWewnsTF4xtjK5k6eC/VRFtBnYTnatJo6VWwxHN4TMv5PF9DFgTH2FKO+03rio3TDy4GwHyV9uNclgonKnv6H+d2DlQfy3J+OPRYICmR0TrBaw1v+tgLt3ZTbc0hgBqZE8HFVeTCaRcT2AfZA1gId8KE1vuU7/9rcjgV8Vy9GT6UZcehiBLD2z9F6tTQa2XzubRvMJYoEK6+VwEak/WBnzVUaZOnZjWTsf3iOVwmdJTU+YVZXBlj1jUDc9D5HRLOg2kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KBgxRO4NBY42OTzZaW0c4I8dLq1r+LVI+ujJGeJmig=;
 b=cUbBQG63uxyNEnFOrebilpuN5JPuYisppfEjtayip3rAtMRQ7pg7VCJCEjhSNBIHGVOgPHLfocujmYB42FPX5sYZmwl69Pm/iWCEYmeutrG9jAtHhujrkQ57BxgkI2iAm9c+Pwz5m+VxiKAjO5x7oZGMTBUJ0WW8mZcDsIfAiDFv/oIyzX827+dom3W6BwYiT0qc23EEq6JwnWN99C3dQid8dKFB5GyJP+BSXMef72252Sdj6YwATFN3MGRRb3EAGqyEnznTrRUe3oUqKUxYEpwmwqPIYowl9Y2GFLikXbYLXI9UPVORKmHh3QtSgsAClVINYPl3vBQ4lsOaE3xc0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7930.eurprd04.prod.outlook.com (2603:10a6:10:1ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 16:50:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 16:50:21 +0000
From: Frank Li <Frank.Li@nxp.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	conor.culhane@silvaco.com,
	imx@lists.linux.dev,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	miquel.raynal@bootlin.com,
	xiaoning.wang@nxp.com
Subject: [PATCH v2 1/1] i3c: master: svc: Modify enabled_events bit 7:0 to act as IBI enable counter
Date: Fri,  1 Nov 2024 12:50:02 -0400
Message-Id: <20241101165002.2479794-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0383.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a7232af-7137-4310-8631-08dcfa95464f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uwGUGizq+wC+fNGauxD7AIla2ImpqnRz0KVJlJOKinzbKrZyz3CMb3x+VAsn?=
 =?us-ascii?Q?TgqUPsgZ8/wrJxCB2meMZ/GpTRG5+tNEhoCnAse793vAzIll509hxFLADFvf?=
 =?us-ascii?Q?HcM+3FPv5sF8Y20MNhfKLfLQ2hPdpjzpPdrzUsY4HoEYltv9/SM8dSM+awr2?=
 =?us-ascii?Q?5bYv1GmsBcD4QDtBXYYGglIM/v4ekpUt89SBcRiZ2IbcGe5o7ax/qeF/+dme?=
 =?us-ascii?Q?K0JSiSmNtOh3wYlCHzXeTS+n0A0AVdk5xMPX3ZEN4ANrzLc8WeYUzpnKcWP5?=
 =?us-ascii?Q?sssmcXb2F7RzwUkCMkEvGBEaDjDOqZzNECaAotMrAR5fc55qz03Rr8Gd01+x?=
 =?us-ascii?Q?KrYKWUEKwPOsWQiMeEM3Cist2bPBHHSTFBQB89X5mDNjsktRKRafozzNXKPd?=
 =?us-ascii?Q?hFkgD/IEEmeQDhg8zGos8sqwU9lV1pzWRPQntQI/KjnNBsGYszAE+iWikToW?=
 =?us-ascii?Q?55sie0WNymwf68mUAbQ2gk4YcyWMhHf42EQocS3ohAOFP8KNXRuWptoibk4F?=
 =?us-ascii?Q?o0YyMK+oZg6wszD72sE8fqalRhKeFOr1tXOfbBsO4BJAo5+o4Gh3b/o9raun?=
 =?us-ascii?Q?2xyE1AHd9HtRRX58azLzFmml7o/wq/ASwiDRcduDzV7ESXoATng2XRuhZi+g?=
 =?us-ascii?Q?YOwXb9bh1Hwt4INfB0m801cr+G7exm3UYmKBZrQAng7nLMrYmlicIIRAJmhC?=
 =?us-ascii?Q?0uD8U+izes2BrJf42EZBXXuYoiafWg8khtBrx/SnNnoFj64e5VGwa+A35yzu?=
 =?us-ascii?Q?pkX7rnzDMAclrS6pfjSB+2+gIrwk8rI60tLhjhym7y9AXiupSZVZRG9yhQzC?=
 =?us-ascii?Q?3a9syrAzIORj2pkARCU7JJxo6IDtEbpy/eCR+WdyCcdDzubY6HP3udsDbaij?=
 =?us-ascii?Q?1OYiW8Xl91WLSDhd2jjNhxVFEsQywfL3dLwEb+AOyniQUjjo2KCv2/w175N9?=
 =?us-ascii?Q?9Ae0hCk5m8y5ZUCCAIpmaCNapz79Hj4/0QF/FSVj/LRNId2nRd3VfV6rP0fv?=
 =?us-ascii?Q?YFP+5/Hq7AMph3agRkhGZ2h9lXGNbhjwP6qbQG4Nmg24eznlX4j+Nw//Yn8h?=
 =?us-ascii?Q?peuEaRkOn14dUgQ0vWThQ4WN7cIu3Hzf2lh/nPXECYVnZWnmsMZZZRI5Qzre?=
 =?us-ascii?Q?lVmiDOaqmmglpWxE6gWHqi9Gee1dprFYpEnIfUa1DyFWab+B/cAqdbtl6TD2?=
 =?us-ascii?Q?mwxh8M6Jx0lK6Prmgtuvq2QQILnZ1DKoaZIDvMdfyZKxhrBBcuB5R+Y1c9kY?=
 =?us-ascii?Q?ImcMvqJ6VN0HjrUYz/5twzJOkQyzU94Ln6UThv2Lq0WIvD5sOEhRQ8qnqk5s?=
 =?us-ascii?Q?8QPc/Ggy0QNyQPijl3mI2WYGWCJZOoxosNxGF0I2gmOuT9W2oEYHgZoNpvKz?=
 =?us-ascii?Q?/GIkXM8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k29K+BAsig55LhlJag4yHjSdFkyujsK0abJhiX9cqYzZD0ggRcrrCGxu13b8?=
 =?us-ascii?Q?BJAu8ih4DoCbADuJI8DaITNmdcgqQDyuWBQgzowxQ6dTtldZQmw1Q/16OC9y?=
 =?us-ascii?Q?2QTEWLg2C4OrvkarAduXMWHfQJhBWZbe+W3IH97IyBxF2g3EDfbPRLyOxcwv?=
 =?us-ascii?Q?FLjc+sGssXpO/a/rn273TiFN0jJ+JfSYrngqCe+S4PEb7Ztv8p9aiznAj0xG?=
 =?us-ascii?Q?LsGtIK3g+5zspzJNuqB/TfsE/taNm3JKGW8H20YZ5Ao7a7YiaDVmNJar4RGS?=
 =?us-ascii?Q?iT9nzAno9rAMMsk/WqzD2dZWWjX4kKhiQKFzc/szY1D7uUMSlM3rlan8Cro4?=
 =?us-ascii?Q?+/3nQiNOGWqc4IMwr/rSvKnLzPLjLqGsQnLvFHJ4dQRe0egCb18eKiV0GMQQ?=
 =?us-ascii?Q?R+WNFMphVd8/pkw7O/xOpU+Qy/7CLxxfj1xH1VoNQuPT3CHTouErIfvpLxIt?=
 =?us-ascii?Q?+zERSVgffZM+obTeMsA/ngMHVb9wtgbEAjjR+qxl/Jb1K9ZYYkQia0hhWi+a?=
 =?us-ascii?Q?dPG0rL5NGg5Gt+wfg2CVo4WfO9qqnkd1/KjkK062UbXtzrnBvry2Xl8Xog69?=
 =?us-ascii?Q?PGIQk/Gw/k61+cUu3psbTARw0l7DYtmDZhD2xNaaZ2USVqPGZQWy+jCynz8P?=
 =?us-ascii?Q?lFVgnop8+N+b5m7m6FSdwfUGWik3JR8v80Td/t4vkL/ziWTwJsirzOXvAdZZ?=
 =?us-ascii?Q?pizdD6VJT4UhIGXrROS8zwgZtX/v8yyQU5sB8uEsivPC+AgkorYzQHUxZ+fp?=
 =?us-ascii?Q?Cow/BEqYvaASIIHlRTjkfz8zIA+04RKh4d0HkrawHwvVkEi43EDnlFqjwH+n?=
 =?us-ascii?Q?sBhLvDujw+tjYIpgE9J5mCGZAoe4RY8LwwUahtWlH14vOoTrqYuAZWPo2DM3?=
 =?us-ascii?Q?iUnvFup9/fUJzTKArst1u0h2jp8T4GWo6MrcRR5FrerxLmh7TfFSs/myEuXv?=
 =?us-ascii?Q?6Mxnt8P+gvAnEhhgN2mPlkJeA2kJ7kG6Kzyi8uVhT4IzhFOaZyssjwS4V6LG?=
 =?us-ascii?Q?xRUI63i5T3LlNxr8acVUnu9+V03mNlnLdZn6qHXS/v9HJpBMyGubfOCoWdCf?=
 =?us-ascii?Q?OpHc2g8l8SOW93q1zFIz5j7EQtFJ+otnruGyyGSox+XBlyQxARzfvhKc13Sw?=
 =?us-ascii?Q?Pqwa4nPZf0YstOw8exTIm3o/P9hSirouu0JMjG/Outb5MlZkk6YA1moaoKF9?=
 =?us-ascii?Q?895jtKclK9Lx56c4wFRmqSYQ3FyF9x1egq3wTFktsCIKkaACJlkz7hzihQad?=
 =?us-ascii?Q?NqL0+QEA88f6744+inTY/sWWyvcUbAm5iUGVRBfcCj6lyST4ny1HS4+4UzXI?=
 =?us-ascii?Q?34x9vBiOnYAZ+wPXpz7uklusOZJrpQRceeRyozGNaXLT7r70BYjc1lqurtUi?=
 =?us-ascii?Q?OZ2l/uBQEXvZr1pGvOHQ46ngVGxnEUHvloeJxHm1+11FW7xxT5wsMkghS4gJ?=
 =?us-ascii?Q?AWeVtELhQQBzaj2u/kNNzsUH1FmgKzrjhtA47b+Zo/TlLIhm/RhwI73WL+7l?=
 =?us-ascii?Q?55ZgNYxSdh7foTkthUt9HFewyr5sIlxcnHoqGKvnmoQtRUeBIWAOzVS0s4kY?=
 =?us-ascii?Q?a0K6uzQO/vvrEZ+uq+I=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7232af-7137-4310-8631-08dcfa95464f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 16:50:21.8255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJEdiCtWIVEeQF4tcDRFpyk/cprw0XJj+YtiSsviHwU9FQycaX8wfnY2EcPFJUQu4+hzVDRsQagmqq9Rv8cu4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7930

Fix issue where disabling IBI on one device disables the entire IBI
interrupt. Modify bit 7:0 of enabled_events to serve as an IBI enable
counter, ensuring that the system IBI interrupt is disabled only when all
I3C devices have IBI disabled.

Cc: stable@kernel.org
Fixes: 7ff730ca458e ("i3c: master: svc: enable the interrupt in the enable ibi function")
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- rebase to i3c/next branch
- add Reviewed tag of Miquel Raynal
---
 drivers/i3c/master/svc-i3c-master.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index c53f2b27662f4..c1ee3828e7eec 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -130,8 +130,8 @@
 #define SVC_I3C_PPBAUD_MAX 15
 #define SVC_I3C_QUICK_I2C_CLK 4170000
 
-#define SVC_I3C_EVENT_IBI	BIT(0)
-#define SVC_I3C_EVENT_HOTJOIN	BIT(1)
+#define SVC_I3C_EVENT_IBI	GENMASK(7, 0)
+#define SVC_I3C_EVENT_HOTJOIN	BIT(31)
 
 struct svc_i3c_cmd {
 	u8 addr;
@@ -214,7 +214,7 @@ struct svc_i3c_master {
 		spinlock_t lock;
 	} ibi;
 	struct mutex lock;
-	int enabled_events;
+	u32 enabled_events;
 	u32 mctrl_config;
 };
 
@@ -1688,7 +1688,7 @@ static int svc_i3c_master_enable_ibi(struct i3c_dev_desc *dev)
 		return ret;
 	}
 
-	master->enabled_events |= SVC_I3C_EVENT_IBI;
+	master->enabled_events++;
 	svc_i3c_master_enable_interrupts(master, SVC_I3C_MINT_SLVSTART);
 
 	return i3c_master_enec_locked(m, dev->info.dyn_addr, I3C_CCC_EVENT_SIR);
@@ -1700,7 +1700,7 @@ static int svc_i3c_master_disable_ibi(struct i3c_dev_desc *dev)
 	struct svc_i3c_master *master = to_svc_i3c_master(m);
 	int ret;
 
-	master->enabled_events &= ~SVC_I3C_EVENT_IBI;
+	master->enabled_events--;
 	if (!master->enabled_events)
 		svc_i3c_master_disable_interrupts(master);
 
-- 
2.34.1


