Return-Path: <linux-kernel+bounces-266947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E04B940A38
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1920D2836CB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD673190688;
	Tue, 30 Jul 2024 07:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lYzWXqpl"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2062.outbound.protection.outlook.com [40.92.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5F010E3;
	Tue, 30 Jul 2024 07:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722325787; cv=fail; b=PN2kaCCoFLHUvsF+5y6RQpfnLtMgPu4zZiT9HzUGTeCm18B+Xm+BZ1kU6WIqCob4tbJ8XzvANHHNtIugdZQtStKb9+bw4KfFVVhWYdJdiBCaSeLSERA6DPCfWr1x4ELWQdxBSqNIUECzjKJk/2bGs/GZhwFFTvRbuw0KUo2PTck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722325787; c=relaxed/simple;
	bh=4/C16IMel2BeDmIH2j3Z3fgQllB16/OOOwWshluf4E0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Bw0OFFUwV8ECT07lR335FaL0cnAkZCasDBt+cAGY9RYFGm79sLIuv1sm/dPYSQPQECAxdN7hcfZrFMHZ+jzJwhpunc7a02IvhrxdCtKala1uB74nQbhDj5kGMXN5r54JN7oedVKmH/EYRJtbvmJM/U6TMTfJM9ZNwQPXkwrgcjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lYzWXqpl; arc=fail smtp.client-ip=40.92.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Plb3ZuAh/wOlKYtvHO0ixcAWg4poHZ0ixV0dT72ll/a8zPUqDpqJyHaaQDBuG48dIDgkr2X+yPpsG5xcJjeNSK82Ql8+WoiGtsQnqJj8Ju/TJfGKw5yY5aXgxnmRtNrL/aIw1LW9zVzIKeqTJQcwNRKLwe36mm8a0zdZf74ZnOuWPc9sF7Dy9SUYnTDoDLEWq3E5/Qua0jDiZrjBNSwriM20eQwCzQP8/oGWXYclbaDHjQUlRwll6HPkiStB0BWM8HYKmSSpCWA6oCL7V/e+gSd5/mMDvHvTJc9SJMmxem4+pI9Q+MeYSQLzXQ+JBoD4UHLzTREiKuTbMeDcl1ay4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MDIH0TdH3THLul1CiKzfxoh5McR2HGXNJ2L6FJoGMs=;
 b=mYXQWKyzhO/SSY3Fnt3N75yKRG4j7G9U3UULtEZtxNLSiQ1Tba0Ggmh6Ag6I/1FO/8c2wnkjzMExEaTVfUgKuzw+l2ZcaLIQsDtMPLc1XfSwpc+q1/ZoH3Dg5u1ifrFp5thQKKCRL3HWqSQMOo6mxNChfTWjkykabJQjhvd94Sg/ak2qev4k2v0Pjqmk/EmVJqFs7vGq0yIifFNICdPIKsg544blAg4xP37eh0vdWZVFT1YEf4IycnE4RIcrmKEAKd4VooQ2+5XwamMqgxTeKF+yAdO8isjQhsBBYyt/osZu+XplzRUIEk6B1EHBOsYlMGBQYwnCdLtDKu+NitfGPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MDIH0TdH3THLul1CiKzfxoh5McR2HGXNJ2L6FJoGMs=;
 b=lYzWXqplN4XPAuVMeA99zhEr0hz08yq+g10+5auAgl8zvHX7RDvpGEwnP9g0M0YUA1yN1YDNhSIzneDv4aF8jVFk24XGq9DD1hPL7VoLind+4R+/JKkh6pzbRgvlugAnrfIPiCLxfPn+Vj55ob7FITltVjsucCrRgMTflqvgH7XXyiH4pE31paLCFmMdV8G1dn1HmNF/9vG9ROvJ7F4YbQamGjjwUuJtSGXkqneKxwXlu9Ms67WE40cn1lxQrDi4ozYG3tC+1o2UThme8XnOpSth3mhyvUSI+zNJSYHPMMyWkTUxdN08QpeFuN+wNMyAKZ2VIRm+/lP8UWu642UHBg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SJ0PR20MB5253.namprd20.prod.outlook.com (2603:10b6:a03:47b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Tue, 30 Jul
 2024 07:49:43 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 07:49:43 +0000
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
	Hal Feng <hal.feng@starfivetech.com>,
	Jinyu Tang <tangjinyu@tinylab.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v8 0/4] riscv: sophgo: Add SG2042 external hardware monitor support
