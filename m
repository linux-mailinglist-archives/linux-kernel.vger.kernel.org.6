Return-Path: <linux-kernel+bounces-558623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56159A5E8B8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43FAF17C8AE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DFE1F192E;
	Wed, 12 Mar 2025 23:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HuBUs4tJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KaM5xcQR"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0441F2388
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823411; cv=fail; b=CUKhFfTemFde2Fp6PFmYHwV2/0gZ9a1MGgf54BwPJX4mL1Tdmm1ftlK3qGCGHWGdXIt94wZlI38Cuyr/MWT2E5VogdwO/I060kJgadjqq28bnmEq4AzYzsRfE6Ml6fz8S3/vDPYu2mcR6isvQfTetlCH/+vBAcpJSjf851repAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823411; c=relaxed/simple;
	bh=0g8jOfs3EhznCsikTySef5iLpIesQmLWFQMlH2JTzoI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QzzLkGT+8bIl+PBeewHcme6pNk0YK9i0uzbR2sUZpBFZtg6B0p/oKqgCYhm5MXS6/uThIL4i4nId0O3wjVD9LrfyU1z5mIHPcYnMeGN87SvoqG4IzaU42137WmBOzUiZNNn3Zn8Apk4AcNYct2aQBt3zXKrWXcY05ycsGxu6t/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HuBUs4tJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KaM5xcQR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CItl2d013877;
	Wed, 12 Mar 2025 23:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ZJCQVMZ/90LO2Wr+a+TEdhhO0+JsR9UwZyQOyRd36Sc=; b=
	HuBUs4tJB6YR4oBlXPpt/otuu6EaPjLgoRo4V13Wic8bs479z9oHr1CYcRIjiC+u
	/5dsZZphAGY7QPASCqlF1FykUvQAmHGs0z9Zna1sMr+ycqem0wumxWIwZML7jZQ0
	QKR0IVpGsTGqa2gIIK1QfXkgWYVZaSQUhFv6Cmg9uVH5FDtE5X46hbzzh9k2zxmW
	dBOiXaz2lIB5DQtnJzh7nQfhVgq/mwETdZuZC3qSafD1ogUJP3waLiy48FUArje1
	ufhLt0AhFkGFzWkPV7fHowj17HWpMLBdsGuYdcJi/FgPjijZeBl04qpv85coCaTY
	CXlcJE1bpslYhCAj9SjvHw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4hb1xu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 23:49:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52CM2FJj002130;
	Wed, 12 Mar 2025 23:49:52 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45atn7ysjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 23:49:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBldbtkH1dxLhP90IKP4ZrYq5eu/2Q9OcvVrlNSbedPS1yPRGVitMVqkvBczjjdZpgYm5M3YNZt0UHIIKkoZIa/OY95uB6/T1zqtIEbHggi7y0wVl4RQgMcJYs7wzbftR+OiEDGhV4rXOqCWdaVvjstlvWu/XIyFed8GiXrzeV0RhXKnIE2MfgoANDMKnkBSbKFMFboYYddLVOyEJFSASlS7XMQZr6eRu+WkvTLienuNqSQVb3CeM9Ot1u+CmVaZn4kJjdGnIOPDxGERMHtU+P2+sy5neC1ifdh8Gxt54KdtPT7TAPjfx+lxVe/nRcWzjGwUuR+CtvVYzV9pdHs47g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJCQVMZ/90LO2Wr+a+TEdhhO0+JsR9UwZyQOyRd36Sc=;
 b=arFJ0LYjMowYKeeuw0GCHxt391ZtiXoqX6N+D/3gqnOmzhYPusV/kD8jHf4MFNE46980Wihhmh7CLhJ/jU1ZpkG5kpdU1rdSBiJP7zEXq500xwsQHi+BgwMlpftb5l81/zjEHAMChsvuRk0d/HaP0XjpbSi+GbEaspUhAVLcBqOSIWGd3jZKdz2O/xEQKtr4o+z/36WA+nXFHfJeKlJFxbDaswwUjhJvrX7XFxj+XqDZVo/h4BrVzpCfRDhAXHp8fxGKNnepKI1AVMIhXXw9hQFixELXQZWtcG8l+MWYTklg2C+t9194E6t+YC1F8szWAVgr8ZnOQwTdwSRinjXc+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJCQVMZ/90LO2Wr+a+TEdhhO0+JsR9UwZyQOyRd36Sc=;
 b=KaM5xcQREjx8TRwHwzYXaTSQjUI4EWK6bLb9NJ3bqsM8s3m8Jn9iizhLzWHKEqeeMh+CBWnJISnFl9Gb41y1hAoYE3FRp4dnmu4Ic9WYzJCLdC7tEv5Q3ido8LAHgTig5cDmqfz6vkCSYJpIiMVrvtR4h5+rFq0cIpqqfaymnJM=
