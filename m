Return-Path: <linux-kernel+bounces-296394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F9295AA7D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DFE8285724
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D571B7FD;
	Thu, 22 Aug 2024 01:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oMNO3hZk"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013026.outbound.protection.outlook.com [52.101.67.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA3F1173F;
	Thu, 22 Aug 2024 01:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724290038; cv=fail; b=TrEr+Solb0w9kSqa1FY4rwyBdDuz/9zBOi5BGiXom7KFj3J7n0jV9w0Q3o7tpRIqb/WEfUeIOjSK/zWp/lpiwqbJwaVJRufadt/0/NZ5jqkCnK9DX/HucmIifZOSIJctR4O4eKpY0E+c467zLgEhWOnsIzlps9val0KCaoSg1mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724290038; c=relaxed/simple;
	bh=FDHFcjELj3uxew0coEDEY6/v8wdW3xUMTnofNOgVzqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sUYk2/FmVi2xPD/Xjn9E4weBDKy+lSlG/8G6hP2kQefIn9hiTllnmJnnNbCKtk4januCQLTqP4LagMYTo1i8J8Rhcxq+gnpM2OG6iajpIhWUTuVmK1fOZn0vTYUoB+cPrU4Ne4t7wrf3hGTxpn8BMKh1BbrTBrYoaDjp2BBOZFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oMNO3hZk; arc=fail smtp.client-ip=52.101.67.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFvVdczryRoVWMmEbQpe8TVfwdCAFNPOSBHl3Wj39sKvBJnHwcFDw1CGRynRcmpZoN9s92eUkq51BcenuO2ey20dTeX2emLXkiMkxb4AeB7sXit7cy6WMiY4KjQD8QEPmatDrOjv5G8axoAGei0gG/G0Z2WqvoQXj1rV/B16bEAfDLCEUr4wxyo1HtJ2aVjd90r6+ncAbxmdsVLePkritPF1BbeqKkUT9KLWyxoUPaaqsVN/kpEOeg+4jOoxOmo0J7zpQTIGGzeZLBQ/w9haI3MH2feGbm/4Xx8luaLiLrTPM5pzqDdhBv5yEdCL8d0u8HvdGcSXlKV4JR9+MYVz8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDHFcjELj3uxew0coEDEY6/v8wdW3xUMTnofNOgVzqM=;
 b=Mlv8kS9Y0sQ7sVosL6TBOjF3P7XFGpXeutUrWTX6uQ49ogKW3vskjfJLTHUIwiH5o9ItTteWEdWKN5bgCTSvnwpzY58EgSX6y2zqdGNd8zME3lWCU0+lSOn5OqgLyhsJwWRgyJx8SX4UViazfq9xMMYlJtWiBqpTg//wqxoIR+Kf1xEE9BNFystQskwif/SkJ0U+48jzYQ1MRp0up6cA7KfcmvZeVv9r/JR9fYTZKQhf21uNOKqi4vQSLLS7iuVlrgzkjy40h23OfEMSP9oTw2TXCx+XtBPihpvjploHdck53cFdOu/CJQXMJNASuEBORQ/GKM1wl2TM/JTKlVEBWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDHFcjELj3uxew0coEDEY6/v8wdW3xUMTnofNOgVzqM=;
 b=oMNO3hZk6DT7Hq8nahntzDeGJxsA50wLdkhrNgLJ8DGPhdx045JLKDoNb2GcQuGt8cZr+qdKccBi9JBMJmtLqgRU882iVe5XGtXdC0LAXMcJ1XshqumpCsCl6pjoF0/4uO1t1ZVuXMyKT02oGiRrwc2A9k8cbs0Lk+zphiAtpnjazpqjpwUhRsWw1xNF8Mw+PQV0Kk2sPDFB/06f8Jx1V72Zqrzt4TMWb7JYZBD3F+xDQJUYKluPr4ECgdAivUuKJ9p1173wSxsDCLEm7FA1F5GMV4waNMvH4vy2qdwwuPWzuuD1BSWz2axGhqM6bFSqP8MNOKVWq0HbvX9Oi2JaqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8714.eurprd04.prod.outlook.com (2603:10a6:20b:43d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 01:27:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 01:27:13 +0000
Date: Wed, 21 Aug 2024 21:27:05 -0400
From: Frank Li <Frank.li@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	jun.li@nxp.com
Subject: Re: [PATCH v2 1/3] usb: host: xhci-plat: Parse
 xhci-missing_cas_quirk and apply quirk
Message-ID: <ZsaT6VctQ18UEFd4@lizhi-Precision-Tower-5810>
References: <20240821-dwc-mp-v2-0-2a29b6a5c2f4@nxp.com>
 <20240821-dwc-mp-v2-1-2a29b6a5c2f4@nxp.com>
 <CAOMZO5DNndao-kU9s9F_1XGMdTP-sgComD9UoaSOQpfkErBEXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5DNndao-kU9s9F_1XGMdTP-sgComD9UoaSOQpfkErBEXw@mail.gmail.com>
X-ClientProxiedBy: BY5PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8714:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fde1584-be1c-41dc-b452-08dcc2498cca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3dVU3lncUZ3YTlzbkRrZW1lT2F5cHd6UXVoRHExMWlhOHpFM2piejZ1dERG?=
 =?utf-8?B?NXo1a2hUOUlpVll6WXphVW8xRmpTS0VjMFFOZ0hKT3ozRHFmbTgwMzNoTUg3?=
 =?utf-8?B?bGlIUys1N3hGZE51R0VpL3RlYzZ5c2t4VTdPR2E2c0VjdnhRY1hRWk16dVhI?=
 =?utf-8?B?UFo3UGVvSENMbVMraXJCZ2FwdWlXTmJQRkh5NjhHNlI3V1lkMnVab0pkUnhQ?=
 =?utf-8?B?UlBIYS80dXZkTDZXYWN2djBZbm42NjhDVGhreWtZSDB5VkdUQUp6M05RTFlm?=
 =?utf-8?B?V1ZseHRzS3Fma1ljbkxqbTlQZmNKNW8yWWhEK3RXUkVpbFRhSnZWSE93ZzVX?=
 =?utf-8?B?THYxY254ZnBjV0g3MlZOejBETmdpaXNBRTQxMWluSWhDT29IRHNXMmNuSHdn?=
 =?utf-8?B?RnFIbVZjNk9BaWdmdXVqY1NtdU0xTEhaVDVya1pOejFIaUJ4MzRVWDBRajFj?=
 =?utf-8?B?NG0wZXlpcXM3bGlQYmlTaXdORXRzd0EvVlVEdUorSC9kQnFhRUdXYWRtbEw5?=
 =?utf-8?B?SDY5ZWE0ZlpUVVNEci9FaytOMDl6VjB4MTlzN3F5OU55N050cGhvcXdNR2hK?=
 =?utf-8?B?bWxaY2VFMnNnZ2Y2SmkxZ1NNaWsrK1llTkllOHkvMjBzWmdHRTg1MVNhUWRS?=
 =?utf-8?B?eDNVTEFVSXlPcHBIYmtjT0xpODZkbXMrTTN5QWpiY0xCeStkV1hDVm80ODRa?=
 =?utf-8?B?cDVva245dHI2NzRNdnRYVStCQmZXeGlYM3BMUUtoV25WckJDYTRFdGxEY0Qx?=
 =?utf-8?B?UE05Z1lOUjZRTHdTa21XQWQ1cnRsZWNEMWl0NmFaVVBncmV4S1NmaW9DRytH?=
 =?utf-8?B?VUZ0ZWp6UGdTSXBTZUNMYWlrUExiVFZzUTRIdjJocDZFNjJneHJDanFVQVpz?=
 =?utf-8?B?dWhzc1JsZEtaL01JYU1hTElFYWZnZHBIVWg0YS9vN2VhNkcxR003YUVkN0xL?=
 =?utf-8?B?MHhiaFlOSVJOM2lLS1MzaXMrMFpkNlRIaHBuWnNDZG5CSWN3eFd5YlJaaUFr?=
 =?utf-8?B?dFlEUmhCRHR6VkhhVVBCcythdUlqRTlMdUMxMHorOEUvNWpYVXM1eXMxSU1s?=
 =?utf-8?B?U1c1ZmpoK0FZTHRVNE1lQU9wVER4OStESER5eDJJM2NMSTNsN2IwaElvQ1ow?=
 =?utf-8?B?ZWNBZ1BUSWttSGlxVzZUVjhMM0l2eE1vaXRqMFhaSjZPbHVVQ1N1MWp6Mnl4?=
 =?utf-8?B?eEU4Q0FKV0VmSHFiZnNqQms5Y3J3d3dRL1praWRCUmVFQWwwYWJkMyszU1RY?=
 =?utf-8?B?YkswUW56aDA3bnlkeVkxNjZEQk9FaWN1eXhSRWcrOTMrZ0ZoSXJoZkRla2My?=
 =?utf-8?B?MzdvWllsVnpicmxPcE5NZHZDeTcydW56N0ZoSlFiV203QVV2cXZML052ZjJq?=
 =?utf-8?B?NDNYSXdXZitsT0RWdjQxRkFpNUhDNEF4MzdEb0NQaE0wV2VPb2pGdXVuZm96?=
 =?utf-8?B?UnBuRjhxQ3BnN1Exbk1yM1dCZHc1V2pYN0JrNDFQeW5Nekk1K1VNUmc4dmI3?=
 =?utf-8?B?Qy96SlZFRitFUW5XZzJTUUtvclhncFk1WDJRTWVQamh3SWorQzhZcU00N2xL?=
 =?utf-8?B?N3M1TDQrSnRwYldyajhmNW4zSFRYa2ZCNCtXcXNGZUVpeUU4Um1TU1ZXOXhW?=
 =?utf-8?B?UVQxd3k5M016djBRRXVUSExYVjlvbUZhYkdoOXhUbjJpWjFzMFdkWlNtS0I2?=
 =?utf-8?B?WDJZcFhsTGxTbG53ZUVHbGtqd0x2Z0pFM1Y3dU5ZUzM5c2hIdnVCMnduK1U5?=
 =?utf-8?B?RERncTRZZ1c0dXhnbE83RHFmajNrQzVZOFJML282aHEzc2lnQnAwMGhLY3ht?=
 =?utf-8?B?VjBEY2xlV0hKWlplZlJ1WmY5UktOL2RwQmgvZmhZci9yQkhDZlYrendKZEkv?=
 =?utf-8?B?SUdkUzRWTUtUVksyL2pWeStxS1l3N01ia3lFKzFNVVlrVlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1l3OGJFbUM2T2dGd2NtV2dlK1FXTERiM1lCeFNLTVdDd2E3YnZ1aEl1ck5i?=
 =?utf-8?B?bjRaUjlGZ3JQV1Arc2NxMzVSc1oxenJITHB0bkJlUVQzMTZXeWNTWkdnNTBl?=
 =?utf-8?B?QjJtY2VKRi9oVzdsdC85RVpQN3Y5K0EwUUN0clByNEF0MHJvVDJxaDJMaFJj?=
 =?utf-8?B?cWtGaWhYdTdPdHhpYnZLbWlyVThCTm9OOGtSY3JGbGNxa3FJYXlCa1BDa3FX?=
 =?utf-8?B?UXBRL2RtdWlIZDBTdmsyNUJZU2R3YzFMeFMydk02MUppTDNacGhjcjU4OTB5?=
 =?utf-8?B?UVJWaXJFcUVXNzBDQ0lnTW0xMmJuOVRGOHpXbDBpQ3d1cHdiSTM3UklBYWtn?=
 =?utf-8?B?MG9yNVRuWGpmcWlWRkYvRkRGR2Z5MGwwMjUvMVZzbTZ0ckx1NFJyMkliMnRI?=
 =?utf-8?B?Q2h5Y25RN01qUTNvUVpMSW1RY090aTAzdTdlOWdsc09GV2dVOWZKcTlaVGpj?=
 =?utf-8?B?dUU2WnhCYk1DZFBZemxCTG8rTkFEZHVNSG1pamR3cEFOU3p5R0dGK045QWhM?=
 =?utf-8?B?eWorTlVWazhzR1MxV0p6NytHVFpLd1pqNGNxKzZnYTduMTRjQ2pyZTBYRkRE?=
 =?utf-8?B?UXV4R2g3U3k1OFVCSERKTnh4R2NsVTNRSmRSRTlYL1Z1M1g4YzUyUUpuOE40?=
 =?utf-8?B?UlpxMTlTOU91blEzbEkyT0ZySGREMUN5NjM0bktVRWx1ZlJFTmg3cU9mS1pr?=
 =?utf-8?B?SGJwUjJHZlRYeEJ0cVJxdUgxZ1dwclk0bVpBZTI2b253OW1Ba0tJVFdyRnlr?=
 =?utf-8?B?OTdackQ5S0RaYUNpanJKQmZMRHBzdlJGdWJLWVpUcVp5N24xOEhvVWhxYXQy?=
 =?utf-8?B?T0dXcUd1UUNnNVRvTTB4NXVlQk9ZN2l6c1FoZm5IMHJuT29vaXBmTXpiYnNq?=
 =?utf-8?B?bmVPT09UMThxK3phU044WVhaZjQxNkRPMU5UNGRiL2lSd08xdU9ydnZQaGF2?=
 =?utf-8?B?RHg0RDA1U0hOZ2dKMUlsakhSQ0lUc2w3ajFuc250Q1pkdU0xK2ticFRnWkdu?=
 =?utf-8?B?Z21Wc3NmM0xVQTFsTTJyNHBScm5HcFV4Y0tsanNNSVBYMXZ2RTBnSTFmdk9i?=
 =?utf-8?B?R3hMc2xsOE9EcENwUE5mYmRTWm9DYmdQOFNuRFYzaGtNLzJHQk5FLzVwOGI1?=
 =?utf-8?B?MlFiai93YW9zcTdxdkEzYUVTNFlqRkZwalFqVndDK1NGS1JtZmRHODJyYlJB?=
 =?utf-8?B?ZVUxc0JnaGowQjBELzdiUnRVd0ZmeW5heXR0ekRnWTVGZlhiMmwwenhnQktr?=
 =?utf-8?B?MGNQR1NhQTRMUWQrWlJtYUlrZ0gvb2paL2RKSkpvRlBXcTZyTVhZYmM4Qjdh?=
 =?utf-8?B?WFozT2dJdXRLWjRDcWdFaFJrMEdTWmsxclEwckpxOGdVT1ljVEVHRU04V1VB?=
 =?utf-8?B?M3BORXVoRFMrOEgyZ2ZuMHFzSkowb2JuODFmYk1YcG5mNzhDb01DRm9nRzd3?=
 =?utf-8?B?d2ZzM3BEWTREaXVuZVJONXFnM2M4N05SRDh1YzVrUzFVcTA2OThNbzFtNzdl?=
 =?utf-8?B?ODhzSmFMMlFSWVFoM3hwdWxwZjludUF0OFF4UDROWGp6RnlFY2VHZDNHb3Bs?=
 =?utf-8?B?NFJHUEJ5RWtXbzRHTjNzMEZYSjVhdzVucXFwNk9ldE1wemhaeXN0bjh3QTR6?=
 =?utf-8?B?cE5STjJGNHZXa2p1SWJhTHlGdE5kSHRXWjBrQnJwTlJqWTdEM1ZtQWI2NDVS?=
 =?utf-8?B?UlBHTXQ2RGxIWGxSNkIxTFgveGRYRGg1UUJQSzFCd1NTUk1uclVzUWxoSGdK?=
 =?utf-8?B?TVJwM1VJdE5WdXI5anpHQTR6ckoweTkxdUxqMkFUUGVPZ1RDQWJkYTc2RjBL?=
 =?utf-8?B?eGRaTVErTGkweEx4b2cxbWVUM3RSZzVvZkcyWGRndDNoWkVkNEZRZWZhUHhi?=
 =?utf-8?B?N2ZVdFFvMS9XZ3lsRVJHZnNhWE1tQWc5amtnbXdUUE82ajVJRHlLeHhmK25z?=
 =?utf-8?B?aTBWS3lwYnhtdUEyc3FFRGlZelN5OEo3R3dtRzZSWk9wNExGZjdhRlMvcDF5?=
 =?utf-8?B?YWpBMDNaSFRDOWNua1ljR1IxMFVYNEZQZGZYN1IrcFdaUmhFYUlDUzI3OEty?=
 =?utf-8?B?WVVLQXpzWVVHeHpBalkvNzRyTW5xMHFFaEJxU2ZwYnI1YndhYXR5OVQ2eVRa?=
 =?utf-8?Q?brfk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fde1584-be1c-41dc-b452-08dcc2498cca
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 01:27:13.2052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7n0iDmY3V/CDlzlZqCYPhvBYojnUhVIAjw1ctmoVWsXTzTI7bo/8iLwaC7/kzo/MPytJgQpOnEvIqDQZnnQkbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8714

On Wed, Aug 21, 2024 at 06:16:18PM -0300, Fabio Estevam wrote:
> Hi Frank,
>
> On Wed, Aug 21, 2024 at 1:19 PM Frank Li <Frank.Li@nxp.com> wrote:
> >
> > Parse software managed property 'xhci-skip-phy-init-quirk' and
> > 'xhci-skip-phy-init-quirk' to apply related quirk. It allows usb glue layer
> > driver apply these quirk.
>
> Please explain the reason in the commit log.

XHCI_MISSING_CAS and XHCI_SKIP_PHY_INIT is already defined at
drivers/usb/host/xhci.h

This patch just add software manage dt property map to these exist quirk.

>
> What does it fix? Why do we need these quirks? Or what does it improve?

This one just add map dt property to driver existed quirk, not fix anything
in this patch.


