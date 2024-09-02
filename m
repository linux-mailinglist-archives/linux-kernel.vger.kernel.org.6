Return-Path: <linux-kernel+bounces-311611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DADE8968B24
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B24BB21DA4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5494A1A2653;
	Mon,  2 Sep 2024 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ciLdLQL2"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD5D1A263C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725291292; cv=fail; b=MB7fpsOmxqZxY4VaIyKUMN7f+tDDICy8CUMuRWbNS7bg6mqgd4QopcKrcmy6JNYHDWWXxqCPBL5VouMPEWBCGiQXZHymB7yD7Imlvsxle5NFEXaV1MYOfvsK++HgAMLE8zm01nMtigFd0YKdhYyB7uzOZUOWPS9ESXYaX79FIbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725291292; c=relaxed/simple;
	bh=9F0KA/F7ceCEnuQHmvATr0Y+fyFG3hxvaJEOuvlhpFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i4qnnOOg+WrdtfALlRzzfsHf5ZM2SDQYrKXGGUVikqrJbcVrFxvZI9OKgdQM5oqKGBo2iFB3uG1kkDFKhWlQv7YBGRtzMuyIRr68ydE141TqA2gCgXC2AFzJsEzQwEBKOHip98OVen/GdxACkFM2lCSThLAbX3NKocsVnQDDXCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ciLdLQL2; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhC4bLVOQVCYI/LD46J6hp4I8IERTAD2gSEhnJQeaYW9cafXpV4q1WIlU+P5zZhpksfU4SkxV5n0TL80/ydN9Ove7fydlPsitj3Wx6La4/qczMG7zffzsnuRrijUh5RmiVyaSK68jIDyJ40WFJtx4U7aO3Qgk2gyWXA2O0pbAZ3zVlbDaZda1mCB61Jv0sGSskBR/MvPdGsE+dzUgVUpdCJNzzddLEjtAH0wQkXk0Wo0CAnHX9IZeBOXpuoB5SdcoQGf+rgsfritE9fSQ+uG0nN569gVXVhO11YnrlEiSlxn5qrPlDHuho67RRe2QdSsUfCDrP50ICdJfhm7nYK21A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9F0KA/F7ceCEnuQHmvATr0Y+fyFG3hxvaJEOuvlhpFs=;
 b=IFzl5VqM//f7eUCPJYAevIndfMb7Hx/T3iYIK1uX1HzoJ2tcEy/RjxPhShVvdZHQIcVIH9NIsLmrYeMI/DjFEd9JuRZwFbi2YR5cYFHNEg+wf+Uu0kqx53pEq140bL/VFAJY57PknfGLkNTuFSLjHhUZqa53LCTi1rWPK5/PAXBGabuOLvYoWIO1li7jn4LawLQQXqEB4iWxn6Xu5BZa9VZ2JvrOFoSPewD9+YtClNOxTPKXw5U5Bnyrx2a7Ro48U4E4dZRKvaFWMZxKqly9CMUmzSFdtCRRsn5b4JNjhbK8JneU9OVbItbRRcrdsVnGKWJN2FbUw2zvPDd5hnpPFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9F0KA/F7ceCEnuQHmvATr0Y+fyFG3hxvaJEOuvlhpFs=;
 b=ciLdLQL2T2KbZVzaunysE3RLVbgM6UWmvKoWO/vL5NDEYCrqW925XwyOqTJUBqBIycVTO7+guviQE/PzFS1LcmbZPFajADKVUJViJdCX/iSb9Iff270FJK0w9XlWnNvvApHQah62bfni6sOdpKuFrfLYHVcHVjz8inM+yP3a5pfebhxAUd4feMe49WGR+eaqpiXPWL8G4rJ1KHUj3QCfe4Y6IGAvzZozgoGEdwfUgnETm9jdrGCRxsLBV+mmBdG4WQqySVfdPEeXuFFVxZyM6gjRH2ZuvonyYC8xHlCaTa/Nr4aaBqNs6zNRbEQ0a7j67h0QBxvT+vLHST8v7SbJiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by IA1PR12MB8288.namprd12.prod.outlook.com (2603:10b6:208:3fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 15:34:47 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%5]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 15:34:47 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Oscar Salvador <osalvador@suse.de>,
 Vlastimil Babka <vbabka@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] mm/page_isolation: remove migratetype from
 undo_isolate_page_range()
