Return-Path: <linux-kernel+bounces-549812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40787A55785
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE92175CAA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B6E27560B;
	Thu,  6 Mar 2025 20:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hEPGfHuW"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665D62566F3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741293370; cv=fail; b=cIv7czTAfVgSYmthJDgbrKdN8ultnT/lcrBX9kiZ1U3SdA+s+Mdhnxj5TLK0pbG++PcVv0sRUy1eDoCohsEb/DGJxPDBZtQYYGJj0AcgFwTWzlWWtY9gcMjnwpHP560CjEHfVDsk8ka1fWjSSZE/s8zOYvg4HbWlNAE7Z7Tp+g4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741293370; c=relaxed/simple;
	bh=T4p9+jDEg4HHcqPNxzRwOfAX/csLWBr+KSmtDnry/EM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tauIKDK6Q1hq/Ivs4Iz326+3H4iIzX+HWFg+G/IiWk96+nUJwR28QUkP4ZgoGKnTCWYT6hVbz4t66MhOSAEG/8luifcj4cbIQySPUPMvtiFfrthQnSkxo/FZkw7yRpTdiCw+7AjKl8FYJ7jFDHZcJnm8T01HnisG1FRWL73nLuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hEPGfHuW; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mevgjFR/xmZf7WsMrZ4Ndsoh4qTPUe44qlQkgaL9R4UiIGcbaNJp+XDuTq3enhLzxy5YEONM7d7rlv2lVTed365E9Bb2wZHwz/JUmaxGdm+ZAJz5acg+zsYCuVm7p/Jk9tMDgOjV12JVwbZ0pynRKKdIWUQieOJmHA988DBMzS+ZxU1svsDihqhqMh0LRtx+fkV/yD5u+Vzhg+6tqrK0YKIlIp9pMPFUbX2uwwVnBF5RrwpsPuhDER73bp3j63xHTU87yb3dsCbLUrgmlTwDftyj72Q9aJrHJWygDFZKLzFeWtG3vFX43PzzHOfwjQVYCM4LZdgfTN653F77JRIWuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdN2QAqeiGRJm6yNUN5410tS2ys25sYzARFJSnrJlss=;
 b=g2JrRdjkgfFSTB7zLoycBK1H1YC+mSx0OxFAH6aez/H+RQntqAI69r7HKsfcPduVMcw8K4TO/pZwTQBH1gwFi/3Xy9jr6cRd8w4FJ5b5ckQ0QPzfibYH/Y8H9kuwb5kMhvpyMiXlu7LWzSGkjHAlEM3MurHkQQobuFbP3eiYYxqCvekyu5Bra6bWDXbmGelzkX6liBpPzIDxmjgXa0tt2icJdYavDV6zQ8pINX4QfAd0JMC0PrC4ZtjLQBNeEnh7Q5OmbO/Y+Hs4FmoCGplonyaGSx9+Y3ptZDAJhjoAIIi+jHVLOkCWc28Olyzy+TwsNxCVVeixZ9b4nNpYeK2xWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdN2QAqeiGRJm6yNUN5410tS2ys25sYzARFJSnrJlss=;
 b=hEPGfHuWBGDK9Okr1730PL7l/OtNCl1yHgTKOGT3YgmyLzurtEVQuo0GVWIgfk7+WwNyoWFFxZjXKrDFJfSd1XCEzfPWv0zuYU62CgLfybDW5TlHg2ZW1tFQksTtrH60RXDAnd3mCMj1Cp5dnXo3SBrOlirIF648khByJf+PIWl22s6/yFcEhppxC0NET29CGSGgvnVcJF9VvaQKtzMi2aOFEHgjeGBS8btBJPd4y+D1Gvq9ZNTU1t4VjS2jzx+Sz+252dR2pWCYKRKStFhjkFqgY/L9pinF/dSSoPh9QF8+LFin2q4fsfKnYUJbn60dolZ1iML+GZoKJRn79npI7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 IA1PR12MB6233.namprd12.prod.outlook.com (2603:10b6:208:3e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 20:35:53 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 20:35:51 +0000
Message-ID: <901c5cca-9a9b-4c45-b7bd-e7ce48c39282@nvidia.com>
Date: Thu, 6 Mar 2025 12:35:48 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 45/49] x86,fs/resctrl: Move the resctrl filesystem code
 to live in /fs/resctrl
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
 Shanker Donthineni <sdonthineni@nvidia.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-46-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-46-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0042.namprd08.prod.outlook.com
 (2603:10b6:a03:117::19) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|IA1PR12MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e1b1ea5-05f9-4793-3629-08dd5cee7c35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEhTb21INDJSRkE3MVNUSFIyNk1palBoQmpOa0NXeGtSbUtwSEtzTzdIbE1S?=
 =?utf-8?B?QWNVSWszRG1zM3pFMWJPWHg5eml0emlDQWxLWjd5Q09UNUEycXpDZVo3ZURh?=
 =?utf-8?B?VGtXNkV1YkgxbG5GVStpWjRrdzRKOThuNVIxZmFtS2RvYmtNR0dGUW9yTGZs?=
 =?utf-8?B?dHo1YzN3UitnUkNLdWdveCtJd2FwbFpIaVlFcFpveVFzS3hiMU55MUZqY3do?=
 =?utf-8?B?VmM0Ty9MNXZXVGZiUzFvbDNLcmhKMWhMK1JhK2JMRlV3anZGVFVzMlIxVy92?=
 =?utf-8?B?dmN1UEdOeUJTRTFBODlKb05yUFFDTVdIN3B5UXd5RXB3UG91dUFsVnpsUHVB?=
 =?utf-8?B?Q2RUMkNFaWR1SlY1SEVWeTlMNGFvbktKSXA2b0xGTisyZitFZ2p5TkNlam50?=
 =?utf-8?B?bWxueHhDK2xoOWxMNW5xYk9OajRVcHZHMzhyRWJhZVdtODVPUktIaFFvdWhi?=
 =?utf-8?B?RCtYanJXWXNhK20raWk4Zzh2RnFHZzdQTEZCdFFFMTNpNk9HZXcvZjNISHA2?=
 =?utf-8?B?bDkvcmJvZFhoOHFjb3lRcnROOXg4RVpKdTBCMFM4N2E2UE55QkVRNHJ0dC82?=
 =?utf-8?B?MFdPV3QxWnd4TjVGbUk4czdrTVBuQXNETXBoTXk0UEhmNmFOK3ppdFI2Szkz?=
 =?utf-8?B?N3dBTENKcDdEVnZXaGtiaUZCNGNCcVhOR2wxdDl0SkVrMUpGMEZrL2w5d1lK?=
 =?utf-8?B?cEdhUUJ5VmdRa2VVcjR4QTNaT2MwWjRFSFA3bGpQdHJIN21EK2x3RGdXMmYz?=
 =?utf-8?B?RnVxdjBKbFZGZXJwem1Tc3J1M1Mwa3FzT0ROazZMNisrOFhMbjEvaVdTNHVX?=
 =?utf-8?B?RmdScHk3RTZLTnhRZy9zN0I2VHc2eUNEU1o1ZlduV1l2Zm5wdTM4VjhiY3Jh?=
 =?utf-8?B?L2NRMWJjQ1lIak8vZVdkOE1HRzkxeXY4N3NlN2R2WGE3MDgvMHN3TWZPSm1W?=
 =?utf-8?B?eElIVVFWZE1kZitnYm13NEYrTnRBSFQ0YlRmSVhQaFVIVzJjdU5FMGpGTi9l?=
 =?utf-8?B?U3dXdmg2NzJMUlNZbDVaS2VXUTVRV0I0L2xqZmdPR29jQnhLaFAyVHc2NVBs?=
 =?utf-8?B?RDllNDJ3L05xaHdWWTdzYnBYdE9hNzdOMG52NE01Qm1mV2JYUWNWTUFJZ3Vt?=
 =?utf-8?B?cnFwTmtNZllGbHEyYm9OZm9qZUhwTEx4Y0RNSlN4MjJIZDdUSjduc1AyMllh?=
 =?utf-8?B?LzBNWUE0MXNrd2hvWUoxUXN2ZTUvdDlReEduYU9HODJmSU4rQjY0TzhMSUp0?=
 =?utf-8?B?aXRrNk53L2w1NzZrVjFrNlVQSDR0Qlc4OUxEMXZaeFlXREYzdGF0bFg4dTMx?=
 =?utf-8?B?WnVvQVduTjIzNXJ2NElYZlhQV2hSS0Y4Q3BZQXBqV1A0djV2ZVR1RWNyUERN?=
 =?utf-8?B?cTdpdGhqMG9jL3dLN1dlVEZaNXI4WVMrWUEzRHhsQTRWNUNkY0ZHN1FCaUsw?=
 =?utf-8?B?WG1aUkx1YTVMdElmaVNXWUZqTm9rWXBaN2lBRkt1N3FpVmJwMGlRc1hOQjNy?=
 =?utf-8?B?OGgzVTQwZlp4YVJ2VGlRZTdOOUE5WEtYTTJ4VXZqdng4blh5cFNSeEFDYzV6?=
 =?utf-8?B?SU1FZzZpRFYyK05aRXNjMlVLN04wbGZtbDg4TDU5VDhEdysvRElOcFlMbUl4?=
 =?utf-8?B?ZllGRHhEVW5QVTlJUVR4SVdqUHRYMjF6SWdxdm10SUVkUWo4ZkExMVpMdFJL?=
 =?utf-8?B?MkhlclpYS2I5cDd0NWI0SFNKUGgwWW1BY2pvQ2JEMkoxVHBGc2owbUJUR3lV?=
 =?utf-8?B?S1A3MkFKalVkTHErWGhWcXdDSlNoZkxOOURwUElIdytiVWx2M2ZBUXhFTURC?=
 =?utf-8?B?QUpPNWNPNGZtdzBOU0l6WmZ2TW9BdHZlQURvR0RQWVU0ak1Sd2RQRXJURmF6?=
 =?utf-8?Q?qb6HYpZ+mjYBp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3o3MS9ZdGE2TkxPdVByVjkrS2JHaTNpT09wdmNseXN5ekxwTmRHSTN6TXZC?=
 =?utf-8?B?aG1XMnY5U01RNGpaTU5XTE1rajh0WUozY3JqMklMWDRtQlRycG1yNEQ3aDFk?=
 =?utf-8?B?ZVQ4aXlDMmdMeElKYVNNM21NbUVrekFDM1ViNmIycm1VUHhZQ294MFgrL0Jj?=
 =?utf-8?B?SExodzRjaWZ3cFdpemFyM2RSL2Z6RG92L0xZN2JLRzkrcklzSnRhVkg2RFpm?=
 =?utf-8?B?eEMzTEJCOWVNT3lLUm9sVUszY3ZFakxKdzR3MUIxeFR5QWE5Si9WNWFWZkdD?=
 =?utf-8?B?aGFOWDFyeDhRM0JqbmNMS25wQ3Z4YWRDUXBOR2JOZDlSclZuVmxIMlgzby9t?=
 =?utf-8?B?V25YRTR0MExMRVZMb3YxdFcxTGhQbXRPZ1pURUVQV3gyWTBTYVM3YkY5Y2xV?=
 =?utf-8?B?bHM4NU1kdTJyUVhTZHR2SnRuekFMc01yTVVjekNDOTRWb2tFWGt4NXVsQnF2?=
 =?utf-8?B?OFdoRDU2RTdFRlI0STRUQjJrZGo4Q2tnQUxZMEpFUVdqeTlReER6YjhNaHZB?=
 =?utf-8?B?MU1rUDFDUkcrSzUyMkYwUWE3SGlNUlZmaUNlTGhOKzlLUGtZdDFlUTg1M0dI?=
 =?utf-8?B?dlJkaEYvRGZsVXFXa1d1YkNFWmwrZDdwYVVsTVhPOHF4QTdaUjJIQmJ1N291?=
 =?utf-8?B?RTBnVE9hZWRHQ2xGMlk1a0RKRE9UMjNQcVp1OHFRVWEvZ0h6Wk1hd3lWU25q?=
 =?utf-8?B?dUl6YVlYNThUUmRCZlhSRTlvUXdSRy9PVTBMcHppamM2amZXZ3NzZjRxZ1dZ?=
 =?utf-8?B?czU4U2xlcXVmR3d4UlZZa0UrK2t2aFhHTFJIVjhaMnVYVnZrUW5qbUdndUMz?=
 =?utf-8?B?R2NKbHNGRGk5VnF5UC9SYXhzMjhHa29Ebm9ucUtPYkdYaVEzU2RrUUlHeGNz?=
 =?utf-8?B?RS9ab0F4VFdGUzRPUm9HRWFiZ3djWm1oZ2ZtRjdlVGJaUVhVRnd1OEFNc2pz?=
 =?utf-8?B?dnBXZ0NjeWJ1cForNUpjQUtVanFYb1ZDMnBDdUZRakRlM2FmVGZQaFFMVG92?=
 =?utf-8?B?bzJTVUQ4cko0VFBmZjgzVWRXaFd5Yi9aWUtMa2xTZ21rdys0VUhUYXdVeXRz?=
 =?utf-8?B?eWVxV281M0U5SzBjejEwRmRtbHA3STN0dnBMT2lOL2l5cDNZQjcrT1p3L1dX?=
 =?utf-8?B?SDFOTSttangyMEpPWXhKNHcvWVZaYVUrbjlIYXNlVjlFd1F3YnVMTEtoa2sw?=
 =?utf-8?B?ekZEMzNrLzN5TXlCdzNKV3NrQVBvS3hRbUpLT2pwdU1FWWxtYjBLUUQxOTRN?=
 =?utf-8?B?ODU3UHVMVTJEUXFHL3ZlSnZpSityS2NYUVJ4RGJtRTF4cU5MWS9aK3hzWlJI?=
 =?utf-8?B?YkhXdU1YSTRTYVFqQ0grZThRY3lzNUMybUY2M0YvN2hUOFdNeWN6cFZVZjlk?=
 =?utf-8?B?UHQrQ0w5UEFKVy8rMUxMeHovbnVXWUtWRTlMckRHMWpxenZCSHQ4Tk4xbzhn?=
 =?utf-8?B?NWF3TEdXMm9ITHNjMnFLb3ZLa1F0anlmbDMvWUdKTlRoVE5FUURJSnRVQitZ?=
 =?utf-8?B?SHoxMVppN3o5RkZQQlNrK284YW1PS1NQaVVobVo5bC9SUnYxbHFOZVhLNDU4?=
 =?utf-8?B?aEFzK0lKYXdBSzJTY0NYenV1VmFEZThkaW44S3BFQ2NFWVNtNzcydGl3R1pl?=
 =?utf-8?B?eUkrWVRadkJ6TkJtSzZhQlpqWVVPeDBFWlA2ODJSY3AydUFJVWtFWGgxLy9v?=
 =?utf-8?B?Z2cyR2RwNTlyZENFc2xDM3dzYndHeEcwYzRlSEpxdVdTQmFFUkxYTkcrNDdU?=
 =?utf-8?B?bUppOTdnNXFkTUVhUnhIS29DUjJNQVBicUlOaUJNSzMwZ1psS1VoTG55NDVq?=
 =?utf-8?B?dXNseGVXaVBybkR1WlJkZUlJSTFRZFpsUnVVdGtudGpGbDVJUEFqL3h4Z0g5?=
 =?utf-8?B?bVh2eTNNNERZSERndlpWT0dHZGZDZXlsMGlsQyt0SUF5SC9OL2pmQWt1eExh?=
 =?utf-8?B?UmZUTGpQV1BxR2tJL1JCRVpRY1JZSTRBWEpnTmpUY2ZjQXduS1hTUnRnK1ds?=
 =?utf-8?B?dlZzK0YxVEk5N0I5OVNjS09rZUkxdzBJSkJqVXByRlFmZ29xd3A2RDY5alFI?=
 =?utf-8?B?MGs2QWNlSXVZNUYzL1F4WnhpbGRWQURTOCtESXpJelo2SXMvK3FkTDZqa0s1?=
 =?utf-8?Q?NW5wVngPAf0ORTmIK1eBpX6tI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1b1ea5-05f9-4793-3629-08dd5cee7c35
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 20:35:51.4897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ADHHc1zmDx7czXjOYS8Vd54hltJm6g6YQELD5fOAS+ez7vV1JzqeTh1SFhYB9jIhkTBwus8KKrk/cDWDTDeJpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6233

