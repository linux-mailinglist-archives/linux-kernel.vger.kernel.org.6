Return-Path: <linux-kernel+bounces-347350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C818F98D189
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E56BB240D5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5F81E766D;
	Wed,  2 Oct 2024 10:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0I61qXPA"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3951D1CCB51;
	Wed,  2 Oct 2024 10:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866034; cv=fail; b=a8HZ0aqRY/rCBTZ/84/nZJwlGgQavxsM4ZthlabIJNWH29ecOSiQGGfEUu498fbRWG7UeaQc8K0ytDHlPYSPVBk2B/jsG3pgz603vat9Lu8pNh6ciPneolTidQMlFaSwHe/jPowRdWzlly7wLdGboUDOzZ5WxwTzoH+/9vvH6Do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866034; c=relaxed/simple;
	bh=5awQ/oyBOc33sVhHclXkvUJOLh4A1EhYOOmCJtzFfdg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VJGyNOZ6PKjS1/8o24ZQfdIdRcDbpyRNGKdDZwDsOEmc3npJAWtXqiPS8OWXp2VZ3QKvuoYTRv9ukWfqi7HesqQ+qzDiCs9QPG6npXZGu/ip/cJbEYWYLYJg9I2Gk+F22ml9NL5MmiUAnRktly6ZZm5i3kbHM4kTD/eoHYKKpoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0I61qXPA; arc=fail smtp.client-ip=40.107.100.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jn6ynlNIef3eMiarYpxihyxwcth3HdFgtreJjQWRUkDRMTdG9MDEkHHeknmE/H8cm6ki/EZNteJZIXQ8FHU3paAZLETGKEy8QMJthXLKdsSG7JBAh6+V8gYByV4CL62hRi5X1giCRokQHKVMyS80xQjkExArLM4V3BhhY0nZ1tNAVzpiOFoW2rQ+PfWEbVpFB+Lgq4rGSAk1HHLxZlwJqKuKEZPoRQaDjZHB0aXZ1SPoqmsxjM37bUAi7TdZUiH3qglJliN0IArKrjF+sX8Xu7/yub+F7Ly17MMcAe/g27rQRpQbLyVU+BeWL1eAsqUqHOU2R8k4GjzxbJUa+O9IYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uV5BfR8zaGJP2p9YG9feOixuw3rJT1LhA0HJv1VGkG8=;
 b=tY3PBoZupJt+CSN9L0wPVtMn5A2crwMxuiFokWcrK8gTTR/jB9N/3E3raD6YdEw448/8jO8Yr5PdHW9cZHH9XOR2JDrUKzkuF2wyPoibFH6ei20viEDh3a3UIv6sGckO6+lEn+4WZ4HID7ao8lw2Msy0Y7PedKNurd0aFTDVDiGEZ7Fnho+t56xys1p248cMiNJhYVYokDc3a/WPCWd09abekbQuur07aclW05STbI9pVhHKI+y1D/LYfq9tr27ZwjGtIRdwe6sO5Qv6a2/ti3pqH7C6vmKpBKTV5FZ47Uhh2RKqtDo7xytZpZIEWOJHXXUa57ALewaKY45F6/5CGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uV5BfR8zaGJP2p9YG9feOixuw3rJT1LhA0HJv1VGkG8=;
 b=0I61qXPAx3252bZ8/NPyoqvKLEioThX+WsJLtJTVeRKPuFb+cWiP4ai+SY34SDhQ9TgGWALeab5fwGUH5URZQPqRnmOoh4CEBaePyRWpJ0R4zgDb9vXHdc5ryliQBj7V0lOgx/Ob7TyAU8zHHT6uQ/z6r+zUj4zR5VEe3j+Kujk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 10:47:06 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 10:47:06 +0000
