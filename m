Return-Path: <linux-kernel+bounces-172512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CE68BF2E0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0171F1C2093F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9774684DE7;
	Tue,  7 May 2024 23:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="aiej8dTH"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2117.outbound.protection.outlook.com [40.107.236.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66038248E;
	Tue,  7 May 2024 23:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715124200; cv=fail; b=NC5YIPsru01fQuxZe8EESR1tVLAQTADxT/joWIirL//yIJSqYUxraBIu4x/ycqZ7kaW+NvCcwLNnED1jrNV432xGE5/s8WOc2RT/ETtKSeGuftxXPlyD/gMFgQXSIPakGJPBmFOBAkluXaCgoqmxOWqB//ztHxWCLH/6emCHv8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715124200; c=relaxed/simple;
	bh=M/IqJqP2cb/9tDZQki0Ksb3+sbpD7nPPnlaePynxgEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tIDe055AFNSHikbskubSSZMKi1z5NXyctpgC06nZJvfESY5nm9LA7pD59NpeOO2O3FdiIqyJcu5dMbqM9M4k0OT3MNHPFglR72CrB34t8arIbMcervifvKxXozHiSGPTKsf0Kla/PthKqeNjUSfwElQEDAkNaOhTxhOpRtcQeC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=aiej8dTH; arc=fail smtp.client-ip=40.107.236.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oF/xKfabAilHGpkEYzs/6VDHgmzbkbPOWza1s5NL5BNeCltt8ZEPVfCaD5bFhZpbISZf1qKLXBs5Q4elf7WKdzs+akMDV1MIiFbjQ3RwetjjEh3+LqVTbAcNgt3FB9luyToTNeGCYgFPWgT5viXw9+oOxnsxpfjuPid3d+RXRuXnFKZQ2a2z8amrYFlQYVJjVWjFdXlxlsuga4K73neQJFOcgbhKdvdvt4fZ9scxk1EMCd/rTuEEoLn2Q5zM7sbwYRHPDLCld44kwzWf4RAEHnlK4UpholkM6dhrwddruJttzeJxaO87eXf1kMhzKV8Avmb1sznHXluGHtksyoWclQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmMvWQd/IEnJv1fFiYrCqI8aHeaob3Eik8lAJIoMXS4=;
 b=l5WfnriUKn1s9AeIZE2I4376tJOILIZtW3mn8/e+Kj9rnKt/teiub/xtS5oMQsXI7I6nwWjTpZynx+1XZ6DBoiQRBJDpKHzd/62YFWLY5b6Un7S9IALSIPWX28f1WSSLKDo683hqlCfvdXHYT8uT0PnKI2zb3HZ447c0qJOSRivGt9KP+qC+mwLyQ3vVJgwfEh/E8+QzpG9LR5H3ohFe47aSCeM/vsafxL/1u30vdhuFXnReMB7tnJscWveis4slLVQOqIW7whwKqzMoQHKYxOm/IcZLIwdyFXDLubH8kQMshKpT4BAWx95xRduCL5Sd4hMADAYGLCHHhDBYPwVuyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmMvWQd/IEnJv1fFiYrCqI8aHeaob3Eik8lAJIoMXS4=;
 b=aiej8dTHBKonCPDhMMQVekSVYpUSXOHW9yyhIlEAKHMhMCOH7DNSlXD/191KR3xdDMFCKICtqUixULRbibdRxqAUA5aSEnyv7NvNrSPAdaapLVihTiEFE+pZLxjeqg7xkRh3RyYzzSqs8yocNQs2XcJiplfYDvncP+bw3AuNyOo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by PH7PR22MB5374.namprd22.prod.outlook.com (2603:10b6:510:313::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 23:23:12 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 23:23:12 +0000
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
Subject: [PATCH v2 2/2] arm64: dts: ti: am642-phyboard-electra: Add overlay to enable PCIe
Date: Tue,  7 May 2024 16:22:56 -0700
Message-Id: <20240507232256.2865168-3-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507232256.2865168-1-nmorrisson@phytec.com>
References: <20240507232256.2865168-1-nmorrisson@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR10CA0004.namprd10.prod.outlook.com
 (2603:10b6:610:4c::14) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|PH7PR22MB5374:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ca548d3-5c64-406b-43ca-08dc6eeca9e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|7416005|52116005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?limroFdRTViS/BwkIzOV/7aidxXh1ETKKn3PxBrNxDYjssZu08UY/IeMD/X0?=
 =?us-ascii?Q?ZxYjOofAvRqb9Exp6cxYSmq4AcmW1u5ZkavXAVqGKjG1KX679y4L/slch3Sn?=
 =?us-ascii?Q?fMEC7js71WSu7WeHFqU8efd/X24eSCyGWeBUWJVdcsPYjc9m0pGU9ZduELQX?=
 =?us-ascii?Q?yC1cT6l0E18qiErxgX++IDpe7TqJbE7mv9rqOnAxcAEjRZ3FGO+A6znYulb4?=
 =?us-ascii?Q?hctvfz7THD+qIjIx+j6YY1efNLRu7bDhtLBZLarNCNfXHl9STCQJOlyZdk+w?=
 =?us-ascii?Q?PiPTZLkgDzYsAl8KTJzj4h7Eqkpe8CKG1if0+Xa9i1m2oCRttUQ9WlmLZgQe?=
 =?us-ascii?Q?hqSqCBsFdF971ZyuzGrpDSa3BGx6CB8WE2y/xs9ATwF5kM+0WpdCRfL5eqVT?=
 =?us-ascii?Q?kGtFsWtGtWg80p1JNF8/7DNrp5nlGw6abOzwqerEhWBa611DNRoX8w5FLMTf?=
 =?us-ascii?Q?QRSoM6EZQauW0HLZo0EF6cUU6ivYcIjiM6re/GvnQ1fNyv1ib+vjyi79xMHr?=
 =?us-ascii?Q?LAUsYHQMqRj7O89a8T5lj6SoE5bfI3DN3fANkUVQR51wZOLQk0ggDEAIxU1G?=
 =?us-ascii?Q?S06OWd4lBC8y2RJdwY+Ts29mqMAeNnSfkzaWLJZ2r23F66L2za+x81N668Gd?=
 =?us-ascii?Q?m214HsaHnWsokKWZuVnFKNs4bqMovdG+Mu0hYRAkl/04o2JqO26u/ONtN5PA?=
 =?us-ascii?Q?V6fqsJGUBvhiQ6Ur2/SVSOLhNPeRlssNUlsZBCkSQhVgdUncpz9gso3XVGPE?=
 =?us-ascii?Q?TBF9p7B7lpkDNqRCIDSuW24uOmwaLftjokV3KlydVSnH/mMXxkMJ1syZSlU7?=
 =?us-ascii?Q?AO27327X5Pq/ahNCf/PokZuse4Dw6CKNp4rKA0nvsg5ujtYXzlUwAirpWBBF?=
 =?us-ascii?Q?J1VSK2qdbtr+TSeRBkwY0tTVyLY7k2+DJxR4kKBQGAxAfmbfOPi9Vk1WPTrg?=
 =?us-ascii?Q?IupzBR1S8ZWq9rhSiUF6ArRdxSoshQ7j9C4brLxI5utuoNG03vA2ffleZHPo?=
 =?us-ascii?Q?4Vd5+h36ZIghY4hS2L2pEAT7T2vRY6M6I1ti8wlADX13IkIac6P7+KXwxuGd?=
 =?us-ascii?Q?LbaAhjBRVVmcwLbRO9dLqtLGyli10IMnx75Ug+OmmeuKiEPh+MpWuH1z5J8H?=
 =?us-ascii?Q?1PxnCaQUPb/uYymG9Rm9psy/1n+KcBtZPM8IwD36/MR+6t5nbsDpERj4vM94?=
 =?us-ascii?Q?nn3zcYmbiq+pP1B9Tw6Zu1iQZE4i06k0/xtBuG3GQ/89opaRMJQ7WIjEPWx3?=
 =?us-ascii?Q?Fptr3f9sNwv0sqA4MiYpzV9XKn1Ad6t9QMqZ/gIQPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i3gTZKa1iBokVWFwDgXQBxJgLucovMBYgYE2jSS7Scf7+69b4Aha11st2meq?=
 =?us-ascii?Q?QXeeiVGy01itU5QOBPMluiDkHe0wCm7g/SPr301lOMVzHszjqKxzGn1+PAFf?=
 =?us-ascii?Q?wZLyKGueKRpyuHhjsQT2obnqBAcrGPkEbsiWHBeJl/gyb8yod5g0bphFHeUb?=
 =?us-ascii?Q?uVUzvJ13yEp+xnmllHs5mP9WyuFuRDW0e6Jrrk8eHWYjrbh1PUYJ2uAYixoS?=
 =?us-ascii?Q?+bUfmNXSngJGK49MprSvT7ICYcl88RjrmhsXtNdqxbl/ANzBVAV2tJ+idhQH?=
 =?us-ascii?Q?dlRzAUb08rer0UO3pp3kUthlQxVI3gjLX/B1B9phq0hcWznFmpxmpCIV+x6D?=
 =?us-ascii?Q?MUPCmpmFTlLj8vtv22BSDVAsnFseBu/TWZP8a1u/T1ZyGbLrf8TMuRMKyLYQ?=
 =?us-ascii?Q?gRa3fNIrXwEPV6sb8Dc+KQDICGSAd15zSEwHyfAX/PWfF2mc1aJ2E7Jzh1kq?=
 =?us-ascii?Q?prWPDZiz2kzS6ZHk0UcicLHfivspo2wjvssXpOnRlIadF2WVCm8ug6KRcIXN?=
 =?us-ascii?Q?/9H5rESkmTNpXpQhZMmDXck82VdoixNZxUVKuHYYO6T3lDKTW15Mqq1ep+G0?=
 =?us-ascii?Q?H2JsODYCVAvgbAMw5Sg/hZankR20HmdS0FSkho2IYBYGHBNWLEsDPNIeNtEg?=
 =?us-ascii?Q?7Fdw+Z4uxiTexu5y937zuQiF5QkwRE7YsBi3rp74AUlX5T50ng+loOjf/GIY?=
 =?us-ascii?Q?LOA7x/sexSQw1KH6RL6kt450mP4FX5JhAXuFNbmLsT2G/7ZD2/udJbdiyrZp?=
 =?us-ascii?Q?/V8zlv/laM4mOwZjcI/3hIhVK1Vqe9gR/4/bdCQwMu+NLV4kRnU77BOgwUuD?=
 =?us-ascii?Q?OMQ0xHmf9OkYtKf6NeUl/MroLVZZB7qYu3ezItzWMT6yIQThSffTLRWNBxXE?=
 =?us-ascii?Q?WkBktwWkf1KOtDXqyfhQp6Vr4Mt01hKcDcpV1PfjaPQrVLVBnJVQ+45MoHXg?=
 =?us-ascii?Q?9XIUEpA+PAVx/UNHbbk3CRgJHYPc7gPMDY6NEY/AB8aOquHPmcAUVZ1teUXp?=
 =?us-ascii?Q?bQZPKC7IadCPdmG4HWZ1MDH/buiIBtAn5nkIDo9Iy3KqjeFbOgx8IBOMT8B/?=
 =?us-ascii?Q?0Ft/nxlV4TZU1ctLTtCD/K6S2jRhwnRm76lDzlSIMqwIJVC0EtHdINGKQ29B?=
 =?us-ascii?Q?aRiJbaBcYK86r4U3Wo1eLngb8yhrwP5wEJq4e7Un1wScUXvTApgFTk4wBq8z?=
 =?us-ascii?Q?AjMe5dJLjM8yLT64NDnCSJgPSy7RofS73cckiMZIF5BMSwDxbcyexuIb/OuZ?=
 =?us-ascii?Q?1YVYBB99HtVc9+ZOCmrlrSjrcbDXJuk07Oh33tiYUfwZZMvNZVp4syPkRvMT?=
 =?us-ascii?Q?alj1WXgYEVVkMhTRlRXdANVRrPtPZeu5I7D/TkVC7jq5NuO02DkLdYjJtF+3?=
 =?us-ascii?Q?6NfCWf1zYn0GU3wPHXQDoDUTCA8CA0xAQRpvPkOoIgMJFfRVXErSI72ZY4ey?=
 =?us-ascii?Q?d0UNQ08QgtFku3NrVG1oQpAQ1b6qijkwfEjFcKXdeSaQvLLG2Y4z7XE87NuY?=
 =?us-ascii?Q?93HYzap0SCoW4pwbh1zr6YYD2mS+bDSItNTpmKk+v0679wE+oCEQgprGEVAN?=
 =?us-ascii?Q?1wB+U/ncdjeXXRf4d4p6Av/VYD7qy3SDW1Ld7Def?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca548d3-5c64-406b-43ca-08dc6eeca9e6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 23:23:12.2843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHGbpiD6jmJBerbII1vjTsVecs4SYktgEQdi62m6cUMS5iF7s9PF7Jl6Fble+RzYo1crHwCGWnzj8HsiL28Jkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR22MB5374

Add an overlay to enable PCIe on the am642-phyboard-electra. This
will disable USB3 and restrict us to USB2.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
---
v2:
  - Fix double space typo
  - Remove redundant status = okay

 arch/arm64/boot/dts/ti/Makefile               |  3 +
 .../k3-am642-phyboard-electra-pcie-usb2.dtso  | 87 +++++++++++++++++++
 2 files changed, 90 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-pcie-usb2.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 9a722c2473fb..6a38ce2603af 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -48,6 +48,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t-pcie.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t-usb3.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-pcie-usb2.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
@@ -131,6 +132,8 @@ k3-am62p5-sk-csi2-tevi-ov5640-dtbs := k3-am62p5-sk.dtb \
 	k3-am62x-sk-csi2-tevi-ov5640.dtbo
 k3-am642-evm-icssg1-dualemac-dtbs := \
 	k3-am642-evm.dtb k3-am642-evm-icssg1-dualemac.dtbo
+k3-am642-phyboard-electra-pcie-usb2.dtbs := \
+	k3-am642-phyboard-electra-rdk.dtb k3-am642-phyboard-electra-pcie-usb2.dtbo
 k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
 	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
 k3-am642-tqma64xxl-mbax4xxl-wlan-dtbs := \
diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-pcie-usb2.dtso b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-pcie-usb2.dtso
new file mode 100644
index 000000000000..7a5ce4bc02f3
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-pcie-usb2.dtso
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * DT overlay for PCIe support (limits USB to 2.0/high-speed)
+ *
+ * Copyright (C) 2021 PHYTEC America, LLC - https://www.phytec.com
+ * Author: Matt McKee <mmckee@phytec.com>
+ *
+ * Copyright (C) 2024 PHYTEC America, LLC - https://www.phytec.com
+ * Author: Nathan Morrisson <nmorrisson@phytec.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/phy/phy-cadence.h>
+
+#include "k3-pinctrl.h"
+#include "k3-serdes.h"
+
+&{/} {
+	pcie_refclk0: pcie-refclk0 {
+		compatible = "gpio-gate-clock";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie_usb_sel_pins_default>;
+		clocks = <&serdes_refclk>;
+		#clock-cells = <0>;
+		enable-gpios = <&main_gpio1 7 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&main_pmx0 {
+	pcie_usb_sel_pins_default: pcie-usb-sel-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x017c, PIN_OUTPUT, 7)	/* (T1) PRG0_PRU0_GPO7.GPIO1_7 */
+		>;
+	};
+
+	pcie_pins_default: pcie-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0098, PIN_OUTPUT, 7)	/* (W19) GPMC0_WAIT0.GPIO0_37 */
+		>;
+	};
+};
+
+&pcie0_rc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_pins_default>;
+	reset-gpios = <&main_gpio0 37 GPIO_ACTIVE_HIGH>;
+	phys = <&serdes0_pcie_usb_link>;
+	phy-names = "pcie-phy";
+	num-lanes = <1>;
+	status = "okay";
+};
+
+&serdes0_pcie_usb_link {
+	cdns,phy-type = <PHY_TYPE_PCIE>;
+};
+
+&serdes_ln_ctrl {
+	idle-states = <AM64_SERDES0_LANE0_PCIE0>;
+};
+
+&serdes0 {
+	assigned-clock-parents = <&pcie_refclk0>, <&pcie_refclk0>, <&pcie_refclk0>;
+};
+
+&serdes_refclk {
+	clock-frequency = <100000000>;
+};
+
+/*
+ * Assign pcie_refclk0 to serdes_wiz0 as ext_ref_clk.
+ * This makes sure that the clock generator gets enabled at the right time.
+ */
+&serdes_wiz0 {
+	clocks = <&k3_clks 162 0>, <&k3_clks 162 1>, <&pcie_refclk0>;
+};
+
+&usbss0 {
+	ti,usb2-only;
+};
+
+&usb0 {
+	maximum-speed = "high-speed";
+};
-- 
2.25.1


