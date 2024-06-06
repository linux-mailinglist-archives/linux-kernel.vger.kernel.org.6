Return-Path: <linux-kernel+bounces-205073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315068FF6D0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 737E9B252CC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6A819EED1;
	Thu,  6 Jun 2024 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dVdP5VuN"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7847419B599
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 21:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709054; cv=fail; b=cE/y342jZLG5EOwHsI7QM/aX7nsgJ6Edk0ZJ8WJIzbjXY9HVLvmV6b8hAhVOirzCfLoEwibTfpmsFoKYFY6xtFXA0hlwwPzu6RxEdgAwSydzQxz7z9A2jKi8h83NS5WqfI82gmEsV+KCDgkDhVgsZ9WQZejsd4KaJXv0bq93ZLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709054; c=relaxed/simple;
	bh=1A4E2DHWAa8GxO1GjQAl+jmYM6Ux0YPY6cXZgHKVC1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qdCcwUg4Nn4bC/qH5nmG7BqZR6eZnEHUPRqiIRcwCGA7mPa00y3cDGiwHr6g9O8kUBrfl4/4cipEqsQN8tjHQBukiTNaDehbo85jpyEWeXEOwC69H5w8cMq/PkWNRhqfhc2NHXG6uZryKecGmIE/WqbVpr+JlQxbOZsYguLGCAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dVdP5VuN; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbQnhnhkEoMwKE8pkTHY6INhSOGRUfjJauFX77520BOewlxSF/t9r2meyL3qnJK9VU8nxVwk7QVke6tqBVFRP0lvYrLwz90H+77V5rcPYFLsH/sFbAhDmQc7Xk+f6FziyugdHmncDbHV3l6TAVCB+cfBrqURQKJVDVV6tTP4+OYGp4lMprOdCKLYiZ5hCjWX2S7q0Fmupq4Cbd2pcy//kHi7dOiPVVLzayK5CUFv7xtbvRNnGLjTA53YwXyIhzleeJKJpCQAn1ZMJXfYvABpTxs68OLksqoeTdt8sOTO5vn+A3gunyfg5G/6pk6ds0J3cQYy1TVuBciMHeEcDGzoGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNoBCc5DGfVIbRcvoZhQe8byZNi1NJRbfd/l1Gyu/x4=;
 b=bNPlas2ahB2pMiH2rh/0wZ7Z92jd6MoVMT77eKIheIlyX0zZ3ZMfsCP44s5UVHfZNhp+rzl0xtbnuWp+wyqDLfyA/pEgCUH3Vbl9NaWcqln5Pmg8S3D+NVLMc+86aL2/KP94qXKMopoQur1SnOvI59MHAEvX899h9m5kCGX4WxC2Ip04AGnO+oWMEdVdYGVW6/PKjkpDk+eYRwpHyHWPFf9yBerrV8WPOy6BWVZ51oc7k5TerQSofKWpMMHt1D9XM5KaYK/M2PRzuAhCd+w0dAJjFmeboMIovYmRek6BA7FLRvsr4UNz1TDgheGfFp8nnAtitPb9cFNYSYxmxVoj9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNoBCc5DGfVIbRcvoZhQe8byZNi1NJRbfd/l1Gyu/x4=;
 b=dVdP5VuNumnYvheT55dEsP+9VTDvU2WfyJIjTF718btKuVLYbYSsayxrVFG14YkaAO9Lk1B78iRejsr5ik/v4y7HElJdbtG+liBhEh66SrzmrczSIOj6sa/THWRo3/0FjpjD1UtXPaKI+c6PjdB57aFGW0w5/7zECzmZymyVS5zqCoSv5xHXAjNs1jg9mKenMKUbiMybwpzXYvbLBeY5e1EcqK2uMKzn5w9U75oGc3LzIhpAIhfDJ+VMVASvKgN80XxaNwWZYtE2kdVt+LZZWcK4h2/uKS8cb4KrXYYfB9EtHHJdYfwdrm3kjsbwJnLH0zHWJii9M/20gNuyS4HCvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.22; Thu, 6 Jun 2024 21:24:09 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 21:24:09 +0000
