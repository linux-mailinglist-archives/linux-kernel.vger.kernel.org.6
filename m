Return-Path: <linux-kernel+bounces-432425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BCC9E4B08
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D69B2815B6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E05A3B7A8;
	Thu,  5 Dec 2024 00:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="auf8t8LU"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C7B1401C
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 00:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733357938; cv=fail; b=XkxBbwE5f21lh3aIYFFT/dYRoVHO/C+V2dC0D/yeO3p7SaE2RPP6Zw4y0+LvB9Ai2dJ68d3QFv4a8/XWaLVS//mb55XJpCIRLL0Qp0o3INOpX1y3ZB2FGskisr7/kyWVKwckJJqkVgqvaN1/oVbgMKKudOftE5yuI2NPSc/i3Gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733357938; c=relaxed/simple;
	bh=nyA+sit1uaf1C1ImgvuyD6F2UCk1m3Taa+FgFfi+gY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mNneSyADZ3qPkIGNU7S6VvoiEll3cAtspAYBdzutI3AP98LaJHrgtgI5gbumzAXG9PpOZV6SglFa9n7yYB4GbGwQ2sFgajfHgIer6mBmen/i1OHgBvhZTGXT5Rks0n3W0Bh0Id6sYuQ3uvpK1SG1ld+3AR11vmOMu3/T68Cc3vY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=auf8t8LU; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGB1RlvVMzCZ2ldmwBlA6ppFKr1jriFEYnQDhV9GrZxr91eE0cNQDScWaxlzIfJ9FrotUnIeMVeOh5tmObXpGBQHC9F9pGFJf3j3ms5dxf63gNpLyVBl3D7tYDjJyXqc2gQCtNugM9DH9JPyHKJiNDis4mYsm1vJiqbdUxLg2MMOrNrt3gcuiFEpHQXlN2PWeEogqzzu4My+f3ldO+K86wr2LgG2zo/a7CKJXxOKRdrIsFpwkjzRUYAOR1mV9KwZDmDUECLaOstqyKaybsOaAXQfv2D0rn8mOXn8APRekefK6Rv46WiTLVJzereAJcJawTtN/dzUyQMzVkGPF60hMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJYcxHpUZ2kDcL+Ml+XnRav8rWac6pv0uhEIokdawrs=;
 b=BE6wxrjxTOKpt3izZZMgPwEaHrpjFVwrfvry7ef1mBoDFQYpE7Nh0sx1bJdjdVjnfzBaKC6aFKoonQgOgPZCeWCNhNOVYvS9x784H1BjZe3gEecLwQ/eCGK8p2+iSpE5w72LcNqhs32DC7DhAlzys/jqCgfVcPUGz1ldafQDbIngPt1lXGI07KI8mNh6GScUekBFCbGx9cyWi374ZGWezg/WjvtGlWmM5I6mjeWfe7MfX3Nu6FK3RPyt69s5cHUvxegOH60vd2MfCQ9zX/tbjfpSvDuHtn54E5tZb+LpMb5vACCiYy6m21BNpsWk4tFJhV1XPKFDVDn/tMowrUT/SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJYcxHpUZ2kDcL+Ml+XnRav8rWac6pv0uhEIokdawrs=;
 b=auf8t8LUzkLq6G2xb9M0VquuXfaVJx54weuYwDO1cVmy1JadxN2Diao2TIXHUskIckOyObnfD2FFREj1DrydVtzPzOwIgCzqrY/KyHdJXp1VOtRzEwYXEkwRJYOQjGRUeo6d1W0nmRsmRXPXa2ljV7WypoExa2kcph1yLIFCPaCl/6XX4/FLzq12zTTCZyC6jWEzOc5xuThi6n06dIew/+EFnJcDjj4f1ex7Og/ghwm9rklJPEOlshbooPERozMtbKJ4qHTyh1cLwY9j8G8kp/Uj5O93Mt3Rp1q4cwU/1z0b43CVbJNn3NANZkqgpT3PBuOBOUGQJorsPh/8+IcbIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by IA1PR12MB7589.namprd12.prod.outlook.com (2603:10b6:208:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 00:18:48 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%6]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 00:18:48 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yu Zhao <yuzhao@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RESEND v3 4/9] mm/huge_memory: remove the old, unused __split_huge_page()
