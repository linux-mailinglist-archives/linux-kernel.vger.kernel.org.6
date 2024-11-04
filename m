Return-Path: <linux-kernel+bounces-394584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D91529BB171
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FF4A1F22794
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F108290F;
	Mon,  4 Nov 2024 10:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ok3zOry7"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690811AE861;
	Mon,  4 Nov 2024 10:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717145; cv=fail; b=HmazZ4x1fSozlrCnIdUskdKVVs/T0Q7XRhGtgN22R/r1KGkgGS3myw/eT7LEBrpgNSrZyWkRM6ZWH9uDBWhTJP/OjfnVIrrTWiUR16awf5+NlkH5uABPQHseEXEWMznZ37Xq/Sas70IWIsZ7ugXx+5Vk37KWdOSZPXT2S8O/2MA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717145; c=relaxed/simple;
	bh=J0A6G6+KzRD1H/M94WQDlZFxZtxBEoJxc6jmRB0awv0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uRL8vXXlTufx08Pwble1tjyuABQnz5fjb0X4QIA6f+D+WcSxX3BbuBtCsRw3SMCS3rxZ6/M66QVK6CeBkRsbvAoRmFf0YYlwIEdHN6m6wKXKsfSTAupa5g5DVznake4fiLfyhErUmhg5/XGpmun9gIderQDg19d7jOkbT5LxD+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ok3zOry7; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajx2/ZTMAb6LrZNVsTUzNdjQjtfK2kJqJKTNczKqMyoCk64hHjp/pQPcFPFodesheoz5oDeW/Fk9swsDifzoKIHCZOWASQLTszbL3K6m3YuBpwD50o2hBW/BGu3GvM6trVUjXB6B5R8+8xAcT2qloNpXUwda9pKjU6nCLKfCGw4KQDEKWmWp8FthwyQxLAuUBCLYxFy2Ud77rSKp6bcYHBkAt2Ee5dRVM5+2Oh4VEDe4OLHkjZy3G3bkraETf0NFxell1OeM6qANASc7iQ3yfYyZnFLYGOkWINl/P480qhGc4mDlhoeeZ0VH8W4wr1R7ejfqyb925KcZVpa9ZShcHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLTTwJXHylKMc0JePpMQo2lSXcb7Q9uzseMK3ySwnMg=;
 b=fp1/CQnaT8Efbn+aqb1uwEvQty7pOB6E/xQHpBCYHCcnkVAE24q9pR7cDmEgLypd/4F2d6u/PaT57f9lfyNJgj57hv+ZQJSI0FjySHn0Tn7mYqZXchGwDakx7FPm8OpnkDQzSIhMN9Y5hNVznjDYA0JSziNRXqtIQ+0kfShQNSCOTE/2o2Upbubq+PkUVsRi5f2cBYtwcpCgHq9g7i1xTBc2YS/Av+RD1qXsS3UQZDxyrY1XG50YwOznmkk9A59paFBA/yrzyUg7XSzp/YX25TN9lWk790/rYkBmrp2LKH4kv9ff5+JM7K631gJC72AMN9WuCZWsX7ZLv4+E+MI3aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLTTwJXHylKMc0JePpMQo2lSXcb7Q9uzseMK3ySwnMg=;
 b=ok3zOry7wD0Y3S9D290lCy/PjOC1YYEk2l2l4kjiPD7zZoG1hBvbiundYST78YDbDbAbDNLH4QdYNKUAOYYPqWitBYkBzf3GCHhutRZFUbiHcFDQrxK6YYheKh7Yf/VJG+1/3jdH8OwAFuNKHhgsMP096J9eUm6MN3p5mEMpNnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21)
 by DS7PR12MB5958.namprd12.prod.outlook.com (2603:10b6:8:7d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 10:45:38 +0000
Received: from LV2PR12MB5966.namprd12.prod.outlook.com
 ([fe80::7c1b:5fa1:7929:fd81]) by LV2PR12MB5966.namprd12.prod.outlook.com
 ([fe80::7c1b:5fa1:7929:fd81%3]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 10:45:38 +0000
Message-ID: <e7a45f09-16fb-4d15-b1e4-0a3ef3f25dda@amd.com>
Date: Mon, 4 Nov 2024 16:15:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] platform/x86/amd/hsmp: move hsmp_msg_desc_table[] to
 hsmp.c
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Arnd Bergmann <arnd@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 song@kernel.org
References: <20241030210019.2858358-1-arnd@kernel.org>
 <582e3574-1823-0c1b-25a8-6a4a6bf73f63@linux.intel.com>
Content-Language: en-US
From: Suma Hegde <Suma.Hegde@amd.com>
In-Reply-To: <582e3574-1823-0c1b-25a8-6a4a6bf73f63@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::13) To LV2PR12MB5966.namprd12.prod.outlook.com
 (2603:10b6:408:171::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5966:EE_|DS7PR12MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b3801e-1f34-4c60-6ebc-08dcfcbdd1cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1Nmb2pWQmNDSkxiU0hUZnYrWVJMK1N5V0pnMVNidXhRU2IxZTlPVXliS0R5?=
 =?utf-8?B?aUd4Q1JwNGVrNTlZdURZK083bXRjczdjYS9GeVAwenBuQWd0SWJSOFZybXI2?=
 =?utf-8?B?UmVYZ3lxZWM1Q0NScGdiMXNMNFg4UCtVVGhIOUZ4ZXlPMFlHblowamJ1RWVH?=
 =?utf-8?B?WHpwNFpiYWtObE1nRVFwWjg3eUJBS0t2dlNmQXNOekR5TjBpSXhRaG5sVjVC?=
 =?utf-8?B?UC9VUkVaNWo3a3B3VWc2Y0lrUGdCZ1dWaXRnVkVIT01uWGMwcDdCRjVoamc5?=
 =?utf-8?B?QklBT2FPQ3c0b1FFVXlaSjRoT012Q282ZCt6TGdjQ2FvZTdRWVJXbnBFYlZI?=
 =?utf-8?B?WmtOVWFpSWJjTUk2dUxOb3p1OEdvQit6cnp0Tmg1WVRlcGJScGl4cStFV2Rm?=
 =?utf-8?B?ZEx4by9GY21HcjJTa3pMSlY4Y1MrcU1wZTZFVzZ6NVNQZTFteGd5YzkrVHk4?=
 =?utf-8?B?QW9BdGNIUkdvSXR3YzJjSzhaUUhDV25qQ1ZZcnFpWTRhTmo3RlRjbGRSM0g4?=
 =?utf-8?B?ZzdHRjFnY1Y5QUJUQkNUYWhCODZuTGF6NXdJVExlZ2pLejFvRWNzYVZDb0Qr?=
 =?utf-8?B?NDZPUy91YzF3cU9lZ0tiMXRFc2xCeENBVkhjOElqak9jK2puRGFFbDdJUGI5?=
 =?utf-8?B?NnZrZHVDMWkzNWlZamNTM1VmdVlvZzkwMGJmaTlyQzBjMkZWT0RlT2F4MzAv?=
 =?utf-8?B?eUNBZUN5Sm9xV0s5V2w2SG03Yzk0L3BocTJtaXFmQUsrRTUxUVlyMng3ZnhM?=
 =?utf-8?B?RmRrR1ZDSEhDK09RNm04NTFuZngzRVZ1UWtVWVhhU2t1L2lkZW1OTUlMV1Nj?=
 =?utf-8?B?Y2ZHZDRHUmdTL3UzRjVSMVJWbW1YVzFTdUtzNXphd1h0dEFqYTMwa2VEbXFJ?=
 =?utf-8?B?Rm1SUnVDOHJXVEpMWG1RK2pnM3ZxT3B3bnJXVDNGdXJzTFhvT3BmRWxXWG9i?=
 =?utf-8?B?VXlrbm9oMXBJbzZmYkQ0WnpncTFJenVlaWhOQnFjdXRDSnBmZm5qbndmOEFp?=
 =?utf-8?B?RFNuNFZHU3IrbG9pRVBNQWNGQzVsb25Zd3dkT2Zyell5TTlTZjM4UGR4Nmpy?=
 =?utf-8?B?VUV4KzRJRkVoNE14c2lJbWJlYzh6dDZJdHg5T2c5aWZaV2JDMkd0WmthMGFI?=
 =?utf-8?B?eEg3M0RxZXlqWXBUYW4zaFFkamRGTTB0V3VjRUxjd0dQT0RTRU52YXMvbW9P?=
 =?utf-8?B?UmptV0UyYUIyVnFQS05JSU8rODRNZkE5Rk1GSnUrdmZkUmQ4Q0dKaVdqb2Uy?=
 =?utf-8?B?OFl5MjIxVDBnMTdYZjBJQU9mdDg5WGFHRkRnTmsyM2ZEVXdkTTE5U1lIZ0o4?=
 =?utf-8?B?ckFBU01JYmRIV1MwcWhuRGFaVGpYZ1ZNYzJmZWtPT1ZqOWdpY21IUEpEYUky?=
 =?utf-8?B?ZHgxL1FibTRmR0pwR3BjN1BlRVlBTytic0tmaDFDNDBrTnE2KzhzUUxUdUp1?=
 =?utf-8?B?L3Azc1dmLzVBZEpYcFBjQk96OFZxanVlWTJFNWhTNFFaSk1jdEE2dkdBK2F3?=
 =?utf-8?B?dFpsY3FTSXhvWmh4QlZKZDRvOUhlcUl1Q2RQVFBGT0JBRWVCZWdKM2FWUU5n?=
 =?utf-8?B?MUgxZmxqVklqdGE0VmRhNGxyOHM5VS92bURJTUFOaDlvaStIaWpPYjNyT2Vo?=
 =?utf-8?B?TUpqRjR2MHc0MU5PN0tUOHlKdlA0ckJNSzBmMjczeERuM3BqL29yWVVXVXI1?=
 =?utf-8?B?WGRTNysvTEpQLzU1WkJISU5IL1hoZTcxT0hMU21WK1BHTnVoVk1EQi82TjVW?=
 =?utf-8?Q?MXu+GK/awum6eaXragosnD7Cuwe7AJgZeEU+gYf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5966.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0FSMHlwUmEwVUtzL21Fa2x0NmlrRUlaK1I2dVpmdnYvMWRqNW9LVnlxQUwv?=
 =?utf-8?B?YXozaDRzSXpjUnF1Z01RVHdzR3M1c1BnZ0l0NkVuSnJwZDVhR3l6RGR1aW1p?=
 =?utf-8?B?UkRvUWJ2UEsvL2N2bkp0K1dmSVRqcUdjSDNBdndVQk5qMnRBR3pZVEEwd1dY?=
 =?utf-8?B?b3hyY0h5SU54OU1yc3I2dDV5eWVIQTVFWHRuVjBGZnZhVVpDcGIvaGVLQzg5?=
 =?utf-8?B?OXB5Y2c5d0VoRk1wSWdJVStEQUEzS3FVaDROdlprSVNQRUlaY3BqbGRqUk9B?=
 =?utf-8?B?VHpwL0FFSnFUZjl1TnpFaktyakorOHJEMHJqOW82WHVqL1BCMUZFZGFkMGFu?=
 =?utf-8?B?bGN2UllYL081dWd2QXovRzh6dVZNRUt0MEVua2JrRG52OXZ2b3J3Tnp0ZDgv?=
 =?utf-8?B?R3lHVEFWSjhzeXYwUFRkbmc2c3hxSUdkV013L3l3Y1ZZRjY3Y1FZaVlib3Za?=
 =?utf-8?B?V0UxanhJYXNSTmFmakhCRi9TbWZFSjJyM2FEdUxRZlZpbUJib2d4eVZnazRi?=
 =?utf-8?B?UEhuNDk1N2p5SmFvZXVwYnNXNGFwa09nWThlRVN3S3IxbjJMQW1FQWtBR3Er?=
 =?utf-8?B?ODhIL05yQzIwaXJHVlpxa0tBYkxBTDB5b3Y5TUFZNWZqaE8zenlkSGZlSGF4?=
 =?utf-8?B?ejBJZno2VDkzam8vaXZPWVpqak1IWmRYdm9za3MvU3Vjdm94WDZ2N09HVksr?=
 =?utf-8?B?Z1VEMkpFM2Ixd3BCdmV2Ny9Ca2pIMHdkUHd3QmJlSGlpdWJ1TlhZbCtiQnVk?=
 =?utf-8?B?T3lrcjFtWFp6NXBLcng2anY5UTNvTVhBb1BPdWlkbm5ZcG5pZitJR2Jhdzl3?=
 =?utf-8?B?Y1BHVHZkZE1SRFo2YlJTTG5iRXl3Rk51UVlsUGpPaVBPV3RGUHpGd3hQVmhi?=
 =?utf-8?B?amxCU0NUNDFHZDRSa08zNENLQTdSSXh1OE5lTnRRbVNoMkpqUnhjcDlOVGhB?=
 =?utf-8?B?RFBqb2JIbnBBY0JMa1ZPYksxdzhzTjdnczVQZTVsQU80MGM1ZEZ6b2UzZzdz?=
 =?utf-8?B?QVJncXI5aTNvTTRuL2JzeTdXL2xITm1lcHY3N2tpSHc5TDMySHpMQ2RCZnJU?=
 =?utf-8?B?QndNemsyMFBmTmNGRk5KV1IzM0oramNNU1NKeHVkL3hLOGlucTVkYW1HRU16?=
 =?utf-8?B?aGlMWFNYbUNFK3RiQjRaQ285TnFHYXh2TGlVenBIUWtnbGxjcW9mQ0JhdGxv?=
 =?utf-8?B?cStib1BKbkxpdHFpOTlFeXRxMlZMT2RxczFqUVlya3JTT3RFSzFTVmViVVBD?=
 =?utf-8?B?OW9TM3NNOXlNdXFLeHRWVUZiR3gyanFRYWk1em9ZcUsrQjkrTGRDT1RMaFFU?=
 =?utf-8?B?Ny9hK2R1WUFBdmtDa0FqclJIbCtRTW9teHdsNFdzYmg4TUl6TXBCZEIrUUVW?=
 =?utf-8?B?V2c1YUhhQkNUSkdRK3lRT25lWFRpMFhnSUp0RTRwYzR2V2VIeFRLc0hab0xm?=
 =?utf-8?B?RGJUa292dlhHZDlIRTlqYzN0M3NvVThRVXFnK1N4YUlDZ25MdTdUUUc2cWJM?=
 =?utf-8?B?RitwcU5kYVZhaDhjWTR3M0dtK1BQME43aE9SSHkyOUNmTUQwL0VZWll0Mlph?=
 =?utf-8?B?TE4xR0g3RktxdFFDelVwZGNoZU4xQUtGOVgxRE5xQStmc0tWaE5qK3gvcWZh?=
 =?utf-8?B?NGRWS3BEb2hDd0ErRnhRRTN3cnkyOE9pQ2V1aFFWK0dyeGtiSEpUTmtEZFVw?=
 =?utf-8?B?WGhiVW9BWURDRVVVdVpTL0cyUzhKUnJRcDJjZkxFZUhpOGIrTDliQTdtazJy?=
 =?utf-8?B?cTBPZ1gvY0pYdzI3bzAyOGVqdlozZG41QU1UVW9qcGF2RDhEdEdra0gwcWlq?=
 =?utf-8?B?S0ZGTWxGVVZJWWo3aWh3S25EdkpsaGV5Rjh6S0pUNkQyWWMvSTQydUE1RFJw?=
 =?utf-8?B?aXo4Um90MTBhYWprVkdqWXNkOE5zZ1dCdk4yYUx6VUtNUnFETldzd1lVSzV1?=
 =?utf-8?B?NGxJanZUUE9tRzYraXM4ZkxsUmVLZ3c1SmdoWFNUVDlQWU0rWk41WTg2ZzNG?=
 =?utf-8?B?aEtDQk5iUzY3dnYyNTMzZjVxdWlMdDVEZU5YaG5vL3FWR1A3Q3hSU0tRZ3ps?=
 =?utf-8?B?QnFQVk1qSHd0eFViYjA3WW84aGxqcHFmWTFnWDkwUGJJMXpJT2NRT3UzM2Nl?=
 =?utf-8?Q?QxM/jz0+x5YjNRRJXTxXd7Scm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b3801e-1f34-4c60-6ebc-08dcfcbdd1cd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5966.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 10:45:38.0294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSsvIpoTbG3hiPeCxA1Kjh5NXsRPjAY0kVtLhWO1eOBZHsSg0XWnHVD0nNeKfNQLy7CdFBN9r1vPt1L/8PjjEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5958

Hi,


On 10/31/2024 3:22 PM, Ilpo Järvinen wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On Wed, 30 Oct 2024, Arnd Bergmann wrote:
>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> After the file got split, there are now W=1 warnings for users that
>> include it without referencing hsmp_msg_desc_table:
>>
>> In file included from arch/x86/include/asm/amd_hsmp.h:6,
>>                   from drivers/platform/x86/amd/hsmp/plat.c:12:
>> arch/x86/include/uapi/asm/amd_hsmp.h:91:35: error: 'hsmp_msg_desc_table' defined but not used [-Werror=unused-const-variable=]
>>     91 | static const struct hsmp_msg_desc hsmp_msg_desc_table[] = {
>>        |                                   ^~~~~~~~~~~~~~~~~~~
>>
>> The array was never meant to be used by userspace code, but was
>> left in the header as a reference for userspace programmers.
>>
>> Move the contents of the array into the one file that actually needs
>> it, and instead leave the URL of the new location in the uapi header
>> in case anyone is looking for it.
>>
>> Fixes: e47c018a0ee6 ("platform/x86/amd/hsmp: Move platform device specific code to plat.c")
>> Suggested-by: Hans de Goede <hdegoede@redhat.com>
>> Link: https://lore.kernel.org/lkml/046687d8-1e2d-435b-adcb-26897bfd29f7@redhat.com/
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>
> I'll leave it into patchwork for a few days if somebody has some still
> unvoiced opinions on this.
AFAIK, Song Liu might be having some user space tool which makes use of 
this hsmp_msg_desc_table[].

Please refer 
https://lore.kernel.org/platform-driver-x86/bfee54fe-1779-fea2-8365-31167cc06972@amd.com/T/#mb563e1e07183e6bb5f85ab2cba4afe0deca1d3c3

for the discussions on having this table in UAPI header.

@Song Liu, this table is moved to hsmp.c now.  Please raise your concern 
here if any.

> --
>   i.
>
>> ---
>>   arch/x86/include/uapi/asm/amd_hsmp.h | 255 ++-------------------------
>>   drivers/platform/x86/amd/hsmp/hsmp.c | 245 +++++++++++++++++++++++++
>>   2 files changed, 255 insertions(+), 245 deletions(-)
>>
>> diff --git a/arch/x86/include/uapi/asm/amd_hsmp.h b/arch/x86/include/uapi/asm/amd_hsmp.h
>> index e5d182c7373c..dfa6aa985ac4 100644
>> --- a/arch/x86/include/uapi/asm/amd_hsmp.h
>> +++ b/arch/x86/include/uapi/asm/amd_hsmp.h
>> @@ -1,5 +1,15 @@
>>   /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>>
>> +/*
>> + * See hsmp_msg_desc_table[] in:
>> + * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/platform/x86/amd/hsmp.c
>> + *
>> + * for some information on number of input- and output arguments
>> + * for the various functions.
>> + *
>> + * Please find the supported list of messages and message definition
>> + * in the HSMP chapter of respective family/model PPR.
>> + */
>>   #ifndef _UAPI_ASM_X86_AMD_HSMP_H_
>>   #define _UAPI_ASM_X86_AMD_HSMP_H_
>>
>> @@ -81,251 +91,6 @@ struct hsmp_msg_desc {
>>        enum hsmp_msg_type type;
>>   };
>>
>> -/*
>> - * User may use these comments as reference, please find the
>> - * supported list of messages and message definition in the
>> - * HSMP chapter of respective family/model PPR.
>> - *
>> - * Not supported messages would return -ENOMSG.
>> - */
>> -static const struct hsmp_msg_desc hsmp_msg_desc_table[] = {
>> -     /* RESERVED */
>> -     {0, 0, HSMP_RSVD},
>> -
>> -     /*
>> -      * HSMP_TEST, num_args = 1, response_sz = 1
>> -      * input:  args[0] = xx
>> -      * output: args[0] = xx + 1
>> -      */
>> -     {1, 1, HSMP_GET},
>> -
>> -     /*
>> -      * HSMP_GET_SMU_VER, num_args = 0, response_sz = 1
>> -      * output: args[0] = smu fw ver
>> -      */
>> -     {0, 1, HSMP_GET},
>> -
>> -     /*
>> -      * HSMP_GET_PROTO_VER, num_args = 0, response_sz = 1
>> -      * output: args[0] = proto version
>> -      */
>> -     {0, 1, HSMP_GET},
>> -
>> -     /*
>> -      * HSMP_GET_SOCKET_POWER, num_args = 0, response_sz = 1
>> -      * output: args[0] = socket power in mWatts
>> -      */
>> -     {0, 1, HSMP_GET},
>> -
>> -     /*
>> -      * HSMP_SET_SOCKET_POWER_LIMIT, num_args = 1, response_sz = 0
>> -      * input: args[0] = power limit value in mWatts
>> -      */
>> -     {1, 0, HSMP_SET},
>> -
>> -     /*
>> -      * HSMP_GET_SOCKET_POWER_LIMIT, num_args = 0, response_sz = 1
>> -      * output: args[0] = socket power limit value in mWatts
>> -      */
>> -     {0, 1, HSMP_GET},
>> -
>> -     /*
>> -      * HSMP_GET_SOCKET_POWER_LIMIT_MAX, num_args = 0, response_sz = 1
>> -      * output: args[0] = maximuam socket power limit in mWatts
>> -      */
>> -     {0, 1, HSMP_GET},
>> -
>> -     /*
>> -      * HSMP_SET_BOOST_LIMIT, num_args = 1, response_sz = 0
>> -      * input: args[0] = apic id[31:16] + boost limit value in MHz[15:0]
>> -      */
>> -     {1, 0, HSMP_SET},
>> -
>> -     /*
>> -      * HSMP_SET_BOOST_LIMIT_SOCKET, num_args = 1, response_sz = 0
>> -      * input: args[0] = boost limit value in MHz
>> -      */
>> -     {1, 0, HSMP_SET},
>> -
>> -     /*
>> -      * HSMP_GET_BOOST_LIMIT, num_args = 1, response_sz = 1
>> -      * input: args[0] = apic id
>> -      * output: args[0] = boost limit value in MHz
>> -      */
>> -     {1, 1, HSMP_GET},
>> -
>> -     /*
>> -      * HSMP_GET_PROC_HOT, num_args = 0, response_sz = 1
>> -      * output: args[0] = proc hot status
>> -      */
>> -     {0, 1, HSMP_GET},
>> -
>> -     /*
>> -      * HSMP_SET_XGMI_LINK_WIDTH, num_args = 1, response_sz = 0
>> -      * input: args[0] = min link width[15:8] + max link width[7:0]
>> -      */
>> -     {1, 0, HSMP_SET},
>> -
>> -     /*
>> -      * HSMP_SET_DF_PSTATE, num_args = 1, response_sz = 0
>> -      * input: args[0] = df pstate[7:0]
>> -      */
>> -     {1, 0, HSMP_SET},
>> -
>> -     /* HSMP_SET_AUTO_DF_PSTATE, num_args = 0, response_sz = 0 */
>> -     {0, 0, HSMP_SET},
>> -
>> -     /*
>> -      * HSMP_GET_FCLK_MCLK, num_args = 0, response_sz = 2
>> -      * output: args[0] = fclk in MHz, args[1] = mclk in MHz
>> -      */
>> -     {0, 2, HSMP_GET},
>> -
>> -     /*
>> -      * HSMP_GET_CCLK_THROTTLE_LIMIT, num_args = 0, response_sz = 1
>> -      * output: args[0] = core clock in MHz
>> -      */
>> -     {0, 1, HSMP_GET},
>> -
>> -     /*
>> -      * HSMP_GET_C0_PERCENT, num_args = 0, response_sz = 1
>> -      * output: args[0] = average c0 residency
>> -      */
>> -     {0, 1, HSMP_GET},
>> -
>> -     /*
>> -      * HSMP_SET_NBIO_DPM_LEVEL, num_args = 1, response_sz = 0
>> -      * input: args[0] = nbioid[23:16] + max dpm level[15:8] + min dpm level[7:0]
>> -      */
>> -     {1, 0, HSMP_SET},
>> -
>> -     /*
>> -      * HSMP_GET_NBIO_DPM_LEVEL, num_args = 1, response_sz = 1
>> -      * input: args[0] = nbioid[23:16]
>> -      * output: args[0] = max dpm level[15:8] + min dpm level[7:0]
>> -      */
>> -     {1, 1, HSMP_GET},
>> -
>> -     /*
>> -      * HSMP_GET_DDR_BANDWIDTH, num_args = 0, response_sz = 1
>> -      * output: args[0] = max bw in Gbps[31:20] + utilised bw in Gbps[19:8] +
>> -      * bw in percentage[7:0]
>> -      */
>> -     {0, 1, HSMP_GET},
>> -
>> -     /*
>> -      * HSMP_GET_TEMP_MONITOR, num_args = 0, response_sz = 1
>> -      * output: args[0] = temperature in degree celsius. [15:8] integer part +
>> -      * [7:5] fractional part
>> -      */
>> -     {0, 1, HSMP_GET},
>> -
>> -     /*
>> -      * HSMP_GET_DIMM_TEMP_RANGE, num_args = 1, response_sz = 1
>> -      * input: args[0] = DIMM address[7:0]
>> -      * output: args[0] = refresh rate[3] + temperature range[2:0]
>> -      */
>> -     {1, 1, HSMP_GET},
>> -
>> -     /*
>> -      * HSMP_GET_DIMM_POWER, num_args = 1, response_sz = 1
>> -      * input: args[0] = DIMM address[7:0]
>> -      * output: args[0] = DIMM power in mW[31:17] + update rate in ms[16:8] +
>> -      * DIMM address[7:0]
>> -      */
>> -     {1, 1, HSMP_GET},
>> -
>> -     /*
>> -      * HSMP_GET_DIMM_THERMAL, num_args = 1, response_sz = 1
>> -      * input: args[0] = DIMM address[7:0]
>> -      * output: args[0] = temperature in degree celsius[31:21] + update rate in ms[16:8] +
>> -      * DIMM address[7:0]
>> -      */
>> -     {1, 1, HSMP_GET},
>> -
>> -     /*
>> -      * HSMP_GET_SOCKET_FREQ_LIMIT, num_args = 0, response_sz = 1
>> -      * output: args[0] = frequency in MHz[31:16] + frequency source[15:0]
>> -      */
>> -     {0, 1, HSMP_GET},
>> -
>> -     /*
>> -      * HSMP_GET_CCLK_CORE_LIMIT, num_args = 1, response_sz = 1
>> -      * input: args[0] = apic id [31:0]
>> -      * output: args[0] = frequency in MHz[31:0]
>> -      */
>> -     {1, 1, HSMP_GET},
>> -
>> -     /*
>> -      * HSMP_GET_RAILS_SVI, num_args = 0, response_sz = 1
>> -      * output: args[0] = power in mW[31:0]
>> -      */
>> -     {0, 1, HSMP_GET},
>> -
>> -     /*
>> -      * HSMP_GET_SOCKET_FMAX_FMIN, num_args = 0, response_sz = 1
>> -      * output: args[0] = fmax in MHz[31:16] + fmin in MHz[15:0]
>> -      */
>> -     {0, 1, HSMP_GET},
>> -
>> -     /*
>> -      * HSMP_GET_IOLINK_BANDWITH, num_args = 1, response_sz = 1
>> -      * input: args[0] = link id[15:8] + bw type[2:0]
>> -      * output: args[0] = io bandwidth in Mbps[31:0]
>> -      */
>> -     {1, 1, HSMP_GET},
>> -
>> -     /*
>> -      * HSMP_GET_XGMI_BANDWITH, num_args = 1, response_sz = 1
>> -      * input: args[0] = link id[15:8] + bw type[2:0]
>> -      * output: args[0] = xgmi bandwidth in Mbps[31:0]
>> -      */
>> -     {1, 1, HSMP_GET},
>> -
>> -     /*
>> -      * HSMP_SET_GMI3_WIDTH, num_args = 1, response_sz = 0
>> -      * input: args[0] = min link width[15:8] + max link width[7:0]
>> -      */
>> -     {1, 0, HSMP_SET},
>> -
>> -     /*
>> -      * HSMP_SET_PCI_RATE, num_args = 1, response_sz = 1
>> -      * input: args[0] = link rate control value
>> -      * output: args[0] = previous link rate control value
>> -      */
>> -     {1, 1, HSMP_SET},
>> -
>> -     /*
>> -      * HSMP_SET_POWER_MODE, num_args = 1, response_sz = 0
>> -      * input: args[0] = power efficiency mode[2:0]
>> -      */
>> -     {1, 0, HSMP_SET},
>> -
>> -     /*
>> -      * HSMP_SET_PSTATE_MAX_MIN, num_args = 1, response_sz = 0
>> -      * input: args[0] = min df pstate[15:8] + max df pstate[7:0]
>> -      */
>> -     {1, 0, HSMP_SET},
>> -
>> -     /*
>> -      * HSMP_GET_METRIC_TABLE_VER, num_args = 0, response_sz = 1
>> -      * output: args[0] = metrics table version
>> -      */
>> -     {0, 1, HSMP_GET},
>> -
>> -     /*
>> -      * HSMP_GET_METRIC_TABLE, num_args = 0, response_sz = 0
>> -      */
>> -     {0, 0, HSMP_GET},
>> -
>> -     /*
>> -      * HSMP_GET_METRIC_TABLE_DRAM_ADDR, num_args = 0, response_sz = 2
>> -      * output: args[0] = lower 32 bits of the address
>> -      * output: args[1] = upper 32 bits of the address
>> -      */
>> -     {0, 2, HSMP_GET},
>> -};
>> -
>>   /* Metrics table (supported only with proto version 6) */
>>   struct hsmp_metric_table {
>>        __u32 accumulation_counter;
>> diff --git a/drivers/platform/x86/amd/hsmp/hsmp.c b/drivers/platform/x86/amd/hsmp/hsmp.c
>> index 82d8ba2e1204..5d21bc8b2fd7 100644
>> --- a/drivers/platform/x86/amd/hsmp/hsmp.c
>> +++ b/drivers/platform/x86/amd/hsmp/hsmp.c
>> @@ -37,6 +37,251 @@
>>
>>   static struct hsmp_plat_device hsmp_pdev;
>>
>> +/*
>> + * User may use these comments as reference, please find the
>> + * supported list of messages and message definition in the
>> + * HSMP chapter of respective family/model PPR.
>> + *
>> + * Not supported messages would return -ENOMSG.
>> + */
>> +static const struct hsmp_msg_desc hsmp_msg_desc_table[] = {
>> +     /* RESERVED */
>> +     {0, 0, HSMP_RSVD},
>> +
>> +     /*
>> +      * HSMP_TEST, num_args = 1, response_sz = 1
>> +      * input:  args[0] = xx
>> +      * output: args[0] = xx + 1
>> +      */
>> +     {1, 1, HSMP_GET},
>> +
>> +     /*
>> +      * HSMP_GET_SMU_VER, num_args = 0, response_sz = 1
>> +      * output: args[0] = smu fw ver
>> +      */
>> +     {0, 1, HSMP_GET},
>> +
>> +     /*
>> +      * HSMP_GET_PROTO_VER, num_args = 0, response_sz = 1
>> +      * output: args[0] = proto version
>> +      */
>> +     {0, 1, HSMP_GET},
>> +
>> +     /*
>> +      * HSMP_GET_SOCKET_POWER, num_args = 0, response_sz = 1
>> +      * output: args[0] = socket power in mWatts
>> +      */
>> +     {0, 1, HSMP_GET},
>> +
>> +     /*
>> +      * HSMP_SET_SOCKET_POWER_LIMIT, num_args = 1, response_sz = 0
>> +      * input: args[0] = power limit value in mWatts
>> +      */
>> +     {1, 0, HSMP_SET},
>> +
>> +     /*
>> +      * HSMP_GET_SOCKET_POWER_LIMIT, num_args = 0, response_sz = 1
>> +      * output: args[0] = socket power limit value in mWatts
>> +      */
>> +     {0, 1, HSMP_GET},
>> +
>> +     /*
>> +      * HSMP_GET_SOCKET_POWER_LIMIT_MAX, num_args = 0, response_sz = 1
>> +      * output: args[0] = maximuam socket power limit in mWatts
>> +      */
>> +     {0, 1, HSMP_GET},
>> +
>> +     /*
>> +      * HSMP_SET_BOOST_LIMIT, num_args = 1, response_sz = 0
>> +      * input: args[0] = apic id[31:16] + boost limit value in MHz[15:0]
>> +      */
>> +     {1, 0, HSMP_SET},
>> +
>> +     /*
>> +      * HSMP_SET_BOOST_LIMIT_SOCKET, num_args = 1, response_sz = 0
>> +      * input: args[0] = boost limit value in MHz
>> +      */
>> +     {1, 0, HSMP_SET},
>> +
>> +     /*
>> +      * HSMP_GET_BOOST_LIMIT, num_args = 1, response_sz = 1
>> +      * input: args[0] = apic id
>> +      * output: args[0] = boost limit value in MHz
>> +      */
>> +     {1, 1, HSMP_GET},
>> +
>> +     /*
>> +      * HSMP_GET_PROC_HOT, num_args = 0, response_sz = 1
>> +      * output: args[0] = proc hot status
>> +      */
>> +     {0, 1, HSMP_GET},
>> +
>> +     /*
>> +      * HSMP_SET_XGMI_LINK_WIDTH, num_args = 1, response_sz = 0
>> +      * input: args[0] = min link width[15:8] + max link width[7:0]
>> +      */
>> +     {1, 0, HSMP_SET},
>> +
>> +     /*
>> +      * HSMP_SET_DF_PSTATE, num_args = 1, response_sz = 0
>> +      * input: args[0] = df pstate[7:0]
>> +      */
>> +     {1, 0, HSMP_SET},
>> +
>> +     /* HSMP_SET_AUTO_DF_PSTATE, num_args = 0, response_sz = 0 */
>> +     {0, 0, HSMP_SET},
>> +
>> +     /*
>> +      * HSMP_GET_FCLK_MCLK, num_args = 0, response_sz = 2
>> +      * output: args[0] = fclk in MHz, args[1] = mclk in MHz
>> +      */
>> +     {0, 2, HSMP_GET},
>> +
>> +     /*
>> +      * HSMP_GET_CCLK_THROTTLE_LIMIT, num_args = 0, response_sz = 1
>> +      * output: args[0] = core clock in MHz
>> +      */
>> +     {0, 1, HSMP_GET},
>> +
>> +     /*
>> +      * HSMP_GET_C0_PERCENT, num_args = 0, response_sz = 1
>> +      * output: args[0] = average c0 residency
>> +      */
>> +     {0, 1, HSMP_GET},
>> +
>> +     /*
>> +      * HSMP_SET_NBIO_DPM_LEVEL, num_args = 1, response_sz = 0
>> +      * input: args[0] = nbioid[23:16] + max dpm level[15:8] + min dpm level[7:0]
>> +      */
>> +     {1, 0, HSMP_SET},
>> +
>> +     /*
>> +      * HSMP_GET_NBIO_DPM_LEVEL, num_args = 1, response_sz = 1
>> +      * input: args[0] = nbioid[23:16]
>> +      * output: args[0] = max dpm level[15:8] + min dpm level[7:0]
>> +      */
>> +     {1, 1, HSMP_GET},
>> +
>> +     /*
>> +      * HSMP_GET_DDR_BANDWIDTH, num_args = 0, response_sz = 1
>> +      * output: args[0] = max bw in Gbps[31:20] + utilised bw in Gbps[19:8] +
>> +      * bw in percentage[7:0]
>> +      */
>> +     {0, 1, HSMP_GET},
>> +
>> +     /*
>> +      * HSMP_GET_TEMP_MONITOR, num_args = 0, response_sz = 1
>> +      * output: args[0] = temperature in degree celsius. [15:8] integer part +
>> +      * [7:5] fractional part
>> +      */
>> +     {0, 1, HSMP_GET},
>> +
>> +     /*
>> +      * HSMP_GET_DIMM_TEMP_RANGE, num_args = 1, response_sz = 1
>> +      * input: args[0] = DIMM address[7:0]
>> +      * output: args[0] = refresh rate[3] + temperature range[2:0]
>> +      */
>> +     {1, 1, HSMP_GET},
>> +
>> +     /*
>> +      * HSMP_GET_DIMM_POWER, num_args = 1, response_sz = 1
>> +      * input: args[0] = DIMM address[7:0]
>> +      * output: args[0] = DIMM power in mW[31:17] + update rate in ms[16:8] +
>> +      * DIMM address[7:0]
>> +      */
>> +     {1, 1, HSMP_GET},
>> +
>> +     /*
>> +      * HSMP_GET_DIMM_THERMAL, num_args = 1, response_sz = 1
>> +      * input: args[0] = DIMM address[7:0]
>> +      * output: args[0] = temperature in degree celsius[31:21] + update rate in ms[16:8] +
>> +      * DIMM address[7:0]
>> +      */
>> +     {1, 1, HSMP_GET},
>> +
>> +     /*
>> +      * HSMP_GET_SOCKET_FREQ_LIMIT, num_args = 0, response_sz = 1
>> +      * output: args[0] = frequency in MHz[31:16] + frequency source[15:0]
>> +      */
>> +     {0, 1, HSMP_GET},
>> +
>> +     /*
>> +      * HSMP_GET_CCLK_CORE_LIMIT, num_args = 1, response_sz = 1
>> +      * input: args[0] = apic id [31:0]
>> +      * output: args[0] = frequency in MHz[31:0]
>> +      */
>> +     {1, 1, HSMP_GET},
>> +
>> +     /*
>> +      * HSMP_GET_RAILS_SVI, num_args = 0, response_sz = 1
>> +      * output: args[0] = power in mW[31:0]
>> +      */
>> +     {0, 1, HSMP_GET},
>> +
>> +     /*
>> +      * HSMP_GET_SOCKET_FMAX_FMIN, num_args = 0, response_sz = 1
>> +      * output: args[0] = fmax in MHz[31:16] + fmin in MHz[15:0]
>> +      */
>> +     {0, 1, HSMP_GET},
>> +
>> +     /*
>> +      * HSMP_GET_IOLINK_BANDWITH, num_args = 1, response_sz = 1
>> +      * input: args[0] = link id[15:8] + bw type[2:0]
>> +      * output: args[0] = io bandwidth in Mbps[31:0]
>> +      */
>> +     {1, 1, HSMP_GET},
>> +
>> +     /*
>> +      * HSMP_GET_XGMI_BANDWITH, num_args = 1, response_sz = 1
>> +      * input: args[0] = link id[15:8] + bw type[2:0]
>> +      * output: args[0] = xgmi bandwidth in Mbps[31:0]
>> +      */
>> +     {1, 1, HSMP_GET},
>> +
>> +     /*
>> +      * HSMP_SET_GMI3_WIDTH, num_args = 1, response_sz = 0
>> +      * input: args[0] = min link width[15:8] + max link width[7:0]
>> +      */
>> +     {1, 0, HSMP_SET},
>> +
>> +     /*
>> +      * HSMP_SET_PCI_RATE, num_args = 1, response_sz = 1
>> +      * input: args[0] = link rate control value
>> +      * output: args[0] = previous link rate control value
>> +      */
>> +     {1, 1, HSMP_SET},
>> +
>> +     /*
>> +      * HSMP_SET_POWER_MODE, num_args = 1, response_sz = 0
>> +      * input: args[0] = power efficiency mode[2:0]
>> +      */
>> +     {1, 0, HSMP_SET},
>> +
>> +     /*
>> +      * HSMP_SET_PSTATE_MAX_MIN, num_args = 1, response_sz = 0
>> +      * input: args[0] = min df pstate[15:8] + max df pstate[7:0]
>> +      */
>> +     {1, 0, HSMP_SET},
>> +
>> +     /*
>> +      * HSMP_GET_METRIC_TABLE_VER, num_args = 0, response_sz = 1
>> +      * output: args[0] = metrics table version
>> +      */
>> +     {0, 1, HSMP_GET},
>> +
>> +     /*
>> +      * HSMP_GET_METRIC_TABLE, num_args = 0, response_sz = 0
>> +      */
>> +     {0, 0, HSMP_GET},
>> +
>> +     /*
>> +      * HSMP_GET_METRIC_TABLE_DRAM_ADDR, num_args = 0, response_sz = 2
>> +      * output: args[0] = lower 32 bits of the address
>> +      * output: args[1] = upper 32 bits of the address
>> +      */
>> +     {0, 2, HSMP_GET},
>> +};
>> +
>>   /*
>>    * Send a message to the HSMP port via PCI-e config space registers
>>    * or by writing to MMIO space.

Thanks and Regards,

Suma