Date: Mon, 02 Sep 2024 11:34:46 -0400
X-Mailer: MailMate (1.14r6064)
Message-ID: <D0CE4AB1-7FBE-458A-B851-8C2F237E43F5@nvidia.com>
In-Reply-To: <e4ed13f0-5a69-4624-9fea-20f980ff14be@redhat.com>
References: <20240828202240.2809740-1-ziy@nvidia.com>
 <20240828202240.2809740-4-ziy@nvidia.com>
 <e4ed13f0-5a69-4624-9fea-20f980ff14be@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_1F1B828A-01D7-4B75-AD71-5F90ED447039_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAP220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::6) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|IA1PR12MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: 08220c70-940d-49d5-3adb-08dccb64c714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nHwjyNrB/q4ojmqKVuCbVE83G6YE9ugpomQKbApraPk1lauDIXeAKDthEM/N?=
 =?us-ascii?Q?ge+MQ/oVOXi87Fu5GgUQ50exCoM1MbjkvUl6nZnyFsSN9bv20VMfVwUU31O9?=
 =?us-ascii?Q?fpk2Q686SFxiEdk5eheOvoglELYQivbb3U+rmSEeQFFiGGPDPjgdfsle86P+?=
 =?us-ascii?Q?j/P3dBVHUSFLjAe4tw+JK2NToMSzz3uPqrP+jaMwXRc+92tEIqTX55yVS+Id?=
 =?us-ascii?Q?BBLze0bnbIW8im6bx3/jiSpohPQSwazvSc+90RvucjQla3Lnf3a9Wy8rvZP9?=
 =?us-ascii?Q?4PzWN8GKVs0onZlxCCn7Y4eBoHyC0X3u7XwyBQC1D/gDMxRFCxTNJoo1abwK?=
 =?us-ascii?Q?jBo+DZbEcB670iGY2bexjeSnEuDF66d+pRCC7kIC9iYtZKYqZJBjWrfeNh7v?=
 =?us-ascii?Q?YjCI2dvgOP04MxzyAF+Qlgk0su0F4a32WjENUG/IEPAE5b7myLfU4USkUrMQ?=
 =?us-ascii?Q?rWG+MbvKAmDUPvvTOSDq1TnHbA8LOcU9oJnWbRxf48EjZcbimeVFJUIvNBps?=
 =?us-ascii?Q?Urh9m4RsdffQaIFjDJQGBV8Odfjj05Qt6i4WXoQ07BhIY2LcOhsFcv1zjPhT?=
 =?us-ascii?Q?lyA4XhTxgZqwPQkRtCmxU2qqh0jwety6gnCiRH2b5V+XoKOYiRWf90MH0J1E?=
 =?us-ascii?Q?cQO6XAA6Rmj85J73YJfxl01L0dFoLlTL03A7gynArbsp2p4ymQgCjR49rfUq?=
 =?us-ascii?Q?zJf+JjnkNbvNtm6qrTNgf0zYtibNXpYd1Uu7KxW2Ogyj75oWKXjktnACjKsS?=
 =?us-ascii?Q?CFmsLy450djCrELKjkVDyOYYrQ7LHTdadt3fz+jSQx8qsXJuaQ3LVMorYUDB?=
 =?us-ascii?Q?vLal2Tjnjt6px5zO51Vrl5ovrGQAO8q+mHBrK17DH1YR218yvIUPBFxmNdio?=
 =?us-ascii?Q?gmjge46GoO7RW2XDyjRfSQ8hqXNrlg+3RreQBCgrHtosJikZl8grthl+WXsQ?=
 =?us-ascii?Q?lx6armWQR9IvilztHwskx1zKL2Xck9fLgvQwfpMsmKSs5BWNTvNtLWqgwQGL?=
 =?us-ascii?Q?llx39j38CL1u6gjzBo7CPrLLrmySvfmF5xqi4EUgPaPULN930gTAq7QEIeg7?=
 =?us-ascii?Q?pqMw7eYPya36De0BFYDbe31DeOMcxiqa6QXNUvfsUS6fOVKOfPj3OLugQYZG?=
 =?us-ascii?Q?mxUJcNhMM9GDVWJUd2DneV8PPcvVk08Rlq3OffcaXfem8xe0hr49FHYCGzQf?=
 =?us-ascii?Q?Dv9N1jFaBjeCNi7TDd8R8MgLkPSjh7RJg3HGMQ1aPOrNGyzn6qNkzetcgjhq?=
 =?us-ascii?Q?xXL5uu8/IqLmjTOzEb7zaBwFU4rg8my1p7lZwasz76bWWJhuz/S51W6L2E7z?=
 =?us-ascii?Q?EIQDC3co6iBJJ+OmnCrQFqw1VHWv5QGz5o64w053mIEYrg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S7YFhSAh3x653qQFkgsiX8e6MS2BWH4PtWfvoGw8dHiSuegZ252R8/uv/LOo?=
 =?us-ascii?Q?xNV3ROMCPclpMRwEl86p9kvCjY5yZ6PPY6kFiJzImrDLDvicVut07j3nPy4n?=
 =?us-ascii?Q?fJ+tL65A4M44R+rPg8SoP0aeEQ61+tCs4hkMoBsl/qlm1GclTpLWK4H6u3qt?=
 =?us-ascii?Q?NLIKouptxX6HZHxMfdzO0oqQSWpllaJ5hT7y/ksXxbu7Yzp2Swam39xakIg5?=
 =?us-ascii?Q?54geHEabPnsDxmC0zLC+mfXFj5/qHbYzKift9TtLi2p4/ibkgs0Zhp93RSDe?=
 =?us-ascii?Q?C22Yj9XXf9r+7IBYWlVFFEZijUyoADWgWIvLczSd7zWeTvKwZUtPB4QqJS2w?=
 =?us-ascii?Q?oqCUqqgWtS8d3BChDntc4raPmPrz1HczuewZzXkPAruDOLRuVvuEAn7VeSr6?=
 =?us-ascii?Q?vpoylzPeIJdFyWyCDbQhSVJsGX8Ssf8cNjJVWIKdQ1QJ7DGrS4S58n4lq4Cv?=
 =?us-ascii?Q?f2gZmAS0o69Afj4MOpl4XE9BJLibaiRlvHlbFscLAmrkf1KIS0XY15T4Qgwc?=
 =?us-ascii?Q?rupaCl4bRL6v1Og/F2zXUuwpPimQOlIuUl7MLdOfTFTYZ0e65f4IAZ7pzVNV?=
 =?us-ascii?Q?D/gtn34J+clxgJA2YWue+Qehf1vPVI8Jhz8MrCVNLO7gyTy4R78GkYaXkEvw?=
 =?us-ascii?Q?YKsLaC/K6TIoFH+dqB1p4HpML77OG15i3epLcih5YailIXGPOPPxHOU0SnYb?=
 =?us-ascii?Q?MPANRW2+USlc7dvzK7z0LCpzBXLcUAAbr8Cts/TD5Smznjit9XGZ8rRFZxvZ?=
 =?us-ascii?Q?kFN5WDRS9KBxdBKyK+Zawjo/mUSbvvtjTdvHLyeV/BSD1MyywbfKsbhw4hie?=
 =?us-ascii?Q?mWShF76qeUvpz6FuGx6UqLd3SO9vLM8O5t2vU50vWfPCn3yxjsUNKhYWdkrY?=
 =?us-ascii?Q?vnMhvbQs8h+11AvIRoecpmW6zP958K/EgC7qyK1STtPfbhz9ADB/2uEx5M+M?=
 =?us-ascii?Q?PuF4rXF0e9fKB9ayiTM/9hG6V6ymcyBdCBt917v2+ahxSXScAC98aY+ZCHoQ?=
 =?us-ascii?Q?p8Y9SkKS9pa9bNYbJ/0D03vpuz+NJht8uXOsn+CqqttQjotE+mQZuZ41y+X8?=
 =?us-ascii?Q?WZxHgru1dXF19FuxkwG9zcFtgh+SbLmeHOwmkpQUXUDPHBkZ3Naar1OOpA+I?=
 =?us-ascii?Q?YE23C9vCtR+qPh3zzQuGOxZK1wWiK79nm05fBvRHwbx4Q07vgxaw7rJ0wCuH?=
 =?us-ascii?Q?PH/TYlxtL3NSHDqv6GzW5pK6yU3zUJ6oOpMQjQDoWAHvcHWaz0bqdQwFGymt?=
 =?us-ascii?Q?e+cj0Pbzr/gh80U38fSQUUkA9b2CnSn/uLjfNEvuohCgyUkDMt/m1/2xRps1?=
 =?us-ascii?Q?2lalQtkLmJvvvrKaiOYz3A+DUFFKDpMHT3wTM2cd2MQWogf+rHXy4rTOKoKk?=
 =?us-ascii?Q?LVZEtWVpenN73D8jlhtGd8ep7wgqZ8d3qDbQoG9tFdebgFUgsV60gOm23bVV?=
 =?us-ascii?Q?ukTlsXjQ7w8QEsdMIVDgoKMcRs6lRawSsXYoPyAr/Z6V4/YRoyOAAdfd8jfI?=
 =?us-ascii?Q?RfeY5nSHMv5BdD0UvpNP1o8LDLmyxrmz0aO4nOfhWvSL0NfU/mtStaCPbnPR?=
 =?us-ascii?Q?0SLrwGp1TJ2I12+CVGh4v2mVa0gOiPR/oEbW3k1p?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08220c70-940d-49d5-3adb-08dccb64c714
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 15:34:47.7720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SVbIwBSj6AyfWhxd5ojFWYY1YzAMqJ0CmLPLVBVQ8njPDuVGG5NafG/M448HUQqC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8288

