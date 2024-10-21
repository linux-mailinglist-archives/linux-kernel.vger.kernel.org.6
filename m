Return-Path: <linux-kernel+bounces-373655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39A49A59E9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C69282035
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 05:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C6C194151;
	Mon, 21 Oct 2024 05:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DXdnrwhv"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8AB7462
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 05:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729489693; cv=fail; b=lv5DJJDVBbXOBmKp3K5NO3zU25UXNMWeYptZAmRCGNyAVf2SqmQbsFcOAOl5SDNMuFTt6deHgYgMFQpo0WYSijNPYJbGrI7J+OijeORq+HHKBnMSgBhg10+6ZWfzF95miOua/nvCwkizGm/YZgvi16c/bh/k8UM+NVBDyxubCA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729489693; c=relaxed/simple;
	bh=XUiEj+2HFquZ9XOrg796H/UWQZLLUVizhbxQudCBQWo=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=ZerOxL84/PsVqg72QjvC1AKuyjbM7mgAWWYy0cA23ekcq1J5j7RQ7JrSbkvvA97F2zw0UxOHeLSdLY7B+/82cCoGKJXFH1+0zD449FuCsYPSv+4SY/OZoKVdm4tFvA2BWRse94QvsGpDgr+5uVGF+l0Uxmpg25COvBTRV5SGJjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DXdnrwhv; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9TdC9T2z8J7+U6SsNxVZB3clo1gykqJQzeaY2ggC2x1BKlNL5CFCTwT3gxWebxCw5F3tHdZHiuQpGKZ8p9tVWE6Xvtdi5LkZeH9JdZ+wu23fbOcNvVGjqoT+QZPBrhgWQFHl3cXxzOspmKtUW3eLRpYQucBVFZTdThnbXNxGp4t+12y5Ccw3VkHcPtfCUdl4+rguCeo2rgMzt2k457JzRhMV0iG5NFy48FWV67ynzOs0GX7d9kM1dOy9gYkG3JiWeFjtLmmu0OyabxKqsOQeui2mZtJk+QtcDs6yNIJ5wJYyfSyGx/dEzOvA12uBe5lMNxtZjMw+SzrRfKhvRyWwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Di3Ds/TCdLRufhT+Kcc+vjwk4Dekk0D72TavI6aYSmo=;
 b=mIoNBdL4sajCWIDUIProPGaoHgD51PzPpbQ0dGzhYfRsRQXAZ341edOXZ2mFcDN75+tIyQp+nA5LkVYgHBpX8eujNuJm/TTwNI7yXUixqPAAUYSl+mZM+ZtM3p5CgF+x1gFZWqNDv4g8qWNGCXE0JYvoi5BaCi2oLKjw5GGnU6lz5mP54LIsNm6hYYXahvmwUdFj1MfwYMUoifg0S1L1mSHZFQTv9MJOv7Jfj4Nvg/Pv6a4IT1dYTRHpuuyT7PUxNGwLK126I+YuRLezafVwF9R98n+73vuQk4mKmMCGNJBw9tka/wSqNMSx3QtvjrxwR+Po0WMh3ByzEkSjJkbF2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Di3Ds/TCdLRufhT+Kcc+vjwk4Dekk0D72TavI6aYSmo=;
 b=DXdnrwhvvVwHul5DLN1bc926SdZBL6GdpyZvDZHsNN1L7TZuUh9gJ0YfhMcUNKeHX1uccI64MtdP68mbxVfvu1zcl6pdF+EKSiw/h5wjctFCdoYnywnHDTxw3bThty6CNuk4AlKV52cqYZLey8hvGJHp+Dj/6TyY8GKqMsmjgRdYN3ZviqqvQ/lvDidkDwtHjZmrjCmmZkkSSD6ADekZeJUlvNF69O/ALjyXmcA+V2+RKr3qMwWoDCcC7158ydxt3SwBwVNlH6coD/HcCors6AStO6hYrfyxd27g5SnS2l2PH8yQgA0Y6oaCRi8sAjVpTl8Bk0e1j7eTMQ/vgYsN6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ0PR12MB6711.namprd12.prod.outlook.com (2603:10b6:a03:44d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 05:48:08 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 05:48:08 +0000
References: <20241018223411.310331-1-jhubbard@nvidia.com>
 <87y12ibbew.fsf@nvdebian.thelocal>
 <142152a5-d265-4aa5-b103-dede882f9715@nvidia.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML
 <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, David Hildenbrand
 <david@redhat.com>, Shigeru Yoshida <syoshida@redhat.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Minchan Kim <minchan@kernel.org>, Pasha Tatashin
 <pasha.tatashin@soleen.com>
Subject: Re: [PATCH v3] mm/gup: stop leaking pinned pages in low memory
 conditions
Date: Mon, 21 Oct 2024 16:39:55 +1100
In-reply-to: <142152a5-d265-4aa5-b103-dede882f9715@nvidia.com>
Message-ID: <87ttd6atxi.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY8P282CA0024.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:29b::13) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ0PR12MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fd078b8-7596-4a2d-a9c6-08dcf193f0ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HGW4ygDrUST5XonBcvOCpoWo1931NPVBuWM/vWo4eD9v4nFaBwuhvnJyfQM4?=
 =?us-ascii?Q?HFlMXaKt7G9pMLr+8MK/fNOsKs29qX+ZCCXx5h/lhCGfp8s8t2XKGX5VHS4y?=
 =?us-ascii?Q?rrHLHGavpTGMf0vsXi2V/TV0zgngu/q7J1pqjsdauJhS3G0oO9bShx6L/JV+?=
 =?us-ascii?Q?bJ8zCGQgqbQxYK1oteLY9tPaiQTAyvhzo0b/ygCcTRVV4VuaOEWx8jq2h8Zd?=
 =?us-ascii?Q?zEaDUs58ZXPQXD3gwKVCsPxovK+LW1iLK7qFEjXEO3vlIqq4nvzbgt61u79y?=
 =?us-ascii?Q?Ld52yRsI2Gkpfy1JzxhGZOPV/Gl8bToJVtUxtN3592rkhKdeoSpK/+dJrzKJ?=
 =?us-ascii?Q?dd94oonIYbnl/RKZdI/SPH9gib5B7MHdbTG60T2XBwW/rWrgb2TrNJ4/CLdq?=
 =?us-ascii?Q?NGMTc4c3T9X0rqAX4vi4lMnrZk76P62ziqTzMNgF3V1W/dybyAJgTB8SM5TB?=
 =?us-ascii?Q?esE+jYArxrA1jZYF2gNTjZFSjH48ZWuZozhKKEDilnISUdK2l+g4OZ6cMVti?=
 =?us-ascii?Q?bm5JIvD9XBMZRvY2pItN1Lb8fKNCAxJrwEnU+BEYwNIA78VaeK26aWmOhGs9?=
 =?us-ascii?Q?YYKdm1KOM1J6tfoUcC2leMoHwOvIJWei20AJi7a0wCN8meZBYzzBSCq8f0eD?=
 =?us-ascii?Q?V4F0zq9dOBbLywTVgueLUX6lWIDpcSP+7uO6KqgdaffXuSknjToB0cqAvZ+E?=
 =?us-ascii?Q?lQyApJnpdppRl15C0DrS4IdM+7czf/HKRjO0FGHFNIaG6jkjL2VWyPnYtowx?=
 =?us-ascii?Q?u5zZZ7bUMuT+XpzZ3M9A9BXdOOziz7yVc0uePak0LNwpIKd10yRou13NN5WA?=
 =?us-ascii?Q?G2vys3L9To3opmoWBVeqdgxkqn545yx+JvUZCur2iBQFkrVvyVsqefQLlp4h?=
 =?us-ascii?Q?VHELgUXwHKg//YZVhtaYIWl7nyiWB2CkZwXDX16egNH9+afF4J+WsyhshIU2?=
 =?us-ascii?Q?fnZKGkqMVc8rBhme3nsxmtPVo8JMT/oYAY7xBdvJf41Y3s6+ppIVOCBK01Sr?=
 =?us-ascii?Q?efLXU88jNNK1qY2UTXkoRuC73/h7jrLyPfabXmcNnJwyjIQGAsfj6zurRJ7m?=
 =?us-ascii?Q?wQ6M6YltLT6//vT1oh8kz4gZai1ggm7NE2fQkdtP0gxIj3UK5i8Xap1Qjjsn?=
 =?us-ascii?Q?2U6BCrAuTaCZKLcZz5LqZBA2xu1rJD2pvClk82Sl3ZX08zCeltRuZ6lg4Msy?=
 =?us-ascii?Q?ohLcflbfZe487dJKYXdvJZPGDJSGqcW9VmdlagbBqmn4BBaGq7/3HkIVIzxJ?=
 =?us-ascii?Q?aZwj5qehzZewqM7aMPqaaxJp5IEzBFkdAIG6E1tkE/BJRLmatuGO+ig/5ozF?=
 =?us-ascii?Q?iOSEBBdgIBfrn/zdcTvYB2xX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VGgTXPO0RlowAVEOy6aDQHzcDXLJRaSizevD+gG1uqqRsjMZi/Fpj/qDBKzi?=
 =?us-ascii?Q?TduDq0EB1eznRuk6sFs8C0VZz1ifiQbMmfgL+n81oUTTQKUNL+z48uyyAdeC?=
 =?us-ascii?Q?r1BVEm9aY693nwGzQGf8ulRMCbiCPrsM0u7+Gl9Rc7NzUL+6o3w4J3lsg+ag?=
 =?us-ascii?Q?c9+WchxGCAv8nIydIGD/3eKTpP8VX91MJORfrHRSfr8BhvZul/C06oP8lm/w?=
 =?us-ascii?Q?j+dp0S2cQOKdGoFtIWBFz6xRq4OCtg3ggq/JCsJh4vrFfQDv5nvAXf7YzL5B?=
 =?us-ascii?Q?RoLxmzvTI542rF0DfMNbfymLjVTxC5PXR6JkH3f4m4YfGFDgi4tUyWDCFzK+?=
 =?us-ascii?Q?OmPXwMQCSOKUMTSyo/LCXkL4DUGQrI0bYZvzTmuD2WgqHlwXIpNqY25vcVkz?=
 =?us-ascii?Q?xxyo3jaYFLtFbb+ROElzEadZEMo0c4YCg4e/F2JE032edvJC4Lcp6/gKg2Ji?=
 =?us-ascii?Q?jdYIqLWkmkGAsfaoikxfPZckZ/nyW8x6VOv/T2zooEIWLDGJLgkoB/PqAisS?=
 =?us-ascii?Q?CsEBVTOrD8jVtjFpnduA2Z98Co3o2tA8rf4aHU2jDPrDw6B2v34xxAhsGtLa?=
 =?us-ascii?Q?8GHBy6IVS8qWeAItlQEfhPNOIMInCaMcUE9epNW0+rDaS/aCy7oScTzkLVA4?=
 =?us-ascii?Q?DlkfrTSy3koLGvObGjhHkO6HDC1nrWcnpLjBwwTSymfgdGdVS1nd9gjer4Dv?=
 =?us-ascii?Q?fAC6DPW0KZUxXkZXgyuslvG62lqvjwFrFLg4SrEiyyN+CVH/+TkK2/CGEpeX?=
 =?us-ascii?Q?dqH7LWgFf9GFirzI/PbviRkEV/0Y7nRedoZGOjdW6cxBJR8riTfFd2zWkmAq?=
 =?us-ascii?Q?LQkCoPsavrPDKHITty9zasnKndCMcSI1LP+c8V4f0jSV03PNXVI2MIMybbLX?=
 =?us-ascii?Q?zcoxcRZhLFT2a0be0XfsPSuRsGgIU+Sz2JqdT0HH1vEmV9QFO6FAr412cPjw?=
 =?us-ascii?Q?VZ6pBWdHOC9NgNMVr5l9lvp9zuW9jJFC9ba2venOMjgHtFzJuUqG2WfbA31G?=
 =?us-ascii?Q?1VhHW8caFWyWVTRX3ftpzH82BItpzxUxBLsNfayoAKoZJhVCpVUVFgUyQ74y?=
 =?us-ascii?Q?MzmT73DUWnf9r49ZRohB0nqI8QnnZiHwJlyDxV4mFu0BA6WrHnCmBMOqhZKn?=
 =?us-ascii?Q?7offvsiyHf7ei6jGFbKq8tjbN3n6yrEgyb0xeEPB1nBHyuT9iyd/4LUPsWW5?=
 =?us-ascii?Q?exMNvCWNuIRBje+USyL/jZKMAJByQFM05kQODX8ygexMBSmbDex3ev5uVQ/c?=
 =?us-ascii?Q?vYkq3POJeu1y0+VkWB6ki1lXGy7+qgXjcf8nwbHCg5jyKJjRcpoX+JBzjyxs?=
 =?us-ascii?Q?RpFrJ6YhnUmYe/XTx1qrsjMp503Sp58PWRauU9dxAmqleWBSGvpVkttNcACU?=
 =?us-ascii?Q?CnYJANqov9TMYxfEZX3xnaczbmqY/aVhE38EbJUxePlOgok6Q57mezDTRdxx?=
 =?us-ascii?Q?3eG7r4gpIRzwZ/H4Huup05mQ+Uvz1YrnYN2ZgqlTke+9fTCeXh6pkVPknruc?=
 =?us-ascii?Q?IFN7PfMM6sMtkqYkilIsD/L6HQZQ63sjfJI8XGkSo48uZs/L+4eUAJcEdwll?=
 =?us-ascii?Q?FVuptLsTFakYkt/pwzrQj8aJss/vT2qpgqQUXnxQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd078b8-7596-4a2d-a9c6-08dcf193f0ed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 05:48:08.5832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lB5LKH1IXjKROlZtiTom/XL1MpuRuRNJH4zY2zsO5loLLAu1Ut6N0FpJ0JkfWW9Hn5JTurr2dSQMV9J3phJd8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6711


John Hubbard <jhubbard@nvidia.com> writes:

> On 10/20/24 4:26 PM, Alistair Popple wrote:
>> John Hubbard <jhubbard@nvidia.com> writes:
>> [...]
>>> @@ -2437,8 +2440,10 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>>>   	long i, ret;
>>>     	folios = kmalloc_array(nr_pages, sizeof(*folios), GFP_KERNEL);
>>> -	if (!folios)
>>> +	if (!folios) {
>>> +		unpin_user_pages(pages, nr_pages);
>> ie. Doesn't this unpinning need to happen in
>> check_and_migrate_movable_folios()?
>
> It already does.
>
> check_and_migrate_movable_folios() calls
> migrate_longterm_unpinnable_folios(), which unpins if errors occur.

Right you are.

Reviewed-by: Alistair Popple <apopple@nvidia.com>

As an aside for future clean-ups we could probably get something nicer
if we reversed the process of pin/migrate to migrate/pin. In other words
if FOLL_LONGERM try and migrate the entire range first out of
ZONE_MOVABLE first. Migration invovles walking page tables and getting a
reference on the pages anyway, so if it turns out there is nothing to
migrate you haven't lost anything performance wise.

> thanks,


