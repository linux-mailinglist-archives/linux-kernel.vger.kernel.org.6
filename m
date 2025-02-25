Return-Path: <linux-kernel+bounces-530499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18965A4342F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 05:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDBF717AAD2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 04:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED22B24EF9D;
	Tue, 25 Feb 2025 04:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nM78GXvQ"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6677824BC09
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 04:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740458186; cv=fail; b=S8f1UUXynOajg8vz+jZucalGdjw5N7UkjWJ7bgIwmA0SXhhfrKVQIilLa2OE2Lvyw5gjKNLAKdHft3FtlVEa46pmVFwkuIpoU8JUmOBfEL8p2cY/4NgmP7qHLo/ulsWhLD2orXMj5JvU3rOJePwMcVs2CMyENO9RyqNEa9iUUzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740458186; c=relaxed/simple;
	bh=RbdZT08/+nCk6CcZ8Dmj8w4QO5bKmreMB/Lo6KsfbKw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eQSiP1egLId4x5o4NKsoranbMrEWG7J7cOG15MRT9Bv4rv/slzFq6InfbtPuw5+bsMqgMq+/e1hWtk00A7XIRZrQ0Fg5Khq7g6wgfVN+TEC001QOI3SnpxXoPvelgRBwDeQKIlDcE4WvoIzIf7VUtfcGfNKYQPd2bpS74lpzqpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nM78GXvQ; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmfoIE6MnWOPQrxCNjzhd3B5YBxzRCCFOrF6PgHBUnjayUuV0uRJPntUc0Vt65bxE+hPBvcCcNt14i+p5vs8Afi01+ofpuxr6R89IDX+tQkqboN3KDmLCz2bjLwshavKs1MyUo8maIAxq8i3ExWIw5rRxjuCzK+1MvHwMh7eEeY2Ta7p43KRmfE5mUKVDqCMFyTPH2yAkUom+quBKmMRZaYhv9LISOJiOfWDIbXn773ie1HnHeVBo0pfuSJbVsS7r6a+Gkek+fPvhRqM3fnRGvKlNSS73Z5GREMbGbtVzvpzYP6D6DbNpy9dVbenqK7+ANEdKWkwdtp3JtLUBKxLAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XUEWrfxOGz9vig9Sj2YMr3lB8IFOy+i8V6eMQGrJVo=;
 b=nl9ZAriKEBD/n+jdHqIMO5TEYZ9qgUW3wTv5XD6C+Sk/NgOax36lQYK2T/4Eu3e8hw92RMAz+IvFjU7vHbb4z6Fas6IEoQHP6d+pC+aL+xjKd4WXfYM3Rqlohp0oqtolvcqpDvs0njHcnH3xkq4uYRgC8u6W5C7L0m7D3pLNyXVnDvpzYXGY7qGESAP35e/8qILcmJFTRcXCTIw1+qurjbbtBU/hAxTq4g8ibNgPAK1o/xFh/PoW+ZKZ17DKB6Bex/fr35LsxhGRVrdJJcGafRkPysQkxcjA8ccVE7Baogu0Ef2DpNE4dcBaHJEDj9vTBFsrcv5/yPngIX2xaHpKCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XUEWrfxOGz9vig9Sj2YMr3lB8IFOy+i8V6eMQGrJVo=;
 b=nM78GXvQDhNtSgCPH/MlYPOnULKjVfp1bXxi77EAxjJU3XZj1JuWYuyFypn0eurqnEBx478pzxhhCwUxMRh9kiL0twF8VQwnbFLJoGCdxYOrO9tRcxrVBwrg4vWdSrAt7J+51gxHa7CodKv3ShXWoOnd11isREAm9UOgH0In8fYQvDnf3BeBRiVtIofFxr7XvUMdTzcfRuVYizueXW+gmJfME+JKQf2AJaODBzpP+p+8x1k1NmBUUddmBdFGoqtgW0U6LX8wtkt//uftMyIyVox5RrJDdHrwM+e86eVVSWu/vnv4dGzrkIcA89mbQX/ibQk/1d3YLsMlTvrw71gQaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SA5PPFA403A61D8.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8da) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Tue, 25 Feb
 2025 04:36:20 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 04:36:20 +0000
