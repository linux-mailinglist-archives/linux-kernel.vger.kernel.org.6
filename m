Return-Path: <linux-kernel+bounces-306354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0262D963DE7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263D01C240D6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B743D18A6A5;
	Thu, 29 Aug 2024 08:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I+hcSww1"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC3D15853D;
	Thu, 29 Aug 2024 08:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724918428; cv=fail; b=SEGZ7y1GQRoTVBT0nD69Twkg7l+TfIir9/XrT46PUNlQ0VRG0gkPk43wFhe3f3XrKR8YgHZ1oWtUTuzOP58VQ+BOd1BvRVc05IIOxMBXLzCz98SAhqiySrt9RakkcqPgLrUJ1ZWM7I2LmYA/zKzYvfSS0bJ+Hj5/xymZn4Ygg5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724918428; c=relaxed/simple;
	bh=IXqpEtl2LOqDW5drDQz5Q+IoDmZDEl6MQ2Th2UOTePA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ppC60XHa+dtzfXpeHQUDd+TDG7a8l2eRFX7F2HzBSEV4QuDJH39s68oda+c4hwmM7OTEv5MBESZbW+QjLHXqwISqrjXrOCivUQ01b1ojQG0FPp5mbOxBKE6PFSIq8gGj6HSNnr42aadn2I0YXk5qqgHliCrfcuimyvdYxY+beWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I+hcSww1; arc=fail smtp.client-ip=40.107.22.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZ+o8GdJe0wez3hWbAfZU067xEk23lE9zbiqMdYlg3EhFFNW9hSViCGQtFLwOPvAiNSsSvB8tlHQE7AwhjlnZlfEsZLSwExkWsP7DtR1l3QC0vo5X31FjONjp+xTBNd/w1VcdnXm9s8wo6KKWgQMGrac6kslAWVmCXuoltm51jNiW4TJBuFVBon/I/eMnUG8QydmjU1Ot6Of0pGavME0b1JCT7+3pRhP5Q/FJs0MEsN6Xhxv+mZ/y8Y6UkmPpP3RAtebIWsJ1PCdYWscQIUZXu3p6FMIOavn7g+7i571fx4EUOzrALsnSq8m1fDo+AZPqPvw+lHjQX+pNcDA77lxxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXqpEtl2LOqDW5drDQz5Q+IoDmZDEl6MQ2Th2UOTePA=;
 b=RAv9AoJSaITNqMyUsiroF+Q8EsAeyxpr+Yg1lAjKJIlFRkOjxiY+yxp7+5qinzjpAT8Jk4LTN8Jg9lqrdi/Zmfo8Ep+2SMST+AHyJW5wG61A86wHO0NSAkL+ouNgeCtGFe3hkvqkuXNRUvRPZvfPl9HGubWosmc9D2oAxM9AroQ0qWIgmTuh8q4qmQl5ECw3/n7ygr88VxCfEUfS6YFUSpb9JpzOl0Gr39LsHDdsMCBHHK4J8X4yqlpPVpBBH/QCtlzvJniWZEVCWN7PvY3CwZ8A4OzBcSrMJeuUcXyo07NzGYrOEFjHvlZ2/bJmsyGnix5ykvxqHW94fBaGbxDQMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXqpEtl2LOqDW5drDQz5Q+IoDmZDEl6MQ2Th2UOTePA=;
 b=I+hcSww1W5TiUJheHkBU8ZMIHJoFG5/nsmI9o6UC6k2OhRyUlKygUdB4McfykyH6sihnkxLUMbNI2YOYEAnwFobslidM0M6+7bNh6VfAbKCaXLklMwQEi/8LkAL/UsuJ+HFDVQ/fUY1eZftwyX+IOF7Xu5yuikirnTEJlrGn/xSNiMgQwKCT6tY8JwY/2xV9QMFWVgROe7hjscwqasI8x18dr/AONIAqnjxHedxCMlE6Db8tg5BsYrRjfbi0WSGsryRz30gtSppLgOgY4tJUXhvkxgoHLDlj3dznOypMSTFeAbGNCN4r8NTGiJcs62+rv4npZW49xJgU/vGPuoaNlQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBAPR04MB7448.eurprd04.prod.outlook.com (2603:10a6:10:1a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 08:00:23 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 08:00:22 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Abel Vesa <abel.vesa@linaro.org>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "abelvesa@kernel.org" <abelvesa@kernel.org>, Peng Fan
	<peng.fan@nxp.com>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [Patch v3 0/4] add NETCMIX block control support on i.MX95
Thread-Topic: [Patch v3 0/4] add NETCMIX block control support on i.MX95
Thread-Index: AQHa+bNwZDrxYeCEgUW09rjezeJ3LrI93MUAgAAA5QCAAAGn0A==
Date: Thu, 29 Aug 2024 08:00:22 +0000
Message-ID:
 <PAXPR04MB85105467D373F18819B2325688962@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240829011849.364987-1-wei.fang@nxp.com>
 <172491778768.2521946.17064463983702008243.b4-ty@linaro.org>
 <ZtAo+B0XOE558+93@linaro.org>
In-Reply-To: <ZtAo+B0XOE558+93@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DBAPR04MB7448:EE_
x-ms-office365-filtering-correlation-id: 2ea57f33-9b27-4c62-4212-08dcc800a25b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?OXFLamVla0JRVWJXbWN3ZnBpU1FGaFY0M2wwVkZtSWt6cVVUQ2RaZ2lKcG5y?=
 =?gb2312?B?bDZBSC9jakYzSUJsM0E3YmpERi9BcjZkNlBtbXJrWkJkSGplQXlNWEI5alhk?=
 =?gb2312?B?WjN2c1NhTDJJUno5S2hHRVcvby9wbmpBZWVMeTRuaUtqRlRKcjBZekUyY0Vu?=
 =?gb2312?B?SmlpN09CN2dJK1lWOWNGRi8xWUxxc1pkVE9EWFZnN1hGR0U5cU92YndVUFli?=
 =?gb2312?B?ODhIR3ppNkNnQ1FsNUV6QUkwbmlsTjJIQ0xLMkZmY2tLdk5mSWdTRDhpMDVx?=
 =?gb2312?B?T2x6c3llRmpzSmoxQ1pDU3FOVEdQV283OG1VSXdxN3hFTnZIejRZYWE5alBl?=
 =?gb2312?B?NEI1aW1ZQUc5aHFQMkZLS0RwcitlL0hUM2IzR2k5a1pzWXhhTWdSc0RCKzlB?=
 =?gb2312?B?b2p2SEFKcVE0NkcrK1dIamdVbUFnRFVOM0VxVVA2elc3UFgvYWpVbGszVlkz?=
 =?gb2312?B?bjd4bXlkTTlqcXNrZ042UUtFT2s4WDZoUGsrSFJYTXgrU2NrQy9ZOFlodHFx?=
 =?gb2312?B?ck9waEc2VVhyVi9ZQkUxUHZkNXZBY1NTY2FkRnZWRGlUNmM0SHN4TW9ycUpQ?=
 =?gb2312?B?M3dhV2tDWWdBZEJ6OTNlMHM1Wkd2T1I4MysvVWwvU0hKZ1NMU0FUVXlLQjhF?=
 =?gb2312?B?N0pBRmtaRStzY3pDN3dCUjA4OVQwNlF4ZEl2VGR3ZHZ4cWxSb2FkMW94SnJW?=
 =?gb2312?B?SS9RV1RUWnkrdnVDMHlUQ1NYUWRlY2c0dGo1TFFRRER0Mk8wV05PelVrcUt0?=
 =?gb2312?B?QXVxdktNMmxLV3phZjBJaENmS2I4aVFNTXFqMU4yS3Rob1J1dGpHUjU1bm4x?=
 =?gb2312?B?ckhORGNRelJiZnB1T1ZSTWZVcXBjWFQxS2RBeXpaV2huMDdYNTdVSVZ1RjJn?=
 =?gb2312?B?RlVZQldqN1dhcUUxbjdiOVk4ZVJGdzdWWlRZcm9tNVdkUTBSTmVldm1NaFBL?=
 =?gb2312?B?dnJpMksyR3JpN3A4OTdqZEdySCs0UlJ5Qm1XUlA0a1g1ajA1T283ekFCL3BY?=
 =?gb2312?B?R3BpaW9HY29JRGp5bUNyajZjbGlJeUlaT0RDeFNHdDBPam9xSmlFamhGZnpu?=
 =?gb2312?B?MUZzdndSVDRNTFdpRW1IdjYyb29vNXRnTURHZkplTWlwMVJ2bGg5T1lpd29a?=
 =?gb2312?B?c3JURnNPQzV3b2xTTnY5N3NwZklyMnh2RGJTakRiQitOd095RUREdlpldzdI?=
 =?gb2312?B?OXl3ZkdaenBMV3ZqdU5LQmNicmNJbVA1TTFDRnZuanJpdFM1NHphQ05ITGE5?=
 =?gb2312?B?VjNJK3JQcTY5TE1zTDN6bVFjNGFhdVpJb09pQWtXNHY0ejlsSnFicWZkcUM1?=
 =?gb2312?B?WFdlZWpuS2ZrdUtYbEExQ1NGTWZwWjNoRWwycjk4QU9iVENIbzNpVDh0Zy9p?=
 =?gb2312?B?d0RjTjQraVNSVGlrSTVHYkp2NlVRaVJ0L2ZSSG9qL3NDcmF4L3dkRUg5cm1U?=
 =?gb2312?B?eUtwbU5HSWc2Z1c4ZjN6VU1yS0l4ZEdqOStpU2dvaXB4Ry9UVHZDdTRJeHFK?=
 =?gb2312?B?OFJwMXJ6aEgyRGJ4V01OL1NDakd3Zmo2Vk9FajBPR0E1bWdtQzVoQldpSGp6?=
 =?gb2312?B?VytXQmsvK0hyaHJjRi9udjd6Si9XWVBUZzFIQU5Ca3FDZ0M3VTFJMDJqRU5m?=
 =?gb2312?B?QXVCbmdBRHJER0Q2cE92L01zZCtjY2w2WnBJZ2grQ2ZiK3JlRmRaeUt3SWc4?=
 =?gb2312?B?SHVOWG5vWjgrZUg5ZjRKVXN2Z2JrZTd2QXQ5UWdOMUd2MWpVSVRNd1FkZGdj?=
 =?gb2312?B?L1NlY0NaY2dBMU82eFJROUppOFJ4RXNiYzJ3ekVLMlFKcHZuSUt0V3ZWN0hs?=
 =?gb2312?B?MThiOXY5ZEEwb3d5bmkxbnZBQWh4amw0RW42azJIREZVSk9NSUpKSUV5c0Zm?=
 =?gb2312?B?cStBeFNLRWhKSjlqZ3ZUOEVjd3RjTDZ6YUJ5d1k2RTlIQzFSdmJOYWdqazRp?=
 =?gb2312?Q?MVTsr0mrKtw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?MWZqYzVDZnhyUFc5TUthTzY3M2gzOUM4MlRqNnBDdFhNbWwyT2hacVNJdTNK?=
 =?gb2312?B?YzdXRUVXaVlYZzltUjVmak56VGlkTExvdndHVEpLR2lXdFVCTEk0cFNtRWp2?=
 =?gb2312?B?RW4rcS91V2YrZEdndktXTE51eHhISnBLbVJJak8yTVV4L3Z3VjFkalEvRjBH?=
 =?gb2312?B?WnlSZXR6U1VHN05mUWdXd28xM24zRFJ5aXJOQnlCSG9OWE5WVUlQNG9vNU54?=
 =?gb2312?B?R25qc0dUUW9UNTU5ODBPdXo0SklwYnVsK3dqM1JUdm1iNGljb09mcml5Rmhv?=
 =?gb2312?B?dmRKR1J3VkVqYVRmczIrVWJwQWt2d24rcE8yVlpZRFFJVmVwSUpJODJVakVM?=
 =?gb2312?B?OXFHRng4U20wYzgwQ1ZYa1BLL3VtQnRYUW1heWx4R1F0R2l6QjJVd3p1KzV2?=
 =?gb2312?B?VEpQZW1Qc2tBcm50Q3JNS002WkJWQUJLY1ovQnl6M0tWNktOR2Y1djhlWEx0?=
 =?gb2312?B?aXJidkhDb2lvd3dEU0d1eHo1OVRaT2hpSXV4OE9WcCt3ZGhwdzUzS0wzRHJo?=
 =?gb2312?B?U3ovQXhKbHA0NDBVTUNyWWR1NXRpYmtlWTlmb0xtRVltMzUrbDVPUHMvOTNI?=
 =?gb2312?B?d2k4aFhYVXRuT0lwSk1qRzNLUUozRmZKSjZnOHo1dWFVeCtndkpMYk5wcFpt?=
 =?gb2312?B?c3k1SmV3SUsvZFd1dnF0ZDFQVlJDZFpsNkJ0cFdwTi9jNzB2L1lmMHVmYjZF?=
 =?gb2312?B?K2t2RHVhLys5WndBeUZWZmZpbE5MVkxZWVJYMEtPOVBuWkh3M3BCKy9RZGVx?=
 =?gb2312?B?WDR1azVJZVFhN1RONlNEL0Q4bTRVRHJuT3NEeEhnUEo4MzQranZwV2dGR2pE?=
 =?gb2312?B?Tm00bDA4R2VkSUNCYm56bWhUVkVwY0h4Z1VUNlVFSGtCMEoxWDRadTdxbG05?=
 =?gb2312?B?VElJVlp5VVROQzlHaTdyYjhJdHpwQzREYmtOOUNWM0Vuc2xLSmRIYnFySzJO?=
 =?gb2312?B?Y2Y2K1A1ZWFIUThJL0I5OVdtWWdvUHBlTHVwbFpVU2NBYXBhWnNmVTIzTkM0?=
 =?gb2312?B?U2xMNkVtbjRJNVl0azliYWhNZU95UDdrQW9rMjY1akhWRUlJdWJqSVlwWHRa?=
 =?gb2312?B?aXZYcXRyMjVnM29YS2dPNzZROUlEeURQb1dDdFpXZ1dZQjBucUEzT3NtUFNT?=
 =?gb2312?B?OHhoV3JmeHQ3eFFKcDJZbzNwQ3RNUThqZG50SEg0RmpYWkdlbEpGVE8yUUk4?=
 =?gb2312?B?aVFNWmg1OGN0YnRicWNBL0s1a1NLc1p6OEZuWUNkM1JNdWVGMk50NnNRdHdJ?=
 =?gb2312?B?ZHR1bzRvTFRxeklDZDU1VTN4ZkZzcnZHdy9DeXAwVnNDN0dWT0hTMnd5anpQ?=
 =?gb2312?B?RkN5UkhRenEvR1dtZ21SQ0JlUWdvYm5aOTZSc3dlR2g5bXZJckhyZW1Ub0dt?=
 =?gb2312?B?aVY2bWY2ODBtK3lZTEhsWkxxbkxFTk4wUG51V1FzRmRtNHpGVHU0N01sOUsr?=
 =?gb2312?B?bVZ5S0txUlZkSC9HR3BsTEFlOE5hZHN4YkZwWlA2UnRkNEd1RGI4SmdBMmZ6?=
 =?gb2312?B?VWNPYjFiQlR5TjRuaXRRVVUrZHF0cnlrckF1UjJ4NnBpR3J6dGJ1dys2Ky9T?=
 =?gb2312?B?THE2VmhvY0s1OXl2THB4Y016UWNnSFJ4NGxQd1RvZ2txK3JaU3FST21Dc3lq?=
 =?gb2312?B?VGhyOGdYRFlyTnZSNUpkRUwzQ01IUmhCUDI3eU8xdWRGdyt5bVRrM3ZRdEFZ?=
 =?gb2312?B?Rmo1SStxUndSblJRTVBIbmhQQXZSWTEvZTg2YlhRYXVVTXJrR2w4TnlmMndn?=
 =?gb2312?B?aE9aQk5SdGxQb0kxbFRwcENGaVA3ME41SFNLWWJlZGhKS1N1M0lSMEx2K0dl?=
 =?gb2312?B?YmJyKzlRVHB4dXJKVnVQQ0ljaTRxYzBrWFhQMGE0RkhNOWFhclI4anlBZEdl?=
 =?gb2312?B?SzFaN2pSM09mNUM3Mk84L0NuTXhuZmZsa0QwT0RGWGVmaGNxZ3JRWkhQRS80?=
 =?gb2312?B?YVRKSWZic2NramhDb0QrMlhzTGQ4ak02L0lZSzZqemEydlcyTlpTdmRWcG5z?=
 =?gb2312?B?U2s2S0tnb2ZwMnZYYTR1Y2FyTTZYMzNVM3pYNm1WSVlvMVhyMkkvbEo0czNF?=
 =?gb2312?B?aWlFank2NW1uTDM3MnRQaXpWZkVzY0hTUElEMDYydWlsclo1RkFlTmVHeG10?=
 =?gb2312?Q?HxvY=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea57f33-9b27-4c62-4212-08dcc800a25b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 08:00:22.8975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 27sPDdDTCeUpOIdPcSmjckSv9myWeYcwcR8BhpyZjchJ34ZABy3XNNImOgKyDlOX7NOt6NNeyef/4szCuufORA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7448

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBYmVsIFZlc2EgPGFiZWwudmVz
YUBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDI0xOo41MIyOcjVIDE1OjUzDQo+IFRvOiBtdHVycXVl
dHRlQGJheWxpYnJlLmNvbTsgc2JveWRAa2VybmVsLm9yZzsgcm9iaEBrZXJuZWwub3JnOw0KPiBj
b25vcitkdEBrZXJuZWwub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJv
bml4LmRlOw0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IGFiZWx2ZXNhQGtlcm5lbC5vcmc7IFBlbmcg
RmFuIDxwZW5nLmZhbkBueHAuY29tPjsNCj4gV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+
IENjOiBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgaW14QGxpc3RzLmxpbnV4LmRldjsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUGF0
Y2ggdjMgMC80XSBhZGQgTkVUQ01JWCBibG9jayBjb250cm9sIHN1cHBvcnQgb24gaS5NWDk1DQo+
IA0KPiBPbiAyNC0wOC0yOSAxMDo1MDoxNiwgQWJlbCBWZXNhIHdyb3RlOg0KPiA+DQo+ID4gT24g
VGh1LCAyOSBBdWcgMjAyNCAwOToxODo0NSArMDgwMCwgV2VpIEZhbmcgd3JvdGU6DQo+ID4gPiBU
aGUgTkVUQ01JWCBibG9jayBjb250cm9sIGNvbnNpc3RzIG9mIHJlZ2lzdGVycyBmb3IgY29uZmln
dXJhdGlvbiBvZg0KPiA+ID4gcGVyaXBoZXJhbHMgaW4gdGhlIE5FVEMgZG9tYWluLCBzdWNoIGFz
IE1RUywgU0FJIGFuZCBORVRDLiBTbyBhZGQNCj4gPiA+IHRoZSBORVRDTUlYIGJsb2NrIGNvbnRy
b2wgc3VwcG9ydCBvbiBpLk1YOTUgcGxhdGZvcm0uDQo+ID4gPg0KPiA+DQo+ID4gQXBwbGllZCwg
dGhhbmtzIQ0KPiA+DQo+ID4gWzEvNF0gZHQtYmluZGluZ3M6IGNsb2NrOiBhZGQgaS5NWDk1IE5F
VENNSVggYmxvY2sgY29udHJvbA0KPiA+ICAgICAgIGNvbW1pdDogNGI3OGI1NDc2MmRiZmMyZjIy
ZjI4NjU1ZmEzY2Y2ZjVkNTBkZTE5Nw0KPiA+IFsyLzRdIGR0LWJpbmRpbmdzOiBjbG9jazogYWRk
IFJNSUkgY2xvY2sgc2VsZWN0aW9uDQo+ID4gICAgICAgY29tbWl0OiBiNGY2MjAwMWNjZDNmYTk1
Mzc2OWNjYmQzMTNjOWE3YTRmNWY4ZjNkDQo+ID4gWzMvNF0gY2xrOiBpbXg5NTogZW5hYmxlIHRo
ZSBjbG9jayBvZiBORVRDTUlYIGJsb2NrIGNvbnRyb2wNCj4gPiAgICAgICBjb21taXQ6IDQyZGM0
MjVmYThiNWJlOTgyYmNjMjAyNWQ1YmYzMGJlOGIyNmRhODYNCj4gPiBbNC80XSBhcm02NDogZHRz
OiBpbXg5NTogQWRkIE5FVENNSVggYmxvY2sgY29udHJvbCBzdXBwb3J0DQo+ID4gICAgICAgKG5v
IGNvbW1pdCBpbmZvKQ0KPiANCj4gRm9yIHNvbWUgcmVhc29uLCBiNCB0eSB0aGlua3MgaXQncyBP
SyB0byBtZW50aW9uIHRoaXMgNHRoIHBhdGNoIGFzIGFwcGxpZWQsIHdoaWxlDQo+IGl0IGlzIG9i
dmlvdXNseSBub3QuDQo+IA0KPiBJIG9ubHkgYXBwbGllZCB0aGUgZmlyc3QgMyBwYXRjaGVzLg0K
PiANCk1hbnkgdGhhbmtzLg0KSSB0aGluayBTaGF3biB3aWxsIGFwcGx5IHRoZSA0dGggcGF0Y2gu
DQo=

