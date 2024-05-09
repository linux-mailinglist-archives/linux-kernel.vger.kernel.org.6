Return-Path: <linux-kernel+bounces-174667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 876788C1273
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 18:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAACB1C21C4C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA70816F8FA;
	Thu,  9 May 2024 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="OIRTKpQO"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2111.outbound.protection.outlook.com [40.107.15.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2964383BD;
	Thu,  9 May 2024 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715271058; cv=fail; b=lOdoyqGoK/S5JF1T3hd2x7IhLItQ7nxqaIYzp+Bcd8uuW3UQTYBvgFYBgfeY0ZnYoA/uTI8i9TNAgHhCC4YQHbSnWnkeAWm6eXd4zxOGWVJ124/hHyJ9FBb3yxTa0ZwJVGfht2tZ7IQgM58zgBgSQ17udZ9B2FqZQm/J64j0/WA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715271058; c=relaxed/simple;
	bh=OScadtCOmV+A8jFNN9OpMh4ahJT/0nKeKHgAHjZ+9bw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a95xTpZMWmnxxZfWMNwwFyHmq/pK0kLvf5v/eZa8A4xQlbtc9T3LaM1mw7pD7gVciDqIMi1fVuAWCDWdIK8aIl6P7cR6tzqFJbRaBzyBWxsvVfwH9rc+t3KCkHV1KipQR7uB+OtSyMue02az5zyNiSREiK+rQLSpXvD1lmaS5g4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=OIRTKpQO; arc=fail smtp.client-ip=40.107.15.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGS/elwW/Bg+JANTRKTAI/3BDBy9OcsAkdOhSZxKsr0eRV3QGNb+nwDwhkG0yKo6mOfrEw/w5owhamSxnM06djT3ehj5Xs0Yd1ThvuTBX1Q4FEJ3sg22kQCAhSnP3VFoDk9O77L07i1FigMSmir4Kqc+RVJoGlGQAmHYCuuDmf7lZqIQB5K5yWsMzQW+IPtxQcrnpy2D0ieFi0oTkl9SLVTJpsmyftUFjXf9JUaQE7aKIC4c39bDrMU06F+QuPKUnpi1OfYOQjp86BJFo+XVs+1z2w8avA4FhHyzWUrRqCdqGatODALfltYmBCbCseWEyjJ0ao7i+jOP9ULpyjSZ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OScadtCOmV+A8jFNN9OpMh4ahJT/0nKeKHgAHjZ+9bw=;
 b=OYra6u4nIEWZTJiyMoY8F9EwBGzwhPrAF0w/KExbtQfPL2WEneVPiY0mSRZGSSz8RSYxV98XsBhlsR+9jkHV2TQ6QjmFu70Rf0GpUbkzH0BlJegFdis05mwP8uMmcN/kJefDpfZ12zc4heWWiOjO+QSQkgDe77dpwKOpaTS+TcuQMpegb5ifK6cOItw7n1laxHFjdfHQTvj30DivtnCDX+Lh87Vaw7BJ8IZ0R/ok3sGf1Re+q3HpkAd8PK/zyRHBSWNAWRmrCqlFNummqElabklWWn0T7YiZTFZPs6D7is+zXOwDpdhlet2KGfDW8yfIGM14NE5ws8jvSylG9n1P0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OScadtCOmV+A8jFNN9OpMh4ahJT/0nKeKHgAHjZ+9bw=;
 b=OIRTKpQOZP1vuP91t77Wf6IyM393fsKeuPwgYm40LVI4E+uasbzn4D2B1usuGMKdL2jFbYZ+0WWubt+D0J5/lx3fq5yhTrqqnxs2cdg0xLwuFWpodSw9M2Zx63aM5zQhjB8VtWM9H8N9s5cEpZo/eKVI6Gf0kL5verHJ88hvHZU=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB8312.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Thu, 9 May
 2024 16:10:53 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7544.045; Thu, 9 May 2024
 16:10:53 +0000
From: Josua Mayer <josua@solid-run.com>
To: Conor Dooley <conor@kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Gregory Clement
	<gregory.clement@bootlin.com>, Sebastian Hesselbarth
	<sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, Yazan Shhady
	<yazan.shhady@solid-run.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 2/4] dt-bindings: arm64: marvell: add solidrun cn9132
 CEX-7 evaluation board
