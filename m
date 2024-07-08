Return-Path: <linux-kernel+bounces-244179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AFD92A056
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B16D2832A8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 10:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62F0770ED;
	Mon,  8 Jul 2024 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="BkHoXuaP"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2132.outbound.protection.outlook.com [40.107.249.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109151DA303;
	Mon,  8 Jul 2024 10:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720435091; cv=fail; b=kzKtfqal3+HG6BKY1IyuA78rV9VTgc0aLseNntNXK3T3j030C7khtop2LQJI49yseGqxGrCSZyccfQKCIohH9nCnc6QPE//8OXQVOiojo2xmOkLBq0AugudKZ5VqC7c+iVViR4ysV5nGKUOYLRIZqTszDQlEE/Yoov2uUbCvHlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720435091; c=relaxed/simple;
	bh=5ySG/IRqoeM7z+CxfnzMviWkmC6GZ+We93KPKPb42nk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ipnWVBlG/9ReH7fRtSJ2uzQ9Sx/69eHez+Cot2dpfCK2+RH9gOolILsUcyYaozVcygT0N8i8iUe54kFjvP9VNmq/scfpsG0r1JT9xUdrDCFj3ZmcpuvdrsQA/z1Io74Q+15IPsJdwOPLPhEbYzZe4tCi3CL3DozzlX4vv422P4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=BkHoXuaP; arc=fail smtp.client-ip=40.107.249.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wu5soK9JmPcgGPVN1fxaz72Lp2mJfwfRlWWCCr3znMnYpg3wz6CUtJnbwL/WQPq9CpCgNkmJPNZ3ZTIcuDxN483Zg8vgH2Z4y/ATxOSMF+DXqXY6c6rgzOGTyLKAwI5f1WrL/SW+T28BDZPuvOFrWVUjbWEe3XEu9QxHDP9p4VSkbtmfTR35AzkXO3Zm68qUvRHGcG+xAOYjXjMz3HMuGrDzbtwS9+iAO3cjsP0bItGGu2MP40Ij3r+Dmflv2CWhqM6GB06w33Ol4BJYyx+uUpAA7a0ncNEMMZJc5bSkdSr2Vfpe8LGiOVNKGiifTInxYGmjZUU8f2e7Xggnl2Ut6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfdiCp0c+exsAwfQYLtz/SZuDcWpJyEJgCWYgBHEZVk=;
 b=O2zOPSRldS97G8QyD2WUzFNETcnNmK0Gp+rBkwraj7P32LW17PCSyTe4XtaBKN/C9b8Gss6+OyfrQWpS1tcw9OeYrqVUigSMTjNJo1fmDAPC4QhJStlNT7ilXMrBjUHPddLgdZcYqFzblbGK1BdkHerzzDPRAvNWrtJO4c6Pyl2qfhDD2MYBgB22cwJivUilQrt/7bvBAmBPDF1iKW+xJoYaYa0rztVyMB2/ot7QyRwNAMEeFlVRCVd3OLA8fNCnH05k4TGM88C4TXqn3ou+LkjyODtAbY5p//bZRrp1sknJfLVzqu//tL6TQbZHjC2CQA59Qe5jMh4uxwT0G+HjiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfdiCp0c+exsAwfQYLtz/SZuDcWpJyEJgCWYgBHEZVk=;
 b=BkHoXuaPayU6QZIPYvKBwv2/6+ELFSKQxPOvhkdYmOngNaZoHUTSnIuPKdXuPEuy7DjhDoYcIhvVW8fLmepc1Wl7ib2J1oS4pcz6ExA3iA8VPBRCoGh7R4dR1Nx5Whvc0T2LzyV9HZc+kiamxmtFVq30QwoCGgrSRfMRuPE2R88=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 10:38:03 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 10:38:03 +0000
Message-ID: <b4218ace-4aae-4fe3-ad27-dd983087d1f7@cherry.de>
Date: Mon, 8 Jul 2024 12:37:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/11] hwmon: (amc6821) Convert to use regmap
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240704175207.2684012-1-linux@roeck-us.net>
 <20240704175207.2684012-10-linux@roeck-us.net>
 <773d8bea-7ddb-4138-b75c-219a52c82fc6@cherry.de>
 <949d9c32-7722-4afe-a8ae-b2ef57d1cf01@roeck-us.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <949d9c32-7722-4afe-a8ae-b2ef57d1cf01@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0041.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::27) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU2PR04MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: 27463341-811c-4e25-8525-08dc9f3a0b6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXJDem5uMXBUTkJ3cm9OMEdkcy9IRVFMZWMvNks5K1NmaWg0NGVPRk9hK2hO?=
 =?utf-8?B?dkhKRzQ4SEd4eXU1NEN3dURWRkNvM2lIVHpTSkF0VWR5UUhsYWpEYnlzeEZ0?=
 =?utf-8?B?Z2VFQjBXM3R1VGU2MVRsaVRjMGRrc0NZNEY2OTlxWWtwYi9BSGdldHJ0WHd3?=
 =?utf-8?B?OGtGTzg0ZFBOamdvZnRWcXpjTGdiZDQrSEtMMGtzR0FpZXk5bWlGNVVSdjFO?=
 =?utf-8?B?bkloWkN5ZjJHK0dFWHkyRWhLUDdnaW5ZWU5oM3dkUHdSNG1nbnFxWVRLVUZJ?=
 =?utf-8?B?aDJya25DNmJaZis4RDExcE5QOVdta1RvY0p0ak1vR1drRkN2Ty9NQSt4OGJm?=
 =?utf-8?B?Tkl6WVMvbi84cGxhUUFxWExkZmI0TUVKTDdRSG9SMU9UK0lreExtaFg0WWdC?=
 =?utf-8?B?N3hXaXhvZi9sd2RWallqd1gwSE8zOCtUcURWQTlZZytpSkNaS2dCMlBubkVw?=
 =?utf-8?B?eFBUVk1QbTZNV3lOMVVVeTk0b3Y3aHlKdnBSS2ZOSjdEUUtETmxPYTRyWmQy?=
 =?utf-8?B?SDdNTTlRb0djM05LOFU5ZUNjSzZYcmswd3FNRUd3cFFSMWVKU2oyZFRpbHZ3?=
 =?utf-8?B?aTk3MnZxZzdCRFl6L0h0WmdzQjRCQU1IeDZHNVVvejI5YTZsN0pINkVJdTNY?=
 =?utf-8?B?YzdoL0w5UVdkVDM3UEFWWmQyUXdvYWlOMmtOdDQwUHJwMDNOMSt1NG50L3Rx?=
 =?utf-8?B?SkxGNWV5MkpiUnVBWDFKWkVYc1N4Z3MyZTlZcmlLdjJLZXMxV3dvWktQTmcx?=
 =?utf-8?B?ekpRTnZEQ3A2alVOQk5BVzBjWEFyTmRrazZEYUlPdjZqeEh3emVYRGRxWWxh?=
 =?utf-8?B?eXJnbEcxc2l4d0hxcWJJRG84cmkxR1NsVEE1QTVrRytWOHVaUkFvUDF6OUZ6?=
 =?utf-8?B?RGZRSGF2cFR4OWlsTXc3U3BiSFp4ZnJSZkdyMXM3eFFqVGNjN3l4aG1ETU4z?=
 =?utf-8?B?S3lzOUtaSDFNRVNna1VtcUg0Tm9xK3hyMTArT0QzK3B4Tm9EcktmTnVla3JV?=
 =?utf-8?B?VVBnbDBGdTIrNVNBbXU5MjIvblI3RTZIRnByWkI4VHBMNkZIRzFEYlJ0OTRD?=
 =?utf-8?B?S3NUY3BsdUVQM1hCUFhOVFAxY1NpRWx6aUF3S1B0OTBwZ05QWWt6T0wreWZM?=
 =?utf-8?B?K3NJclR6aGZ5ckF0R0tycTRZTGVBOUVtQU1lRFZMOUpNc3JteE81T1JNNU5x?=
 =?utf-8?B?Z0c3ZTcwSFNCVTFxQ3BBdWhnbDY2bmo2eCt3emtPUnJpYWhwS3p3VHZDT2x4?=
 =?utf-8?B?S3NqU0NLb0w1L1FnSVMvVGN4TnpGMEhzbFdSTmUrUHZVYTBTUGY2dWtoRk1T?=
 =?utf-8?B?ZEE5V3FOY1pHRHBTckFnMWRGQUFxbWJBN3FYLzRhV2JIQ09xWmp0bmpvV3VK?=
 =?utf-8?B?S2ZFcWxRMkZFZlB3QmszMkJyNkkrTlY3U2taaUgrMkR4TFg1Q1pKZEQwZE45?=
 =?utf-8?B?TFFDV1IwMWh2UW96SUQ0UHkzK2NVeW9PakFUVS92SGtrV01FMWlhUVoyZTht?=
 =?utf-8?B?SFFnZ3RxcDRLMGVjTWdaU001ZFdVY2JXKzJKU2ZnLy9YN2IrdUx1ZVhadVRE?=
 =?utf-8?B?QUR0V2R1SWMzb3pQS0dlRWNCTDlqU1g5TUxCRU9nbkxEUnd2T24wUnJJdW5B?=
 =?utf-8?B?Q0c3bkN2ZHk4Snd5b2d2eUt6ckxKai92cHNSTzlRc1FCTmMyZ2wxMXdhY2lv?=
 =?utf-8?B?Q3I5WDJDQWRERUc0cWNyTmQrbUg3VkxQWmdLcitmbmR3aTd2bmRyOThxMnI4?=
 =?utf-8?B?aUdycnl1Ykx4bzhDeldoM3RXS3hnVE92RlZOcVRmWTN4amRodjE2ZnFiekY1?=
 =?utf-8?B?TVhVUzh0YmZiZDl5aGF2QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWMyVjN1VGxjdEliL1BmN2hHNUc0L3pkOWNUUGdqcTFhNCttTHpZam84cnJ4?=
 =?utf-8?B?Sy9Ucjk1NUxHR3hrQUVLS3lpUHcxRm9McFE5S0p5SUk5OVFlNU42WlB3cDZS?=
 =?utf-8?B?ZXkvT2ZKQWVwZ3BSV0RSOHhycWhQQnp4TllWc2FwellmT1p1bGQ0NzBiSFFn?=
 =?utf-8?B?NG56WE02RVNZQWNyMnJENFkvU2VZcTZxbi95VTk5Vm5qdC9jYy9EZUVnRlZl?=
 =?utf-8?B?NGJLdktHdExyeExscHhQQW0wT3J6QUJDYkQ1T3ppTFN6NllsOSszbGhRek1u?=
 =?utf-8?B?NFUvY0ZCTVNTQndMT01GbjUyZ0pBRG9aaTJRSEN1YnkyUW9HRjlKSjJsUmZ4?=
 =?utf-8?B?OVhoZit0Z2pCYnRjcjR6bXgzN2hPNFJkaDhZVHZOeVB0bXBsYVBXM0xySmRZ?=
 =?utf-8?B?M2FwK21XbWJaR0ZDbzd1MFV2V29yd2tXZWRtUFhpS0l5OEs5d1E0TlQrNDhG?=
 =?utf-8?B?ZEhVZTNCNUp0R0h3a1oveFYzVE9vQk5LMVk1b1g0L3JVb2w1NXlwQktnSlQy?=
 =?utf-8?B?UmN0clVuSyt0cC96bFI2K0JFZmNsSVJSS05aM1BZSFV1bTF0UEdaUk5XWm13?=
 =?utf-8?B?NmF4cHNROFRnT3JIcEowcGxCUHEwNW5PYnFqRVVUbEpOYmtpcjRBVUdLVUx1?=
 =?utf-8?B?UDlSM2RHYU0wWkVxT1d0R3I0QWdBWk45clJENmNDbWZHSHRZQTdiTnpnaW9m?=
 =?utf-8?B?ZzJ2d3pZcGRxMFBLWlBCOEhXcHEvdUtSQ3ZVYkRsTEFIT2NLclI4Tkx4YWE5?=
 =?utf-8?B?K1RlU3A2VG5OSmhUaE5nWnhlbVFUTk82UlRzYzJ4Qm11K1FoWlYwdFQ3N3dy?=
 =?utf-8?B?V0lsRmRZZEhYdmtRR3VzbytGOXd4WWlKc2phMFN0dkZ5bDlhMTBzUjgrUlIv?=
 =?utf-8?B?eTZadXZXM1htVERlMWNRaE5OUjVTS2txUlUwU3dZOWRRV1JUdVQvR3pNSEkw?=
 =?utf-8?B?UmNXcWJNTWIvMDhyZUtJNHQzUjZuSU9mdVM2RTFhYzdsUUR2bDEyVXFGbHFE?=
 =?utf-8?B?bG1SaVJFeFdnMVB6M1NyUGN4bk1lUW1mbUNQRS8wSCtkTHJURUpPRTdvcVJv?=
 =?utf-8?B?QXJCS0x2U1ZyMGcwdEpoU1pJRTVXRWF6c2JVYlFqYUREL25qWWI1eDFpbTA2?=
 =?utf-8?B?RWhWdlFDTnN1aG5qOXQ3SVBFWjF5WHNRRS84M2hFK2pKam9ISE9sWkpwdS9H?=
 =?utf-8?B?MWdvQitVOEE1dTNvdWtpbFkyZTVjTElsUDVpVlpNZW9nY29oeWxtam5xSDdQ?=
 =?utf-8?B?dXQyalY2dFRoYVBFazJNSVpoMEdNOGVBaDhWYmh3RkRJSnowYWhxd3E1Q2E0?=
 =?utf-8?B?cjNhTXY5MVNycU1DYUprU2l4UC9DRk5mdy9Vb2piUnhXbVFlMkZtUXFxQUpt?=
 =?utf-8?B?L3pwVytJdWR0UnMvYVBnMHF0aDhCNFlsLzMwcXJDVHZiRHpYTWFXY0cyd1Nw?=
 =?utf-8?B?dkFhSDBHeG1WQ05SU3FVN1hNQ01ZZGRabldxQ2E5TFprNTZoRGdOUDlDRWV0?=
 =?utf-8?B?c3BvTFp4TEdrZ3kxaFBPbDBEK2RBMFI1NEdpbjNNOWpZQ0hRaUppTFd5L1cw?=
 =?utf-8?B?MUdxM2RLTnBlcUk0K2JWOGZQMGpaZEZWMzB4QmMxU1AzeWdqMU1qeDhwa0xq?=
 =?utf-8?B?V3lSbTUyd3JoUWw4d2ZoODJETm9YcHlnUHFBRTdIRi9jMkJlRitzSlNHMFlY?=
 =?utf-8?B?dG5CYWlSQ05xREpCUjRNZjBjUE1OVHFiN2QySWhyWGozUEdWVDRaRDlCVEpI?=
 =?utf-8?B?bjZUaW1qcTlDRk81alg1MkJUK0taMzB6aHJINHRyTUJQL1ZsZGN5TDRRTzlU?=
 =?utf-8?B?UnV1YlhQRFFqTlpBcWdRb3RnMlQzN0h4NnpyYjN3UWRtU1BNQmN3dHhreEdT?=
 =?utf-8?B?YzhBVVJSOGdFMXJ1eWd0QndQTVczcWRqa25CTEl3S3ovT1E1UXJTaTdlWm9P?=
 =?utf-8?B?bThkVjF6c0F1SitqcVdWQ2kvNDVISzFoM1pqOXQwL2UrT3NMUTQrdGlmd1JU?=
 =?utf-8?B?UU9QRGIzdGpySVJNa1FWcDJqWWNXaDEwYmhGUElDa0w4NFhLWkZBazcxR2VN?=
 =?utf-8?B?YWc4dWhjM08xQ3d3Ulo0MHN0b0NFZXliaVdPeG41KzBvNUIwaEtIUUdNOUlJ?=
 =?utf-8?B?Zm9xTGdObE83MmVUV3oxVDc2SFBMa09TNWtxdGV0NmxpUWszTG9RQTdJcHo3?=
 =?utf-8?B?MVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 27463341-811c-4e25-8525-08dc9f3a0b6a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 10:38:02.9656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JpmBkW1nJa/fZ+1fNNEw8jZ2qKiHlr3xT3m0twS1whCFwCjjbMS+Sg7Brx0uV+0vuZlCTihLMmCmxMshm65j7RnI6VIOMT+OY7I9npJULx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8536

