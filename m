Return-Path: <linux-kernel+bounces-574481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A722A6E5DE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E8403AEE37
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477351E5B86;
	Mon, 24 Mar 2025 21:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LBMcRpoi"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C50418B464
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742852644; cv=fail; b=JwWzGWQKlW+9TEcyOTO9vCa5mIELKF8dVpH3Otj+beOpqcmAN113wrZ3wmp2ptFraRsd6cJzSnNAntDdcdZrEa0C4Jh91z698DSsoeLr4olvHhlouhUIAIHzDTKFrv+0wmKspicWrVXKrxGHMocGTm/ys/gGH+iiGvQJLQlnAko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742852644; c=relaxed/simple;
	bh=lZUf3o/KZ+2TXlxiYhxQg4J/Csp9hieYvN+vZ0llYkU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eIP/Vg6C3QtpQnrLwHtj/XNdSY82r/ZdugkLCe1eCpMKIk6IWInSug+2AX2yoTe6ZP96ZwS1dbQh4CNHOwpzKBc56nPYrG5PGQZ9StsfsQzIMy8oX/05I9/xwJJ1ERuXMMvRvElPl2Vm59MIPRakGIIvmBrFRGaQX0GgOnNGOqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LBMcRpoi; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDJ1HuTm5CbvB86ReS6dLDvI/ZjveB3mKk1CZKk+iXCbEy+zcgwOTKTQwMWJ9KKf9st9TSYiNjYJkhMW5znTKJe/XYvKN2dP0OD3NVPIpmGESNDYdp/Seg03CnPiHpSHRjh3szTdAUwq6mY90ptLArEYLGrT38ME4FJJqzH28HXpb8QNfvbLpafsu4Z4Ya++fglV317InkacEAo2fvohF9xe2ozZWhY4sS/EEx97oz/YWpOTHHHDtxSoV8L1XlL+iPkodU+AUSfJ6TJAM0u2FavnzelNMH/U/TCVxLaKQ3KaMv2XJ7u+Q7Y/f8W/LfjDTxWGItNbu7Bl4tDT4wmuDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLGfDtsxd7FiZTafmDRZTsHtEEgQIlObyf195gBJJDI=;
 b=IxTyjXcz1Vm5C3n2i5rpUPEWAJ1RCxr5VSMKo6WOYIweA0jXBQTAyPuEEYMR1QbQ3T4vvetIVUqsdiy8ZkMItPqlhpqUxXqXwayZiOI1FtdCUAUULiY5Ff43kSZ8baO7HDQRELECvTJ2MgJCmFlX+/B32EX5hvJlpt8iFrZ9r1Hwg9jJDcZQtbg0O/79hnt4QuqPDLYIm4DThysZwdhT4UZeCDi9DtoT6TFOZe4oYH0Jj8875b2PwIBg+Fl2AZpX/3Jbs4cDYbL/Lw0+oIocG0L0ET0ec6Yw1Ph/WvS0fkJ5GxHLvhlxK9b+bbnLTfQ6f8bhnqYgKpso5ecTpsUaVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLGfDtsxd7FiZTafmDRZTsHtEEgQIlObyf195gBJJDI=;
 b=LBMcRpoik8YeGrXNbftPBAqc/D3tUO0Yo/tAW5DA6Sk2Vy1bpG94dcU7kJLM1PknvA8cy/kkkcP46Dqp/udQAWu/YI24Tu2u6SwK/5HnRER056MP/sYzvfVW/ybvz8zvormdtrBrruqXtvjMZKl2/rJlowvWIXq0X+O9KEYaqBdlFDbcNZ3JBXgb294GQObbKUy3+9S+i4ztbh6k028bnPoSR3MYeg2pogSkN4v2760Tnq5/6vqf57FFfviA3zPwDVD3g7GKUr8distSP+qFDEIguqCar2uvHE3apHXo2l4hiMsQw2qsdsoVpHUMCEuf5SI3B8Ppth3UbJIhl55i0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by CH2PR12MB4263.namprd12.prod.outlook.com (2603:10b6:610:a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 21:43:59 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%6]) with mapi id 15.20.8534.031; Mon, 24 Mar 2025
 21:43:59 +0000
