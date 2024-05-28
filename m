Return-Path: <linux-kernel+bounces-192409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 323D78D1CED
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B55B71F2605A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BD516F0F3;
	Tue, 28 May 2024 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yD+5Z0xc"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC95316E87B;
	Tue, 28 May 2024 13:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902870; cv=fail; b=ZM49fbi6juJa4ISpIYmZz1rzjOthBSztHWEgrRsxUMXAV8vauGB4fPnbZ0pSmHNL69ZiSrhPHZRQwOW2T6kyH10AH1KTUYNKTS8P9DFQhKZEuxKMiVF24CMA7r5VzFC1TO7MynbhFjQNpJ7nfBIzrwSs23TSA+q2J3ePn8mweas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902870; c=relaxed/simple;
	bh=9PQMqMkoM6Ar+xtzEYyQmzi7KHN/YS4fz0j6avHl+t0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E1LPsYqSa89lTUac+1KpaP/hpuqJ6haQo/ozBgbhTnOjgAJNhZk7f433ipkqxZgWkd7mY3FGx+8vI3PMh3Bhp8nkrqm++FAxh1pKPwI3Gre9wnLwhmod6uvCEa02+QUuAwCkQmm4mLCAiLv3HZhS70gCd7R1YloB/GtYH0t+fAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yD+5Z0xc; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I52TO0P3+AnMJOl1535RipDUKwhPr6iPtBkSTSjqqWQUF7rMvEfpAulNM2KLhOkKacgLXUCDqK+nVsfM1F2KXi6OGuIeTxZx2Lhi3hJLN/ksc+5erGFlvlfaGVsneg91iJpKtW8hh50sU7dah75gfrsqBTGLa0bB3JHUE5TFPvYwu7XdDFV2Lf1oMEqPOZy+j1HKGoynIuaAqHYKvcflRXnAqb0bFu56kaXQEQ69ALp5DUePCedFrPMiRJmNQ/yRNqRCeL5WV9ePsxJgLjX+D9TUURLqJ0wjjFD2IHd88wf8DuWLXypY9uOAm8Fc0VrXbcyld2gnC2l6GgKOJQMiSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/YYdJU5AGMhi487O+VI3dtAVsSSg29VgRTCsEJQNmo=;
 b=CZ0/viq0cmdZLARThbFh4jzR769GsMLRdZ2I0bLZDgEECQmfuWHTsrrPa3hvxR63qp2SDCLEzXcj5NNyPV3XyjmuHhKbCix9cG59cSThG7dfdBqX2IKX/LOcTxE87fOMnQTLWJUL2EQXqdRDvaC6Ymxri5TPDbnlMhqxzUBXheiP0Loya032ihMjKD+BqgIUg7jh+PKraxiZ2uHoGiB6D2nsGaijyXqVP3Ci2Uec8WcyAAtTk8GpUjxb6N3NPF+DdZRh409RFGgMzQUzF+kvSqdrdJ88TEZ4cxXD07CY4khw6isuZtOZgXPih0fK7oJNj6InZduMClO3c/Eg435wXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/YYdJU5AGMhi487O+VI3dtAVsSSg29VgRTCsEJQNmo=;
 b=yD+5Z0xctUkOKVrHgpo/oFvjVNe2EHeFJlbkWOu/ksTJc6hKZljSkEP7Qbe4in2R3MV/DS4GqnPKAt3bY2G8d9h8OuEs4GqQPcenb9mgAbr2xSK9ZxnApWpXLVIotsCTwtWfEMRIUgjLoyMwyymN4fiWE6K7A/LojpawaOM1rWw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 13:27:46 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 13:27:46 +0000
Message-ID: <5f4799b1-0606-46a9-a347-5a03738db341@amd.com>
Date: Tue, 28 May 2024 08:27:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] platform/x86: asus-wmi: add apu_mem setting
To: Luke Jones <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 corentin.chary@gmail.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240528013626.14066-1-luke@ljones.dev>
 <20240528013626.14066-9-luke@ljones.dev>
 <6f4bc109-00d0-47b0-a581-b96a6152545c@amd.com>
 <4d6b9171-7248-4937-87de-7e921ed8e507@app.fastmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <4d6b9171-7248-4937-87de-7e921ed8e507@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0037.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4236:EE_
