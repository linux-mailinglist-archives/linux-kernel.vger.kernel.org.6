Return-Path: <linux-kernel+bounces-211761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8E0905683
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C08AC283E58
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A461181D0C;
	Wed, 12 Jun 2024 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hrUeBgJZ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hrUeBgJZ"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2041.outbound.protection.outlook.com [40.107.241.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EBF17C203
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.41
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204915; cv=fail; b=h8Be1YhHSIPflHSA8/Dt3XBuGO0B7HtjWuzFQF7Yvt0nYBox65xz3ZjZ3CViylEAUf6CuX8dWeAq/g+PGeLuknX9Kiw5JGX6FG5DTF84ebQLNjB5u4s8cHJi2JeOG+WOaNRS69gmuKj2mXwpzdwV4o4PixydZWoEcqOXD0H+RzI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204915; c=relaxed/simple;
	bh=6d6ix4yE5wXLUAcAwcFIC5yDJlMR41v5kxHQM+52f4w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q2p766Onwk+G8uoiqo9SfixOgbPEZ7EKPiRSs3aBakJXHohdP1la29qXKktvIOFQq7XWUHNoHH0b05gXzCTmSc/kT4kspvTA37lUgPaRJOdOD1nIA1s8SYCc6nV3Qv0lsWnyUOtQsUKrmFdawY04IKkqEKQ1ZIBhjcWUGj/4bbY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hrUeBgJZ; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hrUeBgJZ; arc=fail smtp.client-ip=40.107.241.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=H6SMWJZNYFiQUeeFY2sy88i5H8CacVnjXTwS44EQy4mzCd2/Ti2/5odjeBdRbg4qEt6I+IM44ohzGhpGhI/WshWTwEqAvb2IdriAyoGZw2rszT0tLyIVziALg5spN02ALKJDYsghL1yIR8/zCT8zli+P594o044uuA1NWPmHKCBXJ33udbQMXkkaXYOlUzATL6z+snrd0bZSW0zxCkCQ7ZNu4kwVEjUa/cuVH6j5NgE7q+qhaprRPURQNqSq6vdXA5BjmqG1XYqeG8jb3Cu5sFzNGsA3GJTn8M2TIEIbqRVAagTUh04FI6D7O6yReQfCGavTX3cw0WiMs9T1wsMeVA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxbDLFI4sPTQTxxfCj7ldg/Pt+V1BMGJcyPhs4f1CfY=;
 b=EsPBptDoQR1G9kqRB0mbO5s5fDVb0qKrJUnxyeJUvpFU41QZaR3CwOZgE5tdcavU0ocDKcyMDQTqbGlmNc5mTF5hy/G1ivBSfauDfY8qZcIo5Ki7xdg3f2ksJi4IKzJ/5p3H15Rn8IqxpJfJU34T+UnO++WHQ6fDnXev+sgoZFfOhTNHBtItPCggEH/bl85KAUzkg0K8PkfFeKHQEzXoETyCSBXG+9QP0hE8n0IFm0+pDQAgmc4rjNpY3e6ovI8OZ2FeRNhHADJ4V2Rxh5DLjJ9c5UMWVaBT6m153f7KtLm1KjruRcMARaTIm4gLypxXszjgdRWitlXRnFO6cmwR5w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxbDLFI4sPTQTxxfCj7ldg/Pt+V1BMGJcyPhs4f1CfY=;
 b=hrUeBgJZhTMNFRNbDWBsWPhVS19XgMu7E20/zbfxsc/3Xaoydubc8FZmjWOG5kViOGd9brV9+XMwXK1/inU0gMi/8MUqlzl5t25t2D1dSwePkYIRIek0z+xV7kjSk3h6BaXJg0MjLatmFSI3afM6MufEoPwcx0dzoZhwHd9NKpY=
