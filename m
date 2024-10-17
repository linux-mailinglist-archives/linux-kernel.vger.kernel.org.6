Return-Path: <linux-kernel+bounces-370284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB6D9A2A5C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F2AE1C20CCE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58A91E0E02;
	Thu, 17 Oct 2024 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mb7u0Pgd"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E431E0DF2
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 17:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184817; cv=fail; b=GRNONJG8B8O74HLgKlsCkVzCUd3z4svh/0CfTeE6F7MNorynj1EbsCusDgElflW10tiCPz26bURNG+vu0fXw/glVQS7Ts2QdghLh+yByOyUwTfZxPzRh6Kg6P0TAHc+G63RxMTsmPl3R8zQZohH79LLXbNTNh+oao5dlbzBgfq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184817; c=relaxed/simple;
	bh=hP278mPX73rOW9rsFq30MN5xsTDRHg9t1fzLsab/lCU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XmaHhgTjjXQmk5UhV1C3AqQHxqN1yCmBPngo5eomcmgaYBCJGtvOfMfETD2LhJS+q384bmGYbgxHNBL/gmUxIUCgcr1M+u+qF/pai53SGZYidkslFWPEV4Xx97Fh4I3zR/Knh6eFT4eOePGckxV+x8rsOrw/JDLwL0BOdSjRbaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mb7u0Pgd; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFmW75DQshwwE4URS8Kw07o68oAW2rXX5QQ9j9+Ju4Rzc1TRIgcEFaYYVzy8Lt9n1qL2ppYtRbLvy6HjEg4/hNA6fLdz8YbJMWpXt7ZKb+tn2mzoJQo7JxV6o76xJXSpcR2N9efo8vATXF+DuoIe5J6H9l7hUDkm+NRZmMSccTampgmH1OVzLsnBWc8fGpumWdm47lQO13Ud8bl1zcmQ6o8BOmi9qCSbLxleDzsQ6oEdpBoZp+GqkxFIhTzXNM4rHTWrpNOR7NUnGZMJHSgYZs6Kh0bFToaFjrZqHxvnUsrQSwaSN4wLJlPetdUaj+QX9nRd8voViYhFOHtmJEnM8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IR28PaZ4kbZtqjEgDYsn4h0ZI0OdIKy0OSpqrMrKAm0=;
 b=NEjaDDjX2wxFe3asrXpo0iPumA12KlbofYxAmCqCRq0yfOVxskjGjTYvoIE6gebazIY1bmMO58oq+YQGVl+b2LLNDqh6UMMktKFeHXFONRaozrRUKsfEcOFteR9i+wg0P+qeDpH80MgJDKKTzk9DvjZgMwCRmH+3RrXHgY2sl53kESdFRBnPG0Au85iSxJZ/igywNxETTiyDHq9aWCebr17JZc6zRmLN3SgxaiNbErH0JjY2iz7s/7mw7p8dIEOrxC/oFhZcqhKBGOBdYCPzSzAe+Yy8ht77Hp1deuZaWjm9ug59NCJviRJAyZ+z8oElDYjnb06bpcewsi1nWm/9Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IR28PaZ4kbZtqjEgDYsn4h0ZI0OdIKy0OSpqrMrKAm0=;
 b=Mb7u0Pgdvcgi+6/gwGAoz1Gv9yceif3WIwrLzCrV+ZHuqXD4EutMKk6EOYbCO9zG/P9YXO4pdX/pynFOdDvMAf5WhpqzLgcDV2yn91fChN4Ir8YCwt9kyjyDKNgHLcENjmY4dnoZq6y6bggrfqlvooxKi7kV6iQGul8UOXP9ISRZtS4OGjiVBlxrOcjRL+iWcVjPx7IWDZGIUlF8QCR5GhbTqqGd0VtCFqIWfxHb38uj8tHORuadcPz0nGa/zIoZ2Ef1hkePMmZQsPF+KvbLK9loU5g0goxcE2SuVypiWSvIJbQswrEfYjqk5+Zhm/tNzp3YeldYWXVNQfa3hDreZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by DS0PR12MB7780.namprd12.prod.outlook.com (2603:10b6:8:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 17:06:51 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%6]) with mapi id 15.20.8069.019; Thu, 17 Oct 2024
 17:06:51 +0000
