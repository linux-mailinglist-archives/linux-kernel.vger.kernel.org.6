Return-Path: <linux-kernel+bounces-253833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8CC932798
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDA0BB2163B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1DE199EA8;
	Tue, 16 Jul 2024 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cDqHxUem"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013053.outbound.protection.outlook.com [52.101.67.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F2D143754;
	Tue, 16 Jul 2024 13:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721137001; cv=fail; b=nA/RbGzVT++4MGUrV16aBI8geMlPjXUvuZyM9X2AGF4X16cPPu2a3y76G0tFr98ODodWbM3FX/yM9KxrGW7d/CJGU/XkiYbvz/w1oDg4iAjGixYUQLq4pKQUf58QZL3RioaoUSN8oDtndkorJ9nKFFfbV04MW3bPRSo3RSupTQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721137001; c=relaxed/simple;
	bh=HYeVgaOnfaYBIs+b7O3bupbq7atGb5TIkSCvCpn4cl4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DcgwyR3heqgs791cVLABBKsIjuF/MnHpnpfrFmL+m0Amo6vStk5p9+ARaELbNEiyTBD/rhHn+0Kf6pVE3hJ1lrX01tpk3aYQ9eABmGjnLjtEMg7QBWdkT1msHo6SfE+5H84zI4gmXBeLH9me8ozn7QVIuSGqwMJK191NHABKqto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cDqHxUem; arc=fail smtp.client-ip=52.101.67.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hiFf2UJsd1zpCjoWP+m2NV7Xozl3RtO04dWljN7ktxZry+ATTYhzWvF7sxauqsprZAenDXKQOpa5om8BhXR7LKrb/94iprBTmNSNfJWsSzjyus28w5rYCppQL1DZjEmTmSPqLv1Bv8EKBAdA1rPqzUCT5YhItx94mPFpAxS8x+h7cwJEuf9NrS4nJc9E9O3ma0DyLSqM2WgJbHKx5eKlu0DN1vhLa9jl1Uvxxp1KjzsgVkyvM4gWln5B/FUzTICfpr3kSJpyxB3GvTz2ONCj5IJcci1AF3lo8RHa2S+now2wJy/zPIElqkVs1mFKYmWvHFCECmxh2A54oNEiSkVB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOlbg/UR9oaC2HJ7NvYlWnhOFcPZ85iMS/YEtMWqIfw=;
 b=j5BPtOUrhU+RzrxOr9+axI2ddafFx/OlE82KqZVg3c043viQI+tb9Ruz5AWP7fajsZNLo4A+8DtCWS4s8csr5A5zQAFndmybweSJEltikbKU6zCUA/1yUOthIn66unAjaPPU5z31rRy5L1t10OvMD3v6awSK9txOVaFrLC1K3lR4b1hpjGSEe6l4Sw9vajeb6rm0V4F/FbGxkVeQ5s38xyv8TRGmhGTGQApX8BAidRKGTWoDQIu6jzvjAP4Je+hs9jvg9wbNxX4CBhZZ1jYy/xK+I1clAKYgbs4Pldy7/YIKB9NZrSrIpkkuKB7bWWDw8ty++cIuUNAOOHxw5bTPvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOlbg/UR9oaC2HJ7NvYlWnhOFcPZ85iMS/YEtMWqIfw=;
 b=cDqHxUemFrS1vzM64GdWionIkhp2/damfX+wfcjwd7vwLI6cUmiqBgSSJ8YDLFV8dEahuYbwexrhrA2co1QFSN2DYdmFu65h1IpnweXrpSbinsGV0AL6Xmum0v72hIY0oHdFyhkZ/tV7cqlxEThmXqDP+9Ru7x9lf6MRF0NaHk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by PAWPR04MB10055.eurprd04.prod.outlook.com (2603:10a6:102:380::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 13:36:36 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::88b8:8584:24dc:e2a1]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::88b8:8584:24dc:e2a1%3]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 13:36:36 +0000
Message-ID: <5f2c9540-943a-46a6-851d-a851ade8ba47@nxp.com>
Date: Tue, 16 Jul 2024 16:36:35 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: SOF: imx8m: Fix DSP control regmap retrieval
To: "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>,
 linux-sound@vger.kernel.org, broonie@kernel.org
Cc: lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com,
 yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
 daniel.baluta@gmail.com, kernel@pengutronix.de, shengjiu.wang@nxp.com,
 laurentiu.mihalcea@nxp.com, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>
References: <20240715151653.114751-1-daniel.baluta@oss.nxp.com>
Content-Language: en-US
From: Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <20240715151653.114751-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0104.eurprd04.prod.outlook.com
 (2603:10a6:208:be::45) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|PAWPR04MB10055:EE_
