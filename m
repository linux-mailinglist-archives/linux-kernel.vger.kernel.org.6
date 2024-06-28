Return-Path: <linux-kernel+bounces-234572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFE091C828
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05CA1C22CC5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3E57F48A;
	Fri, 28 Jun 2024 21:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QyDWT9iN"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0920C1EA73
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719610322; cv=fail; b=lY0PpbpUXSfLnvn/BxPoSTtiHiRsU/w7ZrN5n2IgmZ7yYkX6qlTQyOYLitYYfjstA4rCzOFEj0eBeh4THDqK0pXd+MPzggCbqFJCFNWiLbPOlONauqjK4x8+1d6FUfKEFm9ywCvZzOax2E2rhFkysIQd+mncmkjDtZ7QHIE1tTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719610322; c=relaxed/simple;
	bh=3j4RcXWNw2MDGXoZHMjcnGS5+z/kx+/lJlWr7NKLLes=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EKqo4z3lH221vK8FdCh4EcvflX8q9fdiw4bXJWcPFHSsk/27Ft9AM5TRQWWP69ELh/T7lfh4CtE8nM2ottS7XcA1gFJ7VkJ4+HC6jS5QUgA7t7/HcfKILJskTpqsTle+YLLOWEzSJ0xTPKf8V6RlXhQuIdfLtcana+Sg6CAJm3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QyDWT9iN; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghF2b5lFRkaUcc8vAP0QjUldClTsXCG611ObYJeroeO+33wZ77nI9SagQFazmvUgfE2/0YPn2BfbVRiCxChZZgYnonb2qiZ4gzc05GoQzRvsMfbr1EUHSF/kWcz9uBrcKrzmNY0Rb5GTU/5AXZOVCjhQSb3vSsTzUgPVt+YCyibh54agZjcBWlFYaYqTORXX+7evnDy+7lPf2Vynxq7TbCnggjzatffdjGoeRdfdDnkLEmBWCpGspd9L3p9NzTgHn5igIqptZbJj4+4H9fMAELJ5sBMSNOEDUQaD9XSA9kqG9AcjeakL+QUAyV/Iyh1Q90Q57D2Nf8ZQ5FlEphEzxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBEpQ4DsX+c00v1MRHyiDFyxS4+2ZpP/a9b66isqd7A=;
 b=hlXGZG0XmhcaBEDVq0t0zRqdJ4z4Dcv0Qo0xdY3SconH6nCmzDbwQCF18cEtXw6iLp7Px6AhJrHTKUaKJqEGwVjS+EIBsHWy9K/QYx1w91HImLbwdjElpB+cU43G20Q1+MQTlOEt7DEo54Otn0eFtuct6uw9qKU3IP/LmHk3qJCFur8y5JvsRjC5HTr7sKOBIBXdiLxcNPBgY+rEhbVw6wZUdm7vluq41UZrIqbVTQ8TkZC/3HpA3Y1yCcQNl8qVyO1ZmF50/YvurgGm1oa/vVLnt2jZLFY0yaaJWrlPq99IZrHES3xn8vJiBz7G0QVNmRCZSyWEnbkPFCzd7Cn7qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBEpQ4DsX+c00v1MRHyiDFyxS4+2ZpP/a9b66isqd7A=;
 b=QyDWT9iNXsS7OUL8VdeGCAyrqZ8hlcZnP5HHgKllrGOHXX46PKjq7zg93vGZ8gOEkjiF7zqb+DxEC1PJ3+ddJSHoSs36Rpk8OUTiSun5qHyUm/TMZN9plkcob9Qt7re05+Y7Pkk+gJKliCjvJX6nl0h8zONky70dW7ikbrQaS6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by SA1PR12MB8885.namprd12.prod.outlook.com (2603:10b6:806:376::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 21:31:56 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 21:31:56 +0000
Message-ID: <a3372319-8089-e48c-d7e4-5991b35c527a@amd.com>
Date: Fri, 28 Jun 2024 16:31:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/mm: fix lookup_address() to handle physical memory
 holes in direct mapping
Content-Language: en-US
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "Ashish.Kalra@amd.com" <Ashish.Kalra@amd.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "luto@kernel.org" <luto@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "bp@alien8.de" <bp@alien8.de>
Cc: "jgross@suse.com" <jgross@suse.com>, "x86@kernel.org" <x86@kernel.org>,
 "mhklinux@outlook.com" <mhklinux@outlook.com>, "Rodel, Jorg"
 <jroedel@suse.de>, "hpa@zytor.com" <hpa@zytor.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
References: <20240628205229.193800-1-Ashish.Kalra@amd.com>
 <fcb19e22678d126f9c4223d1e80f8c7d27e22692.camel@intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <fcb19e22678d126f9c4223d1e80f8c7d27e22692.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::31) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|SA1PR12MB8885:EE_
X-MS-Office365-Filtering-Correlation-Id: 4787c5b8-25c4-4bc7-a88c-08dc97b9bc08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXliYmpFeThSeXhVbXVKcmtDbWdQNTN3ZE5yRmx3OU1TWUZpNmI1dDR6My9J?=
 =?utf-8?B?OURXNHpPMFBUeGZmdzFyNTFQc0psSXVEVWZSTFVGSzhIZEZGMlJsdjNDQjJq?=
 =?utf-8?B?TTltZmV6c2pHQ0xWNmtQRmIwa0kranNIWVhLYit0WWdZV0UrMHppbUhKOWtq?=
 =?utf-8?B?MHdIRVI4SFlWK0lkb3hEaHVaYi9XaDc5VXlvVG1wbmlXWUNSdWxNcHo0bTdk?=
 =?utf-8?B?amxTVzNxbVc0eVM3TE9qRFdPMTJRdFZ6QUp6SXlML2ZxSndremtSaDdJNFVk?=
 =?utf-8?B?Mlo1WXF5c2ROU1dGNXRUZDBCR01hYmkrd0hGblNKRDRXb2NqQllCNkhHb0lO?=
 =?utf-8?B?K0QvSWlHdVdWaWFvbFowQ0JiMTlYNk82aUdRVTZNMGRlaUtSRjFIKzZwaGRq?=
 =?utf-8?B?UTV1MjVKYVlFSkpGa21HRjlkdk9PTHlDZk1yYTN4YVRjeG81VEJxRWx3YW1n?=
 =?utf-8?B?UlFFRDNXK1E1SlBXTDYvOFFuRUtLTlZZQ0o0c205aC9yb2ZTL2c1ZFhEdUpw?=
 =?utf-8?B?SGFpYVhEKzkrdnE3U2wrOU5FSlBxbENDR2w4TCtTYk12SUZZV3F2UDMrMlNG?=
 =?utf-8?B?ZHN6SGk1YmphUXNwMWhBVlAvWXZGZUtQdW8xbW5kcTlUN0I4cjkxWlltTVRo?=
 =?utf-8?B?R2UyN1Z2eWUzendoeGNMMTZuN3lKdHBCSFNuMUR0K1o5T3NpZjFuemV5c1N1?=
 =?utf-8?B?Q2ZLMzZ1WEpuYVlGSjFvUFduVVlwaDc2QXNIazc2RWNGK3B5VUpYcjlocHA4?=
 =?utf-8?B?aHlQdnEyVkhGYW1mQXBhM1Q0V3NjcjlVZG4xWUlnVFNXYWxrREJkUE1TbVVw?=
 =?utf-8?B?SExSTDh2ODVEV2JSZjhmeW9tZk9KVUhMWmRENjZKZ0JyaW1GZHQwY1lwRnB3?=
 =?utf-8?B?bG0wOERiTEhjUTdRbnlVdm16NWRVN3JyMDVUQXcvdG8zMHZSK1ZzeTJybWt1?=
 =?utf-8?B?VEE5eWY5TjNheVJaUWxTa2IvS1EzR2IxN0pOUnNmLzA2RDdZWlAwK3FkcTQy?=
 =?utf-8?B?NlhtbUpiRGhJQldJTXBDdENaUlRXUHhqdlNKNHBGWDNKRXkzaGVpSW9CWEo2?=
 =?utf-8?B?TU5PZ2lqVFdVUTQ1NzlPeHBJQmsrNEdHNFY1dEdsSS95Ymk3N0Q0bmNZektu?=
 =?utf-8?B?YWdMSm4wWTduT2xlanUwbG1WeCtJWEhVWW5UeXJOdVdWSGViT3QrYlA0cEQ0?=
 =?utf-8?B?ZmFENUVDY1FCRWkxbTJyKzgzaUpta0MvdE9rNnlRWFJiU29KNGhrMk4vYTV4?=
 =?utf-8?B?VEhYRWhERjNpYkFESnd2bG5QWXlnRWMvcWh2NDg5ckhIK21lcnNKdkxubHFO?=
 =?utf-8?B?bE1ueWs2TkZtNmYxamt1UDQ2emxRVEZqa2x3dDc0bmZvZm1pN1dkcGNLVld0?=
 =?utf-8?B?SXRENkZ2SzVsZVFoNEM2cGczZDlSYVBOWkxqRUx2NGUvcTZMRFRWSzkvWnIz?=
 =?utf-8?B?NGp2NEJ0WHBnL2VDaU5nazUxell0Vk83Y1VjUkpGTDRTbHFLRHVROUpObFB3?=
 =?utf-8?B?ZitFRUl4alppYkFSWk9FNEQzSUowdW5HdWt2MmVEc0pVOEd2MGRiSDJRNlAx?=
 =?utf-8?B?L1J3d29adjJpRTlIMEdlNTdVVE1qZGpLejlsWW5LRjYyOVBjdjIrRm16dEJS?=
 =?utf-8?B?TS9OUlpxT09zclNJdHdXUnBjZndUK2ZKaW0yc3lLYnMxQVpZdUNXRGtTaUpG?=
 =?utf-8?B?VThmYVA3MVRQS0JWTlJvdlpEcytKSDFCRG8yWlR2NEgzQTFUNFY3RHFoaEZV?=
 =?utf-8?B?b3czL25GZk5hZ25CYkdEeGgrU2ZrUk12OXBSV09pVC9JUnZFVEhkdUdBdWxZ?=
 =?utf-8?B?TVZuSGVsUU5kUzZyWkk1QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3Rkb0QwSzRCa2N2M3lYcnFWKzRWM1Y5TVcvalpqYVdCY3BaUWIwOWtBeGZS?=
 =?utf-8?B?SE0rRDRHU28zSmt3L0ljR0ZBTGkzYS9ZWjhyWVVDVWdvT2RqQkw0UWF2TklT?=
 =?utf-8?B?bUVxa1VXQkJPZ3ZVU0h2emVidnpQTGIrYVFqbk9GaENTd1BiSitqcEY0aGFp?=
 =?utf-8?B?WHBHYnZPZFZPQnpKNUhYeldZYURkTzM3OFRGRnAzbGRqRXFrNWtkaWFzMVJF?=
 =?utf-8?B?WkhxbUsvL3liQlJtQitFM2NQVDZxRk5HZ3E1MzAxNE5Nc0N4R1pwZXIzcFJt?=
 =?utf-8?B?bEc1bUphbXhEQzcvWjRPdWQrNHIwejdsSkZDZDU2RGNJQmRuWEFBYjloMjVt?=
 =?utf-8?B?V1JpVTRldkVhLzVwMFJaRXBBWkc3SjJkNjI4cFF1SXp6dEQxR01neldtZTJ3?=
 =?utf-8?B?SE80cHRvclNzbkpoUDNjSjJrNzB2ZkxQNitaWjR2bFdLYUF5aXllaUdlMEdS?=
 =?utf-8?B?RXEzMnlOOFN4T1NRaXlMdWFNSEZnY0UzL09sYlhZbkpvSGdoMXk3Mys1b3hO?=
 =?utf-8?B?ZG1UbXk4L01hTmVmaVhvdEU3N1hKVytnYnNoRUcrZXlpL21hR0p5L2xUQlBP?=
 =?utf-8?B?MWsyWkU4ei9aUStqNmVDZUI5VEU5UjlDZFdrbnZtUzlURDRFT3d3NENndDFx?=
 =?utf-8?B?M1ViU2lwZUk1NWhoeTFDMHFDWW5aNnYzb012aWZtWTZlTWE1eUhscXErd013?=
 =?utf-8?B?MjlHc2VJK0hnMFlqejdBZ1M0SVZNTzJtelJxQXZtRElZM2pUa1RTa3RzWmdh?=
 =?utf-8?B?RFF3TWMyL0R6L1RvdzNmelpjZkZ6M0JKWHAxZjBkZ2d1am5mQ0RXdDJZdnJX?=
 =?utf-8?B?ZUYrU0p5dk84WW5YOEltZUJma1F0N00xOFdHSWRlVFF6djNpeWw5MnlOVnVl?=
 =?utf-8?B?cmRiUis5RFVOdEo0d2JzZ1BvU0IwaWpBUkk1ejhrL0Q4QU5zdzY1TzdIei9T?=
 =?utf-8?B?RHFzenFYVWRQTmlFdHo1ajhrcmo2MGlkZ3pVZW9xTUVCWFRjV2ZFc0F6ZFB0?=
 =?utf-8?B?UWhCS1owRTRTUUxNZkE5bnl0REIxWFNpczNCWUhGNTdpS25CMmMrOXYzbnlI?=
 =?utf-8?B?TjRPVVpaYkVKekJ1Tzc2aG4xeWR6UVQwQ0NxSGtHdVZ4MWdKa1FycnJkZ2FG?=
 =?utf-8?B?SldudmhOakpzMXp6NzcrQzc3TDdlbS9SV2dvNitNNHo5OXlKZncyTm5kS0Zq?=
 =?utf-8?B?cnVsRkVNVWZrUzRiK081TFBsWWRaazVGT2F2eVZFeDQxdlExMWJOWHZ5ZmFK?=
 =?utf-8?B?cG5xbkpndVJaMzJlYW5RdFMzYUdzSWt4NlpoZW1ValRuSTExMTZuY3g2c0hK?=
 =?utf-8?B?dnk0YjJlb0pCK3JVRmQyanBxbTBDQmtIZkxLSlFWRTFYOXJJVlFsQXhmazJZ?=
 =?utf-8?B?aXMxWlNTVldvNmNmUHczK3htUmJMREFNVHlIdzhRS0lrMTdtNFZaOEtzQ1Qv?=
 =?utf-8?B?bkNNNG8yRUJHV0lwL2IyeXNETHBEU2YzRHNrTUYyYjE2bHpwQWlNM2d6M2JU?=
 =?utf-8?B?MVlrK2JIbms4anBjTHNuRml6WjB6aXpjY2RHbWY0aW9NVVJoSEJEbDg3NFVp?=
 =?utf-8?B?Qmg5M3F6Ung1Z3RIc3JXQklaQmJRWXgvRUNsUDRQTEhlVU5RZktzZkd1VWly?=
 =?utf-8?B?NTZjUDVYcGp2M1IyWkhUOWZmcXJEUmx6SWJoSm5TM3p2T2hKU01xUVZhSTMr?=
 =?utf-8?B?NGhMS0cxWG9lS3FDVEJCSlh4ZU9WY0g0T05MVVQxOEwyVWhBZmpTSWFRV2ZI?=
 =?utf-8?B?MFltdlhhS0JsVTZwU3V3NGcwUzJ5UUVVUTloY0ROYTZ6Y1BsNDljdG84T3c4?=
 =?utf-8?B?SnlEZ2FMbFpUM0FjOGJOUFNPaXdmSFpvVkVOUVNGOUR6bk9YN2liSFRWUUVk?=
 =?utf-8?B?K21JalFNYVVKU1JRbkNDakQ2cjRYNHp1ZWdCaG92U2hzZ3A1Q0lCa0NVS3Bn?=
 =?utf-8?B?R0lNU0E4U2dsTHV6ZDVIVnNxTVpVWlM2QlN0N25pNE9WSWFZeXVjdU9nSUZj?=
 =?utf-8?B?b2tOMFBoL1RyWWJyQ21tOGtWeFNPNysrdmM5Mll4V1NOYUZhSGJvdXN3a2tO?=
 =?utf-8?B?dnM5cE1semI4TXc3b3hGdlBGbmE1aE9FQlhPOUZMRzRmUTUvK3oxYW5tdzFY?=
 =?utf-8?Q?VCkoOz3olDeRnP5lYYFLAenwg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4787c5b8-25c4-4bc7-a88c-08dc97b9bc08
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 21:31:56.0379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+OonRE1Qjz2d8LHy+isbSROiR8uzul9Q7G9ANO24ZG+gE85sYGVT49E5cIkCdo/BNKgPY8ORwO4ccib8iljgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8885



