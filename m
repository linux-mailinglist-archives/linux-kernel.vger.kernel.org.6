Return-Path: <linux-kernel+bounces-204473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E678FEF8B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA0C28A44C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAFA19AA64;
	Thu,  6 Jun 2024 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aiIsYtW7"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B51A195802
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684121; cv=fail; b=CsChF984xCupG2ZnWJPQ/Syo+MSc0xkiPVDEzn08gLbg+fCHjqBtbHFSIF8TG7mjnln3QbMvF4Qk4ar/4/4kM/0mqUwwjYAGIggAvk//i5avb1VoArsVpMT+V2ELeyiByU44yCRTGjZs4msYRPxua6EyZtUDPSIEtQ9iBMAZRck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684121; c=relaxed/simple;
	bh=HEDEkOOyalcgsGSssrS/HFf0dsglpgQBIpzC3J1/DSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MDjw4tKMFgqgs5q8W4SnrOcg2N6BOG6AEhtAxA4dv+tky5w6rTKgcObjhYbyMHwRvyEVJvgGblU61S5/tynZYeEn4iegNAPYQ6e4S0bTnH8Y7+uPzPvJk5mhXo6oIEGvZV+qBkkVn7pivzeskhMTostjM+yVcFyI4wNr87pb0Z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aiIsYtW7; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzXc7Ps7Df9m1oSa6ZkhcWZfFBs9Ghm5jsaIfmM+q6SJUZxykfjUf1MIL09DR+eRPbhvj5hM6qQH855pDwnhxKVpfVQ+RoIwlD4uMvLu8i+nlwx0eBixmgL0ctuxNM13mUEqPW9o7KD18xX8V351XcKqmdhhVSk9oYrvYKLqX+77AuGsGP7B/0wnUDXjWLV/DCofQzM5SgwdmATicjnN/mKaxexROJ3vonqiTe4e/kBl3PZ9ivFV5B/HBvZNJv1VDFUJCAF5gvNdBhcRv232y1XY6AsPibw16VsEdIPJHAMQXkKz0In4creU57ORSau20RvnZLJWQhyful0IE5vhLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GW+2ZsFW8vPmAnB7MdjxCQYIJEax75w9noyQkznIrME=;
 b=g2CckaZrqAoo/wznssObD0m2P2mV607mabAmOp3BnkAvo1qrjhgvW9OuTnbJt1N0syRjD4zBa2MWbkRmZJ5uk2VPPvAi1vFn3PF6LKmVhHa95MmXXK6Z5oEVnCWnf36gXWxjcUde1W417TnIbCF+ki8AjBczfwax24R9BtcCRn7P/4C7DXkcAt4wqlL8DXrr0PhpLapw9yW6rKvIlwok2/TrQm9XqEpC9O+9rOi4+ZVLLSUja0TgvUMJJR6pSqHyN4X9aSv8gp7Pv9MQ06UDxJag+4kDbvOG9XQzFND6UkEyqDjP2JqNeGrW54AltLB6C0SSwKa9VYU3i+T2CsAIWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GW+2ZsFW8vPmAnB7MdjxCQYIJEax75w9noyQkznIrME=;
 b=aiIsYtW7prB5fgLLOP0F0hh/0pnogNG6acfJEDVLNLw7MF26ZpoFxBqsQV7Ox5hLVWVl0pAtAtVLsumh+jDr/UpGs5qvH0FYtan3TgNfPFfYOXy7A2VwLuSUmGieFkcQf06Dg6ghkVL3Wz8WbsG3doSMxgdIuJimGaNR0aCkL5CvjzPqUmdrrjabCLKXA71Gugi1q1oYzm6Iq0FVaH3S+D6xrv759R77nOcwKbzQ8t5rQHJG8eLFLWBY2pvMJBYep1MOeH3Kh3QWSjRcYjs9TiKbnAZ4mI/LJDFTpd1NcVxNvpUVD4En1qPMBu7tmHsSucayEOzblohJZbPXJMXvGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 14:28:36 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 14:28:36 +0000
