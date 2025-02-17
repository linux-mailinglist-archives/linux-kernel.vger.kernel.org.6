Return-Path: <linux-kernel+bounces-516969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EB9A37A56
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 05:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3289188ED1E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 04:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E1B15B554;
	Mon, 17 Feb 2025 04:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1n/czlAc"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388B75C603
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 04:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739765454; cv=fail; b=VsGJj7WIINwV7HQwe/N2CPSysESVaKqb5blnwUW6p2+MSL6jGRd3cztDeu0rQBy1x9QCIAOF7Z3qRX/MP6h74KDXOW+F6CcXUUIutWcgHb6Xpkkzb2R84rGWmyel4UJRZ7+oAphZoOqdFCUSfpFWWReHNrF+Vmu+K9DhbBEDuDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739765454; c=relaxed/simple;
	bh=V9cb8+G0joJA6LqI2GLX0FaCAoKVlOrN839o1sY2qn0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uTnW1LQjHMIZc40LKundYm0ctZCDORYhpr4P1R22RPGsPi5mPaEh0OXINgCKAjQ5US6xzo2911D0jimmGFhJoPfF0sTS7y0CLIdEBZ+Hx8VVEVpLzkjw/HPOizyurN8j32TkLz8WyoM3GUujTaAiZVLNNGR8fSxmckbHQ3gumQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1n/czlAc; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQTJ3zIfk95WNkrgXmjDpqDuG9sImB4MmvmkfTw1UdKbGVl3Jd2zDDVYUc6xUAvbNaMHEkEYgAkxvo7gvgR96eqwgFkQwT8zJBOM2+3kDd3pqI4IiH/SCQnZyclpds4OepvmqaQkQVZfhvLMvJ5yVbOG0i2cf34x4ztNnCSf+lvw1QqgWrfW3PsXGQp9ReUU1V+LeDzZaYCL7Y652PTcu4CaTZnPCXrByJaqUIimMctc8nhR9O4c52VpyjUPfC6UxG3FKwziCn0CF0Jem6HEEoe91+XKHnECUMP7iMBUSmaVPJDNUmn2WECRzwAQrG6pho7BYF84fVBluHzRoSxjRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epfl23qaw7miR+9mBXHL77LyDCdj7vJhJo+wd4WFAH0=;
 b=xoeXGj+DoEp40EcQzPBKQoEhPC6pgGQhrkm766vV7BsXNDFoXupn0fEWrhKJBgi3nwKz8gwgf2n8dgok4ruYIvxMt2+4KsJXaOm1KocXsJv/XyIxLI0wqfEioUZgR0iDqzwiB+VegCYTNaNAoZpNzApjgJuJvmAXPX0mGkfUB8tkDfOuydFzCzUwwQoGL2XyjjGeSgmFYORJ2xWQlBKhODuK7pzF94H9AuaEBK/GSlOf8ZRG45wRZ9zkiqrACmMhjNA1N4xWWvglIkNv55PKhW971+CCcpzWkuOS46kRdcH/ED4ptIlx4GWaaeFoj+syxNfMngeUkPU00m8dL+vn1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epfl23qaw7miR+9mBXHL77LyDCdj7vJhJo+wd4WFAH0=;
 b=1n/czlAcXkX7ea7P5TlSIKar7v3dV3QFS/kMX03bBhEJdCNijwCQazAtZ0ccoHwtZ7x2aUFA2JxsNi+CjmkYHTOA4GH5foidAsmu49Z8Dlk+U8pozrKs+a2doZj5CBNmuC1jk7hsDQFZb7bqhAb/l+UnCtz7AsbQQCUL6IX8BY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by IA0PR12MB8984.namprd12.prod.outlook.com (2603:10b6:208:492::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 04:10:50 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%7]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 04:10:50 +0000
Message-ID: <f091e09a-1f39-48ee-8968-8f616d8102a6@amd.com>
Date: Mon, 17 Feb 2025 09:40:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Unifying sources of page temperature
 information - what info is actually wanted?
To: "Huang, Ying" <ying.huang@linux.alibaba.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Raghavendra K T <raghavendra.kt@amd.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org, lsf-pc@lists.linux-foundation.org,
 gourry@gourry.net, nehagholkar@meta.com, abhishekd@meta.com,
 nphamcs@gmail.com, hannes@cmpxchg.org, feng.tang@intel.com, kbusch@meta.com,
 Hasan.Maruf@amd.com, sj@kernel.org, david@redhat.com, willy@infradead.org,
 k.shutemov@gmail.com, mgorman@techsingularity.net, vbabka@suse.cz,
 hughd@google.com, rientjes@google.com, shy828301@gmail.com,
 liam.howlett@oracle.com, peterz@infradead.org, mingo@redhat.com,
 nadav.amit@gmail.com, shivankg@amd.com, ziy@nvidia.com, jhubbard@nvidia.com,
 AneeshKumar.KizhakeVeetil@arm.com, linux-kernel@vger.kernel.org,
 jon.grimm@amd.com, santosh.shukla@amd.com, Michael.Day@amd.com,
 riel@surriel.com, weixugc@google.com, leesuyeon0506@gmail.com,
 honggyu.kim@sk.com, leillc@google.com, kmanaouil.dev@gmail.com,
 rppt@kernel.org, dave.hansen@intel.com