On 6/28/24 15:58, Edgecombe, Rick P wrote:
> On Fri, 2024-06-28 at 20:52 +0000, Ashish Kalra wrote:
>> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
>> index 443a97e515c0..be8b5bf3bc3f 100644
>> --- a/arch/x86/mm/pat/set_memory.c
>> +++ b/arch/x86/mm/pat/set_memory.c
>> @@ -672,6 +672,7 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned
>> long address,
>>         p4d_t *p4d;
>>         pud_t *pud;
>>         pmd_t *pmd;
>> +       pte_t *pte;
>>  
>>         *level = PG_LEVEL_256T;
>>         *nx = false;
>> @@ -717,7 +718,11 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned
>> long address,
>>         *nx |= pmd_flags(*pmd) & _PAGE_NX;
>>         *rw &= pmd_flags(*pmd) & _PAGE_RW;
>>  
>> -       return pte_offset_kernel(pmd, address);
>> +       pte = pte_offset_kernel(pmd, address);
>> +       if (pte_none(*pte))
>> +               return NULL;
>> +
>> +       return pte;
> 
> The other levels check for pXX_none() before adjusting *level. Not sure what the
> effect would be, but I think it should be the same behavior for all.

Agreed. It should follow the same logic as the previous checks.

It looks like the *nx and *rw should be updated, too, right? That seems to
be missing from the change that added them.

Thanks,
Tom

