Return-Path: <linux-kernel+bounces-297090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9F695B2E7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA89FB22470
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC69D17F4F6;
	Thu, 22 Aug 2024 10:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OymavG1Y";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OymavG1Y"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2061.outbound.protection.outlook.com [40.107.104.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8F813C9CB
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.61
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724322504; cv=fail; b=D3crMh1aRj+HaditCUsl5yyzGqNOIXnlS+vd1sCIwyG8Pa62ciwrmBH7t0Te6VXJNvJzejlk5xZIv0yv9gQacG9eJ9VTfYVY0/s+p7mPZ1ft/mbHHqozTX5qzWHRL7q6qlU4CMXLexaQPiW2pupJKvzsWBw3WjaYAKnVO0Gq+PU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724322504; c=relaxed/simple;
	bh=NPUskTF+8bAYvBUFTqNX6DKOunrPKoZXhJE3S685z2I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pX7t8hnG0RXUfknRmnN8NORwc65w0aN1Z2iKrrzihQQjxD9Q7CwEvP45MzBQB0E6eIKmJHUweBdx1LQQDIWzYWgWWgRef6ecYADkMOx+60+jTJsVr/hNTCP/KAdAIq6nqGKQtxfXPYJLavzO2assw6/md5yv6JraqfbE/yZSWtM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OymavG1Y; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OymavG1Y; arc=fail smtp.client-ip=40.107.104.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=IzgQ6RZTaqTNYUzpk4v4w0PkJeRsK4LcCz6SRk6h+xldAS/rS6Gc1RV7dYjhRTGGMnclTlTvIJy0udsz8kBOVidlnBqk/oZaklj7PLdSOe1Eu7vM/TDmncvFYcild/vPZcdszIB0wmUAMaXzPIk/objqdH2nXS+e+p/tkQIUZbiQHiVaqx6haKa+fPesnSVEhubtBYi5XQHNewu8zpDmbRMigHdIFtdjCdRlLf8cZLsGp+4xP/Lad2baxU1BpBopZikpSZR6YPjuj/9EUvMLCga8lWIawf7xBEQZ8WcRPlYnobmC5O8HlBSAEQBN2C5FRbhHA3p73YjEZ7jKKLbYrg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tx11lpsUipDilKAcP+kaMRTLRod1404suF92ki51Me0=;
 b=ULAm4taT0ennTpvS9As6MKssEuvVih1BFLtBc1GEr9rdqzgomRygfNL3biPgs3cxK6+pfSAuRSBwlIS8vCWO3kOISx6iQqs6/C+UZkEwAU6W9TeS+qk47OUKwT9BsjT9w+dniHPbGPCVEOhy+OpB96d8K5CUO4WbbMQBkpHp8RJ2KeK203kT1t9Pm2coZu2J1do5iecVTC8KlmkZDEuu5PnTlH/+oZP13Nd9R89vFVQ6LYBZh7cDh1veAS+opVPErWLErpL6vZxGQwFmS0oSQq2z1GMlELt7OnJ4OGWz+QGXWwv+oEjDOLFTTH+32Zlirw6AlPWWlLXtkYU4aR9wRw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tx11lpsUipDilKAcP+kaMRTLRod1404suF92ki51Me0=;
 b=OymavG1YIZZj4w/Cp4fOSxzFG2AvMvQujxcXdjm8R0b39PqUBH07T1BU3OTDJvgVNVSjytCGowX/ruLULvksiJoVEbT67Wp21PAz0dEZ476X6KDV6wf7L/1yxZOVk4DNrsg4HHSKduydZ17iYeQweZUwb1YB9CiyJLv/iypHMOE=
Received: from AM0PR04CA0028.eurprd04.prod.outlook.com (2603:10a6:208:122::41)
 by DB9PR08MB9947.eurprd08.prod.outlook.com (2603:10a6:10:3d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 10:28:15 +0000
Received: from AMS1EPF00000049.eurprd04.prod.outlook.com
 (2603:10a6:208:122:cafe::11) by AM0PR04CA0028.outlook.office365.com
 (2603:10a6:208:122::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20 via Frontend
 Transport; Thu, 22 Aug 2024 10:28:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS1EPF00000049.mail.protection.outlook.com (10.167.16.133) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7897.11
 via Frontend Transport; Thu, 22 Aug 2024 10:28:15 +0000
Received: ("Tessian outbound 901f45c3f9e8:v403"); Thu, 22 Aug 2024 10:28:14 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 43d1053836d2cc00
X-CR-MTA-TID: 64aa7808
Received: from Lb19bda146a2c.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id DBF5005D-4B58-40DD-96A3-D5D2B58D6D98.1;
	Thu, 22 Aug 2024 10:28:07 +0000
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lb19bda146a2c.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 22 Aug 2024 10:28:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqlT5tHhMUyJXfkfEvmaON2Njfu2VvBlpCzLlZ1Wca5SVR/iHeD6J1UMuhhrAL4CtZX+Bu+xxWTr4msBcZ7UZ7MpDtEKkbMufmxKKq4zcvmlVfvWTENzuxg4mFjKYHwtja921AMg8yhYhoYWPwLN150xfbLPnOn/v0WGKLAjDlV+EwAP+MjTf1AS9iyV/WV1dICBa2letH4E3Z0ccKVJWJxb/z8eCHt5k2beXpwVscT+ug0o8SJePClQCGnjZ1pP3EgT5W6EizaR0mT8FNwWqxx0+calVQz+F+6medrwjqZ8gXr2UUAcbhxEI7ILu+VV0Vi1DocxFiPd4vUV93lSDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tx11lpsUipDilKAcP+kaMRTLRod1404suF92ki51Me0=;
 b=d4s3fbONpDrxiP5tmu5I08oBaGpzLuOXIgyVKJsxuJLq/fdFWs6QK5CqBmvrr+lvUOobOQ/A25g9IkFBeJ82Ccgo52vq15u5F4+ZskpTzAMTfV+GdXruqfIxpfRxXTskitCYoGxVpGQTkHs5e/uhU/e85jhASyegYQODRd+1IrldawW4o30NgkCa99TGelDrgt11jPpakGigoRRdo7WqnvFZto4wGL+Te74sfAQuiDpgJ5TRYXl5rISy2FZOKqPpAhihnRHBkao7URckfuHsmfikKalBu1UjyAJjxD5H9QT1k8KtQLlZSVFZCd0PKQDPOzwB8jFr83ixvAs+se6TLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tx11lpsUipDilKAcP+kaMRTLRod1404suF92ki51Me0=;
 b=OymavG1YIZZj4w/Cp4fOSxzFG2AvMvQujxcXdjm8R0b39PqUBH07T1BU3OTDJvgVNVSjytCGowX/ruLULvksiJoVEbT67Wp21PAz0dEZ476X6KDV6wf7L/1yxZOVk4DNrsg4HHSKduydZ17iYeQweZUwb1YB9CiyJLv/iypHMOE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com (2603:10a6:102:8e::21)
 by DBBPR08MB10795.eurprd08.prod.outlook.com (2603:10a6:10:530::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Thu, 22 Aug
 2024 10:28:03 +0000
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d]) by PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d%3]) with mapi id 15.20.7897.010; Thu, 22 Aug 2024
 10:28:01 +0000
