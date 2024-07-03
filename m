Return-Path: <linux-kernel+bounces-240162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7879269CB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB772840B6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADC5194083;
	Wed,  3 Jul 2024 20:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UEPR6lnc"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2079.outbound.protection.outlook.com [40.107.241.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255AE191F77;
	Wed,  3 Jul 2024 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720040350; cv=fail; b=n3iQIOJScCxwoYnXjzEpPzg1347C1i6Pd496EUoNqciPf9y+KZ6eMp77CERzQlnoqBbaNSUc+AYIGcosT7VYM4WAivNMyWu7Ks7bXf6ysneWGgn4GXk6BRay7uXK6+7x1EO/olvuHMNqZNjL27e1hPH24tc282QalNgrgZOVxgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720040350; c=relaxed/simple;
	bh=DgseKq2FcVuAPrEfvhFHD/54Y6kiJkxeGJSjo4y3wZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uAuQ4LjWMpOkjr92MvlN3zIKO7VZJOG680EOpQGQasHierL0/06OCaENuKSS+Lmex8hThheFyJSiudH7VYvwkDhZ1Epx6DF4s+LziuMjF93dHL5IDR6QjinN3SiHHD9XDqbC4ZOAT5SJN6u8o6exsVtCueShDygvjMj9l5h6QdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UEPR6lnc; arc=fail smtp.client-ip=40.107.241.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEjiGZBzGWb/MtUCv8k9RbmKK52tPc//GHMHjGu3z9In3kbMvZ70z1XakQX24cDeqcCbnU624UqRYd/JxLtRO+zPW8GC2B7jh6TsPkEIYMP2u0ahcVuBoRE0NAKDN1pac86Y2Kj4drAZj/QtiijlAtdvtHchi55iQ8BddQOQEOdywm3J3w624avyD8TEsszXLIE2hMbSLNq/1osEDZm6V10ubhN1Cq6drxCGYYvlyssX1PlOjlCChb/8/J4Wbho+bYGBKvGwB4iX7qhYVp6JzVNkH2RUEZigtV1vGc6cFCoEyzoBlcrnMIqzDU36VayvNYv82tbIiOHvWPCPmjAsVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gERMEJwPSVwe3jCKtZYuBdokaotlRn6rLayb7/278Wg=;
 b=JNUsP2PGhrE8X9oUcfTCKS4HZSYq/Nlbt0x7sez9X+XxydMJ9ojUvuPDUb82M8UqOCW7zVOCouWBnbaCtcaEuSTuSnqik/izGbHTHvo+buf8GP9jbkxFGjh8McilKhtCmWD9MxxckmYBjwli3foM1iLUDqUrrVfgnSXZ+hrq2CSLJIwgBCNWZubWBzEH1P69/Mr38AzCL1XRs5wnt0XcXyOxqGbPwVc3WU2mZpK04Ku/AxuMubkYt1VWshIsJGjUmzM7WAuheUGmsUB+yWE36KjHTf2kSF6vTVbS6oKLwcz+n0QMZ85BRTQB25lpj88iYm8kehCoL+yQ5HAia7Ky/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gERMEJwPSVwe3jCKtZYuBdokaotlRn6rLayb7/278Wg=;
 b=UEPR6lncuYVWqIpaxmbfFFljpl4+yg7TRbEB9G1k7+D+tNCV2EEW7B4vbW/5ujURoIGCH1Qs2Mnt5NDIlEx/n0VvYUpT8VgX5YyzT8gX0KXcy7gN2/dcqcbsF3X9AOU486RGNBZ0ykn+23+64s5Tb5xZP9FhO4zfLcxmYgXryQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB10049.eurprd04.prod.outlook.com (2603:10a6:800:1db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Wed, 3 Jul
 2024 20:59:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 20:59:03 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 3/5] arm64: dts: fsl-ls1046a: remove big-endian at memory-controller
