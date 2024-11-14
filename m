Return-Path: <linux-kernel+bounces-409961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92DE9C949F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 22:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68DA32821DF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E62E1AE01C;
	Thu, 14 Nov 2024 21:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mfTEeVmJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KEKUvbqT"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820F0189F2A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 21:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731620355; cv=fail; b=D52+AT5Zy0bSd3temkeXMwoiuEkGHAiUF9xhTbDhfl5uPmsXWZkMmS/a8qj3Brkw5a6MvMQ9WrYLNWkj6CArFYgn+w1cFrZPS2L6MP+FH6VDjT4zheoIXY5+n2nSXcIGhGlFRnLI6dNb0GTtfZHHBoEdZh07pw0iwvzRW5aI7RA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731620355; c=relaxed/simple;
	bh=hEgFjJHm4CLIQoKUoQYZCzkP8B/L8wLb7jG/ZEUaoGI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lnl+I9UQx8lvTMIag91z6bkFVCxrA4+tTVFoZtJHx2q5zPAkUnq2YIzCURw5GzGewnviQQxYDF2pDLqNHdoaQHcsOnov7OPM66rf1nDR5jsYjIn6SaqiEj3JPuWTgiJQe/IgXwvfMd1YGZnAKc9A9L6ukWdohazklB2quPaU/QM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mfTEeVmJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KEKUvbqT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AELXafC008532;
	Thu, 14 Nov 2024 21:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ZqhjA5jfeps3RC2qkz7hcyPdygfdVJMuNZ4/wRieut4=; b=
	mfTEeVmJXzGBG+FC3GkBdL9ptFCtq3VO0TZvJu5A13rosDHsxP/qOq0sSYrVsyDQ
	hf5ILhE1fWJOQsDOfabZnckjKtIgQwzEoxcFotgeCmt8zgeyKwsbBU0rEsfAVm9E
	ccrvWVFFqoSBVbjkcCEAID0UYy48U9oVy0RXCTBf1efoGltYOyCPSxe4bdiCkM6k
	QALsPnk+9gvfubTvNhYjsf6uNwk0ZELsvpjuYmlF3T4ZoXORwRHHaH+3ROAEptZr
	YmqUtl78A8Zcv+e0Ib01OJY1B7HaT/kJPiE3cLnW7UPrv354ryVgYaRVxRrxtGsD
	I5oUgTg/182jXBjOcZqmDA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0n528kj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 21:39:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AELPbpC001179;
	Thu, 14 Nov 2024 21:39:04 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6brtrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 21:39:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICWkbMi2YYOG4EHhSihkepVUHkhkTWHi77q27l3J6EBbjjuduK/meiNk3Q7QZplDeP9Hk4FmNUDMvk3yLolvlbSHALOT1tukrDdW5/KL7rU6jhtqgnmCfeFe7E+1fJpTNJAGsY7kQEYPBdqUTNbL3Ka9awsWxUJ3q1QlOlGIHDL3BVaXvYFRBPqg9ZHZ3MMU+25uw2E5eYoNM22ilq81P4ycfXHva5452XrxIHKxR1T8rdi73UCsGWCP1pNGRIHt+kp06D6rwun5m6UYjSWckEeueuddklvmnQniskXwbgzcR4lhoke2sB7MOml9nStGzkn9mqKp1idnxaBNPYFTxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqhjA5jfeps3RC2qkz7hcyPdygfdVJMuNZ4/wRieut4=;
 b=Od5UHs8V6ULeFNpgbzdhrTJLd2nHznI0YWx/JgZEkJQpqvZNKxzCMdY8qd7E/HdbKomZUwZmY+G08cIjUppIhyHX+ooRu6MAEKEoC+iDd+h8FdsncXc8o6aiQH/m5L71GvAJocDKJ1/Djo2TmeDdG+wceMJjTb2zSfprZZTOGUafeZ/L+0WUpFmdNmegDb9dn2z2HcRprKYucoRUwEoW8wPEwfGLU5761ia1sp9Ds8Y3F57QlscBUTO277y/75cVjMPNWPTXoISXJcjrbsvltdPvHXA9jRatTuk0yGxfNLzQZBPbyXNhNku843Zxg4R78/Y7H7+I/UBik/VzbYzxeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqhjA5jfeps3RC2qkz7hcyPdygfdVJMuNZ4/wRieut4=;
 b=KEKUvbqTlK6F5E41+FQOhs5w0QHLXBD8mAKSz4M/Azw9HVfH2dgwiluFFDHZhEM/gYCT2zUWX904tbCVEuyVSRp27hgIurEkdNVm467vSu8XdirBDqI4ml1O2DeMtNRrYBkXFw4euIHMnHnTU96YX5YP8A6sg6ncgH91RBemWVs=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by LV3PR10MB8033.namprd10.prod.outlook.com (2603:10b6:408:280::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Thu, 14 Nov
 2024 21:39:01 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%4]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 21:39:01 +0000
