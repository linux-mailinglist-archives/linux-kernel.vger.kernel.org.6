Return-Path: <linux-kernel+bounces-537264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A27FCA489CB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470BB188F61B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1836826FA59;
	Thu, 27 Feb 2025 20:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cvWrBVjR"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A43B1BEF7D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740687866; cv=fail; b=AzUIGeHzL9v5XbSRGx9BtPV+Om+6hgEDbl8oEmb6Mj/MMyzUAyiY1Zv4Fe1X8yvO50LZz5K+LWrf72uu6iHqcXBaEJupri2iLebXfiHBrVlZNImEnV7t6umJu4gLPfO7114Fj2U6WurmQ2pb7rytxG1WdzI+S6IYlhsVKHXIqaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740687866; c=relaxed/simple;
	bh=sq431gCMd87wLCzN0QdfZUwbuxlJAVJdJ3o+RxQiKxM=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Htd//850j0KKMnFuz/Mi3oMTetBR7XCsqKTXw5ZFY8arih4f8swjNnzXemUn2I2xhSvYfTzLB7dAdmPZE83PzLhXU6MqlbwvobYQAlHkLlcQqbew962q5AcQyOFlxeIO4uDgjtHdA6BYIXKx1+9vu+M5PpdfHyJqBqWcR6d7k/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cvWrBVjR; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mESEWe8SKZR6m6UR5SjyJiyvwtnbWKJrnk1Yk7jqlb/FjagMZS4gmN0cZzuhDmGbhqSilSEkEApxNZbHthNDEjU7XiTTL3O0nKGdMGr0YSxI+Qx/nfaVCsi6dHS2fw+tja+3v82I/xMh3IhzvhF4ogL3MidPipSHjIiy8+Y6E/FQyA4hRHEbzqGNqN9E2NgfvNbemIRtUS7UyqTJF6t4Hd3puyvKbYBLm9kgBRHX0izEEpzGmmPOa8Zgc9FGd3zirkxprQQIJEgpz3pjjJFbc/JhzTPj4mwGmf3q9pSOQ30bPqoXOH3Jvy1L00jXmvL/l/9rhna61mo8Pi79Eqv0+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EytOfRFcxaoXHrdVRbAAHyc5BtENirsAajTbkzfkp08=;
 b=QXoPYtfY2+9ukYAP+u8+Wnni69aCfFVWZl9o7W66x8OgSHm8WgDxDDvb1uFaeLlF0uNqzGAtxmDVywsZLRUwXPex3sjlsyPOMwI7Wxl6Wh0EmK/EOI68p7El/TmxlrOxYT7i2ge9jLmzDU5KmlLA9ul2ugjRSs+22wN4bliAbYGWoH9bIDaSdG1KtXJScglM0MGlB6b6pqY5vFEGqyJKt5aqTAD14iffi8hcAOecLyWDbty3jsAWE/4F3SUyJpd3GiW49FyB8E95/+ImwcNedtRF3KEyKlq6vkV7m76OkpIuQHYFd22mt+AdctnxmvD2NSBIIkmGDtdDfuGtx9QCAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EytOfRFcxaoXHrdVRbAAHyc5BtENirsAajTbkzfkp08=;
 b=cvWrBVjRZ/S1QRj5wYv8s0k9/X1B3s/GdtNqk023Fn7WIi7NHeHoRcT8MGLyk3721Ce8w5Ltm0kmttQSM95nIG8dB6B7VsZSjWo3z+luEyKo4b/wirUNaR7tnv4QtOjl32qMjhZud67XBDl6HdGru8tzQR6RYhNP5hspSdnt5uc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH0PR12MB7816.namprd12.prod.outlook.com (2603:10b6:510:28c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 20:24:22 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8466.015; Thu, 27 Feb 2025
 20:24:22 +0000
Message-ID: <ecec8891-1228-4f03-841c-60fb4484c4d6@amd.com>
Date: Thu, 27 Feb 2025 14:24:16 -0600
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v6 02/42] x86/resctrl: Add a helper to avoid reaching into
 the arch code resource list
Reply-To: babu.moger@amd.com
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 shameerali.kolothum.thodi@huawei.com,
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
 <20250207181823.6378-3-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20250207181823.6378-3-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:408:fc::23) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH0PR12MB7816:EE_
