Return-Path: <linux-kernel+bounces-297410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D532395B7EB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B8B1C214F7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DAC1CB31B;
	Thu, 22 Aug 2024 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zOvKFIpH"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF42319DFA2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 14:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724335551; cv=fail; b=ABfySvQkfrBFUQs9ofvY8quEsUNAGfteIH+wypKNpGR4lbIwJ1cRnQjIZSHZlix6n9ywYFOkk56UwsEtPN1yBMVPhdTcodl+IinWDXhWOL0TrJG7V69grW5b27w1wEKvm63oseUYBkxwjMfZwH/Vi+TpHMsTGD/VEc2QT7eaqgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724335551; c=relaxed/simple;
	bh=lVqMIxFbBV7KbroQhpfrt3J/7AR6jfwCzDLVA9l+0vY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZMCvezjK5XxrmvbDp+0rk5trJ+uRu7hPSVH2TOoOuvq7Jm1nSVqiIVmEUcL19DKstivT1O5uY4mLk2jBZ69ufy+XcJ+NVTO390WSrPdkkLTb28Yj0gYJH90DfbMYlf41gFZsspL/BWWicZALkRxDxZrYAtwHiAZ+XUyjN89cOic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zOvKFIpH; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvgECPZpndjMn6Y13ceTWS387X9iYqYJJXdGKElVmwxzk1Sm9CyxEFA8CHrFmWPMbp5nuNC1au0+EgnI2CuQXJpNURxBU/8QKTXH9GkUqKa3u/8Vb2IfRIVkhH5tYmjgvFiMo2ZAeGFjyGlqd+aSZG321hjtBHtcwbccbum9PrAoWCqbzxB201QOALM39ekbCw7Ev5JF7adN4Hlc3qB6B36L2Rgq7SyFvFP009Dn4Tt6coOY8/k9f/tL/VhNJXgQlzw/LVEv7YR3itKBZ2wmNy+5mxf1Udp4enUI0q6Ro6Y1UzPEMjE99+er/oWpWMSQYXcnY8iBkIG40MAhE8r8hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udrxOYLOyvMp+2XGJRB7tF0NLxU1ct/V7wAxRHiYOUs=;
 b=LWdoZzlbglZXxzucIsLQQxrxC7SCQc/AxVhXFXZ9z/qlVIhn8opr6+Bi+lydWUK7GI3O5WmbrFDtvDArEkjACCaUGqHzen0SO58hVFYNvNoWvSIjXET6wilrqaH/GAz45FSj2KV/RYtP98mszSBlgyhDH5iAdMM4TcdtzU7vwMr5rUan2UHP3tmkmav48WHgAMAGmrxKpJMx4kFYvRODSUDHRxcyuTLjaJEaSHcWnOdIlyRmJNF3Qm0lgankvB/VMVq9Yl0Ot+ORxVcf8FrqDdRbH+0bXJre/Cn3GTpjq/7RJyqgIFlwe5okkEXyLwmqerlOU+OVtJ/HYn5MFrUpEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udrxOYLOyvMp+2XGJRB7tF0NLxU1ct/V7wAxRHiYOUs=;
 b=zOvKFIpHBnSdMhLSPnrIW/mLCKqSiVU6EuF0TGn5XKuM2xMj9Pz5IY/iU5GJ36WJxUzC8MB1eIb8oeTtQOy7tjcnPZGFLzPnGzY330SPKiGlUhjRDYW0hJlwcc8p4M7Y/0nTTACKpjxSjsrQcES4N+FpSZK88NXGaoW4ATAbFUg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB8824.namprd12.prod.outlook.com (2603:10b6:510:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 14:05:46 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Thu, 22 Aug 2024
 14:05:45 +0000
Message-ID: <5dcd603a-7d62-439d-9a07-9d7d9324e0b6@amd.com>
Date: Thu, 22 Aug 2024 09:05:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix OLAND card ip_init failed during kdump
 caputrue kernel boot
To: Lu Yao <yaolu@kylinos.cn>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, kenneth.feng@amd.com
Cc: lijo.lazar@amd.com, Hawking.Zhang@amd.com, andrealmeid@igalia.com,
 hamza.mahfooz@amd.com, candice.li@amd.com, victorchengchi.lu@amd.com,
 sunil.khatri@amd.com, Jun.Ma2@amd.com, kevinyang.wang@amd.com,
 Tim.Huang@amd.com, jesse.zhang@amd.com, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240723094232.162319-1-yaolu@kylinos.cn>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240723094232.162319-1-yaolu@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0101.namprd04.prod.outlook.com
 (2603:10b6:806:122::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB8824:EE_
X-MS-Office365-Filtering-Correlation-Id: ad261d7d-b247-4903-0be2-08dcc2b3845e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDVNeDcvVGlJNUJHaW9acGUwaE1BYUJEblhKOGs5NlZzNldwWG44NlRJS2lP?=
 =?utf-8?B?bm5kd0lOd3JyRFFZeldWYk52SlpxMWFkT0RabFVBb3ZEdmlSbGNQTGRLQ2ZD?=
 =?utf-8?B?QlErWDRPTXpsaHc2NTlQSGdnN3RFTkdNVlhOVjN5Q1pBRFRKcWZsMDliNW80?=
 =?utf-8?B?bTlGRlY1a0l0bkhWYWphK2E0dnBQL3JNSlppUjV6MEl2ZmFKVzlPMzNkOGZx?=
 =?utf-8?B?VGsrWXJMcTh5ZEF2NGFvZWY3TmF4S1l4SXlZd2tzVjA5UlVCbEg5U1lTbmdQ?=
 =?utf-8?B?ejZKRDAxUUlPVm5hR2xXQTNRZzUzRW5LeVBCM0hYa2pKMTlFMkFwa3RBUGRr?=
 =?utf-8?B?Vm05Ti9kNVVyL0NUZURrYmhST2pncy9RbHh1MitFempCOXpJUDJ1YW5UNXgy?=
 =?utf-8?B?dXFHTWd3STA1UU9takhSSXg3Z2dhWnZxUllnbkhLUW1ubFJIMW51VmhXOHBx?=
 =?utf-8?B?SEtCemFJNjdlL0FIcDdYajZqYkc0S0pCOHRHRXZFQVQ3OXJ2TTQyNHNtQWVL?=
 =?utf-8?B?SWx3a3B5ZzNTYUZVVTJVdUhCbjdVMTUzWnFCK2dYd2d4Nk9wbEVMMEsyQnBx?=
 =?utf-8?B?T3NndklDeXloTUxQRWFzcDRic3ByVitsS0Z2bUthNDBSVnd6RjNZZ1dFWVJu?=
 =?utf-8?B?czYxaitXT0JCM29RRVNNNE1jdHA4S21ackNpTERvTk1Vd0cyMDJhL1pOQWMz?=
 =?utf-8?B?VTgrVmM4NzdqNzc4em5wL1pYditNeWoyUTJmbCtyY1JQMUs0cmczSzFWOGRO?=
 =?utf-8?B?bWkyMzE4THpkV0UrZGlQYnZZNzJnM1lNMHZoUzhrNlZuVUcvREg4ZGVVL1du?=
 =?utf-8?B?ZjNyNHhFaTd0c05XNC9kZ0NyZUh5S1hkQkpTaFdMdUoxSHhweEVZVE5uZSt5?=
 =?utf-8?B?K2JtN3lNN1ZmL2tmYm9QUlBWeEU1UmZmU3FENTVsY2xKWlhPZHdkblFRN3JY?=
 =?utf-8?B?M0FGSmlJUm1uYldCTkJhT2xDcEdsQ25PZ2p6ZnRTU1lyakxQU3lTR0JVUVJj?=
 =?utf-8?B?akN3bk82VFVma0pCazFGUnB1ZU1wNGxJak96TFU1REJvMmFnRTBwY25kSXZi?=
 =?utf-8?B?TGdjU0NuWk9rcjZPam1abzVnUUxLUUErci8rcXhVRHhxbTRReFoxQkd0OFpJ?=
 =?utf-8?B?K0hYRFlJV2RUd0dYUVJnWHFNRHIzQjBGM1FrZWZSSDhCeUd2UktCTjF6aGhk?=
 =?utf-8?B?VWltSjFGQWNibXJ4TjMyMXl5WGlkRDlvVG9pcHBtLzBZdmY2STFQOTEwQXVI?=
 =?utf-8?B?MnFjMnlSeFFnQm5tTWZUc3YrWmlSSTVMNnFWZDNyellPcjBjNEZzRzV3YmU0?=
 =?utf-8?B?VWNxNlRhaFBSb3psVUFYeS90dFpnOExycXFTQUx2RUlUTmhPRnBpYXd0Sm00?=
 =?utf-8?B?WjN5NjNydnNzQmt2Tyt3dUZ2bmcrYTlIZEJTcHVmL003SnkwbVRNMlB6MHFx?=
 =?utf-8?B?aGxsMllDN1VsYkZGa21rYUZGOXN1QitIQ3JVKzlaZTZueEdjM29EYy9kRllV?=
 =?utf-8?B?ZHN0MHNaTTNVY2w2Y2c0dmZtbE9KeG1uMXJKK2R5bFJ1RCtyZ1NMMmZFa01E?=
 =?utf-8?B?MjZFU1RxcExPd0hGY0JuQmMydjZsM3doUFZZajFFQjk1ZVpzVmp4TEYvdnR6?=
 =?utf-8?B?RzRpWm1lZFFQWlZUejNTZTA1SmlFQ0U1TVordXo0MEoyRTVzcTZmWG9BMU9x?=
 =?utf-8?B?QlpnMnBqRzJiL0JZeTdiTnhkNVRqZEx5R3huU2V0cGhiUFBzcWlQb3JudWI0?=
 =?utf-8?B?NVN0YWtHWEpyS1VGdWRFWnBGay9KWGt6dERmN3g1SDBicW84ZElnT0F5Mktv?=
 =?utf-8?B?bXJxRU1rSzJvVGM2QzBiZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWlRM3lMS01qOTFRaWlWbVJSVTdmd0EwL2gvTzRGTWhVVjc4aDA3anBNa0FK?=
 =?utf-8?B?KzE1cTBxNEVvSkVuN0pLd0ZWZlNJbU9YODJUTGV0QWE3UVJGTGdwV1ZkQUVO?=
 =?utf-8?B?alp1MmFtaUU0cGxpenhwa3J5YmIzOXpObE1rSEM1Yk8vRXY2dVRmd0dtMXcv?=
 =?utf-8?B?cnFGR2ZtcXNmQWZVajU1NUROK0kyWkZ3Z3o1Y1FkcnpSc3FLMGVLMFpLdDdr?=
 =?utf-8?B?VHJTVk5TMjNPZXV0TFc3bVJyOHkzZ09HaVpxWlZzSHF3VVFQUFgzNEZZV0Js?=
 =?utf-8?B?KzBqMmVpRitSQ2RkNVhyeFdsK05VdGM0WkVDZFJObWtoZGZjUHRibm1kWFk4?=
 =?utf-8?B?aTMvdTlsbmJITkZCL21YVzNYam9makVBUFB1MEJ2VnNjSWNVY0tWU1pzcVp0?=
 =?utf-8?B?dXNYa2loNnJWUS9mR0dLaDNkYVJvOHpoTnczNE10dnV2OU9JcE40Q1dlUWZz?=
 =?utf-8?B?RVlkdDl1aGRuckR6SzVxVkNnWERDcE1wMTBCTVp6M0NzZDF3WlNYdHdieGJ1?=
 =?utf-8?B?TWFCZFYydlpuK29McURLb0pGeEF5Y3ZGcmFkcnZCQ0dkUzRpalJxbmtTSy9x?=
 =?utf-8?B?eWJUSGQ3ZWRBRks5bzBCWkU5djNocHpILy9aa2Q3NS9RV1U1V0dNa2h1RzNO?=
 =?utf-8?B?dllWR0ltcnVocWJ2R1l4YkJEdVNDcTF2V1loWkdUMG5TaFJkM1ZVYXZsdFZi?=
 =?utf-8?B?a1ltUFFtc3h5Z2lMQ2hZSDExTlBBZnprdlZaQVZLUkx4NEVhY0owS0kwN3Yv?=
 =?utf-8?B?L2hzTnluUFRLRy9rL3FIbFhQNS9rSk9lajV6Z1dFMkpwQ1g1cVU1dEVFSklK?=
 =?utf-8?B?RVl5a1RNQzIwazluK1F3OVFUT0lGK2J2N2w0WVVwOWFRZGI0SFd6YU8zVUlJ?=
 =?utf-8?B?MkVEcGk0YUVOY0EzZ2RvZHpLbWsweVIxYkN0bVlReWlrbkdWRGxYSkV5S25m?=
 =?utf-8?B?cXlyNGkrOHhVYmF2Mk11VkZnUWZpOFZKMXhUVEdOTk1tblpkRWdPbHphbTQ5?=
 =?utf-8?B?UVUwS0tWMjRsUTZOZkMyRVR6dlVTT1JzL1ZJOER5enpNK2ZQc1R4a0l2TFl5?=
 =?utf-8?B?b0pYczlOcHBZR1lXK3FMMWxTUWpsSjkyclgyeGtRMHZWb2p4WjlRVmhuWExK?=
 =?utf-8?B?bHBYc2RYMzFwbTN5akxDTlFWQlYvL2JtTERYWVk5SEVvQitWemxFbURKMzBm?=
 =?utf-8?B?dGRrYzRnZ0dwc1EzSFArUGhwMFRCcm9DK2FaZTQzQUNnV2xqTVFZMkt3Mld6?=
 =?utf-8?B?UDhvTURXcVF2RXVBNEVOSE9TV1pLbHdPQktpTWtzbTBpT0xObStjSjlQVDBs?=
 =?utf-8?B?NVhYR3lZOVRGZ0hKQmNXZGQwSFhuUHR1QitOTzBiQldSYWYxY0o3STNmMy85?=
 =?utf-8?B?NjZCY3lhenVTMVJWWFJjUTVNTHRlT044NmtIRHpNNjVnWkJhdko2UzM1YUVw?=
 =?utf-8?B?WVMvbGd2VkNHYUQ3RkZTSUJqRDBzU0tINzgyTU1BN3BmM1BvV1YyRUxmclJX?=
 =?utf-8?B?NHhQYTVoVlRROEpqeDlmR2RPbkhaTGI4TTViTysrUmFYaXBjRjNkUWFsWm43?=
 =?utf-8?B?Q2tQcFJ0VENPeUpDR3VYbXIxZjdEY1V6QnVKcWxyRDAwUnFpN09FaFJBNUo0?=
 =?utf-8?B?TGdodmgxQUZiTWZRV2M5Qlh2bUhNV2VZREJnL2kyTFdLRVdIY2JyMjRtTXBr?=
 =?utf-8?B?WW1vSkNlNDVRVW5qcngyOEhQck1CdStJQnZPRG42OXNNWnZabjJrMnoyYmxk?=
 =?utf-8?B?SDlaT0VRV1NyeURubzAyR2dZZ0t4SjhGSVhsTzVrQ3FvcHJLa25yY3NnRTI0?=
 =?utf-8?B?Ni9ZdU1IbnlLWndFS3BvNTMyT0ZBbDBoN1p0RGt1THdUelhPMWlLTC9LWGxB?=
 =?utf-8?B?YUtvYnFnUmxGcndZZDQ2a0hFUWg3SHRFaERFSkNFcG5IUHFZemc3NVphc0dK?=
 =?utf-8?B?bHZaV3B0bVNua2FNekxTL3IwbW90OTlKOFp4bnNZaUdZcXBpaWdVcnRrQlha?=
 =?utf-8?B?ejJ2cTdrcE1BQlhNdGtBN0xDL1JrdWQ1TFBaTFlwYW9nSTUxMUdDQ2N5Q3Yx?=
 =?utf-8?B?SUt1Vm83MkhsMWhiYVd3akUxSHJZakpYL3R2YlY0L2tLaEZ6bmVrSGtNaFdN?=
 =?utf-8?Q?sdRZkJUJUcbbKGV1wxuQ5BAb5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad261d7d-b247-4903-0be2-08dcc2b3845e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 14:05:45.7263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i2Wbxo+nE2q8QqgvRFLJw7B1RvZFBw7oGnMePMVgTecoloU6QYRKg3E0skCLYli2KGxvuJDjHl97IUAwWiYKiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8824

On 7/23/2024 04:42, Lu Yao wrote:
> [Why]
> When running kdump test on a machine with R7340 card, a hang is caused due
> to the failure of 'amdgpu_device_ip_init()', error message as follows:
> 
>    '[drm:amdgpu_device_ip_init [amdgpu]] *ERROR* hw_init of IP block <si_dpm> failed -22'
>    '[drm:uvd_v3_1_hw_init [amdgpu]] *ERROR* amdgpu: UVD Firmware validate fail (-22).'
>    '[drm:amdgpu_device_ip_init [amdgpu]] *ERROR* hw_init of IP block <uvd_v3_1> failed -22'
>    'amdgpu 0000:01:00.0: amdgpu: amdgpu_device_ip_init failed'
>    'amdgpu 0000:01:00.0: amdgpu: Fatal error during GPU init'
> 
> This is because the caputrue kernel does not power off when it starts,

Presumably you mean:
s/caputrue/capture/

> cause hardware status does not reset.
> 
> [How]
> Add 'is_kdump_kernel()' judgment.
> For 'si_dpm' block, use disable and then enable.
> For 'uvd_v3_1' block, skip loading during the initialization phase.
> 
> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> ---
> During test, I first modified the 'amdgpu_device_ip_hw_init_phase*', make
> it does not end directly when a block hw_init failed.
> 
> After analysis, 'si_dpm' block failed at 'si_dpm_enable()->
> amdgpu_si_is_smc_running()', calling 'si_dpm_disable()' before can resolve.
> 'uvd_v3_1' block failed at 'uvd_v3_1_hw_init()->uvd_v3_1_fw_validate()',
> read mmUVD_FW_STATUS value is 0x27220102, I didn't find out why. But for
> caputrue kernel, UVD is not required. Therefore, don't added this block.

Hmm, a few thoughs.

1) Although you used this for the R7340, these concepts you're 
identifying probably make sense on most AMD GPUs.  SUch checks might be 
better to uplevel to earlier in IP discovery code.

2) I'd actually argue we don't want to have the kdump capture kernel do 
ANY hardware init.  You're going to lose hardware state which "could" be 
valuable information for debugging a problem that caused a panic.

