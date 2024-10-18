Return-Path: <linux-kernel+bounces-370933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B359A33EC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8F71F2151B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 04:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C000317332B;
	Fri, 18 Oct 2024 04:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tRrySn50"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95271160884
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 04:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729226297; cv=fail; b=EwY+qGFvWqxmq60ichoA6FIeh9WlZ0v5nLOFdfwDQna2DwL6Qc9OnvXJWNpkXv8cUC0tacSwJh/t0H8MDMD7sJjDFqYtrcmt62dMYShwPWaufWPowoPxfQE1srC7qqE+KcqB5AOieLvN+YKK42NUjRMQwqoY3HMSDW/Kz5v9MTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729226297; c=relaxed/simple;
	bh=Hb7g/GzjaEP6AJYu2/52c7njxrZWkXM9+E/RzoYmpR4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f1hMVYbHkc0KbZnDGsnHGGDX0tezq/VKYjjmyMJoDx+D3hgIEUQFQ6ZidZjUc0+GJYVROfBigKzG1XTHxoR5sDk85gnFESCV0NeO9gjZ6LmZIEnbrdt9OAkbszFW8sCJbqtTT1OqE0kKWTUUgNtogtXdYGl38Vu8ii9JqLUe2Ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tRrySn50; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYGfeI36e6tPWxFBA55w2s7qtmCpBBBBxovfoMUuBYJa8M7pd/JSAdLomEL8cLlybaMNZwgb/Mzs/QpRus/7kzzbcbV/wG/CWleeS6Cr/aD9MsFXyyiHEiB+jq1UqAKR1eC8tmVPFVgrHuWQAlnDU1CoXec5xdni1Nv5TdRgMMiOcDadeO2+dz9q7wYpD9AVT4fvSvvIvwW9VuAjh1Reu78agC0hYo7kUKVDV7ASoJTndvOZH3jvEoOQLz6i3QkOEKburVLSqXLnZJLXyvmhxvKR5+t2tG0zFhZl6R58LCKyAF8XDgTv4EV/3XeRivfgZwEZO6cTG5hwI4vaRiAczw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4Pd+SVAqL/gqJC8Xt/VaQS/IpTMiWAadkJvJUdxjnw=;
 b=g8qjSDbOrj4Cz0PP82v29Y/EjsvNLNx56pZtEWb9187Mgr4skwYkhaESrr81NwqiBEXzCt9gmDgyaRSKJ/s1Yplb2yqux56SfET5xJ7F9e0LKUcO6DH+R7AgLRmP3XIhJfwdenF/5041hZRerqJ9EzgahcHVg7RZ/1/6jEpGdzo3B0b9363ZUmDxM1NflCK1zLkfOTtRUqApNY0xlMsVbQ6rM8D4Glv5UJrXiP7hvO7XPu7JhpgZkDL7uNCOhPBV678a7samIfWqm0OtZBGOqoPigCMQTRl6tLk3vs2W9R/S5DRp1FsmBJfo0g5MURd5GFdlytH8UkeRXTPhSv7MoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4Pd+SVAqL/gqJC8Xt/VaQS/IpTMiWAadkJvJUdxjnw=;
 b=tRrySn50nKJSLmRUk/K0iOLacEsBhoWOrBIkuhtPivjEHqEeY0N5rGqxb/zHoWIakCFXpFbpMunp8tpt9aeAonWoYY9PsD9vYvDXMdl8gK9tSkMmUO1tCjKs8WtMYvRsCHeNS92JMzDLlimD9I8WiAR0uW5yMRHplaoMpSUiABc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 PH7PR12MB8426.namprd12.prod.outlook.com (2603:10b6:510:241::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Fri, 18 Oct
 2024 04:38:13 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8069.019; Fri, 18 Oct 2024
 04:38:13 +0000
Message-ID: <b7ef4305-39ba-4650-bfec-287599730554@amd.com>
Date: Fri, 18 Oct 2024 10:08:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] x86/sev: Map only the RMP table entries instead of
 the full RMP range
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <89d50ef2f0a9b3eaf4e9c4cf4e0a418f963d92e7.1727709735.git.thomas.lendacky@amd.com>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <89d50ef2f0a9b3eaf4e9c4cf4e0a418f963d92e7.1727709735.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::7) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|PH7PR12MB8426:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b041650-9b69-4e55-cca5-08dcef2eacfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RW1UOU0xYUtWQVd4U0o1b01TYlp2ajJsbklnQnZtQ0lSYVlia2VwTENGNXhv?=
 =?utf-8?B?SUZDeHlwbGFJZjFwU0lrem14UnFTN3dHUTNveENBbDVqMW9ISktmWGE2S0Z6?=
 =?utf-8?B?QmFtMklXcjhkTnc0OGc1THhTUCtuQ0Z5SnhiRFkvUzZtaWRra0tzWXhXb2Np?=
 =?utf-8?B?b2cxd3UrYzAvbUo0c2tHS3FIMUNIank0dFZBOHA5bjlyYVAxZ2t4REd3Tlpw?=
 =?utf-8?B?UXhjZk0zN05IeVpnNHFwRGt6bjJ2YjJHbU9zdEdRMDdwNXRrYjBZTitnRE1l?=
 =?utf-8?B?bGpuOEFWSm1DUGNobjBEblpTc3hhTDVLZ1NiRWxJWTVYdUgveVpCWDQ4cUhE?=
 =?utf-8?B?SHNUKzNrY1lhcElqeEc2L3hkNzZrdUVaMWMrVjVtUEhFaGtFdlFEZlJRWEh4?=
 =?utf-8?B?c1RESThPdW13V3ZCaHRsWW5ZWDNZeHVsUmJ0eStHdUdoQXhmOUEzRGpEYkhI?=
 =?utf-8?B?TGNrejBaK0hOR2RoUGFEU2E3OFlya09rRDUyYVFoN0VhTWJkQ283eG1qOXNL?=
 =?utf-8?B?S0dGanIwS3pnc2w2TmVnMFV2Ykk0MkVxbjRhRlFZQVVSMGRjM1Q3Q3pCRFRF?=
 =?utf-8?B?eGtZTjZVQ1BBdm4yTUQ4ZkhPU282cjVNOVg2aWxpZnE4blAyVWo1SEQxOGFr?=
 =?utf-8?B?SkpLZ1huVWVzQUd4Q01KdDZldC9HNnBIUEVrN2JyYnNJdktaa0t6a0FzcXZO?=
 =?utf-8?B?b203LzA5anQ0Q2g1MEJxcVZ1K1RxQ01ncmR2VGV2RzRSRXIzS2RyMVlvSVBX?=
 =?utf-8?B?ZzlZNzdEVnhYenNGc3ZiNDhFRGpUQ2o0dFNxZ0MxRHd3UVdOcVU0b0FaUWc1?=
 =?utf-8?B?bE5xcTIvU2V1WmdVZDBnNWwrYU82d1hKek9NaHJOVWFSMnFubFNXREMwb2R3?=
 =?utf-8?B?RC9sb1JNR3VDZnNqa1p5SlE1TEdFcTF1NmxwRjd1d1N4SFFnQXA5blFUd2Y3?=
 =?utf-8?B?RXNFckt4VzM2OEZaVlhNWVVnU2F4QXJ5TzhmR2FVRWxBRWxOY3BHNUdGUmVm?=
 =?utf-8?B?Y0Vid1M1cVZSMnBxektVWHYxTittSms1d0drdWlhTHZwTm4yc0ZzRkw4Vlla?=
 =?utf-8?B?TUlEa3Z2blRIOW1iM1pqMEsxcEIwUUZvd3pYZ204aDBnYWppMjJCNDFwYlJv?=
 =?utf-8?B?Q0p3b1podjhML1FrNTg5M0pPUnpRckMraUJWQVY0YVcvOXRHWG1tTFJobUJx?=
 =?utf-8?B?SVZZZ1NsOTc5c3B4dXh3WlpVZ2JzRVM4VG9TTENlM2FFVlNsTjhiVEFzQmQ1?=
 =?utf-8?B?N3NGa0xycWNkYlJmbk1UVUdCYS9NNFN6Rm9tL2NCYlJWejdaT3VVTFcrSUY1?=
 =?utf-8?B?WHd0VU03UjRqbVIvZmRuN09VZXBRMUovdFpNWnZINmNWVFZKU0hidlRSTXVQ?=
 =?utf-8?B?Tm9RQUVnV2d1UUdVU1d2SzVGL3V1eWlNN29IdGhFVDdzWURQNCtXQzdMWlFM?=
 =?utf-8?B?VWJLV3dzNHp4UGJqOWlKK3FHMVQvRURwbzRDTW9ucUdnWlVUdi8zQTZLODdv?=
 =?utf-8?B?MDlmWlhyRHJoejNWUjUwSVRHMEo5ZmVuQnNUbnpFVkRham15ZkwvQk5lMjlx?=
 =?utf-8?B?TXFkMFRZdG5yU2R1ME4wVmMyV2pQY3ZubEdFdTdFa2h0SDh5dExmTXNDc1RQ?=
 =?utf-8?B?S1NWRXpNaDFtS2E5VzVPSTJvWmJnWDZadXhoUkdwaFhqTmFENjVhaCtZWG5H?=
 =?utf-8?B?UVBFSWNxc2g0aS9wM013OTRUN1ZGOWYremtMUEJGTkhoaVBPd0NIV3JNVE50?=
 =?utf-8?Q?IfD9hrcgNamyF8UDjX54xlpct0cX511/BWPugxP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDQrb1B6NzdXRElER2xFZUkrSGVPUEpIZUFqS2tmcmpWdkx0Slh1dHZpMXZ4?=
 =?utf-8?B?aDk0RnBrV21aS3paTU05U21yWExmSnkraTR3UmJHTVlOV2RHK2tjWmFjWWNk?=
 =?utf-8?B?UVo4RXIxS21uWHl3MGYySGpGVyswOEk3dUNnVkppcEZtdSt3dGUraitpSkZR?=
 =?utf-8?B?VGdsUVNPQ3Qvd2hLVDRWOWRvWVdseUk2NDlHN2Y0RHNZNFAxUEpYaks0TVRV?=
 =?utf-8?B?cm9GSkgwNTNsSlp2RTVqSHoyRWVncVZWRlpFdlZYMHRCNnlDNEpoZElsQVdv?=
 =?utf-8?B?dW9vMDlSSTE3VXYzaEhtaUNCV3lkNm81TlRmWUNTTnZucUtGM2hjcVFXODQ0?=
 =?utf-8?B?MmlYWW9EY1laRExEVGpPbEJkaEtUYW1MUHVkMUx0UmNTVlo0Vno2bUt1SzBM?=
 =?utf-8?B?MVc1aXd3NDQxamZzNS9UcGczTlRVQ2ZjWEJCL214RnBSZ0hMVWZnbWhzbGlR?=
 =?utf-8?B?NDlTYnVNYm9hZEpMZ1NlbW1tRVhLSXpQN1VQaGNtT3JhYXlUVXdJdkV6dnlx?=
 =?utf-8?B?YWRXWFFKRTZWVmRRbGVyZ3dyRnZMRFlXRG1pL2xIRk1XR0t2NTFPSEJYWnNv?=
 =?utf-8?B?QzNzRWMwOVJkd3l6TUIzZjBXY0tla2E5L3U5N0RTQVBHL2NoL0FlaUFTZWFB?=
 =?utf-8?B?VmdHVk0vQTBtSXRpK2tvL0ZmcDdKbGdaNlJpVXBxdEU4WTNzZW1rb1QwZFFq?=
 =?utf-8?B?NzQ2NStvZWc0TTI2YVkxTEFlU2hHRFRiNHFPT1ZxV0ZIOWFQV2J3SUlZaG9F?=
 =?utf-8?B?ajZ6dTlsUHhSS2xuN3hnMW16R0w5S2c0bm5KenZLd0dpOUNjeE8wazdDem1Y?=
 =?utf-8?B?UzQyTU42OGNCcU84YkNuT290S1RrWDYrVEVRbC9Gb2pTbGNlcnNzNCtYK1dQ?=
 =?utf-8?B?OThLQVRHVmJ3eXRKaGtpL1J6NmkvY3MzQTRmK2k0SkhpRnBOaERUeCsyRSs1?=
 =?utf-8?B?VFFLazRYMmc4THZsVThwZFhnMDlHM2RwWFUxbUpLYTk3WFVCR3RmZ2pMYThT?=
 =?utf-8?B?Zi9XWGx1am1KVjFNOGtkWjlnbldVRjV2ci9mcE5QdVF5TWxlcWk1WlNlT1ho?=
 =?utf-8?B?aTNVQVlnUi83N2pqRWlOZ21TWkZFWi84OHRvT2hvYkJCTGQra3dZdTdCUWI1?=
 =?utf-8?B?QmNLallCeTdBTjYvZmF2cVRhMHk0QWNlbHZxN1ByeHJCRmVHamlsaEpCMTA5?=
 =?utf-8?B?QzJGd2NkQng1VXJIMWZVRUt3VkpBV1lDRkJteWh0VmlSbUY2VDgrSFN2REhn?=
 =?utf-8?B?Nzk0RnltTTJybHpweEsxay9Ua3c4cUh5OWJ3Y0IrMkFFd2lYYVpvakxQOVV1?=
 =?utf-8?B?NGxHUUsrMFZ0Rzl1ckszOUtUOXlsOE1ORHBISzVVdlQ4WWw5OHRScGtSS3pw?=
 =?utf-8?B?RGlDS0JzekJ1aUxQZmJLSjVUNHZRNmg5WWxuWDNXc1J2ZERqYjE5dUJhcHZz?=
 =?utf-8?B?aERKQkhaRlo1bnZjRWdEWkp1UVg4blN0b0FydGNtclYyanZqWkZlN0d3djhn?=
 =?utf-8?B?b0NuSEdOL2FWK3BkUWRHVjlUM2NFcCtCVmJPc0RmaXJ4VVlxS0ZMVUFUMTMy?=
 =?utf-8?B?dlNOcy9HQWFGaXdxK20wTjBEVlFjdHJIZjF6ekMvL25VZjVKVlNucXNGM1ZQ?=
 =?utf-8?B?OGV0dTBaSXBDZTlCbE9tNXpxaStKTWZHQUNkYnNWLytvQWpFZmJ2VkVGcU95?=
 =?utf-8?B?S1EvMXFkdEVzZDRtWjhJUWRDMGpZcG5vM2JRMnFBMFM0T2Z5ZE1BWDBNR2Rj?=
 =?utf-8?B?dVFmdjNwZHh2allRQ3IwSC80Tkp3VlpYSCtGdlJ4V0h0VnNQeFhZSTZlbjk0?=
 =?utf-8?B?UkxhcmRHU2JQSDEyVDlXMkhJWXVHSXpnSEVma01lczVUUS80MlR2NDhuRFJV?=
 =?utf-8?B?NTFrMy9jd3RvRlpHaVdtQW92cjNOdGIzZkUvRHdYKzI0QjF5NExUYVRFVTJs?=
 =?utf-8?B?RE5BZmhDU3U0SFQvUDVUV1phYVBvSWRRQjR6anJaK0pXMlBsVFVJRlJlczhT?=
 =?utf-8?B?WnhkRHFaQmJNRDlYV0xsa3hmSlNyak52bzdwbEhISHhwemltTDZoUmxPUU9s?=
 =?utf-8?B?TDJleHEwdTN3NGRhSkFPaGc3Unc5WWROUy9PNDlYTGRpMG1ndWVWaDczbCtZ?=
 =?utf-8?Q?pxZB1biVCUu52/O5lfYMPBpYp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b041650-9b69-4e55-cca5-08dcef2eacfc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 04:38:13.2662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jeSQ/2361Ftfvm58tLzri7k6wof6XDBk7v6UdCGF0ywV3LZNKS96l/3X8oUU5FTxU110QD7zFRZwmubEDUAVtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8426




>  /*
>   * Do the necessary preparations which are verified by the firmware as
>   * described in the SNP_INIT_EX firmware command description in the SNP
> @@ -205,12 +222,17 @@ static int __init snp_rmptable_init(void)
>  		goto nosnp;
>  	}
>  
> -	rmptable_start = memremap(probed_rmp_base, probed_rmp_size, MEMREMAP_WB);
> +	/* Map only the RMP entries */
> +	rmptable_start = memremap(probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ,
> +				  probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ,
> +				  MEMREMAP_WB);
>  	if (!rmptable_start) {
>  		pr_err("Failed to map RMP table\n");
>  		goto nosnp;
>  	}
>  
> +	rmptable_size = probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ;
> +

Nit: Move this assignment above 'rmptable_start = memremap(...)', so that
rmptable_size  can be used there.


- Neeraj


