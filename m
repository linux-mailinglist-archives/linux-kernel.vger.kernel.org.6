Return-Path: <linux-kernel+bounces-425238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B919DBF2A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 06:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC79282578
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 05:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A8C1547FF;
	Fri, 29 Nov 2024 05:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EXCgJbmQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J19uuhx1"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32415136A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 05:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732856663; cv=fail; b=iH1GtzdFsQGqxCbAOsmKrKBdw/T9ksM0C8AeHcicMmwfBaA/iKk4T3J0Lv3j7hfM+KzZ2Q5jBjKdcIXcLA2MiiN3sbgvJKmbsmeX+2DQ+ovb3xU/1ny0x48XL7p9k/1RMJATWqd728HIYKGlCeQoBg4VTcCGEjbaI6sRPjYxrgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732856663; c=relaxed/simple;
	bh=HDHFoFaTHEdoUtzhIbXvqQ5xFOkDpot0wpD1Xy3PoqE=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=K4nKBYJz41Qj8DT7Y8OWYN/ir8S8SjAdeug43RH8voMnpDBA7YRjbZu/miv3QgqTHYavtRYro1aawERxnzfVeSShKMqSQTU3s0EWWu6iWoou0AkBf7yDquSETWIeHVCNLm3qvXTHzl1sBthofZUS1UglPESp74y84EARA9KA0X8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EXCgJbmQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J19uuhx1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT1ffBh025223;
	Fri, 29 Nov 2024 05:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=96vn8LPXRebLVULZ7Na4kZ8vKi5ho3U8e+Oa38N/dFE=; b=
	EXCgJbmQfkc2Zv3hzwFLLDsswFXAIGuH1txyqm+OjDdPnmw1+NSkWEFOHejhlL/L
	Bq8hYRtrC/EjZ8X/z094ln74hWmnrOoo/NgmeaqPOlrQ8hbHFsygnkfR28PKYgtF
	oNNygo1QUPPODhvj6OzZ70FDl4JSVPeZ3J47mx56sk1B8t+bj0Ihuq9MSivweKPR
	tDmWh9zwL/xfLRkNJAqLTZj5i+K2vHJRu6/YuLmoy0Nz+8mpT+Via+ndPf7PzN9V
	MDMuD9Dq5xuM/ZbXDYLNhKGrQo6rdN5OqfudDVHom+/iaqkllN2soj8wew3qCEW2
	KwhqYVOZpR+766vP649MgA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xyamj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 05:04:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT1jkMI027564;
	Fri, 29 Nov 2024 05:04:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 436704r4b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 05:04:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNF4DcHU7yjbK0OI6kZCOW8MqnEeo7rozX+ixFShbcc0BkpkMml63maZUremPNAA3Fgt4Q9sc0SO5s+p7iCu+JCtilbaGfL5NOI7xRaZxvAw889xCfasrEX/awhpNugPsucsojFaua2pUXlI+ZPcy09WSQKxhoeIzl1K86YhcZsVVaC9Yml6ZNdwvCEl0zyl9Bh+sZL3CAjBLZAGT2RmbVZw0ZOw2Y3qHHmiXJR9tvehaHuwpCDCteGT15+7u6e08kA6GQ0pnQnjSt4pw8k4n+kJMBGOe1yx+8+imylpAIay2kW4Wh/pW0h9Ju4MPAaMdOajF5MpG509uisV9SvxzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96vn8LPXRebLVULZ7Na4kZ8vKi5ho3U8e+Oa38N/dFE=;
 b=vVTNeA1EFAOpr+dOt6+NQrpFafl4C9O1Sk4XFmPbzcgUENpkNwvsOh92Aa7s2+tt1M+tz2COTVMXQ1TzvrJRs3gyQ7q5WXM2Il8DcPxPlXqSTaRL8vR/8WnDulSMGA0DwZxy0LNJVm4tNJe0oJpnNYSF7UkfNdQ20ZILVr/tPdgAA+Y44HunIAFoTxdjUiA3meoz0ydl95xyx7BqHolrsT/9cJYy1JM57JoVfs4zXDaA/ESEj0gCIt3S+iJeyLDd1nAPKa3fG6x0HP2Vf6QpduJLyWBcxo3lCx+xTCnvKGhLGSFu6Eojkq8Rwo5/QnbxzujaSrPpwqu4T1+Gzrjjnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96vn8LPXRebLVULZ7Na4kZ8vKi5ho3U8e+Oa38N/dFE=;
 b=J19uuhx13mtvJzC96Nri7UE5gjrzHrZRh05qj1dli8i56NZvhX/QmOS2DVS2nDQ9jcLAGFe768Zc39DNvMTY3qxRITgozoyxJJo8DNaooWADdqhuIpU7T7HjkGSuWHjdIaUS4G/y0Dle5msER8rnchnAcFvB+Ea72dmWQDZZ/Lo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB6684.namprd10.prod.outlook.com (2603:10b6:930:93::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Fri, 29 Nov
 2024 05:03:59 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%3]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 05:03:59 +0000
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
 <20241106201758.428310-6-ankur.a.arora@oracle.com>
 <Z0h_KMzCCx2umo6h@localhost.localdomain>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, efault@gmx.de, sshegde@linux.ibm.com,
        boris.ostrovsky@oracle.com,
        Daniel Bristot de
 Oliveira <bristot@kernel.org>
