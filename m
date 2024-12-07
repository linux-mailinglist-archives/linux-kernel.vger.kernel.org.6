Return-Path: <linux-kernel+bounces-436110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8389E8138
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 18:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1E9E16590A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 17:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D98F14D2AC;
	Sat,  7 Dec 2024 17:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jiz1glDA"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0969E42A81
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 17:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733591805; cv=fail; b=ZVKmsJlWwVrwpJnzNVYirNLg0+SPDeXpYtwi2HIlJTqqpaf7eKER2JITQkhvg2yQHRT0YWxhpB11uqSHNW1YSAAjzsu6q7953VCsW7H46MymwYdg2bCSWCTP9VXEWISYErIAVd+9lN7dX0hqJTOGm02PPpArwWCSCGjZP+KxE94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733591805; c=relaxed/simple;
	bh=9pxEnGKn6TmWcdAdS1ZDOcauEQgc8RyCWgp5eiIlr/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O2qJ7PX7OTpyQjJDbh+DuOuakYYW/nnv7zmtgwhj5OvHyo1P5ofClARpDw4YrfVlzAUVwtjiT/zj10P+UItHKUWtcziiYub6ZZmb1sPLoUKw1UYZMvIjwYGugco0ICBjxbzxij9HTz1PyAmM30DdCHpL6uoCjXcc8U0B41k8NPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jiz1glDA; arc=fail smtp.client-ip=40.107.95.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4IBbr01Tn2UW6VLPX9QvdB1HUCheC320LdUH5KbdGE1WE/NrDEOLBDDEa6quzbUsqeK5jSmZ99+C7GBXKZvPwnkZpKCWa/m1osBK/k700ydXb/ygtStx7JsvOemMLL7hRRhsW7/6JMksG+3GL/IDex/skspaZoRNp9tROOdttR5cMTw/7t96N4TNvD7zdarXjfd41ralYZuFh7l6J853jwTtgaTCGvxmgNd4eqHcvgNklQNpdUDjD0OYoE7P+6PkgZFEBMnEFs+qiQ5RW4C75QESi69msLReR2mc8hi5amulk4ZaLQ6dPlJPWobhS5/vWmBmtyg8hBEbNRQ9V1aeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OE5AjSKRmuU6Rd5zudSUyT6TNtRUji94cy+vQKppN38=;
 b=omNqsIqZWRuVZ4QN0EN+3pcklZxWn1oHkmzPYOmlYxdAbJYUMiHI02v0MJ8cAeBarwK2LkC01mAc82Gnfvv8aG6znwakMSWLzOylxT39jgA1dSnaSjG1f4PJd/S82FgBlgLwZuprlGJ7PLKxbLE+R6rI70QlJ69Ng3VHpsG9NtMdo7eFS4BI8dPpiL44UOUpzOxGZslxZgm1EaOgT4Z9KBkxA+cBWtNC47eKtAHmDpWNMBy/PxMgnM64AgSKc/A9R3ISlUihH34cP+XiIbPafz2Eva679kr/LZrPlM/8sAXZkJQtjQdTFzzBkC6Ie6PbP83bhj0A1Ex7YZ4tkJwwpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE5AjSKRmuU6Rd5zudSUyT6TNtRUji94cy+vQKppN38=;
 b=jiz1glDAiJppLPmO19LYEzRDIACo4xrlZ3v2ggEYOxgO18VgYEOATThsk2WLZ1YGj8k/+H00GeChByjXk1j4901G1n8qkRW8ZLyWayqD4vZtAsMZn04ZMeF6exy+wMtJnGYHMW0HgUoH0HyBuygHX6Ibiyc6ZrX3eVKRbHE2DpiOS4vYorJtCM4Dz0nNTvAfTZMAjvbgI7fU8PzWGGNqtbPxoNGRrzN8nP3tvWeBpqRw/yfJmJiE4Lo4SnqdhEvAM0G+UvhbPNbs+MDrL5V6UtREiqRDuGl63MhfymNxprFFlN+TF1+K2I91L1eiWW4BL1EGZ980zChZ7xwLxQuvcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 BL3PR12MB6449.namprd12.prod.outlook.com (2603:10b6:208:3b8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.18; Sat, 7 Dec 2024 17:16:38 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8230.016; Sat, 7 Dec 2024
 17:16:38 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	John Hubbard <jhubbard@nvidia.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Alexander Potapenko <glider@google.com>,
	Kees Cook <keescook@chromium.org>,
	Vineet Gupta <vgupta@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	Zi Yan <ziy@nvidia.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 2/2] mm: use clear_user_(high)page() for arch with special user folio handling
