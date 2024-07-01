Return-Path: <linux-kernel+bounces-236405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A03491E1D2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCAF1B233E4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626E215FA83;
	Mon,  1 Jul 2024 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pLI5Jd6e"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D0A15F3FC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719842693; cv=fail; b=fJDMEl5YFan+zpGwUNpbG0dfZo94ct1tsNYJw055w04xZuyVG+owibCR+9Y3740ytaGHzKRq2lANh31RqtYJZbfTfLu6bAVzIprfoRhkQyTF7dR+PnB62GOYHG37ersI6SM98XIIFBMEqHa6q3vg64N6v7PLN3LEF5VfWxXrUf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719842693; c=relaxed/simple;
	bh=U1x5jpZ4Izpqj5qLicoU+n/Zm5k5QwgEYem0LEzvkQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ujjzPuIB2tEXPcyFxz4JuBXE8lZkjkdhpfvTsIjJzFQxdKXN/D/NsC4MJcLZzYBKOGmKZTHl8Ut+6X6lyLTnTmOiQsly4chwZBA3QedL0izlP0bV4HJ49Y6+tpg6sHpIvYlGq3XzwqVIuFXwJs0nTvKeZqq6QHyJF3nOJLf19Gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pLI5Jd6e; arc=fail smtp.client-ip=40.107.100.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HH3f1k6yCZ76YS7WEHdVb9qcNl6EIlhqbZBcD3lPYfMuBhF7Iff3U4/1APt5wwD8YtWo55VFgHV1hqGSbjUy2hc+fwKCle/M2NmK4BQa2EWzMnudzE4WM3ErFD2Xaz8f1XEcKvjE/yUQsdDZDonaZVFikox/WL/T8/MlcEuZUy59wtgNVpujcasPnrQGW/y52RewAMH4wEhNZ+vSvtUgEhpaY+kZIqk6mG+SKbXtRGjGC318YnUagr86DIhhilGVuHs2C5f2ZskLDt15c8O7Pibi/EC2Joq/WSxRsJ5OR4cfiH6TUGjFOogPNm4iumm6IOnrFkDdvygOm8vog/0s9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXJayAdmE64U4yuTMSV/iiN0T9MwctKju/KJeJ4yNJE=;
 b=nQTWjGP4RWxijr1V8e17HfgVxCqoJuNFrvF3U+Q1+exqdDC0NabHgQ9UKfUc0y6oYA28whdkG/JfQLWMzJj30YII1KvrtWLEbU5/+mo1lNmNjcCVdGEEcSzni+4F/X20DEnJhuilo9I4raTr0XFevFVmOVb5LZ2qV4neRVvIFJuEqvZ1zfn2jPS8CpVnYxAKfSARouzexa6CZJeDc+GQUMcZc70ZFK0fSemxvJ+1Ewa5C6Oa+xZb6YdYja55+hd5ZYOQjUSFTmoO5NHewyhLCK2BaPI5JQEG2zm+S63/9qAe/Plk4tV5hV9nt5WOhy+qAs1X/KJ6Liwu9Jf8UKeqiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXJayAdmE64U4yuTMSV/iiN0T9MwctKju/KJeJ4yNJE=;
 b=pLI5Jd6eSvk/cpUNoR3wC1bpnzJpZl9NThRB8lmWF4Ju62uNC/voLBs4cTS0kIzdT1DVKiZ2i7MtUscIAj3RLprfa8apc7IKMfpt99myMr2x912HvifC4CkX4fkLYlLvf+VICweTrJ+fLW1fJQREwPw8fBnUJj9+4wKG5LbkmArsqGq/b2BjwcbLeXkRwcUP+z+q5a9px3eSOL0JwYhLk7se3ny1oItNsH0aY9t5PaiMQKFMTbuBOe9csf+/QDHjPnRPlsMDgR+7cQPCTEsH6fUZffBEqxRnJJgAkB+qnZ1AihJeqvghIuXzp5NVi/uhG6OJPfG+66y0rx0braoGSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Mon, 1 Jul
 2024 14:04:45 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 14:04:45 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 2/2] mm/migrate: move NUMA hinting fault folio
 isolation + checks under PTL
