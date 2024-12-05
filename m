Return-Path: <linux-kernel+bounces-432421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 541BE9E4B04
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2332C161C00
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D290A3208;
	Thu,  5 Dec 2024 00:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hJLyFsKO"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EC118052
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 00:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733357929; cv=fail; b=R9cadE/7TQNji+qXaSNuZws4A4CsVxBmZAezGj0a+WoZB7scdEjiZzqjm5yGCsY3yDtZE5LQf4gcY85WqJUI+xw4eslGMTiQzpqlQ13R54dwnqU5XNyTY7hYzIUCuHAGxuc+ZJM2/CLPG/W9uPnAtPF6K1rsYbQnbVFMvZZ9bCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733357929; c=relaxed/simple;
	bh=HFbVhJUTfMdW55sFFrXOU7+9DEYAr8/HcBVrfyW1Ra8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=T+rL5Psm7O9I/9QiGdeHZWvu4sFZI3kluETZZgWo0WN6duuFjgSXltFrWqRJG21nUPQPgsxKVsaoghvUTD6rn/oyrxOZNd64yTbyIdmMyxk/tNWPPlm+KjLOsMG/JcrFK1zBodv043404rMdKL5fsHCELUlAPQALxtFNMq4HGVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hJLyFsKO; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yf3zyCgtWV+gWCXxoQLzg/l9fOr8hQijr3uqNQNnCAsVnpDpNkY0gqplcE8mFuNRJow62Tw37s4w7n6zEE/DG/+kuE6tmJM0MNP1vDzMo6LOCg48cQd8aKeYPxKWMYVA4qTpICsssIlAyOI42ZvuNECPMcn7EigmH6nx27rhkqj2lvtSB+SvuCHED1oL2my0on6ThFPVmc8+KJNcqfxWM9t94/URCDlGObihtC8G2dLu81YQd6F8Yr94lIRHCIJrYmkZvwwCgIxiExwo8dSO7gs73vpRHU1HAQC1PLqyHt+c33Sdq0iPO9r+TR6rt51XBn4DJDX66A5U61WTTjEt2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKT069lVMAQRzU9nsKMLPA6gzsjFGeFA8wtuDb6+7+k=;
 b=FTjrcA62eG0YgHNegSKk+7FdZ0ECDyz4TH1SAh+LmdBQ9SnT/lVXn6dMkAxnwlPGPhIXmaKPetZlHbZEvnkEymvU5aVsYOxmGpWVkIZuLwB0Y2ICpaw3pSAjhfX5OSiFVYwQzQbr+0JXqN1m1bKlWQLyA33eczwCyQ23Wls5xglSeLMocnjgUV+guGn9hGoM0C9EFDO+6YCfOiNHwVxEZjIG5IUNn8Jjim25UtgRAWwYEK8MysJV+VUcWgAzUFO4foSh9bkD+6AV+tmrPFsqj+7sZcrNevltWWZ8DR0+Yx0E+T8DV/7vb7tltZi1Dgt0pDRNGh7uuFeBQ6DkOZ4CXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKT069lVMAQRzU9nsKMLPA6gzsjFGeFA8wtuDb6+7+k=;
 b=hJLyFsKOSzjauKusfsh+mzVHyUd6owE//cELFANy7NBP+yZSqsoxX1x35rwVhXjqwrL67+YtMkYUrGH9hDclky5qRyBKYCMrTei25vozG0TgM43bgnZYl114ZyWSOIUkexvHGgm/b0CO6Ppj41O1cXowHb5nvEgBpHfoaMLHqcA+w4PXEsdm0eS4PJRCy2tFbNHkIoSvo1/aUQqH3Co1ss1RqF3EcP2cECT0eNUEblqrI3wU8qn71HgbtWbes8CmazVHwFq2HHlm1i4+mkM2q46SvvVYP2V0sPXpGnqp4uPHB1VuuYPVy4uIMc7rnOTQ9/GCetX9l7ZeMviX+0oLFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by IA1PR12MB7589.namprd12.prod.outlook.com (2603:10b6:208:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 00:18:44 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%6]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 00:18:43 +0000
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
Subject: [PATCH RESEND v3 0/9] Buddy allocator like folio split
Date: Wed,  4 Dec 2024 19:18:30 -0500
Message-ID: <20241205001839.2582020-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0072.namprd04.prod.outlook.com
 (2603:10b6:408:ea::17) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|IA1PR12MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a181ec1-ed6b-48c8-51a1-08dd14c260c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H7fu5s/yKE7pvQzQLNo8UOUnSJmN00E227XYceQrXQkTrLx6Q0tfkvjXbp6b?=
 =?us-ascii?Q?blWLc/1f40VQRY12giN8S+mrP/w/TN86Geky4eC3z2xNk0IcuxIHpPziQ6Ga?=
 =?us-ascii?Q?g+0RO8/A3WVEXRtEOLQKUhkLg4dEBOteC77X1qMWh8g0nXKuJbZFIgYQhYYa?=
 =?us-ascii?Q?Yt7F5mlN5j1I6CrMDbSD31YFXIuJ+AU6a+h4hhGxEVYEnavThPAEAkqYTCBf?=
 =?us-ascii?Q?y6dTKRZ+eloT/iSxrqKD0d1EY/87h6WNsUyZX16EOZhrTTW8ebURuHe1Xmfl?=
 =?us-ascii?Q?00DufcSjrtLymjHPXWqQfDkmvuzmgvEM9or5ZdTx2EQBlEMWKFS4K9ZSTMwJ?=
 =?us-ascii?Q?aCWwAHCvwYKVY/N6sjmVmTKSZZVfaO7smduma1AofSpySCvfEPeuWpR2G7or?=
 =?us-ascii?Q?GYycfETCXPQ03+VY+zh9MZGabuEfbUdWffe3cml0vWjR39ivPhAnHK9eta9L?=
 =?us-ascii?Q?xr9asVfiNpp5RGVK53f+rT57wJUD5e2MjLjzJHEUX4DeHs2KiSFC75Dd1mkm?=
 =?us-ascii?Q?xL36GxxyabO2syGp5uIpadRPHu3E6HmVlrG6rwO1i1J+f0V/MlacoGdkrmio?=
 =?us-ascii?Q?kZAopAFDuen3rep8QffqNjZwJZ7vzb2dvTACq4nD+x6tiWNB3xCxYNkDT2uM?=
 =?us-ascii?Q?Xf7ZZZvDy/39e5RzIVgkLx7TjUWUt2qwxpISezC4aPuhvZi+H8w75085PUOe?=
 =?us-ascii?Q?yYq2MqN9sWRvSAhBxKLiVg0CuY05z8QHLlHhJsLHrVay0z7arL1N9gsH9W3+?=
 =?us-ascii?Q?bnRLBnSX4cazKr3cvEyaq9IW/X9s6BMgCCFKBL8OtSHoVYFdON+sj8mx0omL?=
 =?us-ascii?Q?m9ndYzgyjalviGfNeLOMs+xYnvx6urtDjQSTw/AQNv/FBwBl6MARJzNNakxJ?=
 =?us-ascii?Q?f9Wy1GZFvgw4k5iRPkTBoUrGdTb5urivuDMfoKHd8Ly9MaRUMPz/LaYy6v5k?=
 =?us-ascii?Q?fFgGysNYErQH9/ihECwmMDQ5Be0/YsAxMClNwsz9hFHW5Ob3stvt91ESq8fH?=
 =?us-ascii?Q?XEYF9oxScvqBGVI5QQdPJjp7JgtLHoqIzF1lvW34FJbiZNFvgi5wDh8ZqvzA?=
 =?us-ascii?Q?JNCzGjK9WzbWvVX/HsUnI02mBmRuYCA+AWve9mkYmBAUvlwZkQzry5ZVK1+1?=
 =?us-ascii?Q?BEqneG7Zm9Pty4AzUH4TtGFSHcvau9aGgkcaQPDtwSSqrAzn+Kv6TNwtIJaS?=
 =?us-ascii?Q?pIu2f5Kl2rsv+3hAtExthu30BkFCyU1R0yDHrnvc42cNQzpiL7QvvU28sT8D?=
 =?us-ascii?Q?yn/v+B5Im2Gxp6R+dXVIp+t5jERxDAFX5md9wySCOl/HlO46qsqtHa5qz585?=
 =?us-ascii?Q?mJXMMFHBvS0ZQEd2SLVZ/iQx4yQr/c5EExsGrsmFlH2xV1DSuZGzh74xge+3?=
 =?us-ascii?Q?bxDUQv8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mE9mpiIyZt7xqL1ONiA4L6gdEKuJ+yIabfaXceZsLlNFTzwnW2Eyh+EeBBe4?=
 =?us-ascii?Q?3nlqTLcFLEFmiTqXsMPUdaFDcqZIDdpaMUEuo4XTV+9lFZibLaq/JCpqoijq?=
 =?us-ascii?Q?PkK8UzkA6sxMfAwmP2gR0ZkED3MDFwVnojS0gVmEDgV81MqC68DzKUgea4W8?=
 =?us-ascii?Q?g7ezP3yiH2oVpVsJ7D0D1WScKbkVBzIXgZQfAsPhjaUjyIhArftsaq01fNqW?=
 =?us-ascii?Q?3kzCMU6BR3ZVIZTdP+fMBIJmZSgQlwwVZytHB6yWVqEzJweIuCcIRIK69wZ6?=
 =?us-ascii?Q?n5adfXO0dgdLJlUkfvBkQEKpkfNkhK5TsVd1uq7RETJLNyB/2PtnOfZCFRgN?=
 =?us-ascii?Q?RLZ3qoGJbw1DV8F4akgEmq2K4mnvNrhNRbEPpG2HwRSiWKAW73MBTC0rzjUT?=
 =?us-ascii?Q?lQiGFeN4J2hIC5z5WljRA9vfa5rpQSM4xVxq5xIndjnHjxfjkJXM4PA1XDqy?=
 =?us-ascii?Q?2599nioQbway+4kOumPokpg1M0fMaoBrfI1G081aGjpuOplHP3W+L2uIOnih?=
 =?us-ascii?Q?9kRtEzSEYDY093kb+qqKMAd9azcECXHLedfZS/oV7gHgukOpm55n0kfKdSg0?=
 =?us-ascii?Q?mNz4NUsliC2isHWQ+sZuRhyoFICPhG+Fwx3oVi5tyi58CfKD/tmsMLi3SRGt?=
 =?us-ascii?Q?8Xktt7n3t+va3r31KqYHlMi/I9bjzhBNWWZ/0tB4zOaUQdfnljO1UiPB4jsG?=
 =?us-ascii?Q?of9BQlrAHrcJh8/8UwlyjV0wf19F//0nZSFw/0oBpgYXFMBEmQTEFQODD1fU?=
 =?us-ascii?Q?GxF9SVPBAQfFYrPE2xzNSR4B9O22SlC0+M/4sSf3ompYZw2sQCNX18Tg8yJG?=
 =?us-ascii?Q?oBkQxpLZPoselhX4KqBshtNQWc9NInhqklQU9WIPzeuLUlQ88Jjoga83OxCx?=
 =?us-ascii?Q?XeQYp4SQvB5Z4mvHYeCQ3lpmZepfddn3SrZcHg+jgMDbv6NeWoEmhdzaCBgb?=
 =?us-ascii?Q?LV6Dj8P51Ul6vQRgH+1aovfqzZpjkqrcXVoLBcuzm2D1dFhxSUug+QUgabzD?=
 =?us-ascii?Q?7YJMNrjltJI7ZEs6IOPv2i+RXB40QNmciqkjztys6Fhrdqsh99UvYJF9AYZK?=
 =?us-ascii?Q?J4mc9fuI9/EIkfE6rgdcBTvdhlCG9kcXqCc1QoknEXgL1nIP3qdukeJAHHoF?=
 =?us-ascii?Q?XBeiB2kxGvZyCZdQiXl7kHkw3CK+dLN+nUc4QlDdt6Ic3NMEzHX7fsJlM3si?=
 =?us-ascii?Q?Ezim7cc/E9Ysz7WgeFKZEsrxwBXPCLoTDKOfM3RwAascMeS+W0VyNMB2AwY5?=
 =?us-ascii?Q?RVcmr/33bJrHIfqaf70+zx8ZckHernqRGf+UCEAjnlNyWGEDD2eNE1iINqOx?=
 =?us-ascii?Q?pGoHdDWqi7X7mOfzUwJF7H1j0WIzFv/s2vz2oVj53jWHEj6tzhhjJuertERo?=
 =?us-ascii?Q?fyNMSVGKuZL1N8ST6sQfNDujpknAzGtFnjbNC0S6Bd3Ho1wvkSRPB/vQk8t2?=
 =?us-ascii?Q?Jbbdu4R0WEbTdSM+dkD3f3+elr82Ti5JCYgkX0GTOQbMRcc57Dwnbo+eEdyF?=
 =?us-ascii?Q?Dlj6JOHDLGOGvVn01Xx9f5yRyNpGc4Q96ToKoBwTJAY6Agq6cOFlYVf0953y?=
 =?us-ascii?Q?V0KqdCgH3AbXt5q+5t3Xr143PpI9cBSg45fsiRfW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a181ec1-ed6b-48c8-51a1-08dd14c260c2
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 00:18:43.7150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /bpgDIyJJvUnOlpOMdpozpo7UkyRsl+M5ntNZoBnJca/BlEkUItxaR1aOU0LAzGs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7589

