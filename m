Return-Path: <linux-kernel+bounces-309215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E18896679C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7882FB26FB2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E311B1D53;
	Fri, 30 Aug 2024 17:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GZZI285E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jDlYiGij"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58201B86E6
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725037659; cv=fail; b=bA2B7PCspwG88z+fPlj2Lc9M93zHgvEnXmXjAdnAwDPsDH7ObRENLAUO9kh1j9lh+zdid41wCk1pLyFpqqPmr9cspn3Bp0Wr2lq5/iOZTGjknH64Th2yJ1p0Mv+yyCCZT2XYNwl5IdRFBfeYY45g/lkrr5QMS3t7Na2CuQVQX6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725037659; c=relaxed/simple;
	bh=li9wb3J3xJ9bGHlP36voHszhQDnF3Sm/wA6CS9fX8as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hs0RYblNu0eDmijFJFuQ6oS34OwrTNDn7KlaeDQFs6KWME2hIpvFoTxs6xnYI1jMGnxtxKHuPNTCPZLEq1ZYs4AkyIFPnKrSRA7v5UcAsa4ckJ9yiw+YzjkvTpk5KGUSK7KXR4jNfrfBP4e8dT2OmhT3GNnzgDFpMhIwzzULr/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GZZI285E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jDlYiGij; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UE0VEf018902;
	Fri, 30 Aug 2024 17:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=0V0IK0OkaNxjCN1BK0wUbQ79MQoHtPWhCiiuTpyA3Rg=; b=
	GZZI285E7HvFTe0fPC88cbaUa1DxSlRxPllVKYoILn+KJcw2RkrnMX8MlFe1rvDn
	50P9A2UK6kxpO00UfPRe4+QusWzZG/I36OjsplcSiLzjdzmFNEA5f56tThQcYDo+
	R7Tp6gi4pycM8xpkkoA3yxI5Bv7MocKKLp34SKgxapk2ZtKyIK1IovfV/iZM43rS
	NuML0mGHNRdNumQFz5jmoE0PyHQDWtQeTpvB1pTbVDOBshd2ymdkCufe+ZTDH7Dr
	HBHm2dfRgt8PBm6pn5n0do7NhuL56xrKDFOEjnaYkIfx5X/4CnyOsX8WNA9Dn+rm
	9H4m1/1oZV8T7wix5JgrOg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pugy8q2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 17:07:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UG3fQI017502;
	Fri, 30 Aug 2024 17:07:11 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 418a5wpuvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 17:07:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqaPftJgR8qsw1l2L+JZswb6s+nu6XxrhlCMa4EMXykhlUiei12KTnNi5D2JYKAf/b8V/UfMczjIjRj5k7bNibFuE6FiH1BxK0APsRHgY361PWs4AwknjFiDB1nlRJ3X5+fqZJEyc1oouCSWSec5Oncw9b6CYJxuNeoJ0bv9+axXbp/AxHTQ7yt08EdCzBDXix9QARHf1dI+JA6x6PVr5PBwZKk8L6aS9TMFtcATJwX1ZzGJwgh7G7+SMNvkW9A7uGhh5H6KXI2rwPKImISMa9sF3iPycLsQiXvb9i4H8sN1PIJOheb1nNgNTTkk4mnQIkLJlyNgzoeGIhrZECLMQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0V0IK0OkaNxjCN1BK0wUbQ79MQoHtPWhCiiuTpyA3Rg=;
 b=b2g0vcX47mgI5p+CjI7gB+3fIRSKitrjjsbYtmw7URIelgb8+swfK5DuzCdBGb8FoDptgBMqtFTlYEqwGN2miR9u9DcGujLvggTbP5vFwWjw3v3Ftv4gDDlB+pFrXQ6Xdxxlut5DIsrO87+A37n3neSOi14gTMZeXIAVLsDtGwyMK6zblWW4MCWRVbhaUYUBbNNxeQKDDq+DP7qK15yzfoaNZwocUBMTcuavEhW39128xjlWfSL1gzkGvR0vbhRzn+zzUHQdqtNvyQ3n8sqqAXO6sQdcCnFyzvEnuHjYkCjvYT/2LoirQZE9Kf/fQGY6+gAw2/FL6EvsI8rC6gLPUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0V0IK0OkaNxjCN1BK0wUbQ79MQoHtPWhCiiuTpyA3Rg=;
 b=jDlYiGijn3zJ1DhLT8c3b2ARoY/UWRF4tzu3vTnUnvi0KpkVISR1cg4VkC+8AvMtF9VrrCKkQlKocdeAxIa0aFDbuw0ZpYA94ZuLagAmGEd4V1bkWqxEJDXvZYaSuSQnQNqiJUOVgbnRfGKfgWHML6m7DphCY5XeTtomzIY2EjE=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA0PR10MB7545.namprd10.prod.outlook.com (2603:10b6:208:491::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Fri, 30 Aug
 2024 17:07:06 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 17:07:06 +0000
Date: Fri, 30 Aug 2024 13:07:04 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v8 00/21] Avoid MAP_FIXED gap exposure
Message-ID: <n6uoflmh6t75ziavv62mp5ixkbfucwltsdss2p47lvjdoj6ogx@6xi5a5wnodro>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jeff Xu <jeffxu@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
 <CABi2SkVjphqbh5M_ybWRbDYWG08C9eL3x5fmy01AQfp+svM0Tg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABi2SkVjphqbh5M_ybWRbDYWG08C9eL3x5fmy01AQfp+svM0Tg@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0267.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::22) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA0PR10MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f5a7228-7c94-41a0-e584-08dcc9162d2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDR6d1lHbERyT2ZXNU5TbnhKYlhlOGZmRCs5K2lqTW13OTRzK2s4QVFiUDMx?=
 =?utf-8?B?djFMNTRuVEdyRmUyNEpiemNnRzc0ZEJPQ3N4QUdrOUdZOFdpYnNaU3NIQk5l?=
 =?utf-8?B?bTlFL0dLWE9aUXI3bnNnRVp3K2g2c1BidGZPY0plQ0NlWWROWEJLODBVcGpJ?=
 =?utf-8?B?b3h4MkpUWmtFMFdPTFQzWDlqdkVSTm8zMzZwSWwrQmMwcnV1d1F0NzVMSE0z?=
 =?utf-8?B?M3BHNGxoSDdSRExmL3AxQjRYemtJYjdKbzU4b0x4MXNaTFlORVlJMG0vYVR2?=
 =?utf-8?B?dXpqS3hIQklMekpyZDhTRTZzWUxyTVcvOVRYbnBjMml1S2NDcjVvcHR0Mnpy?=
 =?utf-8?B?akRRZml0S3pLdjh5TjM3cnhvZk5JaWkxbjJJOTA1K1l3QXlqeHg0aTI3SjJm?=
 =?utf-8?B?V0FvdXlzNlZkYlM5ZkZldjVqMlhrVVo0WC9CVHJhaVFyNzBlOEFRQ3ZmSlhI?=
 =?utf-8?B?WWdkd1pMaWtPR1ZxT0w2WnlYdGhQa2ltYk5obUZSSWpuYmRvVjVaclNZRkpB?=
 =?utf-8?B?RGNzOWwxNjdnTk9LRUtJNzNQK0RSc0Rld2o0emx5cm5wT3VmYTlPVFFrMkFC?=
 =?utf-8?B?TDFsZUZSOTRvYUhYcXd6RjhLSm1lMFYzem82QW9SVHdvcFNsZjh4QU1jTFlS?=
 =?utf-8?B?b1BLU2FoaWdWTlVnUXZwZDF5N2dqS2dnWGVjWVlmL216dHMvZnJicUoxblh2?=
 =?utf-8?B?Tmt2USt5a1B5aWtHNmVlSGpuemU3dnNmQWRqWGd2WUcvRWI2UUdpNUpmQUhZ?=
 =?utf-8?B?NEV0aHVVeGg4UU52bnRiL2VWWHBYWlpodHlVd0tnNUxnZlExYWNLd3A4WU1Q?=
 =?utf-8?B?SWZyYTdLc2pIYldKTHI3aldsckdBL0pwSW1iMktyVGRjMTcxNFNOckhKMk02?=
 =?utf-8?B?bnl3cnRVZDFVeVNJWVNkZnpsK2lnUEVBS25YTysyY01QUXFVZEZDblkrZ3Ny?=
 =?utf-8?B?VWRXSWVZYWFiaVFiMTRhZHZwSjRQSE9RRnBqK0dtVWtUblBRWDZNY05OZ3Q1?=
 =?utf-8?B?V3NGSXEyOHFOclpYZHhlUHZWaEpEdjVjNFJZNkZ3b1VzeFlGejFqblZtSkQy?=
 =?utf-8?B?V0FTTWh1TEhkdkNMYkpxV2crdlJySTdOTSthQWhWUE5YbE4rSnN3Ty9tQlRn?=
 =?utf-8?B?NFcwdUFVZUVKcjNYZ2R5eXo3dEpqT09wcXhPZGVFdWNORWg3aXJuTUdMZWZH?=
 =?utf-8?B?aHIrNStubXVEdGxYSWtqTDlqMmRRSzAzbUlIdk9sb1dUUmsrU1F0dmJWZ1lj?=
 =?utf-8?B?UStpTXA5U0ZkTHhaeEkvQkQ3SE5ESWtUVFZvdHYwQVFjZS80RmVkMnI3VUhG?=
 =?utf-8?B?OU5xS0xFSU5XS3Y0bklqMW9FbHFFM3NHOU9LOFFPdEZwRnBkWFk4bnJxNE1V?=
 =?utf-8?B?a2lhNXpuYmcyTCtaVHBUMlRiT0NsNHI3bUMrTy9jQzVqcDhiZ1NFU1NKSDNx?=
 =?utf-8?B?Qno3Vmx1eFh6TzduT2lyeUN0MDRNOGNnMTBjcFZvU21nNCtzRXJQbDcrNWdZ?=
 =?utf-8?B?M2l1eUE4WGZJVVZzZzBRK2dUQWo5SUM0N09uR1RNdW0ydTJyL2JMR2NUdUpp?=
 =?utf-8?B?VTJrenU5ZGxDWVNDcUVuV3l0L25uc3VFQmJ2WnprVGpYUXdrdzFMS3JBZDlm?=
 =?utf-8?B?ZHEwRmdxOHd3czBVSGIxdW1XVHRtK1ZTMXV3YnczVE1OSGpIa1U1aDdEcDU2?=
 =?utf-8?B?YURzdUFMbER1NnFiQStrUkgwVG5wWk1oV2NQUDN5bnpDVU1Pdkk1NzhJa1Ns?=
 =?utf-8?B?NTF4RWlQSnU4bHZkYlNWcyttVlhiekprQ3hzbTlienJxMXFzUXI5UTZkOGlt?=
 =?utf-8?B?NDIrYitWQ0d3eFBad2tLQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVhjZ1lrM0dvQnNUWTBZbjBWM1orK1RhUXpYN1JJQ202cVM5OWJxWFpiTVNl?=
 =?utf-8?B?QzJUYTltMTZVMjdZSThHTFJ3Q252QjFEc2o0eC9xMlo5c3kxR1I4dW54K2R4?=
 =?utf-8?B?WW1oU2JwVmQ0S21DZy9PL2plZnZHUnZTS0dHVkNOWlhEZDRtTTJONnpGMkJU?=
 =?utf-8?B?VWlsa0hhTWhDRnBOUDkwNmxBc3dJNTMzSjM1U08xQTdWOGRaVEdxMzUrOVRL?=
 =?utf-8?B?Z0pKRUxJcnE0dDJPMHlNQ0NGQ2V1UVA4emNuVFBjYStCaDN3ZmdNQ05VdUlv?=
 =?utf-8?B?L3hKejlpSG1kOVlpOTUvWm1VMjU2eUw2VjBWWDFTeEJHejFCY01yVTBMdWpX?=
 =?utf-8?B?S202dHRMbjNjTkxob3UyZnIwVkRNVytmT2V0dXNkYkpTSGJpMmxSWkN4U2F3?=
 =?utf-8?B?dVVHN2VCRlJ3MXp2SnRqenBXcTV0VENiNjF1YjhqZENobXE5Zi9CamNrejRS?=
 =?utf-8?B?WDBZS29UNVl5RzM2dmg1aHNDNDF1RXpDZHovN0xoRDF0Q3pBY0JCcU5KQlcr?=
 =?utf-8?B?YlM0UVFHbXlYNUFyNXNHd0xuVWJoUitXTUdOejcyTlRjN2ZWRmxhVzRQNzEy?=
 =?utf-8?B?ZHBvYWdqVFEzczJuRzAwdlhlVS9Pbk1LOTFxOXhvdGZFeS9kL1h1T1BvSUhm?=
 =?utf-8?B?Uk91SC9Sb0tERFNuakNQaDVYV1g1SFFBS3l1NDVVTVZuQXUyY2JwMTBwVDJJ?=
 =?utf-8?B?ZG5MYUFiRThGYVZQN3N1cnNQdklld0Y3RU5lL2p6QW5UWnFhOWpaeWR2Smxt?=
 =?utf-8?B?Y3BuME1wdkFIazg1cGptUU8wc3NKSjN3aEluV3lEOUw1bnU2WFEySmE2SWln?=
 =?utf-8?B?RVY4R1hsbWFleTFLZUVwY1ZxWkFJajN2dFlqUzVTNE8rQ2g0L01WdG1QTDRV?=
 =?utf-8?B?MDZhTno5bEJBQ3J5VTYrRGMvcGZMV3Y5bUlZMXJCQno3OVdSSytyRnBwQzhS?=
 =?utf-8?B?Mm5VcXdpKzh1UE94OEQ1UmVHWWpjU05UTTRHVzNNTDVoSEN5emRJV1J0Y3hU?=
 =?utf-8?B?aFMvdXFXc0VLRzBjRUxjSkVoUkQxVWFEeks1cVdWQy8waFdOQkI1MnIyYlRJ?=
 =?utf-8?B?NTBxL1Z6a2lCTTFSTnZJeHN1TmRja00ya0FhbWNnblBMQXBrMVFEMGY4L2lV?=
 =?utf-8?B?R2pYWjA5VHI2c241N0ZpekNLU3NWekR3a21Rb2U3clVOYzV5MTBKN0dHS3Qw?=
 =?utf-8?B?bjF0TUtMZTVrTGR5Ky8vVnE2K0tXRTBOR08vdFE2V3plYVp6OTJJelNBa1dU?=
 =?utf-8?B?MWpxZFpYQnVqay9wSTVvT2tsLzVUN0FpUjZvYjdQSjIyMmtmMVlrZXhSd1JO?=
 =?utf-8?B?cmZLTkxUL2dSd1E1elhLd0lndVFuM2FPWi9hamdTVUU3RWhVUFZ1OE5jalF5?=
 =?utf-8?B?djZDaUdlSmdFdmZrMHBPMjJSODlpdGl6SUhRdVJvYlZJSG40N05BUEpzSGdj?=
 =?utf-8?B?b1RzVlpseVVXdzR4a0M4bEhLemhTdC9VcUZTNC9tSW1VcTlOMGVXTEx4UHJl?=
 =?utf-8?B?My8wcyszOVZCeEtJQlhBZXN1eWk0eDhSUW1iTStUbUtlUmdPVnFoRUoyRnFE?=
 =?utf-8?B?SHNTREFpWmpmSVV6emhwdlB4YWpmY3krT3VQcUtmTFREWno4a2FncTd6K2h2?=
 =?utf-8?B?cXZRNkVGZjI2SUE2TVJUVms1anBZeTV0NFEvSFZiNWs2MXlSTGpjendieGZH?=
 =?utf-8?B?UUZZUXZ5TTNZUElDT3NWM200VVJCU0hmemF6YjRKYU1VQ3ZBNnhYOXc1dHh4?=
 =?utf-8?B?TlRVL3o0ZTFnVDZLa3g0aVJLRWdSaVVnT1QvTlE3dXo2ZkRQbjVrMExtdDJa?=
 =?utf-8?B?d015SXRqQnlSM1VVZ051SnliQnpkY1ZKWHNBdlFmVnNVVUtHRE9HTWZzcU01?=
 =?utf-8?B?UGIwajk5aVljV1RZZ0ZsOEVhd0ZtcVhjWERtbFlWWUZXNzN1MXJpeC9Dd3Ju?=
 =?utf-8?B?Wnl3aDcyakhRMmtQeHVkR2xDN0ZrRlQxNXQ4aFZEdGllN1MwSUZNZjdVdWRs?=
 =?utf-8?B?N3ZmM24vNisrT3o3ajlzd2x1WEZUT0pENGlFdWp4S3lSSTNLRDJ4UllOYWZw?=
 =?utf-8?B?U1RVc1FySEFKSkVCclJKbEhIeDhMSHFMak5odkxMTlNpcW5FS25zNTYweWsx?=
 =?utf-8?B?V240SEw3b2VLdUZHSXhjblNlVFBNSW5ST1IxT3llTnAyMEJNbUg0MEtSVW84?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	spp/yRZKwBAv+jyPWeiqKOqyZD+g+cGkXj4anEmbv7iekLR4E1BBLDb3zZCHqbFPR/aPaEkoty1WOYP6A4R7pFQw5JG0rHRT+rGAUR8/hkkFLgMhEuTT1zeP9/9wY6vZy2ykLJBPn06cSZEAp7CdQfDAVYDN6OpPzzvKeRI4vVGZTScmA74Bp3gO4Cdkc/7PhKTUjVRJPwHl5Rrd62A2cabfzEMNSPCC9OWMcHflSNEWHZbijV8nbeDgOj1ur118cNaWNXs4BnQIYadbmjYkkHuC/wR9/zRcKO1FBxwGXtBhvHAFqXm15IaU7+acs7R+okzwNEitlV+fd53dbUbVF82ND8UbbCeghN29HCw5LUSHNtF+2spmWndIJbdWL+abFm+JDoDHwj5RBHgO/+14wQaln6qoXFuMvwnxLLZNa5Kgg/V4CrFRbYSgppOGpYuqZ6kkJJU2X64Ida+YXpw1ddlLGGNwLcXWyO+D3Qqj+L8jphL+nXeYbE1CEsgIFjEM3JEsRKhfM4sDORSAONFk8yDRe3Rss7T22xIwSrNZWjgdqEhYQfQDmVyymy8IcoPEG4IZhOD96VPIXI5E9Mza94I3M5v0l+TFPbx05hvuwiY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5a7228-7c94-41a0-e584-08dcc9162d2e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 17:07:06.5676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LvmJ4rmbAl8EPBqgGWh1v9ZLkOHo4uCj2O8o6MZ7vnm3tj8qO2rUZEPVUHZARkIqRaD/yZnn5j1uQy6yTLzkog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7545
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300131
X-Proofpoint-GUID: _7zgdifexb_2Xx3pt7WVkaFDHeCmrwP8
X-Proofpoint-ORIG-GUID: _7zgdifexb_2Xx3pt7WVkaFDHeCmrwP8

