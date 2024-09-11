Return-Path: <linux-kernel+bounces-324714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2836975006
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F251C20C96
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DBB185957;
	Wed, 11 Sep 2024 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JwG81FCi";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JwG81FCi"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2045.outbound.protection.outlook.com [40.107.105.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8FD18454F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.45
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726051606; cv=fail; b=hs9HrW5cbC+N+dLRakJvbcLKCD7v7XVIqp35wK3/NEaBE7ipwf9pGO1V6yvY+v+xNva//qWmp88/bFka6KGYxA0ui5okuT3nQtDaEO5jN/dj2gT30SoBg6+LNkQ/erlfQWIgzW/kgZf6iVyoDRlZjyBohPj6/5leHOJKHzXTfEA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726051606; c=relaxed/simple;
	bh=J7XVwVdQnadPdQ8j9yYw6p9pU6sV5kszxKM+xU/1tBY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tyxCR+MsaqcHAndDbKvjkW6xcqwlf/HlWYujQBoYBTsAxOkl8ItFAN3oZEUjb2NWCSmm+zFnsPRDubjH5FujzlRupi/FcWehI5Y0+9z1o0MEXYwKIsL/NHU6ZAuCxrMGsGG6d9yGi8Bu9/Bu9bJisPu7R5wNCA8SU274uMRbcac=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JwG81FCi; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JwG81FCi; arc=fail smtp.client-ip=40.107.105.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=VHlOTz0fr8MfU2BzIUO1fnlemCEnEK0iMcfn5O/0f0vMYqWtimBXAfSh2eWwlVc8C0h/PKa6eJedPQPpsRx2LPDh+D5E0jgU1PX/+y7DMdW74f8q+NtVfqPN1lg8q8Ig1RLVk6UhwOqS+S5AwF63XPd0pfc6UgcXNtw6fMkGNf58hC3eYfzcS2szkiKhAWqwr7W24a58ZQQrSX3t9FBLc1+0HRBZ5Qcvb2WjQ+0/mVEc0Tig0cZXRHDRiEghUJWTApJADf9deT8VmBn9McwR8Ch1iY/mMc+pzvXdusweAZWyTTD4J/xcBhtV9IhjtBwHWEkodIvFHtuzcrOCEDUEag==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rswDAqKWIilV6/I10oDKVJuoBMxd/k0oNswCtTpmMp4=;
 b=UiccQ9CRO50TzjzPTR1yJIcw84vsQkkYmEJcnZX8pXMhkdZ/YSpTyHn6IuNn+9q4zXce7HQ7hGjVVDIWmAP3Dzh9MimxkYgxtUNOWvz1Yy2CyFTKJ2ruQmuUL8Fc5nyNHg0e2SSM4ZNWn7q7s2iqRupR3NDX3A1fsNSuDCq3OnPTL2JTcHYdzeQxoY7VPZ6tFPUsKrvX49RRLowPahpB+Xq0mUY2MCk3xt5nkR0r8yDvAu6q/m0RaXx5y9a48Ion6oKa1AMeQjOBuPOe359uXYs4qqgCSemQdGM16Sw2OSGidJYeh5uhyOy9KsSa3jI59Efudcqzprn6rUw1IqLuMg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rswDAqKWIilV6/I10oDKVJuoBMxd/k0oNswCtTpmMp4=;
 b=JwG81FCivB12jpEduLYRvpoPs8TI5Bte/mnH8cWIqxRTPafiTD2wEBlmJp6uabY9O6j0E2IFen6sK08PdY4J8XGzz6hH6AGrswQeA+XB9YAdrF5USD2LT82dQFOMOKOMHfN5H30u5HZj7YtaLlziWGG2ftONv/gsRsz9L6irgbA=
Received: from AM6P192CA0058.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:82::35)
 by DB9PR08MB8483.eurprd08.prod.outlook.com (2603:10a6:10:3d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.15; Wed, 11 Sep
 2024 10:46:33 +0000
Received: from AMS1EPF00000042.eurprd04.prod.outlook.com
 (2603:10a6:209:82:cafe::46) by AM6P192CA0058.outlook.office365.com
 (2603:10a6:209:82::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Wed, 11 Sep 2024 10:46:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS1EPF00000042.mail.protection.outlook.com (10.167.16.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Wed, 11 Sep 2024 10:46:33 +0000
Received: ("Tessian outbound ee7a81b3b7b9:v441"); Wed, 11 Sep 2024 10:46:33 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 354b4be30e6c899e
X-CR-MTA-TID: 64aa7808
Received: from Lebdbc63db684.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3ED6D671-A15B-428C-9CD1-009988547623.1;
	Wed, 11 Sep 2024 10:46:23 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lebdbc63db684.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 11 Sep 2024 10:46:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJ9jZKq+HGh/H1MUtoyWt8d/nW4knmkeohtRQINFRyvjXVHR/HSI96DCKAwTbgH5P+G20eJ83Kb4rm5zZmu7ydfFtm+SHbZy/J1CLX4TjhNTiwNncDlaVOozQbGw0/r1WzD98BsMueVOOnuuXSAS0OUHdzRCdSbbRvVEyA6dQ4I1678aCOoZGOHbQ2/4JPe46CKfwwmc0LAWl+IM+1/CjdPIiahtI0T8F/8rb91QzXa/2oWNayFjcpvfoZz5G0cN2RaSZjjpNjN1o9tm7S+Wdfgw3FoCLwoLggeQ4F0Vc0UNLdbW/UnEMHM2pa1t76Sx0AKgqay2XBqd3oomWWZR8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rswDAqKWIilV6/I10oDKVJuoBMxd/k0oNswCtTpmMp4=;
 b=OL949afNXwyaZtagtp+Uwoytn+TopJopw0m8JrfVu2nhRqsFrjSWKbLHRVvdWmGMDd1tXsCuX3cqgxkKxIMh3/6Pa02bOzwip3et8s5KcjU7OXUPyEH84x8EP7pJWG36+TTKFmMR+aN3fUanx34ih4o09PoRw6C94Nhk7HG4VIsIfdfUmftiXaEOkd7yV6f4bdoMj2WxMmN/w8Y+SEOu7HS83BVq52NtGf+XsRQVcqXvuKxDjI/rE4u+VOBiCvXTYO/DGmw8XEmCerq1I1Hbwx5wBSB/gKUwYmMcw3ZkR9neXsonFbHcy4yNQYdHH0JEi4N0vec7ildjTiIaFovu7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rswDAqKWIilV6/I10oDKVJuoBMxd/k0oNswCtTpmMp4=;
 b=JwG81FCivB12jpEduLYRvpoPs8TI5Bte/mnH8cWIqxRTPafiTD2wEBlmJp6uabY9O6j0E2IFen6sK08PdY4J8XGzz6hH6AGrswQeA+XB9YAdrF5USD2LT82dQFOMOKOMHfN5H30u5HZj7YtaLlziWGG2ftONv/gsRsz9L6irgbA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com (2603:10a6:102:8e::21)
 by DU0PR08MB8447.eurprd08.prod.outlook.com (2603:10a6:10:405::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Wed, 11 Sep
 2024 10:46:18 +0000
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d]) by PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d%3]) with mapi id 15.20.7939.010; Wed, 11 Sep 2024
 10:46:17 +0000
