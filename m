Return-Path: <linux-kernel+bounces-523925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAC4A3DCE2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B94B1887111
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B891F754A;
	Thu, 20 Feb 2025 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="w9frWzvm"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023142.outbound.protection.outlook.com [40.107.44.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1911028EA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061975; cv=fail; b=ZYmAjJGJVyRE3ITFQyX8/VrRuVVzLEtBItu3A+DRlDTZii7xys0Np08xGByaHQn/2pL9fPW65PxXQxql+Koe01ptPJh95m8zUVeSZwzRiT7TADybkJbcAZvvW+CFexvSwQEr7Pv/6aOdOdetOBejfNeZ+LHOzcu+F6m/hsQq3wA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061975; c=relaxed/simple;
	bh=1OPYxmhnZjQwU0AF61XcxUJEzl2iA45dMMoojQKSW0E=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tmu6XWWdlj6b6RwMDOmzSmoPSDgZRdgA/qeyvuHJ8b7mTMlOPCWw3sIcvzB1IaRGAW/bsupbfIGF5BQBCv90GBnHs3myxxyD42XRc9SQIkreHd52Ey9J4lR93pqJbV67N2A1v/h44lMFh5mxTWpOgxpI8UkFl140DRZRbtPZH2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=w9frWzvm; arc=fail smtp.client-ip=40.107.44.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJL0M0CTmaD8ccXCoFVMOZAlLjerlRoDw7IEBmIEMSxe5AHNXlQsx1KFHCzcyLz468eSSdTrqBniCdenUUGvIZlTw8ZhJi5BKDVNmnbPx9MfRqLAhWBgSbDAwW6eGXn88azS+UHiJhUlrZrxJG8pq1uhpCzEg3OQZdUKdixkwGqq7/8+c2XO4HM1jJIfdZJEVXWwXPBbrPenj4V22sHNoKUzLwFnvW+AveinULQLzNZyju0jEqq7sZ+tqUmBf9A57qM0m5EroWm6aYnT1I+3PrjVRxDcA8JJL5HJbBdhbYCiSxD83+VxXJRGocMaDkSTaM5nFxL76Rbz4eGAtI2+fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OPYxmhnZjQwU0AF61XcxUJEzl2iA45dMMoojQKSW0E=;
 b=uSUwuqEyXjuMLl4EiBDharUFNg20zr5zPle4cxyyYswWMFlfseloOk7QrjfJlboCSWTAB8IOp40l5evJEfLeax7lRtvK4y6a+hCc80gjiEbV7p8OzoAhLIbG/ZVaX8ZEeGZjmLh6h6pkbcS6zHu7G2J3hR1bsR6/h22pe7wHzVVsTXJ/eIECxvm+eRhVvU0SseHzu58Xu+MMjIpfecwWjwaWizlIdOc8xj5wynyjFvI2nBT25Qlp7OqqvxI7ex8OkjNQjDVaLezC0X7PKVAGeuVbAQdWSN2zV1QV6+YRLLxQxX61fGCpOG7yCIoCiD/j4U8bVD3dIZxMX7Z5/JKLmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 58.246.63.154) smtp.rcpttodomain=redhat.com smtp.mailfrom=transsion.com;
 dmarc=none action=none header.from=transsion.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OPYxmhnZjQwU0AF61XcxUJEzl2iA45dMMoojQKSW0E=;
 b=w9frWzvm5jPL/Fq68AGQ7ZTyfbS0B8gU1dszY4rWsxZ+W0BkoPbajy1uvY5/6/EQlEHkWMMhNDXYmq/ZchNzD9xki1IwGanx3vhbKwgK8TLaWGJ1VewY3sLUbSw1/Mr8JxqegY1z+/Aci5Xmcx5vEIYYoZGaPvrXM+J1ZIjKwnU=
