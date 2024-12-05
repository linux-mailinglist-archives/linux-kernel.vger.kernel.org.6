Return-Path: <linux-kernel+bounces-433153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A82539E547B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B60628105E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D092116FE;
	Thu,  5 Dec 2024 11:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="EoQqtwKi"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2046.outbound.protection.outlook.com [40.107.255.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49452116FD
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399264; cv=fail; b=FblkzYgvohFDSZEhRh/XIP7vMj+H08rYr7dJ7CZ7Xzhf1FB2HfeGZCYkwq4t2yF6KZlZpfMx6t5LTUUgorQDmi/pvUkIPqi+NLDpwYOfgXYh8+Ab0ET6i5/zwNiAWX6RjppQ/Ap33p/72VqAOTISjgsc4TADjzYnY31L/xB45ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399264; c=relaxed/simple;
	bh=fL+vWuqsBeqfbowhoDw8bdNyrJ/UQekv3dLaiyjmxjw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DJO599vuacuGiCN5ITc7ewTuMTKrciYjTzp6mm02E4ftmCAfF78ZVHvYF7OW8uUYZWdD+sYG4+oXCuph21S8ZSpGMg4Qv6M/KpPJM5rUYhz+tn8BwQfP7+6xsZUThlF+wB12NyIWAvJ5qGC8ACSXQ+98Hk2jjAbzeQAH23w4L64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=EoQqtwKi; arc=fail smtp.client-ip=40.107.255.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhVaQ87ZkEIvcwhwSahlFCQ9LvzEuE3hpOVJLi8Wm3+wnQelgXqQyiEKFmqs9SmyPGstrNo9nid0iSO6GYsmJdnt8dDYG3gHKYO8NSyEPaMN7KdeTJPN5+tppIJbBG4Hp4iBdfhtU8Wy8q6p/0F+9LoVIrv0Wj8L8EHSKiaIJzM5fzTZM+fJ8MEg7OSYH0kOttNO54JZSC7Z8XH0Sq3Br6wp1szumFrZHNGmhcd9codnVJ9n4MjDjBVHJWhP9pBbI/9A5GRAvkv9CNcj5XjH1vm3ySIhtHploXrhE6wfmH2kT1VqJMrFaCGwgTwWLfHOj2osdPfGSp5cItDBS58nCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fhtRCNkrhaYJTQhjGe1lIs3ZpFexmv5YmaQdMCBcAk=;
 b=u8vjEpG8nPZYD3Vsg20S7/huQDihm3M7pyo54Ih8GBUuGUH0DYKnoAFSp1we0FvCdWLDc/Q/pbAYLSepao6N9lX7ywwdbm2PVOacYtnt9wSFUlj7NtREGNlidqhXQZQ1SBf9fxd9RHVndCisJ+Xon0iwsMw7dx9r2wPL03m5K6xWxHCnCbY2dTWV4ZG24WIyHH9ND6zMAhLTts3ffiLDA/pRBehtBrywcFESgeBmQN5pJPwSfmC2ivqaG+Jv3Dw+lds67VwZYjfyfMV0RC4+xQswmrtU3q2xZ+ld42ZcAL+USIkNzJpKN5ST+bNQQxrMn7b9vJJEHqzH2tRUbk+mMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fhtRCNkrhaYJTQhjGe1lIs3ZpFexmv5YmaQdMCBcAk=;
 b=EoQqtwKiMKWybglDbqa/ZM/mF6/EJ9dIP7ANoIX/jtHHQlLGKeISNpltCYB+o+4Vt6mMin59dKfFyUePsLiSeGc/MKlZQM63wPxy8IRy3X1ehk9Vtbe0Qe1egaDb/+mzDE5iXGTXbbJou7gUaAF4PWYAGXcoWqK4Msr7o0EshD0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SEYPR02MB6014.apcprd02.prod.outlook.com (2603:1096:101:6b::10)
 by TYZPR02MB7818.apcprd02.prod.outlook.com (2603:1096:405:68::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 5 Dec
 2024 11:47:40 +0000
Received: from SEYPR02MB6014.apcprd02.prod.outlook.com
 ([fe80::bb06:c283:a50:7796]) by SEYPR02MB6014.apcprd02.prod.outlook.com
 ([fe80::bb06:c283:a50:7796%5]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 11:47:40 +0000
Message-ID: <315a726a-bffc-4ba2-a64f-abccaf215946@oppo.com>
Date: Thu, 5 Dec 2024 19:47:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] f2fs-tools: Check and fix inline xattr inplace
To: wangzijie <wangzijie1@honor.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: chao@kernel.org, jaegeuk@kernel.org, linux-kernel@vger.kernel.org
References: <502ae396-ae82-44d6-b08d-617e9e9c4092@oppo.com>
 <20241205034035.3119810-1-wangzijie1@honor.com>
Content-Language: en-US
From: Sheng Yong <shengyong@oppo.com>
In-Reply-To: <20241205034035.3119810-1-wangzijie1@honor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To SEYPR02MB6014.apcprd02.prod.outlook.com
 (2603:1096:101:6b::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR02MB6014:EE_|TYZPR02MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae7fd24-6ed3-4dfc-e939-08dd15229efa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGZNcjNtbmdXUlBROGZyT2dna0UvL2c3cHc2bjhHVFVydE9kOCtUSE9SaTg1?=
 =?utf-8?B?SndvSWdoOUhDV2dmTXovS2hFYTd2UzIxenNqNjJ1RmZrbUFoTTJ2NkptMUh0?=
 =?utf-8?B?Z0RDemhKVU9BNEdaRDBmSG9udVFMTUpKT2ZneUhXbCtSWlNFZHQyd3J3dTY3?=
 =?utf-8?B?UDdJMW9KL3NPeU0xaVV4V0hVZldpeVJBcXk2Q0p5ZlBzL3BQZ0kxVFdvTjRS?=
 =?utf-8?B?bVdqeXNmdUgrZ1JMazduc2JZd1d4YVdUS3F6Z0JVSFZRVEp4QTBNM2lmSHV3?=
 =?utf-8?B?bCtIMFFsaHdtR2dOa1phMmZwelBlc0lFWUE1TkxvY3VGc3E3aWZ1b2ZMMVZa?=
 =?utf-8?B?OE4xUG02OTluWXpxV25vVnJRY2s1VVdiajdwZ3hMUVZwVWErUVJndHdZWWhi?=
 =?utf-8?B?cjRzWFBlZk9iZ29zZjNtVlBSeFphR3FDbXc3ZTRTV2x4L3hRVC84eGJjT293?=
 =?utf-8?B?L0ZnaU5sbTRTU0dWMXRJZ1lkdHp5aVlhUGY1WjB0TkdVelUzblVWbzcxVzdJ?=
 =?utf-8?B?Z0NsZ01TR25pUzBvbnl0ZDZtS24zeE1OYitOZmtKWUozZHgrK0QySGxSTXVG?=
 =?utf-8?B?RGhUZk1KNTlXaUJ6UzZiNGtKSVAwUjZrbWZjdUZMRGIxdnNYQmxtYkZuYVZz?=
 =?utf-8?B?KzVCNndFQnpmaFRmQ0FYV1FoSVRGY3hmbW5KbEYzZmlJYzJMT3FNQ3doOXRi?=
 =?utf-8?B?d0lEVi9nL3ZzVE5QNTF5M0w1YVo5akt5TGR3NjVmMXRJRTh0RlBLeVdmM2tF?=
 =?utf-8?B?dFBWSXA2L2x4Q3FpcDdWaEc3dUJaQkRFZ3BNT0pxU29iR2w2SHlLVmxtbXNK?=
 =?utf-8?B?ZUdZZ3oybXJYc2VCNWlvV3B1bHFPUXZWTEtycGJ4YTZuMnBaUlZ0VE0zdEov?=
 =?utf-8?B?R3ZrNDdzbS94cXYyRXIzeUd5ZWg0V3o5bEovKzhDdlkyVmVmcFhBYmdaRk9t?=
 =?utf-8?B?enRkeHl2RXQ2dUNFa0g3dUk0NVk0YkFXeXlTZTBXeUo0LzQ5enVKTUlOVWhj?=
 =?utf-8?B?Q2ZwMVZ2NzA2RTNraHVKTXlVcXlqOTR3dVpLbUJ5UXo3R2dob0JVMlp3NUJn?=
 =?utf-8?B?QTBSQU5NMlNUWDhJZFMyNFRPMUNpUUVYMjZYUVhMZnQyaStEY2VlOWhLRVc1?=
 =?utf-8?B?V2dMbStUTEN0SzVaTTgrZmhmSmsxelpUMXIwQ2RsR0lOOW9wTXl6dGtRcXBr?=
 =?utf-8?B?QVp6dUREOXlKYlhGN1UrbElnck5sL0NqVHdiSXQ1NnIyLzBBWlY2Q0dQQjhW?=
 =?utf-8?B?S1JRWXZjTGhNbkdzZGFaM3IyUnNZcFN1VlJ5aUU0RCthVEw0VXpObFcyR2Rz?=
 =?utf-8?B?cXRXcGNRSW9IWlZta3p3cmdrRm5XVWJ5b1E5RVVxWXZkNjRCNU9HSTZldzlD?=
 =?utf-8?B?OEZuRWFLNW9ERFZpd3J5ZlJ6STU2cTdFbVQ1RGZOREhvZnptL1NqalRMUHg0?=
 =?utf-8?B?QU4rM2l2RFJud1RIMCtBVm03bmRoN0x1enJlOVNqWWI1TzVBRzhGUlVQOGZu?=
 =?utf-8?B?dU9UbFJITDRoWUpHZmE5UUpiTmI1SFYvV0ZxamMxekQwZ1pGMUVCT3NnMTla?=
 =?utf-8?B?TlI4Rk9YcG43VkY2ZjRncG9COWhCU2MxVWFFUityRXc1Nmd5SnRKek9OT3pT?=
 =?utf-8?B?bzZIdVkraWZaZGlXeVFkR3NSemlkUlFxS2kzbVR6cy8zeE8yVmNxOHFyRytB?=
 =?utf-8?B?VFJ5VEd5TzRCV1orZnNjTmMzN2tGb0VrSGpKTXphQVZtYUptbEorZCtuTHVN?=
 =?utf-8?B?WWVEaXBDdlVJdnVYdCtQRWR1NEVQN0hGRlc2M1llL3ArV3Axd0N1a1JCZ1dn?=
 =?utf-8?B?K3Q2ZGlTdG0wNTM1TVNlUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR02MB6014.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTR4WDlHSDBsdTl0eWlVQ21LeXlMaFBkUWxkQStkLzJXdlM5TWI0QVR4NnpY?=
 =?utf-8?B?clNSeDczUHd3NlBqMTNWSVAwMGdwZ3R4QS9DcHdmMVlUbUdXenVQL3AzZWNI?=
 =?utf-8?B?ZzMvUjhGVks1NWtndUFQR2dKTEVRVnZBYWxselZhM3hZendzSjdjK3ZJNzcz?=
 =?utf-8?B?ejNmSEhObWxsUEt0bWlGUWpyVkNRUFQrU01EOTdCKzJSNnRXZlF5QjFLV2gz?=
 =?utf-8?B?ei95TnJ4WG9EcUYwNmhkRGcrbVR5cFE2a1NYNnp5S3VaWGQvR3lYbnExNFRT?=
 =?utf-8?B?OGgveUhFMGsyNlB4eHFJS0ZWamRiRTZQZ1JDT01EUjRxSTNUZ3hqdEswNDlr?=
 =?utf-8?B?UUp1cndORjhxd1pBZFdCMTdXNWRiY0MvRUN3dXVuMWlFWDNhMVJKdWU1aGpz?=
 =?utf-8?B?aEVTMzR0bENUdU9FaHI4MXg0Vi8zUHpmd3N6T3lnMDRvZHhlM2ZRSkNpZ1VY?=
 =?utf-8?B?ZnF0SDRiUWJIZGVZTWZXcDFDSHk2dk9oYXRSYkpxWG9jdVN0NGNqWityYmFp?=
 =?utf-8?B?eU1ObkpDdlgyZ3g4Ym5rdEJqcGsvZ1VJY2JvOXVpUXdRWWxwbTdjMUlGSE1j?=
 =?utf-8?B?NGFEV01wdUw4VFFlTFVML1NnditpUnZqY04vU1QyeUlZaElrYnlIQ0VxMkRG?=
 =?utf-8?B?Z0lZTU1oTWpzV3BvdWNTbHFBMFJXOWIxZkZiZXg1aTNXY25PdktQdHpDMmVx?=
 =?utf-8?B?cDlaTENWelBFMEpna25McnQxamJxdjArUEx5cWgrTk1ROGh0M3lOMG8zYWtP?=
 =?utf-8?B?bDJsTkxuUTFleW10dG1RS1YwMm5uT21GeGlKOVpDTGwxQUVVNy9KZE9CcCtX?=
 =?utf-8?B?SFFTSmxUQWQ4eUt3YkhKL3M0ZEcxcVZ1ZjNQOW0yWXBHMWt5QzhVMFc1d3RT?=
 =?utf-8?B?c294NjVPR21MTlpRSS9HbWJERjVQTENsSG8yc3RCSXYySjdrVXhpRnA5OWcr?=
 =?utf-8?B?dGZNQnBOdHY2M2ZuVDZjOWVXeGIvSVRGZEUxSzVBVDZPSHUvaHpQVW9HdmFz?=
 =?utf-8?B?NThGbWJldlRzTVliWEJ6cC9pR0hFTmFPWUFsb2REcWhLbU9HNkZhRTFqSjZP?=
 =?utf-8?B?YnNOTXVkai9Pcm42UmxlOXIxYjRvdkxZMVdZTVRwZThkTmQ3WVhRQ2t3cXdW?=
 =?utf-8?B?STBhT2xyRUNiMTZiM2pUQnFKbUVacTlZdmU1K3h5aEE1V3R4N2E3TVBCbzJt?=
 =?utf-8?B?ZmZteW56YnpydlpWSVhYb1o3K21rMWVZWVBWU3RFbWVxRGUrbVFmUzlGdmMz?=
 =?utf-8?B?dmN0ZThleWRnclJ0SERYNEhFLzQ5clJYRjNsb1c1VDFpMVJMNUN0SjNweWZL?=
 =?utf-8?B?MUZHT3FHa3BTUDEwM1dTWXNUZTNtRlNHNEFCUnZVNFM3cEt0R1FYbWFWN0dR?=
 =?utf-8?B?SElqZ3NFNXpXSTFTaXBBaWR2KzlWc2hjM0E4ZG83YlBueDJ3cmd5Mit0cTg2?=
 =?utf-8?B?MjRLRWNsSktrZXJtbHdHbit2NkRrL0trbFVpbzU4d3JLZGhKQkw5Z0UzUzR5?=
 =?utf-8?B?V0dLQ09DQkhUOXc0aVF2UklYaTlXbDNmWWNUdXRaQjVCWmhMUWc3L2Z6QlJ3?=
 =?utf-8?B?QWhYMURaS2lCUXMvV2t2amdJTllRNEdoS3VDMTNySE02SG5zRW0rL0FabzN0?=
 =?utf-8?B?RU5BSlViSGE4NGlVekl0SDI3S29rQ3FjRklCbWhOZW9LTUZyNytMbmFidXlw?=
 =?utf-8?B?Kzh1c1IrcEZuclhibXVDS3FQVy9RK0xtS2NWZzl1UnZIempoeGM3RVRNTWRs?=
 =?utf-8?B?Wm5LbEVxaU9JWnI4bWQ3cnd6TXhxZ1VpNmlCOHY3VEk4S2FYUGJDejgxbXNG?=
 =?utf-8?B?c1gvRTV5ejQrOG9VVWc0VUxwOUc5ZjhSYWtlc3RUNzlUK3pBTW9WdlROdThn?=
 =?utf-8?B?WCs0aW9teWNuSXlUNENheEpLM09EN2NjWHdlREZuZ2gyYTg1V1UydTcwekI3?=
 =?utf-8?B?Wjl5cjFCSXpBckdCNUtFK051SUFmY3JsTnhEQjFnZ0J6V1NLTWRYQWZkUUFB?=
 =?utf-8?B?cSt5VER1TFJESU5SWVVuZjROR0RMUDFyTVVCbWtaS2twbkI3YURUaTJSc1pv?=
 =?utf-8?B?dnJzUEllZmRaYVZVdG9iNklBSVRMc3dZa3ArcCtLQjBrQnVrQlNxK1JUMU1z?=
 =?utf-8?Q?Kxm3ZnFrS2poJo4D5Zjis9Ljv?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae7fd24-6ed3-4dfc-e939-08dd15229efa
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB6014.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 11:47:39.9198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IwoaHbS37GntV9L5ntqQ5aYP7nOAU3MIqFjaYtwqRBBhFfuo5UefnOJHQKCyScK17+FIziuDEoGBVAmDgPxRiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB7818


On 2024/12/5 11:40, wangzijie wrote:
>> On 2024/12/4 20:23, wangzijie wrote:
> 
[...]
> 
> Hi, yong
> 
> Thanks for sharing what you proposed to do. By the way, I noticed that
> when setattr, read_all_xattr will set xattr header's magic and refcount,
> but it seems we don't check these values in header(kernel/fsck). Should we
> add check logic for it?
> 
Right, but magic number and refcount are not really used, I think we could
leave it as it is.

thanks,
shengyong
> 
[...]
> 
> 


