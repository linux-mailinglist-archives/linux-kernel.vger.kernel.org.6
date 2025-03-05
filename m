Return-Path: <linux-kernel+bounces-546256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CC5A4F873
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECCB5188D3F4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C9A1EDA1F;
	Wed,  5 Mar 2025 08:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="G08VeovE"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020075.outbound.protection.outlook.com [52.101.128.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8223F2E3360
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162154; cv=fail; b=gqMSAlj/HxNCFUJQ1fPqQBu/xEyFP7O3borHuOFHziEjSJI3JyNnqub+I6BsgWNKYmJp3V5CWFKUdZ997mt2jq0s0Y+Pzq6u10lmh39J9rfco0z+gBI0zCsYXx2BiHaY9di2/+3NZNKeJfuAcNIfiorUFHNe4HZ4pFwyKPs8CBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162154; c=relaxed/simple;
	bh=6YiFG3XeQHtSixEo4oFnuTSzEAQp3PBGmuZyxvCMnv4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NKwanK8GIqLPD+c8ShokZf7Kkp+hmhp4GlEms4Hy0wG2E4m0GwG/gx7Z68KSOPZRcP9ydjGFXqkq0ImSFBqQFNmRYkx6d6spj7BWCgo+qgQBQKYDgyF6Hg3/tgkqZXCWe5iyOxZMcyEFWDfo289CcMdGNglXAazGhWO13bzf3cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=G08VeovE; arc=fail smtp.client-ip=52.101.128.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+JS96AebHQxV8n+KqfPxRrQ2Wn9kc0BtF+BvpZHvJGpB2mLEdwb70gpAkqJmfx3PDXRJjaES8LbJyD7XO2BvL1KhYqBGgV8QnvOYm/baQ/xYdKgJ7HvLq7GaGmpdq410nDCVKpkZUtTA3H6SIA9Heif/Zz3+lTwcn0BRVQXm3T6tPs/ArWt8uoAbgVq00neIQHjQ37cJPJbWLOSJp/ROTJVIStxltxx3xI6kXS+hAgZQEAoN9Wm/dOhFDAGU45XLIASxQaDxZ2fS7D8OdMt9otYiS2VXPY0wcvLddx4YulvA748sALCNlrCewDkV1qYu5dZIKYRBG0H5VHFed8Ibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YiFG3XeQHtSixEo4oFnuTSzEAQp3PBGmuZyxvCMnv4=;
 b=qbwBbd5lHsuTWk+GP1fsW/v3uCjK4zXL2ac/xyeOJZptCH4UlyL/QWeuafZZV5O+2yHpeoh9SUfikwJKAn2IJHexiFsV6bCooRkmCEtLEemberpc3JWeyFxIVGCT6uafnKzUL332oea/jq5lPjw5pOPqasRN9wk/ssaB4K7fN0ronaC2yXCqKBxuo42XCkb1NjeX9M8WemyrvluSNfUKx+N3weIm4E9vzIZdUqnN1Q+9EqCjE+TwF12EIYRtm2ltnj8N+TYvurSLKNDfbfMjtvYSgRfVW674yvf8WlWboKb/cJ7h998usm9dK+t5uk+ZeGvIDZDlAptE00lxxhH7dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 58.246.63.154) smtp.rcpttodomain=redhat.com smtp.mailfrom=transsion.com;
 dmarc=none action=none header.from=transsion.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YiFG3XeQHtSixEo4oFnuTSzEAQp3PBGmuZyxvCMnv4=;
 b=G08VeovE+0ypbAcQHS90Xfyt5BdBZwNq0Z/ubgR6ywJXxD3tfQlOnNY4iJJSH6MCUGSLoqspm/NvKNaNajmgaDkITGVW9gsG3IYc9ixBQZsliW9Qv4+bk74y9UjSf8jIAHUbRoRK45uY/AidYHgebsq2tkQD7SwoiCvgw0I+dI8=
