Return-Path: <linux-kernel+bounces-407488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C669C6E2A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CB5EB23B26
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC832003D1;
	Wed, 13 Nov 2024 11:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Q3RRxsTm"
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2099.outbound.protection.outlook.com [40.92.63.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFBF1BD9DC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731498630; cv=fail; b=X4nHNggQPiTx4IIK5txjvxj8WW4H87QTaGrdaM9Sjb+YPc9W2qePHL/egsesYi9dlJ97qd4K8W2eyPoDWlBPRIYTl4RDGNy3enERkwzwDn7nHvBCluM888w7GRygWrhxw+2Mr28xnfpBvcG1Cxd3B588WzN9/9AU7UIH5FTUxWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731498630; c=relaxed/simple;
	bh=aZkI9WsJcGr42tDfOkAOw+2nBlQTLZHqNL0Osjbh6zA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pB0bSeTLW8EY4EVgzuPeXXNcHF38tIj0UhrXir5I2UEYZVusnAxS4nRvMO/SzCc1hm9vfMiKTSvahTMyxWT+AtXaRiOIV+CYziKJC98EycG1O5un1kVeJwcl7hIYFvSlAEJ1EgdasURV10XdnGwMuljQQzLKlPGyKbGy9DDvzs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Q3RRxsTm; arc=fail smtp.client-ip=40.92.63.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWfuyeABV4UCKkMPpeDc4bKQJ8wCfz73DoU2xUlmy3zBCplG04RARlKpLimv4O2lxJn7e9TllNBJW6mdqsjdRn6vM/sMKnzLkbkzC8C8weHZ88u2JVfMOr6BdmFcruJlHbfBdRWACR+AZfd9HPnlsjVwXeSNe/P/p4J/9uSiDayf/6BIjobtQOh+AUjKCvtzqGRVFLtvoSn76qxh8FOu1DAqDsbAtkNMFA+9dQhXnMei/iI6bXoBhhWU74Psmx+xx/w2OWH6LaDw0a0zPQkDA0aZvyizMz6lVNNKAPNK3j2Hx+Djki4a74pXTkvqLy3gZW5L22kacNpU9RRzDV1CCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZkI9WsJcGr42tDfOkAOw+2nBlQTLZHqNL0Osjbh6zA=;
 b=A5pDEOmrvNPrif6TGu3ICqxA7zbdSXWb3uhWE7K75vNWAdW8NuI51qGxEc9hqfNHsoLor80v9p/uvN/rHXBKOGkUExFDbYIgJKScmCOcP1MqMAsnqFwoClPNwYDY5VR30eFkTC23rXWgz4Hbo4UV4y3kSwcSiWyDYkmadlhhM8r8CJz/Crn3OIz2o2ugNuRYdBWYczhxZyL8tLrkaRYLUaroR5xVE0tBCnR4PluYLbH9IOMewy0R3JLJze7HOZUxxLMAr0xeVERRgGX9G8KdEH/oZcDeFHyr9PBmmY462+0Lt1kIfVvdvoQkZzxLZ/M8XEeAl10EdluPt6XZmN7otQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZkI9WsJcGr42tDfOkAOw+2nBlQTLZHqNL0Osjbh6zA=;
 b=Q3RRxsTmSDy2FMSTPTPan+TRrC/cH2ViWdbLOdu3+XXfl5SIrU0ADiM5oCgubdWsjsskrcxYtMOA9z28pgr59L7XJQsthh3BSQGk2Y18Z3T7vrttV80HzTbxTuOIGizTHvUZlMnNQmBFgvs0xcK91HOyti8jvcDxIxVHf3Z1Cn/eDHI/ctW9pp2P/K7UrpSJ4Ef8a4STOE9s1+r8opxNZwZkFgzTNr2UwE1gUSAe+JqYW6oi19w5x9ryfjS5UNWtp8NHJOOPjonHfBf9Pe+1Ho8eO+mZ9R132iFKujvSNhhqQ+Aze4t+N0II9QXJmz2YnhWVgnE2repntROpstI/MQ==
Received: from ME0P300MB0414.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22c::5)
 by SY7P300MB0377.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 11:50:21 +0000
