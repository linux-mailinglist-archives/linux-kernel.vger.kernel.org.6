Return-Path: <linux-kernel+bounces-400290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E759C0B79
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DB2A1C23B3B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BCC216DEB;
	Thu,  7 Nov 2024 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i0UkCpzA"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011061.outbound.protection.outlook.com [52.101.70.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D58A218307;
	Thu,  7 Nov 2024 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996361; cv=fail; b=N9PFnTw2fkK+d5qn6LQcLHWDa+MQWZp6iOZJGa5UeXXrKxuIYZY+ODzoiYCOFaWpl4jZyCow3Zo2VmMFRifSjDz+QN2rthOy88gzDrXswuhpsLD8+LxGmMk6snpeiEnAESzVqI2kLFs783w4+H1BrBhxQ33sfeQUtRMUqiTiCQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996361; c=relaxed/simple;
	bh=xOZkI2AWZ4MYMUbHfE8rGO2bzzHp/tuR5RPAoKoEeCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nK9oeLU7SGdlvVn9uGUq5HrKo4Qhjc1uCSKlzYV8vTYN3vh9mMZsBwyLBi6lEwToK/0ZnAm+lmx8N6C4+PF6wIcug3R+TdU7dlpYYI4R9Jh7aXqIUu8rdQR3EUQnW+oXQkr6HHekXOaZug/+rvW8uwnJKcYw8cMQ0JeBoIhNWAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i0UkCpzA; arc=fail smtp.client-ip=52.101.70.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFv5SDzT2m2nezJYoPGvM0a7+dP9F1ij6nfhinng2eR1B7ChMopKwWM/bGhGikU447tmhkfbZsbih0DhV6QXq7YRnaaYcxXl6S79xVx+YtB/0/ohehocggI1q8LOxhKST06i/0nUC3u0hoX+Od5DNd/zgsL0AeijXT/Nh/iKvxSU4GSEJ7N0GMVRqWkxGD/Ni87h9jeoXLYPgkDlcKbKldwXAthVXFYXDu2tg/hVPv9y6DeAKWky+eK2Euvot3i2CJkJVeoNU06yOu8ZnZ4M8tAqlX8Dh4b1186hsz+NpZg0TGh+asvCsqp3lvt9HBmalPyur3hSO1wPn2621CxP7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfl2RQM2vUt74rF0H5+FvREd59Jr8QzLueZuE5DBmUc=;
 b=zIa1geB4aTKV0bLZiJeloX+G6LrAuPpbpu2WeksZlBCbNC44UNdVRis6uWpmrM9cw/q+mK6uFc4HQmQBZNvmJQK1ZieedjfUTMFy++wjk9E2aQKEBqIXutomeP5FgAqo40t5J2FBrsPQ5LESfYwlgd17Ysbv++jUzqf2mHn67YZpikrIbcmGK94smFmUm07piYgps2h+jpnX3z/qBaVDwjmm1+bCrsHBbSRORkp1HUSyMbgLIsrWcx0h1UJAdB9MTqwhMo34pNXzv9Wtq7Z2LMZgTn5PGgsKNNdY0Wv7CZDylBoxnnHSxaY4zb5iD34PWBc7VEJljufk3RUdnVIQFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfl2RQM2vUt74rF0H5+FvREd59Jr8QzLueZuE5DBmUc=;
 b=i0UkCpzAjc6ng0xQNK7+UzC+g/14lQVMRg5F3Tr9ZxKXLKFfFM04AJTyFp7iD+dYnidWMUwrp4neOYhVMqTUexexwBz0ZbZSOgw1TnRyVKccjIvCYH/Y4U1+e4s9qMOnI6f7oTsWbunPEPlAQDHfXqFSUvHz+qInTYje/LWRLS3O8QHxcENv2R+Dqo6O13C2dY2vAxjqj9ZbF7tZl27QSFUqtcyj4tdmwl0YamJM+j/szTcMrLUPa+bp+yhtw1CSfrxEdwDQTbEQl8/YGa4ExA0ZnFytAZJNhKWM4NZRkuzMqPtknkBB0aWb30ykNB0hHtP8uvlPOdl/DwuAWQlbCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB9014.eurprd04.prod.outlook.com (2603:10a6:20b:430::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 16:19:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 16:19:14 +0000
Date: Thu, 7 Nov 2024 11:19:03 -0500
From: Frank Li <Frank.li@nxp.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
	shengjiu.wang@gmail.com, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: imx93: Use IMX93_CLK_SPDIF_IPG as SPDIF
 IPG clock
Message-ID: <Zyzod4k+LNkpJdMA@lizhi-Precision-Tower-5810>
References: <20241107102008.3626023-1-shengjiu.wang@nxp.com>
 <20241107102008.3626023-4-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107102008.3626023-4-shengjiu.wang@nxp.com>
X-ClientProxiedBy: BYAPR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::40) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB9014:EE_
X-MS-Office365-Filtering-Correlation-Id: a498c00f-a0cd-4e4d-669c-08dcff47eb79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3NB2RobFtjrQDDtTeKFZj5nC9+Ta5ZgaIXFxfJT7vqXn4pFLtcmqp287cYyz?=
 =?us-ascii?Q?n7jzDEob/bGJ7nzCIxMrE6UWGFMFJ5s8dDyY5aGMs76yUITFnuTGD9XkIqHp?=
 =?us-ascii?Q?kvqCxAlreN3kPHla3hSbeFPqucR3TA2Hr9ZYMZiZDIRafIfUQWcs620dRcYt?=
 =?us-ascii?Q?e+EIMXRStI3fLB5YuEesZ19xni/kCFLjIsUDoVOmLODYtmGrZYghjx1qqhho?=
 =?us-ascii?Q?e5CRWolW2naXlth+BMm4t1MUXRm2A5h5bZNf5zCdHWnIUVtnRXXxvY6UsPhm?=
 =?us-ascii?Q?sSN+HPNLhfUTxb5rd/i9bfkEjAMZb0u/U8AJ9+K2bp+poxGmwdc6R8RC7RQ5?=
 =?us-ascii?Q?DxGK/9BpTotFeFqV/U2bBvh5LXOk5DB3NihLshy3YSkxii8cjxuA1L+vRggG?=
 =?us-ascii?Q?/yS6GuEMvh9xpO3gtA/dLOxjn8l/BntU5+TtOx5S9ITu670GVca34ttsl0J+?=
 =?us-ascii?Q?62/anJi5f9V6g2P44Tqn35unSzRctTnnKhRYDBXtL6JkLlDSx5MWfNImn4oi?=
 =?us-ascii?Q?s54aiY7wYjNJYaCOKf9c2YlRSLBKYxvEP08bMoxTJjKwf7natea5YGnNOTgp?=
 =?us-ascii?Q?hrbYoL/1Rv8Y42CVImv/98uJ8ucxpTXpCZ9OE4pX1JFTjYSTdSyd4uFCu4B5?=
 =?us-ascii?Q?5n00mI6BzKUGz14qYKRaqFkb4d0NePaFc4EojixlWMaFhvUhCqL0TkAd2gbc?=
 =?us-ascii?Q?U4lloYH6A8bkeV33AAjhXBIgnI6rWtKw10Twqca7tS9b2RLxvMSoLcE6XpT2?=
 =?us-ascii?Q?jidqIgemezXJV+YWZvM4pgnfyQ/QopZSR4ivHaba/eeBcwE6N0ydSuFO66r/?=
 =?us-ascii?Q?yz+IlTplLxY7zJM4gzv0ioh8UfbeZPscuJD2YZxYQOSCjZu3qHLl7Ud2GT4r?=
 =?us-ascii?Q?Z7j+biq+zlNuLnJpWTBVMJ2QqaHwf3t8yNsLk+mC8/Aicm64y0JvV3qs4uuG?=
 =?us-ascii?Q?ACDQO52/RMQaLs1i4Ak1IzNyju05Uat1qpNhV3Ely+RjMd1gURrNOXd2dEpZ?=
 =?us-ascii?Q?dpCTLO7X1KfulC5G63qUUFDWa7VrNobWijWHgpE+OC5I0y9+5BvUJgwdeqzw?=
 =?us-ascii?Q?db7YiqtNKECRrPp52eWGKUR3ck2PSFBJYfutI6gg6Iw/C8x9sJjFFay1jyVg?=
 =?us-ascii?Q?5WMHvG9AglHR4T+vzNfsmPL/s0dhPagTSXcDLwqmsUTqo7dMHKF+YqjanLf0?=
 =?us-ascii?Q?J5ZPXiAAzxuX9FAnjnEQMphIwkapXkTZGEgl0x+3CFgvWEo5yY9q/E8vSwFA?=
 =?us-ascii?Q?T2ZEBCyNsTZHPwJGDiqDSV8C9Tu9WAvzKE2Bqe8NOJnH66ejpg06HxT+U584?=
 =?us-ascii?Q?ulxdWGFq8szovtrIGaPILRXx4zwVB/JUHOy8n0R/snY3DuZVjrUcSq8UenZK?=
 =?us-ascii?Q?UfPaXoo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YoD7oh2w77+dc4WgnAXERLsBpUpm5csd48XgZFmQqs7DlohYWTsMCwjQzblO?=
 =?us-ascii?Q?GbpKZWTnzZCWe+jlHANztZxJNCdv/VbAiivaF4zoUL3RzfXS0PtsKEaMnlUt?=
 =?us-ascii?Q?pX9A9CymXuCs13oHfKfsuRqUiAe0RTgkLOYqBu88Q85JQUmWYn48SqSoli+l?=
 =?us-ascii?Q?OPJk+lANj6hls36zTHDD1z4SLZABDkaA7aU0pQYR3K2I/26Vcp3vlEnLmKNE?=
 =?us-ascii?Q?07wrPasbBKMb9rCoBRs7KJHJ1AkSVsSy8YFPSur84EuYfp8wwyjzyEUEKUcX?=
 =?us-ascii?Q?EQCJHi6Ll6GTVflZsK1omXxET3virkXd/9Y3nniVnNaVJhCPMPaTSEy3i6mH?=
 =?us-ascii?Q?8HQkNAqJYDe1kMBumUN4xcvn14F3154im7BBEG2yHyTlD0spJdaG6Y3P5/kH?=
 =?us-ascii?Q?14R60+jVwMIT2iGMBtAPk3JO+kLQ+NQDjBf+n0L5Smcq/k8PLPWop/jmEpWH?=
 =?us-ascii?Q?XKRvset+5ot/Qhjc/cxr2WHWFX/d4n8xmNna+DDEZT5KaD5qPAMo0LHnljaE?=
 =?us-ascii?Q?roj/RtcJcbpqlyAdEF+IFKg2WZSNYiqAV2Dn3AhCipWz4aBCMIAAKKABXfYY?=
 =?us-ascii?Q?CVqg9BORlyMWbBBrGSa5428J9FRNdnQbwOAxih4ZUGjEpLeSDC2gwj/q02M/?=
 =?us-ascii?Q?H4IwS4hwB8UBxet20CTMLJ45c9BwDO9DMUkkeUKePQcd/pUEALEOG8Kp8zMg?=
 =?us-ascii?Q?DqXKbVPVFNwsmkMIHsu5dcyuBe/cXUKfVT77B3PVdmcsIW57Xaj4bX7lMEmy?=
 =?us-ascii?Q?1BdKHIPUmP5BBabrV7han63WUQQRXRFU7x01MXz+2/w/E8aoSF/Bw0KkDFsz?=
 =?us-ascii?Q?Vt4vPyss+FjLBZVIfLSUH+jXo4iONuuJIBNi8PaJDLrolUr54uCtCfXg6wYy?=
 =?us-ascii?Q?vQmWwwnMy1U7dJSe/ruYueJioMuuxZe1LTnIcjFm1Z7QPlZP3AWWk9TdgqId?=
 =?us-ascii?Q?heCehX+FPF1lMNA3nqykS81VwCNNYMbT0KNeEBRYVpX3SlmUyp8VkycASiLq?=
 =?us-ascii?Q?NkNqTw/vk/H8J2kaamRe6VUbDWelENCyOyGSQVFGw9pvcS75hk0vWuc6Q2aY?=
 =?us-ascii?Q?QQBSGHGkV0X6yeRnOdtVUHW9OBHFc9lqwHUcruVaYoDs0m+5kjuHE7R3iwUR?=
 =?us-ascii?Q?pZYwSrqkeZlXMcpxtVm0XMXXpD2PlYFHO+MBq8clFA1jH57TSUqLOkQatbvH?=
 =?us-ascii?Q?7y+Eu/g5uZHmheoPvW4tCnagpgejQshPgXVuYyJlD8TadLwpJbiRKeB8iLrT?=
 =?us-ascii?Q?vASeqSzdyQF4RenYIk4jIJUtmpCMh6Bw06HP1Khb8R3ga3Kzygd1DEkeMD3m?=
 =?us-ascii?Q?oG8yWI1CoYarziDvp+S8BQLdWHVSbU1kAYtIkLAqc4j/6qry70oXjikD/pe1?=
 =?us-ascii?Q?GS/1E3AP1oB6pX1GNznnQR/p42vgZEheo9RoRjMsVrLIgbYYnXSkfFXs8z6R?=
 =?us-ascii?Q?0PARU7tQ+HUml4TVCH7TPNN0ZJ0eriVwZeflVi20y8x9Jqnpz1ljlPU2FmoB?=
 =?us-ascii?Q?H2SVG5ha1tY58ovGpNlAeVh4+ifJKbtx9dC/o/QV53fq4kSzsEyI9Kd5+wTB?=
 =?us-ascii?Q?lvUl7fAnhT5TzHYSMoDV5F7tUB9J6VUmv5x8TZKF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a498c00f-a0cd-4e4d-669c-08dcff47eb79
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 16:19:13.9531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6K7CYeummplWOTaTbkACvaG8TZXe+j90Uid5clxYf3HJBi1rGbRRSbpyb96KZqFemo5aML0FRlnoDCMeIIROWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9014

On Thu, Nov 07, 2024 at 06:20:08PM +0800, Shengjiu Wang wrote:
> IMX93_CLK_BUS_WAKEUP is not accurate IPG clock, which missed
> the clock gate. IMX93_CLK_SPDIF_IPG is the correct clock.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---

This should be fixup. Add fixes tags.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  arch/arm64/boot/dts/freescale/imx93.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
> index 688488de8cd2..56766fdb0b1e 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -925,7 +925,7 @@ xcvr: xcvr@42680000 {
>  				reg-names = "ram", "regs", "rxfifo", "txfifo";
>  				interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
> +				clocks = <&clk IMX93_CLK_SPDIF_IPG>,
>  					 <&clk IMX93_CLK_SPDIF_GATE>,
>  					 <&clk IMX93_CLK_DUMMY>,
>  					 <&clk IMX93_CLK_AUD_XCVR_GATE>;
> --
> 2.34.1
>

