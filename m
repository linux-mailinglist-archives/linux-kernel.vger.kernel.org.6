Return-Path: <linux-kernel+bounces-554427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E677A59793
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A9B3A962C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E5522C34A;
	Mon, 10 Mar 2025 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KG0Z9VDj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CLOWsON2"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A341B22B8AC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616953; cv=fail; b=XQeKZL713qPPbcM5jsWLZSADJiVRKX6lCmeAGcLr3Yvrbk96VW/K4SmWFJwH1p8NAaRwSTPvixPll7yFBPngUNYErkLrdRJoWuAgCyDcxvSW7BRIINXh/zATswFTlJI6kmx5vHr6+YFwYWlPLAQ0Cs6JhJce/H1MAnHV3BQVKoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616953; c=relaxed/simple;
	bh=GDEAVC7uIqSAFwHRgTzvJ4ozbdbgqVh/OneXUpZN+Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r07d2Touj+reSjEk/2IMnBBhty/ihgAvGHx8+GaR922tIppqmQhxuiHcvPwBFn2f5rtkwDHg6dS51W5f0+I+YBPdMucBPlSekpHdBIZCA96PL1qEQpVk5jyu3Rqc9d8owhRa1n/grBBz3FIxtdMlaQS0q0aCijw0CGqeys/dhVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KG0Z9VDj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CLOWsON2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ADvrp0024933;
	Mon, 10 Mar 2025 14:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=QF8MEYdRdJ6UTOZsnv
	dcAiLrJyuHLKmeUhD2uUyFajg=; b=KG0Z9VDj6qYvz+uHxdALDGWMtXl3S8hpj9
	+5YblpB+TZ5qCgJSWt7kpSeSVFDP4exuloqtCQJuwGW/8vApIMl2aX9lZpnLykn3
	Tkr4pHwKi+Y5rd8Auv1eUlO89lVzY1YtIOOT63PlTuwIILFnEuZTVKgh4NIBTfyb
	00bjd0Cb4N6KDCWj5psqH62Y8AwGB4hrcrA13uz7TVVefyDrGPLVGw6vdntGGgOm
	nN/hQd8y5KCMknGMzjKTTj5AUbTQph5w7YL/GB+qn0BckGorUZEzTfZ0UVir8HHQ
	5A9tL8h25m4eON1EQ54+VWAhmRJjyrp5pQpLzCDHInM2qSyQOc3Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458ds9jnx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 14:28:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52ADb88c021423;
	Mon, 10 Mar 2025 14:28:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458cbe61hs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 14:28:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhcQ3PIdJCd2lxzr31Llt+iVpPmhCq0RYvFw+ryTFcnwAuDepT/sRHUPlSZ5NcfT8qBLTq2zxAKSW4934tvV4gKdXijLt09wKF1dfCQKo4EXcfRLbowQyhNxzKyvbnfmfZRdNdtaBICufnUQ/+DPrBgFn9sly9obAYgU3aqqqdfWnJTcgA27/tcvmxEde9W+vHK3cQjbmxWLuKLLupOQjvt953rUYx3p+gTqG6fSt3mqYYoOlMr3JA1V4ohbfctGEU3r+rOZlYYg5ZNQHEOTgJFSVJCvMreEiDvxHFnzDdTm014zxYRDmRu/J00zbZ4VHXPVH7QiFQQrb3oycidPpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QF8MEYdRdJ6UTOZsnvdcAiLrJyuHLKmeUhD2uUyFajg=;
 b=hZvVO5+Q9d5jIckxYkYSJSjE5DrfLWYrNMVCRvhuAca5L9BPXM9cp9mlpJUutWE3t6eksPqT7CxowJr1JNuvUN+GomXKCMtav5drDo0bSJNrGBbFlVVAfqrj7AjxeTnF42W6rqwpkdpJ1WOHroQIpAnVizfw42RM3jC0HUzmvy0VHBJZqHD9C30xKBK4aEiVdhSvIyE7WH6d7gbzan0FN4S5s13T1BPBeSSeKlOmvkuY++MfsqLyciNwzffTr9WYnQiK4ACwvWiOY1Q40LXq3pJypJAgqubJtWNgLSZjsRcrQfM3fMvQmp4HdJJiR64wmMbF5EOj8yDtXPJ3f17VFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QF8MEYdRdJ6UTOZsnvdcAiLrJyuHLKmeUhD2uUyFajg=;
 b=CLOWsON20Gda2V/8BX21vECS3w2rS1jcAdNm4ZtQ3s39hZCGNFkLJqOvgjAhPvcP/o+ngg2a5WlcO8b89a+y1qRuIUzZFBb18KPwVX5imBZdS6PFv/S8pxspzHbjaIYSPic1rYNdHEw2zQuewdXbWAFLfMgaGaAzgXM9CiGkITQ=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by IA1PR10MB5946.namprd10.prod.outlook.com (2603:10b6:208:3d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 14:28:49 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 10 Mar 2025
 14:28:49 +0000
Date: Mon, 10 Mar 2025 14:28:47 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Harry Yoo <harry.yoo@oracle.com>,
        Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: Re: [PATCH v2 4/7] mm/mremap: initial refactor of move_vma()
Message-ID: <97116f44-4934-4868-b810-021592e730e1@lucifer.local>
References: <cover.1741256580.git.lorenzo.stoakes@oracle.com>
 <93193b2b45f6e95da6e8c7a2776e2d8c43a346e7.1741256580.git.lorenzo.stoakes@oracle.com>
 <92b633f0-1ac0-4074-ae7e-a8486052377b@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92b633f0-1ac0-4074-ae7e-a8486052377b@suse.cz>
X-ClientProxiedBy: LO4P265CA0008.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::16) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|IA1PR10MB5946:EE_
X-MS-Office365-Filtering-Correlation-Id: 708a35c1-715d-4043-cce6-08dd5fdfdf8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Eiylvfl8BkniAHXLAGmU/LMgKclzVUU9veXj+/J8K6HK28vdhwNj4Cc0it/J?=
 =?us-ascii?Q?zV76dzdmbUxtz0os2EssouMS4lwwIYAIU6rylo5OHeqIOUEo+HXhBlVmB+Bv?=
 =?us-ascii?Q?/RbAlg57wSqzz4KMDBpSn3DgvN/ovphlPZ9P2s6bFLlO2su7beEfnpIsp/vT?=
 =?us-ascii?Q?NaCYxnV6vF4IFIFiaawW49ht9oSoqni8ffDQ/M61zIahxlUt4U6ndZ/SQ6A0?=
 =?us-ascii?Q?enEmy9BxOWkZirpp5ZSpVWowYmD0JlDGgxM7V+hTP3BYr/snhrGn7KWfpoki?=
 =?us-ascii?Q?VVEL4KNUdh2YjosxoZmg4HsgpSVhXH3ZVWDoNlJzWS3dIAK3wIeBokZhTAE1?=
 =?us-ascii?Q?KtfXEQ42Er3bR1z5S0x7goN85k4Hc4t3heHwUCht7v7fK7JbytKHuQxm7xIL?=
 =?us-ascii?Q?29ikRRkZJIddEz1UCLVeQtVfAecv8MVFPg4g4EHxa16SvZ+KhTvHqvhzxQin?=
 =?us-ascii?Q?l+fb20PiZg6pKITOW+om0NNZKMe3rvkIefhIfCbmcQm8tSYVd7iolqtMYv17?=
 =?us-ascii?Q?NEbm8vhHv9spbM6owe84th3LaxvFclfqCcZ/OTxN/wYKv5UbSHrR9Gbpk3lK?=
 =?us-ascii?Q?D0BnxWUe/ihHJFHm4/kXEfC2zeb3rUZ5wPFkTJZlrXUgWuaFPzreztjpVBJH?=
 =?us-ascii?Q?HqInUQK/k/OZHWV2WuHUxQvmj0WFGppRualf9G7+/4c6NA0ILcr6G0irGytc?=
 =?us-ascii?Q?nAt9woNOOmpD2ysjl26G8ssYsdnQ5w1qikNS1BbEBYP+UmqdyAuA/zGyWUCC?=
 =?us-ascii?Q?1ZxzyjC/xB/01RTRbUqffko+UUA4fuQcd55ZGZRjLWvxlMwPcCmZA1frTgtx?=
 =?us-ascii?Q?v2pM3PnieRkEUwUG2eUzze3kz5oM9ik6dVfspi519K+Uc/kOug8DjcTS3t3w?=
 =?us-ascii?Q?ZYTEqFybWOmXx8EoHTV1WWq/Q9oGg7Wrk+Z6GNRvZPSidRr52RktqiqSSEBD?=
 =?us-ascii?Q?lP9YctHCyQi0Rko+L3OoglRRFRvRFEmy6m5IeHjixO+WWyyfDJrrSVlh96v8?=
 =?us-ascii?Q?B16685fvtIY7p8me/7jBgxrsMWDAMjrJhuIyHC4PDvUcWbG10YOFwwad4FJG?=
 =?us-ascii?Q?p/D8yl85W2vGoWJBXwbkrEY0zxOyxD20DJ0VoyPkp4LztTefvrpOWVv1u1rP?=
 =?us-ascii?Q?5x4kocMPke7kgSnJg/AjnDEnmSZcdLZVtvFJrbGAtTbbvONxbhFTSf+U0lyu?=
 =?us-ascii?Q?7LHHcK7f0NTiwhMBB6AmX1yWnNj20udzUc4z9wkguBUOFLqvSbv/pLCswjpe?=
 =?us-ascii?Q?RzNVwCK64h19KlwNVvMt7+KOtm+BJ1rKhL/15C1fdNk/eNXExstDwZYXeNZN?=
 =?us-ascii?Q?JpRrp4+kxakV8JQnETZ9h7kyzIu+lJwJBc0doudHk/HWM0YF0hnsXg94naLE?=
 =?us-ascii?Q?wz6nZ/s1D5uAg5mJIyYiLyYdmmFn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uPleP1vbzxxrvRtmOzUIggrefaQ0pzfM9cscpnwqd4xCwRnhpVaLpuD+tRzK?=
 =?us-ascii?Q?ekE78ZeAIVrETJVY6MPXnlsVhBRPKnleyurWp08Ymhc3lok7AJMXi+u0Mfp1?=
 =?us-ascii?Q?BKKKTq+VOfT3d3YW+yJq88VpDgQDjnEcgRxtMOeZHQFEmBo5I7QKbD3itxME?=
 =?us-ascii?Q?auomirqd6sGxkkAvDmVOW8SSvOUCv04Vpj75fH1l0wrukhaevmii96fQmrkp?=
 =?us-ascii?Q?ZmjYNmoog2TByossIDqpKUKua4llnhLIvgfb7g4+UWxmsAxm5i752acBqd6Z?=
 =?us-ascii?Q?6VLlKow/bNcQMJeulKt6wVM2KELWGalnXSoAAsG4Ctrje6Ab/7mfondnNkG8?=
 =?us-ascii?Q?iVgIMjTffJWMFUhp02zPlLcOVJSSVeAth2pp5tmbMuwUCwUv89iuxMqXhGj6?=
 =?us-ascii?Q?onxR7kNCCvDQ/Mwg+bvpCNyTHjcfjtaNzbcAfoNJFtGR1mUsSky9hV+VkVn3?=
 =?us-ascii?Q?ROjGm722U8cXVuZK4bha5dA9FGdH3g/nfoTauhftXFH9J9JPCYsn9hxrLoMC?=
 =?us-ascii?Q?cwD1yeEH/RnJQDxBgcZlunv1+tTqQIpg66GGEWkLeGS+a4cLcPauVO3+x7Iu?=
 =?us-ascii?Q?hjTl5UqQ7971e/pjoaqDRQEFBr1+zMlR7rjqPUrNntbH81zjp8vaIva8Dr8k?=
 =?us-ascii?Q?kDtbyNlLW+8dgoG1+TaDFuBxU9OA1ayphe/rE42gcDfMddOnIHwVtYBHs4yB?=
 =?us-ascii?Q?W/WtbHU+cYS3XBpAn/E3tQ2U+mTQojHEdddKbLHoltqFizZm2H0ww76TsemN?=
 =?us-ascii?Q?yJg4HIg0Wb7Gt/GNp4cuPMmt0PgGTDG9g+i318LUeZCCGzcIf8HcMI/gm3g/?=
 =?us-ascii?Q?aV7tK9e5wCPmZ7QdwnLbkzmTlAg4dNGw3Tj5CVU0YOjjgRfFy4BDIJ0jkZyc?=
 =?us-ascii?Q?NI84FE682ITuSRRWFlh4fFsDpZJg3AZc6UZl5PjAPAtkEBq19hedvXJLK4qu?=
 =?us-ascii?Q?XP3Ws55TZLYxkUvaPZCqSCuURsV4g5Yqw0lS3JpZzeSE+HOWr5xIQ09HiBfq?=
 =?us-ascii?Q?X5hR4KlYtebenW+s+ru43VgRLPsxLZUErNX9GPQANiRzFjvvT/VG/SQa8T3B?=
 =?us-ascii?Q?3yJOGhh2s4E8yfyun3CnQ8e84mXxAnJawUU4/vh/N2hPIkE7CTGrMzR40z8J?=
 =?us-ascii?Q?IR4z18ZDl4UbbwUsEXt/BBvCX+qTtT3LqBADy+MM5TXwwPEXCR8sC29rm07u?=
 =?us-ascii?Q?eblKgRJKUX0IZLpe4L6Vg2gPimtYzfHxiFkTSrVI4ZwN6YYT14MpRAhzubs3?=
 =?us-ascii?Q?24aYp5syCihr01qQkKGxCDZfVuiyxkAjglh81YcEaLm3K/zqfWdDPKLdpWRx?=
 =?us-ascii?Q?aLsP8J8G9TwtRQXtV2ceVrM9MblSbXgEcxu4BY9C4r28t/XRWPfsJLjl/zQ5?=
 =?us-ascii?Q?u7qCzr+3KUm7GCW/siyaoO1K+zaD5kWKTFoHqqVPThKo6e8kC+Fpq7eUMyF6?=
 =?us-ascii?Q?dl56pF0cRfPXmD7wgL/UkDH68PqKF3iIvmyhvSocNplGUB7iZ63+VHHTubEC?=
 =?us-ascii?Q?+EgX28EL/eH3rtDsDNqh6MjngbQLI4MtTLAshk8U3VYY495yKLJj2sBhXIan?=
 =?us-ascii?Q?LdtB3QFF6+e9Z6tNkERGrlYQN8sfTP4VIUuOWChOBLinKqw4eFBjmVi+6rJb?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cqkBL0S/riy9ZnSvs3wRsIve7HcI5VVdUxlNyfLuLArUoS+L/maFY8GFQjK2tu6agWbuMJw9H4fQ2ctr7T9QuoyuepIhjpAIhQ7zKwE/hMyjxrQootdrlkgFrOZOJoxXNXOG8PRkQWFXb2s4GbYJk+SBOZJu4Vpoc3MzgkFuTE+ZXvA9ryCK5E8TkLUN18GT5Z+CoBC10Csyi+sBHm6Ks1gR1n4CgTH+VxqLSeuf35fGpTcfh8IgwkuHFHy6lDbaEjObMKH8n0GLFNQ0XFSaRi8CV/WXojMECB+Vh3g5BaEf8Yg4343KPZlgF2ZpaeXO5u9wYS6U5mtBo2Tk+Ln7T4TLPgnPSGV1pciJBy6ONSGFYyhgrY5IawCoV3D0BS497gNh1aYuVVVdjnhDJggjEYTjCGXeCpE2uMcSALZ8a3VsypaHopm0JqHsgmCbv8z0JjvAG/afIuN589V3u+NMLf8IpvSyqbOdeoqgc3XYCgjJKqB7M732l7kFI0kxBdMcWPG1wIYUg0Dwrryji3762SPKv5yvaK4pGuthUG6zNw/ofxOYMOrbB8NPbmbU/Bg0R2jwky7moMIbhXZh0q8oRDoFeDLjOVB1uuECOOFMbfI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 708a35c1-715d-4043-cce6-08dd5fdfdf8e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 14:28:49.1147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5RdeOZdz2C7Ztg+bsArtBPlKWt+YmQGr3llWJgYhMbHwNFRDV7Or+qZuT0wgyGFYJIr8yFsCg/7wUQnmzorvU7OwwvVBffyjU+EATh8Jng4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5946
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_05,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100114
X-Proofpoint-GUID: ksCsGrSAq-oIWFhpMqTqXvybk58k3oqz
X-Proofpoint-ORIG-GUID: ksCsGrSAq-oIWFhpMqTqXvybk58k3oqz