Message-ID: <de9ff75c-0416-46ed-90fd-c8801bbdc8ef@nvidia.com>
Date: Thu, 17 Oct 2024 10:06:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: stop leaking pinned pages in low memory
 conditions
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 Alistair Popple <apopple@nvidia.com>, Shigeru Yoshida <syoshida@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Minchan Kim <minchan@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>
References: <20241016202242.456953-1-jhubbard@nvidia.com>
 <1f8dcae1-416e-43cf-8dda-5440e0db4c00@redhat.com>
 <9a2232d6-74c4-426f-bfab-668c5c5ad143@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <9a2232d6-74c4-426f-bfab-668c5c5ad143@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::34) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|DS0PR12MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff22c34-e846-451c-0b3e-08dceece17db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlVaTnNybXhKWEVweGtEMTRoY2NUeVVnZVVuM044VlVhV2gxT1h5RTVqcFE4?=
 =?utf-8?B?MWUzUDJlTHY4U2ZGZk9YVnFMcFZ5WlRxWWhjSzB5WmZaY0NwQ3BITTE1NXpU?=
 =?utf-8?B?QVVIOUhBWXc5MVF2MXdMMUNPQzF1aEZ4T1lOTGNIdkhXUVoyeWxhNVBYKzlC?=
 =?utf-8?B?NHpLdXBwYnVBei9TcjJEY1R3MWlRUjV6RlIybzhXTk9tUnhvZWM2bTFiWnVK?=
 =?utf-8?B?WU1JaExEYmpLQy9GN1diRUdSWVlvVWpvZEZ0Skw5M0xUOFpBZGFkMWxaaVpV?=
 =?utf-8?B?Z3JLNUZ2OEpFQmkyZFE0Z3Q3VzVzMDlkRU5GVjhscmVkaEpEM2pRK0FrQ0Fk?=
 =?utf-8?B?U3dsdWtZQnZWMVNzR25rZW9jODdBWnRBYS9qN0NKOFBCZTFnNCtoT3BETlJm?=
 =?utf-8?B?dHNDN2dKQWt5cmMyV0NrSWV1WUFhQUtTUWJGYzJMMis0czErV1lmRGRSaUtP?=
 =?utf-8?B?UGorS29UdHBOTEdvaEI0RWZacExBZXZVS1pyTHUxUmxmRmJPRmV3dUptL2FT?=
 =?utf-8?B?L1AvMktkRWM3dWsyU2xkM3FmNGhleExOL0tadzZPT2ZWV095b0o4WlZRNnl5?=
 =?utf-8?B?ZGlocmQ5RGlSVzFxQXNHV3dHZW1JMHZvZGlobE9CRUxESEJ3bE80d3FyMWJU?=
 =?utf-8?B?cVA4d3owVGU1KzdpQXo0ZTJjajh3cTRabWhjTGMrVnBMZk9oUkhSd3RVSVVa?=
 =?utf-8?B?Z1FRS1BOOE1HSE55T1ljMllnN3R1RU40SGgzSldIT2FTbEM4eUtORGpVRFU2?=
 =?utf-8?B?U053OWVhL2k1bU8yaU9UTndHTXNWeEdteXBydVFmY1lzcmdCR1Q5ei94b2hP?=
 =?utf-8?B?cjlOV2JHTDFzQTc0amJObFFmNjc1MTdWQ3p1SWpBN2tBVkp0N1ZuVFIzNlhD?=
 =?utf-8?B?N0x3UG5tTytWRGxUeUlDZFBaRGN2YnJDMlBzOXJyV0hIek1hTjQxakxKR0Jj?=
 =?utf-8?B?ODl0Mm5Ra2JKUU9tbXhDNXA5b0h4a0pkUDlWRDY3YlVqdlgwOWZSU3BQS0xB?=
 =?utf-8?B?NmRmRXovQkVQWDFyc3BDaXRSd3N3Vmc1OFdrL2x0b1NQdUY4Q0gxQ2V0R05i?=
 =?utf-8?B?WHo4WjNJTzFYVUFGMGZjcDkvbkNoeXFHck9PWFlNUUNBT0lpMkxacVhYTzVq?=
 =?utf-8?B?cjRGRGZmbjBDL04za3VDK1RnNU96YWRUSVIzaDVJbVRQNXF5NUg3T0QrOWpJ?=
 =?utf-8?B?QmtFemxDSmhXbzNmcndaYVFEMzVaVlVBcjc0ekZ1WjVHOHZlZ3FJSzZ4YkZF?=
 =?utf-8?B?VXh3ZUFRWnpWcWJpcDQ0Q2JFczFXS0h2cWZCbktJMFVkYXBVa0JWRThnSjcr?=
 =?utf-8?B?Rm8ySVpVeE4zdkpWNmFCUW9zWTA5L0x3NTh0dkI4VGFIaDlwWUNCOEtXaW5z?=
 =?utf-8?B?V3VnMFQwVHUrQmZ0WGNsSy9MUUxoRlp5aHQwcndkejlMaXZ2a3pQRTFFL2pM?=
 =?utf-8?B?ejcxK2RnbTZPNDNQQnN4eHMvTHYrWElyYk4vV04wOTFQdk40bDlyR05TeGxh?=
 =?utf-8?B?OFVVTEhLeERSYS9qbnhzMmpVNllUM2ZaQnk4cWRleEtBeDhVMGMzQy9KRzU5?=
 =?utf-8?B?VUlHMWRkNndQbEVINVdZeFdyY09ZeTg5bndScS93dDEvL1g1V2RqWmF3WnNL?=
 =?utf-8?B?MGV1KzY2Mmd2QzVsd3lDQ3BTQllyUTlQZmNFdVpoR1QyejdDaWsrc3dKQUlr?=
 =?utf-8?B?WTM0WU9venlxSlk2NjhlQUhCMEx2Mjh6OU5hTlNpNzlBbWgyLzN5L2MxZEp4?=
 =?utf-8?Q?FvJaXVrqpnfS0mU8ACMakZqjjKUImedqp0Ac9Ct?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czNSZkZzY1REb0JzaHJxVWJrOWlrRUhqZnJGYkhDTDBJR2ZIZXA4K2hyVHFV?=
 =?utf-8?B?RGp3SmYwMkIvRkNpMkF2aXRHZHJQS2hSTkxWVUJnOFE2a3o5UWd0YTAvcWpI?=
 =?utf-8?B?cjAvc0tHc2p3d0JRRHZCY3A5TkZKMG1DRW0xbnYwYWM2dFBuQUE0Mm44NEpN?=
 =?utf-8?B?OWdycFJVWUNiOEpwTjNaTUtSenhIaXpVWExSQUxWdzROcXRIcHNnVzh6SVF3?=
 =?utf-8?B?bXhLUVJEREc4aklsQXpCelVsNVZsME9LWlFrdHFuS3J0MUE3UnhMd1ZZeWti?=
 =?utf-8?B?QlhMNG0wOXQ4WUtMcy9aaWtteGJPZ051OVZuRDhLcllmMDFGeHBvU2xhc21Y?=
 =?utf-8?B?TTJiNktUd2JQK2NpVmhBTndSMU82L2ZVeCtuVWlmTDI2OExydGhwQkJnSjlU?=
 =?utf-8?B?cXlGMU1LR092WXNHd0k5WUhRY1pZOFZLSkNsRHBVOTY2L0c1RVUvYzRBSnhD?=
 =?utf-8?B?TThvTEE3RnlhYnJiSnA2OFZ0bzlZRlFXT2pGNkoxWERxWTJIcUYxTnp1S2lz?=
 =?utf-8?B?MnFvbXd0V2Q2czlqSGZXUS9ZMGNnOWo4ZWxIcG8xSElHUUdhUUJpMm5RZDdI?=
 =?utf-8?B?RXJXeFZzU1I5TERKQ0VmdnVlUm9XeUZGdnRGOEYyM2JhUDZrTFMxek9tODNq?=
 =?utf-8?B?Z0hvejk1RVN4MnNuTEdJTTN3emxHeS9CRmFPT2VJNnVnYlJBNjFhcndNMGJE?=
 =?utf-8?B?NzlIRzBpR0c0NER4V2l6dmQrMVltUzhFNVkwZG42NFpaMUtpYyt6dHJDUlhX?=
 =?utf-8?B?N2RTL09KUnYwdFlhRll6Q2FQNm1HNnpmaEE1UlNhRE85TE9ySFFoRUVXek5N?=
 =?utf-8?B?Zys0MFViK3F6NzNKU1NGZkkrK2JqVWduTWtDK3oraG1BUzRrQktVRW5VK01i?=
 =?utf-8?B?c2dEZG9YdEp1emZNbHJ6ZHprMG5DYkMwZ2R4R2djQ2lENUt3MExjTWJ1SDhT?=
 =?utf-8?B?dWM2cTdRMkhGdDhvUnF5YUJseTRmM2JRMEJxMno1RUN2UXdCcTNUOHJPNTI0?=
 =?utf-8?B?OXRtdS95VGJ1cFVkTGdsazN1Rjc4Wkc2SnFxbGVyOE04bXprNVQrVW5EMXBX?=
 =?utf-8?B?bHhXZTlrRTgremNZV0lUYVVRYXhQMTFYcmxtL3dQT3YxNnorWUsvR05DVlI2?=
 =?utf-8?B?U3gwWUY0N1d4THB0V28wQm5Gb25zZ29aR3g4cEtyNkxJblVXVElWc2NKOEVD?=
 =?utf-8?B?WDdzMS9lQVhMNWs1Tnk4YVg1YUJWd01TblhZUk1ERkNlOHRBRlJ6OWd1alE5?=
 =?utf-8?B?cDZpNnI2dzVzMFVPTzhHWk1NQ0NXVHl2L3FjNDk5b0NSN1RpR1ZlbldZOXQ3?=
 =?utf-8?B?U3VkSXc2RjVKZnRNQ0orQ2hZUlU4dUt0aUkvcUJTREFRaUV4L2FqcXZPM29J?=
 =?utf-8?B?TjE0R2dIZ0ZPTS9PaGZrcU5GTTE3RjZwZmQzOUNsbjVBbGJPMHlhSXQzS1Js?=
 =?utf-8?B?cGlJRG4yWGEvSXplMGFENXozSkVoL0dyeVkrc3l6MTN5NVFFOGFINjh5UXh4?=
 =?utf-8?B?eEU1Ly9aUWd3VUFBeElkeUgyWFppQlI4bnY0U0JwYlVrVmZVZEJFSFVpL2Vq?=
 =?utf-8?B?MXJldnhKQ09jSEZsRmVvVDRveHh6ZlZ0UmMrd3JqWXdCUUZOVjVWQUEvK1Fj?=
 =?utf-8?B?bWdGdEpoMVVNOE9ObmdsR2pJVW9kd0FjYjNrU0xwYmlHdG5nSTZVSGJ5RjZp?=
 =?utf-8?B?OFdqN1VGclJDT2Z4bC9VQi9OU2NmTkdwQThwVDlydTdWZHpBaXNHaUQ5bnpT?=
 =?utf-8?B?dDB6M1FhOE1TcmQvdGQ2Q0xuVkhrZDVRT3MrZmhSU2xkMHhnRjI1YXRmMkZi?=
 =?utf-8?B?M3M4QUVWcmhWQVcvUkQ3SEhIUHFMS0dYd3locjlMbDNHQmhtclVzdDNIcHZK?=
 =?utf-8?B?Snd5MmRkVEdSOXBPRW9yazdKQ21saS8ycEV2TERWcjREeEdjbTRNV3VmdlNm?=
 =?utf-8?B?YXNTbk5VSHlsWERHbEdYUTlDWG1uNmpTQTg3RUcrZXJIVFB5T0VpSzV5VllS?=
 =?utf-8?B?Z3cvTVoyYy95UE9yQkt1bFAybjNqTjhTWVhEK2t5STE5QitsalVxSmUycDBp?=
 =?utf-8?B?Vkg2N204WWxJVVU3TU14c1I3eUtDREE3MDU0MzlvWkR3c1hMVmFEL296UFNk?=
 =?utf-8?B?NllIU1k2eVUxaWFYandaTHFqWUJpYkN5Z2ZPYklTM2tTT09jVmdJYkZEZ0o0?=
 =?utf-8?B?YVE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff22c34-e846-451c-0b3e-08dceece17db
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:06:51.1920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esFknAX/UaRYMIyxg5y53lu1PEqFijpJh7+D0JSou5mg+rFObx9VuTMZxKGegMvzKuw6loMrwPcWS3797P36mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7780

