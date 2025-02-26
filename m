Return-Path: <linux-kernel+bounces-534747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC311A46AA7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E188016DA90
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB7A2376E7;
	Wed, 26 Feb 2025 19:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bxZQcbud"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745DB221DA6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740597004; cv=fail; b=cH+kPDgCQizdGCMjSgC24S8DOHLZdw2x0eVyYpqaw8xWcilOi0QvFjegPusFU5bMP/tJiExDhQPBUKAnQtfUIwus+GGv3XKwDFplSX46WEWz8IKkAokvpVj5/mQvrqwa+CFvVG31bri79FDIAZMR/ZEBi2RRNH2954KC8rrFMds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740597004; c=relaxed/simple;
	bh=+QaN2f2xioiiA0boLEcB0pPmFsfrZEY0GWFvAc/3Db4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qOerasYggNwjFWWFKja0LpA3vJ0mtb2L4gVh5QYyw2ABtb/TVLrqket+vFiUPbb//DSILQpiwkCAsmmexvWlE66DZ9eXCx6LeV2zCoh8di22JcjstaK9cjz21yvVOUAi73GR5LfP1NiSjAfpFIHEJ1Id1q5JbqNOnR8abTSkT9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bxZQcbud; arc=fail smtp.client-ip=40.107.95.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mO87WPdsRXeVH3NMK3qEieWw7DP9rF+AcuKpUTaX5hHPmbRleLpY0Jjj/lyl2Os9YeVhuLXDUnD7S1zZSL1TkmkizEoZp/5wxDZxVun9eL38G0bP+xRVACxGVL+AdbBjzrviDK0gDF/y4dwRu3x12NN3rFBMktXz6lCp8DK6wje8TqhZUpvFCKeeOjDKUZsuiwjJa+Ig4fXEh50Gs8nxM4Mlfen6Vkd+7qrMS3M4rianf/fYOU+21s9XolsepSdapGO3Rs6QoUJ3hiIkwmknNZO0kaWEwNuuEcKCvYKIKcA9ck+xS/fMIUzUdgjiVKwpUReEMU4wm+XvPEF1YajYZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihNt0PAF4Gq5AxBTPCuncm2iXWZtvF7gTQAv8UolsEY=;
 b=cGvMXFumD0wyfAhIm5VNpiPP8z+0T+JrJFPgbr6ohz6S8B1dJx6EaOWanAQkm4Bet2yDesNVA6WQDr9JV3BrVf4svzg5IK6BSXkQ8VjaTVbYahN/56n8oYTLLo7mlz+MWi9ACiCX3hNYYFXyMfukiczWy+DiWDpe+ghyCytEtZVx0Y6B102nGpyLihCjqC9qbDW6GQp1i6MLR+9Lzwppdau7vF1/4MIgeq/lueppEhI2TwFgmFHKKrErfBhxTKrrrb5Y/tXxN1HCJb2IbXIM7g4/NyUj/VhflSEPJqtIKgHC1oN0osUKs49Qop8VGdB/Ux2xqovWjaarcqKn+CSdlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihNt0PAF4Gq5AxBTPCuncm2iXWZtvF7gTQAv8UolsEY=;
 b=bxZQcbudmCKpL/OM7/XU2mO6zwvSdO35hELrbS0LpvXBa9v00X4F15gMMfLDfD3YVr85zRAfpJNrOZ2woNDFxVqYDOiy8mW09s0aYyIJV94tHfb7hB2Eowunosn9Kua61ZmpEPjFv47BDuPwaD5d3oZbjYxOE9vX0tNuk1a+cfc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by CYXPR12MB9441.namprd12.prod.outlook.com (2603:10b6:930:dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 19:09:58 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%4]) with mapi id 15.20.8489.019; Wed, 26 Feb 2025
 19:09:58 +0000
