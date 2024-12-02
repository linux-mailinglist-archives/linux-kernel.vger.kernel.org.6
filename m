Return-Path: <linux-kernel+bounces-428144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D9F9E0C2F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B215B41833
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4261DD9D3;
	Mon,  2 Dec 2024 18:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cuYvEHEH"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE1170814
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 18:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733162993; cv=fail; b=KkKEfkWZAyBlV24zEhO+rjQBIR+hfjZb6WtvfT9PZM6to0V3DGYHw1MoQnmMqkFxJ8nLvDJL1UOp2FHmb7L8R/YxpTadqbaHbMFSHSgVx1gnoVv0NoDDS8MoVjNnZzuRfaloOhnpIe1aR/Nn9mXZyUEMP81H+fLoitDtNINdofk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733162993; c=relaxed/simple;
	bh=dIIhWjlDs2it5gtba9oM2QPqdhU7YsgqaPgXxN5CcTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qA4mBXF0oocSMoegnYLenrkjjTUoFUCe7DqWsJyyOJtoMJqrUYBUPWu98yuMD3o7RI2HyjheZh5SK4htUz4jlmGaOyM6CbSU7eUtq4KkdaH/8d+L82yWvbi1utCAmwVrZulgta57zhJ1cy2Z9W5WC3FH1DIgrmG7SAYfDQB6JO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cuYvEHEH; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7Iyv3v85plsmk1DtxWG/yqDUuAhtSVCAmewaVQbYyCMbdl2FCWQUHqaH7Ff3BiMknCNwjvyvFIT2lJOVtAM0HQKWLzpoutCc00r3nogen4emN6IUu3fUtmM7VCt4bQycA5Pm7wMnRF324Uh1krqC625V3N5zvDFW9Z0xn1GODLENKl9+yr4kb7hwEelBmJEvtxDrpbyz2MFkRNADfLGoXoR+C3JUOGuLQ5U/ciI96weP1RtZnZ+GAsvUnk7T6sgB0a6KiP+nUArEi8R/jbTn8htAhfB/mR7jzRNPtkxrL4ECUX7HlSp6a0lhwzXHRfLEqni3tJWn38PxmPHwknKqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04ee0vcdiFUnn/0/T+iJTZf4nBMzsQqYMcDPx90VF00=;
 b=kXcPcOb2jra0trczBJq934mCanU0wGNwFjFb9fcaPjQbVblD2jp7ZISdPhj3RRFQpz32S/588X/+pXqqzbibuH/VQWt1usu6kHWrxfZ2vPqRXGxcvMIuhHsLvsT1GRTh6Rb4WIMRhpms/nbFU1pprKIauROMb1OTmBhSsx+93RJxjfaqEZZ9WI6H5MiehoUGCJwDdw4QHpPpN3YiMAQOLsXu42vcCPUt9/W07Gb2ry4Aw3hG5Yi6rJlYYmoVlHfwp2zO27VpxBDfQjTgXDRqCW0EtuI2IZtL4x2pWj9N2wEYHjIHAR+K1F+K2T414sjFGlH8bPythrnD4A7VfZLS6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04ee0vcdiFUnn/0/T+iJTZf4nBMzsQqYMcDPx90VF00=;
 b=cuYvEHEHNO70lSZkMazgRF8bUKLhHOkBddTNKOb9n5GtUyMMHiMF3SmXL8E9jWe/G9Jz2eqiJ7SNur0qwciJb8JbvZct5GoXU3BM6CDHEbBTDt1yHq2c0+wc5GNVS2xnlua9bkFwZ+Z5aM69qXI5NelYnak8L5lsSbLS8nbiCBynTRi3x9Ub1Dtiru2VuJRLSwrbOJPPaTeonr+jSUMDpNRW64eDwr095i7B0Tew7ON/SLpAp0ycqAaA3Xmr+fBTITQzu68GDh26AO2a0mR+zzMsD6DG86HNp8SaG/GgmnyGmiOMVzUEeBzHzRC+CbBpWZoJlC3p1hxgtrZiqoVXlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB7912.namprd12.prod.outlook.com (2603:10b6:806:341::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.18; Mon, 2 Dec 2024 18:09:46 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 18:09:46 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH v1 2/6] mm/page_isolation: don't pass gfp flags to
 start_isolate_page_range()
