Return-Path: <linux-kernel+bounces-343660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A8C989DDF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88284286336
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578EB18BBAE;
	Mon, 30 Sep 2024 09:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d3hqobzX"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012007.outbound.protection.outlook.com [52.101.66.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A0E18801F;
	Mon, 30 Sep 2024 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687773; cv=fail; b=IFIVOgHIfyHqaLrApG2bbwyM8SQJ+Dj9kFRxMe9a56nMxWTKjxzA+N4sHf3NbpOV5IPS60bU0cuaYxIeKh1olm/BRruQ78IHT4eaLGzcQ0o/58EnlGWLbtk8qVi5m7snGJzVWv+AkfJ6dJqmvAu77ojxkoO5+rc3IR529gOiK+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687773; c=relaxed/simple;
	bh=geSQrmPS18ztobLrMHF0zzhBNoMrxH6I4E2wTfNHsKU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OzRg7oFFyDrrstX8DsPggs/qWL8IRJGYXcHncufuaAGV2mXE5gEZv0stT+9Pcu2LkWgeQ8RLBs7h5Pz00luRjMR6FELnSIcTGRFFDPYOTFeFhSgMMGLtV+jeLAEo6GG6RFL8/fp7WteswniQGB6PiaUim/9vGvRu6VObMSoQq1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d3hqobzX; arc=fail smtp.client-ip=52.101.66.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yuSlgwsIr9QZTpX7E4IM7OpuSYEgrLOMTwJ6rCRxho40N5wPA6Peuc8ANCRLBU5HQpc1QvQQTJGV0vnV0AEkzb8+XbxfiPCzyf1Mf4MUqDGKS0JLLqX3yccrZecZHOsuM/QTDiNTak2XDfbNvZs185xSQ2KTFMhPHSJxgUOrPdq7Cir9css4SmkDmiwRlVd5LP7+aeLUCoG/UcqCr74DM21wejfIbEsWxFlXBg+IXd+PIKdKWkvc0u7PxY28Y36KdwfhbryHdJiq5dP2BGGKtAz2haoAnhJeSzrIbjmA4BbwVwFOjF/GeAUc4uCuIp01ZOkUatFEN1RY9o2VTNFrNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=geSQrmPS18ztobLrMHF0zzhBNoMrxH6I4E2wTfNHsKU=;
 b=wGJScklRggjnE7ZPr/qt6xzu+0HiRxubtbZ5eZRtHQVeyDbf3YthDIVH4dX1cV/evSi18hsMneuiiG2nombJTELHh5jfe8e2Mu3x9rKOnX0zq2GwlYw8q5e9D/k/qw1403HmQJqayd9W6S7F45Go9z+2OqdC7agN/OF+h1eyEz3iovQr0L1qNGRoJe2EVC2qxdAs+wX+f1rDn/IyYpf1rPou1l1RXiuQegCDcQMOW5kpVBYH7PG/jQaGuoOF4IczuA4d3mjeCHY6He6MMc20SRuHW/1gkUx//i2Abjr9Pm17eHWTEnWB+aqYmdV/zLQ+aqUhBihw47710wZCF7+T9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geSQrmPS18ztobLrMHF0zzhBNoMrxH6I4E2wTfNHsKU=;
 b=d3hqobzXUNhs12fLpFeXMCvJgRFNZNfMPxFnqf0aoKpvJ6u8h8YZgnXyCnqyd4bTAKvs8dOy7jQzGemoPtrpPv8UwBUA89Le0GqBQuU61PJ6mT/i1IJJvz92c6MQ6OpDmpTfVOQfGj9QRMj3hT1Vz4zYsBBvNUzdmQjNqisAPwttzeNGoaITuOqqfGQ1SqvHcyjaernUuis2Ew3/914I4iNFenxYZeYMCO0CzLYBnHhVuxS0+1TAWLl93rCvJGmMos/bYIdEEl4B768gQTiGmZcfLdoq8ONMWPRMYe9eyZRV0k2ISAaEUNCiiJ5Q1+bpP4L4vASSfOU1U5msCktHMg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 09:16:08 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Mon, 30 Sep 2024
 09:16:08 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/7] arm64: dts: freescale: imx95: add various nodes
