Return-Path: <linux-kernel+bounces-238527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07983924B8B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52EF2B235D8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CCA1DA30D;
	Tue,  2 Jul 2024 22:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="KXbZ99mk"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2092.outbound.protection.outlook.com [40.107.223.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210EF14F109
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 22:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719958913; cv=fail; b=mpWnG3VTxP4ccKzRIUyLBmTWib0uqwrwSGpAsJ8RUJbO/N+jdWlfMjXOyz6zUKeUP7sndvMS9O7W81fYGzDMeFV1yxiWt3NqhiRQuS4gZotF6yyKwmkoF2dMGjSa10C8DA93hyYQ678J9/Z3PMS52Y4xc/4XlmPFHGUxvkAMnhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719958913; c=relaxed/simple;
	bh=4WBGPy9WghezbE23A4dYwWACukUvNa3yiZonvugphyE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OD33aONUw1jjn/dwaI6vkV/qtiv8l8cMspkRBiMknc1sKaHsXOjkb2FxsUSDBPDys3iYro4GnDwuzm9ctg8KvZFYVoEadEJJpv+DrQFa+DbgI7f39Xr9t5Mw9lAr53Pt2hIWyqHXz+iWi8gP7hpmRTQNJmmxwPFgqpewl3rSbIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=KXbZ99mk; arc=fail smtp.client-ip=40.107.223.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mljXGlp0kkV+8LKuJKixX0TdXVMFIBND7TTZEUDZqmW2AH8B4GPS64k6QlH0geUD6lCxGCQEGDl+AZ0NsPUbLM/M0pT3tGRBD12akaOstfhHirUDz1YMCSfE8Z1Uj4OE/0dn79EY1waRP2xLaWyB3z1G9VTRrE5tUDHpnUbU0SXAWguSZwcVskKxC2Mw1GaNF8yVAAn4kPPL7JYlN7qo4cdZDLyyfFTFlPDKianjHO9xjiRWYvZ5Jew9w9u7b4bNyDPBYojXAZxNlWsF2DnDUP0LtIMuXOeMB2VLohepVDKQgg3P95J+I8HcipriDJV6AIaoAN3g2vfU9HsxrlUiIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2r2Om9S9d+DmSXJj9krM65ofGR530t5Hy3xD2uFnuE=;
 b=cei0rCtlSD6+gKVgIJnQheGzp4r7V7P+gvPvQUpmDBfb1oFGWjaZ6S8emCBJWWPklNhFvIvlLgo8VUrV89Xn71Gve2Ri+LO/kAtOXg0ijwHl/5aWC/uSNSmVTH/wk8mgSrJ4atGsmRHQex3UBEdXjnrXNHZXCWCCwFRaQUqzTW0c8ANkTGvv/4WPwWYOyreWoXQfM8AsiPSDm19gGwDju7BXOQF905XlG6+JL7VMKALT0cvMr1mwU2avoObgkPTE0X35ZONACkLxBndivcJ1ehLxJAEObA68eoBxKUUMgSrYxJpl35drL3Ss1um+fnVs91X5vnyahD3DD0mNPsgZjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2r2Om9S9d+DmSXJj9krM65ofGR530t5Hy3xD2uFnuE=;
 b=KXbZ99mk3cwDt1yOwPQD8YUOoquPa6ogJvinNoxHpsasMtvMBnTwyoKDTR3tOAT6owZiLIVXd5Sov7nD6QSMDjQ63gHoqj4MCbD/d7zXgnJRY+xNCILa40a+Zi4+gcny2iBV7vceWE6YVZexBbNvI0WUxutv9qYFt7HMn07fqZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 PH0PR01MB6406.prod.exchangelabs.com (2603:10b6:510:1f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.32; Tue, 2 Jul 2024 22:21:46 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%4]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 22:21:46 +0000
Message-ID: <1689cd26-514a-4d72-a1bd-b67357aab3e0@os.amperecomputing.com>
Date: Tue, 2 Jul 2024 15:21:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, will@kernel.org,
 anshuman.khandual@arm.com, david@redhat.com, scott@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240626191830.3819324-1-yang@os.amperecomputing.com>
 <Zn7q3oL1AE8jdM-g@arm.com> <773c8be7-eb73-010c-acea-1c2fefd65b84@gentwo.org>
 <Zn7xs6OYZz4dyA8a@arm.com>
 <200c5d06-c551-4847-adaf-287750e6aac4@os.amperecomputing.com>
 <ZoMG6n4hQp5XMhUN@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <ZoMG6n4hQp5XMhUN@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::26) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|PH0PR01MB6406:EE_
