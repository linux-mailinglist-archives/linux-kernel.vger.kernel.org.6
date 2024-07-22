Return-Path: <linux-kernel+bounces-259128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB629391AD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CCA01F21D4A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C060816E873;
	Mon, 22 Jul 2024 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ANhtcwF0"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9007816D4EF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721661696; cv=fail; b=XpPjS9fcKBW+54d4l7QNfGMO+ctEOt1Tgunrc2vipAzA/3Jdgf6SEd/c3TCWjqyYYtk/shDG1sM6nt0k4DFZCC9lKwNBUMwxDmgecAv9Vq3vCyByelO9C2FhTjHGv2rTQU1h/St7Qj3Se2CgprBxmYqLMDSM/Zsw77Fndgucqjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721661696; c=relaxed/simple;
	bh=8lDoYb5xdqPEgVHPRlO2FYFpK4WbK5C1km6Y9CULH1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=deac2vkitfU+sog7X/bXl5fVLPiwa/+AILbh4379vp97l1qnk2RWZkKMjWm0MuFNhuebe0IFgDJi643nkafTaQ6Md+K4gA9PYSt6GVf5uTap204zWop1SpXRtof1bWZQIzbpJoSmeoMMpTNBTzpAjNpVEQhSZBIhhxoZs0n3lxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ANhtcwF0; arc=fail smtp.client-ip=40.107.100.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWjTkO3RoKaXwITYYD7HeYGoOzS0/I06uRqVPaOuDv8RZ6ysL0sgQ3LKsonsk6RkxNNMap+Qqw69cyCOiDLkkCLW1kl7eIIENarc5bX7eNmogU7qw0YMN4KQVehqJqjJgePqqNAeTnGnVMzMCR1XpOHaY35yC/7oGGwgSMjlJBJmlHP3UDNqVXt7ek38NB/ExYFTgYlNHi6nenkBUxx2wnwaIuYUDrpB3loWdIxwqB6GYIGYmyU2jr/Zbuz5QG2fF52gIhA6NTsXDus7EWaZGPAxUK6Fi5EzB47TpHDeGAnu3nfV+dUHIpxVmCOXdDfquoRQ1uphg9LHu0NJcLqvnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhFebVmndG4ietZThHWiVdwsGfTNCOKdwzn4kMI1MRE=;
 b=h6tcl4T/JNhX5xYtMdoHH6Yg4zfNds/I9tsOx/Tkd6wP54l9vECSiGwP3ndD/WOlInfn0X7v1a7SKN6edZkqas5EtktAWDK8QfRgVrP5niVHA9atJWg1U9Roe7GwSQAHW+zzBQtM+qMSoOBkuZAiO/Xvo5C2OxBsLDR6x6vdB7NO4lIIM6Xs7tqE+or6dlEulCcIkldIPHb1DcvQcTgDZSc8d/tCb93bePhsDbIEB99Hdd+oGPrV7xw2KSfQMwphx3FBwezLOgMMrqIorFvdP9z7OtPQ+3g0KTubePm8+M9PlSu0XSzcf4x4ikz5TE+/61NGcpLHHDezauaQ9zWQnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhFebVmndG4ietZThHWiVdwsGfTNCOKdwzn4kMI1MRE=;
 b=ANhtcwF0n4gWoMs/btah0bqdOQWUUYBYSdbUyWNWVmS/XIblsGEu5XuXxPFNG330b77xVB0BcwP3Gytg5Cg50A6rjhCQDmVBx8Cy5rMnSH6YFPBWp7g16ZM6ONwqgrWfMihb6ikxv9T6IbwjymrCQ43Ils1sdDLPF+mY+eaAfuXPh3mi4/SqCmESB3pw91VFgld4kh9W90y3SBWQY9MObGjKYUvWcVVIIC/YiqPRVGN5iYCC4GVugz/4pFD/HliBbCYmZHDr1IUOe+MXTTpTljwz0KGk8RlplUJchsa2Hkc/4PM0JvEvxN3daH65WRd3i2ACv6Ne7PFfJo+ZkPJXaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.20; Mon, 22 Jul 2024 15:21:30 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7784.013; Mon, 22 Jul 2024
 15:21:29 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [RFC PATCH 3/3] mm/migrate: move common code to
 numa_migrate_check (was numa_migrate_prep)
