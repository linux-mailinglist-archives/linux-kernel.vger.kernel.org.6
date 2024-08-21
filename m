Return-Path: <linux-kernel+bounces-295038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4609595F3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 09:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB962824E9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 07:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0270E18BC3A;
	Wed, 21 Aug 2024 07:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="amfV1pIQ"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012027.outbound.protection.outlook.com [52.101.66.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F711B81C5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724224859; cv=fail; b=EjDoQT1BooAyohuAfobSw2f1qPyQs8OEPB1sHYLrEmKanA8ZKWud/dBQ3JWc2YlZQOWAvxW49h8beTMYf+bIvFgLFq1YTJ58yM5VlOOEbjbm2eGt25qZxqlX23d7SBskPVnBY/Sg9Ex1EybWZP7KwzZD6roHZRWco69qcYsETXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724224859; c=relaxed/simple;
	bh=+RQX8ok7vMYyGoLlJkz5/9WhZMwQk7lca2UnfczZdgk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C5miJN5dSaFooexCtMY6eEVYAo555iSPlBfvxi5TAib8kHSoRdakzfKW19xKfEtywruB+fFw50zkWhA3v7UirtlHhOWoXJzKzWKOBWljwpsirHbppDll1aAPot23pXtGCDnhlJSmFLzUa0f1PCM3YSEQasSnNRzLtL1GLLHA4us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=amfV1pIQ; arc=fail smtp.client-ip=52.101.66.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VailZrAjdioc2mv8U38MtNarji7va/WArpd7umgew+wy6siSr/1I2uYjHs9zC1Dz8R7wrMUirxIGyDrH7xknXe2/JPx72U+//p72VINdLdbCSOX1qCZ7neGy64uhybbt0XPNJ0coDy2XuM3RLN1z9zTVosLq1jrlzfUNtyWt+ax7QuvjcdlFrWZ1Nbf+pb7yjYropgpYGLxViKG4c30jsn4Qi6LEkrOjpKW6/YXM2mchp/ZROtEuuVJwHlHD9ll+bkaXZ1wbSVYvQwvDOQ3sL1mjr3RxhVUxK6+6APgrkcVisdzQ7lBGDHnnwE6nDA9BENNHir7nNm+umewvURUd3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RQX8ok7vMYyGoLlJkz5/9WhZMwQk7lca2UnfczZdgk=;
 b=GriXHI9ltVHTxkEp0zwpjs2SW0PBR8AM/zhbv1tzVlXmCkl+TwaXfRukD9sUoFICieZKOJ33ekUcr5zlzID15e0iwqLcu36u8AHHUfvZfeNJZRFF8pcDkNLnbCMBz/7m/wEnMriRWfyOPSwTTONsyHc/mUo3KEAxAi+sOR3htlxGdF/hYqRebH/rW9UCi95skIpCJMqQkyuo8EUen41fAyueKUO0P0uRJ8NU9o6tfcPG7gRQJ0/wcuWnJAJpR7W0NOF5FUQE4f/XaZmM5BqUbeh9B5R26UrcrrzzsOi/g+utHv1UNOjxzDKbnOoPwbJjFeTAXM+jzyqq1fiAdvWNIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RQX8ok7vMYyGoLlJkz5/9WhZMwQk7lca2UnfczZdgk=;
 b=amfV1pIQaxX0g1byGbHxkrXWxARJtwb+KbHboyY5h3+P/g7bd3PT8UjSUrZSBi9TvsNIoc8v8gd8eZqGd1yv8euL9GCTHCuqkiPYjgM+xjg2iiAq/8dn56YXCGWBm5HtXZD3bhCETSe0+hBNE/w/RVTD571E5/iDvRTge8PRtJR5Dx1jKGThkvPpkVAq0PEmyjzQTDYdziTAoLDBffWapGLidx2JYNI/sfiaYC24yZiUI/CSScq7T9gVguSyKrFHc1xSOpD5SNIg/T/rWFD+hgO3ai3aApiHwHVSt6i2ToqBPE5Noi595NTGg9PDei261NesFmn9/JOObTl1dsAdsA==
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by AM8PR04MB7858.eurprd04.prod.outlook.com (2603:10a6:20b:237::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 07:20:54 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%4]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 07:20:54 +0000
From: "Jacky Bai (OSS)" <ping.bai@oss.nxp.com>
To: Frank Li <frank.li@nxp.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Aisheng Dong
	<aisheng.dong@nxp.com>, "open list:CLOCKSOURCE, CLOCKEVENT DRIVERS"
	<linux-kernel@vger.kernel.org>, "open list:ARM/FREESCALE IMX / MXC ARM
 ARCHITECTURE" <imx@lists.linux.dev>, "moderated list:ARM/FREESCALE IMX / MXC
 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/2] clocksource: imx-tpm: fix return -ETIME when delta
 exceeds INT_MAX
