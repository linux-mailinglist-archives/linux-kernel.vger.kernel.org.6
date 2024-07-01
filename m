Return-Path: <linux-kernel+bounces-236367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBBE91E13C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04031F242F2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58689158DA4;
	Mon,  1 Jul 2024 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ok0pfUch"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA88514B942
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719841842; cv=fail; b=g1dj7+te/tqY9RZ9fI/J8LTOw+WyOdqmzUY3VE/B2Mkrz8W0B4bD2EeMevgTbNY+/ww6Wnf3pOH8fbH9gMljbKKh3XNVwM2FdfDKonysIie8YhG3JNzqVR9NuH09DpIgGfOG6vK5nivDuVj3yBwE1eAANcswHdwEQvPJVrUomAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719841842; c=relaxed/simple;
	bh=GKGdED86A6rGgg7NrQslGhHh5fXpuxa1hBFc9XDyax8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S6cv+1VBj/W0hJcXlFe3hRqA86nUl1SQT5Tls8QWtVDmYepCWm0dWDLmST0PfH6fHkxCfy6ZMmpQXez6OG/nitQsgWLuryA6jOrVXfQir4u3enBSPlRDuHBT2E+vt+HIEbcorhQSyZwbGCWilGSsCtstWUV7DBKt8eDuyjt85R0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ok0pfUch; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAxbO/8Eo18DMF0wdNX/SuKgCgagIsxk/Iq6c7eW1c+eiJuv8Jy+AfIFwwvdK3U+lC+v5TYw6yjILEAWAFvpBJzPMAg0D993WC3R94ubjnLxq7e7utYbr2StsCdal6x/ny25riH7eBm/edxtf2h/Jg6fKhJXGdPtQImie4F0GfO3NIAUw3/+2JZGTRIth2w0aUVXbwtVy+h+YmSTDPkuc6Sglmh/iZLEMsOgX4W3k82uPLverOneU1iID2f30UZ1KZFZxhik+h6bW9lbUP8rI/3MRNSQPr/5Wb0MKW+J7BuATn/tZJCOp15Wn5nV3YmJMfS2udvWUUGnFK53qee0FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07TjEupr4T6S5MZH/snzbLt32fJNrpFwqmm1VGMizZU=;
 b=FG9xmZ5HNLYhCSw7lsyr/8t5IDqLpR8oVKloGGlw9MOj5FbqUHADrR0APFS3lF9aXzFZVp1iZzBortRsVm6TZd2e5TmKbNzO23T+R1mNYQJoRMvmz13vaacIHZijjGoUdeUvNj1wh+GxB7PQQtbL0/fSh1eY4CsTtTL9xXjM68ST5TfImtgINQEtSgy/kxy4RQ/FtmP5Q3/C/GpLdEAJmg2m6usTHpH6MYIdSTALchZJQdtv4bzdSKj6mi0ndKWhjmRE2drU/VgA3mtwXTR5+DFiVRmyRUZuu7MEwXcKC9tOI4QVS3u+yVgFPIGK1F9XssVQqsQLNfgCEb83ejueBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07TjEupr4T6S5MZH/snzbLt32fJNrpFwqmm1VGMizZU=;
 b=Ok0pfUchieIil95XH5qhi8GGEeggiAO6FD9EPRv1yOA/8ZAO7oWugPrNccJ49GnSiTBdZkHDjYaCY5NchiCPX4ha7le0WfBE4ZSpcGttyZstlLX5Z2siumHoRFaNNcPgf1P01qvmlNM7J+F3fUl+vCOmAAVx4L7yB1P7KCWwmLQvMWqDq+742Rou5tIEbZMe7/o163slUIUvWnU7KT8EuzDa/IZGaKLL4jokVxKMP4mj1Q7SK6y91ewcd89Kx07P5yHCbEUs+T/DBiWDlHcHBXmsBq2kcELgla9mjNfqzGyfQA24L2eJUiIjLfZ3jU39d7/ZUb12kv6+iQOiKDAIVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 13:50:31 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 13:50:31 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 2/2] mm/migrate: move NUMA hinting fault folio
 isolation + checks under PTL