Date: Mon, 22 Jul 2024 11:21:27 -0400
X-Mailer: MailMate (1.14r6052)
Message-ID: <B9364CE0-1F23-45DD-8AD7-AAC8461FE6D8@nvidia.com>
In-Reply-To: <1844A1CA-7120-4DB2-8F67-8F91BA5B18C6@nvidia.com>
References: <20240712024455.163543-1-zi.yan@sent.com>
 <20240712024455.163543-4-zi.yan@sent.com>
 <87zfqfw0yw.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <735B3DEE-5C4A-43BD-B003-17F4B1F0DC98@nvidia.com>
 <87sew2jiyr.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <1844A1CA-7120-4DB2-8F67-8F91BA5B18C6@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_2E418F9A-B4D1-417C-BC7C-CBDF6392889D_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR03CA0087.namprd03.prod.outlook.com
 (2603:10b6:208:329::32) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DS0PR12MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: 165a1e94-993c-4922-1def-08dcaa61f60b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2dRZzFXVGgwVnJwN3p4dGF0cnN6bEpRRndqMGpJRlV0NU5HSC9ZQ3JSMUNX?=
 =?utf-8?B?QU1NZ2x3LzYxT0d3czJJSHUwV3JQcG5BOXVGdFVJTDFoRkVKYkRwYnFUZlJC?=
 =?utf-8?B?VjN6Qm1VNy82RE8xUklzbHBqa2FmYWVEWmRkRSs3MEpnWk1GNnM3VGZtbis4?=
 =?utf-8?B?eEpWQ1ppcjBtM0plZno4NGZDZU5SQjhuWng3Sk42KzFPcU15YXRnTk9LcGxy?=
 =?utf-8?B?WUxNQ1hDcWJDUWx6TWxWNm1mUVkyMjR3RUdlY2JSbEZuL3krUlAySlV4RjFK?=
 =?utf-8?B?ck4wYkgvZkNhaXJwVlF0UklTQm55ZnZqNlpBU04zem5ST1lSWlVuSG1NTDds?=
 =?utf-8?B?S1dNNUQ1cE1JOTV6RWhpZUpvUGJwVnkrWnA1NStlUkxKYzNXOE9JOU9RWkZP?=
 =?utf-8?B?Ykhuek1kNWZlMmh0TUFScXdCZ2lLOERJMHd6ZVEyb1NReFk1TGpOSllHTlR1?=
 =?utf-8?B?M3p6YytpTHU2RUtsMW9oZnI5Y0JkYlBvY2JkVW1uM1BFeHJsa0l2VWNYRW5V?=
 =?utf-8?B?RHpnaVNGSTRQRkRsejhsN1BtbUhEcjRZYk9vZGJ4cit4dmtyWXM0VVV5WG5G?=
 =?utf-8?B?cFJISlcrMnQvckpuMTl0dHhncFRvaWhwdU1pYWlueWdUSzNUMDQ0dUtMMy9o?=
 =?utf-8?B?Tm5QeVdDTzVXS1M2QWhPK1ZvVXcvTUlZS0JGODZSeU1xemZmSlRlb21jWEQ1?=
 =?utf-8?B?c2JGbyszOVN0TEd5c1FvQjRZVUVEcUZSYWhaQzVpSDV0UkhuZDdkN2pydkJD?=
 =?utf-8?B?N1pJLzQ2Nnhab2MvVDRPR0JFbkxIVjZ3S0tQQ0JrT0ZuVW1KdGtlQks2M1pN?=
 =?utf-8?B?dUw0UlEvRnI3KzFydDdzdkpod0dtMm8xMHRjY2ZiNUFHSXhaRXJSQzVEMUZK?=
 =?utf-8?B?aU81Rk8zUkdBWm54WmpuRWdsTXFldWoxdlMyL1IrSlN1QU1jeDMva0tMZ0dE?=
 =?utf-8?B?VnV4MHdWL0hHYW9GVUF2RnVDMXRvVEdHcmlTanVSK2t2bjVjTWJIdSsxMEUw?=
 =?utf-8?B?ays2V2laS1BGMll6UDNVbXExZmoyamhyQ0tSdW5haEc5ejlQQjBZQ2pVUlNY?=
 =?utf-8?B?aERBcHJWZ3k2NmlsSnIxSEZ3SWREeVdiUldRR3MrNk5yUlhEeGxkSzkvWFRl?=
 =?utf-8?B?UC9OR3dZRXJ3aFNIZXFBMVpmMUR0ZTNhcjVDcFh6VFkxcHN3ZHNCcm1ESU1y?=
 =?utf-8?B?UzFsVHNTYXJTZ1NBWVhNNk5DWERyN1Vzd05jMXI5cU42K2ZQWXZ2NEZzQ3JX?=
 =?utf-8?B?VysrdU1lLzcwTnU0UTVJZVNacmwyZmhXVkhrQUZpVk8wNDczVk9KS1JhUXNQ?=
 =?utf-8?B?VGdpZUtyNHgvdi9TMUdNbGp3UzQzYjJiWG5KMXFXSWtYTzQrRTZXaTZhRndp?=
 =?utf-8?B?THZ2SFJGN29kQWNFY2Rnc0wyc0F1UVhYcDdXOVRlM05rZjc3SUYxQlVaZllO?=
 =?utf-8?B?THhsUGEranVSVFhROFZZMWlublVsZVdxN1d4UmJWZHR5bmlhNG1JY0tFK2VU?=
 =?utf-8?B?TzdLSmQ3dzVnc0NxRlpzY3dORS9KUW50YjBsdWltYTlBVHF0UTRPNzdwM2FC?=
 =?utf-8?B?WU8vdXF6SWVJU2FQakpKU1dKdjE1TDVaNmlzT3R1SzdwcVNlamxnYTVYSWpE?=
 =?utf-8?B?aWdHbDVxamozYUpLNnJqT1BUSnl2V3U1RXh3RENrYjE3ZWpGdHcvR2UyMHVL?=
 =?utf-8?B?emNCUGo4YUxzUkwvQ0FraVRkUWw5Z1g2K0Uybm84ZnRuUm9zb2pDRlBOK2la?=
 =?utf-8?B?bXdONVRDYnlxN2lSWDFXZkpMNnJYT3Bha1J2Rk1NTU9IaVJ0N1lwcGE5dzhC?=
 =?utf-8?B?bHo3V1A0QU9RRWZ4aVIyUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFc1ZWwzOHA5QTd3ZFpqK0N4eGk5WVplcW44YmJwYTRGbDl1NlRnd1pWRkxI?=
 =?utf-8?B?QjRkaFNUKzllN0FnUTl3T1BJaDVIQzBkY0J1ckVrSmZ5Y0krbVgreE1OTDkx?=
 =?utf-8?B?dlk4NFVha1ArS3RwNksvUG5vTzVKRGx4aVFUR1pwWXo1cG9rNUJUcldWUmFp?=
 =?utf-8?B?NVY5dTdIQ3RJK0VzN2V4RFhFY0pxbnFtcmkvVEJ4bkowakNKWS9XVDRIS1NP?=
 =?utf-8?B?dTl2bGd5NHlhSnhwUmRtM0VWalRpQTJMMnlpMzZVeWhaakU5V3czSWFUL0hE?=
 =?utf-8?B?ZEZYTmk0dUFIdDdDTW9VTG1lNHFpTDAwNHlYd0FQcnRBMTBMK3RaV3dlaGZX?=
 =?utf-8?B?R2luTCt2OWd2VVRBMzFPdlZjenBCc3NEL2htZmRzZFFLVklqWGM5WjRVZHRZ?=
 =?utf-8?B?RGxwNXRBUXdsOGZjNVdzK3g5eDhFWHNSb21qZjNpbi9vOUZLc3BRNnRvRDRi?=
 =?utf-8?B?Z1UwZENZR2F4bzBmSUQvT25Xa0E5NTAzNktsSDZxOTZ2RTUxT3psNzZZVFg0?=
 =?utf-8?B?NVNicE5BWkdkU3pGVDlzZjhlcnl5QWZDT0dBRXFtVGU1dGJDK1pTZ1NTeThm?=
 =?utf-8?B?MWNpQVZEYUhZdDhaNHNHa29YU3dkZnd1ZWQ1K1dXY0JaNmVXZlB6Mk9lc2Ev?=
 =?utf-8?B?YmxhNkJ2czdNYXJ3SE90M2ZCSjhnWHgwbVRGaVg1NzRsMUIyZXJ4TjlKNExQ?=
 =?utf-8?B?MkNVMzJEUEFxcC90cTlCTEhNcXBRR3FOSHRrSExoaEp0cnE5a1VMdW1LTjV6?=
 =?utf-8?B?b21wNzViSXFJQkEwd0h3ckxwNWRxaVV4OEpXSnZzSWRldWdycHJvTnAyMkw5?=
 =?utf-8?B?cUhnSUlWeWZnNm1YSXZwME9Na0l5bkVZVWcwczFnTllUcGN4WXpPNTN0RDlj?=
 =?utf-8?B?RzJsdG8zb3VHdUJhMzRoQVJhQllzSWx0RU9Sc213eVZQMTd2NnFpNVJGM2xz?=
 =?utf-8?B?QkVMQTYrUy8vYkRTMnhudXlSL0JqQlVSZEFWdGt4bzBlTXhZWE9DeUxLZ1Qv?=
 =?utf-8?B?SmVRb2xsNDJIVDlOVHpSdFozL2JYUXNZV1BSSW94R3dEUWJsQ0hNRGQ3ZGkx?=
 =?utf-8?B?c0RoTlhrM0M1R0JqWnhScFkyczVPb0dGbmtmcHoxYUNXaVZYbGlmOXY1ZlRP?=
 =?utf-8?B?d2oxNmxHUUVDKzRCTnprNnhmNXRYS3NDVUxOZTF0SC9BeXJaK0FHQU5Ub0oz?=
 =?utf-8?B?VWMzamJ0MGJNTW11VkNZQmJNYWVHODgydTZIUTBETERqM1RBQldIVngrT2kw?=
 =?utf-8?B?bEVpY0VZVG1HKzlGM2REU25tMnZXM1Zjd21GTm1ua1Jlci96T2JINW9xV1dy?=
 =?utf-8?B?UER4ZXdkVDM3NXArWVNOdjhuanlGUXlzajFZR3gxZVBWVHlIRDN4SUh0UG1w?=
 =?utf-8?B?SjFHbmNNQWJmbFlIUDlRWHpIMnptUFZhMVhrdUpmQU9LWWdRNlRqSktWd3R4?=
 =?utf-8?B?VTQwZDdSbTVGU1ZuTFpNU0tRQWpPT0xRdGZ6VXFlTGVRYVdwQTUyeVlXKzZv?=
 =?utf-8?B?T0lPU2x4bTl4TWJpZTU0RExIak90Y2JnOWxnSXpIcXlMc0RLcjFFRE10cVFO?=
 =?utf-8?B?eEpLdXBJWGxVcFNkbmhtS01CTi9WTzg2dnpaWWNCS3pxaHVGY0tLb2RJRlRD?=
 =?utf-8?B?WU1vN1h6VDJPUjNRcElUOEhPdjZ4MEJnK2MxMnl0RkpaL0tFd2tSNUl5MVdx?=
 =?utf-8?B?RWhKbEVrdEx4Y0JnMncxRldEUWZwWFF6cldyWVJJSjBueVZ3UktUVVhUdHF6?=
 =?utf-8?B?azFaeHU3VTF4TVdxRmVFamNwNmhXVG9vZHF0dnc4RlhKVWZSQThUdFRlU1k3?=
 =?utf-8?B?ZDJkSnNVclBXYmVOaytPTDErNkFhMEdlU1h2ck5PQk94SG03bzNoanFjcU9Y?=
 =?utf-8?B?dFVhQ0E0RVJ5UkxmVFNMTGV2TEp6STFSVjIvaTdPRXpNL1FIZzR6QTUxcFNZ?=
 =?utf-8?B?RTU5dkRUN2w0NHV4UWc1VjEwY0Y2QncvOFUwR0JpSnc5TEhTV1VBb3lVN3J5?=
 =?utf-8?B?WWk2TmIyTVgzMkNOSVV3TVkwOXp1YlZlUGxDMVZHeHpsOUtpM2ZjUGRVeXA4?=
 =?utf-8?B?UnRPOEp6b3ZvWUtaRU53cWZzdEN0RWI3K1VnRHI3ZnhkRFd2dTVZZ1dUdTd0?=
 =?utf-8?Q?Iqw8Tqv6SMon/bsp1bnsold84?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 165a1e94-993c-4922-1def-08dcaa61f60b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 15:21:29.7566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/dZ3cdFXyXfNCk+5UpDgnq4wFmNspyioyyzX6i8bAf2Cp09bJDQzQb8q5WRhkBc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7900

