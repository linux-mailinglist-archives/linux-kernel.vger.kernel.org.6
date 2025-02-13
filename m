Return-Path: <linux-kernel+bounces-513941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 306B5A35077
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5B60189096E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9B4266B53;
	Thu, 13 Feb 2025 21:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="BpXK9xZr"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2124.outbound.protection.outlook.com [40.107.93.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C83C266194
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 21:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739482068; cv=fail; b=bZlybxyQ48ZmD0c9bLdBOef0RBqdjSIG8DgWu49uF2JkH9+q58NNSamkBaJEvFp48Gf1EIq8ezBgFOLTZgkORvhxoXVqnvJGJNF6NzYH9K1ml/tUrswAQrA8Gzbv5NPPZi8vk80o0+zi4k3K0X/ZJ4X9umKEQJYY8EnrWXTlf28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739482068; c=relaxed/simple;
	bh=9sM/lt+vFSxi+dXA0+ivMoZEOuWTPCnHZQGvHxeZKPg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WuIdEXHdDDSDnOqG5fkhUJ5Zwkyvoa2XrFfkI8qVo55tMjntCMZZFUcSVHJh0xCHo3Zf8hDKwyvA5mql4+g0mqr43T4o8xluyA+ocDaNoyljcxIB/eNiR7LmIikBUr7YPSg8sf8MncVJdLSxsO4Z5wMLiqq9063gdeNVXsPaW4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=BpXK9xZr; arc=fail smtp.client-ip=40.107.93.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DcQGOWV2MWR47a9fVoVCoVEl1tMwbGJVOfPksb04VbnK3A2OvwyCVKlPegYOh0Y1rW6FmGXVArUGWPCd6rHOK8HxIVhEUC3jdlGg6o1G5knvfY3eUOxeI7zIOgHIIS8blSZuSoIbX1PcjGXTgC6jqlx0Dp1DxsAaSIpRgxWGVsSXMUZwCklqmZWEdtqJrkMLTL5mHl6c++MJFvLIkErG2nvKk9o/Z8EXeYnqiUA7x+KHZnWnj0A1Lr/klM54u/m7a0oCkreWCwIK9Q7/sReWJVEIyvHdpR3OW2ST1D2sEXMGjB1juanETVMwvFQnhdDpIiXlJbzEOFgxepD6XDPbDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtP6tRDh/jZu2+p9p6paXjSKq9j+i8pKuwkiJjvfeKQ=;
 b=ltgMnzNWJAM16wazyWBVeC9Ib11cuwlsHxuqqwOmbmjQxaaMJhpF9bEVIHTXJvVm0fK7J3Dsj5BlP/n7e3FUDVeUiPVZdIewzI2OQZnyi4q/ARmfiGFJO5quY1cb3FLtdK0u/E7wSxTvfoMVf50DB/5sxjGuJXZ+X3wqZtXMhXaEXMp+9waFO2iqyoXotPaSyEXZwMCMvYV58jSuLShp4VmnlrTQ80uzoxH+lQPTfwT7CyD1Zc8bbP3kgUToS5MkNfyjZ8Bc59WzX0olfaoa4TrZM6SZiiHLxaIp/UFWQCjdalP2rH5DTfsBuh58/W134p09SkQkMjNqxn1P8ocW4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtP6tRDh/jZu2+p9p6paXjSKq9j+i8pKuwkiJjvfeKQ=;
 b=BpXK9xZrlMqix38GCcnjf4oL6ohpg+hEeL8ZIml9vPUM02SuDegsGO8AngrC30aj07z06CYAl/9NDG5ur+T726hgI2LoBI9/217vux4OPmPsoHQHWQdYhoxR8NQRUIsoLFzYaaOGWdS0ynsbOF+IpwA3+WhpRZOwsIdi9xzuRmE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH7PR01MB7728.prod.exchangelabs.com (2603:10b6:510:1d8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.5; Thu, 13 Feb 2025 21:27:41 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%6]) with mapi id 15.20.8466.004; Thu, 13 Feb 2025
 21:27:41 +0000
