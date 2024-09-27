Return-Path: <linux-kernel+bounces-341321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FCC987E53
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21FAB1F2310E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 06:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B05E176246;
	Fri, 27 Sep 2024 06:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="LAvE6oxZ"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2044.outbound.protection.outlook.com [40.107.215.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6916815D5C1;
	Fri, 27 Sep 2024 06:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727418092; cv=fail; b=GHtUlGO75Y301RhtHJTmsBkl4Jv1BdZ97BMIbqklPGwJ9XL63vvnxT21FyDHIs4Q1JCVDHAFhXKdkxG78wwqa28b7OANtUPBu+l0IKxGxDn738aVGBn8AJsNn7BVTq76K/yO/W0L+hb2x2G9MKq0YzZpvQk261rZnidgVrdazPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727418092; c=relaxed/simple;
	bh=yyNoxlszsqFdLjo5+nfal2EnH5j2J2SqTXZNlZbEVyA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SrKD8Y8i6kGEINIZ26Pp3dLK1cGmSsn1vzyAAM1Z5pnRb0UJ9rv1XK6T9xQhpOk09hqt66QuZ0rHl68T/aeOTGEicjZAnwjJD+Vnz8LL7DEx+qBMqUK7oopcC3EXitbs8mo9VKvtInUyYT3EwC1DP8tpRkEVfVx/8RZ2Ip+APM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=LAvE6oxZ; arc=fail smtp.client-ip=40.107.215.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wplJrb+v0XAVofbKCZvOH/3i4NxZwphQNRP5Eda8FSo1o1ymffryW1/hSxDSaIDTTVErMoLfp6sZFmQ8bdWro4lI4otrlI3JO6ROBcykO82dO06Ge0LV/9PISVzCqS7a48mo774piSt92wHzDU/GOjQTDbv+EsCboqshISeb/AIx0eiYEwrWuc9HWvl95awZ8kUaDzHRE1pDG+K7MOjVW3WKsS3zmtbRBIEs4MCwXDBw6/P/Vx0BqOApJPm50m7HDcliOdjPpOXJcLIeqcqWouLtOuX2UhMUjV10ERBokg1hX30Vywoy0ou5j9gDGmWXPxyoCH+Y0nJy17QgkD4ACA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyNoxlszsqFdLjo5+nfal2EnH5j2J2SqTXZNlZbEVyA=;
 b=faCHW1MCQQqH2tfAJ8A4XDdaDwh0SNgowvf8IIhD68U8nSQGJpJu4dwfal1sdQT3lp31W93wlsy1W2/cNR4ohdty59chSavzMxLbceFCJnHFy5ZE3uY2Ptl4VggPxNdd4AG7MNuIm0CapAyYa4n2vqcqcSH2vVwgh1ocY+3Q2gRGL8cv6OnxjZYPIYFYWmkhwyDAGr7sx9urVKXry1xjiREQt5B/a8kljnXl0rkJzWGr1rn7zVhGN3DpBjHaqQqaC9PpcwDy5r0yl4WLC8gnpNY8Z4R5jO2hn22TZ4Q6yVb4gQEs4My4QWcJd67BMJMPuxf1WSSiRXwUNeiLtXX1MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyNoxlszsqFdLjo5+nfal2EnH5j2J2SqTXZNlZbEVyA=;
 b=LAvE6oxZDfz1mJsvvIrR1kfj9+CzlyMdFq/8Hyo0lU53RxUr3GR2FtTwYcgxtukSRoBhKHgImx6jG+Om29j8EXi2AODQCwOR4fgksvCZNRHsqISHjTujS5QDnFUS9USkG4prl/X+FJdF2+z6+IDmwscIdOjYVU6zhge/pgZqCmOzHAy/5oB4HQlcwaYkpgETJ2e371igTKtZvBQ7nR+e8xb+P0AvH5uyczpv5jOaifnTvMBs7/jc7Z+2AdYR8tE+W5RRH8mikpQLrK+/hjsrdP9pgc6DiT7BqcjPzWWeh8Jry6u0LQSVGX3kdGMkFabEk5QdwphYugu00Wni/1Z+tA==
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com (2603:1096:400:1f3::5)
 by KL1PR04MB7289.apcprd04.prod.outlook.com (2603:1096:820:102::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Fri, 27 Sep
 2024 06:21:26 +0000
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96]) by TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96%6]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 06:21:25 +0000
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
Subject: RE: [PATCH v1] ARM: dts: aspeed: yosemite4: correct the compatible
 string of adm1272
