Return-Path: <linux-kernel+bounces-205093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADE58FF6F9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A0CEB20CA6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A763713B583;
	Thu,  6 Jun 2024 21:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q1l6KnKB"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA737173C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 21:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717710181; cv=fail; b=HVmQZ4iaKEvORpFb6eWBZeG7kQ3dLjqGYv6K24lY0dSfNvsne0lBWB5JZwJg0e10n936km2feYuAHHNUHsNN87JyrX0kjikKJG8bJZ2NMVfc/2CH8HW9F1FUYtcpv+NkBo+4zCG9jvhUL8hU+3jSfw/HW9KNN0tCYmzzzPMjmZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717710181; c=relaxed/simple;
	bh=E631mGo07Svq0RlLwN8Rft/LiNORNM6mVnyvfGm7a1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cvx0U4yFGXfYBHMGcBmzAQDX916UdxkDaDj35BJz2GNUAYr+sUPpRU5ugARDd02vMKlSLBJZFfm96vZ3xomta5j43y97/IXbdPpaI5e6RKNfv71wrLX1kfXt1G7iTUcgeR0mecZfjSeKjz/9peYOSLUl565pLmxZU0+v4rwUvmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q1l6KnKB; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbeFjcuaIC0MojFFkuXFvGW+2eLpeYcCnpTD5ot4r7MJDpUUXDrb4XgrqdJ5Mky4uTuIZRhK1vyPyT8ZJqh8K6Ry3XGOQ1/0iwyoV/KEFbLG7dKGLF/dB1OGoMMHMWXauD7ObNlLhzsAzcGFds4OrgeoiGw0uK3PYLAgK+30JhV77aYKr4woidNDEFx2Uys1AUjICgc4LNME5jR4hIOxPax+gTHHQE3Tddn+vSCZ7C+zHaBfQSTCCCFxZkZakgThrbiUdgnbAKh4+BEMt536o3Q7G+CGRSp68IGcrVfwjulB2VBZm5OBkhHSPUuHOpQUN/esYuux0tCEErW4fodyKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/2l5Tsa3JjQUhspRa+unhlX3F0WLMUH+7jzoSY17Hs=;
 b=WkAgOMUQjvr8/qIBWOWPOi39wStArJ4qG7Rw8ds2sYF50GS3rrvw4LToi/7/1j7mZvoqlx9IBLbkx9uRC1t1g5WX1LRKgWTQsRXDg+WjtYpYot2wWc2CJs4tjVlGqZ/1TlZpANMTbXojayXfJiQRnWHbIdaAK/6AlODQiyx3ZdsaWLBJczpGHML5jeviSgrSutONimFGRfwXaR9YrkBIP/yKE0Qbd+suPVKNSV++05C0iAZeBG8PsnK3liDh5xdoxElxJ3aXVLnL0n2MHj8JxGrid6mSiKTImMCSXVUTdi0MPBr9UMhmAjIOBmO3N6YPorL6abMwfeiaQ10K38d0mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/2l5Tsa3JjQUhspRa+unhlX3F0WLMUH+7jzoSY17Hs=;
 b=q1l6KnKBGPLOycPLyGMiDHMp2t9b6B9P/DT418t8yd1P12Q4uKNsoUDPeOfgarVMSE2tyb1uPPQwtVIZnbklUWd7hpgVx+YebBQBi/sy8kTniwtqFGYwE0rnNvCHwjFr3GzTVxlcW9KGGkfJQGl3sA7/iOsvLw8iUJrWVdwD1nfp6Zwx5C85GnxUHyQ9b37llQPd1wsXHTpzrj+blf2LvQZpiuPsuVMRprkRW2o7xsTk0T5j8f+gNP7IjYtvS61zORQwe8n+He6oWZb8QGO2rKVOj8EgsS4Ars1VSoSCL/SBnFb6Eza7PuLQgaPdmZhn6iOeg79OYOCiMt1iBq7RHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DS0PR12MB8813.namprd12.prod.outlook.com (2603:10b6:8:14e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.24; Thu, 6 Jun 2024 21:42:54 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 21:42:53 +0000
From: Zi Yan <ziy@nvidia.com>
To: Barry Song <21cnbao@gmail.com>
Cc: xu.xin16@zte.com.cn, david@redhat.com, v-songbaohua@oppo.com,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mhocko@kernel.org, yang.yang29@zte.com.cn, ran.xiaokai@zte.com.cn,
 Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH linux-next v2] mm: huge_memory: fix misused
 mapping_large_folio_support() for anon folios
