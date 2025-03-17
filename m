Return-Path: <linux-kernel+bounces-565117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B401A66138
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758BA17DC16
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD331FFC70;
	Mon, 17 Mar 2025 22:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q1bcKWPp"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A6A1FAA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742249267; cv=fail; b=Bwnv1MbknxtEu1pomDsC3luBpJ1rLZsq74+K9jNLcVe3ekPY9nUrvFlOzwOluqn9bID8SOYg3C4QlWipCKwe/8FYQBc/QeE5FosvHZZSiMRcqOLSyfeqnhGsTzKeAViqNIxdQmRuPZ6/Gp/By/gCKf0B8DXGJ7HOu/t2g3B5zUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742249267; c=relaxed/simple;
	bh=jAxQq2BC3GSccKm72/Qojtq3WO+dXw3BqoQKmb8vifc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I0IjljX7YpwsBbMZHnLwdZMfFvmxXX2fVMRDdj2YNdlW1+txBPLphA5AYfED1BZ1wRZfl/psLSn9D6IKAYxu2eRu/WS67zL10X5pSQcy6xlEyeK444eV8M4GAYN35N8xXhAMXDNEiVAd+OtyNqi+hmX0U4x0gMb526nlCKJc71g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q1bcKWPp; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxndFWZMx74CLZAsEdtR/hb/6gqVHxZvME0MG/8RI11QGoDOxOBdWJSx8namKHSsJqwCYttZphNzEjtRf/xBjreuQnWf9uBv1nBh9IEQQqCfIT/UzylEP1b1qigQMhqJpM/dVpPCYGd6vEyN909YIVavRPm1fVyh6v6eSxykStuqrgMzELVM7YI6OjfqWYJYnRn1xkeBfVY40RRb8WIJ2AQM/DwZqF2N3U1l2QYIMtgvIcOG0t8zLTz88Si5e670Q3MZRQ7LiJrDfyGc6AH4BAEnNt1Ipa9kNkaq2tVfJHdP5xFSPr5v1cOV+riLwg7V4p4JoL1I7oRlfMuUo/Bocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGAA3nI5f9mB0JN28BZ5L3DB1T/0rf5WatCVX/D1yJk=;
 b=HYRDL9rkawctbDcmNQAc0lDrTbqIfODnLE2q22g7CTMIx+jv26VEg51dU6HNS4Um+DIr1hovtBWWcV6H7V84bAafqtLLGw+wLxpsIvzauL4NCmdFq3WP3ififDRznVPtFXYqi2hK3PmJoNb/YkKBx44OjETOwppuymkts5MZPIfVDoKYjd4rKUSXhaOEXIh+AKi8NF4WrQF/5ZUd/CteEeLDAtjz3Yq9Ue6kJILB8ZELa7tWmm/WTNXw1fxZaNMgC0p2qw9dpE5hGDCipGk1tY+unSJFUyj5wGzVzxL34zzEMXfs6k7Nfp+9DnZvhQ2MdzAq8ERiwQ8h2wxa25N0Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGAA3nI5f9mB0JN28BZ5L3DB1T/0rf5WatCVX/D1yJk=;
 b=q1bcKWPpHPag7N9p6EYs8Mmdkygp6aqgkTyOkDtGvr1pApfd9gn3Wj/f3JndAcoy29u2V9l2Vhr+Gjx9dbr3VHMAw0iVDWXANevy4w+kKHel3SJB/2bNEQEdfBZ1bpkEDBvu4wZadMw/YnvdpZpHTnqHqf4PPgOdAQnLZb/QQvXaO2wli9oLpvZLdf3nhxxtX8D+5nOtUfRK/XRAVl9IYKsnXHms9xfHEtue4oWGMQmOYOP4J6JWfhMcP1/Es9iW/4Tyj96kBotQHcwu/9spO8IbrQ5NYge8GviBkuwWdXH1ut8Kr9l4QyqLoYiu2P1V+i0yB52P62yZufjeHnYVrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB8427.namprd12.prod.outlook.com (2603:10b6:510:242::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 22:07:41 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 22:07:41 +0000
Message-ID: <b0dea973-bf41-4f44-850c-7bc860d5bf8a@nvidia.com>
Date: Mon, 17 Mar 2025 23:07:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] sched_ext: Choose prev_cpu if idle and cache affine
 without WF_SYNC
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
References: <20250317082803.3071809-1-joelagnelf@nvidia.com>
 <Z9hW_3cPN8u7VURV@slm.duckdns.org>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <Z9hW_3cPN8u7VURV@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0792.namprd03.prod.outlook.com
 (2603:10b6:408:13f::17) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e0ac626-7870-42c8-b31f-08dd65a0232e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEp1S3pYeWVHTEdrNjJ2U09pV2IyTFJyU1Jpck5UeVgzdEZ5Q05DcmVkUXZR?=
 =?utf-8?B?K2VTcG9xR05LOFZPN0FvdXQya1QrTUZWdTNOak1FZk9qL0Znam1GaVljOTNB?=
 =?utf-8?B?d3ZGTkpRQTBMMU1LTGVEdnlFa0c4Y3hwcXQxWFBHcWkrVmx1c3lRUi93UEp4?=
 =?utf-8?B?aFpxSVBpS1oyUjRuUGE4WXo1MjFRZUhOT2FEVkk2NzNJSGZvdUVJTUNRZWZC?=
 =?utf-8?B?S1AxQU43K2cyVUMwVzRlUHZMcCtnRFliUklqRFZ0cHVFUmVRWE5tQ3VtdWhw?=
 =?utf-8?B?OTBEbFBlUjU1cW96Y1JnY0xyeFIwaG9MNWk3eU5wbHlFc3dYOHBRYUQ4Q01I?=
 =?utf-8?B?NERHaWpGTzFtQmVBMXRPYXdaYlNMeHdzWkorVmVUMVdtYXo5a1FMUVRZSnJN?=
 =?utf-8?B?aFVNLzROcjNPV3YyczVxbjN6V3dsQ25EWkRHaElFd0lLNUpXRmxmN2Q0aGt3?=
 =?utf-8?B?ejlVZlFNMU14SVRQRGFDeWk5U2ZQTEpVN01jM0dxbFJjL0I3V2lsSHVpaG9h?=
 =?utf-8?B?cmd2R1JxTHNsWDhZMmR3cXNHWjViQk10ek5MQ0RONk5vZ2d6ZDRwOW11dEs5?=
 =?utf-8?B?Sm9XeS90Rk8wYm0wYldLMllWMmVGcVdjaVpyekZOUFB5UkxDcXp5UzFEUkpm?=
 =?utf-8?B?NkhvOEFlQ20zY3RLbGpYaGErL0ZQeWQzcDg4T1NrcC9wVnhuWlBGUVZ1TTVq?=
 =?utf-8?B?d015NU45WXZYeGhucXBWNEV1L1paSjk5VnRubUZUYTh0TlF4SStNT2VPT3Er?=
 =?utf-8?B?cmlYTUZYNmIxOEVaZmFWSVB1ZGoyK1YzbnpEenk2R2Uya1Q5elNHQ3ROTXp2?=
 =?utf-8?B?aVZUeXo2TkgvMkN3RkRnSGpDTXRwTDFFeEdOaHk0aDRXa3FXM1Q3MWUzZkJv?=
 =?utf-8?B?SmRGVWEyVWkvYWwrNlVtVStwbU9ISWs1VXVsdm9TbWlvczRXUUdvSDJpbW0y?=
 =?utf-8?B?OXo2ZktQWXAra1FkeHNJUzNXQjVPL3ZrMzNiOW11QlZUS21mZ1VCN0hCTVVm?=
 =?utf-8?B?VzUrQ3FERThEY21zWFVlQnRJTU5CcCtmeTRycnA2dFhZcUt1bDJ4Z29JbERi?=
 =?utf-8?B?bWE0amxBajNJdS9NNEgrMS9HU1VvNm9PKzJCV0E2YklZWThFZCtqb20vOC85?=
 =?utf-8?B?SkdPK1pBMFJSdGxabVUyRlV6QjdXaTBERUIyNC9lVHBFeWNUaXkydGtORGdo?=
 =?utf-8?B?ZmxkaWhpT2VDZHNVL2p5UnczWDhxdENhTkZnWHZzS1JrY3NWRDE5UjZIV3Zi?=
 =?utf-8?B?a3JDQ2NTb2NKc2F5Q3F1QTlwb0kwWlhOVEp0cXF6MFJ2TXpNK2YvU0ZlWEVs?=
 =?utf-8?B?RWhFSmxVU3JZSGVuZ0xXWWVlcVJPc2JJOUY3eUJoYWVxcXArZlJHNDRWdDll?=
 =?utf-8?B?VXdVOXU0cDFDSVYxMVV2MUIzMVVVRFRsL0NYMVBzWWlIc2RBQmx0dTFsZEVC?=
 =?utf-8?B?UjI0aXY0d0FabTNtMW9oVkhaWU1EdVVDc2NzeURVQjcwTERCQTJNNnB1M2pu?=
 =?utf-8?B?cjFwVjl5bmJBZHBIdG9tcy9XbFhQd1BqR09MWERldEM3YTIrZlVLOFVZSmRB?=
 =?utf-8?B?UUZEUGxaKzdscTlaNDhLWFlVbGpZMXRHVEp5dmw1OXFyLzJnZzY3em5RdTkr?=
 =?utf-8?B?QWo5R1dEY21XQlI5YXUxTDRESlQ2ZzFsK0JtQ2VEbGkwaHowUkxMMkpkRDJr?=
 =?utf-8?B?cW5aY2RDNjRydFFva1dJSFJDZzl3SWxJUks4UXFoU1AxeHI5amM5ZXVCMldi?=
 =?utf-8?B?ekx5cWdudkRtZVhXOHhtKzFpbXVHWHlSNWI3REFxTisrQ1YwL3FDbnJuaG0r?=
 =?utf-8?B?bU5DejdJbzV4RFlLVENydVZJSmlyWm9DVEFFa1FwblBBV1F2K2hHZHVCNlFi?=
 =?utf-8?Q?G7pA8cvgsxItO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHR1YmI2eHNVU1hLSUswMm1uODJacVpiTkdsN3Z6c0tOUmxEcWQ4WWFBTFhr?=
 =?utf-8?B?QW1CMXA3Q2U5NjNFUjRYZm9McGkvZmFRajhyZzNwK2IvenJxU2xyUWlRVlRX?=
 =?utf-8?B?WUZUNXpxTExVc3lrWHg5RDlmTTRyODdQQmYwWmt0VFpYT1BuOGQ0RnpCYWhr?=
 =?utf-8?B?WTErNlVYbGc1Y3FySTFGRkcvWjJydEk2aUFPNEJUbVRGT1VtKzFYaDl6Lzcz?=
 =?utf-8?B?c3RlcW5uRmR2RGY1TWlGWFBrVmtMdlYxUC9LclkxaUFhMWNiNk14VTZEN1hH?=
 =?utf-8?B?TndLQitweXQyOUd4dWlIalptRXF3Z3hNcDdRLzNRTlVhZU53QWdXZlYzNmpB?=
 =?utf-8?B?dXRuaE5xUmNTTEFvQkdDT2tmNWxoWnRNVWNPcUYwM01qNWNmTlVhWFA5SE1w?=
 =?utf-8?B?OTBsZStod0Rhc243Z1lMS2pGUzBBN1E1allRaE5uWFVOVWhrRDVYSlduS3gz?=
 =?utf-8?B?bG90ZnQ3eHV0R0NQbnZpME9KL3ZJU3E3ejRTZlBYektrWWE0dXRkVDdqQ2pm?=
 =?utf-8?B?cHRUOWhpRndOYkh4RXNLNVJKUUVTR0N3ZlFvWXJDeEdWVFZkYkd1NDBMU1gz?=
 =?utf-8?B?RndiWG56YTIwUDhEcGVCaUdOM3VtS0JLQitJRTAyVlYwMkpJby9GRHlzT0Vu?=
 =?utf-8?B?ZnZZZmR1RTdMazlZaldJNG9salNoeFFMUXpkRGQ4bnVmbEwweVpNOTJnajZ1?=
 =?utf-8?B?ZGttS1YvMnljb09MV0JpbVJ1U25ldnRWZVF3bDI2YUU1cjF1amw5UE1mdUp1?=
 =?utf-8?B?RDFpQ1lxbmV3Y1ByZEgzbjRndXpCWDVRYzBQa2Q5ZnQvS2F6NSswMk1IZzNQ?=
 =?utf-8?B?SlF1Qy8yTUlZRldpRXJVTTMvTHVQeXlWbjkrNk90TFU5Vy9OZHJ5VEs0VGp4?=
 =?utf-8?B?V2hYK1FEeXhOeEhQVlYwUlYzalIzZ0M4RHFVaG03TUdVaEs0Sm13SENjbzJM?=
 =?utf-8?B?ZUZwS2l2OHFWaWFzTUhWbjlsYS94eHRXRFZ3YW14L1V0TnBxd1ZySXlvSlJQ?=
 =?utf-8?B?R0UxODJ6WW1CdWh4VE8rTUsrUlh0R1RNUlJnczdTUnVqaStFb0w0Tk9JRjlh?=
 =?utf-8?B?d25YbFNHUFgxWC9rRFhnL3NUcXpNNHk3NVljYkxxaFZsMDNVVnFham1JUTIv?=
 =?utf-8?B?TzJMOWpyWGVueEs0SUs5b2ZCTi9HckFuUXZlYW14RTA3NlJFbFAyai9sVCtH?=
 =?utf-8?B?MVM2azkrdFgvTGlTVkEyUVZVVldCK3l2N0p6NTBTTnFtN2dmNXg2cm9Yekp2?=
 =?utf-8?B?bEhBemp6cFJDOUtoTTN4V1lCM2s5akhDbkR3VjNKWjlaYkpoMDZ5UjdvamJD?=
 =?utf-8?B?TWNRZ3c0c2xjc1BpcjF0Zm5SU1B1WVg0ajNzTTZ5UGJGRnUyMXNWRFJRMFR4?=
 =?utf-8?B?bWRwUXhGYSs2cEpFdi9YdE5ib3ZRem1UWVJvT1RUUDZsZTk4Q0YwRDJ3YW5a?=
 =?utf-8?B?UVdzWnpjRGc2NW9xRXNaN0Y0aGZwSFBWcUFlZXJLQW9Pa2ErZ3p6dWptckw5?=
 =?utf-8?B?WkNZZ3IwemhrdStFT1FzOEVsWUQzYUZsTWwxdGZWSy9hQXJJb0tPQmpIUCtk?=
 =?utf-8?B?UnVzNVlRemNLbEdmbFhXbTN5cXBONStma01GenlrT3k4aVQ5eEN5TXdwUUpq?=
 =?utf-8?B?NHB2a0pOZWt0bjdSZEhDRUJlQjVzUUlreHNSdnppeWtWKzRLYTY4RWVTcjdz?=
 =?utf-8?B?NklVZWMwb2ZxTDNwSy9ZMEJQenk0VndkOUcvRXBhem1jMldXWExYaHpKZnU3?=
 =?utf-8?B?M2p2Nit3VjJxUWhoK244V0N4cHVSMnhiY3c0SkQ5Tjd1UkN0RkZaWTc5alM0?=
 =?utf-8?B?VXlYN3ZpZ0g0U1JhZUtPa09QSmVxZkR5Z2tWemtZaWRyZGIyQWZoNTdtTG5M?=
 =?utf-8?B?bHRUZGU3blRocGdRR01Td3JhMVhYM05lU3VGODFTYVJNT2JTbUYvbno2Rjhz?=
 =?utf-8?B?NTFJRy9VY09rSngxSFFaSFhtaGZORDNqVGlNT1NTblRkQkErdTB5YXNpaHh4?=
 =?utf-8?B?TGlNNC9zMElzdGlnM29ING1FMDVzUTJXMERseDkvaG1JdXhqZUZjcDdQcVE2?=
 =?utf-8?B?VC9GcytBTHpPZm9iS0hISmU5SnpVU3pFeGg1Z0xWUjA3S3NHZmJqdEVrWVVX?=
 =?utf-8?Q?ybOJIaOk3x3Sj1ymgh65jdR3v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0ac626-7870-42c8-b31f-08dd65a0232e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 22:07:41.7679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOSfFevFTOXSdOfEfSEvZh5QuwKxLLw9pdpUDE/kLlmybHoxBUonjGci+/yB2MtrwzvT7rimGrIVCobmy1VilA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8427



