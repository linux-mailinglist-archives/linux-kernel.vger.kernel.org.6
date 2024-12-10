Return-Path: <linux-kernel+bounces-439113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFE49EAAF0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BDB61882DF3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2196A22E3F8;
	Tue, 10 Dec 2024 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PM+G8oBX";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PM+G8oBX"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141972AEE7
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.66
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733820382; cv=fail; b=jT+di6zjM4es04DNmLIPvlK87VlFWW/E9sAHCdkpN1nzeVt5PF+G36ZFwraaXos/h1DHISKMIaURj6H3JfYhEMOecYiZTTBVYSK/Cz7KKR+msY45upIck1ClWVHcZF39jZtmj3dnIQq6bRm/IJKIFq6LR6ORAQ+WfzVe1n1zjHk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733820382; c=relaxed/simple;
	bh=JfAl8HsHXu0Cti02MhkF2KGrFdju4+ikLyOhELsOJoA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UpB0VLOJYZwGyksWwvaKLlrUfJpUhnvou2TL0J3W0L4+M6lDQ4PHcg1tlkXQVsqmTtkrsNL7ji67s37/ObqjqwwtUR6z62tBlAhB2FTIxFD2qdHAHznNa3GX6vj247/G4JF1JUaBqoRQTgYF5ofINRgr/c8lEKcjOsYNtfN6mqc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PM+G8oBX; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PM+G8oBX; arc=fail smtp.client-ip=40.107.22.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=VzwnKl7+c16wh+vPRPzTLF8GFGBvy1cWU98TwwLsY0mng2nhiHIoygIMQzd6aKrMFqsDTVNhEPrPkb9pQnqgUVQHPsDYt4rtaciFOMtNIjwb6oSTyKX2f3k6LV8jQu6P4bKh0VX6FX6cgtgLxmPPAMbKS0JrxM20RNw5sR0aVC65++9AioxlmKb8bwDw9emmOD5f73MykU1YcSUyKlHXgf73fSRNWUbKwnAPf85fwNpfDLokQwPQhwPaXcvwJul/ZdPIivZi2gzibWVYtdjJDBtr7wDqM80+DYQpy3ssbVUfVuRpTKIfoRROOL9g+k3oGX1t7JBhbzbfUCP9ng8Cuw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wY9WEV29u+KSnvgdPaESYgFisSFOu8KxeA2A2jHBItY=;
 b=eLDCMRLHX2cGDYbPQ/Ht1Gi/qGdQxVgedEb5Pl0VUjxzCfTdSbAq/sk+8VZRplKExMcwUNza1DjZUIzC4E5a8whbT/eRuo5J+gai9mTQ6I0gro2cugHqsc2YQIAYyoJCsULAVjKQxUNp+YCBz8uAgxO6NkKR1hhf83TciMk5jdIjWx2oXn/7Q436aWel53xIWf3Rz/7GjZTymIQj0y3cUWtpxZ7BRbjdN+ewrUoLDKtnv97IQIqBX5NyOSQpUNLn0mqJTCguQWertgwaiJM2s6PtG679TB6PT5YMPH512LtC1Bs2JZX4TeCgB1JOWmXk2TBppZqE43BiN34xHZeV3Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wY9WEV29u+KSnvgdPaESYgFisSFOu8KxeA2A2jHBItY=;
 b=PM+G8oBXE+nzpy0EPRVJq3u7ljCbpEgHxfzQkH0i9DCaaGdsQvaRHYpXvC8hatyuoHfwcSleQpimeFkYQudtknfxMsaq8aJVaNtmvrn5qpwXiZWXblSEWzhOEFI0nlWyfSTJ+1DIkJenT8Ih7mWrrcLWWQoKgNxx0ODr6go0sj8=
