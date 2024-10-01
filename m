Return-Path: <linux-kernel+bounces-346517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD15F98C579
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AEE4284F14
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBB31CCECF;
	Tue,  1 Oct 2024 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="msb+mQor"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2045.outbound.protection.outlook.com [40.107.105.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90E91CBE8E;
	Tue,  1 Oct 2024 18:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807886; cv=fail; b=Yf9MA52DeinZt1rjwJAGmkkadbt23Swa2L0PosP/Wd9amIgSd9ijamvKc7YkJEp56QV2yuH486sEe6NRf5MND5W3JNLiB9QEBsZgoOJloQnayyjeovQ+MjdXFGIrboRINOQ4IMLihoZkVLT64iGEPO5jj6V2qmXm+wCIOe7fusI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807886; c=relaxed/simple;
	bh=Do/kW6S3aWJMYNR52JBDJ6/vLjs3UoO6DWr6oLkcZKs=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XJQfOE+6sj+/xaHF63l+dS0ZwJjJLEe9DfU1D06QLnId4HyihZsVhPC4Kq37FSJ6ojOFJkhR9Rr91KXi7ajQSBIcg6Cz88LDE+TM8krji4JN1hmooJ8+HHRWhMYKS2sxuGJ87Bu/I6zB5vva65eKC7F/0bItOUlwIrBoQRe4XGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=msb+mQor; arc=fail smtp.client-ip=40.107.105.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkUgoUYQJ29f5uIwvmAAYKi2tKuJC9AFU2OFA2NWuUABK+pu4UJoLY8TbwuqHIvXIF6LoNeQLp/PncpGOXhOkEh+y4lpJiXDA1gjbXuLx9ptbf6rwDumAhLa4BvZXy11sv4Wy0geQhOnCtEyhe7H7j76JvaVsHOSh9+ySmNS6mzKoAWiekV4dN5zTIrTyRbNP7FWotIu++zLiUWOJVDXdFgur3EwyyuLF98Muz1R47EWu1cQpUUuBdEiNC2St9GGGgrHJ2imOpKUEnDmxo84OyPFJp3H+EhK+zy+GJBFY7dhLjKOyMd6el/Au4FS+Rggo+vl2uh9eguaFeuWUt+LCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9xXMOlzD5HFSxgSrDsGMEP1t3pnUaQf7x1FyzcExe8=;
 b=j46X1TLBi/MzKnb2j09m3kdT4/N2Ii9VEKLxdxGoRLrtS0lAnA85+QhxkRQWx/7u1vBu9AYdSlbXM5HccESGPWf+daU5VDc6ueU+LKh+wmLABeAUyRfG7gIVwUPZBibk5onZHXHWoQENrnqpsG6UR0mNnDgwl1j2ooy+Gtlwkh1v3nBLOPHgJRWy8s9w4LMWDYn5vtWkmoGT1yYC76ug41OBX7IpwOW4vy8d2sgUcp3ns2NFdfKQDpkNNCeskN2v6zssZcR1bSzA6p56/HuQRdLcJk2XqmpjIcuBP43Xok2yBtWblQJc3L49W0RFl3pZO6eNaTb9/8HYaSTaDIx5Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9xXMOlzD5HFSxgSrDsGMEP1t3pnUaQf7x1FyzcExe8=;
 b=msb+mQor4jaKp+c3jcgblxPVMZ5gBkW7NVlQnJR55ohRO0z+OI90CfCAjZEZwcJcmW5rtUNFYVmJrDU7h579LpxuegpKSqbBWIYIQwcRo8riX87bEnpCEhPm8XmrN/cOdm8zZcq1gjllvvhHQCFSl0JXYTMUOMPZTctvfPLoBu1hkonOcEF0Nb2eFWPy7jXh78HbHgtCyCTtiUpOJSPC9615lgPg7potGW7u9Gs7BVeNEK9nLUoXqATF//kHcwwLIG4ZvLJUaA437U5Wv9pEeEiY3aT6SKohOb9w1NV6P8hrvIuYs0UiTAjB2aZxMsZ3qBadcEh+KDUYJJLwjyU5Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7210.eurprd04.prod.outlook.com (2603:10a6:102:8f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Tue, 1 Oct
 2024 18:38:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 18:38:01 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/1] arm64: dts: imx8mp-evk: add PCIe Endpoint function overlay file
