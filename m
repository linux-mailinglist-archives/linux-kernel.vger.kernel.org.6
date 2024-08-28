Return-Path: <linux-kernel+bounces-304751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F97F962453
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD2B1F24D3E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77205167DB8;
	Wed, 28 Aug 2024 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="oY2wjYpS";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="oY2wjYpS"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43E415D5CE
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 10:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.41
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724839773; cv=fail; b=O6LKzizUKS/DAv7PY/dQumkhO/DLp5eo+ihn1RsIAW6MCqr0BbI45Ofqdx0VBmdmHcc0EgTZiDvyd88s3LhLVdeWNzvnd/KJtd2Aek45beutvPWVIda59ZcLIVUtkLT39GtrDza4Hmi2NSeaCPmoW9r2csMkUNTj62QF8Dvzb5k=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724839773; c=relaxed/simple;
	bh=kzqaoT58EaLoT3GBdG5BrbhCOusG4NOEMVrCaokNHVk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ie3SLxXmloY56ILrDfqHhUJPvAPRW4tN5r0pv8BKT8vrKDpe7Ffar96amBIpmowZpLS5gPsryvAV6wxQagI7LwrVHod8aZhIWsbL0daHa7NF7YezEOrVkSBa3a70YqGZ5PMb/FVvW3apRK8ayxg0KUnQWW/OuQixi3DK15Fwhdc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=oY2wjYpS; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=oY2wjYpS; arc=fail smtp.client-ip=40.107.20.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=YLFgiQwUojhwmg40heVxj+okKAco8JhvVo5lKtd2dzZ8NRA1tcmU3JqUXVDqnsx35DC+wQrfr3zFYeZIxNaIhDyWBsCh5BqSxtV1wi3DU20rG8Dxv+pqqV43jUvVG8xl0gnHZztHsoVNcrFFPgtgI9+/SisTBx14Rc/HY8e2j8kKZV83EoahmlewNfTS3eJcMi7LcdWH0t7OpFxOOMCmWRnL1TDTz7XvtPG1RcSd0qr4AKikvGs61b14oq2wzpEnI3pp9hbA4zCuSJPizNBxG9jCMS3XTfKONcF65tHTZH1GxapgVVO7HuhOoFdxHKqYl4OGGqcr8R7cGAO0bHTaNg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdV/b+ZIu2p1s6/IQaiFyAPTIN3KjUZy90ETVizEa2A=;
 b=pmzBuB/oqbu9VUf23KHeDJKeMjmaG2zZVEBnJg0xtlolN5csIQQ1E262LyhqY7VoqIZBirKTXEPtgVDfGW5vJcLarCv7FlJukzwEInjScLNF16AZhbPZViyjimmRM1VQkmlWoBunOoN5WCWB/NwAmHMEifMq8xhgFrB+0IntQoj3AgQW8/HoVlnwtp0GMIWO8q614e6ZQgCwxei0+SBwTXx5iYy2+PeDBbunJ3JpGgIgiAmpHeGieTaWCIcRUOPRRx49dRrDOFDgIfJ2s0cOJmnNagEQ0FlAkyo6elHrr4YleYhcM4UmgoL04fakjiPifTLZuHgZdPj2BxW3dlDxYg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdV/b+ZIu2p1s6/IQaiFyAPTIN3KjUZy90ETVizEa2A=;
 b=oY2wjYpSvZ5oQyiTIdQqQZ8tJ9f5lsLdvTtDVUvk5JyH2QwTDTXU30UXhMbhLQB6ehzZvC7DINLmtZIYQth1tpyOPmrWGA7AaKSrZ9SabOmdN9FDIfyrWbIZkK+AZoL2p+kGGvRo3Egq6nKcrp0oUJN6/MSvWYPupPiVrB7+lcc=