Hi all

This patchset adds a new buddy allocator like large folio split to the total
number of resulting folios, the amount of memory needed for multi-index xarray
split, and keep more large folios after a split. It is on top of
linux-next-20241204 and just a resend of v3.

Instead of duplicating existing split_huge_page*() code, __folio_split()
is introduced as the shared backend code for both
split_huge_page_to_list_to_order() and folio_split(). __folio_split()
can support both uniform split and buddy allocator like split. All
existing split_huge_page*() users can be gradually converted to use
folio_split() if possible. In this patchset, I converted
truncate_inode_partial_folio() to use folio_split().

THP tests in selftesting passed for split_huge_page*() runs and I also
tested folio_split() for anon large folio, pagecache folio, and
truncate.

Changelog
===
From V2[3]:
1. Incorporated all the feedback from Kirill[4].
2. Used GFP_NOWAIT for xas_nomem().
3. Tested the code path when xas_nomem() fails.
4. Added selftests for folio_split().
5. Fixed no THP config build error.

From V1[2]:
1. Split the original patch 1 into multiple ones for easy review (per
   Kirill).
2. Added xas_destroy() to avoid memory leak.
3. Fixed nr_dropped not used error (per kernel test robot).
4. Added proper error handling when xas_nomem() fails to allocate memory
   for xas_split() during buddy allocator like split.

