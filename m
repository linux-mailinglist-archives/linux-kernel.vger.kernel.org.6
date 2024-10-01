Return-Path: <linux-kernel+bounces-345424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDE098B62D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3E21F2257E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECFC1BDA85;
	Tue,  1 Oct 2024 07:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="Qkx74dQ1"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2061.outbound.protection.outlook.com [40.107.255.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7921419992D;
	Tue,  1 Oct 2024 07:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727769172; cv=fail; b=GJsHjsxBSO8HzO4EcWm6fVEUK25FhcQ6cajgqgF8ukJLBE/JGVBOrotIMZoDsZRZWy9EI3k7QmGF3s3gZJD+5QBl1MfpksOcmTzi710ye6qgPNepv+/6FIc8iqE9wPdpIZswnrLcZOB4foHCW90dry5qeKVGQ3o3GaxeSXd1g/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727769172; c=relaxed/simple;
	bh=dP/Czn9fsu8evogjIbPattR2+URcaLlShzH5L6Hcz3E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y/zTNGffYGcUINhaMbbcTQ6cdq3g36RZUYUjLkPHmceKZqCQRXdp3YurA5fQ01Arb5KwcGrnhyIEHgZUE2IvC5dyxyMS8zAurysDZV+geeDrt0P+U1EQQduWxCqSkx6pRjhqUeSqpr3GCduOj/NycJGkDazAVCSdq9Tn1NLXTHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=Qkx74dQ1; arc=fail smtp.client-ip=40.107.255.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hgvjz+Lo48pAr8AbB5RqWm9rR+r2QweUD+puWrT1e9jrD+TGmtupa0DHl1FQuCFAa2k8roqy38X4Ji7m2h3pHG37oIPleb8GKuiXog1cLk0yVh0LTl1V02zAXZbleaaMWe3TOK508DUW5/OQPnTBli+Ta4E6ThFwjPAW+tQMgr/N3ZK+5xh58X9ZW60P/Oqr9dOm/5onKXeBNh873OMyyhQ4d9Y3NdzvwaMfKtjPrGQEZuOgAMoNpN02H9z4hsk4mRa+c4+x0mElFZdJ6C5SFESLsLVRWoZ6UqdA/NRNOdbcBE5jINE7HVJc7ywA13c4s1Dbz5mzPRXpZdVvrB4lUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dP/Czn9fsu8evogjIbPattR2+URcaLlShzH5L6Hcz3E=;
 b=bK+6UtXUBXo5k1geAJrntwKzZI7b6rqY6g7Irjghp+7VL74bc4T69Osl2xTUs5Lrya9KEzOlNuP7U5FkyfRuRJtVzi85aRnjzRuvFDRAcrcFxyBr6VKTmTRAyUMiIe7Hf7pC5TnsyFeDy9dfMVAKbL4Go3rLYZ7GNqbgtP3/Wz5Fg7tvV/QaBezFVfqUSs/GEj3oMrSrBPKDigiySIiV/nxHoxyjN85DgR/ENhx+MFbMheZBApIMZLXt19JQ393ipHYsSbzc5ar632/Lrgg/1fEw1n9EYaI6AC6wLHGDSuSEdVbjAcZp9UAH0x9//ax1RDKq4RCAyPV1Xk9SlwGkyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dP/Czn9fsu8evogjIbPattR2+URcaLlShzH5L6Hcz3E=;
 b=Qkx74dQ1l0iCSb88Xia/zNORhXeSY4TtdaiYYCMBCagPhUEDJf2paGafZhDuB8CWz9vXFNltVdqdafEqd8M/3O4+lEL/fgDNva5b/ZxJi1ZUa4PkcvFADynuAkysS/oHgzLPOWZ8d2b+HwS38T4aA9TyhtEWo3iwOhOjb2PvORgZvXnHDHBG2GQOzO5JE3VA9GMAfEerdFjnPSxRKnNGXT3x1FAgyQkKHLmCg3bZrJD+y93DOvcbModldRPZVvL4UgdnAQxke3gkgP8AeasSZxlfX09or2LLZaRZ+jbwa0kmpKOTSLgWW9qPYyScaNC7kIkEWTHQSxcbT3I0BMJiPA==
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com (2603:1096:400:1f3::5)
 by KL1PR04MB7516.apcprd04.prod.outlook.com (2603:1096:820:11c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 07:52:46 +0000
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96]) by TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96%6]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 07:52:46 +0000
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
Subject: RE: [PATCH v1 2/8] ARM: dts: aspeed: yosemite4: Add i2c-mux for four
 NICs