Message-ID: <289351cf-7fc7-428a-8faf-f0763e85a8fd@nvidia.com>
Date: Mon, 24 Feb 2025 20:36:17 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 39/42] x86/resctrl: Split trace.h
To: Reinette Chatre <reinette.chatre@intel.com>,
 James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-40-james.morse@arm.com>
 <c481185c-9fbf-4c85-b1e2-ff95fc4cc18c@intel.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <c481185c-9fbf-4c85-b1e2-ff95fc4cc18c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::8) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SA5PPFA403A61D8:EE_
X-MS-Office365-Filtering-Correlation-Id: 194f7ede-4af8-4eff-9fff-08dd5555f383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|4022899009|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlhlMHdESzFYQjVqNU9HYkdaOG16bkpXY3NCTE1kM1J4Ni8xcWZ5M282Q0JT?=
 =?utf-8?B?Y25wVkpFcFBUa1liZGlCeFk2QlBtU0pCSUJvQkNkQmFHYzlaWEtrenNCbDNY?=
 =?utf-8?B?OFpsT0hJRzg4ZFNLZ0hjK2VVTGRRR2NjSkFaTHlOdjRiV2ZRU004ZklaMnZt?=
 =?utf-8?B?a1BwTmRrY01UeUwzV2k2cEVCbmNwRjZSWVZnU1hUcGtka1R0Ry9vUTRwRmJG?=
 =?utf-8?B?MExNYU1aRE1WYlVESWZ6MHh3SFFjTEJUZG50c2RLOHhicmFxeWwwQjN1Qm9z?=
 =?utf-8?B?K2hwVTdWN2VNRkdHYkRyazdRVW9kREpHSUZBSUg4d0lobWRieEJ2UlVZTVNq?=
 =?utf-8?B?aU5RT0psMnd5bzBKRkJTQ0lYQWhvVysyNExkbHY4TFMzOE56U2l4cXRQdHdN?=
 =?utf-8?B?RG9Pbkpqc3pnZnI0T3JGbnVaM1JSMktVcVRNWXN2V3FYSDc5MXUwYjUzNnhJ?=
 =?utf-8?B?Yy81ZDNpM1RNTkVHWnpIMlFwUzBEZTlKUStrSE9uN0NJMHNvcjQ1NVV3Wlk2?=
 =?utf-8?B?c1Q3anZUNlllaW5yS0lRanpucHVQL3NvNmtzRlp4bm54L2M5MHVad1FXVjQ5?=
 =?utf-8?B?c1ZHZVJ3NnNJMTVLVCtVcDh3R2FTR2ZqRzhwQTk4VWRHMkFvSzUzOFhhbFNK?=
 =?utf-8?B?Z2tMTGFkS2R4S1J1bG1aOXA1bVZhUTN3UWp4M1lDRWNybndTWWxFaE9FMFJq?=
 =?utf-8?B?TzdPSTZZWUt1Vmo3djRBM211ZDM3bzVJeTEwRnRrai93bkVHa3hLc01RNEUx?=
 =?utf-8?B?emNuNXdHcnFDdngrcFE4SVdJM1dmZ20yRGtESURjTVJWVC9teHNpUENXY0M4?=
 =?utf-8?B?NkV3RFN4MUxoSEx6cHdwcUxCOE9YUEFwMXdkMS9XODEwRlAyUWZicFVSTnhN?=
 =?utf-8?B?RmlEMXF4UDYyN243MWZ1QlBsbjBGRmc5TUVvcG4yS0NVNFlKYlVCbnZib25z?=
 =?utf-8?B?UC9wU3dmOHpJM09zT3gwcXZYZWx0SXFNREw4SXpGaTMwSSs5elphcmRaWnBS?=
 =?utf-8?B?MFJEYXFGb3JhSlZBaTBpaDR3eERKNzJsOWlrbWVJVGJTREVFN2FJREh0Y1NQ?=
 =?utf-8?B?N2kzM3RJTkptbExhZy9tcmFRVHAvcFcyRDRUOWl6bHhnZldOdUlQZ2VMeTll?=
 =?utf-8?B?L2kxUkVVcHNzUXQ4eDlwRlhDL1AxTTFDS1BiUjZydzlaYUdCZ1phSURTbHNO?=
 =?utf-8?B?clZJMmhkaCtUcjI1dUhUVUxwTkN6a2RybFZIY0p0N2xySzJ1d0d4dXFmSVo4?=
 =?utf-8?B?YTAvV2Q2QmpiZUJySjRkd0pBUWFmSkhscmc2SGFmTFFSNGV4SGU3cXFndXB1?=
 =?utf-8?B?M2ttRnBENVl0dlRpblNBbkhhNE9xYWsyWkl5T2QzTmE0ZGIxM2lUM1kydGVJ?=
 =?utf-8?B?WWtlZlU1Nmo5dHRFNCtqL1BsMHJMVjdPckdIMmVPUDRsdWFvdjVnbmRPM1cy?=
 =?utf-8?B?UlpscjhRa0RZM0RoL0xDeG9RNUZjdi82cXdHQkM4ZlVIRnVtWUJaY2kyODc2?=
 =?utf-8?B?a29xU2ZGQXdBdW5HZzlqbWR6bTN4ZTY1eFVVK1ZEZE5VZEJGWTJRNStJVm9r?=
 =?utf-8?B?Q1RXa2RNSWtqcWQwOHJsaGFSTERza0xHNE9GeE9mSUwxeXA5NWpBUXdKRlp4?=
 =?utf-8?B?UEV0WmNTdEMxdEhPcS9RWitkSlpRVGFMZGxGZ1dUNTNwN0lmSElvRUtsUkxs?=
 =?utf-8?B?Zy91QTRVMFVNY0pVNE1RRWN1OXZHZmFDVnJSYmYvRFNFR3k2emFvTDVaS0Yr?=
 =?utf-8?B?aS9jMzFvRUoyVnQ0ZXNjRmQ5bHdSZE4wU05oMmd3a1lsdU12d0tzNUt4dHZS?=
 =?utf-8?B?ZjhjN3MvSWRwMXc1SGpwQnhwTVoxeWgwZkpmR2tiS1Z1d3dKeWxNYXcreWhm?=
 =?utf-8?Q?15Pxfwb1uqYhd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjdCNWs1Uis5dXRteS94VjdPdHBnOXIyOTN3aFBQMjF1dHR0cjUwdE1sdSt4?=
 =?utf-8?B?TldxRWdXNDkrRmEyWGkxdHl3QU5kbnNXd0VXRGR4UW13SHhLMzlrSU9FUHJx?=
 =?utf-8?B?WUZ1Y2U1bGFyM3ZUZjNra0JPMTNNWll3dEY5Ky9sc2VDOE0rVUFqSHg3Kzkz?=
 =?utf-8?B?akxSL1pLVmc0YkxtZUpGTW9tbDRZekdXMUdiMkJHUGdRSUJIWXpBdVp1ZkFh?=
 =?utf-8?B?QTEwSXNja1FRWFB4Q0llNEsrUzBCLzZ6YXFjYytRenI2S0EzUW1hRjFQNUto?=
 =?utf-8?B?ZkNMRGN1L3ZEbVh2TnBkVkZ5ZVNVMXpLUTlLZ0JiQUt3bzNUSVRtelI0S3N6?=
 =?utf-8?B?QlRpYzZzYU1FMll6b0JaTXpuTGJxT2dwTTFQcDZwd0Z0ck5WYnJ6WVNkWlg2?=
 =?utf-8?B?U0FpU1kxMUlxS05jKyt5bTk1c0Q4dU50SitocGpTZmgxVmY3MGI4ZXBEVmRY?=
 =?utf-8?B?UVhOVU45NFFMcVR6bDNiKzNPanZlWUpzRnROTmJvZUVQeE5Gd3BRUWtWVWYy?=
 =?utf-8?B?TzhaME5sNEtlYUlZNGlyaFBkRXdNYnFvRS9MSU40V1hxTk9mZ3hON01JM2Ja?=
 =?utf-8?B?SjlBS3dyMzNRblk2ZXhPem14Z2lFbmxWMU1saHVNV0xMYUtuUDZCNVdlVVZB?=
 =?utf-8?B?dUwyS3MzblhIRDJXU3N3NXBBUFhYdm0xNENyOGljbDM1YWI3STU3SWFhMDlv?=
 =?utf-8?B?L2lYaXhKckk4dUh0WGcvTjJqdlFHeVZMK210UFZqTHhWUW5paktneFJaWHFN?=
 =?utf-8?B?MW5wL3hYZEZXOEdwQ3VDdVlXWnVtem9Sb3ZXZjlIVkV6SG1yeVNQazZoSFNC?=
 =?utf-8?B?aXhhYlhqZWNEek5aZkYxZ0VjWGxic0lIMStoOUVOQW5FTm1DdER4K0JDc3Zh?=
 =?utf-8?B?QklTd1dKWTV6UWlyb29HSGtKSHA1YjlYWE5rak1GYVB1VURGQVZnMk93bnA2?=
 =?utf-8?B?T2FwYkJnc0s2RE1ldTJsUDBXekw3bTkwQmgrbWlGdWIrUytFczJ4UGxJR2Yx?=
 =?utf-8?B?NGJmOEcyelB6a2M4TDZyNGtlTGpCajdFZVBBTDBXNTB2ZkpUMXR0Z1lVU1lX?=
 =?utf-8?B?SzhBUTFXSGhOUTVwZVNTZEk0UHNNMHV3T1BFSTBtL2FRWkZPZ2hWM0huS2Mx?=
 =?utf-8?B?QVJWSUNVM3oveitQRmN3TDREZnJRUzdKQTlNeHJXRmFtSDBKZ0dkb1AwM1Ix?=
 =?utf-8?B?NDJCQzZtU3crSi9YT0NMRTV1MkNkUGlRMkVDNmRCdWNjdGIvMVZSR29rT2hm?=
 =?utf-8?B?MFNqNnQ2SVhzaDR5N1NGdTV3WHowdS9xc0ZyQU1DVGVlcEw3cFVZVXczRFl6?=
 =?utf-8?B?ODBUNlc3STg3Um9XZXRHUGI2eHJTV24ySG1naitjL0tKRHprMDF0MWlEMkJY?=
 =?utf-8?B?TE5jNVM0bFBaR0dsb0s5NFRGYk5sMGF6YXRTbTgrSjBkQ1QyQmpza0VKYVh6?=
 =?utf-8?B?UnBEajhMZHJQd255NGNZYzRMdlYreTZHNWVyK1VPVlZJWS9aQ0FMMndEQXNK?=
 =?utf-8?B?RUJiakVMY2tVazg4ekN5ZUZtU0xNaytPRWRSUUJnUHB2R3BiS2FIV3RucHZB?=
 =?utf-8?B?bExybmM0UjlBRmtxNlhWVHF5Tkd1N2FHRktmRzJiNkRQVXdzK0UrSEh6ZW9p?=
 =?utf-8?B?dXZaNFl3Qm5vaG1lMlBDU25DMkRPZ2FLTWlvaHBpaGlCSjhId1BWZkd2aGZM?=
 =?utf-8?B?WUdpQ0YwOUpaSUVkQ0xUQVRUa2dFcTJHajFvaFRZSlVLSTV4VkxEenFBQWVk?=
 =?utf-8?B?UFp6TWpoWkxoQ203OWsrNmVzUXBCL1dGWUZEZFBSSTZoeUdOSDBYdnlQM1Uw?=
 =?utf-8?B?V1FjamVQeVVOVXMvbnlCa1hTdFpmeDZya2hicmNLVDFsS0QwRm1VMURCWGFC?=
 =?utf-8?B?dkQ3Y3lEU2p5c1UydUZ3N2o0UWtRcUI2RVc5ZEIzQXJaOTNkamI0NVZkc2w4?=
 =?utf-8?B?TzFIcnhIQWdrYWttN2c0d01jam0yWHdYVXNneDBIdWpOaWNRN1FVaG9rdXFv?=
 =?utf-8?B?NmRQdWhoaHlJaHVITm5YMU1qblp5b3ZvYTNEbHNUL2JwTDByNEhLaE54M1Jm?=
 =?utf-8?B?UDNXZmFWSWNUSyt6c1VlZzVBeTIzeEdEY29vOXNVejJaR2JLYTJjMnhFVEFZ?=
 =?utf-8?Q?pv3U32wU/HXEKO3TAFR0AJUjG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194f7ede-4af8-4eff-9fff-08dd5555f383
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 04:36:20.4325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6aGRgDdbY9WdCJdpQ5faHtvnXTWuhv0RTufZYEQTSkBhV8sjP5accKOGc1Uzhmioim0HQo58sJvtoXPrr5rDqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFA403A61D8

