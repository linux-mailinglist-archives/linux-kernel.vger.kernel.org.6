Return-Path: <linux-kernel+bounces-411319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A07B29CF62D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 21:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 224AE1F21215
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944691DDC0B;
	Fri, 15 Nov 2024 20:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IEyRFuNc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LcW0vIvc"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702931DA23
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 20:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731702913; cv=fail; b=Tb07wJMiNmIvV2kXe1I+6k5q698W7PAijHIWnpozcUHkBritxt5R5xby2LNw3zDceqmgXdgHfFCzKe26UnxaI/lvD4luDDZSYN2RY2Df4MWRPDMQaUxe9JWikVNEstsUZtLq7t5vYtYeHIq4SKasYJ+jK1yCFDbq7mZYy/gmlFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731702913; c=relaxed/simple;
	bh=fQIUBJbvajwECyI4zL4pXSMQxmIfoaRrDxE7x3qBUuk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=up0lP6+BlU/31GOqHu6JnXAwHrX8CoT49TplyOBaeW2Sv+/FyM/pvuEevLANdXyPJIqSqL2eSgagXCeiCgFG3TuyagNqrgOMGr42v0QL89vDyyu8PQVV6Sfu18B1bKezp2bkvyWMEA+ii6uzwUtYwHfvBOJyL+FXWoGh/Pyd+yQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IEyRFuNc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LcW0vIvc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFKNEon016634;
	Fri, 15 Nov 2024 20:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=uHp5Wr+UXt83MtASJ3KgFsTkDfzeAi6sYPz8j41jv8c=; b=
	IEyRFuNcVvrCDLWUw1xzv3ZD80hywi6m5XbUBDO6YFflhZJTCz8AM+BRRZSVl7XD
	27aVgpqSWz7wvMJ7Yi1LLv86zfC4EQ3uqR3ZFpa29LtxaOx9Y5791Sc+exzfvR1M
	pTzHWN25Xu055UT58//nUNvn5eMV51E9vT4c+ZTyUKLscqTjFJhB2LfdExhrdntz
	D0soMOTHUcfvjFgvBJMzhzlFA5oV8qL4mfBDRcraI7UgjiumcprIQS4umvuhx3wk
	qYn6ohHdsFirabeWAr8z/Rrpxg9yQKbjOslkrwuh8rNckxijuvADhVea4bLxJ/z2
	27u04oAu4lBJk6roqs5lGg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0n545um-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 20:35:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFKNvjk025870;
	Fri, 15 Nov 2024 20:35:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6cp8jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 20:34:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vR3P7GB1y3yGG0cllWBU6tmGvDzPExPS+vVaVvdYrBEcOXfyZ7oEl4/MLpISI08YJN7qn4KLLhM9laU84WJfynARkAwylswu1XikKmnv23BGCDoUG36/9LOtez3zPmDaF2ao1gB2WDfefiAvxX/E6NnOQ+AzmmIuTdagtMeo8upwdOyIe7VF330+aKZ2ig4YIR+aNRlndZacaP2uMKS32pHJwdPOx2aS8C2iSrKh0jETSR8dHzKkZwxBw8PXtiV/+GWqsDN3n9CrC0Y32FjwFxadMItg1kINDOlcOhW0HhC53M1xN5N+fAoyBZzyLoY0P/MVBGKwMqUfxFQGjwRG1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHp5Wr+UXt83MtASJ3KgFsTkDfzeAi6sYPz8j41jv8c=;
 b=h1OgQIkwDkFp3+Lgw8dvFDK69VcIb+7TNObBwBEOTKICJZxnedXYNKhb4rVGWlUMC5UjK8Lv8KWWceB+6FZsIj+6xE7V6SB9Gl05RYUtbwgotf2LshIXzNMp2GWsOyiQg8bl3yjb5i4DlThzDzFOfjkbyTikEJxmSIwSLyuKhdhLVfeHVjsy12qCERP2j3OiGj/lj6gCPUqPrEccg2uX8jBCudLq51z1arrMntNEu1FN3UoW1zddvcU4byTC1rav1GZ2SWbUWSveq9ijlXpojCeo1HK/ndiILg2M01xwedl9uKTTMfwbTdgJeaazGa6v7Em2weGbb27DHFE5sb/G/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHp5Wr+UXt83MtASJ3KgFsTkDfzeAi6sYPz8j41jv8c=;
 b=LcW0vIvcneOUn5Zhl+6yx/5pKC/NfmU5G+bIp5AMLcLvqP5iFQ1Zoef96d4hZuyWKxkdRRU9C45S7n4as09XkoGJojleB7dNaJLSTtyrSCVVASpELNtgQEp3NpgeIW+o2pXIKDOi4T6yUXAWm5I80iEJL2Fl+tYXecvc6UlF1Yc=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by LV3PR10MB8033.namprd10.prod.outlook.com (2603:10b6:408:280::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 20:34:57 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%4]) with mapi id 15.20.8158.019; Fri, 15 Nov 2024
 20:34:57 +0000