Thread-Topic: [PATCH v2 0/7] arm64: dts: freescale: imx95: add various nodes
Thread-Index: AQHa/dAkdX29nW9v30KFr6z0i1F8R7JwNs+Q
Date: Mon, 30 Sep 2024 09:16:07 +0000
Message-ID:
 <PAXPR04MB8459BB997B57673198110EA488762@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240903-imx95-dts-new-v2-0-8ed795d61358@nxp.com>
In-Reply-To: <20240903-imx95-dts-new-v2-0-8ed795d61358@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS4PR04MB9436:EE_
x-ms-office365-filtering-correlation-id: 8544dfdc-4f43-4b79-4562-08dce13084b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OUlxWjhSUmpJSTk5K2R4ZW5ZdlJxOHhoUWtHY2V4TzBQbmNUOEJlRTQ3eUlC?=
 =?utf-8?B?NlpNMFRXc29Rell1cTA4THZseDc3akN3VkdJWTZpMnQ4T1lEdmNCZXFjSjF4?=
 =?utf-8?B?Y21FK0doRzBKM3BKYXFPUHVMTGxaWmFWZ1A4V3p2NjR6OWNtK3JwYXJ6UjFH?=
 =?utf-8?B?aFpxS280NDNSTGFqRE0zcHJiU0h1ZW16RjFPUGhmOXVGbmR3SldUcy9TQ1I0?=
 =?utf-8?B?Q2pGVEtsZlp1LzNob0RxVzRqUmhiZEYvVGZ3cEJVSFlrcXdlR09kZCtQVTFm?=
 =?utf-8?B?ckUvRy9KTWRnNUtiZUhVWXN0dzJ5dkp6NFNva1N2cmd1WGFJN05RTFpZNlB1?=
 =?utf-8?B?WHk5ZlY3bnpSYlh5VmxRQlhMcEZ6bU1LbEZibkdtOGZxVTB5amJjcm9RVVhB?=
 =?utf-8?B?dmIzOUdpczVMNk14cVlVSjBjMWtoU3VCYUlUTFpIY2pEWVpsZWxRZ0phU2tY?=
 =?utf-8?B?dHo3eER6MjY2RS8rWWZJZEJoMFpUanpTeDdQaVBaMkFpTVN1cXhWc0NsV1g0?=
 =?utf-8?B?SGRJWm91enhNVWNXelNGdzhVZ1E3dmptV0RiK0Q1SzNVcFkrdTVEZmI5RUx6?=
 =?utf-8?B?K0lzZG9WVWw4K2NacFhDQ25Ya05qbjlRSjhMRGdOSkdaWWtWTkVlTW54WXU3?=
 =?utf-8?B?ejlMMGZZV2lNN1RNbmhQL3RKTTZPTHhXMHAwNEhEbFBiLy9HdUpOajZOS1BF?=
 =?utf-8?B?YW1VQ09qRnFlaWRLTnA2K0tycWlzUU1GeEJIeUE4N0VCZk9hQXM0bEg0R3gr?=
 =?utf-8?B?UHNOMFdaOFdiUmRtODBnTlNJZVAwWktwbG1hMTRKQTlIem41NDhxZWRzYkhB?=
 =?utf-8?B?WEFIaTZGV1BxWm5Bbnd6K01XTjdpRW9pN2o1Rk9yb3BxVitmQWs2VzhyQVpN?=
 =?utf-8?B?cUJPbXZzdllOSHFWK05wTFc0T3lEUXVqM1M0a0NmaTVGWWFTUStmTG51dm9p?=
 =?utf-8?B?Qk1maThRU3VZckMyVXA1bWpmdGFsWkp0bGs2dWk5ODlZMldlcnFReHNxc1hI?=
 =?utf-8?B?YjZJM3JMa2gxNTZkckFKdWtpNjExd2gwU3lkRFgwSTRzeWpGZW1iUXZuck4x?=
 =?utf-8?B?UGRLendvUUo4bk1wMktVZ3N2S3g0RkNSZ29xMDhndFZSVk1WcUZLL0I2YjNM?=
 =?utf-8?B?M2VCeThGRFlmR04wU01MSlhycDVESHVtUnJMdE1sMTFPaWVpQ0dJeDl4Q2RF?=
 =?utf-8?B?R3kzQ2RnTnIxUmtUWmxsM1l0MzRCbXBYTDNISllLVlU4eHlXaUdzQ0NoTTFK?=
 =?utf-8?B?eUl2SzRnazFPRVEzWHA0cnBoSENna1dVcitaUTArcXg4dWJZVjZFZThqeGRi?=
 =?utf-8?B?ZWpJK1NscE4wNmhsMGVEZENpajhVdGlaWEtVT0dDUm5Pck1xMSs1U1lyalEw?=
 =?utf-8?B?VGRIRElWMmRZcmNZYXl3K09mL2YyQXVHOGlPL0ZIRUpGTmNhVDNPamxycVAv?=
 =?utf-8?B?Y1dSQ0JJa0FJRmwvMlZ2RnlNeW9ybGk3R1U4NEtjcU1NbENsMmZzUzM2VXJC?=
 =?utf-8?B?cVQxMVIwT0hrTUxzSFpod2pCa2R2ZUc0VTRIOE1lbWd0akd4VW5oanpIb2tI?=
 =?utf-8?B?ZmJodTBJS1ZhWndyUzcxNFJvWndNMlZOcVNtdGh1Z2dzakhDNll0ZWx0eGg4?=
 =?utf-8?B?eWQ4V0g4VS9USVc3QXppYzArbU5JM29yRDVBZHNEVUpOMFdvN2JpMFRXem9n?=
 =?utf-8?B?VGhhOWdQL2dhL0hybXVjS0pCZDVsVmQ2M0twRXpuS0h2YWI2Qit0b1hhVGM4?=
 =?utf-8?B?aGp2VVpUQnRibDBxcWY4TGpwcGMvSzN1alNsRlUwVW0yNE9ZUVJkK1dzVW1D?=
 =?utf-8?B?K1E5MGhhTGNMa05xU3liTFlnMi80bFIzMVpTR2lvdXZWTDNKQzhmVUpreksz?=
 =?utf-8?B?T2dSeCtraG92RFB2Y25GcTBNMnZtSmVUM3B6ZTRZMXRhS2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VTNlV04zc1g0TzRZLzZqYVdzTC9seGFSYXZ0Qld4RTl0aUpzSVZxY0MxeXhv?=
 =?utf-8?B?RHlNRVBkNXNFZG1BQ2o0Vm4vVkZnV091NHN6UTJKMEZGbXkydnNGbGRxOEZp?=
 =?utf-8?B?NGdMaUtHYVRiTnE5ZmlXQ0dFNDhhUmRlczByZnhCNzdBamlwZ2VORmJwK3I1?=
 =?utf-8?B?UDRhQ2paSnBmU2lOeEZ2M3Q5d0cyaWxuZVlidzR3WGhDeERXakxsUlJLN0hw?=
 =?utf-8?B?aUM0MHQwb1Vvb3NpQVU0Nk5vOFJ1VjJkc0w0djRYSkpSMEQyRU8wa2EzRGJr?=
 =?utf-8?B?ZExhQktpOHh0SnVyOE5VMTBkRDZrMGFxKzd3cnFCQ3JFVzlrdTh6Y1FqUlFT?=
 =?utf-8?B?Tk5WMGtOTWtTYnl4MmtXVDNDWFlUdkd5Z2hVMmZtSEdLTzhmWnNKRVU4RnhV?=
 =?utf-8?B?ZDYyNmYwYWRPc0tKUDdYa0Y3TGlXejdnNDVDR0dTZGlLUVArelF2ejZ4TElh?=
 =?utf-8?B?My9JZ1FNNUpSRlhKbVIzNWZxMEFvcnJzbk5QMWF4eUR3cWF6eFduVElwVS9w?=
 =?utf-8?B?NDcwRkdzMlNIU2o4QXB2T3o2TUxMbi82cE9aODB6QjI3QXFidlMrMTM0MCtT?=
 =?utf-8?B?eTNnK24wOGR0Tm1yMzFvaTZUdnZCZ2docGY0bzhMNkVOOTdpTWxBUC9iTm1k?=
 =?utf-8?B?TG0zcEJ1NmoyZ2pKYmlaVFh2dFZJR2orQW9WT2FjQVlDRzdhbkxMTHRUQVJL?=
 =?utf-8?B?WUcwWkNLT21PaW9iZUJseTE0TGc2N2Z1KzZFZjlrWVZtR1lxNFA2WkEwbXVS?=
 =?utf-8?B?QkhoUE5XZ3M4U0F0N200VS9kby9KNU03YTVQMUNOcjJlbUFOVU44bjlNOHRN?=
 =?utf-8?B?RmoxY2N0YW5vOUsvaVRlYjBUeDJOOWxqbExsVXFYWHp0enp2djlyYVBJNjZM?=
 =?utf-8?B?SDJVd3Zub0F2bmRhMExKY0tIc1pzZk9VdnhRTVE2eTdoaHZRa2dUOWlPYVo2?=
 =?utf-8?B?b2c0ZFBzYjlDUGhicTk2U2dMUWZPN2NGS0tHbkNwUFRjV0UxL2U4MjhtWUYz?=
 =?utf-8?B?bXh5a1NDMVNob0hUZ05ldG1Obm5rTE1VOHZJeEYwMjJjbEh4eENKelV5ck9j?=
 =?utf-8?B?Y3dGdVdKQ044OVJyRlNoa2JDSkRta0FtQ3ZaQklDRUszWWxsRk9tZzA2V3FB?=
 =?utf-8?B?ZXB1UXZjRGdtTDRBdTRwTkdOanNKVUV0Z3l2STdISGwzdE1YaXdLeFNxb3ZQ?=
 =?utf-8?B?bzVranY5b3hjYnNxcHNtQVhnTzlpNTdjdmVFbU5oZDFLTzN5TjFpSzdVcWts?=
 =?utf-8?B?MzVQMWEreWJpQTF3RnlreXBXRi9iV0h4NUxmRkhGeGZaMEdIbTBEb2FIL1hq?=
 =?utf-8?B?ZW90RCt3b2VnbFk2ellkWThHZDlIeTRjbFUwY2k2bEY4dy93VFhBcFRDTDBj?=
 =?utf-8?B?RjVKSndoRHBCOHQ0NjY1emF4SWJFQ1Vmay9yV0NqTVUrUit1d204WHMzZE14?=
 =?utf-8?B?ODl5Vkc0UXFLZ2Y2OG0rMFVqZldybUgvV3R3RWJya1YwOWd3OVZQbWtzL2xr?=
 =?utf-8?B?THRRT2FJQVNZTkozOWtMWmxYR1VCQ3NjTWYzK3lmOERYbXpDVjNWZVF0NC9r?=
 =?utf-8?B?Q3FoRVZCbUxnRjI4WDdnNkRUdDZVOHZrLzh6Qk45bFFSbUJ6di8zQk02N2x6?=
 =?utf-8?B?ZFFXWm8xZnRmUVpDZWZTd0Y5M0hZZHExRmlTcjkwS0g4dUpRQU1jQlFJUzdy?=
 =?utf-8?B?Y1ppMUZqbzQrdWFTY3o1NGx3SDU3enRHUDk4UjVJbXJNaFdSNDNUVFdnSy9S?=
 =?utf-8?B?R0lmbG1IcVRxN0YwMnYxS1JISWhmZ0FES1owZjlzMFNycWsrVVBaZ3NPTGpO?=
 =?utf-8?B?SXh4dmluMlQrRnl6TzNjcU9oSkNLR1lVbVY3M1U3VjhIODNzNFNJUFN6c1RF?=
 =?utf-8?B?d0hVSENRdENZak9ld29LcUtDSG4wVjN3N0VZNkFQdTVzbFN4QWhwUTZNVTZG?=
 =?utf-8?B?elZOSHdIYnp4WTk4Y0VZZEFCSVhyYlUwbzkyWUEvVlhmNDgrQW9neUV2d250?=
 =?utf-8?B?bTdLQ3NEOENNZ0RoR2c0NDNMakkzZytWaVN2VGUzcWlNQW5yRG0rVVIzZ210?=
 =?utf-8?B?ME5LMDdVTUN4Y1ZJSWZ4OVpSeThsRFVqTEVkL1RDdVdDdWRPOTRqeUV4aVhJ?=
 =?utf-8?Q?d/X4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8544dfdc-4f43-4b79-4562-08dce13084b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 09:16:08.0593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3XvSA4uwxLTL2TFx76W4FgmHlHWRK7ySDDA9+Z7bSGc0+YFtTWzYRBzeE0/MXj8R+RxioiPOzqrB+Dvn6bhSgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9436

