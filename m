Return-Path: <linux-kernel+bounces-434535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 687259E67F7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD892812D7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB95190470;
	Fri,  6 Dec 2024 07:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l1t7Z9wC"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2055.outbound.protection.outlook.com [40.107.105.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EC22F5E;
	Fri,  6 Dec 2024 07:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733470342; cv=fail; b=apBoegUiDFzvmy95ThNklY3Hu7m8AEc2KZM7oEhstWaZtsvWCgk+bfdzt3Nk2gl/JVrt45nLeF7rEtN1yy3cjVRC7o2I/vi7JwPz5Kqgf+Xi7IR2dOx8uVnHTwYVLEn1HrtlNc9SpHFyEHx+8aqgw1LWX3npB9rjAOgfm+sikFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733470342; c=relaxed/simple;
	bh=O/LoQsuuCSN7zZukTrmejAvg1v7W4k1hzmKj++9hGtU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O1azgyB61rajkxGABpbrA5M6UUOKAfG+s3FvjLwq5IdhfI3Gn3zhqf5rYMGsQHHzuzU0Qt0bZA/vt8IbLG1+FHY9HqhAzKGUwSSZd2j/++0YR0002HKGkc+WwD0kDRHr3AVj9Fiyg8arBBBzjEK6KqF7bIkvQOBuADdWr4V50a4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l1t7Z9wC; arc=fail smtp.client-ip=40.107.105.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXTOhOizgd6rOQKTZA4dJZCNllmGHJ2Vm0njs4C2d06c3VaH7xvMybwEvVHmcjWgt/MC5CnHpnS/02VUZ8zdwfmbHrlE+X1eKqYx5GQOllZS5eWW4NLvLj0h72c0No9MR6qKdBZNMwfyhIwuXTrCaGknmaXDRkUkH/eUEO1Wq2JZY/2SOiD1w6bGmYrxP7tZloRI8AgksqAH2A5kpCcHqFVUBRxHt+RIkdwtc9vXI/GK4MEtRAPWNYYrJd72+QUI2O6Xv9QslUk+3g4zbgNg9I4v2sBlLR3OaKj9DdsMhM2fhtMzcYWw+fuEHbtXUNI07g9a0aXbf/lLsR9OBHigqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/LoQsuuCSN7zZukTrmejAvg1v7W4k1hzmKj++9hGtU=;
 b=Dcn3/za72X21cWTbm9noI6ZYsc+5Qqu0bhCEDTmu838RZ/8H05MSnu3ETEqlQOh4pd2ngjqtstO8svqfn12R7SDrE0JsLRDaypIZi+Cl9akgj7Xkp+cQwDl/mp/9NEXIeLzuNOlk4JDBFG2fDue6j0mXncDS4JBJk8PgUpL34Bx+O2edhPPzyI+rrY7oS7oU7JtKU1OpourRPnQJjOmLIHujZ0SNUCu6R7TfMhKSXGEa3vGneAtHJeE/MFzvWDHqPv21Qa+FuE5uD5HvfLLJTDGjSl/uvmvteM2hFMH1iq4yNUO8IxfQJI7MBoyjJONzco/x8PBXR1j+nlBR5FT7wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/LoQsuuCSN7zZukTrmejAvg1v7W4k1hzmKj++9hGtU=;
 b=l1t7Z9wCaZw5kLBuxFrlTa+esbx394Ak4OKG+aX/bMpQQDECuQWhb9e97BKBMFYHaL/OPCfpRiVTarDgvzM8X0px8KXNmhcyvzyRrWY4pzGnGjkuQsGfofScO8lwWC373eCCyNewgUUdpRxg8PZXvp70pBGNuPtznJJB282HGknfciKehKYcvbn1uhoJi8AYbTO2WXA2CdUchOWYUF6lFv6WJS2BJLbUGb9xrqihCDVs8PwiOa6Tf4Yplf0/Tpj9eK5FlGLvrpMAl0+XtQqXdpKDgoViJ4WqhkV+6dTBC69yBy/eHAi/q/2ZYd8Sv7I4OBQrK0FgJ5SkHhQx+RKMQg==
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AM9PR04MB8572.eurprd04.prod.outlook.com (2603:10a6:20b:437::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 07:32:17 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%6]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 07:32:16 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Mark Brown <broonie@kernel.org>, Frank Li <frank.li@nxp.com>
CC: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Robin Gong <yibin.gong@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH 5/5] arm64: dts: imx93: add pca9452 support
Thread-Topic: [EXT] Re: [PATCH 5/5] arm64: dts: imx93: add pca9452 support
Thread-Index: AQHbRzX5CtFIREUFrku8tA1R11KzlLLX32eAgACnxGA=
Date: Fri, 6 Dec 2024 07:32:16 +0000
Message-ID:
 <AS4PR04MB938640EE746307F991183C87E1312@AS4PR04MB9386.eurprd04.prod.outlook.com>