Date: Sat,  7 Dec 2024 12:16:31 -0500
Message-ID: <20241207171631.2853336-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241207171631.2853336-1-ziy@nvidia.com>
References: <20241207171631.2853336-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR14CA0001.namprd14.prod.outlook.com
 (2603:10b6:408:e3::6) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|BL3PR12MB6449:EE_
X-MS-Office365-Filtering-Correlation-Id: a6720ab1-6ec6-4de6-1bbf-08dd16e2e8ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Y2XFwm26cw2QCdK2B0hx1zRuQ5iStogSx0h+O8oEj0+X/aTB/mmGfscQhqu?=
 =?us-ascii?Q?Cja7rJvp4CoScdX35deP7ErRnWKcYurx2onJ66gfA+TDyFKyxwDaUxk5QjvS?=
 =?us-ascii?Q?qrJT+zQPDzORlvIjzNk24BpyFcg29r6KBL4NPMg9Z1q9xbDKfvhak12bxee6?=
 =?us-ascii?Q?bRZcLm941iGWUOkM7YWj+RwxXR5KsN2UpU5AysKkD5nkrFYPU6KLPJiAcKGE?=
 =?us-ascii?Q?BvI26bKmnQNJdS9/kq4ZkHcg/Did8BpY6inWINbHWfhx1ICnJwRnt/Opc3ct?=
 =?us-ascii?Q?CaeMAZwU0KWMu4YofYPLTpCaW/TL+UueuTv1ecMsvh/W+1H7kyCPvpWy3KBW?=
 =?us-ascii?Q?X7khJBvpCgRTePFLJZE0I6rOmPE8Pbek4k0+SwHn/4fyPo2dOedkZMB2YTcu?=
 =?us-ascii?Q?HiLf9h3TRRp5uZkqxa/jDbFBP0AxRNtQIQlhymy7WOsGY/TIyxqUxWQ2lo3s?=
 =?us-ascii?Q?o3i27IPDPr0Ipqrmx1PtfkGqTnB9czlmfrL3kZhT+IOHYH7YeKTdY2fCP4RC?=
 =?us-ascii?Q?K36+vxPhfzvgU1tj7f+IObnYGaDHuob/5bZFrFG9CO074wYH+yIiLVgGNnu5?=
 =?us-ascii?Q?a+Ug+/MM4tTX4Wb59985mgrZfeqpRFNm7tSV2K0Can1b0mpXfGLoYOeKOS9r?=
 =?us-ascii?Q?6x4MdoUnUBLV4Im2o5FbHb90l/XTOu50haAFG8gGFozoeG4kcnSbNrEJaZFw?=
 =?us-ascii?Q?MgX7FG/1Qg/mqGUUbTWwvIKsGKBgwWWhm9GTiE/320Q/p80caRURFJEXAX7s?=
 =?us-ascii?Q?XeQJk9KYmWN6SOeFJR0PTHuPE65Y3H9FDESL02lMukNYcIVxT3SSlb3c1gV+?=
 =?us-ascii?Q?s0qZlUzO5IGWcM7/BN4oqYejXB+Rk1AuNT/CRkABOA0hfJ3aKRziahu0bR/s?=
 =?us-ascii?Q?QKBoyGvvDVQ4QooCJeFlH5rAIRlWOz/5rWDuPXOAcgvLKcQ+B6pWq9HvIVxe?=
 =?us-ascii?Q?Q8+e6eqpvtHcpoSJWvAXzqMwh/rYKP4oyScXe1hIFGqLnGyVSin/9me6TyQf?=
 =?us-ascii?Q?eyMGdgRvczRLScPB/1TxjiOOqBs7hOvpTpy0VQb3Ius8ymGGhFapS+2Ij367?=
 =?us-ascii?Q?k4l2d8ROh76ACQ/+7ZZ94/7GYJ+aROqYh1Fmll1MPk547n/glbOTUllx5aXC?=
 =?us-ascii?Q?TE91Tpr1Frc/9KamjUiH12eV2CxD8z0Vu02Fn3EA5YJlRQpod815nsjJUSmk?=
 =?us-ascii?Q?cvRIPol1zRQvvw2dPCz7HpaePH0xRXF5fcNsW1EmYAMoabLCiMusLY475Q+/?=
 =?us-ascii?Q?Bsy3hXM36j4JoEO5GebpKFmL70yE9Zzs7dEc728Lu4Du81s4L03yVFJ+jYHg?=
 =?us-ascii?Q?H888pr/mUci09pbCwR+WV6FOgsVItDpvcs40g4PnTQhOv6lnY2fzl0YLXswO?=
 =?us-ascii?Q?30FLTzw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uLWnkDnmofnhgIeLGaNsC4QTWKQU7U0amFvuILfg1qoGjJq1IW+74rm0HnPk?=
 =?us-ascii?Q?YsyLpjuHQokpMC2E7ekKWiO8Lp5YfjUH/p6fyEE7XtXEb7QzqKvmhcB33jzk?=
 =?us-ascii?Q?xsNQiL28N9hOjEJrRbNh7Kyc+Yb5eV9c4U+DUasK5qZMG+CbgH8+3Nv3GERn?=
 =?us-ascii?Q?VDsZ9LxTbD9mv6dj8cP8yhJ35/tEGVXnXKs8BBSpjVWscNut1T+UKZ7eH+17?=
 =?us-ascii?Q?P+RZCDxaDsxMK9e9XBJ+mm/uJJBmZDRXhJPwgPrCerDkR5stianevzkKTdyG?=
 =?us-ascii?Q?kGqbbTB7CgVf5dbLQOZ3j1nC4RXMjwK59LHyy7w4Nva2TFBFHFVmP2sKn5R5?=
 =?us-ascii?Q?bNg6xTTg0EfaBKkPv0kSj1N1TOVdXR2uLnDnk59M+rA05mqFwU+Zo209gG5a?=
 =?us-ascii?Q?d3blUiWRhm9aFjRUtF4wWJEe7Zcrj+fqxLH+qyVtWK8Jle7s26fLUDJoOq8y?=
 =?us-ascii?Q?Ieup0TOqGoEWLZ6wHFakWadAxLI4IlCsSYI/Rt+Ex4XRYpeRWE3PQU85mctA?=
 =?us-ascii?Q?FYP1GHLHXDpy08cI0kUx/wU0dAPSBejEBM3Ef8qZqRMV2E8FMlVgwe8wxMxn?=
 =?us-ascii?Q?vPASKzIicOY3AzLS4T5qj77skfUc+uygmncFnW4EWF+/gQlHEh8KJ6x56xIw?=
 =?us-ascii?Q?mjq0CXgzmN1cGxjI3D2xScoZDelcIQ1elQlYTpVY5OHL6MSokOSn1fHPD0q5?=
 =?us-ascii?Q?qrjCHlY2gMmfzTt3u2IQml799PHG7uEezOPfC8h+Eyhq0lTJ2y1lkE0hl4eW?=
 =?us-ascii?Q?NQgbIjY/bq0cJpK5GiZn00fAgLYnRaOZZ2u4U55Cj7wg0ETbMOvHPoAwrncV?=
 =?us-ascii?Q?bsYkpYAFq+A81ZHb/ssUhm6rSe58WiDhZNGXgRIE/7a6WHGSnprYOKuoEXv5?=
 =?us-ascii?Q?guSF9MpKbG2POoDd7Xr9n9nsgcls5h5vVViJuflc/G7Bs867EL+G0stfakv6?=
 =?us-ascii?Q?z1xGXuEMVPCiUEfjkG8i7o62RSS8YdMsozmu5p3tkaTsUuEnnoB9mxQh+mOu?=
 =?us-ascii?Q?EhcB4CmVRsjuOCGRb+5GdBt9wMVSCp2Nthcr0MIO38PP1+Mj9W/QFLMqJ5yb?=
 =?us-ascii?Q?3Qt1fLCcmuFvm2cK/JNTsqmUtxf5NCPV/iZpRQQKI23wEslf1kFIG1JRkXBX?=
 =?us-ascii?Q?BQ1Uzgwo4KWhly1IECLcfQOC2Y8/j+MfrZL7UA3MS1vVIfwvHnmCZ8jshs+f?=
 =?us-ascii?Q?bdGKL/Y32XHVdXMSdBOYumrjDfWkzQm2rbZfFIyIMAWPBt2p6FtjO8mNKQWR?=
 =?us-ascii?Q?xC0LhEAArPUWbMtTB3WHnu7Dt0GN6IYHkDemQvE13AfPZQsqqOfBE6xIuIGw?=
 =?us-ascii?Q?zbti4JiSh/2TxQfRlRYsgkxx6ckTHeLIVuOc2ksnkLjcp8u9HB1gS1aqyonZ?=
 =?us-ascii?Q?nQzuRa0DavbVoVxuNUOKX76xjIcVY996JHHLjhsUbMAHWoQjz0oq0+VE8rsw?=
 =?us-ascii?Q?xQwM96KTP2odmFGT+AVQlUEc1MjfeH7QcUcWbxsXzBCO7JbgWL/yM3IHiYbu?=
 =?us-ascii?Q?/WcW5BBiYwSWuijIbxaSjjdhkM1oVvLWCmHlgeKlJCojFDur7IxkWn+LZRfP?=
 =?us-ascii?Q?T66+cHMqAF1SlCOomLw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6720ab1-6ec6-4de6-1bbf-08dd16e2e8ba
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2024 17:16:38.0532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ox5ibJ/iTdeXkxOjKZ09C0Rfw9WAURpn4E/GHUTKXZq3iCzr1JhH6CB5Ant5tlrc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6449

