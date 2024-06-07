Return-Path: <linux-kernel+bounces-206138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F739004BE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC54AB23888
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ED7197522;
	Fri,  7 Jun 2024 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DnpZsNh8"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2087.outbound.protection.outlook.com [40.107.14.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1118A1940BD;
	Fri,  7 Jun 2024 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766706; cv=fail; b=lCrZ1S6QhKek5Sf3AMXatQeot0W4AyI6VkvVKFSjXvzzZsS3Df3hZ7oB3jMAzMTacU8ETdKdfwS2EUQscbwKeTmgb0w8xSVS2DAZfaQQ0QhmpnCz22tFwCZafM3441AMjoARb13w1QsQUrdEanxqud4S+iVVNA9XGyqMR/iQa90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766706; c=relaxed/simple;
	bh=zOT444Gl91E7jHwHwsDUTPYvhX2smx5smdhImSuxa4M=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RErc98Ji7q71x5dEwhEhPQ+/+Urwyxc5qqxHXRMxaSvSKBzpBPHpzo3OgZRprL0XGuibSXFRhZxk9qegM7OJ1IOAPMebArGYbG8WeujZTRreQ4dOt8jTL5HRtVe6i6jlwwNdQgiXKChHSzTe5RA4RBER9vljnVPubx9AQ4Sk5HQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=DnpZsNh8; arc=fail smtp.client-ip=40.107.14.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAHo4Bdm53SGE81bcqTAvPdOp+XTSSNnhK0gJhZ/1g9hT5EadlambdSk+2Z4Y7RZFAdf92b1ynsd9KJUwe4ivFRFBH28vX074WsgmEPACrpNStP1ajNLWo5DxFQezhO2O8H//RQKMAwc/CNpRA06PwBfEVv+d8RDnYinbbt863Q3S/Gr1dblODRGt4XUTlmFDAnpxUawYccVpiQyQdgDkfQo4HbUMr6uKTEmOj5PBJL95TAUVW4n1hGzfCo3b08pXZyc3L5PcMQAR5HaT+8hMKX3cO3QryzA7cBoETHZshswU/PRmU9aonfgDaEnd1CcpU7pSRqsrzzOVDcIbVgvZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiiiRZyjOscXwzB/eyKR4g2HSoH/BBW/c6X0YJIn6hw=;
 b=aq9LwJhfTEKkMkjkeyXWTVoXfvOOEWzHyM5bHmctVvR/6Bk/9blqx6giHJW/NUlZ810793fbQxKcjjP+86sLG+qNohvPIAugIN9vX2yvicrIhFzbADjOjbrwD70XvQiBViL3GA2RInOtIxzatqo7RAQX/nsKw+lHYQ26OYMT3PEdZ9+uCXRLB4yeegqy7UHABjXIgS3GNfgzMN/xLdQISMUXmzxAaJLX715oS8zN+oG3yL2GzBsKF0DWbSy1LtT0J9sboyMI85uroR0y1o5dErcFbHYQCeeLdjmE2BuqAO9OXwk9SS1l8kdT4JOsYtwuLuU8QGATKbGUgFs4tOhrDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiiiRZyjOscXwzB/eyKR4g2HSoH/BBW/c6X0YJIn6hw=;
 b=DnpZsNh8YDP5tEwVubteTwHdlifXJP3ZFPisio6ATRn0hzzaqbX0ea3jc8Sa+m940zIBRp5IhuComp5HFuB0EgqMQ4436dNxiWxiTn3eWjcf6ddW6y3jAPVjRX8sQYhwXsVkZQ7qUG1xG+XUKmklrg18kp9YY1VyNtHS238ZojQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by PAXPR04MB8944.eurprd04.prod.outlook.com (2603:10a6:102:20f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 13:25:00 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7611.030; Fri, 7 Jun 2024
 13:25:00 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 00/15] clk: imx: misc update/fix