Date: Tue, 30 Jul 2024 15:49:13 +0800
Message-ID:
 <IA1PR20MB49538C09E94D90F07B7B2562BBB02@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [zfw/hIWxqvcL1Cq+vX0SJ0YG2ugcqXjORz1bTFh6noc=]
X-ClientProxiedBy: TYCP286CA0039.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::13) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240730074915.486187-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SJ0PR20MB5253:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c5dd5a5-8a26-4641-d0f4-08dcb06c2ca8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|19110799003|8060799006|440099028|4302099013|3412199025|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	VNqfqXbd+rNWtTQmcn6KMSYra5fHnJwRWKfQ5GMilwbnMgYEgs7FZX7kfR/g0sc2T3mucAp3zatIDOPgdUCyytTEJ2zDRR5vker5bZOhVe7JzMc2ijQd6b8xqkkpaIJEGu1062IcbVtaRuvA2upDfBXcjibit/kR+tJZUHYbiSHgebPEABC3t5R4KYML7Tl0n7mPJVH1pLh4yaFUBHevcPaPPgGu8obml82QlDsvZ0EowEbOlPNSuw3T0WkaOi+hJMv/AqYnu8yxj5Om+42JTudo+m/pi1wSy5oJAyHbjQWrO3dPidMJViTKGFvr2WGrktAoNGwf4Oc0fe7QhuC/o3Ow07mGXeQoOrIqdoomU5PKieqhk+G8aYbBD1N3DvSDQuaaFYkuurEY21WqFJYTm+GtiE5IfRw/2HfzHOIkpYZzM86f35lS5ujdHB6tW3AATAE1wMArSq5miegVO4JeviaZw6IZx9wtJL9zzxnzcII/mrjoMgmewHE0L8NVK99jRN7ANDY4GHb0hBIiPeyJxnsIZ0j2iIMLKyy4cwI5RL+uQz9HG0P1NCzzLNd5xFYfLTuqByfs3cO4gt7xTxaejzSx80MrQp++tu9YetIZEyCGF112vmNcBu3mbjgrQR4wG2KTqG6YkqLaA7BTapGNioF9a2NHck/yK1mx9VFPO8TvkEX2v6Xc5h0Qng1oVbehaYPsfmiA5QQavpwsFPmfDZodt8jqHYoTR3hf/ES/c3sMAG2dGQxb1OskqnebgPNX3xsvJpWvoydXQAxvA8dbbTGK4GFPQ9MDfwlj3syzrN/+Ff/4eYLKPXOU2SEQtOME
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+ChfMbh1DA0HuVW+vo+i5yKckQcnWHzhB0PlMB8+DgveIAeLw4eqMPJ4Rjo2?=
 =?us-ascii?Q?zFdpIy2x0S6U65BvCQs9HRFcIsATmCd5wFIGdIvHAmEBglP/9+lk3AN5Q2as?=
 =?us-ascii?Q?gyujgNgNvCJxFijCMjR6mpD9p5hje7XiTr0nrucXaYw9cNS1kaBJ1oWXqRpy?=
 =?us-ascii?Q?9BopVT8abrvf8JqW5E6Gt7XuROtwlHYVOkqvKsu/CB3tT76LUJkzg6B3NGpY?=
 =?us-ascii?Q?RjLaUXT9JWbrFbTcVfPvKwd22J1ulaofvGUqtjJ7eTJEq3z6UHcMrvjlgI7I?=
 =?us-ascii?Q?QGw0PCLJ714/zOSt7y7IFo3VIg6aJDhehkSVV/qg/scSvM+AyE/5fxNPf/Tq?=
 =?us-ascii?Q?660/aGoeotK/noJV6O5/QHdn2zAZMBtUEAJpPOaAxSz23VoDIl2dLKf5pC0O?=
 =?us-ascii?Q?72GHWogCr9/yILDTfU9idw4wLlXAarrGos59/Zvo6U8cxXL8Qtor8ovJKLGB?=
 =?us-ascii?Q?m1zgWPJffdomX3SniU1/puyFMGAdk/Olp856DjOq43zSfqEbudl0Ftk/7+Fl?=
 =?us-ascii?Q?yYMlGs0UtYthKmDRuSTNdSvpSA/uimEWJ79u60PoTlaohRMwkNynODyn4zau?=
 =?us-ascii?Q?eV7X312ZLZGebfFnU+qp6eiBQL6DOT021l9nBazlvu5RBI8QJDVDxFM6H5Uo?=
 =?us-ascii?Q?wx7jyOumwibvZJOxdr/EMkQzapg/HNXEQAo8z1eP8V5Ivdf8tB+A60gnP7/v?=
 =?us-ascii?Q?slwreTt52wx1M69DkVTxB+cc9sASSg7eY/4D4Lrd1pL2F99RkNLhdQ5c37EQ?=
 =?us-ascii?Q?xVt9FcSmgeEcWqOjwdV0+yDBtOaZgVNZtndgIZdfknMhNmKVXc4yF0NNY6cJ?=
 =?us-ascii?Q?2kDKTXon38ijbj1BJDn68UuyULb3ANNFVCoq1FgE0SyO/rpc7chC+dPmkRsy?=
 =?us-ascii?Q?ZnfdVxhQgmkEQblMFFuGmfxfO+yY6OCP9iYqWnntB+5StjVGWAPpSfQGySAO?=
 =?us-ascii?Q?Z3KXxy2wOaA0RWNE5BqMhaJSqXDROFtW2onndaA+90pR9Ol5nVXzwZlfrXyb?=
 =?us-ascii?Q?GWp2Oa0Aa3mOtqESDzXOzIunA9+sBJ8iPWzweDj5BFtJc44QAELadqz2TI1d?=
 =?us-ascii?Q?zPHbfDBo1uO+1tVmw9iEGfEZsrpwYr/YI7QYLcHtelHxnnftf07zm47Nm00m?=
 =?us-ascii?Q?gGZVRtlEMlGDH7copyGDKZ12TJURRMQU7TZf6Mu5jVaAGVlyyJoSg+NKMsrE?=
 =?us-ascii?Q?hxsJsTSNaE44OaZJmPafmkWbKs8E94OmXaGP+gca1OH4V45i8iPpUpSUJP5o?=
 =?us-ascii?Q?0UuaXrYiBRoyFXBlQj5q?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5dd5a5-8a26-4641-d0f4-08dcb06c2ca8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:49:43.4314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR20MB5253

