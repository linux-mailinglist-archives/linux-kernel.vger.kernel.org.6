Return-Path: <linux-kernel+bounces-193958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D81DA8D3490
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633951F25D2F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A677717B433;
	Wed, 29 May 2024 10:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="le5kLrt+"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D743573475;
	Wed, 29 May 2024 10:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716978642; cv=fail; b=br8cn6+sfhCBq5HYPqN7ixxSDQudOejvH7l5hrkRFblKZEtViEnAWDiDEQ86SiZIbFNi17urK+ZMKKuoZL21aPKmkd8D+pLVrhqyUYC9VXQ6CgmVi7f+ciQdRgsbIQWOX1qNSTyRGm4WR2lDnXsmGHeywy3dGgTtccq2lIOz0/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716978642; c=relaxed/simple;
	bh=w+7PmH2jw3uYamet+CKUc461XWr66syAi7NX9iCk7Gc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=or4qEJ5yjhTK8x0lalMzl3/hyXNLx6UtAAL52EaNBnciYzXv0zUys7WkZHCF8mwb+MRIsgkGVph6DjlR/YoKmbAUMavvkvyH31SXjCo7N0+vVZlPcJMbO/cwUSIwHTe90kmBMJnS5JQWoLRPuzLHsQhWVqkdMfctls5zSQ87b2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=le5kLrt+; arc=fail smtp.client-ip=40.107.22.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTtrb6e9zYto8dGeLymoNRBDs3JBF+HLndQs9BoQGUVQcvvGqimdLsXw4Qfg6d5Ijwn0V0rcV+NjArj/6/bOEEqISK22aVp1T3eMKvWWIpLAr0GW1/GQFDwIH2P2zh3zF+F1NoNZSOD+L5BW4+Ut15rE4P/i5A3X9hEh/BMS9Rrk65cjLEBYLsHtcQAjhzfbQVyb9wZjVIk3E4EBsXAlECceHHThWwtO8kIR2WfZYYQcX1dgG9rbgWVCbWdZDN10FDTZbRtOcXZq77mzJ9KP22SVtyQXb3ddIqZ5PdTmzSNZKPHwpYPIjQDlw4nQEIfILrVV9qbKIZN8qmvfPWXW/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2K9LHKVMmyU2R0ZjVOQLXMNHcYbtARDRqjARPwVmdM=;
 b=oLbH/xv4zkACioxqVhKZxJ5llyKOdvJko8sMO2jlFgZbo96tHUcXRDWeQ6uW0s1e1qpS6We7w/d24hlxIIndV7IukEptwzniJjJ2Kwc6K5njGKmMw4L6BM+2kx+UIWkHhVQ49nRxd+qQgrY3dPsXExJ05g9d3pkAYKjzrHVUB3Ql9cLVRYJN497sEYMpd7jDqybPLCKAwsJdtamWKlekf2wSTwxEhltzvjmj47chIyR8YiD+t2IG+aIjF0TwQVlWmyG6Jt8ZJdVz9fxmd6yGKZk4xI9cmeskGQ/iM227I1LoCfXEt1885jSr+hQx+qyrv6OONHKZVQIGwtgv+MAAgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2K9LHKVMmyU2R0ZjVOQLXMNHcYbtARDRqjARPwVmdM=;
 b=le5kLrt+CqzGjn7kkt0BuF0bTNK6mw/r7FooHpi/H9yRMzDb/LVzRAn9J1w9ermoDsicW8gQvaj+TXj3MUlgZ2gVZASz9+taa3MKFwJ8bGgDaH+2THsTrE6HGEaGEKtUCBZ8FTyyGES7C/KRIwPyLkgtNnUZqMwNbSAOoTX01mc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DB9PR04MB8393.eurprd04.prod.outlook.com (2603:10a6:10:25f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 10:30:37 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%4]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 10:30:36 +0000
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
Subject: [PATCH v2 1/5] dt-bindings: clock: Add i.MX91 clock support
Date: Wed, 29 May 2024 19:26:30 -0700
Message-Id: <20240530022634.2062084-2-pengfei.li_1@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d1cebb90-1cb9-45c6-0b1f-08dc7fca60b0
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230031|366007|376005|1800799015|52116005|7416005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?oeY3AZHGYcZkq3OVnLiIs5jQgYg8b3iC/xuy2vUR4byc0yWdhsGWpMOHJKQ9?=
 =?us-ascii?Q?+ydGfjt4VF/8VnHkohTw8OQcrVyJWbPrQXVX4/vnUPcqEJrmy2bgnijPQ91f?=
 =?us-ascii?Q?sZG+h7z2+PB77vX50FuF4QuZgFLw9XVrRIBI7h9JoyPJ9jcyG5hy5ndinF/5?=
 =?us-ascii?Q?+H6N4IFP1MzwaCVAuEJtuvlPuZlVstmCGjhpNkvOdA40kAu2dDKPt9HDq5H7?=
 =?us-ascii?Q?Q930xsVSvVgpYQp2BoPpDnKCNm3N1gqGC+m9rYCKQ9S6P0Yoimbk2bCVa/j7?=
 =?us-ascii?Q?Ip4fGPmH1QwIkJ8lK8C7dPGDSVMkZAaGBhCKFGO9U1FEq9yy3rKCfQCSb8SJ?=
 =?us-ascii?Q?xb/qfiKNMpzusgCru/iMDOJjF0JrpnJfcE30o8wcPOK/zLWcZtDlZIYwOLCm?=
 =?us-ascii?Q?wL3fm2Pb2rdwgRt3rIjxuZ6vrN2Mb+0hGYBrMBkI20vpjeBYpuaRKYuybvBV?=
 =?us-ascii?Q?5fAQfoJ6RxrX1Au3z/y2kcgKapdA6heNPqJfFxnFB1Kiwp74zWBRZ0KdObs9?=
 =?us-ascii?Q?Siw2I5ykr/E4N0bBi/TMCImTPxzoq4L5j0z9jbQ2gwGaCf4PDfAErKmod2Io?=
 =?us-ascii?Q?rw0Op7vuZQHCv+GRDsJoMSi6f2EkcZvOFQezb08rv0zxRBB3oLhkhlboUaL1?=
 =?us-ascii?Q?VULq9upmq/DEAkq3UpG+hSh3YSF8WXlilpgMqk/RfK+u0EGF38aOVbmH3m2g?=
 =?us-ascii?Q?sL/zAzvlpdbzYeY/rRezVXT1/0onnEBgdPzDFXMDBJzh0u8QocjcGedeP/C7?=
 =?us-ascii?Q?3hFIVuLLwalmtZ11/Sye0D3K7jSme1H9zHflxS7FCKMWa+hbDYLSiw+5kWxw?=
 =?us-ascii?Q?l5mfV4G3ds3PXAu3L0Y7YA01hy6IozNo6vr9iUjxNKoP7c0qVxxrZI1Hbo8K?=
 =?us-ascii?Q?OrvaIRmGGnDhdbb6NHwMUXWl0KHs9O/soKzuMdD4Uk+tWgAR1npsVMkjSEVs?=
 =?us-ascii?Q?c/u4EiM5me5VORLVa807SgFrYHkGXTedEFdz5m35dN0ix+iuWYp7Rd1hZ7r+?=
 =?us-ascii?Q?oPEzT1pGDXoF8gnEMLlxosch0w5vtzbno4aawWmTx7ksuWAm+sieOi23i4dB?=
 =?us-ascii?Q?tEjSf8WNhvOBEp5uWJFRO1huiRQ6rpRvsWqorGnmkXxFjuAaFB8p/7fP78Cr?=
 =?us-ascii?Q?rmFfNmvoaeErhddvblrwGVZOOxw7tS+GTQ3eY1J1A/Io3FnlYqfhEvxGNtjw?=
 =?us-ascii?Q?aWj+od8N/PDv1GCJnpo1VvRPUcJkolwyWNIIwOnbpD78/FZ0YzGO9St+kEFr?=
 =?us-ascii?Q?xpxExTuz8nl4sW1M4AD3sTOgEKtO5xcP3iciXj5PRmmkj2WpTZEzmrldx5Yn?=
 =?us-ascii?Q?uvbtph212n81admnWJ9+32n/UL+nG0QXO+j/LQpeyzUtTRVPZOoHhv3vQB4r?=
 =?us-ascii?Q?dkZmwDI=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(7416005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?gsYxcGEK4rxho6RBbZn8ZVjWdqLRY41fOn3dREuX++VyS1PYBonww+d5uaNn?=
 =?us-ascii?Q?gJbin9i6JzS9W0zc2dLUL/ys5GGG+ucP0XPr6j+SvqDw8Mv/KSNtL/9BJJbb?=
 =?us-ascii?Q?LHtrCpToJGTzSsE93MzuCj+GcjywbrUSAu8gULypGyhkpNeCgecBqYcACwGi?=
 =?us-ascii?Q?HSocifP4jfV3T2qrzGwugd/+DCuKj8RmN+eajcZDvyODptvEC0LE1xyWB7ct?=
 =?us-ascii?Q?GwKDQ6vyGH4vcnC26UbWCYz74C+oRJ5pkliO0wdiAhfQU9A+4SQdo2RvbEKq?=
 =?us-ascii?Q?Q1uN9WNQ8ak2BmykfSEDUPBHSxum34QzHaLbYf6eTWkgCNG349FFL/Xn/WqV?=
 =?us-ascii?Q?rTzp+7IW90BBxVcfvrncTysJr1nrve+SA+4G7QrRfgLINQ3OO5bIgJi/a+Hi?=
 =?us-ascii?Q?0AImbU6bhWd/JPy+bG7NZlWzLYb7gZp2An0ZrQ8FwEQVLkjfOPsgdtpcXqjI?=
 =?us-ascii?Q?KTCffmwPcMPlBlchFZE4leO139g6KRcVUWHR66WVxj95TGvuxGyxxoJRrw1i?=
 =?us-ascii?Q?XoymvJOCSm5Bmpe8zH6mtbnOCDqSJ3HZotxK9i4rbbJTtbj5nVp6mxXed4YF?=
 =?us-ascii?Q?HrPQWK0sxHRqAprsFHC46MIBkoNsgAHsK008f4a5Az+R7iqf4QoZlkhmHKyt?=
 =?us-ascii?Q?HZTHTmXPUZw8U4ZKrtalLi3P0202hSHPgOLRTppV9BUTyeVMzkCiNi6MwMYh?=
 =?us-ascii?Q?Lkq1IMVFuodgnHuLhL34dLsnAcFmPBY/x1D0moYCumJ3HgwUiEMQXmxup14f?=
 =?us-ascii?Q?012Nj9Vzo9jUTAlg/9+fh45JGJ0pWORKZJisjh1Wxcdk53vYgmJyJhMbxMXW?=
 =?us-ascii?Q?MXwckNO3hulGYjNBOYDsw6/cgsq5i0O2cqRFHB/mxajsbI4RHwA3mDRR1BL8?=
 =?us-ascii?Q?McBEEkRVe4GuefFO4cXBvfNr4GdBkixY9Wd5jRVrPmOkFhr5aocw9LqLLO33?=
 =?us-ascii?Q?A9qBVrWgli0iXXiwLWzSqOzS/lRT3nFg4usbsO9rXhIqiT7wK/a7E+Rrq/G/?=
 =?us-ascii?Q?kRfZuxNdY+ZrsHL4FjovZEypSuVzvjb3LwyF6y2KafkymbY+SrSYCtkyX/To?=
 =?us-ascii?Q?YgaGEmkxAvBJ01ZJi2GKC0etHgjdu9SGkJLUzruyV2Rch9DRysvikQ52wL2C?=
 =?us-ascii?Q?6klCLGu3QHpxlxXFpT7mj7SFfZybWBYZnin9WgH+H01G3wUk6itGTE5ovE7y?=
 =?us-ascii?Q?GtWi/323I75hmPO08WXG2OkIehYA1L3HnCsZCH8x1IHIseO7Nl15KgJeX2/R?=
 =?us-ascii?Q?EwEKg/TuqsPl6ox8R7sG0reoJLt5JBJzrcc+TNlYyfUN8AFDh21sZcQe3a2K?=
 =?us-ascii?Q?+Sm8BTBKh34antpfkoQgUgczmLMCT12WuFZb3mBnZudrYi8yXr15GLOQ25ae?=
 =?us-ascii?Q?4R223qLEYbwaACRpbmvycLeue6JVTfh760AdV5cZUdtktOweOCKtcNOjXVIR?=
 =?us-ascii?Q?x7dErJu2scUpOHrg/o6tgNKivLNHlwqASmIfTVCX9ojK8lFoF4mgkFh/6iLB?=
 =?us-ascii?Q?tFuq3jvSK3jIf0aaERyTFZ9c80DavOBGdpjxm2rT8s+pwWIU8IpsW546l0z1?=
 =?us-ascii?Q?9HocSoidJFq1ln9rqHgauwKRyLOKiin7oVeM45EG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1cebb90-1cb9-45c6-0b1f-08dc7fca60b0
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 10:30:36.6419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OVEJXOXEx8tiXpyMX6AbOS1y9oqAdrIdW43FIr+ZYqIPVwPo6WKXEbNQ8dwHeCiUgDxQXzEGEbnLek/xSnnJJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8393

i.MX91 has similar Clock Control Module(CCM) design as i.MX93.
Add a new compatible string for i.MX91.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/clock/imx93-clock.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/imx93-clock.yaml b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
index ccb53c6b96c1..98c0800732ef 100644
--- a/Documentation/devicetree/bindings/clock/imx93-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
@@ -16,6 +16,7 @@ description: |
 properties:
   compatible:
     enum:
+      - fsl,imx91-ccm
       - fsl,imx93-ccm
 
   reg:
-- 
2.34.1