On 3/17/2025 6:08 PM, Tejun Heo wrote:
> Hello, Joel.
> 
> On Mon, Mar 17, 2025 at 04:28:02AM -0400, Joel Fernandes wrote:
>> Consider that the previous CPU is cache affined to the waker's CPU and
>> is idle. Currently, scx's default select function only selects the
>> previous CPU in this case if WF_SYNC request is also made to wakeup on the
>> waker's CPU.
>>
>> This means, without WF_SYNC, the previous CPU being cache affined to the
>> waker and is idle is not considered. This seems extreme. WF_SYNC is not
>> normally passed to the wakeup path outside of some IPC drivers but it is
>> very possible that the task is cache hot on previous CPU and shares
>> cache with the waker CPU. Lets avoid too many migrations and select the
>> previous CPU in such cases.
> 
> Hmm.. if !WF_SYNC:
> 
> 1. If smt, if prev_cpu's core is idle, pick it. If not, try to pick an idle
>    core in widening scopes.
> 
> 2. If no idle core is foudn, pick prev_cpu if idle. If not, search for an
>    idle CPU in widening scopes.
> 
> So, it is considering prev_cpu, right?

Yes, but unlike the FAIR scheduler, it is not selecting the previous idle SMT
for a busy core, and instead looking for a fully idle core first. I saw that as
a difference between what FAIR and EXT do.


