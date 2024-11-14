Return-Path: <linux-kernel+bounces-409863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 803629C92A4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D2D1F231FD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6E41AA7B9;
	Thu, 14 Nov 2024 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AMtr3W7M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cbmtrnbi"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C6819340B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731613884; cv=fail; b=I7rjBtSYs3Bvu1VykCpeBAV4kfXvKn3d0vtsaTVm9ewoF9QkKFuTOFqVgZEb36opOMSoK/vS7TnYldMQaiXIIUj4wacCzcDuVc4GyofoH3516IR/Fc07/+7Kbji/52MOUwlK178L1/zCt8NOOF1RxdmcWGs9QunXDZCxL4/MvGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731613884; c=relaxed/simple;
	bh=arXNbkbZi2ERui0OobktsyB2EG1gLd5R/3Qj+VD9hKY=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qE5vo7CeJE2xTgmEq5X4K1laMUUrkc3EqnvdF7WeA56rc5bagv2/WUZhI9u03ZlTbC8x4nSZf8vdgCGghmbkAZdKol0VWFMBgP3IUiSRuWkj1MhqL8a3CoXcsqugljt0G7MLclXsq6zroLDwqvyHdbMsAEASN8P3jY4rHIYnLBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AMtr3W7M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cbmtrnbi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEJfkH1027107;
	Thu, 14 Nov 2024 19:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=g+Z+evSq99L/2cQY3F4ofRcEdum8v6i0WgFcnl/Hvlc=; b=
	AMtr3W7Mi1Jjy1vq7q7izzYnpUccCN4y3zyApNSpLxOXvVKNQQehqVmIBioJfmdG
	WZ08AuP+mqL+tWftoDxY9NOcY9dwLi2lRq8f+kjFwZILkq2R1o+5FENn4f+GPuGu
	cDUrPozb4mm5cJJP7fr3jOgn0psY0QXlCqAV/xWmHRwKO4m1FBicfkOtTf0fTHF4
	lPzDUXj5Z/6UySQ5nSNeR3pKllaCrH9JoBrgQjvLXGYjO6Z7Hh6Ipfp1EfQ/jndk
	dIz37YNaVGwmcO233ibpe2gaAERPqmKVZ3D/0uJ5ZsTA9C+AmFYtan4zV/HkgYJP
	V9jKpavJtT/ThaFpBon6Rw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0hesy26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 19:51:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEIgHkC022816;
	Thu, 14 Nov 2024 19:51:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42vuw1sd0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 19:51:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lt3SpcVOOdcfxnv2D/JWuP457bHBWO1JblYZsbE6O/792PP8hG1aO6BIQS+tR98hkq8P1mJ6sDKB7Y884C+v1+nVyAkFGhqvZ4rK8I4rdql6wdd6QMleRRhKOP5I7J0a8e5jGRnldyqSS59gQl6qmC2cEFzCNojcaQky0zpehF88Qb8aBgvbVOTR3S0zcKb8NjjbY54eJUpZQyG+IEXiX6AicBDMe4bgVNYKQlzAxgiQfV+8t2zAQMLv7EF8X0A8mybuxhvVf8FwS2lxsjv6nkKvEekdwxWjtRB1IrAWTbnchqGQUgISBei+RB0WLjK4N44wbXAtFVQraZ3UVCscSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+Z+evSq99L/2cQY3F4ofRcEdum8v6i0WgFcnl/Hvlc=;
 b=gk7WSHu5mzrQmHLxnaoGqGWLVc4Kslbu4PXf7VxME33Hqsq9f2FxgETi6/rpfyKvNA3kxjp2cSQIvBFzh+WtGHhdGwBO7m5j3uDaA/sdOGOPkJxMYCFx5qOVfnAh7rDSVpQ7FZbqwlCaw3y5I1ZHLS6iPSqTG2jMkKf4iYkIgG68M7lJ/pCTqiipLfFJVzhBlf6zOoQDVcgGpPtfLee0349euM1nD0tMLiopmBWZEvzqeL4ynyuLvqhquF2DbHiOWME7FHVuH+M8ttX/fIJpVtd6P1xgdbeZRy06j1bGX09NUyoWzmze3jQ8e72EbyEw1gWm2goCncKeUNdafs5Ymg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+Z+evSq99L/2cQY3F4ofRcEdum8v6i0WgFcnl/Hvlc=;
 b=cbmtrnbiPdExjRHyk5ibjKX60nbgLLZy8b3I95jy6euSFXtE2ir8SHOugRj9Xr6nEEN/4JMABlx9wzPBncVbvBNcAjLwPXnH9LK3fSv7P/QOCWUcrqthak8Bsczzty7MSBlBI2zVfwpLGp5Wsey9BIL821lZ/rR9HtkSJz3GA8k=
