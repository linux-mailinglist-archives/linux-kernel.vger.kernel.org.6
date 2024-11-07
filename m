Return-Path: <linux-kernel+bounces-400622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBD09C1022
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4BC1C22402
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601B0218312;
	Thu,  7 Nov 2024 20:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="dFGpxQuy"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4EB322E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 20:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013090; cv=fail; b=aSz8/Nds3i9Dd5XnAVytIqZErkVZrNWSjITZyU0JXDrRv2ZM7sZ4v2fJcTMnzuOneCeKQvkiOMG/+2MfbuKkFkyPSb8Yb9a+Eqlvt5jBSfE0r6MDKkWzRfxCxYYc3SGwSvHAXPYyA6/MJhYYh8YYnraptoGnKO695GW9uIO3zv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013090; c=relaxed/simple;
	bh=l0orgrzpZNlXO+6PvIBReUHSPGeTNpjSd9GXGKYDGMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u5ljGEdZVAWCHFP4rWidGjNt0ixnH8EI/sofz7h/Hg0qjnbTU3CKvyehGUAnU3ecJrOz7r74aVG/E3ZdwPo2mgB1axQv9Rx30cn+5FarWQBWLp4DLWR6hMDDfCbsT3TqaagjfQ4KfQmuGtngjMRKLphfJ1Octx0Ip2H1aJxUiwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=dFGpxQuy; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjjQULc0FjSy7MYA4t74zkmQHQQnopXgqSMeV4E2JV5JUkM8Mt26d01fAEYb/ALOEwIfY3YQEXKfJa/p7oTvsNyncjU53tzHvahLXHk4ECNVlKWYGqvcN32yp5HLSYMf1jU6tA+Aw0Qdo5gO5NN3ALe3tdaK/t3yoc0JMDZdXzf6q1VQMiLqcekClfIbBpMpECD6DrglMHdBLzKD2GTzAjFOIhCCWH8KfW35XWiSvALBu6aEHMZOZlW9HSjx+fZkZeXavIv8Xmxnf4ALd3a4q5yUVPiwbqg+y5q8+P8j4Fl+BseLzrr1POz7LFqPI/2wlAAvezwCuMIa01Lyaouk6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSsNbdtojMEcqnjDEJUf8LY84ltKu6tSnAwYBixSDhk=;
 b=Hmchc94hUIs6pf0U1GbCzSfNxjCDASoH6RfzvA1Qw74foRaNx/fvco728X8jI5XUpzIl14VkfjGhf6tupR+UlyDnIcpKo7rlt1se9oi7oaDH2P6xf85lXX0G2R/Ak90ZIjNJFJeQBOjJoEvnWUqmunavZz4WTDCurnfchRsa7jV8WEkU5l5hPsAqXEPpQve/sWbNgHpFEB59rc7Ey104YDgGbYQmMujo6zDmKjamdkbgVy2dvzeGjishkt9xMtNMdAoXfuDvGloyGi196h9VDDZ48hnQno6Jq8ZoeK747dN+6yzRWJukyqYCdWW1f+pH3Cg4yM7HAQ46jbTm23hCgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSsNbdtojMEcqnjDEJUf8LY84ltKu6tSnAwYBixSDhk=;
 b=dFGpxQuy+kzMyZwu97E2T6znNgiqWh08GA+XkkKHxWrVNSj62GLdNqL/zf0ebvwPgyvZ1B24IX3UateSyKTbTpNfaD9TEThuRuMUCPglP+Q8wDtXSiLoR928gF6PbyDc0yxnKISGTDTSq7D3wGN7m1h5TNI5Phd00d6L/KaWvbI2Lta2Ec4NAWdmBbhkORt+7qjSL+oeOtjVTx44faPc3ly029tibPBWpInKXSWzeCJOTljxMUR1sC/8LDwkQX6pXa5s8uqEjpFOG8SUaPzpQMuHX3JIZthJ084ZWUrvuS5FcGdA1OVyJE6pdQs1swXVpl9GyAgZw4N/V+yQFpXxMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9579.eurprd07.prod.outlook.com (2603:10a6:102:368::9)
 by DU2PR07MB8320.eurprd07.prod.outlook.com (2603:10a6:10:27d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 20:58:05 +0000
Received: from PAWPR07MB9579.eurprd07.prod.outlook.com
 ([fe80::f88d:9d2e:618e:55bf]) by PAWPR07MB9579.eurprd07.prod.outlook.com
 ([fe80::f88d:9d2e:618e:55bf%4]) with mapi id 15.20.8114.028; Thu, 7 Nov 2024
 20:58:05 +0000
Date: Thu, 7 Nov 2024 21:58:12 +0100
From: Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: x86/amd late microcode thread loading slows down boot
Message-ID: <Zy0p5DT0SOWsCDn7@antipodes>
References: <ZyulbYuvrkshfsd2@antipodes>
 <6449aa6c-43b1-40eb-ab54-48803481d11b@citrix.com>
 <20241107153036.GCZyzdHEwm9-LPQOzY@fat_crate.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241107153036.GCZyzdHEwm9-LPQOzY@fat_crate.local>
X-ClientProxiedBy: FR0P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::8) To PAWPR07MB9579.eurprd07.prod.outlook.com
 (2603:10a6:102:368::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9579:EE_|DU2PR07MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: 23ac8028-fc31-4340-ead7-08dcff6ee05a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHl3ZjZJekFTRXo0NFNzQkkvU2xQekpSY0kwSE1QcHYrazZPTlpOcXlnUW9z?=
 =?utf-8?B?bUhRRnpqNVRKZkNkeG1sMWZVa0IxdDlMR1gydmQvOTdyWUZib1BpTnRiU1Bn?=
 =?utf-8?B?Ym1CVUlnZG53Z2xhVm1Ed0p2MUFHTjJHMVYvYWswa3A4RmtYZW03SUhtbXNx?=
 =?utf-8?B?THFIT2JYN01YUEtjaFlFaExvN1J5VE42Y1F0MXZiUVVKL3E2Q0hXMGNrczN5?=
 =?utf-8?B?SkVMVXpjUU42c3R0TG9aelJaTTlMYmtESVE1QmJ0R09TU0NwVHBRVXJSaHNR?=
 =?utf-8?B?T3RZT0JidHlKbytxeXJic01ZQmN0aktQQkh3TVluRkhtMjNNdExHazRxb2lC?=
 =?utf-8?B?aDhRSWVGOWlEK1B5RmI1N0IzYU9IMTJoRkdBSlBsR2FTMEVNVTYrL0tsYVhM?=
 =?utf-8?B?NS9EeWJPa014aHBBUUFXNzBaTS9VSUt5N1ZiZFNWSWlnNnlKekJTZFpuUmFa?=
 =?utf-8?B?YVIrbG1Xdmwvd1ZaYis4TURLM1ZuR2g1WmN2di8raFJhemVmRlJwTXJGOVNR?=
 =?utf-8?B?RXBIMnJ4U1pxVzFKcklGRjZZbGxiWWFsSituanhGUE94S2I1OTUzek43MVYy?=
 =?utf-8?B?bDdqQUV2S3QzVnFFMml2SUJ5b2cyTEUwcmJqSldlZmtXRjZGQXBIaXlCTVA3?=
 =?utf-8?B?VDJ4cEs4elZNeFpBaS9UOW5laDZiZDV4cWF0Vi9TdEhVb0ovYjVKaUwrTlM5?=
 =?utf-8?B?RXRPakVCcWJMNUNBMmI2QisyTDhhblBqTmRWQ3B0OGxxalRnVWdGeFJUT0lq?=
 =?utf-8?B?cW1talBTcHZyZHhoakxoaHVRWWd3Q1VhRlVzT0N6eGZZKzd0cTlIMG45S0hk?=
 =?utf-8?B?TUdVNkxVR3dNVDh4ZERKN2NTUGY5TmdPTUNOR3NKOFZEZWUvTEk5RGN1SE9j?=
 =?utf-8?B?OTVHQy9KTHJ1eTFVMGdaVkdhTU5YVWlDaERqNi9OZHQvem9TQ2EyeHAycDJp?=
 =?utf-8?B?VkFvVThKMmVucThJWTdoVUkzTFYvREVQU2k1WFFJZUpGZW1kMWJzNXMveDVG?=
 =?utf-8?B?a2h5UEhZbVAyVTFSODlKdFpxMUR1RDlmRHhVQThMNTROQUNhSU11V3hJY0dW?=
 =?utf-8?B?S0lVS1FmdktXUEtzQUpjLzBERVd1TFpjWlNoSWpaTVNKVit6V3QvZWNFRllH?=
 =?utf-8?B?V3hWNWxQb0NyU2VqN3paSTJoQXRndjJBelpSV1drNjdsZHV3MWc4Tys4N3Y1?=
 =?utf-8?B?a2dXSjR5N2dEa2RTR245bnBWQ1BISENSRXZNc0pFb2JyeXNvUTRrUEZiYnVh?=
 =?utf-8?B?SFp1d091QXBRamlNaFZPRGlvSU1XQnI1UERUYy9QVytvbTB6ZG41dEtvSk9F?=
 =?utf-8?B?cDV4eStDb2dmOHVZaWsxUVFUOUJRQkdRbkFJbmM2eDBRRDI5T2N5bmpySkI0?=
 =?utf-8?B?ZGhyUUs5QnBHaFJXcFBXMC9RN0JXVU9FRVVTWGxwNWdtNlBSMDJNNldjZ1Y3?=
 =?utf-8?B?Y3VIOFhVVmUrQ2pLNmhQNzVINFlvTERldkNMalVFQ3laZjg0eWFWWmp3eWpE?=
 =?utf-8?B?U2xEUHNSL2U3bFQ1akZHd3RwenZ5UXBCWEZ0T29GNUd6ZWFWcnRKcGhDS1l1?=
 =?utf-8?B?bXlXbnhxVFBUTS9kUEo4aFlDZ1JEQTBSQ3pHYkJWRFJ3MXdJSWhQTS9jNWNz?=
 =?utf-8?B?M20xZjFDRVNHdUUyeVZXdngvZXU2UlllZFN3cjlobEluOGo5eldySTRPWW5L?=
 =?utf-8?B?TWRMY1ljQWprL1c5dU04ODVXWjA0RnJFUC9TRmE1eGx1OWxVWGFUaDlYemgr?=
 =?utf-8?Q?ue0W6zdL4B8+3XtK/bxyxGciQx0l6izpzuhLcub?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9579.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUpYY2hZaTVIYmg2NW96M1BYb2JrcURaTmJjNGhUTndvNytvRVdTZXdjVDUx?=
 =?utf-8?B?VEFmR2VJa0ZCNEV1aStFdTJvK3JTQnJES3FCTWVEUm1hVWJ4L3QzTjVvdTVz?=
 =?utf-8?B?aWVnbzlLaWhYMUJyYktPTW16djlLcmQ1ZHZwZUZIczNReUNyQ1RZbFRaYWtZ?=
 =?utf-8?B?K1RkOVlaOVNoUFlYb2NMcVhnaTBSNHJTczVONGx4TkNpR1BFQ1l1MXlSdDJC?=
 =?utf-8?B?TTB1VHpzd0NCQkxaTDQzWFI5ejNSczIxWmNJMG1DRCt3NzBSdXNXT3IyWnY0?=
 =?utf-8?B?VWxUTjBPN3RJTVd3cjNUbDBBZEN4bEF5US92SWxLQlo3RXdGMWliSzJ1R1N2?=
 =?utf-8?B?OVI3NTcrRmVaemhrK2dydFRQQ3M5cGgvNzlQTEUyZi9ZTjJsdVBLM3orbE55?=
 =?utf-8?B?UnRPVThWWUd4UCsza2Rxb3U5OFdiSHp4aHNGWDl2L0tnd0o0ZlU4K295endi?=
 =?utf-8?B?NVlCditQZmx6MGR3OGdMamZNODlVNWducmt5YVg3bEFkaHpOK05tK2VpSTc2?=
 =?utf-8?B?NmZ6NGN5SkVYbEFaeG0rMTBYbXRiNG1pN2Y4aXQwVFpnU0IzNTBDL3doMllt?=
 =?utf-8?B?WHJxWlgrZnhycGljbDdEUm9MSlZEK3VDTkJlWHpReFErQ2pFTFM4OWVtdXgz?=
 =?utf-8?B?alJNbWw0cFJjTU1FMmswdVFiWjl4SThEc2VYU1hjaEp3N3NuMDl3dTRvWUl3?=
 =?utf-8?B?WE1ieklsNlBEampISUx2WXZJUHdhSW8xUEtVMGVTQ3prMCtjVFZNOEpLTGhu?=
 =?utf-8?B?OWxQZHlZc1BuVkpUVkhneFRMUThDL3MzS2p3KzFSMktha3l1R29DWXVMM0Ex?=
 =?utf-8?B?aW1lWEhyNU10dnZnbENjcU9QYStLQVRHOXhrbmI0OTVob3dyUHZFQlNFNEoy?=
 =?utf-8?B?d1VKVkV1LzlJeWd1cU5FeW5pQVg3RnhjOSsxNnZEeDRlRFJPN1U0VGU1Q2J6?=
 =?utf-8?B?L1pSczFjanVlbmVyRzFLcTJtNVlwWWxTeVZkSWN4RVd1Zmxob3ZBNTRNSGNS?=
 =?utf-8?B?ZXcyYkkrODFDbnV1WkVsK3JsdGRGUjlKSmllVzcwRHdhMUJiR2EvVVhWaDVi?=
 =?utf-8?B?S1JTVXJmRnNhNnRUWHk5NWFNUXpNSFNvY0d3T1Y2b2ZlM3BmWVdzblRiaU8x?=
 =?utf-8?B?ZkVIZjBEQkFuM05HVVZtUGdyQytSRHdkUmdVdkg3Uy9zTjJQdUZZY3RReWZ2?=
 =?utf-8?B?cjFXZzRzQlZlekVXQU1QT0JuV0NzbFNOcjhGTG5iQllESTQwVjVRN2pxaHJz?=
 =?utf-8?B?Tzlkejc0TFdrbEVUTE5sNHUvdGhmdXo1WnNkY3U1QmdtckNFS3p2dGsxWUpo?=
 =?utf-8?B?TVZzRld5UXpyNWpmbVRXbzNzWmpKTU91WlJyYVQ1NmRaZFhZNDM1cytrbm9M?=
 =?utf-8?B?YTVub1grVWpBQVNPNHk1bCt1dkE0WlVWdHNQUXV5YWIzM2M0U0djUm1HRGpO?=
 =?utf-8?B?YUFiWTEvMzdJRXRUTTV3YlI0aTE4N090TFQ4eTFKd3FvT1cySVBuZVlYcGtV?=
 =?utf-8?B?U3ZPeklTandlam53YStRcmJqdnRDcVpMZVRJdS9Cc0UybEFONm5zZDBJR25a?=
 =?utf-8?B?LzlYNld3VklibzNFLzYrTDhIc1JaNlAvWEluY2tyMVgxY0pPV2c5TzZHMHFJ?=
 =?utf-8?B?UDRKTjFQWE4zL0pVRkRVMURNaWxJMzJLWS9HM3FjdUJYeFYweGJibFU1T0ZT?=
 =?utf-8?B?eWVTdGZvYTNweHhyQXI1Y2hoQStPYmRwVGVZb29Ea283UTNvbDMzd3QxSnM5?=
 =?utf-8?B?K2Yxb2g2Q1pyYnpHTGhSZzRDeG1laEltdU1CTkkycU0yNVNrV3FHeUtHbURV?=
 =?utf-8?B?Z3VBWStJaDRCSzl6akRVenpXRVhTVFdVamhpR1RhL3RSdFZQcDN2bGhRZnNW?=
 =?utf-8?B?S1dEcE0rcEdpbzlpT09YdENaNU5kYzZjVlc2UFVlK3k3OUx0UStBaEJPd0wv?=
 =?utf-8?B?a3NuU0xreWUxb01GTUJtMnRDdm14alA0RjFQVVlIeDBzU2FDam9nRXQwK1dX?=
 =?utf-8?B?bEhiczVkL0c5TWpKK21QMWdMNkdPRWJBQUdwSjJsUm9yYjI1RlhrMUtRcUFL?=
 =?utf-8?B?NnduNGJvUmd5emdBc2JHamhKWTJodlozdmhIWDZCZ3l4cVNURW1iTmNWY1k2?=
 =?utf-8?B?R1lqbWdkUlJsLzZRdk1kTHAwSkdvQm5mSkhHUjcrQ1ZZSmwxVEtGeGdsbUxu?=
 =?utf-8?Q?Kxxde6iCu4iiiTsC3K0B3pc=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ac8028-fc31-4340-ead7-08dcff6ee05a
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9579.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 20:58:05.7004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NuuYQjCc2uKe3lWM0uUV4pazUiANeWuA3V3ICCbWLgcan0kTVStiN8JB63WhG6mammxlH3NS80TMhPNbk/d6QuHGM2ThbeA/eujDwj9dDUUC07LBM276dUzuiyZJR11P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8320

On Thu, Nov 07, 2024 at 04:30:36PM +0100, Borislav Petkov wrote:
> 
> Thanks for saving me some wild goose chasing...
> 
> Thomas, do you want a diff to try?
> 

Thanks Andrew for the suggestion.

I tested with a call to 'flush_tlb_all()' right after native_rdmsr(), inside
__apply_microcode_amd(). This effectively fixes the problem.

Boris, perhaps you can propose a more fine-tuned flushing? I'd be happy to try
that.

Thanks,
Thomas

