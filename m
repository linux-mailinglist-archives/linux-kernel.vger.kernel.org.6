Return-Path: <linux-kernel+bounces-259037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A85B8939043
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18A27B215AB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 14:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785061DFF5;
	Mon, 22 Jul 2024 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UF4qzN0c"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B988F5E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721656887; cv=fail; b=AgF+FOmfQ1IY4TDULdjj3w3KWgK7CP8upxOtu56IIhODxtqrOaRuFcYpaKf5zrjEzVw6AzzaNqhy1GPBmFQbjxEbls3WnhJbUyY5kB+T9YCORCocDeZd7x/MHfRMKT0IfKKyRwMtgvL4AGRvkSdxctRXPQy2xZAztgfkG+mPTBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721656887; c=relaxed/simple;
	bh=XsFBuEoB1VtqflK8K/rDoh4m4qAY0/ysirfVD+6YGIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JL7fr9tUg/prKAeu+cKcPQmZ6kQTtF7xiP5elQotaWaEYMnJ6Yytl/+V6yR+32HVcliGcAhQ8NWneCYB2b8WM4unSCL2XKRTBq9Qs5+F3CT4hB0gP8ShEZoBwilcktYDdW5hdcUlUXD4E0LmND7Sn60uw4agZ4LD7ENRAMNbz2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UF4qzN0c; arc=fail smtp.client-ip=40.107.212.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCovIkusEnuc3RPG4Ckw+f3UEyPmfbi4+QrntvqwT5b7NS+kPUMOqCFUvQXdHIEnIGhYXPxZHhKSQvQesIPI0DKurOJ8vCRuO3hBI2fHAI5hQ+dpMzWLLd0Vnorj9+nJ5EJpoG5RRoj7kjbFbQbGOu5tTWsMktcjSMmWeocPsTCC2BlRY/a1u9W2TFB6MhTnu4QU7xG8EQ0HscIlyBpZAoyTO7Dwh57ATj/+2o5DzaJhNgQrhZUm/8OdC0vxK4GNWm9QwooAG306DL7kdthd3b5xcJYFQBvI8bLvu4rTWPc8J58A1cln2gVSrH7ntpC8bfxCUcwmObcTgAHSlmIfOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45+N3DnUl0TJH9wH0litZMpLj1GuCsaLaduydKS70LQ=;
 b=IRUUFodS6sRu9J4Vto67+9Cgv/l5UcC2/M9sPNxqRzgyGaR8kRHVK3h1w8Jn/jmnLZN6bMhHcrdmUma0LrKIQGAKLy8r/AMtoHpGYdqyqD6cBbb9Kh54dMovqB6SBMKIDLa12VpHiBB3anKvwtFTJg1RlQ1PX5UDsIsaH2DvCFwgb8iZlhFovVMUJJd8Tv1fqk/uFr6DI9M3t+RCkabn3DE4LpyGJyIIBzxC6wH4riCjp7vkYjL+lQE1jEB4XdMQUHU/H2lYHtQCQZhEWWXqcltw38hskYY5BIzoQbwv8Vlatg7Kz4W6VSJOJp+gQTxJx25v+13rQll17yeJbtc+fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45+N3DnUl0TJH9wH0litZMpLj1GuCsaLaduydKS70LQ=;
 b=UF4qzN0c3S+iF+GIk783rH95lUW5JlC2OtOvNhZ31c13V37sfqhGUZxCaAB+Ouydw5KoNeQssAmWXzbQJzBq8EOMCc/yWB2gUGmq7jgdIVWRMyWkOEMTdZv8Fagd1W7Fir0siBft7en78D5SI1C5y2GmIXxyoSzrDN9m71XCkEkAFwMC6Ig26QjZdIIw11v20v4VLN+Lw58gyddeGCkdMhvZB5l8XgPfYIWcitXbJqnj1KtxDvIGDzU2zDyL5CuzPivYIC44UPSS3moLadp+GGBGsS9mQu0Xb0d3VosGzEgC3LG+nYgTcJtEqYbAipxo/WcYJTjaAwTWDQHKti3Fpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ2PR12MB7942.namprd12.prod.outlook.com (2603:10b6:a03:4c3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Mon, 22 Jul
 2024 14:01:20 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7784.013; Mon, 22 Jul 2024
 14:01:20 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [RFC PATCH 3/3] mm/migrate: move common code to
 numa_migrate_check (was numa_migrate_prep)
Date: Mon, 22 Jul 2024 10:01:17 -0400
X-Mailer: MailMate (1.14r6052)
Message-ID: <1844A1CA-7120-4DB2-8F67-8F91BA5B18C6@nvidia.com>
In-Reply-To: <87sew2jiyr.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20240712024455.163543-1-zi.yan@sent.com>
 <20240712024455.163543-4-zi.yan@sent.com>
 <87zfqfw0yw.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <735B3DEE-5C4A-43BD-B003-17F4B1F0DC98@nvidia.com>
 <87sew2jiyr.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_28DAA9BE-79EB-4FA7-970A-F937A0691FDB_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0165.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::20) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ2PR12MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 08dddf86-9fe9-45a6-f730-08dcaa56c366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlJMbkRoMVJaOUxUZFZldVA5L3pVblZzQk5lTkdsbnZramlmeHZSSkdEemxN?=
 =?utf-8?B?OGF2ZzVGeis0ZGppcHJkZnR4S2lSd3g0U00vbjdYV0o3QU9Zc3N2WUEwVXhR?=
 =?utf-8?B?aW5mNFpTTFAwT1FYeXV1RjBZemlBbzlOMnQ4S0QxZzZOdGJuZll5UlMrNUw4?=
 =?utf-8?B?OVVkNlU1YXR2U1BTL0tHMlNYVEtBcW5wbnN2NFhuU2FnbENRbUd0bFJLNXNE?=
 =?utf-8?B?TXdueTNZQUl0K3g1cHoxZ1pNaGVzWDNZTTROaUZYMHI0NGt4ay9sZjFFaEhT?=
 =?utf-8?B?Z2pBU2FGeGJLZ3FzQmIxNEc2ZnBIdU5nWUZDK2xQNFRoc2gzNHZ5RlBETW53?=
 =?utf-8?B?TkVkVE9KcllRUG82RmJRN2cvYitvQU9DR0s2dUlkbGFoWEEvVHQxL0JEcDJY?=
 =?utf-8?B?WllTY0tZMEY0Z3dHcXNPMnFlZUc3dzAzNlNOR0FBN1p4QktDdk9QTFIxcUFl?=
 =?utf-8?B?WmFzcFBHWDJneXcxTDIzRHpNMHN3bHQ0d2lCYy9DWmVTdHVDK0NsTTkwQlY0?=
 =?utf-8?B?ZUNkRDZZQ2RTMWhhVERhaEdXWlF0Q3dOMXI4OThBQ2hqY0FLM0U5cW91ZjhR?=
 =?utf-8?B?YmJkbnZCM283WU5uSHJKTkprT2JYYnVIemhPOFNpVnFYcjVNMXlSUmJzUFp6?=
 =?utf-8?B?WnlTN0FxZk96dUtQRGhPVi9KYUpVSVlBUnVCbml3WDRDaklwZXN0RkdCcVVD?=
 =?utf-8?B?bWRpNDR4N01CeFN1V0hJamc0MXA1d05neWlFVFdMbExBQkNETmlLbVdmZ1hz?=
 =?utf-8?B?K2thRzR0MDBYZTRMWGJmbFo4NlBTRS94NVVPUkN6NEExekxzUDZEU0IyVU0z?=
 =?utf-8?B?MExLdnZ5OU1ZMHdGQzJlTzZpc1VqdE5PamtlL1JYdDYzOUk1Q2N2cU1jYmht?=
 =?utf-8?B?YWRyRkxQMUhzTGRZTTNCM0RUQnAxZTg5Rjd4Wjc5L09YSW1rakVFVFRvYU5h?=
 =?utf-8?B?K3doVWNJM3lZSmhRdkJMWnBGR0hPL0RQNmxsOXJOR0Rpc05IRUFLcGFhRGhv?=
 =?utf-8?B?MXAwcW9LRWhXN2VwQ0FXcWY3MXJkQjFWUTR5TlhBSVFPNFdGcmo0eWtwNnhl?=
 =?utf-8?B?N3Y1Y3B1QkRxcTVnWUJoZUpNeWo5aGlvcWl0OHVWczFHS1FsUUZkU3hCVG52?=
 =?utf-8?B?ZFVjMUYxeFVtS1ptbklmUmUwZUZGdThtbGZiNDNDN3pJYXorUnFTRGQxaE5M?=
 =?utf-8?B?b1YwQnA0UmY0QnZGQzAwbEg2TEM3MVFlVFR4MldrdFkzU2NaNjVqbnExK3Ja?=
 =?utf-8?B?SFJNM0ZWOWh3UmErZlUyb2JuMndjN2dJSnEyMG1NcEh4L2dJMXEyQ0d3SDZI?=
 =?utf-8?B?WDFVMWhPcU81V2EzQjV3QnUxTGtPZkxYSk1Helh1aXRsekhtcUFjM1kwU0tD?=
 =?utf-8?B?VlFSRGRxMDZ3SkFobjh6R21YNlF2TkVVQ1o0YVlLcDNCOWRVR2NGVmc2REt4?=
 =?utf-8?B?Q3IySExjcldGSkJSeFd4dDFTK2hVaHZnMW85YkhMVmUzM2s5UDZiWk1LNVdE?=
 =?utf-8?B?NFdZYlZlczFwUXZINTg1a1RpNVRYU2JicmxvOHNhaDUwa1JDMGdoNEhiNVox?=
 =?utf-8?B?T1NQL3RTYjVJS3BTeHcwOS8xb3dTcVlPbFluYWJ5cE1tbS9VT0hBaW5xazN0?=
 =?utf-8?B?UlFOUlNabWd1cm9lTndZWDB3OEI4ZXVpbGsyM1NVL1lkOFVIZDVNcUk5NUFV?=
 =?utf-8?B?ZWJxelBZd0I0KzJPcVF6TEFzN0x5V0Z0NVpjaTdYbmRDSEtsUmtVTmF6UVc4?=
 =?utf-8?B?b1dsYUU0Y1lrVEpac0wxNWVMSDJKL3FLV2ZUS3E0aFdhNTU5aGRqYkErOUt2?=
 =?utf-8?B?a3Q2ZGF2c25qNGJxWjVNUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3AyaUZ0RjdSYlg5ay9TeHNOaW5tdmc4SlFRU0tBbkcwZVE5SURsODdSNnR1?=
 =?utf-8?B?RmR6MnhOZlFIM2NuMVZ1NnZNWTU4bVpzdEZaODRQWEFXY0Q3b1dmNWMyMzI5?=
 =?utf-8?B?VHJoZjdFY2RlWnl3d1dSMWk2MnRyNTZTUUlQOVJjdDRBUXU3MWJWQUFWQVZ2?=
 =?utf-8?B?bmZVZ2M3bXRqbUlxVDFvOHV6TlM1WkxuQy9MczY3Tm80cnFCT0k1dEhYRzdD?=
 =?utf-8?B?VkhTalNDT3FYN04rRGFxdE9lMzFxY01CeWhxNCs3bEhlTXhCeWxFSm1GVTRl?=
 =?utf-8?B?akZ4dUFWbWgxZEtkeFl2eW1jcDZ0RkpTQmEvd2RuT2lidHNSQUhBMUxCRmpz?=
 =?utf-8?B?NnBOTXpFQzlqQjRqZitRbDdhMTJsQXVoYVpZT2xOWFE0ako5RnZKbW1sYVNK?=
 =?utf-8?B?c0RnVWhGVFpzeVdCU3Y3TUh1VEtadk41R0I1blIxVnZnb1ozMFU5dzRaTFZN?=
 =?utf-8?B?azNUMnhnek42OXNucWtWbkpwbThFRENQb2hGM05rbzBTMzU3L29yNnJTNDFt?=
 =?utf-8?B?UFEzTmNORElaMk9UVmtlQmJIRGRvNjBYK2dnaW5HY05TMUJuMWw2Z3R0aUpI?=
 =?utf-8?B?cTZvOVVsRWdZTGlLRHU5czJuaklmN3BmdmVyc0V0T3V5QVl6aGlmVzdzM3Rt?=
 =?utf-8?B?VHJUUUFUMGVlYm9hclpycWRidkF2WnZISjJxb2NiZGJVZXdHVjV5SzFKTytk?=
 =?utf-8?B?MDRpM2Vrbng3TkVyeWNsZjRoSVp1R3crMjNuSFI2K0p5S1B0dC9yNDZBcngr?=
 =?utf-8?B?ZWdKdWJ2TnZURGRkRjhjQTMyTEZPQWNtVW5mRmhtUGhIV3NDbERkbEdSemov?=
 =?utf-8?B?eUxrT1hKRGlpZ0k0dlJHNWRlUXZhSi9WckFrd25LbUJoVEJtSWZNaytXQi8w?=
 =?utf-8?B?cWFteURrbk5GLzBuSE82NEF4VDI4Sy9JK3FWaHRSWnR3aXU4LzFiSnFyNklR?=
 =?utf-8?B?VTgveERza0s0TVZGc0JQYXpYNmFxRTBUaG12RkVGMnF0T1BmZDlRRTc1cEw3?=
 =?utf-8?B?OUFpWFJUV3dCMktXUkpmYXdWNnNWSU5OSHVYQjYvMmVmU3Mva1VBV09XSFJU?=
 =?utf-8?B?OW5Cai9IOEpwWWd1REt3Wk1ES213eGJKR2hqNzVTYmp4dTNVTnpYUzU1elRs?=
 =?utf-8?B?VVo1ZWJqd0drcURhdEUwMmd0Q1UvOUNyNUNWQW8rWEhlYk1tN0wvQzlWV2RF?=
 =?utf-8?B?QTNLWmttck5BZThZQTFoVkVCNUpMYTFhdjEzR2JodG9OSjBRbWwzZUdoYXBz?=
 =?utf-8?B?RHpac2U0L04yUGJxRjBlYkcwMDR6M0lQSmpwT3c0TnZBRUYvb3hJWTk5S2hD?=
 =?utf-8?B?N1VTejVKYUs5SkVjTEQ1ZjlVK1BIVVpqbEVYVE5zdkRqaGFRTmpiK3pzRHpP?=
 =?utf-8?B?R2FoQlYyT3hXU0FjbHRwQXBUZko0ZWE0MHVkUFpBMDhaNURZTXBQOUpBZDNx?=
 =?utf-8?B?WnRXQ1RrVlRNZDR2Z3pUVDhxb1p3TnVqUFdoZmlUelowZzNkVUJtRlU2dFNO?=
 =?utf-8?B?OGswK25XdFZxUFVMMGdNZTRLWnRHWVQvVUFKd3JKWUMwNHYxa0ZPaFVRemk5?=
 =?utf-8?B?ZjRFUEtJVzFLcHlxS0M4UE1yem41d2RrTnBTN01vY3BqYnpQcG4yelpNeVpM?=
 =?utf-8?B?dWVXQlE1OFBqN3FEeXg0SlpOcm41ZG5oNWdqd3ZEWWdtVlZ3V0xUTjVldCtB?=
 =?utf-8?B?YXA1YlNxS0dVVnlXWG8yTWNwcnVqRTgwOEFkdFU2SGM4ZUQyK0xZOHV0Mm9n?=
 =?utf-8?B?TXFFd0dsaDk1Mm1YaEhuaGhSSC9YV0gvZlJiVENsVXZXODlwMncrV1ZkRHhF?=
 =?utf-8?B?b0RuakpUaU1GMlA0eEgrZzlvYVN5b3VJSElWMXJZaEdRZC91S3dhSzZaNEZV?=
 =?utf-8?B?NHhEWUlZVWVmM0h4MmtEWTlGbmJGZWYvYThXbjVvMFVaYkZqbjBZdWNxMExm?=
 =?utf-8?B?TUpiVzdNL2xCOFJHcmQxblV0UEQ2LzFOelpVTWg5dXFZSklGYk9odno4VTkw?=
 =?utf-8?B?dkRGMTZUVG9Qa3BCWmZIZVk4dzlWcXlScllYTWlDbVprMkRHazFRcEdBeHJj?=
 =?utf-8?B?YzI4M1hIS2hFYWRLR01Bcy9pTDlSVVdIUXNzeVZScktqblFIZ3VPSTFPL3BU?=
 =?utf-8?Q?oSaWZP+eJEOsijnQg8nmtOFh3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08dddf86-9fe9-45a6-f730-08dcaa56c366
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 14:01:20.5937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCMUpG2cYL0v1pMIfpFBJKEuQeIafG2I9dHQEePLBrMCv77cOkbTx3X54/K83o6O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7942

