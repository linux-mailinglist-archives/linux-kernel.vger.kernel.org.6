Return-Path: <linux-kernel+bounces-550294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB952A55DA1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C75A175DEE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107671632C8;
	Fri,  7 Mar 2025 02:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CK9Ms20C"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4DA168B1
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 02:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741314229; cv=fail; b=pve82W7RPxpGuwPB1QlcsUonR/4XJIywfWI8CP3wNJwuSGgzr4u5XQDLvikGFuvmc691ierzazazF8qyURdntAl0hE/e8R/eWKudSp3CiQ4sXX4neMYnhnSRUMt9VQTNo6CHh9rEuPBLGcLcBRXEpPZopFzjiIInYdn4l0VC/4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741314229; c=relaxed/simple;
	bh=kdqwP471Z9JjO8JxW95PuJQ2PWW3/kmGs1B7JlLLgWE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sqXToLDmq3srMQeKeifVYzoh7JUophwc2D4ghsj9KognGFxH/1lx/8qrBvE16d2VkHAFBoSczEcEcdgmGhgFAA7JNv1V00z1zMvy2MyIqMaUkjSfjTNCBo9jjbv8UsCUa8EP2YKKQnfuU6yyiAMXLPMCD3dqEXSmaDdoiy6RUVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CK9Ms20C; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTuP/bJ36lPiYDXIBGol6/bhAmSydPWrLnUoYc+g/o45m0ErQftpMlgbTiun9VGgf0NUCbG3KUWiBdLt1rH7h12wSMCQdzVkiT/39wBFaGr0D/5iaSNjeCFyNoVDe39TVzTCZCbUABge3+EFXnMepFknaxTNqVwnrrjlvaBwccuL7jibZNMK75aYAdIMP+3pM1dwNCHILpNT2PVPalmtitnEq7pT+J2oR+7uztdVGWj0la7JbDdNyA82idruWeaXfdZqqcAxlqMDXadPgvncaFo4ZWgEU+SHB12OGy96Vn8RCjBRDimLe5af0tbHaNKPKe0A9J89Aj9y0C/UgFh5hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdqwP471Z9JjO8JxW95PuJQ2PWW3/kmGs1B7JlLLgWE=;
 b=rrT47CcCFR5aROiYuWrRIVuLv+/CQs7/M5QiXoOLKeYrp5VqN3vtiTj7bfJ8VyDtpA076RNLK2g5Hyp+cL63ejJCEIghFXZHjq+Vo+m3voN0iXrmG40KpGbqgJlKFZSwiOTIFiyXWZvTyB5Ad1QP22Xaz6qpJeF/Xzk+yXPGibPOhBJW+31gghJLyZss+n1NDcvHRTvOJYvCFfgoeaiRp/9GSMu5l2yNe2PNqn2CE4AgfA1xs7B3x5YizMKvuN3GyZqK+7l+slUlk2JvbiaY223mRCZH7Ue/76NZoG5Qtp2QNE1dhBhFE0xZjo7bqecbKSF6zL4YUJ3mVFECVJRISw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdqwP471Z9JjO8JxW95PuJQ2PWW3/kmGs1B7JlLLgWE=;
 b=CK9Ms20CJSIoJ1y3a6esmjGhTC6kqvISaeu+Pk8KaiF/HVIFxhfUP64JqJ/oyWXzZiNLRXmME3dEcUXoKrsrW/wZoBmGxFLGA0vpEKp6uJzz1jua4/dTa+gZW066PjEx3lcWF7xhOpWJbb8E0z5S42fmZar8S7jTjApJ448aaZjfybRaUaTN3DhQYVaQKN+E4m3VKHr5S7kCcvwdxm875rwtuuA3Cs0enVJ872e5R6XN0v1if0GPPpyF/CvP9yWpjm14h+4baUcCH3ttOf/+Mj54pFHhs07bQbJs0Yvu7ubkwBvz4pvSeKoWEH/1PM0syJCKCJ+xCjS93J0jJw49EA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 CY5PR12MB6084.namprd12.prod.outlook.com (2603:10b6:930:28::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Fri, 7 Mar 2025 02:23:44 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 02:23:42 +0000
Message-ID: <786a1b18-d5d9-466c-bbd8-c846e747d9c8@nvidia.com>
Date: Thu, 6 Mar 2025 18:23:39 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 43/49] x86/resctrl: Prefer alloc(sizeof(*foo)) idiom in
 rdt_init_fs_context()
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
 <20250228195913.24895-44-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-44-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::29) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|CY5PR12MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: eba90ec9-0bc9-4acb-e7f9-08dd5d1f1408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bllGKzdyWmhSeVV0Rzd0SEZpL0xsRjI4cG55djBwRE1JRzhDZUc2QjZMakM4?=
 =?utf-8?B?dmd0ZFFmRnlYeHQ5cXVya0RnZzNlbkcxcEE5OW4rcDdGNllyOXFtMnlpaG1G?=
 =?utf-8?B?NEdKbzVhYjVKSlZoZEVUZjRiTk5JTjg3aEZQT1UzblB4NU1ucmlpY1NQa05k?=
 =?utf-8?B?S0xkck1CYXlJQmhmQ20xQXMxaXMwZS96RkVRdjdXdEE4TW93aXFXWHdKamYx?=
 =?utf-8?B?VWNicy9rMkFUYWM3eGlpOU4rNDdJMWc0aHpVdmRoMENJOXhSWEFZSmFZdVlS?=
 =?utf-8?B?VE03Y2gyd0RwQm9CNFRXMGp0eVlJRUE1SGhlK2lvTDQxQVdvZXJ3RjJDclNU?=
 =?utf-8?B?VmlRUllVUFh6cHgwUlN1QjhYTjRnS05RTVZJaC9KTG0xbGdkRDA5NHRwMjJS?=
 =?utf-8?B?cWhFelZ1K2hNUWVlaHd6YXFqWkNYNE9XeHA2bSt2a2o0UFRBQ3lRanFnZ1Az?=
 =?utf-8?B?NlI4MmMrMElKUWRsUjdwT3BJOWxnL1ViQlRZMEVVU3RkU2lMdGhPc3JxWTZH?=
 =?utf-8?B?L3gyaU04Qy82TGJaZ3JvakdyUFJheU1DZkF6U0FaNWFtRHRTTGVMRUNpYzBq?=
 =?utf-8?B?ZytMYTdrWCtVMXhKb1FkMHc5eVVaQ1hBMWxFdUJUcFVhVGRvN0FzS1RsZTJa?=
 =?utf-8?B?QzMvazRSUm5JZmRqM21laUlqZWhZQklFNE9weFdDUTFGYmIxSGRQTEdTSlNT?=
 =?utf-8?B?bGt0L2hKUk4xM3g0eitNVWc4OUg0c0hBYkhzeHR5YnYwWUNhNUV2ZzJJVGpV?=
 =?utf-8?B?eGhodjJRd0pYcEtqWlRmWi8zYzZENjl5ekMxb2IwYTJSYWRxWTNBVG1vVWZG?=
 =?utf-8?B?bzZCYXFhSEFYK0trRlR1NWk0NHlLdHo2RElCakNlUld2N2lIS3ZKUm8yd3Rz?=
 =?utf-8?B?d0hZNWZwR3IwOEFBNlNpaG4yZWZsbC9WZVFWcTc0QUJQYjY4TlFRNEs4OXF6?=
 =?utf-8?B?Mk5HTCswZGVXczUyZkc1Q2xSSDVKS3A5MlFIZVptNGUwWk50a1V3RWJQZDFK?=
 =?utf-8?B?dFc1QkFBcWNQZkc5N3djQ1JOdTl3YjBwK2lVc2VUWlBtUlhVZjVWL3oyOSsy?=
 =?utf-8?B?ZHRuSXpsZTZEZ21ReFlOYmZuRFVFc25jYkJrSmdnbS9vaWJiMkFTSHBlOVJ2?=
 =?utf-8?B?ejJiKzJiRTdnSDIzRHlESEM5QXBoV2VsM1NXNmhaZDRFRUhhUjdVRk9rVkRF?=
 =?utf-8?B?ZVBSYUJoSXg5RlU4c2orQmlGK1lzd3d1RXIzL3RXcnMxVktIa0JGaDRKWFdy?=
 =?utf-8?B?ZjFscURyeTJwbGFrZklxcnIvdjV6RTB2akgwVjNQc1JmaFFadWVTUHRZU01N?=
 =?utf-8?B?NTNETGZVYm5HRjRmTnNrTDliYnNZenV4cFJSamhQOWo0RFZiRklsNjNaZjlq?=
 =?utf-8?B?dkFyOTh3Q3Yrcks4Tk1oN0xWWElZb1dzMkdSWnVpSDh3RmdqZk1OdC9zRFoz?=
 =?utf-8?B?OEZZclNFYTJhV1U1TFJTaElRUzV5amhLSDVtNEhsbVczeXZiYnFPd0Z1SHdS?=
 =?utf-8?B?OTNnSGgxMTZKR0w5MEJhQUxLTnhaa3B0YU5YUVNTMkw3Z3VsNjBndFB2c09I?=
 =?utf-8?B?b0N2bXdPb3hVUEtIWVdqY0E2RG1qcnQrdm0xYXFDR3JqNlRBYkE1MjVIaGZ1?=
 =?utf-8?B?Y2hXR0RrdXg3RGFqbHY3TnFuaVZTbHhPZHBlU3N6WjdVZks0SXRPR1NZKy85?=
 =?utf-8?B?ZHg2bjJXTjdsMjNUZzgvRFNTRk1laFFxaW93SjkxRGQ0ZnY4VlJoZ1hRWjFG?=
 =?utf-8?B?d2p3aUp5aVU3SjB5aU5QYjZqNUxwK1kvTDEzZmpWRDBSVXVvdEZLWUJlMUZO?=
 =?utf-8?B?MUVzNzI0aER2UFcvZ3hhYTZOTFR2WlQvL01LT2tLMlY2SXR1QWhQUm1mNWl0?=
 =?utf-8?Q?5aKS+2+A3IgC2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2FpMGk3K0ZWcHdOaVkyd0J0SlpjWEZ1U0J1djJtRTljZWRpTWhCNVBSc2Fq?=
 =?utf-8?B?R3NqcE1OckJ4eFBPM1FrM25iYmJpVy9pVmlnby9xdHA4em9JVDU4OSt4cUw2?=
 =?utf-8?B?RXdRaDZTS01WZG5HaE5PMFlnZml1b3o4UUNqajVHZ3oyVU80cEhVOG84QlN3?=
 =?utf-8?B?YjhTQThZU2Z6NjduMnNzRktNZjM1UWRyOFE2cFk5S3VIY0Q3UVUzRC9DWHRl?=
 =?utf-8?B?cWJyb213U0hPVW9oeHlpTXI5Yk5rWEl5WnpnbStkV3htQisyMEhXaGhIckdm?=
 =?utf-8?B?OUVtd2xTVjVpMXpYekQzcjJYTG5xejkrN1ZiUy9JYVBoakRPTXRzQ1d6MXNB?=
 =?utf-8?B?OFhLS2NDd0xTK25HWGVxWUYyczlCUHJ5Tk1VRWxSVVE0Q0s4TVVpRSsxbUMv?=
 =?utf-8?B?T241eGdsRGFoTU43TjdQZmZWNHVCa2pHcThUTFdhQlpDb29waStFL1djQ3hn?=
 =?utf-8?B?TXNFcmZFV3JrNWVRdmU2NlpCTmx3WFlTTlJlYlZRVVBHQjZ2TkNSWTJ4TGJN?=
 =?utf-8?B?aVRZRk9heWpkS09maGQ3SjRPT3UvaXBmQ0FPVDllbXk0NVVCc2VFMzlQaENI?=
 =?utf-8?B?WU9JUms0Wm1nOHdRZUV3UUVxK2U1dUZhNSs5YkdUT1hRVzR0SUdNL2NoajJL?=
 =?utf-8?B?c3picE91eWtZRFIyNVM0TnJDam1VWWpsMmt6OUU3Zy9XaWxsRlExS2phd1ZQ?=
 =?utf-8?B?VThPSGJ5Ym5FTVdsaGJueTNQSGJub21zcnZKMDQ2cVExM25SVllZUzJZd3Bm?=
 =?utf-8?B?cUliUzhwTzkvc2tLL2NlRFIwbVZNL25kSXJTaVExQ2hFZFFpVU1Sd3dXQVRk?=
 =?utf-8?B?clR6aGp0dThmSzhENTlCSTlkNTdyZzZETzV3MTZYdU1RZno5cFpaM1pHOHBX?=
 =?utf-8?B?TTcxZlBBNnhpS0NXRGcwRnJuOStiODBBTTk1YmZvMGJEclduaTBVUllOUkJL?=
 =?utf-8?B?WnpRYzIrSVhrQkxqTDZ4THNHNHpSSmo0RU9QTVp4ZGorZ2dDS0hMYzdHNmxC?=
 =?utf-8?B?ZjVmYmdEV3lMaDFwaUpxM1V6bnZ6cWgvWVIxRm85OUxsVE15MUcyKzQ0TlJ1?=
 =?utf-8?B?M2s5ZHpSVHNPMk4wenVBLzdzQlpTV05Fb1ZzTFRTNXdBemdmelNEazFMci9i?=
 =?utf-8?B?QWlNdmFqZWpRNEhSMlpHcXRzeTZmQUlPWTg2dTZZd2pEUms5cnBsQkFVZnJh?=
 =?utf-8?B?dWc0MVBuZG4yL3V2SXBnSlVHTXZESWJlcUJQY0thMzNiYmhoL3FIYTF3UlpF?=
 =?utf-8?B?U0hlM0crNkMwOVpQM0oxSmRVWVNET21hazIxeUtFemRmbzNhZ25wWjh5QWsv?=
 =?utf-8?B?Z3pPL3VVTlFQZ3BmVWdBMDMzY2R5SjRWNHRWUkhOZjRHdUxKWEt2UGdJWldu?=
 =?utf-8?B?aDhvWnY2NXowSVZWb1FCcVJzQXZERVlFSUpUWlJVNlR6Vzg0ZEpTa3dyM0dD?=
 =?utf-8?B?dFJMUlZzM3RsMEVKL3pyRkV4dGZqSktJTHJRRjBWQjBDWHFXMzdqZFZvRTlt?=
 =?utf-8?B?cHFlWXdoYXJabWFLK0VzT0hhZ25xcWpOd0ltUG52Z3NxUlp3dlBkaEZuSEUr?=
 =?utf-8?B?M3VJUFFpYno5YWF4MmtrQXgyNVpBcHZUem9wS2l2c3ZhVVNxZG1rTXRZdnRj?=
 =?utf-8?B?dHlvTVIrb3Z2eUpEYWI2YVlNM2x2MDFGaE1ONUt0ckhjaTBXL25NRTdSMFNt?=
 =?utf-8?B?QVp0R1pJRC9FWVAwQnZhWFprejJyaXg1YVVEZEEwMC9DbXl5SDRyUGJPUzZ4?=
 =?utf-8?B?bWZhSjcreHJ3d1V2MEltYkxpaVVLdURuRXlzSXJETFFpSlpOdHVFaEFJWm9j?=
 =?utf-8?B?SWFFSDlJU3NCbHpjUzhyK1p6eHNpY3RSaWpISW1mcDllMVRnOXJWNFlBTUVU?=
 =?utf-8?B?Qkdjd1AxSS9HWXluSnNPSytvdWc0L3kxY2xtclBDRnd2Rzdnc2RZSE1rVHNz?=
 =?utf-8?B?UlkzWVR3SWRxYkVSR2hjM2pSNnRDSDVaZVRPWnE5c3FkN2hYT1BKMWlnNTZy?=
 =?utf-8?B?WWppckdieTZ6c3FqQmh1U1pxcjFaUGp6N3RPM21BdUQ3Y3lXcGpFLzBSTEZB?=
 =?utf-8?B?NjhDaDV3eVlVWWltZ0tzRWM5QzdydGVNUEZ6b01Vc3RPZGdnWERpT1BXQVFG?=
 =?utf-8?Q?nCCmbH4yACXgwo1kBfZYg6N2t?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba90ec9-0bc9-4acb-e7f9-08dd5d1f1408
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 02:23:41.9856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GtJkntczZkKBX6yhIXq+auLxzpUoDC77JhXzFPdaSEvXFWWhVWj/8djCljzIgAHc+iJbtu7QNM+uIq6P05+ALA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6084


On 2/28/25 11:59, James Morse wrote:
> From: Dave Martin <Dave.Martin@arm.com>
>
> rdt_init_fs_context() sizes a typed allocation using an explicit
> sizeof(type) expression, which checkpatch.pl complains about.
>
> Since this code is about to be factored out and made generic, this
> is a good opportunity to fix the code to size the allocation based
> on the target pointer instead, to reduce the chance of future mis-
> maintenance.
>
> Fix it.
>
> No functional change.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua


