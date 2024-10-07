Return-Path: <linux-kernel+bounces-354216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEA09939CC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 00:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E9BC1F24374
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB6818C93B;
	Mon,  7 Oct 2024 22:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Er5LJWa9"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012008.outbound.protection.outlook.com [52.101.66.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A30B18A6DC;
	Mon,  7 Oct 2024 22:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728338765; cv=fail; b=NiYJ86LXMSBedSaPQKXJk+apEl/FxE31UXBmkNrVonTUncA0bJoUXl90m1X2dXR1f5UxlJ++MuNTLMbD5B5y5HcO1no4C9pVSHNDcP9+0zXjxtQTaupgjisPMbzgq4rGxY4snZUoFsD7IH6C75oZ/km8R2YLBPQGaVhsRdsVkfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728338765; c=relaxed/simple;
	bh=0cfyjBOWHAHVYc7CFZgp6JWZ7rP5wuHBcpIRN+8uzZI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bCWxjZEUBRqmarluAgsfQltzqBAEohSG1OAPUJ8CXvjmfqGg+ghV/isWMYovjKDOeRVo/yy2dlukDNHu+FeJCXOAbBq/IJcIOeMwgOd+u/2A1tt/K0ggaE2jvKeT995tRn98+IQpSxXB9NmA6zyPhU1TPfSWlX9HC+9cG9jcZ20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Er5LJWa9; arc=fail smtp.client-ip=52.101.66.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6FRAHXE3r5clgQwEdWhoJb8vaxKZtu/jMkLGbhkEur/dAbiLMphWBXYHML5X9AbShTunM88MSJWmvvjFrtmrgbK9QivzpX/5yZm3hdtLIIcgcd1yjBF9Im/t01LL6Y3HGxwLkjXsqilmxbxHoiVjbodYi9D68RS3l8JMLJRiYfwz/7KSF5ATK+s8kE4+XdZ+FBnOf2sqBvEG7nmELXA78Vg5aOALwUqwSwzZYKEkN8yMu1JlvbfQXvXwoZUcjdR2smz5UU7MjhSHDcoawy9bW0Ifv33E3kBlNkrute6jPf65YG+K+MeESF/knsv+wGWkqIxPRotBjlBJtgF7VwP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97vlyFggsKuEkcXO8S/5NaIvcs21ekXb0sc6Qp52Ji8=;
 b=MlIBSrLSGIa6bDvhDbhfB3cLkn7yMcem1vNKxqt0Rh6FYALrfRnr3IwXmARc/nSfOMmVoASNPWPwSJ7nneVY82YUmWxXFUgthpF9708phsRX2/TxPKkI5+5mhYS3wKcPjmxvVrT/WOa6hDx14qeC8TZmU/bwnxYBHBMnu0doMbbfUyAZhNdbJS+pJPxHKnyfWQah9MbN59whaUW3+HeHyFcyXZxa10zIpKTVJrCX9JgGsk1htsp0VWKQxLZroEBde9AcBI0/d7RlB5KVGx3qrdeN83tDcRgCtc9xstFp8sxl6Xa2vDmB3liNQCJW1qhmWLkiPkcTRcVZBdK1L/V89g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97vlyFggsKuEkcXO8S/5NaIvcs21ekXb0sc6Qp52Ji8=;
 b=Er5LJWa9mGGacfeASBrXVmEEhA5ImdAcmgwmohFOm3SRuroCin6d2O8yYevcGehm7RfirS5tWPYIDX9Yijl9DaDJzJqtGNe62bWDvqVCCppWCLJhonxNTUXyX+ODGeslqjBuyWlG4/lfAYEHG55fuKapBpqCSPBfazM0unl+QZvowwtmGkXD0xPSWc9i/ubiKZtApUzRLeO3Cabn6PPTzbWigh0fEywUNaF8eC63kUkmlmPTAMNHjnkn7CmV+hwYZSR5ZB5+6EEBap9SLJb8m0m1qKqO3Idr7WWu4EMkoSA6dNDiKDox+ZvFGp4Hr998GSx/7TcF+LUcp1RBsCKsdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9809.eurprd04.prod.outlook.com (2603:10a6:800:1dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 7 Oct
 2024 22:05:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.019; Mon, 7 Oct 2024
 22:05:57 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v1 1/1] arm64: dts: layerscape: remove cooling-max-state and cooling-min-state