From RFC[1]:
1. Merged backend code of split_huge_page_to_list_to_order() and
   folio_split(). The same code is used for both uniform split and buddy
   allocator like split.
2. Use xas_nomem() instead of xas_split_alloc() for folio_split().
3. folio_split() now leaves the first after-split folio unlocked,
   instead of the one containing the given page, since
   the caller of truncate_inode_partial_folio() locks and unlocks the
   first folio.
4. Extended split_huge_page debugfs to use folio_split().
5. Added truncate_inode_partial_folio() as first user of folio_split().


Design
===

folio_split() splits a large folio in the same way as buddy allocator
splits a large free page for allocation. The purpose is to minimize the
number of folios after the split. For example, if user wants to free the
3rd subpage in a order-9 folio, folio_split() will split the order-9 folio
as:
O-0, O-0, O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-8 if it is anon
O-1,      O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-9 if it is pagecache
Since anon folio does not support order-1 yet.

The split process is similar to existing approach:
1. Unmap all page mappings (split PMD mappings if exist);
2. Split meta data like memcg, page owner, page alloc tag;
3. Copy meta data in struct folio to sub pages, but instead of spliting
   the whole folio into multiple smaller ones with the same order in a
   shot, this approach splits the folio iteratively. Taking the example
   above, this approach first splits the original order-9 into two order-8,
   then splits left part of order-8 to two order-7 and so on;
