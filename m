Return-Path: <linux-kernel+bounces-314679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C995C96B6FD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26E8DB2CAED
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F901CEEA4;
	Wed,  4 Sep 2024 09:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="b/Fj0jRZ"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2132.outbound.protection.outlook.com [40.107.247.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2852136657
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 09:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725442242; cv=fail; b=OKQCzal3GsU4MUJgItoqdP+6r9NTj9BCZbYbgzyGYWbWTR3E8HFCLi3qJl1CqKynQBvJXzxfHJN3C1md6+OIZgfiR2dNpTzkgMpo3xpcxMShm2tsv4spQzuMe1kbTLIf/VSIWbIB8GKxUQvtbVHCYaTZJ4o4/C5WOsNiMZ2qCDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725442242; c=relaxed/simple;
	bh=suUCRW64Y2omyt9lB5vbLb7kxHPnyklx3pK4d6hk0nM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fdvP9SO9Zo8RIZxpmZKPgcj60jwY0+7WR5J0RUHjU9HyBchQAgcGBh0zof30zwJHiPuJJRZn2kzGZWQQMAoZlAYw0FkyuXT3AgicO5UiriFVMrPFiAdzF4oENYUFWP60ckWsVOfvIZC+hvDUfzq62JUDw8DU2f/zNpi2yXXrUWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=b/Fj0jRZ; arc=fail smtp.client-ip=40.107.247.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0XFfh/4c1d72UtiZR/gf4OuavJYMCM5xO0k/mag639JCbfaVuMaRHqqo7wmazT344NjEbTVkoQzrhkTfz1LJhI7z0UEhD38RiMQfMZZfy4kZyDkhxeDd3bvYHYXuyYlmU4TTD2SprHOdk6c4h3GpKlGkrHaOjbF9xoHpXi8SNFCV3qZNu08Dr2iw2UemnIWO/na82QuTWKjcPGt51z5a2Jasl0ksTFtluSphN5HCAdIl21I0Qr+OCOY0A1T1RoleckFseRZtiO488O1up8LMpJHoM/xme25+7pIGoxQPAwzFVQT9RZrgZrhMQmzTZ+1PaZ/4MTbYy1GH6HR9XGdDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+fq9en63WRIQf4cNzxybW70B53kioWZmc6HZ3YTyGA=;
 b=Htm1D78lYmW1KOO8tSh7AamdztUzGgN9Z2T3W70a/fa2uftkTnaK3rymkFY2Vv2vG7/l5tuAKGe9iimvbXMS/Cq8AWJ9caBThQstpZ/WyxDfA2jPyDaVjOYH9OSwThXjAERm5+9Wun3kSKEVatdYEEfDtcoeedIULqnWco0tYzjf/tKX+A4Cb9lL/s4QaSrcsJnMifELZGN/ifv15E30Yfod+46oXWHorhXRndsjpeG9/lwVgswi6SRVO9XhSCLFIHeM2R3Y9aGOVX+p56yJGqm7UD8NZgEbxHz2ZB0eJq/ay1vxCUbRVAHlyXFE739mCEucThapIk07WN1rH4Yg8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+fq9en63WRIQf4cNzxybW70B53kioWZmc6HZ3YTyGA=;
 b=b/Fj0jRZRGeXm8KMxc1ETYDGmksvJ+HPgJVScQu9YQqugcEsFTbYiLZwBk8jxSus4F295W+BXaf9NlBHZ2xedP1QhYzL3fFqbqYHXZNNcuvTQDXe5HsQ+JILZKucbMnNnMNc4YtPn/cQGeS/S+t6PlNxJ4oYAPts4NgXVpDcOgM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DB8PR10MB3750.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 09:30:36 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%7]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 09:30:36 +0000
Message-ID: <3d1a6153-61c8-46a1-afaa-ec4e79069174@kontron.de>
Date: Wed, 4 Sep 2024 11:30:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 2/5] phy: freescale: fsl-samsung-hdmi: Simplify
 REG21_PMS_S_MASK lookup
To: Adam Ford <aford173@gmail.com>, linux-phy@lists.infradead.org
Cc: dominique.martinet@atmark-techno.com, linux-imx@nxp.com,
 festevam@gmail.com, aford@beaconembedded.com, Sandor.yu@nxp.com,
 Marco Felsch <m.felsch@pengutronix.de>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Lucas Stach <l.stach@pengutronix.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 linux-kernel@vger.kernel.org
