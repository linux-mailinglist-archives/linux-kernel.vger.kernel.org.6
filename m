Return-Path: <linux-kernel+bounces-304188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 483E8961B90
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 03:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 877D0B21C73
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 01:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976583B1A2;
	Wed, 28 Aug 2024 01:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jhpNqb2V"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011010.outbound.protection.outlook.com [52.101.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8AF3A8D0
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 01:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724809147; cv=fail; b=mkoNcHG/fze2JvP6PKlTrdLDJWB8U5t8JFCB8JO1OZjr22q/e0OHzCVUNIibwHJLsjUIB0dmmKC5miqkmP4uH1mD6VoNq1/3pHgmn8SY8YZ6vng56TqZicjT11teZrU+30uuzF/0rZxHwig771gY925PrWlNAZ2VNI7v5toUow8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724809147; c=relaxed/simple;
	bh=t0Cwlg9ymWY2x5C44lcvrz0hbFckQ+DjAPzhowdA2to=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rViwR4B/bWc6rE/Zjr6a1oASnEXIe8gMDquQvYciAUSgTRefF/UcxBy5RZSSvgjaYw7vdPx0ODABL03XzlQdOtaystMbEH7YIna0juIotZfxW3GOAFm0xAe3lRoTJShybhiShsI0XKpFwiNtn/x4WEvxyVk5p6n1I4mV5Jp7FIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jhpNqb2V; arc=fail smtp.client-ip=52.101.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qriBAaSmPeKhuXQ+LmDVPQfMqjIXMFeUbgpa6gZWqqHI9ND44aRrY/miPFABDwIwTU38508nOksWqtijugaX+2YT+6L9zu1XqENYo++fI8dplbQ58tm+tnDH3BP6eyaQCt0So3SwObR4BXo8LR1Pr5pKCj0Lak8mmohlB02EojMf+0vpnvRr/XPYqHCyf7UihA0lqbvMvD2Sh5p+6s10LHh/otPvywUqAkzEeQaE7Mky01r0lXSfsqP/QkLcCcO6M+xvMKBebOFDVV4QJ/MHRlMDuzDiWRokn4nHYtGH1/umIHVR08RwL7RbwGwbuu3u1NUizhhgPOgVZKB07O49ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpCpcvAWJPMmC81dbO31zj4MTYU5R5uum5Kcs7/G7ZE=;
 b=eHj46qqKuhInJEfEUbzLUTcE6prPwAkdQesv+maS9YpxqFTTF+Uq9UtF6u2aQ+v4/7zPfzOVscO6YWmRSbtWMFSZTFE3Kb0fVU6/C3Z/gLD/LuidEq/XV9F8saURJ/2MEwAczzYzLtHUGp1rwb/IL5qQzZ1sIUZJmJpDAcnCEYI7e5rjft1cOt7sKOO9+o83azTKaJIQ/lejulVRDRuVEMscepIMRjfl8jvejafXrdDK85nR2SBxDZ3MaiuF8VX1tBkcyhEurftYurXJyVdvviz160Jn7yfqgTg+XqMfKfHt7HRVwcdax4q6BknqHjNSaDua/IrOiBOab0QBp8PLrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpCpcvAWJPMmC81dbO31zj4MTYU5R5uum5Kcs7/G7ZE=;
 b=jhpNqb2VNQXGCHZIYXkdO6hqnQzmSUytLt9Na2CKEF51lVn2iJkd/7aZKWAjm/1tCG4c51QXo89/7GJiPWC1QzhuPlwSBOk2ZZFFDdvyxxPx/lQ/P1VraGsCpIoOKa47FM9gowL5zQrfNPbpGN4E1fXMrUqdBAjt9B0XwmHR7O2ptsW7xaWnfbwS97YMS0z8PYA4NNs4K7HTU0Mg36T0ilr+9aVDUa3YUJ+6KMb55GrwTwI0aKcYz4CE3lqlk8PcOFP91y1xm/Lzl1JX3vdPEZ47i2Ix+L+ToXV+HNWxyRSf2/2axDYjx0/QfAOVpzQnJCFl2C0qLqX1f8qEP+KpdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB8329.eurprd04.prod.outlook.com (2603:10a6:10:24c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 01:39:01 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 01:39:01 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	festevam@gmail.com,
	imx@lists.linux.dev,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] firmware: arm_scmi: imx: add MODULE_LICENSE/DESCRIPTION
