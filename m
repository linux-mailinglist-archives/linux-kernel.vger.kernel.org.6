Return-Path: <linux-kernel+bounces-277924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EA194A82F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 388F21C21299
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CA51E672C;
	Wed,  7 Aug 2024 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JFuHojza";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ihJf43Gm"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E3C4AEE5
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 13:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723035794; cv=fail; b=ohdwhXwDrR4u0RkrKD2z8dE5IgzsHTMzNODLa/tdFsNFuhWN22vkhUfgFxCMy3Br7uLjkBGEORIjpKr748i1GOFZCixipIMM2M+ahGySDqAhPyDYnd7Suvwhau5QN4N4pqn51kAiHPL3O1m742Oxiwt/mXJ/XLV6t72cAgULBJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723035794; c=relaxed/simple;
	bh=UCMVfvZITm6Lh3f03t7KDttHVTXKLB0o61+fvHsxqcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fVudxLGSbrcp4xuKjG2pKBJofSCLYDLCt5c95kLHnLDCLMezzwKJf29scUjA0pnAh1/SVLFeh5RF1j9dScX7kfQfZsEuPweQyr2QEAW+XVR1wRcQ1VnRppZGbmzFBaPCn5kmOt8KOODQCne8hO80t2+NWRb7kfBGvJN0kGVu6cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JFuHojza; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ihJf43Gm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477ASJbZ014075;
	Wed, 7 Aug 2024 13:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=fqcT31IVQ3QspYH
	QX6JKwOTd4Pc7lClQgvvyXfDQ7VA=; b=JFuHojzaZSCNkVbRtwvYg1u/g7Uvgks
	1MokP2sQgkYfej68PFS9J93FrkB5z4BDOSW24wStsmI/2JfzP2yjpNczs883UyIK
	VDb0l+vJVHb7fKaOB2OIAU6ZGpVDpd+z9qkZ76JgeUvemUv8IOBb0IGCYilKPOHl
	tuj3vJNwXDgcqW0yhdHsSB1AZMIkpnxx1XU+6isU5vVHK039zGnMVveKWw1tbOvd
	WdWgKZfauwZf9uQbdisW3Cxco9F9KYf/9eEg9irjMbZm+xXEvr2YYs3GZhutGlDd
	/o1FCScmo9DrMxeh/FHnrvx0cfVVaNvnOZ1shF28UizAYB9iIz4axjA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sce97d75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Aug 2024 13:02:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 477ChsoV027399;
	Wed, 7 Aug 2024 13:02:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0g92d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Aug 2024 13:02:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDQk4EwFXJWeUhcuqIVNomd5P7DVetpDbDmYfudQ6EErqfVaqmgM37H+LpCvdwWGjJ/tcvixJlgL0Pe7N/yLLcNuzaVliMeqwRV3hkYCU9LzNOiTj/wUBTXc9f+uocGrgRxmn9NVrQcyszIurAO6m36pHnx1IKlPO0vvUZpRnYUdgzQdxfVM2eDwWt7JQL7v+ZIWtSegwLoGOP1lU+kCP6+WxRJNjmZwc5u6I8k5Gng18pHxl+lrYCuX2TXhedIEYqnXtgKl2YRnc7mjvTEdmrfP6OOL3jQjAKrcI8DJsvLVremctaD23eNRjXnmokWk9zzradBxJeUaRi/5U/kOsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqcT31IVQ3QspYHQX6JKwOTd4Pc7lClQgvvyXfDQ7VA=;
 b=Bg9BQ7Qa6ugyrpNP9Myyi1zHRKmaXurMRwxcY0lK2ngx5U8GFWr/2Z/SFrI+BGd7WE3QPgHZ7/GfED6IlPDQYmJtCpmSfDgk0Yx+ZJdmQoCZvgIZsqaIpSHFd9Jptqd2wcCuEnvpHCvAuQQCTaSi1WhzVThTgzs80PDXGxFvRHtL6AU0KnJ+xeXEfb0ceb+Vn2aQ6oB5uxoXab46KVsiejwbhMpdvSvCuFd1siOimvu/2cQNCdiZ/HoTUKC6WKZ3G7WrM64tJ0OMQNOebevKJkcS/mFObHqfRv5NPhNI6CHTHwzQQ+7XnjnuONl0dtx6q9NVPzBbZxRcElTnhi0mFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqcT31IVQ3QspYHQX6JKwOTd4Pc7lClQgvvyXfDQ7VA=;
 b=ihJf43GmPctLDWPnw816yEogi/2GB2Ue2PhN4LNF37NG16+4/Rg769pWzV7ae+QfA2ubN5xVB64i/IUHucE0G/z5wXyNfiPMwUt8qQEVnit0cUmz+9ovUvlT4t2kwkesBpUklbd4NhmfCe4veyphLnJG2AbJXV8Q9DyU+8xRIZ8=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CY8PR10MB7194.namprd10.prod.outlook.com (2603:10b6:930:77::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30; Wed, 7 Aug
 2024 13:02:43 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 13:02:43 +0000
Date: Wed, 7 Aug 2024 14:02:38 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, oliver.sang@intel.com,
        torvalds@linux-foundation.org, jeffxu@google.com,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/7] mm/munmap: Replace can_modify_mm with can_modify_vma
