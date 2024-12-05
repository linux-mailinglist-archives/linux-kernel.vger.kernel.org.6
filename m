Return-Path: <linux-kernel+bounces-432427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524ED9E4B0A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C62B162FC6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D06482ED;
	Thu,  5 Dec 2024 00:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B3r0mMGn"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F65E42A80
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 00:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733357941; cv=fail; b=GApeW2OoXA49VdkCxLeQFkczm8OVFwX4OHN/KwBgq749RWCR1XRXjZR81KPHnCuquwHWe2HTbFbCnbwTF7iKzlAG4IEzi7ZXL8y6HBY/jFaMcm/aNfwoCN8KmBngfL5VGQ55R+oCll3ymFkNSrh2GyMZ9HG8LvJ0LqOfDwNSjBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733357941; c=relaxed/simple;
	bh=KiCIoysfm+JzvCSyWd4lCXqW7BO6yL1fPDloMdn0e5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RvcZbJFb8AOcC1qHlxPVTjWJ80e4fzF6gEjSkzdx3PeAPL+68zOUtXiI1m/dcpSI/5KKF73dZLSFSF56KxnCKcY3ojo8IGJiub/g0TCw53iuB12nvXhoFOLxilowMAl57s8OTpqEq24BpDcqXuf0sP/+BDBdQnglhSUS8Y8C7Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B3r0mMGn; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xs3g6oOZ6htcTISdZVUZUJo+mxpVfdqpBWxZe0yQ4HcbuwqXTM+pZzLvMCIymSXHlb2jkkaAnfw2yKh697n8j/3R0VW/CM1W6t6GtR7KU1SERIfHUZgBX7ItrY5HcKp1dzX3X2TotDtyElT4XZGjuLhm3uTTwMfGWoPBjPlftZRueoaZWsbubAaBZ0I1fVnDV9RzJ9PliGYOKPkHZbq53SIMcmoJvIpCWXZLrz6VpubUXfKYI+LP4PMs2qEB+bDkoTw8CoWnkY/e5mYnVmBhJSdrY7lJ46sbFXG04iCAmz/WJnyJjDSiVb4rdCEe2eRYqjJUn4FtzwEC3eJDXiB1Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScO3EO7bE1reYb9jG/eBQkGrULymO/6W7BTzXOMGCLQ=;
 b=JAc3tM9CopY0rL5VrIbHpBEoTzjUKpuF5NCeHH9kFXjPzCe4HEiB9WtNSM7tkLQEhaTNBAtgBK2rDqurlUeilPpyYao8Y/bfmW7ci2UWtprzYHLcwgDJaB1wTy/TbkooUU3jWSYnYUQY9bX6GRFDIIbMexlvrHKZ1I7/+e5bmn10TLiBivNwyfbtLQqovxy9qKNwGlopkegQrP36EbboauS+a2ZYEOKEvD0K7opikE8Rf6nPk2ImNAJDMAGB7VtzySJOCK34uGlSzbsr8PLjc06urImmj7VyVBsZfIflYOMH1t+5ZNT0glSWSm3ahXLEnLfuryeiMCMusZSNKZmT6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScO3EO7bE1reYb9jG/eBQkGrULymO/6W7BTzXOMGCLQ=;
 b=B3r0mMGnAD8KNmtFPQOwr7PN48Z3LQs60uh+lnzixeSHimBzpTLwZpMhwKhnGB+Ip08IsuY5ZT6Kb0f3Nye77jJMIGBFM4M+mHPJ2i7z1dlroOpheGL5KjlZysBfjAJLCvatNkhleCQflxFRunzfbnhtYbBhtZgK1/JcJrx1v76nEmAjErgVW4QE4Zyi+aKVFVSx9aea24j1pLPTbuYxkVSzE8omo1Ze37IurWo6lxMv9cjaWOoXoccnK84a52U+Z598TFtPTs+denIc/t5TN3euHwrMaQ4ptRzkVSI6zILqnh7CCpu9sZgdT262j6WmqI5zYf2Skb/3Mkyjvruc2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by IA1PR12MB7589.namprd12.prod.outlook.com (2603:10b6:208:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 00:18:50 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%6]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 00:18:50 +0000
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
Subject: [PATCH RESEND v3 6/9] mm/truncate: use folio_split() for truncate operation.
Date: Wed,  4 Dec 2024 19:18:36 -0500
Message-ID: <20241205001839.2582020-7-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241205001839.2582020-1-ziy@nvidia.com>
References: <20241205001839.2582020-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0073.namprd04.prod.outlook.com
 (2603:10b6:408:ea::18) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|IA1PR12MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: f2e236ec-df4a-42dc-898d-08dd14c264a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EpHA/NyAKWq7xPgwK/z96oBkzI9C16OQUotJFcKbg2XVkkHyL5VKHczgiI37?=
 =?us-ascii?Q?WjXk8bEkEtY4vwRVAJVHZH04oNHt00wVisAkDSR1qDsJcOt1Y2B7Bo0q0l70?=
 =?us-ascii?Q?UcRw3PMnbJq2fdYfRkCdvazumcA8nUpzSCQ9KBKkFEvLAx+JtyhPgy8fLWBC?=
 =?us-ascii?Q?3K9IexGAl+8nCVvNSG8ZiiGsujGkaD/Xc63BK+CeQO9tbCKgx08Iwi+RkbUB?=
 =?us-ascii?Q?F0WrPCfV2HA/r6pXhWizJmZf8+s796babPMnGHyZ5vSq6PzsOMc+gHYn59BG?=
 =?us-ascii?Q?8mQm2DysV4iK1Xcd+O3aOh9AEOUOfkBqOsQ6Q0u4gzmDAH1kzdGitCfhum80?=
 =?us-ascii?Q?iku1HiR078Yazvi0sFHRt6r9YJfN7koIfFftmhPwbBTlc5XvZRPHB1IB6apy?=
 =?us-ascii?Q?NdpI2n/okSqRcF2EkCjY7kVxzwiEagW6oOOyw8bVdv2/475Nv3C/p6SV7cPJ?=
 =?us-ascii?Q?vCJ2rrU27OTGF/k5h6XRuaxWn48xv3tofFrn6A6suddADQctVVcNwySeTh3Y?=
 =?us-ascii?Q?PR5+pq5ahV+PThumnyichHWfF3m4Rm4mP9P8hGZNwIAnmdOEXLjkN0V5cKzj?=
 =?us-ascii?Q?bEUDRW+TNk9Obx+aO1R+DPGoTyRiiPefEqrOPT/DiHl/S1qWcchPzG8MHdqX?=
 =?us-ascii?Q?5jNR7bow/7XwriGzGLCKEZ6z1AC1Ahg/98XH3FcVjpffuvLFNHSDXDV/GhkN?=
 =?us-ascii?Q?W4XKoOpuMZgwCF5lQkLeXa8Bi9YjViYEqylf/JRGPEvXYqZPNVD3htf10H+N?=
 =?us-ascii?Q?z1RZkKNJ83okt6U0pLU9AUo8JCKdoS1OCepvrmqA+LRoA2KDDj6QEuCZNz8Z?=
 =?us-ascii?Q?Wlgk/GyigLfGQDyfFtJ6hM987xiRh+hRpMHxXKXrYsXQSJyRubTZV1VGrr0y?=
 =?us-ascii?Q?+LDTClzUvJsuQ+aTwRnv4FzWB1WRAlC+Cvwy7OYNl6/X/QsVGBBsmcd/ZhF8?=
 =?us-ascii?Q?60RIOlWOaFUvemgDX6nh14lyPaOoOd5T/xXnIwF5qLIZrctynYF7qv0HGy+2?=
 =?us-ascii?Q?B/YLyuP0xVj1iwNneHMhvL4xtW7NBrBteE7I+AOj+oH0YLzrU89qstRw8Eku?=
 =?us-ascii?Q?aLOMSpov07rzdjxeV5lzBqCnT4vt21RNTq7FfVZtLLBMYF6H6AxZpAdviTsU?=
 =?us-ascii?Q?Iw+B3Sdy4Tp2RlkT9tcm12Z9V6l26t67f06WCTmi6awzcSzOlFIkanfjJsl9?=
 =?us-ascii?Q?OPcn3090AcSJXIYHT3TEINStcA7C0femzzCRjUfg9pWMqHxWlpdpVDsAC2SR?=
 =?us-ascii?Q?QUySjnoXymUfBYOdlR2EUOevdwnqLtNTpRIbJbpwvhXM7wUJjvK/W0ufkuFd?=
 =?us-ascii?Q?OnIU85VQlng2jxIHh/wIZpi+iBoUgKj07GUu1LlsxlFqPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cgzM+UQcnads1cEpigAqjrabxL2OQn8OwZu3TpzIPeo+RNwdbZcMkoUD9sn4?=
 =?us-ascii?Q?jZgsGu1KjBArRor3K4PmyuWnNDirx5uSMSq41k3UjfQa5RPGQEgrTHJjjBGX?=
 =?us-ascii?Q?N6dkJ1/+De8F7Ia9g/Vtv1ottbJT/xmant4lj8YtK77BJrrQrG4JPO/TS9kp?=
 =?us-ascii?Q?aRmo0c2Rv2YmlcrirqIzw1fu8KDQQe6vxfQdVv6tsdmeBlhwGqpA/qK3smb/?=
 =?us-ascii?Q?k9u+w7ClZZnfDZjP7k42OTy+fvvPNdRGkb3g4PyS81l8caRBL1Yp3d1jwkvE?=
 =?us-ascii?Q?pTTdGN2U0IbXKl1scsSVENlNku3Per9BGqfwSufC4mPdpJXIdFv1L5pvjSte?=
 =?us-ascii?Q?zzZPtxV/qOj7KuTy4nuUhvl4RtoOvBcXSxDxhuTrJVBjq7LVBhUUj5Vl9HG1?=
 =?us-ascii?Q?lbM/shF/HCeYKVQ9vYv7zsacnwtb6+kuxmD/Dqmk3iqY/OftZsNeIUj1X2xt?=
 =?us-ascii?Q?YjEayV44EuSG1euSYhp69Glpikc+f8bUQRWxW/47jXFK+wSCQtSl/nQooUQ+?=
 =?us-ascii?Q?9/odf5S9aN7dqF9xUi52QXmVc3D6n66cRE/2vihvCQ1JHCt/j0TirywiBUch?=
 =?us-ascii?Q?gRP9TpNGNMttfj8SXPdlNfXM8n5XGcThKbO/ja4X9Wqmwz/UXvfn8KeB2KET?=
 =?us-ascii?Q?aHAIpSQjsDpqy0tTvrfc1R0DPmt3J+Mbc6ZrkcMro1s3zLpvuxfSLoy6TxoQ?=
 =?us-ascii?Q?nLZGMK1ObCHK9AFWfkO0qam90tEghWkV7qOGdiuy2JlLuhXB0KNOXVY1vFic?=
 =?us-ascii?Q?yDfMc3QDHaOwYU+cIaHAW2Z+CSFxvNPW08UgWahzlOnN+MiQz1j967nScrmF?=
 =?us-ascii?Q?mQaMGWdWt/JvMDdpJOlPPacdmGQKp6ehk11H5Ji5dzgSY6aYj389ahk74oW3?=
 =?us-ascii?Q?mmRr1fMhr8oflJpKPbHliHqam1spnCrKkudd1adi4VwBiBRunLqyK0tnVzpO?=
 =?us-ascii?Q?POn1Otq8ZlcpUZlxYM2ysYfNIyUWXf51cKRQePWNlXswOGR4ofSqoxDV6x6p?=
 =?us-ascii?Q?yw8wY4NoSZ+EuRIPI+otVgcL6Olm2i1GqnXSOrZUbcIoYG1Z62tcj09IY3CB?=
 =?us-ascii?Q?mshTjh00dYipBBx5e+pOCdaWoUdyJIKNz5q4DFlZACTpdkwdUpDTdHqrFe0l?=
 =?us-ascii?Q?GbfExD/FD2w1Bjq0bOZ8FPRmFaA5OxE6E4NnrRehBM8MofWiJ2LVprgVBHCy?=
 =?us-ascii?Q?OHl//JxWRCDBwL+d844nJGkQlqEPCj3PAXmg75K+jFYTYoi4F/fgovcCWE/u?=
 =?us-ascii?Q?sbox3zoqwaO1PfzWhs/SEVYp13vp0RqaRnXHRNxnTAR/xNYzPPZlEZ9NzEOA?=
 =?us-ascii?Q?1Ug2Kx+tSvB3PWQJEfGfX1moI0fjpWT/aOPEh1a5BlJ8PZZO0e/lFCrRUKVF?=
 =?us-ascii?Q?VvgWHPHzPPf5ysT68kZ/jw42vlk6BrcAJzJTokEZhQFt3MfDmz8S4C+wtKsC?=
 =?us-ascii?Q?yM1r/8tjyNUXn/tBvTEnuqjrfWreo33E2C07dG1n8flf5ucUhh+dkT8/uVeh?=
 =?us-ascii?Q?PdRRuaIkRH4pVKJc/ZZDbl4xJV/vqkhi0PaE25qGVCWFX7vdhohfVf8bFK0g?=
 =?us-ascii?Q?WZD01aVhbN6eBRPQFRrziUemRd0fupFv+0CMrOT+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e236ec-df4a-42dc-898d-08dd14c264a5
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 00:18:50.2388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45UrZFgpBllT22CXE3zA7dyNgQ12FJui3eGkM7WtjM/Ie2MxbLL8Ua9DrRFpwH4z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7589

