Return-Path: <linux-kernel+bounces-178157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6208C49CD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 00:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D8B9285DCC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 22:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671088594C;
	Mon, 13 May 2024 22:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="R7sv7/V6"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2107.outbound.protection.outlook.com [40.107.223.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770B484FCF;
	Mon, 13 May 2024 22:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715641032; cv=fail; b=cl57eSvWLkX6bu+FaYOXfpSRT7vP7wJK5Y50ZPvBKJ8QzB55/0vYUXKUYrcLWgrV9gv3uxo+Je2p+TJ89YhR9ke+oZYotjPbrQBmM/ZoBAeurPI6M2ymj5brvpw+2BlpbaptwiLM0GYR3l+/6/mhGvbskBowx+DSOP+yYbBsBnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715641032; c=relaxed/simple;
	bh=IY+CRZdCQ7buysXdtSNZ9yQ+0QDlVddNnjnQRf1h1rU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cFDBwGtfXos1NzXE1v23fm6aZ6711bDGNPglSopImtmJ9QK/8FEdRRCnBhQyK4+GwSAsUPIMdGXCBv2r7kbtVxfeqKv29XsjvK2NczCkNM9PQNTfwICIxVmhF/uPU4/kWHr9KTBhIuYMywGd2mhTUlgTZdaBWCRytOWUBBC3WUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=R7sv7/V6; arc=fail smtp.client-ip=40.107.223.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlqlZG/4xkCL6yHHJJm2QPi7L4ARnM6GT597hNz5UIPVoPbk5qmIfLeQQ8t8QlzKAHs+6+3RNXZDK95Ct+QO72J26VbwPJUDuMK+9YhRUBU1aZXMA+sslf5vH8Lnf1Sk8PV6YNyVl27f5fAYTzHvwQP8RfE4iVSa+DXqX6bjV1FTxpVzvJFBRGMwaiPRB3sXvQw5vnaLmALKDz1fVdlRawVQRwRMBKxJ8hQJeXeda9JWTI+teVXewkcjx+8MPPC8fXyOHcFDPt892zcNBkxy4g6sXK4iP0fqrRgzEQz7GHlCfGCeMB+SpE+H9I8qP2fOAjA6wQeOIEfUaz2J3KheJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bgVajLWjoFytAtRfHclGSoHIESvXLiYwDHCYV6u1T8=;
 b=YaB7yFo4uvmbj4Xi1dJodg5DU5aomK2sBlSO9YrH//OwKGgG9m+vivz0tVaXbLPRd39UNXcSQbZWi7Pryoo+QNM6LJWUFVhGE07rQMl2VkrrqLVMT+C3L+D3Zwgh01KB5/pv2jfwntTpcMExn26dGvFj0IYX2YHqPKsrMpMBmgCPmVlk9EN3pk0uAu/B4YoPjYoEXxySNjjTrywDDDG+kpOkZaaJ8kZPi7u20dA2Km0fa51OfJe00zz32faq1ztPg/NK71bY2lPzj/xfqVz4jaPGZgyhIh5D2uEwr2BoG2CTwhJ/f+1tJ/NAXGkBCnZZCkHtcDCAnR5YxqM/PonTmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bgVajLWjoFytAtRfHclGSoHIESvXLiYwDHCYV6u1T8=;
 b=R7sv7/V6AlQDbafuzquHhfvHQccRPGfXj4Y2FSPa/jTTu5qYcDSKlsifhPa79Jm6TNqsgTWDOsF3JPShpwsptB3j/O2io5ijXKAmzTPD+O0y3wzl8J2/huodAtWHKNqyy25uNk6m1FkY9Q4i16NfpCGRyznpWtDX2WWTl+NmSP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by MN0PR22MB3668.namprd22.prod.outlook.com (2603:10b6:208:37b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 22:57:03 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 22:57:03 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	w.egorov@phytec.de
Subject: [PATCH v3 2/2] arm64: dts: ti: am642-phyboard-electra: Add overlay to enable PCIe
Date: Mon, 13 May 2024 15:56:46 -0700
Message-Id: <20240513225646.3603803-3-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240513225646.3603803-1-nmorrisson@phytec.com>
References: <20240513225646.3603803-1-nmorrisson@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::10) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|MN0PR22MB3668:EE_
X-MS-Office365-Filtering-Correlation-Id: c8cc655a-223d-4565-9cad-08dc73a00108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|366007|7416005|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U6b46/PyR0om1XvB0Qe242jhIwNZjeuayR2sw8cPJanqlu9EWQb6jjqU/X/1?=
 =?us-ascii?Q?AiXTcYQHd2CppUqCYy04Iz/4wQD7KLTqpjrjDwK0AwEBt8ChYE3aWtCfibp3?=
 =?us-ascii?Q?bSu2+5UH70QNmwpTRbaS64twenbNCrpPLGqqewu1YjdIraBSgtuLDFvGyB5Z?=
 =?us-ascii?Q?gs+Bi54i2Z3pw31QHNDgfSpl3V0gH+2VTWMnmPYDyVQdyIgYOxIZ/K6S4Ly4?=
 =?us-ascii?Q?16hBXPe0KMEC0Yn8WIPwnuPOAxQNwrUhTyNnpggl4LlRqH1BHcT7VM54k7M6?=
 =?us-ascii?Q?rZShIlR1GZUPWFLvuoSuPofmdl2YiNoEX+Q4nUm0PqTGC6bsPwslBJRjaD2k?=
 =?us-ascii?Q?b+DaUU7CGqmXaACOOf6ZJiZhbvgIWviCmDfSMS/BZzr21ksn9bppr7shHrCt?=
 =?us-ascii?Q?0WSrFYPblqpF+/lw5RbhJ+GEWjA4zLJWXis0etGstpXJdgOBHDAz59uBYMYy?=
 =?us-ascii?Q?ZpFbpAmDNKoU1NQtvc+YUCLGyXp8yz+6SP9ZDYEqPWkT26it1P3OawRtwFEp?=
 =?us-ascii?Q?wkAM+jEAx/J5gpf7d3g+LW3kXvNvMIDBWwuOzZzZqv7MLDjSFiQUkbateJ9m?=
 =?us-ascii?Q?7Dbm6iamfNGnuFu5k2o+idHmG77GqtCzygsFCb+X0Bc2I0meZUDE9OEbFEms?=
 =?us-ascii?Q?3BvP+03fIMRDZ7NKp1/pAmDgXqwz2qzViBhb3H78I5vn3FmXDJXUmwps0p4n?=
 =?us-ascii?Q?ujJg5hk9ERhqVaatoVsmStEPCQRq6cSl8M1D4kdSOU8RSxQ3gLDj23n50pHG?=
 =?us-ascii?Q?TrcIkzSK9+s3CdOJNQe8YCBdOvxwdwCetCk3XtX+qNUa8CzDkVyqHhuV/Obs?=
 =?us-ascii?Q?uYDAzcsvSqBcrTdBiIS53OpzEuulvGrRBNwxVlHi66UCz6AquQMGCJ0aLjo/?=
 =?us-ascii?Q?ifi0tjX+0Su9XI1Qs/1AItQv7VjsVEbytc5yY2RBMZgOOKpF9mos9PrwyJFJ?=
 =?us-ascii?Q?gTM+1tZZAiYadCf115NlCpVbLi72lPw4Fp7mpBxLZVRUIBcrEy4iXeOFnjDA?=
 =?us-ascii?Q?34wblc9D3xbf5sCHFki6kU+O4TZ9baX8CAbX0IwX+QPvDyJCPz3NVhJ4OI0e?=
 =?us-ascii?Q?omZbg0dqIadevIp8rBpMtBx2nQDm8hlKGQR8jH93e3CkavqXsT/TDpJITIXq?=
 =?us-ascii?Q?UktbrUzePkw6OXfKk7EGMhP6Zmj8hd+FtMYZ8Dxax2VsWOXgn+zu7TdYFoue?=
 =?us-ascii?Q?Iru9mtg0DR19zp6ui+qE9hinELeL9qv0xIt2Gl7rcAWgQzk2Sv3MLxZBXJPr?=
 =?us-ascii?Q?KuPG7fMydSFTqJQmEhSr6TTgG9YyBHNiZCjA20vOnw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(366007)(7416005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2c7mCkEBd1Cg+0ric43eRGh6gxVJ4dRtmRNU8UroyTLmA7dPjtHK58S0TlEo?=
 =?us-ascii?Q?8GeboEgDbpgX8rZGOsPGpHywTR5j2RXpxSuV9LUxEbBwvA4Ll+NhorHAcN7h?=
 =?us-ascii?Q?PvhqJ5jg7bmNMkqoHVmGoeUZFrMvAZvBb3iVpFipItqo/2Syc1nnQC2ryTcb?=
 =?us-ascii?Q?ukFjpSjrtfo9NBilcwTtz2BHdEEY+7pVdRVUgVncQ5AxbEftC5b3TeMZPe3l?=
 =?us-ascii?Q?HSKgRENinXBFVRDoZlbPWY7YPVwk/IJiIAfxKjrf4GO3mulGpGJwYZO3HP8O?=
 =?us-ascii?Q?el2GIqOrsrxdQiQLZoYXkc+XGnE5gBD0HExHTRWGlsu1xD1yLOhul2aDQnpP?=
 =?us-ascii?Q?zYOactI2Tljq+UVlRj9y1VW2JiT0BDUau8ZRVhz3JpNSez0u8ZD65RRm9TGM?=
 =?us-ascii?Q?ekUXvDESskwS/6uk/pBVrKLO3vElbIE5pQNI4Thp0ugMtIsEqfbfoL4XXfy1?=
 =?us-ascii?Q?yhU2p/QBuHRRUnaylKD3bYAuWvLcTDkbDMrZknxjQKdMipwy2rvz2lYFNn5K?=
 =?us-ascii?Q?neqPy/pKBHttKwqFWtB8d5Q4cG1WBlGTMPz7RZG7Q+L4mbMq2v1O159FVvvs?=
 =?us-ascii?Q?KD5xrH3Nsk9wKVJBTTriJcDDsrhxF0OGyDdl4LjrE1t9xaPVxbzv6p3p+mLN?=
 =?us-ascii?Q?ZhHuRU8sc6qcEuLl7A8+uahMIROFazI6GarufFVQ+AtKWAEyMCy2ikTdK6dJ?=
 =?us-ascii?Q?Pu5HZQlsG9aPJw0CDVzsR7YDFRAaS3jK5KixWFzbHUze2UC8vh43HebGDSLk?=
 =?us-ascii?Q?LNdIR+k9Bx5/l+sxHn2D1f64XiAODYjWZEm00frnJinedIIkQPyaW9W+Sc/w?=
 =?us-ascii?Q?f1TTCETAgn3LV+QIXx4zEfPNZCWwLevPPisY521dpHlFey7hByMXLDeoTTMM?=
 =?us-ascii?Q?DJ5rQSyLKLDPTfxdA5lZXc3+1gSI+uBbJf81v/78MODg7lQGrJ+9jPca/xxW?=
 =?us-ascii?Q?aqX1sjutCyIPDXyypEvTLw/lcUhQYRyQ0fBHpAics0pOujB4j3f6LzdhHQwN?=
 =?us-ascii?Q?gg5JVvQP+Spjpq+SM1Xn+No+UbPNDvSvHQYGAjtAFcljH3ur7XdH3b3hlnHP?=
 =?us-ascii?Q?wWivTFM8KhW/WZi5vjYBBcDR3g74dPUV0XimJXjXp0Hd7L/FmhK6w3yUC1ff?=
 =?us-ascii?Q?p5naFjwJl1UEFQ74nac2OsVfEj7nxjhaShS4pSs9z5ziwDabigdMJPlfF1J7?=
 =?us-ascii?Q?jLcSPf/cGqIglbhVuKXSbghupie6LyfcW1KiTzOFte6HQ7UDNBt+taI5CmA7?=
 =?us-ascii?Q?AdJePlYRaihkAz/0HJM1h0n2WqmCga2ix5mBGgifvJEbcJRuxJM9AlNhr+9f?=
 =?us-ascii?Q?ZObO0IvKoAusk3dIulZ4t0cLqOr8psey78LHV/44G+fa9Vh+87K96xEydWmb?=
 =?us-ascii?Q?AiKCVJwGfKv8Sx5f8o2LxO5Y9mGwX0JVgWu93FKzqiSCKIThYlTPIMFOnKlt?=
 =?us-ascii?Q?xQduM4YLpKtzLvsMg8Y17dWUlAbxpl4kDo9dPoNas0JNoM3spF96RCAdvoKM?=
 =?us-ascii?Q?Tu/7Gp3efgQ95It8kY3ChE7SiG0DoBxvin0C64arEAfJdOVnLvgixPpz5R+/?=
 =?us-ascii?Q?eHd2Oq+hcK4YARr3DlEXMlaIXFAexoYC5ji6MJPx?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8cc655a-223d-4565-9cad-08dc73a00108
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 22:57:03.0229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vd6VFy4s/DtzqqumeOx8n3TDYBhR3Zzy3hrREglesDRo5Z8BjoFxlzwgS52rstmn2VIQAGDXKKQzU/Li7+X65A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR22MB3668

Add an overlay to enable PCIe on the am642-phyboard-electra. This
will disable USB3 and restrict us to USB2.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
---
v3:
  - Fix typo from .dtbs to -dtbs in Makefile for overlay testing

v2:
  - Fix double space typo
  - Remove redundant status = okay

 arch/arm64/boot/dts/ti/Makefile               |  3 +
 .../k3-am642-phyboard-electra-pcie-usb2.dtso  | 87 +++++++++++++++++++
 2 files changed, 90 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-pcie-usb2.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 2c327cc320cf..1906711b9b77 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -49,6 +49,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t-pcie.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t-usb3.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-gpio-fan.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-pcie-usb2.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
@@ -134,6 +135,8 @@ k3-am642-evm-icssg1-dualemac-dtbs := \
 	k3-am642-evm.dtb k3-am642-evm-icssg1-dualemac.dtbo
 k3-am642-phyboard-electra-gpio-fan-dtbs := \
 	k3-am642-phyboard-electra-rdk.dtb k3-am642-phyboard-electra-gpio-fan.dtbo
+k3-am642-phyboard-electra-pcie-usb2-dtbs := \
+	k3-am642-phyboard-electra-rdk.dtb k3-am642-phyboard-electra-pcie-usb2.dtbo
 k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
 	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
 k3-am642-tqma64xxl-mbax4xxl-wlan-dtbs := \
diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-pcie-usb2.dtso b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-pcie-usb2.dtso
new file mode 100644
index 000000000000..7a5ce4bc02f3
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-pcie-usb2.dtso
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * DT overlay for PCIe support (limits USB to 2.0/high-speed)
+ *
+ * Copyright (C) 2021 PHYTEC America, LLC - https://www.phytec.com
+ * Author: Matt McKee <mmckee@phytec.com>
+ *
+ * Copyright (C) 2024 PHYTEC America, LLC - https://www.phytec.com
+ * Author: Nathan Morrisson <nmorrisson@phytec.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/phy/phy-cadence.h>
+
+#include "k3-pinctrl.h"
+#include "k3-serdes.h"
+
+&{/} {
+	pcie_refclk0: pcie-refclk0 {
+		compatible = "gpio-gate-clock";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie_usb_sel_pins_default>;
+		clocks = <&serdes_refclk>;
+		#clock-cells = <0>;
+		enable-gpios = <&main_gpio1 7 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&main_pmx0 {
+	pcie_usb_sel_pins_default: pcie-usb-sel-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x017c, PIN_OUTPUT, 7)	/* (T1) PRG0_PRU0_GPO7.GPIO1_7 */
+		>;
+	};
+
+	pcie_pins_default: pcie-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0098, PIN_OUTPUT, 7)	/* (W19) GPMC0_WAIT0.GPIO0_37 */
+		>;
+	};
+};
+
+&pcie0_rc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_pins_default>;
+	reset-gpios = <&main_gpio0 37 GPIO_ACTIVE_HIGH>;
+	phys = <&serdes0_pcie_usb_link>;
+	phy-names = "pcie-phy";
+	num-lanes = <1>;
+	status = "okay";
+};
+
+&serdes0_pcie_usb_link {
+	cdns,phy-type = <PHY_TYPE_PCIE>;
+};
+
+&serdes_ln_ctrl {
+	idle-states = <AM64_SERDES0_LANE0_PCIE0>;
+};
+
+&serdes0 {
+	assigned-clock-parents = <&pcie_refclk0>, <&pcie_refclk0>, <&pcie_refclk0>;
+};
+
+&serdes_refclk {
+	clock-frequency = <100000000>;
+};
+
+/*
+ * Assign pcie_refclk0 to serdes_wiz0 as ext_ref_clk.
+ * This makes sure that the clock generator gets enabled at the right time.
+ */
+&serdes_wiz0 {
+	clocks = <&k3_clks 162 0>, <&k3_clks 162 1>, <&pcie_refclk0>;
+};
+
+&usbss0 {
+	ti,usb2-only;
+};
+
+&usb0 {
+	maximum-speed = "high-speed";
+};
-- 
2.25.1


