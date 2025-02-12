Return-Path: <linux-kernel+bounces-510516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F66A31E0F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1E93A8DED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 05:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433FA1F5437;
	Wed, 12 Feb 2025 05:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TwU8izI0"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0F5271837
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 05:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739338839; cv=fail; b=nEHQcbWgaaMYfVG5Bx7cYKqzmqeQ4v3WHNLklNLziGFE8gVGguAxDZeu7a58t7IwOMdbFzC6dTJiKPsonS0pQaP9mAcDFAoDJkFUTLztLnceR94FoZcU9jUJ4tekDILdfawCGfLhwjrbX3STJCzMW1SB3viiFPZ8lR1bonB4o0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739338839; c=relaxed/simple;
	bh=8fL73gC6iJcMa67gUFtF3HkDT/AeXaAVVGYHDc+uUCU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VAl2UJWvF6MlgEeO3HTmLNfLdHDPpR3GrCWEBwR8elqzKn5l2tMK2VDScWzhEdz8/ANEnRtgzzFRdsH2Iaqi3kq4OV3X4n/8WhP81fcTU9DwI6hp1t8iGpcSPCTDwxQBYC4IRhasZo11Ks+G/d5cE321JMdIkh4PU7QCmbNBaPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TwU8izI0; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0PGLLQqQa7hWhA6h9Uc/FVHvg2G/t6GkIrSdJitcEtz4ysEMS/jiYXkIwPe4P7jB985xbnvTL94QipTKiwPYozcHfkTl+1aALI9QrjwMUq3Ra+Xs+RMXUjBUS3J0hJX/QWzi7DUL17lMi1RbbWOuYhd4H8swI4v4YcnZQ1nmcqYgMIiRVlwEptkKVyU9mM+4uo8LJmkfzC90wors4D43R018IF4Fh2Q/oepCItPpiWuAnzGdwgYM76nyUu3Qd+GMMvNarLNXnV008NwNsPG22l1+1HK4gWaM/CE8TeLl+EU0V2vx7bxdTlUWlHE00R7BkJugfimuvQVmYr5GdFfBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gzBHx/32KN9qVXPrvlRAuGFZtFSClO5+4uxK9N1TUI=;
 b=d8grLD+kuV0t8fDMIquSUcnT/RcztArz0BTFLdVi8ThjATzmTLt3+roOO08okVUsRwZltUpZLklAwZsUzobAKIkZsqYA5gK5IqS3NrwJvd//9Cuwp3zMdfNLIsW6MMNLpLw+Qcy+7UlcspXgnLJDGmCR1mzcN031ZwmxCSKmWGrpKRdJ+5uYF/nu+wzwHM4rcE3SAdMTUFnkXLfbwP7/lCeIq/cIleINt4kIBAU+dpwGVn59odOYiYumQn671AEi27QXbjVX05bDuH3r6t7h2TdUGg34dP44FRcCKzk6+kVLhv55W39v2l1/dDJbRkc6I2F6mWO1wz2Lcj5fCyxDpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gzBHx/32KN9qVXPrvlRAuGFZtFSClO5+4uxK9N1TUI=;
 b=TwU8izI0eGo/CHegfGRqDO2AHqaEre9XB7Ao5WM8UruLb0gwR7qpaC63imCArcPu4c58nLnf+OMj5kSNqH/PH4nAIk+6Ljs043hRUdJOUJ6Ym8Eq31AUi5DvhakPJe5Z5YIvVBRZNXAqdY9QXqheBKMwZbsmqciRMn48s0y0WNM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by BL1PR12MB5851.namprd12.prod.outlook.com (2603:10b6:208:396::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 05:40:34 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.8445.013; Wed, 12 Feb 2025
 05:40:34 +0000
Message-ID: <50f02ce2-85f8-4dda-b3c4-ad3f20f8b9a2@amd.com>
Date: Wed, 12 Feb 2025 11:10:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/mm.h: Write folio->_flags_1 & 0xff as a macro
 definition
To: Liu Ye <liuye@kylinos.cn>, brauner@kernel.org, dhowells@redhat.com,
 akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250212025843.80283-1-liuye@kylinos.cn>
 <20250212025843.80283-3-liuye@kylinos.cn>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <20250212025843.80283-3-liuye@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0006.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::18) To MN2PR12MB4270.namprd12.prod.outlook.com
 (2603:10b6:208:1d9::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|BL1PR12MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ff6b8d0-2b2e-440d-377c-08dd4b27c50a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDhOTlZtM2VnbkVQSVkwb0dnazlMK3BORTFuYlREeXBMY00wZ0NXM0NURDJm?=
 =?utf-8?B?YUNGVTJveFJPTjdPUkE0MEZRY25jZjNjbG1tNFlwYkRpdFl2UjUrSzJDTEZx?=
 =?utf-8?B?VzVFUzM0R1pMQmhXZUJNSHZuZjlLRFNkVE9xdld2UWQ5cDZHQndyVDkra0lU?=
 =?utf-8?B?WStvd1JUZENCLzZ0NUxDZzdYZ1NTcGJKcEtBOEplR0RaRVhXc3NZY3pIMVEw?=
 =?utf-8?B?UjY1N1o1Y1BTNjM0WVJ2MXNnSlhFM2F6RytzWURqSlFvMDMySGd0NmRHM25s?=
 =?utf-8?B?UzVhQU5QcHBwd1NpNlJCRWVQRkZlQThBOG9pR2NFc0FLQnBGQmRjSGJHdFVv?=
 =?utf-8?B?TEtzbEhiUFZmV2NXTWpxY3BxL3I3T1VYU3pFemg4NW1LY2lPeW1Ea2dYb1hR?=
 =?utf-8?B?WnpNS0NoQk9acENUbzd0RXMrVDdZZEFUc2lONTZPSjB3VUcya2JPYW5xT0Va?=
 =?utf-8?B?N0lsUi9IeitYUzVDZzd4VmZIOFNMelYzVWJqZ0NpaDNVN0JRanVmWnlXY0ht?=
 =?utf-8?B?UXJGendtYWZjNmpncmtoeUZGenI5RWlKd1dDT1dGa1hyVkpTaGNPTlB2YnJl?=
 =?utf-8?B?b0wxY2M2bDFJMVk5UTUvMDYvamp5MUE0TXhjdk5KLzY1OU0yYWhjcjNCWVRN?=
 =?utf-8?B?VXExWHc5MXZZQjN1WU80ZDJqdm03MGNTbkFEeFlGQzdxYmpOQSt6T2d4TjB4?=
 =?utf-8?B?VWppc2dmUVhQT3hOUzBpSExySUIrcWU3UVdHalFSSEszVEdxMjkvSVo3RlVj?=
 =?utf-8?B?L1ZCcEd5Zk8vNGxKa1N5WFBXLzN4YXZuazk4YWpyOElPOVJPWFdLeVFzVzhL?=
 =?utf-8?B?TUVNU1dEanpzNWpWTDhFb2tLeVIrTnNRaUppV3VwNTNmVFJaTjViMThYNTAx?=
 =?utf-8?B?dWR2U0d1SElDZWZRLzRMYndONFQ1QTFBNXU5QUVXdjBRZExSeVkwa2hkblBi?=
 =?utf-8?B?MXBnc2drVHJqL3FVY2k0V1FJVkpNV3VJR29OU0cwODY5ZCt4aVkvd1FwbnBj?=
 =?utf-8?B?WVVUaElJbmgrQkxuQkxzQ0Y5akJ2SkpMQlM0Y2hXa3MzYkQvQmJUQzF1L1VP?=
 =?utf-8?B?Rk1kLzRCTndLa1UrdjdVQ3ZNOTd3bU4vN0wvWFRWTC9LWXZjd3RqSWdWazUx?=
 =?utf-8?B?UVcyaWU0eFpzZ2pobGVQTGZLcjE2bjIyRlJ4SThNbkNkRC8rdUI2Sml0VkM0?=
 =?utf-8?B?UG5wQU9QRVo3UEVWR3B2Yndxa2wzRjNZdUFpcTYvVkxSb3Ftd3M0dzBBK1NV?=
 =?utf-8?B?a0VOamhZcTlMWkFrNHNoUE5FQ0xhQ0ZXVW5aL0k3VGFSZEpEdjlFSDVNK3Rh?=
 =?utf-8?B?S0d2ZDdKRjRzaS8rNHFVOFhDT1ZaQmV6bE5CTnVhUlF6OVJPRXpHek05MWhQ?=
 =?utf-8?B?MExVLzVtbFEzZENnVTRmSE9xT2tHb0xtcGNXZVZUQUQ5eGcwaytvTnh0UVBx?=
 =?utf-8?B?azZPamQ0QWNmeWZROWZ5bDVkVHFteEsvdTNZSlREVUx4ejZsRm40Y0l2elNn?=
 =?utf-8?B?bHBEZWliSkdRa3VGdytIYUkyK0FreVdEQlNiSjk0WXNyUFlJSDlFbk9wY04z?=
 =?utf-8?B?RDhDQTlsUXBFbUdIM1M3MUwza2FKYXVBTkZ2RkZaWDNidTFpbUJGNjZiRTkv?=
 =?utf-8?B?eEtYSExiN0dHSXltWk83QThiQVYwNUxUUnRxTE9DdXFVYVRtUXJxdGVCUUdU?=
 =?utf-8?B?amk1WUpCVlQ1dGdMbFZ1N2dEWDl2U2pwVXEwdThnczhvbzFGUzcvdXRlZW12?=
 =?utf-8?B?YXd3ck83NVNzS1ZNNERGV2xZUk5ZTjBEMFpqS3RBaVpONTd0aXBzTFcySTg3?=
 =?utf-8?B?QXRCS0RjTDlrTWJVempwRk9yazVtUnkxc3pzTEM5NWd1T2VKaDVPWCs5eFZQ?=
 =?utf-8?Q?PVBxXw6GZ7lVL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3B5cGk0VGdHVGlRd0VTQWR0WGovTjk5N29ndWRKc1pUWi9TSjRlRG5RSXNw?=
 =?utf-8?B?cGZkOGg4RjJhVHd4NEJCYUpubHA5cTZTT1ZOMUR0ZENrT1VlMWRFQUsrSlZn?=
 =?utf-8?B?SWFRM0xMemVLeDRvSkZqM1Bkanh2blNMUU5BUHFnc0VYeTJHSnpYSUo4aHdK?=
 =?utf-8?B?ZE9hTGFDNjFTYjNsd3VsaVRkem50aWUrUWU3aEE5TG9UeWNuMjJiTWcrN1NN?=
 =?utf-8?B?Yk1DM3lDYXd2c2dzZWJCazRoa3h4Ris3eTV5a3RET3lsZWJONFlXNGl6UWha?=
 =?utf-8?B?aHFFcTJoa2Z2OTlFVmFKY2Z0em9ZckFqZzVEM1ZkRVZSRjUyc0IzbUw5Wi80?=
 =?utf-8?B?SnhyZTg5RmlZb2lXOGtITTBNZnU3WDE1bHZTalpDblQ0MVNZSnd2WGkycXVV?=
 =?utf-8?B?WVZKU2tvWGp4NTJRQlpUbnNiWEJQOEc0ZURUOWZpMjAraXN4R1BaVkJmbXUw?=
 =?utf-8?B?TVB3RVFlaExaeGNhbjJoMnc1NkhjbGR2Q21HQjNyL3o4bWI2YmZsaXJ5eis2?=
 =?utf-8?B?MThYYWlhWVdSUTZPeHFJL3NteC9tMU0wT2ViWWYxU3JPS0JqbXhxbnNBL29Q?=
 =?utf-8?B?QVFlVDJjS0J1SzY0a1BlR2tkZkdUeU82dFdlSTV1bGZmb2pBNVdMbE4yL3pG?=
 =?utf-8?B?S1MvVlV3blFyUVp0MWNqZHFaOUhRZnMzN2MvL21MZDFRRG9EN2xoZlp2REhR?=
 =?utf-8?B?OVlaRFl3S1p4Sk1UTC96R3o4OFRUeGRYa2FjWEZHMjZQRW1Ca0lWZ2MxTlhJ?=
 =?utf-8?B?REtUVmsvOVFtM1dFeTZZM3dIMkZCYXduaE10QjlMRlpZZkhYaEpBOEFLMXd4?=
 =?utf-8?B?M1JtbTNRMVQ4SjNIa002K2xzTlpOczJiYUpmQ0F3NjdiSC90ZVE0RWZ6TXVq?=
 =?utf-8?B?SWx1bzFnWU5xRnVyWlo5Tld2azV3U3YrSUVYc2IydUtuMVh0bytRWEFaejdF?=
 =?utf-8?B?ZVhOY3l5Ti8wSmNQNFJ3dHlvOUFiQmFxQWFrM1BVTXFoejFqbEJaUWtLY2Er?=
 =?utf-8?B?bFJKZllsc0MzWGg3YlRxaGtpd3FRckpNUnFldW4vQ1B5ZXgxa001dHk0SGpV?=
 =?utf-8?B?bm1EU0FLNUI4a2xKQzNENHh6SkFVZVhraWtYYUVrTUZ4cjJicHdZb3lTeWEy?=
 =?utf-8?B?Sm0zekxxbnJEQ01yOGdUa3JhSm43dGIveVhSOElUcjA2MHZNTDFiQUxmaERn?=
 =?utf-8?B?VW5ZSElEMlNFcFZJNVpTbXpVUFByckQ1RVBNMjg3cU13RkVlNEpJSnVkZFZ1?=
 =?utf-8?B?NDA5RncwaUdiSi91MVkwdmYrTm9iN2xOQmRTeE92K0VucjJJR0FOenNZM1Zj?=
 =?utf-8?B?cHdLcU83cGRjSFNTamlMdTRZWDNYcHBUNjlvejRST1FpRWVtOEhycVAyVGZN?=
 =?utf-8?B?Z2pPenVMdGdqVy81WW5ralVHd3BiTW14Y21YOVdQeXV6cGl3ZHVjbzhhQ2lo?=
 =?utf-8?B?VktjMVRhd2gxK2d4YXkvVFJCbzN4OTJFNFBCVGgwVTVKRWxMVU5GMXNoR0hl?=
 =?utf-8?B?T1J3R3ZVOWVIRUV0L3A4dzl0WkQ2emlNRnJVeUV5THU1TytiQUpDd0xHY1p3?=
 =?utf-8?B?UCtQcm1OYUQ1M3N2YWVzOWQ0NGlDQjk1REdJR1lUODNEblE5ZjcxaFltNVNh?=
 =?utf-8?B?bG44Z3RtTXZnZmtkaFE5MzR6NlBDeWdINzBOa01HSmFrbXB0ZTJob3dQN0Ru?=
 =?utf-8?B?ZVFnbWV4QWwyeVpLMEt1VitNbThrM0ZDMUwwZjBhNVMrZ2t4RmJCd045UHlw?=
 =?utf-8?B?Qk4xNW82YW5kQ1hIMXFjRE9Fd2NPL0JmeTlNZVZ3elRvOWZxVm91cy9jdXY5?=
 =?utf-8?B?VTJreDlNamFZb052WmRVVHhjWiswNSt6ckZpdjcvb1dzQVFvcURFejR4Lzdr?=
 =?utf-8?B?VmJvZjJMZ1c2a2ZWRWdmOWN1RTNSYWh0RzB6NTdZMkhTNWpSTklpdnFWeEhr?=
 =?utf-8?B?b24zZEk2dUYvMzhPU0VZNWpXcURLc1NxOHR2ZGluTXlvOHNzY212YTRKWFlK?=
 =?utf-8?B?d0poYWlxL3YzcWxnZkUzYjlxczRHUDBnQ1laTlMxKzQzUmJLTlVBN3pSZ0hE?=
 =?utf-8?B?OGFSam9vTFdsTFNzeTdRWTBNeERXQ3kyOEgwY1JtUFVZN1hNdWNhcnVvSzRK?=
 =?utf-8?Q?7SBpdF42urNix0+bVaKieyl0p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff6b8d0-2b2e-440d-377c-08dd4b27c50a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4270.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 05:40:34.7544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ee+rZPxwG732+SqkXQjEl2EMOow2hlOMyL9MJgo0pRVnOqXvOlbHRoCzRuFCRk+Blae6ZpjkZvhmPorzyHfybg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5851

On 2/12/2025 8:28 AM, Liu Ye wrote:
> There are multiple locations in mm.h where (folio->_flags_1 & 0xff) is
> used. Write it as a macro definition to improve the readability and
> maintainability of the code.
> 
> Signed-off-by: Liu Ye <liuye@kylinos.cn>
> ---
>  include/linux/mm.h | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7b1068ddcbb7..750e75f45557 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1098,6 +1098,8 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
>  struct mmu_gather;
>  struct inode;
>  
> +#define FOLIO_ORDER(folio) ((folio)->_flags_1 & 0xff)

This folio order calculation is only valid for !large folios.
When it's a single page (not a large folio), the memory is interpreted as struct page.

struct folio {
...
        union {
                struct {
                        unsigned long _flags_1;
                        unsigned long _head_1;
        /* public: */
                        atomic_t _large_mapcount;
                        atomic_t _entire_mapcount;
                        atomic_t _nr_pages_mapped;
                        atomic_t _pincount;
#ifdef CONFIG_64BIT
                        unsigned int _folio_nr_pages;
#endif
        /* private: the union with struct page is transitional */
                };
                struct page __page_1;
        };
...
}

I feel this to be risky, considering someone may directly use FOLIO_ORDER() macro
without folio_test_large() check.

Correct macro should look like:

#define FOLIO_ORDER(folio) (folio_test_large(folio) ? ((folio)->_flags_1 & 0xff) : 0)


Thanks,
Shivank
> +
>  /*
>   * compound_order() can be called without holding a reference, which means
>   * that niceties like page_folio() don't work.  These callers should be
> @@ -1111,7 +1113,7 @@ static inline unsigned int compound_order(struct page *page)
>  
>  	if (!test_bit(PG_head, &folio->flags))
>  		return 0;
> -	return folio->_flags_1 & 0xff;
> +	return FOLIO_ORDER(folio);
>  }
>  
>  /**
> @@ -1127,7 +1129,7 @@ static inline unsigned int folio_order(const struct folio *folio)
>  {
>  	if (!folio_test_large(folio))
>  		return 0;
> -	return folio->_flags_1 & 0xff;
> +	return FOLIO_ORDER(folio);
>  }
>  
>  #include <linux/huge_mm.h>
> @@ -2061,7 +2063,7 @@ static inline long folio_nr_pages(const struct folio *folio)
>  #ifdef CONFIG_64BIT
>  	return folio->_folio_nr_pages;
>  #else
> -	return 1L << (folio->_flags_1 & 0xff);
> +	return 1L << FOLIO_ORDER(folio);
>  #endif
>  }
>  
> @@ -2086,7 +2088,7 @@ static inline unsigned long compound_nr(struct page *page)
>  #ifdef CONFIG_64BIT
>  	return folio->_folio_nr_pages;
>  #else
> -	return 1L << (folio->_flags_1 & 0xff);
> +	return 1L << FOLIO_ORDER(folio);
>  #endif
>  }
>  


