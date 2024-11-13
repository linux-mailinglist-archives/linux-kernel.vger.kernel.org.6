Return-Path: <linux-kernel+bounces-407310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB62B9C6BA3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD942845AE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C841F80BD;
	Wed, 13 Nov 2024 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="qLOc4sgH"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2117.outbound.protection.outlook.com [40.107.21.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE49178CC8;
	Wed, 13 Nov 2024 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731490871; cv=fail; b=CBmekaux4FBPTDamlcaAnD9xjZmtd16kycO+kHeZWp6We4zmrumkpPG783V6qTQ8NT3SC3UzTzEtJIEZH4mv4HTmU6LFQoWVhH2T/GqsTRz/2uRB3/RQasZE0D83tGnFF3ltXdZXUiAyrUAj93d7ggpouGu6tZdalJil/vh4/q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731490871; c=relaxed/simple;
	bh=dH4NPdSLmO0RKFLI7wda1Hjq/5269gBCNl16KCuitGg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=glGvkPDR2U+IZPVMdlm7F0c8iCYfZdS+WPpeEEm8xzZ4O5NEs4tmjE2M7tSeKz5Fqo3KqFW4tIm6Ig1AFpHsN3s4zYm/abJBrpvM9mvi+INHr81JX2eWAzDhmMkWRLy/G12eTjxNnxo2Mmpj1JJnmSeXFrOHImKtVrkipo4sXbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=qLOc4sgH; arc=fail smtp.client-ip=40.107.21.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNNeEkhpTHiPcJeg24xC+jBoOOQl5MljumD8BXcuJL9690MLjyvPWSOCVfH1ydTlO18mZfFG74mKHEBvkIwX9MsinWEk9Rj3tsxm+4ju3KXGaGaK8GUoeNosN+BcP9S6WH8mhu7r9IJ3BCn5A5z24BBJH0ilildXO16GO3ZjTm86xyQ9jHpm1zF6pfqH/Wanc7dP/YykIrbP5KZQn4pdcTAuZBsFkaEnLIIRhxYPxvHKnvq1Uko1pBwjVycAnFrfkZPK17NgYcKJSJeEdtKDqRO2LyHi/0VvnVYbl5MixT2N757wG6QfzIluZG+0nRmwAYGmkbLHAaRUdq/+t3MrwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dH4NPdSLmO0RKFLI7wda1Hjq/5269gBCNl16KCuitGg=;
 b=fdr0iaJotTpo1+WQLTPDfDrorf2nrHSIECWxU8A9lWUaOpqNznEcTPdXMjNCKH84alpNCRsHs14fqQG7261KZxnFz6DMYARwurrGe0VqpSHEykh96+1OmpL0jMck9y9C9R8cPt2sUIWqKJNDYLsVuh+pMID8RBmMC7itRFNn3pCA7FXLyvInYUK+166HKUkeNwmpkwULQvAAuUIckXQx+Sy9Tg9CTViCpeXIapamAO+FKRNb7RjlFNtRLoGwlR/rMOm9k711DLSopFIUbhp/KXBOSkVWwtEFELoqBLmetOWgXb8GgktAmaGcQhDmtzo+NVZK0cTS6B/d//30XjyPgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dH4NPdSLmO0RKFLI7wda1Hjq/5269gBCNl16KCuitGg=;
 b=qLOc4sgHMiAqAVukEazarvl7x7aec/NLAsBsOQtATweRJTmEs1LDTxb9j8aPNyuA40ai9AbAgdMNXce2hv70IxvjuowyX2+MQS5iA7NxcOzqHmol4ehQ5ba+12qHQLhACWRdI7z9qZV9S4pdE32V8Lr39E/eOEIRNemRCUNsdBc=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PAXPR04MB8605.eurprd04.prod.outlook.com (2603:10a6:102:218::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 09:41:06 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%4]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 09:41:05 +0000
From: Josua Mayer <josua@solid-run.com>
To: Rob Herring <robh@kernel.org>
CC: Saravana Kannan <saravanak@google.com>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Jon Nettleton <jon@solid-run.com>, Yazan Shhady
	<yazan.shhady@solid-run.com>, Rabeeh Khoury <rabeeh@solid-run.com>
Subject: Re: [PATCH 0/2] of: add support for value "false" to
 of_property_read_bool
Thread-Topic: [PATCH 0/2] of: add support for value "false" to
 of_property_read_bool
Thread-Index: AQHbNM31DAG0MrQIm0yI7cftJ+pYQ7KzqNmAgAFN3IA=
Date: Wed, 13 Nov 2024 09:41:05 +0000
Message-ID: <288deac4-5387-4492-9e9c-cabf77b9c0ba@solid-run.com>
References: <20241112-am64-overlay-bool-v1-0-b9d1faff444e@solid-run.com>
 <CAL_JsqJAQswTo2eWxLw62wqb-2i=_9W84_v_tW+TSW4kgNK3_A@mail.gmail.com>
In-Reply-To:
 <CAL_JsqJAQswTo2eWxLw62wqb-2i=_9W84_v_tW+TSW4kgNK3_A@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|PAXPR04MB8605:EE_
x-ms-office365-filtering-correlation-id: 9258753a-d099-4dac-a613-08dd03c74b96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dVBCMUd2cDJtb202bTh6T3N6RzJCTXFuNDMvKzVpdVNDUmZMZVdMbGM2T3hn?=
 =?utf-8?B?NHRUeVhUNkI2em9nSXh2d1Q3b25lc1FGdjBLdDNZVXBVclhMaXlOSXNkeXR4?=
 =?utf-8?B?NVEyNFpZZVEyK3UyTkNINGdmTFdXb3NJa1BOZ1k5cGlsdnhxbTk0SjVsZG51?=
 =?utf-8?B?SFpWMXNRZ2tlaWxTR0V6aTBkUUhUUEI4U1R0RFBVV1BwZWtkakMvd1BzSEww?=
 =?utf-8?B?V3lQWTE4ZklHVFdZT0tFN2VrT0d0VUhULzAvVTJtazFrVG9KOFRwRkdGYWh4?=
 =?utf-8?B?NkFta21KNzdrblRvVHhONVRvMy9ad0pNeDk0Qy8zamtRcTRFN1lMQVN4WEJU?=
 =?utf-8?B?aHpndURzWUpVMFNxVjEzSVpCOTh4Rml0QWpFbVhiTlpxYjZqVURZS1I1Lytv?=
 =?utf-8?B?dDduYzFIVTFubC9PZGsyTUFlaTJZTmZiUnBObXdsVWlrUDdybG04czcvajN5?=
 =?utf-8?B?OXdreGQzSXdVTk9pKzZYckVkRzVuU25FRE9qSTdtSUN1U1NWbU5zdVVUNjFF?=
 =?utf-8?B?WTVKb1RFcHpuVGN4b1RCTmhtQm5JaURoYzBDYjZFTUR6aUZqWDdiVVIxcDJB?=
 =?utf-8?B?TWg4NkhSdWorVktFWkNMMWg5dVVoYzdUMjZtV3VEK0lmdE1iQURWR0pxbXBH?=
 =?utf-8?B?QVBEaEJ2eHJvQXVVMXUrckRnOVVzLzlkZzlzNDNZK1Q2THJJQzluT3ZyZ2Zn?=
 =?utf-8?B?ZVQzT3NsZHBJZlBiZ3VjdTdoMlBzNW1PUzFQU1ZaOGY2a29QSWtBMHdXdlJT?=
 =?utf-8?B?b0NCRlF3T2FlNFY3QnExbnI4WkRQVDhvVkgzMmJQblVQVFU4dlc1SGFHcVVu?=
 =?utf-8?B?cGtzS0J6K1YycWhudDVvRXRRbWRwQ1Y2YzlIc3ZzbzhmVTNwaXphMEtsVDhJ?=
 =?utf-8?B?SGhYU0dEL0pUdlNuQkNTWEExYjJnQUFMY3RubnArNENxZFJtajJTeFR2TVh6?=
 =?utf-8?B?Sm1DbURvUyt2QTBReHZBR3A0RkdPQXRhQkV6LzYzZnkrbEtzY0ZxZHdxNmlj?=
 =?utf-8?B?bENOTG9ncUROblhIZmM0RmFmMnFPRlJwVFd0NzJuQnJZQ0lYdjRGdnVmNHp2?=
 =?utf-8?B?WHJkOTUzMjV3b0krYVFwazk1WndvcThGQVVQRkcxVGlVVWNNNWQyY214SzFj?=
 =?utf-8?B?cjNPY3MyT3BHV0lGbUkyWkVBT3ZDa2VmbU0wdEFaQVFnelhIWjhUTzM2VFNm?=
 =?utf-8?B?aGl0MnJtMUFMRmlMWXYvVEMydTUvWFo4ZERCbmFKeVl3QmVXeEdWSUhQTVg0?=
 =?utf-8?B?TStxd09pSFdPTEVsYUtuaGhEckdMZFlvMFV0YTBHVzFjT2s2eWhDaE1tenFJ?=
 =?utf-8?B?QitmY2Z6YkFubkt4N25TR0pxaXh0RFVjdExyWE5qdG5VZlRjbG9EbHh6cHdX?=
 =?utf-8?B?MW9qZkRObnV1amlxVUtLRmpUUkhNMFBwZWt6VDRPcTF0NmFWMEc2eUdMR1Ex?=
 =?utf-8?B?Y2pJRTVuaTFNYzU0N3J1aXM2VUtpZEpVN3hQc250UDdnM2NXMStldzFDUUc3?=
 =?utf-8?B?MHM4REJMQ2FhRENjM09mWlIwdlVlWEcxRWNLUXRoVGdwQUxOb29IR2JCMWZN?=
 =?utf-8?B?Vm9iSXFxTTdiRWNybkZaSkVqK1lpckpPYVJhenVudzRXYnBYSEJEdDJIRk1x?=
 =?utf-8?B?bXVmU2VJbHNQaVQ3U3VYSnhlZmVzY3orMmFldG5rL2VmUHMzY2RLNzh2dGk5?=
 =?utf-8?B?Wmo4UEM3ZEZyZytIY0wzNXErVHlkaWpqZWxjYlJ3VUEySkMzT1dxb3JFRHVX?=
 =?utf-8?B?UEw2K2F3U2lxb2txMHBjdTdLSDVFWGVJQXZwUVF2RWZUdGZwOXJYRDlGK3BP?=
 =?utf-8?Q?s7+kWM0dHeQrpBUybW55Ze4b1GUPj5gFBBqVA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXNzUFA2cTM3ZUJzS1pNQXIvNTU5ck9KOEg4WmVkMWRKYnRuVEVBWGRXa1By?=
 =?utf-8?B?Yzl6SUJGVGc1Um9SNFI0MWZJOUJpT0U1Q1pFei94d2tIL3BHWitrenVwSERF?=
 =?utf-8?B?Ui9QbHdUSWpJby9QM2E5WkljbjcxV0hrWDhJUklYUkw1YTBhZlkyeDlQK0dJ?=
 =?utf-8?B?OVJ5Y2MwWUlHQ0RYcUplNmNPdnRrRzFCWTlFdS84YmFuTUJmTi9GT2pLKzZi?=
 =?utf-8?B?aHhWYm80RkkwdzkvZWdpRUZmUDJjOWVpTTVlQmpLeTcybklsSlBrdXY2dVEr?=
 =?utf-8?B?Q1BOdE0wbFU5TzBjcmNHM1lSNkE1WDRTOXFaOXhjbW5lRGhqcHVZYzZIVk1Z?=
 =?utf-8?B?aTdZUWNVc2JQeDJ4NUplK0pXTmc2QU8yZFYzNEYwdXZUMTFSMVFVa3B0U0RT?=
 =?utf-8?B?NjBsdnREY1MweWN6azFFcVZZK1dhdlBiRit4UGg3ZVRhOVlpa1paK3B4ZTU0?=
 =?utf-8?B?Q2d1bDVHNVduc0FJdFBOMlcxTXdqKytkUHhYemdhOGdINHAxNml5Q3dWaE1E?=
 =?utf-8?B?WmdYKzdkL3FFQ3dLZDZZbk04YTNzVWxHMzVyK3M5VmNNZkQ4SnVuWmdUK3Jt?=
 =?utf-8?B?OEtkZmJlczhCM2Q0VXB6c3p5UEhFMEI5M0Z5QkUxSTZpc1k3QUlEcFZoendI?=
 =?utf-8?B?SHNVSzE1L3liY0hnTzdQbGpLU3BXNlh3V0VtUnBUQWYyaCt5aWR3NFo1dXRG?=
 =?utf-8?B?NGpMbThCQThEN0JOTTNiT0RGUHMxREJrd1VBa3lZeVlRbXJEUXVsSzNaakxY?=
 =?utf-8?B?YXNaNVppQmNUM1psdEo3UFpCdWVzMjdFcXIzV1dNZzdtVFZJSHB2eGZnbUh3?=
 =?utf-8?B?WmZWVDdpNWRuRmYyVjVRa0NBWHR1a3ZGSEhOZnBRclpqRk9Ta2U2RXZSWVJG?=
 =?utf-8?B?Q09WRVBUZThhMVpIa0VpM1o2Qjg5VVJobnJJOFRmK1RYbFZzNWh1SXZ3eEls?=
 =?utf-8?B?UExwb3JZakRYL09GKzlMeHkrQjRlbFdCZXhNSU11ZU8yd0RZNHBaQ1VocXRZ?=
 =?utf-8?B?NUFHRFhEanJNZk9VSVdwU1N1WEYydkwveDlYQ3owbXZrS0hJNGJ3Y0J3NHlY?=
 =?utf-8?B?K3l1cGxmOXRIbjZubkZZUWRmTHBqbUxhL210VnAwUXEzdUdrS2JPSDIzLzhl?=
 =?utf-8?B?ZStCZTB1RGJKc3RpQS9PcUFwSlMvRnkrZElPUVhCS2IrelMvSU1iL0MwYTBX?=
 =?utf-8?B?blVZbGlxWUc5bmFVM3FhbkRwaFZsWkJwbFNCTGpLdlZYSWovL0ptdWhpM0lL?=
 =?utf-8?B?Y1Q3WTdSQ0VoWnRzYy9XSHVkY25sUndsOHd0RHd3Z0NtN0VUUHNjYzQ3ZjV0?=
 =?utf-8?B?eDQySkZUL3hBT0pBQ2tqK0IwOVVjZlNIRGlaQ3V4ZlREWm8zZ2hraUU4M0Jq?=
 =?utf-8?B?bVp6VFcwQzczUDJmeDJMdHpERzJWSXBKTXlOV1U2MU1YbWdXbVBDSTdqeGJU?=
 =?utf-8?B?VldKekNQcFZFeGNkVEdOTjZ2ZCtWNlhnV3dIZ1JVMFZ2Ty81NUIzWVZUZHla?=
 =?utf-8?B?bldIS1Y3YUc4cnBBQ1VoeCt0Z2xZTldRNG00enhJd0FCdVNCYXZIVkJzYlpJ?=
 =?utf-8?B?RlBxMzNsaVA1WXNLaUxuNE1xQlZLemYrY01NQjdCK3BDQU04ZmEvTDR6OU41?=
 =?utf-8?B?WmRSanFsR3lsV3l5emVaQnhoNGk5WTErbS83T3FVbHVuNWRMajRLRmRjZDM3?=
 =?utf-8?B?UG1ibVVNdkRSYkE5LzJia2dGTDcxS2dXbFZrSDBjUGQ1QUt3NkdobTZZZ3E1?=
 =?utf-8?B?LzBORkVFSDd2bCtyQzVCT1ozQi9nZzQyditNNi9wQXcrcGlmN1hRUTFoUzll?=
 =?utf-8?B?b05pRDZ0SjJmQmJDY1d3bmNUamNMZHZlUGJHR3l6R0NWaDdmaE96U2pRSmxH?=
 =?utf-8?B?M0h0djhYUUVMZ3RNK1ZHR3Q0UXNJbEVOQUhpWVF3c1JySFpnMlRIS05La0pC?=
 =?utf-8?B?d0lZTVZxRXlhK2lYcitieTY2eVk2OGpFVGlaTHc0TkZCcEdDdWRidkJIVWVr?=
 =?utf-8?B?bTMwbTFNL09LUGc0bjYvZUc0TDAxWWszQnlqM0E4UUpOcVdVUmZ1bGNFRy91?=
 =?utf-8?B?S1BiOGd3NWYyVXFGekNIQzViN0pqN0FobWZpc3RrZ05QZy85WnFrVVBwdVd4?=
 =?utf-8?B?cldnMjV5YjRaT1hCV3IwbDQ5UmE3VDg2UVNFaVU5Rlp3aThJSmg0WE5oVlFo?=
 =?utf-8?Q?aRw+ZTKUsf1LHxm7e23cdac=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37D40E1E8EB16243B8B1DC9B03F755E1@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9258753a-d099-4dac-a613-08dd03c74b96
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 09:41:05.7513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JrUCFoyAkn7Cnwj9YR+TcEHWJ/SPM/z43PX4ykHUTA2uEjSJsAm2FwYbFmhUnAhXnHs5gq2MnTXOyMihFuBTfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8605

QW0gMTIuMTEuMjQgdW0gMTQ6NDYgc2NocmllYiBSb2IgSGVycmluZzoNCj4gT24gVHVlLCBOb3Yg
MTIsIDIwMjQgYXQgMTI6NDHigK9BTSBKb3N1YSBNYXllciA8am9zdWFAc29saWQtcnVuLmNvbT4g
d3JvdGU6DQo+PiBCb29sZWFuIHR5cGUgcHJvcGVydGllcyBhcmUgdXN1YWxseSBjb25zaWRlcmVk
IHRydWUgaWYgcHJlc2VudCBhbmQgZmFsc2UNCj4+IHdoZW4gdGhleSBkbyBub3QgZXhpc3QuIFRo
aXMgd29ya3Mgd2VsbCBmb3IgbWFueSBpbi10cmVlIGJvYXJkIGR0cyBhbmQNCj4+IGV4aXN0aW5n
IGRyaXZlcnMuDQo+Pg0KPj4gV2hlbiB1c2VycyBuZWVkIHRvIG92ZXJycmlkZSBib29sZWFuIHZh
bHVlcyBmcm9tIGluY2x1ZGVkIGR0cywNCj4+IC9kZWxldGUtcHJvcGVydHkvIGlzIHJlY29tbWVu
ZC4gVGhpcyBob3dldmVyIGRvZXMgbm90IHdvcmsgaW4gb3ZlcmxheXMNCj4+IChhZGRvbnMpLg0K
PiBBcyBzb29uIGFzIHNvbWVvbmUgbmVlZHMgdG8gZGVsZXRlIGEgbm9uLWJvb2xlYW4gcHJvcGVy
dHksIHdlJ3JlIGJhY2sNCj4gdG8gdGhlIHNhbWUgcHJvYmxlbS4NCg0KUHJvcGVydGllcyBjYW4g
YmUgcmVhc3NpZ25lZCBhbnkgdmFsdWUsIGUuZy4gYSBkcml2ZXIgZGVmYXVsdCBpZiBuZWVkZWQu
DQpJdCBzaG91bGQgbmV2ZXIgYmUgbmVjZXNzYXJ5IHRvIGRlbGV0ZSBhIHByb3BlcnR5LA0Kc2lu
Y2UgYSBzdWl0YWJsZSB2YWx1ZSBtYXkgYmUgc3BlY2lmaWVkIGluc3RlYWQuDQoNCkJvb2xlYW5z
IGhhdmUgdHdvIHZhbGlkIHZhbHVlcywgdHJ1ZSBhbmQgZmFsc2UsDQpidXQgc29tZWhvdyB3ZSBj
YW5ub3QgYXNzaWduIGZhbHNlLCB3ZSBjYW4ganVzdCBkZWxldGUgdGhlIHByb3BlcnR5Lg0KDQo+
IElmIHlvdSB3YW50IHRvIGZpeCBpdCwgeW91IG5lZWQgdG8gZml4IGl0IGZvciBhbnkNCj4gcHJv
cGVydHkuDQovZGVsZXRlLXByb3BlcnR5LyBpcyBhIGxhbmd1YWdlIGtleXdvcmQgdXNlZCBkdXJp
bmcgY29tcGlsYXRpb24uDQpXaGVuIGluc3BlY3RpbmcgYSAuZHRibyBubyB0cmFjZSBvZiAvZGVs
ZXRlLXByb3BlcnR5LyBpcyBsZWZ0Lg0KDQpIZW5jZSB3ZSBjYW4ndCAiZml4IiBkZWxldGluZyBw
cm9wZXJ0aWVzIHRocm91Z2ggb3ZlcmxheXMuDQpXZSBjYW4gb25seSAiZml4IiAocmUtKWFzc2ln
bmluZyBmYWxzZSB0byBhIGJvb2xlYW4gcHJvcGVydHkuDQoNCj4NCj4NCj4+IEdlZXJ0IHBvaW50
ZWQgb3V0IFsxXSB0aGF0IHRoZXJlIGFyZSBzZXZlcmFsIGludml0YXRpb25zIGZvciB1c2luZw0K
Pj4gc3RyaW5ncyAidHJ1ZSIgYW5kICJmYWxzZSIgb24gYm9vbGVhbiBwcm9wZXJ0aWVzOiBbMV0s
IFsyXSwgWzNdLg0KPiBUaGVyZSdzIGFsd2F5cyBiYWQgZXhhbXBsZXMuLi4NCj4NCj4+IEFkZCBz
dXBwb3J0IGZvciBhIHN0cmluZyB2YWx1ZSAiZmFsc2UiIHRvIGJlIGNvbnNpZGVyZWQgZmFsc2Ug
b24gYm9vbGVhbg0KPj4gcHJvcGVydGllcyBieSBjaGFuZ2luZyBvZl9wcm9wZXJ0eV9yZWFkX2Jv
b2wgaW1wbGVtZW50YXRpb24uDQo+IEFueSBleGlzdGluZyBzL3cgd2lsbCB0cmVhdCAnZm9vID0g
ImZhbHNlIicgYXMgdHJ1ZS4gSXQncyBhbiBBQkkuDQpJIHdhcyByZWFkaW5nIHRocm91Z2ggdGhl
IGRldmljZS10cmVlIHNwZWNpZmljYXRpb24sIGl0IG1ha2VzIGFic29sdXRlbHkNCm5vIG1lbnRp
b24gb2YgYSBib29sZWFuIHR5cGUuDQoNCkkgYmVsaWV2ZSBvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wg
c2hvdWxkIGJlIGNhcGFibGUgb2YgZGVyaXZpbmcgZmFsc2UNCmZyb20gYSBwcmVzZW50IHByb3Bl
cnR5Lg0KDQpXaGF0IGlzIHVwIHRvIG5vdyBjYWxsZWQgYm9vbCBpbiB0aGUga2VybmVsIC8gZGV2
aWNlLXRyZWUsDQppcyBhY3R1YWxseSBvZl9wcm9wZXJ0eV9wcmVzZW50LCBvciBjb252ZXJzYXRp
b25hbGx5IG9mX25vZGVfaGFzX2ZsYWcuDQoNCg0Kc2luY2VyZWx5DQpKb3N1YSBNYXllcg0KDQoN
Cg==

