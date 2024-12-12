Return-Path: <linux-kernel+bounces-442618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE51E9EDF74
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 07:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAE692830B5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 06:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A091E04BD;
	Thu, 12 Dec 2024 06:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Jx79LySm"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBD718B467;
	Thu, 12 Dec 2024 06:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733984949; cv=fail; b=DFhexAGcp9EOaNr9BofdruNDEaPiYcuZ2MqrDu7raQaZTg5znrhmNLad5eQjHMIOThs2cHCtvCqKBi913oVRd7tpyZUfatC7KfGzQzFtGwYU/NuRZXwkxqoyZxMkXeodG+H2iP6iUuAR9sDS0iK8W8yD7LDgRHukSiOjXRi3Vsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733984949; c=relaxed/simple;
	bh=5aj0l071mJLBVyFKPSI4zyqOktLwc33QzWxI748Juco=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hy8CKvhjC5OqFSj+9k4hr3RDeY/br+0Fq2R5TUfizLOJ23IOXsg+B9HvciPtQbMBjaaOxlS2U7ccnbn8fWwoiqxXAv+K2FMsHNi5OovIu3pb7Dd0joneVsXE6Aq9tfBhk08et73UAMBFNhWssYx10FDkaFrKykjxFYqjI4COmKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Jx79LySm; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlIfZ09fRF6Ame5FAb0dPULeXfUkvStciHfjunWDA5knV0olY0uIO6/mqQ+GxT5i6jTvHN8EEHY39wnfSly1xtH8PIQvqlgB/HIZfIaJS5wPyrB0foLkb2aQ2MhfCbLOGWoDzfZXbIBjaKuIWQ7jmG3TR0MKKqlvtg/2QdNm78g3I4n1EcTdOc8I7iH0KrOTmBzbgjl3Dvczrcg7jQh7iIpIC/syD91AQEqnky7qHaOYhMfosriSGgWn5iNPLsMs5gJCM8SXjjrqqquaLacaOu3MzGcKGYekra4W2KSDRj9VRV6BvOmDqnYmIU6CpNEkUUi5STPDqQxTS4atioVDrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aj0l071mJLBVyFKPSI4zyqOktLwc33QzWxI748Juco=;
 b=zKKihMSefSKsz7lO2OqG80zhiwBoRmgAe6oHpl6KPchSB73QBzowdmur8NQ3qkW+AovVuMsI0x+G+zHObopCGDFXkipps19EI8D07i8J8w98iFxT5hy2RbDkbajFa+B6AfFCR2LgyuqJRDLPFobX5Qfh59d0O4a2eUYh0L4cRGCEb0C/XY0HxBg0rbQdI/zg5PZiRoagbKcvS4ceZECk2Ij2QLEZWIZ5eVNWstD0Z71TOfZvh0ZeAOQj8hZjFk21IVgXJEYzo0GJm1pzc5V0gz6h08G8E/OsjUMOFBIWK1L6GPbhjaXgS5QUI8I8BQt2VoJEmWCAfgJOwBqJ/5w8ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aj0l071mJLBVyFKPSI4zyqOktLwc33QzWxI748Juco=;
 b=Jx79LySmoDkiVZpAPhAefOB+HcFXTmQcRxSkF0sl567u5/ZnWma5VVe73QNMkhgCnTejMgD1L3Rwjn/pkjkrV93jzE8UfNoSGfR7yBH2Bt6nPXiJZSqrAjpL02Z7kS5MXybBy+el3Z7sURzHK9Py9Pe15tR3d0F1cyNiF/SnUkkBkjZ/Ai9JxscKSzIhQsz8WzKbjpwvGK9D5wKl01c9MvlpQCRmVHVBaRJGM4GRncNY4mzBkZZnR2Wds4iORNsCo6gPPfMz7Q4OLUgjYZvwWjFiW5eGA+1ui4ifySSpGt1lhzIw20kQuVtnOcL/q7RCNCJnoREUk49ilQ7OHOgvEQ==
