Return-Path: <linux-kernel+bounces-344864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD4798AF0E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D528B23B10
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A486C1AD5C1;
	Mon, 30 Sep 2024 21:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yj7hxkvO"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010043.outbound.protection.outlook.com [52.101.69.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FF71AAE3D;
	Mon, 30 Sep 2024 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727731603; cv=fail; b=WFwVzy+tuxsVFs58zTrrwunUXpMwQJkz4fFcd17YMBe//opsxwT70j7kkQsEQv9+Jo5gsFosatYlmGi++rIqbtwjAVNC3BE6jN3GHc8kUAAgN/78pXzh9/6eITpQEgV0D5DU5GGjqWgLSfOyYYTyqUiykyCdBijKdrE9pyqwbRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727731603; c=relaxed/simple;
	bh=0Zo/2eKvGlpefP3crmB666JNcFwT1bJhXd2EjeAut90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YhN9HXNMJu4sXWKw3gshK/A+rEfUzLoq2JO8flyFa/CjWlBprfdx5CiL/eE9JuletSlL35PbHbmJtVFBf/H+dv4ho6ZoHcLEKsBGiaDqjUJJAfUTzrPgyFl77wI6WvMpj9CCfilb77hrDByktWo4AKYP4Lv/HqTcVISeYOjMgRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yj7hxkvO; arc=fail smtp.client-ip=52.101.69.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1C+NgYXVKF6xd64qcO5qFdaYLrl+L3Pp1Fft9ss1I+IzSDcVZOuynXJpVCH0BfcXACvc9xcH1But6A9PXLacQs0S+lvcWkNS93ZYzlu69Cnku3El9clkIyoKngK1LWaVRmEGNXgXbCWv7rt/FviAEscfRPYgu1o6uG84x+i0xgTzCw/4ah541p7ALaOjZl9ugwDGM7vE8sxPkeVQrm4nXcairU8U9bSZLjnPVLMdA/yiVVlP6H5TGxavJDQEKux/V9j6vYBzp4tK78wvx2v/DTCBDfODVPPJTewLUDGfTdnDFZeksQRIi87PEinfbVUEorBT63dq5o6CGjp6thv2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOwhRLEaaJaMqqdkoo0JzVYgxYkx4KSY87xiQfeSg8w=;
 b=tl/eDHnUS6jTMBRxALIO7EVZPmz4NLSSgV5FTdCLyuRKk22mDTETSvbF5o/EpdOkgBPLqn+oowjU34LTDAuuwqoXQk/wkY4mpbkMQQrXWE1fiTFRzcdOQKAU8mQ/UnHBoJ+eeWe0qYdyY7dTjMGeWBsvWuRTFOenma6kmuzKIaQ+tjPP2NFhhacJujAmJhz5ocnbw7A1bjaiA/GHqEPccivA3iZL/H6zXss6UNaaRZp/23MfcBRxGEUaSLGkK4Neo+DLvTiRH9nZgolePGRIGuf4jnbAoL5HIVO8WMGU+TchrfcN493XNhrMJIMBikDFZU9jpvJqPARDWJ6jO3cHTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOwhRLEaaJaMqqdkoo0JzVYgxYkx4KSY87xiQfeSg8w=;
 b=Yj7hxkvOW81mb7wz7dy1kOTX0HF51gJYp9oHhlWLPg5jYS+w0aMvBsf5bat7bere6+3tzbPmcy1oP0pmy6KWlx3ZW9CyaB1Zvh2v62i7/3uf/e8STjn9GSxqxvg8vfnxHxvAOvIcY15R+TFhwG405NQ4Ym0VTJwTaL8tD+F7/C4Jqzpbubf//v0JnodSCnmbFAtFitJ1eiuGX9uG8z9tp8ush+tGCrFb53466dGZEjueBV/AK4KEXKxcqk/X/zSLCCO0BTmzEjxeJBjN5kee2cihk8YZNr0cFyaOkO7A5eDgZpJPo7chxQNSA31uRTXblUwotsfisGnVC7PBfTxmVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7601.eurprd04.prod.outlook.com (2603:10a6:20b:285::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 21:26:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 21:26:39 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 6/6] arm64: dts: imx8qxp-mek: add cm4 and related nodes
