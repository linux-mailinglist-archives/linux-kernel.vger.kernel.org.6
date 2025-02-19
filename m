Return-Path: <linux-kernel+bounces-522304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC89A3C87A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B13771897B73
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADD622F169;
	Wed, 19 Feb 2025 19:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GjmrmTZx"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013052.outbound.protection.outlook.com [40.107.159.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB56022DF95;
	Wed, 19 Feb 2025 19:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739992899; cv=fail; b=h8mQcBNzLkDHD/3zPWBYeFG8RtYki63agHiew7Ff2BaCb3DP2jOROhRsaI/K4nZw9utHIk4msLP3bFdLLWjyzkK8hsfxCqNT7VOoildZaiEM+AJwJ2uDhXnA44r47tzlUOSzJdOkjSa9YM9BgPhUxqLzFr0o/ppbMGi5yOjQHhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739992899; c=relaxed/simple;
	bh=HB2M4mmem+LEaZA8cBc7gNKDJk1S/qVysta3Mg7BdoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KN4C7RezZ6TwwkjTQcuuT7kAWQIupqvpMsBw3zV210brAQ61UjuP3Yoa7ut43ZJR4rvRPE6ZrbJ83TehOQE2rn6NIiwr+RETovg9TXOiB+1l8hw3ZqFInwmTxgwqtMZ0PTOHEZhfqq46kXyxUrCMUgApO5E32RxkGmuc2vZk510=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GjmrmTZx; arc=fail smtp.client-ip=40.107.159.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYGgckFIm58g5YS9H1nvnvyi39mBtsMXopuE8hT/0xPGTRScSR5NqZx6Kz1488V4jo6/SpaGPmelTeNveKTyiJ+yXnfoP0h74QgFU0HCepoVj/dPRzokR6co6AkdH5hQ63I+ZJoUaL+TIl/GgoyyPvno7gPncy3/T6YC0to4K+6kZTbeuDuxB/tXua9LWZA8PQJzQrHsxVWO+lECmSpk+MpzJ1z38chQQByKl/YSKK8XOQWVos5NyI3ZWJFCd4/1T9jikwOwROeggY33SzzPrLP4VEmMN/ODBK++UmvjmijfEi1xzR1+2M2daaTHA5JbY/ndFP8fo2tI5O/hTNASCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqZSJpLrcpGZWcw8qdjiFDPLAhhKvA719XjuzQ5VDoU=;
 b=PExyV5cyQ9WADVtIEdy4m6O/YlXWHxsEc/D4+4IN5wb4kcPve9EcblNi0PeV+oYMJJG39HpHRa87wfctYa1exQA34Tw1FVKLen3dpVtQyWoId/xTVzkhMrDVF+ttQtjNvuwG6sNOp0h4aR57jCbOY6FU7VoN3E767dhTrnuq4CnQg1nCTuxvgIwCpOhAW/HQfB5YFIodM+DuSxOyr7ulLUBrzz+T/kT7oSzroGa1Kd/9mWQ2RA8t9eiSbS37NzWzXiBfZqnDJNTg2kKREIIp0HYDyEyt0nw91jP0PCc0aqiliQTvupgfFI4/MWGUu24tApq7fC8e+Nl+wpkbDMKIJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqZSJpLrcpGZWcw8qdjiFDPLAhhKvA719XjuzQ5VDoU=;
 b=GjmrmTZxGdVpwp087+dPnwCkxWddEu/NN1kOAwkSgkeWsr/BqA9O5/a04y2pYFa/5iE3nu4b/VMbEBWJfFhtb2/og/ev22ilWUzN15P8kFRGYBtbHl6ZwX4CLth3DJqdArvEMvUA1WXqVU/I/lw4MUGhWeOYv7CVbZ6OnJY1tfPlcBm8g1fxcG+5Wn6ozwZZSkey6ocukrX7MSZudzKHAGmYqDH0bjN9FDtsiDREnKST+Qor6t9iZzoD14BJ0/DASW64rE7ovUxsgbJwAldeOPhr6Bs/h/XUd+26xpgkIsMGQPJger0AH8HChqpdgIRy0SU8qBKv2gKyuANkBYQ1xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by VI0PR04MB10951.eurprd04.prod.outlook.com (2603:10a6:800:25c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 19:21:29 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 19:21:29 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: p.zabel@pengutronix.de,
	robh@kernel.org,
	shawnguo@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	mathieu.poirier@linaro.org,
	shengjiu.wang@nxp.com,
	Frank.Li@nxp.com,
	peng.fan@nxp.com,
	laurentiu.mihalcea@nxp.com,
	iuliana.prodan@nxp.com,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 6/8] reset: imx8mp-audiomix: Introduce active_low configuration option