Date: Mon, 01 Jul 2024 09:50:27 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <D994321B-BF99-45F8-A4BB-F8C8E4DA77A9@nvidia.com>
In-Reply-To: <87ed8do6kl.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20240620212935.656243-1-david@redhat.com>
 <20240620212935.656243-3-david@redhat.com>
 <B726B923-E023-4E56-BED1-BFA5CEF644A1@nvidia.com>
 <c8f9d6fd-310d-4b13-9871-556b6b9a47e1@redhat.com>
 <0F4ABC1D-7A26-4AE2-BCAA-3EA906FB13A7@nvidia.com>
 <9af34a6b-ca56-4a64-8aa6-ade65f109288@redhat.com>
 <D2A4QLLXOM9N.1YK9YRDXMWJPX@nvidia.com>
 <87ed8do6kl.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_7EC8C024-EAA4-4F01-B1BA-9D6A385F83E4_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:208:120::33) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: c673fc7f-db72-4bff-a3be-08dc99d4c5ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1pCh+gH3qTh1bWjgcPBCH9Ddg2m4jdfpumnQwWY3j7BPIoWPFiZhB4ltqCZi?=
 =?us-ascii?Q?cZCQJJQHJLYfPxdOAiBmYKP7KLpHEvlQd/tAIqiyTO21r6ULjSDuGNapnOzF?=
 =?us-ascii?Q?5qFkMlVaMX38uzK7WQKbomb1DPeu4iSxYJ6sgPHTc5ZcdrrNiTAKMrmQuKpc?=
 =?us-ascii?Q?IEQztoXz5C6ZSZe09sEFWivqTwS3vZFkqpyhPUXNEeOFMrD4nD3BjQm7HDtu?=
 =?us-ascii?Q?OA3qdnOUCM7eKHDa4vwMp81Ze7YJi2cy0JAX9AdpFq6XiU+cjNyOvvCK28m9?=
 =?us-ascii?Q?C+MSLNTymt464/OBJKxSvWswK1DJZjgDat8GrfgH6lFMhri8yCGSOBjea+/M?=
 =?us-ascii?Q?Q/ab2xf+9PuMktw7Sqw/XIr+pw9hGv0wOloQCI1qMG0OkJ0M7+TD0rSlOoXZ?=
 =?us-ascii?Q?0vwXA1K3BeT9CM4M3GqWi9YkZv2MqTg8tCm/RR3Co8RwGMP+eDUV2T4RQ9p6?=
 =?us-ascii?Q?sKiMZTDFe1fN8BgiiCbXyvZRHPmn4jvAXXeukfATF+GZyE2h4FtH/dXkUEBQ?=
 =?us-ascii?Q?w1ZzGu6bqWehis9QNPjPWjpYuCLcrN+WQY+Q0P91np6alHe4IMJAWaZMc7yt?=
 =?us-ascii?Q?g00LaeAcCCD8wJlzfghvAwgJxD+gbZ/1ABntsTdIc+3Mq5kvo8ybWIaGT81T?=
 =?us-ascii?Q?CXUjb6tZpPF7Yg+5YCZ4nmSexCX3BKmx8VXlgEREd9moYOInvCGDegIdqgVO?=
 =?us-ascii?Q?BKAhAVEkmamtNOMbS1fobA8Yi1lgEzRG+H0bUwn0K2jBc239crOwHRgiCHOd?=
 =?us-ascii?Q?k2Tcoxrm0fe7BRonCi9ZR2HPTfpwVDucQEuGl0NfBKkiT38n8uQ7JNhc2Ufv?=
 =?us-ascii?Q?k/bShGZZHhG1yY+RAn4Rzine1zreEltgK4mb1CWqBJE5Y5JZ3iVVAtkjnCNO?=
 =?us-ascii?Q?iA5LecXRnWGrhrvwaJQHSfXJD+4WwpGQX5xc2Fqxesil7TEbDa+FE8rbAdBP?=
 =?us-ascii?Q?6ZHfv7naMO5XstZVfulW0rDD26e/27uzq0Xz1Tx3n4oTs9/FNafwC0glMiZa?=
 =?us-ascii?Q?/Y45r8SiE5rZYuO6NZSuCxUBIuIFsbCKO8hxh/x18IIGsocMErbYnlSGYxUb?=
 =?us-ascii?Q?ZXUqp6C7OGeZj9EC+yA5LB0X4UtWFLv6lj8j785CIxEsoUo9bB/JoxQVaMIM?=
 =?us-ascii?Q?3s3BGtCesWZrouu/qPtUGAMMVphfW1Tk+NOhWmKe5StJkHJEK/ZZU3Yy7BuO?=
 =?us-ascii?Q?7cR/nEYaHSDe8nzani3CrDGxn4344SrC3ars334tiU2fG4hwbXP3uECIgM1p?=
 =?us-ascii?Q?FH8C7RpXFha9k1dgPJfq2ib1v9hyozSS5/a9zKAAGny5F5jvBri1lHllhlmt?=
 =?us-ascii?Q?EIIbO37FazbWWfEoIIgTYDeugu4gbKjYBD2g2RzyPjPafw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?02ET0d6feJj5DHwxNUKxTMGq/Iqds41Ki598RwHgv19C+vzhGEcxx8LI3JHa?=
 =?us-ascii?Q?SGtHs5x38mdCFdKJXJLyiAraCTKZGSops6CGiXLigWavddY4B7mabhYyzmCs?=
 =?us-ascii?Q?fcvywy8FSAArTup+NJzFK8imRVFvNnBup6d52oCB6/rGD6Q30MAlVwFJy6DC?=
 =?us-ascii?Q?aSn6x2QV/Z18wh7z6r+HeJUTAaLkLkKnjSqJWAaMYrCLTMLgWDf0O09gLs1c?=
 =?us-ascii?Q?ZhWr6T9Jhmfo2aI9Ng4+YmDApJVn4KDveJFXbtMlUN8JW28JjZChsSjZT5Jk?=
 =?us-ascii?Q?hPdFakzyfqxGu4DJkAqzipphwx7ZXZMG90hFLbtA4vzPy9G4494dqadrDJoG?=
 =?us-ascii?Q?Wl0ddOa7RPQigrNZglODXDKKiSj+7H5KeuD2dpmlarIVbJ10/1L/V38gOgu6?=
 =?us-ascii?Q?I8kvldAbRnu9ak8otCssb9/VXnffGMCAx7hiUBYQXLoSxgdBIdmSzETgVFDZ?=
 =?us-ascii?Q?Dbn+41gqL7+G/miJMnyo2vdUSd5rWgrxA/gjeHW5Nlw51wsXLTIFtDRyeAj3?=
 =?us-ascii?Q?8p5FyjjZTM0UHW8yDZxV64WGoEqvaqGtancsNLCjjxiITw1pJ3ZvX4czCiAP?=
 =?us-ascii?Q?S298Gn8qVS9F5byuyEJiP4A88esSr5m59r9ZC9Bryf5iwPoHUEiD6Swcpqie?=
 =?us-ascii?Q?x/ByQsegIbVbOsPQp4X4PZ9eDbUE6/4nTSIDFY2/rr25feR0SBlXohx4dD/c?=
 =?us-ascii?Q?/2NC/7kkxzQ7dh1JtULgTD0HIKa3njUBX59rKyCRgk0/qJrK6AKPdvwAGRUo?=
 =?us-ascii?Q?m+A8istz1qZBOyeqZlUtyVJ6e7uUdnooc+uSHUqiKsfamGQnunJNlXFSk5Pa?=
 =?us-ascii?Q?1Ya7crMa9tb7nO9QTKcenY5YWKTupU+ums7EVSIU4e74Q+NL8lXGRuXcAFgo?=
 =?us-ascii?Q?E1pOsxMsuWeJQanNbOLwFqpv5M/Q4A8w/LSvAqvibcfbvXYPDU5gafESAli3?=
 =?us-ascii?Q?/6SC/U+sRbLTWRQvqVOKGFeAHS7/cEdF0GyiAWCwqEvi2Hf7RZ6lezTO6KAf?=
 =?us-ascii?Q?slqLoPgFkPr/12hsRaREaIkUyd51aK2JyljNrDXXv3xKtQwsNwLI+cubtgXz?=
 =?us-ascii?Q?y6wB+FcqolR9pJUo52MaENYyaws1mg02Eh7J30iGq29LpUFmsAaNEcIiiWqR?=
 =?us-ascii?Q?zJtNrzQO0eQMSzolTzxrhlyFdTC/3DJfBpQbxiIL61Nxe6UPE9GWa5sQLqdY?=
 =?us-ascii?Q?cFqqoRkpXiM6DzU2CbBRWV6J6m/7bUZTklgBi2zRuR0sh7fib9Zfcq/a1r43?=
 =?us-ascii?Q?YfDjHUyThLHGoh6RqiDeXebIWAdsfSY7llOo0L1mCfyvCV7+CrAatxwajc2y?=
 =?us-ascii?Q?N5hb/22KcO1qOuF+7icaRo+8vCVZzzkHVIxVC/CMmPEivzr8+OcCbei43201?=
 =?us-ascii?Q?mtr5hegYErkGmjhOwZPmnx901LG3KQgeDqtlSHq8IGXoPsMZOMcJkXwj0k1s?=
 =?us-ascii?Q?Mjt7vzsCNXCPcGHjE31GMrepkRy9q3cJMIFiEAs5PiihMlo2URpsOF2qFuPr?=
 =?us-ascii?Q?ueQ0bxW7WR3zJi5h4cwozVaCzJ0fgIk4q5bqxAOqdAc2k1brIHtw14Ln2ssK?=
 =?us-ascii?Q?LcJ0FKwfttlcJ8wVDp6OzOjoXuEZSgGUE1VALthO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c673fc7f-db72-4bff-a3be-08dc99d4c5ae
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 13:50:31.0456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: maLVZeBopMa+RrsVpU8j/xbQiOy8Wvt5KYDBKMV5O6i0AS2xrw4WbCMJXuQBnXVF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197