Thread-Topic: [PATCH v5 2/4] dt-bindings: arm64: marvell: add solidrun cn9132
 CEX-7 evaluation board
Thread-Index: AQHaof4bfE9Ueli+tk+h7rTggD3oW7GOuREAgABW2ICAAAMJgA==
Date: Thu, 9 May 2024 16:10:53 +0000
Message-ID: <91e87a18-9b94-4c5e-9930-80bd72646413@solid-run.com>
References: <20240509-cn9130-som-v5-0-95493eb5c79d@solid-run.com>
 <20240509-cn9130-som-v5-2-95493eb5c79d@solid-run.com>
 <5da207e2-1579-4056-9e3f-c25f5b14e225@solid-run.com>
 <20240509-recycler-flask-0b3b7e2802f9@spud>
In-Reply-To: <20240509-recycler-flask-0b3b7e2802f9@spud>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|AS8PR04MB8312:EE_
x-ms-office365-filtering-correlation-id: 9ca2f6b6-1376-441e-b24e-08dc70429a0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|366007|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?dWN4T2MrR2duTXN0L3lyK1QzNVZ2L0VSMEdlN3JrSGNPN3VQVnlkVzJlYzVj?=
 =?utf-8?B?Y05YRlAzKzMvMlY3bi9SOTdhcTBSNm9pLzluZjcreUZ2Vk9EUHcya3plSi84?=
 =?utf-8?B?NzVtMFR6UytRUlBiSzVlMGpOMTJPSjRlanoyNklReTZWVFNmRHplVTRFd1g4?=
 =?utf-8?B?VjZIUFJxVW1JQmNkTExpUXVpNTh0LzQ0UE9oc05RcDZ3RU5iQTBtWUJvMEFG?=
 =?utf-8?B?b3pFUnRMSlBLV21xVllSM2R2RW1LNStyVlBKckNHK2RlVzNNZzVKWmo3cVB5?=
 =?utf-8?B?ZmxuOG1XU0VmVGJ6V2NLL0g1aDNqN1FNY3B0ZG0xd052Z25jN3AwcWQ2WlRo?=
 =?utf-8?B?eTVEc3Fra0FMdXJMQlpQR0FQMnp4c1QxbUptZkpQODlCNEhvWXRVQTNkNDR2?=
 =?utf-8?B?V2lpQVNSRy9HeVl2S2VYOERWUHU1aVMwOXhkdWRvQW1zcXZZQjZCd2xiQVNt?=
 =?utf-8?B?ekllN3R4VDNhV3ZlekhzOUdLcGhzTTBVMElDVTdHUW9iQzZacmFNVFRkZTls?=
 =?utf-8?B?NGduR2VmclVLaU5DWWJRWDlyMEU1dyt0dFdWZG9sWEtpVTl5cGV3ZllDN1Uz?=
 =?utf-8?B?eDFOVG1FQWNVcnVFVFF0OWlrSGU1T1FQQjhINmpJck5VMkF2OTFyaGp2VHVH?=
 =?utf-8?B?eEtXanVtWnRUSkZIejdtTHQxaUdqUGN1c2lSTzF1VlRXUjFRVEcxQnA3WFVU?=
 =?utf-8?B?WEJ3V1dKbHRyR2NIM0dQL0wrMjFjQ2hEeC9xQ0lpMC9XbnJzTURrMmh2ZExn?=
 =?utf-8?B?NXRyRFlnWHRpWDU2a0l0WHdwRXY1eTNPdFRpN3BUUEJyRURZMG81MTBZWGx2?=
 =?utf-8?B?VTlzdnJuaFJ1U05tMTM5RGN0OEs3dTk1ckxhOHA3bk1Ob0hLVGwzZjJTSzNk?=
 =?utf-8?B?dkVuVzBkNmhkMDNPdm9JWDRpZEh1cG5NWUFFd2lXZkdhTWJkS21TR1R4bnB3?=
 =?utf-8?B?Wk9ONVZrTEpLaHZrN0htM04vbzlzNDc3Z3RYL0pVN21ZMXNTR1pnZC9OaldM?=
 =?utf-8?B?dDRHSkNiNmx2TDl2UHF3Y09sNFliRkxEUi9mYUROL0ZRWlNrZjNDM1ZvdmV2?=
 =?utf-8?B?NE9CQ3dnbDhYUmhZT1RuTGFaSDV3R2JZK1IxZmJ0bkhmNW81cU5Oek5sOXVr?=
 =?utf-8?B?TWdRQm1MeDZaR2NJUk9mZmZ6a1JVUDZ6SGVzbTlNdVJEWE9tK1BYMDM1OGtt?=
 =?utf-8?B?TWxNdWp2dkdZMTAzc0tXcDB4ekFnMjZrTko1eGlUbWJ5dVZrNVJQS1lxWmtv?=
 =?utf-8?B?SWhIdndZZ1YyRHlnYzVvcm02U0JWc1ljV1dKV09XcDlCRjhJMmRKZHZ0R3Fv?=
 =?utf-8?B?RjMvcjlBb2lyWmx2emY5MnFuY1FIVVlOYVZrd2VEOEYyQVpwSStQbnFqRXNT?=
 =?utf-8?B?Y2FoS1JVUnJZVWNsaGhzMWpWa2U2NmxYNGNwNVBNUSt4Ujk0SGFlakNMZWRS?=
 =?utf-8?B?NkF4RFFsVkJTSmxoMllzZzJieGNtdnRMT1ZCNzNCSzIxeWtBU0gwbFM3Vzlh?=
 =?utf-8?B?THZIV2x6UzVSSm5rVitTV0pMb1YvNUlCbGdINlplTDNveTliZDkrVTZTT2Fk?=
 =?utf-8?B?VUh1Y0FkYjV1NzZGRVBsNkdGOVZ6OGx3UGhHeXRPWS9GZUplSmRYemViK1lx?=
 =?utf-8?B?MDBnM1g2UGN1WUlkMnUzU1A3UjhFTDFnRzVRcW5OMWR2YUh0VGJMUGdoUWlP?=
 =?utf-8?B?L1FWby8zcDdjUDI4N3NJTHpqWkFGTDltS1lpY1Zva0xZcm9lL3l1MnpSVUFy?=
 =?utf-8?B?ZjQwamoxQmJpREgyYlhLRVBGZU8rR0VjT242Wmo0ZlllQm90WVhVSmVQNEh2?=
 =?utf-8?B?ZllVY2hPS3RpUnJoaTV3dz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WVRQalpoTmF3amtzY2pNQ2lxVVJScjNSdlNhTVlpdXpwcURCUGdjWVBHVjBw?=
 =?utf-8?B?eVBsUE9kYzNyTXFxS0hnR0hwS3JLNW5MUmFaVU1vdjNoYUdVRlBWNGdpaGM3?=
 =?utf-8?B?WUYrNENSWWQyYzR5SFU5eWU5VzdmWW1UYkF2dHpvbW9xYStVamllK1hwbVQv?=
 =?utf-8?B?cjBpL2hLVmQyNmZ3SWNiQUd4R2x4aTJkdUEwRHFWYTMweVVQT2RqMW5wS0tj?=
 =?utf-8?B?NXIwblZGTCtOaEFFYTd6a0RlU1d0SXdsTnVWQUdQSDluZ3hON01kT1ByQlp2?=
 =?utf-8?B?TnM0S3B0bGFEelNQQXNzMUhhLy8vK3Z5eXprdjJFM0owd0s0aFZGL3UrV0Mw?=
 =?utf-8?B?TTRwTnQzT0JxbG5VdmxiaHZkeW9XSlBodjhxWEE5V0VUOGtwS3NLQnBzWTZz?=
 =?utf-8?B?QUdVZ1lLN3UvZEZ5M29seTRrVWxtNlZQTEEwYk1VaEc3RThFcXhjalRXZnd2?=
 =?utf-8?B?Qnh2b3NxamliV1psMFM4bk5DYVNoQU9zYzlDOTQwazI1VnNrS3JtSktMcHo4?=
 =?utf-8?B?UytJYVNiRWg2aGZjOW9vUDVMeXhxM2FpYnIvT002Y1hWejZhZzhxNkczRm1S?=
 =?utf-8?B?a1B3Rm9jRzBScXhONW5LK09uQ2lnZ054aWZPbklXL2JVU24yQ2JEM3BHbnVZ?=
 =?utf-8?B?Y0ZDODNHWUc1eWhoUmFPU05PNmw3ZEs3aUVPcm4zSXpLZGNqVWFYQzVpLzRE?=
 =?utf-8?B?UXIxWDkxWkprRVVrZ29zSG8rZVZVTzFiZjBOSHhVV042VCtOYW5VVXVqSmdZ?=
 =?utf-8?B?RnJOaTNLV0hBYTF4SHArVjRHWnc1QmJua0pKOE9kTW13YTNwUnovMXI4bDRQ?=
 =?utf-8?B?Ymp3UEV4eU1Gb2RNcEU4YTl1NGpaQVJDRDhaNldnOXhiVHNJbm5ZUjI4UXFh?=
 =?utf-8?B?Mnpya2d1N2tYRENGeGx0ODFabWMwaWU5UkVoTCtYYmRGWVhHQUR1QXhoWUly?=
 =?utf-8?B?Yml6NGRRWDdtQ2V5eUF5eFhrNkw4QmxBcmUvSjB0Q2RaQ3JLZzJyK00yS21I?=
 =?utf-8?B?R08zTk9PUEhpOUJhNndoZ1lhRkdJZUdPNDVZcEloSkJFd2VEeFlnNWxOblVI?=
 =?utf-8?B?ZUhHSHBXa1FFNUtOMTR5MngwSTJ6bi9IZTEvMGNLTFE4eEttVGxqMTY2T2V2?=
 =?utf-8?B?OTdUMmovd2QxT3VnV3BHTExkZDFoVVlFQkxGVjVtMXo3LzFoMTdmb0JVWGdk?=
 =?utf-8?B?dVlYQUs4UnY3NGJtTXcyeHJDMlBYZGo3c3FYM0k3QW05UCtTeldNSW0xNFNF?=
 =?utf-8?B?cVlQaklJaldhdktwc0hNdHhCYm1qeUMrbG43OW0vNHpSaUxNZkE1emhWa25Z?=
 =?utf-8?B?ZEQyUUZkTEZDWlZySk5YSFFSVjVwMmlZdEtUODU2NVA2YnNZYmNlck5NV3FJ?=
 =?utf-8?B?cVFCTzlhbDdtUmZSRU1Hemd3SndXY0NMakc3aElZdXp3TWhYMk81Y05iTk9o?=
 =?utf-8?B?Ui8rYnBWbWlYTVFUeVNiYm9NRGxtUnRhTUdER1czNTdYY0luWFUxaTU2M3pt?=
 =?utf-8?B?LzFxTjUycUludTk3WVYrL2VRRHdUUktXeFV4cUtDOWtuTG9LNjRUcVdKMmNT?=
 =?utf-8?B?SVZNNTFLMFkvVVpBVHdJK3VsTGJSbnpYMm56RlFGbFRiTTMxU2dLNzhCVXNu?=
 =?utf-8?B?aklLVzN0ZnYyVmFJbEh1MEZIY3Q4Z21Ib1ZDL21SZzJWamNSckdwWU42UUsz?=
 =?utf-8?B?amRLRldKZDRwMk1jRGFCMGtySDZHTUp2YzZ5VXIrS2JIYXQ5bVVkYmNBc0hN?=
 =?utf-8?B?L3JNb0haSDJ3TmhFVTh5RWYvcDcwQXphKzNscGRxSk1QRzZibTZRSWhRV09h?=
 =?utf-8?B?YlRsUCtPNWVOTEVKUXJHc3VWSFhnUmtGSGNRVjlHZHNNR0QwQnFEWVhkb0Vv?=
 =?utf-8?B?d1l1SEVsSll4TTNhR0lmUk0yTVFJWUtRZXhJUkxQUng1bGh1ODI2S1JNakVZ?=
 =?utf-8?B?UHIvcmQzSGV3WFRkaGxUSVd6eStzT3BaWFRlVGhNalg1U0plWGJLZWJmU05V?=
 =?utf-8?B?bVhDL0g2TU9CQ0hINTNqTS9pNFYwM3NiL2FYcTQ5ZW12Z1FjNWhVeXBwVXRM?=
 =?utf-8?B?SktpMEovVGdXSUx4dnNqVlYveElIOXRZNmlFTCtMdFdNU1lIQ3Z4cFQwVnEw?=
 =?utf-8?Q?RhDeuSVZ/8hUO4VIW9kjum9eB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D485DBC59D95C43A041ADC54DEA57F1@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca2f6b6-1376-441e-b24e-08dc70429a0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 16:10:53.3890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 83o6BqNs7mnn8PdsLHAjbGXGdDRCDl4k6/HGooOgDE/k7F31dA1tcH2N0S6dTZ2k7avcwwbqwfTW1AX86IKxgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8312

