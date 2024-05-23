Return-Path: <linux-kernel+bounces-187078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 735BF8CCCD3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27BE3281658
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF8113B5A1;
	Thu, 23 May 2024 07:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="Eh0MnQ0g"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2057.outbound.protection.outlook.com [40.107.241.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004123B29D
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 07:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716448626; cv=fail; b=gQmyQzlz19hZuvY+M/62dcaqzucnG9atAP1gDyy2o2s9OZaTlR0uaTEyLmGvYtDPe5uYztah5V1tLs6BEwwjsoR8nDD8g/Ev6L1MQGq0wLfWNZ+qGorM860MCGjpQRsMxO3djY2DaEGSE3NJYt/7PijT2oiL+F85xGJkUUJgAa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716448626; c=relaxed/simple;
	bh=7IP7aIpoGgzeVSXZmkvl91soFOkGpLycu1KYFH18dsg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W6LJ6wgqKZHll/+WZtbTnNKv3jNuD5N3FJjoTKYj03t+WdpU+SjRx/d7rnaA4tCRzKGhd2Q7MlNxb7jfgPpP3INLVWu7wcN0oe0VqSrS7GqGe+puivjgLWQgqCVvB1hl1WElGVtClG4OTuu8XWBndf2YhYR0zxmhMCBCpLk6b8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=Eh0MnQ0g; arc=fail smtp.client-ip=40.107.241.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsqc8DU/xEC28Zm13H4Gm3gj9g0cIPn0UNVzrat7OdzLdqU2d7L/pNIPqopH/nXM5Je8z+vptBEiHYIAbhYq2DMISO+B9Aad/9RrZ0g613KClrbdAbs1ar1lWGJGryneT1qj+MEGM8JzBZvq1TA2ZZwczmW477wRRM+W9MIxyaZ9e3CWORYNBwdU0jToUfnZcgWZjaR3vxcte1e/mngKUTLbQ7d7IiYvVNftLDS87Ek5cNAYqGkm+bxvnUm7yZX0jyg7lLUehX37I1JeP06vAL8dIumeVpyAa+/QTSOkehLx2ShIC9V5Qs0Y5OH0joLx11J6Xd+TlzaZhDy/c9RyLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5g6l5Zk5g7VcXTUBT/+ZtB80eliemEGPyr+Q/GC/yk=;
 b=RvOyFGkjrR8RWI2M1ycqBqEJCzmkn6Xfk71do/mBpVYBBTzTuL1yoJSBw6wXVyO4JS6zwk8o1n2K/R6rqee0aQyvkZQgj5EkhLimeMN/x5H/Q1iyVFhInkrYINHtaOq81hfDddyy1kklVK45MmgVlH/jZq5wIISC+Ay6Xa3wfvSmbJBcBiXr9Xc83JnWAoJLNPHNPJxbL99DOHml6pe7Djs8dB++sYJI+O++tIq+KcFRdP01bZ6AvJsXxZMBDu4HSmorvaZjtWlhdeWmnKuf3qtRoMpCWoSDDXS2oqPNvWfaArEvRL1zq+VjC4mSP4a+EzRTiXE5OICrEbA1JOJmMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5g6l5Zk5g7VcXTUBT/+ZtB80eliemEGPyr+Q/GC/yk=;
 b=Eh0MnQ0gMDrGAEkEN1weJjyS189pGvpPDYeP10lasAC8LX93jwclNNrH8sy9RXXRonWbsScH0qR2+AJX1jh/fmbMvpqkm6+/dv8tblT6ZOZ2HoYkHrBzFdcUZD79FRvN/ZBClCs117sKXNjaHNUqtq8EWJmQqISIo9zzMhP6iGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PAXPR10MB7951.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:23e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 07:16:55 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 07:16:54 +0000
Message-ID: <d225dac2-501b-40de-b9d9-305a9ebfff51@prevas.dk>
Date: Thu, 23 May 2024 09:16:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH workqueue/for-6.10-fixes] workqueue: Refactor worker ID
 formatting and make wq_worker_comm() use full ID string
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Yafang Shao <laoar.shao@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Jan Engelhardt <jengelh@inai.de>,
 Craig Small <csmall@enc.com.au>, linux-kernel@vger.kernel.org,
 Lai Jiangshan <jiangshanlai@gmail.com>
References: <o89373n4-3oq5-25qr-op7n-55p9657r96o8@vanv.qr>
 <CAHk-=wjxdtkFMB8BPYpU3JedjAsva3XXuzwxtzKoMwQ2e8zRzw@mail.gmail.com>
 <ZkvO-h7AsWnj4gaZ@slm.duckdns.org>
 <CALOAHbCYpV1ubO3Z3hjMWCQnSmGd9-KYARY29p9OnZxMhXKs4g@mail.gmail.com>
 <CAHk-=wj9gFa31JiMhwN6aw7gtwpkbAJ76fYvT5wLL_tMfRF77g@mail.gmail.com>
