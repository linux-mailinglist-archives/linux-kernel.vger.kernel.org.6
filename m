Return-Path: <linux-kernel+bounces-296522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7527E95ABBA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 05:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BEDE28D45C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7525A1B7FD;
	Thu, 22 Aug 2024 03:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pyg0TSEK"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011029.outbound.protection.outlook.com [52.101.65.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A5623775
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 03:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724295888; cv=fail; b=O5EKUyITLla1nmmCM8Glqxl0Nhe8mpTKDN1q21ztpE++TR7yVJSnkYbYDN9tSzKVrlhosB3f+HmlosvjFM8BE9RmbcvP4bnDx9b4/S95iBadO/UmWRzqMe+YiypJvTmEjOQm4B0dILcnbR3VL+D3/TB1A9e2zlEhbbTZyBAlKEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724295888; c=relaxed/simple;
	bh=p87VrtzQYOrxoC8kh8IRQZIDwSC+5xMOZZOnaN98164=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EORGYPUkQ7+d3yryKI7fAO6Hg3jRJENDOXP81UR01RuZl6EKpJAzDiSQ0VsxiVG3i7jNWH4vArqYaB6Slwejjhc2yFwaNcBeD6vbBadj3X/KDfMSTtOUwU+dKVFvomdVdke7MXDmPiSqGj7ZvAMCAa0E0GFCOUVXRQWrrWPmlTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pyg0TSEK; arc=fail smtp.client-ip=52.101.65.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NztOG31k8J3WUUbWoUN7j7cbmVQEhKLWXMjAabwGLvwF02o3s+yPEV7noiztSYqClyF4yrnQJ9MiReSEYMApBAJfNjqGwYCNwwJ08HIuEPEmPgK4T5Igy/UVhlF+OmuhjqIY3B5oqEq1/CRvOxuAeAs4wWuDHUt8VOItudJJpBkccUbPqPMRHwS1lxNy1tZCCm/PUooIDovCe9ku3hdrgHmRokF9EaFPfbKwUqLewduT9dmPypfjMdp4d0hU8YjnSozmBYSoFJbxsWavftTpbC8Wtinw/agOTs1hDV3ekX1cHWyx8azSKcBj0MAaqcRc+OH4gAw2Hc7UK5n3IVADig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p87VrtzQYOrxoC8kh8IRQZIDwSC+5xMOZZOnaN98164=;
 b=GdocwVeAZjXpQbDXm+l+SNiGCBJotrHScRLPTnvHChuKd0lVOwM8uL2buiGfMy3CW4QkmdPWPDoE9Wpc1eo/tqcmj3yj3xSq3MD0rKguOKJygBpZPDckqCVgKkjwOfsJqLj8PE70ivREAEij1lIaHdKlhk4dzqWqd1QAiaEuiRgtLlUwAnlQLB1WIPbaX6opMtQhf0ZTAlpvFsL2YiVNCY7Dk0DKaUqggw52ZPhEutvUa2PV13s/PTUkNzJP1+CfHP7Leo9pTB0F6RwXriF3C+ku4mDnyEvXgj80BBo/dLK+9R8fLbLM37jRleSjK7/DU065g6tHnrzJThlf72iZ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p87VrtzQYOrxoC8kh8IRQZIDwSC+5xMOZZOnaN98164=;
 b=Pyg0TSEKil+7rG64QOws1DAbj0VVCZrN08oY3TwKWnaZice/ntNpGvh9yjcW/vXIqZJhrda9njokQOjfeI/IgK33mHIXG5M1q/i8NX6Hr2N1fK/N4K6Un6DK6HZEmAQpwhfxJcnTcg23ZLqxgOS1p4GYt+i0jZngML2lUc+MosQM46yiXlsqrzpYLp/sCCHNAvhWgAVEDXdX9/uTWoncVgvg7UvSulo0Czs5k9a0fusz5wub7C4baSF6ZBAJV3gZeIOjKytjEEzk+rECPgb+SxYgflz7sEgKkqvz0Eb2F0a4TDzFFXrv6RTiwnoxK/gI7xUs/MJQt9l/atoxtukPuQ==
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DBBPR04MB7785.eurprd04.prod.outlook.com (2603:10a6:10:1e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 03:04:42 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb%4]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 03:04:42 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, Frank Li
	<frank.li@nxp.com>, "conor.culhane@silvaco.com" <conor.culhane@silvaco.com>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [EXT] Re: [PATCH v2 1/2] i3c: master: support to adjust first
 broadcast address speed
