Return-Path: <linux-kernel+bounces-408170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DDA9C7B44
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3464F287ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBCB2038AA;
	Wed, 13 Nov 2024 18:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ASfxwqRV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tOZTv0Q1"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BAF200B88
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 18:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731522864; cv=fail; b=mwWw82uGnZv/XVQNU0BLhKSg3JocunDmtoum3Ts66x/EUy1/S1cLrVC6Ni0AiO2oQ26fEj0pdbZuc/F6xDXZFz72vFw/Lxayj0/PNX6dDZMwZZ6M6+nB/3m6CsCjFYPa6J8DkYsUP+NDju/vtQJrtYPR7Vh8S8GxkA63mFkyb9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731522864; c=relaxed/simple;
	bh=YxcRUM0JXan3nzd71bEZF2hU9b93AEKJNW6fTUam0Ws=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DpH37+RGkqqTvXWKE0VKbu4jdIhh/BSLF0uF5K1+qByEw4G+yUkZXbt2qNQogy8JYrpAj0cEvdmhlkMbaZcJNIDMPTDAJ1rUWEYtKJlZ1DyDm6h5x5gMrP1JbYkQ5EqijbCBgx5Lg6otNCgyRGoORGc2t/+kj1jZsDnWj0T4PNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ASfxwqRV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tOZTv0Q1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADIBZwL001271;
	Wed, 13 Nov 2024 18:34:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=lwWgX1OXRARAwuUp1n/Z7QJ4oyrgHfXh/a/8G9ZcrHQ=; b=
	ASfxwqRVApGvm20/qIKH9eOiDihJN1lzQgTL8uslVANLOLlAkacjKSaNrFbo8Mde
	sgBfakUG10Xb1oZRDbdzeUP+YG5s/QiYk/OY+QcvO+DbwST+qmPj1VFyjNL1Cr77
	YnzDs5sOLGEZU/Bsk5vEyV+DqGKEfR0M5u5EIx2oA8RCG5ku4/qtZi0K0uirbjwL
	HlHAsrxxHCi+loA+mVPwF3kYHvuZMud9pwOdjNmuM1/+X2dsc2jVDMFof3oLhsav
	cvjLM60KyNhUrCDaKc6zpo6niW86JqxF5QtIgFTKEZszwIeB4PVnAi5x7YO1wO7c
	4hMNjBjGA/hsPhN3GKYH5g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0heqeyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 18:34:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADH3L6Y005671;
	Wed, 13 Nov 2024 18:34:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6a1afm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 18:34:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+Lcn45lHsEDU6sh+yi1kpcWLnpHAT109zwieoT6Flw4k+AEJI8eqU40vKXEFhI2+lY1/MimJUUA3vLhUYS29dRd+hA3RqeKm8u53S8oYz5whlGcU3n1PxJ/jqXiwlcwLxn61RGl2sdmUYStVDIem+//QeM5z7kxr4voOg0ySHe9ymF37skn+EGd7cbwaE0piyHKacV+BkqYlIQlYa3GTThul0SYXf0jtQtbVmo7N0t2mKUEYeolrzmwHS5mgAU0THENKLJNTCl/WFSt+DCQDFK8tRBbtVXvyXYWzEFOxcVobrOKV9tWpllUep7EHXtNDTshU0+R5/6+AdfTaLkc9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwWgX1OXRARAwuUp1n/Z7QJ4oyrgHfXh/a/8G9ZcrHQ=;
 b=TMQj42R4H1pNBng722P4zaZcMmCUEuDc8xlVq99JXMl2pw6u9s1lBuNLCNdv0lOhpJHGU3MpmxrJ/alb4Uudd3JIC85G017ce3VkzTUqtSbkpCM4i/+gvQ5lgRoWJEUy8jznHkjebX9drk+FoM/R2IzjeeCY0ZWpJk9v+Far5EBX3Ia+tD8LzAHiuUNK3JzxyxzxhgfDo8IV5tL94pRsFjIxsDF21ecTJM6MhBmQymwLRT/5nZ+Mnm+Oa+k97A/69FbEEUngnte1Pk8znE7ioYCj/KHxnnyLr7L5snfV9L7zBJ3G9Hy3Sku/6k4To+ZqcnQsehdeDNhknWJUz5c0kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwWgX1OXRARAwuUp1n/Z7QJ4oyrgHfXh/a/8G9ZcrHQ=;
 b=tOZTv0Q1hK2E+582n8++wEONAIjpLr3M9o0VEsWbFCRiPxdB43icS5b+Ft9FJU8YQMemTKmwyta/4B5hXZAlX1rx8ZgEUvwxsqFPPDveX/NSSD8R6HaCCRYCyWP2Z+qKOtzLpgFRP+uvhG39rTMqa/Ld1YMX5XJLGgJVNzjV6g4=