Message-ID: <5d1d55e1-3d2c-4487-b91c-639187e1546c@arm.com>
Date: Wed, 11 Sep 2024 11:46:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Hongyan Xia <hongyan.xia2@arm.com>, mingo@redhat.com, juri.lelli@redhat.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, youssefesmat@chromium.org, tglx@linutronix.de,
 efault@gmx.de
References: <CAKfTPtDO3n-4mcr2Sk-uu0ZS5xQnagdicQmaBh-CyrndPLM8eQ@mail.gmail.com>
 <aa81d37e-ad9c-42c6-a104-fe8496c5d907@arm.com>
 <c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm.com>
 <CAKfTPtCNUvWE_GX5LyvTF-WdxUT=ZgvZZv-4t=eWntg5uOFqiQ@mail.gmail.com>
 <a9a45193-d0c6-4ba2-a822-464ad30b550e@arm.com>
 <20240905145354.GP4723@noisy.programming.kicks-ass.net>
 <20240906104525.GG4928@noisy.programming.kicks-ass.net>
 <8d0d01b9-a430-49cc-93a5-67b4d68aa35c@arm.com>
 <20240910140524.GH4723@noisy.programming.kicks-ass.net>
 <52ca4cea-8f65-434e-af17-e4bf664d9488@arm.com>
 <20240911084528.GJ4723@noisy.programming.kicks-ass.net>
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <20240911084528.GJ4723@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0017.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::22) To PR3PR08MB5852.eurprd08.prod.outlook.com
 (2603:10a6:102:8e::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PR3PR08MB5852:EE_|DU0PR08MB8447:EE_|AMS1EPF00000042:EE_|DB9PR08MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: d53f4926-e57a-493a-df95-08dcd24f00cd
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?TlYzajV5TU9pa09lUjVJbkFoKzNnYWRXcDZvM2Iwa3RveG5pSkJ0dGZMVU9u?=
 =?utf-8?B?ZVQ1elFpWW5nVXFLNE1pNm9YVTh4KzI3RTZHcXk4ZVBkbjBMUHRQd3JDSWc2?=
 =?utf-8?B?REVRSGVUVHZsNWtiMlZTN2RNYm1QN2VIM1puYW9GVk5mc3FSdUExNk5oRzRy?=
 =?utf-8?B?Q3FaNEVHdEU5R0V2bGRKVUdPM2ZqakxuQ2JHWWhTS05qTmdQWmNzNm1qN1k4?=
 =?utf-8?B?Q2NXcGxoMDFVaEdSWnd0ZHpqdUJRN1RiaWVBZmZBcUVDM0xmR1BtNHVqQ1Rq?=
 =?utf-8?B?bGZXc2t6K3BJN1FpNXJBTEVzd1hOVC9PbUtXZnc3S05qcHFoSlpMYmlTT1Q1?=
 =?utf-8?B?bSsrbzhXc09ON0RRdnovSEdaZVRyTkJGbEI1OGVGS1B2OURXZ3BCUTlZekp6?=
 =?utf-8?B?RXpmdXpzYWJSZks0TDlWVFpOa3Nad0VyR3pzMXFRbmhHcUtidWtRMnB2SGlF?=
 =?utf-8?B?c0szWWxQdFZjZkEzTmU3cXh4WVVMK3hVS0NxeXdmdmRXdkRDcTBxSU9nYlJs?=
 =?utf-8?B?YzhnU1FHaE1hUGgvMEhwRjRUWmFBRnQwamlWemFNZkRMMGIwV1cyd2ErSUZK?=
 =?utf-8?B?TktGTm91d0w1bEtkckNBV0dzMFpRSzE0UHM2aXRPMFRsK2ZLb21DRCtOb1ht?=
 =?utf-8?B?eERPMU9DcGgyaGF2Ym1pbXM3Z05PRFArODJ5dFRKeTlicVdpb3FwR2l5cUhQ?=
 =?utf-8?B?RWRLdW5tMy9sMTlib29YbWVQV21xWGt3S1ZhMksyZkxSZnJlUWlOaCtEYkZZ?=
 =?utf-8?B?eUI1M3VxTXZxK1ppZE1KUGIrRzVGOGRzck1mR1FIVlFqdmk0NUhmZmdnYUda?=
 =?utf-8?B?cmY5em1BUVpSaHVqdnhnbUxhOVFubmg2Q1RnbzVLTUs1aTRnbU56NEZvdXIx?=
 =?utf-8?B?WnYyeWV4VkwvcVpMVXZ6cmFKUzlGU28vejVBZERRUnRQS0pvU29JV2JqbjB1?=
 =?utf-8?B?Yy92UE9IbUZlUjUvS3p0UjQ4Lzc4c3A5Y2hYVDlyclI2MkQ0R05Cbk5PTHpi?=
 =?utf-8?B?MHFMRnZXU05IODdaTWxwOUcyZkRwZWV0SWI0c29QQ0lGZWFFQ0RHZHQzZWMy?=
 =?utf-8?B?R0tsYkZPN1N3M3F4RFE0SWlhRUpydFUxaHpNU0VZYTdkV3hqdHdncDRIOEdv?=
 =?utf-8?B?UVhjNEQ0bFROQ0wxeUtWYVlnd2hxR21aTG45SDNvVlNtblAyR2hEU0lkdko4?=
 =?utf-8?B?NmVzTlgzMGcxS1ZWMnpXQUR1MldyVVpCU1FTV0JQcUR3QU84S2lyMS9mc3RR?=
 =?utf-8?B?RUxuMVdFcDBFYXVBRUdWZFRVU3UzN2lnMklRVnA1WFB1eVNLOXY3ay90Zk5i?=
 =?utf-8?B?MUVZMVd3V0lUUlpZTFJaVm1HcTFUYk5MMURuOTdQZ3JjWGZmQmdGMGhLZjhC?=
 =?utf-8?B?TW85ek9zWHZDa2FUcHd6ckRwbGgrbEVUN1hwTEdRWmFSWER0Q2xUNXRkUUlw?=
 =?utf-8?B?L0RCSG5WNm9uRUlQQUd0dGV3N013TzVoVDhtVU15WVA4Q1lKVk85SzNSOHlz?=
 =?utf-8?B?Y0dYaGtNMkRCYmU3em5MTjFHUzBCVXllQU5zUXJqVUxJTmRWeEpEL1NiTXFz?=
 =?utf-8?B?SWYxVFhiVlZiR3BrMGk0elF3UC90U25jRWFSZ0ZXOEJiWmZkRlF1WXlZRE9H?=
 =?utf-8?B?REhMZzltaUNEbGRXZzNKNG52RDZTSVFzWHhYNTdKc0JoRWRTUUVWQTNsbDNK?=
 =?utf-8?B?Z3Q5bUtUZkVHK0hmUGR1dE1GNFZKbGZuRkxKT1ozVm5lYUxFVzdmVUJaRk53?=
 =?utf-8?B?Q2JxeUd1MU5jNFNuakh6b2VjcmNGbUFWdHBMc1JxeHJENHk0bVpPbE5PdUkz?=
 =?utf-8?B?MzAvWHVZT0hKUy9vMzlDUT09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5852.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8447
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:102:8e::21];domain=PR3PR08MB5852.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000042.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2ddedd26-53de-433e-e414-08dcd24ef69a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|35042699022|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVQ0V05xTnlERURtVmFYTXhXOHJIYzRvalllTlZzZVNEMkFlS29wWlkvdkRE?=
 =?utf-8?B?T1RwWHhXOXV0SnY5VEkrdDRPMG5icWRUMndwMlNXMmZZQ3Q2aTBnL2w5TnZQ?=
 =?utf-8?B?SjFCdFVrcVNoTnBrT3AzQXdGWUd5dmJkQ1FybUhHTnhROWh3WXMxeVdWQUdS?=
 =?utf-8?B?eWpsYWpWZ0Q5eWwzMWN0czQyY2k1dmx0dHo5dWpvekZFTCtpazZIS3NkdEZK?=
 =?utf-8?B?V1FjUGJwS20rVzZ3ZmhxcU9PV2xjQkI5dnowVlBKcU8ramFGQytzRjBKamE1?=
 =?utf-8?B?Rm9ETVhFYXJwL2Y5VERZWGljSHpwdjIzc1VWMTQzM1Awc0dpU0p0QmhrQ0Zk?=
 =?utf-8?B?WmpUVEZKTDBib25GbzU0WHBUUUExYzNEMnpqZUUrU2JvSDhuUjVjU0liVDR0?=
 =?utf-8?B?TUhKT1hoM0MzYkl5MERZY1hVMkdHb0dTdTMvalg0YnAwdEpSMXE5ZHFld1JP?=
 =?utf-8?B?SUh3dzUwaGsvMlIzMkFWN0JCSVRZVWhMdWxjQXp6L1RUVmtiaXJPMjF5MG9t?=
 =?utf-8?B?NUFQTFBxRWpoZ2RjU1N2MkozWksxeVFTQXdWVDl2RW4xbDhzbklYL2ZFdmNm?=
 =?utf-8?B?QTlCZDJrQW01NjFRTENPUExWRi92TmJUbzdPOFBnZFN3V0h2c2prVmpCbzdi?=
 =?utf-8?B?QndaMUdPZHpwRDVPK3dET08wRUlYbCsvcmdTc1o0UXZXWnVmTzd6Sk5abHlr?=
 =?utf-8?B?NEV0WXRkcHF2TFdwWGFmWXNmT0xuUncxbDdLOFlDa25QRjl1SEZaTURVNlND?=
 =?utf-8?B?aStKUFVDcGQ2aFRNMWxVbWY1bWhIMWxmLzQ3bWVFRHVPVkhwdG1tRXMrbVZ1?=
 =?utf-8?B?YVdYWlczZkJWTUN2ZWlHd3B5NHhENUtRdG5VVXFsOHNja2ZKdFc5RWJBc1p3?=
 =?utf-8?B?dmhSSU1hV3JDZ2NmN0VyMHZkWjE0ZzljWmJDaWMxSWFoY0xRODZUWU5LVTh0?=
 =?utf-8?B?ZW5rL3VHdEFqNm9zbjFERkdJQmZ0dDcvcUpKR1BsZk9zdGZCWUZmVDc1MTl0?=
 =?utf-8?B?bkN6aWd5ekJ3b1dPOWdNZEp5WENhcWJXcmlKcXFXWk1zOUV6TldoU2ZLRTI5?=
 =?utf-8?B?N1FkNURuQm5qSW5ackFsY3ZVWGFsYXRDY1dkRFpaTklMb05idldNMWNlMlkv?=
 =?utf-8?B?Y1k2ZXh3Yms3Si9hRTh6SUFBSkpuWHY5S2hoRU5JcGRaenNNSkFSWlJUVFVx?=
 =?utf-8?B?eUVvZGNXcEovWFFrY0JFaHpkazVXRFowbEtLQUp3QmVubTlpR0xRcjVFNVNa?=
 =?utf-8?B?cmxqYW1DZUk5empWZ211VTF3SndCakFZT1hSUmVJS1ZudFB1SkppNjBCb1pZ?=
 =?utf-8?B?TzRmN0pjdEcwcjN4UEpVa2VqNUVTQUYrZldnNXc3LzQ0QmJrRlZ0RWZkdlp6?=
 =?utf-8?B?aGRDV0t4QkE4WUQyRGE3M09McXZUTU1LaFQveCtlUklVejYxQWx2V00zR2s4?=
 =?utf-8?B?YVRsME5GWVU1WS9BL3hqZFVVMndzNTE4cE04SVlUTUVFcXBWeEs5VEVFTFhy?=
 =?utf-8?B?MThFSGp0b09UTVFOZW1TV1lYRS8wWi9uNTlsTWJQS0F0WUptSHYwOVhwVncv?=
 =?utf-8?B?V3lCcERaODhYemhXVVdlMTFFOUk5YmNGeWsralllKzArM0NaT0dYUUpwMU8v?=
 =?utf-8?B?WU5iU2FYdklPNE1DOWx3SDZnelp2dUNSOFQxcEZDc1lwK3FrN3ltVm0wSmtP?=
 =?utf-8?B?Nk03WVdJUjNFajBWOGQxeGorZlFKTXhST3c2MzVRMS96d0g4aGxNQ1JPbG5s?=
 =?utf-8?B?VUtkUlFOQWFvZUIzMjVwM0NDS1hTeHNaVWRjMnpKcnV0SWtFRTJhV2h3VjBR?=
 =?utf-8?B?MmdvSDhyNFkveWVINHI1UStCZzV3eXhCbGxYa0p0UjFPdExqMUxFcHNoL25z?=
 =?utf-8?B?WUFKVUhWUmg4UXNXblpobzIrWi9DS1BVOC8zSXFreGo4T0VDY0Mxb1pCS05H?=
 =?utf-8?Q?Uoh8/6vaR6xb8WBF33Nc5gaXbj30Iiz6?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(36860700013)(35042699022)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 10:46:33.7040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d53f4926-e57a-493a-df95-08dcd24f00cd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000042.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8483

