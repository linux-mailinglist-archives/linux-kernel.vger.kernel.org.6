Return-Path: <linux-kernel+bounces-423038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2A89DA1BA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 06:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8351B22196
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 05:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60A9126C04;
	Wed, 27 Nov 2024 05:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PxYVTXwy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R2RU7us3"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECEE28E8
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 05:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732685758; cv=fail; b=ADpsyIyl7zwDGht6gXKyfKWjaPfnrWq4d8ppgVFp1fiaF+cfBuWwUWZMka+eq2VnbeSdBdQdSz9KNpjN2XXE+qayO/fAAC48eWwwVqf7dXo6Hd81+ML3QRLg6qv/d+YRb4+Jx/mXXaso3urY/hHrD/Cx3OIJ6IRgP6M/ZjLAyZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732685758; c=relaxed/simple;
	bh=WVM0aU7KAMabnYUy+2jziMmndgv0VJTZy9FMwCZ3R10=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=ukJciHPRjm/L9rZcPNLkCk7sXTafOqAFoNornpBFAS7qMGPH5T8F+ycO1J117o6Ti4PDxxpLCweOu5aSlp/KXQCTyJ4KiAkrb1LgZvWKK8odCDiHUWjkLv9fpyZen3eT/Hj7G/r4jlacsI3V5vPTfKeYbToNLMKp2FWlh4LZ/P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PxYVTXwy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R2RU7us3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR0fbd8012315;
	Wed, 27 Nov 2024 05:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=3Qc1ssg2SQ+FRGjo5ld5i9WVDkCDfeZqANzGSsR3tE0=; b=
	PxYVTXwyASFJ5WeoO4K9hRqseex+qYe4czZe3CcUo1iJraEqK62W67fmFyfR8+Nm
	1cIRANhUaKgBclB//n8HCo5xbwzwurzgylKdUvzwSuUmnkgQlXQgA/vg8Wqu1bmI
	77lwft4/D3sx565NJFG9zzdABcn95uIoD59BD8x5m39lKNJClRuEmxMqnP/J4hVG
	fQz1b4gBfn01UYssooSdnoKdk5nP+v5nrt/CuVnfBmWfinPpf/utOX3jXgV/gJ7y
	/hqL04KQbFQSq3ym0f85jjkSikwLB20G0H58w/QBXiGljMTH77h91ErAuNLHOMBr
	C87gyQStv8yK46dmJH8EyQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43385uq44u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 05:35:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR41N5P002762;
	Wed, 27 Nov 2024 05:35:10 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4335ga8dps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 05:35:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ED7vTpYqcqIgAczT+ZIc+lB9fbFNMR+txAxTz98KO1ll5w5ejUP95qJ7ctPm2eptr5dgc7Fyfd/ePfx3wCMaQeM/fO3FNegQo+4r1cFTHbXBETqe9VVLyojVTxnnGtBTX/9NGFG+mlEU+G355TldVrwC6IVAIqxAF/rIzvDmL3O0dTWMVfq/ujctZigXLgWj7lcrBNm8xTkB0X5+JcFj/F3ziGcWbEMSMA8jm3DEBcmL/jbKTVK+ZqxOwjJ1GGCTrU4a6UazuEV32VWGHrSFhCQRCI1Qnulxx1B96KS4oaL0zbLdOlyY+XUgi5d/JRNb9g47NeJVGoMf743GHOyELQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Qc1ssg2SQ+FRGjo5ld5i9WVDkCDfeZqANzGSsR3tE0=;
 b=Y1+eVDzVxaUqPIixFbGZ//s0gZQWt74IkOWNDHr81qxvTf2D/zQyWGvtdtrJY4bhLNnnsIPjbqCoEhMeld8vscNwj7kJ8nzJmF1++eW0a0PdWLjiXi10JQ7DjjN5d9I3Jm5qa42Gt6q9izl0H/UMjs1GmgsoeVVAMIeHH3d5Z/U28lT1ObOcXQmGvSLDKlFbTfWUbYy8q2HrvlTaHGr+yOrtdpVbO+45VQaBmXeTsSRFapeK92BKimsO0wPHwo4jqV0zi80faD78NI9eghpZE6IpdRymFPYxBuNX+UUn0o5UgfGNXmG3cjJ6Uc6UawJk2FLBsZguhO6ZYwierl/NQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Qc1ssg2SQ+FRGjo5ld5i9WVDkCDfeZqANzGSsR3tE0=;
 b=R2RU7us3j0aa7CEtmSgiY7Im+Qy5txvJTJGGoTtYzLoRX7mKhILD2dLhZHkWFYbLhUqyg0Et6iu5ZIGdYtweT5lfDaUhyMQY2i/aRaEUAW6bHRngK/r/kr3K7lbUAQTB12UuHDYvdmkKWLkAOcxCJ2rXqWNmMAGMwqbl/YX+8f4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SN7PR10MB6595.namprd10.prod.outlook.com (2603:10b6:806:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Wed, 27 Nov
 2024 05:35:06 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%3]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 05:35:06 +0000
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
 <20241106201758.428310-4-ankur.a.arora@oracle.com>
 <ZzTGQ_zTS8NrxjW9@localhost.localdomain> <87serfgffs.fsf@oracle.com>
 <Z0Xf37hJiyA7O0Ye@localhost.localdomain>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, efault@gmx.de, sshegde@linux.ibm.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH v2 3/6] rcu: limit PREEMPT_RCU configurations
