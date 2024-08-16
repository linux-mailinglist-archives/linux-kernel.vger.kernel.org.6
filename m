Return-Path: <linux-kernel+bounces-288945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E91D8954080
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 06:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8E728A0EF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 04:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B09155306;
	Fri, 16 Aug 2024 04:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="irTlxR64"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2111.outbound.protection.outlook.com [40.107.255.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D7084E1E;
	Fri, 16 Aug 2024 04:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781236; cv=fail; b=YeVKCinS0DuOhWnI7Fs3XEWubKyPBu3We42k6DMDFHyQuiHH4oGX6/Frz/m9lWxrYu65+Zh0HP/onRntLxPZ0JfTFCYMmNx8tAKgTiptrZ1DMiwH3N5i1Dad7amgEv5fftZPdStJEDaLTMzg7/G319bR9mNow9nUj4w/9If5ai0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781236; c=relaxed/simple;
	bh=aChbpQ8KEnRF4a4yfXZr4N3NeJltMDjo7hzR5gVd72g=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cw1drtmGfV1HcxYjYt27hnCmCUd74EKIeC/71RTecetVIZbeF5fV5JL05sOE9N0lnDoA0NUurvfwA2rp0d7EquMGAq9uVhTZod7TsJggLmVwkrxYJMZSvJNaz3E6uAiab/AFDON+3nWrV4Cv3NE23h5UOqx1r0fFImQrW5Vxflo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=irTlxR64; arc=fail smtp.client-ip=40.107.255.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvtJqmU5eHbnBXnelpdhWJq72fHWSSBwFvVQiq1drCZQbB830ogb6V0OLljT0VM+kYRqSCaij18TVxf2cqr5ph3LT/tpTiOKIHTt1ZxdRdcDHIIEqGd9blaHFTi89efeQjMrgwNrgudRZnXULgkf6H0TS8/bBMhICeXbgdZV/iEPfU2yUTBT0AHSe294BERkweX/g2awiEOvilP9W/nmOEe9topAL7MAnPWcmW18iLsp8rONIyQUW+SkuDXQ/R2+cYUUbaDnKyBNLA4t+pX3DgTSpv7iIIXXRlC8Vi9KFFP0zevzAKOn4BsMMwU+YSysZbiYNFmhgmutwl54OJqBGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aChbpQ8KEnRF4a4yfXZr4N3NeJltMDjo7hzR5gVd72g=;
 b=bd10XMtuA5PXGN6P9x+Tzi/V3yLZSOJmVHwPn0mo65hKeO8jwxfhZ/oCRDdYADYgmt/7EUHVLHn2yDV0PtV9c4YLexXxQj4oG6BV9fYi6YdYpleImjY69IJN6lCDzCFZYjCXS7+nOdmUeTk3L+PXBlV1bEWT8ywmawojtK5BmeReDV1hjeoG3cNR2f6somQNRANsSGDwtA/rUOk4wCc4OCi1Birp2nCACEr7lET6JT1mRstj1Vo2+m3kY7jx87OrUdYuRUIoMT4tkni/CaHabxYk0WvOTvvDGPJlkhOdthW84swfsbhEqiK+7J6Rlk4W3umZTXKow2k5u8KemEiTfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aChbpQ8KEnRF4a4yfXZr4N3NeJltMDjo7hzR5gVd72g=;
 b=irTlxR64/TEDuw/R1UpUaTs6BEkKhtZhM8NyMzM7IHrEOl1MhA1R/42sAo21SOK9QSiwC49FcLQTb+BC3Ms8dsUR1bc7CH5S9KL+REAI/M7kQ11VQlIvFCC6E7JEQOLlPB2+2YAUxrifnF4NtrFpb4U1ZOBvxx3goabPlvLfoPlzL8+fqu3P2wFt/UtxwAFVbtnDIQrKMwNMLR6kjQ4dyiz8SzzflKzn98g0M9R+vlM5DHssWA2HiRSfMLFSfOb/ITE0PUsclbycemc6f7T85/dwoInlkH3FrgPxVtidPlom1383/F3gyhP2tSYuDW4IZXOP3ulDp2vhr82WKIbyvw==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by KL1PR0601MB5510.apcprd06.prod.outlook.com (2603:1096:820:ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 04:07:11 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%7]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 04:07:11 +0000
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
	<joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "lee@kernel.org" <lee@kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net"
	<olof@lixom.net>, "soc@kernel.org" <soc@kernel.org>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"quic_bjorande@quicinc.com" <quic_bjorande@quicinc.com>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>,
	"dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "neil.armstrong@linaro.org"
	<neil.armstrong@linaro.org>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "nfraprado@collabora.com"
	<nfraprado@collabora.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v1 09/10] arm64: dts: aspeed: Add initial AST2700 EVB
 device tree
