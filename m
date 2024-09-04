Return-Path: <linux-kernel+bounces-314419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320F396B2F1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572D11C21D79
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334B114659B;
	Wed,  4 Sep 2024 07:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="agGm/TH3"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2132.outbound.protection.outlook.com [40.107.215.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CB93C17;
	Wed,  4 Sep 2024 07:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725435197; cv=fail; b=IXX7edp5PitWPaBW+bf4fvwX7JbtLVnEHlHGyFWlm7uPlQlGo8g56vRos0AKLeT74A0RHN0UjUfIZtAuw78e6f8zGlz79JfA1oiRWBGZv694feBd9mHqGZihselPJIHGymlOp0BxsIKAccC6F7HMjzTCJth8g+Re+e9rSNge62A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725435197; c=relaxed/simple;
	bh=lBP6FX7Z4QGdXrJyhfsmCgP3GxMe96g/ifv6SP/dzUI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VcD685MwW5W+RsORRQW1qPLEqUFzx/fUpphZ7ej+5/td9yipFEGMwxIIq/v8E2gLrrQ57btGWyuUlMVv6HqSdED5aerpHgNPhGtJ/WX7zhRER1/LLVnfXvwfL1Jx1KoV0hzsmpw8RT88A4J283N3qdMJRxLiZFKvegXnKpS5AyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=agGm/TH3; arc=fail smtp.client-ip=40.107.215.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hu7wIcoeWtJUZ2z39i4v3NAxiYbil5csMNpJMXtfFBwbiJ7sUTjDie+N3iixxPa2lbNQgmKb62pqz0s84/q0YhH5LbTXObJtszMhb7A6H2/BZROage7MNAQvzcwwOnwfzK+tfvKsK5bzrH9Zz+clmAbstf2vkvWnzS1gz/2LFMHR0tYURIBMij10a80Sf26nYlkGknoFRpKuq1p/lW9wwiCybSYLQKIUD8MfyFpHqO/0KMdmFkjs5kbLseLQtM+Ju+Cym1Ud9kX00f3r+THkDeJxZjUiwA2OPjMrcfYhL3AjJLHyLU5qlrVZ4oyFtv3bFjxHeVhPxXb8NRPguvHZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bp7CYkrai+tlAKC5lWFE/QTCc5OTc96Q2h9YDu9OdZU=;
 b=C3vNbooo69XKE3okz+LIZAXsuh2HkZ8wyBz1qKP8aA/6hhF2b+0Ku1iFaH4RITV6p0F36Vz9IfMIL4hy04O/6U+JxCD6H4jqAUDgSO2mny/p3zNsAF5d1noSPzdjXcGSGpibSsRq6WOA5C8fOeJTSlw3P0b9Sp9aRCdGOpDqJlwL0FKvvkYDPGyxZ+qHe5GTCZ33p80ClmIa8Ihe0CHMiChnxH32eRDktFw1jPG05spDbOEwyyI0f/lXIw6SqtvsNKlzVpCGIAUVF817OVC5k+MW0wW4MleBOcIlyuxSylKC5/yLfSunDGG+BUr20h3jxadb2kD9H6rx3sXggdD7oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bp7CYkrai+tlAKC5lWFE/QTCc5OTc96Q2h9YDu9OdZU=;
 b=agGm/TH3CydWYOInP8MgLNZCbMJYMplEQ2nWFmFRCn/3XF352gkDcxwn2q5kYni2Gtw2a/re8zBwVmDynzaP8vL9KXtA7R0aErz3opzOSB91KNocHOgaaz5GxBaZCr35APHOmsfhEyUwBnEazsr0maaK3U+YU4fUwSYZYMoJtRtvhWf3YhZwaQ6SQALVr4GpEA/b7iEoFD1Y1rIkk+bgZXZywc/jabzHXIO5A+luFZmGRbWgwPapij1HVcimLHRPpTimuqJFtWLF7f5X6GCLNGSdoXb/huW6ZB4Vx6CjCrJU+G5dbVtgF24vYxIRhvovqInP4esG5n52A2J6rGC5BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by SEZPR03MB7809.apcprd03.prod.outlook.com (2603:1096:101:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 07:33:12 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca%7]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 07:33:12 +0000
Message-ID: <5021173f-8277-4e5f-8c3e-3febcb45e9da@amlogic.com>
Date: Wed, 4 Sep 2024 15:32:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] clk: meson: Fix an issue with inaccurate hifi_pll
 frequency
