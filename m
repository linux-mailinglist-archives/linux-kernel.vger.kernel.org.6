Return-Path: <linux-kernel+bounces-409389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827E19C8C0B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4322028A900
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E27370;
	Thu, 14 Nov 2024 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="opjz3f9j"
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2106.outbound.protection.outlook.com [40.92.63.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB9E17555
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731591849; cv=fail; b=J5+tJEiGaxlnXlO6vo2f6ZeceDeY4tUGVN2KsrgiN9o6/EWjPuajEWU/pkI0VUWozgJRD9uqUZjG3Hqvp+LqNbVL2aWlT0GrFy0WSsG8QwdPHob7c/WT3rt85lmRe1JhqNa6vxxl4iqraR/7C7i9vE0Cb9uBfFUIimKS2gGdU4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731591849; c=relaxed/simple;
	bh=yxWbshqtn6jP3Ci9HtqvUBYhbTCmQIvdA89gO8jgmPI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k62eXEAbZHe52scYvnGf47O3t5RO7cuMaIl3jgAeony5yz8sLE2WLf4IQjDmgO9WZItozDPzgAxJH2O+iO2NZOFA/eVBvviK48RZZ1h68IRD/uEKISxyepuP+ClnFxk//5N1+wKt/6bZ/dbuTfjfgzLUzHr3fNAPiJOqy8up+Z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=opjz3f9j; arc=fail smtp.client-ip=40.92.63.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CBL2cILcTfThKTxyYDPsK+AsHA/a8cO0a8JIv1ua8hfl5CdZfdXPwuNFBOo5jBuwK1S/PywRX3318rBLjzJBcNt904HIKJNQeI66j41+Y8bBLUdGtHsxFHCPs/XWKM++oWfqJkEUz77ksqbRu6Hsc3/Y5mZUSaUOWoxOLza2c/CGSWATMdvFq3BwmLm7AOuGS9QEfS5V8zJAn4VrpOzGXno9Gv1MS1sr8kY0t88d4xNnzaMvBYiowWAuaxD8Gw1IrgYnkYHThI8wJzxYthxdt0B+QQDTVLrJ8+lQKnhECDLcQ2LalK/2so6VwQqNZD+xnU66/p/24/ok04stj5Q1Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxWbshqtn6jP3Ci9HtqvUBYhbTCmQIvdA89gO8jgmPI=;
 b=jib+aJe7yIo5OfbL99a682xjDoMssBB+bPy28Z4BfiNvE6eeRnsJ2koo8inEf4IpfDd8o/fpeO6byD8GYTOP5DstosUTpYuD2yxTi4c+Tk/lVzImbhaFZKgFcGpGSYMC0m1Ke975nHZgQh9PYcVqrqsgGCWiDmB05ihM+xWQYweSEKDZ7uaT15eUvzG2cSWf2OwIGQUSyDN58W4dYjOdF7lz2gPrUuGx3yvB2jNS+P6VTBTWyQC7RLeKMpbjMXfEYuu+3K3Z0MYb91z5rM14ir18Mc/JMQivNKWqNC+sn095hsZCrIbu3OdaVP6BUNgiAtZ361Udm+gRXdkvxGcVkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxWbshqtn6jP3Ci9HtqvUBYhbTCmQIvdA89gO8jgmPI=;
 b=opjz3f9jdNKQPnZj9kFKgd5Q9SsK88Rrm1jstEBzf47FLwZHyulOrd4ccOCdynBa1mYan/9ckG7Ve0MQ9S7Yz1E/lTyjxWeYZIeAPpegbVEYCf3wBdnObHlndJSj636MzWSVLHM4FO49/pa6kSnRsZsFt+g+NeS5GyGI2GhymMrlFvXOY4TDEH1GhGVeFg9AMTrT/TzpS0kfo+/5VyGNFXP+oDBr/k7TVEQfeULlLzyANIEfNJaYnTkL/cMU0vvjl1rkZ+ghA6vJ3IvziKub346uYcHVrSWZp9FKZk5igfBBN1GA0Wwn8qSyZ/br2fefxczZqe3WX3PzLmOmZTX9QQ==
Received: from ME0P300MB0414.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22c::5)
 by ME0P300MB0446.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 13:44:02 +0000
