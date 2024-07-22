Return-Path: <linux-kernel+bounces-259165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5321939211
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1469F1C21438
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E389A16EB75;
	Mon, 22 Jul 2024 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="qfcWgKGW"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021141.outbound.protection.outlook.com [52.101.70.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2197742A80;
	Mon, 22 Jul 2024 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721663387; cv=fail; b=WM50X/w/1AmEU5VdrrcLyuspkZgeZzOlD8vPne2gHK4w1VuNdL62rEH2HR2B1NJGSGepUp4khyOoIPRP9G/cGhMq5szwlrUTegBP8OO25ij8UAt5ZMqNEGBbOB4qBEc/7ft1egr9bml/M+c8Kx56Q8HQM52FhMU6pmCxk+9MAs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721663387; c=relaxed/simple;
	bh=qLpGiNeFB/ot0toOVlcLinlWBFJp1/7y9Zw/UsAUmzk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lav82kYLnmTzkzxKs37Po/DKpfceZHljAojmtp0SGFvATgQV9B6WfiTnW7e4M1whnoLYvJH72MX/WMNZJ79dwaM3gd1U+FAzfx4C5sgfjhFxB9+U1gHGNAXCaMT3C7Io4ea6yD/r+3NoGzuGW8axl+esWuJah1/xs9mFiKksAIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=qfcWgKGW; arc=fail smtp.client-ip=52.101.70.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6ErujQnhvamPeF8f4JHq3DWGxe5kf9E3W39wCTZNtXLsy67uXLmWzOmXZu8YTIffXSzdtgM2Ms8kOsPDec6Z0FRVP7aQRskZ3b+1J3Vvs2HJlqapWZJP5n4HS4Cb79QCZgAKcrbn3i6AlDo0bdbEhJ8XD6A6Wlet3VkogbJLRbZ2M4Iu85jbd1D7lB6fRTbVecI7tbUIY24NpMsE0jdMRidWEdM2CDXJ+Sps8KTmMqO77iuTZhnn2KBVMS9p7+LWeWHIocolSEDCb4PdSE3UynWaMmesMxH9l2i3xPcNtmXiW7/eomtmko31pXrL/AFdbn/0EWqVk9R29NVXmkF5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLpGiNeFB/ot0toOVlcLinlWBFJp1/7y9Zw/UsAUmzk=;
 b=BcMI44pLCy4q2d22ax5Rzlz7fC00lgGha3/s6Gx3G2mrpsge6kOpHxkqgigtZhKKWowyTjhQwg+NF8geBe3i+Ir/lP2mhaUMWbRKtd/m1kLgn0kIqnNtSZulxkHaoEAjvVDBbGX74Tz1SV6G+QUQWSrV0HayOmX0xgXEyMEi0au0gNCLAdHzLaMsDbb2H7lxp574NfuWlxZfsWtzysfCzt3gcOfHic2Eel1T8KfOt2ppbDwDSTSgSMO9Cx139sy1145Wk4UcTbkdJkIUid4pjHp7g4mecbAwASUtD/7RWRuAbY4RjjBeC6bJhyxqL2aparHGhZAb5Q2TSpN2zbsHIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLpGiNeFB/ot0toOVlcLinlWBFJp1/7y9Zw/UsAUmzk=;
 b=qfcWgKGWF4pNs48qR6OpPiG4HZPH89k5UYuBdFl8iliJAqX9Yy7uTJ2TV3+i+CrfEVf1zxlx421wUfxKf79bw5xwQ3FT/5EGpCEEbtXaR5tdnCCjYmdstWp3NAXuKCxQJAV0dCmvDR0ve0r4X+LsdpVvZVgiz3xjCiE4EF8NxvY=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AM7PR04MB6774.eurprd04.prod.outlook.com (2603:10a6:20b:104::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Mon, 22 Jul
 2024 15:49:41 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%3]) with mapi id 15.20.7762.027; Mon, 22 Jul 2024
 15:49:41 +0000