--=_MailMate_7EC8C024-EAA4-4F01-B1BA-9D6A385F83E4_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 1 Jul 2024, at 4:32, Huang, Ying wrote:

> "Zi Yan" <ziy@nvidia.com> writes:
>
>> On Wed Jun 26, 2024 at 12:49 PM EDT, David Hildenbrand wrote:
>>> On 21.06.24 22:48, Zi Yan wrote:
>>>> On 21 Jun 2024, at 16:18, David Hildenbrand wrote:
>>>>
>>>>> On 21.06.24 15:44, Zi Yan wrote:
>>>>>> On 20 Jun 2024, at 17:29, David Hildenbrand wrote:
>>>>>>
>>>>>>> Currently we always take a folio reference even if migration will=
 not
>>>>>>> even be tried or isolation failed, requiring us to grab+drop an a=
dditional
>>>>>>> reference.
>>>>>>>
>>>>>>> Further, we end up calling folio_likely_mapped_shared() while the=
 folio
>>>>>>> might have already been unmapped, because after we dropped the PT=
L, that
>>>>>>> can easily happen. We want to stop touching mapcounts and friends=
 from
>>>>>>> such context, and only call folio_likely_mapped_shared() while th=
e folio
>>>>>>> is still mapped: mapcount information is pretty much stale and un=
reliable
>>>>>>> otherwise.
>>>>>>>
>>>>>>> So let's move checks into numamigrate_isolate_folio(), rename tha=
t
>>>>>>> function to migrate_misplaced_folio_prepare(), and call that func=
tion
>>>>>>> from callsites where we call migrate_misplaced_folio(), but still=
 with
