Return-Path: <linux-kernel+bounces-312628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56211969911
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9BBE1F265EA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E751B9833;
	Tue,  3 Sep 2024 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="muQCbDsM"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76681AD276;
	Tue,  3 Sep 2024 09:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725355811; cv=fail; b=HZtG3uTsQ5a8WBxeKWmcuQvszgOqnXaqJDu2et2/VH6MHXyohwr3+rY6Joz9sByUMxyYqf/JkzqcW1IPpLVV0ozi5oWwfwiJV7w6Zm6piqalkZ6hsDsbV4EuQisONNzg4UHWociqBMWvAs+Vr+IsKGSyhgk1kSjViAhXf4lUT7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725355811; c=relaxed/simple;
	bh=ySPsgBcx21f9QEB3cbhg8DG/keAtJWSzqxdelT3HUh0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QRyRofxHSOBAsP3aD0KjD7GDkN08Ezv5YA8PnFCzYM3SNY9fMBP9XXtUDHzO1QJ6Wqij+F96IS6zKxQsXOe/7n0I9jrG8ct8M3IZ5M5pNCunRDtp3wM/QR+r9NqvIyL1WtuwS11wmlQmid6CPyOc7Mkxy6w6arRFWEB8BXP4rzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=muQCbDsM; arc=fail smtp.client-ip=40.107.21.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vEUcVs6qJrmX0TvoUr7iVMwI+Z93rr68ijgE+mIknUb4hHm2PpufuXCLCU8jDdLVEW6nvuOCitocYeRN9AaUS0BKN8kLAhSxu/XESEBMXZjRmwNY+izPFkccjUjQLTY8roukP3cH6mCHHECoZRXvBRrYe6TdIUTq7BwoLVHeuyuG++aNgYDhQKYyvLOXNFYM+CNNSlpQrzdmLqZsJ60g8hxxxx7d8hUG0vogNr/jvz0Y4FWJ7mrPO5vJz6bP58New5sDFLjZKdi8K/sE5kE4uHnShLpH8OhaywcGLTXJzSArLXF9b/y+48+sPVGZ6eCqOGvp+PaI+R2OnZGZOI3n5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLcb4RF9LAhuQIBlrefIgHm94V2jbcFjbodcFQfE3EA=;
 b=Q/enyPRPRJbQTA8PUkLbAkhuUIPweYd7yFJhqcjvGJ43LuQXbtFitxnZal1lxm/KkW2PldqyLN5lZIKoNlsHbpM4a9+kbv+hzaZ7JDrR5vAQodVPCJ0zvLBgyeMYCR0IOnSuczsvZfLZLppXXQqwcMoqbmiDHpHIxHTeVCMFsAtZ8SLk2TDC2A3NkGcYVqEXw9GbdzdjaOaCK51g2PaAnUexCQZaYowRrPKDhlUIIoaiQwGGr0TRdU++yYj6eNbr9WxiPcTDA7S6n8Y+T4GXN0ILnJ2hDU5SVV91/5klHwAceoLC6N00mKFb0sDaqtxb9GpCLQSMY5lsBwZ3N7UNGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLcb4RF9LAhuQIBlrefIgHm94V2jbcFjbodcFQfE3EA=;
 b=muQCbDsM18/j1ZzfdW1CRDada25xYc+CE8yKZgpDOEdXMu4rttUHA0qx6iBZ4iI/clV4J9HuJLmZeTtJWEVs0RyhQGgKPjOlnj6c+5KE/aJGi0Pkbdeb8HeRPNRCUMg9a4ApVSE3HssY4toUd8mmT5kP4mT9gVvcAhl61oV9MnbYYzloHazEzcf0cRpzGtjrJItBeMSgyiW240Qjlh/3rY3UnMX6ned97hzaISADU3Xx88mfuTD0wOmU33AtyUb4jE+LnkdYeypYc+eTjNGUYQ90/rZL7jB+mYuW2Y3w6xVtmWeGEcP+HRjyaRXnqXn+GQrkzZi9VoleDA6oRHMMvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by PA2PR04MB10412.eurprd04.prod.outlook.com (2603:10a6:102:41d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 09:30:05 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb%4]) with mapi id 15.20.7918.019; Tue, 3 Sep 2024
 09:30:05 +0000
From: Carlos Song <carlos.song@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	frank.li@nxp.com,
	Carlos Song <carlos.song@nxp.com>