Thread-Topic: [PATCH v1 09/10] arm64: dts: aspeed: Add initial AST2700 EVB
 device tree
Thread-Index: AQHa30uPDJPGKhP2w02fD585UynZDLII3BKAgCBsPaA=
Date: Fri, 16 Aug 2024 04:07:11 +0000
Message-ID:
 <PSAPR06MB4949C5E5ED62614F16244F3289812@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <20240726110355.2181563-10-kevin_chen@aspeedtech.com>
 <79d13e65-ca4a-461f-9888-9664e204f2ed@kernel.org>
In-Reply-To: <79d13e65-ca4a-461f-9888-9664e204f2ed@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|KL1PR0601MB5510:EE_
x-ms-office365-filtering-correlation-id: f6631356-d425-43e9-64be-08dcbda8e757
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?L3JpZ244R0MvZWQvSS9RY0t4OTFMbW1wSGVoZmRPQkxFOERiaHVnd2RqSHBk?=
 =?utf-8?B?M0lpcU45ejk4Y1RhTkttRGhINmZ2eUJXVjY0b0Q2Z2hEVHV3VXlQdXVwYklZ?=
 =?utf-8?B?cUlzSFdZTmlURVlZaG5KQk5XQlBEcTJVbm1VMEhsbm9lTXgvOU1EU1FXaFhj?=
 =?utf-8?B?b1FoNEl4QjlEcGcvSDJWNmNxOVZkNFRjNTU3Tzh6NEgxTEZ0WEwvSmpLRDh3?=
 =?utf-8?B?aFIyZi93YzB1SFROZU5zTXBjajQzSHUyTzFObXZqTTJSNUlhQmlQc1hOTCtz?=
 =?utf-8?B?VUNTNEhPdHBoN1d2d05ZaUxtOEllL1grR0hPSitDZEhUWWNUd0krZjh2QnFF?=
 =?utf-8?B?cGNNR3pLOFcvSTVaUlJNMmdyYzhRMHVlcG5vby9CM1FDbmVKNXloQjlnRDN0?=
 =?utf-8?B?c3U4dlIwVCtZV1ZZNDl0ZkRRY1pQMXpxdFA3ampzRjE5T3ovRkFWUTJsTkNi?=
 =?utf-8?B?ZFNxd2hDeXIyb2ZZS1RuclkyMGJMOFFqaWtwY05qWjVuY2RpVVl1NTBncGw5?=
 =?utf-8?B?cUVmZkJNbXFlblhLbkhsMjFMck1CL0tGd0E1aEY0QmpEakpSRW9MTmtmbGdQ?=
 =?utf-8?B?ZHB2RnFoOEszbTlrWlRFbmM3Qllod0JWdzlkMUdyeDBPeUpReFhsbTBNT0V2?=
 =?utf-8?B?Zkc1Yis4elBGZnlERVVHWmNrN2czRDhYZ05ld0UxQU1sUDB2TlBsNFBkWjk1?=
 =?utf-8?B?V1RWZmJva2IzN2NRZVRlTTVlN3FSbnliNENtcTNZT0w2clRFdDZ3eENNaFF3?=
 =?utf-8?B?dlVNWWl0S29LYXBlcFJjdUVaZlpYR0xtQUlEQzU4UGd0ZnVkWmFTOHhtcHpK?=
 =?utf-8?B?OEcydWVvQlE2RkJwdldaUSs1VDNPZU0vMy9OaVphK2F0a0FveEdFVndOUnND?=
 =?utf-8?B?OWFkRSt5NllXQitZQm53cEx5a2NCejdtaFZQdXdyUmhHTnlOM2NEdWJkQW1I?=
 =?utf-8?B?ZExKMmpHb3pTSHVhNzVSTlNxWnlnSE8zd3VVRTNVZzc2MnZTdGUvMTlya1Yw?=
 =?utf-8?B?V3dsaDJZL0t6OUtXanRqTHBYU1FOQlBjeEVENWRtdk1FT3Z3dXV3ZENMcWNw?=
 =?utf-8?B?Qlh4V3FnQW16SC9lVi9DcUJ1dldXdSs3UzhzdlBkUzZzOGpkWXlqREVsMmdh?=
 =?utf-8?B?YVpZbHNFaUkxSTlvY1Z4dDFyL1kxcHF3NHByTnQ5SG5nWU5zSENpbW1GVDhO?=
 =?utf-8?B?emlSUDcxaFIrL0Yrai9XeTlLeCtsUkFWanhOOW8yd3orV3VJY25yQlZ5SWE5?=
 =?utf-8?B?WmRLc29PQmJYQnZtaXovaXdlTjRtTDM1QjVjblUyZitVdFBjRVVmUVluQjFF?=
 =?utf-8?B?ZUxLQXZIcGozMmlVTlJKWVJobTVITSs3MkdESmNrZzJUQWJ5NkdSK1ZKMnJ4?=
 =?utf-8?B?TjBjb1M3UklYcDJRanBYYm42bVVVajRtNWl5aVAzVDVuWmU1MnNIRnArOEVU?=
 =?utf-8?B?VTFJZExMS1l4YVNJV3Z1cE1KZGdaVzdqYVVWcG43Ny9iV05La1I3MFN1b2FW?=
 =?utf-8?B?R3cyS2V5VWRHY09tczljRTJtRmZqRTZkaXdQYWQrU0hkRmlpQm1KMFRtS2JQ?=
 =?utf-8?B?amRIM0g4Y3RXNlh2b2V0YlMvODV0MUthdnFwaWt5REZyamltUmZ6WjRJalVy?=
 =?utf-8?B?S3ZZRy9yZGFVRmh2NDNUcmFnem81ZTF0elkrUURqMUp2TFJiOFl2WTFzYWhs?=
 =?utf-8?B?TDJQSjBGYW1iTFd3UTYzemFxeFdwbVZjaE1Mai9FSEdVNy9Dc0U2V2c0LzNQ?=
 =?utf-8?B?eDB6RU55SUVWdFBEUEttNHlFNjViSFF0Vm8vbTNEUEgrUlhVMmJRMzNxUFZP?=
 =?utf-8?B?bmUvNDJobXlGbTlxQnB6c0d3QnoxeUp6T2c3MEhLRVE3T3BoUXR1SnlHdUZw?=
 =?utf-8?B?UmV0QWRNRisyRHlidTNMRk9TeXhFZ3dVRW1QUzM2YXdEMkdtWnpWV05KSUJs?=
 =?utf-8?Q?dZxT2Uy0FhU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R1VYOUk1eVp0UUJSaTRWMkMrUVpIVEM2ZmJLcURZVlVMUjF2NXc2eFhTY1Fi?=
 =?utf-8?B?V0JidkUrNnBzQ0J3ZUlobEVxTzlXeG1KQUJPZ0tlN1A5Rzd2VzYzUHdMY2kx?=
 =?utf-8?B?eVk0aUtDVkwyYjhhUk5rL3ROU0c4TWxkWFE1MWIrWE9YWnN2cjJ1SmdRMk9a?=
 =?utf-8?B?Mis5d2lubzNBSWgzdzdlbk1IaHRVNk50T0kzYkJpeGhFd2VmczRYRVA0NVE3?=
 =?utf-8?B?cmdhSG1vV08yWkp2bi96cHI0Ymh5QUwvM2lSQmhZNHIyc0hMV2tXSEV2Zzcy?=
 =?utf-8?B?UDk1RHV5aXpMSFc1bHU2NlNSUWtVdnd6U25HTGE4WXlCOUx0WmhjTTlDcHU3?=
 =?utf-8?B?TmV4eGZXSnA2RGVQNGhZZXVGVkI5V0VtVXlVdXBJWXNBVzc4SkZUd1o2WHJY?=
 =?utf-8?B?Sllad1ZGcGYxWGw4aWxFM3IxVU5ac09OSVpLb0FXWW40Q1ErOS9CVmI3T3F1?=
 =?utf-8?B?NjhiVjZNVlNGTkQ2cEJIOVVieUV3aTJQdWVtNHEzYnZXNi9nbk00cUR2Yk53?=
 =?utf-8?B?akpWWWt2bjBrV2tUdnZscFEzc0NPS2xaWEhnK0ZVTjFMbE1kYUJ5clZMV05v?=
 =?utf-8?B?WHZpRy9iWG1ab0o0TmZ6NGlBak1PRTYvYi9pZVNtaWhmbit1bDNBQURLTVE2?=
 =?utf-8?B?NnhxbGlYYWVTeHo3YURyUWYzMVJiUHN5WUJ0U0d1RktyN3hvNnNGS3dIbnp4?=
 =?utf-8?B?V3c2UWNVdzdDSHNJZkU1dlhBb0JDRFNaV1NyYzczeUluMktkT3RQRlpCbzNC?=
 =?utf-8?B?N1FoOTg1UEJnVWUrblpLTU9wUDQwMTV6dEwxTHdqZ3djSmlGTmVNeVFkUzhj?=
 =?utf-8?B?STlqdTFGZUFGbjVNZGwxcDVlODE1blk2aTdIdXkvSG1YV1BhZGpEdEhGcXZH?=
 =?utf-8?B?M3lQZmg0akN1Nm5aeVV6aTRUM1dTcFJhWGx5OGY0clhpQ1FueklxNTFHQWlU?=
 =?utf-8?B?aDNUd1BLVGNJVnF1d2VMdDBiaHZiNVBpd2Zja3dEY25XQ2MyOUlsS2M5cXZh?=
 =?utf-8?B?eDlxNHNGNUVSYmxrY2FZNGp0OXdNN2FUL3hKS0ZyaWtTbzF4SmluVXlpS3do?=
 =?utf-8?B?bm02bmRqclV2OHc1akpmZElSQUU3TFBxZW55WEZDL29Odkk0L29QK1psdUcx?=
 =?utf-8?B?ai9JdE5ETnF1ZlBYbFpLUWFGam1GL1ZVNGpRLzlWWGZPSHFCRXVwOW5iOXY5?=
 =?utf-8?B?Yk5pZGlQZThZWEorTko4ZGFYSEV5cURrVE1nci9GbUllekJoK3h1LzhnOSsv?=
 =?utf-8?B?UC94bGtoRXlwV09QZm9KYjJ5U00rWFdtekkwdDJCU2pKeTBZY0xPWTNZVk1u?=
 =?utf-8?B?ZjJENWJOeHpWbnZpd3A4a2x5NHgzOGJlWUZ1MHpJeXFibHNHSTlBaHZaMmJB?=
 =?utf-8?B?b29vOURKa1h3ektWVkNteWJpOEtMQjJVc25wbGJoaHA5NmNNWmdBNUd1c2RD?=
 =?utf-8?B?ZDVkZ3ZFeEN5NFRjVTR6ay9CSnpCc1hCS2xyOUYxMkg4alZpQmVJZEZWT1U5?=
 =?utf-8?B?RUNDY1hwQWpGYnZVWENPUkFWWk14dUtNblNTTGZLUzB1Uk0wcW5pYW1DWkRP?=
 =?utf-8?B?OUI0TnJlNEhlRHdzeTN3Smd5WUh1Y3BIU0F5K0ExbFBzcFdscWMzVzRWU085?=
 =?utf-8?B?cS9TWWFFYWpXbVpmV05VVUJoUlZIOEpZWEI1RWlDVUFjOURCdFdzYUdsU1Nk?=
 =?utf-8?B?MFpLazlrTXA0Mm1ZUytBU3R1b0tiNkdUL2pFSkh6L2xwd0FhYVUzeE80dk5n?=
 =?utf-8?B?S08yckFBeGt1ZW15WDA3SFc0MVZEd0ZNT0NPMkEwazJZU1J2d2FreFQ5bmFk?=
 =?utf-8?B?WFlRNTBQTE91c0xRbm1GUEwyK2xmN01lby9nbTdYdE1vM2szbWtqcExwY2p6?=
 =?utf-8?B?NTJ3cnRUWVJ5emU5L3lsb0lEeVRoTFFrL3hvTHRaeFllUllyVWYrNWY1ZmMz?=
 =?utf-8?B?MDR4VzFoWUxYUnVxZkhNS0tFa09UdlFOeHpiNlBheTFLOGpZTWhUZkV1YVpL?=
 =?utf-8?B?dk0xYU5TMC9xaUxwOWxURitzOHN0ZE5zYjhrWThWcHViUFpkL1NsVWZyTURx?=
 =?utf-8?B?TGtPMnVOSGhJVUFtSEoydE1TalJQaURwcy9sVzd5QmhNN0crMmVQeE9tYTEy?=
 =?utf-8?Q?UybzrQV5toYT+kp7F/Y26M2Tb?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f6631356-d425-43e9-64be-08dcbda8e757
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 04:07:11.2582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MhhEJ/moiRY44/UUNYDOefkbrly0g0xTupaiPXKJolZP3qF/m0hNqjgaClwJ42U+XKb7jVrxoaBllXU093HSYV67P7IIVuxCh6YKFc24x5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5510