Received: from DB8PR09CA0026.eurprd09.prod.outlook.com (2603:10a6:10:a0::39)
 by GVXPR08MB7752.eurprd08.prod.outlook.com (2603:10a6:150:6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 08:46:08 +0000
Received: from DB1PEPF000509EB.eurprd03.prod.outlook.com
 (2603:10a6:10:a0:cafe::36) by DB8PR09CA0026.outlook.office365.com
 (2603:10a6:10:a0::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Tue,
 10 Dec 2024 08:46:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF000509EB.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7
 via Frontend Transport; Tue, 10 Dec 2024 08:46:08 +0000
Received: ("Tessian outbound 3df7a8fbf509:v524"); Tue, 10 Dec 2024 08:46:08 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3fe22b1f6d37ce05
X-TessianGatewayMetadata: S8hOPy4n40DKcfJBofC8JenSbwyqwWApNzEOCaVawWpWxAYdGfq7IPK+xs2EAyow9GLqdWla3yZebIMj/GjYvepDVNJ1lYG0P1AR0sJ+HosVz1O/9E5PO2gnUk6WQCcw/a6rLmmuiDALuTfPfMlD1T60Edpwd5RrIJiF0+auUAw=
X-CR-MTA-TID: 64aa7808
Received: from L5adfb16849b5.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 321C4449-1D18-4730-9458-58EFAAB38ABD.1;
	Tue, 10 Dec 2024 08:46:01 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L5adfb16849b5.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Tue, 10 Dec 2024 08:46:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpK+sYsx2c0pzF6ji2Lj10TGB50/OhP2yGiGzT9aStGnhw66SLgGGu/eJEzogldtdBlU4m3qsk6Y6G7PR2L1JYZ+ude/TAPrMdJXN708z0gVeISEu82sLyF4q8ChFChBMgAHwN41+a19lxSIB3ot0uXhdHyXqacrBdwYokdstz8Zww1P7T58wHrZYcw5zBoeKs/8+pQU24Dx5t5MeWC3A+TyoIpEPYem3TJ1Z02pH4P5Qzt065EYZ1zUM97AECvwhvjoV1nWC+E0ijGORikyxePpn64I4Bvs6FHutwwqmGKc7bFv4DNZbwuKFz/OytyAJ7MBX4CDSq5rFnmB72TfDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wY9WEV29u+KSnvgdPaESYgFisSFOu8KxeA2A2jHBItY=;
 b=QqpqMYCL7lhRVyNEYFvxE/rYUOt6bLjdGYlMwKCWcmMc1hP0hPSBwtZQDhqLtTlVZl296sD22lZxS1UPjxCFB+uzm2j0P8nlnNU9JM/Tqrp4PxnTIItN4UFPvloR4ck9CKHaLFV2shy0137kbBR8jI2bwnByihJFCKNA4yG8/e3hcvW9ZX5Jr9zuSFzGKOnEZgUtN/wxj4IXgdnXrBA6h0HkU0Xv9w1BLfsCbgnPsKewhQGXugnNvIfo48vMXY66XL+/8rhIV2TmJFV9FiJJT8vf2SwWD56lhZNby4siCnKfrG5FoLuUxCy9R+lNhDIWbNNnQchQIlP3xWsK9VwQBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wY9WEV29u+KSnvgdPaESYgFisSFOu8KxeA2A2jHBItY=;
 b=PM+G8oBXE+nzpy0EPRVJq3u7ljCbpEgHxfzQkH0i9DCaaGdsQvaRHYpXvC8hatyuoHfwcSleQpimeFkYQudtknfxMsaq8aJVaNtmvrn5qpwXiZWXblSEWzhOEFI0nlWyfSTJ+1DIkJenT8Ih7mWrrcLWWQoKgNxx0ODr6go0sj8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com (2603:10a6:102:8e::21)
 by PA4PR08MB6127.eurprd08.prod.outlook.com (2603:10a6:102:f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 08:45:59 +0000
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d]) by PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d%3]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 08:45:59 +0000
Message-ID: <0b386131-1511-4764-8ebf-1a38fce791a0@arm.com>
Date: Tue, 10 Dec 2024 08:45:56 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: [PATCH 00/24] Complete EEVDF
To: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>,
 Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
 youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