Received: from ME0P300MB0414.AUSP300.PROD.OUTLOOK.COM
 ([fe80::b8f3:cb85:3e65:5cde]) by ME0P300MB0414.AUSP300.PROD.OUTLOOK.COM
 ([fe80::b8f3:cb85:3e65:5cde%4]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 13:44:02 +0000
From: =?utf-8?B?6KejIOWSj+aihQ==?= <xieym_ict@hotmail.com>
To: Tianchen Ding <dtcccc@linux.alibaba.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjJdIHNjaGVkL2VldmRmOiBGb3JjZSBwcm9wYWdh?=
 =?utf-8?B?dGluZyBtaW5fc2xpY2Ugb2YgY2ZzX3JxIHdoZW4gYSB0YXNrIGNoYW5naW5n?=
 =?utf-8?Q?_slice?=
Thread-Topic: [PATCH v2] sched/eevdf: Force propagating min_slice of cfs_rq
 when a task changing slice
Thread-Index: AQHbNl+eeCIHlIuuJkuIdlNQTlVEdrK2X4nEgAAGiICAAGHc8w==
Date: Thu, 14 Nov 2024 13:44:01 +0000
Message-ID:
 <ME0P300MB0414C750ED323B988D8175708E5B2@ME0P300MB0414.AUSP300.PROD.OUTLOOK.COM>
References: <20241028063313.8039-2-dtcccc@linux.alibaba.com>
 <20241031094822.30531-1-dtcccc@linux.alibaba.com>
 <2c4654d1-f212-43ac-abf9-de6d08c85387@linux.alibaba.com>
 <ME0P300MB04148C8F736D90AC822CE3678E5A2@ME0P300MB0414.AUSP300.PROD.OUTLOOK.COM>
 <d83e1631-237e-4743-b067-6cc54771eee7@linux.alibaba.com>
 <ME0P300MB04142599FB1D9BBF8AFECE7F8E5B2@ME0P300MB0414.AUSP300.PROD.OUTLOOK.COM>
 <a903d0dc-1d88-4ae7-ac81-3eed0445654d@linux.alibaba.com>
 <ME0P300MB041447EBB0A17918745695898E5B2@ME0P300MB0414.AUSP300.PROD.OUTLOOK.COM>
 <1d2ad284-c887-4377-9512-a74dc418efa1@linux.alibaba.com>
In-Reply-To: <1d2ad284-c887-4377-9512-a74dc418efa1@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0414:EE_|ME0P300MB0446:EE_
x-ms-office365-filtering-correlation-id: 24aed403-9880-42f2-59d5-08dd04b26619
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|15030799003|8060799006|461199028|19110799003|7092599003|15080799006|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?VlY4TEFSc0RuS1JlaVZWVjZEVVlOUDhkMWlpeHJ4cWZacDA5U0VibWRKYmo4?=
 =?utf-8?B?YUhLazdIWVJJamZPMm1sTU1idEZSZEZ1aUtJN2J3TVlPNExLRy9YNGgxbWsy?=
 =?utf-8?B?dHNrbjZOTXBnZjFMVTd4N2xHK09hQ3NhOGlCb3BxWGpsVGJXU2pNMWliZFRo?=
 =?utf-8?B?UUdEK1NBNjBQMXhWZU5oWklnVnRqMy9Vam02cmtwU2J6Y2NqRWNlbzV6dFhS?=
 =?utf-8?B?MFhWa2FuOFNiY3VBY2JjcWxtOGw2RS9ndm1GVHhCMklPemhPVTFGaG85eWdE?=
 =?utf-8?B?Uk5uUWRUdm9yUmZZVXFhc2pCeWNsY09SUHBHSUJ2eU5taG5yckZuQi9jclBS?=
 =?utf-8?B?RVk0Tk8yajVoMTBtazhIUStsb2lOVFNpRC9ybzl0bEF5VkdTbjhwMDFlODUy?=
 =?utf-8?B?czJXVHp3QWZ0MTcrcDlYdmQ0eGpkQVBFQm83T0t1eS9iTXFQc0E2c0Z4Q1pq?=
 =?utf-8?B?THdpSGZ3emgrM3hDbzFtbTB1VDloTDl3KzRuaWFrQlU0cGlUK3Y2cVlEblRr?=
 =?utf-8?B?dEo5OU5CaWtCK2F5Tmt6cnBzcVI0VkVBU2E5THI4RkUyVkpJUEdjVzB5NUF1?=
 =?utf-8?B?QVBtbHRXOU5ac1FSMDhUWVVNRE5BMEg3WmUvMVh0L3pBbkxHTmNrUWNGVU93?=
 =?utf-8?B?aEdUWEQraDg2S0NzL0thNGFCQThVRmk0YXpKZUhpdjdWNjJyQkwyWTExNlVs?=
 =?utf-8?B?a3VxUE52WmpZMi83bVFHeGQwTy82alU4UkhhM0hFUlFaZjlYMU41MTBWRFNr?=
 =?utf-8?B?T0JOQVduQ1NTSTFDbUdEbnNuMlJVWmgwWGFpdWlFdWpBbEswVFMrL2NIL2hR?=
 =?utf-8?B?M2hXM3dob3JGcVJUOUJKVDVYd0dzai9OU2pqOUhOSjBDZE9uRkgwY0RmZjNS?=
 =?utf-8?B?TWlBcHJacHdlWmN3NXZ1Q1dlWHJRM3NwVFpvUEkxM0NIbzJoUGVJd0x1Z3Zv?=
 =?utf-8?B?cFV5SXY0WitqdGdnTVhwTzVkQm5nQVd2M3N6Zmppd2xvUU43U0ROZFhtSUpK?=
 =?utf-8?B?RVpzUUErTXp4c0dOVUtZTmlMdUcyQzVldUlqNHd5ejUxQlFIRFlNRFRoZ1kz?=
 =?utf-8?B?NzJZeWNjRFJOcHN3ZGlTVWtoNjhaaGwvMkhGU0JzNnQydlpnQ3JoMitMalBP?=
 =?utf-8?B?NkNxVjNic1RoRDFOUUUzTEg5TUlhMnF1d1EyM1pLbmZFV0poamp4ckJqK1Vx?=
 =?utf-8?B?MWNNK0k3RDZuZ0dyTElJRjBGd3JkZE5FemxmaDVmYmVSaDEvZktYMXN6LzNQ?=
 =?utf-8?B?WCsxWFdaOEtDUlVSclhjQm85ZnpiS3Z4bHp2UUtYMm8vK2NjYTcyWlhFK2xS?=
 =?utf-8?B?UTQ0ZXlZbStFTzlnbC9zL25McVEvUE9jS2VvcFJHNGNiK3hWMjJXOUpWSEpF?=
 =?utf-8?B?U0tmWXl5Tis3Zk9yNm9ZU0E5S1Vpd2dBWW5HUldueGo4T055L1E2OHljQko0?=
 =?utf-8?Q?0XWLvoMi?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWJJNTMrSk1HbWNieUpyMzMveEFDTGNJNFhDMjRGSU9rWDloL2ZyN1kyZ0xt?=
 =?utf-8?B?bWVGbTh0NzZQcWFkSjNIbVBrTXBLZ2NIWlczRGxiL3YycjFacFJHRStJZGdy?=
 =?utf-8?B?N1crZGV1djY0RHltVnpoamVXM3l0RGV1VUpwOVJFNVJXRVVJbnpqTkFiUFh5?=
 =?utf-8?B?eXFwelJQdHhJSHZyT2dkUTJ5Q012aFRPWnRUK0U4RmZtK2xJTjhTSVBhYTRU?=
 =?utf-8?B?UUMrd202UnJQdjEvTEk0TkUrZEtOSGpTSllCVno3N1R2YU1TcDdOVlQ1SjlS?=
 =?utf-8?B?aTJlYjkrR090ejZYV3VuVHd4dnV3S0JvYnhEQ3g5RjdIdjJJT2tOVkN5WTht?=
 =?utf-8?B?VWoxQnp1cldiN2JCUkNQSXk0aFIzN0RxRXBiV1lMSURjeDBkQURxNFM0UldL?=
 =?utf-8?B?S0QvRXplUlBxZFZtV3lSNmw2bHNqVWZtaXhJTkloQjRvUHN1ekR6TThqcEZF?=
 =?utf-8?B?enNXclpzY1NPTEtIUXUzVE1kS2tTYWZZTUR0SHpiREVNMTJoMVd1UURLamxY?=
 =?utf-8?B?T2N0Y3o0eXdRODUySjU0RUo2a1BtNjFnRmtVbUllZTZEcEoxWUlEWGtxbjJD?=
 =?utf-8?B?TVpheFErWUp4S21YWW1BUE4wQmVScG14dzNPT1VWbENrVHg1RmlpTzRGRkV5?=
 =?utf-8?B?dzBKdUpXZDBXSW1MN2RNNjFLK1VKQ0Y3UlEra3VvMk5GRW1TZks0a24wdTBo?=
 =?utf-8?B?U2Q0Q1ZPam5nVG9Jcy9Kb01DUk9HQUgvLzJHUkpsTmhmdTNzYTBKb1BKWVhM?=
 =?utf-8?B?NU1KODFmZ09JK1NYWW1mdlNxbitCYk9mcktjMDN1Vi9DSzR4ay9wcU1LS2NE?=
 =?utf-8?B?VlBQZm16bVZGNGw5SjdHY0Y5QVJhbDF5cVJ5WWN5OHp5bGIyWHpJd0w5cHF6?=
 =?utf-8?B?S3lBUGxraFVkbFBDcHIvUmxVK2VZTkw2TjJRMFVQRzArN1VZVFJadmUxOHht?=
 =?utf-8?B?YnZndkVSNE54Wnk3NlZ4TmNxY2NRZnNkSTZTUWlHbXp3cTFvOUl2MVJBcnE2?=
 =?utf-8?B?cEo1MGd1MUN4ZzR0TTFpLzZEQjdIejVwMWlNdTdYeEY0NnVwelVpYjRweGdt?=
 =?utf-8?B?S1pzKzBvTlYxVUQxZGlaRnlLNzFYSWtqTWkwQnVGOEdiMkRNV3kxd3diZXU0?=
 =?utf-8?B?Y1RLZ1F6UmowVzFwNUlBYmFWa0dUMGJJY1lZWm5pUmwyb0s2eWFDY1NqZmw1?=
 =?utf-8?B?Vmw5bE5HYnlQekxraVdFQXRERnB3c1duUDExWmI3OXlpRWRmL2pTMk5HcFFU?=
 =?utf-8?B?RUgzcUt4WXpmdHh1eUphYnNsSG0vZWdDaUEwMWFmSDNEM3Z2dExyYUpMZ3dU?=
 =?utf-8?B?Zjd5OGQxR2tQdTZ3YkpqdjhNZVdhV1dZbVlEbGo2bm5qQ2phR1RDNENsSjFi?=
 =?utf-8?B?algxUU83cStBUFRJK1RrR1VackU0R3dRYnFmSzFuZFozUU9MYTRSV2hldjBD?=
 =?utf-8?B?QUZjcUZHQTZPbExiU20zalZDZ3h0eE5INHYrVU1oeHpmRzd1MmExWnQrVlNE?=
 =?utf-8?B?eVhEYzZtZFd0bGZDS0FJWmRmQzNrcU5Vd2dXS3dlNUhNVHJ3R0djWjhkMlUx?=
 =?utf-8?B?SkcwWDFyUFVzQzE3VGZSL05NMVVCNituY1pscXJRbERYdk5hdDFZUzFhUzBK?=
 =?utf-8?Q?IQCtNCV6GG/4KoqZ1AJ2vUJIBNvgV/fJgO2Pb0ilF9IM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 24aed403-9880-42f2-59d5-08dd04b26619
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 13:44:02.0003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB0446

U29ycnkgSSBjYW5ub3QgY2hhbmdlIHRvIHB1cmUgdGV4dCBtb2RlIGJ5IG15IGNlbGxwaG9uZS4K
CnNpbmNlIGNvbW1pdCAgNWU5NjNmMmJkNCwgdGhlcmUncyBubyBDRlMgYW55IG1vcmUgYXMgbXkg
dW5kZXJzdGFuZGluZy4KClRoZXJlJ3MgdG9vIG11Y2ggY2hhbmdlLiBUaGVyZSdzIG5vIHByZWVt
cHQgY2hlY2sgaW4gZWFjaCBzY2hlZHVsZXIgdGljay4gUGV0ZXIgaW50cm9kdWNlcyBhIGhydGlt
ZXIgdG8gbWFyayB0aGUgdGltZSBvZiBsYXN0ZWQgc2xpY2UgdXNlZCB1cC4gUHJlZW1wdCBjaGVj
ayBvbmx5IGhhcHBlbnMgaW4gd2FrZSB1cCBwYXRoLgoKVGhpcyBpcyBtYXJrIGZvciBkaXNhYmxl
IHByZWVtcHQKY3Vyci0+dmxhZyA9PSBjdXJyLT5kZWFkbGluZSBtZWFucyBubyBwcmVlbXB0LgoK
U2luY2UgeW91ciBmaXN0IHBhdGNoIGZvciAiRm9yY2UgcHJvcGFnYXRpbmcgbWluX3NsaWNlIG9m
IGNmc19ycSIsIEkgcmVhZCB0aGUgc291cmNlIGFuZCBmb3VuZCB0aGVyZSdzIHRvbyBtdWNoIG5l
dyB0aGluZ3MgaW4gICBlZXZkZi4gCgpSZWdhcmRzLApZb25nbWVpLgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwrlj5Hku7bkuro6wqBUaWFuY2hlbiBEaW5nIDxkdGNj
Y2NAbGludXguYWxpYmFiYS5jb20+CuWPkemAgeaXtumXtDrCoDIwMjTlubQxMeaciDE05pelIDE1
OjQ3CuaUtuS7tuS6ujrCoOinoyDlko/mooUgPHhpZXltX2ljdEBob3RtYWlsLmNvbT4K5oqE6YCB
OsKgSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+OyBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6
QGluZnJhZGVhZC5vcmc+OyBKdXJpIExlbGxpIDxqdXJpLmxlbGxpQHJlZGhhdC5jb20+OyBWaW5j
ZW50IEd1aXR0b3QgPHZpbmNlbnQuZ3VpdHRvdEBsaW5hcm8ub3JnPjsgRGlldG1hciBFZ2dlbWFu
biA8ZGlldG1hci5lZ2dlbWFubkBhcm0uY29tPjsgU3RldmVuIFJvc3RlZHQgPHJvc3RlZHRAZ29v
ZG1pcy5vcmc+OyBCZW4gU2VnYWxsIDxic2VnYWxsQGdvb2dsZS5jb20+OyBNZWwgR29ybWFuIDxt
Z29ybWFuQHN1c2UuZGU+OyBWYWxlbnRpbiBTY2huZWlkZXIgPHZzY2huZWlkQHJlZGhhdC5jb20+
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnPgrkuLvpopg6wqBSZTogW1BBVENIIHYyXSBzY2hlZC9lZXZkZjogRm9yY2UgcHJvcGFnYXRp
bmcgbWluX3NsaWNlIG9mIGNmc19ycSB3aGVuIGEgdGFzayBjaGFuZ2luZyBzbGljZQrCoApPbiAy
MDI0LzExLzE0IDE1OjMzLCDop6Mg5ZKP5qKFIHdyb3RlOgo+IGRlbGF5ZWQgZGVxdWV1ZSBpcyBu
ZXNzYXJ5IGZvciBlZXZkZiB0byBtYWludGFpbiBsYWcuIFBhd+KAmXMgcmVsYXRpdmUgdnJ1bnRp
bWUgaXMKPiBub3QgbmVjZXNzYXJ5IGFueSBtb3JlIGluIG1pZ3JhdGlvbiBwYXRoLgo+Cj4KPiBp
dCBpcyBub3QgYSB0dW5pbmcgb3B0aW9uLgo+Cj4gcmVnYXJkcywKPiBZb25nbWVpCgpJIGRvbid0
IGtub3cgd2h5IHlvdSBzbyBmb2N1cyBvbiBERUxBWV9ERVFVRVVFLCBpdCBpcyBub3QgcmVsYXRl
ZCB0byB0aGUgY2FzZSBJCmV4cGxhaW5lZC4KClRoZSBjYXNlIGlzIGFib3V0IGNncm91cCBoaWVy
YXJjaHkuIEFuZCB0aGUgdGFza19BIGluIG15IGNhc2UgaXMgYWxyZWFkeSBibG9ja2VkCmFuZCAq
b3V0IG9mIHJxKgoKSSdtIHRhbGtpbmcgYWJvdXQgaXRzIGVucXVldWUgcGF0aCB3aGVuIHdva2Vu
IHVwLg==

