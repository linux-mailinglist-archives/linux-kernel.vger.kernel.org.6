Return-Path: <linux-kernel+bounces-355427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C969C995210
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE15A1C211D1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893081DFE14;
	Tue,  8 Oct 2024 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="AQa0K5b0"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2131.outbound.protection.outlook.com [40.107.103.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9631DFE0E;
	Tue,  8 Oct 2024 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398429; cv=fail; b=Of2mQXHBBCTiP9zbSnT9XSM2o3wenK0jeSVmsnreTgabc8BjPlmB+KgjpDbLI6moivcy8lvU3wvlhl/R50iCq87CJecPOHwklWfvGYT53/gjQEB5vjodTR/kqxJpvBXqV+9dDlf057cvSLPaut5I2W3qb2LHH1x8P4chsv2CTWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398429; c=relaxed/simple;
	bh=0vmboFC8KB2rCGFzjtAu198ft+bF4TGinWKtB6Vm48g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n4w5kynYuvyBLaDv7pY2nrct7tKSun158Zbqdd1FyB3+afRWkKTpsW988s3hmguy8hmwMaze7aWjPXmPViqXVVFBkSwumin1+FASCqh+ZrH9qUXklKDoa830oNHHII14lWMcuD/IjEFZBJGMQpaVSC+Pj54KJVYIZgm6mEMQwUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=AQa0K5b0; arc=fail smtp.client-ip=40.107.103.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sqjg+AJs9Rj0v6T9VPtt2lnky9AWDi5nK+RvfL1uKm+PQBd1bGZ1sJj7B+2eXFO3x4UiP4UVYQl5kQ5QuIJyxCcAvdzwW8+GEVpgLlLuFqJzp4ZT1Ygf9fQKGPFEaIaOfLtbBCh1F8/6d7Kr/KKDB2xfzWUsSRf16ZotOW46o67sKJsqgskASKB490wprwbaiSoBznjVblPgC+dQC59w6ThjeKQ9r7edrGEWdHQYVjfkJlhjhlR6EqEGC50ujruEEszhsq2Le+e+mPaNzFBK7DQk1H6LZNY7xbIgCbapFwJEmYY5uAzoeoX4BxR/fvFsK/32w9a1DoEJ0WFNPEmE5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxzZ+USzun9nwtxqLM4L5Wh4gQBkEA7pmdBNCPmast4=;
 b=PbKQ0ag7zU5p5uZ4dZD2QMCBL3sEtx1+MlYulaDyXuMCSisds4Bam4wU/LgzrW8MmjPNkaPrwyTFm2NVP9Lw0qdQULNmeOBoj8pSaPBAifj412BSQlPZVRhpfJVuXQsc2Mu9R1nFSlnaQt3LBhVONvsAnWliFCoaWFUIcrZyZbbF6afo+4LdfH0Muy0Mgn8H9/yVMa6f4BHgCjBMndQxvqsdQ0LzbBNUIZXSt1lyIZqWj/QjMbfq644MspGoChWqqX9FNFo7+n+aOPANUnXeJuUlQvxUwg70UD0WWn73cO8xuIF6uDxlBhpRzSwWEvjhugYGfoOiOJrTzwI7jFPeWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxzZ+USzun9nwtxqLM4L5Wh4gQBkEA7pmdBNCPmast4=;
 b=AQa0K5b0JLEaCD1+i46ig6DYElAhZbERaSmI9mNeibZq4cJjwtA0oyhtd/4C0ws7if/ljcGWqscB4MZ1m2YBdjK5/t5Gzl1bETb17Xab89jO0jcXTc9ZdxZ0nuCpW3puk2zOzxDjkS/XpVKDYgm6FSIISe6qOnt2UslN0FzSbjw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU0PR10MB7459.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:424::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.15; Tue, 8 Oct
 2024 14:40:19 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.8048.013; Tue, 8 Oct 2024
 14:40:19 +0000
Message-ID: <fdacf768-f37a-465b-ab5d-1b22f3e12861@kontron.de>
Date: Tue, 8 Oct 2024 16:40:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] arm64: dts: imx8mm-kontron: Add HDMI and LVDS
 display support
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Frieder Schrempf <frieder@fris.de>, Conor Dooley <conor+dt@kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Conor Dooley <conor.dooley@microchip.com>, Fabio Estevam
 <festevam@gmail.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Gregor Herburger <gregor.herburger@ew.tq-group.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Jessica Zhang <quic_jesszhan@quicinc.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Parthiban Nallathambi <parthiban@linumiz.com>, Peng Fan <peng.fan@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
