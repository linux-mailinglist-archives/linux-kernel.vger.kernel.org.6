Return-Path: <linux-kernel+bounces-260192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5328593A45C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56F41F234DE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F939157E87;
	Tue, 23 Jul 2024 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XdG4KrpI"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2071.outbound.protection.outlook.com [40.92.23.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD22114C5B0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721751953; cv=fail; b=O/a5pmhN2328DMbdNNJ43yqjCpd4sVqtSZ1v4ETk3X6Y88HNuXdWDYac7BQNYUP6YrYG0AOyh8tbS9eC2TqM0BZXO8B5cJtKDaTJSYG62RGgUO9vz4+dBbzFrJc2a14Drnp7FdwDkAMU6POmO3aUFfFwNH/vgavvkfwB7KHIxXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721751953; c=relaxed/simple;
	bh=suZNAJyPrugvrOAajQeUUZN+Os5Sqz//EIbj8NjI8tw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DItl5W6tmCKSwchtGZXz9mwYgan/u3NbgFUcsIrTc55ASQEzPpzRwz4FmelyBpac47j/kGbtX4GL1uDlUwPVZxjMuIRLEWikvGfSE+0dwgURpkEm4QkrOMBXfARanCf7AQWlQqdUN3ld6cFoA24IpKWR1Lrl41NFiJ57oWiBlCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XdG4KrpI; arc=fail smtp.client-ip=40.92.23.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dqL7jRNIaXVxG0Hq7JYC3LuElxzOvDaz6AWy4A5XWs5e6cr2yvEgbfFby+Mz9Hb2mSJy37TzLEroz56TJNZS8RVowI91fNkGxQ6ggCh6OZqqn8yDPh5cSi5xWaDoTJPl8dsITmTPhbiQrLx+D5dKKAkJOYAv8Gd0p1wK5ltEc1w9BGOf/AGoaRW1xn+UBia+SuC0tNP60M3auTgHX4UfJl82jE9DobB5hkUA8x8Mx0aXveIUM0o542H6jhLuRSjZnplIokdVyewUHB4gN0lfSHE1NPssJIkD6XdfYA36NpKvxoBa13JtRWmvnOtfAqA9DmIxYQGj3G/yo5HndqZxIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgXQ1QsSRoujttvQpiuwpEVBhPDnW1BO/hgnk4qz+Rk=;
 b=lHPqqvJejgY6zigqM23dDVcm4kIzc3UAUUPDf/Yh49Cfalp3Phw3+kH7VpjeVpJ9UIHj8MoD94ePh3hNK41Xhq5ZbRz4Q/qL4Dy1hIfh8uWDnMM2twelBC69X5sos3JJgbth/FpJ2h4XR/lWmXqvcHp/vTFemTTkj1QcbXiWxHGPmiAG1/Qk9CkcQfSoCBUlablTbP5z0BWzxj7k7m/GutV3BwjRhgevhY346UT/+97/6A+JdvK5n9HByvoO8yJ+3Gs30WcUVzCGatHqUXJAF4plYnM8U4An/vBZpN11mlGgUJpyM2EB+IvK2B60+RxM/ppeUurKoNO3W217m7EkFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgXQ1QsSRoujttvQpiuwpEVBhPDnW1BO/hgnk4qz+Rk=;
 b=XdG4KrpI1PwYnaa9t6NRfUPwe8pclgKJBHrqi6ioltJ8oHOaRb7VYslGd+wkt+vFb5/KO232U+2PmwOqNRm4bUoTAu8t413dOXR+XS9rP8y0gDzgGHC1JRiWdY+GTJBuwhqKUyeYBj+LaeQAchhbe+rt8uFJpB2Za8pgh+Ix6wZDzAVqB2qUY21NmC06YKxNxr5WD6xtZG7ppAv87/PxdOEAWK5jaTolgjSjLgr+T9/vAzToUZg/jZwYY6YJouRLSLDNgOu878cJCore/K68oEaBabjUdct05Ytv39FgNrj8tMhH3Hk+mLwNLyHsQ/MSteS36FU88zksTxkFbaOqxw==
Received: from SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:a03:570::8)
 by IA1P223MB0522.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:3ea::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 23 Jul
 2024 16:25:48 +0000