Hi Guenter,

On 7/5/24 4:28 PM, Guenter Roeck wrote:
> On 7/5/24 03:59, Quentin Schulz wrote:
>> Hi Guenter,
>>
>> On 7/4/24 7:52 PM, Guenter Roeck wrote:
[...]
>>> +    err = regmap_read(regmap,
>>> +              channel ? AMC6821_REG_RTEMP_FAN_CTRL : 
>>> AMC6821_REG_LTEMP_FAN_CTRL,
>>> +              &regval);
>>> +    if (err)
>>> +      return err;
>>> +    temps[1] = (regval & 0xF8) >> 1;
>>
>> I think we want to use AMC6821_TEMP_LIMIT_MASK here instead of 0xF8?
>>
>> I guess we could also use FIELD_GET?
>>
> 
> Yes. The value in the register is in °C * 4, so that is going to be
>      temps[1] = FIELD_GET(regval, AMC6821_TEMP_LIMIT_MASK) * 4;
> which improves readability and should also clarify the units a bit
> better.
> 
> Note hat
>      (regval & 0xF8) >> 1;
> resulted in the temperature in °C (shift right 1 instead of 3).
> 

Yes, it actually took me a while to figure out why this 1b shift was 
necessary as it didn't match what I got from the datasheet, but the 
formula was actually (>>3) * 4. Former because the register starts at 
bit 3, so we need to right-shift by three bits to have the actual value. 
Then multiply by 4 because a bit in the register means 4°C.