>>>>>>> the PTL held.
>>>>>>>
>>>>>>> We can now stop taking temporary folio references, and really onl=
y take
>>>>>>> a reference if folio isolation succeeded. Doing the
>>>>>>> folio_likely_mapped_shared() + golio isolation under PT lock is n=
ow similar
>>>>>>> to how we handle MADV_PAGEOUT.
>>>>>>>
>>>>>>> While at it, combine the folio_is_file_lru() checks.
>>>>>>>
>>>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>>>> ---
>>>>>>>    include/linux/migrate.h |  7 ++++
>>>>>>>    mm/huge_memory.c        |  8 ++--
>>>>>>>    mm/memory.c             |  9 +++--
>>>>>>>    mm/migrate.c            | 81 +++++++++++++++++++--------------=
--------
>>>>>>>    4 files changed, 55 insertions(+), 50 deletions(-)
>>>>>>
>>>>>> LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>
>>>>>>
>>>>>> One nit below:
>>>>>>
>>>>>> <snip>
>>>>>>
>>>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>>>> index fc27dabcd8e3..4b2817bb2c7d 100644
>>>>>>> --- a/mm/huge_memory.c
>>>>>>> +++ b/mm/huge_memory.c
>>>>>>> @@ -1688,11 +1688,13 @@ vm_fault_t do_huge_pmd_numa_page(struct v=
m_fault *vmf)
>>>>>>>    	if (node_is_toptier(nid))
>>>>>>>    		last_cpupid =3D folio_last_cpupid(folio);
>>>>>>>    	target_nid =3D numa_migrate_prep(folio, vmf, haddr, nid, &fla=
gs);
>>>>>>> -	if (target_nid =3D=3D NUMA_NO_NODE) {
>>>>>>> -		folio_put(folio);
>>>>>>> +	if (target_nid =3D=3D NUMA_NO_NODE)
>>>>>>> +		goto out_map;
>>>>>>> +	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
>>>>>>> +		flags |=3D TNF_MIGRATE_FAIL;
>>>>>>>    		goto out_map;
>>>>>>>    	}
>>>>>>> -
>>>>>>> +	/* The folio is isolated and isolation code holds a folio refer=
ence. */
>>>>>>>    	spin_unlock(vmf->ptl);
>>>>>>>    	writable =3D false;
>>>>>>>
>>>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>>>> index 118660de5bcc..4fd1ecfced4d 100644
>>>>>>> --- a/mm/memory.c
>>>>>>> +++ b/mm/memory.c
>>>>>>
>>>>>> <snip>
>>>>>>
>>>>>>> @@ -5345,10 +5343,13 @@ static vm_fault_t do_numa_page(struct vm_=
fault *vmf)
>>>>>>>    	else
>>>>>>>    		last_cpupid =3D folio_last_cpupid(folio);
>>>>>>>    	target_nid =3D numa_migrate_prep(folio, vmf, vmf->address, ni=
d, &flags);
>>>>>>> -	if (target_nid =3D=3D NUMA_NO_NODE) {
>>>>>>> -		folio_put(folio);
>>>>>>> +	if (target_nid =3D=3D NUMA_NO_NODE)
>>>>>>> +		goto out_map;
>>>>>>> +	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
>>>>>>> +		flags |=3D TNF_MIGRATE_FAIL;
>>>>>>>    		goto out_map;
>>>>>>>    	}
>>>>>>
>>>>>> These two locations are repeated code, maybe just merge the ifs in=
to
>>>>>> numa_migrate_prep(). Feel free to ignore if you are not going to s=
end
>>>>>> another version. :)
>>>>>
>>>>> I went back and forth a couple of times and
>>>>>
>>>>> a) Didn't want to move numa_migrate_prep() into
>>>>>     migrate_misplaced_folio_prepare(), because having that code in
>>>>>     mm/migrate.c felt a bit odd.
>>>>
>>>> I agree after checking the actual code, since the code is just
>>>> updating NUMA fault stats and checking where the folio should be.
>>>>
>>>>>
>>>>> b) Didn't want to move migrate_misplaced_folio_prepare() because I =
enjoy
>>>>>     seeing the migrate_misplaced_folio_prepare() and
>>>>>     migrate_misplaced_folio() calls in the same callercontext.
>>>>>
>>>>> I also considered renaming numa_migrate_prep(), but wasn't really a=
ble to come up with a good name.
>>>>
>>>> How about numa_migrate_check()? Since it tells whether a folio shoul=
d be
>>>> migrated or not.
>>>>
>>>>>
>>>>> But maybe a) is not too bad?
>>>>>
>>>>> We'd have migrate_misplaced_folio_prepare() consume &flags and &tar=
get_nid, and perform the "flags |=3D TNF_MIGRATE_FAIL;" internally.
>>>>>
>>>>> What would be your take?
>>>>
>>>> I would either rename numa_migrate_prep() or just do nothing. I have=
 to admit
