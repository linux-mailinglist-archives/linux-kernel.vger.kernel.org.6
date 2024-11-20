Return-Path: <linux-kernel+bounces-416040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE299D3F70
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B76DE1F2355F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA03145335;
	Wed, 20 Nov 2024 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W5zQGxc4"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1745A140E34
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732118116; cv=fail; b=NXcOl4E6b5bHQINz3O68aZLTAMuALUreWEF9QONfsYdRpB0BMLbR/5jHQ3z8p33CO02kOZ6Flw7QHEco2PZP4WEc9TUUEZE8GeocRy8mBmNAceGuINFcnE+bYREDCfuZKazYwDYTMKL07j5A1CvZlL2fbXlqAWX/I0IJw7eax7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732118116; c=relaxed/simple;
	bh=cSdiL/kA6j2zV5X6H1eKchSZugUNn4SDHhAou9rCCEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h8LaS+vA38XpP4Z5JcFlUfvCLXlCXMMFUJu5NqF2FaJ7+nqz8LfuwmF6KUv0z2zpQrlTb8Kc4+f1CdFDludFpJGz4/0yDCplE1C/sAmkGN75DmXBuOGcW/ir6qdZhZJzQHJ5iI3V6YyHZ5xu3jzJbkKm3/9G9qqY0w19cTg24Bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W5zQGxc4; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgB5bRRu+dwUyNMF+Yz6lLYj+ET8admZI4t/A1BK6dOzWTs74GbR67+awfHL3qP41HAIS6GtfbOQ1c+8JJRm0paz4HPUwFeHwMOK6j+Z5sNfvYh2TrAdQtw7r+yFtqJ9YCoCRH2wz1XKDa4PCMrpkIIMwvnl+Lfef60YRqHU4GN7evVxnqWrmtjBG03uVWfQ47oQWUlE48/TwVTMCNH7AcKO6easRPkHVQKvST47xqmddhzVDqcMwHPsSwFhylbxbgl5u7i7D5cSRiHiWPm8DUxVMy8zIHO/ukqgobwdPUKhRVkzGzao5gpUDna9pKargBnK2KXUkbVTSiALBY9Fhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3g0TGYzDzuciFphWKtuTUbQmGktc6o9sNN/3qrQNsfg=;
 b=qX5HYnAgYAhyba07ra+CvgQffcGg17Li158VMhgcIdvCHj47Rrj9ZXnaGltuJp2i9LO8x6f+U3kV1AsW7HMFo2YxvuzelLrS4m3Q2Is7TY9hf5W929lrHAJIygmJwV4Fgfhmxl+3fFq/OK/gqnokKchrdK+aD7nNzzmKbgIPgV0gsXTj9iUF+OOnogPOF5TUJszjyRnVOj63oYyU4IgwVff6rAzkso8GEHxMO996dnNa0dAReJWRzw/myjxOZEJ8a7BY77dkUWoI7E4f36+VQjoKXD1PM+X/PAWCn4A7Da/EeewjEvPW6UpiQBSVVe7k/yuActOhWGfoUFeG0WdFqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3g0TGYzDzuciFphWKtuTUbQmGktc6o9sNN/3qrQNsfg=;
 b=W5zQGxc4OGlpN0e7gscik857HlOhNLQzx0ip+k2ChIxyg0yajnT4VlVPK/Kx9QEzkR0WdeNlnxtaLO1pdhev0K6gqqXt5WCCpmOXfUjSJliXnm/1zZxA042klBjZR+Y6Mzo8KeNm0vam8a8e280jYaxunYXhw2bu1xK4R+C/riEhgZeoOxDlmaILWAaP0vFwy/q+3oPhhFGxpTBukfM8Sg3KwKaOTFjUB5WNZtGJqLxYPoMFyO/C9hRorUf5UppQvtGYg0CZEMG1BineG0xPlm0pOVYfJjAksDZZAzqDDMoVW3shZLsvpf5fid3KZCDA5dbGCz6OBcC87aWNUydD9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB7617.namprd12.prod.outlook.com (2603:10b6:610:140::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 15:55:11 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 15:55:11 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Yu Zhao <yuzhao@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable v2 1/3] mm/contig_alloc: support __GFP_COMP