Message-ID: <8e3ad39e-de59-48bf-b776-b27dc784a8ef@os.amperecomputing.com>
Date: Thu, 13 Feb 2025 13:27:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 PATCH 0/2] arm64: support FEAT_BBM level 2 and large
 block mapping when rodata=full
To: Ryan Roberts <ryan.roberts@arm.com>, catalin.marinas@arm.com,
 will@kernel.org
Cc: cl@gentwo.org, scott@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250103011822.1257189-1-yang@os.amperecomputing.com>
 <022c4799-bf0e-44d4-b657-d6af29a9a31d@arm.com>
 <7ca5e8a6-9f01-40c6-a46d-c717ae7ab3b1@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <7ca5e8a6-9f01-40c6-a46d-c717ae7ab3b1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY8PR12CA0057.namprd12.prod.outlook.com
 (2603:10b6:930:4c::24) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH7PR01MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd9c4ac-fb0b-4822-bafd-08dd4c753f1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0htdVY2QU93QkdGQkhFUGsySVNTNW1uVHRZa3d4UkR2UU1WQVNLazJaSG5m?=
 =?utf-8?B?c2dQMG53V2VranhWRHE3dHN6RXVFZUNNMU95ZlVWcytKRWtoWmhpMGdMelJq?=
 =?utf-8?B?MXBiYWNmdlYvc1hmT01rd3JoNTZuTWg0Z1p4OTRseTVCSnVxN2hGU2RSaENo?=
 =?utf-8?B?Qm1HVktjWU1lak1mVjV6MWVuZjNsV0U2djYyNTV1SThwNXVZUm80YnA0RFcw?=
 =?utf-8?B?V3dmdWNZNGZOVVIxTG9FbFpaaTVjb0oxb2pYUXhPR3lmS0FOU0dqM3ZaTzJU?=
 =?utf-8?B?dzYzUGVYd0tjOS92NldpcVNSTWNLaE9XNThjOEtlK20xNWJSZ0ZXU2hmMmhm?=
 =?utf-8?B?U0l6M09LRVRNdEFSZXc0NHZkanF1azJhalZXdHU2SjhiZ3JYUFpzMHd0Wisv?=
 =?utf-8?B?Lzg2TjJENlN3TVdUM0hwL2ErMTQzY01leHlabG1oWXpmNlA3RllRcStoYWtt?=
 =?utf-8?B?NWV0UkdHbEgxc1YrOEJEZjBKMVorbENORWxDd2FTVE1oQ0x5M0NHR0dEOHZQ?=
 =?utf-8?B?eURaVHJENnRPN2o0SndWVHljL1c5Q0F3Tkpob3pJcWRyRmpCWWF2N1dwcHNU?=
 =?utf-8?B?VWJwNHdEbUM5WEVHWStBbXR1VzZyNjh1WWxjdFh2MUdsTGNzZGVFeXNjQzhr?=
 =?utf-8?B?b3NrKzRlRTRFRHphWVlmTGdXelJxMytDV0wxVk85VGcyeG5hckpIZlJjMmJ4?=
 =?utf-8?B?VzF2T29DMU1tWnduWW92em1tK0hJZ25JSldTbXF0YmprR1VYQUcrZjdnVFFM?=
 =?utf-8?B?eHJvZWhEUHdJZkFWR2NOQlM4SUFIVVE0UnZaVEEvME9TV0E0UkY0ZVlPNDlL?=
 =?utf-8?B?NjFoTlc0eUczTGZpY2xXWi81Wlk5OG1URGl4ajlPVGM0Vk93UFZod0ZHeXZx?=
 =?utf-8?B?V3JQemo2NjVXTFczWDB0dllhRWtFeHljVWtWdS9KM2xUekFObmJnQ09UdFNX?=
 =?utf-8?B?b2s4Z2lHODM1dG5aaU5xTHRkaUgwdlVmYXRCTXlGemM2amk5WlhZWGxiM0Vu?=
 =?utf-8?B?NjlGcmNKRnZXdHJqUDROb0M0dTdTTnFkWHZYeEN2SlFhM1huNlZEU3F1NXN5?=
 =?utf-8?B?UWE3Nk9hQStqL0VFbGFXa3NUaWZWS1RWR1FCZmZvWnFHSlFjNlA4c0hvSExj?=
 =?utf-8?B?RTZvcDNYc2RiRDVlTmZtZUJNMjBTN1RaSmpwL0dYbXNaRW9RWUpkRGpkcjZW?=
 =?utf-8?B?UER3eXVlbVZPWHVKZFhFdUdDamEvUmRtdFl6V3lBUDU1OGUvYjVBSTczR25r?=
 =?utf-8?B?WFhXdkRRWXNIWDZ5L01tNzFmT2FyZXU2TzZ0Rk9FdFh4L1VxK2puRS9DbGdw?=
 =?utf-8?B?d0lqK28rQk4xdnZKMUUrUUhSOG4wcEpZMEQ0bUd3QUFUUUthYW1GRGwwSjlX?=
 =?utf-8?B?UkVnT3V4c2xvR0swSHJ3UFlRTERrb29EVm51cjQrdUM0MVZnSk02a0FRWHYr?=
 =?utf-8?B?K3FWYmUrT0hZVDVlcjM1TUhRNytjeFU2Wm0zRFVEKzdINmxFUmM4YnJFSHlI?=
 =?utf-8?B?T3o5UDFMeUo0bWhYNTE2Z0tKZVdjT1BCdWZtKzdDcjViUUVLR2hCeWxnSjFU?=
 =?utf-8?B?akl6OFl5YzFpUTA2VW1TeGRrZHdUOWU3TzJyQXdxQ2V2YXJjQko0QWsxdmNI?=
 =?utf-8?B?S2xjbGh6NlIyODQrYzZhY1l0cDFFSjI2SG1pdm9tSXU1VXB6RUVtcHFoc1VJ?=
 =?utf-8?B?S091bmdUOVZCeEhBdGI0Y1AvQVQwNXAyZHVSbUNMWlhzQmxwOXhUOHZCRXN2?=
 =?utf-8?B?QmpFUTIyNVY1TWdMcnc5cGhFdDJobFhEV2FkQjlra25ZZEZUN3o3MVk2SUhG?=
 =?utf-8?B?SmZHcEhrVzcxVk5uRHpoZ2N3N1hQVklxQWlEdGliTkJhMU5vcHZRWE9zc1du?=
 =?utf-8?Q?iQ8N5m06Dqlny?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aitXNk0vbGs3U1B3MUdwbzhZZ3JTVmszTjFjMXBRbnIxaHI4bVJDTXpReTRQ?=
 =?utf-8?B?QzBYYW12K01sUi9jNzQ1N3NBb29ObzAxOWZVeGhpUGFOby9mZjNlYWpYbFBD?=
 =?utf-8?B?WFUwMHpMbk1FYjE1enFVclM2UUczNklWYTRhaXdlTy9DTHlqcnFURVV5VDFJ?=
 =?utf-8?B?OWhWdjhOUVhWZHdzbFdqdU9oTHBweEZ0UkwydzVDNjZtYUZGUjVYWnRQTHZW?=
 =?utf-8?B?MndGME45KzRVMkhUN3JBWTRhR0lVeldpZFlYSlFLZk9YMU1ob2crYkptNzZQ?=
 =?utf-8?B?am5wQzFtSDNNWXR1ZTNpZTlNK2JTS0hPOU5HSDlVTkRnN2dwL3drL3kwb1Fx?=
 =?utf-8?B?Q0J5V0swby9SNDMzc0J0cWVOVlVoN0pPYUJhZjBSejVNcUs0akV5THB6ZUll?=
 =?utf-8?B?VHlJcjJtVE9ZZUZmd1pGQVh3S0xyb0wvOHo2RWU1SnZOZ2xLdmVkYUNoM1Ex?=
 =?utf-8?B?ZDBONE9aTklXK2ZBUjV5YjFvZ1NaTllKdEd0RGFwRno4QzVkcmhaVlFwU2R6?=
 =?utf-8?B?bW0xay9RdXdUdmtSdlZzbEdYRDVyekZiS013ODlBcnN2RXJxZno4ZStGcGJz?=
 =?utf-8?B?Nnh5dTNEQWNPQ2V3Q21WSm9LaUpRR2ZoMTAvc09NOHRtOHRMZHgydEZoK0Fi?=
 =?utf-8?B?N3Bjb1R0Tk5MS2VrSmVweDVHeEFzUy85VUwxMExXWmJ1Zm43VkErTnhPLzdO?=
 =?utf-8?B?dzNFRnhJT2VxMjlwYVB3bWN2V3NFZEdTUk5XdEZQd09GWVp5dGtLejRsSlpB?=
 =?utf-8?B?N1JGWElPaFF2KzBRenJPbytobnlYZ29TYUtiSmt1OWZnZUllVlp0WlJzMU1E?=
 =?utf-8?B?R0xKWUp5TzhiY2kvRDNCVHBpS3dzYjRrTVNxVzE5SWpLeXlPK1RRSmJieDJh?=
 =?utf-8?B?Zm42ZEI5cFFEZnk5bmFXZkIyT1lLWmxPcG1WZC9VY3A2Rk1qMkNHbFZYRitm?=
 =?utf-8?B?MG02U2gySmtvUzNkVGxpVnlpVGtqbi9LQVZxQ0E3cVcwYVVrWTkxVm5Mc0dG?=
 =?utf-8?B?bVQ3bWM3aDd3Y3d2a05nWFZaMjVzdm11bFduUGQ0bDc1WTVzQ2V4c2Vrd2xS?=
 =?utf-8?B?cmFtT1NKdUttcEE4TFBCY1N1M1VqN0tBelo4a1ZZRnp6L1NQVmNsREhBZVZz?=
 =?utf-8?B?QS8yNkVHdkJnMEhsUWhjYlZYKzRIN2lnWjhwZlJWSGwwdXhmTStSaGhxdGhG?=
 =?utf-8?B?RG9IMFlvL3Axa0p5c21CUG5FVSt2UXNXYWJkdGdkU2Z5RXI2Q1crMTlZSndE?=
 =?utf-8?B?QUoxa1hSTVQxWU5HUkh4aGZJMklTYlBRa0VDWnhldlhmWTQ3S3E2SFNyamVa?=
 =?utf-8?B?VVBlY3k1UUllQW5Gc3FucG1iUzYxa1RyZ2h5cC8yc3dUcGdyUEJsRmkvOXR3?=
 =?utf-8?B?N1JlZXhudXVmRzQzczV0Q2t1enR5M20wOXlIN1NMTlRoUTJnVkJURE44dGxx?=
 =?utf-8?B?dkhBT0Fuci94WEtWVGpjSkhqT0s0SnVlY1RzN2N5UFhGMTFHTHdjZW53YmlS?=
 =?utf-8?B?VkVpVmRFamMrSm4rMU1aZ1BBQlRpRm9Cemd0NGthaDZPWEg1S1JGNXNlRE5p?=
 =?utf-8?B?cXB5bHNDbDBWRTdHRm5nTWVMOHBBN0ltNjFGNXUwWTZmT0tZQk8wSG85N1VL?=
 =?utf-8?B?aWxNb3dMWFZ3SmVBTXcvYVRGQ2VqMHRTcXlwOFc4N2N5Wkl2WkRlOTQ5Tytm?=
 =?utf-8?B?eTMraVJPVDJ1UVY1OXhYRGZFVVVSRFZxRUNWamZ1UnJTVngzb3g1QXhhbkVC?=
 =?utf-8?B?UEx2L0Q0SXN2RURMOEp1elVFMmpkWTlZcEgreWRIWW9HUGpReGs5bDQvMkF3?=
 =?utf-8?B?NFUvRTF1OFFwYXIzQ2tLVmlQTG55M0ZSVVZVNTYrbG5lcGUzSlJhc2VsNXMw?=
 =?utf-8?B?MVRJL2lxUmxlclV6b21SUFZIdCtuRzZaeUE1SENZaGZhcGJJYWExOVJQVnB2?=
 =?utf-8?B?cExwTE01aHFvclJGRERmdlBNR0FSbElMNW40WjVCZHFqWExtajJHelNkNTBP?=
 =?utf-8?B?Z0E5WUVNamFZUDBoVzJSeS9xN21KeXFMc0JDekl6MVIwbzIrTVdxenM2NHVq?=
 =?utf-8?B?L25WdkRBWVhpdTZZdklQdWgxZTRPay9kL1JuSlVqcjJSR0RHOXZKWkprS1g0?=
 =?utf-8?B?OXpaMUhncU9tRXIvY1pvQkRxUkdvTUFxTGo3Skt1dlZ3ekFwbGRnUTQ3eXlL?=
 =?utf-8?Q?ZwNNpOYp5JUZo64AdQvFVYs=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd9c4ac-fb0b-4822-bafd-08dd4c753f1c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 21:27:41.1150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tIuruQiWqJvYWa+/OOMoUMA2ntCFUh25WUarDtCGrnMVpuwHIPIh0kDS5N5NECC7Y2xi8kqqz4boAqSFfts2GoxTx0QAGIrO/MMfpUydqD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7728