Some architectures have special handling after clearing user folios:
architectures, which set cpu_dcache_is_aliasing() to true, require
flushing dcache; arc, which sets cpu_icache_is_aliasing() to true, changes
folio->flags to make icache coherent to dcache. So __GFP_ZERO using only
clear_page() is not enough to zero user folios and clear_user_(high)page()
must be used. Otherwise, user data will be corrupted.

Fix it by always clearing user folios with clear_user_(high)page() when
cpu_dcache_is_aliasing() is true or cpu_icache_is_aliasing() is true.
Rename alloc_zeroed() to alloc_need_zeroing() and invert the logic to
clarify its intend.

Fixes: 5708d96da20b ("mm: avoid zeroing user movable page twice with init_on_alloc=1")
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Closes: https://lore.kernel.org/linux-mm/CAMuHMdV1hRp_NtR5YnJo=HsfgKQeH91J537Gh4gKk3PFZhSkbA@mail.gmail.com/
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/highmem.h |  8 +++++++-
 include/linux/mm.h      | 18 ++++++++++++++++++
 mm/huge_memory.c        |  9 +++++----
 mm/internal.h           |  6 ------
 mm/memory.c             | 10 +++++-----
 5 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 6e452bd8e7e3..d9beb8371daa 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -224,7 +224,13 @@ static inline
 struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
 				   unsigned long vaddr)
 {
-	return vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr);
+	struct folio *folio;
+
+	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr);
+	if (folio && alloc_need_zeroing())
+		clear_user_highpage(&folio->page, vaddr);
+
+	return folio;
 }
 #endif
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c39c4945946c..9330b60b926f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -31,6 +31,7 @@
 #include <linux/kasan.h>
 #include <linux/memremap.h>
 #include <linux/slab.h>
