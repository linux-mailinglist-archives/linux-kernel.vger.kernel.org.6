Return-Path: <linux-kernel+bounces-530329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442D9A43214
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6952E7A1183
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA2D5C96;
	Tue, 25 Feb 2025 00:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eDWgLWn/"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2189D2571B4;
	Tue, 25 Feb 2025 00:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740444552; cv=fail; b=bTaErcmkW6+zeXf1HlMg/B0bgJ7xMdX2Cu2rEuba2V35T5DJzCNlLW+lxgCCwQTO9M4zpc2H2FrUxtcO5eWIDYEH5ZhaD7bZJC9eu1vTIoDReipjbop1JDD6NdWOTo8y7vFQmWu6GRxmUlhRa2E5+QgdxFUlkIss+wDk3WzLsE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740444552; c=relaxed/simple;
	bh=C8VXk5mjoLekcnKPlsfIGEPwZwP1pED8bcexCI3BNHA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TpBM8aqBymKSbAjfTzrLUTbOICpzr1tHioIO2EdQXl6Z2cnkwTYXxD9wJN1uDNIWG9N9H/67Kx+pNStCdy7feOS9gOJUkmr4eO7Z7MK8N5RBOy8TvGN45M5OraeLpFs6eC83L8YoOTOostOYwNSAAv6qNehoX+mlEWvHW3gxpqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eDWgLWn/; arc=fail smtp.client-ip=40.107.20.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aa5hMBkS6d/2ZgSOdAbzAepZ9m3h6ZC0s5YrVr4upmZ6su1EYrXLNET0XqwKXP6sMkUupZMpAGp19jrcYg66Cv+g3DMvBujCvX9zds7YgBIXKP+6MchGK3K3BTtfH4ZpgV/zwWYAhwoWQIkE/J4w00y7iK7ID6ah0ZEGt6f20QU3XSDSua1FZMYznE7FsCBkiIAe11CX6L5IvvbM9NPKNA6CN8MimJxwHs/rC1JMIzzfAQty8T5dkbhdKZLrj53nv2AThOUHt1/Yf+EYurCfExLc3NAphiNDQQfBNxnK3WLOZhe7F3/Hx7fdoy9NjewueG85IVASEvMmMo473Pgqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8VXk5mjoLekcnKPlsfIGEPwZwP1pED8bcexCI3BNHA=;
 b=KTASXP/dXJ49QN4fxCT6qqwJ7Y0+SLJBUBe4Llv8ZUg4gRtX+aZloVxFctqwsyvt2rmA9H8bg0aZxbwqmQGROjn3K6nUZatCgNCIS760Mtqhcuvx/vOzxsyEw6wVLBLs18Cjbym03618JUtHQDnM+CND+HI9VLr0hkWupTGVWdms2/IoCVpL4PpGB0TxrXDv0uyvNl4I1BxmOihOX7ayd6SbslDj6bSphnpQlyCFfDMdjoaZBtQsNW3jkYquTZZmHLv01T/QUitLLc6WX0QytBIPaUZlU8bKrSb8hCKOQ2f7L54xzb+XfDP/PsqyLFpugZqkxort7cXKRjG4kgzSWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8VXk5mjoLekcnKPlsfIGEPwZwP1pED8bcexCI3BNHA=;
 b=eDWgLWn/TebDSaRzzdhFyaA4WsUqSi+09C9wjeL9VKNp821BDl1SADDK4/VYXG79aMCY4MernFQk7Za8HEmw/PecQW8W0Iw2IqWoTDzSemtRmfzAnNc4mHB8TRRZWc2WuaTpHpdwF9UnvLK2gJU5q5wMTSMjNakJ71GmifJ7fsdEi19zXbXprVMfh3cJTbgiA4Q9jBwktcyWEeD7Ct+GifRHVPXXGI01EsE2qHIr8TewOUdGK4gogcL1BRHutJAXmMhJqVqShgrcSDWRnvUAJPeREwKb+INrV+ZTEUuMskDDxFd/0xCA6Kk9FIHn0dKZ4r4p/NtdJEts7CtV6cOFTg==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PA1PR04MB10604.eurprd04.prod.outlook.com (2603:10a6:102:48e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 00:49:07 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 00:49:05 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Frank Li <frank.li@nxp.com>, "shawnguo2@yeah.net" <shawnguo2@yeah.net>
CC: "conor+dt@kernel.org" <conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "festevam@gmail.com" <festevam@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>
Subject: RE: [PATCH 1/1] arm64: dts: imx95: add ref clock for pcie nodes
Thread-Topic: [PATCH 1/1] arm64: dts: imx95: add ref clock for pcie nodes
Thread-Index: AQHbht6txsW9YLGHQUOuDc8LgvzrVbNXMClQ
Date: Tue, 25 Feb 2025 00:49:05 +0000
Message-ID:
 <AS8PR04MB8676E28107F0F5E2D4577EF88CC32@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20250224170751.146840-1-Frank.Li@nxp.com>
In-Reply-To: <20250224170751.146840-1-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|PA1PR04MB10604:EE_
x-ms-office365-filtering-correlation-id: b38a150e-9f48-4845-d951-08dd55363465
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?gb2312?B?R3RRdEdCL0tEY3ZIdzFxa2JOV2hDNUliYXBwQkdNRld6enhpc2ZtWG9mZHMv?=
 =?gb2312?B?OUcxYzNuMjJTYWhKVDJQeXU1YThsWFBGdVk4VVFUbGo1Y09UZytYVlVNbkVZ?=
 =?gb2312?B?dGJBazZZYXkwRlFmYmFwQnZEZGt3RHNXNDM5MDAxeDdBdVVCMlo1eFZtb3lD?=
 =?gb2312?B?Y3AyY2FNcHg2eGJmME5PTUZpOUZuTEFMc3N4R0d5YnRwZUpIOFBkYldMU3Mx?=
 =?gb2312?B?amdPUGI3MWM4VnQrMjBwTzBrQkJiejMyOWd0V0MySUdpRFhqTVF5WnNNaFp3?=
 =?gb2312?B?Nzg0VldFd3ZqdW5DcnJ3eE8wbFZKM1g4VWs0dDFnakk1bHZ3ZEtrVWN1L3lM?=
 =?gb2312?B?Y0pKR0NsZTBuWUNudFpnWDNkWURLVU83NVFxV3dIMjJrMkUwaEg0MytlY0pV?=
 =?gb2312?B?T1J5c1VxdTdCcElpMWVpUGlVY2lmVUZPbGVKNmw0RTMzL3MxMkZoS0J0UDVF?=
 =?gb2312?B?WU9wNUlobGVlN0Voa1MwWUE0L2JDTUZvMDJMVDlNdEFxMUI3dXZ4SGVsTHB2?=
 =?gb2312?B?OEFjNU1rMFgwU1g3cXR0SkRWY2hGeUI4T210bTRDN3cxRllWUWRUQjhkZExi?=
 =?gb2312?B?Y2xFYVZpd2Y3d3ZsTi9raXpQQXJTOFhwdXFrRktCbCtUSVJIRUxPVlRsVWVF?=
 =?gb2312?B?cnFjcjkxY004ZXlIUFp2M1pSWHJlUC9XU3dIajg5aEV6dHVpNWJ4aFlTdlYw?=
 =?gb2312?B?cEYwZExBVS9yWGw3Rmd6TEM2VWt0Vm1HSHYyTDBrZ3VKTUVMT1hLNG9uNVdQ?=
 =?gb2312?B?OHY5bnN6bVYxeHdvOFlwdnBCbVVwUlg4aHUzNmtNaEhQVldOZGk4ak16OG5z?=
 =?gb2312?B?M1U4Wld0QmNOeThEbHJiTHZJcDBydVU3Q1VpNkN2WUNNbFZObHdVWE1WcVlL?=
 =?gb2312?B?UEtseHVDemVSN0ZzV3lYWVlUZG0vb2hvbzVjeDQvRkxmUGZ4eG9OZzcwRWRP?=
 =?gb2312?B?dUx6RW1VQkIzZ2lidXc5K1hiWkYzODVhNDNoQmVkUmFTUm9IR01KUTVkWlli?=
 =?gb2312?B?bWdnWmRPMHhQbHhnbEdYQnk4VTZMQTEwTTB3R3JyZEhwYytPRjZjd0R3V2o2?=
 =?gb2312?B?Zmg2RXpkS3BKeUFMck5pYnFNQ0QvcTMrSzBGSmdKdGVGSnBCb2NyTzFKeENo?=
 =?gb2312?B?Y284bElISHcvQjh6WkFUVnRFcnY1YUxsTFpQRXFwOWRkVGxMZUd4dHBIeGo5?=
 =?gb2312?B?VlU5SS9RMnRacWN3V3djNGpBcVVXcWFIbElsZnJhOEtoOTNwRmRkRjMySm56?=
 =?gb2312?B?MU4wRkVBNHpTRktsTVdyMkxvcVNHa2UrdFdpMHlVbXlIQXBiamYrNmFEMFgx?=
 =?gb2312?B?aENNNWFaTEU3M0NrYlhWTm9TNzRyQzJNZytKWTRFbjVVR2lyWlRBaWJBNm90?=
 =?gb2312?B?S3QycmVJd0hLV0U5em9PZTNyYVNrUjdnZS9WTmtKY2ZDZks5bnJTdjFna25L?=
 =?gb2312?B?YWxRQmpURkd6MGh0MU9oVU5YamNqSkVVT014SmRUWEhuSWxSNFNTa3I1d0d0?=
 =?gb2312?B?ZVg2ZHBCYWlIQzVuaHB1V05xTTFqbDlKZXVJNWE3NkpzM09jdndqZ21pR2RB?=
 =?gb2312?B?Sk9MeWFjQW5QRWVtSGR5ZGs1UkNvck9BdGduclpzV2EvclZoa0tpQnZwUVpy?=
 =?gb2312?B?QjJyL0RJN25PeDVIRlBTVittd2JWejFMeGI4NU1xYXFZWjZPVWJ1SU5lYkZv?=
 =?gb2312?B?OFlEMXU3Q0NpY2gyZG8xVUhzeFBCQmRNd2Ird215WVVTUk93ZHZDODdoajNw?=
 =?gb2312?B?Q2taN0o3cGdUMHhGSXM3WmRlZ3EyTzRkYjY3blc1cmZKRkJ3enM5cEZVeDFy?=
 =?gb2312?B?RGwyN21VRFpHUHVGNy9aWHU1Z0FFNlFQV2RxMS9QMnQ5TFZ0Ymw2SFZhUXJZ?=
 =?gb2312?Q?alODDXHdC8Cpk?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?RmlWbFE3ZG0zYnB2QkMybmltQ2ZqeExGN21GUXBjL0VCL05lR3M5YldMNWh1?=
 =?gb2312?B?a0hVOFlTeFFxaDFGa2V3dzhFc3VoUnFhMmw0ZHpqZVp6UDdrYjVCYWxVdlJE?=
 =?gb2312?B?RlVQZTlMa01lT2F6c2kxelVYNnQyKzlrUkZ5dnZKeU5pQUpKaHkrQkJOUlVG?=
 =?gb2312?B?QlA3Z08wckh0V3p0eG82RTBQbjJkOGRQcktoblZ5NVBmQjlpSHBWSStoWEc4?=
 =?gb2312?B?SGVNNmVBS1F1aG1KSmxVQ2E1akpwQndHTDJ5MWhwQVhDNDJOSldVcnlRcVVT?=
 =?gb2312?B?MGtGaFg1VE1XbGVQWWxwMm5kVThMTGlRTzF5dWo5eXNGMWpUdHpOK0xyNGRL?=
 =?gb2312?B?OG82QnM0RGJ3U21aOFlrSXBHa1F5cEo4MTRWY2ZyZlA3T2RMK3hBV2luckNC?=
 =?gb2312?B?a0thY3NQS1NyUU9CU1pCcWlrRHMycW1ycXVYNjJoRmVRakVPeDFzN1Z5UDBK?=
 =?gb2312?B?SUFFSy9kSDdycXhaWnNWNC9PbXNBTzVWMlRKb3IvZGJYWTZjcFhWOHB1ZjJU?=
 =?gb2312?B?WlRBTlpIeVpYT01yQWU2TU8reTRDWkRWNzVhM2VuRWxRZllQTFMrZVpRaHFB?=
 =?gb2312?B?VmdlWlZCWWdzWWNsWDdMZEtiY0c0NW1CRmd2YjdPRG9VSGNtOERPVWN2YWZE?=
 =?gb2312?B?QlJXTVFHZERvdWIzTC9NVjhLTFRNUEIxa1ZhSklJWThFNkZJb0FxbWFCK2Rn?=
 =?gb2312?B?ckJBYi9TWHd1bjYyLzhlQXZPNnZTSXY5cFg4OGFFM1FHM2c3d0k1aTllYmth?=
 =?gb2312?B?V3FHZUloQ0QrdmRvNVllMlFrSUo2VDh1R3ZlUk44d3crSlJXSkZZbFQyS1lR?=
 =?gb2312?B?UUJpN2RudURyTEptNW41NStPemYwK0lxV0NLcWZWNTZjTWt5ak1zbmVGM01U?=
 =?gb2312?B?cE5IY3p0N1FUWVUraGk2ajZBNlZEMFFpVHUyMlEra2hLUHo3S3gvS0VJNGEr?=
 =?gb2312?B?UjJRN2JWVWk3V2FYUlZ4K2crN0NFTWl3d0E0Slp6Ly9Ra1VJZ0NNSUZWcmM4?=
 =?gb2312?B?MUw2ZjM1UVVPcGxCc2dqRmtubHg4cXdIQ0pudXVXZDJEazFOV1dveUxza1pC?=
 =?gb2312?B?dXE5amJEeVpOL3ZGOCtCbmk4bUxDV2V3SFZWOHU3N3J0MC9KSGZqS0FiOTZO?=
 =?gb2312?B?a3FnRnBVVWI3TE5SRnlmdVRZRzQvL2JKWUNNdHpMeTRMTk4vUExINDZGMGx4?=
 =?gb2312?B?N0xUeUVkN3M5NXhkNG1qQ0ZEYzNMMTBXQVFGblBoU0NTVlpycy9QVHFaM2VO?=
 =?gb2312?B?cGtXVitReUhJLzNCVG9PSEQvRGQrbDBJYVdRcmRINFFuQWh3Mkt4U1RienJC?=
 =?gb2312?B?aFlOSEFVSlJEUEdmRytLQ0xkVnZOQnc2UXNUdU1HengxTUplYjB4Q2RJUWtm?=
 =?gb2312?B?VDVEeEozYjRWdzJ3ZzFUMlpQOERwWjB3SXg2QTkrazRmeVB4dEJySmlUUDRI?=
 =?gb2312?B?YW5zSitDOEdVL28ybWoyZXQ1NHNmMW94KzEzdTJsZ2pLUUR0TUxCT0pzaE5u?=
 =?gb2312?B?UG83b0lsT01IM2ZVNlhhUmhsMHlBVnhTTmZlTGlRY3FXc04xbkNBSEx2RFhk?=
 =?gb2312?B?eVh0VyttYjRJNDlPNzVFMFNvOWtUQ1liRW5XT0thbGM5c2VEL1l5dklKazcx?=
 =?gb2312?B?ZkoxS21YcFc0YUV0UXFHbU5zQlBZRlZ0Vys1aUFPcEZ0WTdZdk5yU2hZSTB6?=
 =?gb2312?B?ajNsYUVXSmxnVDdpZWczblFnRjlWQTlEL2VCWm1sNlg4ZG1QeWg5NTl2T1NQ?=
 =?gb2312?B?VjB6T3FiREM3YWxZRDBxSXR6alpmT0pSNWg5OCtSUFowUm02RWRKM0Q2Yk5U?=
 =?gb2312?B?MHBndDVSVTA1bnR0dU53ellKb0J0WUpxenNxWGlONmFKSUovVDcxWjhZaDhJ?=
 =?gb2312?B?SmdzZkZnNXVLMHdVZEhFc2FDK0dBT2dkOUZ4SWh4Q3draFZYeGZ5RmtmdVNh?=
 =?gb2312?B?cW9pend2dHk1NmEvM2hIWS9GYTRWUVZYaG1NaU5ZdmYrSXdMMjJ1UEx5VXpt?=
 =?gb2312?B?aXdVSWdBaFlWSUdMSFNIU0lTYlBFY1ovd1YvcmpBbGh6YWZ3M3RLTFpVYzYz?=
 =?gb2312?B?ZGF1V0JmQlc4c3JuMHBiTys2cjFJT2VSQW56amdJUVdLYjcvRDh1bXVpSWlV?=
 =?gb2312?Q?dz/H9jvlmPq+3EXh8BATj5dim?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38a150e-9f48-4845-d951-08dd55363465
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 00:49:05.1914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C4pExDI94tHVr5fjW+thIq/p3gv8Pbq4fMSDG2M6Wi3vZuJo6xleVtSfe4OxiCbhTjqrFtBbIR3vRfyK7k13bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10604

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNcTqMtTCMjXI1SAxOjA4DQo+IFRvOiBzaGF3bmd1bzJAeWVh
aC5uZXQNCj4gQ2M6IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPjsgY29ub3IrZHRAa2VybmVs
Lm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGZlc3RldmFtQGdtYWlsLmNvbTsg
SG9uZ3hpbmcgWmh1DQo+IDxob25neGluZy56aHVAbnhwLmNvbT47IGlteEBsaXN0cy5saW51eC5k
ZXY7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4ga3J6aytkdEBrZXJuZWwub3JnOyBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IHJvYmhAa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj4gc2hhd25n
dW9Aa2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0ggMS8xXSBhcm02NDogZHRzOiBpbXg5NTog
YWRkIHJlZiBjbG9jayBmb3IgcGNpZSBub2Rlcw0KPiANCj4gQWRkICJyZWYiIGNsb2NrIGZvciBp
Lk1YOTUncyBwY2llIGFuZCBmaXggYmVsb3cgQ0hFQ0tfRFRCUyB3YXJuaW5nczoNCj4gYXJjaC9h
cm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTUtMTl4MTktZXZrLmR0YjogcGNpZUA0YzMwMDAw
MDoNCj4gY2xvY2stbmFtZXM6IFsncGNpZScsICdwY2llX2J1cycsICdwY2llX3BoeScsICdwY2ll
X2F1eCddIGlzIHRvbyBzaG9ydA0KPiAJZnJvbSBzY2hlbWEgJGlkOiBodHRwOi8vZGV2aWNldHJl
ZS5vcmcvc2NoZW1hcy9wY2kvZnNsLGlteDZxLXBjaWUueWFtbA0KPiANCj4gU2lnbmVkLW9mZi1i
eTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+DQo+IC0tLQ0KPiAgYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvaW14OTUuZHRzaSB8IDI1ICsrKysrKysrKysrKysrKysrKysrLS0tLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTUuZHRzaQ0K
PiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDk1LmR0c2kNCj4gaW5kZXggNTE2
MjViYzkxNTRlYy4uNTgwMGEzODEwMzZiYyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvaW14OTUuZHRzaQ0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg5NS5kdHNpDQo+IEBAIC0yOTEsNiArMjkxLDEzIEBAIHNhaTVfbWNsazogY2xv
Y2stc2FpLW1jbGs1IHsNCj4gIAkJY2xvY2stb3V0cHV0LW5hbWVzID0gInNhaTVfbWNsayI7DQo+
ICAJfTsNCj4gDQo+ICsJY2xrX3N5czEwMG06IGNsb2NrLXN5czEwMG0gew0KPiArCQljb21wYXRp
YmxlID0gImZpeGVkLWNsb2NrIjsNCj4gKwkJI2Nsb2NrLWNlbGxzID0gPDA+Ow0KPiArCQljbG9j
ay1mcmVxdWVuY3kgPSA8MTAwMDAwMD47DQpzLzEwMDAwMDAvMTAwMDAwMDAwDQoNCkJlc3QgUmVn
YXJkcw0KUmljaGFyZCBaaHUNCj4gKwkJY2xvY2stb3V0cHV0LW5hbWVzID0gImNsa19zeXMxMDBt
IjsNCj4gKwl9Ow0KPiArDQo+ICAJb3NjXzI0bTogY2xvY2stMjRtIHsNCj4gIAkJY29tcGF0aWJs
ZSA9ICJmaXhlZC1jbG9jayI7DQo+ICAJCSNjbG9jay1jZWxscyA9IDwwPjsNCj4gQEAgLTE1OTUs
NiArMTYwMiwxNCBAQCB1c2IzX2R3YzM6IHVzYkA0YzEwMDAwMCB7DQo+ICAJCQl9Ow0KPiAgCQl9
Ow0KPiANCj4gKwkJaHNpb19ibGtfY3RsOiBzeXNjb25ANGMwMTAwYzAgew0KPiArCQkJY29tcGF0
aWJsZSA9ICJueHAsaW14OTUtaHNpby1ibGstY3RsIiwgInN5c2NvbiI7DQo+ICsJCQlyZWcgPSA8
MHgwIDB4NGMwMTAwYzAgMHgwIDB4MT47DQo+ICsJCQkjY2xvY2stY2VsbHMgPSA8MT47DQo+ICsJ
CQljbG9ja3MgPSA8JmNsa19zeXMxMDBtPjsNCj4gKwkJCXBvd2VyLWRvbWFpbnMgPSA8JnNjbWlf
ZGV2cGQgSU1YOTVfUERfSFNJT19UT1A+Ow0KPiArCQl9Ow0KPiArDQo+ICAJCXVzYjNfcGh5OiBw
aHlANGMxZjAwNDAgew0KPiAgCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OTUtdXNiLXBoeSIsICJm
c2wsaW14OG1wLXVzYi1waHkiOw0KPiAgCQkJcmVnID0gPDB4MCAweDRjMWYwMDQwIDB4MCAweDQw
PiwNCj4gQEAgLTE2MzMsOCArMTY0OCw5IEBAIHBjaWUwOiBwY2llQDRjMzAwMDAwIHsNCj4gIAkJ
CWNsb2NrcyA9IDwmc2NtaV9jbGsgSU1YOTVfQ0xLX0hTSU8+LA0KPiAgCQkJCSA8JnNjbWlfY2xr
IElNWDk1X0NMS19IU0lPUExMPiwNCj4gIAkJCQkgPCZzY21pX2NsayBJTVg5NV9DTEtfSFNJT1BM
TF9WQ08+LA0KPiAtCQkJCSA8JnNjbWlfY2xrIElNWDk1X0NMS19IU0lPUENJRUFVWD47DQo+IC0J
CQljbG9jay1uYW1lcyA9ICJwY2llIiwgInBjaWVfYnVzIiwgInBjaWVfcGh5IiwgInBjaWVfYXV4
IjsNCj4gKwkJCQkgPCZzY21pX2NsayBJTVg5NV9DTEtfSFNJT1BDSUVBVVg+LA0KPiArCQkJCSA8
JmhzaW9fYmxrX2N0bCAwPjsNCj4gKwkJCWNsb2NrLW5hbWVzID0gInBjaWUiLCAicGNpZV9idXMi
LCAicGNpZV9waHkiLCAicGNpZV9hdXgiLCAicmVmIjsNCj4gIAkJCWFzc2lnbmVkLWNsb2NrcyA9
PCZzY21pX2NsayBJTVg5NV9DTEtfSFNJT1BMTF9WQ08+LA0KPiAgCQkJCQkgPCZzY21pX2NsayBJ
TVg5NV9DTEtfSFNJT1BMTD4sDQo+ICAJCQkJCSA8JnNjbWlfY2xrIElNWDk1X0NMS19IU0lPUENJ
RUFVWD47IEBAIC0xNzA2LDgNCj4gKzE3MjIsOSBAQCBwY2llMTogcGNpZUA0YzM4MDAwMCB7DQo+
ICAJCQljbG9ja3MgPSA8JnNjbWlfY2xrIElNWDk1X0NMS19IU0lPPiwNCj4gIAkJCQkgPCZzY21p
X2NsayBJTVg5NV9DTEtfSFNJT1BMTD4sDQo+ICAJCQkJIDwmc2NtaV9jbGsgSU1YOTVfQ0xLX0hT
SU9QTExfVkNPPiwNCj4gLQkJCQkgPCZzY21pX2NsayBJTVg5NV9DTEtfSFNJT1BDSUVBVVg+Ow0K
PiAtCQkJY2xvY2stbmFtZXMgPSAicGNpZSIsICJwY2llX2J1cyIsICJwY2llX3BoeSIsICJwY2ll
X2F1eCI7DQo+ICsJCQkJIDwmc2NtaV9jbGsgSU1YOTVfQ0xLX0hTSU9QQ0lFQVVYPiwNCj4gKwkJ
CQkgPCZoc2lvX2Jsa19jdGwgMD47DQo+ICsJCQljbG9jay1uYW1lcyA9ICJwY2llIiwgInBjaWVf
YnVzIiwgInBjaWVfcGh5IiwgInBjaWVfYXV4IiwgInJlZiI7DQo+ICAJCQlhc3NpZ25lZC1jbG9j
a3MgPTwmc2NtaV9jbGsgSU1YOTVfQ0xLX0hTSU9QTExfVkNPPiwNCj4gIAkJCQkJIDwmc2NtaV9j
bGsgSU1YOTVfQ0xLX0hTSU9QTEw+LA0KPiAgCQkJCQkgPCZzY21pX2NsayBJTVg5NV9DTEtfSFNJ
T1BDSUVBVVg+Ow0KPiAtLQ0KPiAyLjM0LjENCg0K

