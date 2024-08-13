Return-Path: <linux-kernel+bounces-285183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71775950A43
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5B5CB21203
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCDB1A2552;
	Tue, 13 Aug 2024 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JNOn0Ag1"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C60D370;
	Tue, 13 Aug 2024 16:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567019; cv=fail; b=WNYqhuygWaOsTS1afoiivW1rjDuIRRQ5xOC2FX7INiqj7SJwDOBLOwE7ZbtwgSrjbjVM1p4bDQXqOG7MJzcHTpkswRZRtKal2us3S//3JKktHAnSsl0orJv+UthUz5IgFtxadHsdNxmvuLiQRMpeYIshme2kajRyFS8Mv/twdHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567019; c=relaxed/simple;
	bh=ItP/kOBoLDt3jhSk3tQOQgENZKvAgHqlGAAH89Wzoo8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LdmV68kT3E1SXsZmpd+liJ00iVELWfJ3DK8ZvZtyT8p45oGGc2aUwOut539owbpGTosOG2nWUNCwI85F0Xud8+SM72Ym0X3Zw+q5W7A3yHNsI2C+Hkpu+s6k7B6eCghslEBS+Alo8L4dqrWJU7kJeqmvxV5RjIuXo2keyWLxr4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JNOn0Ag1; arc=fail smtp.client-ip=40.107.21.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CS0EJxUIjfqb65qnrvZ6IEZCmcmipocZDTTx8KohoYpE4BTsN06+fEPu+TLyRefOGGyelZhNQJ3K9zMk/FKHZLEZrYYQKDP2mVj/nQoQcqkkV2rtA0ByM0jpbJ7e6n9vHtQDydWmtUNH4iSVUjxGWjEKtrR6x5ORVDOXL5TyG/Z5JcKs0qKzR5j2rbWtvQ6o63v0HXxEp8U7OOGDXTFq3zqf5o6aL3mLmwN1i8ZBXh94zXNiRomture9ATnJ29oM1F/nMN14Kc0a21LKZbULeXGw1e5jerTqaYEby0mQbC4sH0tIQoCVa+nG9o6PW7rwlh8d7ejjl/unX3dt/cdlPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsdLvbCR9LGIZ/1rDstKY8po6TQBXspJHb1zqdDzGWs=;
 b=vt3lHrMIyPvsLdgzE1ur8nFL0zZFnUkfvMgR4f799HnuwPDb7TR+T6/eIMQqiXAEYrFSEGeQ0M/astRisWvCN0BIkBnPndB078XmjbrOfSh954mIyIa7faYp6pG+lB/JAAolgJbMEUr2W6HYWLrJYrgI9/Jtgd1dqthV3kQekdWtsbD0kiwQD15XrmAxBnJCo4SGDamZhcCEgshp5RJxHbgTuWhdb3jlkLUy67H26gZJLuEU4nd7vHfMlBbMHfh/5+j4JyURy9n6Lq/4ZEPV/5kmy4sLz3TFNYkGzY+qsG1BS7L1n5qrBuwppYouebNR1dSDQvRpFKix3BZiLJICUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsdLvbCR9LGIZ/1rDstKY8po6TQBXspJHb1zqdDzGWs=;
 b=JNOn0Ag1CXMbYqNnBLye9ncIoXPv0Lp6RvPUpLLnAJ0BM6tWbNTAn2De8xIELwunmDU5EvYgRxeZGYnw11fjfzO0kRmBjpjDw8jzrNRqtyIqV114wjJ84mubHPpKbNC/3fQCy1x8wPuJfTCQSWnQL/lDQM+4AiqmutjiltnQyNvi3DkXQu9I463JKxcayRrV2lvYeyfeFxde4rbda0gcwxzgdtrJPZc5LQ4u0qjJTbaDWzHKtheyPdGm0YDqkg3QYpdri4FP8+ms2zl7FqRFXiwXCeQCr+8UnlnnpqMMmuq7T3eANrMnXyOLMWONTHmczsO1cU7jFsRYxDOD4z9jwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8990.eurprd04.prod.outlook.com (2603:10a6:102:20d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Tue, 13 Aug
 2024 16:36:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 16:36:54 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/1] dt-bindings: board: convert fsl-board.txt to yaml