References: <20241205-pca9450-v1-0-aab448b74e78@nxp.com>
 <20241205-pca9450-v1-5-aab448b74e78@nxp.com>
 <b5b07f6f-a5c5-4b29-ada3-962dbbba42d4@sirena.org.uk>
In-Reply-To: <b5b07f6f-a5c5-4b29-ada3-962dbbba42d4@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9386:EE_|AM9PR04MB8572:EE_
x-ms-office365-filtering-correlation-id: a642f861-4299-442c-104e-08dd15c81c57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?b1FaSGFURERpTHdDN2NrMlRsOWhvY2NDWVQ1a0t0UjJCbE5McmhvSDYvMkdJ?=
 =?gb2312?B?WkdGTVdQeXc3UEpnUFpQWDFzWW02V2owZ3cxcTVoUWhDWEFnM2pjWXBveUxs?=
 =?gb2312?B?RjliWlVaaG42K2l4QUsrNWhSQ3FHd3MyeWNXUjBkZHZEaXVqN0t2UjFSSFBF?=
 =?gb2312?B?em5Qc1JZeXRLS2c0RjMwbVlWc2pMbms3Sy83MDA3SFBiNFNVY3Frcm5aUE9z?=
 =?gb2312?B?ZVZmS2Rnbm4zTk9MUEdNeTdNSGUwdFo0cTVYb1QyNmpYaU4zSWRkN2piaEFx?=
 =?gb2312?B?SUNxaCtPM2NBQndPMHMvTUNhSFE0N01mY1htb1BpTXRsSjE1TWc3b2FWM3U5?=
 =?gb2312?B?RGJHVk5mR1k3UzRJWGEwRWppbGl3R2R5bWdlVkE4YlRQMWV2Q3RkTGNkMlY3?=
 =?gb2312?B?Rm92UTkrbG9hZkIydFlRZC9pK25Mbk92eDIrS05pZHpnZUxHeHJ6TjdHdjda?=
 =?gb2312?B?ZDhJaFR4WUVBZFJVMExQV0czaDdJMEc0VWRiUmxkcG4rdzBQQlJORmtNYXFO?=
 =?gb2312?B?SkZvYTQ3bThlNUE5alFKS2xrUmMwbVR1SFY1NDlJZnM4Umw1U2o0d3hGeEFS?=
 =?gb2312?B?akgxQzJjRytObUVMRU9GcnkwalBnQkUzWW9yMzVrc1B0dDdjRm1vUzZxb01n?=
 =?gb2312?B?Z0NMRlVhcTFkamNhVFY5NUd2RmpZWGdRTnpiVWVRdkhiMCtjaTJkYkMxb0l0?=
 =?gb2312?B?OHRLcVVJZDZzWGtsWGUxVm1XY3RIZGJIL2cyRjY5TE9vM3B6ZjFyNEl3MWd0?=
 =?gb2312?B?NDV5RWl4SmZGNFNnQTB0NzB4bnlqSTVqOFJhK0h1L0JzbUlLd3c0MVl4L1Fw?=
 =?gb2312?B?QmRyNHFXVmJNbEZ1MlNneTRIeGJNd2k3Ujh1VEJ0NWZBY0htM05mQXBBN3hD?=
 =?gb2312?B?bWQxL1hPV0JnSGF6UVk4WjQ0SzlBSG5URjhpT1Irb1FMbWxRbUpvbHVEY2Rm?=
 =?gb2312?B?ODJpcmQvWXBJZzI3YzRoY09OY1RqR2JlSVJBUVQ3dFBDYXZRTGkzVGsxZ3RY?=
 =?gb2312?B?WEtuUVZwSzg4N3NkRStXMTJWNHprUHZZYW5VT3BWK00zd3FjZzkvNnFSUWQ2?=
 =?gb2312?B?UEpjb1BVdndTMWphSFM5T3lLK3hRb3hkRFN2UmJGYXFPWkF2TEJaTkFlYWZM?=
 =?gb2312?B?dWVwd0R0ZjhSUEgvZk85L0Nieko3Zzg1VFJPM0VDV1Azc3JTUkRTdmk5Zis1?=
 =?gb2312?B?RXg4Q3VhVXB2UHZIRUlJbEV1S01OR1ZiMU5TR3I5U01tVFE5RDhzMkRWSE5Z?=
 =?gb2312?B?cHdqTERZNW5IRGdmTzdjYnBrcFR2ZE9mSDhhdDBDNlh3bGtxSU1BUWlYc2F6?=
 =?gb2312?B?T0xmUCtHRVEyWFJIckxsUXIrbTN1ZnNNNVlEZ0VSRmF6b0Q3YlZlbkRyMEJt?=
 =?gb2312?B?b1hqQUp3QzFZb2Yxb3h5Y0ROOWUxQ0g2a1ZOY2lrdTljdDVDY0RJYlM1cjBC?=
 =?gb2312?B?YmtBcC9ZZ1crWFhuNXlSQ1lJVnhSeUVlMHVDeU1NaG1keW9VUi9zeFNNNFNl?=
 =?gb2312?B?UHA3NVJzSXM5ODhpS2luaHIzRm4zQWZJN0x6aTM5MVo2dzVIOHFlbkVuK3Jt?=
 =?gb2312?B?NkYrdU03RFRiT0dMenJ6RkFIKzR0dGdTbCtubGd4TmRIa01ZQVNBWWV4V2Mz?=
 =?gb2312?B?T3RTemI4R3RRYTgrTWpjcURlMStLUGtxeHpGcGlZbk9vVkZJUjM0WFVoYkNR?=
 =?gb2312?B?V0Y1a0ZaNWFqZzZGZmpHMTZ5TWFCUU9YbzErM3NtdWVBUDdSaXpieGZaQkNO?=
 =?gb2312?B?OHVaV0wvMFhoS3NnaWd5cHVxZFIwVWJKZHRHelBlVXVlbVVuNyt6NEZteXhY?=
 =?gb2312?B?alRFRWE4bzJxUklFWUxIOTcrT0ZPc2dwajd6UzcrRlNpbk1jTlJwMTg3UFVu?=
 =?gb2312?B?MWdzTm1KT0FqOFh5Nko2MmJBamlNRmRMNmxNamdZeCtpR2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?UEgwc1l4eVk3N29hMm1vMnNQalpkNFVDRHU0c09iSDBUN0F2Mm9lTjdtY3Yr?=
 =?gb2312?B?QU9NLzRUNGJ0UFFyS05MclZWQ0hqZ2VLM1N0R1czaWtTZ0hVRUlaam1FaG9G?=
 =?gb2312?B?RHF3dnZ2U3VHaXVvbmd4WU1SMkh5MlhlSS9ZOGJBcGRyczRKdUsvN1RaaUZl?=
 =?gb2312?B?SEQ1bXQ1ZFptVjIyczdDRTRmbXdYYm1uOTdlNVZKcGtnQmE4bUlRWWpaWEFC?=
 =?gb2312?B?VEVubWhiOEhObE82QXlKYVIyMGNKaWtsMjRxVFBGSlJLd0hEYWhsa0FCVGpq?=
 =?gb2312?B?WVFFRllrUmw4YzVkSlhzWEZJaXpoM1crSTFnNy9wNWo3SEpCTzU0SGt1WnRZ?=
 =?gb2312?B?R21NNll5YVFQQ3hkbzdiMERLalVVeHRoYVROZkZxSDZJQ1NxbFJDaC9jNWM3?=
 =?gb2312?B?bk5ISGliUVJmVDc2Skpabys2aWRFMFVhSC9vQU5BQTBYdGQ5d1l6OThNZGtM?=
 =?gb2312?B?cm81TFN0MjVKSWNxNndLS1F2ZlNZRTJVZFZjWlJqbUlUVEwrMXpUVndJbTJp?=
 =?gb2312?B?dERmemxNdE82aENvNkkzbjNQMUJKRVVGSTFKa2VHbVY5WXVzTHdZYUhaNlhP?=
 =?gb2312?B?bU8wMU9XQTBUYlNVZHVSd25VaHpJcldSSnVLT1pFUWxzbFRvUFJYTVp4OXZ4?=
 =?gb2312?B?QVhISVhsUkw1T0xVRUFXYzMyK2YyTXNHQmtmbHhER3FtUldEZFV3MnFrYThp?=
 =?gb2312?B?eFVXY3BmQkQxckxjVXlDSnpjUkhkRzhEU1Z3M2V2akJlUnVzR20rSy9peHd6?=
 =?gb2312?B?NnNCOGVaMTRkc0wxYXVpT2xGNzJSQ2VtQndPZXFPenJ5V2E4eVA4QXgrUE43?=
 =?gb2312?B?WC9CRk0yc0ZZaFh3NDRZMElhK3p2WTFBVGxRZnhkZ2RIT1g4VGJXWWlBQzR0?=
 =?gb2312?B?cXBPKzZHdG0wZU9WWWZwalp0RkxBV1pocnVRVmQ2NlpDL2hDU1YrSEk1KzlL?=
 =?gb2312?B?WHJzRStYSlpNQW9CZ0VnVlV6M1lyT3BlT2EyUzJTS0tvVTVnOHZxN3dPL3JS?=
 =?gb2312?B?a3VIVVgrYjFBeWNONHhVeUJXZGMrcTVWcWxBbmhmRFNVUW9zd1FMbHNLNnVD?=
 =?gb2312?B?Tlpva08vdU9pSk5yN245Y1VtTEF5eG1ReWxtRWYxc2NLaFF6ZldvSlEySWp6?=
 =?gb2312?B?K3g1bGxsNnBxMlVRbE96Tk54NVBoMG5iQlVmUFNoNThlS29WaFpsaHJ0eG1Z?=
 =?gb2312?B?dkpNK1REQ2tWWGh6RTlFNE5sRDBiSFRRQWM3eXlkOVUxdk5hbFQraGZuaW1j?=
 =?gb2312?B?WlpiTFBKdUh3bnh6ZjkrcUNRVVJuVlNXNGFSQzRvQjJtWFgycHNxT0FQcEk5?=
 =?gb2312?B?cys4UTZRZ1Fmb3RXOG42YS92NEk2OTB1cHN6MkNXa2N1OFZNZGp3aVRWUzgx?=
 =?gb2312?B?TlRuQVlaSGxZZm02L3YzL1o0SzZMQzZkbnIvNkpUVFdiQVFmdGJYYTVwZ0Zk?=
 =?gb2312?B?SS9UTldUWGNOVmpCVEVaU0s1UUozWUhRd21YSzZuL3JqL3FpTnh5NU9xeGNv?=
 =?gb2312?B?UXBzRUVqVThCYmZwYjFTeEpGUWJFY2N1VVJ5VHZxTUpOanpHTUxQOTZTVDIx?=
 =?gb2312?B?ajZyQWtmMEpyN1luTEx3cGNORHFRdGpqL1YzbzlUQURWZ1N4NXcvRVJuZ0E4?=
 =?gb2312?B?b1c3VmhMeDlpY2IvMWRMellhbzNUaDg5eEZ2QXVKRC9mdVAzQUkvd3o0RzZ4?=
 =?gb2312?B?bGVkejAvbzM1c2dZZ3RobWsxTmxHWXJPSEcyaGVzMU1QRDNPSC82eWNiZERS?=
 =?gb2312?B?WnBhWVgxRDlVWDVkMXhmbTJHV01LcnFzWFBscjc3SzlDYXVyZHB3M2pqUW9a?=
 =?gb2312?B?N2gvRXFUS0xacWxzamJFaFk2OWRMdDJtVGtrbjNDNkEvczN0M0VHOE1zR2RG?=
 =?gb2312?B?NGl2OFVnVFVKRXoyb3JscEUrV3BPSkJVdUh6V2phZ2RHQnJjUGdjRE11VW5h?=
 =?gb2312?B?QUZjdmRxL244VWg4cW9JcFlnNFc3WUFUVnpQUDNxZVRUMnR4OUR6Ym9VUG5X?=
 =?gb2312?B?UTBVdWtDY3AwamJuM21FSk1BRmcwTTFRL3NqeHJLSmlhT0poTzVwOTY4YU1n?=
 =?gb2312?B?Wm92L2lNVnRPbDR4UGtvaWd1RmN3QmI1QnhGdVUvbisvRTBka29wNEdJaFI1?=
 =?gb2312?Q?kBpA=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a642f861-4299-442c-104e-08dd15c81c57
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 07:32:16.9051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AtnN/R65gC7UcC+jY00ZDCrOE5IpqipPw0DebElyLSbWUp/t2P5rz23gXTprWu5g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8572

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyayBCcm93biA8YnJv
b25pZUBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDI0xOoxMtTCNsjVIDA6NTkNCj4gVG86IEZyYW5r
IExpIDxmcmFuay5saUBueHAuY29tPg0KPiBDYzogTGlhbSBHaXJkd29vZCA8bGdpcmR3b29kQGdt
YWlsLmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+Ow0KPiBLcnp5c3p0b2YgS296
bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkNCj4gPGNvbm9yK2R0QGtl
cm5lbC5vcmc+OyBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+OyBTaGF3biBHdW8NCj4g
PHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXgu
ZGU+Ow0KPiBQZW5ndXRyb25peCBLZXJuZWwgVGVhbSA8a2VybmVsQHBlbmd1dHJvbml4LmRlPjsg
RmFiaW8gRXN0ZXZhbQ0KPiA8ZmVzdGV2YW1AZ21haWwuY29tPjsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51
eC5kZXY7IEpveSBab3UgPGpveS56b3VAbnhwLmNvbT47DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIDUvNV0gYXJtNjQ6
IGR0czogaW14OTM6IGFkZCBwY2E5NDUyIHN1cHBvcnQNCj4gDQo+IE9uIFRodSwgRGVjIDA1LCAy
MDI0IGF0IDExOjUxOjEzQU0gLTA1MDAsIEZyYW5rIExpIHdyb3RlOg0KPiANCj4gPiArCQkJCXJl
Z3VsYXRvci1uYW1lID0gIkJVQ0sxIjsNCj4gPiArCQkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0
ID0gPDYxMDAwMD47DQo+ID4gKwkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDw5NTAwMDA+
Ow0KPiANCj4gPiArCQkJCXJlZ3VsYXRvci1uYW1lID0gIkJVQ0s0IjsNCj4gPiArCQkJCXJlZ3Vs
YXRvci1taW4tbWljcm92b2x0ID0gPDE2MjAwMDA+Ow0KPiA+ICsJCQkJcmVndWxhdG9yLW1heC1t
aWNyb3ZvbHQgPSA8MzQwMDAwMD47DQo+IA0KPiBUaGUgcmVndWxhdG9ycyBhbGwgaGF2ZSByZWFs
bHkgd2lkZSByYW5nZXMsIGVzcGVjaWFsbHkgd2l0aCBubyBvYnZpb3VzDQo+IGNvbnN1bWVycyBz
cGVjaWZpZWQuICBBcmUgdGhlc2UgYWN0dWFsbHkgdmFsaWQgZm9yIHRoZSBib2FyZD8NClBsZWFz
ZSBpZ25vcmUgdGhlIGxhc3QgbWFpbCBiZWNhdXNlIG9mIGluY2x1ZGluZyBodG1sLg0KVGhhbmtz
IGZvciB5b3VyIGNvbW1lbnRzIQ0KWWVzLCB0aGUgcmVndWxhdG9ycyBhbGwgaGF2ZSByZWFsbHkg
d2lkZSByYW5nZXMgZnJvbSB0aGUgcGNhOTQ1MiBkYXRhc2hlZXQgYXMgZm9sbG93Og0KQlVDSzEs
IEJVQ0syLCBCVUNLMyA6IDAuNlYgdG8gMi4xODc1ViwgMTIuNW1WIHN0ZXAsIDMwMDBtQQ0KQlVD
SzQgOiAwLjZWIHRvIDMuNFYsIDI1bVYgc3RlcCwgMzAwMG1BDQpSZWZlciB0byBQTUlDIHBjYTk0
NTIgZGF0YXNoZWV0IDcuMSBGZWF0dXJlczoNCmh0dHBzOi8vd3d3Lm1vdXNlci5jb20vY2F0YWxv
Zy9zcGVjc2hlZXRzL054cF8wMy0wMi0yMDI0X1BDQTk0NTIucGRmP3Nyc2x0aWQ9QWZtQk9vb1Ry
Z1oxRnJQZkhZZnp0eEdtNXI3WVlzQkVGUkxreDU5ZElaS01SbGsycnNSNm5CVjYNClRoZSBCVUNL
MSBpcyB1c2VkIGZvciBWRERfU09DIGFuZCB0aGUgQlVDSzQgaXMgdXNlZCBmb3IgTlZDQ19HUElP
L1ZERF9VU0JfM1AzIG9uIGlteDkzIDE0eDE0IGJvYXJkLg0KUmVmZXIgdG8gSU1YOTNBRUMgZGF0
YXNoZWV0IDQuMS40IE9wZXJhdGluZyByYW5nZXM6DQpodHRwczovL3d3dy5ueHAuY29tL2RvY3Mv
ZW4vZGF0YS1zaGVldC9JTVg5M0FFQy5wZGYNCkJSDQpKb3kgWm91DQogICANCg==