References: <20240727102732.960974693@infradead.org>
 <16f96a109bec0b5849793c8fb90bd6b63a2eb62f.camel@codethink.co.uk>
Content-Language: en-US
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <16f96a109bec0b5849793c8fb90bd6b63a2eb62f.camel@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::9) To PR3PR08MB5852.eurprd08.prod.outlook.com
 (2603:10a6:102:8e::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PR3PR08MB5852:EE_|PA4PR08MB6127:EE_|DB1PEPF000509EB:EE_|GVXPR08MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: 48687ef9-69bf-4b01-4a59-08dd18f71766
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?djBaZCtxelJDU2hTYzRMdXBiSHczaHJhVDZ2NVY5M1lIUk5UU3RwdzdvNWs4?=
 =?utf-8?B?NjNCLytuSGU2WDZTUFZIdnlrRHdNcExLdEVyUGlqeTVKWEIyenFOT3hYdXNq?=
 =?utf-8?B?NHZXM0JZbFhkT3hhU0FXNXdlWnBEYkFkVjN3R3VPdFNob2NZdWhPdzh0MW1L?=
 =?utf-8?B?RXB6eXh4d1dTcXMrWmdJRWloeWJsQzZ0S1pEQlRVUlNIRTNqV1JMMm9DazBP?=
 =?utf-8?B?THlCWGpmMkhoWnp4anQ4bk05OXJCaldtbTQwWTFHRi9Ra241MGowcFFvQmFs?=
 =?utf-8?B?VmVIVGtLVEJlbWw0QnJFdE94aGtBbW5jbEdMQmFCWnFtbGI5cy9BcVEvU3Ar?=
 =?utf-8?B?TWdnWGE0cE1lK1VOVDZIZVNaMTRWMldHMjJrekZPdGZzemg0Z212MEZKS2dR?=
 =?utf-8?B?enRIRTRsNUF0RjZPQktDSWVxZFJ4ZGRNb0ZvZVZ3UFdMYU1UaXgwYlViZndu?=
 =?utf-8?B?d1Q2dzBUNmJwemJhUjNvRmNiV1lGdnZVRitiRHJaMEdZalRGTnBscGxyV0FD?=
 =?utf-8?B?NE5tMGMvM0dGSENxVWFObEI4TjVwMzZrdm9PaVFjSWpQV1hkYXhLNFRmQUZ5?=
 =?utf-8?B?bjJRZjVSV1Z5Y242VlB2Y2RDT05wUXdweUhBODFqc2tzeUErRFlCR2l2N1l2?=
 =?utf-8?B?c1FhcXZtODBIWjFHMVFNM3BmaGNZcnc3eGdFZUZ2dGp2NC9iam53eVFXS0dT?=
 =?utf-8?B?TjlScVRUV2xoblMyT2RTYXBvcjlmVi9HdXY3cW5wblY2UCtMd3M3eHB3VHpj?=
 =?utf-8?B?TFdoZ0diVlBtVVE2ZXdaMy9UVHE3S3laakpsa2ViWlBwTkt1dm8zY0MvM2Vj?=
 =?utf-8?B?NlgxQnkyOC9wdUIxdzRnQkl2cTV0RlJOY0JoYWxlYU1HRCtqZU5lWkllUmFL?=
 =?utf-8?B?Y3dWTGdWVUI2cm5oZjBkdmNQVitxQnRZeTBBeWF2SVNLbDEzSUIvN2RpL0FW?=
 =?utf-8?B?OGVTaERaQzZvcnJLQm5FY2E3UnNSbEFkVnlKWVVoRjN2dU1aS2M1cUtQaGhs?=
 =?utf-8?B?U0hOMENWN1I4U2x2UFZRd1VKbjI1NEMwV1IrcjQyMWhXclhCTlpOOVZVSkp4?=
 =?utf-8?B?WVFjNWRTcnJ3bVZDeHhoQlRyYmQwK05hUWNBY3crVTZ1QVJOVi9meUQzNkxy?=
 =?utf-8?B?bDREeUtxc2cwMnZvanVlWDVkREpFSEhXaFdzTys2OWM0VFI5RkJaWXQvOFVj?=
 =?utf-8?B?Q010Nm1JVFQxQ0ZPVVZkcDB5YnBCSHJCejV0eGp3NTk2Y2xHMkI2bTA4Z2J2?=
 =?utf-8?B?enlwS213ZmpyOUJPWGNzUTNQMTRmNU9vSzhUamhibUJ1SXdQOVRiQkphODh1?=
 =?utf-8?B?NTBteVFDS1JUOWhFZ0YxN3pvRklWN3N0RHU4cmlxU3lOaVA4YUxtY0NWZkFt?=
 =?utf-8?B?MGFUYnc4NTVtTFN0azBqaDJsNGhXVkpyeTEzY0FkNmk0NkdQd2NqWFVEVmJy?=
 =?utf-8?B?RW5LMEl6UktCQ1RHQlRlOTR3ZzYvTnNwQjlLak9JV2xYUHc5OWx0bkdsRCtR?=
 =?utf-8?B?VU5rMVpWYWNNd2RsSkE2emhmeFowN0RzRHM1Z3RlZlYzWTRzT0Q2cG5jdnk4?=
 =?utf-8?B?SXlCVnJCNWRuRUlvUXJsWnMwNXNLaWEzZWN3aEV6K1o3Z2ZhY2lKYThSRXNq?=
 =?utf-8?B?NlpFd1BURjBuQTFqRFlWV29mZHpVdDJaRXNYMm40V3IwRE8yOCtMSE1XL1hh?=
 =?utf-8?B?RmJJRFp4SWp0OHF2emlqaUZxOGt3QXUyREdFNTgvVExQT3grK3NrZEh2cVRP?=
 =?utf-8?B?Y2xJSGZDQytjdFNIc3RYbzVmUVhRZFpacmgweWRubFV6YjR1dHB1ZHhTTGdZ?=
 =?utf-8?B?eUxSWWxrVkoyeDBibmY2dz09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5852.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6127
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:102:8e::21];domain=PR3PR08MB5852.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509EB.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4f8d3aec-55d8-440a-2012-08dd18f711d5
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|35042699022|14060799003|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amFJcjlsdGkyTG1ReHdWN2pobmNaRjJTcHo2K3Z3NExvZ3NpUFlTb2FjTVk4?=
 =?utf-8?B?Yk9oSldEWm5lYUh6RHo1ZnUzUVdMZDBXazg3L0t5M0VVRlBKQWgwTzgza2VM?=
 =?utf-8?B?VDlWYjRJUnpRSGFHaFptOS9SVUhNOUlxZ084Y1RQV0l2ajRnY2hTWmEyQXFL?=
 =?utf-8?B?NFF4R1dERUJGOFhCUENEVkNONG5ZczNxTUYwNmh6ZGlzSlFFdkFxeE45MUV0?=
 =?utf-8?B?OFh6WjdlNlFEUkhQRXVhclQ5VWtPRzE4aVY2UjBKckxibWJmdFZyVnhidzFa?=
 =?utf-8?B?LzFNTFM2ZXlQUnBkdnlnZzhVaUhvM1VDUEY1aitRbHd1c2NVa1NWM2NXeks2?=
 =?utf-8?B?dkExTG9iVG1Jc1VhOHBJUVBpRG5BY041UzFzeG1aYTZZSjh2OUFFQzZJMndG?=
 =?utf-8?B?M3VRc2VUVzQxYlhWTlJWdGNSZngyWWdDb0hySjJNVWFBQVkxM29rRFdOcXQ4?=
 =?utf-8?B?SHNxVEhvWGtBNlBTRWRJcnJVb2QwanFwYWxrRlpFWjh2QVM3MEIxdXZ6WHdR?=
 =?utf-8?B?VlJDZ0x6S3NibkZvcHIxeUtwcGlPT2c1cXJsZ2dxWkwrbVZKcForOTJSN0py?=
 =?utf-8?B?Um9ueDViRVpDSDhxSnpRZmxGQngvS0lqcHpjOEc0U2lvaU1VMVJYL1NweHVP?=
 =?utf-8?B?TjBMRkFsQmRlOG5RMDRaN0JIcWQrc1dCNDExUVNvRjVwS1hwQ0VzZFh2cXJB?=
 =?utf-8?B?d1dGeWRTR3R2THpXaGNHQi9Ba3JPZnZjamZST09NUm96Vko0cjAvU09vZ1Uy?=
 =?utf-8?B?c2Q0Mk5CczZWR1Z5VkVjVG5LSm9NTFhBSGlmV2xxWmloa1JLejg2RGdrUDg1?=
 =?utf-8?B?UlU4SnRhUGpnOThOSTlJSlZVTkZuc3FKWlhiYUhUYzNYeHpJZXp4VnYzejRJ?=
 =?utf-8?B?b0hOY2FvS00ra3d2Zi9NV2NVVXB3QlYwaElOUm1qSVNyTUZwMmtiUVd0bUQr?=
 =?utf-8?B?WXFSa0JzY3U5WERaZE9nYzE2bmpjY3ppNVAwTk1xaGQzeGlyNGxPQlpTcERp?=
 =?utf-8?B?MjQrR0FINUlOSzVIbzlIT0VCeDBRUGY5VDRGcUpGa0krU0tNN1NrVGN5cnQy?=
 =?utf-8?B?SWkxVDgydlZSdFJZU3JKUjdwMVpFWGNhQ0dPWlF2Q093WHVhRG1ROUhpQWxs?=
 =?utf-8?B?c0JTeThNVUIxS0htNlovSE4yUFpoYWdIZEZOQW1lSjlvK0FWL3lja1JEY3I2?=
 =?utf-8?B?dVpOeGhWdUp4OU53VG9KRDJLd09QaDlCUEdLZHNVazkyeElGYmJkb2cvMitF?=
 =?utf-8?B?UnJ6MFFoelU1REtoZUxkLzlYSDI4WUdHSDFhQ2srdzh6YTI5b1JhT2d3WVAy?=
 =?utf-8?B?VVBaMVNaK1FuczJrZG5qWFhWSXVNME5ydlN4dVpsUDFJQ1hCMGg3S1VyUGM4?=
 =?utf-8?B?VVB4YVBhUUtRN3RBQTdLMlB6azdDbStSRkxwZVRaY2JBeGplQ2FrR0dBNkJl?=
 =?utf-8?B?QW43Y0t5dFFxWks2N0hWWU92a21STnBKUWU2Sk9vaDNUcG1XSGR6cTN3V2pB?=
 =?utf-8?B?OGhWMlNIYmVmYyt4RFJRdWdHc0I4N0preTE4UERXUWxXZWgvaEpwSEJBYlp5?=
 =?utf-8?B?MXdOZ2ptY0h1eTdJT3cwUEpoWFFVbExyUlBTTzA3Y00yZWd0c09iS2tIc1Ri?=
 =?utf-8?B?VFAwSytKRVFoTnBaaXVIeUlyZjlzRTVGNmZuU1hRdkNFSUtQNXhKYklCTU11?=
 =?utf-8?B?Vk5WY2RjQm9hWEQ0YUdsU3hDQzAyUnIwMlJ3QTdBNVhjUWdlY05waEhnd0c1?=
 =?utf-8?B?MHROM3pvaExZUStjTnVXWlFYUFlJYmVYWDN1R2h2N3k1aU1Nd3IyM2ZhSG90?=
 =?utf-8?B?dVRLK2pseVhaenZwTlNVQ0dsYlZuWmN0bEZQODU0Z2l2THk1dTZYWTVIZ1RX?=
 =?utf-8?B?aFk0ak5CdlhMdHNWUDJtRWpOS1lQYms3d2loNDJVMDFxblJwa21rVzJRRjN1?=
 =?utf-8?Q?CIg+md2KYwQ=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(35042699022)(14060799003)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 08:46:08.4422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48687ef9-69bf-4b01-4a59-08dd18f71766
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7752

