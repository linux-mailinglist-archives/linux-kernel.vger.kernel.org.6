Return-Path: <linux-kernel+bounces-428500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F8B9E0F5C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 00:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78375B222A5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 23:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75A31DFE1B;
	Mon,  2 Dec 2024 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="kvnS67i3"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020075.outbound.protection.outlook.com [52.101.56.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FF32C18C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 23:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733182806; cv=fail; b=BLsQ7hdijncayljFb+mzeQVEdoaVycvVM6gkvgNAqotj6NRXSArHON22AWfqgi07LNr3/p0C0Yg8HG61zLrVB6EUghWUutunh76uaV0crFKagEHYAABDYmQ+MSGjgf+FOvr8DuxTIpKm8zoEWvkFEdntu/4Leexa8pvPSZ7QLn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733182806; c=relaxed/simple;
	bh=/cLRCGOKz02iVjmxBg254NExUS2sfikD8CM8nIJ/xfQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m4gkFGnlCZFh8oW7kWzpjkLsiT1bbyZjd3hu18VukYWWruQF2/OOr/T+W5qP1A6o8wLDSl7vhLrZIolgyq9uSNkoRDpP2xZLaGDLWBMz2IwPvMk8awfI3ZjP/y1GoFQEBhZVK4yGk76ndxv4RfKxAPzwyfNQYQ8IxkyOlrfdYMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=kvnS67i3; arc=fail smtp.client-ip=52.101.56.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnY89Sbxb4zjFE5eQNhRQRW4mNd5MLRLJTdzqc6l2GoS/EfBKWtLW4qxrRGyxGJKAKpbw+zkmM7WKoFI5sG9QhNjaA+OHe6EvzIqmeMM3ETAkIel54KSX6RdW5DAQsslw/fQSZkb9nlN1x9hKXImSRh5whkMjCn6J56caByBOPsW+tneKBqQ+AmEFOKJ9zB+7aVzYuaEnk5K4sdaJSZlx7qu7rQITz9f3q6DFV9nL/Djz/qQNr6oPNZPb6hyS75U25XcyrStWMSDYEWf8HxTd26kU5pvgK2blhIF3bBg38w7u1vCsAXDajVOW7k8h4Ow/V8ykrTsbN3WzR2xUdnfMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hvh4E6DA4359KKk2msNK9g494rkxvFIL5sglHQEcURU=;
 b=qWwDFp8YQJHRqQURZBwJU/1x9RsVlk0Rn6twI2nE/469AXWG2fD0DPbikQ32aoAgkfuoQbJmvaywYmILWKeujX8bnAnQuaw52su8sb+p3gvytlHbl0EyL9AL3mp3YVDEQ+XGi5KslAdFC0mF2pjfo1K9hBtFM1Pg1NBrwwzeVZJi559hypSMPWjGs6lp9GTWly8tgqrTJTqBfgs6TIqewMHXww0lDj7eUbEz33VHUel0lXL8Ek/MYZPmqxCnz7ApwaRu0nYWxjN/vYkuDXNkpvZn9tDtcOJua1EgFGQAL89RJ7T7HgqNPvUnRM7pb6yDEZRZYNte4UHckK0X4NtTLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hvh4E6DA4359KKk2msNK9g494rkxvFIL5sglHQEcURU=;
 b=kvnS67i34xVhQDg6+dvAGMz+gqJGEkF4EGQDrOJyKJV1kC8QOadserHeYwA/2sttWM9BXWjbgMTceKLMVT/eYMCCeIil7UhfCr7NtqLmOOfZpAF8mZ74GZU/YN+plsAnK7Sswg106lWhagq6WUjAs5v9NdR8cxvNpBT5ZJ7Hhkw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SJ0PR01MB6512.prod.exchangelabs.com (2603:10b6:a03:299::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.9; Mon, 2 Dec 2024 23:40:01 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.8230.008; Mon, 2 Dec 2024
 23:40:01 +0000
Message-ID: <d2f2d48e-bfa5-4fd8-a6fe-dc75b89ffe9e@os.amperecomputing.com>
Date: Mon, 2 Dec 2024 15:39:57 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] arm64: support FEAT_BBM level 2 and large block
 mapping when rodata=full
To: catalin.marinas@arm.com, will@kernel.org
Cc: cl@gentwo.org, scott@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241118181711.962576-1-yang@os.amperecomputing.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20241118181711.962576-1-yang@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0205.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::30) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SJ0PR01MB6512:EE_
X-MS-Office365-Filtering-Correlation-Id: 8796cca5-46fa-462d-775e-08dd132aa377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXlGeEhMNW9sdE1xODRhdkNncWlZZ3ZoNW1YYWJibmgwckFMTlU4Sk9rb3Mx?=
 =?utf-8?B?RWZKY0VYbkY0S1FJZGZUVmpVbXFjOTdmTGNWd3pJUjJTNVlobFJVSmhKcUh4?=
 =?utf-8?B?VE1SbElSUDVxaUZWcEYycHV1ZWlxenRJeHV4UEwwbzhXUm55WEREdy9YdzRj?=
 =?utf-8?B?NGtWUU4vZ2E4TFhkWERIc2FSd2NMQmoxbkR5dkZXR3lySC9reEtDSTBKcUFs?=
 =?utf-8?B?U1FuZHBhZDRnWEdqbzhiT1R6NzJWbXprTHhTR1ZMdmJIZEhvMDhJS2JmWXpp?=
 =?utf-8?B?Qm5kbWUzbVE4Wm1nWk5xcEM3VFgxblhEQk1XT216OUJvZ2hHNS93Ni9LeEV2?=
 =?utf-8?B?WVNjR2svUzlNRzAvdDgvdll3UUgxRXR0Q1pCbk81RGpHWmxPaytyZ0x0ME1T?=
 =?utf-8?B?MkQ5blhEdmFQR1B1b09NUjFxbEpjeHZUU2RkNDdFd0N5Mnk1aVdReC8vclNZ?=
 =?utf-8?B?VTFIQTEvMnYzcHlVLzgzYWhySndneEl0SW44ZHQ0aXZGa3RuM1ZjamI5bWZX?=
 =?utf-8?B?eWFQZ0tPU0haL0NnaW9OVHVnUW5VQ2RhQ3VvMm1HYzk5MTBDSXAyZmUrUkx2?=
 =?utf-8?B?am5SOHhKQ3psNnc4N0J2Ykt3NUUwZjEyUWZzYjhBT1BZUFp6RGFrTjNaVFJ4?=
 =?utf-8?B?cVJlQjMzNWZaZWxvYndvUmw3dXJDc0JlSDJDT0NpZDdXWVZkMG5PYjBjRmEv?=
 =?utf-8?B?M1BZQ2dvMTZrMnhHVDFiK2dWaFBNQ0VUR01xYjQ5QTVGaUhEc01nWGNyeUhC?=
 =?utf-8?B?NnlZdCs2bXdyWnNUd0N6c3VTRWFxV3duVXhjQVhERllHYytya251YmhkTFpy?=
 =?utf-8?B?N2F6cXdLT25IVk5GRXB0WEhOTVhUMEhKVzZ4emdLUE03Wjc2dzFHeVFqZG9P?=
 =?utf-8?B?NnA3MGQ2aXkxd2l2cVlILzJLUlVibWhnRmo3QTRlRVFCbG1Vakx6ait3Q1U3?=
 =?utf-8?B?UW8rVk00bzRBMEF3Qk45c0ZTQnVLelg0ZjVqejYrZjRDSGc0QlRsNWhrWjZG?=
 =?utf-8?B?elN5WGh5R3VwOVo5WnRXYzNNYXVpZ0FJeVVEVFlxL3dFZ2lESGlIMFFsbXd4?=
 =?utf-8?B?cXFSY0ZwQ0E3elNoQWYvYzFIbkRwR1RVVTBRWFJzTUNScjBtQ2dtRFRUTGVq?=
 =?utf-8?B?c1ZHbDJMRGRWRTRmYStva1BKVzBGNDRsbjdTUWxOOVVxZFRIRzlQY1NOZGpT?=
 =?utf-8?B?dkpwTTJORkxxRGtsTitRSzhWNG9kdzJxRE9LLzRscGlBbEtmMGJPVjVlSG56?=
 =?utf-8?B?c2NIU09QcFZKbHJLSDJIMlRwQkw0cVFORG5teG9tYUpyVnRYOFREcEs0VWNH?=
 =?utf-8?B?UktTYS9wbzZiWG9xczJ5aFlnN0lLOXVsTlFKWmVORGpsUkNzQXgwcDdPcG5E?=
 =?utf-8?B?QW85aXl6Q2xHRG5URmpUdGdjQzd1bGJQdHI4dDhjU1AwZitzVlkyeGd4QkEr?=
 =?utf-8?B?MkgwWjVGVm9iUU55ZzIxNE85YUxoV25zeElIUEpCNm1LR0VaeVE0NUJGdk9j?=
 =?utf-8?B?dEd2NnA0djVtUXdhdVRTV1QvWDkxalErT2pKVGNPcnc4VHlRd0xLbmt0dUVj?=
 =?utf-8?B?OU1KR0ppdHZoa0lVcTFqK1NTTktoVk1iTDRqaW9WRmc4YU83M2Y4Y21BUmxF?=
 =?utf-8?B?OEFzSjBRTi9LQ3VGRFZhV3JPa0EvaitybUJPaWRGc2NST3dIb3VrZUJ0YkJ3?=
 =?utf-8?B?VXRHVUVyaXhraDd1T1BsdldmUzdFazlxZFBaMzc5ZmI4a0kxZ1d3N1oyOTdG?=
 =?utf-8?B?MGlrSzNZaHEvd0Y5cEhWRGg4WnNzdW41NExLTlZ2L2JJd082SjZrMEJHSHkx?=
 =?utf-8?B?K2xFeFliMjhVM3hwSVlGQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGZwa1NMZU1oQ1pDcTN3ekh4bmo2bnJvdnpaVTkwdXpSdUtZeld1a04xK2pm?=
 =?utf-8?B?RWNzc2NSOTR4S3F4dTIrNFAxMXVzSFUvMTlGcEE1NXpYbFpIdWZWWmJnUVk0?=
 =?utf-8?B?US9HelRlUlZzNHlUdGZ1UVRqdXQvMDVESmNGQVdPU2lQbWRra3IyQ0pJTll2?=
 =?utf-8?B?SGIrTEZnMVFpa3RRS2c5b1pManpwVWhOb21wTlZ0SktLYU1odjdaSmlVR1Ay?=
 =?utf-8?B?NWlWQ0lVVG8yVDZRZ0V5THQyS2VCbExyai83NjFhV29aQ21ibzdCNlV1bmxt?=
 =?utf-8?B?UHlSdndyaU5tQVZka1F2VDJQZEVsK1Z1c3NXTm14eFdLZlhmTFZrYlVzSDEv?=
 =?utf-8?B?cGlPN21kN0U1WEZtdHlFMDgwRCswRlN0MUJJelFrT3dEdStNU2oxWXg5N2xT?=
 =?utf-8?B?Y2R2UGpiQ1VwTDY3RDB4SjlVY0FYMVRHZk9lS1M4VFU1Q3llMmk2L2t5Y2gy?=
 =?utf-8?B?SnNHRndDS2tYVnZhMkJEMHJJdDFhdkNoOUtaNUxFRSs4Nm91MDBNS2IzWUFN?=
 =?utf-8?B?WjFLUXZlRm9XRUxLQXl6SmF5S2V0ZElRRmR6USswWkZ3ZW9sRTZrTUVmVUNx?=
 =?utf-8?B?UlFzZGZpQ25lRHQ5YkhUQ1J2a2RaZitCeVRhMS9wU0w5KzkyOFVqeEJ1SFli?=
 =?utf-8?B?MnljZ2NwRmU1aXl5dE9tb0tXOWcrTU1NNTQzSFpINjl5aGlUVzFUajdSNkxC?=
 =?utf-8?B?NktOdUdPeE5JSlRlRERUZURzSHNHNnRzZkcwWnN0RnJ0eWxXeTNIUXdtcEtB?=
 =?utf-8?B?bHAxVHF6QnNtZFdtM1ZjcmRsOW9xdWt0dzRkdFBhRFJXZmNNR2xuRnF1d0di?=
 =?utf-8?B?M2loWldOT3k3blNEczFRT0N4d1JWV0NTVlVwbGVBOGRYdUNlVUFaeERGVGd4?=
 =?utf-8?B?VW9XWnB4OVJ5aDc4MmUxYUt3UnhFd2NmSVNnMnlWT1FKLzZqVURmK1NzWjFu?=
 =?utf-8?B?QklsaVdQdGx1TFNvUExqQkg3eEI0QWFmeEhsUXhwaWk2V0JmOWF3amdhVUsy?=
 =?utf-8?B?azJyMHJzVXd2dm1TS25KWjFpMFcxSEV1a0xvQ1ZnN0dqclBnS0FhRU9HMUNs?=
 =?utf-8?B?S1lzNXhOLzFXamNuVVlKTVZDVUNFWWJJUXV0SkI3L3h1VGlyYVgzaU05U05K?=
 =?utf-8?B?RmJ4YTNVekIrMld2RURFcUNZWkpJelJDbTBuUFBnK253ZWpBSUtzZTNkQmxR?=
 =?utf-8?B?WXlJc0FYc0V1K0UwdDFWZjJSOXp6VWVrTVV0blVtam5oWTdFSXhmeTNFSjlw?=
 =?utf-8?B?ZVZRNVBpNkEyVlVBWjBrSVJzZzg2MzdCTG9teUtTSUpZcWFPZXQ4V294dE83?=
 =?utf-8?B?Ylg4Wjh6dS9WekxsQS9PRmVNZ2JkOFF2a2lFMEZmbVI3c1J2M1FVS3Z2TnI2?=
 =?utf-8?B?Ti9BR3ZJdHNseS9CMENOM3JoZlRQTXhBblFYMkVDTjVuZFdDUjlrVlUyVFB2?=
 =?utf-8?B?ZkNhRERPOXFRcDZMZE14Ukt5WlFoc0xNK0RkbXA5cWZHM25vNWRrczl5ZkNO?=
 =?utf-8?B?bDYwNGtrWnhmcGRHU3hOaGYwTEVZSjhaVGk0K3JzdHo1U01KbjVXZWtQV1Qr?=
 =?utf-8?B?SjFaWVA5VmZCa25jMWZnSnVydzJsUGQySmZoT2xvTjR3aTNBMUsxMlJ6UnNw?=
 =?utf-8?B?VGZaRll1d1VKOFh1bVpubnVGRmZuTXhPcnVhTUxVeVUrbXEreWo1S05VZW12?=
 =?utf-8?B?WHRlS0tiUkZpWXcrMElkeE5TTTlEb0Zmdk5Dc2xwZUVrSDB0S0tLSytNa0hi?=
 =?utf-8?B?S2t1bHNYOTY0LzZLWHRwelNZVG4vcjdBZDA1TW9SVnhOVmxMUnR5MUZreUli?=
 =?utf-8?B?UE5EbWpDNzdPT0M4alZZMS8ybng2bEx3Qy9yL00zdTZ3TlJnNWVaOHBsN09Q?=
 =?utf-8?B?eXA0K0prekVKUkRMdnRZeHFkM240RENQVDBJUWxoV25KeUQ4V3JLM2Vxc1B0?=
 =?utf-8?B?WGFQbUJnME1WUm5EUzNxQTBBY0lFczFRVWR1ejdXQ2hOTDhLb1FDbUVpQzZa?=
 =?utf-8?B?UWVCd1daZ0s0L3o5N2gveWwydlp5TW1tMVhUWHVQc3RsdElhVExtVU94V0ph?=
 =?utf-8?B?TDhhWXBMbVN2MTA4L0VjTkV6MlV1QmJrMGJhTVJ4WEZZQ1JvMXd4ZldhRVZW?=
 =?utf-8?B?RXY5UGtuOVd6S08wdHRnL3lGNXhjYVoxUFZVMGV1L2dreWd1QWZJdC9SR0Jl?=
 =?utf-8?Q?GCjdWzfMJ7GLpBLzvAhXA6Q=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8796cca5-46fa-462d-775e-08dd132aa377
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 23:40:01.1298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HqPt6tNzqbG+8vSdW3CYz4pwAveKbc9/tUE3sc57p6xecBMdPEBOYp9fAmwS5FY06aH8M3Hg0oQM7nD39V8BJY+FRGfED2T4BApNA5hc4L0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6512

