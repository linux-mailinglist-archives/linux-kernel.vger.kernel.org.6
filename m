Return-Path: <linux-kernel+bounces-327220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD76A97727F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42BE71F24B92
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D2F1C173F;
	Thu, 12 Sep 2024 19:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n42Rbc3u"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC4C1BF7FE
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726171077; cv=fail; b=Epy4z1GyokufkTP4JgIphouVjcCjt94jIYKFj0LG0Bz0L858fRkKRRwIoLO5rEyQ3axBpSjyemcc9dJkfThsG+bJC15d7yoyRQXOtgwr3volI0h4c6dhetGPzLj9pzj21FPSmUSFkaYu6ZhkzfOqZk6D7P5wlXtGH6Hd4Tk6dko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726171077; c=relaxed/simple;
	bh=CdrUl/v6qU6+GxHUrSOhlbapmT93jPR7+4nNmuzHEFQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aUY6Px4g6rgVvRL95uqoFrrK8+VUlTH/fC2c3d8lGHgc+U/Gwi/bkabB1hg3Ja20OL0d2UjMl3t1M2Y+8cvaezV+mUoZKkOqVUL4UrqwfCPTqrE3PLFG0vyt/BpI9xSA4gCHYT5KXfh5fc0zhOK7zF9Av836Mi8bIM1mivEKGFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n42Rbc3u; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gd4TDtwNgN6vK3Ms5wJJd1IP4Vn8Lhm5/YI77zABwyT0gnAB5wiNpI6WKq4TCUuDto8K1uXThNSYaIyka4oPSb+T0+cz/zDxLaOzXMXpTEt4TeZwxKhPJb4f4snlTIwxndZCFPMq+//n67REgLLhbidmNluNHI1mLKW6ToTX5otwSv9ouNsfgi5iNaHCaBG/uQlnWDcRBmrzNsHOaO4xseSAQmuPvPewSN515cpRtOBwbazO4SQGRTufErYGUYXasseL7YVhKsoXv6tCyD1BrWgSSlZSl55cY93HUIcL39/cnN3KoTrf+Fs3+GxpTsmcaKK8NKdGE/E7Sy7qkE/ckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdrUl/v6qU6+GxHUrSOhlbapmT93jPR7+4nNmuzHEFQ=;
 b=p7xpO71tArgGHbp4yyxne3n8VCMjsLxc0ZWsZrAuhOB8JpZ+PUYRV3WmLQ367MZoxG+789HOucOz8gUmTEHncCVMIo4hX4vIOrmo/8U23ApldOm6ERXy2GFZ8TdUsF2gRTb00z4SLs3nHAP+MjUMvzENiQ04voHagAY6+/tDtB9Q3oXR4/PfuVOdrqEO9j2OM45ZYBjxtbDb8wbamuM26XQrPMSc5R1978EG0Amfncp0FczHq6bW3/V6AKf+8xwOfUhV7jfdGZfYrTzoUzuyBAuhd11caFSCCze2sZaeETKmHs8DCSizimUG7AdmmpGizoLWdYZRCBLA+1VbPGyfSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdrUl/v6qU6+GxHUrSOhlbapmT93jPR7+4nNmuzHEFQ=;
 b=n42Rbc3uTcnXWcoQyc+3x0Y3THWcl0ZtxvIyo7mwrZ2tkWqd+9fFFKIkwqGusmWZ/WnwqG0sUJbustf/k78KzYlKpgMslmPY/c42MPzF0scl8Zjk/IWOBGiwhMGHUqi5Dh70AgpNOtSRo7c2rbJxHKSY/C99/WZz9O9cIVKtZKA=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by DS0PR12MB6536.namprd12.prod.outlook.com (2603:10b6:8:d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 12 Sep
 2024 19:57:50 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.7897.021; Thu, 12 Sep 2024
 19:57:50 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Dave Hansen <dave.hansen@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 27/34] x86/bugs: Add attack vector controls for
 spectre_v1
