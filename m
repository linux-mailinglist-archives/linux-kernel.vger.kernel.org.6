Return-Path: <linux-kernel+bounces-333912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 744B597CFCC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 03:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF40F283CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 01:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9393BBA20;
	Fri, 20 Sep 2024 01:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="1ALewKX9"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2059.outbound.protection.outlook.com [40.107.255.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38636AD51;
	Fri, 20 Sep 2024 01:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726797298; cv=fail; b=kucalNZhJEMJ718wktVuk8OuHjFXOQegT6TCTIn78/D48t0S477B+40bNy2Vz0+RrSwAyIrebbUCs5gk7x/BuaclzW/bmG1NPmAjOhXt3t74yQc6tiGyVQxwFbT3r2IRg9zDyxlDf/sMiXgZRT35M9CH794c4cGEI559A0RPdi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726797298; c=relaxed/simple;
	bh=DFeXkhwT2m6kwJsCzBHbOM+RqVxrS/jFRNh8q+oOVL8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LV/nxztX9rxatDTHX98v5eZc/4vYi8KzMpxblhWZwI3ji+YI5trqB/DK9jaZV6/dHFNEiIi6lEvuOu4AnaOw/6p4k6gCy8vg1gvIBsTnUTUPb6XCzw3gcIG+wKKx3H+gmo1wuxsMMYTkHLS8a/N6eOhCSTizDq5tSjN9dZxRkcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=1ALewKX9; arc=fail smtp.client-ip=40.107.255.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/oI0dJytAw4wNRxXacaKahahFNmV9fPeUpvqSmAXnKPLp0KbEieiMyG6uC4Q6ZmuSuc8QFQnL92y1qLuQvfFNVlNuh01s8RPpvTPGvBIK6+nMBtRQFJa8lODuWOp2P3P+jzCrRlDJ26WKwoHWx2lqtIIsFiqLYIe4w0bPEpBDEvbtxlThrqdGbuXdokUUfeccBXI4bykmQf7W7/d/i8RLIuXatSCsBal4JD8gHdQ9UUm06hIFpSkBm4xgGrUsKouJHQwO/2X2s8Z5LnqFzbiSvbu0tbjODMDqV71PtnOCTyoryHzw389R1OIN4PPyZpUgl2wmTi6FaRT/Wv19Y0vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFeXkhwT2m6kwJsCzBHbOM+RqVxrS/jFRNh8q+oOVL8=;
 b=Y4LzeQN9jgcqSmpYlUIb6Bh1EMoyxbIbkfT097+blaC47H6wEeRfKhrgeS5kTspVDRstQa8VpSl2DrtX63ZqkCFOYi1vREYC0+0THaETCTExt7KoiKefEEukHHxAbLnNVuTpM9VjTEPnw/rzJhz6Y49f3X9swIHvZ1vNpAvvupCWkI1LH/ArVcc+FW1h3rH+R9/FpajJa8MoYVafgnUrvUrTSm1NBComluZqNRZYHUkNElN09Y/g8ZEWupY+TPtdyjYs8gcW2xC184RhQPLne3yQ5utLjJz1rS/MzLEb6+h+jOMSqujH9/Kh/twTNtO5Bx6K05CLFjK7JKEf+DeyLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFeXkhwT2m6kwJsCzBHbOM+RqVxrS/jFRNh8q+oOVL8=;
 b=1ALewKX9xjL/lSqmIMIYoxhHWnZzWJI1QREwjvXsHsUwqWnUBdKWo2aHKv9eQ1GsHRlto2frFFdvHWmdDZHtcs6wL8dVSc1c39jvU4KpdfcXYlLVf7wPB329myJzPVIU7YcKwBMFSxLIlIC0C5krS8tYZ+j4OTiIpjCakjbec4yoznd49nUpQ9uBQFOsb8ocXuOsHCBh//mt7+kRJreIWE2AO/vNm2xWX97lS5UOybYzQHCEUNt+sm2ALODUMFKPKK1AD5SM4/tADrGj7ZbdGF12cn8Nx3zh8T0RWBehGLHEa9myZkJz+w5RfGlRpyb7QSMR9nf/6sILdSdhIt6suQ==
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com (2603:1096:400:1f3::5)
 by TYSPR04MB7567.apcprd04.prod.outlook.com (2603:1096:405:35::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Fri, 20 Sep
 2024 01:54:51 +0000
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96]) by TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96%6]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 01:54:51 +0000
From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Guenter Roeck
	<linux@roeck-us.net>, Delphine_CC_Chiu/WYHQ/Wiwynn
	<Delphine_CC_Chiu@wiwynn.com>, "patrick@stwcx.xyz" <patrick@stwcx.xyz>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
