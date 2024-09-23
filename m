Return-Path: <linux-kernel+bounces-336088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DC297EEF4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EAE82810E1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E5319F116;
	Mon, 23 Sep 2024 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="IFIsbU56"
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021097.outbound.protection.outlook.com [52.101.100.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C236719D067;
	Mon, 23 Sep 2024 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108004; cv=fail; b=nCA4mGG9cRPwbOw2tPJjbKfQP4XlXnSih50x2ykzV5RGqHqIA8ocKNUG1WmLWMhhiGxYY8XLn2T+ROOCWeNLqHM29Sn2nJZIZVQ/Cx4R0tw7ph7hq8Aqx3340MxhteoIWNVsLAUek+qzSxgxcIgc3TWSQVEd9goyb0bu+nBC1vE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108004; c=relaxed/simple;
	bh=IALWHVg2vW19nFblKWei1Kh4o+LsQ38Pd1xxBnYJ60s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TesDUY/JI7a/H8ogLxOGFrncFgQKiurN7dy34fpouTBhuwdPyX1goL8rZRQ7wlbkpxc/7IVg58JG3yi7L7A6fdy6jn8BS+1uCcQXP5gSq26nUYZy1cfBXVi8YjR/cwZXpuBAN9QgDxFEdBeg/F4KlvOWJLCh/CiEcTztcIcJ8vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=IFIsbU56; arc=fail smtp.client-ip=52.101.100.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGHfOJIDKSDs5evGu6mrZ6ZSOzMS3w9FbKzrtdTkP+wH6+XON9nxwwMK7UV2q6qpaBq3ePJaKarGsNfrQ2DSFpRZdMMOaZFZQrgR3A6QSsp+5M/6bFwllhEKvdpasb9Qb24PjeuuCcdnNCE/ZWNU/dLKykCigzdC5VqmDtKJIoCGnMe7IK5bmvyYgH9mDH4unpONbI/+IF4x9vUX6f5kdbikC0s+MLNwGkedHttpP3Y1+rxDFW9mSmq/70vafxnFccqBW+MH37rpZ0VLfZetuwhnTBLCgvxWs/zvBbFahhgCw2763dtpyH2pRKru6u06c8lHcSmaBRXeOE/9DDl+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TRn1Yq6L9nY52paGBhWSdK3+M4ww1kSDlc8abb174w=;
 b=F50aExVOHa6mVUsdcl2xIqEi4TMzSjrVD62V9mQYH/4IYLeyHczsKT/2iu3pEznQmucCvyU68z6KDU6ywa5Mcm1ws0+9ZzKMfDjvPj+5yb8LXKzOdv3Zwv2BadhuzzDwd6qurxllB6nye0D2DnCFQrzV8BLjQjX6UlWug/0kBFISfZajgB3ULVm9CydHc5sm5a+tNj5bFLnwd40ne9VAGnPRsmVsnuzjtOmF10VqxOIn2xat3lamgI//KRVJC7E7dS357vvZABzqxNrFrvnaEpvN/QB7N5CLiOP0lRYLT8vKV5eWowdW4TzVNfDL5nVw4eLzkFZYZDn4T+wMM79xbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TRn1Yq6L9nY52paGBhWSdK3+M4ww1kSDlc8abb174w=;
 b=IFIsbU56j3BmsPSBpSNorjPIrSaYpg5xOGXs3lRc8HpAP/68zybHA3soJ0KRaKp3XsGpYukO8cuY0h4j4MvGZJ09QuBDyM1L4puFucVh33CmseFvHKpG5D7aAklidxeRcwrvHxiYKZnayeZ0g7efL090jAa6bAKgo8w27evFgog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB5525.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:274::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 16:13:19 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 16:13:19 +0000
Date: Mon, 23 Sep 2024 17:13:15 +0100
From: Gary Guo <gary@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org,
 alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com,
 akpm@linux-foundation.org, daniel.almeida@collabora.com,
 faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
 lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com,
 jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com,
 lyude@redhat.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH] rust: alloc: pass `old_layout` to `Allocator`
Message-ID: <20240923171315.64327fe7.gary@garyguo.net>
In-Reply-To: <CAH5fLgievsJOe7QET+Wh2c0upygv-nhSnOuTN8K_QkruLwOPgA@mail.gmail.com>
References: <20240911225449.152928-2-dakr@kernel.org>
	<20240921153315.70860-1-dakr@kernel.org>
	<CAH5fLgievsJOe7QET+Wh2c0upygv-nhSnOuTN8K_QkruLwOPgA@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PA7P264CA0255.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:371::11) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB5525:EE_