That being said, I'm not really sure what framebuffer can drive the 
display across a kexec if you don't load amdgpu.  What actually happens 
if you blacklist amdgpu in the capture kernel?

What happens with your patch in place?

At least for me I'd like to see a kernel log from both cases.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
>   drivers/gpu/drm/amd/amdgpu/si.c            | 6 ++++--
>   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 6 ++++++
>   3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 137a88b8de45..52ebc24561c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -50,6 +50,7 @@
>   #include <linux/hashtable.h>
>   #include <linux/dma-fence.h>
>   #include <linux/pci.h>
> +#include <linux/crash_dump.h>
>   
>   #include <drm/ttm/ttm_bo.h>
>   #include <drm/ttm/ttm_placement.h>
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
> index 85235470e872..fc0daed1b829 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -2739,7 +2739,8 @@ int si_set_ip_blocks(struct amdgpu_device *adev)
>   #endif
>   		else
>   			amdgpu_device_ip_block_add(adev, &dce_v6_0_ip_block);
> -		amdgpu_device_ip_block_add(adev, &uvd_v3_1_ip_block);
> +		if (!is_kdump_kernel())
> +			amdgpu_device_ip_block_add(adev, &uvd_v3_1_ip_block);
>   		/* amdgpu_device_ip_block_add(adev, &vce_v1_0_ip_block); */
>   		break;
>   	case CHIP_OLAND:
> @@ -2757,7 +2758,8 @@ int si_set_ip_blocks(struct amdgpu_device *adev)
>   #endif
>   		else
>   			amdgpu_device_ip_block_add(adev, &dce_v6_4_ip_block);
> -		amdgpu_device_ip_block_add(adev, &uvd_v3_1_ip_block);
> +		if (!is_kdump_kernel())
> +			amdgpu_device_ip_block_add(adev, &uvd_v3_1_ip_block);
>   		/* amdgpu_device_ip_block_add(adev, &vce_v1_0_ip_block); */
>   		break;
>   	case CHIP_HAINAN:
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> index a1baa13ab2c2..8700a22ba809 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -1848,6 +1848,7 @@ static int si_calculate_sclk_params(struct amdgpu_device *adev,
>   static void si_thermal_start_smc_fan_control(struct amdgpu_device *adev);
>   static void si_fan_ctrl_set_default_mode(struct amdgpu_device *adev);
>   static void si_dpm_set_irq_funcs(struct amdgpu_device *adev);
> +static void si_dpm_disable(struct amdgpu_device *adev);
>   
>   static struct si_power_info *si_get_pi(struct amdgpu_device *adev)
>   {
> @@ -6811,6 +6812,11 @@ static int si_dpm_enable(struct amdgpu_device *adev)
>   	struct amdgpu_ps *boot_ps = adev->pm.dpm.boot_ps;
>   	int ret;
>   
> +	if (is_kdump_kernel()) {
> +		si_dpm_disable(adev);
> +		udelay(50);
> +	}
> +
>   	if (amdgpu_si_is_smc_running(adev))
>   		return -EINVAL;
>   	if (pi->voltage_control || si_pi->voltage_control_svi2)


