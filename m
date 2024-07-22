Return-Path: <linux-kernel+bounces-258703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0975938BDC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D471F21B01
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD69816ABC6;
	Mon, 22 Jul 2024 09:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="e59bWmDo"
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A0225763
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721639833; cv=fail; b=QboxCH4dlP7yBm1jPhDwAgaKNw1CZe/TLw3Trb9rt76+xYJmfQK9UgNsthLrY+7ImwQcjDWOxz5ypVp8COTKyKE5zjJiVw2uJFyDuFhfjfmCt6YahElCZQEMjkark930Ip2u7Ze6dgdkR3KHEsFIjm0W4Cz70se/aS/U1k3EgG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721639833; c=relaxed/simple;
	bh=G7BnmS/MuQUsrfDtdnK0Zan1GKwiL9Dt//XchOX9Yjk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p4mNgXRec3aCzGiAZObWYxYKELcj2hQNdV+hwJ2w0hJu+n9ReiyHmFVNHkm2nPdBqX5KuQUYAzdSbw/mptCG/9Z9k+j+AuQJkaEnOA0745UJHaIY219CJTe/jzx0zPrqikeXpBW4AZNQhk38HvNfLa62Wn7cDBz15+xadb1n/TA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=e59bWmDo; arc=fail smtp.client-ip=68.232.152.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1721639830; x=1753175830;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=G7BnmS/MuQUsrfDtdnK0Zan1GKwiL9Dt//XchOX9Yjk=;
  b=e59bWmDoYk+8j0UUiQeT7Mlo3L4Z/L8zmp2i0Q8kgwOAF+MiBDA9bShB
   byXrYwW1/dR4G8Sj5v7tgnXVxmgKZZNZiUN7E38EQR01zZrucUYY0WkDy
   tRPTyH4tWngrMSZmCGqgulvbiqMkRfMJP77tqf0H45DrG/PAM+ljyJfs5
   gw3Ih6f0q6aHXEbP4LqYG6RFrPJIc5cUrObinxp2+EXnK1meEQl7ZIjL0
   C4/RS2bjyrEsc+6V4weWN2tFY6YyDu0pHbiZ+PFK/Dlpr/8dagTTmjrz9
   vfynnc3JRloEX9gE5C3Y1gYSJEybbxTrvIT2k5y5TUWRAODApB9svbTGQ
   g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="36903874"
X-IronPort-AV: E=Sophos;i="6.09,227,1716217200"; 
   d="scan'208";a="36903874"
Received: from mail-japaneastazlp17010000.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.0])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 18:15:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TAlC/edVv9Pid35n4iQvhkeLLUiiNdp71fBT/06R16Dnx8ucTGweMwq/cd+NX6HQfF341NnaOhgdr2tiUq9HHH2kmE55fy3aJ3bU0LROWjde1ATfwBpVJa/Qri3Y2iFrMdRm65bY/ewExUswZN/JkpXvzD6YER4ejcGvqgNAxt4HvWBHOzRZLGJyD4KLqN3oXviz7sUo1uSpWOSRG1C8CU7PgQ8WTmxJgxSQekJXLDG8ro55m5Kv7iDapcxcHFoGmHBlkOiDiLiwHOI+J7ncrjEAH3lfjkhSq9mMOCYOa8iGxRz6sIt8SxXgudRNrOnIjDwTpc9QnSMUMEOyInpUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7BnmS/MuQUsrfDtdnK0Zan1GKwiL9Dt//XchOX9Yjk=;
 b=DWoiqJJNXLtKHaS9+Y74/Jn/9cRcsXMwhv/2VmqK58DhfZyXbjN2UpSFgQgH1ms3uTR13v12OFf3y/wEEVaVLdojIFj7SY0eLdCxWxsjD4i63S8XkWMyLBfuwsA0LvXR1Rdh3fNEouAyDboi0aD9ZgaVUd0bEFqqjrg39NI6/VtbLVxVUJjOLjQz0apFkR9nidQ26HPjrF2za2tJaVOcN2mw9Q/HKI4fQ9hYqU7Ng0k68DN5LrCBUBP3BlUFRkK8IEl+VICp/7eovNRx0DaO/p1c4cR057ZvZTrhTeSsF2PZsmelbuBqv6nmO1+gFUXHPjn0bmGoMTRmmB0zrdWpJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS7PR01MB11776.jpnprd01.prod.outlook.com (2603:1096:604:242::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Mon, 22 Jul
 2024 09:15:55 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%6]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 09:15:55 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Yasunori
 Gotou (Fujitsu)" <y-goto@fujitsu.com>, David Hildenbrand <david@redhat.com>,
	"Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