From: Josua Mayer <josua@solid-run.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth
	<sebastian.hesselbarth@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Russell
 King <linux@armlinux.org.uk>, Konstantin Porotchkin <kostap@marvell.com>
CC: Yazan Shhady <yazan.shhady@solid-run.com>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH RFC v3 3/6] dt-bindings: phy: cp110-utmi-phy: add
 compatible string for armada-38x
Thread-Topic: [PATCH RFC v3 3/6] dt-bindings: phy: cp110-utmi-phy: add
 compatible string for armada-38x
Thread-Index:
 AQHa2q/UwdGhmeTzHkyvzzjdx6DlRrIA7BMAgAHvxgCAAAKGAIAAAOaAgAADzYCAAAQNgIAAAQiA
Date: Mon, 22 Jul 2024 15:49:41 +0000
Message-ID: <ef923907-7e88-4549-a190-d1eb9bfc5236@solid-run.com>
References: <20240720-a38x-utmi-phy-v3-0-4c16f9abdbdc@solid-run.com>
 <20240720-a38x-utmi-phy-v3-3-4c16f9abdbdc@solid-run.com>
 <d48d261f-c428-4b96-9a88-725e29f6648f@kernel.org>
 <14090e3b-e627-4342-91b0-d6d0b769b736@solid-run.com>
 <55671e6b-abb3-4773-9f55-41920a3ff8f4@solid-run.com>
 <14f53dce-e26e-4af3-9275-f2aef4e03c98@kernel.org>
 <53c3dbc6-5d14-455f-8c3d-6a7293068ed9@solid-run.com>
 <f8e0ff0f-8b6a-4735-aaa8-803a5ea6cf54@kernel.org>
