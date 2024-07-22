Return-Path: <linux-kernel+bounces-259264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 925A0939335
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B56C31C21550
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1E916F262;
	Mon, 22 Jul 2024 17:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="byzqGfah"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0FD16F0C4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721669373; cv=fail; b=vD7IxDWyC3XbNlT12FeifC2YUF9Glyhds/nPQmbGS1Fp3wZC3Zy5Vz6lOPJqjh4HbHmIJlrfrQSgqGcFEtfxbMGd1kIwlO21gO7bQPdo0cGCBUC517d+Lr5+T4uSDdYuSqVTluLHMV+ILxVbnrC4HEcCVowUm/Y31mECN8je+Oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721669373; c=relaxed/simple;
	bh=BzHyOG1OYj1hpUBV9XNP/vmivsLjmxvdulSxKBi1Chc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o5cI2qSeQwHFZNzOK/miev9afhfdtoqXbDANIXq7fs+95IejSW8MnC7uwFabhFrjDd4MMlHdEuByMc/TtxNBebkbbSKWEF5kfdPfxHRwLa4pOOQQOZJjvw9UYbzWPZidYSetJH2hic9MY3VRxyzeX26dfo+uwGFSL0RljBWPGFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=byzqGfah; arc=fail smtp.client-ip=40.107.102.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMKZoxxs2UmzmJa93plXr5tBFLdQm0oa7IN87ivdkMUrFD6zR5Cs+K7rANtAZvX6ehFWtKWCkBg/on+rD2wGk9LSEV0rJP8niNxGnaWNGH2oo1r0Z3vTKcLAaZfX2ytd99Qoa0+HXK3D4oNGPdqeFr12B8MtaFHTiB3hoqyQMgZugb0oLc8VhlbdwN+7DThwanVZjVMWG5X9Bh3+g7z/ecbgIMAqvtmyabo96vDCX6esNfpPvLVwuZJ9Iu8Pi9sVfSdKmwkFdaaRYGxtnLQbOV79nFW5opx9XIIbyZj9hJDBT9qmma+LgWnUB6il7NDbSFXJj1/BlyZtnuv8YxmGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abeVhQpv8bi5AHWi4oC4YqHkrMU7IYRkJWoM71dK2iw=;
 b=bg/yKSx61a34F769A3Afxu1fID3xGFULncLzoS159XNfsg9CUcEiOEfpEKzgvNDGGE5Olf2wzD5ZqlRHFp4HwyEsAjqqgOmRXH5EFhSERuXJzgtnaiFOfEFzr0rT4SZH1mIbudN22qgI3aMkg1P/uYvM7vijOKKIbeaUn6cO2bzac+EzQrvOK6oYEoElqMzgNcnT6BALAEYkIjw+xDNvoZjgdOkuOcGnLKwv8nfYb6MehpR5s2vJcJugLvclfga9Ic4c/jWab4oXRQnd8/a0WHEfL9OSClDzqvBY0dYBme3tUVaUqDV6BCQnXJzzTUk9n3v1JMbzkEZgh3uc8r2Tmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abeVhQpv8bi5AHWi4oC4YqHkrMU7IYRkJWoM71dK2iw=;
 b=byzqGfahkj5ucKceEntuVWOzlETRgUhaK7s8NEoyPQddLeRlS+uD/Jcluf6emmXx7RSDlh9EYEbNgymSD0wXyLUt8qEoyqfJIt53FgsAI6K9vDJa+Pl99IkQzfL4mrnr47u3WzTGOZpjQlRYPtMnCgvwaudpgMjGXFxApIKtoRnUvrRp58eprjQLYBa0Dcr2T+jVZBSYSMrqUHpIKLGsL/cARH4f7OOKMaWMbAYmSkDwk7PYOSZ4wB53tqbWbIjIMBXz2JAse3GhbIA8pDz/kaza2qaCjRd6Z6/Ej7oBOIOSaqLnO81bGVnF9sUa8/yS/F9LE8sBI10M8QNChl0wLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ2PR12MB7944.namprd12.prod.outlook.com (2603:10b6:a03:4c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Mon, 22 Jul
 2024 17:29:27 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7784.013; Mon, 22 Jul 2024
 17:29:26 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v2 3/3] memory tiering: count PGPROMOTE_SUCCESS when mem tiering is enabled.
