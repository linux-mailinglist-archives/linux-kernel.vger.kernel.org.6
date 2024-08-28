Return-Path: <linux-kernel+bounces-304531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1310496215D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D503B2504B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B23F15D5B8;
	Wed, 28 Aug 2024 07:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="pDIh/aKR"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2125.outbound.protection.outlook.com [40.107.249.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E161F15D5A1;
	Wed, 28 Aug 2024 07:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830593; cv=fail; b=YRaGK8rlEko5hVOjMqNXSfZuW7kI/HsrHuIVA2TMgFsFMJ9P/o/Zg8I9tIK/hwlgUbudbjHib6k5TpjieyfnVtYsxogSfw4wBfOJ3a8LM+UXKUM4Pyk36ktzVynW5byr5ynw+lcYlYTCggt3v8xhnSsVI5U8CxwltyYx02i173w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830593; c=relaxed/simple;
	bh=Sq6yu1FeEF/+3ds8qyJtH4aSb2bcf+QQsoCguaIaq9U=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UQO5FxQpmnN50OHm7rZ0rztFnDPfs8oj1BRQ6J1E4MDWNLa05CeydCUMmvF85H6amhKJp7KIOM+GNnUnwTTerNWY85JrDzZvlYp+D4uGEH+pKpiNeo8UDoUdh4M/cziG8tN32u0GasCMSbpYHCGK56gDu3+tMHoYTIWpC3hLIsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=pDIh/aKR; arc=fail smtp.client-ip=40.107.249.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgbAe1V458wmvjlF5bIPWPfHlnNrfE1G7/nwTHDxKWEjlFTgkHQjZi/zNzfxqI4qzOLC4Nv+A5xY3TcTKVJSeYh9yE7waLiLjDuvz3A/0D4byMu8He4LOK2rQ0pmZ/MPyp3LHLXZxAhIYfU1wNsP6TqvcAcaf3v6fv9g9kzLd16GTMPjk3+NMLmFxAANfcvTa+e4H7/KDbKUlqQxasw7uaK6/+ijvUHluT8+yqTuKN9WYIsSwiRtxux4LblZt879jhijP0Nrk8OBuLgvnE4y3oH3oJzSRg6NxMvflKWewFMqr0F8QuRbHu9a4jlFTao+/70tAc+r5C60rGuxwJeLkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOaaFked6w6NV22ks204DM47yyIj4k8qPrntIiBkRAE=;
 b=udnKnYyTj3NbRddkzYNUqVV6Vb+Yv7WNxc1FEuhK4UmF5cboxVLV9KUT5nFkTO98BJNOnL5Ro6TVcZiNA5aQjRceEg/Ln31JvcueLpQvnHhPtEmnpncdnSYouZTRYOXqvI+XuK7KvxDVS1xAw84q+WK1mWsHvzItv5J2/rDuEsI1OcEPaV+tjOBUrAQs5dS4sC32Mu84r/v+9qNe+qaPKfZXBH1pBVmunBMQ9yiePnXuqYHpskLs8+wyxnrwc3OrNKPIR9VaBgmzwd/29964VSmAmeoSIHKhWxS3uNfy85r6UBXicbWVW7JsjmZ9pqvD2IXQwdU4AxNN5rO6qGFdYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOaaFked6w6NV22ks204DM47yyIj4k8qPrntIiBkRAE=;
 b=pDIh/aKRitukFXE45JkDCSQq//vwNb9znrPh2trfKJE3YwpFxEoJwsDPyx1NhWOH39OhZYPueFJ0k1Ifs0NtxPm7GkQdK4LZ0Fwuj5vlkZkgkxifTceoxnMy1tqoUnOsC5IIhJWelLsr8upmsV+XMFzU60GchZti938GYy3X0sc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PA4PR10MB5660.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:265::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 07:36:27 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%7]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 07:36:27 +0000
Message-ID: <475367fc-b65c-4690-9e8e-7b05a118b093@kontron.de>
Date: Wed, 28 Aug 2024 09:36:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: imx8mm-kontron: Add DL (Display-Line)
 overlay with LVDS support
From: Frieder Schrempf <frieder.schrempf@kontron.de>
To: Shawn Guo <shawnguo2@yeah.net>, Frieder Schrempf <frieder@fris.de>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Gregor Herburger <gregor.herburger@ew.tq-group.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Parthiban Nallathambi <parthiban@linumiz.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20240806133352.440922-1-frieder@fris.de>
 <20240806133352.440922-5-frieder@fris.de> <Zs6R6pqpFybPDa31@dragon>
 <b5c280f6-098b-4a76-998e-4b30c8917f57@kontron.de>
Content-Language: en-US, de-DE
In-Reply-To: <b5c280f6-098b-4a76-998e-4b30c8917f57@kontron.de>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: FR4P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::15) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PA4PR10MB5660:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a51cb5-9d15-4d80-4b11-08dcc7342067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b00xUGZuL0ZRanpsR25qWGVyUW03VG9GaVlHdWRaS0VTS3Nyc1B5WmVoVDFM?=
 =?utf-8?B?VXUyTHk5MVlaOFUxa0JXRmdzTXIvajlMQXZ3QmpBcVVES2pUZElwSzN1R290?=
 =?utf-8?B?VU1iazdwM1hPUTN6ZUlhZXBuQW5OLzBVL1BydlZKdGNLcjFaMTVMclIzMHZT?=
 =?utf-8?B?WXR6S1Z1NlVnVktDc2d6L1A5UTdLOXc5RSt3QzZ3RjFKNUdNemlUdFhsblpV?=
 =?utf-8?B?b3NIZjU3Nk83cmQ3TGdnOTFvVVZYaitubTRNNzdrYm1wUythNDZMTUVpUW10?=
 =?utf-8?B?eDVtTFh5NkkzZkNVOEE4MURoWURJWW0wSGhESldqSjNmNVExdGtIMnBaeE93?=
 =?utf-8?B?YktXMnY3WENEWTFWUjUyMy9uclRRRVp1Y0g3OEFCdW9BMFc2Sm9jR2ZUaFpO?=
 =?utf-8?B?Z1dTT0lSTno2dlQ0K1ZDNFNETUFMYnh1d1VhbWladnlhVjdOQjJRdGdPYVpU?=
 =?utf-8?B?L0diMmRnUFd1RlRiTXJGUm1zdVZ2SXhxQ0ErejJIVnNBSTd0dDdzTGJ2cWVa?=
 =?utf-8?B?RWFXSGZIcE94SEw1UU05SGpPbmtmWFk5bVJxUkg3aEl2MnVPZFk0dnJpKzVh?=
 =?utf-8?B?Vmlkc3VYSFNFQllHZ3ZIQitGNWpoaThUaHRJSk5kNk9qaUpVSVFhOHNDSHM0?=
 =?utf-8?B?cEJoL0hLcURSdG5FY3dQSHFDdWFNeC8zWTRuRVhyQVYxcmZIdjVtTTZETkFF?=
 =?utf-8?B?OHJYQnRMUFB0NFV6VjJRUFAycklDN0p3N0t4TEdJRE5xQjNieERrS0pTby8x?=
 =?utf-8?B?Ym9NZG5lbmpLK1pZNVpuSGdMYnVDZy9FYzZvSm1BN2tkSk50TmN4eHVaNy96?=
 =?utf-8?B?V2NNRTBJQys3b1R4bzVVdjM0eDJEcEtDMENZc1VKbXRSZExqR1FjUUw0alYx?=
 =?utf-8?B?SjZJblZzUWJFVG55QW02aDg0dnJsVGV3U3BiM1VvTjREV2xoTXc1NXFibDdC?=
 =?utf-8?B?Q3QxTWxIdEpSWDVLZ1FIMStDbmRjUlJ3MG16Z2EwMGtYYVU1S3VyTlBQRi9p?=
 =?utf-8?B?ODR4cDZPTUo4S0picXJZY2RaNnNZbG9wWDRWVkNSdWtZWXJxb0dQTHZ0R2Q4?=
 =?utf-8?B?Q1lSVDNpbXU5MitQeUVUSk9yQm5ydXErSjJJVFVGQUxVRnlyRGxuWkorZ29r?=
 =?utf-8?B?bmszakRmZXI3Rjl4R0tCZ200K0o1b2hYM01MeDVvVHpVWHZpMFhoYlI2ZW85?=
 =?utf-8?B?dEs5dFBtVHBQbUx6djVJelpUZjd2VnZ2TE9IUm1lcG01UDFpeFZoaFlLeE0r?=
 =?utf-8?B?eU1XbDRNY2VlV0xrOHdWdmNRUkdDM3I2U3FyL283YzgrWVZSLzhZVEsrK2t5?=
 =?utf-8?B?Znd1SHdzYUdzam5BeEFjNDFkeC9yRU5YVDhUREpsV0llRlBBZlZCL0l3YTlR?=
 =?utf-8?B?Tk5hVTdsejFJdTFxMzJZbWhNOEsxMGF3SDQ5cEJ3T3o2YWJTV2FMTXRpWlB4?=
 =?utf-8?B?cGdtUnJvbVhZaVppbHRPblpFSWdTcUtUS015aTQ4OVJ0LzB2UDQ2eTF6bWlD?=
 =?utf-8?B?dGpzaGFZZE85Zm5BaWJqZWdlK29pOFBXcWZhNDVKUGxEbFl1WmtCcUt1eTNh?=
 =?utf-8?B?ZWlIZXIwYWM4L2hpaGtIc2ZIV05xa0M0QlpTWU9RNm1ETVlHQXB1WHExeUcx?=
 =?utf-8?B?aVFSa1U0bzJLaUdjV2FPL0NOQklsUXBLcXZCVldqeWJvV3VEeGV1WTBQdVd3?=
 =?utf-8?B?UXpVWmQ5SGlXUzVnM0c3WWlzWnd2OCtoUUhBWEIvTFJQNm9KbXorRjRFWFAr?=
 =?utf-8?B?RjJETG5XVUZLV0s2bkl0clpCWVNnSGJtdWJzVGdXZm1hNWh1NktaeUIwUWRM?=
 =?utf-8?Q?JEvg3kbHlDeEOAbGX9GSydW57NRzBK9UdK994=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFNrVVUwOW45ajBlVGNkSXlvcnZpVEdWUUtXL2EzY1pwYzBiS2htSURWRXUw?=
 =?utf-8?B?WjZTSlNIcjN5eGN5Y1lEeExjWEpGcnZsWnVuTnRna1hsNW0zckY1Z0pJUEpW?=
 =?utf-8?B?VnlVTXI4R2FsenI2aDJENWdQR3ppZW9nMkdEcVhsTDBEa3JKcE1kZHN4aVEr?=
 =?utf-8?B?NzNiSXoybHk5NUptZnVPRUVUUDhTL21DaTNRVVFuV3pseGl0a2ZrYjhEWDRD?=
 =?utf-8?B?aUY3Qys0LzQ2OG9EK3RuSXU4cHkxc3JhT3hXV1luOWV3L3NJOWRSK0ZidW4w?=
 =?utf-8?B?Ym1BK1pOWnEzTS9SZ3FlMGo3c0hrelA5VEk0S3o3Wk9xRTBGWEFadWVjdzNL?=
 =?utf-8?B?NzZ2Y3dJZFN0ZUdFU3l1QUpUeWcrdURMemp2am1tWFd3WkVzSFprNllrUnB2?=
 =?utf-8?B?SVVRVTNTVy9kZ0tNVGxQbE1YNU40ejFWVTZXMEVuOG5sTC9ySFlGc0EzWGVQ?=
 =?utf-8?B?a0xhRHVKN215NjF4d2dTdmpCWWhYa1dxS2haUlVnRVR0VXA1azRwb0pEeWRX?=
 =?utf-8?B?L3puUmVsOWp1UGFOM0pLYitYbE9WM0RUMUo3NnZsZzFwZE1oc3dMUVd4Z3FF?=
 =?utf-8?B?RSt4d3djNWFKbE5vc2o2ZUNqZjdkeTNBYk41K2VvdjRXclZpL3lxYW1STWxo?=
 =?utf-8?B?VVBlK3ZGb3dnekM2dnVHeEhxQkRlOG9uWDJlekZnK2hGMFFjZXJLZmI2SU54?=
 =?utf-8?B?WEx1aXQ4UTBiR3dsclZIL3BsRUdhbTRQQi9ZaFRKUHBXSWV3amFiQWxXS1JI?=
 =?utf-8?B?b1NzRXluUjBZZkxZajJINFUyTldoRloxL01welNJMjV6V2s5ZkRDbTMxVTMr?=
 =?utf-8?B?RWF4WnpjTGRlMTRURDljaURzTkFvVHUzN0tSZlZWRUJSdDg0K2t3OE5sRFl4?=
 =?utf-8?B?b0JhNTlWUU54dmVXNFZPUXl3Ulc0T29STnBTVTlEQU9tbWRUaWt3cEFGVU9h?=
 =?utf-8?B?UU0vOEc4eGtyQ3FyNDVtRFN5UXNEN1ArMkFVY0hSWlRHMGhaWlJVdjBEakpX?=
 =?utf-8?B?WnRKVVhSNVpmdVltN0hpSkYyT1lZaWR4SHcydTZIdVZzY2RiSTdEN00vdHlO?=
 =?utf-8?B?RXRRRmFJZGVLc2w5ZXhpQ20rb3lUdjM3aTFYeG9IemJMeS9xUXR1WWVHYUp1?=
 =?utf-8?B?UFpnMWNRRXRobnIvUWw5Rjlvd1ZnUEVZd09GOHh3b2Jpd2ZYMkZhYUNCSk5R?=
 =?utf-8?B?S3pGcGJwOUUvbGtrU0RXN0pHZFhZYzJEUUFORURYWlp5NVFyNkE3b2kyRGRY?=
 =?utf-8?B?RytzR2ZVQWZRWTJkcmpGQUYwUXUzNXMxMC9XaHMxbDQ4UDJYY2xaaWg4alBQ?=
 =?utf-8?B?d1VEejdqbjAxeHlaRXJaZVp2V09kSytvL2d3dDg0S3d5cjFqQlVEd2tqZy9K?=
 =?utf-8?B?TTZwUlVJNThYc3BOQlN4OW9qNHlNVnZMRTdmL1JvSUM2c3dKcmVEa2R6ck1R?=
 =?utf-8?B?dVBxTTgwTVRPdkNBczExTUpxTlhyK0RPc1ZNeHg0c0ZNKzRFaXpEc1Q0K3Vr?=
 =?utf-8?B?c3ZVSnlRVmYyMDAycWM2ZDRMWWJIM2ZuaFFUK3hmSTdQUkhkYnVqYUpiays2?=
 =?utf-8?B?UklZdXRtODFlS29XVGRTQUR2Y1BpWFl5TG9Sa3FsQXdWL3VVNmJTbk9UZkJk?=
 =?utf-8?B?OXN6K2QzVGZoemxTc2QzOVpSVG0yellEOVpUMlBObmkvcnZ6Z0grcS8rYjhD?=
 =?utf-8?B?aFV5K2hNYVBXSnlrSUxCdUJTeDRKVDJINC8xSE53NncyTXJ6dkVLdVpNT1pl?=
 =?utf-8?B?cXBWSXBra0hqNmpQL2Z4REMxS0VTcHM0d2RJcEZjTXVySU82SzQxWXJhWWE2?=
 =?utf-8?B?UkhRbFg5cVlha1JEcXRLT2hMSmYwRmNWKzh1ZjhnZlNtSDBWZHpxQ0VhVDFR?=
 =?utf-8?B?aUV2YkU0bXRMY1BTUkM2U0Y2NnJ2bHpPZGt4bzZVVFdjSnJiMVdkd2FTbUdD?=
 =?utf-8?B?cmRyczBjVHJKbGIyeVgwL1orSzUzT0JHOHlBUTZiaWFLN2hiaDd6dGxDRUd4?=
 =?utf-8?B?OG9sWFN1ajN2SjVSUlRrMW5RamZnSTVzdy9VZVJlTFczZ1VNN2FCNXUzeW9X?=
 =?utf-8?B?R3Nqa1kwTG1kbEZGZ1E5UXowWklIcW1UdnAwblh4ak9ESVdRR2NPa0NnTE9y?=
 =?utf-8?B?SFRJNVlNL1VadUtLNGt3UDhxQ3dFN1R2WFByZ01nU0t0bzdKczB1QUg1UVph?=
 =?utf-8?B?bGc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a51cb5-9d15-4d80-4b11-08dcc7342067
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 07:36:27.6749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6QKLDYQj9ZYVY4PtafiO1TCPI3HTfM02N9eC685pgNfGuodeLDfcZ99zljm5hqUiNcxsqzOZ3h8hwgeolQKqzoCLX57pFPshBKrl8HCHt0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5660

