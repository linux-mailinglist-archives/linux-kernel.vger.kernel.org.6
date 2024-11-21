Return-Path: <linux-kernel+bounces-416997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 007339D4D71
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769721F25120
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199E81D7E57;
	Thu, 21 Nov 2024 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FqXM+Zx1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kYssl23U"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C451B0F0C;
	Thu, 21 Nov 2024 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732194325; cv=fail; b=J3bexsncl8TGsu3UEY8Xp4dysjG/q/qlup8dYSrr092iCU/+jkFof4Pgarqgz7TkNtsl1Ybi701Yp3Yl5ZqGk5dDJf4C0RWwvsZYxJQX/8h4Dn6lP+4MifHk++FighTLkJY8eB8EffOcU8NCMabLJe206lzM/Y0vFL8KFLLBSlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732194325; c=relaxed/simple;
	bh=2E/V7yk7xM8yUe1ZY1CuDMaUUGnLOqEGtCJi8yx3oY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pc8GP5NQWM4/k2kgNNSxmiXJ/Lj0lEzpjXBhNSBPhtLNw4rifVfCNCHTgzq1hPG/vRmr6rg4hu3XdU88VQ7RuzrUI+T28FqgbFn9XfGVIyZL2uJua6sC2YRlisLv7H8L75NGcShYChhofPslbAjJuYsHXjNQZLXJxc2zYKSINqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FqXM+Zx1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kYssl23U; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALCuEEi022822;
	Thu, 21 Nov 2024 13:04:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=lFXdGc1NvJpddLs8Cz
	PHbU5ISZlQoiH+LDyJEVZHiT8=; b=FqXM+Zx1XMjjQQN2Ns7dACSaPm0SusGqtM
	CbyE0zuRuMKR5dSrC8EByu11a78LSeoBPEswK5k3qLAIIEADfDJQX1BIsAtoHfaG
	cxFJjKvbA35/4xc0mdiJ6XCQetFsW/QmJnfMlzjN6PJlECYTH6tqYlE+bC9hxfFF
	GDX6uf5n0k6Iq2o3lfkKa9+mnC3u73H6hsCyFIG1pUe4rwIrKTCIdIWQd5ADYXIr
	4ENGGSQ8hd53dx4dYmdZFehilNi4BEtw3OvkXIb/B27aWqRnC+oWmd59zB8JaV5Q
	OzQd075rAWZY43ABO1HHcuHVOxVcJAPxK0swnm/XZh6On0+PRMYQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk98scfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 13:04:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALC8A1o038041;
	Thu, 21 Nov 2024 13:04:54 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhubs459-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 13:04:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=La/DOByJT73MmzMH5OO22BFsOKzX9TMKvizRU6ZDDIXsHik+w9qSJC5uw8oR8Sb9jbC3FzwDq6dnKEXKtHcbaEkMLsTKWyxipG206fZ1GIModki0PPMUMn4l90YqqJ4P0RRD9it27iZoSDaJ3c38XefGgngz9y8wK8LilPIA1TY8kYE1Ss4b2+w2SxPsY86PUeJFlIt9CXV3Js6ChM8LRnLM5rhsZz72NmJ4lBVhboHeugepAvZxewrD1+SgoBac5lp48IVZp+TrpZFOXJk0xlbjl1dLu0fFXiQriK16e3fvlvJLTVCSkWeM5Z+gubeB2TyzuO/zNGrh/rxsYI9R8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFXdGc1NvJpddLs8CzPHbU5ISZlQoiH+LDyJEVZHiT8=;
 b=Rzns152jDc4PJDbvLhugNAMZQJqBQlUktMgqRzNZ+ozDqfVCkLBzLWuNV5HRhZXTTtrc/+KOdu61AJ94V0SylQ6F0eHcSXucFGttr683KPpgNJDatNNnMWVwc6akb7+k05BabO7NLpCTAjZzyyUxz2xtoHwNNVEfSLPQsrx4pUdVKgBvoq7N6jKd6+ItDsHLrpvUYd7CiktokFtXyv+jgxw6OssxKWiWCQzSJmxA6mgqnbA/lZUv7j6e8BRnbYTupApKb5oi3In+Newd/Sl/H7faAtEGad0Lxqz2MO0VnmIO+AvxHm5ZBMwisNlDLw1BZroIEPktpJA1cSkGWlBiKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFXdGc1NvJpddLs8CzPHbU5ISZlQoiH+LDyJEVZHiT8=;
 b=kYssl23UGUALiE3ry/Uz7n6yU7wV5WuZysIkNIqvpPCRdAnk0AXa3kcLt6CEF5C5URm0i/M/07FRBMP9PBy3aRyl9V0mYhHTyBmQ6T+l0e2kU/BG0A5EiBr+n4E06jA41ybfZaNUAx8EF8TFIHln8//vudVEruCdRhhp2l/7nII=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS0PR10MB7341.namprd10.prod.outlook.com (2603:10b6:8:f8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 13:04:50 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 13:04:50 +0000
