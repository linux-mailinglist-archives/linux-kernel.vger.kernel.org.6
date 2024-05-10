Return-Path: <linux-kernel+bounces-175503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BEB8C207F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A1E2830C5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842191635C1;
	Fri, 10 May 2024 09:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mSFLvbdY"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2082.outbound.protection.outlook.com [40.107.241.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E44170897;
	Fri, 10 May 2024 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332342; cv=fail; b=VohqNNq8WPyLkZZfNbFL+N5L67vG/dU1c3geFkjprc6Zot2z8UHhyNaa0uKuqxVn/GyTdNGIbTk5tnZo79LNTio46e0an5mrTn1iqm/trVVaEcVoG6mOeE3PAttppGkOgabAOMwfTLoVRv6I1xxB4P4RNkPhPSz418kr8r1zV6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332342; c=relaxed/simple;
	bh=PgxRlbUcS/uvOvhLhmHPrOfoWAYvLqu1YwJpsaINx8E=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=d2GbA0GqugqIiI6pRdfmQm46YYHMSIA0q+VJI7rQJPPn82S5xe4DDkIdOTs6y0HoXCyLrqGAwiQksw5UcYIyl2EHV0kt7hjUxI4YLtrxk6jEsNtRiI//B5HxHC3U+bzW4gkK8+zQw+nCzt56h1nywT5yuI8mOheza0pB9u8vL/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mSFLvbdY; arc=fail smtp.client-ip=40.107.241.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnJgTREHp3Sr5Oofj1n9inN7dNyDdkVUU0WSy+6xu/0b1UKmJKnDtB6mDxlf1BqdJVCBA5gMZ+NVbHJn4XHkOrVSvT+j+cGYe4/TEGqKdV9GvNknDZdD3fEGtNTT0tngJQwmt/mNul/LmtTi/5u2fHivncKMjg+cLvAL8Jg4Zbj+guRWu/a5njz7QXiBdFAFkBQ59wmwZ9apVxJGOA3xMyM2dvyAT/C+V0atDc3TH6dvDQk3VKVDA0eaVGglaN7G01GAgaHIhh/TD22dtzSGJ+jIB+RRCtypaRJqeNbEuAEmI2I2iO41BS600atsWSVEJ3KTbc70GvnyxLEJObLw1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZfg5qL7SHsnC+/O7PQKVa9Y6S4TDdYFXWK5DCJ1IFc=;
 b=REeGTpjqYfr3MvBCCGXhf2z8UKKp4t9izcULfzcCdb4Yo88iDAjU1F6mMMpX/pTMJhfP1Ytp2/PbTjUeITrdinOHPcLE6JryUFZBVpByVpdlEd1Hvi3XHFNkNv85g4Jg9yLPqJtu6VGlOqV2qmKftwk5y55ezOs0j2Ik3D6yAbL6syzyoe9h4jNS6Ypcj+w3hHpfi9zqeg4wMmilbyPNcTR9ynRkpSMp3yCmaQALEeK+eq3RQb3svgcitY3Dvm9ZOnnaEmlyArkxKxOt0Uro3W7PnM4FifpMg9IMsOdoC7ZHBifD91VUWZ9s/glCtGkrNWxjiWt75Y8E7BmQYqrWjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZfg5qL7SHsnC+/O7PQKVa9Y6S4TDdYFXWK5DCJ1IFc=;
 b=mSFLvbdYqXpvd86HFoNqEYKIeZd+4fSoLUkRdE2bttCWdOEAynhqpwj9LVPrkhemVVoECITvY0DUMx5cQXaZ7sYXa1O6yuHVA4VAQEBKIhLi786LqHUAJbkgtAuz56Do5v+udAz/pCoyTelbEP96pET5jJb517+Xtkpcgs99dNs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8065.eurprd04.prod.outlook.com (2603:10a6:20b:3ee::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 09:12:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 09:12:11 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 10 May 2024 17:19:07 +0800
Subject: [PATCH v2 12/17] clk: imx: imx8mm: Change the 'nand_usdhc_bus'
 clock to non-critical one
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-imx-clk-v2-12-c998f315d29c@nxp.com>
References: <20240510-imx-clk-v2-0-c998f315d29c@nxp.com>
In-Reply-To: <20240510-imx-clk-v2-0-c998f315d29c@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715332748; l=1404;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=5nMT2IffGwQHQ4in9ZnMD+FiKPbKEz5YS4WgB7bC2HQ=;
 b=ZJUhXx3qA81HYSActztb1LdS/GfTCtR5nxYPVndSLNyrPBO1l3uwUdmWrUnn9tjQFOXRxpjUx
 M9JecmK8DLqCcuKn2Js1MZmLAAQUyAUvaWEUlyo+o7m0iPw7Jbt4SDK
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e2b9be7-190e-4922-7ccf-08dc70d146c1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|366007|1800799015|376005|7416005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHZ0ZDZWU21yU0V4UzhlK0I5aWJhVGRlaTFURFNUa0tJUE8yTTJ5VzhSY0My?=
 =?utf-8?B?b3NYbHk3ZHp5UTE1aThCT2tGaDFDZWVLYlJydFpqb0U1K0FZVnVhY2Rtamwx?=
 =?utf-8?B?elB4TkZZdHhFS1RDMVZONlVpNWdPV01lMW9wL1pZcU0vcGprczVkUzVZYTFD?=
 =?utf-8?B?c1Y1dVpwRGx1QVVIVURGRFRSMWtwUGJHdUY5cWE0TUZTaGwrS2dvMjlFOTMr?=
 =?utf-8?B?endKYjRTSUdib0tTWXUyRHB0cXkySERCYTVrTldvbmtTdWxOdUs5WkhBUk81?=
 =?utf-8?B?bktNMENJdmZWdm9LenpmMWdLSFRkMWxoR0ppeTNTby8zcWo2UGdhN1Z5L3Ny?=
 =?utf-8?B?eXplZDRNR0l3SHpYMHdPb2dSTmNSMnJOcSs2aDZKSnFqYnUvcWVOaGVsZjha?=
 =?utf-8?B?UFlXMkdWcTlpR1BwUVZEeGpGK1hqRlIybGRzTG5oN0tZYm5oYUh2Q0pQeUpN?=
 =?utf-8?B?UG1uUmZMNXoxRjBGSzhrYjBrVUU4QXNsaXRLY0ppT3dvRHR1RS9Hckh0aVBl?=
 =?utf-8?B?emZkQ3pVZjRVMjhOcjJITjRuMWUyV21aWURnSVRKNFpnOFRDTTMrbU1xQ1FQ?=
 =?utf-8?B?Ni9jTklrd2VucldSOEw0L05hazBJdWwrWmd5b3hMR25RWERZSThqb0UxV3pz?=
 =?utf-8?B?U002QjZtUEhVd1JBeG9kQWQwNS84SjVaS2lXTDdXZ0JwcW1VUnU1Z1A3S3FZ?=
 =?utf-8?B?RU96aVpuekloTEMyYVA1dWtvb3dHQ09ZSXVscnRWaWQ3M1NQM3B5bmxQb3Zw?=
 =?utf-8?B?YldTTFBhNTJ0ZFd5ay9jT2NxWUYydTFkQUJ1WWpwcXZwZ2VFOTRoL1NtQkls?=
 =?utf-8?B?Y0dYSUZoWEd6MWhxclBlREpxc09KbzRsYlIvcmlmMEt3Rm5tY1E1eHVDTWtr?=
 =?utf-8?B?U3p1UG9DbVd2Rm5qL0g2cUNReXpNS0lSQVFIeHQwVmhiZWpNZU0yQzN4NU1L?=
 =?utf-8?B?Y05NaTY1SmozSEJ2MFdhMUJsVjZwRW5RTUt0OTNUL3VkVUFnZ2xJSjUxb0Vq?=
 =?utf-8?B?Ync0M2poTG5CUS9mbDdZWDY3WmlEcXUwczUyaVhtTVVsRmlNUllQUzZJWERT?=
 =?utf-8?B?NkY3TUM1ZzhlT2FjSkJnZm1CMzFIN2ZrZkpCdHNjNGRuYVdnRzB0M2pzZDZl?=
 =?utf-8?B?Q3pxdVhBZVRmSWl3MlVuZmVXbCtyb2ZlYjF1Mk1LdGdiZW5xUDdSZithZDha?=
 =?utf-8?B?d0NUZnZpOHRBWVB3blYxSTN2WXFzQTE0Y1kzSHRxL1NhTlBQSEJqeFdoMnFY?=
 =?utf-8?B?ay9CK21YdTltTmJGcXFhOFpGRmd1TWFYc2dMaDNrdWJJZGFtYWhjYzM3a3cz?=
 =?utf-8?B?RDZwQzZ3TTVpSEluTmJSb3BtV2E4SWlIZmU4NmZPb1NwaEdLdFhYR0xtVDBt?=
 =?utf-8?B?QnUwcTV3TUYybGVOWGd3UGF5VURwTUd5MHpxWmxYV2hlRFFVUEVZZzBqMnU2?=
 =?utf-8?B?MXRGZGhaTmhJbnQ2amVyclhsWis2bXVjNXg2MFBSRGMza0c2M0xvYU85YWo5?=
 =?utf-8?B?UmVWRk10cU00WlQycWI5MXpBWGEzSkw4UytQZlB1YUFkYjBUdXhvN3FOYnRs?=
 =?utf-8?B?R0wzdU5PcVo4ZmV5VDVzM0tKNUFIVXpZd21mWCsydysrSnkzazBmeWdYLzJZ?=
 =?utf-8?B?K0ZKN0M2Y0R2cHBCODJhc0lza3JmbHR4Mmd6SDRLUzhiRUpRZHYvUWFtTkpI?=
 =?utf-8?B?SXdMdWxMR1A0OWFwRTNjRWEzVklxMTZBR1ZJbzJEN00vbHVpQ3NwSUE0a0gr?=
 =?utf-8?B?QzJDajBVTU14OGl3UWFuN1RQMEN3YUVlbkk2YjRNOU9UOW5YSmJ2bWZWa0tk?=
 =?utf-8?Q?YPt1SSnexMENvklCnRCPrPkO1WJVJocbBWbOk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(376005)(7416005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzliY0l3VllMNjRWVksvMjErZU9MYUFENGhYaWs1dEtmWStUNHJ3VGFFVlVO?=
 =?utf-8?B?WGlNbVhObUJaNUkvQXZJN1ZXcjE3MDNDRGlyaExvY0p0dUZ3WDJVUWNpRTVQ?=
 =?utf-8?B?dFlvZStKY3BnNmc3K3l1b2EyNWxhaUNjQmYrZ2JGczhqdmkvakUxNG0wWmJB?=
 =?utf-8?B?SklDenlmSXNFeUtneHlkTGRxdy9IbUkxbmo1WHhzd01oSks3WWlFM1JhRnc3?=
 =?utf-8?B?aUFpaGZGRUhxc0VGQzErSlBDVzN6RGwvWWJoL0ZxVXlLeXBnT1Y2VitaaTNZ?=
 =?utf-8?B?bGJETnNHWXplWjY5MGQwSVFRUUdJRTNIRjZ3NkdTK0xPZmJtTXB1bXRYUlN4?=
 =?utf-8?B?RmMvSmd3UGRsMWY2SE5EREtlNHVib3BtTUlITU80QVIrSVNYWTlsY3NSZlJl?=
 =?utf-8?B?WUhFWittc094NUV2N3V5VDZKcWxOK1QyTmlUYTFYQW1mUE9rTWRGczBtL3dS?=
 =?utf-8?B?UEVTVktRWVVKR1lTdXZFTjFsbEc4NXlJc0VqdGx6ZTNCWGVNeGQwWmFsRFA0?=
 =?utf-8?B?ZFJSN1hNNXFZSGpJSGlQUHcwbDQ3NEZDYlBHZ2wrd3JuaStnVjNqU1dMRHRS?=
 =?utf-8?B?NXgyOXgvK3kwQ3pSaWsvRThnK2pkTEpjc2dBUUZMRWNUcEJhTjBEc0JqeVNS?=
 =?utf-8?B?NlVueXdRSHNhSkNNaC9mOVNDMWpUdldWY3UzNmJFajRScm9tN3FMRXQ5RmdB?=
 =?utf-8?B?MmV4R25QME5PTmRVQkdKVkxwZXF3RW5EblQ1WS9kQXl1b3cyUHhMODhMc3dE?=
 =?utf-8?B?YzA2cGdPVHVrYVNPV1Y5QkVUdUJveUZjN1BFb1BzOFpzV0xubHROYTM2WVRY?=
 =?utf-8?B?di9BRGcvSTcyNDNVeHAyUmNlcWRCdTZMS0J2WWM4d1BQeGp1NHkycEVkZWw5?=
 =?utf-8?B?d2hJR0Z0bkZvblBQbk84Q0JQRGl3VTgxWnp2VjVjWkxtS3h6YVJDNzQxVG5P?=
 =?utf-8?B?ZHhZa1c0citHaGR3bzRDSDM1Z1VpMStLWlhSbVRhRGNyQk5RSUNZbWI4RzFI?=
 =?utf-8?B?T1ZxZVNhdXFDK3lUakV6QlYwRTFZUEN0Sjd3c0NYR0U3Uk85ZHhHNFp1UWF4?=
 =?utf-8?B?ZmlFMlBabDlibHpaZnVWVWpQWnVRcTczTXJFWGx2VVRNMTNOUHNsL1NyeXBt?=
 =?utf-8?B?Y1R6MHR1L3EvV1FBK3FrM1F0andDSldLd0M4NlhVT2xGaXVNc2UxdGhVSEM3?=
 =?utf-8?B?UmFZd1VxQittQUY0QXA5QzdSMGY0elFTdjRZeWtEQmVReDZSMVdhbDNtZm8r?=
 =?utf-8?B?K1QrZ1N2L1lkeVpCbmljNHhrYXBLWnFnTW41Zlc0NHFUOExVNW93U1NCU1Ir?=
 =?utf-8?B?REQzVmdhTFI1ZVZuTTRKVVZPQ09rRFR3anR2RzlFYVdqL2RSejFobkFlcEJQ?=
 =?utf-8?B?OHJyanJld25YT0RVaU4rQ09BWFkxZ0s5eW83QXJaM01uZG1uT29QVHpvN3JM?=
 =?utf-8?B?ZE84R0h2akM3T0RyZ3NkSWsrbmk2b2Z4Qk8zNkJYLzZJQ0RVTUNWNFd3TXBI?=
 =?utf-8?B?RzdBb21vMnhXWkhlKzFoc1R4TkdONVpFWjlXUHNyMkZaZlZMbExxNmk0MXk0?=
 =?utf-8?B?UUV4T2xZRjhWSlJ4UmpFb2ZSNkJrU2RXNE00ZUNENnlBSlBFRHhwVnY4cU1j?=
 =?utf-8?B?WkNpZG9kNmpNUkxkNkFjK2tVK0pHTWdyamplVDRGSUJNQ25KemRKSWt4RHE2?=
 =?utf-8?B?Sk54NXFkLzhjTDJzK2wvTkRvVTdsaTZoc3hGbnhyaDJyVUZxY2VpVktiU1pF?=
 =?utf-8?B?Nm1sV0d4NnNtdTVma3FEbGVyeEFHYWczU0JmRGs0TUFoK0lVRjAvL1J3TXN4?=
 =?utf-8?B?WDQ0RWpkSmdMTTFqamZHZWpjb1pYNkxwTkRUNTJLaGJ1eUFlSnJxajZyK0lt?=
 =?utf-8?B?cForT1BhbWlzYlozei9uYmgvOWpZRHk2bVdmQkVIK3NpbEVIMkM4aFBQSFFH?=
 =?utf-8?B?VEs4bGh6d3hoTG5FTUxRazhjUEZWb1FobHFOa1BrK3p2UlV2eWdWd3h6SC9E?=
 =?utf-8?B?M2s1blpuTzBNeG5jSjl2MEt4T3ZPTlNKbWRZc04rNHRqdHBmTlNDSmd0VjdE?=
 =?utf-8?B?Qnc0Q2RXVXQ2UjdvZmhPR0tvRGxVWDNiSHlSN0hLOUNHZjVzVTNWUjRuTnNq?=
 =?utf-8?Q?6iFJaL5Ci4hYA+Yrr+pMJG2Ma?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2b9be7-190e-4922-7ccf-08dc70d146c1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 09:12:11.9118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kyhfrAytnbId7HQ+hENJ5z1KJxahkAwzxSjeTnBm9npkUbOwztiAXxhzHIimxx31VqhtVFDh5syxMYhGkAVzpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8065

From: Jacky Bai <ping.bai@nxp.com>

The 'nand_usdhc_bus' clock is only need to be enabled when usdhc
or nand module is active, so change it to non-critical clock type.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 075f643e3f35..342049b847b9 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -432,7 +432,7 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
 	/* BUS */
 	hws[IMX8MM_CLK_MAIN_AXI] = imx8m_clk_hw_composite_bus_critical("main_axi",  imx8mm_main_axi_sels, base + 0x8800);
 	hws[IMX8MM_CLK_ENET_AXI] = imx8m_clk_hw_composite_bus("enet_axi", imx8mm_enet_axi_sels, base + 0x8880);
-	hws[IMX8MM_CLK_NAND_USDHC_BUS] = imx8m_clk_hw_composite_bus_critical("nand_usdhc_bus", imx8mm_nand_usdhc_sels, base + 0x8900);
+	hws[IMX8MM_CLK_NAND_USDHC_BUS] = imx8m_clk_hw_composite("nand_usdhc_bus", imx8mm_nand_usdhc_sels, base + 0x8900);
 	hws[IMX8MM_CLK_VPU_BUS] = imx8m_clk_hw_composite_bus("vpu_bus", imx8mm_vpu_bus_sels, base + 0x8980);
 	hws[IMX8MM_CLK_DISP_AXI] = imx8m_clk_hw_composite_bus("disp_axi", imx8mm_disp_axi_sels, base + 0x8a00);
 	hws[IMX8MM_CLK_DISP_APB] = imx8m_clk_hw_composite_bus("disp_apb", imx8mm_disp_apb_sels, base + 0x8a80);

-- 
2.37.1


