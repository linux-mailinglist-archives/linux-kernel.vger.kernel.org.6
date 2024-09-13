Return-Path: <linux-kernel+bounces-327539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E392B97774A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 05:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7981284D10
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 03:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005B613B280;
	Fri, 13 Sep 2024 03:22:02 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E81B74402
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 03:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726197721; cv=fail; b=PMRRgMG7JwrIx2nA6yQx6Q1o1QpLFmUZ9rssZOGHCa05s18PKdzSjWc4wxHOoNBw+c/Z2tzQV83x5G9/owSBO8IJpiAfdxYQ97dokPnKgZ9tnQ0MB1imvQC15CIphE1dL/SXn7BG+q+vxeR0liEDE+vw1HA4bGJhzBn3VCN2uGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726197721; c=relaxed/simple;
	bh=uaaV4TZZc9WrM2+GJaRIouJl0jnHDmd1wABgAkXq4eI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HjiC6Mwf2wS9yD2BMjRV+yTMO2NmuVAEjjYcQjyCmLwAlDtLwCM5hufl3PfPzlcurzYn44rGyZNEKIp0PqbKkNBSW3PvWQgm0OB8GegoiWp6QR9pFEk/mPv1ytvSYqNq8OmkqWtbmy/bk7QW6MErm08mmmK54FUULbsAC1hpwuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48D2jhxj020862;
	Fri, 13 Sep 2024 03:21:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41gdt8pu00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 03:21:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/ES1ulH2BdxT86cbTcbcgALOUKD5nGK3iTCePxelbHDtcr+vpSGwRW4OINxxcCr9/IZoSKmC4D/YLI8gp3PxVJ0U12JBCZUMp+Mf/O3dMR0voqN6iL3nbzGhOLnIycUTLiKcQvF3/yyFChin6MPnMOyvTiaNhktbV2HtIsZ7WMnteBKH3RMI55ck30U5CiUPmSjwaKhGsjwTBbmxr5WBadtSu4ZH8aQr7tauQAqB3M64nWZaSDEfGQPYjkbW6WRfHoSlZ+ldqmvAbUrZ280pH1+ObghS4BAWHcl5T+jXVyRktj8j5mLojUfEBxpAEjhQc+lnFPZvsBVr112wUSNYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRZRaBsYtsq35UBrqfhGc0ij7quGTrPtnmYTafJQFMY=;
 b=jAOMaPUTdoUxBGWkejYkUBuxs9gQ6cXywNg27vf3WWY0lQpnyAaCjiYrArOPzXauIPVw2ddSsaPKUOVBNTKCgv47Ng3V3DtyTXMzpOpK0qMjEnXgj5+v+WSoGlopf41SyXIX7F/raoWDUY7pwQipupV95lgbplKfE93yHfcitnwPa065yj58tFuK8NBnsjOcs6hWivjwqCMWGXQYplVwG88yH7AFdppg3Vh316/94gWKcKGtA12EAiWsXTFJ7Y6T7V68xWxTFjJ7kC5FtNIbUOuhn3yn8zo/vVEob25aIO3VaDiyfkBg91FbSuwkGUwxvDfjIt5eN/wxDRHWJISDZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB8189.namprd11.prod.outlook.com (2603:10b6:610:18d::13)
 by CY8PR11MB7899.namprd11.prod.outlook.com (2603:10b6:930:7e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 03:21:47 +0000
Received: from CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4]) by CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4%5]) with mapi id 15.20.7939.022; Fri, 13 Sep 2024
 03:21:47 +0000
Message-ID: <b8b86241-4452-4096-b862-cf3e2fca6b1c@windriver.com>
Date: Fri, 13 Sep 2024 11:22:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Porting fix for CVE-2024-38545 to linux-5.15.y
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
References: <2c7135e8-c279-4307-8264-179eb69090fe@windriver.com>
 <2024091224-deepen-herbal-3961@gregkh>