References: <20240828074753.25401-1-frieder@fris.de>
 <3280f47c-f1e4-4e12-8b48-4e5f68b7a606@kontron.de> <ZwT1tUhrO/avFG+4@dragon>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <ZwT1tUhrO/avFG+4@dragon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::17) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU0PR10MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: 67351849-87f4-46d6-12a6-08dce7a721fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEJMWjZqakd1VWNKRDNGOWJ4Nzc5YlN3WFkrMkdlTzBnakVqNHRBaXNJRkl2?=
 =?utf-8?B?QzhGd0Zrb21LOGc3OVhRb3l2b1dKd3dIcEZsb1RVZUN6d0NObEIxajA2TTNj?=
 =?utf-8?B?UTdvN25UMEdzeGlST2p6SUZ0cTBpc09aWWp2UzlRd29MbEdpRXNRbElCNzBH?=
 =?utf-8?B?akdCZmY4V0labms1Y0FFdE9SeW81NW1QZnkyY2o0RWhETlBnQi9pRi9NeCtP?=
 =?utf-8?B?TDJWV0JQais1SU9rNHlJMzQyWTJhSG9nMVF0ZE5JaWdDaTlIOHlDTCsvNEtM?=
 =?utf-8?B?RHFwNEFuRGdGQU9TNDlsSmtPUWRvT0p6NHVTQm5kazlrUkQ4MTdaZkx1S2Ey?=
 =?utf-8?B?eEhhUjIvZzBTVUpxYVBzQlk3OStJRG1vR095R0U2cC95WHdKL291b0FUOFd5?=
 =?utf-8?B?MmVYcEM2cjQvbkRZQ1MwQkNjUm0rTUh2d3g4QlZ4cEVxM2o2SlRUVnVZczF4?=
 =?utf-8?B?T09ZWk85eWdRQXdjQ2ZOS1VKeVVoeWdXNUEyeVRwNDR1SEF1emRvYU85bWRB?=
 =?utf-8?B?eERsMnV3amhGMnd5NVYwaGRDZVJsS1h5akVxYmVmcGpzakxuNlgwRUpmai92?=
 =?utf-8?B?b0JzSThydG9rV2lDd0lZRjVlS2RmVUcyV3hrWW92STN2SDNZWDVSL2EybCt4?=
 =?utf-8?B?QzdaMCtZOWl4eHdEeDlQc2h1bmpuNGtGam9iNGR2V3ljRkRHdFNPN0VQUWNN?=
 =?utf-8?B?elVjNEtTdmQ3ZTBKOFIxZEJhdXhQWTc4QjZnMmRobGRuWnZaVFlSa0JQY09v?=
 =?utf-8?B?OWIxeE5lNVh4dlZLZWREYTRNVFp5SzhsMkdid3dRY3BHMUZoNkFTQUdzRjBo?=
 =?utf-8?B?dnJyUGJobUk0VHo2THlYV1BuRUladUx4a0JDU2MwbElXbys1ZllWK2c3clZD?=
 =?utf-8?B?Wnc2RUh0bm9TaURyMm9vQUxyb3pEQWdNZGF5SWhoUEpUUzJ4M1RTVUQzYzV3?=
 =?utf-8?B?MGt0WUN1V2hzTlVESmkzQ1o3bGlwR0J2Ry80Rm5tVUw2MHBsUnIxZDBPZko4?=
 =?utf-8?B?TkQ4a0V5QXEveHp4UHExM21rc2lsSzhMei93b1ZhYUh1WUVaQVhGZmYwUUtC?=
 =?utf-8?B?ZS9HK0NPL2pETHFDQUhtazFlVnRvYXZ0UGFQTnU4cW1tS2pvZWxPTFFlVkRq?=
 =?utf-8?B?djlnTzVORDdSY0w5aVpwYklMTFNFbDdWM1cvb2djTWdOOVlSeUZ5L0R6Wlcw?=
 =?utf-8?B?Sk51eExqUFM3eER5RmVWTlpKdHFIVCtQU3oxSXB2T1U4b3lXSTRxakY0dUo4?=
 =?utf-8?B?ZEp3Z1BhQnRJdThJVC9XSEtNbkhYTWc2eWU5RW53Z01QL0xMYzNncjQxbjhX?=
 =?utf-8?B?RDJOT0tkMkU5b0tWcUtXVzNDVy9NREo5VXRPNXl0TjRjeWovamUvRnpUcU1J?=
 =?utf-8?B?akp6RmM2WHpqcWIxUWJIcDJ0K1h1TjVJaUVHZ05aa1UraGhrMmRlRm5qdUxk?=
 =?utf-8?B?Y1lnVzkzWEFWMEo1cXA3UGJ4azhoOGpqUWFVWmdxZDJIRHRvVTkxcVYxbnhX?=
 =?utf-8?B?TWNRSXgwclBjOEY0ZUMyVklrK2tLam5Xbkw2WlNneG9sSXRMK3IwSmkzTmZC?=
 =?utf-8?B?Q3dIU3FTRjB0LzM5N1l6a0RXKzRqdHVIYm8zdytOVzZoYnBYZ1UzUUlpYUxX?=
 =?utf-8?B?UDB3YmRZL0oyc1I0Q2lWck9IT054b09BUUtaSWNMTTQycWRHTHR0RWhNdXhT?=
 =?utf-8?B?UzExclBMY1pqcFJaUHRtdGk5QWdyb1hEMkkwb0NCSnh3eXA2NE13NXlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGFwSzI0YlhlN3dLSU1wRW9RU0dsSytWMVg5TXZMcmxMcFJnV0dKL0NHc2ls?=
 =?utf-8?B?amZ0WjNLSjRrM0NsRUJaZlNpMU9FbFhvVGxSV2F4aVNBY3hqaDJYYmxDQjlv?=
 =?utf-8?B?Vm8zRUVXdVVVQjF3dFJQL2NwUy95U1IzVkx6SE5UVnpmRzVyMlJkOW80MVFj?=
 =?utf-8?B?TkJER3FKMDh0bEZWLzhvaGhFcEU1V0V3T0J0WlVMOGxSVWlQcmdPM1NYL1F0?=
 =?utf-8?B?MWwzQmJseFVtcm9KNExzY2c2Q2JXYk5Mak4zZHp6YVQ1UjJXcUZDT1QzSExh?=
 =?utf-8?B?U244NmdpVVRJaTlBcmwxakVWdXBpQWdmOTFZQ0RzSy8yUHUyejAxOG4vazNt?=
 =?utf-8?B?VW9OdUV5RTVqL1pmMG5IVEdYMEVtR3NDRlhzWTRka25QUTUwZE1ucEhzeTg5?=
 =?utf-8?B?bkgzNDd3UTd6YXFNWElGVFZiUEd3K1RYQVcxNlRtL2E4WEhLb1UvN2FSMG1J?=
 =?utf-8?B?RTkwdmRJaks3QUQ1ZFUrNlpGdmt0eDROZmozOGJiTTArRTBheDFVSmJJdTg2?=
 =?utf-8?B?TFUrS2NVTUZwcTZwcXBXYXRCWHlmRVBtdXZaRFIrZElkRStNSk5zRXRTbWpp?=
 =?utf-8?B?QTVTWDN3Q1BHV0tIR0FMVnIwOU1OQ2RQU25XK3diMVhHdDl4TXpzMWlIYkh1?=
 =?utf-8?B?ekV2VVd1VGk0V3Yxd3lRNTRXUGRDMDhZVndSbkJYcnMyZXdwRGdDTzRGYmpH?=
 =?utf-8?B?c25aVERkbk0vZ2RoeFBrSFU3cXR1d0NsaVYrNnI0UTBPd1VHclNSQ2NSWURQ?=
 =?utf-8?B?UkNIZEdqcHp6WVlub2FUSndaV3l2MXdhSDIxZVY2OWpwa0RzQksvR2lhOWty?=
 =?utf-8?B?d3hxd1FUWlFhMWp4RnMxQU1BOXFaei9YVFI0WW5RSTdjd2RqSU16bFAwTVlu?=
 =?utf-8?B?cDdkSnNlNDlLcTdmRFlrRHFqOWJQT0tEckFMYWZRWkxldnJGeFpsekU2alEz?=
 =?utf-8?B?Ynd3Nlk2SFE4eFhuREdYcVJDMVNneVl5TTE4aDBSdlhPYlB2WWpPNUZnUU8v?=
 =?utf-8?B?endnVFo2TmxNR2UzdE9rMFRxUFFzbzhSeC91NlpuZUs3cFBMWVRvUTZwQkJn?=
 =?utf-8?B?NlR5bXdGWUlvemovbGVTL3NYbEk3TjZSRnhHeUlTVGRuVlZPRnVrblpWRFdU?=
 =?utf-8?B?SEFwbmV3S1VIOGpKdU9yMDMwSU5PRzc0ejc4Q1p4bG9JRE44RVQ3WE5kWm56?=
 =?utf-8?B?T0ZMTmFOd0tYMU5KWlUvaERhVWdZcTVrRmJVMDU2VWFJM2Z3c2NVR3RsUklL?=
 =?utf-8?B?K1kyamJYNzRKc244UVVINmh2SDJUb0E0ZjluQ2tuQUxlblkrWVhOczhsR3JT?=
 =?utf-8?B?VkxuSzkvaDJPOWwrcmE3TzJCcldlYXQ4SEhWWWNUUDVaUG5BbjdIZ0pHQjk1?=
 =?utf-8?B?ay9TMzZlY1I4UDlIZWVySkpvVWliMU1ualo2WmF0UEpBOWdZbDlSUTVhSUNP?=
 =?utf-8?B?QmhiNlg1SGdNdmdXTFJySU9qV3A1ck9TWXN0MnVTMHhabkxDRzlrNnlwOXBL?=
 =?utf-8?B?SUV0RHNtMnVWR0ozNzF6YUJiUjB0QzVsT2ExWHdqV3JlWGQwMU1XK2dEQzg3?=
 =?utf-8?B?NGI3ZkpVMlhrUEhYNU5wTmI4dkg4ZnFGRElERXp4NmhPQmduNFJKWldYQVlN?=
 =?utf-8?B?VFNZYzJMdGZmRkdFc25IK2c2bTVTOHVOL2RadTE5MEhVZDBoL0MxYjdpYkxI?=
 =?utf-8?B?QVIvWFJ0cGQvYmJGWDJzUHVOd09CZkp3WU1YZWsya2JkNnF1ZFRqWlBpdzV2?=
 =?utf-8?B?YlZ6ai9lbm90ZmVnZjZJYTVqNWtFeWNseFRVSmU3UnE4SGRJR1RWNHVuQ1Nq?=
 =?utf-8?B?bHd1eHF4aXpMTUpvNTRmbTNOZFRjSjBCSzdKVzlENDMvbDZTdVZmMFIzalho?=
 =?utf-8?B?Z1ZPVVNYQnRiMXJoWjlJM2JEK0RSTnY4ZmltNnJwbksvTENNWEkzM0lndVdt?=
 =?utf-8?B?aGprZ2g0QVN0OTM3WGdxa3lHcWNVdDdHbE9DdGcwWi95MTAyL0RDYm1MU0sw?=
 =?utf-8?B?Ym9GZDFuNUhEY0IyRmtPQ2hNUStnaVFJUC96V1JNdEMzT1llSUpNaWRiL21C?=
 =?utf-8?B?ZVhrbFUyYm5UT1NyQ1Ardmg5cU5OYU5KcmFuOXc4L1Ava25BUVIvd1RGUlZZ?=
 =?utf-8?B?Mkhac3lKVEx0d3B0Rmw2dWJtekgxZUk1MnE1Ti9jOUk3amJ5VVFGOVl4OVpo?=
 =?utf-8?B?K1E9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 67351849-87f4-46d6-12a6-08dce7a721fd
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 14:40:19.7570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfeqNZJQij2Cvj1SWp6PlW02yalK6RVraRNBUATOsYp3/TVZaKuQga/eJEdDfcVlA97Ke9x1J1BkwlqqC1DKv4iMBgn3evO0x3MXCD3ccf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7459