Received: from IA1PR10MB5994.namprd10.prod.outlook.com (2603:10b6:208:3ee::18)
 by SA1PR10MB5822.namprd10.prod.outlook.com (2603:10b6:806:231::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 18:34:03 +0000
Received: from IA1PR10MB5994.namprd10.prod.outlook.com
 ([fe80::f2ab:1ccf:7941:1757]) by IA1PR10MB5994.namprd10.prod.outlook.com
 ([fe80::f2ab:1ccf:7941:1757%5]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 18:34:00 +0000
Message-ID: <1c447727-92ed-416c-bca1-a7ca0974f0df@oracle.com>
Date: Wed, 13 Nov 2024 13:33:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] sched/fair: Add lag based placement
From: Joseph Salisbury <joseph.salisbury@oracle.com>
To: Phil Auld <pauld@redhat.com>
Cc: peterz@infradead.org, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        Steven Rostedt <rostedt@goodmis.org>, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <58289b1c-8a56-4607-8632-d36aef1fc5dd@oracle.com>
 <20241113181930.GD402105@pauld.westford.csb>
 <164634c5-32df-4542-9a5a-2b357e10a67e@oracle.com>
Content-Language: en-US, en-AG
In-Reply-To: <164634c5-32df-4542-9a5a-2b357e10a67e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR03CA0032.eurprd03.prod.outlook.com
 (2603:10a6:208:14::45) To IA1PR10MB5994.namprd10.prod.outlook.com
 (2603:10b6:208:3ee::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB5994:EE_|SA1PR10MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd4f8b3-4469-469a-2972-08dd0411bdf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2FQWjFPNExHVVFxRmhLSXhKbVFVa1RYSEFPSGF1aGkwRXQ3WUUwNG5EamRj?=
 =?utf-8?B?VjV6KzJTZVJqWE9BSlA5VGY0ME1Zc0dGelpNMjhRbUEvQ3ZvRmh2akk1dU9p?=
 =?utf-8?B?WHI1MUxMaTFKWHhpdW5sVVg1ODdGcXUvcFJVNVhkQWViVmxYbG5ZUjdFOXhS?=
 =?utf-8?B?VWhmYms1YnkrS1hlM0tLZmJLOUVhUUpvM2FLSmxrdmNpSEd5NWRuUHc3UDdp?=
 =?utf-8?B?THI0STBhL2RSam9nbFkxaXdNci9QQXJIaTNvaGtXUklHU0IrV1c2K0ZKU0Ur?=
 =?utf-8?B?amU2Ti9NajZwdklMWk0wUWtwVHl0S2N6bWNEQitmTndKVm1BV2NVSjl3akE4?=
 =?utf-8?B?WEcyVE55UGVIcnZJTmJxYWZaNTl4bHo5bTF4VCtaQjlpM2xKVlhsMEtOZmZQ?=
 =?utf-8?B?bG5GZlRYMkYwQjBCbGVocVBTUlVwb0NaTE5EOEF5SVB0UGJtcXo1a3d1aWVN?=
 =?utf-8?B?T3pYUndKSWJTRC9JaXg4TmkvVml3cEhrU1BLVCtMcEJWNDlrTTc4YjNvMnRU?=
 =?utf-8?B?Y1JoaFZMSlB4VTdkYzczbzE4bVJSRU9KbWhHVjZGWXRPbHJLeTRQRjVFUFNQ?=
 =?utf-8?B?RTkvbU0rcTZZVFNmN0VRRnJLMXRLbWZrUk9Jd2pNNm9FOStyaGIrS1FDUlZE?=
 =?utf-8?B?d1A3SnZQQXhDcTFUNUdDY21rRnVaWDJZdHdKMjJMMlZFK0lUUHlFNE5GQUky?=
 =?utf-8?B?bFRaNmVYcm15bm1XTFdqZzJXdW1lT0ZDTytySzJIREU0cU5TenFxZnhpWi9y?=
 =?utf-8?B?TEVyczVHRVAvYmovM3ZMQVBOa09NSUFpTTNFcWxDVEpHcWNDcHNjQjNZdGxy?=
 =?utf-8?B?SE5CQjV3alhMcGVZYXo4Q0tpbTU0L1FnMUpHYnRPcXpzRGRMaXdCZzFYMGpE?=
 =?utf-8?B?K0hwMUtJVU5qbDM3V3F6VVUzVGJ0T3BYWmcvZ1JZaERqREpwYmZvclU5ckF6?=
 =?utf-8?B?SlRpNGFHRC9HaUc4L2RxdzlaQjQva1VaNXFNQUQ4UlQyWVlhSHlLZjdIN3Yx?=
 =?utf-8?B?R3BIYVQ5YVUwQWg5QWtkVmc2YlNFTm9KNlJHTmNwSWFXODhlbC9lby8vTUhV?=
 =?utf-8?B?aFJzdm1MZENEZ0NuWmNtVTNTL0tuVmU3aUs1UEpoSmVQU09JcWpTdjBWQUow?=
 =?utf-8?B?MmZjQmRJMDRHWHdGc0h1TzlrMXFwL1QwUVFQNk1qR2xBRHRDZHMxcVl6VVhP?=
 =?utf-8?B?L2pKWk9pVm02RHdzSktJcG5iVDJjYjBmTHlhdjR6MmxyRUhaUllmSG40VTBL?=
 =?utf-8?B?UFpyVFVHbFJsR2phZWdMa0JpaHB4ZEZuZERvaWpGUXZsVkV0R0t1a0NIcVIx?=
 =?utf-8?B?SExOMHJIOW1qTnpRSThnZzQ3cWMwY2ZHVjRZaVIzSHBaNCsvUlNxRU5FeGpC?=
 =?utf-8?B?T1BrSFVJNVlFZUp5WE82eGcvaVIwQXZkT1BIN2pMMlJrS0hSbVlPOU5odFMw?=
 =?utf-8?B?WGxCWVgrOUxMZUlwN0dwN3VjMlM0SllYT3FXUTM0RHJtVVJVYU1xVjE2QndE?=
 =?utf-8?B?eGpiK003c0t0VzNsQWdnWWJzdCt0WlhFZTBaeFhVYUNTb3BIaVQzMDVvZW55?=
 =?utf-8?B?VE9FY2J1cnBoWW95eHkyS0VHY2J5aDkxYm9Oa1ZMN2ttdFNMejhVd01CTFdJ?=
 =?utf-8?B?VUt5S2NMbzRHY2NWNTlyUDByNmsvcjFGTDJ4RnFrNldSMDJreWFZMGtSWlFP?=
 =?utf-8?Q?VIxdJEgzXCnvMDYIShAk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB5994.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGwzeTZCOElxNkZzQURlTmVtNFQxOUYxQkZQRVJ3emgyZnA1eGtoUDVsUFJw?=
 =?utf-8?B?VkxBS3JvZDBYeGpBcldJUW1SYzc5eHhBL1dlQmN2ZzUvT1NpdElra0FxZU5n?=
 =?utf-8?B?ZndISE5mM3ZzeWc3akxNTUVZLzNQcFdIM2RSUWRxSzk0VWVFWVZqYkUyRjU2?=
 =?utf-8?B?NEl0UjlIRXBnd1l6MnozckxLNVJENWV4eERTMGIxWnl2RzRUTHZwNkRSbklk?=
 =?utf-8?B?Z1E3RHM3YWFSSWgyWDI5d0lvYWtSREFNTTRjbEx4SG1nS1Y3N3VHNzJMNWYv?=
 =?utf-8?B?Mm82QjVnZUdOcnJNR2hldW95ZUdraVNpN2pnUEhNREw3UDY4WHltNHFpdW0w?=
 =?utf-8?B?TkZxZ3ZvbDY1RDgrMFZ1R1hleUoxLzJPTDR5UXNsRytKemJvYUQzeDd4S0p5?=
 =?utf-8?B?UnlkN0lySXVQcG42L2x1QlZkNWJVYkM2QkZteU1ITEIwYkRLc0pLQVJaTHpM?=
 =?utf-8?B?ZjVDVjJsdlI5ejVGZW9aWFlnSFJnMHU5Zk9qZUU2SFhuOHhscW9KYjVPdzlP?=
 =?utf-8?B?dmtqeHgrSVFBN2w1UVlVRDRGcjBWb0V1QUhVekRDNElYNFkwR2lMaTBISjUz?=
 =?utf-8?B?UjZyTFVOYSsvSjFVeUtZQmZnSWlyQmxSbkZCWk84NllZMTJ0YWprQmtQV2ZG?=
 =?utf-8?B?TWNPeDR2c1dwU1R5NGFiTkQ3SDF3cVVJdkZ1S25rVFdDZjNwQU1lcnlucm1C?=
 =?utf-8?B?cDl1TndKeHJTRDNCUnM5bkE2TDd2c3R6VzB3U1FWTlo4Z3RqTUkwVnhISnpl?=
 =?utf-8?B?OW04a0JYNjlLOUt4WlQwYWxoWmhyVHBObmEwSU5GM2xITDhZbDV4Q2tyVS9r?=
 =?utf-8?B?eTA1cGFucXNOb3d4aUhzcERJUUFoOTNZSUVGNmthTStRQlhMSkp2cnYxUTZw?=
 =?utf-8?B?SUZoRGIzZTRqMEc0Snd0amVuTmlPZ2pNaVBNT1kyNHUwMXZrdldFcmxXcG5Z?=
 =?utf-8?B?MUFKa20zalQxZTQwVVE0eHBpZkZMRmE0Z2ppYWhoa0JYWnlULy96bGVsWFBq?=
 =?utf-8?B?YlVVcTIzWU1KNHlFRk9uV3B6dW9Ub0phVHcxZFJidHoxQ29LV3Aza2F1cGtN?=
 =?utf-8?B?K05OTDdHRWxTWVhiM01QTzRlVmVJMXpkREs2b1NnbzJmdnQ3eU5TTU1YRGEr?=
 =?utf-8?B?eDM1WDI1STFROURhcGJhTUIvVGFvTjZ6bk0ySHJ6RkROQTdQM09teWs4NDZ1?=
 =?utf-8?B?ZndXUDBEUUxJVVpxZ282VVRITk1JTGVDOTdTdDVMbzRpYWhTc0dyaDhOY1JE?=
 =?utf-8?B?ZjZiVWtSZXMveXpVMThrVy95eXdaK1ZLUC8rMkM5Q21hbzJMNEc4L1JaQ3Vi?=
 =?utf-8?B?NmkvWlhQR2pOVlpnbFZ3U3o4SE95Z2hKcUxWUVVhVko5UFJwYmZTYkdNMjRn?=
 =?utf-8?B?THd0VUhXT1VsNjkvek1IQjRWR3dJeFdrMXJ2M1BESllaclJBVThvTXZ6L0xC?=
 =?utf-8?B?QmxJVzdaTElnNGVuNmtTNWFGeWRLOXhFME1pVExPNEdXWXRwRE93aHduMXRz?=
 =?utf-8?B?b0pIVkV5SHl0MlVWTElyM0RJZGxZZmUwY21aZGFycEh0Wm9VaWlpc2Z4dzFQ?=
 =?utf-8?B?bjBKMThXRjB2NnhJdjdkL1JvRThSZE8xS2p6NHdVVkl2d0YvcEsyaStBbWlx?=
 =?utf-8?B?QkpubElRUk1HUTNSRFpscGlWZEdFNmZsQ0hubTdwdW92NHR0ZDBQKzVNRUZ2?=
 =?utf-8?B?UFpXNURRTWRjNkdyTmJ4QXM2cGtyYUs1ZG5GSkFuUElBY3o5OXYwOURhc091?=
 =?utf-8?B?aG50bzl2cEN4bXI1T2lCTXhDSmxhZFZXTkEzUG8vVStQSmxPSzFrbUR5R0dj?=
 =?utf-8?B?TFZ5SjE5L3F2c3hNVEZBZWUvajZSN3BzUmNoVHI0bGY5VG9tZ2Z2QVVpZkhs?=
 =?utf-8?B?YmtKZVNaRkJqMWlnK2pBWXJYZFpUeDBiSEQxbkZHWGh3RUk0M0xRSUlLTFZk?=
 =?utf-8?B?STdTK0c3d3loT2NXTlEwcG51cDRQd1FVRVlESllmdkRCcWVSN2NhR1FBQkxC?=
 =?utf-8?B?YkJ2S09semNpTkZpakpRaHdGR2pZVWJwRGJuRlVMUGIyblArTUhkTzZWcElT?=
 =?utf-8?B?c3JLTHYrMS96MjFTMEQzekd4M3RRNlFpTzhNeDdXQkVBdHphaC83MXVKK3BP?=
 =?utf-8?B?blMrV2VBVUk0c0dxckZqMEZwTkVDd25telJtSUR6QlRrSjZNK294enlXQkxk?=
 =?utf-8?Q?sb3TDx1M08ibOHntWVCboRk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4LZPiFjHyYcGL0yo3gJTWIHFY2hWfIajWIiCvwJtoj9H8163KVk8HSd2hlr2DfiXbfzp3h703Vw2LxmKXhYSRC10dOiSjfj9bV6Epr+sthoTbAOcMkMkmS7nEidPukJYsuDMXxUpV7y7HrDUtQ4yW0CGlRCB0JS9I1I2e3zFdUxJFBQk+WuvOK5sIONEDsu1izt7sel/VWTNLK1nZQ4XNFLFY8XgAIJWfwT9Jsxzg7euDhwk4PMfayZhWxDtOis0nlZAbgUeAwlRCmi4o0LF38XyHsHI2h7EChtYy0wpeFGBpIbOzRvqBr2eeVsjI4ALONbb5U/ik+1/DrQjF0Jb3FrYN20WVF9CaC7glvxjT3ozkJT7GdYgjGYPqAm7D6qI5YO2IK0ZjnHckvNLT/rz+KqEw++A+TPfN7uzjmvmEJ9WwUyNPUpdCpfghO1BzSbOlbRGxMyRnaMLHewoRFRfQrlc8vCCHbmGwCWxQRAJZo8WeQSTPijUOE15eiYIVJ1T1ElzCd6sJc7TlCw60fmPEguQzi5Ybs5+qRtpZ/uipk3tPotbceIl9ECWlvTxScOT7+/nO6czUdDeNnGSOvG33gTRbp8r6ITO4RFtwczNH9k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd4f8b3-4469-469a-2972-08dd0411bdf9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB5994.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 18:34:00.6788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0aChKAA/cQREOn0KKEGqsQKYX6uXXdn5P/9+pv4OkgIrP6sdrEYgA8Fqe0XrCtGpZLQdu+/WNyke7ctMHIJbi6BXGI4IETDO/ngqHX8gawc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_10,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411130153
X-Proofpoint-ORIG-GUID: JzI5gJW_-iszLVJTSXBGnf4PH60rAeyp
X-Proofpoint-GUID: JzI5gJW_-iszLVJTSXBGnf4PH60rAeyp




On 11/13/24 13:22, Joseph Salisbury wrote:
>
>
>
> On 11/13/24 13:19, Phil Auld wrote:
>> Hi,
>>
>> On Wed, Nov 13, 2024 at 01:03:00PM -0500 Joseph Salisbury wrote:
>>> Hello,
>>>
>>> During performance testing, we found a regression of ~9% performance 
>>> with
>>> the TPCC benchmark.   This performance regression was introduced in
>>> v6.6-rc1.  After a bisect, the following commit was identified as 
>>> the cause
>>> of the regression:
>>>
>>> 86bfbb7ce4f6 ("sched/fair: Add lag based placement")
>>>
>>> I was hoping to get some feedback from the scheduler folks. Do you 
>>> think
>>> gathering any additional data will help diagnose this issue? Are 
>>> there any
>>> tunable options that can changed to see how performance is affected?
>>>
>> You can try turning off the PLACE_LAG sched feature:
>>
>>      echo NO_PLACE_LAG > /sys/kernel/debug/sched/features
>>
>> It's not what I'd call a tunable but it would allow you to test w/o 
>> it and
>> see what it does.  It should allow you to switch back and forth 
>> easily for
>> testing.
>>
>>
>> Cheers,
>> Phil
> Thanks so much for the suggestion, Phil!  I will give that a try and 
> report the results.
>>
>>> Thanks,
>>>
>>> Joe
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>
>
I just noticed this thread, which is probably related:
https://lore.kernel.org/lkml/ZxuujhhrJcoYOdMJ@BLRRASHENOY1.amd.com/T/