Received: from MW4PR10MB5749.namprd10.prod.outlook.com (2603:10b6:303:184::12)
 by IA1PR10MB6122.namprd10.prod.outlook.com (2603:10b6:208:3aa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 23:49:49 +0000
Received: from MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454]) by MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454%3]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 23:49:49 +0000
Message-ID: <cde7af54-5481-499e-8a42-0111f555f2b1@oracle.com>
Date: Wed, 12 Mar 2025 16:49:47 -0700
User-Agent: Betterbird (macOS/Intel)
Subject: Re: [PATCH] sched/numa: skip VMA scanning on memory pinned to one
 NUMA node via cpuset.mems
To: Peter Zijlstra <peterz@infradead.org>
Cc: mgorman@techsingularity.net, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tj@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, akpm@linux-foundation.org,
        longman@redhat.com, lorenzo.stoakes@oracle.com
References: <20250311160447.2813222-1-libo.chen@oracle.com>
 <20250312080102.GF19424@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Libo Chen <libo.chen@oracle.com>
In-Reply-To: <20250312080102.GF19424@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::16) To MW4PR10MB5749.namprd10.prod.outlook.com
 (2603:10b6:303:184::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB5749:EE_|IA1PR10MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: 44aed241-5f56-4301-9fde-08dd61c09349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzI3WDN4S3lucmtCVEtKdnZLeWw1R08valZyVE94N0tzSHNwL3BzaEZyYldG?=
 =?utf-8?B?bWoveXl6RUEvSVpLU1VCWWliY1JHaTdTODhDWG8wMjU0TlJXa1lYU0FQTXZE?=
 =?utf-8?B?U2dRWEM3ZXdYakhrTUQrMkdjeGVSNXJxNVhqN3drcXZPNW5COW05Y1NwdHV5?=
 =?utf-8?B?ZmVka0VXU3VWejhSTW51MmZ3cVowUGVSOFBBaklKc25vcCtEUjNSQTNMNHFC?=
 =?utf-8?B?ZjhyQ29GR3NuSjdpZktLaHdXRnBVVW1UNDh6dm1FVE1tT3ZvcGV1bWlBM3NE?=
 =?utf-8?B?cXl1Y3lHc1NNaittU21xZEhkQmFsc0lrTi9yRnFaWkE5R3RhRHQ5TjRiOTBC?=
 =?utf-8?B?MmlmS01jYmRwYjJ0QklCaCtuYm1lc1k3QlNxaVhzZFZhWmo3ZGNuNVBRNDFq?=
 =?utf-8?B?N0RHRHJEUlBjMWtBZHpmSjN3V2JVRzlYTUFaZFp2N3RKVTBMcXJCSDBXTS9R?=
 =?utf-8?B?NmxjalRaeHRlYXlJeXZCdnJnOVcwQjdFajhKOTlIMUR3ZWFsa1NuZTFSeDlz?=
 =?utf-8?B?MmNZSm5rR3oxMDJQeVM2elFBYjRRRjZvdDdWd2s4OVJHNUs4R1pyT3QwcUZu?=
 =?utf-8?B?Nmttc1lHMHhhS3ZpRGZjNXVxOWZURVJwWkNFUzBteGkrVGxMK3NwNXF0SStZ?=
 =?utf-8?B?em5QdUpGVkVrMUVYQTBUR3c2UzJ5QTd5VXJSVnFON1RKb3dyNTJJcFdRN1VX?=
 =?utf-8?B?SnI4L2VSUTYyWkRPSzE1UGMxMkJMVXNWODl2OE9MamxVNi96bTdvb0F6UGdL?=
 =?utf-8?B?M1k1dW5ITnl6ZkVRYUh4dEFlQTN2RllrNWhvS21QQjlyeHU3anBPSjVVRWJy?=
 =?utf-8?B?cUp5REhoK0NOaEtBaHpWQk9PZU50bUxWTHRWZkU1RHFVV3F4cXBTRi9QM0Fp?=
 =?utf-8?B?TEdnbUJaNkxFekhnU2VjdTA0OTJHSEVFY1ZIOXhvK1ltdFh0ZmZxdy9kUnAz?=
 =?utf-8?B?c1hraHJpNHkzS045dmJ6Mk5tSmxtTnp4T1hnb04zWEw2TjV5WG1leXVKVXdH?=
 =?utf-8?B?VFkvaU4yOEtncGFlQW1ISDQxQ1lnR0l4aUZyNkFyRUtld1lFZEh4TU1MUmZE?=
 =?utf-8?B?eENNV0NsR1FDVzFQT0xoUnRWNXQ3cHZWbHNFcXpucDFxcnJrUmFJS1ZBeEhv?=
 =?utf-8?B?ZDdrTkpZcHNwOWNUL3YvQ0Jud1k1Mm5xRGFOM0sxVWlPb21qOUp6MThiQXlj?=
 =?utf-8?B?VnlhejJPMHE4amxUYnliYmxkWXpCdXVYYy9qWHNnVElhVk4wSmVKZ0hxcHgr?=
 =?utf-8?B?MFY4MEZZcXpzK203dDF0SHdEViswb1Z5VVZIeHZKWllyQXFDcVBQeDFlbXR3?=
 =?utf-8?B?c3Y3V2ZvcFU4RFNsMEtxTUxyd2VhSzJrWTRraFUwS29nbE9MZWhpQVVjNG9n?=
 =?utf-8?B?UGxuNTJRaHZoTXVFME5Da3VMSjJkQnZhNVZacEZyVWNBTEpja3ZUbUNJdzVm?=
 =?utf-8?B?Q08rR2RIMURLbDZPS3FTL3RyS1ZFckR2ck43Zm40aEpnV2VSbzFLbXRVRWNq?=
 =?utf-8?B?TENwWm1KVmtDcG90STBYMHVXak5LVHNuRFBWa2hIRUQ1dTkzakpUR2RzUXl5?=
 =?utf-8?B?cXRtV21FalJreEM0RnZDUVBwWlVyaFYrVHo0V0J0QmcrUXlYbDIvVVYrZURk?=
 =?utf-8?B?U0twWHVKOUxXZVB6eGJVTGdkSVVyVXVHUlFvS1FMOXZaYjhlRFJLaVdJSFpK?=
 =?utf-8?B?cnBoRDRtclV6c2ZSTko1cnQzTUFPNDQyeW41ZFNianNQb0tZSkJBZStkMm9p?=
 =?utf-8?B?Ulh0VTFzYVh4U0FiNmI5QXBSZ2ZCTGNrR28xMUMzTkN4SFNkbjFVUTFCSzJD?=
 =?utf-8?B?L254azZvM3NBcnVnQ2hwZlNkTzRMMkZJTG1mbFBMNlBIYlNSUzBMNEZrRXZy?=
 =?utf-8?Q?4xiHbb/WnpFpP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB5749.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHdUZVBNK2hDNndxdFBmaFlxNFBadTlGTENhWFNTUk1MODAvWEtjK2ljckJU?=
 =?utf-8?B?MFc5QnRsa2dpUjVCWHo4ZThNRFJDUVY3Q1RBSlptTTFXZXlsdjJTOGFCdVNV?=
 =?utf-8?B?NFIzSWp2Qmc3QXVGK3F0bThHOXZ2QTNpMXZ4ZkprY0UrMndpWEVkVFU1UTUz?=
 =?utf-8?B?VGpXblk1WmdId1pGZXMrdnBnNzlCYTNOc05Ybzc4My91WUF2cnFwSmZvYUZz?=
 =?utf-8?B?clpVMGtJQ1c0UlZrNkNTR040b1MwbnkxUTBta3ZTcmVFNkdaYUdCY3U0Yjdy?=
 =?utf-8?B?cnlEejhuRFcxS2FGbm8xNkNwUXREb3FneFVlZDEwaStYS3FUcTdXaHJEYnFm?=
 =?utf-8?B?VnU2dU1LTk5WcDk2VDJITTV1UGIwOGdEbUltYk1CODFtdW1oRFlWOUdOdkVK?=
 =?utf-8?B?L2pQUlpicGUwL2dENWZNVG1uZ0xnQ3A5LzN5RG5jVE1RM1BpckhFTUUwQW4y?=
 =?utf-8?B?WUMycStxVExtQTFaNll3enJMa2NpcG5QSHFuK2FNV3Zqbk01VW9vcFBqOU9h?=
 =?utf-8?B?ZmhqbzUwcVhMSytxVDZWNjZJWnhVaEtCeVI1T2wwQnh3bW5CZ1JtVzFKQWps?=
 =?utf-8?B?MWM4ZytSbnB4STlpS1hTUEhudHBXLzEzbFA5VW9tVHd6VDEvYnVHbmdHZVdM?=
 =?utf-8?B?VU1xalF3UElkaWQ3Z3Q2YnRTZGtZTURkWWRtTnlXdFFNWS9Ld21veEVDK2FY?=
 =?utf-8?B?bXlLZUZkWnFzd1h5VVgyNHE5VWlpQml6NTJsOGFmTTVCY1pxdlU2NEhrN3B2?=
 =?utf-8?B?VzA3VlRpWkp2UzVGTnN5N3VYbDd5blpJZUZZZW5zanphejFzM2lPdHNPcjlx?=
 =?utf-8?B?RkFvaU1UazVhYzQvZHBBWXpOQW5PalFlSUkyKzBOOXF2dTd1MjRqSHdTQnQw?=
 =?utf-8?B?TU1PTlQyVVZ5cVhwVnBQNTdTOTdiZGZaU2FXcnY1VkxSZ3BlV3U1WjNMQjJh?=
 =?utf-8?B?VUpDYzdvUCs1dmZVZmtTWUFXSVNkREpuQXZsTndvQlpERENwOExUeTdFNTJY?=
 =?utf-8?B?WjNMVDQzeGNLek1HdFZ0MXJIb0VHQ2tMMWxpUFBGVXVQQ0NtdmprME51ejYr?=
 =?utf-8?B?ZmdSZWgzSU9INE9leXl6MGEwZWRPQXdOSnVldnJDNGZtSk04U0l5cTREZllp?=
 =?utf-8?B?NkhhM29icUtMV1lCcENSd0RCemJkTGNXYVd5bGM5R3FmZlFSZGRIcVJuS0lD?=
 =?utf-8?B?VEZzZmptbXR1R2ZLbUFxOHEzQ2hRNmpTUVBaSXowMkhNTnBsN1lmWEs2bGlL?=
 =?utf-8?B?Z3pJWm1ISy82NnFuUzNDRG1MVCtxOUNhNzdXNEFGTkFyYzRPbG42eklIOW5G?=
 =?utf-8?B?bzlmTGFxYlpLMzA1UE9KMmQ1NmdZK0txNnI1SWI1eGxOVXRjbmZNUFc4UTU0?=
 =?utf-8?B?T0FlUkp1cWI3RnlmUkRSRUNwdk9JMDg0UmJUMmxDNHRETEZ6amhpZDQzSHRz?=
 =?utf-8?B?SHJzSjY4enFuY3BhRmt0ZTlZMUlZcElvOHgvVDJvNHpmOWhLMnR2Y1NaNE40?=
 =?utf-8?B?aHBVQWJiM3dyMmFObklZMGcrKzVSUk1sdUQ5U0JHbk04ZUxCRjFoaGJuZktG?=
 =?utf-8?B?ck9ROHQ1VzVGRFl0Z3pKNmcweXRoOER6Y0FNZ1ZXcjBUVkxqTVd2V1FGcmdW?=
 =?utf-8?B?VG5JRGk1aDR5Y0RKTklkYXFNWkZ0SUJQZWc2N0JTNllqL3pQUk1HWGFkTFgx?=
 =?utf-8?B?OHZaS2taN0RJa2tiWUdhYzVGaWNKR0E2UHNQaVBraWt5Q05pbmRlZERJUXpu?=
 =?utf-8?B?d0ZHNm51QlJBVkpNZjhmbmN3UVJqRjZhMlVLVUVLUk81YzRNdU9BbWQ3UUtm?=
 =?utf-8?B?Z3R2OVV4RnllclJPQkRKV0l6NFV3VDBaYXBKWHl6UTVVV2lTTXBIRllzSWtx?=
 =?utf-8?B?anB6U1BXM1lwbUxZczBNTWZCVDI3bTlMOEhPenVpbVQwWlhRYVl1S3pCYzVK?=
 =?utf-8?B?VVNzVWZTN3VuZlpDVTkvNTVPbTFlRnRUbUZxd3FtcnNsQlRlUG1ValRoTzNs?=
 =?utf-8?B?S1c4VllYMllXb1hNdUpHbmFVOUVOUm1jYXZKQi9xNkhOS011SkN5bWl5WGtB?=
 =?utf-8?B?dWtDRnRTMkhnRmVEdTJKTkJjb29hdGZ3ekZLcmNxOUNLbmt5WnA4Z2ErWHJj?=
 =?utf-8?Q?bBqFTIglv/CUYYDFYvO38Irh3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r9pmjcS2euq75aD8ti794HAkKV2VcPXSi+472XRwUGQgl49AYbGPDQZNd+ryWQrM+x3nU1cnYKkRIH6i7eNRmJXxPTJLzrvO5m+rf+tBnLUeQcELLY2MPC49FMu7ZVHeZ9gwWtOk4O8gwGoBcaMrJXHDy83ugBIAnH4c7uwxOCA8/6sutSKFi5Cbm9zBAMyokBQ7yTGjKRWsZbdS6dDnsAuKokLbNj+Z7x0xIzUfKx0qs/x0+VeEotbMIJdSgou7ci1x+M0QQP2l9lQDyxEjUocMWJqCtdqJaPxTB7Nk72Wr6j61lzM5RN8eJtoplOFDY2EeSA/KHYyhxSfGOIFyFzk2vro9OhbQumNwOHz61Aug7XUMKgb7rrsNlWCKl2V0sFDL4jbl2zoUxAUvoyhv64+rUx19Xb/ieKtkQ8QsZwWQX3zwCPeTKec20taBnZa5VadDj2lHT96e/X/aNWWfufLdAwKNyVjzHhaMNsRA6TzjoBxCw3DSW/xIDHGnqtO1GnD0cVOqN4/k8E+NdaBsmPHbRS6o12qVuiE2nsCuDaffBq9Uwpv9JJKJQ5V9RHbwKax2WMCdVe7gebs9OsGQSctr5lVgN0Rcw5b4DzFZNEA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44aed241-5f56-4301-9fde-08dd61c09349
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB5749.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 23:49:49.0562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4vuHHQ/FZ7x1uxOgaLPH683VE4Xk/thNEG5BbXapnRHkJ0qMvnUDp09QykItRiV85weNKSlfEUWDT3n6CFsuwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6122
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503120171
X-Proofpoint-GUID: fG17VhblHKvJrmvQSFVQ3Vx3H-n-SfU4
X-Proofpoint-ORIG-GUID: fG17VhblHKvJrmvQSFVQ3Vx3H-n-SfU4


On 3/12/25 01:01, Peter Zijlstra wrote:
> On Tue, Mar 11, 2025 at 09:04:47AM -0700, Libo Chen wrote:
>> When the memory of the current task is pinned to one NUMA node by cgroup,
>> there is no point in continuing the rest of VMA scanning and hinting page
>> faults as they will just be overhead. With this change, there will be no
>> more unnecessary PTE updates or page faults in this scenario.
> Its been a while since I looked at all this, but if we don't scan these
> pages, then it will not account for these pages, and the pinned memory
> will not become an attractor for the tasks that use this memory, right?

Hi Peter,

Yes, you are absolutely right. It will skip change_prot_numa() which 
marks an
VMA to be inaccessible (not PROT_NONE though) by setting MM_CP_PROT_NUMA 
flag,
without that there will be no numa faults on those pages, hence no task 
migrations
towards those pages. But that's how similar cases are handled such as 
hugetlb or
MPOL_BIND pages. If you look at the checks !vma_migratable() || 
!vma_policy_mof(),
etc, the rest of the loop will skipped if one of those is true. I am not 
sure why
it's handle that way, maybe there are some old discussions I am not 
aware of, I
personally think task migrations should be allowed even if the pages aren't.

Consider in most cases if cpuset.mems is set to one node, the same node 
assuming
it's not a memory-only node is probably set in cpuset.cpus as well. I 
think I can
add an additional check on CPU affinity, probably needs to add an helper
cpumask_to_nodemask(), so something like below?

+	cpumask_to_nodemask(&current->cpus_mask, &allow_cpu_nodes);
+	if (nodes_weight(cpuset_current_mems_allowed) == 1 && nodes_weight(allow_cpu_nodes) == 1)
+		return;



Libo



>> Signed-off-by: Libo Chen <libo.chen@oracle.com>
>> ---
>>   kernel/sched/fair.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index c798d27952431..ec4749a7be33a 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -3315,6 +3315,13 @@ static void task_numa_work(struct callback_head *work)
>>   	if (p->flags & PF_EXITING)
>>   		return;
>>   
>> +	/*
>> +	 * Memory is pinned to only one NUMA node via cpuset.mems, naturally
>> +	 * no page can be migrated.
>> +	 */
>> +	if (nodes_weight(cpuset_current_mems_allowed) == 1)
>> +		return;
>> +
>>   	if (!mm->numa_next_scan) {
>>   		mm->numa_next_scan = now +
>>   			msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
>> -- 
>> 2.43.5
>>

