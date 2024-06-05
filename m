Return-Path: <linux-kernel+bounces-202961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DDB8FD3B4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3062836F0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3234A18F2E4;
	Wed,  5 Jun 2024 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="PXYPBAcG"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2095.outbound.protection.outlook.com [40.107.237.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684D42575A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717607529; cv=fail; b=I2/TrGHI+Sjw+0dk+4K284++Nw6VMd+zFMr0LTkZa35aqx5++OUiT6QQro3Y1Xfc4bhEPl0X0+5hqAGg6xBUDS7T80xQcPLx4craXNnCsUONq4K4bNfzxcaisd4Z2hi0kXQZU6Y5XsBmH20dRwPkt7KKzD/BDb+N5eTib+2eQ4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717607529; c=relaxed/simple;
	bh=P2BhoU5V18uccLcueiXpt28odhcgVImNMQ+FwuHbHzQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jWYtMfv45t2sulzR9YzMVNF1M73kSl6NKqblJMFM8sIAdpYpO6CB86a6En7/TvMfrLJq2aCYxA/DzN+f+FrCOa7CHjaHKxbm/e1SXx16a/6hswL5yV4itBtS0WY42oUBUoLCTM4ga2SWueCaelDxKBF5xU8l82SZWG0+I4jZvvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=PXYPBAcG; arc=fail smtp.client-ip=40.107.237.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TN6d7Kv0mMbYl82roaZ3o8qMyWLVuC+2TPZrh80hEerhfKeNBciSOrlmpI5t37Y+ZTM6l0E1lN9UXbXj9pk2eFrMbg84YcokLruf3gQUgPKGvJ2TOYa6567j6r8Ot8ip9sZN0J+WwkxJG0KbbBFHJv36F4H4khKXUohhBB7LTwF8tP//YrFRIMP+wzx8fPDHJlvUBSHI90lnsJnUNvegiy1Zo/PbFWg5aYIuy3om+ItfGtMLxAyio9AUEaTLuZNxNVl8ekQ7HUXsa1Bg376f4qwbaq1Y5jKL11BrLvzjcdQH5kjlOMDhKm6WAU/bc30vQk3I0ZMGCQptZwVYb1ZVNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UD5UjIEke4NUGauyyYwhA+wnDdj6UGx0CZrJLbRSBqo=;
 b=icpg1of1pBjDy0igyjtVwAu4napVy00ydTpJQGzgchmnFX4YdfzbWqAxaZm5oiEmHg6Zy/NIAr4FPrTNlX3s/wCw7d2MbTQ0tzFQwx9/L7SKscpqJeG7JukXdHS9WFfNWrSz8ykuplr3UgEhkUDLzmucyiHoRaPbC4tbVEX+DH/BR48g3/Fe/i3ivdzLjWHcsZhjxjmhHA2aSYXVVDxyJqY1t9eNV2s1PPqagwIy5gWZFzgxRrAmjWtnHRFsXGNKuAAc971ahbSm2Yh9AtARuodlvxemj5Ot+JfaEtmAs2W6HCz2PRDD/1UmiUcQ3OuT1aZQHC/wuO4yvvSO4l1iZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UD5UjIEke4NUGauyyYwhA+wnDdj6UGx0CZrJLbRSBqo=;
 b=PXYPBAcGzdHFSTK3TDoYutyoyY5mycjMDX6xMYzJaco4yIJrN7SoUYM47zbi1R5xSWt2MfKaJlCys3fnQmCY4OilTXvspV1GeLQPC5aJDg1rbZbbv0LIZoHjdKIk7KyLkc3Y026IAHF0SR+0Wvx/kIfRaBRfNT8mWge1SBxmkaE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 CH3PR01MB8245.prod.exchangelabs.com (2603:10b6:610:178::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.31; Wed, 5 Jun 2024 17:12:04 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%6]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 17:12:04 +0000
Message-ID: <c6894bbc-d3c4-424c-b47e-4b2a2eedc6a0@os.amperecomputing.com>
Date: Wed, 5 Jun 2024 10:12:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: will@kernel.org, anshuman.khandual@arm.com, scott@os.amperecomputing.com,
 cl@gentwo.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240604171516.2361853-1-yang@os.amperecomputing.com>
 <ZmCYLvb_JlkCuc_u@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <ZmCYLvb_JlkCuc_u@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::10) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|CH3PR01MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: 0000f29d-3013-4648-8ee0-08dc85829f5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alBidmJmd0hyUnUycEJKTUF3bmgyR1AyeGFJdEZESWNpVysyeEh6cDNGdUdS?=
 =?utf-8?B?N0I1MXZRR3VJUHJxS0RncGpEQkJQVU9CYlpMeTlSOXRhcnJoTERuaVN5dWdI?=
 =?utf-8?B?eDN2S1M1aUtNOEVmZmx2UGlCcnkwc2Uvbm1yTGJLdDdqLzdRNjNjQXBtaThD?=
 =?utf-8?B?U1BEbjNSSWlaZDdxL2pxdVI0OHpneVMvNE1YRUFyNUZyTDZ1Qk9BY3FuZHZn?=
 =?utf-8?B?aGNCaWJWVU8xQ0N1Y25POHBwM0RHTlVLdXhURXJtODdua2wwMEtoSzhMam9n?=
 =?utf-8?B?eVJGbHduTktiY2dPbTRRdDhRKzJxMUtaVHlRUjFnSHFtUEFOQldDMHRUcVdv?=
 =?utf-8?B?OWNESHQ0YS9GaDRMSGx1SkJnRHdydTVYNzJXaGQ1RmRKV2swRWd3bWtQSHdr?=
 =?utf-8?B?bGZ6T1ZFSjdsUUh1V1dkVTlrYXBHN1pvUnF2eVhVdHZ5Mjh6eXBNT2hSQmhH?=
 =?utf-8?B?WHNmNTJzWVpDMldBNGs2eVRSa040TkM0aTlHazFLOHE0UzZVbGdOTE1HT1hC?=
 =?utf-8?B?NHlKT1JBZmU4blI4MmNvZWs1QVNkSWJUK1F6NkJ2Nkl4elMrelRGQi9nS1pL?=
 =?utf-8?B?Zy9obkdoT1ZjQTVPZlB6NVpQUS9PeXN4eTlxZzErKzZvNlhZL0I5MjU4a0c4?=
 =?utf-8?B?R2IwUDJ5UTc4bDdLWGw0WVpuVmMrYlM1QmhSWGdMejBRWi9HZzlGYS9OQmFJ?=
 =?utf-8?B?ZWMrbzN3SFZyUlBOVGVhQ1g0czZ6dkxaNGVOMzZpenl1ckV0UlpNcXpUSUs1?=
 =?utf-8?B?TTlpcTArRUM2Sm1nUEVvTStiNTJ1dFZyUUZ1dVJFRGROVjhma3NtanFnRFRu?=
 =?utf-8?B?cjRoRDM5V0RIa2pERi8zenRuS1BZNjU4dDVhL2Q5cmpqVFd0YVlGdWFMUWJa?=
 =?utf-8?B?cW9XSWdTV0MxbHZLOEVzREFVS2xnb2lwcGR0NlQ0RUNZcUVIVldvSzZwc0Mv?=
 =?utf-8?B?bUtoenV0bUJNT3FBUzJYbUJzSlJwcTdtWWNJU0gyV1RsV1kxTWNic0pMMy8z?=
 =?utf-8?B?NlRNeVhYSWpVM2doL2pOSUlBQkgrUkYxK1FiRkJNZ04rUjVQUFhXekZRZ1Zz?=
 =?utf-8?B?eERhaiswQVJLTUhnRmhCS25CMk9TcTdoNldIeGV2TmJOWk5vVDFDM3NLV05C?=
 =?utf-8?B?UVljWlV5Q1NGNTNQbk9NQjcxY1FwUWhYY0FLN09NOWRwcWZYTXkyWDFGZXN0?=
 =?utf-8?B?aU1GSTV0UHRQNUVZWnVvOGRBcW13V3dsRmpTRWNhMnZVS2NnTlhvZ09pcWkw?=
 =?utf-8?B?OU5QMzdnTjBORnVoeUN3SzB2cTUwV3JKTHlpMHdIYnczeHZpVEJMdDkvSFpG?=
 =?utf-8?B?ayszcWxiWTQ1ckxpMzREUlh6NDZETm1CL2N1SXZPa29LUXVmNVllR0hKNm5N?=
 =?utf-8?B?V3pkZWVXa0JLVzFGVU10OTkya1dJeDFDKzZ2Sk43YmV2ank2blYvS3ZLdTVV?=
 =?utf-8?B?Ry92Y2JyN1NHaktVZ0g4SFIxRWwxR1lBN2NaajZzNnA5Y0UyZkdYMXV2R2hl?=
 =?utf-8?B?bVpaS2E5QXEyYVUwSjY2Q3VTMjlNMVc1a3dmb1BQTEdTMkIyVzNkY0U3ZkhI?=
 =?utf-8?B?eC8xMGQzYWtlZHlFVWNYSHpQd3h2UjZUTXdMR3VrMGhJcndmcE9ueE94Q3Zk?=
 =?utf-8?B?ZjN2TEZhS0hvaW9uMjN0a25rK2dEY3VFcnlsSCs5czNwQkNrVnE1YWNwUTNQ?=
 =?utf-8?B?V0RCWkVYMVVZa2cvUGVNakt3UW8ydUZwRUlrYVp3VTJMUFhUQjhxTi9RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1VhN3hjaEloeTJwTnpnOTRLc1IzcWdNMnZ0UnJTdkd0ZUxqd0lmOHhlQ1pn?=
 =?utf-8?B?MEQwK0xxSExVa0dxM0lnbkp2eVd4VlQ1UGkvWkVpcmFxejBkejRNKzJDc1hw?=
 =?utf-8?B?L0NTMFF0QlA4SmQzaitXZ244U05qWEIyNndZTjRSWVRNdUU3Y3kwbmgzLzNt?=
 =?utf-8?B?dXFsWEtxaTlmdUZ1VzlMUkhrWGdHV1VGN1RsY3RrSitWb2toaERxZDBtamNi?=
 =?utf-8?B?bkdMckpEdHZEUHlFTlY1NEt4Z3EvbkZBdVMwUGhYcTZmSGVsWkhjK2JoT1cw?=
 =?utf-8?B?bndKbXJDYzN5YlRNL3FMazJybTVNU1V4YUI5ZXg3NWNJS0pweFpuK3FDc1VY?=
 =?utf-8?B?akZLeFZWOEFsZ2VYM3pKRVB2cHlTUlA0MTIvSi8zWXFUcisySGtmVTYvNUtK?=
 =?utf-8?B?bW81blJHaFBmNzVoR2pjSnBHdEJibWRscG05U3Z4WHE2c1RZTlhkUlJraUFT?=
 =?utf-8?B?Vk1TeDRCNkltdVN5RkhXUDlzMlBLN1VVMkwrNmwreFkvQWRma0lHMzJoSHUr?=
 =?utf-8?B?K29mL0VSNW4rcHM5SFpvT1BWZzdVZ1BKeHN3M1NRS2p0dGN4cEptWlFwZ2Ux?=
 =?utf-8?B?K2Y4eWx5U1c0WmJlWnF1ZE1RZjl6dU9FbUhuVmx5VXNENEQzQm5YOVdSWXdN?=
 =?utf-8?B?c0l0K2oxenZ4RXB0bU5Jc2E3a0VXUEhzYlNES3NzcnNYZzEzWkFrWGFaU1c3?=
 =?utf-8?B?Y3EzYkFzc0Q1bFZ6L1hreSt6YzJzM2QrV0xJNEwvMzc5Ris3Z2ZuT1ZUQ1Q5?=
 =?utf-8?B?cEkyWlRXTDZsSDJOMG9VT2dFVGYwejdLUGkzR09GbEU1ME51K2I0ZDJTT1FC?=
 =?utf-8?B?SkdHbWhuZk95cTFjcHE4TVNFZ25oeURLaHM2ZHBsNTlUdXBCMHU0T1RVMjFr?=
 =?utf-8?B?ZGo1V2xuMkU4MmM4dS9lNXdrd092NkM4c09LYk1FelRhYnRsaEFQVzBzTEhN?=
 =?utf-8?B?a1NCMm44RnJLYkRDMThyakYwbC9XUjd0SVRiaUpkdTY4VFVvVmJMUUp4VVJo?=
 =?utf-8?B?RGlPS2Z4eTJYS3c4Z3JsakJ2Q0JvZlBIMWlnUDdtakd1TjIrdEk3ZGYya3lP?=
 =?utf-8?B?dW44VUFwOU9NMDdvSjE2NTdFTmdnOGRzNEp0QmdyTU5ma2tYaGZkU3M5cWU5?=
 =?utf-8?B?QVhVT2U4OW11NTYxQ0wzeFhsS3A3elhkcmp4Tm44V056Q2J0WGVadHdjdkMv?=
 =?utf-8?B?a3JrT1kyV1d3N3R5OTRHdWZ5Q2h0d2JPK0Y0eVp4LysrbHo2NEFNTXJYb1hi?=
 =?utf-8?B?R3ZRMmNkWkt2SzRBbUF6VWNUTUV4d0kvLzFNNEVESGpEeFFpYTY1K1VHc2t4?=
 =?utf-8?B?ZktYSDFUR2o4dm5uT1dhdVZTejEzOUZuWnRXU3Qvdmt1V0phTmhqMFArYm5V?=
 =?utf-8?B?WVpPbjlSeCt4NGQ5RXpRWmlJeXBiam1aWEN0emo3ckFNWVNqS3ZqU0lNOFdQ?=
 =?utf-8?B?N1JGWXo3QnNacHZxU0hybk9yeEp2YUJQVlJNWWZlUTM0NjE3QjhTbmI1K2xH?=
 =?utf-8?B?NFpRWHFjZVZKbVN2QzlzYXJzMGJhcFZZOGtuRHcvNzNTNmVldWNhcUFTZ2t4?=
 =?utf-8?B?WVBXaVMvNVpVd1FwSy8vM213Q3ZjaXRDRE1iN1R2NC9VeGI3QzFVbG14blZt?=
 =?utf-8?B?bWlqTHovL1NKdElrUU1heDFvbjZGVklObUNIcTR0ejFxWmZCQzVzSFNzNFcx?=
 =?utf-8?B?cE5RQkNvQVZ6eU0wNTFKY3NhcHkyMzlCbm1Lczlmemw2SmVRWlRsdXdzb3dk?=
 =?utf-8?B?K01OUm9GbXYrQW5PVE9hTDl0N3gzUDFUL3pXS1VaSm82YVVQL2JHOW9Tb3cx?=
 =?utf-8?B?S1ExVEFOZjdIbEM4WWdZOVVRa0QyOWk5MHBkZEk0OVJHWGcxSzZVc05kMDlk?=
 =?utf-8?B?N2IrYzNOMGFaSjVNMS9lTStpK2xMdXp2WVVpTzJMUGJIek1nMm5VRlE5TWkx?=
 =?utf-8?B?S01YbHR4akVydlRKNDRqajNLb3dxZzFmZURLN1BFdmlEZ2swd2x3TlFBdkxH?=
 =?utf-8?B?OUxweVhuU2IzSllwZUppWEQ1ZWNXQzVXY2RXNWQyV0FjcmcybTFBU0hkLy9k?=
 =?utf-8?B?Zm1NNFMySlJIdExqOEMwR1hKSCtZdThMd0Z6ampDbUVVN3NmaGI0WC8wWVN0?=
 =?utf-8?B?SStWc2MzazBnTnluY1NYRHd5VktNbkJQUkJWVGlaczBIV0l4L0pQbUZUTHBn?=
 =?utf-8?Q?YVVecCJQZuCWlIcI4xC2MaQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0000f29d-3013-4648-8ee0-08dc85829f5d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 17:12:04.6577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xnx9RUc0HzSYkc0DyNle5qiI251+UicCcd4PArI8L5Zj9KIAms5Oivv319sUOjWYrl0nktiqHD/CgcK81LSAG3fNL/gW73ZVlp/rQvh1Yos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR01MB8245