Instead of splitting the large folio uniformly during truncation, use
buddy allocator like split at the start of truncation range to minimize
the number of resulting folios.

For example, to truncate a order-4 folio
[0, 1, 2, 3, 4, 5, ..., 15]
between [3, 10] (inclusive), folio_split() splits the folio to
[0,1], [2], [3], [4..7], [8..15] and [3], [4..7] can be dropped and
[8..15] is kept with zeros in [8..10].

It is possible to further do a folio_split() at 10, so more resulting
folios can be dropped. But it is left as future possible optimization
if needed.

Another possible optimization is to make folio_split() to split a folio
based on a given range, like [3..10] above. But that complicates
folio_split(), so it will investigated when necessary.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/huge_mm.h | 18 ++++++++++++++++++
 mm/truncate.c           |  5 ++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index b94c2e8ee918..29accb5d93b8 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -339,6 +339,18 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		unsigned int new_order);
 int min_order_for_split(struct folio *folio);
 int split_folio_to_list(struct folio *folio, struct list_head *list);
+int folio_split(struct folio *folio, unsigned int new_order, struct page *page,
+		struct list_head *list);
+static inline int split_folio_at(struct folio *folio, struct page *page,
+		struct list_head *list)
+{
+	int ret = min_order_for_split(folio);
+
+	if (ret < 0)
+		return ret;
+
+	return folio_split(folio, ret, page, list);
+}
 static inline int split_huge_page(struct page *page)
 {
 	struct folio *folio = page_folio(page);
@@ -531,6 +543,12 @@ static inline int split_folio_to_list(struct folio *folio, struct list_head *lis
 	return 0;
 }
 
+static inline int split_folio_at(struct folio *folio, struct page *page,
+		struct list_head *list)
+{
+	return 0;
+}
+
 static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
 #define split_huge_pmd(__vma, __pmd, __address)	\
 	do { } while (0)
diff --git a/mm/truncate.c b/mm/truncate.c
index 7c304d2f0052..9f33d6821748 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -178,6 +178,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 {
 	loff_t pos = folio_pos(folio);
 	unsigned int offset, length;
+	long in_folio_offset;
 
 	if (pos < start)
 		offset = start - pos;
@@ -207,7 +208,9 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 		folio_invalidate(folio, offset, length);
 	if (!folio_test_large(folio))
 		return true;
-	if (split_folio(folio) == 0)
+
+	in_folio_offset = PAGE_ALIGN_DOWN(offset) / PAGE_SIZE;
+	if (split_folio_at(folio, folio_page(folio, in_folio_offset), NULL) == 0)
 		return true;
 	if (folio_test_dirty(folio))
 		return false;
-- 
2.45.2