SGkgU2hhd24sDQoNCj4gU3ViamVjdDogW1BBVENIIHYyIDAvN10gYXJtNjQ6IGR0czogZnJlZXNj
YWxlOiBpbXg5NTogYWRkIHZhcmlvdXMNCj4gbm9kZXMNCg0KUGxlYXNlIHNlZSB3aGV0aGVyIHRo
aXMgcGF0Y2hzZXQgaXMgZ29vZCBmb3IgeW91Lg0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0KPiBQ
ZXIgc2NtaSBiaW5kaW5nIGRvYyB1cGRhdGUgYW5kIGkuTVggZXh0ZW5zdGlvbiBzdXBwb3J0ZWQs
IGFkZCB0aGUNCj4gbm9kZXMgaW4gaW14OTUuZHRzaS4NCj4gRW5hYmxlIGNwdWlkbGUgZm9yIEE1
NQ0KPiBBZGQgYW5hbWl4IHRlbXBlcmF0dXJlIHRoZXJtYWwgem9uZQ0KPiBBZGQgbHBpMmNbNSw2
XSBpMmMgbm9kZXMgYW5kIHN1Yi1ub2Rlcw0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4g
PHBlbmcuZmFuQG54cC5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIFVzZSBnZW5l
cmljIG5vZGUgbmFtZSAiZ3BpbyIgZm9yIGdwaW8gY29udHJvbGxlciBpbiBwYXRjaCA3DQo+IC0g
TGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0MDkwMi1pbXg5NS1kdHMt
bmV3LXYxLTAtDQo+IGExZjc5OGY0Zjc0NkBueHAuY29tDQo+IA0KPiAtLS0NCj4gUGVuZyBGYW4g
KDcpOg0KPiAgICAgICBhcm02NDogZHRzOiBmcmVlc2NhbGU6IGlteDk1OiBzZXQgbWF4LXJ4LXRp
bWVvdXQtbXMNCj4gICAgICAgYXJtNjQ6IGR0czogZnJlZXNjYWxlOiBpbXg5NTogYWRkIGJibS9t
aXNjL3N5c3Bvd2VyIHNjbWkgbm9kZXMNCj4gICAgICAgYXJtNjQ6IGR0czogZnJlZXNjYWxlOiBp
bXg5NTogdXBkYXRlIGE1NSB0aGVybWFsIHRyaXAgcG9pbnRzDQo+ICAgICAgIGFybTY0OiBkdHM6
IGZyZWVzY2FsZTogaW14OTU6IGFkZCBhbmFtaXggdGVtcGVyYXR1cmUgdGhlcm1hbA0KPiB6b25l
IGFuZCBjb29saW5nIG5vZGUNCj4gICAgICAgYXJtNjQ6IGR0czogZnJlZXNjYWxlOiBpbXg5NTog
ZW5hYmxlIEE1NSBjcHVpZGxlDQo+ICAgICAgIGFybTY0OiBkdHM6IGZyZWVzY2FsZTogaW14OTUt
MTl4MTktZXZrOiBhZGQgbnhwLGN0cmwtaWRzIHByb3BlcnR5DQo+ICAgICAgIGFybTY0OiBkdHM6
IGZyZWVzY2FsZTogaW14OTUtMTl4MTktZXZrOiBhZGQgbHBpMmNbNSw2XSBhbmQgc3ViLQ0KPiBu
b2Rlcw0KPiANCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDk1LTE5eDE5LWV2
ay5kdHMgfCA4Ng0KPiArKysrKysrKysrKysrKysrKysrKysrKw0KPiAgYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvaW14OTUuZHRzaSAgICAgICAgICB8IDY5DQo+ICsrKysrKysrKysrKysr
KysrLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxNTMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4gLS0tDQo+IGJhc2UtY29tbWl0OiA5ODViZjQwZWRmNDM0M2RjYjA0YzMzZjU4YjQwYjRh
ODVjMTc3NmQ0DQo+IGNoYW5nZS1pZDogMjAyNDA5MDItaW14OTUtZHRzLW5ldy1mYmI4YWM5ZmNh
MTgNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS0NCj4gUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5j
b20+DQoNCg==