Date: Mon, 01 Jul 2024 10:04:39 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <D937DB05-9897-4154-8B78-020C13D26CF1@nvidia.com>
In-Reply-To: <e2b4933f-7102-47fc-bb33-ecb46eddedcf@redhat.com>
References: <20240620212935.656243-1-david@redhat.com>
 <20240620212935.656243-3-david@redhat.com>
 <B726B923-E023-4E56-BED1-BFA5CEF644A1@nvidia.com>
 <c8f9d6fd-310d-4b13-9871-556b6b9a47e1@redhat.com>
 <0F4ABC1D-7A26-4AE2-BCAA-3EA906FB13A7@nvidia.com>
 <9af34a6b-ca56-4a64-8aa6-ade65f109288@redhat.com>
 <D2A4QLLXOM9N.1YK9YRDXMWJPX@nvidia.com>
 <87ed8do6kl.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <D994321B-BF99-45F8-A4BB-F8C8E4DA77A9@nvidia.com>
 <e2b4933f-7102-47fc-bb33-ecb46eddedcf@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_A5F817EB-4EB9-4F26-9B7C-727194358C52_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:208:36e::7) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ1PR12MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: 3df2767b-ecac-42d3-c932-08dc99d6c2cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4H2P5C8JuPdGvVp5bHDbLZnXHVW6bHI8/FfRwF3salT9jILgXwUpcOzIOScB?=
 =?us-ascii?Q?dHUM8lHYwIEpF7SciF+qlfQFB37jWi+i27toEKSFLMv5fw5kJlwBBv3ptVR2?=
 =?us-ascii?Q?0fear5fQB3xBi0+rCIM91LTDl/uwbSDiiIXWOUbe8EYENJrliC5OjIdEsdp+?=
 =?us-ascii?Q?pyMrxOUco633t1IJLUG40LlDF424Pc3Srjedt2IilDUHKi35TdYDz9J44H7v?=
 =?us-ascii?Q?EUwUCPN2F3+2jsXr2ErGgGTtpG6hpKwTcEp8EBL3fFXh2EJXauQjoViMBLBM?=
 =?us-ascii?Q?ERzrIdvgjezO9bU2HjEXxSyYZAdPYvJc9G2D21CzXeiCG+dtaJ223UTUOqUn?=
 =?us-ascii?Q?OA1dViIHf+LqcUAw6gjEXddx9LPyQXiK5s06hpbj7PTmPVTdfI2iU4xqsEi2?=
 =?us-ascii?Q?gvS3ew5zcfUGdTlF5ajx2gD9YAiae/ncWSWYhJZENBmDnVaXf5nvMxSUCBJX?=
 =?us-ascii?Q?Szc78qiU+KP27A7B6XMSXrDPZIPmy/DmvGvw567gQSdhZo9cyhmMUmI+pxzp?=
 =?us-ascii?Q?ztRPa/EKA8qfpm6imhG+HbVB4qHIIYzJfQNreeS5x4dJ0vRQEZjzD1VCh+t7?=
 =?us-ascii?Q?FHtXS/h8uEp1J3HFI4t7ggqbpfGrmMEYFW3YGR6dkSz1Mq2quj+Jrj3poyau?=
 =?us-ascii?Q?cMU4VdAdwYOWNMHIeIg/crBiScTt8WVYihA+vM7t7RWI0LddrGlOfwbQn/q7?=
 =?us-ascii?Q?XDfgVPpUR+QdP/m33RWkl8uVaL7jUY9m7anfLsLu2vA8z6oSU7VxhQe1AYFR?=
 =?us-ascii?Q?t0wZhTP0s/VbWjW3x3hmFjLy979VhahLj3gjohCNtYr3lzOgGYA/9UkZDXIu?=
 =?us-ascii?Q?mhWp2xgc19YA9F7Nkxw/eWn6+mjFkcZXaaLXo6XJ9q3aGR/g3hA902lNSlqw?=
 =?us-ascii?Q?LeJgMo2GzrHZmWMEQE67J2sfCCtXMjBKfOghsA/8ZQTHZSCtTrEKQ57XiLAA?=
 =?us-ascii?Q?hwYBbaixOukfN8nBWY55OLjS3eTDJdyLhqpsR7RGhfU9CJDvmkYMXnAbE303?=
 =?us-ascii?Q?xg5OgnMEGT3RsokD5XtaG3R32+tFAqMtmmx+kep/wIKVJ1Ls2CEfGJFABTem?=
 =?us-ascii?Q?SWq8dUnrQtmtiMXtLtzBAiyl6JQ41xxihd8GV7Wc0cZpFnatTWzVV0+q2dGB?=
 =?us-ascii?Q?2o2pLTXXJqQDSlv27XiYGow9pACKLXoxrELi+AZmWyaGQPL/52j3V6M9W60n?=
 =?us-ascii?Q?0LPaS+mV0h6wdTpzjd+CDAYni/ftZVa8MaTkGPM7vm7SpxO3f2qieKGfG2oU?=
 =?us-ascii?Q?4yd6Ufj0KiuKoe/YVrS16LLWRLDfOhIhebqQCezwN8zBMrOlrMqDlSgVXb5V?=
 =?us-ascii?Q?1zx+pJNoVFGqk5NlGuONE723t2H2fJcviiUYpNDaJeAQJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FfUUAMJ4PEYjzTEJ4loGRcKbMkPpsFtLQPn9uSVlPZ51/130IVevpPse0v9S?=
 =?us-ascii?Q?pDv/EB/ACW8Ha+0/oTSn1uoc+LgIOcKAQj213iNvhSZv1r6/i3voTbps+bA5?=
 =?us-ascii?Q?TC/V39eXIKxdHmVfroD496qrGcJaOOj67hG/PZkPIuLAh6bxIHXwPGhpl9td?=
 =?us-ascii?Q?MSF0mlDcay6MX0FkBKQ0H7rqD9FnigkXtbnL56TqukRQeXaPkSxrSq85v4h5?=
 =?us-ascii?Q?zRcEzzYsWdZmlPtkfUXORmyY6EWY7hghf+Y2LsmfYhnVMcwW48uVyYA9HlNS?=
 =?us-ascii?Q?CFvtMoDOzI1nEnJe19fbQ9bhsyI4oLwU8QRzdJp7xlO/F1V/CO3b5LXlxrCf?=
 =?us-ascii?Q?dnTupcYupoO1QdNwH8HKjT+Vh1KXC2ih0RtGTMEUT8cf8e+zXx2XTwUIhb4M?=
 =?us-ascii?Q?SNndeUm/+VX3NSnfjAbTF0G+5gqhUGkKTWe62TA84bfmekdF5nmlViW7Vo1y?=
 =?us-ascii?Q?xrdShdbe1UDo84i2Bc8GFD1xSEpsBE+mQIs47oqLOWLxOrJvCvJ3dI0ila+e?=
 =?us-ascii?Q?dkWBR2YCEepgzijqfohDnlzJQFPsAuJDOS1IkgAAv0G5u1kjQMRB9TnZsDow?=
 =?us-ascii?Q?pnxHEMt5GiTOyhMcEhXzB5unw4OCSgh1WyNDry93gSXblcHxeOLlRURmdG3j?=
 =?us-ascii?Q?GHr1nXPpl9CcC6cEosw+FM3YMNq3QEiq69qeY9R8hTwi7ru18wcOAIOrDswD?=
 =?us-ascii?Q?odb2tOnIIFXUaatcGsJoy3XBX+dt8cCkZiYre0aE3WBD1zaiKq71kKgz41U6?=
 =?us-ascii?Q?bUw/Xs4oQulM1Uhsc7QKn8TU5JuLfpruRKxMgeG+hXUaEkEapjCjS2PWejJ7?=
 =?us-ascii?Q?EiVBvlseEJGhsAYqSmgJ/JK77aFY+E4Wot/yA0cKZXsVLt5UFU2w6UwVxvG+?=
 =?us-ascii?Q?dqIkmL5ocERM0fcL9XBsyvjEcG7IpyKkN2dMQPHUvUFAmayolrJpT1rAdm4v?=
 =?us-ascii?Q?3JKovk8hWv2YHG0eh60URPOPJ0v4G8KI051kVTNdROy/y9bMOYglrjRBmpgG?=
 =?us-ascii?Q?qcDwVxuWt4rbyR8PVNHcfmcSjc4hjo7beag9cYtkEKxvjfna4VCNctl3JArP?=
 =?us-ascii?Q?No0SX/3KLtCprfajhS5j5MLo5AIMv/7OSNJVYH/2Ac98GVqXETuJ4djBaJ9Y?=
 =?us-ascii?Q?cMu87wHEUdleCsa4UFIROZqwhQcEcxEJh/KKUnueJrzaTtHw3VWCoIrZQEGg?=
 =?us-ascii?Q?iVdr9s9fSFLX0nXYFLFoXFyDAhEg8shiKW6qDZMuAwyHGC0ipZK5Nm+5QOUF?=
 =?us-ascii?Q?cBAIP8dorBdk2iHTowCaPrsAEbPwo3OtIHhh9NNp8AAe5j4xPABr2vIF5YVf?=
 =?us-ascii?Q?R0JKAOIHiyh1ooP0Y906HHS0L4EZKM7udUYpVOCC93cpG6CiflfyIXtBktcf?=
 =?us-ascii?Q?idwxHdRAvdlE4GDMdjQmWl2Ms6oT9ACjDOY7HV/fM+wIJ/pr0wxz77GKlCd7?=
 =?us-ascii?Q?5Jv7UWL/zKMSUuY48Oude/nsSePzOedAB9/l2OGst5PJTS3U7Wikjb/1Gjng?=
 =?us-ascii?Q?CccFaPcrnQHIVbC7P1UFQwTOPdwoXW57ATwxtJiWuj+rFX5YXp39UjrG1c+8?=
 =?us-ascii?Q?yG1Fpb55F//VzjUWTmSvQDFROy0Cee+LjpkpqDPw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df2767b-ecac-42d3-c932-08dc99d6c2cb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 14:04:45.1177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rjWxCxwtdp/OF1A0hGonQgl0dbYAtf/ivVykbXTQaiX/hAjxVgEkcpb6AIEOa/c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6289

