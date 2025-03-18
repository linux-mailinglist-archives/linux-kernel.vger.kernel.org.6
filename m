Return-Path: <linux-kernel+bounces-567014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F49A67FDF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 23:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913B519C2163
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FCD2066C1;
	Tue, 18 Mar 2025 22:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AG1d8taE"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D523DDDC5
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742337464; cv=fail; b=DMhIXlki9PQUalX2+5s8zFOWXPNr/T6O3hWONtQcI6v91DtpS2zA0U+LP0SZnhDykJyIy5ZbqKN219NWMZeu9glRQFj6u/A4/BBvygx3m7aLz9sNEMXI2EGVKtd5DDBy8R4g7/Nj64PNQKnlbkXiVhJ2fLcUuzcwhbwZ4m9g2XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742337464; c=relaxed/simple;
	bh=trYlXnMI0z+i1j/2uZmz/9fFlCltjqO2M93GqVuHLmM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VFoDNieiPgQfePoTz6ospfpWZAydn2mfXM5YKZNJvRHt7CUj0WAv+iU+906wVvwgd/Qr6zd82CVvS4d3uOTk7RIlVA1dOG9snqfyEZvXfEpeJb5EN4yOT8YsVvde85gor5hwHoI1RIk7H7ur49kAXJIhXgYcO5ZIoT4nPDODPjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AG1d8taE; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0OImNdTrxejCD8sKSHzinbIitEnxeX7nkLGXQ78s4d4mwrhK8qbx/lmm9GB0pv2W0cha9rUxDys64sGlN512qlROTE6bcER1zXM+IoQEhD0y7jb5f4hpPWspujKtYvgNXbiMvJZLPIP3ZFqgiSUbEyFVye+688JIUuLc5vdI9gWnY+8IcFk/PuYn40sxbAHT7cLs2KhT/+WZ5p/tWWN1Fk/gMIYThTjbT0xpI9uKRJGSWEYFvzznvoswYRRhh/kC4P7IyBuRCjfmnb6SbJPlGzRSzFmaM6j0k01GJLHQN5+JBnJTJEF9uL3V2E/OZ+01T+1QfT0omeUHAwNCE1Y1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1LDuKs8O5xDPw60Y/4IGD3D6MpQhS7UBh00JDQJilc=;
 b=LNGAImItUMdK9AiH88xRLs7M1sNY1kSI63DcsJkJtFIMtdby1gfZPNj7kbvArDHUr0BU7P/AKwFmiUab2h3UgW9DcHB7dMPnqTVeqS+x6F88m0v9XJuTJoBvgXsvTlunGS7JxX8auwwHQJMyv3GdIByGbvPjhSR/aXk1kyDcpTGgB0RojD5O/qj3ovjYN0vzV2yjRxgpPxVMfPG2FVgphR38nyLu4hS6aGKz8TeEo4ZRqnkP5HNO2jMqiz1E7P402kI28RkPEQh0rZ9zUJXjC4eQfJDaT8wjMffN0sQy+me8Tx9+KtIxI+WbHx+/bXaLsyFvYx19kL5GHCxlwaGHEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1LDuKs8O5xDPw60Y/4IGD3D6MpQhS7UBh00JDQJilc=;
 b=AG1d8taE5Jp99pJd7q4lQK0lCLgW6CFsc5V+rbrJ0acMBjO5DRjLhT2ZyivP8FOjQLYSZWx7ms48uNKhDsmHx/FEvNXrhLLbtg0QZEt2hq3DqqtPikiF7lcoK30cXHuxCvw52S4twZm2napba8V5HMn+fYXXwO9gmERVpHBfnQ8doUILZ8hq23rfMr6OlJLTawOlLZJwuMDcPPPffgswxluk7uIL46q4x3nwP3/QBcWl2YUT/ewmiy2v0+lLnOLki6d2Eg1Orsmc/jQjJXYpyF78vywaAyz9oSYGVwr7ehZ/79Yy8Dn4kLyQbsn3zhd7SkdKwLLnnw1JyBHZTb4Vtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by LV8PR12MB9643.namprd12.prod.outlook.com (2603:10b6:408:297::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 22:37:36 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 22:37:36 +0000
Message-ID: <6838a26a-7cfe-4c89-a68e-f8eab57a23fe@nvidia.com>
Date: Tue, 18 Mar 2025 23:37:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] sched_ext: Choose prev_cpu if idle and cache affine
 without WF_SYNC
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
 David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