--=_MailMate_28DAA9BE-79EB-4FA7-970A-F937A0691FDB_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 21 Jul 2024, at 21:47, Huang, Ying wrote:

> Zi Yan <ziy@nvidia.com> writes:
>
>> On 18 Jul 2024, at 4:36, Huang, Ying wrote:
>>
>>> Zi Yan <zi.yan@sent.com> writes:
>>>
>>>> From: Zi Yan <ziy@nvidia.com>
>>>>
>>>> do_numa_page() and do_huge_pmd_numa_page() share a lot of common cod=
e. To
>>>> reduce redundancy, move common code to numa_migrate_prep() and renam=
e
>>>> the function to numa_migrate_check() to reflect its functionality.
>>>>
>>>> There is some code difference between do_numa_page() and
>>>> do_huge_pmd_numa_page() before the code move:
>>>>
>>>> 1. do_huge_pmd_numa_page() did not check shared folios to set TNF_SH=
ARED.
>>>> 2. do_huge_pmd_numa_page() did not check and skip zone device folios=
=2E
>>>>
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>> ---
>>>>  mm/huge_memory.c | 28 ++++++-----------
>>>>  mm/internal.h    |  5 +--
>>>>  mm/memory.c      | 81 +++++++++++++++++++++++----------------------=
---
>>>>  3 files changed, 52 insertions(+), 62 deletions(-)
>>>>
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 8c11d6da4b36..66d67d13e0dc 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -1670,10 +1670,10 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_f=
ault *vmf)
>>>>  	pmd_t pmd;
>>>>  	struct folio *folio;
>>>>  	unsigned long haddr =3D vmf->address & HPAGE_PMD_MASK;
>>>> -	int nid =3D NUMA_NO_NODE;
>>>> -	int target_nid, last_cpupid =3D (-1 & LAST_CPUPID_MASK);
>>>> +	int target_nid =3D NUMA_NO_NODE;
>>>> +	int last_cpupid =3D (-1 & LAST_CPUPID_MASK);
>>>>  	bool writable =3D false;
>>>> -	int flags =3D 0;
>>>> +	int flags =3D 0, nr_pages;
>>>>
>>>>  	vmf->ptl =3D pmd_lock(vma->vm_mm, vmf->pmd);
>>>>  	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
>>>> @@ -1693,21 +1693,13 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_f=
ault *vmf)
>>>>  		writable =3D true;
>>>>
>>>>  	folio =3D vm_normal_folio_pmd(vma, haddr, pmd);
>>>> -	if (!folio)
>>>> +	if (!folio || folio_is_zone_device(folio))
>>>
>>> This change appears unrelated.  Can we put it in a separate patch?
>>>
>>> IIUC, this isn't necessary even in do_numa_page()?  Because in
>>> change_pte_range(), folio_is_zone_device() has been checked already.
>>> But It doesn't hurt too.
>>>
>>>>  		goto out_map;
>>>>
>>>> -	/* See similar comment in do_numa_page for explanation */
>>>> -	if (!writable)
>>>> -		flags |=3D TNF_NO_GROUP;
>>>> +	nr_pages =3D folio_nr_pages(folio);
>>>>
>>>> -	nid =3D folio_nid(folio);
>>>> -	/*
>>>> -	 * For memory tiering mode, cpupid of slow memory page is used
>>>> -	 * to record page access time.  So use default value.
>>>> -	 */
>>>> -	if (folio_has_cpupid(folio))
>>>> -		last_cpupid =3D folio_last_cpupid(folio);
>>>> -	target_nid =3D numa_migrate_prep(folio, vmf, haddr, nid, &flags);
>>>> +	target_nid =3D numa_migrate_check(folio, vmf, haddr, writable,
>>>> +			&flags, &last_cpupid);
>>>>  	if (target_nid =3D=3D NUMA_NO_NODE)
>>>>  		goto out_map;
>>>>  	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
>>>> @@ -1720,8 +1712,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fau=
lt *vmf)
>>>>
>>>>  	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
>>>>  		flags |=3D TNF_MIGRATED;
>>>> -		nid =3D target_nid;
>>>>  	} else {
>>>> +		target_nid =3D NUMA_NO_NODE;
>>>>  		flags |=3D TNF_MIGRATE_FAIL;
>>>>  		vmf->ptl =3D pmd_lock(vma->vm_mm, vmf->pmd);
>>>>  		if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
>>>> @@ -1732,8 +1724,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fau=
lt *vmf)
>>>>  	}
>>>>
>>>>  out:
>>>> -	if (nid !=3D NUMA_NO_NODE)
>>>> -		task_numa_fault(last_cpupid, nid, HPAGE_PMD_NR, flags);
>>>> +	if (target_nid !=3D NUMA_NO_NODE)
>>>> +		task_numa_fault(last_cpupid, target_nid, nr_pages, flags);
>>>
>>> This appears a behavior change.  IIUC, there are 2 possible issues.
>>>
>>> 1) if migrate_misplaced_folio() fails, folio_nid() should be used as
>>> nid.  "target_nid" as variable name here is confusing, because
>>> folio_nid() is needed in fact.
>>>
>>> 2) if !pmd_same(), task_numa_fault() should be skipped.  The original=