Date: Tue,  1 Oct 2024 14:37:47 -0400
Message-Id: <20241001183748.256607-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0180.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: 966f1b29-db8a-4e85-7129-08dce2482df7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZJm4X1wNlEawur9zWUOFYDlf7IIGt1nbRQ+TSCdU/qMwXZyqUpO/I3rSYwo+?=
 =?us-ascii?Q?evTs62y9qNQxJjjXp7ZfOTvDqXn3rwz9uXyVg8YBkOqWVaJ8R5LxAjn7eE+k?=
 =?us-ascii?Q?4uMf/fTR2rA/Qj/lw7yaMH1plxu200LoH8lXMjHKi94t7Qx14cAjx7+YMW6i?=
 =?us-ascii?Q?7SC/yw7efqobmd5TsH2hnBTZXNBHQJz7gUrqXomk0X+vWBO+To/3PTwrn5Y8?=
 =?us-ascii?Q?BI2MrlgDFDjmGaff2DuqD8nZuSXjk8e+EmPov3AlDGlwj6JlD6hwBuiwae6M?=
 =?us-ascii?Q?AWbTayTDbhqbV2J5PJCHstVXUSo/icnocW7oCSdjkho/LYyk+vozKjWwEE9Y?=
 =?us-ascii?Q?SXflPROQIjMfYpCudQrRcP6qH7m51TyL2ekqkxUuXHI3IADiKAiS64e50onM?=
 =?us-ascii?Q?VWn+PzMmTlbr4ZRqHwAzw7B7gBj5WlIaGgKmuVWZi2KWYlL++2AS+9EMhO60?=
 =?us-ascii?Q?C9QSpIAx2gU3z22PY15mBXEzBmLVye4DoEqUvvdTVptGphX2mEqwRiBbP3p+?=
 =?us-ascii?Q?FWxMiKQUXojHIAd5Nssl/Q/HGA9wPUrj3KhYnMjmXeszMHtLd6nWQf2bEHfB?=
 =?us-ascii?Q?61Ap8f5PwrN/mXtNLDxZpMAEOjFr04e+sX3qQhXHI2ZlYl4n0GyXHji1d18G?=
 =?us-ascii?Q?T18lGUXFDgrL02/f9b9jMYwQibY6zztnGNic7/lJj0/3xlkIqOh08G1g6uNy?=
 =?us-ascii?Q?6szaVObPH5Yem9Rg+DX2wMy1Opz4AJtsMBQ6ssjimmbIqBtWr8qJgN+SYNB2?=
 =?us-ascii?Q?3TwHLB6uTmEKKVjqDl3gtB98L1j0lCJ0RD5N8ZcXA5bpRB0JvEwWLRmu4woA?=
 =?us-ascii?Q?CEWzjjGyZW/UISb2I8+OIUhrMaLlVDda08oVoHr/1EYq1bH4ZF6FLx81rBCk?=
 =?us-ascii?Q?7QcxQ9nphAlEpZITQASfxFY4qTS/PHIONkajswiXbMpfyH0VPseKvP4NDRZ3?=
 =?us-ascii?Q?9PXwj0zain1A4XcGon9m6F/MJysTZxNH0X+UIJfXvlhtL364pfQPsMlWCPL0?=
 =?us-ascii?Q?BkL+7eunDopy4BPo2wX1g6/uIl0wFsCvzeKj6jGJlTPJvvg5NtsNaXPz8i1z?=
 =?us-ascii?Q?TSmrM8fdC7dhra9Ziv1McrCPL6mwwJJJrNJJls7EV/Ns/2UwL3t/y+vOKT6m?=
 =?us-ascii?Q?HsAImWNKdgoia4ToIN3kLibnMBwy1WNzaDlTP+NLWYiP6oFMUYZRyg4Tk9u+?=
 =?us-ascii?Q?Irm7urkojJygFQQc63Wt8sqZXN4Hf2XD9EURhoTbxfVWI4l8WrKCfFM+RQg8?=
 =?us-ascii?Q?ha//7WnLvjfovlXiUFug3o+pF521m7XYlGvlEmYaUpsSd27YnIkByQX9d4x5?=
 =?us-ascii?Q?Buqcvr+vgn472cE8L8dbGEYELr0GaRu1TznefShpJGp+qq2osnV0fnBaH3cz?=
 =?us-ascii?Q?jt30VYUr+qEo+Y/nA32UJ2aIh1DCB2DNPgiyGkh+fS9rPOGFodEezMOBTOwS?=
 =?us-ascii?Q?eq02R03edtw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dEf8x6CohFkoaW6Ip1dDumQB9zh4oWCqfoofXnukUEIOLo68dSf4whujyyj4?=
 =?us-ascii?Q?XgCevNbRHGy78N8JRdr3HvSbJ2s2ROR2Fz71k5RZ2idLipp7AbGix8vuDTip?=
 =?us-ascii?Q?9ZOVUd7yEfoxiXW2FdhkeLRy3k1SYKeMyyAB5N+jDLYKxdwg1CHvPyigGstt?=
 =?us-ascii?Q?1srS46qpwox1CrxGselzeTBjPjt5d7ROxmmbEL1En+YKbY56C6cQTq1FhKpb?=
 =?us-ascii?Q?U4c+3wBkPPqIfX+PgmrRZmRItBK0+gVfuB37HDBIz9wNqcj5QhrQThnkDN3E?=
 =?us-ascii?Q?vLFVtTYKoFazXd2dNIv6DzYgyK+velIJ8nPmSL40MPS7RIAS/z4N505tCS6m?=
 =?us-ascii?Q?SL+guE8/YZch0dkqCFU6I6p0kEeafkI1zUVrnx5u92H9SodEFwkjR3ZIh776?=
 =?us-ascii?Q?xaS96ii8NX+TItNJe3GrRe8Gtuk6OA3Aa64x8RlXWDbzPMF8WJmn5oDeiruk?=
 =?us-ascii?Q?GlYe724vwl4B0/5tnjFVNJqcQK8iCwRJc3FskFbwStOPefp67Nzl9aFJrGbs?=
 =?us-ascii?Q?QgmnDSNVYn2PD7FUDphWeZVN7sSnay0RxeOl1J5HyfP+VNgBfJi5ZTdy/gbS?=
 =?us-ascii?Q?P/briat29JAK2qDpeChZK0vs7yN9ZNp0pMVE6PCPhM6auRbnfK8u4MQs7Gjz?=
 =?us-ascii?Q?RT0n17rF1IoT7SGjUFEOfD1vCUsXECTQQYFeHrpFHLLj6JcQCdkSS4fdgDG9?=
 =?us-ascii?Q?Pgib+q4ZKdjjHrd+/ptJvLwg5IH/4WlW9cD4mntT2Fp3nHhrOdr5aAPBxHYD?=
 =?us-ascii?Q?HxFvwVKTIjzwxw38AJ3H/hMIstm56Noc0i7h0JyVBiWGVmwbXXfAQIrJBJlL?=
 =?us-ascii?Q?VKeijCLA41EsZU9zDg1j6H7hWo34MCxFbo7u4KzHZMQkNZpNpw6ojx3X7gd5?=
 =?us-ascii?Q?w43/1u/BmuGdgIUNaGwaY8kL/yv9wmQPZyCfAF/0DMHsGyYXLCE+EiEcBLrP?=
 =?us-ascii?Q?Gsx6F1RmrNlEoIh2mZgJwmYqYqSODDOOHhsvmShhCUbY9g52Hj5bZiDTq9Wt?=
 =?us-ascii?Q?Pe3ne1/tJ1UC56GyjFRt/xsLcGRLfC+9VT26NQZvRf8PijGzDjIKCJZf0IKH?=
 =?us-ascii?Q?3qcFlM70LiuFIvp1djBBgxNavKcYALvF+jLxr44CwJ+eDEqGvROyv4JurD26?=
 =?us-ascii?Q?mNZshHdXzBF3CTgcUcO7wx4SiMb2vMt2l5H59YBj+T5CpVrj411/+ZqPmLfn?=
 =?us-ascii?Q?G21kCw5V1cw3vD8fdlMOgGHVCCuSbLio7olWwp7fhkNVdzEjMvGsrpYktf/x?=
 =?us-ascii?Q?DLqs81ASPzDFVdUoSeRf/nV7FhW5wDGhcEorPovVMfJQ6mNeD1ktR5X+P5Di?=
 =?us-ascii?Q?3ByArFkKeQu+z1lJZ96QLwy9GOFTUQotckI6wBCcIvjz2KINlsJ+1BOnOA1U?=
 =?us-ascii?Q?4MzLkZPzk5sr92sHSoKSo1iat7Hmyh9hMdnO5eAHPd9EV2XAuIehyQb8JiWM?=
 =?us-ascii?Q?cPOucFX4CvqBkKX4ze1pzB7zRb3gYOZq9WJiW61BS1dxyxbxtV+r+KeLy0MZ?=
 =?us-ascii?Q?vWGgfPkAwGGYmcUZsVRhMG6vzAFTi1XAnBx+NE7AOFwWFcpSXAFB0AuULwtn?=
 =?us-ascii?Q?Jmjy/uEcJ7DnRo6biOSFYFsVdPuPQXBlQ+v6CkpQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 966f1b29-db8a-4e85-7129-08dce2482df7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:38:01.7654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N1Dsvw9hFY0mpeLZP1LlSdckrEogrtkm7joI0YQpeLwEJqgBoRvJvVYVBWxef9Y9PH4vAOgujId/mMQ8A71Beg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7210

