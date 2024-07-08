Return-Path: <linux-kernel+bounces-244063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF91F929EA1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7411F219D7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C61D45BEF;
	Mon,  8 Jul 2024 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="nw19tyyx"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2060.outbound.protection.outlook.com [40.107.117.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1241400A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 09:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720429468; cv=fail; b=TEIRMtu9Ck4zPaoWy5OmXMoFkI39OyKBZZ8iEduqAN6hqVgqTUJjtmhye3u87C9wGCvHw/bh6ap35C4ywUHVO/h8fVmpLXmwlyKnUOWvRdFBb8WNCpX5iLUY5IOKe+3MziUK8hSt8zaK09GVBvuoQOLOEJ81k9Gnb0Z+KUlh68k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720429468; c=relaxed/simple;
	bh=4ZDhWNXPA2VmswDcc/NLSULgkGObRGk1H2bfOsNDwz8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SnPyriTAS/Mu2saVPvPZep53FJjSvQ9YEFC35OZbDj2TDFw9n2FFq9ICqTaOvkIbKBfd72EUxcs8CGmkbbIsOMOv/Tu8tfs6JWNWaOERPeCCqbEjcPnkk8nAA5L5yM7TsfUWZrBGI9wMtro44CjeHzR4PSTtMdylODLpMpQ3dkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=nw19tyyx; arc=fail smtp.client-ip=40.107.117.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ar0oEEDMYNSy+KzPdbCFlpmlBCAupcCGSaPI41cQxsP+bi8mBK2EZiZzx3k8MmkyQjU4rO3U36XW0zMqGi5J46am2WwDcV6BItL2kvb377tmwKHI+H2+TIOcIv0Dh+A2j8RZQljZoTGWKFfWWmVS8kvENofUYNk072h/E9euojk0xTXefhAGi9bXieBXcjzXAvju9JdKAySyvwc03+X3b7GMDrmWH/u3C5KQ1yTwbFmBoY60l/kf6VkRz4w/Ku3WAAku7eKMq/HO5/dOSJYfnOQ/JX+l4MsWn9h3I2j6b21oXPv+0mMluMyIU28zkYS0t4t2f6sj1+9x/nl+ZXsgvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acXqe6PTX9VcN8nUmysG90Goj+fqwohiaxiCxKistXA=;
 b=oghNqsJGx8TFD6DQyh7kQO11N5h68QPdkfEGre9eBvgRlczKaSjenyjJFS5uAIryjQkWciOWgXR/kwW2VnRmX4hFoNspaQk1pxOkUIFteV1q5RJQP3SWEeeyVWLER3gPNB1Hmrbj3G+a2LqbCjkpQTr8jEZAtNX1quYyLjgf+4JOqHOLY0dTguhd4ndLIvSpYIgnx0z5AjzWCCocw2r90vHkY6/mDRcvtyJ4qpEJ2hFdwswNVXMgLo4JzjdU3LIhbGAiFPTGMNtzmfFxF7MLJfsrdKi9Ze3WvEeqNBKfiHADA3PyvLq8AhOKJ9wbMm099BAOIBKmNA0oNoQamTeOvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acXqe6PTX9VcN8nUmysG90Goj+fqwohiaxiCxKistXA=;
 b=nw19tyyxUaM5fFJj5J2RxtkS3Qv15PP1TefhY2otFUAODpQWmzu/W0HbWdO6DNjkosV6/s8Rct5s46uQIqoju3PZVTGcew7E3g5kL/cbaxP+xilamUTygsgWmzIUVaneLH3YagIlSbHZmknXIAFMOYt/IGfoRHF5nvQBend799pkznNs9jyahMpNHSaLdYeS/5GCwENFzqJWZz4d06MlZBFEzQcjzGyhs8NgxxiU+t8UIYdsfYidrae6noVUdIgxAGZnC+TDW/ma/9obbZC9hVMj4wC6xvART5r3COsdND0+Gj3imKyTnHSo58oMYH4ft5RaixZR/1c3JBDQzb61Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEZPR06MB6351.apcprd06.prod.outlook.com (2603:1096:101:12a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Mon, 8 Jul
 2024 09:04:22 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 09:04:21 +0000
From: Zhiguo Jiang <justinjiang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Barry Song <baohua@kernel.org>
Cc: opensource.kernel@vivo.com,
	Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH v5] mm: shrink skip folio mapped by an exiting process
Date: Mon,  8 Jul 2024 17:04:13 +0800
Message-ID: <20240708090413.888-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEZPR06MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: f16cf014-3722-4499-9da9-08dc9f2cf4fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/sx6VXF81CeQKRS1+MFX4KvlKDZsBoIUAYUQKj9p9x6nsIqA75iuA3rYbg47?=
 =?us-ascii?Q?+zSncVze88Gb+AHQz5/73RkKg/RuK0CaYDWAGqzT4gvcDL9CPLDq5ip927kV?=
 =?us-ascii?Q?kG/sLVeKs74mtt4oVWv5yMU+k1QUpzHMz9aPMiEP35IvmKI3/GSc86XZ2cUR?=
 =?us-ascii?Q?cn6CVsRw0qPMcCFvS/V3f8KtvpoPY3glsizRG1k30AA2iEffTAJvC2h/U8lh?=
 =?us-ascii?Q?BqCYtofZlcLJQU35+dBPDYJlPEvnMQnzCSgPB1ttd7q9WYi15MQAWwjMh+wf?=
 =?us-ascii?Q?GXd+RbFeNOh9JaGVZIhL44oghU7xao7gIfhsArJc+T//nxQXHtQnZoyBuI/n?=
 =?us-ascii?Q?eKGIzuD3D6Mws8maIb2bd0olV9/cFhsf+EDZZjngmQz2I73Lzy42fMEG0MRA?=
 =?us-ascii?Q?7vy4vswkEo5NSrrEiK83/WPyOfxTJbT5lD0AUY5gFF7v9lz7OGL79pX6i9xm?=
 =?us-ascii?Q?GUAOeRCV0brbdpsngw+BBCI4AH52AbHDbggMhA+qADjtZ7J3aUgwWLUyStn1?=
 =?us-ascii?Q?1UcmlPNG8WnkyBTVSfsPrT36UNc5QWqtk3nCqsQER3t00fIa8FDNp4vd0r9k?=
 =?us-ascii?Q?DaVndn2fQeKuUmApEhSVMJefYBHCcTSX+9dr/iPOWZAZdPNYjWyjuK5TubCe?=
 =?us-ascii?Q?Eham/7sqDB7Ga0Y4t9/1b5WJDeZvC12yPgRheBJCgKhajoDJxnR2tg6eLX07?=
 =?us-ascii?Q?WUlP15RUktvRQ330eZMjx6HoT8KTs4IHo6TcARgAIOgN6yyJ08kej6zolPzw?=
 =?us-ascii?Q?cZtpeP6GrxpS5C21hPBb7sfz5TeBOeIUS4y0VC6dsLiUITozyV7QL5KN+vjA?=
 =?us-ascii?Q?a9Tu0NDMUZ5hnpyTHuLYl2ewZIVGjctAJDHo7kKfjv6q9aPYc48pMZVZwbyc?=
 =?us-ascii?Q?GDfoyyu5hVjX+W6j6N8wZA/l/s50nAPHtjnUzp+ukeggOMo6587HE+kNZH2o?=
 =?us-ascii?Q?X4QN9HotdMEcphl5/aDsyQmqg7elDxw4+hIQJ/GBSgDakEpJ3eTuwXnN8S8s?=
 =?us-ascii?Q?o53oAqlC8UKU23x3EzjEOdyfCiaATfpGp+ASHjDMviN1aoSm7cVjTXN/423n?=
 =?us-ascii?Q?osWnEIC7nlMQUVUbba8yCZtC6h/bXQ3M1Sxg5ug9dUPUkscU8j9BRpj2SDTA?=
 =?us-ascii?Q?4xkBYWViJ4MVRzK8+0T/cu47wwVQD5k0Z5LLYa4GxcB02OASBZ/YkqW9EtDV?=
 =?us-ascii?Q?A2TPlvMnV4uwj0Abo3bwsGr9Z4cyVoupZ+hsqb0jZerAXHjmlShHlQGc/z21?=
 =?us-ascii?Q?XsnlXlClXE5yLI8Cj7Bq4V3DnCrl/OlqcqiAtkZSfsfEZQk/1JEtxfVMZ6s2?=
 =?us-ascii?Q?5DefPLDhC11BMA2hLEmRj8XOX7h/vNHRyQy4vMZqKg91gmm61K0olXfuKb4E?=
 =?us-ascii?Q?HBwbUVNItJvX4HMTbDcXxTDdM34kp4RsCdB8lno7Z/CxwVgjWg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L0PxWDqNiGVzvw6QnzSNHRSj0rC2iu157N3X/RwZmZcHYZ363szMwYT9Nr6C?=
 =?us-ascii?Q?R6srQPj2BVYMSw9JlgYirk/WOK7aVyPYy8Nv+Zw9IY2dLGSGdbQqR9e7Ugeg?=
 =?us-ascii?Q?LZp2LvEV6rKlccaJ/tnhbM1Hh5BRp0B+qN7LTmncZ3V94mAMEE6YbkFz3rlt?=
 =?us-ascii?Q?TKcSICmrWssAHwbOMEBZGa/W/0jlgs8lxrtY7PSLcDrWwmz67LzaM8pTzof7?=
 =?us-ascii?Q?0gq9pzdLYQW9SZXFwIeXzntoP/eIeuY3PaHcHlK5Qj8UfGnigZ+If0Ge32+p?=
 =?us-ascii?Q?QgGwPVyrLUzBb6/OyfQEpk2yJx8GdFKSWRZrY+usOJ8vqCXDTrGy66Kqd+wh?=
 =?us-ascii?Q?JjGblK0QTBq5cKc2zzj2kh+0gj3+vSeW8WxqA/kC5OVOWWfrhu94ZzE813R9?=
 =?us-ascii?Q?jqXgRnzFHZIsUDVzAoFenHHr4Zdlpi/VhGa3CtQyRFUUy6nW1w/H/HZ1egbk?=
 =?us-ascii?Q?SK7nDg3MJyWmUmwBF8aT10Roq3OnqtdH7tJ3psENnClll6YBSXB5maOEGwFN?=
 =?us-ascii?Q?lu4shgb5EReJbhKqtDvY/+num4TXitY8V3y1vc3ZfRLi9Ld6SJsDXObjiEHy?=
 =?us-ascii?Q?K6jaVbRmYwyXA+gmk8TRE4Nswy/jspT7IC+gLpxX0XG6HjcftzT9iflLJf0I?=
 =?us-ascii?Q?uD8C1puRvyO9rpabmUHUxnrXUQ+NsJwaHIXWSrolq+B20W6X8QfEQoPSTlIs?=
 =?us-ascii?Q?wVwoOwtZdIJFvKYp91FTz6ymbMZw/ogu1PwMmsOkSsmebKNpNRqLGDn7QMHk?=
 =?us-ascii?Q?rsCrNbx/xrMkxfJEXYKG9ts3l7oYXPyE1LB1nnVk6Gvhoscl66c0/q+0SqII?=
 =?us-ascii?Q?FGSNjCHiDbK8Fn0uQJVTlXczuebcItzxZQf0HRhig6zeQP0C6DEa7PtdwfyX?=
 =?us-ascii?Q?9kJNedmjowN8QPv+DV2GlH/ajQ8iwXXV1oSqjmU+R3TxSbYdpuLxZnxBGNqZ?=
 =?us-ascii?Q?v1lWrWLjVDopltpuJ+qaSkTuQ0dWG9+Q0DpWlxf+FzCTbAl+4DX5bkalrFYk?=
 =?us-ascii?Q?eWgWJos8A2JZJAcqMS0u4oSybkadMBwV7ZQxsUc1rwRX5Y6oHeGO3BK21LkI?=
 =?us-ascii?Q?lZK1Jrw8IrkjKjIeK3PMdKptnf59KY5cJe0KOSrfi6ztNnTvQUoixJqS7Rlx?=
 =?us-ascii?Q?nz0J4DwkECueUcOB64Y6ANOw3vDqKGXTQcE1er7yVfmCjoqcFPPlmjhUJhhO?=
 =?us-ascii?Q?0dyjNb1WhJCMjTaAlVdvWWKrwMsxJCibojCVKZksUrxkX5s5VcJjeT9T0k/t?=
 =?us-ascii?Q?bz5nAEJP7yHrVIWnB9km0JNc0+llgR/VEEdJgAJmdRUJeIR5ducsSNzvewfg?=
 =?us-ascii?Q?tStG2fmuNGDEytvq2LEPIiBFHMpgblRS8QrsRk/lFbFVc2A7ib8JLsAH6YXR?=
 =?us-ascii?Q?WVVkXP4wiEaHzx/fAmGCwi6ckU6GrSkH8SJc3FRnEnIRx0c0PKdKNbeIJx7H?=
 =?us-ascii?Q?/TqP/+637KuT/vYN8go8MOWdLCWUOdbE8kQLj8Lwz4FNDmi7RCxNp7FxSjcu?=
 =?us-ascii?Q?hpTP8aV8RUWQACgYrj/uIBHnaySYrfz3ZIrrglm+sbGbgUUE7WmLEYOcwuH3?=
 =?us-ascii?Q?8F5eOdtjvMObF0brCQH8mWfHoHWYsN8Bii708pfb?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16cf014-3722-4499-9da9-08dc9f2cf4fa
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 09:04:21.8419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XESp0ze6tts9aDg3onU/mGNVv0zN+MFmuSsjVBB24S+BTFLDHqH3OhCn8TNYKOJeTZ3JaDdbco804aRVruBWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6351

The releasing process of the non-shared anonymous folio mapped solely by
an exiting process may go through two flows: 1) the anonymous folio is
firstly is swaped-out into swapspace and transformed into a swp_entry
in shrink_folio_list; 2) then the swp_entry is released in the process
exiting flow. This will increase the cpu load of releasing a non-shared
anonymous folio mapped solely by an exiting process, because the folio
go through swap-out and the releasing the swapspace and swp_entry.