Received: from AS9PR04CA0124.eurprd04.prod.outlook.com (2603:10a6:20b:531::11)
 by AS8PR08MB10316.eurprd08.prod.outlook.com (2603:10a6:20b:5b9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.18; Wed, 28 Aug
 2024 10:09:24 +0000
Received: from AM4PEPF00027A5D.eurprd04.prod.outlook.com
 (2603:10a6:20b:531:cafe::c1) by AS9PR04CA0124.outlook.office365.com
 (2603:10a6:20b:531::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Wed, 28 Aug 2024 10:09:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM4PEPF00027A5D.mail.protection.outlook.com (10.167.16.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Wed, 28 Aug 2024 10:09:23 +0000
Received: ("Tessian outbound bc251c670828:v403"); Wed, 28 Aug 2024 10:09:23 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3a7d9438ec0faccf
X-CR-MTA-TID: 64aa7808
Received: from L355ee3f60812.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 83F93225-0149-423F-A1AC-788B76566181.1;
	Wed, 28 Aug 2024 10:09:12 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L355ee3f60812.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 28 Aug 2024 10:09:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgdHpji4hJvwwV/zNQF5iYSsLGI+yCe9sAyDIAHEa3SFyY1gIDhV3DLoZ6jT5s8t/YUY+hEdiCK/THJ/pPuARhLmzCe0QvEaQugQo+1QIOfnBzmjLA5IJsRlD4A1wI8UyYtrpDDw5PZVI9sy/dFC59Q4DND8qGqVD8FOb/cVJ5ope5ffPG2aE3GZquZRw8r3FmYaYZq6dzILOPe7rgDGcjScciP7nWt2qIY3+IT2RZ8HfYptpy3Q4lZkavWUUkxcWTl7qGWMgjJPu05VodtlgxsZ4cs0OIKzDvX0zhwq31MM80ZvY4TulgvnEwxfJIn0M11k4bQURJnZBg0VYGGAeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdV/b+ZIu2p1s6/IQaiFyAPTIN3KjUZy90ETVizEa2A=;
 b=H4EhKyl717GHm/LGOG6s6zFnpb7HQC4xNWMo1DPczpgEgMdiELFS1+WFBLKToL/x6q2XpzC3DOhl4FnBQX0qAJGuMFNx53o0YmR4BgJtwpIR+k6UU14A1Fbt7gO2ZG6yoJPMLhvXQnx7OY86i2TipXk/QcfCFjjQgU6BeWVo0f2EIs2bU0nHCdr1ujNNM3vjX8zUMeAO6HETyBh8YxsxDihGnnU5+XQNslABtLe4daDXB9GTOzB1FxP/x3hWtJz7Y4Bw7LKYptjjzdxVln+qIix4LNyzh74iJjWxIlWdcBWbr5yxF0XY6THEmRLwf+e0vkpgC0ytMS1w82vU3GEmEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdV/b+ZIu2p1s6/IQaiFyAPTIN3KjUZy90ETVizEa2A=;
 b=oY2wjYpSvZ5oQyiTIdQqQZ8tJ9f5lsLdvTtDVUvk5JyH2QwTDTXU30UXhMbhLQB6ehzZvC7DINLmtZIYQth1tpyOPmrWGA7AaKSrZ9SabOmdN9FDIfyrWbIZkK+AZoL2p+kGGvRo3Egq6nKcrp0oUJN6/MSvWYPupPiVrB7+lcc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com (2603:10a6:20b:290::9)
 by DBAPR08MB5846.eurprd08.prod.outlook.com (2603:10a6:10:1b0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.12; Wed, 28 Aug
 2024 10:09:10 +0000
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c]) by AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c%7]) with mapi id 15.20.7918.012; Wed, 28 Aug 2024
 10:09:10 +0000
