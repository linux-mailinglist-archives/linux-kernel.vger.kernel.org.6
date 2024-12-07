Return-Path: <linux-kernel+bounces-436088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE759E810A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 17:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50777165BBB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 16:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44681494B2;
	Sat,  7 Dec 2024 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="SzQS8Qft"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021132.outbound.protection.outlook.com [40.107.192.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FCA28F5
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733589669; cv=fail; b=YvxEl0K5dLRNUQRMWEFWkJbGzJ/knvH+4z7J9X9kpKHNLmoQxRBpnij2nxmseOQfIegY/p6rw2xpjyZCHMz3Czbv4hszdPNKmAE2672XAmX9vuLU71SzN2hNcd1ZuVPq0HmCRqZPK5YV8BCKoOEL8dCcielm6URYd5C9WQHbmwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733589669; c=relaxed/simple;
	bh=9oSKFcdjzjFegYNtzblGEfbLJbqQsgigt+iVszP3jik=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NKQf07b3peb10nv/dWpkafrxiBZXe8tjbw5OWoDi0issvPv8EjC6Qtxpm9i2cL0V/wzCx7KB7ge/ME/Xj0iGjUTfD/Q5KrDUzRz9mSOTbYbcW1lFKZySaRO+7BI4guDi0Ef1WpWED0RP4Q07A2n6gOCKIhE8dLvzfIeBRHnkAiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=SzQS8Qft; arc=fail smtp.client-ip=40.107.192.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PH+x7Zt+ctqvy+Od0Wv577TFFNh3/lZcNNhO5LEf9SCSpiigcsuwU5ldrdzwX6Zg/mjE+u+AWlHa74JL9maDo3uX3jTH3tkB+5oWtVozNA+8trYGadfFxYrhEi7MKzpOhzfIgE7qCtxw59tebQF7YaT1xAjefJ5pZUxP9WSq8JpLfRjMnM616op3ovZEGEarVbzkXvzJjBuJbsLRErrc/52uAzGiSj/N8A0xxjqB/Xt/3ptu4uC0cME+aVsPymEk6CdFl0v2O4fUgDVGtkHL+H8RKw4ahWlg70V8aMOfOihD8JbhoK19rs584jrajKxlIfHsdG3nrlhKup5ivNjDOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D44IBca+5XXmMaoNHEtUa2QmT7DGLPOUbjI+8nnvnTw=;
 b=m1tOZ63xQzk9Xse9NZDAPZTpr7GOdLU9QvFR38X4J4M7MEFE0Fj32bMDuaV1Y/feMKuU+JjmPSpwgJVnQ7Aoc9mGwKA9bWAevBouaBIyQ29cV68po4Z1SBaHrc7ordvxy/3cEaN4Aryvi/BVplhevmd1kLG0eCYgPbZCjoDrY9k7TIAvgZreMG47qINeyMLmH16WoGZWF5lhBSbJCkMVBPadxsIllTgucnYVPvjLcPfA7pag9MwKyN5URixdqSchOg9PSPvlc6Q9s5daqWGwOAnU5VpSCu14iT7Ej+plTwcIri2w2PVBuTDebqI0yPkBbbd6TKRx1KMJJwNvx4t+gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D44IBca+5XXmMaoNHEtUa2QmT7DGLPOUbjI+8nnvnTw=;
 b=SzQS8QftRq88dq/HpuKt6eA5EejnXOTHOsx4TLaGYMmf8g0J/1TTpwMAA9xhTKpJG5N8btH/iDfCPmGEaCrO33eX/a/w+myT30GM7YqPLkdm6yvw8FXYZ/xOKQOnZeL6yJ01WNmiKrwD+ASXldlMpLVObdt1EEyLKzEk4HjosjWQhBFo2YHUPiLrCxLXLx/u26/menzptD6sE9oeHq91tHYW/o9pr8pXLsaC5evQFkz8Vay77xh341pJnJPxPME6lt1qKbMFf3OqBURLNa6w/Bq1QLBk3OVDYMxUIoTvao2IA1znkUvoHDoGkX04frVotv9RP4UhPXS3win4VT2UlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB9562.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:92::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Sat, 7 Dec
 2024 16:41:05 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%5]) with mapi id 15.20.8230.010; Sat, 7 Dec 2024
 16:41:05 +0000