--=_MailMate_2E418F9A-B4D1-417C-BC7C-CBDF6392889D_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 22 Jul 2024, at 10:01, Zi Yan wrote:

> On 21 Jul 2024, at 21:47, Huang, Ying wrote:
>
>> Zi Yan <ziy@nvidia.com> writes:
>>
>>> On 18 Jul 2024, at 4:36, Huang, Ying wrote:
>>>
>>>> Zi Yan <zi.yan@sent.com> writes:
>>>>
>>>>> From: Zi Yan <ziy@nvidia.com>
>>>>>
>>>>> do_numa_page() and do_huge_pmd_numa_page() share a lot of common co=
de. To
>>>>> reduce redundancy, move common code to numa_migrate_prep() and rena=
me
>>>>> the function to numa_migrate_check() to reflect its functionality.
>>>>>
>>>>> There is some code difference between do_numa_page() and
>>>>> do_huge_pmd_numa_page() before the code move:
>>>>>
>>>>> 1. do_huge_pmd_numa_page() did not check shared folios to set TNF_S=
HARED.
>>>>> 2. do_huge_pmd_numa_page() did not check and skip zone device folio=
s.
>>>>>
>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>> ---
>>>>>  mm/huge_memory.c | 28 ++++++-----------
>>>>>  mm/internal.h    |  5 +--
>>>>>  mm/memory.c      | 81 +++++++++++++++++++++++---------------------=
----
>>>>>  3 files changed, 52 insertions(+), 62 deletions(-)
>>>>>
>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>> index 8c11d6da4b36..66d67d13e0dc 100644
>>>>> --- a/mm/huge_memory.c
>>>>> +++ b/mm/huge_memory.c
>>>>> @@ -1670,10 +1670,10 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_=
fault *vmf)
>>>>>  	pmd_t pmd;
>>>>>  	struct folio *folio;
>>>>>  	unsigned long haddr =3D vmf->address & HPAGE_PMD_MASK;
>>>>> -	int nid =3D NUMA_NO_NODE;
>>>>> -	int target_nid, last_cpupid =3D (-1 & LAST_CPUPID_MASK);
>>>>> +	int target_nid =3D NUMA_NO_NODE;
>>>>> +	int last_cpupid =3D (-1 & LAST_CPUPID_MASK);
>>>>>  	bool writable =3D false;
>>>>> -	int flags =3D 0;
>>>>> +	int flags =3D 0, nr_pages;
>>>>>
>>>>>  	vmf->ptl =3D pmd_lock(vma->vm_mm, vmf->pmd);
>>>>>  	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
>>>>> @@ -1693,21 +1693,13 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_=
fault *vmf)
>>>>>  		writable =3D true;
>>>>>
>>>>>  	folio =3D vm_normal_folio_pmd(vma, haddr, pmd);
>>>>> -	if (!folio)
>>>>> +	if (!folio || folio_is_zone_device(folio))
>>>>
>>>> This change appears unrelated.  Can we put it in a separate patch?
>>>>
>>>> IIUC, this isn't necessary even in do_numa_page()?  Because in
>>>> change_pte_range(), folio_is_zone_device() has been checked already.=