Date: Mon, 22 Jul 2024 13:29:17 -0400
Message-ID: <20240722172917.503370-3-ziy@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240722172917.503370-1-ziy@nvidia.com>
References: <20240722172917.503370-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:208:329::9) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ2PR12MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: fe09ea3b-d43f-447f-4757-08dcaa73d598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gI+yc9wiB7dIsN4/nuMz840TS6L/bx9ws2gfrKckFKMJPnAlDSn085UmE2/X?=
 =?us-ascii?Q?YtZNdzDlz/oPRQhUzglEOtj2ePK5CvF+L/Lzr/JGEdkVagNI3V/Ft79xQ0iW?=
 =?us-ascii?Q?8VfjyKZnzv5gczvVjx7zncKcv6D1MzwTmmJnMgQ1sCUfPyTTOmqD4V0sRtjb?=
 =?us-ascii?Q?uIOdjwFTJRUp/EzjEepqHR0zkD8warGpQVHHMMwrU6t/Aq5g95QOKcHmkURI?=
 =?us-ascii?Q?rQqqH9vklN1LlENtjMeiC+dLq9mQ1/3h3D2UfbucgoJZDuxto4gxEdEq31pa?=
 =?us-ascii?Q?YgNX0IAeH2/iYZOaFZsvD3fuZdiA50WDZ4pT6gQkZHvrJ+U2QwX5r2KAvlx4?=
 =?us-ascii?Q?ZNRM/d2LxBitCGMDYjymmp6eO8vjjk2hMipR/+/jLPAaY9P75zQeUya0HZS8?=
 =?us-ascii?Q?7HHARrfKdrW13MIwoulMO6+uvCbOBrcK5d1efelZPAyZokT4GHvzb+x8Hl8Z?=
 =?us-ascii?Q?/XZqS3yDtbIWeR/H8PFY9Zi3KYOsqQsDxLhFrzhxvOWgE65vWz0h6+zKEQjx?=
 =?us-ascii?Q?XIdSzLUIy4bzv0IKYyLjFdVNT6P7wcggmbsKNaS9YkKT89FCfdC7diMJW44m?=
 =?us-ascii?Q?4W1CQ0F1mOwEGpTHEH4ONP+kP0Yk9G8huwtmTxIS0dU3DN4PCTOS2W/8aZ1E?=
 =?us-ascii?Q?G+Zutay1/m9FZw1o7DlWcKBiEfJXkrNuy37+D8VcVyvQPPzjD4nWEMLNMctI?=
 =?us-ascii?Q?MRxyceO1cYHRQ5LpudwwjPNcdgoV8mqiqrRdrS5rWzToxHgGmASsf+w+DHiv?=
 =?us-ascii?Q?k8gw23E8GkOA2aVvYFJGnJ7BLQTBPlg6yU20m7CGgqSp2GzCzNJ5zcy6iSaC?=
 =?us-ascii?Q?nS1gtsB3n+5f85zLi7V26cThTEOflOhsTBE1VjRBTsJSm/1sjXtpQ+TI4gPg?=
 =?us-ascii?Q?ciEXhf5iLC+aSBCsSdkyRcOcCE5fykgaxKA8uPADypInSOkuE/ShMn2GctOS?=
 =?us-ascii?Q?dokubL/TK+T6aQvtRrAQ/5OMlL4v3QuZtxdUB6XzzFvkvope4BiOrp94wlQu?=
 =?us-ascii?Q?IOD4hUvSTrTWvysiAxzy+qSj0IYLPavE70++VHSuPob61fJS5pgCwdhqgtg5?=
 =?us-ascii?Q?GbfGtk4Khcbc6hTO/Jq34zKz8A+LhOGbd359/mE5vYv6xshEXeb4hhIdgX1J?=
 =?us-ascii?Q?WywMRBFxERm4GSP6svcKkg7uaoeZdoJkicj/h+BnG14Oi/t1A+ZgRAm91pOF?=
 =?us-ascii?Q?r+iH1tHWYBhXGUr1OCf7PiDDKHaZgIljpax/rKvWE3jkUBLbep8Hcr8t9V8g?=
 =?us-ascii?Q?hAKqpMRb8wn5eSKwvuPnnodBInzgZdb2Kgg/0/3hF5wWq/6n6S+CJhoHD2oW?=
 =?us-ascii?Q?YkYWKzASargS1HUBubABrt51ZA4F6pMLnsAXRh/ZW9hSTUqhnNNVWHq2GXob?=
 =?us-ascii?Q?W7u8pl8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pZ7HZ8Xi++lCd+ZMkvDThWzUVzdKzDGPtIvo2/eNWKN7arqG7GRLMiW7vSQF?=
 =?us-ascii?Q?qio9ckKJoxSWjDaj6mQxhelUmNHDggiAKWkVcwCcViP1QdWr2Ojcop/O0kEz?=
 =?us-ascii?Q?uYWdQbEcE8senDrUCpJflSF5rqKswSqtF6V1puVCZTphsF/CygSUZJi63DN9?=
 =?us-ascii?Q?qvy6WWeVaJAllPosYikfras/z2mXTM6jWRJFRrYgAH9lYESwnVs+B41O7rz8?=
 =?us-ascii?Q?EK7FXVgKpvCvUbSGqcOP9HHkT6c5+C+KytgxXNa6IdIF2ZUePlj0FmjTiYDZ?=
 =?us-ascii?Q?h7iE6jTXFj1/K27NsP6FXU4Mf/XbPniwFHTh1YHV+NOgqWaQYQupeX1l3z9Y?=
 =?us-ascii?Q?berrS/Ho/dkoIyzkLL/R8VFrBp0SEUw9V+i7ZmHBKmQWDIBRPet1dpgM2U/h?=
 =?us-ascii?Q?32sAPraCmWNHtK99OAsgTxfFEveBYGySj00n6mR980j07xBPrjZDXk6Zdk6k?=
 =?us-ascii?Q?nHR+M5gsyHt6UqvZ4sN08lfcMl4iiaiOi+sHqkOzisYuc29zE4DbXWd+1lrv?=
 =?us-ascii?Q?om12OJ2uCSGWavPlaS10vfSLmwHDNtrrcjy/pvyY3FzRy3BVkW2VJvju01AX?=
 =?us-ascii?Q?N6I+V+oM1Y+TjwjeG2pJ7S7ABXhNGjy9KMuShDIjE3qRPE15WizWXomQBsVl?=
 =?us-ascii?Q?sIsFnWnTr9jlaZU88kbZqvYMG3BKWKTfYNnqedXNorXUw82wztbf9OG61EsO?=
 =?us-ascii?Q?vwSp/IyP80NBxdHlrTeFkUMrmwANcdMJoR9fCEhHEDvGZnaTOyTgVhU9SGuS?=
 =?us-ascii?Q?Kc1dDq8Vi9meDUBwZb5lXVtAFPji/3TBfbosUy2rvSrzp9AR4gziSHyuuu16?=
 =?us-ascii?Q?d2r6W0nexqzD0N7J1PnCCc4VcAqnmyxhUYs7pGgZlh5KQPa0lss5e54O1k4o?=
 =?us-ascii?Q?Ms9g35JiO+7OmhK+zwWqU6YJ4AvpGQfSuofsCG92OJV2qsX7CATtLYnTR9ZF?=
 =?us-ascii?Q?1zVV3MHiVt9jcEuAsYLcKrqcOQ1Ntw6Ew08DSwIT/Lcq1KF1dBzTmb54QcU9?=
 =?us-ascii?Q?aZMpXctfdtA2a0Id1HOZw29nQAt6ZFgW2YnBCr1T6YmaR7Fla28q2wVAuhHx?=
 =?us-ascii?Q?AGDNKjc4XyfGxCAXsnmqrcA8qNzCHWbTAfVA9J6P3fFJatM6lIhF/DfkDXns?=
 =?us-ascii?Q?6+o41OyFRPtluL3f7BeiBNRDBkEDPmWPVkFU73FTc27AUO0bVeJilb3F2EH7?=
 =?us-ascii?Q?1v7KAeWsOmBDj8WBSGxxwAPAAfBNVWExTuMFB6Dc36KLkUKkrK9YO6MOhaGD?=
 =?us-ascii?Q?AGfVaxCQgzd9oIjzE5WNgNi7oegajxusZsRjqjV1G1I0P+8+5SZUuP1OkePa?=
 =?us-ascii?Q?zrzfRweJxU+KsLUXdoq5NFDAedcorT2Mv0qLtAx5EOz9tliD8Dr1fekiV251?=
 =?us-ascii?Q?J9XJTPnYm0UKkdCpX5njahtxLPI7v7m9ulQlbRPwmE6xWCqr2gB4QWJMUf6E?=
 =?us-ascii?Q?W0RvN51P5ZzFEtJuj8xPqwma52H1AxP4/71bS+7yIYA7i7PAFJagua1q4B46?=
 =?us-ascii?Q?Ka0M+UpN/MhLkT01qBXl6e9NHCVrrVmVWVcB2mQ52nEE9nllGybNxwoEAoW/?=
 =?us-ascii?Q?WBsfODPAsT0ksFFN4rw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe09ea3b-d43f-447f-4757-08dcaa73d598
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 17:29:26.2515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKquAQ8tIuZ7Q4OejS+hs7g68br9fL/R+ErAR1n3SJub9FOFb43xF8OW1csG0xd5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7944

memory tiering can be enabled/disabled at runtime and
sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING is used to check
it. In migrate_misplaced_folio(), the check is missing when
PGPROMOTE_SUCCESS is incremented. Add the missing check.

Reported-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Closes: https://lore.kernel.org/linux-mm/f4ae2c9c-fe40-4807-bdb2-64cf2d716c1a@huawei.com/
Fixes: 33024536bafd ("memory tiering: hot page selection with hint page fault latency")
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/migrate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index bdbb5bb04c91..b819809da470 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2630,7 +2630,9 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
 		putback_movable_pages(&migratepages);
 	if (nr_succeeded) {
 		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
-		if (!node_is_toptier(folio_nid(folio)) && node_is_toptier(node))
+		if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
+		    && !node_is_toptier(folio_nid(folio))
+		    && node_is_toptier(node))
 			mod_node_page_state(pgdat, PGPROMOTE_SUCCESS,
 					    nr_succeeded);
 	}
-- 
2.43.0


