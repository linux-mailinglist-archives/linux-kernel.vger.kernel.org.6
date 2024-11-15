Return-Path: <linux-kernel+bounces-410810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EDE9CE134
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 553EB283218
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F841CEE92;
	Fri, 15 Nov 2024 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0rGM48at"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F411B218E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731680877; cv=fail; b=HEegVGNTkEbtJWB/2TY0uKlHWx2W5AX4Iy/BD+3Cge/hTFkxXWp4KA1wdwWaN3gd/w9Hq2WC2BKvh0taUr26oY03oWIhEjJWLBAQCt8PY4Z3u7wKlpv+uNMKe6hx1Q9lOjfwFCgiiuCLODFSxuYi3yUcU/PghkvW5yyoF63cnZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731680877; c=relaxed/simple;
	bh=Q+9o/lrzs+hC7od9EVTzDOwUJsw2YJs5hd4DJMdowSU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PLY6g0B2yi0pLbWDBTD43YQC3TpKK1RaxdAw797KlrwZ/J92oPRyRcXjGOJ4aKB2NL7QRQmDCbgpL/dyn3+gI38Jm+ufZ6yF+nnrzejwzZXioVZvHFfwjwXG16SxCoLKOr7XlkM3ze/CIFRTsnOZgSQhXgdNimH0EBY/i0qPCWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0rGM48at; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIJS0OMYTa3iEZ8KJDyWY2LYuU4W417rV2CgB242lsIKpokkhX5ujZ2Pk83/ZLvK5kOhzuh/FKLGuO/qdqyoJ0azuL6cuDo6/fDB/PuP7Oagr48dMQGNBWlbtrfLxqNlgKJeHAPXrZv8LAjD7OU80AsdNeGdGjiHIjIooK6F7vFnrm161wF36qqrNI+xS8eF1HVOO6pSsLbBFuMY9NjIksQGoJkEIq1X177SYwlPJKRWaSdU53CvvBA+hIGQxxD8VKHN+6+G2u+0j39mp9QDgq3hAvvZQegZAg1bQ3PnDE4+J0uAKU1LoiRuhTs3MGJnYaOsrSqjxpnNNLbLuxb4TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9zQsvOE2yJhfuElJk8pzriI8sbt+eeW3xIA1kldohE=;
 b=daoVBkggiDGnwFXZzvmfnBkaOfdwteJ/IYYyh+loXjVp5OKLAjVxtTkeA76d5OfdZryFDYIDUGR6WMgztX98f6Esqao4qdpsvZ3tUAjWSF1r0eAe8bTLjiiCJNUwC7nwVZw6e0ZZfV6LeOxjYlG4AcKL2QPUJrV4gpcnIvdPpfBt5Xx83QCjMW2p9nS8GvTCwneRi+L7X5GFxWl7oi9gk+dnnRFpH0N8A0D9u3u8cQqGrmKaENsEWM9gox7JuwZutyFfRA5DP5VPMFGQfyZarEmDLuSGsCmHb+N65LE7CP6wSpEyxKvR7C0WVYhDMxnhMDealatK1QzTgjbOftuqjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9zQsvOE2yJhfuElJk8pzriI8sbt+eeW3xIA1kldohE=;
 b=0rGM48at905j+QktgtjXk6Y1yLU7YaP1FeeF+BfLmNgsot67T/hV3OE8bsaJo5gxSBp1H5oapuzleBcTFB0V0WH8bzXMSKs1L7wnXfr7ckN1aTV/QHXoqEpc4rjyq6jgypeCy3Ee0wQ9VVwrB31iW9xRnkg0GlXEDbFjGpMZ7rc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DM4PR12MB8524.namprd12.prod.outlook.com (2603:10b6:8:18d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Fri, 15 Nov
 2024 14:27:53 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 14:27:53 +0000
Message-ID: <a3b36643-f9cd-79d1-241d-a7aaddee49b7@amd.com>
Date: Fri, 15 Nov 2024 08:27:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/3] x86/mm: clean up unused parameters of functions
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org, bp@alien8.de
Cc: x86@kernel.org
References: <20241115012131.509226-1-bhe@redhat.com>
 <20241115012131.509226-4-bhe@redhat.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20241115012131.509226-4-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0051.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::24) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DM4PR12MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: 18194db8-8fdb-43f6-808f-08dd0581b0b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnBtUHZGOVBBenhrK3JoRlJSd2F4Y3l4MWQ4UHp6Q3FBOFZMVSsrM2x0TXVT?=
 =?utf-8?B?SVExdFhrcjV1S1hhM2NBSk9qcmJwdUpKVUFNZlB2M2FTQ2x2OFFBMXVXU1Rk?=
 =?utf-8?B?TGtWWEZWMUNoamNzZ0JoU3M1cUl0cGV1NkpiNFpneGQxNUI0dkRTbVpPKzBZ?=
 =?utf-8?B?VjREMFc1Y3R1YjhUeXZnMlNGeXlkbzZYR20rUCt4b1Y0RFFDclYxcXBsbDJ6?=
 =?utf-8?B?VnhYejdWbWRaemJzblJ3czYwbDNFSUQ3UGJ0YWtqaHM5dFl3NnEzK3A3VjBK?=
 =?utf-8?B?TXpZcWhQdE13VEMvSHJzcUN5TXF0WnI0YXB1ODNrU25yV3kxS24wMm5QZDhy?=
 =?utf-8?B?alpaSXVxa0pBSTJvTFM1cUk2djZuUE9TVThDOCt3M0ZDcGFWTlVqYnlDOGdV?=
 =?utf-8?B?OGt6RVNpQ2o5K3Q3NGYwZld5bDEwdi9MTitpdDZsaDZCa2FMUkJrUEFDY1RC?=
 =?utf-8?B?QTZlQm5WcVNGV0VaWVpyYzB5aUs2MjB3TVdXRTZMajNvNnVxakNEL1FZaVZr?=
 =?utf-8?B?YVgvR1BYbkhpcTc1S01iZ2xLbktYNlZOalhrWTlFOGUvcWd4NE9SNjh4STZK?=
 =?utf-8?B?TWREQXlMOXJ2Y3NNdFZoYzFlU0FZOXpUUS95dTRlbElDNS85amZ2NkNMSTlu?=
 =?utf-8?B?QmF4eFhCbmJBT1BZeldYQUxiNkdnL0Nhc2c2NWlpWUF0TWVQVnBxYnZOdG53?=
 =?utf-8?B?b3Fua2dqMHI0cEwyS0NZVzdvc1RHTkxSN29td3dKN3FpWkN0NUxUTFFaK0xC?=
 =?utf-8?B?dVQxdm5xQ0RIOXdPYVhWUXB1aWs1YlFhS2MrS0dtb0dUaXJQWmpwQWZQTGNV?=
 =?utf-8?B?b0s3UVlxQlZtOENSNW1KbzUvVUFtdEl3dTVLeW9MZUFKMjNHNWZEU1JrR0VD?=
 =?utf-8?B?VnUzMWFxNFdndHBJeE1JU29KZWZYYzlsWDFXSFIzOVNCdDRzZFVsR3daUXdm?=
 =?utf-8?B?eTFWZ1BEWW1wSUJERElycHA2TEk4TjZGNGRVU2R6N25VMXRqdU94VU9WYXUr?=
 =?utf-8?B?VHR2UTRPWUlqOGlhSVN2WkRpd2VPazEzTFJiWVlJNFV1ZmowTWlKbzFMYnZV?=
 =?utf-8?B?WFF6MUg2a0haMVNMdysycExpTFBTek16N2xMUGh3WXozbHhZQlEyM0l2UmVq?=
 =?utf-8?B?VFR6NytJQ25RejJNNmxKM2kwQmIwc2NMV0dTVHNrdDhwMFhwU2h6SkFLZElj?=
 =?utf-8?B?YzBPU1RRZjY2N2ZMTVdkVDltTEh6aTZIQ2VWa0ZKRDFsOHk5azFPVDJFQVZk?=
 =?utf-8?B?c3U0NG82VXY2STkvL3Y3bzd3cGlGRHdTY0wwc09qcGZCdDhEUnZyWTMxVVpY?=
 =?utf-8?B?SGVTbVJFaW9oTUdGbmNKQTRtMGRJNitZSnIzVlAxRUx2MTZqMUkxYklNS3A4?=
 =?utf-8?B?bXFzVHBUanAvbVQxYVh1bkRQb3NxalByQTJ5VVBjcnFSeDRTWXR4dXRKckQv?=
 =?utf-8?B?Z1V5dWxRcGFERDhqTGFnK1U5WU1sL3VoOGEvRFBvWGJMZVVXUnEzQ1N4UGhs?=
 =?utf-8?B?b3V6U0t5Nzd2TjBNVGZUYjN3ckw1ZUR6SkZpUUVCWFNKNGw1RUoxdTk3RmtL?=
 =?utf-8?B?Zlo2L0lRYVNIT0JadXhqdXdUZENiVURkc2xzN0JVSHk0VUdDdUp5cnBDUGQ1?=
 =?utf-8?B?czVOOFdPem1DRHNUdTBQS0prQmtzSS9xdzN6aUVzdjlZMVBGelFmc1IwaXc5?=
 =?utf-8?B?cmZKc3VtZDZKMTRoRFJWek80MlUyZnRiNkJJRnJBeDBIV1g1NkY5N3hDcTFO?=
 =?utf-8?Q?oAIr0xgqr6V0N9q9oodYfEsXQTcVcQFvwkm+Yli?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWJDZXpURmZOV1laRXlGZm1SNjdsejNxMHF3RmFvUXJIdmVDUnZqaWFhUVha?=
 =?utf-8?B?Ymx0RTdTUWwxM1R2bys1ZUEzeW9MTUZld3VKRGNhdS83dHZoa2RlOHBZMVQ0?=
 =?utf-8?B?YWgvT2diVzUyMk1HYkV5dDhCczZXWHN0ZVFzOStoWGZlallhdklGblVWMlNy?=
 =?utf-8?B?SUp1dDZ6TlhWOUFNR29VMERUdHVkNXVzQU1raVdtd3FKRmg0WVN4UUVwdzV6?=
 =?utf-8?B?WUJFc1Q0RklXNEtPdXp4cHBEY3VWb0RQZVZUN1ZydlJhU2pkZHJWRzhzc2E1?=
 =?utf-8?B?Njd3VFhEanFoL2xseUVHL20xRHFGR0NWUEFHTTFYQVY0S1R1SVZZZG5rbU5r?=
 =?utf-8?B?eXdBSGpTRExoYUJQWmRqK2xGU1lkUUpLc2IrOXBxRE1WOVRxaUhJdk94R044?=
 =?utf-8?B?RGtoWjdTSkhoeksrS2k4MnN6bE91dWVoS3k4eFhWS0Y0c3o3cUFFRjF0aHBS?=
 =?utf-8?B?eWVWQWFnaGJRYmU1ZERDamZMeGd5cjNWbHZpOEdwOXZhV2QweVBrQlh1SHhS?=
 =?utf-8?B?aWJVcm9sLzdrNElVSUhzdWF6Mmk3bjdUT0lJUWNOa1FQUjZrTFpLYXkySjF0?=
 =?utf-8?B?b0kzdzJWd2RiV2kvOUhFb2IyOGtiZWRHM1ZBek9iaHlrdThzNklqOEphWll6?=
 =?utf-8?B?bUQvVXN4L0ZlSysxempXU09Ld1orZDd4U2txWmVKMmFMYnJUQ2N0ankwQkRV?=
 =?utf-8?B?eXRIMVB2TFFRL1UxaWEwN0lGMmprVG1Jb0VFUi92WXNyVk5xUWtCNUZFK3F4?=
 =?utf-8?B?bHU4SVhnWVZGUHFQY0szUWM5OTViNCtxWWdBVUFvWjB3T1diRXJXREIvRlVB?=
 =?utf-8?B?eUxZRkdSQ3diWURlSzl0K3hDY3JSaE5oMkMrNTM3WVV0MERnT0lxVVQwQnV0?=
 =?utf-8?B?ZEFjbExMdy8yOGxtYnNDbE1rVHFnZDQvRGNzRjgrbDE2WmZ4NjIxRUpjQUJR?=
 =?utf-8?B?OUxIbDFTclNseVFXRHZHZnBDRW45V1FtUmdTbEpBUkMybUtaTmJJSnVtNW14?=
 =?utf-8?B?T1Qrakk2Z0tmTzBIb3hBYmlpZzFwekV4QTA1VHBYTjlsVkNaNVdNMEo5aHY1?=
 =?utf-8?B?YjUrR1hTWlVCY0EwN0pHSjBmNFJSNmtCNG9uWUlwNEFJRkRhM0gxdjdzamFN?=
 =?utf-8?B?VE9jQUlsZEp3VUxFWm9DS01iMjNLb0IyZWE0QVQvR20zRGNSa3AvOVUzemF3?=
 =?utf-8?B?YlFmY0xvbHVSN0ZDcmEvN2xBcGRBc216cmJvTENmTVhucEpXYm1XZzNmejBy?=
 =?utf-8?B?dWdhWUFDd1pkMGcxekVBNUkzYzlOSXdlRkhVSW1aNGJYRkRtSEhOenFBb3ZM?=
 =?utf-8?B?RVZscHl4WVc2WXZldEtHQXdYR09kR0lhWGxRSk8ySkNXQW1vRXVYSno0MWsz?=
 =?utf-8?B?R0hMT3B2bjdPRjd3K1dzQVp1YUZ2QW4wK2g4MzVWWEZqdTR0TGY0cEZvaWww?=
 =?utf-8?B?bnM2MzZiUTlFQTJQUG8reEFiMlo5T3c2RkM4WTRIaU5ucG9HZlBKVVM4YU1n?=
 =?utf-8?B?bGJLUUE4UkVPb2x2MVFBb1Y1SlYyMHFnYk1GQkcwWWxQclF3bjNXVUtzUUJ4?=
 =?utf-8?B?ck4wTXhlMWRJQXNTS2tCYUQvdTQzaHRpd0Evd2hFaVVNQ1FuZWk4ZUN6QnZO?=
 =?utf-8?B?aUM1YXk4NU4reFNhSFBoQUtLVjBnWkNpaFhlSVlhZDhqNGRpWURUZEV2dzRh?=
 =?utf-8?B?RVFSNDlZVFVYYzAyM1l3eXhlOVA1MW0xWSthUXFQOXJoY0RPczFJUUtzRS91?=
 =?utf-8?B?ZlBQU1lUTkpGTXcwWUpxNVVFRUYvcUJwMzJ5QU52VnRqQnU1L1VhSkdsK2M2?=
 =?utf-8?B?S3pPWGhuRU1KNXJBZDBXb0RLbWhXckhHc1lQbi8vZGVmc3Y1TWhYYk5VRkpn?=
 =?utf-8?B?cmo3QVRQVnJZS2tueDl1TG0zWkdIRDNVUGdCTHBuMm1pODhPWUVuREI5Ulk5?=
 =?utf-8?B?NWhiUkhXYlVGZVYwaHFXVVJhMklBZUU0ajNFcFpuT0hlUGd0MkVjbWZaZ3pH?=
 =?utf-8?B?MDBDVVJ0YjIwejlEWEI0Zk15RXFiOUhwMnhxS25KajBCNFdlZ2pJY05KcVoz?=
 =?utf-8?B?VkNTSE4yVnR4Q3YzWCtzZEdGL2QrczhqallWVjZua1pYOUxpeCtrNGVTbEc4?=
 =?utf-8?Q?Br91J+sWt2mKOXgwnnntWcO/v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18194db8-8fdb-43f6-808f-08dd0581b0b6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 14:27:53.1185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ew/lRq0lBwHW63Wh7WITvVKpZxvTf7IBMCiZ/LEqHGkTXIcomM8cj0iNshXQjiSr3RAluGQwr+2VOZzD/9TMeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8524