>>>> But It doesn't hurt too.
>>>>
>>>>>  		goto out_map;
>>>>>
>>>>> -	/* See similar comment in do_numa_page for explanation */
>>>>> -	if (!writable)
>>>>> -		flags |=3D TNF_NO_GROUP;
>>>>> +	nr_pages =3D folio_nr_pages(folio);
>>>>>
>>>>> -	nid =3D folio_nid(folio);
>>>>> -	/*
>>>>> -	 * For memory tiering mode, cpupid of slow memory page is used
>>>>> -	 * to record page access time.  So use default value.
>>>>> -	 */
>>>>> -	if (folio_has_cpupid(folio))
>>>>> -		last_cpupid =3D folio_last_cpupid(folio);
>>>>> -	target_nid =3D numa_migrate_prep(folio, vmf, haddr, nid, &flags);=

>>>>> +	target_nid =3D numa_migrate_check(folio, vmf, haddr, writable,
>>>>> +			&flags, &last_cpupid);
>>>>>  	if (target_nid =3D=3D NUMA_NO_NODE)
>>>>>  		goto out_map;
>>>>>  	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
>>>>> @@ -1720,8 +1712,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fa=
ult *vmf)
>>>>>
>>>>>  	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
>>>>>  		flags |=3D TNF_MIGRATED;
>>>>> -		nid =3D target_nid;
>>>>>  	} else {
>>>>> +		target_nid =3D NUMA_NO_NODE;
>>>>>  		flags |=3D TNF_MIGRATE_FAIL;
>>>>>  		vmf->ptl =3D pmd_lock(vma->vm_mm, vmf->pmd);
>>>>>  		if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
>>>>> @@ -1732,8 +1724,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fa=
ult *vmf)
>>>>>  	}
>>>>>
>>>>>  out:
>>>>> -	if (nid !=3D NUMA_NO_NODE)
>>>>> -		task_numa_fault(last_cpupid, nid, HPAGE_PMD_NR, flags);
>>>>> +	if (target_nid !=3D NUMA_NO_NODE)
>>>>> +		task_numa_fault(last_cpupid, target_nid, nr_pages, flags);
>>>>
>>>> This appears a behavior change.  IIUC, there are 2 possible issues.
>>>>
>>>> 1) if migrate_misplaced_folio() fails, folio_nid() should be used as=