X-MS-Office365-Filtering-Correlation-Id: 82ef2e29-c71f-4998-73f2-08dc9ae55bdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clFDL1k5YmQzWHJWRGtmWncwdHNNc1hwMVBjcGR3UEhOa29SM1lBRm4veTZH?=
 =?utf-8?B?Z0QyMnhlQWh4VnAxM3VwUXpzbjBSVFdkUWkvT3h4MHl6ekZVUVFvMTZjTmpD?=
 =?utf-8?B?eTlVQnVTMGxKdHY4T29HVlZ3eStaakNKcDlnU2RhZWtBa1JrSE5NV2Iyb0VU?=
 =?utf-8?B?Skd3T3hSRDc2VmwydFhUenhkT1RaM2ViN1l0SjFhemhDenNKNXhma0srUVV1?=
 =?utf-8?B?MkN2SmZQSWh3cXVTWkJqM0ZoMCtYaUJKR2RhYjArVDNoaWgrWWpXbGM2dkI0?=
 =?utf-8?B?YTNBaTBQS2d4Y2w4bXV6NnY1b0tmVHBHMUdnRXJTSGpXYXAzRUMydGdLNUw5?=
 =?utf-8?B?Qk1JeS8xZTFKMEhmNHplYTkzOW56MCtrUDZsRnB1SWdHQ1YyZzN4VzI0aTdB?=
 =?utf-8?B?TVNHN3hYdUhUUk9rT2ZlajBrWEphQWJWMlhWRWpQKzVMSFlGVEFHOVZLYjJ0?=
 =?utf-8?B?UnBrSk1WMzRtNnZaZXZaTVUzc1BhRzNqMmF5czZhUFlOZ25LVDIxYnJTKzdW?=
 =?utf-8?B?RlVlQjJMMFovejZwZWZkbzd6b2dlaWZna1RLQ3VvKzRjc2J5alU1dFhUYTBm?=
 =?utf-8?B?emVqRE5YcXE5c24zMU5MaWc1Y2pYdzFmY3BLa05SY3ZINFBXYnFIUmxQTW0v?=
 =?utf-8?B?NmtHMER0Vy83Ynp6dUdmeitlUFZidUo1S25aU1hhKy9PUjhJOERyOXVRcHR1?=
 =?utf-8?B?QXk2YTRJZHl6RjFFdGVoakxNM3g0R0R6Mk1LM1ZnTWI3Nm1JVHFGQ0dBZDFP?=
 =?utf-8?B?YjRxb2F6eTM1SGQrR2RTcnhxckJsREJYYlNvamRBQ0JRWHp2dGQwTHIzV1Jl?=
 =?utf-8?B?ZGZLSmtPYkFlYjg0aHAwR1FQVHp1dUEwY2xLbGFRc0pHSkx5Y25zdERqM0c4?=
 =?utf-8?B?cTZXWnBSK2F0a0JBTXk2ZHhhb2k1YXN3WEZrSW4zSjQ5Ym9IMFV1MmpoZGVQ?=
 =?utf-8?B?azI0YmdyV2NFZC9SSjJlb0NDd092cHpqVWo5K2lQcXloVVZvNE9jWkkwaThD?=
 =?utf-8?B?S2hwU3crRnFuUnFJRTlDSzh6SWRQRmRMUkh5ZEN5L2VhSVB6MW0walJlNnRj?=
 =?utf-8?B?MGVlUWl5aTU5MmUwNk41MVhJZVRFQXVTL0c3ZHpxdURvc1R3SkRVT0lsZ0VN?=
 =?utf-8?B?Q2t5RlJIQkgvUXdwMXlvNFV6YTZlakpmK3lWNzlQQ1ZmT3crYVY0bUVXQkw1?=
 =?utf-8?B?bzc0bC9QUGZPSXMvYnpmVU5HMk1KUzlaTmJvSnE4bDA3emp5Wi9zMHg3dCtV?=
 =?utf-8?B?cU5HTUJ2MCtYNWlCK0Y4cW00aUdGNGk4WjBibnpYVjZPU2JqVDg0QlVJNDVB?=
 =?utf-8?B?UFg5aEU0R2VWdjBxeVVLdzQyYVFmSnV6TnpHWDRyZkNRTWdpcHpKelBIeGxO?=
 =?utf-8?B?a09hc0V5Tk12QTduNmZFY09wNExEeWd0dkh2NDFwVVpZSUFlRVB5ZTR6TFh4?=
 =?utf-8?B?NGNuczRFRWc1Nkk1L3RlM081WnNBNkdkMUJra2o5TVFlWDd6djJVYXFMd2pX?=
 =?utf-8?B?Wk9KQ3ZKNkxxRUJ5MFJ4cC8zMFpTZUlSMndJaG56ZUJNQUQ5bUV2bGJubklI?=
 =?utf-8?B?UXhkSFlMSS93VW1EWlNrK2JEdFVJWE13bWkwUHhsejhMNnBXanBJTk42RFV2?=
 =?utf-8?B?R0llWVFMbWR3eUdoTFZ2SnNkY2hOalZXZmI0dyszaUdPT3Z3blBGUEt0Wk0w?=
 =?utf-8?B?NFE2SEZLS0NrSlJHbmJZd0ZkUC9vY2o3SDNsVnljYm5nYXZrZDdVZG5UNmdj?=
 =?utf-8?Q?zXbUjYSfU3XR7LvnX0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGpGaGVNckZZWmUyVVQvVjdlSGhqRERaUDFOWVczTXJCQkMwZmFQRU95NHl5?=
 =?utf-8?B?UURFQUt6WmIvWHNNUHBLdk1raEZBY09EVWdGRytVcTViR09lOU5UaklSYlM3?=
 =?utf-8?B?bWI5ZHpkWlF2U1MyY3VkcC9WdjNKL1RBTU50aVdvN2pUUDNsbmdVWTdyeDB2?=
 =?utf-8?B?SStpU0hUdTlNemd2Y3RFNzl4ejVsRTJ0M3JZZ01jaEV5dzFrZUVXb3BDRXU0?=
 =?utf-8?B?OTFVMGRqRmJGUkJJNXMwZWsyNjI5VWdWMG90dDBNcWpXVk9Sb3hzU2hLM3Ay?=
 =?utf-8?B?d3JKL01LQ1kyUllPcElwV0JZd3Vzd1N5SVhvSVdSZ0IweFBJdkV1NDd6V0Jl?=
 =?utf-8?B?VWlCNUJnTkM3WmZpajk5blNLTll5bld4RHVobXFUWGl1TFh6b0ZHQXljOWJi?=
 =?utf-8?B?NVBiY01HditUekdQR2xNQkRyT0dRcVo4aDRpUDRSRHhNeGUyQ2hyd2dBNlRR?=
 =?utf-8?B?S2hWdUF0am4yRnRjQlNZRUxJK1N1aGlaV0pOTDFLWG1kWDdLUU5UUG5lYVVC?=
 =?utf-8?B?R3dnYzYyeGZ1NDZBUGpYV1hnekhKU0NySFZlak1TaE43enR2cUVBam9tdXht?=
 =?utf-8?B?c2tJa1Q2VFFaNy9uK3pGZ3ZWRGxicmlrd3NrVWZybWE5Rlgxd3BtV0NmK1lZ?=
 =?utf-8?B?UTNwWEdyT2ozTUhVaE9oV3gvY2NOYnJEb1JxL2ZCck05d3pNNFZzdjJIUUxM?=
 =?utf-8?B?NEpHUTl0aVBxUTA1V0c3V0ZvTFZxbjV0YzlBT1hCNHhlcEEzYnhVNHdlWTJs?=
 =?utf-8?B?N1dEQlVTM2FKWDdRR080ZklCVW1lUk9tajVDRDRRSW5mTC9IWmcxYzJPVlBN?=
 =?utf-8?B?ZHJoRkRxclRLN2tYM28zQklPSnR5bGlDTTc2eHpQeXhkOTJvNUVsOHJzL3JF?=
 =?utf-8?B?d0RZN0RpT2twUU5xQW5RUnB5Qk1OeXBSMnZVQkFYdnl2SlN0R0J4MjhGN3hG?=
 =?utf-8?B?Skl5dFlubnVkVGJDN0RTU2R6d2NlRDA2TWEyRUp3aXRwUmVpeXlYU2tIbmRa?=
 =?utf-8?B?em9ZY2J5L29icVphc3VkbGlLNnNMblVmbTBhbmdyVmhXS3FXQ3FIR3hIclFJ?=
 =?utf-8?B?aGkrdmpVelR3bXNLMUMzSXVqSEN1Um5FZCtXNkhnZXZIT2d2aHY5bklDakVC?=
 =?utf-8?B?WE5RNmY3NllaQktFNFJPaGs3RVRURnBQVFVyYmZOR0lmYlNMVXg3MkFveGRU?=
 =?utf-8?B?Q0FjNEZhSHZ3ZGRzemlsWXVOMWptNG55bUpmTlA1VmVqL2RoM29wcGdFNDNs?=
 =?utf-8?B?UjgxRndLcUozQmR5bEdyK3V1dEFmV0JkaTZLcXR6L09VYURBdEczT0Eyb3B3?=
 =?utf-8?B?RlFNb2tvVnJoUGdXVWVWOW84VGR2bC9NL0NIb0tIS2pVS1BnS04rMG90OSsr?=
 =?utf-8?B?RCtQTGp6N09FVkhkWDQxZURINitVc1UxdzNVSUdJK3JOMXNReTJtMFl3ZnpE?=
 =?utf-8?B?bWFzWVVuMlIwQjNBL0lrdzJ0c2V2c0tYc05wN0hxSUhpRWxOak55aUhQVjg2?=
 =?utf-8?B?M1VyVjl4RXExTm1QeUY1MzZ3ck05cVlUMmFmMGN6M2piUkhvSStiQkdHR0xP?=
 =?utf-8?B?bzZFWGtCay9xSjZ1Sm1jUm51NS9hNVI1enNReHFNNWc0Qit4U0lST0J4dmh6?=
 =?utf-8?B?UHF4M2h3c05ZU3ZGcXgxRTRQbzVTLzdCUHV3aWFHU2dORFQ0Tjc2SE9sQkdR?=
 =?utf-8?B?R2VXSlkySVdvSVAva2xKUjNTaEFra2FRN3ZGTkFNdnRGdEVKUVJnK29BQUlP?=
 =?utf-8?B?QXZLNnBwcUNzZzdaOFIycU0wVlVJeXNIN3ozU0RkWTdEVU1tM3JFRDFSa2d4?=
 =?utf-8?B?eEc5TDA5SkRPalNCakcxazlOMGlLWFVXa2R4MXJBellIdklxcXppQ25vL1hy?=
 =?utf-8?B?TyttdGEvRUxjMzZ2U1U3clBxVUJrYjB5TkM4OVZBQlRBUUlHSEhXWDROQnE4?=
 =?utf-8?B?ODFkOHp0dS9wR1c1aVNnTm94VFVOb0prM3RsQm1nQ05Hc1ZwSWRGNWc1enI0?=
 =?utf-8?B?WDNESVh6L2pINElxY3Y3L2c0ZzNIUXp0TmNRNXFuakF1cUFJZlk5YWpxbWUv?=
 =?utf-8?B?dzVaTlRHZmx1VXFPV2VYWEIxbmhGZ2tHVmlPZEhJY3dINkw4VTVINzFnc3RG?=
 =?utf-8?B?OW83cmx2YXZYRUxCdFpnQ2RaNmRTTGR3REtKbmhNLzFoY2tBek9VOHQ3T2tS?=
 =?utf-8?Q?7rrTkjqSxdWwKGqY9FiXAQ4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ef2e29-c71f-4998-73f2-08dc9ae55bdf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 22:21:46.0939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LzRxZe0X1yiTJJBst7vcGRlH7v9Q0/U4vmiHwFjDV70gN72yCea/k/H93i6C1CctAgKiLGalBQmnx0RYVPtTks1+XvwocGU+8kWem6reMyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6406