From: Zi Yan <ziy@nvidia.com>
To: Barry Song <21cnbao@gmail.com>
Cc: xu.xin16@zte.com.cn, david@redhat.com, v-songbaohua@oppo.com,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mhocko@kernel.org, yang.yang29@zte.com.cn, ran.xiaokai@zte.com.cn,
 Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH linux-next v2] mm: huge_memory: fix misused
 mapping_large_folio_support() for anon folios
Date: Thu, 06 Jun 2024 14:24:04 -0700
X-Mailer: MailMate (1.14r6030)
Message-ID: <B7796F09-BAA6-4555-A9FE-F44DF1CBFA6F@nvidia.com>
In-Reply-To: <CAGsJ_4w9cRZUEF7PaVjz1HQoUr1pxHEO15gpbsnAoJHMZG0djQ@mail.gmail.com>
References: <20240606174203124_OW-VQZ_ZLm4lGEimA-K9@zte.com.cn>
 <51DED95F-832A-4836-AA81-556968F6B645@nvidia.com>
 <CAGsJ_4w9cRZUEF7PaVjz1HQoUr1pxHEO15gpbsnAoJHMZG0djQ@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_4994FFA7-ECB1-43E7-8EBB-49D68C234227_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: SJ0PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::20) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DS7PR12MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: f2b179dd-470c-4657-efb5-08dc866f0097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REh4M3lyTmJSNjdLVHk5SHNNUVc4amtGbUl3UUJISGl2S1pOYVdDVy9CL0h6?=
 =?utf-8?B?ejJuUS9KZk1qQWhpWXpEbkZ6OUZkSURoRlNtVFJsMWJnWTcvVVJhY3o0emty?=
 =?utf-8?B?bjZmb0svZGQwYTViV0V5eWxxVU9BcUcyc3hJOXluVXM5cCtYazliRFNaQ2du?=
 =?utf-8?B?NDlXMEFaNmFMWXBzUTZESDFhUng3ZjVuRnp3eDhsaitkYTFPK3ZBd2RpY3cw?=
 =?utf-8?B?MXkvck9STmpCYVZUQ2g1VFFneW8xQ3hZSUV2MjA1OFFVTWd1UTlQb0JCeTN4?=
 =?utf-8?B?RzlXZUZpS3BwZXoybE5lKzFxUGxZbkxZSDV6QXVhOUZKc2dzWHBUNHJaS0dO?=
 =?utf-8?B?TkNmeWFZRk5wN3pxbnVyZi9MSVZrWVViV1V0UW9OOVpqRmRjeDBoSGYvaTBU?=
 =?utf-8?B?UlpITzgySmNBZjlWejRjNnlHd3E1a1o0Z2VWaUU3Q1hiRFM5NU9sdkFyTngv?=
 =?utf-8?B?cWs1eTkrSVlXa3crSk5hYVQrb1F3UG4wempBU3RQR3V6RE9TWENYMGpVN1Y4?=
 =?utf-8?B?ZDhWeFlLZTQyWWxXYlErZjQ1WW5MNkhOc2hzYlpJNzRGY2VVNmxJYkdJWGta?=
 =?utf-8?B?NUtnVjdDbUszRFB6UG9PcG1WRVg2cG83NWZ4UkxJTkJYZGxtU2dBV2pTa3hn?=
 =?utf-8?B?V1ozaDBNRk1LbkIzRXlCdmhHR3NKRGE5bGFiNmFwYlQ4S1B2U0l0cVN6ekM0?=
 =?utf-8?B?UXVaNTBzanZPdzQ3QTZXUTB4YVVpWU9TRTdkVlUwam5HcVltVUxsZlB0Skxt?=
 =?utf-8?B?QVRCMkk2YnJRdFl4OFg1SHQ4djRzaklEN25RZjhLVEhNbEF4Qm5VUmxiRUEw?=
 =?utf-8?B?NE9QSjZTSU1hcGpuMDNBaXd4ekRVVXBDNWxYSjVmSTZXV01GWUxHMnNVZTFm?=
 =?utf-8?B?bitnemxLeWxPaTRWTHlrZmdpTkhXQnozOFNYQ2F3NVBBamduTDBKWlFDTFVL?=
 =?utf-8?B?RVE5Y0ZWTFVoR1lSKy96MGl4MVV4d0ZpSmZlYWt5U28vSGs2N0xLL2FmU0sr?=
 =?utf-8?B?RnpTa285ekc0aTIrbWpMak5rWTNLT3hsQnFhN3hNNVBxTkRkUzJkeldtbXAv?=
 =?utf-8?B?ZHVVcVhIYzBWazRBRUJsVG1JcktHbGpkRjF5R3FMUGswTVVLamExdTAvcGYw?=
 =?utf-8?B?bXlTZ0NZTTVDWENuSmNlQ1hQUURra3lxNFIzZFY4T3MwRTJRSDlXTVhVN3Vw?=
 =?utf-8?B?UkV2V0VxbktkSjUxV0JxWDE0ckdXRGFqU2kyUTFwNXRIcWV3eWlML0tRdjgz?=
 =?utf-8?B?Mm5ETDVnNHhsa2MrVXdiTWUrcHJ4VE5JUEswUmxsZlNpZk84MmNCL2x2SmNQ?=
 =?utf-8?B?a294RjhTSGtMdUJhNzhQN21rVVM3QW1jaWVrUGMvNm9HSm5DVG1ITDZYMGln?=
 =?utf-8?B?ZTlUTExLVkpsNXpMWGpYNDVTVktMMG9HK25iVnZNeHFiWTE0NTBaclprOElJ?=
 =?utf-8?B?QTNEd3hBcDlaTFZhck9Ua1RnK2hZMU5YaDd6c1N5KytjYXlUZ0g4VXRtWkIr?=
 =?utf-8?B?OE9kWURwaE10Skc2SUtJaGc1TG42bmtORTJmclZYa0FKb2JYci81QXhWRDFF?=
 =?utf-8?B?dFdxNDBnSlNSb1NFcWs4RUtMMVcxU3JtNHBubUEyaEF2ZG16V25qV1RpZG9Q?=
 =?utf-8?B?OG8wUnk4YzVCWnZhaHhwT1I0UStsVnZ4VGR4aU9JOGZJVDZpZFp2ZG95Nzhm?=
 =?utf-8?B?dmtCNlA2NnE0YnBxaGUzTEtLeXk4WlNNb1ZJYXZuNGYvSDNNUUhrbXhDV2ow?=
 =?utf-8?Q?IT9mk7FuvmhlE7h0McZdyqPfEakWjgw3IIbRgxA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWpSTDZISmtwUzJHOXdwR0JYODRIRGdHWlpYY05rOFdCeHEvQ1JUYkp1bDRy?=
 =?utf-8?B?MER6WnliTGZWR2NXdThRdWJ4NnVOM3lZQmgraXhqaERGUitVTGlucE1qbHcr?=
 =?utf-8?B?c0o5eWl3RHh6UlNEYTJNdmJqTTlxRnRyVkVYNEFDZ2JCUGYwS1pLaldKcHl4?=
 =?utf-8?B?UFJuQ0RmVFJtR2UrZDh3RzU3bXBWWUZFZ0d6WGRidTU5aEJBV3hacDRTeGNl?=
 =?utf-8?B?OEN6TWN1Yk0rVFNiUXdGUlBkR3pHM0w0NGhFNzdoSlJWczdCYjZNQlFHZlR0?=
 =?utf-8?B?ZzIrKzlQYUNHaFJQZkRJZ3BLZm1tQ3hHUlF0NlcrMkxIK0sxcllRcGZRTzdl?=
 =?utf-8?B?Qk8wWEJMelBQTHVtQlRtbjZVTXRqdkl0RWowcFlRUHgzbzlxQWQzMTQ2Zktu?=
 =?utf-8?B?YktVMWlsMHVyUjM0bHRJTDJqLzBxODE3VjNJZStlNzFNMEVSK0hnQW5sdUE0?=
 =?utf-8?B?ZHNhYXdRdDFSb1lUeVliNWNESUFBTjJBY1Q2bGY5N1VsS0E4N1FnRFNvcDIz?=
 =?utf-8?B?azBYaGF6UTlaVG9HZHp0ZnBZZDc5dFNVeGFLZFA0Qm1zVm5CVlQyOG9zeUJ6?=
 =?utf-8?B?UG1lRWdNNzRXT0plUEk2UDg4eXRtWmE1NXEzeFR0QWZIUlNVK1JnVXZZbmI0?=
 =?utf-8?B?b2YvSzlDdVpOeXdqeGZpZVdIQVNhbVIrcTBsR0dsNGs4WlZGaTM1Qjhwc0tR?=
 =?utf-8?B?VFgxTnhFUXdLcWhMdSs2L2kvSHNJcys1OFJFY1JOajhiRktzVHR6MHIzZTlD?=
 =?utf-8?B?QkFia25BRFVkZU1uNkRtNUIxelNrRS9CaHQ4L1Z5YVNEcUpBUFBqbWVUaDJ4?=
 =?utf-8?B?YXhMUkk4MXRyLzl0cmE2OGxFRGpWekx6YVNPeFJRVXEyemx5UzVOL2xTVFRY?=
 =?utf-8?B?VG95Qk5QMzFVWXozSHdDblFBc29QbThKYzZPNmpLMWNKNHY5VWZiUktLYjNp?=
 =?utf-8?B?OUYrTDhBTHIxMUxreHJ2TWpQczg4SUUwM3NOUVRsV1pxbDV5eVdVTnVTbTZG?=
 =?utf-8?B?M3oyMzVGc0xWMS9PZmVlUS9NWlpEK0pSS0ppUkFIbHdkZ1JUd0gxdnpkSm12?=
 =?utf-8?B?NzlhR093VzJpL3gzbXpwVjYwM01lays3QWZaMW1BVzIrTCtNL25KcnhWK1Zn?=
 =?utf-8?B?WFFaWUkyckFJcWd1WHFlRG1QcjJ1VU9oUmZ4WDJlbU41LzZrdkVOYmlmNjZK?=
 =?utf-8?B?aVFoYUEvYy9XY2c1K241ZEFUR3UrNDVhMzBaSG41clcrTzNlS0RqdmFEbXZH?=
 =?utf-8?B?ZlVmK1JQcmJLQjF6M2VlTUczd0Z5REszN2lIQ2NkTERWTDl6cmNvSXJZY05q?=
 =?utf-8?B?RzBLcUFtZG81YlI0ZlhPUmtib0FrSW5QQkdJYTJXWXFFVmE4bW41aWV4OUxj?=
 =?utf-8?B?Vk4xU2luN21mbTF5SFRjMURoeGFacC81RW5Eb2I5bjZNRDA1TGwzSDBqS3kx?=
 =?utf-8?B?WUM5U1B4UkhqQ3BvNzMwYkZDbHFhSlBFV3drNDBYVmFlOE00SHNqM0RUaUVh?=
 =?utf-8?B?eWFyNVVvaWVFenVjQmVINjNpUTJlR0V2dm9aWHRKMHNkWVkyL3RIUjA2WEgw?=
 =?utf-8?B?bitCZVZCRWx5SWxuZEZPQk5kcVJHT3hkVHlrNHpPSUsreHd0K0RiT2VOd0Iw?=
 =?utf-8?B?RDRieGcrUnlIV3A5Q1duaWNnVi9OWkZycHJDWjZ6WmNSTndUY3lGeXMxekVt?=
 =?utf-8?B?UXRUdHNmb29mK2xhMUIrdE85UGVZUTNkWDA3VGMrdllWanhwQU55RjBtMC9k?=
 =?utf-8?B?aE4wZ2pMUE12eEkzcFVYZXoraU1saWhsYkk5ak5Kak9qWEY3NTFmWDc1LzdI?=
 =?utf-8?B?L3Jham16M2NHQWNvTzNVTFQzcStBZ3lhU08rOVh4WHNFSHkxb3pGVGRIRkJY?=
 =?utf-8?B?V2JWSVlqdzd6WFBxakc5akUzcGI0Z09KTm1BRDNQK3ZOdHV2VXVlTjRRbHdI?=
 =?utf-8?B?b05Tb1NrdnY5REljRDJvOVlUVTBlNUJ4MW9ISTUwRlhyc21OcHhlYUNGa3BQ?=
 =?utf-8?B?SEpSaHMxZFVBcnBjY0pDNlJTdFBVWEU4N2kwajlNOXdGWHRsZmFWbXFod0lz?=
 =?utf-8?B?djVabjMya2tTd3hDaTcwMGZVVUF2WnVuWnhWWEJIR3NEeit1TVJHTXFlYkpL?=
 =?utf-8?Q?Lttg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b179dd-470c-4657-efb5-08dc866f0097
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:24:09.1200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sUKz8NPbJWlLePI+vJIyuHA/a17GuUKPGxE9XXFGwOYx8y/4KqJu/dBLQnQaWfcE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264

