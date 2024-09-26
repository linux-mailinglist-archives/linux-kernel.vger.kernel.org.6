Return-Path: <linux-kernel+bounces-339798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78635986AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 03:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED9D81F20FB6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 01:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2055173357;
	Thu, 26 Sep 2024 01:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="GEw6XyfJ"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2053.outbound.protection.outlook.com [40.107.117.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC40E56A;
	Thu, 26 Sep 2024 01:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727314987; cv=fail; b=WnMoMdT9zyMw9rK4KztzlZKWd1pKBKpnIdxTySEDbZa9bQNGjftlGG8lv76MCkLVhwWSJtuoOXxoHaC0xxXANC5Tn0UGBF51aXYCudFCaz7/iAxFCIhLDxhJzduFfXcaYpazSAqjlr1yVBRNOZFna3GRejI2pj0FAidpz2ha2So=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727314987; c=relaxed/simple;
	bh=yJpsn7pLQClYeZWRyoPAbCdXWHQ0XZvcsE/Gya/gNqg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UZXfQIrBoHX7a5b4lo3dlCOWyM/UYK65Ks1uSwOwX+3eRgo/PVvD/9Guqtw7XyN2MnH6q+9rEMKpKLfVf5ZAibZd2o6RBIfdbfBElmB4MI+jNWMo3XsiX3WOKeNTLTr2i1wqFa3hgaxpB3wcpy/HEAUxKrrBV+79Yrat7hM8SRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=GEw6XyfJ; arc=fail smtp.client-ip=40.107.117.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3eXE2NNr+NvaKQOTT68dv2Xdctmik7eVGJUZvbjNrYU0Bg26DxfDALSJkqD8WCoTnGEgQ751UWuHS/dx89kVo6+84KhYQnrZKHtg4VTvWGHqHj/RChxosLInoyH/bsxJkNoVWw3juqU2RBaT+ai0ApYHfF6O29xpI5z07Miof0GBLEwQsrNj/JUeczriOJSB9FM9Hgd694P9qassJsKffQERH9v0JESZk2KKfsJ0Krn9Jl4paF6pTQEGwpuinerBgNYBoLUu1W2I45fJmmvkcTlMZWDCKsNN2JZvsltkGcbrTpqNK3ri9MsHeIurpeCLXX52Jhsr0fdPFmZJlC2aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJpsn7pLQClYeZWRyoPAbCdXWHQ0XZvcsE/Gya/gNqg=;
 b=HjRA+uuOOmIo/A4YqE7TJevLFZUisedBzTyPtoCY8m2oB//o0r2hk1wiEER6z9I5diwZcyOgCMQgd8e+VdBWeeJPuuDSeYLprd55tvvJmGFWeCQQ4za9Qy7CzcxEyGy+nAwdYpL6TXqVwP1Bwz7fwi4/Nokf28T7iOvA+RAGBI5obZFEX14v8SQQc1nW2jumcedFd4szOY7y3bzuKVa4umQlSheN/XQ0S2Dwru63xE3dleBbzKsXsBzPS4VGLwBN1gWquHG7+A2KjohI47JnOraytqw5HdUDGWJpoXDgh0NsqFQ5sVahw6okObEpys1/iPljDHP4Pa+quJJK7cD8Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJpsn7pLQClYeZWRyoPAbCdXWHQ0XZvcsE/Gya/gNqg=;
 b=GEw6XyfJS1wuq+PCMdpK1jPToiPR0J2//Rq8g5swXH224RvYJLvGlWkLyWrDX1Fkjg2YOS/ouwsLCFtymuA4bTxfM/P8nYxTGaxfJajo2rALvxYpxMbf0QyYmY8CXKsyFE90zSJMCcqvEChkyYYYadRHXx0A5Yye+3XSd48gppzgQLvfEY80uHRn+gZvn019bLWQWwc0oJIoIj1s/rMoveM/rfwAmTsHgsDG2eGOqgrlZfjNRNd9RYOQ8Gi1gIdy++Cce6PKDfMUkRqRuYoIoLMT+iK027zSjdSdOHvWJ1+RLM7jDdF/AGH1rMPp3WAYeKhBkWYUiIlwLL5m0fzcYQ==
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com (2603:1096:400:1f3::5)
 by SI2PR04MB5869.apcprd04.prod.outlook.com (2603:1096:4:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 01:42:57 +0000
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96]) by TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96%6]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 01:42:56 +0000
From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Delphine_CC_Chiu/WYHQ/Wiwynn
	<Delphine_CC_Chiu@wiwynn.com>, "patrick@stwcx.xyz" <patrick@stwcx.xyz>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