References: <20250317082803.3071809-1-joelagnelf@nvidia.com>
 <Z9hW_3cPN8u7VURV@slm.duckdns.org> <Z9hcUSp6P72wT5ig@gpd3>
 <d9bbbf0c-64ad-4304-aca9-ea48febba402@nvidia.com> <Z9kAFnrTvqH_AzEj@gpd3>
 <20250318170047.GA3467630@joelnvbox> <Z9mxc4lzDTHSpLq4@gpd3>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <Z9mxc4lzDTHSpLq4@gpd3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0308.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::13) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|LV8PR12MB9643:EE_
X-MS-Office365-Filtering-Correlation-Id: d7c3f59c-f433-42aa-9150-08dd666d7b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzkyMWVndW9xL2pjc3lqamtvMzVEbXZvb1ZKK3lNN01UVTVKbE1YU1JLQ2Rw?=
 =?utf-8?B?a3JlNUFGTnJTcTFxTFFRWVNqMjdtR0pnclpETDRVZ1E2dE0vSmsybXBXZnhy?=
 =?utf-8?B?Wm1kUjB2NWZKSUJHOHV4UEZlSHJjWGRIanBZbEZGbjdjWGl4YnRwMFJYUFFG?=
 =?utf-8?B?OEZjemhTRjViTGVMclQxNnRkOU4zbjVyQXluZlF0NU1LR3hXVGJ3K2xjMFp5?=
 =?utf-8?B?NjdqMmRCeWptWi8rOWU2dldTOTZmU01CaXVYbFVnZmRzSE40NzNiWjRxbGRv?=
 =?utf-8?B?S2k5ZzNEMjljK25xRHdScVFMcUd5UWppMUxrV3d6Nk0waFFBMTR2YWlzRDhM?=
 =?utf-8?B?MDhNYzN6ak1kZno4MFVYekk4Nkt0S1Vvd0hVYnFvcmhyRWhYNHpnb1lJM0tL?=
 =?utf-8?B?Z29iZHJ1OWZmb29LdHptdXl4cEpjZDNGYzRIRXExaXgxMWtqY0JlSTVLMzg2?=
 =?utf-8?B?b1FLcHFvY3hhT2c5bThtMm9TN05vYi9ZN2dNeFhJOVZjTWYvUFhjOWZSbkVs?=
 =?utf-8?B?b0Z5SDRqbXBZVExnSXRieDlaZnpCUDh1SHFEU1oyWml2Qk8rSmpySU5tREFF?=
 =?utf-8?B?UmpUdStLQ3BoV0Z1RkZPbGJXa0dKa1NqbENBV2cxSFhrTmd0R245VTgxWjVH?=
 =?utf-8?B?bTl5YVFBZnRVNzdmUWtWbExYL1NwNzZwaFpyQlZCZ3NEYnBOY3NXUmVFWkdX?=
 =?utf-8?B?cU1mS2FzL2MzaDAwS3RuYlFWdEQ0cjYybTR2ejh3VHhUV0s2aFZwL3lPRElH?=
 =?utf-8?B?TGZ0SmFXTWFmU0l4RndSYzdyL3ppb0N2Y0pFVFZPZE1MZ1M1Y3RSVTVwbG1p?=
 =?utf-8?B?M1JZQjM2eTBHWlhqYTRJRHNNNjExZTErS0ZRREdDem40NFdQSzcxY0xpNWVH?=
 =?utf-8?B?NEJjN3FmL2I5d0lIVFhsakRMcEkvV2RtUzUyQXhLS2dSN29oMzBsdStHYksx?=
 =?utf-8?B?bi9lRFJxMmFaSFpTdXUrYWpDM2Rvb1VoUkkvY3Fsd3ZTd0pIY0RQUDlOSGhy?=
 =?utf-8?B?Vld3SnFHUE1nM1owTkpwV0srcWZMWHhPeVBwbGdTVHRvSXpWWG9OTW1IVkNZ?=
 =?utf-8?B?L3k3aitPakVkcjB3ZVlLckRWUkJ1Ukdsa1BiaHZFS2QzL25NdzBLOXlUS2gz?=
 =?utf-8?B?RjJRM2VVcXFFVmhQYnpObEptNndUV0F6MWFGZWl1b1paaTc2L3E1VWtHQUJq?=
 =?utf-8?B?TDF6QTZYT3pnSUhPL3M0T3ViQklCSkZOQ1RZTGtyeVoyRFFYaUx5Rk5telVq?=
 =?utf-8?B?MmFHaG9sdzJwOGh1TXd6Q2dvMUxTbTh5K2pkU0pwZnNFdWNyanI4aXlxcVB4?=
 =?utf-8?B?SUFpRFRpa2o1Zm9CdUFFN0E3OWdWc25xTzlGNzQ4QUh3VHB0QUFVL290SWwz?=
 =?utf-8?B?TE9uMHZYTksyU2NDQ3pJODcrTjVwdVFBRjdPTFl3bFdLREZTMUQ5RlFreWVX?=
 =?utf-8?B?RmF6ZmY0b2Y5eTRhTGw2QlJKZXdiSFNERUU4c3JJSytvZ00yblFCQVR4bEts?=
 =?utf-8?B?b1lrNy9Da3J4M1dQSVVtczhuL2ZFNlV2RzgvQ0pCYnBiaGZSWExXYXIrWTUx?=
 =?utf-8?B?RHZKN3ppWEMzOWFMYTZzK0JmQ3RTWGlBVjljYWVuSUt0Q2RLdVcxb0JUWnhZ?=
 =?utf-8?B?ZSs2Yk1vWldmbEl4UTk0SDhBOVlDc2ZNeHdTMVpaS3RGdm0rWkdkaEJLRm16?=
 =?utf-8?B?eGVEZFNOSGVnSjlqbEVxSXljVUpHTjRheU5HeU9zNG16M2o5YVZZOUd4VnJI?=
 =?utf-8?B?bFNLQldNTnBaZEpjdEd6blE4TDJYYnh1SWxiL2wyQ2M1T053bm51RGpTQUZF?=
 =?utf-8?B?c1RYbiswekFmdmk3OExrSXY4VzdLRnNpS21PRExCQnczeFcrZ25YL0hadXkv?=
 =?utf-8?Q?0hK3dil/mAmzM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVRZRVlLVW1Xb2R0REt2S1Q1US9rWTJReXRnOUdmaUlGYStxSlN3SWRNOEZB?=
 =?utf-8?B?Z3d2RVpTMmxJZkZZN3NBQ3F4S0lETFpaNCtYZWMyS2trbFM0bDhVSHJlcmYy?=
 =?utf-8?B?L0RKTUV2R3ZuUlUycWJ3eEhSYzRoQktxOGthd2toUk0yOGFGdzgwR1I4cU8v?=
 =?utf-8?B?RStuUW5oWFhvdENlQllmQTJleGFpeWpWaDNkbzBEOHZ1UkpkQzVLNG9uUm56?=
 =?utf-8?B?OUhWanVJWUsrOVQyOTFRSXJIZ3RRVVBTcXU1MHBsWlUxalVzRnFZWHRBb0sy?=
 =?utf-8?B?bHdLMXFDTUlneEV3U2pFd1ErcWNVNmRabmU1MHI5Vk9IL1hoVHFZTHgxZWti?=
 =?utf-8?B?bEdkMFJ2ZEVxWHpCZVFPNnJLT1ZhclRKa0xaVVpNY3FxNldMWTVQb2duUmw2?=
 =?utf-8?B?SjgwUU1KNHZYVVRES2ozaENXdFpqMzEzUkNVZXdzQWJDMElxcVYwcGJiMGtZ?=
 =?utf-8?B?eUo5UHltcW1UNElxS3JuVUQwTFJwekY1QjJhWHpudVdOLzVVUTgzWWRVeEw0?=
 =?utf-8?B?aHU2TDVzbmw3aFl3R3k5eDZGN0k3TG9RWFVpY2JkaVZzcmdVRjFqZkVhWnNG?=
 =?utf-8?B?b2l0Vm9QSUFBYkdxOUNYUVRURndnVThWRjc3Q3VORFNGWFFia0VSMVBISjIr?=
 =?utf-8?B?OGFiWThEc1ZENVJmVi9nRFg5RU82a0JrcXJXN2FNdFNGYVp2MkUwUzBqcWV4?=
 =?utf-8?B?czVGaCtqR3VNRnVxUmdrWGRDVGRnSjhmT1JwYjBJZGlrRVdNdm5xUERlKzJw?=
 =?utf-8?B?d3hzSUtmYWp5Z2M2WFdieDl4WXk4eVBjZytlWjBJbzc2aHI5U0JmdnVHMVJi?=
 =?utf-8?B?L2ZObE1oYXFLSUNvQm1JK2xzeUc0dzMyUERwaTB2STFBN2tZaWFQajlBcjhR?=
 =?utf-8?B?alJoVWhTeVJVOXRyU1pjUVFqR0g4NlQ2Zmw1YVVuUllNamZLYUVXZmR4RnlS?=
 =?utf-8?B?VzFWV3JUMGU3VkdDK00zMFFrTEhsOEhYcjBteDhSZFRXQ01vYmlxdVJ6YXhE?=
 =?utf-8?B?U2dvanZvOW1uOG9KOS8xL0liOXduTFRLRUlLUlBHR244OXJTcHV6VmhXUktH?=
 =?utf-8?B?WTJFaGFYbFV4TzFVU1NXMkMzNUVpTmg1cGtjUlNTbUd5UlFGRG85S1hPNmdK?=
 =?utf-8?B?SUNmS21ZWkZ3ZitPUjMyUUF6TytMa2p4V1JSdzBxbTVkSm5FWExRRzdqS1l3?=
 =?utf-8?B?eXluRTIwbXNJZitXaTZsNVdxaVo5K28xRkh6c2EwV1h2dFczdzFqRDBOd0Zs?=
 =?utf-8?B?TnNZTXVaeW4vVEcxT0FCaGluZkg5d0h1WkphWU1YbkZ2N29LWXZ2TEtIWXRL?=
 =?utf-8?B?NEFBd3BWRng0Q3RrVUExdkVkMU5XL3RRRjJCcmJVMWYwQzJjTnVHUElZMzZl?=
 =?utf-8?B?RzUrbUpVQ2VTLzFQR3JjQmowZkZiUXhSYlYycmlQQUtQdFp6cWp2ZC9mb0Z0?=
 =?utf-8?B?Uk9rY3l1VytGRnNtL3RnT2E5V2c0K002UVlEN1pFNkVQajk3cG9PVkZ4TFMy?=
 =?utf-8?B?d3dGTXBqM0dTUkFkQXd6WjhaLzNmTzVFcEVCUUdHZStTUUFrMUQ0c1pZQlJM?=
 =?utf-8?B?aWlvT3JzeHpRSndkWDVTdzAvT012R1dKR2wycXNQQ0lBZFlNcWdkenZnVWE0?=
 =?utf-8?B?YkpyQ3ZFVGZXSXEzN3ZPWUY1QWJ2Z1F4VGpjVkc2aWY3S1liUVRLZGhLWXUz?=
 =?utf-8?B?VEUrZ3lxSnBkZjc4MU55T2F0cmFsbWxqU1FHc3ZNZHFEU1ZLMm9UODhjcWhK?=
 =?utf-8?B?cUxQK2FmRzB4QXpFQm5rS0E1a21tTWt3RmFmNkJRdXNubmZRaUJnd2pVNDZE?=
 =?utf-8?B?QU1PNUNlSnhuOXFXdWF1R1Bhem5iTHo3NGFDZElhVVBhYWRNZ2JsVVJ4N2xW?=
 =?utf-8?B?L2pqSmhmd3NtZ1FrN05ONkdXcUlKdUV6RjBNTlZjYWlVT3JxWlp2aDZqazVl?=
 =?utf-8?B?WGo0RUtIMzdOUVpQTjYzTURlUXlGZzVaRSszUGhUM2lCS0gzVld3d3UwRSts?=
 =?utf-8?B?Um5PZEtNWnQ3STcyaUpLU0VpbExjZWJSYUxMSDMwa1dFS0hid1Q4cHQwUnVI?=
 =?utf-8?B?T3hqZmNQenB5T254VjRUSzUvbTFxRk9lN0NNWTJ6cUFuY3ZpcnQ3R054TllQ?=
 =?utf-8?Q?fA6fje6CVrxWTeM5NO6BMr8SC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c3f59c-f433-42aa-9150-08dd666d7b2e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 22:37:36.5818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AyVj+NJ1yDviQZP6cxX3A79zf75uGOR8z63bs+NuObfuSMwHlquERJJWxFW8ZXVBt6krVqDe1VEmlNZk8O/0Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9643