In-Reply-To: <f8e0ff0f-8b6a-4735-aaa8-803a5ea6cf54@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|AM7PR04MB6774:EE_
x-ms-office365-filtering-correlation-id: 2071f65a-68f6-4d86-3e5f-08dcaa65e696
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?eFhiQnFVMEw0V3BpRGhrSy92djlaQ3lHeWRnUFFTRG5PZDE1U3JKWW1UOHlU?=
 =?utf-8?B?TEs4NEVHcEJGQnN1Sk9BVXNQWit6b3FsOWQvQTlMMmx6NXI3bFdwOWhhdFpa?=
 =?utf-8?B?TzFxcndva1E2QWF5Um9nV2kycVFDRms3TjRuSStIN09ycW56Q01jL1BZSXJh?=
 =?utf-8?B?MCsyOU9DU0VnR1ZRYjJ5R0xRenJrUW1tOVRoanZBQWF0bm1wYm1YSklJTkE2?=
 =?utf-8?B?NDlYRHdFTFRJc0J3WkdqcG96ZWlSakVjWGZINHp3NURaNThSc0NEV1NMd0FM?=
 =?utf-8?B?Wis3SVdZMjc0OUUvWVRRWFM1a2Y4T1o4cTVjTVhHT2VWTk1aK1h4RngzVWph?=
 =?utf-8?B?dUowZjBabnVuLzdtbndkVmlpSm8zZHdrMmxJQ2JTTVNqRWEwVVJDWUwzdDEy?=
 =?utf-8?B?cmhhdVJaQUpaMkZLRHRxVitLU0huL2lKVVZ1NWRla01xL0luN0lGUWk4Q1E5?=
 =?utf-8?B?YnFTeWlGV3dSb3k2UDlHZ0o1dWNxY053MU5MbDlHSUtVb3pMK21ReEFqNzdr?=
 =?utf-8?B?dEVrcVZDUEo3ZmVidWVFbG5ud2RsRnZDaEtzSWN0UGpkMmg5VjBpVWFqY0VQ?=
 =?utf-8?B?WngwVG5QdEg2Mkxac2lmME1HcUh5K0ZEa3RlSmRFTm8vZCtEa1pULzNRK0hW?=
 =?utf-8?B?SExGWTk3SlkyNXFsSEN2MXpQVUdXMU5vWFRpeVJWQm90YTcxRWJuenF1aDlR?=
 =?utf-8?B?eUtMWHRHLzFBN3o0d0hXaVdyZk5WOGRFcndpYk5PS3FnM0lENVpCSWNXa1dS?=
 =?utf-8?B?d25kNkhvbEFwK0dLbElycUpCc1BhbXFSbjZWRTV6eUFtTEppcmFwWVcwV1lS?=
 =?utf-8?B?OUZLVEVQMVU5NlVVWVJMU0JLYkRMZ3NYWXBXZXF1Q0prcWFQWXczUVYyK0dX?=
 =?utf-8?B?QXVhT2NrVDA0L2R5VjhTckRtSERRbytkM2ZYdlBsZlQ1cUpHTkt2R08xd3lC?=
 =?utf-8?B?YVY2YmYrcUxFU2p3bXIxNEl1aUZCRXltUVFHRTNHL0h1bHREMmtkeS94V280?=
 =?utf-8?B?RVFFNEZOQlJPRTNxWkZ4VEViZTQza3Q5dGhYNElkUlNzTTZ6Z0hXRUx4bHFa?=
 =?utf-8?B?M0NSV25wU2NwajVFQldCejRjL1NUVE9TRnNuWndvQ3JQSk42NkN6bnFIaER2?=
 =?utf-8?B?VmQwQmtOcFZGbnJJTjU2V0lHSmRQYk9kWEtDc1ZZRno4YVZhM1l4Tm9xZlhL?=
 =?utf-8?B?bW01Zm9zU3JmcGFUMVN5TDdyc2plN0M0RHcrRlQ4Z2tSSWtSK3V4SmUvN3Nk?=
 =?utf-8?B?NXFkMHFvdDJpd2NJR1RMWkIrVVBqUkc2UEorb1pGZXhqaGhyS3ZDZzVGZnhq?=
 =?utf-8?B?SFhVNHZPd01sWTFKSEN6ZVI3MGNlNVNCOWxzekV5ekpZeTI0WS81bk5XWUVC?=
 =?utf-8?B?ek9RYnhrNzVNZ2M0azVpTCtuZFl0Tm5JUmtkbmpzN293QzNRbjYvdXV1MTA2?=
 =?utf-8?B?S0srazJpSUtGY0pBeEVCRHBmT3hieTdkdktiZkhKZ0xGbGgzSVZhKzlBejQr?=
 =?utf-8?B?QVRZSEJQL05rL01rRUR4VkhzWm9IOUNGSVg4dmZSZFhuczFEei9nQ21oWVdF?=
 =?utf-8?B?RytUbVpWeG9xTHVkZUUreVU2K1d5WGpSTy9pbHU3cnV6Zm12Tlc5R3dXaWVi?=
 =?utf-8?B?R3hGUlRmcXc4bXAvQklTZG1sNXVEVGlrWThjTnZHYVNQbmtpbTJ6aE1lTlRJ?=
 =?utf-8?B?SktZSDZZaEtmUHNDS1dGSk9jMjFyRWxpc045QWNPSE5GRHE0YzZ2NEN0SFVm?=
 =?utf-8?B?UXNHSk5uMDhKMUFCM1BzSUNLRDh5cTZlck5GMkd4SnAzRXJPZzZFUEUyYUV1?=
 =?utf-8?B?K0lKbDhESnBpS3VEeXVqNkQvN1cxUE9mVEUvVGV0RTBkSU9HZlpRU3pscEFD?=
 =?utf-8?B?alNYdWJScTBSMVV1NGtDdldrSFR5OHNqZm9IVjZhdk1WNUVibVgrWWdKR01t?=
 =?utf-8?Q?9PFEZhoe/yc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RDVNQ2NaUlFyTXJBR1VNZ1BGZE5zMVMyVDZBTGIxWVB5djNLT1FXVlY2UnZz?=
 =?utf-8?B?azI2YTMyMUxQVWhXK1U5b1UwdlJ3bGJXZDBYZEFsQ0ZRV0JpcDQwNFFvQUNP?=
 =?utf-8?B?NVVoNzc3ZDEvQzJEK3NRQURDbWF5d0FVazdwQit6TFB2LzNBeC8wUUx3Mkh6?=
 =?utf-8?B?NXc1czUvRVNtYWhheitSZnVtejMrMUZEb1g4bjNhU0kyQVJEYlBkTVhxZ0M0?=
 =?utf-8?B?RmkzdWtlTnBsRm1aZ0ZBaWVpVlpIcW1DVnNMK3FndmovR1pJamRUTWtHVldk?=
 =?utf-8?B?RUp0SFcrNXhWc0VaOWNzcHZreUZDZ2VDQlZ1blIzYUoyNWVBVnB5M2N6NVpt?=
 =?utf-8?B?L1pJcHBad0VaTmNFYnNPV0I3bnY1MVlhZExxQXd6cXpJKzN2eS9WNWkrbXVR?=
 =?utf-8?B?RUhtYVRkbG5rNFBIWUgrVm5yNlNnTDU2eGtaalllYU1SNklEOTR4ZVczQkVE?=
 =?utf-8?B?L0tPT1I3R0g0V2pmOFh3NW1VUGZJeHA0STNnajI2bzJISmIwUkVTZXZDL3hh?=
 =?utf-8?B?RDZLRk0xS0RMMVVtc1FSSmdSUFp6ME1PQjYva3ExRm1TUmVVK2lzRUZFbWRI?=
 =?utf-8?B?amVONlJhYW1FbzZWdHB5ZDAvR2VWOEN5SEhXLzB3TzhTNjNaVGNKeWhzbU4v?=
 =?utf-8?B?VGxCa3hRNVEzU1BmNWZVN0R5dEYzeFErd3E0dTV3M09mcS9MdnVHY2VNM1BN?=
 =?utf-8?B?WkxtdWs3TlBFNWgwOHdmTkViN2hPWlh0SEVDTGJLUTMvK1FpeGppZjQxOTVQ?=
 =?utf-8?B?bUVlOHgzbmNQTFBsSE5Sak83UnBUUTA2RWpxaGwybjM5aVBWYUlLaXFtTmRh?=
 =?utf-8?B?c0JYUkI3UXJrTGEwbEI2VkFjeFNtalJ4czlhdDNqMU1qZzdQaG9GcndtbExp?=
 =?utf-8?B?cWtITVVVcCtuSVdhR0lEdWZvMXhmeml6RVorQkxHS2ZGQUZNT2tSUUZNTEd0?=
 =?utf-8?B?VE4yYW9RUndrR2RlYUsra3BXN0w1WEhRMmJSU0M2SWc2aTFPemQvME8zRVRL?=
 =?utf-8?B?VXkrSHFjTWNORS9UdVp0MFM5Y3h4dE9FT0NsUW9tcEZCOG9uK2s2dWpUQkRm?=
 =?utf-8?B?Qyt4UHhGUVFaa2hROWNwcmZoNTZ6cnRjRGRlcEVLd2FIQ1UxMWhUMkRIYk1O?=
 =?utf-8?B?a1RJQXppMjhQOUlpektnZnJsRGI0NnM4VndCZWVsdWo2V1duWVI5OGhTTUZQ?=
 =?utf-8?B?b3JudzJJa1lsZmk3YVlFbkJvbXhmRDlzV2JqMXVzaXdtZDMrem1YQndwaDdu?=
 =?utf-8?B?QnhBTWd6a2dmVmxSMnc3aWhWR1ErSTZEWGl0bWZqY1Zmajh2TkduWTAwa1Ja?=
 =?utf-8?B?SEhNSVBFaThTRWVMelU2dHdxeHh5SGNOQWQwQzd0NVo1bDU4RHE5MFZ3TTcw?=
 =?utf-8?B?eVZxZUQwUXpTNVlRTm5zQ0FFa251RGxYYXpDNXVLU0lUelZrZHRZY2YzSzI0?=
 =?utf-8?B?elJVak5DOWR5cklCMFhScU5BcDlONk9nd3lqcjhUekNpZ2V0b01YS09SVkto?=
 =?utf-8?B?eVVwUkxxRmVaVTlmSTBaOWhtdk1GYWVxMnlLRFRlOVFyWjdCK1JsRWxpMmVM?=
 =?utf-8?B?SnM1eHpvQllSQnRpa0Ztd2VEVFpDR3lXMlJCNitZRGlrUi9YeWJtMHlEdFB6?=
 =?utf-8?B?ZHRnY0VtWnVZMFJzYzVWZVZMT2VUdFczQkNQZ3JsVVd0ak8rY29nSXA3cHNh?=
 =?utf-8?B?bXFFVnJ6bStleEpoOXlqaFR1SndPcTB3Q3RTbjRaTlhPL0UvWHdXZ3crbk9D?=
 =?utf-8?B?ZEtkYmZhS05RZEtUVTBBdW83ZW9LUitrQW1vRjRkUytLQklleDRyMFlGeWJZ?=
 =?utf-8?B?RVlNekFpSTFRdTJwZ09sRFMxTyt3NnBra2p3VG1HdUMxSFcwR3ZSZHdNcTly?=
 =?utf-8?B?c01XM0tKYU9Qbk1PTi83MlI1RjVaYXBaZCtzZHJsUmE0d05ibkJOVXBhRmF6?=
 =?utf-8?B?Wko0djlyZ0tpRkZWTG5JWk4raUkzcERzU1RVWHdicEVkSER0TUlITXZCdGR4?=
 =?utf-8?B?eUZFMk5xc2ozbW9QN0pncXR4MGpYU0xXYnB6MTZDL3ZiR3NJeUlySllHL2tH?=
 =?utf-8?B?ZjJISkd3MlBTWjdPUFRKK2ZwNXprbDVQeWp0MmpXZTV4MWlJMGFxdlNxMTV3?=
 =?utf-8?Q?wjT4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE0A6F0657FB1841B9056EE21EE8AD35@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2071f65a-68f6-4d86-3e5f-08dcaa65e696
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 15:49:41.6467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jwnJ7S6MSAUEznq1vgNh/ixJhthPCN9Y5pFYsigC3I6ux4EmnnqX7pogghsginUkX7uWWG2kBd185xM5C2VvTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6774