Thread-Topic: [PATCH v1 2/8] ARM: dts: aspeed: yosemite4: Add i2c-mux for four
 NICs
Thread-Index: AQHbEwcaMrmlQxTcsU+R+KRlEx+LtrJxDhuAgAB3jQA=
Date: Tue, 1 Oct 2024 07:52:46 +0000
Message-ID:
 <TYZPR04MB585305DCD18AF723B8A48480D6772@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240930070500.3174431-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240930070500.3174431-3-Delphine_CC_Chiu@wiwynn.com>
 <fffb98e40d407c68dc3de6fd21c8a724be96e38a.camel@codeconstruct.com.au>
In-Reply-To:
 <fffb98e40d407c68dc3de6fd21c8a724be96e38a.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB5853:EE_|KL1PR04MB7516:EE_
x-ms-office365-filtering-correlation-id: c25dc48c-c8a9-4705-fb52-08dce1ee0a03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VGJTYkdXWmo1UDVHcTJmeHBNTUxoK2VvSW81TlRFT3RKZGRkUjFyNXZySjc2?=
 =?utf-8?B?Yjc2NnZqVm9EUFJFUG51TnRtWDBRRDBYSU1TSkZuUlI3d2xubGVzUm5mSWEx?=
 =?utf-8?B?ak1mUVpldkFHdXh1c20wSmNEN1dOVSs1cU05K2x3WlBaTGV5YStrMEtwMG81?=
 =?utf-8?B?cXhUL0Y2TEpuRCtnY1NRRGF1L1lQVENwenF5NnFZbFQ1QWhicllzdXh0eXZ1?=
 =?utf-8?B?UnRuVjVLcHExeC9EU0QwRzRJU2tMQXd6U2sxS3ZNaUcrbDFXRExXQStTTS9L?=
 =?utf-8?B?QnVRNlhxazA1UzVIUUhxQ2lLVW10eFZ3VURLbE5DQzZFTVlQNHV4bWRjZGpO?=
 =?utf-8?B?SmoxTUtYM1lNZWJvQjZLWjJKNDVYek5VWk9vS0ExWHVWNmF0YzlMTDFodXVF?=
 =?utf-8?B?aE54RGwraVlmTDJLd3RXOEp5QWZZRnljbHJzczBuNU9BNDFLZ1AxSzE0ejlv?=
 =?utf-8?B?SU1HTHpURUdKclpBbGdFTVNySC9LVGVHNnN1dVBJcERVblM3RGh4d3EzR2FD?=
 =?utf-8?B?b2F0bzRlK2xyb0czYU1SaG9vWHN3Ry9nUlBac2tkY3RJZlAyamFybXI3RVVB?=
 =?utf-8?B?Rmg5Mnl2djM0REVlR1dqSHdnUDcvQXdhMkw0V0lkS0JRc05JZW9nTzJ3MjVr?=
 =?utf-8?B?RjVRRHJnQWh4R1pFamR6SUduNmF2MnVMcXR0cmJ6VHBaNjJSV0pjR2tFWUs4?=
 =?utf-8?B?Z1hLaXNhVEpNcm1SdGpnbzcyTEZjdzM0OSswWmc1cDRlS0xPOHBPRXdRd0gr?=
 =?utf-8?B?SGg4UTFXS01hWFBLRGRZT0tzbXZWZ1FvTUJHK2hXZTdHUm80dHZuTXZQOG1B?=
 =?utf-8?B?MFVVR3RjdGVPWWFwTWFTa3c0QjJIMnhvMWZGQndxV2crRjhCRTFFQ3dmcGZB?=
 =?utf-8?B?dzhIWGdmNThxUjRtU3lYbHV2MFlCdjB1K2pVL1JhdjVlN20rRjJxbnlLbGRn?=
 =?utf-8?B?Z1JLUnEzOTRFdkJCQ05HSnRIcEZoOC9wMWcvaHJUbkFzNzdKTlc4YWg4YzNM?=
 =?utf-8?B?UWpkRUFwYkR2UTBrbC9WTXBEc2I5VnRxeUE0ajJTeS9HTnppb2JXOWgyT3lD?=
 =?utf-8?B?T1VLeGNrRkN3Qkc3bzlZWGdXZG1OMTdGZmF1ZWc0THFPVlFaWm1oY25ncTRE?=
 =?utf-8?B?bXZub1pXS1lQNkkvVlJ6enZUQjZTM1VBR1h1cnZZZnBJa2laelZkTm9WeHdT?=
 =?utf-8?B?eXhvNWc0OHFTM3ZkSGZpQmJxaUdkcXZjaG1tNG5rYUwrRllyWXFmT0FEMGk2?=
 =?utf-8?B?cDkxSTR3d0tZVjdNRTlGdG5QY1FxcER3VFJBdnZCd0FqV2g3dGwvNFUvR1lF?=
 =?utf-8?B?U0RVbGw1Ly9STDNKRHdWOTdlS3hOK01uWjR5SmtkYTYrekl1L01yVm9KcGo4?=
 =?utf-8?B?ZWIwbmsvRUdUZHBrbWg5RkdRUnF1ZitycEhJSVhDN0hTQ0JFdHpSekdzanBG?=
 =?utf-8?B?WkRIK24zNElCSS9qM2VRVDRqZWVkdHFSYWxheXB5WEJzSzFMRUhKTUxuT3Bj?=
 =?utf-8?B?eWU4SnNpTzNTdElCaHFnZTZRM3FjUnVBZi9lQ1A0clIzcmlwQ3J3aHlhekF2?=
 =?utf-8?B?b1FmZDdFSzlua09yTTJBdktvOEcyY3YrYll0bDExRzVZS2xEOS9rQys1SFdy?=
 =?utf-8?B?MlJsem8wVThaWUVOL3Z1ZTJyU2pHSjhiNjZpa2lpNy9nNnlrRGhnTUw2NEtw?=
 =?utf-8?B?Sm01dWVuK1c0bHhVUXRLSjFQVkUvbmV2SEtHRHlhTTA0VnlPTUNiTVpPUFQv?=
 =?utf-8?B?aWF5VTVTZUlqNlN0UjBoay9UNSt6VWkyTHB2TjNLK2xIVllRWGd1d2xpQ0U3?=
 =?utf-8?B?VlVjVDNScGR5bkJ3MndHR0pzbmc2cTE4N1Ywak42SVFwUzgvcTdQRDhydUdT?=
 =?utf-8?B?YlRPRnREeU5wQmNkV0pVWGR6enk2R3l3UGthMVJOTXBHSUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR04MB5853.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OWpLTDljY0xXNEpyYmFvaytUc3ZGdW0wdHkrTjkrUFNyTGdWRmo0VWF1cit6?=
 =?utf-8?B?ZzVJMVo1eHpXTld3TytNWEVkeUl0Y3kwWTQ5VzI3RThjQUlCWkJ4NzVPdVd5?=
 =?utf-8?B?eFVzZVhGRFZoNzhicHlUT0lzSlhDbkoyaXZ5VDcyUy9mV1Bma3I1S1R6Z3Zp?=
 =?utf-8?B?OEVySnNwTElSUEFadklhRjFvaXZSMm9WVWxWZk1ZU0RoT0tsOVd5YnpvdmI1?=
 =?utf-8?B?MTJyQlV2Uk83RmhaVzlBd1RodGpGNXBwS0ZPMnI1bmh2U0ZWMUtSOThuR2tB?=
 =?utf-8?B?Q0Jxc3F5U09Tb3FiVFRYQS9uZFhNSzhnbTZkRkVjVE52ZDVvMUZselJiMytK?=
 =?utf-8?B?QUNZWFZyWWJGc0RmQUZKZDZHazFibG5DRVUvWjYrV010QjV6S3IxUUEvU0Jz?=
 =?utf-8?B?WFpvakx5bTdpbERnSUt1MG1zY0dTMlZ4UEF0d1pHSVh0ZFFtVElFaTdwc1FL?=
 =?utf-8?B?SkgwalFyN2RkRGlob3phR3hZa0ZyN2dSSmJ2c1NFREFaS2ZWZ3hCZ25Yckw2?=
 =?utf-8?B?Y0M1Y3BaZm1HcnBMWTFnY1pYcnRrT1YwUlIrQVRtOU5acEM2SXlTK2loM2tu?=
 =?utf-8?B?MEJEcUVsS2hoa0wwL1JLSjNmYzhsMldoZVY2THI1MkZ6dGZpN05rUkZ5dVFx?=
 =?utf-8?B?MDFMenFsSWR3OHhqOVRZR09OSWNtZG9leTBOR1o5WXY3UVQ2djUwRkppN2NK?=
 =?utf-8?B?NVJINnZrbWM5YlFkTVZTR2xNbVZmb29iUzA1TFA2UVdLZytDZ2UxSWovK1lx?=
 =?utf-8?B?TDBtNHpUdSsrdEppalZzK21OU1BvcmluaUh3clozUHNlYjljZHhLRFBFdDVz?=
 =?utf-8?B?dUEyTUN1djVGQmI0N3lpTWU4N0EvN1FlSlAzcm9QSE9kek1TSlR4TVV2NDJn?=
 =?utf-8?B?c3dtalZTK1dmQW14SjRlZWpKTHdxR0JvQ0VpOUxmQXorMU5tRzZKMU12Qi9v?=
 =?utf-8?B?M3AzNlFGL3FUQkFZc3dYTzlrc21xRll3Ly8xQmtoK3JWYTNUU010QlVoelcz?=
 =?utf-8?B?dVdLSTJkNnNMdi94bzJkUWpVYlFlRXhrRm5kWUlBTy9jZlRON29oTkczTG5F?=
 =?utf-8?B?a2szcFdoc2tkdVlRWTJYQU80RHVIU2hDMGIrWHlER1dBU2NLUXhFS1d3bk0r?=
 =?utf-8?B?ZDB1bEFQQXZ5Y1ZaMGd5cW9jVU5OTDRMN3hqK1ZoaUpraHFzdEhKaWIyZG1T?=
 =?utf-8?B?Z1NwSE9VeWlCRzcwTGNSSWtFSGpIc2FIOW9zTFczN2p1ZmlZUWI2b1NVbmsy?=
 =?utf-8?B?R04rcFArUTdORmVPMVVqZEdWRE1pMGhhdmNlR2x3Mk50SUZwTkVVbXRycWtR?=
 =?utf-8?B?RlpqenY0YXdFZ2pKbGFUNGFlODM3TDVVOWE3STdrNkppZEg5aDF3azhxVEpM?=
 =?utf-8?B?R3Y0d2ZMMVJtNWVZQ2o0OVNVSWxQd1dpcUlWeG5KdGJ0RUxMNC9YOW82Y1RP?=
 =?utf-8?B?alZHZUMycE55VThlQ0ExQzZ4K1pnY2ZCOEhoVkJ1UWFidzFsRWpDK0llOU92?=
 =?utf-8?B?N2dVVlpVNmMyM0YzL0lUejNOclZTTzhSWVdYWDdMWStkUDdsN1RUekFwQmVT?=
 =?utf-8?B?cWorTjdSMlo1NzlWWGlPVm1SOUNuN1ZMamN4eHh6VUVsWWpzK1h2b0NsZjFW?=
 =?utf-8?B?RFpQVHJsRzBtcy95ajBNamVPTldyTndiRysvZTcvbThnVllvMTJ1RVdlMGoy?=
 =?utf-8?B?eHkwYmZPZ1c4V2NyamFLOHFRd2twR2NhMGxPT0lSVEZEZ0t5NGV3L3c3MkJ0?=
 =?utf-8?B?K2FSbTArc2NST0g5R1N0dFVML1JkMTBQYlRsRFRmbUxubDNKNEt6b2FXbEkw?=
 =?utf-8?B?b3YveE5wZThoUWZvK2JkcHQrRzcyeEtzajE1ZjlVenRLZlRwYWhkYUZLeFV4?=
 =?utf-8?B?dUIvQlU5RExDeFVFc2hCbllHaEgxMmkrQ2loS0Z6bnRiWjcyVGdQVWFwVVNo?=
 =?utf-8?B?UDgxckE1bU1PandUWTlIMmFtOWRkL1FmVDdET3BNakQ5T0lQSmE1QUxibGUw?=
 =?utf-8?B?TGduMEFkNHFleGUxZHQrS2FBbkdTbUk1TERKVU1jRC9zSkd0bTQxelJCdWNy?=
 =?utf-8?B?R0RrSVQrZy9IcVZ1WHJpVm92UUF5ckVsYUg1ZzJtRUg0cWkvWmRZKzd3Qi9V?=
 =?utf-8?Q?KBKbNumw/Ikzm79LlWBUwsguA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c25dc48c-c8a9-4705-fb52-08dce1ee0a03
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 07:52:46.6130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o+ZXd2Niz4JLGEIoYPrTGAFnXmMMnKTwTY6KtePuU9LubMFCReOOcSYgl8YOB3XS3DFKJNmu3bSHEdgmuPH6pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7516

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IEplZmZlcnkg
PGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT4NCj4gU2VudDogVHVlc2RheSwgT2N0b2JlciAx
LCAyMDI0IDg6MzcgQU0NCj4gVG86IERlbHBoaW5lX0NDX0NoaXUvV1lIUS9XaXd5bm4gPERlbHBo
aW5lX0NDX0NoaXVAd2l3eW5uLmNvbT47DQo+IHBhdHJpY2tAc3R3Y3gueHl6OyBSb2IgSGVycmlu
ZyA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraQ0KPiA8a3J6aytkdEBrZXJu
ZWwub3JnPjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgSm9lbCBTdGFubGV5
DQo+IDxqb2VsQGptcy5pZC5hdT4NCj4gQ2M6IFJpY2t5IENYIFd1IDxyaWNreS5jeC53dS53aXd5
bm5AZ21haWwuY29tPjsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgtYXNwZWVkQGxpc3RzLm96bGFicy5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
MSAyLzhdIEFSTTogZHRzOiBhc3BlZWQ6IHlvc2VtaXRlNDogQWRkIGkyYy1tdXggZm9yIGZvdXIN
Cj4gTklDcw0KPiANCj4gIFtFeHRlcm5hbCBTZW5kZXJdDQo+IA0KPiAgW0V4dGVybmFsIFNlbmRl
cl0NCj4gDQo+IE9uIE1vbiwgMjAyNC0wOS0zMCBhdCAxNTowNCArMDgwMCwgRGVscGhpbmUgQ0Mg
Q2hpdSB3cm90ZToNCj4gPiBGcm9tOiBSaWNreSBDWCBXdSA8cmlja3kuY3gud3Uud2l3eW5uQGdt
YWlsLmNvbT4NCj4gPg0KPiA+IEFkZCBpMmMtbXV4IG9uIFNwaWRlciBib2FyZCBmb3IgZm91ciBO
SUNzIGFuZCBhZGQgdGhlIHRlbXBlcmF0dXJlDQo+ID4gc2Vuc29yIGFuZCBFRVBST00gZm9yIHRo
ZSBOSUNzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmlja3kgQ1ggV3UgPHJpY2t5LmN4Lnd1
Lndpd3lubkBnbWFpbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogRGVscGhpbmUgQ0MgQ2hpdSA8
RGVscGhpbmVfQ0NfQ2hpdUB3aXd5bm4uY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYXNwZWVkL2Fz
cGVlZC1ibWMtZmFjZWJvb2steW9zZW1pdGU0LmR0cyAgfCA3NQ0KPiA+ICsrKysrKysrKysrKysr
KysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDcyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9hcmNoL2FybS9ib290L2R0cy9hc3BlZWQv
YXNwZWVkLWJtYy1mYWNlYm9vay15b3NlbWl0ZTQuZHRzDQo+ID4gYi9hcmNoL2FybS9ib290L2R0
cy9hc3BlZWQvYXNwZWVkLWJtYy1mYWNlYm9vay15b3NlbWl0ZTQuZHRzDQo+ID4gaW5kZXggZGJj
OTkyYTYyNWI3Li5iODEzMTQwYjNjNWIgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm0vYm9vdC9k
dHMvYXNwZWVkL2FzcGVlZC1ibWMtZmFjZWJvb2steW9zZW1pdGU0LmR0cw0KPiA+ICsrKyBiL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtYm1jLWZhY2Vib29rLXlvc2VtaXRlNC5kdHMN
Cj4gPiBAQCAtMjYsNiArMjYsMTAgQEAgYWxpYXNlcyB7DQo+ID4gICAgICAgICAgICAgICBpMmMy
MSA9ICZpbXV4MjE7DQo+ID4gICAgICAgICAgICAgICBpMmMyMiA9ICZpbXV4MjI7DQo+ID4gICAg
ICAgICAgICAgICBpMmMyMyA9ICZpbXV4MjM7DQo+ID4gKyAgICAgICAgICAgICBpMmMyNCA9ICZp
bXV4MjQ7DQo+ID4gKyAgICAgICAgICAgICBpMmMyNSA9ICZpbXV4MjU7DQo+ID4gKyAgICAgICAg
ICAgICBpMmMyNiA9ICZpbXV4MjY7DQo+ID4gKyAgICAgICAgICAgICBpMmMyNyA9ICZpbXV4Mjc7
DQo+ID4gICAgICAgICAgICAgICBpMmMzNCA9ICZpbXV4MzQ7DQo+ID4gICAgICAgICAgICAgICBp
MmMzNSA9ICZpbXV4MzU7DQo+ID4gICAgICAgfTsNCj4gPiBAQCAtMTE5Niw4ICsxMjAwLDkgQEAg
YWRjQDM1IHsNCj4gPiAgfTsNCj4gPg0KPiA+ICAmaTJjMTUgew0KPiA+ICsgICAgICNhZGRyZXNz
LWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPiA+ICAgICAgIHN0
YXR1cyA9ICJva2F5IjsNCj4gPiAtICAgICBtY3RwLWNvbnRyb2xsZXI7DQo+IA0KPiBXaHkgYXJl
IHlvdSBkZWxldGluZyB0aGlzIGlmIHlvdSdyZSBub3QgYWxzbyBkZWxldGluZyB0aGUgTUNUUCBl
bmRwb2ludCBub2RlPw0KPiANCj4gVW5sZXNzIHRoZXJlJ3Mgc29tZSByZWFzb24gdGhpcyBpcyBy
ZWxhdGVkIHRvIHRoZSBOSUNzLCB0aGlzIHNob3VsZCBiZSBpdHMgb3duDQo+IHBhdGNoIHdpdGgg
aXRzIG93biBqdXN0aWZpY2F0aW9uLg0KPiANCj4gQW5kcmV3DQpIaSBBbmRyZXcsDQoNCldlIGhh
dmUgZGlzY3Vzc2VkIHdpdGggSmVyZW15IGZyb20gQ29kZSBDb25zdHJ1Y3QgYWJvdXQgcmVtb3Zp
bmcgdGhlDQptY3RwLWNvbnRyb2xsZXIgb24gYnVzIDE1IGJlZm9yZS4NCg0KSGUgdGhvdWdodCBp
dCB3b3VsZCBiZSBiZXR0ZXIgdG8gYWRkIHRoZSBtY3RwLWNvbnRyb2xsZXIgb24gZWFjaCBpMmMg
bXV4IHBvcnQNCnNvIHRoZSBNQ1RQIGRyaXZlciB3b3VsZCBlbnN1cmUgdGhhdCB0aGUgbXV4IHdh
cyBjb25maWd1cmVkIHByb3Blcmx5IGJlZm9yZQ0KY29tbXVuaWNhdGluZyB3aXRoIHRoZSBkZXZp
Y2UuDQoNCkknbGwgc3BsaXQgYSBwYXRjaCB0byByZW1vdmUgdGhlIG1jdHAtY29udHJvbGxlciBv
biBidXMgMTUgaW4gbmV4dCBzZXJpYWwgb2YgcGF0Y2hlcy4NCg0KUmVnYXJkcywNClJpY2t5DQo=

