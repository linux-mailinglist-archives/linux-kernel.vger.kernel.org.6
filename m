Return-Path: <linux-kernel+bounces-563553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC5AA64411
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E29816DD8D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C046721B195;
	Mon, 17 Mar 2025 07:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="MdXfGaGS"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2060.outbound.protection.outlook.com [40.107.215.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23BA21ADD1
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 07:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742197353; cv=fail; b=jsQEeKOGhhCkUUFnwNrIaz8S8XBTs5stt16PbM13tj8vrU+2lkmVN8ZkWYaz9wGCBPmjw1ua8ltmTl7Ph9eHectMzScvRzyAw6M6E+iniVetYMp1zjTLDbPW2un1zhXzSG5hyWA6JlFEPWIbheiYYSKYc6+m6PEa3NL0Pr+JT+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742197353; c=relaxed/simple;
	bh=ciAzpDkotsE4SWLd1U/yJPOQQ+BKHnt6OCF0qiyhXYY=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UMLGEOhAit6TagC7W1jjHAKxrCEWbVt3HHAsHo4y/WqRdMgvwT7ioffqV6Fn7u5f8eB8AAVm6RY3iUfDFJ4O59lVYMdl6r0pvC+cETZ3LrCBnjkWdk917o9vhB1BjV0xj9Po6EBwe25ixgiq8WHksr3YA6yBzv78Ue/Q0ZN/yc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=MdXfGaGS; arc=fail smtp.client-ip=40.107.215.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqlL5h+d3vtDYy6oagA+hVpjcoFWWGuwIY9J52L7YGvUEcRcbR3knTmENaP2moCYDI4MRDUPlOlisq+a6QBJwVV7HBIO7b5zwWwMW+aeoHHgH9BMXXvBboUVz/qh78LP4nrfdsJuHJwucmR6diluqLdcwJ2uEPSBWB1BZmC/FM/h+vCsvoDvBeCmg8t4qaVyp0EQ1q+4i1jDTWz/gmJ5NmttBiO+m1Voz4wGIY/7aXF79ganPm8iac6qxoYm3tMdVcqEMtW9tKhobKMmKqF1Rcf7QifZ444uLBxdynuAATYRa6IfVV3IFczfIn1sntdc5rHSdFdgRUXQ6ZfuClVQhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NdwIrdpG5bKOOMCpEVYPRk/Dj/Ut+nkDQeXcLtX6Tk=;
 b=pVdNkn0TVbZxZpugVjH4apgGLuQGzVQKd0rTxL+3In+F79/v3k0v7kZEI5eDOYPYe2OmbZpa/HhGWh4N8t5MY92aEnOlyo+xzOV68C9yAxo5+9U+UPoMzKogH+Y6E7hMLj9KkUbzlOr4DpyEC8aCFpO2ULscND5+2YokhWfIlwjreHpiJ/Zyf7/z211UHEx5I2BuSY7KVKI1hORyIyr0WAJxyUrMuPYC17iumzF3thuJykQzqiYfavtPKZGeSL2zazSmUcniFV2sRRKE4cq3vlqGkp5a2L7Cu8ZF4LxR7OhLBHS4yhhAXIjnNYV5ikC0XDo7v4bi9ZTJE8EzXAr/Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NdwIrdpG5bKOOMCpEVYPRk/Dj/Ut+nkDQeXcLtX6Tk=;
 b=MdXfGaGSWzaDYdDPcRjCoF7X2xW6AJjxt/ECvMN+8TkG4jnwNmkQPjJ/WuwIH5D6Cj4Wcu43d/xqgtUWh70TrSREgBM6Zcj+J2YmfeQCmTEzob//1HIQiMIqH1er2QJwlTpk6IbU56+taqKx2ZhD5/eaynhQktWFgVphSViqph4VncF/UvAxv2HNtXA1z6EDZXKus8Udb/gk6dakm4P3qIkeNq82fAXpxNnmwwxH8DsBQRG9TG0RPkxvlNa1/FoeG1wUyFhUK4/NiNFcyqvm7J1seSagsqjGZvUf2lGK5bMSTBXgzuWwoJYY5FntnIkVuXYu/erGnk9JtFqxLXUjXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEYPR06MB6226.apcprd06.prod.outlook.com (2603:1096:101:df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.31; Mon, 17 Mar
 2025 07:42:21 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%3]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 07:42:20 +0000
Message-ID: <5a12454c-16a1-4400-a764-f49293d8dece@vivo.com>
Date: Mon, 17 Mar 2025 15:42:15 +0800
User-Agent: Mozilla Thunderbird
To: hch@lst.de
Cc: akpm@linux-foundation.org, bingbu.cao@linux.intel.com, link@vivo.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, opensource.kernel@vivo.com, rppt@kernel.org,
 ryan.roberts@arm.com, urezki@gmail.com, ziy@nvidia.com
