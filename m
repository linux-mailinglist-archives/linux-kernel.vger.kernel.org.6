Return-Path: <linux-kernel+bounces-313183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C56896A198
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09A4E1F23088
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E6213E3E5;
	Tue,  3 Sep 2024 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lRfr3xcR"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013045.outbound.protection.outlook.com [52.101.67.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E157154BE9
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376003; cv=fail; b=sh7e0kAsgf2jKV5FTxA5Dzd01mJxS/ny3vFinKVGXvz1dX/gQiCtaQNKyff+Wvo1++gaz73Q352Q9JNucjMs+2yspmwRa76NkQGR2Be9AVkXTPRppMMpbcWwztDs42kD0hp6ctijsStdT8k6YI9wPsXQlraqFHHFjTxQyaU0LEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376003; c=relaxed/simple;
	bh=JJGPidJ0kLxSss7FCISHy7hHPPYp9CD6i0cB0iitmsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KYa4E/XoxRR9E2b8aWV/m1EIztXuUstysuguTGDrAGJkfXbQAqswabStJmiBsbB8OwrMgS9lgDEACiLAKXlqYG7t2g+5zC3KPnE8UQlKetUH3vHpM0Lk4LWYZQJVFlyvxVxVsL5V8K70wtynxv9RcaEUZaM0E/Cs3F7ACopGCAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lRfr3xcR reason="signature verification failed"; arc=fail smtp.client-ip=52.101.67.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWVkdLOZDYyaRcADXm2iGEqkuQ67SSH6EE4stAkqfO//teutPZ9/7lTpbhIXKCgjNq+RdtHHdzZg8f0VneeGdNqub1nq7wnv++MHFGYi5NwQRCsLfelrSLhVV7xI7Rrr872DkRDEPuQD/6FuMKUCeTWzbz1EX9b4zK+CT2z+0I9aKXAfTzHuDR+ZtcCTApIGannBLGnnb37eLaqm2fEwHz+87koe4OoMeFSyLo6+xL4RfQbw0AwiNt5blwT/UsLfAfB0z8n44NSelU9lKHOxd6Jir6DH3qCIEKvizzSea2dl5Yk5N3HiWk8criYwWBWZpz1t8dq+pyRBM/HLZoDplw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UZFGOf4mm1NikeFGmIUJcBAraIrec9GdjRN25ezquU=;
 b=O1mt2qMqJNPc5exMNqnOsD3hQp01kJGvqTqJ3xEEefLC5WZZlkAUx+gGosjKnKmtnRfZZYu6O9WN2UcIIkXNaZqkYYb5J5BHFoPHRieHPFxbx7fxw5NwQoleBEoy/ixN1xqUzJWpeX0U4pSaUXiepFBXUWXnlqX3FxGqy6x3tXfnsu9n6tk7YA7mxUxCMdoZxXxkGpHIoME9hS2nFzvbRvEWTLFYvGOmHd7b5/lnf2PcERLds6ylanoLZW9/q13+XgmxnZCezviR/t9uDyCLMeiFf06Rq/I3cugjBu95REwdak9rDLxKViby7F3/Nq1wd0biGSU7zp+wTEvFX4Z8ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UZFGOf4mm1NikeFGmIUJcBAraIrec9GdjRN25ezquU=;
 b=lRfr3xcRhVf248TDjJXe8PHo2aCNkTOwBtZzf7iTpF1lrUr96DCK0LpbKxTWy/iD8X+fvZODMPqHAfkg0Suu12CZNIwtgqcJz7OSuKTErsx3rF1oSAjtq+IsiCN3otC8JOUOedcTEG7ylSfl3qIxA1zp7k5sqHch61QW19kfhvi9Vr7Z6nIxR/Y40ZvfxV9KDiFlbrKfY057M6cR86ijxnTKNQnvi4fMHhNAePa5W1rxO5/JR78N+eYlDgRTHFB6dUknLyJ524oP+rL826L6L66HjSV8NhS/uuxzqMsPqQ2v/86toAuNKl3uZ6sUIsG3/x/XLXREDCI0ZmWX398PBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7549.eurprd04.prod.outlook.com (2603:10a6:102:e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 3 Sep
 2024 15:06:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.020; Tue, 3 Sep 2024
 15:06:38 +0000
Date: Tue, 3 Sep 2024 11:06:30 -0400
From: Frank Li <Frank.li@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Parshuram Thombare <pthombar@cadence.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Conor Culhane <conor.culhane@silvaco.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v3 03/11] i3c: master: Extend address status bit to 4 and
 add I3C_ADDR_SLOT_EXT_INIT