>>>> that the "prep" and "prepare" in both function names motivated me to=
 propose
>>>> the merge, but now the actual code tells me they should be separate.=

>>>
>>> Let's leave it like that for now. Renaming to numa_migrate_check() ma=
kes
>>> sense, and likely moving more numa handling stuff in there.
>>>
>>> Bit I yet have to figure out why some of the memory.c vs. huge_memory=
=2Ec
>>> code differences exist, so we can unify them.
>>>
>>> For example, why did 33024536bafd9 introduce slightly different
>>> last_cpupid handling in do_huge_pmd_numa_page(), whereby it seems lik=
e
>>> some subtle difference in handling NUMA_BALANCING_MEMORY_TIERING? May=
be
>>> I am missing something obvious. :)
>>
>> It seems to me that a sysctl_numa_balancing_mode & NUMA_BALANCING_MEMO=
RY_TIERING
>> check is missing in do_huge_pmd_numa_page(). So the
>>
>> if (node_is_toptier(nid))
>>
>> should be
>>
>> if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||
>> node_is_toptier(nid))
>>
>> to be consistent with other checks. Add Ying to confirm.
>
> Yes.  It should be so.  Sorry for my mistake and confusing.

Thank you for the confirmation.

>
>> I also think a function like
>>
>> bool folio_has_cpupid(folio)
>> {
>>     return !(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERIN=
G)
>>     || node_is_toptier(folio_nid(folio));
>> }
>>
>> would be better than the existing checks.
>
> Yes.  This looks better.  Even better, we can add some comments to the
> function too.