Received: from DB7PR05CA0001.eurprd05.prod.outlook.com (2603:10a6:10:36::14)
 by AS8PR08MB6341.eurprd08.prod.outlook.com (2603:10a6:20b:33f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 15:08:27 +0000
Received: from DB5PEPF00014B9A.eurprd02.prod.outlook.com
 (2603:10a6:10:36:cafe::5f) by DB7PR05CA0001.outlook.office365.com
 (2603:10a6:10:36::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20 via Frontend
 Transport; Wed, 12 Jun 2024 15:08:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B9A.mail.protection.outlook.com (10.167.8.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7677.15
 via Frontend Transport; Wed, 12 Jun 2024 15:08:27 +0000
Received: ("Tessian outbound 6b7ebc67fb02:v332"); Wed, 12 Jun 2024 15:08:26 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 01f96d8ca3f419e9
X-CR-MTA-TID: 64aa7808
Received: from 927547f85fa0.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 874CB9B3-DA6E-4E5C-8C7F-CC1949045195.1;
	Wed, 12 Jun 2024 15:08:14 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 927547f85fa0.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 12 Jun 2024 15:08:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jtzn7o1VUMx+36zRbFan+xyo8MQoBJZ2vV3sSHR+2SZeqyJD+tf3B0hw0I0VJce6TZE4+HCfHhR8sTdAIEJLIhSXPRhz5zWj6gpWKvKo/6rschMvGY6wqt+Tccto4pIcknHzPzUBFE9mIn6OG7yzCN55lOPY7gijnldHAQ/oGnlKjAPGPO9FPBjMWHl8SUy60IZ18KA3fn+XeM1riqPsfhdw3VnVovKvFhbfyMHqORkH9rAQed3zz7KOiYNt7htmw1BzB9GjIm4ahRfWo1vyzWnIkalpKzW/xmiTcwZuZ9GSfQIMdyLogyBbFUJ0TVqyd7u75Pksa6Z2FaHJNtu/3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxbDLFI4sPTQTxxfCj7ldg/Pt+V1BMGJcyPhs4f1CfY=;
 b=YI4KMoUZzTNnfiBtvaoTPlYC2Id/eEKjU0HGVGmgsCyz5p/7HcaN6T9MvsHjIj6Ik6qLunEwcW/Cr5AvIc9o/4cIoIsPsObC09E8bqH9/YagLlQd1L/WzBKLtVAGxPKq8W5BXKUTY1/BLUCVOjbagiWyMg7Y5sJ0n+IyLfTJwgz5ErRdR0jJ3zfC6GRTxsBxTux6N7vCAgIXbAIIe0m/5Eqleoz9o3OQeZqhGhWFEYfKcMOOWJ89HaitXPI/2p6L0+nnsC8hAZygQLP2lGLiOd1fLF6lGeSUkXZefTmqEu85R6ZWgKFCRl1/b9OWtTGY2lBNMsJnl8YAN9tJ2PwEUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxbDLFI4sPTQTxxfCj7ldg/Pt+V1BMGJcyPhs4f1CfY=;
 b=hrUeBgJZhTMNFRNbDWBsWPhVS19XgMu7E20/zbfxsc/3Xaoydubc8FZmjWOG5kViOGd9brV9+XMwXK1/inU0gMi/8MUqlzl5t25t2D1dSwePkYIRIek0z+xV7kjSk3h6BaXJg0MjLatmFSI3afM6MufEoPwcx0dzoZhwHd9NKpY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com (2603:10a6:803:c4::31)
 by GV1PR08MB7827.eurprd08.prod.outlook.com (2603:10a6:150:5b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 15:08:12 +0000
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::14e2:874a:b20b:78e5]) by VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::14e2:874a:b20b:78e5%5]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 15:08:11 +0000
Message-ID: <9098c152-c618-4e0f-ab59-0cec5cdb3e5b@arm.com>
Date: Wed, 12 Jun 2024 16:08:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, tglx@linutronix.de, efault@gmx.de,
 John Stultz <jstultz@google.com>, Hongyan.Xia2@arm.com
References: <20240426093241.GI12673@noisy.programming.kicks-ass.net>
 <c6152855-ef92-4c24-a3f5-64d4256b6789@arm.com>
 <2fba04b0-e55e-41f4-8b7a-723734fe1ad2@arm.com>
 <20240529225036.GN40213@noisy.programming.kicks-ass.net>
 <7eac0774-0f9d-487c-97b6-ab0e85f0ae3a@arm.com>
 <20240604101107.GO26599@noisy.programming.kicks-ass.net>
 <24e09046-74ee-4ebb-ac1a-bdc84568e825@arm.com>
 <20240604191220.GP40213@noisy.programming.kicks-ass.net>
 <20240605072225.GR12673@noisy.programming.kicks-ass.net>
 <7b26df23-4977-4fad-8721-137a23932b6e@arm.com>
 <20240605094231.GR26599@noisy.programming.kicks-ass.net>
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <20240605094231.GR26599@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0341.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::17) To VI1PR08MB3919.eurprd08.prod.outlook.com
 (2603:10a6:803:c4::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3919:EE_|GV1PR08MB7827:EE_|DB5PEPF00014B9A:EE_|AS8PR08MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: 453558bd-839d-4941-951e-08dc8af18325
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230032|1800799016|366008|376006|7416006;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?VEsxb085c2xYS2lPb0IzM0w5azQ0bUNISGV5bUNOTkhxNWl5cklhZ2p1WE45?=
 =?utf-8?B?ZWhSdEk4OHcvZnR3d25zcmEwQUhTL1kxRDVZQUZsM2pSbUNtdWkzdmtIR1dt?=
 =?utf-8?B?SDFLZzRVeHhVUUpOWjhJL3R0V0FMeWZ3VytzWWhOZGR3S0FqMmVtdENhcitx?=
 =?utf-8?B?dkQwdWRJekhSUElmVGRieXQ2SmdFdkFtMFJ2REJ3WXdlM2xieGJQQzZxMnVL?=
 =?utf-8?B?a1greXVWKy9nOHdLdHBOK1BQTHB1cHk1RkVmK055bUkyZzFIaDZVNjk3cFpZ?=
 =?utf-8?B?L3hqRE9JY2hNNThKYU1UVnRQMGJQVmpLMk96aVZpREtpOU5pTCtiZ0FHSy9j?=
 =?utf-8?B?dFQxbVlHbXI2NjY5elBrQzJqUWpSSC9RSGVJVjgvYUpCcTZFMDcyUHIwWFNX?=
 =?utf-8?B?NFlvdmVNNURxeWFxaTAyY1BGaUZTc0s3dmlEYURRSTIzS3R5VG9NZWtIb3Jj?=
 =?utf-8?B?ZjRUSWMyZ3J6VmR5NkZld0hMUVBzc0ZyUnp4eXdjYUtWalptUXExQU9KT3Ix?=
 =?utf-8?B?TWVZbjhXODJPYmtRdHAxVDBqMjI4RldzYzl4M01ySysyRUJjUm80a2g3Q3pu?=
 =?utf-8?B?OUxMRUZtOGVMR0VyMS92UWlUb1didTlDZ0NYSkN6bkZadDJlOTBTTjdNbkRH?=
 =?utf-8?B?aTMzcEpNUGNFa1F2a090UFRlMWEwV0dsS1JzM2VTaWtyQThGM01xajJEd2ZG?=
 =?utf-8?B?TERGZFlFVDBpR0wzT2ZTOWdMZDhod3JwcUROYkkrNUdsK0drRmhpK0Y3UUNJ?=
 =?utf-8?B?NENsNmZvNW9IcE9zbzd0ME1aZWxjUHBDOHgyYmFLaHNhNGxPdTI1eGRBTG1k?=
 =?utf-8?B?dEFaUis5Y2N2NGJOTk1hTzZQZkY1V2d3dVYwRXgvbE9lb3RiQWlLZzZJbzB3?=
 =?utf-8?B?djNzOHpBSUhIaXlkYVdEWXQybTIyNTV2UHZuTnVDWWNTYktjM296eEIwd2R3?=
 =?utf-8?B?dERPVE5zSkltNFFQRUZRRDEwRkRjZFlyQlcxZGcvRjNwa2hoTGUxQUJQQUNV?=
 =?utf-8?B?aGpwSlJmKzFsQmJXVVlCa29DbnFHWmRxcHB6ZjdXVC94MUN3Qy9HQUlWUWVp?=
 =?utf-8?B?c2ZoVnlNbE9qQXZGelhrNndqU2t3dmRwVnVXaUtQUjE5UTVUbjVIUkNxaThN?=
 =?utf-8?B?N3RlTE4xNnMwY2ZSeUZkbXhQSHltMXBISkNtK2pidXZjYThKWHhQZHIwZDZm?=
 =?utf-8?B?ajNMNnJhMDVnZXJzOFFsUXcxM1lmdmVHbXEvQzZsNmVNVUtHSEd0Y0l5M3hK?=
 =?utf-8?B?YVNPNnlaL2pRSTFBZmQzQnNIMzBuSVdtRDgrUTdzQ2t4ZnRwVk9IelJKdlM5?=
 =?utf-8?B?MG0wMkp3b014bGN6R1NMeG9tQjU2elc1anNqVERsQXJZNVE0cW9DaHNyeFRn?=
 =?utf-8?B?Qys3bm9RWHhDeFJ1UG44YTB6WmJTaXdicU85QitYc3hZMU5YekpQdkE3SnRs?=
 =?utf-8?B?T3Q0YkFmTjdVWVpreWUzQnd3d1N2bGIyTExXb3puSjU1eEppckdXd2Fad2Zn?=
 =?utf-8?B?UktzSERWV0tPdHVLUlh3MlFzNjFWQTVjamdVYnJWRzQ2dGUwbFhYV2ZmTkNJ?=
 =?utf-8?B?OTJWZ2RrS3BhNzEreGpVVm56OUp5aTRUU1BWSGM4T1Q3cHBocFBVbXE3WGZG?=
 =?utf-8?B?ZTVBOEZzNTV6RXh2and1bVZ4bG1GYXJUMExyNklGTUpjdTBoNEdMc1VJeFNj?=
 =?utf-8?B?NWNjSVdUenVkWGhZUXpLY05KUWNkWmU0RW0zYUFrMFRMRlBBVGFmYWN4Nzd0?=
 =?utf-8?Q?ofVkhU53bjAUc5Pb2ohEhJFNC/adlzRBFQdLeQ8?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3919.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006)(7416006);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7827
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b5a3e001-0963-4a74-10d0-08dc8af179ba
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|1800799016|82310400018|36860700005|376006|35042699014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2dTRnYyV0VLRGJsVjFnbTVIUEs3SzRrTnBKN09MMGoySys0cUo5OHNOclNN?=
 =?utf-8?B?R2ZxVHlWRWdaYVQ1QXdXcWdCSTN4cmRQTktML29zMFhyK2NLanlyd2I4OEhI?=
 =?utf-8?B?bHdVeWhlYzBESGJhNWZhQUZhMU9wTzhmaUtaV3BiZ2V0bENjY0ZDdFg5alZl?=
 =?utf-8?B?am1LQjN6QlhKQXh3bEd3Znc3ZUVyd3VpcmpiMGhBdGZLQklva0lyQlIzcytw?=
 =?utf-8?B?K0VMeDNSUFVTVkhRWmp3ZUljbExKMWVFY2NuZWgzalNOK0hyRjZHTnB0Vktt?=
 =?utf-8?B?Tk5KbFRybDV1Q09Ta1UvQ0RtSUhZR3hVMjBVRzJKVlZ1T05hU3o5Q1R0VWZU?=
 =?utf-8?B?UVN2UmlZd0krcUVFSW1wcVBDRzFPZ2ZjZ0N2aVNKdS9GdGJHSjA2VldpVzdJ?=
 =?utf-8?B?SVFvbFZhL2FYVjJSVFA5a0Q0UU90MmkrczZpNEZPVlpKSm5oeVQxaDk5SzR6?=
 =?utf-8?B?YmhZcjI2TEV0Sk91TUZza2xQWkh3SUpNckg3QUVuMHVUT3BFTWtEQ2VKakRv?=
 =?utf-8?B?NlBQekdWWE11TlQ4dGkzVlExa2p3UlFIRlFPcU05VmNoemgzbjloSU5lWUdj?=
 =?utf-8?B?U0RsRmF6MHc5N0Q0WE91RFpoUDhwSHBXM3JybXJyck9nQjExMkNIWWpHcE9I?=
 =?utf-8?B?Q0hJVG9JQW50Z0JMZXpScUt1MFdmZjN3MURBOHp5SHEwNXd5QW0rcXl4K0k3?=
 =?utf-8?B?b0JyT1p5SlFaU2JONXFESDc5L1plSGFhZ2kzclBsNThxSUxleFpRZG9nRUlK?=
 =?utf-8?B?WkYxVUcySGZFMjVpNnoxWUN0ZVN0ZjhmWUR4NkFqN3RnTTZhWEU1WHB3dlBG?=
 =?utf-8?B?MjZtODhwNXlDeCtUWHVPbGIvcXhHK2NrZUdLMjIzL3QyUXBZOWpFcmJybE5N?=
 =?utf-8?B?aGpGSEVEL2ZpS3B5K0VtUkJxdGwwdGJva1hNZ0lNRk9zMkc3dUZsWm5abGdt?=
 =?utf-8?B?MzF5ZC84dTRhSlgxRXc5QU0wTkVad3huSEJWWEpEOWt1MWI2WjVUM2FqMUZB?=
 =?utf-8?B?K0pDYmxnKzhiSzhYZHVmS0Z0SktDRzVCQW5JSnYzcVRGMVl5UGJ5dTVWRXZq?=
 =?utf-8?B?UDA4OXY0dGFCcHNndjF3L1ZEbVVxSjA1eVVnLzB2YzZFMXR6OGxHb1ZaY1NE?=
 =?utf-8?B?dGFjTGFZMXZLYWs3dlRuSVBuZEVobC9KUHZxNEh1ZmozcGM2WU1YM0lNblow?=
 =?utf-8?B?R2hrUVFLVExTaVlQSlkyVWxTNkdZOTlXeTN4ZFdxKzZiVUFSc2dqRlkrV3ZY?=
 =?utf-8?B?TXA2T3JJdExUV3ZMWjE1RlJxaHNYelQxaDhlUXlqaEFtNXR5Z2tiWXA4eCtT?=
 =?utf-8?B?NGdtRW9KOFk2anpJTWl1OThrWWhBaDRmcDJ6UzNFZlRpckJ6ZnpGN1dKTGFx?=
 =?utf-8?B?TG5hVFV1Q1ZJRERXcGRFRTVWYXU4aVYrQytoWWkxNWIwYkQ4d3RqT3NWLzhs?=
 =?utf-8?B?K1R2SHR2dTFMNCtDM3JTMzVLcTN5dEFMQlBNdDNuVmNmZHlQbnp2OUc5SmZn?=
 =?utf-8?B?cW5wUG0yNzZ2aXQ0RmpjbmNyY3hnSi9TeGlNSlhEbVV4VTgrd0ZyQlpzQ2dC?=
 =?utf-8?B?dUFKQ3RpQytEd2xONzVuVHNGOFc0N0hFcnVrMFpmV0VWYkJnSnZEb3M2anNw?=
 =?utf-8?B?WmpwcVdteENZSlFpZHRnSjgraGE0aVB6VDR5eUphN25iRXVkY3hoRWNENmdk?=
 =?utf-8?B?aWFWbUZMTDgvWHFXMHM3ZmZUV0JvVEdmbFRGNkNWZytacGNoTDluem1hRHJL?=
 =?utf-8?B?TnZoY3V6dzRBSE5YeVcvOFZkdEYxUUNlWXNsVmV5STF2TEpydi96WU1yTGRy?=
 =?utf-8?B?aWQxeHkwTFdOQVpwam1IMThUcXhFcEQ0Y2U1bDd4ckVsVkZSMmJTZkdRMHhT?=
 =?utf-8?B?VjFPVUxYTktaZXpPK3huWGpuc0ZWeWhxSitZTGNqcHB1SEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230032)(1800799016)(82310400018)(36860700005)(376006)(35042699014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 15:08:27.1485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 453558bd-839d-4941-951e-08dc8af18325
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6341

On 6/5/24 10:42, Peter Zijlstra wrote:
> On Wed, Jun 05, 2024 at 10:14:47AM +0100, Luis Machado wrote:
>> ... thanks for the patch! The above seems to do it for me. I can see
>> more reasonable energy use with the eevdf-complete series. Still a
>> bit higher. Might be noise, we'll see.
> 
> W00t!!!
> 
> Let me write a decent Changelog and stuff it in the git tree along with
> all the other bits.
> 
> Thanks for all the testing.

I've been doing some more testing of the eevdf-complete series with
the Pixel6/EAS platform. Hopefully these numbers will prove useful.

The energy regression from the original delayed-dequeue patch seems to
have been mostly fixed (with your proposed patch). Energy readings for
the big and mid cores are mostly stable and comparable with stock eevdf
(without eevdf-complete).

The only difference I can spot now is in the energy use of the little
cores. Compared to stock eevdf, the delayed-dequeue code seems to make
the energy use of the little cores a bit spiky, meaning sometimes we get
the expected level of energy use, but other times we get 40%, 60% or
even 90% more.

For instance...


(1) m6.6-eevdf-stock*: stock eevdf runs
(2) m6.6-eevdf-complete-ndd-dz*: eevdf-complete + NO_DELAY_DEQUEUE + DELAY_ZERO
(3) m6.6-eevdf-complete-dd-dz*: eevdf-complete + DELAY_DEQUEUE + DELAY_ZERO

+------------+---------------------------------+-----------+
|  channel   |                      tag        | perc_diff |
+------------+---------------------------------+-----------+
| CPU-Little |  m6.6-eevdf-stock-1             |   0.0%    |
| CPU-Little |  m6.6-eevdf-stock-2             |  -4.21%   |
| CPU-Little |  m6.6-eevdf-stock-3             |  -7.86%   |
| CPU-Little |  m6.6-eevdf-stock-4             |  -5.67%   |
| CPU-Little |  m6.6-eevdf-stock-5             |  -6.61%   |
| CPU-Little |  m6.6-eevdf-complete-ndd-dz-1   |  -2.21%   |
| CPU-Little |  m6.6-eevdf-complete-ndd-dz-2   |  -9.99%   |
| CPU-Little |  m6.6-eevdf-complete-ndd-dz-3   |   -6.1%   |
| CPU-Little |  m6.6-eevdf-complete-ndd-dz-4   |  -5.66%   |
| CPU-Little |  m6.6-eevdf-complete-ndd-dz-5   |  -7.12%   |
| CPU-Little |  m6.6-eevdf-complete-dd-dz-1    |  96.69%   |
| CPU-Little |  m6.6-eevdf-complete-dd-dz-2    |   22.1%   |
| CPU-Little |  m6.6-eevdf-complete-dd-dz-3    |  44.82%   |
| CPU-Little |  m6.6-eevdf-complete-dd-dz-4    |  -0.23%   |
| CPU-Little |  m6.6-eevdf-complete-dd-dz-5    |   8.28%   |
+------------+---------------------------------+-----------+

Looking at what might explain the spiky behavior with DELAY_DEQUEUE, I
noticed the idle residency data (we have 2 idle states) also shows some
spikyness and potential clues.

Looks like (1) and (2) manage to switch to idle states in a consistent
manner, whereas (3) seems a bit erratic and more prone to take a
shallower idle state (idle 0) as opposed to a deeper idle state (idle 1).

(1) and (2) seem to make better use of the deeper idle state.

+-------------------------------+---------+------------+-------+
|            tag                | cluster | idle_state | time  |
+-------------------------------+---------+------------+-------+
| m6.6-eevdf-stock-1            | little  |  not idle  | 63.49 |
| m6.6-eevdf-stock-1            | little  |   idle 0   | 30.66 |
| m6.6-eevdf-stock-1            | little  |   idle 1   | 12.15 |
| m6.6-eevdf-stock-2            | little  |  not idle  | 62.6  |
| m6.6-eevdf-stock-2            | little  |   idle 0   | 31.13 |
| m6.6-eevdf-stock-2            | little  |   idle 1   | 14.56 |
| m6.6-eevdf-stock-3            | little  |  not idle  | 63.98 |
| m6.6-eevdf-stock-3            | little  |   idle 0   | 31.54 |
| m6.6-eevdf-stock-3            | little  |   idle 1   | 15.91 |
| m6.6-eevdf-stock-4            | little  |  not idle  | 64.18 |
| m6.6-eevdf-stock-4            | little  |   idle 0   | 31.32 |
| m6.6-eevdf-stock-4            | little  |   idle 1   | 15.83 |
| m6.6-eevdf-stock-5            | little  |  not idle  | 63.32 |
| m6.6-eevdf-stock-5            | little  |   idle 0   | 30.4  |
| m6.6-eevdf-stock-5            | little  |   idle 1   | 14.33 |
| m6.6-eevdf-complete-ndd-dz-1  | little  |  not idle  | 62.62 |
| m6.6-eevdf-complete-ndd-dz-1  | little  |   idle 0   | 29.48 |
| m6.6-eevdf-complete-ndd-dz-1  | little  |   idle 1   | 13.19 |
| m6.6-eevdf-complete-ndd-dz-2  | little  |  not idle  | 64.12 |
| m6.6-eevdf-complete-ndd-dz-2  | little  |   idle 0   | 27.62 |
| m6.6-eevdf-complete-ndd-dz-2  | little  |   idle 1   | 14.73 |
| m6.6-eevdf-complete-ndd-dz-3  | little  |  not idle  | 62.86 |
| m6.6-eevdf-complete-ndd-dz-3  | little  |   idle 0   | 27.87 |
| m6.6-eevdf-complete-ndd-dz-3  | little  |   idle 1   | 14.97 |
| m6.6-eevdf-complete-ndd-dz-4  | little  |  not idle  | 63.01 |
| m6.6-eevdf-complete-ndd-dz-4  | little  |   idle 0   | 28.2  |
| m6.6-eevdf-complete-ndd-dz-4  | little  |   idle 1   | 14.11 |
| m6.6-eevdf-complete-ndd-dz-5  | little  |  not idle  | 62.1  |
| m6.6-eevdf-complete-ndd-dz-5  | little  |   idle 0   | 29.06 |
| m6.6-eevdf-complete-ndd-dz-5  | little  |   idle 1   | 14.73 |
| m6.6-eevdf-complete-dd-dz-1   | little  |  not idle  | 46.18 |
| m6.6-eevdf-complete-dd-dz-1   | little  |   idle 0   | 53.78 |
| m6.6-eevdf-complete-dd-dz-1   | little  |   idle 1   | 3.75  |
| m6.6-eevdf-complete-dd-dz-2   | little  |  not idle  | 57.64 |
| m6.6-eevdf-complete-dd-dz-2   | little  |   idle 0   | 40.47 |
| m6.6-eevdf-complete-dd-dz-2   | little  |   idle 1   | 7.39  |
| m6.6-eevdf-complete-dd-dz-3   | little  |  not idle  | 43.14 |
| m6.6-eevdf-complete-dd-dz-3   | little  |   idle 0   | 57.73 |
| m6.6-eevdf-complete-dd-dz-3   | little  |   idle 1   | 3.65  |
| m6.6-eevdf-complete-dd-dz-4   | little  |  not idle  | 58.97 |
| m6.6-eevdf-complete-dd-dz-4   | little  |   idle 0   | 36.4  |
| m6.6-eevdf-complete-dd-dz-4   | little  |   idle 1   | 9.42  |
| m6.6-eevdf-complete-dd-dz-5   | little  |  not idle  | 55.85 |
| m6.6-eevdf-complete-dd-dz-5   | little  |   idle 0   | 36.75 |
| m6.6-eevdf-complete-dd-dz-5   | little  |   idle 1   | 13.14 |
+-------------------------------+---------+------------+-------+

I can't draw a precise conclusion, but it might be down to delayed util_est
updates or even the additional time the delayed-dequeue tasks spend on the
runqueue. But delayed-dequeue does change the overall behavior a bit on
these heterogeneous platforms, energy-wise.



