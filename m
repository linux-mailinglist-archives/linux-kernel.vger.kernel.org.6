Return-Path: <linux-kernel+bounces-437989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F3F9E9B53
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 782FC281237
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153A8139D05;
	Mon,  9 Dec 2024 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RGOp0Wb6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iIwwcdY6"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D67233139
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733760804; cv=fail; b=KrGno1kbpl0+Rj28DmRMQo5Q1y8z6aQKWT9hJBr807a9TAYxbcNto0Lv8kdDG4IUwHxadQCHaD/vhm4c8YGbLU7buTp9tTe7IktSzJXF4VEE7Px3I/lpvbJPROkiySXob1uHDQxzoXGLVdoybdwmKrxNa5Wxk6nMdPViqBS+ffo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733760804; c=relaxed/simple;
	bh=2/5CvUnbaFa3y9Ug86tbW26Z+F4hG26A6J1s/YwRHDU=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D+hE6B95UC5vIiGmYdIcfejB6WMPjfIPGhc23X/k5wKI1zfEC2lwfowD9okQTu299IBpbugwgkQFkjG++dRoIeJfgIMKns46Lfin1ucK3XyDBMN9qomH26weHQdnYZNJ1lMbFUKoSXc9nBrWg5y4JOiG2jKOLsmulDhCTFm0B+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RGOp0Wb6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iIwwcdY6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9FfnWu011325;
	Mon, 9 Dec 2024 16:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:subject:to; s=corp-2023-11-20; bh=jACv+
	yTih6w45cYDXAVbisGciJgKbp5Dp0iA5+9Gqmw=; b=RGOp0Wb6Za1jxD4VkK/rz
	VrB8MiQadRjUc+JP0qgEiIKac4J16sp+uAYNlR2/cr9vDcWn3ZwMagrwKRc0rEUT
	NeNRvNPUgMwZTGzdRtVkBMcYybwNRBD+cW4G5MXf0nX1L4ef1mo0UtC3/aRG5gw+
	ci69bjxTmsSRN+HLEhp/Uh2ODe47qX/q7FT/Qy2Al6N3T0gmvoC0yY2BrjWvHwMy
	uZS8RGMr4OmoEBsLQv3qxfzCH/fYhNZRq3cG95jclU+S9QxfUN2YsEaajfjQrYkp
	C2cQnUvMgKM7fa8v7AU78gpT2F1gJPzIdSs2BJalQ1+MmrhbvMiyu27Twc/g7scZ
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ccy03np8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 16:12:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9FYC7N036434;
	Mon, 9 Dec 2024 16:12:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct7fns6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 16:12:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHhopI3fq5j01wv9ryJ+OKKxiR+LWLSQm4ah6P8hj0Z79W+4tpJAocX7VtzhMeamikWGY97tgOxca+E2DIs6wBV7JZP+4I+2OtmL3FMcB6XZZIhc0G5FXypYq/5LT7GMRYZGGPFYebvj7PY4zUbB0DcuUByniRu07ZLNqzTVRdHfIGm71+A+BgXDCXtLDZItAX2s3JMogqmzVwXZnmg8U+NrreoDG6v78NZ3TUYyxm6y0CVjV6tKUw9a+cjkiDXXaRQSOvjFYaQzOz7OHST32lDYBfLOUwF+j/kL6mBfDamfoJcZ5/TxEO/uyOldODSjObiJRM6Z2BkIy+hjAhVsAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jACv+yTih6w45cYDXAVbisGciJgKbp5Dp0iA5+9Gqmw=;
 b=SeRTd75iBP+Z1AchBQrnZu46GchEjfAC1hU4WisUdzF7eqvecw3OxNFUOrphGzuZ9GgFi2qYgPfBQ1fubWgXtQHrlzJf9f6QaNpDRXv5ZKsko3v+Y11FLE3L80VFZ930KbxbHzCmRyl1eJjKFwVfenm4ZceUIEeiD2HLTirLe08gbUuuYVd34qjyKyMV4LOyo6oVMf5QpNGp64nQX6FMuU9OjuDNm+y1hFKFlzH/OwYqrWD57hkJDRoDJhwNNp+z0E3WNVeRyqyGTe98nucnqMcxGfLqO9MaJ2HPC1TAHnCsjEDJezGNRJJDDQgT1RdMdvTEd7Fih6NUpnlLr1Pcyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jACv+yTih6w45cYDXAVbisGciJgKbp5Dp0iA5+9Gqmw=;
 b=iIwwcdY6TGIjiH6W+cNXTByQ74EXCb9mxqixTSpCkPgY+FE2NnGo7vzqKeM339gH/CNOcgQE+Th78RRj2NX9KYzlFCzY5ujeBZul1zjt9a3ZwKeb9aaYCvyN8N0MVWHR0Rh0c4D8J+jXOeWrj0z8i2Xmk2vx1fC6aPuAl/AjTtg=