SGkgS3J6aywNCg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2FzcGVlZC9NYWtl
ZmlsZSAgICAgICAgfCAgNCArKw0KPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2FzcGVlZC9hc3Qy
NzAwLWV2Yi5kdHMgfCA1MA0KPiArKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMg
Y2hhbmdlZCwgNTQgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9h
cm02NC9ib290L2R0cy9hc3BlZWQvTWFrZWZpbGUNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFy
Y2gvYXJtNjQvYm9vdC9kdHMvYXNwZWVkL2FzdDI3MDAtZXZiLmR0cw0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvYXNwZWVkL01ha2VmaWxlDQo+IGIvYXJjaC9hcm02
NC9ib290L2R0cy9hc3BlZWQvTWFrZWZpbGUNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+
IGluZGV4IDAwMDAwMDAwMDAwMC4uZmZlN2UxNTAxN2NjDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+
ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvYXNwZWVkL01ha2VmaWxlDQo+ID4gQEAgLTAsMCAr
MSw0IEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gPiArDQo+
ID4gK2R0Yi0kKENPTkZJR19BUkNIX0FTUEVFRCkgKz0gXA0KPiA+ICsgICBhc3QyNzAwLWV2Yi5k
dGINCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9hc3BlZWQvYXN0MjcwMC1l
dmIuZHRzDQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9hc3BlZWQvYXN0MjcwMC1ldmIuZHRzDQo+
ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjE4N2M0NThl
NTY2Yg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2Fz
cGVlZC9hc3QyNzAwLWV2Yi5kdHMNCj4gPiBAQCAtMCwwICsxLDUwIEBADQo+ID4gKy8vIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyDQo+ID4gKw0KPiA+ICsvZHRzLXYx
LzsNCj4gPiArDQo+ID4gKyNpbmNsdWRlICJhc3BlZWQtZzcuZHRzaSINCj4gPiArI2luY2x1ZGUg
PGR0LWJpbmRpbmdzL2dwaW8vYXNwZWVkLWdwaW8uaD4NCj4gPiArDQo+ID4gKy8gew0KPiA+ICsg
ICBtb2RlbCA9ICJBU1QyNzAwQTEtRVZCIjsNCj4gPiArICAgY29tcGF0aWJsZSA9ICJhc3BlZWQs
YXN0MjcwMGExLWV2YiIsICJhc3BlZWQsYXN0MjcwMCI7DQo+DQo+IFlvdSBoYXZlIG5ldmVyIHRl
c3RlZCB0aGlzLg0KPg0KPiBTb3JyeSwgdGVzdCB5b3VyIERUUyBmaXJzdC4NCkFncmVlLiBJIHdp
bGwgdGVzdCBteSBkdHMgYnkgbWFrZSBkdGJzX2NoZWNrIFc9MQ0KDQo+DQo+ID4gKw0KPiA+ICsg
ICBjaG9zZW4gew0KPiA+ICsgICAgICAgICAgIGJvb3RhcmdzID0gImNvbnNvbGU9dHR5UzEyLDEx
NTIwMG44IjsNCj4NCj4gRHJvcC4NCkFncmVlLg0KDQo+DQo+ID4gKyAgICAgICAgICAgc3Rkb3V0
LXBhdGggPSAmdWFydDEyOw0KPiA+ICsgICB9Ow0KPiA+ICsNCj4gPiArICAgZmlybXdhcmUgew0K
PiA+ICsgICAgICAgICAgIG9wdGVlOiBvcHRlZSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICBj
b21wYXRpYmxlID0gImxpbmFybyxvcHRlZS10eiI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICBt
ZXRob2QgPSAic21jIjsNCj4gPiArICAgICAgICAgICB9Ow0KPiA+ICsgICB9Ow0KPiA+ICsNCj4g
PiArICAgbWVtb3J5QDQwMDAwMDAwMCB7DQo+ID4gKyAgICAgICAgICAgZGV2aWNlX3R5cGUgPSAi
bWVtb3J5IjsNCj4gPiArICAgICAgICAgICByZWcgPSA8MHg0IDB4MDAwMDAwMDAgMHgwIDB4NDAw
MDAwMDA+Ow0KPiA+ICsgICB9Ow0KPiA+ICsNCj4gPiArICAgcmVzZXJ2ZWQtbWVtb3J5IHsNCj4g
PiArICAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwyPjsNCj4gPiArICAgICAgICAgICAjc2l6
ZS1jZWxscyA9IDwyPjsNCj4gPiArICAgICAgICAgICByYW5nZXM7DQo+ID4gKw0KPiA+ICsgICAg
ICAgICAgIG1jdV9mdzogbWN1LWZpcm13YXJlQDQyZmUwMDAwMCB7DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICByZWcgPSA8MHg0IDB4MmZlMDAwMDAgMHgwIDB4MjAwMDAwPjsNCj4gPiArICAgICAg
ICAgICAgICAgICAgIG5vLW1hcDsNCj4gPiArICAgICAgICAgICB9Ow0KPiA+ICsNCj4gPiArICAg
ICAgICAgICBhdGY6IHRydXN0ZWQtZmlybXdhcmUtYUA0MzAwMDAwMDAgew0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgcmVnID0gPDB4NCAweDMwMDAwMDAwIDB4MCAweDgwMDAwPjsNCj4gPiArICAg
ICAgICAgICAgICAgICAgIG5vLW1hcDsNCj4gPiArICAgICAgICAgICB9Ow0KPiA+ICsNCj4gPiAr
ICAgICAgICAgICBvcHRlZV9jb3JlOiBvcHRlZV9jb3JlQDQzMDA4MDAwMCB7DQo+DQo+IFJlYWQg
RFRTIGNvZGluZyBzdHlsZS4NCkFncmVlLiBTaG91bGQgSSBjaGFuZ2UgdG8gb3B0ZWVfY29yZTog
b3B0ZWUtY29yZUA0MzAwODAwMDAgew0KDQo+DQo+ID4gKyAgICAgICAgICAgICAgICAgICByZWcg
PSA8MHg0IDB4MzAwODAwMDAgMHgwIDB4MTAwMDAwMD47DQo+ID4gKyAgICAgICAgICAgICAgICAg
ICBuby1tYXA7DQo+ID4gKyAgICAgICAgICAgfTsNCj4gPiArICAgfTsNCj4gPiArfTsNCj4gPiAr
DQo+DQo+IFJlbW92ZSBzdHJheSBibGFuayBsaW5lLg0KQWdyZWUuDQoNCj4NCj4gQmVzdCByZWdh
cmRzLA0KPiBLcnp5c3p0b2YNCg0KLS0NCkJlc3QgUmVnYXJkcywNCktldmluLkNoZW4NCioqKioq
KioqKioqKiogRW1haWwgQ29uZmlkZW50aWFsaXR5IE5vdGljZSAqKioqKioqKioqKioqKioqKioq
Kg0K5YWN6LKs6IGy5piOOg0K5pys5L+h5Lu2KOaIluWFtumZhOS7tinlj6/og73ljIXlkKvmqZ/l
r4bos4foqIrvvIzkuKblj5fms5Xlvovkv53orbfjgILlpoIg5Y+w56uv6Z2e5oyH5a6a5LmL5pS2
5Lu26ICF77yM6KuL5Lul6Zu75a2Q6YO15Lu26YCa55+l5pys6Zu75a2Q6YO15Lu25LmL55m86YCB
6ICFLCDkuKboq4vnq4vljbPliKrpmaTmnKzpm7vlrZDpg7Xku7blj4rlhbbpmYTku7blkozpirfm
r4DmiYDmnInopIfljbDku7bjgILorJ3orJ3mgqjnmoTlkIjkvZwhDQoNCkRJU0NMQUlNRVI6DQpU
aGlzIG1lc3NhZ2UgKGFuZCBhbnkgYXR0YWNobWVudHMpIG1heSBjb250YWluIGxlZ2FsbHkgcHJp
dmlsZWdlZCBhbmQvb3Igb3RoZXIgY29uZmlkZW50aWFsIGluZm9ybWF0aW9uLiBJZiB5b3UgaGF2
ZSByZWNlaXZlZCBpdCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHJlcGx5
IGUtbWFpbCBhbmQgaW1tZWRpYXRlbHkgZGVsZXRlIHRoZSBlLW1haWwgYW5kIGFueSBhdHRhY2ht
ZW50cyB3aXRob3V0IGNvcHlpbmcgb3IgZGlzY2xvc2luZyB0aGUgY29udGVudHMuIFRoYW5rIHlv
dS4NCg==