Date: Thu, 06 Jun 2024 14:42:49 -0700
X-Mailer: MailMate (1.14r6030)
Message-ID: <360B6C7B-B700-461E-A607-691FE35A7623@nvidia.com>
In-Reply-To: <CAGsJ_4xu9jfC7UWdOqP5_saEXRE26mo6Msx_=JGCKaWac57=BQ@mail.gmail.com>
References: <20240606174203124_OW-VQZ_ZLm4lGEimA-K9@zte.com.cn>
 <51DED95F-832A-4836-AA81-556968F6B645@nvidia.com>
 <CAGsJ_4w9cRZUEF7PaVjz1HQoUr1pxHEO15gpbsnAoJHMZG0djQ@mail.gmail.com>
 <B7796F09-BAA6-4555-A9FE-F44DF1CBFA6F@nvidia.com>
 <CAGsJ_4xu9jfC7UWdOqP5_saEXRE26mo6Msx_=JGCKaWac57=BQ@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_B5159FCD-377D-42FA-9377-8FE173AFCB33_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BYAPR01CA0016.prod.exchangelabs.com (2603:10b6:a02:80::29)
 To DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DS0PR12MB8813:EE_
X-MS-Office365-Filtering-Correlation-Id: 94c9fff0-d149-456c-8af5-08dc86719eed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ci9OeXJ5T1NJVkRCTWFtcWlZbXh2ME1mSXJjUjZybEw0eUdIQ1ZoZXdUMW43?=
 =?utf-8?B?aWVPRWRMa0lNZVpObnV6dEI5bTFKV3o3VmZNT2puZFNBN0pKREN3cmYrekxv?=
 =?utf-8?B?Vk5CV0dGUGltVEU0Z3J5YmllcE0yRnVJek1US2lwV1R0MVZxL0prOXQ1Q3Z2?=
 =?utf-8?B?SFNHaVJ5VHkxVjlXMFUwNzZic1pCRVpBMUFhb1JzRndWRkJxU0pOb0srbitS?=
 =?utf-8?B?ZE9XalhoVmtGelJXd0taanBvOExJMWEreHc4VFp6Y1VhektxNFF3WjFhVkk2?=
 =?utf-8?B?WTFqT0tySVpvcEJvbmZsbjVZR0E3c0hJWmRDSFlSM1dWQ2JNWHdpenN4SHBq?=
 =?utf-8?B?bXYvYUUrazc5L0s2ckFac0lSV2xiYWdvSWZlaXRJQlhUYk5IaDROK0QweUNF?=
 =?utf-8?B?YW1FTXpscFh0N0RuZzlmajM1cFZVNXl4Z1BDNmtneEV4MTd4SG9xTGJZbkpx?=
 =?utf-8?B?dklNMVZvaHN4b1NubUZhcy9rRHpZeFhML20wV3FIRk1KeWhJK2Q0bmhhQ0Rm?=
 =?utf-8?B?YlVBQzdOYUI2SlQzSTY2c3ArM2Y2RUlBUGdYR1NWZmFid2NsY3dqcWFad3RH?=
 =?utf-8?B?WDdBRkV0RkR5Y0J2VUJUaWRtYytTWWpLM3NNSGs2TFJIUFRoYkY4UHZJbDF0?=
 =?utf-8?B?M3prRllyenpEZzVhVWYxVk1jbmo0Y1kybHQ3ZXZncHVyS1pSS2ZtY2ttMi9z?=
 =?utf-8?B?Z3VrVU5IODJxOTBvK0h5UTRwczJqSVdaTVZ5STY5Mi9iem9CZ2xqcmNRZi9y?=
 =?utf-8?B?ZWNSMEFEeUg5KzJYdUdlK0xkUWNoaGdjVzVHbElkeWxqNm90a1B1M1RvaVBI?=
 =?utf-8?B?d1F1eVNxZU9Ec05xeFBKN1BvcFkzcm5PQy9KMnNmb29sc0o5WXpVZi9uSTJr?=
 =?utf-8?B?Yk9rNXV0NWhXd3ZvSU1nNFBlNUtsM3d5dnVDTTRQOWoxVTQ5R0hiUUQzM0RN?=
 =?utf-8?B?cW90aS96OFJ0NE5BVmFHWkNWUzNCQ1gwNUJ5MFlwYVhRcWlSVCsvazJVVGNP?=
 =?utf-8?B?RnEvaEo0OUZnQUN2UllsV2ZVSWxndkVEZkkzYUk5eVFNclpJRzFodjdtMzZW?=
 =?utf-8?B?aGFJZmhFMDdWZnJQOUpXUUsxUjdRUndDeVQ0OUR0QXBieDkxbE8vb3JiS29B?=
 =?utf-8?B?NGRBZnBxRVBRL0czeGpEN050bEhaTUt0QWgzdUdTWG1tZk1Dd3p5SHJ1MTBx?=
 =?utf-8?B?OTRVYkM5TjZsSW1Kbk1kbHJhTzNZWVFST2l0OXVzei9Ha1ZrcWRjMjM3UHJW?=
 =?utf-8?B?ZjVCOXU0bGdEMlBwa3lhcE9kMWRteVBUbkFROGVPWXZkWFlRd3lZaUFzamNh?=
 =?utf-8?B?SnY2T1RnQ0x3QzVLZmRUdDNzWFh6T0Rxd200dk1jT2JZZm1UWlpiSHZXREpv?=
 =?utf-8?B?cENwOVFXWEhjdUo2d1R6RE5KbWxweS9hSWkwbjRld2w2azAyVTJwblAwM0NR?=
 =?utf-8?B?UkJ5MDNGMGh5bnRZY0xtQWgzVzJrQkRHNnYzd0ViQ1lOYkFwSGt1Y3lXeExR?=
 =?utf-8?B?RnZYUWY2d3dPRlNRRXlJbE5BSVJXMUJMdnN4Tm0vOTBoK1c0UEdpYTJSS3Bx?=
 =?utf-8?B?Y21lays5TG9HakVNV0NMUVJrQU5mRGYvbU9QcEVPUEI1Q2hnNmdXaGU2cVFa?=
 =?utf-8?B?eXFFU0d3LzZSanlqaXlXcElGaU1jNHEzVW4rdUJnZjAwcC8zeDY0VFdHL3pn?=
 =?utf-8?B?T3BRM0hyN1JQNU9zU0lXVUpteXRGb083NkxtQi93VTUzRVpscmRJU0pzdy9s?=
 =?utf-8?Q?3WY4bJhizNKoMWVpdCf+t2V8JiXHnvkYcMPOMJu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2JBQUZUSXBxUXhOdE5vcWFjMjZSN20yRTVjUERzUGl5ZUQ5UnQwVEh6RGVR?=
 =?utf-8?B?U0UrUEkwbk5ScXloRnA4YUZPV01HamVEY0Rlb0Y0RFhTUFJkVWxDVGFVUXp2?=
 =?utf-8?B?NG41bmV4K2dJVDJHVVlCcFJPWTdjOHJSRzhMT0FNYTc4TnN3TC80MldNOHpH?=
 =?utf-8?B?ZjFQRnBxMGdhWEd5TmxWaVFjbHdmTERmcHF2bVcyMi9GRi8wR0JXWnFXTXdy?=
 =?utf-8?B?N09pSDNNekNJUEMyUlFIckxNQlVQQUMxT0tJdkRyNG11WkltbitKVTkvcEhE?=
 =?utf-8?B?WGkrRFl6aEZDYjZ6YnhJcmIzalo1ekIva0t2S2Z5M0VnYmlQRHdXaUZKa2Rv?=
 =?utf-8?B?aEhLYktPU2RlTHpSOFBGRTRYTmREbHMxUkF5T3VwMHdORkx5SnM5cStIOFQ3?=
 =?utf-8?B?WW1CU21VY2dQMCt6SnlQOGpTYU9aSjJkMmFWejVYVFI2Y1VyeDNnQXdHRGI4?=
 =?utf-8?B?M2RudVAyQjFKblkrT1JUbmZHMUs3YmV6SUFPRXFtZ0lUZXRSVHc1VkdGeGx3?=
 =?utf-8?B?bXZ1djcrU2djSHZkWlBYVGpSTURVaURibmQ1UEhXQW1zT0RkQjVyUXI0WnVW?=
 =?utf-8?B?TjN3aHpONkRRSnR2OXJ3dXRINnhnSU53a2V2c2hLRFpUbzh5S1NkMDFmNFJN?=
 =?utf-8?B?SHh1TXBCQUE2bzdxUXUzRVgySE1kRHd1cmJUbVdzbGZKSHo5WnVza3d0blJx?=
 =?utf-8?B?SUpRdWR0ZVgyTjhiYkNEQUM0RU9ZUFdyWHEvV2V5SDhaMk9ScmNzUENMRzB4?=
 =?utf-8?B?Vk13TGxpMGIzYzNpYVAvcm9nYzNCMzZCb1JRRGlRaU16NTNJeHJyZ09uUHdr?=
 =?utf-8?B?WFdWaGMvcjB2RnhkY1owMnFpZkJ4aTZ4c3c2bXF2QlVzYnZKaHY3dXVMUG1Z?=
 =?utf-8?B?QUVyWWtrOEVvVHdXamd0WGJKRHlKeTR6U0tpNFJrSTdCVllFOEVmWm13RnhO?=
 =?utf-8?B?b0ZpTzBaRkVJYWNObDduOUNZeWNseFdUU0FLQ29vRURWaTExU2daSVlzTHFm?=
 =?utf-8?B?Z0Y3ZnJnbThaY2Y1Y3MxZUlhUGVXR3VNWmMyK1NucG03bzZ5bGZtellJU0tN?=
 =?utf-8?B?NjV3TVVvbUloeVFyQmNyMDNhNXlGVkI4MmRXOVZlclhnN2lXTFhDWUNyUTdN?=
 =?utf-8?B?aFpaRWtLb0ZBYVR6YTRuWjFjbml6MzU3QkZpalZPRjFtOXBnZUZZSmFpUk1M?=
 =?utf-8?B?LzIxQXBFMUd3RWpJTUdyOE81bFpubmQwZlFENVVidEFaUUhNc1kxVkQxaVdE?=
 =?utf-8?B?NmFPcUFaNW1Jc08zelowellxaGV1bll4MG9IdU1rTE43TGJIZnFWMVU3VGxs?=
 =?utf-8?B?MjByMWZGc2NMTm1hc0lvL0I0LzVBdzVEN2M4blRpV285QnhkUGFRUUx3aFVP?=
 =?utf-8?B?WmxHSGV5YlEvZkhob2xiQnRISGVOR0Z2bHcvQkFaWmdIaVVXY2IyY3VJNFRx?=
 =?utf-8?B?ZnJOZTZSSGllaEQ4MU1xZDVhK3pCazJhQ1Q1RTg1MTM2elhTRlNXMzZndUZE?=
 =?utf-8?B?MXo0RGRHM2VlTVJyOGhlcmtOajNWY1AwbmFWWWgzN0NiM24zZytoYzd5bWJn?=
 =?utf-8?B?eEIrczNjVTdEV1FDcElVVmZjQ0Q3VllVVVBJZVlBWmtGd1NSVjJ5NW1vekVr?=
 =?utf-8?B?NlFkZDZRc3dlMzMxTjloVXBSOFFxc09wYXdqNU9tUm5DamhLL3BselFIZEtv?=
 =?utf-8?B?dExwTExZZlJhd21JUWFNaHJZM2FNM2pkYkVkZkpRVjJJcmE5SFYxOU9WVGI0?=
 =?utf-8?B?TWttT2xLcDVzbVlFdk9SK1JxUHl5RjZnZ3VyZWVocnUzeUdvQjVQeUlDSml4?=
 =?utf-8?B?aHVhb1E0K2JaaEdhR3NML0FmVW9oa3F4VTJVVDh6b1plWmxZbEdyNkVwNmhi?=
 =?utf-8?B?anhBS21NNHVURWVwNG84ZkMzWS9mN3hna1F2UmtUVzZ4M2NVY1d4TEtxTHVY?=
 =?utf-8?B?U1ZFNDVQcnRrcEJva3VUQ1NuZWx6MW9qN1cxS1JZNHp5WWxkam9CcU4zUEh5?=
 =?utf-8?B?Z01lUUxHWFMxbHlHWFpvQ0MwNTFrYmozdkNaSWo2ejlMZCtvVnRHSGxuWWtM?=
 =?utf-8?B?OUJrZlNnS243Z0pxZlBDUnFPQ3lPUlNPTU9EZE5kWWdWQ3hIR0IyQ2oxck90?=
 =?utf-8?Q?nFeg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c9fff0-d149-456c-8af5-08dc86719eed
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:42:53.7090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKFxr7Wj0/sM6SViCfrXdQBcJfCKiFveJ+Mf2tDJbqdpOdCzaaxZY8U+VQRNLlrr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8813

