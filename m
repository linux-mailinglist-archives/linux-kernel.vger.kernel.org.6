Return-Path: <linux-kernel+bounces-289843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BC3954C40
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13AD91C2409C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3891BD003;
	Fri, 16 Aug 2024 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hlangByW"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2062.outbound.protection.outlook.com [40.107.117.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6565413AD0F;
	Fri, 16 Aug 2024 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723818007; cv=fail; b=b0dtude0x3UDRP+NtVJG6z1nR2l8ndAsIPSntp92cnIeB7QKFVaULeuumKaDCELDnEG4J2VXMZdvvgoQGuz7yOcxRuF29Xuzq4yIxdagyDD5T0ju0aaaeEjcQZ0c83d1JTHjJBxfFUFGg3KZGH5rNnhmdn8h1TAFUsIakpaYzmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723818007; c=relaxed/simple;
	bh=q/FXWFkjasXE2QFcWtmDsTVmpCvEFZ1rb1Tc2TKQcLY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TF9cTjr2Flk1U40GzBuZjqakP43ggkhyGOEe67D3mgXSDaNAI9bHdZS/PsGxH+9v1AmEm8ED4Pjoo+4RGbMZtfjGif9J7cFeC3SeM1rO1fwEebUVIy6YO2yx+EBPtHem4fxGlZ7zjrTKw8ioAo3pMv7Y3G0BH4CzxM7Z1RR0/Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hlangByW; arc=fail smtp.client-ip=40.107.117.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2UOrNus+cDvK1g3HKT1t/vhLtU+73dRK7OazxRpaXw4Wlz0GY/RZ9HTxkgY/L4zr/duhqsXSFCDOaAY45i4xhfptzdW9aOj1dHaA0bnyWbZEWToVca+8yw/UvElq/cL+cPWIE1AMMaJkTCTYI/78MLatn4B/y0jjFQJJOyTdPSuSVj/QURG/omq0bu/C+pI6DQ1C+ycy9rVuLJbaB/HXRIlnAsIaqfhi4j7wNvLSyEpXHkxeRIEeepUfi+juTNr5HjFBoMopkBcQowG0OcO8tFZW0oSvpz1f2ZwzFJE2WedT6NWL1326kJ1lv1/4h9ZaBS3EzE6/r8/y2oLrDVVEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/FXWFkjasXE2QFcWtmDsTVmpCvEFZ1rb1Tc2TKQcLY=;
 b=bsccC5lha2yMjnu4gc01Aa19yWBnKHnO50R7BnJ7lXZeRZjwFJmIaggb6Rsy+Y+u2tySEWhbaYxZwvph2s42azxInAkPIe7inRHGFICRHdbnxFse/yrWkWnEVz9r/i5rxgf9y5qezujxAcJZKpswVc7csbgUMrrlgrt+DwqiBS4pOERsIKCJx09bYzXPaVeDUJH6k9DVS7Eg09D4BBLBZslsU6qsFORWNFUgmpaIP1JFnheBGJBkbfZKuQHWgCaZHjVTZdmy+DpnKfiyQSSM1/ein8LVjJz99l8jTyChVnbTsgedP4+c1RPuNVvsxHV3DUJZRHyjlVl2WozI9+79JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/FXWFkjasXE2QFcWtmDsTVmpCvEFZ1rb1Tc2TKQcLY=;
 b=hlangByWS8vp8po6B/xJoNcRA7m/mDnwjpegGpNQ+12+thHYNKVTIHYn6//XZ0oqz3B0Ai7qlPCDANe5j+yTvFUgduzAAjf2NptDvxXtjE5m5shqRplLnBcNqFanK5eAA/0e47xBni8UyMUZUbiTk1yRkVgI0tEJwNrLt7W10oqSnNJZBKXl3RBwPrp52AgC0wFsWydUPZ0OEUMsCCg5HLrjnOaLuc077uOi4he3UW8SF0kTpsNpakbEDeEfpaQfQuvkV0ncZnGvqRbB1Pa3RaI1AIDy51qQD241ZtXcNHBXWz+4WrtSRAPQS98V0QnkxO+Ey+Y24S71LJ8FgWsFLg==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by SG2PR06MB5010.apcprd06.prod.outlook.com (2603:1096:4:1b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 14:19:58 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 14:19:58 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"quic_prashk@quicinc.com" <quic_prashk@quicinc.com>,
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Subject:
 =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjFdIHVzYjogZ2FkZ2V0OiB1X3NlcmlhbDogY2hl?=
 =?utf-8?Q?ck_Null_pointer_in_EP_callback?=