X-MS-Office365-Filtering-Correlation-Id: c97ac2ec-b3dc-40b5-4285-08dca59c5071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkJjYkducjJGN2h1eEJXS0htQkpLL1BlTjYrNjBDZzBEMlJranpteTRvM2RY?=
 =?utf-8?B?cmYzcURjTVFnc1MzVFhqNTBSR2JSSXpRSzY5RWpqVHgyS2FUemZ4SkpsZVZa?=
 =?utf-8?B?c2dWak9nOG41cXQrb0Exc3gzNWUrazJTbjB0TTVvODQzOFlvdTRWdk16QThs?=
 =?utf-8?B?VTJwZmVhd0VVZ2o5UEdVdHZyUit1UmcrSFBHZUhTK0ZGcTJjeXlLc0xoMXlw?=
 =?utf-8?B?SnQ2Qm8vVjk2Y1A3L3ZEQVdMbG13dzhqNmhrVHc1TjBZM0N4L2d6NGhmS3Jn?=
 =?utf-8?B?ajdDbndiN3IzdXk0R2tOVzk0TFdGeWR4Rzh3L0wzcE0yTVkrcVRUVytFSExr?=
 =?utf-8?B?UCtjRW5oUnNIaGVKQmNlVng3cHlyVmJqcjhkRlpybXNoUm00V0wxM3ZYN24r?=
 =?utf-8?B?d3owL2JPVDdZUkh1YUFCZ1p3YXFpYkc2YW9UMVNRbTRTVTRMalowM2d2cUps?=
 =?utf-8?B?VHo1b2tBczRMM1pyYXRtUENYc3gzMXRRRjJXbmhZemdYYWJaTXBDNDFLZDli?=
 =?utf-8?B?K0x6cXRId3BIWUoxTFhHajdhTEwzTFMvdlVBZElVQzFYWk40VkE2VkNjMUti?=
 =?utf-8?B?OU54emNNNnhGcUpPTEtqQWw0dGxOSEUrWjlJY0IvRlY4Z0xXWXFBSU9ieW90?=
 =?utf-8?B?cjJTdExTM0JyWU5hTkd3czdYZUdvd0ZRSllKOG5URUZ2QUxxdlZtYkRFR25G?=
 =?utf-8?B?TUc2eWRjNDI2V1RYeWxNQlhaODYzZFNJNzVqWG5aRXY0T29jVnZSTmErTVlR?=
 =?utf-8?B?aFNTdTk4aEI2UHc3dW9IaDU3bWh5WDg5b1BiSUkyZ01ienNmdkxNQWxhUU9i?=
 =?utf-8?B?amE3elN3eHErRVJRNGp3NHd0aWRJRDFuaTJGMGdQQ1BXTkNleFkvNnB2RlZi?=
 =?utf-8?B?MUVYRE5UL2RQZXRkeGl2WVNQb0pwc0RoMEl2TE51aDUrS1FzRXlUNzB3amRD?=
 =?utf-8?B?Y0hLdjBlczZzK0ZxcGZCRTZqU05tK1FpWlJuMzR1dndRNFV4eXRldTFrSVg1?=
 =?utf-8?B?M2FhV2NlTS83emt4bXlzNFgxT21OY1NBVWRQZGhjY0daTDVNdkIvajdhZzRu?=
 =?utf-8?B?RXZVYmF1RkJLbFA4VE50N0d1MVRPTk5ONFg4eCt0bVpJTmx5MFE5RjY4c05a?=
 =?utf-8?B?aXJ0THdWL1RiSUlxc25GQ25FZDZtWkNZcm9qSmRsUitVdGU1U0ZFd0pCOFlG?=
 =?utf-8?B?a1VmRFAvN091OWdYWU81TG1TNGo4ZXduUEtua3dDcWl6T3RnYUlxMDdhTVl1?=
 =?utf-8?B?eUZoWWxENjcyMnFadUpkVlQrZTRFNUtla3ZFbUoyWU5CS05Tb3ludjNYZG14?=
 =?utf-8?B?d1pTeWZZYU00MldZTFdpbDhyeTJ4TExjQnpEL0Y5aTFXNUczdVdtTjQzT2Fn?=
 =?utf-8?B?YWtuS2hNWFBhSmpRdnlNNmxIMzNCVzhpQjZpY1NkSHV2VWVvYzhHSVk3TXo2?=
 =?utf-8?B?YTA3K0UzNmpUU01XS2JIMmhnUm9yMlk3WThGSnRjVDMraFpjM3BId21FOFM4?=
 =?utf-8?B?Zkxyek9ic01TOUdEcnRhRkdtdEsvck1EczZPOFZ4ZnlQMDN0WEt3TGx0VW9p?=
 =?utf-8?B?akdjQmRiRWxvcmlsSnlRa2xRanJuVmtOWGYrR0YxQnhsUjFTVm9NRU8xbGVG?=
 =?utf-8?B?ZGxCanpFWnhtZXpZSVNoUjJJcThON3JXakxaOHBPQ0tRaWI0TnZzYVBtb0dn?=
 =?utf-8?B?cXlidVlyWHg5WWtubXFVV2tqdSs5Z1BSUkZaZEVuS1N6Vi83cG8vcVF3QzF1?=
 =?utf-8?B?WkdlcmY4Qk5tMGhOeEJNZnpYajV4UFNDcERCSmNnK21lZHpWSEh1dktRdFJr?=
 =?utf-8?B?UGh2TnZuQUFSSzVpVkJUUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmxwNUlNS0Nvd3pkK3hidzlPcnVwRlN3dEJOL2x2dmh4NUFINXRieXNNR1ZK?=
 =?utf-8?B?WDlpUUNuSG10bW54aHVCQk9KUWxMZ0dmNnZ5OHpjN0xMT0hXSjhlUDN4N1Jl?=
 =?utf-8?B?SnZibGJvOHhFenNNa2loYXZWRjBURWxsc2RtRnJIdmpoVjVHNXllbXUxRHV4?=
 =?utf-8?B?WjF4dWI0WlJvNHJ2dEJBbFVKNUVqTkZNRHMwY1pVY1lSOEk5TC90T3JCUG90?=
 =?utf-8?B?Ty8xbitpbFdzdURLdGJZM2xKYzNEb2dwM1VPUHNPSzlxc1Vnd3hicjMzK1Jq?=
 =?utf-8?B?b2lZd3FJSmpDV05vUG55MHNYTHdLZlc5THViT25QNTQ1Q0pzUmZjaDhSOXNw?=
 =?utf-8?B?bkVyaE1HbDBEbmxIaTF1OHhsOCttTGpOSFFISXJnTHR3MFA1WlVGbjl6WVE5?=
 =?utf-8?B?NmdBZUcxMTJMeHhrNDJmUGZhajlZQkM2MU1LdmE4bkpnZ0FtcGVxRXhuY3hs?=
 =?utf-8?B?NE1BSFJUcXh2UkdsclRZNDkzR004amNZUm9VV1YvWHNkKzJHdUJIVGNPQ1FC?=
 =?utf-8?B?VVk3M1BWVzdXNG5uRVVuYWJqc1JvTnp4TXNpVzFlbWtJdDlxR0Y1ZHpnY2M0?=
 =?utf-8?B?NzdrcVRodVAzSTQvcE9TNm8zMU10OW9mdWpRdkVUT2UyVkRxejJLdCtyMytW?=
 =?utf-8?B?Ly9kdWs3aEVWclNaaUN2VzF2RGlERGtnOUtCYW5qR1BHTkltZHU3UWZyOWJV?=
 =?utf-8?B?NTVGMzNGMThaQlVQWWh1RkY3cC9qMTZSVlpBUEdoQlZodmNFZ0hGeXUrQW5V?=
 =?utf-8?B?R1RUUzJQdU1SOXA5VXVmbWpzWEFrZExDSmhxOHVWTjFGNkNpT0F3MFJNSzVO?=
 =?utf-8?B?TUhycG4yd3BtVjFqMjM5UUxrY0hZaGxQblNUZWZEQlFZYVRmUE5vWjgxQ2FZ?=
 =?utf-8?B?OFo0c3d6ZGF3UnJVL1hOeTI0cStRc09KcEIzVDg3Zlo4UFJTODM5UXdZY3JY?=
 =?utf-8?B?WTUweVBLaG9qNWYzYTZiQXBiZTBjOEUydk9GOVh3OG1tOFJ2Vm5aMzVhU1hv?=
 =?utf-8?B?aTc3YS8xMnFKVFdDSU8vZ2U1SmpyT1plbnJjazlwNVFNc1E4QmxTR0dJanR2?=
 =?utf-8?B?OXdOdlRjUFdFS21WU1h5Rzk5VDdEL2RPUDBoZHYySWZLV1dZR2JDZ1VqbjFF?=
 =?utf-8?B?bFpXamltT0RRU1A0TzFNUFRHMlB3TzhsekZmSExIZ1J5RTQ2UTZCeDJyemIx?=
 =?utf-8?B?VkVPTFVBekVheDE5S0lrY2JYOUJPeTJFUGJnTjJZWC93Y0YwVGpQbmVTa1c2?=
 =?utf-8?B?YWE0VHBBSXlUSUJBbDNZd2hxZ0MySEQ1ZTEzbitjbHdNZ3lkQXdmanZia0Jm?=
 =?utf-8?B?UkNEM2ZKQ1hCUjZTZmkzVGNJbVJTZ1ZhWlIvYjJWREdHREtTaDhQRXJmT2Np?=
 =?utf-8?B?UDhMMHZDdkFZb00vdjhyTVJYdXRDdDVTRGcxTHdqc1Q4SFdDRlp5dHluazRp?=
 =?utf-8?B?bUhqU25POWw0KzBySEtWVitxZ25sM2NlekEzMi9tdUs2NVQvaDV2RlpBWk52?=
 =?utf-8?B?Wm12U1o4cGdWbmRtMGJRcnhHVEV5eG1HV2lIL0NwVlZvdDZidG5jQzhoQ3RH?=
 =?utf-8?B?OGI5VVVUUnF1WEkxQi9WazNMZXRMQVRwbjZKZHBGWDQwcTIvZUhKOUIybGhn?=
 =?utf-8?B?dk9kcnpMejVrd2ZwYzVuejhRZ2VNd3F0UmFXeG8rK1lQZE5oVGErejhDc0p3?=
 =?utf-8?B?VFdqUGtzOW1mQjdxTlJHWC9XdTRNdW1MYUlkajhnK0U0Vnp5NVVDSWhOeUZ0?=
 =?utf-8?B?UEw4Q1lkQ2lVTlh3bERLeWRRN29Pc1FUc2VTK3BEY0JZL0tmMmlnczhiekd1?=
 =?utf-8?B?cWVDd2VwbmN1cnhBUFhPL0tzdE1rNGxMeHRWYW1Tc3hJbkNhOWVGa1pjMWt6?=
 =?utf-8?B?TmlDREc1UU1Rc1psWk1MNUZYWHhEeng4M09Ra21zZnV5NGxxQ0NzY3NuTGVi?=
 =?utf-8?B?elpqN2JaZHE1blRKQi9ObG9UYjN4a1dIS1JTT0VwK3VaaG9Rd04xMWMxS1lM?=
 =?utf-8?B?L0xpdGtSYkpiTURjK2JsR0FaMVNPclBWY1RTd0V0NSsrOTJoR21Rajd4RERp?=
 =?utf-8?B?ZXBjKzVnSW5Sd3drWVNzeGg4RVRwWStic2l2TCtiemhXTWdFald5OTRraGU4?=
 =?utf-8?Q?A3M3iSie7UkkItmKqU7k6Zf2I?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c97ac2ec-b3dc-40b5-4285-08dca59c5071
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 13:36:36.4158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15sc33H++H4LGE1hBl+73yODC9cI9ZZvetcTubciYH1lrkQ8e/WHBV6Qlzj2h0Odrzd5GN4dTUFffqZzQ+As0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10055