Message-ID: <Ztcl9phmRK4yOvun@lizhi-Precision-Tower-5810>
References: <20240819-i3c_fix-v3-3-7d69f7b0a05e@nxp.com>
 <20240823180426.056ac093@xps-13>
 <ZsjNA9JV0UKONV32@lizhi-Precision-Tower-5810>
 <20240826100430.33194702@xps-13>
 <Zsylya9TN4mVFL79@lizhi-Precision-Tower-5810>
 <20240826184924.53b48861@xps-13>
 <ZszPrBeoPehGsocC@lizhi-Precision-Tower-5810>
 <20240902161250.26846654@xps-13>
 <ZtYCA9cYywmUaJSQ@lizhi-Precision-Tower-5810>
 <20240903150038.3f224ec9@xps-13>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240903150038.3f224ec9@xps-13>
X-ClientProxiedBy: SJ0PR05CA0144.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 3baad81f-b7a8-46b4-f1c7-08dccc2a0244
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?iso-8859-1?Q?J+VCZJqGpPuuxRD2x00POWZNfM0R4x6T4UEsvMVN+gitZpf3ubReUaqxyQ?=
 =?iso-8859-1?Q?QN0CfRKwzvdMviGYGr3a2Wt39jiIkVGscj2Qh3B0es4rXhdTumga43iEP6?=
 =?iso-8859-1?Q?OJItofvt7sHGEbwb56tSDRL7e39/lY3WyY6KGtYUqIcaHXmpX+J5NPeDmi?=
 =?iso-8859-1?Q?nJj+GpK8q8A2EkuA0KifAkGJs63fB5IG4wuE0VvC4zSqaiIwMti73JNMWH?=
 =?iso-8859-1?Q?HUIN7ck5vOrt1rJK4d1K9bC0am6UdOgKnck9DEEVWsDxhzdiYZPhO2WPKN?=
 =?iso-8859-1?Q?Adq/Ls/0LIgYmF4Zz6cLDRrrD7jW3M2V9y9eyXPQAIGQ7XfP+bxiaSEW10?=
 =?iso-8859-1?Q?Zmca61SoCznSzCPlKh+fQvm/ZYGgBQRPSwS1Md2fUmGp01UYouhSMNpIoo?=
 =?iso-8859-1?Q?1r6d28HEongnqjRMZ4SWB+57OnUxBa5Br+urXbLrVzjK8BYGo4mmZgS2HO?=
 =?iso-8859-1?Q?5koUWG7e0f+4qwo5WGzIlbm9pZX+YfBQ/e2K17/RSt9JtbFCWKJjbqyFsj?=
 =?iso-8859-1?Q?S4papaSbXAtvReIIJdPgj+f+LqJXQHdo7aePb0+sJljD9Ez6cn/FxL6ia7?=
 =?iso-8859-1?Q?Ktsh57F0PT0gCzYMfhU0RIRZhtMWT6v/Os4CtAM0c+DapLXhsNbeRwDOet?=
 =?iso-8859-1?Q?N3+jIndX0trC6AhFx1UFB0LIihfWltsAtgOp17VdTZrTUTrBtlKn/kyB4C?=
 =?iso-8859-1?Q?Wao8U4mqKnL7rRZ1Y0GXe9ysfvapp1Zc7qc/9FzMP92j3TKb2jV4fsy909?=
 =?iso-8859-1?Q?99tMwdeZZS5RZGm6yHWtwJvZrc4GDrb3NTZdacBfVdXU3BFFt46tjcqbGn?=
 =?iso-8859-1?Q?bh/v2FdSqAl4mHaLkiUfisM/XqG9mKubcuzUP7M4yOpg2meC8jEAS2yXlX?=
 =?iso-8859-1?Q?Dw/NITX1j8lbGJH8fzmhzjKMyF09lRqWR3mY/L/CbYcVHJS9zHdCI2xHV/?=
 =?iso-8859-1?Q?YD6FPk9UlOPnmPTbADXduqyofnLmrDgb6A7y7Urk6Qd0FHme966ewutRva?=
 =?iso-8859-1?Q?K6+j/kWcP9Wl9JRatOs7xdTelI5suo+ORE0i5eQqj0fW/OV//lzr9XthWF?=
 =?iso-8859-1?Q?Fcng5t4USISnPR9E+Hfn5wQs959dwyYygsvT3niqVKKYvO37U8KXtFxg/O?=
 =?iso-8859-1?Q?FtKDptAcY7FeO1ZF3FxwtbZv48MppIF4u/fYSgY/arIXTssDS1XGvBaV3i?=
 =?iso-8859-1?Q?SoJhVb7zS3nMh88IW4/X7Ke26BU2ixpCENlY7fCcupsWyS+tJYnameZrqu?=
 =?iso-8859-1?Q?8EfMjGin2eIEYmpNRuCVHbx6AKlO3NC9iUJlKQvmyjlGvDWheiWSvv5wc3?=
 =?iso-8859-1?Q?B/X+Kt3e3ISbj9np6uoMpCVVQJtt0Gg/iF0h/XO47Tgh8P/5eCXSqanEB7?=
 =?iso-8859-1?Q?dK/PxDq9MWCAXE++D4rMuM1W+W99ID/9nMn/jZ3Nb5IURjMBRgjULPfcX0?=
 =?iso-8859-1?Q?AYYe461GtbzxwwFF6Cnf3G4ch3UjYEcA2RFOUQ=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?iso-8859-1?Q?ugq3XP2ycDIFvKl7JMF8dT8/8E/XTMPddnAiY5EbjVhgmqQr/OQ/+VYxUk?=
 =?iso-8859-1?Q?j52NFhhmNd/ivr8U9JAV2Y0YLhPlKXU9TxOnvzU9+J8Uv4IgZF6t+Fz2LF?=
 =?iso-8859-1?Q?TVQLF3RhTuSiXR1jeYcLRY8VC/UUnBYhfsK8O3uM03xOfDhbNl+m8pkeWe?=
 =?iso-8859-1?Q?ZloXlcvMXzIfGmjn6FTX+ZMaUrHzHVSi6rHjcsjBGV9wFPK0iZvk6MhcHg?=
 =?iso-8859-1?Q?+BAqgO4omppybzqDw7j4nO/de0dADbaKE8ZiK56jmVcG04TSdkS4lF0niP?=
 =?iso-8859-1?Q?4bmXPzRzSz6Mn2owg8Luo871z3O7s2/d+g6LpwiW4IxyqJT6QfKgj05m3p?=
 =?iso-8859-1?Q?g8zh4Drx2jpYhqPgW1DWPrnOLYdc08+pqdtbm9Lq3T5vxTNoz4z458hFA8?=
 =?iso-8859-1?Q?ZrwOmtaEPrEHxe86HbuykYPnuzwG4lXZbgVjmU3HEk4X92EG1njCbK4Ko1?=
 =?iso-8859-1?Q?QGq3o95yNF6v+heXs6sGemjaiwGtlicN239/uiDsjAY3QRTxC5zM6JeInA?=
 =?iso-8859-1?Q?OqSDLZvIbFZ8rLK5XQFmnOnudGuWRAC/hfmcV/aZ8MscrFJDvkmL3xYULu?=
 =?iso-8859-1?Q?a2NVddfUF3yDdbtHDgREmkN6BkDzjapvWxCdt/qhTgZsJuH2nWsjX+7S/V?=
 =?iso-8859-1?Q?QotIb21o6OmXGnFii3lZ0t6mGvHJsyDUKl8Eiu3oBtxr1EZPlnGR12BF4P?=
 =?iso-8859-1?Q?u0UMVE8Rbj5JUlkr3MvHv8YGbbRhhkta3MfIUb2hszQ2sECYzADY8z0vcr?=
 =?iso-8859-1?Q?mzYBSoj3yqmRnOZJtCNOdoMS95b3GXTokcSZNkVLtQe/iem8L7sFgAqEHt?=
 =?iso-8859-1?Q?mwdXhOxtnSc+UuhBAqImXBpWkZn8SP5+w7u6GWqKsmxn9szbQBvB7gT8gc?=
 =?iso-8859-1?Q?5YPqkLC4sy1kYmHERNxinX8noPQzuxFJstn1vsB1qWIw483QZGA70BAIuS?=
 =?iso-8859-1?Q?KICWDOpvEYE2MjApOkKsVNJOCoOlpq3PAbdWQbEJnWJTC4WKOCw1rf4cmV?=
 =?iso-8859-1?Q?85AqqpoB3qyq2A2R8mrifXHSQ/yO29OS1x5DGb4vAjyYjjVpJxBb/frrGC?=
 =?iso-8859-1?Q?aOd10Kk7gRdYM2tU6UZPnMt7KcqcVw8X+GgFi5rBfJanz+JvcQrWwEDDW+?=
 =?iso-8859-1?Q?W4IWGFcb8Zq0fD1PRQiXxXEOyGpRlIFIgLkUJ2HirUVHKTHinG1VN7kHLr?=
 =?iso-8859-1?Q?82V71l1FrDe/ogCXlaQG99sxFnpAQvBxYrDzJHV1dP7liC0uiXgJE131H9?=
 =?iso-8859-1?Q?pdu2w1qiEPt+7nOXGCNwPVe97l19BDdr0Ohdav1jbdRNwMXoHGg04+jDCY?=
 =?iso-8859-1?Q?SnjIt7OteRqP3px3mT5rl2enF28HWRljwWh/vqs0XZG/nlt4Ey8TuKscrm?=
 =?iso-8859-1?Q?WRh9c38SOlsgrwLeJrkuTe9Zz0dzazh/fdWQnH1EM9ZxqveMpNd3CZPnuT?=
 =?iso-8859-1?Q?Ik2p3E91qLJhUakA1O1TnKQo6VDA5L0sLszQ4+SamYiGy6c+UCWMMu3Uw0?=
 =?iso-8859-1?Q?VYYekCdFev069m65a1JHhFNLoCat3fYIK4XYW1uvTeI0AlliQNZa5Q+nP2?=
 =?iso-8859-1?Q?ipXiiHeAyIBEJpdNBWSZCAPZ2KlsS/+MrFgnXjPWNYk4QCoEB4fEKa/edX?=
 =?iso-8859-1?Q?/y5jE9GbJbv3XsiDQ1+dJg13O9p6H3eGg/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3baad81f-b7a8-46b4-f1c7-08dccc2a0244
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 15:06:37.9628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZT/clblYLwIcWp3UMwBm3aXdFvDLXN8REyco2Cfmv2L/q8wq+L/F7rbv1F1JHqVRMgRfvAkzstYDkJYikfi7/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7549

