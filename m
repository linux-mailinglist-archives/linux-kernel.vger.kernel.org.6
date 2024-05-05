Return-Path: <linux-kernel+bounces-168861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AAE8BBEFC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 03:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4C31C20B48
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 01:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A494EDC;
	Sun,  5 May 2024 01:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eN5K8zr/"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2032.outbound.protection.outlook.com [40.92.41.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ED717C2;
	Sun,  5 May 2024 01:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714871857; cv=fail; b=u6GZEA2YWQsVpg/sIthocKgQJecODtrCgjEe3chUl2ShtTps6+ES1vEZPF0dJ95IWgU/EOBuwASfFVirN5Wm/BLpwUqIqSnrs4sfc3LyTTz+w0WRAM50O49upZZExVQqvREQqBJlWyw1XRbeAUUybzHwlX1z2uxcIwvMCpJBffc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714871857; c=relaxed/simple;
	bh=5Sxz0eJdoPtt5AzgQypkFwOatCBX9PP8mKOSCrj9YdA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=V+lDb5z/TirYXDUjr2BQeFpp+nr1Rh+sQbcKJJnekeFhYPg3pWDs6qLeM32cXJa9OBsvrhLITRb4R+owaPLylB6JbamKVpkuvm7vBkSVHP7Wb+jo/8Rc8V3gr6EbKW9UfhPeMjPsSSXxy3+eEcpuaTYTPHBMLa9Lw2sW4INJexc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=eN5K8zr/; arc=fail smtp.client-ip=40.92.41.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWiLxelx24z3YRfPkCDpK+Zg7Vqm6s7x7X8RWHTIa6fjbQ+KVEfQLaCKDG9l/q6xHESHiAlYtW33cDdJbXQ/jw5f6yYx5l5mE8UtIuh444QPQAXrBrw37Db5fKTQSxnLoNNf+4fN7wG837R7YjmeXl05uPPM9B6fiKTHeITOpnzStA9PLSisZHdKzl2hXO4K8/SJ8GKHUleLRy7OwDOG82ixtbnCcayL+ZzmuHo2Hq1v72xwwTuJgQtdYgILjDojdeIjFqIvl3Yg2Hx+Eq4veEX9Yz2JJxuB2Dd0KCeega7cHKRSh5cnpPzEJrASpCSE6W9XfPvtgUInmchiukTD4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3nMaR4cTwWMZxDFxLuA7cVFZ9e4fdVmOLkkfBCle0w=;
 b=lWD6gZnaIRHUqlwMGvzmvM0tJSHMLjwOz9XqEF+95BzL9VDPLnygoUf1ZzM/ittdkyhSri/E3EF23yANdRlkvePM5nM1bRo69AFcncGuQ8WMBgsQdCsQFBJL6HxLLWmsuvQyEp/wLZR/+vZQhBCsys5ekSRXUPy42CSZRnQg7IRCMdCpgHdmf/+ORiVzZhxjXBziT8f3CyEzvjPfoW/+UK8yb6PJBlpoPQ4qnbBEd7m/Fg3iluUQRhXxShdddsJ/75PBM7MJFrr44nbDp4KQAHknwtsMlXv4wK1V6k3KgLT7l5bK6zfpKSdn8HxNFf/Rc54NwR3o9l3L2rTZKV6sIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3nMaR4cTwWMZxDFxLuA7cVFZ9e4fdVmOLkkfBCle0w=;
 b=eN5K8zr/p5CFrql/XYvYS1GpZzJTE/K+tWx3/S8giLpAqJj5yNHwm4HSqiDVvoRyGn7vjJEyPvLjD6lQzfWnJw79CUkQcdTSj3tsKz7ZYls8L07pJi4r0AbFDGtaFJ6yCL9Fj1P00taZhmLb4Tq27I1iJXlCjZ9k/iCTC2h1XkJQ71H0P7cgrgxou5ip+ZwOf1l5zAoArmXy77LQRQ/RnbwItgTQkGGqK1m/2JkQ9uiOAzjLb2uUFRV8C4jkky0fFZuPm4IT2zzdvhdAF68FEl+SphnNdUaeGmC1VgZhi0qfiX68rbN6bdFeYc1P/7wa5Yc7TdXesux1fCHEtS3O7w==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB6964.namprd20.prod.outlook.com (2603:10b6:806:3a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Sun, 5 May
 2024 01:17:29 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7544.036; Sun, 5 May 2024
 01:17:29 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v5 0/2] riscv: sophgo: Add SG2042 external hardware monitor support
