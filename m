Return-Path: <linux-kernel+bounces-272555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49348945DDA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D251E1F23AAA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 12:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CBC1E289C;
	Fri,  2 Aug 2024 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JZ1aV9KA"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2066.outbound.protection.outlook.com [40.92.42.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F1C4C62A;
	Fri,  2 Aug 2024 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722602307; cv=fail; b=lsQOjXP8TbG8cphaSkoGnI11Sx8lSJK0IrEMngzLmUgw6xBEsRr6CBasZwZvC3qhfFiY7nuR5ZiZ2QsvU1WZV85Gcj5lRcM+rXncdZGQso9eUgvZaJsIOCWwWq2riBOlTyp/wGgEJ26GlLJdnBlqZS5KBvbPALxjSzcMSXRXK/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722602307; c=relaxed/simple;
	bh=SXiX+JhOAsuuEac8uNPawOhvQfU9/U9GSpkOWVFRpLw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rFap2V7woZYyuvsqg5wcVDaXFjG/SkWMrELkRMguIcGiwQZGW+DZMIJ8NdRqVu55w4O6kE5m2w5ccWvygMgD4l+8FZ9eja7v/8qcEgzyBjQOTTVndLwZwjFhl4afr0/RoRimZCGQPDLlg4HA9VaWHPkiKOknZqKTH5L28NCZzLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JZ1aV9KA; arc=fail smtp.client-ip=40.92.42.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stUzzcInrEkSyTgm3VebBnRtT66YKBgRzWhb+0G1tDYSJc6gXwxAOJEyfkyuMPJ4bEFzuU5pnCVwPcRPz67UQNaeNzt5M4jUZxX9pq31Y0KSAmyeuawoUERJHRClWY9YdvJkUU5bjRxIukIE4TXxs3S4xWBWEulJsrpoAhWbyro0T8gKqzdGdto0T4sagGgQQnUsLVNJ0inbdgTL8SepK1shYd6ETZ2aIszZLDFhpO3i0YG+1sccDlwpppghqqA8MYaiCkl6UBl66UL2pS307dERO2Ixlki1IqWRw583emHA4cc+vr9KET6OCKJxUIoaVcJx+JHVA2hulK94WCE8aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyPLx3dH3J06/QHmBZfVMwhqHCc6KCM33ABBrMEkX2E=;
 b=UPhutQzuFpzFsCIQa+tJYuR4sgMVwrqmTsWAnsFMkr/qNc0HxDvYQI5phCtTlwPoyt8QFaEz920dQzfUMhB9MKxA4RxwmoC3JsXfpxz61OgNrCG2W4IYTeCtKKPDEUMGxCpl6Jkn0192mqJVnXvytmmPiwuvt2vJkoOfhugZ0NpZJoPCSyYZ3/iw0kMS2B2hVdXqpABTN+XaE3NanIJRnzgEfweAR7gPljx0yO0Ij+nkWTYr5Smq2e/tWEYrZUbtejmVtu+enKdGHzocZmo1WwAxD93PI1hl0GAgXZpOGmBVkfDUJlVsGagF0vbnXnXa173ED5YUq1LUbKlwVscLng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyPLx3dH3J06/QHmBZfVMwhqHCc6KCM33ABBrMEkX2E=;
 b=JZ1aV9KAS8UP1ErHI11XB94BMWHq7KylB0VpshGJC9NQhFy9tPLZHFSSdU47ZG44Mc4UlR0dz9LEb5Z7zBS1grbG+5D5A397UTjoeWwuRSQ/EytF399iEgFKVF9pDQu2FPhp5WsjZMFCs4udCiwgAeeGAccS3qN8KJkf7/Ahc1Xw5JCrbnPuSfticdqm+rCIrEAXGaP0tseYtqksTNHLt3LGCCd1a5faD/R81D/GADSL55gsWAfpWxhJV6iG8bHZS9+sr+T8ZJNo3GWnTEqgs0F5+mUckvFdB+pRW9EhGxjl7OquRgtkjD7hPThQUHLYqKZ4Tlz2OxifSfB9XNBVfQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CY8PR20MB5499.namprd20.prod.outlook.com (2603:10b6:930:55::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 2 Aug
 2024 12:38:22 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7828.023; Fri, 2 Aug 2024
 12:38:22 +0000
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
Subject: [PATCH v9 0/4] riscv: sophgo: Add SG2042 external hardware monitor support
Date: Fri,  2 Aug 2024 20:37:45 +0800
Message-ID:
 <IA1PR20MB495337877FFC8D787A045C15BBB32@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [kZTd5wROl03kzyYGtwtycrxQVFY4NKFBiwMCEDzfzBA=]
X-ClientProxiedBy: SG2PR02CA0085.apcprd02.prod.outlook.com
 (2603:1096:4:90::25) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240802123747.1492036-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CY8PR20MB5499:EE_
X-MS-Office365-Filtering-Correlation-Id: 30062de9-334e-4337-e11f-08dcb2effeb5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|5072599009|461199028|1602099012|3412199025|4302099013|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	4ond3ZCtATvtlKc/nTw9H7rCZx6nPZhhw8xFwzti2B6D+zanXeSy2cP1gT+K4WxSNyueztAmnQYyCRVwnSEgCTOSv5e9paywDcXxwiTg8E0MqE31BaCeaSmaMi8GsaumfPjExUQtfTa1SpI9PPOcgZ4KVRqgA52swOq1hCbsuqrsZvGoYM2nLaRBiWjFR3LprMhS7xgvda7/pzpBuY7RtgbcTlMGgRFNN3ioxEyg+nGf5c+Vhlu0ZQN0qf7azFR7q7W9LaM8XoL6Q5nkG+VoPOcoNgaHaYQOC9fdtVd5XEbF0GT6J2xX1wOR7vseeDhtnn483zMtE7M9I4sm8luoZwzFrqp1qyIMNGA5xaV8fwBYhIlvKqrfS/CjJKzFaDnZaN6QdrnzQgfkTYHokIBoL0gsMRShn0bD9tm/1hVn55vmg7BP8fAHSsyoBYj5qkDR9GrkY1GUxxlDArDwrLyF7OKr+YVbDKDkQEwD91qIiViBNBBHXv5Z/3vNHo6CuP7ZiPTAiKXGWFzUu/ytKj4ikCaqWc9AOZClcK7Vl5qwke2jIy9yG6oQoInBRk/lh1OIjvB/cFvb2XieUiUeekarND73MvpiSxCTqspYaOz6D4BalEa8s06I2iJJZsD/K0+VgYsoITH3IEUImClQacavYcNTi91h+pjXU3V57b8Ul/DkDwZqN3HpTMEhIMLIThOSQNIWqwIUteA0UWMnI/UIjVQE1gk4jJk4mkg3giie26h6/PlNrRrZ3QHa/XJ8qFVblo4CzEjKq4y8Hensb+xIa8d1p9myiHrt8mUNdDfcBlH9jZtO8iDhp3fMDE2YHPSu
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CbgSzSIoTFoih3cTBtohdp7GeADGA3wkSXxCElCJzDz78tk2Sn8jpDfgOVZH?=
 =?us-ascii?Q?qgDOzoO394NDXXUApmWlG7F6Jl9dExQs1NjsM077vtqCqAg1lO3W5++UZo2s?=
 =?us-ascii?Q?VCqoPLeBz0anCs+cK7U1Md1sHaUfJUx/lZ9IJs+nwMAwS9ty2zL0JUU9CKkC?=
 =?us-ascii?Q?Hm0BTy9UTmNUL2773DNopi9Z9a8yMV1b3gUsGcq7V0lQO8DqsqtXGUE/wuPC?=
 =?us-ascii?Q?Dmp4zmkM6Ly1SdfyyIAJtc7U7ZDlwDPOChWmq8LZnJcJgOltuUzFhLLMpdfy?=
 =?us-ascii?Q?d/EsyMRSSHq8A9gfKOjPh8bcc5rCDbRnlfmLzgZVpIKAVKM9y5KSrv4isnrb?=
 =?us-ascii?Q?DjZiMhX/KpwShGwGs6qTZtQ4KcEW/V/k+33ToK8D/zd0TcTgYzBWN9gztOPP?=
 =?us-ascii?Q?fPLwfmw9fJly7QM9E8p/FAtsgro4QGRxOVbksY6pdUOXwuarfibpQyeQrpy+?=
 =?us-ascii?Q?qj40bwg43Fz48/ZAaobugQw7UFN37JqSFCTwH8UxvgT6+RZmtSqv/Mp/G/TE?=
 =?us-ascii?Q?FI29QSkIkEjRUPHATgH4A9pLDYzv8QBaHYICDLdyN6Q2D0MRvHkL0wDFfood?=
 =?us-ascii?Q?FRFFrtrxULsER6gqX82Ps71BvaImbJ2I2dp8G20dGWOqBol2o1uR5EwSA66b?=
 =?us-ascii?Q?0aga1EK9FGQkhxn87WH5TpjuHTXLyG3IJv0n4idv+mbbES4ODLBjgh71fX5V?=
 =?us-ascii?Q?w9Ikq/UJE2PPY9KRfu4pjMcrZ75bmXQ1q/lEsmiriKQ4o4vxmE6IUiRI6RdF?=
 =?us-ascii?Q?Lb46EPpg01jLEnk11tleu39AAIgGZvU+z3xttC1d61DVnsh9r9ll4lfRFoGj?=
 =?us-ascii?Q?dE9QPJBNPTIr9Ksq2h+MDlgRDjnHKPJ9ON95sy30Esp2DFwxdewDS4iQZbbX?=
 =?us-ascii?Q?piFZhcEMXM7tmjkYR9sg0F63HiFJhu0Yi7Z5O8qvsd9SglfuZfMe28IL1Xe0?=
 =?us-ascii?Q?LBEDOo88SDktHLZHM3kFlGFFMDZcW4cNCnn1axcos9Jy6YlhUBhjZXTyfhgk?=
 =?us-ascii?Q?GR4PKrn6IMoKLRrsxbpr11s+sULlWkEqGtWm4D3UPefYWuylVTg2cZlGVK8X?=
 =?us-ascii?Q?LnxifRwFnf9v/zPJqeRVzoKwMFk7ZnrVTVxpKHjpWPLpyYuIARRptUfq7zT6?=
 =?us-ascii?Q?rSv6zCBS9fOTdzxhdXQDznRQdw1CAbnq9slqjYiET9aQ5sZs8slTyZ5YY599?=
 =?us-ascii?Q?uoyjZAdmkwZfWZk5hTowYUjBEwcu0AKNnE8w+wEzUAq22clRCBkgCu/95r0f?=
 =?us-ascii?Q?R+MHbG4C1r4KHSSLef5C?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30062de9-334e-4337-e11f-08dcb2effeb5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 12:38:22.4663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR20MB5499

Add support for the onboard hardware monitor for SG2042.
Can be tested with OpenSBI v1.5.

The patch require the following i2c patch:
https://lore.kernel.org/all/IA1PR20MB4953DB82FB7D75BF8409FFF4BBB72@IA1PR20MB4953.namprd20.prod.outlook.com/

Changed from v8:
1. rename critical_action to repower_action, and add some comment
2. remove unnecessary wrap function
3. use guard macro to simplify mutex process.

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
 drivers/hwmon/sg2042-mcu.c                    | 394 ++++++++++++++++++
 8 files changed, 550 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
 create mode 100644 Documentation/hwmon/sg2042-mcu.rst
 create mode 100644 drivers/hwmon/sg2042-mcu.c


base-commit: d2d190621b60d77496d36659e1621b20c897b25d
prerequisite-patch-id: 5e7221ed1c63bb4d68e4a2a0141440e32d29e397
--
2.46.0


