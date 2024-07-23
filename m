Return-Path: <linux-kernel+bounces-260428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6049193A8CF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 23:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0A42821FB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 21:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3231D145B34;
	Tue, 23 Jul 2024 21:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uRF3pkuN"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA6413D503
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 21:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721771063; cv=fail; b=qVCx+rSMovAOl1KWG2Ev30JBOUB3jLZsuP2tOafTiXMlHFerlf5GSyyi1k2FhFPQGnmKE30nBj/rOudED8NKaB1a2Ufa1PapHOSHcMKYsB/tQF9n3MPUha9n2BKvFWbmyqTfrUgrdKajB26pG0NIkozAGIJDCbQbn+Ek0R0o30U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721771063; c=relaxed/simple;
	bh=zxSaCxAe3iDK7/OcT/WsVRxB0qPbpZiadR6p4R8Ys9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X2xbQLDGqVJHn0qesuq8vx7MpkwVB9xkSOcHTlROB4yURjF9RnBAHml1TTn7Jht4mGA4zRfanLK5oPZt5ZSbmuNN2tCMmRlpfXbfAoUTWTwFugBFLmgKzNRaAxm7QF0hAjKQ3kpmIXvJ5tZtBRhVS2//ysq7DfmR2EoxyQU7aAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uRF3pkuN; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hG1ioK8wvmQG5QR7dr7471QHD3xM43zKwldWgzJR8/yVXShUzA1b0kv4C0XQN5EMJ2rTeYxqi6GxEGM8tANK4KDztQ8rVPAoia89fhNH4Dz7Id0rMUCOMBXBsmqIE2c7HGBDJD7cQJbKr2mvFCxuvRYhfAv/LwkHCyaLJWSlc4NOlHs9xgdkXxhH8RpbdC9H1FgGgUs3keuQftAVoHUGvetjzKMydoXMDz4a4r1q2ra1QX8rjeKNQIK5NTLBZfB9yidgih25/ZwfdgM33Sc7WwcCvRufsymu9NEDqbKRVJqCkCRUUZjTPvgjW/K34KgdmokAfdI/UV5NezJCtikncA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwynSQ4tY205xsi9EEPytKwW7Ggu/6IpKQIDUVB/2RQ=;
 b=m2zYjZ9XORjMC3782t3oGbQ/NUNLWEvGBJsSwpnNz13NuQlLwHs6p1NkM6lLtX6IbjbGakBCDylFN1+1AAQULs4KGw6uOVtP+/uXhbCOyGz88MhiLEHUaHw6tq6Xxax+yx5GY7qs+n3ZMomRIwpkipQ8vi/xyHFI6CmvEDP4Nt+1LxyU1/3Au+6uRse+S5w7yYQ2Nnfz2lViEps5qDjTbky6BEbezwqK9d9ST8whTd9lHJK03KghOvtkFw+9j76Q6NKHy7iwQPuB7ltYFhEYJj+Wev9NfwFtQXNb/kh4dPmLfExoJIqzvZ+wHx7172798JzLedCzHqjEsynUOOf5Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwynSQ4tY205xsi9EEPytKwW7Ggu/6IpKQIDUVB/2RQ=;
 b=uRF3pkuNNU81rn6LvODYLIkSeB2JbZGnOqtPv3xmtyEizIbdmQ8qNZnvdC3zEasbEfndg1HX5yEQztk7srinOJ8ZJrJBOnFaev+6ugzH6lZ/lLwofQzXh+x6rhsMLCNY+cT1IOsfluVATSGKBIilt+USKm4yVfnxO8mVooTMekYsVeeRoC8PICI6932ZGl/z4Yp/cz+BLM/d90bKQiHJXcKInTn323zXsbn3MJH0C+fHxPXq3fkwlonKerapUKfO3sI9lfrybqBuCk5zqhS/fPm5VqnxdrqfkZBOBPKHJw8TtvxqwEwrvViVAeDR4T17N61OMIZpg3XCOeaOCBUYxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CY8PR12MB7243.namprd12.prod.outlook.com (2603:10b6:930:58::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 23 Jul
 2024 21:44:14 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 21:44:13 +0000
Date: Tue, 23 Jul 2024 18:44:12 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Yan Zhao <yan.y.zhao@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	"x86@kernel.org" <x86@kernel.org>,
	"Tian, Kevin" <kevin.tian@intel.com>, Pei Li <peili.dev@gmail.com>,
	David Wang <00107082@163.com>, Bert Karwatzki <spasswolf@web.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] mm/x86/pat: Only untrack the pfn range if unmap region
