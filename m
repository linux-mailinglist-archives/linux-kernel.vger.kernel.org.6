Return-Path: <linux-kernel+bounces-562785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 339A2A632EC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 00:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7159D7A0F52
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 23:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F61A1DD889;
	Sat, 15 Mar 2025 23:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XqY1G9AA"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6AA195B1A
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 23:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742080649; cv=fail; b=DlGJ3+uqqAmphBO8Xv+Wg7IX9JSw9GQKk2vWM4c3tKWP0MX2gzBVdI27Yu0zDdZXTyPn7+5CZjFowjOKMjf/HpYuLbH8P7HwMe+3JsU5WYCdgRIgL9R8DEZUDo1ir3ZgoGXvCjVzxXaZBH04eLRpQwyUhuJFCfX8ElRKwcVjwMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742080649; c=relaxed/simple;
	bh=T8Y/BjpHgz69Uop7D7PoCzVbCL7zOtXGb0P+gGxPpKw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tWOiRgSZjcpsHCrVhUNLEUSqSDTI8Jo9E0Mhdz1A+nZHQFygkG0IRdTUKkZmUVKUt6ug1BsYZMjZ2Xs+pwruWACV3m3EFhgCucdR+MWHQzsVQ5zaSqPFMz2arImfEfWyLuOnZx6YSz4PfpGPm7w3FYGVf060nierJIsiA/DFmK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XqY1G9AA; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SciVnFen4WMuodsr1rw49qFJME+HjhauAvPf05QVEBqScCz9xzh6eWBMi+7xAi4VqjbshLQczHLec1wxzAIIJQLaD5pwD8r9jx0Oxee0isklzBoAifnHN7OrHok/q0Mg0lz63S8s8NFVYTq8CbEY635A++auHefGtzRGCuKQpTOgi3AoNA4xNyTkLA5ADbbZwF3eD8WvQhCj46OFDT5T1Au8axZlpN6WgtdzkxaQHsbUiNY9XJsxCrYYNbErLGpoL/XMo7xxMQC80wayDPV26ckZ7s806oYaLq0eqg2a4687qlHQ7280TNP9ufofa14zVWOCT+YC29IjG2P3kHC5XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5aCew6vg1mAY7XvYunJv117KAktjpjcmt+ttybAgUA=;
 b=xvw4aec04/R8sxJ3lyWMXTRmakhcV7fFvwatxBZvYTcZbTJTzJHvzJLyNn5iOBo2wNQ3iAV2FziI+3AMvy2X5679La1Xq90UBqjr8s/XUlYIJeRLGIYmAoswm3WcRmJkrZVUaQ/QZKFkAhKcKWHIWQCOqjHh0EDPyQTHfzPRX/7NqbHlyZ5cS1aNg8Bs+EyED0V6YpO2NxwtZmG2a/ZYCK0R3H17vRalSac6JoRAZqyQtFT5NrzZiDGxTHwbDftp6KnxwIEaIs5tA4+2+wuqVh4OBkq+iO1em13CjcbQ1h4xuieqRdXt8D71et/g8g0mJIfIfXU8h9s9qy0uYQvfBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5aCew6vg1mAY7XvYunJv117KAktjpjcmt+ttybAgUA=;
 b=XqY1G9AAQ0R/VcndW/ts9Pz2R1a7+YFYogifs6awUqIEr1A8r7F+++SLczWzXgYQtzkmpoMk/NmKXiQtT9GxbRTLyNVHhcjtEiBdP1u3d0pg4if35AXCSzKWm66IFFJBAKmCR+fbFI8el4Y2BV1PyObE7qMfFQVLBUVvPHKCqggOTzjbeOf03cVyfV3NUqQNF4C6j6NvJxR3DM9YKtOb71aNQ4iUjsk1+obhYJRg2svpIlDlcIS8OAPDrQmFOF1rDz1r2pT7MSZcl7eSEPEl5buNuJpeyJwnuB2GgAUVRhZfaPdXzoTOeuSxwDh1I1fHavWYxcSjx9vuvTLn08a2Hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW6PR12MB7087.namprd12.prod.outlook.com (2603:10b6:303:238::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.31; Sat, 15 Mar
 2025 23:17:24 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8511.026; Sat, 15 Mar 2025
 23:17:24 +0000
Message-ID: <707b1bcd-5c66-47d6-a485-e571ef983642@nvidia.com>
Date: Sat, 15 Mar 2025 19:17:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/8] sched/ext: Add a DL server for sched_ext tasks
To: Andrea Righi <arighi@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
 Luigi De Matteis <ldematteis123@gmail.com>, paulmck@kernel.org,
 boqun.feng@gmail.com
