Return-Path: <linux-kernel+bounces-411116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D289CF342
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A33A28804E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB6B1D619D;
	Fri, 15 Nov 2024 17:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OydrwV6Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lngPrnER"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF9E1D5ABF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 17:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731692987; cv=fail; b=iBAt/iOzr+DeUEldoo10NZdvc1yeD0mbTSOgCj2jj9tzd9Mi/CR3AdKZ122B3YOq494no0kvUU/AmNZbwUR87XmF0yI7iBBbbm1ixBsQWhm6Htj5qjYGFfhcj5H2ZzlfVXxZBeaL/OreEXQBRduER537gPCVkLpQBg4Y0NUAqDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731692987; c=relaxed/simple;
	bh=VPts7YV4j+VO46UooSl819VdlN939NlwCgHTdDp0/jU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dfp8/VaCd16FZk4Fnb1JVrgbCNdjhnVLu5BK6x69ZcBy0PZK1q+ls/XxuZMa9ryAiWAIabcQxA8VddGXwRCL/0EGxISdzb/UEQ/9f6MllirSSvtgNPMOisIZSo47OAeKxEgVtu0K8ArETsW19VDjTZTa+x9MZJduz8CR+bB/MXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OydrwV6Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lngPrnER; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFGMw56006318;
	Fri, 15 Nov 2024 17:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=VPts7YV4j+VO46UooSl819VdlN939NlwCgHTdDp0/jU=; b=
	OydrwV6YKTdY8Hc/NURqMoVE9aNSNtWdMV/fUGP91Qlh7e2V7YIEJDrlJ4mcUDOu
	b1eobHLp3c6qGlVXN5CYXRL+VASYRWiR+4QEOntD7gEHTup3/Da8HFqARpsf2egV
	2oElmGB4dF4ycVNi5WD9zJtNOuV7J9bcdpkjSyhU7TR6EE4HkX3H698kKrp6APW3
	iScnI5ZQdnTrp7FZ3xBfpIbe8w+Z9tG8qsX4vxgFNuur2288yJZZ9ZtAFyMujczY
	VxZtDJ8QNyy9BcUJWZlp5pVTPRFHAKoeqdPi44RTGKCFYQRbY4MfhRv1ksgq8Sve
	7AkCtUh4dmvwt2hgOL1DeA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0heusf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 17:49:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFGHp9P022699;
	Fri, 15 Nov 2024 17:49:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42vuw2yqgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 17:49:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITECJDrigklLJY6DLKy24CU2XG/y4Cqo6qFfV8WF6y6rMd1gkKgZCIgxecqv5jfm+yUP57tvMJ11mUoL2wB6yVcq33csjedRVIUv5/keB2rNghr/2Fdhd0XVBoWA2F6ReocqVGJVmmtGOaD+gzY1R72Me0uT2zhmFUVzBg40c55DeiXYsBZArYG6GBiYpKtHg3bP4snUaWy2L7GTSwEnUinYz8rMxmPihbMMW4hRF344zAoEk6Gk1aIWGvkS+CIqdMlqWSVjVn3HjV2ELfAtiYy6fdcARwHBxy5lItym+gtKg0rNE74MrzEa28jdxYtTwJtuy/R94wJurSeZNwNQiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPts7YV4j+VO46UooSl819VdlN939NlwCgHTdDp0/jU=;
 b=chwBtX043Q7hGq+naIMKYNQdFjLqzNVEqVF8E8IidNPZdtQa0tsf4puuTZxmdG4g6IXsHIV8me/UyGE4FBudjRgP8qqyC3XbfzTSesw4wLqvtja9lkMvuew6tOUpSYXarTKFXlh8wyJH7Iua6AWSyEW2V5X/6gMbJvON4NCnzIOaewNYUauUge/UGO0Jmr4LCGMvIuT6Zy1KcfFnad+aD0CsauTt+iQQv4l/O3ghRRaDlrKKLlU3yV9ILWf3wIE2upWgJHfD/VaZh548pmze5a4JAY9TLiL9AHrKA+gzd3rdW5Bjas3lbIxOtO+gM95ePo3Oj/lNTig4f4ZmPYri0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPts7YV4j+VO46UooSl819VdlN939NlwCgHTdDp0/jU=;
 b=lngPrnERHbUsxQ2Be+tj4hyrVFLFGn4egL5csBGgXiO7tvQgoJREA2ezhtbxjVLwXoZ5dFs04ONy8pYwaWLEH0ISu9MNh3L4UlWz0kwzJF2nn6VN9E2YyLs6NK6MHJwkOsAJdQYwgwWG2OZUz71r1JBNeyAtk2/cgy07zHodmD4=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by DS7PR10MB7297.namprd10.prod.outlook.com (2603:10b6:8:d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 17:49:31 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a%2]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 17:49:29 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Daniel Jordan
	<daniel.m.jordan@oracle.com>