4. Post-process split folios, like write mapping->i_pages for pagecache,
   adjust folio refcounts, add split folios to corresponding list;
5. Remap split folios
6. Unlock split folios.


__folio_split_without_mapping() and __split_folio_to_order() replace
__split_huge_page() and __split_huge_page_tail() respectively.
__folio_split_without_mapping() uses different approaches to perform
uniform split and buddy allocator like split:
1. uniform split: one single call to __split_folio_to_order() is used to
   uniformly split the given folio. All resulting folios are put back to
   the list after split. The folio containing the given page is left to
   caller to unlock and others are unlocked.

2. buddy allocator like split: old_order - new_order calls to
   __split_folio_to_order() are used to split the given folio at order N to
   order N-1. After each call, the target folio is changed to the one
   containing the page, which is given via folio_split() parameters.
   After each call, folios not containing the page are put back to the list.
   The folio containing the page is put back to the list when its order
   is new_order. All folios are unlocked except the first folio, which
   is left to caller to unlock.


Patch Overview
===
1. Patch 1 added __folio_split_without_mapping() and
   __split_folio_to_order() to prepare for moving to new backend split
   code.

2. Patch 2 replaced __split_huge_page() with
   __folio_split_without_mapping() in split_huge_page_to_list_to_order().

3. Patch 3 added new folio_split().

