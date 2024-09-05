Return-Path: <linux-kernel+bounces-316421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A8C96CF59
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 394701C228E0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 06:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC4118950D;
	Thu,  5 Sep 2024 06:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="kGexVgTV"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022091.outbound.protection.outlook.com [52.101.43.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A7838B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 06:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725518117; cv=fail; b=MgCFerD1LgvFeyCCryfVE16hA+zi2EXY13cV3fQtPL5TMctszZj3Bzt15S6uSS2QIHVs5r/OgKcNKc/DCNp2TLQsgmPeqhFZC5ZXVDOkQrjSSGhO+KDa0vE6R6FxI1qNMzHq4JUx6iWZLhVlHD7+xFcbDDb3BJdlEP+/h4LsY4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725518117; c=relaxed/simple;
	bh=L1//rCH6iPwjoPRNjbXiTQZy8soJ4iXQZJtGvrYgDYY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=A9T1dAJlay9xapu97lLs8hULqJhoWR4g28aef44uVVCaow4IJeKvjLyQp5TR8BZIQOw96vapk8tlvhdkVU0z6Zmg0uRbVXR7NYxMByv9V7P5/LE8bkWL8gC6wB+68Fh5y8vvChI/0rn5dRYjEFEYWJ/CRGDftDutzSkM+KDVdH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=kGexVgTV; arc=fail smtp.client-ip=52.101.43.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8gGI15JLeSURh/jzZyU42vwEIswLY+DRjs9E7ecUSlM+iJlp76NDIPJ8sy2yNjDbQTOY2U+bt337fwCkQUkmbTH5er+SKSENTRhd7e/AikVZxqQ7AOZbm+e7aJLlMl45MU1hruvslMlwaC8eRqSaHIeEFNkOjM52x9dY1vMPIfUJHn3X3iYB/xZgSdc3tAGxVFA1zDJwcIlKN3wekal95xV0VBYyK+/dZPBx8jQvP9r8qMH4iIgooWm4fY1P3N5dBjhmQCiQJCSZxsl6H0MPWHhUMOUwZVACaeP7H+Im2aYICLj1g9C5lsr6T7P8QpqNveX+Lr2A83yZdaSgUt5fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8t6lyviIgxRjR90QY38GFHfZyHhcDiFDPKdz7EMLPA=;
 b=dbxHvdu1a4G7E4t3o5N2sEehesru//xQH1kSflcguEAsr5QkMG+YFLCt8Oc1NgM8bQnizw5nSk4Oo04ciflyIvKpBV2rqpA5B6eUkSbik9GuGzgD1yveAhXmAKjC/T8YHb7wflIpbkhLp1MaZkG/rO0UrHAMtLHMvLgHk2Z0NgtckIhopplie77hHaGwO+BhZjBCJooPQr109TfyjftUgKiTi1xN0FcpXR00F7uRUw4Vhijs2OMpAp940pNeSCgMHHSUUYcLVyXN1QYFQQVuWR1KuJQZW5fkSRRN/nzDogzUuFLoor/V+OPg5Vbff/oz2jL0xcH/3MXBs//0ZBw7cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8t6lyviIgxRjR90QY38GFHfZyHhcDiFDPKdz7EMLPA=;
 b=kGexVgTVSx6n4zMqnzFwIJ5sOTIx3j9deZ99Ndl3lbLTEKfUhX1sN5hAaJSTf2WmuiDiinZ5ULm3clIepITFv7N2URLlT/83BkOfIHiQ4p5RchofY5O95sGLR+8S8gYjxfOAW5y4Zt1rbBBM3D2k7gKm0OHI6P53usNPOjeEltk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 DS1PR01MB8797.prod.exchangelabs.com (2603:10b6:8:21e::12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Thu, 5 Sep 2024 06:35:12 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%6]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 06:35:12 +0000
Date: Wed, 4 Sep 2024 23:35:07 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: will@kernel.org, mark.rutland@arm.com, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
    ilkka@os.amperecomputing.com
Subject: Re: [PATCH v2 0/8] perf/arm-cmn: Fixes and updates
In-Reply-To: <cover.1725296395.git.robin.murphy@arm.com>
Message-ID: <c34d8d0-aba7-aced-f0dc-746e26d9f699@os.amperecomputing.com>
References: <cover.1725296395.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: MW4P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::28) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|DS1PR01MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: c624658d-1abf-414c-5b7e-08dccd74e4ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B9XvrqbJWHHJXzLlhdm1Xa4NhmEW5rksObRGJ9rGT4xR0UE5emVDpqe/4fQi?=
 =?us-ascii?Q?AFET/NFqWzDXYgoS+vhyi0SyeOqUfWhNs5hh3URNBy6quO5virmo98goV+4Z?=
 =?us-ascii?Q?p2H7gXloLrTBBKAu6HSnk+RNj18ZkwCoH+h0cmf6jQ0GZY9s0ecf9DvRxtYr?=
 =?us-ascii?Q?dUTP9Wgxayf0+RtcZiklzkbz3vMbQs6FvgcELwy6B244sqH9GMpZke/kCPeo?=
 =?us-ascii?Q?h+9WjuAArVcAWquMkAhqXfddCP4P6ek3EXcmfXOLCnhEmc4OfMC5leT8VZEE?=
 =?us-ascii?Q?Vx23nMBZkpQB+cY6C34nnlrkOnZWuWjVYBEe6aS0WyziqhEcIugcLarJ0TCo?=
 =?us-ascii?Q?fgai7qK/BtrgRMWqi0HChZG6fhatjwiwTjqCM3KR85LVuzPh0tAIS8t941ph?=
 =?us-ascii?Q?YABzYllUWhek3BSM60n0i3Ae2gJ7VzD/BNIdw0hkp227yj7po64yBx0+MrFx?=
 =?us-ascii?Q?iVvnLTQu5Z95Bw+G8uMpqdNj/rboYaFZsIbBT3T1sTFKLCd6rSeRXg2Vnfi2?=
 =?us-ascii?Q?UTQhFuUaT9cE/xJ3QjLS2KYjfkE0lKUsY42q+x2jEl3G0Als6vBCKn4fsXpP?=
 =?us-ascii?Q?gh0Uq04Qh7dJo0fZfmoIFRLQ8L06aCVMkIXNGuDz4QTeJh67+zrYQ9GJuHVZ?=
 =?us-ascii?Q?WXYT5n7xxRazIS5ZkbHmsD5nEQDTblDvoZOm8kTCwXHvdSsfEm9mwS/Ei194?=
 =?us-ascii?Q?hQqaMpOWx6BhWvuhDOTsUtk+/KG5u49O9L5vTGCLXbxExF05CiKZYgLIUgP/?=
 =?us-ascii?Q?Au9TZDStyzv/p7/O17Z/syoo8b8nfQJvT+bBMuwZH6+oM9EjHBSC54X/N+zZ?=
 =?us-ascii?Q?Be8zN4KBfxSr4nizLcJJD+gQrg1qMDkvM8IiUdrkuSnP6cKqaabOTn+CNcmw?=
 =?us-ascii?Q?2kjYWhn3tECM0WsqYxej2kA8o0DKUW7/Wp+1SGJwZbIPH3AtmrnXyAncyWNZ?=
 =?us-ascii?Q?3g+DEVnVD0+zqWgI0IUx8tvktxbDKi/9wyz2pjwosedABszlwtnTrm2VaB7T?=
 =?us-ascii?Q?VLdJxzUGvFB76S235AmXTWsGAS59SvsvoIb4R4p4QmjM33o9niLiLbDWBlFa?=
 =?us-ascii?Q?yqhI/HDeIAHvp9P9vEktsMvc6rqqj1oC8UvaKLYlN4uIpGvRWSte0PQ5MMZQ?=
 =?us-ascii?Q?coZbuF+glqA6vIU5/PqLoUg+2Ev1mNAC9P8h7+K1KW0jqRe/Y1U1wyl9rsYr?=
 =?us-ascii?Q?hiajR1vRDkbEt3vifnBdeHKybWKfvTvRDPNquOSqGtFqTZy0akbK/Znp1Y/D?=
 =?us-ascii?Q?XDBTsEuwtFWd5MXGscd0dpo1zid3li8/RdKaOhgEqHME4yduDbwAZj4avxzy?=
 =?us-ascii?Q?RPsPKYDefTQhhaWwWpE3CrHDSApZDVgUnHlDU0OM7mOGxohZeSteNWScY6A0?=
 =?us-ascii?Q?/AVW2SX+z3vdlMsIDHtupWsocUO899NfipcH+Fvc8VeC3Q+IHg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NR5vxhRiFZ3kEeWTf0MyT0aUWjBM2f8dyyu0H5uV9k0rPp/4cMqMVrtOrPyx?=
 =?us-ascii?Q?2YtiZ1Ts+oemxKvcTWjpe5HIN6/5n2qQa4zK+wmUHCxl59XtPbUTGILZRGkz?=
 =?us-ascii?Q?W+0ax6ZaDxnKIIG1A3WVL2Kn0MopzOC6RIx8ylstIEZTktf4rYWa1PlhPNnW?=
 =?us-ascii?Q?BIWitsdzrV9iKsPhOR8DpM/QcQdbJhHIc9bWDZnSsALSFPYW15+W6cpFVgXE?=
 =?us-ascii?Q?rZ+T7EsiSUJdBVZX4m6dBPxp8RToW/f5kijYKwkI2W/JxcuF+A6JEEzBP//D?=
 =?us-ascii?Q?BD47TvJm9vCgjkxhemPeM+0kW9ew25qYFVMmVkcNwpqMjEpOSppwOY7gfFO2?=
 =?us-ascii?Q?Q1bGX2aDa/l6QLHQQ57afNgw/9D/ywN0D7Z2RE3bvFbTZUWjD9H3nyKawQEU?=
 =?us-ascii?Q?gb8Ud95YM8GmCyAyygDN3hCr75J/tGixRf/w5DBK39QZLwcKtW8PsdQEn4aq?=
 =?us-ascii?Q?wjuY8OWwDQt9+e/gUWaj0Il6UkBCrltgKuTRDAObrhz+zLZwCFiCdvGelXDx?=
 =?us-ascii?Q?cMG8BFaF9CXt96301G1sgPmrJmzJtEOm+aoSVnD9zjpgSFWN5AKZP815SSnH?=
 =?us-ascii?Q?LgtncNMox6p2Cxk+jNzIBOOhoMvQ34fwpE39Zk3vtLT3X9MPgLwjeVjBLyDV?=
 =?us-ascii?Q?1BJ2OijuJDlqSzAhbAoinRXn4cqhW+eXi6ZzrdK8cxBEVbqC60a0vDVDknsn?=
 =?us-ascii?Q?QH0nhLNpq9EI6Y2pqlXjm6/fw2xk5q/hEclrIDEOdYC24u4CexhK9LiF7sQD?=
 =?us-ascii?Q?00ZXFJgxPL8icdF2uxHJUFM1FTebA0ALmZliRVfJ1ghSY2BSO7jFmurKHf0N?=
 =?us-ascii?Q?jhJcN0jL0YbO87RTgTsoP72gQ2NBZgsKTvNYTZD9B/hz8sat7DIMg7UbZ2Nr?=
 =?us-ascii?Q?ZDPIQ3nFbVmy+7yp50DJXqwv64Myt93zNGzixLdrIgzsFztXTj4A/TQGjJIu?=
 =?us-ascii?Q?zqMzk5TBU8OiXXuQdGkjiolWGvQQ8caNNEUHn10j2v6vb/dMnQDgEaoB5Ygr?=
 =?us-ascii?Q?vi0GRBMWHvi4coMp55dyFZ/pL58TUVL4ePyQ9eGuihw6Bx1+G6YyTTLiOHdZ?=
 =?us-ascii?Q?sDFcLwmKUHRXLmE6yHRhixHcX2Ql8oIkGeMdVEqrbnKOPmlewDpVirvkJHeo?=
 =?us-ascii?Q?IcdVS1guiSy99h4j9abr546nSr3aX/voGi5Iy6fu3fsiKUAd6wuQ3VyEeRB2?=
 =?us-ascii?Q?Gl30cgWAst9rV9JqxI5HcHmPiIZ17O1CI3pRxyubTCJwSO6D6+e/GkroL/kL?=
 =?us-ascii?Q?lY1me9TbjKbCXt4vq928f1bC0I3QFPF7lR8IzPziV6m3KvFBCn396XoSi8yu?=
 =?us-ascii?Q?ZVn2vLoIKSjm+o4Eeb3QRtl8ZtU3Pp6RQ1xP7tFVHPgD0LdPe8mTRvOxV761?=
 =?us-ascii?Q?DQ7NAqeLypY8K9qF6gUTIArgD53rkEP8b4iPvImUZVMlHL5NInoH8f+qjOEV?=
 =?us-ascii?Q?6e9c1md/DybuOizyW+rp7Ek3xJcKG4yGoDVCtwkwXFrkrH1qCARRNEDyOikU?=
 =?us-ascii?Q?JqTbSlgSIKJEJDI7MHzZv0ghipB8pSBcdyzYH38hnEJWVAqzBkX/DoYkBtzO?=
 =?us-ascii?Q?1c1/CvJk07J2+S6JF+XlJ2ai2jkhAiUZPYePArKtXaKUOZTFhtaFIrmnUn8v?=
 =?us-ascii?Q?wdJtr8Z6JObnrcEXSc/MMDg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c624658d-1abf-414c-5b7e-08dccd74e4ee
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 06:35:12.1283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdzwFtw0p8rVlsTwDhkbOt9GuVSBlhJrAntYFSJOkZtGBJOwuZtt7LFWg2+K/qEaWEp1fRtr82Y9kVKF0j3qTirywYxThx4j9+PJNw0h4HPAPw/1LVDZwz/ypuNGidVd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB8797


