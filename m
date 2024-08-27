Return-Path: <linux-kernel+bounces-303939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2B7961726
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 20:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD28E1C23386
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4421D2F56;
	Tue, 27 Aug 2024 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hDpTDhBQ"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90EE84D34;
	Tue, 27 Aug 2024 18:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724784250; cv=fail; b=mvNvA1A3vWSViSGPm13b+8v6PHlDhRCptZ4qWunefEredSRLWXkxbr+EQ76FkqNUDfqMWWcmwLE9jsQqCksCkVnmXgm13/vHbTloj9oYlkzAiQBy8a1eUQNqBj06K2K2EiS4Vcdzbk7ItLG/1BZ2PnT4fQStbYDomHv6tAEJun8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724784250; c=relaxed/simple;
	bh=BFFqPaQ7ceyUtkvVl2tVjOcnDKcKUSkzBulEnModhqY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=blcC+6XWt74u9H23/zVyZcNRHaYQNitq2MgXaG57X4jvst0OZQOSgcBO9ESa9KBS7oOehn9v8vPe3u+UCqSUncXCwqh7m29Zmd0x4l8PaqKvV/G5ljNRu8BAS7x+ztaLVoRxkXwVVFMrT9/e5RKQaYxAbFhu72+T+IeaqdeQfDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hDpTDhBQ; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAYzmwCJkCbCHbZrPtdDKHXgfF1nVoEYFydC2e6mJk9QGP6cPzbw12HFxWOLgTSuythh7drLpxDCW5O0KRWH5A2DembVormvycpRQxUHSUiXGZ3MfQAOPCvRGacvD8NOAhXFg1IlvkYLFFpVVWNOUkD3krZcOwKT9Yr1QSIwsXIUBLmAK14UhEvI6xcw4ovfDXAy/OJB4BB5vcAtIqDU2CzddtCAaWzFvKdWYivYZJgodTDjjmPmjE7997dRNOgfo2Y/yC2TQxlZZu0NbJ3VURAzL1Bl6NM00JMPAvJFTlEe8O5qtuNt/UzA+g6CfV2Q9IHNppRESvfUpvmSv8HBzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3pQde6kn9895AbqI7Od0nwau2f0mzy3AyC5PZwNisg=;
 b=ucFWo1ugeYQ5FWlsqE5BZIQQkCG/uxVTjOdnZwJ4Vr1Z4Wu7jYX72DidU/BY9rSKoulawEO65POWpbDIzFGFZSFlq/sd73L3zZMZ7ixKK2jl/RmE5Wyput9Qp2Jvk/uyusySSU3D6skNicfG1APvVgy6i9r6q5J1QMAu1aHbIpUylO+aY6zctKO4UzNcyBGIenIxYVgaEkyqIKiip2c8WbUqNGpsk3adk9144IicCBgGGoghi1kHAawk+YP0+PE69PI7zNcii1fuK+YKjXjn3oxJsYqJykBgYgjrtc+jnMk1/A4FxInzt81FdoL6kVt7Sm1eTCi6xMW8uYOjvCxh2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3pQde6kn9895AbqI7Od0nwau2f0mzy3AyC5PZwNisg=;
 b=hDpTDhBQiKmcvbEUTZEcVU+qQtqQcPshw+ElfUMS38nuj/+3oZY1z4XH1J/XDA3P2N6vKr7p2A7XJvQhpgQSNhGEFpE58FjBDDsFCbBJOFbtynDyAOfUNBij9s8naRpHBcxmHhiyEF7S3nFoTwoo7NoAbINMxdSKn4GG7DGFQPY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA0PR12MB7073.namprd12.prod.outlook.com (2603:10b6:806:2d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 27 Aug
 2024 18:44:05 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Tue, 27 Aug 2024
 18:44:05 +0000
Message-ID: <4db33660-2720-471d-a017-1fca4c9b7268@amd.com>
Date: Tue, 27 Aug 2024 13:44:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] xhci: pci: Put XHCI controllers into D3hot at
 shutdown