Date: Wed, 20 Nov 2024 10:55:09 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <16391A0B-4E3C-4F3E-8904-9034DC87DC52@nvidia.com>
In-Reply-To: <e46ab5c6-8b95-4d2f-b820-14659c615e81@redhat.com>
References: <20240814035451.773331-1-yuzhao@google.com>
 <20240814035451.773331-2-yuzhao@google.com>
 <402ff3e5-4fca-4452-97ba-5b1ec4a6eeb1@redhat.com>
 <00721702-78FF-4690-8EAA-31C367FA9FC0@nvidia.com>
 <1a77f16b-d637-40b4-bf47-a8236729a0ca@redhat.com>
 <57A6BDB9-119B-4C1F-8715-2584046A5EA8@nvidia.com>
 <833078e4-3661-451a-bc11-3cb60a302946@redhat.com>
 <e46ab5c6-8b95-4d2f-b820-14659c615e81@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BLAPR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:208:36e::14) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: 96145c30-029f-46c1-7f8f-08dd097bb712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wqnmto9UsHQN1xgHAZhipEyhoVCHccXnUxqSDDtZUEgmeL1MLTVWGQHT06wT?=
 =?us-ascii?Q?fmgSrOpsdqFc1NGCVnQVo9HzdFcUqNGU7pyFyaZ+CRhj6A9T51rnGKJsGcix?=
 =?us-ascii?Q?VTh83hqnKMdmEEi7owyVitkLqQSzpTidALzU930AUDhg2U5RLumOG94FOkur?=
 =?us-ascii?Q?85Fdj4jANC9xRuKcPwnDLvKO3E9w+DewGhk03plp73eKXQASaoEM7gonWaBb?=
 =?us-ascii?Q?LQqlG0BMP8YVUJW7YAYQAOiZ3YtWUQE8Mkjuc+/fafLWx965Qq+ZZlyAQ19T?=
 =?us-ascii?Q?GLLZaHHWKUEEnfjoNGb+L5rK7rH919LLHv4802Qg91hpYwGgZCY6jJAiLBo2?=
 =?us-ascii?Q?nTssjuUooNJeSMSXv+1rqHWIOQlbgguL+9A2XYzM1YCnOodpgUIpIgbIvk1T?=
 =?us-ascii?Q?jLPenW2VTTzjOK6qIP9iGIccGufQlg0vp5KqiTc46GMfEUcfsNt6DJ9LVhgf?=
 =?us-ascii?Q?rMit6bSlAxYAO//BjFLCK5ffdLX4h2OMAseSvrpwaL+pbnbA6koyO4SeL7kX?=
 =?us-ascii?Q?kML87oUZcU13Exf5PnkfF1OE7ICIiWyXa9fJNjeLynMeUovso9C9l4hc/VFf?=
 =?us-ascii?Q?PmRW69VIqRToE297+Za+i40K+QLtaiWJMRTYsiQKXvlbXtg0voN2oYQMV7kj?=
 =?us-ascii?Q?owOTjs/djtQ0+Y71Mi4fdD6P/Q4j1QS9frcWb6F5IIrEcPA+kj0GMF1stcmA?=
 =?us-ascii?Q?iLy0V2RFopgt1Let8VpmPSIO6izAOEjGivqbzDkD+qKfL5qsRgwvwUU1tf6L?=
 =?us-ascii?Q?Qpo97+EmicRMr6fQ+krLLJbR9vYPzHBE8zGvmA6zIgbz56+eVmuETr4kh4XS?=
 =?us-ascii?Q?YxtdAzi+3Bs1Xotru5ZhUzFnP/mWolghmPIONVd1jy5tUSLQFoQhCNpj57c0?=
 =?us-ascii?Q?9ihFy8sBXQDJ65R8hf8jA9ygQYoqgpi5dCRzsJQZC1E/UZxmkppYcf5+nWXr?=
 =?us-ascii?Q?XnJuxcQIC2B9C0dKE9Tgf1jdr/1U+yGSIvVJNENxNCsRAKo6VFGm/buo+Z1+?=
 =?us-ascii?Q?jqcvZIzLyX82GAq1u/Nv/pK4wfzX32P1FjiluuscYcB1BU6A9zu0uaecvHjk?=
 =?us-ascii?Q?HYq+CUK2XC9Xfam9znrIhQfKZbq5+xvv0Ui0rMUDcG8TiILzBenYJdDNvCS9?=
 =?us-ascii?Q?OfPlRICy+PR6dWYv3FIPUtJJy7lcuDc0WVkYlCsMisHl0DfsubhXPxcn3FfE?=
 =?us-ascii?Q?2aMybQiqEEfBnJG73C4PwBKLjPZ18XAlSFPS+hwl6RTVPfqmZboWyQKskFMt?=
 =?us-ascii?Q?Ilt4c8VuqH1ft7avIOx8OuQcucsyXAKzgyqmMRmAfr1hgHmLiXxwkXPy5Aqq?=
 =?us-ascii?Q?pEY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vDJVmfDHHIhdWIR/lkBMLXWDGikdYUxizdl7pXlyWtHFoM5/bsH2VLZlkC4V?=
 =?us-ascii?Q?Q5gWhVoxUq8+20IWbE4BYgOT8y6NBKeVQf0hzpqV2KaFDsezQiKW2x3J+Rok?=
 =?us-ascii?Q?4VsgxfsAUMfU/FlVtiO4VovJ9rrQZwgZMZS3zcnlasV4KUhAmX0VxaYi9cqY?=
 =?us-ascii?Q?eFCz56exBmAv2hPt7tLwA7ST40pyoFL0+OTHIzDeNjngd+Gua+M2iMxuBeHu?=
 =?us-ascii?Q?zMA2isooLrJjm4pbtAJk2ZEITYvSoTuK/oOMcJmojfjBc77a6gPjUYSeI+xV?=
 =?us-ascii?Q?rApAHlspxoL2xquYwng4eZGEwSUNPpU5PolAiMLTlpoPLcmJhneygkg3uR0L?=
 =?us-ascii?Q?cyoG95+Uw+iDvU4Xtg1ivucbxerOpPaIIuineylHDgwW+SDb2338vos8h27B?=
 =?us-ascii?Q?zrNWguNRjozQzEyCeVAp3VAey+v9DT0+3ISSTVctV94+OroyWkvfgipG9Gzn?=
 =?us-ascii?Q?wS02w8737eMvENP8kCYX8xnC7z4+oH8QIbJ/GWJ3mDOjAKJzI/uzj/tXQLoO?=
 =?us-ascii?Q?U2ZKuDwl9y281fKQTWjjRLSoQWA7oVBvJVru5QKXMQJGlBHLmvTQi1iAxvaT?=
 =?us-ascii?Q?FDudDbCmedjHH4cCJ+8tnItWHcVK8z8pkfL9jxbuQAUkxO1GR+LlLJNnP/mA?=
 =?us-ascii?Q?0zEfxjPoM+l2x2m3GyxqH5PNziSv1eV9vv2qcv88yMYHcVgHP20viRkWyY67?=
 =?us-ascii?Q?iBDWCfHm2I3dovnDxfOYdaKysWIoSShc4JZOF5Yci8eele2rjLc6drhhIxTk?=
 =?us-ascii?Q?z7X9K99kr3pWCcODtIoHE41w8YHnJsZOS0ibVCnDqbA+aM5tVL2KGM1bZwxf?=
 =?us-ascii?Q?34clxv2gFSDzwcDd3Wkxy6g/Ei7dX7oRPj1Djw02xZNNqlr7ftOHtNhKguHq?=
 =?us-ascii?Q?9Gaqi/VuuzYys3iyhc33S0plMG22RgbMCSR02GN14O4A5UHADDGNgdMK9MCo?=
 =?us-ascii?Q?sOgITDYJJPgZyAjFYDBgCQm6JNaWVB2FWhjSEcry9TyE44vLc2vPvyMA9mc7?=
 =?us-ascii?Q?p3u4BjilntwNmWTHrWEBYpLK/IiCbaSEv0qlqHvWlu/4oU0+ggcWChywh0v+?=
 =?us-ascii?Q?GeoXRwDNvS6xqzB2kZzzapkCUe93Yffc/KSVUE47aLomc49h0eJnVmHH5apz?=
 =?us-ascii?Q?vgeenwMa2yqrutBHAt+cy/XWxij5LJ4ZhJhVmNULizOEahxPTZmvNrjnoyr7?=
 =?us-ascii?Q?FYlFTygFURPApcVh98CmK53MhMV9rFD36u2zJJlEy2vl7gsbiF9rIppMKvZs?=
 =?us-ascii?Q?7dxHmZLjG2gL/g87RvDTxICFDJUJMIrQfHRp1byBIAfEJoaP8NTGnHKgFjx0?=
 =?us-ascii?Q?/+7Nn1S+vHXwOm9EVy8qD922KnefI8rly0t+mcSpF9XgH+efGHbzCNavrzOq?=
 =?us-ascii?Q?Q5+xQPLPSdt7rtGAUaNX/KzByNVKj2Ee8AyK0jGZQkoHkO4Z9r3UgAQFzMQq?=
 =?us-ascii?Q?C2SJbOwPK59GF5BMtBJz6Cm5qwCm1yxs94tdalM6jbZPnVZEMu5NgBMXHpYK?=
 =?us-ascii?Q?/W0w/6tHS+JhBwsqJa7+5pjFBBMNbMKrIq4tT72Ik55pX1rMH9s+/Imr8rSV?=
 =?us-ascii?Q?O6J2YfYwooaHAb+VQZcvz+hV5mFeqXZmhI8mkr1E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96145c30-029f-46c1-7f8f-08dd097bb712
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 15:55:11.4753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R78BrouR1LGZoFZCJTUuItUkwQeNftU90EgAF85HIe5z8Qdi9t0jMzpXpl+O/Yes
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7617