Message-ID: <20240723214412.GQ3371438@nvidia.com>
References: <Zpcgmk6wexTKVv2E@yzhao56-desk>
 <ZpfR_L9wtuXhtSGk@x1n>
 <Zph051h5BsSFMpR6@yzhao56-desk.sh.intel.com>
 <ZpkglfpbHH7lQSft@x1n>
 <Zpmi2JWirNDiJz+7@yzhao56-desk.sh.intel.com>
 <1a0884cb-39ed-455e-a505-7c1b2a0e5225@redhat.com>
 <Zp3/ha6IXL5AYA8r@yzhao56-desk.sh.intel.com>
 <56c982c4-9863-4134-b088-8dfb4b94c531@redhat.com>
 <ZqASQCobvpB_VfCL@x1n>
 <f48c1a91-8ed1-447d-93ad-449f28753c5c@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f48c1a91-8ed1-447d-93ad-449f28753c5c@redhat.com>
X-ClientProxiedBy: MN0P220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::8) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CY8PR12MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: c53d8bcc-7d10-489e-a662-08dcab609826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WdpTM24+InBblR9KMyC5MkM23RQj5WXlrwmAom/13uva8hXBp8M8Bmox6iCn?=
 =?us-ascii?Q?/rDij3PwkP2bhBMLreWgO+EbPXUdlNfNhtz+xHlkO5Qwi9lsoQmu+P+v5OWx?=
 =?us-ascii?Q?+p7ysFinTxst8/gVpdIQd3f3wdVgJ3uT4+4TD7AC/XS3oISkKIAnUrGzqlzA?=
 =?us-ascii?Q?JeySlrx54ZEa7kyX018m3sJ1lujIMhTM7RIneyD7QX4SE7LEBb9M8ahKrDXP?=
 =?us-ascii?Q?IJyBPoLrTfTGmY2MwuA2sINOJVuzHBwbarEjBWGrzzesyw3cuKdl7Jwd+57Y?=
 =?us-ascii?Q?cZvWKy6vwQpP5cdRHx98wlH1rXe/UIRPHu023g1vqBnSbJFQBygQVFh2FL/2?=
 =?us-ascii?Q?tirEhySD1zKhf2bEa+W58SF0jS/0vyqNml0N94qmm0QOHDB22RVXPDRc9H2B?=
 =?us-ascii?Q?MBJxID/6ERnEh3TJYJGdIwtwcJer/z94bx2u0911rClKy6rRboQztuyDnrfh?=
 =?us-ascii?Q?LfJl9ysFGXdrQ180E9SSZbTHtug2R2WdHZ5wC3NhqofY/9/BMN6jJVP6OF3X?=
 =?us-ascii?Q?MsgGYA3wAxDLTJom/dTikXrvEQMaRUjnTy8vvpFEoB3k03evE8alKD82fQcn?=
 =?us-ascii?Q?z+kTNlONeNC7HFglGhk9VeQdQHzxj7ipAINDe5aNMOtJElfbQoe50uZSps6Z?=
 =?us-ascii?Q?aFw8Tl7cri+S1hRva+uARZJ1mlmitfDlfHJJSuxsEYKao2QPJiy+qLMPdFcr?=
 =?us-ascii?Q?CMjD7dbPHspUyBEUKFolzd7EjQpae3s64ErN4ufPV4MAu8EvXZeXroeL/aKA?=
 =?us-ascii?Q?3IY24tyQ6KmRnmK844hqOzQVUt3gSIrFEEDGbPTv9XcshSODOsW8e28/blpS?=
 =?us-ascii?Q?ky5EPzg1iNhDRWir3rf6Rh2zIMsxVoEhjr0M/T3IRMqSRzV7UGiF/BJtXVm5?=
 =?us-ascii?Q?sRxminTnxWifVyC5ZzF0ufO5lzg+c+fu17PS5TwNl+LqMA/g3Qqh4Hu0hDUY?=
 =?us-ascii?Q?rHknIzhCvpztQxx0eGB51Tq7aHMkB7oT5uoFVZFLt1jOlX+YOH334sAHT2Ow?=
 =?us-ascii?Q?kHDIvtazhz52aCQKo6nEd505NlIdXl00vSRhHGEon5f8UtqgXHIOeOAgA7YO?=
 =?us-ascii?Q?H4Bl6TDi2Trbr2Ol/oeo+gLZpZ0pfdM3h/ALv44Alp9C/NMdjHhgGSOt8OAC?=
 =?us-ascii?Q?+gIZRRtNK7P/6z+HtNPCTehw/32SumP7B+bZHxWBkFYBX0qJBcIKNRCUWH4R?=
 =?us-ascii?Q?b9+V12erJ6Cu1vk9kOhXzcUPqt1TlZqAr3FnMrFGKnTVe7MyhQQ2z1xzIq3P?=
 =?us-ascii?Q?fxJHiZBmRvzV2ZNr4J8nUJDxPvGEEOeq1nEEyi60sIGFz8tsSsTxVlFs9Bhf?=
 =?us-ascii?Q?04PVO22bOD/0pgP/TBYXdsBoDGDtyzAfrS6WzGGsHi5W3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5nZ/Hezrc9xTbhVAODeo44yejrWJFxSBlzuZgoaQZOM7nXqQJmtdgcqSSFhS?=
 =?us-ascii?Q?JV5YcytWGsT4KmFFGUOYdBeGdoK3auwIkgZDAWBgey2TxvFRRsU55jrKJMVP?=
 =?us-ascii?Q?mZ7xFj5pUiQRkA1YEHIEU4TQCY0re8b4ucc0HKFbtTA8oBbNKQMbV0Re9i78?=
 =?us-ascii?Q?f5+nJ3i2EFcChKxuTwHb4rqSaKQphKCqj79COZYTXkAU7DtMqAbb7bL4jxaT?=
 =?us-ascii?Q?DLUkUKPrSKWZiHfpkTTt9OEqW5JCNl9AYKOLNrJUrt8VMlkCTyxYZWbCEczo?=
 =?us-ascii?Q?xgVT9vnaNJN4kLQR3/PHv4l0b5w+7JzwhT4WzciRnfDB+6RkP3kBpkAWW19q?=
 =?us-ascii?Q?zmuGBex1iz0nC74dCR3Xv1Qe2BSXo8VX6EU8NF4a8vGbxFJdzY3dPlqDlQjt?=
 =?us-ascii?Q?69eZ5+SIJgBU8i3pGK/IzITIsQvSQ/vAmN5gxYRRuegZaIHyYokNK1gHvCID?=
 =?us-ascii?Q?j5tF9Vh4OZBVNPheZ4uaZnOhLhpv4Er7jwxzNLBdy9GY0lZHwHS74ynAW4SJ?=
 =?us-ascii?Q?hKGawtqvbNc/s7PjfQjBYJIwnqYzHkLKQ/7Ytj3BlxXcLkiv6IQbKBtKzi17?=
 =?us-ascii?Q?gbKdA8/XrNWmxf5oUAJrYCXS5ZzUR3QQVHtXhejrYBvd19J3Z60jVl//FbXp?=
 =?us-ascii?Q?xltwdesE2qxsZgnfDBNwt9Qy7ncyKekD03iSoMVfR/QaBX63tgGy/cFwJbKj?=
 =?us-ascii?Q?fwtQ9O/YrWgpvPp1m21hEpX6FwsIFd54488MnUgm39X79tq2Lrm9zzsMF+It?=
 =?us-ascii?Q?iBJ1p5o6XdmDScCh5f1szeoYmUkTAKO9V9Dp8PpXmAFGLs7SojHjvmcUWb1r?=
 =?us-ascii?Q?gFAD8jlZN+pt/jTAxWnOHCVSrRrplr/7HY9MQqx+yNObYWx3erzTqiXLmAQO?=
 =?us-ascii?Q?RctuaJzvlIk5KpHX21NY0XSyk95xAlSoQ9OQIOEEdkocYy+J/Abrtd+gk32V?=
 =?us-ascii?Q?yF0lGJvzG+1bBIvWg80kcwZ7JBMMtBc1b504LKF0sSW7SH9sSalo+vn/POMV?=
 =?us-ascii?Q?z/uUuDnV6XTRrEJNIkA6gW/UuTsJKTVHbWDSlPrV4Kuoc58UP7dLSXrDQPaM?=
 =?us-ascii?Q?ozWAa/LcErrK4n6uXvTDPwPygb4VgrEBtScSSygv2m4pB7co4KPf6oHYOlKI?=
 =?us-ascii?Q?+rMMBQMgpbGgqJO3iLXtEmVPXjrM9dl037yjKmEntei2GrEIaBlznhyRUzHP?=
 =?us-ascii?Q?nbkey4AkFbjVInLslenNs8OgqkBxPe24cIJHeOYj8Adshl3ae63H/8uCuA8Z?=
 =?us-ascii?Q?po8y4C5g3s/XQgiASkGthgi9zyNtK5dKfKBLRCYLSVQ+/aU6LAYtaCiK4VMb?=
 =?us-ascii?Q?3YzcT0eqE5oywq1LNtZdhNDlnLxU+z3l+pzzuTuXQufXV0iCXLp9kUTZPW2w?=
 =?us-ascii?Q?9Jy47lHs5RBmzY0Fq0opEj4W4hghMOIZKWXK0OdQ2uTpgbDpaVnfM4Kj004d?=
 =?us-ascii?Q?veCUu5uER0zvOJWfM2hs799J/NbHv3PDEB0OPjlrRFIkQ8LBEB+mIwNz0htw?=
 =?us-ascii?Q?7exdsGYSxvHZWX5h+pwW63eUN1x90EZixckqHyN7ChfSzkXfQKBZDAgcoAaH?=
 =?us-ascii?Q?Xb2jh+8Q9V4do0NsAeY/8v013MZedfKYWVYbYFRU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c53d8bcc-7d10-489e-a662-08dcab609826
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 21:44:13.8968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HacAJcjUzaMVwLQFHkNL/7DBHTfOQcyc4MJbwJFOmWpCOpLLUG58QTFsKkAwQlH4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7243

On Tue, Jul 23, 2024 at 11:36:51PM +0200, David Hildenbrand wrote:
> I wonder if we could just let relevant users do the PAT handling manually:
> I'm also not sure how many remap_pfn_range users end up triggering VM_PAT
> code although they don't really have to (just because they happen to cover a
> full VMA)?
> 
> One nasty thing is fork(), I was wondering if relevant users really rely on
> that or if we could force these VMAs to simply not get copied during fork.
> During fork() we have to "duplicate" the reservation ...

I admit I barely understand what x86 uses this PAT stuff for -
allowing WC mappings is part of it?

If yes, then RDMA would expect WC PFN MAP VMAs to copy their WCness
during fork..

Jason