Date: Thu, 21 Nov 2024 13:04:47 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
        Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v8 5/7] mm: rust: add mmput_async support
Message-ID: <94028b6f-9fd5-45e1-a61a-fb7f7f877e7c@lucifer.local>
References: <20241120-vma-v8-0-eb31425da66b@google.com>
 <20241120-vma-v8-5-eb31425da66b@google.com>
 <5762ab92-3091-46cf-9565-f59cf917b470@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5762ab92-3091-46cf-9565-f59cf917b470@lucifer.local>
X-ClientProxiedBy: LO4P265CA0327.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::10) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS0PR10MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: 323672da-d914-4230-dfdb-08dd0a2d1562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uv7Bh8WyVAJDH1wGokfI/zGC7UI3nl3EvfjjUDIChuKikZFtXrTU+7+yyJlk?=
 =?us-ascii?Q?+fXicE2K3fnO+syLl947hJ6KJ6RuzAbD8hnvccGxEOlaQYwF5uj5JnVwRXOs?=
 =?us-ascii?Q?LNwcMldokfv1zG3FQHPPDx0mOXqMeQBauLp1k7DlZCXb+cQ6P29N53+rdUfe?=
 =?us-ascii?Q?Q4mah3iVPP7f4vJ4bED/p/FzccVFdekhy/W/mkjC9YGZfR++I6aSc3zifyYZ?=
 =?us-ascii?Q?FwMDpRZD/OnVe6FeHnBTgXTLlxeR0XDZsz99VFh2jRnCL/0IAC3Sj4A1QDWw?=
 =?us-ascii?Q?xs7IfCVd0qx+If6vKbdRoamoXvKc1ksIizhwP20O/yNuB6SN6/7ajAQPDh9i?=
 =?us-ascii?Q?W7+alCOuJ47RhKF2Vu0PezRhHNW64bPXIluM+B+sLl2jOk2BohR7gOz7jAs8?=
 =?us-ascii?Q?bmV7nDDHUsiPy8Qp4am5oLaAppt19GhgBP8yyYA/piT40kKn2l+Axq21cMnW?=
 =?us-ascii?Q?OYI3pX6Ost0A27/CzlQiKsZ1KgQVXZ82pr+lbz3+QVfq7JYGHRr079vE1c/K?=
 =?us-ascii?Q?85hyeUrgql1NwdqWXl1XdjXQJLioTTMe1ywhFXrCu6hIlRFii1cYEz47lfWn?=
 =?us-ascii?Q?7cGIihARVl7fW2+ojJRN3mPMn/9h4qR18bPcsDi1UwWDrFSCd698ke/LrcMd?=
 =?us-ascii?Q?Jvot3VjiTqkGjRYhuSRoRJwiFNP8ZTg67YusFHBja/8oe516TxmYYsUu5CgI?=
 =?us-ascii?Q?M/ikKfkpqMZTEglO7yBUrs7kYqNZM9bT5rlyCDT4RgJQOBxNMddzzhxUzzKg?=
 =?us-ascii?Q?qVyjxzqqGC9aRRK7J34U0MI1/0AXOJ7nJMroHgzT0CzEMUlgUrLFn480Y7k3?=
 =?us-ascii?Q?Mj/JWwQVwGOr0F6J+RefrT9WnOoDz1FAfSTB5XW7+QyQuPHJGN4vTZ3qxRa8?=
 =?us-ascii?Q?kQhPjZ+l11QAHp7VPhviS+Qp0/KXH/A2u1TAmY5gQpNeinbzfkh7upptKpRj?=
 =?us-ascii?Q?1t7+SEqyM6rJP1BdL1u2J7uaAxfxmkn8PGog+G8h8g/2KHMBwxP45qbcNQkB?=
 =?us-ascii?Q?QHf1YzsgtozWWiGTP9p9hNTcrqFrHSNlZxEJLgHDFy9ruXnLDVOOOvPLw1qm?=
 =?us-ascii?Q?3+hlA9gVmvR6dzZmS6W6hLbrBtYY9n8nFFPooWM3Td11jXNK8Z8Kyn9a75wD?=
 =?us-ascii?Q?JNYB6lDSQ1+5h1nnRhs0JYjYRVJx0Mb8/vZO6LRdUIBvKQxhNzXvyqXoiouX?=
 =?us-ascii?Q?dl8zLk0FUL4Ya6wHvd88zQYZnGaRcE98tz7/+qUQHLIPrYVgsw2J6yysyMEY?=
 =?us-ascii?Q?RSo5vrb+26VVJqSh3ah6eWmeJnKChDwzbZk4UwwxZHRAWnpSgb20i5Vjf2Zc?=
 =?us-ascii?Q?AwTDP0EaXe9tXngGMKu6KVD0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?knGIFoRTvdZRHg/peJNiBSrjpvBZcMkJRmfbJ+RdHdPorIpFaJLDtJvXkVoe?=
 =?us-ascii?Q?tTFkpFZycS9e8NNaEsLr250rKqja70DO8V5bm62OUtXy9xjafwlr/DwgPnW3?=
 =?us-ascii?Q?gmiBkB0mgq0tCfMWMYS0zzHNH7h99fdmyTLS7ljhovspyvL2DarXoV4cIYNF?=
 =?us-ascii?Q?ngxjt1M3nj66vyEA2oKTO/nJ7GiiQjKFvmRV4Vs4cSgPrZaqnXzt9YnxTUgN?=
 =?us-ascii?Q?jzWnmw07cbPAS2+wB6m7qJ3d2L4k7D9LU182ChhkVq3L6TngzfFv/ly/J17W?=
 =?us-ascii?Q?dCRwDBEfwkowEj3QbTdGWV8+oWL5xQBj7Dyy4Gb+iitXiOH6bbPEebLPFMQ2?=
 =?us-ascii?Q?J7vojoqLQL/aBnVhVkl6c/N2nEY20FNxJaVEacu4eBDhlapiTLGEwZ/ybwMQ?=
 =?us-ascii?Q?9XHLrreO8TdJJf2jqR3EppUnH7FN1zRtKGSc1Zhz46HnMnNsPXUGn7c3VKGQ?=
 =?us-ascii?Q?UqAFmytQOjuH0A6vXPZO17yuGfb0Z2mfMO5HnbHs+yqJRGg0sKRoYO6U3+dY?=
 =?us-ascii?Q?6P2XY2d2qisyjQ77QsvVi68glgAAMQtVh/KIrxjBN9M1Ds0+Gbx920meNZcx?=
 =?us-ascii?Q?ZKrIctPhGgoATqAU3KjYkIQPEJGhLa9cHVsXnsfjc6NqIPfYTSb/buuR2oiQ?=
 =?us-ascii?Q?NngS/NPB77XDOzZuSx6umnFegMUrOLrm2K6v3oX2d/cIUbOL1bcdBH3cFlJ0?=
 =?us-ascii?Q?KuJInV/A/A4ZKE9cMgvi7xrCMTBWRiZvzcK9c2S2elaCl74PuYO64sGkHH6f?=
 =?us-ascii?Q?NMGHXKSahcOQ4lyx4MEguYXSow9oYCWsVPvSqoIVoxW/XUpbF96TbEOgXrnW?=
 =?us-ascii?Q?pvCj99sMewM5jcubUPFCO9QF7tujog5n2gWIqRsC6E4tHXZhTJjeN0JbEoqF?=
 =?us-ascii?Q?P/yCMxs0whOEOD1NlgchW2uzD7YTlGJvEErSN5bswi5sQKdHvgd911b6MQb3?=
 =?us-ascii?Q?4sgkiqYSHKSFQWup/1I45tmpWRPlHvlXrvgymN6EpTdn3sHt+eInLNJPFi6l?=
 =?us-ascii?Q?YBBxf8iQKzF1qPE0H5Ax5fPVm27U+fM39b+G7uQS8V4JcQO9OPGa5ux4CFlr?=
 =?us-ascii?Q?wuaA3AVOb2k6jVcLJs0pI3/F7h698EekYdL1JsWGNg2BcnxVX/9M5Q5YscSs?=
 =?us-ascii?Q?HE8GKVP2l/ziLe6Z/GERYVQz7dtsBNbmj4vcq19liX5kak74EdQtTGWpIQi6?=
 =?us-ascii?Q?vovCbxprkVH9P0PbCVO17G8lvWdF8q2cFWvGvYnnakuvbimL7bDRsQ8O8Yh+?=
 =?us-ascii?Q?uQs2GfXfVMB+zoB5Kvx8SuXsWy5sdNz1BHNI9mbIfO3ZsVFw1ejQZkcTvXah?=
 =?us-ascii?Q?Z9Y9ekDyIqj0eRA7I/RWi4sDyCRk4x09J5C5OihQp3ZJhfwVC3ssMhcofOhQ?=
 =?us-ascii?Q?bNOpC9gr0stWcf/+pXI3jRgh1wZMVMscFo2MAV0KfxjQGSZqE2tdl0kO1d7A?=
 =?us-ascii?Q?+RKb3FhMfMb2nL8erQT6BOB0UNCL37Os1KVg/C0TlW98LtY0KS5XCP2/ZpBX?=
 =?us-ascii?Q?M0gNeXC54jT6w+ELOchGU6GiBSYOJ02JspNU1xanSeeGFq0YmXp/HqhuIXxc?=
 =?us-ascii?Q?fYEINFjjXyB2sBp9oSpmT65FRY2C2k3C0+6lvvkLevSIUQMInQMyjg6aunq+?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wMoe2VIYA/cQ+B4fyoLzRPmDoh0pxLcF+KjImW/OcZS1HiZvtkQyFlmgmFv2fCUzRotCQ1xTJ2FAaSeC22BiLcqTz6uExZt4X3cSOO7Iutoeeu0YpxMg57bxqd67eU1v2Sx4ti3DGwjGXap9hO6plXWHCIpUBa/HvAlWKhQKXfUmSe6YgxyhzsVhuuQeFVYKZFE1R+KLGvawKb9Ma/vhPCtnMcfcQtM6VYbaYBCcL4VT3jMG3199K0qfmrjuZ18HBQHLwLqOlJcnmX6YOCTppgKtlYmxEERj+CG9+HPUU3btU3BOYh1tgQqVN+9jpxWWxSUYrvquq3ykN/Kp9gMFRqEwLCpSpxXGTjqAYmHiiJlvmcQUOEov7vDoJWGPLWspH3nlHafFPCby/56jb/olf44JATX3w0QlxrwRxzg06+yON/a4rFn82/ZM98TnNhsgkpRjK9xwySNFlQfG8OvHhjy/KKiYo8anijvu5QssDVxggAmHfDpOMBF+OxDih3I3N7Bew0wCS4bd8wTrZLHmuC0CFMZQA/BzA/dhlYrkU3yugMQFpdjqsm8izp6dMMcrYTyIiqtgJAVLo+Hz5ceszKFjeABTyKTAoa+ttxcGlb4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 323672da-d914-4230-dfdb-08dd0a2d1562
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 13:04:50.7393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+UwjCxxH5Lc4AStrs8xtw1O021u2WWyqdokFH+HaZY6noSdC8YS/59aJz/ZftPy9Jy3RFdBFP8Ty/7HQ4O02h4y7UYnE6ant3mkDcV40Cs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7341
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_09,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411210102
X-Proofpoint-ORIG-GUID: GHUUFWxtEhcIxD7qtiClb7gORAU4IoDR
X-Proofpoint-GUID: GHUUFWxtEhcIxD7qtiClb7gORAU4IoDR

