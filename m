Return-Path: <linux-kernel+bounces-575318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F123A6FDD0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6230D188BAB6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597BC25F7B4;
	Tue, 25 Mar 2025 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Uoeip2eK"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B570727702D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905399; cv=fail; b=eG8QBNtBxHW6RLqRAOqZAX01qk4GzHaOV2ljzbSW0Ua/Dd61KHqBhafQzEecA7+gSLwSDm8umZ/12o/ENEHmP+jTm/YjFL7XiH202K3kIsKVCVgkLeg7ofWNDm8NklrCKbyVfE0RhOYW6gfxqcO+brGVN49eK3K25FzZX3J+mCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905399; c=relaxed/simple;
	bh=Zl28TK0EaZwwdZbCCHCtmp7epETYFjlDCWVoBdqg9nI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cPqK4nmAYyIgRlI+oRCS0W/yba/87NgBRzeF0Ta8cdrd2yuyj+3Z0tRkjSCppKKbUzhjW0A4zxHzF3KXtAGhiWjSDM2WyShKEZvGXFiRuzPmvucnLaVGZAFjlFU8ts5gqmSL6gQnnjK0CTLth2RdIg79GOm7HKVymv1BWVOjlSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Uoeip2eK; arc=fail smtp.client-ip=40.107.237.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZ9s4aWfWfOFrdlfw5rIQ6N9Uo/ROvTrL9tjT+VWEP41I4JodSULdJ62+TCj11AdpagQjX5advY98S9x277evxeCYwxYNGVh8CdcHdmtak5T/eS4aCjA6kara9yhMVdvCeoa502hkgzQy3q2jZn2sT++QbL1/YsUBjCh9AWL4hi2GrzEs8OS9E8nH7zT0UflqbBi5PFmNkCIsFh4W7H9FL+sDpVGgM6smvPY0ldj/cK/CcXMztSA04UjP5NecKEQEXoXaWkIKWCDoJZOOh52xO88+6EjRkic905zPMryaSiegoyQM0hU0w1X80xWm/eLJ/4uMSkSDcMKnaqL+nTOFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8nCVAc5zs6ggNtAWXdoAL+TK8Se/hgDkmMjHQNP7gM=;
 b=D/tXDYTjmmuhHtZcZHMaFGKMmSziS5yudpxIKeuUtueXwcZCzMHdK3Vr8SABuVdHvCcXfIJcu9wWu6cfdIvbxH89cL+M7VPA/Oemh7+66CrVcpcktjY//y315eFvf1/LvVjRjerc/+LNyL7Von/KHUgI5lHQ2krk8fOxvbKKzJLKdJdsmKR4zn6uL8Y+XO/Tqg2WPZFkmHWmBX/4as+VQVPCo4nFcIvdKWTkPX8WPjNk9isRqJVBJELYcSZ8ztYcffe0fkcF6ASEs0feysGlPHR4WxKA3J4Ue+WWA+hIoHq3M8B34a3dVGHTQB1+cdrl4c7HpaQhNHUJ8m6Ov0c1iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8nCVAc5zs6ggNtAWXdoAL+TK8Se/hgDkmMjHQNP7gM=;
 b=Uoeip2eK7s5iT6vwQ0Ks0cK0sRqyFlfFtXkvydY6NC32EiMYxKAd2Zhy1fTulVZ2WE9xTbgHlvaTYblgMvDovvYy/y2awRUZAx3Kp1Y6TNDQLPtRUu7WYepHaZw0B1SOFCk28CjGYlX1mUh0X7CPnzpy6UoW5AMO40z5MsiSxSE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB6392.namprd12.prod.outlook.com (2603:10b6:8:cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 12:23:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8511.026; Tue, 25 Mar 2025
 12:23:14 +0000
Message-ID: <64945196-f05f-478e-a2b5-f0bd58345136@amd.com>
Date: Tue, 25 Mar 2025 13:23:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: commit 7ffb791423c7 breaks steam game
To: Bert Karwatzki <spasswolf@web.de>
Cc: Balbir Singh <balbirs@nvidia.com>, Ingo Molnar <mingo@kernel.org>,
 Kees Cook <kees@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
References: <20250325101424.4478-1-spasswolf@web.de>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250325101424.4478-1-spasswolf@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: 38bd580c-b378-4a66-aa52-08dd6b97d0a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXA3K3UwWnRCN29abG1ROHZmaWhoVjJkYzRqOUNPUHFMZytWNmg3NExxT1hM?=
 =?utf-8?B?Z3hyQktvWW9VdllxTFJDOExFU2NNbkxpaUgyRWFVaVNtOUY2V2JqcVJxRjdy?=
 =?utf-8?B?clJxZjZZVTJ5NFM2ZzVTWXkzSEloclJuRGpvVkswNzhTcTEybnRkYU9aVFll?=
 =?utf-8?B?cmxGekJPOUxHTFZqc3VyclpIQlkyVnVnWHVsayt4bDI3Z1hpSVBLOEhlM3A3?=
 =?utf-8?B?eWNIaGI5WFltMWdjaThCdGxDSG9FbkU3c1kyUVlMa0lvVk5RRUR0cFA1RGcy?=
 =?utf-8?B?RFl3ZExySXRFZ3VyQkh4T3Ewb28zRXNBRktWWnhsZExydXR6dCtRRFFlT0ty?=
 =?utf-8?B?citiOVUrNU45UDVueW9NbjA5ekxMRElIZXJMTUpMaExrVVdESjdrVjgyY1Zq?=
 =?utf-8?B?QmJibEdJV0dCVDYzRlQvbnRNUmI1WlJNb2wyRkJkYnR5Mlg0UjI2dDlyc2Fq?=
 =?utf-8?B?MEdOSWVOdkMzcFdtZVQrd3Vyek11a2NzbWo5aUNFcjJMNnlzcUFTYzVjeGFO?=
 =?utf-8?B?eS9qZEl4WnJmTVFJaVZObjFVZHJ5NWE2M3phRklWZ1RiYjVLM3kxbm5LMHhx?=
 =?utf-8?B?Nno4UVZ3WndjcExXRTlmbVExQ3dXYU1zZ0NhRm8wU0t0eUM1UHVSRVkvaDFl?=
 =?utf-8?B?SXNqT0J3VkE4QlJaZW5lQitGMCszK1duSHNOS0I4cldMNDlDYkZZdXJPaUxn?=
 =?utf-8?B?empqZm9UNXM1dkJyZGVwOEtxbzdWOXdFQlNKZ1l4cm44dHh2a3JMbjYwa1BD?=
 =?utf-8?B?SWQyQnBqSkhITzNJZFhRVTdxaGIxREx2YkM3V1dEM2VROFBGa1JkVlBQYUEw?=
 =?utf-8?B?a3NZcElhZHlaZUFLQnhuaEN6MnF4VjdDMmNiQ0VCelBYbnU5bWUzNnpvcDJK?=
 =?utf-8?B?OUJWVGMxc1dvZFJtUityN0NETjVmR205WG5FWWdzVHdjZUl6eTNIc2ttN0hP?=
 =?utf-8?B?cGVCTDZ5MG9aTUNjNTBYcUc0Ym1pdjhONGpsR2YxQkFiYWZzMGgzaW0zTkhG?=
 =?utf-8?B?ZDl5VHpPVEt4cHpZbUJLM3VVUnFTb3h3RzgwV1ZGaHRMbWNsUWRLVkkrWTdu?=
 =?utf-8?B?SS8rVFY4Zi9lNVRvd2I2R3N1MFJOQnJpa0svOTQ3NndWMU1VUmIxeklZa1F5?=
 =?utf-8?B?U044anp2QmZkalR4cGZYSW1JR0g5WWl4OWZLZlArQjQ2ZGMrQjBLaCtxc21Q?=
 =?utf-8?B?UGRIK2lRenN6YWZrU2xXQStUOUg4RUx0RU9FVndsbVBBcXZLTk82ZVhIdDJL?=
 =?utf-8?B?ZjkxVVRhRDJOWWZzZWx3b1drc0lOS1BjOFJuVkxDRmkxNmJiNERuOXpTWTNp?=
 =?utf-8?B?dzg5MXpRRTE3NE41MnRCZjRDZXpWWXRTaTB1bkJ2bFlUdzBqdklONlUxODVN?=
 =?utf-8?B?aGZnY2tQcU5kVEtQQkM5UUhPMFFlYjBmMHIxNFpUd0NNbWs5YlhraTdsK245?=
 =?utf-8?B?UGhBakFOaVZVZGJHeGhhTm01RDJmN0hkWXJVOWVKbFVWaGFTcURrNklhNkhQ?=
 =?utf-8?B?OE5Dc0RWYXJSMkt6MFVDMkZxVzEvSjJjUmdXMFZmWGg1SU9VWW9HeHh6QW5w?=
 =?utf-8?B?RnJ6Rm1yc2UveXNYZmhSVG45ODdLb3lhYm5FcHZyRno1UVFFWVNLRTV4ZlBm?=
 =?utf-8?B?SHpENEJnVWdCMlR0RXJ3UU12YVhsR2VWQTZ5Ni94eUQ3RjF3MExRd0x6TGhU?=
 =?utf-8?B?S1hJYVk0MUtHODVkQmliODJDYk9kR1dyWnVCTysrWDlIWDdIYkwyOFNqblY5?=
 =?utf-8?B?eXlqbUlFN0k0WEh2bHZ3WkVLNTh4NWJ5VFBMcTE5Mk5ySWViWGEyM01sclZj?=
 =?utf-8?B?NmFvMDg1U1lyT3JHeGI1cmFzVVZ4dmw0VERXbmlwKzRPZmVMV2lhV25TMnJi?=
 =?utf-8?Q?lI4b5KoyuyleB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFFTUFFOSkg1NE5MaVZDSGI3cEd4U3N3enRIeFRQcjI1OEZnTWhqSGVCcERr?=
 =?utf-8?B?bmRxYWRVdnNkaGZCUkUwUlNJbXN3b09oMWdBZkVNMll4bHRleGJjM3lBSXZn?=
 =?utf-8?B?VFlXTVZjeXJteWt4VDZoRnhUSVFnQm82bitVZ3pNeVhuNmY3YkZWVFhNL1BF?=
 =?utf-8?B?SXZSL09Kbnhucmp6MjdOU3ZxQzdVTnFFK0VpRUU5aEtjQ0lXSFVERWtGYVEr?=
 =?utf-8?B?T24vVHFBWkM2dlZvZzZ6YnF3ZlJ6ZFQyeDR2ZDd4V0tvaGI5b3VpZ1RqT0Rr?=
 =?utf-8?B?bzNkVnpzd0lGcEd4cGlEc3gra1NlZUNPa2gvTlhlUGhJNGs0SVdkMFFXZXhZ?=
 =?utf-8?B?eis2T0xrQTdOMW53QU50ejFzM3RuYlFZZTM4cVI2TXF2MVJGZG45OGE3Zm16?=
 =?utf-8?B?eHhhditlaWF1NWYzWDNVd042M0NraDdncTN3M1h3NEpwNUZkaFNZbktpWUVh?=
 =?utf-8?B?NnNYZ0E3RTFxVUl2QTh0NUFKYkQzMC9ROUkzWWlUMjBLWWZDYWJGRzN3Q2FL?=
 =?utf-8?B?b0hCaFgwQVVDcXgvbnYyVllhU2RDRDBJaFdlQ2tON01nZ1AwOFA1dXVPUi9j?=
 =?utf-8?B?amNIUDg4NHorRERObWVHWDYwRy9rUG55MmN1ZXJOOC9ybGRsVWxUbWlacW5P?=
 =?utf-8?B?bHY2ZkxBbW8rZ1JGeWN1UDY0dkF4MDdmb1Q1ZktXR2tHUTlETjZaTk42Y09m?=
 =?utf-8?B?ci9YbnJCcGg5WWNiOGJtcjZyVTIwd1U5amJYbG5BZGl5MTNrd3FZTWF3dzJw?=
 =?utf-8?B?c1NZeXhXclNuNFh6VHVtN29ydXBSSG9vNWlQaGtHQjJVQU92dGNQMWlEZHM4?=
 =?utf-8?B?U1hIR1ZuUWVuZUFKTnpiV04xQ0craFVQMFdJWGFPVkdvbExyUVhRdWZoNnhj?=
 =?utf-8?B?azJnWDRwZ1JPemdvemhoMXlFalNOYUlESmtucjhIYnp6K3FsMzBaemFyL3NY?=
 =?utf-8?B?ckEzcVRzZXlTNUU5UFYvcTJnbVEzMFFNR3JPS2tqSzFJTnFscG5Ga3ozbnMz?=
 =?utf-8?B?R0pYcHRjZ0JGdXF2b2pVbFFuOFk1QnZsVERFbTRVRlZ6TGM2MWhrN2FPMldp?=
 =?utf-8?B?N0o2SGNKZkdsMzh1MHdjWFg5aHdmWmhBdDlDZXpGN3JrVGVLTmxYTDI5RllC?=
 =?utf-8?B?M2l6NHAxRjQyd2pRZEk5MjE4YWd0ZnhQN3lBdW1VUFhWbW94ZjBZbTZ6NllN?=
 =?utf-8?B?SUp6VGdVUUtTRENQQmVrYXNkbFFpWjR0dENPYWc2RE5ldmlVcVE5NmFMV0FP?=
 =?utf-8?B?MzlqaFNpUmNuVXVnK1JvUVU0Z1NsSWFVRTdLK3RDSkd5amdFZi9xdzM3aWFZ?=
 =?utf-8?B?aCtOa2lsbjNvQ2FKdU10ZEhtY0dPS2NHdWRySHhvMzgraHFQOWowWmVRRmhr?=
 =?utf-8?B?L2hlaEtNZE9VUE5xUWhnb3dYL3pnWEFmZkN3Q3BkUWhjNmNta1JBdFhDdnAr?=
 =?utf-8?B?ekZtN1FDamE2UTRwODFqaExlY2o5RVRYMmFVSEEwZ01ydUd5b3B6RE41Y0o3?=
 =?utf-8?B?enhZYzNHaTErQ05iczNYd3dsRHRoeVZ3WXgxWlF4amNDakRScm9hSFR4RWlG?=
 =?utf-8?B?OWxYVTQ2TE5OZi90b0RpZjkyM1RrME9jOWNsZ3RkcndZOW95N2V6RUxGVEkv?=
 =?utf-8?B?eGtKNXNLQ3NWclRUYTdNazg1NmRjekFJL1NXS0Fxc0FzVFRvTG1NVC9FMDJO?=
 =?utf-8?B?eU5EcWEvREZYejNTRHdVb0tEc3NiZzYrckZTckZPN3hJbEduaDJRaU9nZ2t0?=
 =?utf-8?B?THBQOXpGc3NLaWpML3NDVnVxQWZ5RDNacTNPaEVVYjNialFLdmhRc0ZvTGhY?=
 =?utf-8?B?MEFzNU5DUkNoWUZYVTNtTHJ2MVBIMTEydCtQNW5hV2lXZTJPcGNlbmVzdDFF?=
 =?utf-8?B?ZUVZMEVpMEZxWC9VT0Fydzhwa0lWd3dVMzlBdU51cUxxV2tBNXJtanhOeU9s?=
 =?utf-8?B?S1M5bEZaRXRBVnU2MTRmK1kveXJkMks2TlRDV3ZQMzJIdnZmL0xYeXlaazAz?=
 =?utf-8?B?dmpML24xRU94amg1TGJBVUUzT0t6Y3I2SmFLWlZSVVUwWno4S2hmNm11d0U0?=
 =?utf-8?B?QVMrWUVvOGZrUjA0cm43dlNnSmpMWFpzbVhDbVV4bjcrdEoyMjJscERscVJ6?=
 =?utf-8?Q?p75Q=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38bd580c-b378-4a66-aa52-08dd6b97d0a4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 12:23:14.2951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/RuNJacGE6A2Y0Gv92ub5GB5ajmMHMu3CQsLcjE0u3f/bdFqOeLC7uRfK9GuN1K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6392

Am 25.03.25 um 11:14 schrieb Bert Karwatzki:
> My /proc/iomem  contans two memory areas of 8G size which are
> belonging to PCI 0000:03:00.0, one of the is the BAR reported by dmesg
> [ 0.312692] [ T1] pci 0000:03:00.0: BAR 0 [mem 0xfc00000000-0xfdffffffff 64bit pref]

> the other one is "afe00000000-affffffffff : 0000:03:00.0" (in the case without nokaslr) which shifts
> to "3ffe00000000-3fffffffffff : 0000:03:00.0" in the case with nokaslr.

You need to figure out where that stuff is coming from.

See below for another extremely odd thing.

>
> Here's /proc/iomem in the case without nokaslr:
> 00000000-00000fff : Reserved
> 00001000-0009ffff : System RAM
> 000a0000-000fffff : Reserved
>   000a0000-000dffff : PCI Bus 0000:00
>   000f0000-000fffff : System ROM
> 00100000-09bfefff : System RAM
> 09bff000-0a000fff : Reserved
> 0a001000-0a1fffff : System RAM
> 0a200000-0a20efff : ACPI Non-volatile Storage
> 0a20f000-e62edfff : System RAM
> e62ee000-e63e1fff : Reserved
> e63e2000-e87cafff : System RAM
> e87cb000-e87cbfff : Reserved
> e87cc000-e9e1ffff : System RAM
> e9e20000-eb33efff : Reserved
>   eb31e000-eb321fff : MSFT0101:00
>   eb322000-eb325fff : MSFT0101:00
> eb33f000-eb39efff : ACPI Tables
> eb39f000-eb556fff : ACPI Non-volatile Storage
> eb557000-ed1fefff : Reserved
> ed1ff000-edffffff : System RAM
> ee000000-efffffff : Reserved
> f0000000-fcffffff : PCI Bus 0000:00
>   f0000000-f7ffffff : PCI ECAM 0000 [bus 00-7f]
>     f0000000-f7ffffff : pnp 00:00
>   fc500000-fc9fffff : PCI Bus 0000:08
>     fc500000-fc5fffff : 0000:08:00.7
>       fc500000-fc5fffff : pcie_mp2_amd
>     fc600000-fc6fffff : 0000:08:00.4
>       fc600000-fc6fffff : xhci-hcd
>     fc700000-fc7fffff : 0000:08:00.3
>       fc700000-fc7fffff : xhci-hcd
>     fc800000-fc8fffff : 0000:08:00.2
>       fc800000-fc8fffff : ccp
>     fc900000-fc97ffff : 0000:08:00.0
>     fc980000-fc9bffff : 0000:08:00.5
>       fc980000-fc9bffff : AMD ACP3x audio
>         fc980000-fc990200 : acp_pdm_iomem
>     fc9c0000-fc9c7fff : 0000:08:00.6
>       fc9c0000-fc9c7fff : ICH HD audio
>     fc9c8000-fc9cbfff : 0000:08:00.1
>       fc9c8000-fc9cbfff : ICH HD audio
>     fc9cc000-fc9cdfff : 0000:08:00.7
>     fc9ce000-fc9cffff : 0000:08:00.2
>       fc9ce000-fc9cffff : ccp
>   fca00000-fccfffff : PCI Bus 0000:01
>     fca00000-fcbfffff : PCI Bus 0000:02
>       fca00000-fcbfffff : PCI Bus 0000:03
>         fca00000-fcafffff : 0000:03:00.0
>         fcb00000-fcb1ffff : 0000:03:00.0
>         fcb20000-fcb23fff : 0000:03:00.1
>           fcb20000-fcb23fff : ICH HD audio
>     fcc00000-fcc03fff : 0000:01:00.0
>   fcd00000-fcdfffff : PCI Bus 0000:07
>     fcd00000-fcd03fff : 0000:07:00.0
>       fcd00000-fcd03fff : nvme
>   fce00000-fcefffff : PCI Bus 0000:06
>     fce00000-fce03fff : 0000:06:00.0
>       fce00000-fce03fff : nvme
>   fcf00000-fcffffff : PCI Bus 0000:05
>     fcf00000-fcf03fff : 0000:05:00.0
>     fcf04000-fcf04fff : 0000:05:00.0
>       fcf04000-fcf04fff : r8169
> fd300000-fd37ffff : amd_iommu
> fec00000-fec003ff : IOAPIC 0
> fec01000-fec013ff : IOAPIC 1
> fec10000-fec10fff : Reserved
>   fec10000-fec10fff : pnp 00:04
> fed00000-fed00fff : Reserved
>   fed00000-fed003ff : HPET 0
>     fed00000-fed003ff : PNP0103:00
> fed40000-fed44fff : Reserved
> fed80000-fed8ffff : Reserved
>   fed81200-fed812ff : AMDI0030:00
>   fed81500-fed818ff : AMDI0030:00
>     fed81500-fed818ff : AMDI0030:00 AMDI0030:00
> fedc0000-fedc0fff : pnp 00:04
> fedc4000-fedc9fff : Reserved
>   fedc5000-fedc5fff : AMDI0010:03
>     fedc5000-fedc5fff : AMDI0010:03 AMDI0010:03
> fedcc000-fedcefff : Reserved
> fedd5000-fedd5fff : Reserved
> fee00000-fee00fff : pnp 00:04
> ff000000-ffffffff : pnp 00:04
> 100000000-fee2fffff : System RAM
>   825600000-8261fa1b1 : Kernel code
>   826200000-82663dfff : Kernel rodata
>   826800000-82692ef3f : Kernel data
>   826eaf000-826ffffff : Kernel bss

> fee300000-100fffffff : Reserved

First it says that this range is reserved.

> 1010000000-ffffffffff : PCI Bus 0000:00

And this range here used for the PCI Bus.

>   fc00000000-fe0fffffff : PCI Bus 0000:01
>     fc00000000-fe0fffffff : PCI Bus 0000:02
>       fc00000000-fe0fffffff : PCI Bus 0000:03
>         fc00000000-fdffffffff : 0000:03:00.0 This is the usual BAR reported by dmesg (and lspci -vv)
>         fe00000000-fe0fffffff : 0000:03:00.0

And then it says that the PCIe devices are inside the reserved range.

>   fe20000000-fe301fffff : PCI Bus 0000:08
>     fe20000000-fe2fffffff : 0000:08:00.0
>     fe30000000-fe301fffff : 0000:08:00.0
>   fe30300000-fe304fffff : PCI Bus 0000:04
>     fe30300000-fe303fffff : 0000:04:00.0
>       fe30300000-fe303fffff : 0000:04:00.0
>     fe30400000-fe30403fff : 0000:04:00.0
>     fe30404000-fe30404fff : 0000:04:00.0

> afe00000000-affffffffff : 0000:03:00.0 This is the memory which shifts with nokaslr

To be honest that looks like a broken ACPI table to me, but it doesn't explain why this range here shifts when activating/deactivating nokaslr.

Do we have some option to enable printing when ranges are added to the iomem reservation? If yes than we should probably do that and take a look at the dmesg again.

Regards,
Christian.

>
> Bert Karwatzki