Thread-Topic: [PATCH v1] usb: gadget: u_serial: check Null pointer in EP
 callback
Thread-Index: AdrvzihtFNSOcxRwTAOIHI6tveAOMAABV00AAACqLAAAAoTOwAAAUcYAAAD4WnA=
Date: Fri, 16 Aug 2024 14:19:58 +0000
Message-ID:
 <TYUPR06MB6217877B31A08356241CAB38D2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
References:
 <TYUPR06MB62177737F0054278B489962BD2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <2024081608-punch-coherent-d29e@gregkh>
 <CAOf5uwnsgcJjp1=RLa7qx9ScQY5rZvwX-Zu6BOqxBBhBCz+CFQ@mail.gmail.com>
 <TYUPR06MB62177BCD4AB43C19E38990D3D2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <CAOf5uwm65Cw-V+td_=6QAGUF+Uisueqcm0z=1zFaNTisAJnSFQ@mail.gmail.com>
In-Reply-To:
 <CAOf5uwm65Cw-V+td_=6QAGUF+Uisueqcm0z=1zFaNTisAJnSFQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|SG2PR06MB5010:EE_
x-ms-office365-filtering-correlation-id: 783fbec5-a3e3-456e-180a-08dcbdfe8238
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U0dmYzdBU2RvQ0wvQ2d3d2Vlb2kxUDA0K3Y3QkVkak9zZWdNWWdXT2xUazky?=
 =?utf-8?B?TFVYMVdsZDZJaVVqTHYxMzduNnJEdGNzVFVwV2FheUI3T1pqYU1JT3haT3VZ?=
 =?utf-8?B?cHZsdk41azQ5WkpKOXRvWXRsSWptbVFncFk3Z1ZKczNMQ2orOEJvTjBUUVdy?=
 =?utf-8?B?QnhzRE03OHd2aWYxWFZvUmdTSVV0alNIZmxFNGd4QzhjeTlzN0xBcHlHaWox?=
 =?utf-8?B?WW5zUWsvbDZxbFg1MFpQUEVFUjZ5eHAwTTRJTTZDN1ltS2VGVGpUQ3RFZVlM?=
 =?utf-8?B?MFo3b1d1ZHh0K044YWZDdUlmeWMvNG1lWWw0emc0UzBSRWN6V1ZaYjRlWlFx?=
 =?utf-8?B?R0MvQXB2NGFvdUdyY3d0WStGZ2YxcG1FZ2xtaTdMb1dRVGFLYlQ0anRGM0FK?=
 =?utf-8?B?R0l5RXl5dzlEL2pkaDZBSldvRHVrdVJZUjc0Z0dLendIS3FkK1NCRk0wM0VZ?=
 =?utf-8?B?RVZwU2hOTkc3QTdoQzZnbEROVE52NVZXd2t0V1VLdDVZS3NRWTBrSWV6c3Jn?=
 =?utf-8?B?NDVxZkh0dW1LbTNxcGtLZXJwd0pVcnY1SzFlb2tZY25kaXdEcUtxRzV4N0Nx?=
 =?utf-8?B?SUhuQmdYNG9pYlBLd0JGb295MzhuSWhsUStZRFQ2dSs5TnVEN0R2L2pPRmpZ?=
 =?utf-8?B?NU5VL05xeTZZcEpiMFhTNGxveDVvNVJoQ0pQa0prL2lXZTh3NVUwQ0xwdkEv?=
 =?utf-8?B?UE1hdU94Ty90SXNlVllKckRUQXhNQ3JweU9tMmxSTHVDSGxUTmNUbE1CSE9Z?=
 =?utf-8?B?SVQ4UnNwdnVwd1U1clpnOEtCeDNXaDQxd3Vpb1BxTCsvNkExWDRXNFBtck1s?=
 =?utf-8?B?V0VIZXFZWURmWEFvQXdEeEgzYXdwemMwUWZjRjQ3SlJNRzBYVFFUR1Nqc3V1?=
 =?utf-8?B?SDA0M00vS0k5VU92Tzk5NHhjMXhWWEl5bHVQNFF2TlA4OXlUdWorM1hnSDF1?=
 =?utf-8?B?bFNaWkF1REcyTE9QeTJBZkpLVkkrUmZPYTNtcnhua0ZlK29nRi9LK0RZME5U?=
 =?utf-8?B?L1dKZXNWMTE3Lzg0SUhnMWUrS256c0pveHRrdmt0Ti9mMy94dVl1YjBIaUlC?=
 =?utf-8?B?K2V4dlBZNEdLSmRQTFJhUzJSdXhBK21wMmdYdjlaUHZkWHc5QUtDVGpjM3hN?=
 =?utf-8?B?REJ6Ym8xVE1ZejhEUVdKN0pteDlRdGRhM20yZ2hBMFdTcTk3ZjlzaEJzSTdF?=
 =?utf-8?B?Z2VOcW9GdlVsRTBzNWdDUnEveUExN2RnaGkzOWg5bXp1WkxHaGkzSjNQYTY4?=
 =?utf-8?B?MHhYMHAyOC8rY080Q3pGQmJWZ1I4VGtmUjg5Mmo0NTVLNkFSOHBOTVNKL0kv?=
 =?utf-8?B?S2F1QjlYMUdEMmtTVyt6ZDQ5VWc0NG5VZ2ZPUnhIMEdVangwVmJtdU1VVGFw?=
 =?utf-8?B?OHlkSTBvWldWL2t0QzdIdWQ0ZW1rb3FVWHpPbHF1MDljMGdiNGhpeis3azNN?=
 =?utf-8?B?YWt6MFVXbk9ucm1GTnpnZjAvcnB2OFRrSXhGU0VtN0ZOa21HelBsMTdIUUcx?=
 =?utf-8?B?Z01PbzFBUmsxL1RpcjIzNEE3b203bDdaSnA2Z0hBMjNIOVNmNmUwUlFzUzR4?=
 =?utf-8?B?OWFacTJEQVJsRXg3NGxhY3RXTEk0T1ZTd1YxVlVFY01EKzRDL21TbTFVREM4?=
 =?utf-8?B?clBIdDhUWG1MWDBNQWZaa1pwVmxLclpRNXJEMm1hc3g1c2VpakF0N3B1dDk0?=
 =?utf-8?B?cVpHelRTZmlEckhYU0NIWkcxSHA2RFdtUVNuajBNbXkzRkw0bkNZWHFTNVVL?=
 =?utf-8?B?eitXYXVqWVluRTZvZUpKaTZuaTZlSW5LYWo4bTBXWTRoNjR4ZzNPbVUvOGZY?=
 =?utf-8?Q?L2MUgaTFzJltUg2lgwmo7BcKtlvyEbs7kfgDU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MjVTL1RVbmlOS08xQUhsMUJtTmMycVpnaDRieTc2NzU3ZHJMTWZ6NWtZeUN0?=
 =?utf-8?B?UWFKVnJ6YnVyb1U3YlZzYmVDMmMzWmpGaDEyRjFuUk5zRUR5RmE2bk9pSkRq?=
 =?utf-8?B?K3FSZlZRVkFVWm9rSEhBR2tUWWx2cndRRnhSU0pKUWNGeWZCL3l1b0g4ZUZU?=
 =?utf-8?B?ZWExVEsxMkFNZ25GNkVtdWZVR3V1cjB5ZldYZ0hwRlE5djJwSTlZZ0pNL0ZI?=
 =?utf-8?B?dXFuR0NPSmRLUGg4OEFxSCt3OVd3eEd1Ri9JcmlmajF1cTd3c0JiY05aOEsz?=
 =?utf-8?B?Znh4eTBCMlBQMzNqa281WGN2SDBLcCtOMFAvMU1LMEd5d3NBYk9tZG1YSVE0?=
 =?utf-8?B?UlEwZHNUVlkzREdiNHlRV0tKY1VBOGJldTJnS2E0ZTczaHFmbU1oYjBIZGM4?=
 =?utf-8?B?NFpValQwTVFVRnd3TitxRE02MFBCYXVYckhRRS9Nd0VXZjAzRDdoNCtscjBZ?=
 =?utf-8?B?alJ2SnRxc0VkTzFtbzg1eWFTR2RnVzdtR2tva2JZL0xQb0h1ckhLTzBxaTBR?=
 =?utf-8?B?ZTM2R3FSZGtqeGhoc2RKdExvZlhSRmJBVTFjalg1QUhoTmZLZU9IMk1KQTI5?=
 =?utf-8?B?U1VUYlk1ZXI1OHJrSlNJQyt0MUJHRit6OXZXNUM3NG9CUm5naE5mb3c4SWJP?=
 =?utf-8?B?a3VoVmkvd1FKSDd4U2NwOU1ibnlFL1BUZnJzYXNHQ29vL1kvdk1lNUR4UWo1?=
 =?utf-8?B?dE9Sd3Y0QXlwNGZRZGxsUC9EUWdGL2tyWFJFR1FaM05Kb1FMbUVTblczZ1Z0?=
 =?utf-8?B?c1I4R24xRUc0Y3pSQjJOdnhpUmk3WEV6RFZwYnd0b3NmUnNWSElpdXY5VnR0?=
 =?utf-8?B?dHk4b3lZTGc5eml5NFJMZ3pWOXBtZ2RCRlNEMklWSWl1K0FJdVI3RXlpekx2?=
 =?utf-8?B?L1dDWk5zZ3JoRU1MVUJQUDUxTmVhMjVXNmh2cXQ4YVNPOFQ5ZFU3SXk3eVZT?=
 =?utf-8?B?aTNURllpWVU1YkhodXRxKzlFNXY0dWF2aTYwMU5zMi9WUTlOTks3THlvTWRm?=
 =?utf-8?B?dkJHaWF1L1F1aUdUQWlQVFl4ZjRsRklJSktPam1Ma2lTSWl0ZUxpa0lvUW15?=
 =?utf-8?B?V1ZkSW1WZnpOa21UUkZSVzVRSHNKelJ4M3lxN2lWU1g5U0hKaHYyQ0l6RWxO?=
 =?utf-8?B?MzJScGJaKzRvY1p1S2c4QytjWlRjM2JVRFFIZ2s3WEFqN1hwa1cxcE1NeHBo?=
 =?utf-8?B?ZDJqS0NxdGxZQ3htd2tQL2czV2pzbjB2WlFrSVJEYmtLNnpxRVhEWUNrL3ZB?=
 =?utf-8?B?MmRpMGxKWUJlYXN1ZXNYdzZTMEVkRlFPcmUydFFNekMvOURoaFJGSS81aE1l?=
 =?utf-8?B?QzlUcDU0U1BmWlhIa2JOM2FOaXl0R1NoME1nZmxnbjNzWFQvY3VEc0ZDTWt2?=
 =?utf-8?B?SlJ2MHlmNTdQcVFuQ05MRlRUOVN4b29wVWlJOXNSTnVhRkFRbnV0OWJDeFNH?=
 =?utf-8?B?ekhiY3VqRUJXOE14N3o2bkVIcXp5RlR2bVJUUHljQUNCUDFwck8xUXp3VzZX?=
 =?utf-8?B?WmJCSUdVK1Exajd1U3Y1aElERnJ3eWxheCtuR1U2SU9nemVQM1kybXNKODhB?=
 =?utf-8?B?ZjBwRTh2Qk1Lbjg4aFBLQlgrdkYwUjF0bkNucTFkZTFzUi93eDBUYXI5TnhL?=
 =?utf-8?B?eW5nTEdScTZ6aEFxYk5BSCtqV0s4Z2VjM3ZiOUZhNTRPNG15dmRRMWtiaTlv?=
 =?utf-8?B?MVFEN0VlVnR4aS9tY21jbVd6SXBQZU9yS0RwWU1ZNGJMc2VBRFQ3Ni9mNkQx?=
 =?utf-8?B?SHBMU25xWGNyTVhTRTNNd1BIQUViT2xIR0NTZDdxbGovMDczcXV5ekhBd1U5?=
 =?utf-8?B?c2x2L1lpYXBUK3BoWm9Xd0UyNitrcm1JOElIaEs2bHRBT2pwb3M4LzB0cEFJ?=
 =?utf-8?B?QjZidU0ra0Voend0dmtXZGsrL2ppd0ZXWEZlS1pyMHpaTHhZelN5T1pTVmdx?=
 =?utf-8?B?akJ0OEsxbjhjQWVOVmh0d3N5dEdHdStOa3Z5YTdUZ3pCcE1PcTBOV2xLTHpy?=
 =?utf-8?B?QTE0RlZqbzAzcnJ3U1NPdXp5SUltWkdhbGV3aXc4MWpjR2huN1cyYU1WWXFL?=
 =?utf-8?B?anE4RzlpeWJZcGxaUHNrai9nWDU1VU93SHJjZkUweVJhSnFDYTJKRElRV2pT?=
 =?utf-8?Q?Rneg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYUPR06MB6217.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783fbec5-a3e3-456e-180a-08dcbdfe8238
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 14:19:58.3381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +aNVauHOgJv/rafvfBSyN6QXDZSqNzdQHb76xXenU0S47dT8rL37tO3Dz7h8F58cGjROyrpOZNTtTvEq1XKuNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5010