Date: Fri,  7 Jun 2024 21:33:32 +0800
Message-Id: <20240607133347.3291040-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To DB7PR04MB5948.eurprd04.prod.outlook.com
 (2603:10a6:10:8b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|PAXPR04MB8944:EE_
X-MS-Office365-Filtering-Correlation-Id: edaed543-d232-4dab-62dc-08dc86f53992
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|376005|7416005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FOSXs7dTWJCRuXcTa685LXFrTsthnAY4NYs0pxXegQnDgre3hpweoopX7YF2?=
 =?us-ascii?Q?e5CDsBWlluTdh+fxD3GDu8alx2JzT3YtyRuZAM8jRrRsTxE+OQYMFSBkrYmW?=
 =?us-ascii?Q?2h6HUJwoOOvE7aEyIJvYdsPtSCsU6m2UvSeE+5zVw7yIyT78KrFLNXzSVH+v?=
 =?us-ascii?Q?j1T1QALe1p854cB3FzqCZdcjK/4ip09VPWQ/HL7PkJyuDhnyOP+n8wkfTj6k?=
 =?us-ascii?Q?1VLUi9mlZlbKWIBSz4vqt5WD7g33zq1z6mhcGw+mKeCciSpu1BEXEhqVveA4?=
 =?us-ascii?Q?FIQ1qfm+MMmoxSY10Du0KSxP+ITaRgd8Bkb3mi7lcT+3HYQsehIMzpzY+G3Q?=
 =?us-ascii?Q?ROp+chk+Eff4GkMhvv49mLhB3hftupV5lgk20R65lUoU4fHZqDPNFs4qo+kr?=
 =?us-ascii?Q?AYwXM4lRZeYiGhQ6DmgEoK6pIgrSP4xk4eSJjfb+abdWKjALCNpsZq4GMhnf?=
 =?us-ascii?Q?vsgpHMxn2YpAkmZSXHi7QA3PTw0BVg4KATZKSaTDB3OepR7pkb1frQCAwmGj?=
 =?us-ascii?Q?lW4tWoaLy2vw27dsL0BEIUheQVaj6enJzR2TSqr5qKLXn67efo9pboMXg5nC?=
 =?us-ascii?Q?eyh0sutN+k5yURjOX/AIBu+25o6kx8fjGkLufh7RscWKma0Igjf+9V1TNPdi?=
 =?us-ascii?Q?KEUHR+levv4lGoyaCV757G2lXT9cpAZdIJhkcNG0+xOwNicuk43il7WzrwXR?=
 =?us-ascii?Q?eDID5C/B30ydOe4+P8SH1AP9OR5AXbSN6rjTrgiz8nin0QMMte6vvLG7CKKs?=
 =?us-ascii?Q?WuF6bBW9gtSrPnhnGe1Vh9Ppv0TyRIcBp0Tl6CjgKAgPBmumohWSpD9B6vfH?=
 =?us-ascii?Q?FcJ1buZFcZgwvdip8WxBfiC/7khQJ4sSMKuo3cXenDx5z29K1VSGPLTc3+RS?=
 =?us-ascii?Q?K7gq+hxA4Ovt2HKSFtY/ke3HS8W9QukYpxFigoDq9OJ28H06pK0X4ilPswJx?=
 =?us-ascii?Q?VkI5xbBBh79bbRevU8+Zp9WBa1xrLU4ZoY4OetZTqvy4E2WRuxZEZ5uEO5EN?=
 =?us-ascii?Q?PpFkQwbi/Y9J1O8WaF8cg6mIel2Q9JmNrB0IPXJA7nMStRjr8kNhCZnbC75K?=
 =?us-ascii?Q?v1ppgw8WK/rcnsOKpr8e5YNl4NT4gjSDA/m0jIc3ZgnOlrlrnxhrjPAYhZ1G?=
 =?us-ascii?Q?S+FNcv5Qv/iR2OlISBHUoj3x9AcvJ2dsuTmXOSMKlMZ+DaZC+/JnusXwispf?=
 =?us-ascii?Q?daJ8/KcesCHwevUWDkhc5xvmCm6ICUI9iyoaVpbmnh7JiBW6+TRcq3Oe7I1G?=
 =?us-ascii?Q?OZGBuGWl4E4ObyPDw6U79VdOGMR3V12T1N2UHUpNY0twmlZk2VvppRJpSpq5?=
 =?us-ascii?Q?f1wQ+z9Dc7hc0DBKxEmp0V0rwTn28Gu4tuRXF7XFITNkLNqR/WgUfD/cF0Ca?=
 =?us-ascii?Q?QMFkDngfWK6xYFl+kTN2tZhp8IYp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?elvDFVPW/K9uvKIH9bBLChP2NzJvf810+VCs2q3iCzx460HEj7ZlOEPzj4A6?=
 =?us-ascii?Q?Je9CrdQOoRlZ9AUbcmSlpmLKp1LRhkauZeEZwaIoChtBoWMnOXAPza4L++bS?=
 =?us-ascii?Q?bf+on93Wh9jcrs8oJK3bVUKrZ2Fp0R/RiwDjtOpp2/4bvUOL6Gjqahg4JsAs?=
 =?us-ascii?Q?IbqA7gqkjwRbC8Eg3ZH+0CZiP/hluMXY4f+ybjV+9/jDIA8EwoRp5T4f5VX1?=
 =?us-ascii?Q?3P8mqGDcSwDvPuH4oMxN2h7/A/ik84GVIo5oCxrK5ifIC6rjLoFRo4OrW7Wd?=
 =?us-ascii?Q?m82t0LEo6lpO7VSKmd76Af7JdDmaFZm4JsGgIwVsOWPU28iq+wV9xr+JPOYe?=
 =?us-ascii?Q?0lz9zj4JMR3BdlD/9Dd4LnTTcriEbDnHIibt3MPegUPNpTlBFdsOlJrM1s+m?=
 =?us-ascii?Q?3YEpP0bdV2M6N1Ti646roIydO91xjz5Cr37EtlKAJf7Y008/YWYZWks0FjB3?=
 =?us-ascii?Q?PLZoT5CXrDPtbY0I0xaho9wpsESQ5qWti1waIz77dMtL+wsx+v0ooKqdjWq/?=
 =?us-ascii?Q?x3VXsZecDY1QgWSgj9nECbolp71G/ab7Im0KftO4oWJePGCnsbNOs9B5IywI?=
 =?us-ascii?Q?wOJUWcrnoLWkx0n4dmM6pUdO0PJ0Rb8mjZ3bY5fEaMbOqFxMcgd+JIi8Tz2V?=
 =?us-ascii?Q?bvOimzzYpn7AanWQSwq5aKyELfp7dptllxZbXMnFiyNVQ/WNreRhvt4AFect?=
 =?us-ascii?Q?dgN6GZCtSfEvnVH2LDVg0drG5pptrs/u588WUmHFzR/dQz7Gq23tc6ZbidTY?=
 =?us-ascii?Q?TcbvQLNtETCEW/JNaI7KOI1zbiFyKoHH6ZGnVvLyiiAvOqCCxR6LC9EpM4rB?=
 =?us-ascii?Q?HxcO99kH+wfxXnIl2h/shvC6ItmqSR7SbL8nJ28hxrt7GsOFl4Rqrv84+jSB?=
 =?us-ascii?Q?jAepfIizax/EfGO/eX+T9EMg1N8P51ecJqjRdMDugIfDSZvVHc5gY1r5hJoa?=
 =?us-ascii?Q?YN0O+6af8jeBawETxDU6uQVgfKf4crqWNV/10R1X2/Ypl/WqM4euKBduPWp1?=
 =?us-ascii?Q?Zx4VWmTTKIA5mYelfgnNvierVk3T61ed/6RQzixMlOerpBrNN+aqRh11W+4K?=
 =?us-ascii?Q?ybonvZhQFDKiRK/Uqm6ywZ4elCN530kbmfjWtzwuHZrMOl7RbJf2BzuvoTco?=
 =?us-ascii?Q?v9IfOY7Z8bc3lhwZuaHTM9OG60QsVY7/I6m/UtB7KvbEj4FznR//uty2rcLt?=
 =?us-ascii?Q?XFOuIPMjGgtyQihpSi4XPvaCTcAdjlQwIuTYuvqvCuTkqcpZgnDludvnDuNN?=
 =?us-ascii?Q?rKNPpLM/EHS5OHpqKkz4dFWLXCLleoWX/cwzm5gNnKG0I10oIeGDorgRtSWW?=
 =?us-ascii?Q?QK7dKAT4Co9N0AvoDvhySCusABtsCxur+w554VOhPrF6yehN6xgT9PqzCOw4?=
 =?us-ascii?Q?NNnVtNHz0AcrdBoy4aRqf/1f486sADXlw2ZlVRhUCcE4e8H9j//FJlaDv4CW?=
 =?us-ascii?Q?25ssqLI1MkNFrZ7sfKMYsXm7PvLyydCnhs1kbJ2st2tyG9TdqtRrJNwUfl3t?=
 =?us-ascii?Q?dWc1xzIiPJpQ0Gjzz3ci1vDwnJbc2PD/il/ej6VZ/KjW6AW1Ru8uJrJGcUrm?=
 =?us-ascii?Q?TUYpQjon1lq1I0TXLndyJtq/bRSd8/JRt8lDSfjN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edaed543-d232-4dab-62dc-08dc86f53992
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 13:25:00.0649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbn28ykJJJyel9NyNs1DbGMMFETJ4beblIRaUzRDJfIDC7z0AB2joSi7DyJdfj6UwRYiFgqIMqOGx0AR30uk7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8944

From: Peng Fan <peng.fan@nxp.com>

Changes in v3:
- Drop two patches
      clk: imx: pll14xx: Add constraint for fvco frequency
      clk: imx: pll14xx: use rate_table for audio plls
- Update 8ULP PCC check to not return Error
- Update commit log and Add R-b for 
  "clk: imx: imx8mp: fix clock tree update of TF-A managed clocks"
- Link to v2: https://lore.kernel.org/all/20240510-imx-clk-v2-0-c998f315d29c@nxp.com/


Changes in v2:
- Drop "clk: imx: pll14xx: potential integer overflow eliminated by
       casting to u64"
- Add Fixes tag  "clk: imx: imx8mp-audiomix: remove sdma root clock"
- Link to v1: https://lore.kernel.org/r/20240504-imx-clk-v1-0-f7915489d58d@nxp.com

Upstream several patches landed in NXP downstream repo for some time.
- i.MX8M/93/7ULP composite clk update
- Fix Fracn-gppll MFN got lost
- PLL14xx update
- i.MX8MP DRAM CLK fix
- i.MX8MM/N misc update
- Init i.MX8QXP parent clk before child clk

Downstream tags are kept for the patches got R-b

Although there are a few fixes, non-urgent for 6.10.

Adrian Alonso (1):
  clk: imx: imx8mn: add sai7_ipg_clk clock settings

Jacky Bai (2):
  clk: imx: composite-93: keep root clock on when mcore enabled
  clk: imx: imx8mm: Change the 'nand_usdhc_bus' clock to non-critical
    one

Oliver F. Brown (1):
  clk: imx: imx8qxp: Add clock muxes for MIPI and PHY ref clocks

Peng Fan (8):
  clk: imx: composite-8m: Enable gate clk with mcore_booted
  clk: imx: imx8mp-audiomix: remove sdma root clock
  clk: imx: Remove CLK_SET_PARENT_GATE for DRAM mux for i.MX7D
  clk: imx: add CLK_SET_RATE_PARENT for lcdif_pixel_src for i.MX7D
  clk: imx: imx8qxp: Add LVDS bypass clocks
  clk: imx: imx8qxp: Register dc0_bypass0_clk before disp clk
  clk: imx: imx8qxp: Parent should be initialized earlier than the clock
  clk: imx: fracn-gppll: update rate table

Pengfei Li (1):
  clk: imx: fracn-gppll: fix fractional part of PLL getting lost

Ye Li (1):
  clk: imx: composite-7ulp: Check the PCC present bit

Zhipeng Wang (1):
  clk: imx: imx8mp: fix clock tree update of TF-A managed clocks

 drivers/clk/imx/clk-composite-7ulp.c  |  7 ++++
 drivers/clk/imx/clk-composite-8m.c    | 53 +++++++++++++++++++++------
 drivers/clk/imx/clk-composite-93.c    | 15 ++++----
 drivers/clk/imx/clk-fracn-gppll.c     |  6 +++
 drivers/clk/imx/clk-imx7d.c           |  6 +--
 drivers/clk/imx/clk-imx8mm.c          |  2 +-
 drivers/clk/imx/clk-imx8mn.c          |  1 +
 drivers/clk/imx/clk-imx8mp-audiomix.c |  1 -
 drivers/clk/imx/clk-imx8mp.c          |  4 +-
 drivers/clk/imx/clk-imx8qxp.c         | 51 +++++++++++++++++---------
 10 files changed, 103 insertions(+), 43 deletions(-)

-- 
2.37.1