>>> code is buggy.
>>>
>>> Similar issues for do_numa_page().
>>>
>>> If my understanding were correct, we should implement a separate patc=
h
>>> to fix 2) above.  And that may need to be backported.
>>
>> Hmm, the original code seems OK after I checked the implementation.
>> There are two possible !pte_same()/!pmd_same() locations:
>> 1) at the beginning of do_numa_page() and do_huge_pmd_numa_page() and =
the faulted
>> PTE/PMD changed before the folio can be checked, task_numa_fault() sho=
uld not be
>> called.
>
> Yes.
>
>> 2) when migrate_misplaced_folio() failed and the PTE/PMD changed, but =
the folio
>> has been determined and checked. task_numa_fault() should be called ev=
en if
>> !pte_same()/!pmd_same(),
>
> IIUC, if !pte_same()/!pmd_same(), the fault has been processed on
> another CPU.  For example, do_numa_page()/do_huge_pmd_numa_page() has
> been called on another CPU and task_numa_fault() has been called for th=
e
> PTE/PMD already.

Hmm, this behavior at least dates back to 2015 at
commit 074c238177a7 ("mm: numa: slow PTE scan rate if migration failures =
occur=E2=80=9D).
So cc Mel.

The code is https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/tree/mm/memory.c?id=3D074c238177a75f5e79af3b2cb6a84e54823ef950#n310=
2. I have not checked older
commits.

