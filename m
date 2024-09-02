Return-Path: <linux-kernel+bounces-311080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 237B09684A4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 740CFB20DFD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515C0140397;
	Mon,  2 Sep 2024 10:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i0SIo6pS"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2055.outbound.protection.outlook.com [40.107.22.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B182E13D52F;
	Mon,  2 Sep 2024 10:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272910; cv=fail; b=TdP2zHppYqOzemIGrHYRT8gLUNZ2ey2vAxY95YSTyGEHhQNci6bONWt0nki6CrYdRzaQS3+aVcpx8ES3WAkCb5sKs0NcnlaM2ASM/fgzd8Q7umPaeGx3sptGtAV1VKbZCfRVtIh7Uvtldfoo5oQia4tkdF7czg0PXmrKXt0sTF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272910; c=relaxed/simple;
	bh=8uMuCxmNR71MPNMBr+N0ACNooORvhrUa5mlyCKnjEvY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KOBsQrr0CpLA2vYnUXQCpbqu4BCwmx7snc9szXjYD836IiLNzKPEvz/IcJeVt/NqRDOA21deFsZLfng6SUKzGwlFpxsKeAvXwDYIE3SieUvBxuZNP6/1CSGhN/ZdT+B7InOlovOVTyzj3SBCHAS0CoLFpB6Ts2wT97nYdO2MecQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i0SIo6pS; arc=fail smtp.client-ip=40.107.22.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9623Elv9C5I+4Wnys4v6jq6Q0cHF20JEQQC2pvoCz3Uncq5kCGjtE3KUBJTkWc0dEg2qplADVql2Xe/4w4JWtfkjcn5ctk+xhZL8N4FSNBs+I1sWNDRkMDSI/sWIPqza+89If8uH0LM04P77KHGe2TNFLzqD3S3HeInvHsdzAag1aKT42gPQRzgSv8myT+A+kPUmA3sBIvEafsTuQMoOILfCpl//gkyLjK46kk6zHI4o2RJRoMuI5c+Q/eG88GFbYjmuwfo0KzH29syuX9nd+hLoi8yXwrJX9Kys11CIWCbPOOYXIBD/2s/c/ShGhlxF1qcUKxsaFYhQI1x+y6mLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZP4WjcVS+RhHrOKgJzP5QYcOEooxTv3DwqzefZ8iJI=;
 b=Xex7kAPKvPRgXbHGCc2h9ZpopQsL/MWVUHCO2W/5ZF8LuR8c1pTRco90kXERd5yxFHmJ5Gh23ECZvo1s0Cz2V5Zh1Y3xo4vfdUu25OCTs9m4134XxYJz76mRMwo/eHpAkUX9/0q1tfeILWZzDw9/s6G00Qb2EAmWjmV20JasFAC7QurmTziQhh0/ZV+xJS14f1WdPQhD2wDvMSQKSucz7mRipecDm0IJwTIHIlMELsDNweMNjXPBWE3atfuUwQH0mFAHm3LbGyESA6PIlUiffj7lepM+QJoiiORL8hrj6yATv5I74U1vn4m+VbjlQrkyO+ZLoM0RAXAP3/17OAvAmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZP4WjcVS+RhHrOKgJzP5QYcOEooxTv3DwqzefZ8iJI=;
 b=i0SIo6pSAstRRi68439nVXa6WlDfq7q0hc+kxGdptprCg7S/OYH9Qb6gdYtJDhwvfBL1AqNBm745KLkq6Kcv96JUnxpupHgkmb4yBU3ayrMXkOquPmurgjFSinHJZ6xyNTFPRlqsrlTb9ARjgcnqILzI8iKd0eZJtFmtvP3TUuiNydbH39+yA18I+8qb0ObE5k2hPq5g2mF8/ISLkxDnEy4y99V/b1xmzKvlcfXEXt8CRBsfPx5Vi67y97rmh3AUNgdVJFn9RacC35lkQ7dDEPkQBdVLxD7KeTciNxBYi9rwR8EJI7jFUiz573VFy643OUE6GEpzs5Q6E6Kpjr2i1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AS5PR04MB9896.eurprd04.prod.outlook.com (2603:10a6:20b:67d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 10:28:25 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%3]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 10:28:25 +0000
From: Joy Zou <joy.zou@nxp.com>
To: frank.li@nxp.com,
	ye.li@nxp.com,
	ping.bai@nxp.com,
	peng.fan@nxp.com,
	shawnguo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: ls1088ardb: add new RTC PCF2131 support
