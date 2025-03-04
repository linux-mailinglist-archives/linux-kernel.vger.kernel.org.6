Return-Path: <linux-kernel+bounces-545514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21022A4EE0F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 902857A3D1E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD3824C072;
	Tue,  4 Mar 2025 20:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hKLBT7Ib"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3034B1FA243
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741118846; cv=fail; b=GYMuILVsMFPowq81W7Vp7gRcA9ucUOLE8d+VP8nfQvLsL33rMWBE9wJmfdvmZBwUY3zRfc7iuVNd7LLV23b7kSKbTsaiDxOX/oaRNwu2fcAmL7KOyuYi2qRCz7XiwIb3jOchtMJyw9Y0xyQf9ufNWinGpD1jdCJ4IZMKjdMvFGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741118846; c=relaxed/simple;
	bh=ZT3OFLF66DktFekCQe6v/uXCCrCEg+Dpfc5u5odIyCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L1O0cVNUdz44xF6XOqy05ePrYEoFRsByP5EallLXryl7SJ/KLY/0o2s+5R53cFBR2sSkqLcNcSPgoVs/vpLTXPD6MFSjawFTqREDBeC8K0PDtXvtTn/7ZxYDV8cHzuE4g32mqwdUdQZZwB9G/XFEBk9FGWG43K2It8bPWdzp80Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hKLBT7Ib; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cf7yjJnPtAHaMLyt2YOIxnOJz8f3zlwPamz5nE7r10bv5XyOZ5Lnue0ouh4twypeGv0+uIfJ4Y8Vmf7MLo+VPtvi8RJjdcCPHfjLi0WjaxKE6ZCSU7V6ZxkFfEkMDFSiJMgoReQ8a/cHItr3phXVaM7KxaupnMAKJM0/p9bVyfX0ygOGULFKREm+WP5Y4M3B/fnLnIWjLYx4cp+mwC8C4ho0qlBC6w5lX7LtRycO1tjBfGn3cpgZA6VDoaS0v+FJQ0GDaXrfaJVTE/V6q8lt1Z1WOlBCfwOyh9s/KNlbK7kUAEe7/QU9J+WcVtitdsDDcSy+IezltFW9kC8mFMT54w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ER1ZmyeaGGL41nx+RF7JqMpwbgIZ/nGdx88Kr5dLRMA=;
 b=FFlTwBzTcOJ2/mq4dJGUCWhT9ZBX/nyOHPQz82UHBy+2JwgMS6lNrfM5VMNFcER72ocLs3XWNGIM0+1nH7WgY0Y6y2ebaRE5JWq+lSkQZU0EF86g83f4XbUEuhupuh/nncMMsOnkiG25x8BlZ8C8OzJxH0wwgUO0XfZQUv9FmYjV44xHFr3qgcZEeaWlXOrWsVz2h2aqtzRwoTCfqj4g4wmBOYdCUnPYYp4iCW5y5CZ2q9FMmM3GZgbr0AZtYOxAFUxQY1M2LsxSINo9BRdws1P32l3yvh7A766xSEMEou8kGVfBG7p4eDW5ybtlwaBVWeBs2i/r0FCIiGQlUHKWzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ER1ZmyeaGGL41nx+RF7JqMpwbgIZ/nGdx88Kr5dLRMA=;
 b=hKLBT7Ibj17vmg5JIyNoW1fKC0ARUB9P1oDaH2eWNsy6HYpP9oViXYvhqt0Bc1qXZ2wa9mCZDJ4yTccZkw5IZhTrd8g+31NvbnH1x2XRDAXlGQp9ypULZQG22E/843vnJCA/ySgLjqb9HLYhISBevMU3nprCtywuPM7uzO6tZpzGpr2LwoqmceciKLQQLtGZsuM6lQ6C54R9abrGxAtvFMsIc/22nywnGOBdG+P6HZQBujiP1V0b6aFPQWWsi3U8nGBt0YJYmomt7uYcf3PEIOWatn/Gp+GSrplquyZtniqlTFAfSAeIX+46qQL73q2C3YPV3RVkH/ogClUWhqf8/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV8PR12MB9449.namprd12.prod.outlook.com (2603:10b6:408:204::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.25; Tue, 4 Mar 2025 20:07:19 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 20:07:17 +0000
From: Zi Yan <ziy@nvidia.com>
To: Hugh Dickins <hughd@google.com>
Cc: Liu Shixin <liushixin2@huawei.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>,
 David Hildenbrand <david@redhat.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Lance Yang <ioworker0@gmail.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Charan Teja Kalla <quic_charante@quicinc.com>,
 <linux-kernel@vger.kernel.org>, Shivank Garg <shivankg@amd.com>
Subject: Re: [PATCH v2] mm/migrate: fix shmem xarray update during migration
Date: Tue, 04 Mar 2025 15:07:13 -0500
X-Mailer: MailMate (2.0r6233)
Message-ID: <8A4FCFDC-E75A-47B7-8D0C-8874C25BBEF8@nvidia.com>
In-Reply-To: <0D97A437-56A9-4C1D-9759-EAF1F7DA5AE7@nvidia.com>
References: <20250228174953.2222831-1-ziy@nvidia.com>
 <23d65532-859a-e88f-9c24-06a6c7ff4006@google.com>
 <0D97A437-56A9-4C1D-9759-EAF1F7DA5AE7@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:a03:100::37) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV8PR12MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: 95da348a-d756-41c2-f259-08dd5b5829d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bks5ZnhUMy9kRzhPVmpHa3htcVdya0hkdFpvam9WVlY2ZkNSTGJLci9Oa1Bt?=
 =?utf-8?B?TlpOS2YxK3BzT3VPblN4N2FnN3l4WENLdXZmalVSNjJXdU95OHpGMzI1L3E4?=
 =?utf-8?B?SDAwZmRzTG1XWHJ6Q3FEU2QvRE1aaGNKQmQvV09PQVlsanJjSGFST2NkcmdY?=
 =?utf-8?B?QlFSTkh3V2xTdmRIcmQ5elNKamhZRytFVld2VG40a2NuNlR3THc3MC8xYy94?=
 =?utf-8?B?aCtSL1Qxc2grVUJkaEpWYWxtM0EwdU83dlZ6UnBIYUlSTG41dGI1VFNqYWZy?=
 =?utf-8?B?V1hhd3Y1UitQZVZuUTNPV2dYbTdWSWNhVytNVEVKNjUyMnovNVB6TmkzSnJY?=
 =?utf-8?B?aVV1MVhLNWtpS29rcnBrdzVObVJnVVFZaFJsNjhTcE5UWCtSdkc5S3laSW9p?=
 =?utf-8?B?em11aDN4Y0JFcXdHNkZ6MXl5Ti9tV3lnQlB3M1lEckxtZEl0L2ZCMjlMRmI2?=
 =?utf-8?B?eXNRZnNHRndTTXVDWWJMRENxU3pZQ2ZLZEF2OERpMWc5Wk54Y1M4OU4zZDJI?=
 =?utf-8?B?Z1FCcDBMV0dVRmJnMG5aYnVsS05NZE9MSXNscldLL1lkcW5IbmZaVDY1NmlP?=
 =?utf-8?B?TmZBak1KWXNwdEI2bHp2YWVYWktYOExSVzJHNjNkc3Y3WkVYQkxmY3NlTWx6?=
 =?utf-8?B?UWlyRm11Njd5WVBkZ2JGVUNLekhCVndTTCtFSXBJZVlwZVNMUUlJVzJmQ1Jz?=
 =?utf-8?B?SndVdVVLbUt6dUV6RzFuL3RkQ2NXMFpBb253WDlvOXVyMlpmN2VHREpHdDlq?=
 =?utf-8?B?M0dSallNMzVHSjhDdm44SG9aM0RyRGRLSm44NXB2TDljNTlGOWE2cGluUk53?=
 =?utf-8?B?OTFzZXJkVkVUM1IwM0FuOTlrR2xRWnkybmpHZ1VZNURkc29FT0N5ZGFRL01Z?=
 =?utf-8?B?bkVPeGU4ckNnZFVhN2ZpWU1JL29MVDlPUnRiNy9HbVE5ajhObDV1R0NhTi9w?=
 =?utf-8?B?WlRzSGlyR0FDeVIvV3NqN0dqRmdXNHdGUU9aNUZ4alRGbURkMVg3WitIWncx?=
 =?utf-8?B?b2JQU2djMEtzNWdGVUYydFBhMGdFcjM1bHVhc2dLNk5tOHVrLzJiZ0Y1eml1?=
 =?utf-8?B?UlIxRFltM29kV0JKN2U1QWlheUdCdFBscmdUcy90dU55cm1sandmM1NsUE5a?=
 =?utf-8?B?OFE1OGJzem85Q2daSm5CSmRKbERkbVlVV3lzYWY1cDBrbklYVzh3VTF0RGVI?=
 =?utf-8?B?Wm1BOHd6U0RIRVJNYk1FWFZvR3B0YjZDL1lsYkpMWTM0T2k4eE91R01saC9y?=
 =?utf-8?B?SmlzMGdkZGlheHlFcVhMcHpqd2h2MkljT1FSVEVNRXRNaHpJNWxTWnFsTllu?=
 =?utf-8?B?OWtUVkdheVpNaVdXRHBtY0tBWlJTdXRPSjJOdHB4R1pKbk5UZlNoUU5Hdnls?=
 =?utf-8?B?TDc5WGY2dmhCdkN2RzY1WUJvZGV1a2lwc1lqNUk2dkUvV205ZnlJeXhnQkgv?=
 =?utf-8?B?YkpBZ2hOemJseC83UVJicU9VanU1WFBrc1ppK1l0QkdzZ1J2SU84bi9yeGk0?=
 =?utf-8?B?NVU5Y1RzNXN1cm9nYzNBWk54WWV4TTFyODVZMlNZa3ZsY1pTczJUTHFNUTdu?=
 =?utf-8?B?UW9zbWRXS0FCUmcxS1lUMzNWQkppNWpmWU1LRWZUS2k4RXJVcFY5M1JaSll4?=
 =?utf-8?B?UGFNUndXdlFZb3JTZzZRS2M2YjFORkZxbm1vUVRvczNJdzNTZnNEUDExSGc3?=
 =?utf-8?B?Z2tFd1FuUUtNL0poK05OZE52MjYrZnU2Q2hNQ2YyNkRpRnBZR3ZSNzByZGZY?=
 =?utf-8?B?QnRWSVdmV2VLenloQnpNMGc3eVJJczduSGFrWGExUWduOS9aWjNIU1N1dUJC?=
 =?utf-8?B?cnh1MGg4MUs0dmVLM3RUaVAzNjkzS0JTQ1lLWFFHMFMzNFgvMGlqazBuaEV4?=
 =?utf-8?Q?RjSbEmHWignin?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFRNb0JidVQvRHpJN2F4OG5ld0E5RWpFRGxWVXZGR1dhSHlXQ3FOeUdiSjJ0?=
 =?utf-8?B?ZnQ4UG5tRmxHc3duMUR4V1ZJd3BYa1J1WjhyM0tSOVBPSnprd29kcjl3ejND?=
 =?utf-8?B?N2U4WVA1TVY1NVU3VEI0cXhCOHpJa3gyOHpYTVVYbVhMVnpMMWZjM0dkaEZV?=
 =?utf-8?B?ZXg1bmM5ak5wSmlZUWtoMmVFb3VMZXhLYm9FSnJUa05iM0gxNm9KdGxuUDE4?=
 =?utf-8?B?UlFMMHhpcWE3bU14cWdQUGVYa3l3enFJZFdUK1hnQVhMZGZ0aXNhM3lsNXdO?=
 =?utf-8?B?T2toYW9FSUtIT2R0MCs1YWtrK0JFSklERWQrRms3Slh1UGFMNFRLaG9uZUx6?=
 =?utf-8?B?U0Yza2QvSC93dzZoSndLNHZ4UC9aaDN3TVdrTlZlNnJNNkNRV3BmMjVHb3Fz?=
 =?utf-8?B?SFVid0JLZEw0STRwVVBNQkNWdUlJYUw5RGhnUnpqZUhCSWM5eEdpTWhHOUR2?=
 =?utf-8?B?L280YmpabENyZ2FhNkpiRVdQeURQdWR0NmZnTlhoTUZaUE5LYS9hSUUvMjZp?=
 =?utf-8?B?clY1UWpRanhvR1RRNWZkR2R2WERtWWl6cFM5TFJxYmViN04wZnZNY2d0UkNG?=
 =?utf-8?B?WnVDcDdBd0lRNk1UcXQydUxxc3VYMU1ScU5oajM2UGtNMXhHSG8wbHJBZHFu?=
 =?utf-8?B?dm1qVE85NUE5eEk2RjBQeVBwdmRjMDlCWDRkajA1bm10OWJ4Mm1QZ3NybDlG?=
 =?utf-8?B?TWtGMkVabWQyOXNoWFE3VkxrTXl4TTEva0Z1L09IcVVKbmFBbnBSUHhza2Yx?=
 =?utf-8?B?N3F6NVJyZTFtMVpzRnpSdHVKNCtOYXRxZmJUeVUxSnJVY0VPZWFLNUg5N0RC?=
 =?utf-8?B?eitaUmJjYVQrbkl5Yzd1SWtaVzZlSDZsVUw3czE4emY5ZmwvVHhQYW9ZVnRJ?=
 =?utf-8?B?RS8xUElvMWhGUk83T292ejRsOVY2U1BtQWlXOUhLL1FQUGcyVlJRbnZ5SmtS?=
 =?utf-8?B?eldCSndsTnN4NGQ2VG1sY2FwenljT1NCdE0vSnVYNmg1eCtXV1FxMjRBcm53?=
 =?utf-8?B?Z1NJVmdBQ0RUZTFKQ1pZNWRkcm0zM1Jkem5jekZhK01BTnhSSXVrUHIyam5T?=
 =?utf-8?B?UUxMaEJ4MldrclR3ZXQxeUFrUFo5WUNLNktVZ3l1cFlET0k0cjFhc29hN25n?=
 =?utf-8?B?TkpzTDlIbUg2Y3dlVmhyRmVQeGlGVDFYVUJxREZ4OFhsVGJuV0Z3MkFKSVlm?=
 =?utf-8?B?OVFHSG9TNzFkSTNseXZ4OStJMEdkRWhvQjJZc3ZXRjBDdEpzSE5LeGlKWDBZ?=
 =?utf-8?B?ZE1JdGczbEF4cFVWaXVOb1JrZlFSZnY0WXMwRXVvZjRIR2Z3WG9DaG1pcnc2?=
 =?utf-8?B?WkRvWVVuZFR3UmJCdlY0MGU1MFpjOVNyak92QlJOMGtmN0dxWk9COFUvc1JE?=
 =?utf-8?B?RkgwdE5aWjhMR05VZ0xJSzJGc1B2S0tJWFJMRjFSN1p6VHoza2lpYkV1b21P?=
 =?utf-8?B?TFVqdFdISk5sYnBkam5kR21JbVV6MHJacjExSFI2Ujhld1JPUTJURmVtbmpF?=
 =?utf-8?B?d205OXBreFo5TzJPSWV1eVJpSlErN1JwMnJRc0dCS0x5SzIvaGJicnZxYS93?=
 =?utf-8?B?bjNadDRPZm9UWDRuZWRtZmVYaVA2dVB1NThKd1VWNm1Kd3M3c3pkdmk2RE0y?=
 =?utf-8?B?d1daYTRQRUZwOGJ1VWFrZU02T1hQUWNOb2xNM3E0MVVTU1MwQmRINmdtUjc0?=
 =?utf-8?B?SFU4RXNOYU5UOWJsdFFqcFBjWGhqUWFFaTJqc2JGTE0xM3ZlR0xLT0JOUnhT?=
 =?utf-8?B?aDhMaGNIL2U4cWRFWDFkUzExRmVsK1dhWkZFU1FhQlNpWWNlT0NJbXRsaisz?=
 =?utf-8?B?UHRhbVpIeGVvZVBIV1p4d2dqaElXcFVWVGJUdG44RkVrMWdWbUpHajdyUHBx?=
 =?utf-8?B?UVhpNjBsSXVZQ2ZYRkROcW9sc1lnM2NHbStzVXVkSE9PTDBJRUs3dVYwdkk3?=
 =?utf-8?B?VFJjc1V6RGpmRjlhdkJpQ3NZNExSNnZmSGY3UlBZRXVuVllGenc5VzlobGhl?=
 =?utf-8?B?M2VQZDYvQytjdHk1ZWl2c3hPd3gvSEcyLzR5SzB5YzdsOFFlcXozWUt0dkIz?=
 =?utf-8?B?R2JHakQzUjFQU0pmY25jYzd4cm94RnJJTjlUVHduZVdUNFk3U3FqWS9xZkxj?=
 =?utf-8?Q?/RPE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95da348a-d756-41c2-f259-08dd5b5829d9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 20:07:17.5732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40jSdk9Eg9xhZRK8rXd0iyPh5ZTs1WKX0jhuogLUuhqNXOUpH2J12h7rCzX6IDAr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9449