On 6/5/24 9:54 AM, Catalin Marinas wrote:
> On Tue, Jun 04, 2024 at 10:15:16AM -0700, Yang Shi wrote:
>> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
>> index 8c0a36f72d6f..4e0aa6738579 100644
>> --- a/arch/arm64/include/asm/insn.h
>> +++ b/arch/arm64/include/asm/insn.h
>> @@ -325,6 +325,7 @@ static __always_inline u32 aarch64_insn_get_##abbr##_value(void)	\
>>    * "-" means "don't care"
>>    */
>>   __AARCH64_INSN_FUNCS(class_branch_sys,	0x1c000000, 0x14000000)
>> +__AARCH64_INSN_FUNCS(class_atomic,	0x3b200c00, 0x38200000)
>>   
>>   __AARCH64_INSN_FUNCS(adr,	0x9F000000, 0x10000000)
>>   __AARCH64_INSN_FUNCS(adrp,	0x9F000000, 0x90000000)
>> @@ -345,6 +346,7 @@ __AARCH64_INSN_FUNCS(ldeor,	0x3F20FC00, 0x38202000)
>>   __AARCH64_INSN_FUNCS(ldset,	0x3F20FC00, 0x38203000)
>>   __AARCH64_INSN_FUNCS(swp,	0x3F20FC00, 0x38208000)
>>   __AARCH64_INSN_FUNCS(cas,	0x3FA07C00, 0x08A07C00)
>> +__AARCH64_INSN_FUNCS(casp,	0xBFA07C00, 0x08207C00)
>>   __AARCH64_INSN_FUNCS(ldr_reg,	0x3FE0EC00, 0x38606800)
>>   __AARCH64_INSN_FUNCS(signed_ldr_reg, 0X3FE0FC00, 0x38A0E800)
>>   __AARCH64_INSN_FUNCS(ldr_imm,	0x3FC00000, 0x39400000)
>> @@ -549,6 +551,21 @@ static __always_inline bool aarch64_insn_uses_literal(u32 insn)
>>   	       aarch64_insn_is_prfm_lit(insn);
>>   }
>>   
>> +static __always_inline bool aarch64_insn_is_class_cas(u32 insn)
>> +{
>> +	return aarch64_insn_is_cas(insn) ||
>> +	       aarch64_insn_is_casp(insn);
>> +}
>> +
>> +/* Exclude unallocated atomic instructions and LD64B/LDAPR */
>> +static __always_inline bool aarch64_atomic_insn_has_wr_perm(u32 insn)
>> +{
>> +	return (((insn & 0x3f207c00) == 0x38200000) |
>> +		((insn & 0x3f208c00) == 0x38200000) |
>> +		((insn & 0x7fe06c00) == 0x78202000) |
>> +		((insn & 0xbf204c00) == 0x38200000));
> Please use the logical || instead of the bitwise operator. You can also
> remove the outer brackets.

OK

>
> That said, the above is pretty opaque if we want to update it in the
> future. I have no idea how it was generated or whether it's correct. At
> least maybe add a comment on how you got to these masks and values.

It was generated by a script using Python sympy module, which could help 
figure out the most simplified condition.

>
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index 8251e2fea9c7..1ed1b061ee8f 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -519,6 +519,35 @@ static bool is_write_abort(unsigned long esr)
>>   	return (esr & ESR_ELx_WNR) && !(esr & ESR_ELx_CM);
>>   }
>>   
>> +static bool is_el0_atomic_instr(struct pt_regs *regs)
>> +{
>> +	u32 insn;
>> +	__le32 insn_le;
>> +	unsigned long pc = instruction_pointer(regs);
>> +
>> +	if (!user_mode(regs) || compat_user_mode(regs))
>> +		return false;
>> +
>> +	pagefault_disable();
>> +	if (get_user(insn_le, (__le32 __user *)pc)) {
>> +		pagefault_enable();
>> +		return false;
>> +	}
>> +	pagefault_enable();
>> +
>> +	insn = le32_to_cpu(insn_le);
>> +
>> +	if (aarch64_insn_is_class_atomic(insn)) {
>> +		if (aarch64_atomic_insn_has_wr_perm(insn))
>> +			return true;
>> +	}
> Nitpick:
>
> 	if (aarch64_insn_is_class_atomic(insn) &&
> 	    aarch64_atomic_insn_has_wr_perm(insn))
> 		return true;
>
> (less indentation)

Sure

>
>> @@ -557,6 +587,11 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>>   		/* It was write fault */
>>   		vm_flags = VM_WRITE;
>>   		mm_flags |= FAULT_FLAG_WRITE;
>> +	} else if (is_el0_atomic_instr(regs)) {
>> +		/* Force write fault */
>> +		vm_flags = VM_WRITE;
>> +		mm_flags |= FAULT_FLAG_WRITE;
>> +		force_write = true;
>>   	} else {
>>   		/* It was read fault */
>>   		vm_flags = VM_READ;
>> @@ -586,6 +621,14 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>>   	if (!vma)
>>   		goto lock_mmap;
>>   
>> +	/* vma flags don't allow write, undo force write */
>> +	if (force_write && !(vma->vm_flags & VM_WRITE)) {
>> +		vm_flags |= VM_READ;
>> +		if (!alternative_has_cap_unlikely(ARM64_HAS_EPAN))
>> +			vm_flags |= VM_EXEC;
>> +		mm_flags &= ~FAULT_FLAG_WRITE;
>> +	}
> Ah, this revert to the non-write flags doesn't look great as we
> basically duplicate the 'else' block in the original check. So, it
> probably look better as per your earlier patch to just do the
> instruction read just before the !(vma->vm_flags & flags) check,
> something like:
>
> 	if ((vma->vm_flags & VM_WRITE) && is_el0_atomic_instr(regs)) {
> 		vm_flags = VM_WRITE;
> 		mm_flags |= FAULT_FLAG_WRITE;
> 	}
>
> This way we also only read the instruction if the vma is writeable. I
> think it's fine to do this under the vma lock since we have
> pagefault_disable() for the insn read.

Yes, I agree.
>