Date: Tue, 13 Aug 2024 12:36:29 -0400
Message-Id: <20240813163638.3889778-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0143.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: c47c3dcb-c885-4440-2002-08dcbbb623b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gJ3V7C7YMnWESZm0I8wdnDHHZWQ/ZFtQLoDHMMIBJvdhNCUNQvwxOM4LYRNp?=
 =?us-ascii?Q?zAroErIQNKf0Qm3rYFLK+kR0ECHQKG0MTUqqMujV2hwcQQx8rfWFzl+tEjql?=
 =?us-ascii?Q?B2IgAk+IuYRsCe2dDhHzK1mcSXzGaELwaVV4rBcWXi3AzJESholSADsKa+M9?=
 =?us-ascii?Q?lBh7Zx2P2sp2UeO6IkCyTBNwcrx9weuo777b8Y7F5pPX31mBJvv4w/Dhtnw2?=
 =?us-ascii?Q?EXLEALLaayErxOpd6rgEG61MGzAPbyaUqmBFOHNdsaFAmBHDNclhWn6DFGyw?=
 =?us-ascii?Q?T7CnVdtPX3cVjHzReeOhDdqmq5alS2tO6DHADImlhl94Sf6Cx8dxE/OCmTo0?=
 =?us-ascii?Q?NEYewE5J4S4jXQ6ls2ew2ZeUjbVRKLSb+RyrYj8h/gwTTLO3KDC+HD7d1FSR?=
 =?us-ascii?Q?UAeD52aaagPpWxsx7e4aXyfCkodNz7u6bWuSkYpMxkOsNSoIMCLiQbDvOGnR?=
 =?us-ascii?Q?UYcSO91wf8hJYj8dsFXzibu5BmHEPWrtZfPhGIqlu1KQMwzQazTI+yjRzWm1?=
 =?us-ascii?Q?mINXDtT9IdfcdS0rPbEoZRb8gNjqa2UEj9J2743gUr3ZCaR20LCdmMmKDbtD?=
 =?us-ascii?Q?exjFDZm+okLeeYdgahHK3yUpM9NWwbl5VVjdE1YTKN37x8h4Se1Po3rPWmcS?=
 =?us-ascii?Q?P5nAc82TNABtSPTm6icoPjvvZQG3eTSlfOamgmPIElgRVY2n9VUWJULldOuu?=
 =?us-ascii?Q?p5qWqjtH4dcPYgEV6mkbfZtX1LIiP4v0a4y2NGM6kTscy/c0YSfxPW223CWx?=
 =?us-ascii?Q?rRaeMo9qWkKqpjbJszEab1qOjberxgCoALz0NubAdqQXsTC+AnmCMQJHisnn?=
 =?us-ascii?Q?+eyjYYjL8fgWDyXnL2WxCiysuDm5ejbZ1jqmAoVnodQvmCqPL6i83Io1b4bV?=
 =?us-ascii?Q?4gK3Bv+YAM8LyodMdCn3T2Fl60NHH5AB/A1CAkHe+nmII95GQ2AHTnmd70wA?=
 =?us-ascii?Q?NPvLZEitxK24ddkerVN2bF+NCQPEsU5hpU0h8wb9PSdEAMdwQQ07Sg33SmWy?=
 =?us-ascii?Q?T98MqR8QhGnhvRhr6foZTZ+2XsGdhMEvuyR9Wzn7RzrboDwj2jV6FuYt8Me2?=
 =?us-ascii?Q?hVu/21pVAOVxOtNs6HYMGY6mcn+n94MQYXyZceX+j4rZSCis447DHTIhkcXe?=
 =?us-ascii?Q?vN57UoQZb2+OZWdt6XjTAlicCN6ykvnOhz1o+vARn5EACpoE7ElCmwEQlkFN?=
 =?us-ascii?Q?OCsT+QhAaWvOumF85zd51yu09j1AJcTb+TGL/msQ+jjNqeQkjH0PF3xoA7da?=
 =?us-ascii?Q?0ijzfdSUdELUJvPcDVooSs52O69DoG7eoPV/g+plZXWvUW5zuksn6oTkzXEW?=
 =?us-ascii?Q?Q/qbUV0V+uilrObduiSGzjAGQ95QBElLOiYCdWrsPlAfCXUCuTpAcSi90VZo?=
 =?us-ascii?Q?cdXHQuw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dvm3eJEDGpWXJeZHmbrf8qfl0ShXQV2WAlk2Nxcv5ceCqvhaxxYSkdwDX2HF?=
 =?us-ascii?Q?q7utudmHhvPoGSLpv8tZSQJM0fJkRVk4UVcJ2tPSw+sxkLdXtfoKZU71Vk3z?=
 =?us-ascii?Q?Fb+Sz1aKLWMaUq9dNrtlIMquMLwlGHwlE4wRRvI1XUCcHgmqqTlI0LamVK25?=
 =?us-ascii?Q?wyRd3CAVMEFYVRTVkGrR06wByifYUlT8UWktj/yxmWCEGzYFnNcCAc/ybb9r?=
 =?us-ascii?Q?95EfoDO6MfW523I7Kq78xsPXgeqFWHgvNy+irhmC4QSr1XvZ0kJasYWT9sh3?=
 =?us-ascii?Q?HXAHZrB7FmIwBv2QaesTeYQwPVfserWn0MPBZ/MD2rhDFd/e88U/fcjIPDN0?=
 =?us-ascii?Q?KwDdR4IG8i3P9FGXdQ0vHPeujhja3I+jHrMLAqq47UYiTR1n1KLQdKXKs36u?=
 =?us-ascii?Q?49MwoOy8hGZMGpQIr4E/E92cd3zUyMK2bwpPLL0PSFzYVwwFuaEIrjO+d/j6?=
 =?us-ascii?Q?qcCa0QyWCzNzFWV+APS2wY3z/sqXupGlqc3eENUKRRsXbXrXFhkFL44dn9Tk?=
 =?us-ascii?Q?ctxY50wSHpBODtB5kpaSCMW2A9XFz+F2TKoWHu+s7u67obD3d0zkbt5b+hYn?=
 =?us-ascii?Q?c3VhfEGR1JtpBBdPht7Drw21DOStFoeEBeFEpt8v0sH3L5xV2vWFAaHf8E4r?=
 =?us-ascii?Q?VMbbOp0mUzb4YD6zb9Hhu2nrzGmWFpaJCIibBUAs0ojFGTJVvAqRXXXKHrDb?=
 =?us-ascii?Q?cyF3YTZazciLAJg2CjwYJn0rBUfq2xmkFz2q9l0YYOVEShVjmrHe6Vd9oPsX?=
 =?us-ascii?Q?QzD3N6kLXw3F9mj9ZAufN9X18V/ZHLxO3dSbl2hagGbssDOzy7p4qGQ3kDrQ?=
 =?us-ascii?Q?Tx/aO5UaV4SvJL5tP6HYgFiGlnWG8CXfgvKXeNHb6Dkt3CatTRF98NdYdTw9?=
 =?us-ascii?Q?dI3MzGhe4mUU7nEaxOoZ4Y2maZnoAvUAhQ12M50mG2sToRFA7An+DUBovu7S?=
 =?us-ascii?Q?QkyNjCXNNq5OqvxIo2naF65VCDtPLhrjzF0nEAv9DgrIu+P2JIwigck8SEJV?=
 =?us-ascii?Q?hF4MYqDIs6OAPe69gExrfEoYmPekMjzAaEDulbWAwpf+qEQtToLONdtNRrHs?=
 =?us-ascii?Q?jL8ZHSphLD6jp5KfzwXF2aV8U6QzZEXQRzsBj4QLqgjhpzhPaZ6/ceAtD40r?=
 =?us-ascii?Q?5YSOXLcIb+lbLlATJXOtUQnQisuITAxGwgyHyqZhF1SmlI1KwXMEqD+mZQyL?=
 =?us-ascii?Q?71f4+4EfB+VNb3R3MwYCss63DKOO6WUNjDqS1lxo4XOv3VjywVZoEZ61RSP0?=
 =?us-ascii?Q?ezoZJODpK710huaQmT4wMzyZ3bv9hS1NVzlpM3yXT0xYdDsFs9DF1wrrJRZH?=
 =?us-ascii?Q?QEoqMD5RIJmvqDcBHooe3JArP+sr810rMu1TGO6MySIleEct3k2byZI5JBWm?=
 =?us-ascii?Q?pNB5hyJhzh/vzwAHMe07FA6mrf30m+WwEzyUUhsXH65B64g6T8EMcPNHyGqJ?=
 =?us-ascii?Q?G1lRbXDLeeWHx9TxusYUjcdXIJI8vameFIyLVOjFadq/AraboLY6KfxgKCLW?=
 =?us-ascii?Q?IJjrCRmAoomUAmJHjOh66V2DDwJVl8oIBsjt91b/UOcJT9GycflT+smzlEc4?=
 =?us-ascii?Q?wZMPFlsEyOhim7QJQx4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c47c3dcb-c885-4440-2002-08dcbbb623b0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 16:36:54.0018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z28s9HZDbFzNKrDy+1+7HqZDefU2rYxm3xthHLx7A1GLvOkKUv5V31wrDCJNJ1LSixHh8EeD/SZyCa0Qfoop1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8990

