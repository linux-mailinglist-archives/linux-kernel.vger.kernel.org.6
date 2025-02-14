Return-Path: <linux-kernel+bounces-514764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FCFA35B3D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABACB3A8DCC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F0825743C;
	Fri, 14 Feb 2025 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="SRlqXOxR"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2112.outbound.protection.outlook.com [40.107.117.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B396F2236F8;
	Fri, 14 Feb 2025 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739527911; cv=fail; b=p5TJnn6qx8T9oIGGv9r95VlEYQuMLdt5TQ7lVGB5DYrPN0EL+OBAa3AuzW5nRcLyDDlrZAOwEaWtpbUBiJyUSO2yFbYMfH6Y6BBie5Y6izxFo/hKvJZsMz+iyvWkf4BYm8aLHdSEiQVd1EhvDLczZVIuUigS0zST0YTPilGol3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739527911; c=relaxed/simple;
	bh=KJ3z5GrG0QGuIXsAA2/Pog+GZWsLYIc1oEsjNiUsv1M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z5tePjcy6s+ynPNQraGZNJy6921/v9w5QhbTQULq7LjLRjwjOy9wvKCyC9A8q//CMZRUSW6byNvdUQHWVNozOsC2pShGNNn7edwefT5u4MA3Pruasu5HhBPSUFebRG3dVT26JJPaMlWZ/Tq7XnkYMtBstg1cRvvX8CXdvOwdgtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=SRlqXOxR; arc=fail smtp.client-ip=40.107.117.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+JHPdp1b9vdDOAa01eVlULqtlqzjMrIqli8LqAH+BNTP/KHXTt7KHY4xd+E+D3bAHDUBF24dV9RF7/2LVh+CYyX3BiziH5vyiX11ft1mgpFxYaIkEhiATsEQ83AsbJ3A6eBbEtns3a8Li89L55CZU1we0AK3K8NQNHBIza4RbB26YptqwIyT0uGqacPlZ7GHti8ZPafHPEZW8Y+oYM7mB2kjURP6DI0JuLaKOEEEETE/9KF89o94RCc04NPxQg8y556rtcnATyMD0dDdDuJii+cSeh1Cw0uOQq95ddiF3IzJkfKkkLWtxkwFc31vvzKHv1KkIJnUUIQfL4NBX9Bsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJoivgf1f3ykNPxk64TVF6MHJr2GCR1zIWIY0Cm9oKw=;
 b=e57QZ+ouXnk+KwJBVU/WdtuGH5zEPO45hNUdbUBtDKg+NtWQzdmbfoHa9pAUMb2z2yqnhrnCJ2iQidxoEuL6tmbfvNEmRsuonG9PMom7ymBirr7fBU+2CKGLSg5P8SfhVVg5osLxFEM9XgvkUBcCaZQmHL9N9N/0wGamu9laLcpVPMOzIi+zN8z274j2P1wVs4w46MpQNZt3ApNJflpnFWMX1UBYhDG+e3QRuJdEnHyHuxPVw5gDIPdo2CClO2srOIvHjjQ4dvcO9L6fZlVBbw+hZ8UaFg9P5nENNpULf96Nhp5A+MoRDodKPVB92xvQ1YY7MBloIHnIfFIu0yNshw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJoivgf1f3ykNPxk64TVF6MHJr2GCR1zIWIY0Cm9oKw=;
 b=SRlqXOxRv8CLHKstRdv0u1gb1HyqRDblRVFrKpSBwtNajJVIQs2GlN3kAL+TJT93r7LXOTAS4lea2gRHt++Xf8guvfPxh8EHV6lfGwaotw2aqi/zJb4ABdYvHTrtSedXXjfZolsutwa0J12Ypf87CS36Pw3mF8hO6Qy2640fB8Aciyc28pQpysYrplsgRJTUFYOruugoMfF9T2SrqfaDTioz/CPWrsY+udIKP/Ss9ADN+Slc5yjYxUDkmgtqnrzDYVHL0IJtGhGRvB2PcCZBmLHkMzUts2xMOXNFqxv2Eqwv90EiyK5NrKqihAXcaxHRHZIm8hGq7ic/UXEUAP5Opw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com (2603:1096:301:113::15)
 by KL1PR03MB7174.apcprd03.prod.outlook.com (2603:1096:820:c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 10:11:45 +0000
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d]) by PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d%3]) with mapi id 15.20.8445.015; Fri, 14 Feb 2025
 10:11:43 +0000