So yes, much more readable with this instead :)

[...]

>>> +        /*
>>> +         * Passive cooling temperature. Range limit against low limit
>>> +         * of both channels.
>>> +         */
>>> +        val = DIV_ROUND_CLOSEST(clamp_val(val, 0, 63000), 1000);
>>
>> This was already in the original code, but I think 64°C should be 
>> doable as well? The datasheet says:
>>
>> """
>> The PSV ranges from 0°C to +64°C.
>> """
>>
> 
> Yes, but I am sure the datasheet is wrong here. The register has 6 
> active bits,
> which means the highest possible value is 0x3f or 63.
> 
>> And there's a PSV8 bit we can write, meaning we can do (1 << 8) with a 
>> step of 4°C which gives us 64°C? In a separate commit though, to not 
>> mix too many fixes into one, making it easier for people to identify 
>> and possibly revert them if necessary.
>>
> Not sure I understand. Can you clarify ?
> 
> Temperature bit assignments in the datasheet are confusing. PSV3
> means full degrees C, PSV8 means 32 degrees C. That is all in one register.
> On the other side, L-TEMP0 reflects _4_ degrees C.
> 
> Am I missing something ?
> 

No, my brain came up with its own math. Register value TEMPERATURE 
MONITORING section all seems to be 1°C increments (except 
Temp-DATA-LByte since it represents 0.125°C increments for a few select 
registers.

Thanks for taking the time to explain!
Quentin