Convert binding doc fsl-board.txt to yaml format. split to 3 part
fsl,bcsr.yaml, fsl,fpga-qixis.yaml, fsl,fpga-qixis-i2c.yaml

Additional change for fsl,fpga-qixis.yaml
- Add childnode mdio-mux-emi*
- Add compatible string fsl,ls1043aqds-fpga, fsl,ls1043ardb-fpga,
fsl,ls1046aqds-fpga, fsl,ls1046ardb-fpga, fsl,ls208xaqds-fpga,
fsl,ls1043ardb-cpld, fsl,ls1046ardb-cpld, fsl,ls1088aqds-fpga,
fsl,ls1088ardb-fpga, fsl,ls2080aqds-fpga, fsl,ls2080ardb-fpga.
- Change address to 32bit in example.

Additional change for fsl,fpga-qixis-i2c.yaml
- Add mux-controller
- Add compatible string fsl,ls1028aqds-fpga, fsl,lx2160aqds-fpga

Fix below warning:

arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb: /soc/i2c@2000000/fpga@66: failed to match any schema with compatible: ['fsl,ls1028aqds-fpga', 'fsl,fpga-qixis-i2c', 'simple-mfd']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- drop description in fsl,bcsr.yaml
- bsc9132qds is too old, their dts have not simple-mfd.
- split qixis-i2c compatible to two group, one with simple-mfd and the
other one without simple-mfd.
- Add new full example for ls1028
- Remove [0-9], keep @ for mdio-mux-emi. Dts need be update to avoid
warning
- fix typo dt-binding in subject
---
 .../devicetree/bindings/board/fsl,bcsr.yaml   | 32 ++++++++
 .../bindings/board/fsl,fpga-qixis-i2c.yaml    | 70 ++++++++++++++++
 .../bindings/board/fsl,fpga-qixis.yaml        | 81 +++++++++++++++++++
 .../devicetree/bindings/board/fsl-board.txt   | 81 -------------------
 .../boot/dts/freescale/fsl-ls1043a-qds.dts    |  2 +-
 5 files changed, 184 insertions(+), 82 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/board/fsl,bcsr.yaml
 create mode 100644 Documentation/devicetree/bindings/board/fsl,fpga-qixis-i2c.yaml
 create mode 100644 Documentation/devicetree/bindings/board/fsl,fpga-qixis.yaml
 delete mode 100644 Documentation/devicetree/bindings/board/fsl-board.txt

