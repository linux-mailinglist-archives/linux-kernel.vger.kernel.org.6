Return-Path: <linux-kernel+bounces-199008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018A38D807B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2437F1C212EB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3A47E0FC;
	Mon,  3 Jun 2024 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PLRtNXdv"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF33C78C80
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717412511; cv=fail; b=U/iRtI/+sWlkFfPc72IleeXi0BmQm6XpekRMP2FW//et4lSTfW8YIzomkSigumndULHQG8SucJkKGlpxPMIkJatyJW/1Gj3JR/KN6cpIZss0xJtnaql6dbRZNLHtWDycf2lxLwASQMcE8vCtm0dBTkoNE7jAlRpA4olsF4rboEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717412511; c=relaxed/simple;
	bh=8Stmg+xvgNnOwzYJsgFY0EJeIgCgqQnZDR+ih4z4H9o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PlI5VMz4pqcefmTvXBjfpHTnhGIuCHEVetW+NZGIWsc+mNq2/R6RiP0csEGJKwzPqTB/csUm9Y71ItOECP3AWwTdKEC8zufILKvEae7aw09FwMLtZu3Bd32xoynGmOXF90REjjdjvzVaOdL/BXM6Y9Tryct/0+3BTYM2DgeFIjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PLRtNXdv; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKccJa0iTLt4UseOnygDNtYi1OV1NAGfEpO9xyBVc5Z5s1lEeRJMBx0nZMlUUC1uEtPp7F107g5SeXjFuDFwuc/mCK4AmrrpQsxRrzciQQlo+D1e04H1s4s2xYymFd+OSZTPA08z/NZWcfU2uBEUzziiV/+oW2n1u9GJItENRcXM1uApfZd48m9eX5Su/aMktXPIe47Tl/+MYgVYquwLO2lJu7Usi5R9lsuSduJTIv6akX7BgrVjSCj2+9b0gDby8dtwbLzjLLv1y5Nx33LEcH4EC1JIVxJBDtFJ8mdJpxEcgX/sACNIn665eJg3iOKyluiTiODDPVvkRYPnGSycsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Kqskcfj6Ijcd4aROFeswPwurkHLBJhnrjMzrZ8Dbo8=;
 b=lIirXOuUXEsWc7cTssoGT79Pn2ZpnLT7k7LnUDeXvcBVxCDb1lUfy2j6VmxHH7PBkrZnoBCTQM6pGSDelqblrS9RMrLScK0jHSX63KuoYyI4zZcVCsMPM7X1d+CWcL4Qo0kDUOE+cCQqjMUoG9i00tK1yDcCUSmQBUTcrkV0xNskgbeazBMDPZJsqvFLXuZ1rVkPEb2Ns7LAjiML5IJb14SVAs2sxfIVr7ay5NEm0ip92NXSkdYHFTrs5/JOpDor7vYfrASwf3eBxCAiydfaJNfjoZ92bXML+GilZc4s5Of3HeBSmt99TuWa6R9zjSLfJH2KMOBgdH4sVfvOxblmgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Kqskcfj6Ijcd4aROFeswPwurkHLBJhnrjMzrZ8Dbo8=;
 b=PLRtNXdvgj566EHH0ArOOfnhWrRPaNwF92ER13art6K+TLpWfCB9pkEJ60RRFvQ+D+zYe+ytTFnzLENUUe/GQcden3x330ZUiu8xdXTcNam9PAKI17bR379huGmhMmHDEbkOAu9zffRv0jcmdQeqw1Ti7eCM6SuxojwCsRLur6g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV2PR12MB5774.namprd12.prod.outlook.com (2603:10b6:408:17a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Mon, 3 Jun
 2024 11:01:47 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.7611.016; Mon, 3 Jun 2024
 11:01:46 +0000
Message-ID: <1b1efb67-1cf5-458b-a37a-835c7d89b03a@amd.com>
Date: Mon, 3 Jun 2024 13:01:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: xilinx: rename cpu_number1 to dummy_cpu_number
To: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240408110610.15676-1-jay.buddhabhatti@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240408110610.15676-1-jay.buddhabhatti@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0051.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::10) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV2PR12MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: d117198d-1ac3-4ec7-c21a-08dc83bc8fa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dU10cStudUlMZnJpSTBxbEhnTGhmNW9ETTNjNDhsVzl4RnRNYkdoYk84TktL?=
 =?utf-8?B?aWl3NlgrMnpITVJHZlF5eFdrTVlrdzNLdXF1TXlzQTN0LzlIcFNvbVg0VVJH?=
 =?utf-8?B?U3hNNHB4U0VnWUVVQjZoa2JuOEo1bDQ5czUwdTIzWExDRjR5OVhJQkQweUJv?=
 =?utf-8?B?bThGNmpVb3VSV2lUVEFRSWhPRStFSDgzZ2VJb2lJU3RIdmRvbk1ZRTVkYzZr?=
 =?utf-8?B?RG1saTR6YU16RS9xMU9Ba29ERldNL1o3K2dzSjNTK3R1eUlmc3hOaGFYb1lO?=
 =?utf-8?B?bDNQMXZLR2pvL0VXcmJndmE4Q1hQSFoveWdoN2paWFJwNVBOSGl1anNwRTBC?=
 =?utf-8?B?NUVhN3FOeXlVcnhxM3FMVHBWRmRLTTNtdlhhQS80M2lQWTREaEtoZVdUUGtm?=
 =?utf-8?B?QXI5OFhvR2NESXhIUGJuZndTYTI2aVpOVlhkNm5ZVEt1bE85Rm9kR2o4Zjhq?=
 =?utf-8?B?RFpWd0R3RG1DS1Y1dU5zZjRCdmI3cG1HNFhVb1BiclRpamU3Z1VFcWNRd3pN?=
 =?utf-8?B?QzMzVVAyV2NEci95S3VoYStlZVlPSjRkeUdteVNha3grTnIyWHdtbUJKSUV2?=
 =?utf-8?B?RkxUZDZpMmdub1BwTWsxSlVuLzczNFNFaDVkeDA0SmZtWjVZVURMR0g2bXpM?=
 =?utf-8?B?Vmowd3prTTNYRGxLVVJZMXprZ211U3EzSVpEcWtJNndQN2pyeUU3Zi9lSHpH?=
 =?utf-8?B?RmVEZDFKZGc5a0J4c29VZ3VFdTA5dlU4aWN2ODFrREo3K21XZjIxSDcwZktY?=
 =?utf-8?B?RHlYUDJyU2ZXS3lCMGJoNy9DNmlzcWEzdldYWktuK2VjM3lQZzJkTXpIUFNR?=
 =?utf-8?B?akVLOFdMSWs5SFZrZmJTQzBhbTNpZDlBMUl2Zmgra3pVNWFPcE9DdXV0M0F2?=
 =?utf-8?B?QitzZzNQWEttRHJmMTM3cE94WHFHYjZlemlvSVFPV0hFVHFWUGZzRzhVOUht?=
 =?utf-8?B?cndNRkwxYU9QUjlqVUl5QldVR2FFaTRPaEJiRDdXTHk3N1hwREs1QXQ5d0tp?=
 =?utf-8?B?MEt3QnIwaVBYUG5TNHlTcEdoWjFTa2tMZHh2VTlXUFBpSzJwQ0o4L3p2RU0z?=
 =?utf-8?B?Z1VWS0xrWE9PZkdoMVJUaDMzdXV5NGcrQkVyOWJNUGs3STVtRDlBVmN2bXRu?=
 =?utf-8?B?TUF5Vi9NaDVnT2RnR3JtdFc5QUlnbEMwWU56WENhZHYwNUtKMVY1ekNxQmJV?=
 =?utf-8?B?M0Y3Z1ZFRW1YSHNlNHdta25HRmZkdjN2TlFoN0FvTUF5c0RRY3gwUmcrY3Qr?=
 =?utf-8?B?OFB2VnNzdFFaUXIxQ1JDYjY0UEhxZXJSZ3g1VlBleUYvUk5wTEdKV05oUGdZ?=
 =?utf-8?B?bEE4UzVBMUtzZjVaSUx5bFlvSkE3MFFSR2t4NGRLRklMTEs1S1hFZTFJeTBm?=
 =?utf-8?B?amp1NTFLV3pPT1BGQ3BnOVZIRXJGUFJrN1F2cFF6ZzJxbFRKbDd6RnZRWFVw?=
 =?utf-8?B?b0hvMlZ2cEt4TENNSW5FNVhCNTd3QmplVENsbjhiUWwrYXVPTTBzbHJZWExk?=
 =?utf-8?B?RlpGQnFNOTlEaU9sWkJFS3NhNGR4RldudVVMWHVqblFmYTZOSDh4Q2ZQbG5F?=
 =?utf-8?B?amxleDg1dzBPWVdMVFo3QmFVVUptcmptdDJiQWZ6MkRuK1h6Zk9HcDlyQjRo?=
 =?utf-8?B?OTlJeUxMdEJadkZ3QjljNktzNjJhOTNMRDMwdGlCczIrdW9xM2pqN0NaZ1JM?=
 =?utf-8?B?SlhtRnl6aWxhVC85L2FQcEU1RzdvQWlVZUZrNm9iSjQ4dDdHVzhoK2tnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkxCSmVhMVk2OGNuaG1FNDNBclk5SnJCdFVjRXE0ZmFlRmFocXRvYXlMVnpa?=
 =?utf-8?B?Y3ZQcTkrcnVQa3hvWVl3ckRaWDREQlNNbndFT0dnR2kxZEw2S2hkckZJdDNC?=
 =?utf-8?B?c3hXUkdZUDlKdW03UEtjZ1VXdncxTENLZ2lLUGIzQ1R4cUthMEhOTnhhU2oy?=
 =?utf-8?B?ZmVONUdmWFpLekFhRnMwTEsvZkx2R01aYmlzUjIwSDZoUklmTUlMYTVOUHdl?=
 =?utf-8?B?emtrKzNWVVNkNVdCVmM5SVFIbWNoNzJwTDhKTHVJOHZUbEkvQ2ViYkRKWnYw?=
 =?utf-8?B?NU44VGwvdXg0bXIxdEdtdGlVck94ZXRNbGN2YW5DRXlHdkpONlhlSEd0N0FQ?=
 =?utf-8?B?ZEU3aWtnRWJ6Q3MvdFNEdEhOcFkzOE1HOW5hajR5bE4wRnp6TURWYmlweUx5?=
 =?utf-8?B?cVlLbUZqM21tajBrL0g4bjNhd1dnc2dIWG1ReHpMT0FiL1RDOHdYaUNWTlBl?=
 =?utf-8?B?R2xKVWJkYnJ5NWZQa0RJN1BaWXJjZGQ0REpJeUtXWUhtZGR4aHpFczM1Qm1O?=
 =?utf-8?B?N3Rod1FMNE03WnpDVHJVbmQ2UHo2dFJDZHg3VUNZcjUxSjhHK0tFMy9QakhZ?=
 =?utf-8?B?MUZpOGYrUXJPeGxqeXJ2WlZRdjNQcWFuTVREOVJyWTJINjdwV29WRmx4YVJE?=
 =?utf-8?B?MzFkS1JUZWdRNGs0R2t4eGEvZWJSd2MzU2Vmd204L3NIa2RocnlyZDVqUG5n?=
 =?utf-8?B?WTlGaHBmNUI2ZHh4QWtpTVdlTjZ3MWx2a1BMY3dBNTdyQ1hSVkxKVlk2OGR0?=
 =?utf-8?B?MUZhR3ExY1RHZHNSWVBENGdpZVFSdGUwZy9XRGJlQ3pRL2pWZ2c0UVZKV080?=
 =?utf-8?B?VDFHV2JmSk9BY240MmxNRXN5eHpIb3F2RmRJbDFrV1JQYmV2bk5ra1ZRQ1NW?=
 =?utf-8?B?bWlzMTNCVURpN1lQbHBpMmZmUnJFcnpQbVR0eDl0MHhwOE5KSFJQbFppeXVa?=
 =?utf-8?B?MmpWT0srZXlQUlJVSlFUbWE2S24weXdDeGlVNzYybkRORWZvNlVWNWd0ekF1?=
 =?utf-8?B?WFZEWkN6U3JrbU5QZldpWXQxV1lKckF4RG5Kajd3ZEtKUGhIUG9lM25maUoz?=
 =?utf-8?B?dVB0akFveWhVVVB6R1Ywb2p1cmVDVU9JMFU2UnVXaVNxZnJ1WjB2a0d2Ymt2?=
 =?utf-8?B?YXR1L1Vnd3lsaG1JMTZvWlFRdC8rVWIzdmg5RXFXditYdzRTNnBLU1h5WWJu?=
 =?utf-8?B?eFFjVTBNbjcvcElNM2FMVVJZU0xNZWNwK2JWL21nNFkrRGRZeU5KbGNJMUlM?=
 =?utf-8?B?VmFxWjdpdVUzWitRTU1BY1grQTA3b3M1ejdQRElxampBcVJzd2xQdWxqdTBK?=
 =?utf-8?B?MTJFTjd3VVJDNjd1MmdRbW50STFKeWxNSEE2T3V0OVlaRHptQTkwSUdBVlpy?=
 =?utf-8?B?WHoxVFpYdWMwZktEeE55OVhZR3d2WjFGRzEzcFBVc1ZWM1dtVCtBd2VnSUtj?=
 =?utf-8?B?Q1BmK3FGSWVyQ3ZzNCtjSjhPWTVuYTNJcUxWRHNCTzlTTzN6ZzZkUGFWODlW?=
 =?utf-8?B?eTBlWVM4RVNMSW5vbEt3VHBqT3hxYlBsYjFVUEowS05qdWFuOVZWanF2UTFR?=
 =?utf-8?B?aWxTWHd5dnczSFZEaXJDOThpMXl0NEtBSXlidFl3TTVScW1UN3FzT3BSNXg5?=
 =?utf-8?B?Uk9YUEJFT2xONjYrUzl1YVZUUjR0R2s2Tit2aWhRVHVjM3BQdDd5VjdJekl5?=
 =?utf-8?B?THBjanRxZEJSM1o3bzNCQWpRVU5pUUJlYW9JdXRiaHp1M2dZcDlnU2RpZm1V?=
 =?utf-8?B?aStDRFo3MDdNbHFvNjRiRzNYYmUvcWdjVmtpd1laNGFZNzJHNld1UVFUcThW?=
 =?utf-8?B?cW5zdmtNUmp4STc0TUJ1eCtjWklCd1VXdmZhY1ZZbHk2ZGtnVmljMS9mS3Bj?=
 =?utf-8?B?dGVFZEVnTjNYa0loeVY1MENVc1NQYk13Mmp3ZWErNzd3UnZ2aHJOdGJNc0hn?=
 =?utf-8?B?em4xL0NJQW5ZM29FcVdOeEpwZUZjenRGQy9ERnBrTlZZODAzR054TzN4aUxx?=
 =?utf-8?B?cmsxNDR5Q0xjcW9RL1NTd1NTQSt6WlpoUnVEYXpvYXhhYXZweEtmd2NDeENv?=
 =?utf-8?B?RnBUL3U0NGZSK3JXZWVZZ2FtK0N2UUo2Q2RFb2drVzV0aTRRYzZkM0lXOFlX?=
 =?utf-8?Q?b9Y+v6vZjsgbQWb7G6ePZetc3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d117198d-1ac3-4ec7-c21a-08dc83bc8fa3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 11:01:46.9262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9wBJ0wm1q0R03obmROGDc7ThBq/lI+OccPJhqwSEm3gxIVlmeQlYu8nOot5fy1wA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5774