Message-ID: <1793701a-599a-4af9-ba04-7a80bea78ca5@amd.com>
Date: Wed, 26 Feb 2025 12:09:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: fix type mismatch in
 CalculateDynamicMetadataParameters()
To: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>,
 Chaitanya Dhere <chaitanya.dhere@amd.com>
Cc: Jun Lei <jun.lei@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Fangzhi Zuo <jerry.zuo@amd.com>,
 Aric Cyr <aric.cyr@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20250226111027.9528-1-v.shevtsov@mt-integration.ru>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20250226111027.9528-1-v.shevtsov@mt-integration.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::35) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|CYXPR12MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: 06360cce-8086-48ce-6127-08dd5699298c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VU0vbU9jRzl1NWZRdVpYdFhXOUE4dGYrQlR6R1RxeGJxOEtsdzByQlZMRFcr?=
 =?utf-8?B?RWpYcEJwZGZ0RElya3VhSnBYL01vdkhZMVpLZGdBRVNzby9QaHB4ZU5od2R3?=
 =?utf-8?B?cXExL0lBb0ZqZlROS0FLSGRZUWw1emEwcm1vUzl1eFFrVTRFbk42NjY1YnBH?=
 =?utf-8?B?OVppWkVWSWY2ZVQzWWVDMVk4OXpDUTNQQzNSVlBRQWsydkdrbDNuYUdJSVZ6?=
 =?utf-8?B?NHF3NUE3ZGZGK0VaRjA2S1pMYnpsZ0JvR2tNUFEvcDY2bzErNUZRaFcxSk8v?=
 =?utf-8?B?OGdZNmJUSnJWRGYxeklFanpVK1AxOHQ0Mmd6d3hXM0tQSkZJV2JLN2FocGxa?=
 =?utf-8?B?bFhyQXNFL1R0Z2Z6amdIaEx5MWpacWlzd1JvRkpJdWhkY1RKMW9BNURCMWs5?=
 =?utf-8?B?Z01sMERmTVFEak5QelZTREl2MmFuU2UxdXhKZk9ldEVhSTh2RUd2NUg5Ynl5?=
 =?utf-8?B?ZTVZQW9vRGJQTENvd0E2OFRmOWdSOUhJeUc4cEtZOE1QNHJwMkhUSDRNUEwz?=
 =?utf-8?B?TlVOU0hvRnB1ZTVYV2xoUWtzZFRjUGlnM2pXOUk4MjJ6eUVHQy84RGdlUlZM?=
 =?utf-8?B?MFE1aFBlaHp6VXBodW5BcVMvUWZZZTB5ZW01bk5MODlOc09rUkIydVdtclFT?=
 =?utf-8?B?RjFjRXlYK0ZaTUpRUnQwYmtwYTlCWmo1R2tuaEJydWtjeHUzU1JJaWdJWk85?=
 =?utf-8?B?NWxZMXFuaHMyaiswaWJYeFRPVXRubkRUZlczeVZ6OVlDMHk3ZVJaUyswRWt5?=
 =?utf-8?B?M3V3WmtQYmpNb0E4RW9MTzRBeHFZUjU1bVpUKzF3MGo3STdMTkdHeUZSNThH?=
 =?utf-8?B?ejEyZjNITHJVSGgzWGhEN0ROYW9haDJNYXlPUldYbEZqejJOSDdMYUY1UkxO?=
 =?utf-8?B?U3NzWk5pb0dMcU5HMFN5dWJYaVorWUhtYzFjUGRoNzR6Q3QyMzBCMytqSVpZ?=
 =?utf-8?B?bmpya1RwaXBId1l1eDdOc3BNUFN4ZEJ2S0l3RUh5S1NyKzY5OWhpYkM5Z0kx?=
 =?utf-8?B?emkxcGtJaW16OUFjeUpKSlNuRHh4SXRuUnk0Z1dMWTNwQlZVdlNaLzZPSjNw?=
 =?utf-8?B?Y2NkM09GYVhPWFZTYjZGYXZ3MjFKWURDL25aclh0d0d0N1B5OFpUUUZHVVJm?=
 =?utf-8?B?b0hjVjNzK2FGbEpHV3ZSZktUcmlBRHhoc2w3R05Ucm9FWmxhMVRFSUR2SUpX?=
 =?utf-8?B?Y1RjVVkyT2pXUHVTRFRLenE3cGh4ck53bWdHY3U3UStpVFlrR1pvRjhmNEE1?=
 =?utf-8?B?czUyS3l6V3VtZ0NOUW1jeHR1b0dQdktCdlhVanBqSTM3dWVjNkpTcmp1YVZH?=
 =?utf-8?B?SXNZWmlxdjhnZEhjeEJhQ3hzU3BGK1lnaXlaeFJIVkVVZW5ZemZSd2FXRmJ3?=
 =?utf-8?B?SkR0a2x3c2dab2V0WmZGUDVLd1NZbm5YWURJbXpXNlBBQWdZT3kzVGpPNGJa?=
 =?utf-8?B?emtnbXMzU0NhcDAwa2NYN1krSzFyLys2NjRZcXRWRjBsVVk0d3FPakt4QUpD?=
 =?utf-8?B?ckpPME5nS3h1TWlJd2pDMjdUUlNUdG82K1NFWXhrMjc4UDl3VDcrVktmSmVT?=
 =?utf-8?B?Q3FhYVpGRWhlelhOcVZ5SUtwa2JqQ0lDMFViWXhsWkZ6ZUpVc2YwWm1KcWc4?=
 =?utf-8?B?UGJyU2FkYklxcmtPaXM1REFyci9JWHRvYURNMCtiNVF5aVVSdnFYSi80WGh0?=
 =?utf-8?B?ZldZbjEvcHdSOFlkcDBVSmlDZmhtYnZQOGRRVnppVVVzNGl5M01ua3N3eWdC?=
 =?utf-8?B?S0dzZmd6azErdW13dXBrakIvcG0zTlh6U1lvbmlTTmw2bW1Gc01ZeE41TUl1?=
 =?utf-8?B?Q0ZRSGljQ1ptZDZmOUJqT3pLM3lDbFRGMzBsSDRVL29BMUxONHVFRVNGazRM?=
 =?utf-8?Q?syzSPnvsl5x8B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8476.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHVjaDNvb2NTU3RkdVhBUlhZNnBTT09rbUsraWFHSEFvMkxKQzBJZDRFWWdT?=
 =?utf-8?B?MUtRTml1OEErQnc4WWxWRnNiMGRoY01ueUNUQXl4UU4wZXQ3RE9JTXZPUStE?=
 =?utf-8?B?RmNMTnRoR081L2UrakQwQ2pJTzJDazBiVHlSNmZmbEd2SmJPanNEOVNZZjI5?=
 =?utf-8?B?bkZscUk4MkNkWWhtTGlIbDIwVkJtb3BKWmhrRWhvcGI3dTVrbk9kMDFCV1pi?=
 =?utf-8?B?eFFaVENSaXZBQlN6ay9sN0puQ1l1NVE5UEFSMFFVUkRKMlcwRnJ3eERlVHBy?=
 =?utf-8?B?M0U3UkNXZFkyK2hFQkt0eko3N0F1R2o2b29SNTBQanBvZnZWbjQxajRHckMy?=
 =?utf-8?B?aVI4VWFUK2FrRkl4NTlvYmd1OUNMZ3I5WE5sWVZpLytyNzdKSlA5VnV0bXV3?=
 =?utf-8?B?TTl3RDV3alBCT0pFZTRaL08rU0QvWnpQeGd0REJDMTJJS2l0eFAySlR2aFZl?=
 =?utf-8?B?a24yTUwxRUJTOXkwMzBPS0hzelFiTVBabktoZEk2aCtYaEhRT2tCRzFMYmtG?=
 =?utf-8?B?N0lkRlNpOW45SVNUc3hqbDNZcmlBMDBiNmtqdjJpbnhtTGFERENoM0hMRjhq?=
 =?utf-8?B?WjFxSGZsWFpqQm5OcXd5a0tmc1M3ak80cEhxcGNJRXlQbUtLcWlZTW9LR0hs?=
 =?utf-8?B?MkZNdFYzV04zN0JSSmhzbUkweUhvT3F3MWordlFMa2wxOEhTT1QzV05OMzFM?=
 =?utf-8?B?SDBtcnJiNkxWbVMxQ2REMDMzU1JHbzUvRTdPWG1KSVM1L1BBSCtIQ3RRd1Bm?=
 =?utf-8?B?RUhxYU83WHU3QVZ6VlFEeVpYZU1oL3dscmFobkQrSENXOENPcGpBYUVQWUhG?=
 =?utf-8?B?Sk5hcUxPb3pYalptNE55RVJ3a3BjTUlkNmFJcWF3bGxwYWtXem1zdWw0eG1P?=
 =?utf-8?B?UTlsb01idkllekJnQUdZL0xxS1lkU204SnFIOXBHMU4rUW1vVldvUzhFYWk1?=
 =?utf-8?B?RVlCYWsxbVV0RnM2YUQ5YkpJelRmdldKV0I0cTh1OTlnN2hpQnAyLzRaN3ow?=
 =?utf-8?B?b1VCaXkycHgxdWtEQTNEa2lxTDBuaXpXMlZzczRWSkw4SnBtU2R4WkhyTlY3?=
 =?utf-8?B?NjVuTUtaWXdHdUFEMnlpSXB2bXhKSHlaNlhNWExPMUZONSs1Rk5OTVc3T2k1?=
 =?utf-8?B?QVhPMnA1OU5kd3RQUHBYZ0VCYmQ1V0FHc0FiL1VrbUtCMWRydk81V0ZaRlND?=
 =?utf-8?B?c1ZtSWx4UGREQjgwMElCUWZHLzdxNTNpQmNlOGhmWDd1RVVQWjUwL2U4ZFZa?=
 =?utf-8?B?ekw3Z0pLSUlHcm8ydDN3TzVKQVJRNlhoajJFSEVBLzBtekxIVDdVNkRDRERl?=
 =?utf-8?B?aG5LdUIyajdNTlY4RkN2aEJiQnR2MGpLdk1nY1ZHN1hKUlhuVnpya2pBUmR5?=
 =?utf-8?B?L0Z2T2g3QUUxNHB6TGtmUlR6eExXajBjbUEzNU1LeEhZWlJyaTZRRGdoN2dI?=
 =?utf-8?B?c1NPL1daVEVuZFQ3SzQwd3g3Z1N1Yys4eUlZRHhnSDlXTllxNUF6enJiZnRV?=
 =?utf-8?B?eFJ4VldveTNEbFlDS0JWOTNFUEREdk04cERTOVk5SzA5UHhGd2xhcjcxNDEz?=
 =?utf-8?B?VCttOUJ6UXRDWmlYdWxFR3liMEJzOTdtekJ1d2xQeExaRFlvMmtseVZkOHRt?=
 =?utf-8?B?UkFoTGoycVRyTUdWWVpJTkE4Q20vVXpMUjBGRzNoTXhiczVBUytSNnNMZEZE?=
 =?utf-8?B?UmkxNXQzdTI1b0ZyRjBJOU9NYWd1cFREMFhmZVRsSmcrNmoxdkFKcjJyemIz?=
 =?utf-8?B?RDdJbkMrM3FXbmhmTXkwNkJ6Q1dWOFpzeUhZYjRtM1VKWm9qUi9VWXVIRk94?=
 =?utf-8?B?bzRoRFFUL2VQelV1bjMreDk3aTVNSW5GTmlOSFo3U2tEcHdKUVVvWG1XNDQ2?=
 =?utf-8?B?OHhCejlIZHFLOWhEMGlYNm5UUlZ4MXN4c1MwY1pGMHRDa3ZGcUJ5THV5Zmpj?=
 =?utf-8?B?WFB1SS84Zm43MCsySHE3czRSUEVrM3p1VHhxMkdCWmpHSmZNcXBJK3MwZjM2?=
 =?utf-8?B?NTk4dHoycGhVcHRYQk1BcVJ2WlFjbkNLZENORFU2enhGNTZaSE5ySjhsenp3?=
 =?utf-8?B?SlhLTGtHUzBMQlBMdjlGU0N4a3RWTVVTTFlQbEFuS0l4Yk85ME9lclpHTW9p?=
 =?utf-8?Q?bXRB1qJNMORXEd4685z+icpmS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06360cce-8086-48ce-6127-08dd5699298c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 19:09:58.5034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vU8KwppX00YRBvXyGu2klRdzU5vePfXIs0rFDh+gP9Lx/4Up0Smn+c0An55dcdGgoqYnzpNe9rlqbqQoIL7YuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9441



