Return-Path: <linux-kernel+bounces-170634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C08F8BD9F8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 06:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28FD0B20C39
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 04:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7ED4C618;
	Tue,  7 May 2024 04:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c8wh6FBS"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2055.outbound.protection.outlook.com [40.107.105.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83394087F;
	Tue,  7 May 2024 04:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715054566; cv=fail; b=KCtt+SvyAPW4DM457nkzcCpfSwd7C6KDqdLkm4IAb9tZIAKQWzQv/RxPsO7hzk6e/Zj8LWZpt4qbTgWubWTloDThoNpDCuICS877PWKtL9+ej5Ko8b3v5FKzW/rOFbFRZsywvcDwDyo8lRRHGhk2p/DoJ2uvkNM6ZqPklW+ebR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715054566; c=relaxed/simple;
	bh=jgODUXoL/E9UbQDMy8ijqqZ45bm9iZ5f4wiADfuruKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BZsUsm8QZpS4RcEVB7P4CQRlj7/aYejPY9z/PaUZl457YF6fWTL2TCE0YFEO/Yy5ytWycSwZBqZxzsbZuaeCjKilkxOpp/6/GBmlPaZrpY+GqgK4Qrya4qzBoYYnqw2J0OT4xeBBXo7LwDSqkmf6oF79IqJrZ11S6C7e4suHrWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=c8wh6FBS; arc=fail smtp.client-ip=40.107.105.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDKvO2EyjdRixqycZMKSs8MJ4Oe+rcdz4CV5oBg4WK2KJ0f6h7X90VdA68bYxCluNFKUftd/jjHYJ01yaywUb8fF6Y5TYxYBgV4eW4fuJgjh13fG79VPSV5KK86rfBM+eDmUitWbg+1ayY/3zd4G+JqV88X79QSxlCEVfYSslr5r1JTZ2yyLMui6aG0Kj3ADZYnTNZstQtQ79jVYRDs6Q91H2gSWhlnuCrnW16C2gUDGa1jRrnoEaM0BiEqSeFKy4CkFCEmsGRNjLlF8pSql8ibaf9L1vZj+kVLrcKPy5wiE44DbpBk6exvatkNrkG9ItKd/tG2okjG95hBS5kblXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zulPMyHGfOWtlBdzkL7jpjHKUiM9m2HB1CY1mUCuWQY=;
 b=DUfooxL+olfwaFhNgsCbHg5F6THD0FrdEt4kOs7MVqtFR4vpf9fcR5zt0ZRCFCdTmzQ+Pe6TdZcwteIa7tXkPWQdR4zGcRAdWiDNvoqbj4seADmh/SEE6RqAZWhG4A/rHBB53mD05EO/e40Dp2yuyBhHBjAnCpnxIVWgb2EKM7m8Er9/QUnLzz+kWUJuUFrHKNsWbM9wd44s/teiwyS0CKfgTydjTU3nfqdWCBszYqZYsG8VaKIBnKoZ0dvUy7sOYKqsSKZ6qSQOu59zDKFvJF1dtigWLLOpSiYGrLrXoxnZhp7CTytmCIOOhbc0TRCrfHTXRf6Bi8uM3Cour1Y+vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zulPMyHGfOWtlBdzkL7jpjHKUiM9m2HB1CY1mUCuWQY=;
 b=c8wh6FBS8sdFBtaFNSjHyfg4gbyxl/EfJ7wT3PcTvmCnEPIdiF/H7h6Q2CsCDCGgT2Azi2RkH7N4OBSx639bdzBoppeeMpjYL47lkAvb44vPsX+sraCMgI0Y26Td0JeW8bvdI2uUU/1Qv5hGKp/wQXeSU89+3Z/OXQcqEyzGx8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB9855.eurprd04.prod.outlook.com (2603:10a6:20b:652::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 04:02:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 04:02:40 +0000
Date: Tue, 7 May 2024 00:02:30 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org,
	peng.fan@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: imx: imx8mp: Add delay after power up
Message-ID: <Zjmn1jRW2E2kpSlI@lizhi-Precision-Tower-5810>
References: <1714966502-27784-1-git-send-email-shengjiu.wang@nxp.com>
 <Zjkftwr4/6KV39sD@lizhi-Precision-Tower-5810>
 <CAA+D8AN9kFdgojkrR0ORUyrtOW=JOn0AfbXFTJ70RE7JxgA2pA@mail.gmail.com>
 <Zjmi4Qc3C3OYJU5n@lizhi-Precision-Tower-5810>
 <CAA+D8AMC41oUEWLuHb-f=U9pEzqWYon22McvT4MucYK=ajNuFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA+D8AMC41oUEWLuHb-f=U9pEzqWYon22McvT4MucYK=ajNuFQ@mail.gmail.com>
X-ClientProxiedBy: BYAPR01CA0014.prod.exchangelabs.com (2603:10b6:a02:80::27)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB9855:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a1c0f5-232e-46d6-c9a7-08dc6e4a89c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|1800799015|7416005|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnJCaEF5RGtlN1ppZEptSmZZQXpGS3JQaVptSG8vOHJJSUFSMHRaaDJHVzV0?=
 =?utf-8?B?VFJPUVMxV09MSVE2ZmppUW9kbjQvRnM5TjVreGVjdE1lb1hjNlVsQXNodmky?=
 =?utf-8?B?QzZkdUhFUFRsZFBvK2h4Z2FJemVyclRMdXN2NEMxTDZnY1FLNjN1L0xQS3pS?=
 =?utf-8?B?Q0RGbVZSMC9tMCtVR3hoVmxmN2NoWXJQdlk1RnhHU0c4YXFBSGJvaUJrN2lP?=
 =?utf-8?B?cVpURWVKV1NLd0htdWt1cXkxSGJ5VzJJeHRwM1RvYUhTQ2ZwbTNma2hmYU5o?=
 =?utf-8?B?VllyN3BsVllwZkZnTVErRktPNGNVL0QrSjN0bTdOQ3B5OHg5Z2xRNGlseG9a?=
 =?utf-8?B?c0EreWpPbWZYQ3V1U3Y1QVpkWHBzZUt0MWpnSVVVOGJ0dGgveWo5cEhSVkJt?=
 =?utf-8?B?RFhwMFluM0k2VGZQWHQrRmR1eGl2cE9EUE5uZGRScVBEMjhSSHowUWhrNVZS?=
 =?utf-8?B?cHhZMDdlZUtEUEp1Z1NDUVZCVGZTRUk4TmZtcEFVZjFkVk4xa2YwZ1l5Ynpp?=
 =?utf-8?B?WkhMbjAxR1lTMWJSK0oxcU9NY0NUVWFSVm5NZ2VnN0lQaFlZcmFjbVNFZG1r?=
 =?utf-8?B?MlpydFhHNW9PYUNKalBUOGQvYTk2NmRaMGdBWjduYWU1MjJrbUJ2ZjlwZHJz?=
 =?utf-8?B?ZHRuUGN0RU1zLzRFSFNVdi9VekFkNUE1OGdxbGdQWDRGMllDOVQ3SnZmenpF?=
 =?utf-8?B?ajhBOWltSmN2Z1JhWHhvd0VpbHFUUlNscUdTQ0tLcDVEekk4dit2U3B6TXRW?=
 =?utf-8?B?RVlpM1NuYkFpYlJUVFBGODJORFBwN1BEbVhqMm93WjR2UGFlRzZoaU9JTlRv?=
 =?utf-8?B?YXE3NVgzZ1ErYmtTelNQeHViaUp0YVBPdGJIZm1CU3B3TmNXM0xHVHBlY2Ny?=
 =?utf-8?B?TE50ekU5YllGNnI1QUIraHpyZ05DNTJKMTZ1aVZnMVFGWWsxbTYvVGVpclk4?=
 =?utf-8?B?WVN4SWlpNTJFVEYraHZMcGlCN1JzR0VHeHl4SEJDc3lJVW1UU3gzYXg5cHha?=
 =?utf-8?B?VHcya3A5eENpY1IyQlJSc2dkaHVYSlJBZ0U0SnA3a2tabFVXdHlrZTVwbXRs?=
 =?utf-8?B?VTRLMkw0K1NUWmticlZlUVQxa3lPYVhlWTltZ3hmTHJ0SHdBdkhFYlhMR3gx?=
 =?utf-8?B?UGpvdnZCdm5pNTJpZmdUYXB6eUJMazg3WlI3VmJ6aWxmbVQ2WTUvc3N6THlG?=
 =?utf-8?B?YzBFYUQ0M2kxTDRwVWt2UXFSQTc3b3lPMXFQLzA3Wmhzbk5yenFQeXdOQnVF?=
 =?utf-8?B?YU85WVRpYk1HZGs4TTE5UVVIWVF4K0g2VXB3d3FrVmlQU1RrTUl0UUFnTzkw?=
 =?utf-8?B?NGdDbXJkT3Y5OTZsZ2cxa2VFVlc2d0VzMkdOOHd4RlZ6V3BpaFltRklXWG03?=
 =?utf-8?B?VG9GTVlNNUR5U2hBVDcrUC9PZnVOT2p2Vm5xcjU0cG9ZV2l4dlBKRkloUHF3?=
 =?utf-8?B?R1JIZWJ2MHlyeTlnTGpSZjl6bFdyV2dWZy9ITi9UQTMyeW01Rmo2QmNEalBT?=
 =?utf-8?B?d1Rxbk40MTNLSEppMGJZKys0MWN2Sk9XZ0g1YjlnSEMvcDFqekIvNzFMc2h4?=
 =?utf-8?B?VzYzYnhSWHJyUVNMOHFaU2ZOOWtNZjQ2azZxUDBlSkhVSU1qbDdoZy9BbDhh?=
 =?utf-8?B?bERMVVYrT28yV3N6VFI0VzdyK3BSZDAzZWdwRWpLNWlEekYwKzFiRVA0Y2xM?=
 =?utf-8?B?VEZxSW5UeFhpc2l0L0lENjc4RkJEMkx1SUFTOUJjamd5bk1GQVhmVHVXQWt3?=
 =?utf-8?B?SzBMN3l5ODAwbzVSUy90VFovc3dpZDI2QTdjTjNTeWdvU2ZMdVJRRjFOSXpl?=
 =?utf-8?B?bDZWbzgvMElMMisza2x3Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXBlTmh1OFd5MVJVbG1IRDBSdWNoa1MvZ00xY01HYmIycmlNeGlDTnNFdjZl?=
 =?utf-8?B?c1JvcURRRXErNXRiQXlMY0ZvY1JFMjNkOFNFclluQU52OGtBMlVlYkw3RHRS?=
 =?utf-8?B?TDFiL1Fvd09telpXOGdHSjVZS0g4NmxnZ1JnTHA3UEYrR05Dei9DSXM5NU1J?=
 =?utf-8?B?cWNCdEJvZkdFb3duNk1nMkFTVUdrR08vMXpaVEFwOHFOK2d1UDhoNXdDc2hM?=
 =?utf-8?B?MlljM05xTTNsc1BpUVBKRnBxY1JOUmlyK0pkbVBWZGpqMXBxOEpqYndWVmRD?=
 =?utf-8?B?bGpreUh3aktieXp1K29IZDAwZzkxN0VRUUlHWDkyTWNFaFhxaHl1UEpXc2NN?=
 =?utf-8?B?Vnc5cEQ0ajBjaGprQlFlUnk1VG5hU1dVOHMvMk53clFKOXpoZVYrTU9oNWhE?=
 =?utf-8?B?a0V1M1EyQ0tabTlucXFZZThQcXZsMENpOGJ1bitTSlZ0ZHFLUURWTHh6cjZ4?=
 =?utf-8?B?QzF0NWw1RFB0QXFIanc0Y09ld1MwYURrVWE3aGd0anR1azdaVlA0cUd6Y0Vo?=
 =?utf-8?B?bmFzd2RmeW1mZ0xNNy9STFY4d0szbFFCanB1SDNSbHFqMUtBeW50YVhaclBF?=
 =?utf-8?B?VXVnRkJBbTRabEd4VEJML2JPTHY4eDR6TnROUnZxbkRIOWJXai9nT0c0akwx?=
 =?utf-8?B?TXU3U2I4enlKK2ZnQjFTQzFmNFNoNlFBK0syeUIxL3lqYnlGanQxdUlKaUZU?=
 =?utf-8?B?aGdPQ3dPUStxOTR4UWdIR25RUzh1NGxiOEJlMG5TQm9ZS0xRZmEybTVuRk52?=
 =?utf-8?B?Qk84VVNKWHRxSFp4dlpjaTl6MEdNMlFhUHB6cVZ4cG9uZCszYWhQMEQwaEtJ?=
 =?utf-8?B?YnAwOFNWb3d4NXh4K1h4Tlc0Q1lSZlZnT24weGJpTHNncEdaRzFrTXZub3pz?=
 =?utf-8?B?UkpaTW4vQlo1SE02cmJ1YS9VZ1lFVFBrUTVkZEwyUmdWRzgxME00STQ3U1Zs?=
 =?utf-8?B?QXp6aDNBZE1xL1FXYTRJb2M1QU43MjJ4bWpMQ2kwbGc1U1FYRXV0ZWM0dWdq?=
 =?utf-8?B?Ym9CaFFyR3c4VGdlTWd1aDFqWDNqbVZTeVJLRzR4T1VhSjlKSGhLOWF1MXVX?=
 =?utf-8?B?VnJUQzk5TjN6U2Fpd2VHWlZWeGZLMk1NSU1NNkIxblBBaldxNjUxQU9TQzhE?=
 =?utf-8?B?dyt4VVNQbGRGRDlLRzZGWlB0MzZxQitkRFh3ZFRCQUp6VTU5bzFoZURYaUlP?=
 =?utf-8?B?U2tFWkIwVlNqWEMvSENIelZGVk1Ea0czbTRIK3p1VUR1TG81SGt3bGRVU2RY?=
 =?utf-8?B?aWY5RkViUVVveEt5ampkcG9paTR0cUVLT3hYcUtLVVM5ZHJsbks1T0JxaXp6?=
 =?utf-8?B?YU1qRzdSNFVocVhWTUhUckxpSUpUWS9ZaTZjRGZwMlJUT3ZNak9UaThsK2xl?=
 =?utf-8?B?MFE4RDFlL3dmRUFUR003QllqSE9vYnpDWXNsU0E2aUxzc1Q5YnNQdm9RYXor?=
 =?utf-8?B?OWxUMjJzMUdUdU9lRnJyS3F5VVVWbktiWklyREtLY1dUaW54bE1Sb3NHSXZ3?=
 =?utf-8?B?Zy9GVWgwdHBERmc3aWs3U0lCQVlsWGpBUVVWZmhVYTZoZlZTSU00dW9sNS9B?=
 =?utf-8?B?dzNxanNpSmZGQzcvRm52YjZMcTliOTQzcjhrNWRhT1pSakFUaVR0MkNKNzRL?=
 =?utf-8?B?c0RzSjh5NlBkVGxsRXphcVNrSXRFZXByRFNJLzV0dklqb0ZycStKN3hiVGYy?=
 =?utf-8?B?NTJ1RUhlNFhxbUF3TW0rRGwxRUQvejQ2OVhBM2JkLzJyUUV2NDU3MU5lMjZV?=
 =?utf-8?B?THpYTG5MbjZxZmMxd2RqTTFsU2FrQ0ZtTmFiK00yWndKQ1crL2lPNTRSeG5j?=
 =?utf-8?B?ZW5QZ2MxeTdyL1lpOXJDeHdKMEtzNGlWVm56SkY1VTNaRFRYYzVvRkhNVjcv?=
 =?utf-8?B?QlVFaW9veVlvcFVvUW9ZWUwyM1NIazBxTTBZdjltZXE0blA4Q2pMdk1JRXF1?=
 =?utf-8?B?MXI3dGZaNTdYTmtLNGxsZG5ZMThUY0dkR3VVdUZwdjk4RHhSWWl6bVljSktm?=
 =?utf-8?B?dnZ4by8rN3NMYnByRGtUcFlBYTJxSDVNZmE0eWE0U1FwbFZWc2h1cTFmNDhD?=
 =?utf-8?B?b1lpRk1tYUtEcGJrYnBZbXNtbmtPaldHK24ydUpSWlYzT2ViRmlrZ2kzR3RX?=
 =?utf-8?Q?8vzY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a1c0f5-232e-46d6-c9a7-08dc6e4a89c8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 04:02:39.9667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rdr0/bjgROodxiVGad79AU+POezGcpmq4ywlxS1/68SM4VJYc4ChsSMO3ceX6hs/ig7IMPsV9CSiFvSsY3i9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9855

On Tue, May 07, 2024 at 11:44:32AM +0800, Shengjiu Wang wrote:
> On Tue, May 7, 2024 at 11:41 AM Frank Li <Frank.li@nxp.com> wrote:
> >
> > On Tue, May 07, 2024 at 09:44:19AM +0800, Shengjiu Wang wrote:
> > > On Tue, May 7, 2024 at 2:22 AM Frank Li <Frank.li@nxp.com> wrote:
> > > >
> > > > On Mon, May 06, 2024 at 11:35:02AM +0800, Shengjiu Wang wrote:
> > > > > According to comments in drivers/pmdomain/imx/gpcv2.c:
> > > > >
> > > > >       /* request the ADB400 to power up */
> > > > >       if (domain->bits.hskreq) {
> > > > >               regmap_update_bits(domain->regmap, domain->regs->hsk,
> > > > >                                  domain->bits.hskreq, domain->bits.hskreq);
> > > > >
> > > > >               /*
> > > > >                * ret = regmap_read_poll_timeout(domain->regmap, domain->regs->hsk, reg_val,
> > > > >                *                                (reg_val & domain->bits.hskack), 0,
> > > > >                *                                USEC_PER_MSEC);
> > > > >                * Technically we need the commented code to wait handshake. But that needs
> > > > >                * the BLK-CTL module BUS clk-en bit being set.
> > > > >                *
> > > > >                * There is a separate BLK-CTL module and we will have such a driver for it,
> > > > >                * that driver will set the BUS clk-en bit and handshake will be triggered
> > > > >                * automatically there. Just add a delay and suppose the handshake finish
> > > > >                * after that.
> > > > >                */
> > > > >       }
> > > > >
> > > > > The BLK-CTL module needs to add delay to wait for a handshake request finished
> > > > > before accessing registers, which is just after the enabling of the power domain.
> > > > >
> > > > > Otherwise there is error:
> > > > >
> > > > > [    2.181035] Kernel panic - not syncing: Asynchronous SError Interrupt
> > > > > [    2.181038] CPU: 1 PID: 48 Comm: kworker/u16:2 Not tainted 6.9.0-rc5-next-20240424-00003-g21cec88845c6 #171
> > > > > [    2.181047] Hardware name: NXP i.MX8MPlus EVK board (DT)
> > > > > [    2.181050] Workqueue: events_unbound deferred_probe_work_func
> > > > > [    2.181064] Call trace:
> > > > > [...]
> > > > > [    2.181142]  arm64_serror_panic+0x6c/0x78
> > > > > [    2.181149]  do_serror+0x3c/0x70
> > > > > [    2.181157]  el1h_64_error_handler+0x30/0x48
> > > > > [    2.181164]  el1h_64_error+0x64/0x68
> > > > > [    2.181171]  clk_imx8mp_audiomix_runtime_resume+0x34/0x44
> > > > > [    2.181183]  __genpd_runtime_resume+0x30/0x80
> > > > > [    2.181195]  genpd_runtime_resume+0x110/0x244
> > > > > [    2.181205]  __rpm_callback+0x48/0x1d8
> > > > > [    2.181213]  rpm_callback+0x68/0x74
> > > > > [    2.181224]  rpm_resume+0x468/0x6c0
> > > > > [    2.181234]  __pm_runtime_resume+0x50/0x94
> > > > > [    2.181243]  pm_runtime_get_suppliers+0x60/0x8c
> > > > > [    2.181258]  __driver_probe_device+0x48/0x12c
> > > > > [    2.181268]  driver_probe_device+0xd8/0x15c
> > > > > [    2.181278]  __device_attach_driver+0xb8/0x134
> > > > > [    2.181290]  bus_for_each_drv+0x84/0xe0
> > > > > [    2.181302]  __device_attach+0x9c/0x188
> > > > > [    2.181312]  device_initial_probe+0x14/0x20
> > > > > [    2.181323]  bus_probe_device+0xac/0xb0
> > > > > [    2.181334]  deferred_probe_work_func+0x88/0xc0
> > > > > [    2.181344]  process_one_work+0x150/0x290
> > > > > [    2.181357]  worker_thread+0x2f8/0x408
> > > > > [    2.181370]  kthread+0x110/0x114
> > > > > [    2.181381]  ret_from_fork+0x10/0x20
> > > > > [    2.181391] SMP: stopping secondary CPUs
> > > > >
> > > > > Fixes: 1496dd413b2e ("clk: imx: imx8mp: Add pm_runtime support for power saving")
> > > > > Reported-by: Francesco Dolcini <francesco@dolcini.it>
> > > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > > Revewied-by: Peng Fan <peng.fan@nxp.com>
> > > > > ---
> > > > > changes in v2:
> > > > > - reduce size of panic log in commit message
> > > > >
> > > > >  drivers/clk/imx/clk-imx8mp-audiomix.c | 7 +++++++
> > > > >  1 file changed, 7 insertions(+)
> > > > >
> > > > > diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > > > index b381d6f784c8..ae2c0f254225 100644
> > > > > --- a/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > > > +++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > > > @@ -6,6 +6,7 @@
> > > > >   */
> > > > >
> > > > >  #include <linux/clk-provider.h>
> > > > > +#include <linux/delay.h>
> > > > >  #include <linux/device.h>
> > > > >  #include <linux/io.h>
> > > > >  #include <linux/mod_devicetable.h>
> > > > > @@ -360,6 +361,12 @@ static int clk_imx8mp_audiomix_runtime_suspend(struct device *dev)
> > > > >
> > > > >  static int clk_imx8mp_audiomix_runtime_resume(struct device *dev)
> > > > >  {
> > > > > +     /*
> > > > > +      * According to the drivers/pmdomain/imx/gpcv2.c
> > > > > +      * need to wait for handshake request to propagate
> > > > > +      */
> > > > > +     udelay(5);
> > > > > +
> > > >
> > > > Did you address the issue I comments at v1?
> > > > It should not fix at here, I think it should be gpcv2.c to delay 5us.
> > >
> > > Other BLK CTRL drivers already delay 5us in its own drivers, if
> > > add delay in gpcv2.c, for these drivers, it will delay 10us totally.
> >
> > We should go forward as correct direction. If udelay should be gpcv2.c,
> > it should be there and remove other udelay in BLK CTRL drivers gradually.
> >
> With Peng's reply:
> 
> "No. Because BLK CTRL enable BUS_EN, before enable BUS_EN, udelay does
> not help. For the audiomix, move to gpcv2 would work, but gpcv2 is
> not only for i.MX8MP audiomix. For mixes, default not enable BUS_EN
> after power on, the udelay must be in blk ctrl driver."
> 
> So gpcv2.c is not correct place for all BLK CTRL drivers.

where BLK-CTRL driver source code?

even if put clk_imx8mp_audiomix_runtime_resume(), it need read any
register before udelay. all regiser read and write is strong ordered. 
when get value from a register, all previous write must be done.

all udelay (5) in gpcv2 may not delay 5us at all.

Frank
> 
> Best regards
> Shengjiu Wang
> 
> > If sometime found 5us is not enough, need change to 6us, we just need
> > change at one place.
> >
> > Frank
> >
> > >
> > > Best regards
> > > Shengjiu Wang
> > >
> > >
> > >
> > > >
> > > > Frank
> > > >
> > > > >       clk_imx8mp_audiomix_save_restore(dev, false);
> > > > >
> > > > >       return 0;
> > > > > --
> > > > > 2.34.1
> > > > >