Message-ID: <a522ec38-582a-40b1-b3f6-06dbabd731ad@oracle.com>
Date: Thu, 14 Nov 2024 16:39:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Track node vacancy to reduce worst case allocation
 counts
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com
References: <20241114170524.64391-1-sidhartha.kumar@oracle.com>
Content-Language: en-US
From: Sid Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20241114170524.64391-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0863.namprd03.prod.outlook.com
 (2603:10b6:408:13d::28) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|LV3PR10MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: 62c0f244-34f8-41b3-835e-08dd04f4c0fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFlyMXIzamRqbkhiNlIrOUJEL2NTbkp4N1AxdzdWUVVVQy9jQk4wRzh4TTBH?=
 =?utf-8?B?bysrVU1pMHA0MjlsekpoTHBKSTlXV2orWnVUWk1PSW5tdVNCbDJCMVhxeHFV?=
 =?utf-8?B?cnUyK1dtS1ROZmpOZjhXNlpvMjNwSUdSTFlkV2M4NnFpUnpvV081MVRqZUFi?=
 =?utf-8?B?ODV1b3hOYjZMOVBwQVZlbWttby9QQ3k1eGNBb296VXR2d09XK2d6SnhyNDVw?=
 =?utf-8?B?QnpPc01PVUlYWnhLMURZN2dHVjJ1eU5EbHdwS1E5SUsyZjhGbUxzOUkxNjB6?=
 =?utf-8?B?T1hSZVJDOGxLdm5hQU51K1JxUUllZm1TU1ZOL1d5enN3alRSbENYeFF0Rzl5?=
 =?utf-8?B?ay9iemxIUUQzR1cyeDhDVXpDUVRsc1JhZXZwNzVGR2owZDNaMG4zVWFyUzhz?=
 =?utf-8?B?NWdsNjYrWXp2Y01mVldGTmRxek9nSHRMaDZMbUttQS9MdVlKWHBoNmJnVmFH?=
 =?utf-8?B?MU5lUE02WXFrS0o3MTQ2N0NjSzA1SDQ1M0pmdzhKNGY3ZlVGYVNiN0hobmRT?=
 =?utf-8?B?dGxkS2E1cjZ3Mjcva3JrWUVML2hHWnkzSDBYeTFGZFFJNkF6b2RjQ2w0MDBi?=
 =?utf-8?B?dWVVMk5Vd1Bobk1TUE9PVnpHOUxoRUtJZHJLUzNYZ1NzSDVUMkZQbFpuMk8y?=
 =?utf-8?B?NTBhT3Q0ZEVneEtDRTV1Mlc3UmJFTmRlM2pQNzZ5OSs2ZkVEc2xqN2c2MFI0?=
 =?utf-8?B?S3VQRUZKNU9mb2NGZUtENmJwdE5qNXZYSDROdXR1ZVdNd0I0b3hGWUZsSmM5?=
 =?utf-8?B?emlaMkVYU25PeXNvYnpHcGU4YkJ0eXVRTU1taDZlU2xlQXpkT0pqSWlYQWZH?=
 =?utf-8?B?U2tlY0pCNnlVWHBMZjAyWDNUajlvbS94allWY1JhM2hWUUlJaEZ2cjRrbzY2?=
 =?utf-8?B?bUIwcGQ0MDBEM1A0alhjY2xrMk1naThqcExLVXM2NFc1MmJBTHJyb1NBODFt?=
 =?utf-8?B?QVV4dGVVN3hvMGorZGxBWEE4QVJSU0hBUDNQZlRLWFJBOUJlK01tdExtUW5U?=
 =?utf-8?B?QTNwd2hYRFJxaDJzNm9OTFh5VlNwalZZT2lzQjlUZ2hia0h4bzlpc0NpRDlE?=
 =?utf-8?B?bVpLWEJpbGlQcXlBREM2TzhvYU43Q0FFOWgrcUpyU3o4ZjRaVHRZbVNBT3pQ?=
 =?utf-8?B?SldVZElDcDNPeTZwaDh4ZGFRajkvRTdpTWJaY1pwNlUxbXFVUHFpZmlzQXln?=
 =?utf-8?B?Y21sQ0hBNzJFVTJPR1JHK0RCQU5xRy9qQzcwTzk1aWFSdkFmQ0pKL1cxdXRJ?=
 =?utf-8?B?NFIrWnJTWklqNDl1NTRNV2dCeG1RQ1hJTDBIdy84QkoweVYxelB2bUhFK3JR?=
 =?utf-8?B?OUZackZJWTNTclIvakF1RWJqcEMrZzFvZ3B0aVZpY0U5MlZ6ZGI3dXB2KzUw?=
 =?utf-8?B?UU1TblJia0FZaHZBVG9MOE9oaytiZUFJcnBwQlBtNjVyMmtqVHdaQW5UM3lV?=
 =?utf-8?B?ZDZWQU1va2VGeEJRdklweS9RUE1BclB6ZnZRa29FRTBkS0FVL0JXbzM4QWw2?=
 =?utf-8?B?YXUyaWdTVTJkZUs3dm1zbWtXR0wrWFBvWDZWTk5PYU9UMEJ6NDlERlFPSzdK?=
 =?utf-8?B?dWhPY1QrTWE4NG5xd3dnZU5nYUs5QUQ0bGJxY0ZCNW5oN2wvNnJnNmtQeUVm?=
 =?utf-8?B?UFdrTGdEM2VTZzRkellScG5sSjJvRXh2NVJEUHByL1E1K2NvQW5PUU93TU56?=
 =?utf-8?B?K1NyWkJ2eW9XN1B0T2xQUXhSZ2poYmR5TENlZ2xEZjRwdHRpVlJ3c0t3Qjk1?=
 =?utf-8?Q?jHYrzzmKLzWCkB2ljOWjAE2bwr0sdCw2fKC9VsO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDNlYmhTNWM5ZUhTVDlzd1NmRmMwSFVtcjBTUU1GZGN6dk5VVGhhRUJjZXcy?=
 =?utf-8?B?N05NeXk4VmM2VTNRZ0dqWjdaaGNJQk4rZFBkUXp0c28yY1I0RkhMcWdPQlRE?=
 =?utf-8?B?Tng4bnJDUHg0a2FrUGY3RmNVKzBJdkd3RU9KRlA0M2N6ZHI5YTlPQUZiRFNC?=
 =?utf-8?B?bVJuNEgzVFNtVEFNTEpBMUhvbHAxWDFnTzlTalV6SXBwbzVyWFFRNlhEUVBE?=
 =?utf-8?B?T2RwdHl0MW5nM2FiNGNKb2RNa3dCV3VNZDZ5Yy9sRmZPOEhuOExRWktKaks0?=
 =?utf-8?B?c05OOC94YTdjUFowV0psTjJuUERHL3d1NEp0WFpycStrMVlsblBWYWtvSm10?=
 =?utf-8?B?Q05xQmdnQ052VWQxM0h5SEJQbUlCNTZxMFhPMDFDRU9zTm5xUnNsaFZldFRV?=
 =?utf-8?B?anFCaVFKVkZaYXE1ZzlvWFhOVFNlQUtrbUwxTUxPSUp4dGtqdmIwclErSWFk?=
 =?utf-8?B?NjBtV2Q2eWJDVXYrSXBBd3BCMWVIQWNxbkxJZ3NYSTVzMEJmNlpxdjNRSFdu?=
 =?utf-8?B?NzJhZkpiZ2crWGFOQjg1RG1PdXhZaGZrNkV6VDhHeXB1N0pDWFhjdndraEFw?=
 =?utf-8?B?R2hWNGJ0QVpqL08wdk8xend2b2c0akFFekZ1RFBmZ1lDZ1VUV1o3eHM1aTlE?=
 =?utf-8?B?SUdZYlJteGxucHVuZ09XV0t0K254RVplMG5mNnFXM1JOaG9mNnNYS1E3aE5H?=
 =?utf-8?B?eGJ4eWEyMGNhTTIvR013UzU3Rnl4dEM0T0piVitPWjY5aExSUTdkaTFBRkUy?=
 =?utf-8?B?LzVvWDZZT2o4eVU3cEFBTUwrdWcxaS8zNGszb1Q1T2FFU0ptQi92aGFTbmVO?=
 =?utf-8?B?K1J5UG5EL05kazFCQVpLV0M4amNxSVFuUU5qQ2JkSy8veTV0QXNwM1M4R3NZ?=
 =?utf-8?B?Q0RmRXZ0RlJWVHgxckRrd1hDZkxUQzBuYytSQUZqRm1qUVJhVFYzcWZaQ05S?=
 =?utf-8?B?dWljbTVLeDdlWEtvVlRsTE4yV0NmNEhraytHRXF3R3RQbkc3ODNvSEEwN0Ew?=
 =?utf-8?B?LzQrZC85MDlHKzFYTTlVd0syNCt0NENUbFk3VVlWRnBPNStJSGZiRFdKTWZO?=
 =?utf-8?B?akIrYUJwMFlSUmIrVktJNGNybHRTM3ZFWnhjZDQ2UlJUYVZsVGdKdGU1Y3Bp?=
 =?utf-8?B?ZU1LWWVrbndOYU1EalRZRmRQYUVSc0ZOWC9Ua29sQ3BkSUtiT3hPcWN3VXZJ?=
 =?utf-8?B?M0M4dm0yT1l1SWxVTTNlRG1DTDRTNjBHRndPL0RPTzd4d3NnU2Y2c3luZWdW?=
 =?utf-8?B?T05UWlVXQkpuWEFsZ3c5amxJUW42YStSVXpKN2kwdjhzU1BCVVU3Nko4cjhu?=
 =?utf-8?B?aEhCQWE2aWFFbFVteDdYVDdDTzFqaldVK0lzeVJHWU5yOVp3Z3BySVdJWFRY?=
 =?utf-8?B?V25ZRGFwUWV5RWlIaGgzMHZoMjlvc0VUM0JLNTZkUWgyMW83cHBIU2NWalZ6?=
 =?utf-8?B?bHU0d2ozVDhOa2wrUTUwVnZpSml1aGxleS9RMWJqUUZsTWFGV1NJK29Oa1Rm?=
 =?utf-8?B?M1FRSG5HVnIyN0dpOExucWxRYTFYWG41cXNOUXg5MW5nOWljRFc1aTI0YlhV?=
 =?utf-8?B?ZTZZQm44YnVTTnFUK0l1N3NTclpwVUF0QnBqODhsSm9RcVZDcEpDU2tjREVl?=
 =?utf-8?B?NkxIT0RCeHUrOTlyK3ZpTmVUK25XdXBWcTgzU3RWOUwrbHgyUDBYNEdSdXVz?=
 =?utf-8?B?UE1OUXg4R0oxK1RkWWUwMVVuMUdWREg3cnhqbXVvckxkNXlOQnhZRkpDOWIv?=
 =?utf-8?B?aTZMU2IxcWhVVWZuNVJJVU5LQm5vblh4R0cxWmd1MlJOWjJZUHFXL3ZvWnJ3?=
 =?utf-8?B?cWFCbGRGdG1tVFpXb3gzK2JUR3JNL0pSTkJyMHExbWdWbzNLck5KdkpiQjRo?=
 =?utf-8?B?MWczMS95YmpYcXJIV2NMaEFMNkYwZE1GWDU5VXFEWGRSQ2ZQWmRUaCtMaDBO?=
 =?utf-8?B?cWNxalpYWGpXZlVrYlB6Ni9SdVFRNG1sek44RmxHUnNMbEJpMDcvV1c5UW1G?=
 =?utf-8?B?dElOTHZrN3phYTd2TjJYblJLWjZGenEzU2ZKYVJHdTRjVGVsaFNYd2NEMEpM?=
 =?utf-8?B?S2ZXaDVOZVM5R0VRam1OU1c3TGEwNFhWZVpIY1dCdDY4aDhYNTFDbUwwOXlK?=
 =?utf-8?B?VlZKTmgzVmVIVzhVd25PSGgyMnN5WUxWTUtIUkYybys5blV1YVVlLzYrSEJB?=
 =?utf-8?Q?91sLdRJtKUgoyjC5L7iOUbU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mEubFBW5PxqfRrfcCN6SlTgKyL46UvU+5+OoJFL1IKpxm+sHI9YWXCKIclSTJFG/IUihQACS9pYYm7CesIsWCZ8Ts8SRdfRX1sbOyapwHLtWeJEcCDBEwdK1In0ViU0aqoZnp+9dpGXrua1Gtt11CmWGdQoz/3Fp/qeerDBBGtN8ERyC3sNTPFlr7W7gPAbx9EcHHRQQXjWKOYqIm2vZHJLgUfeT++o5uZWWTGAZvzVr9zBhQvDEXWiPA/am2nCf1nwGzzdMKFDOa4mgOJe9wuc5ph706FcjIPtumq/0yNpul9onzBOAfT/a2PgO2uoLFyyqrC5iugtaK7NmdvHY2sWc0ioDhC8+OweEam/AfatDd/UNinh1Z+lTTUzwYXXr7DsQZDGuKz/I2e0bABbX3N3FrCmM+E54TElAc795iPnR5QE3jRBGbkymiqVEVobJIIeSCgJo4ofIv2829Yhr+fLzcZWaKkLGBJKLh4gZvubeSMCijJ005/MYCASrwD1+5isRE3W/Pypp5eKl3oxrPR0kdpYkaSEndIffRlQZYv+R3zIkLQW1OQ0XMKajTVtevD8hUyzMLO50bKfciPyr8xGbY8e3eLifHVqgxG+uVhg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c0f244-34f8-41b3-835e-08dd04f4c0fb
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 21:39:01.5685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IUuxE5pGWhu+YET4DJvJ8YkQfc0+WJzpS0PwnKsqzpwgkG9hgrEa3byNcda1z6pIbIwgH/Ch3TvI5Y3ZWtY+r6McADUoPlcZR8mIRysItf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8033
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411140170
X-Proofpoint-ORIG-GUID: bRuzx-E3a5N8boqrq_g4QfSpAayjmPv5
X-Proofpoint-GUID: bRuzx-E3a5N8boqrq_g4QfSpAayjmPv5