On 2/11/25 3:36 AM, Ryan Roberts wrote:
> Sorry managed to send this to the list only. Resending with original recipients
> added back in...
>
>
> On 11/02/2025 11:34, Ryan Roberts wrote:
>> Hi Yang,
>>
>> Thanks for putting this together; I'm hoping to piggyback on this and use BBML2
>> to reduce the cost of contpte_convert().

Thanks for sharing another usecase.

>>
>> review incoming...
>>
>>
>> On 03/01/2025 01:17, Yang Shi wrote:
>>> When rodata=full kernel linear mapping is mapped by PTE due to arm's
>>> break-before-make rule.
>>>
>>> This resulted in a couple of problems:
>>>    - performance degradation
>>>    - more TLB pressure
>>>    - memory waste for kernel page table
>>>
>>> There are some workarounds to mitigate the problems, for example, using
>>> rodata=on, but this compromises the security measurement.
>>>
>>> With FEAT_BBM level 2 support, splitting large block page table to
>>> smaller ones doesn't need to make the page table entry invalid anymore.
>>> This allows kernel split large block mapping on the fly.
>>>
>>> Add kernel page table split support and use large block mapping by
>>> default when FEAT_BBM level 2 is supported for rodata=full.  When
>>> changing permissions for kernel linear mapping, the page table will be
>>> split to PTE level.
>>>
>>> The machine without FEAT_BBM level 2 will fallback to have kernel linear
>>> mapping PTE-mapped when rodata=full.
>>>
>>> With this we saw significant performance boost with some benchmarks with
>>> keeping rodata=full security protection in the mean time.
>>>
>>> The test was done on AmpereOne machine (192 cores, 1P) with 256GB memory and
>>> 4K page size + 48 bit VA.
>>>
>>> Function test (4K/16K/64K page size)
>>>    - Kernel boot.  Kernel needs change kernel linear mapping permission at
>>>      boot stage, if the patch didn't work, kernel typically didn't boot.
>>>    - Module stress from stress-ng. Kernel module load change permission for
>>>      module sections.
>>>    - A test kernel module which allocates 80% of total memory via vmalloc(),
>>>      then change the vmalloc area permission to RO, then change it back
>>>      before vfree(). Then launch a VM which consumes almost all physical
>>>      memory.
>> I don't really understand how vmalloc is relevant here? vmalloc can already map
>> huge pages you use vmalloc_huge() and changing the permissions of vmalloc
>> mapping will only affect the ptes pertaining to that mapping; I don't see why
>> that would cause permissions to be changed on the linear map or for huge pages
>> in the linear map to be split?

