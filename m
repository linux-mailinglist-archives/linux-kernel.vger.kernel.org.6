Return-Path: <linux-kernel+bounces-214088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFFD907F39
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E126283483
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 23:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D5B155312;
	Thu, 13 Jun 2024 23:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="X9Kerwv7"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2100.outbound.protection.outlook.com [40.107.94.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF1C14D708;
	Thu, 13 Jun 2024 23:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718320172; cv=fail; b=UGfmXt8gHeuDrc9YhvdKJJOIXHMY5aoyQjIz8bXV/zrHRAt6CrOUYV3pKO0ULTdLeGGwfMTxFSyapx94SF615dui1IfekWSv5l3xrBVrMKTuPx6rvBI3BBY7oTLA+WUqiB6RF0Gqynnluoq46fmHQskQ8cdrYq7eVh4OAMRtcL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718320172; c=relaxed/simple;
	bh=0HZVmSqq9IZYKAutk17O2uMg7p5rCgUxVIA8iN7ibCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jkr5rxuhZA6cq14PDSNvgb0vKq5pi7GR1u9b0BsTcStYWxL2DzjBjvJ+hYdjrFRcFB8r56lMZvOnNLNQ5jDN02zjzDhBXpIA3F7UBJ2S3sloiRStM42l3Pvs/yooxjNd6xO71uGg7PYf2zA9k/vcBEVP9/7t8Yo1+TtSmlJ2+qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=X9Kerwv7; arc=fail smtp.client-ip=40.107.94.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQZ4P5cdQgPQQ7zmYsjxJn6bZbX35m7awqpgvD+0k0fB5czJ5WGo7S6+KdmifX1OhGfHEPESIVgLCns4KZxX1iOogcnZ6w3kXgAAO3MqCbxqUJrhUoyH3atyZk5g031mTRbaYrYJKkYc0vPLXnxrAYf67DXRpQr3fIDuSove86DlADZVJtHtv3EiMUc8Us/sBZcOpNo7wwUGwRyLhHtr+ZZRdV4VIGGFhmhv/yKQ0x2ZHPcdzhJJ8Kl5XNDs74mvSGi4HxnZXInTKmRFi8ErHLi6iTNPDE6Ezy7HzKYXVQL++YtoTw9KBXALKb6hi1RXfQJreTMtoxzM45p8G6JvOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pw/coa74cmB026jeGpdvn6mFTiYj7VOLFZgDkln3kWM=;
 b=ZNL7IFzX/zm3uYq02/aParaFriTWvXO0Gpw2vFGWl56bbCvDfV6UZo+q0vXDKIRUUacR58H98OY1rWt6RyTqE/BMJP7eJF1saBr7wyUdlN99+tMHMN9fiLf8AJM6PBytvLGUMsGa/myFab++r6uACE4jT3SNlD8qLdvijjJVJyRQox8IWnl5iaubEvu1wWHRDpgWCUqCV50+K01wIPPqRj3Y7LVDGHmA+PCW1aHCnEwfPS4rR0Bp1xOYUKv2vvNwucoUdjWItvIv0u+GgkDXEBn8OoWJbLYP3rVlkAm6zFl9x6KozTP4pjG9GwFwCJsjJ6XBMJlyM+CFwcKot6WAzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pw/coa74cmB026jeGpdvn6mFTiYj7VOLFZgDkln3kWM=;
 b=X9Kerwv7ocL0V3QAMNkjdf+Oo8sWoxbhrlYGo7PJVYJVaxIjpSQp6VVT2Ht/ygUzRC2e8GWf0i8uLwBC8Qoi6y8gsG2u9UWJvFL04Qb9ovKllNODN6fSA1PKB2nw3csvlKRK8GqUkTE+NQKBBVfBuGeBsxK7ThfmK3EC3LY3eow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by DM4PR22MB3423.namprd22.prod.outlook.com (2603:10b6:8:46::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 23:09:26 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%4]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 23:09:26 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	w.egorov@phytec.de
Subject: [PATCH v3 2/4] arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable eth phy
Date: Thu, 13 Jun 2024 16:07:57 -0700
Message-Id: <20240613230759.1984966-3-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613230759.1984966-1-nmorrisson@phytec.com>
References: <20240613230759.1984966-1-nmorrisson@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:610:e7::29) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|DM4PR22MB3423:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bf4e9b8-b0f4-4e19-385a-08dc8bfddf1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|1800799019|366011|7416009|376009|52116009|38350700009;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AMrFoeF6dImk0vxK/unWZsVUYUGv2A6FxCmCMKrkrE0beYoNZGDbQjDgVWef?=
 =?us-ascii?Q?BHFnr9czmzOOX9hP+TUSKBHxRggzd0LXLaJqIOdEyA+uAAyVsECFgULF8nrK?=
 =?us-ascii?Q?7YWeBgtLXddN5/TM0l4SDdL5LUwc+6PR6kxTLSvwtzX1ETq6WLgjtGDUeHXq?=
 =?us-ascii?Q?Xex6IMvyN0yJr6Y+qWa+dxvGnrunGADeXeww+NKCGS1HksWvpShYrJB+GuuV?=
 =?us-ascii?Q?z8quw/GXzUYx/kd2P4sJtg4jzh1YGnflv0Ls8HO276nhnFMzz0pscEVRb7xu?=
 =?us-ascii?Q?N5yUJ0MPQkP8muT0qqI5yoAMrHxOPaSwZiiJs369BHAtwXMhjtgbKfYEZYML?=
 =?us-ascii?Q?WgJEnne8flUxA8oDoLVeRwOp4UDIcPy1OhQGowge+ib0+yOlw/B5gQp924sU?=
 =?us-ascii?Q?yhOhnBE1Rv/ZIWGBXpXlEeLuLWHhxOecAyFhgvG0mDH2xmK/I+v6dWXXsUg9?=
 =?us-ascii?Q?zPmldBsKThOMi86uZspwPanEpp521a6JGf7Rs3CrW+1KRJPqOdSv0AppgSWv?=
 =?us-ascii?Q?vJ72iuPCTk3pOdsZpuQ94tuUxKKXq/9FuKbKxNK3Bkt/TO6bd5q71QRzdANS?=
 =?us-ascii?Q?8RctHCSqwJHFGa4wZX86umUR81mLQ48GDyGpxv9unl3obqTPnV4I5ifocfdg?=
 =?us-ascii?Q?eVC6YosJGSyb0fcSrxdvnsGAuLa0WZBiob4QW0A+Yg5caLZy6+sjAtYs5lRO?=
 =?us-ascii?Q?yuIEi377FTJ7WEmeDHP0MMELPIi7/n7waq69S742wtXXqnZVFhCEjuwDJZfs?=
 =?us-ascii?Q?7De9lKFdsyoj4JlX51fHpJ8xtzYHU0zUzWoiQvmJ/JU/2Y3mvjoKbrIxEmGh?=
 =?us-ascii?Q?gmec5cY27FKXm6kPHwRFooMBMK1+tmbdws2O7R+rEAkmo+31oxWPfrdlqqOk?=
 =?us-ascii?Q?svqikP7NJfO7JjWvfPrGw+wK5Saw7qNgios1zWDLliQI08fqbw0zW/RU5orA?=
 =?us-ascii?Q?jTyMYlt/IDO8MkpmPnVhSSKZhTu5xlJwmEx1hxUjNjQ+qAEMyMAKskNlAV1A?=
 =?us-ascii?Q?1ogNyj3fU+DgvEhrIWLWJqhOYp6Bs5bCwZgnLBNimaX4ISZ0T/uPUpmnRlHT?=
 =?us-ascii?Q?ZAugvwAbDiPMTbrqISuxH+9tSBUnd0wGQ197gG7QpmjF9eniUjnln2gB08p7?=
 =?us-ascii?Q?jnnH1KvwequwpnF7P4rIlw+KVrAV4+Ozbjws9jnwpqzPp1PCaqPz866adkpD?=
 =?us-ascii?Q?iiNe1n/vkBQkyNL2jOjG06693m9PKPUKiZd182lvghUZgwWdgpweA0KM4D2H?=
 =?us-ascii?Q?4cv8pTxU3ITDxe/JSgu6IXNcwEXoK4s/jP1nEN8+N3hj1u1rbYip3WCZumlL?=
 =?us-ascii?Q?ZBUeRBqkYnw4+p9whPxdE8fk4twaos7ZfR/h+vqkL5ORSK7uWxcI0icHtoHr?=
 =?us-ascii?Q?dnvG2I4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009)(52116009)(38350700009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AJq/CtJdC4pqXlTEVDBkIKnSsvR1FGyLipoENtAgId0ModrGSL7omKKkskCR?=
 =?us-ascii?Q?O37lyu0VIAxhdxh5NHBwNJch6hSAM+Ml1NSBRg7WrCg+/n9wvl3QauuviMsP?=
 =?us-ascii?Q?7y/fuA4t+UYoH+xLr7+p0IKVecHbqV5enmP+1uos70mib/5fbWxCYOd04njX?=
 =?us-ascii?Q?/lulX962R1ypYsSDkvJvl32Mm84cdn+M8+PptJVLv/M5Kpln0G+RaVhwi328?=
 =?us-ascii?Q?ukPKYfdGHlP1p8ZizVzh00PmN3UMkGJaAOv1WY62A0GQYFBgH4jfwb/WekyI?=
 =?us-ascii?Q?YdPaWtR9E8YGj0VpFjpXkrrRt/Meqq6J8dDnZ0QOWHnev3kfBFrkac7T21OE?=
 =?us-ascii?Q?s6bOfgoZOUQj3qjbTAKub6crAaTrn3mZPdX9Ztq9EXpa6NMx8UqANKpisalW?=
 =?us-ascii?Q?fWamLjHJM0FyhQj0cXdKaDqB+BpL9JPcpvUgLBAY/iLrsB9nkxLaYgQv3DXB?=
 =?us-ascii?Q?zm18oiBWjNlYzHfQFRWKJuOvFxoZVU7B/9IqbXdbsDx/XqIlBDbMfBRXAJCB?=
 =?us-ascii?Q?4eh8WGLg5qaQaggXdqaZxUGdor63rsVDQlsaaMXQry2oh9QBPNtuZwHQlmCx?=
 =?us-ascii?Q?j1iPmV2YbcceH0On12M1PWOWSz6pUnzXay/0biUJ5vrEMcGvQA0Asy9JcJj9?=
 =?us-ascii?Q?Vlgfl1XCS0gYjDFoleCVshhuHCgFTtGaYGisvZMi+bHbZuPUtJcDTEc2o4DW?=
 =?us-ascii?Q?I6HPwfISBicIV4ZvG7YZnTo4mXp6lAyccy/IqC15v9Y6WnSeXTgoaxNnqpAJ?=
 =?us-ascii?Q?pCAPp+oY6VK4YE8jxZSjYR4wVH0cLf/sJHpCrCOnGAvm4lUJnXodcHVzIxm9?=
 =?us-ascii?Q?klpV/nD94mavjr3m7RhvgAPFbGntuuDAqQdVz12DUhgIuVj+y3lTf0G39b2w?=
 =?us-ascii?Q?2vwxDVGXSKgf+ebvcBNTod/J3u4xfoy79LokCW3fjSlojc3IIf1c82jK06cs?=
 =?us-ascii?Q?FpTGKDUy7zCtUku5KW0gquv43YH3o3BU7GbTEFPvVt15lOhHX9QAHYT1SG5b?=
 =?us-ascii?Q?hwlVOQgsP6Lq27YiKuAZglZMFdNukbE/DwTzE4TmRKrGk0/1hmr8MQh7i6g4?=
 =?us-ascii?Q?cS0JIJGT0322KKuQ/ldSNksd87W973G3uEw90bagF8J+DnRIF86FZMrpsi5f?=
 =?us-ascii?Q?Z6YVr4zkFMxtoVYj2nZfAhGi3iB7xBtQgYajQFf2MvO7nWAHuB/9QxPeCkzN?=
 =?us-ascii?Q?qWXXpvtzhgIFMtauxOTuvLQjO8fZrAkQu+p3gF8J9vjKXWJr5EA5HTmGZ/3p?=
 =?us-ascii?Q?rKmpr1tY5qbsSdl9YxEmv3MlgNNJ2RYb2UZGILttGtrFMuCxQ6qGc5u4QNLZ?=
 =?us-ascii?Q?vxEG7mP4h975SR/1fuc8SNkuT1zGxE9f1/sAlSgo9HJXAHqcpd++9IcBVYsU?=
 =?us-ascii?Q?XtR9ahQG/C0In9b1mbwok/epjxea5HOp4qwLTuNxkozqJTf5VTanhPRKe70R?=
 =?us-ascii?Q?EkBCsYSONIaBiMaVghag27tVojsYd37YQyT4JF60jYWqVPDz9ahoIY2a9Ry8?=
 =?us-ascii?Q?h8qVCaXiVZk2dNOYsLXh+8ied8KFjHUqnmpM9M6Aa2tV1quULwT/d2M+92d9?=
 =?us-ascii?Q?JwDdPg51iTxI70eLyMRcWJ6dD7aXwMo1omSL9F4t?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf4e9b8-b0f4-4e19-385a-08dc8bfddf1a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 23:09:26.6970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QWFW1BTRUtQlMlcgA8IzVEFE4hUQkWqxAK/GInJ1M79nqM0FYtLwCEa4cXApq2DGg4+2xt05I7GxvLjyh2X2ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR22MB3423

Add an overlay to disable the eth phy for all am6xx-phycore-som
boards.
The EEPROM on am6xx-phycore-soms contains information about the
configuration of the SOM. The standard configuration of the SOM
has an ethernet phy, but if no ethernet phy is populated, the EEPROM
will indicate that change and we can use this overlay to cleanly
disable the ethernet phy.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
v3:
  - Explain why we are adding the overlay in the commit message

v2:
  - Add build time tests in makefile

 arch/arm64/boot/dts/ti/Makefile               |  7 +++++++
 .../ti/k3-am6xx-phycore-disable-eth-phy.dtso  | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-eth-phy.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 2c327cc320cf..320da5ea38e0 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -54,6 +54,9 @@ dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-wlan.dtbo
 
+# Common overlays for the phyCORE-AM6* family of boards
+dtb-$(CONFIG_ARCH_K3) += k3-am6xx-phycore-disable-eth-phy.dtbo
+
 # Boards with AM65x SoC
 k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb \
 	k3-am654-base-board-rocktech-rk101-panel.dtbo \
@@ -107,6 +110,8 @@ k3-am625-beagleplay-csi2-ov5640-dtbs := k3-am625-beagleplay.dtb \
 	k3-am625-beagleplay-csi2-ov5640.dtbo
 k3-am625-beagleplay-csi2-tevi-ov5640-dtbs := k3-am625-beagleplay.dtb \
 	k3-am625-beagleplay-csi2-tevi-ov5640.dtbo
+k3-am625-phyboard-lyra-disable-eth-phy-dtbs := k3-am625-phyboard-lyra-rdk.dtb \
+	k3-am6xx-phycore-disable-eth-phy.dtbo
 k3-am625-phyboard-lyra-gpio-fan-dtbs := k3-am625-phyboard-lyra-rdk.dtb \
 	k3-am62x-phyboard-lyra-gpio-fan.dtbo
 k3-am625-sk-csi2-imx219-dtbs := k3-am625-sk.dtb \
@@ -132,6 +137,8 @@ k3-am62p5-sk-csi2-tevi-ov5640-dtbs := k3-am62p5-sk.dtb \
 	k3-am62x-sk-csi2-tevi-ov5640.dtbo
 k3-am642-evm-icssg1-dualemac-dtbs := \
 	k3-am642-evm.dtb k3-am642-evm-icssg1-dualemac.dtbo
+k3-am642-phyboard-electra-disable-eth-phy-dtbs := \
+	k3-am642-phyboard-electra-rdk.dtb k3-am6xx-phycore-disable-eth-phy.dtbo
 k3-am642-phyboard-electra-gpio-fan-dtbs := \
 	k3-am642-phyboard-electra-rdk.dtb k3-am642-phyboard-electra-gpio-fan.dtbo
 k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
diff --git a/arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-eth-phy.dtso b/arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-eth-phy.dtso
new file mode 100644
index 000000000000..356c82bbe143
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-eth-phy.dtso
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2023 PHYTEC America, LLC
+ * Author: Garrett Giordano <ggiordano@phytec.com>
+ *
+ * Copyright (C) 2024 PHYTEC America, LLC
+ * Author: Nathan Morrisson <nmorrisson@phytec.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+&cpsw3g_phy1 {
+	status = "disabled";
+};
+
+&cpsw_port1 {
+	status = "disabled";
+};
-- 
2.25.1