Thread-Topic: [RFC PATCH 27/34] x86/bugs: Add attack vector controls for
 spectre_v1
Thread-Index: AQHbBUtAYS9nEfikDEWFe8hVs68IMrJUjQ3A
Date: Thu, 12 Sep 2024 19:57:50 +0000
Message-ID:
 <LV3PR12MB9265FDD41382B1271DB0305E94642@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20240912190857.235849-1-david.kaplan@amd.com>
 <20240912190857.235849-28-david.kaplan@amd.com>
 <8a406835-b985-415a-a944-25d0ebea4fd0@intel.com>
In-Reply-To: <8a406835-b985-415a-a944-25d0ebea4fd0@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b85afab1-34b8-4c4c-8146-c10da2149a86;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-12T19:41:54Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|DS0PR12MB6536:EE_
x-ms-office365-filtering-correlation-id: dc7f7018-22e8-4d62-e24f-08dcd3652eaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?YjJ4cUdFSGRHd1RoUUU5SWtPYlphWEpGUmd2ZlRCWmZ4VENMZWdUeFBsS2NX?=
 =?utf-8?B?cU9hVTlaMENweHF4MzJUYTloakRPOEtOUzI0UXpoZlJnbVVGQldFM0hKLzBp?=
 =?utf-8?B?ZGh6SWtmT0laOWlUR2JpV0xNaGVHTnM2NjJVbFU4UE1QanJTN2dma2V1RzJk?=
 =?utf-8?B?ek9tRlUzMjE4a3UxZm56Vk1ZRmQwYVJEMy9DL1NlTy9IYVlSd3EvdnBFUmtw?=
 =?utf-8?B?R0szL3oxSnpVQThmcHpyZjNkOFZVL3ZWbDh3ZkJyWDZhSS9SN1dQb0dsTTZ0?=
 =?utf-8?B?ZHNlMU9ZQkljVStUMndscDJyQWRmZ0llS0hXeGJRTkhucFkrekFNTUpyWWdZ?=
 =?utf-8?B?bU5LYlZiTk1MUkxhbFp2bDFNVCtHV0NSRzdwcmduY011cmgwZzVnUWovMWQv?=
 =?utf-8?B?UzhlV0dHdHRxb242ZXp6ai9STE5KM3gxVFpObkJDUDBZNWxieGVocFdLRzFY?=
 =?utf-8?B?UFEzbTg4d0UxTitEV2Vadjh3S1g2LzdtUGROdXZqaEtkRnhMcjZaRHpCbVcz?=
 =?utf-8?B?NVQvUEp4OU9KSXJJM1dkOXoyUlNBRTdwc3B0cDhBL3E2aXVnNjJGcUtZck5D?=
 =?utf-8?B?YXU4ZlcxNlFhamRLU3h2QnAwWmduS0tGbUEySFpvY2x6L3FrYkRCWG1DTElB?=
 =?utf-8?B?cHpwZm15Tk81VTd6ZmxCVkx0eWFHa2tzVlZpUUFFMTN6OHA5MVZuVDFJOW5Q?=
 =?utf-8?B?d25mVXpuVXhiQUNlWWFIWjlTdXpaRnBERXNwMlBPamNxWHRPbkhtbjcwd3E0?=
 =?utf-8?B?RnhqcnJjK0M3Wnlva1A4QTNzbXRTWjhSUkVQS1p6YkZRd25ObHVGdmhEekgy?=
 =?utf-8?B?SzJja1dhcC95VVpiRWxuQ2IxOFIxYm9aZFRCL1F3SC8yOW1QYkJqeDJxTFBU?=
 =?utf-8?B?S2pXMkdOaFZLQWlERFcyUzVlTGpUR3JsZXZXOGxWbUlXa2dhc3dxYjFGRWRV?=
 =?utf-8?B?RWp4MjhUck9ITHlTT0krVk9RM3N6eUQzVHlvRzhCVFpmUkVDMkdlWUZHWVBM?=
 =?utf-8?B?Q01XeHluQzFvbXRObEl3MzBJVGJVbjlMOGR4Qk5CWFQrekRwVkpCUXdlZXpj?=
 =?utf-8?B?aGxBc2RBenliVmVveTI0aVNUUEJBQXo3ckZ6bzk3eS9SRnc5c0E5SUxzSEpY?=
 =?utf-8?B?Q1ZzK3dTaDIzVjZRRnhNSnFkQUJhVUNGa1FJcHpEWkFueTF4eVJyd2dRVkhC?=
 =?utf-8?B?TkYrV1I5VEc1cTRTcWNBaGZGZ25KTjhMQ0xRYXZqSU9JZ1pxazdXVEJLbmhs?=
 =?utf-8?B?c0hDNGNjdU5aS05STVVzTHZ0RkZZR3RpdEF2UDRXdGV6anRVbkJJYUlGUGJL?=
 =?utf-8?B?ckZqbTYrYkhFdVgrSzRMSHdzY2VvSnRSR3BkRk1BZ0dSZkgrNGtKdkdWWVY3?=
 =?utf-8?B?TFc0SFhzcGNVcHlZSTNPbGJjeVZuY3dqVnpTU3lRYXpOekUvUDFoNndNb3FX?=
 =?utf-8?B?TVp6b1pPTWZFVDZCVER4c0NWVUltRHJkTUxrZTE0dU0vcmd4ZTJOVXg0anJD?=
 =?utf-8?B?ZnArL1pJQVNSRUh4OHAxQVIwcytoUzY3OU9md0NjamdxYklSRU5qZWIzVEhP?=
 =?utf-8?B?ZHdXemYvVGMycnQ1U2pjZlNBaStEZXRScXQ0RXkveXYzanBuQVB2bXh5QVZX?=
 =?utf-8?B?YzZ2Q1dMSDc2VWx1NVh1NVh4WXNEZmtScnkyWVNuV2N4VXVQWi8zNVFjYTgw?=
 =?utf-8?B?YXlObTRmU1NhYnhNSm5UQVNvNWx4QndWd0FENzVrN3A3WmxiWFRLSWt5d252?=
 =?utf-8?B?RnJ0TWhua3luVGdGUzlNZElxNnZkYkpGUTZzZERiYmtPN0NGbnFxWUcxNFVY?=
 =?utf-8?B?dys5WnVaSVhiVHZpdkgwRVN4aFBlaUVCaXpic3BvQUlNcFN1ekU2QnpnVi8x?=
 =?utf-8?B?aHJYc2ZuTVUvTFJDdTNHZjVhOXl5UjNBS1VXSUxFSGRIS3VOYm1GM0ZIRHZk?=
 =?utf-8?Q?fV35szbLZI4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eHpqV3A2N3U4djBJMnByeE9vTXJRb0J0U2k2c0xRM0hxbThiVEo3YUo0cFdI?=
 =?utf-8?B?QXk3Y29peGZCUVA5T3p1ZW5zTXRTeWE1VTNzckhJdmgzajJlc0I1TThPS3c5?=
 =?utf-8?B?SE9VZDdEMVpLOHBJQkdDbjJRL0ovakpmYjM0ZHVRQUNFaHpFSURKYlJ0dkx0?=
 =?utf-8?B?NEY4eEFwUzNPRzBtdWZjMzVvMS9ybWw1cTlIR0RNTjVUWkxTeFh5WWVLQncx?=
 =?utf-8?B?aGtZdkJlK0loekxxNkh3bUl6bDhYaXVoMjlKRWtTVk9mTURvKzQ4cFE1MFVy?=
 =?utf-8?B?WFhqLzlMbS96RHpXU3daN1pnd2pHa2s2N1RGS1pqd2JPWFZHU1lUSDY1UU9o?=
 =?utf-8?B?U2ZoaHdlSFI4K0ozRXNjQktsLzlaM2VIS3BOOTZreFVKeUo0cXZoWVZBa2RT?=
 =?utf-8?B?UG9PTE9DT0VwQ2k4R2RCcTlnUjk0TXZpcG4yZkhJUUMzNFUyYnNaa2w5Qmpn?=
 =?utf-8?B?YmlwYjZVLzdtVDVwdVhMT0k5SjJEZ0hFcmpFN3liMC81aktwdC9najd1SGRs?=
 =?utf-8?B?TDFtalFJNUVFYzhjd2VTTi9hUFNaR253WFhOdXFlelFDUjRhclZPT0tYMzVh?=
 =?utf-8?B?SEE4NjdnNkJVWndrMUlaNzhUaVkvbVVlZ0FqUVBMNVRleVR0dENYTWlzT3Zi?=
 =?utf-8?B?WkpLZjhnTTcyeE81VkR1dEk3ZXNOenZtbzVKUFB5MUdOSEdzUUp0TGJXSzlQ?=
 =?utf-8?B?SFl6NWhmRkxJQk82bWtuK2E3UHhkM1hqdnhtUzZWOTdrVlUzRjUzV1JKL0NH?=
 =?utf-8?B?cFpyQmdOSHIydVpmZDBObVYvdEJCNS8xMTZOa3I3Y2RhczNsaTM1OTR1aE1J?=
 =?utf-8?B?NDByVWlrUklYWldaNDlySXZvRExuSVBYRVo0ZHpVL29rVll6L0JweEw3R3VG?=
 =?utf-8?B?ZXJOTnR3Y0RWMmprNUE0b0tQbkw4VzVrRG5mK3lPM1FzWVRKdkxPdmU5K09E?=
 =?utf-8?B?Z0pEZmJqZTNnSlB3Qm1VZXhxQVJNaU54SXlRcU0vbUE1LzMzMUVMY0Z2SnJr?=
 =?utf-8?B?R2dtb1BFS0p5ZG5vVU5ScytvNFNkVkNkblJCbyt2WjFNRlQ0cXUyMXhvVDFx?=
 =?utf-8?B?MW96dGRIMEpORnJpWkhKMVUvQzNFc1pwcGk3MGJCcWdTbWl1bVIwcjFwZVpt?=
 =?utf-8?B?M0ZsdkZvUlFCSHVIUDgxSnBEbWtEYU1oUDIzR1ZvZE9lUlhaYTFrb1RTMUhz?=
 =?utf-8?B?WnUrMHlkQTNGM2pqQk1nNEFwNmYxcldjUHc4ZnVJSllYV0dwQjZkbFU5NHlr?=
 =?utf-8?B?RjFhRkE5ZW1Ha29kTGRGdURoTG5GVC8xcmlDT3NmeU00TFFZVEdEajFYZXVT?=
 =?utf-8?B?bFpNTGJtYTY0a1BXY2U3dlpkYlJaSGhQa1ZOeWVKMVBRaG1oTXZrSGZFYkcz?=
 =?utf-8?B?ZFl3QzY2WmRtREplQ2RteE9sV2dkQjVaWnlQZWtYbXBieTNxSExaZjVqR2ZJ?=
 =?utf-8?B?dDd3ZitiZlA2WTZnczY0Y1JBa1F1Q2g5NGtDdmQwemI0K2Q5MmJyUFZ4SHMv?=
 =?utf-8?B?a0txYTJua1gzT054ME5xQ29jRDdEU1RqTC96dEU2MDR1allTeE1IRGZZMTRH?=
 =?utf-8?B?WnhwbTB5c0Z4a2N1NGk4Um5GMzc5OCs1d0JEcFVOcDZKbVlsaHhUVUdFSEl1?=
 =?utf-8?B?amtlTFJ0TUxlRjJubStRTWZkZjZQaXNncUFNSFhLcHBYTVdPa21UTDhNOXZE?=
 =?utf-8?B?UU5hTUZmbXIyb3pzbXNRRDNTSEFoaXR4R2tVQW9FMXEySGpHTVV3VXl4S0d0?=
 =?utf-8?B?Q1hIWjZnaW9MNWZVWmFmR1pJVHd2L1QrQXYwd2tGTDNwL1FJNlBIdklPK0tu?=
 =?utf-8?B?Z3YyVk9XczZ3QTYyV2FjT1lYeFNKU00vKzdEbFdIVUVzbUs3bnJVeHowbzZT?=
 =?utf-8?B?eUp2UzFYVlFjbElwSVQ1SWFJYmtXcTVkdU9kandDdjNwVEJVTUN1MHMzYnpJ?=
 =?utf-8?B?eENqK21IL0pKbzZ1L0lmZ0cvMFZKTUx2M3BXNFhuNGdkb2Q3WEo1Qzc3MmZp?=
 =?utf-8?B?ckRKWTNYQnNHbmpKeGlhY0o2YktPZE1GMUlJM2VtcVBLTHpFMjJYUG52YjNa?=
 =?utf-8?B?SktiOU5BakpweEh6ck50YnhBQkRxSElHUUgzdE9wSzhVY0FJZjk2OXhrV0gw?=
 =?utf-8?Q?zN5o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7f7018-22e8-4d62-e24f-08dcd3652eaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 19:57:50.7760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +WN94oPygWnSEfyuGBogSYnb27AGDkkwvIHFlcEkyN6YCgbiYkYVppJer1Sd8iDz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6536

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZlIEhhbnNlbiA8ZGF2
ZS5oYW5zZW5AaW50ZWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDEyLCAyMDI0
IDI6MzcgUE0NCj4gVG86IEthcGxhbiwgRGF2aWQgPERhdmlkLkthcGxhbkBhbWQuY29tPjsgVGhv
bWFzIEdsZWl4bmVyDQo+IDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT47IFBldGVyIFppamxzdHJhDQo+IDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IEpv
c2ggUG9pbWJvZXVmIDxqcG9pbWJvZUBrZXJuZWwub3JnPjsgUGF3YW4NCj4gR3VwdGEgPHBhd2Fu
Lmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT47IEluZ28gTW9sbmFyDQo+IDxtaW5nb0ByZWRo
YXQuY29tPjsgRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT47DQo+IHg4
NkBrZXJuZWwub3JnOyBIIC4gUGV0ZXIgQW52aW4gPGhwYUB6eXRvci5jb20+DQo+IENjOiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDI3LzM0
XSB4ODYvYnVnczogQWRkIGF0dGFjayB2ZWN0b3IgY29udHJvbHMgZm9yDQo+IHNwZWN0cmVfdjEN
Cj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBT
b3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNs
aWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiA5LzEyLzI0IDEyOjA4LCBE
YXZpZCBLYXBsYW4gd3JvdGU6DQo+ID4gQEAgLTExMTQsNiArMTExNCw5IEBAIHN0YXRpYyB2b2lk
IF9faW5pdA0KPiA+IHNwZWN0cmVfdjFfc2VsZWN0X21pdGlnYXRpb24odm9pZCkNCj4gPiAgew0K
PiA+ICAgICAgIGlmICghYm9vdF9jcHVfaGFzX2J1ZyhYODZfQlVHX1NQRUNUUkVfVjEpIHx8DQo+
IGNwdV9taXRpZ2F0aW9uc19vZmYoKSkNCj4gPiAgICAgICAgICAgICAgIHNwZWN0cmVfdjFfbWl0
aWdhdGlvbiA9IFNQRUNUUkVfVjFfTUlUSUdBVElPTl9OT05FOw0KPiA+ICsNCj4gPiArICAgICBp
ZiAoIXNob3VsZF9taXRpZ2F0ZV92dWxuKFNQRUNUUkVfVjEpKQ0KPiA+ICsgICAgICAgICAgICAg
c3BlY3RyZV92MV9taXRpZ2F0aW9uID0gU1BFQ1RSRV9WMV9NSVRJR0FUSU9OX05PTkU7DQo+ID4g
IH0NCj4NCj4gSnVzdCBhIGhpZ2gtbGV2ZWwgY29tbWVudCBvbiB0aGlzOiB1c3VhbGx5IGluIGEg
d2VsbC1zdHJ1Y3R1cmVkIHNlcmllcyB0aGF0IGhhcw0KPiBzdWZmaWNpZW50IHJlZmFjdG9yaW5n
LCBpZiB5b3Ugc3RhcnQgdG8gbG9vayBhdCB0aGUgZW5kIG9mIHRoZSBzZXJpZXMsIHRoaW5ncyBz
dGFydA0KPiB0byBmYWxsIGludG8gcGxhY2UuICBUaGUgc2VyaWVzIChhdCBzb21lIHBvaW50KSBz
dG9wcyBhZGRpbmcgY29tcGxleGl0eSB0aGluZ3MgZ2V0DQo+IHNpbXBsZXIuDQo+DQo+IEkgZG9u
J3QgcmVhbGx5IHNlZSB0aGF0IGluZmxlY3Rpb24gcG9pbnQgaGVyZS4NCj4NCj4gRm9yIGluc3Rh
bmNlLCBJIHdvdWxkIGhhdmUgZXhwZWN0ZWQgY3B1X21pdGlnYXRpb25zX29mZigpIHRvIGJlIGNv
bnN1bHRlZCBpbg0KPiBzaG91bGRfbWl0aWdhdGVfdnVsbigpIHNvIHRoYXQgc29tZSBvZiB0aGUg
aW5kaXZpZHVhbCBzaXRlcyBjYW4gZ28gYXdheS4NCg0KSW4gdGhlIGV4aXN0aW5nIGZ1bmN0aW9u
YWxpdHksIG1pdGlnYXRpb25zPW9mZiBvdmVycmlkZXMgZXZlcnl0aGluZywgZXZlbiBvdGhlciBi
dWctc3BlY2lmaWMgY29tbWFuZCBsaW5lIG9wdGlvbnMuICBXaGlsZSB0aGUgc2hvdWxkX21pdGln
YXRlX3Z1bG4oKSBpcyBvbmx5IGNhbGxlZCBpZiB0aGUgbWl0aWdhdGlvbiByZW1haW5zIGFzIEFV
VE8gKG1lYW5pbmcgbm8gYnVnLXNwZWNpZmljIGNvbW1hbmQgbGluZSBvcHRpb24gd2FzIHBhc3Nl
ZCkuICBTbyBtb3ZpbmcgdGhlIGNwdV9taXRpZ2F0aW9uc19vZmYoKSBjaGVjayBpbnRvIHNob3Vs
ZF9taXRpZ2F0ZV92dWxuKCkgd291bGQgYmUgYSBmdW5jdGlvbmFsIGNoYW5nZSB0byBjdXJyZW50
IGJlaGF2aW9yLg0KDQpGZWVkYmFjayBvbiB0aGF0IGlzIGNlcnRhaW5seSB3ZWxjb21lLCBJIHdh
cyB0cnlpbmcgdG8gYmUgY2F1dGlvdXMgYWJvdXQgbm90IGNoYW5naW5nIGFueSBleGlzdGluZyBj
b21tYW5kIGxpbmUgYmVoYXZpb3Igb3IgaW50ZXJhY3Rpb25zLg0KDQo+DQo+IFRoZXJlJ3MgYWxz
byBhZGRlZCBjb21wbGV4aXR5IGZyb20gaGF2aW5nICdlbnVtIHZ1bG5lcmFiaWxpdGllcycgd2hp
Y2gNCj4gYmFzaWNhbGx5IGR1cGxpY2F0ZSB0aGUgWDg2X0JVR18qIHNwYWNlLiAgSWYgdGhlIGlu
ZnJhc3RydWN0dXJlIHdhcywgZm9yDQo+IGluc3RhbmNlLCBidWlsdCBhcm91bmQgWDg2X0JVRyBi
aXRzLCBpdCBtaWdodCBoYXZlIGVuYWJsZWQgdGhpcyBwYXRjaCB0byBiZQ0KPiBzb21ldGhpbmcg
bGlrZToNCj4NCj4gLSAgICAgICBpZiAoIWJvb3RfY3B1X2hhc19idWcoWDg2X0JVR19TUEVDVFJF
X1YxKSB8fA0KPiAtICAgICAgICAgICBjcHVfbWl0aWdhdGlvbnNfb2ZmKCkpDQo+ICsgICAgICAg
aWYgKCFzaG91bGRfbWl0aWdhdGVfdnVsbihYODZfQlVHX1NQRUNUUkVfVjEpKQ0KPiAgICAgICAg
ICAgICAgICAgc3BlY3RyZV92MV9taXRpZ2F0aW9uID0gU1BFQ1RSRV9WMV9NSVRJR0FUSU9OX05P
TkU7DQoNClRoYXQncyBhIHJlYXNvbmFibGUgaWRlYS4gIE9uZSBpc3N1ZSBJIHNlZSBpcyB0aGF0
IHRoZXJlIGlzIG5vIHNlcGFyYXRpb24gaW4gdGhlIFg4Nl9CVUcqIHNwYWNlIGZvciBzcGVjdHJl
X3YyIHZzIHNwZWN0cmVfdjJfdXNlciwgYnV0IHRoZXkgZG8gaGF2ZSBzZXBhcmF0ZSBtaXRpZ2F0
aW9ucy4gIEJ1dCBJIHRoaW5rIHRoYXQgaXMgdGhlIG9ubHkgbWlzc2luZyBvbmUsIHNvIG1heWJl
IGl0IGp1c3QgbWFrZXMgc2Vuc2UgdG8gYWRkIGEgWDg2X0JVRyBiaXQgZm9yIHRoYXQ/DQoNCj4N
Cj4gSSdtIGFsc28gbm90IHN1cmUgdGhpcyBzZXJpZXMgdGFrZXMgdGhlIHJpZ2h0IGFwcHJvYWNo
IGluIHJlcHJlc2VudGluZyBsb2dpYyBpbg0KPiBkYXRhIHN0cnVjdHVyZXMgdmVyc3VzIGNvZGUu
DQo+DQo+IEZvciBpbnN0YW5jZSwgdGhpczoNCj4NCj4gPiArICAgICBjYXNlIE1EUzoNCj4gPiAr
ICAgICBjYXNlIFRBQToNCj4gPiArICAgICBjYXNlIE1NSU86DQo+ID4gKyAgICAgY2FzZSBSRkRT
Og0KPiA+ICsgICAgIGNhc2UgU1JCRFM6DQo+ID4gKyAgICAgY2FzZSBHRFM6DQo+ID4gKyAgICAg
ICAgICAgICByZXR1cm4gY3B1X21pdGlnYXRlX2F0dGFja192ZWN0b3IoQ1BVX01JVElHQVRFX1VT
RVJfS0VSTkVMKQ0KPiB8fA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBjcHVfbWl0aWdhdGVf
YXR0YWNrX3ZlY3RvcihDUFVfTUlUSUdBVEVfR1VFU1RfSE9TVCkgfHwNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgY3B1X21pdGlnYXRlX2F0dGFja192ZWN0b3IoQ1BVX01JVElHQVRFX1VTRVJf
VVNFUikgfHwNCj4gPiArDQo+ID4gKyBjcHVfbWl0aWdhdGVfYXR0YWNrX3ZlY3RvcihDUFVfTUlU
SUdBVEVfR1VFU1RfR1VFU1QpOw0KPg0KPiBXZSd2ZSBfdGVuZGVkXyB0byByZXByZXNlbnQgdGhl
c2UgaW4gZGF0YSBzdHJ1Y3R1cmUgbGlrZSBjcHVfdnVsbl93aGl0ZWxpc3QuDQo+DQo+IHN0cnVj
dCB3aGF0ZXZlciB2YXJbXSA9DQo+ICAgIE1BQ1JPKE1EUywgIFVTRVJfS0VSTkVMIHwgR1VFU1Rf
SE9TVCB8IFVTRVJfVVNFUiB8IEdVRVNUX0dVRVNUKQ0KPiAgICBNQUNSTyhNTUlPLCBVU0VSX0tF
Uk5FTCB8IEdVRVNUX0hPU1QgfCBVU0VSX1VTRVIgfA0KPiBHVUVTVF9HVUVTVCkNCj4gICAgLi4u
DQo+IH07DQoNCkFoLCB5ZWFoIEkgY291bGQgZG8gdGhhdC4gIEkgdGhpbmsgdGhlIGNhc2Ugc3Rh
dGVtZW50IG1ha2VzIGl0IGEgYml0IGVhc2llciB0byBzZWUgZ3JvdXBpbmdzIG9mIHdoaWNoIGlz
c3VlcyBpbnZvbHZlIHRoZSBzYW1lIGF0dGFjayB2ZWN0b3JzLCBhbHRob3VnaCB0aGF0J3MgYWxz
byBjb3ZlcmVkIGluIHRoZSBkb2N1bWVudGF0aW9uIGZpbGUuDQoNCkknbSBub3Qgb3Bwb3NlZCB0
byB1c2luZyBhIGRhdGEgc3RydWN0dXJlIGZvciB0aGlzIGlmIHRoYXTigJlzIG1vcmUgY29uc2lz
dGVudCB3aXRoIG90aGVyIGFyZWFzLg0KDQo+DQo+IEJ1dCBJIGRvIGxpa2UgdGhlIGNvbmNlcHQg
b2YgdXNlcnMgYmVpbmcgZm9jdXNlZCBvbiB0aGUgYXR0YWNrIHZlY3RvcnMgaW4NCj4gZ2VuZXJh
bC4gIFRoYXQgcGFydCBpcyByZWFsbHkgbmljZS4NCj4NCj4gQXMgd2UgdGFsayBhYm91dCB0aGlz
IGF0IFBsdW1iZXJzLCB3ZSBwcm9iYWJseSBuZWVkIHRvIGJlIGZvY3VzZWQgb24NCj4gd2hldGhl
ciB1c2VycyB3YW50IHRoaXMgbmV3IGF0dGFjay12ZWN0b3ItYmFzZWQgc2VsZWN0aW9uIG1lY2hh
bmlzbSBvciB0aGUNCj4gb2xkIHN0eWxlLiAgQmVjYXVzZSBhZGRpbmcgdGhlIGF0dGFjay12ZWN0
b3Igc3R5bGUgaXMgZ29pbmcgdG8gYWRkIGNvbXBsZXhpdHkNCj4gYW55IHdheSB3ZSBkbyBpdC4N
Cg0KQW5kIHRvIGJlIGNsZWFyLCBJIHdhcyB0cnlpbmcgdG8gY29udGludWUgdG8gc3VwcG9ydCBi
b3RoLiAgQnV0IHRoZSBhdHRhY2stdmVjdG9yIHN0eWxlIGlzIGFsc28gbW9yZSBmdXR1cmUtcHJv
b2YgYmVjYXVzZSB3aGVuIG5ldyBpc3N1ZXMgYXJpc2UsIHRoZXkgd291bGQgZ2V0IGFkZGVkIHRv
IHRoZSBhcHByb3ByaWF0ZSB2ZWN0b3JzIGFuZCB1c2VycyB3b3VsZG4ndCBoYXZlIHRvIGRvIGFu
eXRoaW5nIGlkZWFsbHkuDQoNClRoYW5rcw0KLS1EYXZpZCBLYXBsYW4NCg==