CC: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, Joel Stanley <joel@jms.id.au>,
	Peter Yin <peteryin.openbmc@gmail.com>, Noah Wang
	<noahwang.wang@outlook.com>, Javier Carrasco
	<javier.carrasco.cruz@gmail.com>, Fabio Estevam <festevam@gmail.com>, Lukas
 Wunner <lukas@wunner.de>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v2 2/3] dt-bindings: trivial-devices: support MPS MP5023
Thread-Topic: [PATCH v2 2/3] dt-bindings: trivial-devices: support MPS MP5023
Thread-Index: AQHbCbDSbgtqjaM7UU6HpgGBaLCKtLJdxQwAgACM3ICAAZk/AA==
Date: Fri, 20 Sep 2024 01:54:51 +0000
Message-ID:
 <TYZPR04MB5853BD9CD0774B40BAEF7BDFD66C2@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240918095438.1345886-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240918095438.1345886-3-Delphine_CC_Chiu@wiwynn.com>
	 <bf5258b8-a5a1-4cf3-9bd0-1fa44696c3b0@roeck-us.net>
 <355b19a62e54aa979451d796c3ebe1e294a0cf45.camel@codeconstruct.com.au>
In-Reply-To:
 <355b19a62e54aa979451d796c3ebe1e294a0cf45.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB5853:EE_|TYSPR04MB7567:EE_