--=_MailMate_A5F817EB-4EB9-4F26-9B7C-727194358C52_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 1 Jul 2024, at 10:03, David Hildenbrand wrote:

> On 01.07.24 15:50, Zi Yan wrote:
>> On 1 Jul 2024, at 4:32, Huang, Ying wrote:
>>
>>> "Zi Yan" <ziy@nvidia.com> writes:
>>>
>>>> On Wed Jun 26, 2024 at 12:49 PM EDT, David Hildenbrand wrote:
>>>>> On 21.06.24 22:48, Zi Yan wrote:
>>>>>> On 21 Jun 2024, at 16:18, David Hildenbrand wrote:
>>>>>>
>>>>>>> On 21.06.24 15:44, Zi Yan wrote:
>>>>>>>> On 20 Jun 2024, at 17:29, David Hildenbrand wrote:
>>>>>>>>
>>>>>>>>> Currently we always take a folio reference even if migration wi=
ll not
>>>>>>>>> even be tried or isolation failed, requiring us to grab+drop an=
 additional
>>>>>>>>> reference.
>>>>>>>>>
>>>>>>>>> Further, we end up calling folio_likely_mapped_shared() while t=
he folio
>>>>>>>>> might have already been unmapped, because after we dropped the =
PTL, that
>>>>>>>>> can easily happen. We want to stop touching mapcounts and frien=
ds from
>>>>>>>>> such context, and only call folio_likely_mapped_shared() while =
the folio
>>>>>>>>> is still mapped: mapcount information is pretty much stale and =
unreliable
>>>>>>>>> otherwise.
>>>>>>>>>
>>>>>>>>> So let's move checks into numamigrate_isolate_folio(), rename t=
hat
>>>>>>>>> function to migrate_misplaced_folio_prepare(), and call that fu=
nction
>>>>>>>>> from callsites where we call migrate_misplaced_folio(), but sti=
ll with
>>>>>>>>> the PTL held.
>>>>>>>>>
>>>>>>>>> We can now stop taking temporary folio references, and really o=
nly take
>>>>>>>>> a reference if folio isolation succeeded. Doing the
>>>>>>>>> folio_likely_mapped_shared() + golio isolation under PT lock is=
 now similar
