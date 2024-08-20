Return-Path: <linux-kernel+bounces-293389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50263957EAF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0FE41F24F36
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A533F9C5;
	Tue, 20 Aug 2024 06:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skyhighmemory.onmicrosoft.com header.i=@skyhighmemory.onmicrosoft.com header.b="ymSWrd5H"
Received: from PUWP216CU001.outbound.protection.outlook.com (mail-koreasouthazon11010011.outbound.protection.outlook.com [52.101.156.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A463157A6B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.156.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724136803; cv=fail; b=nRCVgTptgeQ3930mNa5lmzNLsNXJ0WulDlxArZOKAKhfWSCFWdb2BZWlSlPFn+L6Sa+GYy/0Sn6zMvuBZ/7yfw6ko28VDSmJVBuuh9z4c9UlvsiOcBJV+HNotVoOokIaiUaaxcwhNOWybmPfI0lM4TvdfztTgAhPlC8G3qLaXiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724136803; c=relaxed/simple;
	bh=SwosmqbssRBbSCqjh3o+htrnOKgX3UL8UF8coxfiz3c=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tQB0EeA+CytVXZo1QdnGoy4sv8CqHmPIxiDenTW73HsRxyil/QbQ1twStSVo6rSVl/ZKupN+sHNC7I+Q6ZiBZcwnuEU1+9Zf/ctmjmedkFrN0IF6fZ1g6Ya5f+C/dVckMu4ExKYCtZiKzSgqkfKLy4GLh/6wNSDES2PvyYbVWKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyhighmemory.com; spf=pass smtp.mailfrom=skyhighmemory.com; dkim=pass (2048-bit key) header.d=skyhighmemory.onmicrosoft.com header.i=@skyhighmemory.onmicrosoft.com header.b=ymSWrd5H; arc=fail smtp.client-ip=52.101.156.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyhighmemory.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skyhighmemory.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2W4rF7uxL5/ePaz2/UIbfY3LLeZx54K+ebuG2u7pjYaGKaEflr20I4ti6+yRt7VO3l6msSH2MowHh5/7GQE/w6uaK5M+e6yBhz+nkRhao1vpTbm3N1kRu7oqOT5BvURdKebtSKXjalYQU22W21XmJ+94UKg8f2UyGoC0uAS74ihlyJ8MhE+qsxRxs6DFlrp/gdXjHitiUwzBsOskzE1VY2pLDQkusNC4/bL4inqrNjKUk9DnvY/pGtN5WPDHgUg7DhfgsSyzkd2Cxt1EPPSKGvMwWSltI6oQGWPCu4TTeXFUL25hO2tMG91ngErAsg1lsTPEJUX2G/PjhmikfwunQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ds0h7dlCT3QHLeqepVzW9zd7s9BjXoj/YZbGLhWeJa4=;
 b=j/s07+gTqzGdFzKep5KQLVtg2W1tG8nc7qAz1OaBNwZxJhLwBwmXCGfi8bpgUlNrCJYIChlaRqXPs179d/y+DMCEtdH+yQ1Jjkl/DCyAHYUzSswj6t/Q5MjtzY6+r4kPxo5oUX5BIQ/ZOTs/hOBIU6XSh12Ai351W9Iwt+W+MnJCV1U2Jq0gXVgD1lSZfMtPXTx30yHPjlIsqXN7kuWs1LfrI7IlFWR+tDIU9HB2fRwIelxfMhAYfCOfzq6c0usaqNz6Ni3nM4H6WXuWRgKkeOyv6d2Nr9d0rl4htLAOCirY24x14IB4y1Aq+iRNEMmHzqxioT6q3B+vq5cqv8MJkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=skyhighmemory.com; dmarc=pass action=none
 header.from=skyhighmemory.com; dkim=pass header.d=skyhighmemory.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=skyhighmemory.onmicrosoft.com; s=selector1-skyhighmemory-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ds0h7dlCT3QHLeqepVzW9zd7s9BjXoj/YZbGLhWeJa4=;
 b=ymSWrd5Hy6Lz63pbnCIPbLPw20LckgIZUfPU1L01QZ9/eaOrGKe2EI7eyyBgkslWdfth1aOAKgemRMptkchFP1nRnCXZCO+0kViINZmO1XM6ERSpdBCk9CSqbbUECdJhXKlrxXLCQH55CDlBteAJqZkXJHTPy4ZA1hDGZcCVQEduw7QjFJlCXmUlPaDFrelpLNs3uya3n4g7WjuX1VJ+r0S5MCfhXeYfN6FCuDA5N4osrII3sH2RJduDSmKNdtI1H1vgLXOo3v5DK2gpgeoht9dUJyiY4ZGDNSZmsMaBWeHsfYmXxaaHkWB0X3PndMFm4htUq2PDy5XXN2Yh2zf/Hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=skyhighmemory.com;
Received: from SE2P216MB2102.KORP216.PROD.OUTLOOK.COM (2603:1096:101:11b::5)
 by PU4P216MB2010.KORP216.PROD.OUTLOOK.COM (2603:1096:301:131::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Tue, 20 Aug
 2024 06:53:18 +0000
Received: from SE2P216MB2102.KORP216.PROD.OUTLOOK.COM
 ([fe80::b40e:6aa9:78cd:c4c]) by SE2P216MB2102.KORP216.PROD.OUTLOOK.COM
 ([fe80::b40e:6aa9:78cd:c4c%3]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 06:53:18 +0000
From: KR Kim <kr.kim@skyhighmemory.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	kr.kim@skyhighmemory.com,
	mmkurbanov@salutedevices.com,
	broonie@kernel.org,
	tudor.ambarus@linaro.org,
	mika.westerberg@linux.intel.com,
	acelan.kao@canonical.com,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	zhi.feng@skyhighmemory.com,
	moh.sardi@skyhighmemory.com,
	Takahiro.Kuwano@infineon.com,
	changsub.shim@skyhighmemory.com
Subject:
Date: Tue, 20 Aug 2024 15:51:47 +0900
Message-Id: <20240820065147.5069-1-kr.kim@skyhighmemory.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0076.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2::9)
 To SE2P216MB2102.KORP216.PROD.OUTLOOK.COM (2603:1096:101:11b::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE2P216MB2102:EE_|PU4P216MB2010:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c0f091b-6785-453c-3540-08dcc0e4c59a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YoqAReyWgD6RbSY7Ebl16SdGdjyyblv/uCaYAarnZjtwlxd1mS0S4nTTUGjU?=
 =?us-ascii?Q?5F6bHlDMUeLvtXuGhbFLnK/Nv4F5KeJDhb55GNHNV8VpO7+FLYp9qPViC8Ws?=
 =?us-ascii?Q?AMELwFmFqHfMR70s2pQOIzuhkCSk6dpMkfqmZqE+KRb6sHgI3gzI2a+6PgdQ?=
 =?us-ascii?Q?9fmHOuPs9bpyUYE6ADKcgrRrRarvMU85bmrmylcmbeUitnRBWbhqI53Czd9Q?=
 =?us-ascii?Q?1HZSEfVzoT/iny7lShuMPSWuLLMudGhn5FvU2gEfBgGjfchy8EJp+oMYl0cR?=
 =?us-ascii?Q?4kCyo/5qHWqJmcSgx8V1IsIPiIF9JyxHx6N0g/DhU3YMiuvplmGHML8VTWxg?=
 =?us-ascii?Q?/jTgQ/tNWwoppgCVOC13RgY27WkuT8TJNAqJljA60BA/oHOK/eSL1VB76+0j?=
 =?us-ascii?Q?M8stmjbWV+hSHmM9COvjEI0ugU8gZ+JubNwCWHf6o1FHiNzBPDJ2b7XlL3Q6?=
 =?us-ascii?Q?zQhifRzoOKBv+1CM7UWBfFuR0pcqSeSQRMyhG97k/5jIqi8VUZLwf9tmk8iL?=
 =?us-ascii?Q?6ZWkjLp2vuUMSTRdn90jm4eRBWV/2BDiE8pA4ShpFVehOSvwgWoK6HmPsH3t?=
 =?us-ascii?Q?t5tz+qDnO9gFvlrbC4OStaw8+JJsfdrmzBHhIiO7TPF3HlrLsGX9m2hvIR/h?=
 =?us-ascii?Q?TP4L9CnASN76JsnysPiDeP5+U+kg2Unj/wRt1j3bDxnC3ZyZuS7aakNncvhZ?=
 =?us-ascii?Q?SvPPziU5Id7N+9kEhpo+oZxEYoDsPDn1CebxDEUfUi9qbW4PB9MAlze+BA8K?=
 =?us-ascii?Q?/RaOuLQGMbO4KkEGcZKPjlkvUdnxQxMRW+zB7QHHttiLDiTKKIhAgR655CRI?=
 =?us-ascii?Q?UljNjOcdQKWBynI2vkOYIjDsL+mHhpI9KeTeby7vCH9NorI6mv/mvWKn3HYh?=
 =?us-ascii?Q?dArX4vv5oHHGSDFNwahIl8WHLdoE0jsSFcCw//qA4dy5CMmz5xDKFyQo7mBj?=
 =?us-ascii?Q?d+hv7NLejqafR6eiAQk+IfuvbOZwQfT11klsx/aoAygkeKJTQvbIacSi2vUn?=
 =?us-ascii?Q?/I2HZM+Aa3memPwrN1BTwyiU3VbTHhUUrAlxeVFMqx+GoENKiDSZ8GIvu3zx?=
 =?us-ascii?Q?JCnjmOWZrQxmIm8rBNAW1Fu7ZlwB7RRpCcvEnonS15Q0JvHk2oMuRKy7lnzY?=
 =?us-ascii?Q?6rK/OFmucCPEzgC3DjoBEeTv/5dFqvyUovTCMo6g5cMmJztfiV5tPK1EZI/m?=
 =?us-ascii?Q?5lzDTWpI8SMjT6/SyXZQNFds8x5m2AoV5hY2oHFIizl2jFgF1l3EBUE+r2xB?=
 =?us-ascii?Q?VskMC4blmNsosni7lEzYTiniX+ySJSrvbmY500S6vxVuMQ3huaJj4k3OTERR?=
 =?us-ascii?Q?+jn7li2wGKWyj6gVkXIHJdGDXdSkegoz+w+5xkIP8A1einslItTqjS5nns60?=
 =?us-ascii?Q?dz16xbx7qvM3TrrqfbbcEMwZJ5bQGM8JyZ19dxRAbA+qYwYNOhHSmcAowmgq?=
 =?us-ascii?Q?vxG/qOZCcnk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE2P216MB2102.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kosk3A/G8+riQTNd2a0Nv/sJq4/Ef3Ywhvnmn7GCXNJm3uDyrVPKSkDSzx9B?=
 =?us-ascii?Q?sO1A8VnOGtylUd1i4uqAuJay+MzWQbflB5eqZGnNecXcZCQ4/F3c2fcBxHNI?=
 =?us-ascii?Q?L3sQinEDPIXRtOhM7BaqM8wVhyo1FEHrS60enGDr8GqR0zwif16C4fqjBign?=
 =?us-ascii?Q?5syEx1zSCUmx7OeTna3guJA0/Z9Mib2yWUpQSikhyoN89uaniQf6Ck7fkdRA?=
 =?us-ascii?Q?zjZUfUOqdKL9xwx1MlPvGiR9CzDTXgajuTiaJIRExjTcxHO48s0U04pvpKYi?=
 =?us-ascii?Q?6tcUb5zwlXg5dF14uoTmolwu87o1rCgb9jp+4q5pToiLm1w0yUvPhy0+qLnY?=
 =?us-ascii?Q?QNwQVEOwoHcNxZGfk6wgrT34bqjXfx2Jtrssei31V5p10z4B7hcfn9xFV4YZ?=
 =?us-ascii?Q?zFpDgCPyQmqVzXtekKscc3MAN50gco5cpEzD5ngtezMdzK8txDLHAqThmRh6?=
 =?us-ascii?Q?VSN+vDXsDormjc/5d4iV6o094bYU9H7kJ/XQbm+geXfM0ola1OO64Jrx+5LL?=
 =?us-ascii?Q?PQujhGTNaBUewkWglPCCpYXgssoqrtKOo21ydhDgbm4dyxhV86a6MMcC9PX5?=
 =?us-ascii?Q?KBGgYGiL2OsjWxwBUL2EPairaSzV0dcKpRpW/lpElUxsioR6rLQycSGDoq9w?=
 =?us-ascii?Q?bJlKSBjsFp4zmz2vBIMqONpwdbIokefjxy1LASaTjmouC5CKaWijtF5JKZmE?=
 =?us-ascii?Q?dwSsD0/VG7qU13yyDjJGoKx8NvSABinYx34HGAzqr/9GABLZC/eyAYVHIvOk?=
 =?us-ascii?Q?vmeij6J7lDEbLsYUhGs0XbgTZuj2y0/D5xmT7GlfMVG1BlF0mnHW1Hy7YqM2?=
 =?us-ascii?Q?n7NDEJdeGxyoCi07ZBw8H2U3zN06qNsv78pNLcVWRTPPV1A+ExwTitdz5DBx?=
 =?us-ascii?Q?I6ZpYVNikD71jl6PpA0cf0O/GB4fd2c/L3KUZ6O9NDiS4wkkVn3wkH6/EXtZ?=
 =?us-ascii?Q?Q28xbVwJJJCKKvQp46bXaDywkilOMO0O8pCIfORaMAhadbIHucaq8hGpfSd/?=
 =?us-ascii?Q?1Ph1e+3qc1C9vQA2ZIGeLTp7s6f58tbYpPg6zYNfjCJ/opqXtnJ/a59jKVet?=
 =?us-ascii?Q?i/o1etXXwzvUXTLtTyd0aW0KWBJBiiz/vprv1b5kvtyj+r5UrDeHUzWZCZmE?=
 =?us-ascii?Q?C4j8ADKn0y+eABj4wbn7K0EuBWl8719fRPQvCZ6kWeS/3KMLDswQS56wOBDK?=
 =?us-ascii?Q?CklUPFuaN0olJUMHPEfYxm1jV2pnVKlKtaHJzlqvKK3d3NtbwzjKNfXr3cO5?=
 =?us-ascii?Q?o23/uIhPfP5MykkuaSmSsdHI45Ag1ksPnQBEHBixcbmk+wyz6YSkOmdq5LUK?=
 =?us-ascii?Q?r1xBM6IdliiCWB6/NI4gfHw/lzRQNszOwK5sOVflh8NZYxoV8UFkEZBJWnCQ?=
 =?us-ascii?Q?+Y43HfWnTfKa7T7Zj2+AdHH3+5WthOamqLKydKePmgk6HSUBZHb+WWOkpUtp?=
 =?us-ascii?Q?lol1PJK/6rjRT0yXtg5GHR6zIDuflE/SOv0EttFRx22Q0MIPEsdopJiIZnTD?=
 =?us-ascii?Q?NoczxIWlseambUNJ2cb5OvwS+au9FdJzA+IL6PUsbiIsGZSekef2jFJu++FF?=
 =?us-ascii?Q?cWhakVcaJqog9rYSnjdLD/ZNVR4PCPTJQdVdulHJzdt9J19Rv7CsSHvvT0ym?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: skyhighmemory.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0f091b-6785-453c-3540-08dcc0e4c59a
X-MS-Exchange-CrossTenant-AuthSource: SE2P216MB2102.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 06:53:18.6649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 39b82b34-0966-49dc-81a7-5bcab7ea53c0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvUR4kQerKD0Lzf+ZMclQCVtNWt7BTdCY4UpzAd/16dZODWm/IRAMqgGZitWwfw38ZyeTKkKrRbLiudCN+V2e7GXpwR4epYmpLNdXBD9MLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB2010

From: KR Kim <kr.kim@skyhighmemory.com>
Subject: [PATCH] mtd: spinand: add support for SkyHigh Memory ML-3 SPI NAND=
 Flash family
Date: Fri, 26 Jul 2024 11:08:04 +0900

This patch has been added to operate properly on SkyHigh memory's SPI NAND.=
=0D
This patch is derived from Takahiro's work who is author.=0D
=0D
Added:	=0D
	- Some patch code for the SkyHigh Memory ML-3 SPI NAND Flash family.=0D
Created: =0D
	- skyhigh.c
=09
Signed-off-by: KR Kim <kr.kim@skyhighmemory.com>
---
 drivers/mtd/nand/spi/Makefile  |   2 +-
 drivers/mtd/nand/spi/core.c    |   7 +-
 drivers/mtd/nand/spi/skyhigh.c | 146 +++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h    |   3 +
 4 files changed, 156 insertions(+), 2 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/skyhigh.c

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index 19cc77288ebb..1e61ab21893a 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 spinand-objs :=3D core.o alliancememory.o ato.o esmt.o foresee.o gigadevic=
e.o macronix.o
-spinand-objs +=3D micron.o paragon.o toshiba.o winbond.o xtx.o
+spinand-objs +=3D micron.o paragon.o skyhigh.o toshiba.o winbond.o xtx.o
 obj-$(CONFIG_MTD_SPI_NAND) +=3D spinand.o
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index e0b6715e5dfe..4a25ed49a61f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -34,7 +34,7 @@ static int spinand_read_reg_op(struct spinand_device *spi=
nand, u8 reg, u8 *val)
 	return 0;
 }
=20
-static int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8=
 val)
+int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val)
 {
 	struct spi_mem_op op =3D SPINAND_SET_FEATURE_OP(reg,
 						      spinand->scratchbuf);
@@ -196,6 +196,10 @@ static int spinand_init_quad_enable(struct spinand_dev=
ice *spinand)
 static int spinand_ecc_enable(struct spinand_device *spinand,
 			      bool enable)
 {
+	/* SHM : always ECC On */
+	if (spinand->flags & SPINAND_ON_DIE_ECC_MANDATORY)
+		return 0;
+
 	return spinand_upd_cfg(spinand, CFG_ECC_ENABLE,
 			       enable ? CFG_ECC_ENABLE : 0);
 }
@@ -945,6 +949,7 @@ static const struct spinand_manufacturer *spinand_manuf=
acturers[] =3D {
 	&macronix_spinand_manufacturer,
 	&micron_spinand_manufacturer,
 	&paragon_spinand_manufacturer,
+	&skyhigh_spinand_manufacturer,
 	&toshiba_spinand_manufacturer,
 	&winbond_spinand_manufacturer,
 	&xtx_spinand_manufacturer,
diff --git a/drivers/mtd/nand/spi/skyhigh.c b/drivers/mtd/nand/spi/skyhigh.c
new file mode 100644
index 000000000000..5829e8a9344b
--- /dev/null
+++ b/drivers/mtd/nand/spi/skyhigh.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 SkyHigh Memory Limited
+ *
+ * Author: Takahiro Kuwano <takahiro.kuwano@infineon.com>
+ * Co-Author: KR Kim <kr.kim@skyhighmemory.com>
+ * This patch is derived from Takahiro's work.
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mtd/spinand.h>
+
+#define SPINAND_MFR_SKYHIGH		0x01
+
+#define SKYHIGH_STATUS_ECC_1TO2_BITFLIPS	(1 << 4)
+#define SKYHIGH_STATUS_ECC_3TO6_BITFLIPS	(2 << 4)
+#define SKYHIGH_STATUS_ECC_UNCOR_ERROR		(3 << 4)
+
+#define SKYHIGH_CONFIG_PROTECT_EN	BIT(1)
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 4, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 2, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+
+static int skyhigh_spinand_ooblayout_ecc(struct mtd_info *mtd, int section,
+					 struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	region->offset =3D mtd->oobsize;
+	region->length =3D mtd->oobsize / 2;
+
+	return 0;
+}
+
+static int skyhigh_spinand_ooblayout_free(struct mtd_info *mtd, int sectio=
n,
+					  struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	region->offset =3D 2;
+	region->length =3D mtd->oobsize - 2;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops skyhigh_spinand_ooblayout =3D {
+	.ecc =3D skyhigh_spinand_ooblayout_ecc,
+	.free =3D skyhigh_spinand_ooblayout_free,
+};
+
+static int skyhigh_spinand_ecc_get_status(struct spinand_device *spinand, =
u8 status)
+{
+	switch (status & STATUS_ECC_MASK) {
+	case STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case SKYHIGH_STATUS_ECC_1TO2_BITFLIPS:
+		return 2;
+
+	case SKYHIGH_STATUS_ECC_3TO6_BITFLIPS:
+		return 6;
+
+	case SKYHIGH_STATUS_ECC_UNCOR_ERROR:
+		return -EBADMSG;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct spinand_info skyhigh_spinand_table[] =3D {
+	SPINAND_INFO("S35ML01G301",
+			SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x15),
+			NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+			NAND_ECCREQ(6, 32),
+			SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+						&write_cache_variants,
+						&update_cache_variants),
+			SPINAND_ON_DIE_ECC_MANDATORY,
+			SPINAND_ECCINFO(&skyhigh_spinand_ooblayout,
+			skyhigh_spinand_ecc_get_status)),
+	SPINAND_INFO("S35ML01G300",
+			SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x14),
+			NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+			NAND_ECCREQ(6, 32),
+			SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					&write_cache_variants,
+					&update_cache_variants),
+			SPINAND_ON_DIE_ECC_MANDATORY,
+			SPINAND_ECCINFO(&skyhigh_spinand_ooblayout,
+			skyhigh_spinand_ecc_get_status)),
+	SPINAND_INFO("S35ML02G300",
+			SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x25),
+			NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
+			NAND_ECCREQ(6, 32),
+			SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					&write_cache_variants,
+					&update_cache_variants),
+			SPINAND_ON_DIE_ECC_MANDATORY,
+			SPINAND_ECCINFO(&skyhigh_spinand_ooblayout,
+			skyhigh_spinand_ecc_get_status)),
+	SPINAND_INFO("S35ML04G300",
+			SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x35),
+			NAND_MEMORG(1, 2048, 128, 64, 4096, 80, 2, 1, 1),
+			NAND_ECCREQ(6, 32),
+			SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					&write_cache_variants,
+					&update_cache_variants),
+			SPINAND_ON_DIE_ECC_MANDATORY,
+			SPINAND_ECCINFO(&skyhigh_spinand_ooblayout,
+			skyhigh_spinand_ecc_get_status)),
+};
+
+static int skyhigh_spinand_init(struct spinand_device *spinand)
+{
+	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK,
+				SKYHIGH_CONFIG_PROTECT_EN);
+}
+
+static const struct spinand_manufacturer_ops skyhigh_spinand_manuf_ops =3D=
 {
+	.init =3D skyhigh_spinand_init,
+};
+
+const struct spinand_manufacturer skyhigh_spinand_manufacturer =3D {
+	.id =3D SPINAND_MFR_SKYHIGH,
+	.name =3D "SkyHigh",
+	.chips =3D skyhigh_spinand_table,
+	.nchips =3D ARRAY_SIZE(skyhigh_spinand_table),
+	.ops =3D &skyhigh_spinand_manuf_ops,
+};
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 5c19ead60499..421c3ce704e7 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -268,6 +268,7 @@ extern const struct spinand_manufacturer gigadevice_spi=
nand_manufacturer;
 extern const struct spinand_manufacturer macronix_spinand_manufacturer;
 extern const struct spinand_manufacturer micron_spinand_manufacturer;
 extern const struct spinand_manufacturer paragon_spinand_manufacturer;
+extern const struct spinand_manufacturer skyhigh_spinand_manufacturer;
 extern const struct spinand_manufacturer toshiba_spinand_manufacturer;
 extern const struct spinand_manufacturer winbond_spinand_manufacturer;
 extern const struct spinand_manufacturer xtx_spinand_manufacturer;
@@ -312,6 +313,7 @@ struct spinand_ecc_info {
=20
 #define SPINAND_HAS_QE_BIT		BIT(0)
 #define SPINAND_HAS_CR_FEAT_BIT		BIT(1)
+#define SPINAND_ON_DIE_ECC_MANDATORY	BIT(2)
=20
 /**
  * struct spinand_ondie_ecc_conf - private SPI-NAND on-die ECC engine stru=
cture
@@ -518,5 +520,6 @@ int spinand_match_and_init(struct spinand_device *spina=
nd,
=20
 int spinand_upd_cfg(struct spinand_device *spinand, u8 mask, u8 val);
 int spinand_select_target(struct spinand_device *spinand, unsigned int tar=
get);
+int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val);
=20
 #endif /* __LINUX_MTD_SPINAND_H */
--=20
2.43.0