Subject: Re: [PATCH v2] mm/page_alloc: Fix pcp->count race between
 drain_pages_zone() vs __rmqueue_pcplist()
Thread-Topic: [PATCH v2] mm/page_alloc: Fix pcp->count race between
 drain_pages_zone() vs __rmqueue_pcplist()
Thread-Index: AQHa29xyy2u1LdKk6kSPEG8zahIvOLICTZgAgAAqL4A=
Date: Mon, 22 Jul 2024 09:15:55 +0000
Message-ID: <e33a6c42-b7be-46a0-839e-736e8f61102f@fujitsu.com>
References: <20240722021059.1076399-1-lizhijian@fujitsu.com>
 <8323327f-3386-48ba-8554-10a5a6d12a04@kernel.org>
In-Reply-To: <8323327f-3386-48ba-8554-10a5a6d12a04@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS7PR01MB11776:EE_
x-ms-office365-filtering-correlation-id: ee12f124-7b05-404b-fa45-08dcaa2ee422
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?djVmcUdibTJ4VXRVWTA3b2ltWHkyTVVUclo2WllJeUhuVzJpV09ucE1FUHhB?=
 =?utf-8?B?ZllkZURYMmUzcDJ2K3Z4aFNHMWdnS04yZ254U1YxOUNqUzAxVHFGS2hwUWE3?=
 =?utf-8?B?ZHRWaDEzVGNlSWNYZGNyeGVnbEFXdzRuYyt4Slc2VXpQYjBUV2ZyS0xheWF0?=
 =?utf-8?B?RVF0c29RMDdQZkdIQXdnVnRjZGRHTEtQSThmOTcwek9GWUFaSUQxWmZsWUlS?=
 =?utf-8?B?b0syYXZMWkFwODBFS1lHN3ErZ1NGU2cxOStuNlZ3QmM2QnFSTndOYVdMRDQ4?=
 =?utf-8?B?eFRFbENJLzgzV2FURWxQWDJzQVBtcThCbmd1SDRpNVNxZUxFeVFlei9aVXBz?=
 =?utf-8?B?aHBMTXpBTUpNMjFENUJZanp2aTB0ZndoS0hHSjdheUR6ZW9vYUdWdUt1TFNP?=
 =?utf-8?B?OW5lQ1pJb00vdjZLSXFBN0RSYXcvdDBKVlVZNWd3RzBudzlSN3hBay9IRFFD?=
 =?utf-8?B?MXV4K1BoQmdrZ1grNmN1R1pRd3ExUXF1QzltV0dhc0RXVjJ1aitJNTc2eHk5?=
 =?utf-8?B?K0RPN0NhQU50aHNoK05kbjA4NlZEZnJIR2dTRUgwd1BXZjRMcWNQU1pJM3pK?=
 =?utf-8?B?cXlJR2F2T1VoYjJiRmt6WXhXMUVhaFVFNFI0U2hyek41MmhYMXY0akdBZ0ZN?=
 =?utf-8?B?Q0YwNlRmSHR4TGRyYWZGMGcrR2duUlVQSXJUNC9zUEJoejRNS2NGa0ZkUGc1?=
 =?utf-8?B?M1JBR0N2eDRxY28venVydzZGSEw4UDRmMjBLU2dYMllYRSt6V05hRncwbUhw?=
 =?utf-8?B?OStOQ3FWUnhCTkRDOE1IUUZselE3dFYyaFlyYmhWOTEvekd6L1h1Vkt3dHFZ?=
 =?utf-8?B?MlQrR0sxbEhrYVFKSmJiWXdMejBXTjVtdm01Z2tYdUgxdjQrVHU3TitwSklP?=
 =?utf-8?B?RERaNnZ2WU5DbmMxUHVLTzZzM21zK1diY0psb0l1MXZIODdtUzAwbEVJcWVJ?=
 =?utf-8?B?SUQ2WlVKMmhzbzExZHdtYVhuN1Y4OTlmUEhRamN2OHJ4NWg4Q1BlZGtVTEJL?=
 =?utf-8?B?TWRGWVNmKytVWmFNRnV0OHJxZ3U0cndmVnRPWngrUUdFNlNQRk41L2JJZkRE?=
 =?utf-8?B?MFpkNXlINjBtWTNERnFEb0t1TSs4NWtMTTU4WHp5ekVTbUVyVnNCcDRxY0dI?=
 =?utf-8?B?b3FPV0MwU1RsZFNTL2wzMzUzZzhOTnFraUJzektTTElzbEJqb2FMa1V1TmZx?=
 =?utf-8?B?Z0xGRUhyR3htRnE3Mmo2QWx4eE5ja3krWEpRbCtIbjAvaElpYm9WQ0EzM2J3?=
 =?utf-8?B?REdCN1ZSZkIvQ1hEaDFRZmpIUVpjNkpJejdNZEZUYTBBcS9JYXdyMGhNbG1z?=
 =?utf-8?B?Z1lIaXZQd2JlSVZHZzVRZ3ZqS1NYWHFSK282QkdzVkNEc1gwL3hVeXpVQ0tu?=
 =?utf-8?B?SG1HQ1drRmxYdmRSMmhqSSttMHM0cHNHMXBXcnlzZUVQMjBTaUthU3F1SWMw?=
 =?utf-8?B?TEduYWZUem8vSjhHcGdrL2s0ek5FdDRNcHRhVXc0QVZsem4vQTQ2U2hpU0U4?=
 =?utf-8?B?dWZOM1p0TGwyeXhKVnl0Z1pwcGkzL1ZpaWNMRFRjZW1KRHZGZmptMGlsNWRi?=
 =?utf-8?B?VWUwWDJkTzB0dmRxSUdVbGJBb3Nvdy9JekFHWDN0SmJjREVjTjVtYkxRRWFo?=
 =?utf-8?B?aVRtSTB0alg5NGtrK3k3OElsdTJLK2FINjU5cHloRGdIejJoS0NKV1YzVEZR?=
 =?utf-8?B?V1dkLzAyS3NjWnQxVC9scHBrei9MQy8wNlF6VlhtYWtXUlphcktwdHZ1c1dU?=
 =?utf-8?B?RERJcVFlNGpwek8xSjNQNzh3R0V6azIzZmpYb1RFd3pEZFZmUEtOZEVqbGkw?=
 =?utf-8?B?ZTZWTzlGMERtSHFXaFdJditPaHhBcW1FT3pVMmZDYytSSnNHUVdNeTBCbmh6?=
 =?utf-8?B?aTRnL0RMckRPeEFmN3dpTUxvL2J5VUUwdU04ck5KUlltTmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Zzd2ckNld0Y5WjFPWnk2UlpWcDNiK2pVNDFHaGZ4M1lMMTBNUVpyNDBlY3Vo?=
 =?utf-8?B?bDZEcDgzT0hkWE5PMDhkVndzYzE1UnhkbTEvakxzelVJa0E2VlVEdmtsQlpQ?=
 =?utf-8?B?S3p2TW5ZUVhxNVFzYlVub0VOaTJPOGV5NlhvSTk2YVlOMEF1elEvWXVqYnc2?=
 =?utf-8?B?S2MrU0tBODFFNjZ0WlFXM25YbDZrdE9GR3NDTGlrSyt6SEp2azZORjZ4MjdH?=
 =?utf-8?B?N3hWME01WTF4N0J3a3VtdncvWHFsUG43NXJCdCt3ZFp3a0ZDWVlGUGYxNy9K?=
 =?utf-8?B?Vll0czVKdW9pTW9TTTlzWUJ3V3ZyNGQyY0x3ZVlyd1JNUDljdGxoNkg3RVVG?=
 =?utf-8?B?aS9IallvVkFpdXcwK09LTVpFTXNPUHB4cnZrTUJnOXJ6QlE3TVhyQ1VaV2FH?=
 =?utf-8?B?YlRUNncrcW44YytPOGdtakpmMGExYXlkUXBDTWxTK2lES0U5VjIvVUIrc0o2?=
 =?utf-8?B?dTF5OCt2NUdmbXhxa0JYS003WFR0N0ZmOU9LcldFWStDSVh4b1AvK2I2OUd1?=
 =?utf-8?B?bW85Q3I2a2p2RVI0OWF0b3VVbW9rOEtUZUVVbHUzY2E2WHYxaU90eUt6V25X?=
 =?utf-8?B?NlhaN1hreGlNeXhsL3lJdFFrMFdUOUJmTEtPZXRobnl0N3h5Qjd2UnlQd3My?=
 =?utf-8?B?aHRWMDdRNC85cGZCM2tYcUd6aTcxSWE3UUxacUQzTEE1cWluZHI0OW5KZGJB?=
 =?utf-8?B?S3Q0N1lqaFZyazhnMlBCbFBSRVdxQjFNWUhtcHJicFozQzluWEJtZHBkUHd2?=
 =?utf-8?B?ZkJXTVVNaG9iTWo1dWFBbWxDT3ZydDBZVmloK1Y0QjVKSXFwaThpdFRIS2pF?=
 =?utf-8?B?UEdVblVDb0pkZ0dDQXRBWGNsZnFKZ25zRGphOTBwaGR0V1B6NmUxVlZyL3Za?=
 =?utf-8?B?d0lHVThiWXJmRXdLcXJyOFNDNVlZQTAzREJjTVJGUG83ak85dWY2UC8wNjAw?=
 =?utf-8?B?aHVkOXZzUmMxVjlGYm1oMjEydlpoSHN6ZnBGdElaU2MvVytaUW8wclgyc0NW?=
 =?utf-8?B?Y1lOb2lXN3F2cWlocDE1eWpReU5UTmlpNmZKY1lNQXZzdEFXelJROXdrTUUz?=
 =?utf-8?B?bEVka0Q2MWF5dXRoMWpEU2p3cE9VSm5ubmlPQ0wvOWVvZDF3WUMvb3N3Kys4?=
 =?utf-8?B?TytZVnpNZ0RuQmxuTWUyMzdyQWxCTHFEa21EYkFZTkVlTklhZ1hrVFVONFhM?=
 =?utf-8?B?cSs4OHZXeVp4S1EwbUV6dVlic2hlcHh3dVZ5cmtHakRCSm1pM09BWjhYZVk0?=
 =?utf-8?B?MTFFb3pkNE9QS0llczRZcmxPV0tWdExXZEJKRmRMcFhhc2dDWjNXNjk0SWdm?=
 =?utf-8?B?SWhtWVZYTlRHcHFhT2VvRnRLdklnemh4bW1QQlE5U1B2R2wyaXA0emRYZStJ?=
 =?utf-8?B?eWlvbEplKy9oTEdhSjdiQjBXTDJzOU81VzNheTdrYmxlc2NHY3dZZ1c3Zi93?=
 =?utf-8?B?UUpvOW9RNVo1NHVqK0dKcXR0dEk4akJzK3l5TGR5WFJld3gwVVRwT3BkQVBP?=
 =?utf-8?B?RGRSa0V4WXJocERBZ1ZBQ1ZRMVRkZlVhZGFQa2haSXRWUU1oTE56WDNaVEow?=
 =?utf-8?B?SENtNG5sWFlHcmFPejNRNUNKVTVnK21IbmlPMDZnaXVLMnBhZGJaVkFWc2sz?=
 =?utf-8?B?U1NPV2EycXlnUHoyclAza2l6OTZ2VkRDMXR0dWZxZFJnTzVOYUxHMllpVE5j?=
 =?utf-8?B?eEhxQVhaK2orclBhQ0ZNUFFIek1ZaVBmNitMeDRsRmwwcVgxZUVKMXl0QVRV?=
 =?utf-8?B?K2svWmVUWFhQUGFzUE5kZnJwV2U4TmVaWitNaUl1OXhaR1pUZmZqTGdBT05J?=
 =?utf-8?B?eDdYd0FNZVpvelJVTUVlMEFUY3R6ZmMxQ0tyR1RwRHZiT0k2NDZCaGRJc01B?=
 =?utf-8?B?dTI1aWwzVUU4R2FNOGVkcGZwdW9HRHF3SFI5SWE4VVVESkFtZDFPbitEcEY0?=
 =?utf-8?B?RkpUS1pkZTJqTkRlUGxSYnEveTRLTzFhVTdZTkJrMFYwOCtJMUNFMEk4eDJy?=
 =?utf-8?B?aUkzS21QWlBzdUZBSTlBdzZkeGwyQVdxUExpbmF5Y05FcmM0TzV2dDFhdHJv?=
 =?utf-8?B?RTRhd0VPbmlTTFVpaTFtRHJFbi9BZC9xV0hZMHZOOHFWRjZ5azNWV1dXcjFN?=
 =?utf-8?B?THBwMUZOZ3RIaTIyMGgrenZPYURxWUtZQ3Y5VURNa0RDaEpVaUMza3FBT3Fu?=
 =?utf-8?B?cnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A3DE425E5B93A4285DEA202775077E7@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B87qP/2FeF/HR/8XPc0ToMBKgtu3HQRvUtCCq1PfFIxlBzp2bCZrL5mEWrB7Jr/MdtR88+tfJGBGSlkowOfksWbSvzA81+siFlOGSm1D3YDOVuDjlb+fm5gqTCaKTjIRhtQMWyWVtlPCA3xfInLYoUridD3ItJXuKUvKat3dCbV2h7yQzATlHUz8zSXuW8egm13mj6vSQpQSap65P9p6ptFlf1FV1DWjzMhuhswj9yj5OGseWpGSYtugcsCpdldlCWNLWtHY1w0IDLAIb87tjBY0HIAEGUACOWs7l8i1c4T0bLXMOPyGV74RG1UFVtGEGpPp32tk6sY8SXpv5mQeRDdiKfzAvX0cFNzDY48M5w64o1S1omupItWZy8V2Sk6TfvRrhKtO6TlkoFV1BsBsXuGCY3drrVSoWBL78qiIlaqnFmMxyFPLU29GSUGldH/enni6xLk2NTwop4YLKmpV2RyynF9NJSUuKP6O9Uf0RFiDqljLmCVTPrKCe3+tdt+S1HtYIvb6XN1AKVuKdTjDeqNOQEWf66GSLPmccEXGwp2tMtuRUVgB4GxqQjJkH4TAo4omE6aXPW6QJf6iJ7MTVbSW3cjWBmGYey7fFG8DJTLzAOHl7vDGr2OL7VHsgF+a
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee12f124-7b05-404b-fa45-08dcaa2ee422
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 09:15:55.2421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZvTIpCS+vUmoIxoeFPZhtJbXstqQ4S/FqKVX0lsMiLcOWaNQprMjHkq3dujQ/ipCGXzmD/PZtGE1UivVNPmEaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11776