Add support for the onboard hardware monitor for SG2042.
Can be tested with OpenSBI v1.5.

The patch require the following i2c patch:
https://lore.kernel.org/all/IA1PR20MB4953DB82FB7D75BF8409FFF4BBB72@IA1PR20MB4953.namprd20.prod.outlook.com/

Changed from v7:
1. add mutex protected and fix the return value when writing
"critical_action"

Changed from v6:
1. restore the driver name to sg2042-mcu
2. remove unnecessary wrap function and check in the driver.
3. add dts and config entry.

Changed from v5:
1. rename driver name to sgmcu as it will support more sophgo chip.
2. move some attr to debugfs.
3. add standard crit_hyst support
4. add documentation

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

Inochi Amaoto (4):
  dt-bindings: hwmon: Add Sophgo SG2042 external hardware monitor
    support
  drivers: hwmon: sophgo: Add SG2042 external hardware monitor support
  riscv: dts: sophgo: Add mcu device for Milk-V Pioneer
  riscv: defconfig: Enable MCU support for SG2042

 .../hwmon/sophgo,sg2042-hwmon-mcu.yaml        |  43 ++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/sg2042-mcu.rst            |  39 ++
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |  60 +++
 arch/riscv/configs/defconfig                  |   1 +
 drivers/hwmon/Kconfig                         |  11 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/sg2042-mcu.c                    | 406 ++++++++++++++++++
 8 files changed, 562 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
 create mode 100644 Documentation/hwmon/sg2042-mcu.rst
 create mode 100644 drivers/hwmon/sg2042-mcu.c

--
2.45.2