Subject: [PATCH] arm64: dts: imx93-11x11-evk: remove redundant "sleep" pinctrl in lpi2c2 node
Date: Tue,  3 Sep 2024 17:39:11 +0800
Message-Id: <20240903093911.3235306-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::27)
 To VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|PA2PR04MB10412:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1335a3-3048-421f-19a6-08dccbfafe74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iGFx1b9bEREKJ7Vj8YAWcbB0T8d7rt6JQSbMscOPO0gB6B2ufxphBwLvvLHy?=
 =?us-ascii?Q?xDJ7lO4PCYtim+cdfbT30O4E2TDmsQWTAJhy/ZpNJu6GJ3dubn4BbIDffrDg?=
 =?us-ascii?Q?yj832Zb04NcWP/fzD8ARLRgMqAAogZKyXUuxEyfCvE8ddDn2t/zztDnZ/I43?=
 =?us-ascii?Q?PquJqYrWH3/ve74uxwpuWphyK48fWW9Dm5gAmI7ObNogzth+MEnUO33mSqT4?=
 =?us-ascii?Q?xttnwVUDZDYIsYHca7vXYPfbpM7/f7y1lYUus9QhUp9DwUK6wfiV5OSVu/y3?=
 =?us-ascii?Q?hXPy/5ImTEQO1P5RsBT7QTrKrEoNMRiuV+HxwHmPaYW9BiHEYrsNo0nWD9aX?=
 =?us-ascii?Q?u+6pxsZBd8hwvYlM9Waj/WBG7wLqY1Fu3rcRF0DKMzGkfj5mUBTq0e5fZOj5?=
 =?us-ascii?Q?nKjlUJFU5DH2aFmqHCoF3EGfi8bNGG6csV+eCDd4gbcB+wui7e/kb+exAxz0?=
 =?us-ascii?Q?HETF+Weudb44Qzi+9MV9Hh7gjFK/gtZjJNxj+m0MKKDFJJGYINVDDVaOKBFd?=
 =?us-ascii?Q?WYjzHA9CqMZq07n3Hu9Ga7xWbg7DuLVb1Eltb8FeCxnW0EDH/cE5rDn4BoW2?=
 =?us-ascii?Q?Vqk/VipB1DRY/rUwWqeaDCEkx9dyzQlMlG+RK1MRxjn1oyz//abVKt3Pnq1D?=
 =?us-ascii?Q?XhdxkujU1ncGZ5kkJZPNaG9qbW5m/SdWlfl2QrRg0xcrAkM5MDpy/ryU93iE?=
 =?us-ascii?Q?fOk3Qg6CkygEjH/oRXP1/YBAcZgCWpLwTBm9zUwX+hYSbJLc2IpjhL2/AqvO?=
 =?us-ascii?Q?/oeqfIEeX0M2Od8dlKStXXzeMhUITNgzQjd9RJ41OmGA62YjinVniNZ1byO3?=
 =?us-ascii?Q?QzCVeMCQFwVkmGXuqz/hAeAxe+43VzJRyzVkXz7359uAwbvHj4pxM5WTMLi8?=
 =?us-ascii?Q?MUo5URHGxhR7iLPANkOyh51v7vCc1k4pgBPa5VQ7Fg9vthTSNc/AsJtSvEw5?=
 =?us-ascii?Q?R+FeeGnNXde6uydXaBHs8bwphUNM2FUEsWwux6Wek3rZEfXG/IqCc0IcVciW?=
 =?us-ascii?Q?FAsEyPJfwURgMOCsdVZVvOfPBx8nO4pnuDwluV95MwxRO9wQdulZVPiaTE4G?=
 =?us-ascii?Q?p5tc3j6WiAFqpf6VkP2EGSYOIC4JvXduz+lNOTlqigWY3m8rk3ixzL3xG0qs?=
 =?us-ascii?Q?MeHPnmucJ24fZU0CFZ8EEAhArak4t+qYJGuXAmh+u+ogMK0sVpwKvLS4lZtI?=
 =?us-ascii?Q?7hnosutSUmxm6itpHxTRzt6LtEXoHQ9gUaNfN8qRQdlR27nKRzZnRrNK64VT?=
 =?us-ascii?Q?kUjBSchYe7Qnkk4nXfkgiRYfg9MeSb0yBMkXE9jg57WxX0+gz8k2FHs0WAdH?=
 =?us-ascii?Q?Qo6bs/lqab0p4caxKnZzExeijNiULj3+Dc3TxNmUe9hr0SXeVSL70h31Q7//?=
 =?us-ascii?Q?/paA6M+oYGEIsbA7dT882OH+PKQ/vHDM5H1xS3XISbValPPiIw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4tmrQB/Y08Ycn7WlsmJHNukqYCL3a5fpY8t2syt4AID1e2QYR9X3Qd2TQJrQ?=
 =?us-ascii?Q?fGTSuZkVyMlIzFjEPoA0jlU6MsvQOu2AFnlo7+IUbK4KYnrYt0nPaow8UKF6?=
 =?us-ascii?Q?+RzTaGRYKZulc1CSn6SY54QANsFLVYfqb5lgDK40q0/7OxYSh7ThZe6gz4iT?=
 =?us-ascii?Q?QzxcGnWlmwl6TSfKO1M0Q9UCrL2pJrW+cTbVqOubmUsPH910KTVjZiEz/yhf?=
 =?us-ascii?Q?COeGfGUL2GW6hE8PfbguTtSNB1QY/T30rLtTq1aL4mpn28gBcdzRYGwhqTCJ?=
 =?us-ascii?Q?XfO6aSQ4rQY/mIYyX3UmZQyfUZD0Olu6v8tMXZrCihiusAsH6o7OEeZLXhRB?=
 =?us-ascii?Q?FF2C4sv2y9xTjwjyvy+MirSpi0Itx/OkQybnkyNC72fMiVArL/YA7v01FQLJ?=
 =?us-ascii?Q?hD+g2GTjsK0LJHIQQ7o7PTK/q2wrg5eIRhELOvttJpzJxW9wUlCMFyDOEph4?=
 =?us-ascii?Q?rgQ8RzmbdksJ8WL6TxGzUtoYE2rsokLchp4FtxUnBixQrxk9Sl9UjUCQ6nxr?=
 =?us-ascii?Q?5uW075wMG9wER3mh+BUxhGBzadTOS6s7DB+tQX8HDy0Bzz4TNb9l8Qdtr4s4?=
 =?us-ascii?Q?a78D8ymg0jW+bldb7P/3Mx1M2N0qxPi9F0tQZ7lx+E2UMRwbabLvWH/yneeH?=
 =?us-ascii?Q?odYAvl+YFYBxs9EeMBGO5XCJUXhKTXwudlAkqUniAMoVp0FHiH4L7Qfn/hC6?=
 =?us-ascii?Q?0+pDqLI/KUpS7s8chAc2cSXElufTAcXH+PfWGh8zY9zK20ZCg9XKWgFD/WGo?=
 =?us-ascii?Q?nmjScxcv2Io5my1LdoaDq9ouLYl1BFKqZHfQ9TN3wJHhosWP9xvauMa7y8wb?=
 =?us-ascii?Q?Gmxq5dY6+mFqv0zvJstjS07dbQPrFAmad+TJ08q4oaR+Omjtz3CoyLZyupkM?=
 =?us-ascii?Q?tTZq70VxT5qnWC/b54BX2CjK4fgZM1R0igKbmOUFndJi9GIh4bkCGfnT7kpE?=
 =?us-ascii?Q?FPJdAfqOdiAwb6XhP0a3Uj7ll2Tc2oiIZVgGKYuqPpVfNPTJn5T+JbGrYi0K?=
 =?us-ascii?Q?H8rf3y3k9sfEOggRJfmK/INcvU1Rp42v4oASaOYKsEKPGYTqwDwPo27PUYJH?=
 =?us-ascii?Q?nyWv3EO597lM1QBhqVVywiVQFTsmeb5hLC+xPYBCtqjY1B7HLTwZNGL8uyYZ?=
 =?us-ascii?Q?245zU5qlmpJXMLggf9cnPua3+sHpHWkOmHJgWczjXKu76pdLxxM0Xzsq72Ed?=
 =?us-ascii?Q?58o1oKz6Jamy7MtwatXssD8L8TgXquGjyJSmwUObQeM2KBDpRLSvwQykGqpa?=
 =?us-ascii?Q?LhSq5YosRzYnJ5g3SOqSoqpKMwLcVVjRtvpca3vzODsT4bD/CPsaFpRsQ98C?=
 =?us-ascii?Q?PiMMhZn/bk5Myb6om+tfaoMgCusLuPgNEdsDVQB0nz6M+B/vxRiQ6XLsj7cY?=
 =?us-ascii?Q?G0hpmXE8DXE7H73HBGL39EXk2oS60EXQa5KmT1C/HkAnCQvvwG6iRVfXL+eU?=
 =?us-ascii?Q?KMOmqdKF0/APNCUEfHTUkG3zLsr7N/dVEVrF48pkeR11Nut+Y+1ZLJdY5UoY?=
 =?us-ascii?Q?PyanwksleM7YrkCgmXMaGhPTag0/njHYbgfUCfZVfHwI7VMxhLMrHBwnadtr?=
 =?us-ascii?Q?fKc621YlsVbbnl5GRJ1diyDK4rC4EN8ulmU86pS/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1335a3-3048-421f-19a6-08dccbfafe74
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 09:30:05.4446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9s1QrF5nLpJYVJrvbDdK/drgz71vTKDJIY2hMN9IPbvjL8clslsrHCu2GgW/6mGiJBeD0KyEwXgJodc5Y+o8iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10412

In lpi2c2 node, default pinctrl and sleep pinctrl have the same value.
So "sleep" pinctrl is redundant and remove it.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 8d036b3962e9..ca6de0e3a2d9 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -230,9 +230,8 @@ inertial-meter@6a {
 
 &lpi2c2 {
 	clock-frequency = <400000>;
-	pinctrl-names = "default", "sleep";
+	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpi2c2>;
-	pinctrl-1 = <&pinctrl_lpi2c2>;
 	status = "okay";
 
 	pcal6524: gpio@22 {
-- 
2.34.1


