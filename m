Return-Path: <linux-kernel+bounces-515557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C185A36636
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A32E170364
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB2B194A44;
	Fri, 14 Feb 2025 19:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5KoUWTuq"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C42719415E;
	Fri, 14 Feb 2025 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739561672; cv=fail; b=FSXx/RWpFSuz/bFjyq8h4xyyqdxrnCRnPX37wZZCs5ZgXEfHaC7Z8WZiGUla8OrRnlu4scLwjE9IYHdTGJC54U241d7FjheyAn4HAUSWS86oI4nQLI8422T1dpi/6nmSovAnrwErQev6Q73rDs8RZs2jV+H1O/BTXeW0nNc+kxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739561672; c=relaxed/simple;
	bh=TftYXkhQyNa4yh3NkqGanDPbXI6q4bOqUWNmMfElqL0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ma6ZVUlSoFtjMOTQPe8q/h8faVrk97vRkAkweZ2S9Qr6qTDkxFy5HDDQ1qI2BaazpToc/SIJbVJOe0gfU6evKt2oLTb5pwCRY9RdqM2sUjloMD62SvPDLhEJ9Gu4F3FPDl0gO8FlKyyLQnDHnKHpUZHJ4GVyS6XhenQ7fcmvJR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5KoUWTuq; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yX0+p5MdjnoPZ7N+v8XLq16XQIuiYxeje0Wd/tcbl4JaWayt6PiWUApkKz56xl3gZksbzGv1X1om1z6wSpGl+HW6tgSKigGM1HQABVozTsB8ZzTvjPvaBwmm45OcxaaffOTFNDuxIYg624Lwfu2U1m/kEYmJclKO6lX4SKz2jND5a+xr7cAZarKPT0TELJHPf5WuyOxkdcn9U5Spgcp9RhMQvysIhJ78Yzjo28o5ow38y/1x94z1ZCAbmpLGKwUlBJ29Ny7QgYsxZJhPPoPEQgKfJIb6PMpCsOClSF2h24rnw+6YYM9SqEirKfPuNtX9F74GjWnLsPmjRV1nn4WBAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dD26u0LxSuiSuXRk+nvp4qOJLyQun9QilcYlnm/DQiM=;
 b=GyyWInq23hYtgfm4WHsw1XVSBqyDNV2BZZYwsNBySqJpWHE6XI9371fK4lXnQVNc3rZSyF2ZCjv9wTfZo6xxk3EyulNNf9XpEVQhMdeqJRJIBJ/fp2mQioLSclHOXgDMIo635rstg3egvoGB3IH+XmoDuzzuaEQ7d3olwFE4c1xTyw0UynLNe8MEWv7tDuWEyIwN2rtQ4BY3WlOLB8oOf3zjrojo/rS31tm3n7w6lz+YGGydoZODFJ0pz0evgJ9tpUKqOJhpPBkzxnf38s6J4cszIFoXhh/hzJmDPyqhieyO75Rz5vcZFezQ9RHWaQBiKbv1rMeVt3CUwXlb2r5UUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dD26u0LxSuiSuXRk+nvp4qOJLyQun9QilcYlnm/DQiM=;
 b=5KoUWTuqsdFwXKyhrarYCXsAocvtytOMRTcsNgZiHRYWHAzijA11BotutOVeDQSfGo5/88qVIn+l6Tfng6d25/U51DkIY4j1uWgrG3wDBXlUSKlyQWgLyxi9kEDf7HxeaCxDJuUpJ5kmX4J52xsg0k1mwgCs6lmvDA7qfg5dlMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by SJ0PR12MB6687.namprd12.prod.outlook.com (2603:10b6:a03:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 19:34:27 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 19:34:26 +0000
Message-ID: <5e19ec93-8307-47c2-bb13-3ddf7150624e@amd.com>
Date: Sat, 15 Feb 2025 01:04:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/18] reimplement per-vma lock as a refcount
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: peterz@infradead.org, willy@infradead.org, liam.howlett@oracle.com,
 lorenzo.stoakes@oracle.com, david.laight.linux@gmail.com, mhocko@suse.com,
 vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com,
 oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com,
 peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org,
 brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, hughd@google.com,
 lokeshgidra@google.com, minchan@google.com, jannh@google.com,
 shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com,
 klarasmodin@gmail.com, richard.weiyang@gmail.com, corbet@lwn.net,
 linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-team@android.com
