Return-Path: <linux-kernel+bounces-193208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DBA8D284B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5BF1F27C62
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9B513FD80;
	Tue, 28 May 2024 22:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="fqam31vn"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2139.outbound.protection.outlook.com [40.107.223.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588B013E881;
	Tue, 28 May 2024 22:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716936717; cv=fail; b=IUL1Ieq8qtJPxO+0rxqhBCVZqf7GlsH096wUqRUFKID9OSvOdI7MnxOiaocLVBv83nFRnC9bnNoLdsTpdRDwOKFpdY+2OtVTybCdB69QdNmPYvCviF84Igywml1oUyFMPF1kiYHw99bpX3SuEgOHSSHq4wj3//IC5QHY5Ub+2Ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716936717; c=relaxed/simple;
	bh=5dELTEQ5KHcNjGU7GJVwinhbFySfooHq08lcXwO4TyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mgrITratTqCM/qGnvmUpAA65NhVT6pR+phiX77NOrMU0GvfHOzwQZHfjR26ScPxY/S+Y1mPravalNEL5hY22GwfjPUjKTSfICCWCeq602la4WL7+sJp2VrclPgxgbO5JrSpMY0wOqL1SserBvL/vm0Tt/mfCQOJVhOvOOdfmOes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=fqam31vn; arc=fail smtp.client-ip=40.107.223.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXJx2vEUZqiBwEfpAS03bq7RtRVBRndaX1hE98xoXyT6bRzEh96yf1eeir7RJcMF8cA8HX8pG0NiKtSi53e1CCSaTEQopBs/34WluLVQTnr8y7WemFXsw9w0J4ki06YX6qddXb7YSY/eY0l9OC+p351/upy54xn45eSrVjSagahstkZPiyNawsaHWUi4NqaQWwoEtswrjc2RaiTsjualRdmNeZNLBUvi8fZLJ2SUz2/0RD68PraMK5fqyC+s1O8HakjjyV1eNEy1N3CwMCGFvBXoI5xfRTJvL8jNReNMyzta7TegAu5c6CmhHFb7DqojlNoSrrKCMP114WeyBHBe/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmJv2cSKgnpJLJznkdzVORDIGGwlz/8i5+s3hxBkNrk=;
 b=OovSpumd2wJyztJP+xiDzQ7eh1ZrBFPVfKZojhLLP9FFa7Me/dY+xlEBUbWwT/aqKSYQk+b00H2r+nzI5CvfYoH1mB0ErcKMU9ZEg6YlM+Ei9kWHpOWX0zJ1fogZFm/9RNwtrmuS8V0+I7x2KRCfGE6B+6ofy2ag7ftRxIvMbgUI4HDSF3nkyg1jKWff5gZDqrEuuZPkT1DKiKkRIrCZdkmM0zp3J2qyWSlNXNnecbVaLeilMaSE+FiXuwZM5HfVq4KSqFgxLWSx7EYMN/69x5i1hENdbxEafgd/+oDla7MwBPIdignk6Ed1dikBwDAE6Vf9pU9Qv/bmCTxOP2jm3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmJv2cSKgnpJLJznkdzVORDIGGwlz/8i5+s3hxBkNrk=;
 b=fqam31vntL2CZSknLUc+Ywr7V+ymU8qWVJV/eJ98ptwSCWl9e6W+bakLzolJpuj8GNPlPJP5B5a09vc5x9MksH6I6RQEo3k8bs2kB5qlcTwzqxUTENDuESyYhr/A1nM2XviaYWDhtOs7nPfOI96lZBMX6GrYd3xaM8MpayJEFyM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by LV8PR22MB5026.namprd22.prod.outlook.com (2603:10b6:408:1cb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 22:51:52 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%5]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 22:51:52 +0000
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
Subject: [PATCH v2 3/4] arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable rtc
Date: Tue, 28 May 2024 15:51:36 -0700
Message-Id: <20240528225137.3629698-4-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240528225137.3629698-1-nmorrisson@phytec.com>
References: <20240528225137.3629698-1-nmorrisson@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR07CA0049.namprd07.prod.outlook.com
 (2603:10b6:610:5b::23) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|LV8PR22MB5026:EE_
X-MS-Office365-Filtering-Correlation-Id: d8979ab5-bbe3-4c20-4ae6-08dc7f68c430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|52116005|7416005|376005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1eWimk2K5At91TupCRG6H0q5pjOuZnA2dYxaZQDM2nX7KRgOU8ad7n2299AI?=
 =?us-ascii?Q?vaeKE6ooQYutspplsfkwMP/HgCkFbY8B0nHTCsrEgm2PsMQyYc41FTl9D0LL?=
 =?us-ascii?Q?zGVTysYeXpxIp/vjMlJQCTuaTHK2vIXA7fTK4/TyRDupB8bROSSDU6ZUyseQ?=
 =?us-ascii?Q?gpzPD4+ni1wfDelzNeVksMuT8au7ZCxahl6xNVw12OmFvXbDFdQYQRqLyU15?=
 =?us-ascii?Q?8BAY0RM0QWyegm2Eks2ShbR1hrhAJ/2Huboo2cs3kejKhCiUy12xX68nEynv?=
 =?us-ascii?Q?+fzX95gi6Cvq12abg3tXITyHGLSL6jHszRRAHi+iWD4w59ZQehdQbBIy1gAS?=
 =?us-ascii?Q?wtOASiOoh3pPnQZoIKftkbPdDfXOST/qtfIMWn3F5J03axrZzSxTFZ9vDabK?=
 =?us-ascii?Q?Fa9Z+ptuvi825OFVRbmzMj1BcMeIri5G447iWgQvZ9jxQdVu59ZbZtGJt6kr?=
 =?us-ascii?Q?GHHfJf1CTLHc5JUrOijyAsoTKMEqap1BxhXP2ddRXCK5sjD48y/kEq1k/86V?=
 =?us-ascii?Q?ftpRVo8MSWkDrU/xzpK5YsRewojnBbugr1G9e6bEehpr+WxKc/s/i43+8IOr?=
 =?us-ascii?Q?86F6M8f9bTcREkmbT4eHiCp3/NneQFZIqTAwM7xBJ02/D1QAaJU+nz9hFyf2?=
 =?us-ascii?Q?H5Dk3IllrfwSJzgbJq1pM/5Oa39Xj12OjVng4XFoQt8BvpODtVah7kDr3xPi?=
 =?us-ascii?Q?x0IAnHFKTKJVvhTFzEx8IMy3wQUkS3G1mHZG5eWPF6QmbyzOwNEoQAkWeDrm?=
 =?us-ascii?Q?tJMNvFRcdP7AyVIBTKZ6M8tK6mRi+RtQk9t2ejcQxUTWa6jHGfUd9EHASxKO?=
 =?us-ascii?Q?FhtzC9676Rb+OjBDhYftGDgE6OuUU+RnVduvahRbc75QFXxhduD1zLuhTkNM?=
 =?us-ascii?Q?4YEvJPnnCiFgzAvQlS5sMGOUQjXYoVX1DW2S2qn2gAGt2jnZUlhaVR1QW0Gl?=
 =?us-ascii?Q?5dEGLisBG6Dyl3FOX/w+4yicC7iuAR0dQrjL/78ynOERzu3YzKjaLHL7nUj5?=
 =?us-ascii?Q?6zafsWDl/AXLJhc2QHBkupCh2GpRHSUF+lGqt6vR0R37UdK0vyB76md1uB55?=
 =?us-ascii?Q?zov+SvLoUCweI8l0z8P1WASnorZnZpef8BsppBlCP9JLAZvrZEWFvaG/byBN?=
 =?us-ascii?Q?sEWJBwYY2rTdLw9mOJIEYm0I6yRqbfCU/0DxRdwLkvy04HyZTkCElI52jWdj?=
 =?us-ascii?Q?kPRlhGTKfDRTpffN28+9jdCu8C5yXqfbj/hStw7kMjaYROnYjjpVt8VBE5GF?=
 =?us-ascii?Q?PREMgiqSxJj+S7Rg2tk+WFSQySQn/N6W8ftm86fp0X8JlLtpW2sNPvNqtPIo?=
 =?us-ascii?Q?1GkGmBq5r2NXj2W1zazANF/eppP1kc79OUCbLUvz4P6r8w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(7416005)(376005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xhQn+ZOlsddM3sKi1s23Zdo9yOUHU7BRkrSh9MGLJQ4Woln0Z2p1G+4wNVtv?=
 =?us-ascii?Q?Jtmt8+ckSjqWEvZiyfjji9tXyK93iRIQYwxhs736mxKCeWzoSKfG0zQfvfhi?=
 =?us-ascii?Q?YkkE04Q1rZtOg6pNfEYqDrkDUhcLWzyftPMT2TvFWD8zKWKchHejU3J16fIH?=
 =?us-ascii?Q?cSOkIGwrDTEYmQBZZ6Mnu253prtuNhKBwRVK5b0v4QARgGSFMW/W+ictEa3g?=
 =?us-ascii?Q?tqIfjjg+cLQVAAhraXy0ynB1R4Pv+69v39WVriYe4Sfr7R38FuP2w2QaQQgw?=
 =?us-ascii?Q?R8mWuRHXgGh0YLzEFAYBbW4VyjLworWT7M5UZhOhCvfRbpELbFYMrbKROJMR?=
 =?us-ascii?Q?LmPOq7GaK5TlxitbzY1xpnBc3+idAN1ufn61cyFH/npF1lFGwJr0eFmE7Vmf?=
 =?us-ascii?Q?eUX+yTnNIg42vLvshIw7tMfeMggfFEAyNRYpTCS/GCSrF9Cs5iN44LpGjImI?=
 =?us-ascii?Q?CFz+dcW41fdUutw0x9m3kPZTD8uGeQGGcy0S56wa5EkBbb/9wUzXOZ39H846?=
 =?us-ascii?Q?Hmou4n5FVVm0/PxCdLkrbs+ci3QKDw5WnLAGmbTbIZAOX01SilBCJ0MIeZi2?=
 =?us-ascii?Q?yPsahRdyy15aZFcklc9i7ki32HwONByW57tLKBbnQTsMX5g5GChHNEJMjr3k?=
 =?us-ascii?Q?lYwwE4SqfI9s0+GvvXvq6cyxjI9zrlDzu9ovzL88DyGpj3Pa7fSyHR3gN5RR?=
 =?us-ascii?Q?em7t18veVz01keqeFRbCJv56D5OR+KKDQKAvLPoe+bSHYK3Dr1YrrMHvbaF6?=
 =?us-ascii?Q?ImqeSVtGi2BPR/a+E21O7HpBDrijIwBPLUIhrozof+ik7v9HPst7enfkPhpy?=
 =?us-ascii?Q?u3abxZ/+nj9dMuLQqK9Rs1Jb+Fa+d5iuQkAnf8pHEvPrWMu/MUESspZRLYf/?=
 =?us-ascii?Q?Sqn8/CjAKn3ctCFhExDpiDG2+/vSoZVOCBkcLvQ3NjXqwiERdhyrime9SJ70?=
 =?us-ascii?Q?8gtA131dlElELS9H1gMAUlNUM3OS8B1tCjiIhjXa8wHYeZT9QoUYEuAPWICK?=
 =?us-ascii?Q?ZoZUyIHgFH9J4anV5EHE2Sn3ATyQV91L06JrWX2Z5aA1I4zzz6dGQ0wGnJx0?=
 =?us-ascii?Q?EIaOfcuEZ4JJLNlAVrvhiVRqVnkfwRvAs0YbKLXIw+d+uO5c8bneH5worl/f?=
 =?us-ascii?Q?YU9xtrgFSdC7/YrwWc8MUdCRO2vZWHiy4fxDfYEGXi3WjBJWFquBCNCmz7IT?=
 =?us-ascii?Q?O7HZyVwXnE6633hI4ZkbjGmz+7SZUEEWK4v7IJAc9DdQCyyhMG3Bv4YP2wmc?=
 =?us-ascii?Q?cAVZRxzu114aV2nl3OdcThU409FYvXSnAblGEvjJNdt/z4JWdd8AoZnli9JT?=
 =?us-ascii?Q?goa0QODjcE+EGaBn5qkIq2E5OEPOzAbNmQEGN8W2mqlYsOdf0ctMLBe1a5ea?=
 =?us-ascii?Q?UJum2C/cutNqHUTKWAzAPqwjaYSt7RPYceeLoiS+AGtEEvgFjPSyiyNgwP3r?=
 =?us-ascii?Q?6YEZKiTy8QRK1QOh62X3l9IHfElSDiC9nhkNM1Tsoa4UYiMdJYHLzKfz5s5k?=
 =?us-ascii?Q?CFY/GKTjAjGqKSbNO1tsmIHGe5nESPhZis+qhq072O5EddAQ9d7dH/kPnVuj?=
 =?us-ascii?Q?DDMiwwOM6l84jLlt9jaeoDh/ALXg78IWbyxWPjP+?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8979ab5-bbe3-4c20-4ae6-08dc7f68c430
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 22:51:52.5594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MzpobbU25NNvXMC5D1h5ayqMuLrxZ0cGnGPjOOW8x9kyGhe/KvN7fUhdaB75/ehMuSTTcqQ9CYdOzlbvemdNNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR22MB5026

Add an overlay to disable the rtc for all am6xx-phycore-som boards.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
v2:
  - Add build time tests in makefile

 arch/arm64/boot/dts/ti/Makefile                   |  5 +++++
 .../boot/dts/ti/k3-am6xx-phycore-disable-rtc.dtso | 15 +++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-rtc.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 320da5ea38e0..3d0e87a78e09 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -56,6 +56,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-wlan.dtbo
 
 # Common overlays for the phyCORE-AM6* family of boards
 dtb-$(CONFIG_ARCH_K3) += k3-am6xx-phycore-disable-eth-phy.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am6xx-phycore-disable-rtc.dtbo
 
 # Boards with AM65x SoC
 k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb \
@@ -112,6 +113,8 @@ k3-am625-beagleplay-csi2-tevi-ov5640-dtbs := k3-am625-beagleplay.dtb \
 	k3-am625-beagleplay-csi2-tevi-ov5640.dtbo
 k3-am625-phyboard-lyra-disable-eth-phy-dtbs := k3-am625-phyboard-lyra-rdk.dtb \
 	k3-am6xx-phycore-disable-eth-phy.dtbo
+k3-am625-phyboard-lyra-disable-rtc-dtbs := k3-am625-phyboard-lyra-rdk.dtb \
+	k3-am6xx-phycore-disable-rtc.dtbo
 k3-am625-phyboard-lyra-gpio-fan-dtbs := k3-am625-phyboard-lyra-rdk.dtb \
 	k3-am62x-phyboard-lyra-gpio-fan.dtbo
 k3-am625-sk-csi2-imx219-dtbs := k3-am625-sk.dtb \
@@ -139,6 +142,8 @@ k3-am642-evm-icssg1-dualemac-dtbs := \
 	k3-am642-evm.dtb k3-am642-evm-icssg1-dualemac.dtbo
 k3-am642-phyboard-electra-disable-eth-phy-dtbs := \
 	k3-am642-phyboard-electra-rdk.dtb k3-am6xx-phycore-disable-eth-phy.dtbo
+k3-am642-phyboard-electra-disable-rtc-dtbs := \
+	k3-am642-phyboard-electra-rdk.dtb k3-am6xx-phycore-disable-rtc.dtbo
 k3-am642-phyboard-electra-gpio-fan-dtbs := \
 	k3-am642-phyboard-electra-rdk.dtb k3-am642-phyboard-electra-gpio-fan.dtbo
 k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
diff --git a/arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-rtc.dtso b/arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-rtc.dtso
new file mode 100644
index 000000000000..8b24191f5948
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-rtc.dtso
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
+&i2c_som_rtc {
+	status = "disabled";
+};
-- 
2.25.1


