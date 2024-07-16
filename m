Return-Path: <linux-kernel+bounces-253466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AC19321B6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 587DCB21A51
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 08:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A385455885;
	Tue, 16 Jul 2024 08:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="VkYyqFns"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020122.outbound.protection.outlook.com [52.101.69.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798523224;
	Tue, 16 Jul 2024 08:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721117767; cv=fail; b=iyzRsjEkYHypiUxmYJLjNvuh3T2i/8FhUpnVayIAX+j/cpH9+NOrzY/b4MfpQLNBWPhM2Lyl6zGwQweEgNJv3qr/TxjcMlO+VRs4j4kqDtAaCaUiFuPFtUD9lPfFw+6juShfM3lW3azbEVwWEnq+wKZRfr/LgciQIPqmLjB5GSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721117767; c=relaxed/simple;
	bh=yTnW1amBie5sOZwpVnUJF64O3pBsl7g9KQSjczwzM6E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LKkgVYjn8/tGaNKjjWiw345fjKo1z1eOPlQL89BJVl7IU33cTYy/Yn9qa4mOc0gpu5joEM3LwvW5+09b8Ysy8uaWJdDDrs/a+QvCMi9iRhCfbzC4815FwmJaXzbalEE7WgrwUWhVD7rjcAJy1dcrkUOk1/E9NUXAQlCfnTWu/Yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=VkYyqFns; arc=fail smtp.client-ip=52.101.69.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJf+RTyvsJUczAwEodtUg93KOPXDZKkTAWWnPuo5BdchBnMmNPGfXEVJLwAV3SOGuWlTLuKsI0bn0Fn1Ru9EAJQrR18d5zUnhpefYghr9vD3A3z+TDo4WjF+xigo1cqDA8ufhavbYzSYxhoV2FD0Id7QnRCfXzQhm7lyF1jJ/OUxEzgBEj29+IFyyp5qNKaw6aIia9Hc/gEfVsuFMuYlTwzu5kyVnO/7RLOInEti0oE4uJQH0kkDO2T/llwlebr1Y2wIIJ0NZEpxOV+omr88iPCEGEO32HSHexymM+xs1hwGYTA5T2xwT5x2cnCD524Vxqdq1V/GK5198XqZoX5orQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTnW1amBie5sOZwpVnUJF64O3pBsl7g9KQSjczwzM6E=;
 b=M72pa0KJGKcbaQkKjbwRzJxi6pSpqZtfqTEirPukZridb0hXo6DLGDnHkR1Qb7lZqg4Fb6fG37HKqpOGEPE3ahNvYzL8rv0NSy4c4j5F2B8vHpPK0Y0H1O1TtxZJiRP2cAkgdwiawT05KLGBV5YovvDEO/lO0u1NnZgH7I7Rt9X7W4De4r83MRbCv+/hT3ME4cM4338c03/gYWjJ9zR1sy8R4CEnrKlHajV/ZjGf0NlGYKigAGcC+wduv76NQ44oMbunhnRzMcw3HKp5XKpd4rzqApqA1qWOq8IxXV4dOwdtg1rhYsNe87gO5CfedOwPCIEtFm88fDc1Q11Po4aEfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTnW1amBie5sOZwpVnUJF64O3pBsl7g9KQSjczwzM6E=;
 b=VkYyqFnslmRuUmAgMyA2k9qROu9D8ma1kc7pyllHYuYFhyWSBe9+0UxXyETwuezFVCje6jgiUiw7tdNVGn3QUxKUW9+p6vLXgsUoPzX4WhTvFkKFZY+Ow6b0X0lueuxOzOA0emfuzVG5NBdkHp6uq3jOc8baBQ1BB0/6VJwvzgg=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 08:16:00 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%3]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 08:16:00 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
	Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth
	<sebastian.hesselbarth@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yazan
 Shhady <yazan.shhady@solid-run.com>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH RFC 2/2] arm: dts: marvell: armada-38x: add description
 for usb phys
Thread-Topic: [PATCH RFC 2/2] arm: dts: marvell: armada-38x: add description
 for usb phys
Thread-Index: AQHa1t8UBLBa+iFCB0+N+odSS9eyG7H4F2AAgADrqgA=
Date: Tue, 16 Jul 2024 08:16:00 +0000
Message-ID: <4468f388-b9e0-4407-9be3-260d2204e9d9@solid-run.com>
References: <20240715-a38x-utmi-phy-v1-0-d57250f53cf2@solid-run.com>
 <20240715-a38x-utmi-phy-v1-2-d57250f53cf2@solid-run.com>
 <e35e0edf-f99e-4af7-8abc-c8f96b73ddd5@lunn.ch>