On 7/15/2024 6:16 PM, Daniel Baluta (OSS) wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
>
> According to Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> fsl,dsp-ctrl is a phandle to syscon block so we need to use correct
> function to retrieve it.
>
> Currently there is no SOF DSP DTS merged into mainline so there is no
> need to support the old way of retrieving the dsp control node.
>
> Fixes: 9ba23717b292 ("ASoC: SOF: imx8m: Implement DSP start")
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>


Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>


Thanks,
Iulia
> ---
>   sound/soc/sof/imx/imx8m.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/sof/imx/imx8m.c b/sound/soc/sof/imx/imx8m.c
> index 1c7019c3cbd38..cdd1e79ef9f6a 100644
> --- a/sound/soc/sof/imx/imx8m.c
> +++ b/sound/soc/sof/imx/imx8m.c
> @@ -234,7 +234,7 @@ static int imx8m_probe(struct snd_sof_dev *sdev)
>   	/* set default mailbox offset for FW ready message */
>   	sdev->dsp_box.offset = MBOX_OFFSET;
>   
> -	priv->regmap = syscon_regmap_lookup_by_compatible("fsl,dsp-ctrl");
> +	priv->regmap = syscon_regmap_lookup_by_phandle(np, "fsl,dsp-ctrl");
>   	if (IS_ERR(priv->regmap)) {
>   		dev_err(sdev->dev, "cannot find dsp-ctrl registers");
>   		ret = PTR_ERR(priv->regmap);