Message-ID: <4a84c992-58ed-459e-bf84-02c59ba1d00d@lucifer.local>
References: <20240806212808.1885309-1-pedro.falcato@gmail.com>
 <20240806212808.1885309-3-pedro.falcato@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806212808.1885309-3-pedro.falcato@gmail.com>
X-ClientProxiedBy: LO6P123CA0055.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::12) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CY8PR10MB7194:EE_
X-MS-Office365-Filtering-Correlation-Id: d0e50975-f944-47a7-6332-08dcb6e139d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+AoRCPRSXoHkj8jN03MwzqW11pP4KVD8zeVCXAvg+JGc5VhZUH3jsTS050wB?=
 =?us-ascii?Q?HBqgeuCdtVbyRZr7JPrlWNgjyUGh6m9YN5fUYuoHL1CburTX60JcSvVMBFuA?=
 =?us-ascii?Q?Bj3LaeBKzkEnBwIU7kddFoL1foDbOBx4iOq9dNBjez6PXT96fo9EbNbHj7l2?=
 =?us-ascii?Q?RhATMEi7Sk6m294nrHeoCBeMq00bs9X7d/5fKPh6O0kxtuCQKWy9rnpknb/R?=
 =?us-ascii?Q?pWFajvwiXvs6gxXoTpD15StEfAIGvWzXBj73VGvVWvsdTux8rRy4zXGoZEUl?=
 =?us-ascii?Q?OvZqSArFlojw/SmILc6YPwyI1eQaLo/z+ogZRD9mWImjlf6AAx5D8qWS5dRR?=
 =?us-ascii?Q?NFevPfp64HciftYsJn8qHlQ1XHeOGpH7c6fTqkTHoP/g5eAVl9FAD11XQLG0?=
 =?us-ascii?Q?1ywo62W/iNS1K7yoR1G3oScs5uWoZTcUQwgmzeWANKBvfK9OJyD7WNsEfH5R?=
 =?us-ascii?Q?cE0pZa8XcloC9bPW605dA0DhJkn1WfGeF3LtEgHE6vlliWF3T5kUPC0XLgff?=
 =?us-ascii?Q?EgWpTRdLM686rlrZcz4MvbTQmOs0lsPIQPyiIDzSIzrqa/tlEl7qZnfcv2PN?=
 =?us-ascii?Q?oOoTPhWaOaPk4+a4R/vkoGekPW1Ec3EYNmeCHKt4aUTfzYxNtOXHy8l9AXF1?=
 =?us-ascii?Q?cL65TflFl1yV1EIe6OLc2TL4v7GlcvwYwktbA+OBCTcm+WgERE41vZH2HY3m?=
 =?us-ascii?Q?HWeSGdV8t03yx06X/UzfC8mD69erFj3hWcg83oWA0GHnOkp71slZe/5G2Iav?=
 =?us-ascii?Q?bPq8ig6ejuP5UaEkrCKs9nKkOCsCrNqcoXqtKEQlY+w0L7o9GXrd+0OZVsHQ?=
 =?us-ascii?Q?WZqkl6FPM1NxGX1G3P9t1ieFS+zhJ6DxlLize20tkLBoj8Bf0GCsAIhTBKzD?=
 =?us-ascii?Q?WhaFgPzthewPlPaTX93kYRlgs0kp4YiWm5ZQsxb5Q1jznpRpm64YQ7wm6TE7?=
 =?us-ascii?Q?6qJNQHFclPCi+yHlCtu3YhJGMKVCh07SQz/L4tlBpd8XyGvM3nR4zqJyg5iR?=
 =?us-ascii?Q?/qC1UKeFKx80Bdgl2mmBITxH9sVjaw+hpKYc5aODkvBSsxNZ19z9KRP4yHJ3?=
 =?us-ascii?Q?oif+ktE56rPz4Op7blrTthJfVOOhGLEQToPLeZ03gqmX73kPN76HHgj3Sxzs?=
 =?us-ascii?Q?QM17w57QbxN+sWFOmOe26grEv1tYEp/4prBfIU0xVqzngowCKAK04Fc7LI7Q?=
 =?us-ascii?Q?CCJ8utZff8/WR4yM3d4wwIWYYy4E2MWmdQiNbg9CmFsxW/9A6EBbUrBOvVQg?=
 =?us-ascii?Q?t4N/M4x0SGNB0kcGVvf716ToDKakXJ+4VI/3RH1UTM4cvP57nrKzL7MsY3+W?=
 =?us-ascii?Q?OtjvgY9ffoev9lG9Up8jZG7+xm3NztxGt7y4HTMZn/0OSw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XBOzcB9dxhLwT920dLqoxYKnPR8ck8XZOcg+857uNWRaa2ffHqCO11ivI57a?=
 =?us-ascii?Q?OBCQN4R5cDlV1n/mVqWwwjY/l4IKFsLfnfZSqra6nRhpiaeD8gvTCOPjFy7l?=
 =?us-ascii?Q?Z4Z7TLGsq37sxERUyA/eqr0AJ2GitmAVLJ2SudjhGVi/15q4Fx/fHYn4wlgi?=
 =?us-ascii?Q?OeySoPb1HVwGBAPCLCFJ7Sf4FVlpmfgcVgkKPQ12ysL3FKI3yGtCxPlPDPRC?=
 =?us-ascii?Q?uxwQjgTYhtfvVAhOZaQQ3JEtqiqbPO0PI/5k2w4/EegBqcbL6VZzyMpi8btj?=
 =?us-ascii?Q?7HWjpTNUBuO6T/UW0XSL8t3Qrb2VLiQkEm3yxm81eZp/+dM3l6bW0f3l2Ipm?=
 =?us-ascii?Q?EABBr6B4RgmemKdfKuAgIgEnej3curHkftgSua2u3pj+2V+OfrWzmwdWenNe?=
 =?us-ascii?Q?4p9K0m3PKzaWofquQMW0YyRGHx8b4U5liIKWyBQgV9+A0YSfIcevntv4p38G?=
 =?us-ascii?Q?pNTV6Zu3Yew4zWsJWP45L4qJSWSTdfkSUAlYkC54lTgPwpnaI6Sq9O79uoMY?=
 =?us-ascii?Q?26d1I+P+c0Wc1Ec/c3sNpIx3dw1HMf8Zizu2qU4usEsPO/UQYIQ5KMHF9gQ0?=
 =?us-ascii?Q?Dz6s1KZFRPUtpL/91KQZKW0KBdQ9OjXk5rzAVjU8M0mrZcKPeRWh7QbyO8Wv?=
 =?us-ascii?Q?V86rDzydSC6xopuoE4mtepR0AyCofrT4C9ulyHgAye3Qko8j7NX8jxtxL07A?=
 =?us-ascii?Q?obygkofPaQ9g+Ygx1kATDMuq6d5SKrfuxNQ2p4h8D8PfVCNWMckeJH+0PUfJ?=
 =?us-ascii?Q?7Zg8iyxV7TKHko4pDxskIlOQg3YbbOZhvv1/XNw8zDXiVw2drs9Wx7533vc+?=
 =?us-ascii?Q?kku/ShD1X9UJjoD5FWaREfPQTfwOF6lqPLAZzPMvHuq0+tMEeeDTcnymZW+/?=
 =?us-ascii?Q?j6N7xJCYvs/n5vNnNlxIoN+G6a/n79Koc56p7ybCvet9qEbOVfTh/R7o47bN?=
 =?us-ascii?Q?T60oipSvuC18ig4eXGCt+5z7yNbF2zi+Mr+gx+3aZn7AZlAbBcLfgXmDdLEU?=
 =?us-ascii?Q?wr3A7yFZC3kJL3z0N2fcWkKygjkM4kvpYaDs1yWYFY1mWwSRAq7yGJLIY/tv?=
 =?us-ascii?Q?PSQCZ5Htb6yOqON6rk4wZqewkVYk/weKyb/HA90i+7iYpR8o++txR/QJNXXY?=
 =?us-ascii?Q?v9lBrzMQU4VATNu1MXYFlEHeo/JzOHGdSiAdhmYqX3U5e9gP0HN2fcVrgTuC?=
 =?us-ascii?Q?hPtdrJkZId3BFfNl7505XqWTpKGVtWCvQpHw0l8tig0DZYTqWLOvsnc2gUmt?=
 =?us-ascii?Q?JZ7T5I56wEIC/8TsS+3N7Pfe/9hmKkrn7hT81qtiLm128pCIDJlV9iUeAI5K?=
 =?us-ascii?Q?mGwKJm/PeArLIZbJqxsDkBwg1ToKSWc48Fbypjdx5SZkXFBoFqveG+Xl/LYv?=
 =?us-ascii?Q?g8HJ01FqpJaiT0W8pjV2YyTaC+9HhV+uR1XeIYE4d+hJjINN1SFNQ7A65ENU?=
 =?us-ascii?Q?Zloy5T2WDnHAR8xTDO5DYJz5po3waLPq1SWshrZrHDJrDpLGEN77ybdl8gRv?=
 =?us-ascii?Q?+igHbMdfn3HrjKZ+dwu6vFpcjmveHj/J/z/iBHfq+K6advwrSwqwjIYBchDp?=
 =?us-ascii?Q?85MAKWtu9TtCmTd1yIdlo5riygyRzeT3dCxuH/XTSYaiDM8j8fzjzhQ19pBX?=
 =?us-ascii?Q?7WwCFT49kV/9vPWmh4fz7YIgkPhKx6WeEEWXBwKlaZs5xfJRD0k56yoEJNon?=
 =?us-ascii?Q?oLiRkw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NTWKBOjJ3lnUKBupkSOc99/sMq5EIziba53UBKgmsDzNyviIIAuWOarqU1hYhEUhnoGjdTTXrADcNgpvHOn40+3D1c12WTO1qQN4I6utXyoYwMuw+f5OW9bI0ilRYKvT4zPnUJtibAA/soGIAESPdczieE8nJanHPodTWxRGavThpOXBHQHVHu0RH/D9n3SvSuopWUY1LscT2cGwl1adtK3uRJNeyXTSq7x8HVZho1IXh+hxaLEa8AmxIcS2jcohOyNcKXQBd9Jb/+L0KC4s/cuIjHztyDhS+W2kZD/U1ueT5oxAH+Urq5yAvcrV6/ptrfUItwPBKZXvNo+6TgUIm32CMivUFfLT4/6QHmFyz3BNYyzaUVZVkHNvO235rkPDCOzWyRwXPZnwX72JGr5oTzG30pfBW2b+Ift1Zl8FlQv8acBvcLfGIKjML+rLdf2vJudwjv1ZYjgc2OZgGIgYM2qvAd39CBsYvvd8LZRklroGK/EJ1I/t1/hRXvWPeygJkC9xDTjP4VmqZ818Zvfoh5weTtNxsQxMWfft+mypMPB1A846ECirD9XxfFI4r4Be2xTsFCs50EeBsTpJEJJJPkFdPFu0mLY7mhYDL6JOCVo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e50975-f944-47a7-6332-08dcb6e139d9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 13:02:43.5402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZxOAt6R4p0LjKYbzvbYPaJXrwT1Lih65XN+enfj4+NkPYoIZB0xaS9Rm8nYQccSviss5JUR6o487vcckAFv5tdLeEjGn3MUNK/Doe7wvHTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7194
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_09,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=903
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408070090
X-Proofpoint-GUID: VK_RPmLtjqvTTmAcbUDPn8QwCVmafjsj
X-Proofpoint-ORIG-GUID: VK_RPmLtjqvTTmAcbUDPn8QwCVmafjsj