Received: from CY5PR10MB6011.namprd10.prod.outlook.com (2603:10b6:930:28::16)
 by IA1PR10MB6051.namprd10.prod.outlook.com (2603:10b6:208:388::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 19:51:00 +0000
Received: from CY5PR10MB6011.namprd10.prod.outlook.com
 ([fe80::3aca:a3f6:e92f:782e]) by CY5PR10MB6011.namprd10.prod.outlook.com
 ([fe80::3aca:a3f6:e92f:782e%3]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 19:51:00 +0000
Message-ID: <04208f27-44a6-4e64-a2a7-fc1233ebf736@oracle.com>
Date: Thu, 14 Nov 2024 14:50:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [REGRESSION] sched/fair: Add lag based placement
From: Joseph Salisbury <joseph.salisbury@oracle.com>
To: Phil Auld <pauld@redhat.com>
Cc: peterz@infradead.org, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        Steven Rostedt <rostedt@goodmis.org>, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <58289b1c-8a56-4607-8632-d36aef1fc5dd@oracle.com>
 <20241113181930.GD402105@pauld.westford.csb>
 <164634c5-32df-4542-9a5a-2b357e10a67e@oracle.com>
 <1c447727-92ed-416c-bca1-a7ca0974f0df@oracle.com>
Content-Language: en-US, en-AG
In-Reply-To: <1c447727-92ed-416c-bca1-a7ca0974f0df@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0226.apcprd06.prod.outlook.com
 (2603:1096:4:68::34) To CY5PR10MB6011.namprd10.prod.outlook.com
 (2603:10b6:930:28::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6011:EE_|IA1PR10MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: 222abb11-9f26-4835-b69f-08dd04e5a9f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0xmL0tRZytoL0xCU2ZWTXBJOExTTk1BTU50bXJSODBKNEdTazVxYk5uMHha?=
 =?utf-8?B?SG5iWi9CNk92bWh4WDlXKy9ZeFRuNEcwL1pDWUJ4aElyRUtZME5EYzA4Tkpp?=
 =?utf-8?B?SzJKcGtpUmg5MzdrME5Va2Rlb01ockpsTnZHT3RjelpVbnpKUzR5RGRzMDBC?=
 =?utf-8?B?RHlFR3RRLy9uRjRVVDRwVHE5Q0JKalZTQ0JrSVkvd2d4b2IreUJLMXpCU3R1?=
 =?utf-8?B?cHV4dGd0N0hsd3ZueXlvZjJaTjZFUlhmUE9zdTYyZ24rY1RWR2gwRmdjQ1Nz?=
 =?utf-8?B?eSs5QW9IQnJxTSs2ZENQcDhZVHJlTm9rSGtlaTh6M1QydFM5TjJzZkRlVnJz?=
 =?utf-8?B?aXZQdE9yMzVSMGdsTldhOU4wWVpLcVhnRURYVVJMWEdsUEQzTU51Tmw3SWVh?=
 =?utf-8?B?c1Q3MmtzUEM3bFU3SU8vZGlvVDg1ajdhSWFxcEF0dm5aR042R09YM215QXB4?=
 =?utf-8?B?Q01CRzdUTnBVK0dZZ21ibWZ3ZnhJUHB6c3U4L2ord09OZ1dsQWpleGE2OTVB?=
 =?utf-8?B?a1lFUWpSZVMzZlVKVlB3SE5ya3JxcUYxOE55dlQ3aU5FeEgrRmxOb01PNHVD?=
 =?utf-8?B?ZWdhRmRwdHJnZGhIbFpVbm1Qb3lLL05BUU1ERWt4c3JNQ1FpNGQ2bFFlUVZK?=
 =?utf-8?B?S2RTUm94di9IK0dOWWF6eEprWnNWUC9VR1lnMkdsWTgvUUIrWkNtV3VHWEZR?=
 =?utf-8?B?RGpkdjhDNDllMkNOR0pMVmFUVmNjTDNuMVU1RHZ6TWMzQkREWm1LcTEvZUVw?=
 =?utf-8?B?dm1WelNSUUxtcFBWM2ZQY1JNaWs3QTlGVDBqY3hKQlJWOHYvZ1lYUFZYcnE1?=
 =?utf-8?B?WWVkL0ZtMGszYWE4eUU1UTFZaGxmazRxNWdSakhOVFM4K1VVaG9SY3p1NzVK?=
 =?utf-8?B?UHNoOU1HeG51K2I5T1pleHJPeFZHU2o4QnA4eDJaOGllWS9jZlhVa3IzWUhj?=
 =?utf-8?B?cUhtUDkzUEMzeUI5RlB2Q3FvZ1NXczNja0h0a3MrOGhPalVrNUJsZEdYRlI1?=
 =?utf-8?B?NzFXUU1lSGk0N0NwWUljVFJoQWFiTE1jNnIrZTlJR3RBUTFlVUlBT3VkUm9H?=
 =?utf-8?B?TDZSMFk4bEtNckpxbUFtS1ZqNk14ZUZyMXdNQW1OTVJGaGtac014em9SNllw?=
 =?utf-8?B?OGlZdWwyUHFZYzdlTmdwRFJxalBXSWk0K0E0V3NOOVNjOGhiaGRYQjZhalpv?=
 =?utf-8?B?NkNTalFOTWxYTnpjQ3REMkxCaFlXMXpqbkhqMHE1elRVZVVMbHY2ak84Y1Z2?=
 =?utf-8?B?RHdoS1N2c3BBMVZTUFQzOWhtU1FPdU51cnJnOHc0RnJNZ1NuUGpPZ2VqL0d4?=
 =?utf-8?B?TDJUWlZYemU3MFZrSCsvOUNVbVJIK05ERndSRnoxNDBtdFQ0eHY1TnBFVGVx?=
 =?utf-8?B?SFhjQzNpaFpiUUdhTjZldTZCbGRJcUp4K2JvT0hDbk01K3lic081MTA5bDRQ?=
 =?utf-8?B?MVJvUmo0L1BzYkJMaVA2cStGblU5RG90NzdBeUxNY3Z0SXpPUDJaRGFyVzBj?=
 =?utf-8?B?Ly9jdmNPdG9BTDdhczZ2VTVlYnZvSksrcGxaMHdvV1U3dlU3dWFPWDNmK2F1?=
 =?utf-8?B?NW9HZldyT3ltQk1WVk5kQWhoNlJHTEMzYTI1RzhuUTlBdTJUWjR1VXMxVkZ5?=
 =?utf-8?B?clI0amtkNGJyNFUwM0x1Z0xYN2U5Y21TeFZ5TmZWV2Nrc09GVitwTk1ncExR?=
 =?utf-8?Q?f5ThlrLuNTvUxMPxTg20?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1F6cW00TjFDdSs5L1R3S1R5VU1Yalc2QUw1Z29xUy9adms0UFVFTDRXU3Jq?=
 =?utf-8?B?TTUrR2xqMVBETWE4clh6bjB0QTcvbnc4S2xOWVdyYzhZa09ERGFKR2krWGF4?=
 =?utf-8?B?UnFQMEpLYTVVTTFpRzlWSWw1bVBlSmk3RjlOMGgxaHJmVnNNc2VHRG5LR280?=
 =?utf-8?B?blZSYzd0b0ZnTHBjMzFDRkRmTHNlbWFUZk84NHQzaXFsR0ZMWGJHVDg1aU54?=
 =?utf-8?B?ekpBWXQyVXErNzVkcVFRYURRSlJjUW93L3ErNnZiZmYzWkptaUFENS9TQTBC?=
 =?utf-8?B?c2R6QkhqK2tNZS9SZmhaWm42MkljUzZZNk5nWjVIbDVOd1lNb1ZNVXJmQ2Rs?=
 =?utf-8?B?bjRGTHdOdE9JOFJXZS9NcjBOV2dUVldYbmtiKzBldFB0ZmJXaEVhU0JHdDJB?=
 =?utf-8?B?K0JhQzdCWjU1RmpTVGo4aWRRbTd5dm5OWCsyR0RQS0djS3RUcTJXSnFoaXhy?=
 =?utf-8?B?SjhHQ0prTkJlM2UwMXFtQ29PVThCcDNiWDRodCtoTUpVSGxKcllUYWppVXd4?=
 =?utf-8?B?WW1vYUU2UDJib1pwUlVFQTd2RGNFdGNwOGZDa2dtaVVsUU5kV3NyeFhLenhk?=
 =?utf-8?B?UjJIZDFiU1FZdmV3WExnZU1DR0w1akY0UTRJc2hnbHNZQk5CT0c3cXZjdjRt?=
 =?utf-8?B?WnZvb3Vqa3Q3MFhsYUFZS2FiNUk2WGtYUjlpTUJkbnlOUU9DUGRKOGlqY2xY?=
 =?utf-8?B?eGxIbmdaSEZ1ZGJlcXdwTFZrUGdXZFZRUU9XSDMrMFlVZDJUOWJlNVJYL0Rt?=
 =?utf-8?B?azV0ZFloN2dkbE5TWWwwdHFuaGJiNWhKM2dyNUhLTnJyTUxYdGtmbWdvbVpO?=
 =?utf-8?B?WktjaUJ1cFdNaUQzQi90MmN0MlNoMFlyNXcySldEclRjb05JNElRVGlDQUlN?=
 =?utf-8?B?R0RsV3NXVlJIYWFVeS9OdjFNOFlpMCtmMVhZWVlRaU84YnQ1U05oNVlFdlZK?=
 =?utf-8?B?NjkvQ1pTZHQ2N1RoZ1U0ZldNTVdJeWF3ckN3WUljenpFMm54VzVsYVVEWXpq?=
 =?utf-8?B?SzhGQ0R4ZG1SU1hHMGNQQ3pzb2xGM2x5aVIwc3RySDZUTjdZVGpYUDVaQS9j?=
 =?utf-8?B?TkhSRGNuMzZPc2g4SGJxSUFxcEJjWGlERmpQYVFHNE5HUVVmZkwyNWdBWEFk?=
 =?utf-8?B?cGRFc0dtWURXSlJVQUFLQys4UDZuNUJHU2dkTlhLZVVzZVpGL0VOeFRtTlJv?=
 =?utf-8?B?QmcxQWk3YUM0dTZiLzRNS0RidCtuSFljM1FkS0g3cGhMSzhhWUpXMTJtbG1V?=
 =?utf-8?B?MnYzMVUyVmJXZEVnNDNvaUVqRkhOSk1uOW52NVlWcmxEekVySFVOOERLdWdG?=
 =?utf-8?B?VVJwdDFpQzUyVXVBVTJoUkJnS1RYK3JEMmRzeEdZSjJibVNrekJpSFYvUjQr?=
 =?utf-8?B?clk0cjhnSUthQUlTYjRuanhXWThVL2haNDFLUjF4Kzk5K1pVTEtoc2dWNmR5?=
 =?utf-8?B?ODFFZEo1MzlRWWE3Q1lTOUpLTlFDMEVWeEVGRnlrZTZzOGpNNHlCSjFGWFNR?=
 =?utf-8?B?cTd6ellFVGVUWjIzOU1vcGYrSUY5eCtTbGMyMFZhSmhnbk1hS0I2QmZ6My95?=
 =?utf-8?B?THU0YzRUSGhwWWpHV0NuWnJ5bitYWUNrZkR4QzJuZlEycTduVG1DSkpIazM5?=
 =?utf-8?B?UmhWYUxwdmdYVFpLQ2ducUFhQ0RoZUVpMXo1SjBjOWJpb1pLSW1PNW1Cejd2?=
 =?utf-8?B?ZVlRTEVuc2plR1B4YUE5VVNHdXpLa2lvSUozVU1DMWtkVUJKcWlocUJ6dFRX?=
 =?utf-8?B?Zmpzbm15eXlsSnVKck0yMU9IS0RGUnpoYXEwR2xPU0Mrd2ROR0RRYTI3R1Fn?=
 =?utf-8?B?dU9YcGJzTEhTUWJDQ1o4K211NnZoVCtqbEIwZ0pLK09FWkZxbVRISVlzNkNo?=
 =?utf-8?B?ek9ld01EYTRRRW1aS2RsRDMweFg4alV4d0E4endTUUsyRnNVckNzd2xlTUc4?=
 =?utf-8?B?ZmFhcUQ4RlM1SXNUT2o0SEdkN2grVW04NnovRXY2dGFsRXNneEtWMGp5cFNH?=
 =?utf-8?B?bzhwK1RVSHpxcTlIZmVJdVY5ZldBdkNjaDNnVFdYTmVXbjdJaG1YVkEvRWti?=
 =?utf-8?B?eWVINDBjVDdpTStTVnBFU1lSak90NVdkdkZBaFhiSUU0eG03U3d5ajBtWUda?=
 =?utf-8?B?ZFd4L3MwMWdVMkpDSUczaTlabHg0N1A5VWR1YWM3MExZdXEzczdVSnM1VGNh?=
 =?utf-8?Q?+lZ1cP2Huj9R4s5Jj8EU46Y=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KesfVC+NYlexx3/H4lrwN0EiCjEZ+fiSaw90syVNjUEOhsUgavyF3v96wvU3ky1CY3iYdot6SRwGGoFNcgtzdGsvyRNbroBS34v9vX6RbnxgGFVSGu3CYu0+NxCu6x3CrA4IhH0OhxxmxEVkLNGgMmHsCz1GJGdYM+pJMzCw6Z7JWNG31DKJxCCtke8QIn4EzV9RK91FzDSdFJoFzLCKLAbIIjVScewR72cMu4osOt70Qb5ClGIm6GFpRp+V1AOxDoIfph62LL4+dsLYBJIsXITBwz1obT7ghRK9zhF+qQqtD4dD2WDnlXroj77I86YXtUtRXniN4p+YSTdDcaxmsoKb118Aa8dlDxWQLLVDgyXShG+TONo1pysy1+Ap52fuwtQa83qrgvovemx3ubY7W8bdBOkKNz0dUrdITYmS3rXIg0B0aH2P+FgzhF+5i+EsxgVh6NLM9/pw7clffpzAShfpsZwuDm/6/TIYRK6QTgWCwd0hacyH339e1TnIWZ3PMhywQFoNgAa0JZyOOHWj5l/jPHoIH5Umn/h2jMQMqp2VeM/KSw6s8vvMiNs6PEsqiw/yGAlgs1m3Yw0dnhcGt7wfoinzqMwFobB8Uzg6fU0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 222abb11-9f26-4835-b69f-08dd04e5a9f4
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 19:51:00.4689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ws/anZoJ37iOj33I1XotISwdTpu2PwXyY57/FLyKBmbSt+UyRhx+k38bAhpd59E+GSIPWh3J4c1N2LWSgbYqhj7crqkWJxcC2EjLSuhraBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6051
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411140155
X-Proofpoint-ORIG-GUID: 0MZMWR1iMeQAlciOjwxjfsnb3FvZmqBQ
X-Proofpoint-GUID: 0MZMWR1iMeQAlciOjwxjfsnb3FvZmqBQ




On 11/13/24 13:33, Joseph Salisbury wrote:
>
>
>
> On 11/13/24 13:22, Joseph Salisbury wrote:
>>
>>
>>
>> On 11/13/24 13:19, Phil Auld wrote:
>>> Hi,
>>>
>>> On Wed, Nov 13, 2024 at 01:03:00PM -0500 Joseph Salisbury wrote:
>>>> Hello,
>>>>
>>>> During performance testing, we found a regression of ~9% 
>>>> performance with
>>>> the TPCC benchmark.   This performance regression was introduced in
>>>> v6.6-rc1.  After a bisect, the following commit was identified as 
>>>> the cause
>>>> of the regression:
>>>>
>>>> 86bfbb7ce4f6 ("sched/fair: Add lag based placement")
>>>>
>>>> I was hoping to get some feedback from the scheduler folks. Do you 
>>>> think
>>>> gathering any additional data will help diagnose this issue? Are 
>>>> there any
>>>> tunable options that can changed to see how performance is affected?
>>>>
>>> You can try turning off the PLACE_LAG sched feature:
>>>
>>>      echo NO_PLACE_LAG > /sys/kernel/debug/sched/features
>>>
>>> It's not what I'd call a tunable but it would allow you to test w/o 
>>> it and
>>> see what it does.  It should allow you to switch back and forth 
>>> easily for
>>> testing.
>>>
>>>
>>> Cheers,
>>> Phil
>> Thanks so much for the suggestion, Phil!  I will give that a try and 
>> report the results.
We can confirm that using NO_PLACE_LAG adds back 5% of the performance 
that was lost.  However, we have not yet measured what effect this will 
have on other benchmarks.

We will continue testing and can help test the patches that add 
PLACE_LAG and RUN_TO_PARITY as sysctl options.
>>>
>>>> Thanks,
>>>>
>>>> Joe
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>
>>
> I just noticed this thread, which is probably related:
> https://urldefense.com/v3/__https://lore.kernel.org/lkml/ZxuujhhrJcoYOdMJ@BLRRASHENOY1.amd.com/T/__;!!ACWV5N9M2RV99hQ!MhxYsyXTgwxk1HIWrxUHGSEZcJyBENlm5apMv2TEqf6Tn2uoi14-V8YSTymPDvjax78DSQR4m6zdQiJwxJ89K8iTmWl4hvUQ$ 
>