Hi, James,

On 2/28/25 11:59, James Morse wrote:
> Resctrl is a filesystem interface to hardware that provides cache
> allocation policy and bandwidth control for groups of tasks or CPUs.
>
> To support more than one architecture, resctrl needs to live in /fs/.
>
> Move the code that is concerned with the filesystem interface to
> /fs/resctrl.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v6:
>   * This patch is new.
> ---
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |  636 ---
>   arch/x86/kernel/cpu/resctrl/internal.h        |  373 +-
>   arch/x86/kernel/cpu/resctrl/monitor.c         |  905 +---
>   arch/x86/kernel/cpu/resctrl/monitor_trace.h   |   18 +-
>   arch/x86/kernel/cpu/resctrl/pseudo_lock.c     | 1074 +---
>   .../kernel/cpu/resctrl/pseudo_lock_trace.h    |    2 +
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 4294 +---------------
>   fs/resctrl/ctrlmondata.c                      |  660 +++
>   fs/resctrl/internal.h                         |  435 ++
>   fs/resctrl/monitor.c                          |  935 ++++
>   fs/resctrl/monitor_trace.h                    |   33 +
>   fs/resctrl/pseudo_lock.c                      | 1109 +++++
>   fs/resctrl/pseudo_lock_trace.h                |   17 +
>   fs/resctrl/rdtgroup.c                         | 4329 +++++++++++++++++
>   14 files changed, 7535 insertions(+), 7285 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 159972c3fe73..0164d769aeca 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -23,270 +23,6 @@
>   
>   #include "internal.h"
>   
> -struct rdt_parse_data {
> -	struct rdtgroup		*rdtgrp;
> -	char			*buf;
> -};
> -
> -typedef int (ctrlval_parser_t)(struct rdt_parse_data *data,
> -			       struct resctrl_schema *s,
> -			       struct rdt_ctrl_domain *d);
> -
> -/*
> - * Check whether MBA bandwidth percentage value is correct. The value is
> - * checked against the minimum and max bandwidth values specified by the
> - * hardware. The allocated bandwidth percentage is rounded to the next
> - * control step available on the hardware.
> - */
> -static bool bw_validate(char *buf, u32 *data, struct rdt_resource *r)
> -{
> -	int ret;
> -	u32 bw;
> -
> -	/*
> -	 * Only linear delay values is supported for current Intel SKUs.
> -	 */
> -	if (!r->membw.delay_linear && r->membw.arch_needs_linear) {
> -		rdt_last_cmd_puts("No support for non-linear MB domains\n");
> -		return false;
> -	}
> -
> -	ret = kstrtou32(buf, 10, &bw);
> -	if (ret) {
> -		rdt_last_cmd_printf("Invalid MB value %s\n", buf);
> -		return false;
> -	}
> -
> -	/* Nothing else to do if software controller is enabled. */
> -	if (is_mba_sc(r)) {
> -		*data = bw;
> -		return true;
> -	}
> -
> -	if (bw < r->membw.min_bw || bw > r->membw.max_bw) {
> -		rdt_last_cmd_printf("MB value %u out of range [%d,%d]\n",
> -				    bw, r->membw.min_bw, r->membw.max_bw);
> -		return false;
> -	}
> -
> -	*data = roundup(bw, (unsigned long)r->membw.bw_gran);
> -	return true;
> -}
> -
> -static int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
> -		    struct rdt_ctrl_domain *d)
> -{
> -	struct resctrl_staged_config *cfg;
> -	u32 closid = data->rdtgrp->closid;
> -	struct rdt_resource *r = s->res;
> -	u32 bw_val;
> -
> -	cfg = &d->staged_config[s->conf_type];
> -	if (cfg->have_new_ctrl) {
> -		rdt_last_cmd_printf("Duplicate domain %d\n", d->hdr.id);
> -		return -EINVAL;
> -	}
> -
> -	if (!bw_validate(data->buf, &bw_val, r))
> -		return -EINVAL;
> -
> -	if (is_mba_sc(r)) {
> -		d->mbps_val[closid] = bw_val;
> -		return 0;
> -	}
> -
> -	cfg->new_ctrl = bw_val;
> -	cfg->have_new_ctrl = true;
> -
> -	return 0;
> -}
> -
> -/*
> - * Check whether a cache bit mask is valid.
> - * On Intel CPUs, non-contiguous 1s value support is indicated by CPUID:
> - *   - CPUID.0x10.1:ECX[3]: L3 non-contiguous 1s value supported if 1
> - *   - CPUID.0x10.2:ECX[3]: L2 non-contiguous 1s value supported if 1
> - *
> - * Haswell does not support a non-contiguous 1s value and additionally
> - * requires at least two bits set.
> - * AMD allows non-contiguous bitmasks.
> - */
> -static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
> -{
> -	u32 supported_bits = BIT_MASK(r->cache.cbm_len) - 1;
> -	unsigned int cbm_len = r->cache.cbm_len;
> -	unsigned long first_bit, zero_bit, val;
> -	int ret;
> -
> -	ret = kstrtoul(buf, 16, &val);
> -	if (ret) {
> -		rdt_last_cmd_printf("Non-hex character in the mask %s\n", buf);
> -		return false;
> -	}
> -
> -	if ((r->cache.min_cbm_bits > 0 && val == 0) || val > supported_bits) {
> -		rdt_last_cmd_puts("Mask out of range\n");
> -		return false;
> -	}
> -
> -	first_bit = find_first_bit(&val, cbm_len);
> -	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
> -
> -	/* Are non-contiguous bitmasks allowed? */
> -	if (!r->cache.arch_has_sparse_bitmasks &&
> -	    (find_next_bit(&val, cbm_len, zero_bit) < cbm_len)) {
> -		rdt_last_cmd_printf("The mask %lx has non-consecutive 1-bits\n", val);
> -		return false;
> -	}
> -
> -	if ((zero_bit - first_bit) < r->cache.min_cbm_bits) {
> -		rdt_last_cmd_printf("Need at least %d bits in the mask\n",
> -				    r->cache.min_cbm_bits);
> -		return false;
> -	}
> -
> -	*data = val;
> -	return true;
> -}
> -
> -/*
> - * Read one cache bit mask (hex). Check that it is valid for the current
> - * resource type.
> - */
> -static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
> -		     struct rdt_ctrl_domain *d)
> -{
> -	struct rdtgroup *rdtgrp = data->rdtgrp;
> -	struct resctrl_staged_config *cfg;
> -	struct rdt_resource *r = s->res;
> -	u32 cbm_val;
> -
> -	cfg = &d->staged_config[s->conf_type];
> -	if (cfg->have_new_ctrl) {
> -		rdt_last_cmd_printf("Duplicate domain %d\n", d->hdr.id);
> -		return -EINVAL;
> -	}
> -
> -	/*
> -	 * Cannot set up more than one pseudo-locked region in a cache
> -	 * hierarchy.
> -	 */
> -	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP &&
> -	    rdtgroup_pseudo_locked_in_hierarchy(d)) {
> -		rdt_last_cmd_puts("Pseudo-locked region in hierarchy\n");
> -		return -EINVAL;
> -	}
> -
> -	if (!cbm_validate(data->buf, &cbm_val, r))
> -		return -EINVAL;
> -
> -	if ((rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
> -	     rdtgrp->mode == RDT_MODE_SHAREABLE) &&
> -	    rdtgroup_cbm_overlaps_pseudo_locked(d, cbm_val)) {
> -		rdt_last_cmd_puts("CBM overlaps with pseudo-locked region\n");
> -		return -EINVAL;
> -	}
> -
> -	/*
> -	 * The CBM may not overlap with the CBM of another closid if
> -	 * either is exclusive.
> -	 */
> -	if (rdtgroup_cbm_overlaps(s, d, cbm_val, rdtgrp->closid, true)) {
> -		rdt_last_cmd_puts("Overlaps with exclusive group\n");
> -		return -EINVAL;
> -	}
> -
> -	if (rdtgroup_cbm_overlaps(s, d, cbm_val, rdtgrp->closid, false)) {
> -		if (rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
> -		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
> -			rdt_last_cmd_puts("Overlaps with other group\n");
> -			return -EINVAL;
> -		}
> -	}
> -
> -	cfg->new_ctrl = cbm_val;
> -	cfg->have_new_ctrl = true;
> -
> -	return 0;
> -}
> -
> -/*
> - * For each domain in this resource we expect to find a series of:
> - *	id=mask
> - * separated by ";". The "id" is in decimal, and must match one of
> - * the "id"s for this resource.
> - */
> -static int parse_line(char *line, struct resctrl_schema *s,
> -		      struct rdtgroup *rdtgrp)
> -{
> -	enum resctrl_conf_type t = s->conf_type;
> -	ctrlval_parser_t *parse_ctrlval = NULL;
> -	struct resctrl_staged_config *cfg;
> -	struct rdt_resource *r = s->res;
> -	struct rdt_parse_data data;
> -	struct rdt_ctrl_domain *d;
> -	char *dom = NULL, *id;
> -	unsigned long dom_id;
> -
> -	/* Walking r->domains, ensure it can't race with cpuhp */
> -	lockdep_assert_cpus_held();
> -
> -	switch (r->schema_fmt) {
> -	case RESCTRL_SCHEMA_BITMAP:
> -		parse_ctrlval = &parse_cbm;
> -		break;
> -	case RESCTRL_SCHEMA_RANGE:
> -		parse_ctrlval = &parse_bw;
> -		break;
> -	}
> -
> -	if (WARN_ON_ONCE(!parse_ctrlval))
> -		return -EINVAL;
> -
> -	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP &&
> -	    (r->rid == RDT_RESOURCE_MBA || r->rid == RDT_RESOURCE_SMBA)) {
> -		rdt_last_cmd_puts("Cannot pseudo-lock MBA resource\n");
> -		return -EINVAL;
> -	}
> -
> -next:
> -	if (!line || line[0] == '\0')
> -		return 0;
> -	dom = strsep(&line, ";");
> -	id = strsep(&dom, "=");
> -	if (!dom || kstrtoul(id, 10, &dom_id)) {
> -		rdt_last_cmd_puts("Missing '=' or non-numeric domain\n");
> -		return -EINVAL;
> -	}
> -	dom = strim(dom);
> -	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
> -		if (d->hdr.id == dom_id) {
> -			data.buf = dom;
> -			data.rdtgrp = rdtgrp;
> -			if (parse_ctrlval(&data, s, d))
> -				return -EINVAL;
> -			if (rdtgrp->mode ==  RDT_MODE_PSEUDO_LOCKSETUP) {
> -				cfg = &d->staged_config[t];
> -				/*
> -				 * In pseudo-locking setup mode and just
> -				 * parsed a valid CBM that should be
> -				 * pseudo-locked. Only one locked region per
> -				 * resource group and domain so just do
> -				 * the required initialization for single
> -				 * region and return.
> -				 */
> -				rdtgrp->plr->s = s;
> -				rdtgrp->plr->d = d;
> -				rdtgrp->plr->cbm = cfg->new_ctrl;
> -				d->plr = rdtgrp->plr;
> -				return 0;
> -			}
> -			goto next;
> -		}
> -	}
> -	return -EINVAL;
> -}
> -
>   int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_domain *d,
>   			    u32 closid, enum resctrl_conf_type t, u32 cfg_val)
>   {
> @@ -351,100 +87,6 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
>   	return 0;
>   }
>   
> -static int rdtgroup_parse_resource(char *resname, char *tok,
> -				   struct rdtgroup *rdtgrp)
> -{
> -	struct resctrl_schema *s;
> -
> -	list_for_each_entry(s, &resctrl_schema_all, list) {
> -		if (!strcmp(resname, s->name) && rdtgrp->closid < s->num_closid)
> -			return parse_line(tok, s, rdtgrp);
> -	}
> -	rdt_last_cmd_printf("Unknown or unsupported resource name '%s'\n", resname);
> -	return -EINVAL;
> -}
> -
> -ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
> -				char *buf, size_t nbytes, loff_t off)
> -{
> -	struct resctrl_schema *s;
> -	struct rdtgroup *rdtgrp;
> -	struct rdt_resource *r;
> -	char *tok, *resname;
> -	int ret = 0;
> -
> -	/* Valid input requires a trailing newline */
> -	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> -		return -EINVAL;
> -	buf[nbytes - 1] = '\0';
> -
> -	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> -	if (!rdtgrp) {
> -		rdtgroup_kn_unlock(of->kn);
> -		return -ENOENT;
> -	}
> -	rdt_last_cmd_clear();
> -
> -	/*
> -	 * No changes to pseudo-locked region allowed. It has to be removed
> -	 * and re-created instead.
> -	 */
> -	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
> -		ret = -EINVAL;
> -		rdt_last_cmd_puts("Resource group is pseudo-locked\n");
> -		goto out;
> -	}
> -
> -	rdt_staged_configs_clear();
> -
> -	while ((tok = strsep(&buf, "\n")) != NULL) {
> -		resname = strim(strsep(&tok, ":"));
> -		if (!tok) {
> -			rdt_last_cmd_puts("Missing ':'\n");
> -			ret = -EINVAL;
> -			goto out;
> -		}
> -		if (tok[0] == '\0') {
> -			rdt_last_cmd_printf("Missing '%s' value\n", resname);
> -			ret = -EINVAL;
> -			goto out;
> -		}
> -		ret = rdtgroup_parse_resource(resname, tok, rdtgrp);
> -		if (ret)
> -			goto out;
> -	}
> -
> -	list_for_each_entry(s, &resctrl_schema_all, list) {
> -		r = s->res;
> -
> -		/*
> -		 * Writes to mba_sc resources update the software controller,
> -		 * not the control MSR.
> -		 */
> -		if (is_mba_sc(r))
> -			continue;
> -
> -		ret = resctrl_arch_update_domains(r, rdtgrp->closid);
> -		if (ret)
> -			goto out;
> -	}
> -
> -	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
> -		/*
> -		 * If pseudo-locking fails we keep the resource group in
> -		 * mode RDT_MODE_PSEUDO_LOCKSETUP with its class of service
> -		 * active and updated for just the domain the pseudo-locked
> -		 * region was requested for.
> -		 */
> -		ret = rdtgroup_pseudo_lock_create(rdtgrp);
> -	}
> -
> -out:
> -	rdt_staged_configs_clear();
> -	rdtgroup_kn_unlock(of->kn);
> -	return ret ?: nbytes;
> -}
> -
>   u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
>   			    u32 closid, enum resctrl_conf_type type)
>   {
> @@ -453,281 +95,3 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
>   
>   	return hw_dom->ctrl_val[idx];
>   }
> -
> -static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
> -{
> -	struct rdt_resource *r = schema->res;
> -	struct rdt_ctrl_domain *dom;
> -	bool sep = false;
> -	u32 ctrl_val;
> -
> -	/* Walking r->domains, ensure it can't race with cpuhp */
> -	lockdep_assert_cpus_held();
> -
> -	seq_printf(s, "%*s:", max_name_width, schema->name);
> -	list_for_each_entry(dom, &r->ctrl_domains, hdr.list) {
> -		if (sep)
> -			seq_puts(s, ";");
> -
> -		if (is_mba_sc(r))
> -			ctrl_val = dom->mbps_val[closid];
> -		else
> -			ctrl_val = resctrl_arch_get_config(r, dom, closid,
> -							   schema->conf_type);
> -
> -		seq_printf(s, schema->fmt_str, dom->hdr.id, ctrl_val);
> -		sep = true;
> -	}
> -	seq_puts(s, "\n");
> -}
> -
> -int rdtgroup_schemata_show(struct kernfs_open_file *of,
> -			   struct seq_file *s, void *v)
> -{
> -	struct resctrl_schema *schema;
> -	struct rdtgroup *rdtgrp;
> -	int ret = 0;
> -	u32 closid;
> -
> -	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> -	if (rdtgrp) {
> -		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
> -			list_for_each_entry(schema, &resctrl_schema_all, list) {
> -				seq_printf(s, "%s:uninitialized\n", schema->name);
> -			}
> -		} else if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
> -			if (!rdtgrp->plr->d) {
> -				rdt_last_cmd_clear();
> -				rdt_last_cmd_puts("Cache domain offline\n");
> -				ret = -ENODEV;
> -			} else {
> -				seq_printf(s, "%s:%d=%x\n",
> -					   rdtgrp->plr->s->res->name,
> -					   rdtgrp->plr->d->hdr.id,
> -					   rdtgrp->plr->cbm);
> -			}
> -		} else {
> -			closid = rdtgrp->closid;
> -			list_for_each_entry(schema, &resctrl_schema_all, list) {
> -				if (closid < schema->num_closid)
> -					show_doms(s, schema, closid);
> -			}
> -		}
> -	} else {
> -		ret = -ENOENT;
> -	}
> -	rdtgroup_kn_unlock(of->kn);
> -	return ret;
> -}
> -
> -static int smp_mon_event_count(void *arg)
> -{
> -	mon_event_count(arg);
> -
> -	return 0;
> -}
> -
> -ssize_t rdtgroup_mba_mbps_event_write(struct kernfs_open_file *of,
> -				      char *buf, size_t nbytes, loff_t off)
> -{
> -	struct rdtgroup *rdtgrp;
> -	int ret = 0;
> -
> -	/* Valid input requires a trailing newline */
> -	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> -		return -EINVAL;
> -	buf[nbytes - 1] = '\0';
> -
> -	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> -	if (!rdtgrp) {
> -		rdtgroup_kn_unlock(of->kn);
> -		return -ENOENT;
> -	}
> -	rdt_last_cmd_clear();
> -
> -	if (!strcmp(buf, "mbm_local_bytes")) {
> -		if (resctrl_arch_is_mbm_local_enabled())
> -			rdtgrp->mba_mbps_event = QOS_L3_MBM_LOCAL_EVENT_ID;
> -		else
> -			ret = -EINVAL;
> -	} else if (!strcmp(buf, "mbm_total_bytes")) {
> -		if (resctrl_arch_is_mbm_total_enabled())
> -			rdtgrp->mba_mbps_event = QOS_L3_MBM_TOTAL_EVENT_ID;
> -		else
> -			ret = -EINVAL;
> -	} else {
> -		ret = -EINVAL;
> -	}
> -
> -	if (ret)
> -		rdt_last_cmd_printf("Unsupported event id '%s'\n", buf);
> -
> -	rdtgroup_kn_unlock(of->kn);
> -
> -	return ret ?: nbytes;
> -}
> -
> -int rdtgroup_mba_mbps_event_show(struct kernfs_open_file *of,
> -				 struct seq_file *s, void *v)
> -{
> -	struct rdtgroup *rdtgrp;
> -	int ret = 0;
> -
> -	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> -
> -	if (rdtgrp) {
> -		switch (rdtgrp->mba_mbps_event) {
> -		case QOS_L3_MBM_LOCAL_EVENT_ID:
> -			seq_puts(s, "mbm_local_bytes\n");
> -			break;
> -		case QOS_L3_MBM_TOTAL_EVENT_ID:
> -			seq_puts(s, "mbm_total_bytes\n");
> -			break;
> -		default:
> -			pr_warn_once("Bad event %d\n", rdtgrp->mba_mbps_event);
> -			ret = -EINVAL;
> -			break;
> -		}
> -	} else {
> -		ret = -ENOENT;
> -	}
> -
> -	rdtgroup_kn_unlock(of->kn);
> -
> -	return ret;
> -}
> -
> -struct rdt_domain_hdr *resctrl_find_domain(struct list_head *h, int id,
> -					   struct list_head **pos)
> -{
> -	struct rdt_domain_hdr *d;
> -	struct list_head *l;
> -
> -	list_for_each(l, h) {
> -		d = list_entry(l, struct rdt_domain_hdr, list);
> -		/* When id is found, return its domain. */
> -		if (id == d->id)
> -			return d;
> -		/* Stop searching when finding id's position in sorted list. */
> -		if (id < d->id)
> -			break;
> -	}
> -
> -	if (pos)
> -		*pos = l;
> -
> -	return NULL;
> -}
> -
> -void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
> -		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
> -		    cpumask_t *cpumask, int evtid, int first)
> -{
> -	int cpu;
> -
> -	/* When picking a CPU from cpu_mask, ensure it can't race with cpuhp */
> -	lockdep_assert_cpus_held();
> -
> -	/*
> -	 * Setup the parameters to pass to mon_event_count() to read the data.
> -	 */
> -	rr->rgrp = rdtgrp;
> -	rr->evtid = evtid;
> -	rr->r = r;
> -	rr->d = d;
> -	rr->first = first;
> -	rr->arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, evtid);
> -	if (IS_ERR(rr->arch_mon_ctx)) {
> -		rr->err = -EINVAL;
> -		return;
> -	}
> -
> -	cpu = cpumask_any_housekeeping(cpumask, RESCTRL_PICK_ANY_CPU);
> -
> -	/*
> -	 * cpumask_any_housekeeping() prefers housekeeping CPUs, but
> -	 * are all the CPUs nohz_full? If yes, pick a CPU to IPI.
> -	 * MPAM's resctrl_arch_rmid_read() is unable to read the
> -	 * counters on some platforms if its called in IRQ context.
> -	 */
> -	if (tick_nohz_full_cpu(cpu))
> -		smp_call_function_any(cpumask, mon_event_count, rr, 1);
> -	else
> -		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
> -
> -	resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
> -}
> -
> -int rdtgroup_mondata_show(struct seq_file *m, void *arg)
> -{
> -	struct kernfs_open_file *of = m->private;
> -	struct rdt_domain_hdr *hdr;
> -	struct rmid_read rr = {0};
> -	struct rdt_mon_domain *d;
> -	u32 resid, evtid, domid;
> -	struct rdtgroup *rdtgrp;
> -	struct rdt_resource *r;
> -	struct mon_data *md;
> -	int ret = 0;
> -
> -	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> -	if (!rdtgrp) {
> -		ret = -ENOENT;
> -		goto out;
> -	}
> -
> -	md = of->kn->priv;
> -	if (WARN_ON_ONCE(!md)) {
> -		ret = -EIO;
> -		goto out;
> -	}
> -
> -	resid = md->rid;
> -	domid = md->domid;
> -	evtid = md->evtid;
> -	r = resctrl_arch_get_resource(resid);
> -
> -	if (md->sum) {
> -		/*
> -		 * This file requires summing across all domains that share
> -		 * the L3 cache id that was provided in the "domid" field of the
> -		 * struct mon_data. Search all domains in the resource for
> -		 * one that matches this cache id.
> -		 */
> -		list_for_each_entry(d, &r->mon_domains, hdr.list) {
> -			if (d->ci->id == domid) {
> -				rr.ci = d->ci;
> -				mon_event_read(&rr, r, NULL, rdtgrp,
> -					       &d->ci->shared_cpu_map, evtid, false);
> -				goto checkresult;
> -			}
> -		}
> -		ret = -ENOENT;
> -		goto out;
> -	} else {
> -		/*
> -		 * This file provides data from a single domain. Search
> -		 * the resource to find the domain with "domid".
> -		 */
> -		hdr = resctrl_find_domain(&r->mon_domains, domid, NULL);
> -		if (!hdr || WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN)) {
> -			ret = -ENOENT;
> -			goto out;
> -		}
> -		d = container_of(hdr, struct rdt_mon_domain, hdr);
> -		mon_event_read(&rr, r, d, rdtgrp, &d->hdr.cpu_mask, evtid, false);
> -	}
> -
> -checkresult:
> -
> -	if (rr.err == -EIO)
> -		seq_puts(m, "Error\n");
> -	else if (rr.err == -EINVAL)
> -		seq_puts(m, "Unavailable\n");
> -	else
> -		seq_printf(m, "%llu\n", rr.val);
> -
> -out:
> -	rdtgroup_kn_unlock(of->kn);
> -	return ret;
> -}
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index a569e31d75f6..521db28efb3f 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -13,14 +13,16 @@
>   
>   #define L2_QOS_CDP_ENABLE		0x01ULL
>   
> -#define CQM_LIMBOCHECK_INTERVAL	1000
> -
>   #define MBM_CNTR_WIDTH_BASE		24
> +
>   #define MBA_IS_LINEAR			0x4
> +
>   #define MBM_CNTR_WIDTH_OFFSET_AMD	20
>   
>   #define RMID_VAL_ERROR			BIT_ULL(63)
> +
>   #define RMID_VAL_UNAVAIL		BIT_ULL(62)
> +
>   /*
>    * With the above fields in use 62 bits remain in MSR_IA32_QM_CTR for
>    * data to be returned. The counter width is discovered from the hardware
> @@ -28,275 +30,6 @@
>    */
>   #define MBM_CNTR_WIDTH_OFFSET_MAX (62 - MBM_CNTR_WIDTH_BASE)
>   
> -/**
> - * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
> - *			        aren't marked nohz_full
> - * @mask:	The mask to pick a CPU from.
> - * @exclude_cpu:The CPU to avoid picking.
> - *
> - * Returns a CPU from @mask, but not @exclude_cpu. If there are housekeeping
> - * CPUs that don't use nohz_full, these are preferred. Pass
> - * RESCTRL_PICK_ANY_CPU to avoid excluding any CPUs.
> - *
> - * When a CPU is excluded, returns >= nr_cpu_ids if no CPUs are available.
> - */
> -static inline unsigned int
> -cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
> -{
> -	unsigned int cpu, hk_cpu;
> -
> -	if (exclude_cpu == RESCTRL_PICK_ANY_CPU)
> -		cpu = cpumask_any(mask);
> -	else
> -		cpu = cpumask_any_but(mask, exclude_cpu);
> -
> -	/* Only continue if tick_nohz_full_mask has been initialized. */
> -	if (!tick_nohz_full_enabled())
> -		return cpu;
> -
> -	/* If the CPU picked isn't marked nohz_full nothing more needs doing. */
> -	if (cpu < nr_cpu_ids && !tick_nohz_full_cpu(cpu))
> -		return cpu;
> -
> -	/* Try to find a CPU that isn't nohz_full to use in preference */
> -	hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
> -	if (hk_cpu == exclude_cpu)
> -		hk_cpu = cpumask_nth_andnot(1, mask, tick_nohz_full_mask);
> -
> -	if (hk_cpu < nr_cpu_ids)
> -		cpu = hk_cpu;
> -
> -	return cpu;
> -}
> -
> -struct rdt_fs_context {
> -	struct kernfs_fs_context	kfc;
> -	bool				enable_cdpl2;
> -	bool				enable_cdpl3;
> -	bool				enable_mba_mbps;
> -	bool				enable_debug;
> -};
> -
> -static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
> -{
> -	struct kernfs_fs_context *kfc = fc->fs_private;
> -
> -	return container_of(kfc, struct rdt_fs_context, kfc);
> -}
> -
> -/**
> - * struct mon_evt - Entry in the event list of a resource
> - * @evtid:		event id
> - * @name:		name of the event
> - * @configurable:	true if the event is configurable
> - * @list:		entry in &rdt_resource->evt_list
> - */
> -struct mon_evt {
> -	enum resctrl_event_id	evtid;
> -	char			*name;
> -	bool			configurable;
> -	struct list_head	list;
> -};
> -
> -/**
> - * struct mon_data - Monitoring details for each event file.
> - * @rid:             Resource id associated with the event file.
> - * @evtid:           Event id associated with the event file.
> - * @sum:             Set when event must be summed across multiple
> - *                   domains.
> - * @domid:           When @sum is zero this is the domain to which
> - *                   the event file belongs. When @sum is one this
> - *                   is the id of the L3 cache that all domains to be
> - *                   summed share.
> - *
> - * Stored in the kernfs kn->priv field, readers and writers must hold
> - * rdtgroup_mutex.
> - */
> -struct mon_data {
> -	unsigned int rid;
> -	enum resctrl_event_id evtid;
> -	unsigned int sum;
> -	unsigned int domid;
> -};
> -
> -/**
> - * struct rmid_read - Data passed across smp_call*() to read event count.
> - * @rgrp:  Resource group for which the counter is being read. If it is a parent
> - *	   resource group then its event count is summed with the count from all
> - *	   its child resource groups.
> - * @r:	   Resource describing the properties of the event being read.
> - * @d:	   Domain that the counter should be read from. If NULL then sum all
> - *	   domains in @r sharing L3 @ci.id
> - * @evtid: Which monitor event to read.
> - * @first: Initialize MBM counter when true.
> - * @ci:    Cacheinfo for L3. Only set when @d is NULL. Used when summing domains.
> - * @err:   Error encountered when reading counter.
> - * @val:   Returned value of event counter. If @rgrp is a parent resource group,
> - *	   @val includes the sum of event counts from its child resource groups.
> - *	   If @d is NULL, @val includes the sum of all domains in @r sharing @ci.id,
> - *	   (summed across child resource groups if @rgrp is a parent resource group).
> - * @arch_mon_ctx: Hardware monitor allocated for this read request (MPAM only).
> - */
> -struct rmid_read {
> -	struct rdtgroup		*rgrp;
> -	struct rdt_resource	*r;
> -	struct rdt_mon_domain	*d;
> -	enum resctrl_event_id	evtid;
> -	bool			first;
> -	struct cacheinfo	*ci;
> -	int			err;
> -	u64			val;
> -	void			*arch_mon_ctx;
> -};
> -
> -extern struct list_head resctrl_schema_all;
> -extern bool resctrl_mounted;
> -
> -enum rdt_group_type {
> -	RDTCTRL_GROUP = 0,
> -	RDTMON_GROUP,
> -	RDT_NUM_GROUP,
> -};
> -
> -/**
> - * enum rdtgrp_mode - Mode of a RDT resource group
> - * @RDT_MODE_SHAREABLE: This resource group allows sharing of its allocations
> - * @RDT_MODE_EXCLUSIVE: No sharing of this resource group's allocations allowed
> - * @RDT_MODE_PSEUDO_LOCKSETUP: Resource group will be used for Pseudo-Locking
> - * @RDT_MODE_PSEUDO_LOCKED: No sharing of this resource group's allocations
> - *                          allowed AND the allocations are Cache Pseudo-Locked
> - * @RDT_NUM_MODES: Total number of modes
> - *
> - * The mode of a resource group enables control over the allowed overlap
> - * between allocations associated with different resource groups (classes
> - * of service). User is able to modify the mode of a resource group by
> - * writing to the "mode" resctrl file associated with the resource group.
> - *
> - * The "shareable", "exclusive", and "pseudo-locksetup" modes are set by
> - * writing the appropriate text to the "mode" file. A resource group enters
> - * "pseudo-locked" mode after the schemata is written while the resource
> - * group is in "pseudo-locksetup" mode.
> - */
> -enum rdtgrp_mode {
> -	RDT_MODE_SHAREABLE = 0,
> -	RDT_MODE_EXCLUSIVE,
> -	RDT_MODE_PSEUDO_LOCKSETUP,
> -	RDT_MODE_PSEUDO_LOCKED,
> -
> -	/* Must be last */
> -	RDT_NUM_MODES,
> -};
> -
> -/**
> - * struct mongroup - store mon group's data in resctrl fs.
> - * @mon_data_kn:		kernfs node for the mon_data directory
> - * @parent:			parent rdtgrp
> - * @crdtgrp_list:		child rdtgroup node list
> - * @rmid:			rmid for this rdtgroup
> - */
> -struct mongroup {
> -	struct kernfs_node	*mon_data_kn;
> -	struct rdtgroup		*parent;
> -	struct list_head	crdtgrp_list;
> -	u32			rmid;
> -};
> -
> -/**
> - * struct rdtgroup - store rdtgroup's data in resctrl file system.
> - * @kn:				kernfs node
> - * @rdtgroup_list:		linked list for all rdtgroups
> - * @closid:			closid for this rdtgroup
> - * @cpu_mask:			CPUs assigned to this rdtgroup
> - * @flags:			status bits
> - * @waitcount:			how many cpus expect to find this
> - *				group when they acquire rdtgroup_mutex
> - * @type:			indicates type of this rdtgroup - either
> - *				monitor only or ctrl_mon group
> - * @mon:			mongroup related data
> - * @mode:			mode of resource group
> - * @mba_mbps_event:		input monitoring event id when mba_sc is enabled
> - * @plr:			pseudo-locked region
> - */
> -struct rdtgroup {
> -	struct kernfs_node		*kn;
> -	struct list_head		rdtgroup_list;
> -	u32				closid;
> -	struct cpumask			cpu_mask;
> -	int				flags;
> -	atomic_t			waitcount;
> -	enum rdt_group_type		type;
> -	struct mongroup			mon;
> -	enum rdtgrp_mode		mode;
> -	enum resctrl_event_id		mba_mbps_event;
> -	struct pseudo_lock_region	*plr;
> -};
> -
> -/* rdtgroup.flags */
> -#define	RDT_DELETED		1
> -
> -/* rftype.flags */
> -#define RFTYPE_FLAGS_CPUS_LIST	1
> -
> -/*
> - * Define the file type flags for base and info directories.
> - */
> -#define RFTYPE_INFO			BIT(0)
> -#define RFTYPE_BASE			BIT(1)
> -#define RFTYPE_CTRL			BIT(4)
> -#define RFTYPE_MON			BIT(5)
> -#define RFTYPE_TOP			BIT(6)
> -#define RFTYPE_RES_CACHE		BIT(8)
> -#define RFTYPE_RES_MB			BIT(9)
> -#define RFTYPE_DEBUG			BIT(10)
> -#define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
> -#define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
> -#define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
> -#define RFTYPE_CTRL_BASE		(RFTYPE_BASE | RFTYPE_CTRL)
> -#define RFTYPE_MON_BASE			(RFTYPE_BASE | RFTYPE_MON)
> -
> -/* List of all resource groups */
> -extern struct list_head rdt_all_groups;
> -
> -extern int max_name_width;
> -
> -/**
> - * struct rftype - describe each file in the resctrl file system
> - * @name:	File name
> - * @mode:	Access mode
> - * @kf_ops:	File operations
> - * @flags:	File specific RFTYPE_FLAGS_* flags
> - * @fflags:	File specific RFTYPE_* flags
> - * @seq_show:	Show content of the file
> - * @write:	Write to the file
> - */
> -struct rftype {
> -	char			*name;
> -	umode_t			mode;
> -	const struct kernfs_ops	*kf_ops;
> -	unsigned long		flags;
> -	unsigned long		fflags;
> -
> -	int (*seq_show)(struct kernfs_open_file *of,
> -			struct seq_file *sf, void *v);
> -	/*
> -	 * write() is the generic write callback which maps directly to
> -	 * kernfs write operation and overrides all other operations.
> -	 * Maximum write size is determined by ->max_write_len.
> -	 */
> -	ssize_t (*write)(struct kernfs_open_file *of,
> -			 char *buf, size_t nbytes, loff_t off);
> -};
> -
> -/**
> - * struct mbm_state - status for each MBM counter in each domain
> - * @prev_bw_bytes: Previous bytes value read for bandwidth calculation
> - * @prev_bw:	The most recent bandwidth in MBps
> - */
> -struct mbm_state {
> -	u64	prev_bw_bytes;
> -	u32	prev_bw;
> -};
> -
>   /**
>    * struct arch_mbm_state - values used to compute resctrl_arch_rmid_read()s
>    *			   return value.
> @@ -394,12 +127,7 @@ static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r
>   	return container_of(r, struct rdt_hw_resource, r_resctrl);
>   }
>   
> -extern struct mutex rdtgroup_mutex;
> -
>   extern struct rdt_hw_resource rdt_resources_all[];
> -extern struct rdtgroup rdtgroup_default;
> -extern struct dentry *debugfs_resctrl;
> -extern enum resctrl_event_id mba_mbps_default_event;
>   
>   void arch_mon_domain_online(struct rdt_resource *r, struct rdt_mon_domain *d);
>   
> @@ -436,99 +164,14 @@ union cpuid_0x10_x_edx {
>   	unsigned int full;
>   };
>   
> -void rdt_last_cmd_clear(void);
> -void rdt_last_cmd_puts(const char *s);
> -__printf(1, 2)
> -void rdt_last_cmd_printf(const char *fmt, ...);
> -
>   void rdt_ctrl_update(void *arg);
> -struct rdtgroup *rdtgroup_kn_lock_live(struct kernfs_node *kn);
> -void rdtgroup_kn_unlock(struct kernfs_node *kn);
> -int rdtgroup_kn_mode_restrict(struct rdtgroup *r, const char *name);
> -int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
> -			     umode_t mask);
> -ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
> -				char *buf, size_t nbytes, loff_t off);
> -int rdtgroup_schemata_show(struct kernfs_open_file *of,
> -			   struct seq_file *s, void *v);
> -ssize_t rdtgroup_mba_mbps_event_write(struct kernfs_open_file *of,
> -				      char *buf, size_t nbytes, loff_t off);
> -int rdtgroup_mba_mbps_event_show(struct kernfs_open_file *of,
> -				 struct seq_file *s, void *v);
> -bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_ctrl_domain *d,
> -			   unsigned long cbm, int closid, bool exclusive);
> -unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r, struct rdt_ctrl_domain *d,
> -				  unsigned long cbm);
> -enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
> -int rdtgroup_tasks_assigned(struct rdtgroup *r);
> -int closids_supported(void);
> -void closid_free(int closid);
> -int alloc_rmid(u32 closid);
> -void free_rmid(u32 closid, u32 rmid);
> +
>   int rdt_get_mon_l3_config(struct rdt_resource *r);
> -void resctrl_mon_resource_exit(void);
> +
>   bool rdt_cpu_has(int flag);
> -void mon_event_count(void *info);
> -int rdtgroup_mondata_show(struct seq_file *m, void *arg);
> -void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
> -		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
> -		    cpumask_t *cpumask, int evtid, int first);
> -int resctrl_mon_resource_init(void);
> -void mbm_setup_overflow_handler(struct rdt_mon_domain *dom,
> -				unsigned long delay_ms,
> -				int exclude_cpu);
> -void mbm_handle_overflow(struct work_struct *work);
> +
>   void __init intel_rdt_mbm_apply_quirk(void);
> -bool is_mba_sc(struct rdt_resource *r);
> -void cqm_setup_limbo_handler(struct rdt_mon_domain *dom, unsigned long delay_ms,
> -			     int exclude_cpu);
> -void cqm_handle_limbo(struct work_struct *work);
> -bool has_busy_rmid(struct rdt_mon_domain *d);
> -void __check_limbo(struct rdt_mon_domain *d, bool force_free);
> +
>   void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
> -void resctrl_file_fflags_init(const char *config, unsigned long fflags);
> -void rdt_staged_configs_clear(void);
> -bool closid_allocated(unsigned int closid);
> -int resctrl_find_cleanest_closid(void);
> -
> -#ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
> -int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
> -int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp);
> -bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_ctrl_domain *d, unsigned long cbm);
> -bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_ctrl_domain *d);
> -int rdt_pseudo_lock_init(void);
> -void rdt_pseudo_lock_release(void);
> -int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp);
> -void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
> -#else
> -static inline int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
> -{
> -	return -EOPNOTSUPP;
> -}
> -
> -static inline int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
> -{
> -	return -EOPNOTSUPP;
> -}
> -
> -static inline bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_ctrl_domain *d, unsigned long cbm)
> -{
> -	return false;
> -}
> -
> -static inline bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_ctrl_domain *d)
> -{
> -	return false;
> -}
> -
> -static inline int rdt_pseudo_lock_init(void) { return 0; }
> -static inline void rdt_pseudo_lock_release(void) { }
> -static inline int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
> -{
> -	return -EOPNOTSUPP;
> -}
> -
> -static inline void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp) { }
> -#endif /* CONFIG_RESCTRL_FS_PSEUDO_LOCK */
>   
>   #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index fcd3c41db554..1809e3fe6ef3 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -28,55 +28,9 @@
>   #include "internal.h"
>   
>   #define CREATE_TRACE_POINTS
> +
>   #include "monitor_trace.h"
>   
> -/**
> - * struct rmid_entry - dirty tracking for all RMID.
> - * @closid:	The CLOSID for this entry.
> - * @rmid:	The RMID for this entry.
> - * @busy:	The number of domains with cached data using this RMID.
> - * @list:	Member of the rmid_free_lru list when busy == 0.
> - *
> - * Depending on the architecture the correct monitor is accessed using
> - * both @closid and @rmid, or @rmid only.
> - *
> - * Take the rdtgroup_mutex when accessing.
> - */
> -struct rmid_entry {
> -	u32				closid;
> -	u32				rmid;
> -	int				busy;
> -	struct list_head		list;
> -};
> -
> -/*
> - * @rmid_free_lru - A least recently used list of free RMIDs
> - *     These RMIDs are guaranteed to have an occupancy less than the
> - *     threshold occupancy
> - */
> -static LIST_HEAD(rmid_free_lru);
> -
> -/*
> - * @closid_num_dirty_rmid    The number of dirty RMID each CLOSID has.
> - *     Only allocated when CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is defined.
> - *     Indexed by CLOSID. Protected by rdtgroup_mutex.
> - */
> -static u32 *closid_num_dirty_rmid;
> -
> -/*
> - * @rmid_limbo_count - count of currently unused but (potentially)
> - *     dirty RMIDs.
> - *     This counts RMIDs that no one is currently using but that
> - *     may have a occupancy value > resctrl_rmid_realloc_threshold. User can
> - *     change the threshold occupancy value.
> - */
> -static unsigned int rmid_limbo_count;
> -
> -/*
> - * @rmid_entry - The entry in the limbo and free lists.
> - */
> -static struct rmid_entry	*rmid_ptrs;
> -
>   /*
>    * Global boolean for rdt_monitor which is true if any
>    * resource monitoring is enabled.
> @@ -88,17 +42,6 @@ bool rdt_mon_capable;
>    */
>   unsigned int rdt_mon_features;
>   
> -/*
> - * This is the threshold cache occupancy in bytes at which we will consider an
> - * RMID available for re-allocation.
> - */
> -unsigned int resctrl_rmid_realloc_threshold;
> -
> -/*
> - * This is the maximum value for the reallocation threshold, in bytes.
> - */
> -unsigned int resctrl_rmid_realloc_limit;
> -
>   #define CF(cf)	((unsigned long)(1048576 * (cf) + 0.5))
>   
>   static int snc_nodes_per_l3_cache = 1;
> @@ -153,6 +96,7 @@ static const struct mbm_correction_factor_table {
>   };
>   
>   static u32 mbm_cf_rmidthreshold __read_mostly = UINT_MAX;
> +
>   static u64 mbm_cf __read_mostly;
>   
>   static inline u64 get_corrected_mbm_count(u32 rmid, unsigned long val)
> @@ -164,33 +108,6 @@ static inline u64 get_corrected_mbm_count(u32 rmid, unsigned long val)
>   	return val;
>   }
>   
> -/*
> - * x86 and arm64 differ in their handling of monitoring.
> - * x86's RMID are independent numbers, there is only one source of traffic
> - * with an RMID value of '1'.
> - * arm64's PMG extends the PARTID/CLOSID space, there are multiple sources of
> - * traffic with a PMG value of '1', one for each CLOSID, meaning the RMID
> - * value is no longer unique.
> - * To account for this, resctrl uses an index. On x86 this is just the RMID,
> - * on arm64 it encodes the CLOSID and RMID. This gives a unique number.
> - *
> - * The domain's rmid_busy_llc and rmid_ptrs[] are sized by index. The arch code
> - * must accept an attempt to read every index.
> - */
> -static inline struct rmid_entry *__rmid_entry(u32 idx)
> -{
> -	struct rmid_entry *entry;
> -	u32 closid, rmid;
> -
> -	entry = &rmid_ptrs[idx];
> -	resctrl_arch_rmid_idx_decode(idx, &closid, &rmid);
> -
> -	WARN_ON_ONCE(entry->closid != closid);
> -	WARN_ON_ONCE(entry->rmid != rmid);
> -
> -	return entry;
> -}
> -
>   /*
>    * When Sub-NUMA Cluster (SNC) mode is not enabled (as indicated by
>    * "snc_nodes_per_l3_cache == 1") no translation of the RMID value is
> @@ -348,772 +265,6 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
>   	return 0;
>   }
>   
> -static void limbo_release_entry(struct rmid_entry *entry)
> -{
> -	lockdep_assert_held(&rdtgroup_mutex);
> -
> -	rmid_limbo_count--;
> -	list_add_tail(&entry->list, &rmid_free_lru);
> -
> -	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
> -		closid_num_dirty_rmid[entry->closid]--;
> -}
> -
> -/*
> - * Check the RMIDs that are marked as busy for this domain. If the
> - * reported LLC occupancy is below the threshold clear the busy bit and
> - * decrement the count. If the busy count gets to zero on an RMID, we
> - * free the RMID
> - */
> -void __check_limbo(struct rdt_mon_domain *d, bool force_free)
> -{
> -	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
> -	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
> -	struct rmid_entry *entry;
> -	u32 idx, cur_idx = 1;
> -	void *arch_mon_ctx;
> -	bool rmid_dirty;
> -	u64 val = 0;
> -
> -	arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, QOS_L3_OCCUP_EVENT_ID);
> -	if (IS_ERR(arch_mon_ctx)) {
> -		pr_warn_ratelimited("Failed to allocate monitor context: %ld",
> -				    PTR_ERR(arch_mon_ctx));
> -		return;
> -	}
> -
> -	/*
> -	 * Skip RMID 0 and start from RMID 1 and check all the RMIDs that
> -	 * are marked as busy for occupancy < threshold. If the occupancy
> -	 * is less than the threshold decrement the busy counter of the
> -	 * RMID and move it to the free list when the counter reaches 0.
> -	 */
> -	for (;;) {
> -		idx = find_next_bit(d->rmid_busy_llc, idx_limit, cur_idx);
> -		if (idx >= idx_limit)
> -			break;
> -
> -		entry = __rmid_entry(idx);
> -		if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
> -					   QOS_L3_OCCUP_EVENT_ID, &val,
> -					   arch_mon_ctx)) {
> -			rmid_dirty = true;
> -		} else {
> -			rmid_dirty = (val >= resctrl_rmid_realloc_threshold);
> -
> -			/*
> -			 * x86's CLOSID and RMID are independent numbers, so the entry's
> -			 * CLOSID is an empty CLOSID (X86_RESCTRL_EMPTY_CLOSID). On Arm the
> -			 * RMID (PMG) extends the CLOSID (PARTID) space with bits that aren't
> -			 * used to select the configuration. It is thus necessary to track both
> -			 * CLOSID and RMID because there may be dependencies between them
> -			 * on some architectures.
> -			 */
> -			trace_mon_llc_occupancy_limbo(entry->closid, entry->rmid, d->hdr.id, val);
> -		}
> -
> -		if (force_free || !rmid_dirty) {
> -			clear_bit(idx, d->rmid_busy_llc);
> -			if (!--entry->busy)
> -				limbo_release_entry(entry);
> -		}
> -		cur_idx = idx + 1;
> -	}
> -
> -	resctrl_arch_mon_ctx_free(r, QOS_L3_OCCUP_EVENT_ID, arch_mon_ctx);
> -}
> -
> -bool has_busy_rmid(struct rdt_mon_domain *d)
> -{
> -	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
> -
> -	return find_first_bit(d->rmid_busy_llc, idx_limit) != idx_limit;
> -}
> -
> -static struct rmid_entry *resctrl_find_free_rmid(u32 closid)
> -{
> -	struct rmid_entry *itr;
> -	u32 itr_idx, cmp_idx;
> -
> -	if (list_empty(&rmid_free_lru))
> -		return rmid_limbo_count ? ERR_PTR(-EBUSY) : ERR_PTR(-ENOSPC);
> -
> -	list_for_each_entry(itr, &rmid_free_lru, list) {
> -		/*
> -		 * Get the index of this free RMID, and the index it would need
> -		 * to be if it were used with this CLOSID.
> -		 * If the CLOSID is irrelevant on this architecture, the two
> -		 * index values are always the same on every entry and thus the
> -		 * very first entry will be returned.
> -		 */
> -		itr_idx = resctrl_arch_rmid_idx_encode(itr->closid, itr->rmid);
> -		cmp_idx = resctrl_arch_rmid_idx_encode(closid, itr->rmid);
> -
> -		if (itr_idx == cmp_idx)
> -			return itr;
> -	}
> -
> -	return ERR_PTR(-ENOSPC);
> -}
> -
> -/**
> - * resctrl_find_cleanest_closid() - Find a CLOSID where all the associated
> - *                                  RMID are clean, or the CLOSID that has
> - *                                  the most clean RMID.
> - *
> - * MPAM's equivalent of RMID are per-CLOSID, meaning a freshly allocated CLOSID
> - * may not be able to allocate clean RMID. To avoid this the allocator will
> - * choose the CLOSID with the most clean RMID.
> - *
> - * When the CLOSID and RMID are independent numbers, the first free CLOSID will
> - * be returned.
> - */
> -int resctrl_find_cleanest_closid(void)
> -{
> -	u32 cleanest_closid = ~0;
> -	int i = 0;
> -
> -	lockdep_assert_held(&rdtgroup_mutex);
> -
> -	if (!IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
> -		return -EIO;
> -
> -	for (i = 0; i < closids_supported(); i++) {
> -		int num_dirty;
> -
> -		if (closid_allocated(i))
> -			continue;
> -
> -		num_dirty = closid_num_dirty_rmid[i];
> -		if (num_dirty == 0)
> -			return i;
> -
> -		if (cleanest_closid == ~0)
> -			cleanest_closid = i;
> -
> -		if (num_dirty < closid_num_dirty_rmid[cleanest_closid])
> -			cleanest_closid = i;
> -	}
> -
> -	if (cleanest_closid == ~0)
> -		return -ENOSPC;
> -
> -	return cleanest_closid;
> -}
> -
> -/*
> - * For MPAM the RMID value is not unique, and has to be considered with
> - * the CLOSID. The (CLOSID, RMID) pair is allocated on all domains, which
> - * allows all domains to be managed by a single free list.
> - * Each domain also has a rmid_busy_llc to reduce the work of the limbo handler.
> - */
> -int alloc_rmid(u32 closid)
> -{
> -	struct rmid_entry *entry;
> -
> -	lockdep_assert_held(&rdtgroup_mutex);
> -
> -	entry = resctrl_find_free_rmid(closid);
> -	if (IS_ERR(entry))
> -		return PTR_ERR(entry);
> -
> -	list_del(&entry->list);
> -	return entry->rmid;
> -}
> -
> -static void add_rmid_to_limbo(struct rmid_entry *entry)
> -{
> -	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
> -	struct rdt_mon_domain *d;
> -	u32 idx;
> -
> -	lockdep_assert_held(&rdtgroup_mutex);
> -
> -	/* Walking r->domains, ensure it can't race with cpuhp */
> -	lockdep_assert_cpus_held();
> -
> -	idx = resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
> -
> -	entry->busy = 0;
> -	list_for_each_entry(d, &r->mon_domains, hdr.list) {
> -		/*
> -		 * For the first limbo RMID in the domain,
> -		 * setup up the limbo worker.
> -		 */
> -		if (!has_busy_rmid(d))
> -			cqm_setup_limbo_handler(d, CQM_LIMBOCHECK_INTERVAL,
> -						RESCTRL_PICK_ANY_CPU);
> -		set_bit(idx, d->rmid_busy_llc);
> -		entry->busy++;
> -	}
> -
> -	rmid_limbo_count++;
> -	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
> -		closid_num_dirty_rmid[entry->closid]++;
> -}
> -
> -void free_rmid(u32 closid, u32 rmid)
> -{
> -	u32 idx = resctrl_arch_rmid_idx_encode(closid, rmid);
> -	struct rmid_entry *entry;
> -
> -	lockdep_assert_held(&rdtgroup_mutex);
> -
> -	/*
> -	 * Do not allow the default rmid to be free'd. Comparing by index
> -	 * allows architectures that ignore the closid parameter to avoid an
> -	 * unnecessary check.
> -	 */
> -	if (!resctrl_arch_mon_capable() ||
> -	    idx == resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
> -						RESCTRL_RESERVED_RMID))
> -		return;
> -
> -	entry = __rmid_entry(idx);
> -
> -	if (resctrl_arch_is_llc_occupancy_enabled())
> -		add_rmid_to_limbo(entry);
> -	else
> -		list_add_tail(&entry->list, &rmid_free_lru);
> -}
> -
> -static struct mbm_state *get_mbm_state(struct rdt_mon_domain *d, u32 closid,
> -				       u32 rmid, enum resctrl_event_id evtid)
> -{
> -	u32 idx = resctrl_arch_rmid_idx_encode(closid, rmid);
> -
> -	switch (evtid) {
> -	case QOS_L3_MBM_TOTAL_EVENT_ID:
> -		return &d->mbm_total[idx];
> -	case QOS_L3_MBM_LOCAL_EVENT_ID:
> -		return &d->mbm_local[idx];
> -	default:
> -		return NULL;
> -	}
> -}
> -
> -static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
> -{
> -	int cpu = smp_processor_id();
> -	struct rdt_mon_domain *d;
> -	struct mbm_state *m;
> -	int err, ret;
> -	u64 tval = 0;
> -
> -	if (rr->first) {
> -		resctrl_arch_reset_rmid(rr->r, rr->d, closid, rmid, rr->evtid);
> -		m = get_mbm_state(rr->d, closid, rmid, rr->evtid);
> -		if (m)
> -			memset(m, 0, sizeof(struct mbm_state));
> -		return 0;
> -	}
> -
> -	if (rr->d) {
> -		/* Reading a single domain, must be on a CPU in that domain. */
> -		if (!cpumask_test_cpu(cpu, &rr->d->hdr.cpu_mask))
> -			return -EINVAL;
> -		rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid,
> -						 rr->evtid, &tval, rr->arch_mon_ctx);
> -		if (rr->err)
> -			return rr->err;
> -
> -		rr->val += tval;
> -
> -		return 0;
> -	}
> -
> -	/* Summing domains that share a cache, must be on a CPU for that cache. */
> -	if (!cpumask_test_cpu(cpu, &rr->ci->shared_cpu_map))
> -		return -EINVAL;
> -
> -	/*
> -	 * Legacy files must report the sum of an event across all
> -	 * domains that share the same L3 cache instance.
> -	 * Report success if a read from any domain succeeds, -EINVAL
> -	 * (translated to "Unavailable" for user space) if reading from
> -	 * all domains fail for any reason.
> -	 */
> -	ret = -EINVAL;
> -	list_for_each_entry(d, &rr->r->mon_domains, hdr.list) {
> -		if (d->ci->id != rr->ci->id)
> -			continue;
> -		err = resctrl_arch_rmid_read(rr->r, d, closid, rmid,
> -					     rr->evtid, &tval, rr->arch_mon_ctx);
> -		if (!err) {
> -			rr->val += tval;
> -			ret = 0;
> -		}
> -	}
> -
> -	if (ret)
> -		rr->err = ret;
> -
> -	return ret;
> -}
> -
> -/*
> - * mbm_bw_count() - Update bw count from values previously read by
> - *		    __mon_event_count().
> - * @closid:	The closid used to identify the cached mbm_state.
> - * @rmid:	The rmid used to identify the cached mbm_state.
> - * @rr:		The struct rmid_read populated by __mon_event_count().
> - *
> - * Supporting function to calculate the memory bandwidth
> - * and delta bandwidth in MBps. The chunks value previously read by
> - * __mon_event_count() is compared with the chunks value from the previous
> - * invocation. This must be called once per second to maintain values in MBps.
> - */
> -static void mbm_bw_count(u32 closid, u32 rmid, struct rmid_read *rr)
> -{
> -	u64 cur_bw, bytes, cur_bytes;
> -	struct mbm_state *m;
> -
> -	m = get_mbm_state(rr->d, closid, rmid, rr->evtid);
> -	if (WARN_ON_ONCE(!m))
> -		return;
> -
> -	cur_bytes = rr->val;
> -	bytes = cur_bytes - m->prev_bw_bytes;
> -	m->prev_bw_bytes = cur_bytes;
> -
> -	cur_bw = bytes / SZ_1M;
> -
> -	m->prev_bw = cur_bw;
> -}
> -
> -/*
> - * This is scheduled by mon_event_read() to read the CQM/MBM counters
> - * on a domain.
> - */
> -void mon_event_count(void *info)
> -{
> -	struct rdtgroup *rdtgrp, *entry;
> -	struct rmid_read *rr = info;
> -	struct list_head *head;
> -	int ret;
> -
> -	rdtgrp = rr->rgrp;
> -
> -	ret = __mon_event_count(rdtgrp->closid, rdtgrp->mon.rmid, rr);
> -
> -	/*
> -	 * For Ctrl groups read data from child monitor groups and
> -	 * add them together. Count events which are read successfully.
> -	 * Discard the rmid_read's reporting errors.
> -	 */
> -	head = &rdtgrp->mon.crdtgrp_list;
> -
> -	if (rdtgrp->type == RDTCTRL_GROUP) {
> -		list_for_each_entry(entry, head, mon.crdtgrp_list) {
> -			if (__mon_event_count(entry->closid, entry->mon.rmid,
> -					      rr) == 0)
> -				ret = 0;
> -		}
> -	}
> -
> -	/*
> -	 * __mon_event_count() calls for newly created monitor groups may
> -	 * report -EINVAL/Unavailable if the monitor hasn't seen any traffic.
> -	 * Discard error if any of the monitor event reads succeeded.
> -	 */
> -	if (ret == 0)
> -		rr->err = 0;
> -}
> -
> -static struct rdt_ctrl_domain *get_ctrl_domain_from_cpu(int cpu,
> -							struct rdt_resource *r)
> -{
> -	struct rdt_ctrl_domain *d;
> -
> -	lockdep_assert_cpus_held();
> -
> -	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
> -		/* Find the domain that contains this CPU */
> -		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
> -			return d;
> -	}
> -
> -	return NULL;
> -}
> -
> -/*
> - * Feedback loop for MBA software controller (mba_sc)
> - *
> - * mba_sc is a feedback loop where we periodically read MBM counters and
> - * adjust the bandwidth percentage values via the IA32_MBA_THRTL_MSRs so
> - * that:
> - *
> - *   current bandwidth(cur_bw) < user specified bandwidth(user_bw)
> - *
> - * This uses the MBM counters to measure the bandwidth and MBA throttle
> - * MSRs to control the bandwidth for a particular rdtgrp. It builds on the
> - * fact that resctrl rdtgroups have both monitoring and control.
> - *
> - * The frequency of the checks is 1s and we just tag along the MBM overflow
> - * timer. Having 1s interval makes the calculation of bandwidth simpler.
> - *
> - * Although MBA's goal is to restrict the bandwidth to a maximum, there may
> - * be a need to increase the bandwidth to avoid unnecessarily restricting
> - * the L2 <-> L3 traffic.
> - *
> - * Since MBA controls the L2 external bandwidth where as MBM measures the
> - * L3 external bandwidth the following sequence could lead to such a
> - * situation.
> - *
> - * Consider an rdtgroup which had high L3 <-> memory traffic in initial
> - * phases -> mba_sc kicks in and reduced bandwidth percentage values -> but
> - * after some time rdtgroup has mostly L2 <-> L3 traffic.
> - *
> - * In this case we may restrict the rdtgroup's L2 <-> L3 traffic as its
> - * throttle MSRs already have low percentage values.  To avoid
> - * unnecessarily restricting such rdtgroups, we also increase the bandwidth.
> - */
> -static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_mon_domain *dom_mbm)
> -{
> -	u32 closid, rmid, cur_msr_val, new_msr_val;
> -	struct mbm_state *pmbm_data, *cmbm_data;
> -	struct rdt_ctrl_domain *dom_mba;
> -	enum resctrl_event_id evt_id;
> -	struct rdt_resource *r_mba;
> -	struct list_head *head;
> -	struct rdtgroup *entry;
> -	u32 cur_bw, user_bw;
> -
> -	r_mba = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
> -	evt_id = rgrp->mba_mbps_event;
> -
> -	closid = rgrp->closid;
> -	rmid = rgrp->mon.rmid;
> -	pmbm_data = get_mbm_state(dom_mbm, closid, rmid, evt_id);
> -	if (WARN_ON_ONCE(!pmbm_data))
> -		return;
> -
> -	dom_mba = get_ctrl_domain_from_cpu(smp_processor_id(), r_mba);
> -	if (!dom_mba) {
> -		pr_warn_once("Failure to get domain for MBA update\n");
> -		return;
> -	}
> -
> -	cur_bw = pmbm_data->prev_bw;
> -	user_bw = dom_mba->mbps_val[closid];
> -
> -	/* MBA resource doesn't support CDP */
> -	cur_msr_val = resctrl_arch_get_config(r_mba, dom_mba, closid, CDP_NONE);
> -
> -	/*
> -	 * For Ctrl groups read data from child monitor groups.
> -	 */
> -	head = &rgrp->mon.crdtgrp_list;
> -	list_for_each_entry(entry, head, mon.crdtgrp_list) {
> -		cmbm_data = get_mbm_state(dom_mbm, entry->closid, entry->mon.rmid, evt_id);
> -		if (WARN_ON_ONCE(!cmbm_data))
> -			return;
> -		cur_bw += cmbm_data->prev_bw;
> -	}
> -
> -	/*
> -	 * Scale up/down the bandwidth linearly for the ctrl group.  The
> -	 * bandwidth step is the bandwidth granularity specified by the
> -	 * hardware.
> -	 * Always increase throttling if current bandwidth is above the
> -	 * target set by user.
> -	 * But avoid thrashing up and down on every poll by checking
> -	 * whether a decrease in throttling is likely to push the group
> -	 * back over target. E.g. if currently throttling to 30% of bandwidth
> -	 * on a system with 10% granularity steps, check whether moving to
> -	 * 40% would go past the limit by multiplying current bandwidth by
> -	 * "(30 + 10) / 30".
> -	 */
> -	if (cur_msr_val > r_mba->membw.min_bw && user_bw < cur_bw) {
> -		new_msr_val = cur_msr_val - r_mba->membw.bw_gran;
> -	} else if (cur_msr_val < MAX_MBA_BW &&
> -		   (user_bw > (cur_bw * (cur_msr_val + r_mba->membw.min_bw) / cur_msr_val))) {
> -		new_msr_val = cur_msr_val + r_mba->membw.bw_gran;
> -	} else {
> -		return;
> -	}
> -
> -	resctrl_arch_update_one(r_mba, dom_mba, closid, CDP_NONE, new_msr_val);
> -}
> -
> -static void mbm_update_one_event(struct rdt_resource *r, struct rdt_mon_domain *d,
> -				 u32 closid, u32 rmid, enum resctrl_event_id evtid)
> -{
> -	struct rmid_read rr = {0};
> -
> -	rr.r = r;
> -	rr.d = d;
> -	rr.evtid = evtid;
> -	rr.arch_mon_ctx = resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
> -	if (IS_ERR(rr.arch_mon_ctx)) {
> -		pr_warn_ratelimited("Failed to allocate monitor context: %ld",
> -				    PTR_ERR(rr.arch_mon_ctx));
> -		return;
> -	}
> -
> -	__mon_event_count(closid, rmid, &rr);
> -
> -	/*
> -	 * If the software controller is enabled, compute the
> -	 * bandwidth for this event id.
> -	 */
> -	if (is_mba_sc(NULL))
> -		mbm_bw_count(closid, rmid, &rr);
> -
> -	resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
> -}
> -
> -static void mbm_update(struct rdt_resource *r, struct rdt_mon_domain *d,
> -		       u32 closid, u32 rmid)
> -{
> -	/*
> -	 * This is protected from concurrent reads from user as both
> -	 * the user and overflow handler hold the global mutex.
> -	 */
> -	if (resctrl_arch_is_mbm_total_enabled())
> -		mbm_update_one_event(r, d, closid, rmid, QOS_L3_MBM_TOTAL_EVENT_ID);
> -
> -	if (resctrl_arch_is_mbm_local_enabled())
> -		mbm_update_one_event(r, d, closid, rmid, QOS_L3_MBM_LOCAL_EVENT_ID);
> -}
> -
> -/*
> - * Handler to scan the limbo list and move the RMIDs
> - * to free list whose occupancy < threshold_occupancy.
> - */
> -void cqm_handle_limbo(struct work_struct *work)
> -{
> -	unsigned long delay = msecs_to_jiffies(CQM_LIMBOCHECK_INTERVAL);
> -	struct rdt_mon_domain *d;
> -
> -	cpus_read_lock();
> -	mutex_lock(&rdtgroup_mutex);
> -
> -	d = container_of(work, struct rdt_mon_domain, cqm_limbo.work);
> -
> -	__check_limbo(d, false);
> -
> -	if (has_busy_rmid(d)) {
> -		d->cqm_work_cpu = cpumask_any_housekeeping(&d->hdr.cpu_mask,
> -							   RESCTRL_PICK_ANY_CPU);
> -		schedule_delayed_work_on(d->cqm_work_cpu, &d->cqm_limbo,
> -					 delay);
> -	}
> -
> -	mutex_unlock(&rdtgroup_mutex);
> -	cpus_read_unlock();
> -}
> -
> -/**
> - * cqm_setup_limbo_handler() - Schedule the limbo handler to run for this
> - *                             domain.
> - * @dom:           The domain the limbo handler should run for.
> - * @delay_ms:      How far in the future the handler should run.
> - * @exclude_cpu:   Which CPU the handler should not run on,
> - *		   RESCTRL_PICK_ANY_CPU to pick any CPU.
> - */
> -void cqm_setup_limbo_handler(struct rdt_mon_domain *dom, unsigned long delay_ms,
> -			     int exclude_cpu)
> -{
> -	unsigned long delay = msecs_to_jiffies(delay_ms);
> -	int cpu;
> -
> -	cpu = cpumask_any_housekeeping(&dom->hdr.cpu_mask, exclude_cpu);
> -	dom->cqm_work_cpu = cpu;
> -
> -	if (cpu < nr_cpu_ids)
> -		schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
> -}
> -
> -void mbm_handle_overflow(struct work_struct *work)
> -{
> -	unsigned long delay = msecs_to_jiffies(MBM_OVERFLOW_INTERVAL);
> -	struct rdtgroup *prgrp, *crgrp;
> -	struct rdt_mon_domain *d;
> -	struct list_head *head;
> -	struct rdt_resource *r;
> -
> -	cpus_read_lock();
> -	mutex_lock(&rdtgroup_mutex);
> -
> -	/*
> -	 * If the filesystem has been unmounted this work no longer needs to
> -	 * run.
> -	 */
> -	if (!resctrl_mounted || !resctrl_arch_mon_capable())
> -		goto out_unlock;
> -
> -	r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
> -	d = container_of(work, struct rdt_mon_domain, mbm_over.work);
> -
> -	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> -		mbm_update(r, d, prgrp->closid, prgrp->mon.rmid);
> -
> -		head = &prgrp->mon.crdtgrp_list;
> -		list_for_each_entry(crgrp, head, mon.crdtgrp_list)
> -			mbm_update(r, d, crgrp->closid, crgrp->mon.rmid);
> -
> -		if (is_mba_sc(NULL))
> -			update_mba_bw(prgrp, d);
> -	}
> -
> -	/*
> -	 * Re-check for housekeeping CPUs. This allows the overflow handler to
> -	 * move off a nohz_full CPU quickly.
> -	 */
> -	d->mbm_work_cpu = cpumask_any_housekeeping(&d->hdr.cpu_mask,
> -						   RESCTRL_PICK_ANY_CPU);
> -	schedule_delayed_work_on(d->mbm_work_cpu, &d->mbm_over, delay);
> -
> -out_unlock:
> -	mutex_unlock(&rdtgroup_mutex);
> -	cpus_read_unlock();
> -}
> -
> -/**
> - * mbm_setup_overflow_handler() - Schedule the overflow handler to run for this
> - *                                domain.
> - * @dom:           The domain the overflow handler should run for.
> - * @delay_ms:      How far in the future the handler should run.
> - * @exclude_cpu:   Which CPU the handler should not run on,
> - *		   RESCTRL_PICK_ANY_CPU to pick any CPU.
> - */
> -void mbm_setup_overflow_handler(struct rdt_mon_domain *dom, unsigned long delay_ms,
> -				int exclude_cpu)
> -{
> -	unsigned long delay = msecs_to_jiffies(delay_ms);
> -	int cpu;
> -
> -	/*
> -	 * When a domain comes online there is no guarantee the filesystem is
> -	 * mounted. If not, there is no need to catch counter overflow.
> -	 */
> -	if (!resctrl_mounted || !resctrl_arch_mon_capable())
> -		return;
> -	cpu = cpumask_any_housekeeping(&dom->hdr.cpu_mask, exclude_cpu);
> -	dom->mbm_work_cpu = cpu;
> -
> -	if (cpu < nr_cpu_ids)
> -		schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
> -}
> -
> -static int dom_data_init(struct rdt_resource *r)
> -{
> -	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
> -	u32 num_closid = resctrl_arch_get_num_closid(r);
> -	struct rmid_entry *entry = NULL;
> -	int err = 0, i;
> -	u32 idx;
> -
> -	mutex_lock(&rdtgroup_mutex);
> -	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
> -		u32 *tmp;
> -
> -		/*
> -		 * If the architecture hasn't provided a sanitised value here,
> -		 * this may result in larger arrays than necessary. Resctrl will
> -		 * use a smaller system wide value based on the resources in
> -		 * use.
> -		 */
> -		tmp = kcalloc(num_closid, sizeof(*tmp), GFP_KERNEL);
> -		if (!tmp) {
> -			err = -ENOMEM;
> -			goto out_unlock;
> -		}
> -
> -		closid_num_dirty_rmid = tmp;
> -	}
> -
> -	rmid_ptrs = kcalloc(idx_limit, sizeof(struct rmid_entry), GFP_KERNEL);
> -	if (!rmid_ptrs) {
> -		if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
> -			kfree(closid_num_dirty_rmid);
> -			closid_num_dirty_rmid = NULL;
> -		}
> -		err = -ENOMEM;
> -		goto out_unlock;
> -	}
> -
> -	for (i = 0; i < idx_limit; i++) {
> -		entry = &rmid_ptrs[i];
> -		INIT_LIST_HEAD(&entry->list);
> -
> -		resctrl_arch_rmid_idx_decode(i, &entry->closid, &entry->rmid);
> -		list_add_tail(&entry->list, &rmid_free_lru);
> -	}
> -
> -	/*
> -	 * RESCTRL_RESERVED_CLOSID and RESCTRL_RESERVED_RMID are special and
> -	 * are always allocated. These are used for the rdtgroup_default
> -	 * control group, which will be setup later in resctrl_init().
> -	 */
> -	idx = resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
> -					   RESCTRL_RESERVED_RMID);
> -	entry = __rmid_entry(idx);
> -	list_del(&entry->list);
> -
> -out_unlock:
> -	mutex_unlock(&rdtgroup_mutex);
> -
> -	return err;
> -}
> -
> -static void dom_data_exit(struct rdt_resource *r)
> -{
> -	mutex_lock(&rdtgroup_mutex);
> -
> -	if (!r->mon_capable)
> -		goto out_unlock;
> -
> -	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
> -		kfree(closid_num_dirty_rmid);
> -		closid_num_dirty_rmid = NULL;
> -	}
> -
> -	kfree(rmid_ptrs);
> -	rmid_ptrs = NULL;
> -
> -out_unlock:
> -	mutex_unlock(&rdtgroup_mutex);
> -}
> -
> -static struct mon_evt llc_occupancy_event = {
> -	.name		= "llc_occupancy",
> -	.evtid		= QOS_L3_OCCUP_EVENT_ID,
> -};
> -
> -static struct mon_evt mbm_total_event = {
> -	.name		= "mbm_total_bytes",
> -	.evtid		= QOS_L3_MBM_TOTAL_EVENT_ID,
> -};
> -
> -static struct mon_evt mbm_local_event = {
> -	.name		= "mbm_local_bytes",
> -	.evtid		= QOS_L3_MBM_LOCAL_EVENT_ID,
> -};
> -
> -/*
> - * Initialize the event list for the resource.
> - *
> - * Note that MBM events are also part of RDT_RESOURCE_L3 resource
> - * because as per the SDM the total and local memory bandwidth
> - * are enumerated as part of L3 monitoring.
> - *
> - * mon_put_default_kn_priv_all() also assumes monitor events are only supported
> - * on the L3 resource.
> - */
> -static void l3_mon_evt_init(struct rdt_resource *r)
> -{
> -	INIT_LIST_HEAD(&r->evt_list);
> -
> -	if (resctrl_arch_is_llc_occupancy_enabled())
> -		list_add_tail(&llc_occupancy_event.list, &r->evt_list);
> -	if (resctrl_arch_is_mbm_total_enabled())
> -		list_add_tail(&mbm_total_event.list, &r->evt_list);
> -	if (resctrl_arch_is_mbm_local_enabled())
> -		list_add_tail(&mbm_local_event.list, &r->evt_list);
> -}
> -
>   /*
>    * The power-on reset value of MSR_RMID_SNC_CONFIG is 0x1
>    * which indicates that RMIDs are configured in legacy mode.
> @@ -1197,51 +348,6 @@ static __init int snc_get_config(void)
>   	return ret;
>   }
>   
> -/**
> - * resctrl_mon_resource_init() - Initialise global monitoring structures.
> - *
> - * Allocate and initialise global monitor resources that do not belong to a
> - * specific domain. i.e. the rmid_ptrs[] used for the limbo and free lists.
> - * Called once during boot after the struct rdt_resource's have been configured
> - * but before the filesystem is mounted.
> - * Resctrl's cpuhp callbacks may be called before this point to bring a domain
> - * online.
> - *
> - * Returns 0 for success, or -ENOMEM.
> - */
> -int resctrl_mon_resource_init(void)
> -{
> -	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
> -	int ret;
> -
> -	if (!r->mon_capable)
> -		return 0;
> -
> -	ret = dom_data_init(r);
> -	if (ret)
> -		return ret;
> -
> -	l3_mon_evt_init(r);
> -
> -	if (resctrl_arch_is_evt_configurable(QOS_L3_MBM_TOTAL_EVENT_ID)) {
> -		mbm_total_event.configurable = true;
> -		resctrl_file_fflags_init("mbm_total_bytes_config",
> -					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
> -	}
> -	if (resctrl_arch_is_evt_configurable(QOS_L3_MBM_LOCAL_EVENT_ID)) {
> -		mbm_local_event.configurable = true;
> -		resctrl_file_fflags_init("mbm_local_bytes_config",
> -					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
> -	}
> -
> -	if (resctrl_arch_is_mbm_local_enabled())
> -		mba_mbps_default_event = QOS_L3_MBM_LOCAL_EVENT_ID;
> -	else if (resctrl_arch_is_mbm_total_enabled())
> -		mba_mbps_default_event = QOS_L3_MBM_TOTAL_EVENT_ID;
> -
> -	return 0;
> -}
> -
>   int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>   {
>   	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
> @@ -1289,13 +395,6 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>   	return 0;
>   }
>   
> -void resctrl_mon_resource_exit(void)
> -{
> -	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
> -
> -	dom_data_exit(r);
> -}
> -
>   void __init intel_rdt_mbm_apply_quirk(void)
>   {
>   	int cf_index;
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor_trace.h b/arch/x86/kernel/cpu/resctrl/monitor_trace.h
> index ade67daf42c2..b5a142dd0f0e 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor_trace.h
> +++ b/arch/x86/kernel/cpu/resctrl/monitor_trace.h
> @@ -7,25 +7,11 @@
>   
>   #include <linux/tracepoint.h>
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
>   #endif /* _FS_RESCTRL_MONITOR_TRACE_H */
>   
>   #undef TRACE_INCLUDE_PATH
>   #define TRACE_INCLUDE_PATH .
> +
>   #define TRACE_INCLUDE_FILE monitor_trace
> +
>   #include <trace/define_trace.h>

Similarly this file doesn't define any trace event. make W=1 complains it:

                 from arch/x86/kernel/cpu/resctrl/monitor.c:32:
./include/trace/stages/init.h:2:23: error: 
‘str__resctrl__trace_system_name’ defined but not used 
[-Werror=unused-const-variable=]
     2 | #define __app__(x, y) str__##x##y
       |                       ^~~~~
./include/trace/stages/init.h:3:21: note: in expansion of macro ‘__app__’
     3 | #define __app(x, y) __app__(x, y)
       |                     ^~~~~~~
./include/trace/stages/init.h:5:29: note: in expansion of macro ‘__app’
     5 | #define TRACE_SYSTEM_STRING 
__app(TRACE_SYSTEM_VAR,__trace_system_name)
       |                             ^~~~~
./include/trace/stages/init.h:8:27: note: in expansion of macro 
‘TRACE_SYSTEM_STRING’
     8 |         static const char TRACE_SYSTEM_STRING[] =       \
       |                           ^~~~~~~~~~~~~~~~~~~
./include/trace/stages/init.h:11:1: note: in expansion of macro 
‘TRACE_MAKE_SYSTEM_STR’
    11 | TRACE_MAKE_SYSTEM_STR();
       | ^~~~~~~~~~~~~~~~~~~~~
   CC      fs/proc/consoles.o
cc1: all warnings being treated as errors
make[6]: *** [scripts/Makefile.build:207: 
arch/x86/kernel/cpu/resctrl/monitor.o] Error 1
make[6]: *** Waiting for unfinished jobs....

The above two compilation errors only happen when first 45 patches are 
applied. The whole patch set won't have the errors because patch 46 
removes these empty trace events.

The fix is simple: just merge this patch and patch 46 together. Then 
there is no empty trace event in trace.h files and thus no compilation 
errors.

Thanks.

-Fenghua


