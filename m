Return-Path: <linux-kernel+bounces-244253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4507892A1AF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C781C2103F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9374A7FBC1;
	Mon,  8 Jul 2024 11:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qLIFM8FG"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFC53BBE8;
	Mon,  8 Jul 2024 11:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720439703; cv=fail; b=Eo8XF7Sxnv2UDTHBMDAKVyszh1sxxnM5uXakNn2TBScpZ/jwpcxOZ9jgah8kZJLZgrwlMtWheEbdoPBWEAX9YIfxtccg6tunu0QgxvbiGKPYb+F3J6dCYB6CO61oGQxKjqyxwjp0G3VAuI1awQvhvHgH/zm5lgTV29Fow9hW7Qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720439703; c=relaxed/simple;
	bh=vJeqBhTzqzyx5/3GVWlEg1dxvilpgmaKSWrrhvV78zQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=COtkSXszqu0uMTZd9s/mtjxTfXZpdO+DZvKWWzu0Yk+oOhOd5KHwK1fPGAMJtWumiNZvoer5XTiVt51PQH3jaSdlaTsDOo5rdP7sLbQSvO8L1lqRzTXWA230K9n/UckIZOx4clIHmQYfU9xmNZ8NUTaF3W0LsUCh+0beY7d39FM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qLIFM8FG; arc=fail smtp.client-ip=40.107.21.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZ0mMUW/RYBn7Xj8SUu8ZltFO5TAVW53vvAvF56LMNurOCxUiagPLrEiA55lGxePkX+/zeie1qcGfZBq0y/n/yTSaKHVdvyKsn9fRjawkG+J2LDBslc2Y4msGwcgT5or/Ox/Osi+G7kBqijAcv9vEkXHvzNXCGgdhwU7djqzqo7Vb2Q9NnDLV+XYdPWTxCs3yGE+HUkv70G8Up5MSy1DqeJPWlSu+3T5SYISO2MBaHdaE1e8VpSDk3kvDuesS1ToY/vE7oESs8rJAXT6KBgk7MEP2egnO0B62IiwUlYyTByKgEjvCZ1zMN7OVQQAGpq3I+bhpM5CzkPqhoUk3eGSqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJeqBhTzqzyx5/3GVWlEg1dxvilpgmaKSWrrhvV78zQ=;
 b=AiVbUf8sqx9yNLhC+Ssp1zkKEHWIuo2t9Ii+zI3Gan5clfiDnZTCjRZ2bVaFUR/7zU6Eu5kAEY+t+d9HlirZrETAUiEwCZSOIzNNO/Kixm5cvLrd29KjhABLtDHqDXcgq96UMcCgKNxXMrixrWL2+jmatWv5+n23sp+3CqmgzcEBwoDZ3JjnDC08Qn1upgR0VrU83OsBdHNIOrdog/VovR/dhGK9UBS/xv5oHgcy7tB8XkSHMIXfgoNk+LLA6mf2IF1RCSufLqdXAkrFNvMQzBys0J1QnBIfbH6oNSShn3e6DWeLKoXbwNiYZEUI1I+aQrovEJxlmBZ6H7qAST7Peg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJeqBhTzqzyx5/3GVWlEg1dxvilpgmaKSWrrhvV78zQ=;
 b=qLIFM8FGKClMme5IcHSa/FSFz1CpjMVwVrXbhJboN2ivAxhzx4wX+6LkJI8GXOkl9rthK4ejAjZGk43qUkjrRcYr4XL+k8l7e+HbDXp2EGoU4GPnlgIAaAvaEcTOYDMXiliDkFitbPL8cDTP031/6hrLtlX96k1wYOm0v2P8/X8=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by PAXPR04MB9680.eurprd04.prod.outlook.com (2603:10a6:102:23e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 11:54:54 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 11:54:54 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v4 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Topic: [EXT] Re: [PATCH v4 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Index:
 AQHazuMSrg3adK0l6E2Y9DEwTEglUrHrNmCAgAETJjCAABVegIAABHLAgABRfgCAAADUsA==
Date: Mon, 8 Jul 2024 11:54:54 +0000
Message-ID:
 <AM9PR04MB8604AE7ABC833D77D403229795DA2@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240705-imx-se-if-v4-0-52d000e18a1d@nxp.com>
 <20240705-imx-se-if-v4-2-52d000e18a1d@nxp.com>
 <450d1575-c9b3-413b-bfa9-8dc4352fa263@kernel.org>
 <AM9PR04MB8604B9A9F3D22C35679AD1D195DA2@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <c7688fba-0570-4dc6-80c4-23cd75ed29aa@kernel.org>
 <AM9PR04MB86040DFD0C0EF5D904BF960D95DA2@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <d9d334cd-543d-4316-ab0b-9ab253fffbd0@kernel.org>
In-Reply-To: <d9d334cd-543d-4316-ab0b-9ab253fffbd0@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|PAXPR04MB9680:EE_
x-ms-office365-filtering-correlation-id: 8b86df46-0bd9-4593-34a6-08dc9f44c817
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bk1LQWxVck5VSHFxR1ZPVUxSTjVtWFJGejlUY2NzNDhXZDlTeXVNWTRWaEFN?=
 =?utf-8?B?MTk4OGRZVWZybjdtUlNnOVRBblpYZ3VtYzA1MzJ5c0NDSW15UElqenJ5dzgv?=
 =?utf-8?B?L0ZLamVCbWhiZ3NlVUZXaE1MVlFSNjJIRGV4cE5pRHNGbVRnN3hlM01xa0Jv?=
 =?utf-8?B?VldpVVozWDc3NURVOUUxekw5VDZmRk1uNEgzaExTS1JDeHE3ZFhGOCsyNko0?=
 =?utf-8?B?d09EbUZXY0d5QklJYVRjMjR3aG1YSWU5R2VpOGVSQlFucTA5cEVYci9kZzZQ?=
 =?utf-8?B?cVRjWEZEb1BDK3o3VXI2SWFKWDIrellWZzNqYW50c1VWQ0RFa253bGozOUs1?=
 =?utf-8?B?RytZS2RFSlExejFkU0l6d2RNdnByaUdrSlFkZU4xUWx5c09Eb0s1RkxyR1Y5?=
 =?utf-8?B?dE5xc09HaWgxY0RER2NjQXhmYVJGNzdyVll1cU9xelliUjcvWjBRRUljdjUx?=
 =?utf-8?B?RUlvRHpiM1U2SVllMVlSemFoVVZHL29qcnlSd29qd1Y5UENJbDRjVTJRdGJM?=
 =?utf-8?B?cUFoTTBYdXRZcUd5d2g0cmRsMENDWUVPWEpVNTBtQXBJWHhRZ05TZ2VvTUtG?=
 =?utf-8?B?SFg2T3NOYTltQk91U0pGejJZcmJ3ekRzL05pdTh2Z1NOUnVxMHdZeWJFNGlJ?=
 =?utf-8?B?eUpHUGpDaXV4MllwdGxMcVdnZlJQMXNKK0cyQUh4a2crNEVkc0hiZkxKS3Rp?=
 =?utf-8?B?eUpaNGZGMllwY2phUThSQXFhdllzWFhIWU9SYk03ZllyMFpYbEpUWjFyRVpr?=
 =?utf-8?B?NzI5czE1bGJ1N3hZYTkvWjVDM2YwRDdzK0l4eHhDcXJ1RzF1OEd3d0ZFcWdV?=
 =?utf-8?B?VGJDM1VORFNVd05jN0h4cWF5MzVZT3pPV1ovTVhVUVpEb3RaR3p2elFERndT?=
 =?utf-8?B?Uko5VmFUS2RFOElzWXdOREhhaFVVdEE2OGUvU3J5SkFtQ2VQbTgvSTZvV3hS?=
 =?utf-8?B?NE5YM2VkcUNNWDhSTlJFajBNb21CQVZQSllzUmc2MjZxMEdJckxpMktHLzRn?=
 =?utf-8?B?NnQraTZSdExNM2U2RTZFTU9lMDY5YktMaGZJdTRWaDlhQjJmZ0RReTVwZGRJ?=
 =?utf-8?B?bWtsNG5CSG9FYmlkUUVnMHU3Z2I0VEF4NGJ6dy85Qk94N203d3pVL0lERTJF?=
 =?utf-8?B?S0xOYVJ6akFYaitrdnV6cUwycXVQRUlyUG5jbjdkaU4yOE5HekhkRktMbm01?=
 =?utf-8?B?T3MvM2ZiQmdKNjFsNnh3U0paYUdTaWtwbitlYkF5NXd4YURPNlhlYVF5TEJu?=
 =?utf-8?B?eDByMFNDWHVoVXFRMGxQaGxrNE5LVFB4dDBMY1pQT21Kc1NmU2t5SWUrOHU4?=
 =?utf-8?B?ajRVU0t5K2UvTnk3Qjg4dEh2UnRDV0wxTktOcERYNC95ckZnY2tnY0JMczh4?=
 =?utf-8?B?TitwUXphclA4bCthN20rREFzOTQ5TDBTamNtSUFNYzkrMm1XQUNHNlQzNU1E?=
 =?utf-8?B?N3VDdkdZaHQvQ1U5cmVXRXRMVnh0T0g2ckpOcmtVbUN1YWFDeDY4YXZkSnZv?=
 =?utf-8?B?b1Y1WmtJTFgzYlFhMkprSkZBbjRRaWcwbmFiMHkyUEdZWUdNYm00MnlVOGNn?=
 =?utf-8?B?ZnRjaUNQWnNWMERWYW9YZlVxQk5HZXRxU0NYYXdtSXA0TVBNbFVha2VTck0r?=
 =?utf-8?B?Rm9DZUxyaGc5b2RrSmpsbE4vZVEycGFMSmtYazkyREVNRTJjMDdLMHV5eVky?=
 =?utf-8?B?QncvL1ByV09oVWt2T0w3U1d5QmRadTMwYXlKMWRMeWNJY0pWTnpidHk0S2p6?=
 =?utf-8?B?Uk90V2dwTDBRZ3FVY2orV1ZTTklqY3EyKzlZdzcrc3ZnNE03WnVPUjdDMlZV?=
 =?utf-8?B?SDh2b1Fva1c2MzY4M1NMQjhzMWUyUyt1MnpaYVBVTWY2VTFuNEJUTWZXd2F0?=
 =?utf-8?B?ekFpckpJeFF0Y2Y0dzFYTHNMRnptREwya2NFTHlsN2gzVzBkWTcvTlVlMkNU?=
 =?utf-8?Q?mLsiVjNaDo8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QnE0Q3U2cEh5ZEovZVJKa2pCcXRaRkg3Skc3WW1DbXlHSW8xVlFzMndRZGZQ?=
 =?utf-8?B?ck9iWnRlWUE3dzhnZWxwam9UQjZJeVVYcDVqK1dsZGg4WjVXeC93Sk9MYmtE?=
 =?utf-8?B?RVczVmFjbi91U1pVUkoveFdCYmZ6eVZjajM4UlN4YTd6aE5MUkl6Q3NaS3pr?=
 =?utf-8?B?WkNLQnNHaWVNUzAzT2RQSUVWSERPR2FrSy9UR2tnUFNTdjQvWlRFU1RrT3JD?=
 =?utf-8?B?c05LY2ZoWERyQUNUeUg3WDBHUGVqVHVxTHE4NFQrQm4yMXkxczVmWjdUUUM5?=
 =?utf-8?B?M2MzSVYvUGxzdW1wWFZRUnNIV1cxdFZWVm05c0t0cW03TmVZZVJsTU1hOWQ1?=
 =?utf-8?B?NzBiYWc0eTRiMGtDSmRpam54Y05qM3k0NkJtWVZ5MS9MT1BUV0JramtSZFp0?=
 =?utf-8?B?cnpRSUdabHV1M3dKVHNnU3BuV0dEcVFaUGI4M0Z3NitXL2k1TlkrMWE4bzYw?=
 =?utf-8?B?Y0NNb3o5dzcyK1liRDAzZDJ3eGNhRVpnUzlFSXNZMzBMaXJ3Z0k5dUtqOHVZ?=
 =?utf-8?B?RUhtci8yeWg5UTkwRXVPVWZibWxKbFN5Wkszb2VCNjJKRUJkSmo4MDNCRHl1?=
 =?utf-8?B?Vkx2Y3ljNVBmeWVBZjA3MFRLeHB0WWRITEoxSjljWmQ1QXlvWGhCd2JhZ1d4?=
 =?utf-8?B?SnVCTXNCVUdkVnUxbW1UQkNQcTd4cld4aWFYdU1wUUhmN2dVMDZReHlicWEx?=
 =?utf-8?B?aVlTR21QNGNJa2xsNnZHV2xKdytYM05hYVRrbnlDQ0dCeUd2RFFzQkNyWlp5?=
 =?utf-8?B?ZW9PN09lTDNxR2loY2RSb0xSZUlqNGxiVWVWbXJTVVlEMHpKV0ladkk3Q1c4?=
 =?utf-8?B?bU0wS00vWUNpaUF6V1JvK1g3U1JOR1hLbk85Nm0wQVpYK244eTdwbHVkSlNQ?=
 =?utf-8?B?NkE1eC96Y3ovbmpqUlV3UFhqTlpPRkIyb2h6ZS81Uk90T3ltMnlZT3ZZRUpF?=
 =?utf-8?B?SnpPZFJReGFmTkpSTXIzWlZxRktBbmp1Mjd3RlpJUXZRSVZUZDh4VTUrU0VN?=
 =?utf-8?B?bVBMdk9UTC9zOE44aDJKcmJQTWpMeG5QZUZsU1lrL2lubWdwdGhyUWFIUlFE?=
 =?utf-8?B?eU9ST2ltRTJ1cnlJWWJ0Q3Uyc0haZS9hRG1ULzBMbUlGeEc3YXV0bjB2WnFV?=
 =?utf-8?B?SXdocGtQbEhzdHE5MHByWGpFUjJEMHJJTHh5TWtlR2lzNjBuZzAvUTRFVDFo?=
 =?utf-8?B?MCswdDFzN215MldBdDdoRS84bWRoOVZ5MmU5c0pYYVZURkpadG9YU0U3bStt?=
 =?utf-8?B?Sng3VHUyMWREbEJjTXQ4aCtITHpWRWVuY2NCcHgwcjhHY1NubS90bnFQVHlj?=
 =?utf-8?B?WjV6WUZnTUV1d3NxR2NVZW9pYlRWU1MvbSt5VDdLSWlKR0thMTJoMkdoY1E4?=
 =?utf-8?B?Q2E2eFJ1Y0RabGhyVk1icFhQVUFXOVVVbG9QS05ZR2RRTGhVa21tTnhSSE1h?=
 =?utf-8?B?Tjh5V1N0Tm81UFlMeDdqbTZMWlpWdzdQQTdNNmxCVFAxTlgrREwzaDg5UUZ3?=
 =?utf-8?B?WXBMUTFyNE81UFR0c2FUbWhHcGs2U28wMDZMT1JKUE9ORzV6UFlYcFdVOE94?=
 =?utf-8?B?Q3RXMVpQK3paQnRyd1VVd2hGU2ZZcHcxWWRZblM0c0hoc01oaUVHR2lzTEpG?=
 =?utf-8?B?Mlp3Myt2dHRqcHJYUWM0LzNTTmRSMUhxSTRTU0d0Y1NjcWQ5VitlOCtjQmtz?=
 =?utf-8?B?UEUwMHlSNVpEUFNQREIwOGNuUHNDUjRGSDRYUHNnSWlDN3ZNMmd6NEIyMmRy?=
 =?utf-8?B?UWNqN0crL2JnWlE3WEpZVEQzbUVLdTJyYTE1dy9KV1V2Qm5ySXJtazIyT2JY?=
 =?utf-8?B?azB5UmswNVQ2VnJsNVBoL0ZLNmxQS3AxYzNyR0VCNFdIU1hoNUFxa200RUsz?=
 =?utf-8?B?eW5LVVliUHpYM3pnQ2Nqc2h2VlpQbkNKcnEvRTN1TDh0NnRiTkxuc2grRjNB?=
 =?utf-8?B?VUxRZVhpWVdYTlZ1bk5xQ1NYT2xVVlJ1RTVRLytmejNjREJYVU5qbzlteDNU?=
 =?utf-8?B?RDlMTXJuTHl5VkVRTUVBODB4cFpMTTlzbWtDMXBZOWtBUjFwNjk2Y3EvbHBs?=
 =?utf-8?B?ck12MjBCLzBxaE4yTFJTNzVCWmRkYnRoc2NCOHY3TGRiQ09OcTVEOWoxcklV?=
 =?utf-8?Q?j+ckQlJXueK/NOIxeHFlbdX2R?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b86df46-0bd9-4593-34a6-08dc9f44c817
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 11:54:54.2570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TV1wDC/jUpv5gHw16IKHhG/0uTveYYt5VmCoN6vox1OKRA5AXUpje4Y0VvqnTEnR3y5xy+UXFrjhYLVnSVPURA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9680

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIEp1bHkgOCwgMjAyNCA0OjU0
IFBNDQo+IFRvOiBQYW5rYWogR3VwdGEgPHBhbmthai5ndXB0YUBueHAuY29tPjsgSm9uYXRoYW4g
Q29yYmV0DQo+IDxjb3JiZXRAbHduLm5ldD47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+
OyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxrcnprK2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29s
ZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBTaGF3biBHdW8NCj4gPHNoYXduZ3VvQGtlcm5lbC5v
cmc+OyBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+Ow0KPiBQZW5ndXRyb25p
eCBLZXJuZWwgVGVhbSA8a2VybmVsQHBlbmd1dHJvbml4LmRlPjsgRmFiaW8gRXN0ZXZhbQ0KPiA8
ZmVzdGV2YW1AZ21haWwuY29tPjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IEty
enlzenRvZg0KPiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZz4N
Cj4gQ2M6IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBpbXhAbGlzdHMubGludXguZGV2
OyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6IFJl
OiBbRVhUXSBSZTogW1BBVENIIHY0IDIvNV0gZHQtYmluZGluZ3M6IGFybTogZnNsOiBhZGQgaW14
LXNlLWZ3DQo+IGJpbmRpbmcgZG9jDQo+IA0KPiBDYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFs
IGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3INCj4gb3Blbmlu
ZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRo
ZSAnUmVwb3J0DQo+IHRoaXMgZW1haWwnIGJ1dHRvbg0KPiANCj4gDQo+IE9uIDA4LzA3LzIwMjQg
MTM6MTksIFBhbmthaiBHdXB0YSB3cm90ZToNCj4gPj4+PiA0IG1haWxib3hlcz8gVGhpcyBjYW5u
b3QgYmUgZGlmZmVyZW50Lg0KPiA+Pj4gbWJveC1uYW1lcyBjYW4gaGF2ZSBhbnkgb2YgdGhlIGFi
b3ZlIG1lbnRpb25lZCA0IHZhbHVlcy4NCj4gPj4+IEFuZCAgdHdvIHZhbHVlcyBhcmUgbWluaW11
bSwgcmVxdWlyZWQuDQo+ID4+DQo+ID4+IE5vLCBJIHNhaWQgaXQgY2Fubm90IGJlIGRpZmZlcmVu
dC4gSWYgdHdvIGFyZSBtaW5pbXVtLCB0aGVuIHlvdSBjYW4NCj4gPj4gaGF2ZSBoZXJlIDQsIHJp
Z2h0PyBCdXQgZWFybGllciB5b3Ugc2FpZCB5b3UgY2FuIGhhdmUgb25seSAyLiBJdCBkb2VzIG5v
dA0KPiBtYWtlIGFueSBzZW5zZS4NCj4gPg0KPiA+IFVuZGVyc3Rvb2QuICBXaWxsIGZpeCB0aGlz
IHdpdGggZm9sbG93aW5nIGNoYW5nZXMuDQo+ID4NCj4gPiAtICAgICAgLSBjb25zdDogdHgNCj4g
PiAtICAgICAgLSBjb25zdDogcngNCj4gPiAtICAgICAgLSBjb25zdDogdHhkYg0KPiA+IC0gICAg
ICAtIGNvbnN0OiByeGRiDQo+ID4gLSAgICBtaW5JdGVtczogMg0KPiA+ICsgICAgICAtIGVudW06
DQo+ID4gKyAgICAgICAgICAtIHR4DQo+ID4gKyAgICAgICAgICAtIHR4ZGINCj4gPiArICAgICAg
LSBlbnVtOg0KPiA+ICsgICAgICAgICAgLSByeA0KPiA+ICsgICAgICAgICAgLSByeGRiDQo+IA0K
PiBPSywgdGhpcyBpcyBub3cgY2xlYXIgYW5kIGFuc3dlciBpcyBhbHNvIGNsZWFyOg0KPiBObywg
eW91IGNhbm5vdCBoYXZlIGRpZmZlcmVudCBuYW1lcywgZXhjZXB0IHNvbWUgcmFyZSBjYXNlcy4N
Cj4gUGxlYXNlIGV4cGxhaW4gd2h5IHRoaXMgc2hvdWxkIGJlIGFuIGV4Y2VwdGlvbj8NCg0KVGhl
IG5hbWUgc3VnZ2VzdHMgdGhlIHR5cGUgb2YgcHJvdG9jb2wgZm9yOg0KLSBzZW5kaW5nOiAgICB0
eCBvciB0eGRiICh3aXRoIGRvb3JiZWxsKS4NCi0gcmVjZWl2aW5nOiAgcnggJiByeGRiICAod2l0
aCBkb29yYmVsbCkuDQoNCk5YUCBJUCBTRUNPIG9uIGkuTVg4RFhMLzhRWFAgc3VwcG9ydHMgdHhk
YiAmIHJ4ZGIuIEhlbmNlIGFkZGVkIHRoZXNlIG5hbWVzLg0KDQpJdCBpcyBqdXN0IGZvciByZWFk
YWJpbGl0eSB0byB1bmRlcnN0YW5kIGZyb20gcGxhdGZvcm0ncyBEVFNJIGZpbGUuDQoNCg0KPiAN
Cj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K