Message-ID: <2eb17574-01e3-4608-a16e-56678781e32a@nvidia.com>
Date: Tue, 25 Mar 2025 08:43:54 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: commit 7ffb791423c7 breaks steam game
To: Bert Karwatzki <spasswolf@web.de>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
References: <20250322122351.3268-1-spasswolf@web.de>
 <688f2757-e364-45db-ad54-daa6ff1c4f3c@nvidia.com>
 <6e8ad3cd27b570aaefd85395810cc90bb3120734.camel@web.de>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <6e8ad3cd27b570aaefd85395810cc90bb3120734.camel@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0075.namprd05.prod.outlook.com
 (2603:10b6:a03:332::20) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|CH2PR12MB4263:EE_
X-MS-Office365-Filtering-Correlation-Id: 11bbe1fc-0aac-40ff-a67d-08dd6b1cfc40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dS9XNVNYNGtwcngwSHZFaklaMDRONnpHQ2NKL3dXQmJNU3QwamRBVERoNTlx?=
 =?utf-8?B?K3ZBSFRzSGhIQmxFZXdJcFFGL0JzTEJNdHNSMGlZQU0waWRMQk13KzFPeWtt?=
 =?utf-8?B?Z2d5V0t6bzRWaWQyVjBRU2pEazcwOEREa2YrOVpiajd0Mk53YTNhR3UyMnVM?=
 =?utf-8?B?SS9CZDN1MDJkNU1SK0hkemZ0ZHowWEVFdWd2SHkwRGFDckRPanNLVXVPcDBF?=
 =?utf-8?B?OVcvaUJtMmRlZkg5bE04ajNEb3BoNmpLZTY1WEc2UlhZSEZ4cFV6bHpiUHFF?=
 =?utf-8?B?SzVDcUY2RjBId1FLSGhDQklsbHBJSkRpWmdrOXk4VnVBaCtHNVhMNWtLaGpt?=
 =?utf-8?B?Z1ZjV0dGUGpVeTJmbEEyOC9GVFR1aXdZYysrUnNLUm1QdDBMcEJEeit5UUtQ?=
 =?utf-8?B?azBzcEg1WWZrUHY0YW11VkZ1K1JpamZ1MXU5VVhYandJMm1LcnphUHJDdWxh?=
 =?utf-8?B?MldtR2dLcG5ic3o5N3FtOG85bnNOQWNSekxjTHRkN2FFempyYzU3SEVNTC8z?=
 =?utf-8?B?UXhDcTl2UUswb3o2QUtDNWw2bGxoUkh2KzJEcW5VS0txV3htUnlxam9OU1FX?=
 =?utf-8?B?anEvWkZDWXdyQmRLdWpwYXoyTEUzNHJGZEhqUkRzTmdWOGRLeXQzay9qOGJu?=
 =?utf-8?B?a1dBYzM0M1p3ZFFPU21xN1Q1K3RtL0tja1o4elBBVG1WVnFrQnRxRmR0UWJu?=
 =?utf-8?B?SVhmaUVQaEtIMGpJUWhpdzdxLzYzTTd3STNEL3hyVlNvY1RINHF6YVZ5bm1y?=
 =?utf-8?B?SG9pN2F6Zm0vd3BDSWszcEl0SkhFeGhINStFK0FqUGxveS9CcnZwekF6bTcz?=
 =?utf-8?B?WDBMWXdESlpIWWV4VUpGbmFLSDZSTWYxQURRM1UzNHNsNm4zcmJOYnhQZnZv?=
 =?utf-8?B?M2cyR2wybWNodzR2YUxuQ25HK2p5UGlwYTJ6cUpJWGlsNTkzOUkyNGxQQWJi?=
 =?utf-8?B?TGw3M1pNbGxtbmcwWFJ6TURSVEJjWWxGem9zdlN1UEIrTWw5elgxWVRIUlpC?=
 =?utf-8?B?NmdMMEkvYkxRdFNCSUtOSDNwamZIK00yWW05QzBVbUFReU9ZVVFSYzlDWFY2?=
 =?utf-8?B?aElNMngxWktYQXY4M3FmUGpqM2QxcHk2Y1EyTWowbmhpY2V1YUJDS3NUVDZu?=
 =?utf-8?B?RHFyTnFvejlEM1VabE5LYlcxOGg3R1VaNkRzZnRvb0YySEdIWUsrNTRxZnNu?=
 =?utf-8?B?K053VzVDQU5sWFNZQzhyd1lLdmxmU1VnRWYwZ3NCTVBNSXRBODg3LzhWbDE2?=
 =?utf-8?B?OXR4cGRLZ2NjYjNjOHhiYnFSL0hYdkpNeGdTYXhXTkRNdzNRTFlRWjA1ckR0?=
 =?utf-8?B?N0hJdjN5aVFHOTh1NVNEencxN3ZINytETGRBVytqdUNVdHJiL3h6RWNvK3BR?=
 =?utf-8?B?MzV1em1BT1FtNHJGVVRyQUF6d2xNakVFRGdNSk9vdUE2ZFA2OVlsWjBXYi9S?=
 =?utf-8?B?UVJ0Q0VWcEtQR3FPN2IxTGFETzgveEhsVVI1UHhLbU1xb2pkZE1reXJvTTE3?=
 =?utf-8?B?emVVNjh1MGF0SWpNRlJqTGwxVFBMRHI3U2VHM1BEN2tWWDZGZWo4ZmxEeHBE?=
 =?utf-8?B?Z2tHVjJSVU1pRVAzT2E2azY3amd4T1VvOTg1NmVKMFQ5TWFCNjRrS3ByNkZK?=
 =?utf-8?B?S0pwSjI1aVI3MEt3aFBFbTAxd1VGN29LYnZwV0JwSGpvVzVoZjcvc0Rva29Q?=
 =?utf-8?B?VmpiU29DOFdQVWttTXI0enM4Uk8wQS9MaFg3ZmFWK3hBVW5CZncvMTY1RUUr?=
 =?utf-8?B?c3dMdDk2K0Yyc1YzV0RITkM3SFFqRTZUMzZIaU1FTmdpdmIxNFErcTE5NDlO?=
 =?utf-8?B?Mko2eTZmZ05NTDRjc3FwWjJBai9LU0pZSmFVeURUZzFuSENFR2kzMk1LVTNU?=
 =?utf-8?Q?ndtxllTBhLlag?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3ZWd2g2WG1tYit5UEVHa3JzKzFrVkxlRUJJd0k5NUlibklUM3I1eHppRGFw?=
 =?utf-8?B?eFpRdVVaamkyTElZSHJJbUFOTEZRc240bTdpRHhoZ2Rxb3MxdVhWRk1aL0pT?=
 =?utf-8?B?ZGlTVWJlVlpYK1FVS2ZkSlhIUHhqM3ZzTWs3MDBXdm9kSitJSDk1dWwrUkJ4?=
 =?utf-8?B?VlBqVGlHZWsrMkh0am9EbmpwRTR4T0UzMXZ3c0RtTU8wNDBVd2o0K3R6ZE54?=
 =?utf-8?B?anNzQzk2Z0hBeDZnZkx2eExTQWFNSE9ZOGNVYU9KQkxSYjFuYTFNV3NnVGRs?=
 =?utf-8?B?ay9FNWI0YVRONnd0K2xJemlWZHlKMEc2YVk3TWZDSjB4SnJHdzVJVG1hZTFT?=
 =?utf-8?B?SXcwUkVIUC9FR1hiNmFUUjc1Q3EvTno2SnJmTVZ5Rmtpcm1iUVU3dE1QZ0gz?=
 =?utf-8?B?UUVhYkJXVEtXT3NjZkFiL013RTFlUkcvdGdyQWNWZ0VHRmE5VFhGYjlNRlMw?=
 =?utf-8?B?ZjFNUGVPbEZCdEc5ZVJLNUY2NGptZ1VGbE9JQlpsWnhoU2pISGI1VlJhTHk1?=
 =?utf-8?B?ZlhvVDkyZmgrOVdpY3BQME9UK2VRRm9pbE9Ic3hueGlPckhQWXhoM1JuYmI4?=
 =?utf-8?B?dkVQaWJaU2NTaGxSLzc1VXdiaXV3WlRwL2N5ZFlOWW5Yc1psWjYyZUpqRGt1?=
 =?utf-8?B?Uitia3pTRzY2eUtoVGt6bzdXbDdaUm9tY1ppV3RMcEVzeHlPQzI2M3MwbTdS?=
 =?utf-8?B?Z3dicEZOdDg4OTkyZmhGN1J4Tm83WXg5Rm9KK0xaZ1pLT2ZFY0lXMHBtTjJF?=
 =?utf-8?B?dUxoZk94Vm9mVXBpL0lNMWxuYWttQ21PNUVUdHlScTFWV3RoZzZBaU5hZmZ3?=
 =?utf-8?B?RXh6Z0tVeDVQSG50cGw3T0JwUFkvejZuZUx0QkJwMEtyMUszTEhXY2E5OGM0?=
 =?utf-8?B?ZlFheDh4ZHRVTjZLQ2s5MjVTQVFvenJXeis3NmxxM2VyRGRobFpkeWh4U1g4?=
 =?utf-8?B?TkorTVhiNVk5Wnp2cEZ0VFZjMUcyeHdwNXdDWExxa1hmMnQ2bUtpUUEwU0V2?=
 =?utf-8?B?a1RnaEplcTAwbGx4eExzZ0o1OWkrMEx3SHFEU3RCZStJQjJPRTU5eXYrT3NT?=
 =?utf-8?B?TUV5bmRaTW1iZEFnRWZRemlqNDhVZW1KR1Z3WnBzbE9BRmU3aEY1MlZ4bGs0?=
 =?utf-8?B?WUdKMmtxVjJoK1kvRUtEeU0xWWpOOUEvdVQxM2dOVHF6ZGgrVlJQL0x2ekF3?=
 =?utf-8?B?aVZkcm5reTRMeHZFSmVVWnVoU3NOWW4xSERJZzUxVDlkUk9JMDVLNTBXMHF5?=
 =?utf-8?B?YWk1dE9tVzV5V3IrbnVyUVdmRk1lVVFJTFA2L210SEpCVEZab3NUU2dKWnYw?=
 =?utf-8?B?NVNwN1A3dTBGUmlUVU5HSXhrdDVXMjh3TGs1WnB1RnZzb3pDeEFnV3BQelBh?=
 =?utf-8?B?WEZMWXk5VGN5bVh1RU0rYjNzNlEzdGdjSWYyVHFuZmxvY3g3YXBoWVVHOG9k?=
 =?utf-8?B?bkZ0V2VDTHJMNW5OSmlMcTV5cWRLTHJkTGY1RXF2Z1pNNzNVUXRjNzRmYVlR?=
 =?utf-8?B?bXZ5MXJGUjlYSldocGhVVjZGZXJtK3F6WjNyTVloSG5PdWR0WHJRZkRNQkFn?=
 =?utf-8?B?R1RBUTVMbXg2aDRMU3FDVWZvbDlpcnoyRTF1ZW5sVTRRUEZxcE4wRGIwd29w?=
 =?utf-8?B?U1RCMzhWNkpOMG13UzBxOFRTbXNOSThZbDF6ajBCNUo2TVlUQnBZTWN3cnFl?=
 =?utf-8?B?RWppKzdTaTN4VHRER3I1TW5DUjJUcWwzWWgwWVY1QkNrZm5rL1I3eTVpZGJi?=
 =?utf-8?B?Z3hZNHcvcllLZTRIN3MyczA3d1F5WEhlWEZEWmp1S0VNRlZvanpna3djdHhw?=
 =?utf-8?B?R2EvWkVPbGYwNU0ybmdmYjhpRmx5dzlRTDdFakxqUW9RRmVTUEFWM1dWMnpT?=
 =?utf-8?B?ekl3NmFzR0R3cVlsYm05Rk5OKzk5SWI3ZHBvdk1HS0JtWEVhNnBXaTU2QU9y?=
 =?utf-8?B?djhQODdPMTBub3dHSU15RFBJa0JBNzhEWHhIampCZ1hhRUZSWmJZdHhZMy81?=
 =?utf-8?B?dDhUdjNtZXBNNFdzVlJoSWUzWWYyYlRQZjRjSWg3dWhpOE9aekxHWEswQzV0?=
 =?utf-8?B?RlRmSXJSeDJ3Q3dzdUtDTUVHRUtiOHdmWEtUdmVqREVrdTBicStvRUZ5aFdx?=
 =?utf-8?Q?U5AsfkEs9v+Ohvh3l0GDkLkzN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11bbe1fc-0aac-40ff-a67d-08dd6b1cfc40
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 21:43:59.2989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLcn3b1/eFJtDYMaDrtT+I5hn2MRvaknadjC9GMEWqm+Yu4gmWQj8QYlgdYRB9MEm23J1Zuz6MMNKePOGKVuyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4263