X-MS-Office365-Filtering-Correlation-Id: 39198313-9703-4dea-d5d5-08dc7f19f5f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nm5tTm1lQ01PTDlVejdnRG9rT1JUUms4Y2RiRDJDRnY4WTlGdkJpRWx2ZlZG?=
 =?utf-8?B?QlE2MHJaTVF3R1FvUERPR1A2anhnQ0tNUjMvdWdlcit6MTZXeUxLMHFqVHF2?=
 =?utf-8?B?ZzJXV1lQcU9hdWl4RXphZUh0TXV6WjhieS9LVTNzT0p3UDVHUVJRcmNGTFBq?=
 =?utf-8?B?bm5JMWNpT2Z0WHNqQ1dTY212bVZsZHVsUnhGMDRLVlFteHdJcmJIUS9CQTVY?=
 =?utf-8?B?ZGFzeXU5Tlo5TzRVZmJpT2hRUllXSEhCL1ZKVWZrd0cwSkJpb3IrQ0NLQVov?=
 =?utf-8?B?RSs2dzVXbUxSbXZHNE5INzRsZUFBUGcwaWNOZ25ydWRieTMzQldLaFM1V3dH?=
 =?utf-8?B?VWhzdVFibi9Rc1AyaVQ4R1hRWVMycHcyV1JSYUZQWGJhZEFSTTV4REZ1dU5C?=
 =?utf-8?B?WHJyTDh0OWlqS3dVdUY3bFdNVGlkRm9QcFYvOTJHbG9CUFFQWlZyOE5LN1px?=
 =?utf-8?B?R1JwbzJZZis4M1phU0NxUHBnS2lBcU9rRW15YWNZalVVdFhvU2NBSG1SdDBG?=
 =?utf-8?B?aFBzZWlZblN1aE9PcUV0eWlHdFhCZmFpVlZtd01xZC9RM3lvZFRGVmNXK3I0?=
 =?utf-8?B?MWVhOW5RMWFGTUVzemExeDRyWlNIeSs0a2J3N2tPTzQ0ajFDYVo3NGZpQTFP?=
 =?utf-8?B?RWowSndJczZYZFRFQU5Za3pJZmp1bzZ6Q2RReTBNZlR1emZkbXM1MTYxNnAx?=
 =?utf-8?B?RDIrRGFaUm54WVk4Zkd4amhHb2ZPYVNxY1ovbCtud1cxUEFxdXNvZWoremEx?=
 =?utf-8?B?VnhqL0ZZUHljYnZXbjJERUxlSEl6ZG82KzlyZ09uT29Udk9GS3pvajJzbHlr?=
 =?utf-8?B?bmFsQTV4N2FObUpBRExhbUkzYWhKNnh2aFFtVG9WVmZxZXo0cmdGOGgyL1BN?=
 =?utf-8?B?SU9tNXk4ODRodFJSSG15bVg3NkpLZ0RrWlpqcndiVzZ1S0Nhdjd5aDh2Ulla?=
 =?utf-8?B?eSs3U3VBYjlCOUFHRE9GcGY1MVU0V3RraXRKOExBY1VhUHdESnlLMDRVWTA5?=
 =?utf-8?B?OWppK0thdXZTVWgvZFlrSTJyL0RZelNhNUYxQlYwZ2k0ek5ET0tvbmExR2ZC?=
 =?utf-8?B?cCtXWTZUU2FlRHZ4SUNhbTVuR0krOURCQzJPWktoU2tXK2pDYWRSRVZWeFZP?=
 =?utf-8?B?UEYreS9tMTZZaXNtemV5NzhyVlFFN2V5UStKZjZVZVJ4b3FBNDJtaUVBMGJI?=
 =?utf-8?B?YUtndXNsSHlnTWtPa0o4TWVMNmxvM2tsdlQ1K3M3VWUwSGp3di9lazlEc2FU?=
 =?utf-8?B?TUVvb1draCtzeXFOZEM4Z3FPSVNtd2lHWkVkelJWQldtTlZqMUtPY2tmQVd3?=
 =?utf-8?B?dUhvMzVnZEdqRURzcUJsaVM3ZGhGZGlMbnM3cUp1dWY2Z01nb3FMUmNzV0w2?=
 =?utf-8?B?bEM1OW1JM2piUnJROTEzUGlKRTdDaUhjVWdua3pXQk4rZFdKOWg5LzJaZElm?=
 =?utf-8?B?MkRtWnkxNVY2WkZzVUdWOTZOZFZZZ09ZMWwzVVFtMEZUMkJqL3gwQnFsM082?=
 =?utf-8?B?Mm9sMkJWVEFUWlNPSldmNHZnbEMyNlB4QlJDWU1rR0tYL0gvQVVYTGNGNVdT?=
 =?utf-8?B?Vk5lUmRZWm9PcURiaW1zWlNhM0RieFowMjFyMWZXMGFyaUlVcDA3a0RsVWdD?=
 =?utf-8?B?eGpVVnRNbC9YOVBSdkd4eWExa01CK2tkbXpNM3ppb3dpcUF5TmxCdFR4RnI0?=
 =?utf-8?B?c3FqaXBDMUxpeTNrK3VxQWhTRUVzNE4walVkbEJaK3VESjhnanVrR1pRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHExSERaejc2WDNvOVRGRlliempUV3VqVG0zWk1BZW1oRk1Jc3lWa1l3bWps?=
 =?utf-8?B?NHdMcXZSd3NlTmNUUC9mTEd4MGpyS0JPWXVKK3kyM3doYUhjRUJ3cTB4MjZK?=
 =?utf-8?B?eUdDVk81N090em90T3Zjd3NRNCs1UnFxU1Jqc2h2MHUwVnlUZDUyemhKKzdU?=
 =?utf-8?B?akgxdzN6QytkMUY4T0hSZm5idHdKUm84S3pvcFRVNW5PQ3g0a1FFUURtYVYr?=
 =?utf-8?B?SkUxcEdITmtyUEtmbDNLOFA1b080ZUhUV2xHbWxrdnNFdTdEN2lMczNlU2tL?=
 =?utf-8?B?YzhZMUtNS3VDVEVmcW9BZ2J6Mkc2QWZ3ajVvYXJNSWFQWHhhUUdpajc2QWxi?=
 =?utf-8?B?M1dCNGJ5TUZxdkswMldYZlk1T3EwVGFtTzV6cHlyRTJ3dGxaK1ordHh0VEVQ?=
 =?utf-8?B?VVZXZHZtSG1JMjZxeFdiTndaOGdWbC92VUFNaDlCS3hvNWxqSSsxZSs0MWJT?=
 =?utf-8?B?QklBdFBobmNZQWlINTN6Q21JaVFHcko2M0JYakJzempiMVBJaFgvR2k4T1pV?=
 =?utf-8?B?aUxxb0NrQ2RjNGRVTUwwVXkxV2c1OFZMRkE3N0lrN0NVTzJyYVZmZEdDcTV6?=
 =?utf-8?B?RW5EalpUQlgzMVJvWDVoTzNJa2xnaWFTeUxqVzUyWUFCL2E0QStlQTJ6ejlX?=
 =?utf-8?B?NUNma0ZvZXdCR2RMVjVFNWZySVRpa3hwUEtJM0FZZ29mRXd4RWZoRXBZVUhq?=
 =?utf-8?B?bUh5MmR2SVBqZWRWNGlCYi9nRGQraVlZdmdSQWxUSWdiODNLRnlnRjRvV3N4?=
 =?utf-8?B?c2UrUnZCUlFCL245emxTd0xsWTBoSHhyc0xMVGdZUktNRVhtV0MwQ0ZyRlBT?=
 =?utf-8?B?dDZvNEoxT05zUm94U2o0eGJTby9yYlpuVVdEbVdBeWVuVHg1RElDajd6anpF?=
 =?utf-8?B?OG83cHV5eEdxemVIUW14ajZpbVBIY3ZpcWFPTHg3VmhSRXM4RDlxSzhjbCtn?=
 =?utf-8?B?d3l4WEszMmhEQlg0SDRUTFlnNW1hNEU2VDdtTHp3Z0xpNExZYzZDamNvTHQ3?=
 =?utf-8?B?Q0grdjYrWlh1MmtnNEhwdUs0SjA4SVVhOUx0Zm5YS09wZHpXVzNMZmlnbWp0?=
 =?utf-8?B?ZmtYNmEybnhjUUk4MFFrVzZkb3RpamZBeGk3OGNjSkIyYUJXMVRoSUxFVjdy?=
 =?utf-8?B?a1JmZVpwRGJHTHZFWUNocnc4QjdRUGVZK2tvVVBaeG9pL2ROcjhZNTlaeWth?=
 =?utf-8?B?ZVBFS2FmZlNoKzhyVHd6YWd2aUVqaUNaZjlmQjV0Wm9uQ2tHUnc1Y3NTSXB4?=
 =?utf-8?B?WVcvUUxHM0hwYU1Qb1cxdSt6bFh1KzA1ejdhQmltWnlsMllJK2ZxTlo1OFhT?=
 =?utf-8?B?NFZaVFdzM2svWkZ4WmxrYUxRYlpVUWpWZ2w3RVZaK081NlpaU2FwZjM5TElw?=
 =?utf-8?B?cWNrUm1MZkxqK2RCL0U3ZXhmdTFka2k4TDBxa01WUVVxSXBrck9GNnJkVU5q?=
 =?utf-8?B?aWw2UW9NZnBnNmNieEl1Q0V2NDVwSFBOUlYzWjdtV1lCd2pTTHA4WG1rcDRZ?=
 =?utf-8?B?eXU4cklkUHU5STd0MzVQbVozNm9USzVkRTNna0JWeFNBKzZxUXJtcGxQdldR?=
 =?utf-8?B?VllQOWxUUHU0dSs1Wi9lNUpKQklrNnBIS05vUHptdGl5MzhtNUxoS2V2VnpX?=
 =?utf-8?B?U0JzN3JMTE9ma1VPL2VrektLRW5BYjMrcWNlRURJUU9JSGQ5VUp4SWRRaG94?=
 =?utf-8?B?ay9QaDNCZ3ZUSERkZjhwckdkREFOZ3RkR2VCZHcwMVVkdGFrSnA2d1VqTjU1?=
 =?utf-8?B?STdDT2phUUtKY1E4M2tTZVRzNjI1Nysxd1U3bHRqTWViZzdWVkVLT2JlSzkw?=
 =?utf-8?B?OVNyYWhSRGZyZCs5dm4xZUgrVURxdjB4YzV6VlRoK2s2c2FsYlkxbU53emY1?=
 =?utf-8?B?TER4aXhtbzBXQ1pGYmRjaTIvREV6L0x2L2F0VzZLcitVNEtZRnNYUDJqeUxi?=
 =?utf-8?B?YkgzRjFhM0xNUGhPMDd3dFhkSXoyazFDRmQxd3JlZnRkSlB5NmRoR3piS0tZ?=
 =?utf-8?B?d1JXcGg0VDFRaEZERnpWVW01eHJrbGpCMGpZa2FaWFRaQXFRTGMyNERmMEhM?=
 =?utf-8?B?N09KWkxpdjI1RkxjY3A3UWlSL3N3aE0rMDZ2a3NFQUhYbEh6R1dqMTZWY21y?=
 =?utf-8?Q?/Kp6UB5r7m/D1miHNedEBhr3K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39198313-9703-4dea-d5d5-08dc7f19f5f5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 13:27:45.9249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KrmnKIrJUcCisX/URoe3s3N20wtFVgkbx79uj50xs6ZDH9q18ClJ+jklM9VLgMHvCt28l1URGIz5YeEQJGgbVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4236