--=_MailMate_B5159FCD-377D-42FA-9377-8FE173AFCB33_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 6 Jun 2024, at 14:33, Barry Song wrote:

> On Fri, Jun 7, 2024 at 9:24=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>>
>> On 6 Jun 2024, at 14:00, Barry Song wrote:
>>
>>> On Fri, Jun 7, 2024 at 2:35=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:=

>>>>
>>>> +Matthew
>>>>
>>>> For mapping_large_folio_support() changes.
>>>>
>>>> On 6 Jun 2024, at 2:42, xu.xin16@zte.com.cn wrote:
>>>>
>>>>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>>>>>
>>>>> When I did a large folios split test, a WARNING
>>>>> "[ 5059.122759][  T166] Cannot split file folio to non-0 order"
>>>>> was triggered. But the test cases are only for anonmous folios.
>>>>> while mapping_large_folio_support() is only reasonable for page
>>>>> cache folios.
>>>>>
>>>>> In split_huge_page_to_list_to_order(), the folio passed to
>>>>> mapping_large_folio_support() maybe anonmous folio. The
>>>>> folio_test_anon() check is missing. So the split of the anonmous TH=
P
>>>>> is failed. This is also the same for shmem_mapping(). We'd better a=
dd
>>>>> a check for both. But the shmem_mapping() in __split_huge_page() is=

