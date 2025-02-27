Return-Path: <linux-kernel+bounces-537489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5887A48C8E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 00:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB363B0E59
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1366E272925;
	Thu, 27 Feb 2025 23:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kjP05l1F"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869482309A3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 23:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740698224; cv=fail; b=LKDafydnNhmDmwc8JikRO+wW+/2YfBEPsVOaC8EKpU82aRXm6n+2qj2AWsxsay60niYItwSlcDC3IdtiEYdg2xLLDHz7nBZ7X4npxm2xtL7kPbsarr3Ix1FyztL0gcb73GiGLOH0fJ/UNp1iL62qLQ9aNvlEGzy92G3NNh2Y0+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740698224; c=relaxed/simple;
	bh=yIuk59XoLr027r6kToyNPVnO9xsE73kW+MVYDAs2jyQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SLqgtUwmrUsPxU0PEClV1021D5TPHByHyR3ADQjtjgB95g9lU00UUpm5SS8lG+8I8viM6W8otE5MUt5t3FNJ8bFRVvtYGuYNS7yJhbKJ7KQ6NGx7gYEypOIgtbGmaBQbk7LZp9Nc2GdrhgM5U9nyv9/v7WTeO72iuP8/IUJJJqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kjP05l1F; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWEObzO3er3kxr+1lz7AM+CgJQzRfizISeghMuySpTS8PGdpq70A/8s6Nv5i4pLd6Lpmnsg2DS1pkFY28TojugVAReJVmLC2bT5KuUvwfeLZ5xnXpoDMxEeBXkZRMycMJ7fkeu5c3KmL+QIRaElImailbX/YIIbofCJ82pzesvOpfDPZUvAwvhOIeq8Vwl01s9fNIcdAnJnNUGD5+HeOYNw2B1qABl6zwoFukUUESLVuPuv2bN8CcWvezZykPG9LnKKl3Qo42qYHVzpvAEKcFWAnVBUM1zfZ34V/pWiTNWHgfQg9Nib1ojuVDU0r/4znpu6325+b1C3dO6AOMU8DDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fI6TUNwy4jPUyxZWfqV+L1Nls8dn5DkCoitSYUXsnhM=;
 b=fwfaO8k7v1YlrOpAR/xUdRpNIkAyp9zcquwR2Pg9Gb5Bb4/epcRa4+f6AuexptQTtr0JNmVnahUsmyBnB7dPlpg9tOUWTXwZxTasFDM7YzIvExRh2YI6Ns8xHv4ypHxCjNXwc1mdrfPN3QqVTbez99aoT4eOMWqYyYzP983J0u07xWIqcJJOxAdUYFgagYAG/pCsKoKkec4G4w1k7xV9uIMHutvyEpQbpT7QzO3sakKXHH3S6k4S8AGya0P9t528v9atvLvnDDApVwLpzNIC5G1NY49OLYtxKfOM7X5zrtgpw9NA2Aes/qJygSodhey0KnvwZsY//X/VgUw4IEMk6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fI6TUNwy4jPUyxZWfqV+L1Nls8dn5DkCoitSYUXsnhM=;
 b=kjP05l1Fd4rbGIoLt8ZeLcPrf5orFix4cH/q6MtIovXJtNi39gOWPJdgjoxjwHtytxoGUPgl7mn/5XtE+JR2XoUFAQFVap77NEQvWZXZ8GxvUiugWaHwrkB611b1NEIscAfLobZakLhkpunDYM3QPqLVk53yPnk41inGjM1W5WeUEe4XQ7eptCppTZ+sEGoqJ4YrF6xM/3pvint3VeorX8c6yvTQ1ZscIjgK3puPHsI0Krd565tVfLrppJ/FXkRdzwstgxdyeX4p3dBar4aOTzm13TAzEah6HyXner2g4iH42HPjVNjIGcp9jb/bIOlNMq0PuuzpNqJX3JN0jXUnGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 PH7PR12MB6720.namprd12.prod.outlook.com (2603:10b6:510:1b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 23:16:58 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 23:16:58 +0000
Message-ID: <dc055425-9db5-40ba-b9aa-fb95e49e883f@nvidia.com>
Date: Thu, 27 Feb 2025 15:16:55 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 39/42] x86/resctrl: Split trace.h
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
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
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250207181823.6378-40-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0163.namprd03.prod.outlook.com
 (2603:10b6:a03:338::18) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|PH7PR12MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: c99c6620-e7db-4267-8815-08dd5784d4ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGRjdklaNzJqdlg2cWhZWG9EdERMdUNzWGRJVVI3UzZMeVRlQ2JNa3NqbStW?=
 =?utf-8?B?Qlp1RGFJcFNCUVdQTGd2NThpUWhZU1dMNzc1NmhtZFZEZHFtcHUzVms0STY1?=
 =?utf-8?B?eEZ5Rit2SUo3YVdVcENaUlNYWWJpeTZOUCt3QkdpQXQ1V1RwRzZQZ3BPVity?=
 =?utf-8?B?V2pnTlFZZElhUGN0akVLamtsQTEyM0x5K0p6R2c5ZUJ4YTU4aVlFZlQvNm12?=
 =?utf-8?B?MkdxVjh0TWFJTi9pMDFja1F0NGVucFhzZXBCNDZIa2t3SmRkQU9kRmpZQUVO?=
 =?utf-8?B?WllMd2svS084RmhwUXdwK2UxTVZCZ1pnQ1dIT2J4U3FWNlVId1RKUDc0QnlC?=
 =?utf-8?B?TnU4NlNNY05ZVVhGSStEL1hGYVYvcDRKZWpFTEFIdXBKVzhKWnVBc2tsNUl6?=
 =?utf-8?B?c2k3Wkc1WndFTTFoYzhJQzQxR1BPL09rUzVDZ081S1JvMW80Y3VSN2NWQjBV?=
 =?utf-8?B?aW9qMW1LWlZQSGFvemZBY2UvNVZmZlVSRzBnRGV4UXQ4QnhhV01VYW84YXQw?=
 =?utf-8?B?NS9rT2s5Y1NiWkFpRGh1dXBKaU9ialF6ZFZwUDJmczgzMlhKZWFSa0E0MUUx?=
 =?utf-8?B?Q2lKa3cwU01zUWlLSmRabU9iSnc4YThkaWFaR0ozL2JmR1VGU3JzSEtwUW1L?=
 =?utf-8?B?QU8rL0FHY2pyZzBDOUtwR0dydy83eW9CMkR0SGNmQkxJY2Z0eG1ObkNmNERW?=
 =?utf-8?B?aEdJNzVXc1V5NVdORWJOSHYveFJxTEZTVzdLODViWkxscWEvRUI2dzRvS2hU?=
 =?utf-8?B?Rjhsa3p5ZVNCNnl5eWhleTBodTJNZnJXR1RHZDJJSnFlZW51RnZmSWhES0pN?=
 =?utf-8?B?dkFXRTVRZ01BTHFRaC9oRnlLSEZDRjFDS1lJV015bWJKNjRMb2oxUmlJSGsx?=
 =?utf-8?B?elQzeGY4dWllNENpMk1KdTY0N1UweUxFT3N4OVB5bmVqa3pTM1pjWGJRaThD?=
 =?utf-8?B?RmlaaFB4elh3cmQxaStDTGY5SkFQdDl0R25Rb044bUEwenBTaGxuUklkTlJj?=
 =?utf-8?B?ait2dnpUTFZlYkZXQ3NFd2dxY1hDb1dDRGNOQ1prZC9yclpvdng5YXllMHB3?=
 =?utf-8?B?RzhDM3EzN1g5dWFaaGZiWHptbkF0Z1BhTTRrVDQxTkdxbmtreXNnSE9IeXJD?=
 =?utf-8?B?ZUF3eWJFVWdCbmdOaW9RckZScjcwdU0xOEdWZ0NSclhYVDdGS0Rtalh4TTJI?=
 =?utf-8?B?amo5YzJxTjU1WmZxNkdxQWlVQkNHaW9HeWZDZWp4UGR1VkdZRVlEM2gyaDRE?=
 =?utf-8?B?RW0xQitqV1c4QUNjdlJGb25OZjQ2VncvUzFCbWxZc0JHQkUvb3FBOHR0VWdl?=
 =?utf-8?B?WkE0VldQZk5EZUFJRVkvNVorMXczdDdiQk9YaVZFYlZpSUswdnJjb0ladHlP?=
 =?utf-8?B?NVlKbXM4NFZWbU9PSEZBY2s4YzRNa0VlK1R0RDU4UkJOc1gxOUJYNUpORGd0?=
 =?utf-8?B?bjBaVzkrYWplbmhjbGlqdzBYTHNEWTJNNnFKTStxdXRnRkxiaW9XWm1GZHpa?=
 =?utf-8?B?eWEvWWxIL2FBcEFuTXQwTGtTU0VVQ3Q5VVpPV25Fam5udGVxSHMwRGxTWmV6?=
 =?utf-8?B?NXZKVTJ2VUR0TnlkQ2t5eWlqaDl3WVBveFV6WVd1L2JVczlFNUgrZ1JWUnU4?=
 =?utf-8?B?TkNrejBFTUp5N2pQUXRTa1JncllGcmRlUkoyZVUzcnNad0xyWDVhMVE5R1g3?=
 =?utf-8?B?aDJnemhhbEx1RVNVZTlXeUNTNGdCdFJtNVhETzZWVVdHSkNBSitxUU1za2JJ?=
 =?utf-8?B?bjRHRVJVbzRWU1o1WmJvaW12OGJUTG45MEljY2k5NWpZdEl1R2V3a3BOQjBt?=
 =?utf-8?B?WVU4bTBaZEpENzlZdUFwU0dnc1lTM1VwTU5VQ2hER3hza2ZKZDZxeDh1OEpY?=
 =?utf-8?Q?fSLUlDufZxoG5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OU42dkFzL0IvL3AxQ3pkZlBobDZ2T2FaRTViK1dDYWhJTTI1WEJlbmVPejVl?=
 =?utf-8?B?Uk0veWVOSEJaVDhXdStoMmxMYmUxUitFdWlJKzJtR2dTM3hQMFBKMVpsRWJX?=
 =?utf-8?B?K3lmUUpXUWpxNXAxeWpUZlBWNkphQ1hjN1lVcVVkdzBPSkdvM29rZ1l3RVY4?=
 =?utf-8?B?TXJzeVBveG1UOVR2ZG4zcmQrWXNVdWUwWVEzNlJiOUxUdHRGSE5ycUhVMm8x?=
 =?utf-8?B?Si9TdXltZ3gvSEwrdUE2cEpabGlSTDVWdHJPTFBselY1NW1KUUJBbjNnUFJx?=
 =?utf-8?B?R0E1SkJiVTZaQ3BzTytULzJFdFhOZUd2di9qZWhUSkIyUlg1dk80bFlpdE1L?=
 =?utf-8?B?OWtxMzgvYSt1MEdibEtTTGRrdXhUSFhsbmpEODVLdElNRkgxWGxmRmdGZGR5?=
 =?utf-8?B?YTdQdzVtUXhFZmJMeGg1VDVYNnJQS3R4dW52ZmM3Wm9EYmRnMVVydE9wcFFq?=
 =?utf-8?B?OXNjOEk0MEF1SkVnSXZOMWtpQUx5U2ViUE5tY2IvaElwL3J4VFBmTGQ1ZENU?=
 =?utf-8?B?QTNLTlpHR1R5a1hSU1VOa3FpemliWXc0ZGF3NGhVWHAralV3M2MyemtBQkxE?=
 =?utf-8?B?YU9ZVUJTeCtIL2FrTDJEampuS0ZWT2Y4bkJBaGZ3NkVDQ2JDTzdEcENtdTdT?=
 =?utf-8?B?Rk5mbTI1VGQ0N0xzUFFnYUVCRnh4Q1A3MGptMldCU3c1WmRvcnRmSW1SZ214?=
 =?utf-8?B?Z0hiYXdFSVdCR2c3ZGdwWGo4SFZVaDVQdFZHbkxINTJncFJXb3MvWDhkRmlM?=
 =?utf-8?B?ZjRsQ21ReVpxb01YcUJaZmM0dFdvNGJpVjNhZ3R5MjcrRnU3VUxXZXUvL0sx?=
 =?utf-8?B?d3dkQ24zWTJTRlR1Sk5LOHRkaWZETHRvUVQ1WjZveFRzRzRlRGVyQ0xzWDhL?=
 =?utf-8?B?T3dJUXZ3cUI0dUtkbmo3NENjZlFYZWc4Z0lvYXAvRm9ib3pHb0tCV1laZ3or?=
 =?utf-8?B?NDRtU2FLNndoWXN2R0hIbjVJUUxwa2hZUG1JU1YxSXoxZ2VYOFVLTEJPWkJl?=
 =?utf-8?B?MDFpTWRwZVNpQ28zM3NXK1huVmJoZXpTaUY1OThOYzdyeE5kM0p1UU02MnVF?=
 =?utf-8?B?R1hML1JQRjQvbWJ2a0tmblRUSG5BT0RCQmtVMzhBV0k3L2tZU3NQeGVRZDZT?=
 =?utf-8?B?NkZsRXVBYmJOSDZsdXFnV3FCeGYzZGNFcEZtWlhSc0lCWHN4eEpnTzBkRmpl?=
 =?utf-8?B?WlZ5UTAxbXNmTUNxdHlmd05TTm8rcUhGbGdSN0ZwenNNTjZqUmRyb3hLTEto?=
 =?utf-8?B?c2hiMTA1WnBycDhiRXpYS1BRZkUwNnZsUXFoc2RsdHNNVmJKTXgrZFJ1aTZL?=
 =?utf-8?B?VlBiTGczOUd3cmhmeTJndE1qM1hscmp5bm4wRXF6NitZSythbGRiL2lZeG40?=
 =?utf-8?B?RDdna3RjenhvVS93dTZ5WkJyN1FldzhqcGYwOGNkalpjTy9WYUtqSVowemVj?=
 =?utf-8?B?aTBkbHczUW5QY2hpWmdwQnVObUtCbm41cStndkdicUpvVHI0ZFNjYTdWc005?=
 =?utf-8?B?UytGSlpYV1Z5L240SllXcVA5S2c3ZkRJRmtWNXBRNVpoc0c1SnREemJuU1FN?=
 =?utf-8?B?amlmMzhFZ3VvRHQzMmxIM2U5VS8xZHg2eXc0L0NiN3dtSEo1bFRsWjFhQ29p?=
 =?utf-8?B?cnh3K2hoc3Y5ZjRRUXpKM01kNW1KMFVaNDNoRXcxWHNCL3Z3bjVjcGs2NVFw?=
 =?utf-8?B?eEcxMmhYUXU1ck50S0R2UWk0SUdmQjdVbnpqVXlmamN6ZjZHS3BkdGJBcDJD?=
 =?utf-8?B?ZythS25QTXVvMWZDODVYb1JjeHNzYll2bGl4bHVLeE9EQ2VQcWJtaVpINElR?=
 =?utf-8?B?SVRIV05taVdLclVoSU5XSFFRUmFWSGg5MUtXRzJzRkVZN0hIRUpLaWc1bjM1?=
 =?utf-8?B?ZGFnTENkem55TDJra0dsY0NnZ0FvYmxpTVFmRmZCY3hOOU1CajhtWEpNVDRC?=
 =?utf-8?B?R05YaHpQNVoxL3BDNTNPN2l0K0c3TWdDaWo2T2VZZklxeDJVU251OUY1NkJQ?=
 =?utf-8?B?TVlxRXhIYXVMV3I1TlFraEhTWEM1S2s2UVVwRitEZmZUL3dVckh5U25mZjJX?=
 =?utf-8?B?cm9yNDNCNkM3NitTTVNKcWVOQ0ladHN6UmZkQXZHVWg5V1BYVm5MR0FUTUpG?=
 =?utf-8?Q?Eb+SWeXKiYk4eHPARfJaXIjG6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99c6620-e7db-4267-8815-08dd5784d4ee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 23:16:58.0077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTQygPeMJv9rS0f7DyWpYnqnwc93FBvJHRzBBPRnpORg5vbkegXALkw1FL4obqQrUk/ZPCwAmZBSv/iv9b5H0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6720


On 2/7/25 10:18, James Morse wrote:
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

Since this patch itself doesn't cause the errors when W=1 and doesn't 
appear any issue to me,

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua



