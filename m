Return-Path: <linux-kernel+bounces-415529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C12CA9D3797
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 10:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F041F21C3A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0072C19F46D;
	Wed, 20 Nov 2024 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eGxiexdS"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2087.outbound.protection.outlook.com [40.107.103.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0B819C543;
	Wed, 20 Nov 2024 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732096391; cv=fail; b=ZBMwMmMl+g23kJIbGaYdqqgEDkWS3Fv4YXSdLo/f80EdQ+V62jqxX+K2SuKNYKHzxp9PrMuafXx2gLb4X+ti/NAsRN5c/BKhW4mHid/XGggHGRYxZcWsMYHleCJRvP7x7X85zW9rX0wJTAcd02JxTs3uehxeKVEYKq8YNDOyvio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732096391; c=relaxed/simple;
	bh=k3QQmfWNrq65K84vDQevxiaqBoTaFbjYmK+TLWHo8IQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=om30VzCYuzRYgPgc290MsilyHCTtR4+IyRBo06yf8zWG4t8sVajSYrlYK2F+hct1vlFwafWihvVmpZ34C71hDuwwtpTxxbiD+6+r/FzLQ7Wiz+/RkQonwlFX2qqZN2KaBd+pskfxJfRUeKkCUWLMrPW96eUGrz4ytvQnEARGGdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eGxiexdS; arc=fail smtp.client-ip=40.107.103.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rcKNG5JkvnVXT5geqBk2r8gTOwtz35kAQ46mJ379ceftS0su5XuhFCJOJLktJYmVgWJQEbyIk1Or9FJWfriQTqbDDqZO8GhFVtrRRs791pcO/W07bAdF7gmIySoJNhzyvAhIoxDSGF5e+OwxboSqhgsCVw5dGg+jqrV9aga7/y9xzOLkCj8fpZ2q15aHxE55JFCNBOnIvU/mfeRDsaoMkncrx/hfwapECJ1R6ORxQzopnqlzYhfY5XRIHeb2/hcVDC45U9znmBBGf11pKIwL1lFCAbrs6bIefAZNC66+fTlqUa9pCQUhfmUjhVByhORyQWp6DtsamkeMpz1OHLFZvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zV+ahhjGrBMpkZ4Feet1kgXsyozie72DQi4vjCrE0U=;
 b=CTlohmSvkElLMl6MzESvT7xQQSW5DAyyFb5u/lbosa2Ikq0h3fZoh1IpF0i9T4VRAIZaKv65Px13AfgiPDc0fYGAemhoF4/0RXJisF34O/pKsOjYB7GKhqp7kkONZbW1x1Vfeaheb2MWgo3KHoPgkdylRzEFt4FdIjaVzyl1wMjD2RowP1KrySDduX3G1EJ/P/IhpJOzDmHFTfVS8dkEs+g5R2lwesc1iiSSPdsfPJXJvWwweubbGxZzyAegCOgKyWj2x3IiXPSkW0jf8576L1RogXxbU/ILaDrLrcq8ZRa84ET8LxMsKPuUfr9yPTgt17If5jKlGIpGb24PSHf5SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zV+ahhjGrBMpkZ4Feet1kgXsyozie72DQi4vjCrE0U=;
 b=eGxiexdSAuw0THaWDBTt7Se2023aAHRgbI2cZzpga2sw7GbPcHuLYj+6hP6YMtJskdGfXvXwm3UQLB6VMKqABQVTKW8TEAqRxgtbyO49fsQocfZ8vjt46eBP9XSh/EEvwTpCZ0Ky3wtfoiuCwXqP3LYiII3OvO+VZ0Qslu4Od4YanBhBdRSWQScbEjxCTfzn9xP/9L3SqsN5mjDjVuehzwQXrlAJXZvv/GCWG5O4wOGViSU5zUWZX5WkoUmMgC6UOqZcJ62grKsC9cS0hb/EbZxy0di6EDK9qEZeawXpvK243fXLcq+I297nVy6Hzn4Kg30bztuYtYfRIXPdVEtvvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by GV1PR04MB10128.eurprd04.prod.outlook.com (2603:10a6:150:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 09:53:05 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 09:53:05 +0000
From: Pengfei Li <pengfei.li_1@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: joao.goncalves@toradex.com,
	marex@denx.de,
	hvilleneuve@dimonoff.com,
	hiago.franco@toradex.com,
	peng.fan@nxp.com,
	frieder.schrempf@kontron.de,
	alexander.stein@ew.tq-group.com,
	m.othacehe@gmail.com,
	mwalle@kernel.org,
	Max.Merchel@ew.tq-group.com,
	quic_bjorande@quicinc.com,
	geert+renesas@glider.be,
	dmitry.baryshkov@linaro.org,
	neil.armstrong@linaro.org,
	arnd@arndb.de,
	nfraprado@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	ping.bai@nxp.com,
	ye.li@nxp.com,
	aisheng.dong@nxp.com,
	frank.li@nxp.com,
	carlos.song@nxp.com
Subject: [PATCH v3 3/4] arm64: dts: freescale: Add i.MX91 11x11 EVK basic support
Date: Wed, 20 Nov 2024 17:49:44 +0800
Message-Id: <20241120094945.3032663-4-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120094945.3032663-1-pengfei.li_1@nxp.com>
References: <20241120094945.3032663-1-pengfei.li_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|GV1PR04MB10128:EE_
X-MS-Office365-Filtering-Correlation-Id: de850a60-e568-42a3-08d5-08dd094920ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pzIRuJL7YD1WcKmossJwyPWl7UMYlvVtwajuOvP9IWr6DijfSweuS4O8UdhO?=
 =?us-ascii?Q?cwhyZBPh66sl7CUXX2ma9NYumVzWoCqmQZVzf1H63F801oaNRhbZ8n4dvmAY?=
 =?us-ascii?Q?ewmgA1iaMldqqb0z/F1fo7Wlf9x7b/JugoQry1rodUGaw2/AVTv/B4KksyAy?=
 =?us-ascii?Q?f62pqnZkIU0T6hkPPAvOO/+uDLg+PxGtrbPFwDD1w9btcSFgyLC6NKp+8BvW?=
 =?us-ascii?Q?QKvG/PJS7MhEQ9DZEG2mdv45c/G/awnCu8bdcaf6L/lSR0v+/+Llpxqeb6WY?=
 =?us-ascii?Q?t4pWuNQztg2N9f3hgdsIf0OgzPfZEQjrPcwPr3OLwikddNskoz1YlyiCGuOW?=
 =?us-ascii?Q?/hvvLeMGZoygTWuXYe3XdK9uMq2V99RsTpaQDn8zE2v3yIC/u0ScM+rNn7CS?=
 =?us-ascii?Q?MPWH/WEH+kzLpS56lWME2fX2huHc2j0uvZTj/QfXNwjQM/vGYgkcmrXl9S49?=
 =?us-ascii?Q?FkFCGu35RE9DPrngk+utx3PHIeVcEplMGkCLQdTB+NgIl7LP/VHcwxijRg9d?=
 =?us-ascii?Q?FuXfIUQ2fpuoRCn0HmssZdh/DJvTfBznZ/ihoMxfzwWYNeJf7ZnHjPTm0qNm?=
 =?us-ascii?Q?IGKd2tPf37VZlFjzQLfCIfbH4L9qIR2fXPOcaCwxFsMNdkC5e+2KCIJQl1Z5?=
 =?us-ascii?Q?XA1LPR+/AGgcTRMi4kAfT4CD1x4yPFBJpgCty86QZAW5BkBFiZA7xdR0PJQd?=
 =?us-ascii?Q?PZ8YJ7F4Fp5Hdjayqw9Ya0IJ+9kJ3AaYpX1HbCyTxzvFvJ+2apOVqs71q+Bc?=
 =?us-ascii?Q?+22ek161xqK9GdM8sA62+lekeStuHsETse9+m4JNthSG+UjaC1ccTlbhAmip?=
 =?us-ascii?Q?ygVGMLF0y+RG86OkWXLXCLlRpSJw0GCpdg3Ho6aXXHQn/e0UO1LRtsIGNWm5?=
 =?us-ascii?Q?A4IPOvjadXFPVrRa42ZhWexAd6WeHJA1aHjyORwjWyCwAggsWWnPUW6kcJ37?=
 =?us-ascii?Q?uaEgNBVXzOHnQEn8tPxg1n7F1kwhyDgW39rdv3aNeVTUb6y7yyMzgP5TYrym?=
 =?us-ascii?Q?oVTdjMguIKIOFT1nCG+8dANqmaBDxR+y4ufDi2wH2WnEhpr2NqUuCSv9l2nB?=
 =?us-ascii?Q?hsCSCHVnNjHHvI/ppFlfkZ3w+neu/ZWxgncDSo3VbmHu3tjzCIGzVKEl5ifK?=
 =?us-ascii?Q?aPAFIoqIsMoAY92xaz13MsTxJSJ9L8s4JFypWt/sX75Y6ODEnKhuSNWU+dwm?=
 =?us-ascii?Q?j7Ar72x6Ar9xiCO3MRsEA+ppoDATNaE+dwezGGXKfCJu3IL5B978hM6o/XJO?=
 =?us-ascii?Q?LMcN2/mabxY0yCak3lsD7Mu3dnhSgHgfLPZabxuyiKozSYE9EWtiWXl9QKn7?=
 =?us-ascii?Q?GT7iSsJglZXngjym49mWevwHHHqKEv9meiuiyTJVrCaiq6OtN3jimXFrn53z?=
 =?us-ascii?Q?g8qlrtA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f5zoKMb63bj/cXZQ5JTrwRA54ItJe2+f5CtJUbgw616l7mEmTIbOFOXTHGKd?=
 =?us-ascii?Q?+22NVSWBijbC1zWpXAmLNOLI2Fh6ZXZobo9JgT4iPMhxTIahkL7Eacc77xJn?=
 =?us-ascii?Q?xuxU2OsdeBimCuqsmtjpxVFu8otvlyl3DDcv2Ve84jnnsy2nRE5cNmBRizTK?=
 =?us-ascii?Q?GGUbf4lmQO4mMLQbdk7PlBw+r94RQR/JJV91vgcGauWHD9Hm63v+XcB/clmh?=
 =?us-ascii?Q?kFjrWZOWGqYGpfDCBIj5JRRgTwMTtP2ehk+nD7JJgTZ+EiqglRCd2kdRM/D1?=
 =?us-ascii?Q?qJNlB1DxmGjUwx/ErNn+WKqVKbaiNPJKsJTxwfpOKJUmZRbJMrxWZivbM9lZ?=
 =?us-ascii?Q?f9K5KIWHCYBgb85HUaF9mOvycmL0irR044upA6fcROMOzJ0i5sEejdgQJehu?=
 =?us-ascii?Q?Er+hR+Zk5V2EBTRr319EQW7xQOxvVNJsiLvXjAUtWj7ENXtsmetsxYHGR8K2?=
 =?us-ascii?Q?G3rEUMH9RwLQl4ENbOHvNf8AfxmyI6E5CAtGmouRz1T6udOUfA55n0+fIny7?=
 =?us-ascii?Q?VO8zZIhbQU5UsVoG7ZakP5Qkg0n1nWWqMsat3xKYmySYUqOz3kRqEMh7XMC5?=
 =?us-ascii?Q?1OB8+5zBgw+AKJs0sOUjTxc2pQTaaHBtbNEse1tlAJ3X8OF6xLvt+vf/I5oa?=
 =?us-ascii?Q?irW95ZR+QB5TXXKXwjgHpgPTiiyVfVmUljKNU9ekncIGLczXbPcPCYQfDDJ0?=
 =?us-ascii?Q?JaIQEzd+j7T/OTejRlJV6PUC+A9TtoK0abGKUYEc1LOm95doyP3SgY1w2KWG?=
 =?us-ascii?Q?MATMAAVi9xdqU+MisrS78XykjCeNbF0FYniNIyn9qfWsnnXdJbB1fmn4yadv?=
 =?us-ascii?Q?Osj2kGIPYybhguwOU+0TSKVzlTz/S7ZPx/TXFakPPxJCS4SSwaE1aEzV8Fp0?=
 =?us-ascii?Q?GNy55U8kfkfK2bymH6tfCwitDgCy+0b7EIEwWmqVMalHq5LB6Qjn/oeC402p?=
 =?us-ascii?Q?tpsmg/lC47S4jKAqgmLXMJW0rLP1Xg4PDfq5eHyQlmzGN/q3Pr9hl4xjC0xK?=
 =?us-ascii?Q?wVFrySTEib2ov+4zt30koh3nYwWtP8j5zbkbTKhYtsHojCCg+v8nQtsgMDQG?=
 =?us-ascii?Q?p/ranDnZ2tIL6nYIQgGjKYCJyUMpE9+X3gmmQcqkhprBA7ZmvWz7yiudKGgZ?=
 =?us-ascii?Q?vn0q3Sv659bPFxvU22UMUdCKD+wXAG/jDuOhGTnR0llV1qvPbuIqKsYYmYeK?=
 =?us-ascii?Q?VT3hTcTumTc0Rb08QdEkqid/siq4/C3i1b4zPQ9xfc9XEFOjNybvbxS0uyv9?=
 =?us-ascii?Q?iwOSftJE/ATmp63cuB3OQlYDaFwtWSP4EF7ySDSohMIKJiBjMt7lN3Z3qGi4?=
 =?us-ascii?Q?JUg/nNEuiiu4JPwwuFc8fl5VsMlFsUqcoN/RjfdkVUaDYN7V9ammKh7vXrNf?=
 =?us-ascii?Q?IyVOdXXCNpxkSh81Tn1fpt0q2GFFoyYtrd1ixrubzFUN/4zxzXcGy7LG0tvD?=
 =?us-ascii?Q?fq2KQ0rU+8/dcF04GM2cGEvebTjncFCuNWPufCcuY2G/LhPZ9G28IjgdDmtk?=
 =?us-ascii?Q?FL9gkOVrkVPTq9wBu4/eYFxfH4P+zs/Bhg3++iXk/aiVW8v5hftKwOryZ3Zn?=
 =?us-ascii?Q?iymBIDJoL15XfgM3ZhrEjwB3tfn1Hk1CgMDAdqOZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de850a60-e568-42a3-08d5-08dd094920ff
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 09:53:05.0712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KKM19BrrIC53cckzKol7/THfPHTl4Pk3AcArGy5VqPakZPxBWF7XIn+Ut2feD0uqG0CDJA4H7sDzAiZ/ppNTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10128

Add i.MX91 11x11 EVK board support.
- Enable ADC1.
- Enable lpuart1 and lpuart5.
- Enable network eqos and fec.
- Enable I2C bus and children nodes under I2C bus.
- Enable USB and related nodes.
- Enable uSDHC1 and uSDHC2.
- Enable Watchdog3.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx91-11x11-evk.dts    | 875 ++++++++++++++++++
 2 files changed, 876 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 42e6482a31cb..9174c9e215d5 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -256,6 +256,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-iris-v2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqp-mba8xx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx91-11x11-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb.dtb
 
 imx93-9x9-qsb-i3c-dtbs += imx93-9x9-qsb.dtb imx93-9x9-qsb-i3c.dtbo
diff --git a/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
new file mode 100644
index 000000000000..65571fc223b7
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
@@ -0,0 +1,875 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2024 NXP
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/usb/pd.h>
+#include "imx91.dtsi"
+
+/ {
+	compatible = "fsl,imx91-11x11-evk", "fsl,imx91";
+	model = "NXP i.MX91 11X11 EVK board";
+
+	aliases {
+		ethernet0 = &fec;
+		ethernet1 = &eqos;
+		rtc0 = &bbnsm_rtc;
+	};
+
+	chosen {
+		stdout-path = &lpuart1;
+	};
+
+	reg_vref_1v8: regulator-adc-vref {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "vref_1v8";
+	};
+
+	reg_audio_pwr: regulator-audio-pwr {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "audio-pwr";
+		gpio = <&adp5585 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		off-on-delay-us = <12000>;
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "VSD_3V3";
+		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_usdhc3_vmmc: regulator-usdhc3 {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "WLAN_EN";
+		gpio = <&pcal6524 20 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		/*
+		 * IW612 wifi chip needs more delay than other wifi chips to complete
+		 * the host interface initialization after power up, otherwise the
+		 * internal state of IW612 may be unstable, resulting in the failure of
+		 * the SDIO3.0 switch voltage.
+		 */
+		startup-delay-us = <20000>;
+	};
+
+	reg_vdd_12v: regulator-vdd-12v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <12000000>;
+		regulator-min-microvolt = <12000000>;
+		regulator-name = "reg_vdd_12v";
+		gpio = <&pcal6524 14 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_vrpi_3v3: regulator-vrpi-3v3 {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "VRPI_3V3";
+		vin-supply = <&buck4>;
+		gpio = <&pcal6524 2 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_vrpi_5v: regulator-vrpi-5v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "VRPI_5V";
+		gpio = <&pcal6524 8 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reserved-memory {
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			alloc-ranges = <0 0x80000000 0 0x40000000>;
+			reusable;
+			size = <0 0x10000000>;
+			linux,cma-default;
+		};
+	};
+};
+
+&adc1 {
+	vref-supply = <&reg_vref_1v8>;
+	status = "okay";
+};
+
+&eqos {
+	phy-handle = <&ethphy1>;
+	phy-mode = "rgmii-id";
+	pinctrl-0 = <&pinctrl_eqos>;
+	pinctrl-1 = <&pinctrl_eqos_sleep>;
+	pinctrl-names = "default", "sleep";
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-frequency = <5000000>;
+
+		ethphy1: ethernet-phy@1 {
+			reg = <1>;
+			eee-broken-1000t;
+		};
+	};
+};
+
+&fec {
+	phy-handle = <&ethphy2>;
+	phy-mode = "rgmii-id";
+	pinctrl-0 = <&pinctrl_fec>;
+	pinctrl-1 = <&pinctrl_fec_sleep>;
+	pinctrl-names = "default", "sleep";
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-frequency = <5000000>;
+
+		ethphy2: ethernet-phy@2 {
+			reg = <2>;
+			eee-broken-1000t;
+		};
+	};
+};
+
+/*
+ * When add, delete or change any target device setting in &lpi2c1,
+ * please synchronize the changes to the &i3c1 bus in imx91-11x11-evk-i3c.dts.
+ */
+&lpi2c1 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_lpi2c1>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	codec: wm8962@1a {
+		compatible = "wlf,wm8962";
+		reg = <0x1a>;
+		clocks = <&clk IMX93_CLK_SAI3_GATE>;
+		AVDD-supply = <&reg_audio_pwr>;
+		CPVDD-supply = <&reg_audio_pwr>;
+		DBVDD-supply = <&reg_audio_pwr>;
+		DCVDD-supply = <&reg_audio_pwr>;
+		MICVDD-supply = <&reg_audio_pwr>;
+		PLLVDD-supply = <&reg_audio_pwr>;
+		SPKVDD1-supply = <&reg_audio_pwr>;
+		SPKVDD2-supply = <&reg_audio_pwr>;
+		gpio-cfg = <
+			0x0000 /* 0:Default */
+			0x0000 /* 1:Default */
+			0x0000 /* 2:FN_DMICCLK */
+			0x0000 /* 3:Default */
+			0x0000 /* 4:FN_DMICCDAT */
+			0x0000 /* 5:Default */
+		>;
+	};
+
+	lsm6dsm@6a {
+		compatible = "st,lsm6dso";
+		reg = <0x6a>;
+	};
+};
+
+&lpi2c2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_lpi2c2>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	pcal6524: gpio@22 {
+		compatible = "nxp,pcal6524";
+		reg = <0x22>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupt-parent = <&gpio3>;
+		pinctrl-0 = <&pinctrl_pcal6524>;
+		pinctrl-names = "default";
+	};
+
+	pmic@25 {
+		compatible = "nxp,pca9451a";
+		reg = <0x25>;
+		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-parent = <&pcal6524>;
+
+		regulators {
+
+			buck1: BUCK1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <2237500>;
+				regulator-min-microvolt = <650000>;
+				regulator-name = "BUCK1";
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <2187500>;
+				regulator-min-microvolt = <600000>;
+				regulator-name = "BUCK2";
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck4: BUCK4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3400000>;
+				regulator-min-microvolt = <600000>;
+				regulator-name = "BUCK4";
+			};
+
+			buck5: BUCK5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3400000>;
+				regulator-min-microvolt = <600000>;
+				regulator-name = "BUCK5";
+			};
+
+			buck6: BUCK6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3400000>;
+				regulator-min-microvolt = <600000>;
+				regulator-name = "BUCK6";
+			};
+
+			ldo1: LDO1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <1600000>;
+				regulator-name = "LDO1";
+			};
+
+			ldo4: LDO4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <800000>;
+				regulator-name = "LDO4";
+			};
+
+			ldo5: LDO5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "LDO5";
+			};
+		};
+	};
+
+	adp5585: io-expander@34 {
+		compatible = "adi,adp5585-00", "adi,adp5585";
+		reg = <0x34>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		#pwm-cells = <3>;
+		gpio-reserved-ranges = <5 1>;
+
+		exp-sel-hog {
+			gpio-hog;
+			gpios = <4 GPIO_ACTIVE_HIGH>;
+			output-low;
+		};
+	};
+};
+
+&lpi2c3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	ptn5110: tcpc@50 {
+		compatible = "nxp,ptn5110", "tcpci";
+		reg = <0x50>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio3>;
+		status = "okay";
+
+		typec1_con: connector {
+			compatible = "usb-c-connector";
+			data-role = "dual";
+			label = "USB-C";
+			op-sink-microwatt = <15000000>;
+			power-role = "dual";
+			self-powered;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+				     PDO_VAR(5000, 20000, 3000)>;
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			try-power-role = "sink";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					typec1_dr_sw: endpoint {
+						remote-endpoint = <&usb1_drd_sw>;
+					};
+				};
+			};
+		};
+	};
+
+	ptn5110_2: tcpc@51 {
+		compatible = "nxp,ptn5110", "tcpci";
+		reg = <0x51>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio3>;
+		status = "okay";
+
+		typec2_con: connector {
+			compatible = "usb-c-connector";
+			data-role = "dual";
+			label = "USB-C";
+			op-sink-microwatt = <15000000>;
+			power-role = "dual";
+			self-powered;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+				     PDO_VAR(5000, 20000, 3000)>;
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			try-power-role = "sink";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					typec2_dr_sw: endpoint {
+						remote-endpoint = <&usb2_drd_sw>;
+					};
+				};
+			};
+		};
+	};
+
+	pcf2131: rtc@53 {
+		compatible = "nxp,pcf2131";
+		reg = <0x53>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-parent = <&pcal6524>;
+		status = "okay";
+	};
+};
+
+&lpuart1 {
+	pinctrl-0 = <&pinctrl_uart1>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&lpuart5 {
+	pinctrl-0 = <&pinctrl_uart5>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&usbotg1 {
+	adp-disable;
+	disable-over-current;
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	usb-role-switch;
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	samsung,picophy-pre-emp-curr-control = <3>;
+	status = "okay";
+
+	port {
+		usb1_drd_sw: endpoint {
+			remote-endpoint = <&typec1_dr_sw>;
+		};
+	};
+};
+
+&usbotg2 {
+	adp-disable;
+	disable-over-current;
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	usb-role-switch;
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	samsung,picophy-pre-emp-curr-control = <3>;
+	status = "okay";
+
+	port {
+		usb2_drd_sw: endpoint {
+			remote-endpoint = <&typec2_dr_sw>;
+		};
+	};
+};
+
+&usdhc1 {
+	bus-width = <8>;
+	non-removable;
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	status = "okay";
+};
+
+&usdhc2 {
+	bus-width = <4>;
+	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
+	no-mmc;
+	no-sdio;
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_gpio_sleep>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	status = "okay";
+};
+
+&wdog3 {
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_eqos: eqosgrp {
+		fsl,pins = <
+			MX91_PAD_ENET1_MDC__ENET1_MDC			0x57e
+			MX91_PAD_ENET1_MDIO__ENET_QOS_MDIO			0x57e
+			MX91_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0			0x57e
+			MX91_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1			0x57e
+			MX91_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2			0x57e
+			MX91_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3			0x57e
+			MX91_PAD_ENET1_RXC__ENET_QOS_RGMII_RXC	0x5fe
+			MX91_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL		0x57e
+			MX91_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0			0x57e
+			MX91_PAD_ENET1_TD1__ENET1_RGMII_TD1			0x57e
+			MX91_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2			0x57e
+			MX91_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3			0x57e
+			MX91_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x5fe
+			MX91_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x57e
+		>;
+	};
+
+	pinctrl_eqos_sleep: eqossleepgrp {
+		fsl,pins = <
+			MX91_PAD_ENET1_MDC__GPIO4_IO0				0x31e
+			MX91_PAD_ENET1_MDIO__GPIO4_IO1				0x31e
+			MX91_PAD_ENET1_RD0__GPIO4_IO10                          0x31e
+			MX91_PAD_ENET1_RD1__GPIO4_IO11				0x31e
+			MX91_PAD_ENET1_RD2__GPIO4_IO12				0x31e
+			MX91_PAD_ENET1_RD3__GPIO4_IO13				0x31e
+			MX91_PAD_ENET1_RXC__GPIO4_IO9                          0x31e
+			MX91_PAD_ENET1_RX_CTL__GPIO4_IO8			0x31e
+			MX91_PAD_ENET1_TD0__GPIO4_IO5                          0x31e
+			MX91_PAD_ENET1_TD1__GPIO4_IO4                          0x31e
+			MX91_PAD_ENET1_TD2__GPIO4_IO3				0x31e
+			MX91_PAD_ENET1_TD3__GPIO4_IO3				0x31e
+			MX91_PAD_ENET1_TXC__GPIO4_IO7                          0x31e
+			MX91_PAD_ENET1_TX_CTL__GPIO4_IO6                       0x31e
+		>;
+	};
+
+	pinctrl_fec: fecgrp {
+		fsl,pins = <
+			MX91_PAD_ENET2_MDC__ENET2_MDC			0x57e
+			MX91_PAD_ENET2_MDIO__ENET2_MDIO			0x57e
+			MX91_PAD_ENET2_RD0__ENET2_RGMII_RD0		0x57e
+			MX91_PAD_ENET2_RD1__ENET2_RGMII_RD1		0x57e
+			MX91_PAD_ENET2_RD2__ENET2_RGMII_RD2		0x57e
+			MX91_PAD_ENET2_RD3__ENET2_RGMII_RD3		0x57e
+			MX91_PAD_ENET2_RXC__ENET2_RGMII_RXC		0x5fe
+			MX91_PAD_ENET2_RX_CTL__ENET2_RGMII_RX_CTL	0x57e
+			MX91_PAD_ENET2_TD0__ENET2_RGMII_TD0		0x57e
+			MX91_PAD_ENET2_TD1__ENET2_RGMII_TD1		0x57e
+			MX91_PAD_ENET2_TD2__ENET2_RGMII_TD2		0x57e
+			MX91_PAD_ENET2_TD3__ENET2_RGMII_TD3		0x57e
+			MX91_PAD_ENET2_TXC__ENET2_RGMII_TXC		0x5fe
+			MX91_PAD_ENET2_TX_CTL__ENET2_RGMII_TX_CTL	0x57e
+		>;
+	};
+
+	pinctrl_fec_sleep: fecsleepgrp {
+		fsl,pins = <
+			MX91_PAD_ENET2_MDC__GPIO4_IO14			0x51e
+			MX91_PAD_ENET2_MDIO__GPIO4_IO15			0x51e
+			MX91_PAD_ENET2_RD0__GPIO4_IO24			0x51e
+			MX91_PAD_ENET2_RD1__GPIO4_IO25			0x51e
+			MX91_PAD_ENET2_RD2__GPIO4_IO26			0x51e
+			MX91_PAD_ENET2_RD3__GPIO4_IO27			0x51e
+			MX91_PAD_ENET2_RXC__GPIO4_IO23			0x51e
+			MX91_PAD_ENET2_RX_CTL__GPIO4_IO22		0x51e
+			MX91_PAD_ENET2_TD0__GPIO4_IO19			0x51e
+			MX91_PAD_ENET2_TD1__GPIO4_IO18			0x51e
+			MX91_PAD_ENET2_TD2__GPIO4_IO17			0x51e
+			MX91_PAD_ENET2_TD3__GPIO4_IO16			0x51e
+			MX91_PAD_ENET2_TXC__GPIO4_IO21			0x51e
+			MX91_PAD_ENET2_TX_CTL__GPIO4_IO20		0x51e
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO25__CAN2_TX	0x139e
+			MX91_PAD_GPIO_IO27__CAN2_RX	0x139e
+		>;
+	};
+
+	pinctrl_flexcan2_sleep: flexcan2sleepgrp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO25__GPIO2_IO25  0x31e
+			MX91_PAD_GPIO_IO27__GPIO2_IO27	0x31e
+		>;
+	};
+
+	pinctrl_lcdif_gpio: lcdifgpiogrp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO00__GPIO2_IO0			0x51e
+			MX91_PAD_GPIO_IO01__GPIO2_IO1			0x51e
+			MX91_PAD_GPIO_IO02__GPIO2_IO2			0x51e
+			MX91_PAD_GPIO_IO03__GPIO2_IO3			0x51e
+		>;
+	};
+
+	pinctrl_lcdif: lcdifgrp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO00__MEDIAMIX_DISP_CLK		0x31e
+			MX91_PAD_GPIO_IO01__MEDIAMIX_DISP_DE		0x31e
+			MX91_PAD_GPIO_IO02__MEDIAMIX_DISP_VSYNC		0x31e
+			MX91_PAD_GPIO_IO03__MEDIAMIX_DISP_HSYNC		0x31e
+			MX91_PAD_GPIO_IO04__MEDIAMIX_DISP_DATA0		0x31e
+			MX91_PAD_GPIO_IO05__MEDIAMIX_DISP_DATA1		0x31e
+			MX91_PAD_GPIO_IO06__MEDIAMIX_DISP_DATA2		0x31e
+			MX91_PAD_GPIO_IO07__MEDIAMIX_DISP_DATA3		0x31e
+			MX91_PAD_GPIO_IO08__MEDIAMIX_DISP_DATA4		0x31e
+			MX91_PAD_GPIO_IO09__MEDIAMIX_DISP_DATA5		0x31e
+			MX91_PAD_GPIO_IO10__MEDIAMIX_DISP_DATA6		0x31e
+			MX91_PAD_GPIO_IO11__MEDIAMIX_DISP_DATA7		0x31e
+			MX91_PAD_GPIO_IO12__MEDIAMIX_DISP_DATA8		0x31e
+			MX91_PAD_GPIO_IO13__MEDIAMIX_DISP_DATA9		0x31e
+			MX91_PAD_GPIO_IO14__MEDIAMIX_DISP_DATA10	0x31e
+			MX91_PAD_GPIO_IO15__MEDIAMIX_DISP_DATA11	0x31e
+			MX91_PAD_GPIO_IO16__MEDIAMIX_DISP_DATA12	0x31e
+			MX91_PAD_GPIO_IO17__MEDIAMIX_DISP_DATA13	0x31e
+			MX91_PAD_GPIO_IO18__MEDIAMIX_DISP_DATA14	0x31e
+			MX91_PAD_GPIO_IO19__MEDIAMIX_DISP_DATA15	0x31e
+			MX91_PAD_GPIO_IO20__MEDIAMIX_DISP_DATA16	0x31e
+			MX91_PAD_GPIO_IO21__MEDIAMIX_DISP_DATA17	0x31e
+			MX91_PAD_GPIO_IO27__GPIO2_IO27			0x31e
+		>;
+	};
+
+	pinctrl_lpi2c1: lpi2c1grp {
+		fsl,pins = <
+			MX91_PAD_I2C1_SCL__LPI2C1_SCL			0x40000b9e
+			MX91_PAD_I2C1_SDA__LPI2C1_SDA			0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c2: lpi2c2grp {
+		fsl,pins = <
+			MX91_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e
+			MX91_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c3: lpi2c3grp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO28__LPI2C3_SDA			0x40000b9e
+			MX91_PAD_GPIO_IO29__LPI2C3_SCL			0x40000b9e
+		>;
+	};
+
+	pinctrl_pcal6524: pcal6524grp {
+		fsl,pins = <
+			MX91_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
+		>;
+	};
+
+	pinctrl_pdm: pdmgrp {
+		fsl,pins = <
+			MX91_PAD_PDM_CLK__PDM_CLK			0x31e
+			MX91_PAD_PDM_BIT_STREAM0__PDM_BIT_STREAM0	0x31e
+			MX91_PAD_PDM_BIT_STREAM1__PDM_BIT_STREAM1	0x31e
+		>;
+	};
+
+	pinctrl_pdm_sleep: pdmsleepgrp {
+		fsl,pins = <
+			MX91_PAD_PDM_CLK__GPIO1_IO8			0x31e
+			MX91_PAD_PDM_BIT_STREAM0__GPIO1_IO9		0x31e
+			MX91_PAD_PDM_BIT_STREAM1__GPIO1_IO10		0x31e
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_RESET_B__GPIO3_IO7	0x31e
+		>;
+	};
+
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			MX91_PAD_SAI1_TXC__SAI1_TX_BCLK			0x31e
+			MX91_PAD_SAI1_TXFS__SAI1_TX_SYNC		0x31e
+			MX91_PAD_SAI1_TXD0__SAI1_TX_DATA0		0x31e
+			MX91_PAD_SAI1_RXD0__SAI1_RX_DATA0		0x31e
+		>;
+	};
+
+	pinctrl_sai1_sleep: sai1sleepgrp {
+		fsl,pins = <
+			MX91_PAD_SAI1_TXC__GPIO1_IO12                   0x51e
+			MX91_PAD_SAI1_TXFS__GPIO1_IO11			0x51e
+			MX91_PAD_SAI1_TXD0__GPIO1_IO13			0x51e
+			MX91_PAD_SAI1_RXD0__GPIO1_IO14			0x51e
+		>;
+	};
+
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO26__SAI3_TX_SYNC		0x31e
+			MX91_PAD_GPIO_IO16__SAI3_TX_BCLK		0x31e
+			MX91_PAD_GPIO_IO17__SAI3_MCLK			0x31e
+			MX91_PAD_GPIO_IO19__SAI3_TX_DATA0		0x31e
+			MX91_PAD_GPIO_IO20__SAI3_RX_DATA0		0x31e
+		>;
+	};
+
+	pinctrl_sai3_sleep: sai3sleepgrp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO26__GPIO2_IO26			0x51e
+			MX91_PAD_GPIO_IO16__GPIO2_IO16			0x51e
+			MX91_PAD_GPIO_IO17__GPIO2_IO17			0x51e
+			MX91_PAD_GPIO_IO19__GPIO2_IO19			0x51e
+			MX91_PAD_GPIO_IO20__GPIO2_IO20			0x51e
+		>;
+	};
+
+	pinctrl_spdif: spdifgrp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO22__SPDIF_IN		0x31e
+			MX91_PAD_GPIO_IO23__SPDIF_OUT		0x31e
+		>;
+	};
+
+	pinctrl_spdif_sleep: spdifsleepgrp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO22__GPIO2_IO22		0x31e
+			MX91_PAD_GPIO_IO23__GPIO2_IO23		0x31e
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX91_PAD_UART1_RXD__LPUART1_RX			0x31e
+			MX91_PAD_UART1_TXD__LPUART1_TX			0x31e
+		>;
+	};
+
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			MX91_PAD_DAP_TDO_TRACESWO__LPUART5_TX	0x31e
+			MX91_PAD_DAP_TDI__LPUART5_RX		0x31e
+			MX91_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B	0x31e
+			MX91_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B	0x31e
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD1_CLK__USDHC1_CLK		0x158e
+			MX91_PAD_SD1_CMD__USDHC1_CMD		0x138e
+			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x138e
+			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x138e
+			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x138e
+			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x138e
+			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x138e
+			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x138e
+			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x138e
+			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x138e
+			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x158e
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD1_CLK__USDHC1_CLK		0x15fe
+			MX91_PAD_SD1_CMD__USDHC1_CMD		0x13fe
+			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x13fe
+			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x13fe
+			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x13fe
+			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x13fe
+			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x13fe
+			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x13fe
+			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x13fe
+			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x13fe
+			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX91_PAD_SD1_CLK__USDHC1_CLK		0x1582
+			MX91_PAD_SD1_CMD__USDHC1_CMD		0x1382
+			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x1382
+			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x1382
+			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x1382
+			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x1382
+			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x1382
+			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x1382
+			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x1382
+			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x1382
+			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x1582
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CLK__USDHC2_CLK		0x158e
+			MX91_PAD_SD2_CMD__USDHC2_CMD		0x138e
+			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x138e
+			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x138e
+			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x138e
+			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x138e
+			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CLK__USDHC2_CLK		0x15fe
+			MX91_PAD_SD2_CMD__USDHC2_CMD		0x13fe
+			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x13fe
+			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x13fe
+			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x13fe
+			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x13fe
+			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CD_B__GPIO3_IO0		0x31e
+		>;
+	};
+
+	pinctrl_usdhc2_gpio_sleep: usdhc2gpiosleepgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CD_B__GPIO3_IO0		0x51e
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX91_PAD_SD2_CLK__USDHC2_CLK		0x1582
+			MX91_PAD_SD2_CMD__USDHC2_CMD		0x1382
+			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x1382
+			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x1382
+			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x1382
+			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x1382
+			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_sleep: usdhc2sleepgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CLK__GPIO3_IO1            0x51e
+			MX91_PAD_SD2_CMD__GPIO3_IO2		0x51e
+			MX91_PAD_SD2_DATA0__GPIO3_IO3		0x51e
+			MX91_PAD_SD2_DATA1__GPIO3_IO4		0x51e
+			MX91_PAD_SD2_DATA2__GPIO3_IO5		0x51e
+			MX91_PAD_SD2_DATA3__GPIO3_IO6		0x51e
+			MX91_PAD_SD2_VSELECT__GPIO3_IO19	0x51e
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD3_CLK__USDHC3_CLK		0x158e
+			MX91_PAD_SD3_CMD__USDHC3_CMD		0x138e
+			MX91_PAD_SD3_DATA0__USDHC3_DATA0	0x138e
+			MX91_PAD_SD3_DATA1__USDHC3_DATA1	0x138e
+			MX91_PAD_SD3_DATA2__USDHC3_DATA2	0x138e
+			MX91_PAD_SD3_DATA3__USDHC3_DATA3	0x138e
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD3_CLK__USDHC3_CLK		0x15fe
+			MX91_PAD_SD3_CMD__USDHC3_CMD		0x13fe
+			MX91_PAD_SD3_DATA0__USDHC3_DATA0	0x13fe
+			MX91_PAD_SD3_DATA1__USDHC3_DATA1	0x13fe
+			MX91_PAD_SD3_DATA2__USDHC3_DATA2	0x13fe
+			MX91_PAD_SD3_DATA3__USDHC3_DATA3	0x13fe
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX91_PAD_SD3_CLK__USDHC3_CLK		0x1582
+			MX91_PAD_SD3_CMD__USDHC3_CMD		0x1382
+			MX91_PAD_SD3_DATA0__USDHC3_DATA0	0x1382
+			MX91_PAD_SD3_DATA1__USDHC3_DATA1	0x1382
+			MX91_PAD_SD3_DATA2__USDHC3_DATA2	0x1382
+			MX91_PAD_SD3_DATA3__USDHC3_DATA3	0x1382
+		>;
+	};
+
+	pinctrl_usdhc3_sleep: usdhc3sleepgrp {
+		fsl,pins = <
+			MX91_PAD_SD3_CLK__GPIO3_IO20		0x31e
+			MX91_PAD_SD3_CMD__GPIO3_IO21		0x31e
+			MX91_PAD_SD3_DATA0__GPIO3_IO22		0x31e
+			MX91_PAD_SD3_DATA1__GPIO3_IO23		0x31e
+			MX91_PAD_SD3_DATA2__GPIO3_IO24		0x31e
+			MX91_PAD_SD3_DATA3__GPIO3_IO25		0x31e
+		>;
+	};
+
+	pinctrl_usdhc3_wlan: usdhc3wlangrp {
+		fsl,pins = <
+			MX91_PAD_CCM_CLKO1__GPIO3_IO26		0x31e
+		>;
+	};
+};
-- 
2.34.1