On 4 Mar 2025, at 12:18, Zi Yan wrote:

> On 4 Mar 2025, at 4:47, Hugh Dickins wrote:
>
>> On Fri, 28 Feb 2025, Zi Yan wrote:
>>
>>> Pagecache uses multi-index entries for large folio, so does shmem. Only
>>> swap cache still stores multiple entries for a single large folio.
>>> Commit fc346d0a70a1 ("mm: migrate high-order folios in swap cache corre=
ctly")
>>> fixed swap cache but got shmem wrong by storing multiple entries for
>>> a large shmem folio. Fix it by storing a single entry for a shmem
>>> folio.
>>>
>>> Fixes: fc346d0a70a1 ("mm: migrate high-order folios in swap cache corre=
ctly")
>>> Reported-by: Liu Shixin <liushixin2@huawei.com>
>>> Closes: https://lore.kernel.org/all/28546fb4-5210-bf75-16d6-43e1f864608=
0@huawei.com/
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> Reviewed-by: Shivank Garg <shivankg@amd.com>
>>
>> It's a great find (I think), and your commit message is okay:
>> but unless I'm much mistaken, NAK to the patch itself.
>
> Got it. Thank you for the review.
>
>>
>> First, I say "(I think)" there, because I don't actually know what the
>> loop writing the same folio nr times to the multi-index entry does to
>> the xarray: I can imagine it as being completely harmless, just nr
>> times more work than was needed.

It seems that you are right on this one. I am trying to reproduce the
issue on mainline but could not and I did see shmem hits the entries =3D nr=
.
So it is likely there is no bug in mainline just inefficiency.

This fix might just mask the bugs introduced in my folio_split() patchset,
since I reverted my xas_try_split() in shmem_large_split_entry() patch
and still hit the issue. Let me do more debugging and get back.

>>
>> But I guess it does something bad, since Matthew was horrified,
>> and we have all found that your patch appears to improve behaviour
>> (or at least improve behaviour in the context of your folio_split()
>> series: none of us noticed a problem before that, but it may be
>> that your new series is widening our exposure to existing bugs).
>>
>> Maybe your orginal patch, with the shmem_mapping(mapping) check there,
>> was good, and it's only wrong when changed to !folio_test_anon(folio);
>> but TBH I find it too confusing, with the conditionals the way they are.
>> See my preferred alternative below.
>>
>> The vital point is that multi-index entries are not used in swap cache:
>> whether the folio in question orginates from anon or from shmem.  And
>> it's easier to understand once you remember that a shmem folio is never
>> in both page cache and swap cache at the same time (well, there may be a=
n
>> instant of transition from one to other while that folio is held locked)=
 -
>> once it's in swap cache, folio->mapping is NULL and it's no longer
>> recognizable as from a shmem mapping.
>
> Got it. Now it all makes sense to me. Thank you for the explanation.
>
>>
>> The way I read your patch originally, I thought it meant that shmem
>> folios go into the swap cache as multi-index, but anon folios do not;
>> which seemed a worrying mixture to me.  But crashes on the
>> VM_BUG_ON_PAGE(entry !=3D folio, entry) in __delete_from_swap_cache()
>> yesterday (with your patch in) led me to see how add_to_swap_cache()
>> inserts multiple non-multi-index entries, whether for anon or for shmem.
>
> Thanks for the pointer.
>
>>
>> If this patch really is needed in old releases, then I suspect that
>> mm/huge_memory.c needs correction there too; but let me explain in
>> a response to your folio_split() series.
>>
>>> ---
>>>  mm/migrate.c | 6 +++++-
>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index 365c6daa8d1b..2c9669135a38 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -524,7 +524,11 @@ static int __folio_migrate_mapping(struct address_=
space *mapping,
>>>  			folio_set_swapcache(newfolio);
>>>  			newfolio->private =3D folio_get_private(folio);
>>>  		}
>>> -		entries =3D nr;
>>> +		/* shmem uses high-order entry */
>>> +		if (!folio_test_anon(folio))
>>> +			entries =3D 1;
>>> +		else
>>> +			entries =3D nr;
>>>  	} else {
>>>  		VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
>>>  		entries =3D 1;
>>> --=20
>>> 2.47.2
>>
>> NAK to that patch above, here's how I think it should be:
>
> OK. I will resend your fix with __split_huge_page() fixes against Linus=
=E2=80=99s tree.
> My folio_split() will conflict with the fix, but the merge fix should be
> simple, since the related patch just deletes __split_huge_page() entirely=
.

Best Regards,
Yan, Zi