X-MS-Office365-Filtering-Correlation-Id: 06c802d0-3f00-440d-1e1c-08dcdbeaa385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1hEeGpTY3BQTnJta09iYUhjdG5TQkVOeTJhUy82RmhUVmJQTG12UUJWbDZs?=
 =?utf-8?B?aFRMN0Fkb1c0Sytzbk5Fa3hkRURhMXFMVFJoM2VxamwyVmdVbW0vR1pOMzYw?=
 =?utf-8?B?aDFIWjNHWks3bTl4N0lYU09QREI1SzNabWxlaDFPOWZLVFluOElBeHYrc1RZ?=
 =?utf-8?B?YTR0YW5IdGJ2ZkE4S3NvQW8vNkZNQ29rWVJ3MnByMlNZYmJ6YmZtZTdUM3Nt?=
 =?utf-8?B?NmZGa3lSRi9LTW53VXVGR1ZGMVB0aVIyMmJmTW1HQXhBMEFMdncwdHNRT3Za?=
 =?utf-8?B?ZWI5eElNQW1qR2N2Nm5CYUFieExxR0xNcEhNek9IL0xWU2hlVjV6b01NRUV2?=
 =?utf-8?B?aFhIS095MFBvSExWak5lTURYQ2NNeEt5dUJQaEdwbHdWa1hVNnFkTnFBbnN4?=
 =?utf-8?B?S0FHVkpBd0FwU0k3WE0xUUU4dno0MS9ZYnEwUTBzUDNTWFNLaktrRnlGY0Fl?=
 =?utf-8?B?cEVFc000RGYvRGo4MWJ2eDJwckxZSHFQOHpFVnIzd09SR2NLMkFYN1JUc0Ez?=
 =?utf-8?B?NE1qRjBINUcxRUlTQmlaMENUSTNmT0xGWTRjS1U0SzJhNDZlaDhiU1c3L2Qv?=
 =?utf-8?B?cElGQTM1SlN1bUROTEdrMitQSWpCZm9UL0RINVZCWUxBTnlmbUZUZncrRURr?=
 =?utf-8?B?MmViMHZjVS9jTDVZSnVDekE3S2lHbjY5a2ErZDFiV2RwUndEUmdHOGsvTUtX?=
 =?utf-8?B?TjRKSEhFQy9pNk41NGNTK3V4bkRtNDlmZEhLT3Q2S2k0VDljOUJJYTZydmNx?=
 =?utf-8?B?V3RXNk5FMEJqaDF5aG9UdElqZ3I0dmdVYXIvd0RGS3JGWDJXQjFocnN3b0xa?=
 =?utf-8?B?WHFQN1ZBRmJRVVY0dkp2b1g0YmZMd2RycTczNkVFc09SU1F5TEFuNzZTT2pG?=
 =?utf-8?B?aW9VaWVmejUyYVoyMHJvdWlpQkxVdVVFb1BjYkxvcUJDRU9oYmh5YWZZRGlF?=
 =?utf-8?B?bG5EcGhYYzBrbSt6SVJHeEQ2OXZxamdIZStzanhSaVNEK3pESXcyZmlhd1N6?=
 =?utf-8?B?S1lNZzJaWlhTRkNVMi9UcGJKbnBTTjJFdGJDbUZCOS9MTGRZMGJHNHhTaVE4?=
 =?utf-8?B?cVFWdCs2WklWSHJwbjl4bHhHalczTVRxUW1KNzhteW13d3JwRmVoVlJzTlV6?=
 =?utf-8?B?bit6MldWQ2ZudjgrMmRURHZGSlFUVGRDeE00ZGNTaHdreHdhRHVkWkk0MVhR?=
 =?utf-8?B?WDkyRC9jZEt3UHpHOE5PZndyS0RZY0JOd2hocHhQSjRmeCtEaTBnZmdrVCtr?=
 =?utf-8?B?M0F3a2dsQlIyZTloMlVHRmdnU3lWeE9EQjhnSzdlR3lJWm5wQ2JBeXZDemZN?=
 =?utf-8?B?cWhDWjZDZnV0NW54WUNXVnZJZk1Ibmh1Z0dsdkVPYVVuWW1wK2wybGNlWEVl?=
 =?utf-8?B?dVVhNmc4VGxobzFvb2xoUitQTDVNSTJsT291akwrZTAreGlzUXZaU2FGcFRu?=
 =?utf-8?B?UEo2SmhHU1p2enIvU0hNVDdINFZpNW1rcURUcVZudEFhbThjQUNjUStPTmpx?=
 =?utf-8?B?VFN1SXRSR2ljT1NxTDNzc0RqcFdabmxlL0oxTmg5dHovaEh4NFYvTEFiVDV3?=
 =?utf-8?B?UUhFaUdDSjZyQUI5ZTNTamtYc1U3MThuSHEvYStTTHZYYzJSelV4SHFHTURW?=
 =?utf-8?B?RmNaMk1QV2pLcE4wcTNvelBscjVjcVdjN2E5OVlEWndJSFFjeE9sY05JcnUx?=
 =?utf-8?B?dUF1eXROYWxlaFpydVV4OUZwdXJyYzlGRldLMGVYaGxHWTZMbDM1UXJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHhmMlpSTE5NSlZybUl6YjViSENpWFJ4dTZOZkVxbGFZeS82ck9ZdlM0N2NI?=
 =?utf-8?B?V1dYOGt2S1VPcGpoM3VnOVBjblJqN1RhcjliUXJsVTlvZVgwZmJGdVpGTkw3?=
 =?utf-8?B?bTYrYzI5dW5BTUJwUUMyYnYvbCt0cnFYOFJZUEoydTlNdmt0TU1zWEk3VWU4?=
 =?utf-8?B?UTVzZHR6cmVwTEZ1WTBDRm1DZGpZb3hSUCt5QWtLU05OMUNoN0pSc085d3VR?=
 =?utf-8?B?TWFEMEswcHZBZGlYVzl5UEVYMjU5R0hMZkxRV3FwSCtDUnFScmtmL0w2ZWRx?=
 =?utf-8?B?ZjRtNVh2bVdsVkVQWnRpSm5OOG1IZUdJVkl1SWFFR1ltWmY5MVBCaVJMTTQv?=
 =?utf-8?B?WnViUVRZUVFUZnNSTUh6eWdmTWVObzIvMUxhcTRtWGxoYXlsTTllY0pkVUVZ?=
 =?utf-8?B?VzBlY2pEa3JpdUovblp2Qm9xcFB4Mm9SUHN6bU5sb1hoY2o0YkNscVlXcWVM?=
 =?utf-8?B?Q0lhblZEZ2x1V1lvMVFZSDhFQW5EZXFlMmdFOExkT3RMZ09XK3VxOXFBNFlV?=
 =?utf-8?B?clJreUVCVkE0VUpFZ2lNcm9nem1jbzZGcllsR0NKMjA3cEJLMXlnT2ZvRXkr?=
 =?utf-8?B?RWNtTVYvWXd3d0Z0UWZCanMrdTdTQ05WTVVZV0c0ODNBM1JqQU10aEZNaVJS?=
 =?utf-8?B?QkVLMUZmc3ArdmQya0NGUU1Zb095VStMWkxjYWNxeHFDSzBTRkRUQkp3QVlp?=
 =?utf-8?B?MzBtNGphd2VTYlRMM0dTQ2EzcjBabVB2aUJJeTlDSzFna1djZ0FaRzRBc29N?=
 =?utf-8?B?ZVdBem5rMDVDclpKaDJoQVhydktJcGNENVQwNUtYUG1WUkZ5WExON0lEY1Yr?=
 =?utf-8?B?aU8vR3hEOU1WS0pXamNSaUhZVUZ4bFQyalBsTkFLSG0xYkgybFl6MjZzM0p6?=
 =?utf-8?B?eldSbnpiKzJMWnByVUNsQnhxMzNkcmhoYllQUzhwbmFHMG5VQmM2T0dnM3Zl?=
 =?utf-8?B?clJhWHZSZEhOUWRPaTdFeGxNS3Y4V3pyTzY2U1UzS3ZyODRsSXNocWxtSW9m?=
 =?utf-8?B?b0locHAzNFQyTk5aMGxQaFlKTmN0cXlXeWlRMGpTZ2ltRlpFKzNlTXY5ZzZh?=
 =?utf-8?B?U0V3RjNuYmJLcDBaN0dJUGlhak1TSjlrSmtHd3ZOdS9ISDlUY2UyQlpNQXVD?=
 =?utf-8?B?MXM5MDJXeTRPejk1WGFNVmUvajdaeE5BbGlieWlKMEZCQXVRYlVvanBRdDN5?=
 =?utf-8?B?VFBwQlUrR0V5T2xGb0ZxNjYybERtOGVzZ211TFNzL01PRFpSNW1pNm9kVGRG?=
 =?utf-8?B?ZWgyaUVCcmJSanpBMlNOWXFnUGtHNVhiV3NJSGFSOXhSMk1sd09WeTYwNnBi?=
 =?utf-8?B?Y05vbnNPQWxuTzVSNVdjbCt2UExjKzhZaVFuNWgwdHFpYVJmR2hXZUowaGQ2?=
 =?utf-8?B?TlpwemNTcTFzSlp4cmJpeEEyRmI4UnZpZldTQmk0WnJWRlQ5cWswRGVEdVNV?=
 =?utf-8?B?OGtZeGx3SlU3NENCcE9DUnFWNjhTMlZuQjhUbVV3c3JpV016ZVdIT1haNVdN?=
 =?utf-8?B?MDE3Y0gyMjliQndyaWs4WjNVc09keUdDYStQZGJ3OTBHbXd1K3pUQ0JlUTlY?=
 =?utf-8?B?YytzUW85SEF2d0pCejV4OU5RUjlJcEFvQThkYmR3Zmt6cEJ2UGN5M2FudnY1?=
 =?utf-8?B?aW43VElieUU2NEFva2d1M3A3eTRxcUVQaVBTQWFkdERZVHk5VXdiaU9menpo?=
 =?utf-8?B?YlBZb1ZxNm1SbkppWllUbU9KYnErZmNDbnUreUhvbHBGTVFFc1htSmRqZTJu?=
 =?utf-8?B?aEFmOFlWcmFjMWRLM1Urb3ZuQlpxZTRuNFdDd2UwdXNlRUYrNmpsbzdDSGZi?=
 =?utf-8?B?cFNyb2VieE50WHQ5U09xdjlYVFc5VTlYK1FmRWdpdit1YTFVVmxBOHpPbkVP?=
 =?utf-8?B?bEZKQS9VZFBoMzNDeWFnQkdqOHdJMk5CN1NUSDZ2czdnRUYwdUJMZlJ2dUtX?=
 =?utf-8?B?NHdjWkFHL2pINk5VUEh1b05CY3RqRFBaeE5IQThkbDJpdGNYSWlUR1BWUy9Z?=
 =?utf-8?B?OGN2SzhLRDkwY2dVNDIzbk5WbksyWk1QeFg2UmoyT2Z1aHlJekpRS2NBRTFU?=
 =?utf-8?B?bWlOT1FNbFZMMDAyRklBUmx0cEdXU0JQc3M0K0dWRzdjbmI4dG50NkNWdU9m?=
 =?utf-8?Q?RroNU08jkCpOngGkir6FF2yB5?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c802d0-3f00-440d-1e1c-08dcdbeaa385
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 16:13:19.3169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O1puvaz0rRRXhJPlwKQjs25fpdX3QvI8iTLs64NXMEp6qf+J3hyYCzbk5iqEtL+BoWBq8mFk/p3clI/vi5Z7ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5525