On Tue, Sep 03, 2024 at 03:00:38PM +0200, Miquel Raynal wrote:
> Hi Frank,
>
> Frank.li@nxp.com wrote on Mon, 2 Sep 2024 14:20:51 -0400:
>
> > On Mon, Sep 02, 2024 at 04:12:50PM +0200, Miquel Raynal wrote:
> > > Hi Frank,
> > >
> > > > > > switch to this address if it is free.
> > > > > >  *
> > > > > > In step 1, i3c_bus_get_free_addr() is called. To optimize for step 2b, this
> > > > > > function should return an address that is not pre-reserved by any target
> > > > > > device with an assigned address in the device tree (DT).
> > > > >
> > > > > This does not make sense, if you want to optimize for 2b, why not
> > > > > selecting the assigned-address property in the first place if it's
> > > > > available?
> > > >
> > > > This is my first idea. But I gived up this way.
> > > >
> > > > Select an assigned-address here will involve a big change in i3c framework.
> > > > There are no PID information in i3c_master_get_free_addr().
> > > >
> > > > In DAA flow:
> > > > - SVC is get PID first, the get_free_addr(). This case, we can use PID to
> > > > get dt assigned address.(if change/add API)
> > > > - But HCI, it is difference, hci_cmd_v2_daa(), get_free_addr() firstly then
> > > > send out DAA command. So no PID information when call get_free_addr().
> > > >
> > > > To cover both case, return a *real* free address here is simplest solution.
> > >
> > > But this is a limitation of the HCI driver? So why not addressing this
> > > in the HCI driver instead? It would greatly simplify the core logic
> > > which becomes complex for wrong reasons.
> >
> > It is reasonable requirement to reduce stall SCL time. After get PID, SCL
> > have to stall low to wait for software get dynamtic address, I3C spec allow
> > relative long time for this, but still better if hardware can send out PID
> > and dynamatic address together withoug stall SCL low. Pre-alloc adddress is
> > good method if consider this.
>
> I don't think it is worth the trouble, given the complexity of all
> the changes. I prefer to simplify a bit the software and keep it
> readable than gaining few us with SCL low. In this case you also spend
> more time on the configuration I guess, so is it better than keeping
> SCL low (it will be low for some time anyway).

