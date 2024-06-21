Return-Path: <linux-kernel+bounces-225466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD209130DE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 01:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B820B21D33
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 23:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2404F16F29B;
	Fri, 21 Jun 2024 23:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="GggQ5nhB"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2094.outbound.protection.outlook.com [40.107.101.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82CA8BFD;
	Fri, 21 Jun 2024 23:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719012727; cv=fail; b=RNQT1ntQT6JlJZhRdDMMgkzHyNCGlsP4ZhFnQ5NUXtdpPq/AqyUOmUZIwVNEeiCRvEVLxSUncbK9WTPhnwgnID9HFLP8KcptOj+iQwcrcws4GuIn4+Lr9oYwT6gPSVealFKMVfyjdAUDKusdk41C2nUTCjM3KZZuP0IJ5lVo9S0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719012727; c=relaxed/simple;
	bh=4z/AacUpBvk2CFMrcb/gqqJ6TDui2bC9wiqa8Lap7xY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uA+NH1VIziP414ZBhwOxVpvGxiBDoioKgZoZF5EJXiqXY+P+P09TYxHrhhcxIJKGmmZKOY1zHdJ2FjF2w+DQswrmcMgdnrk/4Til2trDyDACqOWbHD8ByVkLXU8f+VG3f8VsYt5Y4KgJT2xfQC82A7LrAO3kD7R7jBa3je7AVag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=GggQ5nhB; arc=fail smtp.client-ip=40.107.101.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5eQwR8CSvwK+bM7hL+fKP1wqqi7zbe05a4sI2A90+JZ5ZrKA6nGFgyau+gJqdE5CppxDExGWvG3/Wd0PnERTXIDqzSVYTpS48SI9sJ/Bj7YJzjGrWguJREZjEEbFm/g7FiSt2cd8z73enJfM4R9sABJsSzybvDtBZe3f4CWF5UDnUZKsBv/QlVrVhhdQGrpUBtygYBizbL9OQk3ZEnyK/5WIThbC2c1+tD/vJFKHIFCVRVPpjVQ1OB29mW/26glczU4DvBudT5TL93PEiyuW2z5ZYMG8FqF6jcm0bFi8QfvY7DK2M8p8D3DyEuLr9/WcanYGwB93+cCf2a38Cqtyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d26uXRTKW+ZmCXI0sI5z1q9E1k1oQdRkFq6N2JNgOv8=;
 b=BU4npu94JU80tlv/9CjVxo7j29BNp2Do2opmWEstQapMPF94/PyiTA4BzhqafZ/qmyhZ/9YSgKdi8+Whq8gmTx5EnTMthsndY6Sp3/tdbrjv4ztFmNQi2e/mUG+XSYUx0kwWU5MTvH3n9z7EMNQj/V7+Zc06BSdUiMciUOSswOG+vSU1sSvpspydCq8rXeRG8GMFdZ2nDsxMwXSQRBy71qOAm3zOLZQSB3j2iaZuylAC7O02I3ExD3buWPn5VQ0qhmgLlaqezlin7nBVOr+bUufWjer7kl8GZbz84JflxlG0gNB/UxYpFKsHq7N104PaYVofPTRNdByWL4kK/M1SqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d26uXRTKW+ZmCXI0sI5z1q9E1k1oQdRkFq6N2JNgOv8=;
 b=GggQ5nhBFpEPJQF3u8w5ulTAzrC8SB2bH2OHLYL15pCvQXOAIbTLxSshzEg/ygu6+QlWCLBc+cBGK7ID+1I22BojUPHZ+9lWnQZ3Kk+xfNV9xVGHADRQQGK+dDn7yPfHAQIjfuHugk4K7fsaLm8grb8uSJtc9Xv6DzXylxqfmaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by DM4PR22MB3577.namprd22.prod.outlook.com (2603:10b6:8:5c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.20; Fri, 21 Jun 2024 23:32:01 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 23:32:01 +0000
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
Subject: [PATCH] arm64: dts: ti: k3-am6xx-phycore-qspi-nor: Add overlay to enable QSPI NOR
Date: Fri, 21 Jun 2024 16:31:43 -0700
Message-Id: <20240621233143.2077941-1-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:610:e5::11) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|DM4PR22MB3577:EE_
X-MS-Office365-Filtering-Correlation-Id: 17582c89-7939-4417-5baa-08dc924a5a01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|366013|7416011|52116011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mIhW8RdpOZEKM3ckHApwe+IXcmZ6++nMQ/KY62s1gridKIv6m7wxpqBpZLTP?=
 =?us-ascii?Q?qJBp89D1Og8qgazn+IhB3uVnrkeSRdXj6iUa987TyprHQZIMMvyprQwC+t8F?=
 =?us-ascii?Q?4AmHdQBTmw4v0GITVTvY/DXRDo3L2RBMWM37J8XwD0FOCrkIQIN/AqhDISN7?=
 =?us-ascii?Q?wVnD3I8Mz/Tzos0iNljMaWztb9iyhDFRUI4HABodk7n65H9V0xY5ZkEoy7fS?=
 =?us-ascii?Q?sVqMmi2pk8K/nij+UwW9/WyhHNm4fmM/Rq1tUjrTnmJ6ZTjPCGI4PsjoT4QD?=
 =?us-ascii?Q?mWn9uAraHnlep2IG6v0xWlC9buVkZe+A4IWWOpuH6yGY400QvBaSHmHF8oF+?=
 =?us-ascii?Q?+TPNez+0uAdEaDlUYsLZ6+2K7cvOh8jToWIz0RtF/ExJ43Y1lKO6x9xWU2dw?=
 =?us-ascii?Q?sZlWsVYAH6eMcLBRVdYtOg2LHGAd5gpvhv8wXerFxWlBkPsbq/kMrRiFVeoI?=
 =?us-ascii?Q?w72HAerolfRxhjKxV2QryYjhzO6IthuZXSeMFVlr9YV4kVWT1gUejYCf7Uy7?=
 =?us-ascii?Q?lsgYy6o/ROO6CSprCexN8d8oaY8tGCNfN/sRF+GRqZ1/JPdALLOoD1qzbymL?=
 =?us-ascii?Q?FMJkBbNTLKIXxDzD6a5zTwH/lIg1wzKPe8k7dhJy1nAGRlWSNfxbEhUO5X6S?=
 =?us-ascii?Q?UtDNyql9/8XDjHDsrZMQY7b2Gp6IQSxzPA7dn7w9FTtHLFxKksnuHmsMn6YV?=
 =?us-ascii?Q?u74Dg58czqGVrddjafHiraezVVPw/NrNV+CO6obujdnjLO8DDQ7nhm2yjbDI?=
 =?us-ascii?Q?ehfpLxcIJMDuvLovYk63Hky63IJnvJ2PsTSgYuborjibnZxxthpV5Wn0Asel?=
 =?us-ascii?Q?qX9OdR1S7befyM7/1Y6Szw7r7Y5KOityv+mMn06OdsHMZG7lkNG9MMvqPJbP?=
 =?us-ascii?Q?toYd9v0obHJ1CcR9Kn/QWV1XBO3x0SFirtA0XU0VoMtX6F+yiaD0WkTJGKCC?=
 =?us-ascii?Q?f1uc2vxnoO5pMVVXEm2R+9nb4rmFCa6yhzKjphwruaUF1L3KpDc+7eG/Syqi?=
 =?us-ascii?Q?9nmOyY1YywXFmjCjtdYNK3A25bivTsg1pETcysAm6JNXQ3INQth0atITHx17?=
 =?us-ascii?Q?sT5/KGGkfY35zxLTE/LEbPWwiIu8jPrAYKGh2OBwI1U1sZmaSyZF5V6kSRkJ?=
 =?us-ascii?Q?yYwUhlyf6v5llLrZASC6qJna3iPwumRJRwdj0pldXXbT2K7JaVHeMoNXh7rx?=
 =?us-ascii?Q?9pIYw8bX4YjFpfrTRToDwVxxoeiyQd43J1i3yGKkmls8TKQ5ZUFnVkgtfcye?=
 =?us-ascii?Q?OvYT1FEXMOEwapDPZ9Z4itja1+wC3zMYqKfSR1I4yuJvglfpPFk5TDz05qHN?=
 =?us-ascii?Q?vV97/1G1Tly+YxrQlT74nD0hMG7VXVY66Cyjvq0WfXpfZUg3ceuuuHp3gYWA?=
 =?us-ascii?Q?TI1xZq4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(7416011)(52116011)(1800799021)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iW3PYj/4Lw3qFFZy4SinJIxEOZ9awD5rCMQ+FngfW+lV2HfYIBynHFzoKWaB?=
 =?us-ascii?Q?i00f6zrdJFd1Om20/xc5ijV037N8Jf+8HDeEeju5lUzDG2mLixOYsDaPiFfL?=
 =?us-ascii?Q?NI7BP+4/PoL6BEHhd7Iov5KkQZpzNjRfYsSpPfSHqbS+XceHUMdZ1CKYScsh?=
 =?us-ascii?Q?DrFBjMplgLiUHAmW6laOOvP8YiBs+Bp8ODPZus1ScTtBJutYvZGJMFcpMISO?=
 =?us-ascii?Q?JJGCnKQ4Gy0ixQgc25JCi/3jyf8xnLeFcUJ/YKmqDDyBQ35grcby7DWHzfwW?=
 =?us-ascii?Q?aVfkZcaTy+gNOHneC1Tzm8GRQwmERpSJec7LY3gw3E8bwHgDv0cM5BJ4xdOc?=
 =?us-ascii?Q?y4r2InZn2dMtB+JNvytm3x/Ew+uqpMKsygogOQPXwQN+IuWfVA1oXB+ePvt3?=
 =?us-ascii?Q?iYMbB9F1nZrCqnNrnoyGhulpJGLzXI2jZwG2w+vxPHtxmF1PixqmO0yWueoX?=
 =?us-ascii?Q?FqPDLkwb6qULDGEVKsXlzXMieNatPSawv0L5Zv2KXjVIdsWVv4Rl7ytYUdFG?=
 =?us-ascii?Q?onY6JOCcZ3LzrVP4DE+WZrGAlB6jYko1lt2QNfTC2GLcu36TuQHkWkbZfwvG?=
 =?us-ascii?Q?dIAwxzon9hs/eM6goHRTpLArZ20RhJ+eH7tcPCDrktNMg1tJti1ENizLgKAt?=
 =?us-ascii?Q?73Vp6J54X2kDwNmscec8Cr1aax2swykJGDoIpvJ2aRCLXXBAPGYpgDNy3mA2?=
 =?us-ascii?Q?+0VSSBMTWZvf0g0jwg0sXbNN3i5EwtA3gvRAnNbF/m81tH+VGusEV7o6HRxK?=
 =?us-ascii?Q?ikWyP/cfNGmTHNA23lYVziXaK5Pc24OOcAjA9QWfPjM+OkFLxz2L2m6ZqLrp?=
 =?us-ascii?Q?zvlckcNBWvUKnCxXuTgfFxtsvSyVnzalqXQVg0r+pBtq+e6wkQBU2rECrfOX?=
 =?us-ascii?Q?WVXfhOXSU9oiRMR7Dl2corHmTF/0DgJjrWAvl+PbvDjrgQuycShele+QtSvg?=
 =?us-ascii?Q?NYi0xTDi/aUpy39yTBA8lim/o7mJ+hzlUdBE/AAvuPB/BicueTkdWxJK7qUM?=
 =?us-ascii?Q?TiLYACZEuBnLbAJf1ifeIfajTUDYU8LjwL6Ti9onrdGO4AcTJjYPgCU8Nr3l?=
 =?us-ascii?Q?q+QPoTNirVCmDu7mB2fDm1LfFRLaTzm1UZkWQed/zM6Gt/yOXRv2EqNIoyF0?=
 =?us-ascii?Q?006NsdCDW333BZonL3CXGa8v10bLrbfkzI+lz8PEoSVtlQAGgjjwBzGIqReg?=
 =?us-ascii?Q?7MInW8Ipsn/NDkrJv0Nfv3E1htnqn/kWO15/yTQJ1pjTPz+KTZRoQ7anYbpk?=
 =?us-ascii?Q?moSFJzni4OtaWRaCJZqVFLuJliiL63WkmRlEc/o2H8YwqWYPTZ9mAhpSYgJc?=
 =?us-ascii?Q?xgnzUTZbNhUoLYMEc3Ef4MQa6VLgwwplMkLMbaqlbneo+uN/zfsGC5y+LuyD?=
 =?us-ascii?Q?bG8gTSnE2/ikzUpldLI9IG9vWykeQ7mEn8ZsOehS4v/Kq0LZgkIEIszdV/rU?=
 =?us-ascii?Q?K6pa28eFZdxI6/NwsexjZHkZcJn+eb4WCQdy7CurEmeAufaZfXrGMbnNogi4?=
 =?us-ascii?Q?IAxlN17N8zwPhOmD1hvd5ghWaS4WuK+y8CPASZjqOZicmGUNbqz/rZW2Vz3+?=
 =?us-ascii?Q?oVztrHiiBzMQr7DT7Fi2UgDd7rEPflTb3A0oqRVl?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17582c89-7939-4417-5baa-08dc924a5a01
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 23:32:01.6738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdSXBI/dtMeepCjHmBHaI+ghgDsN+9ogz8/CbrHXdzimADaLDiyOx6uk6o/mG8vpNP4/t5mBRSHEnspJPmf0Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR22MB3577

Add an overlay to change from the default OSPI NOR to QSPI NOR
for all am6xx-phycore-som boards.
The EEPROM on am6xx-phycore-soms contains information about the
configuration of the SOM. The standard configuration of the SOM
has an ospi nor, but if qspi nor is populated, the EEPROM will
indicate that change and we can use this overlay to cleanly change to
qspi nor.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
 arch/arm64/boot/dts/ti/Makefile                   |  5 +++++
 .../boot/dts/ti/k3-am6xx-phycore-qspi-nor.dtso    | 15 +++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-qspi-nor.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 8d8fc8bfaf7e..f0ddda064f08 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -58,6 +58,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-wlan.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am6xx-phycore-disable-eth-phy.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am6xx-phycore-disable-rtc.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am6xx-phycore-disable-spi-nor.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am6xx-phycore-qspi-nor.dtbo
 
 # Boards with AM65x SoC
 k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb \
@@ -120,6 +121,8 @@ k3-am625-phyboard-lyra-disable-spi-nor-dtbs := k3-am625-phyboard-lyra-rdk.dtb \
 	k3-am6xx-phycore-disable-spi-nor.dtbo
 k3-am625-phyboard-lyra-gpio-fan-dtbs := k3-am625-phyboard-lyra-rdk.dtb \
 	k3-am62x-phyboard-lyra-gpio-fan.dtbo
+k3-am625-phyboard-lyra-qspi-nor-dtbs := k3-am625-phyboard-lyra-rdk.dtb \
+	k3-am6xx-phycore-qspi-nor.dtbo
 k3-am625-sk-csi2-imx219-dtbs := k3-am625-sk.dtb \
 	k3-am62x-sk-csi2-imx219.dtbo
 k3-am625-sk-csi2-ov5640-dtbs := k3-am625-sk.dtb \
@@ -149,6 +152,8 @@ k3-am642-phyboard-electra-disable-rtc-dtbs := \
 	k3-am642-phyboard-electra-rdk.dtb k3-am6xx-phycore-disable-rtc.dtbo
 k3-am642-phyboard-electra-disable-spi-nor-dtbs := \
 	k3-am642-phyboard-electra-rdk.dtb k3-am6xx-phycore-disable-spi-nor.dtbo
+k3-am642-phyboard-electra-qspi-nor-dtbs := \
+	k3-am642-phyboard-electra-rdk.dtb k3-am6xx-phycore-qspi-nor.dtbo
 k3-am642-phyboard-electra-gpio-fan-dtbs := \
 	k3-am642-phyboard-electra-rdk.dtb k3-am642-phyboard-electra-gpio-fan.dtbo
 k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
diff --git a/arch/arm64/boot/dts/ti/k3-am6xx-phycore-qspi-nor.dtso b/arch/arm64/boot/dts/ti/k3-am6xx-phycore-qspi-nor.dtso
new file mode 100644
index 000000000000..969dfebcd637
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am6xx-phycore-qspi-nor.dtso
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2024 PHYTEC America LLC
+ * Author: Nathan Morrisson <nmorrisson@phytec.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include "k3-pinctrl.h"
+
+&serial_flash {
+	spi-tx-bus-width = <1>;
+	spi-rx-bus-width = <4>;
+};
-- 
2.25.1