References: <20250213224655.1680278-1-surenb@google.com>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <20250213224655.1680278-1-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0019.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::30) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|SJ0PR12MB6687:EE_
X-MS-Office365-Filtering-Correlation-Id: 343229fb-4d62-4d45-3207-08dd4d2e9785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RW8zYkk1RE1XQnNsWHpPMDkwZDIwM1hiU1dadDVsV1ZGUm5Hd3pxOFIyaDB0?=
 =?utf-8?B?SFlPdDN3U3FPMjdwWmV3anoxbm9sOVlQL0tYb0pBbFc5L1JJakRFUVNwZjd3?=
 =?utf-8?B?UWFxUVFaZDJiNWNmNG5VcmNRdS9DRjdpcStHcnEwRWN0eEg0a1dtdzBRMzl3?=
 =?utf-8?B?VmlaSUJOdGVWbFpZcVhaSHlYY1Vnbk1yeDQ5Z2ZoYzZWdXBDdi9XSE9lbzcx?=
 =?utf-8?B?RnBvbXFzT25CR3NiUmZYRnlLbmxEQm5QTWE3dldWZHVxTXcreGYwM2IxWUtk?=
 =?utf-8?B?MmUrZjhLemhReWFBYXVRQzNaS3d5d1BHVVQrWGZBZDBjWlZJbGRqbWFsWkU2?=
 =?utf-8?B?cUluRExyVWhwQlRwZWdmck5iaVlUMjhkTkVpS09HUmh1T3NMS0xXcjJBdmlW?=
 =?utf-8?B?cmwzaWlkRGlVWVgxRWxRWmo1RFo4c1FUN3ozTkJJTDVuU2REWG1GWjh5cFBr?=
 =?utf-8?B?d2xNTWsrU3hKcGNKdS83SzkwYjVKWWY4eEtRc3NnNGhnUno2bjdJb2NDMjJ5?=
 =?utf-8?B?NHIvajNXdEhoWmNzSExkMG1UWHY1OGJKYmY2Q1A1aWdrN2dZVDZDaXZsVkdW?=
 =?utf-8?B?SHZoeW9JQ1RVNmJYM1I0bmV4WitkREdaN2tMSFZmWW5hbUlFR2tLT0RYM2M5?=
 =?utf-8?B?M01lMUNmSi95N1d4V1BJd0JZTWJrOWk4L2F4MnpZNnFaL0tYUm1jVVhGUkFo?=
 =?utf-8?B?NXRNZ0VkMTFMUk1heHAzOStINDA0eEgzSW1Jc05YbVYzNUNVZE1QeXYweFI4?=
 =?utf-8?B?NlAwbkdXanBWYk14R2ZHVGZIbkxXNDlTTm5wV1U2VyszMjMrWlBnN3dSZWpR?=
 =?utf-8?B?SXJqVmlVUVpiUmFyMGUvQ1E2aEZNT1JaMWphdW80UU1OSE1mYzZBYUQ2cmRu?=
 =?utf-8?B?UjBUZlQxWGIrRGNiYTkyTTdQU2dEamR3OUlDTys2VzBmSXpHVTBmT0I1b1Y0?=
 =?utf-8?B?eCtSRXlwSzh2cWNFWktiSElvSjQweklrcjJEZ2JrSTBsaVNCT1JMVVNtVnY2?=
 =?utf-8?B?ckNVd2ZScDkwWDN1Z0tCVURjN21uQUJGR01NeldmRmhtSFRYMnM0NFpTUWN3?=
 =?utf-8?B?RnhJUW9HV2ZwYlpzN3RyQmdMUmZoMmVxemZuM0JvbnVyMjVNdUs4WXkvanF5?=
 =?utf-8?B?anlDMXFybDZRUlBscFJpeTR3RzZhcWxOenZzWDczZm5GL3YyeFpPVjlHdG54?=
 =?utf-8?B?TlU4YXY0RU1RSWdBbjlpSENPajBwTG5jaHo4Sm9aSWo2T0ZhbWxaTU5USjFW?=
 =?utf-8?B?dGFnR2NCQkhKeUx3czV0NzhaeWF0SEtoNDBIUGlOVUg5ZENDWE9qWWRWaTRr?=
 =?utf-8?B?dFhUWDNzYnd2ZWRqRjBKVlRuMHA0N2pldFR4ZmFzMGhXQTE1R0RoNi9jaldy?=
 =?utf-8?B?NndXWTkxVDQvSzE3MTh0TnkvekhwVCtJaFFDbWFoOGUvSWhITHZndU01a2NH?=
 =?utf-8?B?OWhJS3NYczEyWElOd2hMK0tnNE5ydUJhZ0x2MWRHbnpGNm1SMmxTaVVSZlh4?=
 =?utf-8?B?dWR3bWZudTJHbXp6NUFwcFhEd1JyZS9QSkJvR2swQTJQMUFDMCtFcTVtWmdY?=
 =?utf-8?B?Si9NN1BtdXN6dGRUWUkwSjg2NkJjU0RSaXZvYldNcTlCZTN1Z3oyQVR6cG9o?=
 =?utf-8?B?ellyWml4ZEl2N0RlVGJlTmV3eURuaHgxMi82SUlGVDlHejdGTENYSENZallY?=
 =?utf-8?B?dVlObVJwQ1lPY2dXYk5aMjB6K3cvZGtJYnFYbEc0aDI2QTBjd2NrNko3djJQ?=
 =?utf-8?B?RTA2d0pFVk5CZ1dpOTYrc2d6UnJ3TmJuZmM3czhVQnUvSDluK3RpTWIxVEpC?=
 =?utf-8?B?dHNRS2h4d1M2MmtXdlE4Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0lIMGVqSXpPQVJ0QllOaEl0V2tpQzRPaEdFWnpVa0VoUXZkb2JyWWYzUFkr?=
 =?utf-8?B?Tzc4ckxzRWNkRzBoNnQxNWVkKzdOUHEvWnNEUEpTUFprLzdkUmd4anFxdGJM?=
 =?utf-8?B?ekc4QW5Sc2s2MC9tUnR0ak9PYmdxcXhaQ2pIZW1pUzNsdEJZT1JaUnhGSVpq?=
 =?utf-8?B?a2RnaklocHo5dTdtbXZ0aGFWRWNmaXNlSEFhRW13UEJHS2lieUZqMnpTT3Zz?=
 =?utf-8?B?dmxCcHNjS3RJbmZoOGJ5UmxWRnRRdFBrbXJGU3EwcUxvbGpjYWZZUVJ5YUk0?=
 =?utf-8?B?ekdRRC9OQWdTTUYvVUpQTTJjT2NUd0JNRmVQbUFXRlYrVE51TDhtaVltcWpy?=
 =?utf-8?B?YWJ4emxSazU2R3JBY1U1QmVJQU41bFFWR0xLUTlLSkhaano4RlplTUdWYTJG?=
 =?utf-8?B?bXY1RWFSWlh4R1hQTFVpSHNwN0c3aVhXbnF4RFFFVFRvbi8wR0xtRVE1QVNO?=
 =?utf-8?B?WFZ4Tjh5Yk1FRjk2SkUzR2NybnhReUxiT1dTbCtmelhuWmVzNDVISndLK1ZF?=
 =?utf-8?B?MGpYdVNid3I5SkNlU21ieDRGL3hydStkMWxWallVSFVYTTA3aUxSNUloY2VI?=
 =?utf-8?B?YlNlTFpEV29RL0NEYWRxaGo5RUhXS0JTSGZmeEd0bUxPYzNPZlZyUGdKL2l6?=
 =?utf-8?B?TWROMURTNml4dTgwczE4RnhNN3pPR1NCRzlxN2JpQmtud3F4THFmMWFKclZO?=
 =?utf-8?B?SDlXclpLOVBVekx0Nm9kWjBZSE44ckg2TllDK3BHWkJKTXV3eFVmcHJvWS9L?=
 =?utf-8?B?U1NRazkxTjFjZy9IMzF5ODY5Ukx6dHJQejkwTWIwWjc5YjZPMGszYndmanZF?=
 =?utf-8?B?TVBLa0l1Si9CUEcvaVR4OGM2YktqSytWT0hYVEJZdW1xUlBXcm44M3IwVE4z?=
 =?utf-8?B?MDcrWjB2RUNQM1Q4TnBFV1VieGo0QUF2Y0kyamN6OXVCRC9PenRKWlZ2N1E3?=
 =?utf-8?B?SnpHaG5UMThRcHJiUnF0UFR4cUROQktwaHFUU0FFYitWMWsxd1Iwdi9NaGox?=
 =?utf-8?B?eUR6QmRZWk5LQ0xNRUdRUXdVNm1PMW81ZUJ6ZUxtaU5Cd1l3UVVCb0FzZXE1?=
 =?utf-8?B?YkQrbVBNdWNoNkpFZys2cEt0S2d3WnhNUThsOGN2aHhBMHFHTkFZU1p5czcz?=
 =?utf-8?B?TS8rSzQzbUxKbmV2RXFsU045SnExV2JpZkNzeUs4L2o3cjl4dGErMkFhcVcy?=
 =?utf-8?B?RnNPc0lmZDU2SlNlRERvUExDSHE5RUw4WTk3ajgvUjJMd2RFbTA2R0ZyQ2dI?=
 =?utf-8?B?eEM1UXV0MWVaSEJLTU9wTjR3Wi83d0srV2hjKzB6Sit6L25HOTlyK1RCeUhR?=
 =?utf-8?B?VStxYU9KUSsxeTE0SmdXZFQ0UFJXcDF5WFRQMzQ0OXhSV0ZSNmYxVTFodU9Q?=
 =?utf-8?B?RFkzWDRZOVdqREgvcXJyOW16Yjdyc0hVbjl6b3hpT3VOMXpIeXorWmZvbXh1?=
 =?utf-8?B?SDUzSDREOTFGTndVN1FLd0hqSTZJRStzY2JXenl2dkpLMTdyQ0twVnB5V3hi?=
 =?utf-8?B?dUNjbVBGYkxYeUtLUzEyYWFjT24wbmdsZTd2ZERRcEdaWDMwU0MwRmc3anE0?=
 =?utf-8?B?WU5QNk85WFk5R0pZY3Z5bE1TOGxmT1IxakhHQnh3MjBPUXNPTjk5aHMveUI5?=
 =?utf-8?B?TnRiZ0U4eVpnRUZWSzAvekRZYUNLNUlqbHl6TjU5N3JZMzRIZzFzR2toNFBH?=
 =?utf-8?B?dHE0ZU5SZEg0SlFJcDF6aDZkeVcyMkhDbHlLazhGdTkwTTNZUnh0UUJXdDMz?=
 =?utf-8?B?Rk9JS1Vxb2Z5RHJaY2lqcXczTW1pUE5NdS90SnpXU2xYZHM3a3RvcnNwbTVh?=
 =?utf-8?B?Vm1FeWRlYU1yNmVOam1rbC85aHp6dnlTZzRzenJrc2M0a1cxdGRyK0I5dFow?=
 =?utf-8?B?YktDYzdkTktzSlNDY2U0dWhoUDJGMWxMRlZIMk05R0JJL2U3MDNUVkdFdmth?=
 =?utf-8?B?OEtHQWlsMnhBYTEvcjV6SzdBMlI1K0JJQmM0Z3NWbXAxWEtoSjRubllHOG1h?=
 =?utf-8?B?NVNKTmZtZFNUMEEwVE5TVkpzeG55SHVDdnM3YlNyRU8xRE1jU1hleTBDaXRC?=
 =?utf-8?B?aDJhY3E5U3pWT2FXYU1WWW4rVkJIWDdoL3NvMnhLTnlyd1JXb01MVGpFZ0pz?=
 =?utf-8?Q?uo1fJe3bP/gCTfbxdh/a1Cf6K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 343229fb-4d62-4d45-3207-08dd4d2e9785
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 19:34:26.6973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51c1zgGlqdOtQ5zkJQ5Ng2jnyNLTXae3QqGZ3PKaobqWpxdEb7x2o0bem06ihLj4qcBMRo+VbU0KgJlFHu5cSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6687

