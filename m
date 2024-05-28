Return-Path: <linux-kernel+bounces-191879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D88938D157C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32D28B22578
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAFD73163;
	Tue, 28 May 2024 07:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TNXuT+r4"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA6811713
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 07:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716882448; cv=fail; b=bkXs5Nxiz2IJyDiIZs3X6m3fuvIVYube8bqKKiwz3K2zCoH2NiGwGgX5+be3U/YCTSVsHUD0puZrYg5QZK5rGP7/broZtWPwJaMP+QfxFq08JpKZ/ZmxhJ87PBGV4zcqdHtBNQPFp4jkPFQCuFFjGFYEsIqjSZwr9SNezPcAziE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716882448; c=relaxed/simple;
	bh=aZ8ub5seDOtCA9uSWtvOBsPR9H3P7fLbWNJZ01WB/XE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UpPd/W5JHkTwLO0wPS0ZzFFO0HMy1TAn6ahqZwekrRg+okf3pFotfEQ/yahPHxOjGeoMxhKZt+/ytOU6Ug7G22EttZ8IQHNvDBJIygaBPlxjLlghHXkBcL100ICZoQtEvnMWI877itMHlM2zxgv14H17wOsJoy/0he5Y1juzVGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TNXuT+r4; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2oB+ZgeDd24mPGpiN+QlbF/nOe/NMjo/sqGJbGm6KYSoUjTJKKy/v+Xge6sHNII1PnJPaOgcAjRHgOTBzQkaY1OVOewr/MWk6ZF2CUazgEKV30dsJm/CyStKbLArbZzdAQUuRZXc2DN1fMNNLFIKKmDaQ+GTUmV3o8k3xv0fsvMoUxxo5R5I92Bf2/4lPbnfCAz9JbL3kA/chPEQ115wh3YdSDaXfVdpm5yT3cP3tcilFx37BpG58wLMN9VNVeo+CyAjsn/meDcsAN7pznpt0xwF+kVqt87LBuHWZKBsWVVisyshMIsSerqymaXoDE7HJoH2m9Dortruu42Z8B8KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeA1mtP64Ogf3Q9QK88RStc6HNzfaOLRJzyxcqq20Qo=;
 b=Cw2j4XXUYLfawX/pYLy2GK1Wf2SmGggkaYc+JEc0DgZMieWcmHHGEk1Av50LeO/9tUv5cHMTsKXlay7hq7E8aPjT9AoA9Lqw3p6yug+EF+Ng0V65VjcLXDu/KzryH2VsxC/NIDgwOTrcdk2UhwZBQzGw3hO4s7VY8RMU61a/zT46Vpogjlabjlq9fS2kdI0e0aFFlPPuzBcz2RRoyipPn6FkR6I28xpsPV99JmmG/vYICm/oUwD9BEjtnlnD7JV4Hwgj4E+pw5L3Hfg75nio/K27xuJLbC7CwqECgBY+pO3K2nP76kqBb9cxUcFcBC4JbQMONya52Env7vwSpORPQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeA1mtP64Ogf3Q9QK88RStc6HNzfaOLRJzyxcqq20Qo=;
 b=TNXuT+r4Vu2pGho+iYBTjgsrf8sjB00r5T7w/dHEh/L95Ik22+Pn7omvysg3vJVRCaO6UkvZWWKGWIvub9UUlsOLgwW3zmksTsDtFYPfyYuypH19UafihNlHEhyVwE/1jvgvWwikM+nREr02UDtTgL1J+1ZiYKQKvt9LvBaAVLM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by SJ2PR12MB9209.namprd12.prod.outlook.com (2603:10b6:a03:558::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 07:47:22 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::dc81:c7b9:7aec:68cb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::dc81:c7b9:7aec:68cb%4]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 07:47:22 +0000
Message-ID: <25386c11-6793-4437-5ead-ff5a253b5281@amd.com>
Date: Tue, 28 May 2024 13:17:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] sched/fair: Reschedule the cfs_rq when current is
 ineligible
Content-Language: en-US
To: Chunxin Zang <spring.cxz@gmail.com>
Cc: Chen Yu <yu.c.chen@intel.com>, mingo@redhat.com,
 Peter Zijlstra <peterz@infradead.org>, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, linux-kernel@vger.kernel.org, yangchen11@lixiang.com,
 zhouchunhua@lixiang.com, zangchunxin@lixiang.com,
 Balakumaran Kannan <kumaran.4353@gmail.com>, Mike Galbraith <efault@gmx.de>