On 19 Nov 2024, at 11:52, David Hildenbrand wrote:

> On 19.11.24 17:49, David Hildenbrand wrote:
>> On 19.11.24 17:41, Zi Yan wrote:
>>> On 19 Nov 2024, at 11:31, David Hildenbrand wrote:
>>>
>>>> On 19.11.24 17:12, Zi Yan wrote:
>>>>> On 19 Nov 2024, at 10:29, David Hildenbrand wrote:
>>>>>
>>>>>>> +/* Split a multi-block free page into its individual pageblocks.=
 */
>>>>>>> +static void split_large_buddy(struct zone *zone, struct page *pa=
ge,
>>>>>>> +			      unsigned long pfn, int order, fpi_t fpi)
>>>>>>> +{
>>>>>>> +	unsigned long end =3D pfn + (1 << order);
>>>>>>> +
>>>>>>> +	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn, 1 << order));
>>>>>>> +	/* Caller removed page from freelist, buddy info cleared! */
>>>>>>> +	VM_WARN_ON_ONCE(PageBuddy(page));
>>>>>>> +
>>>>>>> +	if (order > pageblock_order)
>>>>>>> +		order =3D pageblock_order;
>>>>>>> +
>>>>>>> +	while (pfn !=3D end) {
>>>>>>> +		int mt =3D get_pfnblock_migratetype(page, pfn);
>>>>>>> +
>>>>>>> +		__free_one_page(page, pfn, zone, order, mt, fpi);
>>>>>>> +		pfn +=3D 1 << order;
>>>>>>> +		page =3D pfn_to_page(pfn);
>>>>>>> +	}
>>>>>>> +}
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> stumbling over this while digging through the code ....
>>>>>>
>>>>>>> +
>>>>>>>      static void free_one_page(struct zone *zone, struct page *pa=
ge,
>>>>>>>      			  unsigned long pfn, unsigned int order,
>>>>>>>      			  fpi_t fpi_flags)
>>>>>>>      {
>>>>>>>      	unsigned long flags;
>>>>>>> -	int migratetype;
>>>>>>>       	spin_lock_irqsave(&zone->lock, flags);
>>>>>>> -	migratetype =3D get_pfnblock_migratetype(page, pfn);
>>>>>>> -	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags)=
;
>>>>>>
>>>>>> This change is rather undesired:
>>>>>>
>>>>>> via __free_pages_core()->__free_pages_ok() we can easily end up he=
re with order=3DMAX_PAGE_ORDER.
>>>>>
>>>>> Do you have a concrete example? PMD THP on x86_64 is pageblock_orde=
r.
>>>>> We do not have PMD level mTHP yet. Any other possible source?
>>>>>
>>>>>>
>>>>>> What your new code will do is split this perfectly reasonable MAX_=
PAGE_ORDER chunk via split_large_buddy() into pageblock-sized chunks, and=
 let the buddy merging logic undo our unnecessary splitting.
