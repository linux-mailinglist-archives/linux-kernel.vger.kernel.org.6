Return-Path: <linux-kernel+bounces-565105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B32A660ED
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36665179C31
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 21:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA0A18EFD1;
	Mon, 17 Mar 2025 21:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MlfDz3WO"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEDE54670
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 21:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742248106; cv=fail; b=jcAKGX9637QlxBKBWLK6o4zUN9ypcHSbUzKfcAZWl+Np87zVHxvtqHLihaNkpFHYyKf2v6di7HaxfuzvrhfedqQuzhPNjLdnFpe1i/fLTWiIOzbudAWzNwjdeNaXHBwlKAp2skKl2lCgZ+MDRSbX2zBCERL0xCr+ytx9gArNzZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742248106; c=relaxed/simple;
	bh=G7bikNgOt6ruNb4o4oUQ56AnjM7+CuDZG+2h1DQ0aS8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dggOUTtj6qmAF2OfarqkqurStXyOk/4MVDeEtSM96nhvmbZMceiqH7mQh+IRsbbFkTbJT34KZldp7Wis2XLFCFhm9DkJR6+XRnvXBLNuJZ8WvzxP29F9VbbMgHGnz1gWqP8R+vBA7xsAEMIyvVS1rz/xfvycQ3vVoMml41g9YW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MlfDz3WO; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0YIhcNzfPICObHWUqNH4WUZqJmJkyRlVvJlbbgLC630O0ayFYtl8ngBLOl2GnyNYnIqyigw6/9ayZPDRyqhdmbgIE6jn2LZfsWvmssE1/cZnl8OrAMBO0eP4s+rt5SMJWpTni8bWJukVeUd5B6+OZPUmhNn/Dzet9cPLKnMZeH0NpXcdbNNc9Sh5euH1mx/Wwjceyl+EHXmZmIYikqm8NXq9IERellJZsUtagxCBE1ty5LHCe5IJcjCh8nKk+UTSBuUWaAbqErntdqCAvEZyKsgDI3jhHSbQyHnKvYcfz93dD6mUj5lvIk4IW1stf51Qo1doaCK7+RXnJsqrZknPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHaSwk0COKk6IBlX+FUU7brXshhB2R93Z29RNOFindg=;
 b=dwOupHYnnpyAlWfWLxH2MAMwoYnsbonH6ggALzm+GwIkqh03KCdsfnvmckLDZCiQMurl+19bIAlgEyney3xLuQxgpPr+i4xqcxVccw1hgjLQkNWQDNiG13Ur42dl6qI9KgFtdZl9WsI7zUxvMivsyfgEmcp5Iuuma7PZKm2Jw4JnNe1p3rGcl3JCORe2lsBo1Zu/VzLpuaNeOW2lASW7EcXvD/ZiDIzYK73rsx9UdJbeQNdVWWYhsoNWpMhPBhh8ypYokmSK76WcaaBQMIUPMcjd3WpC8zCno2wsVFiZhw/eogC4yrn3j9JHaISozS0H5ue7ZNXwc0oAiGsFCJHjug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHaSwk0COKk6IBlX+FUU7brXshhB2R93Z29RNOFindg=;
 b=MlfDz3WOHRTZM0/GM12cJgYLfh7c1WgKMzGFxLZVKXpObwupYe5r9ELPtVnXai+mUyJKrdWmY/HVXAYwtEJ2cXekNMeImuCQdmu40I0vsFbMVuseBfmWpMbbji/fmECMEzMGfckPmo3WRBZQU2E214XYui37+tBJTGirHQS6GGwQHK6FwjsKt7rJYdW2jptnltUdVEHU5ViRizT5c6faVB7ESTSVfpTSbrscn5S7smStKLlN8o2zyOpOo2axfbiuJVjqoUHo9kTkXIyGqlCjsIiAYdcPGC0yGc1JinjurJfUI+Ge4LZrUkgF+TUGw8ZbcBisakvrdQ1tat4arkSCcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW3PR12MB4426.namprd12.prod.outlook.com (2603:10b6:303:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 21:48:22 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 21:48:22 +0000
Message-ID: <8d9e6300-113e-4a89-8fc3-2ae895c77794@nvidia.com>
Date: Mon, 17 Mar 2025 22:48:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/8] sched/ext: Add a DL server for sched_ext tasks
To: Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrea Righi <arighi@nvidia.com>,
 Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
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
 <Z9hUby9e1JYaE6iC@slm.duckdns.org>
 <20250317170602.GE6888@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20250317170602.GE6888@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:408:fb::7) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW3PR12MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: 97e64feb-aa33-4b22-3982-08dd659d6ff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEZlbGx6NFBzZEpSZzRLYkRIV1pTSHliSmdmRlZhVllMc2hpV3dJc3c3cGtV?=
 =?utf-8?B?UGsvUElvOTkwZmxVT1RiUUFzOE96TVFsLzEyMnlnMi91aXQyUnZDdkUvY3I2?=
 =?utf-8?B?YXUyRUcxakNLeFNnNXRiNGVnSGg5TzFnZFdHaTNWbkJkUlJxaGo1WHV4UXBz?=
 =?utf-8?B?V0FxUm5wb2huZTBMei9DcVBuMms2SXhqa1J2MWhidUtPUFBwS21VN20ramk2?=
 =?utf-8?B?SVJ0YnFNVHAxdjFVYWQ1RnFETlQwMktvSkJPTWxjRnQzY2RBdGNpNmhGN1ky?=
 =?utf-8?B?VmdWbFppdlBOWFlMME5YdDJkYlBtd1B1VUZTeFdxcndwVjU1clpGdEhwd2Rj?=
 =?utf-8?B?N29nL2JvalpMM1doM3Q5S284T29KM3l0c01NS05YYjRZUkJkcWVHRk8rTGc1?=
 =?utf-8?B?OEQwS3VNM3VON1RPemIyRXdCdmZ2RmhXUDVsWEJMTW03WU5kb0Y2WjlLcWVk?=
 =?utf-8?B?VjF5eVNpZ3kydTBCOVNNdS9KRXFyUDNLSU90NWNIN1RxaUFETVVFelNMYy90?=
 =?utf-8?B?cmdzQjJtS0h2SFJBSVpxVkZDYk93MHpsZlBSY2RmSitJVi9hL0txaHhQNHIz?=
 =?utf-8?B?QXdFaDV2dWMvemFrNFY0ZXc5cGJ0OC9FOHRCejk2bi9Zcm1pQjYxMElmdHpk?=
 =?utf-8?B?a3ZWMnNVTlR4b0J6TmNhcFhoM3FYOG56YmtDZlc1eHQ1dHkyVW8zUjJ3cGZJ?=
 =?utf-8?B?NlNYY3g5MDhpWjNnVnBaWnFrVy9CblFIZGswRURFdnU1bG5Nc3FNNjlQdUEv?=
 =?utf-8?B?SkRPWEhjY21pNVpDNm03Z2U4Q3dMdW0xN3pCZjFlbFlCd0twekU4OHFkbm1X?=
 =?utf-8?B?UlZVOWxWY1lLSm04YW1SK3dPNURGNlUyTCtTRmtmVGEzS1RxK0tsaHpLZk9N?=
 =?utf-8?B?cG1TR0dwYmRaNEFtbThOSFRITHkxaHhEb1hLbWhjc3BxYXhoYm5idUIrRHNC?=
 =?utf-8?B?MkQvSjE3T255LzBUK3pqVW1hNzFhTExZV28zRHN4SlJQajJsNmtFYytjR3Ax?=
 =?utf-8?B?ZzA4U1YrVVl0WHE4VkRvTVlUc245eGZxWkVhYUxaWmRPU3RQU2tIT3N4YmFT?=
 =?utf-8?B?OXVXZEp5WWl2MTdtMnN5QmFTUGVhUDk4SU95U0E5aVY5TEhDQWVVbTVEOXY4?=
 =?utf-8?B?SlF2VURTYlV5akMyTmtGaXM5WnBDQWRQYmpNSC9uSzh3dWR2R21sQnF0V1hY?=
 =?utf-8?B?QVlUMVliWXNHUnAxRnhNckdrRjFIYVJvZFB3cWlyZ3Zqc05RYnM1Q2pwb0la?=
 =?utf-8?B?TjdzRE1BdDBVbklYak55L2p4clAxd1pZdGRIWDk1RW90emM2dmw1b0tkQXFa?=
 =?utf-8?B?UElLblBGU0xmaTc3NGxtNlh2cHEwYmt3TUV4QlF1ME91TWMwZm93VWRhVEZT?=
 =?utf-8?B?czFBTWYrY1FTOEZYY0FOdTBHZXpqYjR5QUE4bHlmZDl5dDRKREtDVlRhR2VN?=
 =?utf-8?B?TndPWE0wZWUyTUo5Q29yd3JLdkRGMHl4eEdSK1NyZG90UlhtaE5ndmlRRmJV?=
 =?utf-8?B?akIrRThPMlM2OVRnekwvaytTdlBFK3JnalVpQ3ZCVS84aVdCeExwY0tlN0Y2?=
 =?utf-8?B?bkVmRU9FMHJLNE15NmMrRE9zcXNQZUNmVmNZKzVlR0wzZUJIY3VkZEVucDlp?=
 =?utf-8?B?Z1FERGt2SEtCbWJ4MmlackVQd1lOckhleXlxMWhranRGMjFCaUlsSnBQVjh0?=
 =?utf-8?B?N25odUxyUDJRS205ZU1jY1ZGKzEvVW5QRGp2VzZzWXV6YmVXUm02QWEvNXQy?=
 =?utf-8?B?ektPN29RN3lBWjZSbUEwMmtEK0pSM0FhbjlHc3BXcTR1THN5Nlk1bjd0YlFi?=
 =?utf-8?B?ZTd3cEJRQ1dMcHd1dmozRzhVa3dCREVVbnErOEE4K1FkaEFqSUVaekROb1Iw?=
 =?utf-8?Q?/VD9jLwsedMH0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ck5jWnAxck9ON0ZTMVY4SVhsRWQ1RUp0L05OVWNxcjJMNTlhTndzenMyN0I2?=
 =?utf-8?B?VTQvSStDMm9YY3J2akNINk5qYzk2VWRCRFVhM0pVUW9rbWZ0VVJkbG5SQ1kr?=
 =?utf-8?B?ODhjalhVcEgyTVMveDZ5MVdxY1dUOTJUMlFQOEREalQ5WFdrdVpaNVlnY2xK?=
 =?utf-8?B?ZktMcG0vQjhQaW5jb1dTS21xcmVZVmtpcWFwbXVRZGQ1TTZFYUxsOStDMVpI?=
 =?utf-8?B?YnoxanUzbHNzZjdWa3lHVHVOaUVmOVdBTGQyLzdwbDhIck4rcFFieG0xTGor?=
 =?utf-8?B?czEvNHJkSU4ra0wxTDdQT2FHbE5rUEpUTEcxVVZDMWZjMjlKRGZaZHUrUGV3?=
 =?utf-8?B?aEprU1ZHNFlEdjdtQ2t3aUh5Tk9UeFB0VkU2dkt5YzRaYzRWOXd1TWhGQkVB?=
 =?utf-8?B?eXVFRTRCa3NVN0VLalBCckVOMlhYNzE0ajNCRk44V1hYbVlWeTI3eThTWmRZ?=
 =?utf-8?B?R1lGRXd5MFpIakRjVWsxZjdndmlCK1RpRXZmTkIzMUlYQ3lTZmlpZmRpVXpr?=
 =?utf-8?B?QzdYU2J6UlhnbWxSL0M0MUdLMnFjeCtEZHFrUFZXUHJDa24yTXlEMVlYbndm?=
 =?utf-8?B?Mk1RS1dlNzVEYm13VWZRYXRIR1IySW1KZFBmdUZlRm1Fck1nRDVkYld5b1k4?=
 =?utf-8?B?c1NhTktlblpFTTFLaHBjbGpuajRSTkFEM09FOWtMOENNcEdFdmpNK0htWWpa?=
 =?utf-8?B?UEMyVmpPbTh0NWloeEY3Z1I4cnkyaGhCUmlqZ0Q4WERSUUMxY3JuVHh1Y2JZ?=
 =?utf-8?B?cDhFLzhSQ3luRnRINGlhWGNUWlRUdkdQTWd6eUZhcUFuQU1lYVlEYllyaGs4?=
 =?utf-8?B?RVB0UzdVUUtRMllaTnFtYmZYcDVUV0psdERmd2lQaVNuaW51SmNpN3JybHo2?=
 =?utf-8?B?eU5walZZbFNVY1hPcVh6NVEwK3Jtb3RUZVlHZzZzVjFEeWJ0Qy9TLzhmNVRD?=
 =?utf-8?B?Q3VvZmYyVEp1RzVwQyt3a1hUanRLa1FIT3k4WVIvbE9mYnU5aXVmQTZ5NFVB?=
 =?utf-8?B?VENFRlM3MS8wMUdoRXRSVFlGSVlQZkNmamY1ek8raHBXeWZpdVdzckZuYU45?=
 =?utf-8?B?ZHpxRUdQRDZUTW5xU1BUdnZCbzZpU29BTnJvbldTWnQ0Q0RFM0Q5Y2RkdDVE?=
 =?utf-8?B?L2xzQ0xmQWg5cGxKM09NRXBULzV0QURQTEthSGY2aUtNV1lGTUhGVkppb05O?=
 =?utf-8?B?SndoSVNqQkZyODhHYzlmTGtTdkZ3eDliczdyQnMzMlV1dmFvNlZHL1BFVTRx?=
 =?utf-8?B?RldPZElKK3FDY2NFZWE0cWIvbE80aVlMcTVLZVQrbERFbmY1L3ZJNmo5MHZR?=
 =?utf-8?B?d0NjcC9LemtVMFhVUE0rN1lTcEJkclVRR2VxRnpBTDdmOWg1eEE3YzNXM3VF?=
 =?utf-8?B?SjZ4VDZKektOOTRJQWZHUHZ3eXVXODRjTHhBa0pHV3JKa0JNMHoxZmMzK2pK?=
 =?utf-8?B?Mjk0VW9meDY3RU5LL0RsOVFCelN6MmwvZDZ6cnMwSkRHYkdrSEtaMzg2Wm9k?=
 =?utf-8?B?OVRacDFvSHczdVMvQzJ4OVpGOWNQK2J4TzdheFJXYnNOc2hJWjJCbkhGeDBl?=
 =?utf-8?B?Q2VpaTdKckJXUW1KeEYrWHRZK2pBU3NCMjEyd2J2ZGd1WUIvV2RiSWhhSHBN?=
 =?utf-8?B?NUFDaHF0VXJwQ3BkZUlWNDVNOEczdFViQXhYc1gyNFhFUTNOcnp6K0lMMXZl?=
 =?utf-8?B?aU9odnF3Z28vdnA5ZDN2ODRXby9Jc0xlS3pocU5Db01jNlRqKzNmelhCSysy?=
 =?utf-8?B?VnZaRTAwdXJEaEVGS1hkSnJpbEtwUU15U1VDaFVxdGFNNnJ5WHRBbnZSU2VK?=
 =?utf-8?B?THZ6cVVHcHhCOUVxV3FOTG5KeHVndkNDOHh6MTM0a09KaytpektzTzhKc2J5?=
 =?utf-8?B?WVhuajBaOEs3dUFPUzBjK1JmYjdLa2lpekp5Z2NzaWFQZ0VqUTJVR3ZVWXoz?=
 =?utf-8?B?eVl5bGFUL1JkazNXR3BHSk5TaWlrRGJCZ21LZlltNEF4bGFiNjRNOHpvMkcx?=
 =?utf-8?B?K0hMMnhOOS9BN29FM1hsOTZENFd3dkdGM2wwL0NSSjY1cWRERmp0QjVkRXI4?=
 =?utf-8?B?Y01idVc1QzQzb3RyMklTdWpSbmM4eEZrc0UvNkFDLzhsTTFHWkFFVVpmMWU4?=
 =?utf-8?Q?RpLZpS4LYCvBvFxbLvMbhR60f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e64feb-aa33-4b22-3982-08dd659d6ff3
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 21:48:22.0552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wVSn3Vm2msAgpaN7FQmSmAtNANGss/ADfpDETPnFYfn+jk2crNR3qMKUjxqEBIO4NZp6xgMtAWwQvoHKMWDtjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4426