Thread-Topic: [PATCH v1] ARM: dts: aspeed: yosemite4: correct the compatible
 string of adm1272
Thread-Index: AQHbD7Q2eW66Wbq4s0SgBTKCf2nHYLJrJbkAgAAE6+A=
Date: Fri, 27 Sep 2024 06:21:25 +0000
Message-ID:
 <TYZPR04MB5853E2B3197AAD9268A0BAB2D66B2@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240926013411.3701546-1-Delphine_CC_Chiu@wiwynn.com>
 <c2ddf0375eff2c9c18fd26029fc6a1be7ed23a8b.camel@codeconstruct.com.au>
In-Reply-To:
 <c2ddf0375eff2c9c18fd26029fc6a1be7ed23a8b.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB5853:EE_|KL1PR04MB7289:EE_
x-ms-office365-filtering-correlation-id: 9ffd40c6-d268-429b-a5e8-08dcdebc9d72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RVBabG00UjN3bzEza0V5cWoyVXdpaURRdXh4aUtVRUZQTUlVczZIOXpjeVVy?=
 =?utf-8?B?RUlBbU4zQWQrdVFicWNzU2t4WG1lc0lzeWszQnN6MitPWWpUQ3JTRjFRVXdt?=
 =?utf-8?B?N0N5YnpQNU5Yck1ybmJKOUR0OFNIY3I2ZEo2KzV6YkpSQ1hOaUc2d3JTNEJN?=
 =?utf-8?B?TTdFZWJMbjU5QUpJQ2liQnFUNWZ0a0hPSVk1OTVFak80Yjk3R3NJa2U5VUpo?=
 =?utf-8?B?UWhkV3pXMVF0bVFIVXN0bVBHc3lzT1l2bGZIcHJwVkhEeW40Q2NwWUhwUmRj?=
 =?utf-8?B?VTVQOGNEUnRTY3Vta2hGTWw1cjExdDVhVHM3bkhiOUZvV1podzJUZVhtWHgv?=
 =?utf-8?B?dGVjVjZ6Yk1vQmV3Y2I4Y0cvR256NEVBVUVkL3dXaER0S0tkSXBOeVUvK3VE?=
 =?utf-8?B?MW43VEpCMDk4TnZRWHJOWUhiRXBNTkgvVldET0JoVkZyLzF4Z3N1UEhqdm5O?=
 =?utf-8?B?YVI1R1dwRnFsdTc4Tm91dUpXTmNZdmJHWTFPZjR5UnVKMG54WU5UcHA5OE1t?=
 =?utf-8?B?Uk44anRiSkRwZ3BTdUlLNVdMNmpORVgzM0pvbGFpWW95UURVQ0dhQ1YzdDJk?=
 =?utf-8?B?cm4vN0lsSmdlWExOTEhQbUswdnp0SEVKVjU5S0lrZVorTGhTVndhdlhsdUZT?=
 =?utf-8?B?ZEliSm50bE93amNQU2FRNWtmYUlqWUJyemYrbEtDc01rN2sySGptVVFtNTBo?=
 =?utf-8?B?azAzS0VsWEZWQXhJL3lZWkpVcFNGNUxJdmFjS3ltNUJabkhMSllmUzhaS0xm?=
 =?utf-8?B?Y3RNVlY3VDROVFdpRC8vTVNYYytlRCt2VVJOSkFvZnQ2L3ptSloxTUxSNnhJ?=
 =?utf-8?B?WllEOGJsVnc3dnUyQk1WVXhVQk92SHpBVW83Vytobm1NRFZERzJLSWhGR3d2?=
 =?utf-8?B?N3ZIMHdiMXVvTzJkbWJKdjgxVlZETVMzQmlBR1ovK0RJMUNDdTM2NDZsei8x?=
 =?utf-8?B?Ti94RTZLcDNtb2wyQ2hzZmlVZjRQMGdoSFp2bitYQ1kvc3NvNk40REpKSzYr?=
 =?utf-8?B?WmN2VlVROC9SWUxQNWFRQkJhUlJBSUFuamx1RFZqS0gvaTg0bzN1Vks0WWp2?=
 =?utf-8?B?RGVQZk85dE1IQW9MZGtsL084YlFwd21HeFZaeVZVdTZpVW44S3lwa0JRUnRF?=
 =?utf-8?B?Z1N5L2U1Y0hBenY4MFlLWnYva2E4VzgzeWpBa1Y1c2FPajRzNFFoOXdRVklM?=
 =?utf-8?B?a2cyUkhaaVZ0ODFXMTVDZUM5blE3TEJsL1pXSzBrS3RUNGFWcU1nYzdnS3BM?=
 =?utf-8?B?VlJ5VG12eWZ1bFFBRVU3RkRyM255YVpPOUlNTndTM2FIaVNnTEdCaFNpc3d3?=
 =?utf-8?B?RTdvMGNUMUlocjN4dVhTaGFqUmlvSm1HcDduSnZ0MjVyZHJlejJqMUxDdndR?=
 =?utf-8?B?Q0RsaTBsZjZUT084SUhHYjFKaUpZU3hsMVpwT0E5VG5CMHZ4ZmZTM0Z6NEFu?=
 =?utf-8?B?R0VHSlFyaC8wU3F6alRnc0JOQzlpQmZ0UThkbE4wUk0rNjJpb3NvcUIxWmF2?=
 =?utf-8?B?a1dKWTlTdjhiQncxQldaRk4yVmdGNWlaZjFvWEJseWRKcDU4d3JDdW5MeXZK?=
 =?utf-8?B?Y1RjNlBrc1JVTUcwT0puOEVGaktycjNidmVSQTAwRk9RalpweXF3SGsyaFRV?=
 =?utf-8?B?WVd4aXBkN3doc0djRGdTWWlEeDZYUmZaMTdhZjhwRWtkUGJrTXdweXhWZUcr?=
 =?utf-8?B?OXB6N29GNmhIU3Q1OE9IbXNYMW43OGhyZ1AzamE3c2grM1lGL3ZxTmcveWta?=
 =?utf-8?B?TjRuTzhGcnFXMlhSWE1RU0NISVdzUk1heUJzTEVkMGQybktWZ2ZRMUdKMFJQ?=
 =?utf-8?B?Ui9jbXl4TG8ybStEaVdoT0N6bGFoTk5hNlcxZkRxWTZkN0Vzak12SitvcU9y?=
 =?utf-8?B?bjUwbjBFaGg4NWQ5R1RsMFFMZFdybXdjZWRXWXBhYkhWbGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR04MB5853.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Qk1zbmFCWWV0UmdqbmlLZks4bEd5WUIvczZ1eVViNXZGQ0k4UTd5NVhPdDNS?=
 =?utf-8?B?WXEwTDRpeFVkb3IzVmxQSHNTdjYzU3pIUUoydm5qRlhJQTZrZTROWlVwbWFr?=
 =?utf-8?B?LzRlN3AvdXZWNUpkV0swSGZ1dlBwL0hWRFNzUGwreUg4RkdIL1BJOTFXempn?=
 =?utf-8?B?MUtFazBXV2xUcDJsRnBUSENIYVMxYXJ4Y1BPTWFkekc0TExUYkpRSGxSU2h1?=
 =?utf-8?B?U0NPRytiVUJuUGdQUzg4bFpHMnB2czM2UHl5SE1RWDZ1VFNQcFJvT2oyeGhK?=
 =?utf-8?B?WVI3VGdMVGVEaHdRTmVhZkpENEJ2R3dxazN3Rm40WDVJODljL0hqZlg3R1ZK?=
 =?utf-8?B?T3hzRWNQVE4ydlVkaEJwYmU1V2tZV0J3eU5HZGREcEtSOVpKVUhNL2xwN3BG?=
 =?utf-8?B?SXhjR3ZwUHpUeVpmakJNRFVDRjZUTnpRSG5WUWtwZjN6NGI5aEZUNzBPK05z?=
 =?utf-8?B?Q2pOQi8zOElERHhiNjhNNCt6aTY5NnFrZEVKU2VvNVk5bTUvejdUTFNMZk5C?=
 =?utf-8?B?MGdML3F5eDFQblptTTR3ZSs1Q0JpaEpZWFQySHA5cUlvRzRsRkZWVU15d2hJ?=
 =?utf-8?B?K0lYM2l5aWU5STVTZFRzTWh4bGpmN2xyY09UZUVBeVNLa0s0VHl6Z3FRcWZU?=
 =?utf-8?B?RFROaW12MEY5YVBIb0V0bjBsdzNaVW1UQlZKQloycjB4a2xnOUMvUGhWdzVv?=
 =?utf-8?B?YXZSdTlZZ2sybmg1WCtrYld5bFlNbThYNGgrQVZZdXE1a0RaMWFCZWZ4Mk56?=
 =?utf-8?B?MmdjT1JQM1hjWWNKSHBqUkpXV1RlbVJBLzFkc1BaZnVTS2R4WWRwUUJ6MDc1?=
 =?utf-8?B?YVMwSS9EWkNaN2srblY0TFNQR1dSWFJGRGxQUktrdWQrVjJmbW1KS2ZFMXNl?=
 =?utf-8?B?dEVkbTBLVFQ0VUNLelR6VzhEVlJRWUVkQjB3Z09oZy9ZRDVTR2pjN0NIZHo5?=
 =?utf-8?B?RlJVa2gxcDBCNk5XNlpDc0NVSWg1dFdpUHZ2d0grSTZYUFpHZVRnaWZXemI0?=
 =?utf-8?B?cDhZWnlkZWlQTjVFc080Q3oyNElsTU1SL1BwRlY5cE9aTWZyblM5aEd5MUQ0?=
 =?utf-8?B?TUtGSjRZczgvTzhXVHZnUnpPWjlBRmVTM0c3UkRoV2MxRlVWM3BkSWJoaGt5?=
 =?utf-8?B?RGJWejdzTXIwdCtNbkd3SGtDQzlRTk01V0VYbzJWWXBTOGhBa2dMR0RqdmpH?=
 =?utf-8?B?ZEptZHk4M0tqY3FObWxPVkNzN2thTk9TQzJNbmYxVm1pbFE0V2ZqUExXL05U?=
 =?utf-8?B?OXpYQWEyVjFzU2xPbU9Ld1VuTFlBemZNQmFVSW9MZDR6bi9QNUJqWDhOSElH?=
 =?utf-8?B?R1l6Y3lBbXZwZVFaU3V1UEd3NmlYZW5BQU1lTzBzY2lMbDUvaFhIZmJSY25O?=
 =?utf-8?B?VFU2YlNSN05zNkNLVTVwSVZ4U0RBUjlmdXA0SE1UMElURjhLUTE2QUxiVUtG?=
 =?utf-8?B?T2VWVS9ZRVRmRjJtSS81aXlRaFViMGxvcFZPcHhIZ1R0Mno5VHJDZzZvT1JJ?=
 =?utf-8?B?NndaNnA5WlE4WDJBZDFtM1VLVU9JWWlPd0EwQ0lYWksrSGgzcU0zeGlpZGoy?=
 =?utf-8?B?WE9keS9IREhpU3FZR09lSWFTcDRLdXFncWVrWk9YZ2wwVFpnanY3MW5KOURF?=
 =?utf-8?B?UXFWL2xTMEZTMm5JcEE1dnk1dlFxME1SbnlXTWl1U1lEVmQvQ1FFbEpFcmFj?=
 =?utf-8?B?akpmcDViNHNvR043TERreC8xTE9PczhUbWp4S1U3THQ1ZjViRHd5K2hlY0JF?=
 =?utf-8?B?RDAyQ21QMmtMK2x5Ynh5WHNnZjB0ZDk3bDFiZlROcGUwVWlBQTE0cWtKNU42?=
 =?utf-8?B?RXRvZEM5SVdkNU51TVU0YUZUT3pDM2c5UDF5clpoeTVHVVZ1UnZoOG5YaGpM?=
 =?utf-8?B?eVpUSDlMMmt5SHYwU1FUOGZ5T0t6S0dJczF0akYwbXR5Mk1yMUwvdkx5dGVH?=
 =?utf-8?B?MGJ5TDRYVGlVSXl4SnNzbjhxWW4xMUZ2TXc5ZU12RGEzbitPWGN3SWlNMjly?=
 =?utf-8?B?dCtZRDlXSmp4cWxlSU5KRDI4ZGZLZDQ1VU90RS9iSEd2S1lGYjBWMWt2SzEz?=
 =?utf-8?B?Q2F3bk5Gakg2WjhXd09WWTh3dytqc0NoME9SdFplVGVMZVVKUjRSYUtSM21Q?=
 =?utf-8?Q?5gMnvxtRzINVvW9ktSE1lCDbM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ffd40c6-d268-429b-a5e8-08dcdebc9d72
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 06:21:25.6074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c/BJPNb+F15zG92iJqQAl3+z9VALKteiQziAPBTdolUWB8LDpoXUCVG1AOoNkBaROKyjy5IDGkQn284RmAA+EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7289

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IEplZmZlcnkg
PGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT4NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIg
MjcsIDIwMjQgMjowMSBQTQ0KPiBUbzogRGVscGhpbmVfQ0NfQ2hpdS9XWUhRL1dpd3lubiA8RGVs
cGhpbmVfQ0NfQ2hpdUB3aXd5bm4uY29tPjsNCj4gcGF0cmlja0BzdHdjeC54eXo7IFJvYiBIZXJy
aW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxrcnprK2R0QGtl
cm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBKb2VsIFN0YW5s
ZXkNCj4gPGpvZWxAam1zLmlkLmF1Pg0KPiBDYzogUmlja3kgQ1ggV3UgPHJpY2t5LmN4Lnd1Lndp
d3lubkBnbWFpbC5jb20+Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1hc3BlZWRAbGlzdHMub3psYWJz
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYxXSBBUk06IGR0czogYXNwZWVkOiB5b3NlbWl0ZTQ6IGNvcnJlY3QgdGhlIGNvbXBhdGlibGUN
Cj4gc3RyaW5nIG9mIGFkbTEyNzINCj4gDQo+ICBbRXh0ZXJuYWwgU2VuZGVyXQ0KPiANCj4gIFtF
eHRlcm5hbCBTZW5kZXJdDQo+IA0KPiBPbiBUaHUsIDIwMjQtMDktMjYgYXQgMDk6MzQgKzA4MDAs
IERlbHBoaW5lIENDIENoaXUgd3JvdGU6DQo+ID4gRnJvbTogUmlja3kgQ1ggV3UgPHJpY2t5LmN4
Lnd1Lndpd3lubkBnbWFpbC5jb20+DQo+ID4NCj4gPiBSZW1vdmUgdGhlIHJlZHVuZGFudCBzcGFj
ZSBpbiB0aGUgY29tcGF0aWJsZSBzdHJpbmcgb2YgYWRtMTI3Mi4NCj4gDQo+IEluIHRoaXMgY2Fz
ZSB0aGUgc3BhY2UgaXMgbm90IHJlZHVuZGFudCwgaXQncyBqdXN0IGluY29ycmVjdCwgdGhlIGNv
bXBhdGlibGUgc3RyaW5nDQo+IGRvZXNuJ3QgbWF0Y2ggYW55IHNwZWNpZmllZC4gRG8geW91IG1p
bmQgZml4aW5nIHRoZSB3b3JkaW5nPw0KPiANClN1cmUsIEknbGwgZml4aW5nIHRoZSB3b3JkaW5n
IGluIHYyLg0KDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNreSBDWCBXdSA8cmlja3kuY3gu
d3Uud2l3eW5uQGdtYWlsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEZWxwaGluZSBDQyBDaGl1
IDxEZWxwaGluZV9DQ19DaGl1QHdpd3lubi5jb20+DQo+IA0KPiBDYW4geW91IHBsZWFzZSBhZGQg
YW4gYXBwcm9wcmlhdGUgRml4ZXM6IHRhZz8NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEFuZHJldw0K
PiANCldvdWxkIGxpa2UgdG8gYXNrIHdoZXJlIHNob3VsZCBJIGFkZCB0aGUgRml4ZXM6IHRhZz8N
ClNob3VsZCBJIGFkZCBpbiB0aGUgcGF0Y2ggdGl0bGUgbGlrZToNCkZpeGVzOiBBUk06IGR0czog
YXNwZWVkOiB5b3NlbWl0ZTQ6IGNvcnJlY3QgdGhlIGNvbXBhdGlibGUgc3RyaW5nIG9mIGFkbTEy
NzINCg0KT3Igc2hvdWxkIEkgYWRkIGluIHRoZSBjb21taXQgbWVzc2FnZT8NCg==