To: xianwei.zhao@amlogic.com
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240904072013.517905-1-chuan.liu@amlogic.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <20240904072013.517905-1-chuan.liu@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|SEZPR03MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: 2311350d-2e18-4b97-fd89-08dcccb3d4d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkpqMnc5YVBzdVhCcUFkVGc3ZWR5TjZPM21oVGY4ZjR4cURXOXpCTkVSYUdU?=
 =?utf-8?B?SERVNDFHM2VIcER3QmE3ZGt5SERoY3laTnIyUkkxdDkyZzMyQk9yR0dvdkYy?=
 =?utf-8?B?WCsxVmR2bDdqK2MrVnNzM1d5TXQ0VHhnYktWc3lyZ0RhenlCc0VrVWt5aHVS?=
 =?utf-8?B?NmpyQi9VeXVOblBpZnZKUUhZNmxHRFFJVTZmVEhxNlRlSEJQRmtiSW1TelNv?=
 =?utf-8?B?enlBUThZS2NBM2Z1cjR0NUNTOHVabERsR3dCSEMxemcxaFNvTjdZZnh1c0dG?=
 =?utf-8?B?dkxkT01qejhRYnNFdVFDMnZKUmU4ZjE4NHV2dHlIbTVkdTRmNXJXRFE4ZTYw?=
 =?utf-8?B?bzlGZDBBWFV6Qy9QN1Y0OFp1a2lpNnFoRzNoQVlrMjNCQkw2d25obFBEOGl2?=
 =?utf-8?B?cnpDZWE1QnFkb2FCR2Z4cXBFanBDTERoRmYvbnNZZGhRbTF3ak5FaEowdjlJ?=
 =?utf-8?B?MVVZMzFoa1lhdHZoMDd2cENpUnlXQXJsUlhTbmtRQ3ZtK05GNjZwU3ozeHll?=
 =?utf-8?B?bUN3YmlBSWZRS2tFNGtReWZMQzhtVzBrMkNRV29nZVlJZ2RLUUFWUlFnNHVQ?=
 =?utf-8?B?VDlaV3VLMHRvbVhibm5URVZMYnhETUx4eTZxZEtET2I1bEx5eis3bEErWmR0?=
 =?utf-8?B?K3NSQkl1bndpSEZ5WllCMEZKUkdNK1NGZmVNZ3RXOWE5QzM5Q084elovZWVC?=
 =?utf-8?B?OEhIYjhudXB4RHloMGVCcmk2aEVuVE9wV0VJbVNkSVRyK1hmUGVWMXRYWU9E?=
 =?utf-8?B?RFlNbjdIeXZlalJ3M2VocndIdXVSQzJqZzdwSldaNFdlSTg5ZjkrMWRrLzB2?=
 =?utf-8?B?azJFWXlrblp2VUN1RkQvNmtXeU1TR0FseS9QWWQzUi8vUGZ1WXdBd0FPSWk5?=
 =?utf-8?B?VzlqQkorWlp6V1gvMDE2MVF0bXd0UkRhcU5TSDRZcUhIY2h0dnFvUkt4bUZU?=
 =?utf-8?B?UGt0V1k4Yk1iYW5TL0lJU05GZUtkMkk1L2trWlY0dmtjdTh2MWxCM3dDSlVy?=
 =?utf-8?B?M3V6NEZkaFlib2RNNHBTdFpBR25FUUgwRUlsdXRBUmNnRTBadzAzUHpKTTZD?=
 =?utf-8?B?MzVBTFNhWW8xV0kwTFgzeDJockVSWDRyNlpOMUczR3B4aFluVktUNWJKaHc1?=
 =?utf-8?B?MTdMMSsxUk93cG9PZGNrZUxJd2ttLzJGYUppMmJCR1N6ZTE5eThLTk0yWm13?=
 =?utf-8?B?S3I0STBqakJUTDhFUUk3emNUTVI2VnowMStLL1lxbTBmS0tYdXJPcTIyanlh?=
 =?utf-8?B?VHBSZ2xWUmlDdGhnR2FyS3ZRZ2pDVTl1WitSaHdyWExtK3pITm9Wd1lKc1E5?=
 =?utf-8?B?cmRkelR5UUxhV2ZrWUh5Sy93aUQyKy9GWEkwWERmZUtqR3JRZnhHSGVIZzlj?=
 =?utf-8?B?TWZ6NE5UYWJkeGlJa0dvRmNZblNRb2cyLzZ2QlZWdG9PZFI4Q3drSmRqUWhu?=
 =?utf-8?B?NTdnVitJa2UvaEp5MzBTZjR4ZnBKZWdpbEgyVUxsSFA5dFN1cFBqdjhOTk05?=
 =?utf-8?B?MUM2QXRPSlJQelZyRFVRNGJYcjVNRXd0cEltd29oOGFxd3ZvK2VuVStVL3NZ?=
 =?utf-8?B?VUQ4em9UaXV4SFZXVWh3c0pPT3B4NjZJOWZ1S2VBOTR5RkF3cnB1MkQwV1Fl?=
 =?utf-8?B?RnlqOGUycStaa0tHaTBKeFFoZnVNQ3NTbDhnd3lCUFhpZW9MMGdRNWRSOXIz?=
 =?utf-8?B?dWJsaGVOZ3lYTm1iWmR2RWZycXF2UUQ5cFl4TkJnVjhXbzY0ZXcxL0hBSEtp?=
 =?utf-8?B?TmE2ekxIWXF6S3N4b1o3dGFjNlVBZ0l2bUhrbTMyNkFiSHRLS3lYUk10ZDJG?=
 =?utf-8?B?bERzY25paWgvUkY2MWU2Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTltbGhSOU0vNXAwcC9qQmZEOWxjVHlJeEpsSUl2dXRyeDB4Wmo5ZDRMblJH?=
 =?utf-8?B?Q3dSdlJsNGw0bGJPL2NzbGZtb0F3MWE4VVhtemdKQ0FDdS9TTWRMTXpvZHV6?=
 =?utf-8?B?dDlCZk0rVWpUZmg4eFFMMFBMODFUU0tnL0pZc1lHaWtBNWVrYnFadVZ2OUFH?=
 =?utf-8?B?c0d3dVJyVy9FdkVYUFZUQVhPcTlZazZtK3dDKzFtVDVOWnJkaFoxeHdwWEI4?=
 =?utf-8?B?dmJ6MnFzMTlWNkVoenBDYlhndEpxYks1dUhGcExzdTFKdEVYYWdRSUJYclRs?=
 =?utf-8?B?cEtWZzc5SmFZQ1lVajZkSU83ZGdTOWp0OUJLWjNTWVRSV3E3dVg2YWZvWk1O?=
 =?utf-8?B?eUs5cWxsMC92dEdrd1QrOE5td0wvWCtLdzB4VHpkY1RGcUh1UFB1Q1NMR3lX?=
 =?utf-8?B?M3JYU0IvQ09VUVRld0JrWUJXKy9qSkhKT0lqWGxiVzFLT1ZuZjlRdlFQRkQv?=
 =?utf-8?B?amJnN2xtS1pyajBYbmp1TUFkSlFvL25QaVR0SXl0azdxTThGczBHelJ2bnVB?=
 =?utf-8?B?d3JJUUtrM3NhVmpVMmMyQU52UWUrSDVaTVpMeFdLRWxhR3pueVVHZlNaVEF4?=
 =?utf-8?B?VFhDenZHUE5NcHZnNi8rdWZSTnRFTlNVWWg4R3IzZzY1bW1jUlVuNS9xVXVj?=
 =?utf-8?B?ODZyTkkvdi8xY0FYeU1ROE0xRVZJMXJaVm9HRFNTNnBKa0VsN1hMLzdpaXk5?=
 =?utf-8?B?RWNVUmV1L1VuUFRHU3g5RTkrNmhRVVdmNDRCb3E3SjZoN2ovRWpvL21MOVdZ?=
 =?utf-8?B?eHB3c2JDMThDL1cza2FITGFHcG9kLy9PdG1lUkJ5eVNIU3VONGxzaG02NzJ0?=
 =?utf-8?B?bmJsOE85czYzVEFUZW5HbDRvS0d3dnNlREhYOHlNbTRCTzcrK1U4Y1hhTTdN?=
 =?utf-8?B?R0JvNit2TFE2UGNRKzRPc0Z6VmczV0pib3pwWERYcG9rU1BkRnBzK2F6YnpK?=
 =?utf-8?B?NXFXVWtnQVg1OHRydEVBT1lXWXhSeXBweW5VZzdJbkZ1c3V3SXNTQndUUGNI?=
 =?utf-8?B?Nkh0c3JxSjMyVFpKRUVrd1dNZjhIMnUvWnVqdEZHdmdjSWpyaVArYU9YZ1h5?=
 =?utf-8?B?KzBJTXlsYm5WUGV1SUxxaXFWSE93cHY4Y2tmZ2xLZTlwVkFCL3JHLzVkNDc1?=
 =?utf-8?B?WXNDSURxQXNXRDVEU29reHYvalRzVytrbmRveFdIaFprcEhzSzJXSlpSTmtp?=
 =?utf-8?B?N29OTXI4RHNrYnJaVHFwYkJrak5jZFpxWDU0R01SU3IzL3dVYWFOdmN1WWlz?=
 =?utf-8?B?TDlTcEdBaDJMRkRNWmQwd3lTekVoYllJbU45MVk5QitFditxY3pNUzdEU1U0?=
 =?utf-8?B?R0hhQ1pWcDN3S1JMT25KZUF5WDQrNmNpbTlWd2dXK2QyR0NMdVVQRnM1YmNU?=
 =?utf-8?B?c3lITlA4bmhPWllaS2JQTHlpTVVRUG0zZitMWjJ2ZEQxREdYLzh5NTUxMnA4?=
 =?utf-8?B?aFpzS2ZUOXdEMWt2WUt6MDVqRmpTcXE1M3ZWQi9pTWhMTUs3bWNGQW5qSml2?=
 =?utf-8?B?Zk5tdlJER2lQQXJpZCsrRXNYamxrNzRLUy9JTFNJVWpvTFcxaE1rbERHODEy?=
 =?utf-8?B?NGw2Syt0UE1Fenc0cEUvZHZnNERoYSsvMXNwazkzTFFQMWI4VUV5aEF3MHBq?=
 =?utf-8?B?QzZxZHNickFVdWZEZFdXZU12eDlEQ3VqcWJxRlE4ZGUzYkRlV0h2NUxpWElJ?=
 =?utf-8?B?V2hXcE5JSjAyazA1OTJsYnVXWkFuaEN2Tk80THVhUEpZRGZTNFY0SGtWM2pO?=
 =?utf-8?B?OFF6VHhhTFFGeDYyMXNnbVYzamtOTy9HNmFWeVFQcTJ6MTZBNnhSRHA5WDlh?=
 =?utf-8?B?VWU4a2VzSGgyakNUdVNwRmJ2WmE3bVV0ZFZwTzROK3BkZHpXWm1MTGpzK3Bk?=
 =?utf-8?B?K3dJWHJaaExwTG1rME4zMVExNlpPaU13QTc2MUJWWVFvaHROcGw4NzBKM3ow?=
 =?utf-8?B?b2NMU1FFemlZWUJkWjNSTU54dXJmTlVHTlpLSHRQZ2ZpS2I0alF0Z1plTHZ4?=
 =?utf-8?B?dUV4elFNNE1oYVFQdnhiRGI3RFlwUWljU05IR01hTVlZWks3UHA0Ym5tdjdx?=
 =?utf-8?B?UFhmUHVTNTRCcVVYV2NPaHRJQU5qaW5TaHd6eGltc2p2T3I3SG1KSDhtMTVq?=
 =?utf-8?B?YUFiKzIwVDc3WVJLVVFmb1Z1K3hSR29uY3ZWOHRBekE1WTN3d3pEM05zWTlI?=
 =?utf-8?B?M2c9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2311350d-2e18-4b97-fd89-08dcccb3d4d0
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 07:33:12.4833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T92iVm0YuIkpvXwKq3zByYbiw9bgWl1IwwWl7Z5THnJq9lxEJDWXVdCnFKB5nmbG2ZpnguLo8aQ8fZHD0FbCHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7809