Yes, but see below about HCI. But two solutions will be worse.

>
> > > > >  Also, I don't understand why you would care to specifically
> > > > > *not* return an address that might be the default one for another
> > > > > device in the first place.
> > > >
> > > > If devices A (want adddress 0xA), device B (want address 0xB), if both
> > > > device send hot join at the same time. device B's PID less than device A,
> > > >
> > > > Device B will be found firstly, call get_free_addr(), 0xA will be return
> > > > if no this patch.
> > > >
> > > > Device A, call try_get_freeaddr() to get 0xB.
> > > >
> > > > So Devcie B will be assign to 0xA, and Device A will be assign to address 0xB.
> > > >
> > > > After do_daa command, framework will add device B and device A into i3c bus.
> > > >
> > > > When framework try to add device B to i3c bus, framework will try switch
> > > > device B's address to 0xB from 0xA, but it will be fail because 0xB already
> > > > assigned to device A.
> > >
> > > Well, okay, but that's exactly the situation that will happen if these
> > > devices are not described in your DT. I guess it's expected that a
> > > device not described in your DT can be connected, thanks to the
> > > hot-join feature. In this case you cannot know what is this device
> > > preferred address and you might end-up in the exact same situation.
> >
> > If not descript in DT, it means that any dynmatic address can be assigned.
>
> That's the point of view of the host. But a device might be "critical"
> and expect a low address, but the host not being aware. This is the
> same situation as your A and B conflict example.

DT provided addtional information to let host aware it.

>
> > > May I question the need for preferred addresses at all? Is this even
> > > part of the spec? What is the use-case?
> >
> > It is implements detail. I3C spec said lower dynamtic address have high IBI
> > priority. Spec just said assign lower dynamtic address if want to higher
> > IBI prioerity. Using DT assign-address just is one implement method.
>
> Thanks for all the information, for me the HCI driver must be modified
> to retrieve the PID before assigning the dynamic address.

I am not famillar with HCI, but according to I3C HCI Spec 1.2, sec 6.4.1
Dynamic Address Assignment with ENTDAA:

I think it is impossible to do that. A dynatimic address must be provided
before issue ENTDAA command. HCI is MIPI I3C standard defined Host
interface. we have to consider this.

Frank
>
> Thanks,
> Miquèl

