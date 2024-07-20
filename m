Return-Path: <linux-kernel+bounces-257768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3F7937EC0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 04:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ADAE281FA9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 02:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E258B8BE2;
	Sat, 20 Jul 2024 02:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GOKDaF1s";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PE2b7H19"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE325C82
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 02:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721441954; cv=fail; b=DCS1372IlflLHK/TAf3k+uvAN2Mn2TuE8Qaywr85NlDZcvahZjLjjeeQD7i6O4aYk+5+a/aKba1UmOwFlk7N6u1nO+hfy//G55/IU/i/8qhQXXwlA0NGo6bw2QeqUYF1GEpRu6A0ikkdsmC8Angtp3L6q29V5UezL/u1TU1uMtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721441954; c=relaxed/simple;
	bh=Z4kUEg0NiYZ3t+XVGSbQNzmXG/18+NsUXoaGmQnidOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g4gYDkRt1/jXZde+fS/UB8hr6oLqRg0BUlaphcWbzse/tAdIfJbfZLoLizA7DguRP8cFoeO0oW00LH0zKgQXwuDGWBZHyjypTz0cqL1egO9tgJIpilZjD0nlLUFcbtB6ItL+q7eVZiOuQ/kO5BKdrE4cHTV8sj+kC+pkutPMGkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GOKDaF1s; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PE2b7H19; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46K2GGuL014924;
	Sat, 20 Jul 2024 02:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=fzYMReHpkxB/NHU
	t8Zv8x6Huq0btmvmzGiiFxiSv7UY=; b=GOKDaF1sBiPTi+7AVjnQf/TdLz8IG/p
	aRiDlcg+VSqzpuwOadvBugQeoySiYHXE2sR/UFgQ/e7Qn00i5OSjou+GqUCwDqon
	AJeAFS1sdHH7/EU6+2BDb0wTg3vLJlvWOX5ktkGrzKi5pp2ALgEUtYFNiljtYbh0
	yZYghKoP48Gj6K0vVIZd+BIAv+OoaBq4UitJgTbu7lYgQos1ekJpggY9BwsfpP71
	0b3oHZcyTJKrNVz+1P7zwij/MMSOV3wxGL3+E5EMOU3ByNJdPI6lqLYVV6TJLYfz
	r+2SJrXJCH3XZmZn6BcFsxJdqdIFisyQ9tPNCA5YBn3g2OkGfbqhJ3Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40g49t002g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jul 2024 02:18:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46K1YIw6034068;
	Sat, 20 Jul 2024 02:18:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40g3pb8k2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jul 2024 02:18:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=piV0mR25Xfs/h0rwfnrB36nB9P1SnkA3wkha60970gdiEwe5Xq26aG5Gm55ShJc6wUTE8cgRqYSE3b9lkEhjEx6D+hg3qdriHrIbrE4o+04V+YOdGQmxcOQV2NwxLiwgl1jqMSaBH67hifsMBF+1qAou3cO0GYZa0lDV5AeyQZgibbw74jxU+FzWttqt/wSKGhmSMYphAtWgmsFtT6s/UfKYEWje21RHWBJ662zDBXIZYPct2cT0UOobSpT1GYRSOnHVEiLKgc7nnLgzUf1r5qFFt9x51G4SR7ZPLpqtbca6u8ZaTUaqtX+PIaSOtbVvBaRV//KcrU1G5MrTiKfrEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzYMReHpkxB/NHUt8Zv8x6Huq0btmvmzGiiFxiSv7UY=;
 b=TZcAyrdl8MJPJeglCtPuCmo1vbqgb7NpxAMrAH6O5ztiC2EaHy5wn70gSAdKSkuX3WREKzNiu3thuZCdwXSc4sbTsjzX8wKA/qtPaLUHrabGn2diq/ypDx26VQwCtpy4XNtfu3LwBxCo8ZkguQUZTGurZHP/dAspS5utJhT5JSyNLawD069x63LeAJF/XB01xUEs6zBS1VRXuV8M87af67ind6ofIssjKZ0aBPbv8PzDz8/VWtgePceT8+ChEBTYOyJ9uOWNdRiDvAw85dbgFJCBNdkR99Jxibgi87sRk45FRYzkEV/UuvbYYwn9OJcGxriAjGbcJBG+Oq+vUHKr6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzYMReHpkxB/NHUt8Zv8x6Huq0btmvmzGiiFxiSv7UY=;
 b=PE2b7H19/9g17IAx/6gCIStE1s3rFvrj0PPMeogh43Mpj5bZuln3rMNQc0ZyDS9a0UWXY/OiSGfjU+J4fVGwO6LW9t6Roey2obR9AudurPkGBYbB58ErqAv7eJczKRx6EgyQDmUjGTldG7mKourCVBF+EulzEQysr5vRcmtBKaI=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH8PR10MB6647.namprd10.prod.outlook.com (2603:10b6:510:221::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Sat, 20 Jul
 2024 02:18:15 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7784.016; Sat, 20 Jul 2024
 02:18:14 +0000
Date: Fri, 19 Jul 2024 22:18:12 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>, x86@kernel.org,
        Yan Zhao <yan.y.zhao@intel.com>, Kevin Tian <kevin.tian@intel.com>,
        Pei Li <peili.dev@gmail.com>, David Hildenbrand <david@redhat.com>,
        David Wang <00107082@163.com>, Bert Karwatzki <spasswolf@web.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] mm/x86/pat: Only untrack the pfn range if unmap region