Subject: Re: [RFC PATCH 0/4] Scheduler time slice extension
Thread-Topic: [RFC PATCH 0/4] Scheduler time slice extension
Thread-Index: AQHbNV85xP8mG8bGMUONwn7IqXYau7K1jv+AgAANEACAAPVMgIAB3O8AgAA0WgA=
Date: Fri, 15 Nov 2024 17:49:29 +0000
Message-ID: <71164940-E45A-4572-9F8D-4CE7189514E4@oracle.com>
References: <20241113000126.967713-1-prakash.sangappa@oracle.com>
 <20241113185013.GA22571@noisy.programming.kicks-ass.net>
 <f0f681a0-22b4-45f4-85a1-18f140286cbe@efficios.com>
 <20241114101455.GL6497@noisy.programming.kicks-ass.net>
 <939a3bba-9e9e-4eb9-8040-e1447718b341@efficios.com>
In-Reply-To: <939a3bba-9e9e-4eb9-8040-e1447718b341@efficios.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|DS7PR10MB7297:EE_
x-ms-office365-filtering-correlation-id: d36abb74-b3ca-430b-6a2a-08dd059dda99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cGcvS3NPV1JDQmxCL2N6YWVxVjRhWFcxYitXaHZCcG1WVTVoYmVhcWxuanM5?=
 =?utf-8?B?ZmhYUHlRUGFXY0hoNlJpUlluZk9rZUhpQmRHRE9ORlBrNlY0bVNoV2l0dUJB?=
 =?utf-8?B?WFFLTS9QL3dIUlNuWmhBaUxKYzBMVUpkeG5MNVBDZzQwSGpqc1FmT0htVCtJ?=
 =?utf-8?B?VmFUWHFlNmxCYzl4TjlEZG91RHJTV1dYRVBrMnJMWWpSVWIzdDNkUFdIa2dV?=
 =?utf-8?B?a29PdUg5djFWL3hLSlVhdlc5bnZOVW5wRU9VRks3cUg3ZzhhL3RxZm9pekNQ?=
 =?utf-8?B?UTRISkRPa0UxWHlhM1MvQWVTSENDM3QxNGIvbkVqck9VRnlKOUpRQ0MvdlRW?=
 =?utf-8?B?djJmb0ptdm9nditlT2NZT251d0VQYXZHeU5sVGNmSXB6WmJHTG9SalNCOWNY?=
 =?utf-8?B?QU5nZnFwK2RkTzlnZXFHSGxqRVdqdWtKUTJqd1ZUTXJJbkdaM0VoTE1yTWRy?=
 =?utf-8?B?UFhjYVEyUzM3Rm9BZFgrZmpFZ0puOEdWWVQ4bTVFZHpRYTZkMU9oM3VBQ2wy?=
 =?utf-8?B?ZWlERlBnN3BDZThic0o3Y3FiQ1VlS25rV1RxTXZWMGxCZ0czNnp4SVBmcUE0?=
 =?utf-8?B?d2ViaTJOY255ajBkZGlsRkptM1NlbzRPcHVZWm9PdHVhdEFDLzVMTE1oOHlH?=
 =?utf-8?B?NExlVTFRcHMwYWhjUjh5NDRNd3JJVzdIT2RZUHlmb01XNlRsUnIxYVFONWwz?=
 =?utf-8?B?ck44TVBuUHhkeWhmOHNWczk3bjZZZWhieitobGkwRVZhWjZCcEJxdUZySGls?=
 =?utf-8?B?ZnYrSWp1VytkUmozRml2cTBON1VjT3dHTjM5NzE0YVltS1ZKUDlpVkY5Y3lK?=
 =?utf-8?B?aHpIMkpIYk1zeDFIckNab0JFR0M5ZDlScXV3MkpRcnZTR3ZjNnMwRUtNQVhX?=
 =?utf-8?B?bEJoTFV1azVpNTY1WXY2NDBOVzhkTkRGS3dLSTVxRzBhNkdWc1NvNEhkakI3?=
 =?utf-8?B?dzhYdEdMSDM3ZFlPK283NjVwVGNuWFlWTjlFY3FpZW03TzdHTEJaWDA2NVVj?=
 =?utf-8?B?TnQwV3pvM1NNQjZOOUF0bi9lSnZBUmhPRk5Hb1VZM2p4cHhxU3NuVXdzZ1Rk?=
 =?utf-8?B?b0ZmWWpGME1EMkFpelNoMzVDdDFnUjU5cG02NzMzTnJpN3NUbTBRVW5yd2JL?=
 =?utf-8?B?R251VUNZUlFJU1ArYW5WMkJ6NDhNSEVFcDUxSWVad0VXSmo4blRYQTgzc3Z6?=
 =?utf-8?B?aERKeG84VTdZeS9PUTcrc0ZUQWJ1c1JJQ2tIb2pKNFlnMGwyZDJUSkRjNTEw?=
 =?utf-8?B?R3k0TnM0UWlhTm1UQmptWk5ueFJWL0Y0bzBZTWc3aXA2encyZzE2Q2RkekFN?=
 =?utf-8?B?MkIyY2NZSXQxdStLZVdlYmFDSmx5TWsrMHkrQll2U0x1TlNRSTFNWnpuOHB5?=
 =?utf-8?B?SncvZGNDNXRTTjVOc1BoTlJzcW1PVXpoT2pOYlpZV2VjNjFTUXdyZU93dXJZ?=
 =?utf-8?B?UHFBL2g4L3ZDWFZnTDdCR04rT2x0STVQNzJkdFBwUndZYlVzOWRaZkhRaGgy?=
 =?utf-8?B?ekxUaDZmM0xtWXJaZm9nYVYycmRHWG1Nb2JNQncyVGhaSUtOZTBGdjhvZWdO?=
 =?utf-8?B?am1QNjI3ZXFKK3RvNXM0RDJ2OHh6VjlWUzJFY0RIYVI4SkIrYXcvbjUzL3Ay?=
 =?utf-8?B?c3B1aEdMQ1AvYnpVMXFlUVY0TmVVK3hCSXBQb0lWUlNwNzMvQU5pR3BtSE9i?=
 =?utf-8?B?L1pPVlZqNFFTS2xHSkIybE0yM1o3QW1Rc0ZRS2RCcXZoNjl0T0tTRTVISGM2?=
 =?utf-8?Q?vUxdkY0mPE1RAriA9oGmkrIidRx+aFd6ceSl48G?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L0x5QjUxUUFFY1VMWkxnbG1zd2J6V3pNb2VFRzBSMzYwNkdTQXJCYStwL2hs?=
 =?utf-8?B?anhQMGc5VUIwSy9WS3Y1VXNSWldvbW1MWjFTTityR004cC9lZVdVTCtSRm5O?=
 =?utf-8?B?NzBNZDM1MHN4T0NTRjlDbGwyZGhFS3RWZHpJRmxxUWpUZVVnZVVGbVg0Y2o4?=
 =?utf-8?B?SElNcXVOU0s3SFRjWnRQWm9uMldwUFZLOHMvc1JpeXNrZTBwN2ZWVWV0bTNw?=
 =?utf-8?B?QWdGRk9tdk8yTnE5NEtBTi9HUmhyUUpFc1U4UG9GaWw2Umw1SVN6QkFJSkNi?=
 =?utf-8?B?WEJQV3FseVhkZzc2bTNvQ1JVUEVQMjRNUFg0RnV3RnFoMklUblByNXlzSWEz?=
 =?utf-8?B?Y2lRM2xsTkNHREtYZDNHTGVwUjBQWlhzM21jQmlyTjg0eWhlUmFaTC8zTys5?=
 =?utf-8?B?NzhNRkRpR3crUHRsSFNsTmpwQkZEN0FweUs4aXFrMk9mWjlhSGxoM1l3VzNH?=
 =?utf-8?B?dzJRRzJBNkhhRkZ3NXRwKzZFYWZTdWNKTUY4LzlHVDBOZU1SK1VPMGMwbXNI?=
 =?utf-8?B?MmNuOXdMNjZWVHlnWndoTzY2YSs1ZHErR3hCcWhRZHdtVjlWTjgwTWtGS3RP?=
 =?utf-8?B?ZjZ5Y2ZlVkpDQTYzc0dvYXBsY0paUjVwWk10VXZ2b1N6UDczNFpYeTM1SHlx?=
 =?utf-8?B?YXJEWms0RUNPeUx0VWpvZFNTN0tNWVkwcEI0TTRaTzRTR1pBVDl5dDMrWDNo?=
 =?utf-8?B?Q0xJMGNTV1FXeUMraHlYZzJRK1NZdFUyZHVaZkVxVlc2ZG1pVDVmTndVNms3?=
 =?utf-8?B?L0gxTmcrYWZIZmhCTlh1RVp1RHFBY2paRjlHa0JDL0NQdVRuamI2b2I3Rklw?=
 =?utf-8?B?QVViZmtjUjgvWG9abUp2UVJzaW5MeWp6NEhCZGRFU0J2eFVMajBBWjdrcmNl?=
 =?utf-8?B?cHVSV3ZFL3pSTHMwUU1qdTVIb002MjBabjZKM0dTNW9JNWxqblBXbXJHYzhZ?=
 =?utf-8?B?UEpRQXE5Mkt5TkN4dHFMeGYrS29id01qSDg4VUFkRndaK2RSZmhpNk8rUHdq?=
 =?utf-8?B?SFFZczdOUlFUbENhSHUwSnZ4OUhkSTRnZ1o0SHF0QUd2QS8veEwrMUNFQUdt?=
 =?utf-8?B?OWJVTTI1bzF0TTYvYnpQbE5QTXZaajFuQWR0S0cwNjNjOXVMTEVFRkVxdEcv?=
 =?utf-8?B?NEo3ZTUyS3ByV055eW5vZ3RCTSsrd2JGTmtMakRRbmFwcWcwUjdsM0R3MXpp?=
 =?utf-8?B?ZVJsSm10YW5yeE04Q09jYUNBK0ZmNmVFM3JoYjNRVENEN3R1MzViR0RoQjFX?=
 =?utf-8?B?SmNwR05qTUpZU08xcHJFTWVidzF6QUVwSDNTY0k0bFc3T2FQcExtd1hDUzM4?=
 =?utf-8?B?QkJQZ0xyVzM3MFZBREJ6ZFVxb0kyR2VKYWNaakZsWE96b1BTMGc1MzBsZE1W?=
 =?utf-8?B?WHJLNVZoTDErakI0dHg0dmlwN1p0dWE5SXJ1RktmSURhWjlid2RibE1Jc28w?=
 =?utf-8?B?Uk1ybXZ0RHhySndqTVY5L1BnMXdiTkpTQ3ZualpFcDJNTXlNTlJWL2ppQlRR?=
 =?utf-8?B?aDVqWnhsM3g4UEZjVFB2T3JzWGFIT2FlU0R4RmNzUnd4bHlkSDBuNENQNzlV?=
 =?utf-8?B?VDJHL0ViRUgrQWxrTEUrWVpUNGV5VjJMeWlJMFlCRHJVeXVRSjRLVG9qcVhD?=
 =?utf-8?B?SjZrSFdXZlc3c0xVMmNWYm82NEZRYklxM0k5NC9aSnRPQnpnK3gyK2llckxm?=
 =?utf-8?B?bmJBNjZBdElOcnBTVG1sNkNYRHZRNnU0Y0JWZzlOcUdQb2gybU1JMGpCYjVF?=
 =?utf-8?B?VXU1NnltdmhEeEV1N3pBQW01dmplSENFVlkxaU1aSmxNcGhpQXJpZjBZZnAw?=
 =?utf-8?B?OW1vMWU0WnJmYW92NFdyKzNMYmZhUFFjZWdjYU9VWk4veGxSZlBtc2loL1Rq?=
 =?utf-8?B?QVZXeHd1QzNwcVB5blA0by9Zd0JoNzdrVVBxVktRV1pVMnpKcW1NQis2S0ZW?=
 =?utf-8?B?RlB3a0FaU2NXMGoxTnFwSnZ1R0xBTFJFOWMzeGVUNUtmUFFOSVludWFyTzZE?=
 =?utf-8?B?ZWNQSmFQc00vWi9aRzdIQ1hRRkRnZExpTlZMNG85SFliRGwvcCtYRTFldUdW?=
 =?utf-8?B?NVNSclJnVVAxdkh3RmlES0t2ZUZoWVREc3o2c3RnK2VlT0FHd3hzWXl4bExK?=
 =?utf-8?B?cmh2N1Avcy9lS2xoeWpPTElUTXZNZmhrMEdCQTdpYlBQM0ZrdmZXb2FDcmxS?=
 =?utf-8?Q?m+AmBP5oMjJvmwnRnNpT8NPuhwvqRh2QkWM1c3ubTkyG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A45B15849C21841A510C577335A93D3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oP2Ziy5FjLCoUJWd0d9z5HqaLJrvBTe3hkPZlpZl6mlIVyIWOgPD424mOXYeE0NHb0fS6tgFbe2h9dBldgzpUeUGpIsLKsfVC1mgvSgDQq+tYqp8DsTxv/6kEqu+Swqz5BPRhxWGI24byqkXQKDu/evDm69F1GhGNhmTdLnrRDEC9FIRavt17g81sO0yO7OvPn95CvIz8NZK6WjGRm7fwEei7lWWkQ1nMdDMmHQGurCiu2AqX9nyR4uRk+NmrN/iux7/eQ/Zbvjrf6mJMZoBBW1m+3qXg6rPQLamS2PYIuLwQ7s3u9A7Y5xgqPKMnkgJndySIYavvPS+y0y82HrkUvtunpopFP7budqJcctwiNUGqvMmxB5H6vGbbX5GlGaSF7eJDrsDQ0sOlty3wAaM1klWB2G6M0Rwn/o5b6SHFP7aY5FRkGVuPTdBoRpPSMnff1Pg5MddeAsLAnlURtkweKxq5ep7Pk+HoTHonQeGo4bXsbUj3AH2hkYf7vo+Gcb2uLoS50zoQgWoXpOKV7M7T/9Jr0RP214pXKSQz+qrAtvVtcBT0i2LKgXgl2EcZWdcHSLg85hcrImd1Vhq8rGlGJoSRH9+A3K4zOPbBUOCwI0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d36abb74-b3ca-430b-6a2a-08dd059dda99
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 17:49:29.1713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xSyPo74qYTDgTkN5JL82S+mBtiIRPhW8NOKOO793w5pjMPcDFE0yMg0VXHQceC6NgPKQzZzbNO1tqbD18fqmxwOwwJ65KwQM9QLP6q7MKH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7297
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-15_04,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150150
X-Proofpoint-ORIG-GUID: ht0xUWt6oYfYL8EN02OWnmZCG9qG5vVp
X-Proofpoint-GUID: ht0xUWt6oYfYL8EN02OWnmZCG9qG5vVp