On 11/14/24 19:21, Baoquan He wrote:
> For functions memremap_is_efi_data(), memremap_is_setup_data and
> early_memremap_is_setup_data(), their parameter 'size' is not used
> and sometime cause confusion. Remove it now.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/mm/ioremap.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 5d1b5e4a8756..71b282e5a4a0 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -593,8 +593,7 @@ static bool memremap_should_map_decrypted(resource_size_t phys_addr,
>   * Examine the physical address to determine if it is EFI data. Check
>   * it against the boot params structure and EFI tables and memory types.
>   */
> -static bool memremap_is_efi_data(resource_size_t phys_addr,
> -				 unsigned long size)
> +static bool memremap_is_efi_data(resource_size_t phys_addr)
>  {
>  	u64 paddr;
>  
> @@ -709,14 +708,12 @@ static bool __init __memremap_is_setup_data(resource_size_t phys_addr,
>  }
>  #undef SD_SIZE
>  
> -static bool __ref memremap_is_setup_data(resource_size_t phys_addr,
> -				   unsigned long size)
> +static bool __ref memremap_is_setup_data(resource_size_t phys_addr)
>  {
>  	return __memremap_is_setup_data(phys_addr, false);
>  }
>  
> -static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
> -						unsigned long size)
> +static bool __init early_memremap_is_setup_data(resource_size_t phys_addr)
>  {
>  	return __memremap_is_setup_data(phys_addr, true);
>  }
> @@ -739,8 +736,8 @@ bool arch_memremap_can_ram_remap(resource_size_t phys_addr, unsigned long size,
>  		return false;
>  
>  	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
> -		if (memremap_is_setup_data(phys_addr, size) ||
> -		    memremap_is_efi_data(phys_addr, size))
> +		if (memremap_is_setup_data(phys_addr) ||
> +		    memremap_is_efi_data(phys_addr))
>  			return false;
>  	}
>  
> @@ -765,8 +762,8 @@ pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
>  	encrypted_prot = true;
>  
>  	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
> -		if (early_memremap_is_setup_data(phys_addr, size) ||
> -		    memremap_is_efi_data(phys_addr, size))
> +		if (early_memremap_is_setup_data(phys_addr) ||
> +		    memremap_is_efi_data(phys_addr))
>  			encrypted_prot = false;
>  	}
>  

