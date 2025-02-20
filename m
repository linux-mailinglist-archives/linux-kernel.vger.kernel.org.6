Return-Path: <linux-kernel+bounces-522741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 760DDA3CE0B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E2B189AB22
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628DD17BD9;
	Thu, 20 Feb 2025 00:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="rFZqQi7j"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2135.outbound.protection.outlook.com [40.107.102.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E440423A0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 00:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740010773; cv=fail; b=J1kcWWhdX45BUFpI/SjPSDWSQkwzHryY1PxdWmU9UR3fYqD3QUy8f9sUF/p4wetfy6VyIYJHZVtGug4Pmvmql18mRQ6isSdW2jrQF8sGsTD1gRI//OtOCxLmyiCk+ALbItakdQMwXzk6TpUPkZnTeal0itiiDdhemR9KP+yrxpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740010773; c=relaxed/simple;
	bh=/BOFud63GEs3L2iBVbGGu2Svhd/7ObQ9K+tJt0UAH+0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gSeF1FYWndA1Pz45vAIPRj4RtFFSGtMDC0aYs8FlcXvR3JFlJcFmhDljOzsX7tKtuOZbIQpH5OXvR6oxeeupZOUj1z+58ak4qxQQ3Qn0GzpbwKQnbRrXUkiuRNP3Yafq6FzmdNU1FanWWTHejui7QtUR93ekFZDcOnXSpUJfWQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=rFZqQi7j; arc=fail smtp.client-ip=40.107.102.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pCBadj5caCMX5/5IgnmzU0kr1EjhU6rq9vGQRzi7ZlwcQVEo+XN66PHRL6wk/zICKbqhW3w1Ot8270OlfylwlaGf2f15bBLRtHIxGNDWQGNrNMOTvt3oZ86qtga8fAtudvvI6FwOocyVhdS+YssEyj5cr/hPvEZASSkFSqm3+8KMj5Jz7FbbU0Br56e7lkSE9aLIpj2FNXyANFbEogiC4HUP0ZYq+zcIVDlrewr5gJTg7Qrb0mV6WKA1CfEkjbOcYHiAmzNCX1QrhMM5XigR9CEzaJGJFf6sffFl/f8kR8B2uyGFTk+IVvSqLDQeQwT7bi8NMgbLT2MRTp3+LuEBJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lxa1IBkTiAswB9F6C1d2J28rOAew+AjV3gMyL9vg0so=;
 b=pnEEh7Wp1FO7vxT/LiNJ7WeL6XWL72RYqM1sfIA4rv6rTdotNqUWTCQO/bVZKzLuMSDn4sC8KFk0Scl0DJIgfyfk7rOVWf06YxWr6rP45Cq2TFp2zOfVcRFGcWG4BdemDgtPREwoyZplGZ8/Nmf2jor4aeZWPk3IzTMtVB1sWcfP/r93uY1ZmOfFrWuY7ifS2Hwq8/9NaZco/m4M1fTWv97FUxmcRJooMy0iXt0EbHiPNu+vdlRNH2DUX1a/UDTGGipFF4ZBuHxmmhgQrQB7LIjvPS3gAWDm/jj5RtvUt8AEmitW4FtMgs/Q6dLn2rsUR31K/zChgzKDPu86qa+bEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lxa1IBkTiAswB9F6C1d2J28rOAew+AjV3gMyL9vg0so=;
 b=rFZqQi7jFft7girny3GlupZamze+c1jT+q7AWqnREnLm+X33jUUE3DMH/C+9QAFXMIpD4CJ63ILISGhge73EdAZYidAwXo7CwbxPzMBcSIs5eqbmybk0tJc3rmiIdsD+imXR20F0gnpxgivILpSjvz8q/YPDoOeDQ78l/QeeK+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 MW4PR01MB6321.prod.exchangelabs.com (2603:10b6:303:7b::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.14; Thu, 20 Feb 2025 00:19:28 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%6]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 00:19:27 +0000
Message-ID: <4c44cf6e-98de-47bb-b430-2b1331114904@os.amperecomputing.com>
Date: Wed, 19 Feb 2025 16:19:24 -0800
User-Agent: Mozilla Thunderbird
From: Yang Shi <yang@os.amperecomputing.com>
Subject: Re: [v2 PATCH 1/2] arm64: cpufeature: detect FEAT_BBM level 2
To: Ryan Roberts <ryan.roberts@arm.com>, catalin.marinas@arm.com,
 will@kernel.org
Cc: cl@gentwo.org, scott@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Miko Lenczewski <Miko.Lenczewski@arm.com>
References: <20250103011822.1257189-1-yang@os.amperecomputing.com>
 <20250103011822.1257189-2-yang@os.amperecomputing.com>
 <eef5fba9-da21-4131-a8a3-ae9a735869b1@arm.com>
 <0c644070-e4be-43c1-acb3-30cd030e20e1@os.amperecomputing.com>
 <590573cb-d9c6-4478-bd7c-2a61b39d7e9b@arm.com>
Content-Language: en-US
In-Reply-To: <590573cb-d9c6-4478-bd7c-2a61b39d7e9b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYZPR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:930:89::9) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|MW4PR01MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: ea3b5945-e76d-441e-cb8e-08dd51443c77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REx1WXRtV2hUVVpSN0V3QXdUSTJSSTFhS3RZcTk5RFBGWEJ2MStNVmFmMXd6?=
 =?utf-8?B?NGZ6U3pjQjMvUm82S2tPYzhKYm5tMkY4ZFI0SEZoNC84SG5LdFBCdTlmTlRy?=
 =?utf-8?B?dWQrc1EyZGlMQUNyYzNwdjR4c3Z1cHR1dkVNZ0JVb1c3Qjd0TE5LMGVRQWxl?=
 =?utf-8?B?V05QM0NzOEZ5NE9GMWF1cmJ3OGZFc1ZjRHlPb3RXelB1UUpWaGo4NlJKZGh1?=
 =?utf-8?B?L1h3TWVUSGpoUWZ1MFVGbkVDVy9rd05QcEVDZVNySTFRVXN2Y1lGUGs2ZkdN?=
 =?utf-8?B?aC9xdHc3MHZWOElBNFZHeEVjdDBVVXZESUZDYVEyK0huZHVpUjVSdWVCYXNU?=
 =?utf-8?B?ZUJXbGZDOFBvc2Fsb2NLcEZvT1lHQ1R1STVYTmJxbm1lcWkzenowZStqSjEy?=
 =?utf-8?B?YUZqSmlubjk3MUloTUd4N3IzUzVmTWVQK1N4M3hZdGFwRlRWWHB0OGFZZVdn?=
 =?utf-8?B?R3FkTE5iK1FrKzBGbkYxbjl6cUlJZjR6T1FCUzI3MXdnQkViMnBIUm1FNlNZ?=
 =?utf-8?B?eFNSdnhFK0dGRi83WTc3QVpkQ2VZWndqUEx0SmNKYlcrM1NlL0wxK24vbFhY?=
 =?utf-8?B?Slh1MWZhOTZlUm45SVlVZFhTVHdnMlV6a1ZZYWRXeCtobUFwbnRSdGtGZEpt?=
 =?utf-8?B?UkFFVG81anBXNHhmcWJmdUY5RU8rZ0xicnYrQnFLQ2xyY3JWNE5NejdKdmg0?=
 =?utf-8?B?bGpJRTFTTURCUWd5ekdERk94dlRNR0h5aVU4UHpOaXZya3VsdGwxV2l0SUlM?=
 =?utf-8?B?Z3AvdmpyN0xub1RwZkI4ZFhvN0czRjk2dDFzbWdUUm5xbGRBYVo1b2VKY1lz?=
 =?utf-8?B?amZRamVKSnhsMTFyMHRFSkxXc0ttMXZhcEx3ckJwaG00WDlpc3cyUW9zSmN6?=
 =?utf-8?B?aHdYYkRnY1R0MTJ3TzQ3S0xaTW1nVmh0SGRvOFZrTFZoRVVVZmxpUjIweGI0?=
 =?utf-8?B?MTR0dTdGZ0lLbUszNy9hWXIxZjluWDRFYXJnWjZqeEhsY1RSYm4xUklwUTJq?=
 =?utf-8?B?WjhrYzM5V1VURWhXZlNpSUJyMTltcSswSS9ZaWpuWVY0azJOUFBlY0NQUnI1?=
 =?utf-8?B?dXlEamdnYkJVeXI0aFZiRW1HK1BEQ1AzV2htd3EyL01ER2twTTlGSDJhTG5X?=
 =?utf-8?B?NE9NZythR1hKaWJNYjRzY1JlZG9CNzJvRkNZbUdUVWtLVUJ3RnBXRVJjQkRF?=
 =?utf-8?B?YTIwc1c4OXBrNnJ4T2RtcEhCYktSanl4TDYybm5ublFaTFZpRE5wL3hxK0NH?=
 =?utf-8?B?cHdvRUR0TWhzSnFqa1pSbUNoN0NsWlRlTGtONTVHamJQU1BZMkVJV0tESVFS?=
 =?utf-8?B?emMzWXRwWmowZ1l4S0FDeGFQdnFSdnVaa08vRDMvRGlrNWkyNTRkTC9nYjVO?=
 =?utf-8?B?bG5ucThpNVF5VkFkc00zRlVkaWJJellQRE5qeDdIYy9tc3JxeHZEVXU2S0hR?=
 =?utf-8?B?NzR5eVo4cnhDcS9qWW11a1VURlBxb2Z0WDlEUjM0bjYwV3A0dkVkbDE2WWJO?=
 =?utf-8?B?dTdieEZxNHJBems4MG5mbWFaRUxoSlE4d3I1VE5nMzZDOGgwQXhjd3hnVmZj?=
 =?utf-8?B?RDVtWU16elNoMFZXRmJoVGFjY0hmbU1YanlJS3Z2bzNpTHJnZWs4Vk85TCtR?=
 =?utf-8?B?ZWorYnVOMmx1Q1pJZ05pWkh2T0x2T0hqb3F6Z0hKbU1aNEVpUjFRRXpIZnNT?=
 =?utf-8?B?ZE1RSWVPRXpwQW1vMUN0cytFOVQ1dVdGTEhERGxnazU4eUp5b25jaFRiQ05R?=
 =?utf-8?B?aURSVUNUdEJjU2hSYU95dWZLM1FzQmFpbXZSUmFwc3hVNlQwZGJIMUlEZ08v?=
 =?utf-8?B?blhtS0pVTVZPSVNvaFFlRzUzVTNadHNhZnM2VEZSQ1U4RnNkb01aT0JWcjJm?=
 =?utf-8?Q?+IXKsy9HgZ0d9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YThWYVNrOVVOL1VSZnJrRWRnRGNnc3JFa0tMcjI5WXFuNDNndVNXZDc4QkJQ?=
 =?utf-8?B?MUNkTzllcHJkaGl2VHBHUFRYeTV2Um1SSDF2dlpnbHhUMFE1NDFTeDBRL0U2?=
 =?utf-8?B?a0xnWUlRMk95eitSTEZEMEIyVlJjNzJUVS9RKy95SEVqQkl5cTlIdW5DdXI4?=
 =?utf-8?B?eDR1MXhZdlU1SGM0RDNhcmQrckVkMVRwYjhNMW96YlNnekNKQ1F1OVVwWXV4?=
 =?utf-8?B?QWdjeUJtZWh1eDJXekg3TlBYZitIUzIrLzRINklGYzlmVjNjaS9DbU9pNmdG?=
 =?utf-8?B?clNaNEtXNThnN1BtcFN3OTZjL0lMNmQxRHlJL3owTVB1anl6dW9iODgyYXJr?=
 =?utf-8?B?a3hhdHhrcU9aT01jbEVZQXpNU0dDSWhqVFlSUDJtQUNmZ2p2UUlIaXFsYlhT?=
 =?utf-8?B?amxRRkdXUVpqckdTMzhoaFh2VThFVWFxV281Mi9IZjlJdmdpN2tNcTU2YkVQ?=
 =?utf-8?B?TlpJNGVvcUdraGVrU1VzTVJKQ3JDMXp3SDN6Yy8rMmxRdi90Z25KTlVkdWVP?=
 =?utf-8?B?dGVacVI4MXNwR0NQa2lVWUpBdy84MDZHRUtCdEYzd2hxb3hqNUZWNTZ0TWFB?=
 =?utf-8?B?aUhnbnRDUzdOSkJQdkxKUFVFN3FkZ1dEd2hQdXhBZzB4b21OSUFpVnhxRlVn?=
 =?utf-8?B?YnZtS2l5QlpFclNzUDB1TlpCUWNCUWlrRDE1Qkpld3FDaGJJdGJSSzg3MTEr?=
 =?utf-8?B?MURCRUFwRHpUUHdZYTBhNVBITlRjOEx5M05FbzZqMGpJM2grMkgyR0lxSFhx?=
 =?utf-8?B?QzcxeGVVOWgyS2x6c01WSG5nZytZT3F6S0V4V1RlSUFvV2hCUHV4VkVPQlVw?=
 =?utf-8?B?cXZVbHQ5Z2xkUEErUk1TcGVST2tnR0tvMnVaTEJadnBaVVZhVGNWQkpOeGpD?=
 =?utf-8?B?RnI0VGlrQ3lFakp0by9raEpKQy9pVFZzUjRReTlJVko4N3l3T2RLaldJdDFR?=
 =?utf-8?B?eGdFQVVwRWl1YXM1QU1RZWkreWsydlpuaHA1K3pKZmtMdEVMQmNaZXBmSmxE?=
 =?utf-8?B?WWZZVFdaMW05dGFzTzU4R3oxTTNONlJ3MTM1YmNsKzVPY2YrUTUwSExhc00v?=
 =?utf-8?B?eHpqZG8vdklFRXJvMGwyQWUvZDB2SWdKdDZzNURFZGJpWGoyMDdua0JYYzZU?=
 =?utf-8?B?SlJIZlc1WG9CdVpBQUNCd2QrbExRSUkxem5sNHNKM1kyUzRoNndkQWJNOXdF?=
 =?utf-8?B?dHM5WEVCWVhnUzl1RDZNQTZsdE9TVFlPeEptbXA1WGlURHBaVy9IbEdsUlVk?=
 =?utf-8?B?UVl0TzNOMy92ckwzS21tbDAwajdjc0tVV091NW9yTHMyNVZuMnNSejFYOVVZ?=
 =?utf-8?B?Si9XdXhLdEQ1M3lGaVlaRUVkMUlhdHVJN0prY20vQkxiRElZQjYwM2ttT3ZH?=
 =?utf-8?B?WUdmZmx2TUdqWDVOZkhJbGlqUkJtWkdXTVYzZHVkK2gvUTIydWRvS1FHbTFu?=
 =?utf-8?B?OEt6cWt3ZG0xZFR5eWthRjdJa3Q4ZXh3aWlzQVdzMFJpbmVXTEhSUURkdWQx?=
 =?utf-8?B?YW1Nekk5K0g1czgzNS9WV0pGdUVMRm1hcng0dFZRaDYyeEFwb3k1bjFVcU92?=
 =?utf-8?B?M3BEUjFpb1JpazJqVnZxUUQxOEcvRFlQWFBPR0syWWVKSlZXOUhuYXpJMWYy?=
 =?utf-8?B?dm43bEdpSFpCOU1NVnBGcWVQbFRQcVI1cEI1NU0rTmJWZXVndzZXTDROZDlI?=
 =?utf-8?B?ZTdYbTZ6WE1GZkRUNXEzNkdYaVpUbFloeUEvK0ZSekUvMGdQMDFxUGcrdTJW?=
 =?utf-8?B?SVQ4a0dNZnkzSmY5ZzBDVTRyRmExQ3IySm52VnZ0cEZDQnlOaTRNenFqdDVp?=
 =?utf-8?B?dGdvL0NxV2QwMWJ4ZVVJdU9CVEJZRjBwV0duYTdPK25iMzJhV2lxamwwUjkz?=
 =?utf-8?B?Y3F2Qm1BdEI2YlN5WU9YRHJ4d3dxVmVXWGo2Z0U3cXo0amxEeG9UbzQvSTE0?=
 =?utf-8?B?ZFBpTmZGanY0VGlPTVVmVGVBbXVzc2hrQ0tOczVXTnFBdjIydUFGTmdyd3Ja?=
 =?utf-8?B?RG01Q3pqeXU5ZVNwTkRPNEpCb2s3MlRxVSt6Tm1UaE0rc2ZuM29lUHNmMUlz?=
 =?utf-8?B?R1MxR2F0YklISHFXekRDZDBzN1BUeW9VU0xyTEhKR2JIczZuamNtZmlhWktC?=
 =?utf-8?B?K1hQV1VwM2ttNXRQaFJ5bGJjRHNLcHpWc0toTkJ2d2xKUnNuWmNRbFR0VnVj?=
 =?utf-8?Q?1//wUXtcDhmVDvAgPuLVAY4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3b5945-e76d-441e-cb8e-08dd51443c77
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 00:19:27.3019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l39akoHC6ejsI25PI3oJG3zKL/T3aDsEooV4RI179FES3LSRzG02/L2P62jYVehfQkNRiAnegI9/JPdSajr+wJp3LzNY82xbVNRa0M4lfRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6321




