Return-Path: <linux-kernel+bounces-568934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CB9A69C3B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE66189DA78
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17B8220683;
	Wed, 19 Mar 2025 22:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b="afQlAyN6"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2132.outbound.protection.outlook.com [40.107.95.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B60B213232;
	Wed, 19 Mar 2025 22:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742424269; cv=fail; b=XzcyCEF4OyKxArXxaTL659M+VknxCHcrTFBqTqZZLLSCh4FbeVP1eu+xV5IqVeimTtYczO89vTWwmLDwRhM8FLLL6uONrDlfivGec9/zuD/0FsmtdQ6aSAOkJlM+cCdYG+f01O23V1C+mgew6t9jMq+JFeHZTQPrmdupOyzcaXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742424269; c=relaxed/simple;
	bh=MYL5D5Vt1BoCy5xDQy9Z5w2HRLJP/hB8atXbLi/vqiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oYYF4Gyp+Z04M/VEYXyucJCdiosLtrBJvuLahUV4O3XH6FXPzMIK9C8fbi1cBObbvKr0xfZpeHHgGjqqYFpu1jN8NfwO1+RENayQsnPB3aRTGJSsQG7Zjsb33Hx0rxvfrkLckmuNoClpf8E3rnoSoBDQPgxCOjnBF3Qa2UkY7s4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com; spf=pass smtp.mailfrom=in-advantage.com; dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b=afQlAyN6; arc=fail smtp.client-ip=40.107.95.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUunfEm9X9cOK4lDOUlicuQQPw+VJtgN85+rTlzCEBVzWRTd7iH9M49vwFbiJxLodietNe6PVYn0NFTFvk/U/wesPoJIDjWthYUCgkSe3NLhxNh2dlRVqC0YF2xXqAhS1LRA61M19xu9P4lcHQjaFZhfAf2LPqpUnb4fZzJ7sZ0ygV1tzs6thaxv/39CEboeUK6/PVZa8RmcQj+ouwOHOALWUqYChYkcQkJrZv0uhaahVNfSsJBhbVnC4R9H13vn4GQk+ZIP50EJSTKGLIir15YFPCXyna8G3Qns7Wwyzf9f2z90nHpbjL7e9UfiLO6X6ZwgpDSxlBKPkYuyw00+Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFIH6n5qxN8UtULLM9x215ccLciS6M3W4GCTDyx8q7Y=;
 b=aU8Is8PiYt/uhjdkq7W7YKa26G4gvZLl3VxBvXQE81YJo6sDgCs6tKyBqi24n0EE7v8uMb9DTN6LFAfGvN86bzJWydXTmPGUPZGShMKPzyFnQKU/zLWKdWns9S0YX7oeEZCmZSTQ6KQPoW4fFegzHsw0EZ+Ghfi0HgPhXJEI/8IivCM1LSLMSi1Y+GknEoAh1WFKTS/Iv+FBAsWY8YkFsK7Xjn2yvX3FKPlY1awZWYMaEWuKDJX80zMWZqQhzzIRaCtb+f8XTJyuo3VYKc5USaSVV9WewK9g0utuRewqdjErkC8T+FAYLqCUa/+DBo6RKEk8dZPaFzEZ9zw7E1fuXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFIH6n5qxN8UtULLM9x215ccLciS6M3W4GCTDyx8q7Y=;
 b=afQlAyN6zuW5qsCCqQHqVCk8Dt01B8EtFcXURfZz2MyMgUXGG3fwnae7ellnkG28mnqCTVLPFOa4+0f/ffBWnQCPeev1ujDdmckTOV7jhniz8lwvRNzLGGI6ZmhiYNjxniiFd+WrLskm3WBbxCzISgbpy7TjuBh4nM39vXdWAco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12)
 by DM4PR10MB6136.namprd10.prod.outlook.com (2603:10b6:8:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 22:44:23 +0000
Received: from DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea]) by DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea%6]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 22:44:22 +0000
Date: Wed, 19 Mar 2025 17:44:19 -0500
From: Colin Foster <colin.foster@in-advantage.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Felix Blix Everberg <felix.blix@prevas.dk>
Subject: Re: [PATCH 4/8] mfd: ocelot: lift chip reset logic to ocelot-core.c
Message-ID: <Z9tIw9pAV4teP_R-@colin-ia-desktop>
References: <20250319123058.452202-1-ravi@prevas.dk>
 <20250319123058.452202-5-ravi@prevas.dk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319123058.452202-5-ravi@prevas.dk>