4. Patch 4 removed __split_huge_page() and __split_huge_page_tail().

5. Patch 5 added a new in_folio_offset to split_huge_page debugfs for
   folio_split() test.

6. Patch 6 used folio_split() for truncate operation.

7. Patch 7-9 fixed split_huge_page selftests and added folio_split()
   tests.


Any comments and/or suggestions are welcome. Thanks.

[1] https://lore.kernel.org/linux-mm/20241008223748.555845-1-ziy@nvidia.com/
[2] https://lore.kernel.org/linux-mm/20241028180932.1319265-1-ziy@nvidia.com/
[3] https://lore.kernel.org/linux-mm/20241101150357.1752726-1-ziy@nvidia.com/
[4] https://lore.kernel.org/linux-mm/e6ppwz5t4p4kvir6eqzoto4y5fmdjdxdyvxvtw43ncly4l4ogr@7ruqsay6i2h2/

*** BLURB HERE ***

Zi Yan (9):
  mm/huge_memory: add two new (not yet used) functions for folio_split()
  mm/huge_memory: move folio split common code to __folio_split()
  mm/huge_memory: add buddy allocator like folio_split()
  mm/huge_memory: remove the old, unused __split_huge_page()
  mm/huge_memory: add folio_split() to debugfs testing interface.
  mm/truncate: use folio_split() for truncate operation.
  selftests/mm: use selftests framework to print test result.
  selftests/mm: add tests for splitting pmd THPs to all lower orders.
  selftests/mm: add tests for folio_split(), buddy allocator like split.

 include/linux/huge_mm.h                       |  18 +
 mm/huge_memory.c                              | 693 ++++++++++++------
 mm/truncate.c                                 |   5 +-
 .../selftests/mm/split_huge_page_test.c       |  70 +-
 4 files changed, 511 insertions(+), 275 deletions(-)

-- 
2.45.2