Gently ping...


Any comments on this RFC? Look forward to discussing them.

Thanks,
Yang


On 11/18/24 10:16 AM, Yang Shi wrote:
> When rodata=full kernel linear mapping is mapped by PTE due to arm's
> break-before-make rule.
>
> This resulted in a couple of problems:
>    - performance degradation
>    - more TLB pressure
>    - memory waste for kernel page table
>
> There are some workarounds to mitigate the problems, for example, using
> rodata=on, but this compromises the security measurement.
>
> With FEAT_BBM level 2 support, splitting large block page table to
> smaller ones doesn't need to make the page table entry invalid anymore.
> This allows kernel split large block mapping on the fly.
>
> Add kernel page table split support and use large block mapping by
> default when FEAT_BBM level 2 is supported for rodata=full.  When
> changing permissions for kernel linear mapping, the page table will be
> split to PTE level.
>
> The machine without FEAT_BBM level 2 will fallback to have kernel linear
> mapping PTE-mapped when rodata=full.
>
> With this we saw significant performance boost with some benchmarks with
> keeping rodata=full security protection in the mean time.
>
> The test was done on AmpereOne machine (192 cores, 1P) with 256GB memory and
> 4K page size + 48 bit VA.
>
> Function test (4K/16K/64K page size)
>    - Kernel boot.  Kernel needs change kernel linear mapping permission at
>      boot stage, if the patch didn't work, kernel typically didn't boot.
>    - Module stress from stress-ng. Kernel module load change permission for
>      module sections.
>    - A test kernel module which allocates 80% of total memory via vmalloc(),
>      then change the vmalloc area permission to RO, then change it back
>      before vfree(). Then launch a VM which consumes almost all physical
>      memory.
>    - VM with the patchset applied in guest kernel too.
>    - Kernel build in VM with patched guest kernel.
>
> Memory consumption
> Before:
> MemTotal:       258988984 kB
> MemFree:        254821700 kB
>
> After:
> MemTotal:       259505132 kB
> MemFree:        255410264 kB
>
> Around 500MB more memory are free to use.  The larger the machine, the
> more memory saved.
>
> Performance benchmarking
> * Memcached
> We saw performance degradation when running Memcached benchmark with
> rodata=full vs rodata=on.  Our profiling pointed to kernel TLB pressure.
> With this patchset we saw ops/sec is increased by around 3.5%, P99
> latency is reduced by around 9.6%.
> The gain mainly came from reduced kernel TLB misses.  The kernel TLB
> MPKI is reduced by 28.5%.
>
> The benchmark data is now on par with rodata=on too.
>
> * Disk encryption (dm-crypt) benchmark
> Ran fio benchmark with the below command on a 128G ramdisk (ext4) with disk
> encryption (by dm-crypt).
> fio --directory=/data --random_generator=lfsr --norandommap --randrepeat 1 \
>      --status-interval=999 --rw=write --bs=4k --loops=1 --ioengine=sync \
>      --iodepth=1 --numjobs=1 --fsync_on_close=1 --group_reporting --thread \
>      --name=iops-test-job --eta-newline=1 --size 100G
>
> The IOPS is increased by 90% - 150% (the variance is high, but the worst
> number of good case is around 90% more than the best number of bad case).
> The bandwidth is increased and the avg clat is reduced proportionally.
>
> * Sequential file read
> Read 100G file sequentially on XFS (xfs_io read with page cache populated).
> The bandwidth is increased by 150%.
>
>
> Yang Shi (3):
>        arm64: cpufeature: detect FEAT_BBM level 2
>        arm64: mm: support large block mapping when rodata=full
>        arm64: cpufeature: workaround AmpereOne FEAT_BBM level 2
>
>   arch/arm64/include/asm/cpufeature.h |  24 ++++++++++++++++++
>   arch/arm64/include/asm/pgtable.h    |   7 +++++-
>   arch/arm64/kernel/cpufeature.c      |  11 ++++++++
>   arch/arm64/mm/mmu.c                 |  31 +++++++++++++++++++++--
>   arch/arm64/mm/pageattr.c            | 173 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
>   arch/arm64/tools/cpucaps            |   1 +
>   6 files changed, 238 insertions(+), 9 deletions(-)
>
>