Date: Wed,  3 Jul 2024 16:58:45 -0400
Message-Id: <20240703205847.2826263-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703205847.2826263-1-Frank.Li@nxp.com>
References: <20240703205847.2826263-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0055.namprd04.prod.outlook.com
 (2603:10b6:806:120::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB10049:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0d4e36-6b58-40f4-354e-08dc9ba2f872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G8Cm4d2QO6DM97mY5bYC3x1A9j3HmROpjWQxKMMK4kmp2HNVzSovqP/m76hk?=
 =?us-ascii?Q?jTggsxnd2ToPJG+c12pr+C+lsW0mylDUNZeDk7EaTHyf0d/1PV04QALhxdjo?=
 =?us-ascii?Q?bxZ/qmJFfl8FeoNsB+Cze1i4pnczKOoBha8qYkWk4UxcA3wNgPmSNn3Y6NDs?=
 =?us-ascii?Q?MvVBP4qMuDsdk/DO4CEcRUn/4i9KMdpw9+MMDhDtptl8S4bcE3qAs4Ms+EvP?=
 =?us-ascii?Q?qYnSGmHrD7VvIHZXzck/HIzcgREonFqKK8a4A2CSfbjrB6Z9ZvfLSn95eNaH?=
 =?us-ascii?Q?uRzFpymov9/HOfzlhmwU/SOYkd+CpHnvFSVOmTbnlE3vCEPMB1SyGo8NXAmq?=
 =?us-ascii?Q?CUR/dgaUbf3+3bywsLCC8x6NTD3VmjrImMsSqhAH5VtB6Ogolv6vrzqlMtGB?=
 =?us-ascii?Q?T6W/J8uakCiJzOhF2MQH3LAifmVCEDOk+V8+UkQCojYlyimCsTE+zOonHI3r?=
 =?us-ascii?Q?CrD9Yo0DP1VPFYhnLfkwWw4rNyq9kV4NsnucMxp/dC/6JGbKDg/fHoZoviIj?=
 =?us-ascii?Q?BwY92JDDdEJ86/1/+qpVb4gmR0fK2xOT8mmghZTi8wGGI3adYDwVxLzPbY1P?=
 =?us-ascii?Q?AH9pXyRcUGJdvOYc4HwrU303gDSStC7w2rjSnkna482ZAqLASCB1Af1dQ1bS?=
 =?us-ascii?Q?LLB3biaD+WY+UU/KjYmOKirUwEiI5hJsjE1YE/fJYN6q36Bkx040yL/1SlxV?=
 =?us-ascii?Q?9QNiaskahtHaPgDJ9r8tn4+MM6ekdH+dIIuTuLX5GeFe+PZmpP5/d/dFXdmx?=
 =?us-ascii?Q?wbKvbst6SX1VRH5jCC03JDLUIXDSW/8mn4NqCiy0mNVAq9/abHOFgenwdyBr?=
 =?us-ascii?Q?FfXYXBOs/b7kDZU2OR4kCT+hPYs7edt3+w2hBqFMKMAW1oP28Ohr3o2sl47N?=
 =?us-ascii?Q?wRNEkP7GOndhKsza1b/aX9s6mcf15TEhS84aHnMyJ6eicTzZi32nLSmPvxwN?=
 =?us-ascii?Q?UCfg1zS4y/u5wS5uJFeb7ftJ3xBV/kxHt7Jn95jx+AvcyVE1ptFzANefQfGG?=
 =?us-ascii?Q?6LDTE5XYhvngIn+esj2pAjGA6ABYHKfptrgCqETOf4a+NPdZvccvBhrLKIDn?=
 =?us-ascii?Q?Yk+l0EZiMa/VoikoIiSmW8fgu/VcE4qNgPYImbulGHIdioIrNCkqoob1Cu39?=
 =?us-ascii?Q?/q+TjdZzBMVnMb12Totakab+95d2nenAP9Dsn1nrquRGo48RrMO1UBO5r66M?=
 =?us-ascii?Q?yp5YisHOCrG1VDqxn9aFie6+Om6QsTkx1rkzAoG5TNI/q5NG8mqDYT8uXQGl?=
 =?us-ascii?Q?cuxcj0UWiCpHJZzseGsDnMIm7flD+mhpn9aU0c82H0RzRqTidAzTmqmDQzHw?=
 =?us-ascii?Q?+kgXHstBLuZOrDIDvYjWe+gnBf7m0g4BVHaC9/gHIX9pcrgHXtSpmU9T8jkG?=
 =?us-ascii?Q?VVUAK7A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XfIH0yP9LFvFtB3ksKR79wfYDK44i1A5nWGplUnokrRvbWb0aSOfk0bG5RAT?=
 =?us-ascii?Q?5DtuMb7Vh5YrMv/cTXEF2/p6eh2ZPf/LfC1mxwyT1GEX4h1j5Fv7S4FJUjaz?=
 =?us-ascii?Q?Gi4KHeEnG62EMI5NUsWfpOX8Vz7qfHYna3eZtwF+cVmqDoGf3HbLVLiVFFtn?=
 =?us-ascii?Q?EXiJ3n6Q8fE8UfTN91vjwyvDCJ7DPOXoDm4vuDA0QBpC8KzT5keJhiACkK++?=
 =?us-ascii?Q?Yw/9fLnal51yJIl0UIl0wxUu5c+K+eSqJX141xr3nC5bp3Dru4d+EjY9/lV0?=
 =?us-ascii?Q?t87nXlUH03Mp56gyqYdMgOTE4YDkiC+AnKhI5BtnK6ysBA0j7bB426/Y2O5S?=
 =?us-ascii?Q?ScL6mqveDnJX+iHQy1RclyBvfmicFjbAn/gSmzR/RkR+KswLs6rhZDAZJI3U?=
 =?us-ascii?Q?9p3XwIxuuzjdxQCAwh+Rnbi6BsKdTjbS7bQdv9bC7dUtWWxfyKeFCHj5L+FA?=
 =?us-ascii?Q?kzTbquXt0vEv/fS4MwovHiSDR2hkdQD8xmVs4csxQlegrXvU2mds6HnYNfyr?=
 =?us-ascii?Q?vb9BlR8QZoUv9Hw2MpDMf1MX4KntpVf1Z3zxRr96PeYZT3AJVQT8qkhz/nhf?=
 =?us-ascii?Q?bihte/+rr6adoF2Ik33rwuo8fr+km/uDY4rNMBa/cISBf2cjbpYUBxV1CCaZ?=
 =?us-ascii?Q?mJ3K7tPVSTt8xRI/1/UN46gjxDh09E+QFm7bEDYxiHJ4NO8gRjlHBMaQlaIk?=
 =?us-ascii?Q?DjdtAxn+riVD+5enWUsH6pz3qOp3MAfwXXUs77hYkbxG87f6e6Pb1k2/DuFB?=
 =?us-ascii?Q?SG8WpDyn9a/PRa8OLWrWdVOpceZOVFkA+Rr7y5K+6Zkb5hARDHxYoD1k9PtM?=
 =?us-ascii?Q?32k3/KZN8lqbwP0QzhxmZ1ZaloMDQiDyESQocvxx8U8/cxWV6z+kTQfMiPfY?=
 =?us-ascii?Q?CQsfrMyyIJk2XsDxyM7SzhjD4Ad/D8VN8Mzo5FEKzjYFVTVeg8zRtq4+Fn6e?=
 =?us-ascii?Q?HcU0a3BJrCS8BA5gbv+0r0DjlvJ5x3P5u37hV/vHWLsnkDE6r6lL1VLBgMQy?=
 =?us-ascii?Q?CHbbl2U4HzX5JDEcu38kcY9P4vUZ9EOdHrBRcyJLud15hrA9tGrj1pkdCpU7?=
 =?us-ascii?Q?6o6uTNjLOowe89QzyO+opme+0d89VvbSRzlLCOpT0zmv8uphd9jWIjLKeWuv?=
 =?us-ascii?Q?OSyUHmiqsaG2bzm0DFdAR4dOXlXDWjE5/jdOw2KIaHMRFNRAtt9jJcQq6zAC?=
 =?us-ascii?Q?3I2ToYXG8Fg0Ki5yFNbjOXHcT5bdl+s/xcJRhwz3QEiilVpqLR5E26KYCSth?=
 =?us-ascii?Q?sygllQAZGD49nnC00BV4RRGh7BcS++r22iZWsLxksIQZOjz9GccPwfMuLJt/?=
 =?us-ascii?Q?fFSo86D1fmjPWhTK5nLp5+1EMkwXvp5rCaa3M5fqzlsMMKSGcdcorkk1CSkz?=
 =?us-ascii?Q?zRSFLFBrs76t4ff1s3+ZSzTxLtKdfi1FqRu+sS/d6ZARBVzcXEkYRtRVQ6BM?=
 =?us-ascii?Q?tdDLqAlzI1o7xhYTQ7MQzr9NTjPtIioOmrSGb+48hmJr3+NaqlBTx+rN4/vr?=
 =?us-ascii?Q?Kmy4JsmksirdISnJ4abzJiJSxLmOsSDrJEzUTFTq846yf84HD3X89uUvc6po?=
 =?us-ascii?Q?PjhPFYO58tN4v2CMZ6mlLSGOVxzGSvt4BnhRrEmu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0d4e36-6b58-40f4-354e-08dc9ba2f872
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 20:59:03.5979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLUsfwyhro+n1zF83XcHC/v+k4s1RXta3LdI/tx51wN3XM8sJ16ZsnZKpxFNOhc9IdrQxFcBBdhub0U+8atY/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10049

According to binding doc fsl,ddr.yaml, big-endian is default setting. So
remove it to fix below CHECK_DTBS warnings.

arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: memory-controller@1080000: 'big-endian' does not match any of the regexes: 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/memory-controllers/fsl/fsl,ddr.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 -
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 9a19bcd1850d9..3dcfa50cedf9a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -438,7 +438,6 @@ ddr: memory-controller@1080000 {
 			compatible = "fsl,qoriq-memory-controller";
 			reg = <0x0 0x1080000 0x0 0x1000>;
 			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
-			big-endian;
 		};
 
 		tmu: tmu@1f00000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 9bbe2d686a39f..1ae73708bdc60 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -282,7 +282,6 @@ ddr: memory-controller@1080000 {
 			compatible = "fsl,qoriq-memory-controller";
 			reg = <0x0 0x1080000 0x0 0x1000>;
 			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
-			big-endian;
 		};
 
 		ifc: memory-controller@1530000 {
-- 
2.34.1


