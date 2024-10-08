Return-Path: <linux-kernel+bounces-354367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB2E993C92
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 04:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FCDB1C21611
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 02:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D572A1DFD1;
	Tue,  8 Oct 2024 02:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="g5XscVQ+"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2123.outbound.protection.outlook.com [40.107.215.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA348EADC;
	Tue,  8 Oct 2024 02:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728352887; cv=fail; b=Eh1zmKyy7je6W/FARa/7KfYQXBtphLECnOJjcv2nHxLOKvgQ4pR7bi0oHacvb7JmolSFvsZI2jG49mWyIMLuVpjXabjTnBMe7NbgrWnuRUTGZIFm/fH6068DqOEZZ+wEObytPBERkUAcidJwaz5YgvzaklSRKRjyxFEL2Hapc1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728352887; c=relaxed/simple;
	bh=/7I8a+f+TZ3D4x2sP/RvATi6oLILmwz4gWLsXE9WBKs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PhEeiRXWoldPKqagi2KTApOAhTyaA5mZVnpMCKi5hQ4X10JnEt97yHFcPrmXF0PpoLaVb9rqQhWzcrgbtZB0TxHf/Pqk+MysJyJjWbQJF/Gk/UjhxPVe17f3obwx99Hv7veAWWmabakWwjV8c0J2UzsopIkXaIiMT26Vn53zDC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=g5XscVQ+; arc=fail smtp.client-ip=40.107.215.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOstACKQmo1C75++QhpySdu4brYhhCiwVtOUYZZ5zTY90P37lzXvEGQP+jV2Ng3Ebx1nIUQJtoJF7DzDR5l+mojEV35BX2/oTKDI5SWdtO4Muaqva/SI811rynofYSdQnEMJZi2st31rfWrQMW9EfFLSq+TlESzM2ngxefiUcr+k2CKnfpbOgFbKUwslmXcZ5NkcOnsS7f0X18nIH3Dz9hyY1fkaVop5KkZjMTxhEDJ5bcPqCAG4iRBxHXIR+dtK20N6l8BEnUIkAtBAS7xTmIrveiX0w+yqKhcmOsfPshkuqHdD1+jzj2LSG6gSuEY7O0zfJUdJ39O210ZayvE2jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7I8a+f+TZ3D4x2sP/RvATi6oLILmwz4gWLsXE9WBKs=;
 b=l5d61it7DjfXkc3kcoml13VyXa7BFmwTmV/v2nuQsq1H6hL4QuTLdMxIyFcTF8DGN004GgPSlqHSem41KaJ5l7GajU3Vgpf4sheyu9rYegW3Ki13aZEwCd/urkeP17lO9ndnx2zMlhyXihiVuNktgXX7MdPj3MTkLdzJm7QRy0tcmjvwwBHpX5UiO9f7Dc2PHHU2vDp25hqmifkZjq8UCdpuGizhMT7GHbDgfkRMBFfETbqy7AZGFTo6q2mJhOTTHUNE2Afa3Y7N2n3NRJSy2pdmn1i7ONnnL6ypP46e8D1DtGiLSBlJiLwragGtV4Ugcky+JLFiOJPqZkEZUkhSZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7I8a+f+TZ3D4x2sP/RvATi6oLILmwz4gWLsXE9WBKs=;
 b=g5XscVQ+Jg/K4V1EYRZfTNqOzWzAgKLEeYWnBO1prQEiwU7c2KGurvJm0xFUX85X0VaVADoN3K9tIg5fapl3e5JGGoELnFbJNNlC7nCJY0ljtRiGulGZBxg/Ll5fDvm/02bCaHcdn3qZBRuxT1MeSDj2EA+sG41RQ4AsU9k11NhBCxfg7U38D37DMkrK7gvQSPFlqmZctoUNDWzUCQ8iKPsMSwDldzuLPajCKTOa00SYZ0durPylUhTHs4yeXKT6RfY7cWhyynN1JWO5Aibi+/bAVdp9D7ZCIxaU4z/C4Xf2yzKBOlj0eTws6RDHkHlLCbo15fIF0m1oGO2gQSvr/Q==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by TYUPR06MB5909.apcprd06.prod.outlook.com (2603:1096:400:35d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.13; Tue, 8 Oct
 2024 02:01:18 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%5]) with mapi id 15.20.8048.013; Tue, 8 Oct 2024
 02:01:18 +0000
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, "joel@jms.id.au"
	<joel@jms.id.au>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v1 1/2] dt-bindings: interrupt-controller: Add support for
 ASPEED AST27XX INTC