References: <20240904023310.163371-1-aford173@gmail.com>
 <20240904023310.163371-3-aford173@gmail.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20240904023310.163371-3-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::7) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DB8PR10MB3750:EE_
X-MS-Office365-Filtering-Correlation-Id: b9de1259-ebda-4686-fcaa-08dcccc43b4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkNJWk00ZUhWNWhhcE5QQlRYOHdzejBRMVZNcHI1aHA1MzJZSVNuY0tGTDZB?=
 =?utf-8?B?cysvTU5tdG5ocGQyYUxqdVFlTkhTR1B0RFdHRi9Ha2JadVlpaW1XNFpIYzY0?=
 =?utf-8?B?N2VxRzlZK2o3UUV4UWVQYUJBQWJJN05PdjdyOUw3aDhlOHJrQlVsWUtCSlhI?=
 =?utf-8?B?OFRaTjdvc2trOXduUFFIK1p4LzFBeTJ5dDhyTk1XNHM0cU43ZlZ0VXJkaDFV?=
 =?utf-8?B?ekdZT3R6a3hCSlZzZG4wSUtzbmVkT21NeFRVSm0zNVBmWmVrbnRobWVoSlFW?=
 =?utf-8?B?RWwyRndMeW93ZkFWVlRvRDJMbFk4bmlsVUhKVGc5bnRrMURtR0pyUmpiTS9C?=
 =?utf-8?B?NHZQaUc2c0pBUTNHUWZTZmk1ZDhBOWRCdzloakg5b1JSdnV5NnQvYllOTnc2?=
 =?utf-8?B?WktWVlhSNnFVOVNwR2NJdklCRVZDeWdSOC9CZDlTQzBNdXRucGUwNVAranJk?=
 =?utf-8?B?cWE0VFJUSTg2M29BVmdCWXBFS3ozQjArNWNZUUZRQUEvRmdONFpKNjdud3p2?=
 =?utf-8?B?UC9VTjc5aDFnK2NEVEdha3NRdTFRbVVQNG5PYVFlNjBzZGhlTXcvR1JaS1Bn?=
 =?utf-8?B?TWNBWW5OSVJJTkNZRGdvdWdwOThvVEJiT2lEVVIrNkdsdHQrTkExbVFNcjlp?=
 =?utf-8?B?Y0ZSUzJLUC9xZWZCOE92aWs3bWxwWTZ0K1FtZWdNQm1LVVJIQlNvZWlyK2FP?=
 =?utf-8?B?WnhoVlNoeXg5bUU5Yy83bnN3d3ZhNi9hM2l0YllWY2VaY2pESDY5aVNzTXZu?=
 =?utf-8?B?Tkt0b2NnMlVpWEZiZlZaZ1RXVXFMN3lYQWhWb2JlWXlUTlE0MEZ5TGdnSlVU?=
 =?utf-8?B?N0VQbXdpWk1scEdudFBmT1VVMzFXQktLWDRqOXAvTXZ5dFhmRlgwaUlJcmw1?=
 =?utf-8?B?dzJnaVB5NGdsbnFncUY5MURSK2QxYzc3c3BjZHI4K2xMT3IrS05sd2JsV3JQ?=
 =?utf-8?B?UnBVcjVCSXo2TFNqSnNMYU5nNHpZUlR4bHRHdmNibDFTUkpwd2ZTZWNWaEEw?=
 =?utf-8?B?enN4ZEhQbUNLZDI1Zjg3NEJjQ21FVWxFQ0xLYk1haU5EYmx5ZlQxcFoxVzZQ?=
 =?utf-8?B?WW9Oc21DaSsyaVNzdUlxS24rbFhTOC9mTVVRTWFBVjlhU3pITVIyVlZhQkFl?=
 =?utf-8?B?azV3aHVEMDl6SzZTTEFxNGFCYm8ydUZ2cXBHNnBIcFJjcGRmSUtvVHZJSTdr?=
 =?utf-8?B?azFFZW5hM2tJYkhFaDdxUi9uUHlLMkNYMU1QUWFRVXdkc0xleTVkRlNIaG9G?=
 =?utf-8?B?cmJUa2ZpcWppU25XWVQ4RUp5OVkxdGF5MEVZajUxS2V0anRxeFZLbCtCcW5O?=
 =?utf-8?B?bjhBWXk3THU4SExiU3BJeCtqNk1XNDdna2wrZlM0NlBRQk1IRXpIdkxWbFZC?=
 =?utf-8?B?aCtyUllSeEpZSlk0UzU0SDhpUDFSckw4cHRGVGNPWmY0YTQzV25xdnJTanRn?=
 =?utf-8?B?MFpEazVRb0JPNWw1ZDZyN3pjcVRpVkpobjAxdjN5dWlacGFwUlAybzlXc0sw?=
 =?utf-8?B?QTFHL1cxK1FLeFNDNmQ1NnUvejY3R1J5czJCRGVpek5MbFRGVXN6SHBJSUFX?=
 =?utf-8?B?L3A3b2hDSXhmVCsyd0lNTVFCVE1idC9HbHN0Y3Y0SktpcnYzWTBET0s4SXNi?=
 =?utf-8?B?UGNJRStISk40U2Z6YWR1Zy81bzhDNFNiWXVUMmt2U3lwZDQ5U3UzTDczdlVD?=
 =?utf-8?B?TGFJUG91VlJwTGN6M1FHckJNQTVOTFp4SGxZZXNPak5iRXZHeGgvYlUwczhj?=
 =?utf-8?B?LzlZbUlhenZ6SU1ISldhbzR5T251TUh3bGJLTUpyV3dCZFkwUEthNkNsUHdL?=
 =?utf-8?B?ZVdZTkoyTDhiTGlPMEtrQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVJPY3VxaTlzNUZnY0hNMGpZMWxTdDRNMlRtTmttQlJIRUxKclpmRUhRdTEx?=
 =?utf-8?B?L3NpRlRUdVl6cmpxYXRpM2poZklDcDdMNDBIWWVGNWg0NVZPYjB6Yy9IMGc1?=
 =?utf-8?B?VGEwNmtYV2hvRW5FMmtpMjZZZ1JVd1BSL2JIckVndkNtbUs4dkRmdFhVczNQ?=
 =?utf-8?B?YUZnZFJZQk11NXlsN25iVXd1VjFQRC95ZndHR2NqU3M5MVlGSXYrV3ZqZkdk?=
 =?utf-8?B?a1d2b0l5SkFMUXkzTzhEa2p0SHE3K2dvL1JyOUVxbzVJYVd1MjFiTkllSHcv?=
 =?utf-8?B?QUdITGJMQ3hEU0RRV0pXeDY5MnplWURiM1ZDendzMkFNWkJ4OGVTZVlKemZq?=
 =?utf-8?B?MWtNbXJQT3RpUGsyc2ZBcnNnUkxnLzVSbzBFMHRhTSs4WFgrNk1aUjNsWnZh?=
 =?utf-8?B?OUhKNk4rQy9yM1NaUmd2Uk1xL0JhT2pIY212Uy9VaDlZelJ6alZ3TEhkRVpI?=
 =?utf-8?B?Q1hNcmowckRUejhLYXUzZVA5Tlh2LzdLSWtrVGprWjF1Ym53ZWgvYmpmckpC?=
 =?utf-8?B?YVYwYkErQmVVOWVrT2ROdFRSaVVRZWNxZS9YSmpRV2VOWG1Oa253VUJKWitV?=
 =?utf-8?B?QklkMHdGZzFJaGx2eGFrSXZRSkk3NnhVOUtZNkNYMWtRNmI1VHZ4OFYwVmlW?=
 =?utf-8?B?c0k1eDE3c3BYaVdkRjVYdHd5TlNpZzljayszTi9XTkVLQWRXa0xoWEJyZWQ3?=
 =?utf-8?B?eE4rSEJhY3l3OXlsZGlWY2tOK1lVSHpSNjluYVU4eUtJaWxVQnFPTjdRRFhl?=
 =?utf-8?B?VVRieTkxK0xPcFNxeVdheklPajdZNFAzcllKY3FuSncyczM4ZzY5Q3NaNStw?=
 =?utf-8?B?WkdxL0dCdzU5bUd2ZFdsa1VDYXVrZHpYZ2JlUHhuS1YvdENLS2tyZ0pOekRw?=
 =?utf-8?B?VVZPMGJQTFBHZXR5MmZheTQ3YVUrNm1XL2dIdXZRRm1tcnR1cjEvTDlSa1Vi?=
 =?utf-8?B?K1NkWE02b1VsNi9RSzR6MWQ1MHdYMHlJTGZub3JmK1V5aFdtK3h6OFVFRlhm?=
 =?utf-8?B?dkQ2RXpERmdBMjFWWGtMTHFvSlhLYStnMDZxbUZOYkJlZEs5M215MXlrUUJL?=
 =?utf-8?B?YVQyTEg0UmMwNC9KdGdWR3BsbFJvZUo3ZjhmdXJQZm9qM1ZrTmV4Vmh3bk50?=
 =?utf-8?B?ZnNNNml0UFJESUlaMlJZT2ZqUEE3UnRoeDVWQ3JOdi8vZGI2WCtodEQ4QnU3?=
 =?utf-8?B?MHl0clRzQUFkSFlJdTE5SWgyTzZ3SVE3MmFvaGIwNkp3Y050TjdRYTJ2Y0sy?=
 =?utf-8?B?d0VBRjgvcVQ0aDdnTTlKTzRGWTQrTXhmOWVyaklHdmF1L1h3T1Nzdm9jVGFM?=
 =?utf-8?B?c1dtRVhmUzZKenVZc0wxVVFjS2VxZ1VzQkxCQlMrbU5CK0QyRko4QzNSQlQw?=
 =?utf-8?B?YkRSUFJGRTRaQ2FUcSt6ZmxUcGZKQUxxRWVxV3NkMW1XejA1b2lrRzZJUEl2?=
 =?utf-8?B?ZEpnekxGdDZMRXNvaitlemlWRGRqSS9Vd1RORmc2WW1KaTg2alc5WFJURVdC?=
 =?utf-8?B?c1pUSnU3VXM1RXE2d3pwTzJPRzVaVHpwS24wcTl6am5wZU9VbjhhM0JINytn?=
 =?utf-8?B?ZmVQYU5EYkJWMW8vZlhaZ3FqbXRrVlV2MlFTTCtRNllwUmFJN0FKVldDOW9C?=
 =?utf-8?B?STZNNUNWdXhISzNXYmI4SmNFZDZjeHM5QXJmWkhXZVo5dUhzd1p5RSsycWNy?=
 =?utf-8?B?L2prUmZkUnZpbnYwQTZINEY4NzNOdis1bDdmakRjTVN0RHd2ZklxNFNOMW1T?=
 =?utf-8?B?UHlBSmlpRmV3dGhGN2RPaXBLWXloL0hxSFNvRWVvTzF1RENmQy9kZmVHRTNw?=
 =?utf-8?B?b0czTzlMRDZldWNNZHJCMUF5SEVSNXZHR3Zxdk1uVlZyekowZTV1RUNHUC81?=
 =?utf-8?B?NVJHamRqMDh1S2hFRElMdFhUdGk1WklydDAyZkhTK281TEx3emw4WXdHblFu?=
 =?utf-8?B?SXpkUHgwSHRUWjhKbFQzck9xNkJkdkY1Vlo2dnM1cVBYdHN2cGlEZmJhMzZC?=
 =?utf-8?B?QjUvVEc0VkpMWG40NTJMeldSR2RMWElOOFBjQTlJcU1SaFdOVlhPNWFKWHl4?=
 =?utf-8?B?d2FrR2pHLzNlZ0ZtSEpLaWlCK0o3SUJUY2lZaEFpSUFjQ3NFUkhxNi8xOURQ?=
 =?utf-8?B?UlphNTNZcTB0d2FkOFROYVRwcnM3Qi8zV1hPdzM2T0t3TFE4VHJGV0kvaGNC?=
 =?utf-8?B?a0E9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b9de1259-ebda-4686-fcaa-08dcccc43b4f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 09:30:36.2901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gB2PgIZfgWEf+yUg48IpqzxM78RCia1cbqesNG/T3sS2RoxsV0ur59xr5BxyrdpjQz7XiF0sPw1sY1gbO42yv8FtfhGEHlYQLgihdS+LwYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3750

On 04.09.24 4:32 AM, Adam Ford wrote:
> The value of 'S' is writen to two places, PHY_REG3[7:4] and
> PHY_REG21[3:0].  There is a lookup table which contains
> the value of PHY_REG3.  Rather than using a switch statement
> based on the pixel clock to search for the value of 'S' again,
> just shift the contents of PHY_REG3[7:4] >> 4 and place the value
> in PHY_REG21[3:0].  Doing this can eliminate an entire function.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>