--=_MailMate_4994FFA7-ECB1-43E7-8EBB-49D68C234227_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 6 Jun 2024, at 14:00, Barry Song wrote:

> On Fri, Jun 7, 2024 at 2:35=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>>
>> +Matthew
>>
>> For mapping_large_folio_support() changes.
>>
>> On 6 Jun 2024, at 2:42, xu.xin16@zte.com.cn wrote:
>>
>>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>>>
>>> When I did a large folios split test, a WARNING
>>> "[ 5059.122759][  T166] Cannot split file folio to non-0 order"
>>> was triggered. But the test cases are only for anonmous folios.
>>> while mapping_large_folio_support() is only reasonable for page
>>> cache folios.
>>>
>>> In split_huge_page_to_list_to_order(), the folio passed to
>>> mapping_large_folio_support() maybe anonmous folio. The
>>> folio_test_anon() check is missing. So the split of the anonmous THP
>>> is failed. This is also the same for shmem_mapping(). We'd better add=

>>> a check for both. But the shmem_mapping() in __split_huge_page() is
>>> not involved, as for anonmous folios, the end parameter is set to -1,=
 so
>>> (head[i].index >=3D end) is always false. shmem_mapping() is not call=
ed.
>>>
>>> Also add a VM_WARN_ON_ONCE() in mapping_large_folio_support()
>>> for anon mapping, So we can detect the wrong use more easily.
>>>
>>> THP folios maybe exist in the pagecache even the file system doesn't
>>> support large folio, it is because when CONFIG_TRANSPARENT_HUGEPAGE
>>> is enabled, khugepaged will try to collapse read-only file-backed pag=
es
>>> to THP. But the mapping does not actually support multi order
>>> large folios properly.
>>>
>>> Using /sys/kernel/debug/split_huge_pages to verify this, with this
>>> patch, large anon THP is successfully split and the warning is ceased=
=2E
>>>
>>> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>>> ---
>>>  include/linux/pagemap.h |  4 ++++
>>>  mm/huge_memory.c        | 27 ++++++++++++++++-----------
>>>  2 files changed, 20 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
>>> index ee633712bba0..59f1df0cde5a 100644
>>> --- a/include/linux/pagemap.h
>>> +++ b/include/linux/pagemap.h
>>> @@ -381,6 +381,10 @@ static inline void mapping_set_large_folios(stru=
ct address_space *mapping)
>>>   */
>>>  static inline bool mapping_large_folio_support(struct address_space =
*mapping)
>>>  {
>>> +     /* AS_LARGE_FOLIO_SUPPORT is only reasonable for pagecache foli=
os */
>>> +     VM_WARN_ONCE((unsigned long)mapping & PAGE_MAPPING_ANON,
>>> +                     "Anonymous mapping always supports large folio"=
);
>>> +
>>>       return IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
>>>               test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
>>>  }
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 317de2afd371..62d57270b08e 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -3009,30 +3009,35 @@ int split_huge_page_to_list_to_order(struct p=
age *page, struct list_head *list,
>>>       if (new_order >=3D folio_order(folio))
>>>               return -EINVAL;
>>>
>>> -     /* Cannot split anonymous THP to order-1 */
>>> -     if (new_order =3D=3D 1 && folio_test_anon(folio)) {
>>> -             VM_WARN_ONCE(1, "Cannot split to order-1 folio");
>>> -             return -EINVAL;
>>> -     }
>>> -
>>> -     if (new_order) {
>>> -             /* Only swapping a whole PMD-mapped folio is supported =
*/
>>> -             if (folio_test_swapcache(folio))
>>> +     if (folio_test_anon(folio)) {
>>> +             /* Cannot split anonymous THP to order-1 */
>>> +             if (new_order =3D=3D 1) {
>>> +                     VM_WARN_ONCE(1, "Cannot split to order-1 folio"=
);
>>>                       return -EINVAL;
>>> +             }
>>> +     } else if (new_order) {
>>>               /* Split shmem folio to non-zero order not supported */=

>>>               if (shmem_mapping(folio->mapping)) {
>>>                       VM_WARN_ONCE(1,
>>>                               "Cannot split shmem folio to non-0 orde=
r");
>>>                       return -EINVAL;
>>>               }
>>> -             /* No split if the file system does not support large f=
olio */
>>> -             if (!mapping_large_folio_support(folio->mapping)) {
>>> +             /* No split if the file system does not support large f=
olio.
>>> +              * Note that we might still have THPs in such mappings =
due to
>>> +              * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the m=
apping
>>> +              * does not actually support large folios properly.
>>> +              */
>>> +             if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>>> +                     !mapping_large_folio_support(folio->mapping)) {=

>>
>> Shouldn=E2=80=99t this be
>>
>> if (!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>>         !mapping_large_folio_support(folio->mapping)) {
>>
>> ?
>>
>> When CONFIG_READ_ONLY_THP_FOR_FS is not set, we need to check
>> mapping_large_folio_support(), otherwise we do not.
>
> while CONFIG_READ_ONLY_THP_FOR_FS is not set, that is no way
> a large folio can be mapped to a filesystem which doesn't support
> large folio mapping. i think

That is why we have the warning below to catch this undesired
case.

> if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS)) is correct.

When it is set, khugepaged can create a large pagecache folio
on a filesystem without large folio support and the warning
will be triggered once the created large pagecache folio
is split. That is not what we want.

>
> The below means a BUG which has never a chance to happen if it
> is true.
>
> !IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>         !mapping_large_folio_support(folio->mapping));
>
>>
>>>                       VM_WARN_ONCE(1,
>>>                               "Cannot split file folio to non-0 order=
");
>>>                       return -EINVAL;
>>>               }
>>>       }
>>>
>>> +     /* Only swapping a whole PMD-mapped folio is supported */
>>> +     if (folio_test_swapcache(folio) && new_order)
>>> +             return -EINVAL;
>>>
>>>       is_hzp =3D is_huge_zero_folio(folio);
>>>       if (is_hzp) {
>>> --
>>> 2.15.2
>>
>>
>> Best Regards,
>> Yan, Zi
>
> Thanks
> Barry


Best Regards,
Yan, Zi

--=_MailMate_4994FFA7-ECB1-43E7-8EBB-49D68C234227_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmZiKPUPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK8AEP/RD20aIxWlwDqUKIq9+EJQGm8AR4il7BeTm9
E1wPu6ojZ5gBMf4roKsDyLZLgG24CzoDAiFPA+KR3h8E5JjxG9YVomGEFLoi99uf
DrsidmklQJPS8SL+KnepK05cbpibgpZ5ugLUjSV3GcPdxvb9mjOBjKHg2cVc4j7i
ApYEIBdMD3ROLHIDa92AT3DYXE5WphW32AaEitMttnXtxxGpKCEXERp4iJ9sqw9B
ddDiBoBE6+xxbsBYHFue/QWTYH6ffI1KtURbr0QemesPrsc4kqs1cDh9omNCSA2V
e4EHR/8OtCGywUx+2X/AI65n7U1r4qcPjQ9Rq1xY+ecxwlmsgCw4S5lQq3ZUyZrM
THLb9mAZGlID68azXxt/qDZklKIUHk18Wof4035ARUA0q1dkwh8m8AHF+XCdWw3v
OoSUQ7Bv+yCvvpDa9+57XpUhUt6Hs0D5pyWD+/ioXkb5lMqNkweX51SwTiVIRB5Z
AsIqeVeYsfGKlARJjHq5Nb1QdakgMtfiG7huH91kMW/feB9UqTbIkPSAsFOcwVh/
DjeyAZeoKnpwS9a7wdzG/8ZX+GG6yIoJeEr2Iz+0LS54cpaxRxeTWOQo3pfjyN0p
9owXcV3c7dxTr0LMIRjXhUSUYvapQXR40Sae+50JpwjF4Ibyzkb5OEcVeigR/pIs
Za6zIUWM
=APGl
-----END PGP SIGNATURE-----

--=_MailMate_4994FFA7-ECB1-43E7-8EBB-49D68C234227_=--

