Return-Path: <linux-kernel+bounces-193959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C36C8D3493
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B322895DD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34023169AD0;
	Wed, 29 May 2024 10:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AOPQbc39"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD7D73475;
	Wed, 29 May 2024 10:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716978653; cv=fail; b=n87PL8fWNVaEnbJ5xYKVnZktgwqdN9ZbZH1T14v0QO8Na3PbKH/PJfHVEWpLeY3l+MltjxHsckIZzck7nyoa07f2BEBZpCd5VMHoK/0tlDOe9+sJ8subtRJj6PYHEy4Qg/jPd/svULjENDWGD6H1GAXkQzJhQUuHMTnjhJ5rSyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716978653; c=relaxed/simple;
	bh=LvfgtV3fKEW4IMqYiDv05a8c++Tz00oypwbKwQhrF3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VPlXdMlMbN6cj6iLextINgV+zUg4Kb2ArTuT2gt9mfC/v7F4TA6AdR+XNQmzs7tMCy2DR8NPO1jdiQgPAMxLWyQT5ZW8O1Qb854rORrx68WSvjrTGQQi1MEuCFzaLEGYv3c1xdJdyC87COpO4eRBb3t9e9aFWldmGJxvZPvNOZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AOPQbc39; arc=fail smtp.client-ip=40.107.20.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qi4OO/RoIkln4MQYCaNNQ+whHpnQDUcb/tEvD8HTDrP3F4mHglw8r+I+j1s5F83wZ4U4Bk/QVgJFZdE6pdytQJKfpuugwv5GLif84TM8FkaRc0iOxuSNmWVVLPFpJlQQx+hUzcdXLcmB+Vc/GGr+HUyOnLBa5SBdIB1vdKopc0AzMLF+3iSZWt3RD9qFAtKQX953PMIyAK4QFMQhEYs/lQ7AqZrhg8PkyokU8XU3UQUZwPkUrb0EE4FXxufnGxQv/jFYEcioCS0i4cihOdCpZpzWUKQsuWzYF7VRyg8bej6BgwQw2JzQzCsegawelxC8RWrzcsdyvNVgWAA2cZXyew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuXeZjy97dzmj+XaUtWsUKigfAY7eWC/uXA8vKM8bUY=;
 b=UWfhPaHU61ZybJV4yF58TLvAlahJxO2vfl1iVjaj/SQC2OvIPkCT+lCrOHNa10AomTnkximR5w7cbxBnSqJezu3ZhtlaKi+Wjj0G3FNWRakmNj/XzMwuUaoWqtJV96GD6u0imVMQiqaZDbGhLPM5G6z5Kzzrvl/M7dRRZ70D/VPw03mJtHRwmdJqsuyztMpS5EuNkYP+f7NWUn5FXPhFHZthbK2mUL/ywYzlomY0lB+HB/cDPeyTrF9CJM7sXE8R31cpTZaYm8pFoj2P4JeQzDP1Rbl8TkdYJ2H5NzyyvDhXwpIKRl+GzxicLUgx2b/bKxCOzhBhWvbLlTqu7FG8sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuXeZjy97dzmj+XaUtWsUKigfAY7eWC/uXA8vKM8bUY=;
 b=AOPQbc39snb+KGOW5BcjooPvaUQsQQwYai88GWOVqrJxvoVaZJP7iOZB2wpu7fet+LeAjUHUTfAV0Aq0nGCUUd7JFUAiDk+/guQa/V1NUXo82axyixy0Wh6p0Bsj84InFvQeBmyl44+cEj1YkKRJpFeyfH4p6tbkJEE+fLOaJKY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DB9PR04MB8393.eurprd04.prod.outlook.com (2603:10a6:10:25f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 10:30:48 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%4]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 10:30:48 +0000
From: Pengfei Li <pengfei.li_1@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	ping.bai@nxp.com,
	ye.li@nxp.com,
	peng.fan@nxp.com,
	aisheng.dong@nxp.com,
	frank.li@nxp.com