Message-ID: <2aa439f1-d33d-43ee-9945-5ac570506c7e@oracle.com>
Date: Fri, 15 Nov 2024 15:34:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] maple_tree: use vacant nodes to reduce worst case
 allocations
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com
References: <20241114170524.64391-1-sidhartha.kumar@oracle.com>
 <20241114170524.64391-4-sidhartha.kumar@oracle.com>
 <20241115075203.ojspk255cw3sr3s3@master>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20241115075203.ojspk255cw3sr3s3@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR22CA0025.namprd22.prod.outlook.com
 (2603:10b6:208:238::30) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|LV3PR10MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e106b94-aac8-4b4e-5ac6-08dd05b4f814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFlSUEdibU9OeFFoR3VSS1BkQWJZRFJ6SUZRUnIzcHR6N3ZsN1hiSFpCNjMx?=
 =?utf-8?B?Y0tXWjVSa2Q0MmZqbVp6b05GaExTN3ZtL2cvaXVlanh4WFFBMW11Wjd2dkY4?=
 =?utf-8?B?RHFpaTdvdWhEaHZhY1JWMFBZTitqY3VqQ0xYdkJ0blFRczZnMGRsd21jdzYr?=
 =?utf-8?B?TWI4V2dRazdzYXkydE8ySHdwWWF0N2wySWFhSUtLdG1CMmxWeDM2b3pDc1J2?=
 =?utf-8?B?SStwRS9BV21aZFlGYllBcmFSYy84VHRlZC9kZ21YL3poZUNsOGQrV3liTE80?=
 =?utf-8?B?bURLOHpiUjRybTgvMnpkTXJWOExYdVNHSFdxR3QwVGlCVzRzR044Y2Ivd0Ex?=
 =?utf-8?B?SFNzUUxZNWdkRFFlaTIrdmp0U0xmZnRCRys4NldQNlpMZXA3SW13SkJMam15?=
 =?utf-8?B?YmRRQjRid1Y2SkdUdVk1R2F0V3BKUGYyK2I4MHZnVER2OExSV0FBYXZtQnFK?=
 =?utf-8?B?OXNWbDR5NVNpSEJoR09zVzRxSldRaDFkZ25IZ2pyaHVHWkZKNXd4R3QxenNV?=
 =?utf-8?B?SVQrNDNSZ0RIUFhlditwUnlxenhFWWcyMDhqR04xK3J6eUJaeloxNjBlWCt0?=
 =?utf-8?B?QXdFb3V3alhnTU9QS2hYOXlUbFFnckpHU2taQmRrQnBvbFQ1SmE5cGJVVmwz?=
 =?utf-8?B?cWs5NitudzFGeUFQR0s4WmgxNXJhNlZHQ3hQU2dUNUJmWm9BenBMaktqbHlv?=
 =?utf-8?B?U0JHa2RtZzZacmVnWnpVZCtzQ2NYUStXRDEzdm5wNm1wRkUrZ3kxa2JXLzFC?=
 =?utf-8?B?RWZkUm51RzNKTnNCVUE5VEhMcjNFejlBTzBrTG1qN000T0dDTlJLend0YzhL?=
 =?utf-8?B?ZG9WcEkrbVNkVlROc2hwaDBvbmZ2WUUvMDlTVExyZmVjWEtlZnNLYkcySEU4?=
 =?utf-8?B?ZXdTWDRYOVJjbzB4aGQ5M1dTck9xcUhTWUc3QjhZOHc3ekFMbkJTN3ZpQTUz?=
 =?utf-8?B?a0o4UWZKMVN0bUhEK3BuRXA5aldMTk1xYndUMXFEU3M5SUZmVm5JRkgvbko5?=
 =?utf-8?B?b2YvQVJTSDRVSXVUQ3RPdmJpd3ZFR0ozYWd1V2Y3T3VlN2k5OGIrMnlHQUQ5?=
 =?utf-8?B?ZlJtWmxnS2RWaUt3MTQ4elRhQm5sanlMYU1MS3JySlBReWpZOFRNNTdpWVFr?=
 =?utf-8?B?eFZRQ3hzL08zOW93MGFubWlLK0xMaUpxVE14N2VTS0NPcWd0b0VWbGxQUk4v?=
 =?utf-8?B?a1V6Ni9BTFVEYXNvdnFSdFdpRkpFbDg2YVVWOUVkQWl1aThxTGdyckplRzhv?=
 =?utf-8?B?dVV4VTZ3WXhOTFFMU0J0ZDVGQnZXWW1mWVFpQWc5dWkxL09FU0w2MWkzS2xP?=
 =?utf-8?B?Nm44VjdORlBQVWZleWYzQzViVlVQSjJpL0M2dUNQem56UDc2b01pWXVyTEd2?=
 =?utf-8?B?dWZjVWpXUFZjQ2s2V1lpMlhxRGRCZ2pOT3RjeEVYVjIyUVN2ME9QcmZMYjlx?=
 =?utf-8?B?R0psNTlPRzQvVzlzUk4ybDIwMEVTTklSK0l2UWk0cVJaaEJsVXBBR0pmblNK?=
 =?utf-8?B?bW9TTjVXajQ4QzBOOE1yUWRDUmowNzdDY3RQMjBRUi9ab0I0Q0xuTnNudkZt?=
 =?utf-8?B?Vnhpa3N5dzdCdllzdzBYUndUbjVwWElvc0lRSHIrV1RvYWxTSndNNFM0b3B1?=
 =?utf-8?B?VElsTVIvamxpc0ZKM3JkRTUrYjBOTkZQT0l6YWE4QzNhUzA0TS84SkQ1b2NP?=
 =?utf-8?B?RTVxZlk2WlFlQUFQeno2K1ZWTHFpMmtYNHZLVHZiNUNqNzZ2Rk1vM3lybEhE?=
 =?utf-8?Q?lhrXc5WLY0j0FoEAGOe86/97qeD6RxlAtbUGIAW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGpiRkVaSjF4Yng4UUZtby9lMkRRK2tUZXhNeHovOWVoL05saU1NTGhEWVhW?=
 =?utf-8?B?YzlLR2crc3IzQytxOTVIclFjNFZmVjRFdGNnLzlYZzdjdkgvLzJJRVZ2ejhK?=
 =?utf-8?B?WTdWZnJ3WlROK3ZDZXdSNWxUMVNvbTM3bXZkdVFJMHRmcjhRbVFDWlVuUlVB?=
 =?utf-8?B?OG9MekJLNjc1aWdhbWtZOGNsakRwS0V0ekdDYnZ2YndOcjBENEtKVkd0ZFVR?=
 =?utf-8?B?eCtnZUQxMnlKb3dPLzVuczBkY0FPKzBWUURRMVlvejdreVFnSmxFb0RNMUtr?=
 =?utf-8?B?OXh5b0JVUXFBK0Rod25OYmM3VmM4c1RqNWFCZHhtbUtaMjBqcFNTeG11cVpN?=
 =?utf-8?B?blVQeHBLOFdqOE9PV2tYZlpLNXZMeWdXUmlVY0NjekxmelB5c0p3Uy81aSti?=
 =?utf-8?B?aUIyajZwblBHMWlkOFNwT01mdjRZVjlMaXNFZDIrMlFhKzA0VzBvRWRyaGk1?=
 =?utf-8?B?NXBpTzNlTHJlMDlWc2NMNDJmb0NhZ0pHcWVsendlQXJtNml5a3hWczk5MTVy?=
 =?utf-8?B?Q2JsY3pxVGVMWktuaFlFbnJVanNXaUlFdWhjODNqUWZxSWE2YXZzVnIweXlh?=
 =?utf-8?B?ckRocG9pbGJYbjlCdUpLL04yT2xvOFNrSnQ2Q2ZVSGkyMGpWTU42Q1dIV01j?=
 =?utf-8?B?WVVFekRDTG9MVklJdUlDbzhBMkRDNERnekJiYWVVTWF3KzgzTmJES09Ydjdy?=
 =?utf-8?B?bm5uM2dTY0lyRjVwbEJ2WUVtcGRjZTNEK2lrTmpGb1puYzUwVmxwOUlmeTFw?=
 =?utf-8?B?TnBPLzVZa2ZKako5dHJraTdKbVpNb3dwMUV5MlNEMjZIV0c0dFY2clFpckNZ?=
 =?utf-8?B?TW9Xc2l5WUlVMlBmc00xSTFvMW5PSFArdU9jM1lMU09CU2EwS0I5MHNQUDJa?=
 =?utf-8?B?aXpqYWw3dWkrZmtOVE13MC9VZk1KM1UwVXZFWko0NXp0NUgvV1Z1SmJQcGtu?=
 =?utf-8?B?TjB1VlJvem1va1BPbm4zYW1wb3ozMk0yNTVBNUZtWVdaSGRGZVhtbmFqQXh5?=
 =?utf-8?B?ZUM2SVphdFJWVFZPRUQwMkZ4K2ZndXRpbHdmZ0d5OWllK3o2QjhQbWNWMngz?=
 =?utf-8?B?OUh1dnRaMUJINit0VW1ZRzE1ZnpXVGRtUExRTTJOV29FWE1HZE9XbGh6dSs1?=
 =?utf-8?B?aUR2MS9XU0lJcURNelVia2JBbDJQY1FpdlBrY2xRbTJDdkY1MFJsSjVDQVZY?=
 =?utf-8?B?NldkblJYVXltbEU2QjJyWm9Pd0lqWkxsZFZOdVZtWE5NMGVkRTlkOVNZVDBB?=
 =?utf-8?B?bi80bFpudFkzWEZQNXNEWXFmcjl2VE1KeXlVc3p2eFdwN1Zzbzl6eDNMWFRp?=
 =?utf-8?B?eEJWMmFNRno0b213RGJOcUFTc0kydldpU0d6cnhTaDFrbXN5ejZNRnM3dGdX?=
 =?utf-8?B?V3M0am55UnNTTGprbWhVZHlvSDdFbTBrbzZmelBVaGFVa2V1dWZMTWtqNzVN?=
 =?utf-8?B?R1RYdkl5SjRhZHo0UUpDd3BTdDF5NU1zVmlyZmNQbk9JVVo5Ry9WUURqYUlz?=
 =?utf-8?B?U0w3UFdNczJaandpQkpnb0wwWE9lUlBFcEJrSTMwcS8xOVFkRGQxdzB3eG9S?=
 =?utf-8?B?bUpDTzNIeldueGM2cFVpQ2tJV3hlNlFiaFVyaXFPZElmOTROMEZnS3hWKzBY?=
 =?utf-8?B?OVBwcC81eEp5bFNBbW1qK2lNQUlHbEU2NkU0NFRxUWJZbzFLQ1gxSGo3WGtF?=
 =?utf-8?B?cUJYUjBsS0dwMXA2d1dVcFF4QStZUWdSZ1RrNVNiQUM5YW1Nbmg5aFRYUXZQ?=
 =?utf-8?B?S0VzeVZYMXowekZqY0pjMEJ3am8rOStBaWhlVHQzM3UrYnJWM3RySTd4MnJo?=
 =?utf-8?B?RlpWS2tHRFB4d2xyemxoN0tDc0VnZ1h6amJUZGdjUHVDUzBqcnBzWjA1eU1J?=
 =?utf-8?B?SzVnRmxoRTdQQ2xaSW5XRWFHRXQyZEhPWGFFNHgvQWVLODZraHJpK1hubFE1?=
 =?utf-8?B?Y0thVHE3aHdpeWwwODMvblNzbkJhNm1HdnpHMzR6b1ZHT0ZuQWZWQ0FXdkFl?=
 =?utf-8?B?T3hEb2hhcjR0OFFqd0hFMFFnT0RqdFFxeUNMVmVQcGJIVzdYQmpQUzR1STg3?=
 =?utf-8?B?VHhFWG56bGdsRFpQM0NrcFJUZ2JmbzFLNXZkK3lteWF2OXdlTkorN3hTODU2?=
 =?utf-8?B?aHlKTWF1SGh4N0puOUV5SG1OVzJVVTlJV01TQ2VpOS9kQ2VRQ042WUE0clVW?=
 =?utf-8?Q?8lzqPVhmwnENdTUBuEydj3U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vo0n/yIx72FciexUDr/pWXmtc0fjnJQlbKZ49wgBMbEoLmbb3mdotD8oAlO6j0FiGEwbXB11RrMooUzKzNepwbIU1CkEcAQVHmyJFou/ypeO4yqTp4PD+PUL639DsVbDcraXCq6Blff1e+xDtXFshY39yNwLOlYOLZ9wNRHipGc6SfVvjeQdS/f8kwfx4sa6AJP8KLqZSSTRxgNCHB0HOQLNR8S5M+DWS1Tj0RIph97ONJxKrw0NZ/LRXbZ+0r4MUvXf+WWKHWHNZSBDSMaCYWfvnA4HmOR9SgqQICarq5wfSNhIwL7UC9bC6tmhSkC3vwLY2dn5wMO3sW8I99I4PwU/lhTsMBqBOKEtLaWjDaQmEb5eMmzUkV0LcHNVNtemVLcjxh1845u2y8EJjqAxd8VbjS0RS0Me2p9QEbHwALgYqEgFteYLVAP6pQpiNq4raAgOZZTd5nsshOXZxTtdjiKsH00ENJNWRhHGGCovokmnvjmzefMaJkH0Xj4cB99tpOgvNSI+bca9p0F+WdfpDkgWCkRBw8+MObezmh3tUn7z2OESlMOYmIOfMz4QcKxqdONFdYw0yDPq5r45yvZUpxrQTJ27rTNSAUI/YzFcUyc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e106b94-aac8-4b4e-5ac6-08dd05b4f814
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 20:34:57.2881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHB0pl7020Yoby8ozWJBlQvrQqVuN7b98hInQ8O6LLwV7fz23jxwyuseCH0JVrOyeKPf0wvySq/Zh3LchY6crr9Of2lA9qufuKxSFEe1pSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8033
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-15_07,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411150172
X-Proofpoint-ORIG-GUID: wULxsCG9TkkGA4J6-hDVGmhP91v-ujdo
X-Proofpoint-GUID: wULxsCG9TkkGA4J6-hDVGmhP91v-ujdo