Message-ID: <t7q4s4rktcjkrtmr7l2zffpthxis5bmafhae7aaxxekyyp75ev@x4dshxdx3jpo>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Alex Williamson <alex.williamson@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"Kirill A . Shutemov" <kirill@shutemov.name>, x86@kernel.org, Yan Zhao <yan.y.zhao@intel.com>, 
	Kevin Tian <kevin.tian@intel.com>, Pei Li <peili.dev@gmail.com>, 
	David Hildenbrand <david@redhat.com>, David Wang <00107082@163.com>, Bert Karwatzki <spasswolf@web.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20240712144244.3090089-1-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712144244.3090089-1-peterx@redhat.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0428.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::20) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH8PR10MB6647:EE_
X-MS-Office365-Filtering-Correlation-Id: c18e7895-d8ac-471f-5608-08dca8623617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?OlhR3k15o/kOI3ZnqWXsIsYuvbMDVDdOWxYK7MBroxVryW/4CEDpDi69JyNM?=
 =?us-ascii?Q?Nmh+AKskgsv/27ChkuILtiW0seXdqrdOpHN9jgPyogZutaMCJwPqkwxae7mT?=
 =?us-ascii?Q?VAEZrBqgsx94CzrUvtpllwzdJ567jnLBLZIKO7FinbHQiBErR7uALZe5ZWGV?=
 =?us-ascii?Q?E/ld/yW3wcrdkgncw+VBaJpyoFvKa2PXDF7gD1g3mKMMJRaDTK+WF/C7ilCu?=
 =?us-ascii?Q?TCTjOxpp9fMTzKiEb/pXjNHz2Rbr/MWUEU4W/lNLpngsnF+GDIcetij+Ks1k?=
 =?us-ascii?Q?Mp4CXNVzxogfeB2TicHThhC9uSooDIFzXsU2YndIeiqt2JePIcSo+rKw/EjN?=
 =?us-ascii?Q?OwHyFgioYwWhdyxwSNL3WyqUqVhvvS5yvPBvw3Ba2u/cN+TR4Y5pajUxjGFH?=
 =?us-ascii?Q?droqRDfhiBtscAbAlrY1+CCRg3RVGuUB+y7fWG8LgPtiRSNQIEK/jHgRYrlV?=
 =?us-ascii?Q?tcJQqhbCAOmm0JeJVeOFgljhQz2RgKBbc9OH8PnFXWi6uCf7eo19d/W4My7F?=
 =?us-ascii?Q?NBZFfy99BCwmAaB8KBx4o0e+TDGNXX872MtmW4b1nYjFMYWueayNDjBTQKRT?=
 =?us-ascii?Q?9BV7JZ+PkV95vG4Ch1Wq7yL1F2uw9AVGG/uZo16JPkNlCrvXZaUYwamPUhV5?=
 =?us-ascii?Q?ozY0tpeO1DKDs9QpOax1GsSnMrPPt9vx+P4IRN+KE2i8uO/56oHTB9OWiFUp?=
 =?us-ascii?Q?p4QHN4COs6cWpCT6UNPQ5jD4hVVIngAaXOxwebivmyleSQyRBDCr9BbOX/QV?=
 =?us-ascii?Q?+ColThz7wO/1sqhQinPvUnsWjtxuLk+66/VjAVL69v6OHldmgalxXdCs/z2d?=
 =?us-ascii?Q?glHKMq9GDzxOE0knMCxU6q/4gpePKh7tbKDwPAcZER0w6OXrpFZ3nMm/DqpI?=
 =?us-ascii?Q?DVtyjHa7gNXOrm4VvEvFyeymhVirfz+MfgeKZP/l0+/u7PKbv07IoiHFa7Yy?=
 =?us-ascii?Q?5lspOyqFehkWH4UYYKXEGjaUl3U2lJj2a4uTw5R1eeceOu2083nCnc8yq+fD?=
 =?us-ascii?Q?m4ujVOWdOKK8lBM4XH6x461us55+zbQQpUnKIc9elzbS0ptIGfIPRmIQFcTx?=
 =?us-ascii?Q?2aI5302U7ShkAu3cxaXv/0ExcqQZ2oXFbh2fgFQ01oAjG8Q6MuOSphFMy9xa?=
 =?us-ascii?Q?91Oh82MqNw8MPas0PHuw+7U9dmGJF0SX9p0QrF5IPCtR2Szgx1ume5llHrca?=
 =?us-ascii?Q?tdlO7A+sYOfVpOX9UdPVMg7l/kUOg1oQ1/dJenMkHYgLHgk5btRK2pDlhb0R?=
 =?us-ascii?Q?vlk5Zl0DpxezIyIspujEDbyGERPncWU83ql3QbIIv0hMt2CyGfCuW0TrV2yZ?=
 =?us-ascii?Q?T9k=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GCocZB+30fdvUUgLWWaFooy9W+BNpUDs15cwUGhWf4rSsZhDXfteIEpqoUD2?=
 =?us-ascii?Q?Fa2Mo/6Ux/cNYwDx0EA1OOsWjDYaosokUslss6f78JSsjuHFdCcymR7zJdLu?=
 =?us-ascii?Q?BP59mi5Of9qA+b03bDaojTEQsr1Q3kiKIFqdn3Od8/+6T6pzi8ype/kyx27g?=
 =?us-ascii?Q?ugtQuZm4O/wyfdudVsD5mGXHoYsKvHlaMzYt3X+gWU789PMlo/aUxyDHWRTR?=
 =?us-ascii?Q?jZLopN8pZoYp7nUiqwzUkp+2IqnZl0ywOYabnfHvzias8grXXBACXtdokLhH?=
 =?us-ascii?Q?ucj6S/KspRkZgfTb+z/j6gEnzXklpU6Tt1d7wILCKVsJ0rUdYLVAtfURSCxR?=
 =?us-ascii?Q?c0B28w5HgqHzBIdk30HyKko3b8R/uQjfn9OM4QmImSejqZnQKUplalx8xZ8R?=
 =?us-ascii?Q?M77CqfnyfGC2pkPIxfRZOQbb9WnNZHB72yJdOluYiy5VZd34abnQQdF13M7g?=
 =?us-ascii?Q?+1dBS5krywAhbCRSEpV6x4/F0gStvyTJ4qxX/KJSz2tTWXI5k6ghGP6majVW?=
 =?us-ascii?Q?nlirwjAdA4CF8KhjByM+5iFq3bRRj1+sQ2G9GvAPF/hr55BfyPbqv40b8oY6?=
 =?us-ascii?Q?vl+5wtZyznx7nN8jAcoXvE5WkthFMJ8ss2Q/Lb/X5FyGMLM6KGpkQBxAQ+8X?=
 =?us-ascii?Q?hQkdUzOmHGJD0AqfwppGh94moyMbHujIyizf8pqQUP1U3oYf8EAbmYaNc+WL?=
 =?us-ascii?Q?IgQV1VtHfZGVoLcBn/5Rpz51SXhrpTsXqVOOVab7TmoXs06UtfaAnY9k5s3Q?=
 =?us-ascii?Q?n9gxK3fJrPeAaIHcl4TSNdHiYJjgsIvrKJMBFGlKfYWZ6itD7DJ+zv0uRaoU?=
 =?us-ascii?Q?VaQ8UfLjw9oFolzGNrJ06yAMvTdUve+9J5pP8DZesI7tpcA2bpojVBcrKgNc?=
 =?us-ascii?Q?aEv7kEDb9uIipUXJOXyoJLhUVbKvK13LYF+dC8SRe+/dDfn1Z8A93D+dcQ+n?=
 =?us-ascii?Q?ec0QThLLWbx35Jj22CZe+qIrgPv4jR3PmZXsR5AS/DGQkLenMnxXsK4pIPLY?=
 =?us-ascii?Q?KhM1Qbj00K3YebX/s/37RfQP9+ofQaBH5Yq2QeSQq2pmKQq02eQNXuIGyEtD?=
 =?us-ascii?Q?DkoR2xWDdehnI7kthRplxrLsIQW9BtuGhix/ySIY4ZKM8OBSQJvzJ4x7/oU9?=
 =?us-ascii?Q?E+sZ93IIr21nuZIFyTMUO39GJPiuipJqgAko88FrgxuBeJwqS13rA3J47sWX?=
 =?us-ascii?Q?qBK1JwE533ymY6Poli1nUSxBG2hVXsTeEIzcZWEFn+R3meKy43C5vXUPXbou?=
 =?us-ascii?Q?R0ocG/2mvb0Vhtjjqi8HiNgn2AWwfwY6WFR6ADkY/Te4yTHBL0knprbiXM/B?=
 =?us-ascii?Q?+vgCDyeZ72GmowDsD3LG2U1/zS3+lvOYVae1FR/RXfg6aMKHkfeQMtzirN1t?=
 =?us-ascii?Q?7kEjP5w3Bnki1Juzchi5DApaExf8xXwo1Q9zH3D3b4qKCPCjALNl7AvknRvM?=
 =?us-ascii?Q?KjEjymZOO/RxFnl4MRrR3CeY6AGPbYzWtaC6nhbT5NMjPrwPSXJN4+U9T++6?=
 =?us-ascii?Q?1R9zRb4gUoFVYueabyOe8V9SZixu75J3vNOw2WSDjEUTYDvY+aTMVEf8jjwW?=
 =?us-ascii?Q?cFjeOIOiL/GY+xw0GQc0KOzZ4cl2L8SD9DFiNe4+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RfPuG9fVxLYVmgyeB3G8CafNRoIDo+QDXUSwi4pkAYEHqpi33YjovGfYmR+Co0XTj0xOGYyuN2b1QqPIfPWGSvAEBQUVHm3SbWtJws7olyUv0iD7LhEKdC4HjtUiOdgp5Ypgknc8pazaiYlcy0c5YRSul4VgbbHQ7sjWEdWzE3Jnq2vIlECNMBZzOeNUWWs4mcj+zF5Dhu3ae7yGNs4sV4irNIfu9YLXOPUeQroJh6FDCc697AIMlf8uhhrccTvbwqYpPbB58E1Yw12KOzyKckLCJCe9KUcIeY0Tj681k8Eu9CS7JKLVx7YSfLf2Bqqgk1Xx6cFnaEfsCJYrNGNp8ZbsYW9qZcyKFtDNVehLo4fdjJqUNWr/6paOYBYOJ35Azc9SeH8Hto3s2fK8LoYpWCjWezBHjJotKboFKVDK7WzVGBNrwIJ17BbwwpNdrKTsO67LYW7bWTgeJ0fZ7bRm1gKRUmcnEh8HapfdftSbSUSO/+Djb/Xq60gxyMTZw8ZoavNf3DLylbwu0rl+10zTdMQLknXUveFappmcVJP+leePJZiQ+M5bhRo5aQ8FObZKcfhyUdjNSVlJLoA8jtjbcMVJhkCtdaZ7plmghVAhlt4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c18e7895-d8ac-471f-5608-08dca8623617
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2024 02:18:14.9000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aystoyRj4FwAHZUeZQT7DxX08mPoP/5WWSqdKjeUFgamPUwlxS6BedhlwcZazKhEOilRW9pB3dPXX2/0D2M16w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-20_01,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407200016
X-Proofpoint-ORIG-GUID: Yq-ZeNqwapPlYfzREQxY5_WFSgvQ4b58
X-Proofpoint-GUID: Yq-ZeNqwapPlYfzREQxY5_WFSgvQ4b58

