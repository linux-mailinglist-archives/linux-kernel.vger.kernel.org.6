Return-Path: <linux-kernel+bounces-265166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8500193ED80
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104201F22948
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1967484037;
	Mon, 29 Jul 2024 06:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xgiiQdH9"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2077.outbound.protection.outlook.com [40.107.247.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D598B33CD2;
	Mon, 29 Jul 2024 06:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722234773; cv=fail; b=QJYVnIyWg/1X8I5gB8cLo5dBfMLHEPtW0PU+GbQt+Fncp0HeuX5jr24lfwpwJKqbZO0kViOYP/I90azEZY4BZyQyh459fgp3VMxmb7KVjvtu87WJ6IEv3CdGANszuy/sYQk0oBoFxH3ftOPX94a87O9P4hTv21OQS91oLKC/d9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722234773; c=relaxed/simple;
	bh=ZNHKS5U1IeGs2Ci2F+1SMj1J5tUyE4cGetwvW/caBbE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dykrSJsLZkctQvngZqCpuFiY3Rn+mfhjOTxBbaqaSk+ZWDXhiKqH5YFu4eUxBt9KfG454A+EgSuo+JeqMQYrWeXOFOZQs50NzTrqsQUWKYoiavwPnnnjbGcN/V3GQgwzMYbI4jf2TWSK5QvmxmukeWk9RszM1Wb0SFO1rZLhO/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=xgiiQdH9; arc=fail smtp.client-ip=40.107.247.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJLJHOce1XU1V+HZQqSpMOlSXYtcSNyP0OkSoxk3K3w6oEptvphouyPmnJDkVhpZqXIcM87qzmgEyEfOyWQ7MjojJtbQddQF6cazN3ufqvv5rCdiW3zYTO90YaOQGi3x9h5I0ZV2DjGcHaYDDotKEM8EG5HzytQB7qtGfaLhrScVhKjyO0adh0JbhPLVEn3HH9mNrduEZVs4cPHq0JAIUmoGT6lScskPflnTjhOUQX1roiom27xnru502Xs0JBQdCKgalEuBdETcqeIjaN1DsaZyqGPy6DhwtuDurLuR4BRV2rfVMqKF6lGn1JMPo9NuX4bYDOx4rZzEQymo5RM7+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejmOzYj/SEwvjYJVdpdamQfUaNgeAhKyq6iBJKysKW8=;
 b=bMKanxYN94Jj/YugAseKmIMZwTLcP22ha22krYEn6AxcvwBMPeZ5r3kqplUqiKf+Q7fLItUFEaq/OD4831sASIGow/p0ay2z90Jp3YwnXgDyhgXad211rubf9Yeo2YBwjK4fVaNqBr+dKxZAMNoU66cKBEgolXRZuNtjsFCay25jtQYNES3T5JPj/TUC4t7+JwBF+FxLMXzSyLWyxtqxOImgwa/Fq7ELBgXUFIPmlroInxw2Gj8hcNXa7AX1CdXBqqyZPaqVispd/DqLOQhv95UMrGFDqh4E7FADtqPEXjLb0ulkEOBwvrB9RkBf8ZFjFsi5kPPoLYpYHit7BeDg+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejmOzYj/SEwvjYJVdpdamQfUaNgeAhKyq6iBJKysKW8=;
 b=xgiiQdH9OYFOoR8qtRQOINZcqft3n0NF3uto+j0C8Dl0y2JgU2SK39h3pXh8b+jWeKz0lkwzBJg7gY2wX1cmtpk3YeEMO3hsoIE0/TFcMI7OjKxkiVEkVoJwFN1LoRTr5IarxNrGPizs2D0F6DL2tur/wnneA1q+4rjHHbXX4/bHHsSwXq80ioFq1JU2c1S6s+fzhy39nsXbmQWovK/kZSe/0i5Cl8+QXF8AVhcE6ef5ImfCictUUsULZXGdDmOVgh6aP4rjywvaCp+lZRQbuOETf9JTpNk7DPWOli1FBPvWVv1mBZzoPLmezqJB3dY6SLL2bvKA3G68/AVWTfLhaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7863.eurprd04.prod.outlook.com (2603:10a6:20b:2a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 06:32:47 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Mon, 29 Jul 2024
 06:32:45 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: dts: imx95: correct a55 power-domains
Date: Mon, 29 Jul 2024 14:41:11 +0800
Message-Id: <20240729064111.2060746-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: a00fd8e5-ad88-4092-d381-08dcaf9840b2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xqoaVD+9C/zI/HdTIS/R28CCNkTLyni1gZ4TN+Tukwmw5DsXhsecvttu+rZm?=
 =?us-ascii?Q?zcpnxcSNdhDvdPhjq7TdxmiMnmvcCko37KgfbkOBBQN2NT0i2cC6vJ4hIWMr?=
 =?us-ascii?Q?PeZTMZi11elWhEYO5VbSk82xcWEik1ph3paMxWbPipEWYwM1QEIEmwc9qEUw?=
 =?us-ascii?Q?FE6LiBe9KHAc+ayZsD9olwvoOBtbuLzjH+Wp8t1Xly1Fj8WiCSH8XDqFFi8o?=
 =?us-ascii?Q?Tm08wTTBl2GhdsLyH8mKyDyVATwn/iS7jHq6EtKFZbQeMbx1eIpsPv7qIM8X?=
 =?us-ascii?Q?s8tn9yPdPlJ/KnKdhO7aR1Jr9N98nVbGZlkCvQLA5TkxFFne1mZK9Aq7GsUk?=
 =?us-ascii?Q?9CYwMIy9XcVE7qOpwCh89/KTWRzcr3eNwNRhdcnpws86UagESkFqCJBdTCgq?=
 =?us-ascii?Q?JYOqenV6znXm7NZ14Z5zGQNDrGfhDY0VJ477rVcL+dVDC8IPFruVbzAoZgN4?=
 =?us-ascii?Q?bqbGrNaoFhcHRQsYFTWNzag9EV8bmqu5SUWju7Uw3Iue3ugpO2Pj/zhp+wMe?=
 =?us-ascii?Q?kuMNCxHDoe10FxTcYtmFIDXulOhwmlcR5e3/smgj96POTqv0rXKwY8Z92P6j?=
 =?us-ascii?Q?V2JGIREkadFasXoYZITjEKG+qqrDzovTcU3TSGIvRRp7ezBtFMC9qrMD1cpd?=
 =?us-ascii?Q?yAJhU++5vUUveag7483cVTGjqhGASMH88OWyCSkFoWHN6cb7AX8zIAVaYd/V?=
 =?us-ascii?Q?+0GTuRwmFOpS/LftoKPuqDNWFMcYDtRCDKoHubrbcsvBqRd4xIzUqcdAjupR?=
 =?us-ascii?Q?27hCj7TkTxaSq1Gl+srdHZJHE7qAyTFR17T7ndWYt54ECIpG84fzG3bDtkX7?=
 =?us-ascii?Q?TMKj1xwX6vcgKZ7WUc45WtZRPGgVZIt0GS8kg0sqpRrv2FhNl+M9CPsgxsL2?=
 =?us-ascii?Q?OfTDI77of5US7a8dLfeqIlCFRiwPjosicDbH7AyQqn1h+iAy7m/p6HxIVCKp?=
 =?us-ascii?Q?rfGEBc2VsPmAg1JVQS6sIsjOaavssyKOk5v0dOxCLCEqaS6Y8hrT0CgTd5OT?=
 =?us-ascii?Q?cj+FzdY9zakMWLYrxHOCjmJUVE1m26cSwmlJ93DrO8oq4nw0/UfhGfvmHRwb?=
 =?us-ascii?Q?Gz5kMkLBpOd1mlD4REzOoBSKVawjvU6qk44yDO9x5j9SRGcFepaFaHd4fo5Q?=
 =?us-ascii?Q?nmgdEkhU6yYcObGqakT+bt5CLnRqz+UD2ITZDee7RT6c/jJjpubWlr0Cgu4p?=
 =?us-ascii?Q?FS2WVX9qqtZHNnalPWjUCkUgYZ3cz2SF80jqdCp18kMzDX3wvBd/ztNZbWgN?=
 =?us-ascii?Q?leZGVe/DT6dAdwQOyDoZBtW4DN+MWyV31dnTB8TqhL9MFlICeoYvWKPw/Q31?=
 =?us-ascii?Q?OiNnPGWoQNlK49KpJuQzus9QZ8QM1s98PIwISTVpWHuBS1ueQaCDWlN4jM8F?=
 =?us-ascii?Q?rxLe2ncDZH5jsw28EpqBvt0CfWV0SOS5Xun+V7HCEsnSd84Nxg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NrIZqTTvzIJukf4MXVfhJ4bukTBuuJuBsG/adVq/eQlvossLmWcSUw3ndMdz?=
 =?us-ascii?Q?2pN4DnNJntI+kqoU1pyeKtmH9q7J9M1qLv2DfOuEmaSKF/ky1wdLukfXiGs8?=
 =?us-ascii?Q?a+uqY9vntmvROXkMnl76epU9vlAE07IwbLGPS0zkDk9xKr+UM72/9AyrIVa8?=
 =?us-ascii?Q?4dXkwSl+PfgQnKvfcZRWoUqH2WQqCIsk0JZBJFiVZkUBBLGIBc2UgHjd7HAj?=
 =?us-ascii?Q?Wy7QyrQj73ArltL8TlEBmi21fFLt/lfLIo5cpbV7R858gKSOGQzRHU6w+s+u?=
 =?us-ascii?Q?gEFooDQj+T5xz1hZIG+try3aBU7Myf9g3PPUhfX0/7u/NfUdRfztwzJwm+9a?=
 =?us-ascii?Q?/mTlen8cS2b4b4S2p3iwr9wHv+1j4N1/4hU9IyaYBp3NGoHmUd7NbKrri8oa?=
 =?us-ascii?Q?tcIxnlzMeS7WdfwT3wrIQ+U0TF/BGbAGBODbBw+SYcEzdJwMqK5S3rS7ewFM?=
 =?us-ascii?Q?KGmYOOu1H7xxiRCqUq7bbseWI16TfGIZY5NCRWHB4IUJQQgOC8krbo8YVaNV?=
 =?us-ascii?Q?pB4LBmwhuYm9M++dDoZEPw4BhPgAhmwtZ36pbVT+uTTyA13C3pBUdbsKOXzF?=
 =?us-ascii?Q?vhZfy0Y+VEPvvU8ES8zXuv5W+s0NTCRqBPgmois7CaN21zTKIWmOifYguRAB?=
 =?us-ascii?Q?vuWKfeXPR74nBA9FEumEQ5fI9h2Bi6laQjJIyYaaIyM16p+ZYfTePCZ9VZ4j?=
 =?us-ascii?Q?52gmBrxQX/XuPlGTBunor0niv423bQrQcebnBSmpyWghq49LTZ2OBEMOLpeA?=
 =?us-ascii?Q?pkcTL2I6nqE2xsKrl3AJ7uKhx/muLP2IfJoYeg74i8e4r6h/ZfHiNGYJJZwO?=
 =?us-ascii?Q?uiooyZ4hAOgc6O2DWX56FehHwbqC7KvyFu2BABFctZud+aiDMBOGjd/CibP5?=
 =?us-ascii?Q?szUHbQW8J0K0cNoz/jINiqPhRbp1ZlnLN2L111eq3RmIiFlgkXhr6MzVsWxI?=
 =?us-ascii?Q?6RnjutWpthLrP3zNak/7oEdKxklH2LQVJIsKdFFDZef2vf/sK1tmh3a6PT+d?=
 =?us-ascii?Q?1ksqHMETgrQKqO4a/BzPLj1v7DOoWt2VJHZiMLSOeCs2kZWb2jLlGynTDpTq?=
 =?us-ascii?Q?PP+2k/9l26vRakVBAXeMuNlcwnSBNMD0yMRMdDRMZkt+wee1bB4bXaFiWF3j?=
 =?us-ascii?Q?posRQvOe92oHAROImeIIcXti4vTI8v+frUCvgbRFP/BcAod1AtaDaBOaGDdE?=
 =?us-ascii?Q?Dy0qlIpvGLZS1KhL5cpIDggH25aKM3fXdRsywIJv0o5ISckYpGO6AuMBg7OW?=
 =?us-ascii?Q?afBmOjcEdK8nI/gkXGI0CGbfC4WopR27UTRQ4DZS0bBJj2bSqa26HAILhvza?=
 =?us-ascii?Q?P1IBb+nbsk3WlaqsSTrH0GZu0Pv2DAScy+3JYq44Uf1l86cXKcmxTa53TW8X?=
 =?us-ascii?Q?EHbq4y6VJX6oZdeH54w+Unx0Y2GfQ+3+V1TEpwjbdXqwMtrehqjv/EdlfFY9?=
 =?us-ascii?Q?nGeTAJoCWH/xLR3DYaxWj7ZJ+jgloUWDozxavAOGaisf0vP1AgNrKloWFqC8?=
 =?us-ascii?Q?cAO35pTwcsrm+VuRFkeaDURjorVk6xwmC1dotiEv7BVT39bKFLSZocq4Ut/S?=
 =?us-ascii?Q?v5aGFMBPuUvd3xy1LSqowykI01aksLAlsasek2gs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00fd8e5-ad88-4092-d381-08dcaf9840b2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 06:32:45.4109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9tdTCrfO7ejW2KuUELEnLmvFX9gRHrn4WVZ/0ukLJ6tUEBHR/cAKDXkC0JdMAmDqWJ1SD3S/bFWClUHD1vq2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7863

From: Peng Fan <peng.fan@nxp.com>

The A55 power domains is for SCMI performance usage, so for device power
on/off. Correct the power-domains entry to use scmi_perf not scmi_devpd.

Fixes: 5e3cbb8e4256 ("arm64: dts: freescale: add i.MX95 basic dtsi")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 The reason that it not fail with scmi_devpd is the driver only use the index,
 not use the phandle, so it works before. But since the phandle was wrong, so
 correct it.

 arch/arm64/boot/dts/freescale/imx95.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 1bbf9a0468f6..3499d4eb2496 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -27,7 +27,7 @@ A55_0: cpu@0 {
 			reg = <0x0>;
 			enable-method = "psci";
 			#cooling-cells = <2>;
-			power-domains = <&scmi_devpd IMX95_PERF_A55>;
+			power-domains = <&scmi_perf IMX95_PERF_A55>;
 			power-domain-names = "perf";
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
@@ -44,7 +44,7 @@ A55_1: cpu@100 {
 			reg = <0x100>;
 			enable-method = "psci";
 			#cooling-cells = <2>;
-			power-domains = <&scmi_devpd IMX95_PERF_A55>;
+			power-domains = <&scmi_perf IMX95_PERF_A55>;
 			power-domain-names = "perf";
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
@@ -61,7 +61,7 @@ A55_2: cpu@200 {
 			reg = <0x200>;
 			enable-method = "psci";
 			#cooling-cells = <2>;
-			power-domains = <&scmi_devpd IMX95_PERF_A55>;
+			power-domains = <&scmi_perf IMX95_PERF_A55>;
 			power-domain-names = "perf";
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
@@ -78,7 +78,7 @@ A55_3: cpu@300 {
 			reg = <0x300>;
 			enable-method = "psci";
 			#cooling-cells = <2>;
-			power-domains = <&scmi_devpd IMX95_PERF_A55>;
+			power-domains = <&scmi_perf IMX95_PERF_A55>;
 			power-domain-names = "perf";
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
@@ -93,7 +93,7 @@ A55_4: cpu@400 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x400>;
-			power-domains = <&scmi_devpd IMX95_PERF_A55>;
+			power-domains = <&scmi_perf IMX95_PERF_A55>;
 			power-domain-names = "perf";
 			enable-method = "psci";
 			#cooling-cells = <2>;
@@ -110,7 +110,7 @@ A55_5: cpu@500 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x500>;
-			power-domains = <&scmi_devpd IMX95_PERF_A55>;
+			power-domains = <&scmi_perf IMX95_PERF_A55>;
 			power-domain-names = "perf";
 			enable-method = "psci";
 			#cooling-cells = <2>;
-- 
2.37.1