In-reply-to: <Z0Xf37hJiyA7O0Ye@localhost.localdomain>
Date: Tue, 26 Nov 2024 21:35:04 -0800
Message-ID: <87zfllfddj.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW4P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::18) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SN7PR10MB6595:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b337a2-6344-4c8c-4aa8-08dd0ea54036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUVLZ2ZvTmdBamR5cFFLV1R4MVVqYkdYQno3K1pSTHQ2YWtoQ0xEcExiMGky?=
 =?utf-8?B?djNvN0Q0RzlqSnp6OHo4cmRCOUFRYThHVVgyK3E3NnoxZ3hFV3hvNjVYSHQv?=
 =?utf-8?B?Z3M2U0FqcmcyTUwvWWwxeXA2T3ZodmZ5N3BoU2VUUCsrV0w5dkJzL0lXN3Yr?=
 =?utf-8?B?dDdmQ0pncCtmTjBVdGNXY0ZOZFYzWVhMWllLdGJmbjRWcUxmUXBHOXRLT3ht?=
 =?utf-8?B?SnVINllrL29RUXNYNitpTVNaZTBUcUJFbUNINTVxUWlJejhEb3J3NkM1bC9U?=
 =?utf-8?B?Skhsd3BqS1VRZk1kNDZhZXdWeDJza1BNYlRPTmJtbzdmNDZMWjkvNlhwRGY0?=
 =?utf-8?B?ZWZ5QlByeFdkYjJ5QVp3QTgyVmVITDgxc3B3L2JJbWtESzNueGx4Q1BvUzM3?=
 =?utf-8?B?dmNEZEo1cUFscGNyTUdkcm9rbmN6S0o3Zll4alB0VFI0ZXNMUDVYSVZrVksv?=
 =?utf-8?B?dnYwdVc3dHRHZWxTZytCSlA5N3lVYjJWZmpwK3JOTDkzR3pVVDJNUVh5TzFw?=
 =?utf-8?B?YnRyUzhLeSs0RXNsQVBadVF4VERQOWNvczNzZE1BNGUxeWRrYXljcmNsL1RF?=
 =?utf-8?B?cXcxT2duaFNJREVrWlVZQ0E3ZUM1VWljaFd2T05SL1h0ZVdGaFdQZmZUdEVT?=
 =?utf-8?B?RUdnRXM4TGNoSjVMYUsrZmd4bGJkWm5RNVMxZ2t2RHhLUzNjS284aHM0UWNL?=
 =?utf-8?B?VjhhVGZBaE90QklIeVAySGEwUi85dFJ2ZEF5OTVEREkxWkYvZDlMYkFSZkpL?=
 =?utf-8?B?SmpDZStQbGEreVFnMkdUT2ZHOWxFeEdZWEpHMmpMY25zcnNuOG56aTkvemUv?=
 =?utf-8?B?R0ZCRjFPZE14VDlWZ3ZEUVZsSXpCNDdwTlNCaE9yUTVHcWhjUVBqRmJLcmNw?=
 =?utf-8?B?WENVNERyYlZobTk1QjNhaGF5WkV2Mno2MytpZ2twUGlWWkpHMk5XTVByNXpP?=
 =?utf-8?B?aDJ6QW1pWVJSemE1Um9yR01aV0l4OWJmYlhlcnlTRGZpNGI2SHdDM2dFaVBH?=
 =?utf-8?B?Nm41bUNMY25YdkVZSHlzNTEvUGhBUUZoSG5qb1MwQ2ZQT2VySkZ1UTFDQXV0?=
 =?utf-8?B?cnN5Q1JpcTluU1VJY2NVWDZIdkZtRXZJR1JyUDV4OHYzWlp1d2oyRUt2Zjhj?=
 =?utf-8?B?emRLV2lCTzgySEpocW9vS25LQ2RLaWhaMCthNkE5QWNKOXRJRzdLSlJWQXha?=
 =?utf-8?B?dnkyeEhBdlMwUmRHT1hKaE1RYVpiekFlSlZIOWdsNjhVd0NMWjFidUVPVU0v?=
 =?utf-8?B?M3VuKzUwemtuS1RuY003L0tIby9md3ZRaklKMy9uSTREd282cFM5aFBDY3Ax?=
 =?utf-8?B?WDA3aHBPOXlMblV0UXBpK0Z4MlBMb1plZGpqeExjUnhZem5Tc1M0bE1jcENJ?=
 =?utf-8?B?aGt1Rlp4ZTU5MFBZY1plNDhiei8xNVU2OFEyTkF4K3FIdTROdnd3RU8wcm5R?=
 =?utf-8?B?S2Yyc2R1NzRzUmo4UjBFRkllNldvRTV3TXR6dXEvTHVjekttRnBFYVRsSmRy?=
 =?utf-8?B?cEVTb1FqRy9DUVVKeDl4Q2VqeXdVZEVySWtkakVMN1VOMkNNUi9uUVUxNTdj?=
 =?utf-8?B?RVhVN1phTVpoTVhqZFVTdkEzbUdZcmhPYXZTZUN2QVhNMS82bnBjYmZPRUp2?=
 =?utf-8?B?YTZNa1JqRURFaWFaN0RPY1ZTQ1pCZkEzL3RTcEk5azk0TFg2RFgxVm1uT1lt?=
 =?utf-8?B?SG1ueDlOQnZPVzRmSHFaVHpaYmw4NncwRHJZaXEzdnprUGd3VVdFd3lNYTBn?=
 =?utf-8?B?ajlYeldVVHZRL0tyV3dGSlZIWjI0b1FTZjhWUlY4cE9acjRSLzNaSTRLZDdz?=
 =?utf-8?B?NnNoeHpiZG9vemlQSEQ2dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUVXdFd0TWJuSDlxMzg5K3A3cHFEeURESmdIa0U1d3FlbjNPUTNpRjczak1D?=
 =?utf-8?B?NnFXTVBqRjJ4VjY0UjVPaVE5OHBFbUYrTmV3U1BYc3Y3Wm1BcVkxV0pLTGJQ?=
 =?utf-8?B?NEJPQ0xRNVVDbzRLSkxLNG5mQi9kcnRVNG9sbk1Wb0x2T3dGZFI5YlpxUUtn?=
 =?utf-8?B?Rm53bG9rRU15NWRuUlZmbmRLSVZVdEhSR1dOVjJadVd0NEx4R1haU3FUOHdy?=
 =?utf-8?B?U2pMWjFXaTdtT2tJdVcrQUtRblUzcFQxUUY0SW9QK2hCaUNsZWJhdkhLcHhv?=
 =?utf-8?B?Ukt4TlVweXJKZzZ5bnF6bU5adFpzcFhKNkMrWVNZK3kxUk9sd0YzTk91Wk9j?=
 =?utf-8?B?OTBlem50cmVMdnFvcTl2RzcwZFJLZVl6enVBRnBkYmlnS1YzbDJHRk5pYXJJ?=
 =?utf-8?B?Zit6SWFLVmVYNVBEVGluNXNlMm1PbjUwM2pzUk82MnhFenZFT09xcm9EK3Jl?=
 =?utf-8?B?UHVTL1QyVXJZY1NsdjB3bEpyekZTN1RHQUJTTmwxc01tOStRTW92eTd5bHNT?=
 =?utf-8?B?SGd4b2J5UnQrZFNKSUFnczQwWU9QaU12a2E5VnRDZVdEREZTS05RSmhhRGRh?=
 =?utf-8?B?MXpKK0g4S3AyczB4ZFV3SU9laGk1REVJT01FS0Zwck93RUFBYVRYRDNjbWU4?=
 =?utf-8?B?dVhQUmsxNjhkVnNJamJNa1IvYzBpNHdTbytPOGtZZ05JUUR2am03dWl0SnE3?=
 =?utf-8?B?ZWRHSzZhK0JSc0pYcW1nN0RvQ3VhZ0orZm9ucFJYc3FMdTQ3Ny9nWnNobk81?=
 =?utf-8?B?bmRISjZPWVFRanhiOWJuNmxVb1dROEk0MVFuNVBmcHNERjI1bWlRcVlVbzFh?=
 =?utf-8?B?Mjg0RTJ3NHNLQ3JiNzcvbUUyTjd3UFFCTGdXMGdudEVMZUM5K0ZaUnhadVZK?=
 =?utf-8?B?T1ZndDZZR0x0TkN1dU1pT0phQzF5SEM3UUdMV2w1eUgvRDJOMmVNNG0xRXNO?=
 =?utf-8?B?Vm1rSkJydFh5cHNCd1dncU1SOUdFZDNKTS90UC91L1VESm54cW9ZNm5LYjN6?=
 =?utf-8?B?VWJMZ203aVZOcDlDMm81aVpxNGw3Rm9tM254Tko3T0FLN2lqVWJvbDVmNldR?=
 =?utf-8?B?RTcyblg4Tkx5SWh4U1dzMmhWNjVTd1BlcE5jaTZqMkVyOFpWeWdlNjBuNjRT?=
 =?utf-8?B?VVp2K29ZYWJCeHR1US85ZjRGTld5VDhncGlabUJvQmxBRXdzTGhrV0EyN2xw?=
 =?utf-8?B?bTlIR0NnWTJpanlTOWpXcDdKb0NlLzdUNjcvZlNGc0kvMW4rZ2dkaHJCb0lH?=
 =?utf-8?B?c3FoVU5MN3BLVmE4N1VmUFk2d1dmc0VxNm1TMnpQWWVmNFR1bi9CVDFXY1dZ?=
 =?utf-8?B?cHhueXZyRXpyM3F3Mk1zR0V0K01KS0tuS290cEVOVVdWeGNCUUhuUlJtVmRm?=
 =?utf-8?B?UXFSTGxMZEdUOHN1MzRQM2NTR1VKMDFUU3gwTy9neGw0SlNyUXBxc1dYL25P?=
 =?utf-8?B?ZlZMd1hTUnArMFlnNTV3c3o3RVhsSzIzeEtLaHhTUkJpK2NmdUhlMWUzVVlQ?=
 =?utf-8?B?NkovVExIQkFkVm9CSXc2QlZOL05yYmp4WGkrNjlrOXI4S1pNSnZOa05GL0xC?=
 =?utf-8?B?ZmxiUlhUN0R3OUpDQitIMlRIWGRMMC9YUzBCUW1wR2tXV0VPR0Y1L0NkOWRr?=
 =?utf-8?B?bGE3YUp3ekFrV2pUWnVJTmpJMytZVTZQbnNlSVgwOTdEQnc0SW96czlrakNj?=
 =?utf-8?B?NTAyak9rcUsyM1l0MXRvM0M3eFhXekRvWUt6YWY2MVFPclhRWlNyb3lleUVn?=
 =?utf-8?B?bzJMSFdBMkp4SVZuK0cweitHL3hwdUsvbDJOVW9SaE9kZmRMNnNibnRlT2FU?=
 =?utf-8?B?Q2hIRzMrQWlSZ012WUJGYzJ6Ung5NkRGQWRRdTVxWTVHRFNGdCtaSHRLRnRu?=
 =?utf-8?B?Yksxb2J4QStVVDRPVnp0VElFSWdlNDB2Tk5zQUd5dEhZZWtvdmM4c0RMaFU2?=
 =?utf-8?B?UTlmZ1c3NGlQUUxmTVIxa3FUOGRVdktaaEg3VUxPam15UkQzNUxtUUdhT2N2?=
 =?utf-8?B?OFRDbkozRlhxaEdhSXVpeDI4V2cxUFVMd1I3QitKQXppTEJyUHRVKzRVZ0Qr?=
 =?utf-8?B?UURuSHNGTGJzZHNycFVFenc3ZHMzN0hMZFR3dmRWK1dBek9nYzRlYmJ1Nzl4?=
 =?utf-8?B?Ty9wNzI5cTA5SUNLMHBtaENEZnFrU1RXd2Nqc0FWYldKNDY2dWpMSFdrb3Nw?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aCbMHbamgzhd9r4t3nag8IYXh28bIA5/rKCHBeg8n1i6ZhStI98gLE1MaPDK2m58/uQjE9FSsbB1YABpW6q6WYLnm56uUROwiA1vZ+5djUxheGJ/xTcyL8GEkeYmbcOmu2CT/MOK3x97tXFZcP+ahUz+LFxYCtNnYuR2+iU4Gw4bfLU5tSfn1VYAJ8XqiK9t0o1h6srZFZ7zbhOwQdgqAa5dVGti6p/IyuluUQxB1JnIcIV1yjHEn48MTpw5j7wxQzsrlqNxB+s2I7rztImLtPmdp6T+GAz0ouOFEzc2ZSa1lLCKTXtdfLVS20oBiWd0+YkXAUDJAjgnWViVijEw5gINTrTzlYP0qjTQTR4dWNdcu+CnjT8CTV3cgPf5KRt5T86+WjlfNd8qD8S8q2u5iAPXptqMFoxltGn9jcAWyyW3djmMLbVQW/ByqImLGfYv/ABPoObW/jAhKtJzWBATnoBzqVDzQJHCRWns2jUA5PTX2jCI2fYveyB+JTJHApVv2biCBGgXjfN+lukw89RVo6KKVRrqVJo/8Z15Kwyp3Z7JlAgvlMINtORKPxlFKoKnopsutXXXMa5US0tiBkZ8N3YiaoX80DiWch8h3BuQF78=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b337a2-6344-4c8c-4aa8-08dd0ea54036
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 05:35:06.8810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhXQRXGDIeQGK5T1rfsj8aVmGTR3xDqcj/FSkkq8CwLZOFgv+JHqoBUfQoSOU+NyKa4OW8KhYb4go1SSWB/FvUP8oFwwG4Vc0+3tVx37Z+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-27_02,2024-11-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411270045
X-Proofpoint-GUID: JDhU4sQ_u4_H9g1VdP3BEwwZTdsaEM13
X-Proofpoint-ORIG-GUID: JDhU4sQ_u4_H9g1VdP3BEwwZTdsaEM13