diff --git a/Documentation/devicetree/bindings/board/fsl,bcsr.yaml b/Documentation/devicetree/bindings/board/fsl,bcsr.yaml
new file mode 100644
index 0000000000000..df3dd8399671f
--- /dev/null
+++ b/Documentation/devicetree/bindings/board/fsl,bcsr.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/board/fsl,bcsr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Board Control and Status
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - fsl,mpc8360mds-bcsr
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    board@f8000000 {
+        compatible = "fsl,mpc8360mds-bcsr";
+        reg = <0xf8000000 0x8000>;
+    };
+
diff --git a/Documentation/devicetree/bindings/board/fsl,fpga-qixis-i2c.yaml b/Documentation/devicetree/bindings/board/fsl,fpga-qixis-i2c.yaml
new file mode 100644
index 0000000000000..28b37772fb656
--- /dev/null
+++ b/Documentation/devicetree/bindings/board/fsl,fpga-qixis-i2c.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/board/fsl,fpga-qixis-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale on-board FPGA connected on I2C bus
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,bsc9132qds-fpga
+          - const: fsl,fpga-qixis-i2c
+      - items:
+          - enum:
+              - fsl,ls1028aqds-fpga
+              - fsl,lx2160aqds-fpga
+          - const: fsl,fpga-qixis-i2c
+          - const: simple-mfd
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  mux-controller:
+    $ref: /schemas/mux/reg-mux.yaml
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        board-control@66 {
+            compatible = "fsl,bsc9132qds-fpga", "fsl,fpga-qixis-i2c";
+            reg = <0x66>;
+        };
+    };
+
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        board-control@66 {
+            compatible = "fsl,ls1028aqds-fpga", "fsl,fpga-qixis-i2c",
+                         "simple-mfd";
+            reg = <0x66>;
+
+            mux-controller {
+                compatible = "reg-mux";
+                #mux-control-cells = <1>;
+                mux-reg-masks = <0x54 0xf0>; /* 0: reg 0x54, bits 7:4 */
+            };
+        };
+    };
+
diff --git a/Documentation/devicetree/bindings/board/fsl,fpga-qixis.yaml b/Documentation/devicetree/bindings/board/fsl,fpga-qixis.yaml
new file mode 100644
index 0000000000000..4d4eb45ce64cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/board/fsl,fpga-qixis.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/board/fsl,fpga-qixis.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale on-board FPGA/CPLD
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: fsl,p1022ds-fpga
+          - const: fsl,fpga-ngpixis
+      - items:
+          - enum:
+              - fsl,ls1088aqds-fpga
+              - fsl,ls1088ardb-fpga
+              - fsl,ls2080aqds-fpga
+              - fsl,ls2080ardb-fpga
+          - const: fsl,fpga-qixis
+      - items:
+          - enum:
+              - fsl,ls1043aqds-fpga
+              - fsl,ls1043ardb-fpga
+              - fsl,ls1046aqds-fpga
+              - fsl,ls1046ardb-fpga
+              - fsl,ls208xaqds-fpga
+          - const: fsl,fpga-qixis
+          - const: simple-mfd
+      - enum:
+          - fsl,ls1043ardb-cpld
+          - fsl,ls1046ardb-cpld
+          - fsl,t1040rdb-cpld
+          - fsl,t1042rdb-cpld
+          - fsl,t1042rdb_pi-cpld
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges:
+    maxItems: 1
+
+patternProperties:
+  '^mdio-mux-emi@[a-f0-9]+$':
+    $ref: /schemas/net/mdio-mux-mmioreg.yaml
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    board-control@3 {
+        compatible = "fsl,p1022ds-fpga", "fsl,fpga-ngpixis";
+        reg = <3 0x30>;
+        interrupt-parent = <&mpic>;
+        interrupts = <8 IRQ_TYPE_LEVEL_LOW 0 0>;
+    };
+
+  - |
+    board-control@3 {
+        compatible = "fsl,ls2080ardb-fpga", "fsl,fpga-qixis";
+        reg = <0x3 0x10000>;
+    };
+
diff --git a/Documentation/devicetree/bindings/board/fsl-board.txt b/Documentation/devicetree/bindings/board/fsl-board.txt
deleted file mode 100644
index 9cde570159219..0000000000000
--- a/Documentation/devicetree/bindings/board/fsl-board.txt
+++ /dev/null
@@ -1,81 +0,0 @@
-Freescale Reference Board Bindings
-
-This document describes device tree bindings for various devices that
-exist on some Freescale reference boards.
-
-* Board Control and Status (BCSR)
-
-Required properties:
-
- - compatible : Should be "fsl,<board>-bcsr"
- - reg : Offset and length of the register set for the device
-
-Example:
-
-	bcsr@f8000000 {
-		compatible = "fsl,mpc8360mds-bcsr";
-		reg = <f8000000 8000>;
-	};
-
-* Freescale on-board FPGA
-
-This is the memory-mapped registers for on board FPGA.
-
-Required properties:
-- compatible: should be a board-specific string followed by a string
-  indicating the type of FPGA.  Example:
-	"fsl,<board>-fpga", "fsl,fpga-pixis", or
-	"fsl,<board>-fpga", "fsl,fpga-qixis"
-- reg: should contain the address and the length of the FPGA register set.
-
-Optional properties:
-- interrupts: should specify event (wakeup) IRQ.
-
-Example (P1022DS):
-
-	 board-control@3,0 {
-		 compatible = "fsl,p1022ds-fpga", "fsl,fpga-ngpixis";
-		 reg = <3 0 0x30>;
-		 interrupt-parent = <&mpic>;
-		 interrupts = <8 8 0 0>;
-	 };
-
-Example (LS2080A-RDB):
-
-        cpld@3,0 {
-                compatible = "fsl,ls2080ardb-fpga", "fsl,fpga-qixis";
-                reg = <0x3 0 0x10000>;
-        };
-
-* Freescale on-board FPGA connected on I2C bus
-
-Some Freescale boards like BSC9132QDS have on board FPGA connected on
-the i2c bus.
-
-Required properties:
-- compatible: Should be a board-specific string followed by a string
-  indicating the type of FPGA.  Example:
-	"fsl,<board>-fpga", "fsl,fpga-qixis-i2c"
-- reg: Should contain the address of the FPGA
-
-Example:
-	fpga: fpga@66 {
-		compatible = "fsl,bsc9132qds-fpga", "fsl,fpga-qixis-i2c";
-		reg = <0x66>;
-	};
-
-* Freescale on-board CPLD
-
-Some Freescale boards like T1040RDB have an on board CPLD connected.
-
-Required properties:
-- compatible: Should be a board-specific string like "fsl,<board>-cpld"
-  Example:
-	"fsl,t1040rdb-cpld", "fsl,t1042rdb-cpld", "fsl,t1042rdb_pi-cpld"
-- reg: should describe CPLD registers
-
-Example:
-	cpld@3,0 {
-		compatible = "fsl,t1040rdb-cpld";
-		reg = <3 0 0x300>;
-	};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
index 11b1356e95d5b..697c5b3beea9d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
@@ -211,7 +211,7 @@ ethernet@f0000 { /* DTSEC9/10GEC1 */
 };
 
 &fpga {
-	mdio-mux-emi1@54 {
+	mdio-mux-emi@54 {
 		compatible = "mdio-mux-mmioreg", "mdio-mux";
 		mdio-parent-bus = <&mdio0>;
 		#address-cells = <1>;
-- 
2.34.1