Date: Sun,  5 May 2024 09:18:00 +0800
Message-ID:
 <PH7PR20MB4962C6D8FD6989BC79F9483FBB1D2@PH7PR20MB4962.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.45.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [h5eO1W7XnBu76wb8lUvbN6Sq9JbTZj0iKUUArmOfHFQ=]
X-ClientProxiedBy: TYAPR01CA0129.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::21) To PH7PR20MB4962.namprd20.prod.outlook.com
 (2603:10b6:510:1fa::6)
X-Microsoft-Original-Message-ID:
 <20240505011801.356972-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: b8dc15b9-7383-47e1-b876-08dc6ca11f32
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1602099003|1710799017;
X-Microsoft-Antispam-Message-Info:
	FN1vYZcnP55W6M3zjAT/lJbbok6GQ4zccn/twetKL6KnhRP0LLVFSFjsrcWG6tG/qw/8eXNm0jitLvysR1QLapJ1d9RgG+o0/WAWNwDM7slLf8lUNiagYqLJk4ZtFnwXBwIsKjrpv5EEn9JkSHeeSGhfNz9wSzIodI9ZSFqimvD8BqvuSgLynxDmIPZUeRYlVKCD62M+ww3p1PyttzQpUnHCo5xJ1WdYaka3KFAUKb4SaVk2724OVL+Yreq95++DaAN5+ddojj+NhUmNsLP8w6sJQfqZUhoHUnvM59J/TqhuYr8jZ1p9EXIZMdSpkpk0mUwho/toJot1QriYhxZCBhAGky3D3rukkMAJiaC6rNFXy/SElv0fltp1nnhD0wQKyEOm20qZ58/JQl82In+XTZuWTAiYvASAOpwPurfYg9PAHHjFngwE7XzbVtXBaFOP5aeIK8iY8917QbEGus4c/aaqGFO3Ff/ffCOSB7FwDWjOwidY8EA/LedYYXOANHfD8ljzNfvderlsdi5HEKXWvXfwn3isZFLt8450/7cDXgYCSmW8CZvDlENJJUdt5ybPmjIuMzKd2vJ9mK5r4fs8YydG0ZnIqot0WKZeFf3G+kKlYj2wYD6x2g+MxAcytOIgQ4cFmDioS/tImg5TowLHn+qOAi7+uV/Y6WsSWx0XdDfuEUbbTmBXnvZEn9/nIYvK
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r5giSZn9yeVTSwu0w6jTyeQt9pXHjgmGlOgygu7GrIMqVJzECka7ogLcxPpg?=
 =?us-ascii?Q?cp8/mJit1afBiu02iMxplbjtskJ1hg/pQfeaU/f9A1/9kaqKrGTHzTXqlmwe?=
 =?us-ascii?Q?mdHnDae30OkisN6g0qP5QopRLxfcrOnKHdl42o15YU68vDcQyP65vLRDTcNk?=
 =?us-ascii?Q?sd2brUxU0AbIEDlSmnKuWTvDOF9VslNyCQIFDuZ81lGY1ObSTq48W1015hD7?=
 =?us-ascii?Q?yKBhGiPLaC929hXRZQuOj0En4rsDnOcXnu6k54k939nAie527o4tDO0dzs6F?=
 =?us-ascii?Q?HMWefM5KukUfjK+AA/sBTGtNHGVuCku7M4kkX348NgOoujTNmhBtjjlr3dVw?=
 =?us-ascii?Q?e4zWUmWeaEMklvLoLpemnIZbsFaOGzJfawPSUoyXARW3SaeqBp833RmRZotw?=
 =?us-ascii?Q?MRXt+ZGyMPnvYNUJxKdJWjaccT0xFksuLRxsiWkLpAB3U9+TMZgM9rfx9HgY?=
 =?us-ascii?Q?YCpm5ZioGGV2gWQim3TSh57dTlZQDwc2O/qa9YsLbF/2e6FE2Zm8sDAhH2L/?=
 =?us-ascii?Q?ub8x8mm9uq+FOPX+fQmkCOvnJuytMaeIR2pvWgFxaqNtMzMbXMIHPDDgRNqu?=
 =?us-ascii?Q?MNxChCpwmTThlcGxFqRhld4htqt39+uaI9JvwQmN/ACuOQgOcRYbQxlyIrYK?=
 =?us-ascii?Q?xUCmgw5geAatcEyV0FNbCpsuLWuBjm2ZozM8//PFP3biCQXkbErOCiQSedkt?=
 =?us-ascii?Q?CWY6iMlBysIb5iKEUdGUDGXY7DKoSoByx+drnr4lp66zzh2/8hDZZ+eGNd9A?=
 =?us-ascii?Q?yzF0sG9Yn6XIbrpCWAQO2a71Z7cXkco/vMco+JnVE90D+G9d8AApFgTif7Zy?=
 =?us-ascii?Q?DeO3HClfDoX8zlAEeHdAvpfhCWQkn6wWU49xWTIFoASKJdvE/ZMKlpa3Wvb8?=
 =?us-ascii?Q?H6YJfE6tgkfBLJ+8vtZIRg14+2yWYVkVdxRQt7+9ULsljbr9hWFQX3CWT29T?=
 =?us-ascii?Q?NBB21SSaeFbwCKib0ag+leAR65xQ+dD+Nopzny9FA3Pyeak3WaVPWv3AezUL?=
 =?us-ascii?Q?6NVzQ3Ldu+24hbyyYMrDoA8NkGUeh+mSKMmQuzP9lmDsucvclIJ6YZGGxzNW?=
 =?us-ascii?Q?bpcEivLkCF8oFTySjaBRknbJm1MTmwNmgPXGxbqI4J9je+CrV1dAbcL1ws3l?=
 =?us-ascii?Q?3gca7YppTFva5ZROdSqBuXrnxUSsCEGI7Y/crE5AuVTGXl0zHU7i98Zr6WqZ?=
 =?us-ascii?Q?8G6W/ULNXqvEX87ResqnHDReHWkjeZJvMH3LO3VS97EgPcLZJIk92wN3L5L5?=
 =?us-ascii?Q?k57fVHVE27bxe8jButc5?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8dc15b9-7383-47e1-b876-08dc6ca11f32
X-MS-Exchange-CrossTenant-AuthSource: PH7PR20MB4962.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 01:17:28.9527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB6964

Add support for the onboard hardware monitor for SG2042.

Related SBI patch:
https://lists.infradead.org/pipermail/opensbi/2024-April/006849.html

Changed from v4:
1. use fix patch for binding ref.
2. use unevaluatedProperties instead of additionalProperties for binding

Changed from v3:
1. add thermal-sensor check.
2. change node type from syscon to hwmon

Changed from v2:
1. fix bindings id path.

Changed from v1:
1. Move patch from soc to hwmon.
2. Fix typo.

Inochi Amaoto (2):
  dt-bindings: hwmon: Add Sophgo SG2042 external hardware monitor
    support
  drivers: hwmon: sophgo: Add SG2042 external hardware monitor support

 .../hwmon/sophgo,sg2042-hwmon-mcu.yaml        |  43 ++
 drivers/hwmon/Kconfig                         |  11 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/sg2042-hwmon-mcu.c              | 531 ++++++++++++++++++
 4 files changed, 586 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
 create mode 100644 drivers/hwmon/sg2042-hwmon-mcu.c

--
2.45.0