+#include <linux/cacheinfo.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -4175,6 +4176,23 @@ static inline int do_mseal(unsigned long start, size_t len_in, unsigned long fla
 }
 #endif
 
+/*
+ * alloc_need_zeroing checks if a user folio from page allocator needs to be
+ * zeroed or not.
+ */
+static inline bool alloc_need_zeroing(void)
+{
+	/*
+	 * for user folios, arch with cache aliasing requires cache flush and
+	 * arc changes folio->flags to make icache coherent with dcache, so
+	 * always return false to make caller use
+	 * clear_user_page()/clear_user_highpage().
+	 */
+	return cpu_dcache_is_aliasing() || cpu_icache_is_aliasing() ||
+	       !static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
+				   &init_on_alloc);
+}
+
 int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *status);
 int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
 int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ee335d96fc39..107130a5413a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1176,11 +1176,12 @@ static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
 	folio_throttle_swaprate(folio, gfp);
 
        /*
-	* When a folio is not zeroed during allocation (__GFP_ZERO not used),
-	* folio_zero_user() is used to make sure that the page corresponding
-	* to the faulting address will be hot in the cache after zeroing.
+	* When a folio is not zeroed during allocation (__GFP_ZERO not used)
+	* or user folios require special handling, folio_zero_user() is used to
+	* make sure that the page corresponding to the faulting address will be
+	* hot in the cache after zeroing.
 	*/
-	if (!alloc_zeroed())
+	if (alloc_need_zeroing())
 		folio_zero_user(folio, addr);
 	/*
 	 * The memory barrier inside __folio_mark_uptodate makes sure that
diff --git a/mm/internal.h b/mm/internal.h
index cb8d8e8e3ffa..3bd08bafad04 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1285,12 +1285,6 @@ void touch_pud(struct vm_area_struct *vma, unsigned long addr,
 void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
 	       pmd_t *pmd, bool write);
 
-static inline bool alloc_zeroed(void)
-{
-	return static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
-			&init_on_alloc);
-}
-
 /*
  * Parses a string with mem suffixes into its order. Useful to parse kernel
  * parameters.
diff --git a/mm/memory.c b/mm/memory.c
index 75c2dfd04f72..cf1611791856 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4733,12 +4733,12 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 			folio_throttle_swaprate(folio, gfp);
 			/*
 			 * When a folio is not zeroed during allocation
-			 * (__GFP_ZERO not used), folio_zero_user() is used
-			 * to make sure that the page corresponding to the
-			 * faulting address will be hot in the cache after
-			 * zeroing.
+			 * (__GFP_ZERO not used) or user folios require special
+			 * handling, folio_zero_user() is used to make sure
+			 * that the page corresponding to the faulting address
+			 * will be hot in the cache after zeroing.
 			 */
-			if (!alloc_zeroed())
+			if (alloc_need_zeroing())
 				folio_zero_user(folio, vmf->address);
 			return folio;
 		}
-- 
2.45.2