References: <20250317055304.GB26662@lst.de>
Subject: Re: [PATCH] mm/vmalloc: fix mischeck pfn valid in vmap_pfns
From: Huan Yang <link@vivo.com>
In-Reply-To: <20250317055304.GB26662@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWPR01CA0045.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::15) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEYPR06MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: db1f3062-0572-4421-97e6-08dd65273f91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXg4eEMxQUZXRHFhNEhoSFI3TVovZTBNNHpZdU0xWnRxckZLeU9KdFhPWDZC?=
 =?utf-8?B?aG1UbTFxWWNueHNKTG1tNlpqTTYyTzRmckx6cHhzL2JOdDlPYTRIMlVtUXQv?=
 =?utf-8?B?anJEQzE3NUovQnN2b1phTW9nU1hiRUZvWE10SGx6dHhIQWZWYk9jNjVMWlpr?=
 =?utf-8?B?cG45djBZN09OVVdLeVc5alNxUHRSSzhrVDUyYnRRYmxIc1FZTHp6VG5NajZQ?=
 =?utf-8?B?eTNNK2ZuVldnY1QxYWEwL0hpQ2RsNGQwdzNucXkvRkVndFdMdWNQL0xzTFor?=
 =?utf-8?B?eE9LQXVFVE1wa1FCdHZkR283c0loYTdEdTRLRGJ2SlVDWitvdnlmL3JmSFdy?=
 =?utf-8?B?QXMzSGF0SnhENDhmbmFKNFZiaXJZbjUxSVEvRDFlclFhQUZoc1hZdHVQNDJP?=
 =?utf-8?B?MUtGcDdhNWw5b3RYL3d1VXJXNndCSUlYYzMySXgwdHR4SlBieFM5bDV0TzFZ?=
 =?utf-8?B?L2lyUEhadEs2TUdPcS90Q2tKYXpJNUtQSDBxcG94QUZVVHRGQWU0OXZZUFR0?=
 =?utf-8?B?OTU0cmw4RDVIeWtCQ3FwZ1pIcFdCZ0x0aytXaXJGelB4anozVit2UTVvZlFp?=
 =?utf-8?B?L0RTVWtCRHlYelUzeStsUWFRK0lxQnM0eHo3bWE2Tk1uTTNOZEZHYmdpdFlp?=
 =?utf-8?B?Nkhpd3NueHVxT1N0K2hvZXluSys2djRaUGFSMWpMOEs5TkhMUSt3UURyM1pC?=
 =?utf-8?B?ZjlnSnl0ZERFc2NZNC8ranBCd3F5aFZCeE01VnVVeXIxUWdheG5oQlNPR0Fx?=
 =?utf-8?B?ekpDRklHRkk1dy9NdU1PeUhRTm96V1BrbEVYaW0xcVpBRFY2Rk9ONjZYZEl1?=
 =?utf-8?B?NTgvV0RqVHdIT0VDY3JLRGF4YkEwMlpuSFJMTTVUbUJTaGVmYnFFdGJlSGR4?=
 =?utf-8?B?UXNvRVIxeE0wUGlyc3p0ZWR1eTVlUUV3eHpwT0tiZllqWUtnSWM2SHJnNnIx?=
 =?utf-8?B?K0s4TmYwUThRZ05FbTVxYjdnOGUwSk9CaGFtZHBuZjVyaS9BdG5hQkYrUGp6?=
 =?utf-8?B?RStma2hUV0hQd1FHeUlWeU80NDdPREtCUURRdWE1djBpNFRGRlZNb0lEaDY0?=
 =?utf-8?B?RWgwNDErajRiTk91Zis5Ylh2aCtUdVkxeUhIWjJJbVlkSys5MHJiVXZkUGlE?=
 =?utf-8?B?aHBJZlNYdDVkMUY0SlFsZ3JLR0lxMmFjWnlpZENEUUw0S3ptT09uQTNXQnNr?=
 =?utf-8?B?VUNxaEw4S0I5SkdlZE9ZekFhWERDcjJkUDRiMThMbFE3NUZjM2N3cGpBdmlP?=
 =?utf-8?B?ZkJ5TmVtQkZIM3Rja1FWa1YzVkJmN0JxeDhGQ3IyYnY1czhONnhlNzNxcnE5?=
 =?utf-8?B?WTZJOHNOTWVraXBQNEVoMlpYK3JEQ0NKUEtsbFpQSktlUEp5UXdmd0pWbWdZ?=
 =?utf-8?B?MHJxcGdNcE5JZUZ4eGtLd25mNzNXT2pmN3VhNFVvbVFDTWU3RFk2eW5CcDha?=
 =?utf-8?B?NHpKMWdWcmhUZmxXTU1ML3NBUlRCdExTbzlqcVgvK1NnZk1SaXhuVitrRmNx?=
 =?utf-8?B?VWtGZjBYTzRodHRIT0ZYSGpjQVFMVHVyQTlyL3Z6TDhYTzVYVG1PT3dEd25v?=
 =?utf-8?B?endBeUZGTm5MQjdTZ1hNcStpWENlcDIwNytHSG53L3RSWERNK3FxWE0yc2dS?=
 =?utf-8?B?U0xwSlJEZ0syazZVWW96L2Mra2FxYTdWc3JPT1NOalhGdnVWTnBCNmRKOGc3?=
 =?utf-8?B?UFpBaFdTdFNqVTRYN042cnAvbGovUk9hTkRCVFE5Y3hRZEp0UDBkSzNuL25D?=
 =?utf-8?B?UVNUN3YzWlJTNEsvdHpHaWFSbnFsMjBVQngvRGRlaGcyYWl2ZTE0cnJ0UGFC?=
 =?utf-8?B?RXE4aThjbnpkTmhtQlpReVRIWll3bnQ0bWlYVWxOUUF6Ui8zVWZPS3dLZkVS?=
 =?utf-8?B?akYzeFZHNTdiNlVIQk5mSHJTUDhaZndFeW96eWVQVkNXcExTTDdhUitROUdi?=
 =?utf-8?Q?qqMWd09bVFJMY3TZOysuBDo7epaXD+II?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3h0ay9tenVOYUN2dFNWaTBEc3ZkbzU4WGd4VlRUcnp5NkkreW8reWVocEZZ?=
 =?utf-8?B?MVpleTN3Z2FGSGVXdkNrT0RDR3hEcmlzUVRyWUhZeU5jSHRBbE0yWDl3WEpx?=
 =?utf-8?B?ek9WanZyZ0hmMVEweGlGN2NDMTUwUjFjTTI3d2dvdzY4Skd4TjJNVzhzcC9U?=
 =?utf-8?B?WGVaYllBblhxOFlxSU0xRm82NWFNdnltL0M5aUFRa3dzREtQNnhOUHlZSnM2?=
 =?utf-8?B?c1B5S09UcDhuc0ZIU3gwc2hXUTc5TDFYREthN0NscHJUbUNHMjZMYm9KQklk?=
 =?utf-8?B?THQ2ckR4OHpmWTl2ckoycTZEYjBxQkNFSTVZWkZ1YWU5cFc1WGN2dmNmTVNM?=
 =?utf-8?B?akFwVytqZTJoZ1ZFa0J0TElWVHdxL2xaNlYrM2dYRzZJN0l1alBuQ2tDOGV6?=
 =?utf-8?B?ZUtqTUgwa3JOZ1FYZDhRcytJNmtkbm1GWEtGa2JjWjNETkRENjc0K21GWkRz?=
 =?utf-8?B?Z3NnY2syU2pQdHUzNjlab0NVa1lJVFY1bUFWS0VuaHhPU3VPSUZjV0tOUTRS?=
 =?utf-8?B?RlFLYy9LbVVnNGhHdEtrU0RHZHovbzI1cWVEd0IrZjIwSkZSaTl3N2RmZkc1?=
 =?utf-8?B?OGwzSWs3VWMrQUhzUzYwbDFpUjQyb3BGcVR5SzJmVXdvQ2ZqdHBXNGw1VGN4?=
 =?utf-8?B?bXRzL05EWGo5bWpJWnFQS0tldEd3NmJJcGx5Y1RtVFlPTEZ1dHppdEEwVCs3?=
 =?utf-8?B?SXhwVXdMdGtzY2pnTUN2TWQxVXNzK0QwYVNORng4N1lKMERqMnZWUmlHMkZv?=
 =?utf-8?B?V2ZEOVNjMlRmUEpYVjVoS2hudVFBMjY3ZDA5QlVYOGtJK3ZSQkJZYW1GT25W?=
 =?utf-8?B?bjVnVUNnYStaK1RPcEliVU9UeSt0MTNkOGY3T1JBSkxWdU92NVI0S0Fpb2xK?=
 =?utf-8?B?YWc4L0JtN05KUk5XZ0pzQmFvb21RZGl0NU9hU3FvNXovbTBiUVRKcFFOVWlz?=
 =?utf-8?B?dUpBMjdvY3hUUlFhd2EzVWpxbm1MRkF6Q0plTFB4bTdUaVhtVFp0UXRzVW00?=
 =?utf-8?B?Z2tzZkxIb05MekJ0MXZMNDcwRG43OXptRnJmY3FyR296Ym93VW1uYnpqeFFy?=
 =?utf-8?B?c29iV1VBOEVnZzh4cUpaS0RuQW9TSm9YSG5OOVArSVhKRTQ3ZUNmRlptWXJv?=
 =?utf-8?B?d0lCZWJVeDA5cGxlVWNrRkZobTNTUENPRUM5RG5QMFQwdi9XdytPNjdOM1Bv?=
 =?utf-8?B?ZDJVeVR5dHRsT0pRWUkvYkJKdTh5d285R01nQS82TFBtMXFIWE8vQ3BwQXNI?=
 =?utf-8?B?amZIYi93b0trYmlDUEloSURXdkRONUZ4RkhJajVyMzl0dVBESFhJSDlodWha?=
 =?utf-8?B?eGYyVDlaais2RTVjRGZlK2owTTR3cTFoME1TejhTenprWmtVQlpLY2R3d2d1?=
 =?utf-8?B?bHoyUktRVG4wbDQrUzdtUmM1TVpmK2NWOEo2WnJseS9ueEhTZllUMFo5Q2dK?=
 =?utf-8?B?cjlaZ3M1ckJuS21WZWhVbVFvOCtyWStmSnQrVzEvTWZVRkNSTXdUc3ZFcmFV?=
 =?utf-8?B?aG8vS0NYcDI5VGViZmxmdjFHSzVha29uV2ZhUlRFSFdrdjBWZWRBQ1NlOEtO?=
 =?utf-8?B?WDYrdXY2emtURDZrS0lwM1hxV1ZwcWxLSUQvVHB0QldyYnk0SE00dU5uVjdm?=
 =?utf-8?B?QmVHb2xwTzNnZXQxVnN3N09SMFlpNVAyR2J5MHg4bnJ4YmdKV21oN05kYWF5?=
 =?utf-8?B?eDRPcERHem4wVWh4dDVMWDJOWkpuU3lQTldPclpFTmlqWFNSc1VzZTBQeU1a?=
 =?utf-8?B?RHk5MTNLZzBjQzVYdUM5TXZxd0NzMC9yd3Y3ZEpTR3lGdGNYSjEvT0UraWdh?=
 =?utf-8?B?dFBwT2FPNEhTQXB4by9aMW9qemVXZEtrZTExbnpjdjNnckFWTkpTRGU4Y0R3?=
 =?utf-8?B?bDFPTWhxNFhPdkNtVHNUb1UvNzAwaThNMHdUT2NzOW9BT2NicDZ0VFhrM29R?=
 =?utf-8?B?ampaTG11Y05PYVZ1L0VyUmhXT0NPb3JldDVMcWt3WkNuRXh5YlM0ZmFSRGtH?=
 =?utf-8?B?bERJbmlSazVIWWZjTnhrT3pVVWpaVFdlT2Nwb0RLV2l3WE1wWjFldUJHK3cr?=
 =?utf-8?B?bGYxdUJHUFlaWHFWS1NkeEVrdnZvQkwyS2NVSW9JQnpEOXRGc1hmdTlRbzU3?=
 =?utf-8?Q?jssEU2oZznFWa32LZMP2RP27G?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db1f3062-0572-4421-97e6-08dd65273f91
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 07:42:20.4311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TAn+MoKEry7cfWxTDpWtovodacvsCtPCSFyKmSL3S1rWNovAraUWb9f6QyEshsqDW/BpOvZE0D0v/IaMIpOU3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6226