* Peter Xu <peterx@redhat.com> [240712 10:43]:
> This patch is one patch of an old series [1] that got reposted standalone
> here, with the hope to fix some reported untrack_pfn() issues reported
> recently [2,3], where there used to be other fix [4] but unfortunately
> which looks like to cause other issues.  The hope is this patch can fix it
> the right way.
> 
> X86 uses pfn tracking to do pfnmaps.  AFAICT, the tracking should normally
> start at mmap() of device drivers, then untracked when munmap().  However
> in the current code the untrack is done in unmap_single_vma().  This might
> be problematic.
> 
> For example, unmap_single_vma() can be used nowadays even for zapping a
> single page rather than the whole vmas.  It's very confusing to do whole
> vma untracking in this function even if a caller would like to zap one
> page.  It could simply be wrong.
> 
> Such issue won't be exposed by things like MADV_DONTNEED won't ever work
> for pfnmaps and it'll fail the madvise() already before reaching here.
> However looks like it can be triggered like what was reported where invoked
> from an unmap request from a file vma.
> 
> There's also work [5] on VFIO (merged now) to allow tearing down MMIO
> pgtables before an munmap(), in which case we may not want to untrack the
> pfns if we're only tearing down the pgtables.  IOW, we may want to keep the
> pfn tracking information as those pfn mappings can be restored later with
> the same vma object.  Currently it's not an immediate problem for VFIO, as
> VFIO uses UC- by default, but it looks like there's plan to extend that in
> the near future.
> 
> IIUC, this was overlooked when zap_page_range_single() was introduced,
> while in the past it was only used in the munmap() path which wants to
> always unmap the region completely.  E.g., commit f5cc4eef9987 ("VM: make
> zap_page_range() callers that act on a single VMA use separate helper") is
> the initial commit that introduced unmap_single_vma(), in which the chunk
> of untrack_pfn() was moved over from unmap_vmas().
> 
> Recover that behavior to untrack pfnmap only when unmap regions.
> 
> [1] https://lore.kernel.org/r/20240523223745.395337-1-peterx@redhat.com
> [2] https://groups.google.com/g/syzkaller-bugs/c/FeQZvSbqWbQ/m/tHFmoZthAAAJ
> [3] https://lore.kernel.org/r/20240712131931.20207-1-00107082@163.com
> [4] https://lore.kernel.org/all/20240710-bug12-v1-1-0e5440f9b8d3@gmail.com/
> [5] https://lore.kernel.org/r/20240523195629.218043-1-alex.williamson@redhat.com
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Cc: x86@kernel.org
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Pei Li <peili.dev@gmail.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: David Wang <00107082@163.com>
> Cc: Bert Karwatzki <spasswolf@web.de>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> 
> NOTE: I massaged the commit message comparing to the rfc post [1], the
> patch itself is untouched.  Also removed rfc tag, and added more people
> into the loop. Please kindly help test this patch if you have a reproducer,
> as I can't reproduce it myself even with the syzbot reproducer on top of
> mm-unstable.  Instead of further check on the reproducer, I decided to send
> this out first as we have a bunch of reproducers on the list now..
> ---
>  mm/memory.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 4bcd79619574..f57cc304b318 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1827,9 +1827,6 @@ static void unmap_single_vma(struct mmu_gather *tlb,
>  	if (vma->vm_file)
>  		uprobe_munmap(vma, start, end);
>  
> -	if (unlikely(vma->vm_flags & VM_PFNMAP))
> -		untrack_pfn(vma, 0, 0, mm_wr_locked);
> -
>  	if (start != end) {
>  		if (unlikely(is_vm_hugetlb_page(vma))) {
>  			/*
> @@ -1894,6 +1891,8 @@ void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
>  		unsigned long start = start_addr;
>  		unsigned long end = end_addr;
>  		hugetlb_zap_begin(vma, &start, &end);
> +		if (unlikely(vma->vm_flags & VM_PFNMAP))
> +			untrack_pfn(vma, 0, 0, mm_wr_locked);
>  		unmap_single_vma(tlb, vma, start, end, &details,
>  				 mm_wr_locked);
>  		hugetlb_zap_end(vma, &details);
> -- 
> 2.45.0


...Trying to follow this discussion across several threads and bug
reports.   I was looped in when syzbot found that the [4] fix was a
deadlock.

How are we reaching unmap_vmas() without the mmap lock held in any mode?
We must be holding the read or write lock - otherwise the vma pointer is
unsafe...?

In any case, since this will just keep calling unmap_single_vma() it has
to be an incomplete fix?

Thanks,
Liam