SGkgRGF2aWQNCg0KVGhhbmtzIGZvciB5b3UgcXVpY2tseSByZXBseS4NCg0KDQpPbiAyMi8wNy8y
MDI0IDE0OjQ0LCBWbGFzdGltaWwgQmFia2EgKFNVU0UpIHdyb3RlOg0KPiBPbiA3LzIyLzI0IDQ6
MTAgQU0sIExpIFpoaWppYW4gd3JvdGU6DQo+PiBJdCdzIGV4cGVjdGVkIHRoYXQgbm8gcGFnZSBz
aG91bGQgYmUgbGVmdCBpbiBwY3BfbGlzdCBhZnRlciBjYWxsaW5nDQo+PiB6b25lX3BjcF9kaXNh
YmxlKCkgaW4gb2ZmbGluZV9wYWdlcygpLiBQcmV2aW91c2x5LCBpdCdzIG9ic2VydmVkIHRoYXQN
Cj4+IG9mZmxpbmVfcGFnZXMoKSBnZXRzIHN0dWNrIFsxXSBkdWUgdG8gc29tZSBwYWdlcyByZW1h
aW5pbmcgaW4gcGNwX2xpc3QuDQo+Pg0KPj4gQ2F1c2U6DQo+PiBUaGVyZSBpcyBhIHJhY2UgY29u
ZGl0aW9uIGJldHdlZW4gZHJhaW5fcGFnZXNfem9uZSgpIGFuZCBfX3JtcXVldWVfcGNwbGlzdCgp
DQo+PiBpbnZvbHZpbmcgdGhlIHBjcC0+Y291bnQgdmFyaWFibGUuIFNlZSBiZWxvdyBzY2VuYXJp
bzoNCj4+DQo+PiAgICAgICAgICAgQ1BVMCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIENQ
VTENCj4+ICAgICAgLS0tLS0tLS0tLS0tLS0tLSAgICAgICAgICAgICAgICAgICAgLS0tLS0tLS0t
LS0tLS0tDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzcGluX2xv
Y2soJnBjcC0+bG9jayk7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBfX3JtcXVldWVfcGNwbGlzdCgpIHsNCj4+IHpvbmVfcGNwX2Rpc2FibGUoKSB7DQo+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8qIGxpc3QgaXMgZW1wdHkgKi8N
Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGxpc3RfZW1w
dHkobGlzdCkpIHsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAvKiBhZGQgcGFnZXMgdG8gcGNwX2xpc3QgKi8NCj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBhbGxvY2VkID0gcm1xdWV1ZV9idWxrKCkNCj4+ICAgIG11dGV4
X2xvY2soJnBjcF9iYXRjaF9oaWdoX2xvY2spDQo+PiAgICAuLi4NCj4+ICAgIF9fZHJhaW5fYWxs
X3BhZ2VzKCkgew0KPj4gICAgICBkcmFpbl9wYWdlc196b25lKCkgew0KPj4gICAgICAgIC8qIHJl
YWQgcGNwLT5jb3VudCwgaXQncyAwIGhlcmUgKi8NCj4+ICAgICAgICBjb3VudCA9IFJFQURfT05D
RShwY3AtPmNvdW50KQ0KPj4gICAgICAgIC8qIDAgbWVhbnMgbm90aGluZyB0byBkcmFpbiAqLw0K
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8qIHVwZGF0ZSBw
Y3AtPmNvdW50ICovDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcGNwLT5jb3VudCArPSBhbGxvY2VkIDw8IG9yZGVyOw0KPj4gICAgICAgIC4uLg0KPj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLi4uDQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzcGluX3VubG9jaygmcGNwLT5sb2NrKTsNCj4+DQo+
PiBJbiB0aGlzIGNhc2UsIGFmdGVyIGNhbGxpbmcgem9uZV9wY3BfZGlzYWJsZSgpIHRob3VnaCwg
dGhlcmUgYXJlIHN0aWxsIHNvbWUNCj4+IHBhZ2VzIGluIHBjcF9saXN0LiBBbmQgdGhlc2UgcGFn
ZXMgaW4gcGNwX2xpc3QgYXJlIG5laXRoZXIgbW92YWJsZSBub3INCj4+IGlzb2xhdGVkLCBvZmZs
aW5lX3BhZ2VzKCkgZ2V0cyBzdHVjayBhcyBhIHJlc3VsdC4NCj4+DQo+PiBTb2x1dGlvbjoNCj4+
IEV4cGFuZCB0aGUgc2NvcGUgb2YgdGhlIHBjcC0+bG9jayB0byBhbHNvIHByb3RlY3QgcGNwLT5j
b3VudCBpbg0KPj4gZHJhaW5fcGFnZXNfem9uZSgpLCB0byBlbnN1cmUgbm8gcGFnZXMgYXJlIGxl
ZnQgaW4gdGhlIHBjcCBsaXN0IGFmdGVyDQo+PiB6b25lX3BjcF9kaXNhYmxlKCkNCj4+DQo+PiBb
MV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbW0vNmEwNzEyNWYtZTcyMC00MDRjLWIy
ZjktZTU1ZjNmMTY2ZTg1QGZ1aml0c3UuY29tLw0KPj4NCj4+IENjOiBEYXZpZCBIaWxkZW5icmFu
ZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4+IENjOiBWbGFzdGltaWwgQmFia2EgKFNVU0UpIDx2YmFi
a2FAa2VybmVsLm9yZz4NCj4+IFJlcG9ydGVkLWJ5OiBZYW8gWGluZ3RhbyA8eWFveHQuZm5zdEBm
dWppdHN1LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWpp
dHN1LmNvbT4NCj4gDQo+IENhbiB3ZSBmaW5kIGEgYnJlYWtpbmcgY29tbWl0IGZvciBGaXhlczog
Pw0KDQpJIGhhdmVuJ3QgY29uZmlybWVkIHRoZSBGQkMgYmVjYXVzZSBteSByZXByb2R1Y2VyIGlz
IG5vdCBmaXQgdG8gcnVuIGluIHRoZSBvbGQga2VybmVsIGZvciBzb21lIHJlYXNvbnMuDQpidXQg
SSBub3RpY2VkIGl0IGRpZG4ndCByZWFkIHRoZSBjb3VudCB3aXRob3V0IGxvY2sgaGVsZCBzaW5j
ZSBiZWxvdyBjb21taXQNCg0KNGIyM2E2OGY5NTM2IG1tL3BhZ2VfYWxsb2M6IHByb3RlY3QgUENQ
IGxpc3RzIHdpdGggYSBzcGlubG9jaw0KICANCg0KDQo+IA0KPj4gLS0tDQo+PiBWMjoNCj4+ICAg
ICAgLSBOYXJyb3cgZG93biB0aGUgc2NvcGUgb2YgdGhlIHNwaW5fbG9jaygpIHRvIGxpbWl0IHRo
ZSBkcmFpbmluZyBsYXRlbmN5LiAjIFZsYXN0aW1pbCBhbmQgRGF2aWQNCj4+ICAgICAgLSBJbiBh
Ym92ZSBzY2VuYXJpbywgaXQncyBzdWZmaWNpZW50IHRvIHJlYWQgcGNwLT5jb3VudCBvbmNlIHdp
dGggbG9jayBoZWxkLCBhbmQgaXQgZnVsbHkgZml4ZWQNCj4+ICAgICAgICBteSBpc3N1ZVsxXSBp
biB0aG91bmRzIHJ1bnMoSXQgaGFwcGVuZWQgaW4gbW9yZSB0aGFuIDUlIGJlZm9yZSkuDQo+IA0K
PiBUaGF0IHNob3VsZCBiZSBvayBpbmRlZWQsIGJ1dC4uLg0KPiANCj4+IFJGQzoNCj4+ICAgICAg
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbW0vMjAyNDA3MTYwNzM5MjkuODQzMjc3LTEt
bGl6aGlqaWFuQGZ1aml0c3UuY29tLw0KPj4gLS0tDQo+PiAgIG1tL3BhZ2VfYWxsb2MuYyB8IDUg
KysrKy0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9tbS9wYWdlX2FsbG9jLmMgYi9tbS9wYWdlX2FsbG9jLmMN
Cj4+IGluZGV4IDllY2Y5OTE5MGVhMi4uNTM4OGEzNWM0ZTljIDEwMDY0NA0KPj4gLS0tIGEvbW0v
cGFnZV9hbGxvYy5jDQo+PiArKysgYi9tbS9wYWdlX2FsbG9jLmMNCj4+IEBAIC0yMzIzLDggKzIz
MjMsMTEgQEAgdm9pZCBkcmFpbl96b25lX3BhZ2VzKHN0cnVjdCB6b25lICp6b25lLCBzdHJ1Y3Qg
cGVyX2NwdV9wYWdlcyAqcGNwKQ0KPj4gICBzdGF0aWMgdm9pZCBkcmFpbl9wYWdlc196b25lKHVu
c2lnbmVkIGludCBjcHUsIHN0cnVjdCB6b25lICp6b25lKQ0KPj4gICB7DQo+PiAgIAlzdHJ1Y3Qg
cGVyX2NwdV9wYWdlcyAqcGNwID0gcGVyX2NwdV9wdHIoem9uZS0+cGVyX2NwdV9wYWdlc2V0LCBj
cHUpOw0KPj4gLQlpbnQgY291bnQgPSBSRUFEX09OQ0UocGNwLT5jb3VudCk7DQo+PiArCWludCBj
b3VudDsNCj4+ICAgDQo+PiArCXNwaW5fbG9jaygmcGNwLT5sb2NrKTsNCj4+ICsJY291bnQgPSBw
Y3AtPmNvdW50Ow0KPj4gKwlzcGluX3VubG9jaygmcGNwLT5sb2NrKTsNCj4+ICAgCXdoaWxlIChj
b3VudCkgew0KPj4gICAJCWludCB0b19kcmFpbiA9IG1pbihjb3VudCwgcGNwLT5iYXRjaCA8PCBD
T05GSUdfUENQX0JBVENIX1NDQUxFX01BWCk7DQo+PiAgIAkJY291bnQgLT0gdG9fZHJhaW47DQo+
IA0KPiBJdCdzIHdhc3RlZnVsIHRvIGRvIGEgbG9jay91bmxvY2sgY3ljbGUganVzdCB0byByZWFk
IHRoZSBjb3VudC4NCg0KSG93IGFib3V0LA0KDQpzdGF0aWMgdm9pZCBkcmFpbl9wYWdlc196b25l
KHVuc2lnbmVkIGludCBjcHUsIHN0cnVjdCB6b25lICp6b25lKQ0Kew0KICAgICAgICAgc3RydWN0
IHBlcl9jcHVfcGFnZXMgKnBjcCA9IHBlcl9jcHVfcHRyKHpvbmUtPnBlcl9jcHVfcGFnZXNldCwg
Y3B1KTsNCiAgICAgICAgIGludCBjb3VudCwgdG9fZHJhaW47DQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAgICBkbyB7DQogICAgICAgICAgICAgICAg
IHNwaW5fbG9jaygmcGNwLT5sb2NrKTsNCiAgICAgICAgICAgICAgICAgdG9fZHJhaW4gPSBtaW4o
cGNwLT5jb3VudCwgcGNwLT5iYXRjaCA8PCBDT05GSUdfUENQX0JBVENIX1NDQUxFX01BWCk7DQog
ICAgICAgICAgICAgICAgIGZyZWVfcGNwcGFnZXNfYnVsayh6b25lLCB0b19kcmFpbiwgcGNwLCAw
KTsNCiAgICAgICAgICAgICAgICAgc3Bpbl91bmxvY2soJnBjcC0+bG9jayk7DQogICAgICAgICB9
IHdoaWxlICh0b19kcmFpbik7DQp9DQoNCg0KPiBJdCBjb3VsZA0KPiByYXRoZXIgbG9vayBzb21l
dGhpbmcgbGlrZSB0aGlzOg0KPiANCg0KU29ycnksIEkgZG9uJ3QgZm9sbG93IHlvdXIgY29kZS4u
Lg0KDQo+IHdoaWxlICh0cnVlKQ0KPiAgICAgIHNwaW5fbG9jaygmcGNwLT5sb2NrKTsNCj4gICAg
ICBjb3VudCA9IHBjcC0+Y291bnQ7DQo+ICAgICAgLi4uDQo+ICAgICAgY291bnQgLT0gdG9fZHJh
aW47DQo+ICAgICAgaWYgKHRvX2RyYWluKQ0KPiAgICAgICAgICBkcmFpbl96b25lX3BhZ2VzKC4u
LikNCg0KV2hpY2ggc3Vicm91dGluZSBkb2VzIHRoaXMgY29kZSBiZWxvbmcgdG8sIHdoeSBpdCBp
bnZvbHZlcyBkcmFpbl96b25lX3BhZ2VzDQoNCj4gICAgICAuLi4NCj4gICAgICBzcGluX3VubG9j
aygmcGNwLT5sb2NrKTsNCj4gICAgICBpZiAoY291bnQpDQo+ICAgICAgICAgICBicmVhazsNCg0K
VGhhbmtzDQpaaGlqaWFu

