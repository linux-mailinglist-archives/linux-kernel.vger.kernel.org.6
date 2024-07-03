Return-Path: <linux-kernel+bounces-238684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2F0924DD0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60ECD1C214F7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 02:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E41C522F;
	Wed,  3 Jul 2024 02:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FxeIv/iR"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2108.outbound.protection.outlook.com [40.92.22.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68154C6C;
	Wed,  3 Jul 2024 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719973835; cv=fail; b=Lurc8PguPwsbRclGCFxRaHZdPrAQTAiLmb5ER5QWXTfvqqShdIhBaaMDrHU6ZI0kT+dCV+t+MHi8IzYu4UP0KAfuQ9M+jQ58yJf5lC6B7i2oAwdQYyIHw2ERq5qy4tykn+gZ0kgx1TDFM5glRV2ekllp9FCkId2BzIOuxlR68d4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719973835; c=relaxed/simple;
	bh=5BxT9AALqA7SJtYI+41/2eWeDak6ASvt7WIbAHr3uL4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jpSn7CyVimv0JlYFFY9p0USyl+6aj8mwpimA09jNw5zPYQr8W6+illabP6MTMYadpe0zxfoYNG4wuKkCrzuJHJ3TexE9canB29nOod4oRHzvKy1erTd5GoV3r/rTZdETdvX6z4Cnd/s0C9+ZCx2GVcimqfN80LHN0jyr4qVoENw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FxeIv/iR; arc=fail smtp.client-ip=40.92.22.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4zoS3ej+y6YDEtlSTzv0vgDYeWJSKMpBjfJtheGkkV+WqLjs1Y5kzG3vShLBVRTQ+KESiZhVGIyhxxtqR4TzVVct95+saeUKDTdgBcoRUha2rZIeXQ8DiQfemSLadCu6g0GvNH+s03n5klEEt9UnIXdhxUm3/GybK3PjDnSvuIT7hBaE2NOwxi9i1/x8UHZBhvfDDRJ351SrL86fg12z2FPGXIff0paJzQXBTW3b92GrX/nuWYDfVTEc1VTqdnOe0EVZs72CBa0u5N9rXsg0bc9EQNjCesK4/WSAzdJR/rAgM8aMIZycPAXJ/S23eiyWuOjS6Wh4vOLkRP2LGTDqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ISUeGXmwJ6IuwsxJi2G6i+ge6aGslKvxRZ0ox0zhnY=;
 b=KjDLjx+WbHXEuYQ5j/zmyBGAPBKb1eZJC56jVCrg/LhwYE4W6h8QnYDRRdIe1NoVNMDGrBUD2fuic/KIOgTeuFevuIvAPnLtO4W3SRs5KWTEiGvHMqodHJ+TDpjKAoPwTEYu62M6EJ2/DCJJpo5E7qN6B0IxbfSn++HiGbIn9eIucx8un1C0RuNGwE07s/SB4bMi4wwlUXMv9H/OZgX3PIaWFDvi2ai0VWDq/9vDKgMKrqPkfDSV7zERym3yztiNe6lo4GR3PnaUezyICPz95f0CExTTuS3iWfpGZt6ZOVIBrSeyPkxApxWRmUb9HcZoBRn1EENOXg/vYFi8xuLncg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ISUeGXmwJ6IuwsxJi2G6i+ge6aGslKvxRZ0ox0zhnY=;
 b=FxeIv/iRquzVMpqxvB6fP9QvcU64UEEpSupp9aj5pxAqelQWOCatBNIUEfGj/UlI/bWDOASs6ib7rJ7hFTV6kT1+EYEco6weeTln+gpCaUp5Wsqu6z3oqf12hO+xTIvPK5cqy9eBpe0cahUcTtzUBXnSy1dP3NSH6/fdozLX3TKKRV2hDVmgAwagB8QXGUEs72vPddewqDszb3l2gURsb+99BXcr5O0Wlmqc55JarTqx5o2ZkhUOASd0NA8919IytJD7caQuPkhQLrb2sJ0bYTrTyULqO0Wr3MTDio8P8w/9dJGtUZpvjyxiFyCnSe1uyt7h8Cq7CC6/n8ZmZrbUIA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SN7PR20MB5580.namprd20.prod.outlook.com (2603:10b6:806:29b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Wed, 3 Jul
 2024 02:30:30 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%6]) with mapi id 15.20.7719.028; Wed, 3 Jul 2024
 02:30:29 +0000
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
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v6 0/2]  riscv: sophgo: Add SG2042 external hardware monitor support
Date: Wed,  3 Jul 2024 10:29:58 +0800
Message-ID:
 <IA1PR20MB4953967EA6AF3A6EFAE6AB10BBDD2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [PkEo834EUFRaaM7fr27GZAtJkbQ3/zhtx8BctliPzpc=]
