Return-Path: <linux-kernel+bounces-422444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D65F9D99BA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF83283698
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E4B1D47AF;
	Tue, 26 Nov 2024 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FROfX+c1"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CF0BE46
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732631893; cv=fail; b=nScsCqCdASbPN83svklWRO9BvQZ9TGMW1N3+jDaNNYr0Jwm+XbKj+XHKg5X81IpUd7AFxzhGxmv4PqHvaA3e7LO4yaBPFr//sMM09FVtRSA8/ItyhrtCVDr8caS3Yw1FoOxPM/ZckN4rah4oNi7o0mt1zIbAef/6VGMF81EWkEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732631893; c=relaxed/simple;
	bh=SUiTsWsGqsD9oK3oP/HM9UxljbGbnA6oWs11eyGz2/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sQBwyfDg/c1wxt6iYVvSGxPR6Zi/Ay/hdh1LQa/GV7OAbbCUXT2OiW96IUZwxn9vxOgp0r4eHtPCiYXvo+WI/83+bIXd9AT3plKoDVG5je2lz01sNikmsSW/p/k+6eMT55KmHVT8lxuTNfmQT4wOAHXsnNLY68kpq4D7YjY7EhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FROfX+c1; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMSLvsiyCXNAfj/VDKEOJfZE1X+F9YTIIEwRPQKr0w1HY+LnV4d1q74DGwPg9EkwjqhgDcxnv13lpPRUqeRm5IsPxeuLCOE8NokN7pLX6nU16SdSlfCxrXD92gWExBzoLY0l3bqZ2Z6uiGbUvXfkHGycO/m0Mtx5nxwbE9miK1Kd5c4IGFYwnY2OCcTxFpWCMuq5c0UqaQjYURgZK5aDUNKWRipChXSvY6Yxv7rWEACmVKaw5qvl6M0aUzSOrL21UgH3qtJjjG4qVf688Wor3OusZ89QbgynmotXIGyCPWeJ2/OcLPgl1LH7Jm5biOJ7BEuxq5+p2xwftHLoueJ8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3sMW7dOzeT96ZZJs2Lq8mha0Vn6R+Yvq+ri8vwINDo=;
 b=UK10k5/tBWNqN14W7aO6Y9Fj+fzZ12Zy3CNGVmo3KRft3A8UgrH7HA2pJh4Qty4QgqaWnccASQzIg0KSRcbZqUUWXIaLep+igjq+BnSbPRd2x9JhF0++gpAtdNpNzIblx82FeCZD+j+MXzilGoSByZT2gHoaapCpTgTyBbcs2Sh5Om04PiixEonjyN2RSpRcWtNQ+cdCXKzHfCjEzfXiTaVFkETfBO+wxNdeK3tb4aKQhQgjZdLUpWjYLUV3qalnfJlkWvGTWqSzZDtI+WvuJS54Tg5Y09F8O3F/4dQ/iFFSHXSaL/HR3D9xibf5f1LfbqybVtyaj39doxanDL94jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3sMW7dOzeT96ZZJs2Lq8mha0Vn6R+Yvq+ri8vwINDo=;
 b=FROfX+c10X7lOUo/HP82YBUxANAbkd/haTEm7JctuOFB3c3J7OVyl9Q2vDoVbeGLiTZ+oWv6vBwejI7pKG4XyUdWtycBkP9zP/KRLDTgZGTfGYDW6kNHlagq+aNsn2wm/9A9OBWTeIDNS1Q30NtbjWpd6bYzcwdFb1hd3JB9w+skaq6O0i4Pub7eq1GCnnVsQTG8jwGezijZRwAUwl37LDCjlg1+D2GbbYgiPF1jTKpfoheU6DMUOn1f80zRUv20GkX6b3yhxyRV5BBe7oNt/N8CDWzXJzGXPyq+TStZJ0tk+6hiIM5w6Lvt4v3GndbaXME9RpojXmlfTcIeqe3eHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PR12MB8280.namprd12.prod.outlook.com (2603:10b6:208:3df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Tue, 26 Nov
 2024 14:38:08 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8158.024; Tue, 26 Nov 2024
 14:38:08 +0000
From: Zi Yan <ziy@nvidia.com>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH] Removed unused argument vma from migrate_misplaced_folio
Date: Tue, 26 Nov 2024 09:38:06 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <DDB8CFE4-D53C-456B-847D-5190053FA478@nvidia.com>
In-Reply-To: <20241125075731.176573-1-donettom@linux.ibm.com>
References: <20241125075731.176573-1-donettom@linux.ibm.com>
Content-Type: text/plain
X-ClientProxiedBy: BN8PR16CA0034.namprd16.prod.outlook.com
 (2603:10b6:408:4c::47) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PR12MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: e29ea3af-2cb6-480b-90c8-08dd0e27f20a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PowVVNuFzrlDk0Kb6ouHK88V5hxo/y13eIMUQEVOQHOJrd0vOl8G9krqzGRL?=
 =?us-ascii?Q?nAJvzkk6DD7BGk0BzZ/jzNwJH8iC6BVHGDe0aJQEM021Zo0J3HxOOCg1bU6h?=
 =?us-ascii?Q?auHWHWLQSRdUyXGxFAXx+zISRfX0tfAbpKQgUieDu1slIIL4N/rOgqU5NxCo?=
 =?us-ascii?Q?7ghskWO3FxDklGJsOaQCQ5ZZpxvTJStfctWzz5MZg1vdt3XZpWjGh190Iygj?=
 =?us-ascii?Q?JUBo2LyXR8o+cEafY0MCRv7M5MzOu2qOlPlUzkHQk2dvJOK1osffJfV0/EZK?=
 =?us-ascii?Q?PqoB9t5fmuGM+/IR5/nUt1zvTUyUxgYs2LJqFXtE5Fpx1x3CNYfGRSeneiqd?=
 =?us-ascii?Q?mxACA30Xt+zTKBg7+EY5lEu8qWfz4OT48zgu7YEUL8vlSF5jd+G4mrOXFXIM?=
 =?us-ascii?Q?kFuygjGFX3PCDt79q/+jq+UnBdx1kMlwj0YBRA66X55Y0TSnveOl0lYKsQAf?=
 =?us-ascii?Q?Pb1q3snD2SyDG0sE/goROMAsmJdqgZIcdEpta4czyBnExjvjrZVP51Q0xlXG?=
 =?us-ascii?Q?ix0XqOH35c83DN4hm0UF6SjX/yfwzMLdxHBp7pUuYoKLdEpyqZgiD4uDdkC4?=
 =?us-ascii?Q?0pLqOVxo4pzAt3U7MlnJupsgm3J1qB1fob9afB45Y8A2WUT9ErF85Qz8Dn9f?=
 =?us-ascii?Q?nsxvaX32rKwQL6mVNlf4XhA8lhPygqQIFIT+jloyTpIlb2Q2RNP9HzDr4q0s?=
 =?us-ascii?Q?Owj/nlJCAiwy32gXDuovzbj4DifO4/ub8wtGwnuIo6ebnuidPThlod5HObMV?=
 =?us-ascii?Q?+xoKMA/JU2JBy4SN50sREnmHj/leME2+q0bY+Uf27V+Wgck3wxX1waDkcP/t?=
 =?us-ascii?Q?4LYoZHN1PIxpWI9gnB+8Bq1eQhFESLlSPZ4pjyneErcz9yoDozhhaJdnyAvW?=
 =?us-ascii?Q?VAfBTF23Y024B4+AnoyOUECIEG2G1BBc6tW2G1YHjtfEQzkxTdP/GUaqAYVn?=
 =?us-ascii?Q?cIpXZH1sVQMiJnzHVVbCc87KuR7rtTvlvQ6uXYSr1oIQk3jIduFv79o9Mo79?=
 =?us-ascii?Q?xY6LtUhkmVl518NGfO8FchJd9AfVh4AlMXnnu4XyDll93cSMs8dKJ688SRFs?=
 =?us-ascii?Q?pMkotuPkdfORmhtOF68uTCEsGnPWdnFddhFmooukWw/YRC6Xb8YVSm3P5Y8Y?=
 =?us-ascii?Q?vSVnNynfPrANvzb1+q90UMjFIu6Waz43EjNJSFEF4PSuBknCzvw7tEnW1zIn?=
 =?us-ascii?Q?zrIL1oj2GHKsv7H2LSgdS675lthdxLttLwQt+vBG5wF+DxRl918U4VCfHQFM?=
 =?us-ascii?Q?czWgmPAM1gqYiZ9Jsj2/UHUmB8tZ6ebyfj/nXLqU0n2b5e51wg8JSKrR6JqB?=
 =?us-ascii?Q?k6A/pUw1uVL8iyS/SgpHQ//VDxjlak5D4GhQDFKwKCfoyA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?te+hBx5JyhlIq9w5wKbthtqMfZ4t9crmrYsBK8dzQ0+BRSnhUGXvdSFpwC4p?=
 =?us-ascii?Q?gO8jUIxV/C6sdrnhmKZVP0AbhPATrCkJmlnWFaIE4yAm5c5JvskSb0TItPD+?=
 =?us-ascii?Q?F4xDtDmqXymfBKwv9NJq2Zqem+pF+Z2fGnl0bdQ7/ax2fTF3W4oEYd4wXuVe?=
 =?us-ascii?Q?8V63zaYR5Uf3nuuTNqCTfNoKdRYqa3prqkgiO03M7msg0ydXld8eH+SQUl/R?=
 =?us-ascii?Q?GPMEwo2PB3Uxb1LzpxUo+mDxrxJHR6MWE9p3TB9WSStF+OggC1HT3IvzY8YX?=
 =?us-ascii?Q?AkSW0jW6vBK/YgiXaDx4CYqa7llLGEHZqbzmRj0YNne3F6D5+w4EbNAuFhK7?=
 =?us-ascii?Q?x3Dwq9S4gLl7gTb0pMkkl+C8ptn/eLgxl7+LPc80ytNQPnRowY5E92+7Wzpy?=
 =?us-ascii?Q?WY066ACnN1EnD/7oLfkFNweXfbGAGurdp0GOjcPYCaB98e52CR9soYURvAYW?=
 =?us-ascii?Q?SG9wLoFWIaJ16XEGyrx3uL/iWstr8ep09UddUvdFZ1vP1o2EJpwq+bHVKTrJ?=
 =?us-ascii?Q?UlEGgaHdofNUTGDStcretpKsoCtxJ7C9JV63a9B24uQ0ZSyQDolmLDF62XlT?=
 =?us-ascii?Q?gK8qS9U2mDz9VrH5lvO8Cn3wWInlfEb8VEOJOsLiPfzwjXmpr+AB7Po4X+Wz?=
 =?us-ascii?Q?N4HHL209h40pMrVSl6nMsGEYGn32l3xizZxPPtt6yIdPmKlWfdHBZ2nQ1dvC?=
 =?us-ascii?Q?kCjyD3qszucKyhy0O7I/ytZwO24atLJWDG6B5BxF46Lm9MuOF15Biyekraub?=
 =?us-ascii?Q?kxNQEpHJOXK2wk0d9PVZniu5/0RDta4887Q36zbie6oOqbWtT2UXtjx1DoYq?=
 =?us-ascii?Q?AHMBEH8QTgdWtRp/H8Gvzit6DKhpbxQfm74arm87ZLBYWuof2vf/wtXsGlp3?=
 =?us-ascii?Q?aSUnLpuvl6SUWNiqKKzfJBOUCgYnjgT6oJ8iw8/6fotrAJgfeVU8/P669CMR?=
 =?us-ascii?Q?OpGzvZuyKYyITUYmy6nJCcbxE4ECP9GR8rDLqBYhbSLz849bHJ+y8xeBZ1tU?=
 =?us-ascii?Q?i4rPIClCVGhHnhAFPURyAY4iE05vJPGOhGh1dqTkhrMneAFT0Wq9v7Gpaj12?=
 =?us-ascii?Q?SKUrwLCIjwNPT9MP5dARTKcLeXkaRb0z4n08ZGjyS5dnH3U9IG8zrOQT/glB?=
 =?us-ascii?Q?ejbI7i7CUQotwSGHKwjZqY2NxV6O2fXNqzTgiUXp6oeZ7rh013Mi9vMCtFlB?=
 =?us-ascii?Q?xMMpOiZwA2sn3UvTNE8QuNyqsJgrfaMZt9HDIg+wckGeqjQua4+Yatg9eIJ5?=
 =?us-ascii?Q?a8bFL1QqVCW2080u4WlL872EjIomI3EaCZrMjSoXqeqLYtXWT+pK3L8wRrkU?=
 =?us-ascii?Q?k9TmCk7RFUunjLbampKFanQ36EyZFerBe1pm/yS5t+bBJyO3d21yowg4voYe?=
 =?us-ascii?Q?rsRX8pGy4PK2YU0AyRKJcaHTQndqaioNTgAA+4I/0+0mHNhDtaV3WfbO1/aY?=
 =?us-ascii?Q?wYXnxBlkT8CBDkAks+zKdq6csQ4snnzz+x0tTd72QTv4yJ3CAHYfCr+oxtMe?=
 =?us-ascii?Q?rHHh9Uu/oYGKRYolYCMgQ+npRbMxafHKLeDLr0WEGG2Y2OsC1+JxlTmQdROO?=
 =?us-ascii?Q?048q+7bERKAOsO/DjPQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e29ea3af-2cb6-480b-90c8-08dd0e27f20a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 14:38:08.4807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71H4lhtLPa9+WTM0lNGeLfS95gC3H/I6kYHXFq7kwV3wuJ5NLJDtA522HfLjFHfi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8280

On 25 Nov 2024, at 2:57, Donet Tom wrote:

> Commit ee86814b0562 ("mm/migrate: move NUMA hinting fault folio
> isolation + checks under PTL") removed the code that had used
> the vma argument in migrate_misplaced_folio.
>
> Since the vma argument was no longer used in migrate_misplaced_folio,
> this patch removed it.
>
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---
>  include/linux/migrate.h | 6 ++----
>  mm/huge_memory.c        | 2 +-
>  mm/memory.c             | 2 +-
>  mm/migrate.c            | 3 +--
>  4 files changed, 5 insertions(+), 8 deletions(-)

Like Baolin suggested in another email, "mm/migrate:" prefix should be
used. Otherwise, LGTM. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

