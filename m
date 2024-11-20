Return-Path: <linux-kernel+bounces-415524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 098EC9D379D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 10:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 068ABB27DCE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B950E19CD16;
	Wed, 20 Nov 2024 09:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WQYNEcYW"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2330518A6B2;
	Wed, 20 Nov 2024 09:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732096362; cv=fail; b=WVTHh1aTapaJzi8vjWIWmKF4KzyO7yqezSTcV1ImrrKyS+z+GXsCcOUqvBvgWDNVQSlJPEi6tkbpfj4x2aYosTwg/5020cbdz8zFzxPcLRLvieC8sUtDEzWz5ggYCoWBJcJWxQDDS1hAWHGLkH8e2ypHvv7NVJISbSsOkH/P4gU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732096362; c=relaxed/simple;
	bh=A13n9fzhCeOGWhR62pmFtpbxmQUqCZ+QTllTKGyUwpY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mEn3Pk+smW8bKqgkguxo+hnQQnnciDV22KaNrDTmEtQzJh3q9L6ygAQ6Y93ZvTNR7Vgkb8scKKDDZTDR2uYIUef60rPrDQEblpxK2gIjP3tavLDZ/LyBBiorhsW8NBIGh8u2y4dzViFnZfqodgMgqUBJIN0cje20H4rpdSpjWKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WQYNEcYW; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCPK0B0Qca+WjC5vJM98va88UiVqfaM50ImXAIzTE4p+21HTtZsTKMhQPIK6yT5U97VyGSCpnlqK8BFUu9LRhKJ1B+Ur9a1k1eKMPsEXAaYXlUeT1F/ymH+cOh5jvAkTnCMWwYwKmPz7Upb4KT49Iik7UHPTzCl/w2iAmyzhziF3WwHGTkbuRO322xEzNvruTo5klPhtvbceMgoSOIcqal6Y0dLPJtFo2Ol8Ok6MzBv+mSwFyXmSwA+OB1Ldxnn2e/5LxsS+dbT/6GHFYKah0MWIrcQwKHVtUs29xdcE9MyFpnPkdWDGXrG+tb2b2iVsfy/purlU9LmmM6eurXwX8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJTZ4f5CucrzMYxviWYyhSMDlQZeDpr8A/JcdnbM1HA=;
 b=x2Er7CehqtIYYJL64yXiWVyNjuNxIyA5OgsIroawZz3yuTef3t1jsGnWUptoWqs+23pnSGA9gEmOnA/UDwzSLU1skrr8+IBAsiwOK0oJVCjgO6MD2MlYE2cYnZ1jgBSOrPJr/H858UoYPkkI5UTXPxWlTuKMYHelujBenwk21vddbAmYfWtjpgQPoyd6C5MJApDiF8X+MC2Q+XCA7VQLMdsOnfFRhD+tcw6uJpQIs72fI+LtaRBsllb9h+9wYp2LZqKwy7pDFsUE53WjkmaY32yU2TZWrS2IbntsQc32vtEeCdVZyiRnP8lNooSj8hwUes6nolYBjO+0AwH8Q/s3fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJTZ4f5CucrzMYxviWYyhSMDlQZeDpr8A/JcdnbM1HA=;
 b=WQYNEcYWPE6dLySVbbPRT29lZnWnKbsJGeNl4cBv5HI5qA6GCsw9sc2wO/dPgb3YLnHOKqB7MSrZjRvUhAKNq3t2m10bNnwZFw9WkRUjGrEDllqaSHt7JF23WEBE+YzaXMWaSS60lY89zPDZBvYeutBkXvovOsjGhPTZYdQiXAuxJHfgtQZl6mBu/2ME9C9q45er01bE0rreENxzQhzUkU8PMR0gNBoLZvvNaI2Wabitq54Vtget5AXxymrdAAb+FwKvaGq5Y2LN/RF0CMMh6n4oxNmiAc8SKw4ad2zx9qjEj63xK65WSaF/X4y6cBIM8FkibJ/jjvnTOjC7ciFTlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by AM9PR04MB7522.eurprd04.prod.outlook.com (2603:10a6:20b:282::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 09:52:36 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 09:52:36 +0000
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
Subject: [PATCH v3 0/4] Add i.MX91 platform support
Date: Wed, 20 Nov 2024 17:49:41 +0800
Message-Id: <20241120094945.3032663-1-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|AM9PR04MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fcb3d2c-225b-43ea-dee3-08dd09491003
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TFhAM7o/jhRBUUUtaZ4H9gG2qZFXoe3w9tSdpqE9la+chYHaa3/Uv0AOHm7x?=
 =?us-ascii?Q?n0sL1vxo/5GAVpynwhMUfG3nd2Z57HhZ0oZ6vNgzJbJsCRMbE47YV7cs6lhL?=
 =?us-ascii?Q?3yuGqtT+mn1p7TMA/rJy4Bj14/Nv1Fr6Tv62heos3ZvyjRhAMzySNcGy16xj?=
 =?us-ascii?Q?D7y2zF7bhmbeKfowi5AjVJsf1mX8//5WzYlBV2t95YlKmWsVZdqyee5jObHl?=
 =?us-ascii?Q?vrbNfu95cfLY9ukPqqdLXt/cV7D9ZTM/tolB5NRNTaAxWSXBQx8935pZpe+5?=
 =?us-ascii?Q?P+sB6p5/ZvmBPMNxDcFKjZrAEHakxcGjKILtLoV7FQIoNsiGB8dVUz6Yo4/Y?=
 =?us-ascii?Q?hxp8/FoXDBNOaFk3nktdSThVBwHbSAO1uMaaTeNV2qVxKmFp5qW1e+2txXNR?=
 =?us-ascii?Q?Lj6Cbt4pJiE2YOyer+HF0miHXS1ISgCCdsmvRVea2MZcXWBnpaJtOJ/ndEEo?=
 =?us-ascii?Q?1mMmP5Ifc4QpbcoclBopJiMcHT085YaSjJ/29MnuCo5oY7GIT+snChOSe11a?=
 =?us-ascii?Q?n5TpdHwTFgAaT5tNCAPL4o2eD3X24cQ/hY0tKdvMGSxEh1fVro5hJm9yyXh8?=
 =?us-ascii?Q?JFp1Lv/A/88ZGHqIQditoalOiq2xxPjOLF4YhIyBhTy+rXuI7hbX+bJNx3Pf?=
 =?us-ascii?Q?Wk39/rktqP9ukTHUDUC+c7F2jwInpkOh1IBUBRXd4w5rlVwuegrIjwEMDR7S?=
 =?us-ascii?Q?SBptsTvDYk4JfJ6lyYO8BneeAVsLQfkbYyaryJBHeHmCQVco6Oj7pkTFQSeP?=
 =?us-ascii?Q?K1EbH4v6aS+vV6zo5qbMrHV4vx++sZ+CbdPKNSJ1heoL+CAuq5a9QUCBGwHW?=
 =?us-ascii?Q?C3O/yFqbi6XK5jdwxb/td6U1VYq3zftiPN7nxwzbI7vowtV50yiVOSUPMvwJ?=
 =?us-ascii?Q?Rh5h7ekwASaQHFgjL7EEsppo8dGHjUKHf/S2cjCIiBZ0ipDLTVxUP77nMq/v?=
 =?us-ascii?Q?SgBw6Ux0KY/LPUOlwGD6OtJth8OTiSpjx5NOM6MxEaLzyGujF5CDq3fvuAh0?=
 =?us-ascii?Q?3szdxeJnqC3C+AkL4u82MuIZ9zyiTYaHar92mr7qHqKaXV54ccwt9LAZ0vYY?=
 =?us-ascii?Q?j5Z/sNbhKdQ+cANEfegcGTml0oxr3Mkr7zMy2x6NxH3FNFHE3G4DBXO8oP7Y?=
 =?us-ascii?Q?bm4DgD5949QVKFSOLSjKB1ig+8OKRUuOPcyqykrCI5Pw1gqoKALbt7apz6r0?=
 =?us-ascii?Q?Or7SzqVLFLRK3lxZGYOOi01ylzG66uhQsvS3E5fl9bGNvYnGV6mO7em9pHBJ?=
 =?us-ascii?Q?oMmMr984UKWqQ653EJHIH0tDXFmSRLLjcm/sU+7whcGRSMua4+OLbM9fsWyi?=
 =?us-ascii?Q?+dCSHXZERIKrdn8ZDW8rRRW8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yr1ISahXXPoL+5EL2dQI9ByEpMKGJucIu9wSc5rcVUzwNUKfkZT7FqTXdKVd?=
 =?us-ascii?Q?AY/Is3RWWqEHYEa+ttkoM4kAxIlT1BCSgKsUS2vO20YQN3pzb5IURbEBqDC7?=
 =?us-ascii?Q?n/91VbZ1fkYG9bhbHoQGFtpBrhoidl8bjbN65wme9LgmGh7eK8VlYV3RGgmc?=
 =?us-ascii?Q?f3CH7lR5VbSdIR3jHd9g1jxjKvmYeu57jt9pXSJLP57k9ChumJpbMSfnFbqV?=
 =?us-ascii?Q?khedIpu0lTiTb9sVi3oGgWE7Tt/NTDWM/KLPCgT6VDgxRCUzrmAo+RhOluOk?=
 =?us-ascii?Q?VTXm10SMfuUm4G++aPho7435I63wp85mipB9pyyyYR5mfKH5mNYboia6TC7Q?=
 =?us-ascii?Q?mvagUVh+GLAl/hBXUa2E59rwc15X5zppHuE/IR4fX1Dj7HJYGnPGw6+ueKND?=
 =?us-ascii?Q?ky86DrjlgBcAbn9wCSVrUGg45zavf3S84W2KeQzAAGHZhS/pKev4D8rkGG+O?=
 =?us-ascii?Q?eEgi9bzxofZhpBzAbKuNFfEtkEb5jpIwV6al4QhP5Z8GRLIYzsWgLv+xog89?=
 =?us-ascii?Q?Hy+kKPgEa12SYU0Iq73oMwdDihBiBs2N8XP9nGz+PIF8tDRjpdjT5glKjPdi?=
 =?us-ascii?Q?2dSRqcP9x4P3+InB4rNxUZbVeokjcBjuDjxAaIBZki/cICUX3YRVx/oBkHu8?=
 =?us-ascii?Q?U+aNZtWnaz7aoBb1oV5hi060A5Zb1vH/hvqwDL8zpK59JzfrwUpcyj2CRM/E?=
 =?us-ascii?Q?+3AnUkEv68tD02PbNpyXUvLG3yZYqtP7HZ3+nwFrlLqCUw7V1mziS5hy2jm4?=
 =?us-ascii?Q?zKrffv92Tm8ZRft2sx4XpQ09I+B07g5w9Jf75FzJMGIoSjsOOqhQxZ8ACDIH?=
 =?us-ascii?Q?lUkCc8TQQThVVPHK/mJAjR5L3n0Gt5Q6qVouBZ/DBzTf+vG5z4DCb7Yj/dHP?=
 =?us-ascii?Q?BTyFb/9QW9ojIebc7TwDhSL7uBIXioinJY4WJsd18WzNp8CDGnQ8gcrtwc81?=
 =?us-ascii?Q?eJd4+VRPzXtvexFG9xx+v2ZKGOsoUTJae4y4SnW9IjBeUyocSdELOca36rOO?=
 =?us-ascii?Q?Z86r7vqpvUBgKKYKukQaJ2CYYPDz+q1vtsLUM8ck6sbxjbPf/GqDZgxJqwLu?=
 =?us-ascii?Q?A9PaLCI6l+6lFdZf8D8F7AiU2XFUs8XsJnsH2947WbO89g+/8VnegOEjF9hM?=
 =?us-ascii?Q?5HVlztguwc2hYaiNZbx/o24S2Vk+nNiA0IJaTk7VAplMP7mhXse5b8KiXGKd?=
 =?us-ascii?Q?rUzQJTgklkVSyxb0tGhq41sNfHWoqPUG8Qp8SiKk7lpS23aprDS7vU0a0M6C?=
 =?us-ascii?Q?cEKCa6BpyCTLe8gKz/c0E0yMsRFqO9AaSYU4nWaxLaPkKKVKTj5Kb0JxNtRZ?=
 =?us-ascii?Q?G58cIXChlKtavxIbwJfgAhVkrRCOzlSM0FT0pSubqi9K/yWgI07jmAIYJrqH?=
 =?us-ascii?Q?OMUlPaXFGLH4NOMKzoMFH/BXNrpnantek1fKeiKBq3FdC06QX4DU0SPdp4oK?=
 =?us-ascii?Q?Yy31YUaTo3grII9C2YCK5d6veCqlxnOgv2akGMUk/zkQLNyFn6AAghwXCbBp?=
 =?us-ascii?Q?h2GBS/eU7RcXAsMcbevgRM0UqXxfNfpJTOpIcGyNlfRwI7gPYylUC+rOrfDm?=
 =?us-ascii?Q?kIKtUQJrWoeezUB1mPYMCZn/uX4/sCcODPDaCOEL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fcb3d2c-225b-43ea-dee3-08dd09491003
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 09:52:36.6100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gdIk15F/dnjpZIBjltF4XR8CeK3ihMnkDKTs/rHVcePG6JYmXFHl9974tKgvFV9YAxNjl4XvHK44OJPVnWAGpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7522

The design of the i.MX91 platform is very similar to i.MX93.
The mainly difference between i.MX91 and i.MX93 is as follows:
- i.MX91 removed some clocks and modified the names of some clocks.
- i.MX91 only has one A core
- i.MX91 has different pinmux

Therefore, i.MX91 can reuse i.MX93 dtsi.

---
Change for v3:
- Add Conor's ack on patch #1
- format imx91-11x11-evk.dts with the dt-format tool
- add lpi2c1 node
- link to v2: https://lore.kernel.org/all/20241118051541.2621360-1-pengfei.li_1@nxp.com/

Pengfei Li (4):
  dt-bindings: arm: fsl: Add i.MX91 11x11 evk board
  arm64: dts: freescale: Add i.MX91 dtsi support
  arm64: dts: freescale: Add i.MX91 11x11 EVK basic support
  arm64: defconfig: enable i.MX91 pinctrl

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx91-11x11-evk.dts    | 875 ++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx91-pinfunc.h | 770 +++++++++++++++
 arch/arm64/boot/dts/freescale/imx91.dtsi      |  70 ++
 arch/arm64/configs/defconfig                  |   1 +
 6 files changed, 1723 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-pinfunc.h
 create mode 100644 arch/arm64/boot/dts/freescale/imx91.dtsi

-- 
2.34.1