>>>>>>
>>>>>> Is there a way to avoid this and just process the whole MAX_PAGE_O=
RDER chunk like we used to?
>>>>>
>>>>> Probably split_large_buddy() can check the migratetypes of the to-b=
e-freed
>>>>> page, if order > pageblock_order. If all migratetypes are the same,=
 the page
>>>>> can be freed at MAX_PAGE_ORDER, otherwise pageblock_order.
>>>>
>>>> Thinking about this: why do we care about the migratetype?
>>>>
>>>> We only have to fallback to pageblocks if any pageblock is "MIGRATE_=
ISOLATE" (and maybe MIGRATE_CMA), but not all. Otherwise, we can just ign=
ore the migratetype (or rather overwrite it)
>>>
>>> There are VM_WARN_ONCEs around *_free_list() operations to make sure
>>> page migratetype matches the migratetype of the list it is on. Ignori=
ng
>>> migratetype would trigger these WARNs. Overwriting it would work but
>>> free page migratetype accounting needs to be taken care of.
>>>
>>> An implicit reason is that __free_one_page() does not support >MAX_PA=
GE_ORDER
>>> and gigantic hugetlb folios are freed via free_one_page(), where
>>> split_large_buddy() is used to work around the limitation.
>>
>> Yes, I saw that change. But that can be easily identified cased by
>> unlikely(order > MAX_PAGE_ORDER) to handle that rare case in a special=
 way.
