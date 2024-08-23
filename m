Return-Path: <linux-kernel+bounces-299147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F0595D0EE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5673C1C2153A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A837188CB0;
	Fri, 23 Aug 2024 15:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Woeh4xEh"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2043.outbound.protection.outlook.com [40.107.215.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4544188A21
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724425476; cv=fail; b=OevTE/xLxb1voBlmFRKq+vrYxP7scr2nv6nCb+Wf67KwdKawMqE/exYPcv3CawuCUzVqOOrlVp5pxP127sux0XlO9k2eleqUtsYrWIos2wHrdJp7E8I/pseP3JurvlCbY1V36mY9gY/2ZK3MAO4ZRqqvyT0/GmANLZ2LlQ64cRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724425476; c=relaxed/simple;
	bh=OS7oElMBza6uCNrbX/hvIJz0wVEBi/qKfQVs8lc2UFk=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ay0AcSA6a4+7/sBtFRR1tGL7HxHgVO9VB7c7ZnX71PjRRLbV4gIlVUFAbM4S/dKpg/dexx6WUC+4crk8qZpi1yfwf1R3CXOcq8lRjX00pt5pJhyrA87NmZ37we4KqdKmgFTJR20RXkYbjjJYejAyoT8oZN+nGn75K1ZWxnuEsSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Woeh4xEh; arc=fail smtp.client-ip=40.107.215.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6/Z4oZVi3obeVDYIaMR4y/Tc7cHZIP29QNFFzWcAtyifKuePIX8wCnsXaQrvvZqlu4gM2u7yr7995g7dn64bLW71TvwwT9s7RSNEh+6e0Q3koStXHf7r2/Rr6+Y7AQ7wBnWY3Mu0xf+Uh4A2t7aCAnZZukcSZ7vdj/GmALyD8hA0icBgC2IZFo6ZfqMHAF0gP5wyfTkrh64QZf0lgoEGdSZaiOZvUQFWtIr/WPv5MGoJjeVoYMIIuUgwh1qeXDBn2TMLsii+6IQOd4709A7jXojMAbKto4aMdiHBF7LHV8yLj/m1tadxlxOy4dBkc66tNY5jUi6ybrVgjyAuusBpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xzht31lawVhPjmbYbZkZ7M0miGQuggUuej3fbTq6+lA=;
 b=ee76T8cOgIWN0Yd2pmHZ5jmQMtm0uzlgMfCe2rajOOVMrz0Eg1OCv/9+Yf/QZHh4bgQa8O4gSw345CoJvYPeykgyrq5QK1WDIs2NalrxPwViVJkXG21hYn7vMpqlelZ0pDXVtJHQZ3yMbVlk/uoHvOBZf/uMxxJ6UNN5p1fndMZcSEzkte1ASrkFSWGI0F1VEcc1KTXBH5w47Fs7okGPj8DXuUBtSuPRBG3yOsROUHpeDnc7A7m627KUM7pp+yRZk1auHgkVfDD0aZ9RAVThR604YaIimmPB3S/7Dh6+QCi59DLPwwjeePi3JFjhltH3fE0EWtqgvdCtsaljG1C2Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xzht31lawVhPjmbYbZkZ7M0miGQuggUuej3fbTq6+lA=;
 b=Woeh4xEh0+Kl0DVL8nHgzjTzxgij6qMBVf2cJavct/MRpiimvczYDHDqbkTO5h1EeBghL3LokU9mFlEgXaLaHdtZI6hlxMnfGC0Jh7p0pGygTkGI7gkymtL8DFDjHhWBXxPUFAAl2syCB/R2zHPn4CDLUxfkgfOyVcf5tBb5ggZxuIGGqqQUoegke8g9GoluNpVY4CgbGZZgOzdCcLmMnfAVzLETF4XpIFHJdC/mf85xmASz0jm0PfxmRB8nOO3Ckbg9QaixtDSy2A2lsDroKCYxr8Y1BFsFA09C9bbyE5PgcAn5dWP496+0YpwElXe1wMp0CCiMLKN/ci5WxQF2pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by OSQPR06MB7249.apcprd06.prod.outlook.com (2603:1096:604:291::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Fri, 23 Aug
 2024 15:04:29 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7875.019; Fri, 23 Aug 2024
 15:04:29 +0000
Message-ID: <b0353ada-cd23-4b20-b1df-551de12824cd@vivo.com>
Date: Fri, 23 Aug 2024 23:04:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: vma remove the redundant avc binded with old folio
From: zhiguojiang <justinjiang@vivo.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
References: <202408230938.43f55b4-lkp@intel.com>
 <617ea0f3-3a7c-453c-af65-f8724008ac4a@vivo.com>
In-Reply-To: <617ea0f3-3a7c-453c-af65-f8724008ac4a@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0227.apcprd06.prod.outlook.com
 (2603:1096:4:68::35) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|OSQPR06MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: cdd1e58c-cde3-4e5c-54ec-08dcc384e2fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3lWMVF3QU5CaTVYL2owRmxHVUlvWlU4Sk5pT0l5NmVpeFVBS3ZVNCtZVzVG?=
 =?utf-8?B?dkpNT2J2bXhxeWNDK0pnUzF6NVBNZ1dDOFg2TGpLQmdta3pNRERsMjg1T1ZN?=
 =?utf-8?B?bjBSS0lXWnMvUVo3WWxYWUVPV21sU05oLy9ONmpiWUI2SUkvUUNSVk5zZ0Jh?=
 =?utf-8?B?VUdmdFN1aGphbElWcGtjUlFOMzcrUkFjVWZ2NmVnc2RoZENpMTBUMmdwNnRI?=
 =?utf-8?B?S1YrMFd0Vy9WZTM5OHdZaUhUa2lJbkgrTHNuU3d2ZGlwcGFlYmJJbDFRdzlx?=
 =?utf-8?B?Sys1UVN2WllieEphUHRBeHdvUDVyZlBuWTJUV2w1cTZvOEZ0QmZyT0hGZFow?=
 =?utf-8?B?U0Z4RlJSM1dmWTJMUGRtRTJIVFo5ZkVGWXBnQkl5TjI3UEg2V2NIY1lETUd1?=
 =?utf-8?B?K2c2dG9pa2dKcXZyZ1Zlb2VzOVNhVllQS3BGNlNla1RqZjJ2RXROa3Zka0hh?=
 =?utf-8?B?dmQvWlRvMkxpbXhzdXpQVzlhR2NSYWFObjljN3U0K1VUWDVGbTRqYVpZRGNN?=
 =?utf-8?B?V2V3dzdvWlFuMlJpcFpOMFc0OTFTZkdIdml3TW9pN1MrcWtLaEVCZ0xsajZC?=
 =?utf-8?B?c0U2M3ZzaDRxek5EOTRWZmhVaDN4MkVNY1E4eisvMnE5S3BsWm1XeXNSUktp?=
 =?utf-8?B?c1Zta0JJNU9WWXJGbjdXQThESlJaaG56VGk5aytBVzVNa2dYZ2FhMkZycmZh?=
 =?utf-8?B?NllEMTVkMHNNMDUvc2xZcUJ5NGd3UHVuYmhiTjJMU3h6S01CUjNWK2RiVFpU?=
 =?utf-8?B?SVk3VDR6cFFkYXNSTTUrcVNvTC9tQmJCNklYZ1hoL24vUmpoRkpUZ2dNZm1h?=
 =?utf-8?B?VDJReXpxWmxOVVdBYWpaVXl2Z3Q2QTNOTDRtOE1ZZGJDZUFyS3pVK3poY0c2?=
 =?utf-8?B?eGJjZzdBRmZuOTllVTlINXdsdDVOZE5kcG9mUy9oN0ZZQy85d250TDZhZFNL?=
 =?utf-8?B?SkxSL3l4ZzU0SjVPYytEaEVPV29md3p1NXJJa09hZitVSTJPNW0zaUtySUVk?=
 =?utf-8?B?Y0JaVUxtUmhBZnlqRXovOTlHSGFRd2pEK0FwaUc2OGlOWUdNYjBxMHY0OUlU?=
 =?utf-8?B?NndBdm82WmUwUmFqSENsdnlKaEs1cVdodWowRjVJSGRYNDd2T3VCc3NFWUxW?=
 =?utf-8?B?dk14alNhWGxVYy8wTGJSMEROT2lpUGVZUXFndVNRcTFHMzE3b3czZHZjeUp2?=
 =?utf-8?B?WXNOa1E5bXZTWmwydXNIUmUzbXZ3OUNQR2NaUVlpdEhxbzNMZ3dabjY0YnBp?=
 =?utf-8?B?dTRhdFp6RC90Zk1nZmJMNkc0Ykt3dDNESis2Yy9hS203emM4aXJWS2VEbDF5?=
 =?utf-8?B?THlDLzFwUnNQeFkyNi9pd2xON0oxb2Z0QzllSTViYkFsVDhEUmxpd1p1ZVJ3?=
 =?utf-8?B?b3NtZ0lIMzJ0bDlSUzUwUUhIalVYWE5CWnhoTUVyWFArWTdTRzNMRkdtREN6?=
 =?utf-8?B?ZXM2YktaZWt2UFlkRDlxOHJ2d1cwVFZPZmk3RUpObTFZRVI0YlByMkJYczFx?=
 =?utf-8?B?MnVsMXRXMnFWNzdFaGp0U1VzRXZRUUtWZW5mVktFaVM2d245UW02VGdkaGhz?=
 =?utf-8?B?QzJxd2NZdUJJYm0yZkdkQmtZbkdNQmZrbE8yRTF1cldzOCt5cHRvTU0xL0ZW?=
 =?utf-8?B?a2hSVEpOLzMxWlNKYk5VdG1pVTZzdmpPMnd4VjZubGZ6a2pIcjdxZURhTlVR?=
 =?utf-8?B?UG9vQ3NBanpFTHA2eGFsOVBYUTU5ZSsweGlvVlZ1ajUrOERWSEhsNzR5N1N1?=
 =?utf-8?B?MVhsSEI5TVM5WUlIQjJJKzRlbEdCeUkwdFdueFBOYVlKZDZPTmovbFhsOWwy?=
 =?utf-8?B?ZHNKMy9yLytKYnJmQ1VuUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S214cVlwUFV2U2x1dUNNNHlia3Y0K2FRYlV3QkI5a2ZZQzg5a2lTeFVqV3cw?=
 =?utf-8?B?TlJ3WVhjZG15OXJpNmJJQWpNanlFWWM0UWl1MUdGelBIVXVFTXBxaEZybXZv?=
 =?utf-8?B?K2V5dEFndHNWM1lVTElnWWFLVFVkdEtMQmRUZjQyUlMxNzZYVWQvamFFZjdI?=
 =?utf-8?B?LzRzd2EzTTBaRGhrSkJMU0YzNnJCRDM0UTFSL214U3BxdVJZcm9YTjI3OXFD?=
 =?utf-8?B?N1BYWDd2U3F0Z1V0R1U2ZlZ6TklCZkpHWHFGQ0NZMDh0MDRvUi9JbEF2N2pT?=
 =?utf-8?B?U0hmUGR1cVN5TSt2SEhXWjJGR1Y0QTJ0NU13UVB6bSttOThESDJJOCtDRjI5?=
 =?utf-8?B?c2NBbTRMT2hrNGNvL1hpd3F0UHI1TXhYbWl6RUlkOERsbzZIZ3ZXUVFlcW4r?=
 =?utf-8?B?MVFta0ZuWERwNTJ6ZzR5N3hPZ3dDb3laNFJCVW90amdIVkVuOStaV3RlZm4z?=
 =?utf-8?B?NkI4bjBrNzFOOWF4cDJwalhPU01sUmwwbG16VDd3MGZVWjd2MTRBeTAxSFRL?=
 =?utf-8?B?U1NXV2ZwWHRES3YrZTNQd0VvSjJYeHFMWUhBeG1uWUdCT2g1V1hJMkFINksz?=
 =?utf-8?B?dnFOVnU3RUNYdEpQamVMY282NVQ1OGJTSS9rSEFzaXBFTlRPcWJyd0FEbytt?=
 =?utf-8?B?djZrSW9IMmtTR0FGUFhraHJQanp3U29lM2JORmVuMTdFQW1kWXMwNXpRL09t?=
 =?utf-8?B?ZXJmYTA1dEV3YzVqd1JPM3RMS3B0U1o5OERlUzEzMDRoU1RnL3JRTFlTMEF3?=
 =?utf-8?B?S0F6V2hqRG5kdGVWWXoraTRrZTVCOENEQXlNM283U00yQmtJQUN1RkhxMFZs?=
 =?utf-8?B?VzB5emZHMDBlUlZWMnJDSjBKWitZNEsxUDdzMGdhQmVuWkVZRHoydGtrV284?=
 =?utf-8?B?ZTR4TlFKZ3ArQUVBd0dUZFUycHBJK0VpQmk0RCthbHlmc2hQUUZjeUNyR3M4?=
 =?utf-8?B?WmRTNnQ3emhwMTdlUWxJTE5PazZ0OWJRd1pXMWxhT1JCWFlHcmUrVjFvalo5?=
 =?utf-8?B?b0RLRmNqc05pbURaV2RYRHBzVUtza0JZUXFOeFdHSEJyUlYvM1B4d0RUOFdh?=
 =?utf-8?B?VUtxZWZTRkNPc3J6cUUrOU1ubHM4dDNtU3V0dm9LUVYrNy9BUFhYOU5qQits?=
 =?utf-8?B?WE5WZytzUVhmU0JWbFExWUxMZkw0dmdWNzBNS3hRbnArd1Y1ME1wZVFZTU1K?=
 =?utf-8?B?WEZGdUk2Ni9JcEdRaGFZcnlBMEEyQzhHQTJrWDBJRm5tVSt6a2JtSk4vVGV3?=
 =?utf-8?B?Q2xhQXRUcm93dWsvUHdOTmYxTmptWi8xWmZtamxzb2p0YnpoZFFtMUlEWExo?=
 =?utf-8?B?bmtnL3F5NHVFWEJwZ1JiWjYzSWlZUjJEbGxjS3plZ3VndkI3TnpJQmQ3UEdk?=
 =?utf-8?B?VHBoRVF6aldHTkEwRDNIYkhYaFhwNG9hZTlpZUtNeFFLYlFMd3kxcXBwU2Ey?=
 =?utf-8?B?RjN2dHBQTS90bzdXbGN5RFliRlZKU010YzBtSW5DVXpvVWJZUS80dWwrMG52?=
 =?utf-8?B?enYzUkFyYm9NTTVxaTQzMHY1T2ozT1U4R2EyYzlTbGZmdlBVNG5vdUpzclVJ?=
 =?utf-8?B?ZjZxYjZaazAyb1A2MDFvYy9nelkrOG1SeTM3TVYzSVFhZTlnc2FRb2dRdTBs?=
 =?utf-8?B?WHpoTGJmeGNxcGJkYXZvbGVSN2FKT1dsYytEZ2UwZ1QxWGhTQk1XWkJnWmZ4?=
 =?utf-8?B?UWRCb2EwRGw0MEovbjNXMXJ1dWJjanE4U01qUUpSZ2V0eVFKZTdYTUpnZlRC?=
 =?utf-8?B?L3ZVQ3RTcUI0QmxTSzVKMllHeTlSd0ZjM21SUUwvWDg3OW9mSVdRMmU2djZY?=
 =?utf-8?B?blF3bXliR1haNHdLVC9ndEJ3aFhsNjJyS0oyU3cyc2l1TzBMQUFOS3RsaWhN?=
 =?utf-8?B?YzhPWDVHUEs1WDFZeTVtTUpkWXlUS0cwaUZGMFVzcWJoS3dFQm1GTmJPak4x?=
 =?utf-8?B?SHcrZVZLOTIrNEZJK29ENzRqSG0rRTdvT2pHSWVzOXlXZFd5L0dVcHJKaWJ5?=
 =?utf-8?B?cWIzU3lTMkJtNjFBd2JGeFY5QnErZGNlUnFUUmoyTzFXUUNibVVPNTZxOFA1?=
 =?utf-8?B?S2xjYU13UWpzMGhyUlhueC81cUFTL0VKM0tZdjZCYmUzbEhxU1JVR0M0Wlow?=
 =?utf-8?Q?JtSnkCn6z1JctXWFPEhddyPrK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd1e58c-cde3-4e5c-54ec-08dcc384e2fe
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 15:04:29.1937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YuOS7q6uNOBPgfCW1STXObMLK48BaHgwqxAyqgWrTmzrwj/ADZ2tGZOq++26K4wSpdIeyCHs+7YECLe2xrzc/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7249



在 2024/8/23 22:04, zhiguojiang 写道:
>
>
> 在 2024/8/23 10:33, kernel test robot 写道:
>> [Some people who received this message don't often get email from 
>> oliver.sang@intel.com. Learn why this is important at 
>> https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Hello,
>>
>> kernel test robot noticed "WARNING:at_mm/rmap.c:#unlink_anon_vmas" on:
>>
>> commit: ae307233d6efc18c3d6015b127b099450ca8588e ("[PATCH] mm: vma 
>> remove the redundant avc binded with old folio")
>> url: 
>> https://github.com/intel-lab-lkp/linux/commits/Zhiguo-Jiang/mm-vma-remove-the-redundant-avc-binded-with-old-folio/20240820-223531
>> base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git 
>> mm-everything
>> patch link: 
>> https://lore.kernel.org/all/20240820143359.199-1-justinjiang@vivo.com/
>> patch subject: [PATCH] mm: vma remove the redundant avc binded with 
>> old folio
>>
>> in testcase: boot
>>
>> compiler: gcc-12
>> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 
>> -m 16G
>>
>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>>
>>
>> +----------------------------------------+------------+------------+
>> |                                        | 75bee94793 | ae307233d6 |
>> +----------------------------------------+------------+------------+
>> | WARNING:at_mm/rmap.c:#unlink_anon_vmas | 0          | 6          |
>> | RIP:unlink_anon_vmas                   | 0          | 6          |
>> +----------------------------------------+------------+------------+
>>
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new 
>> version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>> | Closes: 
>> https://lore.kernel.org/oe-lkp/202408230938.43f55b4-lkp@intel.com
> Fix the issue, please help to review again.
> https://lore.kernel.org/linux-mm/20240823140139.263-1-justinjiang@vivo.com/T/#u 
>
Sorry, please help to review this patch.
https://lore.kernel.org/linux-mm/20240823150206.565-1-justinjiang@vivo.com/T/#u

Thanks
Zhiguo
>
> Thanks
> Zhiguo
>>
>>
>> [   36.655884][  T197] ------------[ cut here ]------------
>> [ 36.656843][ T197] WARNING: CPU: 1 PID: 197 at mm/rmap.c:443 
>> unlink_anon_vmas (mm/rmap.c:443 (discriminator 1))
>> [   36.658183][  T197] Modules linked in: sg ata_piix libata 
>> crc32_pclmul crc32c_intel scsi_mod polyval_clmulni polyval_generic 
>> ghash_clmulni_intel sha512_ssse3 aesni_intel scsi_common cmdlinepart
>> [   36.660508][  T197] CPU: 1 UID: 0 PID: 197 Comm: lkp-bootstrap 
>> Tainted: G                T 6.11.0-rc3-00378-gae307233d6ef #1 
>> 5ff8330b382acbcd2719e520175822ac6c64d0eb
>> [   36.662685][  T197] Tainted: [T]=RANDSTRUCT
>> [ 36.663288][ T197] RIP: 0010:unlink_anon_vmas (mm/rmap.c:443 
>> (discriminator 1))
>> [ 36.668434][ T197] Code: 7f fe ff ff 48 83 c4 28 5b 5d 41 5c 41 5d 
>> 41 5e 41 5f 31 c0 31 d2 31 c9 31 f6 31 ff 45 31 c0 45 31 c9 c3 90 0f 
>> 0b 90 eb ad 90 <0f> 0b 90 eb 82 90 0f 0b 90 48 8d 7e 08 e8 2d a2 bf 
>> ff e9 ca fc ff
>> All code
>> ========
>>     0:   7f fe                   jg     0x0
>>     2:   ff                      (bad)
>>     3:   ff 48 83                decl   -0x7d(%rax)
>>     6:   c4                      (bad)
>>     7:   28 5b 5d                sub    %bl,0x5d(%rbx)
>>     a:   41 5c                   pop    %r12
>>     c:   41 5d                   pop    %r13
>>     e:   41 5e                   pop    %r14
>>    10:   41 5f                   pop    %r15
>>    12:   31 c0                   xor    %eax,%eax
>>    14:   31 d2                   xor    %edx,%edx
>>    16:   31 c9                   xor    %ecx,%ecx
>>    18:   31 f6                   xor    %esi,%esi
>>    1a:   31 ff                   xor    %edi,%edi
>>    1c:   45 31 c0                xor    %r8d,%r8d
>>    1f:   45 31 c9                xor    %r9d,%r9d
>>    22:   c3                      ret
>>    23:   90                      nop
>>    24:   0f 0b                   ud2
>>    26:   90                      nop
>>    27:   eb ad                   jmp    0xffffffffffffffd6
>>    29:   90                      nop
>>    2a:*  0f 0b                   ud2             <-- trapping 
>> instruction
>>    2c:   90                      nop
>>    2d:   eb 82                   jmp    0xffffffffffffffb1
>>    2f:   90                      nop
>>    30:   0f 0b                   ud2
>>    32:   90                      nop
>>    33:   48 8d 7e 08             lea    0x8(%rsi),%rdi
>>    37:   e8 2d a2 bf ff          call   0xffffffffffbfa269
>>    3c:   e9                      .byte 0xe9
>>    3d:   ca fc ff                lret   $0xfffc
>>
>> Code starting with the faulting instruction
>> ===========================================
>>     0:   0f 0b                   ud2
>>     2:   90                      nop
>>     3:   eb 82                   jmp    0xffffffffffffff87
>>     5:   90                      nop
>>     6:   0f 0b                   ud2
>>     8:   90                      nop
>>     9:   48 8d 7e 08             lea    0x8(%rsi),%rdi
>>     d:   e8 2d a2 bf ff          call   0xffffffffffbfa23f
>>    12:   e9                      .byte 0xe9
>>    13:   ca fc ff                lret   $0xfffc
>> [   36.671148][  T197] RSP: 0000:ffffc900019ffad8 EFLAGS: 00010202
>> [   36.671931][  T197] RAX: 1ffff1102e73f0bf RBX: ffff888173c55ab0 
>> RCX: 0000000000000000
>> [   36.672880][  T197] RDX: 1ffff110241d68e2 RSI: 0000000000000000 
>> RDI: ffff8881739f85f8
>> [   36.673933][  T197] RBP: ffff888120eb4700 R08: 0000000000000000 
>> R09: 0000000000000000
>> [   36.675002][  T197] R10: 0000000000000000 R11: 0000000000000000 
>> R12: ffff8881739f8550
>> [   36.676082][  T197] R13: ffff888173c55aa0 R14: dffffc0000000000 
>> R15: ffff888120eb4710
>> [   36.677134][  T197] FS:  0000000000000000(0000) 
>> GS:ffff8883af300000(0000) knlGS:0000000000000000
>> [   36.678328][  T197] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
>> [   36.679207][  T197] CR2: 000000005663e33c CR3: 000000012021c000 
>> CR4: 00000000000406b0
>> [   36.680251][  T197] Call Trace:
>> [   36.680681][  T197]  <TASK>
>> [ 36.681079][ T197] ? __warn (kernel/panic.c:735)
>> [ 36.681682][ T197] ? unlink_anon_vmas (mm/rmap.c:443 (discriminator 1))
>> [ 36.682312][ T197] ? report_bug (lib/bug.c:180 lib/bug.c:219)
>> [ 36.682920][ T197] ? handle_bug (arch/x86/kernel/traps.c:239)
>> [ 36.683494][ T197] ? exc_invalid_op (arch/x86/kernel/traps.c:260 
>> (discriminator 1))
>> [ 36.684125][ T197] ? asm_exc_invalid_op 
>> (arch/x86/include/asm/idtentry.h:621)
>> [ 36.684804][ T197] ? unlink_anon_vmas (mm/rmap.c:443 (discriminator 1))
>> [ 36.685501][ T197] ? unlink_anon_vmas (mm/rmap.c:400)
>> [ 36.686185][ T197] free_pgtables (mm/memory.c:410)
>> [ 36.686819][ T197] ? free_pgd_range (mm/memory.c:367)
>> [ 36.687466][ T197] ? preempt_count_add (include/linux/ftrace.h:976 
>> kernel/sched/core.c:5634 kernel/sched/core.c:5659)
>> [ 36.688179][ T197] exit_mmap (mm/mmap.c:1934)
>> [ 36.688758][ T197] ? trace_contention_end 
>> (include/trace/events/lock.h:122 (discriminator 52))
>> [ 36.689496][ T197] ? do_vma_munmap (mm/mmap.c:1895)
>> [ 36.690125][ T197] ? __mutex_lock 
>> (arch/x86/include/asm/preempt.h:103 kernel/locking/mutex.c:618 
>> kernel/locking/mutex.c:752)
>> [ 36.690779][ T197] ? __mutex_unlock_slowpath 
>> (arch/x86/include/asm/atomic64_64.h:101 
>> include/linux/atomic/atomic-arch-fallback.h:4329 
>> include/linux/atomic/atomic-long.h:1506 
>> include/linux/atomic/atomic-instrumented.h:4481 
>> kernel/locking/mutex.c:929)
>> [ 36.691585][ T197] __mmput (kernel/fork.c:1346)
>> [ 36.692143][ T197] exit_mm (kernel/exit.c:572)
>> [ 36.692699][ T197] do_exit (arch/x86/include/asm/jump_label.h:27 
>> include/linux/jump_label.h:207 include/trace/events/sched.h:333 
>> kernel/exit.c:930)
>> [ 36.693256][ T197] ? do_raw_spin_lock 
>> (arch/x86/include/asm/atomic.h:107 
>> include/linux/atomic/atomic-arch-fallback.h:2170 
>> include/linux/atomic/atomic-instrumented.h:1302 
>> include/asm-generic/qspinlock.h:111 kernel/locking/spinlock_debug.c:116)
>> [ 36.693947][ T197] ? stack_not_used (kernel/exit.c:878)
>> [ 36.694605][ T197] ? _raw_spin_unlock_irq 
>> (arch/x86/include/asm/irqflags.h:42 
>> arch/x86/include/asm/irqflags.h:97 
>> include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202)
>> [ 36.695304][ T197] do_group_exit (kernel/exit.c:1069)
>> [ 36.695908][ T197] __ia32_sys_exit_group (kernel/exit.c:1097)
>> [ 36.696561][ T197] ia32_sys_call (??:?)
>> [ 36.697142][ T197] do_int80_emulation (arch/x86/entry/common.c:165 
>> arch/x86/entry/common.c:253)
>> [ 36.697852][ T197] asm_int80_emulation 
>> (arch/x86/include/asm/idtentry.h:626)
>> [   36.698504][  T197] RIP: 0023:0xf7f03092
>> [ 36.699039][ T197] Code: Unable to access opcode bytes at 0xf7f03068.
>>
>> Code starting with the faulting instruction
>> ===========================================
>> [   36.699967][  T197] RSP: 002b:00000000ffcfddd8 EFLAGS: 00000296 
>> ORIG_RAX: 00000000000000fc
>> [   36.701055][  T197] RAX: ffffffffffffffda RBX: 0000000000000000 
>> RCX: 0000000003323d2f
>> [   36.702120][  T197] RDX: 00000000ffcfde00 RSI: 0000000056633734 
>> RDI: 00000000f7ef8000
>> [   36.703147][  T197] RBP: 00000000ffcfdef8 R08: 0000000000000000 
>> R09: 0000000000000000
>> [   36.704165][  T197] R10: 0000000000000000 R11: 0000000000000000 
>> R12: 0000000000000000
>> [   36.705185][  T197] R13: 0000000000000000 R14: 0000000000000000 
>> R15: 0000000000000000
>> [   36.706281][  T197]  </TASK>
>> [   36.706698][  T197] irq event stamp: 10051
>> [ 36.707257][ T197] hardirqs last enabled at (10059): console_unlock 
>> (arch/x86/include/asm/irqflags.h:26 
>> arch/x86/include/asm/irqflags.h:87 
>> arch/x86/include/asm/irqflags.h:147 kernel/printk/printk.c:341 
>> kernel/printk/printk.c:2801 kernel/printk/printk.c:3120)
>> [ 36.708455][ T197] hardirqs last disabled at (10066): console_unlock 
>> (kernel/printk/printk.c:339 kernel/printk/printk.c:2801 
>> kernel/printk/printk.c:3120)
>> [ 36.709660][ T197] softirqs last enabled at (10006): handle_softirqs 
>> (arch/x86/include/asm/preempt.h:26 kernel/softirq.c:401 
>> kernel/softirq.c:582)
>> [ 36.710805][ T197] softirqs last disabled at (9997): irq_exit_rcu 
>> (kernel/softirq.c:589 kernel/softirq.c:428 kernel/softirq.c:637 
>> kernel/softirq.c:649)
>> [   36.711941][  T197] ---[ end trace 0000000000000000 ]---
>>
>>
>> The kernel config and materials to reproduce are available at:
>> https://download.01.org/0day-ci/archive/20240823/202408230938.43f55b4-lkp@intel.com 
>>
>>
>>
>>
>> -- 
>> 0-DAY CI Kernel Test Service
>> https://github.com/intel/lkp-tests/wiki
>>
>