Message-ID: <ee2c315c-b15b-4ac7-8cea-c331a60a3374@arm.com>
Date: Wed, 28 Aug 2024 11:09:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/panthor: Add DEV_QUERY_TIMESTAMP_INFO dev query
To: Mary Guillemard <mary.guillemard@collabora.com>
Cc: linux-kernel@vger.kernel.org, kernel@collabora.com,
 Christopher Healy <healych@amazon.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, nd@arm.com
References: <20240819112508.67988-2-mary.guillemard@collabora.com>
 <4538ba23-ee8b-4e15-8857-d653d581bc18@arm.com>
 <Zs7d2-NHTy-A_oLL@kuroko.kudu-justice.ts.net>
Content-Language: en-US
From: Mihail Atanassov <mihail.atanassov@arm.com>
In-Reply-To: <Zs7d2-NHTy-A_oLL@kuroko.kudu-justice.ts.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0325.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::6) To AS8PR08MB6263.eurprd08.prod.outlook.com
 (2603:10a6:20b:290::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR08MB6263:EE_|DBAPR08MB5846:EE_|AM4PEPF00027A5D:EE_|AS8PR08MB10316:EE_
X-MS-Office365-Filtering-Correlation-Id: 360c676c-d840-496c-8ff1-08dcc7497e18
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UFhxS0FWVk92RTBGREk5ZzgrSUVZd1E0NzFOenhtdHVabFBNVzRuSkJEa2RJ?=
 =?utf-8?B?SXdmdjB0QXBKOGExcjhVSDRHNG1UbVFqQkNFY0tWVlVRenRObm9oK0VrNXNj?=
 =?utf-8?B?bDhacDlDeVJUdHM1YVJxUjBPUVhXMHViN0IzMzlPa0lSQjBCbE9xaVZwRm9V?=
 =?utf-8?B?b2ZEejU1Z0kvWm9iZEpEY0xRd213Yjluc2tBc0o2bW5DZEFLVVhYSEwrb28w?=
 =?utf-8?B?VkFsS3FBdnpCNm8vT0xzUWhpdThOOXpTdi80c2xKc0ZTWHFVdWhTQVIyVkE2?=
 =?utf-8?B?VFZBdVhmNVY0M0VSWlNnWm1TSHRhYVhqd0krTGJEMi9vZk9EU09WTnBubG1S?=
 =?utf-8?B?cTM3RDg1blFKVE5mYnc4WVluRGdLVG9odC9ZWGxrOHRXRFEweS9nQWM5azlk?=
 =?utf-8?B?Y1lMR3NDVVE1TFFoOENCRUROR1BPUnhGUXFhTzFPRXo2Mnp1Yy8zbTU1b3lK?=
 =?utf-8?B?TkJIU3owczBMVGc4T3RRUjgzUVBrZkpZUlF0bVh4QkkvN2t6WGw5ZzRSYnFH?=
 =?utf-8?B?SnFNaFVrZnJ6a0p2aWgwWE8zMlFGaDZtRDZtbXU0SVhZaXFqZXBLMDRBSlJk?=
 =?utf-8?B?YW9ubXRkU21Yd1VvVWk0MllaTEk3YTRyYjVBcTNmYlRmejNyeXhJUFlQWlgz?=
 =?utf-8?B?NldMOGlQeE1IaUczUmxmaG04Z0FCOTR6bnlZUnQ0cVZ4eU5Rc0hUSHBtNUdY?=
 =?utf-8?B?Q2ZPWFpLOWNMUFVlNlVUcFNvbEFsMWhrZThtWnRvN0d2MnhQNnpQRWZpQkxa?=
 =?utf-8?B?dmo2aWE0MG0xUkJvTXZHbGNhekpPYUR3eHJNZzloRkl1RWh0dWdtWTA4L2wz?=
 =?utf-8?B?ajZuMHNtWnowZnhEQlVPOHpFSU80aUxBeFVJODh6U3dyZmdhSWpWQTdVUE81?=
 =?utf-8?B?SlExTkFOVXdvUlJLZkFiajFlb2lKSTBVa096OFloTFRuZXE0OGR1T3dJV3VU?=
 =?utf-8?B?blloZHVMWVFmWGQ3YW50a1BKNFFPUi9tOTVtQTh6Q3lUemlpcXUrTjNUN21z?=
 =?utf-8?B?cGlJVVRMSWd1aWNGSy9KZXNnWWpTejR2ZUZTZWIwaFkwL1pJakw5WFhiNFlk?=
 =?utf-8?B?VVhObkNyOHN4ZzBlTkhmUE9IYnlzNThFUk1XbzJqTHorTmlSUjN1R2pQRnhk?=
 =?utf-8?B?djZOK0tvNHJRNTF6dUJNT0RkbEJBT0thdDcrOG80NDVRaSt4aXI2SlZpMUV4?=
 =?utf-8?B?QldPRHlKdzl5Z3pySzBpQVp0N1dneFZLNGphM1JmaFdFdTF4SHMvY2JWUE9r?=
 =?utf-8?B?WDJXNDlLbVdydlo4ekVMNW9UKzVPSUVPS0JwK296RW1RWlcyUk8yYVZNRlkz?=
 =?utf-8?B?SnBsZEJaWk9CUTJaN1JwMTdJdjFBUXpSL3NEckkvVTRiWDVkV0VhNDZkTWtR?=
 =?utf-8?B?c0k5ZjNQMnFhSXpsZy93UUZ4NjdxL21qa0JKZDhiMDJSckhHekRMejlKT3pQ?=
 =?utf-8?B?SzVHVXk4UUhYVnhJMWxKaUpZMlhYR1p0d2FwalhYdERuVzFldE1EcUNoT3px?=
 =?utf-8?B?S1d4MllGK0ZUR21hU01QcUl6MWpRQVBCYThDd2hYVkpielhjcjl2dTVJVER0?=
 =?utf-8?B?R1hjSW1wa29HeEdPZ3RJQi9HR3pFNW0ya3V0M1JDd05SRno0aWRZQ29EdTdC?=
 =?utf-8?B?L2dVWjdQQWF1T1FBUVp0WE1kSU9ic1l3L1dVQUFpZlR5cGRFdnVhOWhzYnVD?=
 =?utf-8?B?WldWVTJubUFKZWRBUGJGd3NqQStvbWYrNzA3SHZhWFVncFkyQW93cVZCZXgw?=
 =?utf-8?B?NUcxUHFGd3dqYjFDcm11Z3N5VHZVVnhTL0JZWU5HNEV6NmJHSEcwdXhQR2Uz?=
 =?utf-8?B?bjJPdncrb2RQamVjM3gyQT09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6263.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5846
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:290::9];domain=AS8PR08MB6263.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1140f986-8bc0-41c8-1fe0-08dcc74975ba
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHRBTGVQYkZsTS9Bd0ZTMm12RTlsNm5rL2xrMlRUTitqYm1jYkowSlRWaEY0?=
 =?utf-8?B?Wlg1RTRvdnIrYUFYc0JIZnVHUlJEZmZKVUhKQXJVaXpydDhqV0VUZEIzaWxq?=
 =?utf-8?B?NVJ6OEhMUS9MOUJCTng2Tjcwb3c2ZFh2ZzVOYU1pR2h1djVndDRVdU92T3FO?=
 =?utf-8?B?YWwxZTRMTS9ZUlhrRjcwcUhRWDVTNllUOGkvTFRKTE1lbVJqRjAxcGVjVGRk?=
 =?utf-8?B?c3c5V3pEakpqTHBjR1c5UDdtdWtNYnlDem1wakZPeENyc2JoQnN2dy9jYVl0?=
 =?utf-8?B?cnFJZlpWMTQzVUtNTXk1MUliWkxvQ01LTFplbVNZY3ZKRitWbSs1bmtLY1Yr?=
 =?utf-8?B?Uy9Obm91QlJLaE1PK2JrbVR1OUNIUWxzMU1EUUptYXU4bkNLcTBNUWdRdVZw?=
 =?utf-8?B?ZGhsTmJLMks4aUd4NzljeC96UzB0UkZFV29KTlVVSmlnUkRwVEN3MzJhWVZ3?=
 =?utf-8?B?NnFjdS9MMG1hSkczQWJmRzNQblRHN2E2Mk5TMlNob09VMmVhUlNlNmIxMXda?=
 =?utf-8?B?eUUzWSs3SGdMN3o3eHRpOTg3dGZVM2FKTUZ1WEJ3MVA2c1BNdW4wS3J4bGwy?=
 =?utf-8?B?UDdHZ2toZXRVMmxtejZyY28weEFTY0w4V2dtT3lIWExzbFprTHhYY2JaWkFn?=
 =?utf-8?B?RmQ3WjJZUjk3VS9LVEJFZzRXMExaUzVzYmpLYkgyOWt1cndKR2Q5aHJaVDJF?=
 =?utf-8?B?T290WnpQdldNaFA2NG9nNHNSVmlUdjdEaTlJZXBGQ3c2Mzl6cEwvWEFzWkxn?=
 =?utf-8?B?d2Rrd3BWU3RPb2FMakVwSDE4bEN3UmQ4MVQ4OWEwT0lhbXErNWlGTitlMWVO?=
 =?utf-8?B?NFVsRXNqMUJBSW14MngzUUdCc2diYzJCRzRrZzZrOTNsb1EvWkdYQmE0eFV6?=
 =?utf-8?B?akdUVDVxZ1RBTGN0c2ppMTBqdGVSL2pDd3UyYUwwaUsrQ0xEaTA3dUZSdnEx?=
 =?utf-8?B?ajZSblh5WEF5aU8vRkdrdlRzdVg4NUdoWEZNb0E1YWI5S2IxNUs1bXh6Ym5s?=
 =?utf-8?B?SHIvUCtwVVdNTEV1TDZxWUJJNjljUUMvcWZqVXc2YnBYRmZxMnRqZ0FPUTEv?=
 =?utf-8?B?VHBubm11bnRrSjg5ZUZhY2N5MHU3eTZzYk4rN3hYS3JXZkdwOTJySjRyelJo?=
 =?utf-8?B?c2pBSE52aitxMkFYMmo4NWJZWmxPenRwWEREUlFkaXpXVDY2TXhPWG5peXRi?=
 =?utf-8?B?d3BuSmx2QUY5SkJrTjRZbjVQSFV6VDBlTUhMNkVPMGRFdEplcmhodXhNanZE?=
 =?utf-8?B?TFJBV2cydkxDbWcvS3NSN2xIcVV1emVPNnJCOHlPUzEyT1Q1TGdJcmhwTVVs?=
 =?utf-8?B?UUFDZWVsZEErb3dwdExMRVNacEZtZVFGZUFsL0hnZ1VmcEJGSkgwbmhweVl3?=
 =?utf-8?B?cGJuakRxZ1RXRmdJNVhCSytuT0JvY1BBSDNRSGtWMzVSaFdVUFFMMHFteDNU?=
 =?utf-8?B?T3JXeWFqMC9YRjI5UytHQkZRbDNtRXBsVW54aU5VTk5ET1AwM3BCdDVpeXo2?=
 =?utf-8?B?WTFqa2hETzNkbERWM1JMbEpaSk9uS3lZMUNXUlRUaThjM0M1bFM5SWlyemZS?=
 =?utf-8?B?d0g2V0l3akdueG44ZHpMbEM4MFI3N1JNTkhwcVlRazhaa2VMTGhPRXZNaUtM?=
 =?utf-8?B?WU5UdXNQQjhvZFU5MWhWN2k1WDZoZk56bGduWUJ4RkhCdVNFL1grcHhMeHlw?=
 =?utf-8?B?ZzV5SUs0Zmx0cG54NFVFdmt0Vk1MeWltcmVWM2NLOHg0QmZYbzdSQUVlNS9v?=
 =?utf-8?B?RENnaXJrMlRkZ2hFS3pMd3BxRXlXRkdPcEF6L3BTc0N0WThVenN1MjM4NWJp?=
 =?utf-8?B?aHBGN09hdzRqMmdJTW4xQVBxbmVjbmdPdTRDcTVQWllrVVQxWDI2N0tWZTdB?=
 =?utf-8?B?aEdFQk5lckUrMjZlQ3hVdHY3ZVhVclg5WUwrS1BrRExFVDg2RDBYQ1hzdDJY?=
 =?utf-8?Q?Q79kkZEnzKfqY1LmNVv1F+Zpi/n/5ifQ?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 10:09:23.9815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 360c676c-d840-496c-8ff1-08dcc7497e18
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10316