Message-ID: <24442d9b-cadb-4f76-bec0-6311b1332ec1@efficios.com>
Date: Sat, 7 Dec 2024 11:41:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: use clear_user_(high)page() for arch with special
 user folio handling
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Vlastimil Babka <vbabka@suse.cz>,
 David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 John Hubbard <jhubbard@nvidia.com>,
 "Huang, Ying" <ying.huang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Alexander Potapenko
 <glider@google.com>, Kees Cook <keescook@chromium.org>,
 Vineet Gupta <vgupta@kernel.org>, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
References: <20241206174246.2799715-1-ziy@nvidia.com>
 <acd263a4-824c-4c8d-a3e2-8b2f391fc775@efficios.com>
 <34C615C1-E1CB-4D8B-81D2-79CE7672930D@nvidia.com>
 <C86620B0-E95D-4BB0-9470-FDA3422DEC8F@nvidia.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <C86620B0-E95D-4BB0-9470-FDA3422DEC8F@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::21) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB9562:EE_
X-MS-Office365-Filtering-Correlation-Id: 3911ff69-7c74-4ea9-7912-08dd16ddf1a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGdERTN6eks1ZkY2TnFSQ0ZraUZuMUlxcHpqTXhmUlNJazdXOUpnSUNNZXBn?=
 =?utf-8?B?bWtsT3dHc3lDRU1Wb3NUdUdjL1FmMW1HaDY3QWVDVHNsQ01ldEVKdSttbENS?=
 =?utf-8?B?bEtERG1UTy9wWG41VFpKRWY4MmNOQngvSUZ2cEh4bUhpaUZmcEpsTFA4YzBt?=
 =?utf-8?B?NVltZUlTZUJSMytieGlpKzU5V3U1Q21JRjkxNHRERThRcVhjNDhuVUdFRXNS?=
 =?utf-8?B?aW9UT1dNMDk4TUdlWE5nNnI1NTJuajNyOGZtZ3hpTTFWTVF2QjYyNk9Fejkz?=
 =?utf-8?B?VEdHclFEVkJWMnpqb0N5UGNXNW1SbFFGWXNSZnEyVEpLUTFON2RPaWNJZ3dq?=
 =?utf-8?B?YU5DUXE4dzBGRVNDK2Q2T3RCZWppbytOWVpYWlk3VGhRSktGaXNvaHRHNDdL?=
 =?utf-8?B?M3VKMVEzc0FMTUZ4ZTg1eno2Yk55MW5ESkNYbE5meHZkbXFrZnU5V2J0QWtS?=
 =?utf-8?B?UHdjUUFDUGFHNkZhYm5wa1FseFRhRmo4VXRWNjNuWGtSbitLUkQxTEw5UGF5?=
 =?utf-8?B?ZG5rZUJHRXVlT2JZcW9tdnVNWXlmb3V6Tnk2Y3o5UkZ5U0doMXNibFJLNU9s?=
 =?utf-8?B?c3d4ZDBUOFJRb3dETzRBN2MyZ0xkbGVrdVdLNFRaN3hDT0MyNXdMZkxyV2RR?=
 =?utf-8?B?SVhQTmhJalZTMnNzUFQvYWYyNXFYOFF0Rk5jZUdFWFk5N2VXMTJmTExNZ1hh?=
 =?utf-8?B?Mnl3Qk5hcFpOZ0pNdFpEa3AvSVF5dXZJVzNNMllnLzUwVllyclFaVHVaS0Zm?=
 =?utf-8?B?YVZXQUYyWjZKY0prWG8zOFZGemp6aWZSYUduSGo4eVArQldpZk9kV1lZSGNJ?=
 =?utf-8?B?aTBESVZOVHRLY20wWWcvUENjRkpjR0c5OUoyMnR5ZHZmVHNDWE10NXBBSmRi?=
 =?utf-8?B?SFBvRlhIek5xUGFlVFpFK0k1VmxUK1p5ZnluamUwMDhCWngrcWFoRUVlb2dy?=
 =?utf-8?B?LzVLWHhJdmdLWDZGSmd5ZFNUaUpzMDRNWWhlTmRlMWpJNkk5RnZlVkNGaGo2?=
 =?utf-8?B?TllwZWZxM0lHNFB6U0Exelh0bHI0MVBFejVaV0RoYXducmtPNjdQdlZMTnhq?=
 =?utf-8?B?MnkxY0c3M3JKbkUwUVNWUCtlcmJXSWcycGRtS2hOZEd6YjA5bEhlK09vclQv?=
 =?utf-8?B?Z3VOSTNudHVHUXI0V0xxZHRHVzdqYXg2S1dteVNyNHBweGtJSTFiVi9jaXlp?=
 =?utf-8?B?clZVNmNNOWFRb0lpSHBSRVU1bm9LVjBqZk1qdkVzMldMY3hkaWsxdnZRZEEz?=
 =?utf-8?B?ZVZHUThpMmlrQlB5VFFFOGtRc1BxTGlZYzBFeTZjdnNPVmRIcjZlZFQrc1Er?=
 =?utf-8?B?RVBJZWV1TDJWMFgvOWhncjlHSFV4Rk9CZURRWklwLzU1SDUvTGlxck5RZEtJ?=
 =?utf-8?B?cExBWVlYNjV1Zml3M0NJenBJMThFR1VMZWhHLzQvM29FNVNraU5uVGNGK0J6?=
 =?utf-8?B?OURybmVVV1l6QkdMVjY1Y3V3ZHpjQXpJMDRCMTREcEsraUdoOVlxQlJvczFy?=
 =?utf-8?B?ME5ESG5nWkwwU25KZ29wbW1qV2x4NC9kazRDeXp6dmUzNGczSUJDOFJKdUpn?=
 =?utf-8?B?azBTSTliSlVxMTBHYzYyb1VmK25QN3lOMm5IMU5Gbnpac1RIcW9jV0NqNDlK?=
 =?utf-8?B?VS9SZ0pxUHhESXVPd3BPdysvbW9nWm5YbDkyU2hqZ2FCbWxWVUdFRmtQOEdN?=
 =?utf-8?B?NzZ4RHJNdHJLVDR6MFJLZGp4cU9sV29oaFIwSGV6Q0VQY2VlNzBwYklZY3B6?=
 =?utf-8?Q?mFzwuSPUvWmn4dXa80=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnFGYW1ucHNXZlhLQzlQVzBocW9mTkVsSjZuUkpXZ3h4YUljVkxUZi9QTlNY?=
 =?utf-8?B?bGl4SmNISUlOT2wvWWNucUswbzU3dUFVVHNrREMzaWZTd0pjOTI0VXFpZGVD?=
 =?utf-8?B?T0c2SkZlSC9uaFNob05JbmgvVmp5N0M1WHFLWmUrMys5a2JaQXJ3MWRES3FX?=
 =?utf-8?B?OUhLdW5qaFZ0cWxoQ0tIL2Fmamw2d25lbkFiNjZmWHVNQktKcFgwNVNhcFRX?=
 =?utf-8?B?Qi9MY2pqVVMwRjRsMEFrQWc0Y3dzSEJwNER2UHF4alA2Z0Fmdi84blRpMTV3?=
 =?utf-8?B?SlZHUVhTR0dUR1hQV2hGRzZYcy84R1RoSmJDNkliMmhORnVoNEMwMStZQnVi?=
 =?utf-8?B?QlF2TFA2cFBtVWRxajlQOVhvOVNrcmtWelhTKy9td2ZNMmp0Y3VmYWNWRVA1?=
 =?utf-8?B?R1lvTjl5dldOdUxBT1NpNXZzeXplZi9CSEM5Z083dFBmS05UVkpsTmVrM3ZH?=
 =?utf-8?B?VEtYOWZZVWVuYzVqeTZrV0YxWUVsN1o4Y0M3cVZSMWdTYUpGaFU4eDdmSGJN?=
 =?utf-8?B?bk9Iam9lQVBVc0RwcThRQXhpQklWVDZpYml6NHhRdWxFa3VISDAxZ2lxNkpi?=
 =?utf-8?B?TlZvZUNWT1o0U0R5b2NHY1hLaUEwMjU4cHo3Zk54SzdTeER0N3JUZXRQME42?=
 =?utf-8?B?TWhma0YxaDRLZ1VZOElMNmpJZVBJbjAvb2MwYlplZDhKWGM3NmpmbUhBTXdY?=
 =?utf-8?B?Vnh1ZkFGQlNqVFE1TVIvV3RvT015RjUwQllpeWxZYXpCWHB3andxU3ZGVjN2?=
 =?utf-8?B?VUI2dnB0ZnAvbklZU0JacTdNK3VPRW9UODZVY2M2QjZNbGRhc0lhaG5Pdlpx?=
 =?utf-8?B?Yk5FVDR1VHc2L0hXdm5qZ0VILzhNTDFNaS9qZmk1WTlzV2dCRmxaeXd4NTZ6?=
 =?utf-8?B?NXU3VGYxanZFY3BCY1BBWXhjUlorN0h4aTU1OVBnVXg0citycXpmMkRQajZ5?=
 =?utf-8?B?ZU5YN3pLTHlKQnpyUThoODE2TWRSVGdMa3NCcm81YVBlNjlnUk1JRm5mb1dV?=
 =?utf-8?B?M2pVUGxyWUtWMjVDYUErVnJQMzhDeEFXai9jN2dqc3VDcDF2ajlFTlU4azg0?=
 =?utf-8?B?TXFjNHFRUGFmTEI3ZDI3OUIrMEwwSmtUU25rUVZZTmxpVVUydlZuNVpOS3dz?=
 =?utf-8?B?Nk5qMlduZU1YZlZ1bXJEb29rd3NFbzRiMmFBL1dDSmlvRlpjNkhieXF1ZHdW?=
 =?utf-8?B?NHd1ZzliR0pjZGxsVFpSZEloU0pkbTcveXZLWFA3Y1lzRVRzcmlOcDYxZ1Bu?=
 =?utf-8?B?ZkUxWk40SWRWbTlKcWFDUmY3QmsxODZxZ1RjbFFkVlJUdWNjZmdkRE1ZZHZQ?=
 =?utf-8?B?cXVRczdqWm9QMFk1MjBXSUJOZjlpc1lsR2tlak5pYzhaTERVZ3BxbEhkUG1M?=
 =?utf-8?B?K1F4WGtuZE5QTEQwV3VEbTg1NXJ1WDl3WWJLNlFzcEM5VENvancrcVF1eFhG?=
 =?utf-8?B?L2pEK2ZkcDJtYVRab1Q1STZFdXlTblU3UGYvWXBpdjR2UlpDSGlNNGd4NmEz?=
 =?utf-8?B?UTNRcmFmS2pPcTlGVjRIRXlyTEpaVTlQVEFsVStNWlBkY1RBT0dabjAxUFFK?=
 =?utf-8?B?UDhiRzhXU1UxUXpxdnVpbk5XRUNwaXZmN1RGSzJYMjY1Vy81V2FyR0VnNVEr?=
 =?utf-8?B?c1BLbFo1ZEE4V3FaMnFTRkw1WFJXcFcxZ1U4R0ZmZDluNmk5Y1oxMjZuZW5i?=
 =?utf-8?B?eENUdWhEUmFYV0FFMEthNERjKzg2TEVtcllXSFRkL1N5ejR3bi9QU1lSTFlU?=
 =?utf-8?B?MVVJSDhpWXArdldvOC9wWjkwWUdweWJaUUVESU40L3gxbmhNaVQrd01PbVF4?=
 =?utf-8?B?QmFrTnhVMmVLa0ppZjFQYUpUSzNZMGwyekR0bFZOTG1PK3JTeUpkVTVmcEpS?=
 =?utf-8?B?cVFjWXNCaEJSc01JMFNDdW1uWXpuZkxza0Rlc1pRWVlyTzNlS0o1L1kxQ1cy?=
 =?utf-8?B?YjdYTWl3MlVISCszZjRnWkhiSysrdmlJWnRJZjg1WC9HLzIzak9aMFM0RDEr?=
 =?utf-8?B?VUg3MzdSUytmN0U4emxkZTZwajFibS9FVmdleS9uR2tDSytremYyblpCWS9L?=
 =?utf-8?B?NWk0TTliZTI0ZjU5aE02Smd5QVlxMFZodkQwTHF4eHB1Qk5KbW95RXJvTTZR?=
 =?utf-8?B?YkRPc1FDR2VQYjI3MDFGK09kVnkyUTFVSERCQlpwV2ZYQ1VPd2FvRVVDRGxT?=
 =?utf-8?B?UDNYbysrQVY4ektQSEZ4SFRLcENURnB1TnZ1NjJvOTltaWpzSVRyaVoxd2cv?=
 =?utf-8?Q?8RNTvkl3yJSdV5iFa5ncL8xp5jp87Kei5l6FwXtbpM=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3911ff69-7c74-4ea9-7912-08dd16ddf1a1
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2024 16:41:05.5233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vH6h8voOYDgu2jWNXz3RnGavhvEseWKqhtLL0aoctT34AMeSXQ7UyetXzE+mDgALTbCwl2mKxFaxsvQ5Dsbphhdewr8x3qdtZalelC8uMGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9562