Cc: tharvey@gateworks.com,
	alexander.stein@ew.tq-group.com,
	gregor.herburger@ew.tq-group.com,
	hiago.franco@toradex.com,
	joao.goncalves@toradex.com,
	hvilleneuve@dimonoff.com,
	Markus.Niebel@ew.tq-group.com,
	m.felsch@pengutronix.de,
	m.othacehe@gmail.com,
	bhelgaas@google.com,
	leoyang.li@nxp.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	pengfei.li_1@nxp.com
Subject: [PATCH v2 2/5] dt-bindings: clock: Add i.MX91 clock definition
Date: Wed, 29 May 2024 19:26:31 -0700
Message-Id: <20240530022634.2062084-3-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530022634.2062084-1-pengfei.li_1@nxp.com>
References: <20240530022634.2062084-1-pengfei.li_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0029.eurprd04.prod.outlook.com
 (2603:10a6:208:122::42) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|DB9PR04MB8393:EE_
X-MS-Office365-Filtering-Correlation-Id: e670d2cd-396b-4b04-f5f4-08dc7fca67b1
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230031|366007|376005|1800799015|52116005|7416005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?kp4JQRJyd8tTkCEChq60ayqDO5rmc+AY0UFWyc6O5Oy4pF7cBjbUfR0hWtDz?=
 =?us-ascii?Q?jyXPsDimv0HcdXgm+5tNFdbEHXZSg8ojT0nudBbxfBUQ+sPTUH4Mjr3t+hRJ?=
 =?us-ascii?Q?NJHHWCk35/e2O/S732iLGwn0r546dqug2fhVyEzegYkHFPiEGOurBZKJWcJ9?=
 =?us-ascii?Q?sYiyShZFKx/rNwgz+14Ja5H51+IosI+sz63bn70jCASL29aEoqRRW71aKzFQ?=
 =?us-ascii?Q?LLY7ZCbTMGLDKKN4eVzKXacRLhYMQhlYgtoIM8ySF1+xQSacMoFhmJ3guwlW?=
 =?us-ascii?Q?IJWhsAAdoA9iWuUhcKTHgNo9SHWoDyxDCHo0DpM7JylYTCsEbDy1mzUoFYBa?=
 =?us-ascii?Q?4n52YFT1D8Adg7GdDjmkuRzcA0/+cI7LQxNBLsrYKrmnpl9o1+d6uGObmikB?=
 =?us-ascii?Q?6VkpPwrhxg3Ho3u1Irws/o87KPbantOVQ54FEU2ZrlMQ1m/M+knxF9jrddce?=
 =?us-ascii?Q?RYugQOXnE2aYdApP+v00wucdwDcnUQqjLWkpuzxLEM5hC1DEkiRb2oHw3+dX?=
 =?us-ascii?Q?FqWKfwQC1Wm8CN4g1x1VatVdguAg2iUHr8dWdFTxHCWhvZWVBKF2nAHjVQWg?=
 =?us-ascii?Q?Fr/W3xSXAGIfOz11Vay/ERSegWQKsVdAIvmIF/kCGudH4OTdSPJUwg7IseKH?=
 =?us-ascii?Q?G41dimnE5wUvJYV52ES3+wZzsAdQ5egedZcSdXscDIU0h5ZU0DL0JFPOd1MV?=
 =?us-ascii?Q?QhQAjnf3eBw4RI6+sud8yRbU+1J2tjHt3d+S941wLcuRBvarwr0v+QWnwaKv?=
 =?us-ascii?Q?VIFDIyLoEObWobj7j0yLhB0Q7QQGhKRv1Jpy4KTa1E8adcc3F8zGFFM7OC3G?=
 =?us-ascii?Q?dZIaDWLlIcbHnrxEHOOCMnQqRf7Lqf0ZyRLnj8Nx0qI3Ug2EOXB0VWa45i3f?=
 =?us-ascii?Q?kp9H0T5LyAQhT29hEj+tEJdQ5zFZuVNfA1EJZ8fo0LT/vCsC9pmA73oFWfcY?=
 =?us-ascii?Q?CmABshfnltzN3uRcDVIClUihvso15msgn4ddNmLIbAX3h9V9sawuIQcOzd7n?=
 =?us-ascii?Q?K6m8/Wpf1an7SLIykDIpcwSoSAdyO7BnGltu87N6NZFesnPJrgf/RtJmLOvt?=
 =?us-ascii?Q?0v8Xw/9Ih5V1LUgZJUA5SNVEhLioW8XzLZNIzm9G9SeXz/GYi4O31CMG6RyD?=
 =?us-ascii?Q?6a8kN+LBO9EOnSC/nTSXGDacaFMx0I76WgIXbvCe+Am66ULxJih9TvmVfbvj?=
 =?us-ascii?Q?1s8lHHI5zQTxALQuyIstQlIr17hZKqbisVsa5yeO7pCRnqEWkAKLH2SztbCI?=
 =?us-ascii?Q?CFs9OTQc5T6pGa5A/U71LJEwu3uZIGTu0QgggHYQ6Ah++bTenbz855V74gc+?=
 =?us-ascii?Q?dZtFW4lnvFl0QfJwb5uK0q/fr7fEqIBzg39rBPUOVZpEIj/M3qxsBD8dgRf2?=
 =?us-ascii?Q?d921/mA=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(7416005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?9dVPaLMbpD5C/L6jN7QRd+lvn/3HrLPVKafifMfJ7qv/j5V2x1XWt5MfAiJ1?=
 =?us-ascii?Q?nHpOK/v61ItS2VZVuPKjspssYHAr0gi/jmSNLEmgyZdp8cc8/jyLA5sjbNew?=
 =?us-ascii?Q?o+huhcjizU5TdiZr0O1WZr5XXYnyiixztDvgrXfZedtWUm9J87xVqMNz7tXE?=
 =?us-ascii?Q?fTFLTYt0dsFnQXDEmxpQ4yyD1LKmhDqkDe+d0lIaVa2f1mYSHNvK6d4ZM/zV?=
 =?us-ascii?Q?3I7UHki3MfS+bunraLLPfPUcN4Vq9p4UG6ur0DZDj5DRn7dQIeowG74eEeAr?=
 =?us-ascii?Q?71zfXfgHn3Ws265pPFaHOJ/9Vupz8zSY5vgcghv75hxMonQOS3VPkuNCAac2?=
 =?us-ascii?Q?e691Hq1/tybkShHOSg29fr0e1ryq7pr1w6AG6NpkrgUEfLcRwf1zAQ+ljM8M?=
 =?us-ascii?Q?Srgj2sSaH+j0IjT994UhjiyrOim0NtmhQHqmcZTjsw8kJQJcTBEO5HYKZ+yG?=
 =?us-ascii?Q?KplYTtBpABDC/CBuY9235juW/G8Ivy+4gCXcDJfrPICXifOzw3hE66a4bP+y?=
 =?us-ascii?Q?W+h77Ww1pYiNZ9DqMYTuy2mrB3K5ZzpXQT6+ZAqdmjuVzQqvkvCMlHr57FQ6?=
 =?us-ascii?Q?PCAFM0G4OO5mKDUREMJmb6JDGxDu8yGkSR1S/RQQFdf8TMAXnbxn2YwgOvOf?=
 =?us-ascii?Q?7bqh6Op9O/mDH/jrcLoEnXOqpW7/pbDEDEgC5K+E/veB5U01sRLCjF8urttw?=
 =?us-ascii?Q?pLXSVIOsgNT30Gfp7kW+FwtzP5JG1abRICGT7viJ/ASxcO/y7cKdpxPesvS4?=
 =?us-ascii?Q?7ybdbPFbMEbGcZFDDV9NnkmV80JnMdeEcRvN+zY9AaSwl3G/XnP7rsxYInMj?=
 =?us-ascii?Q?H7Xnlt8kQzpKq/6UxRyqt43qGYa3sxk+vg856Waf/w9XEbHPnD9Mzr84lJEg?=
 =?us-ascii?Q?ywiN+p+FnGm2KOU56dYk0bZWrLLsMucyHJGg5D5HZ5UDS4uDpGwXHRjeJ+og?=
 =?us-ascii?Q?m0DVuJY0CyjUpxGOpb9gsrwtlMKKYEE0fBlXvbg0xC8KThBwf/OtiRAtbSle?=
 =?us-ascii?Q?X4Qx4a0jDOw6kMWl4kWriD1pVTO/NqCGhuDCMkrT4FrBgOcTOgYRC5EqoN6J?=
 =?us-ascii?Q?TzTRat3pDUUTr3huv1ZnbXo4Ps7CYBQguz3YGENuEHtBaMS9IWc78fIXg11k?=
 =?us-ascii?Q?5gEV3fmvmECh4tDLKSrHT5LwM0lli7vjpGyKmp1qsCFf26UnPCilN/NV1neS?=
 =?us-ascii?Q?QO+s5Ke9npKO+KnNN552+/vmIbiPygME6a6ngouUJt3lXjc+2OKBFaD2FJEM?=
 =?us-ascii?Q?HMg/E8KbtFfxwit8PdVaYQxMk5frSnW5nW9vw1bbn/7L+DwD8uevo36iGmOZ?=
 =?us-ascii?Q?7WfqXJMKnPcNbEyCjzIZU6gzczOMmHFvdmC+u/u2ehYNjRTVYpyfLXQU4TP/?=
 =?us-ascii?Q?XviolqrKOFrR/OQLjH1zx6l+s/DrAkhA3kaCSLBVTHpxnn47GDHymC8PuGaJ?=
 =?us-ascii?Q?ZI6di8uIdM5+I7F/xJewhuVFenbsZh7bK0djsH8zttal75AqggHKdf2TuPP3?=
 =?us-ascii?Q?+Znq64Askej8mfLwiuTm5vrQkQWnJ3HbOCvpnvXcBQhmdW1btM1Y7tmHQwv8?=
 =?us-ascii?Q?mXiSIIxsDLAqbu4ujVeiFZBHfMqKnB86B/5p8QL9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e670d2cd-396b-4b04-f5f4-08dc7fca67b1
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 10:30:48.3456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1pNy8GnDF2+YHg/+E3F7dJbMfvVoyClzPa6woCK1SkfB3GNVXACp2l7DtpIzFSAq7tJrab2UseK2c97HmVYLFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8393

i.MX91 is similar with i.MX93, only add few new clock compared to i.MX93.
Add i.MX91 related clock definition.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 include/dt-bindings/clock/imx93-clock.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
index 787c9e74dc96..ca0785f35a46 100644
--- a/include/dt-bindings/clock/imx93-clock.h
+++ b/include/dt-bindings/clock/imx93-clock.h
@@ -204,6 +204,11 @@
 #define IMX93_CLK_A55_SEL		199
 #define IMX93_CLK_A55_CORE		200
 #define IMX93_CLK_PDM_IPG		201
-#define IMX93_CLK_END			202
+#define IMX91_CLK_ENET1_QOS_TSN     202
+#define IMX91_CLK_ENET_TIMER        203
+#define IMX91_CLK_ENET2_REGULAR     204
+#define IMX91_CLK_ENET2_REGULAR_GATE		205
+#define IMX91_CLK_ENET1_QOS_TSN_GATE		206
+#define IMX93_CLK_END			207
 
 #endif
-- 
2.34.1