References: <20250123105721.424117-1-raghavendra.kt@amd.com>
 <20250131122803.000031aa@huawei.com> <20250131130901.00000dd1@huawei.com>
 <87h64u2xkh.fsf@DESKTOP-5N7EMDA>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <87h64u2xkh.fsf@DESKTOP-5N7EMDA>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::7) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|IA0PR12MB8984:EE_
X-MS-Office365-Filtering-Correlation-Id: d41ad7f4-eeef-4e61-c414-08dd4f09100c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTVzMGl3emJ3VVdCNnVoN3ZBWmQxMmEzNyt2RThxaGtZbzZFWEp4cnF3VnNy?=
 =?utf-8?B?MFBMMWxOdFBHRDNoUjFJdW9LQmI1cmhiTXZBOWthYmFhbDE1bG9ENnI1VzJG?=
 =?utf-8?B?RllNOUhZRWkvQi93a3ArVVlVeFZDN1d5bDl4VnFVZG9VUnR6dXpyN21qcWF6?=
 =?utf-8?B?MEFpbGkvcm40OFFTcDcwRXR4QytXUnVCSDBMTGNmQWhKM2V3aU5sN2JDNUNq?=
 =?utf-8?B?RG0xRTFFL0daOXZ0MDlyeWFNR1I5R1VYbWJaTW90YVJjUjJCdGx3NFJmZFpK?=
 =?utf-8?B?Z0NEQzlpaTZtNkUveER4anBFRndMa29MNzAzQ3A4M3JjbEcrTWh5Y0hyVzVS?=
 =?utf-8?B?Y0JQTnJzZEVaVnlGK0xERDhTUUNDWEl3NnpiQitvd1FVTkhxTWQ0Uk50eE5m?=
 =?utf-8?B?eTZxVm0xbXB4cDBpM2M5Tzg3UHQ1bk1VNmZlczJrMzY0aDRBM0hEd1V2WmN5?=
 =?utf-8?B?T2RXUURVMW1tbDVJN3pULzFXaDN6ZVJXUUhxQlNxN05mU282VHQyb2NxRllj?=
 =?utf-8?B?RkFweGQyZjJodDNzTTJTSnNKVVVEVEt3b2dGeVdjbFJWRXA3bHpWbkNVZVlG?=
 =?utf-8?B?cGtMdHV4TllkOC9nQ0Vha0ZEYW9YZVJUeU55VUJwbzE1TEd2MG8wSE5uUy9r?=
 =?utf-8?B?OE96K2U4UDB3SGxBTmdCaEcxSTE0ZCsrNDhxdzBNWElWS1phVkFpMTNORzF2?=
 =?utf-8?B?TjBoT3hKNXh0WTZQT3hhK0FISnhzVGhta1VOOWEzQXNHVmtuOW9XN2l0SEdD?=
 =?utf-8?B?cjlVRXpJc29aUmxNb2xFdXZBb0J4ajJhVXZJUHZTVUl0czBRSit4RW81S0ZF?=
 =?utf-8?B?OXc2dThzMVVZV1BhcWFKWmo5Q2dZeFhlZWZkVGRwNGNaQkdyM0tielV1VFVw?=
 =?utf-8?B?a1hXTzFGcHFieSs3bjQyUStQZ0hzNXMwckJHWG1Xamh3QXE5YXhnOUhrakF3?=
 =?utf-8?B?U0FWZnFIcHUyU2Z4YjZqY0hpL1AyQ0Q4S0M1SkNiZFFRSjVTT2cvSEZDTUNJ?=
 =?utf-8?B?bC9reHBKOW0xd2NLaCtacFJyRFlNUGx6WVdnZ1VEVHdJYzRURW1CREsvTjVh?=
 =?utf-8?B?SU5OSEpBaENWZmQ5VCsvSHpvdmMyNml0M3lqd1VsMWc0SERiWDhtNCtNWlNS?=
 =?utf-8?B?Y0VkSUpWcUZ1TXZnbzBJcUhmTmt1b3Q3djAyM2pLTlBXM3drMzhwOWRVbnVV?=
 =?utf-8?B?WWlBTkpnVXdiLzdtYWdUS0E0K3dWa045UlB0MWJmVXJwTndVWUxwOGltS1ls?=
 =?utf-8?B?NzVBc2I2S2cwODlCZjloSXBDSUIzZjJlckpIcVo3NmsvQjhvR0VkUVlhZFhj?=
 =?utf-8?B?VmhBdnlzWVc3aS9aVW9ENVlSc0VZM2N5d1IvdE1yUThXd2VvajdrN2YzTkhS?=
 =?utf-8?B?aDBJTEpGaXhlTExTd05HaG8wQ0Jnd0pRaCtyWXlBTHNlbkVRaDEwaUI5RmRH?=
 =?utf-8?B?TlVRQ0tPTklka0FQTmdVbXpqVDR2YWh6SXQzLzVhZzlyd0Q5T1dKZ2tORWZS?=
 =?utf-8?B?QVdzVjhxRi9VbnVNL3lzcUMrMnU4VWRaQy85UEFTOW9jdm51SmwzRlFQV095?=
 =?utf-8?B?c1pZUHB2Zlpyc0JCVHZNeis4L2k5ZTZpWEVnUzdDeVpudGkwc3J3OFF5Y3Nk?=
 =?utf-8?B?bkphY3IwQmJsL3MrcENsMmtmQ0lvdng5Vk00ZGVvTU9pZE43cW5pdS8zeDY3?=
 =?utf-8?B?K240NFc3UjRRcE5hbFZ2dElubjQvSnVpSU43QU5zUE4vQm9IVWVkSm9ERGlN?=
 =?utf-8?B?Rkg4L0psQTA4TzEwVk5GWlZvdzZDNCtmYlBwVEwzeFlncFBhdXdtcVJDbm9i?=
 =?utf-8?B?YThKTTY5a0NoUUlpSlArUHdoMllINkdzTXRUUlFxTzI0OG9FNEpyYWRmblF2?=
 =?utf-8?Q?iKsLpiTH3+XA3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWJKNitOS3FISlZxTWZ6RTh6U0F6SS91WFR2QzRMWmtQejBDVzdQVGprSFo5?=
 =?utf-8?B?blBwZGRTVFRMT3dscEpkdE4yNGtuN1kwWlN6ZlBIdjh0dXVMS3ZIWXBpNkht?=
 =?utf-8?B?Z29hMTlCMVhBbXRhVkkrRW9hV2tWa1IyQkdZZkpRYldzOGhPVkVIUW5ZQWNK?=
 =?utf-8?B?SllTWTN3bkVtMnFKcmQ5aU1VU0cxcUpWbm92MzFJcWc4Y2FnNVBtd3VkQUtZ?=
 =?utf-8?B?S3dBWkJuTjI3TFhoQUZZVG1OWWw2aWpnZHhQYzAzcWt3enYrOFBCMzZ3TG9V?=
 =?utf-8?B?elN4VURJb1hPc3puTE8yNnVhUFhIblJlaSt0d20wOElNd2hqWGhJY0tKZEEy?=
 =?utf-8?B?SnVFL09WOFVDOXY4MHJUc2NscHZadDZoRVI5aXNUdnRObTNJSmMwODVram5w?=
 =?utf-8?B?YWV5WGl2MENUbmd4R0MrNmtFZHJDSFBlNTFyREtyaEFsVmdqYkY5YlkrMEJm?=
 =?utf-8?B?Ykl4SUYxMnV0SGlkMUxoMVlwYWtHc3o4ZUNnWlQ5TjY4UjJCeHp0RXhjNjhn?=
 =?utf-8?B?R3diZmFEU09UMVBMYWdqa0ZRbnd5ZUFBOGo1T3RrZ1h4Mk9SSmJ6dUdVU0ta?=
 =?utf-8?B?VE1ZbENGSXNWZUxibXJhNFVyQ0drZlZRQ2w5UHA1eTNlZmhoc2tTM1RGanJQ?=
 =?utf-8?B?SUlFY1ZuVEF1ZDBrT1N6RFhWRUc0ZkIvWnR0QlNwYlF3ekc4WkNnQWFjOFZx?=
 =?utf-8?B?bW9Qem9hY2o3d0hnRTBpVUN1akRSc1dFL3FrWEgxM2xiSGkzSE05ejZXMzJ6?=
 =?utf-8?B?dElGWHN0R1g2aGREY09jVldSZDVHNUJmZitqQVRGcWJZRmRKTXlKbzg2OWI4?=
 =?utf-8?B?UE5jUERxOG1TZXMza2RNWnZlSCtvS3Y4akE2YVBYSXprMy9kMDkzSEE2OE5L?=
 =?utf-8?B?dHp6Q05BbFh4bEc2ZlRjV2VpNXI4eGZzNW5zbmN4U3JOU2hKT1h5MFlQRjJn?=
 =?utf-8?B?M2V2ZmFuT2xsdzdENXpvNFRoQU11K1hFOEI2ZVpNOVdLNnRWTjZnTkF5YW9l?=
 =?utf-8?B?K0REb3l6aWJoaXlBaUVoQSszQmFLR2oxK2ZJcXJ1Rmx5ZnAyY0pPTUUvWFhH?=
 =?utf-8?B?YnVxVGRad3FhOHRLcnIzOC90eHN6Z2pvTEltV29jWlA0cFM5NTJKeXFCcG0w?=
 =?utf-8?B?ZnR6dUpoeXVEeS9vczFjaXdiamgzWUsxQ2hQQkxnd1lVdFpTdEdiNFhaY3dM?=
 =?utf-8?B?alk5OUpuU2ZWVVJjcjNHa1RSSjZveGk4NjhaMkVkeFJsZVo2QTJhUkpDeHkv?=
 =?utf-8?B?L2UvN2xFL0hCZ1VkTG9La0Q1cklzS0hEQWRBWkI1NExjZnUzQkc5MHZUSUhT?=
 =?utf-8?B?ei9jWVJNbzFFYTRSaUNXV1pjMkN5ZmJHS2p5TVpxV2FnQkRGeHlqTkZvV09o?=
 =?utf-8?B?OGRrZUJhdGFtQ0FMTE9vb1V1MW1jY2JSRlRBNFJtSHBiZ1JHR3E3QlB0WS8w?=
 =?utf-8?B?djM1bTlmRXJQbzBaZnRURy9wSzdzM3RhdGd6OW02akMvTVNnbkZXNGxoS1A5?=
 =?utf-8?B?eWNQNHI2NE9WSU5UL3ZFeEhzVmFoN1gxdUNkUU5BR0VueGZ3Wnd0VVF2bDAx?=
 =?utf-8?B?bHVLbHlPUGMwd3BiSHA2YzV4YVo0ZTh4bW5sOUF4S1V4U2pGaFcyVGhQTEVj?=
 =?utf-8?B?bVpEN2RIMEFPdmpIOW9ESEQ0UWJCck9Pd1FYL05Ga0xOOXlkRG9qUzVpeENj?=
 =?utf-8?B?NnpWN3paUnJFZnpwRk5DNndVYjBreVVDV0dLMHVZY1RWN0h6OUNEaUR4SkJx?=
 =?utf-8?B?bWVkUE1jZWc3dG56VS9mR3dCWXZYKzJjckhWVURtOUZYVE9RWFhJRWFMNEpD?=
 =?utf-8?B?VWsrNksvSWE1VTNQOVBRaGpIcDNCZGVHTG9rRUwrMFBHQ0ZKSkMxMk1hNHpR?=
 =?utf-8?B?MHpYbHV1cFRIVU52Vk4zM2ExWnl1b3RveXpyR1ZwWlRjMWd4bkhwWklib2lr?=
 =?utf-8?B?MFpmc0xSNS9sempDVCtTMitRWHNNQ3UwbERzSlJaVE9QYUMwWmo0Q3JlWUtv?=
 =?utf-8?B?Vk1DZ095NXJEbWRRdEtzY0krbzRKMGRDUjV4NmhkMEx5YTZWT2pPRS81YVM1?=
 =?utf-8?B?eXNSTFdUV2ZNVXp0WkVnSmFiM2x4R2ZqeU5QY2JNNUNHdWt4SW1uSTJOSzBy?=
 =?utf-8?Q?ScOAUDnevNfc2Lv1dsoLUSM6Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41ad7f4-eeef-4e61-c414-08dd4f09100c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 04:10:50.2278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iUQ96JottH/FK5X54Ztpo31DdizDZesaSF3llF/bQuHaq0uhudvPby/Kw4BqdLmft06gWGy1yyLzaOHsGUJF3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8984

On 16-Feb-25 12:19 PM, Huang, Ying wrote:
>>>
>>> 1) Give me up to X hotish pages from a slow tier (greater than a specific measure
>>> of temperature)
> 
> Because the hot pages may be available upon page accessing (such PROT_NONE
> page fault), the interface may be "push" style instead of "pull" style,
> e.g.,
> 
> int register_hot_page_handler(void (*handler)(struct page *hot_page, int temperature));

Yes, push model appears natural to me given that there are producers who 
are themselves consumers as well.

Let's take an example of access being detected by PTE scan by DAMON 
first and LRU and hot page promotion subsystems have registered handlers 
for hot page info.

Now if hot page promotion handler gets called first and if it promotes 
the page, calling LRU registered handler still makes sense? May be not I 
suppose.

On the other hand if LRU subsystem handler gets first and it 
adjusts/modifies the hot page's list, it would still make sense to 
activate the hot page promotion handler to check for possible promotion.

Is this how you are envisioning the different consumers of hot page 
access info could work/cooperate?

Regards,
Bharata.