Date: Wed, 19 Feb 2025 21:21:00 +0200
Message-Id: <20250219192102.423850-7-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250219192102.423850-1-daniel.baluta@nxp.com>
References: <20250219192102.423850-1-daniel.baluta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0267.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::34) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|VI0PR04MB10951:EE_
X-MS-Office365-Filtering-Correlation-Id: 37745722-b490-4a3c-48ad-08dd511a9ca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|52116014|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LnuxNfSOksxCRRblr0IPe4UoMxYt7PajIcbahrWYZeqmXLNhfenM42olmO7n?=
 =?us-ascii?Q?mVTY7dQwwA3UrB6pQqJJCaZmkFXCyqWlE2d3UI4sobJIXtDgpHViUKJ1AFvo?=
 =?us-ascii?Q?WjB9y0b/MyLlfm6dELwVgym4VPheJidE4GBciwO4G1GDgzXUgAOGPG4yxDeJ?=
 =?us-ascii?Q?+UHlZYiStvthQOi4oHBarimncz38kjcM5oMJ3oQzLZ07bJdpulJ2b16fwRZt?=
 =?us-ascii?Q?wJUDRs1pi8s1+F+GWpWn//J0L/qiacDYxIC7sQJQKH7KiHXxKScj0MO5m3NS?=
 =?us-ascii?Q?o0sIm+2jvhtOZv0jPeeN1/FGiYIH6mPmKKBwfh85R9XBIYofr5WWKDDR1KbQ?=
 =?us-ascii?Q?UbgQBF8DTSe80d6MgHicutYrHr+53XwfM4PnLQqAwhoIgQ176CtJEqMXo6D3?=
 =?us-ascii?Q?rQcmkqiYOnfGwZUWzaieqC9CFjxGIUABkjecZfssR0XZFzAtBlUw8GPlDaQE?=
 =?us-ascii?Q?dA5i2qRsDZ3zsn7WJMzAAriDGqJHYl3CB22yp4ckMzXFnE16/ssQcVkKuwa7?=
 =?us-ascii?Q?/WYL3TmSvJaqvF6w37Vn3zGeygkW705Ozi/fcmFn7cgG7iUopArSaAYK7rc0?=
 =?us-ascii?Q?zvzktCP3z+VodJSHDHKoGm5rjyXR501FDuD1DfzDCREIlG+aFsZX6dQhWQOC?=
 =?us-ascii?Q?VO+NxuWD0uxI931sxhbyNLInEnbIKn+BtUXQISli6TG8kiU1E17nEwN1+iXX?=
 =?us-ascii?Q?c1hsqd7nSVqm+D5F7jilZzn6u8lee99Gq2zrmFZVzASMAjoLKDRLY6RgnJVX?=
 =?us-ascii?Q?q0RBJgNRu/AS+ICak5eNmeZsaYSz9JlcbY3JqFbEXM/zTAO8TKMH2DlMa4ZF?=
 =?us-ascii?Q?UNAC+TXxjOok9yHq5FQezW9iIOaIfu8STWQ/H9nGPmiwtwkl90K+VhT4chAc?=
 =?us-ascii?Q?m9TOp07D+WtGTbnXACgz+FN+yMpYkdVijnuHQ+VwpheRUC6hoARoiWIaFgSL?=
 =?us-ascii?Q?y1+NdzAE97+hll0a6Fzi53n2rLU289qBkxMLU8nFtkffkVJGQIWxnev8gxJ6?=
 =?us-ascii?Q?bkbhlQPqf8IS8QIxoDQqOWmzwdOdsjXnvae+Cao5mRqJhIfBEDHPx2FWbJKa?=
 =?us-ascii?Q?Z3WDIUYiu/kGGSCcddtY9RwAucHeE1+W4ApXnp9sBoAljKVYKIRVV4MlUJ2q?=
 =?us-ascii?Q?1aHAQKnvnvw0XF5MaR2Qv0nFSRsez3fCzvt1QfUhn5vAy4csheRsOSY4KM5N?=
 =?us-ascii?Q?1+LqLHaU4KOgkAIBNQVKIX6meZkUJOoGiOfY4iZJ7qkhALMgUVZtZN/O7YbX?=
 =?us-ascii?Q?wkL0Z/aKOHo+JVc6Bc8Xu4yZJkZ/bfWILQ0IPkATuw5G8TWaOmeBHvFsIxPn?=
 =?us-ascii?Q?PHS5rrMNIKSvAuZd59EPOYqca6uXnVL1utCCxayLFG872nRQvqrgs7nc70Z/?=
 =?us-ascii?Q?VNUnycBxeyNAR6KT4kKK6q3lIohZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?duaEtgyGNF3I2ojfUnZareWjH0yfMLJarDwqvHK0vA/xh2Hucvc8uK08dvMO?=
 =?us-ascii?Q?1nZgf7PCJb8BntukvtVUODVJ8yiMMHdOPx5WSTEl6breyExahNfNUDzT15bB?=
 =?us-ascii?Q?35KsWfZWwku215zLVMMvqm62Oikn9QM1IiTsXtngDdF4Bsnc+jG8vgDaX5rJ?=
 =?us-ascii?Q?/KerDQzQswHpnWY3AODzUMP4W6bWWZP7hz5/HsDJpTERclbRxgsciugDcY3Q?=
 =?us-ascii?Q?3NdkVcz3jTUhA3DpnJW8SGS9gkfbJIZzcSM0MFhKVz53YuP4PwkR4Ky8Zwcl?=
 =?us-ascii?Q?BTUJY+3gS1IaDBhme2UGJ3cfhKmKRBha/SMARd8Cadu7dFGUxzraBqs5U8On?=
 =?us-ascii?Q?dGEplvGaixinQj15+imPNDEVSQsHpCfUUrvQk0tMW/GobZE3o5PmYkNmU/+4?=
 =?us-ascii?Q?y5PoNNMuczFMb6V59hJUuIp8oTZcLG1bUzqdxyFfd9tb6KdcPDe7WUMMHb56?=
 =?us-ascii?Q?NbtXoplmTEtzxwUjQBbt1yx7PyqX9VPat/x6Nik5b6O7qXI9orPtIIE444Rc?=
 =?us-ascii?Q?gwMyvzyobEG3Y9ud8O575Z1jkym/LgXKNpawpxP1Pd6pF+DMPkQbCz3/Z/DV?=
 =?us-ascii?Q?WloVvEKeFIzCIC4u3d4lpM0HIQ8SLBobs3ABPywRzO5myEZqKu/qiOFzeVRD?=
 =?us-ascii?Q?/bXwkDxxOu7CtsBYswDid3tEUPa215DlfxYQLpVE8dXNdWIrJpgW1CK6Zjd6?=
 =?us-ascii?Q?lVYx+3euicYF3fVOesG1rZhJJtAU1r4tpVqmS0f7BNuqjaQPHsUMP91gWeVH?=
 =?us-ascii?Q?RhOGAuFRVQ3BE2XUDmzO3IfKJSe9rHfT/VbwuI3weHqHwYRKFdPoxbJaDRGh?=
 =?us-ascii?Q?fgi2IojUnB2o11LiWH9fAzYPwpnLQSUTZVLBq+4FRP365PRt/V+TCYtN4PdH?=
 =?us-ascii?Q?QGKDj1aXgPSRvgKF6NqnwUGYNbzeKAM8lcqjA8gY88bSfltkkVa+EgKl1rP0?=
 =?us-ascii?Q?/GRXhZ4B4dUxlSK3SynmBa/xjsuADwSJxw0rAHyCTPy24nXzMsZ+bth6Q+v7?=
 =?us-ascii?Q?w5Q++psUFxvjCI93W+pQymPjOMKxXUGOC5Ls8ht9wOuz4lx7S2WdUz7QaaRh?=
 =?us-ascii?Q?eSSBdu9CV6q2Bz5S5JhnC8xc0yTLpRZnIYRC4xtdRNcUeJX2EIKs1Y9c2qsv?=
 =?us-ascii?Q?M63oua90bu2ja2TegEE7RMb4C6rePGVY+GDNJaH47J2deQKfbn58rUqm7kJI?=
 =?us-ascii?Q?kW3GrVxS83hkCwmNMYKQrBWRvhjT8tyApBwFqVJ6e9pq/sFkEvegXCwLoToA?=
 =?us-ascii?Q?lrJK6Kgv1L/msS0kSQD07DmMzXni7QVl/Aji6L/ljj2Z+TTEyN0lBil8H424?=
 =?us-ascii?Q?acT1o0dWp119Hp1oepN8TbV8ZnFK7SjFkqEhc8rJVIP0BFSMuR+BZXicgCyb?=
 =?us-ascii?Q?GBPvy+hFF35dtkMUW3ihzeIhi+4jZeiJXMHuZMyau7pxyMkkE4F/LteLwCs+?=
 =?us-ascii?Q?qFu5xKdPkSAA6ZVnFzuCk+GYlgrdnWiDHtyoFlwWq+a9tBDBl7V83yuKNJpw?=
 =?us-ascii?Q?8Kmvo9eWzph8KyPBbnZSxIaE03v76rncqAsq+baTbpA6fi8yxSWwwqR5pYsI?=
 =?us-ascii?Q?xooIg6IVcqqTwVDHhKnG86UB+I1EYvPM0caTfdX38hrhuSFxOKYBG21EQVQy?=
 =?us-ascii?Q?IFoTyJh4UsKoobUu1MBjZZredeI/5zMo7tVki+wQbpsEl8IvBpcSrilAe8iu?=
 =?us-ascii?Q?OSMdUg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37745722-b490-4a3c-48ad-08dd511a9ca8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 19:21:29.7365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bahk7JhKAt7koaWr6b+k3zD4n4FfiNz239srAYn+fVGpO+qqBknctQpvPw1hf39CjRDwgs4EVI4jBX8V59PosQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10951

