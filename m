Return-Path: <linux-kernel+bounces-175509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A7F8C208E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3EB21F213AD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1213B16D332;
	Fri, 10 May 2024 09:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mBzVoZj8"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2060.outbound.protection.outlook.com [40.107.241.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55386171644;
	Fri, 10 May 2024 09:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332366; cv=fail; b=EaVkmkt8DwfQb98tCtyiOdtSkQVYrmFJn5QftFu8CB7VTLgjcqxcT4kCvzBtZjLNwLq/2bJErck9CJ/o2SzAOTST87YAcKpX28c9+0yJ0jR1qOQhjIFOBSM6KRx5lGtO7oeC1SasaE3WIbyBI8Pzja4DgJprL7HQ+V84mQlChMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332366; c=relaxed/simple;
	bh=LIgsjKhvPsQ/Wke1XoRmOQwn3YqqnKKetqjIr+h1Gx8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gWXqfOAk49q/VltN/sn4mxvRYlh4c4q9bR1UyMHkOzaAN21Pm1n93CV2aignxQ9UkAxLZ+vTq6klw/VhyHVPIHlz5DUo5iVlKolZbuRLGeC/nG9Mk9pVvdle1xW09PoLsCkzG8Eo6IY/vFI3ElGUrC/vVJC2y0QD1h2DW6WLK7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mBzVoZj8; arc=fail smtp.client-ip=40.107.241.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7xRV2cPkygIlYdtXaHEVQ4abPo3l5WKojDauOjsANtZevNAZCc4CJ9Dcz+jv1GvooO4OwVlgiwkMA3e5Vrs0bCUoMDfdSUDRcqf0mJJmw2KJKhT6SAbrZg1Gnz22xTtdCXFaxgeFq5NtmUg20TU81OfmSkQJWEcT0opahTigonmLx3PPlh9Vqs5fRhye7LTh0DRhfnlugox7rEQt66WxL1R7aL9LweXsNj+9W4nX2cHZAwW9XHV3w9dA2wAGn1Byp85E6BHx1keR3EC92S8V5g8IfBI4czALCaGYOrB7j7YyVaHdY7wZOCNwMnjSb08h/BWTzQgwoGfi/9hkNj+0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Xbc0TOfAlS9LPLGccHITUNQDuUBFJQrLHuLiwGMTuY=;
 b=F1drtFFdH+mbXOOUUqV7SvBUtPnA13tZZvSQhgdP00wBlwPYt7M/9UuDxfLLsiFL/p5lk6DWMlRIGj6X3cWGrA/I0rA87IJUvbfUCMlvejUdZttsNkzV3/BEyopfpiRTCVzfU1gkntZqSAprrNMAB9VyKF/9b5OlqPNXno7Go6hNFPNggDvZpmvbkx++iSvKuW28wj/eBr/s4NESUvvbV1+2uCU/9+6CkhfXNJREpkLRJd2kyJwQkwsi0Vrs1OP72997lcDNUlt+lS4SnJhPdwjC03BAGOazmUSNO00XXuUCSR1bm6pZQ6NWdS+EJbSHgFrVm97dIaKpU5mgBBGlcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Xbc0TOfAlS9LPLGccHITUNQDuUBFJQrLHuLiwGMTuY=;
 b=mBzVoZj8URYc3B2wS9yeMcQzA3KPBG2YMNHcNfGgT/tul7sEIw+U5kNf5GnZF6lz7bT7ppVMUaduhQh1IBPQRteJ3oCcuRwUypg+eXpRiYyWMl2aNw/q+v5lFzCQm7cWdWjg31XPl79qUsqPpYUzOCL1+qMyjZ3CXULHGkLmm1g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8065.eurprd04.prod.outlook.com (2603:10a6:20b:3ee::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 09:12:40 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 09:12:40 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 10 May 2024 17:19:12 +0800
Subject: [PATCH v2 17/17] clk: imx: fracn-gppll: update rate table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-imx-clk-v2-17-c998f315d29c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715332748; l=1217;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=fgOtqAw+FraHuW4UTB8xhgz6F79BoqMSj9Ycinx3ytQ=;
 b=MzOraOXKo0x2j0Q4P2ptJBbcY5Z8MfCff6fTNtB8DYnvmhotRnquZfgm17Rbf9gMEd9KwZo2G
 JsC3KP/13fnDxmL/epbQsFvu7+Wx4RgZVXxkRcBJiUUQ6Wt1WJ3QCac
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
X-MS-Office365-Filtering-Correlation-Id: 9d1ec767-d79a-43a7-8a5a-08dc70d1578b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|366007|1800799015|376005|7416005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWdPWGRJK3M4a0s2QThlT1RWS1pzZ0VkcXJPb1JRLzRCUXhXbWlqVmYrZkdN?=
 =?utf-8?B?anZZdjg0TmJZVWlzdGFXRGljaTNWY0NmUlQwcVFjUGk5eHd6L24yek1IclZz?=
 =?utf-8?B?ZVJ3Titza0xNTEtMdUc5NXZLNXJrd1dVbjZuVXJPQUJnbTI4c3FVdWhaSzNM?=
 =?utf-8?B?eVR6ZDErMmpZcFhYOFA5Z0R6YkpPMm1aMTVmNzFHa3A0ZFNNVUJhNHFSUVVG?=
 =?utf-8?B?aUZGTkNyeldvRTVlTEZ6Zk5YVEo0MFFWdXRISm1YWHZWbVhCdy9mT3pLaEZF?=
 =?utf-8?B?SWlWTjU5aWxqRDZuQ2w4UThiVHJndXBKQUI0TnFNem1DSDU1c3lESDJnRC96?=
 =?utf-8?B?bHRyMC83UnBlMEIyY2lRdFlhNWhEb3NzbEdBNmlmTlppZ0dzMW04aU5mdkU1?=
 =?utf-8?B?YXp0dnZqaDJtYjNrMW5GemkrbzNqeUVXWk5IZzI1UlhVSTBhZ0VsanA2S1RO?=
 =?utf-8?B?aEh6KzljWDJKUHE5UCtWYjV6OXg1Y1d2MVRsYWVxZExuVVIxb1I5ZjBnejNs?=
 =?utf-8?B?N3RKRENJVkVnSHRZVFdBUCsyRE1TT1pHNGNqZmw5MWpFWUxsenM0WHBmcXZS?=
 =?utf-8?B?Uk9UQW1IT3J2NFU0RCtMQVR5OFRNT2NPdGsxVnU1VHlqMW9xNEFhZzdVdWZH?=
 =?utf-8?B?ekZXOHBsMUdOUkk0SHZUMTBES1BTcGxOc0QrQVJQL1FIR1VBZGhXc2FVR3Aw?=
 =?utf-8?B?U05ZcHlBbVoxNFRGS09yRGpWdFkvb0dERHRseS9RNEhaVWQ1WHBBenVKeEph?=
 =?utf-8?B?SjVlajJEZDJGUjFqVzQ3eEFiL1NZWjhjeENUaHdoOVBqUmtrWDQ4NHdIMkdB?=
 =?utf-8?B?dlp0ckwxaEErS09zeEZRZlBWMEpqZXdSdjlKcldtUGlyUFIrU1RxRFc5QXZZ?=
 =?utf-8?B?TlN2MW8vWTFlL2RJNCtZOUVja3ZLSTBXVHZMTnJkSFN6bTJoYjhRdHFGbHhs?=
 =?utf-8?B?R2s5emxuK1IrZGtUQURscXc3dGljem1uT0JDdHN2bzF3S3hpQnpHeWpseW52?=
 =?utf-8?B?RVdsVEtHczJ6N3JCeWlxVlE1eTF1SzBGaDE4c0lTWlFQMWxrM2w1bDdidVVD?=
 =?utf-8?B?WjFMa3hJZzYrQUNyK2R5VDVGNWVReW9Dek1LYlFDeFlLMWJSZHhWTjVrc2FS?=
 =?utf-8?B?bVR6Nmc4UzVkVGMvWnlSTVJ2dytTUnJzMFJZVFVadXdkYSt3UExsZjJRVnRS?=
 =?utf-8?B?a2tYdElkQUhWdWx6aC9OeGs1RHgwY2xjUWVJUTRWcC9DYUsveG01SXRMR24v?=
 =?utf-8?B?ZVJDTktrYU9RSmRuQ252SEEzYm51Y0xqeFYzRzdGbmJNd3gyQ3BkNEx3bDNq?=
 =?utf-8?B?ODJLdVN2cTA2U1djMWJIbHdwUmpNbGErdmJseUV6LzB4MHNIclJoU2VhLzFy?=
 =?utf-8?B?cHpZb0I3V0ZOWnJrc2pzV2dKelRjQUxlUFloalJ0QVU2clBhZjRxUWVWZVI4?=
 =?utf-8?B?aVM3OXdWUnB6TWtYT2V2ZHpOd0N2Zld5WlpmOWxoYTBxRWltNm0xUHA2NGxV?=
 =?utf-8?B?Z212Rm42ZDA5STZZTVNmTmpCclU1b1JGZE5sbUYvZlpzWWVrOUhCNGNrc0tk?=
 =?utf-8?B?M0RUa2pVbDVlZzdFWnZ5a2dIL3lEUXZ2MzZVLzd2cW5FeHR4RUhmYkV6bzRZ?=
 =?utf-8?B?aHJHVG9McWh5WXhReXFINnlYaytBVjU3MktWWnlXUzB0VS9JYkNrSlpjSS80?=
 =?utf-8?B?UzdhZFZTbVlWRlU4cWExQVhkc0ttMGdVcXFneEVIWGU1VGhzcnBnM05XRW9x?=
 =?utf-8?B?ME90WmNzaVhaU1JRUEVVMlFrdmdac0JiMEtUQUpKcFNRMmIwRE9Ma0RDaWdQ?=
 =?utf-8?Q?IoL9XpA0y9LUIj6ohMKZYQWiVBcEoux/iA2Fs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(376005)(7416005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2lBK2dxZDcrRldSVGpiQUhpdnhHamgvQ01uQzVSYks1cWIzQlJvZ3JZQ3Jz?=
 =?utf-8?B?WmU3L2VZYjVIMjhKamh1K045b1Fwc3pQK1RoNVpMbjU4Tm53V2MranJ4L0p0?=
 =?utf-8?B?TDVFbit2bzg4NHgwTkNOS0VXSkdBNGtCZG5tU2s3ZndSUkdkZHFJcDNUMGk3?=
 =?utf-8?B?a3BuRnlZb1E1Z3k3RUZtYmdRVGJXMkVFV1VUWVRYS08xbTg2NGxOb3U1RHBj?=
 =?utf-8?B?TjN0c1Vnb3NWdm9NdCtHU2lUM1R3QnkyN0NwWWcvYUJLZ2s1M3M3Q0xPaS8r?=
 =?utf-8?B?c3pPNlcwUDVoTTlJRVYwTXF6VkxjT2toU1JNN1NiVnZVSDRhVDFyRXRVNWRa?=
 =?utf-8?B?WEdjZTljampEN3orTFRlZFVTbjdwQmNvdEFudURNSjhMbXdtUFdzY1o0bzNU?=
 =?utf-8?B?SzFLcldKeEhhcDFVamJTd3hFUFVMdDJBM21XRVNqeEhGWVNXcC85Ym0xNnBD?=
 =?utf-8?B?QTN0c1FVdTdoSjhLaisya2VuMGtWSnYzYTMydTErQllneTBqdVB0YmxDekVX?=
 =?utf-8?B?Y0hxU3hPdjJaWW45UFFaNkR1dVp1dEhGT3ZjTEtETjVQV2V1eDhabUNjQ1F3?=
 =?utf-8?B?aEUwNkdVbDZCMGJPTy9ldnNuZmRCdi9kaHlGSkVlNjMwTWRzdWhvZzdLbUlU?=
 =?utf-8?B?MDVXMVN4UzhmMHV3cHVNcmx6TXNZTkxBOWpleGlITjFSNlFXNUE3NWdPNWky?=
 =?utf-8?B?Y28wZWRSaGNKR0s1VDUwcEt1dTQxWk5EeDlkSU1RaVkyNTVHWHlpb25BTWtD?=
 =?utf-8?B?U1JPM1NCT0NDSC9ON0RZa08vcGFObisrT05HREYvM1VSV29qQkgzekh1M0ZR?=
 =?utf-8?B?SWtPeWdQbURNRmp3a2Z3YkNEWXdHV0RDclhyTlRMSTZpKzFOT2pQTVNZQkxR?=
 =?utf-8?B?NjMySlNnM25SMHV1WjkveXVPY0hmV3pDeWZKdlI4c3pPYytJd2xKaStxTGhZ?=
 =?utf-8?B?UzVXYk53LzI4am5KTGdzazM2R2hiOEhrOHNyY01tdXdTekh3QkZ2R1d2VVkw?=
 =?utf-8?B?THhSb0R1UGhxVGxPZ2hTcHJvZDRvTjVzNU5sYUFiMDVnam1CbkwybkNER0J4?=
 =?utf-8?B?Z0R0bUpFY0NoSzgybGUxbG5BelhCbloxbmkyZ01rU2NzVGMxcndDK3dEaVdk?=
 =?utf-8?B?WS85ckphU1BUUWVtVWYzOUJIS0haSjdUUithcG9sWWRGMWFPb1VFSDRjRUsr?=
 =?utf-8?B?K1dNT29zemNOZzZOWlQ1dG93N3lzSmtkdFBwUTNKbytJbTA0Mk1pOVQ5SXF2?=
 =?utf-8?B?Y0o5WVFxVXdIRXlkN2NNRHZTS0VaSVNYVWJlRVRHc3hxQW45WGlBM1g1bklr?=
 =?utf-8?B?Qk85QnhxdWJjWmU2dVRseGVZSFhnZ01iRmp1MTFDU2pmRkpMY0FiaGRjZFdC?=
 =?utf-8?B?U0hqRTA4ODdOYXhxbkNiYllwNkYySUFhTXFKdWJkT1Jwc3lRTVZkZmUxV0R5?=
 =?utf-8?B?R0x3VWc5ZTlBRHBsQjhNSC9XaHNXZUpXVlVkSFVSeEszTklYVTZKWUM2Ti9U?=
 =?utf-8?B?c09WaVNTMWd3ejhkanJUVHdQeDA0dmRyZ0QzVHptN0Z0QllaQTJlck9TUy85?=
 =?utf-8?B?NGc4dDhwTlhrTWttaXpoaWIvY3pwNFR6bTR4VkdOdzhTMGpCNXk2UmlWUlI4?=
 =?utf-8?B?eFVjakNST2JFYkNnUXBVNkpQY08zb01DWEd2TjV2ZXFsYlR6cW1nM3piZEFw?=
 =?utf-8?B?dzYxSDBVN3JuSERpNExmbG5vZEdNY1BxNXJoU1c2cG4raVIzQ2s4N0tzOUxr?=
 =?utf-8?B?L3ZYVmRCMjJqWlczd0pxNndsRkNKcStmZFpuSkFUVWQ2dEhTbE5qSDIyQ3pI?=
 =?utf-8?B?bGFKV0pXTDJxMkkxSUl2TGRmZkZScjE2SXdJd2hkZENJZmlQVGhtRTg1dHdz?=
 =?utf-8?B?R1A5OWViUkEvWUppRUU0N2NRL0liWHJhR3htQjlKbGNjQXpnYkxreERTOEFZ?=
 =?utf-8?B?Z1lvL2taL0hXRWgydGFjc3UycVFSS0FraUdBWUZ1QS9qRjZXOWI4YkVIRkl2?=
 =?utf-8?B?UTNBTGtFTTVyaE9YWE0wVW5FNDB2RFZLdXlJMXowTndaZzNrYmZ3SVI2SlFP?=
 =?utf-8?B?dUkvdjFGdzdEWkdzaHZkS1RGZUw2cHNCdGtBS2dIUkYraG9odDlXTkpqd3cx?=
 =?utf-8?Q?CzdBZSjDLtFjhrbWSVb77Bbyo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1ec767-d79a-43a7-8a5a-08dc70d1578b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 09:12:40.0336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 599JclCOA4ZfxSYs5D7BPegWCKD4R5BzL1BZNHYm1hIDxsf7A3S/apQ0SqPbBgURkHWNfcQB7U3MfHd/lrbXGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8065

From: Peng Fan <peng.fan@nxp.com>

- Add 1039.5MHz clock for video PLL to fulfill the LVDS display
  148.5MHz * 7 requirement
- Add 800MHz clock for ARM PLL

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-fracn-gppll.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index 1becba2b62d0..591e0364ee5c 100644
--- a/drivers/clk/imx/clk-fracn-gppll.c
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -78,6 +78,7 @@ struct clk_fracn_gppll {
  * The Fvco should be in range 2.5Ghz to 5Ghz
  */
 static const struct imx_fracn_gppll_rate_table fracn_tbl[] = {
+	PLL_FRACN_GP(1039500000U, 173, 25, 100, 1, 4),
 	PLL_FRACN_GP(650000000U, 162, 50, 100, 0, 6),
 	PLL_FRACN_GP(594000000U, 198, 0, 1, 0, 8),
 	PLL_FRACN_GP(560000000U, 140, 0, 1, 0, 6),
@@ -106,6 +107,7 @@ static const struct imx_fracn_gppll_rate_table int_tbl[] = {
 	PLL_FRACN_GP_INTEGER(1700000000U, 141, 1, 2),
 	PLL_FRACN_GP_INTEGER(1400000000U, 175, 1, 3),
 	PLL_FRACN_GP_INTEGER(900000000U, 150, 1, 4),
+	PLL_FRACN_GP_INTEGER(800000000U, 200, 1, 6),
 };
 
 struct imx_fracn_gppll_clk imx_fracn_gppll_integer = {

-- 
2.37.1