On Wed, Nov 20, 2024 at 07:46:46PM +0000, Lorenzo Stoakes wrote:
> On Wed, Nov 20, 2024 at 02:49:59PM +0000, Alice Ryhl wrote:
> > Adds an MmWithUserAsync type that uses mmput_async when dropped but is
> > otherwise identical to MmWithUser. This has to be done using a separate
> > type because the thing we are changing is the destructor.
> >
> > Rust Binder needs this to avoid a certain deadlock. See commit
> > 9a9ab0d96362 ("binder: fix race between mmput() and do_exit()") for
> > details. It's also needed in the shrinker to avoid cleaning up the mm in
> > the shrinker's context.
>
> Oh Lord, I didn't even know this existed... I see it was (re-)added in commit
> a1b2289cef92 ("android: binder: drop lru lock in isolate callback") back in 2017
> so quite a history of being necessary for binder.
>
> I see mmdrop_async(), I guess that's not needed for anything binder-ish? A quick
> look in the code suggests this is invoked in free_signal_struct() and is there
> due to some softirq stuff on x86... so yeah I guess not :)
>
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Other than queries, looks good to me from mm side so:

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)

> > ---
> >  rust/kernel/mm.rs | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >
> > diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> > index a15acb546f68..f800b6c244cd 100644
> > --- a/rust/kernel/mm.rs
> > +++ b/rust/kernel/mm.rs
> > @@ -98,6 +98,48 @@ fn deref(&self) -> &Mm {
> >      }
> >  }
> >
> > +/// A wrapper for the kernel's `struct mm_struct`.
> > +///
> > +/// This type is identical to `MmWithUser` except that it uses `mmput_async` when dropping a
> > +/// refcount. This means that the destructor of `ARef<MmWithUserAsync>` is safe to call in atomic
> > +/// context.
> > +///
> > +/// # Invariants
> > +///
> > +/// Values of this type are always refcounted using `mmget`. The value of `mm_users` is non-zero.
> > +#[repr(transparent)]
> > +pub struct MmWithUserAsync {
> > +    mm: MmWithUser,
> > +}
> > +
> > +// SAFETY: It is safe to call `mmput_async` on another thread than where `mmget` was called.
> > +unsafe impl Send for MmWithUserAsync {}
> > +// SAFETY: All methods on `MmWithUserAsync` can be called in parallel from several threads.
> > +unsafe impl Sync for MmWithUserAsync {}
> > +
> > +// SAFETY: By the type invariants, this type is always refcounted.
> > +unsafe impl AlwaysRefCounted for MmWithUserAsync {
> > +    fn inc_ref(&self) {
> > +        // SAFETY: The pointer is valid since self is a reference.
> > +        unsafe { bindings::mmget(self.as_raw()) };
> > +    }
> > +
> > +    unsafe fn dec_ref(obj: NonNull<Self>) {
> > +        // SAFETY: The caller is giving up their refcount.
> > +        unsafe { bindings::mmput_async(obj.cast().as_ptr()) };
> > +    }
> > +}
> > +
> > +// Make all `MmWithUser` methods available on `MmWithUserAsync`.
> > +impl Deref for MmWithUserAsync {
> > +    type Target = MmWithUser;
> > +
> > +    #[inline]
> > +    fn deref(&self) -> &MmWithUser {
> > +        &self.mm
> > +    }
> > +}
> > +
> >  // These methods are safe to call even if `mm_users` is zero.
> >  impl Mm {
> >      /// Call `mmgrab` on `current.mm`.
> > @@ -171,6 +213,13 @@ pub unsafe fn from_raw<'a>(ptr: *const bindings::mm_struct) -> &'a MmWithUser {
> >          unsafe { &*ptr.cast() }
> >      }
> >
> > +    /// Use `mmput_async` when dropping this refcount.
> > +    #[inline]
> > +    pub fn use_mmput_async(me: ARef<MmWithUser>) -> ARef<MmWithUserAsync> {
>
> Again, nitty, but I wonder if this should be as_xxx()?
>
> But I guess this makes sense too.
>
> > +        // SAFETY: The layouts and invariants are compatible.
> > +        unsafe { ARef::from_raw(ARef::into_raw(me).cast()) }
> > +    }
> > +
> >      /// Try to lock the vma read lock under rcu.
> >      ///
> >      /// If this operation fails, the vma may still exist. In that case, you should take the mmap
> >
> > --
> > 2.47.0.371.ga323438b13-goog
> >

