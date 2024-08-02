Return-Path: <linux-kernel+bounces-272560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7201945DEE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D22A284659
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 12:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3B51E3CB7;
	Fri,  2 Aug 2024 12:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PQTfS8dj"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2020.outbound.protection.outlook.com [40.92.40.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967331E3CCC;
	Fri,  2 Aug 2024 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722602376; cv=fail; b=VY8la2Q8GCUZQvXYJrVM88iPbEdTD3Xfz0zw4P8njZfTItgqa6ZdJps0cVdgqDkGDk5L9rWqWQn5bbj6BJ3dChWgWnnFw8uRXqou73i9PWrExfCkXlOguw4IVrbzzdHjRJvVi9lZUZogE+jiQimDwzbBLqj4fWoAntg8J1IJues=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722602376; c=relaxed/simple;
	bh=ky4hdMO5Qo20h4lLnPTmtodE2ab1YlFe5yheyv5xp6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tAG6v+mwjO3S8sUC5mrAMYZCAgGIoGkgvXYH+0Z+WcFVlq/zbqkPBg2g7uSCbknhFtSva5k/uBLP+uxla0bYyVepoXMAwPF+weIDA1dk5IPow6O3jv4qvA91RZDVHBp9b9eckSeDu5tomyjBbcEAluI5trdaWlH1YxssPH/vOio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PQTfS8dj; arc=fail smtp.client-ip=40.92.40.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+PF7dbwuZC/IWrHnR+SBSFZwr6BBO5MEes0XRasWG/3cIC0SttPNNBzCUhJY7mCltJrg0v/37Gy3KDivSXIMh+HJETLZEzS+snAYi4kkC56XjgeRXnD5xt80PqRdsh5nq3In6BK2CegNlwPLT0mymD5SDZ/yvbBSfd7mzI673hrXSAscJMFd7Gj5GSsir/hYY2NckYy0aDpZ28bJ7pNFkm2yt1jNxzoyxB5eaT4OlFDyYNbWRBIP0/2WshtpGHOoe3IRgAIAsotSTM9zboXNTN6XUX4knkxY87Le5VKSXu/3GxKEbLOVqY0a79/Zt+7bxEc70vrm4v+yc5eBlB/RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKfJxZpv2S9cJDJFBoxogiufiOfYodWSGVaJ2yBznh4=;
 b=S/7VIL5ziKxUKgiQTxfp2jsZh8VF2+JDO0YXYbrugeBJ+u/VZBZKWFRFxBanjkgo5LtF/CnVQssJyCFzr3JIo53IX4e8FeYS6Rkpce05eFEhxtUo+UESDrx7FtOkE3vBlHR1AoYZ3/BM6+rl+ufHgTlBH3ShOFfv0fyKyxjXY5AnMWgCN7q+V8kp3fGQ6fAwZM2tMsTzoMIG6czz0avnHpBaDY9QnAHTaZ0FDLSH7n11lD46DhLenE1hdlc32iBVqAgDV2pDPPmiGLtrpu7O8i5xNyQUuweAc8Z3wSrDoGfaMEoIbrVxIs7C8bmesw3CJ6U5ghuDvP1dnFBSF9kCig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKfJxZpv2S9cJDJFBoxogiufiOfYodWSGVaJ2yBznh4=;
 b=PQTfS8djiRjT0PSCkkZWw79iG5SgPlbAHLPzbMyZ2UjwY9+cx5oMHJnf9oyjPDeLN8rlSQ0OWuIpQDAWjBm/QmSNEmQm041WalttbEe/eyd3MKLT9grtnNtMt6jYw9D0maB7oPjUX7j1xJj3puc3rsc9oDkCDVb3M6LsY1xX5wPuCNYWt9+qRqpMfKFNGhr9TOUoMOJiTruLHvxOkEYiWbPv/FjumrCBUZQG6yNVgBpA2M59y2MKuvlQ+DZ4wK8L6T/sILa4oOfOauz7B8V4SQPOuKY0THKVXBleGAOOrxUL0WlS0P0rm1iFgpoKRGHwG9HaxsN2tNSk026vZs822A==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CY8PR20MB5499.namprd20.prod.outlook.com (2603:10b6:930:55::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 2 Aug
 2024 12:39:29 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7828.023; Fri, 2 Aug 2024
 12:39:29 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
	Jinyu Tang <tangjinyu@tinylab.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v9 4/4] riscv: defconfig: Enable MCU support for SG2042