On 10/17/24 1:53 AM, David Hildenbrand wrote:
> On 17.10.24 10:51, David Hildenbrand wrote:
>> On 16.10.24 22:22, John Hubbard wrote:
...
> And staring at memfd_pin_folios(), don't we have the same issue there if
> check_and_migrate_movable_folios() fails?

Yes, it looks very clearly like the exact same bug, in a different location.
This complicated return code is the gift that keeps on giving. Although
likely people are just copying the pattern, which had the problem.


> 
> diff --git a/mm/gup.c b/mm/gup.c
> index a82890b46a36..f79974d38608 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -3708,12 +3708,10 @@ long memfd_pin_folios(struct file *memfd, loff_t 
> start, loff_t end,
>                  ret = check_and_migrate_movable_folios(nr_folios, folios);
>          } while (ret == -EAGAIN);
> 
> -       memalloc_pin_restore(flags);
> -       return ret ? ret : nr_folios;
>   err:
>          memalloc_pin_restore(flags);
> -       unpin_folios(folios, nr_folios);
> -
> -       return ret;
> +       if (ret)
> +               unpin_folios(folios, nr_folios);
> +       return ret ? ret : nr_folios;

That looks correct. I can send this out with the other patch as a tiny
2-patch series since they are related. Would you prefer to appear
as a Signed-off-by, or a Suggested-by, or "other"? :)

>   }
>   EXPORT_SYMBOL_GPL(memfd_pin_folios);
> 
> 

thanks,
-- 
John Hubbard