Thread-Topic: [PATCH v1 1/2] dt-bindings: interrupt-controller: Add support
 for ASPEED AST27XX INTC
Thread-Index: AQHa7VSIDzu/MHU15Ua96sizVbLD67Ik6xkAgFeFyyA=
Date: Tue, 8 Oct 2024 02:01:18 +0000
Message-ID:
 <PSAPR06MB4949621DE71075572B67EEE7897E2@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20240813074338.969883-1-kevin_chen@aspeedtech.com>
 <20240813074338.969883-2-kevin_chen@aspeedtech.com>
 <172354119091.52485.8216967911640529962.robh@kernel.org>
In-Reply-To: <172354119091.52485.8216967911640529962.robh@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|TYUPR06MB5909:EE_
x-ms-office365-filtering-correlation-id: 6b5a5a47-58f3-448f-f1c2-08dce73d1953
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bURjRG1ITit5a2QxVHQ3T28yUTNPNUpVM1BxYTJZdEVQN0UxSER5Zk5TWWNG?=
 =?utf-8?B?TWNYQzhueXY4cDRxVkxqNEV1VHh0d1dRNGNYVmc5Y0NoTWQzc0NDeDd5YlJR?=
 =?utf-8?B?ODRPbVZ4SjNsVjdMQnRjblY4cENuck5tQWRVNTQzZmg1d1NEdmlhWkk4Nkpw?=
 =?utf-8?B?OW03dkhGYlRRbzNxc2laUkNNT1NONjFGbTBYeUdtTkdmY0ZlaVhJc0VENUtp?=
 =?utf-8?B?R0t3a0NncEZleDFDNC9DajRJcEdXZVZ2UHNocXdtaGV6dEZqZ3RuUkp6L01v?=
 =?utf-8?B?OUNtYnE0S0Y1akJWTHpKeTh5TWpRSk5saVhyZzFPRlFoazBIdUpxTVp1cVpQ?=
 =?utf-8?B?NTBIc1lsSnZRRkI2SFBTMzcvaXFrcm80bEhYRjNpZjZsdmxXWDhSQTc5YjFI?=
 =?utf-8?B?MHlVM0hQT2FKMFc1bTlseGZlaDN1dVNqWGl1QVhQcU1UM0d0aXJIMktGaVBE?=
 =?utf-8?B?Nmh3VEx6eERFTWtLc3Y0L2RQSlZ3Q3doc01VaGpMNUdqVmRSbUVHQkNqTWpT?=
 =?utf-8?B?VEV2Ukd0VXkzNjluZ0FXK0pkNUhNZUh6U2ZkTCtNbEFrNWl3b0VUNEZ6THkr?=
 =?utf-8?B?TXRzUHpPMlF1aWsvd3JCY0o3M1lkSGpvTU12RWJiVmR5OEhqR2V2U0NORG1Z?=
 =?utf-8?B?YS9tbTFKZzlhcjgwdFY3amErWHJ3dTNiZzlHQTJoZ3dzeGFuY1UyMm5qUUFz?=
 =?utf-8?B?aHh6aDZXMzFJSUlrS2tqQzNtc3ArcWErS2hNejhKQ21PRmlxMDF3RVVpejFX?=
 =?utf-8?B?TW5JMmZheEpEUXpOaFZBcVNoUlJ1VUxHMS9mRS9xc0xhSXljbGsyZWV2LzJU?=
 =?utf-8?B?NTBnVTRVVXY1ajBBTmFCY0xhdzd1K2kwZlV1SlE4aVB6cWdoL01nb1BKaHNy?=
 =?utf-8?B?QW15R0R2RkdpM2FncEJYSFVEV0hBLzJPYVRoSFpPSnFvejNQbkVhZFZHbVBO?=
 =?utf-8?B?NzVUa0RTdkNKc0lZL21UckNzaHRiU1VvTUlqWGNvU2o1SHQ3eGlsN2FyYXh0?=
 =?utf-8?B?QXR3NW1DWHF0TzY2RGRHaHhyZldEcGJSenpzRGtZVFBrL29iWjZxSWtkTlZw?=
 =?utf-8?B?TDBwOHdRdldGUjRGeFp5ckRxNG9reitXMG9rUkhlQ2xTYUU1dStwT0Y4aU12?=
 =?utf-8?B?c28zdVZCTnBtK0tXWFNJQjZ2OUxrd2Z2bS8yMFBYa0owTFIvbTRsNnN0UE5T?=
 =?utf-8?B?dzVNUjhlTlpqNG1qVXBLNFRHd0grQkpkcCsxdkQ0cG5qR1dGdGx5ZkI1OSs2?=
 =?utf-8?B?SHUwRXZ0QnlGSjlNUklkMjd3UlEwRG9QRWo3blNHWmdMZ0U4TXMvOS9RUkdV?=
 =?utf-8?B?SkZsKzZyZUFxWGFmMUF4SXcvTDVvNzhRSWNXdnZQZHFqMWJVUWI2WXlBazdX?=
 =?utf-8?B?a1pGUHZESDRTd0ZVUUVWdzlOaWtEQk9KUy9Uem50QVZ1NE1nbExIM1Iyb3lp?=
 =?utf-8?B?UmlmUExNSjJEbFowY2RJVDByR2JWM1ZSek1KTE1ZRlRuSmpwYXNGVllNZzZn?=
 =?utf-8?B?UklOZ1dlOVY2UTlBZFAvY0wyZ0s5OG9DMmJNa0RQYy9kcVBjekNkbU1CZVNR?=
 =?utf-8?B?NFRxZmowc1VpaWFjVnJxTVdJS3NCc0pqSnA4b1N6c1QwSEc0VTc4bkRwUUpC?=
 =?utf-8?B?QytKNGpDVDljcVovbzcvbDlGWXdpTG02UnVHc0tpNStIZUJISWJmeHU5R3d1?=
 =?utf-8?B?YjJxQkw0VmtyRmw1czdVKyt1aEVYT3hackRBMmpYZ0lFK3FkMzJHcVAzbUxV?=
 =?utf-8?B?cHBrMGJ5dkVtMk9SRFRqSU5DcUxDQytEOTV4MEs0SUN1ejE5YmJ4SDJpTjJB?=
 =?utf-8?B?NFdnUGVoMDM4MEMvNTkwdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1hjZWV1a0daK04ycnZteHl1cVhwcFdWSExZdGZUVHZDSXZVRkwzak1jSk1l?=
 =?utf-8?B?bGFMb2Z5dldlMjZoT21MUUtvWERSWTFFZndLZHZwbFozUTlQSnFidFRUQUhR?=
 =?utf-8?B?aytKYlJGcmdudEw1Tm9pWFF6anF6T1ZObEpJb3hla0Q2MmQyU3VVS2lWcjBX?=
 =?utf-8?B?aHJpSm1xSEZLeXNRVWdyZ3RmSUpzOEhHNjl6UVpqbWhSelEvSUxzR2JROVRy?=
 =?utf-8?B?bXRCcjZIblpDbVFmcVhkV3JGWXFtUjZHem1RUC9lZ2VxTTh4bGpHUVJONFk3?=
 =?utf-8?B?Qnl3azhPdUN2YXllRkNHejJIV2lqak9ud1NWYk5EekxKUG5LZlVONVFsOTJI?=
 =?utf-8?B?Tk5Vd3doNWt5MnRDM2N5NTZ4NE51bExjMG5vYk1WZDA3czhic0g0NHhoMEY3?=
 =?utf-8?B?RnJ0TjRSUXdZeDBmbW9wbnFCSkh1NTlSUnRwRFQ2UVFCeURPejIvOFpGSUxX?=
 =?utf-8?B?d3B4bkFrTWh3aVVKWlc5MzQ4QzhDV0tOZlQrZHhzWTdrTnY5enFONmJjNW9C?=
 =?utf-8?B?TXRRMGpJZnBnTlRiZnFIU2Z6YnpKY0VWKy93bVg1VmRtakp5ZmJKNXBwemlO?=
 =?utf-8?B?ZE1UbEUzRWRYRlkzYnRIZGZka3Q0Z0prMEhvbTQ2UFBEMm9adEFvRThhUnNj?=
 =?utf-8?B?STU0VGIwTEtuMmo3RURUTEZuMU1BTjZnUTdISUZ4WDk3M3pRcjkrb3NZNjhx?=
 =?utf-8?B?aHhuRUZ3M1dvU0txVkJRdnJWZ0hWZGJibnVjbW5PZ3I0dmh6MEQrTzQ2WnZJ?=
 =?utf-8?B?WHpuQlBkTVYzWmZNbjVlbzJaQ0NnaXVsS1VhbVZ3VVJOVVFXYnpzT2dPdmcv?=
 =?utf-8?B?QVQwYkJlS3doQ2NNRjhFRlpNcXNTaDZ5RzRSelJlWDJnZ212VnFFdjNiTWNi?=
 =?utf-8?B?dGZSaFNRcTJEQ2ZBWHAxM0JSc0RFM0ZQVTRvcXkzTmNGZHVEeU1BRWF5cDY4?=
 =?utf-8?B?RWxSRGxrWlArRUdDaE0yYzZST2xEQWdwWjBpS0VvanJ4ckZISHNyVnB2SlF1?=
 =?utf-8?B?SThvL05jOVJma3FPc2Y1QkVIV0QrUURiVi96Sm1ENmR5Z1lxdk1uTmVrNWNu?=
 =?utf-8?B?T1FxQmJJaEl6NVZkUWtBb0VMSE9NT2ZOVUx5d2YwQTU2VXRrNm1Kb3NuYWw3?=
 =?utf-8?B?NFZGYXRoVk1IMzEyNVJhMEgzb1o3U2ZuNzB0R09MUUdRV3hMZlBFdTJRN1k4?=
 =?utf-8?B?djVoYU5ZdU9xcmRTaVd0ZkdOUmJsLzdHYmpkOWdYYjZ4SmdMWGt4OHZ2QWQ2?=
 =?utf-8?B?VzRRaE1Ha3NLWEUrbUs2UG5ibzdOS2FJZi9XeWRlNFphRzVFQXhNUllqcG42?=
 =?utf-8?B?M3Q0bVZERXpPd1l5dHhkemltbHZNWFlJdFBOdThjbWlsbzVMZEVUWmsvYmR6?=
 =?utf-8?B?cGduZlJMSEFERXRqa2FFbjFYcFYrZVZwTklGamJpMm03bTczeWVJVEI5cUhq?=
 =?utf-8?B?WjY3bVhRQ0J5V1lhZjNZWmdSRHdIaWcyckMxZHE4VDZuWnFJNnRUWVJXL0Vp?=
 =?utf-8?B?YzFsMXQxcTJDSkZsTUtaSk00dHR0VXJ6Q2M3dU9UVXFZVEtuUFI4b2xzWi9z?=
 =?utf-8?B?TDBBYWx0ekljN1J5TytzN3ZaS2g0UG5TM0kxOUVjS2pGWlRUZ0NJUFNMQUVh?=
 =?utf-8?B?a3JYVWREZFJobTlYL0NuaGZ5MTJYOVc3WTh4TEdMd3pYQnB1U2w4VHo5bDIy?=
 =?utf-8?B?Tk1rT3NpUTBEakNGWHJLREFuOFZlVERmNjRxQ3o5V0phTGRsem9lVmpyaW84?=
 =?utf-8?B?RmtZNndCSHlCVjE1Ym5UdHVrOUxPQ2ZiZGhQVEozaG16K2xyNjJXVVVzU0hZ?=
 =?utf-8?B?aHF3TzhZMzh4R29xdFFZaUpaQnV0Z1p4dTQrV2tpTy94d2QrK2FxZ3J1L0dG?=
 =?utf-8?B?a21veFducFl4d0w3cGs3emVNNEljUmJYWmx2Qk5lQk9BQlJGV0JiM1BNdXp1?=
 =?utf-8?B?UnhTaTI2cHhjeUlKMDRqUFU4OHBJTEF2eXp2U3NVU1BEbHFud0Y3d0tZbWNP?=
 =?utf-8?B?Zzk0Nk5LWlByVEl1NXBHckNXdkJOejFxQUY5S0ZNSGZzZmV4RjJQZXBITllL?=
 =?utf-8?B?eGZTOGVrdzhSZ3ZrM1hPTkVENmF1MW9OZHNEU3llYzllYzlZQUNqRzV0OTlh?=
 =?utf-8?Q?AAZiiKcxm4SGiEg+r/uDKZUV4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5a5a47-58f3-448f-f1c2-08dce73d1953
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 02:01:18.3414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jQ8O43rbCVUkbT4YfSPjkxPTlQzTxi7YM3RkVuy6CI8938yUCzdlaSmlL2Us8r/a8ZU3vGWF8acBkmzAVke8xezdSCSv4Om1YBVShUAeWDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5909