Hi, Reinette and James,

On 2/19/25 21:45, Reinette Chatre wrote:
> Hi James,
>
> On 2/7/25 10:18 AM, James Morse wrote:
>> trace.h contains all the tracepoints. After the move to /fs/resctrl, some
>> of these will be left behind. All the pseudo_lock tracepoints remain part
>> of the architecture. The lone tracepoint in monitor.c moves to /fs/resctrl.
>>
>> Split trace.h so that each C file includes a different trace header file.
>> This means the trace header files are not modified when they are moved.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
>> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> ---
> I did not investigate if this originates here or after the code move but
> when compiling the series (after running the file move script) with W=1

The issues happen after running the move script.

It's because no trace event is defined in fs/resctrl/pseudo_lock_trace.h 
or arch/x86/kernel/cpu/resctrl/monitor_trace.h.

One way to fix them is to add empty events in the trace files. But seems 
that may cause the script difficulty because it cannot handle empty 
events easily.

Another way is to remove the two files and their inclusions in .c files. 
Please see my comment and fix in patch #42.

> I see the following:
>
> In file included from /home/reinette/dev/linux/include/trace/trace_events.h:27,
>                   from /home/reinette/dev/linux/include/trace/define_trace.h:113,
>                   from /home/reinette/dev/linux/arch/x86/kernel/cpu/resctrl/monitor_trace.h:17,
>                   from /home/reinette/dev/linux/arch/x86/kernel/cpu/resctrl/monitor.c:32:
> /home/reinette/dev/linux/include/trace/stages/init.h:2:23: warning: ‘str__resctrl__trace_system_name’ defined but not used [-Wunused-const-variable=]
>      2 | #define __app__(x, y) str__##x##y
>        |                       ^~~~~
> /home/reinette/dev/linux/include/trace/stages/init.h:3:21: note: in expansion of macro ‘__app__’
>      3 | #define __app(x, y) __app__(x, y)
>        |                     ^~~~~~~
> /home/reinette/dev/linux/include/trace/stages/init.h:5:29: note: in expansion of macro ‘__app’
>      5 | #define TRACE_SYSTEM_STRING __app(TRACE_SYSTEM_VAR,__trace_system_name)
>        |                             ^~~~~
> /home/reinette/dev/linux/include/trace/stages/init.h:8:27: note: in expansion of macro ‘TRACE_SYSTEM_STRING’
>      8 |         static const char TRACE_SYSTEM_STRING[] =       \
>        |                           ^~~~~~~~~~~~~~~~~~~
> /home/reinette/dev/linux/include/trace/stages/init.h:11:1: note: in expansion of macro ‘TRACE_MAKE_SYSTEM_STR’
>     11 | TRACE_MAKE_SYSTEM_STR();
>        | ^~~~~~~~~~~~~~~~~~~~~
> [SNIP]
> In file included from /home/reinette/dev/linux/include/trace/trace_events.h:27,
>                   from /home/reinette/dev/linux/include/trace/define_trace.h:113,
>                   from /home/reinette/dev/linux/fs/resctrl/pseudo_lock_trace.h:17,
>                   from /home/reinette/dev/linux/fs/resctrl/pseudo_lock.c:34:
> /home/reinette/dev/linux/include/trace/stages/init.h:2:23: warning: ‘str__resctrl__trace_system_name’ defined but not used [-Wunused-const-variable=]
>      2 | #define __app__(x, y) str__##x##y
>        |                       ^~~~~
> /home/reinette/dev/linux/include/trace/stages/init.h:3:21: note: in expansion of macro ‘__app__’
>      3 | #define __app(x, y) __app__(x, y)
>        |                     ^~~~~~~
> /home/reinette/dev/linux/include/trace/stages/init.h:5:29: note: in expansion of macro ‘__app’
>      5 | #define TRACE_SYSTEM_STRING __app(TRACE_SYSTEM_VAR,__trace_system_name)
>        |                             ^~~~~
> /home/reinette/dev/linux/include/trace/stages/init.h:8:27: note: in expansion of macro ‘TRACE_SYSTEM_STRING’
>      8 |         static const char TRACE_SYSTEM_STRING[] =       \
>        |                           ^~~~~~~~~~~~~~~~~~~
> /home/reinette/dev/linux/include/trace/stages/init.h:11:1: note: in expansion of macro ‘TRACE_MAKE_SYSTEM_STR’
>     11 | TRACE_MAKE_SYSTEM_STR();
>        | ^~~~~~~~~~~~~~~~~~~~~
>                                                                                  
> [SNIP]
>
> Reinette