Hello, Peter, Tejun,

On 3/17/2025 6:06 PM, Peter Zijlstra wrote:
> On Mon, Mar 17, 2025 at 06:57:19AM -1000, Tejun Heo wrote:
>> Hello,
>>
>> On Mon, Mar 17, 2025 at 11:31:01AM +0100, Peter Zijlstra wrote:
>>> On Sat, Mar 15, 2025 at 07:15:27PM -0400, Joel Fernandes wrote:
>>>> If so, that will not handle the case where the system has both
>>>> FAIR and EXT tasks in the mix (EXT has a partial mode where certain tasks can be
>>>> made EXT with certain others left as FAIR) and FAIR runs 100% and starves EXT.
>>>
>>> Well, you did not mention that issue, you only babbled about RT.

You are right, I will add more details about this to the change log.

>>>
>>> I did point out that issue with ext, and TJ said this mixed mode wasn't
>>> really meant to be used or somesuch.
>>
>> It's true that most of the current use cases don't use mixed mode. That
>> said, some folks are interested in it and if we can prevent starvation from
>> fair saturating CPUs in mixed mode with a DL server, that'd be really nice.
>> Would it be possible to toggle the reservations depending on the ext's
>> operation mode?
> 
> Yeah, that should be doable.

Just to clarify, Tejun is suggesting that in mixed mode, we boost EXT
independent of FAIR. And in normal mode, we we boost both FAIR+EXT, because well
- nothing would be running as fair anyway.

But what is the point of doing that, if we have boost EXT independent of FAIR
anyway? We need that code _anyway_ due to mixed mode so it would not simplify
anything.

Or did Tejun mean something else about "toggle the reservations"?

thanks,

 - Joel









