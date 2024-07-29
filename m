Return-Path: <linux-kernel+bounces-265012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EBF93EB36
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57BAB1C2164E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC62B78C8F;
	Mon, 29 Jul 2024 02:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OSZ755Jj"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2093.outbound.protection.outlook.com [40.92.41.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0646B1B86D6;
	Mon, 29 Jul 2024 02:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722219904; cv=fail; b=R3C/HzHnUjKRHtfCR5EeHTJjiOLLfCB/gmdkGDidEGRPQPgFnC3dfC1pTV8foIzu1BJdJcZw3xK+qJISxAcROk8mwPGTMKwCtmJYodhHrcpqCL41piRlDSj7wH0bU9wYGU4k7s96gIqdPPz+Y23+JHdQIvnA7SOHC6HJAQh+GE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722219904; c=relaxed/simple;
	bh=lhqtrTNcuQdsfUsbD/HUNSFrR9fqKuG3IUnUqih5g+s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NOEW/ly2vaPuhi1FABdQwmsDTTo/L5fS06Az42DAnR7x3ZOLdH38j8eEpoK9t3fSpsic7ZDW2UuoIaVMXghJbEJveGokBwe0onm/iwBIDqLS8ANQuxlBtArS0Qye/2ByIpYK7d1qQeAReNNp+pX8W7sa5yQ3Zog998bLVja2M/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OSZ755Jj; arc=fail smtp.client-ip=40.92.41.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMOgBK+GIUX7PTPCi6JlM/JvxrZPH3wVFAmKigB6gbup+5ezdSouFA85jLx98GivcW3M0qekbMDrlMNof1w6Hk5D5OJv+NLH6QAKB1TVgfmPG/Et6hbW1/2oyJVrHRPs7EYSNw16PkOTJmYNm12StBJrbnrGedJbYXZkOu4lfc8IUywUEIWtZ2XdzqMj4WohknCAF7nnESjKWk+T4G/pRE5Sn0i5GtrnrEVRGbRCGuzYXLJ4c6f9SrxzBrhGD1qZVKeCODIyoxQT6PNQ8vSBYeNipsI6jfzGyW5AqfkQc5IR8fTpz/4T9nn08uUOl9jBiK/naIG9GX+5zznvNOB4bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wLeG2t8CPipeB6lx2Qzk7McyYPo0YQ65/+ZClLs1RY=;
 b=T3cH4EqMqm/Yfg2OcHLy1qpv/RZafYH0gC7JBWyQPZ8Nvzs4dAh/uaFylLerf3IPUJGHW8sAtDQPxsMIJFwlvIcmpjPVOB/ko2ChspLnodoKS7XxIdu76lVS65+GWED3lceBwOobbVvRpBeDV6Uv464My0H2sJ/toA9j9C0+qdMVIIgDAcWp1VQKl2UHyoLkKqpnGVjHeuyfUqa7UZhaX0FzfHUsxKcyBGIeFRs1s7ZO9wIJF1NiZi5OPQoyhCyh2GQdXmFCqsV3lkgqa9qyzGF9Bb9BrkY63J0oy6zBGC+J5fVlZVkcKta7sHs1o37GwzrQtMfpW8nOOccaXDCF7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wLeG2t8CPipeB6lx2Qzk7McyYPo0YQ65/+ZClLs1RY=;
 b=OSZ755JjFsaFl/dQKfpvKtmi/NmY1WBPvRKo2n5clNhk5j0G5p1NbTgIsgRBcBDXEaWuKG4X0mhZQu8YfnEK8a1i5riuZt4wiMKys4lUFYFoA6epdLig7AuIHZVX9nIDYhq5pzRFs2Gok0fOCkomD27cW7aXHQbBrzanHe0LC/Gxv07qTTlmFKIqJoFIzlrZX4yYE8OnYeUIbPXMv4EEHRp0tb328yF0qPBuZFMQqkXivnJD+J6uQINwMruhfKqgP38LATKPkiSXfYFOzutWAOhWXGdmgoNTLkNndIGe0xtO5PAdykWSmOKIRj70mC1MTAEyQ+Xpnn88gCiL+vThRw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH8PR20MB5413.namprd20.prod.outlook.com (2603:10b6:510:22b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 02:24:59 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 02:24:58 +0000
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
	Drew Fustini <dfustini@baylibre.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Hal Feng <hal.feng@starfivetech.com>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v7 0/4] riscv: sophgo: Add SG2042 external hardware monitor support