To: Peter Chen <peter.chen@kernel.org>, superm1@kernel.org
Cc: Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, mika.westerberg@linux.intel.com
References: <20240712185418.937087-1-superm1@kernel.org>
 <20240712185418.937087-3-superm1@kernel.org>
 <20240827063206.GA879539@nchen-desktop>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240827063206.GA879539@nchen-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0183.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA0PR12MB7073:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dfdfb55-3472-4e2d-e468-08dcc6c83a1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azRYaCt2aVRIZHI3UzlmelUvR0FpZksyNGMvU2o4R2l2VWZXTE5lMWNtb2Uv?=
 =?utf-8?B?bytiUXNXR1cwSUlEQ3BycHk0RE1OU00wbW1hblNFYkhGRzRPeTQ4UVJyM3I4?=
 =?utf-8?B?U3RSSXJyWkZId3VOaEVhcmZGTWlWSlIzWkU0YTRtVmdUVkJPdEFNTnJuSjho?=
 =?utf-8?B?TmhaVUYraGpyd2ZCQ2YwSlVlam9sVkREWVdkcHU4aE80N3FHRVNoMEs3R25v?=
 =?utf-8?B?azJDalJsdnhveDJyWE9veTNCSDNPOWltc1dsMitSZTZGYStZeVcwYzVocXNK?=
 =?utf-8?B?VWp3amxBd3daTkV1eWpNWFFONExFQjV1bkFpM3hES2U3dHpDSGhteVN5K1ha?=
 =?utf-8?B?aisyY1FoT09ybjlZbWZDTXM1aGpMWjVub2VNN3NJRVFFazN3V2ZtVGZrY0Jw?=
 =?utf-8?B?RzBxRStYSHlBa2VYSzhmR1dUVHQ0SjRzaXZER2x0eDZRTGQ4cEJSTHA4RFJM?=
 =?utf-8?B?NGJvTjJxaXd5QWdtY0VkekZ6Qi85enBVM1NzNVBrWXNHMXBXNmoyNVpCR3kx?=
 =?utf-8?B?N1A0d3BXNUhCVXh5Mk54QTg3RERXd3IzM3kzb0lCRTRONEVhOUc3VHF6c1FI?=
 =?utf-8?B?RXdGcVEvZTBWejlSOW9yMWFYV1ByaEVuc09vc3R3bXY1RVZwTE5oQWYwbEF3?=
 =?utf-8?B?bUllVlN0c1cvcjNRVW4zRnQ2U0syU1A2dlJQb3JaZmFRdHVnUnFDbmZpb0pk?=
 =?utf-8?B?bWMwd0FTN0NtQTVOeHgzTUwya1N2bXlOK1dZc1VaVXdHWFdzZTAyVWZtUENq?=
 =?utf-8?B?QXYvNkRaOFNwTm1NbEg3QVV1ZVNEVUR6eXJkVVpJQXluRlpTVW1SQ2JPTEpp?=
 =?utf-8?B?VTRDenpKNmM1OGJzdzJmMElkN2hHdGhsK3RVcU5lRGVaZnhIMUNha05VRnhm?=
 =?utf-8?B?ZHNMcEdadk9pMWxORGpmOU5ZYXl0REZLcnA5Mlo1Yk9NUjBtZnA0UlhwU1RZ?=
 =?utf-8?B?UFRzR3RPTndCMXNWc2gyaWcwUENtWHF6M1F5Smw5RjVNNFE4dldHdy9NNnQ5?=
 =?utf-8?B?SDlHRlUyY1JLd3NZdEZuakpnbE1OV1ZGVFBrYk5XbVArRGh3TkJqK0w3SFBt?=
 =?utf-8?B?WCszaEt3cHdHdGhTTncxQy9UK2gyOWNaZWxHVlhhbTBKNDN1Vk9yb2pOTDAv?=
 =?utf-8?B?VjY2RE15bEZiU1J4MHFaTkRCSFpxei9HdG1CQWdvK1Z5cDh3bUhWR3hCcjMx?=
 =?utf-8?B?L1RZT213WER2cEdkVkdQaCtRd1hiK3FySDFnV1VzdFBsWTVFMFhNY28wRlJ4?=
 =?utf-8?B?NkRQcWhhWFVnUS8wRXNtZC93UGplQUpVaVo2eEtMenhkOUlWWHZBbnBsSmNy?=
 =?utf-8?B?aDY3ZW1EZmFPN0FGTURhTWxpd3c2QTYzb1ppUzlpRkY2MG5qVk02U2kwNGRU?=
 =?utf-8?B?aXhXU20zT25nYURvUGR2amdMa1RqcGZzcXBtUU5XV2N4TXFSU01IclhXTm9L?=
 =?utf-8?B?QXM2NkoxNE9qMVlhM3RqQWNFUGwrZWZ6WDBlM3NXQmdkK3hPb25pVU5obWto?=
 =?utf-8?B?WElFRGtDM3FBalpLQkt3R2xlbE44dXhBclNtbXYxVklXZ29DQnhmWThoRWNj?=
 =?utf-8?B?a2xWaXE2QllSaGpkc2VwN3JSckVlS2hqVm95NmhlRGpKYVY4MkVOWXBJc3FR?=
 =?utf-8?B?QSsrazJuSkJodkFaM0Zack0wZk5ZUzNsb1VvblNNN2g1SUE1dno1Y0o0ZDJh?=
 =?utf-8?B?TFV5STRiTW9hNXhab3lUdDNGck4ydlFDc3dubTVvQnA5SklVQkd3bU85Z1Nq?=
 =?utf-8?B?WUlpTjVTK29FR2ZkLzNHRGhrYUdhZEhTRWtkUDl0bGNkYm9wQ3RmaHlUUTd6?=
 =?utf-8?B?VE9Gbm5mSE55NHZZL3dEQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QW50Q0ZlaDR0MGEyUVozOEFMbC9VcDBlNCtSLys2OVFYa0xQVnNMQ1o1dXVh?=
 =?utf-8?B?R05GT0lGWVA2a2VCUEJnZ1EzTjU1UUxvcmtOWi93V3o2dTArTzhxYS9FWGhP?=
 =?utf-8?B?OXFBaWMwMUJlTEt2ZjZEYzFEYW44U3NZTzNYTVZoSVNIbnNNOFRhWlh0d2RK?=
 =?utf-8?B?cDJNTEQ3WjZsa0ExZk44bWthWEd4bXIzSHlJamhNZUNWT0Npd3BPWEVrNXZh?=
 =?utf-8?B?VzVDbVc2WkYrZEltSDNFMGhUTGVzYktBZ3NMNitjUDZGK2VvSllMNnQ1QXJY?=
 =?utf-8?B?K0h4bDJlbmRxVDlKdWhKT2tuZ3JmZ09rR1ZBTHgyN0l3V1o2ZnJocDI4SkNL?=
 =?utf-8?B?Zk1JWWNEQXZweFdFbjZsR1JFVHJjSWx5U0ttckhxRnFVRFdHcjhMbU12YUlC?=
 =?utf-8?B?OU5lMlpyR3Jsc3h6WmhPNlhNL0N2VWZwenUvK05Ib3pjVUhFWVNTdldBSVY3?=
 =?utf-8?B?bmVMZ3dOVHlhUndaUDBKV2YvRFN0MGdSV0hJZ3RuQWhRcllvYW56VThsMHQ4?=
 =?utf-8?B?Y2tTS215OVI1VEd5eG5aYnIyWkUyV3JqWjV1MmpHMm9Vdjg1NS9CbGd3ZEhZ?=
 =?utf-8?B?dEh4eXRUSE4vVDFPVkw3bERaS2RRU0t3aWZmVjFvZGJ4L0wxWHVpMGJXMXRn?=
 =?utf-8?B?TlM3cFgrM2R0TnNSYTFVSkhnTEtEL3ZBWmRiMlZ6MG9PNWRPeHhxSjFNeE9i?=
 =?utf-8?B?WDFZQWx0Ry8vLzFhODRtKyt3TVpRR0lsSXBkM3FPTHdIell5b3prbDF4S3JR?=
 =?utf-8?B?cTg2MjFraGtuM050cms0ajRsclJ2SkhjMzBscHViWkFQekxyUytSaTZWbzR3?=
 =?utf-8?B?b25nTGt5NnNFWms1dHVBeFBRQlc2d0NIb2xjQWVHTm5GRTZGZlJMeWsvcG94?=
 =?utf-8?B?YVdUSjZOQTRZVkoxa2hSbElEdmF1MWYzZTlCdU9mUWxMTEtmZEhIdG1MNWQ0?=
 =?utf-8?B?aGxsV2xRTkhzYTNRVjZ5V2dYRnNXVlB1b21uTU5YUFFEWmoyeTYzdmdaUXBI?=
 =?utf-8?B?SHRzOTladSt5bFZQNDIwcU5UVGVjcllxWi85VzUvZW12L0Y0dTYrbS85Y2pj?=
 =?utf-8?B?MVloNS96OWZra3dXeEEyQWRzeGV1aXU5RGt2RnErb0w2TGxtVFE0RVM3ek5C?=
 =?utf-8?B?K1FuMFFvNlc2aFUrbGthRXRqQ1MvcjQ5Qy95ejFmNE5zNTFkYzZsbER3Q3Jt?=
 =?utf-8?B?SmFSaUtnTFZKL1g4NldnUHN0SGdOSEhpZmdGSHZ6QjRnbUhHOGVqN0cyU0RH?=
 =?utf-8?B?OFpFTTVsVnBKV3JWL3RqNDE5WWhjcnVoM3hFbThxdDRNazEvTXBHbTdMT2lN?=
 =?utf-8?B?WWJNMkxQeU1kc3J4MzlmYzYveHNaVmVTYkhSRjB6WmxpckJUdkRMenJjaUs2?=
 =?utf-8?B?M3ZPK0VnOU4vc2hkYytLTk1UMFA2Q3Foa3ZsM3V4dDErQk50dVIrYTNxYWZS?=
 =?utf-8?B?emZnZGxlVzkvN2VHWkhhcEVsTWpCM3VKcjV3QTkwSTlpdDlWU2FuYkVvM0Rm?=
 =?utf-8?B?UEdCdWhvc2xldjZ1VTVIVlJLSzN2L2VVUmhaZ2VHMkc5S0R4SzR2QTMwT2NV?=
 =?utf-8?B?ZnZhUmdBU1JHYmwzL0ZWWWpXQ2JzeUJPSDJKK0ZzN1FhdXRZZFpEOVZSNUF5?=
 =?utf-8?B?bmpTTTJyVzkwTlFEcEE5ZzB5R3IxTnpVWlVhaEVVRzdLNFdpYlRtSFVyUFg4?=
 =?utf-8?B?RzFpWXlCVmcvMmJIWGkzWjF1T1owczZHdEQya05rN1R2SzdBbXVHRVB2MFhR?=
 =?utf-8?B?MDlJZXZmWkw3dzhTTXM2WkRwdytZSjhvL3hkeU9PTE1lalFvaThWYVJDd0tX?=
 =?utf-8?B?Mnd0RkorTnQ5RTRyNGoxRTlMUkFHZERSRFdPZFpyamwzQmh1MTA3djZkaGFP?=
 =?utf-8?B?WldRT3RvZkltZEFVbi81cFhsc1dDNjFHcWE4QmRUS1pCbFF1amppYWpxT2hh?=
 =?utf-8?B?eVVOcEFzb29pQ0JKTFVPUElGdER2eTlYY0pjenRLRDZYSUY0cGl2SEVhWXcx?=
 =?utf-8?B?NVZ4ZzlDT0VsM1VZQW5pdnJqc0dic0xnUXo3KzZGT2NPUlBwUzkxZXBqcUdP?=
 =?utf-8?B?ZlQ3MjRZK1BBTkF6bzFFVDUxZHdxUTk1U3BNRTYrNkIyVWZOYTJPbUVZbzBQ?=
 =?utf-8?Q?5EoTacD7ZVbuy8j8NNfw4quC/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfdfb55-3472-4e2d-e468-08dcc6c83a1d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 18:44:05.3470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hu0OTXUOYdJNTQizZh0h5Vno8WZNeKmfw5hWMiSmsBvJe6lxwLfvo/efIv/DPuMuI3qMMUog+YTisY8ADVjPxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7073