QW0gMjIuMDcuMjQgdW0gMTc6NDUgc2NocmllYiBLcnp5c3p0b2YgS296bG93c2tpOg0KPiBPbiAy
Mi8wNy8yMDI0IDE3OjMxLCBKb3N1YSBNYXllciB3cm90ZToNCj4+Pj4gwqDCoMKgwqDCoCAtIGNv
bXBhdGlibGUNCj4+Pj4gwqDCoMKgwqDCoCAtIHJlZw0KPj4+PiDCoMKgwqDCoMKgIC0gIiNhZGRy
ZXNzLWNlbGxzIg0KPj4+PiDCoMKgwqDCoMKgIC0gIiNzaXplLWNlbGxzIg0KPj4+PiDCoCAtIGlm
Og0KPj4+PiDCoMKgwqDCoMKgIG5vdDoNCj4+Pj4gwqDCoMKgwqDCoMKgwqAgcHJvcGVydGllczoN
Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJlZy1uYW1lczoNCj4+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBhbGxPZjoNCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBjb250YWlu
czoNCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdDogdXNiLWNm
Zw0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIGNvbnRhaW5zOg0KPj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0OiB1dG1pLWNmZw0KPj4+PiDCoMKg
wqAgdGhlbjoNCj4+Pj4gwqDCoMKgwqDCoCByZXF1aXJlZDoNCj4+Pj4gwqDCoMKgwqDCoMKgwqAg
LSBtYXJ2ZWxsLHN5c3RlbS1jb250cm9sbGVyDQo+Pj4+DQo+Pj4+IFRoaXMgd29ya3Mgb2theSBm
b3IgYW55IGNvbWJpbmF0aW9ucyBvZiByZWctbmFtZXMuDQo+Pj4gPz8/IEkgZXhwZWN0ZWQgdGhp
cyB0byBiZSBwZXIgdmFyaWFudC4NCj4+IEFzIGluIGJ5IGNvbXBhdGlibGUgc3RyaW5nPw0KPiBZ
ZXMsIGVhY2ggZGV2aWNlIGhhcyBmaXhlZCBwcm9wZXJ0aWVzLCBhdCBsZWFzdCB1c3VhbGx5Lg0K
Pg0KPj4+PiBIb3dldmVyIHdoZW4gZGV2aWNlLXRyZWUgaXMgbWlzc2luZyByZWctbmFtZXMgYWxs
IHRvZ2V0aGVyLA0KPj4+PiBtYXJ2ZWxsLHN5c3RlbS1jb250cm9sbGVyIGlzIG5vdCBtYXJrZWQg
cmVxdWlyZWQuDQo+Pj4+DQo+Pj4+IFdvdWxkIGl0IGJlIGFjY2VwdGFibGUgdG8gbWFrZSByZWct
bmFtZXMgcmVxdWlyZWQ/DQo+Pj4gSSBkb24ndCB1bmRlcnN0YW5kIHdoYXQgeW91IHdhbnQgdG8g
YWNoaWV2ZS4NCj4+IFdoZW4gdGhlcmUgYXJlIGJvdGggdXNiLWNmZyBhbmQgdXRtaS1jZmcgcmVn
cywNCj4+IHRoZW4gbWFydmVsbCxzeXN0ZW0tY29udHJvbGxlciBpcyBvcHRpb25hbCwNCj4+DQo+
PiByZWdhcmRsZXNzIG9mIGFybWFkYSAzODAgb3IgOGsuDQo+IFdoZXRoZXIgdGhlIGRldmljZSBo
YXMgYWRkaXRpb25hbCBNTUlPIGFkZHJlc3Mgc3BhY2UsIGRlcGVuZHMgb24gdHlwZSBvZg0KPiB0
aGUgZGV2aWNlLCBub3Qgb24gc29tZSBvdGhlciBwcm9wZXJ0aWVzLiBJT1csIGVpdGhlciB5b3Ug
aGF2ZSBoZXJlDQo+IHNlY29uZCByZWcgb3Igbm90LiBUaGUgaGFyZHdhcmUgaGFzIG9yIGhhcyBu
b3QuDQoNCkF0IGxlYXN0IEFybWFkYSA4SyBhbmQgQXJtYWRhIDM4OCBib3RoIGhhdmUgdGhlbSAo
cGh5c2ljYWxseSkuDQoNClRoZSBkaWZmZXJlbmNlIGlzIG9uZSBvZiB0aGVtIHVzZXMgc3lzY29u
IGZvciBhY2Nlc3MuDQoNCkNvbnNlcXVlbnRseSwgd291bGQgaXQgYmUgYmV0dGVyIHRoZW4gdG8g
YWx3YXlzIHJlcXVpcmUgYWxsIDM/DQoNCihJbiBkcml2ZXIgSSBjb3VsZCB1c2UgbGFjayBvZiBz
eXNjb24gaGFuZGxlIHRvIGRlY2lkZSwNCmN1cnJlbnRseSBJIHVzZSBwcmVzZW5jZSBvZiByZWdz
IGJ5IG5hbWUpDQoNCnNpbmNlcmVseQ0KSm9zdWEgTWF5ZXINCg==