On Tue, Aug 06, 2024 at 10:28:03PM GMT, Pedro Falcato wrote:
> We were doing an extra mmap tree traversal just to check if the entire
> range is modifiable. This can be done when we iterate through the VMAs
> instead.
>
> Note that this removes the arch_unmap() callsites and therefore isn't
> quite ready for Proper(tm) upstreaming.

If this isn't ready for upstreaming which is it being submitted as a patch
series and not an RFC or such?

Liam is likely to do some significant rework of this arch_unmap() stuff
soon, and is certainly significantly reworking the munmap() logic, so to
avoid conflicts it goes doubly that if this isn't meant for upstream then
it should be RFC'd.

>
> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>

This patch doesn't apply in the mm-unstable tree. If you want your series
to come in through the mm tree you need to rebase on this.

I made a major change to file structure which moves a bunch of mm/mmap.c
stuff to mm/vma.c (similarly moving things around in headers), which is
why.

It also means I can't sensibly review it... :)

> ---
>  mm/mmap.c | 36 +++++++++++++-----------------------
>  1 file changed, 13 insertions(+), 23 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d0dfc85b209..b88666f618b 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2660,6 +2660,12 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
>  			goto map_count_exceeded;
>
> +		/* Don't bother splitting the VMA if we can't unmap it anyway */
> +		if (!can_modify_vma(vma)) {
> +			error = -EPERM;
> +			goto start_split_failed;
> +		}
> +
>  		error = __split_vma(vmi, vma, start, 1);
>  		if (error)
>  			goto start_split_failed;
> @@ -2671,6 +2677,11 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	 */
>  	next = vma;
>  	do {
> +		if (!can_modify_vma(vma)) {
> +			error = -EPERM;
> +			goto modify_vma_failed;
> +		}
> +
>  		/* Does it split the end? */
>  		if (next->vm_end > end) {
>  			error = __split_vma(vmi, next, end, 0);
> @@ -2763,6 +2774,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	__mt_destroy(&mt_detach);
>  	return 0;
>
> +modify_vma_failed:
>  clear_tree_failed:
>  userfaultfd_error:
>  munmap_gather_failed:
> @@ -2808,17 +2820,6 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
>  	if (end == start)
>  		return -EINVAL;
>
> -	/*
> -	 * Check if memory is sealed before arch_unmap.
> -	 * Prevent unmapping a sealed VMA.
> -	 * can_modify_mm assumes we have acquired the lock on MM.
> -	 */
> -	if (unlikely(!can_modify_mm(mm, start, end)))
> -		return -EPERM;
> -
> -	 /* arch_unmap() might do unmaps itself.  */
> -	arch_unmap(mm, start, end);
> -
>  	/* Find the first overlapping VMA */
>  	vma = vma_find(vmi, end);
>  	if (!vma) {
> @@ -3229,18 +3230,7 @@ int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		unsigned long start, unsigned long end, struct list_head *uf,
>  		bool unlock)
>  {
> -	struct mm_struct *mm = vma->vm_mm;
> -
> -	/*
> -	 * Check if memory is sealed before arch_unmap.
> -	 * Prevent unmapping a sealed VMA.
> -	 * can_modify_mm assumes we have acquired the lock on MM.
> -	 */
> -	if (unlikely(!can_modify_mm(mm, start, end)))
> -		return -EPERM;
> -
> -	arch_unmap(mm, start, end);
> -	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
> +	return do_vmi_align_munmap(vmi, vma, vma->vm_mm, start, end, uf, unlock);
>  }
>
>  /*
> --
> 2.46.0
>