On 2/18/25 3:17 AM, Ryan Roberts wrote:
> Hi Yang,
>
> On 13/02/2025 21:14, Yang Shi wrote:
>> On 2/11/25 3:55 AM, Ryan Roberts wrote:
>>
>> Hi Ryan,
>>
>> Thanks for taking time to review the patches.
>>
>>> On 03/01/2025 01:17, Yang Shi wrote:
>>>> FEAT_BBM level 2 allow changing block size of a translation with relaxed
>>>> TLB flushing.  But it may incur TLB conflict abort.  We can handle the
>>>> abort in kernel, however it is hard to guarantee the recuesive TLB
>>> nit: recuesive -> recursive ?
>> Yes, it is a typo. Will fix in the next version.
>>
>>>> conflct will never happen in the handling itself.
>>>>
>>>> Some implementations can handle TLB conflict gracefully without fault
>>>> handler in kernel so FEAT_BBM level 2 can be enabled on those
>>>> implementations safely.
>>>>
>>>> Look up MIDR to filter out those CPUs.  AmpereOne is one of them.
>>>>
>>>> Suggested-by: Will Deacon<will@kernel.org>
>>>> Signed-off-by: Yang Shi<yang@os.amperecomputing.com>
>>>> ---
>>>>    arch/arm64/include/asm/cpufeature.h | 19 +++++++++++++++++++
>>>>    arch/arm64/kernel/cpufeature.c      | 11 +++++++++++
>>>>    arch/arm64/tools/cpucaps            |  1 +
>>>>    3 files changed, 31 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/
>>>> cpufeature.h
>>>> index 8b4e5a3cd24c..33ca9db42741 100644
>>>> --- a/arch/arm64/include/asm/cpufeature.h
>>>> +++ b/arch/arm64/include/asm/cpufeature.h
>>>> @@ -866,6 +866,25 @@ static __always_inline bool system_supports_mpam_hcr(void)
>>>>        return alternative_has_cap_unlikely(ARM64_MPAM_HCR);
>>>>    }
>>>>    +static inline bool system_supports_bbmlv2(void)
>>> nit: Arm language internally is starting to refer to FEAT_BBML1 / FEAT_BBML2 and
>>> I believe this will soon make it's way to the Arm ARM. So probably better to
>>> refer to bbml2 rather than bbmlv2 throughout.
>> Sure.
>>
>>>> +{
>>>> +    return cpus_have_final_boot_cap(ARM64_HAS_BBMLV2);
>>>> +}
>>>> +
>>>> +static inline bool bbmlv2_available(void)
>>> This function has no need to be in the header. system_supports_bbmlv2() is what
>>> users should use. Suggest moving to has_bbmlv2() in cpufeature.c.
>> bbmlv2_available() will be called by map_mem() in patch 2, but map_mem() is
>> called before CPU feature is finalized. I saw you suggest collapse the page
>> table in the below comment, if it works we don't need this function anymore. But
>> I have more questions about that.
>>
>>>> +{
>>>> +    static const struct midr_range support_bbmlv2[] = {
>>>> +        MIDR_ALL_VERSIONS(MIDR_AMPERE1),
>>>> +        MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
>>>> +        {}
>>>> +    };
>>>> +
>>>> +    if (is_midr_in_range_list(read_cpuid_id(), support_bbmlv2))
>>>> +        return true;
>>>> +
>>>> +    return false;
>>>> +}
>>>> +
>>>>    int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
>>>>    bool try_emulate_mrs(struct pt_regs *regs, u32 isn);
>>>>    diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>>>> index 6ce71f444ed8..a60d5fa04828 100644
>>>> --- a/arch/arm64/kernel/cpufeature.c
>>>> +++ b/arch/arm64/kernel/cpufeature.c
>>>> @@ -1889,6 +1889,11 @@ static bool has_lpa2(const struct
>>>> arm64_cpu_capabilities *entry, int scope)
>>>>    }
>>>>    #endif
>>>>    +static bool has_bbmlv2(const struct arm64_cpu_capabilities *entry, int scope)
>>>> +{
>>>> +    return bbmlv2_available();
>>>> +}
>>>> +
>>>>    #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>>>>    #define KPTI_NG_TEMP_VA        (-(1UL << PMD_SHIFT))
>>>>    @@ -2990,6 +2995,12 @@ static const struct arm64_cpu_capabilities
>>>> arm64_features[] = {
>>>>            ARM64_CPUID_FIELDS(ID_AA64PFR1_EL1, GCS, IMP)
>>>>        },
>>>>    #endif
>>>> +    {
>>>> +        .desc = "BBM Level 2",
>>>> +        .capability = ARM64_HAS_BBMLV2,
>>>> +        .type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
>>> I'm wondering if this will potentially lead to problems for assymetric
>>> collections of CPUs (e.g. big.LITTLE)? I can imagine that little CPUs might not
>>> support BBML2. In this case if you boot on a big CPU that does have BBML2, you
>>> will require the feature and refuse to online the secondary little CPUs.
>> Yes. This is the behavior of this patch.
>>>> Perhaps this really needs to be a system feature, where it is only enabled if
>>> all CPUs in the system support it? I'm guessing that will make painting the
>>> linear map harder; I guess you will need to initially set it up with PTE
>>> mappings, then repaint as block mappings if BBML2 is determined to be supported
>>> if that's not already what you are doing.
>> Actually I thought about this before I posted the RFC patches to upstream. There
>> are a couple of options, but I can't tell which one is the preferred and whether
>> it is really that important to handle asymmetric systems gracefully or not, so I
> It is certainly important to handle asymmetric systems gracefully in general;
> Almost all mobile handsets use big.LITTLE. And I think it's entirely possible
> (likely even) that we will see systems where the big cores have BBML2 and the
> little ones don't. There are cases where we don't currently handle asymetric
> systems gracefully (e.g. LPA2), but we try to make those the exception rather
> than the rule. In LPA2's case, the VA size is a compile-time option and I
> suspect it's very unlikely that a 52-bit VA capable kernel would ever be
> deployed on an asymmetric system (i.e. mobile handset). Given BBML2 is runtime
> controlled only, I think we need to make it play nice with asymmetric systems.

OK, makes sense to me.

>> did it in the simplest way: just fail online the conflict cores. I also noticed
>> some features behave similarly, for example, MPAM. And this RFC patch is mainly
>> aimed to get some feedback from the community about whether it is worth it and
>> the direction is right or not. So I tried to make it as simple as possible (for
>> example, I didn't add CONT_PTE support in patch 2 either).
> Based on your perf numbers, I defintely think this is something we should aim to
> get upstream.
>
> I think there are 3 options for the approach:
>
>   - refuse to online secondary CPUs that don't support BBML2 if the boot CPU does
>     support BBML2.
>      - I don't personally think this is viable for the reasons above.
>
>   - initially paint the linear map with ptes, then update it to block mappings if
>     BBML2 is supported system-wide.
>      - I'm guessing the main cost is the pte-mapping, and we already have that
>        today, so it's not going to slow the boot down vs today. Re-painting with
>        (mostly) PUD-sized block mappings will be significantly faster.
>      - I anticipate we can just call the same function to do the mapping over the
>        top of what's already there but with the BLOCK flag set.
>      - It's easy to test on all systems
>
>   - Guess at the system supporting BBML2 based only on the boot CPU, then if any
>     secondaries don't support it, stop the machine and repaint linear map as
>     PTEs (we do something similar today for nG)
>      - It means that symmetric systems will boot marginally faster because they
>        never map the linear map with ptes
>      - Asymmetric systems will boot slower because they have to stop the machine
>        to do the pte re-mapping
>      - It's a code path that won't get tested very often
>
> My view is that option 1 is a non-starter. Personally I lean towards option 2,
> but could be persuaded that option 3 is better.
>
>> If I understand correctly, system feature needs to read the "sanitized" register
>> value per the comment in cpufeature.c, but we read MIDR here. So it actually
>> just uses the current CPU's (likely boot CPU) MIDR if it is s system feature,
>> right? If we really want to handle such asymmetric systems gracefully, we need:
>>      - read all cores' MIDR then determine whether BBML2 should be advertised or not
>>      - update a flag or bitmap to tell us whether it is asymmetric or not
>>      - take actions based on the flag or bitmap (i.e. collapse page table or do
>> nothing)
> It's my understanding that we want is ARM64_CPUCAP_SYSTEM_FEATURE. See it's
> comment in cpufeature.h:
>
> /*
>   * CPU feature detected at boot time based on system-wide value of a
>   * feature. It is safe for a late CPU to have this feature even though
>   * the system hasn't enabled it, although the feature will not be used
>   * by Linux in this case. If the system has enabled this feature already,
>   * then every late CPU must have it.
>   */
>
>> But system feature is not checked on the secondary cores. The
>> check_local_cpu_capabilities() called by secondary_start_kernel() just checks
>> SCOPE_LOCAL_CPU features if I read the code correctly. So local cpu feature may
>> be better? The local cpu feature maintains a cpumask, it can tell us whether
>> BBML2 is asymmetric or not.
> I've not read through the details of the implementation but the docs point to
> ARM64_CPUCAP_SYSTEM_FEATURE and there are many other cpu features defined as
> ARM64_CPUCAP_SYSTEM_FEATURE which need these semantics. e.g. ARM64_HAS_TLB_RANGE.

I basically figured out how it works. The boot cpu initializes the 
boot_cpu_data, then the secondary cpus need to update it, the 
"sanitized" register value will be generated. For example, TLB range 
capability is determined by ISAR0_EL1. If all the cpus have this 
feature, the "sanitized" register value will show true otherwise it will 
show false.

BBML2 can be determined by MMFR2_EL1. If we can rely on it then system 
feature does work. But the problem is some implementations may have 
MMFR2_EL1 set, but they may not be able to handle TLB conflict. We can't 
rely on it solely so we check MIDR in .matches callback instead of 
MMFR2_EL1. But system feature .matches callback is just called once on 
boot CPU because it is supposed to read the sanitized register value if 
I read the code correctly.

So this may not work for BBML2. It seems like the cpufeature 
infrastructure needs to be enhanced to support this case? For example, 
off the top of my head, we can define a global midr list and a bool flag 
in struct cpuinfo_arm64. The boot cpu initializes it to true or false. 
Then the secondary cpu update the flag according to their MIDR. Then we 
just need to check this flag in .matches callback. You should have 
better idea.

>> In addition I'm also thinking about whether collapse is the best way or not. We
>> should be able to have large block mapping in the first place if the boot CPU
>> has BBML2, then split the page table if it is asymmetric. I'm supposed we need
>> to stop machine anyway even though we do collapse.
> Yes I think you could do it this way as long as you stop the machine first.
> There is already a pattern to follow for this with nG; see
> kpti_install_ng_mappings().

Thank you.

>
> I don't think you need to stop the machine if collapsing, as long as BBML2 is
> supported.

Yes, I agree. But when collapsing, are the secondary CPUs actually doing 
anything? Should be just in idle loop? If the secondary cpus are in idle 
loop, then stop_machine won't make too much difference.

>
>> The split need to be called
>> on the boot CPU. We already have split logic, we can reuse it anyway (maybe need
>> some minor tweak to fit). It sounds simpler than collapse.
> I'm wondering if we can enhance the existing table walker in mmu.c
> (__create_pgd_mapping()) to handle collapse and split gracefully. Then we could
> reuse that logic for all collapse, split and permission change operations so
> that we always have the largest possible blocks mapped.
>
> It looks like it used to be able to do (some of) this prior to commit Commit
> e98216b52176 ("arm64: mm: BUG on unsupported manipulations of live kernel
> mappings"). That approach may turn out to be cleaner and more general than the
> current logic you have to split a range to ptes?

We should be able to handle splitting in __create_pgd_mapping_locked(). 
__create_pgd_mapping() takes fixmap_lock, it sounds unnecessary for 
splitting. If we want it handle split as well, we should need pass in a 
flag to tell __create_pgd_mapping_locked() in split path. But I can't 
tell how much code actually can be reused right now.

Both creating and splitting walk the page table from root to leaf, but 
collapse is different, it goes from leaf to root. I don't see it can be 
easily handled by __create_pmd_mapping_locked() without introducing too 
much churn at the first glance.

>
>> And the asymmetric
>> systems may be not that many in real world? I know there are a lot of big.LITTLE
>> SoCs in the wild, but those big cores may typically not support BBML2. If so we
>> can save boot up time for the most cases.
> Yes, you are beginning to persuade me that stop_machine() for asymmetric systems
> may be the better way to go.
>
> If the boot CPU does not support BBML2, paint with page mappings as before; no
> change.
>
> If the boot CPU does support BBML2, speculatively paint with block mappings. If
> all CPUs later turn out to support BBML2 then no further action is needed, and
> this gives us a reduction in boot time because we never had to paint per-page
> PTEs. It's also a runtime advantage due to the TLB pressure reduciton.
>
> If any secondary CPU later turns out not to support BBML2, stop the machine and
> repaint with page mappings. Assuming the major cost is writing all the PTEs,
> then this is lightly about the same speed as it is today. And as you say, this
> path is lightly to be rare-ish.
>
> OK I'm convinced.

Thank you.

>
>> The other concern is about cpu hotplug. For example, if all the booting cores
>> have BBML2, but the hot plugged cores don't, shall we split the page table when
>> the cores are hot added, and collapse the page table when the cores are hot
>> removed?
> I don't think we need to worry about this case too much. There are lots of
> things today that require that the kernel can see at least 1 of each possible
> CPU during boot (applying errata is a good example). If a new CPU model gets
> hotplugged that it hasn't seen during boot then I think it's completely
> reasonable to refuse to online it if it doesn't meet the configured feature
> requirements. If you define BBML2 as a system feature, you'll get this behaviour
> for free. In reality, hotplugged CPUs are going to be symmetric so I don't think
> we will fall down this path in the real world.

OK

>
>> I'm not sure whether the extra logic to support asymmetric systems is worth it
>> or not. Maybe we should start from the symmetric systems, then add more graceful
>> handle to asymmetric systems later if it turns out to be a real problem? And
>> unfortunately I don't have the appropriate hardware to test the code. Maybe you
>> or someone else from ARM has the right hardware?
> My view is that we need to make BMML2 a system feature. Speculatively paint the
> linear map with block mappings if the primary CPU supports BBML2. Stop machine
> and repaint as page mappings if the system as a whole doesn't support BBML2 at
> system feature finalization. In the unlikely event that the system does support
> BBML2 and a CPU is hotplugged that doesn't support it, refuse to online it (that
> bit is for free as a result of defining it as a system feature).
>
> You can hack the code to always stop machine and remap as page mappings for
> testing purposes.

Yeah, sure.

>
> I'm happy to collaborate on development of these patches and/or do testing as
> required; I think the performance numbers you posted look compelling.

Thank you.

Yang

>
>> Thanks,
>> Yang
>>
>>> Thanks,
>>> Ryan
>>>
>>>> +        .matches = has_bbmlv2,
>>>> +    },
>>>>        {},
>>>>    };
>>>>    diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
>>>> index eb17f59e543c..287bdede53f5 100644
>>>> --- a/arch/arm64/tools/cpucaps
>>>> +++ b/arch/arm64/tools/cpucaps
>>>> @@ -14,6 +14,7 @@ HAS_ADDRESS_AUTH_ARCH_QARMA5
>>>>    HAS_ADDRESS_AUTH_IMP_DEF
>>>>    HAS_AMU_EXTN
>>>>    HAS_ARMv8_4_TTL
>>>> +HAS_BBMLV2
>>>>    HAS_CACHE_DIC
>>>>    HAS_CACHE_IDC
>>>>    HAS_CNP