On 11/15/24 2:52 AM, Wei Yang wrote:
> On Thu, Nov 14, 2024 at 12:05:22PM -0500, Sidhartha Kumar wrote:
>> In order to determine the store type for a maple tree operation, a walk
>> of the tree is done through mas_wr_walk(). This function descends the
>> tree until a spanning write is detected or we reach a leaf node. While
>> descending, keep track of the height at which we encounter a node with
>> available space. This is done by checking if mas->end is less than the
>> number of slots a given node type can fit.
>>
>> Now that the height of the vacant node is tracked, we can use the
>> difference between the height of the tree and the height of the vacant
>> node to know how many levels we will have to propagate creating new
>> nodes. Update mas_prealloc_calc() to consider the vacant height and
>> reduce the number of worst allocations.
>>
>> Rebalancing stores are not supported and fall back to using the full
>> height of the tree for allocations.
>>
>> Update preallocation testing assertions to take into account vacant
>> height.
>>
>> Signed-off-by: Sidhartha <sidhartha.kumar@oracle.com>
>> ---
>> include/linux/maple_tree.h       |  2 +
>> lib/maple_tree.c                 | 13 +++--
>> tools/testing/radix-tree/maple.c | 97 +++++++++++++++++++++++++++++---
>> 3 files changed, 100 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
>> index cbbcd18d4186..7d777aa2d9ed 100644
>> --- a/include/linux/maple_tree.h
>> +++ b/include/linux/maple_tree.h
>> @@ -463,6 +463,7 @@ struct ma_wr_state {
>> 	void __rcu **slots;		/* mas->node->slots pointer */
>> 	void *entry;			/* The entry to write */
>> 	void *content;			/* The existing entry that is being overwritten */
>> +	unsigned char vacant_height;	/* Depth of lowest node with free space */
>                               ^^^           ^^^
> 
> Would this be a little misleading?
> 

Could you elaborate on how its misleading?

>> };
>>
>> #define mas_lock(mas)           spin_lock(&((mas)->tree->ma_lock))
>> @@ -498,6 +499,7 @@ struct ma_wr_state {
>> 		.mas = ma_state,					\
>> 		.content = NULL,					\
>> 		.entry = wr_entry,					\
>> +		.vacant_height = 0					\
>> 	}
>>
>> #define MA_TOPIARY(name, tree)						\
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index 21289e350382..f14d70c171c2 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -3545,6 +3545,9 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
>> 		if (ma_is_leaf(wr_mas->type))
>> 			return true;
>>
>> +		if (mas->end < mt_slots[wr_mas->type] - 1)
>> +			wr_mas->vacant_height = mas->depth + 1;
> 
> For some cases in rebalance, we may split data into three parts, which means
> we need 2 extra vacant slot.
> 
> Maybe this check is not accurate?
> 

