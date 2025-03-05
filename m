Return-Path: <linux-kernel+bounces-547376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3B0A50661
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BB0E7A5A78
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11F4194C96;
	Wed,  5 Mar 2025 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m24/gyGI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tvyfOOww"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1776B282F0
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741195828; cv=fail; b=tg99ovBnKPug6Z3IwUkhaEkcjBIB6cLXy9xnRDHGsIpXYIhMGCIwpZmt/m3DOD/vjjRH/m1aDxTUNedxOxH5vHV51vB0E0lRZHLWbi98RjQuZioqPGPrySVN5d3kfkiGU5Na6z/uYYUxRzEZYViz6ckJp1RG+oWpdCi2gnzPdAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741195828; c=relaxed/simple;
	bh=3HcCO4TOT6/bpbS6skpCeEhZlPRMK95BqW8JI9jWPiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=duUPGtqw5mWtsutj/m+/TLjVVrT89Wcui4voMq7km7KbgnM2vUxf3qQbd0FfvAw3XIVGbxxHtrXaGZt6lXggU+1h95smdayP1oqK/L/NSuEhTxJ0taOXDgdS0fSRam834CZvma68Eh5u/Qv6m0y6jK40A314QOa+9ZFIbTLS7/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m24/gyGI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tvyfOOww; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525HC0BJ009959;
	Wed, 5 Mar 2025 17:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=XtzDN8JH6SMxZQkKhH
	yufaMGNFPmqsnZeM6fQp+9v2A=; b=m24/gyGIHolfEXMgqnUPCqdKJqCLmPuUcw
	SuqeHnrbIwg04yf6V6bsShbmctdbk3JHk22/mwrn9n5m+OzPkqsrJ0yPHauoy9qo
	jY3m6BWdBZh6HJ0SqPIU5IN16ga7mr3jfvGb3iiAG/H3BDvw8xT6px3i0RNbYckT
	h2HTBrbRQhQH3wiof4SkOZsfCxr4idZElzSrAjW2+OxL06wK6f42zBNSGSp7Ug5G
	6bfIlwxOriaSsaB+Lrx6kD9x9JHKR5kQHtGRykq6Au8koV9rviQm6WnrMkIz3ssr
	f2bsvllP7sdSXQcaRbqtr9HmOa9Sk9re/TXVVDcwxkQkJJ6zcL1Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u86r5ha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 17:29:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 525Gqb6n021913;
	Wed, 5 Mar 2025 17:29:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rwwmuhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 17:29:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUm3imhov8zg2fuj5zIsvlkcOaZ7y56btya+/TYl+LgF5AjW4ly70u/e7jMmLOrSTPkiqT/+yjxWSoNzcYaM949Tmtd7hbC8QVVVSKZ3hHE4KbRHnKicJCSvBLgrRBciZVjKdGdMyTg7MUUmSVs4Uq3/pGgmLPrOtggH0g8KNBuIXbDsN42YNuS2MLtrMauNV/J/uOuQ56n4rYtBY6TXmXBrt4AiVyNYNAGY0I0ZnFN8TThZOOqRbu7V+8v1s0ZZx9Y7HHrqEAEd9/SBRvmEOMyYVCHtYImB15sriz6Iqok7TkJ1wvnEKElt4KLzMlUyH8h85Gn6RMNhuWPJSeMwUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtzDN8JH6SMxZQkKhHyufaMGNFPmqsnZeM6fQp+9v2A=;
 b=CW2Z2Tx+mAZ2QofI8f1LKg8I9p6NHHhQtVl9r+VsvTEoO++d9Z7+jP1WItDGvFBIxgbEbJNi+ZAhO4UN9c48qpUCEagdOoSjwgUDbdSaF2VgYkXkAG9UN7cdiVoPJ7aTNFnsEjpq3HOFWm6kwNUYFMFBbU3SPtBUtjERIqQyAnKo6rhO4PG24ufcKK0/JgQt2O72dR9TaGbgaMj7AQOXZSClvnI+SoV/6ybgwo2yBLi5Nt0kpjDYXzipEzVSniqQUjKz+Wt66T86xe2KgHYFVsjED8yZoFBH5zUMuNLetJ9DubHwkpPtW0olABtfJr8d9hUB1BNrDEF50RJyuVzi9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtzDN8JH6SMxZQkKhHyufaMGNFPmqsnZeM6fQp+9v2A=;
 b=tvyfOOwwATtzHn7Cp8MG3TBVlWxyRdLLNHohk7EzZVAGmAEljVpR4xvKo4dQkr2T2T1+nlvRm8qjAj4PKHD6EdFGcZuOGY09LDrcOPvZHWH3qIZUmbcYxnszBJ8vN81McRchU8qfD7FyRuwPO4rNPa0ohmr59YQ3FNXVVoqqJuQ=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DM6PR10MB4266.namprd10.prod.outlook.com (2603:10b6:5:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Wed, 5 Mar
 2025 17:29:54 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 17:29:54 +0000
Date: Wed, 5 Mar 2025 17:29:52 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pedro.falcato@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jeff Xu <jeffxu@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mremap: fix uninitialized return code
Message-ID: <bc7c9b8a-83e7-49f8-bf0a-2f2bb950b99d@lucifer.local>
References: <20250305172800.3465120-1-arnd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305172800.3465120-1-arnd@kernel.org>
X-ClientProxiedBy: LO4P123CA0472.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::9) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DM6PR10MB4266:EE_
X-MS-Office365-Filtering-Correlation-Id: 15378ec4-4c5f-4f4f-9d11-08dd5c0b57b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XoO4ixK/gd3Szv02n1ZAuZ0/RJIPwWiV28+NnvHHCqF+MkFqzxNsqiM/j5r0?=
 =?us-ascii?Q?QMkn6hAq9neh7LeH4OXOteGMUZiNggB4gj9tXfoSYucrL8TufZEnq6VFgpwK?=
 =?us-ascii?Q?XKTdhab6T9adh74/rncPM0f4r/dC52QH8VtzoMrIf8fXRFf7iPruM5rcNRhY?=
 =?us-ascii?Q?hz3mcVWjEjhC/wIZr5DeQnlBVAY1+xLNYWJmDuIwOJv+yiUffnJ2ueIuEt5y?=
 =?us-ascii?Q?oGiu2gxXjlaSqeEwp8ndzVjacWxGcw2trobvc8WrGTR4NUM47YVCTGqYUfjq?=
 =?us-ascii?Q?47GIaBtsiVVjsGpEZ+chXn1raU2UY8Tqcb7NQ8jEhx3yQYakUMy29vJ22z7F?=
 =?us-ascii?Q?/Jwbu7/sEU5AxJfhS5ju5dQGIcID4SWUY+dEGiKYM3coL8Y+kPe0zIeNgBbN?=
 =?us-ascii?Q?Ev0vqhlWtQRKqWRwz/XZ43Q1/yR/4g0iWFB8yVCCpXkPOxY7i2twUpx8I5Bl?=
 =?us-ascii?Q?jLThXV3odhPA2kbnEZg8zNryYvzDMJ6TJujYJ5F4szZHrE+lrAUDSr15RPNk?=
 =?us-ascii?Q?zXGkDZharOOAVTIJzSNC1hEwoCdz/caGQv6CYw++y8nJY/ZYA+0o07FycCbt?=
 =?us-ascii?Q?TvZN84WCFH7Ng/MhYGZs5Frj019p5+1SsIrcUOk44FXf/aGV1WBCv2OfOnxc?=
 =?us-ascii?Q?dUKcCAwJN1LCxhK/BdRfiRrQ/JiM38J/obOcfs9wklhOH6/+KaTdMWqJER/A?=
 =?us-ascii?Q?/GBoS9zcp/27kL+Yw1vRh0zZhupzIScJFcMCO5BakaXlSqZMApB5R1kjqvqA?=
 =?us-ascii?Q?CeT223tleovuopNKxcySzuSrBHfQfGNab+ju5M1fplk5ILovA6nvg6zNvUqj?=
 =?us-ascii?Q?yOUbREUpIl/Mo0xs2NpBXMf+cZOgJOrGZmwccNoDgkac7Uxyz+JQuCwxTw57?=
 =?us-ascii?Q?p4p/qstWseqNU3ec/oLEpT6CBlKlNrmArjOM1s9slwPmd1yqVs4P85Ul503m?=
 =?us-ascii?Q?M+IRMZaE05Cd7vb+ssv/vZSy/Vnv/94S81AFme28Cc9nTfN7h9elcxB5iBJ8?=
 =?us-ascii?Q?XCu/BoW/2Oa8y3swcZkPbFZ0uML3C8+vdpX4fn1KlrG7PzUlr/kaOA45Hom2?=
 =?us-ascii?Q?kI/mluSaF2VwrXc2vncFlMGYMLN3oFvqzQXm5mrdp6u/QAw4NsSMIZQphQmM?=
 =?us-ascii?Q?LNxXMfJyNw2qnLVogebUc7zSD3Ppo2ZyHHWYcrKQYcRXOW5ilcok1z6qs20h?=
 =?us-ascii?Q?QpCQEaRT4BQJTDIKDA0G+Kc5dBkNOV7C4rg6ZoFdGPx1K5dpNPM/4/IUKYGa?=
 =?us-ascii?Q?Y9yTEecv8ZpjSXJMEnydAJ0CsTJbXjLRxhWTviCqyxWK64j5zvx9PpnAp047?=
 =?us-ascii?Q?59xfTG7s0V56akAF/pkIl4F+ozQ4EQRmYhyfGjXjsIXLlb8W8ZuTLpk+IH5/?=
 =?us-ascii?Q?KFnl891J9CwLSVy2CxLZYdTKmPAE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yyt7J6JNg20X0EkZCtz3VaWt6+jDv5CBCyIcA3yN1H9UsIbjJDh4g7aVh7ot?=
 =?us-ascii?Q?/MEHM5VxEPLsk73MVmNJYFTv3GKNc2JDhSEvZ4M1xuL7vFTALIGTPYKHMBeb?=
 =?us-ascii?Q?EDFRACIdR3QlmMc0+EM8AIgOADc3MjlTLfy6NxVt2jl8wzaOIR+LqA4MXfuA?=
 =?us-ascii?Q?2dljUqCpwIlvs7Mkaxv/IeW3GyuN1FyoZ9BI/uqrXqIvCxbiMRX+AzRM9dgO?=
 =?us-ascii?Q?coC0A1FUOwHyRSw6tRKH6aPVHFvXUm12znvXbJXJ3WefQf1Rb0kBTmb2iiOj?=
 =?us-ascii?Q?j3b3GiJUL6eVuuFHydeijtoXrI42+19FT/MNoLTQeCFXfbbSUgD2B3rfBpRN?=
 =?us-ascii?Q?Rt6msv1bXFQ1Eq0UtsZjxeur36hytQT4qA1SC0XnVwWHKxZX79Bk8OmYsm0E?=
 =?us-ascii?Q?XibPik0mkVgNr7FM4pGL8yzfRlZsZCydbfRsi/mAdTM2pZ2azPQOHzX++C3Q?=
 =?us-ascii?Q?9kL/WU5fhzxf7sCBWSb+PPgHoKHDqmmK96l/99a0j6AweG5XSW3Gn6UYtD1c?=
 =?us-ascii?Q?yJgPdQlhhi6sqmpXfAJQXcouQKMMdgFfHlUVwg2tefeFsOeteG5U+lnBKmoY?=
 =?us-ascii?Q?dWMsGuEBFE0eCgqmmQlIJjOoqL4ofrM4vr/5ElhBp7Ei86FucLfa+VuD1V9A?=
 =?us-ascii?Q?b6ibGT9y3/zq3NN2YU/sL9bGI8sCXVMGPrGZdG1a9rD1vbrCEnbFtcHXLHNb?=
 =?us-ascii?Q?GYbfdfIUNTPcCtuXYeIG5gCJ/5x25EZ6jB21tEE+8wzdoBMrdiPSUZJ4PlDK?=
 =?us-ascii?Q?ibhruoG6fShuuOV/3ixefr6cFE4a051aSi+k5SjyyDA37/pdCfizvJHdzplp?=
 =?us-ascii?Q?0wZZYWXNnkPkUF9Yln6ANuc4wf5j5w5UGmiMravceAceUj08B+8Qp0kxwb6W?=
 =?us-ascii?Q?nFjeEqrsxrOX2OZRz+mmx2WJjpMshoUD8tv6LXQ6GK353WXToIESHttwJGEf?=
 =?us-ascii?Q?YCBc7HqDLGBPe4AQeRLQnuKro5/stI/R7PLPyy/c/ZP+N+fvwreQLvNJwkxZ?=
 =?us-ascii?Q?krzODhwXReWIzt52ObxFv1fiTKE9OUr6YaJYXFxG1h12KQVwJHGsiJyYNquM?=
 =?us-ascii?Q?OUxc9sG0hehsVHdunNM/wHWD64T3V3i79HIHiCDCzogngpB2tHojQUHJ2gAA?=
 =?us-ascii?Q?pwnoLZCv6WkNAirvBbAaUrHlKhKAWHteY6YC34y8Xz2eZQqaYD17+9kvGpju?=
 =?us-ascii?Q?I085BLIosiMl5f2YyltaH3bamQPDSdeG4bBs3OFRor7fWJnWeoqeSAoPgSFv?=
 =?us-ascii?Q?t4jQfXMEzl6/RHWO3Dae42ZC8vSrOepviJg7TLXo26bKO+/yVfImgl1Q9pWn?=
 =?us-ascii?Q?449yCvEC2iX9++aVcB6Kkm8ELJBI3n207qp15kWAXR/TESnl2KXEzYLXcqny?=
 =?us-ascii?Q?AWXua1gLi5nfM7Y4tvWBXVte7GFFZ9hi7ND1MqOPGW0lXP4KZqsEal1ednLw?=
 =?us-ascii?Q?vzux7o07wswphQ7B2XqxRxotTjKwR0ZUi55aankMXS2HVFPdlpUUbc+4Kjmj?=
 =?us-ascii?Q?LfCqDv0JYCrdRP1xDuhRP1Ptk3ZtZCjN3ESW6K/DIznV2oGHVjoxmiE2qReF?=
 =?us-ascii?Q?e38WqUyzsB3SHfgYJR5i7o6FRpAHq2T9asoNjC5+bu9oYeA11rcg/YQ5K8iS?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7pT6MbmE3WfhRictpLGEENLLvExRQX1PE9BL+dF1EMT3aXXiLztXlMa0aYp2fGeAqTwmtxbBNYSZTIldMs7BHfS35OfEG75B6B+ls3VPoQ9U82h8ZgKzBRd4uR46du8qJtuIW2gQXFaOHp4QZw6c6IALHdP1VAIr4xQLJKOCGikXur7AJMWbeoNvv2iVXlS1P96374TwiEn9V7FD71hj9P9O7uKTPIUsgrtEweq5sWpdN6kyQGUjmWXjrrE5vP8r36LNTet3vY6Eh7WiylxyC8NxHm92UJXKJKOYj+sOoPiik0pxqvILcNQBf8wa+/vR8BwOrQY49baSyiyz3/bpV9vCavhA50eYBpyr7aRllRp1sjV+EMMAWhK8PzmKxIN+Y93mHukV9lx3LNVLe0Ul8eXM6IB4Gy/bHvekdVvw+3WamieOxP46P9UmFg/XDrbjSzMIB3NPxDQPiBPX9KoR6wNhLskDiu05U7D5+EynKbeXg+sYF9dOmG96jhB1sT7obYt+X9AKc18s0c+aP+ampGTWXVDYry+B3RnASHxtPJmTj6njDbfnWstGsLibF+tsdzPCpDexwt/PN0OeVQ6yH1k/OkSOvgs2sfCKJjTjwJE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15378ec4-4c5f-4f4f-9d11-08dd5c0b57b8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 17:29:54.4474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/reHyfENci+q1xt8mKqWMAktUgnlhrWuMV5f8g5SCqCP80+YfCSZaZ1cp+LJPjHECSBxW23RjLWpAPHnOJpkrBQGkRPQxJnM0MM5naxsf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4266
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_07,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503050134
X-Proofpoint-ORIG-GUID: PvbaaFXoDTUQIcinhiiNg8d1JZn52sNv
X-Proofpoint-GUID: PvbaaFXoDTUQIcinhiiNg8d1JZn52sNv

On Wed, Mar 05, 2025 at 06:27:56PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The 'err' variable is set in a conditinal branch and is not
> set otherwise:
>
> mm/mremap.c:1017:7: error: variable 'err' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>  1017 |                 if (vma->vm_start != old_addr)
>
> Set it to zero before the initial value is set.
>
> Fixes: 3129f7896afb ("mm/mremap: initial refactor of move_vma()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for this, however this has already been fixed via Andrew doing a
fix-patch which should land in mm-unstable,-next soon (possibly tmr?).

This is entirely my bad btw, for some reason my compiler locally didn't
catch this even with CONFIG_WERROR on which _really_ surprises me...

> ---
>  mm/mremap.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 456849b9e7bd..9c51a2360d84 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -1014,6 +1014,7 @@ static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
>  		return -ENOMEM;
>
>  	if (vma->vm_ops && vma->vm_ops->may_split) {
> +		err = 0;
>  		if (vma->vm_start != old_addr)
>  			err = vma->vm_ops->may_split(vma, old_addr);
>  		if (!err && vma->vm_end != old_addr + old_len)
> --
> 2.39.5
>