On 2/14/2025 4:16 AM, Suren Baghdasaryan wrote:
> Back when per-vma locks were introduces, vm_lock was moved out of
> vm_area_struct in [1] because of the performance regression caused by
> false cacheline sharing. Recent investigation [2] revealed that the
> regressions is limited to a rather old Broadwell microarchitecture and
> even there it can be mitigated by disabling adjacent cacheline
> prefetching, see [3].
> Splitting single logical structure into multiple ones leads to more
> complicated management, extra pointer dereferences and overall less
> maintainable code. When that split-away part is a lock, it complicates
> things even further. With no performance benefits, there are no reasons
> for this split. Merging the vm_lock back into vm_area_struct also allows
> vm_area_struct to use SLAB_TYPESAFE_BY_RCU later in this patchset.
> This patchset:
> 1. moves vm_lock back into vm_area_struct, aligning it at the cacheline
> boundary and changing the cache to be cacheline-aligned to minimize
> cacheline sharing;
> 2. changes vm_area_struct initialization to mark new vma as detached until
> it is inserted into vma tree;
> 3. replaces vm_lock and vma->detached flag with a reference counter;
> 4. regroups vm_area_struct members to fit them into 3 cachelines;
> 5. changes vm_area_struct cache to SLAB_TYPESAFE_BY_RCU to allow for their
> reuse and to minimize call_rcu() calls.
> 
> Pagefault microbenchmarks show performance improvement:
> Hmean     faults/cpu-1    507926.5547 (   0.00%)   506519.3692 *  -0.28%*
> Hmean     faults/cpu-4    479119.7051 (   0.00%)   481333.6802 *   0.46%*
> Hmean     faults/cpu-7    452880.2961 (   0.00%)   455845.6211 *   0.65%*
> Hmean     faults/cpu-12   347639.1021 (   0.00%)   352004.2254 *   1.26%*
> Hmean     faults/cpu-21   200061.2238 (   0.00%)   229597.0317 *  14.76%*
> Hmean     faults/cpu-30   145251.2001 (   0.00%)   164202.5067 *  13.05%*
> Hmean     faults/cpu-48   106848.4434 (   0.00%)   120641.5504 *  12.91%*
> Hmean     faults/cpu-56    92472.3835 (   0.00%)   103464.7916 *  11.89%*
> Hmean     faults/sec-1    507566.1468 (   0.00%)   506139.0811 *  -0.28%*
> Hmean     faults/sec-4   1880478.2402 (   0.00%)  1886795.6329 *   0.34%*
> Hmean     faults/sec-7   3106394.3438 (   0.00%)  3140550.7485 *   1.10%*
> Hmean     faults/sec-12  4061358.4795 (   0.00%)  4112477.0206 *   1.26%*
> Hmean     faults/sec-21  3988619.1169 (   0.00%)  4577747.1436 *  14.77%*
> Hmean     faults/sec-30  3909839.5449 (   0.00%)  4311052.2787 *  10.26%*
> Hmean     faults/sec-48  4761108.4691 (   0.00%)  5283790.5026 *  10.98%*
> Hmean     faults/sec-56  4885561.4590 (   0.00%)  5415839.4045 *  10.85%*