Date: Mon, 02 Dec 2024 13:09:44 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <E0CCD7CD-DAAE-473F-BFD9-609B169F07BB@nvidia.com>
In-Reply-To: <20241202125812.561028-3-david@redhat.com>
References: <20241202125812.561028-1-david@redhat.com>
 <20241202125812.561028-3-david@redhat.com>
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:208:329::30) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SN7PR12MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: c481d164-958e-4e1a-2fd1-08dd12fc810c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LDMJHiwsyY9Un48KwUU/WDW5XmxL0rjebk8ykMcMvdWZnWGFCIkLNKOiIBB1?=
 =?us-ascii?Q?k+17hb53vSuLR/i7wIM87Zv6kEQVjhEnAst/G1aLIqsPe/Xx9NtAYr3HKJBf?=
 =?us-ascii?Q?wbSpBVsZ5/ECLuZVo12D+NqnrMZMXGfTWogmMqJ+zRgTJhSYYPbaXWI7gST9?=
 =?us-ascii?Q?K99vBWKmsGKkQh71eLprHksNUuLpHQVlZD5Iyd+5nP8bitCDZ7DUTWcvxkjD?=
 =?us-ascii?Q?F9LSUTegV3KirEqbTuPzxXnnyxoNk920qOa0fpBTWZh788Vv9CciMSq2mI7T?=
 =?us-ascii?Q?wOAlar/S4YcRQ0eha/6ueRuXPlNInJ8yZsK+wzG57Uxi+gnK4U9CacDacxoz?=
 =?us-ascii?Q?auFk2axLbDhDLJy3gmQTujUzQHOseJGE3xiOD6PzLQ7Uy0mrnY9UWypNklgC?=
 =?us-ascii?Q?yTas7f1XQ6de0fUts2L7cLtiTgAsTN0gJgdkEzD3sUHgS/vpHeYTJ9hpGS0k?=
 =?us-ascii?Q?aowvUdf1Pk3S48d6VBgAUSOHEIA0XKjI+Aw2EXdvgfF9lPowtMN1s6375kae?=
 =?us-ascii?Q?cRT5OnPw5Pw3GzOWAJfFe7Yu7DZdKzn3gcfNFRas7LZwTXLDclX+5pkwrORK?=
 =?us-ascii?Q?d7FsPXZ55s0rTslvaS5xqiv3k25aFYdUPTLBi7ZzW5JM2Wdwl5QJIKCXYw+r?=
 =?us-ascii?Q?ioJtgC+mQ6gTTwufT088N1SFwEoY1BWUimzU2fxHlId5iVxs5abzKC1pMEp9?=
 =?us-ascii?Q?9mi0TfW0ftpZlLz9FS8LgcmcY/4vXeqXjF+CO+vjA5l0JGg2KfjmKi6+apJn?=
 =?us-ascii?Q?bENUGCbxHH8FnYkIWDYoLMnpanilz4bnvVOXRRDX6NzYfZFNT2fMF3pcbqP2?=
 =?us-ascii?Q?blbYxa9CrzKJ0Sbsbvcj983WWjIq1ubSUB+tdb3o6lBThT/Mkev/AVb8qDGK?=
 =?us-ascii?Q?cyN1J8uLlgh0Z8gZqw/qHr42P3RxjDbNzV3UcZzu7mlBpTEI71D3vdf+ZiyO?=
 =?us-ascii?Q?V9lIKd+DdqFclN1vU654OXfQWmeWo/zonKTC9yNB7h8SeTpIVYFsz8qpOWgZ?=
 =?us-ascii?Q?iO8vtotkqIpdI1aaiz/UDQTv+muPhlMrDNQ8LD/fvMzsnp3nEwnB0nY5Ekzx?=
 =?us-ascii?Q?hPuvr6vI5dq6SLGhd6UT+PBOekz+jZw56n1DOrdt5EqWW1wmhK+GsOA9UlxI?=
 =?us-ascii?Q?PpM/n3W9cfahAd/5it7npmGHbUFqUxal8CLHaww6z7YDFPc+qvVOLgFUjRp+?=
 =?us-ascii?Q?d+PZOX800atTjArUE1DWeLEzuxOd96HMtML+oC7K9MINn3n/4wu7But4l+4h?=
 =?us-ascii?Q?hx5IqWlEEPK6QSN2yKzmaSpsVCqi3fOXN1vO1em1A3lIh8Q+PJGlJ3HsRboV?=
 =?us-ascii?Q?8JrRCBvEIz5N8Atc/Ct0tT9H9oAwChYjIt2rvFNG/xjzrQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J6k89bTpY+ddKFFlwUau4IFDyQbZWRtbx+eqCHtq3eH8QgBCAdZ4/rzwc8Ex?=
 =?us-ascii?Q?qUHkX/PbdqH5pP7uaMZZca+DHooOpIFlJkWAB/RloXmdnC0P4ATl7USYNX8K?=
 =?us-ascii?Q?R8CDtvjrF8qgihx4dAWw40Cn/v9gptihLp4zKX9t1ZMZfpKsU/Sm9nE25WF7?=
 =?us-ascii?Q?pkYJrksHw52w3g/UphQsoBYUiRMPQwK+yqARiLNNh7jwcyAOMcFMiaupZy1O?=
 =?us-ascii?Q?qG/3qDT1S9YTpKrkUQ14z5IAvnhoPXqUn9NYxKwp0KpExYiPAMTP1vdt6cF8?=
 =?us-ascii?Q?2vTWfdO4+Zhsq6Xg435GglO69snBNI+zdx9fLdFuuSZPLO5iCv13I5kXca1E?=
 =?us-ascii?Q?z96kIa0agCy/LFwYT4yiatZVafVnSGxLgY/O1tui5rX2jX7Bzivd2TftuWrn?=
 =?us-ascii?Q?3Mip+Sp+n6TC76Q/lr5LCvxHkKZBIYEYf5zMDqNouvFpDw9kzI1Ix3EzzJu9?=
 =?us-ascii?Q?iu4Bkm0hYoIC+n26uy5ARJ3ZtTh7Zc6aai4zrjElK8Wp+0ZZT5Up4eLY9B9/?=
 =?us-ascii?Q?P9GmpKG5inG67gfHVk+msLU9Qkff79i/+CalJYsmILohz1jk02E7P8jOye16?=
 =?us-ascii?Q?NuG+z6zQJoPZOzZmdOeZlefnk61HrLeHUw5ZCoHDB6AWbAhwsPSl5LL5SFgd?=
 =?us-ascii?Q?9Osl2igVQJ+JHyKOqtoiQoyVCZ4tAmsp6aCyyPYTOsMgU8nmBLeGJLihOxrL?=
 =?us-ascii?Q?aRa7JXXMx9aow/u4ffqdLlUn2dNMPfiZjS08tn48w5jZGa73MwZoa8LJpxY6?=
 =?us-ascii?Q?4jN9rtXN3296sC7yqK8SsdZa3HEdUDCgX9STI5gJLHYWroqEfbuQMemk10Oc?=
 =?us-ascii?Q?vihbbEQeKJfuGlskaSVEkfHVIz/cHJYx9mEAthpb1qsTINsBYyrg05+7cedV?=
 =?us-ascii?Q?qvgI2UZQFQfQqmjoNBO7/Yd6MMIbdMtSoY0iRaeBTO4fYuHv/fKuy92pUact?=
 =?us-ascii?Q?I/V5YUwLOnKZfqlEw351/xdOXD2IsZa0zDIGeflANNtU8KMzS5Mxe9Ui1qNA?=
 =?us-ascii?Q?2sIICtg/j6wX/TckITF0wRTQ+goG61/u5xFpLNBg7wscbToj4OR91n+d1FgV?=
 =?us-ascii?Q?rYf6+CkV8QcDuSkiUiI1CC2EtZMKOt7bHcS095LUD8tFrX54EqaPF+7eEV5T?=
 =?us-ascii?Q?AtoTo+kD+/krhlN9RKXGDiNSgXOHe1n4oGO5+Kh7v5SFVUumO5cs18v3/dVI?=
 =?us-ascii?Q?1qaPWgrWB0/9GAxLWTTD0PEmzgLtVjjibQTuJRpvMrdBNuGrP/iMnSSYR2Dn?=
 =?us-ascii?Q?+jlEv4gneFz5YzqDOIQGHNxhoGQ6apxnrQTny1/f7zv0Sl7kBnUTW8DHJQ5h?=
 =?us-ascii?Q?CIrBqOWdLqOj8pfaix7JbM+TV/OwQZZQdxdCycd7yd5YK3hL/I8R9KYrVwJ0?=
 =?us-ascii?Q?dh5zyUTMhM5T6WmHxg2x1aH5FTtAhr6An//XTq3+2f87wl8TJ7pQ5RCtj/m8?=
 =?us-ascii?Q?thqzGkNARm88kYstpLEbvC1AFqJyJOcmGe9XyPUVSYG+axxO/Mk+ktYYuA/D?=
 =?us-ascii?Q?ixsFcExZzR/5boMBL2Rtu1QMuq7Ml+Yezumn0lR/4E/HsUnzqx/V55kcw5uH?=
 =?us-ascii?Q?HqBp3cKwEHUevW8FufLazaq762tLjpT7n1fXxy4V?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c481d164-958e-4e1a-2fd1-08dd12fc810c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 18:09:46.3573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rN4bnBvhlg5yf0wkntfoCzAiJRztT0Pft1WEnIfHkIpUOzmACPd6P9No+jReRwXO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7912

On 2 Dec 2024, at 7:58, David Hildenbrand wrote:

> The parameter is unused, so let's stop passing it.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/page-isolation.h | 2 +-
>  mm/memory_hotplug.c            | 3 +--
>  mm/page_alloc.c                | 2 +-
>  mm/page_isolation.c            | 4 +---
>  4 files changed, 4 insertions(+), 7 deletions(-)
>
Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