Thanks.


-Fenghua

>
>
>  From mboxrd@z Thu Jan  1 00:00:00 1970
> Received: from foss.arm.com (foss.arm.com [217.140.110.172])
> 	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBED71AF4E9
> 	for <linux-kernel@vger.kernel.org>; Fri,  7 Feb 2025 18:21:02 +0000 (UTC)
> Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
> ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
> 	t=1738952472; cv=none; b=PFrOGcCGM+MjrdBzD6HmKJG/UiOsBugPbKMsqC2F57JloaI12vsfJ6MvmkRWrY6qiP/OJUu0TOyQpGWHpn5aRfBOYww5b+87lSnRBQRdrF+KXxLTyqMVd1nH4aZdUDrvcaZ6VG7GPcBcDERY8rqliD0ML1je6nefzSBMGoE0+DI=
> ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
> 	s=arc-20240116; t=1738952472; c=relaxed/simple;
> 	bh=34UocWVSN3dGfK9ddb8MDRo3AU4bVW3Pvwz5MGjnN30=;
> 	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
> 	 MIME-Version; b=edzmQCT8CRaz1N9z0j5OnDawAxdTiDx7vz1PxIqaf5ANscFYEuEcKlijvFuk1ENpYAU9jyXuAwVX4dQlp2AMWVwCTWurQln2bvF/4lWLn82uB1BR2FokzzzUo8n5w4Dyn8koLUwzNlk9a3U0TjKO23gs1LFoqLoOlDqXLQHleeA=
> ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
> Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
> Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
> Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
> 	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 829C71F37;
> 	Fri,  7 Feb 2025 10:21:23 -0800 (PST)
> Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
> 	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64EA33F63F;
> 	Fri,  7 Feb 2025 10:20:57 -0800 (PST)
> From: James Morse <james.morse@arm.com>
> To: x86@kernel.org,
> 	linux-kernel@vger.kernel.org
> Cc: Reinette Chatre <reinette.chatre@intel.com>,
> 	Thomas Gleixner <tglx@linutronix.de>,
> 	Ingo Molnar <mingo@redhat.com>,
> 	Borislav Petkov <bp@alien8.de>,
> 	H Peter Anvin <hpa@zytor.com>,
> 	Babu Moger <Babu.Moger@amd.com>,
> 	James Morse <james.morse@arm.com>,
> 	shameerali.kolothum.thodi@huawei.com,
> 	D Scott Phillips OS <scott@os.amperecomputing.com>,
> 	carl@os.amperecomputing.com,
> 	lcherian@marvell.com,
> 	bobo.shaobowang@huawei.com,
> 	tan.shaopeng@fujitsu.com,
> 	baolin.wang@linux.alibaba.com,
> 	Jamie Iles <quic_jiles@quicinc.com>,
> 	Xin Hao <xhao@linux.alibaba.com>,
> 	peternewman@google.com,
> 	dfustini@baylibre.com,
> 	amitsinght@marvell.com,
> 	David Hildenbrand <david@redhat.com>,
> 	Rex Nie <rex.nie@jaguarmicro.com>,
> 	Dave Martin <dave.martin@arm.com>,
> 	Koba Ko <kobak@nvidia.com>,
> 	Shanker Donthineni <sdonthineni@nvidia.com>,
> 	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
> 	Tony Luck <tony.luck@intel.com>
> Subject: [PATCH v6 39/42] x86/resctrl: Split trace.h
> Date: Fri,  7 Feb 2025 18:18:20 +0000
> Message-Id: <20250207181823.6378-40-james.morse@arm.com>
> X-Mailer: git-send-email 2.20.1
> In-Reply-To: <20250207181823.6378-1-james.morse@arm.com>
> References: <20250207181823.6378-1-james.morse@arm.com>
> Precedence: bulk
> X-Mailing-List: linux-kernel@vger.kernel.org
> List-Id: <linux-kernel.vger.kernel.org>
> List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
> List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
> MIME-Version: 1.0
> Content-Transfer-Encoding: 8bit
>
> trace.h contains all the tracepoints. After the move to /fs/resctrl, some
> of these will be left behind. All the pseudo_lock tracepoints remain part
> of the architecture. The lone tracepoint in monitor.c moves to /fs/resctrl.
>
> Split trace.h so that each C file includes a different trace header file.
> This means the trace header files are not modified when they are moved.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>   arch/x86/kernel/cpu/resctrl/Makefile          |  3 ++
>   arch/x86/kernel/cpu/resctrl/monitor.c         |  4 ++-
>   arch/x86/kernel/cpu/resctrl/monitor_trace.h   | 31 +++++++++++++++++++
>   arch/x86/kernel/cpu/resctrl/pseudo_lock.c     |  2 +-
>   .../resctrl/{trace.h => pseudo_lock_trace.h}  | 24 +++-----------
>   5 files changed, 42 insertions(+), 22 deletions(-)
>   create mode 100644 arch/x86/kernel/cpu/resctrl/monitor_trace.h
>   rename arch/x86/kernel/cpu/resctrl/{trace.h => pseudo_lock_trace.h} (56%)
>
> diff --git a/arch/x86/kernel/cpu/resctrl/Makefile b/arch/x86/kernel/cpu/resctrl/Makefile
> index 0c13b0befd8a..909be78ec6da 100644
> --- a/arch/x86/kernel/cpu/resctrl/Makefile
> +++ b/arch/x86/kernel/cpu/resctrl/Makefile
> @@ -2,4 +2,7 @@
>   obj-$(CONFIG_X86_CPU_RESCTRL)		+= core.o rdtgroup.o monitor.o
>   obj-$(CONFIG_X86_CPU_RESCTRL)		+= ctrlmondata.o
>   obj-$(CONFIG_RESCTRL_FS_PSEUDO_LOCK)	+= pseudo_lock.o
> +
> +# To allow define_trace.h's recursive include:
>   CFLAGS_pseudo_lock.o = -I$(src)
> +CFLAGS_monitor.o = -I$(src)
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index a9168913c153..6acfbd3ad007 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -26,7 +26,9 @@
>   #include <asm/resctrl.h>
>   
>   #include "internal.h"
> -#include "trace.h"
> +
> +#define CREATE_TRACE_POINTS
> +#include "monitor_trace.h"
>   
>   /**
>    * struct rmid_entry - dirty tracking for all RMID.
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor_trace.h b/arch/x86/kernel/cpu/resctrl/monitor_trace.h
> new file mode 100644
> index 000000000000..ade67daf42c2
> --- /dev/null
> +++ b/arch/x86/kernel/cpu/resctrl/monitor_trace.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM resctrl
> +
> +#if !defined(_FS_RESCTRL_MONITOR_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _FS_RESCTRL_MONITOR_TRACE_H
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(mon_llc_occupancy_limbo,
> +	    TP_PROTO(u32 ctrl_hw_id, u32 mon_hw_id, int domain_id, u64 llc_occupancy_bytes),
> +	    TP_ARGS(ctrl_hw_id, mon_hw_id, domain_id, llc_occupancy_bytes),
> +	    TP_STRUCT__entry(__field(u32, ctrl_hw_id)
> +			     __field(u32, mon_hw_id)
> +			     __field(int, domain_id)
> +			     __field(u64, llc_occupancy_bytes)),
> +	    TP_fast_assign(__entry->ctrl_hw_id = ctrl_hw_id;
> +			   __entry->mon_hw_id = mon_hw_id;
> +			   __entry->domain_id = domain_id;
> +			   __entry->llc_occupancy_bytes = llc_occupancy_bytes;),
> +	    TP_printk("ctrl_hw_id=%u mon_hw_id=%u domain_id=%d llc_occupancy_bytes=%llu",
> +		      __entry->ctrl_hw_id, __entry->mon_hw_id, __entry->domain_id,
> +		      __entry->llc_occupancy_bytes)
> +	   );
> +
> +#endif /* _FS_RESCTRL_MONITOR_TRACE_H */
> +
> +#undef TRACE_INCLUDE_PATH
> +#define TRACE_INCLUDE_PATH .
> +#define TRACE_INCLUDE_FILE monitor_trace
> +#include <trace/define_trace.h>
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index e7f713eb4490..9eda0abbd29d 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -30,7 +30,7 @@
>   #include "internal.h"
>   
>   #define CREATE_TRACE_POINTS
> -#include "trace.h"
> +#include "pseudo_lock_trace.h"
>   
>   /*
>    * The bits needed to disable hardware prefetching varies based on the
> diff --git a/arch/x86/kernel/cpu/resctrl/trace.h b/arch/x86/kernel/cpu/resctrl/pseudo_lock_trace.h
> similarity index 56%
> rename from arch/x86/kernel/cpu/resctrl/trace.h
> rename to arch/x86/kernel/cpu/resctrl/pseudo_lock_trace.h
> index 2a506316b303..5a0fae61d3ee 100644
> --- a/arch/x86/kernel/cpu/resctrl/trace.h
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock_trace.h
> @@ -2,8 +2,8 @@
>   #undef TRACE_SYSTEM
>   #define TRACE_SYSTEM resctrl
>   
> -#if !defined(_TRACE_RESCTRL_H) || defined(TRACE_HEADER_MULTI_READ)
> -#define _TRACE_RESCTRL_H
> +#if !defined(_X86_RESCTRL_PSEUDO_LOCK_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _X86_RESCTRL_PSEUDO_LOCK_TRACE_H
>   
>   #include <linux/tracepoint.h>
>   
> @@ -35,25 +35,9 @@ TRACE_EVENT(pseudo_lock_l3,
>   	    TP_printk("hits=%llu miss=%llu",
>   		      __entry->l3_hits, __entry->l3_miss));
>   
> -TRACE_EVENT(mon_llc_occupancy_limbo,
> -	    TP_PROTO(u32 ctrl_hw_id, u32 mon_hw_id, int domain_id, u64 llc_occupancy_bytes),
> -	    TP_ARGS(ctrl_hw_id, mon_hw_id, domain_id, llc_occupancy_bytes),
> -	    TP_STRUCT__entry(__field(u32, ctrl_hw_id)
> -			     __field(u32, mon_hw_id)
> -			     __field(int, domain_id)
> -			     __field(u64, llc_occupancy_bytes)),
> -	    TP_fast_assign(__entry->ctrl_hw_id = ctrl_hw_id;
> -			   __entry->mon_hw_id = mon_hw_id;
> -			   __entry->domain_id = domain_id;
> -			   __entry->llc_occupancy_bytes = llc_occupancy_bytes;),
> -	    TP_printk("ctrl_hw_id=%u mon_hw_id=%u domain_id=%d llc_occupancy_bytes=%llu",
> -		      __entry->ctrl_hw_id, __entry->mon_hw_id, __entry->domain_id,
> -		      __entry->llc_occupancy_bytes)
> -	   );
> -
> -#endif /* _TRACE_RESCTRL_H */
> +#endif /* _X86_RESCTRL_PSEUDO_LOCK_TRACE_H */
>   
>   #undef TRACE_INCLUDE_PATH
>   #define TRACE_INCLUDE_PATH .
> -#define TRACE_INCLUDE_FILE trace
> +#define TRACE_INCLUDE_FILE pseudo_lock_trace
>   #include <trace/define_trace.h>

