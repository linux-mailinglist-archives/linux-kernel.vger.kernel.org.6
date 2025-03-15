Return-Path: <linux-kernel+bounces-562784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4C5A632EA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 00:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9183170D98
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 23:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB001A9B28;
	Sat, 15 Mar 2025 23:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j0ogjuL7"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C16B17995E
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 23:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742080536; cv=fail; b=HbVr8rD2OZoDky1+lKTA1gv+2tMR9IWQXZJvteEUj0tjvbxur4e1hL30kTrfWlWe37zYnYUFvclMRsZK1D+34dvRxlKgUVn31+Lpp7TQ3vqsnO03CxkBVYY4MWa8Lo5b49Z9gehE81V30X4kolfbi9jfgQFpgfC2uJbpNc4SRaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742080536; c=relaxed/simple;
	bh=Yv2pNIwDH95nM6ePMnZ3elctiI2YpCxQz+jxxpTkRAM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RlO2Nmj74cpUiQboNpyhz8RxSgHzVpq6JPMUFZsVG6HQkqYrolDmmYR9aL/aWGNwgYsEKDjyBku+hCnZX3FRXA5ZujACzHAG1ET0vxbaqGMgvqh2OytxoXHeV9dpNZOd+3a5K5IhIpG52+gkKeHfEJ6kDTrLTPFAqjgdTlpl5K8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j0ogjuL7; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJbDiVF7hrZ01Nh6pos0ToUdKqBXtkqWb0V++HM1JFW2K2wLEBzP/7DCfzNYkCZmp/MGjOmCWaxy/Fi4MHk6A/rJHklzix7pJjPehcr69ybZFsjD22xjtWjsXQb6IvYALlYC1bz5IgdPFwhyKhbDeipe0Fz7QMU9SL7D2uH466cJKqdUki2UPNbiM7nnbv5g4s5NRN1HPtgDNE7JnhN/7UHXA9mKjR/0KdJfOxF+lIAmDOWEOSmz4JMbwIe5acBy+c/nybKKubrVQNPL5K1Lg0gXW95WFVsJvY6PkYPAZZPy97iW3t3N66+EJHXqe3+xtJMfQtIqvJ/tZ2FZ7i/xxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grxAUTofk4VjzqdIlONv/usIvmvlH+de9nVFAVJ80zk=;
 b=f6BjnQpMDhZ1aGkClgL5hkAFgYh6VhazWeYFmENZffMEkdh9K9AIcaEORRyzks41nL7p24VgZZ8Vtl4NnWXDV2LZ5OoJRpAu4eQMc5/WJBAI5MyvbiFO/ico6klDiGYzraqRxPEGVn+vCynhgTuy4Fq5D72ivfyNtH9rkdnBFwavPKpE/bU8s34b8FRSR/Tz3R2AAhon1qWKDz+UfhbicLccixSakN93+fbNRsRoLKaYlsKwD+T5c1lp9LulS5SzxFqDJkioC5NyFaI6bDRbVc0QltHgVgIkw2Tdw+2gO1R7DTWrKI+dwvPyCrd4Djze0tr976Mu2x1HkuuhMv+tMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grxAUTofk4VjzqdIlONv/usIvmvlH+de9nVFAVJ80zk=;
 b=j0ogjuL7AafT/9uYSe0+hN6oaFkR9NzS/XT9Rmvoa8UqrqKa+L5q7xqG38+5iJ1aFp4kiUoikCDnqqYDwV+Lxw5fylGDsQi/zjvm+O1BpDnddxWDJG2ycwbZV27p3vO8HN0HOH7/Fj3Th0ITftiI6A2bVKTaxLgbYQGjby3yBkCi3nQmm4K5wUEL+N2iX4Nj3/dC4BSQBHaaV5fMVHRq6vOH/VX1Nepl+88dfyECncN816h1ERUu7YAc30mdEApM+dffYoMyxFv62gfszQ0Z692+NawQ6FJNTmIOB53p7g9pxV6vVF5yCp71JvwkmVB2qdhgqmKkrQ1Yh45P4gYkug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sat, 15 Mar
 2025 23:15:31 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8511.026; Sat, 15 Mar 2025
 23:15:31 +0000
Message-ID: <3b244939-6d55-4d86-8b77-a9a7629f8239@nvidia.com>
Date: Sat, 15 Mar 2025 19:15:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/8] sched/ext: Add a DL server for sched_ext tasks
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Andrea Righi <arighi@nvidia.com>,
 Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
 Luigi De Matteis <ldematteis123@gmail.com>, paulmck@kernel.org,
 boqun.feng@gmail.com