Message-ID: <d0ddf1fe-6e6d-4e18-93d3-c432630b9dbe@amlogic.com>
Date: Fri, 14 Feb 2025 18:11:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] ASoC: meson: s4:support audio tocodec
To: Jerome Brunet <jbrunet@baylibre.com>,
 jiebing chen via B4 Relay <devnull+jiebing.chen.amlogic.com@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 jian.xu@amlogic.com, shuai.li@amlogic.com, zhe.wang@amlogic.com
References: <20250214-audio_drvier-v2-0-37881fa37c9e@amlogic.com>
 <20250214-audio_drvier-v2-4-37881fa37c9e@amlogic.com>
 <1j34ggzwel.fsf@starbuckisacylon.baylibre.com>
From: Jiebing Chen <jiebing.chen@amlogic.com>
In-Reply-To: <1j34ggzwel.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0032.apcprd01.prod.exchangelabs.com
 (2603:1096:820:1::20) To PUZPR03MB7135.apcprd03.prod.outlook.com
 (2603:1096:301:113::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR03MB7135:EE_|KL1PR03MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d12ca97-8dd2-49c7-8977-08dd4cdffb60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTJJbDh6S1ZMazVXR3RTbkxCNW51U2xPMXFBR0dad3hsWmp4Y3RoY0QyRzhJ?=
 =?utf-8?B?Vk1YT3JMbG1UOGIvRTErN2NrZGpxajNnc2JmZ3FrUXdnYXBxSU5MRjAyKzZL?=
 =?utf-8?B?NXlWekwrRFVrREl6Z3VCVm5TenJqUUszekMzNVNlbll3ZnVhQUZocmRCdCti?=
 =?utf-8?B?bmVNR3RWZGMwZW04TUtlWVdOWWhEUGdUY1FRNGJiK1lzeUYva0hLNkQ2M3Rs?=
 =?utf-8?B?NE0xSVBJMmp5bGxZRkkxeEtkMGpyQ3diMEFvTmorZUJaaFI4TUNZN3RodUIr?=
 =?utf-8?B?WHdPNHFacHhuNkVuTzdCZWQ0akVxWWt6aFZaUlpDZzdKb2hDR1J2NWd4UEJI?=
 =?utf-8?B?Qk4yTDQ0WWtFSlQ2YmR3WndGSjh3M3VuUGdaUGt6ei85a0V6dDE1V1o1Wnlz?=
 =?utf-8?B?ZEhLcHNyOTJYZmdmbVhRNy8rNHBETnpuSWtBWXBhVENHRXlwUFJKOHRxOGNq?=
 =?utf-8?B?OWFsaTF3ZWpsays5L295MzM0ZS9peUlxa2c1VU9LMGNQcEw0d2pBZFpqQnJR?=
 =?utf-8?B?em10eFZBWmJuTFJoY3BmWCtUWDJkZDdSSE90QjlMUElTRGxXWTdNcmJpTUc5?=
 =?utf-8?B?VGpPOXhWQUdGQTRUbkxtdm5UNHZlSmliSUpnZWxsT1VxdEhTYnBUUG93Qk8r?=
 =?utf-8?B?b0RuQkppL3pxZ1RjQmZUOEZOb2dibVAyOGNneEh3S29NSXdjZmpQMi9TaVRX?=
 =?utf-8?B?cTM1d0FLTzhnbTNGUXA1Q2w5S1RJSU9WcWEvRHViRy96TndycWZWZ2JteXlC?=
 =?utf-8?B?MGpIOUNrUDZreUVaK2RtSGhkWTdCd0p1VGhxMXA5WTNBMkZMQ0R1WWxFeE5k?=
 =?utf-8?B?UE5IWTFHcFdQSWNLWjVLcitVQStHQzVxQnNnSmxHZTY0NnFaZEpMZ3NmRkFH?=
 =?utf-8?B?RnFlVnNPMStNK3R6QUpKWHJpU1pUVmhqWTNEdGNWT0xkRWNLamxIa05kWTNY?=
 =?utf-8?B?UU5SWllBNGJRbXhPbXkzaW1qREZUTmJkWE95eS9DUHRHeEVkWjY0Ymd5M1o4?=
 =?utf-8?B?eXlqMEJHdEladnhyU1grN0NaM2RhMlVtVXVhV2tuUzNuSk9yU2YrZVcvR3Jv?=
 =?utf-8?B?RXRFRFMwb2dTc3M0WE0wMDhPSC9PWFcxS0NqT0ZoSkpBcHdwZFVlekN2QWo4?=
 =?utf-8?B?aklhOVlkTmJWbTM1djBRWUozYWhHVUNpc2FXU2VXMmI0RE5xYnYzdVprQWNQ?=
 =?utf-8?B?eTFrM1pqU2hxUG51TFpmR01maHc4d1pGLy9NS0RaZkJZZjVvc1dIQytFY1dr?=
 =?utf-8?B?NGw3SWNOWUY0MjIzMnBpZHRWN2pveXl2WHU5UkRjWUF6a2tnTUpFa0FxaERx?=
 =?utf-8?B?aXRoODBMZ0RFbGlydk5RWE56NHhTYlNjVXFyVzJNMkdxOE55OE1Ua2ozRmFK?=
 =?utf-8?B?MHRYemVncUxaSndYekREZnVJb3o2VXBtVWtjMHAyc3p2RmhMK0VXVnk2MEJQ?=
 =?utf-8?B?TFNrWW5FYmZWQzB2aDVpbHBVTXM3Q2xwSlprNCs1TEdDVEkrVE9HTEhKK0JF?=
 =?utf-8?B?Z2hXdnhGU1cvVEljbFA2UDdQU3ZyM0NnWEdDSitSSXJYZzhlOHp6ZXN5RnMx?=
 =?utf-8?B?alpqR3B3QTlYdUhTWG5DQjd6N3d3UEJTdGNMMDI5cEJGWHJMNlFyRDNZWlBK?=
 =?utf-8?B?a3RmTVJiQ2FtRTBJZ1hkZVNHRjBRSCtLSDVZdklUQStTZHY2MjgzUGhsN29u?=
 =?utf-8?B?T2pva0toVnRkemdYR21ENTRaMm56a3RiWVA2MnQyYjdsL1lET2N4RXVTUzAv?=
 =?utf-8?B?NGNqakQ3VUxXQWF2SzNWdE5IdFhHU01PS3NldWZYdlM1R3pOaVBYYkh4ZGli?=
 =?utf-8?B?RzlwQ1JMdlZReUcvck80NmRoN2lVNnJhZ3BzZkkycW15WXdKcUZTa0QwMmUy?=
 =?utf-8?Q?eMge9/RR9A6Sv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB7135.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkJaTitMTGFBb1BjeEoyWUxxSHNPZXZEQzEvT3AvVk9hekdyd0tBcHBKb1pZ?=
 =?utf-8?B?c1FDT0hQamxpZ1ZBZG82U0ZTaTVpMU50eHNVdDRwTGg5QXZqVDVlRm1KSy9m?=
 =?utf-8?B?VmVNNkJ3cldtRTB4SlNKYTNqdm94SmFsVWt6R0s5ZTNFTzVsVHIrUmVQdnlW?=
 =?utf-8?B?bUJYZnZxL2FnQStXa0pIZjlPbVJTeHFDanM3eHM1cWFSaFA3SHp3a0x6T2dZ?=
 =?utf-8?B?dnN1OGY3aVZhaUREOEl5R1JrZldicHVpTmtWMmlYd3JVaFN6UlpBUWRtYzBR?=
 =?utf-8?B?WHVFWmlHN0t4aHF0LzVmZFd6TXRVcjlyVXNCdDVTNDd5K1RPK243MFdkT0NI?=
 =?utf-8?B?bWxWU3F4NGYzK3NLWXV4WUZrU3lsSDl1blJuVUROcFU2NmVUNW5LTHh1WUVG?=
 =?utf-8?B?VjFQRFNsdGFjVndnZ0w5TTQ2Z0xSeEMwNTk4QXU1YkhqT2UxRkh2SXZubFYv?=
 =?utf-8?B?NDNudjRObmkxWmorNjZYempnR3NBS09uSDZmQVkyYStvUlV2TW5KNEQvZmxh?=
 =?utf-8?B?dnpNVHloWHRqZ05KTVV1SGRtZWN4K2lIeXd1VU1Eb0Q2VEk0YkpTdnBWY01u?=
 =?utf-8?B?Tjh2K1FHd3ZTK00rcXZ1ak96ZUpNcHBVVmJRU3RuVXF5a3VCWktuYTVhcHE2?=
 =?utf-8?B?YVQ0VmlHTUVYeDFBeHYxbnJjNzErVVdubksxR2ZOdXNRRzhKT3FYTWRUQmdw?=
 =?utf-8?B?MlUyUi85YlNFKzlDU1k1MVBxd0dudHBqVTdmUURkc1dKaGxlZHVTWk9yK3pp?=
 =?utf-8?B?M3ljRW9HM3czMVFxcjFwMnlUOU84eGxNbFBvWXFxTWdsend1VEZOK0xEbFBM?=
 =?utf-8?B?aml0aXQrVU9IRTl0QzN4VE9yYU5hSitjNjBIRVFYeWx6L0JsbmhWZmhsY25x?=
 =?utf-8?B?TjNtYzAxVUJUVjFqbnhDM3dXWHZncjFqM1kyWW1jQ2ZmOUFhdDZOSW9hMHdX?=
 =?utf-8?B?OXNaZzdtVms1UjFRUnQrOUVYQUlZWGl0b3dRZlBtTWE3MDFhNXhkeG4ra1ZX?=
 =?utf-8?B?ZEVWdU9NTE53bThpeE8vZlZPbEVtM0tsWno4bzhDRHJSa04rVEIrM1dZZW9R?=
 =?utf-8?B?dDBMVmVxbUd3ejlFUWFvS0thNWw2QzRCejFEaEFnSzFzSkJsQ3F3dkFycm5w?=
 =?utf-8?B?TGxuNUlHNGNIS0svRXJCM3BZVktGSEZ5NDNQdzQwdUxJS0JoRlRmRDJIbGFU?=
 =?utf-8?B?MUZNQjYzNWNrMnk2VFg5d1o1SFFGeFMxa3JvUTViVVBrbVhFVXpJazNvUDJS?=
 =?utf-8?B?cCt0bTdycjhSM052cDlwTWVFYUxhQ0lIN3BxMDVTQ0EyZDhTN2ZNUkVySEg0?=
 =?utf-8?B?VTB6eVZreDFUcklwY2J3SVMwNnRQV1lOQWtOWTBSZmlkSmt6b2xkZm9ZY2dz?=
 =?utf-8?B?MHprQVRFT09NMXNrNUNBVFVjdkoySTRwTm0xWjJJNnVDa1pObHgwMnBpNGpC?=
 =?utf-8?B?MmFOb2tFOWFsNFhaamJLWVcvWThWS2czQ2pHMGdzckZ5dXVPcnNZaUZqblpY?=
 =?utf-8?B?ekxQeUMzSW1mNHVLZ3VmZ1hKSzFLaXQzSVRLYXYrem1pQ1lkL3lFTTdCVUow?=
 =?utf-8?B?cWVIdEVmM21VUmRlYnF5d3dqTXRpWmttWU1UYTZ2L3diL3pka0JGWmVqMWVT?=
 =?utf-8?B?V1VSK0xYM1EwT0lraTgyWDFxMjFYMEdwMVd3M3QvOGFuTGFLV01nSHJKY1BS?=
 =?utf-8?B?R3dscXVGaytTNTAxTWFINjA1U09KNHBGWGdCaS9VYjd4U3VwUGVhc1NIdExy?=
 =?utf-8?B?aXI2MWF4S3hiR0Q5K09DTHFpbHMweGZtTHQrb1JxVEkwNmpmR1VFY3JadzVs?=
 =?utf-8?B?d29LQzVlL0ROU1hmL0tBVkhWYlJLYXFxVnpLMWUrSnJqUFJGckVkRmdnOUph?=
 =?utf-8?B?ZElZMHpySzN4aUdLYjd0NWh5LzlsRTdUTzhVYzdTRVZZejVLN0dwRkpJSGZx?=
 =?utf-8?B?ZktFS0RYVGI0WThncW5mcW95VlplNy9uSnROdkJzL3ZCdGJzaUQ0VXN3N2pj?=
 =?utf-8?B?Z2o4UTVxaDVzSXFKY1RCSzRkTzh2aGhBVVVBL0s0NE04c0RrNWNHL2RiNVZj?=
 =?utf-8?B?SDBsL0o5SS9LWkpwcERFempSWnlDZ0wzWUJUNHN0Z2ltWkZGdmVWd0V4N2NM?=
 =?utf-8?B?NzVSczF4NG9BeXp6YkdzL0hZQ1RQelZwTmJXRHh4cjVyQzJnWDlhd1NHTzBJ?=
 =?utf-8?B?a1E9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d12ca97-8dd2-49c7-8977-08dd4cdffb60
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB7135.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 10:11:43.7165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QONq6gQC5tGi9230iOM2g8KKeWhLQveObhxi5v38kNZ01D7gYRBx+cp1/xWJXpgsua+2fTXrCIYsaLWBXI1p0LzHnNiIhjN9Cv7Ho4zDtb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7174


在 2025/2/14 17:51, Jerome Brunet 写道:
> [ EXTERNAL EMAIL ]
>
> On Fri 14 Feb 2025 at 10:13, jiebing chen via B4 Relay <devnull+jiebing.chen.amlogic.com@kernel.org> wrote:
>
>> From: jiebing chen <jiebing.chen@amlogic.com>
>>
>> Add the audio tocodec for s4, add the 8 lane support,
>> add the mclk and sclk enable event when start data enable auto switch
> Again, incomplete description and mixing things together.
>
>> Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
>> ---
>>   sound/soc/meson/axg-card.c      |  3 +-
>>   sound/soc/meson/g12a-toacodec.c | 64 +++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 66 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
>> index a2dfccb7990f3a53f508fc6724b21de53b4494d8..5cef069c3370257d4aaf24d7270482651babcfe1 100644
>> --- a/sound/soc/meson/axg-card.c
>> +++ b/sound/soc/meson/axg-card.c
>> @@ -303,7 +303,8 @@ static int axg_card_cpu_is_tdm_iface(struct device_node *np)
>>   static int axg_card_cpu_is_codec(struct device_node *np)
>>   {
>>        return of_device_is_compatible(np, DT_PREFIX "g12a-tohdmitx") ||
>> -             of_device_is_compatible(np, DT_PREFIX "g12a-toacodec");
>> +             of_device_is_compatible(np, DT_PREFIX "g12a-toacodec") ||
>> +             of_device_is_compatible(np, DT_PREFIX "s4-toacodec");
> There is no need to extend that indefinitely, use fall-back
>
>>   }
>>
>>   static int axg_card_add_link(struct snd_soc_card *card, struct device_node *np,
>> diff --git a/sound/soc/meson/g12a-toacodec.c b/sound/soc/meson/g12a-toacodec.c
>> index 531bb8707a3ec4c47814d6a0676d5c62c705da75..a93a91136e8ea00e856c3981b9c1e7e08d927a3b 100644
>> --- a/sound/soc/meson/g12a-toacodec.c
>> +++ b/sound/soc/meson/g12a-toacodec.c
>> @@ -41,6 +41,9 @@
>>   #define  CTRL0_BCLK_SEL_LSB          4
>>   #define  CTRL0_MCLK_SEL                      GENMASK(2, 0)
>>
>> +#define CTRL0_BCLK_ENABLE_SHIFT              30
>> +#define CTRL0_MCLK_ENABLE_SHIFT              29
>> +
>>   #define TOACODEC_OUT_CHMAX           2
>>
>>   struct g12a_toacodec {
>> @@ -107,6 +110,33 @@ static int g12a_toacodec_mux_put_enum(struct snd_kcontrol *kcontrol,
>>        return 1;
>>   }
>>
>> +static int tocodec_clk_enable(struct snd_soc_dapm_widget *w,
>> +                           struct snd_kcontrol *control,
>> +                           int event)
>> +{
>> +     int ret = 0;
>> +     unsigned int mask = 0, val = 0;
>> +     struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
>> +
> Over complicated for no reason
>
>> +     switch (event) {
>> +     case SND_SOC_DAPM_PRE_PMU:
>> +             mask = 1 << CTRL0_MCLK_ENABLE_SHIFT | 1 << CTRL0_BCLK_ENABLE_SHIFT;
>> +             val = 1 << CTRL0_MCLK_ENABLE_SHIFT | 1 << CTRL0_BCLK_ENABLE_SHIFT;
>> +             ret = snd_soc_component_update_bits(component, TOACODEC_CTRL0, mask, val);
> All this could be done in one line and be actually readable if you
> properly used the BIT() macro.
>
>> +             break;
>> +     case SND_SOC_DAPM_PRE_PMD:
>> +             mask = 1 << CTRL0_MCLK_ENABLE_SHIFT | 1 << CTRL0_BCLK_ENABLE_SHIFT;
>> +             val = 0 << CTRL0_MCLK_ENABLE_SHIFT | 0 << CTRL0_BCLK_ENABLE_SHIFT;
>> +             ret = snd_soc_component_update_bits(component, TOACODEC_CTRL0, mask, val);
>> +             break;
>> +     default:
>> +             dev_err(component->dev, "Unexpected event %d\n", event);
>> +             return -EINVAL;
>> +     }
> ... and nothing explains what is being done and why ...
>
>> +
>> +     return ret;
>> +}
>> +
>>   static SOC_ENUM_SINGLE_DECL(g12a_toacodec_mux_enum, TOACODEC_CTRL0,
>>                            CTRL0_DAT_SEL_LSB,
>>                            g12a_toacodec_mux_texts);
>> @@ -143,6 +173,14 @@ static const struct snd_soc_dapm_widget sm1_toacodec_widgets[] = {
>>                            &g12a_toacodec_out_enable),
>>   };
>>
>> +static const struct snd_soc_dapm_widget s4_toacodec_widgets[] = {
>> +     SND_SOC_DAPM_MUX("SRC", SND_SOC_NOPM, 0, 0,
>> +                      &sm1_toacodec_mux),
>> +     SND_SOC_DAPM_SWITCH_E("OUT EN", SND_SOC_NOPM, 0, 0,
>> +                           &g12a_toacodec_out_enable, tocodec_clk_enable,
>> +                           (SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD)),
> Drops the .autodisable without a even comment
>
> AFAICT, could be done like the other SoC with SOC_SINGLE_AUTODISABLE()
> with properly chosen values.
>
>> +};
>> +
>>   static int g12a_toacodec_input_hw_params(struct snd_pcm_substream *substream,
>>                                         struct snd_pcm_hw_params *params,
>>                                         struct snd_soc_dai *dai)
>> @@ -236,6 +274,10 @@ static const struct snd_kcontrol_new sm1_toacodec_controls[] = {
>>        SOC_SINGLE("Lane Select", TOACODEC_CTRL0, CTRL0_LANE_SEL_SM1, 3, 0),
>>   };
>>
>> +static const struct snd_kcontrol_new s4_toacodec_controls[] = {
>> +     SOC_SINGLE("Lane Select", TOACODEC_CTRL0, CTRL0_LANE_SEL_SM1, 7, 0),
>> +};
>> +
> No. there is no reason to add that for s4 and not for sm1 which has 8
> line HW support too. That clearly shows up with #define used.
>
> If you must do that, please do it correctly without leaving the other
> platforms behind.

Hi，jerome

for sm1 tocdec reg, tocodec only support 4 lane

bit [19:16]

0: tdmout_a_dat[0];
1: tdmout_a_dat[1];
2: tdmout_a_dat[2];
3: tdmout_a_dat[3];
4: tdmout_b_dat[0];
5: tdmout_b_dat[1];
6: tdmout_b_dat[2];
7: tdmout_b_dat[3];
8: tdmout_c_dat[0];
9: tdmout_c_dat[1];
10: tdmout_c_dat[2];
11: tdmout_c_dat[3];


for s4 tocodec reg, tocodec support 8 lane

bit[20:16]

0: tdmout_a_dat[0];
1: tdmout_a_dat[1];
2: tdmout_a_dat[2];
3: tdmout_a_dat[3];
4: tdmout_a_dat[4];
5: tdmout_a_dat[5];
6: tdmout_a_dat[6];
7: tdmout_a_dat[7];
8: tdmout_b_dat[0];
9: tdmout_b_dat[1];
10: tdmout_b_dat[2];
11: tdmout_b_dat[3];
12: tdmout_b_dat[4];
13: tdmout_b_dat[5];
14: tdmout_b_dat[6];
15: tdmout_b_dat[7];
16: tdmout_c_dat[0];
17: tdmout_c_dat[1];
18: tdmout_c_dat[2];
19: tdmout_c_dat[3];
20: tdmout_c_dat[4];
21: tdmout_c_dat[5];
22: tdmout_c_dat[6];
23: tdmout_c_dat[7];

reg offset ,and mask is differnet

in addition to this

add bit[29] : enable tocodec mclk , bit[30]: enable tocodec bclk

we want to auto enable bit[30] and enable bit [29] when bit[31] enable

if not add the autodisable event, we can enable it on startup api, 
disable on shutdow api ?


>
>>   static const struct snd_soc_component_driver g12a_toacodec_component_drv = {
>>        .probe                  = g12a_toacodec_component_probe,
>>        .controls               = g12a_toacodec_controls,
>> @@ -258,6 +300,17 @@ static const struct snd_soc_component_driver sm1_toacodec_component_drv = {
>>        .endianness             = 1,
>>   };
>>
>> +static const struct snd_soc_component_driver s4_toacodec_component_drv = {
>> +     .probe                  = sm1_toacodec_component_probe,
>> +     .controls               = s4_toacodec_controls,
>> +     .num_controls           = ARRAY_SIZE(s4_toacodec_controls),
>> +     .dapm_widgets           = s4_toacodec_widgets,
>> +     .num_dapm_widgets       = ARRAY_SIZE(s4_toacodec_widgets),
>> +     .dapm_routes            = g12a_toacodec_routes,
>> +     .num_dapm_routes        = ARRAY_SIZE(g12a_toacodec_routes),
>> +     .endianness             = 1,
>> +};
>> +
>>   static const struct regmap_config g12a_toacodec_regmap_cfg = {
>>        .reg_bits       = 32,
>>        .val_bits       = 32,
>> @@ -278,6 +331,13 @@ static const struct g12a_toacodec_match_data sm1_toacodec_match_data = {
>>        .field_bclk_sel = REG_FIELD(TOACODEC_CTRL0, 4, 6),
>>   };
>>
>> +static const struct g12a_toacodec_match_data s4_toacodec_match_data = {
>> +     .component_drv  = &s4_toacodec_component_drv,
>> +     .field_dat_sel  = REG_FIELD(TOACODEC_CTRL0, 19, 20),
>> +     .field_lrclk_sel = REG_FIELD(TOACODEC_CTRL0, 12, 14),
>> +     .field_bclk_sel = REG_FIELD(TOACODEC_CTRL0, 4, 6),
>> +};
>> +
>>   static const struct of_device_id g12a_toacodec_of_match[] = {
>>        {
>>                .compatible = "amlogic,g12a-toacodec",
>> @@ -287,6 +347,10 @@ static const struct of_device_id g12a_toacodec_of_match[] = {
>>                .compatible = "amlogic,sm1-toacodec",
>>                .data = &sm1_toacodec_match_data,
>>        },
>> +     {
>> +             .compatible = "amlogic,s4-toacodec",
>> +             .data = &s4_toacodec_match_data,
>> +     },
>>        {}
>>   };
>>   MODULE_DEVICE_TABLE(of, g12a_toacodec_of_match);
> --
> Jerome

