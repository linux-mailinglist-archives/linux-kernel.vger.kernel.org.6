Return-Path: <linux-kernel+bounces-214090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71682907F3D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E31B728311A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 23:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A67C156652;
	Thu, 13 Jun 2024 23:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="CvMvjDLr"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2100.outbound.protection.outlook.com [40.107.94.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F48155A53;
	Thu, 13 Jun 2024 23:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718320175; cv=fail; b=tAM6m6EwJaSY84UE36du/oCAQ49agKOPysqxam1W19pgns8xuoWu3LIV09wS+yZYeeBeeMe2mFZr2qdZlrEOyhOgu367JA9Njg+VNjP95wG7CoBkOE/RXxP8CSSJtSYqvwhjlsLjMIeDJ9tpq+LTOWj8CTWAkcbJCmPfNkQEhzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718320175; c=relaxed/simple;
	bh=4oZXwEDiVyLO+9N0qDy5i+1bfow2trWq/3Vq/dBY5eA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KHuUsw+ivMR1K7TK/DIJ7cdFQKvl1N9iixnTa1IkgrMg4PowqQU6/8INRS0uro+HbIKXDa2sPGRrNsA+6LPUyKZoWkJM0ZMT9BTxaVGTLbO/rD/WolYAhc1qiYKhtzIUwpLBhPvFPb+6vlj0rAkQx6bQzNnhEbPrLiBN/LGGO6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=CvMvjDLr; arc=fail smtp.client-ip=40.107.94.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mv7Aq7WrimvncS8bOurHREOCxsc965IniHUuSiUPWXj4Ok8Bky7AElR5qEpWU60UnNwo3vXeAzgFbNyuT1d82z3isdvq10e6IZ1ZDKC10cHq9IJvFSsksfDxvY6o2yDCRVXjHMu8vDlqoLj2X8dWf11sQ2RGvQmDPmmmlI5jxqBqMvHuN57/TIClEzJiFJNbl1jJJYDbaUPnT7Py5HBydQtEG+UHumzwDiDu/VlDcwEBGWPqIbyi1fWa92NwSPPZsBKK4GlCav/Qb7w+YAHjXJ9kZx8ZgzlNUmU59LYO/Pp4kvs7p/BqJMIKXd3M2ypQ7cqALEI0HXKLzt+SfSsyYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVV2UPhrcZq6BZwNL3cLfOxS7NTppWhGYN1Qfj7Bl5U=;
 b=mKP8YD5HtQwH3Em8iyQ2zpMmkaZcz64udNPsX/RHRnB/vUbqJxRHfRoekeFUsZrFT76zw6T/YMgyj9KH+rFCapqg8fcaZNvwe/C18cM/1WOPwXUAIc1QkxPtSHw7+LPF+EaT88x4nFxybDYyAfzr8rWsi30dF06ohokkKNVWZv8KzpOHbpiVIVys2C0eGRuYScKqO96gFdOGGpARDcvUN7ncoQJpBxZiHBoRwF5hQgRu1SifPut2M9bdKZDg+y4x8iZ7B4asiiuvHPosyUYxhBrGiMaQUHcBVZjt6J+4Ws0uY/tEgoAJnxmY6YbR4uaGXWIvRE37sBRiUWPCLfW55Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVV2UPhrcZq6BZwNL3cLfOxS7NTppWhGYN1Qfj7Bl5U=;
 b=CvMvjDLrztFDQP82BVz9+ujzBi5IQJ9v+5NlC0IPHk1lSazyMA7XhvUbk9kZ8u5Lt8YcLkqEVgZ8K2AwtP/CnB3c5YT2Os+iVYmOkrzisj4+bgPM/tz08InFgfGV48Wnf9ILVw5YsaPlX4111/fkXVeGjoQucGfPoUtqHmv8sbI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by DM4PR22MB3423.namprd22.prod.outlook.com (2603:10b6:8:46::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 23:09:29 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%4]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 23:09:29 +0000
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
Subject: [PATCH v3 4/4] arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable spi nor
Date: Thu, 13 Jun 2024 16:07:59 -0700
Message-Id: <20240613230759.1984966-5-nmorrisson@phytec.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0ebdadaf-841a-40ad-4932-08dc8bfde0d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|1800799019|366011|7416009|376009|52116009|38350700009;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TgOccfOsAvsW/1cy+NaCUIRfDwrEfg28i405W3Zc/YvsSyXAxXQHr0I59a1i?=
 =?us-ascii?Q?Cm5ZmAyEGHmuUZJKytuxZyCsrPXlIktxNgiRliPju+wOaoY1NB5sbqKvpybc?=
 =?us-ascii?Q?6nqy6CMGTQbD2L2VLd1aWMRKappkdLJs+QqO5MjVEj/b4tK1x9Sih8DCbAF1?=
 =?us-ascii?Q?6hhyZ7vJr4LBcx/FUnRnmb1EljMLaR7R3SmAPOJ1RLLttGduCvIlKsfAsZ7C?=
 =?us-ascii?Q?YOnEUvygg5O9UZ1d9Jd1U2YIjfMAvBMHuXpX++iddtC9HAbNf0owZimOWsFN?=
 =?us-ascii?Q?PhY65dEMA4S3pEGMoyF9fqofTEnHVfObqwO1HCcJcIMFWC+DgCDCfxZMjru7?=
 =?us-ascii?Q?qhftqz2hq/zLchyI837mgqrctwCdmP4HosQ+5dHO5fogz9+hGBlyRvtwiWdz?=
 =?us-ascii?Q?3YOkmgvkd+0uPiWC06if0qY+z0s6E5TY6sBmzKQep9+i6zKul0FIHowOFb4w?=
 =?us-ascii?Q?8YhVeI3jvA+lTyRQisM1rD4QeDuZJaxUTuR0vNb3+NcNI+lMwiKHJvtU6HBZ?=
 =?us-ascii?Q?p3DmiGvYXtguT2t2fnmqut+cUJI/dyxDwf/WtHEs7MQQdnPSoUdVdsF2Pa9k?=
 =?us-ascii?Q?3aDA1zzilY88tfYC/8zkGgZypKiUmdCVEptH5e/TJsqStGEgwXbcklDQqxKM?=
 =?us-ascii?Q?qOmn1GLbh7hXPCn4wnVj/oSwWUMsCSEsIG3iJW4kuwtZMEwU3kehpmAOoF9E?=
 =?us-ascii?Q?yJ2JTk9WCoqi1B1wwJtTTGKa3ojOC3zfQyeJoDj58Xqs4YCm85VH6Iyo0dhp?=
 =?us-ascii?Q?JxuHv2VboqpDVRi4ZctzSwsejdqVi7LPcZJsrBk0VlPaxwasFJKjECFktxDa?=
 =?us-ascii?Q?th/Ak1ShRQyGUQ7nNNnKY1oAxcKO4SHeYP3h2xapAnUApJcihyuwNrp8Yde2?=
 =?us-ascii?Q?Q9eYgm4FJ4nye5SoVaaC3+neac79UsidqYPDa7fKEOCI5uvzNssd6MjdPpM/?=
 =?us-ascii?Q?MN+QzofifjlS6S2mw+js/EaE10Lvqb4vABhUVa+KXBL2tJhpDDFs6bVJaHtc?=
 =?us-ascii?Q?ci951wNUiduXGpDIN/HcWkq1PnhBW8yytcWtoTHwjMJvR1duL1nYrwVVjetq?=
 =?us-ascii?Q?mGwuTNYAcBHjur9mKVAaz3K16w4TWEmEKuN4NjaP1oNR3ABQTplpu6sgHDIG?=
 =?us-ascii?Q?I5B4EEffesh1z1HGYZocbrdrUyEFcVB4aoHGxSQz+retLj5bhGXG+7/t/mtR?=
 =?us-ascii?Q?JZLnH2EnMeWiIhNQyqvTF1VTkxACGJV5m3s8uScMx1uZ+lKs2ynYkEm9NK8y?=
 =?us-ascii?Q?QlTvnuPBlIEON3n/K/rgnOytk4nOp4Qk0ZU+ijXThD2EMm39tewK+3iidxsu?=
 =?us-ascii?Q?+mdD+gvjYlh7PG8WyLXNIhItgutsqqb0S6l97BCGRwkZbFsm1C4leIwUmTyl?=
 =?us-ascii?Q?jaDpSUo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009)(52116009)(38350700009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/xwsrjmEcMGu07GSbpVeA6u2YDtbCZ7ohHCJ/Nwl4XYqaqnUH8vlfaEPebcZ?=
 =?us-ascii?Q?d5rApZsqp77f5q9Pqj9KKDppZQOA9g2+nov6zjAVs/fyRuPBpQsytADlRo+J?=
 =?us-ascii?Q?JydwT93SFtJpm1t0rQTdsWuiBxpyToiaH2Zlg7Sa1Fu2UG3N4T6DB9wPtY6U?=
 =?us-ascii?Q?UiAgcs9ojVG3AGFcIcv/mTWFW2hQUrOW2MyVlfN8NfYf/7FE8Qd4Fnd34VDa?=
 =?us-ascii?Q?MuN6cb67cLsUNVBVMTFez93PH230gjdT01iAKatVk24X/e1vks/y3g7iN9vn?=
 =?us-ascii?Q?nG/7tiUuGAraUBr/RIuM8ugiQQCbdOss5KqgZsDXBkuvXd7PqeYCFdnX7zm3?=
 =?us-ascii?Q?DMjQQqgsSw2nNPyTsrzgN1IEn9zTxiBEHFHKpMA/LxRmFD62pjCuduhYoTx5?=
 =?us-ascii?Q?XQMmgKe6Y98+JmGKzhGTDLKtvdHUUxJ9XWh+dPOJ41L7gTPh3exYhbLTn3Fb?=
 =?us-ascii?Q?QGGnp0thJ83R0hMDsrQOdcNSJ3+iHJW+tK+iHXnxhphcB+RRuiCOmTVqbmzN?=
 =?us-ascii?Q?q//t0Cn+VWWKI9iUe9Wkwx5zgN0kuM53NFOy2A8arRVrCc6bgK+gMyli3jqx?=
 =?us-ascii?Q?UwA9SCUoioneZrWh/gkzhZKKaFFZq03j9b+NULDgGSegAjxB1tUASz9VZILK?=
 =?us-ascii?Q?Dv73seVlzhaWBu6QpaGetAG6p5WS1QGMtHHbvBSHahFWUDXTfHSWVsOhkuoA?=
 =?us-ascii?Q?SEYk4Ml8rgqN5wMkvwCZpo2S/5ucX5HcKgNCGfLBqeXkZeaqePM7KmIsoqJV?=
 =?us-ascii?Q?6+ZTV58elWmafdgA7LyyQwqXR70+ApS8kNFuwm4hYNzsvTNPBFSjSYU/p32C?=
 =?us-ascii?Q?EFyfl9Slyl6N/TLc7b+OLjefWC90R9mbwuQPsriEvJPDL5KwHPLikhP+BZSt?=
 =?us-ascii?Q?zNuYj78+eooeE2LsmDfbC3KtEbnoaQGZsIyqDuMwp6q9xxKaqE2Yi/kf0BGM?=
 =?us-ascii?Q?gD3g7WB8Qy4WZVoNlIR5Jsf8Fp53SZWoVx3G7JfPK2V5m2YTfvvFd8cdWIYG?=
 =?us-ascii?Q?7F5APbOJUTEKbMJF7qHIJCQvsgzcpxoqttCxMaWXCwc0f8Sk4BMCxEnJfVfq?=
 =?us-ascii?Q?D+N3HSGArYtT+bjo6paJzFRveSF3dAeZVuPEKbjg4c7NLSIoWRndWlAbVs94?=
 =?us-ascii?Q?GQQy+E030h9VwyeBZc6rLUSimFuTnRp9Bx4z3gvxmzjQ4BwcCURvR8nTvkNC?=
 =?us-ascii?Q?9Xq6TmvLBL7Gv3CkcgxFI1bCAX1WMoNzjqa8823Y0FoI1Xx8c3tyEuJjq5cx?=
 =?us-ascii?Q?yH97muRNEtD31zfdBhz5T8Js3nTai7Isbsqte7VeLEcsb29nONDJ46vegFAo?=
 =?us-ascii?Q?1UG0JzE5rB3/zIVvLnh66liUH84Ci0bXeTSfAHIFrPTcsfmDd1pB3dMup0d8?=
 =?us-ascii?Q?exbaOSZ1aBZ+Yo1HTPcLLs4IN9LijQZnVEvIRBeSx9DCYxdwm9UQxPlWrp3Z?=
 =?us-ascii?Q?kpCG/hRpGbE8Jaku80F4xmjpSTfL3mTILODBy2VMvD/RORAFQFvT9g3OuOlN?=
 =?us-ascii?Q?iRhH73E711crP0L7q5pQLydc180A/CPfW7PPvVQSOkNXPfm/cyjke/p1Tdu1?=
 =?us-ascii?Q?4jqmVPbI8DylSALMScmE1MV1bHatZnIAz6Xyj7OI?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ebdadaf-841a-40ad-4932-08dc8bfde0d7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 23:09:29.5991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BU+3A9DJumzNZyJN04w7fkb6iO659o2n1fmBvAcOML/22m6RYnnEe3uHsUEKMCTVA/Z/fKqaqlNVR+vf+R43kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR22MB3423

Add an overlay to disable the spi nor for all am6xx-phycore-som
boards.
The EEPROM on am6xx-phycore-soms contains information about the
configuration of the SOM. The standard configuration of the SOM
has an ospi nor, but if no nor is populated, the EEPROM will indicate
that change and we can use this overlay to cleanly disable the
spi nor.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
v3:
  - Explain why we are adding the overlay in the commit message

v2:
  - Add build time tests in makefile

 arch/arm64/boot/dts/ti/Makefile                   |  5 +++++
 .../dts/ti/k3-am6xx-phycore-disable-spi-nor.dtso  | 15 +++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-spi-nor.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 3d0e87a78e09..8d8fc8bfaf7e 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -57,6 +57,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-wlan.dtbo
 # Common overlays for the phyCORE-AM6* family of boards
 dtb-$(CONFIG_ARCH_K3) += k3-am6xx-phycore-disable-eth-phy.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am6xx-phycore-disable-rtc.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am6xx-phycore-disable-spi-nor.dtbo
 
 # Boards with AM65x SoC
 k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb \
@@ -115,6 +116,8 @@ k3-am625-phyboard-lyra-disable-eth-phy-dtbs := k3-am625-phyboard-lyra-rdk.dtb \
 	k3-am6xx-phycore-disable-eth-phy.dtbo
 k3-am625-phyboard-lyra-disable-rtc-dtbs := k3-am625-phyboard-lyra-rdk.dtb \
 	k3-am6xx-phycore-disable-rtc.dtbo
+k3-am625-phyboard-lyra-disable-spi-nor-dtbs := k3-am625-phyboard-lyra-rdk.dtb \
+	k3-am6xx-phycore-disable-spi-nor.dtbo
 k3-am625-phyboard-lyra-gpio-fan-dtbs := k3-am625-phyboard-lyra-rdk.dtb \
 	k3-am62x-phyboard-lyra-gpio-fan.dtbo
 k3-am625-sk-csi2-imx219-dtbs := k3-am625-sk.dtb \
@@ -144,6 +147,8 @@ k3-am642-phyboard-electra-disable-eth-phy-dtbs := \
 	k3-am642-phyboard-electra-rdk.dtb k3-am6xx-phycore-disable-eth-phy.dtbo
 k3-am642-phyboard-electra-disable-rtc-dtbs := \
 	k3-am642-phyboard-electra-rdk.dtb k3-am6xx-phycore-disable-rtc.dtbo
+k3-am642-phyboard-electra-disable-spi-nor-dtbs := \
+	k3-am642-phyboard-electra-rdk.dtb k3-am6xx-phycore-disable-spi-nor.dtbo
 k3-am642-phyboard-electra-gpio-fan-dtbs := \
 	k3-am642-phyboard-electra-rdk.dtb k3-am642-phyboard-electra-gpio-fan.dtbo
 k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
diff --git a/arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-spi-nor.dtso b/arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-spi-nor.dtso
new file mode 100644
index 000000000000..cc0cf269b6e4
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-spi-nor.dtso
@@ -0,0 +1,15 @@
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
+&serial_flash {
+	status = "disabled";
+};
-- 
2.25.1