References: <20250315022158.2354454-1-joelagnelf@nvidia.com>
 <20250315022158.2354454-4-joelagnelf@nvidia.com>
 <20250315072225.GG36322@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20250315072225.GG36322@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0037.namprd02.prod.outlook.com
 (2603:10b6:207:3d::14) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH3PR12MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e9a7010-7c26-48e7-fea6-08dd6417481b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnB5OVlGU3J0NUM5SkVaUkNUaFpmS29RREtWSHpHOEM4OFhoaTRkbVJ5U05y?=
 =?utf-8?B?Um1mQkVjMWFIcVNGU0tUKy93bWFIZWZId2xwcFlPTHovUktvUkIwV0o3SVU4?=
 =?utf-8?B?WG1uSU5mUFlwekprZ1JXcGVMT0tRZG5zY3p2eWU3TVRTVko4N3REV3h5U1pY?=
 =?utf-8?B?WHgzTnZYOGFHL1JKOWNESHF0K2p6SGdIZE5sTkQyZlVldW9YV254Q0QyTmRq?=
 =?utf-8?B?cTBuZWF6Z1RnSENqcHRDNGVuWHErZGVOLzZ2eVFPTWF4SFBScEhacDZMelgz?=
 =?utf-8?B?SWFORTEzWnNhakc3MDJocVpXM05TR1JYNXdlWDV5b20xUVQ5Z0ZTNkhsMEVy?=
 =?utf-8?B?bkE1WFJ0S2E0WTBSamFtQlFiM0dxV1pYWm1JZzRFajh1aFF6VkdINE9Jak1o?=
 =?utf-8?B?QmswUVpOeHM4WmVJWmZhMTVkN3kxQjl4aUJVZFA4NStQZGhOZmVDQkIray9N?=
 =?utf-8?B?dTlpVVJwQnFxOSttNlJ0aHhYL092S0NOYjVzb2ZDWXVpQjliRFhQcGM3WFZq?=
 =?utf-8?B?cXFYUjJLWTMxNEU3T09TcHc0MjdNWGVBa1pyb0xmQ2gxRWlKczMwUlJqMHBY?=
 =?utf-8?B?bE43YmxLQnVjTXZKZ25qTXo5RTA1dzRYTHJOY09tNzF0QmxhZ2Y2WVpFZnVv?=
 =?utf-8?B?cVJjdXlhb05JNmRjSVpUdnY2a3ZqVDZ4NGhTUGlSd21KMGd5bXd6cUcrWml2?=
 =?utf-8?B?bEJ1dGwyMExtakVBa0xjSWhtYUZQOE1La0p3L1JqQ0t6dGlLRkU0QXllNlpn?=
 =?utf-8?B?RE9OeWppd0VETXFHS0Y5ZkhGMlQvVFlCbHlld1phaXhUWTlQMGJBN3hjUjJO?=
 =?utf-8?B?T2o3WTYxS2R0Y0dneXRSYVo5Q1M5UzlGUU9sdWVjZWV4OWlnd3JmT0NtTDBN?=
 =?utf-8?B?blJuZ3RvVTFCWDQ5VXVla0dsT3ZhQWtURGdjaDJGWjFQTkhWODg2RGJncEhR?=
 =?utf-8?B?OGU3Y3U2eUhZMUpqU0pic3pveVd4UFkyWVlxNzYvZFA4MHljZkxPVE15aGxu?=
 =?utf-8?B?Sm5wOG1uNDRGYVRFQnNla2M3RTZ6UElLK1RwYituNEdNRmFqUGQ0djBsUm05?=
 =?utf-8?B?a1plc3pWcGVibEhkUmJBVFJla3llVGE5TklXUWU5bWpzTTlCbU8vamdSVEJ6?=
 =?utf-8?B?bVdZUGhHSzFVODNvekFUcFVFaVVJclZxRkNqZGZxVC9IeEtMYWtaMWZNZ0J3?=
 =?utf-8?B?M1c4K2hyNVU4VGhiWlIxTndpZlkrYkZUTTVka2o5NzdFRmxVVi9JT0M2OXBP?=
 =?utf-8?B?YU5QcVBqZ2FkcHVSMmg5Vko3dktNbHRMYktzNi9Pd1l1NWhTc2U0VXE4dW9J?=
 =?utf-8?B?M0xacVQzc2VuNlpGWDFEa3lyZXBwNmF2a2JXUnVIekxTUEFmU010TURLSkZT?=
 =?utf-8?B?UktSZTl5VEM3Y0lkQjFpQ0tLdnZkRmtlYi9SeHhiVTdPNHllZmNtb20xMFYr?=
 =?utf-8?B?UEpuSXJCajlRSWg4NHFZUXhGdUxaanBkRE9Dcm13bkRyUXZ1NnA1NnpqTUdq?=
 =?utf-8?B?UmhtVFNPME9kMlQwak03YTlHUFcwaWZPZkpUc3R4THRyWGQ3RHpSSW1pdmd2?=
 =?utf-8?B?UjJCbW5VRDhoRnc2TUIvalNwcWZQNXJOWms3WUs0MFlHaTBZY043WTRpK0RY?=
 =?utf-8?B?VDZlelVJeEZFZjNmRjdzcVB6bkNoQkxXUlBqTUpEZ3hDL2orWHBjb0pZWjRK?=
 =?utf-8?B?a1gvUzU2NTNDRDVCalRETWQ0ek9UK3lJc2sxR3JRTnplY1RiNm42WEVnNmJU?=
 =?utf-8?B?dy84a2pYMWVtZnZRem9wN3pRTWViK2hlYjVVc0pocnl2UEphekF2Mjd6YTZ4?=
 =?utf-8?B?UEsvWHNwbC93ZXFoQTUzUGczTllKUU9vY21aMzYwZXZYeWkxT0FON0lkT01Y?=
 =?utf-8?Q?xm4hnKkrXpptk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wkx4M0lvSERydmlSbzk1cEV6QjNCUVpqL1ZUdGdvdE5SbU5VTm9OVWFMb2ZP?=
 =?utf-8?B?Zm5VdnYvUUh1Z01Wa1YxaE5vcWRuUytYdWxKMUZxRlBPVjJrZ2FOQnZXcjhL?=
 =?utf-8?B?MW82YmRyNVpkTkVYVTV4ZkVHNEJOSk41VFhockQrWVk0S0tWMy9CTDlSSTY1?=
 =?utf-8?B?NFZzZlhEOVBJVGJVZS9ESEFNWU83dVdVZS9aM1dFeXVnWFJWbmpIcVJRTkJO?=
 =?utf-8?B?dEpMWTZoTHp5cUlGMXdpSlV1biszbjdnbnYxVFlNZ3ZzeTJKYnBMSys1V0wx?=
 =?utf-8?B?VlZIbWJqNTdCOXo3L1hFMnZHaTRuTHByMXUrSE9YOS9HeXREVTFEdERCbWRZ?=
 =?utf-8?B?RERhL3dab2NPMThoVHNFSXZlNmNkWWtLSGdsTjBoTGdNSm1PMzg4VnRYeFpx?=
 =?utf-8?B?MXNIYUxqUDFlQU5LZGE0SktubWtGa0FpQzBzOU5DVzhOck5nMGtMODNjSG1I?=
 =?utf-8?B?c1ltQUpGOVVBQTF3c3VsSFlyUTN6eVBmL2N3OW1aRTgvZnIrVHQwdWZMVFhM?=
 =?utf-8?B?N0dGL2kyUTMra1RQR2F2UTRNSDkzUWY3NUhialo5NlB4bkY1TU5IRkk2cy9T?=
 =?utf-8?B?TVBqU3Z4NGpJeUYydGkrc3ZWRFdnRVNyNzdxVkRwT1ZKdXFXLzdlMVdCdFJa?=
 =?utf-8?B?NWxTNXd2UDZEaFA5N3VFeUJZQkxaaW05bTAwRHhYTXExamhaRkdBSGpLUERh?=
 =?utf-8?B?TlRHcXJZUjlIekNHeDBmanV4RzlJTGFXcXRYaFJrSTJscHVnOGt1Z1Bxb1pU?=
 =?utf-8?B?ZHVqQ3BNZlNNNzBidWFyUGdDUkpvbXQ1WkJsc01UMkpqUEVFYndTMzJ0Q3h6?=
 =?utf-8?B?aTdKTUQrNVhvNGFrZ056SmNaVEdMN1lsbndiRTVRWWJkeVZ5R0c5Q05PTFZk?=
 =?utf-8?B?aU1wYzlFYlI4cFpHcmFLMmRzVjBXcG5VZzVrVkR2SEp2VHhUWDdQMGNrN1NG?=
 =?utf-8?B?WVBteE15RHZGSTZkTGNxcllpd0VueFB0N1BUelJlOWVtNXlrL1hTYWdDUUFV?=
 =?utf-8?B?RjVTK2JlT2dwbFhkbThKYlRLSUovNEVYS280bVk4NlFEUGJGV1czSkhwRzBJ?=
 =?utf-8?B?RDV6eGJPS0wwajZoN243Uno1QkRtYVNoUHVBelpWTmVhWFQ3cG5FYlBqZ1hF?=
 =?utf-8?B?SlovLytweFl3Z2UyUFhtZnUzU3ZXMlB3N2krWWM4OVhZVE9ZYVUwSkFVMlZi?=
 =?utf-8?B?Zm9qSGp2eXlhTDI3TGVwMm80SDBIeGJjMnZxc1FOMkNiZUZnMjRDRTlYSEcw?=
 =?utf-8?B?VzZjSllMYmV4MXZwRFVPQncwV1ZURXpSME5kNS9KS0FDbDdDWVRlTCt6ZWhw?=
 =?utf-8?B?dmVXcWlUQ3dqeU40WVpFb3VUSnVjV0JSQkdVY01GZVpmT3JXNWNuYkthM0Jm?=
 =?utf-8?B?bVRpdkg2d2ZTRENibTlSYlhGY1BjVGJwL1RtdEgrZWtXRFZIRThPYW1ySUJZ?=
 =?utf-8?B?QVMrbW9oL2J4OXFFTkgvMVBWQlZOTnQ4Y0xqUWpsMXZKY1EyYk80dDZJbWlE?=
 =?utf-8?B?SnhydkpMZWpNWWRFaHVqbTZBNXk2VVRWM0NLRitUNzVUWUNPNGxIOVNSVVg1?=
 =?utf-8?B?SE9IdkFvMnI4OE9hZ3JDd2xnbk9sVTFJQzliRHM0alF5WE8zU3pRbzE0Rzk3?=
 =?utf-8?B?bHBWckdqTi9WOHBCY1pKdUd2RHg5MzBtViswc3d1VzMyYzVLZ3FoOVNlbVpG?=
 =?utf-8?B?bWgvSlp0TDJpZWZ5cHExKzFCeFdxdElRYzNRZkwrdEV1QWpyVmJ1eHZ6dGlV?=
 =?utf-8?B?dWJUZGVZby9IOFZnRWRTK2dyRGl6YmplR3FZMWZCWFNLc2xWNllUS3pwdVhC?=
 =?utf-8?B?dkJSVkdiVkxXbWIyOGJPVnA1SzNQb296Qk44M3dkTHYvdFNJSjQxNHI1bWFl?=
 =?utf-8?B?Uk5ud0hiM00rcGd1eUJ5L2w2dktEbWJOOGIzZGFURloxa0crZ281S2cwODhr?=
 =?utf-8?B?WkQ4UWUwSnFTdXFLU2tCSFJpcnJnVjUwbC9nd3ExSFhNSnAzd1RMdnlqWC9t?=
 =?utf-8?B?b1JrRVhJQkpUSnN1NmxCYTFXdmZDZG9tQ0NqeTlQOS84Sm5sRGdJaHFibTFk?=
 =?utf-8?B?TkVYZklOSFlIS2FDQVl3bFRVTW1vbG5NdXVZZjk0YVN5RThBMEM2OEJpbUhX?=
 =?utf-8?Q?DEfBTyGnB5RsWJS7vV+bDUGTZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9a7010-7c26-48e7-fea6-08dd6417481b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 23:15:31.5159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: brL9+UY7OYp54OQJcUK7KlcEQs/PvevvKqhd+UwoEkP734S9xdSoheBpDl1TKklYxcQEPrXwOmVsm7Sd3aWfeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740



On 3/15/2025 3:22 AM, Peter Zijlstra wrote:
> On Fri, Mar 14, 2025 at 10:21:50PM -0400, Joel Fernandes wrote:
>> sched_ext currently suffers starvation due to RT. The same workload when
>> converted to EXT can get zero runtime if RT is 100% running, causing EXT
>> processes to stall. Fix it by adding a DL server for EXT.
> 
> This needs a lot more words on why you need a second server. Because I
> don't think you do.

Sure, I will add more words to the change log to explain rationale. When you say
"I don't think you do", do you mean that both FAIR and EXT could be served by
the same server? If so, that will not handle the case where the system has both
FAIR and EXT tasks in the mix (EXT has a partial mode where certain tasks can be
made EXT with certain others left as FAIR) and FAIR runs 100% and starves EXT.
We still need bandwidth allocated to EXT in such a situation. So we do need an
EXT server. Or did you mean something else?

thanks,

 - Joel