From: Zi Yan <ziy@nvidia.com>
To: xu.xin16@zte.com.cn
Cc: david@redhat.com, v-songbaohua@oppo.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org,
 yang.yang29@zte.com.cn, ran.xiaokai@zte.com.cn,
 Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH linux-next v2] mm: huge_memory: fix misused
 =?utf-8?q?mapping=5Flarge=5Ffolio=5Fsupport=28=29=C2=A0for?= anon folios
Date: Thu, 06 Jun 2024 07:28:31 -0700
X-Mailer: MailMate (1.14r6030)
Message-ID: <51DED95F-832A-4836-AA81-556968F6B645@nvidia.com>
In-Reply-To: <20240606174203124_OW-VQZ_ZLm4lGEimA-K9@zte.com.cn>
References: <20240606174203124_OW-VQZ_ZLm4lGEimA-K9@zte.com.cn>
Content-Type: multipart/signed;
 boundary="=_MailMate_01928395-E6FC-4913-90CA-7618991F85B8_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: SJ0PR13CA0183.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::8) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MN2PR12MB4469:EE_
X-MS-Office365-Filtering-Correlation-Id: e3aec396-40c6-4250-e375-08dc8634f3a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVA0K0JBQzZ5V3cxZzZqQ0RnbU9ISTNzbmw1ZThmaDNWOUJzTjV2eEZodDlV?=
 =?utf-8?B?ZWhKRnYybHUvK3ZGd2dFeElkRytCVjhtVEplWUtpRlc1aUJkWk5jMUgyZk1X?=
 =?utf-8?B?K0NsMU05Y0R2NW8rN3hEK0V4M0lpR3lJdGpPbStJcnNGK1lIYjNrdkZpcTFL?=
 =?utf-8?B?UCtKaUtoaWEwczl5bUJVQmNueml4QzhHQlRMR1Q0NUJVZHZEV1hzNDd1amRu?=
 =?utf-8?B?T0l0QVYwejhwQ3ViOXVndW9BaEFoV09zanBOdkZJYnBUeTBSSkNjQllSUjhU?=
 =?utf-8?B?a1RmY05saE00MEVLdlFxUTF3WGJpTEN3aXY2Rkg2aTVWZURTRVVXVmxwU3Bv?=
 =?utf-8?B?bXczUkt0RnllN2ZaTE5hcFBpb1VURGwvcFN1ekZJcHFOSm13ZnJCSGtXeWkz?=
 =?utf-8?B?SVJiZ3hsSURjQlNpVFF3VGNWUFpIcHpkS1hVUWNqNWcveVVmdE5jdHdmZUl3?=
 =?utf-8?B?aEtiVmtCc2ZJS25od2MyODl3dGlUTlNvM2dEWi9WNlc3RytlRHhKTExiMTBB?=
 =?utf-8?B?TERUQzNaREJaUEFYNDdia1B0bUwvRVBmRWNsWlMydmxCUzR3NXJqYlMrMEZh?=
 =?utf-8?B?S2tMd2lFcDFLS0lYMWVzVXZQNFluSWR6ZU0ybllHMzdiWXo3VnNydnBBMGJZ?=
 =?utf-8?B?WnJXUFMrOFVrT3FURzhFU0FSbXk3bmN5aWRSQnl1WGhuRlB2SDlZaTN5YjdC?=
 =?utf-8?B?V1loMUorZHZ0aEZjSlFDZ0NlODFaY2I1MVdPZ2RrTnY3TG9kWmhacDl0SHli?=
 =?utf-8?B?ZnNXQnE5VURsaWdxYkltZDUzcWZSb3NwNlk3SHRoQnZhQUpWWEIwMm4ydTRQ?=
 =?utf-8?B?d0tDNUViaGxxT0pkR2FKMVlWb05tM3Z6empsLzhoaEdQM3lGTUNMOStFREZJ?=
 =?utf-8?B?ck1vaVk5d3RyUjk5eVRRNEJJWithbmxRVG9YOGpUL1krcTZPL1N0bTdpS2Na?=
 =?utf-8?B?SkljelhjQzhLZjkzS0swQ0VhMms3V2p4VmFEclZhOXZRL0ZPOFJOSDZyRi83?=
 =?utf-8?B?NEdjdHJwQlhzK1A0dVFOOVY4b3M3ZW9Rb1djaHZkcUtjWS9UMGFrSWlGYm5h?=
 =?utf-8?B?dElUdEJ5YjVrakh5OWYrOGJ0MUd2aEw4cGVyZU5wM3hObWhPdHh1KzVESm1B?=
 =?utf-8?B?RlA1VEhrMGhIanJMRVlYZ3ZnVWVvMDZNRURqTVloK3BnbVFtYjRlU2FncThQ?=
 =?utf-8?B?Mkx1N0dQRmUzcytqcjZkbHdaMWxVL1lzWnJFVktXSS9QcWhvNEF2dnc2NVlv?=
 =?utf-8?B?VVhhNDhHVkdwczdJK3d5TXhLZHZIOExKLzRKc1lxdnprYjIxNmFvaFh2WTVm?=
 =?utf-8?B?bzgyMkVCYU9VMGZPaUtlV3BtcTczQjVkVkozN1p2S09waVBVNmFwdDF2WkpX?=
 =?utf-8?B?Zjd2cVJHMSsyWjhvSE9NYXZ6UkZsL21VS1VWa0pUd2VvR01KRktnd2tMVUVH?=
 =?utf-8?B?RGNDTjRUa0k5K01mejA0VVFLZ1daTWl6elZ5R1FkdmRjSjZRb1FFL2Z5Yk1z?=
 =?utf-8?B?UTFBblJxemd6T0tTOWVpemNrTzNKaVZUa2hkVytXY0hRaHRDakM5WW11MlJQ?=
 =?utf-8?B?L01OYU4rQXNvN1Y0VE11ZlNOemxCV2U5bU1WZEtTbUpRTzZnZDYxMVMzclhw?=
 =?utf-8?B?QTNBNjcrYUt3d1dQWDhwd1gzMXM3VWxUem9vSFA5OHl5dWNJVW1xTGtFNDQv?=
 =?utf-8?B?SlcyVCtkelUxKzFIQ215QmlZUytVdkI4U3BsZ2hGR2RxeFdHRmluK3V2M2Fq?=
 =?utf-8?Q?gEdHh7GCaBpWeQYywEgr1olJ65z3umSmWoKDb2E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S015elp6OXdtT3YwOENMUW5Ea0pBQ2xrV0o1bFVIRENTVlNrQlJHTk8zYXEw?=
 =?utf-8?B?WHl4YXJVb1pSMjNHZ21Vd1FRQS83UzQ4SythaVNTdnhwVFJLZ2w5eHdzb21B?=
 =?utf-8?B?c091Q05wY0didEwydExDdFhtdGVhbVdnR21majlwYUltVDdWNGt4N3cyOVJ0?=
 =?utf-8?B?eGJrWjZjaDdyYzdld2d2R3hsUzVOYTVqUGRnSE1iN0NBTC9objh0UmFySmw0?=
 =?utf-8?B?NnRSdXBrTVg2NTNkSzNKeUtuYWd3S0pnL1FkMk1tMlovdVVPK09QY0o5TzRV?=
 =?utf-8?B?RVdQWWVnb3dodmYxN1ZpOWJkYmxDK05oUDVOeEtrNWNJYm5LQk1weU5zNVFB?=
 =?utf-8?B?QzRrSEw0V3g2bHZ1MkpVb3EwTm5RQUtodFVieDFBdmdhd1FuU2VFTGtIaTQy?=
 =?utf-8?B?ck5IWXJvOXdLQnBrUXVQSFRsZ0NLMGhZdjhuSHNtbkY0Uk9KSWs4YVdpZTNZ?=
 =?utf-8?B?bEZzNHlpQlVodUdXVnVmRE5XWmtud2RzZFZNUGZQUWtjZ3JIMXcva21wNlhZ?=
 =?utf-8?B?aXpYUGZFdXJXUDlmeW1LWlMxNGRXQ1h0UjdkcEdjQ1p2S1BCMksxQW93UWFO?=
 =?utf-8?B?UWNTTlJ4a0pzTVhyTUU1YVdOYTNDTXFBdTF4dVk3ODhoTWJMM1Nob1VnWW5q?=
 =?utf-8?B?cGhWOWRGS3pyMUs4MWN2U2w0VXo3QjJBRU81MUFIMDJvNm1ZZHloaGZXc1N0?=
 =?utf-8?B?bU11VWNBNlplcm9IbHBQQUw5SG5lU04vTHZwR3ZncFl5eDZPS3k5VmJqa2Uv?=
 =?utf-8?B?d1RDRkxHeENrbHQ0czhDWVZUeUlGZ0wrY2hUYVlnaTloT2srOGZqbUkzb3Bm?=
 =?utf-8?B?dTFVaExxbXhGTnhpcExLRGpxbjhwaDV6WmxCUkdqV09NRGVMMkNXblpnMlRq?=
 =?utf-8?B?ZnFZSEdSa29oTkt2MUtvcm90OUR2WmNzRVNZQmhnTUlKazVPMnRoU3B3dElq?=
 =?utf-8?B?SGJWTU1ZVVlObC9pODkvQktUdGl4VC9ROHFhbXo4VUpPZ0tEQmlkM3IxQTlG?=
 =?utf-8?B?cDI3WS9DdVVSbm9ablVJQ1ZwQmRpUEswekduRUVhUFZIdWY2ZFpGZ3lhZmpk?=
 =?utf-8?B?ek1uR3B2R3dZdmlxME4wbXF6SEE5cEt1UzB3NnhNQXU2UTNnVmM2RWUrNG1w?=
 =?utf-8?B?bUdmK3RRY0NoWU56LzAwNWNuZlFpamN4bEJ6SndBN252ekdqSjlmaldIeGdq?=
 =?utf-8?B?VWtVSkRtN0tKQk1qUUt6dzdtRTFFVGxickY3cEh6NGFRdnNyeDlHN0hudTFk?=
 =?utf-8?B?SVFNWlRkTEVqc3NnaldzTGZWSUZmNTVCc01RQXN2WmRUekkyVlNVUE0veUdq?=
 =?utf-8?B?b1B0Nnd0UXZiMWdZTXFva2JvNmV1b21YZ1gwZ1ZCV0xERmNNQWJBTDd4MkJM?=
 =?utf-8?B?OTZhZUg4M0U3bTJaRXJIam84RzVSSWgvU3FJZGV0NkNJS2hNSThLVEZtU01T?=
 =?utf-8?B?Z3BCOFdBK21iQXd5d3dtYTM4alZWbHM2dldxdDFPcWwxbTVRWnVodjcxaGIw?=
 =?utf-8?B?cGVZWDhVS09raFNMb1cxTDFwbk9SUUhwUWo2aXVYZGZ6WDdTVkNYVExvcUtS?=
 =?utf-8?B?cS9GaURheXBDWS9jOE41WDJ6dFZkR2NpZVZUeWh4ZVEvY3ptblVZSjY1Vy92?=
 =?utf-8?B?OHlzTVV5ZFpZYkU3N2o2cEpkd1ZGUmJsbm9qVngxSlVLdlVoNkF0SmdZajhB?=
 =?utf-8?B?WldlS1pYTXdJQ3NzUG0xUEZUUTJKajlaZ2ZTZy9qQW0xdU5VYUVaQWs3RUR4?=
 =?utf-8?B?MmU5Sys4UEd6aE9nU21na2orVkJ6ZHgvNXBDQUF3S0xMNEk1b2ZsazRpU2E0?=
 =?utf-8?B?aitvaGNTT3l6WjNPUCtMdUQ3aWhrL2U2S1AxRDM2UGNBNkIyaWRoZ042KzFl?=
 =?utf-8?B?RWJZRGZEY0NmSWVBUFhYRVplOUlzbGNrcy9JeXRVcEtZbEFaUFY5Z1p3ZW13?=
 =?utf-8?B?dUtEL3pib25VY3BHeVByb3kvL3BycTFZdXpTZ1VFNCtveFhOVFBGZW5ONGpR?=
 =?utf-8?B?TmxNTURaeWlvMzVROHZYZkt6NHFIUWFFc3hPa0hEc3M3QXU4d3B3REFmdE9w?=
 =?utf-8?B?OUpqaDl2bTlEV0ZabE00U0NJNyt2R0YzYk14OEN4ZmRlZ0N6eFhmcFFNOC9X?=
 =?utf-8?Q?FP1o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3aec396-40c6-4250-e375-08dc8634f3a7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 14:28:36.5617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vACHrMDFmpc0tXPiukr+ZiNhKfkET60qCdfEv7oZiQXA1gT6PbkjLf+WHGrY9D+C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469