Received: from SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 ([fe80::b5cd:c37a:bd3e:e3fd]) by SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 ([fe80::b5cd:c37a:bd3e:e3fd%2]) with mapi id 15.20.7762.030; Tue, 23 Jul 2024
 16:25:48 +0000
From: Steven Davis <goldside000@outlook.com>
To: gregkh@linuxfoundation.org,
	christian.gromm@microchip.com,
	parthiban.veerasooran@microchip.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Steven Davis <goldside000@outlook.com>
Subject: [PATCH v4] staging: most: video: Fixed minor capitalization and grammatical issues
Date: Tue, 23 Jul 2024 12:24:49 -0400
Message-ID:
 <SJ2P223MB1026A75E582B79FCD0DB1C9BF7A92@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [kLw+Yxiqk4V/O7UJQGJE7bcKGrhjwr+H]
X-ClientProxiedBy: MN2PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:208:d4::23) To SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:a03:570::8)
X-Microsoft-Original-Message-ID:
 <20240723162449.1456-1-goldside000@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2P223MB1026:EE_|IA1P223MB0522:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ae9294-6771-4fff-a9fb-08dcab341c3c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|8060799006|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	RyG9Xm3yzTzhHa1gI15TPDlaXv8fVoMDfFyNcB8kiHOLzP3iSiYYLCU+pyhONI63mWIoH+cRBRzF99yztrjjO6RwlJ7IImbAC2guh8RasIyabxYEb538SY6VQUv1C9Vitwf94qSzEQYWDcWdIbUhLXtlCey2UCDYwYAOrZYdkXy2zs+TQMC5g4ZpSelGHx+mkZC+n0VOgndv9ElTy7Qs9pgSck3vplpNq5TCqbRN98RrjVexfB963Oj34EtUzqsi24v1PYzDJLfqxEZuQMbK0WvNSFVJeHBmIrmhhz/OUDmeizKRYakCSQ38XgLGXcGUxUsbtqJ+hSGiauz7fbYsqXoYArkWyizIzaOgKxM57HL956Wt2cLPscm295/Bl6iARo23wUq1agvzgL2PQTiMoUzWY8vI8Slx3hD/VpLYiQ1IOY+U/t6fGytuBEKZna5sp7BlN3tVUDIi78HeEOwTFTX6QXbPGjAjID/HFGxMVUNgTODz5bOCtFgnnyPuMhhQVzYka9XDF/zFJuMdEZ873nwFDH72bCnV+WFKB+oaMdeEknhs0pV02gPUyaFcyKLAQvIixHhMkU1syXAsTUStNrbF7fsWKzbsO1zyMIWicBOR1WMGvzK1z2+vJBIY0pCltqdjk2fc3v0+/uyGXSOy2Ncsst7U25dQvUSNB+yRTHQfrHnogkKoUKgfTM7XzkP3
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VSjXTRhGpwmLWoMp4d3cYfS2BEUYM+L6mOpBCRBRWn1Rd+1g7Jqov9/uzDBC?=
 =?us-ascii?Q?ImJYLq26qi9tc1kW1f1QMaGHszhPhPKYEcZZXbJKFs0qwWezPJUTrKP70XrO?=
 =?us-ascii?Q?lXNHsHjd8sLrOh9yBtoIj6IgqMiotaAw2FAMZXknlS/WAG32GBrQxPhgL36P?=
 =?us-ascii?Q?ZeF7A8aFMqyZ0P+XVKGSObD8J8WTEhtJGGzbQBmlTqsoGk1TUFaQUx+4J9lH?=
 =?us-ascii?Q?a7yUgjHHPaCWwyEoBqFDQpvg5pJU0Z42jdPTVYksJAjcN+W4ZiXwI+jgtJ6G?=
 =?us-ascii?Q?TqMR7VliU69O4OvtM2pohBH9U6tORlPkg+PnRup78LGk7TpgJ6IRSXs0NT4P?=
 =?us-ascii?Q?Ntr7xBZfriCSw8Sg7+EUWx86LOlb67I0olQZSMwWxVhiwhUgEL/+KfPEjrGD?=
 =?us-ascii?Q?l+vKBdWRXkCgrqddIzmRA3zuEVuXXZlVmQhYFPOC6pu2UlqE9XN4hiE5Hu7K?=
 =?us-ascii?Q?2wOAduh4ClqvdHPCFqNbzO3hmLux045e91cNgdRog3KO5++ktHeoapR1cRQt?=
 =?us-ascii?Q?Lib/WM2Svs8XJ1cofae0UmwS6AC15O7MQhk17Alng+ZjLjq/yV3rSp14Q9UG?=
 =?us-ascii?Q?XCWN5ndfz/jb9pIGdni5jVz89cXt54BQu28Vwy18C5O36w5QCfIdauRFmgwk?=
 =?us-ascii?Q?qOJCe+l4dB/+rZ12NaKy4yVsZ4JF4yVk1CQpWRcWrdJXYes78naPqmjCbSRN?=
 =?us-ascii?Q?7FEpGKEkkjru+Zyb5ZnlVkvmkKm+f3dehGodINZ1lnFlCMIxEXzd1+mmmFVJ?=
 =?us-ascii?Q?ZJHGe8IsubIzeNChhG4FQF3nR0dUjE1uIjSQDsRE1dKKHxCIEZpwo2SsaYJ4?=
 =?us-ascii?Q?Caht4GuCbn1zd2V16z7HCF1J7WAJM126ytvaQ3dxsoj6cc1Bw51IMEC8EfSz?=
 =?us-ascii?Q?A+FTLtW1ysGaBmO4WmZ/U7/hAsLSfktrsYcViWoNWlZJymSvwLQVc4C8P9gY?=
 =?us-ascii?Q?tz9v4WeUIdTb4bVbZ4FYj+7rVpCEEE+aajCiCGxy3mqy0lwhslCmJFfKgBSc?=
 =?us-ascii?Q?9FZbFd083BidhZ3WkzgS6nAgKSzfkxg2fK7a92m/IUfdMmAxcQgm5SWpXGrW?=
 =?us-ascii?Q?mXkNCAB37BIflk/mkAlfpMSvXo8APDIfyVVI1dJNU+RNIU3p255hhxsQVKVq?=
 =?us-ascii?Q?M0eRO+k00P1eJqsP3cxvRs1uvjQKIn2qHuzASnjkkK6l14SDq12qb9UgzHiM?=
 =?us-ascii?Q?/WKKEUXMsu6EbDkrW2doIF/ax6j50E1wl8cwPc3DdAW+ghQe8f/+rK5C3Aw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ae9294-6771-4fff-a9fb-08dcab341c3c