Date: Mon, 30 Sep 2024 17:26:03 -0400
Message-Id: <20240930212604.118756-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930212604.118756-1-Frank.Li@nxp.com>
References: <20240930212604.118756-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c65460-7264-4af9-784a-08dce1969216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NODKHGQxPRsyzgAn/CJV0CqeHrQR7ZI9RUdmvAy7tZDABAow+GiIcV368Zx9?=
 =?us-ascii?Q?Y+iMCBZ/yxXuh2KfIDwa3HbVzd5xw+HCNbNq0nCC0FSj3J7JQ0rsa2Lms+jm?=
 =?us-ascii?Q?gByWwQE+bqpBJ7cut8xbUVfR8EDIqvZEeekV5WGqOIpDFrMVPt1H4NkqSsH+?=
 =?us-ascii?Q?JNJ+p2+aA+AYCmmJTjyeeBuN8Ach9m4H7Zj++EjZkYAz49ttcol0SapNaMsV?=
 =?us-ascii?Q?PNhRodBcEGCWLEUk+2pVKGZbCTI8/0AUnVlTlBrGobztOpr4SzgUKNeScFBZ?=
 =?us-ascii?Q?oOhTUcxXc8RI0VRt8XCTvhQppCD8KPTr1PWEcPuhp53Lvrjk6YYP6shs71GA?=
 =?us-ascii?Q?GQZC0DDUKpHLwa3ISfl3CXrgW0bITKC2Z9q2t0yprzZGv3ze3RF0VHdUljbd?=
 =?us-ascii?Q?/LfrQbdNUAx+NeDEiaXNVrOjFk2o9K4zX33YR6dp/G+hDwCSJynK+Ecc0A1C?=
 =?us-ascii?Q?F4nW9Drj/izE8pF76D2VzwmWINjdRi4sfp5P85xTCiJP+BZBoAdEeEpr5W67?=
 =?us-ascii?Q?RPKdo6ZGnK1am4zeriAG/IIju7eBL+Vhd9F3HR13ShSwHBhqHaIQacIpEK5K?=
 =?us-ascii?Q?DeEUYg9wum8Pq84b8lM0KbcURshRUs5+sspQstRnx1iflJ60XJcorc2YiTgb?=
 =?us-ascii?Q?p7duHrUnBF4Fwg0apRfzkGvSmVQpHIVH2bHxl8CFEfgLJCy9So0MY51unuLf?=
 =?us-ascii?Q?LixB821QIX4zZHhRySvrHp4fC6yC+5JRw2M8Jr/Uwrv/NbOTsSE64zGt7Xtj?=
 =?us-ascii?Q?f/tkq+GWSBEuTpDOh4jAH/ayEYBVGVytqbVjQzA7nQJimbNcCC2tcY+i4BP1?=
 =?us-ascii?Q?2MnHd0Gz4ibdOgXEA+i5v5+rOIAlkceP4ws6lYwOJXG0AaxSd4OqYdys7KSG?=
 =?us-ascii?Q?BxJP0FRCJzH+kDsHYtR+1wxUydipSn7a0hIN01DYgGN7wjF6+ckq1iodKL05?=
 =?us-ascii?Q?XvhP54Tl22/jitASPqC296ea+WlRPzK/X2XAhRlBmagz94vHFyH6XPln3V47?=
 =?us-ascii?Q?RXjClt59ZnFyyAWkNqhN18kA+NmMfD00qNy/Wl8NFHPgWo3o1YAitHOBK68m?=
 =?us-ascii?Q?bV3lRHTVosPCMQXQ9FVPlCTyQLUbdDQPYgWznCmFzPqEQZg4nZAhVMFYiX8a?=
 =?us-ascii?Q?YpBtmx5Wn+/1CWSt5pYamfhxtlZCCnLsg7bRXL3nXCPFoiKAvHO9Aurl3kT+?=
 =?us-ascii?Q?qOmsF9pJJBgfP3bquLly5IySNFFnAxmBeVMayg19CD2o1YhzoLPX7veA/usD?=
 =?us-ascii?Q?deIuaGn29f5At7ebVOzC9I8P2VOikug5sPcn6272nbQPxi0QfKnB8tEb5/X5?=
 =?us-ascii?Q?DJu15PphMUs3ojS2Gz5wwjG3CK4q5mta/5ZFVhik20xu2SwLTcLnm4tLCQYW?=
 =?us-ascii?Q?gRskzBKUxmPPO4KWGORh6l7VVfvEy7nOEopYHgVMOpcePY2gzgoFi62tgMqg?=
 =?us-ascii?Q?270rQ0ewnBs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GUjF2XdxiDdKb3oOgdvSm6g/ofDqQgMWFv7vl6c9bP+SD7o56f4lh+9fksdU?=
 =?us-ascii?Q?yG8816fWyUTDiSH3XigwY7SGGpF3bTH0FkH145sL8SJZsFn6U6ohyzb1RgVY?=
 =?us-ascii?Q?nfYocZMmuBdLhoxoKrspwSexMP4hpUQveYZ1gk2wk7dD4r2W5bshl5Mn+eAt?=
 =?us-ascii?Q?lsecgfgtRDqO2lYZ1tcs9p0AJjta/Evo2RBa6x3Yae5waznc42fiTqIyoXkg?=
 =?us-ascii?Q?H8HC/QKx/GhjPetzUkTNUbtBRLz4zQmLwtZ07aC2b2vIqTbNM0MBoDk4IHwz?=
 =?us-ascii?Q?V9pyO/5VC608KaBiLvnWrjN3OHY7ZhDYX2nbXjHpGR2uQjvDqeqfXxKjkc9l?=
 =?us-ascii?Q?VJ+gNPlDeksrFVXoZuIg1lVvJWvL/y6f6RoS8nynS+z3m9dc4g/qMFW0JevK?=
 =?us-ascii?Q?fEyJRiZup7Isk6lWgn5yHixAwaqFHB5md3krHjGdNiVlKk+naXlcNEqcQ0Uu?=
 =?us-ascii?Q?9QqElJ9vLP1wlRXliCQxHdWWJlVre6A9HPLI7j6z1D+t6DKXr8BhMp+F17Cf?=
 =?us-ascii?Q?DIFwJfgUARUJhcEn1VD3vsjzsSG7l+/aZUyQvVwnbWhSQjZDCWmGkrFWCfi6?=
 =?us-ascii?Q?Z6l7sHElT3ymtjygBO0zJoxvmgWrMefahszyW8KCoH1DKum7/w2gx+VokkrM?=
 =?us-ascii?Q?AAV8Tlgd4i5T9WF3eaRNYSHfMqd3BukR2uGhNuhcgy6/P6MPuIzxbaYJX6u8?=
 =?us-ascii?Q?rjcZ27tKmJz5Z3/BT1hD9wtTRtnmBIvjzgLZGd2rPrvjt5sWrjYGFUoYcpxx?=
 =?us-ascii?Q?MjwNP8eu4KGrgMK0BfQ5HhLVerAnEeGjmvA25Xm6ISKIe2fAP9ERPbfFyOnh?=
 =?us-ascii?Q?nDsgyJAhsEs3ZqHqiXoHY5P3g++ePOJkpE3JRR/arN3PO2lvZAVeS9DAbltK?=
 =?us-ascii?Q?ahKNtHYuXO8A1D90aNrmMBnW8iLm7l8BVPksP2UZINS3u3xIyLkCZZLNc1fK?=
 =?us-ascii?Q?hAJKHgy6Q06brGyLr1Xpq5UwYjjgC3S4HcFRLUULue462x6WuW1SVd9GCZtK?=
 =?us-ascii?Q?ymDsNbkbjVEv/+yb1BjMjrKWjAB9qGEjfv/ay432XK2/UQDGjBaed60UVf4c?=
 =?us-ascii?Q?g1sh7u1MAu8lla0Bu5LqKapS/9rUHhXQfNqF84SnB5l0mruDyN+LFObiQVZr?=
 =?us-ascii?Q?xVkcT1HKXBhiNM50BD6KqdNG280tYqAsB9C+dDtTJ0UkCK03Cw4Dyx+dVcDG?=
 =?us-ascii?Q?XRw/Y2/x5Kjvw9ZBOdGdSsWFgPTDU7AZjEC1eVh0PeocG2klSJoH267mXJ5Z?=
 =?us-ascii?Q?y+7ioWtWCmw4o5/XnT6UZvkyNO6WDW4W9KOO/KqZbNIjTN6jfL9/d5/Oa0Dk?=
 =?us-ascii?Q?TtICre5VfSni6uHmkOMNg8v6JKG+sZH3yELBxlCsllzXavXp+VYsy9yra8nf?=
 =?us-ascii?Q?N36NP+5hsa7RQXpOqfS4Xcj4WJVoAQMA+vZUpwfkJ79l88WcZtScbP7iRj8X?=
 =?us-ascii?Q?f/Ff6+n9nvnXXvrg2agVOEyRAOmt6oPOE2+u4rwl12ymJTi5vJoCPOMOkncN?=
 =?us-ascii?Q?IH2Sq/UFwkutYyVcvgHNliYVIcfJ+r90kOKH7FAC+WeD42Q/PlxcS7XqGnKH?=
 =?us-ascii?Q?4L7AJatByrFQ2kqocGA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c65460-7264-4af9-784a-08dce1969216
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 21:26:39.3470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWJiWVtyZqd7nI2VIB4eI8bMFemk1dZyrkGSW/ctN8996DFxMLixg3b5+gdAI5eLV7CC/RvAWSxRfIotjh4U5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7601

