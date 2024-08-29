Return-Path: <linux-kernel+bounces-307206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB383964A0E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69CC71F220D5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2771B1B3738;
	Thu, 29 Aug 2024 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zm/sMN+Y"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DF91B3722;
	Thu, 29 Aug 2024 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724945367; cv=fail; b=jyBSLJax7EbgZHD6kO0aEEv1bXr+AY4tyjTmHl/EAiDStjcNIc+Ot7/7v11p1DCbXQVExwxrTcvC2IpEhgIZwLqlbR7amPJFoL+89HxVEuTX0dqg/Ym27eJQDwia3r01JMAoqKW9qVM29+fa9s86qqTS6BeZgmAc4WIgdTpvc4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724945367; c=relaxed/simple;
	bh=C38mQq6VA1efcv2TW0OLr94ybYl/GvU6LV+BaNSFXWM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S7mtcfFButZHK5VKfp6Q1JV6eSYSQzaRcl1NUZn1PDALTmwuVZ8a10HwKFVGgEcE+zWd5go3ku2Ip/TzlbBoBjbVgKNhhQCqos6SAkSMhNXjVUcEqpSSjF7gMMIWHnLlzV4MZgN0MSYOE982X4ZAFmGmrbve1izg83opDMqW2uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zm/sMN+Y; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/d8QUcs12gcb9SvtBT3aNT7ICw9+rRPG6pdI6X3Lm0WXHa/IkxJSqNJVqeQet/LFJnriCH9TU2kzRQf7KtOY+uNgLL9RFW3HXQy5FakYrvEWE9GUufPO/dBFwjPHCB7h25gt1bWOTQT7ZMLwTYx/a3ZyApsA0usalUgeLh0nbRLE9TtcnmT/7PEH4O5Eh4ak0f8Y2K0w/4jE1DCWS+haAYS+NC6p/RrCdqTYF3howRCYa3qSRWBG3Iu0svfFTdBrY98UmErMqAZBe+odWZTUn23QUxF5i7wC9KQIgHk2GKMEOpF37ZanYyQ9fxzaBdKaCuFwG9N0ukmt3gFrhHX1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWxvVmwsdYlUVbfKy1LPWAqAOxF44g1cP3/3mZrHd2s=;
 b=FEt/+MCWr4n8SGLBIa5CdWRM10I9zTYpq7vSir+32zXBUOygdThg0/TQtkxMM6/ZHtQnNvomjF9avmomUkTBCBYiWBvRvMT1Ib8dPKforPuU7wOqz0v3tBBsQ/Jom4hihZfCnsMmUfg9ZL7G4w0QX77s+eYaE8/LlCpbvahdhhZWKOEAq85GZKUJaiS5omgQk1BR9itxIiYwCKqI7NgJFEK16o7fNkrg6Cuze7g3XfV9N36uy92x+DW0E39BjYexek1wu2FAa33Lq7VPUM50XaTSw9/z+Kt2MFo0abN8+CkdOL4N8wxDubd+ZBCoVSOKTbKpfrC0BS7x+XAcjO9Ayw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWxvVmwsdYlUVbfKy1LPWAqAOxF44g1cP3/3mZrHd2s=;
 b=Zm/sMN+YS1BuVkVOM10E9CtDdT8r3E5xjHSv9NvjpwBIpHSTD6JHZHfvmwHEtji9jdicmEKM0PXpQwcL4mpUidCprKOpEeYSO2fYVtI0oPCXJ001zaWcxkppZeWRBJuZkiSCbC1ad1XLmVaawpCEzZHtK69+zaI1lcsHeL90N4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23)
 by BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 15:29:20 +0000
