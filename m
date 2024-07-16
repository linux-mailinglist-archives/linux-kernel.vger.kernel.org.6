Return-Path: <linux-kernel+bounces-253475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 956329321E1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 273011F22B14
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 08:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DF617CA1F;
	Tue, 16 Jul 2024 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="CFBRXgSX"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11023073.outbound.protection.outlook.com [52.101.67.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FF717B42D;
	Tue, 16 Jul 2024 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721118616; cv=fail; b=pMs2MdkOrHx9pg765JDOuR3YUkYEazNuCfNdNzuRnr+qlKo51EdHiWsXIPpGQRpm9D+2MN0CkI33VMPQcfGeMtMJa7TU7lhKidE1GZb+2/voMZcjEaXvyyKCPFoxlZ8Y8ayvFzjf7rxDoXZLf8aBcj5jflosNRhRGjE6ifFhyco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721118616; c=relaxed/simple;
	bh=NwlTPUCHNubZ/AUVG61Mw5UEOgp0YF8ELIhx3wdAtEo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oEmU8HzkOGy0JCutLs5Z1UHbwh3Aj4sbHx/Ys0tz9IPuSsEmaADfZyfLozU8lnD5e3syEapetoXduLVscCE5d8RshsfYwCKnELN9DeGiZQFDnuW+sq+LENg6u4mFXhR6c5afSnScvd4ltUq21ESSZ38606hlz58d5vxY3YN3ybs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=CFBRXgSX; arc=fail smtp.client-ip=52.101.67.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kixpVhWDTKdkUU5i5GauxZRyX+BpHpRs6CawIzhJlsk3nCklydo9dgMV687ajvoHnx/ovWjRXPa+oq3vGPS14t3BTuVSAyBS6DsS5Wko+8kf+qWRG2J/nbOoZNwe3Mzqe+h9/6mKyr9Z3/zrWLM1RXbHw+Ka1l8TcwVDeue5rRJsTsY65WvSQvIswcfH8ZD12NxkPHHBUtJPo489yhKRtQNOlerPT+9EHUkrzXTRw8qL8lgpEZFbfg2bFrLZAQA2OA9jbBmCYoLHTWm0o7NjFB4VDAY1be7NqdOc4G4Tcqg23CAo2H1schnABF+qojhnHobQtS05JTZ2qeRRQIT6pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwlTPUCHNubZ/AUVG61Mw5UEOgp0YF8ELIhx3wdAtEo=;
 b=lTPxmm6szS8Q/9eG1MRPxptT2cpPt5leWkVBjrWPDrWMM/CILCdHhAdroAJPkQuUQJd53Sy19j+mf/y4SlaXiv69BtIa0nudZrlXmBFmVI9H3IZ6Z0SC/lTfWXfGGcA67iZAMq5kO0SkpqRJF0W94A6Wxt7/JfIvesLms6ah5VxXTqIhsOygTRQ1bcXKy0h2kjaFY1UQdJdrny4sBSWzp/4TTzAz2UOuc2XpchrWLMP6gkbBXdCOxjFKMc6CihqIMXG+XLu9fC0bVqbx/Rl9uU+zYixf/NrJ2BxeIWSICgIh96+RVYx/RbLmSMNjGQNcTRwloIEq1n1KKk/2+vBWRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwlTPUCHNubZ/AUVG61Mw5UEOgp0YF8ELIhx3wdAtEo=;
 b=CFBRXgSXE4zu949suMC9sSUgxn2xMgyyvrk1aMdHRIc5Y2O75z3lXEpcpwSpU9CKWzpNs/57HyCG9BTM+jVqFXZvRrXMIiIiQmnqhrwN1x9TqVcPYMbDkRuaG+ogyapvLMtho6ldPpSgqEP4q78BZbRrRissiQYUFvJ0DSu9ipA=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS5PR04MB9895.eurprd04.prod.outlook.com (2603:10a6:20b:651::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 08:30:11 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%3]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 08:30:11 +0000
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
Subject: Re: [PATCH RFC 1/2] phy: mvebu-cp110-utmi: add support for armada-380
 utmi phys
Thread-Topic: [PATCH RFC 1/2] phy: mvebu-cp110-utmi: add support for
 armada-380 utmi phys
Thread-Index: AQHa1t8TfjddiryMQkiNldLCRfDlw7H4FU8AgADxsYA=
Date: Tue, 16 Jul 2024 08:30:11 +0000
Message-ID: <c5ac4b22-7632-4232-a81b-e32bc48df670@solid-run.com>
References: <20240715-a38x-utmi-phy-v1-0-d57250f53cf2@solid-run.com>
 <20240715-a38x-utmi-phy-v1-1-d57250f53cf2@solid-run.com>
 <837de973-0a58-4a07-a126-43445bfa7721@lunn.ch>
In-Reply-To: <837de973-0a58-4a07-a126-43445bfa7721@lunn.ch>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|AS5PR04MB9895:EE_
x-ms-office365-filtering-correlation-id: 63753aa2-6f8b-4d67-d7b3-08dca5718282
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dWVvU2pxdkQ4eG40dUN3Rm9KYTdTVk5wdUlDRklUUDFIditzT2NMTUV0M1FG?=
 =?utf-8?B?OXd3WHNuaEVUWU0vL25ObnJOV2FXbFQ3Y1pzNWU4UXRYUkJxQWpOWFZPZFJD?=
 =?utf-8?B?K3U1Ym85S1owUTJrL2NqdDF2TGwyZlM2d1lFV09YVTlGS0xBVk9YUkNiNjE1?=
 =?utf-8?B?UlE5QkdXdEpGelJ0blgzdHBXa3V6RWlzWmV5aExTNWZVTTAwa1NmYnBVa2Nx?=
 =?utf-8?B?YURWR2Q1em14ZThzTFdKU2Ria3FsRlpaMXl1a1FrWEhqUzRMK3ZsRFdiZklC?=
 =?utf-8?B?UkJ0eDNzcFlwNWRoUFBXZUlJZnp0QVJ4ME1GREk1QjFyK1Fua0V2ZXdJeU1B?=
 =?utf-8?B?bWhPdEpicWUrVm1XdksvMEZvelVRTjUzSDczUzFOZkpUKzZEaHdzeEY0VGNY?=
 =?utf-8?B?RFBPVUhVMFdBKzBTNFdZUmFyUGUwTks3eG9HQ204LzRudjYrWjVzWklzdDFi?=
 =?utf-8?B?dnNxTndqSkdUZHZnOFREL0U4eW4xclVSMDNSaHlKc3R2SFVLVUxUMEZaWDRp?=
 =?utf-8?B?WVJnRi9JOS85WWxaQzdFVmlVZ2xjMGw3aXpaTnNKNStYV25WZUhrNEFSYVdX?=
 =?utf-8?B?aDZvSEM4VXVsRDFTTVU5K2lrZDZQM1pUTnVOeUhUQjBQYmwvR2FaTDdtNDNO?=
 =?utf-8?B?NUJGTGV2NFJRN1poR1NsTVUxUm9Pa2Y2QnNnNkxuejlnUkF6NTJMZHdDRmpJ?=
 =?utf-8?B?K0N3REhlSy9sK2YrWXFDYzYrVlNDY1BUTEhWL1hrQmxHM0VHZTFLUW5PZFJw?=
 =?utf-8?B?QlFsMkNvMHhXTW9MSnZCN2w2TnB6YngxQmF2QlBjK1VIc3BabGJjYklab2xq?=
 =?utf-8?B?ZHozamFUNUxybzZjNWVpNXBQbmtBNlFSQXNDdzluYUZZY0VZK296VEg5MkUz?=
 =?utf-8?B?NFZwUjFOZ0VkellOc2ZyWmxpRjJZVWR2YXRQOXl2aE1SYWJZdjhZMlVpNmQr?=
 =?utf-8?B?Z3Q4ZzVwc3Fnck93ay9vNGRDS3FZTHQ4emoxNXNXS1ZES0g2cEw5ZTBNaVRw?=
 =?utf-8?B?UmpLSVVOc1MwRWdVZFo5ZU5EZ0lqWlFvSWJ1d2tMTCt3NUdtYmhMakZRVS80?=
 =?utf-8?B?MGlBTHFTeFhsRW42NkhGeWtNeXIrdmU2ZkxCUDdpZlh4QlRzSFV3cUE4dlVs?=
 =?utf-8?B?bEZxeGJQZ0xvNlJzYTBLVXlpREYrWHpRYng1VkFKaXpuUCt5TTM4QU5VKzNn?=
 =?utf-8?B?RU43TkRoTHRNK0trYnNLYWJab0xsTlBlalJGWDR2bkNjREI2RnhTbVFmN2Ni?=
 =?utf-8?B?QkZyMXN0UEtKZmM3alNXamRtUSt5cUdBTFZaZWFUZXNCTVVmZWE1NUJ3bmhY?=
 =?utf-8?B?dTJPVWR2dS9oaWQwd0JQczUrS0JVdVUwTXBRRGhFME81TnFqV0crcFBGR3px?=
 =?utf-8?B?YTlhVVR2SnZ0eDBDbTE4YU5POUYrNENrTFJxdkt4V01aVEdPMUdPelU4QjBR?=
 =?utf-8?B?QnFDc3FRMHN5MkdoakNFaEk1c2ZNT1Flb3FjYUhGSmxOY0s5YXVZRkJaVzFx?=
 =?utf-8?B?U3lOVVZLRkF6eGh5VmV6VVlRanlPQW1JMFV5T1ppUXdsdnRMNHRGOFFnZWV2?=
 =?utf-8?B?RENJQXpDQk5MWkdpRVpFQ1hVWlJMQ0ttSzFlM0IvVEw1aURFTEYxaVlpWGNF?=
 =?utf-8?B?TTBmZGRRYnh0eVJtYjdUb0k2MHdLZEpNNVRtMnFieHJSOTQ2c3NsanJ2eDVE?=
 =?utf-8?B?V2tzeTRaQzA4ZVhTWkJwOVg5VGF0RWZMeUxrSVREYy80M1pWcUFjelJKS3Ja?=
 =?utf-8?B?TCtYUG93NFR2SUk5NGN4KzZUNDllZzFjN3NsRC9JalNDVGxReFJwZnU2QTRH?=
 =?utf-8?B?TkdNZ2hwaUlGMFJaTEF0dWFLL0VsS1VQSkNvWXgxNWRDcHREcEg1MVVsdm80?=
 =?utf-8?B?c015Vi9HV1IvMGo5eDRIeklHU0xBWWx3QlRPMDUydk12bUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OURxQ1N5YVR6VnptVFArSmVSR3NNNllrQmtTV3RsWXNjcTFMNVYrSVJuQUI5?=
 =?utf-8?B?T3Jrc0NyZllTQU9jNkI5bjRRdFhSZkdrOC9OdnZXZW9kUjNLTk96blJSVHpQ?=
 =?utf-8?B?RUgrdTFwUkVyME5QSlI1NWpsSmFiUWFoaFZZZzdjc3NVdDVpc2toSHlSQ3do?=
 =?utf-8?B?UlhzRkFqSFozK0JoK0wrRHEvSmZDTzJDcFlHMmEzaDRoVm4wVjRLQW5zTUxl?=
 =?utf-8?B?TXJncDNkclpyRTk5VjVaMnl5Z0JBODlaU1ZJQTFnVDAxcll0THg2QytIdXBY?=
 =?utf-8?B?ZlYzV1BORkFzMTJpS0lPRncvbDVESUsyeDAvMWJVOEw5Z0RWNXFCc3E3dmk0?=
 =?utf-8?B?TmE2R1krY2xTZEVabTlHbG9BOU5qMjhub3VKVkhMci90MnljM2VNaytFV0wz?=
 =?utf-8?B?d095MEFwWWs4bG5JQ3gydTZDaVUycE83TGNndjdUSnIyZnVJdXhuQnZuNHNR?=
 =?utf-8?B?QllMRnVOL01SMTlhUUJDblZxM0xwdnhGdkFkTFBkdEJhRklyMlgvL0xJRHJT?=
 =?utf-8?B?ckRNdUtpeFQyTllGdEw5TGkxeG42aDhnd01DMko2VDlhYmNrclQ5V0JweTVK?=
 =?utf-8?B?QktPckRnR25WQkVxOE5WMDJBbEo4WnlvT0IrLzcvUFN0ejdVRWpEdC9tNnBW?=
 =?utf-8?B?RXNQSTV2RjhrOUs4OElVUFZ3SlJvZ1B5ZnlxMWpWRXFTVlorMWlRSy8xYXh0?=
 =?utf-8?B?anN6OWw0NU56c3k4VFNvVzJ5TWdsdGlnMjNFTjh6YzBQamFQclFiTk5RY1JL?=
 =?utf-8?B?RlltOGlWMGc4ZWVnNFhoWEV1VFNEQkIrd0dmT08ydFBZT1A0OHRXU2l1VXpv?=
 =?utf-8?B?TWxFS1AxMVdzSGtpeXV2aEVYSFdESGJhS3Y0aGg1dmRvRFVrVDExSUxQSzBO?=
 =?utf-8?B?OUY0d2Y4bVhQTW9NUHp5TTVzbEJabHlrZndrNGZCRFBRZDMyUHBiek9hVUo2?=
 =?utf-8?B?RHlSR1ZmcWhZZCtzYU5iV3A3OTdwRXBmSWFQVVI2aklwbzBlYUVJY1lETEpV?=
 =?utf-8?B?US9LZGV1bUhEUmZlQ0UvVGEvQmxNZ1NzU3FhLzZIZ201eDN0Y3dNV09ZOHZz?=
 =?utf-8?B?VlhmenVEa3VUb2wwZGJjYnJza2FUaHNNN1pqdDNRZnJTdkhVYXc1aVBjOUpl?=
 =?utf-8?B?YkNYL2VKZ2hsYjdwVkZtMWZXN1JnTVRRWjRyZSs5T0Y2KzVhZHB0SlYyZWYx?=
 =?utf-8?B?K3U5WUt5dHA4a2hQb04xa0Q3WVFWaWtwbEd2VVdjTkZIc25hck9sa0crVEFG?=
 =?utf-8?B?M2lJT3VXRlpvM1NUaVRDeWQvT1J2TjljdlVWVGp0cmdXdnp4cWJtdE5lRGtY?=
 =?utf-8?B?NmVlOVpqcHBON2gyRVUvQmgyeURUc3VJc1dsdG8xYkoxbXlKSGdjSWhVTXl1?=
 =?utf-8?B?cEdkQUlGMjlZMGV6bWZYMmMydlNPenFmdmZocjcrUDZncHFzS3ZSOWdUanpG?=
 =?utf-8?B?QlRJYjRBd2NYejJOREtZS0NGQXQ0R2tvS2NmSHVpaWlXZ3hQMGM1TGIvR3ha?=
 =?utf-8?B?VEMyZ0RldjdRd2NUczBTRk1XU203bnFlYWRwLzN0UUFQQWJNUGkvYXZSR1V5?=
 =?utf-8?B?OFRDMk1rQUk5bGpGZU13ZHlkcUNJc2ZFZXpKcUpVbTNxT0lubC8vNncwc1hC?=
 =?utf-8?B?cVc2Tlg0SWtaUnhaVjNFcGc0RmpqK05CRkZrR2toSUtsZnBYSzBnRE9jVlls?=
 =?utf-8?B?Mmc5aFhHby82WS93NW5tOXlmRDJKRHM1cCt0V3ZRMDZJcFJjdnRCUERMOFN2?=
 =?utf-8?B?MU8vNlROUVdmM1VCb0Iwb2ZlaGVVYXVtcU5CcmFNaCsveVZNOE4yY0kxeXR3?=
 =?utf-8?B?RTk1ejNweHVOWTNwUERTanpTelRvbklzYnVabE1hRkIrNHVsa0RWU1ExdE1G?=
 =?utf-8?B?R3pXRXpPUlNYUmpMakpLWFFZK1k4SkQxNkRrdk13RzF2Y1M3SWw0Rk0xY012?=
 =?utf-8?B?alQyY2Y2SERTY3lNS1BWdXBnTG92ZjQ5NFhkb0l4SVBBMUwvRzJNQTFIT1Rq?=
 =?utf-8?B?UVhMNXBQcW4xcExUamJtUWVlTmpQRzl2UUt6cGREaE5xMmgyR1JJV3Q0WWtn?=
 =?utf-8?B?MGltS3Z2aWw5dWpjQ3JCNEFQSUpJemh1QkJzbkVBQzluSUs2ZEtvQ1l1SDRp?=
 =?utf-8?Q?KvE5vM0/eNp0UW+i11PBAJlBX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83CC75DD852EC8498604559271A3C7F9@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 63753aa2-6f8b-4d67-d7b3-08dca5718282
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 08:30:11.8772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V/+sz/XVYOqZxa/Zw8XzDKjjRJmoEWoM9GnZtz7Hb0bfo9r4/AwAOc+JMudUTIS3UAPyhM9equftaFGtwJ496A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9895

QW0gMTUuMDcuMjQgdW0gMjA6MDUgc2NocmllYiBBbmRyZXcgTHVubjoNCj4+IEBAIC0xOTEsOCAr
MTk2LDE1IEBAIHN0YXRpYyBpbnQgbXZlYnVfY3AxMTBfdXRtaV9waHlfcG93ZXJfb24oc3RydWN0
IHBoeSAqcGh5KQ0KPj4gIAlzdHJ1Y3QgbXZlYnVfY3AxMTBfdXRtaV9wb3J0ICpwb3J0ID0gcGh5
X2dldF9kcnZkYXRhKHBoeSk7DQo+PiAgCXN0cnVjdCBtdmVidV9jcDExMF91dG1pICp1dG1pID0g
cG9ydC0+cHJpdjsNCj4+ICAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBoeS0+ZGV2Ow0KPj4gKwlj
b25zdCB2b2lkICptYXRjaDsNCj4+ICsJZW51bSBtdmVidV9jcDExMF91dG1pX3R5cGUgdHlwZTsN
Cj4+ICAJaW50IHJldDsNCj4+ICAJdTMyIHJlZzsNCj4+ICsJdTMyIHNlbDsNCj4+ICsNCj4+ICsJ
bWF0Y2ggPSBvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoZGV2KTsNClNob3VsZCBiZSBkZXZpY2Vf
Z2V0X21hdGNoX2RhdGE/DQo+PiArCWlmIChtYXRjaCkNCj4+ICsJCXR5cGUgPSAoZW51bSBtdmVi
dV9jcDExMF91dG1pX3R5cGUpKHVpbnRwdHJfdCltYXRjaDsNCj4+ICANCj4+ICAJLyogSXQgaXMg
bmVjZXNzYXJ5IHRvIHBvd2VyIG9mZiBVVE1JIGJlZm9yZSBjb25maWd1cmF0aW9uICovDQo+PiAg
CXJldCA9IG12ZWJ1X2NwMTEwX3V0bWlfcGh5X3Bvd2VyX29mZihwaHkpOw0KPj4gQEAgLTIwOCwx
NiArMjIwLDM4IEBAIHN0YXRpYyBpbnQgbXZlYnVfY3AxMTBfdXRtaV9waHlfcG93ZXJfb24oc3Ry
dWN0IHBoeSAqcGh5KQ0KPj4gIAkgKiB0byBVVE1JMCBvciB0byBVVE1JMSBQSFkgcG9ydCwgYnV0
IG5vdCB0byBib3RoLg0KPj4gIAkgKi8NCj4+ICAJaWYgKHBvcnQtPmRyX21vZGUgPT0gVVNCX0RS
X01PREVfUEVSSVBIRVJBTCkgew0KPj4gKwkJc3dpdGNoICh0eXBlKSB7DQo+IEp1c3QgbG9va2lu
ZyBhdCB0aGlzLCBpJ20gc3VycHJpc2VkIHRoZXJlIGlzIG5vdCBhIHdhcm5pbmcgYWJvdXQNCj4g
dHlwZSBwb3NzaWJseSBiZWluZyB1bmluaXRpYWxsZWQuIA0KQ3VyaW91cyBpbmRlZWQuIEhvd2V2
ZXIgSSBoYXZlIG5vdCBzZWVuIGFueSBjb21waWxlciB3YXJuaW5ncw0KZm9yIHVuaW5pdGlhbGl6
ZWQgaW50IChlbnVtKSByZWNlbnRseS4NCg0KSSBjb3BpZWQgdGhlIHBhdHRlcm4gZnJvbSBkcml2
ZXJzL2dwdS9kcm0vdGlueS9yZXBhcGVyLmMsDQp0aGVyZSBob3dldmVyIGlzIGFsd2F5cyBhbiBl
bHNlIGNhc2UuDQoNCj4NCj4+IEBAIC0yODUsNiArMzIwLDggQEAgc3RhdGljIGludCBtdmVidV9j
cDExMF91dG1pX3BoeV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4gIAlz
dHJ1Y3QgbXZlYnVfY3AxMTBfdXRtaSAqdXRtaTsNCj4+ICAJc3RydWN0IHBoeV9wcm92aWRlciAq
cHJvdmlkZXI7DQo+PiAgCXN0cnVjdCBkZXZpY2Vfbm9kZSAqY2hpbGQ7DQo+PiArCWNvbnN0IHZv
aWQgKm1hdGNoOw0KPj4gKwllbnVtIG12ZWJ1X2NwMTEwX3V0bWlfdHlwZSB0eXBlOw0KPj4gIAl1
MzIgdXNiX2RldmljZXMgPSAwOw0KPj4gIA0KPj4gIAl1dG1pID0gZGV2bV9remFsbG9jKGRldiwg
c2l6ZW9mKCp1dG1pKSwgR0ZQX0tFUk5FTCk7DQo+PiBAQCAtMjkzLDYgKzMzMCwxMCBAQCBzdGF0
aWMgaW50IG12ZWJ1X2NwMTEwX3V0bWlfcGh5X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+PiAgDQo+PiAgCXV0bWktPmRldiA9IGRldjsNCj4+ICANCj4+ICsJbWF0Y2ggPSBv
Zl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoZGV2KTsNCj4+ICsJaWYgKG1hdGNoKQ0KPj4gKwkJdHlw
ZSA9IChlbnVtIG12ZWJ1X2NwMTEwX3V0bWlfdHlwZSkodWludHB0cl90KW1hdGNoOw0KPj4gKw0K
Pj4gIAkvKiBHZXQgc3lzdGVtIGNvbnRyb2xsZXIgcmVnaW9uICovDQo+PiAgCXV0bWktPnN5c2Nv
biA9IHN5c2Nvbl9yZWdtYXBfbG9va3VwX2J5X3BoYW5kbGUoZGV2LT5vZl9ub2RlLA0KPj4gIAkJ
CQkJCSAgICAgICAibWFydmVsbCxzeXN0ZW0tY29udHJvbGxlciIpOw0KPj4gQEAgLTMyNiw2ICsz
NjcsMTggQEAgc3RhdGljIGludCBtdmVidV9jcDExMF91dG1pX3BoeV9wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4gIAkJCXJldHVybiAtRU5PTUVNOw0KPj4gIAkJfQ0KPj4g
IA0KPj4gKwkJLyogR2V0IHBvcnQgbWVtb3J5IHJlZ2lvbiAqLw0KPj4gKwkJc3dpdGNoICh0eXBl
KSB7DQo+IFNhbWUgaGVyZS4NCj4NCj4gCUFuZHJldw0K