On 7/1/24 12:43 PM, Catalin Marinas wrote:
> On Fri, Jun 28, 2024 at 11:20:43AM -0700, Yang Shi wrote:
>> On 6/28/24 10:24 AM, Catalin Marinas wrote:
>>> This patch does feel a bit like working around a non-optimal user choice
>>> in kernel space. Who knows, madvise() may even be quicker if you do a
>>> single call for a larger VA vs touching each page.
>> IMHO, I don't think so. I viewed this patch to solve or workaround some ISA
>> inefficiency in kernel. Two faults are not necessary if we know we are
>> definitely going to write the memory very soon, right?
> I agree the Arm architecture behaviour is not ideal here and any
> timelines for fixing it in hardware, if they do happen, are far into the
> future. Purely from a kernel perspective, what I want though is make
> sure that longer term (a) we don't create additional maintenance burden
> and (b) we don't keep dead code around.
>
> Point (a) could be mitigated if the architecture is changed so that any
> new atomic instructions added to this range would also come with
> additional syndrome information so that we don't have to update the
> decoding patterns.
>
> Point (b), however, depends on the OpenJDK and the kernel versions in
> distros. Nick Gasson kindly provided some information on the OpenJDK
> changes. The atomic_add(0) change happened in early 2022, about 5-6
> months after MADV_POPULATE_WRITE support was added to the kernel. What's
> interesting is Ampere already contributed MADV_POPULATE_WRITE support to
> OpenJDK a few months ago:
>
> https://github.com/openjdk/jdk/commit/a65a89522d2f24b1767e1c74f6689a22ea32ca6a
>
> The OpenJDK commit lacks explanation but what I gathered from the diff
> is that this option is the preferred one in the presence of THP (which
> most/all distros enable by default). If we merge your proposed kernel
> patch, it will take time before it makes its way into distros. I'm
> hoping that by that time, distros would have picked a new OpenJDK
> version already that doesn't need the atomic_add(0) pattern. If that's
> the case, we end up with some dead code in the kernel that's almost
> never exercised.
>
> I don't follow OpenJDK development but I heard that updates are dragging
> quite a lot. I can't tell whether people have picked up the
> atomic_add(0) feature and whether, by the time a kernel patch would make
> it into distros, they'd also move to the MADV_POPULATE_WRITE pattern.

As Christopher said there may be similar use of atomic in other 
applications, so I don't worry too much about dead code problem IMHO. 
OpenJDK is just the usecase that we know. There may be unknown unknowns. 
And the distros typically backport patches from mainline kernel to their 
kernel so there should be combos like old kernel + backported patch + 
old OpenJDK.

AFAICT, the users do expect similar behavior as x86 (one fault instead 
of two faults). Actually we noticed this problem due to a customer report.

>
> There's a point (c) as well on the overhead of reading the faulting
> instruction. I hope that's negligible but I haven't measured it.

I think I showed benchmark data requested by Anshuman in the earlier 
email discussion.

>


