Return-Path: <linux-kernel+bounces-365454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F8599E28E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99861F22E12
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCB51E570C;
	Tue, 15 Oct 2024 09:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zwVQhTLq"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527A11D9A6F;
	Tue, 15 Oct 2024 09:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983540; cv=fail; b=WSKBUUCxWSw6mgEEkdA9dp7sVHQkd0NyxdOFvJyZl2afzaMsaBKx9f/u9GwMwF/NMtGfmN96/+ifDSkfNunxU8u6DrkElNiYl+8PLVa5qgKrI/5gCHurJqouf8T3SeyO6HDLUhMEpKTObYEA5BZaQ7Onsd7wF0wYKLxK1Hw+hTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983540; c=relaxed/simple;
	bh=2JwKM3QxOcel86QsxHkEwViK8rSSwB2Z3i7jWvKeC0E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ikYW1YnHZM1oQZe5tYcW+nUBje/pjk+TM39hShUna15E1C5UUuiAO2xKskNL3kfeSPgu0HClxLxSBvmgUcBQzuF3wm4ZGaW6bk1bBVTXiDULUDDf4IOBaN9/cCWXRlIVpJxJLYq1CfcBokqCVf+kDL1pJy2V0kd2Ujb5lktvzl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zwVQhTLq; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zlso9IP9vuyBvXPw+cYvOqxxwdijo8lYaACWwQ8FRtVm/Z0Pi6BtFPhtM4fcpyPuEo6EN1uqwnsu0K8sgt42mnYZygtSAfKGAOroMifueHXKHa0rAWHKpgEMj6g01MgEUWBfRE3rebOVxik12Rm4SPVlkfdxILN1BRrHaetIKeO9eo9cxaiOOkQISs4ItkmG7nQ+hKrGobXeGrSbhxvvqz5tpdzPK2I8NZUq/2Jcp11krYRCn7NBKEmBeBnWiW5F2Qg0gI/rkNBZ/Nif0YyePWkFD7xvk9LKlLBHHynsO+gviETgGyIvn9PkuTCSDK9G9mAJ3NIrh8rqX9LcckxYrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZrpqNhTS9vhZ3Tn8sFg8M+78hW/WdJGR4Wl9Qvba4c=;
 b=pnz6t57HDmNYWCWMZ9LIl0b0tuE7m0q2bmV5geBMYKEtpVceURDpPGOePcUBL5qmed3Y0kVytdCC8OYaZ5YXpAWeg0NY9mEi5SfPO6ZxVUdtKn0vHiYvEXawNZw23nGaLAQRZu4ZSYZHULIF0hNdk3HTfc7Jm1LIfU9wwDdYkPSsJwlbB0vhoIO6EfdwscBiLtToh+llpr6kL3xmWGvR38nC8vyc9yqfym3Q37H0LYUPblzzg/HSDa/9ls1B5JcmJgkrKcdOQq394v7cbq8uBuvofxTkE8jcnr35tA4o3V+68C919crSMdrwExpm3mgkS9M0TIoXwZq6vseXUBJTjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZrpqNhTS9vhZ3Tn8sFg8M+78hW/WdJGR4Wl9Qvba4c=;
 b=zwVQhTLqQa1IP7seRyHdjOoRfe2SCQrmoFkxkCs1I5YzwZ4c7eVkCKaIewrezwexqaPL4d8wOv2UNJEI4J6b9gDjwQxWevYR2zGeHxxriiJcVUiQed7EIV/FXb8xgsPZSMYDAnt8Xg6dKWBxNn6uShvg7RlXCHZxA2bk6addfqs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 by BL1PR12MB5850.namprd12.prod.outlook.com (2603:10b6:208:395::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 09:12:15 +0000
Received: from CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753]) by CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 09:12:15 +0000
Message-ID: <27148cde-29db-dc77-18af-2fe56dce036e@amd.com>
Date: Tue, 15 Oct 2024 14:42:08 +0530
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
From: "Gupta, Akshay" <Akshay.Gupta@amd.com>
In-Reply-To: <2024101351-hash-deflate-b339@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0070.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::22) To CH3PR12MB8909.namprd12.prod.outlook.com
 (2603:10b6:610:179::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8909:EE_|BL1PR12MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: a495ae31-63e6-42ff-c582-08dcecf97639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlhVZVJmV1J0ak8rMWUrYkNoY1ZZeWhkVmwweW1SN2FPcnBjaDEzNE5yTlFw?=
 =?utf-8?B?b1NoQkV6d2dwUURFYVRhaDJkanFDcjA1dFZFeHNjZUg3ZDBPRmtUY2FFZmtF?=
 =?utf-8?B?M2Z2M1hJanZQYlc2ckRrYkhpYk1BZGZnRkxNYjgxdHZXOHU2c0Exb2lxTmJy?=
 =?utf-8?B?c2tQNTk0SFl2MjF2clA1SnR0ekREeDNFaXp2dXUxKy83NEhla1pBa1VJQ1Bv?=
 =?utf-8?B?aXpCRHJsZHRuRHl0eVcya0xkSkIyVGxzRnZIeTNPbjBwS0craXY3SXByVWdw?=
 =?utf-8?B?b1k0TCs4aCtrSUtUbkhqOEIzU1ZOalFhcDdBT2phVTRGMVhHbFJvUTJNZTc4?=
 =?utf-8?B?dmZNR0V1UUh1TEhaOFN5MEpiZFU3aXdreWMvZmZSanRsdDdxTVJDNW1RckVx?=
 =?utf-8?B?ZWg5VlowL3dYV2dlV2xjSVFaNXJqVUgrMUUrSGpENUJDdjljSVNHdi8rMmlE?=
 =?utf-8?B?R3paNkMycU9KZVAvZTFQZ3ZMNnFseEh2S0tVWnN4dEF5MEU3Y2hOSkMzc2tB?=
 =?utf-8?B?SWlVK0kvaVZzL2JpL1FGWUtzeWUwcW55OXNtY25YRURvM21RT2Z5OTY1ckJV?=
 =?utf-8?B?UUVIdko1TncrR0xaRnM4R3RJQXh6aDZOMEpLUGZWcHBGRHhZZHliVVZCWmlN?=
 =?utf-8?B?SUUzdXl2aGtOZG1leWEwYUQzYUo1Y040TzMwaEdnNFVFNVd0Nkl4QnZKclBS?=
 =?utf-8?B?MW5hY2RHOTJ0TXZwYnNTdUJ0eitYamtLck5sTFF6UVVSZXFabkF4UldvWmsr?=
 =?utf-8?B?TDBwZGlydVVzMzJYRHBjZFhiQTZqazdPQjNVWG9EbWxPWTU5ci9FZG50NnN1?=
 =?utf-8?B?VFJnaXRvTjUxeVFjaFhLRXdISGQxOEl5OVRJOXgzSC9OT2lrcThLdUNxK2Fp?=
 =?utf-8?B?OTNjQlRXdUNCSGFzWVRFQWM1STA2WTd3dUwydkoyU2Y1dVZEZWdLRkpxcTl0?=
 =?utf-8?B?ZUd4eU04VlB1V3kxUmE1aTJEcG91a3cyaTZYcEdNZnNDZm9ZSlJwZWxUTy9B?=
 =?utf-8?B?SkRmdHczaDNrcEZweE9pK0NtQWRKRjdjWFR6a3V5VWdlMFYyM2tnVG1ob0VJ?=
 =?utf-8?B?ZzViZXRtWm9mVFlyNEliYk5tSkdjL0dRNVFPWXdmd0d5UEdFQXVxbFNFdlRU?=
 =?utf-8?B?OFNkT0FkQWRVb3kxS0hicjZxbmxlbmJoT3RiMk9XNGlwaTdFbDIwdTErNEla?=
 =?utf-8?B?ZE1Tb2ZIYTd2ZUFKZVJPcEFxem9CTXVKVm1oQjVOa3laRjlKMVdTUkNKQkJ2?=
 =?utf-8?B?Qmp1VlptUEF6UzFLdElsUnFETzRabXpCZWJZdDM1TG1RRXhScndUbHZINHpi?=
 =?utf-8?B?TGxhMGtBTEtydWx4MlVoYlYwT0RsMVl2SUpZTVRMKzRuYUV1SFN1R0k1Wk5r?=
 =?utf-8?B?UUxLQ2pYajVrZXo2RWlBVE00OGRNRmdLeWpEbktRZHVYTEEzeFlSTU5lNTYw?=
 =?utf-8?B?anhkTHgrNG5NeUtSbnZxdHQ0Z2orUFQ2dmFpdUdaYkJTdFpvbWNZV0x2ZXNZ?=
 =?utf-8?B?MkxXZ1Jub2tDV012ckViSFJndWdsSTRidEErQ3R4cW5ZMHlpaUdOUm1kTGdG?=
 =?utf-8?B?d3owZEJiRFV4L3hUVkFzTkg0ejZSOXVRemp6ZW5SdWY5WmhqOXptSU4xQmR4?=
 =?utf-8?B?RjdhQ3dwMmZOR1JxR0tTU3RtU3lUcEQwcTlFRS9LNnpteGZOZUtzWGxuNXlU?=
 =?utf-8?B?SHJYVkZlcXA1Ryt2dnlINyt0UHNjN1VIeHhONkkyVmtOcWhtV0FING5nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8909.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHJ6T3I0MVNuYjRlK0lLZ0Y1WFNHS0NldHlMWjNsQWw1ei9XMlNhRWtZS3VS?=
 =?utf-8?B?N3YrQVQvQTdxTkxTdmZWQUVRYWNuekpuMEtzUEVKWkVydFBmOVYxMUZmUUYv?=
 =?utf-8?B?ejB3bXNqVCt4MlZNYjF4UGVpeDVaR0xya2cwL01Sb3J5S2plUXJvYUZESW5h?=
 =?utf-8?B?RWhkSDhzTVpPcjZzd2xxbExXcWJtU2Q2aE5GZldYRnl5UjhzbVFVWjAyakUz?=
 =?utf-8?B?NER4V0VsTGp3alhtc0ZPRnlXYXJONXhZSjQraHVLY3cvRFhJU25FMlFxWWZo?=
 =?utf-8?B?ZmdwMzlnSWd1Yzl1VDc1OVBUVXZ1dzJibWIxMWZ5YmRHVnc4Nk1qQ1pGa25L?=
 =?utf-8?B?M2tTakZDUEk2aU1qRTFlMVFSUHY5TThKdW04R0owc2loc3MrK0ZDcGVEbVoz?=
 =?utf-8?B?U2g5aGM5cFd1SGN2cUJpZlRsSys0c1hCZ2FxYUNzL1RYbFNLQy9nMW1veE1F?=
 =?utf-8?B?alN1c0V1L3ZQNEhyR0h6bjJVZEYxMHVydUpWbW14OWF2aGxXVTBQcXUzSEh3?=
 =?utf-8?B?V29QRWNFTHJ6aHpUaTVDVU5FM0dNR2wrNkJKT2FkalpTekNzYzNaYk9wK25Y?=
 =?utf-8?B?MHN6WWVQSERCZjJzWWJoT3dLYjlBSmpZUFlrNWVqREZOQ0t5TnJReHlQRk80?=
 =?utf-8?B?UWdsOUdvSm5rcEFIamtTTkpHRDU2dkZBa1lLNUoyQU8yVUNhZ3FtNC8zeXF3?=
 =?utf-8?B?MHk0eHdBeVI3R0RBVERVNzh3OWtLMnVBYWx2c0Z6RlQyM2UweEV3U2lTQnpC?=
 =?utf-8?B?c1hCWk9LOUJXcytqaHdERUVWTEZXd3ZkV2YxNkFtWjVQd05rN1RBTjI1ekRp?=
 =?utf-8?B?ajFsYzVDTWptalFEVlM0T2lIUEtWODAwTjdrUXhjTUVWSVZHZXpHOHhRQ295?=
 =?utf-8?B?ME1DOW9qcVI3Q2ZCUGpsek1SS3Zxc2srTzhaTm5BN3ZDT1NMdDBrMU9JbGdn?=
 =?utf-8?B?ejBMQUZtdVloZUR5YUh4L0w3bUMwTTBZa0ZMclJXYzlNQTlnOFZxSVRHeVlk?=
 =?utf-8?B?NzhVWXBWL1hsdkJSR0RFR010R04zNXlPakk4ZFVIQnBGek9OU1loV2RnWUUv?=
 =?utf-8?B?c21tTmN2MEhMMzFRR1laL0MxdWZPTmtxeFc3N0Y4clFsVUIyV3pZc3c5ZTYv?=
 =?utf-8?B?QWZKakVDamtYNndQTVhyTXBFZkxwSkwxLzV3M2JrWVI4QUVVbzZCZnhvcE5C?=
 =?utf-8?B?VENid0RoRU82WkFSbXVncWlLOWR1RjJ1ODc3ZXNFdVFOZWJBUzVKdGZ3ZE9M?=
 =?utf-8?B?di9nL3JCWkhhazJMYUVyN0tmR2EwdXVTL0hnZzNFYXdXNkNrTVFBODhGVU9Q?=
 =?utf-8?B?YW9xcUdoN0RhOHFBelBTbUs5Y29MRXlKVkxsYVRiaHFaamJCVjNKcDBlLzZP?=
 =?utf-8?B?cU1NZ0dyb2xqelphc3g1NWNYTzVPbDJKRTZsNkx3a1VjanlCVFQ1eVdxS1h6?=
 =?utf-8?B?R3Z0UXVFWWdkbmU2TXI5S2Y5UzZldGdETXNhV0gzT0tVUEwxMVJpSmc1aVAx?=
 =?utf-8?B?YzlDbDNGdWppYXFtdnlDWHY3d29jZHFCZDhRM2VnR2tyMkY4R0xkT0xHaVEv?=
 =?utf-8?B?WnFDL0FBZzVRQ0UxSytzc3VXVStIcnIzc28rRWc5WVVWY2ZVQVYwU2JNQkhl?=
 =?utf-8?B?dTdaOW0yOGs0aUpUSW1pSHZzRld4NFdEcU9qcVZoMUVhTGsvV2VVa0x4YitD?=
 =?utf-8?B?dVBkSDZFUlJFSzV0ZjdIajlaNWJ2SDZKVW11ZHZOWTlPeG43K2tNV01xQlVU?=
 =?utf-8?B?QWtHRlR1cXZZeGxjVE85OW1uOVRodFlneEdvMkQxNnZUQzIzTGNRdWQxM0Ev?=
 =?utf-8?B?RGVZVFpieExOQ3FGeC9qemw1V1Z5RFFDK2FmV0ZMbkZ2YWNxTUlsUnlZNWNG?=
 =?utf-8?B?Y1FKQ3QvMkxqUzdPa1hMekFDSVBscVU1U1c0SnVZWDhCcFN6MjRmNDg1U0V6?=
 =?utf-8?B?eElTV2p6aUhpY3JaU0l2ZGE0WVBOR0RoOWY1ZFZDcDJWeFBGQWV4a0tXRW45?=
 =?utf-8?B?bWxYTUFCc0piZTVtdk05YVBUZWpwL2lES2lLTHRHZUlrRTZzK3JCSTBmTlpl?=
 =?utf-8?B?K0I1SmloYnhDeHFKVExwNllIc3Y1eFowSWE5bnNBRnR1MThSeVRqZVU4VDM4?=
 =?utf-8?Q?5OrxMpUz0cvY07BeMwQTRetri?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a495ae31-63e6-42ff-c582-08dcecf97639
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 09:12:15.7268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5V+LQ47iKfdTqDoZo2VqLv2UZuzN6KZnxkXuyvi3lUj6x4Nw0V9G/XA5csL3LBZSv6p4ujft8uBNA3QVRt7dAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5850

On 10/13/2024 8:49 PM, Greg KH wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On Thu, Sep 12, 2024 at 07:08:06AM +0000, Akshay Gupta wrote:
>> --- a/include/uapi/misc/amd-apml.h
>> +++ b/include/uapi/misc/amd-apml.h
>> @@ -38,6 +38,10 @@ struct apml_message {
>>                __u32 mb_in[2];
>>                __u8 reg_in[8];
>>        } data_in;
>> +     /*
>> +      * Error code is returned in case of soft mailbox
>> +      */
>> +     __u32 fw_ret_code;
>>   } __attribute__((packed));
> You can not just randomly change the size of a user/kernel structure
> like this, what just broke because of this?
>
> confused,

The changes are not because of anything is broken, we support 3 
different protocol under 1 IOCTL using the same structure. I split the 
patch to make it easy to review.
Modification in patch 4, is only for the existing code. This patch 
(patch 5) has additional functionality, so we do not want add multiple 
changes in single patch (patch 4).

The changes done in patches are as follows:

Patch 4:

- Adding basic structure as per current protocol in upstream kernel

Patch 5:

- Adding additional error code from PMFW.

Patch 6:

- Add changes required to support CPUID protocol

Patch 7:

- Comments modification for MCAMSR protocol (structure remains same as 
CPUID)

> greg k-h
>

