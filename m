Return-Path: <linux-kernel+bounces-304536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8189A962174
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A367281B9E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B62215C131;
	Wed, 28 Aug 2024 07:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="EZ0WzBzO"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020100.outbound.protection.outlook.com [52.101.128.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BAF15B54F;
	Wed, 28 Aug 2024 07:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830763; cv=fail; b=pbNNADfd7FuHARmuYW2GXdPdzpYhBosCak1NjFw/aNJEdBsU/vsjd1fJvtWSkbHbEsWQvdp/NOYwzCWO/v2nFBUkYU0gMs5lWQOgw9mVZJ1z5RTqPgK3u5WbPAXXFyvCbJTeCYS7nrkgvhRJpUlZvMQRYhS43kF0PcA9d043SCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830763; c=relaxed/simple;
	bh=Y83HcwXBf1RT4oIBdQoO0VH86iMvtxjjMqPe9M6nEgQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dJ5LyPBbmWPsx30+6jw/A97xA/YIvugru13KjkO+nEbDK7G1ZGQ9HKk+59IUUGaI2woDvrRXV4K0F6B+ehK3Icxt3p2/swFHWC2YDKhruEfdylVwtVbTKxTixxWmyWnJ/73VqTFXnfjMZtHDs2eOj9d8i+4N05RS8Djlv3cPeMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=EZ0WzBzO; arc=fail smtp.client-ip=52.101.128.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZS7PfkMHiRhJnw4eLCTsBqvav73OiabIO14t95Nc8QEqeEV+iB54wl0lL5OHEefvGj4/6iH7W1OeCvEfEbW4DFQQYu2e7W3K8MXJE/0YUOqtNMDr8KJuGnyBpG9LYq7kzZ5Px1wV7D9WRMlEPl7uyE5m/bxH8u/cmSiIRMloWCoppc7uOCrCtPTfbUpohMiPnzSrs4ciT+/MNazevvWkQKey7snfa59vTc98utzjzRrhdrlh3MRgyrRMj2x2M0jmb//sCycmyDWWKW4IOcWRN3yl0y144SysmxYEzNUPJqTEgssxIdzuH7oo45/dCBWJXEz/xHr7P+DbLPNRZ/uY+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y83HcwXBf1RT4oIBdQoO0VH86iMvtxjjMqPe9M6nEgQ=;
 b=YhQoI4+wInIRnBnKQjLKQwhopiW8tx/eEO52pqD0JOBwGAU0XfYzNBszF+kfmoQm+Coxg365Xo4lL+Zsond8PvzMqz6bTa/KpC2E/RxXJmPT+i3LDK2appOGPvPVCPoTpCYi1vM/+ZNTpWg/CKqNN8a8u87pKDVlhH4FCMltaLmIZNgEILV402a61FMwENZUuMek9uZXrifk7s25hQDQg1BXCcrqMV0KR0nKIAUXYLaF+1oaMTPTnXBq4ERM1Yk8uVlk4Rv6j94AlLTZKiugH6x77PqE7SQwuI4bH6WJ/yjmPEdijhU/IUVAlXN/yz2zw9NhLxnG38D412rAUEgltw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y83HcwXBf1RT4oIBdQoO0VH86iMvtxjjMqPe9M6nEgQ=;
 b=EZ0WzBzOJZl3ZK/hMIn7RiWaJZqRHX5X2fw0BgjhXMoJ9OgCT4K5I8d3egmKXAXTTDGM0Kh7Uu2vpqdPyEH0iGQb2ZOuqkPa9VpzoqLMy9GexpaQDjgtzDHsJBg3hBj56MbQ6Shp+zRMD/jZdnv4aNagsH1ot1G3vYsPiXzuLdSHMXrKbmmVYz04uwM5ZORrvxAn2AG75DmAOLlsBzEvr330hnz9BptQF/XJi0DtBLiYGNHJyV7M+QZCoVkwQUbk0wzgWBSyrmvwxFm136qaZa2J1MipOnS0vErFjp+4Po+qMun/3bjNgqI34/xw7ESOabP9AwVGeAoXOyEPxUTsKQ==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SEZPR06MB6692.apcprd06.prod.outlook.com (2603:1096:101:181::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 28 Aug
 2024 07:39:08 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%6]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 07:39:08 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v2 3/3] clk: aspeed: add AST2700 clk driver