For EARC and EARC PHY the reset happens when clearing the reset bits.
Refactor assert/deassert function in order to take into account the
active_low configuration option.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/reset/reset-imx8mp-audiomix.c | 41 ++++++++++++++-------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
index 17f78ccc7820..42539cafbccc 100644
--- a/drivers/reset/reset-imx8mp-audiomix.c
+++ b/drivers/reset/reset-imx8mp-audiomix.c
@@ -19,16 +19,19 @@
 struct imx8mp_reset_map {
 	unsigned int offset;
 	unsigned int mask;
+	bool active_low;
 };
 
 static const struct imx8mp_reset_map reset_map[] = {
 	[IMX8MP_AUDIOMIX_EARC] = {
 		.offset	= IMX8MP_AUDIOMIX_EARC_OFFSET,
 		.mask	= IMX8MP_AUDIOMIX_EARC_RESET_MASK,
+		.active_low = true,
 	},
 	[IMX8MP_AUDIOMIX_EARC_PHY] = {
 		.offset	= IMX8MP_AUDIOMIX_EARC_OFFSET,
 		.mask	= IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK,
+		.active_low = true,
 	},
 };
 
@@ -43,42 +46,42 @@ static struct imx8mp_audiomix_reset *to_imx8mp_audiomix_reset(struct reset_contr
 	return container_of(rcdev, struct imx8mp_audiomix_reset, rcdev);
 }
 