On 11/14/24 12:05 PM, Sidhartha Kumar wrote:
> ================ overview ========================
> Currently, the maple tree preallocates the worst case number of nodes for
> given store type by taking into account the whole height of the tree. This
> comes from a worst case scenario of every node in the tree being full and
> having to propagate node allocation upwards until we reach the root of the
> tree. This can be optimized if there are vacancies in nodes that are at a
> lower depth than the root node. This series implements tracking the level
> at which there is a vacant node so we only need to allocate until this
> level is reached, rather than always using the full height of the tree.
> The ma_wr_state struct is modified to add a field which keeps track of the
> vacant height and is updated during walks of the tree. This value is then
> read in mas_prealloc_calc() when we decide how many nodes to allocate.
>
> For rebalancing stores, we also need to track the lowest height at which
> a node has 1 more entry than the minimum sufficient number of entries.
> This is because rebalancing can cause a parent node to become insufficient
> which results in further node allocations. In this case, we need to use
> the sufficient height as the worst case rather than the vacant height.
>
> patch 1-2: preparatory patches
> patch 3: implement vacant height tracking + update the tests
> patch 4: support vacant height tracking for rebalacning writes
> patch 5: implement sufficient height tracking
>
> ================ results =========================
> Bpftrace was used to profile the allocation path for requesting new maple
> nodes while running the ./mmap1_processes test from mmtests. The two paths
> for allocation are requests for a single node and the bulk allocation path.
> The histogram represents the number of calls to these paths and a shows the
> distribution of the number of nodes requested for the bulk allocation path.
>
>
> mm-unstable 11/13/24
> @bulk_alloc_req:
> [2, 4)                10 |@@@@@@@@@@@@@                                       |
> [4, 8)                38 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [8, 16)               19 |@@@@@@@@@@@@@@@@@@@@@@@@@@                          |
>
>
> mm-unstable 11/13/24 + this series
> @bulk_alloc_req:
> [2, 4)                 9 |@@@@@@@@@@                                          |
> [4, 8)                43 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [8, 16)               15 |@@@@@@@@@@@@@@@@@@                                  |
>
> We can see the worst case bulk allocations of [8,16) nodes are reduced after
> this series.

 From running the ./malloc1_threads test case we eliminate almost all 
bulk allocation requests that

fall between 8 and 16 nodes

./malloc1_threads -t 8 -s 100
mm-unstable + this series
@bulk_alloc_req:
[2, 4)                 2 
|                                                    |
[4, 8)              3381 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[8, 16)                2 
|                                                    |


mm-unstable
@bulk_alloc_req:
[2, 4)                 1 
|                                                    |
[4, 8)              1427 
|@@@@@@@@@@@@@@@@@@@@@@@@@@                          |
[8, 16)             2790 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|


>
> Sidhartha Kumar (5):
>    maple_tree: convert mas_prealloc_calc() to take in a maple write state
>    maple_tree: use height and depth consistently
>    maple_tree: use vacant nodes to reduce worst case allocations
>    maple_tree: break on convergence in mas_spanning_rebalance()
>    maple_tree: add sufficient height
>
>   include/linux/maple_tree.h       |   4 +
>   lib/maple_tree.c                 |  89 +++++++++++++---------
>   tools/testing/radix-tree/maple.c | 125 +++++++++++++++++++++++++++++--
>   3 files changed, 176 insertions(+), 42 deletions(-)
>