>>>>>>>>> to how we handle MADV_PAGEOUT.
>>>>>>>>>
>>>>>>>>> While at it, combine the folio_is_file_lru() checks.
>>>>>>>>>
>>>>>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>>>>>> ---
>>>>>>>>>     include/linux/migrate.h |  7 ++++
>>>>>>>>>     mm/huge_memory.c        |  8 ++--
>>>>>>>>>     mm/memory.c             |  9 +++--
>>>>>>>>>     mm/migrate.c            | 81 +++++++++++++++++++-----------=
-----------
>>>>>>>>>     4 files changed, 55 insertions(+), 50 deletions(-)
>>>>>>>>
>>>>>>>> LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>
>>>>>>>>
>>>>>>>> One nit below:
>>>>>>>>
>>>>>>>> <snip>
>>>>>>>>
>>>>>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>>>>>> index fc27dabcd8e3..4b2817bb2c7d 100644
>>>>>>>>> --- a/mm/huge_memory.c
>>>>>>>>> +++ b/mm/huge_memory.c
>>>>>>>>> @@ -1688,11 +1688,13 @@ vm_fault_t do_huge_pmd_numa_page(struct=
 vm_fault *vmf)
>>>>>>>>>     	if (node_is_toptier(nid))
>>>>>>>>>     		last_cpupid =3D folio_last_cpupid(folio);
>>>>>>>>>     	target_nid =3D numa_migrate_prep(folio, vmf, haddr, nid, &=
flags);
>>>>>>>>> -	if (target_nid =3D=3D NUMA_NO_NODE) {
>>>>>>>>> -		folio_put(folio);
>>>>>>>>> +	if (target_nid =3D=3D NUMA_NO_NODE)
>>>>>>>>> +		goto out_map;
>>>>>>>>> +	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) =
{
>>>>>>>>> +		flags |=3D TNF_MIGRATE_FAIL;
>>>>>>>>>     		goto out_map;
>>>>>>>>>     	}
>>>>>>>>> -
>>>>>>>>> +	/* The folio is isolated and isolation code holds a folio ref=
erence. */
>>>>>>>>>     	spin_unlock(vmf->ptl);
>>>>>>>>>     	writable =3D false;
>>>>>>>>>
>>>>>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>>>>>> index 118660de5bcc..4fd1ecfced4d 100644
>>>>>>>>> --- a/mm/memory.c
>>>>>>>>> +++ b/mm/memory.c
>>>>>>>>
>>>>>>>> <snip>
>>>>>>>>
>>>>>>>>> @@ -5345,10 +5343,13 @@ static vm_fault_t do_numa_page(struct v=
m_fault *vmf)
>>>>>>>>>     	else
>>>>>>>>>     		last_cpupid =3D folio_last_cpupid(folio);
>>>>>>>>>     	target_nid =3D numa_migrate_prep(folio, vmf, vmf->address,=
 nid, &flags);