I tested this patch-series on AMD EPYC Zen 5 system
(2-socket, 64-core per socket with SMT Enabled, 4 NUMA nodes)
using mmtests's PFT (config-workload-pft-threads) on mm-unstable. 

I see significant performance improvement for higher thread count:

			   mm-unstable		   mm-unstable
			   -6.14-rc2-vanilla1	   -6.14-rc2-v10-per-vma-lock
Hmean     faults/cpu-1    1933589.0920 (   0.00%)  1950506.1985 (   0.87%)
Hmean     faults/cpu-4     722834.4269 (   0.00%)   657946.3257 (  -8.98%)
Hmean     faults/cpu-7     373210.8410 (   0.00%)   358995.9493 (  -3.81%)
Hmean     faults/cpu-12    216267.7580 (   0.00%)   211032.8119 (  -2.42%)
Hmean     faults/cpu-21    153080.2758 (   0.00%)   150207.3115 (  -1.88%)
Hmean     faults/cpu-30    143142.8874 (   0.00%)   142904.3981 (  -0.17%)
Hmean     faults/cpu-48    135825.2524 (   0.00%)   158502.4303 *  16.70%*
Hmean     faults/cpu-79    111892.4921 (   0.00%)   141725.6864 *  26.66%*
Hmean     faults/cpu-110    96905.8995 (   0.00%)   114238.6961 *  17.89%*
Hmean     faults/cpu-128    89136.8524 (   0.00%)   107620.7035 *  20.74%*
Hmean     faults/sec-1    1933283.3273 (   0.00%)  1950224.2371 (   0.88%)
Hmean     faults/sec-4    2859235.5825 (   0.00%)  2611293.1103 (  -8.67%)
Hmean     faults/sec-7    2580415.8792 (   0.00%)  2497936.1104 (  -3.20%)
Hmean     faults/sec-12   2560172.2303 (   0.00%)  2516697.9056 (  -1.70%)
Hmean     faults/sec-21   3080686.9599 (   0.00%)  3038393.3328 (  -1.37%)
Hmean     faults/sec-30   4174290.0462 (   0.00%)  4168318.6202 (  -0.14%)
Hmean     faults/sec-48   6318251.1880 (   0.00%)  7323087.0849 *  15.90%*
Hmean     faults/sec-79   8502378.1341 (   0.00%) 10761979.4193 *  26.58%*
Hmean     faults/sec-110 10131823.3341 (   0.00%) 12318722.2392 *  21.58%*
Hmean     faults/sec-128 10584693.5966 (   0.00%) 13354652.5141 *  26.17%*