References: <20240524134011.270861-1-spring.cxz@gmail.com>
 <ZlCyhDspcZQhxlNk@chenyu5-mobl2>
 <06649B84-DA1D-4360-B0C4-79C81A34BC08@gmail.com>
 <cf8fdb86-194b-34c4-f5e8-dd7ddc56d8d9@amd.com>
 <6D065A1B-7220-4575-B0D9-3442A623E5F6@gmail.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <6D065A1B-7220-4575-B0D9-3442A623E5F6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::7) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|SJ2PR12MB9209:EE_
X-MS-Office365-Filtering-Correlation-Id: a3117b52-598c-4cf2-50d8-08dc7eea689f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXoyc0JEdk83c2wwMGZkQTYwZm44NDRlQmFic002clc1M2w2cjBrSlV6Ukxs?=
 =?utf-8?B?SGM5VGE4M3hhNUdhT1h1ZzFPRjJESFRHNjdSL2sxSThIZ3B2c0dHZmMvWDR5?=
 =?utf-8?B?MTJXUndKblNuMEI5elV6R0NVNm1ESEJzcHF0eVV6bkdGTlU1MjJDMnQvM3Zs?=
 =?utf-8?B?Lzh1YzJQWndWcHlaL2ZWdGxqdVQxSHQ2K3RTN1J1MU1iU1JwUVM4SHFGbXZW?=
 =?utf-8?B?WklJWFRvTzRyZ1p6bHNjOUFkS3BiSnFubnV3YWZyUXFpME9sYU9CcmE5dS9x?=
 =?utf-8?B?Lzkyb2tQa0hRS1NEVE05YTRCb3daQUZhamZXRHovVHdYMWdrNTNBVm5YS1Rh?=
 =?utf-8?B?VVp2VHBvdjJJRElsZFlBdzN1QmRXOENkSGtkYUg1ejlKd1IyYUhKNVVCQjls?=
 =?utf-8?B?ZUl3MUV2OHUzUStBUExCVmxITGZvcnNldHRyckVzd2dHVVJha2NnOGZXMUxr?=
 =?utf-8?B?MnNEVk5wdThBUFRuOHNJUXBIRERUYXQ2UC9NVTd3aWNiUDB0ZW93dGM4bUFJ?=
 =?utf-8?B?T3A5L3FCUWNDN0RMODg2Qm5ScjdkeVBYZWY2NEdFMWxyNXI5MWl4RE5nam9t?=
 =?utf-8?B?NEU3MEw2SVdpTU1IWUMxWEd3bkNtdCttbXpERjJjVWVXT3gySXYxVUJXWWRC?=
 =?utf-8?B?TWhCUmxXb09sZ29nZ0FYQkZYL2pDaUpFcTIrQi8wOFBvRkRsSXZzei9FRGdl?=
 =?utf-8?B?b1NCRzk3OEl0TGtyUlduT0R1UWhDQzhlcCtyb25hUkJ2bWxPNHNJUXgwMlhq?=
 =?utf-8?B?NmFTeW9zclp1dGNSR0xPR251N2lpYkhsNWl4Z1laOGwvR09LZlBXNXN2TTVV?=
 =?utf-8?B?Ylk0R0JkV1pvdEVEc2NxcE1jZ2tTODI4NzdkdzY0ejRLUm9tbmZOWWd6bjZX?=
 =?utf-8?B?YTRscHhpZjRSUXcyeDd4TXF6UmI4aEVPcWZnM01ZWTQ3WTkyRTVONFYySVQw?=
 =?utf-8?B?R1NkR3NHVmhqVDlLd0xDc3paVWMrY3hrcmZkRHk4YXA2Q3l4L2J1SmVpSVZr?=
 =?utf-8?B?QnlXSHFhRUlUcEJsbG9iZmlMcllIQWw1OENHeFl0R3V5QjFZMHJ4WnFBak5O?=
 =?utf-8?B?QThJSkRVVTQxQ01UZ2FpSkRaeUxsUVJhWUZiUTBseEFrdHZWblJNOW5uQkJE?=
 =?utf-8?B?YUVvMjh5UWRSWnJjUFpESStrQUZqQWpNQnorNHVHR3p3R25GKzFlY1o4b3hY?=
 =?utf-8?B?SGhLNXZHU2krVit1YlYwK1dBWWNXdGlxQVoyUmRrWXg0Tm8zank1WTdtbmZl?=
 =?utf-8?B?Z3M0bUtmcFYvZ28ycnArZjJNcjlaNnhvM2xjaWdsY2diRzVVNDlwZC9BSDdW?=
 =?utf-8?B?eVFZU1lHbWFyQzdHMVJ0M0hpRk5qY2VuamVYMXJIcUZWVEJuVVlsR2EzVVd1?=
 =?utf-8?B?TGhCTUFQRVI5WEFCK3o2dGNFMU9vUVlCYnlWZ1pYem5xaHhxUGt5YVN4ZU5h?=
 =?utf-8?B?ZVlkWEVFR0JIOG1pc1FXbHlOYURreTAwVEg2djRRZERJVGJWTjljbWVNaGVx?=
 =?utf-8?B?aEkwWlBNcFJlM2tOQmoyZmludnBDVWZKRDZLVW1tWkIzNjJBV0FDQWFIb3d0?=
 =?utf-8?B?MHFWbXFTNkpvUDhOaEdwemo5eUJkTWdRNVdjQWExRmFnKytidnlocjcyYkN0?=
 =?utf-8?Q?Hr1NY1iwWGBBmIh2l7BFa3bONcS1qgQE0Tb5i5VWN+nk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QURabEtNZzNMMHVxVGpteTI0QnFmNnBQWU8rdWlNdk1xd24ybThYSmhxSlFT?=
 =?utf-8?B?dHlsQW4ybHpDWVBUdXBvKzc2N0d0SEUybGtzcU9kZlhNaGZId3ExVEJFN3Jv?=
 =?utf-8?B?MUpPbnl2eFRzWlp2TjFoZzFIU1kvaW81NmNmd0ZhZXYyWlVYSldQcFFQcXRY?=
 =?utf-8?B?bWpIKzhlcTZHemlaczFONUxjZ3NNeG1aNXArRFFsQTRpQUFCMENpLzlMZUc2?=
 =?utf-8?B?UWwvN2sxNi9UMm5Lb0xaeWRmc1dpdlNFTHJMTHhzcDhSNTllYyt1SnBqMlRZ?=
 =?utf-8?B?bk1nSFBCaTZzeFN5Rnp3NDVnSHc0M3pnREpYOFJ3cXd2eHhGQ0pKZ0U2TXZU?=
 =?utf-8?B?aHVvZmtIODBWMFhWN2FENVlMa2tMT2tDOWVxT0s5UkgvSUJQb3RqYnp6dkpp?=
 =?utf-8?B?b0Nic3pUN21xRkVKTDJ6YWwzaDk5YjVvNThTNllITHIvSDEvb2t4UjdtWGly?=
 =?utf-8?B?KzBOK2FxTFNzWkl0dDdjNEJYRlZuWXZsVjhtaHdGbnNLVTA4M0FCc2R5YVhw?=
 =?utf-8?B?SnVMejdRVEMwRFA2MkhXendQUCtYTm1aL2lGWTA0ak1pQVovOHUreWw2K2Ji?=
 =?utf-8?B?Y05mTHpYODMvbjRDSkpSOUNEbkhNbE4wbG1lRkxhYUFmUFZCazhxdkY0Ni92?=
 =?utf-8?B?QnVRY2FNejc2S0tIeVczOWsxUUl4VXNaeTFRZUhmK0JhMUpsUlBGVS9LSEJm?=
 =?utf-8?B?T083aEIvSHllQ092MG1UVDExQUViZzUwZ3VVdmRDZ3NuOVVnUk04Nm1uR2th?=
 =?utf-8?B?RFNjN2J2TExYdFl3MkJZdExiWlR5VWowSHd6ZUt0UThPQlovMlpXNy9VNFlD?=
 =?utf-8?B?STFNcDhjSlVEQmFPTEFSUlBJbVVReTRrVE5kOCs4dENzN3plVjFLOTE1Vis2?=
 =?utf-8?B?ZjVKT3B4Z3o2a0FFbnVCQUJBM012aFdyU3NMNEloemNhckVQRDl6M2FBT2tt?=
 =?utf-8?B?K0M0OVhDYklPSERBVm5tbEtYQVl4b2MrSHJPbVRIZ095UW9wWUlEWi9QanNQ?=
 =?utf-8?B?N2VBR2praXoralFMMTQxQkxQTTF3NlVoaXNTMzY2TXJYOElZUGk3b05uMVRZ?=
 =?utf-8?B?V0VsRFoyYmxUQ09jSzBFU2lRdHArVFpiZjdyQXFMTXk4azlENVRVbk5MSnJT?=
 =?utf-8?B?MVZUVmRvRkNOYXluS1lvZ2UrRjB5YjVsVWpLaEJjNlVmeExhQjBIWElXN3ps?=
 =?utf-8?B?Qm9DbkRkc29LYTltaWZ5WWNHbElXSXlYQzlvZmlXeE5kQjRUeEVGbHVVaUVR?=
 =?utf-8?B?dVNkbzJoM2N1OVZqY1E0NmZ1WUcwZ2c3RVdqNEJWcTAvbkFNd0ErYnR6bEl6?=
 =?utf-8?B?dExkWmZ4cEp2eEszb2hQMTVQQ0dIME51ek9lN0E1d1ZSTVZ0aWhvQ3pjNi92?=
 =?utf-8?B?YUkrYlNwNjQ2WG5VZGo2eFcwUVJ3S0czUldTSFdOUWNUZk1FTHp3dkd6bFVY?=
 =?utf-8?B?VzhUUFdiQlo4SGVzQlMzVVp4eUsyN25UbXR3dDdWcjFvZXAvQkpWTDRPTUov?=
 =?utf-8?B?RkJKMDV3MTR5eEcxK2N2UWdFVVFNODlLMkt3bm5RaU9jamFBOGh2UEJiUlUz?=
 =?utf-8?B?eFZsV0c4bEl2RnJMdGNXS3RrdE52aUlVQXJGUkE4OGN3SG1zTytTQy9aMEl6?=
 =?utf-8?B?M0pZbjVXSHRGSGZLRTJ1emVZdGxnSjlmQytRWk1pT3MxOFJyVnlwMHNtR0gy?=
 =?utf-8?B?ZmRkTU5wWGJld3dCWHI3ejFUT1NGS0wxbWlxYlhlZUpKTXFTVGVCYmw1WE93?=
 =?utf-8?B?Y0RJVjJFV1R1OVJYYnlyVXYrRUpUbytuSXYxZmxONWxPUlNsWmRlTk41dHBC?=
 =?utf-8?B?WWRIeGUybSt0M3ZwME4yWXAycEdpRVFHWUlibmdHM2tmM0x3YkJqRTFPdDR3?=
 =?utf-8?B?WktNdEN0a0ZZcWZGWFl3d0k1WExVdEtUYXJ0QmVPOXVqTXZ1VFFwZldOZ210?=
 =?utf-8?B?NVd1aDhpZWtjeHB3OGl4dHVnZmoxU3E2RkNrTkxVN0J0aG5EeURmV0lhVm9N?=
 =?utf-8?B?dkxLdlMzUWlmY2Fic2dXOXNFQXhNODFOTWxTc2o1TzlxYUpxdTFNbU9WcHJj?=
 =?utf-8?B?bHgwUjdrQlZyb2hTRE4zbnRqbldQQ3lBbkExZnhHV1ZHOE84T3NBV2kwc2Rz?=
 =?utf-8?Q?40ZCzu1wXNjrnZDxEweRz6EEO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3117b52-598c-4cf2-50d8-08dc7eea689f
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 07:47:22.3447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFi7RLwB2KHQiCKqhyrnhWFp+Wsl0BejBZXX6MgiNyTpiKM87rGG0mrxQIpPKf4uU9587dn3+t/Y/IcVPDYgVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9209

