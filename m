Return-Path: <linux-kernel+bounces-548140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8D5A540BE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 03:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EAB53AEEDB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 02:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A95518DF89;
	Thu,  6 Mar 2025 02:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="RjWTFZSl"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2095.outbound.protection.outlook.com [40.107.215.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1C018DB18
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 02:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741228763; cv=fail; b=fz59QBy9GPuKPLtStEn5QuJ/k93OdChQak3DbXiHjM+oXNn1F0q06kQiIRIA35KjisaS3/XZxkEIvU7Ez1nEPDHYXw9zfnQS9X8zzcsrAhcmpWMkyknvjj/WqqZCQb5xvnjfBrUrpF4moBax0LrkqAKnnynF22ik+C5rhwsgDrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741228763; c=relaxed/simple;
	bh=FaIii2dH5C58THtEYIoWgIRyFaz4Hnc6jY9tIaw/JF4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gFoX7Pe8PTTIeUBfkZsdeKp7TN75pC9X3eL07f3vMp/Nkv272x+RsRKSKm3HgaJeoftR77LjNjeJVvPL+8/T5CXWnJMcRDt6pSs+2NE2shuv3w7oX98EoJQ6GpKc2S5mX7APdj8OkVQVvNLp3YhZMiIQ8MxeGM0tgH0vodWeOCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=RjWTFZSl; arc=fail smtp.client-ip=40.107.215.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TyyUB+exP26ciEb42ZcjC9Cmh6uyS5zHGsX+7e/81wyyjnD2/K52YgfbmOAR85CQgT3J3QpGv6uQv5TE9QayxgGWyxUQZat8kXWLWvn6dSbwBueE0bw4AVoojSZAazzx9cW8nSN3a7UoxY1hPN/y+IPoJEi/zCAMJrlO3KgMBwe01mOYwWfg/JF+eQWzSXYdXfYhfm1vkbZaulv9BG8kSYrABq0oWIuySX56KOpyDRAuuCmFcHKArPEBJe1rpDA1AQmQwF+9Wft+RWALYpUhUXyprvHuiWeL0yKAD6tEz+h7zdDysmmeyP1iUfCdtbh6bTyZS8ANA9aPJcQJILuypw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaIii2dH5C58THtEYIoWgIRyFaz4Hnc6jY9tIaw/JF4=;
 b=R5B0eUTgQXe8RVQvceoJdskGMuNYEPtNIUgJIs1APcPy4FyIu2fWbPnwYK38fQ5dTOq9JCUlYIQBDzia2FWrhWXppOvZamfE9UKTxLhE4LrL2v9YsHZuq+KhnG/GBgxHxbnYqENopbIF2jOBWddX1vUtYNKXXs9cnZpKi0RcT49tbHTwjOkV2eFPgOFXgCImXv+OJ5h+rgOF7EtH3feGVTi+zNTprQ4pq8zZT3whJlyf4pQJvt2N+5rwWh/FRQOMVSw0RTRrGViRq3RCu3+P5Z97yLsy4If8D4YVH0IqJWRmJiLG604bl5wQ64qQhkiaWwayDMFRcC/L7UR4PdV1Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 58.246.63.154) smtp.rcpttodomain=redhat.com smtp.mailfrom=transsion.com;
 dmarc=none action=none header.from=transsion.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaIii2dH5C58THtEYIoWgIRyFaz4Hnc6jY9tIaw/JF4=;
 b=RjWTFZSlvNmy0BMDq76b9N4rYlH3wlYEI6+X4b4MK/2+mrscUUjMBgkTABOo4PvvrNDgN5f2xdwHVBhCsBW5b9lO2YNiee6SOafcXHyh7DaQy6bTv2VjZgDSys8mdUACm3NjyeNqUGseS+x6U+pTWoeMnlG4mJC+fXQ5CzhfB2c=