Subject: Re: [PATCH v2 5/6] osnoise: handle quiescent states for
 PREEMPT_RCU=n, PREEMPTION=y
In-reply-to: <Z0h_KMzCCx2umo6h@localhost.localdomain>
Date: Thu, 28 Nov 2024 21:03:56 -0800
Message-ID: <87seraeimb.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW4P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::6) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c92943d-0d77-4336-6611-08dd10333bb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2NxVitzNXRwRm8yRHJvRmJxSjdFb2lwZ0hEVGN3aUNiSy9aMHdVcklSWWJl?=
 =?utf-8?B?empPZytSVHNqWnl6UFp2VUFxbkdnV2hUWWMrZytiSm91Z3ZKYVVVVEtkb1Mz?=
 =?utf-8?B?NUM1Q0FTeEk3WHVyOGFLd2hVYmwxbUpWejI4d3JJQlhXYW9JYWFyQnZ2d2Mw?=
 =?utf-8?B?b1JoYndKNmhYMG9zSUdGVHNBYmFGQmdGaUl0WGtEd2xyczViWXR5cExjanNX?=
 =?utf-8?B?blYwRTlrSWJ4WGthRlZaUkUxQU51SGhzNGN2T25KT09yNVlmQ0QxYXJXUDh2?=
 =?utf-8?B?M3UvS1UxYmplS0JwVHFVM01WZnlDRDVDSTBZWDBWeXFCOWt5L2RkdE5qenlm?=
 =?utf-8?B?OGFGQlBHbWRSZ3BBTkxoOWp1dDNoRCtTSEFYVUdyMkNwamdmWDg5bEQ3ZzN5?=
 =?utf-8?B?UWl6YU5TTGthV21VY0h3eDVsK04valZjR0tSUXVrZjNONEcvd1hGTmpXWkR4?=
 =?utf-8?B?YTIvMXFZU3RaSERwS1FHek1jZTkxWUtpNEdDT3duY1VzR2hFWkRNa2FPMmFG?=
 =?utf-8?B?SG5NMmtvVHhUeDdoWDFQVjZ3SXdPS2hNa0xtNzk3TGE1ZTU4NTliQVE0S016?=
 =?utf-8?B?ZjViUWh6MGJQTmhFYmorWTExMEpuQzJOL3RaaEt3cCtMRmp0N3htcVFPbTRQ?=
 =?utf-8?B?ak9yV2ZvNlZ6akZQTlpqT1NWQlpod2JkKzRmQ3o4U1lpbHF6b29tNmZMc0tX?=
 =?utf-8?B?ZG9nK3RoY1VVVHdnclpWUzNveWk1SGYxbnc1Z0FZY1ZKU3pqK0RXRTFwc0tP?=
 =?utf-8?B?Y1M3UjZ4b08vaWhOc2NRWGV3RFhWU3R4b1BCUGdMTnNJSWpmWERSbjljcUFV?=
 =?utf-8?B?SExqSjI2eXNkeDVtMDJHOXpOVzdVazVGbkFFajBMNnJBVWFjNXladjNzUjhh?=
 =?utf-8?B?dzA4WHhjZWNzY051R1pnWVo3Lzlkb2tXS1RNVjcxdWgyN0Njci9HWlEvU3hi?=
 =?utf-8?B?UkJSZUwxL1p0M3k5cUVRZm5yVmJKQWQvSkdZeklhK25RNndxSS9VRU9hVkJ2?=
 =?utf-8?B?ZjE4K09lbnhlVVh1S0FOWE9GaVZabi9nc05KSDh6anY1dXVkZjd2RWFaOHZF?=
 =?utf-8?B?MEs2dFJMMmU4WWVXQmV0Q2lYY0JDOHJSdnIvekZRYXA5Ykc2K2hDL245SUJw?=
 =?utf-8?B?MzYyK2MwMGZXYzhjc0dhWHpJRTR3Z2VYVHZBb2pYZjc0NmxmeFZ1UlZpdytk?=
 =?utf-8?B?MDF4REVsZ0ZCSUtMOVFJcFNwOHNVVTVRR2JwTmhrYktpaDkrRWt5ZWpqWUcr?=
 =?utf-8?B?eW81d1pPZG9qemZTK3dzMjZtbmRVc21SS3NFY0NqUFd1S1VGdHZCRXI4L3Nk?=
 =?utf-8?B?RHZJRUpFbVJlU3hGL1B3TGpWV0d0S0J5VnQ0U1g4Ym9ZaDMxQ1diVlROanQy?=
 =?utf-8?B?VjBLdk5FMnlzM0prdXZVd2diMHVWeU0rMGxmV1IvWFVGMVJHM2RtU0ExTDF1?=
 =?utf-8?B?TVRyT2hTdXBScmE2ZG1TNG1qdWp2ZG10WnNLdE15TFJkcnBzbHZVbFF3eExZ?=
 =?utf-8?B?bG5vc2lTanlFQ2tvY1FlN3lHWUVmS1BGSlZNaVYvMWRTOWFzV3M0SC9VemE1?=
 =?utf-8?B?YSt5QVFzaUlJcDBTUm04S3ZGTnhzWGdQdEdzdkJmR210V3ZsT3BMYSt0dGUw?=
 =?utf-8?B?dHh0MHpaUUF5bm1rWmFJVVpXOVZTaGJ1OWViMERHTjVOcXQxTEZsd3Jlb0dY?=
 =?utf-8?B?N090QjM3YTRpRkVlNnlEUWt3NW9DRlNQZU5DY1BKOVhJZkozM1BUUVAxMWtr?=
 =?utf-8?B?S3ZVSnNxUmNCVmg5MElFU000cndpV3ZlblJVMDVCTWFkNWhoSlQrditadlAz?=
 =?utf-8?B?RTJGVTVWTWNReTR4MVM5QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0h1Qy9NVHFNcjFMR0hjcXNMMk4rbFQ0QUdTajREMUkrWUxGT3lXZGEwZHRz?=
 =?utf-8?B?dWxORUxlSjFLWjlMWGRsazlSNFA4Q3d5SFRpbVUrQnBMUmt1Q1ZpNzlYNG1L?=
 =?utf-8?B?TkRrRWdUMDBBcnMvK3VBSVRaZ1dTZmRKV1lVRjZjbVcva1N4c0FvWnJ3WW1Y?=
 =?utf-8?B?WTY3eVFJeTY5YzFlOHY2QUIxTGlhYWFpaXpHcjVMUmkzNDc4WnlTYlBnK2Jj?=
 =?utf-8?B?YnN5SGw2aW9iVnN2UWxqSU5RckROVy9pL1A1ZlYzNTZpN0Y0WVFpRGxJOXp2?=
 =?utf-8?B?Z2RoY0FIckZRQWxlZVhzUUZjeW5QMFVkUHhkMTFYdnZ6MHNzNkd4eEpxWGhO?=
 =?utf-8?B?MThYY2dvcHFqaHZjOHFUN1VxK1BwQjc4V1h6YVVqT1JOWUtYRU9kbytKdDRN?=
 =?utf-8?B?VmI2M1owSXh6aCtRWlBFNll1d2JrZ2VFQVBmZlZLVmhBNlhUTFNiMS93ZDdU?=
 =?utf-8?B?ZHVHVlJLaDY2QUxwU1Vaa1NmLzUybGtHeTZvYWNuYlMvVU5jWEhxdjJkOUlX?=
 =?utf-8?B?d29RREZWbU9nS1FJSngwUk5MRzhsaFdRcDgydXRRczlreEdSTUNaOThCSnp1?=
 =?utf-8?B?RCtrVmg3NFplTzkyTnE1R0hSQ3ZDNkJWb0VkSXpNNUg0a25IMFFDK29kZ3Rr?=
 =?utf-8?B?Qm5vaFg1NHpUUFFXZmlGbHhINUNxRklFUzJMbmdPdlRxd2QxNlR6eEYya0Zz?=
 =?utf-8?B?Z0cwOWMxelZJUm9udEVYOEExZFNaeFVYNWpGN1hSeEVUbFB2NGswSEtyWEhG?=
 =?utf-8?B?VjFlckpFaG96R1gwbEtqNGVnbDU2Si8zM0xVdFp6SE5wVmk4ZzdKbjNNN1Q1?=
 =?utf-8?B?TGxjQ2dJM2ZBRGpibjA3UmNHdFBNejUxcWg3OVc4MzJxVC8zNmh3Y1V5QlVF?=
 =?utf-8?B?VW54ZDdsY3AwcUcxYjJhdGZ4ZG51bkZjbHQvN09kQVQwTVFkcDFRRWZQM2xs?=
 =?utf-8?B?TG45aXo1T2hFcVVYTXBCemVWTjNUQWxSOExWYzMvMUhJdnpQQ1FicmlzdVdx?=
 =?utf-8?B?VElEUmF0RG1KT0NhbEhIS05wQjB3VTFnYkdkSThrRGsyZmpjZTRDTnA1Nktq?=
 =?utf-8?B?L294eGJQdnZJaTNwR0RxcmplMzdVd2hEbkFkemRFc244cUNOY0tmQncvYnEz?=
 =?utf-8?B?NFIvWGYxQWVNTHVQNGV1TUxKYUpRZGZHZ3RvRE5BK25FZEVBdUloR0xXRUNt?=
 =?utf-8?B?WW4veHk1SHpyYXFiV0JrQzdwZS85NWgxM2dWVDRYUzFvWnN3MFE5WGtiOG1S?=
 =?utf-8?B?VWJVZmY1WTZWZDdLeWNwUUtBWVovZDc5Z0JWM1hRK2NydnM0RlZ3V0ZkVDh6?=
 =?utf-8?B?UGQ0WGJUYU1hMTkzZ3ppa1k4RFhxdGtKSUhNNkRCYXpReTRyZlduQUQ3M3NM?=
 =?utf-8?B?RlRMdU5udjZGVGxUbVZoODRCMWNpQjgxYTBEcXZhb05LY1hGMG9yRHNmM3hQ?=
 =?utf-8?B?cnpZNTdhQlU3YXBWWDhwaEIxdDhobVVhUXBybWFvQi9Tc050Nk80NHg5dVZK?=
 =?utf-8?B?MzdrUDJpeE9nSEZXc2JMdTdjUzN0eStYY2I3NWZ4ak1PS2JCeENnaWRzQUpq?=
 =?utf-8?B?dDNqenYxc3FiUEtXbXByK01BbnkySXV0d3I5QjloWDh6dFBnQ0FHbVNBYTlC?=
 =?utf-8?B?NnNYQTdSa3BOQVRtR2dTdU56RE5hb3RwbUI0QnBVSUdnSDA1RDVqSnREbFBs?=
 =?utf-8?B?RGNVZlNCMkNnUSt1ekc0Qm9GMUx5SldTNVpGSEV2MFBlSGlFK3ZOVkZPcXNU?=
 =?utf-8?B?N0U1WUkwK015WVNaUS82dlJYVjNRVHFJTHluQ2czdS9MVGFVa2IzMFBqNjdH?=
 =?utf-8?B?WVZrTE9yUTJkN3d2aS9yY09meUZodmx0anQ4S2JnU2FDSkRRRStZSUtJSzRM?=
 =?utf-8?B?dHo4cVpBY3lncnhSWUo3bFdFSUtuY1VKYy92VW1DRDVYYWthdUtCb3RQbE8w?=
 =?utf-8?B?TmwxRlJRSzhCUitxRlZMd0VnNnhtM3EyQUxSMmtqOVErSmNzS1Bua0hheStu?=
 =?utf-8?B?aFJ3MW94dmNqbnU2QWJQRHFSalNXS3BuYmV0RCtUeTE5eEdDK0daUHFSUk1q?=
 =?utf-8?B?VWk3cy9GTXRuK3g1Y0piYld6SHlXMVhYaFBOT3hWdjQ2Uy9wcGZ0SHduMTkz?=
 =?utf-8?Q?ceMbAbUO18y8mDqjxLj/o+Ugg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d739k1SiQp0yoOLab2VBmHOT+jcFea1Ru7BCjOv7HTl2FlzO67Nic8HqEu0UEClnfFdl2SSYLGYKk3hiDdinxXleZahVMXMe9XQqzVe8eGbJheoQ6xwYNiSi7peChP/IFkXqppMWdMoh9LwE3159hm4dSuDkbuTguRNsagPe/VH87hel59U4FGWU+M66cIQg8Fpwn49VymgBg9gK06++gdazYGY9HRByqI2Lnk6pIHvrJzpknBmXP7sh+lQJFBrLfTthe7J5nBEKifvCfeSNamcNy6QqaZ3nXTE6epeyw68KnQPvmrUS3er6mo/juRGNsL9bpI1pa0x/xtgL+vagbaqtgMNLMRUg+1sZpKAkcYaD1g9XDmuasfSXh6j33Bq62CH226C2x7Yt/eHQ7FJ5OD/+qbSXwIQtP10XpJzxFEWwhPBAt+vEo/i1K+Vf4havZ+4TwWeaGth5v12IG3jvuxD4qpz7LGD866yrEyNoozNAw/eN48Gz03XqNryegcRTYJ/tQ2umEQ628H38uIaKURr1qIEMVu65sLDP/8DQXxhy5JAxTx7hmW3JCTqPXPfP+4G1Z8tDp+n6IahNDpuC0vdDqmo6Njip4ln4fj0pPLA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c92943d-0d77-4336-6611-08dd10333bb0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 05:03:58.9023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYbbQ0dLBCNP4YMieKSo8/NVGU+BRCM6m5BNCwTE0cQTJFCn4xi/TE4L28S3pMmyxjJFBsmdxlE/ILF7FUlfoDV5FisXiLNey+qWr5kcIVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6684
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-29_03,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2411290039
X-Proofpoint-GUID: 0rcbJFHZGEPIY9bB6Ful8Sg-T_QdKfi0
X-Proofpoint-ORIG-GUID: 0rcbJFHZGEPIY9bB6Ful8Sg-T_QdKfi0