>>
>>   > > For the two memory init cases you mentioned in the other email,
>> maybe a new
>>> fpi flag to make free_one_page() use __free_one_page() for them,
>>> since migratetypes should be the same across MAX_PAGE_ORDER range the=
re, right?
>>
>> In the context of alloc_frozen_range()/free_frozen_range() I want to
>> free MAX_PAGE_ORDER chunks when possible, and not have some odd logic =
in
>> the freeing path undo some of that effort.
>
> Adding a pointer to that discussion:
>
> https://lkml.kernel.org/r/ZzZdnuZBf-xgiwD2@casper.infradead.org

Thanks.

So you are thinking about something like this:

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b6958333054d..3d3341dc1ad1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1254,7 +1254,12 @@ static void free_one_page(struct zone *zone, struc=
t page *page,
 	unsigned long flags;

 	spin_lock_irqsave(&zone->lock, flags);
-	split_large_buddy(zone, page, pfn, order, fpi_flags);
+	if (unlikely(order > MAX_PAGE_ORDER))
+		split_large_buddy(zone, page, pfn, order, fpi_flags);
+	else {
+		int migratetype =3D get_pfnblock_migratetype(page, pfn);
+		__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
+	}
 	spin_unlock_irqrestore(&zone->lock, flags);

 	__count_vm_events(PGFREE, 1 << order);


Is it possible to have a MAX_PAGE_ORDER hugetlb folio? If no, we are good=
=2E
If yes, alloc_contig_range() can change the migratetype of one of half th=
at folio
and during migration phase, that folio will be freed via __free_one_page(=
)
and causing migratetype mismatch.

Best Regards,
Yan, Zi