Received: from MW5PR10MB5764.namprd10.prod.outlook.com (2603:10b6:303:190::15)
 by CH3PR10MB6689.namprd10.prod.outlook.com (2603:10b6:610:153::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 16:12:55 +0000
Received: from MW5PR10MB5764.namprd10.prod.outlook.com
 ([fe80::8d9b:9200:a7f5:19a9]) by MW5PR10MB5764.namprd10.prod.outlook.com
 ([fe80::8d9b:9200:a7f5:19a9%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 16:12:55 +0000
Date: Mon, 9 Dec 2024 11:12:52 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, mhiramat@kernel.org,
        oleg@redhat.com, peterz@infradead.org
Cc: Jann Horn <jannh@google.com>,
        syzbot <syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] general protection fault in
 find_mergeable_anon_vma
Message-ID: <emgf7rbacg4jqsnyg2mgmlbbeehc34o33fpnkmlaghb3xynzjx@gmldlwjliwiv>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org, 
	Jann Horn <jannh@google.com>, syzbot <syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4d05caee-d900-42e5-84e1-448cc62435b2@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0255.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::8) To MW5PR10MB5764.namprd10.prod.outlook.com
 (2603:10b6:303:190::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5764:EE_|CH3PR10MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ea3bd43-46a2-497a-70c8-08dd186c56f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|27256017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N29FcFlxRTBuc3RLNVhpUG5ncXo0TnlNaEdxVWx1STFxY2NGMEhFMkd6cmtN?=
 =?utf-8?B?c3JFa1hTSk05bXpRMEtxZXNnb2Y5c1pZTlNOUVc0cEdZZy9lSlg3bWtyTi9V?=
 =?utf-8?B?SUhLcTV3UkxocXRmRFFjUml6TXZqUnFFbjl6S3ZvQmg0cXBGSVdLbUQ2QXFQ?=
 =?utf-8?B?c1FGNUQzL3FvWHdyZC9sVU0yZG4xTzF1bmY0dkRoVTVTU3Nmc1BFOHIxcm1h?=
 =?utf-8?B?R2NBMlJqeFlHdUxBWS9Od1hqMSt2WlhJK05nWVNQdFdyY251NnJFT2tHanRV?=
 =?utf-8?B?Y0FBUStNSGlZazNUSDROb0hZTFlocFpNbnpQTkJRSDdvYVBZdmVyVDZWLzZk?=
 =?utf-8?B?elYwRmp1QWQrdmhyT0IxYU81SHhzYisrVU9kNzZNNGhXMlNrVlNGalo5L0tY?=
 =?utf-8?B?VWoyWEhGa2dCTHhXMzA0NEt1Y2hRQndENGpZNkljeERDUGRzWDBVWlpvWm92?=
 =?utf-8?B?UWFtTGJwejg4RS9yTVl6NzhKVlRkU24ycU5PdUljZkJyMEFOOHBtYkJ2SHRG?=
 =?utf-8?B?cUtWcXd4b0tpeUh5SjBWZHlvVG51aWRzQWRaMFM5WVJRRnYxdWJwMTdhcUVX?=
 =?utf-8?B?UEMvUUtpUkxiUnN1aDlhTlZLVnRMQUtoUCs0cVRpUkhvNGtqN2ZoWVhFQlBp?=
 =?utf-8?B?d3hIQXJwNWZlUUVkQUlLR1FESHBFSEFOS1V4My9SUGtJY0tsZTZnOGZuTmti?=
 =?utf-8?B?Unp6RG1oYXl4TFlOMmM4dUY0ZmlsczNURklpeFp1QzRpNUVhZFZ4akg3VjdT?=
 =?utf-8?B?c3d6V0hWRGc5d01EMXpMYU54NFV2ZVN5NmI1U2dRTmYvTUd5dTVUSCtyRndD?=
 =?utf-8?B?M2w4eXRmc2xOSFc5OENGZktGQkx5SnozUWU3UTEvK3BtYm1lMk5XUExCaGJH?=
 =?utf-8?B?SlZ2N3ZLZXBtSUVueTZjdkkyOHMrYmloUmVSeWRkT1UxLzRQcXcxbkx0Z0JU?=
 =?utf-8?B?RHU1Uy9DdCtsaGNsOWN3L0lneE5oWlA1OENlNHhEU3BnNDhIUm5ha3ZkS0JI?=
 =?utf-8?B?dmdJcVFaSVFoNXNETnlwcjJUTEVUOG9iUXFEcHFPZEJOU2kxZlh1aFl5RitR?=
 =?utf-8?B?Z3ZSU2FOR2EwQXlXa0Q0c1FYeVlEZVMveUliMU5iK05UazlVWTl3TzQwbmN1?=
 =?utf-8?B?aHJVUTZxWGowTlVoTnJ2MmNTa3puK0pVaW5iejdoYTJrb2tqSzlRWGsrK21W?=
 =?utf-8?B?b2QzMk0zTTI1bnNOMndzdXBGWjM5dUJBZVRDeGtRQkFQYU9DbnlhMmNFZm41?=
 =?utf-8?B?ZmQzbkJVK0F4QWIwVG10MUl1OU1VVlJ4S2cwZ29LRUt1SHJNQkxzWHpXWlJI?=
 =?utf-8?B?bmZGQ0NtQUlINTR6cUJLdk9kdXVERXdNKzRQWE5nanpocjlXelR3Q2dBTnA3?=
 =?utf-8?B?eGRMM1U4aUxWeWxsVGttbGpvU1M3d2RvajdYV25vcGxNN09Yc0RrdjkyaFlL?=
 =?utf-8?B?YWZ0TElzWExseDE2NHpuS0JRY005bGxQVThINk1aU2lzNytxSnFXMWkyb2RE?=
 =?utf-8?B?MGFrd2tWSk15YkpNdkxPRmFvUFRUSGdoMkdOSUgvQk9Hb0FOTWxMNlpMU2FI?=
 =?utf-8?B?dU1mbEIyT2xnZ2N2MmhpQytnNFk3OHBQUWdmd3F5dFA1Z2VhMEE3ZXRYY0w1?=
 =?utf-8?B?Z2IvSVA4VWdCNDNRS3NwR0lLYkpCMzh5NDJnaXB1WnlvbWVmclQ2Zmx3NmR1?=
 =?utf-8?B?dnBYVVlLR3FteDZNaGpMREdQNG5kNmd3eU9TSXdiYktLb1MxaXQvWFFTU2I4?=
 =?utf-8?B?YUx4bDNtWnJJM3FabWtKQTRzVVlnZnpNVE5KTG9jQTV3OEEzYXN3dkd5d1cr?=
 =?utf-8?Q?n+8AIkODcx77VtVHBr3XaIaaWYbmmP2bCjHK0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5764.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHZzUjhjUHZhamF5OUd0T3BpRW02ZnpxZGdCcWNtaDZ5OUpzYUJ4cEVBZURZ?=
 =?utf-8?B?YUxWUE04UW1wcG1wVUpESWVvVXlnd2N1bnFuRllJOTJtdG1VaWNBUU96Z256?=
 =?utf-8?B?Wi9mc09NZ2tYME9VZXVzZm0rT2hJNnZaemJQT2VzeGlBT2ZHWEluMlhMOU5Z?=
 =?utf-8?B?Vk9YbUh4Tythdm1nNVN3V090TzI3RHN1M1hnUW5UWHBzOTFxWTF1Z1gwYUJz?=
 =?utf-8?B?VXJQSXlWWEFLbmo5NHJXcFh1ZUpmWUNFQTZhMFZyR1lTYy9uOHd2am5CNE5W?=
 =?utf-8?B?OEZQQVZ0Mk5QNlFkOXF1NXg0YmV1TEN4S3dNUWpvcm90bWovRlFuVWkvdlpT?=
 =?utf-8?B?dDNEUjBVd3F4OU5hdm5SZkMrcEZzbjhIb2VoUERNL2JUUTNBY3BveTZPaWEv?=
 =?utf-8?B?aGJYT3RFc3RDcE9DazVFZVRXNGNNeXVvV0NNMkl5c1B1Y0tFblBhM2w5STBz?=
 =?utf-8?B?UXpnQ1FyWjJ4NUs0VmprV2FjMDRBNGpoUkFYalRIYks0NzFHeVZXS296Vyta?=
 =?utf-8?B?ckxTckRIaWhmYmZhbzUvZ29YYjJUcEU3SVpHQm01TDU3SEFSbzRlbkZJMlRt?=
 =?utf-8?B?THF6NkNCdkFLbzVFYXdYMTRzVm01RFk4cFA4d2EwVFJlTHE0aXhhYXlYMHBs?=
 =?utf-8?B?aHFJVkRldmdmMldUTjZ1TW5TdTNlaGdzZDg2L3lCM0JyVmhnb2o1aVdwS0Jj?=
 =?utf-8?B?azIvWTlHYlhJQzNwamJUd1NqTzk0M3Q4a3hYbzVhS3cvUmk1b3hLZmNEMWNL?=
 =?utf-8?B?MUYrODdiZjBmYW5NNGRVZTh2em9YQm1iVUJWRS9UZW5XTEZGaU53aGgxaWF2?=
 =?utf-8?B?QVVOK3lPQTBCODBTZExHbWxicEtxVVFERXdoeTJEcnNYL2MxOEc4V1NtN3NZ?=
 =?utf-8?B?WDg3Z3hMNmRMeG9pWiszSmN0bkpDYTUzTnBOSHhCNlkySk5JYytzUWdQZys4?=
 =?utf-8?B?dW5Yb2tNeFBjbXlWQlJFdCtvMmdjZzNjYWdBdFFXZk1xUGlRYlIvZXhrb2VL?=
 =?utf-8?B?cUFCQWpFb3luZWJYYVZBRGNtWFFtUnlJU0hCVWZibUVVWnhGSWt5WHZieTNS?=
 =?utf-8?B?ajRPM2hhVnhpcUZ1aUZ0cDA5QkxjcFlrMVNtSm1oYiszcFRpQXRuQVpodXV4?=
 =?utf-8?B?Tlg4VGJ2QVZSUFNpdWZiNHNDL1k4N3RIdThWZE8ydDhUbTZObS83WDdjaVBW?=
 =?utf-8?B?L3hCNjFWS1JYMFkrNmttMVRiMkM2bTd5Y1RocG02YnNjeFR5c1daYzJEeTRp?=
 =?utf-8?B?T0cxOVIxdXhXY05KdUFmVGFrQUYzVkJUWG41UUdNNHRMYXhscVZVdjNDRFJ2?=
 =?utf-8?B?NlhoMTlrTDlaT3ZWTFNUTUMrVHEwM2phUXZoU1BES09Xbk1NUFRZMW5lUStx?=
 =?utf-8?B?RVZadGY5T1IvMlhIUUZZQTQ0V211RzBKbFE4TWE2VmhIdGIvQXpGS1R0MDd4?=
 =?utf-8?B?elByZDJhUlFCVWpNeXVhSG82TmhCZXMyZ09talJKYmIvdEpydVJuWkxRK3BY?=
 =?utf-8?B?dFNybnVoYmNBL3ZnU1ByM1Q3VWlhSy94WjFkL1VDVkxJRmsraFhNUE4vUE16?=
 =?utf-8?B?VC96cHRxclFJcTZ3YkNraUt4S2pYTy9BdUUwL3RlbHFpWWRVblF1STE1bmJJ?=
 =?utf-8?B?ajJlUnVpKzZFV0JoUWFkazVaZmNaZ1BPbjdUQWVFbzAzeDRqakFWejhsdWVw?=
 =?utf-8?B?bURPNjFMdFdvOVFCTE1CTTF6a3drOFRqaU5yVklqM1lROUp4T0ZmNWQwSU5h?=
 =?utf-8?B?UGp5aEJDblhUS2FheXhOSXNKdnoyakRnSkJwem4rbjM5enFnbGRITXNKUjFi?=
 =?utf-8?B?ME02TWNCYjhGR0xZbG8yUFVkREd3bXZhdjMxM0xqbUlFV2hmaFlocytIVUt1?=
 =?utf-8?B?QXI1SEdFVlFFNlhtZklBZ1dpVm9GUm5jZFQzUVhNVC9HZFE4RXI4Sk5nUkcv?=
 =?utf-8?B?TWNzdytGRk9zUXZzYjMydW1IWFVmRldXSVJaMXVTOWpFNnRuUTRaTzJyZk1R?=
 =?utf-8?B?eXZJQ3ZTS1hIMDFKMjh3WGxndkF1dzFpMVhrdWx1N0VvT0I0WXRFdi9Rb2t1?=
 =?utf-8?B?MVpzeWw5eGdvb0l1bGtXeW1VV05uQ2piZFlrV1F2ZmNDV1BwZW5nNXJlWXA1?=
 =?utf-8?Q?XMV8ianFAYcpjBonUXdPO/pU8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yG3pb/PBZU+SJnniXk/tIwnGJqwps7lDaH2NON3E1aDcIEKC7UaFFimQsRhy9BlgGX87p3kCbuIrFXBlEZ2Ahc6Z8N/3wvpOimunFLFq9CdWWuRLmzTjF2TZPBHcc32/O3sc7YmJDL8gwLa6+24x8txFp1mVudscK/wTnroxKVc/uXmMtrJaYgyYEAIr/k55VTPgzZB/BhHUMAPntVrB1f0tMce02DYBxK4acN4G1Zx6HYmS6UVLRh4yZ6oY8cBboTf9RRKWjDZPFmvO3k73+d7GITxgqUHUZqTH2PQmN++c5tqAtGeeGPhTkzv5YBLltghS11AOJDPugV6MGUf3UblWfj/lxd3XnTus+jf3S5i/VsKK0wHyrhUxPE39FQzbFw6DKc+nEBbE2aYeahhPrlK94nxCVerKFT8HIOpE1tEyY8psDZd6HYXt4xc7mrP2HoUvthfQDFz41CTsv0djvhTGYp6ec+j2r/Gb6UGMqQUy5LRTtckR2sQYhRpQKVyNpMAKYWVzCO/f3ks9gdmadiH8fJ+AUZzfglUomYuDUO6uOMbwY1s1N1Xy2xLNna+qCS5aIS8Bvxl9ocmJWNrddTB0HCyqLuVzutnwHNqCWJw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea3bd43-46a2-497a-70c8-08dd186c56f0
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5764.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 16:12:55.2097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m74W9xbhNXw3VlN6s28jvF1VFEFlEFKCSgphQ6b2Fp5kct7YlIxv/uXj77gbUoyEIjG/VmH/59DaRvbqXUzV+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6689
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_12,2024-12-09_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412090126
X-Proofpoint-GUID: b3qwrqM89LTEpV74lUwPlOxVykfgXVx7
X-Proofpoint-ORIG-GUID: b3qwrqM89LTEpV74lUwPlOxVykfgXVx7

+Cc maintainers listed of kernel/events/uprobe.c

TL;DR:
dup_mmap() fails, but uprobe thinks it's fine and keeps trying to use an
incomplete mm_struct.

We're looking for a way to signal to uprobe to abort, cleanly.

Looking at kernel/fork.c, dup_mmap():

fail_uprobe_end:       =20
        uprobe_end_dup_mmap();                                             =
                                        =20
        return retval;

So uprobe is aware it could fail, but releases the semaphore and then
doesn't check if the mm struct is okay to use.

What should happen in the failed mm_struct case?

Thanks,
Liam

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241209 10:53]:
> On Mon, Dec 09, 2024 at 10:33:56AM -0500, Liam R. Howlett wrote:
> > * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241209 08:58]:
> > > On Mon, Dec 09, 2024 at 02:52:17PM +0100, Jann Horn wrote:
> > > > On Mon, Dec 9, 2024 at 1:53=E2=80=AFPM Lorenzo Stoakes
> > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > >
> > > > > On Mon, Dec 09, 2024 at 03:20:19AM -0800, syzbot wrote:
> > > > > > Hello,
> > > > > >
> > > > > > syzbot found the following issue on:
> > > > > >
> > > > > > HEAD commit:    feffde684ac2 Merge tag 'for-6.13-rc1-tag' of gi=
t://git.ker..
> > > > > > git tree:       upstream
> > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D17f=
85fc0580000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D50c=
7a61469ce77e7
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D2d788=
f4f7cb660dac4b7
> > > > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binuti=
ls for Debian) 2.40
> > > > > >
> > > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > >
> > > > > Points to this being racey.
> > > > >
> > > > > >
> > > > > > Downloadable assets:
> > > > > > disk image (non-bootable): https://storage.googleapis.com/syzbo=
t-assets/7feb34a89c2a/non_bootable_disk-feffde68.raw.xz
> > > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/6135c7297=
e8e/vmlinux-feffde68.xz
> > > > > > kernel image: https://storage.googleapis.com/syzbot-assets/6c15=
4fdcc9cb/bzImage-feffde68.xz
> > > > > >
> > > > > > IMPORTANT: if you fix the issue, please add the following tag t=
o the commit:
> > > > > > Reported-by: syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.=
com
> > > > > >
> > > > > > Oops: general protection fault, probably for non-canonical addr=
ess 0xdffffc0000000080: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > > > > > KASAN: null-ptr-deref in range [0x0000000000000400-0x0000000000=
000407]
> > > > >
> > > > > This doesn't make a huge amount of sense to me, the VMA is not 0x=
400 (1,024)
> > > > > bytes in size... and the actual faulting offset seems to be 0xdff=
ffc0000000080
> > > > > which is 0x80 off from some KASAN-specified value?
> > > > >
> > > > > This would be vma->vm_file. But that also doesn't really make any=
 sense.