X-MS-Exchange-CrossTenant-AuthSource: SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 16:25:48.2806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1P223MB0522

This patch makes three error messages in the driver easier to read by
capitalizing the first letters properly.
For example, "channel already linked" becomes "Channel already linked", and
"expect" becomes "expected", as you would typically 
find in an error message.
This patch improves user experience by making the errors clearer.

Signed-off-by: Steven Davis <goldside000@outlook.com>
---
V1 -> V2: Added a patch description
V2 -> V3: Changed subject line, removed apology from patch 
description, added change log

 drivers/staging/most/video/video.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
index 6254a5df2502..2b3cdb1ce140 100644
--- a/drivers/staging/most/video/video.c
+++ b/drivers/staging/most/video/video.c
@@ -454,18 +454,18 @@ static int comp_probe_channel(struct most_interface *iface, int channel_idx,
 	struct most_video_dev *mdev = get_comp_dev(iface, channel_idx);
 
 	if (mdev) {
-		pr_err("channel already linked\n");
+		pr_err("Channel already linked\n");
 		return -EEXIST;
 	}
 
 	if (ccfg->direction != MOST_CH_RX) {
-		pr_err("wrong direction, expect rx\n");
+		pr_err("Wrong direction, expected rx\n");
 		return -EINVAL;
 	}
 
 	if (ccfg->data_type != MOST_CH_SYNC &&
 	    ccfg->data_type != MOST_CH_ISOC) {
-		pr_err("wrong channel type, expect sync or isoc\n");
+		pr_err("Wrong channel type, expected sync or isoc\n");
 		return -EINVAL;
 	}
 
-- 
2.45.2


