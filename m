Return-Path: <linux-kernel+bounces-183893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDBB8C9F84
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1E41C2139E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A50136E39;
	Mon, 20 May 2024 15:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="j1t+II/V";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="j1t+II/V"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2082.outbound.protection.outlook.com [40.107.7.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8A31E49D
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.82
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716218455; cv=fail; b=lkKWZ+xStq+boib7E6JAhNTm3RCCZOhNmW5DGlmqQrGpYKP7SUb/kQ3k4g8Lxn/+hjSKIBqUAh/Btf7cCzbZBRlevyiXFMinTLw5dgJensjAh5pGcpnQf+BwgoQrM3nvYTxb3zPgqVM0h2eQXDbeb+SKLHkdJ37p4nNIW7vpmi8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716218455; c=relaxed/simple;
	bh=wrHrRTN0r2np88Z6TuLyHzJBJcZ7FQoCqwTKSWaW+I4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q7vW3oncQfqjSF514NvQRLwI2TcVaDA0CIVYsJsF6MDf78An3kW4GzkLtsDvVlrCNyOUz3TZUZX9hWE7yWh+2Fh2lX2iFWKTf989GinZKVd7nb6So9jDKHBvCAVz1jarD+sPdbWp4sreCOxRdVJDGg7pZXosQY1o1i1V3QUuHV0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=j1t+II/V; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=j1t+II/V; arc=fail smtp.client-ip=40.107.7.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Ex8nrp6u+nHfC2KI/oMPbfSoxvuCQYePCUVJrsw0OEq0gQlOVPps7Pa7o7lDYFkl2nmkg3hEUwP6BOn3oqSWg/Wc3zCx854180DKIVSE1NY5mBOugRgC24vMOCQo3hBQtwtI9BdMzRfJ+8uCYcnPLR/cLbi4x4VkhnQxGN5duSEp67DpdKQiodcPGlqLcGV8qndLIVnLohC0aFUTaW48kvL8YjXqVu29JWjL03xPrSlhQRJDcEyCG3IxwV4g7DAbGNM6O/oYl24BSGzIWOg1NdLik5t2RKzK/D9d8yfNfdqmfmFdIQY7yUYbTMCJNhgx3KIu1n4eOwOcRZyr19b2Xw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5Qimm6mITQPTXQAqo+H+Ec7y0cHMHFuY5AS9yWnGeY=;
 b=FYVIA661tsq8OYsMCrpCOUQwmzT4/I4xZU/lgeVoFjYYUhmY9WIEyBPAqXTRj7xKZUu5ctwGDVCb1fTo0JZ1oeMSNhR/bEO5M2Ul0BYz/i5JxGGvRsIp8sYXdImv2AxsbfKRWCTQjPYTcx8RJVIybVJBGB1YNK3N7b12u2qxym4XsDj+p+UmBW6S8W+AlFcz77sqcalPRA3zmt7HXuNbXD/jwOMWmhgliXaHCgFZsPH9C7pIUcReR5AG9eePYU8e4W4DLcjnEH8IFJvGIW4slY1weMRkFhv3M6XmMZ4f5ovhk1D2akhVg3FiXRjfSQ/QrPpp4W6B/1m3T1Ktk6XTqw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5Qimm6mITQPTXQAqo+H+Ec7y0cHMHFuY5AS9yWnGeY=;
 b=j1t+II/VMpl91WjxD815SvcD/CcG4vg4f36zh/LztwnoweLEBcNbLu1IEj6qLSY4iWujpGaModxU1hARcACuBP32XEBSDP/eD884b88cY2i0Ti2fCQUp4leHSDQzXae48KDUEe/YqhnWF1PzjjAc/eWx+2XL8jRGTxb58Yzdw7I=
Received: from DU2PR04CA0219.eurprd04.prod.outlook.com (2603:10a6:10:2b1::14)
 by AS8PR08MB7744.eurprd08.prod.outlook.com (2603:10a6:20b:508::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34; Mon, 20 May
 2024 15:20:48 +0000
Received: from DB5PEPF00014B8D.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::a5) by DU2PR04CA0219.outlook.office365.com
 (2603:10a6:10:2b1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Mon, 20 May 2024 15:20:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B8D.mail.protection.outlook.com (10.167.8.201) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7611.14
 via Frontend Transport; Mon, 20 May 2024 15:20:48 +0000
Received: ("Tessian outbound 082664cc04c1:v315"); Mon, 20 May 2024 15:20:48 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 9cf0a2fa07a0e50f
X-CR-MTA-TID: 64aa7808
Received: from b3709525a968.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9A4ABC3F-346A-458F-8EC7-7A18FFEA6A9E.1;
	Mon, 20 May 2024 15:20:37 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b3709525a968.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 20 May 2024 15:20:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5PjBAS6mC3oQqW1MxKDl7t4ZQE9Y1339Z2ShY/PWzrwB8691DYMr4LpACefgmXYEpSP5FZQ/IPd5RKKiEWuC/fB5dVGDGOF3zJ0nNFCYV9r985LRUGr2AA+oMdzvB8RsZY/faUWO8PSp17+tH+TnQ2sZs4AixQJF7a2ZFVY70NkWaVEYruB0IV4RKnT6ssWdgoBGCYXUOW0kpJzTy9ZkwDdfc+OLiO0kOCQJCISyx5ItItHM+3hFaUxRNr/jtb4SCNie4C5W4pCUvXwZr9q8IuFKAtVVlftP7hdjH8ca7l7p+AjP/Ft57S+OnlA+nLM/isGwx5h+ltMMJNils3yzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5Qimm6mITQPTXQAqo+H+Ec7y0cHMHFuY5AS9yWnGeY=;
 b=NQyaAI+t/pufaY53RXOWPxGrMTNWWdkS1TvTgquRX6zTFK4mCINSV6/E39iLlakKXc4hwrEa925Ae/4jCG2q96aEQCFHXS7dv1gCB+CNDu1ik1m9FvOSXMC+2AprnKN26nJ0g+tvVxdytJFDxELTAy5j/QJNt6j7Ber7CwqrhJMBrhi7TRWyHxYgQi7Q5EMxDwuPMz/DNcAeqIFPVjFVZKDo3V66qM5Gub4qRgIPx266dg2ad5H+LmeYu9dV6bWkn+L/tkLbFg2RokFrmzcNBd+4L+10+xZoDfr7/oFb3+wY2Lrvb7bP19F4I8G6aZsUGbmvhJ2SQ2E1R4qd8OHKqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5Qimm6mITQPTXQAqo+H+Ec7y0cHMHFuY5AS9yWnGeY=;
 b=j1t+II/VMpl91WjxD815SvcD/CcG4vg4f36zh/LztwnoweLEBcNbLu1IEj6qLSY4iWujpGaModxU1hARcACuBP32XEBSDP/eD884b88cY2i0Ti2fCQUp4leHSDQzXae48KDUEe/YqhnWF1PzjjAc/eWx+2XL8jRGTxb58Yzdw7I=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com (2603:10a6:803:c4::31)
 by PAVPR08MB9209.eurprd08.prod.outlook.com (2603:10a6:102:30a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 15:20:34 +0000
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::77d4:d040:b19d:6472]) by VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::77d4:d040:b19d:6472%4]) with mapi id 15.20.7587.035; Mon, 20 May 2024
 15:20:33 +0000
