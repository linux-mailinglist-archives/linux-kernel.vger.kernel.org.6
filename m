Return-Path: <linux-kernel+bounces-565108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE307A66105
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7162C3B8B24
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 21:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542062036E5;
	Mon, 17 Mar 2025 21:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gsSX4xuR"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DC717BBF
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 21:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742248404; cv=fail; b=TVBjM1Wc0Ooh8aFpTt31r5sdTkPqnb0T58i83QDpKSttX8D0VRXcEDKfdJJED8XVgdHEyRds+Db93zAay/VOABeWvM4W2ESTcZZ6Y5Q8Vo14XiLvbAlPC7LtXnUPxbPnv9Q6MHTky9Gf2kcE1s1FIibeehZDizJGLHIHF2lJ8JA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742248404; c=relaxed/simple;
	bh=h13G0pUf4S4hKcSka6RkQUjGq0hSwNdzzcXi6BSHq1A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dKM2bB+y+MiitTG/APMtq6OO7dD5Xvq+Q9VJ5/jA0ZMageIJLvuhE7OuNRGwKEKYH1/CbWKTSZR6i3LP50F2pr+BKiMk0k04E4dSMfNZubdxN23esJRz14L+Rgly0S7pyGJHoBVLtVqKwvdXsqJoQWsIYLGp5lngmuZZaRs3Bk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gsSX4xuR; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lV7pBmQ8ROLwF54KaRAn+ZtuLEjNPDcxPYh7QnIMH5m8lX6x5yrS+0Wl726LDZqcSqEb4exqOPnt231KtTEGI/DcRz8c9ZMO+5j2gxFAM8Lf9klP6IeqvXBpkjL9sU1mbixH6CgpqLAADuuoTYKnGX0X8qdXvh8hKSGIm9yDf26kp7jEM8E/PMsOc80wi9nmZ2sICYtQ7RXNp3ppZ6T8ztrnjFXlzavD3W4ecsQc7qVc6N3/dJIHn+Wdtdqq/Hw/ENnLQIpIqWHvFQgAJPiAaLXBkLuBFdq79T1hnPIlpumvIsSKO5vLDyl4l9EJ9ukil6G8JZs8SK5DTaWSFHo3Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tck9xmxoFpYFRC2f6kmLcfHLbAMgQMcu1FKDH5UJ9TM=;
 b=HhLuZt4C/shEsPsH6wkYjNda4H/xzxztdSRw/+Bv8dU4zgDFr92Y/rNbe2w01RaisOtHDwWG9zw5IoNpGYhrnP1j65tIO6inv2LwCXFEBQ67lW7mCz2ckUlu9SyEyDzjFNn0J1YJzVOXk61iHTk9oxVpWKcN+1BiNvhddNZGJRKBKjIYfg42WM4hmoa7BzRINLbRAiQRxisyzeTEqbGUvOhrndBxtu4OpbHDhUXdcn02MiMmnxvgaJ0pOMk2+hT6sLzOSAT0h89V7xtPA21y6ty2qg1FJFquF8Sw+0JA+496qUBY9QmxVrHamzaCX9if+ka8JwZ+AXp/7WZPaX/rQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tck9xmxoFpYFRC2f6kmLcfHLbAMgQMcu1FKDH5UJ9TM=;
 b=gsSX4xuRFJQq05BQU2P9hqZxJsM9N9P8wOUlquV60d0QmDM8FWYoqhkhYbxOoAfXO+/ui8s02EJQbiZV4BUAJa191Y/GJXVDkxSq0mPPJ2n/Tt1m/PfZSeNvyuWOseNpKPj5agX8goQa/WQtcmLfKNTS5oL0nYqD0iSaYn/ro6O9fQ+LUagGn7ok3NY1SKcW2OVx3Mf3WTNmQW/ii9+ouQao/Gd2efYwUfIA40yeUAfYdS4Xmum7zXRvTdeanVVJltb0Mswp8FyXUd6PNF3LvzwLyEhnTbdMYW3P9NW8hxE0AiyHTMQp68HnWYOvLhF8/3eHe++IQPJzrg21P/6/hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB9068.namprd12.prod.outlook.com (2603:10b6:510:1f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 21:53:19 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 21:53:19 +0000
Message-ID: <0c0480f3-6793-4d3e-bdbe-c503d50a0c02@nvidia.com>
Date: Mon, 17 Mar 2025 22:53:10 +0100
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
 <3b244939-6d55-4d86-8b77-a9a7629f8239@nvidia.com>
 <20250317103101.GC34541@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20250317103101.GC34541@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0755.namprd03.prod.outlook.com
 (2603:10b6:408:13a::10) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB9068:EE_
X-MS-Office365-Filtering-Correlation-Id: d5d65db8-e61d-4688-d44e-08dd659e20e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnkxVUxXSEpYU0JNQ2NJTW5BZnF6aTRmZkhveUxLSEFMOEpxZk04Uyt3c3pZ?=
 =?utf-8?B?bmcyall0V1p4aHBkYnQ2Ri9DdTNBYWw3bHNUem5GR3g2ay80cXR3MEp4dERG?=
 =?utf-8?B?QzB1VXBPcnVBT1RtRkZoWmlhSXN3Q3hNWXhoOGhFMnBmdFRlY0JEbnZzOEl5?=
 =?utf-8?B?NWFTUWMzTXplc3RwYTd2NFdUWWtjTC9DUHcxUWpLT3NUa1AwWjY1MFlZU0hv?=
 =?utf-8?B?MnV2VGFYcFF5QUdjTVFSaFgyWXB2THJEN1ZGM01ISGw3QTZFdVJpYzFUQzBv?=
 =?utf-8?B?emNNb0xhTzk5ZEFiZnplOXRIOFhqaVdCY0tReDdxUWxndzk1cG9KSTdCdnRY?=
 =?utf-8?B?ZnNUNzdieEYvYlRjZUVRbW9OY3RkZUw3QkxWQ29CdGJrNnhqMmUzT21EOFNF?=
 =?utf-8?B?OTZseHNFQWRrUVE0Mm5xNFBQV0FRZ1dKeFUxcFRnczlvWDRyWG9FVmdiRUNS?=
 =?utf-8?B?amdXNFhqMXVSRGpoS1NRb2h1UTl3azA4NnQ2MFBPUFZNcENkYWtoRnRseHY5?=
 =?utf-8?B?T2pnMWxJSWJZaGltNUxYSE91aG5COUxuQnVkY3BrNlJ1WnhnRldMYUVpTUpM?=
 =?utf-8?B?MmtKeThKdHZjOUVqS2ZYSFdhVFFwRUc0VzNhaWc2SGFSUlZtWGpVRXV5Mjd1?=
 =?utf-8?B?bDJzR2lRZnRjaElndlFFZ3JzM3JpaWVmbHJZNjhPOXpaQVp5SkV1ODdLdFB3?=
 =?utf-8?B?Z3I2OG5CNVBkcjRmT0RFem92Ymozam1PRCtWb0gvZXlMYUIzbmxCcGUyS3VH?=
 =?utf-8?B?Y3ZCSThhc1V0YmZvSmxvZjRpdmJYejNlTnJPNWMyeE9UM0JOanJGTlVvRGlF?=
 =?utf-8?B?Yk5DVS8xVXdFay9MR0dpMkhaSTM3RHg1OEN1YzZoaW9KSGxMUVZhaW1TWGVN?=
 =?utf-8?B?b1c1V3pYZXRwWDdJZ0RBNUNCa0d3TE40T01zS0VmZForLzdITnBQM0g0cVll?=
 =?utf-8?B?MllYY1pUNGtKOWdqbzVsemdkUnVERGZrbmZmVGI5VVFGMzV2dzNodUFtNnE5?=
 =?utf-8?B?MDBSNStSV0srMEZoWGJJY3R6d3U2eHF3OUx3VzR2d3oxVVQybXlIWUJhVUNC?=
 =?utf-8?B?NERQdFpYd2RWYjdxVFdVUk9ibU9QdmJnWGhlRkhkNG1rTHlaMHJDWnhUUEFR?=
 =?utf-8?B?QU4xV1B3TEU3OUR4RFpoZEc0QWxQcGdZR2x1V1hPV1UraDVUTEYxOGZGdzNr?=
 =?utf-8?B?UDdhNTZwT01QeTJMSVRwdmMydU1pcUF5a2VxUnBJWVhGQVU4M3B1Wmtnb0dL?=
 =?utf-8?B?d0xvZjI1NW1kR3EybEEwajRRbkdrZ0ZRVzExS2xLK0hRV1ZUSGk3bkFFc0tL?=
 =?utf-8?B?Tjk5VWU2TzFqS1NiV2txTW5Ib1dEVENxT2JyUGh2amlYVGhpUlhCWlhjUG9T?=
 =?utf-8?B?WW1VcTd1TlhaVE9LVzdabDVYOWhtQk5PVWVwQ1ZScVFiZmhpR1NBd05mUTA3?=
 =?utf-8?B?V28yZ2crM2tpZnBWeTQ3TXFVRUVPWWtFTFNRcklqY1JOcWRHNXdxZWJXbWZv?=
 =?utf-8?B?WnlRamgreTM0ZTQ4a1BxNm01WmFjUlFCczB3bHlpcWJGUjBNTTJQeUwvU0Vq?=
 =?utf-8?B?YXErSFo1dDRUUXp4VHBpQXQ3THZnQnBNVW8xcXEyRzdZQUdPeWNJbmRTejNn?=
 =?utf-8?B?ZG9SenFSU2FuRHRIZFRoUm5iUTZuMzZVOFZXK2JxbDljQ2I4SnVzL3NHS3k0?=
 =?utf-8?B?elRWRGRsREo0aWNGL1o0c1RGalppY1FKaVgzYjZpdDFNS2tLMFl3UEhWc2dY?=
 =?utf-8?B?WXhKZzdVY2NFZ2hyUHp0cnNjeDFYSG1raHFWeU12MDlGU2NrQlA2dGlyZE5N?=
 =?utf-8?B?U01qYnB5VWxkbXNxV2hMa0lKVnZNRml0clFlb0ZodGhCUzQzbGVJL3VoVW0x?=
 =?utf-8?Q?Y6Yafk6gDys+C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkQvbzN4RUloQlp4M05JV3VCbkZsWU5JRS9SWW83a0NrRXliK1A0REVIK0hX?=
 =?utf-8?B?ZEFZUDFuVm9La0ZpczlRNXZJZ21xbG9xNUE3U1djNktCT05Fc0pPTS9xeE93?=
 =?utf-8?B?RzlzeU0zalFlSlovdGFXTUJSbUU1VElaeThtUTNWS2xnNlRQRnNPRDdhTGhh?=
 =?utf-8?B?Rk5LdmpaOXkyTTVKTEJWdXBwcjFpUnU3OVZTeXRjdGZ4UE9YZEN5UFpWVUFO?=
 =?utf-8?B?S2RSaVhKSG11WXhHN2RCL0ZUWkdhalZDZVhWa3U3aElZSFFPQm4xbGZpSS9p?=
 =?utf-8?B?WWN2VXpQdkRlM2pHM3BnbWRTZFc1S1luOW81djVaT3gyV2hRZElFRjR3YXBO?=
 =?utf-8?B?eG50b1c4cXhzWmd2NDZ4RGFBUEo1cGtHUVQ5RlN4cTRRdk9LNUxFZjdnRWhE?=
 =?utf-8?B?Znh2ZTJRY2hNQVI1VzNqaVFOM3loVktvOFFPUnZrZkpmZjZURVVYd3dqVklK?=
 =?utf-8?B?OXp4bUQ2cmg0Qy96Q1RJSmI0VzltSTBXanI3Y2x3emdNU21PZDZqZHJOYmVF?=
 =?utf-8?B?a3RqUkNkZWlTeXE3MnkyS2NuZlVoNVJ4S3hGWkNURkdxVk5Rb2tqMllBek9j?=
 =?utf-8?B?SUt6MlFHVkR2TjVxTUc4YUkvbTBTL2wyRmg4NXlTNEV5RUFkL3lvSkRrdTMy?=
 =?utf-8?B?SHgxM3UwRHFXN1U4YmFhM1c1VzdTR0FaWE9XMVRscThkdlI4bUkwdU1lcGNp?=
 =?utf-8?B?ME4yeEwxS2RudXBJQkN2SFZ3TjlxOXNZcEEwV0dtME1HMzVURGdtQXVHY3M1?=
 =?utf-8?B?cTAzNXk4R2VmS2dCbWdEU2JqMEdyc3ViNktIQ3k0bktJSnVCWXF5K1d2MGxS?=
 =?utf-8?B?MzZYWXQ3R0g5RlE5NEFOejBFMGFGVVZaTnpzVmsyQzJqeDZxN1JwMVBZbGFh?=
 =?utf-8?B?cmRBRU1yY0pzUm5DMjdQMDgraCsxRDdKVWtveGl2akNsOE1nYXlYRitKcExw?=
 =?utf-8?B?NC9oZWkyMCszdUI0NUFnT0RpK0c3VDArWjV5ODhxS1MxczNqMVByVm9zNC9V?=
 =?utf-8?B?d1h1RVN6a2NQaHpzWTlaRkFjNHo0eDgya0VnQ1pQYU9VVC9DU0ZWY3N6VkZR?=
 =?utf-8?B?bzhPazJKVDZ5SEd6elppU2NEdG5IKzVnYm1MVHdhMzcxSWdaZXh1Tmw4VHdV?=
 =?utf-8?B?K1FKMFpzMHpBaGU2cDNTaDVENWNxYjBWL1lXUDhhbjZuMGQwam5IdWViMnRs?=
 =?utf-8?B?eGhRSlE0QUlLWkNlYW1XUGk2dFp6aFRKZ1h5ZkZmUjRIcWhtMFloWkExbzVr?=
 =?utf-8?B?YjlhSjd2Z2VEZW9NbCtTc2R4VVNRZEFibFJHc2dkZjl0MEVyaW9Jb3BSL2U2?=
 =?utf-8?B?NTlIVGNiRVhMNVhXYmIvK3hqWGV0VXF1YlM0aUhGaDgydmtJQmc1QWljUjU1?=
 =?utf-8?B?UnpLU1VQZWgyTG4ySS9GYWFRRmQ1bnczVyt3czVoZHRNSHJOOG5IMExoTnda?=
 =?utf-8?B?ZWNqOUlKYVJ5eWdNSEV0eThhd0ExOFUxbU8wRDVMUU9Kbng3TFp1blRhd1JX?=
 =?utf-8?B?a1kxYjIweUFyZ1RRRHEwSVZKUUN5OG5RZEUvUGIxazVyQ3BZb0dOR04xSTVX?=
 =?utf-8?B?U0U2dUxUKzFEQjV4aFphTiswVDJ2elFpRmdNSVdQMDhWdnRXSk9na3JJaFlp?=
 =?utf-8?B?SlljSWpXcExOTkRXL2ozWHpmcW1PSlc5Z0FwQ3NDSkZaY1lsYXVNeWMxYVlN?=
 =?utf-8?B?bWZhUGllSlBSdUJ0T0VwMkxkSWJhWC9IczdnSEJrK0g5YVp4Z1htMU9RalM1?=
 =?utf-8?B?aDlpM2NBSnZuN0IrOUV6Rnpwc3NIektJbHRpZ1lQa2VHcVFFYXNVbWY1OW0w?=
 =?utf-8?B?T2N6bjE0WllWSHk3NUE4UmhaMmwwZHhyQ29vSEV3RUo1cmlvWUdPc09BWHRQ?=
 =?utf-8?B?RGx1MWs2RzFrQkk3VCtOTGZSeWh3L2plQWYydVJxMXpYLzdKU3gyalZQVytj?=
 =?utf-8?B?cVpaK3hNbDAydEEyeUpNUGxjWjZheDhNZlBlUTJqM2R5M01EWGdOL2VpSk5s?=
 =?utf-8?B?d0NqUDdBU3JkMW16eEhBTjRybHBXVlFHSTYvRVF2VndDV1pjOXFpRW8rNHYv?=
 =?utf-8?B?aGtvWU9CUUlxbG14TGN4T2tMc082TzZuaTNmQnNPZVhYaEpPL2VkTTkyRFRa?=
 =?utf-8?Q?saHrZXF3r91HxH9MR+v6Y/sxM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d65db8-e61d-4688-d44e-08dd659e20e1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 21:53:18.9063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RCBknHITEcTYCLkwXRYgzEFG5yl+Eh2fPYRKLDmUUF6kVDtWSIu/yM8FXJiJRXUIFmYXqz0C6BysLD/3Fm6yng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9068

Hello, Peter,

I replied to other parts of your email in another thread so I am just replying
to this part:

On 3/17/2025 11:31 AM, Peter Zijlstra wrote:
> 
> Also; I gotta ask, why is nvidia looking at ext ?

There are some complex CPU topologies which perform poorly with the existing
FAIR scheduler as reported by people (I have not seen the data though so there's
that).

There are also workloads where it is beneficial to schedule on cores which have
the data in their cache and are submitting work to GPGPU, which makes the GPGPU
operations faster.

thanks,

 - Joel



