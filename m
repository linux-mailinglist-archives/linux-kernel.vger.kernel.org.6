Return-Path: <linux-kernel+bounces-308379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1365F965C34
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF3C12840EE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A202F16EB4C;
	Fri, 30 Aug 2024 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="M2gIsqHR"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2044.outbound.protection.outlook.com [40.92.23.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4206216DC3C
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008328; cv=fail; b=KHY6VfAUQoLePxsqTyXwgf0mrKRxaC8c21eEkLrGVAwW+g1CPdyxUwdZd6YkxERFXUIGRTP+vuNvelNOcFgbrZGmJGMVtEd/EKUX2tVDH+wFZiVcjJMEanVmVNaB2cYlQccUMlZPMaE/lkf6THZUPJzABPzXUv95FDvYaP6w5xI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008328; c=relaxed/simple;
	bh=Gzd8T9wtih6Y/lSp8zYbk91EumqLd24Oe1Yqkifoeo4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OU/uYJS6mhWoZ10TsXOHImQw+nU9gvUlA68kE5BQNs3QC6HvK9YsdU8TCKSsgtgQZ1Ud1+eg/9dYSiVdQsbn/pL+5mGNKNnJ8NfIvgwZiHTHtVYyW/nrod5gJs37C7TReAjwOqMzPjSCLQbRX71EvpN1d8w+V9uRplMamNCg0yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=M2gIsqHR; arc=fail smtp.client-ip=40.92.23.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDcO2ailjoUgvllx57i4RLPp4G+iyxDC9cwifWw4uP4y27CTWGXIkCugLUfVxTf93OfotqeXzs6J53s3UnGqUURVPnDtcaGGtUddLR4Nqt44vzYN9uqztt378z+STgMUE3UifgxI7rz2agodQpCW17YUZFj4imkvo5JaCj3g3KP7TBwJh/e26nshnUL8pje5Gp/mKtWuK+1thbdxQVpW1RTdVG/DyoaPq6f1Qq8CEgC/1fAWZJI0D79YNWDqOy7lzAVjeD8c9MlOg7v1ftRrLjjB3fFim1CKc35/KHTDEMQC1FbOKhLVSZehSn383bFq+XnCYnVapMYRd1dIIg3SOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EY7cJiGNlW/HoTLS65mW/8yDGu5LMyCWCnbfrkSvfbc=;
 b=bYg1Bnf9EP3ArCZFbiLDFm7rzqLaabRS9ya2TW2S97NUVogtLgIwxU8lpdHEdfoAZPXuDDZXz1I6K5qUQa1OVG9mGWJId2EaX5NdMIascpMiD7raDGrB2GwpmpJpKS1x5RcjL4eYmRFTJ45t/sBxI2UeogOdeTe9F5DntRspceYDi9JVLb+/fqx0pzVoOC71s/JYU8Xdyk84i6ROKdpiZMMCK8XLGRlbwSncV+pxDgNByiL2E4wy11gN+X8Pm/gXH8UruPcH4VdMEmiX5ubB83uE6vSC3t87rfDEoQGn88kcjHYxlXiauN4/tDeIvtshPCbzzCqOpbQgZB7+B585Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EY7cJiGNlW/HoTLS65mW/8yDGu5LMyCWCnbfrkSvfbc=;
 b=M2gIsqHRD2udKS1NfTFL4uMKmMmG2w9ySVFvyAoyGVAhn7m4UdBtoLG3jRFRwLDZLIKXavEIp/3t45C2bfEWuvNDpSSKpQDS/81e8Nvd4I7iRLF5cgN2Z+SNbmC1WRdt4IL1LTGJJ+dNT4m4KDCAB5O7EEYlEP1bhOlWThVy86khiElIPh0xGCpB3OdeJEFWMgn13jA34jAhoBOMR8PcMwawbC6M1YKeaMfMAujsD6Txt4gMkUo0Edq8JVJ/LyuPkLJrxSIJdNonq5NiNIk0aKmcnzF8t2xs2B/q4x0wjEqVajsUGUnz+4GVAmi8aTnZFwn/Rkj5RrjgjhWigiAOaQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH3PR20MB7520.namprd20.prod.outlook.com (2603:10b6:610:1e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 08:58:45 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7897.021; Fri, 30 Aug 2024
 08:58:45 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Guo Ren <guoren@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Hal Feng <hal.feng@starfivetech.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: defconfig: Enable pinctrl support for CV18XX Series SoC
Date: Fri, 30 Aug 2024 16:57:38 +0800
Message-ID:
 <IA1PR20MB4953FF3C0CA0B51962DBE892BB972@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ZehtY5qKqkdrKYQa2pZ9s9weFCU+z9o2UzN29Anjw9s=]
X-ClientProxiedBy: TYCP286CA0292.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::17) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240830085744.888525-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH3PR20MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: b0eda9b7-69e8-465c-4d63-08dcc8d1f42d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|5072599009|15080799006|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	AmIkoMwlrL/asu3nsvzaSifmjCwC7f5ri9MnoLRMd6MRvFRDurhqnVgdEIWRxZ0rTpvYsul1dsKM1gaAseCF0L029IWADo+m+aM7LbGBu8vZQBappKTHV0df5sHFlF68HYNhu2OnL24s9TDsu+HsdfwwRoX7B181m5z52HQn3epZebaDQ7PI6KpNes8H/aCwHk3GiEHNBw5FZNkWGIq6V3tzvTy3n09LXoxwrsTJTNwAgcS38s3TC1v8asI44dZjI8azGxuXCVwKtdaD2kDFJwp6A7wT0S5/KiBcqbrvbL3qYJjnvDgBYAYzv0dw9snP9PFpnS/IhSbtwuWdn78w4sgi3+CiJG6oZT6cCEHtr4CW1VV+LPXOUh3I+gFVP1hyptHPpk+U+8gGXIuXRdz6CkipRWwL558yvel6iwxwtEUh1KI9txYpXPMEPIoQj0RLVTYpxJojxZOjd2yvCJZ4DLqfGJ2QkXuq5SNScbzB/pF7glMRjRi6UAKv4jKwl+PSF0a4LV80Tussc6dKbBuI8bWCI28DUrocpXiL8B9+fceGY3zAlV90gpTCqP80AvAClWhtrns48eW7/W8odfE6fRfYNrG9z76ZV4vnXoWZk9djM+dtFcjRS8o8/IfGRuvilebHW4CDNt6+J1YEilHftR4zd/yeGApv0WCOvHudGZzf8+iZj2OP7rh9B+708hnT1R4zJ2IGmHEQohUH4l4ZPX+2V+n/x3hGL9xl7qzc5Ao=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vFbz2wSJVOxv9PIPjfAFpzx22NNpTkzTJRNbFVvqs4bhvI0+9iHkWJmicn4U?=
 =?us-ascii?Q?U2Ol0wSyWx6vEsKq4fkxXKFcx+Wva4wQiMoRWr5mKg27zOpnRL1OZJyVm+/2?=
 =?us-ascii?Q?LxH6sLXuhS39wUG4JGZuML+gkn3ASkVvSGqKR+dcXInRGShqqS3pyt6yLjRm?=
 =?us-ascii?Q?sBFmfTgSJlurWD8o9+in44X6L5JT7G+PIwzTyx/WBdT2aoUtnbkBvZMrK5aO?=
 =?us-ascii?Q?wpLANGvSztlUrtTyKerZKDCYo97XQLoMvRpTlj6CwPVnEglb6hC/YBARzIEF?=
 =?us-ascii?Q?hJtJx8nnVMKtC3d9s0fo2kNX1Y9SdzXaz/kM2O+49gk1X12oWIgeTJxnSdPv?=
 =?us-ascii?Q?rX2QJcSg6g9d/G8UsdK6i8/LO9oBVJfZgjJCFemp9+yPnOT65XKqI+gvpOZo?=
 =?us-ascii?Q?xeMENJez5q1xfnxnLFWCt3hK8AXBhm1Xt50uRSfWsSMrdg/pBu0LfbQFvG4n?=
 =?us-ascii?Q?JiyFi1RlbONQyUxQhEL5jkIUDjelfYe/p76ElDdzzJxYbV0yYn+SZvCnKnOP?=
 =?us-ascii?Q?37fM7yhd2hy0N0qDzV6EKPCZREE/wE0kxhLLp5tTOmVE5/VhR8e2fmyn9hIF?=
 =?us-ascii?Q?7rF5pzwRFbxBWavvS64n4BJ9x6RDPKwoSEz0tDPegVmufjrc9TTRY+Kc1tRH?=
 =?us-ascii?Q?MbnCugG1624GpcC0+EDlRlJqLfTb97n/L+AXCnZA3olpVAB707StLYYbaYsr?=
 =?us-ascii?Q?3MCU0MH0HEq5ig64pUpFoQPYOHbLb6Oy3tn2ap7GauoAj200M13jLxqXOS6J?=
 =?us-ascii?Q?KF7kIn78Xrqzpkb/PPVsOzrhgkET/K/QmQdRpvCDoW7gG7NuoSc6RFT8bZTH?=
 =?us-ascii?Q?yJBOmZyBBUMICjcAGBPrMUzwNGwU22WBLEfLmvwCQeyvWWt7dR2gXmUGSqJp?=
 =?us-ascii?Q?MZDyhaV5RG+aE7Z72a4v/sBm3nnzm5WUDz/2VLx5Pk+/5WgKAsqF2J04PMgH?=
 =?us-ascii?Q?WSuT8xeAQCndEn/92j+rNyRGua/RaCyD6Khfn7FmrZT54k9SXig2KyfnvaoB?=
 =?us-ascii?Q?vVSI6lVRVGRQwOSXKeqgvmBg8POmR7ohXfVQcQ0yIp1NGumBspNAWlu0OLhd?=
 =?us-ascii?Q?LxkK59OleD9jhjQY9GjW/RtRszy9LGgJdVBuaVLMbcb4pXbdQg9hbXQkKPfH?=
 =?us-ascii?Q?qwznyBIcZRLpc6JgNJGr6rygzpKM5yMYfS3cpTcJNESK4OVoukjIhcg13dop?=
 =?us-ascii?Q?Ax+sZzhYwW2y5Ove2+8uzhQOzgZ6s4vpek+MM+pe+KCf7kG0y8kCchRvaSdY?=
 =?us-ascii?Q?dUUpzyEmO7cPYtnEuLNR?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0eda9b7-69e8-465c-4d63-08dcc8d1f42d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 08:58:45.1956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB7520

Enable pinctrl driver for the whole CV18XX series.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 arch/riscv/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 0d678325444f..cd7980df4759 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -167,6 +167,10 @@ CONFIG_SPI_RSPI=m
 CONFIG_SPI_SIFIVE=y
 CONFIG_SPI_SUN6I=y
 # CONFIG_PTP_1588_CLOCK is not set
+CONFIG_PINCTRL_SOPHGO_CV1800B=y
+CONFIG_PINCTRL_SOPHGO_CV1812H=y
+CONFIG_PINCTRL_SOPHGO_SG2000=y
+CONFIG_PINCTRL_SOPHGO_SG2002=y
 CONFIG_GPIO_SIFIVE=y
 CONFIG_POWER_RESET_GPIO_RESTART=y
 CONFIG_SENSORS_SFCTEMP=m
-- 
2.46.0