On 8/27/2024 01:32, Peter Chen wrote:
> On 24-07-12 13:54:18, superm1@kernel.org wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> A workaround was put in place for Haswell systems with spurious events
>> to put XHCI controllers into D3hot at shutdown.  This solution actually
>> makes sense for all XHCI controllers though because XHCI controllers
>> left in D0 by the OS may remain in D0 when the SoC goes into S5.
>>
>> Explicitly put all XHCI controllers into D3hot at shutdown and when
>> module is unloaded.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/usb/host/xhci-pci.c | 8 ++------
>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
>> index 4408d4caf66d2..dde5e4a210719 100644
>> --- a/drivers/usb/host/xhci-pci.c
>> +++ b/drivers/usb/host/xhci-pci.c
>> @@ -667,9 +667,7 @@ static void xhci_pci_remove(struct pci_dev *dev)
>>   		xhci->shared_hcd = NULL;
>>   	}
>>   
>> -	/* Workaround for spurious wakeups at shutdown with HSW */
>> -	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
>> -		pci_set_power_state(dev, PCI_D3hot);
>> +	pci_set_power_state(dev, PCI_D3hot);
>>   
>>   	usb_hcd_pci_remove(dev);
>>   }
>> @@ -882,9 +880,7 @@ static void xhci_pci_shutdown(struct usb_hcd *hcd)
>>   	xhci_shutdown(hcd);
>>   	xhci_cleanup_msix(xhci);
>>   
>> -	/* Yet another workaround for spurious wakeups at shutdown with HSW */
>> -	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
>> -		pci_set_power_state(pdev, PCI_D3hot);
>> +	pci_set_power_state(pdev, PCI_D3hot);
> 
> Hi Mario & Mathias,
> 
> According to xHCI spec v1.2: A.1.2 Power State Definitions:
> 
> 	Software shall place each downstream USB port with power
> 	enabled into the Suspend or Disabled state before it
> 	attempts to move the xHC out of the D0 power state.
> 
> But I have not found any USB core code does it, do you have any ideas
> about it?
> 
> We have added the similar codes at non-PCI USB platform, but met above
> concerns. In fact, we met kernel dump that the thread usb-storage try
> to access the port status when the platform xHCI code has already put
> the controller to D3.
> 
> Best regards,
> Peter
> 
> 

This is pretty tangential to my patch.  But FWIW in case you missed 
we're going to discard this patch in favor of another approach in PCI core.

Regarding your point though If I'm not mistaken this should be handled 
by the Linux parent/child device model.  Each of the ports should be 
children of the hub they're connected to and the hub a child of the 
controller.  So when doing any actions that start runtime PM on the host 
controller the children need to first be in runtime PM.


