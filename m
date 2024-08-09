Return-Path: <linux-kernel+bounces-280415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0013894CA31
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8AB287B03
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 06:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94EF16D9BF;
	Fri,  9 Aug 2024 06:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="iJn4PYLo"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020108.outbound.protection.outlook.com [52.101.128.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A75216D4D9;
	Fri,  9 Aug 2024 06:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723183832; cv=fail; b=aTTgPqEYSYNTVD5phn7TiBTlpd9I3bNJ5/nlQx+eFrvhBsrOUaPVFXgg97CJd9JUEQ6xvSlJFQRMd8hU1H5imzadmdNNyafC2p9dMcAuIY58nuM5YoZ4GuUWb6HCog6IKZyhq/FkB4RJFdGaoklhpSpDzE67uXFGUNsNz0C31Dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723183832; c=relaxed/simple;
	bh=PLBBP1QPMmtzltocB8TOblwRsnlSoiK5rpxqSwoFY7M=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QuVNpHvdwLvswoV7q4mqIq7zS9nJrrEZHMyjvjV6yXyOkFPxpDqMRSgUWbC/6FCQQS7c45JJWQK/YyJrh2kTpNos/8ZHHekbeAQFJp+BpjN94NlhjcVvnsEGXZmjfswxPSQE+r7ui6QD7iHLoSuALRfbezslBIUrw48QdISVtso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=iJn4PYLo; arc=fail smtp.client-ip=52.101.128.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cro+183qzowEsmZnAbJQeJb0UrqVUaClc8C7ZbJXY9CJ55LCZ51SySiNXAiT3l7kofE9w4PJ5+lnuLEEuAVHS7AcaQeN3FkPEiAoHDVeM3izfaPeJkzj0HXmzx2jZBHB9ejvZLyD9m38XWioHUHGpMujzoc/jLrjToEZWvGYIG5tNkTMHwh0PLfwth36mawIj+mxViN6OluFH0+lTaJAdIwFNlWQdB8G1P6l5G8zWOcaLrZZjFFkm+ryp0uyUrvPAU8CyCXMRLcqvlALe6YWuVsZVbYg1Yzt4kGpKU596kaUch+jC4a7CF1RNcR6MkgKnQeMRCbUf5JFi6la/z/xxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLBBP1QPMmtzltocB8TOblwRsnlSoiK5rpxqSwoFY7M=;
 b=unHfsbJeRagNxgkt0o+6s6N7AFYc3EZtrHOyKlWG3QvvCSPgfyer5xfTOcwtux5KEsBZbmQ/JjuT8exRXocsebtH8+8l/g278UkY8/RSytUoHXuGBL7W5uL4SoiW06d020SqaTc+oi9w5H6eM02x2OKI+WAlco/mAMt+brfLvHlFpuaS3xLVuqqIyhPsqO9YHVIHNdwFHBO+p8Uti53aGjXdtbAYRFKqF82o+N8tOBqyvxtMn1dkDOsf4mK0y2jzUrWOOCObAXf5iT+uLwi7/r484aY3XTTwWzucqCCApJuha5cfPd8tmAe1Jw4Ba/+6+lPOjUaVyGHLZCVwFizPqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLBBP1QPMmtzltocB8TOblwRsnlSoiK5rpxqSwoFY7M=;
 b=iJn4PYLonBj3Ne2NoKICd6yXthPLl9ScS+QFOds3jkMludDRHmI2k0jjwL/saDdS1OrU9SpB/Wt/pV9s00NhJHB4tzVbpL4EDTD8NyV4tgYGevzTLrxrBiyXO+Oon8NtzUVqRceN20R49QivsEW+cQD9290zr51+mSQWSFtnxKY4d9eNHK7+lgSelCu9EAISKfv24iF3wHwrDE1X2QTHVGsufj/eVxP/pM+MuoJau1KjvSdI68tfmSKtXT409f790PvduagnwLRfen8OqNiiapQd5z6a85xjV5eOIUtfvipfUs2g6WI36zx3qc8tnvM6e+7kCrxAoU1Jhf4gfLHBqg==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SEYPR06MB5720.apcprd06.prod.outlook.com (2603:1096:101:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Fri, 9 Aug
 2024 06:10:22 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.7849.008; Fri, 9 Aug 2024
 06:10:22 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
Subject: RE: [PATCH 1/4] dt-bindings: mfd: aspeed: support for AST2700
Thread-Topic: [PATCH 1/4] dt-bindings: mfd: aspeed: support for AST2700
Thread-Index: AQHa6Wjwpmm6AqTUmky9VcIbkjW1JLIdJMiAgAFHtRCAAAQ8gIAAARxA
Date: Fri, 9 Aug 2024 06:10:22 +0000
Message-ID:
 <OS8PR06MB7541F4F740FDB17F50EBCACBF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
 <20240808075937.2756733-2-ryan_chen@aspeedtech.com>
 <2f27285e-6aa5-4e42-b361-224d8d164113@kernel.org>
 <OS8PR06MB75416FAD2A1A16E7BE2D255DF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <10809e91-31be-4110-86c1-1e1ccb05b664@kernel.org>
In-Reply-To: <10809e91-31be-4110-86c1-1e1ccb05b664@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SEYPR06MB5720:EE_
x-ms-office365-filtering-correlation-id: 50593897-ab6c-4adb-4978-08dcb839f3dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?T2tLS0VGWkxUZnlBRVEvdXpXT3FjSHRFbCt0cFByNWRrcGVDZHE5MVdrVHYx?=
 =?utf-8?B?MW96MkovWHFYeDVXcVpmYXpJRDQvNXZraExnR1AyTWZUVVd0aURHM0hQN3Va?=
 =?utf-8?B?cCs3VXVEWHhTYkd1Rm44MGxqNWEzekJrWDM0VE5URkdHOGl2T1VMTWY4SmY5?=
 =?utf-8?B?MTJ2dEpDL1dBTzRtSmZVbVd5bjgzTzEyOGpaNk9KNTlkNUlhS3NXcUxuQlVy?=
 =?utf-8?B?REw5TTdoYW43bHU0S0lGNTNwa1hJOHFmc1RlS3NER2YvTEpqak5RUnVlUWtM?=
 =?utf-8?B?aHNzamFwWnZCdnNIZHlWNXI3bVlqUzBGT2tLUXNMVFN4eHlRc0ZJMXZVQzhU?=
 =?utf-8?B?Y0ZOOExkUFUrUjMwL3lMSDBJUnljUFByWmR4TWhXVUNKOHp3azJWa2tjVSto?=
 =?utf-8?B?dTc1YnN0a0VCLzBETmdZMmJmdGsyRUJQalBLVzQxZ0tSenJDUVNvWnUwV2xi?=
 =?utf-8?B?emdsSmFYT1MzWks3cDR6YXdtNWF2Y3ZGc2Y4a2M3aW9xeEtjZ1B0UWpnK2xH?=
 =?utf-8?B?aVdzTFN3VDJTSlpxd2tTQklLNnRvWThHRi93SGU0L1pIQnJKaHFuRHdoWmwv?=
 =?utf-8?B?SWlrVGk1WDA3UnNnL0x0WUxnMEtuS1l2VkFXZWZlRkRjamVZUDV2cUQvb1Zk?=
 =?utf-8?B?VHhKVDFSaXJQQ3U3SllzYjRQZWFLbGZWRllyY0xtOFNHc2pnNXpkTVZlajlt?=
 =?utf-8?B?ZnJiODFzZzRnVWR1UXVyQnVDSEsrYkIwN3d5eEVXSHhSNisyaVRNa0ttdmNk?=
 =?utf-8?B?QlhUeSs1VXBxMXhweXJiRVdvYVFPNWMzaWRkWVRkTlZ1cUtweDVMMmNPOVE4?=
 =?utf-8?B?OUxvbTRHcndRaUtHZExtQWFaNnBuUnM0S2VNZlNPaEVZRWRzd0I5SWpVTGto?=
 =?utf-8?B?VTd4Yk5JMU13Nzg4MnY1VWFJQ0QzaWFzSXk3c3I2YU9kVGtMZzhtY1ljRkRp?=
 =?utf-8?B?NmFCbWJWcmgvamdjNGFUUnBOY240MytsdHcrTGF2R2JlWE1wQmxSR3B5ZFYr?=
 =?utf-8?B?dk15bVRMbFdaNmhtQlZScmJwNkZQcEtNaWdoeGI4SzNlL1VjcUt2QTNnOE04?=
 =?utf-8?B?SmNEUGVwdlBFV1pjVEt5c1MxZmRlL2FzcWsrNk94alIyOEpNQXNKdENrV1Bw?=
 =?utf-8?B?aCtEL3NDRkg5aUhISkN3N2pRcXAxajkwaW50c3NsZ28vN1l0WGpWb3lxaEVJ?=
 =?utf-8?B?R1d6TGdNQU5JNHkydXV0WUNaL0hnNU5kcFoxeTAvbkV3dEd4U3NjMS9lL0M1?=
 =?utf-8?B?RzhKOExaVVZxVlpNZjZnckw4bklrRERkNkZLOWJtb3RyeVlIckcxMXpGdWM3?=
 =?utf-8?B?MkhvSFF6MnNCV2xsdnBkaDdVdWRBb2pyQ2ZYYm1KSytjcldROERCbzdQSXpX?=
 =?utf-8?B?SEZmK2lWSnZkY2RDOWZoYkQ2bWhmc1kwMTJPdkl4ekJMc3NzSmtaR3BnY2Rt?=
 =?utf-8?B?NVFkc1FMaTdlU2hGczdQU0VPQjdLTldpazBKQWNqOUtyWjVJd2o3bHF0VHFY?=
 =?utf-8?B?eWpHaTIxbm1QZm11TzZUWGt2OVZiWEZuRDUrZ3UyVE9WNE8yV3dHZ3A0dmFB?=
 =?utf-8?B?R0xraUVHR3dCcHErSWZBS3IrRUdWbE1NREFoTTlJUGx6WjA4NjNYelRud3dJ?=
 =?utf-8?B?dnBaWVJOSnRyWjZLYnVHcVo3U0NyK0RJMXdmbUdEWVpSbkZTTElFdjZ2MTRB?=
 =?utf-8?B?bGs0UWN5US9ZWTFtb0hvdUt3eWw1SS85ZXlzN05sL2N0TGRuRjh5VGxOYmg0?=
 =?utf-8?B?djl4WkpWM0NsM1F4ZjlMVGJlQzZNa3k4MEZRQW5HZ1RTODdWdmIvMXdZb0lU?=
 =?utf-8?B?Q2RUdy9RUjlSVXBqdkNSK0E3UUR2bXRrMEoxaEI3S0VJUzlCbTNkR0xpNk81?=
 =?utf-8?Q?7Br6QcZBOF9h6?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Wmp5N0JQSnhnTGozNUN4OUJldE1GVTlBaHh1M25XZkhqOVZiWUNhQ25yTEtZ?=
 =?utf-8?B?bXpKaGZtOFQySHhrQzZBc0xFV1lWaVVhQ09WRkZ5c2FGdE9wOXAreVdaNTdP?=
 =?utf-8?B?ZFB5aHhxMnNPVEp1cHZhKzgzcUp0Z3pnVTdIU2NFNytpL0JLUXpyRUZiN1Fj?=
 =?utf-8?B?VGZnSW05c003R2JqVHNEditvSE0vNERMMjlTWjhMOUF6RjA0d0IyT2VjT2o5?=
 =?utf-8?B?NEF1eHNteEtrZUpVSDMvN0VsSE1seWN6NS9BM1lDNnFvc21CNkNjY2dacXlL?=
 =?utf-8?B?UFVuZmR0Yi9zemxMVnpoN3ZibFJJbmhGakl1RDk0UFp5OHZYang2NVFYcmFH?=
 =?utf-8?B?aklhSGo3S2s0eHJVRitoNXlWZzZmV0Z5MGZHa1JDVzlUcm1LcjZuR29pS2ov?=
 =?utf-8?B?NEtwWHB1SVE2RUxOZUFuUk5pZDNoSXhPWE9tQ3BrNllqRnFyWjNmSnAwdlZK?=
 =?utf-8?B?aTVQa29iK2RwZ25ycExpdGpNRE11RGRjKzAxK2xOY2xVYjBEMG1HZkk5Skx5?=
 =?utf-8?B?OWQ4ajBlQkZMLzk3ZVV6TUNkRFpndUlubXpETjF6REhvL3VGQ01BSGpzRDFO?=
 =?utf-8?B?enZjY2pmR0FDUTF0S3dISEdIZUYwUHB0UXBXN3J0VVErZ2VZZ1IyMjd0YUl4?=
 =?utf-8?B?bURaazJzdVlBVDJ2S3ZUVlV5M1VqOUM3bHh6WEVDNlN1NFVJVFRxUGhHNHJt?=
 =?utf-8?B?VFlCM2tXMm1reEtWZ2dzVHViZ0F4OGtqNkJHY3dLMVN2TWtGTnFWQ041ZjZU?=
 =?utf-8?B?UEJoVHV2UFo4N3gwcG9tOE53UnYvdHplMjdNVnIzb2xEOHBZczV4Z01GQmtu?=
 =?utf-8?B?bG1URnUzWWpYckJXZDltbkh4eGV4L0xwL2hPVis5d1JhaGxQblRxUmtOZGhz?=
 =?utf-8?B?ZWM0WGc2cm1GcHgvKzlaQzNmckJoSThMdVh4cUhNUU5JdTllOHRQdGVVNWdR?=
 =?utf-8?B?aUhYQVJXT2Z0emFUb0FCcFROeWgvNnpQWDhiVG9yblZzMC9ZbmxERWZINjlU?=
 =?utf-8?B?eFYybXJyWW0zdklCSVdrU1dmaHhleWJHcjJZVHhqUzM2RzdvK0JxQVJQaE1L?=
 =?utf-8?B?UzdtMmZDR1lRbVdjVWNZNk5KeUREQmtkU1RVVE01WEZHVlFReDNnYThOZEJ0?=
 =?utf-8?B?L2xxSXRDOEhnK2tMMVI1bzYwS2NlVzRnQjlUWjU0R000NlZpditmWUZCWXhW?=
 =?utf-8?B?dzMrT0VJRDBWS214eFFrblVrc1pYQXNTZUtXL2hZeGZ1aFZVdXZuWGxzU0t1?=
 =?utf-8?B?bUhyd1B0aDJ0QlQzcmlObUJTLzhNNnYzSk1OT284aXFlTGVkcmZpQ0t0NEFJ?=
 =?utf-8?B?MlU3KzNNMHRPRTBwWFFNckpOZVovS3pha2hPekNKK0NvQ1JXQ2ZMQ3FkeTFz?=
 =?utf-8?B?RFdXVmFSd0w5WTRFQjZpVjlucWRiYlp2K0Y0dVR0SnlkUm5vY2ZTdnBFR3hn?=
 =?utf-8?B?QStmOSs2YWdsTTJLalJlKzM2bWNwZU1wYkdqTU5PTmZENUIwTlVGVzlEdjBX?=
 =?utf-8?B?bGdtclN4K05aa3g3SFRjRjZ4Q1JrNURZelVjUWxvZmpGNEdTOWJONFZveFlX?=
 =?utf-8?B?V09zaEtXTlJoUDVqYzJyTER2K05QazgwaDV2SG5ZVWxDZTZDVnlWQ3c1K2Zi?=
 =?utf-8?B?NlZwVlJZNVo2bEJiVjY4T1Z2TCtkMW1DbUxrMGtJMWo4aGZ4REw5MnBvMGl3?=
 =?utf-8?B?ZEJoUVhqczg5cTFkNEJVZ2FKbUtFYmpURE1PbXUySEQvS3pNc3hZY0Z0TlFE?=
 =?utf-8?B?WWJqY0crNVhpU1RqY2Y2aEI5Y0lnL2lsODNnTFZMVWY2OG9yS3JDNTdYZGdG?=
 =?utf-8?B?WGZEeVFPUGRtc1Q2UDduU3NKUFdOdUtld3dTNlZXQ2JEVDdqY1VISGhJU1E5?=
 =?utf-8?B?a3pNck5kbklBcUFiMVpETG1mbEVpNkRQNnNxR3RKbEREdThISXZQaVpJSlB5?=
 =?utf-8?B?N1AydDE5bkVNWDExa0x0RW4wUjArUXFCbEJSS1NRMjFHY1RSWnpyMSt4Njlr?=
 =?utf-8?B?UlExNWdOWm1qVnBKOWJrUlZyeDdsZDNRaTJLMmZwYXdCWW1lTTBJSllidENH?=
 =?utf-8?B?SVpBN2RWaFVlU21DWi92Uzd4WHhSeWZqM05xTE1vWXpYazVBeXBWeFptUkE3?=
 =?utf-8?Q?rnJIC+dat6vSIhXoCM3TEuPon?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 50593897-ab6c-4adb-4978-08dcb839f3dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 06:10:22.3515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AMjJL0HUD73eMETkLWpwnlhj+gwJ6gjBzt3GdHX/+3LA8bVuKwGtBkHWcAJmbz1V47cXE3AHMXd+k70yd83Swk4fflp3snGsvxSFkkTgqyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5720

PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvNF0gZHQtYmluZGluZ3M6IG1mZDogYXNwZWVkOiBzdXBw
b3J0IGZvciBBU1QyNzAwDQo+DQo+IE9uIDA5LzA4LzIwMjQgMDc6NTUsIFJ5YW4gQ2hlbiB3cm90
ZToNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzRdIGR0LWJpbmRpbmdzOiBtZmQ6IGFzcGVl
ZDogc3VwcG9ydCBmb3INCj4gPj4gQVNUMjcwMA0KPiA+Pg0KPiA+PiBPbiAwOC8wOC8yMDI0IDA5
OjU5LCBSeWFuIENoZW4gd3JvdGU6DQo+ID4+PiBBZGQgY29tcGF0aWJsZSBzdXBwb3J0IGZvciBB
U1QyNzAwIGNsaywgcmVzZXQsIHBpbmN0cmwsIHNpbGljb24taWQNCj4gPj4+IGFuZCBleGFtcGxl
IGZvciBBU1QyNzAwIHNjdS4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBSeWFuIENoZW4g
PHJ5YW5fY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gIC4uLi9iaW5kaW5n
cy9tZmQvYXNwZWVkLGFzdDJ4MDAtc2N1LnlhbWwgICAgICB8IDMxDQo+ID4+ICsrKysrKysrKysr
KysrKysrLS0NCj4gPj4+ICAxIGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0DQo+ID4+PiBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXNwZWVkLGFzdDJ4MDAtc2N1LnlhbWwNCj4gPj4+IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hc3BlZWQsYXN0MngwMC1zY3Uu
eWFtbA0KPiA+Pj4gaW5kZXggODZlZTY5YzBmNDViLi5jMDk2NWYwOGFlOGMgMTAwNjQ0DQo+ID4+
PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2FzcGVlZCxhc3Qy
eDAwLXNjdS55YW1sDQo+ID4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbWZkL2FzcGVlZCxhc3QyeDAwLXNjdS55YW1sDQo+ID4+PiBAQCAtMjEsNiArMjEsOCBAQCBw
cm9wZXJ0aWVzOg0KPiA+Pj4gICAgICAgICAgICAtIGFzcGVlZCxhc3QyNDAwLXNjdQ0KPiA+Pj4g
ICAgICAgICAgICAtIGFzcGVlZCxhc3QyNTAwLXNjdQ0KPiA+Pj4gICAgICAgICAgICAtIGFzcGVl
ZCxhc3QyNjAwLXNjdQ0KPiA+Pj4gKyAgICAgICAgICAtIGFzcGVlZCxhc3QyNzAwLXNjdTANCj4g
Pj4+ICsgICAgICAgICAgLSBhc3BlZWQsYXN0MjcwMC1zY3UxDQo+ID4+DQo+ID4+IFdoYXQgYXJl
IHRoZSBkaWZmZXJlbmNlcyBiZXR3ZWVuIHRoZXNlIHR3bz8NCj4gPg0KPiA+IFRoZSBuZXh0IFtQ
QVRDSCA0LzRdIGlzIHNjdSBkcml2ZXIgdGhhdCBpbmNsdWRlIGFzdDI3MDAtc2N1MCBhbmQNCj4g
PiBhc3QyNzAwLXNjdTEgQ0xLX09GX0RFQ0xBUkVfRFJJVkVSKGFzdDI3MDBfc29jMCwNCj4gPiAi
YXNwZWVkLGFzdDI3MDAtc2N1MCIsIGFzdDI3MDBfc29jMF9jbGtfaW5pdCk7DQo+ID4gQ0xLX09G
X0RFQ0xBUkVfRFJJVkVSKGFzdDI3MDBfc29jMSwgImFzcGVlZCxhc3QyNzAwLXNjdTEiLA0KPiA+
IGFzdDI3MDBfc29jMV9jbGtfaW5pdCk7DQo+DQo+IFdoYXQgYXJlIGhhcmR3YXJlIGRpZmZlcmVu
Y2VzPyBFbnRpcmVseSBkaWZmZXJlbnQgZGV2aWNlcz8NCg0KQVNUMjcwMCBoYXZlIHR3byBzb2Mg
ZGllIGNvbm5lY3RlZCBlYWNoIG90aGVyLg0KRWFjaCBzb2MgZGllIGhhdmUgaXQgb3duIHNjdSwg
c28gdGhlIG5hbWluZyBpcyBhc3QyNzAwLXNjdTAgZm9yIHNvYzAsIGFub3RoZXIgaXMgYXN0Mjcw
MC1zY3UxIGZvciBzb2MxLg0KDQo+DQo+ID4gU28gSSBhZGQgdGhlc2UgdHdvLg0KPiA+DQo+ID4+
DQo+ID4+PiAgICAgICAgLSBjb25zdDogc3lzY29uDQo+ID4+PiAgICAgICAgLSBjb25zdDogc2lt
cGxlLW1mZA0KPiA+Pj4NCj4gPj4+IEBAIC0zMCwxMCArMzIsMTIgQEAgcHJvcGVydGllczoNCj4g
Pj4+ICAgIHJhbmdlczogdHJ1ZQ0KPiA+Pj4NCj4gPj4+ICAgICcjYWRkcmVzcy1jZWxscyc6DQo+
ID4+PiAtICAgIGNvbnN0OiAxDQo+ID4+PiArICAgIG1pbmltdW06IDENCj4gPj4+ICsgICAgbWF4
aW11bTogMg0KPiA+Pj4NCj4gPj4+ICAgICcjc2l6ZS1jZWxscyc6DQo+ID4+PiAtICAgIGNvbnN0
OiAxDQo+ID4+PiArICAgIG1pbmltdW06IDENCj4gPj4+ICsgICAgbWF4aW11bTogMg0KPiA+Pj4N
Cj4gPj4+ICAgICcjY2xvY2stY2VsbHMnOg0KPiA+Pj4gICAgICBjb25zdDogMQ0KPiA+Pj4gQEAg
LTU2LDYgKzYwLDggQEAgcGF0dGVyblByb3BlcnRpZXM6DQo+ID4+PiAgICAgICAgICAgICAgLSBh
c3BlZWQsYXN0MjQwMC1waW5jdHJsDQo+ID4+PiAgICAgICAgICAgICAgLSBhc3BlZWQsYXN0MjUw
MC1waW5jdHJsDQo+ID4+PiAgICAgICAgICAgICAgLSBhc3BlZWQsYXN0MjYwMC1waW5jdHJsDQo+
ID4+PiArICAgICAgICAgICAgLSBhc3BlZWQsYXN0MjcwMC1zb2MwLXBpbmN0cmwNCj4gPj4+ICsg
ICAgICAgICAgICAtIGFzcGVlZCxhc3QyNzAwLXNvYzEtcGluY3RybA0KPiA+Pj4NCj4gPj4+ICAg
ICAgcmVxdWlyZWQ6DQo+ID4+PiAgICAgICAgLSBjb21wYXRpYmxlDQo+ID4+PiBAQCAtNzYsNiAr
ODIsNyBAQCBwYXR0ZXJuUHJvcGVydGllczoNCj4gPj4+ICAgICAgICAgICAgICAgIC0gYXNwZWVk
LGFzdDI0MDAtc2lsaWNvbi1pZA0KPiA+Pj4gICAgICAgICAgICAgICAgLSBhc3BlZWQsYXN0MjUw
MC1zaWxpY29uLWlkDQo+ID4+PiAgICAgICAgICAgICAgICAtIGFzcGVlZCxhc3QyNjAwLXNpbGlj
b24taWQNCj4gPj4+ICsgICAgICAgICAgICAgIC0gYXNwZWVkLGFzdDI3MDAtc2lsaWNvbi1pZA0K
PiA+Pj4gICAgICAgICAgICAtIGNvbnN0OiBhc3BlZWQsc2lsaWNvbi1pZA0KPiA+Pj4NCj4gPj4+
ICAgICAgICByZWc6DQo+ID4+PiBAQCAtMTE1LDQgKzEyMiwyNCBAQCBleGFtcGxlczoNCj4gPj4+
ICAgICAgICAgICAgICByZWcgPSA8MHg3YyAweDQ+LCA8MHgxNTAgMHg4PjsNCj4gPj4+ICAgICAg
ICAgIH07DQo+ID4+PiAgICAgIH07DQo+ID4+PiArICAtIHwNCj4gPj4+ICsgICAgc29jMCB7DQo+
ID4+PiArICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwyPjsNCj4gPj4+ICsgICAgICAgICNzaXpl
LWNlbGxzID0gPDI+Ow0KPiA+Pg0KPiA+PiBUaGF0J3MgdGhlIHNhbWUgZXhhbXBsZSBhcyBwcmV2
aW91cywgcmlnaHQ/IFRoZSBkcm9wLCBubyBuZWVkLg0KPiA+DQo+ID4gQVNUMjcwMCBpcyA2NGJp
dHMgYWRkcmVzcyBtb2RlIHBsYXRmb3JtLCB0aGF0IHRoZSByZWFzb24uDQo+ID4gU28gSSBhZGQg
ZXhhbXBsZSBmb3IgNjRiaXRzIHBsYXRmb3JtIGRlc2NyaXB0IGluIGR0c2kgSSBoYXZlIHRvIGFk
ZA0KPiA+IHNvYzAgdG8gYmUgYWRkcmVzcy1jZWxscyBhbmQgc2l6ZS1jZWxscyB0byBiZSA8Mj4g
VGhlbiBJIGNhbiBkZWZpbmUNCj4gPiB0aGUgcmVnaXN0ZXIgdG8gYmUgNjRiaXRzIGFkZHJlc3Mg
YW5kIHNpemUuDQo+DQo+IFRoYXQncyB0cml2aWFsLiBEcm9wLg0KRG8geW91IG1lYW4sIEkgZG9u
4oCZdCBuZWVkIGFkZCBleGFtcGxlIGZvciBhc3QyNzAwLXNjdTA/DQoNCk9yIGRlbGV0ZSAjYWRk
cmVzcy1jZWxscyA9IDwyPjsgICNzaXplLWNlbGxzID0gPDI+Ow0KSWYgSSByZW1vdmUgaXQgd2ls
bCBtYWtlIGR0X2JpbmRpbmdfY2hlY2sgZmFpbC4NCj4NCj4gPj4NCj4gPj4gQmVzdCByZWdhcmRz
LA0KPiA+PiBLcnp5c3p0b2YNCj4gPg0KPiA+ICoqKioqKioqKioqKiogRW1haWwgQ29uZmlkZW50
aWFsaXR5IE5vdGljZSAqKioqKioqKioqKioqKioqKioqKg0KPiA+IOWFjeiyrOiBsuaYjjoNCj4g
PiDmnKzkv6Hku7Yo5oiW5YW26ZmE5Lu2KeWPr+iDveWMheWQq+apn+Wvhuizh+ioiu+8jOS4puWP
l+azleW+i+S/neitt+OAguWmgiDlj7Dnq6/pnZ7mjIflrpoNCj4g5LmL5pS25Lu26ICF77yM6KuL
5Lul6Zu75a2Q6YO15Lu26YCa55+l5pys6Zu75a2Q6YO15Lu25LmL55m86YCB6ICFLCDkuKboq4vn
q4vljbPliKrpmaTmnKzpm7vlrZANCj4g6YO15Lu25Y+K5YW26ZmE5Lu25ZKM6Yq35q+A5omA5pyJ
6KSH5Y2w5Lu244CC6Kyd6Kyd5oKo55qE5ZCI5L2cIQ0KPiA+DQo+ID4gRElTQ0xBSU1FUjoNCj4g
PiBUaGlzIG1lc3NhZ2UgKGFuZCBhbnkgYXR0YWNobWVudHMpIG1heSBjb250YWluIGxlZ2FsbHkg
cHJpdmlsZWdlZCBhbmQvb3INCj4gb3RoZXIgY29uZmlkZW50aWFsIGluZm9ybWF0aW9uLiBJZiB5
b3UgaGF2ZSByZWNlaXZlZCBpdCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUNCj4gc2VuZGVy
IGJ5IHJlcGx5IGUtbWFpbCBhbmQgaW1tZWRpYXRlbHkgZGVsZXRlIHRoZSBlLW1haWwgYW5kIGFu
eQ0KPiBhdHRhY2htZW50cyB3aXRob3V0IGNvcHlpbmcgb3IgZGlzY2xvc2luZyB0aGUgY29udGVu
dHMuIFRoYW5rIHlvdS4NCj4NCj4gTWF5YmUgSSBhbSB0aGUgaW50ZW5kZWQgcmVjaXBpZW50IG9m
IHlvdXIgbWVzc2FnZSwgbWF5YmUgbm90LiBJIGRvbid0IHdhbnQNCj4gdG8gaGF2ZSBhbnkgbGVn
YWwgcXVlc3Rpb25zIHJlZ2FyZGluZyB1cHN0cmVhbSwgcHVibGljIGNvbGxhYm9yYXRpb24sIHRo
dXMNCj4gcHJvYmFibHkgSSBzaG91bGQganVzdCByZW1vdmUgeW91ciBtZXNzYWdlcy4NCj4NCj4g
UGxlYXNlIHRhbGsgd2l0aCB5b3VyIElUIHRoYXQgc3VjaCBkaXNjbGFpbWVycyBpbiBvcGVuLXNv
dXJjZSBhcmUgbm90IGRlc2lyZWQNCj4gKGFuZCBtYXliZSBldmVuIGhhcm1mdWwpLg0KPiBJZiB5
b3UgZG8gbm90IHVuZGVyc3RhbmQgd2h5LCBwbGVhc2UgYWxzbyBzZWU6DQo+IGh0dHBzOi8vd3d3
LnlvdXR1YmUuY29tL2xpdmUvZk1lSDd3cU93WEE/c2k9R1k3aWdmYmRhNnZualhsSiZ0PTgzNQ0K
Pg0KPiBJZiB5b3UgbmVlZCB0byBnbyBhcm91bmQgY29tcGFueSBTTVRQIHNlcnZlciwgdGhlbiBj
b25zaWRlciB1c2luZyBiNA0KPiB3ZWItcmVsYXk6IGh0dHBzOi8vYjQuZG9jcy5rZXJuZWwub3Jn
L2VuL2xhdGVzdC9jb250cmlidXRvci9zZW5kLmh0bWwNCj4NCj4gSSB3aWxsIG5vdCByZXNwb25k
IHRvIGFueSBvdGhlciBjb25maWRlbnRpYWwgZW1haWxzLiBUaGF0J3MgdGhlIGxhc3Qgb25lIHlv
dSBnb3QuDQo+DQo+IFRvIGJlIGNsZWFyOiBhbGwgbWVzc2FnZXMgZnJvbSB5b3VyIGNvbXBhbnkg
d2lsbCBiZSBtYWRlIHB1Ymxpc2hlZC4gQnkNCj4gcmVzcG9uZGluZyB0byB0aGlzIGVtYWlsIHlv
dSBhZ3JlZSB0aGF0IGFsbCBjb21tdW5pY2F0aW9ucyBmcm9tIHlvdSBhbmQvb3INCj4geW91ciBj
b21wYW55IGlzIG1hZGUgcHVibGljLg0KPg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K
DQoqKioqKioqKioqKioqIEVtYWlsIENvbmZpZGVudGlhbGl0eSBOb3RpY2UgKioqKioqKioqKioq
KioqKioqKioNCuWFjeiyrOiBsuaYjjoNCuacrOS/oeS7tijmiJblhbbpmYTku7Yp5Y+v6IO95YyF
5ZCr5qmf5a+G6LOH6KiK77yM5Lim5Y+X5rOV5b6L5L+d6K2344CC5aaCIOWPsOerr+mdnuaMh+Wu
muS5i+aUtuS7tuiAhe+8jOiri+S7pembu+WtkOmDteS7tumAmuefpeacrOmbu+WtkOmDteS7tuS5
i+eZvOmAgeiAhSwg5Lim6KuL56uL5Y2z5Yiq6Zmk5pys6Zu75a2Q6YO15Lu25Y+K5YW26ZmE5Lu2
5ZKM6Yq35q+A5omA5pyJ6KSH5Y2w5Lu244CC6Kyd6Kyd5oKo55qE5ZCI5L2cIQ0KDQpESVNDTEFJ
TUVSOg0KVGhpcyBtZXNzYWdlIChhbmQgYW55IGF0dGFjaG1lbnRzKSBtYXkgY29udGFpbiBsZWdh
bGx5IHByaXZpbGVnZWQgYW5kL29yIG90aGVyIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbi4gSWYg
eW91IGhhdmUgcmVjZWl2ZWQgaXQgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBi
eSByZXBseSBlLW1haWwgYW5kIGltbWVkaWF0ZWx5IGRlbGV0ZSB0aGUgZS1tYWlsIGFuZCBhbnkg
YXR0YWNobWVudHMgd2l0aG91dCBjb3B5aW5nIG9yIGRpc2Nsb3NpbmcgdGhlIGNvbnRlbnRzLiBU
aGFuayB5b3UuDQo=

