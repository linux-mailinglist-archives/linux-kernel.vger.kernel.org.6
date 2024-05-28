Return-Path: <linux-kernel+bounces-193127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769858D2730
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BFBD285E82
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B31217DE0D;
	Tue, 28 May 2024 21:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xffkibkd"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88D917BB3C;
	Tue, 28 May 2024 21:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716932282; cv=fail; b=W79fiP4TC+1JbUwgpSPz8RxIL+PQBggy+akxoQpPNY6z8lPZ9EnXbMwDpC9Y6ef06o19qdZ8r235yqvVe1hNsosf/jGJi22sxptIuz8+++2SlbD1AaLItr7fcdnMkRpmd9sxRG0fdCLxyNX5FHuCbf/QZyx2q16rSjnVDbIVoaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716932282; c=relaxed/simple;
	bh=CWIrxfqnk3E/Hp0MiBK8AkBHAD4VZcyPmI4qZmNumE8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BMRABNhYNVXdxxowDWt14ktBW0KlKDo8i1azj9M7NAkOZ/NqHDqS77I3yuLaFov1zYPm5KJQmglab/V4aSYuwOi3+gOLSZCeWsON3Df+5UILHaQVSS6Xx1PP/3T2E3MEZMsJEKhOpPj6DAjAp4ggkEoe3N+bU22RZH1s9ZEOJ5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xffkibkd; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtqW5hFlIrj4HMJeRxghe987FCYtdkpZ0iT4w5DGINSvztY/YWDSaODmWQCEiC/rpJUNBp9L4XRrf5XGZCL9q5ug0A+GXyDzATaa+Q7ooZbSklFp21PTySuKzsMpcjF410CuSE3fmOvEaW81qaiOUPkE8ZGLmrYAcgqad1WihTMWsocytRAM5MKOYP90+TC4h5bkWM9O/oNHM5kvm1j+ScNiSZWSywIBbL/hMyIjKfmohReV+11a3r3tJrK9crVADcOjI8gmQy2JBAdl5SoK20h937vJ9gss5SRqr+Ec228kg5czV2uCVXR4rzFXI1+1IFU11DkVnXVx1ql+pluhFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEWL/cSvlQ6Qy6U2X4FW5FNKCUXON89uZtVTgjyjT+0=;
 b=ITVSwZAsDPOYYvKV012spDLAi3NtUe2EKY8H3SLsmmS/aVAIvlOQTLdKR11Vb2cpHyBOlCt544FX2Fnm+XwY0kIeu9Fs7fckv0mZB82mwsKyEXK+XiOlH1AmZs+OT+zVbw+zB2S8xFTPsouOuXK257mnZKSDUOlqKFBLbewWr1jmxzEjMOz+5+8A7YdZaVlDzBjZw8mvQOWeBJNE27+bQmppmC/aWP5N4OjFHYKVlooMmrJN1eH86lTkN7EdqzGmECdynN9YJiibymAdPupiY3mqITCOETbrJS6fS7TcFuqOVooFt/z62WMsbD83DqMciIDLptfVP2rjGcnTmXsa0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEWL/cSvlQ6Qy6U2X4FW5FNKCUXON89uZtVTgjyjT+0=;
 b=Xffkibkdac/efeOhdqbtmSkeECrnEyUPHfqlwYgOYhDSO8imveQxENRuourUPtKZj97CfrbMpSoGNvfPWIp5kwvoi4+m/YN/2ml6hGtJYEAtiOWtzsPKEzVVGauLBpdjCXFvJidwgtb6At6Fzk/c3dF7bdiNWINDL9JlGts/z40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ1PR12MB6220.namprd12.prod.outlook.com (2603:10b6:a03:455::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 28 May
 2024 21:37:58 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 21:37:58 +0000
Message-ID: <1a33c7a6-a04d-4c53-b8f2-02431a1073b3@amd.com>
Date: Tue, 28 May 2024 16:37:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] platform/x86: asus-wmi: add apu_mem setting
To: Luke Jones <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: corentin.chary@gmail.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, richard@hughsie.com
References: <20240528013626.14066-1-luke@ljones.dev>
 <20240528013626.14066-9-luke@ljones.dev>
 <6f4bc109-00d0-47b0-a581-b96a6152545c@amd.com>
 <4d6b9171-7248-4937-87de-7e921ed8e507@app.fastmail.com>
 <5f4799b1-0606-46a9-a347-5a03738db341@amd.com>
 <ac597520-fb5b-40e5-ae1f-de825450d2db@app.fastmail.com>
 <371d4109-a3bb-4c3b-802f-4ec27a945c99@amd.com>
 <6d4e7f1e-ccd0-4ac5-b450-f9c5f8d5c90e@app.fastmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <6d4e7f1e-ccd0-4ac5-b450-f9c5f8d5c90e@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0116.namprd13.prod.outlook.com
 (2603:10b6:806:24::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ1PR12MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a3a304-d821-463d-9251-08dc7f5e7113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUpRK3crNHpIZG1la2p5ckFnUlZpeDZDUWVYdVhqNkJnVnF3TGlGSUhJTGx5?=
 =?utf-8?B?YlhJQzdaMWxrK0VqNHpESnVNRUt0b1d6R3VtNnRxL2I1b2QydUFMb2tXUGVN?=
 =?utf-8?B?QWVSY1R0aW1xNGx6Qk5aKzJSTlY2enBQeE05UXU3OHEzdmYrSmlMc3ErdHds?=
 =?utf-8?B?MXBUTjBzZE5YM3NpMEFhc25QY0J2RVJvdU1IRmo5Y2xzQmVibUc5d3JPSVhN?=
 =?utf-8?B?U09zcHlLM0t4aWE3YW82WC9VdTVVdzIwUy9TcVVja1RobGFYYzN6d0tiZjg5?=
 =?utf-8?B?empDanEwTnZUMHh4bkU1cmZIbDV2S0ErOFkreXM4ZjZqbkJLKy91NnhybGl4?=
 =?utf-8?B?NnU4NGhsa1k4S29pSXY4VXNEVU42NVRoK1ZYNXR1WWZCTTNEN1VXdnJhVE1v?=
 =?utf-8?B?QmcwREo1MFk1enhYRzd4RzI5YnA3aGhVSVgxaDlDeFF5VmJXR2tMazdzUEl2?=
 =?utf-8?B?dHRrOTVYam1KMmwvRkpwM1VyRGRWeCtNNnBNc0hyYm9nVTF1V0dwWDMzQmMx?=
 =?utf-8?B?YzBFbEM1ajRXRmdDMGZYV1F0bkZ0U2U4eXV0SjFoMkdCS0VabG5KaXkwbkdW?=
 =?utf-8?B?cjFnMHBnWmxpa1pUOEVrWi9mSUtQRFZuWHU2RzlTZG50dVFydjBrNXl3c0Zq?=
 =?utf-8?B?eHdRa1NUa3pOOTRpTFg2Q3RMUFQwcTVqc2NmNTZHNG1ib0gzZmlONlo4TWlL?=
 =?utf-8?B?YSthaVM5cUsra2hMTUV4RDkySlBYa2R1YnZWSFZPaXY0emVYTTNzSFFycXV4?=
 =?utf-8?B?dkRTZXpBd05NVHNsZ0ZXYWpwQkVFeTFjWHpoNnRLVkNpclBiMWtnZGZHQWZH?=
 =?utf-8?B?TXFHZTVGVzVCQ2ZhVlJoQWFxWExsU2k4cnFZVzZUNUVqcVZGWlFHc2tsbTc1?=
 =?utf-8?B?SFNWWERnK2FrRUttS2pGR09zYk9sT0kzQkhNaFhPM1VCYlZuYnZnZGY5UXlY?=
 =?utf-8?B?TlNSNS91Z3FwWWljcGVXTm1aTlMzSkltblpSYzFyVk1keTVtSTd6VUV6TTAz?=
 =?utf-8?B?TlNxT0ZDMElMUXo3VS9XV05PTTFNZkFMVW9qdVhudEFOUXVON0ZsaFQ1dkgy?=
 =?utf-8?B?dlE2bHVTVzNPZTZHSVkzQkxHNHdmRFM5VFZoc3lGYjZXTDZFUElDQzNJcUF6?=
 =?utf-8?B?MHZZcVZ0UHFnU0srYjdIanN4NDQ3WWhVWGZtbTJQekxvUU9xc1FhNElyRVVp?=
 =?utf-8?B?ZzZYWEVZWDArUldoYnFHWlVSaWVGNHpRWGowNmxUdk1pdWF2ajgwaUZQbUp5?=
 =?utf-8?B?L0Jva2xWeThkbElRQTVGU0R3ci9aMUs3blkwdGR0cFV2MlhGR3JHMUlyZjFS?=
 =?utf-8?B?d2xSbmpyMlRCNnVPTWZOeFhPQUFPdEttendUcEZ6UFptNEs5ckRFVnl3ZmhV?=
 =?utf-8?B?NWhjdzdDdXJLSGE5SS9ObjFDd2lHWXVqOFViY2x1RDlTdFpSSmVMMnZpU1p0?=
 =?utf-8?B?d0ZSOHR3NlErMTZzV0xBbFp4OG8zcWtiTEtuRUhYOGxaSlRGZkpNNzdUSml0?=
 =?utf-8?B?NysxdkFLd053UUhLRmZ6VGlXcndqU01BK0dQalZkUXZ3U2NCcTFWQlNHUUg2?=
 =?utf-8?B?SzQvS3NaQTdaU0J1bDZYSkJ0bkJEVnBINmFKUDhjcFUwL1RlUUphaUpFR05O?=
 =?utf-8?B?alNSMkQwWm1SWEdPSkh4S1g2UU1tN0s5bUNxWVJrWS9LYzA5Q2sxWU1PbDBy?=
 =?utf-8?B?WXFJMG5rRFNmd21yL3VKM3ZVcmVERVVHdy94SGJDSlk4cysrQ04wMnRRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmM3NmNDcmZhTDZnZlZXVlNsYiswVWV3YzFRUHJjMWlYWUlWdkpvWVhiT0k5?=
 =?utf-8?B?eWxlZDBqZHZscS9JZzJCZlMwWGhMVTYvTmhZVGRobGRDRy9VUWtKUzlVUGQw?=
 =?utf-8?B?a2I5d1doeHB1RGRNVEN1UFhHWWVrMzhucW9tUVNpOG5mNEg2S2VQeFIwV1J5?=
 =?utf-8?B?K3VUMmVsWXprdVpnR1pzZnpramZ0MnZWUWU3ZkZIeXpVbDNTRk5SWFNxKzNm?=
 =?utf-8?B?SWp3Q1RaWklSMktWNGNhVFhicXB0WmdGcGpva29TVDdQam5xUDUveVlNSURn?=
 =?utf-8?B?cjd4a0N2TWZYdTZ2dUFjc0UwdlJUL1lyRDFkNnoycW40cmxpcjVWZVppd2JJ?=
 =?utf-8?B?VW01cFhvMGlHZWdMWVVQYXI5NTZkMVRKTzUvUmRjOFZVRHlSVzJlUWJRZzlr?=
 =?utf-8?B?MTVvNk5KNzZmQzZhYlk3aXV2L0dyWnFWU0hvV3d5UjNvNW9ycTcyNWR4clpq?=
 =?utf-8?B?Nzl3OWRWYko0RVI3VnRZUmRqdFlnU3gyMExZd3NZTUVRMi9sWFhTSHdrZU1u?=
 =?utf-8?B?Z1NqdXRFR05xTWRiNWw2MzJHUGViZnFBQ1d4c284TEdLbzk4ZUZ3SGZ5Q0pB?=
 =?utf-8?B?dlpvM3kybnhZKzFzdFpTY25meHp0MkFuRVMvbHJybExNL0VTOVZOV3JCbS8y?=
 =?utf-8?B?WkxFUnBlWDFyaC9BRGxySFRLcXo2NFI1YTlOYkdRcjBISW1nd1dRdThzZXRz?=
 =?utf-8?B?dEJUVG9VYzJqbWhkYk1GZE5DUkNaMkVSYnhBNWFPQnN3V3VkeFhSeU5RWXRi?=
 =?utf-8?B?a0VaUndaQjh6NGNwM2lJdGo1em1KWkV6aUpHTWFGYlB5bFE4WFlSdW1LTzVB?=
 =?utf-8?B?azUwMUphRExtWW1QSjVERGsrZXpDR2txTG4xSitIQUhHK3ljcnlobGVzeEFC?=
 =?utf-8?B?ZEVSbktVSDVLOTA5S2JhNy9JYXBaL0JhUXBoaFZVNFAyUXlnd1NqK0lmSUU0?=
 =?utf-8?B?U3dQc0UyZDZuVHA4dGNMTkUyaFgvME1CNU9lT2lOTVVQMlgwQ21CR2FwbGJ2?=
 =?utf-8?B?MVIyVTJBUVpyQTgwUDBiWjJNUE8yOTE1cStKdnk0SkpuSlVHdDVCdHFPU0Fn?=
 =?utf-8?B?ZWpzbWlqZEJaRUV1bHcwcEFMZHpqdm1Xelo3T0wyWTUwdW5tQnlkRjltWGhP?=
 =?utf-8?B?Z1QxSkhRL1lyYkRHaDBqQ2pPZWY1ZnFhZlpRbkpOT2xHcDZ5NlovdW4zQkZZ?=
 =?utf-8?B?SFNlaGJWaGU3UEUwa2d1T21WZzRYWTZDSldXdWdqTFNvazBJYzVUSXV0QXk1?=
 =?utf-8?B?OEVyYko5V2JIYkVmcXQ3RDdXZXp1QnNiSS9ZVUs2bmNUcmo5OG10M1B0UUlu?=
 =?utf-8?B?cjBhcUd1VVNVVWt1STlONjlpek8xMXNDQ0FZRytZcUhiS3QwaEZ2WHMvd2JM?=
 =?utf-8?B?YWtuL0l3VFJ4MEhZNjVSTUZNbnFnbnFFWDJFSmUrMkRkQXRkQ3ZoNnV2L3g3?=
 =?utf-8?B?WGswelg5aVVIR2k5b3ZEK05oNDJlNEtqUS9nUFcxMlgwWjNpT3hrZkRwUThv?=
 =?utf-8?B?RDhoSGFVOURJNUZuL2piM2o1YVVlTkRkM0VEVG9PSXZzcVpRMXVlMDlINWV6?=
 =?utf-8?B?QkVnZ1BuUUx6cTlBcEJUejZuMGMrTlRpeEFWQUVpOG43akhwekFVMENDMVpt?=
 =?utf-8?B?OGs5MUZjUkh4V3d3VU9xd0lJVVFrSWVNT1pSWVZ5ZXNwTGptVXpzczZ5QnAx?=
 =?utf-8?B?elZObHlZWWdrelZOdlVjMjl5c0hZeUFxaGliQlRXcGFxdkhaZHdJeWhIcVBh?=
 =?utf-8?B?QlR4Tm95b0h0OGg5b3cxZUV5Qkt6MUN6NW5sb2YzV3JtemZYQi9NSlYzNnJY?=
 =?utf-8?B?NmNjb1QyNG9yY1lzZndqV2lyZDcxR1ptN0JEN25hdTcrSFpKek5LemhiUkxa?=
 =?utf-8?B?SDREZHA3TmZ5Yk1JaVR0aVJJTmpSSEJzbHoxdCttdUFPVkxGMEdtbWVCcSsx?=
 =?utf-8?B?MW1JeG1tcFQ0V0tXcDRiQWtMTHViQWpzckNUb210L3Y4TWc1Z2dVcTYrdzBH?=
 =?utf-8?B?Y3VQWHNPcFN3NVJhZ3JlRlMvS0lIZmxjVjFreGlPNUhuaWM2SFphdWcyMkVY?=
 =?utf-8?B?SjhSUWpRVXN3VkhvU0I0b1ZGTWE0ek9aSFV1QmFKYTk1MzdjVEVKNUVUSXRh?=
 =?utf-8?Q?ouP/wqgZmRAF99zspn3JW6R9c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a3a304-d821-463d-9251-08dc7f5e7113
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 21:37:58.1571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+30OgjTZDCEsx1GqtPZB6lAyMPXD6qJy+0lmOLjuk2Vjdi9Lt14SBzIESivsg0wSQ4MORc6dchUq00o4MYZUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6220

On 5/28/2024 16:34, Luke Jones wrote:
> 
> 
> On Wed, 29 May 2024, at 9:16 AM, Mario Limonciello wrote:
>>>> For any "new" attributes it's better to put them in that API than code
>>>> duplication of the BIOS attributes API as well as a random sysfs file
>>>> API that you can never discard.
>>>
>>> Do you mean the firmware_attributes API? If so, I'm not opposed to adding all the existing ROG attributes to it also.
>>>
>>> If I'm understanding the docs correctly, for example this apu_mem attr would then become:
>>> - /sys/class/firmware-attributes/asus-bios/attributes/apu_mem/type
>>> - /sys/class/firmware-attributes/*/attributes/apu_mem/current_value
>>> - /sys/class/firmware-attributes/*/attributes/apu_mem/default_value
>>> - /sys/class/firmware-attributes/*/attributes/apu_mem/display_name
>>> - /sys/class/firmware-attributes/*/attributes/apu_mem/possible_values
>>> - ..etc
>>>
>>> That's absolutely much better than what I've been doing and I wish I'd known about it sooner.
>>
>> Yup!  And even better "fwupdmgr get-bios-setting" and "fwupdmgr
>> set-bios-setting" [1] will work with bash completion too.
>>
>> If you want to build a GUI around it, it could use the fwupd dbus
>> interface for getting those settings and manipulating them.
> 
> My existing GUI effort revolves around me adding these attrs to both kernel and a dbus interface. So if I can drop that then all the better

Awesome!  You can either use libfwupd or the dbus interface.  After 
you're done with the kernel work ping me or Richard if you have problems.

> 
>> The dbus
>> interface policy is protected by PK.
> 
> What is PK? And I'm guessing this restricts users to requiring permissions to change settings?
>   

Whoops forgot to respond to these.

PK = PolicyKit.