Slight degradation at 4 and 7 can be ignored due to high variance:

HCoeffVar faults/cpu-4          8.7568 (   0.00%)       11.4420 ( -30.66%)
HCoeffVar faults/cpu-7          3.3204 (   0.00%)        3.4852 (  -4.96%)

Please consider my:

Tested-by: Shivank Garg <shivankg@amd.com>

Best Regards,
Shivank Garg

> 
> Changes since v9 [4]:
> PATCH [4/18]
> - Change VM_BUG_ON_VMA() to WARN_ON_ONCE() in vma_assert_{attached|detached},
> per Lorenzo Stoakes
> - Rename vma_iter_store() into vma_iter_store_new(), per Lorenzo Stoakes
> - Expand changelog, per Lorenzo Stoakes
> - Update vma tests to check for vma detached state correctness,
> per Lorenzo Stoakes
> 
> PATCH [5/18]
> - Add Reviewed-by, per Lorenzo Stoakes
> 
> PATCH [6/18]
> - Add Acked-by, per Lorenzo Stoakes
> 
> PATCH [7/18]
> - Refactor the code, per Lorenzo Stoakes
> - Remove Vlastimil's Acked-by since code is changed
> 
> PATCH [8/18]
> - Drop inline for mmap_init_lock(), per Lorenzo Stoakes
> - Add Reviewed-by, per Lorenzo Stoakes
> 
> PATCH [9/18]
> - Add Reviewed-by, per Lorenzo Stoakes
> 
> PATCH [10/18]
> - New patch to add refcount_add_not_zero_acquire/refcount_set_release
> - Add Acked-by #slab, per Vlastimil Babka
> 
> PATCH [11/18]
> - Change refcount limit to be used with xxx_acquire functions
> 
> PATCH [12/18]
> - Use __refcount_inc_not_zero_limited_acquire() in vma_start_read(),
> per Hillf Danton
> - Refactor vma_assert_locked() to avoid vm_refcnt read when CONFIG_DEBUG_VM=n,
> per Mateusz Guzik
> - Update changelog, per Wei Yang
> - Change vma_start_read() to return EAGAIN if vma got isolated and changed
> lock_vma_under_rcu() back to detect this condition, per Wei Yang
> - Change VM_BUG_ON_VMA() to WARN_ON_ONCE() when checking vma detached state,
> per Lorenzo Stoakes
> - Remove Vlastimil's Reviewed-by since code is changed
> 
> PATCH [13/18]
> - Update vm_area_struct for tests, per Lorenzo Stoakes
> - Add Reviewed-by, per Lorenzo Stoakes
> 
> PATCH [14/18]
> - Minimized duplicate code, per Lorenzo Stoakes
> 
> PATCH [15/18]
> - Add Reviewed-by, per Lorenzo Stoakes
> 
> PATCH [17/18]
> - Use refcount_set_release() in vma_mark_attached(), per Will Deacon
> 
> PATCH [18/18]
> - Updated documenation, per Lorenzo Stoakes
> - Add Reviewed-by, per Lorenzo Stoakes
> 
> [1] https://lore.kernel.org/all/20230227173632.3292573-34-surenb@google.com/
> [2] https://lore.kernel.org/all/ZsQyI%2F087V34JoIt@xsang-OptiPlex-9020/
> [3] https://lore.kernel.org/all/CAJuCfpEisU8Lfe96AYJDZ+OM4NoPmnw9bP53cT_kbfP_pR+-2g@mail.gmail.com/
> [4] https://lore.kernel.org/all/20250111042604.3230628-1-surenb@google.com/
> 
> Patchset applies over mm-unstable
> 
> Suren Baghdasaryan (18):
>   mm: introduce vma_start_read_locked{_nested} helpers
>   mm: move per-vma lock into vm_area_struct
>   mm: mark vma as detached until it's added into vma tree
>   mm: introduce vma_iter_store_attached() to use with attached vmas
>   mm: mark vmas detached upon exit
>   types: move struct rcuwait into types.h
>   mm: allow vma_start_read_locked/vma_start_read_locked_nested to fail
>   mm: move mmap_init_lock() out of the header file
>   mm: uninline the main body of vma_start_write()
>   refcount: provide ops for cases when object's memory can be reused
>   refcount: introduce __refcount_{add|inc}_not_zero_limited_acquire
>   mm: replace vm_lock and detached flag with a reference count
>   mm: move lesser used vma_area_struct members into the last cacheline
>   mm/debug: print vm_refcnt state when dumping the vma
>   mm: remove extra vma_numab_state_init() call
>   mm: prepare lock_vma_under_rcu() for vma reuse possibility
>   mm: make vma cache SLAB_TYPESAFE_BY_RCU
>   docs/mm: document latest changes to vm_lock
> 
>  Documentation/RCU/whatisRCU.rst               |  10 +
>  Documentation/core-api/refcount-vs-atomic.rst |  37 +++-
>  Documentation/mm/process_addrs.rst            |  44 +++--
>  include/linux/mm.h                            | 176 ++++++++++++++----
>  include/linux/mm_types.h                      |  75 ++++----
>  include/linux/mmap_lock.h                     |   6 -
>  include/linux/rcuwait.h                       |  13 +-
>  include/linux/refcount.h                      | 125 +++++++++++++
>  include/linux/slab.h                          |  15 +-
>  include/linux/types.h                         |  12 ++
>  kernel/fork.c                                 | 129 ++++++-------
>  mm/debug.c                                    |   6 +
>  mm/init-mm.c                                  |   1 +
>  mm/memory.c                                   | 106 ++++++++++-
>  mm/mmap.c                                     |   3 +-
>  mm/nommu.c                                    |   4 +-
>  mm/userfaultfd.c                              |  38 ++--
>  mm/vma.c                                      |  27 ++-
>  mm/vma.h                                      |  15 +-
>  tools/include/linux/refcount.h                |   5 +
>  tools/testing/vma/linux/atomic.h              |   6 +
>  tools/testing/vma/vma.c                       |  42 ++++-
>  tools/testing/vma/vma_internal.h              | 127 ++++++-------
>  23 files changed, 702 insertions(+), 320 deletions(-)
> 
> 
> base-commit: 47aa60e930fe7fc2a945e4406e3ad1dfa73bb47c