X-MS-Office365-Filtering-Correlation-Id: 85d2179f-1c65-4e4b-f670-08dd576cb87a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkFNb3NxcVhya3BSd0ZadVBNMVBiUzBnbnhEeWx3bkc2YkMrYXpkUis4OHpV?=
 =?utf-8?B?WEo0TjhYZFJpNGVIa2MrRFV6OGgxU1BqcXpJdEV5QjdjZWlXVWNyMTBqYmdK?=
 =?utf-8?B?OTFNNEJWUTh5Q3RwckxXTk5tOGNNeEFMREFLWEd1K3QySlBNajRCRzZ3aUY0?=
 =?utf-8?B?WkpnM1MzdENmR2hwdGJtUWV1dlczWHFneGFKdmdKMTBWYkZrdWQ0MDcyVnUy?=
 =?utf-8?B?NXZiejFFNDYrMXBXaTNrSkdKUkl0N1hxZkh1TC9QSHJUbStJR0xPRUFsOEpW?=
 =?utf-8?B?RVJmUHJIR2orU2QxUTY1K1c3ckFhZkl5cmNNTkVNTXpRbW5kWjFrWFZrdmk4?=
 =?utf-8?B?WDVUSFFaOG8vZVNPQlVqSWxTSHpHNFZjaWt1UnVXakVqdS81M0w5czFSTlN6?=
 =?utf-8?B?bkc2V2NGNXUrbFBJM2ZvSzg0ekdBYUdiVEd1UUhBUk51T2l2akI0ZlducHVR?=
 =?utf-8?B?cG9OckNkWWdCS2QvMDZOYXNlMEVWTFFjMlRMZW9jMHU4di96OFNNNmRHK1Bh?=
 =?utf-8?B?TVc1NUxwR3c1WXRRQzhmdFh3SGgzeUZPamdkQmZPZ005eENTSnBIRGNGb3p5?=
 =?utf-8?B?MEcreTBUZ0RjSEkvb2ZWMVR1THBkek9EUGxJcHMwNXVTYVV6WTRjSVF3ZDlB?=
 =?utf-8?B?Uk9HVU9uT0dWMFJuWnU2RWNpOWFOMjgycThxc1dod3pocFgxWElBakY1VUlU?=
 =?utf-8?B?MEpIbldnWFoxazB4ZnR0bjhTNHI2Wk9kYUdWZ200c0FGRytQVUo2TXF5ZTA1?=
 =?utf-8?B?RDIxei81NGJOTUttZGVtb3VEcVlNSVNBeEwzbHRFTE5tTU9LYlBMOFNhUzhw?=
 =?utf-8?B?RUV5b3hpbUYrdjMwM1lWeGtrQ1VWM3haQWI5Y1NUaFpkeE0rbXRDZjZOckl2?=
 =?utf-8?B?RlJDVHVNNHBBeEU0elhYRFV1cTl2M0h3bHhxcWN2b1cwYTFRM01VWkNZcXcy?=
 =?utf-8?B?aWtEWlR1azFzNmhXd24xaU92QUdtSFFNRTZTdWt6YzhLaTdMbkhIakNaVEsz?=
 =?utf-8?B?YmUrd3NyVkQ4YlJmOHpOQlZKZGN1bTNKbFQwUDA3bUZLL3JlYmRzSlhYM3JE?=
 =?utf-8?B?QTFzNTROSzhreVVNZlZuUWJXeTZsUGx1eCtnT1VUampkZkpLejVCQlA2aTZo?=
 =?utf-8?B?U1czV1p5MHBLTGNUMm1wSHZab3ZxcWZnRXVIUHplcE1DdFpkdzdWaWVPbnJi?=
 =?utf-8?B?cVB6WWpGVzQrcTNRT2JhMUhkNFJaNFRqVWhwQ3h6cjh5QjM5Y2RWUGZ6Q0xL?=
 =?utf-8?B?ZTJIdGZydXJzMktBMlpkQUVTclROeWhXQkRmWEpidVNJKzVjY011VnZJUE9R?=
 =?utf-8?B?c0pyZHVvaVhHMVZ1Y2E5eGNLUkp3RS9BLzMvdFBwSGRBOFZvSzFrL0pyV1Fu?=
 =?utf-8?B?d3RlanlMcWFTZCtxYWU2dkdjTEUxOEJDNmFJL0JITGZwWmtldWgwWkhsN0Mv?=
 =?utf-8?B?SHJwQ1ZsRWNKNzlxRURiWHE0cm1TaXcwS290bG1KRDBXUjdnNFFRZ09Ncjk5?=
 =?utf-8?B?V0tKOER4K3BUT21tUlhxM0VpQlBZOWFERUgrWVUzZVlPc29Rcmg0ajFwZTJE?=
 =?utf-8?B?cVdFZHNOMlN1UU1JUWtZVFRBQ0Q1MkIzVHU2Vy9QQzZJVjlyL2ZxTEhFemQ4?=
 =?utf-8?B?QUNnYit6NHdmODk0a1djVFd4QVZTbmFLdEp6WXBqUk82aXE2c3pidlhtL2c2?=
 =?utf-8?B?clJsb3lmeW5oM3duV3VmNlNwTUVDMVBHbCtoTDZ1YXZWWmc1K0lOcHZFV1JL?=
 =?utf-8?B?UjA3UWFjUTFYTzgvYkNNUUc0MWpNWTltMG5NMHhRbjRwOVNrU2FSTGowc0dC?=
 =?utf-8?B?OVFQSXdPVFdac3dncEVERHBaQmFPYkI2WXRybUlteUUwWkE3OGRyUENpdE1u?=
 =?utf-8?Q?f83HhLAZUv1mV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?US9GUlJMMUlUTWo4NU8zK3ZUaDBBM0ttTktGcFVqdWRVcjdJS0NoeXVrRjkz?=
 =?utf-8?B?US9kSVRCOVpSTXdaeWFLSnM3dUM1TitjeVZTMFFMMm01SEZMZzFPRmZkdTNK?=
 =?utf-8?B?RDIrTlZDK0FmV2xsN0NSN3R1K1M3Z2JDWmxYc1B2S2JPcldBMmF4bVJnUDZt?=
 =?utf-8?B?NytLRjRjV1JMUUhzbE11Y0lPRFdLYjgrSWdrWTJPVElhaTdJdTVpajhKT2xp?=
 =?utf-8?B?QjNOVkI1WHNPdGZOV2dseHpja3ZRd1lOeng1RURBTktYVTZ0bnNLbGJIMW1x?=
 =?utf-8?B?V3VKTmRUL2dkZ2VPWVVrRTJVdk1URjk4RGZ0dXpaV3lUY1BITnR5MmdRZ0Zx?=
 =?utf-8?B?YkxhVkRsUlFnVU43b0lRY3ZnYVk3THNld3I2cmpycGlMUmhrZ1BuTEhXVEFP?=
 =?utf-8?B?VE95Y2ZGMDJwOFhsTnVneWRvalFOaHJzRjB1Yk91emFJTDZHUFFBMmMveEFS?=
 =?utf-8?B?cTR1WVpXMnAwRG14VnprMGFlek1zMXhjZlYyMFpRMEJ0UWNyRndFeGJwUkZO?=
 =?utf-8?B?dG5pbFY5QStVcXdXT1BBR2pVelJMeVMwQkNwUUpMbmthcWtzSXJ2NG1rS0dB?=
 =?utf-8?B?M0NnYUNHVUh3TVdndFhJMk1pL0RsaW9janlZcERPc2hZc3lsQ2VEQURFRGR6?=
 =?utf-8?B?YURKZTNTSTZLUmt6TnJLbzBsWGZKUGs3MjM0L1VPeCsvTjUwWDdidWExZFFF?=
 =?utf-8?B?UjJRM09mWE5QUkV5alVESG1hSlkzMVB0K1ZMZ3Y3TU9sQVJadk1jMXZaZGZ5?=
 =?utf-8?B?Zkw1NHRtdW1TUVlOZ1lPZ09qWTdFWWdONUxxU2hDVXd0QUwwQllCZWhrUEhi?=
 =?utf-8?B?TGJSLzNjTW5uUUw2Z0JoVVhOTTI3Nlo4U04xT2Q4SjZELyswOHBEOTBKTWpw?=
 =?utf-8?B?OTZDZWVVbDB0d3BSZUNoRW0remR6VnBWdGRnbWVZSGdrcTZPcGFKNTAvck83?=
 =?utf-8?B?SkxqZHE0NU1OeDBGV1VyNkpEM1kwaXNxOUEzSlYxSHlzNW5QZ1BVRm5nU251?=
 =?utf-8?B?NEg3UEx6NmE5ZmNoVWtnOXhJeWZ2a2x4Nk44Y2F3RHRVWmQwZ3dkeDZIU3F3?=
 =?utf-8?B?T3p6RnVYcHNudDBsdDFrMUhUZnRXQ1lrNk1iZERXRFFpMVhoYi9GL2N6eTdM?=
 =?utf-8?B?Mm1IaWxHOGpKbGlpYVZCR0VlcGIxaFp1MEtWMmk1ZEtWa2pTVnJGMkQxcXpI?=
 =?utf-8?B?aSt6UEt4YWFaSmMyTUpjeUhZUStqcVBkVnh4ZVAyc0JYa2NMTktIRXl6cEZJ?=
 =?utf-8?B?elc0ZXExTFZEWU4vcWZQRFA4bEptSzQ3QzNWRDJXMlpzSFhNSGhmSytvWFdI?=
 =?utf-8?B?dUJzMHFlL2wvc29qQUNWZHFnNmlxZXFOUHh4eVJabGt4TU1qbzJGZDVSR0Ro?=
 =?utf-8?B?aE40VmxPZmRwTGd2bEl2bEdmZEpMT21hS3l1TGhVakx5QkN4eGRpYnJtNU1w?=
 =?utf-8?B?NWpZai9tSnpRNmN1ZUdSSHlxdTRzdVovSVFzajFxYVl0MEFWNVcyTDhKUjBT?=
 =?utf-8?B?VzB5VmFFWjV2Rk0vOWU4d1B0NkYzL3ZxVWU4dmppYUt4U21mT2RseUZob1hG?=
 =?utf-8?B?d0NtRnFmcFFiMUdBd25NRSt1ZDBBRnVVcjVkWGZibEQ5MGw3RjN3ZituV0FE?=
 =?utf-8?B?N09PTVoza2djaHJqaFZjcFZXZDNnb0pBVDZheGV6Wm5rY3BUQUN5UGtUKzdl?=
 =?utf-8?B?d3lBc2xOeXdqWUkwRkRtWXpQakowTFNPOGtjdThXaU9IeGZidHJSM0YxMlh6?=
 =?utf-8?B?YjlmQTFrb2pNdzlGbXNrdWNVOVRPS1JhNUZyWnJBYWhDek04QStZUFFiY2FF?=
 =?utf-8?B?VGNsaURsMVpteG94Sk1Db3p6UURkRWVHYVVaYjc5SmFMRzRkV256c2ZNWEN4?=
 =?utf-8?B?NzNDZFRabG9OUkMySmVhMEhuUk5taXRNVm96Y0VKZ1A4UEU4SkdVRFFucXUv?=
 =?utf-8?B?YzJ1bml6N3o2R2g3OUNtQndUNEJhcFVGaXJ4RGd4dEdVTFJZaVlDU2k1MnF5?=
 =?utf-8?B?RWpkNjRMWjhjQ2s3TXdlMWtOdHBwamRvZzBOWWpsc05BdVlSdmU3NXUwbXlV?=
 =?utf-8?B?bHpSRWZua1pOOVZ0clVyemJaVzZhZXFSTG8vLzRPUUVxMEswRURvMDNBeTFP?=
 =?utf-8?Q?Yxr8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d2179f-1c65-4e4b-f670-08dd576cb87a
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 20:24:22.2640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01tbz+GfX7DCcfATnY3P9CagkJupjlOWoe00t4llY/mnTTfYlkM5RiQNaRww4TST
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7816