Sorry, The email was sent by mistake, please ignore it.


On 2024/9/4 15:20, chuan.liu@amlogic.com wrote:
> From: Chuan Liu <chuan.liu@amlogic.com>
>
> Some PLLs with fractional multipliers have fractional denominators that
> are fixed to "100000" instead of the previous "(1 << pll->frac.width)".
>
> The hifi_pll for both C3 and S4 supports a fractional multiplier and has
> a fixed fractional denominator of "100000".
>
> Here are the results of the C3-based command tests (already defined
> CLOCK_ALLOW_WRITE_DEBUGFS):
> # echo 491520000 > /sys/kernel/debug/clk/hifi_pll/clk_rate
> # cat /sys/kernel/debug/clk/hifi_pll/clk_rate
> 491520000
> # echo 1 > /sys/kernel/debug/clk/hifi_pll/clk_prepare_enable
> # cat /sys/kernel/debug/meson-clk-msr/clks/hifi_pll_clk
> 491515625       +/-15625Hz
> # devmem 0xfe008100 32
> 0xD00304A3
> # devmem 0xfe008104 32
> 0x00014820
>
> Based on the register information read above, it can be obtained:
> m = 0xA3 = 0d163;
> n = 0x1 = 0d1
> frac = 0x14820 = 0d84000
> od = 0x3 = 0d3
>
> hifi_pll calculates the output frequency:
> calc_rate = xtal_rate / n * (m + (frac / frac_max)) >> od;
> calc_rate = 24000000 / 1 * (163 + (84000 / 100000)) >> 3;
> calc_rate = 491520000
>
> clk_rate, msr_rate, and calc_rate all match.
>
> The test and calculation results of S4 are consistent with those of C3,
> which will not be repeated here.
>
> To: Neil Armstrong <neil.armstrong@linaro.org>
> To: Jerome Brunet <jbrunet@baylibre.com>
> To: Michael Turquette <mturquette@baylibre.com>
> To: Stephen Boyd <sboyd@kernel.org>
> To: Kevin Hilman <khilman@baylibre.com>
> To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc:  <linux-amlogic@lists.infradead.org>
> Cc:  <linux-clk@vger.kernel.org>
> Cc:  <linux-arm-kernel@lists.infradead.org>
> Cc:  <linux-kernel@vger.kernel.org>
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>
>
> --- b4-submit-tracking ---
> # This section is used internally by b4 prep for tracking purposes.
> {
>    "series": {
>      "revision": 1,
>      "change-id": "20240904-fix_clk-668f7a1a2b16",
>      "prefixes": []
>    }
> }