Message-ID: <92b256e7-2918-4a4e-9c18-362dc6b91f73@amd.com>
Date: Wed, 2 Oct 2024 12:46:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] arm64: zynqmp: Add thermal zones
To: Sean Anderson <sean.anderson@linux.dev>,
 linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240812215129.3599832-1-sean.anderson@linux.dev>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240812215129.3599832-1-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0140.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::24) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: 6272437f-9961-43c4-8b1d-08dce2cf8f18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlJVVm1UQUNZcWsyNUEwV0xFVUMvRzI3U1dINEJya25NVDlzeEpaUnNvWHNz?=
 =?utf-8?B?VmJMRmsxZ25qTmhnbGhEVWNES21iVnlXL2ZmV2x5M09BOU1IblJ3RW9aSG5G?=
 =?utf-8?B?Q1krRm5MMEZhZkFUNVc0VDhINk5BMUhFWUVMSEFORTFNdHFaWU1nd1EyNXlJ?=
 =?utf-8?B?dXVEOVY4bWxXbFBSckhvNGI4TmhTU2cxQ1crZ1JjbmY3dkh3cVVlN042TE9l?=
 =?utf-8?B?eURhSGhLTTdRdUlGcWFnbHQ4c252ODJCdEsxV01pbUIrMlZSUGdqNitVTno0?=
 =?utf-8?B?TnE4QmhvYTBxNy9CUUt5ZnhlTEJiWis4MkpyWmU5Rmpvd29xTGV0eExnSkMv?=
 =?utf-8?B?SWIxdFpJeGpEYy83ZmxaSldDOVVjWmNjdDJjbVJlZU1Ed0hGdGExOU1uQnNx?=
 =?utf-8?B?L29wRjJmK3l2c0tTTXFybHh0dlRpQTFKWlNIeXJNL2NpN2RqakdTUFhwZy9Q?=
 =?utf-8?B?NFhGclBUMHhrclBUUXpBQlE1YzlDdGxQS0NGVlk1T2k2U3dMWlpMQ0VuODVV?=
 =?utf-8?B?Ryt2czQwSUxDUGF4RTVtQVBFQWc2SWtaWi9BS0JZdS9INE52bWNlODRXY3NT?=
 =?utf-8?B?QnRBNVgxSXlHcGlrMXk3WDFKVGdYR3NFZ0lUN041RGRwRnVjSUR2VjBLYVRw?=
 =?utf-8?B?b0w0STRvckNobkxFL3VKbld5M0draFBjR294bzJ2MklEYjZaR2VpYjZHK0ww?=
 =?utf-8?B?RXpmZUV6V0RzWk5rajZkOGdmN1NMV1lZcFA0Ty8yeDVOMnNqcTRiTVVpeU9Y?=
 =?utf-8?B?eExUWnNUSlZzalBVKy9BblV3Y04rUXpsZ3o4Y3JQdmRpQ05OZTNPYVI1aDl3?=
 =?utf-8?B?TDlXRjUrdnE3Rmxmc0FxT0lkaExFK1RocktTUzlOQnlwUjlvTEZQY3Vqbisw?=
 =?utf-8?B?M0pDNmV6VWY4VnowRjZicUlqZkFucTg4dlI0RFBsS2xTbjR0YTM1ZlVWT1Ir?=
 =?utf-8?B?L3NuTDhJaXErZkxlRTVuSTdEekpkaUowT0J5Y2NlZ0NmdkFiSWVuRUYzSzYv?=
 =?utf-8?B?aU1iVXBrVmFOQjBhTElDQ3BpclJrMXNBendrQkwxSnVOVmFkallEeFVqRGV3?=
 =?utf-8?B?YTJhckl2R2d1cUxzSXRsSlFjek9LRVhIWUE4ZVUwYURtbVRCbTVkMTBaV3Jy?=
 =?utf-8?B?ZUtuOW5pa1RJaHdGWmFEU3VpaWNxUXMvVW1CMzlyaGpBOUsvL2dYWFkxbFZr?=
 =?utf-8?B?V08xOFBaZ0NZU29RUVE3MGVBaFFPYmZkNVRRUmxobzFadEhISzl6clA1eXFn?=
 =?utf-8?B?aWhFcUpjS1g0UEh3anh0YXhyeDZQU2xVVUxaT0xLTElPS0o4ajRKYWJaZ0k0?=
 =?utf-8?B?QktNc0ZoR2JENFdkRXpqQkV5bXFnVzQrUFRKZVRad1QwaTZ6cCt4SUF2UEVQ?=
 =?utf-8?B?UHA1bFBxakhEVkxhRmJBakxvdHlWVEFTSjYvT0ZURmpib3puWXkxT1gyRDVZ?=
 =?utf-8?B?UmRUZDFIRkpOazlTS05zaDhOZHdwdFcwZGRkbm4zQXBJZ1k1S2FPRVRlRVBh?=
 =?utf-8?B?K3hzdFRGRlREdzlhNEZCejU1aXY1NnRUSU4rdFM0eHJCcmJ1UVhPa1VqVUtK?=
 =?utf-8?B?TG52dXBVRDFMd1ovc1VZWW91YURiYm40NjdLY1luenZPYlhoL2RXTnlocytY?=
 =?utf-8?B?NzZlNXpTWDN6eVMzQklXTjVVK3RyTk90QXhMbFNidDBkSytvZ0sxWTVBb2Fu?=
 =?utf-8?B?M2FzU0VaNmlnQllVdXlhNHp0ZVYwZ1lHTzZRa2owSHFOaDgxRG1pVHVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzkxSTFRYUNlVXlOd3c0ejNWc0NXQ3hCUmR2K0tIOHdGSnZLNXltMGRZVU5J?=
 =?utf-8?B?cklIL1ZlMG1neEE3Y1psMkZDZjNBQ0pzOGU3NzFtZzNJSUhibXM4dlhzQzh5?=
 =?utf-8?B?YUtmdkR0c0hDZUJyTG5FdktuNzZldExEOU9qRXZKWmxRc1BGb2sxVUlBYzhY?=
 =?utf-8?B?NlVtdXVVZTZBdmZMR2JYTjFHVzFZTEdsU2pzWi9kaXV6dk1TUThURzkvMDQw?=
 =?utf-8?B?WjQ4QjBpc2E2VzJrMElpRzFpZHRSU1FCVzhXZEVkWHRmQVVScEVnNGVYb0hl?=
 =?utf-8?B?QXloUFdnYzJwbjhyMnhweTJyVGlMcloxNVllU2FMdGFaaHowVW0vT2xzNHRp?=
 =?utf-8?B?TXpMN3VkQ0crcXhhVTVxNy9wZU8wT3gwbUdWaStLVk5sV0drcnVTUzJqMWRh?=
 =?utf-8?B?Um45aVFiZXJGNXlDY3B2dkFjV2lmY2pqL0xFbEpxTlU5NzZNU3k3MnJPbFlY?=
 =?utf-8?B?amZMZUU4ai9Ma1ZSL20zUERMWGR2cGVvRFRMcGw1eENOanBsbFJtMnlHalBw?=
 =?utf-8?B?MnhDcXdmQ2lERFA2bHlyVW55Szh3a2JFSW12K3o2ZlBlbDNJdENuOW0xWlhq?=
 =?utf-8?B?bUlacmgyRHJzbzlhaDlEa3RSNldOV1BnTVZVVkhUcFBtV2JiekZYWEZqYzJt?=
 =?utf-8?B?cXRwWVpJYUlOTitmcmNicVB4R083UGM4OFR3WlhGWWZZbDhHUjJ5OHJsZ3dk?=
 =?utf-8?B?eDJPdGJqaVEvKzVhZHUzcVE4L1dod3pYSHE5bFNOaWNlbVpiVUl1OFdNV3pr?=
 =?utf-8?B?Y1dtTGdvaUs4VTlDSlJYZkZIeXEvck1Tbk9yOWlONUJlOVNYZnBRWVMzbUkv?=
 =?utf-8?B?K1VGR2N1SzVaUFBoYmxkZURsVEZEelJXNnFBblFkRDBRT1hwRkNlMUlCaTMx?=
 =?utf-8?B?RW96dER6enY0bWtpYlRYTW5nakNiTm83NVQ3T1NkOGRGWGVvVkd6MHhZdGFu?=
 =?utf-8?B?SmJsQ3JZckxVRVBWVnpieFdwMFZyeVBLc3I4amlsbXZRUzA1NGExa0ZxVlB4?=
 =?utf-8?B?UVJwTnRSUjY0bnVlRXlDc3hGa3Z5L3kxTU9QN1cwNUZVa1MyVUtCVDFBRWFl?=
 =?utf-8?B?UUdyWVdReHoxWUVuM3VLamZNTExWQ3oxQnZLUWNTTytUbjhuNXhpZVBNeWEr?=
 =?utf-8?B?N3QrSlBXamFCa1RIU0pVd3pycTlkaXRaR3BxWTN1ZlpxNW5GczFmT3hLYXNG?=
 =?utf-8?B?OTRDaWtrMFZHSHZGT0E3ZWN1djhwWWVKWWxIcno3R2dMRzZXNUIzaXRFWWNG?=
 =?utf-8?B?QzBhSHdOZUlQdXlpQ1dYTUdtK1BBSm90RTkvUjdJTzg1Zm92ZXpkK2NMTVRy?=
 =?utf-8?B?YUZIUi9XTmJlZ08xWTdFWXAzRzdoMTBrcy9td3NtZXlPdUZXdTNsK2hhbmE3?=
 =?utf-8?B?R1hhTGdsMFcwMlBjRW9LcXVla2JCNmpsSEFrNFlpR01uTnRQZXIvaVlnUEJa?=
 =?utf-8?B?cjB2bGZCUXdSOStEQ0JTQ1JCTE9tTll4ZWhKVGdiOW52amJpNWNNUURpUkJQ?=
 =?utf-8?B?K0sxdXpoVjltK0h2TVBQVlJjNFdzelRiUGpPQmczVGc3NDVLNjhjWWU0bXA3?=
 =?utf-8?B?Ulp0dndhT2U1YTJZTDhJa1gwNUhzTVpRSllyK3RuMlcrZWZ2QlpsR2k0V1lr?=
 =?utf-8?B?K1Z4RVYvRVdWUEp3eTFZK2ZPallxd2VSRlVud1BReXo2QnpncGpuSEpCS0w3?=
 =?utf-8?B?bEtzWXhpMVdvemhYZERLNkJZS1FIM0ZhWWFTaWhhaVRlMFNYekc5RE9lZ3Vz?=
 =?utf-8?B?UEliQ3VldVV4ZUxrZTYyS1JPV2c0ZmRPb2tlKzg0UVYvZVo2N2EzZm5oZDZt?=
 =?utf-8?B?NnlJd3QwQU5VckkyZ3V6MmtyV1FrcEF6VHpJeDZDcGwrYW5LSzVaUlVQK3l6?=
 =?utf-8?B?NTJneTRKQXIwem9HTzhwdS9IK3R1aENGMXZ4SUg1cmlsR3ArNHpkMXRIOFU3?=
 =?utf-8?B?Sm43RTh2YW9iUUdOb1pseEdwWTNKT1cwYVMxb3loMXNBR0hIb1NCZWkrTzdE?=
 =?utf-8?B?dHVVMzBTTktIVFppUGIyYWdMMmFlYzZJM3BCUG42Vkp3T3ErMjRCcGhaU1dT?=
 =?utf-8?B?MDVBdDNjYkk1UWh1TDY0TXRlbjRMOGRUM3dsbXkxdlBNYk1WYzl1aFVYSkw5?=
 =?utf-8?Q?o7l4klE9xkmlNgsEP5jqXrD4R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6272437f-9961-43c4-8b1d-08dce2cf8f18
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 10:47:06.8937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwUjrhdaj8vqJPPCZFvMcFVtcXEMO836SOIMEmu5hUcRxtUp/47bu+AxThmFlYEz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740



On 8/12/24 23:51, Sean Anderson wrote:
> At the moment, the ZynqMP Analog Monitoring System (AMS) is only used
> sporadically. As it is built into the SoC and doesn't depend on external
> hardware, it can be exposed to userspace for all boards. Additionally,
> we can use it to implement thermal zones.
> 
> 
> Sean Anderson (3):
>    arm64: zynqmp: Enable AMS for all boards
>    arm64: zynqmp: Expose AMS to userspace as HWMON
>    arm64: zynqmp: Add thermal zones
> 
>   .../boot/dts/xilinx/zynqmp-sm-k26-revA.dts    |  18 ----
>   .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    |   4 -
>   .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    |   4 -
>   .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    |   4 -
>   .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    |   4 -
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 101 +++++++++++++++++-
>   6 files changed, 100 insertions(+), 35 deletions(-)
> 

Applied.
M