x-ms-office365-filtering-correlation-id: a596c260-5189-4be3-1afe-08dcd9173711
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZHhybkZqcDJnSUhkQ3NnZkZSQ3FFdnZTejljZHpBelN0SlpvRGJoVWY5REc3?=
 =?utf-8?B?OWJ4UHNRZ0ZuRDBpVm94VVdKUWtBVFE2SSs3UWFaQURKNnFJVnVESzlVbmlN?=
 =?utf-8?B?a1llc0ErcEF6M21haHF6dGlybnhCRndZV0o5R3Z2QTI2akptcWI1by90NFJ5?=
 =?utf-8?B?WXRhNnRJK2lldWNFVXdsOTRhZjRVNUVKbkcxVStnT0ltRFFiQWZETUg3cEJI?=
 =?utf-8?B?ckJxQWNFaFNJSWFJeXJTWUhJMTk3UWZ1SUVLWXBPR01nQmxtdlVrNEdIVnVx?=
 =?utf-8?B?dWVlRjNnTnhBUHh5bklaLzMzUVVHMHlJeFNFUVdPbktKaXpBYThOc2FacXc3?=
 =?utf-8?B?WUN5N0s1VlJkMzlVZW82cXF1RjIra3dQY1MwR0Y2ejl0R282SnVYRWFtRzQz?=
 =?utf-8?B?QkVvbGJNcTFaaFdMVU41UDl3MEhhRlE5N0d2T2JTajVYOTlRakZGZ3pHMWFm?=
 =?utf-8?B?dGZJTDZuMUJuaFNPd2ZzbUljUEM4aFVzVjdNeHJmcWZvZ0RWLzJhYURpaFFv?=
 =?utf-8?B?UExmdDRSL0tJeEs0WlZ2MnpyOEFHUCtCWG1lQ2xGL3NBbGNyNWluRGlxQVda?=
 =?utf-8?B?SW9nRkFMWGt4SlU3S1hOYkNnL2VFSHNORXNOY0JLSTF5VlQ5Q2kxc2NyKys3?=
 =?utf-8?B?enVEYUI1L3BmUWw3NklkZkl2NTQwaTFhN09qN1h4b3ZyV21uUlpFTTN3d3k2?=
 =?utf-8?B?bTZiU1JweGZZQjhwMU1ZVnRmZWNtbE84bEhKQlg4ajFzUmx4Nk1heW5nV3JU?=
 =?utf-8?B?eldOeEpOVTNLYnFINnZTUk1TVFN1bU1oU0Y1VmUxc1hBRzBkNHNsN3FTTXpC?=
 =?utf-8?B?Q2RyZG5mN1lDVk9MTUkwa04vaXBKZnQvbVJHNk1lRXY5RFFkWkh2VVF6RGRO?=
 =?utf-8?B?eHhHR3N4Y1hjNXd3SG4xeWtXeUgwSk9zaFhQYjF3TlUvMU1TUjBoR2ozaWNP?=
 =?utf-8?B?NGIzMkdMWXFQdGxRVUh1dit1cEU5T0RzM1NScE1ma1dhTE1BbkJ5V3d0TkNY?=
 =?utf-8?B?Slg4Y1hJRFVCUUkyUzJJUHQybmsrQS9UN1pPVlVJNXB3VDUrYk1rMDY1YkZi?=
 =?utf-8?B?bS9lZkl4UGFHTnd4NFl0bXV5bHpuYXUvTVdsMzg4VmJ5a0x4VlJxSHFGVWxa?=
 =?utf-8?B?Z3NlZ3FaNmVsUzdxMS9ocmdmUzlWTE5zUDZsL3lZQ3hPSzl6V3M3YUZBNzMr?=
 =?utf-8?B?TWxaRlJIYlhyM2gxUVlkaGNLTldpbzJ1WVRzNEJoRk04ZzQ1YlJ3bmR4Qnhz?=
 =?utf-8?B?TWgzR3ArN1hFR0Y5eFpTVzVQcUtkdlBuL2t5ak9rbjJ3N2tyMkExQzErWm56?=
 =?utf-8?B?azFrUy9BSlBjengvVldrTGhDN3hURTlzdmVCS1kyMU5IMzUwblRYVEE0RXRP?=
 =?utf-8?B?STFwV1ZBMzBQb1FucFprdWQreWcxaGkvOGx0Z2J6VGtmMG1DdTdlem41MVhJ?=
 =?utf-8?B?RHd3TFJVZkszYzBOQ2daNU1NRlNYaWU4NTZWWHNpczB0SDdmQlZZajFsZktO?=
 =?utf-8?B?ZkM3aHdmemdKdFE3OXkvTHBiZUM0MzAxS1lzS1psTy8zZHFac1pKZ3YwOVBi?=
 =?utf-8?B?S1lXTVBWMmYrNzk4akNwcTFZbDVFYWhVV1RsZ0xXVno4ZWJLTDJPVFBweGoz?=
 =?utf-8?B?Q1dXSVVTTUQrUEpXNkU1RnE5dU8wMDRadHlCTHNtMXBRY2FJTHA1aTUyNHRO?=
 =?utf-8?B?aWNTbTkwL1Nxcm5HT0F4eXpBUm9OR0srVzBGVktJaXE3bnR1UHhlcHoreGwr?=
 =?utf-8?B?bzBPQ25KWUs2ZitOOHB1eTNxaXVNNUhUMnZvZUVTUGhkR2FtcFgwYktTOUc3?=
 =?utf-8?B?eVNmQmEydVZpZjFwTnh1UT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR04MB5853.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M0NCV2l5SUR2UkpsWFZvTWEzVW5oamJ2eHA0QXkyc0JiaXlFSmJjOHRDNWJh?=
 =?utf-8?B?Y1JENHNaTXdmQnBDQzRVNDlseG1JTlpoQTc2UUJxTDBTbXhQaWZ4UjNXY0xl?=
 =?utf-8?B?UHhqZWREWlB3VVJtdUNoeFJFTExNYVVJN0RVa2VTL2p1aExJUE9pbmwzNktV?=
 =?utf-8?B?dnFYa3ZXYnRrL2VHS3F1SnNLdFpkbFQ1aEdsUU5XY1lVYlNsRHhGcyt1NWlH?=
 =?utf-8?B?TmpDejk4dXJtRUlxRHdPU29YRVZtYlFzQzlpSUlUUGVnZzNUUGpUZVV2aWx6?=
 =?utf-8?B?YWdzam5FdUgzck5CcVlhcTdFOTZ4Ry9jNDQxaHVFSy9ITmg0eTZhTlhnaHFQ?=
 =?utf-8?B?VCtxWVpPNjNvZG9kMzV4akJXb3hMb2FDcEVZdlhMTFJkZ1ZvVkRob0xsWi9o?=
 =?utf-8?B?S2dSN3ZVaXpVSjRnVnhTTjN2LzNBM1lFd0s2eGZnSCtRNGViNndaeVpraTJ5?=
 =?utf-8?B?eDZsQmoyRFd1THRJL3N3MnVpZGM0TFdzQytVWloxU3R2b2JrcEYvUDBVTm9K?=
 =?utf-8?B?NHVjUzRVLy93WnQ2d3JyeU1NRG1YbVdXRzJ6NDhTSFFWS2NiN1RtSkMzK0pQ?=
 =?utf-8?B?UTBOcXBBbWFoa2k4LzdNcTg0Uk9CRW1hYzU0RmN5NDNpMnAyOFB3dVNpVlhF?=
 =?utf-8?B?a3Vtd0ZCS0RpSTZHbkMxeFpXNGg2a2RyMjU4elNEdlcvQjJqVEFGd2JTWjk3?=
 =?utf-8?B?elgvbWQ2REZLaXBFNURlRG1tZGtqb0QxZnBrQmNlZTFUYlV2ajhkKzk3Vjgr?=
 =?utf-8?B?NThNWkNmbXdtVXJ6M0djTHpWK0UwdzNuRkFOUHpBRzF1bVJXR2hOSEsrcTFZ?=
 =?utf-8?B?SytQNjg1ZlVFRGJYUmxKR3B1RFhuRXFnMWNtNGNqRDFlNng5a0ZCd09MWGR1?=
 =?utf-8?B?dnU2ZktaZUNnTVlKWHg4KzkvSWdIUzJ4WDZHNUp2OGRyR1lyWllBc3FOOENG?=
 =?utf-8?B?TjVza3k1QitLSTZQblpBMHMzK2NxdHVKUjdIVktzNFd2UDJWMmJqZFdWY2JH?=
 =?utf-8?B?eTVudXNZM2xSTGZuQlhuV0ZtUXFhQkxSeUlLSUhLZm1OM3ZBOTZ6cW5uTkR6?=
 =?utf-8?B?dm43ZGg4R25oaHFOQzZrdnFIWGp0QTRSWHhUbS9KbHNlaTdXeU9MaFFObE9O?=
 =?utf-8?B?a2ZuQ2huZytSRlFRaUVDUG5uMVVicEpUaUxUdWF4Y3V1Qlp1Y0lESkRIWHJX?=
 =?utf-8?B?NUd6djB1Zld3WUpCYkNDR2UzR2JrOHc1OGtOdXNRSXZJaDlSSm01Wm51NXlD?=
 =?utf-8?B?b1NKVXRMQ0FZUDZHWFEwa2xHRW5uQ2M0dTRmblprU1BiV2ErT01DanNhUkVN?=
 =?utf-8?B?SEMxNG0zNUNEZGQvdm9Ec3FpbDNiNmFaUTd5SnVmUCtEWWlYTHZWMndTWlQ5?=
 =?utf-8?B?MU5mMkExRWpwOFNhN1ZpQU5UR1ZmWVVPeXU4bHdiNGMzRVQ5eFh1a3NyRTlt?=
 =?utf-8?B?YXVUNVNlVkIrQ1BXK3dDWERhajVMRWdFS2ZiQi9wVFowUjlpdXl6SzlCYUlT?=
 =?utf-8?B?Z1BZVzZ5U0M5aFh3UUtnRTBuemk2UWZRWVMydThQcE5pZFVwdnJhSXR2czVp?=
 =?utf-8?B?MFUrd2Z1ZG1UV3NiczJWUTZMQmNQV0gxL05nSlV4NWQ2TnNjcGw4L1pLbFI4?=
 =?utf-8?B?Y2R5QmpWSVZtRFpvVk5QVWtiK3BwOStPL0RWa3dhZk5zMTkxVzBNMFYrL2lL?=
 =?utf-8?B?VFIzaGMvNXpOYno0dVhnZThhQmx0Yit6cnhUdmVZMW9qTzNXK0NtSlZxWTgw?=
 =?utf-8?B?WVdWQ2h5eGR5QUQvdElIOWJzYmVQOUpJT1NQOHNmT0p5dzlmWEhNRTVHKzNZ?=
 =?utf-8?B?WFoxSDE1bUd6UDZaZWM3bDRkemk0cUp1UjBEMm5EdkVZM1VWaDFiWGJPRkFH?=
 =?utf-8?B?TkwzUG1BSWF1ZEl6b2FtZkNmdzBhQnBGWHluSXdIN08vVkVZZEl2R1ZKU0E1?=
 =?utf-8?B?Q2orbmg5QlFxM1lHR1RYNER3N1l3aDlPZ29uTnNVcUdOUGYzbU9uRktsbDFK?=
 =?utf-8?B?bGpseVQzY0dlS0NPRVNEbXZDMjlwTWhPUWVkTUhxMnNEcVNrQ3oxbUJObnJv?=
 =?utf-8?B?NDNmMEtXSDl3ZUNGdVFvNGM5RzM1MmR6NWZrUnlUZVBzclpOZENiMXoxZVNo?=
 =?utf-8?Q?LQYQVAqeyDwyLqWmIB3+2hWsU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a596c260-5189-4be3-1afe-08dcd9173711
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 01:54:51.1067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DxxUBx7gG81TKc1K6KvOVpGU1TpmKK+3dxCIoRSXKzkh6e0nRRyYB5noXlmIr7mD8alFqCf14ekm/tz0wsIsDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7567

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IEplZmZlcnkg
PGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT4NCj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJl
ciAxOSwgMjAyNCA5OjI0IEFNDQo+IFRvOiBHdWVudGVyIFJvZWNrIDxsaW51eEByb2Vjay11cy5u
ZXQ+OyBEZWxwaGluZV9DQ19DaGl1L1dZSFEvV2l3eW5uDQo+IDxEZWxwaGluZV9DQ19DaGl1QHdp
d3lubi5jb20+OyBwYXRyaWNrQHN0d2N4Lnh5ejsgUm9iIEhlcnJpbmcNCj4gPHJvYmhAa2VybmVs
Lm9yZz47IEtyenlzenRvZiBLb3psb3dza2kgPGtyemsrZHRAa2VybmVsLm9yZz47IENvbm9yIERv
b2xleQ0KPiA8Y29ub3IrZHRAa2VybmVsLm9yZz4NCj4gQ2M6IFJpY2t5IENYIFd1IDxyaWNreS5j
eC53dS53aXd5bm5AZ21haWwuY29tPjsgSm9lbCBTdGFubGV5DQo+IDxqb2VsQGptcy5pZC5hdT47
IFBldGVyIFlpbiA8cGV0ZXJ5aW4ub3BlbmJtY0BnbWFpbC5jb20+OyBOb2FoIFdhbmcNCj4gPG5v
YWh3YW5nLndhbmdAb3V0bG9vay5jb20+OyBKYXZpZXIgQ2FycmFzY28NCj4gPGphdmllci5jYXJy
YXNjby5jcnV6QGdtYWlsLmNvbT47IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT47
DQo+IEx1a2FzIFd1bm5lciA8bHVrYXNAd3VubmVyLmRlPjsgTGF1cmVudCBQaW5jaGFydA0KPiA8
bGF1cmVudC5waW5jaGFydEBpZGVhc29uYm9hcmQuY29tPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgtYXNwZWVkQGxpc3RzLm96bGFicy5vcmcNCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzNdIGR0LWJpbmRpbmdzOiB0cml2aWFsLWRldmljZXM6
IHN1cHBvcnQgTVBTIE1QNTAyMw0KPiANCj4gIFtFeHRlcm5hbCBTZW5kZXJdDQo+IA0KPiAgW0V4
dGVybmFsIFNlbmRlcl0NCj4gDQo+IE9uIFdlZCwgMjAyNC0wOS0xOCBhdCAxMDowMCAtMDcwMCwg
R3VlbnRlciBSb2VjayB3cm90ZToNCj4gPiBPbiA5LzE4LzI0IDAyOjU0LCBEZWxwaGluZSBDQyBD
aGl1IHdyb3RlOg0KPiA+ID4gRnJvbTogUmlja3kgQ1ggV3UgPHJpY2t5LmN4Lnd1Lndpd3lubkBn
bWFpbC5jb20+DQo+ID4gPg0KPiA+ID4gQWRkIHN1cHBvcnQgZm9yIGhvdC1zd2FwIGNvbnRyb2xs
ZXIgTVBTIE1QNTAyMy4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNreSBDWCBXdSA8
cmlja3kuY3gud3Uud2l3eW5uQGdtYWlsLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IERlbHBo
aW5lIENDIENoaXUgPERlbHBoaW5lX0NDX0NoaXVAd2l3eW5uLmNvbT4NCj4gPiA+IC0tDQo+ID4N
Cj4gPiBUaGUgaGFyZHdhcmUgbW9uaXRvcmluZyBtYWlsaW5nIGxpc3Qgd2FzIG5vdCBjb3BpZWQs
IHNvIEkgYXNzdW1lIHRoYXQNCj4gPiB0aGUgZXhwZWN0YXRpb24gaXMgdGhhdCBpdCB3aWxsIGJl
IGFwcGxpZWQgdGhyb3VnaCBzb21lIG90aGVyIHRyZWUuDQo+IA0KPiBXZSBjYW4gdGFrZSBpdCB0
aHJvdWdoIHRoZSBCTUMgdHJlZSwgYnV0IEknZCBwcmVmZXIgdGhhdCB0aGUgaGFyZHdhcmUNCj4g
bW9uaXRvcmluZyBsaXN0IHdlcmUgY29waWVkIHJlZ2FyZGxlc3MuDQo+IA0KPiBSaWNreTogUGxl
YXNlIGRvIHNvIGZvciB2MyBvbndhcmRzLg0KPiANCj4gQW5kcmV3DQpIaSBHdWVudGVyICYgQW5k
cmV3LA0KDQpXb3VsZCBsaWtlIHRvIGFzayBob3cgdG8gY29weSB0aGUgaGFyZHdhcmUgbW9uaXRv
cmluZyBtYWlsaW5nIGxpc3Q/DQpTaG91bGQgSSBqdXN0IHNlbmQgdGhlIHYzIHBhdGNoIHdpdGgg
b25seSB0aGlzIGR0LWJpbmRpbmdzIHBhdGNoIGZvciBNUDUwMjMNCmFuZCBpdCB3aWxsIGJlIGFk
ZGVkIGluIHRoZSBtYWlsIGF1dG9tYXRpY2FsbHk/DQoNClJlZ2FyZHMuDQo=

