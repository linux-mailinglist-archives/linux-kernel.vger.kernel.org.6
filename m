Return-Path: <linux-kernel+bounces-280895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 878E794D08C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376D52858B2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A01194A42;
	Fri,  9 Aug 2024 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fTx0oLvm"
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011032.outbound.protection.outlook.com [52.103.43.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128331922C7
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723208012; cv=fail; b=IRg0tlPPeykTOHrfLhs5H8iMtNcEDipc/x6AstXdwQ4KUKt38RhPNt3IGc8TMMcHzfRHa55PgUbk5G3a4TnWBD52c4XMZzZBvaAS4a6Z7n2VFjyQy5BNqT3OfNRLsKfuaeS32W8S8I2BP8ej16cpF6eIS0FSGpoEAiflYuUkN3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723208012; c=relaxed/simple;
	bh=aktNYc8Fto4GagTq9TBKVYZAO0boa37wmZQKZFgjkFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YG6dr78rOnBnSAEsRcE/YdR07jWsEV5eNF8hC1ygNxH94pz8yLjcezlI8fs+X9cecgBcwiCAP9y5VJ5euXHZw25i/5Qbc415wwE4nrJWTjBkQe0FAsaTq/MbAWR4sfFgW0K/7dWcsg/jYBNQFH9wusCd+CvbPPKEOsqOl/bTay8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fTx0oLvm; arc=fail smtp.client-ip=52.103.43.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqsKaZ/GBiVKhMbUoN1qtq8v+LYRD36UE0g4ebMEj8I+WYJc1rMUny5qHGZdBffjaTkROYvgnhPL9oKmZO2jpxgMamhAmrw5GAhgx/1ZNNVw8J78xe+OYW3+A/e6UCK0euZP3I2vEj6kr7q8tm81ksSI+4UnoHgPi3ObisdS7+T/pdAuYiuUFxhHVOiadVY+CweOb7jw7UsX+1bwzMH+r38CARVr/8ET241zZLUrFIOD1Wu7W4m37kvXaiGTpgQ2hMNXw6ck+AHP7jv1a6hjfpc5/xBW6Gnizj1+NqWNxx18tuQCV0bSpGSVG85tUCrrheI5Tb6afTmh0U8RABWvPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKDoGwPSYAo8XHJdtqpVdfJMUkbEV1zAJZYFBauWQ2E=;
 b=flyV4bN8AEe1ctoxuBflk8HnlZ7d7PXl7Z9NkCWO8Ff7o3au/LGiYCK8zvY3lUOmT6b+amaRvgy8Y/NFtNc2LZa+wWas3Xh0I3lM/AqPEH/AfOV1HYweEVuFMPNdK8HHi6NtMIr9U0Y2UOW2h/npqb57ht1mHZpoHy0aaDwN9Nqrvc5pY7DBw2YTE3PWx4qi+HTZ28JMaIRqVM8CiWRJzeGF8kjytbdH0xAlgrgO5StA46H89vt+Hqd7aXQGeM/3lo9T+QqFgbndME03Uq9wvm3UBIgmxa07Fi/j10gi00UZXGXTIKsp5OxXv/xVrRxxj/0IgUMBHdGe1ZiY/d9tRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKDoGwPSYAo8XHJdtqpVdfJMUkbEV1zAJZYFBauWQ2E=;
 b=fTx0oLvmTygFhurGvTcKVeTh8tgSctcTjxUGApkuGsKTGpKLpppdBpAYkb2zUswyYZ35UIrPIWGdza93DkPGgpQl/vfh4AsodqIpH9FwCa+HuxF6fzfheRa1pUkdHDET1C0FoGBvDDmXhg8abkOZrJ3hsFxtbP4PSJxL4uw0EnPT5hq9v5d4HC270+OV/nDZJAzvHW4y7wG6qHqEYniSJkMtkpYPw2MTRme2bM+9S3SOcT3f0KLP92kTXCpiCN10OGZJSicxDXDaQRW/J3/HaitOhK5ztuWZnJb4Pp3f8vJRpkh0Y7KsMFyAa6NGVHG2t7GyuqXsoWNQvbDbVYrJVw==
Received: from TY2PR01MB3322.jpnprd01.prod.outlook.com (2603:1096:404:d8::12)
 by OSZPR01MB6848.jpnprd01.prod.outlook.com (2603:1096:604:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Fri, 9 Aug
 2024 12:53:27 +0000
Received: from TY2PR01MB3322.jpnprd01.prod.outlook.com
 ([fe80::2580:b866:1150:d0d]) by TY2PR01MB3322.jpnprd01.prod.outlook.com
 ([fe80::2580:b866:1150:d0d%5]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 12:53:27 +0000
Date: Fri, 9 Aug 2024 20:53:24 +0800
From: Zhang Ning <zhangn1985@outlook.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org,
	linux-kernel@vger.kernel.org, lee@kernel.org
Subject: Re: mfd: intel_soc_pmic_bxtwc: irq 0 issue, tmu and typec components
 fail to probe.
Message-ID:
 <TY2PR01MB33222D8BE4B1107EB3A1917FCDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
References: <TY2PR01MB3322FEDCDC048B7D3794F922CDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
 <ZrYMne34hVa33qKf@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZrYMne34hVa33qKf@smile.fi.intel.com>
X-TMN: [lyrZNRglQoWQMw3VYErBbaXS3CwCErj+MoNVwBRey7LlMcieYG0u0QfZnVPDSmGp]
X-ClientProxiedBy: TYCPR01CA0026.jpnprd01.prod.outlook.com
 (2603:1096:405:1::14) To TY2PR01MB3322.jpnprd01.prod.outlook.com
 (2603:1096:404:d8::12)
X-Microsoft-Original-Message-ID: <ZrYRRBknvEx5QttU@orangepipc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR01MB3322:EE_|OSZPR01MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cdad609-2cd3-4f0f-e952-08dcb87242ef
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|5072599009|8060799006|15080799003|461199028|1602099012|3412199025|440099028|4302099013;
X-Microsoft-Antispam-Message-Info:
	9/2XRte/GOyq0zawSU8QRi++gcHQyzutneTUu079oTBm3haQC1x+P7j5P2hHDHyNH/R6IuYwy58dowC+kFVSavZ3Udczj9yAtt4n4ypnc5zc49++Z/UuViI65x2LgtZ1aJctyGpZIXkXp6NceSV+jcF1QD8hFNY6xVozYRBhQHce8wzZ6Ts2tClzT7uDjA6rnFSNUVFpAILCuqc7zj/AGIXKNSkwzTRHESHoW068gWdlf0333b3eoDe1K4K/rkgW5XyGKql6eFygf9RIyVlHMZJfYw0LDtqfvExU3ADct0oyBnqJye4pCVqWcG3uvbQ9/TBzVTDBW7TdPVD3hAJ+CnqG5pBOPFqUq3DLzQJlal24R94xlSBdNMijFWZeMDCFz0VxZfdHsu+N2L9smnN0VFB5cUiP+Sj57RgKPIJhOVr417rsCEsPoXEgzcOiObzEbstKHUV86unZrz+LgFBIDRIlWjNnf4bryUN6tuYe0eKJTBt5rNWMyvudRcvusIbeV1IcbEMibF9Ykla28waloWP26PRmORuc3+bITZAj2wCjHLhkX3t5w8ff4uoTqKdfGJq1R4jRMetcH4YAU7tSdIFxM5QZEGD9MKGxHK/5PGGNs0jeJmnovTV2oVwYzJeWkPU57XezvM7RTbHNgqgGN59mPKx/sGDk4ejTrmBcU66LeyO/6PbmXWJltfM+GlLq/JHaotroG/gEwAcuhrICiw5/Cpqir/qGU0sCWbY3aImJBeR7cWXmROx2tsZrqhakfoLDzg4JJld6l0ZV/e9cDD+uKfc9TtgX0518Vs7B23zXl1wU7pZgBUVY+MQUslxrAAee4dl47w5XEUmSALut72lxDXw3BL+7AwhKbKtp965ic5gbH2zoSLvJ6x+RIGW3
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzNLVHNsYmxGaG90Zm8vbDBoY3JqS2k2bXpEdys5TWNxZ2dqbHBERVozcjh1?=
 =?utf-8?B?M3BUbFE5cldMTGJyWlY4bFJPck9JbXdXWFN0WWJQd3d3SGJXc0NiVmwyTS9Z?=
 =?utf-8?B?RVlYdUFQeWtYVTZERUVwd2p1VGdoYUVhYmEzSjdwOTIydUY5Sk05YnpzTWVE?=
 =?utf-8?B?SkFtTzMyRWJVdnVjQlAySTJROU8vL1BuT04wY0FhcG5OS0N3U1ZUZjFQMmlU?=
 =?utf-8?B?NXNhd05sNjZzUmtZTGFuOC80U2lZQXd6cU92aDdtR1dTN2Q2bWxRVTlFSXIx?=
 =?utf-8?B?T082YXE2YVRqZ3NkalRDU1RpM2VsR3dIMVh6R0VCbDA2bGhtK1JtOUNZeUwr?=
 =?utf-8?B?YUtEWFl2UzBpSEFvVXY4aHErMm02SGVSU25iVEFXVWdpQ0dENFJiVlZrZmZl?=
 =?utf-8?B?bXBHMDBYTjlqL2dwblRKOXlucHB6V2JOVVhPMHZ3bjJOSEdxZUhlWHdldzli?=
 =?utf-8?B?bWRqQ0NtL1k0TjMxaFFLdDFyZkZuUy8ybnZ1bXNGdGwxWTlnN1JRNFFZV3ps?=
 =?utf-8?B?d3NWL25aVHhLYTMrVHozdW01NmtFYVNPR2VjTjgwZmpHNDlCT2NRUjdUd2wy?=
 =?utf-8?B?a2ZIUkpMR2d2K1J6MkNIWkhkdkw3Y0lwNzdvMDBWVURRODN5UWMvYnd5NitP?=
 =?utf-8?B?bG11REhkdytTQ09ETks4YWEzWW5McEFkWVlYN3FiS0pvYmdCNnlRR3Y5Z1oy?=
 =?utf-8?B?a3libGM2TlQxZFNjNWx5OU5lN2R2bHU4VVhvdGZ6WHRQNWRXZFJsa0RqZkhp?=
 =?utf-8?B?N0lpTkIzWFZBcGppdEZYM1BLY2NxSWREREFmQnZZSVl6WHpYbUpHdlhpVnRz?=
 =?utf-8?B?R3ZYaTkvT09ZZll3angvZ0pEME1YQnRURy9PMDBYL2tjR3pxclp5bzR5MytE?=
 =?utf-8?B?K0l0U2FkSlhDZ0kxMUFqdjd6T2pQeTBjN29tSDlzK2hqSS8vOHZwSkI0WGU2?=
 =?utf-8?B?bnYvblNseUxkNnBkSTNSbFF3ME5iMG1XbkFjbXllZWdZamZHNE4yQnB6bU9F?=
 =?utf-8?B?SWw5L213Um9kVkY3SFhtdmZvZHc2cURGdzErWEw3QXZnamhZcFRUL3l6TUdP?=
 =?utf-8?B?OWhKOUcvbWRHbGRPTUR4dzFFRTNNWGViOHZkTWhjRXRWMFdqbFZqdlFLV25l?=
 =?utf-8?B?ekVhbXRLN0hIYnQ2STFyODFENG9rVndhbHN4ZTloZUV2MjRmTWp6Y091THlt?=
 =?utf-8?B?eW9iQVVTNVNKN0t4c05kSkJUbDlrU2Zuam9lUU1yYVBOL21YdjRQT3JReUU3?=
 =?utf-8?B?OTlCVTV1UVFuQ3hrdVpRaGFMSnBaQWNxMnZsVVlZVVA5cEtvSEJmeU9WekZJ?=
 =?utf-8?B?L0pCbjAySVIyTFBPbkt6ZFltSWR6RXhVcjBpdVJTUFNSc0h3Q2VoNVBGN2sz?=
 =?utf-8?B?MmRJUXdCc2toUkxlbHRQdkRuQWRscVFPcWpDLzJGRk1HS0Q0ampNbUtnR2dW?=
 =?utf-8?B?Uk1ObDlLeDZsQmVWYkVGcC9VelVGSHp2YnhQdjBXeklybi9ENWFWNG1scVBO?=
 =?utf-8?B?NGdVYkY2TldiRVpqZDBVU2pwSDRSQlc2ZFNPRE5QZENCdUc2aERkVWJpM3FF?=
 =?utf-8?B?MFZmdDNKMjhYTWNRb01xRGU2VGNzcmVpR29QYW1FUVhmRlNCK2RXcFIrUTVs?=
 =?utf-8?B?SzJCMW9OdW1JaFFwYkp0NTdNMzd0L0h6WmJlY0hUZi9JUTNJblRoanE1bnps?=
 =?utf-8?B?dmhoSjFqK0M4ekZmWWxCa0k0eUFidGJDc0ZIcll0QmpWK0ViaVVEM3RETkE5?=
 =?utf-8?Q?W6bXi9Yw+VSanFqWBo=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cdad609-2cd3-4f0f-e952-08dcb87242ef
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3322.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 12:53:27.0466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6848

On Fri, Aug 09, 2024 at 03:33:33PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 09, 2024 at 08:02:43PM +0800, Zhang Ning wrote:
> > Hi, Greg & Rafael
> > 
> > recently, when I try to enable mfd components for intel_soc_pmic_bxtwc
> > for debian kernel[0]. I find tmu and typec failed to probe.
> > 
> > after check source code, I find irq for these two devices are 0, when
> > use platform_get_irq, it will alway fail.
> > 
> > 	if (WARN(!ret, "0 is an invalid IRQ number\n"))
> > 		return -EINVAL;
> > 	return ret;
> > 
> > My workaround for debian is to hardcode irq to 0, instead to use api.
> > 
> > I don't know how to write a good solution, thus send an email to you.
> 
> Hold on, how the heck you got 0 in the first place?A

use tmu as an example

enum bxtwc_irqs_tmu {
        BXTWC_TMU_IRQ = 0,
};

static const struct regmap_irq bxtwc_regmap_irqs_tmu[] = {
        REGMAP_IRQ_REG(BXTWC_TMU_IRQ, 0, GENMASK(2, 1)),
};

static const struct resource tmu_resources[] = {
        DEFINE_RES_IRQ_NAMED(BXTWC_TMU_IRQ, "TMU"),
};

        {
                .name = "bxt_wcove_tmu",
                .num_resources = ARRAY_SIZE(tmu_resources),
                .resources = tmu_resources,
        },

this is why I got 0, and I don't do any hack.

> 
> > [0]: https://salsa.debian.org/kernel-team/linux/-/merge_requests/1156/diffs
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

