Return-Path: <linux-kernel+bounces-293382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA4C957E99
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6111F24CD1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B8FDDA6;
	Tue, 20 Aug 2024 06:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skyhighmemory.onmicrosoft.com header.i=@skyhighmemory.onmicrosoft.com header.b="PxdvFO7X"
Received: from SEVP216CU002.outbound.protection.outlook.com (mail-koreacentralazon11012021.outbound.protection.outlook.com [40.107.43.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117A71849
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.43.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724136467; cv=fail; b=HgETuWhzUE+XrVoDTpSjXNxWWeltIclAjMAjmZfbDZF3fBTHxCCGJEZlfHfb/m3U7byPqedNdB+gEBZ2X9M0p40hStTg4h933/zE6auXvWV+7utyOPOj5UizbSN4JVLoTVpvZGau5UQrxo3r82uqUHY6V0vSglNleJz63XsoqZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724136467; c=relaxed/simple;
	bh=7srXbPm3Z345LZjw/t/Vkz3TvTPCDKGHsPY46dvhVl8=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kkdzGiN4Cuh338aaanAAq7f0JZUC3gClyQuWTrXlmQnWJTkhK75DekLWVzqd5z4gbieEfOeRUquEGjMdTsU5m/nDdlnBJ6OzRNgVj+o9YvwdnLjiUItJpR2MXoIuR+JA9ZZ/omV/WcM2DReHF7jyozu9Mf4i9WTjamb77umIRzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyhighmemory.com; spf=pass smtp.mailfrom=skyhighmemory.com; dkim=pass (2048-bit key) header.d=skyhighmemory.onmicrosoft.com header.i=@skyhighmemory.onmicrosoft.com header.b=PxdvFO7X; arc=fail smtp.client-ip=40.107.43.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyhighmemory.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skyhighmemory.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajh382601j0bBJ+Ej5DiuCH8szNi98zYKklwKxLGGLf2AQ4fxJB/I16Owk3Pq2Knp1du4EgrB+pKZWfOpGGoKMPKI27cqwK7KcW91XpH3MhMHw16UDGwBGMSJFdQ1epEYdBlSwTbYUttws1vOUo3E9aKpsFp6upKbAvhaBZdEpXE/fv0Xhd9T402C9PWGgyt/BWvA4aUorWXFhyPa9w3v4aZL3cN31n5GiLBZMqchvdSeBzdC0YSUTEA3UV7UT88nCOedmiN8nC/o8cDxgTRnmEN9bYePQ22glDI2JRyws+OCereoRO4SaL3NjEjCuR/myE8cA/BIcd3cEppcdhzsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Bv2Qg8hUk1/amf8atQbGIjfDjpLsk845IEQXEtvGkY=;
 b=DQcytBRJ5JuNpHe9/O3g2uytr++1lkCffLpK2TA6qNI388tkoXSftDkHbz28BShzMeJY8TYDj/sZV6MZBAim7if/mA5El58E/uOyLYPxINYK7NGNlIBlvHF9aqq1g4L4c5YG1Sq/lzh2TL/VNpjyPQdkUt3C3LVJqGdaqo1enIYwdfHwyzKaOcHzWo3iBDRYf/1rVCvD4SCHss4jZWMR22Q4YRcUKkK2HaS4UR6/FPTdW4J0kkFijYAPVA6pKPbjipUfzEPLUTEMWtoor+c9ls2/cgFZ1SqrlVBx7gf2MfbfJMqC0vptGOjOk5aqKTv1twrhpbLn5ithtOy2pf5jJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=skyhighmemory.com; dmarc=pass action=none
 header.from=skyhighmemory.com; dkim=pass header.d=skyhighmemory.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=skyhighmemory.onmicrosoft.com; s=selector1-skyhighmemory-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Bv2Qg8hUk1/amf8atQbGIjfDjpLsk845IEQXEtvGkY=;
 b=PxdvFO7Xrmo7JeknH1kp6vw4blu7mJUysawdyGXUilC10iHEH9iU57TbPDGKh9YC/OlrTc2VRAHm1NHu6MdIqPfufQ5t3i6wrXmk46aUwYGMKuxdky0t3xjf5kgWxum2qtvYrSFgbXjdP7POGihtfiLElKzAmAAzJwlyL8rmiCuWrwUHs5WAfPoJ2A+gCyPtoaLalDCLWATunYJerwIxsliLfvZqlyWRmQ4Q2zaTCzUJAf68OgnEEZs+c/9gK2pperhsb9myInvI1xfw9uo54+/N4T+/+l4b14TGWpevlQjYq90SDsUDZIsi22uVe7EsZ30DU4bDz+FEDSnIWl8unQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=skyhighmemory.com;
Received: from SE2P216MB2102.KORP216.PROD.OUTLOOK.COM (2603:1096:101:11b::5)
 by PU4P216MB2010.KORP216.PROD.OUTLOOK.COM (2603:1096:301:131::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Tue, 20 Aug
 2024 06:47:41 +0000
Received: from SE2P216MB2102.KORP216.PROD.OUTLOOK.COM
 ([fe80::b40e:6aa9:78cd:c4c]) by SE2P216MB2102.KORP216.PROD.OUTLOOK.COM
 ([fe80::b40e:6aa9:78cd:c4c%3]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 06:47:41 +0000
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
Subject: [PATCH] mtd: spinand: add support for SkyHigh Memory ML-3 SPI NAND Flash family
Date: Tue, 20 Aug 2024 15:45:47 +0900
Message-Id: <20240820064547.5035-1-kr.kim@skyhighmemory.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SL2PR03CA0022.apcprd03.prod.outlook.com
 (2603:1096:100:55::34) To SE2P216MB2102.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:11b::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE2P216MB2102:EE_|PU4P216MB2010:EE_
X-MS-Office365-Filtering-Correlation-Id: 01db7dc5-5751-44c2-15cf-08dcc0e3fca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nr2q2+abgriinBL9xjgu8spXZGVGFlzfZYVoC0OPWku0/JD+dJRKr4gtOi8l?=
 =?us-ascii?Q?6VWpaP8qylyfyYJ5YZ4n2UMtzYoKo05BLs/8ILDZmnd/3eHUMG7MDkr5XILe?=
 =?us-ascii?Q?iIsGjysVan13iU7cP+I2kGta15pe3wi5l5hd6NcPL9PP4Kqf7a3m+alkMu+X?=
 =?us-ascii?Q?arLw50wD/okrD2/ft5z0kupkU0Y4wevm3mAxrPzX+KT9hETMYzmHE5m9Y/Pc?=
 =?us-ascii?Q?jqzK4j7VTR7zJHfrW6OKw7U6cQRuSpFEZ3SGcaxaZ4pDkoni2MMuZgfc51q3?=
 =?us-ascii?Q?2Bj/ArF6sf+TRk9UHyyendAKTytiruoJxCIBqbOOTPrE/s8E5ndwKCGvGqSS?=
 =?us-ascii?Q?iKYYOoSJn56osw9PqldAJ3k3ic4pKoxUlOWxZpXlv/OeboFQVVElyJKkoK8M?=
 =?us-ascii?Q?L0t8gw52VELed1HJ++wCD5mVWqtKxIRhhl5ULen0RUMaD7PB6SLlVb1p5W2o?=
 =?us-ascii?Q?E6n1bMeE3tIqnDPuz1T3xLve9WkPWCNZfNz+wZKyvh7uoB0vFdwgSMgjQN9u?=
 =?us-ascii?Q?JjZQ3LBJKyFq6ujERZS+ZYqZ6MG1HDI72jXY5pmDTpz/x/70slNKSWPL3mAZ?=
 =?us-ascii?Q?5Tg4d+KjpRx/82+O8BTFpNvlPjWXlnnmbAJCt/cP8JbWF+HJ0pH7zIVRYjT6?=
 =?us-ascii?Q?L0ICbirryo+0xwoGPQZ+3vJGrcIggtRzDqr6wDcGxA8Ds8YCheC6c2z8B321?=
 =?us-ascii?Q?P/VNX6RyVFpNT6OGzRN7Ffk2JxoEe5Yo6/HVm9Vb1zV/vFaQfmPZzLTPSkEA?=
 =?us-ascii?Q?08c2f3eySJFVry/3cNeD8KdUCnBjorbvYabtD+x/hXTu94144CwFiE1FCaP/?=
 =?us-ascii?Q?RVB7heHXJU7bLW12G7xSyE+9/84Ar+jd5D5xpkQb8JmLl/VhV36MiBcea+sB?=
 =?us-ascii?Q?BBNngpPitVjhgopjf6tMU04RSXNv4wzzXWioZZlsTOpaBgKxLTtmDMmYik6x?=
 =?us-ascii?Q?FQkliUkt6sZ63IcvpfWT6SoO5yhtr1CDmC20r4GbXfQJsn1NJlHCBfTzNVZK?=
 =?us-ascii?Q?SnG0YeFa+GNqIPEdL5fDK1/C9bkqqyMh6eKc/N62qu3cj96T4vu0/eGxgb+F?=
 =?us-ascii?Q?zJS7RzJYylLx6TykZlU/YKoDNrxviHUPa8for7y6vsmO2096TlAho7wljBa9?=
 =?us-ascii?Q?3yL9gFZbMJ6F0y9k2Mg288xnWENRHCsDNUwVltjPsynXKuJwFCwucK0Y9MPh?=
 =?us-ascii?Q?ReTG8skD8o6pYPl2exmT5+6J9cF31LwC200OWTthaAs7lM2lVIv+pUroLmwU?=
 =?us-ascii?Q?hzN6Zg3TAXX4RtPpz5oExJby/33xc4gjoyhp34HS1PP03+W7qIfecXfT56RR?=
 =?us-ascii?Q?JruTyOLBL9SmGKB8qKKBoMG4uetCP4GgxZoRWCMK8dDbmBKenIh33jFZ1Qi2?=
 =?us-ascii?Q?5y+xGXsr6U/C6XXIRTNUE02jcflBp/Z5AtP+U9Ent2eGv4SlMiF/XC1TbuVU?=
 =?us-ascii?Q?gWznLboz+vI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE2P216MB2102.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0QJMrgGkmWmGFeEP8nx/sHkYR9h5WKwqUMs8mnGrVLjwPxypkfurGLgjMZ81?=
 =?us-ascii?Q?YKrXcxodzByQu3x7dcU03Fdo4IQIuB8IZKoH0S2Vu/j8mn1UYSM3VIHH29TS?=
 =?us-ascii?Q?6jsA2l3iGcEwOKEuczRrJNOd9VQ60DbfKLcJY7YBQfMuickvd+X7fsUdaN5k?=
 =?us-ascii?Q?ukFC39iQXFQ5bZyE8F3HDThSjwSmy5bDSCKQctqc60H1OtEBnhY9F7MeRvV2?=
 =?us-ascii?Q?w0hSaabJJm3yFG8efJfNsffHdf3KwMbElzZqlpwt3MJHvZfTTTWizkNPJfHG?=
 =?us-ascii?Q?B1TxhQ+QuVcEVhrPEInca/Wz/oaglAyYmgHi5ra8hGGE68bdrO0w7WuHGE/d?=
 =?us-ascii?Q?h10803IM3GsRrTF3BcIKoLvjc9z0fQ4s2SylaxoBA68Y+oLUZWKZkFNL0BeE?=
 =?us-ascii?Q?7lQ4b8s4AUaeq73qxPudPMVtC885AYTYrl5o5YgY8uGVfAjauKIeI0gfy8S6?=
 =?us-ascii?Q?qzBEzb2TUsp2BjBOj1Uh63u+jfdQyVhW16qBqwIvGAVFEqrEo8CcC9650c5w?=
 =?us-ascii?Q?aFnPNBkAnUXhPYWDg5gngHQ1GLuxDLLn7bztmCh5oeYUWJc9D2hq6R3GEQKS?=
 =?us-ascii?Q?2uCK14BY3xvTkLmoi6hm4shTHJWMcQ4xY5It9J37xqGZM/9HQVKmwsIjIQ7l?=
 =?us-ascii?Q?0L45TE/0Z8RzRbmADtkW+YBEHKg77zf8aL/M8aeDJZWMpjQVUPCgRN5yNFXY?=
 =?us-ascii?Q?C1dmOmbni5KAyo1kWqs7oEE0gWWwhfHqa997g6guiMQB/ePUPfV1zGgVfujF?=
 =?us-ascii?Q?E0CyDoZ8gW1cpy0Pkf4IQgRwCflc9u00UdkMmolL+Q5PbA90W66majB4r+Sd?=
 =?us-ascii?Q?MwN/mubLWWKsH1TJgHELjBl4sXXc9Uqq5jJSp+IvzY2jy/ynP6gDUP+MtWUT?=
 =?us-ascii?Q?R9d7jMTIBG1hN0n8GYdi35WzHMEJQPRBhwF44fcCtxrqT/msRCpKB0b20BXI?=
 =?us-ascii?Q?AvvKqiUWgptTeAcmDrMDGzKQv1RpOCkl+nK8lzZEB7Q4jUGLTJwJHTg2ORyO?=
 =?us-ascii?Q?wQaHeEDXr1S434GBPSWdkvw7tSEOCTiRdHuQnNvRZiSsGdNW4PwEEjlKvAKJ?=
 =?us-ascii?Q?k+TaUr4UCv9Y6cNhpb2KwMpFuh00BCww9OMEuaZWqYBzbbzWkhKma98OJque?=
 =?us-ascii?Q?qOv0IXKJa7w3+zCuCClbBwjUvhqi0zEewPFfMcopocamzNoY8UtS0NKY1iga?=
 =?us-ascii?Q?3LH47+WrSvZDt1WBoiBtLardPWQTCYRigmelxyqmxkbGm5tFjWPqVWUn8FyE?=
 =?us-ascii?Q?ECUuOLPyMG4e0Jsmu5K8AjWwMSEOdzXF4ptBWV2RojPa2I1AI+/uZ3lKmVlX?=
 =?us-ascii?Q?k5+n3pFfpOejwxtPKqLO7cNKjDDv0ZPtItL+i0niz3yyBvt6eig8f2Qah8HK?=
 =?us-ascii?Q?oCn3qJbTnEMVcvOYS2v3KcLFyU8QNoZdKlrZMiGOhimreAhNk5pcl88581fP?=
 =?us-ascii?Q?autHSxdfkl2K+8WUpCDtJc5b09UJuGy1PdMLjY0vFecuK7ZEU35ms9IQ73M6?=
 =?us-ascii?Q?odankk3h35Wgc4ekilGDkMGrlceLrKZyJNo3IWeVy4rj9Wqghfihkw1vXShw?=
 =?us-ascii?Q?6JCFFAixU60L0mdxlghmSQSz0A1mBG+HPDUoyZ2gHxIFigrjRXcfLToOB7N7?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: skyhighmemory.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01db7dc5-5751-44c2-15cf-08dcc0e3fca9
X-MS-Exchange-CrossTenant-AuthSource: SE2P216MB2102.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 06:47:41.0155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 39b82b34-0966-49dc-81a7-5bcab7ea53c0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2gH1R1fhVA8RfnG2TZdtX0JNa1tEfUTiHZ/PcwFLgdYKVwEmhvgBiar0s7jp5XCqUg1Xc9yqVlE+7H8D/TVKSHZsxKu+Or4L/txiN/wyNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB2010

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