Message-ID: <2e1baaea-c18a-453c-9dec-1036966f1baf@arm.com>
Date: Mon, 20 May 2024 16:20:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, tglx@linutronix.de, efault@gmx.de, nd
 <nd@arm.com>, John Stultz <jstultz@google.com>, Hongyan.Xia2@arm.com
References: <20240405110010.631664251@infradead.org>
 <3888d7c8-660e-479c-8c10-8295204e5f36@arm.com>
 <1461277e-af68-41e7-947c-9178b55810b1@arm.com>
 <20240425104220.GE21980@noisy.programming.kicks-ass.net>
 <20240425114949.GH12673@noisy.programming.kicks-ass.net>
 <20240426093241.GI12673@noisy.programming.kicks-ass.net>
 <c6152855-ef92-4c24-a3f5-64d4256b6789@arm.com>
 <2fba04b0-e55e-41f4-8b7a-723734fe1ad2@arm.com>
 <219b8b49-3767-4010-aa68-9e1cf66c2ccb@arm.com>
 <20240515093649.GF40213@noisy.programming.kicks-ass.net>
 <20240515114828.GO12673@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <20240515114828.GO12673@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0464.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::19) To VI1PR08MB3919.eurprd08.prod.outlook.com
 (2603:10a6:803:c4::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3919:EE_|PAVPR08MB9209:EE_|DB5PEPF00014B8D:EE_|AS8PR08MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: c52d5795-d164-4f16-5964-08dc78e06d62
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?MmR4OHhZc0ZHallIOE1nMVRQL2tCZFdpMnp1b2FramJRbVladjdtUWRVbGZV?=
 =?utf-8?B?bkgwTjN2MDdPT3luME9kUkp1V2hYYldmWkdnN3E3SmpTbVg2alQ5UTdob0xl?=
 =?utf-8?B?YXVIbzB3MWNkOUNwZmRwb1VCUVpxakhVRGhScWs3WHBLeXFFdmdyWGR4eitV?=
 =?utf-8?B?dWoxR3JPSFVSSUMwbFQrUmpPaGdkUndSamw1d2VGVWRyY0R5Zy9zTE83NERt?=
 =?utf-8?B?aE84QUdlRUlUbSt6MjZZc1JiYUFWU2dRQy84aktIazlBenlibmNCYVpnVDJr?=
 =?utf-8?B?U0tCR2hMTEhEdFJJYndpRmdha2k1SVNHWmFQUlljUStSbVp3dktpZG5KVTFE?=
 =?utf-8?B?VDRYdlZQMnBuQ0prdzhSanNpclo2dWRrUlFWNENhR2VlRTFTWGRkU3Uzd1hL?=
 =?utf-8?B?NlQ1UWh1N3NDaiszWnlwY1BDenZnNVhYNlV0U2FHVlJDclEvdnV5Z3Y5UXZr?=
 =?utf-8?B?eFpOZEFLQVBwRG45SzQrdk9IVkQ2U3g2VUU1ckZkeHhUNW5KTnkzL1JYZXBG?=
 =?utf-8?B?L0lEMm9udVJ0S0U5bkFVUkV0Q1JvMUJxeHN5U2xtcmo3WVNiZFl3M25MUWV6?=
 =?utf-8?B?SG1zK2JTZ3FhSEl2bXEzSFVKWkZ1Nm5EUDNhd0FIVUsvclNrQzFDcWFyWXpl?=
 =?utf-8?B?WnFzakJPNWdtSzdobXBhNEFUVmlZSGpHYlQrallBbStibi94TmMwWWswUFZP?=
 =?utf-8?B?RCttREdUc3A3eU9lVEwxdGVlMGUxOThlclp3Z0JrbkhBNnhlVURUdmh6djZj?=
 =?utf-8?B?M0tXYlpUQU9Bd1hsYUNNQy9peGxOdlBDYW9CcWxsL0pubnp5UURib0h5L0c5?=
 =?utf-8?B?ZHNoYnNjVVVDQ2srTC82WmdrOGdQZ1dIcCtnbmJuYzFaaTVjdlhydzdQelFN?=
 =?utf-8?B?RkFKL0V0eDFzcjVVbnZaMnhia0ZlbXI0ekNQdllQb2VWMkZSWHNRd2JvWWwx?=
 =?utf-8?B?Si9pYm42V0tibUp0dzA0bFcvamN6ZG1oRU9SMHl0MExuNXhJZlhMWXNqaSsv?=
 =?utf-8?B?ZVFVUHJwalF1ZzVJWE5NY2poR1ZRc0pKUTR5RzhFMmxyVlQ4MDZkcE5vd2FJ?=
 =?utf-8?B?VHNGYitObEIrZkZIN0p6c0VoY0VHY21CLzBjYWFuT2dnRnlvU0VyQXkybUJQ?=
 =?utf-8?B?aFQ5bDluRFQ5OGdHRENLK2hWYnpodWhMWERJN0NpdlZoVURVaG9BdnpmWVBX?=
 =?utf-8?B?bEl1OUUrZUIxMVcveEN2MVp2UjRkcWd5a3VJNjIxSHBJVnpmVDFwcXZReis4?=
 =?utf-8?B?d2ZJUExaSVZFRFR3ZVdYNEhNdUJVazFhdFFuZE9pVC9CL0RzZjB2TjJzeGlV?=
 =?utf-8?B?enF1RHd0RUlkV3VGN1lHK2lydU9ZVUFxVW84VVk4dTdrVTR5M1c5b1pwMzBq?=
 =?utf-8?B?RlFqSGRuMERGc0M5WGRBTy90ZjMyOS9zSTk0cWZvYyt0UnBTR3p3dTgxQ0VM?=
 =?utf-8?B?dit5QjdMdkY5MmRkcFBab1B2Q1p4WGl1aE5Na0NQYUJrTHNlVG9TOUhHbksr?=
 =?utf-8?B?NlBsaXAxWWVpdEVYd3BBek1RdFI1N0c5SEg3VE03NGE4SzBHeFJZTkM0UXJS?=
 =?utf-8?B?SUx4VDU4ZG5wTE1aMTI0SnB3aGJ4WFBkYURtZzdvWXg5RHQyWmxOSXRpWDFj?=
 =?utf-8?B?TlQ1bisxOWxWUkk1NitCZXhobjRyQ1ZyY3Fublk3YUFKVSsrVHlBeXVGb004?=
 =?utf-8?B?S0xEeWxmRDVvZ3VnSEt1cmVKdXF2YnVZSS80N0lGdFJTTlZXMGhwV21BPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3919.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9209
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B8D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6f453c81-75ea-4ac6-b729-08dc78e06442
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|35042699013|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWh0dzhLV1pKUStBdnZ4bmtjTjROYllHNEgxa3ZlZDBaNmJZQisrK0M4N0Fo?=
 =?utf-8?B?aFYzZEVWbnd4cVhCRXBTWE9WU2lpdmpKek5ndGhqMGwrK3R0MTNza2ltcTVJ?=
 =?utf-8?B?NkhQdERCZnNsVDVkamtlUnd6T1RwZURQMTB3QkYzekExamZRcEVZUkZ0c2hp?=
 =?utf-8?B?cFh5MUoybGhIZndOdnBvQ3hDQUY0dDdESjlmOFJINDNNbHhaZVFPTWthT3lW?=
 =?utf-8?B?WUdCLzVyZjlSVkwyR3dTeXFSbEZFZXowWWQ5bDN2S2JlK3NZL2pBMXhad2ZU?=
 =?utf-8?B?aDNqandlWFJMdW8wTUtaMUEycGdGa2dCWnplWTZBazlOUmllSlQyTzh5L2I3?=
 =?utf-8?B?MjljU0NMSVFPSHZBcWE2N0tOQ3hDTVNHK25sRGNCSDhQdHNJNnZ4czk1cEZJ?=
 =?utf-8?B?V3k0aHJ2c1RSZjRqM1M3S1VQWjYxY0xtTklPZzFmQWw3dXFUR09JTzRGMnBK?=
 =?utf-8?B?WTJlRXFMbGpMK1V3a25TcGo3djM4blpZMS9iREpqUzFDMU55RVhBeTcyTTFX?=
 =?utf-8?B?N3dDSmd4MGxqUmVTQnRSd0NNMHM3ay9vTDM2L0t5T2xSN2ExZllIZmhsM2pW?=
 =?utf-8?B?cmYxWEsyT2lCRVdwMzFZMTRqNlRQeHBCK2daUWxNTnN0Zys4WVRDNnZPU1FT?=
 =?utf-8?B?QlJubElRazJ0THdCbldTZ0NjMkh1YWY3cy9KUzd2NTZ1anUwdUpickxVSTky?=
 =?utf-8?B?ZDFmUWNIQnAvQXpmV2YwWEJ2L01HM0pKZ0lySXpOanFSSXBCUldFSTZ0Qk4w?=
 =?utf-8?B?OTVoWFMyZDdtMzRXR28rTzZzZXIvSm9JWnVZb2R4S0tNOFJHNC9HdWtybzNt?=
 =?utf-8?B?ckUzN1B3cUIyMjVPRm5UVE5GMVYwZUVUZFZOWlgrL3lIbmF3NGNOaUpYcmpN?=
 =?utf-8?B?cnRRVGtveUJ5Sndzc0lpL0pTTWllaVlic0NSaVFkbFY5ZnFLQXZNaEN4M2sw?=
 =?utf-8?B?bm1nME9WMnV1SE1SdDZVVmRZRjNsek1iVVFRNWF0RnRJWWFQVmpOV1ZMWXFE?=
 =?utf-8?B?VHpnMkxHUXJoaVdYVmZYcW11TDdsV0JVZHcvYjc2bm5OR1E0cVFxNGtEaDk0?=
 =?utf-8?B?UXV4a0txZ3F3aGNKZ2xMeThjK2xBMmY5clF0ZFNKbENCaFF5ZU5zQzRNQ3R3?=
 =?utf-8?B?ZFFtY3p4TGNkOEhuVC9SSHkrZTJZR2lqZ3B5S1VIVHNHZUYzY2FwNHFYb05Q?=
 =?utf-8?B?T3NrR1Z4WWdIcXZMalRLTkFDUmU4VVducEtMU09CcXNhSGw5bHBHcm9WQkl2?=
 =?utf-8?B?WmFWdlE1ZVBhS3BnUjZLdE5FOWRxZ1ZjS1VDakhPT3NoNkc4NUhINzVMeFRG?=
 =?utf-8?B?UDErVGk5dFZ5QmFFZUxQaUdHcDQyTGIvNEd5Z0RSYnhoSkt5NzZOZjNGUEdZ?=
 =?utf-8?B?UVlrVW5Idnp3azBZSCtQc3J3ZjBaY3ZrOGNTVFlFVUw2b3NrT0hOZW5OQmZm?=
 =?utf-8?B?U1hMbXhDcWdhNFlseTRHY1lMQmZMa2c5N25hQkl6MHZlTktPVmV4TDVBMmRG?=
 =?utf-8?B?MFE0TFdZSlEzSnYzb0ZKbVFLNUViWHVHbm1ONTBURFA2eXp2M3UrVkZtdjZK?=
 =?utf-8?B?R1B2YVNJb3JKblR0aExneVNMc055WGcySHVjaWJGaEtLcjNnN0krTndrWWd3?=
 =?utf-8?B?L0pPMmJRcEtJN3ZpbEs3YmNiK3ZRL3pDclJ6MC9xZWVOcGhHSE1pdVY5YUZF?=
 =?utf-8?B?alR3aUpOVWNNVlpEYTBnRWU1aDFlaUcxNXFpUlk3WTRnemhFYXFORUNZbU5T?=
 =?utf-8?B?SXdSUjFOQWM2akxlL0lZQytDZEVoQU5uYVIzNFEzbTI5OXBKVXg3ZVQ3TlUz?=
 =?utf-8?Q?NghYjCYdFdXg3zB4/7oh3METk16vQWloYbJB0=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(82310400017)(35042699013)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 15:20:48.2780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c52d5795-d164-4f16-5964-08dc78e06d62
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7744

On 5/15/24 12:48, Peter Zijlstra wrote:
> On Wed, May 15, 2024 at 11:36:49AM +0200, Peter Zijlstra wrote:
>> On Fri, May 10, 2024 at 03:49:46PM +0100, Luis Machado wrote:
>>> Just a quick update on this. While investigating this behavior, I
>>> spotted very high loadavg values on an idle system. For instance:
>>>
>>> load average: 4733.84, 4721.24, 4680.33
>>>
>>> I wonder if someone else also spotted this.
>>
>> Hadn't spotted it, but now that you mention it, I can definitely see it.
>>
>> Let me go prod with something sharp. Thanks!
> 
> What's the point of making notes if you then don't read them... *sigh*.

Makes it look like you did read them? :-)

