Return-Path: <linux-kernel+bounces-410892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624F79CF067
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83E63B348F7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7211D5AA5;
	Fri, 15 Nov 2024 15:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="oteuF6Ue"
Received: from mx07-0063e101.pphosted.com (mx07-0063e101.pphosted.com [205.220.184.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46671D515F;
	Fri, 15 Nov 2024 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684512; cv=fail; b=qBNf9HD8ZJFOMEWHuM6TgviKAf+n0UmsLzSQHDPj/kOo5v5ispPC/aH1CNoovlksaQUklsu7bCreLNRJYZQ3Cs9CLqJDfWMvp2lIAUix5+c4fE3srbDuvblQtzAQ20Qul73AA66kicRB4ROth3i7P6BdFlIwkzttxHsROR5Xjuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684512; c=relaxed/simple;
	bh=7kE109q0oCSF7orZ0/+etEiKRF2xyHuMAMrIfpvsVnY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zib5Y4PsHAxdrAmAO/G1ehdNszfEclfJ0+CTJYuiPU/6qMA7+FsvCF+6aZNjkAn5GfDgCMd2k8CoQ0p/o88XWB925talVF9a+yGf+Zf5DdMZZdcBy2EWFM+HZPQFnJOID794cnqWifd8pJJ4A6ruDe5kgUWq46kFb3uKhujNyVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=oteuF6Ue; arc=fail smtp.client-ip=205.220.184.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247495.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFEpvmV003841;
	Fri, 15 Nov 2024 14:58:08 GMT
Received: from pnzpr01cu001.outbound.protection.outlook.com (mail-centralindiaazlp17011024.outbound.protection.outlook.com [40.93.132.24])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 42uwr1sv90-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 14:58:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdWz8WfHVCG0LBDcqURr+sYGZ4o02+rYBmKBZJywMvJb4Vhva9e5XILdiGUk0+pPkjJ3PfMODaP/tGSKdosGGxdj4WJIgGa5vGUENJ70S3y/rnR0ucx2bz6xZpodeJ+zVEtX2MC2w3OBtPUTjDakbXupRkqtigEIC+taxUQ6QiXzlyXEzHXv6OC+5GaSlH0XCkT8TJh82zSxTt1/xwdJv5WhUK/uozhq1jJNvgQU4lordLLT4Rjh5XMmuqOb5Hac3Xe5iZ5dYU2QEUFJYORM/XM92074/QCzHtNrsI0PuzcNzIzFQbS0u9byY3Nu+3qkM+w/dDkf1anfhj8O1YTXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kE109q0oCSF7orZ0/+etEiKRF2xyHuMAMrIfpvsVnY=;
 b=gNMa1NndborDG+dAhcKXtMdh98+YR5RiAospNnmnxNV+PwVIGQba+HpcYuIf2YtOgjzkY970NOQefEvJoPDEJMASMidrOXkILJyignEnPieMKZdDvh0CViKdVjlhGMgX1JQ64J3ZIJi4Tdp3Mw4aDObHLb7Ei7QifjxZePxyb/cEQ6bwQdaGr/5mkxtiwRWhJLX5uJsP3lTMnfqfNIACKK/7y/iHyVYKbh1hwP3gS42CxDwP1fB+BDFVPEMhPawxhtgSaWxZq4M/w4bEMVKV92+D7eXD2zaEenW12Xm0Z0nhqc5GV1AynmZw9EHlfOrN6dJ9nR0aUuAg7Hx1tnHXAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kE109q0oCSF7orZ0/+etEiKRF2xyHuMAMrIfpvsVnY=;
 b=oteuF6UexIJeKpLPY/y3iMTBjwmVu9fSQnhUhCw9l2NJPL51eiF48/hzgLZAM87ePx6HhOLug7MUt1ON+mjmeJ+mOsvmXdo8dD212kGnvWHwCVat510aZj2G4zCCC0UzyAx6PMZLEqwAMthnqYrtADXE9sLRlhPB5OO5xEtt53Y=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by PN3PR01MB9551.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 14:58:02 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%3]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 14:58:02 +0000
From: Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        James Cowgill <james.cowgill@blaize.com>,
        Matt Redfearn <matthew.redfearn@blaize.com>,
        Neil Jones
	<neil.jones@blaize.com>,
        Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "soc@lists.linux.dev"
	<soc@lists.linux.dev>
Subject: [PATCH v5 2/6] dt-bindings: arm: blaize: Add Blaize BLZP1600 SoC
Thread-Topic: [PATCH v5 2/6] dt-bindings: arm: blaize: Add Blaize BLZP1600 SoC
Thread-Index: AQHbN27ExxtW+dVGF0yrst4+IanRfQ==
Date: Fri, 15 Nov 2024 14:58:02 +0000
Message-ID:
 <20241115-blaize-blzp1600_init_board_support-v5-2-c09094e63dc5@blaize.com>
References:
 <20241115-blaize-blzp1600_init_board_support-v5-0-c09094e63dc5@blaize.com>
In-Reply-To:
 <20241115-blaize-blzp1600_init_board_support-v5-0-c09094e63dc5@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB10184:EE_|PN3PR01MB9551:EE_
x-ms-office365-filtering-correlation-id: 0acaa306-12e7-4e0f-dafe-08dd0585e70d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Qk9Fd2Nla3h4cjhNQzh6MVlyUExLNXNtVjJSQmZEbFRlOStEOXU0MDNnNmt5?=
 =?utf-8?B?QkIvRDZwMVJBczFOdERPL1dWWk9RUDE2L0xocUkzNWFxcU82dVY3cWxZVzNQ?=
 =?utf-8?B?RURqZWl0RUVabk5qNnN1d0NKWmRxK3B5NzU1LytwVUpRMDdNVVlkblI4cE5l?=
 =?utf-8?B?TW9SaWEvRE5OVnJuNDR0R214STBIRHVDc0QxeVdFeDlwd1JDL2pKdFg5NjBn?=
 =?utf-8?B?ejBIUUluY3RqRjBWdTVSSXFPTTF4UnZoM0dVV0ttM20rYXozeHU1aGFQUEpJ?=
 =?utf-8?B?MGxqaUpWaHhZUjRKQlFvZmRrelVFSitvT3dlUHZqY2t5ajNMcTJScU5mZDVi?=
 =?utf-8?B?UnhaR1RGRDJuZnMxTGlqbmhUVVJieHptVnNtblhqZEM3UWY5TmdwQ3hvLytQ?=
 =?utf-8?B?MS9tQ0tJZE02ZkNhUHVtYVJzNVR0eGlZd3JnWGs3cUtGWmpDeHVMTllkL3JX?=
 =?utf-8?B?Sm9OVGtxOTdzYTBsZEkwaUlrUUd4NHN6Y21pa080N0JycmZmZVpwRjhMVDBa?=
 =?utf-8?B?c3FhVmNxenN6bmptenRuVkR2eDJaYlpxZnhmekVFR0hCeEd5WXlmTWJvSy9v?=
 =?utf-8?B?ZWgvcFVwbG90Y0NmWmZoRjZ5b0Fqd1kzN0FKalhRdVpXSGlPdjRVSVM5c01O?=
 =?utf-8?B?dTZIdzJjalJYZW1NcDZCb3Y4dHRYTEZOWWJzL3k0RVpaZktZUVVzUGpuaHBm?=
 =?utf-8?B?OG1tRzQyNkFqUjNHc0l6ZExVeWs0RndHQnFIT1REa1Q4cDRpMG0zZGkzMjJM?=
 =?utf-8?B?WEEzdW9aQ0NkNnhrTUpZbGJSRll5N3Axc3JFMmhVd3VwUmxYTWNTMXJLa0or?=
 =?utf-8?B?TWRpdkZEZTlrTURtMDNYU2RFUDRNakEwTURRRUdLL05uelJuKytSS3k5NmQ2?=
 =?utf-8?B?bmtLYVFwUDdIL2xsLzY0OXphMlBsRWFwbm16SWhQODBtaVRjT0Jlend1RjMr?=
 =?utf-8?B?Rk8zUzhpMERtSVo5bGhrZkM1bVlOdVlkVUhyQkhWVytscit6aXVWUHhWdE1k?=
 =?utf-8?B?UjA2ZWxiR1hVVWhZbGFUTTFxZnlHNXhqeDI4VEdoM2JRaFRtK21KNVF3ak5E?=
 =?utf-8?B?elA5TU9CT1RiN1A4aFNYT0poRHZEMFFKNEVycnNXU29XMWVITDJRRFNxek1w?=
 =?utf-8?B?UHRWVkI5SDFqUXZXQ0VEdExNWW1VRmNmcjJsaFNHYWdRQlhiZVVuUzRERGxK?=
 =?utf-8?B?bkkza212dmNLd21ZZXNMRDNMdHQ2WCs1ME4yYkg5aUcxL1RJeEw0dFhOeno2?=
 =?utf-8?B?eWlZNkxIeGlSVHdWS1JDLzBZRC9zZnVFb0VHOG15aS91MXVBWTJwRnhFWkNC?=
 =?utf-8?B?YVRXS2RTV1VGMk1TWTRWZVpSNGNOMU5yUDhqcmU2VEU3MFpEYUx0elEzckdB?=
 =?utf-8?B?bXRqZWJLT0pscmhJNUpRWGQvbzF6MDhKNjJaWnZhT2R3Znp4N2ZTMWRacGpN?=
 =?utf-8?B?Z0NBbUhhcElSVzJBczBkT1dYbkNhMG16NHduQ2Q3UE0rWUZkQXVkOUdyN2Jr?=
 =?utf-8?B?MGtGT05uL0xFMnU4cHE2TjYzWGc2MWV0KzZhbjN3V052RjBLQ21VTkpHc2t4?=
 =?utf-8?B?YUtzMmRRdmNtLzJKY2ZpMlZEZEpUdDU0SmtzTSs0WkdGM0FqSEZmejRvZGlK?=
 =?utf-8?B?ZGdQZTZTbWtib2NQdzZHQ3F1d0l3ejRyUndiNmg3NHNCeTZpQ1VMVWp2ekNH?=
 =?utf-8?B?Z3FQS2dvV3J0S3JnODVVZ01EMHZEMEc5aWJXZWR6SVI3RTZzbGdBc2U5VXhD?=
 =?utf-8?B?UkJJcStHbGxwMDB5dDhQd2paNjJIVm1jWDE5bGoyTEE3K1cyOVBBYTNOaWww?=
 =?utf-8?B?dlZUQjRHLzBuYkI0YUZMelpVb2ppQmJKUHo4Sit4MzFHMFJpYmU5bkpxaGpj?=
 =?utf-8?Q?OvTVYn8A4GKU2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZDVHNU1ZNmlaRFNhakllTkFhTTBtNWtoTVFUUlhqVFFMZ1o5MVluOE96TE9E?=
 =?utf-8?B?M2l2VmJoZVB4VXowTmJ6R3hDVHRjbTVzdlhWYk5vNXMzRzFYdE52Rys0OFV0?=
 =?utf-8?B?RmR0L29Lc3FiMEtpcjc3NjMzTTZFVzY3K2RaL3V2YkZVbVZESU5PbmRlcWxl?=
 =?utf-8?B?R0gwK3ZSUklTbG1OdnVwZERCSWN0b1VNcEgyVTVKZmt2OXhLOVJTVGg4cXA2?=
 =?utf-8?B?QmRsT0ZUTXpNQW1qMHl2ZmlVVXQxTUl4WUFmUFptaFE1M3hlVk5GakJ6T0hJ?=
 =?utf-8?B?YkNsNm5zZ1JwS3ltdWpOMVA5UWIybmVjN1hrV3VFcDNpdENvV0JUMUxETHc3?=
 =?utf-8?B?bCt2K3lPZDRKcXBoMEJoTXAvVzk1YUxEUGpHeURUbWRRV3JUOUJaYmw5dE1n?=
 =?utf-8?B?NDZncWJlRlJDWFJ1MHFwTnNKS0FlNWlkZXhUaFJ5TWk5eTNtdEdwdUlPWVpj?=
 =?utf-8?B?UmJpL3dpK2ttTjFUTE0vVWdUZ09yVWRSbmV3eDJBY3dEcjh5SFAwVjluWjFz?=
 =?utf-8?B?M3N0V2c1T3hlakZTV1NzR2ttZEIwdUllVXBSLzgwc3NmOVJIVTRHcHBrdzlB?=
 =?utf-8?B?NnBBWFZ1Q0JlWGN1MXFibnpOeTNxdEM3TEQwVFc2SmozZzlsWmRWZllNUy8v?=
 =?utf-8?B?cmZJeVV1NHpqTWpnRlZQSDlIaE1DeTdyODNXUEM3ZUk5S2t4VXZFWTd5MkJs?=
 =?utf-8?B?dXpnRDVTYmhEN2hIbVBmTVpqWm12ckR6dkFHaVJaMURLSTFwZ3p1UDFNb2RW?=
 =?utf-8?B?OFAzdDk4cWhqYnhsN1RtZk5qSWpCR3lRQ25kWFNaMXRCSGoxWFNob3U2MGdj?=
 =?utf-8?B?YitqNWhpdHNwWGI2SmZLWWdoWEc1NU56ZVFaZ2Y5dFIranFjVFZIVEdGSnFV?=
 =?utf-8?B?Vi8wSmlGSUl6MHczck5OSkhKaVpzdjFSbEtVU1IvZFlsSkE2OEdqREZSUHd6?=
 =?utf-8?B?VDFTejhPRWJoeFVpeVc4VE5RSlY3USsvQnpVbFdKbnEzQ1BqYjYvdGlyS3Bk?=
 =?utf-8?B?YVpjZnhLVHpsdmJzaFo1eDZKQnJlUTVBODJGcFAvMXV2RXpaQm9KazRLUWZK?=
 =?utf-8?B?SXdLNHRManoyMjI1Q09YQ3k4SERIRlEzNzIzaWRGdDhXVVJCbWs2U0FlMTl4?=
 =?utf-8?B?ZmgwaS9hdUN0NDAzMnRZamttcmN3VnZOQkdwazVXM3dXR1hSdFd3SFJvOGpL?=
 =?utf-8?B?am9nSUVmMlJWV1NTY0lqdVhhaFkzT3BWdEE3OEdNRG41eVlLc2tvMXRsU0Jt?=
 =?utf-8?B?dTJwUDh2WVZVTk5idWNEUFBHN1RhZkRTeFoyNTNhK1E5T3FCc3RMZTZDclV4?=
 =?utf-8?B?VVdZdW9SL0tHTFRjVWd2WGFybXFCTXBGd3RSUUhJYkcwVHdtenBFZ3VZdHpN?=
 =?utf-8?B?RzhMN1BhVHVLL0FabCtwYkgrMlBRb0lLK0FyM2ZabG5xaFRTVzhiWEl6WGph?=
 =?utf-8?B?Nkw1MVdERVQrajJ5WXM1ckt2RXRmaFlqUGo5L1RRblZLZVozTVRaT2VueDhx?=
 =?utf-8?B?WFZQei9HYVdJTWhRR3phZExnK252ZzhkM1ptdWNac0dTMTZQUDMySERBQ1ow?=
 =?utf-8?B?MnlzT0svMkJzNlptNHFEUGxpU3QvSXVTS0xkT3dqRjUrZ3dCQ0FRNFUwdE52?=
 =?utf-8?B?UlQ5bDlyVDBBSmRGM2VVaDBCU2hXd3N1OEcxSFV1ZnU0SXR4VmlWbk5ucWcz?=
 =?utf-8?B?bXJTMXR2cnIwSm9IdU15YjJQOVRya21uNTlRUy83cjVjUjVFUHF4ZEN3UWo2?=
 =?utf-8?B?QkdYb2xBQUxocVBaRjdDeWtoaXVsVlA1NlJQS3ZTQkgwa1U4QndVZWJRbjNI?=
 =?utf-8?B?dnBxa3dIOTltMW5tYWJQb1hZaFcwWFMzVzArK3F3UjJ6N2VUQWFyeDI0TDho?=
 =?utf-8?B?Z0phbGdaMlhvdWtsQ05uNFE2NldMQWoyZUZEU2hDcEt2K012eUFyaFRNSWti?=
 =?utf-8?B?YzhvdnRkK2dlVG5FM1p3WTcwT1pQakFlM0Y5ck9Ka0FHNzZYcnhLeEFrblJR?=
 =?utf-8?B?SVJHeElnRFl1Qlp6VC8zMFNHM2FZNDIzMVdOYUlwWTYxdkc1MW1rOFgvY1Rz?=
 =?utf-8?B?Y1FzdCtaTTVKekozaUxuNWFmdDkyZnpHWDlUK0JlWVlqdTc0N1VBM04zOXIz?=
 =?utf-8?B?ait6TUQ3ZkxTUEd3OUNJZmNHeU82ZHZ0QjUvVGE1OStQMkJjN0tZL1U2YnZu?=
 =?utf-8?B?bmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9101046ECBF8E14DB4B05DF70E638F51@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0acaa306-12e7-4e0f-dafe-08dd0585e70d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 14:58:02.1460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s+DV72Grjs3rUcQwGTxXFIsN9NJTIJrtYMbmBe9wS2CY+DbdRZcpB6+Lx7hh6vxhx13MI/l5g5f8o1dW3ccixjoVkUWPyz6PROMK4cgfuqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB9551
X-Proofpoint-ORIG-GUID: y3dthl3tRMiXS_wes_0YP0E-Ku5dyQ4D
X-Proofpoint-GUID: y3dthl3tRMiXS_wes_0YP0E-Ku5dyQ4D
X-Authority-Analysis: v=2.4 cv=YMvNygGx c=1 sm=1 tr=0 ts=6737617f cx=c_pps a=RRW9qgVLUv3Tpt3ACdNssw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=4MthsM0t3ikA:10
 a=-5LYVjoNHPMA:10 a=gEfo2CItAAAA:8 a=SrsycIMJAAAA:8 a=lDLmA3gUkHkARDlSV1MA:9 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22 a=zapPnUM7SFj2ezx6rUw-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Reason: orgsafe

QWRkIGRldmljZSB0cmVlIGJpbmRpbmdzIGZvciB0aGUgQmxhaXplIEJMWlAxNjAwIENCMiBkZXZl
bG9wbWVudA0KYm9hcmQgKGNhcnJpZXIgYm9hcmQpLiBUaGlzIGJvYXJkIGludGVncmF0ZXMgYSBC
bGFpemUgQkxaUDE2MDANClNvTSAoU3lzdGVtIG9uIE1vZHVsZSkgd2hpY2ggaXMgYmFzZWQgb24g
dGhlIEJsYWl6ZSBCTFpQMTYwMCBTb0MuDQoNClRoZSBCbGFpemUgQkxaUDE2MDAgU29DIGludGVn
cmF0ZXMgYSBkdWFsIGNvcmUgQVJNIENvcnRleCBBNTMNCmNsdXN0ZXIgYW5kIGEgQmxhaXplIEdy
YXBoIFN0cmVhbWluZyBQcm9jZXNzb3IgZm9yIEFJIGFuZCBNTA0Kd29ya2xvYWRzLCBwbHVzIGEg
c3VpdGUgb2YgY29ubmVjdGl2aXR5IGFuZCBvdGhlciBwZXJpcGhlcmFscy4NCg0KUmV2aWV3ZWQt
Ynk6IE1hdHQgUmVkZmVhcm4gPG1hdHQucmVkZmVhcm5AYmxhaXplLmNvbT4NClNpZ25lZC1vZmYt
Ynk6IE5pa29sYW9zIFBhc2Fsb3Vrb3MgPG5pa29sYW9zLnBhc2Fsb3Vrb3NAYmxhaXplLmNvbT4N
Ci0tLQ0KIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYmxhaXplLnlhbWwg
fCA0MCArKysrKysrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA0MCBpbnNlcnRp
b25zKCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
YXJtL2JsYWl6ZS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9i
bGFpemUueWFtbA0KbmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAuLmFmMzllMjc1NjQwN2JhYWNlZTMwMzBmNjkwOWNmMmFh
N2RjNTc3NmMNCi0tLSAvZGV2L251bGwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9hcm0vYmxhaXplLnlhbWwNCkBAIC0wLDAgKzEsNDAgQEANCisjIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiAoR1BMLTIuMCBPUiBCU0QtMi1DbGF1c2UpDQorJVlBTUwgMS4yDQorLS0t
DQorJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9hcm0vYmxhaXplLnlhbWwjDQor
JHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQor
DQordGl0bGU6IEJsYWl6ZSBQbGF0Zm9ybXMNCisNCittYWludGFpbmVyczoNCisgIC0gSmFtZXMg
Q293Z2lsbCA8amFtZXMuY293Z2lsbEBibGFpemUuY29tPg0KKyAgLSBNYXR0IFJlZGZlYXJuIDxt
YXR0LnJlZGZlYXJuQGJsYWl6ZS5jb20+DQorICAtIE5laWwgSm9uZXMgPG5laWwuam9uZXNAYmxh
aXplLmNvbT4NCisgIC0gTmlrb2xhb3MgUGFzYWxvdWtvcyA8bmlrb2xhb3MucGFzYWxvdWtvc0Bi
bGFpemUuY29tPg0KKw0KK2Rlc2NyaXB0aW9uOiB8DQorICBCbGFpemUgUGxhdGZvcm1zIHVzaW5n
IFNvQ3MgZGVzaWduZWQgYnkgQmxhaXplIEluYy4NCisNCisgIFRoZSBwcm9kdWN0cyBiYXNlZCBv
biB0aGUgQkxaUDE2MDAgU29DOg0KKw0KKyAgLSBCTFpQMTYwMC1Tb006IFNvTSAoU3lzdGVtIG9u
IE1vZHVsZSkNCisgIC0gQkxaUDE2MDAtQ0IyOiBEZXZlbG9wbWVudCBib2FyZCBDQjIgYmFzZWQg
b24gQkxaUDE2MDAtU29NDQorDQorICBCTFpQMTYwMCBTb0MgaW50ZWdyYXRlcyBhIGR1YWwgY29y
ZSBBUk0gQ29ydGV4IEE1MyBjbHVzdGVyDQorICBhbmQgYSBCbGFpemUgR3JhcGggU3RyZWFtaW5n
IFByb2Nlc3NvciBmb3IgQUkgYW5kIE1MIHdvcmtsb2FkcywNCisgIHBsdXMgYSBzdWl0ZSBvZiBj
b25uZWN0aXZpdHkgYW5kIG90aGVyIHBlcmlwaGVyYWxzLg0KKw0KK3Byb3BlcnRpZXM6DQorICAk
bm9kZW5hbWU6DQorICAgIGNvbnN0OiAnLycNCisgIGNvbXBhdGlibGU6DQorICAgIG9uZU9mOg0K
KyAgICAgIC0gZGVzY3JpcHRpb246IEJsYWl6ZSBCTFpQMTYwMCBiYXNlZCBib2FyZHMNCisgICAg
ICAgIGl0ZW1zOg0KKyAgICAgICAgICAtIGVudW06DQorICAgICAgICAgICAgICAtIGJsYWl6ZSxi
bHpwMTYwMC1jYjINCisgICAgICAgICAgLSBjb25zdDogYmxhaXplLGJsenAxNjAwDQorDQorYWRk
aXRpb25hbFByb3BlcnRpZXM6IHRydWUNCisNCisuLi4NCg0KLS0gDQoyLjQzLjANCg0K