On 28.08.24 9:27 AM, Frieder Schrempf wrote:
> Hi Shawn,
> 
> On 28.08.24 4:56 AM, Shawn Guo wrote:
>> On Tue, Aug 06, 2024 at 03:33:02PM +0200, Frieder Schrempf wrote:
>>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>>
>>> The Kontron Electronics DL i.MX8MM consists of the BL i.MX8MM board
>>> and a 7" LVDS panel. Provide an overlay that enables the panel.
>>>
>>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>>> ---
>>> Note: This currently throws the following warnings:
>>>
>>> Warning (graph_port): /fragment@3: graph port node name should be 'port'
>>> Warning (graph_endpoint): /fragment@3/__overlay__: graph endpoint node name should be 'endpoint'
>>> Warning (graph_endpoint): /fragment@3/__overlay__: graph connection to node '/fragment@7/__overlay__/ports/port@0/endpoint' is not bidirectional
>>>
>>> There is the following commit in DTC that relaxes these checks and
>>> will eventually resolve these warnings:
>>>
>>> 84b056a89d ("checks: relax graph checks for overlays")
>>>
>>> https://git.kernel.org/pub/scm/utils/dtc/dtc.git/commit/?id=84b056a89d3c5b6cf6c5eeeafd4c4b14d6333aa9
>>> ---
>>>  arch/arm64/boot/dts/freescale/Makefile        |   4 +
>>>  .../boot/dts/freescale/imx8mm-kontron-dl.dtso | 210 ++++++++++++++++++
>>>  2 files changed, 214 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso
>>>
>>> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
>>> index f04c22b7de72e..d8af069139920 100644
>>> --- a/arch/arm64/boot/dts/freescale/Makefile
>>> +++ b/arch/arm64/boot/dts/freescale/Makefile
>>> @@ -244,6 +244,10 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
>>>  dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
>>>  dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
>>>  
>>> +imx8mm-kontron-dl-dtbs			:= imx8mm-kontron-bl.dtb imx8mm-kontron-dl.dtbo
>>> +
>>> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-dl.dtb
>>> +
>>>  imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-imx219.dtbo
>>>  imx8mm-venice-gw72xx-0x-rpidsi-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rpidsi.dtbo
>>>  imx8mm-venice-gw72xx-0x-rs232-rts-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rs232-rts.dtbo
>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso b/arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso
>>> new file mode 100644
>>> index 0000000000000..b2d593d700e2d
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso
>>> @@ -0,0 +1,210 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (C) 2023 Kontron Electronics GmbH
>>
>> 2024?
>>
>>> + */
>>> +
>>> +/dts-v1/;
>>> +/plugin/;
>>> +
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +#include "imx8mm-pinfunc.h"
>>> +
>>> +&{/} {
>>> +	compatible = "kontron,imx8mm-bl", "kontron,imx8mm-sl", "fsl,imx8mm";
>>
>> Not sure we need compatible in overlay.
> 
> I've seen discussions around this elsewhere. We don't need it, but it
> seems a nice way to express which base DT this overlay is intended to be
> applied to.
> 
> Anyway, I can remove the compatible for now. Your other comments will be
> fixed in v2 as well.

For whatever reasons, the build for the combined DT + overlay works only
if the compatible is in place. Therefore I will keep it.

DTC_FLAGS=-@ make ARCH=arm64 CHECK_DTBS=y
CROSS_COMPILE=aarch64-linux-gnu- -j16 freescale/imx8mm-kontron-dl.dtb

  DTOVLCH arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtb

Failed to apply 'arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtbo':
FDT_ERR_NOTFOUND