Thread-Topic: [PATCH v2 3/3] clk: aspeed: add AST2700 clk driver
Thread-Index: AQHa+RNp/f6Zl0wHLUuBnq05ailKU7I8RhAAgAACRqA=
Date: Wed, 28 Aug 2024 07:39:07 +0000
Message-ID:
 <OS8PR06MB7541F0519B4819A0A859A9B3F2952@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240828062740.1614744-1-ryan_chen@aspeedtech.com>
 <20240828062740.1614744-4-ryan_chen@aspeedtech.com>
 <231a159e-7596-46d2-a44f-bd61b2908f38@kernel.org>
In-Reply-To: <231a159e-7596-46d2-a44f-bd61b2908f38@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SEZPR06MB6692:EE_
x-ms-office365-filtering-correlation-id: f6a7335b-7c1b-4ed5-9dd5-08dcc734800d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q0tkQWZDVzVmREdWbzVvK1NQRzlZQ2V6ZFEyMzZkSVpxOVBZS1Qvbk1Vdk1Q?=
 =?utf-8?B?ZHdPMXhROU9qcEZaaSs0VTdtTHdiNys1UUVPbUNISUhFSEJyaitjelVaSmpX?=
 =?utf-8?B?amhuYjBMQXFDTUsrRmk3dzl2eUtOSlZFY0JzT2YvNGo3Um5KMVFQdVZkcndt?=
 =?utf-8?B?aGpJRG11UkFSbERWSDVXajlrRHMvaEFMSG8vK2VNNU1vUlByYndmTi9yb2xs?=
 =?utf-8?B?WXRiMW5QOEsrZXc5aFFGZnY3cDRqZzJMQk9HakNJNTNkcDdmZGRlVno0S2JD?=
 =?utf-8?B?MlVBMkNWUDFQTWEweDhrQ3AyWHl5c0ZCZTN2U3lMdnRkSGJMQzZVcVhLT3JT?=
 =?utf-8?B?VnFCRGNtck1lSW04dU0yd05VM1huVGlRck10VEhvdmlObXg0Vjh4emdaNDBN?=
 =?utf-8?B?MDZMRzNkYjRkU0ZINGpOYXFFaFRMOWpObWZQcmx4VnRiRWxhMEorM0xneFRJ?=
 =?utf-8?B?SDFkMVFPaWlDdzF1YTd4T1BjaS9UN1NwaFpEaFVVODZDUXlLbGxNYjFBamYr?=
 =?utf-8?B?bnZjcXBuVWYwSDRZRnYzcXpvaE1IL244L1J6N2N4WjEyQjV5VUxMVGw2SXVV?=
 =?utf-8?B?ekpkd2g0UUdwQ1hzK0pYOFRSemVuM0RlZHdqRnhyVERUbzFzdWphN3lFZmx0?=
 =?utf-8?B?ODBFUVNBMlhEU2htL25MUXVoczhjK25MNkZFdUU0YVpVZlQ5aHROSDRuSGs3?=
 =?utf-8?B?UnAxRlE0cVh6ZHIzS1IrSWpLQlNFaWllOXRnRnY2ajZpN3pPWGNZSU91REhm?=
 =?utf-8?B?clY5eEdWaEdGWTFQTldaMC9SWkFRMDVkT21Kd1B1SWZYOGRKU0pFanVqcnFs?=
 =?utf-8?B?Q3hlSUZYWUJTOVl2bmFrNHY3RE1mUm9oZy90cURjV1N3OUZvMEV2Tkltd09s?=
 =?utf-8?B?bi9JOWQ5RUhONW16NmZZV2pGVExqU0tpdjh3NUgraVQ2VWY3N1UzRXM1K1o0?=
 =?utf-8?B?MTMzQWNaYTJsZ0YrYklsWnM4VklQWFNsdmZTMGZyY3IvdVRic1I5MURxTE42?=
 =?utf-8?B?NWo1aFJJSkpXRmFMK2RseHhPUDl6a2t1ckorUEwzSmZocVkvYVFKNXd4Tmw3?=
 =?utf-8?B?YjM1NlRlczZIbjBGYThTejJLNk9NMHVRczViUTZNNWtab3ZNdElzbXVNQWpa?=
 =?utf-8?B?ZUU2Q09KcEVKMHoxODIveUtqKzd0ZFNubTVxbktLYkRmMUwrWkFoT1BtRGx0?=
 =?utf-8?B?a0FNM3BISEVuVnAvcWt0dDNSWDcxWDJFenRmQitsajFtY20rRk82VmxGNisx?=
 =?utf-8?B?Wm9mZXZOemhZaEN6OFk0eVZoRXNVVW4yV1JaYWpBN2pMOVdBK0FxNnBraVFP?=
 =?utf-8?B?NXJFZWY5Q3d3Q2ZiSjdMQVlyTWJiRkdvaWxUQmxzb3lMY0E0STl0UFVQSFFM?=
 =?utf-8?B?YllOc0hiNWgvZEhheThMRGtwcFJ0SXdrOXh2TTJtcGxCL1BNNG9sUU5OeGtV?=
 =?utf-8?B?WlNrbWVXVDl3eEUzTVJ3U2lKTTNKM1BweUE5MnhPczVuaVBqUHljKzZOZ2RH?=
 =?utf-8?B?emJGSWNtbFg3VUwzQmZPSGxoWU9XN3ZFZ2dwcVhzcVlCSVhzNSt3RUc5OWNw?=
 =?utf-8?B?blYxTmRZZTRoVklrQUhBOVhreVVxRVUrdkFpaGNDRWUwQUw4NjlQbHIvd1ZP?=
 =?utf-8?B?RXlMZ1p1Nmh5RENpSDlocitsamZzcWQyVEZoU1liRDQzTWp4dWk2T01MZlBx?=
 =?utf-8?B?NHhmWEovNTFidXMwbGZPWWFzcThWamk2NlBlTnB6cFNYQVFHbzdhaHdPOGd6?=
 =?utf-8?B?VTNGOElZR09GV3haRGlIUUo4NVpSVUh4aXd1V3AvSVFwRHM3ZGlRcjFHRmFw?=
 =?utf-8?B?RnI0eVp0bDM3Qi9qSjA2VWVpOHZiaElIRUxRTlI0U2diYVJsNzZUSTZrZVBD?=
 =?utf-8?B?SERnSFNWczlBWFQ2cDhIQS9nb0IzUG8xTTQ5VGlraHRNTmZFZzVzdXBSVU5U?=
 =?utf-8?Q?vpxR4fUNPts=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MURsdlhFcXBWS1ZYZ0dkMlAzNDdIZXFjNzI4OE1mVkFCeEVhWCs2eng0UXBG?=
 =?utf-8?B?TmhEWTE3cnVKbCtER000TU1NSzJ3ZXNUbS9COVVMVWhUbzQxUVc3UVdoMkJh?=
 =?utf-8?B?cGJVdFdnUVVMTE92R2ZDZ0tON1UwSlR2ZllIU3VBeWtTelZsdXExSjZGMDd0?=
 =?utf-8?B?NUN4b2xoMi9ua08xRXptWUljQXBaZGtDVlhiSC9kRDZyS0VVckZSK2JOQ2JI?=
 =?utf-8?B?dmVyenFrTk9EWnhSNWpUWUtuUUo0QkZ3MG8rUi9LNUxQdkJCZXZ1M0JKUzFS?=
 =?utf-8?B?NXExTHNMYVBDSEd3ZnZvMStka2tzY1Y1SDdxUzNyWEg0SGhnRlFXMG10MWNU?=
 =?utf-8?B?bm1QWERMY09lZFY2VkJ2dEJTTWdPWlo1TDlOc3dTdjVzckVjVG5TemZaRWpK?=
 =?utf-8?B?L2tYUnFKcUZWYjNxam5EK3FwMnA4THdUejl6L3EveDFPQUtuOGkybFRzbWtk?=
 =?utf-8?B?NkNpank2SG1aQk05cUUyaWg2RElTNjRPOU9HTFloYkVvYm4rakV1a1gwemNN?=
 =?utf-8?B?ZlhTajY5d0ZhYTkrV3poYys5bnM2ZzRPT2MzZ2V6VnBSMHhyQ0FrZldtQ3JB?=
 =?utf-8?B?ZkpTNWFHTUJOYUZGZ0lhTTdaYmtMZGxMaG9KRWxWZHZ6MUZrRXR5UkNUTE5y?=
 =?utf-8?B?ZjdickRYcEpoMkw1ajI0cDhYQXdzajBIaFBSVnNGVnVmYXhMWDdKTXdYNU50?=
 =?utf-8?B?MWR1UmtGVi9nTUdxam9ic01uQUd3cEpBbHp4UGx1YXF6dW9KUkgrVEtwd2I3?=
 =?utf-8?B?cnBpajFsV2h3RzY2NzdYcXNKMC9nS0t0YVBWbGpiVXMycHcxTVc0a215aVZs?=
 =?utf-8?B?Y01NZW1iUGcxZmFkS2tSd1UwWERiMUZiRlNPSGlqY3h4VkVJMitFeEtrZmo2?=
 =?utf-8?B?QTdnMUNsVENDNEc0Y3pIdHordHBIVkozZXFKWjREcmFXZHdsYy9hTG95V0xz?=
 =?utf-8?B?NDF0ZGhGdkRFMi8xb1cydjhCTTVJVXpNS0lCbGRPZTROaUVxR21XVitOcFVy?=
 =?utf-8?B?RC9OaHN1SHZTbVpnMmk0ekxSSHQyRTlGS2RuRVYrU3RWL3FDc09RTjJpOHZx?=
 =?utf-8?B?aFhFU0F0eHlLd2xTSVNoYUlXVndET04zLy9rZklnRGJ6NnI4N3NMMmZNMXRu?=
 =?utf-8?B?Q0MvTTRVcWx4dGU0QTFMWHFPYi9PenVWQ1BaNVFXekNzL29UVkdBdkdFZThP?=
 =?utf-8?B?ZEpNUDE0am1XMHhhSm92NGtQUHhlSHlpbktocXhJK2hvVDM2QW5GcTNISElI?=
 =?utf-8?B?Tjhna0RXOXJCWEhIWTE1MzRVVkEzZ0NIcDVPdTRmcVRNRVo5S1V6cmNQekNr?=
 =?utf-8?B?bS9NQ2NwRkpFUHZ0YXp6SlB4Ylh6MW13SmRxSHZnVmhsNUlteVU4a3FOQ1BM?=
 =?utf-8?B?c0FlY3NmQVlvZnpPZ0ZmaUwrSkljQ254aG5XT1NtckhyeFN4QnRyVGx0ekF3?=
 =?utf-8?B?dmFzeVRoaDZvMGtGeDhXb1Y2b0IvL25Jc1ZDOWt5VVVQOTRhOG9YNmZ0dFNZ?=
 =?utf-8?B?V2VhR3VuRHZtaWpJbG5pd3A4czZYcXl3OC9OUWZ2UjY0Q0xGZ0x6Zkg1dlE0?=
 =?utf-8?B?b1Y4djJlZUJMZTlmT0sxeVVIZmVyTUsyYzA2Q0VNMXc0eFpQTTAwMXoxYURO?=
 =?utf-8?B?bnlyOGdYRGp0RjFhOTJsdXpWLzduQytXRzh1eWdDei9GNW5mRllzNUoyRkxB?=
 =?utf-8?B?bHRuRnJ0Y0pyeXJOVjI5YkNiR1ZkVXFoeW1oZFUvbE1TWnZ1SDRCOXBjZ0NN?=
 =?utf-8?B?UmpSbXBBTStVSTFpQ1ZvRlFkRkdDSCttSXRZM1hWck8rRmNrSml2RmtVeEtP?=
 =?utf-8?B?cnFuOVZqYWljS3k1dGlVSU5KNVRkWEMvbWtiRzJKL1VIZE1FUzQzSGYvQjcr?=
 =?utf-8?B?NUdlWmVKOTJKMFhxa2NOdHNRZkRzQksvUFRmVjcyRGVKVEMwQ3F1dWpxazN4?=
 =?utf-8?B?MHFxYWdPTmx2akt6YWdtLzB4RXltbmVZZ3lON2FTMUx3WXp0ZnQzR1R2UlJN?=
 =?utf-8?B?WnZMRkNEelJNK09SMVlWS0llYmw1QUtQQ28wSTUvRGVHaXdqaUt6bmtJQUNO?=
 =?utf-8?B?dTBrWWJURmNlL29DVGVBMUhTSlFJejAreVFmR1NoQjhPbW1HTHdPYm1CK0hM?=
 =?utf-8?Q?bN8H/m4bsWC/Ch3d2A6t0tuQN?=
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
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a7335b-7c1b-4ed5-9dd5-08dcc734800d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 07:39:07.9784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oPrrGFenF9OjFhnvsVQSxhVB9sq79a5dvJs7EZr+SsQzUB6V7QteHc9pigTqIiQkbUxeGnMITzjNBADYHYk2d0rRJSHJ7RkegPFqDmPf9sQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6692

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDMvM10gY2xrOiBhc3BlZWQ6IGFkZCBBU1QyNzAwIGNs
ayBkcml2ZXINCj4gDQo+IE9uIDI4LzA4LzIwMjQgMDg6MjcsIFJ5YW4gQ2hlbiB3cm90ZToNCj4g
PiBBZGQgQVNUMjcwMCBjbG9jayBjb250cm9sbGVyIGRyaXZlci4gVGhpcyBkcml2ZXIgYWxzbyBz
ZWxlY3RzDQo+ID4gTUZEX1NZU0NPTiwgd2hpY2ggcHJvdmlkZXMgYWNjZXNzIHRvIHN5c3RlbSBj
b250cm9sbGVyIHJlZ2lzdGVycywgYW5kDQo+ID4gcmVnaXN0ZXIgdGhlIHJlc2V0IGNvbnRyb2xs
ZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSeWFuIENoZW4gPHJ5YW5fY2hlbkBhc3BlZWR0
ZWNoLmNvbT4NCj4gDQo+IA0KPiA+ICsJY2xrc1tTQ1UwX0NMS19HQVRFX0VNTUNDTEtdID0NCj4g
PiArCQlhc3QyNzAwX2Nsa19od19yZWdpc3Rlcl9nYXRlKE5VTEwsICJlbW1jY2xrLWdhdGUiLCAi
ZW1tY2NsayIsDQo+ID4gKwkJCQkJICAgICAwLCBjbGtfYmFzZSArIFNDVTBfQ0xLX1NUT1AsDQo+
ID4gKwkJCQkJICAgICAyNywgMCwgJmFzdDI3MDBfY2xrX2xvY2spOw0KPiA+ICsNCj4gPiArCWNs
a3NbU0NVMF9DTEtfR0FURV9SVkFTMUNMS10gPQ0KPiA+ICsJCWFzdDI3MDBfY2xrX2h3X3JlZ2lz
dGVyX2dhdGUoTlVMTCwgInJ2YXMyY2xrIiwgTlVMTCwNCj4gPiArCQkJCQkgICAgIDAsIGNsa19i
YXNlICsgU0NVMF9DTEtfU1RPUCwNCj4gPiArCQkJCQkgICAgIDI4LCAwLCAmYXN0MjcwMF9jbGtf
bG9jayk7DQo+ID4gKw0KPiA+ICsJb2ZfY2xrX2FkZF9od19wcm92aWRlcihzb2MwX25vZGUsIG9m
X2Nsa19od19vbmVjZWxsX2dldCwgY2xrX2RhdGEpOw0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0K
PiA+ICt9Ow0KPiA+ICsNCj4gPiArQ0xLX09GX0RFQ0xBUkVfRFJJVkVSKGFzdDI3MDBfc29jMCwg
ImFzcGVlZCxhc3QyNzAwLXNjdTAiLA0KPiA+ICthc3QyNzAwX3NvYzBfY2xrX2luaXQpOyBDTEtf
T0ZfREVDTEFSRV9EUklWRVIoYXN0MjcwMF9zb2MxLA0KPiA+ICsiYXNwZWVkLGFzdDI3MDAtc2N1
MSIsIGFzdDI3MDBfc29jMV9jbGtfaW5pdCk7DQo+IA0KPiBOb3BlLCB0aGlzIGlzIG5vdCBkb2N1
bWVudGVkLg0KPiANCj4gWW91IGNhbm5vdCBhZGQgbmV3IGNvbXBhdGlibGVzIHdpdGhvdXQgYmlu
ZGluZ3MuDQo+IA0KU29ycnksIEkgbWlzcyB5YW1sIGZpbGUgcGF0Y2guIHdpbGwgc2VuZCBpdCBp
biBuZXh0IHZlcnNpb24uDQoNCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K