Message-ID: <83a20d85-de7a-4fe6-8cd8-5a96d822eb6b@arm.com>
Date: Thu, 22 Aug 2024 11:28:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Hongyan Xia <hongyan.xia2@arm.com>, Peter Zijlstra
 <peterz@infradead.org>, mingo@redhat.com, juri.lelli@redhat.com,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
 kprateek.nayak@amd.com, wuyun.abel@bytedance.com, youssefesmat@chromium.org,
 tglx@linutronix.de, efault@gmx.de
References: <20240727102732.960974693@infradead.org>
 <20240727105029.315205425@infradead.org>
 <6f39e567-fd9a-4157-949d-7a9ccd9c3592@arm.com>
 <CAKfTPtAS0eSqf5Qoq_rpQC7DbyyGX=GACsB7OPdhi8=HEciPUQ@mail.gmail.com>
 <1debbea4-a0cf-4de9-9033-4f6135a156ed@arm.com>
 <CAKfTPtCEUZxV9zMpguf7RKs6njLsJJUmz8WadyS4ryr+Fqca1Q@mail.gmail.com>
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <CAKfTPtCEUZxV9zMpguf7RKs6njLsJJUmz8WadyS4ryr+Fqca1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0693.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::9) To PR3PR08MB5852.eurprd08.prod.outlook.com
 (2603:10a6:102:8e::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PR3PR08MB5852:EE_|DBBPR08MB10795:EE_|AMS1EPF00000049:EE_|DB9PR08MB9947:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d46fd5-7910-4f8a-696a-08dcc29521e4
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?SFBUZFhjWXZuMExZb2U2cWVoNk4vY3EwK1hPaTkwQ3FhdEUxUDB1Y240bS9o?=
 =?utf-8?B?dWpFOGNPb0hnMWdtWTRMNDJWYjFHaHIvYlVTYUVlRHByamlydGVCL09tczVZ?=
 =?utf-8?B?YUdUREZ0Vy90VkJONjBqU0ZIaFBkclBjS3puZElIYXNCN2V3ckFQVVdObFZY?=
 =?utf-8?B?WjJ4WHEwK0xWYjRiNEVLQVhxSGlzTDU4YWNPKzBRRFhTNDdqazR6bnkrdWRt?=
 =?utf-8?B?NVkyR0tIYmtoY2E4a1RIZTZBbS8yekRUQmpQMExjTXZPMUdQa2x3SDJkZjRV?=
 =?utf-8?B?R2dYeTFveXFIVVJ5QVRiVGVEK1pKTUZIdDI1S3RGQ0FyV3A3a29uSGRmbFA4?=
 =?utf-8?B?WXBlVzBZYzFpa0gzS0MxaGpQKzFIcG1WTjc5cGcvVnJiZERtem42QVpSbGhu?=
 =?utf-8?B?ZGhXeTI5eXo3SXZSVnJzM0RVRE9IWU1UM282bEFUYVdMOGxCc0Q2eGl5VkJs?=
 =?utf-8?B?RzBnemRHbVhjemM4N3l5TVlRSWxJMlVrZDRtWFZnTTdmWVRMUlM3cEJ0d00x?=
 =?utf-8?B?OUdMWmpVb0ZYUzZGMEMzR3VLYTQ2MG0zWEdoeHBTRlNybU9tMlJ2TXk3NG9n?=
 =?utf-8?B?aU5rZkRteXJJZW1HQVlvZlNvTFFKUlJhRENHSWYyOGUvdzI2OFhkRnRFV3hi?=
 =?utf-8?B?TFpscWhIWU9aM3ovL1VOZ2IxaVZIR092TTFta2ZNd25tSXJaMVVxOEFTUW5v?=
 =?utf-8?B?L3FmSC9TYkxKcWtqbUpNSGhRQ1AwSlkrWjhqS25lclpQRWxaejBQSG9rRWN0?=
 =?utf-8?B?eWhiV0I4ZFExRk5yeDZEaXp0dzBSOHppblRaT09Qa0E0N0dXcEQyUHhvMlR4?=
 =?utf-8?B?bHoydVJrM2xRUjd5ZTBPazk4enN1K3AzZ1NlV0o2TjdkMjlSYWc3U2NkSnhF?=
 =?utf-8?B?VnllQmJwcjBrTGJTaHpIVjRKeXZVSzl1MVRDNUlhWElrc01IZURFRzNORUo5?=
 =?utf-8?B?T3lvTkxoSjB0bVBKdEFPTDVVcUhVRzFiTUNyZ0xTclM2RmdpWDgwaTc5RGxK?=
 =?utf-8?B?M1hpYmxhbkZreXo4QXhrS0V0QVNZbUlnUXd4N1Q1MnN1QTFXL1RLNURHT1hO?=
 =?utf-8?B?TURhVkZzeHQwNlBoL0M3bDk0VWN5dWJsMEd1Y0tQSzhiL1VXVHVLaWV1RWV3?=
 =?utf-8?B?ZXUyLzg3ZWpPU0JQS0pBMGVnWjNvVUJEZlAwNGxsbVcyOU8rTG1samtGaU1B?=
 =?utf-8?B?djEwbnVZSXM1azNqdFgxUEJpd1hpcXQ3RG1Fa0JnTXFQVWhCUmFDdEkzQzZp?=
 =?utf-8?B?YnZMRG1ab3V2WnJuYnFyZGgvV2VBT0xMaTNwTXZCNkZEb21ZR1dOV3VBSnd0?=
 =?utf-8?B?U2lDNkRlZkJocUhRMTFUOVNOSkFRQkxxU2g4Z252azYxOWRwaDdyK2p5cjZ2?=
 =?utf-8?B?MU1ZT2F5NVJmS2lMdzB0K0szTDY4RTVLQnFXbG9EWXJaUDMra0Qwcll4U2VQ?=
 =?utf-8?B?MnVnY2h1UHFOV0JidkJEYVRmTXlCN0E4L1Y2UUZwSnJzK3NVZ2VweTV3ZHND?=
 =?utf-8?B?MXk2Yll3RnRJN05aUE5veUdERi9iVkZ5MDdrNmpDaFJmcmhCUzYyaEZuTTNk?=
 =?utf-8?B?aDhKcVhPK29JeG1PejFDMHpyQWt2VWxZeWNwdXZQaG5vc043ak9zaGZoV0lF?=
 =?utf-8?B?OGFZeHF2dTlpTjQrSklaendRMVpPWUxKVy9IY0pURXJSc2Q4YVMzQnBOVGpS?=
 =?utf-8?B?eVdPa2NRRG9wN2UrSlBKWVJjUm56VjNla2QwVHgyWjJpUVRRWko2RnI0RERm?=
 =?utf-8?B?RjNmVjNLdm9iQ2JOMENzaWNVUUw0WURtTmlXakNVbHJnYUpSOVBrdVJBd1Z4?=
 =?utf-8?B?NFdqZHFBNVNCTUVPT2U0UT09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5852.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10795
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:102:8e::21];domain=PR3PR08MB5852.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000049.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	cf7796a6-ea4d-473c-df97-08dcc2951992
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlVWNEM0NTJIc25ucDZjS2V6UHNXMDdVR2s2SytHa1NuS01JbkVwaG9KNVpv?=
 =?utf-8?B?V0MzNG4rd2dTL05Ja25iM25xU0I2VkFuWkVKZks3WUVRdk1FblVhZ0NTaHI5?=
 =?utf-8?B?NERZTTRtQ0hYanRYMktFVDNjVUJOb0ExSjVmU0xTbUJySmZ1UHNwZDRPRWdP?=
 =?utf-8?B?MUxpSzZZbUplNjhFKzljRmw1MW0vZnB2bWpnTURja2lWWUIxajBHK3BrNmZ1?=
 =?utf-8?B?ZnMvZlVLMC9vWGFXRDF2RW13WkRwRFp0QjZFd1JnK2FYeUplSElDZjZZOGFq?=
 =?utf-8?B?dGduc3h0VlovV0Eza3lKRHpTT0dHNGladU91RVU4a0UvcG5UbWV2bGhWbGky?=
 =?utf-8?B?ekQ2aW9wRktiMGQ0U0szZTNRS1BSR1gyQmgyVDFHblFjMXhDcDhrc2J3RFUz?=
 =?utf-8?B?OVdyTWpaSGpTQzV6UjJaSGxHQ1BvTUFjUVFGNDI4T2NXMDFPL0RQU2ZpblEv?=
 =?utf-8?B?b3FLeUQ1Y3ZHL2FEazN0UzBFZVB2anE4WURSempVUkFZZXlzYXhwdldoNitk?=
 =?utf-8?B?NUk0Z1JEUlkrU1BHb1JVYjFteEExdmZwckZiRzRxVmZnOW5MQ3J0RDNMVXdY?=
 =?utf-8?B?MjJFemlxY1JIMDZ3bUdOUE4wekUzRXFyV1JTcFBzNVU5bmJuTmRycGtJZ3gr?=
 =?utf-8?B?dlRuZTV0Z1ZLWDNJWHJnL2t2Yk1NV1M2Q3RwQit4d2NwT1Mrb3NNMVhodUU3?=
 =?utf-8?B?TFJTakowY1VLY1drUFh6WUtTeE1URGg1aVpmWlAvK0F3OXAzVnpQN1dxMzJD?=
 =?utf-8?B?WkE3RXhCS1hQd3hWQXJDTE5ocDFBUzM2UGZ2K0tHN2lSeVA2bVN6R1BwVU4x?=
 =?utf-8?B?N1RHTEt2TkZVaVR3WU4vdnJiMzdadnBhVEptL2VENm5kcnBOTDFZSDgzeDdv?=
 =?utf-8?B?ZUt2N1dEV0V5d09kSWRLN1dKQ3pFRVU5VFlaMW00R21HSjdHWmI1T2NGaDlk?=
 =?utf-8?B?SEwxUDNnVmtaV3R4TU8wZjBiR1l6MDZ6eUg1UTJHWkh3VjBtOUFFNWhMMlhU?=
 =?utf-8?B?Q29zaDRQNlg5REZVZyttaWxONm5LWDAyalNCbE52dVhVcStkdjVNOGRORmsw?=
 =?utf-8?B?NnZhR2pjSHdUcVVZQ2ZYTitvV0hhUW1JbEVWclRxdUhkenkyNWtZc1NRb2tF?=
 =?utf-8?B?Wjd1YXdFL0ZGMXlzcUl2SzB3ZnROMEZyM0k1NU44eVJxVk00RWt3TUIvSERH?=
 =?utf-8?B?aXJpdzkzNXJTK0FIT290QzhlcjhsSlQ5T3FWOUJqRmdERUViQU5zNDZOb0Za?=
 =?utf-8?B?d0xEblJQemNxSDYvZUhJQmlncFhuSVVhKzBBK1p1am9ZOG8ya2dVNmFXdGZl?=
 =?utf-8?B?b2FkbzNPZlJkYlpXVWZIT2lIUnZ2dmFsN0NBWVY1V2w4alFPSUgzZ3pUMXdw?=
 =?utf-8?B?enpISUhrYmk1Uk1rbVdleDl4V09FR05SaFhRMFJtTVIwWkNxRmVsV2FhbDBi?=
 =?utf-8?B?WkY2UyttQ3ZDVUhTSVVJd0FHb2hQcnF2bnRwWDA1c0dkc2FSeUlCcnB0U0Vr?=
 =?utf-8?B?RHRCN1FuS2YwaHhmdlRFZ3BBV1ZXMWxRbkhTenE5Um5XL2RKbkMzbDBneHJo?=
 =?utf-8?B?NzRkOThiR3ZrQ25Sam5WTGd3RU5TU253Q0xsS0s1RGd3Q2JobUNjMEhEVnVx?=
 =?utf-8?B?c0hsWlpPeG5LTVJ4Kzlqblc0MGUvR0h0aGVZUEoxMmt4b3JZeXF2cC9FWnhi?=
 =?utf-8?B?akhzWHFDS0hSbjJRby93MkJIYWpuQllkVlBoUkJtNkNCZTBnQ0FJWVJQRE11?=
 =?utf-8?B?RWRSNk50RGhGUjJ6ZEVGWnpMSnhXQnBzbC9yNUNwS2FhOCtzNk1hOGhrOTly?=
 =?utf-8?B?Q0NGOENQNzVWbWtSQ25NSTlnMjJWWUdXdTR1Wnlaa25McWRvN0lXV3BNamhD?=
 =?utf-8?B?dTV4bGIrQkprNnhNNTdNd0pmamtuaTFwNzRXZi9oUHRhZ2NzUGRGQmpnVEZ5?=
 =?utf-8?Q?QlkKtA3Kg4H19RvSWQW2VpfikOjhtTkz?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 10:28:15.3831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d46fd5-7910-4f8a-696a-08dcc29521e4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000049.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9947

