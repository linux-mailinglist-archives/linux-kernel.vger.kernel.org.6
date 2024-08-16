Return-Path: <linux-kernel+bounces-288940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74544954076
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 06:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9929E1C2380E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 04:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC9D1494D8;
	Fri, 16 Aug 2024 04:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="RTIRBrUk"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2109.outbound.protection.outlook.com [40.107.215.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3321482F4;
	Fri, 16 Aug 2024 04:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781220; cv=fail; b=CBRdrxrKQOzqCIfSyj66Jft3jLWhTCS4xeCfOK6rR0+7Hjry5xE7eNPu26q0eNVgqi3g+puQmW6njxUGGpOMn/7n3Qfuv0+U0hSIbOK51Hf/RsXZ3LjiVk6+vt/Akxuhpj5PXvRJaEv1xEzCXmddWSp+2V1s7na1/uo9u8OZUJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781220; c=relaxed/simple;
	bh=+s4+qLlljlYoOKpjKD4UttYFZcBwN3R+LRV6DLD0HYo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NVCVUecMoH537nJb4Hn+9ktxbP3Ju1Gn6eJeYAVUxlVoGx2yluTc1fDdYvtcDipVeTRtLazIPPizB+eiY7Lq+RkIdlNZf9Lk4baIV/F79WO9lZ9e7p+X2GMB3UJcROt2haE0Z1N5cfXaUlDn5yKDtxwieCSbvIHHzo+mXjXbwtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=RTIRBrUk; arc=fail smtp.client-ip=40.107.215.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktGpa7OU/pdMIj5e5mzw0RZ47sCjc/OU3wztAYRnj3aNkti+YJc+ijBF6cq1+xFPzEpmvspx4wpnrbc/kj0uP2z2QeyMi+ElIzj2aRhNBrojMPmDjmEAJgvXEJku4u2IWfUImULVJW3gbFxYBkH6gB1BxFJylnF/mI4qA/J3rq2u04dQuTpM+xCmtMpBsqjwRR4ysvVhm78628p3BlVX9nUGwCHbu0ltQWgOcLAKIS1t7+rDkuBMKifjSRw46MM13nkOaTbQHMbsBxFU+v898zSBW3sGgLZsPGJlXcLVW2IBP32DIHAcYMzahmAPv5oKaecGYn4EcVVzPVKiygBMKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+s4+qLlljlYoOKpjKD4UttYFZcBwN3R+LRV6DLD0HYo=;
 b=KzKsOIpBNvNvolCzBI2JGwofetRYaWPsaKCh9CV/whb4YARhpZ2WDkxBhg1GrOY3ykzhGk2A1aYj/5m3OpvkQW408PO1l8fwJOG1dqMbhgJPF+9ch8MJG3ai6gdYxSA51vVmU2UivHnnOCmFpVGz2cMa/X2O4knmAWhcKqboqUsss7CNmS89E4dlWwGUbvPRbadHQXBNEZRMbKOncn78FFWfoMbvhUG05Q4rVsci+xbabnkFUhn0gX5o+poFciu/74p2ZodQXSAFazaapvaQgPaDqmF80Hm8qTpvmRDzo9r/OsuNI63VQk/UG2lhc5HV9FFDe/Nx3my/bGL4hX99JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+s4+qLlljlYoOKpjKD4UttYFZcBwN3R+LRV6DLD0HYo=;
 b=RTIRBrUkZV/a5N42nKuMa00hgvgCvLg3+yyo94OiptyNtxiqgaNBu2S7/r5tOB5P+WBZT2j7nJ4I0J64n6G9/qWhU9fqka6USBkCBh0Lgldb4Y6Vr29rqS/Mtf7R7F7V+pPExbK4aXpYIbxrAlghU6qnr5DCcX3Vw0xb5Ff4H0NCShrkcEHgtOA5ew2Xgif70P8L5b1bXwjij4nHauDk9rPQZEHmERkoWu8zAmTVC+Uaf9rARFmgV+gAq7l4rNAVP1S2u/XH97Wbk7BSBhExyCq+yTyvtelHZhmTNaXrnk3p8zJ58v3Z6qvGS+sbpLbL4uVruARmhaosvKJgHYAZgQ==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by KL1PR0601MB5510.apcprd06.prod.outlook.com (2603:1096:820:ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 04:06:55 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%7]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 04:06:55 +0000
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
	<joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "lee@kernel.org" <lee@kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net"
	<olof@lixom.net>, "soc@kernel.org" <soc@kernel.org>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"quic_bjorande@quicinc.com" <quic_bjorande@quicinc.com>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>,
	"dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "neil.armstrong@linaro.org"
	<neil.armstrong@linaro.org>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "nfraprado@collabora.com"
	<nfraprado@collabora.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
Subject: RE: [PATCH v1 02/10] dt-binding: clk: ast2700: Add binding for Aspeed
 AST27xx Clock
Thread-Topic: [PATCH v1 02/10] dt-binding: clk: ast2700: Add binding for
 Aspeed AST27xx Clock
Thread-Index: AQHa30uIzhKcxQKQN0uLSEZ15MV2a7II2ogAgCBti+A=
Date: Fri, 16 Aug 2024 04:06:55 +0000
Message-ID:
 <PSAPR06MB49499A057A333009AFB61B7289812@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <20240726110355.2181563-3-kevin_chen@aspeedtech.com>
 <e13c16db-e1a7-4ee0-867b-b184d421de7f@kernel.org>
In-Reply-To: <e13c16db-e1a7-4ee0-867b-b184d421de7f@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|KL1PR0601MB5510:EE_
x-ms-office365-filtering-correlation-id: aafa4759-607a-4d59-c76a-08dcbda8dde5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?TDdiaThkUWZmSUVRNHNsd25Ydm1jdmJrWm1hd3VEbUR6ZDFpMFZZVnFRK2tt?=
 =?utf-8?B?ckpsbHlrcHh0SVNyYzBzdGZlZzJONWNEMjYyRm9wQjNyS2w2UGs2SDNiYkxr?=
 =?utf-8?B?amMrOElOeXptTTBkQ0x4VXZmaEo3eTVMRUZGcDNHRHV0c3lRVUU3WG9BSkpz?=
 =?utf-8?B?d0ZFYTRGYnF1bXZYKzRoSk1xcnVjb3IrY1grT2x4WDBQcmhkUFJYandCYVZ2?=
 =?utf-8?B?c0JBR2NjaEhUTlZ6eTU5eXdDbDlFaTd4Q2hyVjJGWUxXbkFab1V3Y0xkaEcv?=
 =?utf-8?B?Z2h0b1JYKzJwd3RreUU3VE96QWZNK29VcUtlZzFJUjJSZkdValNjRzNzRDFs?=
 =?utf-8?B?anNrR0pRVHZjYWZzYVJHV21aUk9IMmV0RTQ1T2VwRml6K2M2ckR5UGdRRFBk?=
 =?utf-8?B?Y09XSjljNGdNVktRT05KdDdpSzQyVzlnaDFYOVI5VDVuazNOMUYrVmVvdVhH?=
 =?utf-8?B?VzcvRHZTV0F6RWM3Y1RZWDRaZTBRY0hhejNPUnhOT1hxMW1yWElNUW5tVnd5?=
 =?utf-8?B?TTh6VHE3MmpaQXZGOWxNdURqNFV3T1ZlQ0p4OHdPSEVWWHR1V0M3cDRrK0xq?=
 =?utf-8?B?WGdKZmhTd1ROTGdEZzQ1S2wzWmZUYUNXc2VIREFBM2xTLy9GeGd5OWtKZWl1?=
 =?utf-8?B?RWpSSGxpY3F1SzhZb201aE5STGJXdEdUMFovOHlBK2pFUWFNSTBzTnV1dmFr?=
 =?utf-8?B?K2NYZ1E0dDFDVjMwREpMQU9yV3BYS1RjdWE5Y0IwVUxxcFk3cFFwUVpQeXpY?=
 =?utf-8?B?Y2JvQ2R3anVlNzBWbGowZWVaZmtxWFVjUFFIQ2JVeTZPWk15YkJCUGJyVHpK?=
 =?utf-8?B?dXdwZFJQK3VUMjUyR2FuUlVYdTVpelY3WDFFblB1aWhVYldKOGlVT3p3TGxh?=
 =?utf-8?B?akl4b0t6Z0hENHFyTkRveDRsR3ZKTFJRMllwanVTUnI5L3FIWkJ3RVZlUmln?=
 =?utf-8?B?dUZ1T3VrWDB1TW44cXc4dmFyN0FsdkNMTWhmTE5tYjhQUTlueHpXVndPK0NG?=
 =?utf-8?B?VkVsY05xMCt6Q1R1MmVOdGgvRGgxdnMrbjlkSEw0Z0FwNDR4b2dKQjJpbzl5?=
 =?utf-8?B?MXJ4U2JIOGNTdVEzY3dTbE9VeEVlM3BtZzdyeFVNdFd6ZDdocDV2cWZnNktT?=
 =?utf-8?B?cGhKeEsrOWppaEV0TlZXSWVSblBZeXllN05qOE84WmlBRE9ZK3VyLzdzK2d1?=
 =?utf-8?B?VERwNlZIcHowa3Q3Y2NMaGIzRXJQaWlrcHNCVGZoS0w5OE9BTjNHVno2Vzgz?=
 =?utf-8?B?SnYzYTVDK0RtU1J5Wk9lTTIzL2FKck0wSkkrN2g4emNoTDY4MG5ySTFKQkpM?=
 =?utf-8?B?WmVrc1VGRlc1STlNRHBCRllOS3o1bEUzMGVmYmx6U0J2MzE4eDBGVTNVY3Vy?=
 =?utf-8?B?dVJ6bUJkVVNwQS9sdnBydEVLU0hiYVFPMGo0THI5cHRjQmkvOXFmbVZTYzdR?=
 =?utf-8?B?aFBlVnlqditONldNOXAyOHh0Z0p4RTNSd0t4YUh4L3kyUHBPVEVuNjExb1Yr?=
 =?utf-8?B?bWFueWZyU3djd2d2dmJ2ZEZqdi9TNUJnaWRDQTZianJDeEdSRzNZZFBubERM?=
 =?utf-8?B?czJPVWRnNFFXb1dON25KclpmQTZ5dzZ4R29lQU9NNzFRS2pkM0pUZHYwcWJx?=
 =?utf-8?B?YkZ6ZFpDTFV2NXRXb1BkcThXVXovUDNtMkZRNmhSdmpBUWd4SXhJclRCSElL?=
 =?utf-8?B?TEpNQ2w4TkZyQkZBeXBaNTFpMGNCbStla08yMk1jRStNZTViWEJBQUFQUjJ1?=
 =?utf-8?B?K0NPZ0hkN1hpRUhvZ0tRbFl5eVB6eWVZWTFOU2h3aE1FcDhxZXZScEJJN1NV?=
 =?utf-8?Q?HI/JhdTnXTi7TCW+FYOzxZgqRoHYA2HjBOC8A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TlRnSDloNjhQc0hZMVNSSEhTMVQrb3dsNWdMWW5mbUlCK1RQUHVDSE1IVGlH?=
 =?utf-8?B?T2J2cEVkVFBib3lndTZUVjBraHJHL2NlbVd5RHJWWXAvVlFyV0RabklFc2ZX?=
 =?utf-8?B?ejl6UXVCUEJjSlN0NG9uZTRySUM5cmNQQnJHOHZYbGpyU1owV2dmdXdSdVdS?=
 =?utf-8?B?N1l1YlFkQ2JYSWZPYlhLa3kwdTZ1Y3Zsa1BWWDR5VkdWTW9xTCtrRVB0S3A0?=
 =?utf-8?B?MCtEM0ZQbERPdExYN2NSdklEaUJKNUt0S0lTM3o1RUZUald5cWhkYXRqVzdI?=
 =?utf-8?B?Q3Q1NnZpNi85RTBQS3JXOWl2UktXenorYkdFSzdtTm9rUFlKb0NLaWJ4WGJo?=
 =?utf-8?B?OUs3cG9hSC9uYloxRjcvQ0g0RU9tUW5YejJ5ZXhGR3VKZXJldjdMYlNTT0ZX?=
 =?utf-8?B?Ry9ZaVVZSHVRMjcwZFNGRmhkbXMrZHFMREZzdEppS1RxMWFKNFJjTSt0OVFR?=
 =?utf-8?B?b2lENXRxZ1RQZE5wN0VuY0NRTVh6K0Zib3RGVHVXS0tScXVmeG1YVDZwWk5T?=
 =?utf-8?B?S2tQMzlOUllwSUVIVnRVaGVYNFV4ODBvZ3lsNjR0ZTIzcHQrbk1qeUgyYnlz?=
 =?utf-8?B?Q3I1UmNoL0xKMTFJMnh1K1BlRHBMOURTMUxZZGdPYmVBcUs4S0JKVU5EQXlp?=
 =?utf-8?B?dnVpMUJqRVU4czFQb3d4Qm1OdnM3QWxyeTB3TDBrVlBPUWUxYzZ5ZzlhMGxJ?=
 =?utf-8?B?RUVBcWxjQWRGWTgyQ2VEV3hhK3RxSldBRXFsb2ZFWlVCZmxMdS9lQTFJOGN3?=
 =?utf-8?B?dUtSNmNvUXV0MEdIMlhUa0hSQUFCQ2tGT2JrQzZPQWtCSCs1eFcvZ0I3dUVI?=
 =?utf-8?B?N083dFMvenR4RUFHa2tsZDEwZEhkdGo4RWgwbGJ3Y1BJK0RwKzJ5VGtrdWNE?=
 =?utf-8?B?Rm1CSkZrdnNra3ZpYTZ0OW5zMk5IRGNZOXRRN1FlTzJuakxBQ3UwWUpwNVVy?=
 =?utf-8?B?bDRPdllEL1RKVDFCTC9Tc204T2Rkc3pkSUcrQzEwVGpnYUhtQVRNNFRNKzVR?=
 =?utf-8?B?VjRUaTM2dWJuRG9NMTEwUjB4Y3BObnF2QXVQUDhTM3VrR0IweFZ3VHJPRzRK?=
 =?utf-8?B?Q1k2anI1dDkwbmkvekRnU1VDS3prN2V2WVRZeEtEOWtEMlY3NUUyZGhOUUNW?=
 =?utf-8?B?R1pyZnRIQmVGMVZGYXIvVGM2b1dSRkp4NzY2R0pZOUZoTDViK3M0aGtacVBU?=
 =?utf-8?B?eHU4U3FmbnNFSnJOZ2xRVFM2akt0c2tlY1o1YXhlck9nR0VVeUp4VTBjWnlm?=
 =?utf-8?B?U2FUWCtjcC9VSjFmZTFtTncySVBKYnVZOEgxQUtpdTA5UHJKcHZIUWhWNlRu?=
 =?utf-8?B?aG9abGlDMnIrTEVxdWYzQ1FZZTViRFlqd0RwWnVtak1JRDByMFpFNU1JR21L?=
 =?utf-8?B?R1NUaHc3bkpaMjgyV1F4Y0pKNVFqT3J1YUJNUmxCUFQ1WHZwMHlqbnJ6Y2M0?=
 =?utf-8?B?cWFxVlZTTi9aYkRWOEhtcTdsQlI0bm9EMGIwYmZTZisvclFDVml2amRNR1ZC?=
 =?utf-8?B?RHlQUHppVEFQYjJUbXhBb3R2R2FaZnRtMUw5KzVDdTJXWG9hU0x6NW5RcnIr?=
 =?utf-8?B?dm5WTVAyUEcyU084aEZzVUUrM0d6UWpVKzVvaXpyd0xsdzRUVy9aWjBpK3VT?=
 =?utf-8?B?enJ3RjhSZXcxWVZJOWF5bHpIaSsxODVuOVpNaW81a1BOU0JDc2hYMERMT0h2?=
 =?utf-8?B?Z3R4a0xBQ0R3S2w5TDEvMFZGR2lvbTBldS9QVDkrNVpoakpwb3J4bWc3R2Va?=
 =?utf-8?B?VWFnVEwwOGNTcVp1QkhCK2xOV3RJTlA1a1ZYQjgxcXA0Sk5mNnFWUE9MVVQz?=
 =?utf-8?B?Mk9FUmdjcVFKM0hLRDkxcCtJdDl5Y3c1TTVERlpSRUc3RXIwWlRsT3MvS0cv?=
 =?utf-8?B?SzYwMjlWVXFudnBHNVZiS3NKNVg1QnB6K3daQjRvay84TTR4YUd1c1c2ckE4?=
 =?utf-8?B?VnEzRU5BaVl3cUt1em1neXZzRU82UWRkdDFNR2NVcm13bXUwWElQWHlqOVF3?=
 =?utf-8?B?a0ZWRGFId0hCeGZMRzlKejRXSi9nVnVJR1ZyZG12ZVBrSU04WFNoWVpTaGU3?=
 =?utf-8?B?L0U3ZEJxR0wzZnJhYytQQjhtWGkvQ3dmZmtKRzR5NHVJNHpHYUtOUDkzK0lC?=
 =?utf-8?Q?5aSNuA1oO/LAgqI7Htkt7p4v2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4949.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aafa4759-607a-4d59-c76a-08dcbda8dde5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 04:06:55.4227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bIiYYbRFEPFdePHU3g8FJpFEH87JOmiPSr6TcD1TJWYbD1vdsLL3wl4qu5M7enha82sLMqqcdK79z3vWgdCMfRd1+fevnp+vUgPS9kiXcIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5510

SGkgS3J6aywNCg0KSSB3aWxsIHNlcGFyYXRlIGNsb2NrIHBhcnQgaW4gdGhlIHYzIHBhdGNoIGlu
dG8gUnlhbidzIGNsb2NrIHNlcmllcy4NCj4NCj4gTWlzc2luZyBjb21taXQgbXNnLg0KPg0KPiBB
IG5pdCwgc3ViamVjdDogZHJvcCBzZWNvbmQvbGFzdCwgcmVkdW5kYW50ICJiaW5kaW5ncyIuIFRo
ZSAiZHQtYmluZGluZ3MiIHByZWZpeA0KPiBpcyBhbHJlYWR5IHN0YXRpbmcgdGhhdCB0aGVzZSBh
cmUgYmluZGluZ3MuDQo+IFNlZSBhbHNvOg0KPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9s
aW51eC92Ni43LXJjOC9zb3VyY2UvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jpbg0KPiBkaW5n
cy9zdWJtaXR0aW5nLXBhdGNoZXMucnN0I0wxOA0KPg0KPiBQbGVhc2UgdXNlIHN1YmplY3QgcHJl
Zml4ZXMgbWF0Y2hpbmcgdGhlIHN1YnN5c3RlbS4gWW91IGNhbiBnZXQgdGhlbSBmb3INCj4gZXhh
bXBsZSB3aXRoIGBnaXQgbG9nIC0tb25lbGluZSAtLSBESVJFQ1RPUllfT1JfRklMRWAgb24gdGhl
IGRpcmVjdG9yeSB5b3VyDQo+IHBhdGNoIGlzIHRvdWNoaW5nLiBGb3IgYmluZGluZ3MsIHRoZSBw
cmVmZXJyZWQgc3ViamVjdHMgYXJlIGV4cGxhaW5lZCBoZXJlOg0KPiBodHRwczovL3d3dy5rZXJu
ZWwub3JnL2RvYy9odG1sL2xhdGVzdC9kZXZpY2V0cmVlL2JpbmRpbmdzL3N1Ym1pdHRpbmctcGF0
Y2gNCj4gZXMuaHRtbCNpLWZvci1wYXRjaC1zdWJtaXR0ZXJzDQpBZ3JlZSwgYWxyZWFkeSBmaXhl
ZCBpbiBhbm90aGVyIGNvbW1pdCBpbiBSeWFuJ3Mgc2VyaWVzLg0KaHR0cHM6Ly9wYXRjaHdvcmsu
a2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LWNsay9wYXRjaC8yMDI0MDgwODA3NTkzNy4yNzU2NzMz
LTQtcnlhbl9jaGVuQGFzcGVlZHRlY2guY29tLw0KDQo+DQo+DQo+DQo+ID4gLS0tDQo+ID4gIC4u
Li9kdC1iaW5kaW5ncy9jbG9jay9hc3BlZWQsYXN0MjcwMC1jbGsuaCAgICB8IDE4MCArKysrKysr
KysrKysrKysrKysNCj4NCj4gVGhpcyBpcyBzdXBwb3NlZCB0byBiZSBwYXJ0IG9mIGJpbmRpbmdz
IGFkZGluZyB0aGUgY2xvY2sgY29udHJvbGxlci4NCj4NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE4
MCBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRp
bmdzL2Nsb2NrL2FzcGVlZCxhc3QyNzAwLWNsay5oDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9kdC1iaW5kaW5ncy9jbG9jay9hc3BlZWQsYXN0MjcwMC1jbGsuaA0KPiA+IGIvaW5jbHVk
ZS9kdC1iaW5kaW5ncy9jbG9jay9hc3BlZWQsYXN0MjcwMC1jbGsuaA0KPiA+IG5ldyBmaWxlIG1v
ZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi41Y2E4NTUwMzczNmQNCj4gPiAtLS0g
L2Rldi9udWxsDQo+ID4gKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9hc3BlZWQsYXN0
MjcwMC1jbGsuaA0KPiA+IEBAIC0wLDAgKzEsMTgwIEBADQo+ID4gKy8qIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkgKi8NCj4gPiArLyoNCj4g
PiArICogRGV2aWNlIFRyZWUgYmluZGluZyBjb25zdGFudHMgZm9yIEFTVDI3MDAgY2xvY2sgY29u
dHJvbGxlci4NCj4gPiArICoNCj4gPiArICogQ29weXJpZ2h0IChjKSAyMDIzIEFzcGVlZCBUZWNo
bm9sb2d5IEluYy4NCj4gPiArICovDQo+ID4gKw0KPiA+ICsjaWZuZGVmIF9fRFRfQklORElOR1Nf
Q0xPQ0tfQVNUMjcwMF9IICNkZWZpbmUNCj4gPiArX19EVF9CSU5ESU5HU19DTE9DS19BU1QyNzAw
X0gNCj4gPiArDQo+ID4gKy8qIFNPQzAgY2xrLWdhdGUgKi8NCj4gPiArI2RlZmluZSBTQ1UwX0NM
S19HQVRFX01DTEsgKDApDQo+ID4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9FQ0xLICgxKQ0KPg0K
PiBEcm9wIGFsbCAoKS4gTm90IG5lZWRlZCwgbm90IHVzZWZ1bC4NCj4NCj4gPiArI2RlZmluZSBT
Q1UwX0NMS19HQVRFX0dDTEsgKDIpDQo+ID4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9WQ0xLICgz
KQ0KPiA+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfQkNMSyAoNCkNCj4gPiArI2RlZmluZSBTQ1Uw
X0NMS19HQVRFX0QxQ0xLICAgICAgICAoNSkNCj4gPiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX1JF
RkNMSyAgICAgICAoNikNCj4gPiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX1VTQjBDTEsgICAgICAo
NykNCj4gPiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX1JTVjggKDgpDQo+ID4gKyNkZWZpbmUgU0NV
MF9DTEtfR0FURV9VU0IxQ0xLICAgICAgKDkpDQo+ID4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9E
MkNMSyAgICAgICAgKDEwKQ0KPiA+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfUlNWMTEgICAgICAg
ICgxMSkNCj4gPiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX1JTVjEyICAgICAgICAoMTIpDQo+ID4g
KyNkZWZpbmUgU0NVMF9DTEtfR0FURV9ZQ0xLICgxMykNCj4gPiArI2RlZmluZSBTQ1UwX0NMS19H
QVRFX1VTQjJDTEsgICAgICAoMTQpDQo+ID4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9VQVJUNENM
SyAgICAgKDE1KQ0KPiA+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfU0xJQ0xLICAgICAgICgxNikN
Cj4gPiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX0RBQ0NMSyAgICAgICAoMTcpDQo+ID4gKyNkZWZp
bmUgU0NVMF9DTEtfR0FURV9EUCAgICgxOCkNCj4gPiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX1JT
VjE5ICAgICAgICAoMTkpDQo+ID4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9DUlQxQ0xLICAgICAg
KDIwKQ0KPiA+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfQ1JUMkNMSyAgICAgICgyMSkNCj4gPiAr
I2RlZmluZSBTQ1UwX0NMS19HQVRFX1ZMQ0xLICAgICAgICAoMjIpDQo+ID4gKyNkZWZpbmUgU0NV
MF9DTEtfR0FURV9FQ0NDTEsgICAgICAgKDIzKQ0KPiA+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVf
UlNBQ0xLICAgICAgICgyNCkNCj4gPiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX1JWQVMwQ0xLICAg
ICAoMjUpDQo+ID4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9VRlNDTEsgICAgICAgKDI2KQ0KPiA+
ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfRU1NQ0NMSyAgICAgICgyNykNCj4gPiArI2RlZmluZSBT
Q1UwX0NMS19HQVRFX1JWQVMxQ0xLICAgICAoMjgpDQo+ID4gKy8qIHJlc2VydmVkIDI5IH4gMzEq
Lw0KPg0KPiBJRHMgY2Fubm90IGJlIHJlc2VydmVkLiBJdCBpcyBhIGJpbmRpbmcsIG5vdCBhIGhh
cmR3YXJlIG51bWJlci4NCkFncmVlLCBhbHJlYWR5IGZpeGVkIGluIGFub3RoZXIgY29tbWl0IGlu
IFJ5YW4ncyBzZXJpZXMuDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGlu
dXgtY2xrL3BhdGNoLzIwMjQwODA4MDc1OTM3LjI3NTY3MzMtNC1yeWFuX2NoZW5AYXNwZWVkdGVj
aC5jb20vDQoNCj4NCj4gPiArI2RlZmluZSBTT0MwX0NMS19HQVRFX05VTSAgKFNDVTBfQ0xLX0dB
VEVfUlZBUzFDTEsgKyAxKQ0KPg0KPiBObyBkcm9wLiBPdGhlcnMgYXMgd2VsbC4NCkFncmVlLCBh
bHJlYWR5IGZpeGVkIGluIGFub3RoZXIgY29tbWl0IGluIFJ5YW4ncyBzZXJpZXMuDQpodHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtY2xrL3BhdGNoLzIwMjQwODA4MDc1
OTM3LjI3NTY3MzMtNC1yeWFuX2NoZW5AYXNwZWVkdGVjaC5jb20vDQoNCj4NCj4gQmVzdCByZWdh
cmRzLA0KPiBLcnp5c3p0b2YNCg0KLS0NCkJlc3QgUmVnYXJkcywNCktldmluLkNoZW4NCioqKioq
KioqKioqKiogRW1haWwgQ29uZmlkZW50aWFsaXR5IE5vdGljZSAqKioqKioqKioqKioqKioqKioq
Kg0K5YWN6LKs6IGy5piOOg0K5pys5L+h5Lu2KOaIluWFtumZhOS7tinlj6/og73ljIXlkKvmqZ/l
r4bos4foqIrvvIzkuKblj5fms5Xlvovkv53orbfjgILlpoIg5Y+w56uv6Z2e5oyH5a6a5LmL5pS2
5Lu26ICF77yM6KuL5Lul6Zu75a2Q6YO15Lu26YCa55+l5pys6Zu75a2Q6YO15Lu25LmL55m86YCB
6ICFLCDkuKboq4vnq4vljbPliKrpmaTmnKzpm7vlrZDpg7Xku7blj4rlhbbpmYTku7blkozpirfm
r4DmiYDmnInopIfljbDku7bjgILorJ3orJ3mgqjnmoTlkIjkvZwhDQoNCkRJU0NMQUlNRVI6DQpU
aGlzIG1lc3NhZ2UgKGFuZCBhbnkgYXR0YWNobWVudHMpIG1heSBjb250YWluIGxlZ2FsbHkgcHJp
dmlsZWdlZCBhbmQvb3Igb3RoZXIgY29uZmlkZW50aWFsIGluZm9ybWF0aW9uLiBJZiB5b3UgaGF2
ZSByZWNlaXZlZCBpdCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHJlcGx5
IGUtbWFpbCBhbmQgaW1tZWRpYXRlbHkgZGVsZXRlIHRoZSBlLW1haWwgYW5kIGFueSBhdHRhY2ht
ZW50cyB3aXRob3V0IGNvcHlpbmcgb3IgZGlzY2xvc2luZyB0aGUgY29udGVudHMuIFRoYW5rIHlv
dS4NCg==