>>>> nid.  "target_nid" as variable name here is confusing, because
>>>> folio_nid() is needed in fact.
>>>>
>>>> 2) if !pmd_same(), task_numa_fault() should be skipped.  The origina=
l
>>>> code is buggy.
>>>>
>>>> Similar issues for do_numa_page().
>>>>
>>>> If my understanding were correct, we should implement a separate pat=
ch
>>>> to fix 2) above.  And that may need to be backported.
>>>
>>> Hmm, the original code seems OK after I checked the implementation.
>>> There are two possible !pte_same()/!pmd_same() locations:
>>> 1) at the beginning of do_numa_page() and do_huge_pmd_numa_page() and=
 the faulted
>>> PTE/PMD changed before the folio can be checked, task_numa_fault() sh=
ould not be
>>> called.
>>
>> Yes.
>>
>>> 2) when migrate_misplaced_folio() failed and the PTE/PMD changed, but=
 the folio
>>> has been determined and checked. task_numa_fault() should be called e=
ven if
>>> !pte_same()/!pmd_same(),
>>
>> IIUC, if !pte_same()/!pmd_same(), the fault has been processed on
>> another CPU.  For example, do_numa_page()/do_huge_pmd_numa_page() has
>> been called on another CPU and task_numa_fault() has been called for t=
he
>> PTE/PMD already.
>
> Hmm, this behavior at least dates back to 2015 at
> commit 074c238177a7 ("mm: numa: slow PTE scan rate if migration failure=
s occur=E2=80=9D).
> So cc Mel.
>
> The code is https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git/tree/mm/memory.c?id=3D074c238177a75f5e79af3b2cb6a84e54823ef950#n3=
102. I have not checked older
> commits.
>
> I wonder how far we should trace back.

