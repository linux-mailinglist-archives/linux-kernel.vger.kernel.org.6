Return-Path: <linux-kernel+bounces-247101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6A292CB4E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C854CB22B4A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 06:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C9D537F8;
	Wed, 10 Jul 2024 06:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="n7KvXyMW"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2069.outbound.protection.outlook.com [40.107.255.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC6F482CD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 06:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720594039; cv=fail; b=pMwEUOAW6oZU99uQrXsieKvyd4obuzKB0Byum3fTJVw40k0/ZYF2m+o6XcxpIoa/+Gjppl0HFnQO7R0daj2rjAB4GvXq4yn2HyEy0ypcKcEuqrJ04kK1ifGONy9O63bWjC6e+di9pt+4du+Q5OvMG7Xs4cOydb4S9QI6w7shWmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720594039; c=relaxed/simple;
	bh=mMUbqZDgQ8bizJRxOjBWx47faNv7TIk1Utxq78iADww=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lfcjTd7oaaNN+hpvgnhpPi1qALzc26QEvl6PdxzbfnFOZerpcgrLoaEJpDgyXWUY2TW2pVWu1W0heHE9jVyfq701Q+Jphse5gnpvO05ovdiz49g9p3gIzZYLFrugOaFwGSShhGb01rGRAM/SoKXmQ8m57LV18P3Jtag4cq7vaJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=n7KvXyMW; arc=fail smtp.client-ip=40.107.255.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FaKMGWOZHK6ogdcjK0pBWcmQ2tEMdsD9phake4FbLrsGsMKIznwf2HJGRTk3F9hWbLshM93OFNacWwd3ovNO5WOh+Y4vTXxxuQyocegetho6BpeNXOjln5MPn4RTdaRkbFBn677aQwiroZpeQaJro5LKVENSAs+3HxX2uRBicmZqxg9VlMyfBWjErZKgbGuG+R6ihef9OPqzyFDH1GX8M6Wz+VhYl8UMWp91lIr1OQegTVc3LCeF2ixbkKO6GR0Gr1zcj7Nj0yB2fmU6QYF+yrQbRais/WDjwpQndAWHX9DgY55fdmI6pAQ4eN1xG/JFn/LW4fTMHnzdfLDcSkBa+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHgjBE+h4IOs2nHax9bvgHFqUL3jYDp5fn54azWg6Lg=;
 b=GqlhQnNo2h6/w7AudJxGxRwNpJtTgiVZXVetqubB9vD5MsTTss6nts1AIw6edDctq1IkJxUwWxLgLNbhPwlkifSNhFN3qAOH1J/1eqlQjReajSWgTKddrhxa0J25DYhlbExJwzi62D3Inr/aGX1TmHX3JHF7CtXDVZN1APiryLCQw/emf2zMkCuv/Uwx+HABsMBbgL8PHWdI5KXyQurHw9qHYfw7CExjUES8wFmXctXIIJFw6B80vsQdHtQA+CuhYbm9w8B6YXeS9IM3uamq5VGO6PYUK92s2WMsJN+FTVO9oAzaAqVyaPkDBXTo6rNuUnT1miQFbJE6Sm0JnBfG3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHgjBE+h4IOs2nHax9bvgHFqUL3jYDp5fn54azWg6Lg=;
 b=n7KvXyMWF76kcv9z01En5oNHl8EveqYcLLvE708mjlDJrSDMriUjuPTCcAVH6BrWZVV2661UpqXRKFAEtqIuwCVqaRIIkel/E/SUAGpsudQSqL4QB4iiAAj7aublLmt83UpfMOEr759+e80DvbQxzBWtXYm1Z08+jf9zrwfnA8UI2jo2gG4tLvXa7lyu3KLW6UXs8HuG68Q1ijgLHswZMCnCvK4eZokXNmurPJruyjAKxH0MtYCqQpXXtQRt1X6W4VkBaDyts3SoY0jww8xCr9639TNcsOCCWTsyhCLmgB5fs2JP+fNPwxGkIqiHtqQ8cLATsR4oM2bZ8dwjyRsHzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TYZPR06MB6640.apcprd06.prod.outlook.com (2603:1096:400:44c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 06:47:13 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 06:47:12 +0000
Message-ID: <db98cf80-6755-4083-83d7-cd750fd029b6@vivo.com>
Date: Wed, 10 Jul 2024 14:47:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] mm: shrink skip folio mapped by an exiting process
To: Barry Song <21cnbao@gmail.com>, David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, opensource.kernel@vivo.com, willy@infradead.org
References: <20240709142312.372b20d49c6a97ecd2cd9904@linux-foundation.org>
 <20240710033212.36497-1-21cnbao@gmail.com>
 <dc2c3395-e514-40ad-b9d8-b76cf04ba0df@redhat.com>
 <CAGsJ_4zkt5wKk-JhEpZgqpQgNK--50jwpZFK4E_eXgBpKkMKmQ@mail.gmail.com>
 <9d77dc44-f61c-4e52-938f-c268daf0e169@redhat.com>
 <CAGsJ_4z6kv=KhZ=DY-puG0uVosEPWx2=CNH0TGBG4W9tZoW+NA@mail.gmail.com>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <CAGsJ_4z6kv=KhZ=DY-puG0uVosEPWx2=CNH0TGBG4W9tZoW+NA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TYZPR06MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c312e9-615d-48b8-1732-08dca0ac2078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFQwMTVJSU5DcTBkWWFpUk01akxRR1ZWdlhHaFUxT2dDaEZ3NFFraVdlTzJN?=
 =?utf-8?B?V01uTHJvNktic3hseUxndWcxdFJBRkV0Z3VZNE9Ea1RhRjAyODVWOTJJNzJZ?=
 =?utf-8?B?cUgwQjJUbk9iVnY0bXBadG4xaWpqTEJPTDNjY0xsbmQ5YVJVNDA4aXBwc3Vt?=
 =?utf-8?B?ckdXTlZSOGRMVHd0MTBwbWo3UEtZSHlYL2YrU0IvaFVmYUZYR2Y2Y3hkWGlI?=
 =?utf-8?B?Sk1PQXZFc0xFSGZ3ektoMmhKS0Y5SzJqQjRCVFNBTElUbDcveWdSdlRVVEZr?=
 =?utf-8?B?OXZ1MFZsU2h0Qm1leGJpV1BCRkdzYXY1QnduMkhSQlRkVVphOWF4Y3FwajVt?=
 =?utf-8?B?MkczWldzMGp5THdwSGhvYXFqUlo0RVp1U2U0dXErTkszRXRsdGI3SEFucm52?=
 =?utf-8?B?dXFiL3g4WkZyMHA1b29yM29rYmZHVnNjOWU3eUl5MnNhc2ZOc1QxbjFocVR1?=
 =?utf-8?B?Tk83akVSREtnVFowUmI4dHhsbXYvaUNxbE85RVM3ME14Y1Z6eWllUzlFNTg1?=
 =?utf-8?B?UG5saVhObTJEZENvbXVQTjlHdCtoSWNaaXptQ0hYMGRrQWY5alNiUmJyaTRG?=
 =?utf-8?B?eU10V3IzSEJCR3k2SkhuaEdGUlQ4WVZhRXd6djRRcjM1cEJYOFhRQU85OUtw?=
 =?utf-8?B?RlUvTnUrUk95ZE5xQ2YvcHNIc1lEalZlQ1d1ZURzajhtQ1VYMHVYMnE2Nkdn?=
 =?utf-8?B?UnFwTDRkK2xPSGNRWVVETGJYMzlDU3R2K2kwVlBUMHhtSS9wYVpzcElXd00v?=
 =?utf-8?B?N0g0SU16KzBrRnQxNU9KcC9kVFhLdnlwdmp5U2RyN0p5MVVDbkhPb1hISmNy?=
 =?utf-8?B?NkxFUUt3Um5mWStWSlZyb1ZlWlh3bEFnZXdOZWpFMmtsVUVvdGo0Ry9mSUZ3?=
 =?utf-8?B?a1NXcVJZS0FJZmNySXpyMmphTHlDY0hJNnVmV3BVU1dsVjg4M3Y3VU8wQW5D?=
 =?utf-8?B?VVQ4RVhHaUNQb0ExbDNXZklzUlQyUWVNTUpNbDZ1cjdROWZHMENDSytkdWVj?=
 =?utf-8?B?c0ZUTklrWlRXRnBvT21mZHZ3Q2x1bWt6MDlMZnRNU094QnFkVTc4NUlXK0xm?=
 =?utf-8?B?VkQycnJkUUdYVlJWVTBMMzBBM1EyL2pZbCtpa2s5WGdRVjFUa3NEd1Q5aG12?=
 =?utf-8?B?WmIraEpMeWxhQ1V3MDljZzJKMDFJM1lxMW9VeDhNeEVvK05ONEFCaFZvMkRS?=
 =?utf-8?B?UUtsZSt0SmFZeWM2d0NMeXhDMDRWT0E4Ym5Sa3VGQkYzZFpTNXF4MC90Z3Q0?=
 =?utf-8?B?U0RXT2t3SFE4NmNsSDY0UFdHVUlVK2hDbTdieTNIQ05taWFGQ2NDWkpnRS8x?=
 =?utf-8?B?TitqNFNTN01aWVVKTmF1V2ZkdEozV3lLbjVCSGZQYUVMeHRkZFhFaTkwZ0Jn?=
 =?utf-8?B?UzREdG82b1BIbnBldG1YKzhNQzcxOS8zcDg1WmxtZ3VFRndCaUNWOEtKMTZl?=
 =?utf-8?B?ZldrNlBtSUlzOCtJTGlFMkZGSUR3M2RHSkx1L3V0dGc4T2ZTell2K3RveDdP?=
 =?utf-8?B?TFE5VGxzMGd1cE5PZlNxV0MrbHZSR1NNOCt4QjBiLzk5VjMyeUlSaWhxb2dp?=
 =?utf-8?B?RW1PUUZLekptZnhwTkcvSTEwY1B5Z3ZBeW5zRFNhWmNhVWRIeWZUWk85TUhP?=
 =?utf-8?B?YkNpeWVWakh2VkFtR1ByeUhXSmRJZDdzdUIyMFFsRUxLd0MzSm9sQkI4UHdZ?=
 =?utf-8?B?cGhNSEhPbUErcjVvdngrNExkMG5SL2F0bXZZbE11K1gwQmVDKzU3aTkvS0Rn?=
 =?utf-8?B?SXF0TlUxa0VxR2dieitJdHhNSFFsYlBtYmpueXYwYzRITW0weGZ2dGU2THhR?=
 =?utf-8?B?SzF5YnEwdmdXZ3FobEo1UVJFRThBYzVrK3NQdkx6QU5tOXJvRlhaNUlkUFE4?=
 =?utf-8?B?bncwZDFIUHJGRDJsWndEbXQ3M0Nqb3Uyc2JjVk1IeXRHWlkwbzNSUU43OGZt?=
 =?utf-8?Q?16OtO4v3Fx4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXlGRkh3bmVQS0pvT3pMVTZyWlpNUzFKaVIrQmk5OHB6aHNGZkdHSEZzTHZI?=
 =?utf-8?B?a25GOXV4OVZsb1lPRlBVU3FUc1MwTmxibk9FNy8wRllMRzdjSS85TXB6MG0x?=
 =?utf-8?B?ZFhyM2dxcURjb3RGVXJ5L0xickpsWGM3QktUK2E1QlRGdDVyUHR0SUhROU1z?=
 =?utf-8?B?ekxZZkpvZkxweFA0NUhQM0YzUDd6ODM2Ny96b1IzUTVwUURJUVNpc0gzSWlC?=
 =?utf-8?B?YWZWZUJEYUMrWHNka0hQQktuMzZ3N0hkQnY3Z05IMUIvcm5sTWNkdHZvUHBL?=
 =?utf-8?B?bkJGczEwUnBLZGh0emZoREFuTjFFRzVhY0RTYVNBNVRHR1NQaDVKc1R3Qk5x?=
 =?utf-8?B?K1lIQVFFUlIyTndMKzdnUi9XWUpvTDJMZDUvZkVOV2ZKa3BLcXQ4aEZwSUlV?=
 =?utf-8?B?R2lSQWJDNE1WVko1dmlmYmdKWWdMVHAwYzBKc3ZuSXZNcWxBb0pwZEg5L0M1?=
 =?utf-8?B?dmIwZkJLNVdWSmxSU0t5dWhqc1dIeHZIanhWQk1SdDNuNFNKVWw2WjM5Vy9H?=
 =?utf-8?B?NTNOT0lIdFdUR0tVY1NNM2twL1luUXViK1ArS3JhcEpyNE1RNTRjTmZjeUN3?=
 =?utf-8?B?UWFqbVlGamJmYy8wNk1tQytGY01mTmxCOFJPNTZxSWJkZ3RmZ1N6QndDRDZn?=
 =?utf-8?B?bDMvNlFBb25od3B0MjMzMGxmKzhDbFoxYzlRVFVsVlJBSllyNEFnZWFOdklJ?=
 =?utf-8?B?Q3ZWMkg2UmMyTkVTZmNOY2h6N1VYakEzYUt1VU5penNGblhUaDI1OU1NTkUz?=
 =?utf-8?B?SDVTUTBMeUNOZURVbWs0WGsxaTVMbERpcnYzR2F2bnY4R1NSSHYyVmVVWWZ3?=
 =?utf-8?B?dm1aMGpNeDFpMmp4dkEyN3g1dWZoMTRBMHM1VTIwVWxhOW5udEdWUWZhWmZK?=
 =?utf-8?B?Znlnc3dneXF6MmdtQXAxSk9xc2RZQWRYY1VOUVJTNXJyck1teDE2cVhERlEz?=
 =?utf-8?B?RVBKSXFROGFNTXB6MVpIbk1LOWxpK2ZNdnZseTBPUXRSZXIzbXB3amZZSlhn?=
 =?utf-8?B?K3BncFU4N3duWnRmS2JRSEVXMTBNR2xnZWI2SnRVVjRrVzdtWEludFg2ODJV?=
 =?utf-8?B?bEcwS2pMaDJuVVBvY2V2eDFTQkV6cjlrY0I4Uk5rV21lNjk1V3NyMFhOdjlv?=
 =?utf-8?B?VGIwenFIUlF4TWZTUkFac2RyODhEQnV6ckZJN3IxYytEY0FFRVloTnVtM1k0?=
 =?utf-8?B?Y2k2YWoycGl3U2JqazB4aDJCeFZ2VjJWZlI5Mit6RjlwWmJlWm5LaUdzVWha?=
 =?utf-8?B?OVNHd0ZDelpEOVFvdG0rTkwvRUJab3U3QndMTitBL09UU0grdHVaVlJVMDd2?=
 =?utf-8?B?Q1hlWk0vc3pzQ2ZMUEgvZTdnVnVNRFlJLzVWQVNvaDFEYVl6ZUs3eEk1a2Z1?=
 =?utf-8?B?RENUb1ZSdDg5Y0JZYTIyZnVkSG0wQW05WUErcXEwVU9rY05kOHg1b0RGOTIx?=
 =?utf-8?B?M051RjhiQm44TURleWdHU1hFRHFva3FVQkpsazQzLzgwam5jcjJxd0djNUpZ?=
 =?utf-8?B?blZkaEhwMERGZzRHNGJBU3ZWUnk5SHUxZDMwaisxdTllaEhrOTN0N040SUlx?=
 =?utf-8?B?Z2RtaXFGS21uZkdGeXZvMktjMkpoTjI4U2Z5U2taSSs5WEZ0dkZLUFVUelMr?=
 =?utf-8?B?QVorQkpLaG9KVEpNb0ZJTTJtbEhJY3RSNk4wSXdhQVFsTU5RVEtUbURhM3pB?=
 =?utf-8?B?ZzN1dGU1NlF2a1FpSjQ3V09QUVV5QWhqWm41V1BkSnk5cGcvV002enFvbzJs?=
 =?utf-8?B?dlZTR21jdEtRM0tqY3ZoZE1SUEg4dWRzL1R4VUE4ai92S1VCaEtYYmJOQUhY?=
 =?utf-8?B?STFtbjJuT3djZk1KQ0RJcUlqYUlrWUF1TDlSYzZObkZFU09XSGM4OVNIYnlF?=
 =?utf-8?B?ZVBOM2lndks2L3h1QWJwQUVWVjlQUW1sUml0T1lUZ3JaZEhJa0RyV0hJYlJr?=
 =?utf-8?B?bmtUdENuR1YyUjBsdVIzYXAwdTIwVnBEQTcvOVQ2bUw1V0M3YkxYc3NFems1?=
 =?utf-8?B?WG5JZ2RySDFqcml3MkhLdmoxK0ZoWEsvVGdmQ3VQQlNiclZTSmlJYWxVbmcz?=
 =?utf-8?B?SVZJdmRjdUtBb0gyK0pKWnlheTVCMGZLeFV1RUlHOHJXOEZmOFVTTVA0RG9h?=
 =?utf-8?Q?izWebAoaw/sTSFWbur+Z42zuJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c312e9-615d-48b8-1732-08dca0ac2078
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 06:47:12.0320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Pc2XLLLLPOmbMy6G2T+GNOalZMmKgxBq9yiJgrIy/CryFwxmLTGh6aN80lydB+oiHiSgcLpNTdRSOP6WVjTVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6640



在 2024/7/10 12:44, Barry Song 写道:
> [Some people who received this message don't often get email from 21cnbao@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Wed, Jul 10, 2024 at 4:04 PM David Hildenbrand <david@redhat.com> wrote:
>> On 10.07.24 06:02, Barry Song wrote:
>>> On Wed, Jul 10, 2024 at 3:59 PM David Hildenbrand <david@redhat.com> wrote:
>>>> On 10.07.24 05:32, Barry Song wrote:
>>>>> On Wed, Jul 10, 2024 at 9:23 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>>>>>> On Tue,  9 Jul 2024 20:31:15 +0800 Zhiguo Jiang <justinjiang@vivo.com> wrote:
>>>>>>
>>>>>>> The releasing process of the non-shared anonymous folio mapped solely by
>>>>>>> an exiting process may go through two flows: 1) the anonymous folio is
>>>>>>> firstly is swaped-out into swapspace and transformed into a swp_entry
>>>>>>> in shrink_folio_list; 2) then the swp_entry is released in the process
>>>>>>> exiting flow. This will result in the high cpu load of releasing a
>>>>>>> non-shared anonymous folio mapped solely by an exiting process.
>>>>>>>
>>>>>>> When the low system memory and the exiting process exist at the same
>>>>>>> time, it will be likely to happen, because the non-shared anonymous
>>>>>>> folio mapped solely by an exiting process may be reclaimed by
>>>>>>> shrink_folio_list.
>>>>>>>
>>>>>>> This patch is that shrink skips the non-shared anonymous folio solely
>>>>>>> mapped by an exting process and this folio is only released directly in
>>>>>>> the process exiting flow, which will save swap-out time and alleviate
>>>>>>> the load of the process exiting.
>>>>>> It would be helpful to provide some before-and-after runtime
>>>>>> measurements, please.  It's a performance optimization so please let's
>>>>>> see what effect it has.
>>>>> Hi Andrew,
>>>>>
>>>>> This was something I was curious about too, so I created a small test program
>>>>> that allocates and continuously writes to 256MB of memory. Using QEMU, I set
>>>>> up a small machine with only 300MB of RAM to trigger kswapd.
>>>>>
>>>>> qemu-system-aarch64 -M virt,gic-version=3,mte=off -nographic \
>>>>>     -smp cpus=4 -cpu max \
>>>>>     -m 300M -kernel arch/arm64/boot/Image
>>>>>
>>>>> The test program will be randomly terminated by its subprocess to trigger
>>>>> the use case of this patch.
>>>>>
>>>>> #include <stdio.h>
>>>>> #include <stdlib.h>
>>>>> #include <unistd.h>
>>>>> #include <string.h>
>>>>> #include <sys/types.h>
>>>>> #include <sys/wait.h>
>>>>> #include <time.h>
>>>>> #include <signal.h>
>>>>>
>>>>> #define MEMORY_SIZE (256 * 1024 * 1024)
>>>>>
>>>>> unsigned char *memory;
>>>>>
>>>>> void allocate_and_write_memory()
>>>>> {
>>>>>        memory = (unsigned char *)malloc(MEMORY_SIZE);
>>>>>        if (memory == NULL) {
>>>>>            perror("malloc");
>>>>>            exit(EXIT_FAILURE);
>>>>>        }
>>>>>
>>>>>        while (1)
>>>>>            memset(memory, 0x11, MEMORY_SIZE);
>>>>> }
>>>>>
>>>>> int main()
>>>>> {
>>>>>        pid_t pid;
>>>>>        srand(time(NULL));
>>>>>
>>>>>        pid = fork();
>>>>>
>>>>>        if (pid < 0) {
>>>>>            perror("fork");
>>>>>            exit(EXIT_FAILURE);
>>>>>        }
>>>>>
>>>>>        if (pid == 0) {
>>>>>            int delay = (rand() % 10000) + 10000;
>>>>>            usleep(delay * 1000);
>>>>>
>>>>>         /* kill parent when it is busy on swapping */
>>>>>            kill(getppid(), SIGKILL);
>>>>>            _exit(0);
>>>>>        } else {
>>>>>            allocate_and_write_memory();
>>>>>
>>>>>            wait(NULL);
>>>>>
>>>>>            free(memory);
>>>>>        }
>>>>>
>>>>>        return 0;
>>>>> }
>>>>>
>>>>> I tracked the number of folios that could be redundantly
>>>>> swapped out by adding a simple counter as shown below:
>>>>>
>>>>> @@ -879,6 +880,9 @@ static bool folio_referenced_one(struct folio *folio,
>>>>>                        check_stable_address_space(vma->vm_mm)) &&
>>>>>                        folio_test_swapbacked(folio) &&
>>>>>                        !folio_likely_mapped_shared(folio)) {
>>>>> +                       static long i, size;
>>>>> +                       size += folio_size(folio);
>>>>> +                       pr_err("index: %d skipped folio:%lx total size:%d\n", i++, (unsigned long)folio, size);
>>>>>                            pra->referenced = -1;
>>>>>                            page_vma_mapped_walk_done(&pvmw);
>>>>>                            return false;
>>>>>
>>>>>
>>>>> This is what I have observed:
>>>>>
>>>>> / # /home/barry/develop/linux/skip_swap_out_test
>>>>> [   82.925645] index: 0 skipped folio:fffffdffc0425400 total size:65536
>>>>> [   82.925960] index: 1 skipped folio:fffffdffc0425800 total size:131072
>>>>> [   82.927524] index: 2 skipped folio:fffffdffc0425c00 total size:196608
>>>>> [   82.928649] index: 3 skipped folio:fffffdffc0426000 total size:262144
>>>>> [   82.929383] index: 4 skipped folio:fffffdffc0426400 total size:327680
>>>>> [   82.929995] index: 5 skipped folio:fffffdffc0426800 total size:393216
>>>>> ...
>>>>> [   88.469130] index: 6112 skipped folio:fffffdffc0390080 total size:97230848
>>>>> [   88.469966] index: 6113 skipped folio:fffffdffc038d000 total size:97296384
>>>>> [   89.023414] index: 6114 skipped folio:fffffdffc0366cc0 total size:97300480
>>>>>
>>>>> I observed that this patch effectively skipped 6114 folios (either 4KB or 64KB
>>>>> mTHP), potentially reducing the swap-out by up to 92MB (97,300,480 bytes) during
>>>>> the process exit.
>>>>>
>>>>> Despite the numerous mistakes Zhiguo made in sending this patch, it is still
>>>>> quite valuable. Please consider pulling his v9 into the mm tree for testing.
>>>> BTW, we dropped the folio_test_anon() check, but what about shmem? They
>>>> also do __folio_set_swapbacked()?
>>> my point is that the purpose is skipping redundant swap-out, if shmem is single
>>> mapped, they could be also skipped.
>> But they won't get necessarily *freed* when unmapping them. They might
>> just continue living in tmpfs? where some other process might just map
>> them later?
>>
> You're correct. I overlooked this aspect, focusing on swap and thinking of shmem
> solely in terms of swap.
>
>> IMHO, there is a big difference here between anon and shmem. (well,
>> anon_shmem would actually be different :) )
> Even though anon_shmem behaves similarly to anonymous memory when
> releasing memory, it doesn't seem worth the added complexity?
>
> So unfortunately it seems Zhiguo still needs v10 to take folio_test_anon()
> back? Sorry for my bad, Zhiguo.
If folio_test_anon(folio) && folio_test_swapbacked(folio) condition is 
used, can
it means that the folio is anonymous anther than shmem definitely? So does
folio_likely_mapped_shared() need to be removed?
>
>> --
>> Cheers,
>>
>> David / dhildenb
>>
> Thanks
> Barry
Thanks
Zhiguo