CC: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v19 1/2] ARM: dts: aspeed: yosemite4: Revise i2c-mux
 devices
Thread-Topic: [PATCH v19 1/2] ARM: dts: aspeed: yosemite4: Revise i2c-mux
 devices
Thread-Index: AQHbCytp0AbmM5OfoEqAwcoPxSX0wrJkkf2AgATB49A=
Date: Thu, 26 Sep 2024 01:42:56 +0000
Message-ID:
 <TYZPR04MB5853D45F7E64EBF3042E044BD66A2@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240920070449.3871705-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240920070449.3871705-2-Delphine_CC_Chiu@wiwynn.com>
 <59baad7d486637f7f82f2730181734eca047efd7.camel@codeconstruct.com.au>
In-Reply-To:
 <59baad7d486637f7f82f2730181734eca047efd7.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB5853:EE_|SI2PR04MB5869:EE_
x-ms-office365-filtering-correlation-id: 6d232b57-d642-484b-7395-08dcddcc8bbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eFJjeEpIc3I3QWJBdGhYZGRTVzZoQzYyQ2VWbWZXeHpQZ2FSb05UOFVMZUlH?=
 =?utf-8?B?ZEhIT1Rha25BZ01zcitIM2sxMTU2SURDdkZ6N3QzdU03YjVlSFdUQ3FwYVd6?=
 =?utf-8?B?OThYOVZLQzNRUXU3L3ovaysxbHZoY2hacy9LODJhODBvQzFhOGc2c0l5TU8z?=
 =?utf-8?B?ejl1Lzh2WEVSaXMzemxuWmNGR2lNdlQyTGNjaC9tOW82dmRMK1lkcm1JbFVL?=
 =?utf-8?B?cUZJRVdiajN2SWdQRElkTHhPSnlUd3FJWTBYMmIzSkU5NmhSb1dLcGdCeVM3?=
 =?utf-8?B?WlVkWEJuTmVCVzBSdVJGL1BsOGlBdXBiWG12eDliMlNWUGcrTFVhUWVvQWxR?=
 =?utf-8?B?bStWWVdLd2o0dnp5c28wNjd0YndTWXh1RWNGSXNCS3R5djdsR2VkbnBkWC9u?=
 =?utf-8?B?WTNMMEt5VHo0NTlQaVMrUDJTM1lESnA3TmpqT2Z5dyszT2dlc2s0b2RGS2Zm?=
 =?utf-8?B?MnJqNmRLVktCa1ZRSGJuRjVlaHIvcnFERGJBK3VXbzIrbVJwRHZIQjlIdmwz?=
 =?utf-8?B?YzJueU5yUE1HYzhhcGtnMDE4S0tGL29ZSDNXanE2ODVlcXV5S1E2VlFCQm9h?=
 =?utf-8?B?Qkt6akN5Y1M1WnIrOUpOcis2S3F1czJ4cWk1UlY2RXdFaHF2VElyQmNieXI1?=
 =?utf-8?B?TlFOSkJwUE55Z3U1TXB5UldIclhUckdaOUNlTGdlTzJ0K25QekNuR2c1alU2?=
 =?utf-8?B?eit2WEF5TUZBSHU4WTFMeW1QTTVXMDROUXIzYnhScVRLRlRrM2dYOS83Z1hF?=
 =?utf-8?B?MWxHamF3eHFRRzlOYkpjVEZDaGl2dTVOWUtLcmdISkMxM0FGVk1CT3dVVlRv?=
 =?utf-8?B?RDVBM21xVGJ3OXJOc2M0dU9pNStCWVFKUGwwMlZCL1hrWGdOK250eGt1czV2?=
 =?utf-8?B?RXZ0d256S0duVDJZL1MwRUFVSVFSMG9ra2tsWUl3THBmbDNpQ25sdVN2STU4?=
 =?utf-8?B?LzdhblgwSElodVUvdkl1dzdqM3l2dU9SYnlCTmZjaWZ0a3FabkU2Zm5PVzBp?=
 =?utf-8?B?cFdZcGUvZnJITHFEK2ErWVI0QkM1QW83RHNHTFUvbC9tYjN1dVU2SEsrYWZB?=
 =?utf-8?B?TmRrRHZSWWdORWtpMVVQS0w0bURQQzc5emxqTzJETDY5N1dGWmtUaG5BbDdr?=
 =?utf-8?B?aE41cWxLVXZBcU1Sa3A4ZmtnaW1VU3BlR3NFK2hsaW5Kam9DazhsZ2tENStn?=
 =?utf-8?B?NER2RUhFSW40THltUTNGeFhuTXUzdzhkQ0cyQzNKNnBFZkRFcW5RTHVYNm5x?=
 =?utf-8?B?RkZaWlJrR05yYUY3OHJQR2RtbjJyYTBpSEIwYndwM0hXbzNoL0ZXNzNoT21w?=
 =?utf-8?B?ajNuVEdBS0xIVzdBSVZmSnpzMVp5NzVhM3dJS2hmU0lKd1pwTnVqSDBTeGt1?=
 =?utf-8?B?WFBYNXA1V09zaFpDSjJNOUtzQVNLdTFHK25tUlA1ZHk2bFhxNEl2Y3dWRDdo?=
 =?utf-8?B?RFRsZld3cGFBS1kxazAzblNPSkZNT0xrck9IbThyb2tIYnJHYzgwNFBrc21P?=
 =?utf-8?B?THprWDNxdVJBOUR0blBOSThUR0xkUFN3ZVBuWEJOVGd3dUc0SWEydTY3djVI?=
 =?utf-8?B?OTd6b25hRHZQakxmUkhtZXMySXN2VFdjbXpNWEl3a1k1QWU1RFo5eUhhK2VQ?=
 =?utf-8?B?akFnbDR1SitsbnpTUTFmM1pkVlJOWHdURmMyRXZWUEtLNEZnV2pGTUtaZ2h6?=
 =?utf-8?B?aENGY2ZmV0R6UXd0L2EyOTFicDhybVA0YmQzSzIrdERJV0VMbDVKRTdVRWd4?=
 =?utf-8?B?ZVRxRTNYYTFhVlphQ1BsQWZkN0ZYRkJIZy9tRU1qMGM2YjFsbXVvODJZWXp3?=
 =?utf-8?B?MTBoYjRzc0wzbWtncmJIQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR04MB5853.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WDFrT0xMemQrZVdQaTFIZU95MzRsSFhqZnBzWFJBOTFZRTNOTlEwRFVwTHE4?=
 =?utf-8?B?Mk96UnhiSkl4RE1sQkdRSGNWVUpJcDlhSlhLY2pSRTFNeDlNOGRHdGg1SEZa?=
 =?utf-8?B?MEtNNy9abi9tTEVHZ1NkS3FOZDJBMHJESkl3N2FFeTVUQkZWL2krUVV1NkJI?=
 =?utf-8?B?NGJZRTIySDE0VlBpUEcrQmtOMUx3T1lSeFJYM1JvZG0waXhJbUxtbFJ1bWR2?=
 =?utf-8?B?akp0bWhRN2JrVnpyNWNuTmxnb0pzUHcxNU5qNXI5VEE3a2RrTFNPOGhsR3Zo?=
 =?utf-8?B?Q1lSQzlGRERjMWlRcFduei80L0x1L0U3RjM0dEV5eHAyNmdZd3hiZk5MY2xk?=
 =?utf-8?B?Ny9adGZsUjZHRXB4SklVVFllYUtPUEhOZzB2VzRrMUVXVk0vYnFKNWpCMmxs?=
 =?utf-8?B?Y0JxNE0xUjZUZkVkTFlkS21KOTRQWEU2QVI2aDZnMjlyWVZXR2RrRm1Yc3VV?=
 =?utf-8?B?WVhpMEpqQkJ0STV6THU2NDVnZ2ZTUUFwMFIyQjRwcndPL0d4SnA0MEhQTUFp?=
 =?utf-8?B?S0FvZTJtb2JRSEo0bG5zYlhnRFpkRXVNcEFrd3d3UzdKWW5YSnpNNFhqTGRp?=
 =?utf-8?B?WUN4QTZXWGJPYTVELzB4L2p1VkNyenNHdWFNQk9SLzViUHNCczZKRW5qNS9w?=
 =?utf-8?B?dS9TdmFCSk4wUS9VNUVDQVdXQTZsQ1NYaHB2SlFOTER0RUsxSEh3K0MrNEVr?=
 =?utf-8?B?TTg2NFBRM2k1OXhtRkJsUW5hMmFObmlKa3k1YjZxZ3NqRmdhbnBnVElKNGZ0?=
 =?utf-8?B?UnlYMmxoaTY5bU9uVzBQUUo0eS9Oa0JWMXllY0tubC9sNFJjQ2V2UHNsTEU1?=
 =?utf-8?B?cnR1NVdjQ1hYdkhiU29PTW4xUlVUeGEySFZHaXN4dTBxOUJnTXF6WlhKT3Fm?=
 =?utf-8?B?Y0xjbG1UTDl1R3Y3M3MyZ3RDblBNYjMrK29rRzYxZDlmQVAvRlFCbjA0TW5F?=
 =?utf-8?B?MVFTMlFNWW9jS2k0ZU9DVkh1TVRvZDdtWkozMkdlQVhnL2E4djNVM2pWY2dE?=
 =?utf-8?B?UFI5U2krUVU5OXMrSERJK3d1bDZMd001SlB2TzhKVTFpVUtVTVdJVWdZQmNz?=
 =?utf-8?B?QmY4b21lTEJJM285RTZRVEZkWFI2WXJGNUpYNFJsNUI3d25qN2dPZ0c2cndG?=
 =?utf-8?B?MG52L2V1OWZsd2Z6bzlBR01SVTdYNFZEQlk4MjNQeVhCOFlLQlZjVDNtUFlQ?=
 =?utf-8?B?THdvcFZvN2VhVjE1b3JydDIzUTM1ZDRvcFVzYWQwYVgyZFQ2NHZ4Q284UFRv?=
 =?utf-8?B?d083ak02d2FFUVVGSUFWREgyVlovMnBsUlJPSWdpWGVob1ZHdW5JcnRDNWZq?=
 =?utf-8?B?Q3JQTXNkVnpqU3BFY3NUViszZVlsV0RaSlozbDNZYzdySkFQUk1yOHM2ejBp?=
 =?utf-8?B?bGhDK2wwVm1NR2lPSVZ3SjdpQzRNZTdUaisvWlFZUmwxUkFXTk12Uzd2OW5R?=
 =?utf-8?B?ZytBWUdkR0ZVWGw1b0pUU1V0OHFjNE1zTXhxSWdVOVpUS0REcS84SVZnc01m?=
 =?utf-8?B?SUF3OVZPTk1lQVU5bEJ0Um5yQ1pHQXY4U2xOL2JxYjFsUDhYdTJvZjNrSDN1?=
 =?utf-8?B?ZlZCcjR1ekcwcndsd2V3S3NxdTNuNjFWc1hrcnorZ2lHWFJXbzl2NkhJZjdV?=
 =?utf-8?B?UklkbmVQem8yMTdwWTRsSFlEUXdhWHBxdVp6d2VOaWRDMm1RSytDbzF4RVJL?=
 =?utf-8?B?WitlVEhOYVBFelhZL0JITzA4RlZLUUxOSWFqTVliWU1RZTRVaEFvUXFDeG9n?=
 =?utf-8?B?b2ZlalllVDZ1bTdsZFVLNjVyVFFHbGFqYWVzZU5wUUsvSTkrcTNPT2RDR0dv?=
 =?utf-8?B?Zi95dGRDUmhROEUweStIK1pOSlQ4SUovZlBmakpzVVBVTmpyaGVSVmFHNktU?=
 =?utf-8?B?aThrRjczcHZvWG40Vlp2dTRQTjJTbWFHN2FmN1hpdk9VbjV4WUZvN3l6Y01l?=
 =?utf-8?B?cnd5cDFNQ0tOYytCMVBUUjZlNkV6QU9XakZwY2gvT0V3OStzaWZabzR2K24r?=
 =?utf-8?B?T0l2d0ZNSUh6YmJ5c1hIL0MrczZkZUJ4Q1pPLzRSTktKUEhHam1BRXNKRzJB?=
 =?utf-8?B?amc4WVFZeVh3RU02bnhXWkJwNVZKV2NEaGhxY3JGWEtTOGZXN0l2c2h1Nk1R?=
 =?utf-8?Q?ihBbtER4faHxubAAPUcLOLxCM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB5853.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d232b57-d642-484b-7395-08dcddcc8bbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 01:42:56.6807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CH74eO3ztvVPKo66a/X8GvcWoILqWq6DnOT1jzHilSRCKwqgjsboBoQKENEqL5b5jQlJ2tYjMu8qjEXMfdbaLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB5869

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IEplZmZlcnkg
PGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT4NCj4gU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIg
MjMsIDIwMjQgOTowMiBBTQ0KPiBUbzogRGVscGhpbmVfQ0NfQ2hpdS9XWUhRL1dpd3lubiA8RGVs
cGhpbmVfQ0NfQ2hpdUB3aXd5bm4uY29tPjsNCj4gcGF0cmlja0BzdHdjeC54eXo7IFJvYiBIZXJy
aW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxrcnprK2R0QGtl
cm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBKb2VsIFN0YW5s
ZXkNCj4gPGpvZWxAam1zLmlkLmF1Pg0KPiBDYzogUmlja3kgQ1ggV3UgPHJpY2t5LmN4Lnd1Lndp
d3lubkBnbWFpbC5jb20+Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1hc3BlZWRAbGlzdHMub3psYWJz
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYxOSAxLzJdIEFSTTogZHRzOiBhc3BlZWQ6IHlvc2VtaXRlNDogUmV2aXNlIGkyYy1tdXgNCj4g
ZGV2aWNlcw0KPiANCj4gIFtFeHRlcm5hbCBTZW5kZXJdDQo+IA0KPiAgW0V4dGVybmFsIFNlbmRl
cl0NCj4gDQo+IE9uIEZyaSwgMjAyNC0wOS0yMCBhdCAxNTowNCArMDgwMCwgRGVscGhpbmUgQ0Mg
Q2hpdSB3cm90ZToNCj4gPiBGcm9tOiBSaWNreSBDWCBXdSA8cmlja3kuY3gud3Uud2l3eW5uQGdt
YWlsLmNvbT4NCj4gPg0KPiA+IFJldmlzZSBZb3NlbWl0ZSA0IGRldmljZXRyZWUgZm9yIGRldmlj
ZXMgYmVoaW5kIGkyYy1tdXgNCj4gPiAtIEFkZCBncGlvIGFuZCBlZXByb20gYmVoaW5kIGkyYy1t
dXgNCj4gPiAtIFJlbW92ZSByZWR1bmRhbnQgaWRsZS1zdGF0ZSBzZXR0aW5nIGZvciBpMmMtbXV4
DQo+ID4gLSBSZXZpc2UgYWRkcmVzcyBvZiBtYXgzMTc5MCBkZXZpY2VzIGFmdGVyIGkyYy1tdXgu
DQo+ID4gLSBGaXggd2FybmluZ3MgcmVwb3J0aW5nIGJ5IGR0cyBjaGVja2luZyB0b29sLg0KPiAN
Cj4gQ2FuIHlvdSBiZSBtb3JlIHNwZWNpZmljIGhlcmU/IElmIHlvdSd2ZSBoYWQgdG8gZml4IGV4
aXN0aW5nIHdhcm5pbmdzIHRoYXQgdGhlDQo+IGRldmljZXRyZWUgcHJvZHVjZXMgeW91IHNob3Vs
ZCBzcGxpdCB0aG9zZSBvdXQgaW50byBjb21taXRzIHNlcGFyYXRlIGZyb20NCj4gYWRkaW5nIGZ1
cnRoZXIgbm9kZXMuIEluc3RlYWQsIGlmIHlvdSdyZSBqdXN0IGZpeGluZyB3YXJuaW5ncyB0aGF0
IHRoaXMgcGF0Y2gNCj4gaXRzZWxmIGludHJvZHVjZWQgdGhlbiB5b3Ugc2hvdWxkIGRyb3AgdGhp
cyBjb21tZW50IGFzIGl0J3MganVzdCBhIHByb2Nlc3MgaXNzdWUuDQo+IFByb2Nlc3MgaXNzdWVz
IGFyZSBiZXR0ZXIgZGVzY3JpYmVkIGluIHRoZSBwYXRjaCBub3RlcyBvciBzZXJpZXMgY292ZXIg
bGV0dGVyLCBub3QNCj4gaW4gdGhlIGNvbW1pdCBtZXNzYWdlLg0KPiANCj4gR2VuZXJhbGx5IGlm
IHlvdSBmZWVsIHlvdSBoYXZlIHRvIGxpc3QgdGhlIGNoYW5nZXMgeW91J3JlIG1ha2luZyBpbiB0
aGUgY29tbWl0DQo+IG1lc3NhZ2UgZm9yIGEgc2luZ2xlIHBhdGNoLCBpdCdzIGEgc2lnbiB0aGF0
IHlvdSBwYXRjaCBzaG91bGQgYmUgc3BsaXQgaW50bw0KPiBtdWx0aXBsZSBjb21taXRzIGFueXdh
eS4NCj4gDQpIaSBBbmRyZXcsDQpJJ2xsIHNwbGl0IHRoZSBwYXRjaCB0byBtdWx0aXBsZSBwYXRj
aGVzIGFjY29yZGluZyB0byB0aGUgSTJDIGJ1cy4NCg0KPiA+IC0gUmVtb3ZlIGxlZF9ncGlvIHBj
YTk1NTIgc2luY2UgdGhlcmUgaXMgbm8gYmluZGluZyBkb2N1bWVudC4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFJpY2t5IENYIFd1IDxyaWNreS5jeC53dS53aXd5bm5AZ21haWwuY29tPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IERlbHBoaW5lIENDIENoaXUgPERlbHBoaW5lX0NDX0NoaXVAd2l3eW5u
LmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2FzcGVlZC9hc3BlZWQtYm1jLWZhY2Vib29rLXlvc2Vt
aXRlNC5kdHMgIHwgNTM5DQo+ID4gKysrKysrKysrKysrKysrLS0tDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCA0NjYgaW5zZXJ0aW9ucygrKSwgNzMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0DQo+ID4gYS9hcmNoL2FybS9ib290L2R0cy9hc3BlZWQvYXNwZWVkLWJtYy1mYWNlYm9vay15
b3NlbWl0ZTQuZHRzDQo+ID4gYi9hcmNoL2FybS9ib290L2R0cy9hc3BlZWQvYXNwZWVkLWJtYy1m
YWNlYm9vay15b3NlbWl0ZTQuZHRzDQo+ID4gaW5kZXggOTg0Nzc3OTJhYTAwLi42YjRlZmI1ZmJk
ODMgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1ibWMt
ZmFjZWJvb2steW9zZW1pdGU0LmR0cw0KPiA+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVl
ZC9hc3BlZWQtYm1jLWZhY2Vib29rLXlvc2VtaXRlNC5kdHMNCj4gPg0KPiANCj4gLi4uDQo+IA0K
PiA+DQo+ID4gICZpMmMxMSB7DQo+ID4gICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiA+ICAgICAg
IHBvd2VyLXNlbnNvckAxMCB7DQo+ID4gLSAgICAgICAgICAgICBjb21wYXRpYmxlID0gImFkaSwg
YWRtMTI3MiI7DQo+ID4gKyAgICAgICAgICAgICBjb21wYXRpYmxlID0gImFkaSxhZG0xMjcyIjsN
Cj4gPiAgICAgICAgICAgICAgIHJlZyA9IDwweDEwPjsNCj4gPiAgICAgICB9Ow0KPiA+DQo+ID4g
ICAgICAgcG93ZXItc2Vuc29yQDEyIHsNCj4gPiAtICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAi
YWRpLCBhZG0xMjcyIjsNCj4gPiArICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYWRpLGFkbTEy
NzIiOw0KPiA+ICAgICAgICAgICAgICAgcmVnID0gPDB4MTI+Ow0KPiA+ICAgICAgIH07DQo+IA0K
PiBDYW4geW91IHBsZWFzZSBzcGxpdCB0aGUgYWRtMTI3MiBjb21wYXRpYmxlIGNoYW5nZXMgb3V0
IHRvIGEgc2VwYXJhdGUgcGF0Y2gNCj4gYW5kIGluY2x1ZGUgYW4gYXBwcm9wcmlhdGUgRml4ZXM6
IHRhZz8NCj4gDQo+IEFuZHJldw0KU3VyZSwgSSBzZW50IGFub3RoZXIgcGF0Y2ggdG8gY29ycmVj
dCB0aGUgY29tcGF0aWJsZSBzdHJpbmcgb2YgYWRtMTI3Mi4NCg==