Date: Mon, 29 Jul 2024 10:24:32 +0800
Message-ID:
 <IA1PR20MB49534B9F7A3B4A1585467C87BBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [vokWRG9Ds52DesjummiBY5px9FVgN62VmrIv6FzcnzQ=]
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240729022432.842060-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH8PR20MB5413:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ad0cd5-f440-4eb0-c7d4-08dcaf75a48e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|5072599006|461199028|1602099012|440099028|4302099013|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	R6UobovN02ZAUjRxFjFapPSnaizqUpT7JN6bw9nZCXmlaYGCiNQ4XMMy1WOBpsr6W3hDrMthqxvZpLrrrvvQW/pGDygQ1x5Tu+Cm31PrzBpm7Mu9yoCh58sDfbQ4yDzVmLgkwObe/4uKhS4W06R3Lf7Yi+oRiqSDM6cpPWtH6qg3Ag4ikC2EJOVWmIUeVDlKftEIW4IPLbU0gkOHjmyJL3PmOnCOTcTveC1ruT9pIP6FOb9C/ASshgiAZYECuwE6OWjphMqBeOB5Ys5RFoGoutFEqy6XxOtfzmJeFcybvks1vHE05F7D4ZN8ppiwcecsbckSrw3IhaqW06VgsT3G0Vnxg5FsXla/i2qQfA6JsJ9yWkLK5g4K2bXJZxxfPVALprVlIc2w6EXXXGzSFwANNmpvyD1dbst8gyLn/Fq6D0LlXns45oJO2a8+1anXevBtlmCzLmgn1AvHm3N2AwQB0VzJ2Vu00dh4gE4f1qv4RlhQ74EPAvqILTXJghBKirBfDO1I3OxVqQRJasfKUZR/mZTFshsJ/HxryOH5BtJ1Z0VqriO4bVr4YqfbQbFwKhO18hq59aCi9dLvR5v8RhBrFprH0U4BIZ4bj8OJwhUiLNs/F3TVX1KZBBdHslgHoJ9pysdIKxfN15k37Ec0Kt/EMZ9Vvoc+oecy3wTpCDzegMVqjHLBIfcVYyrI+KH9I6xcn9reUwLW70l4il0PWnd/Tcu/gW4asabwjuXHDogJE99xApS4SaVZ2fexVpXDJBzE08hYusiXmTK4Lhdc+C14M55veiz+AVm8cCjmlGaOzhVbRhuwBzgo+FVZQGK7nSJr
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JYccWRcp4vX+CaITTJovgAoIEJyRp2n2GJXxqzIPhURJ07FojwbYSl2uoQfT?=
 =?us-ascii?Q?ADnh8eeUIBL3g9NelSKSTPqTqbaewwJOZg6tneKfnHM6zwW2YqNAqoilIIqh?=
 =?us-ascii?Q?RyqGI6HwEae44a7E52tLz5zQxSWWkErs8dDi8nHGq1Uwq6QUmYyhQ+1+R4m1?=
 =?us-ascii?Q?1nqDdNsKGxIM3kvMx8D1teDPdoUE4QqQjSMYGn7wOSXlNn1dqr7gG2uu0UU7?=
 =?us-ascii?Q?xhLHVDyF47jVN6QGrCox8acGneZSALo8x/pixt2b05GK0xTEt5yZfnqnNxEt?=
 =?us-ascii?Q?cjduk++y8DmxlBd5fRHz0hsBlc9exIZ4gcpc4d6GPsKOvzW5r5duh1XhKkvS?=
 =?us-ascii?Q?e0S61qU/Y8rTTeIOesVHIOtdJRJLljx6cNtjpVjK9KeRSnaBo3yF3X82l88h?=
 =?us-ascii?Q?8a7kPL9wkWzbPjIOYnNBSrfYaur1uVqLshg1zAgNOXOtGQFDLL97qE90oF7i?=
 =?us-ascii?Q?YWrsSMgLXrtbXcOdsD3LWZktKKejQraxHtbBuKWDReXsNtMeBdxFPHScuj9Z?=
 =?us-ascii?Q?bfazAjDbEiUwAP6oGZImkmIPn0goEKi97KHI7DTxthdTVfyMPS4L/F9Lbf/H?=
 =?us-ascii?Q?nXViDGr+pzwQqozRyB7t4M0GbilhBkSVxiEH4d7sX72WLM1BWv9dJspDfgxU?=
 =?us-ascii?Q?S7NQJBPmL5P9uzizGXySBkwNfNYkztJrveCMNVeHxRRso1z6o6wMZVt/x0Mm?=
 =?us-ascii?Q?XI3RiGjc4ynWFZlLVi0CCMu2zsqGyfemLWSANO4ckRGouHwMtDjQDH4jnStT?=
 =?us-ascii?Q?Y1jWwOGIy/eMOOE2ZpfkpnfwdDVR2WtIMX18Er/LM6RD7qmV+yfDTrhqG15j?=
 =?us-ascii?Q?0DXodaKdlmixn99MoVfy4jwRKGQl/Rfrc/L9OoMwJgUdrbuUvb1+8q/A0Ez2?=
 =?us-ascii?Q?oUqVcvGos1cM82A28hZDtxSc2WP3RSzY2qD46uOHIPlV/IpyeU8w9pa5FaOi?=
 =?us-ascii?Q?5s45XhO59M/DgkOu4t8dgztfHnTYUQW92+s19Q4LxgIqXsB2L5Y0R2Qys3iy?=
 =?us-ascii?Q?/3+tbQGiE9lakiPMlgBOr1a4GBw2oWUagEqbHv2cUXtOxaTeaTKOLPbqH4za?=
 =?us-ascii?Q?QZqLbhr+hJhPn1OZ3v+Ni9kjbFyuyTTUM406vxjFRVoh9TL2KWQDINeXmpC1?=
 =?us-ascii?Q?J7QBKV98pGB9AXvRZ4IJtA9Otr3FhXCoG3nYhTLy0p5v2+WKufnX3Z7f9CTq?=
 =?us-ascii?Q?I8Q6NX1q0Uo35RTn44Tgta1cZfvYbRhO16arTMRHF0GU81xaYVdS1sYp73sm?=
 =?us-ascii?Q?NH39jdtOLdRYzz3RyV4i?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ad0cd5-f440-4eb0-c7d4-08dcaf75a48e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 02:24:58.8346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR20MB5413

Add support for the onboard hardware monitor for SG2042.
Can be tested with OpenSBI v1.5.

The patch require the following i2c patch:
https://lore.kernel.org/all/IA1PR20MB4953DB82FB7D75BF8409FFF4BBB72@IA1PR20MB4953.namprd20.prod.outlook.com/

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
 drivers/hwmon/sg2042-mcu.c                    | 399 ++++++++++++++++++
 8 files changed, 555 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
 create mode 100644 Documentation/hwmon/sg2042-mcu.rst
 create mode 100644 drivers/hwmon/sg2042-mcu.c


base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
prerequisite-patch-id: da041a64080141b02fa3b45a19c937e69dd750a4
prerequisite-patch-id: 5e7221ed1c63bb4d68e4a2a0141440e32d29e397
--
2.45.2