Received: from SA0PR12MB4447.namprd12.prod.outlook.com
 ([fe80::b4ba:6991:ab76:86d2]) by SA0PR12MB4447.namprd12.prod.outlook.com
 ([fe80::b4ba:6991:ab76:86d2%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 15:29:20 +0000
Message-ID: <385ef968-4b13-9124-1f13-e521992ac0c7@amd.com>
Date: Thu, 29 Aug 2024 10:29:16 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] x86, KVM:SVM: Move sev specific parsing into
 arch/x86/virt/svm
To: Borislav Petkov <bp@alien8.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "VanTassell, Eric" <Eric.VanTassell@amd.com>,
 "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
 "Kalra, Ashish" <Ashish.Kalra@amd.com>, "Roth, Michael"
 <Michael.Roth@amd.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paluri, PavanKumar (Pavan Kumar)" <PavanKumar.Paluri@amd.com>
References: <20240801205638.6603-1-papaluri@amd.com>
 <20240801205638.6603-2-papaluri@amd.com>
 <20240829132438.GCZtB2lqeYpleYk9c4@fat_crate.local>
Content-Language: en-US
From: "Paluri, PavanKumar" <papaluri@amd.com>
In-Reply-To: <20240829132438.GCZtB2lqeYpleYk9c4@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:254::10) To SA0PR12MB4447.namprd12.prod.outlook.com
 (2603:10b6:806:9b::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4447:EE_|BL3PR12MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: dca92eab-0307-443f-38ed-08dcc83f5a2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3cza09uZzZMLythaUR4TU8vUjkrYVpVcWJINWlXMW5uUmxLZTlGZkZaSUVV?=
 =?utf-8?B?emh5M2xFU0dTbmEvSGNZVXdlLzZRMW5qUjFmY1F0TW5KVkt0YUhuOU9Zc1Jt?=
 =?utf-8?B?Tnk2VWRIL0xLbUcraWtFc2FwQi9lZUpIaUtEUy9maWsrUWlFZG1wM0c4R0tE?=
 =?utf-8?B?djZJRE05R3NON0ordE9IYUdZekxhdFg3cytURWx2Rk5TK1FsWHU3NmcwcDdW?=
 =?utf-8?B?TGRJM3NMZ3BlUU9LYks5TkxDTEwxZkdUOHE3c3dUUGtJeWxHa056SUpRdTMy?=
 =?utf-8?B?aW9INHY4Vm9QK0NSSTlkc3hNM1JYTXVjZExTZkxNUEtjbzJKd0pXTTIybWM5?=
 =?utf-8?B?ZVZKZStBcTFzZXJuZG91VG9QanU3T1BkK0tVVkRKZXBPT1UrNDZmeUR5bWtB?=
 =?utf-8?B?WDVQSXVHQllheG1mSUc1TWZBZlBTeTVKeGdiNjR3SjZmOUdyQnRzODhxRmlr?=
 =?utf-8?B?WnN5UE9CSkNoUXBDQ1BhUTZYOE96WGd2ZDY0ZTVvMENpTXhVblE5cm9ad2hy?=
 =?utf-8?B?b2NiTWd6b0o5aGp4bUl1WWJlSVFsbFo0OWRxWXJ2Z0FaY1IzK2txaGxPSWs4?=
 =?utf-8?B?MGZjVUdDN2d2MHNKMXc3UHFzZ0hiT0VKQnoyb1BBQklMOFdKTzlVTjVsai9r?=
 =?utf-8?B?bjB3dHZwTEZXQWhYWmQ4WEQzd0xHRTh6bnVMamVIZ0ZtblVOK1QvYVFXcTN6?=
 =?utf-8?B?dkVmRkNvZHhzYXFWZmpnV0dVTzEzQW1NLzFMNittWE5pbGtTeDJhYTZkK3dO?=
 =?utf-8?B?U0hQcklrY2J1SDRtdHc1Y0Yxc1drc1NJS3RRelFiWE5DNmJKNnRRTjh5MG5L?=
 =?utf-8?B?YWJCVWY0amo3Y1RERW9NenljVEpCT08vcXFzck9nMjA5UGJhMVg5S1pISjho?=
 =?utf-8?B?SnE3MEIzRzFOakxRTFFFeU1EQVVaOS9zZGsxdGp3NzdJMENEZjdTZmVFamlk?=
 =?utf-8?B?M2I0b0p1K1lHOWZWQU1qUXJpcXJEc09WV2dUTUhqSzNKVkx2Tkd3WkdMdzVt?=
 =?utf-8?B?aUhSSmFnTjNwQlhrOVE0Um5Nam5iMWZYTng2d1FsNUd3K29zTzNxb2JZMzdz?=
 =?utf-8?B?VGkzQWFpajhaZWFFdFFtMU1PZFNJMnhsUzVZbFJjZjVISTRWMmExclpmL2hR?=
 =?utf-8?B?NHEvTkhkazVJcVFpQmQxejhiZ1J1RDYyYlNmR0R4MUgzS1dlcUhxalAzVjll?=
 =?utf-8?B?dHRsV1VoMWZqcU9LalpYR0lMaURKcUwwYXllanBEYWVNeFlnNnB6UFE1TWw0?=
 =?utf-8?B?QmhDNWR4L3ppdWhMQjFoNUtTQUhiTkVnT082N0RFQjhUazlZNGRwMm84djh4?=
 =?utf-8?B?UnhJRGZJdFBreDR0Nm02Yjh5eHpMd3lGaFVyUytnd1AzdnYrcExvQzNSVk44?=
 =?utf-8?B?QUF5V2ZNUG8rRnVHUzM5bURoOTFXcnFqRnJ6eU95WC9jSURlWmhKWEVFd281?=
 =?utf-8?B?cnc5bHRUbG9qdE9CcXZPU2tpcFpUWmE3ejBMbnBlaVBGMG5DRVZ1V1dxYWpH?=
 =?utf-8?B?bW44aFJIYWlMVTI5RDdUNURvTGFsa2JEaHlnejhiSlRxSmhFTHlLTmsyakpO?=
 =?utf-8?B?VkVZVVZFaGk1YVFuRFUyTS81dTladDVQaUowR1Z0T3ZaUkEwbFBUb0o5OTAw?=
 =?utf-8?B?alpzVDhRaWR5WXUxVHFpVkI1ZjNMaUFTa3MxVGhNVk82WFY4T3RUbWNvTGZa?=
 =?utf-8?B?TnQvbXRrYlgvMVdrWDZNM1NSdzZaMWFkbHRLa3NQdVJIT0tqUXhiWGt1Vzc1?=
 =?utf-8?B?akFhTjJXU2ticU44NEpJdDFnN2hyT1A2eG1ZTC9UeHdYcFhCcmZqYUY2eTN5?=
 =?utf-8?B?OUtqK1plMTNvdEFLQ2tsUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4447.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTl3bTV1R3BqVWR1dnBESGZRZTZUOSswdUZtOEc1bG16bGZ6cG13end2a1Mr?=
 =?utf-8?B?N09Ob1R2V09nZWtWcStSTzFMbDNxcW1uQjdTOThzcDBwR0tTdnJHSlArMUNt?=
 =?utf-8?B?dS9EQlhQcHRzZStMQVRHVjU1WVk3MzNLTUZaZmNzUUFBVENNbCtJQiszdUsx?=
 =?utf-8?B?eVBoV1A3UlB2dnpTU2lsOHV1VVN2NFJBV1V6ZlFmYllkMHlZbFBDUWd2ajBo?=
 =?utf-8?B?NUlMV2R3SHh2UURRUzFyUHdmQXk0UGhUcE8yWTRlNDk5WXF5V1cwVXNZbURH?=
 =?utf-8?B?cGxGVXNYTVEvUHBRbHRKeWVZZVUySWsxUnVXZlh0bGdpUDd6V09IdVc4a0Rl?=
 =?utf-8?B?eVRsYzNjSDNrdXB0MEpIQ1UxSWpEYjlxZE8xNThacDZPVWZiQndhRFdCdm51?=
 =?utf-8?B?NFRnRlhTRDNDNmpmbDIzNThCRjRwVHB2YUZaNWJEUmkwRDFzV1UvL2NyZlVJ?=
 =?utf-8?B?elFtMXViejMzclBvdEQ3cVBFSWN4cDBWL0N5Ym55NGJSdEVDYzNxa3hNQlVC?=
 =?utf-8?B?M0NnMGtqRDdzWTFZK2tCMmJkcUF2YnpFQlMwN2RxSTB4S0NCekZSZVZwOU16?=
 =?utf-8?B?ekxKVUhkOEQydTl6d1d5V0FNMUh5bHJKT3V1dFQ5WlVTQlRJY01JY0ZvRW5o?=
 =?utf-8?B?YWhIU3phdExqTkl6cW4vYzdQZExCYityWTdHQStuVWlJUDE0ZUpnSXJyVnU1?=
 =?utf-8?B?d2FaZ1pRM1NQS3ZBLzVUd08zVTBDQWFqOTZtR3NVditFekFGd3NhQlV6aHBr?=
 =?utf-8?B?b0dTcm1BcnVKUytVelB6OGNibVI5S0ZGY1prbVJ1NmZwRUxvU2lSd08zSndm?=
 =?utf-8?B?WTdad2NvMGxHN1ZRY0thdWNNUkpxTFZQbithU2V1dXZVcEtqMEUvTEs1MEVV?=
 =?utf-8?B?cXRLZWpuUXFLbWdWVVkranZvVDJXekxUd25kVnZNV01Lc0FlK1pZK29OZGwz?=
 =?utf-8?B?YVRJQURkSjdVTHFNQlRzVTkwMVJ1NFpvR1BLNVlzV1pVMVIrcVgxK3R4R09s?=
 =?utf-8?B?RHRiWjJ3SExCcDM3SW44WjNvby83UW1QZm5PcDE4L2lDVDNhRUh6c1E2Ym56?=
 =?utf-8?B?MmQzemxtUmhCYU5mbkR2dWkxWHc4aDZPVFVlekZJT0lCUVFFNERpVHRaalVO?=
 =?utf-8?B?ZjVmVkZxbmVxejBtM0l4Q1ZtY21VOHppS01kYlRUT25nTlcvR1JqN3N5STdZ?=
 =?utf-8?B?MTBwMzErcXVYQzRaVTg1N3E5NzYxVmhxZm9KeXlYOFdhdWRudlNaSG5MUjdG?=
 =?utf-8?B?Z2pLUS9SV0FXblliMStzUnJoQjNFVmNMMmlnbDMvS1dlNlNCbmJuVVQ5OFhX?=
 =?utf-8?B?NzVIcUIzOGNmeTBZV2Y5OThkS0Q5QnR1RGxKMGdGdENSTWZ4T2JWZTlwMXFT?=
 =?utf-8?B?TFpqUHJnTzkvVGlmekdYc2N0ZFZxSTd2Nkt4VnltZDR6MWVndHJGNURnWkkv?=
 =?utf-8?B?RHpTVlBlYXBZZWdTMVJZaHhpQk1paklUc3hhTU1sTGhoaFFNd0FNTFMrNjlU?=
 =?utf-8?B?cFJvdUZuQVpDbnlWNzBGVk1iMEZYMUpFeE84VWxMTDBReXFzcnIvRVNKRHdX?=
 =?utf-8?B?MTluVlIzNGxsaDk4a1c0T1NCanpDQzZjT3FnMTdQbi82RENnR0NMNUNndG1L?=
 =?utf-8?B?dms1REQwcml0SkhHZ2dyaDNrckVVVFQ1VzdzRnlET3BNQkVwTUVVNVJ0SmZB?=
 =?utf-8?B?UUdCbDFUVEN0aUZtT2Frb2VmZXpJdSt2dmdEV1VqT3haa1FaTlJhUGY5T2pF?=
 =?utf-8?B?U1lxYm9XR0JyZ2xpYXI3NlU5VjFsZ01nVnh1OHlFZmNIN2tnZVA3Mi9hNVFh?=
 =?utf-8?B?L1RsQitHWFgwb0ozMDFuV2pYcEpmdnplSkxKWlFPTHdvenUwZHNpbHRPc1do?=
 =?utf-8?B?bGRzcXkwMmRRNkZ2R1hCN2NKODg2ZVI4UGtBUWVnQ1dUUGVUcjRXUkRtcGtZ?=
 =?utf-8?B?YWRjQkdXTHBiR2JWSWVBNEFMUWtMTU9veFBxa25zL3RTUDJCbFR3S1VpRCtG?=
 =?utf-8?B?b29tVlhMMk9VaU1EU3VMUFRIbVlIbEdCQTJpbko3aUJEOCt4ZTdJdmYzbXk4?=
 =?utf-8?B?bDdtVGNHSlFRVDNyL2ZRcEFrTlZnUklRWDA1L2ZrNFZNS2hPc2pDRkJ5eFYz?=
 =?utf-8?Q?lNNSsxO7R6LNaM6/JpbgFzAYJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca92eab-0307-443f-38ed-08dcc83f5a2c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4447.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 15:29:20.2949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltdHCbigj65HfFlgYuWu6AfEzplsd/DfqM5xKaR+lejJxEuCJ3j+6Q5hO2wLfmnuO6GM/odW1OzLHBt+ozWPpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6571

Hi Boris,

On 8/29/2024 8:24 AM, Borislav Petkov wrote:
> On Thu, Aug 01, 2024 at 03:56:37PM -0500, Pavan Kumar Paluri wrote:
>> +#include <linux/memblock.h>
> 
> What's the idea of adding some random include here?
> 
> Does this file use memblock?
> 
> I don't think so.
> 
> You need to resolve include visibility by including the headers where you need
> them:
> 

Understood, will include *only* those headers that provide me with the
facilities as you mentioned.

> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index dd302fe49f04..d3e7f97e2a4a 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -8,6 +8,9 @@
>  #ifndef __ASM_X86_SEV_COMMON_H
>  #define __ASM_X86_SEV_COMMON_H
>  
> +#include <asm/cache.h>
> +#include <asm/pgtable_types.h>
> +
>  #define GHCB_MSR_INFO_POS		0
>  #define GHCB_DATA_LOW			12
>  #define GHCB_MSR_INFO_MASK		(BIT_ULL(GHCB_DATA_LOW) - 1)
> diff --git a/arch/x86/virt/svm/cmdline.c b/arch/x86/virt/svm/cmdline.c
> index 507549a9c793..f0a532108f49 100644
> --- a/arch/x86/virt/svm/cmdline.c
> +++ b/arch/x86/virt/svm/cmdline.c
> @@ -5,11 +5,8 @@
>   * Copyright (C) 2023 - 2024 Advanced Micro Devices, Inc.
>   *
>   * Author: Michael Roth <michael.roth@amd.com>
> - *
>   */
>  
> -#include <linux/memblock.h>
> -
>  #include <asm/sev.h>
>  
>  struct sev_config sev_cfg;
> 

With the above diff applied, I was observing the following compilation
errors relating to string header:

arch/x86/virt/svm/cmdline.c: In function ‘init_sev_config’:
arch/x86/virt/svm/cmdline.c:20:21: error: implicit declaration of
function ‘strsep’ [-Werror=implicit-function-declaration]
   20 |         while ((s = strsep(&str, ","))) {
      |                     ^~~~~~
arch/x86/virt/svm/cmdline.c:20:19: warning: assignment to ‘char *’ from
‘int’ makes pointer from integer without a cast [-Wint-conversion]
   20 |         while ((s = strsep(&str, ","))) {
      |                   ^
arch/x86/virt/svm/cmdline.c:21:22: error: implicit declaration of
function ‘strcmp’ [-Werror=implicit-function-declaration]
   21 |                 if (!strcmp(s, "debug")) {
      |                      ^~~~~~
arch/x86/virt/svm/cmdline.c:13:1: note: include ‘<string.h>’ or provide
a declaration of ‘strcmp’
   12 | #include <asm/sev.h>
  +++ |+#include <string.h>
   13 |
arch/x86/virt/svm/cmdline.c:26:17: error: implicit declaration of
function ‘pr_info’ [-Werror=implicit-function-declaration]
   26 |                 pr_info("SEV command-line option '%s' was not
recognized\n", s);
      |                 ^~~~~~~

So here's the updated diff (for patch #1) that is compile-tested:

diff --git a/arch/x86/include/asm/sev-common.h
b/arch/x86/include/asm/sev-common.h
index dd302fe49f04..d3e7f97e2a4a 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -8,6 +8,9 @@
 #ifndef __ASM_X86_SEV_COMMON_H
 #define __ASM_X86_SEV_COMMON_H

+#include <asm/cache.h>
+#include <asm/pgtable_types.h>
+
 #define GHCB_MSR_INFO_POS              0
 #define GHCB_DATA_LOW                  12
 #define GHCB_MSR_INFO_MASK             (BIT_ULL(GHCB_DATA_LOW) - 1)
diff --git a/arch/x86/virt/svm/cmdline.c b/arch/x86/virt/svm/cmdline.c
index 507549a9c793..be3504a601c0 100644
--- a/arch/x86/virt/svm/cmdline.c
+++ b/arch/x86/virt/svm/cmdline.c
@@ -5,10 +5,9 @@
  * Copyright (C) 2023 - 2024 Advanced Micro Devices, Inc.
  *
  * Author: Michael Roth <michael.roth@amd.com>
- *
  */

-#include <linux/memblock.h>
+#include <linux/string.h>

 #include <asm/sev.h>


And for Patch #2, here's the diff:

diff --git a/arch/x86/virt/svm/cmdline.c b/arch/x86/virt/svm/cmdline.c
index 9cec2c2fb67c..5880df8027e6 100644
--- a/arch/x86/virt/svm/cmdline.c
+++ b/arch/x86/virt/svm/cmdline.c
@@ -8,6 +8,7 @@
  */

 #include <linux/string.h>
+#include <asm/cpufeature.h>

 #include <asm/sev.h>

If these changes look good to you, I will send a v2 incorporating the
changes.

Thanks for the review,
Pavan