On 2024-12-07 11:23, Zi Yan wrote:
> On 7 Dec 2024, at 11:20, Zi Yan wrote:
[...]
> 
> Or this one, which set cpu_icache_is_aliasing()’s default value
> in the generic header:

Yes, this looks good.

Just be careful to keep the same tabs vs spaces style
as the nearby code.

Thanks!

Mathieu

> 
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index 5b2488142041..e96935373796 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -6,6 +6,7 @@
>   config ARC
>   	def_bool y
>   	select ARC_TIMERS
> +	select ARCH_HAS_CPU_CACHE_ALIASING
>   	select ARCH_HAS_CACHE_LINE_SIZE
>   	select ARCH_HAS_DEBUG_VM_PGTABLE
>   	select ARCH_HAS_DMA_PREP_COHERENT
> diff --git a/arch/arc/include/asm/cachetype.h b/arch/arc/include/asm/cachetype.h
> new file mode 100644
> index 000000000000..acd3b6cb4bf5
> --- /dev/null
> +++ b/arch/arc/include/asm/cachetype.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_ARC_CACHETYPE_H
> +#define __ASM_ARC_CACHETYPE_H
> +
> +#define cpu_dcache_is_aliasing()	false
> +#define cpu_icache_is_aliasing()	true
> +
> +#endif
> diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
> index 108060612bb8..61a46cdff1dc 100644
> --- a/include/linux/cacheinfo.h
> +++ b/include/linux/cacheinfo.h
> @@ -155,8 +155,14 @@ static inline int get_cpu_cacheinfo_id(int cpu, int level)
> 
>   #ifndef CONFIG_ARCH_HAS_CPU_CACHE_ALIASING
>   #define cpu_dcache_is_aliasing()	false
> +#define cpu_icache_is_aliasing() cpu_dcache_is_aliasing()
>   #else
>   #include <asm/cachetype.h>
> +
> +#ifndef cpu_icache_is_aliasing
> +#define cpu_icache_is_aliasing() cpu_dcache_is_aliasing()
> +#endif
> +
>   #endif
> 
>   #endif /* _LINUX_CACHEINFO_H */
> 
> 
> Best Regards,
> Yan, Zi

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


