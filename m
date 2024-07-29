Return-Path: <linux-kernel+bounces-265127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AFA93ED0D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215A41C21868
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 05:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED5D824BC;
	Mon, 29 Jul 2024 05:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uTZowZ0I"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFBC817
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 05:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722232707; cv=fail; b=EARcis6q9tQ4GNWRYrqSuMyMYT284xiIM7qb6AV/c+XOuo25rDHtm3jv91DK6LflH2G8YVbVxT2kBfKdHa9bNb0hXNnQDc7Oe/n5u++Pt4+/WRF0AbhAAGetM4HeSe1klAVKz/1VCadthSQiTaKhy7l2AgrsZxRfM+lPvzw6Y4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722232707; c=relaxed/simple;
	bh=lS0t3FHA7gbaery6ZtL0JWcycCoF014VKbtluhSV9B0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LEbwZGe5T8OYrVubEjXCtzipgIkkcmxKOlZjyK6ErOmt4/Hpyypq1Yysa1ibPgg5mGyQvF1zV+d5CEdIzqIN7kEEn7qtI7fbYP5G5eRAfixOVvYifiNTmrcw6K2rrhnZjgmReTxWeV7gEne1cypM+CWprTyKMfum4bGFPAPM6ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uTZowZ0I; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yr6PlCASN9gs20GrgkRMaMjqrQ6y9ZpuNr/SDTmF0VK8pD2LY4usdhSYO/cDASrYj3k8dZuPR+DFQxWuSXRQeNDlI/lYywuL0TTL/+V8fqy8ZyLbCHafsegrR2dpbeiRy4RstEh6+TAqnE13jEyiaco4CMD6sTx7TfLI3LY4CmtbYQ4WdBup8hBeq/QdVsFQWa46fYsRFbUzcaXsWcrbjhk9cULwZbcOZgoQGeajBzTGNJ5ByDsHRCf9fTT0TuSp2OSqqmxt+mCExh3PFullc5ZuK/coax2Vxp4jA4zewTZi08VqrW5PMBT0DLzvezoGvj5XhiCBa/YceMTkZW9d/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pO3CC6KG8dd2p0oiS5RYv1JM5piLwaYJd5Y9U9FAmr0=;
 b=MBn+xXXmFRPKIMatOyxMP+e79Tzq/oxZIm0Z7keeEHzNZjqGWFApsfoRnpn/xBcWwDhCx4ZnPf+8iDpUwRXIgrHnIB87s8qUqo0NYwQR4vdxsPoah1eeRk8wSiNWk1koPDm+1YMr7OjusE/nP3dKiE3EBEAoWveZ/pQVzS1zMmf6Jt9cuk6GNjYATcEjCY5wS69A1ThaWhDb8A0aQBntHE0IT3Gxd1QEGeldAsVwmjzKQcN0CmtvBIZin6P38NZhXYaipjN+Y/a/lKm+f0Z9uEVAfpznbrimwPAF+s79GDIMbeOz5dwMkMhcFG7yL6rpmDe5SCDTidJBAkqK/QdNEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pO3CC6KG8dd2p0oiS5RYv1JM5piLwaYJd5Y9U9FAmr0=;
 b=uTZowZ0ICy/p7nJZGEgkuc5doiw65X/P0oiJxKb749EYmfsVs/PTKM0Y9J5YO4++PuuP/CQ0YP5Xne4Q6T1gFpoYF8JbusLctbWj7GdyefIO0WuRnUevXUAq8Vo8bkOx1NH1Btp7c/TYPV7HQoNniWXuMiKTZpNfgkpEuKjy60Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH0PR12MB8049.namprd12.prod.outlook.com (2603:10b6:510:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Mon, 29 Jul
 2024 05:58:22 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 05:58:22 +0000
Message-ID: <0dac25a8-a178-418a-8282-83597b5e64af@amd.com>
Date: Mon, 29 Jul 2024 07:58:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: xilinx: Add missing debug firmware interfaces
To: Ronak Jain <ronak.jain@amd.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240711045651.3309975-1-ronak.jain@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240711045651.3309975-1-ronak.jain@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0044.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::16) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH0PR12MB8049:EE_
X-MS-Office365-Filtering-Correlation-Id: 069d19ba-52c2-42a2-12f5-08dcaf937446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHpYemZrd2RHWk5idlp4UUN4REI1bjZjNG9TVVY0akloYmxMcjlZbnNzWWJy?=
 =?utf-8?B?VE54MVRjMzErRmc3RDErNHJYNTM1c1FyV3k0MTFLTUI0L2wwN1Z0eEhLNWlG?=
 =?utf-8?B?RnJmandqWWJHenFxQ1BpVXRxM0hyaFF2TE9mb0txOUVVbjcyZm5UZ1NITG5K?=
 =?utf-8?B?V0Ztd2l5a1VUWmY5d3RKcjQvdUlRbE1tUFJSQUZjaXd6ZzFCQVBZbTZuaGM1?=
 =?utf-8?B?b0ZmZjhYMitWYzl0QThEUklWVDJFWXVSOHR0Wm96UXZZS0pvamNLT3YzenhM?=
 =?utf-8?B?L2gxK0MxRWtqVSsxVjUvL3lMMTlybzgzS1V0L0k1ZVA0d3VPb0NnUlNUcWhp?=
 =?utf-8?B?T2tqOXNVMWJMQk9zQ2pHNDFlV2xlWW9FQ2JPWWZ1NGIvcUtlYUJyUTAvSHhu?=
 =?utf-8?B?V1FsYWJDazBJV01kTlBESmkzcE1lb2dxSVR5WUU3cStWYVRlYUtHTWt4azBI?=
 =?utf-8?B?MUtXb29HS0lHbUFMRVpTWllpdy9QNGRHOElOaDl4bHVNOFBFbGk5dTREOExX?=
 =?utf-8?B?K0szRVVoU0VueGk1Mkp6TXdaOXdnc1JTcWFNdTRQNHI1aVowL0x4dFkrek1P?=
 =?utf-8?B?UFdpcllMbGR6SWZwaGp1MlVSQVFPOFNSc2J0SWszallUSkpNbXJHVjd0b3hR?=
 =?utf-8?B?Wmdkc2JvY3NRVzV6RTQ2ZXJhVG04WjlnaUVPNnljUE16SUVwZHRKR1YwK0xW?=
 =?utf-8?B?aVhVUWJBTy9QYllUT3A5d1A3RlArVFNzVDBqZXllSWxZV29BVFhqY09WTVNI?=
 =?utf-8?B?eHhPR3hnalhOSFRFdlhydEJROFNEUEJiRjNDM3pOWnRzVFViY3BqRjBoWGJv?=
 =?utf-8?B?aHFPTlUxb2R3a0tNUFhtYXV0eEdpY044a2RPQ0FReHRYclRyK201ZWJxMUov?=
 =?utf-8?B?THhCMW9Sa3J1V0ZFR2JtV3lqcGZBNDUxaWlTUitNYi85NVhYWDN6cW9PNEI5?=
 =?utf-8?B?L1U3RWNjWlFJbjJlWVQvVVlzNTdyNlkxODJtNEtTTGRuMHQ1L1NuWmFuYzdG?=
 =?utf-8?B?RjVtbkZFNWJPSHJ5L0o3N3RwQ09ocnhFWkcraGM4SlU5SFR2akRWK1IzRldJ?=
 =?utf-8?B?bG5QYUh1cmdlQ1BMVHA3VEF1anI4dXkzWXZ6UjVyaWtUMEltT09NbVlmWmY4?=
 =?utf-8?B?UkJQNE9FaWVNUm9iN3NNeEFjTWlGN2JVTCs4MHJzaGdZMmh5eTI3UVVKWkFX?=
 =?utf-8?B?aTZRZGFHRjdUN0RKcms5UGJuMDl6NHZKaUUyUVVsSEdRRWF1a2lIdnYwa3BS?=
 =?utf-8?B?cjRMTEZTV2lraWh5K2RUOXg3eUNBV3U3THY3VXd0TC9jS1Bsbk8zTHZWYzZs?=
 =?utf-8?B?NGUwTS92WEszeTIwVmV2Mkw5TjdaaWhzcHNFdElZZEhWTUo1cGkrNk1yK0d2?=
 =?utf-8?B?emxTaFdVa0lJMUhoeHpJVmpOMXlmTXVpbElBY2xsY1lsaXU4ZFhxSzAvTmND?=
 =?utf-8?B?Uy90dWpycDNxQWwzaVhseFFOS3NJYklFNGJNTGhMRUg4U3N2UEk2b1ZHN1E2?=
 =?utf-8?B?TVZld0h1UVBKdlBQUWJHd25WQXdKR0FnUlVnalh2bmNXTFVQNldxblU1TFIv?=
 =?utf-8?B?N1hETUkyZ3VvdVVpRWRFSEk3bmlwcGt1S0o0MTI3dlRWd2RVczlIVXJIWFhw?=
 =?utf-8?B?SXVpdnNyanFtanJCUWR2MEVIK05LZU81ampBYmtUdUZrTlZxK21CZ3dIYWMy?=
 =?utf-8?B?WGVQMmk2RDZTek1mTWJ4bXlHUlJmVEFLWDJ5Nm9VcDdpelhjK2ZsdkRsTTR6?=
 =?utf-8?Q?h+6IjqXam5TeRAjmZLYMPppH8fCCrWTYMf/uiP4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y05oRmtPZ2V3cFNSeEJobndoWEFWU2xEUENzWENsTHM2cWx3ZFYvZFAwN3Q3?=
 =?utf-8?B?N2FyZThSWE5jYXdJTUlJWnczRjJNRkpzQk8zMjVndHZlUmQ0VEpBSHF0OGIx?=
 =?utf-8?B?MmJ2L01XZnFSbzQrSXJhQmw4ZW10azRETWxienFXbFBjcG1tUDFacnZ6Nmk2?=
 =?utf-8?B?UnlRY3JFNjZZdk5Yd1J4VjR5NVc4VjBEYVlnMll3VzN0T0x6bzBUWitaSHdv?=
 =?utf-8?B?L0JySWViaTd1b2JoQ1FCNTA5R1BiL3ZTNEFQSkQ0MFl2M0dHTTZvWjhHSC9r?=
 =?utf-8?B?blJBTlZDRzJxbHB1Q0pjUlUrTUl5WGdJcE5rb0VWTForL1FBaktDRUJjWURz?=
 =?utf-8?B?OUI3WGsrQ2xiTTQrbVJkMmJlcGFsWTg3ckgzczVpN3dlcGZhVC9JNkgxbzVo?=
 =?utf-8?B?UWZZNjdxUVc2WExvazFGdDcxb1BkcGFJbU1UWTBOQVI1N29XTmVqVkw0NHZZ?=
 =?utf-8?B?VUhjcmFxcnVWcGoyVjc0RHJ4bTFZdHQrQWZwU3Y0bmt3bzhra3lHa3lFcUJi?=
 =?utf-8?B?Sm9vOTg1VHBMYy81bVhoTlc5YWlsZytKdlIzMjh5c2RnUGFZeitxZDc4N2Zx?=
 =?utf-8?B?QnU2RnRSNVVwK083bWZteFV1TmZDZVFnaGFGSU52R3BwRm16UnVmTlZlTFQx?=
 =?utf-8?B?TmZtNkZEV0MveXNlKy82bjRjUXNia2MxbnJCaHFwdkE3VVA1TnlSY2ZGQ3NK?=
 =?utf-8?B?MXdYNDhqV296cGRVUzF4WWdERFZXc2tRQVZUbnpVUGpPMEVoUHEwMjNoYzFE?=
 =?utf-8?B?R1VTT0NOZUhGUU04d21maXRBa0phdWFGNGJuU1pWSjRYeFJZRHpzTFNSaEJ4?=
 =?utf-8?B?SXR0czc0b3Z1a2IxYjltS1NabUVUdVhadjdyMzV0NWJCc1ZwNCsvelJFMFo4?=
 =?utf-8?B?SW9qNGYyNHhxdDh1R29MakdSL0lXaTJISWZEazloVWU0SXZ5YzBqVlNHNmVS?=
 =?utf-8?B?TW4wdS9uZmZmTjM2QTdnUCswTkx2WHo1MTlkUGpsRjh3QlloWmpUQXQ3TlZo?=
 =?utf-8?B?UTcybUlmenJob3l2KzkrcVVsOW5CQ1JXQkEzRk8wUUNQMktuOVRMY000Qzlh?=
 =?utf-8?B?d0FaME14ejNSUnZ4Z0I0VEhkUGxPYWxIZ21icndjN09FakR4WmFSMUtTR3R6?=
 =?utf-8?B?Q0tOV2V0RWtlY1pwUkxuSzI1UXhOWG53T0hjVnJTUG0vdURsTlE0d1BadDcx?=
 =?utf-8?B?THlZUXpjKzQyZVk1U0xxMzVEalpaWk1GYnRvSlVQMGhnZ1IzTXJENzhRc0hH?=
 =?utf-8?B?M0ZsSkZMOFpBR0ptU3pRc1d0R2l1bVpYL0J1YXFMWGVCb0VpeVBMS0tNK0hQ?=
 =?utf-8?B?UVBlN1hza0drK3VDalhZQ0Q0Ky8rRzl2ZVFpdXVTUlNnRTdMMXRadWFONFJV?=
 =?utf-8?B?ZlZZbGRwV09xWkFjN01PQ3JKeEpFaG5rQ3JqL3NRblFBOVVvTjdpWVN5TzFV?=
 =?utf-8?B?a3NtMmFLV1BFMzRFKy9UOFA2MTNiUExGL2REUUNJNmZKL0IxRzFGNE5aYlJ4?=
 =?utf-8?B?Z1F0YTRIcW4yNjNCUTN0ekZZS1N0aWU2Y0RtK0VHelJQc1JiMmkrWHQ2V0RM?=
 =?utf-8?B?V09IWnhBNXd0SEMzcG9oZmw0cFRYdldYYTlMeDJpN1Z4Yk5WYUFrZk9LdllQ?=
 =?utf-8?B?eEE0aVNoaHhGc2FVYmtvT0cyc1RYUFZSeUtFRnFyWkFBOWNsekR1T2pzRVAr?=
 =?utf-8?B?VHNZOE8xUjlKUnozZ0pCWXA3Nm1aYVVrNEE3cnVwS1VVeUx3dXltUnprOXN1?=
 =?utf-8?B?NjBaWW5DZmQwWnF6SHFoQ1AzdFdMcHBmOU9VK052VkpKS09UNTBJRXpMV2E5?=
 =?utf-8?B?T0tIRUkrdlBodDBHbENTNXpPSldUM2NqYUMyVGhudGdUK3k5U0tvNkdCa3Ni?=
 =?utf-8?B?dUxDd0hhcjBwU1hsTk5qQTYxQTRXMldXUFFZN1JWMzVQc3hUcUsrRDVBUXVD?=
 =?utf-8?B?VnhqOGlZVTNVb3J3RzJFQmcxQmRlUm5tK2pkclVQdk5kbllKTmVaUTNRM0U4?=
 =?utf-8?B?enVybGI5QmJkK2pnTysvWGxHLy80ZnBuL0xtK2dGU1g0S21waUdJVE9Ba00y?=
 =?utf-8?B?cDN0blFkOUIrd1ZDZWtZcHhNRWpGR3MyYTliOXZXZGZmRFZyMFBsamZpZlBG?=
 =?utf-8?Q?PCPSY8EpZ4MIuG00n5MAVp83g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 069d19ba-52c2-42a2-12f5-08dcaf937446
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 05:58:22.6248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jK9qstaVWXSoInf53PChwiozj1CXj/WBPsEvu83tzrenw15lWeOSsiQqGu++Gs+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8049