On Mon, Mar 10, 2025 at 03:11:01PM +0100, Vlastimil Babka wrote:
> On 3/6/25 11:34, Lorenzo Stoakes wrote:
> > Update move_vma() to use the threaded VRM object, de-duplicate code and
> > separate into smaller functions to aid readability and debug-ability.
> >
> > This in turn allows further simplification of expand_vma() as we can
> > simply thread VRM through the function.
> >
> > We also take the opportunity to abstract the account charging page count
> > into the VRM in order that we can correctly thread this through the
> > operation.
> >
> > We additionally do the same for tracking mm statistics - exec_vm,
> > stack_vm, data_vm, and locked_vm.
> >
> > As part of this change, we slightly modify when locked pages statistics
> > are counted for in mm_struct statistics.  However this should cause no
> > issues, as there is no chance of underflow, nor will any rlimit failures
> > occur as a result.
> >
> > This is an intermediate step before a further refactoring of move_vma() in
> > order to aid review.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>
> Can't wait what the bots report what I've missed in this one.
>

Thanks :)

To be fair the other one was an extremely weird edge case where a user
'remaps' a region of a VMA of length 0 onto itself expanding the length 0
mapping to the length of the VMA, i.e. a weird way of doing an unmap.

With that caught, and heavy testing of _real world_ usage of this series
done locally, I think we _should_ be ok... obviously bots have been
hammering with no issues other than aforementioned crazy case.