On Mon, 23 Sep 2024 15:56:28 +0200
Alice Ryhl <aliceryhl@google.com> wrote:

> On Sat, Sep 21, 2024 at 5:33=E2=80=AFPM Danilo Krummrich <dakr@kernel.org=
> wrote:
> > @@ -84,11 +92,18 @@ unsafe fn call(
> >          &self,
> >          ptr: Option<NonNull<u8>>,
> >          layout: Layout,
> > +        old_layout: Layout,
> >          flags: Flags,
> >      ) -> Result<NonNull<[u8]>, AllocError> {
> >          let size =3D aligned_size(layout);
> >          let ptr =3D match ptr {
> > -            Some(ptr) =3D> ptr.as_ptr(),
> > +            Some(ptr) =3D> {
> > +                if old_layout.size() =3D=3D 0 {
> > +                    ptr::null()
> > +                } else {
> > +                    ptr.as_ptr()
> > +                }
> > +            } =20
>=20
> This is making Allocator work with zero-sized types, which deviates
> from std. We should not do that without a reason. What is the reason?
>=20
> Alice

As Benno said, this makes the API closer to Rust `allocator_api`
Allocator trait as opposed to deviation.

There's one benefit of doing this (discussed with Danilo off-list),
which is it removes ZST special casing from caller. This RFC patch
simplifies `Box` handling, and if we add this line to the safety doc

	`ptr` does not need to be a pointer returned by this
	allocator if the layout is zero-sized.

then the `Vec` can also be simplified, removing all logics handling ZST
specially, except for `Vec::new()` which it forges a well-aligned
dangling pointer from nowhere.

Best,
Gary