Content-Language: en-US, da
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <CAHk-=wj9gFa31JiMhwN6aw7gtwpkbAJ76fYvT5wLL_tMfRF77g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0104.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::21) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PAXPR10MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: f52dbf51-6563-47a4-c628-08dc7af851df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0grUTZDZ1NJUzZPVmYrald0c2p2dU1iMWlxS1Fra2pTSnNkN0RiQkNGaEww?=
 =?utf-8?B?SmU5UjFjZ0JMdXVrMDR1ckF1SndTRUdEOGwzMWZQTWNzaWJDV2pwcWtUeWRp?=
 =?utf-8?B?eDFWb3h6cFZHMXBMaDFSQncvek1IOUJZNUNNNXVWWmZRZHdNbmpPUlNCSXcv?=
 =?utf-8?B?a2VIZjZsUzRJNTBpTXlIL1BIejkyNzhLMVFaekRxS3UzWVNxOHJvY2VacHdR?=
 =?utf-8?B?TlcrNFZzRldnTUg0VTMvYU1YS3hRdnpjZUUzSkxHWko1TS80b2dseHdCWm1W?=
 =?utf-8?B?TDdDZWpwSTJRN3dxdEdHRnBGNzU4YzNVbHR2RnltNVZyQ0szMW4yQnV4M1A1?=
 =?utf-8?B?TlZ4eUx4R25CVFJXbEdBWGV6QzZKK0RTTDNBNHlibDBocTBCKzhTYzAvaXVS?=
 =?utf-8?B?dk1ZQkZtQ3dkenEvNEQxY3JDNVN4aVh4S3BlWmtQTUUwUGY3M01YZjlhZ0ti?=
 =?utf-8?B?U1N0dTcvNlFqWldRUlp4YjUvSm55TmxWWTNCWThSaVVzT29ISFZVeWREMXVW?=
 =?utf-8?B?bDF3NWxlVWdIWm42dzc1Q3Y5OXJ5aXNLVHp4VFR6RHFXUlh0OW1HT2ZwcEFP?=
 =?utf-8?B?cGtOeFBuVUZWNDdoYXQyckEwckFpUnZuM0U1QnBjMGZqejRlZWsrbFpwUnRB?=
 =?utf-8?B?TDZUNk52dENDcCtFekovUWlQZmVEN0JBWVFsV2FpSDR1cGl3UGVNVzFoOWFU?=
 =?utf-8?B?QVZleEVDR0dzV05nUjM3VkZYL0RWcDJBeVNHTXpvMWtDQUtWTWY2M0NQWi94?=
 =?utf-8?B?R041eHpOeUNPU0pSV2t0T0YwdnZlOW03VjFaM29TSEpjeUxOTDMramVSRmN3?=
 =?utf-8?B?eTk3ckUrdnFnemc0YmtpRENtV3JWNlBHNDhtbHgxWTEyZUtNMVZYbVpSNkdj?=
 =?utf-8?B?eTh1YUh1STdTWWp0MXQzOWtCRkdQMGVZR1cwaTZEa2phWnVITHNDY2lkbGxy?=
 =?utf-8?B?ems5Q01BUzdnc3M0bzNYWFJXZXk0azVscHZZeHNxM0MvQUl1bFlHckMzdWJG?=
 =?utf-8?B?eCtTaXhheWZMVFRaVXVlTkU1RkRqL1VLU0FLQTY5M0FGSWZlaXRBSUxqK29U?=
 =?utf-8?B?OHNwY0VhZjJDS05SMGFtSE9mb0pVYUgzZlA5S3EyZndSK2wyTlZib3Y4b2Yy?=
 =?utf-8?B?VlUxNDJ0Nnpub3h3Um1YQ1pIVFBTS1U4aW9rc1Jza0RheGRNYXV1YzJ3WWtW?=
 =?utf-8?B?eUl5cG1NNjdadkJZMWgrYTJmL1hNeU9DYlF6aUF0cHFybmI3WW1LeU5kZVlH?=
 =?utf-8?B?U0VpMEJ3TWxMT3hDLzdFaG91VWt4SXhkbC9aMjBrZllKbzVpWldxWVg4ZVcw?=
 =?utf-8?B?bWpWa1FmelhPSDg2SEN5NlZENFIvYUErZ0NzbisyVW1TWlNQamR2cmpkditx?=
 =?utf-8?B?cFpiQUZPczU2bTNYN2dNZ0QzQjFqWkt3N2ZuYTdCRXdQSmJaenVnN1VITjVl?=
 =?utf-8?B?Z1FqQ3NIYTJRTTczSjNGOGUvZXpYMEpLK0tkdGhjQjk5ZWlaSWZ5dTdpS1Rq?=
 =?utf-8?B?a3RKZlRqVkIyS3JOKzVTUngrdityYWcrOENVOVN4TEhqN1kxeUxKUzA1Yito?=
 =?utf-8?B?T2dCb2wralZqOE9qc2o0M2tGcG0yU2pUUkdJbzhab1ZaOVVSb0NkWkx5OU1K?=
 =?utf-8?B?eVd1Yi9PN0FWYldodEtjdU4ra0VzaVBHc21sMXNOclo3RFpaVzViQUNPb3BR?=
 =?utf-8?B?dHlOZVlYQWFiV0xoNVFtTEp6WGM5VTNwS2NOTUlsakZCUFNvQy9DcTVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1ozS2s3OW1XMHByVHpSN0drUVIweEpaaS9sWlE3My9NV2NpOHV2UnplQysr?=
 =?utf-8?B?Vk9SVFlPWUwrMWJBZlM0YXV2QnlXc2ZzTjN3aE0zeitIdXprbnU1QzlTY0tI?=
 =?utf-8?B?V29xQ0hRb3pXcHVsckYwVzNEOGdYdEFPWDl2UlNRWVNmVm1aWnI2WURUT2sw?=
 =?utf-8?B?aFRQU09aODRJY2NQRk1xQWpnS01lR2dNbzBkY1AwVDlaNlMyUG14WFFwQU5k?=
 =?utf-8?B?cDg0Z0xNN3d3dE1UeTlveEMvd2pKcWFXeEEwZzRpNjlMRmNYWnZhOE9MaGR0?=
 =?utf-8?B?c3BIL0EySlU0dWJlNisvWDRFNnFLWktLczBnVTlhMWplcXM1dGVVMllWYVFh?=
 =?utf-8?B?QldJd1JKOHgzby9kdjRHZjhMZlN2cU1oTGZkUHU4Qm1NWHNvZ21LQXZ0ZlJu?=
 =?utf-8?B?Tm1UWENXZW11b3ZybTF5NTJXWnFodHlZMXBpOWVxNlRpTTQrV09FWTZFd0pr?=
 =?utf-8?B?aWtIdmJVT3FMb2JtYTd4ZGF1RmZxNWR4djBuWXBxSHc1T1NCOGh1akFtQ1Na?=
 =?utf-8?B?THEvOTN3UU1VKzdJNXR4b25jeWFFcjZab3dPZ0c1S1ZiSVhhUVEzdCs0YUFy?=
 =?utf-8?B?dmxMbzlWbmx3L1g1b0duYU1hdWVtZkVMNEVUOVlWVlFZQ1JxTVlxZFNZT1U2?=
 =?utf-8?B?SFhsVjZGenpSM1BQaU5XcWUwNlphVERYR0VrMzlBcjhHKzE3SUQxdnVoZmFJ?=
 =?utf-8?B?R2V0cDVOV1U4VTd4d05mRGhaQUd0clcyTGZpb1NINE9SUzFWR0hjUjhUdW5M?=
 =?utf-8?B?WCtTKzc5bVF2Y3d5ZUlrVXVwTHR0NGkyZVh4MklwbjZOcmZSc3o4eFRRTDhE?=
 =?utf-8?B?RUE0OFQyN3lTajNsaFNwS0NYcTc1RmlrU2svVGZ4SGZDZXYraVR4SUtkSklY?=
 =?utf-8?B?dG95Z2RRR1VUbzdJTmRmU0I0Vk9hUnFDZDhCYUZjaEUyWjh2UW9zLzd5Q0xU?=
 =?utf-8?B?aSs0T2NFM21FM1lFWHBzdGhjREk2aDhQYXlhS3FNaFVxSnpla0pqdkgza2xH?=
 =?utf-8?B?dFhHS05DcnRtWER0Nkl4dkJMeHFQNHhtRnBMWEVIcCtHRWFaS3ZPOXJKTkJT?=
 =?utf-8?B?TmhSRElaZzZpMFZyVUdTY2kvdzFZb2Q2NUNwY2JUcWdJSXN3TmJVd2M3aFg1?=
 =?utf-8?B?Mnk0ZU9TaWxRaHNHOXZoSzlseHNIUXFVVmhYYzg0NlNCNHdWbUxpZWhlRWJk?=
 =?utf-8?B?dkJWWTZaQTNVVVhXVnpnYUN1eStGaXJBcTdRSXdKNXoraU9PSzJRMUgrTk5u?=
 =?utf-8?B?STVqSDQ5Q1RFTDhRbFBWOHRNTXpKQ3BvSGg2aENRanM3U0ZBS0RNdnVWWkhG?=
 =?utf-8?B?dVlJTHZlalgyampTZ2hVVlhGZGFLcGJuSGJTTHJia1B6SHJwY2JwdlZxWHg4?=
 =?utf-8?B?N3REYzJCVFhmVGlkZmhuOUtoRmo3cnJsWTFLRkpPcFFjbFBZS2ZjTjRLY0Jx?=
 =?utf-8?B?cnhnd3Z1b0EwSUJXUzBnTFIwN24xOHZzZTM2NkNZYS9pLzN0Lzlmd2oyYmpy?=
 =?utf-8?B?dDJQdXQzYmhMSkpPT3ZVMkdWNkVvUUtyamREWHhraGFEVkJqQ3lwWjNKeEFX?=
 =?utf-8?B?MWlKWHlNOTNJVTdkUTNJbDJqODlYdG9KM1VUQ2ZIOGovcXJuWTNocWdVRmVk?=
 =?utf-8?B?STBUNTZBNDEzeVlPRGREL1ZaVk16em9hTEFuU204NzA4M1UwV3dhTEp2R09m?=
 =?utf-8?B?K1VPMGhwakZiREY1aVN4QzkwcmV3Q0N1T0xrYi9KeWtsZ3o4Q0RLYXRFa3Fv?=
 =?utf-8?B?VjBrNVdkWW1TaDBaQWJETjVoeEtJZGFJdUhrOTNWc3psRlY5a2Vsci9QSXc4?=
 =?utf-8?B?ZlFuZW1hdkIvdkxwSzExMW83NkdYdVpXYlhJNEZPcUppSGV0RUZZeE5OQkJ2?=
 =?utf-8?B?NFlvd0IvcWkzUmlQMWZ5NW5sT1R3QWpzTEFiUVZxalY4ZlVYMkt2QlpHNXZY?=
 =?utf-8?B?ZHFkK3lJTkFRUEZCa3I1OHpTRTJ3RFpRRTd0NEsrcW83T01IRkNNYTZ6MkFn?=
 =?utf-8?B?UUtkTGt4emtiY1puMFFvWlhCZ2puRnNMK1BSazRIajYxNGszKzlaUzdnYXV5?=
 =?utf-8?B?OEl0S052WXBNSnB1SFdublE5SUc3YlZaMkhJUHg2WjA2NVQ1TmVBbnpOWkFw?=
 =?utf-8?B?UXM3Q3l0K1k0ckNtcE12RFk3clI4aU9JREZzdElQb21Kc1NJMEJkcURuNFRU?=
 =?utf-8?B?akE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: f52dbf51-6563-47a4-c628-08dc7af851df
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 07:16:53.4832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQ2jF0mvUcnC8846LtBqvcA8Z7XtCNWi8E7rKs5q2vdkPPfEVMcpDdiMNCPDSF6okZTAh7NJWJLCvHf4i/3KV+Isl6+fPApeUgnPeZ2et9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB7951

