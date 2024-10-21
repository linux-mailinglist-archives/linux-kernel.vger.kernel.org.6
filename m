Return-Path: <linux-kernel+bounces-374729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 836489A6F12
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085671F21D39
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759041D0164;
	Mon, 21 Oct 2024 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kQrIZUhb"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D44E1C8FC2;
	Mon, 21 Oct 2024 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729526847; cv=fail; b=KEsO2toE40n5jO0TAarXcyDPhxHSqzjD4R8JeVKijeMqDw6LwQWc/68BTVK4UTUiXzcBrjqaL3CsSHYwkvxCAO2pQAT3djfmjW2HKuigeiK1KJv8TT6B65MOiJwh9wABaVuCOyGaCc7HCMjfz8RFIEzveO9tUhApBa+L1yJj33c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729526847; c=relaxed/simple;
	bh=nD/Mh93xy3iGe6yVyJKH4ff3v9KShPwxMUBGrmeaTOI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NHwohJYp0qPHrPO8FyGepFfmnZA7xN60oAVvF9EUgvHVMsMrwQlKqoA5OPB+FA5HkzaBT/E6LdG0tm/fWPzIIwbo7Sc1HdAGdJYYrWhjE9oaiWPDeoEY+Viz+FDh1iGMkZ+BAbfjUdXaXnHsaoX9kPROYoTkHmb0RXFBXLp7jGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kQrIZUhb; arc=fail smtp.client-ip=40.107.100.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nk4MYGOsOIuY5smjZZrjujV9Y/aMB35Y8CxEh0c7Jnyu2iC8hVFpCX9c6PcwaDBV7ECiCJuv4uCJQjVA9rbvCQKdWNupSKcwtb40tnDLgFecbNassMf063mMGlHQ31cnbeiBEpynqzqw/zQeMivScCr0CrdbSczypAlXqpZHgu75SqAVn1R4RMDsFdTt+TY9ZwzChA6aiYsVv+VMc7loVrvRSFgLXr/KvWfOlNwJHRhQ5BKo/VNEh6NRssng9wmwr6B5DqFtZ83BoKNizI7jdU2EGADtS+F8h5C9lYn27RXFTZGEZiR3pykatgv2f5VeR3lqmabkzq0ANd3p7yEHww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHV6oBXUoIQBkBWZAxp1P/uIjw2tPSG6Lr/LfdL9Wws=;
 b=tL+cDR/2iscra0c2+VvagblY9otVe8PNjAHuQoW/oXQkFgDLT5WMibBivDKmlbkSJsUaMLkh4bGqx+jeykfRQcMI+b+b2V1sgSbtmVL0Uh7JY2Yo61N0Gq6qrj1ygrWjW7SBjugmiEF1UgaXupBgWhOi6r4Jki/1GzHjPH9BUnHyS90oYD/49EI4Qh1EaPZPo4Nm8IwC8kft35Wwmg/sCOTI+KCLEjiPMsutbhUDsqwCf3nqeRqncOIihNSnYTln0kFWzCcBoN1GsgyXcMElwh5ywXPvDn/nBzkMjSISbZCWKGu5akZUzIkCYf2EjBv5uyI0/0tDmo78jdy4+7TOWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHV6oBXUoIQBkBWZAxp1P/uIjw2tPSG6Lr/LfdL9Wws=;
 b=kQrIZUhb+bNH3DJs5WIIkq9P/aEdrngm/4RAYRy+nY2Fn961iIA8UfnLp9tYqs+VjQfEWUmTBvAp4qXwcY5ZZS/dCB9dYOhXRc0GS4ELfFnA03fb+tnhV3IbbhNPegmNudaMh+8AmZR2FfHlxQj9jsNHNdoKNghspvFBTPv0fNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 by BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Mon, 21 Oct
 2024 16:07:19 +0000