DQoNCj4gT24gTm92IDE1LCAyMDI0LCBhdCA2OjQx4oCvQU0sIE1hdGhpZXUgRGVzbm95ZXJzIDxt
YXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+IHdyb3RlOg0KPiANCj4gT24gMjAyNC0xMS0x
NCAwNToxNCwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+PiBPbiBXZWQsIE5vdiAxMywgMjAyNCBh
dCAwMjozNjo1OFBNIC0wNTAwLCBNYXRoaWV1IERlc25veWVycyB3cm90ZToNCj4+PiBPbiAyMDI0
LTExLTEzIDEzOjUwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4+Pj4gT24gV2VkLCBOb3YgMTMs
IDIwMjQgYXQgMTI6MDE6MjJBTSArMDAwMCwgUHJha2FzaCBTYW5nYXBwYSB3cm90ZToNCj4+Pj4g
DQo+Pj4+PiBUaGlzIHBhdGNoIHNldCBpbXBsZW1lbnRzIHRoZSBhYm92ZSBtZW50aW9uZWQgNTB1
cyBleHRlbnNpb24gdGltZSBhcyBwb3N0ZWQNCj4+Pj4+IGJ5IFBldGVyLiBCdXQgaW5zdGVhZCBv
ZiB1c2luZyByZXN0YXJ0YWJsZSBzZXF1ZW5jZXMgYXMgQVBJIHRvIHNldCB0aGUgZmxhZw0KPj4+
Pj4gdG8gcmVxdWVzdCB0aGUgZXh0ZW5zaW9uLCB0aGlzIHBhdGNoIHByb3Bvc2VzIGEgbmV3IEFQ
SSB3aXRoIHVzZSBvZiBhIHBlcg0KPj4+Pj4gdGhyZWFkIHNoYXJlZCBzdHJ1Y3R1cmUgaW1wbGVt
ZW50YXRpb24gZGVzY3JpYmVkIGJlbG93LiBUaGlzIHNoYXJlZCBzdHJ1Y3R1cmUNCj4+Pj4+IGlz
IGFjY2Vzc2libGUgaW4gYm90aCB1c2VycyBwYWNlIGFuZCBrZXJuZWwuIFRoZSB1c2VyIHRocmVh
ZCB3aWxsIHNldCB0aGUNCj4+Pj4+IGZsYWcgaW4gdGhpcyBzaGFyZWQgc3RydWN0dXJlIHRvIHJl
cXVlc3QgZXhlY3V0aW9uIHRpbWUgZXh0ZW5zaW9uLg0KPj4+PiANCj4+Pj4gQnV0IHdoeSAtLSB3
ZSBhbHJlYWR5IGhhdmUgcnNlcSwgZ2xpYmMgdXNlcyBpdCBieSBkZWZhdWx0LiBXaHkgYWRkIHll
dA0KPj4+PiBhbm90aGVyIHRoaW5nPw0KPj4+IA0KPj4+IEluZGVlZCwgd2hhdCBJJ20gbm90IHNl
ZWluZyBpbiB0aGlzIFJGQyBwYXRjaCBzZXJpZXMgY292ZXIgbGV0dGVyIGlzIGFuDQo+Pj4gZXhw
bGFuYXRpb24gdGhhdCBqdXN0aWZpZXMgYWRkaW5nIHlldCBhbm90aGVyIHBlci10aHJlYWQgbWVt
b3J5IGFyZWENCj4+PiBzaGFyZWQgYmV0d2VlbiBrZXJuZWwgYW5kIHVzZXJzcGFjZSB3aGVuIHdl
IGhhdmUgZXh0ZW5zaWJsZSByc2VxDQo+Pj4gYWxyZWFkeS4NCj4+PiANCj4+PiBQZXRlciwgd2Fz
IHRoZXJlIGFueXRoaW5nIGZ1bmRhbWVudGFsbHkgd3Jvbmcgd2l0aCB5b3VyIGFwcHJvYWNoIGJh
c2VkDQo+Pj4gb24gcnNlcSA/IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMzEwMzAx
MzI5NDkuR0EzODEyM0Bub2lzeS5wcm9ncmFtbWluZy5raWNrcy1hc3MubmV0DQo+PiBOb3QgdGhh
dCBJIGNhbiByZW1lbWJlciwgYnV0IGl0J3MgYSBsb25nIHRpbWUgYWdvIDotKQ0KPj4+IFRoZSBt
YWluIHRoaW5nIEkgd29uZGVyIGlzIHdoZXRoZXIgbG9hZGluZyB0aGUgcnNlcSBkZWxheSByZXNj
aGVkIGZsYWcNCj4+PiBvbiByZXR1cm4gdG8gdXNlcnNwYWNlIGlzIHRvbyBsYXRlIGluIHlvdXIg
cGF0Y2guDQo+PiBUb28gbGF0ZSBob3c/IEl0IG9ubHkgbG9hZHMgaXQgYXQgdGhlIHBvaW50IHdl
IHdvdWxkJ3ZlIGNhbGxlZA0KPj4gc2NoZWR1bGUoKSAtLSBubyBwb2ludCBpbiBsb29raW5nIGF0
IGl0IG90aGVyd2lzZSwgcmlnaHQ/DQo+IA0KPiBbLi4uXQ0KPiANCj4gRm9yIHRoZSBzcGVjaWZp
YyByZXR1cm4tdG8tdXNlcnNwYWNlIHBhdGgsIEkgdGhpbmsgd2hlcmUgeW91J3ZlIHBsYWNlZA0K
PiB0aGUgZGVsYXktcmVzY2hlZCBmbGFnIGNoZWNrIGlzIGZpbmUuDQo+IA0KPiBJJ20gY29uY2Vy
bmVkIGFib3V0IG90aGVyIGNvZGUgcGF0aHMgdGhhdCBpbnZva2Ugc2NoZWR1bGUoKSBiZXNpZGVz
DQo+IHJldHVybi10by11c2Vyc3BhY2UuIEZvciBpbnN0YW5jZToNCj4gDQo+IHJhd19pcnFlbnRy
eV9leGl0X2NvbmRfcmVzY2hlZCgpOg0KPiANCj4gICAgICAgIGlmICghcHJlZW1wdF9jb3VudCgp
KSB7DQo+IFsuLi5dDQo+ICAgICAgICAgICAgICAgIGlmIChuZWVkX3Jlc2NoZWQoKSkNCj4gICAg
ICAgICAgICAgICAgICAgICAgICBwcmVlbXB0X3NjaGVkdWxlX2lycSgpOw0KPiAgICAgICAgfQ0K
PiANCj4gQUZBSVUsIHRoaXMgY291bGQgYmUgdHJpZ2dlcmVkIGJ5IGFuIGludGVycnVwdCBoYW5k
bGVyIGV4aXQgd2hlbiBuZXN0ZWQNCj4gb3ZlciBhIHBhZ2UgZmF1bHQgaGFuZGxlciwgZXhjZXB0
aW9uIGhhbmRsZXIsIG9yIHN5c3RlbSBjYWxsLg0KPiANCj4gV2UgbWF5IGRlY2lkZSB0aGF0IHdl
IGNhbm5vdCBjYXJlIGxlc3MgYWJvdXQgdGhvc2Ugc2NlbmFyaW9zLCBhbmQganVzdA0KPiBpZ25v
cmUgdGhlIGRlbGF5LXJlc2NoZWQgZmxhZywgYnV0IGl0J3MgcmVsZXZhbnQgdG8gdGFrZSB0aG9z
ZSBpbnRvDQo+IGNvbnNpZGVyYXRpb24gYW5kIGNsZWFybHkgZG9jdW1lbnQgdGhlIHJhdGlvbmFs
ZSBiZWhpbmQgb3VyIGRlY2lzaW9uLg0KDQpEb27igJl0IHRoaW5rIHRoZSBkZWxheS1yZXNjaGVk
IHdpbGwgYWRkcmVzcyBhbGwgc2NlbmFyaW9zIHdoZXJlIHByZWVtcHRpb24gY2FuIA0Kb2NjdXIg
d2hlbiBpbiBjcml0aWNhbCBzZWN0aW9uLiAgV2UgY291bGQgYWltIHRvIGFkZHJlc3MgZnJlcXVl
bnQgcGF0aHMgd2hlcmUNCmEgdGFzayBjYW4gZ2V0IHByZWVtcHRlZC4gIEluaXRpYWxseSB0aGUg
aW50ZW50IHdhcyB0byBwcmV2ZW50IHByZWVtcHRpb24gbWFpbmx5DQphdCB0aGUgZW5kIG9mIHRp
bWUgc2xpY2UsIGlmIHRoZSB0aHJlYWQgaXMgaW4gYSBjcml0aWNhbCBzZWN0aW9uIGluIHRoZSB1
c2VyIHNwYWNlIGFuZCANCmhhcyByZXF1ZXN0ZWQgZGVsYXlpbmcgcmVzY2hlZHVsZS4uIA0KDQpB
bm90aGVyIHBhdGggdG8gY29uc2lkZXIgaXMgdGhlIHdha2V1cHMgb2NjdXJyaW5nIG9uIGEgZGlm
ZmVyZW50IGNwdSB3aGljaCBjb3VsZCANCmVucXVldWUgIGEgdGhyZWFkIGFuZCBhdHRlbXB0IHRv
IHByZWVtcHQgdGhpcyB0aHJlYWQgd2hlbiBpdCBpcyBydW5uaW5nIGluIHRoZQ0KY3JpdGljYWwg
c2VjdGlvbi4gU2hvdWxkIGl0IGNoZWNrIGlmIHRoZSB0aHJlYWQgcnVubmluZyBoYXMgYmVlbiBn
cmFudGVkIGV4dHJhIHRpbWUgDQppLmUgdGhlIOKAmHRhc2tzaHJkX3NjaGVkX2RlbGF54oCZIGhh
cyBiZWVuIHNldCBmb3IgdGhlIHJ1bm5pbmcgdGhyZWFkLCBhdm9pZCBzZXR0aW5nIA0KVElGX05F
RURfUkVTQ0hFRCBpbiByZXNjaGVkX2N1cnIoKSBhbmQgc2VuZGluZyBJUEksIGllIGxpa2UgbGF6
eSBwcmVlbXB0aW9uPyANCklmIOKAmXRhc2tzaHJkX3NjaGVkX2RlbGF54oCZIGhhcyBiZWVuIHNl
dCB3ZSBrbm93IGl0IHdpbGwgZ2V0IHByZWVtcHRlZCAgZHVlIHRvIHRoZSANCnRpbWVyIHNvb24s
IG9yIHRoZSB0YXNrIHdvdWxkIHNjaGVkX3lpZWxkKGlmIGl0IGlzIGEgd2VsbCBiZWhhdmluZyBh
cHBsaWNhdGlvbikuDQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+IE1hdGhpZXUNCj4gDQo+IC0tIA0K
PiBNYXRoaWV1IERlc25veWVycw0KPiBFZmZpY2lPUyBJbmMuDQo+IGh0dHBzOi8vd3d3LmVmZmlj
aW9zLmNvbQ0KPiANCg0K

