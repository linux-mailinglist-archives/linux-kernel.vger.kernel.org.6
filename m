Return-Path: <linux-kernel+bounces-197534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920AA8D6BE8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2888B23357
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD1B7FBC8;
	Fri, 31 May 2024 21:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l1Isrw8h"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A42249F9;
	Fri, 31 May 2024 21:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717192239; cv=fail; b=dBY4kzcpz82bUhq4XLYMyXyNxb0W3yQWRLgwHpc4k7DaI1RAt7+Hi5AwRkAh9363mEApu3dSVkIO3sssts3H4qUBc0Y7Q4o00bRgltkpJZXB8U7vwQk1H7fOuDKe3olRaBYVsDK3kRmY9GyVZpZQkYh1rLpJ/5ZW7q0wRsAX6AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717192239; c=relaxed/simple;
	bh=L+4qzIjxH/9hYsR+rkidtk5PwqixPVf+S+/5JZaawwI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oE4OWDaJnvMkr/rITBqNZ1dLRmyslEatoWQmCV/PxrP3HRtrzlaFqrwruUj0iSQV2dzJe8rnAKyxFugYEqB8xsRkAK8gWWbUd4DCYQZDIES6U4kGflhsBQmHwYwKyF7eHZp2uTYI/DBVXIqEELGftoKduuvY7VVbsIiTBdZNtSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=l1Isrw8h; arc=fail smtp.client-ip=40.107.7.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qjs5B9oMVXl2PgF/TCEHF0Q6jMVvgaPwTpAtlQ4g2us/GACcA1he50FRHC8WEFI7sgIP0MHIuxeE+vi6PcYoyeFlZ14zrZ+t6vk2uKfZnhQ3rWK92L3xqzj8zccacbmioaEewVpFEZ5L/lOhIJRn+/LotFr+0Kr0oxz2K/8vvvPu9oqlpVEkvTvj1Hz0d1wQatXuBY/GZxtNfOHF0FNE0j8N/8f52WMZJGNLXkSuQ/i6KTR8tG1zU4S4JYcIuuvGIBGjaIw6jwcufw8Mug2YT9Ps/nW1TqKoUwbJjPm56/GXnK28qU6pxqFm6UHNivTQtK50ejFoDw5mYN411b+AaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHm11cmihstiRcXdauEEInpyhTF+redcpz7tt9UL8ig=;
 b=H6myFSRxRAw+eah5SkVmZ/ghEj0aZwav9KE6br6rcvZQE2MYQSe+gBIUHRUUnMsZWierK4JfaVDAJF6qCutIzCU5TE4B7kzrtjYOvoc/JkhyZ2oM8fjFSV0lO40kDe3r4XyC+1Og4/B7Z76gE4DxTtAySig15B2NIwc0VdzyMj34AMwkGUEI7FR8InCV6QEAJbEDzG4WGI+Q8XZoxp43lMFyvr4Ax+rdt+T5ZNxknBUEKVeKympqJJdonYd6zggyMf9a+aafPxoFUxoTa0nED7BU9B1ZCjt82w1YquKYjcQheYe/DINvYcBX+3bEVMwdfCz37XCLnUpYj/jmxicRlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHm11cmihstiRcXdauEEInpyhTF+redcpz7tt9UL8ig=;
 b=l1Isrw8hkH65W3WLnBXwfaR0pHzq5O+oLHfzaghNV+B/INVenZP1YwOrsQ458OVhrMfemnFWtEAxAA0StrThDUr6rRObB98+fna139otD3IxvYDO6E4Lztra+9Juos+aUzj2CvKs6sNyZurIo5qiRyhR82KRyJyvxDp+HocA5bw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10748.eurprd04.prod.outlook.com (2603:10a6:102:485::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 21:50:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 21:50:34 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com,
	shawnguo@kernel.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org
Subject: [PATCH 1/4] arm64: dts: ls1012a: Reorder sai dma-names to clean up DTB_CHECK  warning
Date: Fri, 31 May 2024 17:50:14 -0400
Message-Id: <20240531215017.1969431-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0036.prod.exchangelabs.com (2603:10b6:a02:80::49)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10748:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d473445-c497-472d-5a86-08dc81bbb312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|366007|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hk+4yas1v4Qv1PUg31B+4KdJ9vT1YP1MxnaVa65fW+fgDlmJF3RYXim8WbnI?=
 =?us-ascii?Q?St+HdCY9R2luB8BbRaafKDaBfbkqkC2MP6UapYi5T7qbRAwHao9NdS4G1B4D?=
 =?us-ascii?Q?Q3HRiTBlJhdHJTeceNzxzTxQhHWkst6JEHdR5sDoNA0gw1K15Y2RAp8YbAD0?=
 =?us-ascii?Q?yJoLPOH4MIWdiGuxXB1/ttiJgX3Q96J37NPcYrKKwq+pGfgpapUamSpiWL7L?=
 =?us-ascii?Q?lCQUWaFB1bjufYotCqGiFNn9fSf4yi1VrHXgxda69BU4hgcVdk9c869VkQRl?=
 =?us-ascii?Q?l/AKP9iOrOZXn5YL32fyKUEJYS4t/s4GRwL2Mau/4lk4HgoBjv05ti2hIchJ?=
 =?us-ascii?Q?ZNzLkbkucQGz2kb/S+S+N+BSTpGho4vPwUTdDNhb/KLtDfMasjO8xeXFOBw4?=
 =?us-ascii?Q?tMpT0G8ywD4x5OSAJDC8v3rYauMXs8hTHB979+0eW3DfnFlEelk7MmKaQ+1q?=
 =?us-ascii?Q?requsDxTZXt6V78M5pFQzBFksl3spcPVlapzHL3R7yZnRSB6GcfgwWpfbUUI?=
 =?us-ascii?Q?NTSVNcpyl4SSuatP2bcPr/U2E+Sw44mgNHVENcnSub2kaUuzpE14/GWsuJ8a?=
 =?us-ascii?Q?Hbe9AdHlyslUD0RT4LVKMtx7xo3MwLFHHgxTnYYfWQzaUZkzszwXsWtEPm5i?=
 =?us-ascii?Q?8aN6OYL2njNj64MFJbHNu2XEgk5ZILWB+ybwau0K3WRqYhYdUaHgdDZW6tad?=
 =?us-ascii?Q?WnS543J4gtgTzheBfuZUzal2DCGk8VfJh6RfbSjDWg4UqeszmjIUuPfaBuCT?=
 =?us-ascii?Q?TBlv1JMQOfVB79l8EhiEpedgyGe7uRQlG34+MmnZkghHMoz7zxWV8mFiKgpT?=
 =?us-ascii?Q?XLd4gvhVBsIp1Y/R/6N/4PzNNB7NqaDaAm6rSIP31uvpeu3au9+EqquM9xpR?=
 =?us-ascii?Q?EfzHwFlQJ9L8T1doguovF1/nmGUZoaZLgeHXfC3szTA4/ElKYZRTobANw/DH?=
 =?us-ascii?Q?FolvLF7YVHZ+qi9JWL9fdK2hFO5m5d/KTT2eH3NQoJC+6gafDlJMQ/NlvkgK?=
 =?us-ascii?Q?DqvL66G60e5NaahL5n+aqi2ys5oIXZShuyEv7x9ziOvUh9Yko0d8so1JmgQk?=
 =?us-ascii?Q?z21hKgOIQN4NZiTxiMLLix6cHjVecWeGbaljZ9uDNI/0/HXK3Fuad7cKZovP?=
 =?us-ascii?Q?6pCRP9Ep+z+4Y/JXP0CRqaP693fZ4nBbHSuZ/DLUbnay5cITuNsGO2LgWWs+?=
 =?us-ascii?Q?Qf3LLErzSL2mB0rTLmc7m7Fl9VOVFYw8E8nW7IjhBp2iifOA2ZqiW/ehhqru?=
 =?us-ascii?Q?iLwv6ll721QGkv7Cutm2e6p9JnTHfcrIs1a8wJ55PhELPQUnBHCLke7d6ooV?=
 =?us-ascii?Q?zxoOlvmp0mfxce2CAG1PKAauuayIYS12E3D6nkqeCqE0cQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yj5pevPrVIO1BztshHrHC0Lxb4xn2RA7C1JvKPebucHzHWPugpKQW1QBHNd+?=
 =?us-ascii?Q?EHmSOBCyjd6L3ASbEP30RwiiEGEkT9QemdgQNcE61Lxd/nexO0rvMS+xAIqs?=
 =?us-ascii?Q?OkG1Q+fxpDq+d90Tz6ObRYWSyOZ+0I3avUwI7tP57EANIN3YbB3pk2fd4uNs?=
 =?us-ascii?Q?YE5JNCjfRfZxU6NQmA0AkmL2sRfP8IA47IEwnl4o7pLhWyXnI1VNPV6yvUOR?=
 =?us-ascii?Q?23czT9sb8Z9vzCVA9v7+yc/omT/qpyH3bxTz7g4tPd9miaBHAo5pmWSuCsM+?=
 =?us-ascii?Q?hye3EwoNNTnx/upVOefNTYS4sqTxDyXTTmZGgYf8a83PCZoHUZqU1Sq8jQLq?=
 =?us-ascii?Q?G9Q1+vU95saG8ZxTqeYLoLHGi4FXdyX92sLtHipO1pQhavB3c/QmFvGzTW9z?=
 =?us-ascii?Q?BY6c6CjfnNgghuQ8//ewJX2fM19t5PK9z91VNen16O81g25/rwMkjviyZphb?=
 =?us-ascii?Q?vZRsEMI62sIyiTWmK2d593XGyy3fKxDcoLdYKEQdA+UrGeb2Qj1Tn8EBp1Qk?=
 =?us-ascii?Q?dDgkOaVkWMukpOehkO1YQgQh41N33wFIWb3aNalUQ18ZomKPR6rChVDSlYCS?=
 =?us-ascii?Q?/qVFyLHZuSd/NfJ6ruugXFHCaC5WZm3gcuC2oiLvewBJ23ZPviy8mMe7L8mD?=
 =?us-ascii?Q?p5PBPrXyNyw/e1JdxUqaQS4nGcr5+WCKYmqOYuaCeBEjpoo2tjsROEu+V4LU?=
 =?us-ascii?Q?dB1OcSco3fDWNaP8GmcKHOf+y5Wk43OIU606H6C/Byh3E4hKdULtMjh3UiAv?=
 =?us-ascii?Q?Ncx8Io1goEpDNoJZtLjX3PSkmK51jXXWjjTA1jgMOMUdlI3xQRK+azzLBu6R?=
 =?us-ascii?Q?sOs4Ay5gqPoM8XFAL0tao4kxUyfuUpX0pNEldESsSdeEny3LWUw3IPVmlEnK?=
 =?us-ascii?Q?9/bXc5WKZ02WfQaWjNQq0RP9LD4BtfjBvBufH8Oq/Xu1Maro5orpKpa2szt0?=
 =?us-ascii?Q?UDagYzL6p39dkgO0dloJ/KqarOsglWsomfFjQ9i3TazFRXHk29xBd8L4KGto?=
 =?us-ascii?Q?dnWb12cXcr9jjOT9tUSvc0FSBKNKNncCkdfO1jy0fNnXKzns9D75gn7lsCjs?=
 =?us-ascii?Q?dO9tHTK4DY2QUJN7KXebY23q0UVy+ElZetrPOlNMtcgfDcXGOfEGcuaOY3lR?=
 =?us-ascii?Q?GakBrmQ3ey8pU/DCvK/Z9Yk8Bs1RjC9x7jidAjImDqhLTGTtJUcCUrxLc3FB?=
 =?us-ascii?Q?5mqD8jxXk9qMBKNZimnOVzHeTxr4IHebdT+JKyjFwFn/jD4oDkcZJ5Ds5q9B?=
 =?us-ascii?Q?mZgkdIICVvrZMU9/PiQISmw7NxDqQCM+jJnWYTCy5A2F4Y2rKngEEz3Oik/K?=
 =?us-ascii?Q?y/+xgbSwOZIKWtwObZQXswyUEl2o1LZZK227ZpdXB/Ie0ULWU2Dpzm9gk0Ww?=
 =?us-ascii?Q?A8ExjXR85wiKk9PlY1euFFuLSIBcqtw6Kiytw55wGdlfYaPzpe6kbNdtgR8p?=
 =?us-ascii?Q?lZUGo5pYAPLpAZSEsU8AbMnr+bqDatc+PUdLhzfFFdU/urZJLzIf6HAzipjF?=
 =?us-ascii?Q?7fY/a86CuqFfaK33V8eh87g7qXNW0be/g9PBo98sLCKTou+IjDJkNopD+ExX?=
 =?us-ascii?Q?M3v1dgba1mt8XNsSOzYIBAL+vDr418nIrpxO+CyN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d473445-c497-472d-5a86-08dc81bbb312
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 21:50:34.6511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LNNexkG88uDfjlVnjv/8Nq8wuyD5I9cWxuffwwVZ/KVDqzAxs8GmIrGq1D3Zj1PMl4UNx/8i8fk1chXudQlvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10748

Change order of sai's dma-names to clearn up below DTB_CHECK warning.

   arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dtb: sai@2b50000: dma-names:1: 'tx' was expected
   arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dtb: sai@2b60000: dma-names:1: 'tx' was expected

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index a0f7bbd691a00..454b61fa0e051 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -449,9 +449,9 @@ QORIQ_CLK_PLL_DIV(4)>,
 				 <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>;
 			clock-names = "bus", "mclk1", "mclk2", "mclk3";
-			dma-names = "tx", "rx";
-			dmas = <&edma0 1 47>,
-			       <&edma0 1 46>;
+			dma-names = "rx", "tx";
+			dmas = <&edma0 1 46>,
+			       <&edma0 1 47>;
 			status = "disabled";
 		};
 
@@ -469,9 +469,9 @@ QORIQ_CLK_PLL_DIV(4)>,
 				 <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>;
 			clock-names = "bus", "mclk1", "mclk2", "mclk3";
-			dma-names = "tx", "rx";
-			dmas = <&edma0 1 45>,
-			       <&edma0 1 44>;
+			dma-names = "rx", "tx";
+			dmas = <&edma0 1 44>,
+			       <&edma0 1 45>;
 			status = "disabled";
 		};
 
-- 
2.34.1