Hi James,

 You probably missed few cases here.

static int logical_rmid_to_physical_rmid(int cpu, int lrmid)
{
  struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
--

}

Any reason not use the new call resctrl_arch_get_resource() here?

Thanks
Babu

On 2/7/25 12:17, James Morse wrote:
> Resctrl occasionally wants to know something about a specific resource,
> in these cases it reaches into the arch code's rdt_resources_all[]
> array.
> 
> Once the filesystem parts of resctrl are moved to /fs/, this means it
> will need visibility of the architecture specific struct
> rdt_hw_resource definition, and the array of all resources.  All
> architectures would also need a r_resctrl member in this struct.
> 
> Instead, abstract this via a helper to allow architectures to do
> different things here. Move the level enum to the resctrl header and
> add a helper to retrieve the struct rdt_resource by 'rid'.
> 
> resctrl_arch_get_resource() should not return NULL for any value in
> the enum, it may instead return a dummy resource that is
> !alloc_enabled && !mon_enabled.
> 
> Co-developed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> Change since v5:
>  * Ensure rdt_resources_all[] is always padded to RDT_NUM_RESOURCES
> 
> Changes since v1:
>  * Backed out non-functional renaming of "r" to "l3" in rdt_get_tree(),
>    and unhoisted the assignment of r (as now is) back into the if ()
>    where it started out.  There seem to be no uses of this variable
>    outside this if().
>  * [Commit message only] Typo fix:
>    s/resctrl_hw_resource/rdt_hw_resource/g
> ---
>  arch/x86/kernel/cpu/resctrl/core.c        | 12 ++++++++++--
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
>  arch/x86/kernel/cpu/resctrl/internal.h    | 10 ----------
>  arch/x86/kernel/cpu/resctrl/monitor.c     |  8 ++++----
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 14 +++++++-------
>  include/linux/resctrl.h                   | 17 +++++++++++++++++
>  6 files changed, 39 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 3d1735ed8d1f..12b41316d8f7 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -62,7 +62,7 @@ static void mba_wrmsr_amd(struct msr_param *m);
>  #define ctrl_domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.ctrl_domains)
>  #define mon_domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.mon_domains)
>  
> -struct rdt_hw_resource rdt_resources_all[] = {
> +struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
>  	[RDT_RESOURCE_L3] =
>  	{
>  		.r_resctrl = {
> @@ -127,6 +127,14 @@ u32 resctrl_arch_system_num_rmid_idx(void)
>  	return r->num_rmid;
>  }
>  
> +struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l)
> +{
> +	if (l >= RDT_NUM_RESOURCES)
> +		return NULL;
> +
> +	return &rdt_resources_all[l].r_resctrl;
> +}
> +
>  /*
>   * cache_alloc_hsw_probe() - Have to probe for Intel haswell server CPUs
>   * as they do not have CPUID enumeration support for Cache allocation.
> @@ -174,7 +182,7 @@ static inline void cache_alloc_hsw_probe(void)
>  bool is_mba_sc(struct rdt_resource *r)
>  {
>  	if (!r)
> -		return rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl.membw.mba_sc;
> +		r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
>  
>  	/*
>  	 * The software controller support is only applicable to MBA resource.
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 536351159cc2..4af27ef5a8a1 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -649,7 +649,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>  	resid = md.u.rid;
>  	domid = md.u.domid;
>  	evtid = md.u.evtid;
> -	r = &rdt_resources_all[resid].r_resctrl;
> +	r = resctrl_arch_get_resource(resid);
>  
>  	if (md.u.sum) {
>  		/*
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 20c898f09b7e..75252a7e1ebc 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -512,16 +512,6 @@ extern struct rdtgroup rdtgroup_default;
>  extern struct dentry *debugfs_resctrl;
>  extern enum resctrl_event_id mba_mbps_default_event;
>  
> -enum resctrl_res_level {
> -	RDT_RESOURCE_L3,
> -	RDT_RESOURCE_L2,
> -	RDT_RESOURCE_MBA,
> -	RDT_RESOURCE_SMBA,
> -
> -	/* Must be the last */
> -	RDT_NUM_RESOURCES,
> -};
> -
>  static inline struct rdt_resource *resctrl_inc(struct rdt_resource *res)
>  {
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(res);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 94a1d9780461..58b5b21349a8 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -365,7 +365,7 @@ static void limbo_release_entry(struct rmid_entry *entry)
>   */
>  void __check_limbo(struct rdt_mon_domain *d, bool force_free)
>  {
> -	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
>  	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
>  	struct rmid_entry *entry;
>  	u32 idx, cur_idx = 1;
> @@ -521,7 +521,7 @@ int alloc_rmid(u32 closid)
>  
>  static void add_rmid_to_limbo(struct rmid_entry *entry)
>  {
> -	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
>  	struct rdt_mon_domain *d;
>  	u32 idx;
>  
> @@ -761,7 +761,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_mon_domain *dom_mbm)
>  	struct rdtgroup *entry;
>  	u32 cur_bw, user_bw;
>  
> -	r_mba = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
> +	r_mba = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
>  	evt_id = rgrp->mba_mbps_event;
>  
>  	closid = rgrp->closid;
> @@ -925,7 +925,7 @@ void mbm_handle_overflow(struct work_struct *work)
>  	if (!resctrl_mounted || !resctrl_arch_mon_capable())
>  		goto out_unlock;
>  
> -	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
>  	d = container_of(work, struct rdt_mon_domain, mbm_over.work);
>  
>  	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 04b653d613e8..45093b9e8e63 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2256,7 +2256,7 @@ static void l2_qos_cfg_update(void *arg)
>  
>  static inline bool is_mba_linear(void)
>  {
> -	return rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl.membw.delay_linear;
> +	return resctrl_arch_get_resource(RDT_RESOURCE_MBA)->membw.delay_linear;
>  }
>  
>  static int set_cache_qos_cfg(int level, bool enable)
> @@ -2346,8 +2346,8 @@ static void mba_sc_domain_destroy(struct rdt_resource *r,
>   */
>  static bool supports_mba_mbps(void)
>  {
> -	struct rdt_resource *rmbm = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> -	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
> +	struct rdt_resource *rmbm = resctrl_arch_get_resource(RDT_RESOURCE_L3);
> +	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
>  
>  	return (is_mbm_enabled() &&
>  		r->alloc_capable && is_mba_linear() &&
> @@ -2360,7 +2360,7 @@ static bool supports_mba_mbps(void)
>   */
>  static int set_mba_sc(bool mba_sc)
>  {
> -	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
> +	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
>  	u32 num_closid = resctrl_arch_get_num_closid(r);
>  	struct rdt_ctrl_domain *d;
>  	unsigned long fflags;
> @@ -2714,7 +2714,7 @@ static int rdt_get_tree(struct fs_context *fc)
>  		resctrl_mounted = true;
>  
>  	if (is_mbm_enabled()) {
> -		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +		r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
>  		list_for_each_entry(dom, &r->mon_domains, hdr.list)
>  			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL,
>  						   RESCTRL_PICK_ANY_CPU);
> @@ -3951,7 +3951,7 @@ static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
>  	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2))
>  		seq_puts(seq, ",cdpl2");
>  
> -	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl))
> +	if (is_mba_sc(resctrl_arch_get_resource(RDT_RESOURCE_MBA)))
>  		seq_puts(seq, ",mba_MBps");
>  
>  	if (resctrl_debug)
> @@ -4151,7 +4151,7 @@ static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
>  
>  void resctrl_offline_cpu(unsigned int cpu)
>  {
> -	struct rdt_resource *l3 = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	struct rdt_resource *l3 = resctrl_arch_get_resource(RDT_RESOURCE_L3);
>  	struct rdt_mon_domain *d;
>  	struct rdtgroup *rdtgrp;
>  
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index d94abba1c716..37279e2a89da 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -37,6 +37,16 @@ enum resctrl_conf_type {
>  	CDP_DATA,
>  };
>  
> +enum resctrl_res_level {
> +	RDT_RESOURCE_L3,
> +	RDT_RESOURCE_L2,
> +	RDT_RESOURCE_MBA,
> +	RDT_RESOURCE_SMBA,
> +
> +	/* Must be the last */
> +	RDT_NUM_RESOURCES,
> +};
> +
>  #define CDP_NUM_TYPES	(CDP_DATA + 1)
>  
>  /*
> @@ -226,6 +236,13 @@ struct rdt_resource {
>  	bool			cdp_capable;
>  };
>  
> +/*
> + * Get the resource that exists at this level. If the level is not supported
> + * a dummy/not-capable resource can be returned. Levels >= RDT_NUM_RESOURCES
> + * will return NULL.
> + */
> +struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l);
> +
>  /**
>   * struct resctrl_schema - configuration abilities of a resource presented to
>   *			   user-space

-- 
Thanks
Babu Moger

