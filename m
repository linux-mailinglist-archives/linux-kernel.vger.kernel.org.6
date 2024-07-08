Return-Path: <linux-kernel+bounces-244219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA2092A0F3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE17F1F21E43
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732E77D075;
	Mon,  8 Jul 2024 11:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZWxB1cya"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A679812FB1A;
	Mon,  8 Jul 2024 11:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720437575; cv=fail; b=WP1hocmJ5nNTwqxalSrFEVWz7sHllQRYQAmY6qeJ7bUzeiEeGLPRkDe7nES6RRb8Tr6857Mh2PxxYqBLh2qVMjUuum0ZCCOt3RBB+vsPemBgecunpIvUtFdunnpLbmclBoXfGwusMhDX6LnPT3tmlo4PrMMuSq7M7xHTSmytlK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720437575; c=relaxed/simple;
	bh=Gyqd7HacjbHJtQ2uqZNZcyXnh/RFKtDnpivGTTYSFOc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UKE/cMMQNdL9/iPe7+0JU8C3Z7Bmnjo+6RaEIz1xUdBzE0IfA0HU27WeuC2wN+DbawC7X1r70GwXngD9h/ODDhRDopUcsu2rYamplJkr5iawn+B4yv5bVDtEq4mwgNABj2JqRis2I10milmyErky6ueypPPhY3PzqF/eyyFFZYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZWxB1cya; arc=fail smtp.client-ip=40.107.22.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWDl2Cl+I3Vl2jMMkFKILLH5n1I4/fzLOWr4cBzTdbWSjde9qs1ZZNXByd1AHRId+sq4PZyMKiMH0ZaPwECSZ9l4Q7HMTd9M1W1S34bGBws3my9aSQ1pTBa6cz+MFJaZqBpxfvyq8t3JO6COikrnGq6gbghr83BRV4xDEN2FK/vD4dCT7WY4S2VB+DmJBESAgWQfm5QcAwJsGNkj23GLMK2WTxdavCI8PGu9kkHO83Co6/BNHmqXR+sF4UoC5OJ8TW0m8zxHZ09B0q0qXreyzyCjvoupPOWLlUCZsuDwmXFYiJ4prICMY3xvqvSmB81s/hS7A6JcB98JBWA50GGSvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gyqd7HacjbHJtQ2uqZNZcyXnh/RFKtDnpivGTTYSFOc=;
 b=ELov6TQ5BElzPYRZB8vHZaZEmKvONX/sXyj8MfpTje5aMCA9TcUML/IgL5Dlqs9VE1lDYZdkEtpCRChft/Z7yTnWBmGinXIjJEoyoKFmebfCZHMrd7lraHlXDI+vFuZrJemQQ9GlThbgnclzeioTNZx9MRHrFqzpJ7mHSa6/su4btpmR7cIAK4UCecOhyFZrxKOcN8bqKI16bx+ybnTaoSGkC2wVTp12L37RhMOOxcklOuRp4eRtPHagWShmDutpgawDQSv2Jh7p1jwwdwrm53HXCcIPoYbuChFRLOBuU0uT/F9+J6Sr805QEl4NlI5VLbScAvJ1p8TNCu7k7/g8Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gyqd7HacjbHJtQ2uqZNZcyXnh/RFKtDnpivGTTYSFOc=;
 b=ZWxB1cyajGisH5/MSrDsPiGEAnpEdQJyc6PoBZtycNzcUAXO4gG6S982YKhvLvuhdOUisObuIJRffj2/TJXN8izrpW0zE+i29YvNmHaCZAVWuqooEEYr9IXAWNsbBhRwu3B+kas1SwS6FVWwwVfpe0fhI/i+TtPu6Y/4nvZLgSI=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AS5PR04MB10042.eurprd04.prod.outlook.com (2603:10a6:20b:67e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.25; Mon, 8 Jul
 2024 11:19:29 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 11:19:29 +0000
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
Thread-Index: AQHazuMSrg3adK0l6E2Y9DEwTEglUrHrNmCAgAETJjCAABVegIAABHLA
Date: Mon, 8 Jul 2024 11:19:29 +0000
Message-ID:
 <AM9PR04MB86040DFD0C0EF5D904BF960D95DA2@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240705-imx-se-if-v4-0-52d000e18a1d@nxp.com>
 <20240705-imx-se-if-v4-2-52d000e18a1d@nxp.com>
 <450d1575-c9b3-413b-bfa9-8dc4352fa263@kernel.org>
 <AM9PR04MB8604B9A9F3D22C35679AD1D195DA2@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <c7688fba-0570-4dc6-80c4-23cd75ed29aa@kernel.org>
In-Reply-To: <c7688fba-0570-4dc6-80c4-23cd75ed29aa@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|AS5PR04MB10042:EE_
x-ms-office365-filtering-correlation-id: 829ecef0-b29d-4d0b-4aaf-08dc9f3fd5bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dktLMGtFWEZYTE92Y1A5bFJWdlk1ZjVRZWRnUDhEM1VwVklFZlFJL1dROHdy?=
 =?utf-8?B?M3FRVTJBdmViTFV3a0hHQWdMQ1ZOSHRjRmtQd3FNOTdiMmFtclNleURSemNG?=
 =?utf-8?B?bFRBeVFFcVR4MEtlUkhmcU1tNi9mWW1JY1FSYWtEV3FRcjhJMHNjdWc4cWk5?=
 =?utf-8?B?bDJldllLWUJGcXhnN09sYU96YUpjcUV0dFRPcHJDNWM2Q2gzS0FDcS9NNHVZ?=
 =?utf-8?B?bm1TZ1k4eHVxMTBUeW45eW5aRGhMcFdRMktVanZKeWFWdDhsUitSSkJKaTRL?=
 =?utf-8?B?dlVYS0ZNMDErRTZyZ1ZUVWYySHlQdWdZdUZOSnZMa2FCNDVkbjZBN3ArUlVJ?=
 =?utf-8?B?RzlxUHBKS0diUzVWeDRTanlvUEdCY0t0T09BeW1NRHZuUVlwdFZNam5xRWIy?=
 =?utf-8?B?VVBSVzZKQSsxVkFrYjFNQzk0MXgvOXBCSjR1RGhveGQwSnpwWWJqZTZ6aUhF?=
 =?utf-8?B?aHV5OGFnZzhEdVcxUlVmSEdVQ3hqekJxNFk2UVQ1L1drR0VWOFozME43dUd5?=
 =?utf-8?B?YmZuSDBCN2ZFdFQ4cm9lMUphSVpabkhjLzd4OWdKRjhUcXltRURKa0dDdU5D?=
 =?utf-8?B?SWNEMWlXdGlETk90UXpvNTZyM0dXU1U3d0t0RWg2VVcyazhnaGN6dnZCRHpz?=
 =?utf-8?B?RXBBS1BHV0RwbEk3SG5Yc2xjQTcxY1ZFMDd2Sks3MnJsck9sY1RvQjBrekhp?=
 =?utf-8?B?R1BtQ0VrUnRCSHZ6TFN4MVBLcXJvV0RNaUJZbGM3VW9pMGJmbEE4a0pGeWda?=
 =?utf-8?B?bXRBeWZRNWtPV25RNWh5cys2cmROOFQyVnl1SzVORTNWZkZZVGZUdmlhVmJ0?=
 =?utf-8?B?OGZnVTFZb1NOUlpJNWZFVU1LcjdwcEdXQysyOWdEVEVhTGoyMTFwUFhFb3BZ?=
 =?utf-8?B?YmZHRXlxQ3J3bGVYdVRxVEpBVngvbXRDU2NJSkwzS3BqMWI4UkttRDkyTTBY?=
 =?utf-8?B?RXlpWlhhRkdPU284YytCMWRTK2tzS0dIV0tLTVF4MG1GK3ljaGQ1Y2huS0V2?=
 =?utf-8?B?WDF6cnVjOS9nVENyc2RyWDlBTUFMa2JoVnlQRWwwWHJOSUlmR0l5TjhNZWZz?=
 =?utf-8?B?TWEzRWR2TTAwM2RReXdlbkFzNTE4R0hEWkxDdFdxdE83YmhMbzZzdXBDZVB1?=
 =?utf-8?B?UmpLT3NFODBweHdKVkdPNzdidG1UU3F6YmN2VTZRSlhWeUlXWjJRTHF0YmIz?=
 =?utf-8?B?bjJUeGZIYzBYbmJFK1FCU0MyQTlQcGY1cUJFZTJkNzV5OEx4Mkw5V0dITFRh?=
 =?utf-8?B?YkFCZXB5LzFHeEdGQ1dxYjREeUZzNlNTcng4UUNwLzdDS3ZDNWZZM0RHK2pG?=
 =?utf-8?B?N3pLcStsbncvcVdsa29xL2VoWXNMOENpb281YjNwcXQ5dHU3OUFvLzVmMnVV?=
 =?utf-8?B?Wk5yeGo3eFA5N0dCMjRBNGFHamNqaVdiSDV4QVBSeFZaZ0htdllZQThJTFFy?=
 =?utf-8?B?bFZoS3BJdnFyWFZoN3NuMUdrcXpHcHdRY2V5anVud3VUZFBQRnQ3RE1CV1Ru?=
 =?utf-8?B?V1N6N3VBa25MU2Z2ZldMVjdQYjdZQkVoNUxXT2xTcGM4R3dUMS9JczdyaTRS?=
 =?utf-8?B?T2hFUUpmMTVEQnRZTXpGa0MyN1psQXNKdFJ4K3Qxb1k3MHVUMU0vMG42bWd3?=
 =?utf-8?B?VTZibGVTOVphdjI4MVdhbEQrTUNMYU8ra0Y5SStaVHZnVFhIbXJvVEg2Zm5i?=
 =?utf-8?B?VzA0QkpQTnpXZ1FBS09IR0ZtUHBabi9xZ054cXJjZnRYdXorQnk2R3k0Mm14?=
 =?utf-8?B?NnhrSWZhZFEreHdlNlJ3Z3h1TExLYlRQSWZQcUdSZkUzZ0F2amU1NGg5NVgv?=
 =?utf-8?B?YUhxdFpTM01vZmRkUC81THMyQmQyRFRmRkd4V2FuZ2dhbC9CeVZZVEZHSmlp?=
 =?utf-8?B?RXRibDNxK2NqSWxvUTNFYzJtbWFGVzF3K3A5TFRzVDhybG14MkZRNzhCcU5N?=
 =?utf-8?Q?GNMMTJ/I0ss=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDNSTXZDSUt3aEI4K2xpZHFQYVdRSDVQd0xYbzRVRE5nTGtuSXlvUFlJbktk?=
 =?utf-8?B?cFZBRWNtY2RIUWUxZnNyT0ZUMWtKWmZYbmdVRk52NUpPcHIzd1JkQlNEQUgz?=
 =?utf-8?B?V3R4UHhkOGNFdjc2UHVrb0RzeTZpQWxYUkpQY0pTSDVUWTJ3YThIbDlKd2Yv?=
 =?utf-8?B?dExjMldxRC8yZHl1d1VweWJSUjhPYWxpdkN0ZlFub3pkNGJqVHVMQ0xiNjJR?=
 =?utf-8?B?Rm56V2hLaW5SOTh4ZEI2T1krSW50RTFGSTFDVVBjc0F0S0g3VTFpNFN6dCs1?=
 =?utf-8?B?YVpDbm9sMzA4dExHZWtDZlNjYlBqKzlETWhBY1VPQXR6VTBlY3k3WTdyS2NH?=
 =?utf-8?B?bGQ3MnV5U29HaDRJdzVlVnpIM01TdDBVUVNDaytNdEQ5di9QL3J0UkVqbk42?=
 =?utf-8?B?SFRYejFOUGpsK1BIK25ndFlCMGZpSytQRTZYU2RCdjV3RU5NM3FpdDdBVmVk?=
 =?utf-8?B?aDFZV2g3dzR1SGhXQnpsOGxUNHJYeEJDaFgzbUlyV0YybUxqVlRhN2Y0c1Rj?=
 =?utf-8?B?bHVFb2kwbDZNWXhNMG5kV2FaOUUzZSs5NmI0WmJLYUs1WWMvVDBkbnBIN3Jh?=
 =?utf-8?B?Rk9iNUw2L3UzNzZGYzZMazcvSU5BK055ZkQyUHJWOW9LRlI3dDZHdGVvVXl0?=
 =?utf-8?B?NlFiY0JyZ2MybHdQV0NHMDczLzgvYXNuNnpuRWNZUFoxYlViNm5oSHJUVGxI?=
 =?utf-8?B?SDVpSWRsalRwckFub0FPMkNxMDBMZWxVUlFwdkR4MmN6VGpnemk2bHRkekw1?=
 =?utf-8?B?QnNlMzNHL1dnN051UktBZllxNldLMEF2VzlKWkh4bmRXeEZmSEozSU5GcWsv?=
 =?utf-8?B?eUgwN3pDVW9UbmVDSW15OHFiWGtxYWk1VTlISTdGMUlTOTRSbjA2Q1V2VnZl?=
 =?utf-8?B?UUNNT1JDT0J3alJpVys1SEhISVd4elFJQmIyZDBXNHorbStYRldDS29Pc3Fm?=
 =?utf-8?B?VC9sZTAvL3dwdjFmb0tKU3RZdkFNQnRXRHdpNzZNVlZKUENaWXBRdG1VZWVG?=
 =?utf-8?B?L2lidHd5RmdUU2R4YnpxaldiWXhPaGFVbWJYdkhmQVZseWZYaDFYNml6ZDg4?=
 =?utf-8?B?QjZGamt6Z0tKdjhVcmR5QUdaRmFrOUpZQnE2MlNkQmhsZDV1RHZ6NDgyWDgw?=
 =?utf-8?B?V0lvQ1BYaG5XcXN1dFBramZuSzc0ZHRVUzhDV0VycUo4R1RYSUJIVXdqaytS?=
 =?utf-8?B?Q3VVSGxocnFOYUhwTmJZL2FCWngyOVNrM1VtVG05RUNqZ0Q1eldaMTFtN0xK?=
 =?utf-8?B?ZzRnaG0xQWFYQ0taalFDdm1IZi9CYXduc1dNQWFDMVd1US9rV2pTeHZpamgy?=
 =?utf-8?B?M0lTeS9UUGxyZUkxVVk2b2QvUDlpT2E0VlZQbjEra2ZHdThrdXpuTEJ2VWRn?=
 =?utf-8?B?UTc1c0xtdkIvcTNkdlY1WWRqc0g1cVkzMDlSUkFEWktBbEpOOVF5OFJWdDBI?=
 =?utf-8?B?SWV2QjFxcWc0anJDTEhHczBXanE1Y29wOEdwdTR1NzZQdkVDZjNBb1o4ODNF?=
 =?utf-8?B?VzdDd1FXL2tFcjJwMFpGTHNZNGtMbk1DZHd2T3d6Z3IrZFBsS3RKaWFVeUQ4?=
 =?utf-8?B?Y1BFZ2RZUnNMejZ6MDdKUjRqdmlUc1REUjNkYUpUVi9vcks2akU0YWJPZU43?=
 =?utf-8?B?NHg2RTQ2YXlnUlpzTEdsZHZFdWh3dy9HSnJ1M1oremdEdkM3d3lBcllBb2p2?=
 =?utf-8?B?TXU3OHUxbnhPRFRKeFFPRW9yRFFZQjVKRVFTdlo5QUdCMmk4LzZKNDJPRXky?=
 =?utf-8?B?ZWdwUm5NMTVJR2IxTGg0SEFKNkZ4bHo2U1UxTWlPazU4U0lkMlJSTEJrazE1?=
 =?utf-8?B?L3M1RmRFNnowTXhSMDExcVQwZjZacVVCTHdiMkdFT0FmcjdEOGM5UnR5Q1ky?=
 =?utf-8?B?RFB2VVgvN2tmeW5pYXJDdTFpK3NrcTlyekUvSlEzZGxTOC9qZWJlUklJRlZX?=
 =?utf-8?B?aXYzVm91Zy9zY0lub0lnOC9CalNmbmltc3ZaTHZMdVExM0sveW5iM1N3VURp?=
 =?utf-8?B?aDlTOXBpN3FUUFAvc0hXZGV2R0RSZEdmNFN6NmdRaW1VMW41Rkx6VFdQSFo1?=
 =?utf-8?B?T0ZUWnYvL1R5WEJRcmVmVEVaMjVLVUE2UERpWGRQemY4OW9QbVU2NU03Tm52?=
 =?utf-8?Q?QmYAbbem9phbBHb+MDfPuYHGS?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 829ecef0-b29d-4d0b-4aaf-08dc9f3fd5bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 11:19:29.7308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tOU2Vep28nvfp+21vbiKdgKGPtL0udycJ088xItlLZ/gEtTSOLhNI33eO8mFWvp4b7jhynvUZwWjKGca2ou9dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10042

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIEp1bHkgOCwgMjAyNCAxMTo0
NiBBTQ0KPiBUbzogUGFua2FqIEd1cHRhIDxwYW5rYWouZ3VwdGFAbnhwLmNvbT47IEpvbmF0aGFu
IENvcmJldA0KPiA8Y29yYmV0QGx3bi5uZXQ+OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3Jn
PjsgS3J6eXN6dG9mIEtvemxvd3NraQ0KPiA8a3J6aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9v
bGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgU2hhd24gR3VvDQo+IDxzaGF3bmd1b0BrZXJuZWwu
b3JnPjsgU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPjsNCj4gUGVuZ3V0cm9u
aXggS2VybmVsIFRlYW0gPGtlcm5lbEBwZW5ndXRyb25peC5kZT47IEZhYmlvIEVzdGV2YW0NCj4g
PGZlc3RldmFtQGdtYWlsLmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBL
cnp5c3p0b2YNCj4gS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc+
DQo+IENjOiBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgaW14QGxpc3RzLmxpbnV4LmRl
djsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW0VYVF0gUmU6IFtQQVRDSCB2NCAyLzVdIGR0LWJpbmRpbmdzOiBhcm06IGZzbDogYWRkIGlt
eC1zZS1mdw0KPiBiaW5kaW5nIGRvYw0KPiANCj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5h
bCBlbWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9yDQo+IG9wZW5p
bmcgYXR0YWNobWVudHMuIFdoZW4gaW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZyB0
aGUgJ1JlcG9ydA0KPiB0aGlzIGVtYWlsJyBidXR0b24NCj4gDQo+IA0KPiBPbiAwOC8wNy8yMDI0
IDA3OjUwLCBQYW5rYWogR3VwdGEgd3JvdGU6DQo+ID4+IERyb3AgcmVkdW5kYW50L29idmlvdXMg
cGFydHMuDQo+ID4gV2lsbCByZXBsYWNlIGFib3ZlIHR3byBkZXNjcmlwdGlvbiBsaW5lIHdpdGgg
dGhlIGJlbG93IHR3by4NCj4gPiAgICAgICAtIGRlc2NyaXB0aW9uOiBtYWlsYm94IHBoYW5kbGUg
dG8gc2VuZCBtZXNzYWdlIHRvIHNlIGZpcm13YXJlDQo+ID4gICAgICAgLSBkZXNjcmlwdGlvbjog
bWFpbGJveCBwaGFuZGxlIHRvIHJlY2VpdmUgbWVzc2FnZSBmcm9tIHNlDQo+ID4gZmlybXdhcmUN
Cj4gPg0KPiA+Pg0KPiA+PiBTbyB0d28gbWFpbGJveGVzPw0KPiA+IFR3byBoYW5kbGVzIG9mIHRo
ZSBzYW1lIG1haWxib3guDQo+ID4NCj4gPj4NCj4gPj4+ICsNCj4gPj4+ICsgIG1ib3gtbmFtZXM6
DQo+ID4+PiArICAgIGl0ZW1zOg0KPiA+Pj4gKyAgICAgIC0gY29uc3Q6IHR4DQo+ID4+PiArICAg
ICAgLSBjb25zdDogcngNCj4gPj4+ICsgICAgICAtIGNvbnN0OiB0eGRiDQo+ID4+PiArICAgICAg
LSBjb25zdDogcnhkYg0KPiA+Pg0KPiA+PiA0IG1haWxib3hlcz8gVGhpcyBjYW5ub3QgYmUgZGlm
ZmVyZW50Lg0KPiA+IG1ib3gtbmFtZXMgY2FuIGhhdmUgYW55IG9mIHRoZSBhYm92ZSBtZW50aW9u
ZWQgNCB2YWx1ZXMuDQo+ID4gQW5kICB0d28gdmFsdWVzIGFyZSBtaW5pbXVtLCByZXF1aXJlZC4N
Cj4gDQo+IE5vLCBJIHNhaWQgaXQgY2Fubm90IGJlIGRpZmZlcmVudC4gSWYgdHdvIGFyZSBtaW5p
bXVtLCB0aGVuIHlvdSBjYW4gaGF2ZSBoZXJlDQo+IDQsIHJpZ2h0PyBCdXQgZWFybGllciB5b3Ug
c2FpZCB5b3UgY2FuIGhhdmUgb25seSAyLiBJdCBkb2VzIG5vdCBtYWtlIGFueSBzZW5zZS4NCg0K
VW5kZXJzdG9vZC4gIFdpbGwgZml4IHRoaXMgd2l0aCBmb2xsb3dpbmcgY2hhbmdlcy4NCg0KLSAg
ICAgIC0gY29uc3Q6IHR4DQotICAgICAgLSBjb25zdDogcngNCi0gICAgICAtIGNvbnN0OiB0eGRi
DQotICAgICAgLSBjb25zdDogcnhkYg0KLSAgICBtaW5JdGVtczogMg0KKyAgICAgIC0gZW51bToN
CisgICAgICAgICAgLSB0eA0KKyAgICAgICAgICAtIHR4ZGINCisgICAgICAtIGVudW06DQorICAg
ICAgICAgIC0gcngNCisgICAgICAgICAgLSByeGRiDQoNCg0KPiANCj4gPg0KPiA+Pg0KPiA+Pj4g
KyAgICBtaW5JdGVtczogMg0KPiA+Pj4gKw0KPiA+Pj4gKyAgbWVtb3J5LXJlZ2lvbjoNCj4gPj4+
ICsgICAgZGVzY3JpcHRpb246IGNvbnRhaW5zIHRoZSBwaGFuZGxlIHRvIHJlc2VydmVkIGV4dGVy
bmFsIG1lbW9yeS4NCj4gPj4NCj4gPj4gRHJvcA0KPiA+IFdpbGwgcmVtb3ZlIHRoZSBsaW5lICIg
ZGVzY3JpcHRpb246IGNvbnRhaW5zIHRoZSBwaGFuZGxlIHRvIHJlc2VydmVkIGV4dGVybmFsDQo+
IG1lbW9yeS4iDQo+ID4NCj4gPj4NCj4gPj4+ICsgICAgaXRlbXM6DQo+ID4+PiArICAgICAgLSBk
ZXNjcmlwdGlvbjogSXQgaXMgdXNlZCBieSBzZWN1cmUtZW5jbGF2ZSBmaXJtd2FyZS4gSXQgaXMg
YW4gb3B0aW9uYWwNCj4gPj4+ICsgICAgICAgICAgcHJvcGVydHkgYmFzZWQgb24gY29tcGF0aWJs
ZSBhbmQgaWRlbnRpZmllciB0bw0KPiA+Pj4gKyBjb21tdW5pY2F0aW9uDQo+ID4+IGludGVyZmFj
ZS4NCj4gPj4+ICsgICAgICAgICAgKHNlZSBiaW5kaW5ncy9yZXNlcnZlZC1tZW1vcnkvcmVzZXJ2
ZWQtbWVtb3J5LnR4dCkNCj4gPj4+ICsNCj4gPj4+ICsgIHNyYW06DQo+ID4+PiArICAgIGRlc2Ny
aXB0aW9uOiBjb250YWlucyB0aGUgcGhhbmRsZSB0byBzcmFtLg0KPiA+Pg0KPiA+PiBEcm9wDQo+
ID4gV2lsbCByZW1vdmUgIiBkZXNjcmlwdGlvbjogY29udGFpbnMgdGhlIHBoYW5kbGUgdG8gc3Jh
bS4iDQo+ID4NCj4gPj4NCj4gPj4+ICsgICAgaXRlbXM6DQo+ID4+PiArICAgICAgLSBkZXNjcmlw
dGlvbjogUGhhbmRsZSB0byB0aGUgZGV2aWNlIFNSQU0uIEl0IGlzIGFuIG9wdGlvbmFsIHByb3Bl
cnR5DQo+ID4+PiArICAgICAgICAgIGJhc2VkIG9uIGNvbXBhdGlibGUgYW5kIGlkZW50aWZpZXIg
dG8gY29tbXVuaWNhdGlvbiBpbnRlcmZhY2UuDQo+ID4+PiArDQo+ID4+PiArcmVxdWlyZWQ6DQo+
ID4+PiArICAtIGNvbXBhdGlibGUNCj4gPj4+ICsgIC0gcmVnDQo+ID4+PiArICAtIG1ib3hlcw0K
PiA+Pj4gKyAgLSBtYm94LW5hbWVzDQo+ID4+PiArDQo+ID4+PiArYWRkaXRpb25hbFByb3BlcnRp
ZXM6IGZhbHNlDQo+ID4+DQo+ID4+IEtlZXAgaXQgYWZ0ZXIgYWxsT2YgYmxvY2sNCj4gPg0KPiA+
IEluIFYyLCBpdCBpcyBhZnRlciBhbGxPZiBibG9jay4NCj4gPiBJbiBwcmV2aW91cyBjb21tZW50
cywgaXQgd2FzIGNvbW1lbnRlZCB0byBwbGFjZSBhbGxPZiBibG9jaywgYWZ0ZXINCj4gcmVxdWly
ZWQuDQo+ID4gSSBhbSBsaXR0bGUgY29uZnVzZWQuDQo+IA0KPiBTbyB3aHkgZGlkIHlvdSBpbXBs
ZW1lbnQgaXQgZW50aXJlbHkgZGlmZmVyZW50PyBSZWFkIHRoZSBjb21tZW50IGZyb20gQ29ub3IN
Cj4gYW5kIGZyb20gbWUgYWdhaW4uIEkgYW0gc29ycnksIGJ1dCByZXBlYXRpbmcgdGhlIHNhbWUg
dGhyZWUgdGltZXMgKG9uY2UgYnkNCj4gQ29ub3IsIHR3aWNlIGJ5IG1lKSBpcyBxdWl0ZSBhIHdh
c3RlIG9mIHRpbWUuDQo+IA0KPiBPcGVuIGV4YW1wbGUtc2NoZW1hLiBIb3cgaXMgaXQgZG9uZSB0
aGVyZT8NCg0KVW5kZXJzdG9vZCB0aGUgcG9pbnQuIFJlZmVycmVkIHRvIHRoZSBleGFtcGxlLXNj
aGVtYS4NCldpbGwgY29ycmVjdCBhcyBwZXIgdGhlIGV4YW1wbGUtc2NoZW1hLg0KDQo+IA0KPiBC
ZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