In-Reply-To: <e35e0edf-f99e-4af7-8abc-c8f96b73ddd5@lunn.ch>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|DB9PR04MB9380:EE_
x-ms-office365-filtering-correlation-id: dce1d1c8-830c-46be-363e-08dca56f86ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cjJUc0EyU1R5WVNmcW05R2tvVzJjR1ZzTDZwa24wY29HUmQralNBbXh5OXdH?=
 =?utf-8?B?VHBxTlhRdjI5cDNEc1hNUHo3SjIzMTdwNE1FNjZmVExNdjdhanhBcUxSaXdQ?=
 =?utf-8?B?VmhXK0U1WkZkOVVTVmV5QVl4SG53SmttUWd3bmlUM2dTTlFnc1F6ODc4MEFK?=
 =?utf-8?B?Mk1XcE4zY2VBUUhKc05HOHc1VGJ5dHNtYS8rYUttWExySEVKWFBad29NVkp0?=
 =?utf-8?B?eVhZWHJST2c3ZW5XeDNlUE81VVl2clYyZTRiTW0yZUxlV01BWE85QW9kTnNv?=
 =?utf-8?B?QkpaWDlrenEzT3o2Qlk4dG40amNSQ2p0VlpadkVPclc0czVqdmh2R3VySlp1?=
 =?utf-8?B?azBucFNQWXNQNkkvWnF2Z2RxS3A3TFBPSStlY1FQMXU3eFdaNHVzbDRFMnBK?=
 =?utf-8?B?QklnaUZ0bDNxMFNHWGFwRFdhOUJlQ1ZLdzZaZTAwS0VhYXdXNnUyRHpaWkls?=
 =?utf-8?B?SXRSNlcySlI1amYrTFBWT3Z1VjdGMTVtdStFSjdtUUg4SmNIcGtqcTVkdzVv?=
 =?utf-8?B?OFZ1R0RBQVovcytkTWFxeENua0JnWHZEMXpHbXpPWmxrczlUWEJVRnRESElm?=
 =?utf-8?B?aEtKOFlIa1hxSzdDN2tOSFNXUU5KVnBWQUFvekNPSVRiSEpNQlAva3IySVBs?=
 =?utf-8?B?QmJ0bHE1ejVwT3BGYXFSSW1pVFVqQjFzZFpseW1RZ0s3WnA5RUtFS0FvNGsv?=
 =?utf-8?B?MklSQTJBcHd3L3hRUnpDazYxRzh6RFd1SnBOL1RmTGVxUUF6cmpsMUVCbU4v?=
 =?utf-8?B?aytNd2NXVEtpa055cHRuUHdFNjhrUFZXZWNacDBNb29JL2Q0dS9WdjJMTlhG?=
 =?utf-8?B?NzgvK1FQTld3L083emZaUFpCaDJ6UXRrc3l3NXk5b1dYaDN5WXJpNTNNUDc1?=
 =?utf-8?B?OG1FUnBPejFWc3lyUGtIMlNQazVmUXQ4MWtKb2o5Q0JLRWgxb09OM3R2aG9U?=
 =?utf-8?B?dnFSQkQzMGM2Yk4xTVpNOEZoOXpuQTQveUpSMjVOWkdxdHdyZDVRUTVJOWM4?=
 =?utf-8?B?eUxUNUlQVzdES2xLL2RFZ0xyZVJSbHlGSERUUUlHWTZrQTg0ZDdOczkzYnFF?=
 =?utf-8?B?MkdWenM1ZW9ORzVyVTNwbmVSVUkrcnBKNXJ4M1VubEJwVHlSZUk3RDh4c0Mv?=
 =?utf-8?B?bXdZVjNEeWxDQ25wbzE3SzIvMVhjbHZUdmc3MEtqUXR4U2R0aTVybDVOUGFQ?=
 =?utf-8?B?YlB1cndYWUpLcVIwUkd1MGl6NWpmMzZlM1c1QXhKTFIvNWVRZUEyeWpLaHVX?=
 =?utf-8?B?bUszc3lLblFMNWtCb3U4d1pRamNLLzdKVk84ZGsya1pCTHJXcDIxWWMyUzgy?=
 =?utf-8?B?clV2emc2Sy8xSlJaVE9IQTZUVmNvZE1DbDlnTitxb2N1NXJSazZmYTdkdDJC?=
 =?utf-8?B?dzFCdWFnVkgvY3kvT3RuK0VoSm1OYmcyVktPSUFDdEUveHk1UXJkSEpNalB2?=
 =?utf-8?B?aW1WQUNGWjFCSmZNV3JpSkU3K0ozQThjcDhKZ2tHaDFJeFpHSzVSZmNEREpp?=
 =?utf-8?B?alJUMkd0THE3OVJ5TnlwZlUyMHNrLzdzdXM3SjF3eldkSTg5bEtYMjJuY0VE?=
 =?utf-8?B?aFlPazJMM0ZYeHFWcGx4bHdwdmFmTEtOb0NnYkE0Z2h5UmZVSGJxZTlXZWJW?=
 =?utf-8?B?NjJ1dUx0Nml6QzRyaERuZ1R6RUExUmg5cjhrMS9vRnFESldDc1REUVN5OUh1?=
 =?utf-8?B?UmtBREx0d01VNTVTMzVPY0IrVzBESmR2UU1OYlNZNUpJOHlXZFlZOUpHZWx3?=
 =?utf-8?B?cWkzbWFnZ0lkakxUOTltc1REdlZZbktrVllkUzZkNGNnMzZ6N0tNbXJWMm9o?=
 =?utf-8?B?K3lxb0llaEJZUTRlS2NhQ1AvQXdIQnBHNjZmT3lKMmR6enVvaVhQUlNVM054?=
 =?utf-8?B?dFJuaXI2TjU0VDExWW9MYTBrZVovODdmTEQzSFFlMDhhYmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dDZHTndWSTNINlpLT2hhVlNXV1d4eFBoaUxpOS9hZ055U0xtNitpUzd0UDl0?=
 =?utf-8?B?OVhOWFJGdnJVb1dOUTh4RHAya1hRN2FLOGNHQ1hSUGgrZE9VUzFkSndNT25h?=
 =?utf-8?B?ek1pdUZDRllPVWZSWFExcHBuR29TN0U4aXE1eXk4TlQ1RWZ5SzkzQ2Vpdjla?=
 =?utf-8?B?NVpVNk5DVjZROUZLMXZxZDkzM0NSREFaelRUUmUyM3lvMFZ6Y3JPMWtIMzJn?=
 =?utf-8?B?Mi9uQXNTOWhWbHJOSzBkVlljQkpBZGdRYXFpeVFRMDhieFp0c1lhUmErR3li?=
 =?utf-8?B?U201NkMvMUwwUnJhMW05QkdxZjF5QS9FcmFZTW9uTDV4RzZDTXJZSE8rdXBh?=
 =?utf-8?B?ZU04c3VqS3N6Z0o1Kzh5b2ZGdWwrRDlrbWZSbGdnZGRMczVJTW1nNEZuZWd4?=
 =?utf-8?B?Zkl3TTE0UGNWOXpqejE1U0MxVUIrSFJlWEpxQm1nOVNybFI0VHNtSFRlYkVD?=
 =?utf-8?B?N3BPTE5YTTJORmRWTjRZQm5PZEZFUnd2eTdOU3hjb1VXOExoTTU4M0p4L0xZ?=
 =?utf-8?B?MUVZWFZBK3ZobElPVlNCbDQrSERlSVZZNGgzaGZmbmx5aGZTNEQrd3pnWWo3?=
 =?utf-8?B?NWpVZ3hmUldaUU5XdFk0d2Z3TzhDRU5ONzBaWnd3V0RneTY0Rk9seitIVDl3?=
 =?utf-8?B?ajRZM1k5aWdnSDRzYk9rV0JlRGEraHNHeFFSTEI2NXBzbGRVbWt2cHFCbnpZ?=
 =?utf-8?B?SXBDYVVENW42RzQralJ4WHlVazA2QkdGRllWRUJ1c1RVSnJYVG5PaktxdWJT?=
 =?utf-8?B?eUNxaks1dXhIeHEwdEJJcjJyVUZZNXQ1T1VoWnZ0Qk84QmxlSmU2WE00UXZ0?=
 =?utf-8?B?eHNjQitHcm5LMDF5VXVqTVM0SHJ0OEdMckV4TUF6U3ljTUFTQS9lNk10RVBG?=
 =?utf-8?B?SnFxNXZJSm9YSmpZbEtmQ0hXY1J6amhrMVRhenNMVWx3MVViSnBNYmFPQkVK?=
 =?utf-8?B?dDVBZVFIQ2tWN1ZwME0yS3A5NkVuYXV3YUlSTDN2ejVQenFQdzRjZ1h3NE1r?=
 =?utf-8?B?ZFh4aGFwczZzYm8wU25keS84Y2ZueFpoalBIRFJDSlJaUzdITUdyODdBQWNn?=
 =?utf-8?B?TTZoV0I0cGUrbmZoS2hlT1VRT0RrZkZudXM2U24vWUtvUEdKZFc1T0NDM2pQ?=
 =?utf-8?B?cUI1UmxEMUkxT2VwMUZZU0VudFA5NzVoMkpQa0IvcTk2SW5vUTRhWEo0MWhF?=
 =?utf-8?B?UEFyV1VuNURrZHZzYlBUcDRQMGRmVkFLbVcxQ2x6QXQ5N3c2NjhXT2tGM3BP?=
 =?utf-8?B?ZzBGUUpzUk12T3FSU1JVQkZVMjJ0VWh4RU4zOG1ySEs0KzFoVTBnVlZpNktD?=
 =?utf-8?B?dDZPTFppb3pWOTdQMXJhSldMUWlxWVhHbDh3VmovWU9hMEJNeDAyWFIreUFy?=
 =?utf-8?B?bTNEUklhT0phTXVxVlNQeXpKM29ORlpvYk9HVGdXa1Y0UVZxa1NBbTlJRjFj?=
 =?utf-8?B?aXpTWXdpVUdpSVIxdW1zYWNTZG83cU1nWkV0NmdBMkNYdHQ1M2ptV0tlRngr?=
 =?utf-8?B?MU9veVEvQjVRaUdzWStFV1ZodjV3aE4xYUU4UkhLMFF2aEtlZ1pjS1VHU0hU?=
 =?utf-8?B?Mlg0Q0FVTSs2c0ZTTlRiMHZBQy9YOElNUkMyL2NJSUtVOXhYRjJock1oWTZv?=
 =?utf-8?B?NUxLU29NK1JRM085Um1NYVNaSHlJR2VsRWVEWFI3SFVpWUtUNnlxN2NqWmRx?=
 =?utf-8?B?MGpMZVlYUUIrWWhGNGFxQkx6N2pQT2tHVnFhcFRzQWNMdjU0TmZxOVFSeVlV?=
 =?utf-8?B?NVp1aXo0Qk9DMkJWdlh4cEJCaFZSaEIrVGNLTWZZWHhCK012cDcwNUptYkhY?=
 =?utf-8?B?N3BBbEh3KzBlVzFCWDlvVldJQWUvZzVmdWEzN3dibFBOUE5ZZEszdUY2ZENk?=
 =?utf-8?B?RndrZTJQenVldHl0aEZQMXVkaHNQcUpwNzBYQkw1RlA2MVFiYSt3Q2xPbDZ5?=
 =?utf-8?B?YmVYRlhlOTk2RGtGSlc5TDBUZGtiQjQ4NlB0dnp5YklvYUt1UEhheUdBM1JK?=
 =?utf-8?B?N3F0ZUxIOER5UkZNUzFaanQ1VWlQUTBYN1M0QjJYdmdYalVvTGhSMDBIOW9W?=
 =?utf-8?B?SERKaU85NGZUN0J4TWJUVjYwKys4SGlVMDZ0d1VlL2l5dGFpQ1JPZHk0YUdP?=
 =?utf-8?Q?ZrhJkvmC475njn5aZ0a4T9TTD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD36E9B0BCB23341821C1BC7BBFB5291@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dce1d1c8-830c-46be-363e-08dca56f86ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 08:16:00.4499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ebBGYoKZrFXa8nUyyq/jlVtIEWG/s3cFbNKBjI7u4g7OCBdkhKFm4ghKQEJr0XM3m0dCVnJ7GKB+dFufLfopyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9380