I wonder how far we should trace back.


Best Regards,
Yan, Zi

--=_MailMate_28DAA9BE-79EB-4FA7-970A-F937A0691FDB_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmaeZi0PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK4H4P/jXImTvm2/p14fogU0I2KC1O2JOL2Sqvo5Lc
RaZRR5CLk71aWxwlUFJHulPXUHjTTgeTZHQDPTzU9YhXjLCzkWIxuRcOUkHihrWy
CqyVehBIP7fhpNHRSqhVO/n9/BWdTqMUfSF3I7MX+XuV0AK+nwXxvCtMnJ4ykSUE
e5SnRk0nCxMVDW8DjkmEOjzNcRCMMtCaSgt4/Ip5RZK8B1cQsN6JQK8sUT1aYzdj
kT6pIELKp2yavkK9dJLdmhlcHHqN3ZTjBGp3J1g3lmjDS76BxCZSJcnwogQs4Ocj
DoN7Lub0pFM9+/znvkzl8/4K9lbVuzHR0Ilg36C9wTlQfsuvFuR8n3cnkKZlLN7i
5bXN+AKZKJtLpaaSSS1V4Rc9wmpsTOtAX9PEA8JOuzjAEL/vMW5uM6yM49/QJas5
4ozt8gdZiqwRldr58nAzoucr/FYvcdT9J2hL6oGePXgoTSOayYdtohnXJJLJuOPM
kR4+lTlMQ2ibiDgFA8S2iwLl5LsQb7Op4VBfVV0XOiT4z/WTZwws6Rc88MZmzShd
tCBpBNxXYIJRNG6Fz6I+En1srSpvQzIVPGAyXMfKaEo0ZZk7dvnh4gTNYApiVs0d
aN5m3edvFYoc5iN4xyGH7wtOKGMsVfHOGNrP79gQCOcJD/l6WXpGVo9b6ESafJwB
yA09R4cU
=Z61J
-----END PGP SIGNATURE-----

--=_MailMate_28DAA9BE-79EB-4FA7-970A-F937A0691FDB_=--