--=_MailMate_01928395-E6FC-4913-90CA-7618991F85B8_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

+Matthew

For mapping_large_folio_support() changes.

On 6 Jun 2024, at 2:42, xu.xin16@zte.com.cn wrote:

> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>
> When I did a large folios split test, a WARNING
> "[ 5059.122759][  T166] Cannot split file folio to non-0 order"
> was triggered. But the test cases are only for anonmous folios.
> while mapping_large_folio_support() is only reasonable for page
> cache folios.
>
> In split_huge_page_to_list_to_order(), the folio passed to
> mapping_large_folio_support() maybe anonmous folio. The
> folio_test_anon() check is missing. So the split of the anonmous THP
> is failed. This is also the same for shmem_mapping(). We'd better add
> a check for both. But the shmem_mapping() in __split_huge_page() is
> not involved, as for anonmous folios, the end parameter is set to -1, s=
o
> (head[i].index >=3D end) is always false. shmem_mapping() is not called=
=2E
>
> Also add a VM_WARN_ON_ONCE() in mapping_large_folio_support()
> for anon mapping, So we can detect the wrong use more easily.
>
> THP folios maybe exist in the pagecache even the file system doesn't
> support large folio, it is because when CONFIG_TRANSPARENT_HUGEPAGE
> is enabled, khugepaged will try to collapse read-only file-backed pages=