QW0gMTUuMDcuMjQgdW0gMjA6MTIgc2NocmllYiBBbmRyZXcgTHVubjoNCj4gT24gTW9uLCBKdWwg
MTUsIDIwMjQgYXQgMDc6NDc6MzBQTSArMDIwMCwgSm9zdWEgTWF5ZXIgd3JvdGU6DQo+PiBBcm1h
ZGEgMzh4IGhhcyAzeCBVU0ItMi4wIHV0bWkgcGh5cy4gVGhleSBhcmUgYWxtb3N0IGlkZW50aWNh
bCB0byB0aGUgMngNCj4+IHV0bWkgcGh5cyBvbiBhcm1hZGEgOGsuDQo+Pg0KPj4gQWRkIGRlc2Ny
aXB0aW9ucyBmb3IgYWxsIDMgcGh5IHBvcnRzLg0KPj4NCj4+IEFsc28gYWRkIGEgc3lzY29uIG5v
ZGUgY292ZXJpbmcganVzdCB0aGUgdXNiIGNvbmZpZ3VyYXRpb24gcmVnaXN0ZXJzLg0KPj4gQXJt
YWRhIDhLIGhhdmUgYSBzeXNjb24gbm9kZSBjb3ZlcmluZyBjb25maWd1cmF0aW9uIHJlZ2lzdGVy
cyBmb3INCj4+IHZhcmlvdXMgZnVuY3Rpb25zIGluY2x1ZGluZyBwaW5tdXgsIHdvaXRoIGRpcnZl
cnMgdXNpbmcgc3lzY29uIGZyYW1ld29yaw0KPiB3b2l0aCAtPiB3aXRoDQo+DQo+PiBmb3IgcmVn
aXN0ZXIgYWNjZXNzLg0KPj4NCj4+IEFybWFkYSAzODggaGFzIHZhcmlvdXMgZHJpdmVycyBkaXJl
Y3RseSBjbGFpbWluZyBzb21lIG9mIHRob3NlDQo+PiBjb25maWd1cmF0aW9uIHJlZ2lzdGVycy4g
SGVuY2UgYSBzaW1pbGFyIHN5c2NvbiBub2RlIHdvdWxkIGNvbXBldGUgZm9yDQo+PiByZXNvdXJj
ZXMgd2l0aCB0aGVzZSBkcml2ZXJzLg0KPiBEbyB0aGVzZSBkcml2ZXJzIG1ha2UgZXhjbHVzaXZl
IHVzZSBvZiB0aGVzZSByZWdpc3RlcnM/IE9yIGFyZQ0KPiBtdWx0aXBsZSBkcml2ZXJzIHVzaW5n
IHRoZSBzYW1lIHJlZ2lzdGVycyBhbmQgeW91IG5lZWQgc29tZXRoaW5nIHRvDQo+IG1lZGlhdGUg
aW4gb3JkZXIgdG8gaGF2ZSBhdG9taWMgYWNjZXNzPw0KDQpPbiBBcm1hZGEgMzh4IHRoZXNlIGRy
aXZlcnMgZXhjbHVzaXZlbHkgdXNlIHRoZWlyIG93biByZWdpc3RlcnMuDQoNCkkgc3VzcGVjdCBh
cm1hZGHCoCA4ayB3YXMgdHJ5aW5nIHRvIGF2b2lkIGRlY2xhcmluZyBsb3RzIG9mIHRpbnkgcmFu
Z2VzLA0KYnkgdXNpbmcgYSBzeXNjb24gbm9kZS4NCg0KVGhlIHN5c2NvbiByZWdpc3RlcnMgYWNj
ZXNzZWQgYnkgY3AxMTAtdXRtaSBkcml2ZXIgYXJlIGV4Y2x1c2l2ZWx5DQpmb3IgdXNiIGFuZCBu
b3QgYWNjZXNzZWQgZWxzZXdoZXJlLg0KDQo+DQo+IEluIHRoZSBvbGQgZGF5cywgYSByZWdpc3Rl
ciBzcGFjZSBjb3VsZCBiZSBtYXBwZWQgaW50byBtdWx0aXBsZQ0KPiBkcml2ZXJzLCBzbyBsb25n
IGFzIGFsbCB0aGUgZHJpdmVycyBhZ3JlZWQgdG8gaXQuIFRoZXJlIGFyZSBwcm9iYWJseQ0KPiBv
cmlvbjV4LCBraXJrd29vZCBlcmEgbXZlYnUgZHJpdmVycyBkb2luZyB0aGlzLg0KPiAgDQo+IAlB
bmRyZXcNCg==