> > > > >
> > > > > But I wonder...
> > > > >
> > > > > I see in the report at [0] that there's a failure injection in vm=
_area_dup() on
> > > > > fork:
> > > > >
> > > > > [   73.842623][ T5318]  ? kmem_cache_alloc_noprof+0x48/0x380
> > > > > [   73.844725][ T5318]  ? __pfx___might_resched+0x10/0x10
> > > > > [   73.846687][ T5318]  should_fail_ex+0x3b0/0x4e0
> > > > > [   73.848496][ T5318]  should_failslab+0xac/0x100
> > > > > [   73.850232][ T5318]  ? vm_area_dup+0x27/0x290
> > > > > [   73.852017][ T5318]  kmem_cache_alloc_noprof+0x70/0x380
> > > > > [   73.854011][ T5318]  vm_area_dup+0x27/0x290
> > > > > [   73.855771][ T5318]  copy_mm+0xc1d/0x1f90
> > > > >
> > > > > I also see in the fork logic we have the following code on error =
path:
> > > > >
> > > > >         mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1)=
;
> > > > >         mas_store(&vmi.mas, XA_ZERO_ENTRY);
> > > > >
> > > > > And XA_ZERO_ENTRY is 0x406.
> > > > >
> > > > > Now if _somehow_ the VMA was being looked up without XA_ZERO_ENTR=
Y being
> > > > > properly accounted for, this might explain it, and why all the !v=
ma logic would
> > > > > be bypassed.
> > > >
> > > > You fixed another issue in this area a month ago, right?
> > > > (https://project-zero.issues.chromium.org/373391951,
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3Df64e67e5d3a45a4a04286c47afade4b518acd47b,
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D985da552a98e27096444508ce5d853244019111f)
> > >
> > > That's for ksm/uffd though, neither pertinent here.
> > >
> > > >
> > > > And we came to the conclusion that MMs whose VMAs have not been
> > > > completely copied and might have XA_ZERO_ENTRY entries left should
> > > > never become visible to anything other than the MM teardown code?
> > >
> > > Well if we came to that conclusion, it was wrong! :)
> > >
> > > Error paths at play again. I mean I think probably the slab allocatio=
n is 'too
> > > small to fail' _in reality_. But somebody will point out some horrend=
ous way
> > > involving a fatal signal or what-not where we could hit this. Maybe.
> > >
> > > >
> > > > > > RIP: 0010:reusable_anon_vma mm/vma.c:1837 [inline]
> > > > > > RIP: 0010:find_mergeable_anon_vma+0x1e4/0x8f0 mm/vma.c:1863
> > > > > > Code: 00 00 00 00 fc ff df 41 80 3c 06 00 74 08 4c 89 ff e8 10 =
39 10 00 4d 8b 37 4d 89 ec 49 c1 ec 03 48 b8 00 00 00 00 00 fc ff df <41> 8=
0 3c 04 00 74 08 4c 89 ef e8 ed 38 10 00 49 8b 5d 00 4c 89 f7
> > > > > > RSP: 0018:ffffc9000d3df500 EFLAGS: 00010203
> > > > > > RAX: dffffc0000000000 RBX: ffffc9000d3df540 RCX: ffff88801cf800=
00
> > > > > > RDX: 0000000000000000 RSI: ffffffff900062a0 RDI: 00000000000000=
00
> > > > > > RBP: ffffc9000d3df610 R08: 0000000000000005 R09: ffffffff8bc6b6=
42
> > > > > > R10: 0000000000000003 R11: ffff88801cf80000 R12: 00000000000000=
80
> > > > > > R13: 0000000000000406 R14: 0000000021000000 R15: ffff8880120d4c=
a0
> > > > > > FS:  00007f137f7e86c0(0000) GS:ffff88801fc00000(0000) knlGS:000=
0000000000000
> > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > CR2: 0000000020000140 CR3: 0000000040256000 CR4: 0000000000352e=
f0
> > > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000000=
00
> > > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000004=
00
> > > > > > Call Trace:
> > > > > >  <TASK>
> > > > > >  __anon_vma_prepare+0xd9/0x4a0 mm/rmap.c:199
> > > > > >  anon_vma_prepare include/linux/rmap.h:164 [inline]
> > > > > >  uprobe_write_opcode+0x1a95/0x2d80 kernel/events/uprobes.c:516
> > > > >
> > > > > Here we find the VMA via:
> > > > >
> > > > >         old_page =3D get_user_page_vma_remote(mm, vaddr, gup_flag=
s, &vma);
> > > > >
> > > > > Actually one unfortunate thing here is... ugh god.
> > > > >
> > > > > I think there might be a bug in get_user_page_vma_remote()...
> > > > >
> > > > > I will check in more detail but I don't see anything that will pr=
event the
> > > > > mmap lock from being dropped before we perform the
> > > > > vma_lookup()... FOLL_UNLOCKABLE will be set due to the &local_loc=
k
> > > > > shenanigans in get_user_pages_remote(), and if we get a page afte=
r a
> > > > > dropped lock and try to vma_lookup() we could be racing... :/
> > > >
> > > > Hm, aren't we holding an mmap_write_lock() across the whole operati=
on
> > > > in register_for_each_vma()? I don't think FOLL_UNLOCKABLE will be s=
et,
> > > > the call from get_user_pages_remote() to is_valid_gup_args() passes
> > > > the caller's "locked" parameter, not &local_locked.
> > >
> > > Yeah I was just about to reply saying this, that code should be clean=
ed up
> > > a bit to make clear... But yeah it's the bool *locked of the invoker,=
 and
> > > can't be &local_locked.
> > >
> > > So yes this rules out get_user_page_vma_remote() as a problem, which =
is
> > > good, because I wrote that :P
> >
> > The mm_struct isn't fully initialized at this point - and won't be once
> > the dup_mmap() fails.  How exactly are we getting to this point in the
> > first place?
> >
> > I have some ideas on fixing this particular issue in the not fully
> > initialised mm structure, but we will still be using a
> > not-fully-initialised mm structure and that sounds wrong on a whole
> > other level.
>=20
> It seems like uprobe can still connect at least via bpf... it uses
> dup_mmap_sem to prevent races with dup_mmap(), but then in no way checks =
to
> see if the fork _succeeded_ and assumes that the uprobe is good to go.
>=20
> I wonder if we can tell uprobe... not to do this in that case :)
>=20
> Some MMF_xxx maybe could help us? I guess we're full up there... but mayb=
e
> MMF_UNSTABLE somehow?
>=20
> >
> > Thanks,
> > Liam
> >
> >