HI Christoph

> On Mon, Mar 17, 2025 at 01:29:05PM +0800, Bingbu Cao wrote:
>> Why not update udmabuf to make it work with both vmap_pfns() and >> vmap()? As only the udmabuf knows it is actually working on? >> >> 
I don't think it's a good idea to hack the common API, the WARN_ON() >> 
is really a mandatory check, and current case is a good example.
> What non-page backed memory does udmabuf try to work on, and more
It's HUGETLB which enabled VMEMMAP_OPTIMIZE, all tail page's struct will
ref to head page struct, and then release tailed page struct.
> importantly how does it actually work on them given that the normal
> DMA APIs require page backed memory.  Or is this just made it up
udmabuf's sg_table ref only folio+offset, no any page struct ref.
So, any DMA APIs just use folio based.
It pin each folio given by memfd&offset.(memfd can be shmem or hugetlb).
So, shmem memfd can get page struct, hugetlb's may can't.
> and it doesn't work at all given that it also tries to dma map
> to the fake miscdevice struct device which can't work for most
> cases?
This implement map_dma_buf&mmap&vmap&begin/end_cpu_access.
It's simple implement.
>
> Mapping non-page memory is difficult and without having coherent theory
> of what non-page memory you are mapping and being very careful you
> are extremely unlikely to get it right.