Thread-Topic: [EXT] Re: [PATCH v2 1/2] i3c: master: support to adjust first
 broadcast address speed
Thread-Index: AQHa6I/NxwwdUr4WekyxzVSWz7a/B7Ix9zmAgAC2tHA=
Date: Thu, 22 Aug 2024 03:04:42 +0000
Message-ID:
 <VI1PR04MB500513D0A8E03D49EA2558ECE88F2@VI1PR04MB5005.eurprd04.prod.outlook.com>
References: <20240807061306.3143528-1-carlos.song@nxp.com>
 <20240821180709.1626dd64@xps-13>
In-Reply-To: <20240821180709.1626dd64@xps-13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB5005:EE_|DBBPR04MB7785:EE_
x-ms-office365-filtering-correlation-id: 87d6e01f-01fb-41b2-a278-08dcc2572b5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y2hua20rSDBIOVVHK0MrdTRNN05LZDZWbGJKdHFDOTZIU2NtTDl6MTNWVGl5?=
 =?utf-8?B?bnJTVC9ncmYwcS9RWUZMMnROa3dXcEFqTFZMQi9CbEFIRjJTZi8rTVk3WlhP?=
 =?utf-8?B?UjNRb1dOYThGZHRycDI3QWc3bWdEZlpFdERtNFZyakZZK2xnVEVnMFpZY0FC?=
 =?utf-8?B?VVEwNGVkT1B4QzRDVXE5dkNxNThNM0xXSTcxVTV6WWxjTVdDNStZOGt2YUpw?=
 =?utf-8?B?cVJ6VkcxNWZtdGtXblRyZXgvczF2UnNFWVd5YVIzYVFTTHVFeWVrRXhIQXpo?=
 =?utf-8?B?akdWaWI4THg5VmJmYmtpUGE4L2FUL0pNRjFhVXViYkxzUHFrUUlBNVN0b1lp?=
 =?utf-8?B?ekU0eG9QS2RPWUYxcWIxeGZZSkJKQnhYQWFpcnJYSW9PcmFLMjE2eDRCZnB6?=
 =?utf-8?B?eE9YYlhFazhpSHUxL1N4N0FaSUlSUFBjT0FTTk4rVzNkWW1aZmgyUGZJdmZY?=
 =?utf-8?B?S3JNN0gvK0RmcXQ0bm1xbFNRSzNOQzhWbUdzbWZBS0JoYVIrd01XcUtDdisy?=
 =?utf-8?B?TFlraHpjWi9JbHphMFhxaHAxSnpzV0l5ditjMmFUOWc4LzJCd2FsOFNkMUpk?=
 =?utf-8?B?Um5WNld4S1JBRjJrNWJpZk94MUpBYjh5d1E0SDdPaUZmckU1MlYzWWsrZDJZ?=
 =?utf-8?B?TkxTRzVHTklaU0xmVlpjdmRWR3cybVp2bHlYY1BJSk13RENBSzF6cjBEMURz?=
 =?utf-8?B?T3ovaVVXeFR0VTNKTjlWVTBOM25sNDl0UlZndVJPL2F4NkZDWmpmNDMyLysw?=
 =?utf-8?B?azJRNVdzN08zdnhOaWJuL1pGYStTcC9DNzZ1V1kxUXZnYVpzZUJZNzltNTJo?=
 =?utf-8?B?R3kwWitDejhKNTlOTEVITDZodkRJV2tQeTJQSHduRG1VbGJtZUxDVjdaSmp4?=
 =?utf-8?B?dHVSZFBrRWd3Vk50NVFBR3ZmMHo5enVwb29mVVlWTzNsR2J6S3dKR3M0VkxL?=
 =?utf-8?B?UjNOUFkzNTBEdUhOOW1jUWNHZXczMXdVT1p5a2o5YjY4T2RwckdwVXMrL1Vo?=
 =?utf-8?B?QlMzZDBoNEhuVmhaZnNoVGhCbytqa1c1eVBoYVV2WlBFOU9qV1dNTm9DRk91?=
 =?utf-8?B?aDZCdmltL0dJZ2hkaDRaSE1NZktFNUVOSm1kc2VMRTJ3R3NuWnlLNkgwaWcw?=
 =?utf-8?B?dGYyTXhUR3djSUdCeXlGZ2xXeW04TUlHLzVoeFM0YW1aNG9vVTgzbHZVZFEx?=
 =?utf-8?B?bmxhZ0FVVlBXaFdkL0I5cnlLSm9lQ01UcGN1Rkd1VGFTR2c5MUhaRUpwdERD?=
 =?utf-8?B?VWNpaUsrS2tXMXhlRU1HUk1rYXY4K0drejc5Y3dKanY4ZHNxd1ZkLzc4bGVY?=
 =?utf-8?B?a1BvUHdQYWsyWDFQcHF2RmNOV3Q4dkVaaUVSNlFyYUs1cDJtNHBWR0ovUk80?=
 =?utf-8?B?blgzWVMySEMzcjlSMUVONkM4bnhuMHA1eXFWL0hudUNYZEFUbHAvYUpXTEFU?=
 =?utf-8?B?RlFxbWNkRFlZM2FEQXJnOWhac2lyR01iVVZqZWs0cXVQR0pvNndHSXR2aHJS?=
 =?utf-8?B?Uy9mNmw3V0NGNjdVeEZ5UkZTaWVJOGlhNmtQcGNQWDZGVVRBcXVyRFh2dXBu?=
 =?utf-8?B?bms3ZDZlVjMzK0owNlNyZG5LYmZJQU0zQmdOVnFiUHNUVWNzYk5vMzdETE15?=
 =?utf-8?B?aTcyWC9wRjM4eFp3SEFWQnlXQjRNTkhWVTdHZTcrZ2I3cCtXZEtmZndUNEZk?=
 =?utf-8?B?REJmaHlUekVXaitIRFFMYTFseGV5ZTdVd2UydnRNekZwT3JUS3N2Q3dpeDJt?=
 =?utf-8?B?ZlB2bFVqOVRFLzJWOUxXd1dwZXdFcndXdkxYTjNpOWlkakpkZGtaN1k5MDJD?=
 =?utf-8?B?clFuUVgvdU9WVUEwK3hLQzEzcDJuekcwdTBwc3ROOGxudnBLMkpkdkl0UHlj?=
 =?utf-8?B?SmVaUEJOUHBlbkl3aTRsTythd2wzYWx1bVRIbmRpdG92dUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RlRxSERUR3RVclhvaGNibi81Q3lzMnZ5VEZ3ZmpyZ3FtbUpWYkdSOHVPSW1J?=
 =?utf-8?B?YU43bUQ3cHMrRkVhWFRhK1ZGaCtaWGxDRUNjNDZ3Z1FzdFZEUndBUnJyKy8v?=
 =?utf-8?B?OUlIWHZ4VmY1U3RxTjlQck40VWJvYVRuY3BMV3JReCs4MGl2eHNsYWc2TGpn?=
 =?utf-8?B?R1RZcllnWW02ZFJKckw4MzRWM2xmWWRkaU55RWhMUFN1K0w2WkwvaTRUVllh?=
 =?utf-8?B?MnZ4NEdmVE1qZU90K2RVWEkweEpoTHA1RWhiMldjYlZ1YXJRZHlsTTNSVnBv?=
 =?utf-8?B?R0RNYnlVaDZIT3V0aHV6TGJYRklDcHVKRVI0dU10SzdqTXE2a29FOXVYcDlY?=
 =?utf-8?B?akVyZWhSVEFHaFU1SHNmazhRTXJZbWpSMEdSUE9WTEtLaHZPRXhaTlZkNldS?=
 =?utf-8?B?N2tyV0hRSVorQnRaTlMraU8vWEdBYlViNllhTzhTN082aUloT1I0enJuZFBm?=
 =?utf-8?B?UG5iNDBiOWFpUm4zN3gybnhDa3o0dzVCcHVWbTdMeit6YTczeXhGYWJoUlNI?=
 =?utf-8?B?UTAwTFFhZ2JpeTFESWd2eUpnS2hzUDF1UVA0VlhrUnYwMzZXM25DM1NZUzNj?=
 =?utf-8?B?akZVeWh2d082SG5tYUdCMmM4SlRHTjhNWXZodGFLOWRhNURMQWhDZmJTclFi?=
 =?utf-8?B?a0loeEJtQTE3d0VDN0JKR0dCdjJKMm9udUpsT1pMMVJ2T3E3S0NRNE9TQU9L?=
 =?utf-8?B?czUwNjJUSEhLVHhGQ29XMW4weU4wR1RHeEhjOTVMck5DKy9TU3V2dWhMeFFX?=
 =?utf-8?B?d2VSRWhyMnJMa2Y2eW1KYnE5b0RQeVZoN3g0OC9qbmM3bU0yNTZOOExjYlVl?=
 =?utf-8?B?UG5UVmFjMGJtVEJ5b3lXVlBCb0lSb09FNkpJWCtMUW8vUlpIYVNCZW9ZRWk3?=
 =?utf-8?B?ZnVob2RLS04xWkVWUUIwUFJYaG1RVXpWa1pPemcraC9oWDFiaDdPdTFrcklV?=
 =?utf-8?B?UG5YZEUwcEt1MTJoTGtkMUhkYktqOU1lVXBzSk9NZjkvUVNNeXRFYUxqU0hy?=
 =?utf-8?B?SWpFRFJ4YVErQTZ5THpvOVNPREMzMDJpSUJINDg0Y2hqNVpMYnZneWtHSTBq?=
 =?utf-8?B?MnFnajNNRmxSYlR4amR1QXpubjIxeFhzQVhwOURXbWRSVlgyQ2pnd2xGaVlr?=
 =?utf-8?B?Q21ZamoxeElJbUh6a3RQSkZGMlZFUmJHcDg5Q2NRT1FiWDZUQUUzVzVsVGZJ?=
 =?utf-8?B?Y0ZFaXBESnFTK2N0cW10MldoRFZzM2oxdG9vdCt4NS8zNHVEKzNRVUNxTElS?=
 =?utf-8?B?U3RGOWpJN0dDTThnWm1VQjQvVm1EL2Z4aHZtYlN2T2l1U0g5TUMvWW43UUpr?=
 =?utf-8?B?ajhpRjR4WlZCdzVnR0FrRkRrenR1UjRwSi9HWGtnN0M2TmdxSm1STWZwZ0dF?=
 =?utf-8?B?aFUyNEh5cXNoOW43UVV0YWZlczgrVFRxcGc2VWVqZG9SWG9oSkY2TmRISy9W?=
 =?utf-8?B?VkhaaFR6VzBPdytLbVJycHVMUWVocXRzNGg2T3JXTktYOXhNMEl2S1dwZkEr?=
 =?utf-8?B?dXhMSlFoTWlFdktWTlhaTmc2KzhlTU50ZmxlcjVlYU5RcUgyeW82Sk1YSUc2?=
 =?utf-8?B?U2pUNGF0WTJOd0xtRDUvUHR3UVRtVHgwdVh4UGMvQ2lXMGlxMlVNRHg0MWph?=
 =?utf-8?B?eFJENDBvY2hkRHFDaTBWWUthN3RjVi9vN1c1M2M1cm9BcmIrem5YYW0zdlhI?=
 =?utf-8?B?SXZtSU4rck5WL1lKanh0eGZyZWtyaE1aVWptZHVySldWN0x5QlFiL1ZJZFYw?=
 =?utf-8?B?VnVMVGM2dGpNdHZiTjRaTnI2UzBieHBBcDkzTExxTW8zUmZqQzR2UWY1R1g1?=
 =?utf-8?B?cnl2WlB5bnlVVG5LOG9id3QxU2xqOHpldHZVMllRdUhSS2tvTkQ1VEEzU1Nk?=
 =?utf-8?B?dFlpdHprYkMzK2F6VlcxMGxlWE1DZ0RRVVAyejMvcmttZEFmZ2VUZG5pVzcw?=
 =?utf-8?B?ZWtOd3Y0SHZNY1Vob1JmcG9hMVM3eWRrSlR6ZnI4aENVNy9VcnlVa0dvMmkx?=
 =?utf-8?B?UjhqUm01eDlYZEk5a2dNampOU0lZQzhlSmdkNzZ1SXZjTlp6V01vT09id0Yy?=
 =?utf-8?B?andidVpGRkdoSFVuMXp0RjFCNHlRQzlBejl5WFZRTEFzVlF6MTBpMVhMcktL?=
 =?utf-8?Q?8vcV1GnuL3p4zushoZOGIV3NO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d6e01f-01fb-41b2-a278-08dcc2572b5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 03:04:42.4504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9nF61QwQkLM2xI854RkpyZtBVIp7756dAIbZThCriR6rccZHZBAXkPdlwzgfOaAA5ZovLGHSUtqW1w7EOm927w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7785

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaXF1ZWwgUmF5bmFsIDxtaXF1
ZWwucmF5bmFsQGJvb3RsaW4uY29tPg0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDIyLCAyMDI0
IDEyOjA3IEFNDQo+IFRvOiBDYXJsb3MgU29uZyA8Y2FybG9zLnNvbmdAbnhwLmNvbT4NCj4gQ2M6
IGFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4uY29tOyBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNv
bT47DQo+IGNvbm9yLmN1bGhhbmVAc2lsdmFjby5jb207IGxpbnV4LWkzY0BsaXN0cy5pbmZyYWRl
YWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBpbXhAbGlzdHMubGludXgu
ZGV2OyBkbC1saW51eC1pbXgNCj4gPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBbRVhU
XSBSZTogW1BBVENIIHYyIDEvMl0gaTNjOiBtYXN0ZXI6IHN1cHBvcnQgdG8gYWRqdXN0IGZpcnN0
IGJyb2FkY2FzdA0KPiBhZGRyZXNzIHNwZWVkDQo+IA0KPiBDYXV0aW9uOiBUaGlzIGlzIGFuIGV4
dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3INCj4g
b3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVz
aW5nIHRoZSAnUmVwb3J0DQo+IHRoaXMgZW1haWwnIGJ1dHRvbg0KPiANCj4gDQo+IEhpIGNhcmxv
cy5zb25nQG54cC5jb20sDQo+IA0KPiBjYXJsb3Muc29uZ0BueHAuY29tIHdyb3RlIG9uIFdlZCwg
IDcgQXVnIDIwMjQgMTQ6MTM6MDUgKzA4MDA6DQo+IA0KPiA+IEZyb206IENhcmxvcyBTb25nIDxj
YXJsb3Muc29uZ0BueHAuY29tPg0KPiA+DQo+ID4gQWNjb3JkaW5nIHRvIEkzQyBzcGVjIDYuMiBU
aW1pbmcgU3BlY2lmaWNhdGlvbiwgdGhlIE9wZW4gRHJhaW4gSGlnaA0KPiA+IFBlcmlvZCBvZiBT
Q0wgQ2xvY2sgdGltaW5nIGZvciBmaXJzdCBicm9hZGNhc3QgYWRkcmVzcyBzaG91bGQgYmUNCj4g
PiBhZGp1c3RlZCB0byAyMDBucyBhdCBsZWFzdC4gSTNDIGRldmljZSB3b3JraW5nIGFzIGkyYyBk
ZXZpY2Ugd2lsbCBzZWUNCj4gPiB0aGUgYnJvYWRjYXN0IHRvIGNsb3NlIGl0cyBTcGlrZSBGaWx0
ZXIgdGhlbiBjaGFuZ2UgdG8gd29yayBhdCBJM0MNCj4gPiBtb2RlLiBBZnRlciB0aGF0IEkzQyBv
cGVuIGRyYWluIFNDTCBoaWdoIGxldmVsIHNob3VsZCBiZSBhZGp1c3RlZCBiYWNrLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogQ2FybG9zIFNvbmcgPGNhcmxvcy5zb25nQG54cC5jb20+DQo+ID4g
UmV2aWV3ZWQtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+IC0g
Rml4IHNldF9zcGVlZCBkZXNjcmlwdGlvbiBmcm9tIEZyYW5rJ3MgY29tbWVudA0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL2kzYy9tYXN0ZXIuYyAgICAgICB8IDEyICsrKysrKysrKysrKw0KPiA+ICBp
bmNsdWRlL2xpbnV4L2kzYy9tYXN0ZXIuaCB8IDE4ICsrKysrKysrKysrKysrKysrKw0KPiA+ICAy
IGZpbGVzIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2kzYy9tYXN0ZXIuYyBiL2RyaXZlcnMvaTNjL21hc3Rlci5jIGluZGV4DQo+ID4gNzAy
OGYwM2MyYzQyLi42ZjNlYjcxMGE3NWQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pM2MvbWFz
dGVyLmMNCj4gPiArKysgYi9kcml2ZXJzL2kzYy9tYXN0ZXIuYw0KPiA+IEBAIC0xODY4LDYgKzE4
NjgsMTIgQEAgc3RhdGljIGludCBpM2NfbWFzdGVyX2J1c19pbml0KHN0cnVjdA0KPiBpM2NfbWFz
dGVyX2NvbnRyb2xsZXIgKm1hc3RlcikNCj4gPiAgICAgICAgICAgICAgIGdvdG8gZXJyX2J1c19j
bGVhbnVwOw0KPiA+ICAgICAgIH0NCj4gPg0KPiA+ICsgICAgIGlmIChtYXN0ZXItPm9wcy0+c2V0
X3NwZWVkKSB7DQo+ID4gKyAgICAgICAgICAgICByZXQgPSBtYXN0ZXItPm9wcy0+c2V0X3NwZWVk
KG1hc3RlciwNCj4gSTNDX09QRU5fRFJBSU5fU0xPV19TUEVFRCk7DQo+ID4gKyAgICAgICAgICAg
ICBpZiAocmV0KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl9idXNfY2xlYW51
cDsNCj4gPiArICAgICB9DQo+ID4gKw0KPiA+ICAgICAgIC8qDQo+ID4gICAgICAgICogUmVzZXQg
YWxsIGR5bmFtaWMgYWRkcmVzcyB0aGF0IG1heSBoYXZlIGJlZW4gYXNzaWduZWQgYmVmb3JlDQo+
ID4gICAgICAgICogKGFzc2lnbmVkIGJ5IHRoZSBib290bG9hZGVyIGZvciBleGFtcGxlKS4NCj4g
PiBAQCAtMTg3Niw2ICsxODgyLDEyIEBAIHN0YXRpYyBpbnQgaTNjX21hc3Rlcl9idXNfaW5pdChz
dHJ1Y3QNCj4gaTNjX21hc3Rlcl9jb250cm9sbGVyICptYXN0ZXIpDQo+ID4gICAgICAgaWYgKHJl
dCAmJiByZXQgIT0gSTNDX0VSUk9SX00yKQ0KPiA+ICAgICAgICAgICAgICAgZ290byBlcnJfYnVz
X2NsZWFudXA7DQo+ID4NCj4gPiArICAgICBpZiAobWFzdGVyLT5vcHMtPnNldF9zcGVlZCkgew0K
PiA+ICsgICAgICAgICAgICAgbWFzdGVyLT5vcHMtPnNldF9zcGVlZChtYXN0ZXIsDQo+IEkzQ19P
UEVOX0RSQUlOX05PUk1BTF9TUEVFRCk7DQo+ID4gKyAgICAgICAgICAgICBpZiAocmV0KQ0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl9idXNfY2xlYW51cDsNCj4gPiArICAgICB9
DQo+ID4gKw0KPiA+ICAgICAgIC8qIERpc2FibGUgYWxsIHNsYXZlIGV2ZW50cyBiZWZvcmUgc3Rh
cnRpbmcgREFBLiAqLw0KPiA+ICAgICAgIHJldCA9IGkzY19tYXN0ZXJfZGlzZWNfbG9ja2VkKG1h
c3RlciwgSTNDX0JST0FEQ0FTVF9BRERSLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIEkzQ19DQ0NfRVZFTlRfU0lSIHwNCj4gPiBJM0NfQ0NDX0VWRU5UX01SIHwgZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvaTNjL21hc3Rlci5oDQo+ID4gYi9pbmNsdWRlL2xpbnV4
L2kzYy9tYXN0ZXIuaCBpbmRleCAwNzRmNjMyODY4ZDkuLmI4ZGFmMDlhOWE0YSAxMDA2NDQNCj4g
PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2kzYy9tYXN0ZXIuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGlu
dXgvaTNjL21hc3Rlci5oDQo+ID4gQEAgLTI3Nyw2ICsyNzcsMjAgQEAgZW51bSBpM2NfYnVzX21v
ZGUgew0KPiA+ICAgICAgIEkzQ19CVVNfTU9ERV9NSVhFRF9TTE9XLA0KPiA+ICB9Ow0KPiA+DQo+
ID4gKy8qKg0KPiA+ICsgKiBlbnVtIGkzY19vcGVuX2RyYWluX3NwZWVkIC0gSTNDIG9wZW4gZHJh
aW4gc3BlZWQNCj4gPiArICogQEkzQ19PUEVOX0RSQUlOX1NMT1dfU1BFRUQ6IFNsb3cgb3BlbiBk
cmFpbiBzcGVlZCBmb3IgRmlyc3QNCj4gQnJvYWRjYXN0IEFkZHJlc3MuDQo+IA0KPiBBIGZldyBt
aW5vciBzdHlsZSBjb21tZW50czoNCj4gDQo+IG9wZW4tZHJhaW4NCj4gDQo+IC4uLmZvciBzZW5k
aW5nIHRoZSBmaXJzdCBicm9hZGNhc3QgYWRkcmVzcy4NCj4gDQo+ID4gKyAqICAgICAgICAgICAg
ICAgICAgICAgICAgICAgRmlyc3QgQnJvYWRjYXN0IEFkZHJlc3MgaW4gdGhpcyBzcGVlZCBpcw0K
PiB2aXNpYmxlIHRvIGFsbCBJMkMvSTNDDQo+IA0KPiBUaGUgZmlyc3QgYnJvYWRjYXN0IGFkZHJl
c3MgYXQgdGhpcyBzcGVlZCB3aWxsIGJlIHZpc2libGUgdG8gYWxsDQo+IA0KPiA+ICsgKiAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGRldmljZXMgb24gdGhlIEkzQyBidXMuIEkzQyBkZXZpY2Ug
d29ya2luZw0KPiBhcyBhIEkyQyBkZXZpY2Ugd2lsbA0KPiANCj4gLi4uIEkzQyBkZXZpY2VzIHdv
cmtpbmcgaW4gSTJDIG1vZGUgd2lsbA0KPiANCj4gPiArICogICAgICAgICAgICAgICAgICAgICAg
ICAgICB0dXJuIG9mZiBpdHMgNTBucyBTcGlrZSBGaWx0ZXIgdG8gY2hhbmdlIHRvDQo+IHdvcmsg
aW4gSTNDIG1vZGUuDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdGhlaXIgICAgIHNwaWtlIGZpbHRlciB3aGVuDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBzd2l0Y2hpbmcgaW50byBJM0MgbW9kZS4NCj4gDQo+ID4gKyAqIEBJ
M0NfT1BFTl9EUkFJTl9OT1JNQUxfU1BFRUQ6IE5vcm1hbCBvcGVuIGRyYWluIHNwZWVkDQo+IGNv
bmZpZ3VyZWQNCj4gPiArIGFjY29yZGluZyB0bw0KPiANCj4gb3Blbi1kcmFpbg0KPiANCj4gPiAr
ICogICAgICAgICAgICAgICAgICAgICAgICAgICBJM0MgYnVzIG1vZGUuDQo+IA0KPiBJJ20gc29y
cnksIGNhbiB5b3UgcmVwaHJhc2UgImNvbmZpZ3VyZWQgYWNjb3JkaW5nIHRvIEkzQyBidXMgbW9k
ZSIgPw0KPiANCg0KSGkhIFRoYW5rIHlvdSBmb3IgeW91ciBhY2shIEkgd2lsbCBjaGFuZ2UgYWJv
dmUgdG86DQoNCi8qKg0KICogZW51bSBpM2Nfb3Blbl9kcmFpbl9zcGVlZCAtIEkzQyBvcGVuLWRy
YWluIHNwZWVkDQogKiBASTNDX09QRU5fRFJBSU5fU0xPV19TUEVFRDogU2xvdyBvcGVuLWRyYWlu
IHNwZWVkIGZvciBzZW5kaW5nIHRoZSBmaXJzdA0KICoJCQkJYnJvYWRjYXN0IGFkZHJlc3MuIFRo
ZSBmaXJzdCBicm9hZGNhc3QgYWRkcmVzcyBhdCB0aGlzIHNwZWVkDQogKgkJCQl3aWxsIGJlIHZp
c2libGUgdG8gYWxsIGRldmljZXMgb24gdGhlIEkzQyBidXMuIEkzQyBkZXZpY2VzDQogKgkJCQl3
b3JraW5nIGluIEkyQyBtb2RlIHdpbGwgdHVybiBvZmYgdGhlaXIgc3Bpa2UgZmlsdGVyIHdoZW4J
CSAgDQogKgkJCQlzd2l0Y2hpbmcgaW50byBJM0MgbW9kZS4NCiAqIEBJM0NfT1BFTl9EUkFJTl9O
T1JNQUxfU1BFRUQ6IE5vcm1hbCBvcGVuLWRyYWluIHNwZWVkIGluIEkzQyBidXMgbW9kZS4NCiAq
Lw0KDQpJcyB0aGlzIGFjY2VwdGFibGU/DQoNCj4gPiArICovDQo+ID4gK2VudW0gaTNjX29wZW5f
ZHJhaW5fc3BlZWQgew0KPiA+ICsgICAgIEkzQ19PUEVOX0RSQUlOX1NMT1dfU1BFRUQsDQo+ID4g
KyAgICAgSTNDX09QRU5fRFJBSU5fTk9STUFMX1NQRUVELA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAg
LyoqDQo+ID4gICAqIGVudW0gaTNjX2FkZHJfc2xvdF9zdGF0dXMgLSBJM0MgYWRkcmVzcyBzbG90
IHN0YXR1cw0KPiA+ICAgKiBASTNDX0FERFJfU0xPVF9GUkVFOiBhZGRyZXNzIGlzIGZyZWUgQEAg
LTQzNiw2ICs0NTAsOSBAQCBzdHJ1Y3QNCj4gPiBpM2NfYnVzIHsNCj4gPiAgICogICAgICAgICAg
ICAgICAgIE5VTEwuDQo+ID4gICAqIEBlbmFibGVfaG90am9pbjogZW5hYmxlIGhvdCBqb2luIGV2
ZW50IGRldGVjdC4NCj4gPiAgICogQGRpc2FibGVfaG90am9pbjogZGlzYWJsZSBob3Qgam9pbiBl
dmVudCBkZXRlY3QuDQo+ID4gKyAqIEBzZXRfc3BlZWQ6IGFkanVzdCBJM0MgYnVzIHNwZWVkLCB3
aGljaCBpcyBnZW5lcmFsbHkgdXNlZCBmb3IgcmVkdWNpbmcNCj4gdGhlIHNwZWVkDQo+ID4gKyAq
ICAgICAgICAgICBmb3IgZmlyc3QgYnJvYXJkY2FzdCBhZGRyZXNzLg0KPiA+ICsgKg0KPiA+ICAg
Ki8NCj4gPiAgc3RydWN0IGkzY19tYXN0ZXJfY29udHJvbGxlcl9vcHMgew0KPiA+ICAgICAgIGlu
dCAoKmJ1c19pbml0KShzdHJ1Y3QgaTNjX21hc3Rlcl9jb250cm9sbGVyICptYXN0ZXIpOyBAQCAt
NDY0LDYNCj4gPiArNDgxLDcgQEAgc3RydWN0IGkzY19tYXN0ZXJfY29udHJvbGxlcl9vcHMgew0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgaTNjX2liaV9zbG90ICpz
bG90KTsNCj4gPiAgICAgICBpbnQgKCplbmFibGVfaG90am9pbikoc3RydWN0IGkzY19tYXN0ZXJf
Y29udHJvbGxlciAqbWFzdGVyKTsNCj4gPiAgICAgICBpbnQgKCpkaXNhYmxlX2hvdGpvaW4pKHN0
cnVjdCBpM2NfbWFzdGVyX2NvbnRyb2xsZXIgKm1hc3Rlcik7DQo+ID4gKyAgICAgaW50ICgqc2V0
X3NwZWVkKShzdHJ1Y3QgaTNjX21hc3Rlcl9jb250cm9sbGVyICptYXN0ZXIsIGVudW0NCj4gPiAr
IGkzY19vcGVuX2RyYWluX3NwZWVkIHNwZWVkKTsNCj4gPiAgfTsNCj4gPg0KPiA+ICAvKioNCj4g
DQo+IE90aGVyd2lzZSBsZ3RtLg0KPiANCj4gVGhhbmtzLA0KPiBNaXF1w6hsDQo=