On 4/8/24 13:06, Jay Buddhabhatti wrote:
> The per cpu variable cpu_number1 is passed to xlnx_event_handler as
> argument "dev_id", but it is not used in this function. So drop the
> initialization of this variable and rename it to dummy_cpu_number.
> This patch is to fix the following call trace when the kernel option
> CONFIG_DEBUG_ATOMIC_SLEEP is enabled:
> 
> BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
>      in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
>      preempt_count: 1, expected: 0
>      CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.0 #53
>      Hardware name: Xilinx Versal vmk180 Eval board rev1.1 (QSPI) (DT)
>      Call trace:
>       dump_backtrace+0xd0/0xe0
>       show_stack+0x18/0x40
>       dump_stack_lvl+0x7c/0xa0
>       dump_stack+0x18/0x34
>       __might_resched+0x10c/0x140
>       __might_sleep+0x4c/0xa0
>       __kmem_cache_alloc_node+0xf4/0x168
>       kmalloc_trace+0x28/0x38
>       __request_percpu_irq+0x74/0x138
>       xlnx_event_manager_probe+0xf8/0x298
>       platform_probe+0x68/0xd8
> 
> Fixes: daed80ed0758 ("soc: xilinx: Fix for call trace due to the usage of smp_processor_id()")
> Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
> ---
>   drivers/soc/xilinx/xlnx_event_manager.c | 15 ++++-----------
>   1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
> index 253299e4214d..366018f6a0ee 100644
> --- a/drivers/soc/xilinx/xlnx_event_manager.c
> +++ b/drivers/soc/xilinx/xlnx_event_manager.c
> @@ -3,6 +3,7 @@
>    * Xilinx Event Management Driver
>    *
>    *  Copyright (C) 2021 Xilinx, Inc.
> + *  Copyright (C) 2024 Advanced Micro Devices, Inc.
>    *
>    *  Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
>    */
> @@ -19,7 +20,7 @@
>   #include <linux/platform_device.h>
>   #include <linux/slab.h>
>   
> -static DEFINE_PER_CPU_READ_MOSTLY(int, cpu_number1);
> +static DEFINE_PER_CPU_READ_MOSTLY(int, dummy_cpu_number);
>   
>   static int virq_sgi;
>   static int event_manager_availability = -EACCES;
> @@ -570,7 +571,6 @@ static void xlnx_disable_percpu_irq(void *data)
>   static int xlnx_event_init_sgi(struct platform_device *pdev)
>   {
>   	int ret = 0;
> -	int cpu;
>   	/*
>   	 * IRQ related structures are used for the following:
>   	 * for each SGI interrupt ensure its mapped by GIC IRQ domain
> @@ -607,11 +607,8 @@ static int xlnx_event_init_sgi(struct platform_device *pdev)
>   	sgi_fwspec.param[0] = sgi_num;
>   	virq_sgi = irq_create_fwspec_mapping(&sgi_fwspec);
>   
> -	cpu = get_cpu();
> -	per_cpu(cpu_number1, cpu) = cpu;
>   	ret = request_percpu_irq(virq_sgi, xlnx_event_handler, "xlnx_event_mgmt",
> -				 &cpu_number1);
> -	put_cpu();
> +				 &dummy_cpu_number);
>   
>   	WARN_ON(ret);
>   	if (ret) {
> @@ -627,16 +624,12 @@ static int xlnx_event_init_sgi(struct platform_device *pdev)
>   
>   static void xlnx_event_cleanup_sgi(struct platform_device *pdev)
>   {
> -	int cpu = smp_processor_id();
> -
> -	per_cpu(cpu_number1, cpu) = cpu;
> -
>   	cpuhp_remove_state(CPUHP_AP_ONLINE_DYN);
>   
>   	on_each_cpu(xlnx_disable_percpu_irq, NULL, 1);
>   
>   	irq_clear_status_flags(virq_sgi, IRQ_PER_CPU);
> -	free_percpu_irq(virq_sgi, &cpu_number1);
> +	free_percpu_irq(virq_sgi, &dummy_cpu_number);
>   	irq_dispose_mapping(virq_sgi);
>   }
>   


Applied.
M