> I think it's preferring idle core a
> bit too much - it probably doesn't make sense to cross the NUMA boundary if
> there is an idle CPU in this node, at least.
> 

Yes, that is a bit extreme. I believe that is what my patch is fixing.  If
previous CPU and current CPU share cache, we prefer busy cores with free
previous idle SMT, otherwise go looking for fully idle cores. But it sounds like
from Peter's reply that is not necessarily a good thing to do in case 'fast
numa'. So I guess there is no good answer (?) or way of doing it.

I guess one of things I would like is for FAIR and EXT's selection algorithms
(default in EXT's case) are close in behavior and consistent. And maybe we can
unify their behaviors in this regard, and 'do the right thing' for majority of
workloads and machines.

> Isn't the cpus_share_cache() code block mostly about not doing
> waker-affining if prev_cpu of the wakee is close enough and idle, so
> waker-affining is likely to be worse?

It seems with FAIR, we do waker-affining first:

In select_idle_sibling(...):
	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
	    asym_fits_cpu(task_util, util_min, util_max, target))
		return target;


before checking if previous CPU shares cache:

In select_idle_sibling(...):
	/*
	 * If the previous CPU is cache affine and idle, don't be stupid:
	 */
	if (prev != target && cpus_share_cache(prev, target) &&
	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
	    asym_fits_cpu(task_util, util_min, util_max, prev)) {

		if (!static_branch_unlikely(&sched_cluster_active) ||
		    cpus_share_resources(prev, target))
			return prev;

		prev_aff = prev;
	}

So I think that block is not about "not doing waker affining" but about "doing
wakee affining".

thanks,

 - Joel