Frederic Weisbecker <frederic@kernel.org> writes:

> Le Mon, Nov 25, 2024 at 01:40:39PM -0800, Ankur Arora a =C3=A9crit :
>>
>> Frederic Weisbecker <frederic@kernel.org> writes:
>>
>> > Le Wed, Nov 06, 2024 at 12:17:55PM -0800, Ankur Arora a =C3=A9crit :
>> >> PREEMPT_LAZY can be enabled stand-alone or alongside PREEMPT_DYNAMIC
>> >> which allows for dynamic switching of preemption models.
>> >>
>> >> The choice of PREEMPT_RCU or not, however, is fixed at compile time.
>> >>
>> >> Given that PREEMPT_RCU makes some trade-offs to optimize for latency
>> >> as opposed to throughput, configurations with limited preemption
>> >> might prefer the stronger forward-progress guarantees of PREEMPT_RCU=
=3Dn.
>> >>
>> >> Accordingly, explicitly limit PREEMPT_RCU=3Dy to the latency oriented
>> >> preemption models: PREEMPT, PREEMPT_RT, and the runtime configurable
>> >> model PREEMPT_DYNAMIC.
>> >>
>> >> This means the throughput oriented models, PREEMPT_NONE,
>> >> PREEMPT_VOLUNTARY and PREEMPT_LAZY will run with PREEMPT_RCU=3Dn.
>> >>
>> >> Cc: Paul E. McKenney <paulmck@kernel.org>
>> >> Cc: Peter Zijlstra <peterz@infradead.org>
>> >> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> >> ---
>> >>  kernel/rcu/Kconfig | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
>> >> index 5a7ff5e1cdcb..9d52f87fac27 100644
>> >> --- a/kernel/rcu/Kconfig
>> >> +++ b/kernel/rcu/Kconfig
>> >> @@ -18,7 +18,7 @@ config TREE_RCU
>> >>
>> >>  config PREEMPT_RCU
>> >>  	bool
>> >> -	default y if PREEMPTION
>> >> +	default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
>> >>  	select TREE_RCU
>> >>  	help
>> >>  	  This option selects the RCU implementation that is
>> >
>> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>> >
>> > But looking at !CONFIG_PREEMPT_RCU code on tree_plugin.h, I see
>> > some issues now that the code can be preemptible. Well I think
>> > it has always been preemptible but PREEMPTION && !PREEMPT_RCU
>> > has seldom been exerciced (or was it even possible?).
>> >
>> > For example rcu_read_unlock_strict() can be called with preemption
>> > enabled so we need the following otherwise the rdp is unstable, the
>> > norm value becomes racy (though automagically fixed in rcu_report_qs_r=
dp())
>> > and rcu_report_qs_rdp() might warn.
>> >
>> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
>> > index 58d84c59f3dd..368f00267d4e 100644
>> > --- a/include/linux/rcupdate.h
>> > +++ b/include/linux/rcupdate.h
>> > @@ -95,9 +95,9 @@ static inline void __rcu_read_lock(void)
>> >
>> >  static inline void __rcu_read_unlock(void)
>> >  {
>> > -	preempt_enable();
>> >  	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
>> >  		rcu_read_unlock_strict();
>> > +	preempt_enable();
>> >  }
>> >
>> >  static inline int rcu_preempt_depth(void)
>>
>> Based on the discussion on the thread, how about keeping this and
>> changing the preempt_count check in rcu_read_unlock_strict() instead?
>>
>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>> index 1c7cbd145d5e..8fc67639d3a7 100644
>> --- a/kernel/rcu/tree_plugin.h
>> +++ b/kernel/rcu/tree_plugin.h
>> @@ -831,8 +831,15 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
>>  void rcu_read_unlock_strict(void)
>>  {
>>         struct rcu_data *rdp;
>> +       int pc =3D ((preempt_count() & PREEMPT_MASK) >> PREEMPT_SHIFT);
>
> This should be in_atomic_preempt_off(), otherwise softirqs and IRQs are
> spuriously accounted as quiescent states.

Not sure I got that. Won't ((preempt_count() & PREEMPT_MASK) >> PREEMPT_SHI=
FT)
give us task only preempt count?

And, given that the preempt_count is at least 1, the (pc > 1) check below
would ensure we have a stable rdp and call rcu_report_qs_rdp() before
dropping the last preempt-count.

>>
>> -       if (irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
>> +       /*
>> +        * rcu_report_qs_rdp() can only be invoked with a stable rdp and
>> +        * and from the local CPU.
>> +        * With CONFIG_PREEMPTION=3Dy, do this while holding the last
>> +        * preempt_count which gets dropped after __rcu_read_unlock().
>> +        */
>> +       if (irqs_disabled() || pc > 1 || !rcu_state.gp_kthread)
>>                 return;
>>         rdp =3D this_cpu_ptr(&rcu_data);
>>         rdp->cpu_no_qs.b.norm =3D false;

Thanks

--
ankur