Date: Mon,  7 Oct 2024 18:05:42 -0400
Message-Id: <20241007220542.897605-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0089.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9809:EE_
X-MS-Office365-Filtering-Correlation-Id: feafed2e-6a5c-43e9-0ee7-08dce71c38c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W769Rw8A06eOmbotfIuYwp7ySxjRtLGM1KLcgBvGzLLxh4HnPH7BaatYc/XI?=
 =?us-ascii?Q?SxdT81eS2jwzVsqZVdNU75bEr7Ryq3woC6g72wgprZKqrgsheuFdvTekE/Ne?=
 =?us-ascii?Q?52GyuzSrOWlija2jmAnh+C35BkkhZxKFsGg5PH+Ni0yFdCM+8Bmxpf0R3qHI?=
 =?us-ascii?Q?XqPHlo4RhQ9ZV1SW4m5NZb3Qr/AWMxPkqBF2OwxDseXMUjVqtUC3ZflpHO5b?=
 =?us-ascii?Q?inFQDeCwsohcuympXWSxnekhyf+GasrZOfS1YZUGmlsXuwBA5stvaBiBC4V/?=
 =?us-ascii?Q?eljzAfwGeT+d82GUUWWIZLN3HsRNcbLO/o3hjKeXgE/Rb1vnRZJZpE4r3u0u?=
 =?us-ascii?Q?FiQbog00iux+FT6Np16JYalEUu8gbKtjiov84iq3NbCfC+gjxlpECAVR50nC?=
 =?us-ascii?Q?dbLvAb18I+2ErIbkN2SAn6Uyg0XLtbtZ7G4+1zA1p+exFdYWupiTzxlWn8nu?=
 =?us-ascii?Q?8xK8lPDVkx1evJ3r0ZA2TiRQqi16Br4K9RbcXXfCzk/D0onSVB6QeAbaCwbm?=
 =?us-ascii?Q?HV1FID7eoVZ/sONoHQpv67hr3h6g0ABtf9fmMbx5ursjjW3QaS11LLBOzgYj?=
 =?us-ascii?Q?vd/SC7zRLWrnHv9YB/rWFTWBmOLW2bEepjUyQWOebxi0wECGzl8nmzxkr+lS?=
 =?us-ascii?Q?6jW1vlz/toILVhxEEgtNvDGvk00j26t7HUSeuowIw0LZuQz7Oj49ZbSmIfKo?=
 =?us-ascii?Q?QIjQgLSfsMjZit2X68JQNDly0G5P5aklcM70vZwcA912dax79nYLJ7nQpKg1?=
 =?us-ascii?Q?dMMGVfIWrvKjy8nc/ERBQHaA8FeCRi3Sn+eOLyyqDhZfcM6oHYdwGmkAeAEC?=
 =?us-ascii?Q?RxOJVa8T89xT/KVOwT7ciXow/M6twm9EDuTuQsOFETxKiF7nrLKH5R+WLU0v?=
 =?us-ascii?Q?hqPQvGQLZxnEyEVhnPs8mzqkqiwXcE0qYriXiENn5jJLPzN0DukvPNCGOA82?=
 =?us-ascii?Q?n/FCQJ9xANUpFj9Cy8Bvmff394j4q6ide5PcXihNw5qZ6ucZnsJ/6BSKt12A?=
 =?us-ascii?Q?U9BF2bjxyW3YMN2VfAx64FenImSi57VSsxaHADF0Q+QvE0VKVBSDNH4ca7Wg?=
 =?us-ascii?Q?J2RqW7MnlZmTJM2AURIswqEqoQJE42zgib94X4VrywOYkzFuaL9roCB242ir?=
 =?us-ascii?Q?oGMWwWjLvQEuJLV/tm4cVUdDy5VQw2uHVFi/8q8okZfzvdxEe79S8sWFbNB4?=
 =?us-ascii?Q?NoGxMIuOA0jEvwZjWy+oeSrAZDclEG6Zis006YWft5IXVC4IrfwsIk9NtGjn?=
 =?us-ascii?Q?eUhJyNRRKm5GyRrXsqd7kp8PJPhe68+gtqXaXvuTpxg4lBc0nqCkF6E8x1l4?=
 =?us-ascii?Q?VcidwT03EL7OMkOw2QoKzwn9GmQZcH8226ch/UT0NlL7JA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nx4VRO4nWXygyzMz735spDzUBtUnsISfKxZwgeO3P9GAmrPIf356XnDUczGA?=
 =?us-ascii?Q?efinPlGkTnnu2LvGuaUUwrK+Icmr3cZHa6e7Tz3Sw434Sn0QMHX56hnoFRRa?=
 =?us-ascii?Q?ZEsCxuY9cpW5gp6BwrC3nOPSMoCpiWk/P1ansDORl6c23H0X64ZbpJWH1+Ny?=
 =?us-ascii?Q?AS1f7TxIsiZQlNs5ZUTJWeuTvP67oziATjKF70e4OUd9uhQFoftxVw7XKRiz?=
 =?us-ascii?Q?0SCpbIQliScAMBQplWMIlmFG79yT5RSyrZCvEv7Jdpj/5jY24IGVthXUXtSW?=
 =?us-ascii?Q?6PN0SihShP2QciEQRVpD2gsvh25vXPScMDNojXYgHksLo5lhvfHv/SdUXbz8?=
 =?us-ascii?Q?7Ve+hr5p5alG9vI+XMXarEOv9Q4QZx/QmI+nqliTxYshVA+OlT6SIuX8z+3k?=
 =?us-ascii?Q?gaOkvrGp/RScvsqAIqMqvVx3w3RQFJTIDR1lNt6fkRsTWgf6hVO93Qk8BoEX?=
 =?us-ascii?Q?YGubVsVvzH8GQ1UEny17Si5heL1ch8mYM3OMx6Ie648zu6CDSgq9PehqFqRu?=
 =?us-ascii?Q?BlW9MRJHWRl4+jR5JLgWjVp6t33q7t0ypP/ZzVQP/VpWJlHNIyLrxImFMzRd?=
 =?us-ascii?Q?fUGXjPYFMss0AQJWQ4FIrncg9vy9LdI/Azho5zPr82ydCzeVK+/ihioL4xlv?=
 =?us-ascii?Q?ItVYPDPCFcBzAPf24NMQQDZ3Lrpwja2MxxwbVeD8pqkzwPTa+0VefFHEV29q?=
 =?us-ascii?Q?r/Joc3jqr70ZS/gqcBNAOIhQFwi17ImYVfIyRTBqiAYRvB70siVPJQ4nA8+p?=
 =?us-ascii?Q?itkK1YTyT8zxCMcgc8RVzId/VAPkSOsXN4reoA5pW1IiQZe1du6CraB3mxpP?=
 =?us-ascii?Q?0WEz+ShrdXa85OEnVp3iAkl+Qh2kuF/gd75Rm3uCS19HICfmeqNaQhkZ+gyB?=
 =?us-ascii?Q?A1TUk6DvkIfpjiIlQEoKTozY/9yi85iQwsMKktKGDWMo/muxLBlGRhok/Wsy?=
 =?us-ascii?Q?EsScP1vF+4OZWsQa2XgRoL1a2em37iI+yTLO2NlHY9gC9PpRE9EfAJJru633?=
 =?us-ascii?Q?wYCdkqBuMmDcqIy7rN/ZMJ7jf4qtOtd+4CDCls6Jdb/nzojvozau8zTvHSAH?=
 =?us-ascii?Q?lJUPy6V+w486SIZCs5y8gM60ej/ePjzGn/Mqcm1xgx2cAANL9FtO9JoR66Vr?=
 =?us-ascii?Q?520E8RJb9WzIT4WOxgHGy/6b0rPCDVw7WgQZ/QpnuLlcMK9Ouo1C2IY6s4f/?=
 =?us-ascii?Q?ZUeUuNZbpHfMm6pO8tTO1AG2sYaM24D48YQOCFfh7Q+rvkQZjSFUKZ/ofPFR?=
 =?us-ascii?Q?HWD2jVRxEvXRJTUmF8RP5sIuOnq8E8ApX7gh6moMfYL8iIXUDx7N91MllVsu?=
 =?us-ascii?Q?qncj2UAhdtAXyZcDHC9s6e3xyLRqWscXKm/Nw0qvXIJ4dxDAWxcuBIuO58S2?=
 =?us-ascii?Q?hdHr6WNjP1x5fw2gTxe8UyyBTzc+z91vEmLqrd8swxEGTRNRi8kzH3Q+5/9f?=
 =?us-ascii?Q?aoJoa/RT40c6T9yzOtSAc0mtqNvGuB/axKxt/jvRSbjCK7SgCuH1yPrBo97V?=
 =?us-ascii?Q?rJ1IHS2NeiR1c0sn1VCX6C4JgUfaBqxRjLtzJKpkA0uCTtprVY7XlBj4VOxQ?=
 =?us-ascii?Q?608M5OSy37+casvgS6M=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feafed2e-6a5c-43e9-0ee7-08dce71c38c8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 22:05:57.8885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4GX+CzjoylvzZrS4mJucl5uX4L/idRUfbCiP59PcgGYHA636g7p5NNFQbjDh9uVDftaeTwsZngA86Q/AZnhPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9809

Remove unused property cooling-max-state and cooling-min-state.
Remove undocument property #cooling-cells for ti,amc6821.
Fix below dtb_check warning:
arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: fan-temperature-ctrlr@18: '#cooling-cells', 'cooling-max-state', 'cooling-min-state' do not match any of the regexes: 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/hwmon/ti,amc6821.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts  | 2 --
 arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi            | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
index d9fac647f4327..1d53b529af88f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
@@ -19,8 +19,6 @@ / {
 
 	pwm-fan {
 		compatible = "pwm-fan";
-		cooling-min-state = <0>;
-		cooling-max-state = <3>;
 		#cooling-cells = <2>;
 		pwms = <&sl28cpld_pwm0 0 4000000>;
 		cooling-levels = <1 128 192 255>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
index d32a52ab00a42..e4b727070814f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
@@ -94,9 +94,6 @@ i2c@1 {
 			fan-temperature-ctrlr@18 {
 				compatible = "ti,amc6821";
 				reg = <0x18>;
-				cooling-min-state = <0>;
-				cooling-max-state = <9>;
-				#cooling-cells = <2>;
 			};
 		};
 
-- 
2.34.1