Received: from CH3PR11MB8187.namprd11.prod.outlook.com (2603:10b6:610:160::18)
 by PH7PR11MB8058.namprd11.prod.outlook.com (2603:10b6:510:24d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.22; Thu, 12 Dec
 2024 06:29:02 +0000
Received: from CH3PR11MB8187.namprd11.prod.outlook.com
 ([fe80::9c7b:9ccd:4c55:c6b8]) by CH3PR11MB8187.namprd11.prod.outlook.com
 ([fe80::9c7b:9ccd:4c55:c6b8%4]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 06:29:02 +0000
From: <Balakrishnan.S@microchip.com>
To: <krzk@kernel.org>, <claudiu.beznea@tuxon.dev>,
	<Andrei.Simion@microchip.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC: <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ASoC: dt-bindings: sound: atmel-at91sam9g20ek: convert
 to json-schema
Thread-Topic: [PATCH v2] ASoC: dt-bindings: sound: atmel-at91sam9g20ek:
 convert to json-schema
Thread-Index: AQHbS7I0Qjr7X3ZS70GOEHmfmWHjWLLg6GCAgAE+f4A=
Date: Thu, 12 Dec 2024 06:29:02 +0000
Message-ID: <d26a9ea9-d6bc-460f-8c56-ef025459484a@microchip.com>
References:
 <20241211-sound-atmel-at91sam9g20ek-v2-1-86a0e31e6af9@microchip.com>
 <0358a6ac-4037-444b-8e65-4e5afa29e8c3@kernel.org>
In-Reply-To: <0358a6ac-4037-444b-8e65-4e5afa29e8c3@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8187:EE_|PH7PR11MB8058:EE_
x-ms-office365-filtering-correlation-id: 553fe445-d175-48be-b394-08dd1a764502
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8187.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?NnV3N25XTVFSSlcrMUxVVDZldzZGQ3RnSGV3VjBCeE9KcnJraWdlYy9PdW9E?=
 =?utf-8?B?V2VYaGJaTHBCTW1QMkdXUUU5U0RpWGowTHlxNlFETTVEMElHZENUSXIrTVlH?=
 =?utf-8?B?VlBuNlRXVnJVR0dBNTF3blVvdFJ2bG9CMFVqWlVpSnJvMnlZT3grN0xxVzdC?=
 =?utf-8?B?YjFqemtMWWZPdm5PR3VFZUttUnVSRlZiYklXVDM3ZDdLVm1oYTBMTFVYN0tv?=
 =?utf-8?B?Q1dpYUg2RjJYRlpUSEYyM0ZPQytQbEZqMGhXWnh5YlRsSGxhS3FjenZyWWpQ?=
 =?utf-8?B?ZlF4R2FsMXExcFduVUNsdUI5TkY0dU9LOHFadFB2UWFocXpXL2xYNmJOT2cx?=
 =?utf-8?B?blVuS1pRVmFSUk9qNWxjaytpcDBZVk5XS3lxbVMvcXVNWVZaeS82Z2NVSU8r?=
 =?utf-8?B?TDEyTmNhazdhMk1ZTmU3Rkpyd3Y0bVYrVjJwRGZBNHVlL2tLY0pZNTlhTU1R?=
 =?utf-8?B?OVFjT29BT0lqRjlzeDdWZjY3YlBGcjlNMDhuaE12aWptNE1ORG1NLzBwU2dX?=
 =?utf-8?B?RXBUOFhxTXczUUJrR3JpM1JJeGJ1eXIvSml5NGMvclNTQ1ZOSWRaelptek50?=
 =?utf-8?B?a09ucXpsd2JhdzMyVjdWMVJFd01SNjlsWExjM294WUc0cnVOSGtqWlVUNzVp?=
 =?utf-8?B?RmdUSGs2aFdjWWszSVh1bFBDbVhXYXRnSEJkTXAxb0JsYUxZUGZUL1BDK1Zs?=
 =?utf-8?B?QTg2QkhYZk1XcjE0YWRnL2gyRXVsVjM3Q3g5Q0NNSGJ5c1FobWZ1M2hrMG1B?=
 =?utf-8?B?ajdVbWRNSkJmOFEvN3RpcHoxNlpCQlpKZTgxVXlvWVQzZW1LaGNiNXBzS2lM?=
 =?utf-8?B?L0R2bGtsc0R5d0g5L0l5eEhPVHNvT1Y3Vmg4QnpXWnoxOCtVNDBES0k4Ulc0?=
 =?utf-8?B?aEhZZzVXRFUwdEVkWFlJWWR0NjA4Rzh1V2J3SVBuR2dvdVhqeTBTVG1zeUI1?=
 =?utf-8?B?eHhYckFaNzlXWHBma0pubmdGVVIyY2oreDVPTk1wLzcwMzVnTUxBK2hTSHJY?=
 =?utf-8?B?T1dQQmIvKzRkTElDZkdVUjd1YjN0ZXpDcy9JSXM3T2RtQTJYZC9qZEthNWRW?=
 =?utf-8?B?bERxM09SVE5BalJoRjB4VHpVd0ZVc2FhdFdXU3VRby9vRDExZlgxYVdoc3JY?=
 =?utf-8?B?N3cxUHRHOFZmajhlUWtGZGpYMFVITDhiU2FkeFlqcWpKRWJoNHkxRnYrajRD?=
 =?utf-8?B?b2hZbUU2enB5eS9Qa2ZUWmtkVDA5aSt3dVpSUWZxYWdYMHVLa1YrNWNJNUJO?=
 =?utf-8?B?TS9sc3FYSjE3b3VkajFkK1c1c2hHN1R3SWoxUjBSRUZJQVpOUnUwMVl2bUhQ?=
 =?utf-8?B?RndOeUt4bTd1UmMzT3JvZTRubG5zOFBVUDFoL2k0R25sT3QwVzJUMG5oZGxm?=
 =?utf-8?B?T041OXUzZFdPbityM2s0SWFtTmRiZ2xxSmg1Q0FGQzYvTnJKMHh0dFpWa3VV?=
 =?utf-8?B?L01YbytwUkVpQWpSOHBza1F1Z0V3UWt4RDFyVW1tWnRDd3FQRzlQRkRKY1lC?=
 =?utf-8?B?b3U3YmFmZ0o5NmZuYzJVSzRYaUlFRERhQmRuSGN3UHI4WEFiaEcrczdpeXVl?=
 =?utf-8?B?cGZlVVhqWjZNS3lkbXFVR3BWMnJvQWhGQmlURFBOUDY3eXNvWUV4SEhac2VO?=
 =?utf-8?B?YVJ3aHZuTnhjTVU3SUxlbE5oTGpPN056NDJRblc1NzkrdDR2OHk2QWxjaDB1?=
 =?utf-8?B?N0kvNmlCQmxucWRWVWZMZ0E3YWhpaXNvM3ZsYkRGK2xVUlFwb0pCY2xwc2sz?=
 =?utf-8?B?dUpXODRPbG9NR2hKTERUdmVwa2wycldGQ0ZjYTE1WjdmRExtd2w2b2NFR0Q2?=
 =?utf-8?B?L0ozUGYrUlpUOHlzS3RrdlRHVk9DWDZ3ejBaaDJmSmJxWWhvY0ZpMUhGTzdQ?=
 =?utf-8?B?ZWU3bHV3Q2RRTmR3SjlaVkFVR3VPcEZhYXRFWGluUGF2Rlc3cUZqWVpVWjJH?=
 =?utf-8?Q?MGy3/Nyo/Mo=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1VQR3drVHVpWDZuRTA3ZVpORU5vVk1TK3VTQzhCODBVK0ZBMUJEdE43SFlL?=
 =?utf-8?B?OWJFemt6aVJOc1pBdzFYdEV5RlFoaFBGMkl0MW1KTU1Xa2JsMmZySGZyVWVu?=
 =?utf-8?B?M0E5L2VISS93aTU4MEVVZWwySlo5cnAwWjV6c2JpbzJDRkdzeVorUkE3amND?=
 =?utf-8?B?L1gweVZaTjMwa3BkOVNWWmI5VVN4R2ZLazg3RnpIeVRQanVSb3M1UkVYK2hu?=
 =?utf-8?B?UExZWjF2VmtiamU1MDFrbk1USW12bkJEK2wybnR4eStRM2NYb091aXVQZDVL?=
 =?utf-8?B?MEFMWE52ekQ2eXkrSFFza1pZMFBlYW9IRTkrMm0wUGg3OWZXTERRb2QxYXFu?=
 =?utf-8?B?NWpKd1BXd3RLbUhrM3BZT2tnSUszMDFlWmN5cW40SHEzZjFKaVpCSng2cEpn?=
 =?utf-8?B?Z2JvMWsrWWROdlFjeTEySHV2bTZ5VHE2L1hVcXhXcXExN1JMQUxOOU9ObnJm?=
 =?utf-8?B?UnpqQzdTMXRjWktBdmhrdHZRVTlPVEZBZHBLeldsRkFQM29TYWVPR3BjbWFE?=
 =?utf-8?B?SWpIaDBnckRzNEY1Ty96REh0VVVRT2dvL0RVOWQzeWIvQzJUczBVbFhRbVBH?=
 =?utf-8?B?TlVVK1VNSW9pWW5HTDI5Q0g3aUxTYXROalNJZVIxV3d5Y1NacnNadURzbWlD?=
 =?utf-8?B?cmNlR3JNOGpaODVNWlZOTHJVVFg0RS95aGpLZkFSSEpDMlBPZHZydUNoS204?=
 =?utf-8?B?UDBKNlpFS2E0QjNOYlp3VHhuMFRmeTR0SjdFMVp6MFptamI3bmxaUmRaR3dV?=
 =?utf-8?B?NzN2QStIVkF1ZzBZNkV2ZjNNVVBKbS9WNnl5VndFT0FCWGtidUpOcDRkOTVR?=
 =?utf-8?B?STdkU1JJZXVsT1p0Ky9tcEFhRTkyVUx3YTBwUm9rUythRDZha3p1bEhSM3ZP?=
 =?utf-8?B?a0JRVG9sYlBCbDVaQ0EvTUpsQVRpRVZGU1VlL1F5MWpjOUVCelhHTWJKUFo3?=
 =?utf-8?B?WHVFaFVIWUdFc0hUS21nYVkrV0wyMUVqRWJPaEJOUGU2akhUSFkrcVlibWhu?=
 =?utf-8?B?WUkvZVRWTTR4NDlPejlnU2JwU3dJcWR6eE51T0VWWkh6MEVIY3hSNThrTGxy?=
 =?utf-8?B?TFpzbHhJVFZ5TTJNV0ZtaXQrNEFyWWgzc2ptT2RDS1VwcWZrTDRFc215ZWh4?=
 =?utf-8?B?S0VwWkxSQjdITmxMTFdURkpiLy9EV2NJNXptSGJUMHlCdnVrQWxRWWZmWEhC?=
 =?utf-8?B?VzdWOWNFL3BIRGVFMHNBd2FFWTV1bTNwSm5XaW00c09hU0tjSlgzaEt5Ykw1?=
 =?utf-8?B?NDdBSEFhcUtKcnRvVVViaVhYMjhEYlRWT1JrSmRwYTc2VmNvR2dzdWJ1R29B?=
 =?utf-8?B?OEd4eDVvZVg2ekE1WFJ4MHRGNUo1TG1jRkFBNER3Z0ZmcXd1UXlEM2FtYkFn?=
 =?utf-8?B?aFFhZGZxaGNkZC9lRmJKNjZ1UndqNW5oUXdnWFFXNmQ3NVJKYW8vTEl5ZFJ0?=
 =?utf-8?B?RDFrSmE3WFdjMWxQdEdJdElBWHo4YmdWOEVNamp4WTVROHMxYkc0a3pnZHRu?=
 =?utf-8?B?dndPNHpYYUtnYTJKYTVpUkd1b3RzUTV5VEJKZE4zcW8rRmFVWE9lejZGS0VG?=
 =?utf-8?B?cjBJY0dCendMZjdVUnVWdGZaYWw2eUpXK3djcmlSdXl4OFJENzV1akNlYmRL?=
 =?utf-8?B?ODhDL3pac3FJTGVpOVBsNUxDbHYvMmF0TW1LYndNS3pXbUNKQmVtcW5hT2xO?=
 =?utf-8?B?aHZBa3p2dWhzRFZwcU93ci9JL0pyWUovaHpKTnBOMVVRZURFV1lEajQvalpy?=
 =?utf-8?B?NWJMTVBwajZnUkVZaGkyYTUwL1pJeUl5T1lkOUR0R1czclY3OVJkcGVJTHBo?=
 =?utf-8?B?bFBkOW9MSTVnNEtod1k5TEVqZU10ZDFwTzRZQm42L1ZFa1JvWnNuYVZrRVI3?=
 =?utf-8?B?WGsyaG82KzZscm1XcjVUNDdzaVVKYk1RWGxaZnUxaG0wTjBuOVQxUlBsM1R6?=
 =?utf-8?B?d3BIYm11K3hHWmtzU2Y2aU11NWxKc2I1cDV4dFBiQUoxcXA5Q3BPRHhpcGxY?=
 =?utf-8?B?WnFSSHRHSk9NSmNFUUkrNEYyVy9QeSsxKzFSVGZDRG1wQ08ydm93cG9wS29i?=
 =?utf-8?B?Vk16UzZsZnhIbG5JYjZjQVRMT2xhUG5xaVRQVXlmRzFRVnFQaXhsSlJpVHlh?=
 =?utf-8?B?Y3FWWUVzNWRubGhkbVJWSzVqRFlBTmlhTHhYSTdZTDV4eW9na2NUYWVWRXNT?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CB6DAFC19C3C948A0B93FB673B6E01B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 553fe445-d175-48be-b394-08dd1a764502
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 06:29:02.2500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3gVAiFo6v3X9GhbLEBfn8dDe4uUBc61rXnTI77D6bJPQltUo14MWNN2mwmbx9g325Jd5bDeJLpnrXHgGIohgDByRBOYA+eQQ7VzrB2+QcjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8058

SGkgS3J6eXN6dG9mLA0KDQpPbiAxMS8xMi8yNCA0OjU5IHBtLCBLcnp5c3p0b2YgS296bG93c2tp
IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDEx
LzEyLzIwMjQgMTA6NDYsIEJhbGFrcmlzaG5hbiBTYW1iYXRoIHdyb3RlOg0KPj4gK3Byb3BlcnRp
ZXM6DQo+PiArICBjb21wYXRpYmxlOg0KPj4gKyAgICBjb25zdDogYXRtZWwsYXQ5MXNhbTlnMjBl
ay13bTg3MzEtYXVkaW8NCj4+ICsNCj4+ICsgIGF0bWVsLG1vZGVsOg0KPj4gKyAgICAkcmVmOiAv
c2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9zdHJpbmcNCj4+ICsgICAgZGVzY3JpcHRp
b246IFRoZSB1c2VyLXZpc2libGUgbmFtZSBvZiB0aGlzIHNvdW5kIGNvbXBsZXguDQo+PiArDQo+
PiArICBhdG1lbCxhdWRpby1yb3V0aW5nOg0KPj4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55
YW1sIy9kZWZpbml0aW9ucy9ub24tdW5pcXVlLXN0cmluZy1hcnJheQ0KPj4gKyAgICBkZXNjcmlw
dGlvbjogQSBsaXN0IG9mIHRoZSBjb25uZWN0aW9ucyBiZXR3ZWVuIGF1ZGlvIGNvbXBvbmVudHMu
DQo+PiArICAgIGl0ZW1zOg0KPj4gKyAgICAgIGVudW06DQo+PiArICAgICAgICAjIEJvYXJkIENv
bm5lY3RvcnMNCj4+ICsgICAgICAgIC0gRXh0IFNwaw0KPj4gKyAgICAgICAgLSBJbnQgTWljDQo+
PiArDQo+PiArICAgICAgICAjIENPREVDIFBpbnMNCj4+ICsgICAgICAgIC0gTE9VVA0KPj4gKyAg
ICAgICAgLSBST1VUDQo+PiArICAgICAgICAtIExIUE9VVA0KPj4gKyAgICAgICAgLSBSSFBPVVQN
Cj4+ICsgICAgICAgIC0gTExJTkVJTg0KPj4gKyAgICAgICAgLSBSTElORUlODQo+PiArICAgICAg
ICAtIE1JQ0lODQo+IA0KPiBBcyBwcmV2aW91c2x5IHF1ZXN0aW9uZWQsIEkgZG9uJ3QgdGhpbmsg
eW91IGNhbiBjcmVhdGUgaW5maW5pdGUgYW1vdW50DQo+IG9mIHBhaXJzIG91dCBvZiBpdC4gQXNz
dW1pbmcgeW91IGFsd2F5cyBjb25uZWN0IGJvYXJkIHdpdGggY29kZWMNCj4gKGJlY2F1c2UgY29k
ZWMtY29kZWMgYXJlIGFscmVhZHkgZGVmaW5lZCBpbnNpZGUgdGhlIGNvZGVjKSwgeW91IGNhbiBo
YXZlDQo+IG1heCAxNCBwYWlycywgYnV0IG1vc3QgbGlrZWx5IGxlc3MgaW4gcHJhY3RpY2UuDQpJ
IGFncmVlIHdpdGggeW91ciBwZXJzcGVjdGl2ZS5IZXJlIHRoaXMgYmluZGluZyBpcyBzcGVjaWZp
YyB0byB0aGUgDQpBVDkxU0FNOUcyMEVLIGJvYXJkLHdoaWNoIHVzZXMgdGhlIG9uYm9hcmQgV004
NzMxIGNvZGVjIGZvciBhdWRpbyANCnN1cHBvcnQuU2luY2Ugc29tZSBvZiBzaW1pbGFyIGJpbmRp
bmdzIGRvIG5vdCBleHBsaWNpdGx5IGVuZm9yY2UgDQptYXhJdGVtcyxJIGFzc3VtZWQgdGhpcyB0
byBiZSBhIHZhbGlkIGNhc2UuIEhvd2V2ZXIsIGJhc2VkIG9uIG15IA0KdW5kZXJzdGFuZGluZyBm
cm9tIHRoZSBzY2hlbWF0aWNzLCANCmh0dHBzOi8vd3cxLm1pY3JvY2hpcC5jb20vZG93bmxvYWRz
L2VuL0RldmljZURvYy9kb2M2NDEzLnBkZiwgYSANCiJtYXhJdGVtczogNCIgdmFsdWUgYXBwZWFy
cyB2YWxpZC5BcmUgeW91IHJlZmVycmluZyB0byB0aGUgc2FtZSANCnVuZGVyc3RhbmRpbmcgaGVy
ZT8NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCi0tIA0KQmVzdCByZWdhcmRz
LA0KQmFsYWtyaXNobmFuIFMNCg==