Hi Mary,

On 28/08/2024 09:24, Mary Guillemard wrote:
> Hi Mihail,
> 
> On Mon, Aug 19, 2024 at 03:25:48PM +0100, Mihail Atanassov wrote:
>>> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
>>> index 926b1deb1116..944f5618aa05 100644
>>> --- a/include/uapi/drm/panthor_drm.h
>>> +++ b/include/uapi/drm/panthor_drm.h
>>> @@ -260,6 +260,9 @@ enum drm_panthor_dev_query_type {
>>>    	/** @DRM_PANTHOR_DEV_QUERY_CSIF_INFO: Query command-stream interface information. */
>>>    	DRM_PANTHOR_DEV_QUERY_CSIF_INFO,
>>> +
>>> +	/** @DRM_PANTHOR_DEV_QUERY_TIMESTAMP_INFO: Query timestamp information. */
>>> +	DRM_PANTHOR_DEV_QUERY_TIMESTAMP_INFO,
>>>    };
>>>    /**
>>> @@ -377,6 +380,22 @@ struct drm_panthor_csif_info {
>>>    	__u32 pad;
>>>    };
>>> +/**
>>> + * struct drm_panthor_timestamp_info - Timestamp information
>>> + *
>>> + * Structure grouping all queryable information relating to the GPU timestamp.
>>> + */
>>> +struct drm_panthor_timestamp_info {
>>> +	/** @timestamp_frequency: The frequency of the timestamp timer. */

Sorry, late nitpick here, maybe add "or 0 if unknown" or something similar?

>>> +	__u64 timestamp_frequency;
>>> +
>>> +	/** @current_timestamp: The current timestamp. */
>>> +	__u64 current_timestamp;
>>> +
>>> +	/** @timestamp_offset: The offset of the timestamp timer. */
>>> +	__u64 timestamp_offset;
>>
>> Are you sure you don't want the cntvct_el0 and cntfrq_el0 values here, too,
>> as separate fields? While they're not values coming from the GPU, they are
>> related. Getting the lowest delta possible between querying one timestamp
>> register and the other is quite useful for tooling. Requiring userspace to
>> do two separate queries, one for CPU time and one for GPU time, doesn't feel
>> optimal, your max deviation will necessarily be higher that way.
>>
> 
> Exposing arch dependent values in the uapi feels wrong to me too but
> maybe that could be done with just the cpu timestamp with a frequency of
> 1 on other platform if needed?
> 
> In any cases, I think that if we ever need it we can extend this query
> with more values. (as we are retrocompatible thanks to PANTHOR_UOBJ_SET)

Agreed, we can leave that for later.

> 
> --
> Mary
> 
>   

Do you have a link you can share with the userspace side of things? 
Assuming userland has been reviewed and is ready for merging, and the 
small nitpick above fixed,

Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>

-- 
Mihail Atanassov <mihail.atanassov@arm.com>