OK, I find the commit where task_numa_fault policy settled:
8191acbd30c7 ("mm: numa: Sanitize task_numa_fault() callsites=E2=80=9D).

It says:
=E2=80=9CSo modify all three sites to always account; we did after all re=
ceive
the fault; and always account to where the page is after migration,
regardless of success.=E2=80=9C, where the three call sites were:
do_huge_pmd_numa_page(), do_numa_page(), and do_pmd_numa_page().

The current code still follows what the commit log does.


Best Regards,
Yan, Zi

--=_MailMate_2E418F9A-B4D1-417C-BC7C-CBDF6392889D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmaeePcPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKqlwP/iKuPrNIRDxKTzqw5nP+ZNpiaO3XGu90JxS/
WxCTKXX9iotkGULwMz3LnZdH9+bWt/bcdyUh/QsP+aOQfrOcFeHj2DyKei+MhfrI
VRlX4wcHZr6BrESU6j3hvdZL1gUP65Tejy9du5vL8Pc3YqPPLSzO1PVtRiepk9ZF
Y9SIW4JSS3EW73BsBSrECMawkhraSwJP1eL1Z+03nYvN8JqGmGan/eF/y8h4jnUW
KnbSefTrIefBKdou2QoG9B4IZQdjugtL/Wdi6CbqdhEgaMBw5d63jXCj8U/mFfMV
bDyz3HcWRxPTMi/mngEYX744OzLXJJGE4NKIb+zdD1pvSi7BSRH5CQwA0d/ea1Y0
W4aNlwyubJmFdKSQ5wTIMQBa2e5YrXeOwcTGF//r8LG21ks9kvw6kf6SwZ4YIDEh
8UAq3TbBIHwv75pGp6N72SMalJnvoInavB3KbdwI1q87wOsK7hzOfUPTjcFNkcNJ
Efg0/Hx1GKD2hGeIruYa/uH85MRhSWsoDc/uuDls6+2srp7ok53IYWjjOsPXQI1E
UMoVkzWWfjo1Z7Q3y78s3MOaHISYVpc0TevY8T5bHzs4eqeo6/yt+8CtRdvqw37c
QUCl4+nLiOzYmXgIpddo1fMpyMoNxyL7dzCURtJsAUNwtLpVYtOLitZ7CE/9Mgo0
G/FQ2/9c
=tBHv
-----END PGP SIGNATURE-----

--=_MailMate_2E418F9A-B4D1-417C-BC7C-CBDF6392889D_=--