SGVsbG8gbGludXggY29tbXVuaXR5IGV4cGVydDoNCg0KPiA+IFE6IEFyZSB5b3UgcnVubmluZyBh
IG1haW5saW5lIGtlcm5lbD8NCj4gPiBBOiBZZXMuDQo+DQo+IFlvdSBzaG91bGQgcmVwbHkgd2l0
aG91dCB0b3AgcG9zdGluZyAocmVmZXIgdG8gWzFdKS4gSSdtIHRyeWluZyB0byBiZSBoZWxwZnVs
IHRvIHlvdSBidXQgaXQncyBub3QgZWFzeS4gVGhlIHF1ZXN0aW9uIHdhcyBpZiB5b3VyIG9uIHNv
bWUgNi4xMC55IG9yIG9sZGVyIHZlcnNpb24gb2YgdGhlIGtlcm5lbCwgdGhlIHN0ZXAgdG8gcmVw
cm9kdWNlIGl0LCBhbmQgaWYgeW91IGhhdmUgYW55IGF1dG9tYXRpb24gdG8gdGVzdCBpdA0KICBU
aGUga2VybmVsIHZlcnNpb24gdGhhdCBoYXMgdGhlIHByb2JsZW0gaXMgNS4xNS4NCiAgVG8gcmVw
cm9kdWNlLCB0dXJuIG9uIHRoZSBjb21iaW5hdGlvbiBtb2RlIG9mIHRoZSBtb2JpbGUgcGhvbmUg
VVNCLCBzdWNoIGFzIGFkYitkaWFnK3NlcmlhbF90dHkrcm1uZXRfaXBhK3NlcmlhbF9jZGV2IHdo
ZW4gcnVubmluZyB0aGUgbW9ua2V5IHRlc3QuDQoNCj4gWzFdIGh0dHBzOi8vc3Vic3BhY2Uua2Vy
bmVsLm9yZy9ldGlxdWV0dGUuaHRtbA0KDQpUaGFua3MNCg0KPiAtLS0tLemCruS7tuWOn+S7ti0t
LS0tDQo+IOWPkeS7tuS6ujogTWljaGFlbCBOYXp6YXJlbm8gVHJpbWFyY2hpIDxtaWNoYWVsQGFt
YXJ1bGFzb2x1dGlvbnMuY29tPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjTlubQ45pyIMTbml6UgMjA6
MTcNCj4g5pS25Lu25Lq6OiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZw0KPiDmioTpgIE6IOiD
oei/nuWLpCA8aHVsaWFucWluQHZpdm8uY29tPjsgcXVpY19wcmFzaGtAcXVpY2luYy5jb207DQo+
IHF1aWNfampvaG5zb25AcXVpY2luYy5jb207IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7DQo+
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG9wZW5zb3VyY2Uua2VybmVsDQo+IDxvcGVu
c291cmNlLmtlcm5lbEB2aXZvLmNvbT47IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmcNCj4g5Li7
6aKYOiBSZTogW1BBVENIIHYxXSB1c2I6IGdhZGdldDogdV9zZXJpYWw6IGNoZWNrIE51bGwgcG9p
bnRlciBpbiBFUA0KPiBjYWxsYmFjaw0KPg0KPiBb5L2g6YCa5bi45LiN5Lya5pS25Yiw5p2l6Ieq
IG1pY2hhZWxAYW1hcnVsYXNvbHV0aW9ucy5jb20g55qE55S15a2Q6YKu5Lu244CC6K+36K6/6Zeu
DQo+IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbu+8jOS7peS6
huino+i/meS4gOeCueS4uuS7gOS5iOW+iOmHjeimgV0NCj4NCj4gSGkgTGlhbnFpbiBIdQ0KPg0K
PiBPbiBGcmksIEF1ZyAxNiwgMjAyNCBhdCAxOjU44oCvUE0gZ3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmcgPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gPg0KPiA+IE9uIEZy
aSwgQXVnIDE2LCAyMDI0IGF0IDExOjIxOjI0QU0gKzAwMDAsIOiDoei/nuWLpCB3cm90ZToNCj4g
PiA+IEZyb206IExpYW5xaW4gSHUgPGh1bGlhbnFpbkB2aXZvLmNvbT4NCj4gPiA+DQo+ID4gPiBB
ZGRlZCBudWxsIHBvaW50ZXIgY2hlY2sgdG8gYXZvaWQgc3lzdGVtIGNyYXNoLg0KPiA+ID4NCj4g
PiA+IFVuYWJsZSB0byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdCB2
aXJ0dWFsDQo+ID4gPiBhZGRyZXNzDQo+ID4gPiAwMDAwMDAwMDAwMDAwMWE4IHBjIDogZ3NfcmVh
ZF9jb21wbGV0ZSsweDU4LzB4MjQwIGxyIDoNCj4gPiA+IHVzYl9nYWRnZXRfZ2l2ZWJhY2tfcmVx
dWVzdCsweDQwLzB4MTYwDQo+ID4gPiBzcCA6IGZmZmZmZmMwMGYxNTM5YzANCj4gPiA+IHgyOTog
ZmZmZmZmYzAwZjE1MzljMCB4Mjg6IGZmZmZmZjgwMDJhMzAwMDAgeDI3OiAwMDAwMDAwMDAwMDAw
MDAwDQo+ID4gPiB4MjY6IGZmZmZmZjgwMDJhMzAwMDAgeDI1OiAwMDAwMDAwMDAwMDAwMDAwIHgy
NDogZmZmZmZmODAwMmEzMDAwMA0KPiA+ID4geDIzOiBmZmZmZmY4MDAyZmY5YTcwIHgyMjogZmZm
ZmZmODk4ZTdhN2IwMCB4MjE6IGZmZmZmZjgwM2M5YWY5ZDgNCj4gPiA+IHgyMDogZmZmZmZmODk4
ZTdhN2IwMCB4MTk6IDAwMDAwMDAwMDAwMDAxYTggeDE4OiBmZmZmZmZjMDA5OWZkMDk4DQo+ID4g
PiB4MTc6IDAwMDAwMDAwMDAwMDEwMDAgeDE2OiAwMDAwMDAwMDgwMDAwMDAwIHgxNTogMDAwMDAw
MGFjMTIwMDAwMA0KPiA+ID4geDE0OiAwMDAwMDAwMDAwMDAwMDAzIHgxMzogMDAwMDAwMDAwMDAw
ZDVlOCB4MTI6IDAwMDAwMDAzNTVjMzE0YWMNCj4gPiA+IHgxMTogMDAwMDAwMDAwMDAwMDAxNSB4
MTA6IDAwMDAwMDAwMDAwMDAwMTIgeDkgOiAwMDAwMDAwMDAwMDAwMDA4DQo+ID4gPiB4OCA6IDAw
MDAwMDAwMDAwMDAwMDAgeDcgOiAwMDAwMDAwMDAwMDAwMDAwIHg2IDogZmZmZmZmODg3Y2QxMjAw
MA0KPiA+ID4geDUgOiAwMDAwMDAwMDAwMDAwMDAyIHg0IDogZmZmZmZmYzAwZjliMDdmMCB4MyA6
IGZmZmZmZmMwMGYxNTM4ZDANCj4gPiA+IHgyIDogMDAwMDAwMDAwMDAwMDAwMSB4MSA6IDAwMDAw
MDAwMDAwMDAwMDAgeDAgOiAwMDAwMDAwMDAwMDAwMWE4DQo+ID4gPiBDYWxsIHRyYWNlOg0KPiA+
ID4gZ3NfcmVhZF9jb21wbGV0ZSsweDU4LzB4MjQwDQo+ID4gPiB1c2JfZ2FkZ2V0X2dpdmViYWNr
X3JlcXVlc3QrMHg0MC8weDE2MA0KPiA+ID4gZHdjM19yZW1vdmVfcmVxdWVzdHMrMHgxNzAvMHg0
ODQNCj4gPiA+IGR3YzNfZXAwX291dF9zdGFydCsweGIwLzB4MWQ0DQo+ID4gPiBfX2R3YzNfZ2Fk
Z2V0X3N0YXJ0KzB4MjVjLzB4NzIwDQo+ID4gPiBrcmV0cHJvYmVfdHJhbXBvbGluZS5jZmlfanQr
MHgwLzB4OA0KPiA+ID4ga3JldHByb2JlX3RyYW1wb2xpbmUuY2ZpX2p0KzB4MC8weDgNCj4gPiA+
IHVkY19iaW5kX3RvX2RyaXZlcisweDFkOC8weDMwMA0KPiA+ID4gdXNiX2dhZGdldF9wcm9iZV9k
cml2ZXIrMHhhOC8weDFkYw0KPg0KPiBBcmUgeW91IHJ1bm5pbmcgYSBtYWlubGluZSBrZXJuZWw/
DQo+DQo+IE1pY2hhZWwNCj4NCj4gPiA+IGdhZGdldF9kZXZfZGVzY19VRENfc3RvcmUrMHgxM2Mv
MHgxODgNCj4gPiA+IGNvbmZpZ2ZzX3dyaXRlX2l0ZXIrMHgxNjAvMHgxZjQNCj4gPiA+IHZmc193
cml0ZSsweDJkMC8weDQwYw0KPiA+ID4ga3N5c193cml0ZSsweDdjLzB4ZjANCj4gPiA+IF9fYXJt
NjRfc3lzX3dyaXRlKzB4MjAvMHgzMA0KPiA+ID4gaW52b2tlX3N5c2NhbGwrMHg2MC8weDE1MA0K
PiA+ID4gZWwwX3N2Y19jb21tb24rMHg4Yy8weGY4DQo+ID4gPiBkb19lbDBfc3ZjKzB4MjgvMHhh
MA0KPiA+ID4gZWwwX3N2YysweDI0LzB4ODQNCj4gPiA+IGVsMHRfNjRfc3luY19oYW5kbGVyKzB4
ODgvMHhlYw0KPiA+ID4gZWwwdF82NF9zeW5jKzB4MWI0LzB4MWI4DQo+ID4gPiBDb2RlOiBhYTFm
MDNlMSBhYTEzMDNlMCA1MjgwMDAyMiAyYTAxMDNlOCAoODhlODdlNjIpIC0tLVsgZW5kDQo+ID4g
PiB0cmFjZQ0KPiA+ID4gOTM4ODQ3MzI3YTczOTE3MiBdLS0tIEtlcm5lbCBwYW5pYyAtIG5vdCBz
eW5jaW5nOiBPb3BzOiBGYXRhbA0KPiA+ID4gZXhjZXB0aW9uDQo+ID4gPg0KPiA+ID4gU2lnbmVk
LW9mZi1ieTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KPiA+ID4gLS0tDQo+ID4g
PiB2MToNCj4gPiA+ICAgLSBPcHRpbWl6ZSBjb2RlIGNvbW1lbnRzLCBkZWxldGUgbG9nIHByaW50
aW5nDQo+ID4NCj4gPiBUaGlzIGlzICJ2MiIgbm90ICJ2MSIuDQo+ID4NCj4gPiBBbHNvLCBzYW1l
IGNvbW1lbnQgYXMgYmVmb3JlLCB3aGF0Og0KPiA+ICAgLSBjYXVzZXMgcG9ydCB0byBiZSBOVUxM
DQo+ID4gICAtIHByZXZlbnRzIGl0IGZyb20gY2hhbmdpbmcgdG8gTlVMTCByaWdodCBhZnRlciB5
b3UgY2hlY2sgaXQNCj4gPg0KPiA+IEJvdGggbmVlZCB0byBiZSBhbnN3ZXJlZCBiZWZvcmUgd2Ug
Y2FuIHRha2UgdGhpcyBjaGFuZ2UuDQo+ID4NCj4gPiB0aGFua3MsDQo+ID4NCj4gPiBncmVnIGst
aA0KPiA+DQo+DQo+DQo+IC0tDQo+IE1pY2hhZWwgTmF6emFyZW5vIFRyaW1hcmNoaQ0KPiBDby1G
b3VuZGVyICYgQ2hpZWYgRXhlY3V0aXZlIE9mZmljZXINCj4gTS4gKzM5IDM0NyA5MTMgMjE3MA0K
PiBtaWNoYWVsQGFtYXJ1bGFzb2x1dGlvbnMuY29tDQo+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18NCj4NCj4gQW1hcnVsYSBTb2x1dGlvbnMgQlYNCj4gSm9vcCBHZWVzaW5rd2Vn
IDEyNSwgMTExNCBBQiwgQW1zdGVyZGFtLCBOTCBULiArMzEgKDApODUgMTExIDkxNzINCj4gaW5m
b0BhbWFydWxhc29sdXRpb25zLmNvbQ0KPiBodHRwOi8vd3d3LmEvDQo+IG1hcnVsYXNvbHV0aW9u
cy5jb20lMkYmZGF0YT0wNSU3QzAyJTdDaHVsaWFucWluJTQwdml2by5jb20lN0M1ZDkyNTM5NjIN
Cj4gY2E5NDRhMDUzZTAwOGRjYmRmOGIzODAlN0M5MjNlNDJkYzQ4ZDU0Y2JlYjU4MjFhNzk3YTY0
MTJlZCU3QzAlN0MwJTdDNg0KPiAzODU5NDEyMzA5NTY1NDQyOCU3Q1Vua25vd24lN0NUV0ZwYkda
c2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pDQo+IFYybHVNeklpTENKQlRpSTZJazFo
YVd3aUxDSlhWQ0k2TW4wJTNEJTdDMCU3QyU3QyU3QyZzZGF0YT1iR0xJQ2JxVDR2angNCj4gUDIy
UklHdWphenEyTjJBYnNMQWdkbmk4MHElMkJhdWFFJTNEJnJlc2VydmVkPTANCg0KDQoNCi0tDQpN
aWNoYWVsIE5henphcmVubyBUcmltYXJjaGkNCkNvLUZvdW5kZXIgJiBDaGllZiBFeGVjdXRpdmUg
T2ZmaWNlcg0KTS4gKzM5IDM0NyA5MTMgMjE3MA0KbWljaGFlbEBhbWFydWxhc29sdXRpb25zLmNv
bQ0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KDQpBbWFydWxhIFNvbHV0aW9u
cyBCVg0KSm9vcCBHZWVzaW5rd2VnIDEyNSwgMTExNCBBQiwgQW1zdGVyZGFtLCBOTCBULiArMzEg
KDApODUgMTExIDkxNzIgaW5mb0BhbWFydWxhc29sdXRpb25zLmNvbQ0KaHR0cDovL3d3dy5hbWFy
dWxhc29sdXRpb25zLmNvbS8NCg==

