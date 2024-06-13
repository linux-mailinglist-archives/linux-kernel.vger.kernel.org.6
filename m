Return-Path: <linux-kernel+bounces-214089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4172907F3B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4156BB2236F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 23:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4FB155CB8;
	Thu, 13 Jun 2024 23:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="SjhUdEA/"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2100.outbound.protection.outlook.com [40.107.94.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234E7152188;
	Thu, 13 Jun 2024 23:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718320173; cv=fail; b=F4H2TLMn4ppSk+Qp8uoQABSVlhoj4G0/sVd2ps6+RnQ/gYVsxdXrkUOnM16SJJ0VDXRjbv4VNs45HuYAk1kMYR2uqtD4VvnFzTB3o2WneudkUpqLNaPFwQILz4R6wZ2Nx+apnM2TW4elH46mJvBuHobFP6AX9MK3tsnYnTXvsvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718320173; c=relaxed/simple;
	bh=pWHfWAKxvNC8h1z2BBTL+w5QxSu5yCzUqnQINWGGqiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aDvhYPAnANm5QNzHZxUlS0nsJ/peEJrGy8BoVGASlWzROnXZLOMcHFIkPyZH9eF3hidl8yiEAl3dhkrTFdsEEPBVU6vSJhm2rmBJtXys8D37S7KC0/3dr7av6mDROXvWRZP3oHU1iCQTsj3y4J8JRwZQp1TYp/VEfsTJO3jj+kA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=SjhUdEA/; arc=fail smtp.client-ip=40.107.94.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7nzj2MLmjQ8m4F+EFRTtCIxJWKp0ljnFr/FeowbAaW/0FGD9WKKtvlwYOeNWKmRQ8y5tPWW0N4c6OzQxArCv8uoe77eeRKocyxsK07CviePiko69GeZWADV0jEvMZe9NkhCGtv8/vN3zonjd9KHfj0oMV82iHLlXqvT14H/b/6kzOKQmwORpgjs4xEVJ++07iYpbXTJRYLVOZ+NOG1n+0KHO+lN3/lrqjS9SucGBYRXdS303XfLgpF7g5lkICLGL4J5dEqg6yRZ54LiPzEa0KNR8HYKwb8RUuq2RWIcJ60UfZVOatZ1tGiecJE2MhZNNIZFMxkyFdTEc+qTWtYUCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ocZxjB66uF3K2wO2Gx2JlmsXMDocb5IA3JBoNuSb7U=;
 b=H8/Qj3M1W5QTQYrLspaY8OoaBf19eiwl2b7riHHTkZQd0+/KZMrfzAEeZPyN6g7YUNOHKO62AVbPoVyQfAvklBg7rg0GgNDzdrYf6l7JYrXq0YVDI/fLUKvx6arexUUxvLVVNURJB4DAz+gbfiXKonQ+D+SpzAs+/Ue7J2Hg0QdtqkITyzs3CH0hMXU7NKcF960jSAEG0tLwhscZpis7zbZaJWHWS90HQqVfFzjxQnNgYuP6cx5eyCQKwShixjW79qCdtWC9mh3gj33cqmuoppksH5wRVLalNw9+G/P58Qy1gm47odC6YwYHiXgMVQvCqZGrLom92lVAaHGu8ZWpMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ocZxjB66uF3K2wO2Gx2JlmsXMDocb5IA3JBoNuSb7U=;
 b=SjhUdEA/fB96ikSeIbe1HqvF9OFvRuiMGhFzZLfob4U7JF3YulH94RVaHqZmDr6zmdGgao7Fmo/KcJ/iI6qJz09VNz/ucrEd0xQE+294NY+kk8L4qmU6XM/r+h5+wYBsPuqGjz9+Cs/MSWceCnOj3AVdERQcfSU5GAxKao6lkGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by DM4PR22MB3423.namprd22.prod.outlook.com (2603:10b6:8:46::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 23:09:28 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%4]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 23:09:28 +0000
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
Subject: [PATCH v3 3/4] arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable rtc
Date: Thu, 13 Jun 2024 16:07:58 -0700
Message-Id: <20240613230759.1984966-4-nmorrisson@phytec.com>
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
X-MS-Office365-Filtering-Correlation-Id: 11df39fc-c156-4a96-133e-08dc8bfddff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|1800799019|366011|7416009|376009|52116009|38350700009;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0dExirJmrPPT5VB8LVzbRacjOhIi6zRa/D/1J1jTPQV7dYtbJZw/gGfeFkPO?=
 =?us-ascii?Q?nW+n+2/ZFSjhIzGzTpDSnQVskEuX2+52H9j3QYLHRauXeU4a05CaA8lEnLrP?=
 =?us-ascii?Q?5/zu7jUKeBjFlQ5sMnx279hIRRsIaj5Bh338e9NsRp7f1zt5a/ph1KUw6m+P?=
 =?us-ascii?Q?pn1gyL7C1Z3Lrqb9HWPrxnsT4npipNLsbdiphl76Sf+t2L1WTIfRv4jn4Xve?=
 =?us-ascii?Q?jZMHTAvd1m21Z85z87qcl21T+dsjSF6FtcpnIGsGxhq32qKaigMJeLtyG3Hg?=
 =?us-ascii?Q?tlD6sv1vpgMdGI3fCB+wIbJBMt1pbV58C1rhz718Es7K1U+jR6QCDANrRuJU?=
 =?us-ascii?Q?pV9/HDC4OgiL4LrufZx99cPU7apxim2UVoRPhX/Brvnj9mFZAGkuYdupfPUx?=
 =?us-ascii?Q?nD4IfD4YKbDld+xjTzhYGBPIptsaRj8WBI2aXsQwLOvrt8u5R/8muCqIJj1W?=
 =?us-ascii?Q?bJsJCkBGoshWW74u5tpIuELJOdriGGE2DvLhM3WILIuFUOw6v4H3YcVRyjUS?=
 =?us-ascii?Q?AFyJ5msDXcTvvq+8lskJHAJ8i9GAxADYs3xJi1QFe6eCfDxGW/gYCieOLhrG?=
 =?us-ascii?Q?uFHEUlQTuyhKZSlgP4z3RtAjPEDncP2IjcNHLqQYULSHrWFEmg/BNzz48iBK?=
 =?us-ascii?Q?sb7ZeEhs2hyYOTsotfIdLULnHFHlzGWBYli/UWrxObRRGEIm0Ep3n4Bm9dCd?=
 =?us-ascii?Q?/LUb8JjJyuzJk4Lnp1TfGqM9LBFhL30ecq/pPSUafF99UPcS6cZ9KEdoQj/Z?=
 =?us-ascii?Q?eT+npux03YoKuwNg1XaB8M/uXjIykols6PY2A9g7/oMhifMVg7h9waoRB9/f?=
 =?us-ascii?Q?DkCsXqMHG4oT2tSLVytKFG+Ke6hjgaY0vrTUjQ6Px68VrWbauZUx9vmVNGv8?=
 =?us-ascii?Q?hh60vT6yb9Ktra7RSvPAAG9oQEQrk+kqs18fRkw6r4jiQ52OzE9OmEubiTcW?=
 =?us-ascii?Q?pVfLEenF7qhwniVE1gMczhOiIKFH4SG1/MkjHEwMOko7r+ybhP41qIrNp6Zj?=
 =?us-ascii?Q?bDAMnb3HPeXrPkLg6drplhFibLqMxpER0YrkKas3awwgN/sOwJUHEcdaS2BY?=
 =?us-ascii?Q?Pv0+WlaK2OBYmJ48ujcSUDINkF7sgIgnRhsU/Jx5gAys1GavMfDQu0BPKYhF?=
 =?us-ascii?Q?qtZ2bmKkYqeTRpCtV22dl+E6k1VphTEEFlGkZGVcRi66jhL4T16uCWbUtsyQ?=
 =?us-ascii?Q?7SRlDD++vCCXCVvAwRgSRaq79SQb1qKs1PQ6INeBVTuOqNYCOt1qIgk2R94z?=
 =?us-ascii?Q?9e3r59NbmHxoCuhnP4Y1HIPjIrcvQj3CCqqhbBYHFlFErSACZI+97WwVDD3R?=
 =?us-ascii?Q?PYo/7/PavEVB2a5L22KiPBVoRYNmmdeXRUe1IsODZoBLSIsdayGzYaN6h38m?=
 =?us-ascii?Q?Z49MziY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009)(52116009)(38350700009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?djVjB6hlHHc8sXPtjLzmGRpDSlN7tYS9N0g53mlBMSYUz9YkXuobPHfaf7Bg?=
 =?us-ascii?Q?dpN9sj3PzH6T6zto59RImuGaSB6wEmRbHQK9osusDOk9MMHl6QYZ5j1LbVFa?=
 =?us-ascii?Q?NOR+9E/f73E8C5SPaI5VkwduoZmTKEoTNo1w8hlCfJpeyF5pCFYGKryJ56Ev?=
 =?us-ascii?Q?1rJ3md1B2TjAeP/NqzOIUk3zWP3GvoFX0ag6wcbeDgwDgwxKR4qvs87Yjd3m?=
 =?us-ascii?Q?5O/HJMdiNbJf+p94rCUnkb/R+ilJ0e6odWU8k+miHAJJXnkpYsLJVgM+oOe7?=
 =?us-ascii?Q?uxLQUd3uY/I9MiROTwewITolt8O9DgChXqtzOQOWhSdloUfY5EtOqsPook1p?=
 =?us-ascii?Q?lEDDpASstSP6nUta0rjR7JQ546cKt4oQXj6B/MRC3lEoj1sr9KNh9+Enzj3Z?=
 =?us-ascii?Q?XqxBgGZz5P52gc6zOIJsFuep5otWPuG2jsHWCszA5IVTnchPj/o+C/PVKCj7?=
 =?us-ascii?Q?F1uaUvcmQIQv/7sGlucAIRsXewnX16FdcdSWV74MxAzdzKPaMry75LmTbYM4?=
 =?us-ascii?Q?HF7bAV6c+IReiQgb4ArnYXnjdnZZVlOuYCnQNH44yoT+/zEX0H77sZszjS0L?=
 =?us-ascii?Q?h7/LHord1fa8kVeU6pJaJ9v8teciRhOzDjEbjZlGa+Q/t4kfRpsRWgi2BHGn?=
 =?us-ascii?Q?YBtMi8oE93zMH9uV1g76Y3LqDuXmBp2wL/ceFM++uxd+CDPz8SESP3e/R86j?=
 =?us-ascii?Q?C1ehoLbw1zaCJ9sMQRpHw0WtHMhNL7N/q9+qH/6ZXtD76IIN9riX+sacEWLL?=
 =?us-ascii?Q?rSZRPaZ3jvzG/1fJTNg0zdbrBU6MUVUo3B5Vn8DDrq5FjvifxKiRlEt/KPYV?=
 =?us-ascii?Q?AAeSIQl4Eo3JA9FWProInaYKDGk/E173/LK+feaLpprvT2RpVFXxIHlLXDgs?=
 =?us-ascii?Q?G2BxI9rq/6eqm7TYiOHt/FciPJ6APARXbE0au/aFkFNkGfm5kLynayzdegfn?=
 =?us-ascii?Q?lJINa0++U5yB5CIwRGfx41pylvbUIOBXHz7zn6lwmkivCQM98q3LNfN3Ggz0?=
 =?us-ascii?Q?4q5bBYb+hU3Rh21nmKWxTQxwkTMciMxu4jdw21KWGmhLcLwC6zhbXuovkSjI?=
 =?us-ascii?Q?Vn2Nx+QhfQw7lIc4ZXDKY0vR7mrRf8YYyC3RULeEhOT5nkVarbWpGjdauTOR?=
 =?us-ascii?Q?NVNVIFt0eykc4Sj3XVcOZ+6evTi8XFWXtsNJByE3jGHKPWxQwUgndCRXnTXs?=
 =?us-ascii?Q?XgjGkA9g/cPYmEDDFtjjfY43oc4B62/ZteA5U93W73SjeZCUYJLnnG8wwCk8?=
 =?us-ascii?Q?HL4TDBGfEAHn24FDO4cO7lEGjgm/X/rhiWgQVecgHA/XdgV7Facw+YTVs080?=
 =?us-ascii?Q?iP99olEXUpfyRIK0BF2j7UWDAwts/Z6DsuLz4JiDHjoLVPZDnCULd+lzHrBZ?=
 =?us-ascii?Q?cLI+CS3MvLtBVeRMThPJDsm6UQhqmQQwWgfxDKrUnA88XS0BgBcCVMyOGRqY?=
 =?us-ascii?Q?XHlkj+FoSMVmk3k4hqpg4kVJVs5PtcAD8G6AVGrgI+lpY2qUAOaL6mS1znOg?=
 =?us-ascii?Q?a1gzz3hJl4clZ48dRJ/PhxDnCMh1x0q1g4XXcIx0bj3eIMMfa1y/pgzynu6J?=
 =?us-ascii?Q?jy2atLxoNtevwoa5qIl6+7ZUp+IWuDG8cHEVuDU9?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11df39fc-c156-4a96-133e-08dc8bfddff7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 23:09:28.1466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mk27geQSjhoMEHwD7Mho4eDBzDMYBAEYBwSqbC9gE4DVN7dkwFD2LeyYFdc6RvsVF2Gr/RZ68z5AT0lpsYWLBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR22MB3423

Add an overlay to disable the rtc for all am6xx-phycore-som boards.
The EEPROM on am6xx-phycore-soms contains information about the
configuration of the SOM. The standard configuration of the SOM
has an rtc, but if no rtc is populated, the EEPROM will indicate that
change and we can use this overlay to cleanly disable the rtc.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
v3:
  - Explain why we are adding the overlay in the commit message

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