-static int imx8mp_audiomix_reset_assert(struct reset_controller_dev *rcdev,
-					unsigned long id)
+static int imx8mp_audiomix_update(struct reset_controller_dev *rcdev,
+				  unsigned long id, bool assert)
 {
 	struct imx8mp_audiomix_reset *priv = to_imx8mp_audiomix_reset(rcdev);
 	void __iomem *reg_addr = priv->base;
-	unsigned int mask, offset, reg;
-	unsigned long flags;
+	unsigned int mask, offset, active_low;
+	unsigned long reg, flags;
 
 	mask = reset_map[id].mask;
 	offset = reset_map[id].offset;
+	active_low = reset_map[id].active_low;
 
 	spin_lock_irqsave(&priv->lock, flags);
+
 	reg = readl(reg_addr + offset);
-	writel(reg & ~mask, reg_addr + offset);
+	if (active_low ^ assert)
+		reg |= mask;
+	else
+		reg &= ~mask;
+	writel(reg, reg_addr + offset);
+
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
 }
 
+static int imx8mp_audiomix_reset_assert(struct reset_controller_dev *rcdev,
+					unsigned long id)
+{
+	return imx8mp_audiomix_update(rcdev, id, true);
+}
+
 static int imx8mp_audiomix_reset_deassert(struct reset_controller_dev *rcdev,
 					  unsigned long id)
 {
-	struct imx8mp_audiomix_reset *priv = to_imx8mp_audiomix_reset(rcdev);
-	void __iomem *reg_addr = priv->base;
-	unsigned int mask, offset, reg;
-	unsigned long flags;
-
-	mask = reset_map[id].mask;
-	offset = reset_map[id].offset;
-
-	spin_lock_irqsave(&priv->lock, flags);
-	reg = readl(reg_addr + offset);
-	writel(reg | mask, reg_addr + offset);
-	spin_unlock_irqrestore(&priv->lock, flags);
-
-	return 0;
+	return imx8mp_audiomix_update(rcdev, id, false);
 }
 
 static const struct reset_control_ops imx8mp_audiomix_reset_ops = {
-- 
2.25.1