I just uses vmalloc() API to emulate what modules loading does. Allocate 
memory via vmalloc() then change permission to, for example, read-only, 
by calling set_memory_ro(). So I can stress the page split by doing it 
on the most of memory, for example, 80% of memory. It is more efficient 
than loading real modules.

It is implemented by a patch against test_vmalloc. I don't include the 
patch in this series, if you think it is useful, I can include it in v3 
anyway.

>>
>>>    - VM with the patchset applied in guest kernel too.
>>>    - Kernel build in VM with patched guest kernel.
>>>
>>> Memory consumption
>>> Before:
>>> MemTotal:       258988984 kB
>>> MemFree:        254821700 kB
>>>
>>> After:
>>> MemTotal:       259505132 kB
>>> MemFree:        255410264 kB
>>>
>>> Around 500MB more memory are free to use.  The larger the machine, the
>>> more memory saved.
>>>
>>> Performance benchmarking
>>> * Memcached
>>> We saw performance degradation when running Memcached benchmark with
>>> rodata=full vs rodata=on.  Our profiling pointed to kernel TLB pressure.
>>> With this patchset we saw ops/sec is increased by around 3.5%, P99
>>> latency is reduced by around 9.6%.
>>> The gain mainly came from reduced kernel TLB misses.  The kernel TLB
>>> MPKI is reduced by 28.5%.
>>>
>>> The benchmark data is now on par with rodata=on too.
>>>
>>> * Disk encryption (dm-crypt) benchmark
>>> Ran fio benchmark with the below command on a 128G ramdisk (ext4) with disk
>>> encryption (by dm-crypt).
>>> fio --directory=/data --random_generator=lfsr --norandommap --randrepeat 1 \
>>>      --status-interval=999 --rw=write --bs=4k --loops=1 --ioengine=sync \
>>>      --iodepth=1 --numjobs=1 --fsync_on_close=1 --group_reporting --thread \
>>>      --name=iops-test-job --eta-newline=1 --size 100G
>>>
>>> The IOPS is increased by 90% - 150% (the variance is high, but the worst
>>> number of good case is around 90% more than the best number of bad case).
>>> The bandwidth is increased and the avg clat is reduced proportionally.
>>>
>>> * Sequential file read
>>> Read 100G file sequentially on XFS (xfs_io read with page cache populated).
>>> The bandwidth is increased by 150%.
>> The performance gains definitely look worthwhile!

Yeah, thanks for taking your time review the patches. I think the 
feedback is positive enough so far to get rid off the "RFC" tag.

Yang


>>
>> Thanks,
>> Ryan
>>
>>> RFC v2:
>>>    * Used allowlist to advertise BBM lv2 on the CPUs which can handle TLB
>>>      conflict gracefully per Will Deacon
>>>    * Rebased onto v6.13-rc5
>>>
>>> RFC v1: https://lore.kernel.org/lkml/20241118181711.962576-1-yang@os.amperecomputing.com/
>>>
>>> Yang Shi (2):
>>>        arm64: cpufeature: detect FEAT_BBM level 2
>>>        arm64: mm: support large block mapping when rodata=full
>>>
>>>   arch/arm64/include/asm/cpufeature.h |  19 ++++++++++++
>>>   arch/arm64/include/asm/pgtable.h    |   7 ++++-
>>>   arch/arm64/kernel/cpufeature.c      |  11 +++++++
>>>   arch/arm64/mm/mmu.c                 |  32 ++++++++++++++++++--
>>>   arch/arm64/mm/pageattr.c            | 173 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
>>>   arch/arm64/tools/cpucaps            |   1 +
>>>   6 files changed, 234 insertions(+), 9 deletions(-)
>>>
>>>