Received: from CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753]) by CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753%5]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 16:07:19 +0000
Message-ID: <73a6cdd5-9791-809e-e1a3-39329867d986@amd.com>
Date: Mon, 21 Oct 2024 21:37:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 5/9] misc: amd-sbi: Add support for mailbox error codes
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@roeck-us.net, arnd@arndb.de, naveenkrishna.chatradhi@amd.com
References: <20240912070810.1644621-1-akshay.gupta@amd.com>
 <20240912070810.1644621-6-akshay.gupta@amd.com>
 <2024101351-hash-deflate-b339@gregkh>
 <27148cde-29db-dc77-18af-2fe56dce036e@amd.com>
 <2024101541-domestic-steadily-6451@gregkh>
 <420ab0bf-32cf-cd98-c711-0dacc8bcc161@amd.com>
 <2024101854-twister-stem-e3e6@gregkh>
From: "Gupta, Akshay" <Akshay.Gupta@amd.com>
In-Reply-To: <2024101854-twister-stem-e3e6@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0171.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::26) To CH3PR12MB8909.namprd12.prod.outlook.com
 (2603:10b6:610:179::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8909:EE_|BL1PR12MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 3750a8d7-3764-4bfe-30e0-08dcf1ea705b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmorT0plWllHMlhPUmdvTm14Mmx4R0FBTUpKVFRBVDNMcDE3SlVGL0R2M3d0?=
 =?utf-8?B?RW9oVTlPbExYN1pNZG1Ka1ZVazZJNk9kM3ZLUWdnVjFpT2xUWkxVT09zZTNl?=
 =?utf-8?B?YTZ4Zk5WUzVYVkl0aGlmdXppWGFRdUFES2gwTzlPRUF2ems5cVJYS2FySnlW?=
 =?utf-8?B?dm5mUElBaC8yK3J4c09La3VXV0xJNUx0UFh5MDY1UkJjdUdKQitEVmpBbmxl?=
 =?utf-8?B?Z0Nqc0NzT01kalJVb29Ha2t2V1E0SVM2YkJpb2I1RHN5Rk5FZHRwUTVzKzl2?=
 =?utf-8?B?OXdVYUN1dkZDY2JYWUpqakE2UVMrQURoRW9henlkaXdWWnZxY2kxN0xQZitW?=
 =?utf-8?B?YWxjVllwSkM1L1ZtMWpRQytaM1Q5aDVwZUZxREhjY0hyTCt3VEExZGNaNVZL?=
 =?utf-8?B?VllRQkpFUnJERFMvb0hVZllNQWJWZFNQbUgySzVDcnh0WVo2cG93bDVrd2Nk?=
 =?utf-8?B?YklOREpxbFczSWVYU3lpOFlKSXFlZFRLUFp6K1dRZWY1K0QzaHZ4L0dPdFlt?=
 =?utf-8?B?OUpVMWhwSDFNOWVjSlZKbDc0WUp3ZkN5azliRVNqVGlMZXh0di9yWjJtRnYv?=
 =?utf-8?B?Ny96b1M4QmhHSE0xMkRGNkZmSEhTbWdFSzRlREFOK3plK3lwQm5HSmtUMzlJ?=
 =?utf-8?B?Q2R0bFlYcG5TbnFSdE9oN2FNNXdqc3pJVDhJUHhxWENUVENRVk9uUlVrVUp2?=
 =?utf-8?B?c1dYMjlJVzVoZXJuU0tVdVJTc0xVUTdtVGJUK0Z4ZStsNHM0TkhnVkg2dWtl?=
 =?utf-8?B?SWNyclVJclpHTTlya2Q3R2pqbnc2K0F3YzNsbzVvbEt0MkI1OHdRZ2Yza29j?=
 =?utf-8?B?MU1qTmJieFZxTEVDQXdGelFtL0I5QmxLdHZzK01KZHNGZVBtdlNudEZHWmZn?=
 =?utf-8?B?UXRIS0V4NHJYa1o2TjBBWjVkQmZrYTMyM3lhYlkydkFlUnc1R0pHeStpSXVK?=
 =?utf-8?B?UU9BZExCRUZia3A0ZmRlL3FQSjFsckdkMEFIZ0MvblM0SjNodlo1V09PdkVo?=
 =?utf-8?B?OUt4a3NTY29COWQ5NUlXOHNIK0kyWmZDcVpMZ1ZZTEVPcHRobG1hcDlKUUhY?=
 =?utf-8?B?QWgvYjVsb0xlVVJkWFk1MzN2Rk1GNE1QQmhpdmJBZzgzNVNNMnhXYXFsVFd5?=
 =?utf-8?B?UU9VbENOSDluODJnSEdPdzlxZ1FhbjdJM3ZPb3ZKdjdYcDY3TnFScURZRzJW?=
 =?utf-8?B?UElzdm5DVUpsUWo1RnEvUEJNL3VoRGhVcVRFMm4zcnM0ZnJ4TkF2aVhpZFpw?=
 =?utf-8?B?NVdudEVKbDNzQUMrV0NySmgwVDgwYlNGampOanJzTllIVVlHWjFzelBObWZa?=
 =?utf-8?B?NkVJZVVzM1A0b3NaZDB1OEVzRklmWUVOdWFadloxNTZ6ME8vUUNzRmZJaCtl?=
 =?utf-8?B?SkZkNUsvY2hJNXRwVEErNEhJYXgyeG1ERGdYbW1aNW5CSVhqRlBIMWF3bjFX?=
 =?utf-8?B?VVdta0E2dVpmT3VmY3c2NldQTjBmK3AyL0ltQVJhTTFQK2tWTTNBbDBUNkJu?=
 =?utf-8?B?cGl4aDk2RC9kV3hmOUxKNmRweU9jYmpWdkZjUnpEbkU5SGttK3Eva1VPNG5z?=
 =?utf-8?B?WVZyUmFzNzAvRnRwVjgwQlFmdVFZNjhkRU8rTnFHeWw0VWYyTXpIczMzVXNQ?=
 =?utf-8?B?TDkvaGxueTlWTEF6SjA5Tk5NcXBiNUZzV1J3Vlk1MWNDMTFobnVwRzh3R0hL?=
 =?utf-8?B?RHZEdFRWL0lNZnVGVTlnMXROcDIxM1Ruc2ovRnc5TGhBSHpPYTF3V0lmS2ZQ?=
 =?utf-8?Q?EpxNJgIIcI0+tuFnXuJLeAX09s6G7+ug99NMCuW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8909.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDJDMmJtSlYyb29aWXlzY1pUN05hZlZoNXArWDBUeVJ4d05FODVvcnBBQ3lp?=
 =?utf-8?B?QS9nOUs0Y1dzTzhnZlRqTzVRR3l2eTZlQ0xKS0tzZHRXOTU2U3hvbUt1WkhP?=
 =?utf-8?B?RkN1TG9uSmlNL1F6RDMyeElCcXcvVGNyYkhGN2N1SkRCbjN0WGNnanVmN1BL?=
 =?utf-8?B?b0d4SEtBRUxCMU81alJqbGhFeHJMOEhPWEdyc0ZKdVRrMjlYOTE2NlF1bzNj?=
 =?utf-8?B?elp2Q0Z3a2VUYU12T3d6N3NBNVZod2tSSHFRNkQxdzh2NlR6M1V4Vy9DQ2hI?=
 =?utf-8?B?YWxRZXNnU3cvZ2Z5ZGxvYlFMeGVtNGIxQWtIakxCazhmOGc3ei9aQmRTWnB0?=
 =?utf-8?B?WEFCTlFqakthZFhtNW5IRUovRjFyUEt3UlBtRDlaSXVGTjlDaDVnVXFYVDhF?=
 =?utf-8?B?TXdPZm1QOHpTSWl3eHJpOEdKdE9uNHZyQTFUU2c0emVKemVFc1hNMnZiNlFj?=
 =?utf-8?B?TlU4VDBVOWRySFVGQlFIeG5RVHZJbnhvSFkvUTBjdmQ0SldXWTVZRmxkTmRK?=
 =?utf-8?B?cHdEeldSVThwb0d0eFNKU1V0OW53Y1Bpekl3eGk2K2RNYk5PRStRY2Q2bWxM?=
 =?utf-8?B?OHZKazFzOFdDOGJaUG55WnhKQmwxTDZ0aWtqd25pN1FOQjJPeE5nY3FqSzZ6?=
 =?utf-8?B?YzNRdW5JZTc4MVQ4UGFPM2xMWDVoMVpiWXJYWDJxT0FxZGJ0QmFpaFI2a1ZH?=
 =?utf-8?B?VGpmWVVSd29tazZWWEMyaVdmNWFTSUlEUm9XQm9vcnBzODV2WWttSlJZR0Jz?=
 =?utf-8?B?aDl4Vk9aZDhISVFwKzk1K2JWTWJRVGxCUzVRR3Ftb1Q4Q0s0ajZTNlhNckgw?=
 =?utf-8?B?UGhtdU1xaksvaFlNT24zY002eW9uSHcwenl6dzY5MC8wb3JjZ2ljTlg1TkVj?=
 =?utf-8?B?OVNaTlVMTlBYWTNFZis3byttbC85N0IvQzMxSHJ3SUVRRElVeXlTM3pycVl0?=
 =?utf-8?B?SG9IUzVqTUhBbFdac3dWSFh4UnpuMkluTHNPUnhxUmhJTG44MzNzcjh2cFhv?=
 =?utf-8?B?QUdUN01hYW5zM1ExMFRIY010cGkvY3pURk42RVJIL2I5REg0OFZ4azFKanox?=
 =?utf-8?B?YVZUOEZxK2JHNWpzYnErRC91ZG9OTURmTllKaFY3LzlYaXJQQkJGeVJJRHdv?=
 =?utf-8?B?VzVIRE1YQy9xa1BlYlNKdkZpNWh2OXhUai8yOS9MZnIweDNBU2J4MXlQM1FG?=
 =?utf-8?B?MW5zUTQ0b1ZVSUU2RDdjczhXMWpVZS9mVVVsbWNjZmtxdnFoRWxGdjdNbk1K?=
 =?utf-8?B?SGJ5UDh1cFVSRjI5YnZXUElRQUdwUmRNOVg2WlM4SFlnc3pkQ29YMXFtTGR6?=
 =?utf-8?B?M2dZZncvNG0yMG9yd2tmUmFqUmFrUzdHRjNucWs1K1Z4eW5Hdk1mYlNHY21L?=
 =?utf-8?B?S1NZcGVwR1c3WVp3bElJcmMrcWRsMWNDOEdxdkV5YXpybWpOQ3VKZ3FxRUE4?=
 =?utf-8?B?bnhDTlVsalJGK0NiSCtDdlpFaUdueWVBYnhXOW5ONVVlR3JkcExYa0VTcW40?=
 =?utf-8?B?RndqSklNZXZicHNUMUVyd2Q3cW9nQWJZL3pRbm9WSTRUaVphZUE0aDNZSU5G?=
 =?utf-8?B?QlFYSnJES3daZ25YNWtrQkdJQmdWTzRkdUFGcFdjQUJJNysza0pnQXhXTHVT?=
 =?utf-8?B?TlJGblNZOUIzcHYzUk5Tay8zNThzOHVwSTRxT0R0cW9Ba1E4TDgwQWkybWFy?=
 =?utf-8?B?NmZvbVJTSWF6dVVRMkRISjJJaStWaHVXNVZDalVURUNkYk9Oa0FuaDJGUCs0?=
 =?utf-8?B?cGQ2aXNmamd3MmFNQTVESE5naE9tQ2x5bi9ZemZ6SEh4Q3BxTDU3WkZhSkcv?=
 =?utf-8?B?TStaSE9QSGt3V0VINkYyc0xhUFp2ZUlPYkJmdnhsWlNtMTd3NnorSVQvVmtO?=
 =?utf-8?B?TWZza2RDQXFTWU1zQ0F2SkM3Q2xmdFdTSkRWWmhITElvZGpKVDlWU1NqTnFx?=
 =?utf-8?B?R2ljM3pnWVVxazhweUpiTVM5dER2RUNIVEdRa1c5UURRRHhpM0ZHZXBkVXNR?=
 =?utf-8?B?akluaE1iK0lLT0RqcXA1QU1VQUNTa0ZRaVFEV1prN2tpdmc0S0ZRYi9DbU5r?=
 =?utf-8?B?VWZtZGQwU0t2eVcxVXhYc2pDUmZZeGx1YWQ2eTlyU1VFRFczQWYyeC8zQmxx?=
 =?utf-8?Q?U4XlQ0kItsYdpB2xVpDjuVbIJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3750a8d7-3764-4bfe-30e0-08dcf1ea705b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 16:07:19.3676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M72EDDSyvmHqwU185H8He5avZw6grQ7ipZkfWcFkGgedyQvfUxFe/C4nbtm41x8FnrLbkXiA4maG9w86+2pA1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756


On 10/18/2024 3:05 PM, Greg KH wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On Fri, Oct 18, 2024 at 02:53:26PM +0530, Gupta, Akshay wrote:
>> On 10/15/2024 3:34 PM, Greg KH wrote:
>>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>>
>>>
>>> On Tue, Oct 15, 2024 at 02:42:08PM +0530, Gupta, Akshay wrote:
>>>> On 10/13/2024 8:49 PM, Greg KH wrote:
>>>>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>>>>
>>>>>
>>>>> On Thu, Sep 12, 2024 at 07:08:06AM +0000, Akshay Gupta wrote:
>>>>>> --- a/include/uapi/misc/amd-apml.h
>>>>>> +++ b/include/uapi/misc/amd-apml.h
>>>>>> @@ -38,6 +38,10 @@ struct apml_message {
>>>>>>                  __u32 mb_in[2];
>>>>>>                  __u8 reg_in[8];
>>>>>>          } data_in;
>>>>>> +     /*
>>>>>> +      * Error code is returned in case of soft mailbox
>>>>>> +      */
>>>>>> +     __u32 fw_ret_code;
>>>>>>     } __attribute__((packed));
>>>>> You can not just randomly change the size of a user/kernel structure
>>>>> like this, what just broke because of this?
>>>>>
>>>>> confused,
>>>> The changes are not because of anything is broken, we support 3 different
>>>> protocol under 1 IOCTL using the same structure. I split the patch to make
>>>> it easy to review.
>>>> Modification in patch 4, is only for the existing code. This patch (patch 5)
>>>> has additional functionality, so we do not want add multiple changes in
>>>> single patch (patch 4).
>>>>
>>>> The changes done in patches are as follows:
>>>>
>>>> Patch 4:
>>>>
>>>> - Adding basic structure as per current protocol in upstream kernel
>>> So what if we only take the first 4 patches?  Now any changes after that
>>> would change the user/kernel api and break things.
>> Yes, it will break. We need all the patches to go.
> That's not how to submit a patch series.  Please work with the other
> kernel developers at your company to do this right before resubmitting.
> You shouldn't rely on the community to point out basic engineering
> problems like this.  Would you want to review a series like this?
>
>>> Please don't write changes and then "fix them up" later on, that's not
>>> how to do stuff as it makes it very difficult to review.  What would you
>>> want to see if _you_ had to review this patch series?
>> We submitted a single patch in v1, later split the patch based on each
>> functionality for ease of review.
>>
>> I will squash and submit along with other review comments addressed.
> No, don't squash, do it in a patch series, one at a time properly such
> that if we were to take any moment in time of the series, all would
> still work correctly.  That's the proper way to do any sort of software
> engineering, this isn't unique to us at all.
>
> thanks,
>
> greg k-h

Hi Greg,

We have compiled and verified individual patch in the patch-set over 
reference BMC platforms.

We have an open-sourced user space library 
https://github.com/amd/esmi_oob_library/ 
<https://github.com/amd/esmi_oob_library/> which depend on the 
out-of-tree kernel modules open-sourced 
https://github.com/amd/apml_modules. <https://github.com/amd/apml_modules.>

This patch-set is an effort to upstream the out-of-tree kernel modules 
open-sourced at https://github.com/amd/apml_modules 
<https://github.com/amd/apml_modules>.

After all the patches are accepted into the Linux, we want to update the 
user-space consumers to move to drivers from Linux kernel and deprecate 
out-of-tree modules.

Thanks,

Akshay


