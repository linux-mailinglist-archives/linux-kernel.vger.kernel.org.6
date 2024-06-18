Return-Path: <linux-kernel+bounces-220116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A8F90DCD8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8B11C20818
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E7C16EB55;
	Tue, 18 Jun 2024 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p5V5CfUF"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A27516D9A0
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 19:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740098; cv=fail; b=lDRFOvXxzgKx/Lp23NdnWh1PdnaLHVN8rH0Pesp+tt2RRtj/8s50QeUjyjhbRe2qkaOa6F+xVqUIEoJIsC7mYdNVQ4agHtuJgezfOJlux8ez/a5AonvKDiTzBr3FfarGkPqDTaVRJS+1DFCaitxuBp9JjpjNug6Pd7iw8ZW0mrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740098; c=relaxed/simple;
	bh=44qdVV6ziG+dApG5pNwLUu9WAZNGpsRCrhVeUNdBzbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YVFt0llNJI0xbPXIhXSa7VKG3a9iijbYBZDS3YBa1Xfmv3IXwjkDcftzgrjXWS3i7gF2Y1VnSl5JdROEcad2/yJFoMiI/XFJ5cgYlMO27oNAbAepE3iU4zHIyVSS7Dsvv7YSLQk063kEpB3Mzi1Lm+kZDEsl7g8g7mzuf/xwE+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p5V5CfUF; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PoJvmoBGzhXIflBdx0CcbtgUeuD6ZMv8AIODyU3EZe/COF9O4ABMzEf3jEaQhj2Bw3ahBN70mmlkbdPAOLksa7pfflB7UiwNVeLQitZVQQXiJ7yi633TkUX+PWlpqZlBSySkeR0FtzOL/zyLziU6wlYmYPmZQ8PX55ygEIsjCIeeD/XAjuNkK9bR5bSD5KUyFf4d79KrtydeDO4fAXiwPspTShSlFq9hPohDCLprqmmSFbzW/em1LXCA+RsM0fatveJr088WKfWO7GKab7wknxADElSnBPzCK1col7zAZkvRGaK5Are/P8/d4TueMboouivB6oXhi+mBsDLJPSNgDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zozj8OsHhApv066D4GevwVNwqaPaSaMqnVD1gVWdJZg=;
 b=cZYKscVyIc9J4RAu2WvEoO+VdAFT0i+9DsxRXYk82TUJEMK97McHVrFcHJ1Vv7mL1TP3Avvlnonq/KpBgRsxLNirZ1gkp6PwXYeTXyIh0zPggXGfrDAmcPiwZaOE0Y1BDQnlE7HKi/dgatLYtx+8E4OysiT7xVJ9PutE3om98KSr5PC6tkBUuiyyVzMHAAW9q3EsTduz5oX1xJm5wRxJzSWvDKLam+5wlxmtIlD8QM2nqTDBzI01lmoz5I2mmjapmGrudBqOikx9vtghZ6WwPzB4T4oWnWYpkzUYVy4+9a3p6XsrWzvCtQ3CDbglUjmhoOgzx5x5eGHpuVmKm1cVEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zozj8OsHhApv066D4GevwVNwqaPaSaMqnVD1gVWdJZg=;
 b=p5V5CfUFiGx0DhjQXMEXIoP5PjMUZZWDgtBQCIDvg3NbPzYSM7b4+8AVLkEFewE57FLcIbnS1z+yP9Per3vAIXeMkErfsqiCaYzFhu/9O637fDpjgV2qxbnpXzfo+uTXF4rMgPBTsHQvkmV7SXKTU4kdLFU6/aHOFbk+6v6SQiWdERcFnGqa51DP7JwI+yyeresoomRqk/ZT2dBVLibGBC8u7iKTGMG5DZu9x1vCpPalNu1VGpbB4d2YCAarVN78A+SJSe0JMGgAf1tb8vwGJubhV8Q+b8Q0jlT0HHuHYaWtE0iWyjv0U0d7OdkSux5ZrTI3cwhT4ipc4WkgzZpDOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA1PR12MB8333.namprd12.prod.outlook.com (2603:10b6:208:3fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 19:48:12 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 19:48:09 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>, "Huang, Ying" <ying.huang@intel.com>,
 linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, David Hildenbrand <david@redhat.com>,
 Yin Fengwei <fengwei.yin@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/migrate: make migrate_pages_batch() stats consistent.
Date: Tue, 18 Jun 2024 15:48:03 -0400
X-Mailer: MailMate (1.14r6038)
Message-ID: <D1935798-D0AB-4624-AAAF-660CCFEBDFD9@nvidia.com>
In-Reply-To: <20240618124417.08745f6c08f6ecb2c959a096@linux-foundation.org>
References: <20240618134151.29214-1-zi.yan@sent.com>
 <20240618124417.08745f6c08f6ecb2c959a096@linux-foundation.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_25E27C35-87B6-46B5-9FCE-9D8FE66C0AA9_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR02CA0111.namprd02.prod.outlook.com
 (2603:10b6:208:35::16) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|IA1PR12MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: 47409328-7292-4569-edcd-08dc8fcf9455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z7/vw3FeaD5Wa9kAwa6wsCjmhGJxI7YLQ3DRb2QROnpkdvpAfJgnDJfHmeOa?=
 =?us-ascii?Q?71EiM7OGEbTXWEed3zRLsEa78/ux6Kw3WaYAbJWzkIEyUV8kqlgvjye/vzmf?=
 =?us-ascii?Q?UWJLKjDc36jxzHuiv7RO9sWUVGPWt/kOnlOys3DqBAvIANyWLOSjMRrKWL0N?=
 =?us-ascii?Q?szyi19d3/ulx3w4WZmRszxVnK7GD5sFYuNCnNmZdw8GmfhdTTDGNZVv9gi9T?=
 =?us-ascii?Q?zzxo9w/q+HOTkfgBpsBX84cV9NOOD2mB9R6GAccwW1jKfIchOii0ldIa3rsz?=
 =?us-ascii?Q?la3sDp1erM/l3l/Ep0eTL/k+jCV++SdFmeNtyRC0F+bgzZ6TXDiXAARh2J1+?=
 =?us-ascii?Q?tbwC9DEFlgl3gHKEWkHRJzZn/8xv97k55KFrLDFuxhDr3O5I04hqGsI607QQ?=
 =?us-ascii?Q?6auF6ErtmCstweGcTDpJULJUByD/sZaVLfBq1FVKbn0pnCXd+ZIoIO4M5gDe?=
 =?us-ascii?Q?cf7/H9aE0f24x6G0hBSYGyMZlR3r2aVhHI3cusi6q0JWoKexBPkpkv1Cj7Ni?=
 =?us-ascii?Q?owqglPu1kE/XJQwpmdmf9XncVa24goKAUQSpbMT92gI9i/mvPnNfb0zv0Pp+?=
 =?us-ascii?Q?u2PH4EJmWtd/OBUqKRf6/Hp8alZG7E1sFp9errbSYnQdr+ByDEaZnnbkkqd/?=
 =?us-ascii?Q?TKeAjBU1EZwMGGz1KuA1ZuD754XOHiRUFCBQvw/3jlkyc/R8tX9EpmwPWknA?=
 =?us-ascii?Q?wyuwmyEWX/Asp74gBciZ+crHbt0eaumc3jGrTOf14hNcMynBgESr7vAzQpCK?=
 =?us-ascii?Q?rdrxOhNkoKO1CVTOZuaby8g5Fvx4Mkn5EE2iFHH7fqbR1Phh5tRG184GJCNm?=
 =?us-ascii?Q?Su8vHVGSr8bQNBaXz7LFZR/lIU5y7gMVeDdtV7jx+Rp8bvcr6asY/lVWc9zA?=
 =?us-ascii?Q?XzHg+aGLAqJ0mk6yrtsQkSl4tGZ9FeLsyMVxtW7sAmSUMXg5p5k64RopePKk?=
 =?us-ascii?Q?LRAiKZFMyAL7QUUCYjW8T/cCuCwYYm1kjiB57Wf8RsPpnBMcTPBqx++c4fUP?=
 =?us-ascii?Q?QlDQz5r61gpDJPt/XvwT+jTVy+WUpryGm57w6yWj4/0ZJnQDsRGh5Z3TBlI1?=
 =?us-ascii?Q?S467GQN++caUXnx3arT5O1QZFzkjQMAwWCgPmwlnt1q7yPhfi9yKHCxuXXpe?=
 =?us-ascii?Q?yZm5O5V7EIGJQe7ZyXAxa4nA4doapMlfl8rWfVYAQYFphRSmJVzj+bpx42A7?=
 =?us-ascii?Q?5CBdFaBubSrdruqWARxLzP47RvyBfVR5gFrrDs93AHMXZUD6E6Itw9OWqJya?=
 =?us-ascii?Q?akwHdNxvvAVtY9fj8fYiN5GR1in/HAuNIKcgYPFbaWP0nhXBHf193GGYb3pB?=
 =?us-ascii?Q?HIg7UipJMiYfYe4PTaLn/iDe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cEPkdPJquur9U4KG0s5trXcybDe5y3A3P6QEFVi+XP/89NGv2j2tIkV8SnDG?=
 =?us-ascii?Q?Oa+IDqewPneburgBh9tpf8VoNZhGJT7H9xFyY+gZbpIC1R9yRuNrEn0wf1CO?=
 =?us-ascii?Q?yUcm5wT1UXupIWb4fPeLqb5/Zu7R83f3fH/FywjxaozhF+Hji1FLce8xlsAZ?=
 =?us-ascii?Q?rxZ8rhcmskTiDmMWFjyocE/Il2nK8MuVi6JSD3bPHVmHoi2RlTGwT5jX5tII?=
 =?us-ascii?Q?gVXUu6awdkRmYHNDUYoG/+1TMF2JoJhhRDjKePSfAdgQ4hH9Yn/tUmr0Cyin?=
 =?us-ascii?Q?kmfE3JCRJIdk0OpcSOKZvmlmUpChFY3Ijra/jQf5qKlKbwybUOD+7wyMT3kk?=
 =?us-ascii?Q?34pyNrPKzU1TbsxtM+XaJNJecVf6XEx6YHBIUfSDbq53r5T/L6p6sJAevNGH?=
 =?us-ascii?Q?BrKEqUtDz2EBDGZFqomLtx+X63QWgmiV61E2Hd/X+ptbn5UgUeNPXw8fd+Hq?=
 =?us-ascii?Q?+SaGEBhnX1ur5KZ1ZZ7HgJbnyb6NdoM8ZcnUitBPnHTGZPPwhM42ACLJl/Do?=
 =?us-ascii?Q?ScoSkipOx4VoYyo68aCSKV859sRSPTmwxF0UpPuZ2jOXemOU1+UCKjfVPoCl?=
 =?us-ascii?Q?hsYCemviIhefajDO89N4V1dyskQ878IOqds/4tCt6L7oa6JzgDZPTCETNJ5a?=
 =?us-ascii?Q?dwX7Fd/oRRcaGkBiQYniIlVMIcXSS5E9LaTRhtvmJeqQTsXKaoSeyXIXy9O9?=
 =?us-ascii?Q?k6otUoewuIuhH6OoYqo0m7riO90U4Ob/X0s5auoJNTu8YjPs7/i5ry/WNXAG?=
 =?us-ascii?Q?NVWIG5ru2ZuvDfELCNYVOoa/jQVhI56//b8RU1Ni48bDiHBQ6IflkpGTCnB3?=
 =?us-ascii?Q?o8v4/SpcVjJlbiFrucNmXwifcd5ksjRMFHgig1pzqL2rqUwieWpxZjUeYXp8?=
 =?us-ascii?Q?vvhqsjS1TJzTGrqix845tPWXPxlSNelxlmbnGPjvoiCXhlyd9EljoRiBHwZT?=
 =?us-ascii?Q?OGcGcucAjar2L9JWhy9aJWezhHTtzQQHcSkJ+0DZELNFy3GQAjEt7+7ZSFqJ?=
 =?us-ascii?Q?9gu0EelF/lPyqMQ+HqIfY7pteKUx32aZ8F3WYC9cB3jLC8m63O4ecWWRI09r?=
 =?us-ascii?Q?qdU23oHhg96xsJuCNAKzyBvlBa96RWoh9WByV8hVgtNjppqCgl1oOptaiyKM?=
 =?us-ascii?Q?p77Pdp4zEbJ/xft6BQqdDvZensIgshF6IaqJZb1QyUswPz+JakbthM8D7kZw?=
 =?us-ascii?Q?o5TOJhbFSMJzNqgKZPvPuxl6gBRPpLEDy4AsoufJCbLTZRicF/+VBoeEl6a9?=
 =?us-ascii?Q?F5d5CSm971rSjJs6dqqEBkbvUCMQ3gbaNKnnMrjG77+rK/CG5LHfsMBcFK66?=
 =?us-ascii?Q?hLmjLZtjO08uyXS/hl0W5ZcS6z8mHZ96Ioa5CygpPd4R2vOzAQBgMFVdnptB?=
 =?us-ascii?Q?dLS0VWNfNJpuIb4/Cx0yLKWNpzICDQhH0/x3QB6BIkzCyL7ddD0zcxa5aGJl?=
 =?us-ascii?Q?NeQoo9mUNHrw4lFRlNrOW9Vxh50HiAPdAERIwFXKcmNAJVwAdTHjr5O+w2Bv?=
 =?us-ascii?Q?CJLcExVbvPRJptYFUGCkAK3XrdZCuSNviIhpW+tp4WV+n3eoukHm4RXfaDfS?=
 =?us-ascii?Q?V0Ky51nRWaGvqCJVcVc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47409328-7292-4569-edcd-08dc8fcf9455
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 19:48:09.0637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7rW8hZHhtTOdLnq7QEHbdrsnrlNQQnttUSUXttWkpxdxvbbOkok2yzC7fSJ2KWIL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8333

--=_MailMate_25E27C35-87B6-46B5-9FCE-9D8FE66C0AA9_=
Content-Type: text/plain

On 18 Jun 2024, at 15:44, Andrew Morton wrote:

> On Tue, 18 Jun 2024 09:41:51 -0400 Zi Yan <zi.yan@sent.com> wrote:
>
>> From: Zi Yan <ziy@nvidia.com>
>>
>> As Ying pointed out in [1], stats->nr_thp_failed needs to be updated to
>> avoid stats inconsistency between MIGRATE_SYNC and MIGRATE_ASYNC when
>> calling migrate_pages_batch().
>>
>
> Thanks.  I'll add
>
> Fixes: 7262f208ca68 ("mm/migrate: split source folio if it is on deferred split list")
>
> and shall queue it for 6.10-rcX.
>
> Please don't forget such details.

I thought about the Fixes tag. Since Hugh's patch fixes the
BUG_ON and VM_BUG_ON, I did not add it here. But yeah stats inconsistency
is something needs to be fixed. Thanks for adding it.

--
Best Regards,
Yan, Zi

--=_MailMate_25E27C35-87B6-46B5-9FCE-9D8FE66C0AA9_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmZx5HMPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUPQgQAIWxbd4bOc/5GV7nlPIu1+ybgUcKvgW8caBD
PVaPjKhz6KmI016KEmF+YgVQ1356qDLTkc6j1Xy5pPkA/38k7YLFm3vcG8/B490Y
26egLfHKb9uV/lCrnSl0Q4hRDRrmWS4MCLDx0a4dOvapODvGlJBC2z6s8DVX9+e+
uDR+7hOvGHXRFDEeRckwWWmRbI/w0W9t83lImt6McsjaACR8Ec0ED0qDb1AnKY1r
QD4RN/VZT120BeEQCA+l4MRkie8meXCyofXJFyZQV4ZSlmJz86ZZyqUMjJ9jCzOs
PCnpnsljTJW02739fbzErVJQiXQncGPyFRqMFXbbK5E2gE8B709miHyaFAe8lZnK
Rfyeg1C39UsE/qgbcQwK/OI+BfWCv5Sym3iqWaz0slmD82xcSwYgG6w6SVTc7CvI
ml0Hz4zNWYypWwZq2mO+VkJd6UGQ1fvt8H09BAs4WUYsjA6GgIKBW8MLw9QK1sX1
vMZi6U1kDHmu9Iy5Yll9qppLcTz11NXET+zd3a5cQF2DOmSY6mrp1aFo9/j0vNq/
JptagstlfNOBZqP6M9qAtuymhZG7B3m7F23kYZrYxwyNUEGesxbkVfjYGvKT1jbW
xHC6XvJUuDxt482nYsf98WbiemcK3Ndxu4+ECPLNMlMc80adAY/BdORf8SgZm0f/
WjeYvKWY
=CwEy
-----END PGP SIGNATURE-----

--=_MailMate_25E27C35-87B6-46B5-9FCE-9D8FE66C0AA9_=--