X-ClientProxiedBy: BL1PR13CA0162.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::17) To DS0PR10MB6974.namprd10.prod.outlook.com
 (2603:10b6:8:148::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6974:EE_|DM4PR10MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: a09851ec-85f0-4cbb-d0e1-08dd673797fc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?syvrwUiBdubt1fNl261WUol0zafr+IVZ6deUqdSRa1yH0WNSYrNSRRzS0qZZ?=
 =?us-ascii?Q?Luh0iJ06Dt2Dr+HrqCqDBkK9BV0uFbVAc2wCczhzmuCZzqEb2M+3oFd4N6N2?=
 =?us-ascii?Q?8yrSwcLhMkv0yghckbNMbGlcnGABXfya5hURxx62jT1IQHzhF1Nn7caWDHQD?=
 =?us-ascii?Q?Sc0xqU8WbXPEvY7LBsJ+jxOL2Fq2gfrHQEFRuPeTPcOesxO3BSwZK/9f43z7?=
 =?us-ascii?Q?U/4lqKvK1Ygd3N03iErq53YfJCDagipwCt3SZl7KdDvWBJ31dbINTL8l6wL6?=
 =?us-ascii?Q?ISRuH+tS3T1QJk2sbzcdT/YD9ZlLYFdjaZCMa5HKyNHRzIiIv4F7F84XM3vT?=
 =?us-ascii?Q?DOwzeKDPNXxpXubol9mLiEvDpnvU34Ayz0VgmtYVhAYt49kNv6LIlrbmCMfm?=
 =?us-ascii?Q?xYzgAbYwmim2NL+O5KwTXucfSteUwaam1ZUZL/gfOwAXE3hv/5og156+mov0?=
 =?us-ascii?Q?GTM/Bp1ytTEgKpLoYY7usNnR4+U/mmauYWnXmv0Qi3yzy2LCGXffI/Rudr+2?=
 =?us-ascii?Q?tItkSkkWykEfBbpfCMFBAjydS1SPUN9YsO+Dd2ymKiUU3SXk6Vk9BBcWEbk9?=
 =?us-ascii?Q?l89Mw/sREgYMLKhHJ4Gl1f0FWXY8FXJtCCWGYldFVOuYTPLgH1HWHXHnwpSZ?=
 =?us-ascii?Q?md2wmc7VzAoRmJM5HMy8nhM1BEWXXKE1U9GiGL1EC9o6T/IE8ejagv1au2DC?=
 =?us-ascii?Q?8y3RTVdmudv5PVzv3+WXm8vSL7+69otdK22AOieIrSsrRbn5amc+0equXAkA?=
 =?us-ascii?Q?gZiyfVLZc3h3mm8e1xipmwRlgiPEmitAimXLpgwAJ0aFf1jpknXpEFeRBbFL?=
 =?us-ascii?Q?SarqhB1XJJuVyCoKq1rmrbCzgkTX9KdTIfrTko5blGCDbgQ4YfYV4sh5M7jI?=
 =?us-ascii?Q?8PINkKeMLq8KBa6No/WSLIbpIZvI6fW1Y5V8VhgdyMyaMkLcu4uDfmNeFEXc?=
 =?us-ascii?Q?X6vvenpsHZc6ktBGKxeIVoyA57xEGKTT1Kpc0zt09wiUGL0xr8mSfL6eooxX?=
 =?us-ascii?Q?g03uarCO1KNAJcAgUuEcesxOkjQyEHNq2zo0AybMAzRclQKuwfBpON/a/QPH?=
 =?us-ascii?Q?MsA6d9FSG//ypn1o0pTwKTPXBUReJcthoNM3i0oXU5PO6yC0STMcbzAFCsdN?=
 =?us-ascii?Q?Zu9gDALumVdOKs8kCYDBNzQDJTG8Zeph2S2k69Bak78RES1Uaka7Uzs/UW7x?=
 =?us-ascii?Q?Z0Tnq5sYzxMEcHSJYEx7BeWK4iiy/tXlGjer82XCmeP/5iSLfv0alk5SfLc+?=
 =?us-ascii?Q?z8VfbSKzBeixZR1MqaY7MoGKiuNeP2R+qEuzpbLwK6Vt9o+zRjr/sHYgnizI?=
 =?us-ascii?Q?uhrfpUexomaJWMlaaEYfAexqvHnGHGwfvN+5JeRu8KCJFePeP9sunFBDUw10?=
 =?us-ascii?Q?JFvf8cRrDm0Ndrucm7B7f4KOGTsN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6974.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w1kJ+BP/aw2uTLof2/BzBeAKt0f479+MkqXhNyDN7sXQTdZl6PYhfzAGP4iW?=
 =?us-ascii?Q?PteBC1qoZ88DLx+WnFIq27lyiXxjOpIRJ0AyPH2drdxTohxVgqgKvJ+z6mFR?=
 =?us-ascii?Q?xX2C9sTHFFyGTBPSoePMBin1a7+gtfWcfDRz2/a2Hwh43cF2c6VObK1C+BXm?=
 =?us-ascii?Q?N7sPwex+9WsMWkPX7q/C+UPYHCyMxijhXYKU343/ja48uxgkU2QoykTiBUFw?=
 =?us-ascii?Q?Chv30PGfgprQ0Lrj4NxeGSDvixW2l8Ak5HIpfL3MfqKoFME9IBg6ihZK5N1S?=
 =?us-ascii?Q?imbv8dto4s2+hyCaTgUjLHtmAKBsaJjoQ1/GQ5/TZwJSPVvZH99z9piD6F3Z?=
 =?us-ascii?Q?Bp4ao/+59Jeid8G3nhv2kGWIDukkJaTDT33aNY9ooA4Tx0XGpBqPwN0QyMvp?=
 =?us-ascii?Q?dvsCGpGoXB8Kwj0QH0V8IkzwXSbar+FYDCk256EYPinC6J6s6zFDXQQsGi+J?=
 =?us-ascii?Q?3jQ5KNhe8zmzcOMSKvRWqAW6Qm/jDOAuT69wz+HKw0KcBf+yoV3FhgnhKI8Q?=
 =?us-ascii?Q?793R4iavhi++g5Ycno3d+KTTRHtRVL7nNIFRMV909s/bVR+zhNjAkgk3lE00?=
 =?us-ascii?Q?zqYj+15D9nvfbrQZY/iJOgGKaaSjwOddQUPUTjFGejPEn48dmy0tDxmwiAxw?=
 =?us-ascii?Q?H1SqusGs4EptQxqUJQVKYdGBNWtWz1wFuJyRIXo1hJ76CQl4a2q7NrS/0lvL?=
 =?us-ascii?Q?VV7IzmvvEsYR/HjhYXXPFmeozhSHGyYh43RGZ7+9i3vknwA1EuvnOqP9Efkp?=
 =?us-ascii?Q?FJHv2U05ClrYbeEKgEDCq0fokXwjxkxDYU5xpcwSdIW9sW1yNEg8/cWx8cSI?=
 =?us-ascii?Q?r2o0Ej0lsJ9WvHofHeLwoV7WSuN7gtPUBK6kewkGlOnXyHjERklI5dcbHCio?=
 =?us-ascii?Q?M8Z1C+xd5dDH3wAbr25C6LXyuXtjgHAiPcDePKoNVBXzN5zeR4E9BvDUqI/Y?=
 =?us-ascii?Q?khOWM//qbZdQ8JVbjSUSEPs3ZjgidgszsfoJ1OzmPIgcAAUG0MCtyXEdjurR?=
 =?us-ascii?Q?XB3KJVS0LfajeSpNtUrNl9EmUjW37qGhqvpRIIAUBsFUMvI2/gWbreRHDrj5?=
 =?us-ascii?Q?567gd6WpHop/sDiv6ZCt52hg48W+JjFglxo3nBgC3bM+E9nxr/7CZHet460A?=
 =?us-ascii?Q?yYk6iDKEohx8IGnBE1U5YKX9Sa0i14hAltcU1brU7gjJRM9PER7lN3ajmIc9?=
 =?us-ascii?Q?PHGaEo16Kaex8qC+Q3UQF57I1Y5OC6+zEEEiEJFMsbiK6EJxf6ptz50qnfwH?=
 =?us-ascii?Q?CB8fY/mVE7lG/1C69qqQaIS0MC45EguGRnynAmytMloKwNDZtOXX432Z0byl?=
 =?us-ascii?Q?UvOaCWgTVUvqE/df+MjWZ9e+r6gcsbJB6OlLCNXMTJyo06RfVPOzfwXCGzVO?=
 =?us-ascii?Q?vvTiL3dOYvZzBl2RH8TUo0p3B9vQJvEgxSqX1Zxjau9FavAvWYYuE8Cgf4hY?=
 =?us-ascii?Q?ENcXLkrPCq3VOqKYXF86HrQGX+aghaLIf32AcZR5E4z4uFyIIvM4xSYA4CLT?=
 =?us-ascii?Q?VEDZeg9uCvGPbeD3roFPL0kAGMmPgsfRLZQS9reWWyr4+qPYjeOTxaWH1V6M?=
 =?us-ascii?Q?gKRD5SKwGKYi/mFQ5pEds0dTPPsUxXPohWjYUhyZZG2SO+2WDIyN59P5Ij0L?=
 =?us-ascii?Q?1Q7GcN/Zyka1+N+FZs2nMm0=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a09851ec-85f0-4cbb-d0e1-08dd673797fc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6974.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 22:44:22.9008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XjX+vcJKSThWzaFZquQfOtNw0JBMgW6BfFRZ0+m825eXBEOTeJP5X6Rq5z8ORqZ3xrWyexsIG/CyBdTcd9k+jSdMm66X32Qb8j27F63SiQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6136

On Wed, Mar 19, 2025 at 01:30:54PM +0100, Rasmus Villemoes wrote:
> As further preparation for implementing support for mdio management,
> lift the initialization of the ->gcb_regmap, the initial (and
> optional) bus initialization callback, and the call of
> ocelot_chip_reset() to ocelot_core_init().
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Reviewed-by: Colin Foster <colin.foster@in-advantage.com>