>>> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>>> index f62a36dfcd4b..4b5fbae8c563 100644
>>> --- a/drivers/platform/x86/asus-wmi.c
>>> +++ b/drivers/platform/x86/asus-wmi.c
>>> @@ -855,6 +855,112 @@ static DEVICE_ATTR_RW(cores_enabled);
>>>    WMI_SIMPLE_SHOW(cores_max, "0x%x\n", ASUS_WMI_DEVID_CORES_MAX);
>>>    static DEVICE_ATTR_RO(cores_max);
>>>    
>>> +/* Device memory available to APU */
>>> +
>>> +static ssize_t apu_mem_show(struct device *dev,
>>> + struct device_attribute *attr, char *buf)
>>> +{
>>> + struct asus_wmi *asus = dev_get_drvdata(dev);
>>> + int err;
>>> + u32 mem;
>>> +
>>> + err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_APU_MEM, &mem);
>>> + if (err < 0)
>>> + return err;
>>> +
>>> + switch (mem) {
>>> + case 256:
>>> + mem = 0;
>>> + break;
>>> + case 258:
>>> + mem = 1;
>>> + break;
>>> + case 259:
>>> + mem = 2;
>>> + break;
>>> + case 260:
>>> + mem = 3;
>>> + break;
>>> + case 261:
>>> + mem = 4;
>>> + break;
>>> + case 262:
>>> + mem = 8;
>>> + break;
>>> + case 263:
>>> + mem = 5;
>>> + break;
>>> + case 264:
>>> + mem = 6;
>>> + break;
>>> + case 265:
>>> + mem = 7;
>>> + break;
>>> + default:
>>> + mem = 4;
>>> + break;
>>> + }
>>> +
>>> + return sysfs_emit(buf, "%d\n", mem);
>>> +}
>>> +
>>> +static ssize_t apu_mem_store(struct device *dev,
>>> +     struct device_attribute *attr,
>>> +     const char *buf, size_t count)
>>> +{
>>> + struct asus_wmi *asus = dev_get_drvdata(dev);
>>> + int result, err;
>>> + u32 mem;
>>> +
>>> + result = kstrtou32(buf, 10, &mem);
>>> + if (result)
>>> + return result;
>>> +
>>> + switch (mem) {
>>> + case 0:
>>> + mem = 0;
>>> + break;
>>> + case 1:
>>> + mem = 258;
>>> + break;
>>> + case 2:
>>> + mem = 259;
>>> + break;
>>> + case 3:
>>> + mem = 260;
>>> + break;
>>> + case 4:
>>> + mem = 261;
>>> + break;
>>> + case 5:
>>> + mem = 263;
>>> + break;
>>> + case 6:
>>> + mem = 264;
>>> + break;
>>> + case 7:
>>> + mem = 265;
>>> + break;
>>> + case 8:
>>> + mem = 262;
>>
>> Is case 8 a mistake, or intentionally out of order?
> 
> Do you mean the `mem = <val>`? Those aren't in order, and I thought it was easier to read if the switch was ordered.
> 

I'm wondering if case 5 should be 262, case 6 263, case 7 264 and case 8 
265.  It just stood out to me.

If that's all intended then no concerns and I agree sorting the case is 
better.

>>
>>> + break;
>>> + default:
>>> + return -EIO;
>>> + }
>>> +
>>> + err = asus_wmi_set_devstate(ASUS_WMI_DEVID_APU_MEM, mem, &result);
>>> + if (err) {
>>> + pr_warn("Failed to set apu_mem: %d\n", err);
>>> + return err;
>>> + }
>>> +
>>> + pr_info("APU memory changed, reboot required\n");
>>
>> If you're logging something into the logs for this, I'd say make it more
>> useful.
>>
>> "APU memory changed to %d MB"
> 
> Agreed. There's probably a few other spots I can do this also.
> 
>>
>>> + sysfs_notify(&asus->platform_device->dev.kobj, NULL, "apu_mem");
>>
>> So this is a case that the BIOS attributes API I mentioned before would
>> be REALLY useful.  There is a pending_reboot sysfs file that userspace
>> can query to know if a given setting requires a reboot or not.
>>
>> Fwupd also uses this attribute to know to delay BIOS updates until the
>> system has been rebooted.
> 
> Oh! Yes I'll queue that as an additional patch. There's at least 2 or 3 other spots where that would be good to have.
> 

For any "new" attributes it's better to put them in that API than code 
duplication of the BIOS attributes API as well as a random sysfs file 
API that you can never discard.

>>> +
>>> + return count;
>>> +}
>>> +static DEVICE_ATTR_RW(apu_mem);
>>> +
>>>    /* Tablet mode ****************************************************************/
>>>    
>>>    static void asus_wmi_tablet_mode_get_state(struct asus_wmi *asus)
>>> @@ -4100,6 +4206,7 @@ static struct attribute *platform_attributes[] = {
>>>    &dev_attr_panel_fhd.attr,
>>>    &dev_attr_cores_enabled.attr,
>>>    &dev_attr_cores_max.attr,
>>> + &dev_attr_apu_mem.attr,
>>>    &dev_attr_mini_led_mode.attr,
>>>    &dev_attr_available_mini_led_mode.attr,
>>>    NULL
>>> @@ -4176,6 +4283,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>>>    else if (attr == &dev_attr_cores_enabled.attr
>>>    || attr == &dev_attr_cores_max.attr)
>>>    ok = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_CORES_SET);
>>> + else if (attr == &dev_attr_apu_mem.attr)
>>> + ok = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_APU_MEM);
>>>    else if (attr == &dev_attr_mini_led_mode.attr)
>>>    ok = asus->mini_led_dev_id != 0;
>>>    else if (attr == &dev_attr_available_mini_led_mode.attr)
>>> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
>>> index 5a56e7e97785..efe608861e55 100644
>>> --- a/include/linux/platform_data/x86/asus-wmi.h
>>> +++ b/include/linux/platform_data/x86/asus-wmi.h
>>> @@ -121,6 +121,9 @@
>>>     /* Maximum Intel E-core and P-core availability */
>>>    #define ASUS_WMI_DEVID_CORES_MAX 0x001200D3
>>>    
>>> +/* Set the memory available to the APU */
>>> +#define ASUS_WMI_DEVID_APU_MEM 0x000600C1
>>> +
>>>    /* MCU powersave mode */
>>>    #define ASUS_WMI_DEVID_MCU_POWERSAVE   0x001200E2
>>>    
>>