Received: from SEWP216CA0137.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2c0::6)
 by SEZPR04MB7856.apcprd04.prod.outlook.com (2603:1096:101:228::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Wed, 5 Mar
 2025 08:09:04 +0000
Received: from HK3PEPF0000021C.apcprd03.prod.outlook.com
 (2603:1096:101:2c0:cafe::b9) by SEWP216CA0137.outlook.office365.com
 (2603:1096:101:2c0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.18 via Frontend Transport; Wed,
 5 Mar 2025 08:09:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 58.246.63.154)
 smtp.mailfrom=transsion.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
Received-SPF: Fail (protection.outlook.com: domain of transsion.com does not
 designate 58.246.63.154 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.246.63.154; helo=mail.transsion.com;
Received: from mail.transsion.com (58.246.63.154) by
 HK3PEPF0000021C.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 08:09:04 +0000
Received: from SH-EXC-MX06.transsion.com (10.150.2.44) by
 SH-EXC-MX03.transsion.com (10.150.2.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2507.44; Wed, 5 Mar 2025 16:09:02 +0800
Received: from SH-EXC-MX06.transsion.com ([fe80::954b:3df8:a403:9ca3]) by
 SH-EXC-MX06.transsion.com ([fe80::954b:3df8:a403:9ca3%12]) with mapi id
 15.01.2507.044; Wed, 5 Mar 2025 16:09:02 +0800
From: =?gb2312?B?eGlhbmhlLnpob3Uo1tzP1LrVKQ==?= <xianhe.zhou@transsion.com>
To: "mingo@redhat.com" <mingo@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"incent.guittot@linaro.org" <incent.guittot@linaro.org>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>
CC: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "bsegall@google.com"
	<bsegall@google.com>, "mgorman@suse.de" <mgorman@suse.de>,
	"vschneid@redhat.com" <vschneid@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND] sched: Fix incorrect runnable time calculation in
 sched_stat_wait tracepoint
Thread-Topic: [PATCH RESEND] sched: Fix incorrect runnable time calculation in
 sched_stat_wait tracepoint
Thread-Index: AduNpc7e/vIoEgrTQ5G6RTe5+ksHWw==
Date: Wed, 5 Mar 2025 08:09:02 +0000
Message-ID: <88f3d595597443bc96fd7f11b02ccc15@transsion.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021C:EE_|SEZPR04MB7856:EE_
X-MS-Office365-Filtering-Correlation-Id: d3107146-8c12-4e3f-c068-08dd5bbcfed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?gb2312?B?cEF1dU01ZWJTd3V2Wis0WHZRRmoyNjVISUI2c0lwSUZYQzErSGYyaUlXS2Na?=
 =?gb2312?B?T3R1ZHBRWHNlaXc0Y1V0cHhZMW1CYzdOeHpIeWhzbFZSL2hxUG5NY0RoY2Z4?=
 =?gb2312?B?VitlQjJUUERYeWY2Z1ViUURueHI1NWlsNUdLREpIVTFISDVTdnNJaWt2L2R0?=
 =?gb2312?B?OHdxY3NLaEI4eTFTSXVET2FaOWwxMFI5LzlncWZ2VWtqM1ZaaXR3bDhIbWdz?=
 =?gb2312?B?eDVMR3VQT0hTa2JaL09vSXB2VXplYUxKU0dkeEZRdDJQWW9JZGJGNHFWSVBs?=
 =?gb2312?B?b1F1OXpDb1FaM2IwanZuSnpwalRJejZhU0FoeXF0UXFLb24wVXVsNml5V2Q5?=
 =?gb2312?B?TzA0K1N2eUVXaXBoamFtRnZNSWlFYU04a1Vxdk9IR2Z5MW9Kd0F2SHJKYmlS?=
 =?gb2312?B?UlVhaTFrVGVYR21Bczg5cjZodEY1QzdTQmxZbXozRlBEYmhyZVNrb1lwc0gw?=
 =?gb2312?B?ZU9MYjdNbTlOclA5RXU2SzE5LzlmSy9tRmNiMzU1UG9SdHg4MW1sZWNuNEpY?=
 =?gb2312?B?L2pqYUFJZFVNYTQ5OHRzSSt4Q2RZdFNlUXR5Y3RuY1p2bVF6eXRMa2czZHJp?=
 =?gb2312?B?QmlNTXJ5bEg1SDNIbDluOC9rWHUzWEIySWVMQjZ2SlN0UkMvWTcySStrYTE1?=
 =?gb2312?B?UDltTzZTcU15TWhwZm9Pb01EODVWN0EvMURmaGtCMmQ3OXZOQlV6MFY1Smx4?=
 =?gb2312?B?djFZVWRqWTdCMUduOWxsS1djdy9xK3dReE1vT0Jva1NVVWVTaUp5TlF3eUlR?=
 =?gb2312?B?elV1bUYwaVBSOGtHSW0ydHU1UG90N0wxdmt1M3ExVk1ra1UvYk1RaE9rOVRE?=
 =?gb2312?B?OG5KQVJzK3RuNjBkSnhaeFhHc2FxejJQTGRHYk5kcjloaExIdTZRVUswd2x1?=
 =?gb2312?B?WlQrSG0xR2hCdmdwR0daZERMVnJTUnRRM1daWlM1WE55ODdWU0U5UXkwWGwx?=
 =?gb2312?B?Wi9xVmp1ZUN0RnI4YlZwc0YzbkduUkZtek1PV3dBSGtRWGU5SjJaUlVMeFFa?=
 =?gb2312?B?NENpOEdKN3htT3M4K1lFN3E1SzAwTEhNVzFHRnpISzVzS2dtUFNFRUFIWXE4?=
 =?gb2312?B?VUVkNDFWU1VIUS9UZkd4ZGxJTld0TkpXSit0U1hjK3RJUkNEU0ptcVF0ZSsz?=
 =?gb2312?B?eFA5bmloVk5KbzM1VXN4S2NCNCt3cS96MmlUam9NNHJZS0t0bk1oU2Ewbm5G?=
 =?gb2312?B?Y09pM2o1VGtHR3Q4N21oWFR6UE9wY3M3RXBRdnNjUWkzaXMwdmpnUXdLcW5w?=
 =?gb2312?B?bDhrcGt1ZHoxVUE5b0JqWjdKN2ZxM281eWlzMWhsSXBPYmQyY09BcDNxVk1U?=
 =?gb2312?B?azRVdXJtamNqWnpqWm1mdmdtdzhCWi9Jdk14MTdobndHNWI2VjFkZ1lOOHJN?=
 =?gb2312?B?MGl1Y3p1Z29PNTFyL1pjaDlKY25WZDhLbEtCcjhCWXZRWElNRFVleWRtNWtu?=
 =?gb2312?B?eGZ6MHNleUYxZXc5eXNNWUlFaFIxVEs4RXBnN1Fnd2pmTGhKQkp5VTlPMDFK?=
 =?gb2312?B?ejJKdDcxRGllWUpKcnF4WjBWNm8zMlJFbkx4Q0hYZmJVTUJ6aTlHN3d0TGEw?=
 =?gb2312?B?cjVDclkyVGl2SU1JbzBjVHRKa2RTUGFUMllHQ2JhamxNcnlHY20vanJMeTls?=
 =?gb2312?B?QVJpeWsrb2JRK0xUS2JYd05BSnJIN1ZEZlZWQk1VR0JaOWlReWo3eUVGdGJx?=
 =?gb2312?B?NmkrSGhzME9Sdi9FbmxFcjQ3NkljQldwdWdOV1hxQVZhNmF2cjIwL1lRWHk3?=
 =?gb2312?B?M0djcXBLeHFpUHQ3WVhZNlFZSUZ0WTJ5N1AyakYrbFFYKy9WTlo1UzEzbzJQ?=
 =?gb2312?B?a3poQVBzOVR3RVV6RjVybnovMkg4NksybWVnMGw0TkZCVkd1ZVZ2UTFTS0VE?=
 =?gb2312?B?OVY0ZndmMzFHRE9wTEtzM0RlMHFoeVNBTFpDTTBtV1Nha2dtdFNMeWNjdUlz?=
 =?gb2312?B?MWVOMEpjS0h2OHplaytrNWVSZVdiOVd5MVovb25KbGdSYnlaMi8wOXJJQmNh?=
 =?gb2312?Q?pMwRmVAFEXwN0ptCyrx7Ga1+iPBIRg=3D?=
X-Forefront-Antispam-Report:
	CIP:58.246.63.154;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.transsion.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 08:09:04.2003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3107146-8c12-4e3f-c068-08dd5bbcfed5
X-MS-Exchange-CrossTenant-Id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2;Ip=[58.246.63.154];Helo=[mail.transsion.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021C.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7856

RnJvbSBiMDdkZjNlZDNmZDIxODZhNjk4ZWY4N2FkMzY2NTIzZWM3YzdmY2NiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogInhpYW5oZS56aG91IiA8eGlhbmhlLnpob3VAdHJhbnNzaW9u
LmNvbT4NCkRhdGU6IFRodSwgMjAgRmViIDIwMjUgMjI6MDE6MjYgKzA4MDANClN1YmplY3Q6IFtQ
QVRDSF0gc2NoZWQ6IEZpeCBpbmNvcnJlY3QgcnVubmFibGUgdGltZSBjYWxjdWxhdGlvbiBpbiBz
Y2hlZF9zdGF0X3dhaXQgdHJhY2Vwb2ludA0KDQpUaGUgc2NoZWRfc3RhdF93YWl0IHRyYWNlcG9p
bnQgaXMgaW50ZW5kZWQgdG8gcmVjb3JkIHRoZSBydW5uYWJsZSB0aW1lIG9mIGEgdGFzay4gSG93
ZXZlciwgZHVlIHRvIGluY29ycmVjdCB0aW1lc3RhbXAgaGFuZGxpbmcsIHR3byBtYWpvciBpc3N1
ZXMgYXJpc2U6DQoNCjEuIFRoZSB0cmFjZXBvaW50IG1heSBpbmNvcnJlY3RseSByZWNvcmQgY29u
c2VjdXRpdmUgc3RhcnQgdGltZXN0YW1wcw0KICAgb3IgY29uc2VjdXRpdmUgZW5kIHRpbWVzdGFt
cHMsIHJhdGhlciB0aGFuIHByb3Blcmx5IHBhaXJpbmcgdGhlbS4NCiAgIFRoaXMgbGVhZHMgdG8g
aW5jb3JyZWN0IHJ1bm5hYmxlIHRpbWUgY2FsY3VsYXRpb25zLg0KMi4gVGhlIHJlY29yZGVkIHRp
bWUgbWF5IGluY2x1ZGUgdGVtcG9yYXJ5IGRlcXVldWluZyBhbmQgZW5xdWV1aW5nDQogICBldmVu
dHMsIHN1Y2ggYXMgd2hlbiBtb2RpZnlpbmcgYSB0YXNrJ3MgbmljZSB2YWx1ZSB3aGlsZSBpdCBp
cyBydW5uaW5nLg0KDQpUaGlzIHBhdGNoIGVuc3VyZXMgdGhhdCB0aW1lc3RhbXBzIGFyZSBwcm9w
ZXJseSBwYWlyZWQgYW5kIGV4Y2x1ZGVzIHRlbXBvcmFyeSBkZXF1ZXVpbmcgZXZlbnRzIHRvIHBy
ZXZlbnQgaW5jb3JyZWN0IG1lYXN1cmVtZW50cy4NCg0KVGVzdGluZzoNClRoaXMgaXNzdWUgd2Fz
IHRlc3RlZCBvbiBhbiBBbmRyb2lkIDE0IGRldmljZS4gVGhlIGZvbGxvd2luZyBhcmUgdGhlIHRy
YWNlIHJlc3VsdHMgYmVmb3JlIGFuZCBhZnRlciBhcHBseWluZyB0aGUgcGF0Y2g6DQoNCkJlZm9y
ZSB0aGUgZml4IChpbmNvcnJlY3QgdmFsdWVzKToNCg0Kc2NoZWRfc3RhdF93YWl0OiBjb21tPU92
ZXJsYXlFbmdpbmVfMCBwaWQ9MTUzMyBkZWxheT0zNTI0MTgzMTU4MzkgW25zXQ0Kc2NoZWRfc3Rh
dF93YWl0OiBjb21tPU92ZXJsYXlFbmdpbmVfMCBwaWQ9MTUzMyBkZWxheT0zNTI0MDk5NjE4NDAg
W25zXQ0Kc2NoZWRfc3RhdF93YWl0OiBjb21tPU92ZXJsYXlFbmdpbmVfMCBwaWQ9MTUzMyBkZWxh
eT0zNTIzOTMzMTc0NTUgW25zXQ0Kc2NoZWRfc3RhdF93YWl0OiBjb21tPWJpbmRlcjoxMTQ4XzMg
cGlkPTIxMDIgZGVsYXk9MzUyMzgwNDkzMzc3IFtuc10NCnNjaGVkX3N0YXRfd2FpdDogY29tbT1P
dmVybGF5RW5naW5lXzAgcGlkPTE1MzMgZGVsYXk9MzUyMzYwMDMzMzc3IFtuc10NCg0KQ2xlYXJs
eSwgdGhlc2UgcnVubmFibGUgdGltZSB2YWx1ZXMsIGluIHRoZSBodW5kcmVkcyBvZiBzZWNvbmRz
LCBhcmUgaW5jb3JyZWN0Lg0KDQpBZnRlciB0aGUgZml4IChjb3JyZWN0ZWQgdmFsdWVzKToNCg0K
c2NoZWRfc3RhdF93YWl0OiBjb21tPWt3b3JrZXIvNzoxIHBpZD0xMzY4MiBkZWxheT02MzUxNjky
MyBbbnNdDQpzY2hlZF9zdGF0X3dhaXQ6IGNvbW09U3VwZXJBX1JbMTM2XSBwaWQ9MTUwNzQgZGVs
YXk9NTEzMjQzODUgW25zXQ0Kc2NoZWRfc3RhdF93YWl0OiBjb21tPVN1cGVyQV9SWzEzNl0gcGlk
PTE1MDgwIGRlbGF5PTUwMjgwNTM5IFtuc10NCnNjaGVkX3N0YXRfd2FpdDogY29tbT1TdXBlckFf
UlsxMzZdIHBpZD0xNTA3MSBkZWxheT00ODk5NTY5MiBbbnNdDQpzY2hlZF9zdGF0X3dhaXQ6IGNv
bW09U3VwZXJBX1JbMzRdIHBpZD0xNDk1MSBkZWxheT00MTg3NjMwOCBbbnNdDQoNCkFmdGVyIHRo
ZSBmaXgsIHRoZSByZWNvcmRlZCBydW5uYWJsZSB0aW1lcyBhcmUgd2l0aGluIGV4cGVjdGVkIHJh
bmdlcy4NCg0KRml4ZXM6IDc2OGQwYzI3MjI2ZSAoInNjaGVkOiBBZGQgd2FpdCwgc2xlZXAgYW5k
IGlvd2FpdCBhY2NvdW50aW5nIHRyYWNlcG9pbnRzIikNClNpZ25lZC1vZmYtYnk6IHhpYW5oZS56
aG91IDx4aWFuaGUuemhvdUB0cmFuc3Npb24uY29tPg0KLS0tDQprZXJuZWwvc2NoZWQvZmFpci5j
ICB8IDEzICsrKysrKystLS0tLS0NCmtlcm5lbC9zY2hlZC9ydC5jICAgIHwgMTUgKysrKysrKysr
KysrLS0tDQprZXJuZWwvc2NoZWQvc3RhdHMuYyB8ICA3ICsrKysrKy0NCjMgZmlsZXMgY2hhbmdl
ZCwgMjUgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9rZXJu
ZWwvc2NoZWQvZmFpci5jIGIva2VybmVsL3NjaGVkL2ZhaXIuYyBpbmRleCAxYzBlZjQzNWE3YWEu
LjM3YTMxNWIzOTA2YiAxMDA2NDQNCi0tLSBhL2tlcm5lbC9zY2hlZC9mYWlyLmMNCisrKyBiL2tl
cm5lbC9zY2hlZC9mYWlyLmMNCkBAIC0xMzMxLDExICsxMzMxLDEyIEBAIHVwZGF0ZV9zdGF0c19l
bnF1ZXVlX2ZhaXIoc3RydWN0IGNmc19ycSAqY2ZzX3JxLCBzdHJ1Y3Qgc2NoZWRfZW50aXR5ICpz
ZSwgaW50IGZsDQogICAgIGlmICghc2NoZWRzdGF0X2VuYWJsZWQoKSkNCiAgICAgICAgICAgIHJl
dHVybjsNCg0KLSAgICAgLyoNCi0gICAgICogQXJlIHdlIGVucXVldWVpbmcgYSB3YWl0aW5nIHRh
c2s/IChmb3IgY3VycmVudCB0YXNrcw0KLSAgICAgKiBhIGRlcXVldWUvZW5xdWV1ZSBldmVudCBp
cyBhIE5PUCkNCisgICAgLyoNCisgICAgICogQXJlIHdlIGVucXVldWVpbmcgYSB3YWl0aW5nIHRh
c2s/IEFuZCBpdCBpcyBub3QNCisgICAgICogYSB0ZW1wb3JhcnkgZW5xdWV1ZT8oZm9yIGN1cnJl
bnQgdGFza3MgYQ0KKyAgICAgKiBkZXF1ZXVlL2VucXVldWUgZXZlbnQgaXMgYSBOT1ApDQogICAg
ICAqLw0KLSAgICAgaWYgKHNlICE9IGNmc19ycS0+Y3VycikNCisgICAgIGlmIChzZSAhPSBjZnNf
cnEtPmN1cnIgJiYgIShmbGFncyAmIEVOUVVFVUVfUkVTVE9SRSkpDQogICAgICAgICAgICB1cGRh
dGVfc3RhdHNfd2FpdF9zdGFydF9mYWlyKGNmc19ycSwgc2UpOw0KDQogICAgICBpZiAoZmxhZ3Mg
JiBFTlFVRVVFX1dBS0VVUCkNCkBAIC0xMzUxLDkgKzEzNTIsOSBAQCB1cGRhdGVfc3RhdHNfZGVx
dWV1ZV9mYWlyKHN0cnVjdCBjZnNfcnEgKmNmc19ycSwgc3RydWN0IHNjaGVkX2VudGl0eSAqc2Us
IGludCBmbA0KDQogICAgICAvKg0KICAgICAgKiBNYXJrIHRoZSBlbmQgb2YgdGhlIHdhaXQgcGVy
aW9kIGlmIGRlcXVldWVpbmcgYQ0KLSAgICAgKiB3YWl0aW5nIHRhc2s6DQorICAgICAqIHdhaXRp
bmcgdGFzayBhbmQgaXQgaXMgbm90IGEgdGVtcG9yYXJ5IGRlcXVldWU6DQogICAgICAqLw0KLSAg
ICAgaWYgKHNlICE9IGNmc19ycS0+Y3VycikNCisgICAgIGlmIChzZSAhPSBjZnNfcnEtPmN1cnIg
JiYgIShmbGFncyAmIERFUVVFVUVfU0FWRSkpDQogICAgICAgICAgICB1cGRhdGVfc3RhdHNfd2Fp
dF9lbmRfZmFpcihjZnNfcnEsIHNlKTsNCg0KICAgICAgaWYgKChmbGFncyAmIERFUVVFVUVfU0xF
RVApICYmIGVudGl0eV9pc190YXNrKHNlKSkgeyBkaWZmIC0tZ2l0IGEva2VybmVsL3NjaGVkL3J0
LmMgYi9rZXJuZWwvc2NoZWQvcnQuYyBpbmRleCA0YjhlMzNjNjE1YjEuLjk5MTI1MWZlZWFmNiAx
MDA2NDQNCi0tLSBhL2tlcm5lbC9zY2hlZC9ydC5jDQorKysgYi9rZXJuZWwvc2NoZWQvcnQuYw0K
QEAgLTEzMTAsOSArMTMxMCwxNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgdXBkYXRlX3N0YXRzX2Vu
cXVldWVfcnQoc3RydWN0IHJ0X3JxICpydF9ycSwgc3RydWN0IHNjaGVkX3J0X2VudGl0eSAqcnRf
c2UsDQogICAgICAgICAgICAgICAgICAgaW50IGZsYWdzKQ0Kew0KKyAgICAgc3RydWN0IHRhc2tf
c3RydWN0ICpwID0gTlVMTDsNCisNCiAgICAgaWYgKCFzY2hlZHN0YXRfZW5hYmxlZCgpKQ0KICAg
ICAgICAgICAgcmV0dXJuOw0KDQorICAgICBpZiAocnRfZW50aXR5X2lzX3Rhc2socnRfc2UpKQ0K
KyAgICAgICAgICAgIHAgPSBydF90YXNrX29mKHJ0X3NlKTsNCisNCisgICAgIGlmIChwICE9IHJx
X29mX3J0X3JxKHJ0X3JxKS0+Y3VyciAmJiAhKGZsYWdzICYgRU5RVUVVRV9SRVNUT1JFKSkNCisg
ICAgICAgICAgICB1cGRhdGVfc3RhdHNfd2FpdF9zdGFydF9ydChydF9ycSwgcnRfc2UpOw0KKw0K
ICAgICBpZiAoZmxhZ3MgJiBFTlFVRVVFX1dBS0VVUCkNCiAgICAgICAgICAgIHVwZGF0ZV9zdGF0
c19lbnF1ZXVlX3NsZWVwZXJfcnQocnRfcnEsIHJ0X3NlKTsgfSBAQCAtMTM0OCw2ICsxMzU2LDEw
IEBAIHVwZGF0ZV9zdGF0c19kZXF1ZXVlX3J0KHN0cnVjdCBydF9ycSAqcnRfcnEsIHN0cnVjdCBz
Y2hlZF9ydF9lbnRpdHkgKnJ0X3NlLA0KICAgICBpZiAocnRfZW50aXR5X2lzX3Rhc2socnRfc2Up
KQ0KICAgICAgICAgICAgcCA9IHJ0X3Rhc2tfb2YocnRfc2UpOw0KDQorICAgICBpZiAocCAhPSBy
cV9vZl9ydF9ycShydF9ycSktPmN1cnIgJiYgIShmbGFncyAmIERFUVVFVUVfU0FWRSkpIHsNCisg
ICAgICAgICAgICB1cGRhdGVfc3RhdHNfd2FpdF9lbmRfcnQocnRfcnEsIHJ0X3NlKTsNCisgICAg
IH0NCisNCiAgICAgaWYgKChmbGFncyAmIERFUVVFVUVfU0xFRVApICYmIHApIHsNCiAgICAgICAg
ICAgIHVuc2lnbmVkIGludCBzdGF0ZTsNCg0KQEAgLTE0NzQsOSArMTQ4Niw2IEBAIGVucXVldWVf
dGFza19ydChzdHJ1Y3QgcnEgKnJxLCBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAsIGludCBmbGFncykN
CiAgICAgaWYgKGZsYWdzICYgRU5RVUVVRV9XQUtFVVApDQogICAgICAgICAgICBydF9zZS0+dGlt
ZW91dCA9IDA7DQoNCi0gICAgIGNoZWNrX3NjaGVkc3RhdF9yZXF1aXJlZCgpOw0KLSAgICAgdXBk
YXRlX3N0YXRzX3dhaXRfc3RhcnRfcnQocnRfcnFfb2Zfc2UocnRfc2UpLCBydF9zZSk7DQotDQog
ICAgIGVucXVldWVfcnRfZW50aXR5KHJ0X3NlLCBmbGFncyk7DQoNCiAgICAgIGlmICghdGFza19j
dXJyZW50KHJxLCBwKSAmJiBwLT5ucl9jcHVzX2FsbG93ZWQgPiAxKSBkaWZmIC0tZ2l0IGEva2Vy
bmVsL3NjaGVkL3N0YXRzLmMgYi9rZXJuZWwvc2NoZWQvc3RhdHMuYyBpbmRleCA0MzQ2ZmQ4MWMz
MWYuLjM2N2Y0YmIxYzc1OSAxMDA2NDQNCi0tLSBhL2tlcm5lbC9zY2hlZC9zdGF0cy5jDQorKysg
Yi9rZXJuZWwvc2NoZWQvc3RhdHMuYw0KQEAgLTIwLDggKzIwLDEzIEBAIHZvaWQgX191cGRhdGVf
c3RhdHNfd2FpdF9zdGFydChzdHJ1Y3QgcnEgKnJxLCBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAsIHZv
aWQgX191cGRhdGVfc3RhdHNfd2FpdF9lbmQoc3RydWN0IHJxICpycSwgc3RydWN0IHRhc2tfc3Ry
dWN0ICpwLA0KICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHNjaGVkX3N0YXRpc3RpY3Mg
KnN0YXRzKSB7DQotICAgICB1NjQgZGVsdGEgPSBycV9jbG9jayhycSkgLSBzY2hlZHN0YXRfdmFs
KHN0YXRzLT53YWl0X3N0YXJ0KTsNCisgICAgIHU2NCBkZWx0YTsNCisgICAgIHU2NCB3YWl0X3N0
YXJ0ID0gc2NoZWRzdGF0X3ZhbChzdGF0cy0+d2FpdF9zdGFydCk7DQoNCisgICAgIGlmICghd2Fp
dF9zdGFydCkNCisgICAgICAgICAgICByZXR1cm47DQorDQorICAgICBkZWx0YSA9IHJxX2Nsb2Nr
KHJxKSAtIHdhaXRfc3RhcnQ7DQogICAgIGlmIChwKSB7DQogICAgICAgICAgICBpZiAodGFza19v
bl9ycV9taWdyYXRpbmcocCkpIHsNCiAgICAgICAgICAgICAgICAgICAvKg0KLS0NCjIuMzQuMQ0K