When system is low memory, it is more likely to occur, because more
backend applidatuions will be killed.

The modification is that shrink skips the non-shared anonymous folio
solely mapped by an exting process and the folio is only released
directly in the process exiting flow, which will save swap-out time
and alleviate the load of the process exiting. 

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---

Change log:
v4->v5:
1.Modify to skip non-shared anonymous folio only.
2.Update comments for pra->referenced = -1.
v3->v4:
1.Modify that the unshared folios mapped only in exiting task are skip.
v2->v3:
Nothing.
v1->v2:
1.The VM_EXITING added in v1 patch is removed, because it will fail
to compile in 32-bit system.

 mm/rmap.c   | 13 +++++++++++++
 mm/vmscan.c |  7 ++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 26806b49a86f..5b5281d71dbb
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -843,6 +843,19 @@ static bool folio_referenced_one(struct folio *folio,
 	int referenced = 0;
 	unsigned long start = address, ptes = 0;
 
+	/*
+	 * Skip the non-shared anonymous folio mapped solely by
+	 * the single exiting process, and release it directly
+	 * in the process exiting.
+	 */
+	if ((!atomic_read(&vma->vm_mm->mm_users) ||
+		test_bit(MMF_OOM_SKIP, &vma->vm_mm->flags)) &&
+		folio_test_anon(folio) && folio_test_swapbacked(folio) &&
+		!folio_likely_mapped_shared(folio)) {
+		pra->referenced = -1;
+		return false;
+	}
+
 	while (page_vma_mapped_walk(&pvmw)) {
 		address = pvmw.address;
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0761f91b407f..bae7a8bf6b3d
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -863,7 +863,12 @@ static enum folio_references folio_check_references(struct folio *folio,
 	if (vm_flags & VM_LOCKED)
 		return FOLIOREF_ACTIVATE;
 
-	/* rmap lock contention: rotate */
+	/*
+	 * There are two cases to consider.
+	 * 1) Rmap lock contention: rotate.
+	 * 2) Skip the non-shared anonymous folio mapped solely by
+	 *    the single exiting process.
+	 */
 	if (referenced_ptes == -1)
 		return FOLIOREF_KEEP;
 
-- 
2.39.0