Content-Language: en-US
From: "Yan, Haixiao (CN)" <haixiao.yan.cn@windriver.com>
In-Reply-To: <2024091224-deepen-herbal-3961@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0181.apcprd04.prod.outlook.com
 (2603:1096:4:14::19) To CH0PR11MB8189.namprd11.prod.outlook.com
 (2603:10b6:610:18d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8189:EE_|CY8PR11MB7899:EE_
X-MS-Office365-Filtering-Correlation-Id: bcfce5a1-af5d-40a8-004c-08dcd3a33308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEtQOG42SVQ0cXNNVmZyWGRuMStuM09KYWhpdXpscTZiUkxGUTVyVFczTmsz?=
 =?utf-8?B?bnorck82eDVFY0NsenlpMXc5UDZ3TmkwWVRKckViTktsWG1tWUNXTmIyb0Ft?=
 =?utf-8?B?KytHRU5IRHFZVDFmNE9CM3JZd1RlNnQ4T05Tb2tvL1RNMHVNRkk5ajg4cjYr?=
 =?utf-8?B?cFN2WmhvcG5FQ1psSllHaEZiQ2kzRkJpRTlIU2o5ejVTWW83ZHhhTXp5RmM3?=
 =?utf-8?B?MFQ5bFd0ejRwNUlzOGRSM2dDM0dMT1orTDV6cHNnQlh0NXBoWU1KYjZlNFEz?=
 =?utf-8?B?OVd4cUxadmhRSGJ4TEFuSDVCem4zenB4QjZlTGYydXFJZDVIR25IQ09xZmxT?=
 =?utf-8?B?MnVCZDZhVDFZRE95VHlXa1dJTmVldWY4TjZhS2FweVZIeDVyVW80bmpVdSti?=
 =?utf-8?B?Q2p5b1U5TSs2UmRtQ3ZYYUpRUm5QRm1yTlJ5L3JCd0hDMlB3UnNEbTJkY0ZW?=
 =?utf-8?B?R0hXNjVCK3ZEM3Q1UXJEd2tRQWJjcklwVWZyd0ZsWlo1emRtSVd6Kys0Rndl?=
 =?utf-8?B?QVFuUnhNMlFrdGtPNGRGZUhBK2FENWw0VXFCeTBKRkwwWG03ZE5qSm9HZkF3?=
 =?utf-8?B?d0hpSGhaU0RVWUFaS2RMU0J5Slk1VTRZWUhRS2twWUtyVlVteDJaM3BVTmcr?=
 =?utf-8?B?T1ljMWdrT2tocmhLTU9FR3RJRGdaVE5id0JHdVJWTThrbFJFczlTcjQ2Y3Fl?=
 =?utf-8?B?UUhxYWMwSVpFYStJK0dHMTN0MUowUDRuYm1aTDZRSUJTcGRnaGhaTXRPYlgw?=
 =?utf-8?B?em9acDlXRkZJVUxGVk1YQzllTCtUc3AxcFVObVd2YVNlanJNZE5mMFQyUWFC?=
 =?utf-8?B?OW1zRmJYZXFlS05OOWJXTStxV0NadFQ3dDc1VEQwWFJ4b0NQZDFyV1NsbVJC?=
 =?utf-8?B?N1Z5eldPSFQ4Tm9HOVZyRnlNa3dVYlZvaGJPRWZuQzFsVXRWUzhWUW0rSzVJ?=
 =?utf-8?B?MnIzbkpsVmJ4WUJzcURvK1UvTlZuRDREbXRWRlk0eUNKOWFYV2Y0b0NIYTNS?=
 =?utf-8?B?UVlka21hMjdvUVUyUUx2anVFOFVqWEJTaGFoY1VLK2gzS2RkU0lrYXE3Ykgv?=
 =?utf-8?B?eXVmUmtmSlI0ZmdMOHQ1cnZ0VGNlUzBVcW1NbmZEZ01LeWZDTU1Dem5WYU0w?=
 =?utf-8?B?OHdhTkljRnBDdjNNOW5HOEVCdWREM21mRkZFQm1XZnZmbkhDM3dGSGN2YWZC?=
 =?utf-8?B?NG5PSWJzcFd4U2dmMXZPVmxiQ2J4dmhOcitjNHdkZGF5YkhtQWEyS2JJUDc1?=
 =?utf-8?B?eGNTa1Q5MG16VHo0Q24zNnhENnZsSWowZ3c3aDRGbXNqaFhneU5aN0pkM0V0?=
 =?utf-8?B?TzdtSmtIc1ZkeEwvVzVLVnN4eW1YeDQ2T1lQcmpyVkhuSHJMNHVDWHlncU5F?=
 =?utf-8?B?NUNaTURxUEVXdVdYMXJUdXcvV2UwREJMV2NFN0FseXU5Q202cnhJU3RmS1d2?=
 =?utf-8?B?R0xObTh5MXlrR1NkN1A1YzlxWGd4Tmt2WEhBeXZ1RWhSY2hTTlkxQ2xjcEJN?=
 =?utf-8?B?QzRMRDlDeHhFazVFc3pFSFlIQzZNczh0bU5GUWtvbU9BU3R6SlBYL01aZENw?=
 =?utf-8?B?WEF0UCt0YVQwN1VxMHoyM1R6dzA4TVpPSWtmN1cxVCtsWTM0VVJOTFcybWJi?=
 =?utf-8?B?R2NJeHFKVmJ3Rmd4cDRsWGRNOWlsVWhNci8vUFlXWjVVbzRWdGNxamZwWlV4?=
 =?utf-8?B?SWZ2dTBGVSs2Yyt4VjFDU1pUN1JZaTFzMWhNUHEwa0I0LzBpaVhKTFJINUF1?=
 =?utf-8?B?bGlsZzZVeGFHZDRvM29RNW9mOFg1SC8xMGpsb1huUUhONUQxWjlRaklrNXdy?=
 =?utf-8?B?ci9tZmxHQllPKzdlTWhVUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8189.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnRzRXRtK1A4ZGJmMTNJS0JXUndKd2JNYXk3cStBUlp2QjVmemFMVWI1SjhE?=
 =?utf-8?B?N0JqQ3JaWmx4ZE9LbTJ1NFJRWWxhYzdrb1NRMXU4bGgxNmdsc1ZsTDI5cU1x?=
 =?utf-8?B?eDNSblZyelpObzRlVWFZa29HUTBCY01JWjgwUk4wREFPWkhoWGV3WGtZSzNJ?=
 =?utf-8?B?MENkWFFFdjkxRWZZOXNNZFFpK0lvY29RdEdYRWQwUm14NDFmVU1tMk02bmFs?=
 =?utf-8?B?QkNwdFBSV1JXNGZtVW9sYmk3cktZSzBzdC9PWGlRekt6Q2F2bUY3NS9jQ0p3?=
 =?utf-8?B?cHNTcVEzLzJ0enM0d2NnY0NNTGMxME9tanV1cjkyNGYxVkFXcFZCVXlxQWJj?=
 =?utf-8?B?RHYvbFBrWEVvSWdvVlN6c0ZuTkhVcVJCbFUxSm9DMWMrQ25BV0toYjM0TEhy?=
 =?utf-8?B?Nk9iQjczbkU5VU9JNDY2bHhFd3hsK0RvNFkvQjdVYzRRUnQzNmR4WjMxNW12?=
 =?utf-8?B?Z01FZ1RMYTlIdktWU3NzQ3hiaUVZQzhWSEtBVStXUkpwQk5GZjdFdXYzUEpr?=
 =?utf-8?B?M0R0L1hRZWRkeGNRNHp5d0RCSEgxa1I4d2VwcEpmaTZ6VXYrWXBITVk4V0ky?=
 =?utf-8?B?b0pVS0xNSE5WN3JtZ2pLMWcrdGlaMUJ4U0NsVkh3eTllV2xzZzlxUXZuNmRQ?=
 =?utf-8?B?K3ppd3M4cWhFVHV1L3k4VUEyMjlReGVvdXVMb2FHSERiMGFaK0F2N2xLV0k2?=
 =?utf-8?B?bEM0cFpjLzhpeG95TVViMGowZ3E1WHI2M0xDeVo0RlhtaE5HUzZIMHVvdk1i?=
 =?utf-8?B?Znd1T1dwa0RDemE2dWM5UXY2OW1TS0dnVC9XNHhUNWVySFJUOSsrMHFzdWZY?=
 =?utf-8?B?eTRJUE1lZURZUXZnUGY1ajJWREo0QW5XMUNPd3Rhc0ZJUU9scU5sUVRaeDJs?=
 =?utf-8?B?SE5WT1BDTW9IdVVRbTg0dVV5am5VUmVyczd5TEFYY2c1TEhGS3lRc3pHcnpM?=
 =?utf-8?B?VU4wNDAwbTNlVTNqU1NLT1htc3F0Y05HeVk3Wk50N2NBNTdBL1ZPQytXc0Ju?=
 =?utf-8?B?dDFEWC80d3B1Ym5hZ2pBLzZGYjFLYXgvZ3VjQk41KzJUQmdOSkZNeVJZZkJT?=
 =?utf-8?B?WWltWkJ0MEVadUIvUm1hcFk3cjlxdllIVi8xeGhFSjFEd3pJTnRuUEVWaUJx?=
 =?utf-8?B?aTBsaU1NZXJqdGs0TVVVSEoxbTNoZWgzMWlTWFpaMUd0bGFicTRzZzV0Tzd3?=
 =?utf-8?B?QWVEQytYUEJKYVNGNG00QUJCeHJCb0pZRFJWYStxbW9zVVhIT0J4SDFKazZi?=
 =?utf-8?B?RnFRcXhKK054T3FQYjdlRDNlYTJaUm1iSWNPdUJSWGJtdS9UQUJOcHlBSHlt?=
 =?utf-8?B?ZEV3WUxneGVZbTMwbkJmeDNJL3JKbEM0WUdmZWtxcDVCK01WNFJoVFo1T0lJ?=
 =?utf-8?B?MUZzUkxvZkVBMW9MRSthRURkMHVzdWgwTmsxZkFnY29rSldZU3V5ZU5FTnlp?=
 =?utf-8?B?MGNEc2Z2Z1ZDZkNhSFdWcUpyYlVCUjB3YTNTWFVNWjUrdnlFeERpWjIxN2F1?=
 =?utf-8?B?NW9XbUtOSXdHM2MvRG9iaUpkMjhvMzlDUk5EUUg2MWJIWmpwYzYwa3ZqMVJH?=
 =?utf-8?B?TFJGeDZtN1d0Sm13K1JqWjNySHRINHlLWlBxa0MrUDR4UE5pMzhBc3IxT3Rn?=
 =?utf-8?B?QTlvMEp6ZDlndUdrNUgyNWNpdGpTZjVTVllFek1wb0hvWitaUWxBcTZJWjA0?=
 =?utf-8?B?bU91MTdRRUwzQ0dXKyttaGhEcStxZEphdGl5ZkRlN05rSFQxK0RIQXU2U2VE?=
 =?utf-8?B?alk1a1pjbnRWSWNEbXRWYlN1d09td2lSOWR0N29wSkV4QXRRdkZHd1FQRzVY?=
 =?utf-8?B?UlIrYytzOFUxN1pGWGM2UDBKRXdOUWNyTGgrZlczNnZUcXFZZExrTm5JdXZK?=
 =?utf-8?B?WnJ6UUtRNDdNdEMrOThvL2RHaGVzejBKc1hlRkdDckVJZ3g3M01ZRU5xOEtk?=
 =?utf-8?B?Yk1ZM1dwNUU4aUw0RS8xM2RuMnFyekxwSWNFTzNCUzRZOHp5RlJOM2xIeUM5?=
 =?utf-8?B?dmNQL041VnJZZG1nVDFabGU1NkNHTnp1SGVIVW8yc3hqZ0E2USt5RjJJK1dq?=
 =?utf-8?B?ZmJLajgzbUQvbFBIaVVGQlhXNVYvZzlnZDlTaHY1Mm5zT0VQQ2duQ1dIVWhL?=
 =?utf-8?B?L09QNndmNVl3UnJXaXJTMU5yZWxrOFNYa1pOTnBNc2x5T1dEa0kyVkFCY09J?=
 =?utf-8?B?VkE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcfce5a1-af5d-40a8-004c-08dcd3a33308
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8189.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 03:21:46.9946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kGYY8KWc4bgmj40mPJAbj1YhFLNViEtRdOUJ3UAtKaTbS1Ws0vkzW3ZXCrA0nvQGuE+v/l/ZKyIGmbqE8RkJMiP9JFN8lvAXjFKgY4jVV9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7899
X-Proofpoint-ORIG-GUID: KmDQ5g7bG_nVyjrGFUePPdkKb9Wl8MNr
X-Proofpoint-GUID: KmDQ5g7bG_nVyjrGFUePPdkKb9Wl8MNr
X-Authority-Analysis: v=2.4 cv=a+hi9lSF c=1 sm=1 tr=0 ts=66e3afce cx=c_pps a=l9lnEPKonMfu/vbXsUzXcw==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=bRTqI5nwn0kA:10 a=VwQbUJbxAAAA:8 a=Rn79HQWYH2hxiF3RMMAA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_11,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=828
 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2408220000 definitions=main-2409130023

Thanks, I will submit the patch to 5.15.

As I am currently using the 5.15.

Thanks,

Haixiao

On 9/12/2024 1:05 PM, Greg Kroah-Hartman wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Thu, Sep 12, 2024 at 11:33:47AM +0800, Yan, Haixiao (CN) wrote:
>> Hello Greg,
>>
>> Could you help to porting
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=a942ec2745ca864cd8512142100e4027dc306a42
>>
>> to the stable version linux-5.15.y
> Please provide a backported, and tested patch, for that and submit it to
> stable@vger.kernel.org as the documentation states if you wish to have
> it in that kernel version.
>
> And why just 5.15?  Why not older kernels?
>
> thanks,
>
> greg k-h

