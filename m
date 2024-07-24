Return-Path: <linux-kernel+bounces-260944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E4E93B0B2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C27F1C211D0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 11:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC1E157461;
	Wed, 24 Jul 2024 11:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="chwlfku4"
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010062.outbound.protection.outlook.com [52.101.229.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148A941A80;
	Wed, 24 Jul 2024 11:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721821663; cv=fail; b=DOqg6CFOOH79azGG6svmakZDQGJICWVEzdrwQpZ791Pv6RFYuh6SeXF4DBV5LVV+vWnHWhrok3duEwFdhhEIJIIw+2XQgf73vaIVbIDKfc7AvXquCeMJL21JZNGsWbXWaUe2dXPz5gON/3ASG0wmIj/kAy4tQPhhWDJ46JJFLaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721821663; c=relaxed/simple;
	bh=ARVOQAxiig5Ks5DSduAaaiBj9U/XUkWybUvofnojBuk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P8fhHkkcQeL1UgFz3E5xDleq9tBhG87AHbAVp/6PBHLUUaUio/NDD9ITE35sxuucW0b1R6kHY+TvhjruPAdFu4Hq+CEkTMDZNGERirMhhGC4pBhDn7MDxOsnVifCUgUsoKKo1F7GmhO/Z0/E8rbzwy6eGaFOT/oBAQGvO9x+WaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=chwlfku4; arc=fail smtp.client-ip=52.101.229.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VnhdMRXHYK3YVeAEUDIW46mIuJhRYm9H7OjYdXHDMY1S6ZFy/uxrHenyxrsVyYINKOBh0Qj9U0rgzeAQv19xZsG/2kH3go8JyWrO0JtDpfZFIe64ESElrPyYq/teXwIvpS/8qjEZhBWsKSj6TzE2hRI08B9KoXKPZQbTc4bazPnszbWhITpCD6L6h8obWh3rAhIr+0Ga06UKSoNyXP0+ksFdSksr3bukJ+qEuLHKUkAB+iPwE7nTc++S0twWm4HMsWeFGaED+Sa93BHRkL9/OifUbvgg6H1l5taosYYxwn0tTHqftrSMJ/NOaLn9erF8qzOyzjjwRy/VkHgAYIoB+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARVOQAxiig5Ks5DSduAaaiBj9U/XUkWybUvofnojBuk=;
 b=yKWATGb8rzYXd1zvoUxHIykHxsMqoHGd/KDlno8sVQowe7eh6EwXjq8X2RQdnY4MIObcWoQgXTbunk9I82vO94xvgfksNg2nTwr50CsGS3EMq08T23LZK1EoAZPEgJsm5zk1SV2s1ekmvJiTFgtS/pKeRVHhz33uaXGTy/70O0Ysf1C+h9XFZEx+HkWoqIjVfhqTpGGDIaEjLMbfcOyjRHqfkI6GM4ZWx9HCRHnhSq1iEBlv1oXw91gfzT9X+SG8ZBoLGJUBGwdSTY1Ux15NJecv0Ds1bMqMz/FY1oXoMTwI87YTj3f6rcU1VyfXIaLpVQc7U2/MtEPBHNM2UCsrpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARVOQAxiig5Ks5DSduAaaiBj9U/XUkWybUvofnojBuk=;
 b=chwlfku4aEbwP02R5/TyaMBXu2RReJT1UqQ3a3SNDjL0/Li9m+4il2e/qdRD3l2TTQfQI17RqTt/HcRFDqaa3ScxU57jkV0xXM1pNAV+XWhJbx20skFbQN7CrigPFgXOLzXBWo4T1p/318o/jFqk7jJrHkeYtPcQ0FZEcUKy1uw=
Received: from TYTPR01MB10989.jpnprd01.prod.outlook.com
 (2603:1096:400:39e::14) by TYWPR01MB7204.jpnprd01.prod.outlook.com
 (2603:1096:400:ef::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 11:47:37 +0000
Received: from TYTPR01MB10989.jpnprd01.prod.outlook.com
 ([fe80::9294:7c7c:537:5ec5]) by TYTPR01MB10989.jpnprd01.prod.outlook.com
 ([fe80::9294:7c7c:537:5ec5%7]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 11:47:37 +0000
From: Steven Niu <steven.niu.uj@renesas.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>, "alexandre.belloni@bootlin.com"
	<alexandre.belloni@bootlin.com>, "linux-i3c@lists.infradead.org"
	<linux-i3c@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
CC: "zbigniew.lukwinski@linux.intel.com" <zbigniew.lukwinski@linux.intel.com>,
	Alejandro Gonzalez <alejandro.gonzalez.wg@renesas.com>
Subject: RE: [PATCH 2/2] i3c: i3c-hub: Add Renesas RG3MxxB12A1 I3C HUB driver
Thread-Topic: [PATCH 2/2] i3c: i3c-hub: Add Renesas RG3MxxB12A1 I3C HUB driver
Thread-Index: AQHaYaM8CTFN7C36TU6+d12yl3Gvd7HPaBeAgDXAZ3A=
Date: Wed, 24 Jul 2024 11:47:37 +0000
Message-ID:
 <TYTPR01MB109893062FB3F0D4141444219BAAA2@TYTPR01MB10989.jpnprd01.prod.outlook.com>
References: <20240217131412.4145506-1-steven.niu.uj@renesas.com>
	 <20240217131412.4145506-2-steven.niu.uj@renesas.com>
 <bae054d217aa577838593244eda02b008e3749a5.camel@codeconstruct.com.au>
In-Reply-To:
 <bae054d217aa577838593244eda02b008e3749a5.camel@codeconstruct.com.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYTPR01MB10989:EE_|TYWPR01MB7204:EE_
x-ms-office365-filtering-correlation-id: d9eb23e9-80e3-45df-900d-08dcabd66a35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UVFLK0hSQUMyNGZYSXFINWFrYlFJUEduZjN4enVTRUpRcFZSR0h0QVl6V0RN?=
 =?utf-8?B?OW1pV2FIZ09BbmIrRGtWenQrZGpmenMyVXpwY1p5bGJJWjE5YU8zM1dBL1gy?=
 =?utf-8?B?WDNSckVaRXZaUGNBRmx4bTNVTlpZNTZwQmxEempWLzNEWDArbzJvWTRSR2s3?=
 =?utf-8?B?TDNiVDR1dVFKTkZ3aHd6RmUrZVFucDBEb3lzVm1zdFBYZG14b0tUTFUrTlZ2?=
 =?utf-8?B?VUtZa0xKeTVjSDVIZ09WRHMvMGtaeWdmeVdTTUVBbTM1WVRwbTV0OEU0d3pK?=
 =?utf-8?B?ekZBYi84Rk5BZXMwNmN0TUJtQ0JTMWw2Q0g4QW5qYTlVRjJrblF1b2ROQTJu?=
 =?utf-8?B?WTJhMEpYUzVsM0xQVnBFdzVHRzZYOEFYOEJNZGRKMTAwcVBmdmMrb00xNTNT?=
 =?utf-8?B?eVFFQ1h2QkxnVzFhWnJvQ3h3Qm1hOE0rbkUyRmpicFl0dEFKZ0swSW5heWJG?=
 =?utf-8?B?U2k5UmFhNzMwREJnVWlyaU9adFRLY1ViTVQwQzVRcnZQanoyeEhqZGY5NXE3?=
 =?utf-8?B?RDc5VmRLOE0yK3FycWtaYm8wd1VOVHljRU8zdUQ3VjZUd0h1dDRLR1BjcDBU?=
 =?utf-8?B?RGpvdG1XMnRlV3pYN0tmWmdvc2IreUU2QnF5TjhyNThzRC9ESG83SlJRbDBQ?=
 =?utf-8?B?YmtmcUYra08vZ1JkM1F0RmFJenAyNlRBZ0ZiMFZuU1BkUG1IazBmV0hLaHRF?=
 =?utf-8?B?K0xwZFF6K3d6QmxpOG1ncnpUaVBSSk9WdDYvZXhuaTYrcm0zTTh4VkZMSmhX?=
 =?utf-8?B?ZkxYWUNTbHVweUFWRWFFTnJlWHVrdWZKU0JBQTFsdDkxZlA0YVA3Z2ZsSzRT?=
 =?utf-8?B?c2tNYzgzMWhGNDhqTDNQSjRNQTZ2cjhPMjNwQXl4Mi9NRisvQlRyaERLeHhj?=
 =?utf-8?B?UDE2ZlhyY2U5bnJidXRibUpzVkIxc2xraHo3bFpNa0RIWS9oWnRDZkF3OFdI?=
 =?utf-8?B?b3k1dm9vc3BmUTQ3VVRZV2FKYlJaTnJFbVFFdWdIaWhtc0tFNVdUV2RZWXdw?=
 =?utf-8?B?V2hXQUFrSzQzdk96VnFQbEhSTHRZSWZUOVY3SlBqMjdpZzd0Q1lwcHB1Zzhz?=
 =?utf-8?B?ZWZJRnRLdDVWUU53a3VncHV1SnJsQlZqb210ZCtpaGFDczZhdHlZYk5PUWlS?=
 =?utf-8?B?RkxKb1BOUjRSQ3poZ01Fc2JvdklWTzVwSk5oVGFpMm9yTGxydHd5SEFRRnVR?=
 =?utf-8?B?cFA5ajM1bnBQcXp5SVZnQXZJS1Boek5xcEFWam1tMDVyQ3RCWFV0QzFnckJu?=
 =?utf-8?B?dWE0L2JYR2tjazNQWGJ3Q0dIODBqTE0yT3hOQ0dDL2RLREZVUDd3VFhoU3ZO?=
 =?utf-8?B?K2crTm9KTDNIb2N0dmErRWF3OHlRcmxRMUVpY0tTVEhIRlR4d3JhZmpLYm1Y?=
 =?utf-8?B?TDNtck5YY0Jyd0tlTytMTkU3UHJ4TzhtNFRIazVXZERWUkxKRXQzQkJkd0dy?=
 =?utf-8?B?SFBMekVaVXBkT2x0WHB0MmFYVTZPWUpzaTlEeDRoWWxBVTdmdHJNUlRtNlFl?=
 =?utf-8?B?REFwN0JlS2pIV2JBaEZNMmc5UHN6RkMwYW5tZ05LTXZBOHBhZjlCazAyaTM0?=
 =?utf-8?B?RG9oSkdHdEhlL2pzZG5oVjFvaVlDUHBJV1c1b053QWVBVEdIVlNJbFp3VUta?=
 =?utf-8?B?QjZxK05oVjROaFZwZHVyd1VjdEd3bDdDK1FqK3VQYTJpRXZMMjBKT2tpR1Vo?=
 =?utf-8?B?VW5kTWlQNERHclJhNURvM1FFRFppSlB1S0l0YVRkVnhaa2kyWEZEckU5Z05o?=
 =?utf-8?B?bVh1Nk9WSDBCZHJhd3lhaklrQ2lsRHV2QUNLMmFiOVpiejhOSjJsVzhicHVl?=
 =?utf-8?B?dCtsRHRzbHM1OFlPeTYwREw1OEhIcWtyVkpvM3JPYXNBQ0JieWdDeFVSbWpM?=
 =?utf-8?B?cG9LdmlpQi9RbldsRkhBTlZIMFk4cFB2Mi92cktmbkdkbUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYTPR01MB10989.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y3hKdG54MGl2RVRva0p5Ung2MWM5YUdwNS83a0pTMmlNK3JEdDNLM2d0S0Nw?=
 =?utf-8?B?S1gzeFFpLzlRaUc4S21Pa0V4Z2t0SzlzcitBV0xNbzBCWDhOSFBrZEZmMlh6?=
 =?utf-8?B?VVBlb2JnUkU2QjUrVXZ4VXQ2M2tlRDg3MGoydXFPSU9qV3IwMmc1dm1RL2kz?=
 =?utf-8?B?WVR1YlZDRzhNQjR0Y1ZJcW5Ycm9QWDJjMTVqdjlDR0VDcm40YWNsc3pHMU5r?=
 =?utf-8?B?SWgxWUR2RGZvZ3NrQkN2dTNVcTZWSk9KRXdtN0xUUG5ZeGNZQWhvcnY1eEhZ?=
 =?utf-8?B?UXpDQ2ZUQlJ1bTJUa3cvSWJNOWVyOE5ha0gxT2VWY01wcUt6YWxoOVgwUG8z?=
 =?utf-8?B?TVl0UFdER3JPSytWbk1aZEFDS1QvUHV1b1g5WkZTWUdZbmw4YW1RR240VlVN?=
 =?utf-8?B?c0U4QWxKODhPeGRIQUR2UlBOU0hXOHlXRVczRi9DbGlzZjZxbjdHVThrcGJG?=
 =?utf-8?B?TmhZY0NXeXJxZ0dQZlFhS2VGSkV2M3F0NWV3TkFRd0RpMmF1ZDVRNm5DRm5r?=
 =?utf-8?B?ZG9sYkhsdzVLUFhDNWNTMFNobklqakczY3BhOVFzb3drZkV5anQwcEt5NlNy?=
 =?utf-8?B?TmtUcTN6cC81NnNTaXhCbFRJNnZqTEZ5M2p3ZzRDWFpla1psZlRZMHJadTd4?=
 =?utf-8?B?dEFyazNjc0oxRTZXZjVSMDdmemR3cmQyOTc4Q1V4RlA0b083aDBWNmp2aklF?=
 =?utf-8?B?TWpjOXV0RDl5VE5vNXgxNnUvMlQ1em9xNHpiTklKbzhBNGdkVW9zSklFZ0cx?=
 =?utf-8?B?ZG9hVFZVaVZkS0VjQURXdDhFbXdDcTRHT214Z3ZJVGkzMmZacFp5MCtIYy9p?=
 =?utf-8?B?ZDlsYXFZQTAwYzJEMXRyNjl5bHpEQWY0aHR0WE9DbXZBc0ZoQmZ0YlNuYllt?=
 =?utf-8?B?SEtXeXZucmtnc08zUGtDR2xRQURPM1JIWnVKNWFCazgvWGhiZGZIMXl5VENF?=
 =?utf-8?B?Vk1UMThjd0tJc084bkdyckFqOVlxRnZMMkJnWlNoRVcyOEwvQU52dnF5UlBa?=
 =?utf-8?B?aTVTYXl2UEhnT2hXODJsOFhSS2pUaXJlQkhicklKQ1haQXUyOU1uTjB6dkk3?=
 =?utf-8?B?OHFabEUvUXJUOVlWT0V2U1BJaXk5WmV5TmRXMVNKdUlXM3k1VVNwd1hXRDYv?=
 =?utf-8?B?emIxVWVLZSs0bEI3dmVJY0lYR1pQdG55UlBwZ2NGS1RtdGVZeHh0RjF3cHMx?=
 =?utf-8?B?bG9XeEZORGNJTXh5VGErWkxzc0Fza2d6Ui9FS1lrVjlxdW9sTW1kMm5ML09X?=
 =?utf-8?B?Zm1NUmFtQ0ZXaTRLTWg5N0cxS1dYaWVTRHBEQkRlTEV5RUh2aUhvNnFUZ2J3?=
 =?utf-8?B?M2ZzakV4djJXM1dHb3ZvanRLemQ2VlErWVVVYk5GVlZqdFNYRHBtbzd3aWg0?=
 =?utf-8?B?RndPMmExd1FLYlphSXphR1dCTW1lOTNWak9IL0FXUW1kRmEwdktRMjhESDBu?=
 =?utf-8?B?c2l3UzRUL1lRVjhHSm5LVGNOdVI4Z0ZUVytRbmVrc1hwOENQUzI4V2VJUXls?=
 =?utf-8?B?dFovSi8zL0U2RDJnMUxtK2x1RTFyVGRTMEV6alBWVUhLbmVnclBoUTJINjBo?=
 =?utf-8?B?SzduZklzVEsvUUhwQytRckFzSFRqa3A5Uys2Y1czOE1Wc3c1cFVES2tCbFBW?=
 =?utf-8?B?bC92bkkyeE9DV1ZWM0JYZHNzZVZGZU5oL2JOeVNCaGVLMDJRRmhsR00yK2dJ?=
 =?utf-8?B?MWg5MWdiRUJTWWNvd29YMG9RbW8xbC9RZXdLMzkvZlU0bFcrd1JGZTllc2U0?=
 =?utf-8?B?aWdIaFdha0s0SXN0TUFiVVlSWXdxUysxZTBnVllSUzBvdEpKL1B1WjBPUE9M?=
 =?utf-8?B?Z0dXb1Axalk1cVU2WVJLb0N4V1lJcHpUK2JoS1A3NzlCcEpmMTk5L1hmZXR0?=
 =?utf-8?B?dFJKN1JpN29EZzdpYXUwMkZDR1hkK2dtR1dHVEZXTkpRQXlyWitKcEJBT0J2?=
 =?utf-8?B?aDlLRStMdnBaclJYQzJMWW9FQyt5K0Z1YjVQb0RYNFlQbGNsZExib1l0VFpZ?=
 =?utf-8?B?VWdmNldBYnpWViszTmJBZzIyZTFvYUZyeEoxMmZtQ29hZmpYOEU1a3YzYzNo?=
 =?utf-8?B?dkJXSi92d0VWRzV4ZW9QZ3F1Y21oOWFOSmN2dlcxR0xma3hDVEt5S3dQZXVQ?=
 =?utf-8?Q?9C3lCty9qUONGh4DlbmSWkX21?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYTPR01MB10989.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9eb23e9-80e3-45df-900d-08dcabd66a35
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 11:47:37.2417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0bXdye1XJ1CLAGCMUhXj6/ILpUNlyjh1gDMYdH/k8ALhj3AbqjjZ9FCNPikfpjvNExYNJS70ehPzzv0ef8Bkh64gOUJ+15QpEU0Tt9aryks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB7204

SGksIEplcmVteSwNCg0KQXBvbG9naXplIGZvciB0aGUgbGF0ZSByZXBseS4gSSBhbSBvdXQgb2Yg
d29yayBmb3IgYSBsb25nIHRpbWUgYmVjYXVzZSBvZiBteSBwZXJzb25hbCBlbWVyZ2VuY3kuIEkg
YW0gYmFjayBhdCB3b3JrIG5vdy4NCg0KVGhhbmsgeW91IGZvciB5b3VyIGludGVyZXN0IGluIHRo
ZSBkZXZlbG9wbWVudCBvZiB0aGlzIGRyaXZlci4gIA0KDQpXZSBhcmUgd29ya2luZyBvbiB0aGUg
Zm9sbG93aW5nIGl0ZW1zIGFmdGVyIHRoZSBmaXJzdCBzdWJtaXQgb2YgdGhlIHBhdGNoOg0KMS4g
TW9kaWZ5IHRoZSBiaW5kaW5nIGZpbGUgdG8gbWFrZSBpdCBmb2N1c2VkIG9uIHRoZSBkZXZpY2Ug
ZGVzY3JpcHRpb24gaW5zdGVhZCBvZiBkcml2ZXIgZGVzY3JpcHRpb24uDQoyLiBGaXggdGhlIGNv
ZGVzIHdoaWNoIGRvZXNuJ3QgZm9sbG93aW5nIHRoZSBrZXJuZWwgZGV2ZWxvcG1lbnQgcnVsZXMu
DQozLiBSZS1pbXBsZW1lbnQgdGhlIFNNQnVzIEFnZW50IGZ1bmN0aW9uIHdpdGggSUJJIG1lY2hh
bmlzbSBpbnN0ZWFkIG9mIHBvbGxpbmcuIA0KICAgU01CdXMgQWdlbnQgZnVuY3Rpb24gcmVxdWly
ZXMgdGhlIGRyaXZlciB0byBjaGVjayB0aGUgc3RhdHVzIHJlZ2lzdGVyIG9mIHRoZSBJM0MgaHVi
LiBQb2xsaW5nIHRoZSBzdGF0dXMgcmVnaXN0ZXIgb3ZlciBJM0MgYnVzIGV4aGF1c3RzIHRvbyBt
dWNoIGJ1cyByZXNvdXJjZXMuIEkzQyBIdWIgc3VwcG9ydHMgcmVwb3J0aW5nIHN0YXR1cyBjaGFu
Z2VzIHdpdGggSUJJLiBUaGlzIHNoYWxsIGJlIHN1cHBvcnRlZCBpbiB0aGUgZHJpdmVyLg0KNC4g
UmVtb3ZlIHRoZSBpMmMgc2xhdmUtbXF1ZXVlIG1vZHVsZS4gDQogICBUaGUgc2xhdmUtbXF1ZXVl
IG1vZHVsZSBpcyB1c2VkIHRvIHByb3ZpZGUgYSB1c2VyIGludGVyZmFjZSBmb3IgU01CdXMgQWdl
bnQgc2xhdmUgZnVuY3Rpb24uIEJ1dCBpdCBoYXMgbm90IGJlZW4gaW5jbHVkZWQgaW4gdXBzdHJl
YW0uDQoNClRoZSBmaXJzdCB0d28gaXRlbXMgaGF2ZSBiZWVuIGZpbmlzaGVkLiBBbmQgd2UgYXJl
IHdvcmtpbmcgb24gdGhlICMzIGFuZCAjNC4gDQoNCkkgd291bGQgYXBwcmVjaWF0ZSB5b3VyIGlu
cHV0IG9uIHRoaXMgZHJpdmVyLiBJIHRoaW5rIGEgcmV2aWV3IHdpdGggeW91IGlzIHZlcnkgaGVs
cGZ1bC4gDQoNClJlZ2FyZHMsDQpTdGV2ZW4NCg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBKZXJlbXkgS2VyciA8amtAY29kZWNvbnN0cnVjdC5jb20uYXU+IA0KU2VudDog
V2VkbmVzZGF5LCBKdW5lIDE5LCAyMDI0IDI6NTYgUE0NClRvOiBTdGV2ZW4gTml1IDxzdGV2ZW4u
bml1LnVqQHJlbmVzYXMuY29tPjsgYWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb207IGxpbnV4
LWkzY0BsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBy
b2JoK2R0QGtlcm5lbC5vcmc7IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgY29u
b3IrZHRAa2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCkNjOiB6Ymlnbmll
dy5sdWt3aW5za2lAbGludXguaW50ZWwuY29tDQpTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gaTNj
OiBpM2MtaHViOiBBZGQgUmVuZXNhcyBSRzNNeHhCMTJBMSBJM0MgSFVCIGRyaXZlcg0KDQpIaSBT
dGV2ZW4sDQoNCj4gUkczTXh4QjEyQTEgSTNDIEhVQiBpcyBzbWFydCBkZXZpY2Ugd2hpY2ggcHJv
dmlkZSBtdWx0aXBsZQ0KPiBmdW5jdGlvbmFsaXR5Og0KPiAqIEVuYWJsaW5nIHZvbHRhZ2UgY29t
cGF0aWJpbGl0eSBhY3Jvc3MgSTNDIENvbnRyb2xsZXIgYW5kIFRhcmdldCANCj4gRGV2aWNlLg0K
PiAqIEVuYWJsaW5nIHZvbHRhZ2UgY29tcGF0aWJpbGl0eSBhY3Jvc3MgSTNDIENvbnRyb2xsZXIg
YW5kIFRhcmdldCANCj4gZGV2aWNlcy4NCj4gKiBCdXMgY2FwYWNpdGFuY2UgaXNvbGF0aW9uLg0K
PiAqIEFkZHJlc3MgY29uZmxpY3QgaXNvbGF0aW9uLg0KPiAqIEkzQyBwb3J0IGV4cGFuc2lvbi4N
Cj4gKiBUd28gY29udHJvbGxlcnMgaW4gYSBzaW5nbGUgSTNDIGJ1cy4NCj4gKiBJM0MgYW5kIFNN
QnVzIGRldmljZSBjb21wYXRpYmlsaXR5Lg0KPiAqIEdQSU8gZXhwYW5zaW9uLg0KDQpEbyB5b3Ug
cGxhbiBhbnkgbW9yZSB3b3JrIG9uIHRoaXMgZHJpdmVyPyBJdCB3b3VsZCBiZSBncmVhdCB0byBo
YXZlIHRoaXMgaW5jbHVkZWQgdXBzdHJlYW0sIGJ1dCBsb29rcyBsaWtlIHRoZXJlJ3MgYSBmYWly
bHkgbGFyZ2UgYW1vdW50IG9mIHdvcmsgcmVxdWlyZWQgdG8gZ2V0IHRvIHRoYXQgcG9pbnQsIHBh
cnRpY3VsYXJseSBpbiByZWdhcmRzIHRvIHVzaW5nIGV4aXN0aW5nIGtlcm5lbCBpbmZyYXN0cnVj
dHVyZSB0byBzdXBwb3J0IHRoZSBkZXZpY2UgZnVuY3Rpb25zLg0KDQpBbnl0aGluZyBJIGNhbiBk
byB0byBoZWxwIHRoZXJlPyBXb3VsZCBhIChmdXJ0aGVyKSByZXZpZXcgb24gdGhpcyBzZXJpZXMg
YmUgdXNlZnVsPw0KDQpDaGVlcnMsDQoNCg0KSmVyZW15DQo=