Received: from SI2P153CA0027.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::22) by
 TYZPR04MB7726.apcprd04.prod.outlook.com (2603:1096:405:6c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.15; Thu, 20 Feb 2025 14:32:48 +0000
Received: from SG2PEPF000B66C9.apcprd03.prod.outlook.com
 (2603:1096:4:190:cafe::66) by SI2P153CA0027.outlook.office365.com
 (2603:1096:4:190::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.8 via Frontend Transport; Thu,
 20 Feb 2025 14:32:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 58.246.63.154)
 smtp.mailfrom=transsion.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
Received-SPF: Fail (protection.outlook.com: domain of transsion.com does not
 designate 58.246.63.154 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.246.63.154; helo=mail.transsion.com;
Received: from mail.transsion.com (58.246.63.154) by
 SG2PEPF000B66C9.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 14:32:47 +0000
Received: from SH-EXC-MX06.transsion.com (10.150.2.44) by
 SH-EXC-MX03.transsion.com (10.150.2.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2507.44; Thu, 20 Feb 2025 22:32:46 +0800
Received: from SH-EXC-MX06.transsion.com ([fe80::954b:3df8:a403:9ca3]) by
 SH-EXC-MX06.transsion.com ([fe80::954b:3df8:a403:9ca3%12]) with mapi id
 15.01.2507.044; Thu, 20 Feb 2025 22:32:47 +0800
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
Subject: [PATCH] sched: Fix incorrect runnable time calculation in
 sched_stat_wait tracepoint
Thread-Topic: [PATCH] sched: Fix incorrect runnable time calculation in
 sched_stat_wait tracepoint
Thread-Index: AduDpDBefAeZFjAmToakS6U99Gtdug==
Date: Thu, 20 Feb 2025 14:32:46 +0000
Message-ID: <40fe38e2c9594608849785c4d4d2a6d7@transsion.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66C9:EE_|TYZPR04MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 04f0385f-9e54-48de-1b42-08dd51bb72a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?gb2312?B?cklwOWpGNTdBOU1VcEVxOHNXK3FKdWNGYWR1MFVwNE9DSzVPS09wbjEwYmh0?=
 =?gb2312?B?Ty8wc1ZUbzJqeHliZUpzeVhJZk1OVUErOWs4R25IQXQ5MEd3UXY5ZmhKd2lm?=
 =?gb2312?B?Z1d0c2RRY3hTU2ZpanNvV1BmclhrY3RvY1YrVWkwdmZTbVoyblhxa2EvaVJL?=
 =?gb2312?B?ODdrTU0yWmw0bmxTQVFPWFFFc1hTUkt2azdHRW1vYUluMWY2ckRrQXU0eHZJ?=
 =?gb2312?B?d3hieDVTRVFRY2hKR1NwSU9EODlJdUVzd2t4YzVtaHdETmVjdHZTUXMxVFh2?=
 =?gb2312?B?Z2RjRkYrZThOVUhkSTR5dk9jYmIrakt4WDFDMVVCYTZDZDVkdFNNbkQrbW5P?=
 =?gb2312?B?ZGdtYUZSVDJ2MzR3VkJqeWN5WWJCNjkrU2RPeFhVUzEwelY2dUZrN00yVG1m?=
 =?gb2312?B?UElraXgrekpPRkZzbmpvRGp4WWhnN1plYkpzRGhKMDFieTVpeGpTSXNwb00v?=
 =?gb2312?B?K3VSNVgydjdiZHo1eGhMdTBNN01aQUhxZ01peUl3dWEwYlBpU2NNZjVJWnBw?=
 =?gb2312?B?Y2tMd3ErajNncTdIbExjSWtCeVRJRzhNa2RkWWxtV2Z0UENwclpxdnc4N09z?=
 =?gb2312?B?YndNaXNtczFPVWVNcFY1bEptQWgraGRwKzFXbE80ZWtrTlJNMzN5K0F1bFN1?=
 =?gb2312?B?Q0ZDeGpPNjRRRVF3SDY0M0FvckMzU2c4eDVIMjRoOWtVR2VqL1hFY0V1T253?=
 =?gb2312?B?SG0wdVpuZ2xkU1RBb2c2NlVDUDFRL3ExQ3Z1bThQd0RKMklhWjV0TUhBZFlH?=
 =?gb2312?B?V29yNGkwVXMzbmE2MVlSVXhJNmxGVWt5VU1yRExjcnhQNzFWSTRPOEhOTEVm?=
 =?gb2312?B?OG5LOG9vVXZsYmdXT3hZSlZFVjhuSytaRTRncWFFK1ViVUlMWjVvcGdQZVMv?=
 =?gb2312?B?WVZVTDVEbDQvUTdoVk44OGkyeVlGcm9jU040MnRCVDY3VmdDVFVuSUI5eTFr?=
 =?gb2312?B?ZEc1Yy9JSmxRVWg1SmUwSHZuM0cvaWtvSmQ4OGRFdlAzTW1TMGMwb3RZa2RH?=
 =?gb2312?B?Yk5Qa3pWcFU0b3l1bmVuRHhxVFFDMEN5ZGlKUlNhTmRnY1UwSnVOZVpKR3Q3?=
 =?gb2312?B?Ujd5c2tmN3VqcFZ6WXQ3V3dMek1LcWJLVDYxY0hBRkVqb2U3YSs5N1NacENU?=
 =?gb2312?B?c0NCV3B6RlhjL3ZXcC9hZ0IrQml1K2E0QVI0U0lTeHdZUTRXWWZKdlFWa0lO?=
 =?gb2312?B?U0tmWlZoZkZoQUxpRUpVMSt0Qk5oSXRtbjNvY0FvZVRIK05HV1lWNjRnTU8y?=
 =?gb2312?B?QlVEczVaRkNhMnB5aEJWZ2laN0FBbGtHcDJvWGZaZ2ZSQ0ZKUTJ2elQ1bi9l?=
 =?gb2312?B?bXk3TnZTdWxBTGo2c21xdFVJM3NVSVpZUVFocy9DaElySHZBbmw5bW44RjVE?=
 =?gb2312?B?M0VNR2JEbTIwMU1QczhlZS9JamVRa0h5Z3RXWVVHckJEQnRTZ1RSbFRURXFn?=
 =?gb2312?B?NWxMak5WWXlHa1Z0YmpsMGpZRFQ1WXJpS2hsRitFWWZjV3JkQjYzaGwzOHhO?=
 =?gb2312?B?amFLTEhkT0FndkdWYTdXalM0SXdza0VDYkpPcE55dk1Sek9DZXFnTTd3TnEx?=
 =?gb2312?B?NU1lRFl2aFFKQzhCNkNVa1Y3aUE2TWlsNGZxRGFuN2pPZ2h6eUpuRU9rdFg1?=
 =?gb2312?B?VlhORzdiQ01SVFlEbURqYmtHUWNFRm0wS3Z0a2RvOFVBR2FpVUVBK3RmT1Ni?=
 =?gb2312?B?THM0d1lEVXF0UVdlR25kTnpmRFQwZExzeFpwOVZiQXA4MzlMb09FbDYySm15?=
 =?gb2312?B?ZnpKNU1QTmwrVkt2Rk5hcTc5TG5mM1d6RzgyVHZsSVRVL3FSdHJRNnlPUW1H?=
 =?gb2312?B?TWl0N2w3bnBRRDZEbTN0N1hPbm1KUUltRVdhWml1dm5TZlNGdks3V0t5S1FI?=
 =?gb2312?B?N2c4a29xQ2hiMUdUMHdRdlJabHp3aVlkWnFsSHFnS09KWEhiTTVJTjFLdHlN?=
 =?gb2312?B?TWRoSk80QWlEczY2S3Vsa1dLNnM0NzRUSzVVT0FkL0pHcjM2SGlKMk9uT0hy?=
 =?gb2312?Q?o2Grg4lo0fnWRz0+SMmrV0sRhmxK1Y=3D?=
X-Forefront-Antispam-Report:
	CIP:58.246.63.154;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.transsion.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 14:32:47.9032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f0385f-9e54-48de-1b42-08dd51bb72a2
X-MS-Exchange-CrossTenant-Id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2;Ip=[58.246.63.154];Helo=[mail.transsion.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66C9.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7726

RnJvbSBiMDdkZjNlZDNmZDIxODZhNjk4ZWY4N2FkMzY2NTIzZWM3YzdmY2NiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogInhpYW5oZS56aG91IiA8eGlhbmhlLnpob3VAdHJhbnNzaW9u
LmNvbT4NCkRhdGU6IFRodSwgMjAgRmViIDIwMjUgMjI6MDE6MjYgKzA4MDANClN1YmplY3Q6IFtQ
QVRDSF0gc2NoZWQ6IEZpeCBpbmNvcnJlY3QgcnVubmFibGUgdGltZSBjYWxjdWxhdGlvbiBpbg0K
c2NoZWRfc3RhdF93YWl0IHRyYWNlcG9pbnQNCg0KVGhlIHNjaGVkX3N0YXRfd2FpdCB0cmFjZXBv
aW50IGlzIGludGVuZGVkIHRvIHJlY29yZCB0aGUgcnVubmFibGUNCnRpbWUgb2YgYSB0YXNrLiBI
b3dldmVyLCBkdWUgdG8gaW5jb3JyZWN0IHRpbWVzdGFtcCBoYW5kbGluZywgdHdvIG1ham9yDQpp
c3N1ZXMgYXJpc2U6DQoNCjEuIFRoZSB0cmFjZXBvaW50IG1heSBpbmNvcnJlY3RseSByZWNvcmQg
Y29uc2VjdXRpdmUgc3RhcnQgdGltZXN0YW1wcw0KICAgb3IgY29uc2VjdXRpdmUgZW5kIHRpbWVz
dGFtcHMsIHJhdGhlciB0aGFuIHByb3Blcmx5IHBhaXJpbmcgdGhlbS4NCiAgIFRoaXMgbGVhZHMg
dG8gaW5jb3JyZWN0IHJ1bm5hYmxlIHRpbWUgY2FsY3VsYXRpb25zLg0KMi4gVGhlIHJlY29yZGVk
IHRpbWUgbWF5IGluY2x1ZGUgdGVtcG9yYXJ5IGRlcXVldWluZyBhbmQgZW5xdWV1aW5nDQogICBl
dmVudHMsIHN1Y2ggYXMgd2hlbiBtb2RpZnlpbmcgYSB0YXNrJ3MgbmljZSB2YWx1ZSB3aGlsZSBp
dCBpcyBydW5uaW5nLg0KDQpUaGlzIHBhdGNoIGVuc3VyZXMgdGhhdCB0aW1lc3RhbXBzIGFyZSBw
cm9wZXJseSBwYWlyZWQgYW5kIGV4Y2x1ZGVzDQp0ZW1wb3JhcnkgZGVxdWV1aW5nIGV2ZW50cyB0
byBwcmV2ZW50IGluY29ycmVjdCBtZWFzdXJlbWVudHMuDQoNClRlc3Rpbmc6DQpUaGlzIGlzc3Vl
IHdhcyB0ZXN0ZWQgb24gYW4gQW5kcm9pZCAxNCBkZXZpY2UuIFRoZSBmb2xsb3dpbmcgYXJlIHRo
ZQ0KdHJhY2UgcmVzdWx0cyBiZWZvcmUgYW5kIGFmdGVyIGFwcGx5aW5nIHRoZSBwYXRjaDoNCg0K
QmVmb3JlIHRoZSBmaXggKGluY29ycmVjdCB2YWx1ZXMpOg0KDQpzY2hlZF9zdGF0X3dhaXQ6IGNv
bW09T3ZlcmxheUVuZ2luZV8wIHBpZD0xNTMzIGRlbGF5PTM1MjQxODMxNTgzOSBbbnNdDQpzY2hl
ZF9zdGF0X3dhaXQ6IGNvbW09T3ZlcmxheUVuZ2luZV8wIHBpZD0xNTMzIGRlbGF5PTM1MjQwOTk2
MTg0MCBbbnNdDQpzY2hlZF9zdGF0X3dhaXQ6IGNvbW09T3ZlcmxheUVuZ2luZV8wIHBpZD0xNTMz
IGRlbGF5PTM1MjM5MzMxNzQ1NSBbbnNdDQpzY2hlZF9zdGF0X3dhaXQ6IGNvbW09YmluZGVyOjEx
NDhfMyBwaWQ9MjEwMiBkZWxheT0zNTIzODA0OTMzNzcgW25zXQ0Kc2NoZWRfc3RhdF93YWl0OiBj
b21tPU92ZXJsYXlFbmdpbmVfMCBwaWQ9MTUzMyBkZWxheT0zNTIzNjAwMzMzNzcgW25zXQ0KDQpD
bGVhcmx5LCB0aGVzZSBydW5uYWJsZSB0aW1lIHZhbHVlcywgaW4gdGhlIGh1bmRyZWRzIG9mIHNl
Y29uZHMsDQphcmUgaW5jb3JyZWN0Lg0KDQpBZnRlciB0aGUgZml4IChjb3JyZWN0ZWQgdmFsdWVz
KToNCg0Kc2NoZWRfc3RhdF93YWl0OiBjb21tPWt3b3JrZXIvNzoxIHBpZD0xMzY4MiBkZWxheT02
MzUxNjkyMyBbbnNdDQpzY2hlZF9zdGF0X3dhaXQ6IGNvbW09U3VwZXJBX1JbMTM2XSBwaWQ9MTUw
NzQgZGVsYXk9NTEzMjQzODUgW25zXQ0Kc2NoZWRfc3RhdF93YWl0OiBjb21tPVN1cGVyQV9SWzEz
Nl0gcGlkPTE1MDgwIGRlbGF5PTUwMjgwNTM5IFtuc10NCnNjaGVkX3N0YXRfd2FpdDogY29tbT1T
dXBlckFfUlsxMzZdIHBpZD0xNTA3MSBkZWxheT00ODk5NTY5MiBbbnNdDQpzY2hlZF9zdGF0X3dh
aXQ6IGNvbW09U3VwZXJBX1JbMzRdIHBpZD0xNDk1MSBkZWxheT00MTg3NjMwOCBbbnNdDQoNCkFm
dGVyIHRoZSBmaXgsIHRoZSByZWNvcmRlZCBydW5uYWJsZSB0aW1lcyBhcmUgd2l0aGluIGV4cGVj
dGVkIHJhbmdlcy4NCg0KRml4ZXM6IDc2OGQwYzI3MjI2ZSAoInNjaGVkOiBBZGQgd2FpdCwgc2xl
ZXAgYW5kIGlvd2FpdCBhY2NvdW50aW5nIHRyYWNlcG9pbnRzIikNClNpZ25lZC1vZmYtYnk6IHhp
YW5oZS56aG91IDx4aWFuaGUuemhvdUB0cmFuc3Npb24uY29tPg0KLS0tDQprZXJuZWwvc2NoZWQv
ZmFpci5jICB8IDEzICsrKysrKystLS0tLS0NCmtlcm5lbC9zY2hlZC9ydC5jICAgIHwgMTUgKysr
KysrKysrKysrLS0tDQprZXJuZWwvc2NoZWQvc3RhdHMuYyB8ICA3ICsrKysrKy0NCjMgZmlsZXMg
Y2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQg
YS9rZXJuZWwvc2NoZWQvZmFpci5jIGIva2VybmVsL3NjaGVkL2ZhaXIuYw0KaW5kZXggMWMwZWY0
MzVhN2FhLi4zN2EzMTViMzkwNmIgMTAwNjQ0DQotLS0gYS9rZXJuZWwvc2NoZWQvZmFpci5jDQor
KysgYi9rZXJuZWwvc2NoZWQvZmFpci5jDQpAQCAtMTMzMSwxMSArMTMzMSwxMiBAQCB1cGRhdGVf
c3RhdHNfZW5xdWV1ZV9mYWlyKHN0cnVjdCBjZnNfcnEgKmNmc19ycSwgc3RydWN0IHNjaGVkX2Vu
dGl0eSAqc2UsIGludCBmbA0KICAgICBpZiAoIXNjaGVkc3RhdF9lbmFibGVkKCkpDQogICAgICAg
ICAgICByZXR1cm47DQoNCi0gICAgIC8qDQotICAgICAqIEFyZSB3ZSBlbnF1ZXVlaW5nIGEgd2Fp
dGluZyB0YXNrPyAoZm9yIGN1cnJlbnQgdGFza3MNCi0gICAgICogYSBkZXF1ZXVlL2VucXVldWUg
ZXZlbnQgaXMgYSBOT1ApDQorICAgIC8qDQorICAgICAqIEFyZSB3ZSBlbnF1ZXVlaW5nIGEgd2Fp
dGluZyB0YXNrPyBBbmQgaXQgaXMgbm90DQorICAgICAqIGEgdGVtcG9yYXJ5IGVucXVldWU/KGZv
ciBjdXJyZW50IHRhc2tzIGENCisgICAgICogZGVxdWV1ZS9lbnF1ZXVlIGV2ZW50IGlzIGEgTk9Q
KQ0KICAgICAgKi8NCi0gICAgIGlmIChzZSAhPSBjZnNfcnEtPmN1cnIpDQorICAgICBpZiAoc2Ug
IT0gY2ZzX3JxLT5jdXJyICYmICEoZmxhZ3MgJiBFTlFVRVVFX1JFU1RPUkUpKQ0KICAgICAgICAg
ICAgdXBkYXRlX3N0YXRzX3dhaXRfc3RhcnRfZmFpcihjZnNfcnEsIHNlKTsNCg0KICAgICAgaWYg
KGZsYWdzICYgRU5RVUVVRV9XQUtFVVApDQpAQCAtMTM1MSw5ICsxMzUyLDkgQEAgdXBkYXRlX3N0
YXRzX2RlcXVldWVfZmFpcihzdHJ1Y3QgY2ZzX3JxICpjZnNfcnEsIHN0cnVjdCBzY2hlZF9lbnRp
dHkgKnNlLCBpbnQgZmwNCg0KICAgICAgLyoNCiAgICAgICogTWFyayB0aGUgZW5kIG9mIHRoZSB3
YWl0IHBlcmlvZCBpZiBkZXF1ZXVlaW5nIGENCi0gICAgICogd2FpdGluZyB0YXNrOg0KKyAgICAg
KiB3YWl0aW5nIHRhc2sgYW5kIGl0IGlzIG5vdCBhIHRlbXBvcmFyeSBkZXF1ZXVlOg0KICAgICAg
Ki8NCi0gICAgIGlmIChzZSAhPSBjZnNfcnEtPmN1cnIpDQorICAgICBpZiAoc2UgIT0gY2ZzX3Jx
LT5jdXJyICYmICEoZmxhZ3MgJiBERVFVRVVFX1NBVkUpKQ0KICAgICAgICAgICAgdXBkYXRlX3N0
YXRzX3dhaXRfZW5kX2ZhaXIoY2ZzX3JxLCBzZSk7DQoNCiAgICAgIGlmICgoZmxhZ3MgJiBERVFV
RVVFX1NMRUVQKSAmJiBlbnRpdHlfaXNfdGFzayhzZSkpIHsNCmRpZmYgLS1naXQgYS9rZXJuZWwv
c2NoZWQvcnQuYyBiL2tlcm5lbC9zY2hlZC9ydC5jDQppbmRleCA0YjhlMzNjNjE1YjEuLjk5MTI1
MWZlZWFmNiAxMDA2NDQNCi0tLSBhL2tlcm5lbC9zY2hlZC9ydC5jDQorKysgYi9rZXJuZWwvc2No
ZWQvcnQuYw0KQEAgLTEzMTAsOSArMTMxMCwxNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQNCnVwZGF0
ZV9zdGF0c19lbnF1ZXVlX3J0KHN0cnVjdCBydF9ycSAqcnRfcnEsIHN0cnVjdCBzY2hlZF9ydF9l
bnRpdHkgKnJ0X3NlLA0KICAgICAgICAgICAgICAgICAgIGludCBmbGFncykNCnsNCisgICAgIHN0
cnVjdCB0YXNrX3N0cnVjdCAqcCA9IE5VTEw7DQorDQogICAgIGlmICghc2NoZWRzdGF0X2VuYWJs
ZWQoKSkNCiAgICAgICAgICAgIHJldHVybjsNCg0KKyAgICAgaWYgKHJ0X2VudGl0eV9pc190YXNr
KHJ0X3NlKSkNCisgICAgICAgICAgICBwID0gcnRfdGFza19vZihydF9zZSk7DQorDQorICAgICBp
ZiAocCAhPSBycV9vZl9ydF9ycShydF9ycSktPmN1cnIgJiYgIShmbGFncyAmIEVOUVVFVUVfUkVT
VE9SRSkpDQorICAgICAgICAgICAgdXBkYXRlX3N0YXRzX3dhaXRfc3RhcnRfcnQocnRfcnEsIHJ0
X3NlKTsNCisNCiAgICAgaWYgKGZsYWdzICYgRU5RVUVVRV9XQUtFVVApDQogICAgICAgICAgICB1
cGRhdGVfc3RhdHNfZW5xdWV1ZV9zbGVlcGVyX3J0KHJ0X3JxLCBydF9zZSk7DQp9DQpAQCAtMTM0
OCw2ICsxMzU2LDEwIEBAIHVwZGF0ZV9zdGF0c19kZXF1ZXVlX3J0KHN0cnVjdCBydF9ycSAqcnRf
cnEsIHN0cnVjdCBzY2hlZF9ydF9lbnRpdHkgKnJ0X3NlLA0KICAgICBpZiAocnRfZW50aXR5X2lz
X3Rhc2socnRfc2UpKQ0KICAgICAgICAgICAgcCA9IHJ0X3Rhc2tfb2YocnRfc2UpOw0KDQorICAg
ICBpZiAocCAhPSBycV9vZl9ydF9ycShydF9ycSktPmN1cnIgJiYgIShmbGFncyAmIERFUVVFVUVf
U0FWRSkpIHsNCisgICAgICAgICAgICB1cGRhdGVfc3RhdHNfd2FpdF9lbmRfcnQocnRfcnEsIHJ0
X3NlKTsNCisgICAgIH0NCisNCiAgICAgaWYgKChmbGFncyAmIERFUVVFVUVfU0xFRVApICYmIHAp
IHsNCiAgICAgICAgICAgIHVuc2lnbmVkIGludCBzdGF0ZTsNCg0KQEAgLTE0NzQsOSArMTQ4Niw2
IEBAIGVucXVldWVfdGFza19ydChzdHJ1Y3QgcnEgKnJxLCBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAs
IGludCBmbGFncykNCiAgICAgaWYgKGZsYWdzICYgRU5RVUVVRV9XQUtFVVApDQogICAgICAgICAg
ICBydF9zZS0+dGltZW91dCA9IDA7DQoNCi0gICAgIGNoZWNrX3NjaGVkc3RhdF9yZXF1aXJlZCgp
Ow0KLSAgICAgdXBkYXRlX3N0YXRzX3dhaXRfc3RhcnRfcnQocnRfcnFfb2Zfc2UocnRfc2UpLCBy
dF9zZSk7DQotDQogICAgIGVucXVldWVfcnRfZW50aXR5KHJ0X3NlLCBmbGFncyk7DQoNCiAgICAg
IGlmICghdGFza19jdXJyZW50KHJxLCBwKSAmJiBwLT5ucl9jcHVzX2FsbG93ZWQgPiAxKQ0KZGlm
ZiAtLWdpdCBhL2tlcm5lbC9zY2hlZC9zdGF0cy5jIGIva2VybmVsL3NjaGVkL3N0YXRzLmMNCmlu
ZGV4IDQzNDZmZDgxYzMxZi4uMzY3ZjRiYjFjNzU5IDEwMDY0NA0KLS0tIGEva2VybmVsL3NjaGVk
L3N0YXRzLmMNCisrKyBiL2tlcm5lbC9zY2hlZC9zdGF0cy5jDQpAQCAtMjAsOCArMjAsMTMgQEAg
dm9pZCBfX3VwZGF0ZV9zdGF0c193YWl0X3N0YXJ0KHN0cnVjdCBycSAqcnEsIHN0cnVjdCB0YXNr
X3N0cnVjdCAqcCwNCnZvaWQgX191cGRhdGVfc3RhdHNfd2FpdF9lbmQoc3RydWN0IHJxICpycSwg
c3RydWN0IHRhc2tfc3RydWN0ICpwLA0KICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHNj
aGVkX3N0YXRpc3RpY3MgKnN0YXRzKQ0Kew0KLSAgICAgdTY0IGRlbHRhID0gcnFfY2xvY2socnEp
IC0gc2NoZWRzdGF0X3ZhbChzdGF0cy0+d2FpdF9zdGFydCk7DQorICAgICB1NjQgZGVsdGE7DQor
ICAgICB1NjQgd2FpdF9zdGFydCA9IHNjaGVkc3RhdF92YWwoc3RhdHMtPndhaXRfc3RhcnQpOw0K
DQorICAgICBpZiAoIXdhaXRfc3RhcnQpDQorICAgICAgICAgICAgcmV0dXJuOw0KKw0KKyAgICAg
ZGVsdGEgPSBycV9jbG9jayhycSkgLSB3YWl0X3N0YXJ0Ow0KICAgICBpZiAocCkgew0KICAgICAg
ICAgICAgaWYgKHRhc2tfb25fcnFfbWlncmF0aW5nKHApKSB7DQogICAgICAgICAgICAgICAgICAg
LyoNCi0tIA0KMi4zNC4xDQoNCg0KDQo=