On 21/05/2024 20.05, Linus Torvalds wrote:
> On Mon, 20 May 2024 at 19:34, Yafang Shao <laoar.shao@gmail.com> wrote:
>>
>> We discussed extending it to 24 characters several years ago [0], but
>> some userspace tools might break.
> 
> Well, the fact that we already expose names longer than 16 bytes in
> /proc means that at least *that* side of it could use an extended
> comm[] array.
> 
> Yes, some other interfaces might want to still use a 16-byte limit as
> the length for the buffers they use (tracing?) but I suspect we could
> make the comm[] array easily bigger.
> 
> But what I suspect we should do *first* is to try to get rid of a lot
> of the "current->comm" users. One of the most common uses is purely
> for printing, and we could actually just add a new '%p' pointer for
> printing the current name. That would allow our vsprintf() code to not
> just use tsk->comm, but to use the full_name for threads etc.
> 
> So instead of
> 
>    printf("%s ..", tsk->comm..);
> 
> we could have something like
> 
>    printf("%pc ..", tsk);

The alphabet is running out of letters, so if somebody goes and
implement this, I'd suggest making this %pc thing take extra modifiers,
so one could also get the pid or whatever else one might want to print
from a task. I.e. %pcN, %pcP, ... We could of course have %pc with no
following letter mean ->comm (or "real name" for kernel threads) if that
is the most common thing, which it very well might be.

Rasmus