On 3/18/2025 6:46 PM, Andrea Righi wrote:
> Hi Joel,
> 
> On Tue, Mar 18, 2025 at 01:00:47PM -0400, Joel Fernandes wrote:
> ...
>> From: Joel Fernandes <joelagnelf@nvidia.com>
>> Subject: [PATCH] sched/ext: Make default idle CPU selection better
>>
>> Currently, sched_ext's default CPU selection is roughly something like
>> this:
>>
>> 1. Look for FULLY IDLE CORES:
>>     1.1. Select prev CPU (wakee) if its CORE is fully idle.
>>     1.2. Or, pick any CPU from fully idle CORE in the L3, then NUMA.
>>     1.3. Or, any idle CPU from fully idle CORE usable by task.
>> 2. Or, use PREV CPU if it is idle.
>> 3. Or any idle CPU in the LLC, NUMA.
>> 4. Or finally any CPU usable by the task.
>>
>> This can end up select any idle core in the system even if that means
>> jumping across NUMA nodes (basically 1.3 happens before 3.).
>>
>> Improve this by moving 1.3 to after 3 (so that skipping over NUMA
>> happens only later) and also add selection of fully idle target (waker)
>> core before looking for fully-idle cores in the LLC/NUMA. This is similar to
>> what FAIR scheduler does.
>>
>> The new sequence is as follows:
>>
>> 1. Look for FULLY IDLE CORES:
>>     1.1. Select prev CPU (wakee) if its CORE is fully idle.
>>     1.2. Select target CPU (waker) if its CORE is fully idle and shares cache
>>         with prev. <- Added this.
>>     1.3. Or, pick any CPU from fully idle CORE in the L3, then NUMA.
>> 2. Or, use PREV CPU if it is idle.
>> 3. Or any idle CPU in the LLC, NUMA.
>> 4. Or, any idle CPU from fully idle CORE usable by task. <- Moved down.
>> 5. Or finally any CPU usable by the task.
>>
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>> ---
>>  kernel/sched/ext.c | 26 +++++++++++++++++++-------
>>  1 file changed, 19 insertions(+), 7 deletions(-)
>>
>> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
>> index 5a81d9a1e31f..324e442319c7 100644
>> --- a/kernel/sched/ext.c
>> +++ b/kernel/sched/ext.c
>> @@ -3558,6 +3558,16 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>>  			goto cpu_found;
>>  		}
>>  
>> +		/*
>> +		 * If the waker's CPU shares cache with @prev_cpu and is part
>> +		 * of a fully idle core, select it.
>> +		 */
>> +		if (cpus_share_cache(cpu, prev_cpu) &&
>> +		    cpumask_test_cpu(cpu, idle_masks.smt) &&
>> +		    test_and_clear_cpu_idle(cpu)) {
> 
> I think this is always false, because cpu is still in use by the waker and
> its state hasn't been updated to idle yet.
> 
Summarizing our conference in-person meeting, we verified that in case of
wakeups having from IRQ, the waker could be in idle state at the time of select.
So I'll keep the change and will rebase and send it out again soon.

thanks,

 - Joel