On 9/11/24 09:45, Peter Zijlstra wrote:
> On Wed, Sep 11, 2024 at 09:35:16AM +0100, Luis Machado wrote:
>> On 9/10/24 15:05, Peter Zijlstra wrote:
>>> On Tue, Sep 10, 2024 at 12:04:11PM +0100, Luis Machado wrote:
>>>> I gave the above patch a try on our Android workload running on the Pixel 6 with a 6.8-based kernel.
>>>>
>>>> First I'd like to confirm that Dietmar's fix that was pushed to tip:sched/core (Fix util_est
>>>> accounting for DELAY_DEQUEUE) helps bring the frequencies and power use down to more sensible levels.
>>>>
>>>> As for the above changes, unfortunately I'm seeing high frequencies and high power usage again. The
>>>> pattern looks similar to what we observed with the uclamp inc/dec imbalance.
>>>
>>> :-(
>>>
>>>> I haven't investigated this in depth yet, but I'll go stare at some traces and the code, and hopefully
>>>> something will ring bells.
>>>
>>> So first thing to do is trace h_nr_delayed I suppose, in my own
>>> (limited) testing that was mostly [0,1] correctly correlating to there
>>> being a delayed task on the runqueue.
>>>
>>> I'm assuming that removing the usage sites restores function?
>>
>> It does restore function if we remove the usage.
>>
>> From an initial look:
>>
>> cat /sys/kernel/debug/sched/debug | grep -i delay                                                                                                                                                                                                                             
>>   .h_nr_delayed                  : -4
>>   .h_nr_delayed                  : -6
>>   .h_nr_delayed                  : -1
>>   .h_nr_delayed                  : -6
>>   .h_nr_delayed                  : -1
>>   .h_nr_delayed                  : -1
>>   .h_nr_delayed                  : -5
>>   .h_nr_delayed                  : -6
>>
>> So probably an unexpected decrement or lack of an increment somewhere.
> 
> Yeah, that's buggered. Ok, I'll go rebase sched/core and take this patch
> out. I'll see if I can reproduce that.

Before reverting it, let me run a few more checks first. Dietmar tells me
he sees sane values for h_nr_delayed on a juno system.

I just want to make sure I'm not hitting some oddness with the 6.8 kernel
on the pixel 6.