References: <20250315022158.2354454-1-joelagnelf@nvidia.com>
 <20250315022158.2354454-4-joelagnelf@nvidia.com> <Z9W_UbeDXUok4D6R@gpd3>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <Z9W_UbeDXUok4D6R@gpd3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:208:236::21) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW6PR12MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: db16baf5-b1e4-4eb6-b58f-08dd64178b66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1NHbTVFTk1wSUlEdE9lb29mTmROVjVQcmxwdEQweS82VDZBVlpycFNySzFZ?=
 =?utf-8?B?K0ZPckUrQUZveWU3bmJNRCt1MjNXNncxT3k0aFRCVm9YWG1oVHVLYk16VTZC?=
 =?utf-8?B?SzAzQ3E4RWovc2hhQXBUZDB0QXhpRk5PYzBpQ2FFemRKc0orOTJyWjgyTXln?=
 =?utf-8?B?WVNrM0xENTdUcmFlZ2w4ODRoeWVOdzMxWFZXYWVFWFRKZE1BcnNnYUVYNlRZ?=
 =?utf-8?B?dTI0d2cwMFA0c3JpWmlXQzAxVThhV1VTamwrWis3bWMzMTUyaE4yMEcwOVVs?=
 =?utf-8?B?WTFXbHlhSm9mM05kRUdtVjFRRnJkRFlHdnNjYWV6VVdSTi8zMmxlKzBzTWpP?=
 =?utf-8?B?YllvVHVuT09MN2h3dDlWYS9PMWZSTk9lWHk5MEptMjFXQzdienVJQlRxRGlh?=
 =?utf-8?B?Y1JhcktJR2NETzdIZm9CZFF1WHBybU1ibVREQXliVlNyRUVvV2QxbGp3WTZ3?=
 =?utf-8?B?TW1sWVl6VUVMR1pFelBGYTRRVDVUR002dFVGUnVZRVdZVXF2ZVFMenpqOGI4?=
 =?utf-8?B?L2tvcncvTzZVOXFzSHBwRTJMWURVZUFZOHBncW4xNy9UcGk4aUVXdmR0T0JP?=
 =?utf-8?B?dDRLNFBJQ0hxS0dra0NyaEZ3RFpZbzROK0puV3NDSXJGTWx3Rmg3aU83VDN5?=
 =?utf-8?B?ZWtrV2tRNkNBNjFnc3ZtZkFqWS9rUkhNVE04TXRNMGIxOHlCcU9NbU1QeWhs?=
 =?utf-8?B?SUpvSEt4SjJYQVduM3FHcUM4U1BIaXNLdTEzUS9XcUJxN3g0c2pkcGJmS0NT?=
 =?utf-8?B?VWo0RnZQOXNCVkxzblF0RzU5OTh3d05iSkk3V3ZZMTRFQnpLcHBqZVkzc21u?=
 =?utf-8?B?YzZHQXVwVXdmeUpXNnpRemM2bUVrUjdGaFRDcWh4VEFnRUdxb1ozU1B5VHpr?=
 =?utf-8?B?TTJYRExoaStYOUFFbDd3amt2SXRBdlJvamNSdGdLcVRpREg1Z2ZlaS9YTGlW?=
 =?utf-8?B?Q1JzK0NRY1VyT1NsRS9iZDUzV2dMR3JVWlBiODhjVG9seERjMHhQckpJY01H?=
 =?utf-8?B?clVJMnN1RGt6S0JKUkVzUHM2ZjNodkRRWnZDZGNWRnQ1M2hVVG80SERTc1ZY?=
 =?utf-8?B?bVVuaDd6d1YwamJvUmp5YUxWcHc5YXE4QkVheE5taHprbnBzZEx5MGZkVTUv?=
 =?utf-8?B?TXZjV2hDN2x6Yk9LOXhVaTA1d3c3aGl1N1BKTXkxdWlubmRiSEtYaEo1WHRv?=
 =?utf-8?B?anBRWVpqT29IT2xZSVVDUnRWOC9DVHdjVnVNU2VWQTlRMXI5clNIZHBuVGFs?=
 =?utf-8?B?cjBjc2dqeUxjWEdHU29nRG9WNlZGS01ORDAyTDM1V1FpU1dTYldkcUJKQ1Ew?=
 =?utf-8?B?Z3ducS84T2k3S0I0bDZPUG9ycEtZUDRNQVc0azZGamxHMmhaa2xoSUVOalhJ?=
 =?utf-8?B?THpBUm4ySmJkcVhSNFV1dWFDajZsMHNKZUJRenRLWkdINUEwZk5LamtUSnJT?=
 =?utf-8?B?RDlSMkNURS9BQ0F1S091cW5qWnAwQ2hSR29Hbk9GWjFqTTlNL1BjN0VYU3VL?=
 =?utf-8?B?WFUyNVhzVHRORTZPOVk2NVU1dEhCWGlET29mcm9OaXhiMGVLMkhhcWZ6N0ZQ?=
 =?utf-8?B?SjR0a2tIbG1GZ1d5QjF0SEJHb3d4K1FDZTRETG5aa3c4ZVZlSHhIZFY5U0lX?=
 =?utf-8?B?UzdMWnl2V3J2cG1ycVRVbVk4OExwejAxNHQySWhkVDUvSzdwZnpKeGR4YVgv?=
 =?utf-8?B?OTJtN2xEa29SNXM4R1puMDczYjVaK0hjMllBeE53RUFJL2ZiRDRybFVaZU1a?=
 =?utf-8?B?dC9OT3p0UExJN1NtdGxRb3ZGK0s1ZkRWbGFHYUNYRVExMFFGYjhPZHZtcEhP?=
 =?utf-8?B?R1lrbU5KWk9GSUxFZUU3cmdOWUV2VGVNRUFPd3owaExJaHZrTDBMNm5kMzRz?=
 =?utf-8?Q?DBGsrS05JuUrZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnRhYm9ycGIwRWg1ZlJnU0FGaEZtbWxmTDErZjU4MkJzaTREV0xtSUphSmhy?=
 =?utf-8?B?eHlkNmoxVzE5UXZOTDBtNWJiOWZtNlBKczZwS1NTaFFRM0RkMHhTU0FRRFp3?=
 =?utf-8?B?SWxtMUpZcG5pdVFqRUNPTUoxdjlsSHVFL05STkdvWmJMM0VYV1QrOE1wQyt2?=
 =?utf-8?B?aFNlU0ZoUHRIUzRMZDNVdlRUcHNMZWZBMmxiWlZ3V0hKbWlPcFUva2Q0dSs2?=
 =?utf-8?B?aVgrWmNuUXNrT2ZtbHBtbGYxRmFKcXFQZGhQUGtValpadTJTNVdFb1BoY1Bn?=
 =?utf-8?B?eDBpckk5WG4zejljYkFDcFd5dGI0ZklVcjA4ZVZZY3QzNEV4MGZCelgwVWVm?=
 =?utf-8?B?NWdUWW5FelZIWVEvdzVIQXZlQ3U0T2N3ckl0MjlRclFycWJielhJcWppMmlq?=
 =?utf-8?B?WmtHY3QyMmhqVzJ2K3pITEEwcXNNc2l1NTFYaGJvNWVYdWlETTFObC9tekt2?=
 =?utf-8?B?Y0xGTmIxdTRJeW1aNUtqZTBtWFNOamcxMC83VnRxeDhCdFUvRUhNeFJIZnNt?=
 =?utf-8?B?dE9VdzhSbEI3VjMzTzZybXR4YktQK2VoQ0dwTDJlOE1JQkcxR3FnUmNFOVl2?=
 =?utf-8?B?MXJUaGh6Y2t0RFFyTGIwNFBiM3lTWnJKdERKbUE0UHp2N1EvM2hsMU5qRWZ2?=
 =?utf-8?B?TGVvL1hSbnV2K0x2S1l0VEVmZ1lOQ3d3dWJhNnVWb1ltMzhINUJhWGRsdnVU?=
 =?utf-8?B?WVgxSFBBcmdhZnpaNUJkNmxJZi8walc4RExxYTdFdHJEblY5UnNhSFJ6b3Nz?=
 =?utf-8?B?bDFvbXV4VmhJSmY5UGEyZS9oajFDQVBvWTV5TnZYZzZ5Y3pxWEdEV2JPQmli?=
 =?utf-8?B?V0pPcS9JVi90MEQwVE5IZW10SlYvcEFoa1RkaTdNMHUyZjM3SWVMRTFIL3hm?=
 =?utf-8?B?ekV6Q25YbWV2NlpENFNZR252eGRzbVJrY3JXZGlYblVlTUtrdjd5Q2Jla3da?=
 =?utf-8?B?WmFFNnhWRkp2bUNGU0grQ1E5WWdsMTU2anl4cU9UTmF1U1l3VFpGbjM0bjFV?=
 =?utf-8?B?Q2JIOU14YmtEK3Y5SkJqQVF0UWo2ZCtRLzNlZTkyK3VQcSttbnRDcFA1S3pN?=
 =?utf-8?B?cVJjOWZmNFNRVGJpVTdnVXFSczdwejVqOUVYa3BKS2s2ZkJKbGVFSzdDRW8z?=
 =?utf-8?B?MzZ4TlpmRGJMZFczZDl0OU1Ydk81eHJWaG1od3AwTTkxSVlyYThmNlRlTjhm?=
 =?utf-8?B?dlBVTW1Zek02YXBxYVZoNHQ2Z1g5dUx5QmNoK2FUT2J1KzRMNWZ6dGwzRXpn?=
 =?utf-8?B?OVRndlFKU0QzaGNyMnBWR0VWZ1VyMlU3WSs3RFBRcmxtd1ZQVmZaQlBkeTd0?=
 =?utf-8?B?dmRDOFJrbXgwdjBYTFJiU041Q2c4UktQRXZkTE1DZnZyV2k0Q01TSGFJMnBr?=
 =?utf-8?B?VnZqN0lZZDRvMWNxamoza3p1NFJneDRoU0FhbTM3Qnp0ZXBQc3VBU1RsQUZY?=
 =?utf-8?B?K3ZiNG1VcktuZUp5Sy80YUI5UDNzaDhBZDlTKzdYU3hJMVNXVVEyaDI0d0lS?=
 =?utf-8?B?UVlvR09QekJ1N0tlMmhKbTU4dkNIRTZZcDlDNVFFblZSaExtak5wc2E4OUJv?=
 =?utf-8?B?aDVpazlDWklkenJHZkE3dTBPZjNpUGJ1TzlwNTI1UmNGdjUxMGVmR3hOT205?=
 =?utf-8?B?dmFvV282K1pYREIwSU1FVHozSTlSUU9pRWZDQ1UvWjJLTWREdHlpYjYvZzFw?=
 =?utf-8?B?ZFU1ZUplS1VkN1cvZU9od2hlbkR1eWVISk0wVnNaM1NPMHVtelpIVHkxdktE?=
 =?utf-8?B?czdPdjJjY2Vwb1RrS2VYMHpYMUpPRnRzT3ZFMGM2R0FzVE5WYVptUnRYVmgv?=
 =?utf-8?B?cis2cGU3NUducjEvQmZQb01aT1B3bHA4bkM0V0JCenF2RkhEbEoweGhBdFls?=
 =?utf-8?B?TzdrOVpCamx6ZnVUMStqTmpaOVN2QmFxbDlnS0NhK1ZPY0IwMnVBZGxtQmZW?=
 =?utf-8?B?UmJPSFg4ZTJyTGVSR2Nja29mbDJSb3pSVWdRdUZSY0t4b2NidW1ESVF1SkpB?=
 =?utf-8?B?THFZdHRiNUdXZDEwT1RTYlZTem5kSlZGaGdrTHBFQXU4T3dxbkhJUUM1UFE0?=
 =?utf-8?B?L1dkNGlYcXZWbFM0b3NHUzhTSDFMMjFIOFYvVHh4VmZkYzFzNzdZU0ZJb3Qv?=
 =?utf-8?B?a1BQdnNFSWdScTVBbzF0V3gyN05NUmVlSnRoTGxyVm8yN2VaMXpCMTd3RThG?=
 =?utf-8?B?T1E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db16baf5-b1e4-4eb6-b58f-08dd64178b66
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 23:17:24.3503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+mKURkEcy50YgDcruEFrSCAnF1z5auabpeAjP+H9+8bLJQXkr5Hrkv+UwCVequ6TcWT0zugg2hsi48VnKYtjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7087