On 7/11/24 06:56, Ronak Jain wrote:
> Add missing PM EEMI APIs interface in debug firmware driver.
> 
> The debugfs firmware driver interface is intended for testing and
> debugging the EEMI APIs only. This interface does not contain any
> checking regarding improper usage, and the number, type and valid
> ranges of the arguments. This interface must be used with a lot of
> care. In fact, accessing this interface during normal PM operation
> will very likely cause unexpected problems.
> 
> The debugfs interface shouldn't be used in the production system and
> hence it is disabled by default in defconfig.
> 
> Signed-off-by: Ronak Jain <ronak.jain@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
> References to the public documents who talks about the debugfs
> interface.
> https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18842232/Zynq+UltraScale+MPSoC+Power+Management+-+Linux+Kernel#ZynqUltraScale%EF%BC%8BMPSoCPowerManagement-LinuxKernel-Debugfs
> 
> https://docs.amd.com/r/en-US/ug1137-zynq-ultrascale-mpsoc-swdev/Debug-Interface
> ---
>   drivers/firmware/xilinx/zynqmp-debug.c | 162 ++++++++++++++++++++++++-
>   1 file changed, 161 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
> index 8528850af889..22853ae0efdf 100644
> --- a/drivers/firmware/xilinx/zynqmp-debug.c
> +++ b/drivers/firmware/xilinx/zynqmp-debug.c
> @@ -31,12 +31,50 @@ static char debugfs_buf[PAGE_SIZE];
>   
>   #define PM_API(id)		 {id, #id, strlen(#id)}
>   static struct pm_api_info pm_api_list[] = {
> +	PM_API(PM_FORCE_POWERDOWN),
> +	PM_API(PM_REQUEST_WAKEUP),
> +	PM_API(PM_SYSTEM_SHUTDOWN),
> +	PM_API(PM_REQUEST_NODE),
> +	PM_API(PM_RELEASE_NODE),
> +	PM_API(PM_SET_REQUIREMENT),
>   	PM_API(PM_GET_API_VERSION),
> +	PM_API(PM_REGISTER_NOTIFIER),
> +	PM_API(PM_RESET_ASSERT),
> +	PM_API(PM_RESET_GET_STATUS),
> +	PM_API(PM_GET_CHIPID),
> +	PM_API(PM_PINCTRL_SET_FUNCTION),
> +	PM_API(PM_PINCTRL_CONFIG_PARAM_GET),
> +	PM_API(PM_PINCTRL_CONFIG_PARAM_SET),
> +	PM_API(PM_IOCTL),
> +	PM_API(PM_CLOCK_ENABLE),
> +	PM_API(PM_CLOCK_DISABLE),
> +	PM_API(PM_CLOCK_GETSTATE),
> +	PM_API(PM_CLOCK_SETDIVIDER),
> +	PM_API(PM_CLOCK_GETDIVIDER),
> +	PM_API(PM_CLOCK_SETPARENT),
> +	PM_API(PM_CLOCK_GETPARENT),
>   	PM_API(PM_QUERY_DATA),
>   };
>   
>   static struct dentry *firmware_debugfs_root;
>   
> +/**
> + * zynqmp_pm_ioctl - PM IOCTL for device control and configs
> + * @node:	Node ID of the device
> + * @ioctl:	ID of the requested IOCTL
> + * @arg1:	Argument 1 of requested IOCTL call
> + * @arg2:	Argument 2 of requested IOCTL call
> + * @arg3:	Argument 3 of requested IOCTL call
> + * @out:	Returned output value
> + *
> + * Return:	Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_ioctl(const u32 node, const u32 ioctl, const u32 arg1,
> +			   const u32 arg2, const u32 arg3, u32 *out)
> +{
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, out, 5, node, ioctl, arg1, arg2, arg3);
> +}
> +
>   /**
>    * zynqmp_pm_argument_value() - Extract argument value from a PM-API request
>    * @arg:	Entered PM-API argument in string format
> @@ -95,6 +133,128 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
>   		sprintf(debugfs_buf, "PM-API Version = %d.%d\n",
>   			pm_api_version >> 16, pm_api_version & 0xffff);
>   		break;
> +	case PM_FORCE_POWERDOWN:
> +		ret = zynqmp_pm_force_pwrdwn(pm_api_arg[0],
> +					     pm_api_arg[1] ? pm_api_arg[1] :
> +					     ZYNQMP_PM_REQUEST_ACK_NO);
> +		break;
> +	case PM_REQUEST_WAKEUP:
> +		ret = zynqmp_pm_request_wake(pm_api_arg[0],
> +					     pm_api_arg[1], pm_api_arg[2],
> +					     pm_api_arg[3] ? pm_api_arg[3] :
> +					     ZYNQMP_PM_REQUEST_ACK_NO);
> +		break;
> +	case PM_SYSTEM_SHUTDOWN:
> +		ret = zynqmp_pm_system_shutdown(pm_api_arg[0], pm_api_arg[1]);
> +		break;
> +	case PM_REQUEST_NODE:
> +		ret = zynqmp_pm_request_node(pm_api_arg[0],
> +					     pm_api_arg[1] ? pm_api_arg[1] :
> +					     ZYNQMP_PM_CAPABILITY_ACCESS,
> +					     pm_api_arg[2] ? pm_api_arg[2] : 0,
> +					     pm_api_arg[3] ? pm_api_arg[3] :
> +					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> +		break;
> +	case PM_RELEASE_NODE:
> +		ret = zynqmp_pm_release_node(pm_api_arg[0]);
> +		break;
> +	case PM_SET_REQUIREMENT:
> +		ret = zynqmp_pm_set_requirement(pm_api_arg[0],
> +						pm_api_arg[1] ? pm_api_arg[1] :
> +						ZYNQMP_PM_CAPABILITY_CONTEXT,
> +						pm_api_arg[2] ?
> +						pm_api_arg[2] : 0,
> +						pm_api_arg[3] ? pm_api_arg[3] :
> +						ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> +		break;
> +	case PM_REGISTER_NOTIFIER:
> +		ret = zynqmp_pm_register_notifier(pm_api_arg[0],
> +						  pm_api_arg[1] ?
> +						  pm_api_arg[1] : 0,
> +						  pm_api_arg[2] ?
> +						  pm_api_arg[2] : 0,
> +						  pm_api_arg[3] ?
> +						  pm_api_arg[3] : 0);
> +		break;
> +	case PM_RESET_ASSERT:
> +		ret = zynqmp_pm_reset_assert(pm_api_arg[0], pm_api_arg[1]);
> +		break;
> +	case PM_RESET_GET_STATUS:
> +		ret = zynqmp_pm_reset_get_status(pm_api_arg[0], &pm_api_ret[0]);
> +		if (!ret)
> +			sprintf(debugfs_buf, "Reset status: %u\n",
> +				pm_api_ret[0]);
> +		break;
> +	case PM_GET_CHIPID:
> +		ret = zynqmp_pm_get_chipid(&pm_api_ret[0], &pm_api_ret[1]);
> +		if (!ret)
> +			sprintf(debugfs_buf, "Idcode: %#x, Version:%#x\n",
> +				pm_api_ret[0], pm_api_ret[1]);
> +		break;
> +	case PM_PINCTRL_SET_FUNCTION:
> +		ret = zynqmp_pm_pinctrl_set_function(pm_api_arg[0],
> +						     pm_api_arg[1]);
> +		break;
> +	case PM_PINCTRL_CONFIG_PARAM_GET:
> +		ret = zynqmp_pm_pinctrl_get_config(pm_api_arg[0], pm_api_arg[1],
> +						   &pm_api_ret[0]);
> +		if (!ret)
> +			sprintf(debugfs_buf,
> +				"Pin: %llu, Param: %llu, Value: %u\n",
> +				pm_api_arg[0], pm_api_arg[1],
> +				pm_api_ret[0]);
> +		break;
> +	case PM_PINCTRL_CONFIG_PARAM_SET:
> +		ret = zynqmp_pm_pinctrl_set_config(pm_api_arg[0],
> +						   pm_api_arg[1],
> +						   pm_api_arg[2]);
> +		break;
> +	case PM_IOCTL:
> +		ret = zynqmp_pm_ioctl(pm_api_arg[0], pm_api_arg[1],
> +				      pm_api_arg[2], pm_api_arg[3],
> +				      pm_api_arg[4], &pm_api_ret[0]);
> +		if (!ret && (pm_api_arg[1] == IOCTL_GET_RPU_OPER_MODE ||
> +			     pm_api_arg[1] == IOCTL_GET_PLL_FRAC_MODE ||
> +			     pm_api_arg[1] == IOCTL_GET_PLL_FRAC_DATA ||
> +			     pm_api_arg[1] == IOCTL_READ_GGS ||
> +			     pm_api_arg[1] == IOCTL_READ_PGGS ||
> +			     pm_api_arg[1] == IOCTL_READ_REG))
> +			sprintf(debugfs_buf, "IOCTL return value: %u\n",
> +				pm_api_ret[1]);
> +		if (!ret && pm_api_arg[1] == IOCTL_GET_QOS)
> +			sprintf(debugfs_buf, "Default QoS: %u\nCurrent QoS: %u\n",
> +				pm_api_ret[1], pm_api_ret[2]);
> +		break;
> +	case PM_CLOCK_ENABLE:
> +		ret = zynqmp_pm_clock_enable(pm_api_arg[0]);
> +		break;
> +	case PM_CLOCK_DISABLE:
> +		ret = zynqmp_pm_clock_disable(pm_api_arg[0]);
> +		break;
> +	case PM_CLOCK_GETSTATE:
> +		ret = zynqmp_pm_clock_getstate(pm_api_arg[0], &pm_api_ret[0]);
> +		if (!ret)
> +			sprintf(debugfs_buf, "Clock state: %u\n",
> +				pm_api_ret[0]);
> +		break;
> +	case PM_CLOCK_SETDIVIDER:
> +		ret = zynqmp_pm_clock_setdivider(pm_api_arg[0], pm_api_arg[1]);
> +		break;
> +	case PM_CLOCK_GETDIVIDER:
> +		ret = zynqmp_pm_clock_getdivider(pm_api_arg[0], &pm_api_ret[0]);
> +		if (!ret)
> +			sprintf(debugfs_buf, "Divider Value: %d\n",
> +				pm_api_ret[0]);
> +		break;
> +	case PM_CLOCK_SETPARENT:
> +		ret = zynqmp_pm_clock_setparent(pm_api_arg[0], pm_api_arg[1]);
> +		break;
> +	case PM_CLOCK_GETPARENT:
> +		ret = zynqmp_pm_clock_getparent(pm_api_arg[0], &pm_api_ret[0]);
> +		if (!ret)
> +			sprintf(debugfs_buf,
> +				"Clock parent Index: %u\n", pm_api_ret[0]);
> +		break;
>   	case PM_QUERY_DATA:
>   		qdata.qid = pm_api_arg[0];
>   		qdata.arg1 = pm_api_arg[1];
> @@ -150,7 +310,7 @@ static ssize_t zynqmp_pm_debugfs_api_write(struct file *file,
>   	char *kern_buff, *tmp_buff;
>   	char *pm_api_req;
>   	u32 pm_id = 0;
> -	u64 pm_api_arg[4] = {0, 0, 0, 0};
> +	u64 pm_api_arg[5] = {0, 0, 0, 0, 0};
>   	/* Return values from PM APIs calls */
>   	u32 pm_api_ret[4] = {0, 0, 0, 0};
>   

When this is applied on the top of v6.11-rc1 I am getting compilation error.

drivers/firmware/xilinx/zynqmp-debug.c:221:26: error: use of undeclared 
identifier 'IOCTL_READ_REG'
   221 |                              pm_api_arg[1] == IOCTL_READ_REG))
       |                                               ^
drivers/firmware/xilinx/zynqmp-debug.c:224:32: error: use of undeclared 
identifier 'IOCTL_GET_QOS'; did you mean 'IOCTL_READ_GGS'?
   224 |                 if (!ret && pm_api_arg[1] == IOCTL_GET_QOS)
       |                                              ^~~~~~~~~~~~~
       |                                              IOCTL_READ_GGS


Thanks,
Michal