Date: Wed,  4 Dec 2024 19:18:34 -0500
Message-ID: <20241205001839.2582020-5-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241205001839.2582020-1-ziy@nvidia.com>
References: <20241205001839.2582020-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0090.namprd04.prod.outlook.com
 (2603:10b6:408:ea::35) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|IA1PR12MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: 60bc5f44-aa45-4352-1102-08dd14c26360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w4r1cMEiYkc7KtL22I6MAdHot6xMep07BHeARTD/GpqKlrGNH67CjeOxHKuH?=
 =?us-ascii?Q?Q4iFTgzO544lG3ZskwSttAitR9CBayf5B6MacBypO7nO7Gru/w+Z8krz3qVU?=
 =?us-ascii?Q?7lkQx6z7Jy8EmEEVyMZGDIW7c0g0moaBIRCfKX3qsXLf2cnTZf93utXbDQeI?=
 =?us-ascii?Q?Lb2KArQBTR3LC8nclejyu1tdlf+hvz+k+LlXJTYLQtn94U+Qm1us7wTe7XIP?=
 =?us-ascii?Q?E/TRv/bFAC+tGB1CIJ8Rkxc416rKW89s4FpzllHgjlyNNBrKM2lBZVt1r7sr?=
 =?us-ascii?Q?/i0i9uHVy+5YTWYMdgtv9iqvdYmiRHkkRS9JHzUpFhet5eB0IcRcsWij8K05?=
 =?us-ascii?Q?p/tykF+qY7ooFMQuOseCtg/kBCEKi0vz2YJ7MKlWd7i2m/47Adn5CNrhrygz?=
 =?us-ascii?Q?c05wkTeuxTb/ofZyTrf10qeViCaIObdZpfrQekuiYXUB5WPzLvHT5g/XngdO?=
 =?us-ascii?Q?f+bBSGBj0DJGnloh66WRvoD+jsQFSmDOGE8OTX2jr3yB3bsvJUNsZugtE+2b?=
 =?us-ascii?Q?gjMXkHI/yQqx7/xceNH4HiLXUtDMKmhIHtQLo0ykco7VfU/KHnZf6Io/hDNE?=
 =?us-ascii?Q?+DuRC6dhSem65G4NkOOpI1wAgTwvnJwiJp7SknluEGsan/H70c4HbKp8mr2U?=
 =?us-ascii?Q?Ctp6o+wQziHSV/UWUx+PgQSgqdXzssGr1S0W3WqmGqr0RGfWZRavsvkjNzkr?=
 =?us-ascii?Q?+wh4Ec2PnnmaZI7KvGtjrS0fkrdwInoOGPPIPTWnb1Xpvr5bopjOMZ6ZHzA+?=
 =?us-ascii?Q?DY6vHDCDfqER9SfgmxIzmMFWhtaG2oh0r3TLoGDoQfKyZxoUsv+BfNhgqiQV?=
 =?us-ascii?Q?tAcEVl5IFWpm/9BofRMVDWm5a3vrWS6ga1y7ROCLiriC2zyQcf06cCwzJDhK?=
 =?us-ascii?Q?oU4d948qO0wtC9WcBI6Txuo46lqIzqkp6p2qKFPEzVedy/WoEG+53vJPA+JM?=
 =?us-ascii?Q?2n2Y02Xy7leaXpS7xERqrKVUEkRxvS19eisOiOvxXad1vUUMi7mniUXubJyW?=
 =?us-ascii?Q?tvgnLdrXVuS3wrDBwCd3FW7be6AQeukgayVMY+aOa3JztmwlQT4uNRj935Pw?=
 =?us-ascii?Q?egBhQJxxjYxI+/TucdEjlVdJXFgV4QlWgGGOqkcavBJfRHqB/0V0NXszEp4N?=
 =?us-ascii?Q?g3VcFr3JxKNB9px5sThSPcis0Bz/bZwtvmXr2sDEaHB9Xl/xXYE3vSit1QzW?=
 =?us-ascii?Q?HqRhVvDFdJ1T4r6lqr2J94WnW5p6V0FApelvBfg7Cdg0NMNeZ/6mPGuz0Dvw?=
 =?us-ascii?Q?iXaO2d4ugrX92WsTujKjqGk5lGqTRMlo+wi9KD7zpUUlGOIRpv2pODx2EXbt?=
 =?us-ascii?Q?i90JlyfzXIJ/7QKOMQtX9T+me0fzi0xDtkkAA52edt2mMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OjMZ6QtTP9yPFh8vszEpVjq9hneW5+dI1jHhK87njnmAIeUKNCX1QIkGh+lx?=
 =?us-ascii?Q?ZrXaK7Tr5iAvPnGxi6FMXBNjbyPGcKI6923UglDx6192ulwL9y4DZfClhSh1?=
 =?us-ascii?Q?S07PXmuZHfwo9AjO9XhpEXskoEjg1LXYXM/n/FujCVDe7GZRFa9jIw0M2ACP?=
 =?us-ascii?Q?1bt1B+ShjwKlyvNWnyahWvm8AIJcMHlat+WFRMb5Y6XaX62AnKbnki7foHNk?=
 =?us-ascii?Q?UoWnFBOuhtEmJwc3nKZGXMm9Xlwp8Gu8XZ0WwiuMUzaTQr0ld/fLIhmvCojR?=
 =?us-ascii?Q?JARkXckiyJWRU+VA5CzQl6dxl2xYSfKu0b1tL7WPUpXfhrHuxsmHM9JCftr9?=
 =?us-ascii?Q?Ak7chLbiAtujbgyzNAEUFK3iXRQow2o4batthdtAkKZU+whvLi1Pjy81+Jk8?=
 =?us-ascii?Q?Ehd2mS/yTOvwUf3ULQGFJhxMHCSt2cXCHpUmxbR7K3xGTdlQtqqYlJUzj5hT?=
 =?us-ascii?Q?bPv7c/LHF7EB9quQa6U3Hr2pZTm2EsEKZVeU7P+jZfz52x6EVx2zEQpU5qQe?=
 =?us-ascii?Q?Dzb49k+oUyB0+E5/1FBX79szMQ6/rWOfXM7kJP9K97mbuq+BYABPUPii1kzp?=
 =?us-ascii?Q?8g2ErIUwDvYEX0Nmdra1ywe8pG1LeOQLcG2KFn+yCCpqfSu00evGZcBRK1+U?=
 =?us-ascii?Q?qGfkWSRSdShgEab+WMKao21P93qrR84GdyE7G5H3LuVJQpfoValmpGQ+ZL8D?=
 =?us-ascii?Q?Jzel0f31vSqYgAWDzwLu5bQJXYtpYcI5ymRr5zWmmz5sRTlyWVBVi+KYPpi8?=
 =?us-ascii?Q?wWUAaykxJfKEpT8cLeejpR2L7dtlAomJ1PWPnx6J26JEXrW04gD9Xqmk3+ol?=
 =?us-ascii?Q?RRnvx9+/ig4rmCJ3Jl4UPRowrJLWy7t+WXk6dXDM8G0neYRLBnBLKxmQ00+c?=
 =?us-ascii?Q?yKuPBXhs5cUVC8DM3msog1GfNQs9V2ZhiVxnsmxbGS1RNiwSPMdEmLeu6KXq?=
 =?us-ascii?Q?R9q0aBPWyfmNCZX+S2Tj8553ehroDFBq9/obo5ItZhSsYOg+lJOXDDA7ZqWb?=
 =?us-ascii?Q?dHLBeOEHUoeWqdZLocEQAndTwYVwEdUKlMxYCL9FtUs9315m4mzS0vhSmTPv?=
 =?us-ascii?Q?NJAG0CRVf1xzZmAGTwU51T5zFzNxNnAmnuOhxsC0/cEaoLdcz4cCLCOu52YR?=
 =?us-ascii?Q?fCdFp3o7ZTKN/ZYg0+BrEYNFjIBmzSBRraJ3K+nZhmL3pqvBsMs4G5ns7iQU?=
 =?us-ascii?Q?NMmUn1KU+eoZbL+aj1Su/vJ1OMxq7O3d3WR/TvuTUABcfE7hbSivK+115wY4?=
 =?us-ascii?Q?tITTi3cVnr4j6eGUO+EwsoJe5octTh1CMFgNl7F6gTf7wAA9UcZQie24Syqs?=
 =?us-ascii?Q?OhDNf21lVAf3GKtyPElQzkFgocMyi3/2pFXDUkKoCz4QOhK77mwRmrISdPlq?=
 =?us-ascii?Q?Q2TDt3m1TDBa/++KtmIepBtZGvPckGdGZjaC5Uwpyz65FhcWiqqddUPmWSNG?=
 =?us-ascii?Q?5CmgaULqtuC4gZA20UAI29RmtvYfXVlh2ahdt9Hb77iVKxW8E4uFbTJNcF8Y?=
 =?us-ascii?Q?hghqrASvAfVujR/hezsRJ3LVokWdqzTdSm8nQTYwCqiPIpQR4tSzxBejYRU9?=
 =?us-ascii?Q?6g6FAw3NG/ey9x4XGxqhOIfinvwFTGS0SrI++S+R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60bc5f44-aa45-4352-1102-08dd14c26360
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 00:18:48.0863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sK27t186KaweXtQ+609hYOdXpHdfWc6rCIpcjgz7vg6LgwEgxnFJyTIiuII4Vgme
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7589