On 3/24/25 22:23, Bert Karwatzki wrote:
> Am Sonntag, dem 23.03.2025 um 17:51 +1100 schrieb Balbir Singh:
>> On 3/22/25 23:23, Bert Karwatzki wrote:
>>> The problem occurs in this part of ttm_tt_populate(), in the nokaslr case
>>> the loop is entered and repeatedly run because ttm_dma32_pages allocated exceeds
>>> the ttm_dma32_pages_limit which leads to lots of calls to ttm_global_swapout().
>>>
>>> if (!strcmp(get_current()->comm, "stellaris"))
>>> 	printk(KERN_INFO "%s: ttm_pages_allocated=0x%llx ttm_pages_limit=0x%lx ttm_dma32_pages_allocated=0x%llx ttm_dma32_pages_limit=0x%lx\n",
>>> 			__func__, ttm_pages_allocated.counter, ttm_pages_limit, ttm_dma32_pages_allocated.counter, ttm_dma32_pages_limit);
>>> while (atomic_long_read(&ttm_pages_allocated) > ttm_pages_limit ||
>>>        atomic_long_read(&ttm_dma32_pages_allocated) >
>>>        ttm_dma32_pages_limit) {
>>>
>>> 	if (!strcmp(get_current()->comm, "stellaris"))
>>> 	printk(KERN_INFO "%s: count=%d ttm_pages_allocated=0x%llx ttm_pages_limit=0x%lx ttm_dma32_pages_allocated=0x%llx ttm_dma32_pages_limit=0x%lx\n",
>>> 			__func__, count++, ttm_pages_allocated.counter, ttm_pages_limit, ttm_dma32_pages_allocated.counter, ttm_dma32_pages_limit);
>>> 	ret = ttm_global_swapout(ctx, GFP_KERNEL);
>>> 	if (ret == 0)
>>> 		break;
>>> 	if (ret < 0)
>>> 		goto error;
>>> }
>>>
>>> In the case without nokaslr on the number of ttm_dma32_pages_allocated is 0 because
>>> use_dma32 == false in this case.
>>>
>>> So why is use_dma32 enabled with nokaslr? Some more printk()s give this result:
>>>
>>> The GPUs:
>>> built-in:
>>> 08:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Cezanne [Radeon Vega Series / Radeon Vega Mobile Series] (rev c5)
>>> discrete:
>>> 03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 23 [Radeon RX 6600/6600 XT/6600M] (rev c3)
>>>
>>> With nokaslr:
>>> [    1.266517] [    T328] dma_addressing_limited: mask = 0xfffffffffff bus_dma_limit = 0x0 required_mask = 0xfffffffff
>>> [    1.266519] [    T328] dma_addressing_limited: ops = 0000000000000000 use_dma_iommu(dev) = 0
>>> [    1.266520] [    T328] dma_direct_all_ram_mapped: returning true
>>> [    1.266521] [    T328] dma_addressing_limited: returning ret = 0
>>> [    1.266521] [    T328] amdgpu 0000:03:00.0: amdgpu: amdgpu_ttm_init: calling ttm_device_init() with use_dma32 = 0
>>> [    1.266525] [    T328] entering ttm_device_init, use_dma32 = 0
>>> [    1.267115] [    T328] entering ttm_pool_init, use_dma32 = 0
>>>
>>> [    3.965669] [    T328] dma_addressing_limited: mask = 0xfffffffffff bus_dma_limit = 0x0 required_mask = 0x3fffffffffff
>>> [    3.965671] [    T328] dma_addressing_limited: returning true
>>> [    3.965672] [    T328] amdgpu 0000:08:00.0: amdgpu: amdgpu_ttm_init: calling ttm_device_init() with use_dma32 = 1
>>> [    3.965674] [    T328] entering ttm_device_init, use_dma32 = 1
>>> [    3.965747] [    T328] entering ttm_pool_init, use_dma32 = 1
>>>
>>> Without nokaslr:
>>> [    1.300907] [    T351] dma_addressing_limited: mask = 0xfffffffffff bus_dma_limit = 0x0 required_mask = 0xfffffffff
>>> [    1.300909] [    T351] dma_addressing_limited: ops = 0000000000000000 use_dma_iommu(dev) = 0
>>> [    1.300910] [    T351] dma_direct_all_ram_mapped: returning true
>>> [    1.300910] [    T351] dma_addressing_limited: returning ret = 0
>>> [    1.300911] [    T351] amdgpu 0000:03:00.0: amdgpu: amdgpu_ttm_init: calling ttm_device_init() with use_dma32 = 0
>>> [    1.300915] [    T351] entering ttm_device_init, use_dma32 = 0
>>> [    1.301210] [    T351] entering ttm_pool_init, use_dma32 = 0
>>>
>>> [    4.000602] [    T351] dma_addressing_limited: mask = 0xfffffffffff bus_dma_limit = 0x0 required_mask = 0xfffffffffff
>>> [    4.000603] [    T351] dma_addressing_limited: ops = 0000000000000000 use_dma_iommu(dev) = 0
>>> [    4.000604] [    T351] dma_direct_all_ram_mapped: returning true
>>> [    4.000605] [    T351] dma_addressing_limited: returning ret = 0
>>> [    4.000606] [    T351] amdgpu 0000:08:00.0: amdgpu: amdgpu_ttm_init: calling ttm_device_init() with use_dma32 = 0
>>> [    4.000610] [    T351] entering ttm_device_init, use_dma32 = 0
>>> [    4.000687] [    T351] entering ttm_pool_init, use_dma32 = 0
>>>
>>> So with nokaslr the reuqired mask for the built-in GPU changes from 0xfffffffffff
>>> to 0x3fffffffffff which causes dma_addressing_limited to return true which causes
>>> the ttm_device init to be called with use_dma32 = true.
>>
>> Thanks, this is really the root cause, from what I understand.
>>
>>>  It also show that for the discreate GPU nothing changes so the bug does not occur
>>> there.
>>>
>>> I also was able to work around the bug by calling ttm_device_init() with use_dma32=false
>>> from amdgpu_ttm_init()  (drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c) but I'm not sure if this
>>> has unwanted side effects.
>>>
>>> int amdgpu_ttm_init(struct amdgpu_device *adev)
>>> {
>>> 	uint64_t gtt_size;
>>> 	int r;
>>>
>>> 	mutex_init(&adev->mman.gtt_window_lock);
>>>
>>> 	dma_set_max_seg_size(adev->dev, UINT_MAX);
>>> 	/* No others user of address space so set it to 0 */
>>> 	dev_info(adev->dev, "%s: calling ttm_device_init() with use_dma32 = 0 ignoring %d\n", __func__, dma_addressing_limited(adev->dev));
>>> 	r = ttm_device_init(&adev->mman.bdev, &amdgpu_bo_driver, adev->dev,
>>> 			       adev_to_drm(adev)->anon_inode->i_mapping,
>>> 			       adev_to_drm(adev)->vma_offset_manager,
>>> 			       adev->need_swiotlb,
>>> 			       false /* use_dma32 */);
>>> 	if (r) {
>>> 		DRM_ERROR("failed initializing buffer object driver(%d).\n", r);
>>> 		return r;
>>> 	}
>>>
>>
>> I think this brings us really close, instead of forcing use_dma32 to false, I wonder if we need something like
>>
>> uin64_t dma_bits = fls64(dma_get_mask(adev->dev));
>>
>> to ttm_device_init, pass the last argument (use_dma32) as dma_bits < 32?
>>
>>
>> Thanks,
>> Balbir Singh
>>
> 
> Do these address bits have to shift when using nokaslr or PCI_P2PDMA, I think
> this shift cause the increase of the required_dma_mask to 0x3fffffffffff?
> 

That depends on dma ops, as per dma-api.rst

"
	dma_get_required_mask(struct device *dev)

This API returns the mask that the platform requires to
operate efficiently.  Usually this means the returned mask
is the minimum required to cover all of memory."

I think the assumption that dma_addressing_limited(), due to dma_mask
for the device being smaller/shorter than required_mask implies dma32
 = true, is incorrect.



> @@ -104,4 +104,4 @@
>        fe30300000-fe303fffff : 0000:04:00.0
>      fe30400000-fe30403fff : 0000:04:00.0
>      fe30404000-fe30404fff : 0000:04:00.0
> -afe00000000-affffffffff : 0000:03:00.0
> +3ffe00000000-3fffffffffff : 0000:03:00.0
> 
> And what memory is this? It's 8G in size so it could be the RAM of the discrete
> GPU (which is at PCI 0000:03:00.0), but that is already here (part of
> /proc/iomem):
> 
> 

I think the mask is independent of what is mapped there, all it says it
it needs to address upto 46 bits in the mask

Balbir Singh