QW0gMDkuMDUuMjQgdW0gMTg6MDAgc2NocmllYiBDb25vciBEb29sZXk6DQo+IE9uIFRodSwgTWF5
IDA5LCAyMDI0IGF0IDEwOjQ5OjEzQU0gKzAwMDAsIEpvc3VhIE1heWVyIHdyb3RlOg0KPj4gQW0g
MDkuMDUuMjQgdW0gMTI6NDYgc2NocmllYiBKb3N1YSBNYXllcjoNCj4+PiBBZGQgYmluZGluZ3Mg
Zm9yIHRoZSBTb2xpZFJ1biBDTjkxMzIgQ09NLUV4cHJlc3MgVHlwZSA3IGV2YWx1YXRpb24gYm9h
cmQuDQo+Pj4gVGhlIENFWCBpcyBiYXNlZCBvbiBDTjkxMzAgU29DIGFuZCBpbmNsdWRlcyB0d28g
c291dGhicmlkZ2VzLg0KPj4+DQo+Pj4gQmVjYXVzZSBDTjkxMzIgYW5kIDkxMzEgYXJlIGp1c3Qg
bmFtZXMgZm9yIGRpZmZlcmVudCBkZXNpZ25zIGFyb3VuZCB0aGUNCj4+PiBzYW1lIFNvQywgbm8g
c29jIGNvbXBhdGlibGVzIGJlc2lkZSBtYXJ2ZWxsLGNuOTEzMCBhcmUgbmVlZGVkLg0KPj4+DQo+
Pj4gU2lnbmVkLW9mZi1ieTogSm9zdWEgTWF5ZXIgPGpvc3VhQHNvbGlkLXJ1bi5jb20+DQo+Pj4g
QWNrZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJv
Lm9yZz4NCj4+PiBSZXZpZXdlZC1ieTogQW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPg0KPj4+
IC0tLQ0KPj4+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21hcnZlbGwv
YXJtYWRhLTdrLThrLnlhbWwgfCA4ICsrKysrKysrDQo+Pj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGlu
c2VydGlvbnMoKykNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvYXJtL21hcnZlbGwvYXJtYWRhLTdrLThrLnlhbWwgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21hcnZlbGwvYXJtYWRhLTdrLThrLnlhbWwNCj4+PiBp
bmRleCA3NGQ5MzVlYTI3OWMuLjUzOGQ5MWJlODg1NyAxMDA2NDQNCj4+PiAtLS0gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21hcnZlbGwvYXJtYWRhLTdrLThrLnlhbWwN
Cj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21hcnZlbGwv
YXJtYWRhLTdrLThrLnlhbWwNCj4+PiBAQCAtOTIsNCArOTIsMTIgQEAgcHJvcGVydGllczoNCj4+
PiAgICAgICAgICAgIC0gY29uc3Q6IHNvbGlkcnVuLGNuOTEzMC1zci1zb20NCj4+PiAgICAgICAg
ICAgIC0gY29uc3Q6IG1hcnZlbGwsY245MTMwDQo+Pj4gIA0KPj4+ICsgICAgICAtIGRlc2NyaXB0
aW9uOg0KPj4+ICsgICAgICAgICAgU29saWRSdW4gQ045MTMyIENPTS1FeHByZXNzIFR5cGUgNyBi
YXNlZCBzaW5nbGUtYm9hcmQgY29tcHV0ZXJzDQo+Pj4gKyAgICAgICAgaXRlbXM6DQo+Pj4gKyAg
ICAgICAgICAtIGVudW06DQo+Pj4gKyAgICAgICAgICAgICAgLSBzb2xpZHJ1bixjbjkxMzItY2xl
YXJmb2cNCj4+PiArICAgICAgICAgIC0gY29uc3Q6IHNvbGlkcnVuLGNuOTEzMi1zci1jZXg3DQo+
Pj4gKyAgICAgICAgICAtIGNvbnN0OiBtYXJ2ZWxsLGNuOTEzMA0KPj4+ICsNCj4+PiAgYWRkaXRp
b25hbFByb3BlcnRpZXM6IHRydWUNCj4+Pg0KPj4gSXQgYXBwZWFycyBJIHdpbGwgbm90IGJlIGFi
bGUgdG8gc3VibWl0IGFjdHVhbCBkZXZpY2UtdHJlZSBmb3IgdGhpcw0KPj4gYm9hcmQuIFRoZXJl
Zm9yZSB3aGVuIGFwcGx5aW5nIHRoaXMgcGF0Y2gtc2V0LCBpdCBtYXkgYmUgc2tpcHBlZC4NCj4+
DQo+PiBJIGFtIG5vdCBzdXJlIGFib3V0IHRoZSBwb2xpY3kgaW4gdGhpcyBjYXNlLA0KPj4gaWYg
aXQgaXMgYmV0dGVyIHRvIHBpY2sgb3Igc2tpcC4NCj4gV2hhdCBkbyB5b3UgbWVhbiBteSAibm90
IGJlIGFibGUgdG8iPyBEb2VzIHRoZSBkZXZpY2UgZXhpc3Q/IElmIGl0IGRvZXMNCj4gdGhlbiwg
SSBhdCBsZWFzdCwgaGF2ZSBubyBvYmplY3Rpb24gdG8gZG9jdW1lbnRpbmcgYSBjb21wYXRpYmxl
IGZvciBpdC4NClllcywgaXQgZXhpc3RzLCBhbmQgd2UgZG8gaGF2ZSBhIChsb3cgcXVhbGl0eSkg
ZHRzIGZvciBpdC4NCkkgbWF5IG5vdCBiZSBhYmxlIHRvIGRvIGl0IGluIHRpbWUgZm9yIGNsb3Np
bmcgb2YgbWVyZ2Ugd2luZG93Lg0KDQpJZiBpdCBjYW4gZ28gd2l0aCBhY3R1YWwgZHRzLCB0aGF0
J3MgZ3JlYXQhDQoNCg==