On 3/15/2025 1:56 PM, Andrea Righi wrote:
> Hi Joel,
> 
> On Fri, Mar 14, 2025 at 10:21:50PM -0400, Joel Fernandes wrote:
> ...
>> @@ -7793,6 +7819,38 @@ BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)
>>  BTF_ID_FLAGS(func, scx_bpf_now)
>>  BTF_KFUNCS_END(scx_kfunc_ids_any)
>>  
>> +/*
>> + * Check if ext scheduler has tasks ready to run.
>> + */
>> +static bool ext_server_has_tasks(struct sched_dl_entity *dl_se)
>> +{
>> +	return !!dl_se->rq->scx.nr_running;
>> +}
>> +
>> +/*
>> + * Select the next task to run from the ext scheduling class.
>> + */
>> +static struct task_struct *ext_server_pick_task(struct sched_dl_entity *dl_se,
>> +						void *flags)
>> +{
>> +	struct rq_flags *rf = flags;
>> +
> 
> It'd be nice to add a comment here to clarify that we need to call
> balance_scx() before pick_task_scx(), so that we can trigger ops.dispatch()
> and consume tasks that may be pending in the BPF scheduler's DSQs,
> otherwise pick_task_scx() may not find any scx task to run, reducing the
> effectiveness of the dl_server.

Thanks for pointing this out, I will add rationale for the balance as you mentioned.

 - Joel