--=_MailMate_1F1B828A-01D7-4B75-AD71-5F90ED447039_=
Content-Type: text/plain

On 2 Sep 2024, at 5:00, David Hildenbrand wrote:

> On 28.08.24 22:22, Zi Yan wrote:
>> Since migratetype is no longer overwritten during pageblock isolation,
>> undoing pageblock isolation no longer needs which migratetype to restore.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>
> Yes, that's the right way of doing it.
>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks. :)

--
Best Regards,
Yan, Zi

--=_MailMate_1F1B828A-01D7-4B75-AD71-5F90ED447039_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmbV2xYPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUD7oP/1IR65zqIq3Wh0BkOhg5q1Mth/5VONzE9cw+
sZC8Z91He0fHxEW3K/y8a1Az5YIC86QlRTZ6L3AHrA46zDv4ND/jwHs6Fcy0TYHU
1iyxbLVmFzPWr6809pkych6Z1EQR3HM1J7MvmmuTmofUbylJPEXkQVv9WJf5q/ac
9xI9To9EADnVPZku/6BNXoB8HV3J+ArFMYKnFa5sVQ4SBoKjlD3R2XD/HVc6AFCx
STrn9NW5jHBBFQz0TnVbDSviWXTrG7zk1mLrth8ggsY6HBugIw0L+L/ToR9qx6q4
JwnEAE8Z2CkkVw8SlHyqhnijNxu3B+0H1jBbbLqUDQY/Ta9C9L2NFfHNZpnj9lXM
1UbLBk4MO2hfUbfqDk9x/IltqqsVuRkvw58rV3g0QzOiC8060bVXaalYmNs9w8Mq
HXwZR0QQ+puwU/a56JLb39Ok9mpKdGNOhYObjN5yI6mIx9J82TRnQ9rDDLcHAMGi
5B994EYvH2fbGleR+WQ0Mkhx5svjFlMvl9ZbY2fzOpf6KlQ8f60ek57RzD2Gsp52
7mEvPCvOVT5xUI7vNutNTFPzSKDsTUCSIT42Hd8j+GgIKKDaekeMVFc4cz2k9IVS
/2nlYV0Kn6yC4GKqyNTAfgTJkV+xilOOwZ78dCSaJLt4OtO3zTiVeY8YP9FpU4dG
6YhNEh7G
=Mns4
-----END PGP SIGNATURE-----

--=_MailMate_1F1B828A-01D7-4B75-AD71-5F90ED447039_=--