Received: from ME0P300MB0414.AUSP300.PROD.OUTLOOK.COM
 ([fe80::b8f3:cb85:3e65:5cde]) by ME0P300MB0414.AUSP300.PROD.OUTLOOK.COM
 ([fe80::b8f3:cb85:3e65:5cde%4]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 11:50:21 +0000
From: =?utf-8?B?6KejIOWSj+aihQ==?= <xieym_ict@hotmail.com>
To: Tianchen Ding <dtcccc@linux.alibaba.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjJdIHNjaGVkL2VldmRmOiBGb3JjZSBwcm9wYWdh?=
 =?utf-8?B?dGluZyBtaW5fc2xpY2Ugb2YgY2ZzX3JxIHdoZW4gYSB0YXNrIGNoYW5naW5n?=
 =?utf-8?Q?_slice?=
Thread-Topic: [PATCH v2] sched/eevdf: Force propagating min_slice of cfs_rq
 when a task changing slice
Thread-Index: AQHbK3ollxrR3gaeJkqsh/oWYQlEi7KzDfQAgAIchaE=
Date: Wed, 13 Nov 2024 11:50:21 +0000
Message-ID:
 <ME0P300MB04148C8F736D90AC822CE3678E5A2@ME0P300MB0414.AUSP300.PROD.OUTLOOK.COM>
References: <20241028063313.8039-2-dtcccc@linux.alibaba.com>
 <20241031094822.30531-1-dtcccc@linux.alibaba.com>
 <2c4654d1-f212-43ac-abf9-de6d08c85387@linux.alibaba.com>
In-Reply-To: <2c4654d1-f212-43ac-abf9-de6d08c85387@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0414:EE_|SY7P300MB0377:EE_
x-ms-office365-filtering-correlation-id: b48aa7cd-48a8-4117-1177-08dd03d95a4d
x-microsoft-antispam:
 BCL:0;ARA:14566002|15030799003|461199028|19110799003|8060799006|15080799006|8062599003|7092599003|3412199025|102099032|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?S3UwakV1QTZOQzVJUittazFUSGk2dTRwL1ZxNDhYZ1dNRUNYdnZQeWpCWGdh?=
 =?utf-8?B?UXUzcUt2VjgyN09Oa09XRFBjWG5DbXJDem1NUW5ocEpXZWU5WStkakZ0aG1M?=
 =?utf-8?B?MlBLSVp0Tk9LZllWYXQrWlE0dXVvTzRoQW42QzJrdlhoRmtCQms1R282dVlO?=
 =?utf-8?B?T2ltemNINUhIQVk0YjFuZU5xaWhwOXhGcEl4aVhEVzdQUHd1ZjhxMDJFbE5H?=
 =?utf-8?B?ejVUUmhNYWxaVkRBWnpHV2pHRlVEcnFKRldKdzhMd1o4dklCaU5MQk03MFdL?=
 =?utf-8?B?V3V6NXBnWFRJSFlYamxOcndKY0xZeGRqTndjSTJ0Q1drMEk1TTFSWHV6UHli?=
 =?utf-8?B?WGFWTEJjbk9nVHlEbXBlT01hYlIrR2NSU1A1djBqaFc1SzFSUTlSTTBYbktE?=
 =?utf-8?B?cnJFTWV4ZzRkUUE1bHhBYVd3bHpDZElWU2h5SGhJN1dxNXg2RExmN1dNNmNW?=
 =?utf-8?B?My9jWTlGUGppYTczVFcvOWpNcTNaRTg1RzRvMUhFNWV3KzlzcDJzSmFGdll4?=
 =?utf-8?B?UElKeEJWTC9zbURKYUFlWlcxWW5Ccm5WdGYyM01kK3BFOEdKUTFKckVtZHQv?=
 =?utf-8?B?bURVWkRXUkJPVHlwZFEvV3czdlBUVlcyMFhGa1VBMXBSUldkUXE5QWFyN2tw?=
 =?utf-8?B?MzlNRUJ0RGh5RzJxL1p4MEZlTHBOZmxsT2dxOG8yUTdzeDFjaW1tbnZRTzd5?=
 =?utf-8?B?bUpPSmVDeXZIS2JIVjdtdXRDMHVQNnd1MHV0STl6d1VnRzhjK2ltc01EbkhO?=
 =?utf-8?B?VURRejF2SkFmeWVyOEMvMCtLK1RjRXdqYWZ5cE81ZTc1RU5BWDltR3JkR2sw?=
 =?utf-8?B?S3JFWW0vSlpwSDhQVTV6eUdncEhxbVd6akI3dXU5ODVXVFFhb25mOHZuZTcx?=
 =?utf-8?B?S1JtejRRSVFtbUhXQlg1L0tiM0Y1YWprckthazFydXVLd3hpMjJKWGZNSXpn?=
 =?utf-8?B?Y29ZSUFrKzZMc2J6Sm9RMFlZblhGblE3VVF3elNKSkpMT1owKzdkQUJ5Y0tQ?=
 =?utf-8?B?OVpITU9NalRXUXB3K045TitpclZpKzE3NXJTSWdGdDFpK3cyZTh6djFNamYv?=
 =?utf-8?B?TUFxY1dnMkRUUlZSUm5kVG9NK1pUVHlZZTBYQ1FGN2RDRVpNSEJTdENURTRr?=
 =?utf-8?B?bjFRY013a1g3NUJ5Zk1uSkRDTFh3Zk5EQWY5MUprNjNGTVl0TDBJK2FNN1cr?=
 =?utf-8?B?Ymd5Y1BEbG1FYmRLLzZmcnlOMkJROVNFUnp2anh5T1JGY0pITGhKR1MrSUhC?=
 =?utf-8?B?V2VzT0U3UWNJOHo5K2J6QlRzM0ZRTitaQmhFSXdqTXQvZnIzVVovaFlldVJq?=
 =?utf-8?B?Tmp3dFI5RExYWXRSN3VYYU9qUzNXbUhSNWNlT1M3RVRkRHluSUFzZ21vVXlE?=
 =?utf-8?B?WDNxdWdnNnB0UGk4KzRSQ0Z2dkM2Snh3TWp3bW9najU0amkwVzgyNDRkSG05?=
 =?utf-8?Q?AC4GFocN?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aC83YWhnVjhYOWRSekZPUG1nZlFTWlR2QTYwTE1yb25ETURCN3YrTm9HSU82?=
 =?utf-8?B?RTNYekExajlKcFpycHdGTVdPVWxWSk1WOTlZZlFuQVJGSmJDMFU1RW5WWTJz?=
 =?utf-8?B?dUdaUjhaNnFJZ2FiQXRUbEZnV1o0dVp3MWRONmRIZTlqY0pqR0pyek5oLytP?=
 =?utf-8?B?dTIyREhDNHJwaWRKdEttY1pBVnkwNm9KRy8rQk01b1hKZ3RveW56bmQxWk5o?=
 =?utf-8?B?b2FpSjJKckk5NDdYdWlTWitxQTV4TjV3dEhPYm43am5zbUQxSUtGckhIb0tu?=
 =?utf-8?B?WkJyQlo1YnlkRmt1TWluMTFpSUxuVkMrMjdJeFpCeXJVd2o1Qi9nbEg4eG1T?=
 =?utf-8?B?WmhnS3JuYTFRN0hvOGtkVlkrTGdFVC9vYVZER0NjZU05Nk9ieEE0MzVUMTd1?=
 =?utf-8?B?MFJvektJaXE0MjcvNXRyd2g3aHBUL1JIdTdtaWl2a2JjNmVPUjlmRm1rV1lM?=
 =?utf-8?B?dE9xOXJTbis4dlAxMlB6ZTdzYTU3UXp3Tjc0RWd6MytDZGkxcTFZSEVRU1Js?=
 =?utf-8?B?TnZWR093VWV2b1lIcWlTWXFwTGNieno3Z3pPeXBHQUxGTExIV1A0a0R3M1gv?=
 =?utf-8?B?ajBXKy81S3FOaHp4TDJTU05sZlhodkUxM2JSbjRhbEQ1Tkl1aml0aE9ZaW1h?=
 =?utf-8?B?dEtSZVNXbVQ2b0FvZzBOUFRmTm1SM0lTYm1nVWVwUVRrS2JBNkV6bFdJenVZ?=
 =?utf-8?B?a01yL1cyYnduM1dJcDFPM09QYzlHRWs5ZGQxN0dGTEczS0VjTU5kWFZzUSs5?=
 =?utf-8?B?THUrNXlBN0dsVldCTzd1QVVLYjNyZStMVEtyc0dUTUpZODljREVQMjc3cjRq?=
 =?utf-8?B?NDREU1FTMyt6ZDJoZ0hINWpsOE82RjNQTUpXQnVvY1ZyWkd6cDMrVGttSFU0?=
 =?utf-8?B?cWI4ZVE4dHNpUnlHOXdFQnp0M0VDRHYxc2tUblM2aUJQb0I2S1lqSjRFSHhl?=
 =?utf-8?B?Mzl6SmNTSEMrSTlzVlpIdGlDRjUxUzFVWENtbzgxUnlkT0h4cmtjaHNZb0xm?=
 =?utf-8?B?SERwRjZRajUwOHRmNzVDMllSWUV5akdxcnA0NWJkYnNjWERXTlRnd1dYMHIz?=
 =?utf-8?B?RVpLMUl4WDBiMzNoNjhzK3dkeW81TWtLNG43Y3ljb1JkbWJ5YWlwRXZ2RGtQ?=
 =?utf-8?B?Wks5NTRRVEI5b0xvMFlySXAvNGZuVFlLejBubzYzNVlZSWNVYW5EdnFtcUox?=
 =?utf-8?B?REtvNzIrMWVkUjEzSnpXaFFlQUdHU25pVjdmR0lxZ0FVYmpOTnpUbE1mTFpn?=
 =?utf-8?B?TWJjRTZZU2FjSU1TcHdVTXE1V1lEaWZMelVUbTBGTCtrd0J4WmlFUmgzRThH?=
 =?utf-8?B?MHFXL0ZsZG5rWVJHNTc1eXlWWkdtWjlpdkNFOU5mdko4RmhlZkRoQUx2Y2Rw?=
 =?utf-8?B?RGwvdVl5L1E1ZFRGY1drV1F5aVh1VmZwaFJ0VXVNV1RoRnB0RlBsWUptcVRj?=
 =?utf-8?B?Wml0bHNMZDhVR2dTZzZRV2Q3Q2tGMC9RL1NOUG45dThsMWhjSFBubGVEY2VC?=
 =?utf-8?B?RlQ1TW1qMFJiVU01V0QrQ1c4V1ZUK0xOZFRrWEdIekRXUHBJbnhhVmZKcXQv?=
 =?utf-8?B?VDhVSnJvdkhUUmtQQXN6UVFqNlJwaVpBdnpIV1Z5aWp5TmIxU3RUQ21ncEx3?=
 =?utf-8?Q?DO7/RlHfOMq7fqqhCsTjyjw4C923wiVSY2yf741TccN0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0414.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b48aa7cd-48a8-4117-1177-08dd03d95a4d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 11:50:21.4224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB0377

U2ltaWxhciBwcm9ibGVtIGFzIGNvbW1pdCBkMjkyOTc2MiAmIDhkYWZhOWQwLCBidXQgdGhpcyB0
aW1lIGhlYXAgaW50ZWdyaXR5IGlzIGNvcnJ1cHRlZCBieSBtaW5fc2xpY2UgYXR0ci4KY29tbWl0
IGVhYjAzYzIzYyBmaXhlZCBpdCBieSBleHBsaWNpdGx5IGNhbGxpbmcgX19kZXF1ZXVlX2VudGl0
eSBhbmQgX19lbnF1ZXVlX2VudGl0eSBpbiByZXdlaWdodF9lbnRpdHkuCgpCdXQsIGl0J3MgcmFy
ZSBjYXNlLCBpdCBvbmx5IGhhcHBlbnMgd2hlbiBhZGp1c3QgdGFzaydzIHNlbGVjdCBieSBzZXR0
aW5nIHVwIHNjaGVkdWxlciBhdHRyaWJ1dGUuCgoKUmVnYXJkcywKWW9uZ21laS4KCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCuWPkeS7tuS6ujrCoFRpYW5jaGVuIERp
bmcgPGR0Y2NjY0BsaW51eC5hbGliYWJhLmNvbT4K5Y+R6YCB5pe26Ze0OsKgMjAyNOW5tDEx5pyI
MTLml6UgMTE6MjUK5pS25Lu25Lq6OsKgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZyA8bGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4K5oqE6YCBOsKgSW5nbyBNb2xuYXIgPG1pbmdvQHJl
ZGhhdC5jb20+OyBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBKdXJpIExl
bGxpIDxqdXJpLmxlbGxpQHJlZGhhdC5jb20+OyBWaW5jZW50IEd1aXR0b3QgPHZpbmNlbnQuZ3Vp
dHRvdEBsaW5hcm8ub3JnPjsgRGlldG1hciBFZ2dlbWFubiA8ZGlldG1hci5lZ2dlbWFubkBhcm0u
Y29tPjsgU3RldmVuIFJvc3RlZHQgPHJvc3RlZHRAZ29vZG1pcy5vcmc+OyBCZW4gU2VnYWxsIDxi
c2VnYWxsQGdvb2dsZS5jb20+OyBNZWwgR29ybWFuIDxtZ29ybWFuQHN1c2UuZGU+OyBWYWxlbnRp
biBTY2huZWlkZXIgPHZzY2huZWlkQHJlZGhhdC5jb20+CuS4u+mimDrCoFJlOiBbUEFUQ0ggdjJd
IHNjaGVkL2VldmRmOiBGb3JjZSBwcm9wYWdhdGluZyBtaW5fc2xpY2Ugb2YgY2ZzX3JxIHdoZW4g
YSB0YXNrIGNoYW5naW5nIHNsaWNlCsKgCk9uIDIwMjQvMTAvMzEgMTc6NDgsIFRpYW5jaGVuIERp
bmcgd3JvdGU6Cj4gV2hlbiBhIHRhc2sgY2hhbmdlcyBzbGljZSBhbmQgaXRzIGNncm91cCBzZSBp
cyBhbHJlYWR5IG9uX3JxLCB0aGUgY2dyb3VwCj4gc2Ugd2lsbCBub3QgYmUgZW5xdWV1ZWQgYWdh
aW4sIGFuZCBoZW5jZSB0aGUgcm9vdC0+bWluX3NsaWNlIGxlYXZlcwo+IHVuY2hhbmdlZC4KPgo+
IEZvcmNlIHByb3BhZ2F0aW5nIGl0IHdoZW4gc2UgZG9lc24ndCBuZWVkIHRvIGJlIGVucXVldWVk
IChvciBkZXF1ZXVlZCkuCj4gRW5zdXJlIHRoZSBzZSBoaWVyYXJjaHkgYWx3YXlzIGdldCB0aGUg
bGF0ZXN0IG1pbl9zbGljZS4KPgo+IEZpeGVzOiBhZWY2OTg3ZDg5NTQgKCJzY2hlZC9lZXZkZjog
UHJvcGFnYXRlIG1pbl9zbGljZSB1cCB0aGUgY2dyb3VwIGhpZXJhcmNoeSIpCj4gU2lnbmVkLW9m
Zi1ieTogVGlhbmNoZW4gRGluZyA8ZHRjY2NjQGxpbnV4LmFsaWJhYmEuY29tPgoKcGluZyBmb3Ig
dGhpcyBmaXguCg==