>>>>> not involved, as for anonmous folios, the end parameter is set to -=
1, so
>>>>> (head[i].index >=3D end) is always false. shmem_mapping() is not ca=
lled.
>>>>>
>>>>> Also add a VM_WARN_ON_ONCE() in mapping_large_folio_support()
>>>>> for anon mapping, So we can detect the wrong use more easily.
>>>>>
>>>>> THP folios maybe exist in the pagecache even the file system doesn'=
t
>>>>> support large folio, it is because when CONFIG_TRANSPARENT_HUGEPAGE=

>>>>> is enabled, khugepaged will try to collapse read-only file-backed p=
ages
>>>>> to THP. But the mapping does not actually support multi order
>>>>> large folios properly.
>>>>>
>>>>> Using /sys/kernel/debug/split_huge_pages to verify this, with this
>>>>> patch, large anon THP is successfully split and the warning is ceas=
ed.
>>>>>
>>>>> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>>>>> ---
>>>>>  include/linux/pagemap.h |  4 ++++
>>>>>  mm/huge_memory.c        | 27 ++++++++++++++++-----------
>>>>>  2 files changed, 20 insertions(+), 11 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
>>>>> index ee633712bba0..59f1df0cde5a 100644
>>>>> --- a/include/linux/pagemap.h
>>>>> +++ b/include/linux/pagemap.h
>>>>> @@ -381,6 +381,10 @@ static inline void mapping_set_large_folios(st=
ruct address_space *mapping)
>>>>>   */
>>>>>  static inline bool mapping_large_folio_support(struct address_spac=
e *mapping)
>>>>>  {
>>>>> +     /* AS_LARGE_FOLIO_SUPPORT is only reasonable for pagecache fo=
lios */
>>>>> +     VM_WARN_ONCE((unsigned long)mapping & PAGE_MAPPING_ANON,
>>>>> +                     "Anonymous mapping always supports large foli=
o");
>>>>> +
>>>>>       return IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
>>>>>               test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
>>>>>  }
>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>> index 317de2afd371..62d57270b08e 100644
>>>>> --- a/mm/huge_memory.c
>>>>> +++ b/mm/huge_memory.c
>>>>> @@ -3009,30 +3009,35 @@ int split_huge_page_to_list_to_order(struct=
 page *page, struct list_head *list,
>>>>>       if (new_order >=3D folio_order(folio))
>>>>>               return -EINVAL;
>>>>>
>>>>> -     /* Cannot split anonymous THP to order-1 */
>>>>> -     if (new_order =3D=3D 1 && folio_test_anon(folio)) {
>>>>> -             VM_WARN_ONCE(1, "Cannot split to order-1 folio");
>>>>> -             return -EINVAL;
>>>>> -     }
>>>>> -
>>>>> -     if (new_order) {
>>>>> -             /* Only swapping a whole PMD-mapped folio is supporte=
d */
>>>>> -             if (folio_test_swapcache(folio))
>>>>> +     if (folio_test_anon(folio)) {
>>>>> +             /* Cannot split anonymous THP to order-1 */
>>>>> +             if (new_order =3D=3D 1) {
>>>>> +                     VM_WARN_ONCE(1, "Cannot split to order-1 foli=
o");
>>>>>                       return -EINVAL;
>>>>> +             }
>>>>> +     } else if (new_order) {
>>>>>               /* Split shmem folio to non-zero order not supported =
*/
>>>>>               if (shmem_mapping(folio->mapping)) {
>>>>>                       VM_WARN_ONCE(1,
>>>>>                               "Cannot split shmem folio to non-0 or=
der");
>>>>>                       return -EINVAL;
>>>>>               }
>>>>> -             /* No split if the file system does not support large=
 folio */
>>>>> -             if (!mapping_large_folio_support(folio->mapping)) {
>>>>> +             /* No split if the file system does not support large=
 folio.
>>>>> +              * Note that we might still have THPs in such mapping=
s due to
>>>>> +              * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the=
 mapping
>>>>> +              * does not actually support large folios properly.
>>>>> +              */
>>>>> +             if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>>>>> +                     !mapping_large_folio_support(folio->mapping))=
 {
>>>>
>>>> Shouldn=E2=80=99t this be
>>>>
>>>> if (!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>>>>         !mapping_large_folio_support(folio->mapping)) {
>>>>
>>>> ?
>>>>
>>>> When CONFIG_READ_ONLY_THP_FOR_FS is not set, we need to check
>>>> mapping_large_folio_support(), otherwise we do not.
>>>
>>> while CONFIG_READ_ONLY_THP_FOR_FS is not set, that is no way
>>> a large folio can be mapped to a filesystem which doesn't support
>>> large folio mapping. i think
>>
>> That is why we have the warning below to catch this undesired
>> case.
>>
>>> if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS)) is correct.
>>
>> When it is set, khugepaged can create a large pagecache folio
>> on a filesystem without large folio support and the warning
>> will be triggered once the created large pagecache folio
>> is split. That is not what we want.
>
> yes. This is exactly why we need if (IS_ENABLED(CONFIG_READ_ONLY_THP_FO=
R_FS))
> but not if (!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS)) .
>
> because if (!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS)), folio is definit=
ely
> pointing to a file system supporting large folio. otherwise, it is a bu=
g.

Oh, got it. Thanks for the explanation. :)

>>
>>>
>>> The below means a BUG which has never a chance to happen if it
>>> is true.
>>>
>>> !IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>>>         !mapping_large_folio_support(folio->mapping));
>>>
>>>>
>>>>>                       VM_WARN_ONCE(1,
>>>>>                               "Cannot split file folio to non-0 ord=
er");
>>>>>                       return -EINVAL;
>>>>>               }
>>>>>       }
>>>>>
>>>>> +     /* Only swapping a whole PMD-mapped folio is supported */
>>>>> +     if (folio_test_swapcache(folio) && new_order)
>>>>> +             return -EINVAL;
>>>>>
>>>>>       is_hzp =3D is_huge_zero_folio(folio);
>>>>>       if (is_hzp) {
>>>>> --
>>>>> 2.15.2
>>>>
>>>>
>>>> Best Regards,
>>>> Yan, Zi
>>>
>>> Thanks
>>> Barry
>>
>>
>> Best Regards,
>> Yan, Zi


Best Regards,
Yan, Zi

--=_MailMate_B5159FCD-377D-42FA-9377-8FE173AFCB33_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmZiLVkPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKVp8QAKs/vlj//wZhlJvxTltbn0ONsD0rSanX1Lof
Q3TVjG9exlSdjXG6dcN2HO+xcaRkRoPp4Q9PE7HLbCBFZ7CMGmqFhM0UyTDBweQd
0C6BCNDpsydBqe0QXf2NrtiYDl4zdOfC9yloecW3Wr4bq7Ayiy40OyNICEnWE77a
Rl8hzs3CbTveI7+0n8ln32oSjVtKorGW9YQnH5YHvLH8w/KmxmCkKpXy2DoW8532
rGp2zpCK0hPpjmjYKy3C2sFegBnYxDq0iUJMj46P4StU2nRUxLuegJYceAlwCNd6
U/byZ3lxSG3DOsOw2tKOlL6gBPGhNg9RO92giHu+8hmDTUGD+leUT2jzGcGJnT6G
DjcgOSBKxpmiIjRSttfnLsPwpsgnPSnuvNTkvjV8u/RjJkRA96e8aa50sKvgBJbs
U2IjW3aNw2Au33ZiftWKLa+jUSKHM1g+3liRPjj7ENi5QyyBNfNmZUqICJpXWHyB
SELgHqMLM71+6rgXfLAH/OinyLAPL56ci6xnZ4fO/ZUFLw0Y7KgIS6CHkwxZv4LC
Zlnra/MuiPDTMUlHtUkBP9oBoO/O0sxdUqkNXKhd23gHDmjF89rf1/tIVFCT3GGF
4B/+BywL3cU3xJ+e3rV825exshELpRq/HQuaNp/P7i7DaNw6Z7WVEQnaJWJdz+M2
ybsYnu33
=7gjo
-----END PGP SIGNATURE-----

--=_MailMate_B5159FCD-377D-42FA-9377-8FE173AFCB33_=--

