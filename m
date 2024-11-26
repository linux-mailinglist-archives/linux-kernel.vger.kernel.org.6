Return-Path: <linux-kernel+bounces-422592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 521B89D9BDA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB9EFB262DB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B711D8E18;
	Tue, 26 Nov 2024 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OjN/EUc2"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2048.outbound.protection.outlook.com [40.107.103.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A532E1D63CA;
	Tue, 26 Nov 2024 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732639014; cv=fail; b=KySCM/tpDfmAB1XEw59oDK47oTKuSQKX3MjQXfsexWjTAJbK3j2FCWA0rWIBkrq65eyVj438nnHluiQNQ729E9dEsHiBLI97+QcEBBLniAko92B23GUYCMx8889pFHTrvN7w0vnCvO+xuGYsKV0prshP9BjNeubK2BMRadFwMGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732639014; c=relaxed/simple;
	bh=fXRwshdfsWBmIPJZURoF4Sawoxqt486+lu94cMiE69I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kr5+V3ZkNB8RrUYyGjbr/JH0/6W8MUoqMljc8BnfDACBsoLsWNk6BuuQ7rpbtsbGMr4SShnuexVRkYnKDJZg9sKy0+O22oSjztHjGpGwLNiPsP+NJj8HnQkPWPLltw4wK1vw2rTRwH5AMb7A4n6sWH4PNtsSKWsda/Z2iESu0Os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OjN/EUc2; arc=fail smtp.client-ip=40.107.103.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fz3qRWfuN37/2Cgu1MobvS0AKHqrJBuvmwjN/r9gnoi5QKJHn9YAmbeO6LDRFAD05lFtP7MEzO1bCV+neOwR9Yp1Pa4NZvjuzP4uuksofrwm+KhzMuzJINM6TKgwdLQGKeA8uq4AzLBzuNKoRqtRTTFYZQV4QF58yI7zKkq4DEEDIFyf8VfwnJETHBJLEohnMijQP2M3nfbBAljKjsEPKJwEmqxfe/9xJcM0eRqIZm7FuvcDmHrclFNk5bHubaIGhAM6UaJPZPoMJXbb4cA7K8PtjlELGdAtEc/ig2DnpMmdRckrkA3YcmhcfUFwjF9Vo0pE157kazglNKyqLKAbVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXRwshdfsWBmIPJZURoF4Sawoxqt486+lu94cMiE69I=;
 b=aQW03eEudSnQPp8YzPeb1JGgucz9Js/h85Q9npzO+LMyYqNnbkHpN+uHhWrkQct0+Go4Ho24JQLTzxKdjLSAOoOuJGQzF2mxwqq62ZVtXFwybExGfPGFmZBLPbLzNi4TKZS+ujSMV/IN3tuulr4AmIC+EfKhFTa57UuAQ9wGvYKeRYRRUhnFgBLD14OO2PAi1H+E4J+kIn4V6t3kD2fJKnEqPTh83FOr3ekTn71ldhpzV34TuG2MW/4tWCLgWIyxRdQ67ZIEQr/SSrkoFcD5wjXOxuND1CUs31xHiU2PGkiILFdrBMqWplcsHqSafuoJRqrdHDF9vXtCXAHhjhG9/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXRwshdfsWBmIPJZURoF4Sawoxqt486+lu94cMiE69I=;
 b=OjN/EUc2XA9PYw6uFjtR1RNvUCHlMTjhX61/HTTgvQp4im9EAtfEqpDGMH+CVwDWGpBxWd9BlRJz/QctB+9ns0FOwHSH1W6au2IC8nWxYVfF1jocECVliMYIgPIe521tn7IMgGiSYpBb8Iw6oPJdjYV+abqjbI7zSWmV+XwceuvFY0vGPnpkN9r4JwDRHSzjF21xulJg8Yrdk58uLXtKv6iy7lgh2B0GghVscdgdeDzAIglnDzYYGiv3aUQgGF4HwbXt1Mr3UmvM1z8sARw1iXyPXkbJO37A9E51CrnmalsAbl14HFxjTlElo5xn9Hb1rGjTOFUMeKq6JGvrQN4ixw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8251.eurprd04.prod.outlook.com (2603:10a6:10:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Tue, 26 Nov
 2024 16:36:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 16:36:43 +0000
Date: Tue, 26 Nov 2024 11:36:32 -0500
From: Frank Li <Frank.li@nxp.com>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, festevam@gmail.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	aisheng.dong@nxp.com, laurentiu.mihalcea@nxp.com,
	shengjiu.wang@nxp.com, iuliana.prodan@nxp.com,
	a.fatoum@pengutronix.de
Subject: Re: [PATCH v2 4/6] dt-bindings: clock: imx8mp: Add syscon compatible
Message-ID: <Z0X5EOBXMFTGZVQN@lizhi-Precision-Tower-5810>
References: <20241125152427.136883-1-daniel.baluta@nxp.com>
 <20241125152427.136883-5-daniel.baluta@nxp.com>
 <Z0SvF2tQR14jrHet@lizhi-Precision-Tower-5810>
 <CAEnQRZAVmza+A5QC1Xq4dsw1WBtdp0EoM505+UzrCKe15+vqhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEnQRZAVmza+A5QC1Xq4dsw1WBtdp0EoM505+UzrCKe15+vqhA@mail.gmail.com>
X-ClientProxiedBy: BYAPR11CA0037.namprd11.prod.outlook.com
 (2603:10b6:a03:80::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8251:EE_
X-MS-Office365-Filtering-Correlation-Id: a5c6965f-758c-47a9-7cd2-08dd0e3882d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXZSWGRuUldrb2hoYnh0OTBmSi9RVHBMV0FiRk9kZzNNN1d1WXlhL3N2Vi90?=
 =?utf-8?B?ODVJdnkvb0tRWC9SVWVhb3VnaDZtYzVBWWo1K04rYTgvbmdTSU8waUlSajI0?=
 =?utf-8?B?bmJDNW02Qlc2QldhYU1ENDJXUUg1WTJhQUhVSDl1UG85VnE4d3M5bzVqaWM0?=
 =?utf-8?B?cmF0Q1JQQ3kzMjZMdzVrMHh4b3F3RUYvV0pjQXl4V3VFTkVQd2FNdFE3eFcz?=
 =?utf-8?B?OXJaSWNIMUZoNVJSWVBKWjRJU1UvcDlabW1mcWNZYWppamxKT2Y2RHQwLzBo?=
 =?utf-8?B?R2xTRDdkTEhkQmx3ZzgwTkh2R1R0dStML0RQNGp6RDlLamJVV2NKVkt1eE5r?=
 =?utf-8?B?Y1JsQWkwRmdzTWFlUk1nYXBGQml4VUVPcUt2SkcrY3FlbGppWUt6VW43R2NF?=
 =?utf-8?B?MFUveEt4bmRUMUlXU1dIWVRHcnVnMDZRTnYySlc5c2tUQUdBTGxqTjQyZnFK?=
 =?utf-8?B?bG14Ky9PMGFIMzkxUXRNcHIyMHg3eDVHL1hnaDlCWmUxZ01QOWNHODdyWmFI?=
 =?utf-8?B?R1ZEK1lZbTFjWWJFT05wcWYwTjU2dWRQWGFCc1JCS3Z6eE1Gd0FZekhZajhJ?=
 =?utf-8?B?OWtEUGJJcnRPNnQ5a2t3a081UmpMQ2xYZUtob1BQT3k0Znh3cEtiMlhNOFJF?=
 =?utf-8?B?UVhMd3lpNmYxV01IZWtva0llQUJtWVBSSlR4SlJrd1BHSDFYM2haSGVYK0lB?=
 =?utf-8?B?WnBwYUZnQ3FzZkQ1dm40TmlScnJlVmtyT2tBNTZ1RHBZUk16ZktlK1BtbUhZ?=
 =?utf-8?B?Z1BzZ1FMbHRvTG40ZXpqODhSbVVrL2dvV1NvK3RXa1dXdk9qMDFNbDB4S05s?=
 =?utf-8?B?THNISjZodFpOMWN1b2lQWm9sYjI1TW1JMGVGUldzbkU2QVVBUkNuSS8xbXc4?=
 =?utf-8?B?aS9CRGgrZDR5N2pIaldieStaM3daZGduS2tScm1vVUxuZEtKb3Vka0xlQURB?=
 =?utf-8?B?clRybWZKQnppSTlqSUFFc2VhSmNxSHpyYStGdHMraUorNDVLa0hWM05hNjBX?=
 =?utf-8?B?MlR6QnlZVkw2YktJMW0rOFVLWm1GNmpJZlIxVUlGMEZHaEZuSjltdGRsd1Jl?=
 =?utf-8?B?Tk9UOWkxVExhUjRUZVVsYi8vNTdzOStFSzlyM25EdlB1bTNPMi9lK05vTjc2?=
 =?utf-8?B?SkJ2bi90cmxuWnovYW1vdUZJa1pJZkVFLzhPdkZpUnRDSGRKVW5tR0ptQXpW?=
 =?utf-8?B?dFgreGEvTUdBMUVnV3hqcUl2QzlFS2VUN3lIdWtFTThXSis1bGlBWG5CaSsw?=
 =?utf-8?B?dk9SWTFta2N0eU56M0dWN2Y1d2pKT3RtMjZDaG0yN3hzSTdsRFRVdW52dGIr?=
 =?utf-8?B?ZUtlQWg0T0UzbXc1alYrLzM1bEJaLzIzbTA2bVNYdUt5dWdRL09vU0piUjJS?=
 =?utf-8?B?TlR1bXRHV2J4WS9iNW1KcjFaaGpoa1B4WE45bXJPdXFFcHpSR1hvQ20rZlJK?=
 =?utf-8?B?andmRjlzSmh5dHRBK3pmOGgxeGd5dnNVS1ZrN1F3dFQrMitVZFlVbzBZN0kv?=
 =?utf-8?B?Wm9CTGVxYXFVNHpVZFZ5UFcvWXBIVGd6VnhTWjVDSVQxZXU1ck11d0RxMkZt?=
 =?utf-8?B?R0VuQjU0T0ZlcHhNQ0N2UjdYWVVUMGhVZXlaQUE2S2V0dXBDYks0T2E0c25x?=
 =?utf-8?B?eU9jN1RaWGY5MkJ4SklHVEVzZ2hMQnFQWk5JZE43eHpwU0VudVFrdGtDQUVL?=
 =?utf-8?B?aXZ2N3FqdVRaL2FuVFJFaHY4dVNURHJjaEZWcVVxSWV4U1ZVTDl3TE9sL3JY?=
 =?utf-8?B?UWsxa1dGOTlrVDVJU3lmRG5DU2xZa3Y3cWpmSGZWbHlORi93RWIzckpPVTZ1?=
 =?utf-8?Q?ePdEkbDhCOgsuvf48Xa6WrRO/jewg2UjpAWho=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWYrWmJSYmRFVlBBOGJ2YTdrSE84bU5wUUluMlNIdVpDbWJuMmsxQUo1YzlJ?=
 =?utf-8?B?aTJJY2dMMTlGdGRtTXA4R0Z3ZnRSZW9yN0o0bCtObjNTSGh1SDFTK01pZWo4?=
 =?utf-8?B?OGVXL2ZmeUVBa3c2Yk1wQjBWZ29MVzhvNnRucEFwVzBwWlNUTXErcVVuMGFj?=
 =?utf-8?B?YUI5SUZSTHduWlkrMWk3OHpqcmIzT2F3elM5ZEFFZFpRTzE0TjBFT3VVb0kw?=
 =?utf-8?B?elpsaTVaOS9BV3lMQ3FWQnA1MzBDVG01WHA5Mm1QdlBua2VKZmtJK1hOTnA4?=
 =?utf-8?B?WmpnZVBqTHNoRUY5Z3VHd3p1ajlnQWY4bVNGNXpXVWhUVDlvQmdpTVFrZE5p?=
 =?utf-8?B?cE53SXZBeUpRMW5XcE93Uzd3VGtYUThuR29wd0xsY2xxb2YvTzJRaVorNkc2?=
 =?utf-8?B?aTkzK0hLSWVBNDlUTHVVVXVxak1LMGJFNVU2bWVVRklFa2kyaEsyT0dVOWJz?=
 =?utf-8?B?QkZDQmF0ckFzczZ4a1U0cUhxNjk1T21oVlBMeFpEQlk5bExjaU1vS0U2SEpi?=
 =?utf-8?B?dlBxYUhvRTFpZDZhMWM3NlNVdzUvTUVNeXYwMzhiQ216UE5zRDJvaFNDNDRX?=
 =?utf-8?B?NzR5Q2dMeTBVY0ZxMDd3MVZnTElHd1NubnRxcE5ORmFJM2VvNEdoZ2JhekYx?=
 =?utf-8?B?MXpDbDRLSERpa0krMnF5eTZ1c1M3bVVZcDhUZVIyb3N5eEZOeXRMZC94aEZ1?=
 =?utf-8?B?LzZVNzg2bVluL2lrVlIwd1lFd3ZoV1J5alJTK3VaN3lTcldETlhMeVBBcWVz?=
 =?utf-8?B?WU42RWRGOGVGZVVFVlVyOEVxalJnek5la2FzbzEyOHJFaWU4MHVXbmNzRkI1?=
 =?utf-8?B?NWJMNnRtYkNQR2hCbTZVTU1XSUlGOWIySnJieFl2bmpwSlloUzBCK3A4VzZq?=
 =?utf-8?B?V05sdnRHUHdvRjFGWjJ1a244RmgxcU9SRFAwRjNGZ3RIeVl3VjlMOVhUWEpU?=
 =?utf-8?B?NzVIWmxreFEyMjBoVTc0UVhMSEsvM0ozMFhNRFFpLytLcGlrektwRXF4eUwy?=
 =?utf-8?B?VXRxMnBtbHZKUVNPYlF6Q1pRRDl2dzRHS1FvdWpGNjNVQXBQWi9kN0dEeHhI?=
 =?utf-8?B?Q0VzcjE4ODJINHk3em50emowdk02TTlNUUUyRmNEbXNOS014VFpVRWIzNkUr?=
 =?utf-8?B?Vm5ZRm9mRFZZSndWTWVrM09LSFJGclhOdnkzbU5ubDJPS1c0YzJVYWVNb1pK?=
 =?utf-8?B?N2RRV0daRG42dDlsVTYxYjFuVm4wVnJMQStNSnJmdkpaT3NXS0l6TVJ4TVFq?=
 =?utf-8?B?MVk5TlVweFJpcXQwU3lTSmtEV2tENWtLeW9xOGpsQTRkSG5Ca25qY2hIbWxN?=
 =?utf-8?B?NEZiYzhFWXB1QnBNemFyaThtUGFXblZlemZKWWFLakJ1RmVjRFBvKzZuTEFP?=
 =?utf-8?B?Z1V0Kzd3alZtb2tmWEMyMVNYT2hXdHZjZ3FIMEtzbi9VS3VnQ2NPMmRHYTNI?=
 =?utf-8?B?aStHSUp3STBxclg1NHNFN3NaUkhxMVQrZm1jeVVxZW5yYnRBZi94dUdMK2E5?=
 =?utf-8?B?RzdGYVBLd1RPMit5RmtDQ0lsa0JPV2ZwWFJxRFJ5d1RFZElkQjBBOFc2UUZG?=
 =?utf-8?B?eG52bHhIV2xpWHI0M0YwTkUrRTJBaVpMaVAwOW5vVXNsdXhJcFN2OEhXdHJ0?=
 =?utf-8?B?d0dMaHlmSUlINFV1YkR5RjhUM0F3TzF6ZzJpUytXMWY3bFllRVprQ2ZJVmN0?=
 =?utf-8?B?Uk9UYjFyT1JQVjRNMnIrS2M1d1ZJVTRHRDhoWVRUeDN0RVowMkVPa3lvV1VD?=
 =?utf-8?B?TS91djRaN2tsSk1NYnNBaDNuWndEZDdzWkVPWmgyL1lkR0ZOR2pTdHU4NlVB?=
 =?utf-8?B?ajErNmtqd1U3dUFwOExidXR3TXNXTHBsUE5sK2tzcjZ2Q2ZjNlJsb3hoTnMv?=
 =?utf-8?B?K2ZUeTRybUhmQ0xCMXpqS1BrdXVZd2huSm9GeGdIVVVJRlhTb1NNYUVvUS9R?=
 =?utf-8?B?T3NSRGdwUjZQREtJOVEzM3p6VjczSTg1NTRkdUZYV1Z3YWYvcVNzeFlLemdn?=
 =?utf-8?B?Q3RHend4Y1NhcXAzR3RpRVBwNE9wNHNlQmhiYmdyWmhEcE5YRjBoaDB4Y1pi?=
 =?utf-8?B?VjZqRElabndWdUZuNy9CUU5LRGo2elhwL2tOOHgyWmhZV2h0Zkt5UkRZZDBU?=
 =?utf-8?Q?4Au1XO2jnn0RpK0DFS9AZjX0K?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c6965f-758c-47a9-7cd2-08dd0e3882d8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 16:36:43.4157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ib/QeEfHwsP6BZX/fSkH2bJ0Aw6w2RV23Fsf/azYkRbLwA+ENNeSl5UIKiWWZJpVthrA0IylzZcwkreWrHjIKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8251

On Tue, Nov 26, 2024 at 05:31:21PM +0200, Daniel Baluta wrote:
> On Mon, Nov 25, 2024 at 7:08 PM Frank Li <Frank.li@nxp.com> wrote:
> >
> > On Mon, Nov 25, 2024 at 05:24:24PM +0200, Daniel Baluta wrote:
> > > imx8mp audiomix contains a set of registers used to control
> > > the DSP.
> > >
> > > The dsp will use this to acquire o reference to audiomix registers
> > > and handle the registers to control the dsp.
> >
> > Look like this is NOT good method to direct operate these register. If it
> > is reset, you should export it as reset interface. If it is clock, you
> > should export it as clock interface.
>
>
> Hi Frank,
>
> The code to handle this is already upstream and used for:
>
> Remoteproc
>
> https://elixir.bootlin.com/linux/v6.12/source/drivers/remoteproc/imx_dsp_rproc.c#L991
>
> and Sound Open Firmware
>
> https://elixir.bootlin.com/linux/v6.12/source/sound/soc/sof/imx/imx8m.c#L237
>
> I'm not sure if it worths the effort to refactor this for such a
> simple operation.

It is up to Rob's opinion.

Frank