Hello Chunxin,

On 5/28/2024 12:48 PM, Chunxin Zang wrote:
> [..snip..]
>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 03be0d1330a6..a0005d240db5 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -8325,6 +8328,9 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>>> if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
>>> return;
>>>
>>> + if (!entity_eligible(cfs_rq, se))
>>> + goto preempt;
>>> +
>>
>> This check uses the root cfs_rq since "task_cfs_rq()" returns the
>> "rq->cfs" of the runqueue the task is on. In presence of cgroups or
>> CONFIG_SCHED_AUTOGROUP, there is a good chance this the task is queued
>> on a higher order cfs_rq and this entity_eligible() calculation might
>> not be valid since the vruntime calculation for the "se" is relative to
>> the "cfs_rq" where it is queued on. Please correct me if I'm wrong but
>> I believe that is what Chenyu was referring to in [1].
> 
>  
> Thank you for explaining so much to me; I am trying to understand all of this. :)
> 
>>
>>> find_matching_se(&se, &pse);
>>> WARN_ON_ONCE(!pse);
>>>
>>> -- 
>>
>> In addition to that, There is an update_curr() call below for the first
>> cfs_rq where both the entities' hierarchy is queued which is found by
>> find_matching_se(). I believe that is required too to update the
>> vruntime and deadline of the entity where preemption can happen.
>>
>> If you want to circumvent a second call to pick_eevdf(), could you
>> perhaps do:
>>
>> (Only build tested)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 9eb63573110c..653b1bee1e62 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -8407,9 +8407,13 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>> update_curr(cfs_rq);
>>
>> /*
>> -  * XXX pick_eevdf(cfs_rq) != se ?
>> +  * If the hierarchy of current task is ineligible at the common
>> +  * point on the newly woken entity, there is a good chance of
>> +  * wakeup preemption by the newly woken entity. Mark for resched
>> +  * and allow pick_eevdf() in schedule() to judge which task to
>> +  * run next.
>>  */
>> - if (pick_eevdf(cfs_rq) == pse)
>> + if (!entity_eligible(cfs_rq, se))
>> goto preempt;
>>
>> return;
>>
>> --
>>
>> There are other implications here which is specifically highlighted by
>> the "XXX pick_eevdf(cfs_rq) != se ?" comment. If the current waking
>> entity is not the entity with the earliest eligible virtual deadline,
>> the current task is still preempted if any other entity has the EEVD.
>>
>> Mike's box gave switching to above two thumbs up; I have to check what
>> my box says :)
>>
>> Following are DeathStarBench results with your original patch compared
>> to v6.9-rc5 based tip:sched/core:
>>
>> ==================================================================
>> Test          : DeathStarBench
>> Why?       : Some tasks here do no like aggressive preemption
>> Units         : Normalized throughput
>> Interpretation: Higher is better
>> Statistic     : Mean
>> ==================================================================
>> Pinning      scaling     tip            eager_preempt (pct imp)
>> 1CCD           1       1.00            0.99 (%diff: -1.13%)
>> 2CCD           2       1.00            0.97 (%diff: -3.21%)
>> 4CCD           3       1.00            0.97 (%diff: -3.41%)
>> 8CCD           6       1.00            0.97 (%diff: -3.20%)
>> --
> 
> Please forgive me as I have not used the DeathStarBench suite before. Does
> this test result indicate that my modifications have resulted in tasks that do no
> like aggressive preemption being even less likely to be preempted?

It is actually the opposite. In case of DeathStarBench, the nginx server
tasks responsible for being the entrypoint into the microservice chain
do not like to be preempted. A regression generally indicates that these
tasks have very likely been preempted as a result of which the throughput
drops. More information for DeathStarBench and the problem is highlighted
in https://lore.kernel.org/lkml/20240325060226.1540-1-kprateek.nayak@amd.com/

I'll test with more workloads later today and update the thread. Please
forgive for any delay, I'm slowly crawling through a backlog of
testing.

--
Thanks and Regards,
Prateek

> 
> thanks
> Chunxin
> 
>> I'll give the variants mentioned in the thread a try too to see if
>> some of my assumptions around heavy preemption hold good. I was also
>> able to dig up an old patch by Balakumaran Kannan which skipped
>> pick_eevdf() altogether if "pse" is ineligible which also seems like
>> a good optimization based on current check in
>> check_preempt_wakeup_fair() but it perhaps doesn't help the case of 
>> wakeup-latency sensitivity you are optimizing for; only reduces
>> rb-tree traversal if there is no chance of pick_eevdf() returning "pse" 
>> https://lore.kernel.org/lkml/20240301130100.267727-1-kumaran.4353@gmail.com/ 
>>
>> [..snip..]
>>