Date: Mon,  2 Sep 2024 18:36:26 +0800
Message-Id: <20240902103626.1414595-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|AS5PR04MB9896:EE_
X-MS-Office365-Filtering-Correlation-Id: 48a7b654-eed5-4f35-b893-08dccb39fa2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1U+sMC09Y6MqQM4NWab4WLEnRufJaHB0hEikyZpdrlDWlRvb8ZBJxRafy3WE?=
 =?us-ascii?Q?kSUiWjXnqJ9wboRA6vy0RojrlWANdYHzl/j0LwhApCm6HJgP34cKM9FY9LE2?=
 =?us-ascii?Q?q1KtJTMJ4b165Jd3I8y9CbxpvGWGZsioFe8lziwcZFnpkqzi8dPBSidOzEJO?=
 =?us-ascii?Q?BIe9sJWB68JBYDt5rgfhB7yPVYmev/gSvACKt0ZZ/RATDQIpHwH1RtZ32EEN?=
 =?us-ascii?Q?Mmlu/0czO/+MWzDyf7uUHK+tsfyBS5jVVj6PHHE1sWk+VXEh5FrxSwaOk5L3?=
 =?us-ascii?Q?ACHix9qDiTfwRNzysaHEmfbC9lWgDqxDbaLLLKUORoabJiw8Pd/i5S0yopys?=
 =?us-ascii?Q?3MtDt66ue8h+W023Z5z+UW/lggwgXhk2dAVJPimQgMlRN0zwvOV6sfLVK0SC?=
 =?us-ascii?Q?znqjBmMhEuuwZkPYCQh+EW7X8lf2FCMzaykgcMomHBsWMPTIHxgoWW2OyUI/?=
 =?us-ascii?Q?YkQTj5MtnDe1lsWpwpODiBAFHeyyDF28J+wTa6aelLOxHMh6rNL58KFEA2wN?=
 =?us-ascii?Q?EAt/7ibUoDNGNpH2Di5QcGCPSjPeTWjZqF8DfI6uaFMXa4+lTPuLoPdvHUZO?=
 =?us-ascii?Q?EkS2NXpDN25/h99fDqcDdM5lMvR1yQ1cDo/lXcHjlab9wRmk9aD3IQGPkQg4?=
 =?us-ascii?Q?PLv3jhv7tfTVAOQIBuYy2QnTPwpwTz3mYy0ekLZf82MUIJOeTRXWPk8t07ZX?=
 =?us-ascii?Q?dItM/8+xY7lEerwdVh6XpgsFDokD/c4DB6IsCrO02vwn1TANb0YW+E4qvMN+?=
 =?us-ascii?Q?9XoJCExOtUB+pvyYi/GplVoq1LmjvvpasB0X6Zk7MlGgonCIAUN0XpQmbLDb?=
 =?us-ascii?Q?1TjnVjCfSod2lXJ7ITsdDV4aUCy6/+NmRl7VuM3OeVwzMfYsuDqVvITnFwEO?=
 =?us-ascii?Q?L38IOIdQPL8ufTd7jebhpufheSSyfcxwb4UVXjKC+cAVAg81QCGbD2P2/EV5?=
 =?us-ascii?Q?GTR6IAVwo4fmwSBrjigrA78Gi2uehto6abfknBF565SYdXyaDi3mD77XCSV3?=
 =?us-ascii?Q?5899Wdgslt3n8kWXFm0ksUBRcKkEodDet4RmPI5oYcWrP58l20/QuWyuNmLk?=
 =?us-ascii?Q?8tm3R7W5cx27RBtBIWqyTFpN+/LLusZfbZVViDWQocX7/oEb/O5AqogYWTXu?=
 =?us-ascii?Q?BRlplrWfQpXnLxOQ2I0a2Kxb+cVyiYctk5Tc5KghMfzX5RGaW2KQk7NUn8fv?=
 =?us-ascii?Q?Ow7TlhcvwoU+N7jRZ7dKV7MeyQdfif/k9L0UPwJCNjC5sAlG/R5Y7QpNPj6I?=
 =?us-ascii?Q?pkWCq9CWZJZAKSQaQL6X3PGyat64mry1WFphURasQF2jg+spBlMo1wiYFozP?=
 =?us-ascii?Q?O+36bYttizawmr+o4WP0ox62fwb1H29LKXvSdX+FC3Z2bOzIySGWZelPtyVC?=
 =?us-ascii?Q?NgDTURqyRYB9F4hqdnEx2GZQ9wio3iklYxVwiPKpTIOVUZxL5A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?USPB3MYUd15z9GkuvoZtmy8f/GPqYoMVYza+oJ9DAU6O/7IwjCEUXZ5xQ3eI?=
 =?us-ascii?Q?NWP64UrdZOpOiZdSmePWagi7KGbFfDT4eEUuBLASg60jcgU/ItfO8Fh9W4+y?=
 =?us-ascii?Q?HkoQ/4xv5VwOpOPBzT8USz23M28NzqKkkXd2nSKIcsR9LtDEB01sM3V4BDbh?=
 =?us-ascii?Q?Y8HE3cWtCgME4pDM1mXLEIW2KV9y2G0Zv9a1RqG6OTtsrnrvZUAFJ4bKFAGQ?=
 =?us-ascii?Q?a2Q5NJiiNI+CFvL9icmF0sOUtOgnQkQPYgsx5LIL9NbpWYgXtg46mFlogCQt?=
 =?us-ascii?Q?xgW40xyl2BukKruJige+2qbWWew2lao3O239LKUnBk7a39ROXB5FMa6AYmYP?=
 =?us-ascii?Q?7ww2PUdwWDFWjLXDAxtREWmgC+fFsrHu75SITutqj8MXaXGDXI1E5XOmZb5M?=
 =?us-ascii?Q?5+c+lH8NTagwgnbHVNkkLXBAHjPxbL7LXfq0C7/6K1vxwQt4kjbg1U96JtKt?=
 =?us-ascii?Q?fv1mQ2UM6n4xJvMiCx+H4EvtIyTqNf39aJj6wszj7i2FpCuVlsxwWn2Kzo4m?=
 =?us-ascii?Q?s+y6eq+4OnPpRTefbzXNkoA1VPBikedzl3P7AAWamJBqMn4ZoqLPgaBXVVoG?=
 =?us-ascii?Q?1ZvhF6zPnbP7AUZhxDfSWjzOY/P8AAUqadBcn/pFpOykOvlE8rxn36i0Gk2p?=
 =?us-ascii?Q?RknzhhPOgewDpkd4STbLSZu+SsHOof9kkbvy8BBnmCVyD0DZYid9WqFDLU/R?=
 =?us-ascii?Q?DWO/MVB3g6GoSthWiT3oHO0uY8mzfzWSIOQgsaN/RLG4wFxL/dMOHCvriuUT?=
 =?us-ascii?Q?vj22GNTuvJlOC/0+t0ha+sWJX2BbM254zB0GOclw5o4Wm9maLHMEusNUAqxk?=
 =?us-ascii?Q?xPsiX46A3J9HF3VxClgEf4/IeTny5KvVspU2+5z3TfX6Eege0AeYB9t0Fc+I?=
 =?us-ascii?Q?WbMssYlNw9pvxwE6ty+tzLw66cjphvsMfsbg44Dq9z3jvSnJqhRs/4nt0xWr?=
 =?us-ascii?Q?/Z7xgC/rSLPcYe4pbO61zFQGVNw0FUoHyZ+CnVLoO4LDfkVEiK0JpuRUBbLK?=
 =?us-ascii?Q?LTq8TcZBcrw2tCSCrfj86hGZP2CUO5BRuh3QsQ3Q92E4CqrSbLZKPpZDzL+u?=
 =?us-ascii?Q?LTtG4OwXF4Uj86QVg9TtcYtQFu/6joO3F+J3XEKqN3Bqd/9c6cLtcnVoORpd?=
 =?us-ascii?Q?rtw8QHB/PONExS2roMwtTbnuFGDC7hX9NYSFDfSOjHiwhZ2mjOIe4BPJSh+w?=
 =?us-ascii?Q?G71EuP/H2XnZWAjrHxvUfdW7n3vjCCL8KNpRtEAS7nFO+iWlzLiHpLgYE0W2?=
 =?us-ascii?Q?fDrkedmDTLsg3fR9v6SKhbHa6cbo5wA+XegPSXtAyhRhDX+wJhhDnP9cuqwt?=
 =?us-ascii?Q?lKmx516B34PoJyxijRqWjMu/UKVr3HEpxVjEQQ0qHbM9P77XnaMATR4oG2Q4?=
 =?us-ascii?Q?W/J97MXUUH96iX8ixpSXE3+e0gsAqtD357yt7hS9ck5Zjvzo3yXKbgsOvIg+?=
 =?us-ascii?Q?+6kgPF+HFwEBikxu2Zrg7Tv0OaUypp7UEovQfLgoOkL7QwhyErbHSixfoeSW?=
 =?us-ascii?Q?ZkbWerBiHs5Pl6TYN7T+q1BLzPi+uRhfhvq2yR9517o12b20brTXtXUU6ZWh?=
 =?us-ascii?Q?CWT9AcSzfd8tiE1inSWv9BggzJRH9VuX03UBWbxR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a7b654-eed5-4f35-b893-08dccb39fa2a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 10:28:25.3918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: igsvL2RXMxmeYcARxiSEF+Lm8F867YdLudFtEfAN4KqUFquFkH0oogdbSvN9231i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9896

Add RTC PCF2131 node for new ls1088ardb board..

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v2:
1. modify the commit message.

 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
index ee8e932628d1..2df16bfb901c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
@@ -170,6 +170,13 @@ rtc@51 {
 				/* IRQ_RTC_B -> IRQ0_B(CPLD) -> IRQ00(CPU), active low */
 				interrupts-extended = <&extirq 0 IRQ_TYPE_LEVEL_LOW>;
 			};
+
+			rtc@53 {
+				compatible = "nxp,pcf2131";
+				reg = <0x53>;
+				/* IRQ_RTC_B -> IRQ0_B(CPLD) -> IRQ00(CPU), active low */
+				interrupts-extended = <&extirq 0 IRQ_TYPE_LEVEL_LOW>;
+			};
 		};
 	};
 };
-- 
2.37.1