Date: Fri,  2 Aug 2024 20:38:41 +0800
Message-ID:
 <IA1PR20MB49530E505BAEC8F92B19F37FBBB32@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <IA1PR20MB495337877FFC8D787A045C15BBB32@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495337877FFC8D787A045C15BBB32@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ZyDaK4cupEPhm8YJys4baKMhB1R4Wvbih1W+t03Lk+0=]
X-ClientProxiedBy: TYCP286CA0061.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::13) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240802123842.1492286-4-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CY8PR20MB5499:EE_
X-MS-Office365-Filtering-Correlation-Id: 35132327-4aba-4d3b-8029-08dcb2f02688
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|5072599009|19110799003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	7e4/caVhvzWU5O88+fmuwBXrW9H3KCguEDOrK6tzibEwM7Q/zVCBH3hxtLXez3ayWLgAtoObusN9nU0tMMm0tP2JAakT0jRHG/ks3vUWqtI4yjhQdmn57BjFUcfE6jeTqUsIRxHhN5vUKl2l4NH17SW8wq+WdTymHDjYLsv+N9tkW+I5jAtxDV/kFVH+JwdIZSiZeOU90tHbmGzFI6l8/yg4+e6vcbWPdVD/0YZoVCWNwyJbjrWdfh7HhD2lj0/v1rDKvvNTo13QEA3V1uE3at7+UeoeFp0LuXXyATaK3SRhFSi8kRm6XjuF5fsrey10WAUlcEXm/h3HjPbKJMUckAotqp8DJ+8JroGikrhDitAkM8w+eg/bBDN4WFu9jubdAAZ+nu9hIDBA7gP1j1VAP3Gd2gOAJ9eOGgv3F0mFCDden0Yw1uSvlB5097O43PEV0WB54AcBI37vbK442a/k5vE3v/bHCW4wOSSBIYY1vMfbggiDmzs6OoM0vbHZaCcxRW89djjyegzH1O+FQnrq7y+lU+B+5swawdkW8Mnrzbh36T/0HI2cCexPB9hC0syfQBZShIUqrQ4YhNr2584ofVH0pxZd/Y+UMjFWP/8Gf7hmJXjdz6UpzDJhAn6B3F9JMR687ZHBPRZBp36JERAZ9mb++mMVyAX4vpocFwXJmw3856UGqZxVMpRPNYRyHqUWZ/4JQ7p2JOj1a91DrYPytQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?liOhYNkVlDjXewjOAaEj12dQKc6k0ZjXXL40hqRO1HCK29jTzuPdaALrM0dO?=
 =?us-ascii?Q?SnxPU1kquVkll4nwWsEr1olknQQstdFDas7X2fSxT0swBFguwZ1nn0dSKOds?=
 =?us-ascii?Q?tt7ykXhzpqhuR79xoowT2EXpBjXhhqnX0RMUzOq1c6Z34wOT+M59WPy8DgLV?=
 =?us-ascii?Q?tSUX7i9+5ZqrYYt7ECB/97e8aEtw877/UUvxVUcYXyU0az/gOUAuaVqE4B6U?=
 =?us-ascii?Q?NBrLJouVTKrqmPdMEqzfsIwF2MNeMV6qkAr2aBQ+4LU3NlGJ7SEO/X4b3vCQ?=
 =?us-ascii?Q?sWQsHjI9nYrVOINV4iOul5hYY8GIyKV7bnVN3rYKolOo83WQ+8O3/Jm2590f?=
 =?us-ascii?Q?8i7R4jichYOXRXX1/b26DzjJczqztMGU+LYXRCxXzFhpss10n9avNns2Y8Ii?=
 =?us-ascii?Q?VsX1dkDBIOd34MDopbqfApO8Yk2eSpWYg8only3BHEa7Q5O0tveEWhfE2Kpa?=
 =?us-ascii?Q?ce5sUStjGU/iUWi+ux4EUi9GAoeu6m+KPQQADU8gpwXAjy2d8Q26HNs3mdYU?=
 =?us-ascii?Q?wcyVS089HJ2Dqwg+pM/uTkrLRLNmgW5f+nuvorPXd/z9CwvnStuBRIwUbtqP?=
 =?us-ascii?Q?1uavYaiSbsXBCmbLiBwmlSHEniQ0VWuv9z9N/9KhvKnkYnynP1CNOlLhVjBm?=
 =?us-ascii?Q?xnnERN45pQuVSjt4m7hpuDSYl112bRPk6qTC5Cr9QpCYTHBT0HEb+qPQ7dTS?=
 =?us-ascii?Q?1fSqZNDHJgMsPu9X2O7tpTOMuf481/knrqYWZx+HY3i3+7k5yO8KnSVUI0hj?=
 =?us-ascii?Q?+6GnZmNBv4vnyO6oflAwW/a+pgY0irFiCzHz1CUPVSpkSz8p4XW6cIo8/puz?=
 =?us-ascii?Q?iaov1u9BPp3g2AZDGzAximxK35EydsZDMd8ff36an51q0GvleuThqEnW/t+O?=
 =?us-ascii?Q?no0ncJwSXIeM2LYioPDBlpbo9aQEwkR6OZF5f4PF1GrJ8w06dRHUFJETDS6k?=
 =?us-ascii?Q?e0W52VzSPL8W3oo0oCxb0V+G7LaCXIyK0c4ofBFDSeVn4OGmDnFNi/p4coTY?=
 =?us-ascii?Q?gvFXnJM0lXrzMqQJI3OxPfIn/7BhJlCcPjBuznVKnzUpEt6xLaeyrVW6qwX8?=
 =?us-ascii?Q?ZWGeeYMs5dj6Vb4Gu+I/0Bhu5fXBlu6P1xMvPQ9pXrMm3jXAtjXpTchXLF85?=
 =?us-ascii?Q?zXTZjFW+0Gr79LEBOKgx7wJH7FsMBc9QwYFAvG0IsUMY6iZU7io42Jrmunrb?=
 =?us-ascii?Q?Ltif9ML6+Mi0Z0NizLx6xSSHSW0+CXwMC5AD5HWf014vXqTt9v+Csp6sH00O?=
 =?us-ascii?Q?mq0HAWcwv1a7mILR2vbk?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35132327-4aba-4d3b-8029-08dcb2f02688
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 12:39:29.0125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR20MB5499

Enable MCU driver for SG2042 to provide thermal and reboot support.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Tested-by: Chen Wang <unicorn_wang@outlook.com>
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts | 2 +-
 arch/riscv/configs/defconfig                        | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
index 8b8fdf6243d4..76375e25a495 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
@@ -67,7 +67,7 @@ soc_active3: soc-active3 {
 				};
 
 				soc_hot: soc-hot {
-					temperature = <85000>;
+					temperature = <80000>;
 					hysteresis = <5000>;
 					type = "hot";
 				};
diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 0d678325444f..a0f346301df6 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -170,6 +170,7 @@ CONFIG_SPI_SUN6I=y
 CONFIG_GPIO_SIFIVE=y
 CONFIG_POWER_RESET_GPIO_RESTART=y
 CONFIG_SENSORS_SFCTEMP=m
+CONFIG_SENSORS_SG2042_MCU=y
 CONFIG_CPU_THERMAL=y
 CONFIG_DEVFREQ_THERMAL=y
 CONFIG_RZG2L_THERMAL=y
-- 
2.46.0