PCIe of i.MX8MP is dual role PCIe controller, which can work as root
complex (RC) mode and endpoint (EP) mode. Add overlay file to let it work
as EP mode.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile         |  2 ++
 .../boot/dts/freescale/imx8mp-evk-pcie-ep.dtso | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-evk-pcie-ep.dtso

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 9d3df8b218a2e..0d8cf020ec2dd 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -197,7 +197,9 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-wifi-mallow.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-wifi-yavia.dtb
 
 imx8mp-evk-mx8-dlvds-lcd1-dtbs += imx8mp-evk.dtb imx8mp-evk-mx8-dlvds-lcd1.dtbo
+imx8mp-evk-pcie-ep-dtbs += imx8mp-evk.dtb imx8mp-evk-pcie-ep.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk-mx8-dlvds-lcd1.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk-pcie-ep.dtb
 
 imx8mp-tqma8mpql-mba8mpxl-lvds-dtbs += imx8mp-tqma8mpql-mba8mpxl.dtb imx8mp-tqma8mpql-mba8mpxl-lvds.dtbo
 imx8mp-tqma8mpql-mba8mpxl-lvds-g133han01-dtbs += imx8mp-tqma8mpql-mba8mpxl.dtb imx8mp-tqma8mpql-mba8mpxl-lvds-g133han01.dtbo
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk-pcie-ep.dtso b/arch/arm64/boot/dts/freescale/imx8mp-evk-pcie-ep.dtso
new file mode 100644
index 0000000000000..400e36db9dccf
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk-pcie-ep.dtso
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2024 NXP
+ */
+
+/dts-v1/;
+/plugin/;
+
+&pcie {
+	status = "disabled";
+};
+
+&pcie_ep {
+	pinctrl-0 = <&pinctrl_pcie0>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
-- 
2.34.1