Now split_huge_page_to_list_to_order() uses the new backend split code in
__folio_split_without_mapping(), the old __split_huge_page() and
__split_huge_page_tail() can be removed.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 207 -----------------------------------------------
 1 file changed, 207 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4f4f3b50c537..eed4ff97e235 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3146,213 +3146,6 @@ static void lru_add_page_tail(struct folio *folio, struct page *tail,
 	}
 }
 
-static void __split_huge_page_tail(struct folio *folio, int tail,
-		struct lruvec *lruvec, struct list_head *list,
-		unsigned int new_order)
-{
-	struct page *head = &folio->page;
-	struct page *page_tail = head + tail;
-	/*
-	 * Careful: new_folio is not a "real" folio before we cleared PageTail.
-	 * Don't pass it around before clear_compound_head().
-	 */
-	struct folio *new_folio = (struct folio *)page_tail;
-
-	VM_BUG_ON_PAGE(atomic_read(&page_tail->_mapcount) != -1, page_tail);
-
-	/*
-	 * Clone page flags before unfreezing refcount.
-	 *
-	 * After successful get_page_unless_zero() might follow flags change,
-	 * for example lock_page() which set PG_waiters.
-	 *
-	 * Note that for mapped sub-pages of an anonymous THP,
-	 * PG_anon_exclusive has been cleared in unmap_folio() and is stored in
-	 * the migration entry instead from where remap_page() will restore it.
-	 * We can still have PG_anon_exclusive set on effectively unmapped and
-	 * unreferenced sub-pages of an anonymous THP: we can simply drop
-	 * PG_anon_exclusive (-> PG_mappedtodisk) for these here.
-	 */
-	page_tail->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
-	page_tail->flags |= (head->flags &
-			((1L << PG_referenced) |
-			 (1L << PG_swapbacked) |
-			 (1L << PG_swapcache) |
-			 (1L << PG_mlocked) |
-			 (1L << PG_uptodate) |
-			 (1L << PG_active) |
-			 (1L << PG_workingset) |
-			 (1L << PG_locked) |
-			 (1L << PG_unevictable) |
-#ifdef CONFIG_ARCH_USES_PG_ARCH_2
-			 (1L << PG_arch_2) |
-#endif
-#ifdef CONFIG_ARCH_USES_PG_ARCH_3
-			 (1L << PG_arch_3) |
-#endif
-			 (1L << PG_dirty) |
-			 LRU_GEN_MASK | LRU_REFS_MASK));
-
-	/* ->mapping in first and second tail page is replaced by other uses */
-	VM_BUG_ON_PAGE(tail > 2 && page_tail->mapping != TAIL_MAPPING,
-			page_tail);
-	new_folio->mapping = folio->mapping;
-	new_folio->index = folio->index + tail;
-
-	/*
-	 * page->private should not be set in tail pages. Fix up and warn once
-	 * if private is unexpectedly set.
-	 */
-	if (unlikely(page_tail->private)) {
-		VM_WARN_ON_ONCE_PAGE(true, page_tail);
-		page_tail->private = 0;
-	}
-	if (folio_test_swapcache(folio))
-		new_folio->swap.val = folio->swap.val + tail;
-
-	/* Page flags must be visible before we make the page non-compound. */
-	smp_wmb();
-
-	/*
-	 * Clear PageTail before unfreezing page refcount.
-	 *
-	 * After successful get_page_unless_zero() might follow put_page()
-	 * which needs correct compound_head().
-	 */
-	clear_compound_head(page_tail);
-	if (new_order) {
-		prep_compound_page(page_tail, new_order);
-		folio_set_large_rmappable(new_folio);
-	}
-
-	/* Finally unfreeze refcount. Additional reference from page cache. */
-	page_ref_unfreeze(page_tail,
-		1 + ((!folio_test_anon(folio) || folio_test_swapcache(folio)) ?
-			     folio_nr_pages(new_folio) : 0));
-
-	if (folio_test_young(folio))
-		folio_set_young(new_folio);
-	if (folio_test_idle(folio))
-		folio_set_idle(new_folio);
-
-	folio_xchg_last_cpupid(new_folio, folio_last_cpupid(folio));
-
-	/*
-	 * always add to the tail because some iterators expect new
-	 * pages to show after the currently processed elements - e.g.
-	 * migrate_pages
-	 */
-	lru_add_page_tail(folio, page_tail, lruvec, list);
-}
-
-static void __split_huge_page(struct page *page, struct list_head *list,
-		pgoff_t end, unsigned int new_order)
-{
-	struct folio *folio = page_folio(page);
-	struct page *head = &folio->page;
-	struct lruvec *lruvec;
-	struct address_space *swap_cache = NULL;
-	unsigned long offset = 0;
-	int i, nr_dropped = 0;
-	unsigned int new_nr = 1 << new_order;
-	int order = folio_order(folio);
-	unsigned int nr = 1 << order;
-
-	/* complete memcg works before add pages to LRU */
-	split_page_memcg(head, order, new_order);
-
-	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
-		offset = swap_cache_index(folio->swap);
-		swap_cache = swap_address_space(folio->swap);
-		xa_lock(&swap_cache->i_pages);
-	}
-
-	/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
-	lruvec = folio_lruvec_lock(folio);
-
-	ClearPageHasHWPoisoned(head);
-
-	for (i = nr - new_nr; i >= new_nr; i -= new_nr) {
-		struct folio *tail;
-		__split_huge_page_tail(folio, i, lruvec, list, new_order);
-		tail = page_folio(head + i);
-		/* Some pages can be beyond EOF: drop them from page cache */
-		if (tail->index >= end) {
-			if (shmem_mapping(folio->mapping))
-				nr_dropped++;
-			else if (folio_test_clear_dirty(tail))
-				folio_account_cleaned(tail,
-					inode_to_wb(folio->mapping->host));
-			__filemap_remove_folio(tail, NULL);
-			folio_put(tail);
-		} else if (!folio_test_anon(folio)) {
-			__xa_store(&folio->mapping->i_pages, tail->index,
-					tail, 0);
-		} else if (swap_cache) {
-			__xa_store(&swap_cache->i_pages, offset + i,
-					tail, 0);
-		}
-	}
-
-	if (!new_order)
-		ClearPageCompound(head);
-	else {
-		struct folio *new_folio = (struct folio *)head;
-
-		folio_set_order(new_folio, new_order);
-	}
-	unlock_page_lruvec(lruvec);
-	/* Caller disabled irqs, so they are still disabled here */
-
-	split_page_owner(head, order, new_order);
-	pgalloc_tag_split(folio, order, new_order);
-
-	/* See comment in __split_huge_page_tail() */
-	if (folio_test_anon(folio)) {
-		/* Additional pin to swap cache */
-		if (folio_test_swapcache(folio)) {
-			folio_ref_add(folio, 1 + new_nr);
-			xa_unlock(&swap_cache->i_pages);
-		} else {
-			folio_ref_inc(folio);
-		}
-	} else {
-		/* Additional pin to page cache */
-		folio_ref_add(folio, 1 + new_nr);
-		xa_unlock(&folio->mapping->i_pages);
-	}
-	local_irq_enable();
-
-	if (nr_dropped)
-		shmem_uncharge(folio->mapping->host, nr_dropped);
-	remap_page(folio, nr, PageAnon(head) ? RMP_USE_SHARED_ZEROPAGE : 0);
-
-	/*
-	 * set page to its compound_head when split to non order-0 pages, so
-	 * we can skip unlocking it below, since PG_locked is transferred to
-	 * the compound_head of the page and the caller will unlock it.
-	 */
-	if (new_order)
-		page = compound_head(page);
-
-	for (i = 0; i < nr; i += new_nr) {
-		struct page *subpage = head + i;
-		struct folio *new_folio = page_folio(subpage);
-		if (subpage == page)
-			continue;
-		folio_unlock(new_folio);
-
-		/*
-		 * Subpages may be freed if there wasn't any mapping
-		 * like if add_to_swap() is running on a lru page that
-		 * had its mapping zapped. And freeing these pages
-		 * requires taking the lru_lock so we do the put_page
-		 * of the tail pages after the split is complete.
-		 */
-		free_page_and_swap_cache(subpage);
-	}
-}
-
 /* Racy check whether the huge page can be split */
 bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
 {
-- 
2.45.2


