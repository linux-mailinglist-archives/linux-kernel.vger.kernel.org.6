Return-Path: <linux-kernel+bounces-279190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1BA94BA30
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C0F1C21286
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCD4189B81;
	Thu,  8 Aug 2024 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Bzty1CTj";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Bzty1CTj"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2047.outbound.protection.outlook.com [40.107.247.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154A0189F5F
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.47
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723111009; cv=fail; b=DRX9t3lP00lryNiEfvUXCzzuM0gTu2hzTIsCf3zZqRMjmJpFgMhEVt90HjEsVksUvMxAEM9nXzWe6qxYEqCVXjOhVcZWdbgi2i5cVhE/czeckJSrQZIkd5XzWyqfCT5eMJ/GfIVHWutR3Pv6UgH1XuodqV9K+FQFmQxg9/NG4ec=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723111009; c=relaxed/simple;
	bh=oN0cZ0I8LSbXSCV2TQcgwOfoJOGgUlN2N1DqgUO4Cng=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CfHjf8BrAcwd2wxkX3XrR70dPRFYs1MfcwkrL9OTCvE6pNzMU/2LNp1d7M8AYCwOxeAd/FrqZJ3owafjgmL8qshlXKcghQyY4EjIwO5Xq1L6vLcWeA8zlR1Mr1qAGyKxsTDDsaDtWHI/6Mv63Nv8VYkq0Ob6AbeEHoaO0P5mD5s=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Bzty1CTj; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Bzty1CTj; arc=fail smtp.client-ip=40.107.247.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=HOfO7c3LNCXRbpFZP94u4DUbp06x3ZeFgA78bxDcJB8Dj6zugB0bn4pEGhSYR8kkAtCKl0gKnboHwJAJWD3XNxH4Dns0rBV0IoF5XglQuPb6OiO1/rBNRHfYLqWBrOflvbYtU53qwHxxXWeJHrO2H8TqzmwaBhxbn3Zzk7jT9Bp+ub8GdpItvvh6wrCE+TZQpAWoXs1n8DfGMj9a/UlEjGOHUQ/MziNXSUMf19pm4CZq150ZY4y7brrOQ1qQplHplba5iLXpDlsSwt4+ruvffYj01K+jDgruV/fB5GNh3Oj4e/a5K6uExHeMsfPk4MmJ5cAtoUk5aIyPFfosyGGcpg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TR40wwMefC19PswVHU9SnOs0SlB8inwvhsoGgHGnDiU=;
 b=bWKQ54gFYGMCTY+dp7VS5CDe093IKHDZ3j+F4ZuHGicm1t72lWI98MZFDcX/13Tvhhgh7qNR1KE+KYb4In7wCk55fRWHAFkaIQenoAMLgzRbEvBm35ON+0+eVp9kiIkR6fTwIQ9Ts2enzMkv7qrtTo/hfmuqbihqdm9X4nL5Ni66BzMp3T5y9BdAp5Hx4WDIxT1BZ5FYfBOalPumPulizud9HlVIjkEipgqwVnZAIw9LrwCwwfWNC7k1xQJwmBKkjOaVO08/Awm6B3150mWbz2VBI2nzbpyS+NYJ3UvUOPB2ImndH3GL0L7VZzzY1UXjO1FfNWjwWo+nQ5OWpXMICw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TR40wwMefC19PswVHU9SnOs0SlB8inwvhsoGgHGnDiU=;
 b=Bzty1CTjqzP3d6l0TFS5FSby2n08TMrutmU+3mo7RMRs6FswT+QkhtIg97a1iaDMoCBJ3xVTezdU2ULmy8GVnkI9CunUwZRL+nAjFjskYIj60Z9STllJ1/lP6VhvOFb2QDHgnL3BVZ3hEqUzB771pGhDLRcClbarFvyCC+uTmwM=
Received: from AM8P189CA0019.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::24)
 by DU2PR08MB10016.eurprd08.prod.outlook.com (2603:10a6:10:49e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Thu, 8 Aug
 2024 09:56:41 +0000
Received: from AM2PEPF0001C708.eurprd05.prod.outlook.com
 (2603:10a6:20b:218:cafe::88) by AM8P189CA0019.outlook.office365.com
 (2603:10a6:20b:218::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Thu, 8 Aug 2024 09:56:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM2PEPF0001C708.mail.protection.outlook.com (10.167.16.196) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7849.8
 via Frontend Transport; Thu, 8 Aug 2024 09:56:41 +0000
Received: ("Tessian outbound f9126a275842:v365"); Thu, 08 Aug 2024 09:56:40 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c8caf9ead765c589
X-CR-MTA-TID: 64aa7808
Received: from Le31f65da330b.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0FAE2729-17FB-46D7-ABD1-46BFBF7E6DDA.1;
	Thu, 08 Aug 2024 09:56:34 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Le31f65da330b.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 08 Aug 2024 09:56:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kETjQ8D6kC986VD4nLS6Vo9XFmQhRCH3Z4Z5kP8sK//LFf/pBLXItostoOebXmrjDloY1HVsxFGCn7NYZYrniWJ/1FPDMbpRfzJ05XLvxljFXg75hW/czh6U79z0eOFcUgOT7GtE+xqq2ts2XXEvmF9QNW/ahKJmzMpkfzaPdgZOdYh8MayupMOPELCMN4BmIuHputWWY1i3wosD+4HCbU8xBiLPmH/ePaKLpQ7wUnajMFhv43Wkc3YDpTMko1EfVOqSidfJSvB653PTmpr7JktOptq+4kqXyeV3jmUkWGwZocuWsND+u7b43VGIx7W811WYuaoapeUai1Sc26pHLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TR40wwMefC19PswVHU9SnOs0SlB8inwvhsoGgHGnDiU=;
 b=jvhO46JIhHFmB58Vn6C9UyfqC4obz9Cth5Gwf1wLw/ZsHA18hY5JsnY9A4/8rJD+eJZFztyrKP1iWx/BWPEugslM4NIe24WUXtgTaPGfLdAKzvgWWxBrt1mbcqUA1f41DhHgF9DwFYyFe5Ws7DVsuIrA5Y241Qh1huYj1iaNiYlXzGrRFdYN61tKMzQrFoS1Gw4dD/sO0TbjdT+tn+LN6sZWGEuezIefPbos5hcdu+mMGG6kCV1AobDO891t5z39dOpG63wqtwJW5XLrWVk8zNDNkhSBbsZ+3T1jw+pp/Eb7NxMFkpOLZlZp7RZYP+aoZ6EOXAdsu/7qRB2L3jH9jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TR40wwMefC19PswVHU9SnOs0SlB8inwvhsoGgHGnDiU=;
 b=Bzty1CTjqzP3d6l0TFS5FSby2n08TMrutmU+3mo7RMRs6FswT+QkhtIg97a1iaDMoCBJ3xVTezdU2ULmy8GVnkI9CunUwZRL+nAjFjskYIj60Z9STllJ1/lP6VhvOFb2QDHgnL3BVZ3hEqUzB771pGhDLRcClbarFvyCC+uTmwM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com (2603:10a6:20b:290::9)
 by PAWPR08MB10259.eurprd08.prod.outlook.com (2603:10a6:102:366::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31; Thu, 8 Aug
 2024 09:56:27 +0000
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c]) by AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c%7]) with mapi id 15.20.7849.008; Thu, 8 Aug 2024
 09:56:27 +0000