On 8/22/24 10:53, Vincent Guittot wrote:
> On Thu, 22 Aug 2024 at 11:22, Luis Machado <luis.machado@arm.com> wrote:
>>
>> On 8/22/24 09:19, Vincent Guittot wrote:
>>> Hi,
>>>
>>> On Wed, 21 Aug 2024 at 15:34, Hongyan Xia <hongyan.xia2@arm.com> wrote:
>>>>
>>>> Hi Peter,
>>>>
>>>> Sorry for bombarding this thread in the last couple of days. I'm seeing
>>>> several issues in the latest tip/sched/core after these patches landed.
>>>>
>>>> What I'm now seeing seems to be an unbalanced call of util_est. First, I applied
>>>
>>> I also see a remaining util_est for idle rq because of an unbalance
>>> call of util_est_enqueue|dequeue
>>>
>>
>> I can confirm issues with the utilization values and frequencies being driven
>> seemingly incorrectly, in particular for little cores.
>>
>> What I'm seeing with the stock series is high utilization values for some tasks
>> and little cores having their frequencies maxed out for extended periods of
>> time. Sometimes for 5+ or 10+ seconds, which is excessive as the cores are mostly
>> idle. But whenever certain tasks get scheduled there, they have a very high util
>> level and so the frequency is kept at max.
>>
>> As a consequence this drives up power usage.
>>
>> I gave Hongyan's draft fix a try and observed a much more reasonable behavior for
>> the util numbers and frequencies being used for the little cores. With his fix,
>> I can also see lower energy use for my specific benchmark.
> 
> The main problem is that the util_est of a delayed dequeued task
> remains on the rq and keeps the rq utilization high and as a result
> the frequency higher than needed.
> 
> The below seems to works for me and keep sync the enqueue/dequeue of
> uti_test with the enqueue/dequeue of the task as if de dequeue was not
> delayed
> 
> Another interest is that we will not try to migrate a delayed dequeue
> sleeping task that doesn't actually impact the current load of the cpu
> and as a result will not help in the load balance. I haven't yet fully
> checked what would happen with hotplug

Thanks. Those are good points. Let me go and try your patch.