On 08.10.24 11:04 AM, Shawn Guo wrote:
> On Tue, Oct 08, 2024 at 09:21:05AM +0200, Frieder Schrempf wrote:
>> On 28.08.24 9:46 AM, Frieder Schrempf wrote:
>>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>>
>>> This add support for the display bridges (DSI->LVDS and DSI->HDMI)
>>> on the BL i.MX8MM and the 7" LVDS panel in a separate overlay.
>>>
>>> Only one of the interfaces (HDMI or LVDS) is supported at the same
>>> time. Enabling the LVDS overlay will disable the HDMI interface.
>>>
>>> * Patch 1 and 2: Add the necessary binding changes
>>> * Patch 3: Extend the BL devicetree
>>> * Patch 4: Add the LVDS panel overlay
>>>
>>> Changes for v2:
>>> * Patch 1: Add link to commit message
>>> * Patch 2: Add Conors A-b tag
>>> * Patch 3: Remove blank lines from hdmi node
>>> * Patch 3: Fix order of lvds and hdmi nodes within i2c
>>> * Patch 3: Remove the unneeded deletion of samsung,pll-clock-frequency
>>> * Patch 3: Use the existing MIPI DSI output port from imx8mm.dtsi
>>> * Patch 4: Update copyright year
>>> * Patch 4: Use exisitng MIPI DSI output port from imx8mm.dtsi
>>> * Patch 4: Fix pinctrl for GPIO hogs
>>> * Patch 4: Fix property order in i2c2 node
>>> * Patch 4: Use generic node name for touchscreen
>>>
>>> Frieder Schrempf (4):
>>>   dt-bindings: vendor-prefixes: Add Jenson Display
>>>   dt-bindings: display: panel-lvds: Add compatible for Jenson
>>>     BL-JT60050-01A
>>>   arm64: dts: imx8mm-kontron: Add support for display bridges on BL
>>>     i.MX8MM
>>>   arm64: dts: imx8mm-kontron: Add DL (Display-Line) overlay with LVDS
>>>     support
>>
>> Gentle ping for this series. Neil proposed to apply path 1 and 2 to
>> drm-misc-next. Shawn, can you review/apply patch 3 and 4, please?
> 
> I'm getting this:
> 
>   OVL     arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtb
> Failed to apply 'arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtbo': FDT_ERR_NOTFOUND
> make[4]: *** [../scripts/Makefile.dtbs:83: arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtb] Error 1

Thanks for noticing. It seems like I missed to commit something before
preparing the patches. I just sent out a v3 that is fixed.