Add cm4 and related nodes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index bbb94adfd64f0..83e8393a34a0c 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -21,6 +21,21 @@ chosen {
 		stdout-path = &lpuart0;
 	};
 
+	imx8x_cm4: imx8x_cm4 {
+		compatible = "fsl,imx8qxp-cm4";
+		mbox-names = "tx", "rx", "rxdb";
+		mboxes = <&lsio_mu5 0 1
+			  &lsio_mu5 1 1
+			  &lsio_mu5 3 1>;
+		memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
+				<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
+		power-domains = <&pd IMX_SC_R_M4_0_PID0>,
+				<&pd IMX_SC_R_M4_0_MU_1A>;
+		fsl,entry-address = <0x34fe0000>;
+		fsl,resource-id = <IMX_SC_R_M4_0_PID0>;
+		status = "okay";
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		reg = <0x00000000 0x80000000 0 0x40000000>;
@@ -85,6 +100,48 @@ reg_usb_otg1_vbus: regulator-usbotg1-vbus {
 		enable-active-high;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		vdev0vring0: memory@90000000 {
+			reg = <0 0x90000000 0 0x8000>;
+			no-map;
+		};
+
+		vdev0vring1: memory@90008000 {
+			reg = <0 0x90008000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring0: memory@90010000 {
+			reg = <0 0x90010000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring1: memory@90018000 {
+			reg = <0 0x90018000 0 0x8000>;
+			no-map;
+		};
+
+		rsc_table: memory@900ff000 {
+			reg = <0 0x900ff000 0 0x1000>;
+			no-map;
+		};
+
+		vdevbuffer: memory@90400000 {
+                        compatible = "shared-dma-pool";
+			reg = <0 0x90400000 0 0x100000>;
+			no-map;
+		};
+
+		gpu_reserved: gpu_reserved@880000000 {
+			no-map;
+			reg = <0x8 0x80000000 0 0x10000000>;
+		};
+	};
+
 	sound-bt-sco {
 		compatible = "simple-audio-card";
 		simple-audio-card,bitclock-inversion;
@@ -407,6 +464,10 @@ &lpuart3 {
 	status = "okay";
 };
 
+&lsio_mu5 {
+	status = "okay";
+};
+
 &mu_m0 {
 	status = "okay";
 };
-- 
2.34.1