The triple split scenario which you are describing comes from the 
spanning store case not on the wr_rebalance case. There is a check 
before we set vacant height to return if is_span_wr() so I believe this 
is correct still.

>> +
>> 		mas_wr_walk_traverse(wr_mas);
>> 	}
>>
>> @@ -4159,7 +4162,9 @@ static inline void mas_wr_prealloc_setup(struct ma_wr_state *wr_mas)
>> static inline int mas_prealloc_calc(struct ma_wr_state *wr_mas, void *entry)
>> {
>> 	struct ma_state *mas = wr_mas->mas;
>> -	int ret = mas_mt_height(mas) * 3 + 1;
>> +	unsigned char height = mas_mt_height(mas);
>> +	int ret = height * 3 + 1;
>> +	unsigned char delta = height - wr_mas->vacant_height;
>>
>> 	switch (mas->store_type) {
>> 	case wr_invalid:
>> @@ -4177,13 +4182,13 @@ static inline int mas_prealloc_calc(struct ma_wr_state *wr_mas, void *entry)
>> 			ret = 0;
>> 		break;
>> 	case wr_spanning_store:
>> -		ret =  mas_mt_height(mas) * 3 + 1;
>> +		ret = delta * 3 + 1;
> 
> Hmm... I am afraid we need to put this patch after next one.
> 
> Without the change in next patch, we still need to go up the tree till root to
> rebalance.
> 

I think you are right here as mas_wr_spanning_store() calls 
mas_spanning_rebalance(), I'll switch the order of patch 3 and patch 4.

>> 		break;
>> 	case wr_split_store:
>> -		ret =  mas_mt_height(mas) * 2 + 1;
>> +		ret = delta * 2 + 1;
>> 		break;
>> 	case wr_rebalance:
>> -		ret =  mas_mt_height(mas) * 2 - 1;
>> +		ret = height * 2 + 1;
> 
> Looks current calculation is not correct?
> If so, do we need to have a fix to be backported?
> 

This was a typo, it can remain as height * 2 -1.

Thanks for taking a look,
Sidhartha Kumar

> 


