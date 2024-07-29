Return-Path: <linux-kernel+bounces-265016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315B293EB47
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80BD281C9F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901647A715;
	Mon, 29 Jul 2024 02:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="B20VSsNR"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2010.outbound.protection.outlook.com [40.92.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019517F49B;
	Mon, 29 Jul 2024 02:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722219978; cv=fail; b=bhpP9Mpr+t3WrAjqzN/6/6Fzh+PodfSA2nmpiRhjii5fXNVCKgw7k9w01JqkcRYNwKxmoltpI9S8byd6ff5FW7MFTVh2O6iA1Y8h+wU5ZX6fjCGY9gfu97+lZpQ2JlqHcCjha3OZzbpaxzmm6dbdSs0mG9ZxEPnQuZ9u9n+qhcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722219978; c=relaxed/simple;
	bh=i5uJVpVqHzYneC8x74apUJpzwoJvkLMx3dMpKQs+vKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CP+TUVbk5vSjc+prsENWLgYehW2UsNzbZ4mAiHt+VircEiCPMYmbaSE8uEVGBxkklDFXnFsQKdLkKIAf7H1w2VANaFnmXNlk8CSCARPsch9rydyS66nCi7ZWlLk94oFhlxZD9yYg+FD9TMECWJoDP+FgWpDARwm6NoysE4uN5l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=B20VSsNR; arc=fail smtp.client-ip=40.92.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IoH/EYbBUOxgXEjlnKMIs0ZcOONvJp/yMa/HqomeCwW2iDY8bj/pwTfQktdUn7FUGMAedaPv6oZoaUmKMHJ69nYPod9/HlnoaSFqPAYV9AbJ8mkNnynMOxjqcX9t/Gow7mmKNLQ6ZEaMjpOD4fGE28f+hWJzvLK55stqdOGK7cNmyhB4qrwUIJt+La3oqt9VudfDFcByJZf3LxUU6ewPgxl9qKwOJ5M957o3ROUNg08wMu05VmllwUjFxhU7yzFzH6OWh4tdCrcxJwev+MSfjSXhRLDj8ItACLFQFnVdvKUaDlnj9Wg/jvq4jdcS15DvdDi4mDKoBDj7MhhX/N5+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5uJVpVqHzYneC8x74apUJpzwoJvkLMx3dMpKQs+vKM=;
 b=oZFqDFTHNd5rAWs97zOnzihq32OzsBbO+a2KIM4SUWXIfo9cJQL73wZMsIK4DUpklF61DqlGEzI5VTkDXTEzYPO7HG5vakisnpFqj66NZ0cjaWGKZRSRUFYqvimTSyjFNw6/uUGF9LkJ2Iz6cQsOPY/h2NVwYvjYQeBeekj5PQ9cnNOmU87Q2pvyiwF9N7tgcdGlQGcVRH4OHVfWXauXNZKKT0cJ7t+PgeLOeWkEFcgCE5X+NuG83UEh1G8sN6of4ME04g3XA9Kjz0sd5hWx9J+d7WxHd8BdZBnsuMtWP6znYIKiMwjj/WRMgZVrATiNiUQ2hgZRuP/j2WKGhPHnag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5uJVpVqHzYneC8x74apUJpzwoJvkLMx3dMpKQs+vKM=;
 b=B20VSsNRdV30y+H1qx499Tv8UCHhXTZsv69jPDM/hwlv8hcb0vsLMRU6LdoZjvWcZ4bZALrWlPXAA/tsEwePvqWvcYm64zyevr0t4JMUN98a6kB9ul6AZxMK98Fj0hQVQEf8AsSvwobq/xGmJ1xK1Sou7zeHyiYeEIt6GScdNvjG7jmhiMcAN564H+A8rtLY5v8ULi8z7QIL0wHDGMYqgl1/+c3s5dSWXKRm9LE9S64bKetQFhu5zdnZ/oQNNJg95S+gujIxJe+C4GpxOCHyQ2x12Gr5RLrvNUhxoSTG+cnfsgsz6DurReCMezCKDMOU5jyWYo+uXOhayB4YBZE4eQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH8PR20MB5413.namprd20.prod.outlook.com (2603:10b6:510:22b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 02:26:13 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 02:26:13 +0000
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
Subject: [PATCH v7 4/4] riscv: defconfig: Enable MCU support for SG2042
Date: Mon, 29 Jul 2024 10:25:33 +0800
Message-ID:
 <IA1PR20MB4953F4162372085ECE625C26BBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <IA1PR20MB49534B9F7A3B4A1585467C87BBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49534B9F7A3B4A1585467C87BBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [hEgp07/OQY1Gt+Y8L6CLvUmn9fesjZZHrX4qW6Q+tOc=]
X-ClientProxiedBy: TYCP286CA0131.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::13) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240729022534.842326-4-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH8PR20MB5413:EE_
X-MS-Office365-Filtering-Correlation-Id: ffe4a480-1cea-45ed-0e84-08dcaf75d139
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|5072599006|8060799006|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	ZtnRzdx9ye3oisr3mlqaJklpdY6xWJMKllboGrwCoWGF8pDW0bOKwgjG22vNylJeIymyLc8RCZvYVQSN5EG6nVrbxduYP+26WY76ErJVdXpdXKQaSjT/9Z9SjIPXtZ8J/GIz76GYk6kQzscubfpxxIFSj7AXFY/bfF2IN7NWJSuPxJkWH9oHhMhovKFs4yzj/dwjLcgaREDfZnj1i6RkanL8Wg1dFG4hrOvQ2juJtd/EY5ZgZVtX0tZElodaai4ybREaQz1wpEaUyaTlZjqZp0NmkN9qtP0Yokk61JnITW5W2pk1trOtdexSMAgP0zQRYzraz17BQxaflkjiyygyFxMTz+si9a2jlZd+qrrWkGxQP7/t1pm8FBfVveAaNgmL/7Tb9aKVJrKSOu5QaAexyozPDqLsvgSiwjT3hBACyluYEo1Z469g09txo8/cSBjKPzxiP45UfWbuqOXybm7qhI7RzDCMB7p2l+KR9mcB/RCsFagKVdCF8DfFctS33gKsJxFoJR5tnn/3SjEmyPJkyOwfze5ZWt2QypXLtBvmK0PQYAuTj+4ETIVfkpJvPpwIjZPUbvCCC/LPnMX1Vr5OZbYD+xLQqaGQLROzOEgz52QlikHKdmH5x+PB/TAyhSClJrR09k18h65rGzZzB6FCXnYl1YxC/HecyyFXb3b63a0PLG6R9UxD7xQ2ZVZfLtxzgVnHeEuZdhxcbtIruRBPPQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xobbS/KotmUOVsibR8u1l+B2EmFgd69GYHIHPnhPN29ssBI5888D8Qq7/NZE?=
 =?us-ascii?Q?CJ0EaCDAt76T00mVB44ZwDOx+4etNG4ChM8rYIuh5yJqVPnDoKAnuCEYoWtR?=
 =?us-ascii?Q?u2EofZ37HgX4CgjfidYmqDwm3KraJy+ENyLhVcd2Hc6PjGXO1QJT6wmR4pM8?=
 =?us-ascii?Q?ZgdodoEoGzZTtpCGi1v11J1kj1a5Fj51l9vxoHVI9BEFpUtuXUKxTIE47iww?=
 =?us-ascii?Q?liWAz+6pOVcYWeetqrQPhkGatJzyWDoYRupakLs8fcO01j25adIGyrxUQUlq?=
 =?us-ascii?Q?WAYFd2J8ypOgBKgUW2EVenKkFG0kt6md9NJ4t7uLIi0EU2NNCGbQ7MPY3GVe?=
 =?us-ascii?Q?FTxb466t0mBrfbkHRt8jBBOIBHdsEkyAaiC3AXbEW6WszdycQ+jmoU2IIEWo?=
 =?us-ascii?Q?JvYzDc4i/yWbey5kPSRm9j+hDjWbLB3awaG0rtGrUYpS0OHlePX4zrizF9vx?=
 =?us-ascii?Q?A4ISAso1IokhOgnmQFk/reLrsH0oxsTZxtq/f/4PwbXS0c+FMUbUlsBRmgoq?=
 =?us-ascii?Q?IgpxLz6kJf12wErUaXDELrzgDkfLvFwwQTs0F1DdvCUaeikJ0iK+FYfCvgI9?=
 =?us-ascii?Q?ybXDud61ecPmfNeI3FdbNYEkIx5DbkkoJihh2f4G4KBxC6XrQbNyzOWb84Zq?=
 =?us-ascii?Q?I3b4yI4rVIOuL4du0VOO67Tl+qxoOm9CyRjQoZFmfEigfF8oW/YqfISQb2uQ?=
 =?us-ascii?Q?21HSsRh3sKVLRn044Wq9Lf/ZbLVu10H6dP4/H/ipAX9yTOQEdziq1EpCIpNR?=
 =?us-ascii?Q?MlFFjLldrmU+xpCyH8rkFLzwvqShpMgHejcFu8c8x4P3F8/PR4SyQdOfsFBA?=
 =?us-ascii?Q?nbAA/unhf7rf6AIdngNeprweCvNMdhNSsCyv3fmLggEt2APlkKdjnUUHklGY?=
 =?us-ascii?Q?w/EJLt6zdmApflIF6BIEjpmCfJUjhsiFLZuOrxz7GaUBA3G9kuQEXpkU6/i/?=
 =?us-ascii?Q?ppub2sp9gSPTm+aaeaNrpJN2Xnma1T9R0pv0Ldyu2l8xgkHJ44uMQr7yakVf?=
 =?us-ascii?Q?iwfOxR/9g5vSP+GrI7YtIuFGgpzSeDEfI0L61VtJUiIfheQSlPYz0+7eP1ap?=
 =?us-ascii?Q?RsUJH/zk59RDRyA9Bw9Phuuu8ZZpovRjE7OxN+UdKS8dW4dBIxTCGppytEzE?=
 =?us-ascii?Q?YmdCQ38Sb2hdXBTFCv/uLngrkeq1UdENpWvsElE+7GNF6A/hEVf8mGvxgEHr?=
 =?us-ascii?Q?aMJ65NG0ccaBCXTGjXg+dbWm1WlaeVB1TyQAJ2nYAQWysGFu52JMeYHZPwS/?=
 =?us-ascii?Q?R0cblJYYNU8jOdKnxyE+?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe4a480-1cea-45ed-0e84-08dcaf75d139
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 02:26:13.7260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR20MB5413

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


