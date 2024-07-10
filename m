Return-Path: <linux-kernel+bounces-247264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A9992CD40
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09848287463
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D451013AA35;
	Wed, 10 Jul 2024 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="MI06PNYM"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2071.outbound.protection.outlook.com [40.107.117.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70298131E4B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720600705; cv=fail; b=SfWuYHp0E/TrZhFimFhb/Bl9pH94zWM7H/WxrC9hKmsTK2Wb5+m53YnaUV8AYrNNapjOF6Q63En8Ypu6zacX5iPsieVE2iVTr7ITnXc1Es0leeyDKDf7S+JpZ0SboQbj7+9Lw/XTaB4EQiyGd6irXY9zuQQCNi2CUl1qsED3LvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720600705; c=relaxed/simple;
	bh=zx6+2YzOZS61unBA3aFXD8OSXnYvudpoz7pkBunpS/4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ktYMJjIJQC7v4ypzIrZu8+DW0P6w9ywh2nYwsDnGPI7AitWAd5MtPFqKA/ccK0J2V2a726iyijif0/sxSRlJXGSL7Q5S97DPZAYqQrHkcPs+D70H6lNjyLxBLWBQilIROOvMZpel7BDu++qMMydwJm+9QunLE42nRZWt6A9xG/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=MI06PNYM; arc=fail smtp.client-ip=40.107.117.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+M0zjOPakaY0mXANuDKNFvoKbfzQ2Wl8+spZeBIKva+KMU4zSXQU+OKF1GAS7/Xi5BS1r6rKWx3FqAIlbo8YMFu+c86N7Y/O2AAbm9ag01RwQBlsry93mHpH9dGZlG3VHhk+Ddy9/pWHCf+5uD+KnQbG/I83pmt2qL3APUXXZVcrMVNiAW1Nk9VbO+SM4oQEtXrdcFQLy4AXMXEpMYl1AthKjAi5RiIm0NLlQvv9Rs5Ew67+IqCzDNnabjQesFu1V8+p1n7XDhnb4p+etGocp88SFqghNLqJMnBq+Equ0mdZ3bOIPcyyh8U5aPR792mlx6hHbyjkHI7jxPVA/wdtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9sm8r/vIVTZQuEHU0YyuoJIGBFhQsJPfHb+Fs9JYck=;
 b=J++mHWTbWVLgh21YN0QMdBnCcAK7a8aWBzI5vTON4XOqEYKtxkxfTc3wPvdHpNgcCxyeyHuk/W1dEyEMMv77B/awn4hiXoPs74EzQ7XEihxSTSmrwROyJP/sq3fm5BBdHBptKdwni4NFcBlloFAuzKhNQB2O2K1C7x7dndhk1LT5ubOt3eiaW+xmpRAFnMhiWX0rFTt0VYzNqzwlbo/7fLlUU3TZOKWDIkVMi5x2khbdhDfeJwwLW50zGMTrpCqRvUQBbJGMrqFNwIpSXKV5UkZDxwm7mwYGBornZiRG0dKZZM2RsKMRystGB5IdaaEORi3xMFiv62YHZjzWlVrUig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9sm8r/vIVTZQuEHU0YyuoJIGBFhQsJPfHb+Fs9JYck=;
 b=MI06PNYM9zQJSEABpRnOFoNKpzq6IXhSgrVYNecU4+Kom8gDUo1BTr2OE8mQiVsEsqLB7+TZO/Rk3uXH1dnBtz1bMe9mq6Frk4GPPpXCiZEcNO9fJlskzX35P6RbLW9GKiMJQPp6CjAZmzr7iGSb5LpXbmyhPMN3Q3A5mQDFRbnjO8NdWJDBn21qov5YKjX6qk5lyhWXK0+o4iUktccHIOj6j6ZTUK9USeZFaK0F5hu6ge+yWjrbzI24U6Hq381UHeCWOqX4oK5b81gRecqLhIVl0hQ/p2Fzr1Q+Pk4/kOKwUBS8omYdtmglsmYqSIwu3+PyVnkGXUyaJJhaPze8dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEYPR06MB5792.apcprd06.prod.outlook.com (2603:1096:101:b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 08:38:20 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 08:38:20 +0000
Message-ID: <85b144ba-ad45-4ce7-92d1-bd8f6fe222b7@vivo.com>
Date: Wed, 10 Jul 2024 16:38:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] mm: shrink skip folio mapped by an exiting process
To: Barry Song <21cnbao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 opensource.kernel@vivo.com, willy@infradead.org
References: <20240709142312.372b20d49c6a97ecd2cd9904@linux-foundation.org>
 <20240710033212.36497-1-21cnbao@gmail.com>
 <dc2c3395-e514-40ad-b9d8-b76cf04ba0df@redhat.com>
 <CAGsJ_4zkt5wKk-JhEpZgqpQgNK--50jwpZFK4E_eXgBpKkMKmQ@mail.gmail.com>
 <9d77dc44-f61c-4e52-938f-c268daf0e169@redhat.com>
 <CAGsJ_4z6kv=KhZ=DY-puG0uVosEPWx2=CNH0TGBG4W9tZoW+NA@mail.gmail.com>
 <db98cf80-6755-4083-83d7-cd750fd029b6@vivo.com>
 <CAGsJ_4ze50AYaBnAAt=pyZ0rWQ6scpeuYaFiqJfGeibET+anKg@mail.gmail.com>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <CAGsJ_4ze50AYaBnAAt=pyZ0rWQ6scpeuYaFiqJfGeibET+anKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEYPR06MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b20855-f794-44a5-6d41-08dca0bba711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZklRZTM4MXc1NVIwUDNtcHkxcHcwdkVGNGM5NGw2dGg3ZllhTW10Y2YvZ3R4?=
 =?utf-8?B?ZHRoT0gwQy9UYTVyc05HTXZMZC81Y2VMM1FjcEN5UTM5UXIvU09jOHh3czFQ?=
 =?utf-8?B?RWVJcktxRzRMQ2hWOTgyT1B2UjRsQ0hWSm82TEV2bTZhaDVqRTZoUG9UalVX?=
 =?utf-8?B?ZXdGQUtacEUwZ0xZcll0YVE5ZWx1ai84MU9UekxOL09tR2R4clNzN1RFU0Qx?=
 =?utf-8?B?MUc5ZkVoVXd3WFZueXNCY2Z1cVp2U040Y3drUDZGdXZKZ1VzOHFDSENyd29v?=
 =?utf-8?B?WFZRSHdka0VFSzZ0R3JPT2Q4MDIzR0hTQ093NVc5MG0yMDNyT3ozZDl3NWww?=
 =?utf-8?B?T1pCQjVFLzlBanJqcVVzbS9IeG1pamx0azBRL0dsR2g3a3BqaDBSdjE3QmE2?=
 =?utf-8?B?OEFUM01VbTY4cDZ5cTBYQU5McVI3ME1wYThta0ltWVRQck9CS05PcEhTemJI?=
 =?utf-8?B?Zlh0UURzUzI5UEQ0SENvL2MrM1J2T0dpd3F0MW0zR2F6RncxSzk5NnFscTUz?=
 =?utf-8?B?dWRaMng0ektodmk0eGFna2kyUGxhTng3Tnl1TVpJRGdSdmJmaGdURTFKdXZm?=
 =?utf-8?B?Qkg2QWpZVmVQVmtsd1d1TVlqZ0RVTW40MkJTUEd0UFR3RjR1eEFrQzIvU3Bi?=
 =?utf-8?B?ajJDeDV4UlBqSDlHS01HWjk1dXQvRGd0cnFEa1hhUXMwRmViYnAxOHo4ZTNZ?=
 =?utf-8?B?SS9CTGkrRWMrUk8wZEVDRkdITkN5cWJyVGNvRUQxM0xucDdhaFUvc1NwcDQ4?=
 =?utf-8?B?YXNqSU9VVkI5OFREMDU3c3pRaVptZEhJNkZmVmhEcXhYTk15bGFZU293VG44?=
 =?utf-8?B?WUxKZHkxSnR5QlVnVEdRNG45RFFjZEhVdTM3NFlBdm41U2NPWXZnTjI0SWEr?=
 =?utf-8?B?UEFzNVRTUzJReTlFTkhOODlUcldOaTB6NmZ5L1hIbThOL3VycE1IQ2YrTnBR?=
 =?utf-8?B?cnNLS3JFbmxhOUlvdnk4OHR3cXkvV29TaGt2bkt4SDd4NnYrTXg3YXd1bFNQ?=
 =?utf-8?B?UTFKSlp6eS9YL2JSVi96SXUvN2RCaVpzTGFmZTMyUFJYRDMxR0tjcGdMQ3N5?=
 =?utf-8?B?YXF3U0hXR084NFdrMCtHa1lHcWN5ajVuUE1wK2hhUWxZZEVGMG5vZ3BpZTlC?=
 =?utf-8?B?MmVhdHRHa29WUDQ3S0JxVHlsN0pscUFKcTlpalNDZnFURkNHeVFRL0FDdFpV?=
 =?utf-8?B?c3l0NlBGM1VtQURleno4cEprTjM2ZUNYQlRBdTNnSmwrT0tDRHRsb1ZYZ0JD?=
 =?utf-8?B?cTYweklCdDR1WnBTV0hOam5ndmh4V3diSWh5REtLR2E1Q3M5QTJRem1PL1kv?=
 =?utf-8?B?djYvRC9uR1hXcFpORUl4VjlvY2NJTFp6QUttcUp4eDN3anJsdXlubjJLS3dl?=
 =?utf-8?B?VXBqRjFEMERiWWtXWHJiK0d4NFdCOHE5cTEwRkhKOUg0V0JSeEZ1d0kwZkhE?=
 =?utf-8?B?emtKd2UyeHZhazlkUW40S2gxN0xnZzBCS2NxUyt6U1FYNWMyd3JuNEM5Rm5n?=
 =?utf-8?B?alZyZXpJeDVCZXZxeG93MFVoSmhHRGYvWXhUTXFaR2pIajQxUHptUGtnT204?=
 =?utf-8?B?MmhBYXQvaTQxY2dSdkp1M21JWU5XaWdnL1c0ZWpQT1l3Y293V3cyS1dTNDRj?=
 =?utf-8?B?dWhjNHdqZU5IOHZNcmY2cWJJR3pVUDh4MG1IYndoTzgrMjFsMnlYVER1eXRX?=
 =?utf-8?B?cnRVcTRpQ3c4RE1XWFBjWGxuM21FWmp2dXM0cVlsZG1vU0FET21XYVkyelB4?=
 =?utf-8?B?eUQ2Rldvdi9IUUpaYjg1Z0VOUjh3N21penFPSjE5NllOTFMrTTZSc0dneEY5?=
 =?utf-8?B?b1ZPbUFUaFA4WWd6VzdUK1dla0lzcUVtbVZ1SStseDJ5UEFUVkVFYys2aThO?=
 =?utf-8?B?eWVjOXhoY2VhVERUMEIzbXoyc0UxZnk0TG1Zc0Y2SVVIV3pCMlFjTkN3OTEv?=
 =?utf-8?Q?3tpfQtsmDe4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFFLUVJsOVMrR1N2aHZzc213anhmMXFDTllkVGxzaUtVbkxDQVNZYlNqZzJB?=
 =?utf-8?B?VDE0K3JON3BTTWVEMUpBKzduN29nME5xeGNNZTFBVTI1V1JXRTRxYnN6OTV3?=
 =?utf-8?B?cTZhckEzMSs0eG4rRGRCeWtxUWdXN3h6QVZ1MlloTjlQR2w5VG9JNUlDMXVP?=
 =?utf-8?B?UlluMDRkc3pXd0cyNEQ3NERNTkkrNkx1ZnJ0bkdkNGVkQ1loZ01pNjgvWHBT?=
 =?utf-8?B?TzhGOUlZR1BmT0ovWU4yc0g4UzNMNDBpMlhPNysva25tNVBWNmJNTUdBQ2FW?=
 =?utf-8?B?Y2R5MGpUVmpKQzZyU2tlTldZSjlIQmNnYXZ3b290a3pQSU9JbnNjUmd3Tko2?=
 =?utf-8?B?ckxLK2xyV0ZTLzZnbHIxT3ZQbzIrY283MlBPN2duS0gvMTBiM2dqQnJCbG91?=
 =?utf-8?B?VEJqMkhaeUMxcjE5M1BwWGJtb1owSGN1L0lIaEoyQ0d5dERHd0RURVlsRTRX?=
 =?utf-8?B?K1RjYlI4Vi9UZzFMMmx2dzllY0Q5a0JIYmk2YUs1b01oZWtkT1FTYUJYcElZ?=
 =?utf-8?B?QkNkNkxUc0diNDhUdk1hYStYMHZsRG9NTFRQeTBVZEtpQVZIMlZSOUFML3Qw?=
 =?utf-8?B?RnNvN0pDSWxFRFFPM2N5RWhmV2tnTkxKdmtSUlViR2NWd0dLMjMrcVVDakt5?=
 =?utf-8?B?dzAvMnluWHpuV25XYVp3Sk1xM0pHOGs3WmZPanUyMCsyTHlzS3kzSExBd3J6?=
 =?utf-8?B?Nmg2cFNyS0lMTGNmQWM2UXE4S0huMTZadk1YMXpsRTl2blp2c2F2WHpyOUp2?=
 =?utf-8?B?VzU3WnNLVnpTS3ZuNzJQQ0RHeFVWUmFidEE5Ukk0cTFzWjJvbXVrSi8zT3Yz?=
 =?utf-8?B?cEFDVk5MeXF5a0xub0ZCTmxkRjYrQUltNFE4eHNvQXoxZ2RDZytjaGh2amVO?=
 =?utf-8?B?RmFyRmNGdWE4c3FIUTduR2NBQ0VxeFp1d1JnQnNQR0Viam83UHhuVUduSHN2?=
 =?utf-8?B?NU1UTDVGYUJPSEZJUTVpeG1FZENLdk56TG5lb3QxK1lIeS85a2oxWTkvSmR1?=
 =?utf-8?B?K1BhcUlVWElwaWZzVStDV2YxYlJLZEpSL3VjUmtaRGxxOEkrTHNqWlMzeEVR?=
 =?utf-8?B?enZsSXlIMDVJQmZmK0QvNDh6U0hEeXFtWndFY1o3b3N4RFJsU0k5dHp6VUVF?=
 =?utf-8?B?QlNyaGRqU0lPaGYzNTRPbDBtQ1Y3TmswNUQ1TkxmVVp5N01hNzhicmxkREdp?=
 =?utf-8?B?ZXhJS1pxK0hrdmRCWU1UTm1jQnNoMEhpdW1jcEZvOWg5cmZsRTA4bTByY0s0?=
 =?utf-8?B?eDBRN3YwRE4wM2Mwc1RyZUhveHpreCt3MGdwL2FOdXZybGZnOVVnR1YxK21j?=
 =?utf-8?B?V3BITGsyNTZ4anFXYitpK2RiMWlSa2UySVpGaW0rbGRvc2hHS3dTQzNTYnNU?=
 =?utf-8?B?bzdueUIzaGZrNE9VQXpZRkxxNS9hVXRMVDV6a1lxTzI2SEpRSFlWNWtBTjdt?=
 =?utf-8?B?bm1jeGM2c09Kajk0MWRsVmNlM1pwNjFJV3N5UjJ0amJIOHl6SVFjWHRyMFhP?=
 =?utf-8?B?aHdqbU1nM3VOOUthUmdFdXZZNjZtZGl4LzRzM043Zy9Ub3FrOS85SHRHY0Zy?=
 =?utf-8?B?T2tZWlRNOXgyajBBcmg5SlJxN2ZUbDN5NHR6ODgvbi8rdmwvSzFERXBuaTdx?=
 =?utf-8?B?TkM4UDhyZE1wNXBvMEJtaDFVTWVZdCtnVTlwM0l1aTFPMmZ1d2JCZktSeWI2?=
 =?utf-8?B?dWdla0wrWFh5OVkxamhxeUxqbXYxOElpNXF4Y2w4WHRhQlZXZjd5ZVZBd1N1?=
 =?utf-8?B?YnhDVGtqTHcrUTRBeVJFYnZva2lYdXhTc1dqdGJ6U2RFTGhqYUE1cS9wYk5O?=
 =?utf-8?B?a2VlVDA3NGRpVi83aDNaeCtwblJYR21ObFFrTjY3WWVzdTVzNXJCZ2RtczJx?=
 =?utf-8?B?OTBUcitGUkh0ZGQ0TjZNb2loa0I3Nm11KzV6NlhvSk9ScXJmazQwdTZndFNL?=
 =?utf-8?B?TFVWZ2RNM01yVTUwWGNORnlCMjgwaExBbWt5b0xGNEk5cG1CdGVwRms1bFNV?=
 =?utf-8?B?MHRCbFlYeDZLMmQrTGM0WWNKdmVIRmludnYzc0phdVVnU2d2TEVHL0JNRTlD?=
 =?utf-8?B?elR6eUJONE13WDVIYWtvWktUNVFQQmlCejRVRWRhaGhid0RETmtNZlZEdGF2?=
 =?utf-8?Q?Cu+8Qp07Q3wKA1RDPO1AnWULd?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b20855-f794-44a5-6d41-08dca0bba711
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 08:38:20.2835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmGRLHddfgwWPj7tNxwYczk0IuW9r2bg/282Q5AwZ1eMHPr9XTpXt2XC14wBueec6RJGpWJ4DwhYXc9Kn9bUGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5792



在 2024/7/10 15:11, Barry Song 写道:
> [Some people who received this message don't often get email from 21cnbao@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Wed, Jul 10, 2024 at 6:47 PM zhiguojiang <justinjiang@vivo.com> wrote:
>>
>>
>> 在 2024/7/10 12:44, Barry Song 写道:
>>> [Some people who received this message don't often get email from 21cnbao@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> On Wed, Jul 10, 2024 at 4:04 PM David Hildenbrand <david@redhat.com> wrote:
>>>> On 10.07.24 06:02, Barry Song wrote:
>>>>> On Wed, Jul 10, 2024 at 3:59 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>> On 10.07.24 05:32, Barry Song wrote:
>>>>>>> On Wed, Jul 10, 2024 at 9:23 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>>>>>>>> On Tue,  9 Jul 2024 20:31:15 +0800 Zhiguo Jiang <justinjiang@vivo.com> wrote:
>>>>>>>>
>>>>>>>>> The releasing process of the non-shared anonymous folio mapped solely by
>>>>>>>>> an exiting process may go through two flows: 1) the anonymous folio is
>>>>>>>>> firstly is swaped-out into swapspace and transformed into a swp_entry
>>>>>>>>> in shrink_folio_list; 2) then the swp_entry is released in the process
>>>>>>>>> exiting flow. This will result in the high cpu load of releasing a
>>>>>>>>> non-shared anonymous folio mapped solely by an exiting process.
>>>>>>>>>
>>>>>>>>> When the low system memory and the exiting process exist at the same
>>>>>>>>> time, it will be likely to happen, because the non-shared anonymous
>>>>>>>>> folio mapped solely by an exiting process may be reclaimed by
>>>>>>>>> shrink_folio_list.
>>>>>>>>>
>>>>>>>>> This patch is that shrink skips the non-shared anonymous folio solely
>>>>>>>>> mapped by an exting process and this folio is only released directly in
>>>>>>>>> the process exiting flow, which will save swap-out time and alleviate
>>>>>>>>> the load of the process exiting.
>>>>>>>> It would be helpful to provide some before-and-after runtime
>>>>>>>> measurements, please.  It's a performance optimization so please let's
>>>>>>>> see what effect it has.
>>>>>>> Hi Andrew,
>>>>>>>
>>>>>>> This was something I was curious about too, so I created a small test program
>>>>>>> that allocates and continuously writes to 256MB of memory. Using QEMU, I set
>>>>>>> up a small machine with only 300MB of RAM to trigger kswapd.
>>>>>>>
>>>>>>> qemu-system-aarch64 -M virt,gic-version=3,mte=off -nographic \
>>>>>>>      -smp cpus=4 -cpu max \
>>>>>>>      -m 300M -kernel arch/arm64/boot/Image
>>>>>>>
>>>>>>> The test program will be randomly terminated by its subprocess to trigger
>>>>>>> the use case of this patch.
>>>>>>>
>>>>>>> #include <stdio.h>
>>>>>>> #include <stdlib.h>
>>>>>>> #include <unistd.h>
>>>>>>> #include <string.h>
>>>>>>> #include <sys/types.h>
>>>>>>> #include <sys/wait.h>
>>>>>>> #include <time.h>
>>>>>>> #include <signal.h>
>>>>>>>
>>>>>>> #define MEMORY_SIZE (256 * 1024 * 1024)
>>>>>>>
>>>>>>> unsigned char *memory;
>>>>>>>
>>>>>>> void allocate_and_write_memory()
>>>>>>> {
>>>>>>>         memory = (unsigned char *)malloc(MEMORY_SIZE);
>>>>>>>         if (memory == NULL) {
>>>>>>>             perror("malloc");
>>>>>>>             exit(EXIT_FAILURE);
>>>>>>>         }
>>>>>>>
>>>>>>>         while (1)
>>>>>>>             memset(memory, 0x11, MEMORY_SIZE);
>>>>>>> }
>>>>>>>
>>>>>>> int main()
>>>>>>> {
>>>>>>>         pid_t pid;
>>>>>>>         srand(time(NULL));
>>>>>>>
>>>>>>>         pid = fork();
>>>>>>>
>>>>>>>         if (pid < 0) {
>>>>>>>             perror("fork");
>>>>>>>             exit(EXIT_FAILURE);
>>>>>>>         }
>>>>>>>
>>>>>>>         if (pid == 0) {
>>>>>>>             int delay = (rand() % 10000) + 10000;
>>>>>>>             usleep(delay * 1000);
>>>>>>>
>>>>>>>          /* kill parent when it is busy on swapping */
>>>>>>>             kill(getppid(), SIGKILL);
>>>>>>>             _exit(0);
>>>>>>>         } else {
>>>>>>>             allocate_and_write_memory();
>>>>>>>
>>>>>>>             wait(NULL);
>>>>>>>
>>>>>>>             free(memory);
>>>>>>>         }
>>>>>>>
>>>>>>>         return 0;
>>>>>>> }
>>>>>>>
>>>>>>> I tracked the number of folios that could be redundantly
>>>>>>> swapped out by adding a simple counter as shown below:
>>>>>>>
>>>>>>> @@ -879,6 +880,9 @@ static bool folio_referenced_one(struct folio *folio,
>>>>>>>                         check_stable_address_space(vma->vm_mm)) &&
>>>>>>>                         folio_test_swapbacked(folio) &&
>>>>>>>                         !folio_likely_mapped_shared(folio)) {
>>>>>>> +                       static long i, size;
>>>>>>> +                       size += folio_size(folio);
>>>>>>> +                       pr_err("index: %d skipped folio:%lx total size:%d\n", i++, (unsigned long)folio, size);
>>>>>>>                             pra->referenced = -1;
>>>>>>>                             page_vma_mapped_walk_done(&pvmw);
>>>>>>>                             return false;
>>>>>>>
>>>>>>>
>>>>>>> This is what I have observed:
>>>>>>>
>>>>>>> / # /home/barry/develop/linux/skip_swap_out_test
>>>>>>> [   82.925645] index: 0 skipped folio:fffffdffc0425400 total size:65536
>>>>>>> [   82.925960] index: 1 skipped folio:fffffdffc0425800 total size:131072
>>>>>>> [   82.927524] index: 2 skipped folio:fffffdffc0425c00 total size:196608
>>>>>>> [   82.928649] index: 3 skipped folio:fffffdffc0426000 total size:262144
>>>>>>> [   82.929383] index: 4 skipped folio:fffffdffc0426400 total size:327680
>>>>>>> [   82.929995] index: 5 skipped folio:fffffdffc0426800 total size:393216
>>>>>>> ...
>>>>>>> [   88.469130] index: 6112 skipped folio:fffffdffc0390080 total size:97230848
>>>>>>> [   88.469966] index: 6113 skipped folio:fffffdffc038d000 total size:97296384
>>>>>>> [   89.023414] index: 6114 skipped folio:fffffdffc0366cc0 total size:97300480
>>>>>>>
>>>>>>> I observed that this patch effectively skipped 6114 folios (either 4KB or 64KB
>>>>>>> mTHP), potentially reducing the swap-out by up to 92MB (97,300,480 bytes) during
>>>>>>> the process exit.
>>>>>>>
>>>>>>> Despite the numerous mistakes Zhiguo made in sending this patch, it is still
>>>>>>> quite valuable. Please consider pulling his v9 into the mm tree for testing.
>>>>>> BTW, we dropped the folio_test_anon() check, but what about shmem? They
>>>>>> also do __folio_set_swapbacked()?
>>>>> my point is that the purpose is skipping redundant swap-out, if shmem is single
>>>>> mapped, they could be also skipped.
>>>> But they won't get necessarily *freed* when unmapping them. They might
>>>> just continue living in tmpfs? where some other process might just map
>>>> them later?
>>>>
>>> You're correct. I overlooked this aspect, focusing on swap and thinking of shmem
>>> solely in terms of swap.
>>>
>>>> IMHO, there is a big difference here between anon and shmem. (well,
>>>> anon_shmem would actually be different :) )
>>> Even though anon_shmem behaves similarly to anonymous memory when
>>> releasing memory, it doesn't seem worth the added complexity?
>>>
>>> So unfortunately it seems Zhiguo still needs v10 to take folio_test_anon()
>>> back? Sorry for my bad, Zhiguo.
>> If folio_test_anon(folio) && folio_test_swapbacked(folio) condition is
>> used, can
>> it means that the folio is anonymous anther than shmem definitely? So does
>> folio_likely_mapped_shared() need to be removed?
> No, shared memory (shmem) isn't necessarily shared, and private anonymous
> memory isn't necessarily unshared. There is no direct relationship between
> them.
>
> In the case of a fork, your private anonymous folio can be shared by
> two or more processes before CoW.
Hi,
I have added folio_test_anon(folio) condition in v10.
Thanks
>
>>>> --
>>>> Cheers,
>>>>
>>>> David / dhildenb
>>>>
>>> Thanks
>>> Barry
>> Thanks
>> Zhiguo
>>