> 
> Does this help?
> 

It does address the load_avg issues as Mike G pointed out. Thanks for the quick patch!

Unfortunately, for me, it didn't help with the energy regression. So my investigation
continues.

Something still seems to be driving things out of the smaller cores and into
the bigger cores. And the load_avg accounting proved to be a red herring.

> ---
>  kernel/sched/core.c  | 23 ++++++++++++-----------
>  kernel/sched/fair.c  |  4 ++--
>  kernel/sched/sched.h |  8 ++++++++
>  3 files changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5ffd7e047393..43f061bcfe54 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2154,14 +2154,18 @@ void activate_task(struct rq *rq, struct task_struct *p, int flags)
>  
>  void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
>  {
> -	bool sleep = flags & DEQUEUE_SLEEP;
> +	SCHED_WARN_ON(flags & DEQUEUE_SLEEP);
>  
> -	if (dequeue_task(rq, p, flags)) {
> -		WRITE_ONCE(p->on_rq, sleep ? 0 : TASK_ON_RQ_MIGRATING);
> -		ASSERT_EXCLUSIVE_WRITER(p->on_rq);
> -	} else {
> -		SCHED_WARN_ON(!sleep); /* only sleep can fail */
> -	}
> +	dequeue_task(rq, p, flags);
> +
> +	WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING);
> +	ASSERT_EXCLUSIVE_WRITER(p->on_rq);
> +}
> +
> +static void block_task(struct rq *rq, struct task_struct *p, int flags)
> +{
> +	if (dequeue_task(rq, p, DEQUEUE_SLEEP | flags))
> +		__block_task(rq, p);
>  }
>  
>  static inline int __normal_prio(int policy, int rt_prio, int nice)
> @@ -6693,9 +6697,6 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>  				!(prev_state & TASK_NOLOAD) &&
>  				!(prev_state & TASK_FROZEN);
>  
> -			if (prev->sched_contributes_to_load)
> -				rq->nr_uninterruptible++;
> -
>  			/*
>  			 * __schedule()			ttwu()
>  			 *   prev_state = prev->state;    if (p->on_rq && ...)
> @@ -6707,7 +6708,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>  			 *
>  			 * After this, schedule() must not care about p->state any more.
>  			 */
> -			deactivate_task(rq, prev, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
> +			block_task(rq, prev, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
>  
>  			if (prev->in_iowait) {
>  				atomic_inc(&rq->nr_iowait);
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 536eabcb1a71..596a5fabe490 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7032,8 +7032,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
>  			util_est_update(&rq->cfs, p, task_sleep);
>  			hrtick_update(rq);
>  
> -			/* Fix-up what deactivate_task() skipped. */
> -			WRITE_ONCE(p->on_rq, 0);
> +			/* Fix-up what block_task() skipped. */
> +			__block_task(rq, p);
>  		}
>  	}
>  
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 12841d8195c5..48e5f49d9bc2 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2560,6 +2560,14 @@ static inline void sub_nr_running(struct rq *rq, unsigned count)
>  	sched_update_tick_dependency(rq);
>  }
>  
> +static inline void __block_task(struct rq *rq, struct task_struct *p)
> +{
> +	WRITE_ONCE(p->on_rq, 0);
> +	ASSERT_EXCLUSIVE_WRITER(p->on_rq);
> +	if (p->sched_contributes_to_load)
> +		rq->nr_uninterruptible++;
> +}
> +
>  extern void activate_task(struct rq *rq, struct task_struct *p, int flags);
>  extern void deactivate_task(struct rq *rq, struct task_struct *p, int flags);
>  