On 11/28/24 10:32, Marcel Ziswiler wrote:
> Hi all,
> 
> On Sat, 2024-07-27 at 12:27 +0200, Peter Zijlstra wrote:
>> Hi all,
>>
>> So after much delay this is hopefully the final version of the EEVDF patches.
>> They've been sitting in my git tree for ever it seems, and people have been
>> testing it and sending fixes.
>>
>> I've spend the last two days testing and fixing cfs-bandwidth, and as far
>> as I know that was the very last issue holding it back.
>>
>> These patches apply on top of queue.git sched/dl-server, which I plan on merging
>> in tip/sched/core once -rc1 drops.
>>
>> I'm hoping to then merge all this (+- the DVFS clock patch) right before -rc2.
>>
>>
>> Aside from a ton of bug fixes -- thanks all! -- new in this version is:
>>
>>  - split up the huge delay-dequeue patch
>>  - tested/fixed cfs-bandwidth
>>  - PLACE_REL_DEADLINE -- preserve the relative deadline when migrating
>>  - SCHED_BATCH is equivalent to RESPECT_SLICE
>>  - propagate min_slice up cgroups
>>  - CLOCK_THREAD_DVFS_ID
> 
> We found the following 7 commits from this patch set to crash in enqueue_dl_entity():
> 
> 54a58a787791 sched/fair: Implement DELAY_ZERO
> 152e11f6df29 sched/fair: Implement delayed dequeue
> e1459a50ba31 sched: Teach dequeue_task() about special task states
> a1c446611e31 sched,freezer: Mark TASK_FROZEN special
> 781773e3b680 sched/fair: Implement ENQUEUE_DELAYED
> f12e148892ed sched/fair: Prepare pick_next_task() for delayed dequeue
> 2e0199df252a sched/fair: Prepare exit/cleanup paths for delayed_dequeue
> 
> Resulting in the following crash dump (this is running v6.12.1):
> 
> [   14.652856] sched: DL replenish lagged too much
> [   16.572706] ------------[ cut here ]------------
> [   16.573115] WARNING: CPU: 5 PID: 912 at kernel/sched/deadline.c:1995 enqueue_dl_entity+0x46c/0x55c
> [   16.573900] Modules linked in: overlay crct10dif_ce rk805_pwrkey snd_soc_es8316 pwm_fan
> phy_rockchip_naneng_combphy rockchip_saradc rtc_hym8563 industrialio_trigg
> ered_buffer kfifo_buf rockchip_thermal phy_rockchip_usbdp typec spi_rockchip_sfc snd_soc_rockchip_i2s_tdm
> hantro_vpu v4l2_vp9 v4l2_h264 v4l2_jpeg panthor v4l2_mem2me
> m rockchipdrm drm_gpuvm drm_exec drm_shmem_helper analogix_dp gpu_sched dw_mipi_dsi dw_hdmi cec
> drm_display_helper snd_soc_audio_graph_card snd_soc_simple_card_utils
>  drm_dma_helper drm_kms_helper cfg80211 rfkill pci_endpoint_test drm backlight dm_mod dax
> [   16.578350] CPU: 5 UID: 0 PID: 912 Comm: job10 Not tainted 6.12.1-dirty #15
> [   16.578956] Hardware name: radxa Radxa ROCK 5B/Radxa ROCK 5B, BIOS 2024.10-rc3 10/01/2024
> [   16.579667] pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   16.580273] pc : enqueue_dl_entity+0x46c/0x55c
> [   16.580661] lr : dl_server_start+0x44/0x12c
> [   16.581028] sp : ffff80008002bc00
> [   16.581318] x29: ffff80008002bc00 x28: dead000000000122 x27: 0000000000000000
> [   16.581941] x26: 0000000000000001 x25: 0000000000000000 x24: 0000000000000009
> [   16.582563] x23: ffff33c976db0e40 x22: 0000000000000001 x21: 00000000002dc6c0
> [   16.583186] x20: 0000000000000001 x19: ffff33c976db17a8 x18: 0000000000000000
> [   16.583808] x17: ffff5dd9779ac000 x16: ffff800080028000 x15: 11c3485b851e0698
> [   16.584430] x14: 11b4b257e4156000 x13: 0000000000000255 x12: 0000000000000000
> [   16.585053] x11: ffff33c976db0ec0 x10: 0000000000000000 x9 : 0000000000000009
> [   16.585674] x8 : 0000000000000005 x7 : ffff33c976db19a0 x6 : ffff33c78258b440
> [   16.586296] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> [   16.586918] x2 : 0000000000000001 x1 : 0000000000000001 x0 : ffff33c798e112f0
> [   16.587540] Call trace:
> [   16.587754]  enqueue_dl_entity+0x46c/0x55c
> [   16.588113]  dl_server_start+0x44/0x12c
> [   16.588449]  enqueue_task_fair+0x124/0x49c
> [   16.588807]  enqueue_task+0x3c/0xe0
> [   16.589113]  ttwu_do_activate.isra.0+0x6c/0x208
> [   16.589511]  try_to_wake_up+0x1d0/0x61c
> [   16.589847]  wake_up_process+0x18/0x24
> [   16.590175]  kick_pool+0x84/0x150
> [   16.590467]  __queue_work+0x2f4/0x544
> [   16.590788]  delayed_work_timer_fn+0x1c/0x28
> [   16.591161]  call_timer_fn+0x34/0x1ac
> [   16.591481]  __run_timer_base+0x20c/0x314
> [   16.591832]  run_timer_softirq+0x3c/0x78
> [   16.592176]  handle_softirqs+0x124/0x35c
> [   16.592520]  __do_softirq+0x14/0x20
> [   16.592827]  ____do_softirq+0x10/0x1c
> [   16.593148]  call_on_irq_stack+0x24/0x4c
> [   16.593490]  do_softirq_own_stack+0x1c/0x2c
> [   16.593857]  irq_exit_rcu+0x8c/0xc0
> [   16.594163]  el0_interrupt+0x48/0xbc
> [   16.594477]  __el0_irq_handler_common+0x18/0x24
> [   16.594874]  el0t_64_irq_handler+0x10/0x1c
> [   16.595232]  el0t_64_irq+0x190/0x194
> [   16.595545] ---[ end trace 0000000000000000 ]---
> [   16.595950] ------------[ cut here ]------------


Random piece of data, but I also had some difficulty making things boot on Android when trying
Vincent's nr_running accounting series due to a very similar crash/stack trace. Though what I
saw went a bit further and actually crashed within task_contending, called from
enqueue_dl_entity. Possibly crashed in one of the inlined functions.

Even though the kernel was 6.8 and it was backports, it seems awfully similar to the above.

> 
> It looks like it is trying to enqueue an already queued deadline task. Full serial console log available [1].
> 
> We are running the exact same scheduler stress test both on Intel NUCs as well as RADXA ROCK 5B board farms.
> While so far we have not seen this on amd64 it crashes consistently/reproducible on aarch64.
> 
> We haven't had time to do a non-proprietary reproduction case as of yet but I wanted to report our current
> findings asking for any feedback/suggestions from the community.
> 
> Thanks!
> 
> Cheers
> 
> Marcel
> 
> [1] https://hastebin.skyra.pw/hoqesigaye.yaml
> 