Frederic Weisbecker <frederic@kernel.org> writes:

> Le Wed, Nov 06, 2024 at 12:17:57PM -0800, Ankur Arora a =C3=A9crit :
>> To reduce RCU noise for nohz_full configurations, osnoise depends
>> on cond_resched() providing quiescent states for PREEMPT_RCU=3Dn
>> configurations. And, for PREEMPT_RCU=3Dy configurations does this
>> by directly calling rcu_momentary_eqs().
>>
>> With PREEMPT_LAZY=3Dy, however, we can have configurations with
>> (PREEMPTION=3Dy, PREEMPT_RCU=3Dn), which means neither of the above
>> can help.
>>
>> Handle that by fallback to the explicit quiescent states via
>> rcu_momentary_eqs().
>>
>> Cc: Paul E. McKenney <paulmck@kernel.org>
>> Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
>> Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  kernel/trace/trace_osnoise.c | 22 ++++++++++++----------
>>  1 file changed, 12 insertions(+), 10 deletions(-)
>>
>> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
>> index a50ed23bee77..15e9600d231d 100644
>> --- a/kernel/trace/trace_osnoise.c
>> +++ b/kernel/trace/trace_osnoise.c
>> @@ -1538,18 +1538,20 @@ static int run_osnoise(void)
>>  		/*
>>  		 * In some cases, notably when running on a nohz_full CPU with
>>  		 * a stopped tick PREEMPT_RCU has no way to account for QSs.
>> -		 * This will eventually cause unwarranted noise as PREEMPT_RCU
>> -		 * will force preemption as the means of ending the current
>> -		 * grace period. We avoid this problem by calling
>> -		 * rcu_momentary_eqs(), which performs a zero duration
>> -		 * EQS allowing PREEMPT_RCU to end the current grace period.
>> -		 * This call shouldn't be wrapped inside an RCU critical
>> -		 * section.
>> +		 * This will eventually cause unwarranted noise as RCU forces
>> +		 * preemption as the means of ending the current grace period.
>> +		 * We avoid this by calling rcu_momentary_eqs(), which performs
>> +		 * a zero duration EQS allowing RCU to end the current grace
>> +		 * period. This call shouldn't be wrapped inside an RCU
>> +		 * critical section.
>>  		 *
>> -		 * Note that in non PREEMPT_RCU kernels QSs are handled through
>> -		 * cond_resched()
>> +		 * For non-PREEMPT_RCU kernels with cond_resched() (non-
>> +		 * PREEMPT_LAZY configurations), QSs are handled through
>> +		 * cond_resched(). For PREEMPT_LAZY kernels, we fallback to
>> +		 * the zero duration QS via rcu_momentary_eqs().
>>  		 */
>> -		if (IS_ENABLED(CONFIG_PREEMPT_RCU)) {
>> +		if (IS_ENABLED(CONFIG_PREEMPT_RCU) ||
>> +		    (!IS_ENABLED(CONFIG_PREEMPT_RCU) && IS_ENABLED(CONFIG_PREEMPTION)=
)) {
>>  			if (!disable_irq)
>>  				local_irq_disable();
>
> How about making this unconditional so it works everywhere and doesn't
> rely on cond_resched() Kconfig/preempt-dynamic mood?

I think it's a minor matter given that this isn't a hot path, but
we don't really need it for the !PREEMPT_RCU configuration.

Still, given that both of those clauses imply CONFIG_PREEMPTION, we
can just simplify this to (with an appropriately adjusted comment):

--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1543,7 +1543,7 @@ static int run_osnoise(void)
                 * Note that in non PREEMPT_RCU kernels QSs are handled thr=
ough
                 * cond_resched()
                 */
-               if (IS_ENABLED(CONFIG_PREEMPT_RCU)) {
+               if (IS_ENABLED(CONFIG_PREEMPTION)) {
                        if (!disable_irq)
                                local_irq_disable();

--
ankur