* Jeff Xu <jeffxu@chromium.org> [240830 12:06]:
> Hi Liam
>=20
> On Thu, Aug 29, 2024 at 9:01=E2=80=AFPM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > Changes since v7:
> >
> > This is all the patches I've sent for v7 fixups plus the return code fo=
r
> > mseal().  The incorrect return code was introduced in an earlier patch
> > and then modified (still incorrectly) later, so this version will
> > hopefully bisect cleanly.
> >
> > - Fixed return type of vms_gather_munmap_vmas() to -ENOMEM or -EPERM
> > - Passed through error returned from vms_gather_munmap_vmas() in
> >   mmap_region() - Thanks Jeff
>=20
> I would think it is cleaner to fix the original commit directly
> instead of as part of a large patch series, no ?  If not possible,
> maybe mm-unstable should apply my fix first then you can refactor
> based on that ?

No, it is not.  These patches are not up stream, so the fixes line will
be stale before it is even available.  No one is affected except the
mm-unstable branch and linux-next.  Patches to commits that are not
upstream can change, and almost always do with fixes like this.

What I have done here is to fix the series so that each patch will keep
passing the mseal() tests.  That way, if there is an issue with mseal(),
it can be git bisected to find the problem without finding a fixed
problem.

If your fix was put into mm-unstable, all linux-next branches would have
an intermittent bug present on bisection, and waiting to respin the
patches means they miss out on testing time.

This is why we squash fixes into patches during development, or ask akpm
to do so by replying to the broken patch.  Andrew prefers not resending
large patch sets because something may be missed, so for smaller changes
they are sent with a request to squash them on his side.

In this case, there would have been 3 or 4 patches that needed to be
updated (two changed, two with merge issues I believe), so I sent a v8
because the alternative would have been confusing.

Thanks,
Liam

