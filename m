Return-Path: <linux-kernel+bounces-266953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BF9940A4F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698C91F242D0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630E1192B98;
	Tue, 30 Jul 2024 07:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="a7Q1rbjv"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2072.outbound.protection.outlook.com [40.92.23.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B36192B6F;
	Tue, 30 Jul 2024 07:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722325893; cv=fail; b=N17fpHQoXuKVrvOKESO9SF8oGa8rTmnUZN/GLq3BFn1QQtqO88i7Y1dMqWoIFRGz1r5GVpTLXdgs9YaXgqUOZQXyIzi67/IxHptYmwLGT/ugkGuWQaCR5+L0LI/IZ08PQ59GtbrAxXu27iFy4o9I0Vu1yBuFz8/y35a6/ClGFcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722325893; c=relaxed/simple;
	bh=i5uJVpVqHzYneC8x74apUJpzwoJvkLMx3dMpKQs+vKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AR+NzZ5RFfFFNFnIUI9R4AhrhFQuushCPKbYR7PkQd8lFMXSfceXN65x+POqDvuR5xNsVQUye+EZ1vGhF0z5611Fk2iAX39VrYLSz0or6BWQSQXrkYzZg1eazn07ZuVTl8V8zbcAobBxSZ+a6PYfRG4qJg7EzNUNgwCp79IUgfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=a7Q1rbjv; arc=fail smtp.client-ip=40.92.23.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XX1xF/xj+zrwLHYj5NeQCf6P/l1OnxeO6yEGGyPsaogMrjHimiB0xtoGczG7Cvu381WXbul2O+vCw0L5jGG9OUtxUkrDpv/g9Y9qZZEykkwIS8Z/zQtkdIRIQ+L6jVB2Pgz9z5k2wQSdEHiv6KiXYYvpR49WVqwOlv+L0w2jfTIeTH6v3xVzGY3NPw9BbaS8FzFEmjFaYPupngZuHEE5RQjooKVg0bsiQHMm9V4Y7YPltAFXeHxnv+IP++C9qGhFTSB+Eq5qKX75t8oFyfrl21a8s3bSt+o6hfCRlaTUeSeXAE0yxN3oqn73lHbBK1Mh1CWDj0MZZtC+ZrT2Ln7pfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5uJVpVqHzYneC8x74apUJpzwoJvkLMx3dMpKQs+vKM=;
 b=BAx/ashHyc1/ocbcV+yJyFtFlH7Pge555iKu0Y08BQGk/3us0rfKDHGCkXM879cEcViAapkDPuaw48YORoTfuEiNHMg1ZFGvLGBtPoA57XE1qUr16sB7QrIf0cLr+yidrI8fJ0uv0Bu136zEFKm3kU5moamurJFMZ81oXV8xSWjKCpTislHq+GJOBivbzLX5fUgSMeXDOW7Ss1S6aQx87F+EfL3P+hl77UdDZO31+fMnA9THNtKp9URFE2hBV7jAGkyUoao64jpZRv/F9eosbECOwVxlSeZR3Kh6sLq9BbbXK7ej7GZG+n9DCy5zC3NyRUbdyUpuX6+V7UTy54tMkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5uJVpVqHzYneC8x74apUJpzwoJvkLMx3dMpKQs+vKM=;
 b=a7Q1rbjvrCOznKuxb2jgZAKBypREYkder+lI4QRA5tvN/MTb029K9y0GTVBjcWD+ZDaccKiEAgYcjQe9Q2wfCAV112Fj8UU2GsCvvxo94Sw9lpjjroRiEdSFEUifxrfsdhIcj1vPIq6lNr3FkACmyIMsJlLtesdt+/USTjou/8lXccHuQURZ7sIeUCLkDc1xe3zHM880oslaiHWvS5DSv0XGgECON6dH9k45pIB2ImwYuLqrhi9sBykVyaKmHNdRK11/AHiT84JlyF7Eiq+YEbQhDricbRs0hTZ/mkLMivNR8KL9WyHhPUUDRggNJ3+beWs+xWSh1amxSJCPgedSjA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MN0PR20MB7552.namprd20.prod.outlook.com (2603:10b6:208:4c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Tue, 30 Jul
 2024 07:51:29 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 07:51:29 +0000
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
Subject: [PATCH v8 4/4] riscv: defconfig: Enable MCU support for SG2042
Date: Tue, 30 Jul 2024 15:50:40 +0800
Message-ID:
 <IA1PR20MB4953609E27C5D1F5F5F7552BBBB02@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <IA1PR20MB49538C09E94D90F07B7B2562BBB02@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49538C09E94D90F07B7B2562BBB02@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [fBdlE5LebptCIQaEyvxxV2hhzptwRRrlWqYKhfvb+vY=]
X-ClientProxiedBy: SG2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:3:17::15) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240730075041.489815-4-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MN0PR20MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: 3897302e-bace-486c-fbca-08dcb06c6bd5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|8060799006|19110799003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	SUWv7cz0h/obRmXHC9mumnDi6+HHq+J3dvXYtgoJE62/47bb/IB7p4dcV6K1+8SQO//P0I90U09fqpIiUyTNoX9xNcTxqyQDU3+SQLTQaKgiptP5M+68cpC+fshWShn5scGL2gLufTXLJJ83sYPX1yTqoamSt+GQT+Ud5PsgJnhy2rCP9l3HZETkQxwqOw4gFAkipkV2E0zAwABsiNKukIS4QYYgn0YlYznYx5tgsV1K6JLybGg01ihjS07sCoM8h+OighJOG6t3GBCdRR4DpyVGRsGSPlnJq1/6XZzH4hCRDqm089wW6G9o2qjou6OIyTHrtiQSBRU6yaaW9NM+ArG06jvmLdH21ym/09qQjU9hgV3bUi1UVTxssYWEAlydIbTjCqPyZaIlMSXDTB2rzeD0Nh0j4e4KoM8I6cDKXNCNYPPLt/FUGa+A0LfkPqJDAb4AdugdNZoEypdDdewxA3B1biHAm4zbCDDF0CE5SsIF2tkeYtjflarV7edhSgPDLBX+BXTj7Q7rAckkTJ5V8cpZW1rpRXM4aNSphXqyY3eUUCMrS1eHS1UuA8tApW0uJVspSQuF+wB6MCFejGAir3/njcx7pgiIzjcvtbpWnKYQhq0Th8PX4x5XgFsHeZLz0xjWvEBs3Wl25Qk2SuovWqrLM4oAhj49aqVuw7881Lk7aF9Gt/4h15tKuyXD4nY/22G9itXamCRO7ECBGV9VsA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XO6KTWdTevejydPcJoH6bTNuXyAIMnVvw1UF/cw9lSWS224SYUKgJH4rbuLH?=
 =?us-ascii?Q?GjDomqlwPQwLi49/fR1UArII3lnbt/b2NXq5U3KqK9fwIbAyeDv/ht3woATx?=
 =?us-ascii?Q?UOywonvs/6GfN4PtH4Shp1jlD25Wy//0TaxRxsgRPnDSFuS3ffGM7+udrj/P?=
 =?us-ascii?Q?4+iXGOktRGOKRftNq41x+OaPnp4dXM4wkdsHP7KmFIp8xgwnAqLuJn9Nfp2D?=
 =?us-ascii?Q?HeREz81ZY6/QxHy9epVlTOxs7BTnv5eD1TVreZdZl88J5x6ZMAziAAn1nIxh?=
 =?us-ascii?Q?1ETEFDj5mDi6csIe/tuEdftTjwSsuiEaG/YxfLQ+hLej1Mmxo9AXMMKFqhez?=
 =?us-ascii?Q?9oIEY3kSV80odWPVkRrwY3fFGZZkeZK3SvjVujn1aQrs8MAmXX6IvpEL/bpN?=
 =?us-ascii?Q?Ebn+0Tuo+mFNn398NUvfb3XKzNh2uX7WfWRKk1rglY2nlDmJpF+5Y0CSTpI2?=
 =?us-ascii?Q?qF8Ltl3TzTA6RYvys25F8Nb788MAmZ6MzEaYQyJqiOyuGnUUF9lkqjySYO7r?=
 =?us-ascii?Q?xgp3iQpRwZ8Mjlaif7dB9rtt0jboR41JL9MJ244MTBeiztDE9eMvhILWvzCy?=
 =?us-ascii?Q?9c1pINQbsMoBujoyEZULt+4X3E44Z1VUji5NH0vQ9+/oQ5WjUZGB1a5Bq9FW?=
 =?us-ascii?Q?TgdzR5MMJpA5ZvqL4//BPUX1EqztkjKRXCn8ux2qen3LDa/22YqTXfxrJ/gF?=
 =?us-ascii?Q?3SwuzyfJa2pd6sOQUta9RxFoaSIme4jJKgFDDJIIjt/cywzfR37S7Le14JW5?=
 =?us-ascii?Q?As+4YKMiy17+DX8eOMgKmSLS0Z8fWDMo8pw2PG3K549UzIi3lE0pzbYTtYqh?=
 =?us-ascii?Q?uEdqekl2dKo18cgVkAhX2e92Kg3f0+4P+lmCEVr/oY5bPfG77lxP6ufbmTOF?=
 =?us-ascii?Q?Pr06BuDZU7CgTXtbK5mxKFjYm8/kRdcIznzjTQYjq0yg3X2M4NssjG/kfG+Z?=
 =?us-ascii?Q?MWUySWfT65y/lgfySYAjpaCie3Q9l7sYQNQHdULuo/3WsjwLLzkDxf2/Y+mn?=
 =?us-ascii?Q?cemicycjhn8bOgpa4CsRYS1CgJTOSC5ZtYjovlqWoB4K9/dsCkQlGNzv9qkx?=
 =?us-ascii?Q?eG2hHgLOY4hbTZgFgmcHAA+BV/dgfbsnUwyHClP6mdtdBugdJf9lxmp9fvi3?=
 =?us-ascii?Q?dGEQhMmoAoDnn++G4hifXT9citrtvS/bNk6d9ZILeAa1bCXc7t4MCoRWA0yb?=
 =?us-ascii?Q?+sWpYu42+b+b+RS6LJfl4C+8dxbzGLQdYDjAEhVCQcHr2wOO5TYmc3/h/y1F?=
 =?us-ascii?Q?l5mu5bB79HZAAv+AfSAS?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3897302e-bace-486c-fbca-08dcb06c6bd5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:51:29.7018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR20MB7552

Enable MCU driver for SG2042 to provide thermal and reboot support.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

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
2.45.2