X-ClientProxiedBy: TYCPR01CA0118.jpnprd01.prod.outlook.com
 (2603:1096:405:4::34) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240703022959.272629-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SN7PR20MB5580:EE_
X-MS-Office365-Filtering-Correlation-Id: 59201867-908d-4e0d-e4d6-08dc9b081abd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|3412199025|4302099013|440099028|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	slh+K1vRVEtu1oM2P5Z1kgdNan25zeVKwTrKrXhBiH/e/59R/nkBp3snv7io5NPf4Ged7gstA4I8CJ+/QD3G6Jy5O6zVq0dSdpUhe3PdPe0yfXSInJNVPEfeiWrU65LoLhDts6wXxFKjUZSt6wXgA0SRyQx5q8BGj4DDh+YsqzBRVP2UsGPYV+yNYFjH64cvHquR0GIxRQCn+N1xkDe3xmqsw1KEc8SQkocgyrf9z2WBvoUzA5fLSBy0yXXkJ0+rq2X9yZG/I+fIQhqkQOzZUvORh5Y0Y+LrzVqnveGYpiLQccQoMv+97EB+5RWx4ungMIpmd3MBf3dBrU2jkILp7FPErf2c2PYLeh+a+MZ3piB0nfTas/p4X0cBYVCUVt7foPjaabVfTpcltqh5p0YHNbRokeolPkF4R8aUV0prkt+r8VDg7NcdU08dvt5YSX+E0p8kOnff+nQ0oLlujnCV8d+8Rb2Qx4E6S/HjnSNRsmm7HKHQAhaYR8NwU/QbsFFhDsznrsL3XUZzKb0cFL+l5hk3dceE6+Ur+7UatcoKHm1frOLBbOha0NJcrDx07+HxHJExouo9wYehnWRuMfzvULOT6D/ZCMiqvX/wnXVBEJ+wvQY0EnOlQxMpy5i5vFf9joTfM41sY1+RLnq5U+W37IRJZgu50QjJyQ4d6qxSkxF18VaQl2H6uviCufr6JnkHflcI8eRcISCO07CqlzkpiakI7vCkMtsfMKVbRB/Y44ONeDWbokpZfRC5FWgzSOIE
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/HzLOfjhe13ZIP2WDcoDzTqmeXgwtyWntG0ItHhwiqm7K6ELwhkhG9ffw/sz?=
 =?us-ascii?Q?qERTGVgDplaHC5aAYRUpw20qAnHweidOT7jo6HtMe3ApFqoUB0mTPE17bbOu?=
 =?us-ascii?Q?A97pcpRIJtHZ2VzTO3hLNN12agaNvyC9nKp87RAHSxvVBunMcI59J6nKnITb?=
 =?us-ascii?Q?890D3P+E8gc/3B/FY+9icqWlXKbuzLX+PhTV69eODXbyUpxIhhBAcr0mzvr3?=
 =?us-ascii?Q?Sw8fLJB98E9MOvIE3JLy1DZ7Pev2oI0qxY7nO1a7zdvUD9DLSF+oP421aFLE?=
 =?us-ascii?Q?T/4DmsD89u/wTPp+hCAAG5nEA3nYjE5PD8/76C/DCWr1Prn/hnUivurlgtkU?=
 =?us-ascii?Q?iCterfzCJbD2su4ds0puGvjsFSpJJ9ieVECUQwHR0e8C3/m0R1gaJLbQk1uj?=
 =?us-ascii?Q?atnls7CFYfFWUviLP4XXPpgVHKR9xzKiHiCv5DehZ7MitbEoU3SweCBTAhps?=
 =?us-ascii?Q?WQjRjYqWOqpiX9Wv6CbZBrgMEWeGmx/S1fO+727BL3DqpQyxEJMTyJKY2nty?=
 =?us-ascii?Q?TaHamDrmsqQXby6CTCOn3Gyih9pqfojtFCjPYudgLS8sH0i9Oba26LkPedhw?=
 =?us-ascii?Q?JWczlsN558IlI8+YpdVrjvpQuIhKBLIvh1TOKZ7AN5g43Sg+P0NYZo/X0yH+?=
 =?us-ascii?Q?3a34W4gp5a+enayDePBnp4XZni4XfVDMyjKsNfW7eSl2qx0nB/w6jYqRELOS?=
 =?us-ascii?Q?rA7DfHetjkefCYmvwlnidiaNIBkRngqNGR1LVR1LDR5QR4s/MRVx07DoIXzC?=
 =?us-ascii?Q?aSav4cG+FSCVk+JAvaX7tgDWDNJix90XWSO5V2XcRN4aNI7KjF3yYlJbaCc0?=
 =?us-ascii?Q?gFXoJsrsNCVvVRuJp66Lg73K8w0A2A48J4S61GWwwWfdjz+sJQvcvq1hRGZf?=
 =?us-ascii?Q?yMm6ngsY6anJptWGzKXxUm7gfy78TN1WW55UgXGWCVSTyI1kNV/OXEE2LuUL?=
 =?us-ascii?Q?ixXZzouZ4Bv90/YZgon8YSIq5fjA5KL8TzKAcjg8saDEn6MABdAXn/VLfK2q?=
 =?us-ascii?Q?9tcd72ln9RMqjcTt4luza89B+QAoPHFw3TkmKCl4bM4ZRHb5Be7qLgbpPBSH?=
 =?us-ascii?Q?H5+U51T3ue4s5VnOkNYHBE6a0AZugXcWiVwupZlxleyxfm9mHEmRG8tXWRwS?=
 =?us-ascii?Q?PgY7lXXkO4QUpxA9utL8Ewi2bu12lrFWzygVOeyo4gq3FEGV7z/9chmSZR4J?=
 =?us-ascii?Q?no4n3J/vyiwxgqS/YyvkGN+s9JSm7T4K/7XvcknmjqtmHJh9LklulvNVuNr+?=
 =?us-ascii?Q?o3eFugViJHFP9AblehGu?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59201867-908d-4e0d-e4d6-08dc9b081abd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 02:30:29.4210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR20MB5580

Add support for the onboard hardware monitor for SG2042.

Related SBI patch:
https://lists.infradead.org/pipermail/opensbi/2024-April/006849.html

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

Inochi Amaoto (2):
  dt-bindings: hwmon: Add Sophgo SG2042 external hardware monitor
    support
  drivers: hwmon: sophgo: Add SG2042 external hardware monitor support

 .../hwmon/sophgo,sg2042-hwmon-mcu.yaml        |  43 ++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/sgmcu.rst                 |  44 ++
 drivers/hwmon/Kconfig                         |  11 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/sgmcu.c                         | 585 ++++++++++++++++++
 6 files changed, 685 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
 create mode 100644 Documentation/hwmon/sgmcu.rst
 create mode 100644 drivers/hwmon/sgmcu.c

--
2.45.2