PiA+IFRoZSBBU1BFRUQgQVNUMjdYWCBpbnRlcnJ1cHQgY29udHJvbGxlcihJTlRDKSBjb21iaW5l
cyAzMiBpbnRlcnJ1cHRzDQo+ID4gc291cmNlcyBpbnRvIDEgaW50ZXJydXB0IGludG8gR0lDIGZy
b20gQ1BVIGRpZSB0byBDUFUgZGllLg0KPiA+IFRoZSBJTlRDIGRlc2lnbiBjb250YWlucyBzb2Mw
X2ludGMgYW5kIHNvYzFfaW50YyBtb2R1bGUgZG9pbmcgaGFuZA0KPiA+IHNoYWtlIGJldHdlZW4g
Q1BVIGRpZSBhbmQgSU8gZGllIElOVEMuDQo+ID4NCj4gPiBJbiBzb2MwX2ludGMxMSwgZWFjaCBi
aXQgcmVwcmVzZW50IDEgR0lDX1NQSSBpbnRlcnJ1cHQgZnJvbSBzb2MxX2ludGNYLg0KPiA+IElu
IHNvYzFfaW50Y1gsIGVhY2ggYml0IHJlcHJlc2VudCAxIGRldmljZSBpbnRlcnJ1cHQgaW4gSU8g
ZGllLg0KPiA+DQo+ID4gQnkgc29jMV9pbnRjWCBpbiBJTyBkaWUsIEFTVDI3WFggSU5UQyBjb21i
aW5lcyAzMiBpbnRlcnJ1cHQgc291cmNlcyB0bw0KPiA+IDEgaW50ZXJydXB0IHNvdXJjZSBpbiBz
b2MwX2ludGMxMSBpbiBDUFUgZGllLCB3aGljaCBhY2hpZXZlIHRoZQ0KPiA+IGludGVycnVwdCBw
YXNzaW5nIGJldHdlZW4gdGhlIGRpZmZlcmVudCBkaWUgaW4gQVNUMjdYWC4NCj4gPiAtLS0NCj4g
PiAgLi4uL2FzcGVlZCxhc3QyNzAwLWludGMueWFtbCAgICAgICAgICAgICAgICAgIHwgMTIwDQo+
ICsrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTIwIGluc2VydGlvbnMo
KykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2FzcGVlZCxhc3QyNzAwLQ0KPiA+IGludGMu
eWFtbA0KPiA+DQo+IA0KPiBNeSBib3QgZm91bmQgZXJyb3JzIHJ1bm5pbmcgJ21ha2UgZHRfYmlu
ZGluZ19jaGVjaycgb24geW91ciBwYXRjaDoNCj4gDQo+IHlhbWxsaW50IHdhcm5pbmdzL2Vycm9y
czoNCj4gLi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJydXB0LWNvbnRy
b2xsZXIvYXNwZWVkLGFzdDI3MDAtaW50Yw0KPiAueWFtbDoyNDo5OiBbd2FybmluZ10gd3Jvbmcg
aW5kZW50YXRpb246IGV4cGVjdGVkIDEwIGJ1dCBmb3VuZCA4IChpbmRlbnRhdGlvbikNCj4gLi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXNw
ZWVkLGFzdDI3MDAtaW50Yw0KPiAueWFtbDoyNToxMTogW3dhcm5pbmddIHdyb25nIGluZGVudGF0
aW9uOiBleHBlY3RlZCAxMiBidXQgZm91bmQgMTANCj4gKGluZGVudGF0aW9uKQ0KPiANCj4gZHRz
Y2hlbWEvZHRjIHdhcm5pbmdzL2Vycm9yczoNCj4gL2J1aWxkcy9yb2JoZXJyaW5nL2R0LXJldmll
dy1jaS9saW51eC9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZQ0KPiBycnVw
dC1jb250cm9sbGVyL2FzcGVlZCxhc3QyNzAwLWludGMueWFtbDogJ2V4YW1wbGUnIGlzIG5vdCBv
bmUgb2YgWyckaWQnLA0KPiAnJHNjaGVtYScsICd0aXRsZScsICdkZXNjcmlwdGlvbicsICdleGFt
cGxlcycsICdyZXF1aXJlZCcsICdhbGxPZicsICdhbnlPZicsICdvbmVPZicsDQo+ICdkZWZpbml0
aW9ucycsICckZGVmcycsICdhZGRpdGlvbmFsUHJvcGVydGllcycsICdkZXBlbmRlbmNpZXMnLA0K
PiAnZGVwZW5kZW50UmVxdWlyZWQnLCAnZGVwZW5kZW50U2NoZW1hcycsICdwYXR0ZXJuUHJvcGVy
dGllcycsICdwcm9wZXJ0aWVzJywNCj4gJ25vdCcsICdpZicsICd0aGVuJywgJ2Vsc2UnLCAndW5l
dmFsdWF0ZWRQcm9wZXJ0aWVzJywgJ2RlcHJlY2F0ZWQnLCAnbWFpbnRhaW5lcnMnLA0KPiAnc2Vs
ZWN0JywgJyRyZWYnXQ0KPiAJZnJvbSBzY2hlbWEgJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcv
bWV0YS1zY2hlbWFzL2Jhc2UueWFtbCMNCj4gDQo+IGRvYyByZWZlcmVuY2UgZXJyb3JzIChtYWtl
IHJlZmNoZWNrZG9jcyk6DQo+IA0KPiBTZWUNCj4gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9y
Zy9wcm9qZWN0L2RldmljZXRyZWUtYmluZGluZ3MvcGF0Y2gvMjAyNDA4MTMwNzQzDQo+IDM4Ljk2
OTg4My0yLWtldmluX2NoZW5AYXNwZWVkdGVjaC5jb20NCj4gDQo+IFRoZSBiYXNlIGZvciB0aGUg
c2VyaWVzIGlzIGdlbmVyYWxseSB0aGUgbGF0ZXN0IHJjMS4gQSBkaWZmZXJlbnQgZGVwZW5kZW5j
eQ0KPiBzaG91bGQgYmUgbm90ZWQgaW4gKnRoaXMqIHBhdGNoLg0KPiANCj4gSWYgeW91IGFscmVh
ZHkgcmFuICdtYWtlIGR0X2JpbmRpbmdfY2hlY2snIGFuZCBkaWRuJ3Qgc2VlIHRoZSBhYm92ZSBl
cnJvcihzKSwNCj4gdGhlbiBtYWtlIHN1cmUgJ3lhbWxsaW50JyBpcyBpbnN0YWxsZWQgYW5kIGR0
LXNjaGVtYSBpcyB1cCB0bw0KPiBkYXRlOg0KPiANCj4gcGlwMyBpbnN0YWxsIGR0c2NoZW1hIC0t
dXBncmFkZQ0KQWdyZWUuDQoNCj4gDQo+IFBsZWFzZSBjaGVjayBhbmQgcmUtc3VibWl0IGFmdGVy
IHJ1bm5pbmcgdGhlIGFib3ZlIGNvbW1hbmQgeW91cnNlbGYuIE5vdGUNCj4gdGhhdCBEVF9TQ0hF
TUFfRklMRVMgY2FuIGJlIHNldCB0byB5b3VyIHNjaGVtYSBmaWxlIHRvIHNwZWVkIHVwIGNoZWNr
aW5nDQo+IHlvdXIgc2NoZW1hLiBIb3dldmVyLCBpdCBtdXN0IGJlIHVuc2V0IHRvIHRlc3QgYWxs
IGV4YW1wbGVzIHdpdGggeW91ciBzY2hlbWEuDQpBZ3JlZS4NCg0KSSB3aWxsIGZpeCBhbGwgdGhl
IHdhcm5pbmdzIGluICcgbWFrZSBkdF9iaW5kaW5nX2NoZWNrICcuDQoNClRoYW5rcyBhIGxvdC4N
Cg==