>>>>>>>>> -	if (target_nid =3D=3D NUMA_NO_NODE) {
>>>>>>>>> -		folio_put(folio);
>>>>>>>>> +	if (target_nid =3D=3D NUMA_NO_NODE)
>>>>>>>>> +		goto out_map;
>>>>>>>>> +	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) =
{
>>>>>>>>> +		flags |=3D TNF_MIGRATE_FAIL;
>>>>>>>>>     		goto out_map;
>>>>>>>>>     	}
>>>>>>>>
>>>>>>>> These two locations are repeated code, maybe just merge the ifs =
into
>>>>>>>> numa_migrate_prep(). Feel free to ignore if you are not going to=
 send
>>>>>>>> another version. :)
>>>>>>>
>>>>>>> I went back and forth a couple of times and
>>>>>>>
>>>>>>> a) Didn't want to move numa_migrate_prep() into
>>>>>>>      migrate_misplaced_folio_prepare(), because having that code =
in
>>>>>>>      mm/migrate.c felt a bit odd.
>>>>>>
>>>>>> I agree after checking the actual code, since the code is just
>>>>>> updating NUMA fault stats and checking where the folio should be.
>>>>>>
>>>>>>>
>>>>>>> b) Didn't want to move migrate_misplaced_folio_prepare() because =
I enjoy
>>>>>>>      seeing the migrate_misplaced_folio_prepare() and
>>>>>>>      migrate_misplaced_folio() calls in the same callercontext.
>>>>>>>
>>>>>>> I also considered renaming numa_migrate_prep(), but wasn't really=
 able to come up with a good name.