On 2/26/25 04:10, Vitaliy Shevtsov wrote:
> There is a type mismatch between what CalculateDynamicMetadataParameters()
> takes and what is passed to it. Currently this function accepts several
> args as signed long but it's called with unsigned integers. On some systems
> where long is 32 bits and one of these input params is greater than INT_MAX
> it may cause passing input params as negative values.
> 
> Fix this by changing these argument types from long to unsigned int. Also
> this will align the function's definition with similar functions in other
> dcn* drivers.

The commit description needs to be updated to include int in addition to 
unsigned int too.

> 
> Found by Linux Verification Center (linuxtesting.org) with Svace.
> 
> Fixes: 6725a88f88a7 ("drm/amd/display: Add DCN3 DML")
> Signed-off-by: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
> ---
> v2: Change DynamicMetadataLinesBeforeActiveRequired type from unsigned int
>      to int as per Alex Hung's observation.
>      Add Fixes tag missed by chance.
> 
>   .../amd/display/dc/dml/dcn30/display_mode_vba_30.c   | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> index cee1b351e105..f1fe49401bc0 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> @@ -281,10 +281,10 @@ static void CalculateDynamicMetadataParameters(
>   		double DISPCLK,
>   		double DCFClkDeepSleep,
>   		double PixelClock,
> -		long HTotal,
> -		long VBlank,
> -		long DynamicMetadataTransmittedBytes,
> -		long DynamicMetadataLinesBeforeActiveRequired,
> +		unsigned int HTotal,
> +		unsigned int VBlank,
> +		unsigned int DynamicMetadataTransmittedBytes,
> +		int DynamicMetadataLinesBeforeActiveRequired,
>   		int InterlaceEnable,
>   		bool ProgressiveToInterlaceUnitInOPP,
>   		double *Tsetup,
> @@ -3265,8 +3265,8 @@ static double CalculateWriteBackDelay(
>   
>   
>   static void CalculateDynamicMetadataParameters(int MaxInterDCNTileRepeaters, double DPPCLK, double DISPCLK,
> -		double DCFClkDeepSleep, double PixelClock, long HTotal, long VBlank, long DynamicMetadataTransmittedBytes,
> -		long DynamicMetadataLinesBeforeActiveRequired, int InterlaceEnable, bool ProgressiveToInterlaceUnitInOPP,
> +		double DCFClkDeepSleep, double PixelClock, unsigned int HTotal, unsigned int VBlank, unsigned int DynamicMetadataTransmittedBytes,
> +		int DynamicMetadataLinesBeforeActiveRequired, int InterlaceEnable, bool ProgressiveToInterlaceUnitInOPP,
>   		double *Tsetup, double *Tdmbf, double *Tdmec, double *Tdmsks)
>   {
>   	double TotalRepeaterDelayTime = 0;