Received: from SG2PR01CA0162.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::18) by KL1PR04MB6898.apcprd04.prod.outlook.com
 (2603:1096:820:d0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 02:39:14 +0000
Received: from SG1PEPF000082E2.apcprd02.prod.outlook.com
 (2603:1096:4:28:cafe::e3) by SG2PR01CA0162.outlook.office365.com
 (2603:1096:4:28::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.19 via Frontend Transport; Thu,
 6 Mar 2025 02:39:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 58.246.63.154)
 smtp.mailfrom=transsion.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
Received-SPF: Fail (protection.outlook.com: domain of transsion.com does not
 designate 58.246.63.154 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.246.63.154; helo=mail.transsion.com;
Received: from mail.transsion.com (58.246.63.154) by
 SG1PEPF000082E2.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 02:39:14 +0000
Received: from SH-EXC-MX06.transsion.com (10.150.2.44) by
 SH-EXC-MX05.transsion.com (10.150.2.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2507.44; Thu, 6 Mar 2025 10:39:13 +0800
Received: from SH-EXC-MX06.transsion.com ([fe80::954b:3df8:a403:9ca3]) by
 SH-EXC-MX06.transsion.com ([fe80::954b:3df8:a403:9ca3%12]) with mapi id
 15.01.2507.044; Thu, 6 Mar 2025 10:39:13 +0800
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
Thread-Index: AduOQIVtb7ajYxqPRD276HtouTmwtA==
Date: Thu, 6 Mar 2025 02:39:13 +0000
Message-ID: <98cac8ca355d4aad963deb52a427fa2c@transsion.com>
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
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E2:EE_|KL1PR04MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b696f1c-a58c-44bc-e648-08dd5c581578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?gb2312?B?cDVjYTMrcFZEMGxQQVRhMDNLTnBtRGwzU2kvNUtibGJsN29yakEwMytpQ2Vz?=
 =?gb2312?B?Y0FZVHo4THRodEo5Qi9ERExrM3BNa1duejhlWk9vRXFvWWFMaG9uMmZiMGNJ?=
 =?gb2312?B?QkcyQzVUN2c1NG9SSzZzUFNVVU9WMmNpUUVtbkVkZmRFanlhcWJkaGt3bHR5?=
 =?gb2312?B?U0VLM1dPeEFGcENaVU9Hemp4TEFTdjlqR2RkTjFDeExTN2Q0dlNFbUpNUnpi?=
 =?gb2312?B?S2RSdmEzTHpxRUh5NjNkdmZUS0ptanFPZ0VZL0tnWlFEdzQ3V3FOcTBVTVlk?=
 =?gb2312?B?dE5kYXB6U2cwSzNRdy8rNUdSbWcrOXJYQ2NjNWlQZDBJNnlwOTJPUDZ3MGFW?=
 =?gb2312?B?TmlBbDlSMEY3WngrWFZuQnlIcWJtK3Y5emRzVTM0alFuVU56MEtGL2V2NE5F?=
 =?gb2312?B?S1ZrOWZyOVo1aUxTTWdtVmpLU2RUQW5kdnR3NERLTm84MUJNdERvbGc4aXdP?=
 =?gb2312?B?ZVVMc28yZEdyOVdiRkYxTWc0Uk9NM3RoVjg5dTU2cHZOMTk2ck1XcTlTMHh0?=
 =?gb2312?B?dVJIbVFlVE9Qd3JwS04rMUoyeVFWcmxISmVwSTRpaFczTWZvdGR1eE81UFlY?=
 =?gb2312?B?bDVhVFdIajZxbTgwZUhXMkozY1hnL0FXYWxIbU9vd25YTnNuTlVkdHprdjZE?=
 =?gb2312?B?RlNOdnJpcGZNM0pYb2dQK1RJSzZqejRPd3FHZkh0ZlRZMjFWOFFvaFpmbkh5?=
 =?gb2312?B?dW5ndWRkSjlVRnp3UVloWVV0TWcrOVBweHFJbTIzSy81Q01POE12N2h3SVcv?=
 =?gb2312?B?RnFMVWt3TGtjQU1adk9hZnJXSzVCUjlxM0tsU1ExZTQyZDYrTVpyU21mSkpu?=
 =?gb2312?B?aEhMalBxd0lKS0ZzdnExVjF2eW82aWZQbjloZjNudFFmVHRGMWJOZ3J0T0Zs?=
 =?gb2312?B?aHRadWZnaHVQTnNVT043Lzk4Y1h0SUlxcWkzN0tvS2ZDSXBKZ29iVDVRZ2Vq?=
 =?gb2312?B?NTJ1UEpLcHZmYmEwZUQwdkp0cndxaW1uTXdDMmdmdy9Hb2dhQ21tRUpseFJ2?=
 =?gb2312?B?SmtGQmxtR3p3azlxQlJuZUlPYWFnRmpPa1dDcXdjcERkSVJDQUFnc2J2Qm85?=
 =?gb2312?B?clYvV1BRRDZRZmhzWldxZGxiNzhmMW1LTTljQ0t4eEFUNmIwdEQyTVhSZmhj?=
 =?gb2312?B?bGYvQWN5ZDE0c200Y25COUVZamxxRXo3OU5MazdNRHFHcW1odm9NVjBpc2p3?=
 =?gb2312?B?cUs2dXFESEhqRHg2L29RWVZ2bktHWU9NWjhnM0VMQWZrKzJnVmxPQUkvUlVE?=
 =?gb2312?B?L01MNGlmajd1YjEyWTlOd3BJYUdjSm0xRk4rQzhoRjM2aDFUdlFFVDJ6VXov?=
 =?gb2312?B?MERFYytIdmZsMHBYbXJQUVdyQ3RNUVNzY1g1WFpRNWhRNTVtMmJxMk1CSmxj?=
 =?gb2312?B?U3l0VEVjOVFYejUwdy91aittcE16YXJTR0x0SVZTZ3kzMjlPeEZuc0tmanB6?=
 =?gb2312?B?eVF0UERoMG82eWdvSVNyUzNYV0d4NWpWVkZLdHJGdVJpcWs2UExydlpkQ3Zj?=
 =?gb2312?B?ODBFdmNURWZyWVFqNUtpUmxrWE9QQitUd3NnaUV3YkZuays3K3FPaWtsbDRr?=
 =?gb2312?B?aG5HaCtqNHkvNHBsL05WVUh2NW9iV1p4SGFFOG1OU3p5Q0dnaExxVjgzM0JE?=
 =?gb2312?B?YlhaZDBYL0FvWWt2L2dPeWNoWFo5d1BJTVlBSkVsWkRRclQ2ejhLUmFHb25u?=
 =?gb2312?B?akJ6N3FTRGkrc2xTUXQzWEg4dk51K3lMcERBVWVrVWgwQmNoMkx0aXpuMEtG?=
 =?gb2312?B?d3FwUi90VVVCWjArbHRuVmhMTEhNekEydEhNdFI0bGtSKzJZZG53RVZ3WnUy?=
 =?gb2312?B?MHR3elc2TTlLaTB0bVlpR0x2Y05XYkJwT2tPSjRkVGYwbENqTDNBRytNRHY4?=
 =?gb2312?B?TUhIL0R6TjFOYzIzamQ4VnhhTDdxeE5sMzFCVGYxUFdZQklhK0ZEU1MrSkN2?=
 =?gb2312?B?OW5aRDJLN1J5SGV5Z2FDaGlxdks1d3BweXlRWlJtczRmM0swaFd4M3ZRaXJP?=
 =?gb2312?Q?cV9rw59GapKuuu+eP56KYXqNu7N9A8=3D?=
X-Forefront-Antispam-Report:
	CIP:58.246.63.154;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.transsion.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 02:39:14.2194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b696f1c-a58c-44bc-e648-08dd5c581578
X-MS-Exchange-CrossTenant-Id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2;Ip=[58.246.63.154];Helo=[mail.transsion.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB6898

RnJvbSBiMDdkZjNlZDNmZDIxODZhNjk4ZWY4N2FkMzY2NTIzZWM3YzdmY2NiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogInhpYW5oZS56aG91IiA8eGlhbmhlLnpob3VAdHJhbnNzaW9u
LmNvbT4NCkRhdGU6IFRodSwgMjAgRmViIDIwMjUgMjI6MDE6MjYgKzA4MDANClN1YmplY3Q6IFtQ
QVRDSF0gc2NoZWQ6IEZpeCBpbmNvcnJlY3QgcnVubmFibGUgdGltZSBjYWxjdWxhdGlvbiBpbg0K
IHNjaGVkX3N0YXRfd2FpdCB0cmFjZXBvaW50DQoNClRoZSBzY2hlZF9zdGF0X3dhaXQgdHJhY2Vw
b2ludCBpcyBpbnRlbmRlZCB0byByZWNvcmQgdGhlIHJ1bm5hYmxlDQp0aW1lIG9mIGEgdGFzay4g
SG93ZXZlciwgZHVlIHRvIGluY29ycmVjdCB0aW1lc3RhbXAgaGFuZGxpbmcsIHR3byBtYWpvcg0K
aXNzdWVzIGFyaXNlOg0KDQoxLiBUaGUgdHJhY2Vwb2ludCBtYXkgaW5jb3JyZWN0bHkgcmVjb3Jk
IGNvbnNlY3V0aXZlIHN0YXJ0IHRpbWVzdGFtcHMNCiAgIG9yIGNvbnNlY3V0aXZlIGVuZCB0aW1l
c3RhbXBzLCByYXRoZXIgdGhhbiBwcm9wZXJseSBwYWlyaW5nIHRoZW0uDQogICBUaGlzIGxlYWRz
IHRvIGluY29ycmVjdCBydW5uYWJsZSB0aW1lIGNhbGN1bGF0aW9ucy4NCjIuIFRoZSByZWNvcmRl
ZCB0aW1lIG1heSBpbmNsdWRlIHRlbXBvcmFyeSBkZXF1ZXVpbmcgYW5kIGVucXVldWluZw0KICAg
ZXZlbnRzLCBzdWNoIGFzIHdoZW4gbW9kaWZ5aW5nIGEgdGFzaydzIG5pY2UgdmFsdWUgd2hpbGUg
aXQgaXMgcnVubmluZy4NCg0KVGhpcyBwYXRjaCBlbnN1cmVzIHRoYXQgdGltZXN0YW1wcyBhcmUg
cHJvcGVybHkgcGFpcmVkIGFuZCBleGNsdWRlcw0KdGVtcG9yYXJ5IGRlcXVldWluZyBldmVudHMg
dG8gcHJldmVudCBpbmNvcnJlY3QgbWVhc3VyZW1lbnRzLg0KDQpUZXN0aW5nOg0KVGhpcyBpc3N1
ZSB3YXMgdGVzdGVkIG9uIGFuIEFuZHJvaWQgMTQgZGV2aWNlLiBUaGUgZm9sbG93aW5nIGFyZSB0
aGUNCnRyYWNlIHJlc3VsdHMgYmVmb3JlIGFuZCBhZnRlciBhcHBseWluZyB0aGUgcGF0Y2g6DQoN
CkJlZm9yZSB0aGUgZml4IChpbmNvcnJlY3QgdmFsdWVzKToNCg0Kc2NoZWRfc3RhdF93YWl0OiBj
b21tPU92ZXJsYXlFbmdpbmVfMCBwaWQ9MTUzMyBkZWxheT0zNTI0MTgzMTU4MzkgW25zXQ0Kc2No
ZWRfc3RhdF93YWl0OiBjb21tPU92ZXJsYXlFbmdpbmVfMCBwaWQ9MTUzMyBkZWxheT0zNTI0MDk5
NjE4NDAgW25zXQ0Kc2NoZWRfc3RhdF93YWl0OiBjb21tPU92ZXJsYXlFbmdpbmVfMCBwaWQ9MTUz
MyBkZWxheT0zNTIzOTMzMTc0NTUgW25zXQ0Kc2NoZWRfc3RhdF93YWl0OiBjb21tPWJpbmRlcjox
MTQ4XzMgcGlkPTIxMDIgZGVsYXk9MzUyMzgwNDkzMzc3IFtuc10NCnNjaGVkX3N0YXRfd2FpdDog
Y29tbT1PdmVybGF5RW5naW5lXzAgcGlkPTE1MzMgZGVsYXk9MzUyMzYwMDMzMzc3IFtuc10NCg0K
Q2xlYXJseSwgdGhlc2UgcnVubmFibGUgdGltZSB2YWx1ZXMsIGluIHRoZSBodW5kcmVkcyBvZiBz
ZWNvbmRzLA0KYXJlIGluY29ycmVjdC4NCg0KQWZ0ZXIgdGhlIGZpeCAoY29ycmVjdGVkIHZhbHVl
cyk6DQoNCnNjaGVkX3N0YXRfd2FpdDogY29tbT1rd29ya2VyLzc6MSBwaWQ9MTM2ODIgZGVsYXk9
NjM1MTY5MjMgW25zXQ0Kc2NoZWRfc3RhdF93YWl0OiBjb21tPVN1cGVyQV9SWzEzNl0gcGlkPTE1
MDc0IGRlbGF5PTUxMzI0Mzg1IFtuc10NCnNjaGVkX3N0YXRfd2FpdDogY29tbT1TdXBlckFfUlsx
MzZdIHBpZD0xNTA4MCBkZWxheT01MDI4MDUzOSBbbnNdDQpzY2hlZF9zdGF0X3dhaXQ6IGNvbW09
U3VwZXJBX1JbMTM2XSBwaWQ9MTUwNzEgZGVsYXk9NDg5OTU2OTIgW25zXQ0Kc2NoZWRfc3RhdF93
YWl0OiBjb21tPVN1cGVyQV9SWzM0XSBwaWQ9MTQ5NTEgZGVsYXk9NDE4NzYzMDggW25zXQ0KDQpB
ZnRlciB0aGUgZml4LCB0aGUgcmVjb3JkZWQgcnVubmFibGUgdGltZXMgYXJlIHdpdGhpbiBleHBl
Y3RlZCByYW5nZXMuDQoNCkZpeGVzOiA3NjhkMGMyNzIyNmUgKCJzY2hlZDogQWRkIHdhaXQsIHNs
ZWVwIGFuZCBpb3dhaXQgYWNjb3VudGluZyB0cmFjZXBvaW50cyIpDQpTaWduZWQtb2ZmLWJ5OiB4
aWFuaGUuemhvdSA8eGlhbmhlLnpob3VAdHJhbnNzaW9uLmNvbT4NCi0tLQ0KIGtlcm5lbC9zY2hl
ZC9mYWlyLmMgIHwgMTMgKysrKysrKy0tLS0tLQ0KIGtlcm5lbC9zY2hlZC9ydC5jICAgIHwgMTUg
KysrKysrKysrKysrLS0tDQoga2VybmVsL3NjaGVkL3N0YXRzLmMgfCAgNyArKysrKystDQogMyBm
aWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCg0KZGlmZiAt
LWdpdCBhL2tlcm5lbC9zY2hlZC9mYWlyLmMgYi9rZXJuZWwvc2NoZWQvZmFpci5jDQppbmRleCAx
YzBlZjQzNWE3YWEuLjM3YTMxNWIzOTA2YiAxMDA2NDQNCi0tLSBhL2tlcm5lbC9zY2hlZC9mYWly
LmMNCisrKyBiL2tlcm5lbC9zY2hlZC9mYWlyLmMNCkBAIC0xMzMxLDExICsxMzMxLDEyIEBAIHVw
ZGF0ZV9zdGF0c19lbnF1ZXVlX2ZhaXIoc3RydWN0IGNmc19ycSAqY2ZzX3JxLCBzdHJ1Y3Qgc2No
ZWRfZW50aXR5ICpzZSwgaW50IGZsDQogCWlmICghc2NoZWRzdGF0X2VuYWJsZWQoKSkNCiAJCXJl
dHVybjsNCiANCi0JLyoNCi0JICogQXJlIHdlIGVucXVldWVpbmcgYSB3YWl0aW5nIHRhc2s/IChm
b3IgY3VycmVudCB0YXNrcw0KLQkgKiBhIGRlcXVldWUvZW5xdWV1ZSBldmVudCBpcyBhIE5PUCkN
CisgICAgLyoNCisgICAgICogQXJlIHdlIGVucXVldWVpbmcgYSB3YWl0aW5nIHRhc2s/IEFuZCBp
dCBpcyBub3QNCisgICAgICogYSB0ZW1wb3JhcnkgZW5xdWV1ZT8oZm9yIGN1cnJlbnQgdGFza3Mg
YQ0KKyAgICAgKiBkZXF1ZXVlL2VucXVldWUgZXZlbnQgaXMgYSBOT1ApDQogCSAqLw0KLQlpZiAo
c2UgIT0gY2ZzX3JxLT5jdXJyKQ0KKwlpZiAoc2UgIT0gY2ZzX3JxLT5jdXJyICYmICEoZmxhZ3Mg
JiBFTlFVRVVFX1JFU1RPUkUpKQ0KIAkJdXBkYXRlX3N0YXRzX3dhaXRfc3RhcnRfZmFpcihjZnNf
cnEsIHNlKTsNCiANCiAJaWYgKGZsYWdzICYgRU5RVUVVRV9XQUtFVVApDQpAQCAtMTM1MSw5ICsx
MzUyLDkgQEAgdXBkYXRlX3N0YXRzX2RlcXVldWVfZmFpcihzdHJ1Y3QgY2ZzX3JxICpjZnNfcnEs
IHN0cnVjdCBzY2hlZF9lbnRpdHkgKnNlLCBpbnQgZmwNCiANCiAJLyoNCiAJICogTWFyayB0aGUg
ZW5kIG9mIHRoZSB3YWl0IHBlcmlvZCBpZiBkZXF1ZXVlaW5nIGENCi0JICogd2FpdGluZyB0YXNr
Og0KKwkgKiB3YWl0aW5nIHRhc2sgYW5kIGl0IGlzIG5vdCBhIHRlbXBvcmFyeSBkZXF1ZXVlOg0K
IAkgKi8NCi0JaWYgKHNlICE9IGNmc19ycS0+Y3VycikNCisJaWYgKHNlICE9IGNmc19ycS0+Y3Vy
ciAmJiAhKGZsYWdzICYgREVRVUVVRV9TQVZFKSkNCiAJCXVwZGF0ZV9zdGF0c193YWl0X2VuZF9m
YWlyKGNmc19ycSwgc2UpOw0KIA0KIAlpZiAoKGZsYWdzICYgREVRVUVVRV9TTEVFUCkgJiYgZW50
aXR5X2lzX3Rhc2soc2UpKSB7DQpkaWZmIC0tZ2l0IGEva2VybmVsL3NjaGVkL3J0LmMgYi9rZXJu
ZWwvc2NoZWQvcnQuYw0KaW5kZXggNGI4ZTMzYzYxNWIxLi45OTEyNTFmZWVhZjYgMTAwNjQ0DQot
LS0gYS9rZXJuZWwvc2NoZWQvcnQuYw0KKysrIGIva2VybmVsL3NjaGVkL3J0LmMNCkBAIC0xMzEw
LDkgKzEzMTAsMTcgQEAgc3RhdGljIGlubGluZSB2b2lkDQogdXBkYXRlX3N0YXRzX2VucXVldWVf
cnQoc3RydWN0IHJ0X3JxICpydF9ycSwgc3RydWN0IHNjaGVkX3J0X2VudGl0eSAqcnRfc2UsDQog
CQkJaW50IGZsYWdzKQ0KIHsNCisJc3RydWN0IHRhc2tfc3RydWN0ICpwID0gTlVMTDsNCisNCiAJ
aWYgKCFzY2hlZHN0YXRfZW5hYmxlZCgpKQ0KIAkJcmV0dXJuOw0KIA0KKwlpZiAocnRfZW50aXR5
X2lzX3Rhc2socnRfc2UpKQ0KKwkJcCA9IHJ0X3Rhc2tfb2YocnRfc2UpOw0KKw0KKwlpZiAocCAh
PSBycV9vZl9ydF9ycShydF9ycSktPmN1cnIgJiYgIShmbGFncyAmIEVOUVVFVUVfUkVTVE9SRSkp
DQorCQl1cGRhdGVfc3RhdHNfd2FpdF9zdGFydF9ydChydF9ycSwgcnRfc2UpOw0KKw0KIAlpZiAo
ZmxhZ3MgJiBFTlFVRVVFX1dBS0VVUCkNCiAJCXVwZGF0ZV9zdGF0c19lbnF1ZXVlX3NsZWVwZXJf
cnQocnRfcnEsIHJ0X3NlKTsNCiB9DQpAQCAtMTM0OCw2ICsxMzU2LDEwIEBAIHVwZGF0ZV9zdGF0
c19kZXF1ZXVlX3J0KHN0cnVjdCBydF9ycSAqcnRfcnEsIHN0cnVjdCBzY2hlZF9ydF9lbnRpdHkg
KnJ0X3NlLA0KIAlpZiAocnRfZW50aXR5X2lzX3Rhc2socnRfc2UpKQ0KIAkJcCA9IHJ0X3Rhc2tf
b2YocnRfc2UpOw0KIA0KKwlpZiAocCAhPSBycV9vZl9ydF9ycShydF9ycSktPmN1cnIgJiYgIShm
bGFncyAmIERFUVVFVUVfU0FWRSkpIHsNCisJCXVwZGF0ZV9zdGF0c193YWl0X2VuZF9ydChydF9y
cSwgcnRfc2UpOw0KKwl9DQorDQogCWlmICgoZmxhZ3MgJiBERVFVRVVFX1NMRUVQKSAmJiBwKSB7
DQogCQl1bnNpZ25lZCBpbnQgc3RhdGU7DQogDQpAQCAtMTQ3NCw5ICsxNDg2LDYgQEAgZW5xdWV1
ZV90YXNrX3J0KHN0cnVjdCBycSAqcnEsIHN0cnVjdCB0YXNrX3N0cnVjdCAqcCwgaW50IGZsYWdz
KQ0KIAlpZiAoZmxhZ3MgJiBFTlFVRVVFX1dBS0VVUCkNCiAJCXJ0X3NlLT50aW1lb3V0ID0gMDsN
CiANCi0JY2hlY2tfc2NoZWRzdGF0X3JlcXVpcmVkKCk7DQotCXVwZGF0ZV9zdGF0c193YWl0X3N0
YXJ0X3J0KHJ0X3JxX29mX3NlKHJ0X3NlKSwgcnRfc2UpOw0KLQ0KIAllbnF1ZXVlX3J0X2VudGl0
eShydF9zZSwgZmxhZ3MpOw0KIA0KIAlpZiAoIXRhc2tfY3VycmVudChycSwgcCkgJiYgcC0+bnJf
Y3B1c19hbGxvd2VkID4gMSkNCmRpZmYgLS1naXQgYS9rZXJuZWwvc2NoZWQvc3RhdHMuYyBiL2tl
cm5lbC9zY2hlZC9zdGF0cy5jDQppbmRleCA0MzQ2ZmQ4MWMzMWYuLjM2N2Y0YmIxYzc1OSAxMDA2
NDQNCi0tLSBhL2tlcm5lbC9zY2hlZC9zdGF0cy5jDQorKysgYi9rZXJuZWwvc2NoZWQvc3RhdHMu
Yw0KQEAgLTIwLDggKzIwLDEzIEBAIHZvaWQgX191cGRhdGVfc3RhdHNfd2FpdF9zdGFydChzdHJ1
Y3QgcnEgKnJxLCBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAsDQogdm9pZCBfX3VwZGF0ZV9zdGF0c193
YWl0X2VuZChzdHJ1Y3QgcnEgKnJxLCBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAsDQogCQkJICAgICBz
dHJ1Y3Qgc2NoZWRfc3RhdGlzdGljcyAqc3RhdHMpDQogew0KLQl1NjQgZGVsdGEgPSBycV9jbG9j
ayhycSkgLSBzY2hlZHN0YXRfdmFsKHN0YXRzLT53YWl0X3N0YXJ0KTsNCisJdTY0IGRlbHRhOw0K
Kwl1NjQgd2FpdF9zdGFydCA9IHNjaGVkc3RhdF92YWwoc3RhdHMtPndhaXRfc3RhcnQpOw0KIA0K
KwlpZiAoIXdhaXRfc3RhcnQpDQorCQlyZXR1cm47DQorDQorCWRlbHRhID0gcnFfY2xvY2socnEp
IC0gd2FpdF9zdGFydDsNCiAJaWYgKHApIHsNCiAJCWlmICh0YXNrX29uX3JxX21pZ3JhdGluZyhw
KSkgew0KIAkJCS8qDQotLSANCjIuMzQuMQ0KDQo=