>>>>>>
>>>>>> How about numa_migrate_check()? Since it tells whether a folio sho=
uld be
>>>>>> migrated or not.
>>>>>>
>>>>>>>
>>>>>>> But maybe a) is not too bad?
>>>>>>>
>>>>>>> We'd have migrate_misplaced_folio_prepare() consume &flags and &t=
arget_nid, and perform the "flags |=3D TNF_MIGRATE_FAIL;" internally.
>>>>>>>
>>>>>>> What would be your take?
>>>>>>
>>>>>> I would either rename numa_migrate_prep() or just do nothing. I ha=
ve to admit
>>>>>> that the "prep" and "prepare" in both function names motivated me =
to propose
>>>>>> the merge, but now the actual code tells me they should be separat=
e.
>>>>>
>>>>> Let's leave it like that for now. Renaming to numa_migrate_check() =
makes
>>>>> sense, and likely moving more numa handling stuff in there.
>>>>>
>>>>> Bit I yet have to figure out why some of the memory.c vs. huge_memo=
ry.c
>>>>> code differences exist, so we can unify them.
>>>>>
>>>>> For example, why did 33024536bafd9 introduce slightly different
>>>>> last_cpupid handling in do_huge_pmd_numa_page(), whereby it seems l=
ike
>>>>> some subtle difference in handling NUMA_BALANCING_MEMORY_TIERING? M=
aybe
>>>>> I am missing something obvious. :)
>>>>
>>>> It seems to me that a sysctl_numa_balancing_mode & NUMA_BALANCING_ME=
MORY_TIERING
>>>> check is missing in do_huge_pmd_numa_page(). So the
>>>>
>>>> if (node_is_toptier(nid))
>>>>
>>>> should be
>>>>
>>>> if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||=

>>>> node_is_toptier(nid))
>>>>
>>>> to be consistent with other checks. Add Ying to confirm.
>>>
>>> Yes.  It should be so.  Sorry for my mistake and confusing.
>>
>> Thank you for the confirmation.
>>
>>>
>>>> I also think a function like
>>>>
>>>> bool folio_has_cpupid(folio)
>>>> {
>>>>      return !(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIE=
RING)
>>>>      || node_is_toptier(folio_nid(folio));
>>>> }
>>>>
>>>> would be better than the existing checks.
>>>
>>> Yes.  This looks better.  Even better, we can add some comments to th=
e
>>> function too.
>>
>> I will prepare a patch about it.
>
> Do you have capacity to further consolidate the logic, maybe moving mor=
e stuff into the numa_migrate_prep (and renaming it? :)).

Sure, let me give it a shot. :)

Best Regards,
Yan, Zi

--=_MailMate_A5F817EB-4EB9-4F26-9B7C-727194358C52_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmaCt3cPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK6lwP/iV/d8btIhaidDQ4vUkEGcjA4wpDLCCKvLXd
Kti8/zeFxHJcjsa5P4LmwAdPIezQovvaOtAC+Tdh3uxNmKWuRn593e0FlnvLZYSI
eo1aXrP1UhQ//K+uUYdF3l27GXRFgrp2aUlnnIdevHxZZPjdYlkiVqwUdK9ep+Zd
sDliRMcZH4qN78Y/+vOnEfLPDvwcWi67RabUVnzGz0nMbRP4Zup1dniLpCL+uuLh
srqzx5dejFPop+UvZYkjWP0jwoSUdOTR+3NXIIJogCa9c5kBp9yeJpXzJKwwAHzw
7ZtQNMdj2CM49I5qSR+wv2cGutVcCVcvDM/3KMYw+6y8i3NYCYhv/dRUpxvRFPyd
9RdhMKUVm652f9HAbi96T5rDeX6DPjr6dIuChowBB/WS1DJzW2AVFth8GhaD2Hu0
D3AniSbC/Ln+07YJDbvOwIZLjRn7s9WeKQAjgKvNsnVgGc4mWKdAD6UWNQcCHb76
cvk1pSq93nE/6/J6G9npvxFKClhh3LA8GWj20sKXJpye0HkbnZo1GfiEhfF4VGPv
Tu3ZmU0uy4OEJqwhII44n/4vXq3gS8nsvcZJ59in9ieo0OVwcnZkYmlGDDtczqeq
IXw86wrUS5Iqgdts4rj1TBD7ailjuLNECuOh0ccv1QLlTtOLFUB33ojpAN89hJPI
d8XFP/NZ
=1Onl
-----END PGP SIGNATURE-----

--=_MailMate_A5F817EB-4EB9-4F26-9B7C-727194358C52_=--