> to THP. But the mapping does not actually support multi order
> large folios properly.
>
> Using /sys/kernel/debug/split_huge_pages to verify this, with this
> patch, large anon THP is successfully split and the warning is ceased.
>
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> ---
>  include/linux/pagemap.h |  4 ++++
>  mm/huge_memory.c        | 27 ++++++++++++++++-----------
>  2 files changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index ee633712bba0..59f1df0cde5a 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -381,6 +381,10 @@ static inline void mapping_set_large_folios(struct=
 address_space *mapping)
>   */
>  static inline bool mapping_large_folio_support(struct address_space *m=
apping)
>  {
> +	/* AS_LARGE_FOLIO_SUPPORT is only reasonable for pagecache folios */
> +	VM_WARN_ONCE((unsigned long)mapping & PAGE_MAPPING_ANON,
> +			"Anonymous mapping always supports large folio");
> +
>  	return IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
>  		test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
>  }
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 317de2afd371..62d57270b08e 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3009,30 +3009,35 @@ int split_huge_page_to_list_to_order(struct pag=
e *page, struct list_head *list,
>  	if (new_order >=3D folio_order(folio))
>  		return -EINVAL;
>
> -	/* Cannot split anonymous THP to order-1 */
> -	if (new_order =3D=3D 1 && folio_test_anon(folio)) {
> -		VM_WARN_ONCE(1, "Cannot split to order-1 folio");
> -		return -EINVAL;
> -	}
> -
> -	if (new_order) {
> -		/* Only swapping a whole PMD-mapped folio is supported */
> -		if (folio_test_swapcache(folio))
> +	if (folio_test_anon(folio)) {
> +		/* Cannot split anonymous THP to order-1 */
> +		if (new_order =3D=3D 1) {
> +			VM_WARN_ONCE(1, "Cannot split to order-1 folio");
>  			return -EINVAL;
> +		}
> +	} else if (new_order) {
>  		/* Split shmem folio to non-zero order not supported */
>  		if (shmem_mapping(folio->mapping)) {
>  			VM_WARN_ONCE(1,
>  				"Cannot split shmem folio to non-0 order");
>  			return -EINVAL;
>  		}
> -		/* No split if the file system does not support large folio */
> -		if (!mapping_large_folio_support(folio->mapping)) {
> +		/* No split if the file system does not support large folio.
> +		 * Note that we might still have THPs in such mappings due to
> +		 * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the mapping
> +		 * does not actually support large folios properly.
> +		 */
> +		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
> +			!mapping_large_folio_support(folio->mapping)) {

Shouldn=E2=80=99t this be

if (!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
	!mapping_large_folio_support(folio->mapping)) {

?

When CONFIG_READ_ONLY_THP_FOR_FS is not set, we need to check
mapping_large_folio_support(), otherwise we do not.

>  			VM_WARN_ONCE(1,
>  				"Cannot split file folio to non-0 order");
>  			return -EINVAL;
>  		}
>  	}
>
> +	/* Only swapping a whole PMD-mapped folio is supported */
> +	if (folio_test_swapcache(folio) && new_order)
> +		return -EINVAL;
>
>  	is_hzp =3D is_huge_zero_folio(folio);
>  	if (is_hzp) {
> -- =

> 2.15.2


Best Regards,
Yan, Zi

--=_MailMate_01928395-E6FC-4913-90CA-7618991F85B8_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmZhx48PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKyJkP/ifVHxcOgwpM68Tdu9NdFppyJOXUxnfptvaU
mVDUfOGtnumYdazGt6E9d3rccO/smsLzmCHTvcwh5vUlR5UbM5idIbpf9EgzJK9r
iFW6MZXEMHJE+hYQWZdat024to5o+XuqwYbHqWEjvqB7CrYGA8pGhL9+T/2gzK54
o0a6QidYK+jm910SvpFAPV2HLsxOQaHoS28I4X0oZb4HpNRonvE+VQdshv4w9r4S
EOrQx4USsUSR1vao8D4/wmxPciJjkUPYNw0X/aTqALBSGXUEN23rIv3Z1vpPjtXf
MJrYxBS1vaBoatf734gkvjIkzDBOfKIEMK5MLrGWv0nQwEx/uSAWzf9X7NdITR1y
dSN0yStqzYNczS5vZWpBsyyeZyP82km0ZLDns8C/mQhTBtlx/a55DSVAXoC0Jy1p
h/TzcxjzzyzP5mZTn32zXjaVC11M3IcuYfj/BFayAK8NROEOeFaPBJtG5TIfcy96
GCAM5f3B6o5n2PxWK9kXTH9pZB9qyYjWx3i0ewfqlPATLxaFkR4WWTQkGYKMl03O
PZnCvyuSf2FWFCyuPhlpvdiwYTfNdaJD4k6acVuqEnY83PN/C6J/sBPFN0+rT6x+
uVz8R+wxm3eRGI/TGcuu6UsAs5qRnDR0CrxVdkj3K1dfYqoKQ9Xf6KIvB97ovihU
BSaZgwzz
=XUlL
-----END PGP SIGNATURE-----

--=_MailMate_01928395-E6FC-4913-90CA-7618991F85B8_=--