Message-ID: <0ff65a45-bb8a-4d49-ad3a-7c4d3ae64cc5@arm.com>
Date: Thu, 8 Aug 2024 12:56:25 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: Add DEV_QUERY_TIMESTAMP_INFO dev query
From: Mihail Atanassov <mihail.atanassov@arm.com>
To: Mary Guillemard <mary.guillemard@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com,
 Christopher Healy <healych@amazon.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, nd@arm.com
References: <20240807153553.142325-2-mary.guillemard@collabora.com>
 <327a3440-8d01-4787-83be-a00fbbe0b593@arm.com>
Content-Language: en-US
In-Reply-To: <327a3440-8d01-4787-83be-a00fbbe0b593@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0301.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::19) To AS8PR08MB6263.eurprd08.prod.outlook.com
 (2603:10a6:20b:290::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR08MB6263:EE_|PAWPR08MB10259:EE_|AM2PEPF0001C708:EE_|DU2PR08MB10016:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c5f8c3-ee77-45f3-cea5-08dcb7906722
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?QW8wK2cvSVJ1Zk9BQkpFeXBGOEpYQk9FOVp5QWNUcWhaWW9XdStGMnVoSWEy?=
 =?utf-8?B?dS9uZFNiSE5hWktudyt6K3Avb2ppY0czRVE5eEkrMDR2UitJdHRPZWJ3MFJn?=
 =?utf-8?B?T0hFYkh5bmhBTkN1RVpxTUoyeFpQVHY4OTgxYUZmN3RWM0ZLaUlpSjVKc0xw?=
 =?utf-8?B?RU9oYmRLaVlXRVhaK2EvVGFvaVgxTGJHbEI2Y2NJSUVaWVpyMGhIY2JCN3kx?=
 =?utf-8?B?dzZnd0p4L0xWaUwxdVNZOVFmTStCMGl0eTZWY1NkbVpMSG1EWVBOUit1V0hL?=
 =?utf-8?B?WmJvRVV6bDB0cUZuNVJ3clFubWtESDZuc1BQQ2k4ai8wUjE4Z0NBdHhNeWdr?=
 =?utf-8?B?cTErK1dnTWg0c2s4NElQSFRmQi8yWkRJTVJTaDJuaEkxS21KMjdseUxDVWZm?=
 =?utf-8?B?Z0x4SlhwYXV6cW16Q1czOTk0TzNTUEpQSGMzZmRLbloxZzJicHNVVXNKa2JP?=
 =?utf-8?B?Z2FWazd3VElvc0c3R0ZFeFd0N254Y1lmZ1ZsZ2N4clpzSFFIZVZwWEY5bDQ1?=
 =?utf-8?B?K21zVVN3Ti9teGpXblFRUUsyanJlbmZCWVBobC9CNlR0T1ExKzZJZWp4bzBm?=
 =?utf-8?B?dlZ3TFovaTJpb3pIdVhmcmJUUHNNbEdxQVpSdDZzYkJMU1FsNzQyVkJIUHEx?=
 =?utf-8?B?SElJVCsvR0QyRFZUVDArK1p2UEJ4WS9WaHpwQmgrKzVIazMrb0xDK3poR2Rn?=
 =?utf-8?B?VXRJeE1HWm9RdWdqNjR1dFdpQTc3Y1NmdzBUODVBVmJ0SzhpU1RodjhHZzdX?=
 =?utf-8?B?UkhybnhCVUNlQkU0akxzWnU0WHJRRmJua1YwRVhGajJ4Sm9ZL0VSSEFueERX?=
 =?utf-8?B?UzRnVmVXNjR1eVBGUkl4VEtMMnQ3R21wL1VHekM4TEgyanlDWEhKOTd6Sjl1?=
 =?utf-8?B?QkVVZHJRUTM1RnlYOE5RZEo4clZudjloTjhENzk2U1RhcTJaMVVvcldVMzBN?=
 =?utf-8?B?S3o3V2pqejB6ZDhIRTNETjNXL1Q5eUY5UFRYcFhBOGloanJqalNHZWZXZnpr?=
 =?utf-8?B?aStMYW56c3VQNXVxR2pYa284VnFnWXdBR21UNXBqVU1DK3hScDY0WW5oaUti?=
 =?utf-8?B?bDgrZDFVLzhOYlZ5VnVRNmhyMGM3RHUrNDd6WDZTbStnWTFxUGxqRXpTTzBa?=
 =?utf-8?B?WHkwQUJaWkYzekYzZ2VWTVRKT0g0cHo1ZzcvWFVlRTRnT1lFdTdoNFhNZWwy?=
 =?utf-8?B?Z0FsS21uUzdiUHJDOUJ2M0dzTGJveXZDVUpHd0RHU2NLTEdXT2hhY0tWL00w?=
 =?utf-8?B?N0dscitoVXRvYlRyWGE3My9TRGpXYkp1Q0FVbTVMRzV1c1RJWU1jSldRdWNM?=
 =?utf-8?B?a2dZcFNmUnZMOUFaaXhFNS9uSnAvb0FaTXJGdk84S0toaDl6V05LSXVlUG1m?=
 =?utf-8?B?cnZ3SFR2NUR3V2FxTW1zckxEUlROS28zOEkwN2pxOFE2NHpUaW9DazM3WFJZ?=
 =?utf-8?B?MnNsMFZIY2h1VW1LUC9ZSS9FR09UUklGaHRGQzJOOEpxV3hpeWNGbjRLcGhm?=
 =?utf-8?B?WFp0MHAydDFjaHFVZll5QXdpckR3ck4zUytBdFp3Z3RxZzB3YWxva1doWGgv?=
 =?utf-8?B?OVpvZlVyd1J2czMrWDFsRVY4dFNaUTF5L3ZXWDAvZUhCWXpDQVlCNi9qcGlU?=
 =?utf-8?B?TlJoKytOVmRQK2R6MkNEL0tNUTVzdlFQS21RaUEybm1UczdKZk9zTlBtR1d2?=
 =?utf-8?B?Vi9Kbm1aWjk2K2JKRVBhb3gwVFhIb2tvUlVwN1JSVW52VWx4SHgzcFl4M3hn?=
 =?utf-8?B?VFEvQld1UzZWSjJhcTNkWFJwWXpjME04YUkxTk00ZlZIZVcwd2RBeHlMdW1r?=
 =?utf-8?B?VTNwbER3WWIzejJ2MzUzQT09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6263.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10259
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:290::9];domain=AS8PR08MB6263.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C708.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1ad0c8a2-c1f7-4e7b-3ac7-08dcb7905f04
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|35042699022|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzJ5NHdQazhjUUFueGxsa1ZoWUhzVm1VYVMzSGthemdBclkyWVN5NFhGWHhu?=
 =?utf-8?B?T3YzQmZGZXN0VEZpZlpkNzJKNktjZTJrNjlrS2xsNlMyb3hzQzUxeENqbHhL?=
 =?utf-8?B?bjNTL0taZU9zeHBqalJucm9uamt3d0RjekpWMlZBejJDT0NLdEZZTFE5dDZF?=
 =?utf-8?B?TE5odHlDQ3pkVU9qVUJodkFPcmdmb1p5SzhxSGNJZEgxLzc5WC9zYTZNRmlG?=
 =?utf-8?B?b1FZWjNPeG9MWVp1c0QvZFkwNGdEMlMwSkJFVUNCR0txVGM3U2JSUlQ0TTBB?=
 =?utf-8?B?SVBsb3FaZDdBaDhrK2ZqRi84UDY4ZTB0MlJIUTNuNmROOG1hWGhGYXJRUERZ?=
 =?utf-8?B?bWZVdUVVcmdTUXMvdWlwcDFTVFhDZFhJTFEzU0VJUy9RbUpTUXpqMkJwcDZO?=
 =?utf-8?B?emRSZjlzUnJ0a3htaTgyK00rdFdzZE1mYklUa2R1Q1N3b1JoVDcxMFNQZEdC?=
 =?utf-8?B?VW9HZUg4MjVlU3pZeHlFQmRndVFBK2t6NG9PbnE2ekJPc3NqOTRkenJjejFq?=
 =?utf-8?B?TmJNL1grL1NPSTR2RDJNZlY1aVorY1dSSlFkc0J2bmEvbk5WQ2tNMyt2YXZs?=
 =?utf-8?B?YjdMT3FlYmpxaktLU0tFYzU1Q05GL3ZsZlNFeG9CVWNXRUdUV2NSQnJkRlJZ?=
 =?utf-8?B?TEp1Smk2MjVyUDNpSG8zWjEweGliUitnQUVBTFQxbWRnanR1eld1dnBkZzFs?=
 =?utf-8?B?WDN3WnJCYkdkVktSdGI0c1JiekFnU0JERVlodHE2N0RDL011Y1dHYVA5c0N2?=
 =?utf-8?B?NEVNUGROSVJSYk1JMythcEc2Qk84aEFRb29nMXZPZVVZVjVvRWlzYSs5NytF?=
 =?utf-8?B?cXV4TmZWck1uQUtPZ3kyVzRSMmZEZVR6bzI3dnNUYytjWUc1RVFWeUV3Ykxk?=
 =?utf-8?B?cWtZRHUxVjhhSVdkWXRvbm5GdFlKWTNhRWZJbCttMkp6TGpKdFJwZzc4c3FG?=
 =?utf-8?B?bXJyc0VVM3Vzd0hCZEtWUHhCMFp3SEc1MURyaHRyb1E1bStJZXNET1BIQk5i?=
 =?utf-8?B?YjV2Z2VVT2FwMy84Q3h6U1l2Y0M5d0EvN1pabXdmUnpBa21nT1R6dTdxbGlM?=
 =?utf-8?B?T1JlL3pVSzVzTUExK2VBOEJVZlFFTmllREU4NGh5NTRiWEhsdklyWHdJdndz?=
 =?utf-8?B?eHFnRmd1anlPZEYvQmdoSXlGalBPbG9VdmQzK3YvK2NGbzMrUjJDZ202dnJM?=
 =?utf-8?B?ck9BMDhYK0xocUEvOXJ5ZW8yMWliV0J4K0lDcjVreE9PUHgwcXQvWGdUeVN3?=
 =?utf-8?B?S1NRRnc2RVhTbHZtakc4RWcxTXBYWmpDNWg1V2h0MjZvYTBGMFF6MGlJeFJL?=
 =?utf-8?B?YzlCN2doenRJSk1OdG1wZ3JoVkFNbzlSVmJhbk5MTjE1a044TTBPSTEzalhr?=
 =?utf-8?B?VHZtRk12aEJLbjFwOC9VU3BPdmphMUc5L2xCUm4zZGEyZnhzcFU4VHRxWGxw?=
 =?utf-8?B?YW50d1FUcDZnTDNpN0FqMmZzbUlRL2hpZ0x3MmVlZ0FuZFFyRFpOOS9IUmo3?=
 =?utf-8?B?WHZiRUk1aEsxZW5MTjZmMkdOZm9ITXRCakNIaUNzT2VoNVBEWFlsY3R5NWNw?=
 =?utf-8?B?L2xxaUJRcnpLUHNzcTRDQUdHMVZDSm8wd1pjV3RLTlhDcFN3alkrN0FCdzdP?=
 =?utf-8?B?UjUvWXlSeFZ0aFZoSjViV0N4S2Z6eE9xQXdtdFo0NURabTJ0V2IzV3FLN0gy?=
 =?utf-8?B?Z1hLWVp2SkxqUmVPK0J0UUFHa1g5S0tWK1p5OThUbUwyNjBGYmhxSFEvRTBu?=
 =?utf-8?B?Wi9lNTV2VWk3TlJ4a3F6RnRLakRqVmJwLzEvVFgvbFc1UDM5RUNIQ2VLdndH?=
 =?utf-8?B?cVowQ1lSOUFEYTkxRUdCQmFNNWI5WCszLzhmdDExZWNZRGtXWXVSVVdhaTha?=
 =?utf-8?B?cGR3b0JoNFFneG1xb2pUd0FRTHV0aGNaOUorVHdrUjUrcTQrWWh3bElUNkUz?=
 =?utf-8?Q?ou2Q8caXKuKnVZdt2pu/xG08LVSRU1Iy?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(35042699022)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 09:56:41.2650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c5f8c3-ee77-45f3-cea5-08dcb7906722
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C708.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10016

Sorry about the accidental re-wrap, I got fat fingers...

On 08/08/2024 10:41, Mihail Atanassov wrote:
> Hi Mary,
> 
> Thanks for your patch.
> 
> On 07/08/2024 16:35, Mary Guillemard wrote:
>> Expose system timestamp and frequency supported by the GPU with a
>> new device query.
>>
[... snip ...]
>>
>> base-commit: f7f3ddb6e5c8dc7b621fd8c0903ea42190d67452
> 

-- 
Mihail Atanassov <mihail.atanassov@arm.com>