Thread-Topic: [PATCH 1/2] clocksource: imx-tpm: fix return -ETIME when delta
 exceeds INT_MAX
Thread-Index: AQHa3smqUXtjDwmI8Uma5p8XQ+bedLIut9sAgABZzACAAl/OkA==
Date: Wed, 21 Aug 2024 07:20:53 +0000
Message-ID:
 <AS8PR04MB8642A2B327ACDF7EF9BE2CC5878E2@AS8PR04MB8642.eurprd04.prod.outlook.com>
References: <20240725193355.1436005-1-Frank.Li@nxp.com>
 <b88b6200-b92a-4cf3-946a-3c38cff886ec@linaro.org>
 <ZsOSNC/5BvTQAiAe@lizhi-Precision-Tower-5810>
In-Reply-To: <ZsOSNC/5BvTQAiAe@lizhi-Precision-Tower-5810>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8642:EE_|AM8PR04MB7858:EE_
x-ms-office365-filtering-correlation-id: e7b000ef-7578-47a8-32aa-08dcc1b1cb0c
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aHBQbFFOWFowaWlXcllKVm9ZTGZHRXF6dEhMSEVJVVN2U2JXYitxTlJLeU56?=
 =?utf-8?B?ektzZzRzTGV3SS83UzRBN21OL1V4dFk4STVwTGQzL0MxRG5aWUtXb1NVcXFv?=
 =?utf-8?B?bjQ4ZUtrWm9CYWVQdmswQTErWlg2WmM1U2hXUEEvTjlTbFZoSVVsRXk4d2Ex?=
 =?utf-8?B?MkZyb0ZFMFJEdXZwQ2hNMTN5Qm92MG9CQXdFU3RLUWhOYkw5d1ZkT094d2Nx?=
 =?utf-8?B?THhobVBRZlk5bkFObzBvbDN0ZHpUS3J4ZlIxcUZPczNnZnA1VndhZk1KT1hJ?=
 =?utf-8?B?UFdxOWt3SkZPVmNRZkt1YUc5aHJBek9KRlhQNzJyNEVpRHZpdTllV2JSalJK?=
 =?utf-8?B?L2Rjclh4SlJvOGtFaWlKaEV2bTh5WG42OGhRUFF3ZlJCajJpSHB1RHVOMmJ3?=
 =?utf-8?B?bVA5Mjh3N21MS1J3dHA0RWFvK0NoUEJncG9yUnhYWmJ0Y3IwZDBrL0xVaFBT?=
 =?utf-8?B?Q1NTdXl3b3hiZ1A4WEdPRFNVc3JLak9TM0Q0NFAxdUh4Y0lsdy8zcXRSN3Zy?=
 =?utf-8?B?VnRCd1BMaFVYcEF0VDVFSHZSUmdteXNkMFUwbE84RGRSc0NuQkV2b2VIOEFj?=
 =?utf-8?B?Q05keE5zVnN0cWVxVk1FU1pkOWdyNWg2eXZMc0NXNjY2dGUxQjlPZVBUSmQ1?=
 =?utf-8?B?VHB2ZVZudnVMVythSnZ5QlJBSzB5eGg5VGN0RkVuNTBvZXhHQ2tmVjA0d3c0?=
 =?utf-8?B?N3JxWVZJZGVqV3I0OHllRVJ3VDJhY0NGUXpjeUphYlFHdUZObEhrN20rVVJa?=
 =?utf-8?B?dFhFaytKVkFuVFhnaEk1NWpIbzV4a2tCK2x3Q2Vzam9NYWJ2cCt4SDNFd1Qx?=
 =?utf-8?B?b21COHN2eThrelNOcFk3OWYvcmxFejdKRU9KejdFdjJscndXRUJGUGVSU2tz?=
 =?utf-8?B?MXJ6emNLR3lZK0llengrZitXamhXVUNLb1Jpc1VZZFFjaWlkQkNMMWhUb3BK?=
 =?utf-8?B?aDZnbU56UnpMUEpwWVN5T3M0VStkcWpBYmJTNEo3Z25FRjUxUzRxa1Y2UERi?=
 =?utf-8?B?MmRxSU01cDZIQ09vUUJKaHFkelpNYkpuSnhxVjNTTlMvakQzRlUyQnZtMkh4?=
 =?utf-8?B?M0tPT3NXa2NHRUg1Zk5la0ovQlhHTVVZUkhpQ3lXVXdoVmdIZit2c2pZRWhR?=
 =?utf-8?B?OGYxaEVaR09scFJYVTFTS3laczBHaVhsdXpEU3hINXFKZE9SdVN3MTBhajIw?=
 =?utf-8?B?c01rNDZmaUhiRExrNjVTdThGZzhGL0xQMEdERFBjM1pYTUZKVEYzbEV2enBY?=
 =?utf-8?B?dEp2enYzT2JlWi9leWkxK0pwSXg2d0lPUFZuelBMRlowQlFWcFZzZkY2S1Yw?=
 =?utf-8?B?aEdscGM0eXdEOUo4eXJMWU1Zbk9YWnYvRUVZbkZyeHpNcng0N1JxcFlXS2s0?=
 =?utf-8?B?aHZYa3RDdGc2aUxIRVIzWnZYR0RCR2pVVmdhb3F6S2llRE5aNGlFeGUzT21m?=
 =?utf-8?B?SU5Qck0reXlzRFQ1cHhUL2VEUUY2SWxFeHBnSlJibWpXZWxKdU44SkdQRVVY?=
 =?utf-8?B?cHQ3RUJUWCs2M0FlU1NmU2ttNWxTWCtzMlFaSUJPUDF2elVHVTMwczVGbnM0?=
 =?utf-8?B?SHhlVVRBTllrdVVBMmE0VXJwSkNCNEYwRS9TWjhoZTIzM2ZwNVY0TFkzVCtm?=
 =?utf-8?B?VnVoZWVSM1FnTkRJMURhMjFCc2RzcXhtVWxFZHBzMFdORDdDOWJUWFRRa3U5?=
 =?utf-8?B?M0RsVlB4ZHhJZDIzY3p2TlEvd3JpVm00aXBlVlhuZTd5WVBPM1lhMWczd0RL?=
 =?utf-8?B?R0l1ME4xUTlLbm1vS0wvRnRPMzlVSUM1ZStOWDRZakd6c1FuU3dDWGF6SGpS?=
 =?utf-8?Q?NveoUnDPmIGUddiCRNK1c5y27HMa7pc3H9ABQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RjhxVFd6YWJKVVZvRzh0bzMzWHFVN1dmSmxZNGxVUXdZUkdsWExBRUVWNHM1?=
 =?utf-8?B?UnlhRUduVU9nTmtMK0xJQngwYXZMeEJnTjRPTmRMTmw1K0gyU25wN3VqdzJW?=
 =?utf-8?B?ZWhuckdIbzk3T09BSFJBTTU0aTBqZDF1VkR0TW5xSkFwanlGMFB4UXlNaCta?=
 =?utf-8?B?THRmUmZ0OU0zR2trZXlCbTFQNHFEbkp3ZERzZFhleHF4NENvRnd3V2RZeDBy?=
 =?utf-8?B?MytZM2duTHY5RElrNWI4L1JpNzZIejh5RW1rcjRDVTZEaGpRQnZpMDZaOHp5?=
 =?utf-8?B?V29CdmR6cHU4MDAxUmdMNFovZWVlL3NxUVVoU2JJV1lrSHZhU1dmSTZJek1p?=
 =?utf-8?B?a2c5MWxNa3ZSYjI3dHV6RmJweGtaMDBLUnE2OWZzUkI4aDR6eHNZcDFiQ1U5?=
 =?utf-8?B?MENnN2VRZzl0U0ZVVDBSQWIxOVhGcjdmYkhRVDdMc0w1eVU0dGFXNWNJTHFP?=
 =?utf-8?B?MDhVTUI2akI4czhqSEljWTl3MUVQL2VWQTFQdE9BK0JwcTIwR3FscjErTlBC?=
 =?utf-8?B?SWZHdHJJR2Z5VlY3K1pnM2owTUhoR2tVeEp6dTZ1MXpQTEJZMDRKdkVQYXBO?=
 =?utf-8?B?b0lKUjViWDFrbHVTbHViWHFMNkxERjRhR2Q4Ti9pVzB6dk9HZjJEYzliUHpa?=
 =?utf-8?B?amkvK0JJbnBtcUpPcHNWUjc1cWwrcHM4NG9YMENtNnVMT1JQdE5EOXhPVHFZ?=
 =?utf-8?B?N0VXNzRhQzBKMlZZWlZpSThCWXhZOFJIdnhxYThhQ2dEKzd3SysvbGFVKzd2?=
 =?utf-8?B?bUl5aGdzZWhpSVRGcyt2cHp4eS9xMmM4c2xpSXlzZ2pBS2Y5WHdpdGJJTWVQ?=
 =?utf-8?B?QmZKaGtkRG5mdUJ1QW53eUVzaSt2WURKSTJLWVowWCsvTjZyWGFLUTZQMi8z?=
 =?utf-8?B?QWpWbTFBbWl1S0R3RSsrWEJFNVFWUGM5VVRFSWFnZHp6czlGbWVFWmxKeHEw?=
 =?utf-8?B?cVN5b0hYb0hFOUlzbis1Wkh2WU0xeVQ2eDhOSkg5ZzhITDRSbU53Tmhxbm03?=
 =?utf-8?B?VVYxeWZVSjgvdHRMRmhFdGdVWmE0cXRGU1lUNmdMWWxuNE9ZRmNNVVBReEUz?=
 =?utf-8?B?YW5aQnYwalUwYlNVRUoyZy9zNThaRmorZ2JwOWZ3TXIzZnphNk5DbGFObkc3?=
 =?utf-8?B?bjRteU9GNEdMd2NvTFFyT1NOcjBnenhXVk5mbzRlQWJxTUp1MmY0cmVaVWRY?=
 =?utf-8?B?L0w1czlscFpPQkNCRktDeFVCemFXM0VlRUg4V1N0R0twT3o1QmYrMWZBazBT?=
 =?utf-8?B?VGhPcGFMeUFtbG04dU5zMkcrb2UxNXFUejMzMmxWdk5INjAwajREM2hwdHA1?=
 =?utf-8?B?c0tCeHF2MEMxMnpVT0pOeCtJNUllTUljRmRJWHNYamF3cmxFMXQrYSs0U3E3?=
 =?utf-8?B?R2NmZ0dKZkFxcmpXM2dUVThHaHBORmozY0hVWHJRNFJiTFVMWXBZWXY2d2p4?=
 =?utf-8?B?bUpndFFUVWNScUJsSWFsbG9GdTZSaVF2ank0aHEwY2FTWmpEblJPakkyTzlU?=
 =?utf-8?B?TmNubzY5RXY2Ri9vQ1VyYnhCYVlXZW9SSXlHTWs1ZDFJUHUrTnF2STAyanlN?=
 =?utf-8?B?ZmlEc3NkWWxjcnJaSUZlQ0NsT1pRcVBBclJCcUtNTW9VQyt1Z25sMDN2NUR6?=
 =?utf-8?B?NnRUNzd6T2l5bVA0R3ppdlMrczlGMG1RSldrOVhnRnNJeVdNRDdXaTJEVVo0?=
 =?utf-8?B?VSsvV0dtT1NiYjVTZlhJVVNZUmdpZVFZYU44NENMdGdpNklDOVBUWjIwdjlE?=
 =?utf-8?B?RzlZYld3UEFlSlE4SWFMdGFuUEZadm9BSWJHOFFMUHNuczhxTlRCSFRKbnRl?=
 =?utf-8?B?YTdPQ1dpSUlxcVhSUndZQ2dkeDVhbUtNZnpTRmZ6VWF6VXc0M295cFplaWJo?=
 =?utf-8?B?VVM3aXhOQTZKQU95ZU5yTStJc1kxWkFGVFdPOW5TaHZPQzFvejM2dndYc3h2?=
 =?utf-8?B?WWQ0TlgzSFllZm9kV3liOFVJWVQ2Y0J1dUhDOVpFQXRLSUZFRDNvK1AyZjJY?=
 =?utf-8?B?Nm5pK1F0TkU2ZFZuL1NLOHpBZ2VrSzJJUWZ1ZFIxa1FZelI2NCt5KzM2OHhm?=
 =?utf-8?B?Z1JwS0svMU1Wb2x6TU5zWW5BNFlhRDB6a1dLbzZuZ3BQTFllQm5jc01BNHBC?=
 =?utf-8?Q?6rVk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b000ef-7578-47a8-32aa-08dcc1b1cb0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 07:20:53.9503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sYzm/Kytew4fbofzli7rMpJ/iaa/WVtNBAyYPYL01Oe+mQGxPswL+84LVn7QUn+Ru4hmUfOq1Aj1BKrFEbuzVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7858

PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gY2xvY2tzb3VyY2U6IGlteC10cG06IGZpeCByZXR1
cm4gLUVUSU1FIHdoZW4gZGVsdGENCj4gZXhjZWVkcyBJTlRfTUFYDQo+IA0KPiBPbiBNb24sIEF1
ZyAxOSwgMjAyNCBhdCAwMzoyMTozNlBNICswMjAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToNCj4g
PiBPbiAyNS8wNy8yMDI0IDIxOjMzLCBGcmFuayBMaSB3cm90ZToNCj4gPiA+IEZyb206IEphY2t5
IEJhaSA8cGluZy5iYWlAbnhwLmNvbT4NCj4gPiA+DQo+ID4gPiBJbiB0cG1fc2V0X25leHRfZXZl
bnQoZGVsdGEpLCByZXR1cm4gLUVUSU1FIGJ5IHdyb25nIGNhc3QgdG8gaW50DQo+ID4gPiB3aGVu
IGRlbHRhIGlzIGxhcmdlciB0aGFuIElOVF9NQVguDQo+ID4NCj4gPiBJcyBpdCBzb21ldGhpbmcg
eW91IG9ic2VydmVkIG9yIGZyb20geW91ciB1bmRlcnN0YW5kaW5nIG9mIHRoZSBjb2RlID8NCj4g
DQo+IFN5c3RlbSB1c2UgdGhpcyB0aW1lciB0byB3YWtldXAgZnJvbSBsb3dlciBpZGxlLCB3aGlj
aCBjb3JlIGFuZCBsb2NhbCB0aW1lciB0dXJuDQo+IG9mZi4gLUVUSU1FIG1heSBwcmV2ZW50IHN5
c3RlbSBlbnRlciBsb3dlciBpZGxlLCBvciBmYWlsdXJlIHdha2V1cCBmcm9tIGxvd2VyDQo+IGlk
bGUgdXRpbGwgY291bnRlciBydW4gb3ZlcmZsb3cuIEkgYW0gbm90IHN1cmUgaG93IHRvIHRyaWdn
ZXIgdGhpcyBwcm9ibGVtLg0KPiANCj4gQXNzdW1lIHJ1biBhdCAyNE1oeiwgMS8yNHVzICogMHg4
MDAwXzAwMDAgaXMgYXJvdW5kIDg5cy4gUHJvYmxlbSB0cmlnZ2VyDQo+IG9ubHkgbmV4dCBldmVu
dCBiaWdnZXIgODlzLCB3aGljaCByZWxhdGl2ZSBxdWl0ZSBiaWcgbnVtYmVyLg0KPiANCj4gQW55
d2F5cywgdGhlIG9yaWdpbmFsIGNvZGUgaXMgd3JvbmcsIGl0IGNsYWltIG1heCBkZWx0YSBpcyAz
MmJpdC4NCj4gDQo+IEphY2sgYmFpOiBhbnkgYWRkaXRvbmFsIHN1cHBsZW1lbnQgZm9yIHRoaXM/
DQo+DQoNClRoZSBpc3N1ZSBjYW4gYmUgdHJpZ2dlcmVkIGluIGJlbG93IGZ1bmN0aW9uLCBpdCBp
cyBwb3NzaWJsZSBtYXhfZGVsdGEgd2lsbCBiZSBhc3NpZ25lZCB0byBkZWx0YSwNClNvIHRoZSBv
cmlnaW5hbCBpbnQgY2FzZSBsb2dpYyB3aWxsIHJlcG9ydCB3cm9uZyAnLUVUSU1FJyBlcnJvciwg
dGhlbiAnY2xvY2tldmVudHNfcHJvZ3JhbV9taW5fZGVsdGEnDQpXaWxsIGJlIGNhbGxlZCB0byBy
ZXByb2dyYW0gdGhlIHRpbWVyLCBkdWUgdG8gdGhlIHRwbSBsaW1pdGF0aW9uIG1lbnRpb25lZCBp
biBwYXRjaCAyLzIsIHRoaXMgbWluX2RlbHRhDQpwcm9ncmFtIHdpbGwgbm90IHRha2UgZWZmZWN0
Lg0KDQppbnQgY2xvY2tldmVudHNfcHJvZ3JhbV9ldmVudChzdHJ1Y3QgY2xvY2tfZXZlbnRfZGV2
aWNlICpkZXYsIGt0aW1lX3QgZXhwaXJlcywNCiAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wg
Zm9yY2UpIHsNCgkuLi4NCglkZWx0YSA9IG1pbihkZWx0YSwgKGludDY0X3QpIGRldi0+bWF4X2Rl
bHRhX25zKTsNCglkZWx0YSA9IG1heChkZWx0YSwgKGludDY0X3QpIGRldi0+bWluX2RlbHRhX25z
KTsNCg0KCWNsYyA9ICgodW5zaWduZWQgbG9uZyBsb25nKSBkZWx0YSAqIGRldi0+bXVsdCkgPj4g
ZGV2LT5zaGlmdDsNCglyYyA9IGRldi0+c2V0X25leHRfZXZlbnQoKHVuc2lnbmVkIGxvbmcpIGNs
YywgZGV2KTsNCg0KCXJldHVybiAocmMgJiYgZm9yY2UpID8gY2xvY2tldmVudHNfcHJvZ3JhbV9t
aW5fZGVsdGEoZGV2KSA6IHJjOw0KfQ0KDQpCUg0KPiBGcmFuaw0KPiANCj4gPg0KPiA+ID4gRm9y
IGV4YW1wbGU6DQo+ID4gPg0KPiA+ID4gdHBtX3NldF9uZXh0X2V2ZW50KGRlbHRhID0gMHhmZmZm
X2ZmZmUpIHsNCj4gPiA+ICAgICAgICAgIC4uLg0KPiA+ID4gICAgICAgICAgbmV4dCA9IHRwbV9y
ZWFkX2NvdW50ZXIoKTsgLy8gYXNzdW1lIG5leHQgaXMgMHgxMA0KPiA+ID4gICAgICAgICAgbmV4
dCArPSBkZWx0YTsgLy8gbmV4dCB3aWxsIDB4ZmZmZl9mZmZlICsgMHgxMCA9IDB4MV8wMDAwXzAw
MGUNCj4gPiA+ICAgICAgICAgIG5vdyA9IHRwbV9yZWFkX2NvdW50ZXIoKTsgIC8vIG5vdyBpcyAw
eDEwDQo+ID4gPiAgICAgICAgICAuLi4NCj4gPiA+DQo+ID4gPiAgICAgICAgICByZXR1cm4gKGlu
dCkobmV4dCAtIG5vdykgPD0gMCA/IC1FVElNRSA6IDA7DQo+ID4gPiAgICAgICAgICAgICAgICAg
ICAgICAgXl5eXl5eXl5eXg0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgIDB4MV8wMDAwXzAw
MGUgLSAweDEwID0gMHhmZmZmX2ZmZmUsIHdoaWNoIGlzIC0yDQo+IHdoZW4NCj4gPiA+ICAgICAg
ICAgICAgICAgICAgICAgICBjYXN0IHRvIGludC4gU28gcmV0dXJuIC1FVElNRS4NCj4gPiA+IH0N
Cj4gPiA+DQo+ID4gPiBUbyBmaXggdGhpcywgaW50cm9kdWNlIGEgJ3ByZXYnIHZhcmlhYmxlIGFu
ZCBjaGVjayBpZiAnbm93IC0gcHJldicNCj4gPiA+IGlzIGxhcmdlciB0aGFuIGRlbHRhLg0KPiA+
ID4NCj4gPiA+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4NCj4gPiA+IEZpeGVzOiAwNTlh
YjdiODJlZWMgKCJjbG9ja3NvdXJjZS9kcml2ZXJzL2lteC10cG06IEFkZCBpbXggdHBtIHRpbWVy
DQo+ID4gPiBzdXBwb3J0IikNCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEphY2t5IEJhaSA8cGluZy5i
YWlAbnhwLmNvbT4NCj4gPiA+IFJldmlld2VkLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNv
bT4NCj4gPiA+IFJldmlld2VkLWJ5OiBZZSBMaSA8eWUubGlAbnhwLmNvbT4NCj4gPiA+IFJldmll
d2VkLWJ5OiBKYXNvbiBMaXUgPGphc29uLmh1aS5saXVAbnhwLmNvbT4NCj4gPiA+IFNpZ25lZC1v
ZmYtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgIGRy
aXZlcnMvY2xvY2tzb3VyY2UvdGltZXItaW14LXRwbS5jIHwgOCArKysrLS0tLQ0KPiA+ID4gICAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4g
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLWlteC10cG0uYw0KPiA+
ID4gYi9kcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLWlteC10cG0uYw0KPiA+ID4gaW5kZXggYmQ2
NGE4YTg0MjdmMy4uY2QyM2NhZjFlNTk5OSAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvY2xv
Y2tzb3VyY2UvdGltZXItaW14LXRwbS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL2Nsb2Nrc291cmNl
L3RpbWVyLWlteC10cG0uYw0KPiA+ID4gQEAgLTgzLDEwICs4MywxMCBAQCBzdGF0aWMgdTY0IG5v
dHJhY2UgdHBtX3JlYWRfc2NoZWRfY2xvY2sodm9pZCkNCj4gPiA+ICAgc3RhdGljIGludCB0cG1f
c2V0X25leHRfZXZlbnQodW5zaWduZWQgbG9uZyBkZWx0YSwNCj4gPiA+ICAgCQkJCXN0cnVjdCBj
bG9ja19ldmVudF9kZXZpY2UgKmV2dCkNCj4gPiA+ICAgew0KPiA+ID4gLQl1bnNpZ25lZCBsb25n
IG5leHQsIG5vdzsNCj4gPiA+ICsJdW5zaWduZWQgbG9uZyBuZXh0LCBwcmV2LCBub3c7DQo+ID4g
PiAtCW5leHQgPSB0cG1fcmVhZF9jb3VudGVyKCk7DQo+ID4gPiAtCW5leHQgKz0gZGVsdGE7DQo+
ID4gPiArCXByZXYgPSB0cG1fcmVhZF9jb3VudGVyKCk7DQo+ID4gPiArCW5leHQgPSBwcmV2ICsg
ZGVsdGE7DQo+ID4gPiAgIAl3cml0ZWwobmV4dCwgdGltZXJfYmFzZSArIFRQTV9DMFYpOw0KPiA+
ID4gICAJbm93ID0gdHBtX3JlYWRfY291bnRlcigpOw0KPiA+ID4gQEAgLTk2LDcgKzk2LDcgQEAg
c3RhdGljIGludCB0cG1fc2V0X25leHRfZXZlbnQodW5zaWduZWQgbG9uZyBkZWx0YSwNCj4gPiA+
ICAgCSAqIG9mIHdyaXRpbmcgQ05UIHJlZ2lzdGVycyB3aGljaCBtYXkgY2F1c2UgdGhlIG1pbl9k
ZWx0YSBldmVudCBnb3QNCj4gPiA+ICAgCSAqIG1pc3NlZCwgc28gd2UgbmVlZCBhZGQgYSBFVElN
RSBjaGVjayBoZXJlIGluIGNhc2UgaXQgaGFwcGVuZWQuDQo+ID4gPiAgIAkgKi8NCj4gPiA+IC0J
cmV0dXJuIChpbnQpKG5leHQgLSBub3cpIDw9IDAgPyAtRVRJTUUgOiAwOw0KPiA+ID4gKwlyZXR1
cm4gKG5vdyAtIHByZXYpID49IGRlbHRhID8gLUVUSU1FIDogMDsNCj4gPiA+ICAgfQ0KPiA+ID4g
ICBzdGF0aWMgaW50IHRwbV9zZXRfc3RhdGVfb25lc2hvdChzdHJ1Y3QgY2xvY2tfZXZlbnRfZGV2
aWNlICpldnQpDQo+ID4NCj4gPg0KPiA+IC0tDQo+ID4gPGh0dHA6Ly93d3cubGluYXJvLm9yZy8+
IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0NCj4gPiBTb0NzDQo+
ID4NCj4gPiBGb2xsb3cgTGluYXJvOiAgPGh0dHA6Ly93d3cuZmFjZWJvb2suY29tL3BhZ2VzL0xp
bmFybz4gRmFjZWJvb2sgfA0KPiA+IDxodHRwOi8vdHdpdHRlci5jb20vIyEvbGluYXJvb3JnPiBU
d2l0dGVyIHwNCj4gPiA8aHR0cDovL3d3dy5saW5hcm8ub3JnL2xpbmFyby1ibG9nLz4gQmxvZw0K
DQo=