I will prepare a patch about it.

Best Regards,
Yan, Zi

--=_MailMate_7EC8C024-EAA4-4F01-B1BA-9D6A385F83E4_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmaCtCMPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKBS0P/RtyXuyfOTb1W3E03LM3vsewqTlhwZsVC6LS
ZIiKJJmiQIERGR1XIz/EahZz+WfkA/xb3/2jw8m6STijmYjA27d1lxQeyxH0TXK0
Y2vLsWz5tkzuuSk3PGIfLrI6P53FMnCOIHW9cxBym68vaFRLHZ4yiYL6mdaCNd+1
DSMRm+PD6AodtgU09diINRuvYaes6jvv06YBBImRkkimeClHiINagYQPCfitpfHp
8Ysx88A2AjnHfEdgayrqh32hDEIj1vdyRhusBYuOpql/He6dVY76zGR6AQzHIAo5
0AjRVVLQGEnqOik4YP1B+kvWuZcoYwSlMQLgK8W+NaBq+5B2tXl6P2lhdr+jP2wd
eWnXhyJMDvWthW45L8pyBYisRzxtkadyoy0ld61vACiZqw8B4w0Nt3xIp6J0xhPr
R798NINJsAq103N6bFXGV32lYqb61vo89TjhftKQOlXpS8psTjQba7DFX8A5dVmK
BDEDDgfrEofsKRS9S8AInuMp72ox3f6d4uSZ4E93sGklHbo4+yb4r89j9mxrMLW1
M5vmtlBME8aO+RdwP5cy7fX5UWOJQO4iyk83YoYBe+HtQCsf9PWyb0bGaXXUFQq0
u94KdhZJ6qQjCDmqwT5txu74jjCrStA030zemObsfZUKA5/1/NU+xxq+zyR6Ag9e
iC8htiMn
=dhmx
-----END PGP SIGNATURE-----

--=_MailMate_7EC8C024-EAA4-4F01-B1BA-9D6A385F83E4_=--

