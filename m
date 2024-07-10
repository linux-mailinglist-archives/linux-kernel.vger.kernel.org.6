Return-Path: <linux-kernel+bounces-246883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F0A92C86F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 04:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48F3AB22168
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 02:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FFCBA39;
	Wed, 10 Jul 2024 02:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="meO/QgcN"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011038.outbound.protection.outlook.com [52.101.70.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A153219F9;
	Wed, 10 Jul 2024 02:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720578175; cv=fail; b=gJ6pnVCaC0Kgh4MsZ0DE7NdJYWUP8TYD/A42TK6gybXuTF5PLulOJetm1cnMdYiVtQekuDu7lY/Vws6dn2L0c4Ypaecl1HiIoTQvjeswBghGdiKs8rNXxbsDR6oK3dydYcpnDLBtOGxg/DfhRZX48Uvsbn9/5KTKy8ffCgKxNQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720578175; c=relaxed/simple;
	bh=Nf4OOrFGTPt49IHdjrokM6+fYT+eqsYt25sQPPQrydc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uuLtyfiAyj7HsoVIQ8wgsZRrhgsg47JcRdqm+7opB2qfmedg9nkton3s1vbLlGL5pWAN8R8y4nH/Do2WNTj82kQ0BnGsuC6LRJqj38GG55zgPN+WMWzFQqGepQuihd48i0kuEiIPFyVs0NZB+w2v10rdvj3aX0t9f5MQehq20JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=meO/QgcN; arc=fail smtp.client-ip=52.101.70.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDdpOfA7Yfxhi6R5Z99J/ukL+eDl+OqJvuYMvp4TqI9K4MX/otD4nYOTgIhQf2AV04cXGzWi4ARA53wv446jbpVo0WQimsG8SyqouDZMtaFKq6x63oLteu7wV+aUf/RJbRMRyFLFy6WW14s1VT10+6jvSBjuruMdzjLQolrNxJ3IpaP9WG7kxqdrTSedKzEQGKprHG1byQMutwR2VenH50Wrp9XFACPpXOkGmCU8sbVnDsla1dEiCKBX6KPbYj73sRXXZAlky1iDBkFuIL2HLM31L5dDeA3KT7V0ELWwVmON8g5VACak3uTd1k8wWtxx6c7eGnvoJQqc+RqKiOMN5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nf4OOrFGTPt49IHdjrokM6+fYT+eqsYt25sQPPQrydc=;
 b=oDxAyqYfhkIUyC4eKgpUv9N4s8t5xc/HNwLvTQBNdwX1dTHEngnUmiud1QKZEDGQ1vkQBXd+jU/EWBgzrrDDIy15B1AB4xJ7KWmBKOI1RCWecdNCmEeVAr7ReHHOZdzEzhzywyTC7/vq8CWY6Jb6X9m1NWfEJKrB7PbJhpDyVwZCeeTwtXkaRX+042bpLYHjHEcrnTZiHzBfX3yozmiE3uguio0mI9W0kyUpDzG+jVcEZ9/dDy6pecfrNxPSXQZJ3n3uahCkvtHrjSwF5MxWGrHS2/Shcj2QWnxb22/ogNORtDCESo4ADn/3THJalQHBWZhPf2GYCNEF52AF7nS7GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nf4OOrFGTPt49IHdjrokM6+fYT+eqsYt25sQPPQrydc=;
 b=meO/QgcNemXdomA07SCpwaxmb3+X6UsDK/evNO1YlVo4lueqRuWHDIWyORe2opHfPdlfpT3HWL2Og6nrM/LfINMR8RUMH5xaU4+rYY5s/PzclNeCo6e+C0KRvuAZz7rIHngkBhQCQtfHrY6H7PzHMbrp948UK4hqLDeYZ1cXMaU=
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB9069.eurprd04.prod.outlook.com (2603:10a6:150:20::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 02:22:48 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 02:22:48 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "abelvesa@kernel.org" <abelvesa@kernel.org>, Clark Wang
	<xiaoning.wang@nxp.com>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] clk: imx95: enable the clock of NETCMIX block control
Thread-Topic: [PATCH 2/3] clk: imx95: enable the clock of NETCMIX block
 control
Thread-Index: AQHa0dSnz6xtwOc5AkmkHi9IOLmwibHucDMwgADIfoCAAAMkQA==
Date: Wed, 10 Jul 2024 02:22:48 +0000
Message-ID:
 <PAXPR04MB8459724CAF741E00C61E8F5F88A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240709073603.1967609-1-wei.fang@nxp.com>
 <20240709073603.1967609-3-wei.fang@nxp.com>
 <PAXPR04MB8459C43A1D11FA8A9F4AD0FC88DB2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <PAXPR04MB85108ED62C1178D9D0BED9F388A42@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB85108ED62C1178D9D0BED9F388A42@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GV1PR04MB9069:EE_
x-ms-office365-filtering-correlation-id: f461bf8d-f1be-4c43-060c-08dca08730ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?gb2312?B?Y0FzeXRJdGc0Y0F0QWxLU0V4SytRZHprT3plaWJ6UExnSXNjVU1jR3o5dmhI?=
 =?gb2312?B?a3dlSmMwVHk5cXRBenp5SUoxeVNOSnVybWpCdEJGN3NOdXFKUDF2c2dFcTVR?=
 =?gb2312?B?bVI2d0tVVU10WFkwekVYbGgzakFkd3M0T0wrTi9iL3dQc21MUWpxY3p5a0lN?=
 =?gb2312?B?MkhaT0VuVFhyZnBDTDRaamZuUzdBY3ZZWlVlTE52dGNmVFlUWkpuNncrQ01T?=
 =?gb2312?B?cHcrdml1K1BUYlZic0lZNlpNdW9lUzJQakc0cU9BMm4rRHl1UEFHcm9UeU9D?=
 =?gb2312?B?L1BXS04zWC9NU05yRmMyNU5LejdzNnJzNFBLQ0R0ZmRaUEdjZGpUMkVINzM2?=
 =?gb2312?B?VWJvRThVdXYzNm1xMFhLcmIyY2xDbzRrT2k0Nm9EVFFXQXB1MGhjR1NmdWZZ?=
 =?gb2312?B?UXJJd2k0WkVaWEltUHJyUzR6K2JtdFVYVGZxMTFwTkR4M0tiWVJXZ1RPYXFw?=
 =?gb2312?B?c3NockFUK2xYc1JaUXpyRHFKcFR0eGVtdUg2SXp3ajkwMXhPLzNyZU04SmNJ?=
 =?gb2312?B?TytvN1lVTUtnM2psUWsxT3JEU3ZlRHpKemsxWE1kU1ZES1ljSjh5V0loeEU2?=
 =?gb2312?B?em9jdUJtcCtSeW9rV0lDaW1lNm9tMWoyZXZ2ZmprOHdodkhmU0ZxQnh0Y0Rv?=
 =?gb2312?B?U3V0YkQ0S3B4L2JtRmFtUUQxVDYzVXVoQ29yemcyS3dNdUpqZTIxZWcydGJ5?=
 =?gb2312?B?akZteG5GWWZKTVlBYUwxcVRZbWNhSm5FTHNkcElLNzN5TERMenBCQW1zbjZy?=
 =?gb2312?B?ZnhVUTZkRmtrTXo4S2pYeXE2R0tOelF0RjNzM0dlVitSMk9ndTJESWZ1a1M1?=
 =?gb2312?B?bGRHOUViNlRnY3lPOXN5SG9zTVJQQnZGSlpKaVUzSDZvUS8xSlFSM1VOc3cx?=
 =?gb2312?B?UVQwM0VtQzE4djJIcHptOFZsUWhOMnVrS0tyVHgvQnNjN1djNTZRcEJJTzhn?=
 =?gb2312?B?Zi9vS3g1dndZWmkrZUVRRUtEUzBMUWJmWUdmcE1hM0pVMXh2YWE1Mk1DbFRQ?=
 =?gb2312?B?YTJWRGV1dHh0RU1OUTBTc0xDMTRCalNnWEtXc0luOUZOMWs0bDZFZEdoUDVm?=
 =?gb2312?B?ZHg2L09tR1hldzgzaEl6Yy93OHVVQmE2RmtRY0ZsSmhxYmFROUJFRTl5aEwz?=
 =?gb2312?B?TUJUS0xaSzNUNGlVc2U0cHdiUHFNUEJTUmpRRFRkRExNVTZTc0s0Ty91b3Nq?=
 =?gb2312?B?WmxZNmZ3TTAxRC90SnpZTmpYNi9IQjlDc290Vk1yR3JZdktxMlNoVm9VK3E3?=
 =?gb2312?B?NjdFLzA2MUticFEwTHd3RGZJQnpvZHlXNGFrSm1uejU3KzlaaU5BRnFQdEpQ?=
 =?gb2312?B?R1VXYks1WmROTURHVFRBbk0yUjRjN2tDRWsvcGxOU0VWRU0vQUIwYWpvWDBR?=
 =?gb2312?B?dVk2ajlnRVVnYUVZMGlWWjVKMzJJT3BURTRTdHVxQmJ3VDV0RzRBUW9wZHBM?=
 =?gb2312?B?SDVFTnczS0xONEFhNmNEQWE4WS9QSVBGalhsR1YrdlI5NDA1anpZR0s4MWVD?=
 =?gb2312?B?TjVyaGthR0dubkFrTVM1NWtqTGVvNWwrRmRXNm9LUU11ZHBibE94N1ZBT3BP?=
 =?gb2312?B?OVJjeWNhK2RWMFQrRXhrd2FaTVpybUFiWXJZTml0bFR3MkdSc09aTmlraHFr?=
 =?gb2312?B?a29hTXhHQXp4aUpnMlVpcEpwN0xBZDNtdXlOcmU1TE02WVVPbjJ1VTRrZmZv?=
 =?gb2312?B?WXlya21DZjdXWmMwTzlPbUVpeWNIWXBVczNtVS8zWXQxeEVzdDZGNkU0d3BV?=
 =?gb2312?B?c1NsQ2VuVjRiVk1EMTRiUTVWTXN4Tys0Q0JLa25mRzRpOVpEM1lJd2tjb2Ra?=
 =?gb2312?B?eXFGRFZlZjQ0OVMrMlhSWWt4Z2pMK3pyZ3VlZ1NyMmhIQkxpVm16b01nR21P?=
 =?gb2312?B?cUYrSkEvSXJSSTlnVDdGVVN5K1ArWVNMRENZeG51WnhpVnlaQkhYRkMyTC9U?=
 =?gb2312?Q?WwAwSQ5Ezvc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?TjdKRU9pRUZTTE9rOXI0QXVUUkdETDJNbTVqcFFZcGhaS3JVMFpJY0RhaFhE?=
 =?gb2312?B?MFMwL2hSNG1GczIwUXZjc3crMUNzZEpoeDJMMFJscHVDUHd6S1dOM243R2Iy?=
 =?gb2312?B?d0FNeER6YWhRcUZ2STNDRm1XeHJ0ajQ3aC9xU2JzSitTbThpTlV4SkZjbEhs?=
 =?gb2312?B?SjZiY1UwRXJnd01jYUNqR2dSMVgzSjd6Z1dWNEZoS1F6ZFVnUDVHTERXOWFD?=
 =?gb2312?B?QTlzekRTN3gvVWNrcFhJRlVVR3pHZHhrQWdDTURQUU5FQk9ndFVCNW56bm9X?=
 =?gb2312?B?VUU2Um5xT1I5V25MTEZ0TFpFcXh1eWpOejlXUFpxekRYTEdCVzFHMUtuZ0lX?=
 =?gb2312?B?amhIdktNRDd2U3NCY2VnVnFVK1lYSWhQYkJIVERFb0xoREV6KzVjaFd0UHRE?=
 =?gb2312?B?dDVDenQxd2N4VkZOTmdhdWhEaGlsSms3T1I1TUdEN3ZUNXhMSDdNVjFiZnRM?=
 =?gb2312?B?ZTZDM1k5VnJyQ0t4M1RDYzhXRzJDS2ZHZFcrcU9hd1VGL3gyN053MXVJR3Ey?=
 =?gb2312?B?L1JSdTQyQnlNRlR3blVaUlpXTFBqWEFYTkpkbzN4aHlOdHpGaHc1c3RLNmZt?=
 =?gb2312?B?aXI3ZElZUTRVL0VEbFdaYXgra2Z2Vm51K01yNDJYd0JUZldCMXJGbXpMZ0Rj?=
 =?gb2312?B?bzcrWG1ya2FOS29jdFE4OFNISGtXMXZseVlIa3VlTFlxT0pJdXJadFc5RlQ5?=
 =?gb2312?B?Z25TSWJsNUM4ak5DUnhMNHpsR1JNUC9Oa2JxNm5xWEFmZkszYy91NXcvMGpW?=
 =?gb2312?B?SGRaZGtMZ0NDTUorc3FPbU04cWlLZ0VPOEQ3STk3NlpqY1M4VlByQ2d5akJk?=
 =?gb2312?B?dlRqZjJPVWZhWGlwblpoUWMrWDFidDRGMUtuTEY0L0lZTEMrcGhkaVJvTVRR?=
 =?gb2312?B?NFJGeENaTXV0R1RBNDlDZGVnU1VNbEtsbVFENk5wbllQY3NWMmo3cFBLUys3?=
 =?gb2312?B?T0pIVFdRZm43bEtZYjNBQXlZYWc3elpMRWwvQWRrTEJEMnErN0U4U3BwZGFH?=
 =?gb2312?B?NjRERFgwdmwvaWJCMWtpUTI2NlJOQnpVVkNzN2hOOFJ2VlFCUXB6RGNsK0ZF?=
 =?gb2312?B?MHdPc3oyTEVLN1lZY1luQTAza05DTXVUZHkrTnNLTTJWOW9Ld1I2cmFGTHpR?=
 =?gb2312?B?MlhLT3NnV2xRQlRFckhZbUU1QTNMWU11dE9OK1FHa1N5Vm4vQzdKcStiU1Ja?=
 =?gb2312?B?bFZ4RU5aczFnUk9uVlJ1SjhIWWYzb1lJdXphelBvZzZRSXJ5NDNoWUk1K2xD?=
 =?gb2312?B?TzcvZFpua2NDZkwzSG9jUm15ZkZOZ1lwcWlZdFc5ZXNRejdkaXoveEpVZkpn?=
 =?gb2312?B?WU1Ga0V3OEZCT3RFT0xPYWowamUwazBNRGpWd25mQjBRSVd4UnAySHhIdFBD?=
 =?gb2312?B?Q0Y3R0hBUjl0WSt3bjNFNittRldOWTBZcStxRzg3U1lnRzBkU1hZTW9UMzJK?=
 =?gb2312?B?c2Y0N3dxOUMwcGZlRzdDTXdDTitKdE5ZQy9QWDI5b29YRW00U0taWWR4eDRY?=
 =?gb2312?B?NEtGVlNLTzNiNHlTNVFIclcyNGhvb28xeVRjSStrdGN1cTJjMGJrQ2wvUUJP?=
 =?gb2312?B?U0tZQk1HZldiaFBwUUNJOW5Ta014cDF0dU8xZ0o4Tk80cGhSUDZDTVRkcWNu?=
 =?gb2312?B?VkNSVTZ1Z2FVUUJJdEVOby8zZFlKeTNaajJUdStWVnl5b3g2UkxMazJlWEFM?=
 =?gb2312?B?d0RRQWR0NUZIWEZiVVV2V0FvSkZDcHh1ZTA2akh2cnk2RjdDbTgwTGZkaU5l?=
 =?gb2312?B?SnAzSmkvQmhSU1B1RTFVNjRWSWxTV0VKNW0raWdwM0c0Tk1pcG9OZEFZdHpR?=
 =?gb2312?B?MFdYSVdBUUdDOHNvM083dEU0UjN2c3IxOVFsRlJnWWdBYlA3ZjhNbjRKUXo2?=
 =?gb2312?B?Nk90TE5sd1pjbENXWWNLRzVBWGU1ajlSY2M2aUkvcUNxYUF2RkdiNEs1RS8r?=
 =?gb2312?B?WEltcXdMbXN6UDRWWUs1cjREU2gxN0h1YjlGTERucm0yYVQ3UVlNUWo4U1I1?=
 =?gb2312?B?SHMrUUVFK1Q5M014RldJbUNzVGRERGMzbDBEb0JKM1dkem5yc1htbFNheHJ6?=
 =?gb2312?B?SDIvQ1htVy9XQzFYTDd5cUkzRW1iOFkzVXhIZndFR3Bqa2xDaExhWTBuVzky?=
 =?gb2312?Q?iIts=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f461bf8d-f1be-4c43-060c-08dca08730ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 02:22:48.1402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: id4jlj6dMv5Uwh2oWeswlVxU1gi+8xatp8g/kCzOJUdXR+VF/OHXmSIrHSOJFBmmncW3p12tN9liBIvgo0UEug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9069

PiBTdWJqZWN0OiBSRTogW1BBVENIIDIvM10gY2xrOiBpbXg5NTogZW5hYmxlIHRoZSBjbG9jayBv
ZiBORVRDTUlYDQo+IGJsb2NrIGNvbnRyb2wNCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiBTZW50OiAy
MDI0xOo31MI5yNUgMjI6MTMNCj4gPiBUbzogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+OyBt
dHVycXVldHRlQGJheWxpYnJlLmNvbTsNCj4gPiBzYm95ZEBrZXJuZWwub3JnOyByb2JoQGtlcm5l
bC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+ID4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5o
YXVlckBwZW5ndXRyb25peC5kZTsNCj4gZmVzdGV2YW1AZ21haWwuY29tOw0KPiA+IGFiZWx2ZXNh
QGtlcm5lbC5vcmcNCj4gPiBDYzogbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gaW14QGxpc3RzLmxpbnV4LmRldjsgbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCj4gPiBTdWJqZWN0OiBSRTogW1BBVENIIDIvM10gY2xrOiBpbXg5NTogZW5hYmxlIHRoZSBj
bG9jayBvZiBORVRDTUlYDQo+IGJsb2NrDQo+ID4gY29udHJvbA0KPiA+DQo+ID4gPiBTdWJqZWN0
OiBbUEFUQ0ggMi8zXSBjbGs6IGlteDk1OiBlbmFibGUgdGhlIGNsb2NrIG9mIE5FVENNSVggYmxv
Y2sNCj4gPiA+IGNvbnRyb2wNCj4gPiA+DQo+ID4gPiBUaGUgTkVUQ01JWCBibG9jayBjb250cm9s
IGNvbnNpc3RzIG9mIHJlZ2lzdGVycyBmb3IgY29uZmlndXJhdGlvbiBvZg0KPiA+ID4gcGVyaXBo
ZXJhbHMgaW4gdGhlIE5FVEMgZG9tYWluLCBzbyBlbmFibGUgdGhlIGNsb2NrIG9mIE5FVENNSVgg
dG8NCj4gPiA+IHN1cHBvcnQgdGhlIGNvbmZpZ3VyYXRpb24uDQo+ID4gPg0KPiA+ID4gU2lnbmVk
LW9mZi1ieTogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBk
cml2ZXJzL2Nsay9pbXgvY2xrLWlteDk1LWJsay1jdGwuYyB8IDEgKw0KPiA+ID4gIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2Nsay9pbXgvY2xrLWlteDk1LWJsay1jdGwuYw0KPiA+ID4gYi9kcml2ZXJzL2Nsay9pbXgvY2xr
LSBpbXg5NS1ibGstY3RsLmMgaW5kZXgNCj4gPiA+IDc0ZjU5NWY5ZTVlMy4uMDdjNzBjMGE1M2Q0
IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg5NS1ibGstY3RsLmMN
Cj4gPiA+ICsrKyBiL2RyaXZlcnMvY2xrL2lteC9jbGstaW14OTUtYmxrLWN0bC5jDQo+ID4gPiBA
QCAtNDE5LDYgKzQxOSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkDQo+ID4g
PiBpbXg5NV9iY19vZl9tYXRjaFtdID0gew0KPiA+ID4gIAl7IC5jb21wYXRpYmxlID0gIm54cCxp
bXg5NS1sdmRzLWNzciIsIC5kYXRhID0NCj4gJmx2ZHNfY3NyX2Rldl9kYXRhIH0sDQo+ID4gPiAg
CXsgLmNvbXBhdGlibGUgPSAibnhwLGlteDk1LWRpc3BsYXktY3NyIiwgLmRhdGEgPQ0KPiA+ID4g
JmRpc3BtaXhfY3NyX2Rldl9kYXRhIH0sDQo+ID4gPiAgCXsgLmNvbXBhdGlibGUgPSAibnhwLGlt
eDk1LXZwdS1jc3IiLCAuZGF0YSA9DQo+ICZ2cHVibGtfZGV2X2RhdGEgfSwNCj4gPiA+ICsJeyAu
Y29tcGF0aWJsZSA9ICJueHAsaW14OTUtbmV0Y21peC1ibGstY3RybCIsIH0sDQo+ID4NCj4gPiBU
aGlzIHNob3VsZCBub3QgYmUgYWRkZWQgaGVyZSBpZiBubyByZWFsIGNsb2NrcyBhcmUgaW5jbHVk
ZWQuDQo+ID4NCj4gVGhpcyBpcyB0aGUgZmlyc3QgcGhhc2UsIGFuZCB3ZSBhcmUgY3VycmVudGx5
IHByaW9yaXRpemluZyBzdXBwb3J0aW5nIHRoZQ0KPiBSR01JSSBpbnRlcmZhY2Ugb2YgRU5FVEMg
b24gdXBzdHJlYW0uIFdlIHdpbGwgYWRkIHN1cHBvcnQgZm9yDQo+IG11bHRpcGxleGluZyBvZiB0
aGUgUk1JSSByZWZlcmVuY2UgY2xvY2sgbGF0ZXIuDQoNCk5vLCBwbGVhc2UgaW5jbHVkZSBjbG9j
ayBjaGFuZ2VzLCBvdGhlcndpc2UsIHRoaXMgaXMNCmp1c3QgbGV0IGRldmljZSB0cmVlIG5vZGUg
YXNzaWduZWQtY2xvY2sgYW5kIHBvd2VyIGRvbWFpbnMNCnNldHVwIGJ5IHBsYXRmb3JtIHByZS1w
cm9iZSBjb2RlLCBhbmQgbm90aGluZyBlbHNlLg0KDQpSZWdhcmRzLA0KUGVuZy4NCg0KPiANCj4g
Pg0KPiA+ID4gIAl7IC8qIFNlbnRpbmVsICovIH0sDQo+ID4gPiAgfTsNCj4gPiA+ICBNT0RVTEVf
REVWSUNFX1RBQkxFKG9mLCBpbXg5NV9iY19vZl9tYXRjaCk7DQo+ID4gPiAtLQ0KPiA+ID4gMi4z
NC4xDQoNCg==