On Mon, 2 Sep 2024, Robin Murphy wrote:
> v1: https://lore.kernel.org/linux-arm-kernel/cover.1723229941.git.robin.murphy@arm.com/
>
> Hi all,
>
> Here's v2 addressing Mark and Ilkka's comments. I hope I've added
> sufficient clarification to patch #5, but at worst I'd be OK with
> landing the rest while that discussion continues.

I was a little slow again. Anyways, the patch set looked good to me
and I'm glad Will already picked it.

Cheers, Ilkka

>
> Thanks,
> Robin.
>
>
> Robin Murphy (8):
>  perf/arm-cmn: Refactor node ID handling. Again.
>  perf/arm-cmn: Fix CCLA register offset
>  perf/arm-cmn: Ensure dtm_idx is big enough
>  perf/arm-cmn: Improve build-time assertion
>  perf/arm-cmn: Make cycle counts less surprising
>  perf/arm-cmn: Refactor DTC PMU register access
>  dt-bindings: perf: arm-cmn: Add CMN S3
>  perf/arm-cmn: Support CMN S3
>
> .../devicetree/bindings/perf/arm,cmn.yaml     |   1 +
> drivers/perf/arm-cmn.c                        | 308 ++++++++++--------
> 2 files changed, 175 insertions(+), 134 deletions(-)
>
> -- 
> 2.39.2.101.g768bb238c484.dirty
>
>