Date: Wed, 28 Aug 2024 09:47:46 +0800
Message-Id: <20240828014746.1713728-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: c280e247-2127-42c3-57f4-08dcc7023173
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RPFr18qCUUpb+EQofGzDTEEEciHXQJDTVs6HeVHp5h77QROw6vsPPmO/up6h?=
 =?us-ascii?Q?f/qUX7Mz3qNZg3Mncg7oLnfY+AVVvwkQlfv7Lfi7cTzM8QI68jAvmJVjP8EK?=
 =?us-ascii?Q?i56q5oJACb5bHoktgtwxkeMUoaOpoRVe8Q6nME5C8J+sz5JKEVEPWfA6qVF+?=
 =?us-ascii?Q?IYvkZQWLkWMgd/k0i1ZNjlNJQNUlvhoUTp8xmatyV8oNKVlcYE5aW0TtstGj?=
 =?us-ascii?Q?LjQsS7u1KmiIwG+ZZ8AvFQIuBuKfARmnMDh2StnV5QzJQoD399WTo7RZ4qoU?=
 =?us-ascii?Q?L0mIxpZTqxB5JGgHs1HwWJn24s1ccWTaIAXH6QKBrXKwNqfwsWeCHGvA3U8/?=
 =?us-ascii?Q?3JC8G5+6hGHUB/LEFzIg9wtemSO9lVIII7cqDW1hO9zwPyrrYix8DCLjnsUg?=
 =?us-ascii?Q?pi3yjK09wuNUC13SOCEQrt2Vj9m+C8eFIXIkLkGrEHPEywZ0VtKiCCK8ZYph?=
 =?us-ascii?Q?BT9dIKeiTL11JrqYlpE0hzz+OVbi5X9S4ED645cRcOMmpqwStNtZKKkTU6+P?=
 =?us-ascii?Q?9PxtNCJLE0v88TPxWZfTkdEi+VtsQeivKr7SBNnP4y/F126p/uK+XQrfOjd3?=
 =?us-ascii?Q?Tbkxop+vQ6ZSZ8xzwIxVoG7i6w6nS7jySxJZK89aKQRe3V/X+2rwflA8L1Rg?=
 =?us-ascii?Q?OCOJBX2BF7gyjCbJjjFyu92P7DkgP/ytpuJk9s8uMXCQy/woodKcX+4MQ/50?=
 =?us-ascii?Q?HkFICZGPId/ToDNzXvY6DUIdemPNhxQOkoVpCEq2//c8E8uH9qeR3hSD+lX7?=
 =?us-ascii?Q?dUHESfu84hK4AG1SOOPh2NORM0cyEdu/DzuLd8AW0ISiXW1I+2vPakaH00a3?=
 =?us-ascii?Q?E6loDaK5SM4MBEQ89Zvvo+579np+ySNY+mWMLwyUsKYvkLuxWYT/VbTVWLha?=
 =?us-ascii?Q?UySQRfNf4YX5OOzEiBj5tYQQ4drLeHQlJ/iV6w2VjvNo2rcn2aAa76iFktaY?=
 =?us-ascii?Q?1IVPa9nM27Ia7FB1R2RpPWX8tUZBD6qCA48rMzwH54/N+sgyUfH41GGQi797?=
 =?us-ascii?Q?JHIbS29jrmvksvaAzI99wBG4HCrUvK/xMys8SfX6AZR5cBKVhFx7UE6JBu/m?=
 =?us-ascii?Q?RIZm3hm3lk6/s1XizVmIdchcgXA9AZvChS2ilayEQ5cbz9CK8gdkRuQlrPdN?=
 =?us-ascii?Q?Uc4T1GyiE74ej/uQ3ImH4gTiAPtatw6KzCPyiouoXaU5Ljg3qOWqk4UTH1as?=
 =?us-ascii?Q?Kbyh6c4N4uowI80Jkz6JpN4kEUTT0TH2RQicAwTuX5XhUSyV5ePIGD9Rqa6k?=
 =?us-ascii?Q?5bykeSU8KZ20r+D3pCWG/2nnN7kAztAC71fZilR/7TEsV+WudXyTqYfZVHR/?=
 =?us-ascii?Q?VW3ExOB2e54hhACh6THfLPgiwslc1s4zZ9if3q7iHAEVWYw5RCIxbVIM0RT1?=
 =?us-ascii?Q?SjZJ64D+ORSnrbNj7O2vOZBMGmM789rb6uT2AevU3jdOzwQJZw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0sEihPVg1l1LAdIEMsCkGuJBThZ927rWq3eHKXq9dDjT7iwSTBJUy6fGWf1z?=
 =?us-ascii?Q?eVMaGDQfex70mnEcV+9XNf3d/RBmaCPnyyrj6nnBZVv5k0WJMze3qy/+HOK5?=
 =?us-ascii?Q?ZgflBF2mfFmZJTFC+r8UJBCoWmWvQ1Z22RDPBaXsLYtwGPieha1ME3K3giX0?=
 =?us-ascii?Q?C4dHRr47mDJovq8XicnoL3FVdz1Z8xqumH0f8LZC/GTYbzecIsEBrQOx6Bqr?=
 =?us-ascii?Q?ZZvrNoHfair/GRH+4nfNC6+LN5KD3IH/Me+AHPb348vJ8VUYGcBv34GPzgwA?=
 =?us-ascii?Q?1khSrK/qWPNeTSbLJNlqSiQxdgH+Zp1qojTm8oK+it7Fwf4alp4WAlbwsig3?=
 =?us-ascii?Q?9XjUiIrz97guQC1/kLTW9zOg8UT46eMlYp8h5dn31cpuNywKHvL/v2Z8RyJo?=
 =?us-ascii?Q?EHH/Ib2q2W/t7Tk1EhkHPx2NBGXk+2+zyBDIkRW9WqFWtY14q7u91Kktvu0c?=
 =?us-ascii?Q?T7yeJzPk+KvBMAJ+qfem19sCtVIQEvGb4PHpdpTGIekIs24LY+AxzaFlp4Mg?=
 =?us-ascii?Q?H28JQnU5MfHtU+azNS0wtIHCMfA/Z51myhrqkDdzpbvPH0KH9fiKE9GowF+U?=
 =?us-ascii?Q?2uxV3A26TErypBPBuryJZKc90hIo+0pETzQijzgM2rxVAXt2HINWEAhI+P95?=
 =?us-ascii?Q?Qd2UMoHmIMu3XaOmniuD/2TI27MPao4Zerrbv4TdJwTgi71kgsZbzewO+Qk3?=
 =?us-ascii?Q?w2mlH0h8UfROQGwwWuNcYEnXzU04v4I4MpxKgSSz9Ve1zmIDZx1dgMN70RXB?=
 =?us-ascii?Q?cRV6lEfscAYwpe0jA2iSzefeGmCTW7J+KFkAIJSOA93BRgeGke3Oo4Yms/9U?=
 =?us-ascii?Q?10rgBQQnXdIi+CaLKHPkjfU9zwx+X2otYTWB7b9H0ULVZQyVPFaR2ae73pti?=
 =?us-ascii?Q?I8X2UExcYnkX8BC8Dz1KVFZKIwUlw5ubnTM8h79IArXEPdC9BYdLmzYG2xbP?=
 =?us-ascii?Q?JggyUfJ7kPhg218DWtGze4JUSD2QBFQK7q6bAQr5Fn2TCAoRjjoX7af3x5cN?=
 =?us-ascii?Q?YWZSo3zxleX/vhMC2NQgq8mvzLoH9natmgU7RfjUp8nXtpqbWhWZWY165+X9?=
 =?us-ascii?Q?bzSYvZCDXTeS94BNfA+5sFGYrcZJyouL0Fq9YKbedRAwDZG+9iOiZ4F7qHK5?=
 =?us-ascii?Q?q62ZQiVek23mggYDKBzwJEZJQugHqp4aLfJI1xYv+GTrC8MzUs11POyXjP6E?=
 =?us-ascii?Q?AA27ENfGqH1ZeBCwa7KDEI8nKd/7QcAxN9V55CxelBXxSjy7OU0Jxdxazgvf?=
 =?us-ascii?Q?YCzY7nNeyT8U0vEZ+TUx0/RPNCmVsv32XGjUPH3kKsA8M30PJI017OnB41CD?=
 =?us-ascii?Q?4XR0A8LWM6GQ8IAPn4H8o8SW6NZ/vedi1G2CXJX3wi8kcT8ZUq7URAB090HQ?=
 =?us-ascii?Q?sUpuwjFXpkqjkIMx6hbYytdAey52OsurqZAZTcKSoljjiUYT+TT6M79Px5pU?=
 =?us-ascii?Q?X761J956XDdAtlZOBxnf+N2zAvYyBQsduyXi6sy+e00ZBZqXGa62eD7XYS3e?=
 =?us-ascii?Q?u5f7o0cYUMmV6w9ptn3JRxS5AZt5ZcGuX+PVzOa+msCMX2v41web8uHJhJK3?=
 =?us-ascii?Q?FdFZoBNyb9NXCat31fLNSa+yoxqrXGhE25ECAQHk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c280e247-2127-42c3-57f4-08dcc7023173
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 01:39:01.6400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZHyWYpGf4EKuO+JGPp7Z3glzLhMP7ig8keU5DqbqkdNBaMyAGDd1RoDj9ClJ7TOMxaSC3NpYJ3zNHrVLogDC/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8329

From: Peng Fan <peng.fan@nxp.com>

Add missing MODULE_LICENSE and MODULE_DESCRIPTION

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

Hi Sudeep,
 My bad for not build this as module. If you need me fix the previous patchset,
 please let me know.
Thanks,
Peng.

 drivers/firmware/arm_scmi/vendors/imx/imx-sm-bbm.c  | 3 +++
 drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-bbm.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-bbm.c
index 0df7ca135c34..ad8734d2aeab 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-bbm.c
+++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-bbm.c
@@ -377,3 +377,6 @@ static const struct scmi_protocol scmi_imx_bbm = {
 	.sub_vendor_id = "IMX",
 };
 module_scmi_protocol(scmi_imx_bbm);
+
+MODULE_DESCRIPTION("i.MX SCMI BBM driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
index 9ee2d204d607..1d339cfa6ecf 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
+++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
@@ -313,3 +313,6 @@ static const struct scmi_protocol scmi_imx_misc = {
 	.sub_vendor_id = "IMX",
 };
 module_scmi_protocol(scmi_imx_misc);
+
+MODULE_DESCRIPTION("i.MX SCMI BBM driver");
+MODULE_LICENSE("GPL");
-- 
2.37.1


