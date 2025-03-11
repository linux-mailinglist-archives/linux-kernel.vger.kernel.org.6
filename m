Return-Path: <linux-kernel+bounces-555861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9109DA5BD89
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D4EC7A385F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C27230BF3;
	Tue, 11 Mar 2025 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YLFXS831"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0006236441;
	Tue, 11 Mar 2025 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741688205; cv=fail; b=MhRsNCtD9JgElE03C9QgL3E55yWBgJUKVM/qPUuWo3woawgWCmoZeIxgChmryqVEqlvhcVYAylhmYyGlqxb194uasHkbqoMXROgENLzG7wJar6yI6tnsIIu3C/tBVB/qRyzdJPJShBnU2K60nKz1KyK90HzeDgUPjHa9M1HKI5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741688205; c=relaxed/simple;
	bh=sOFx0xbXmNFZvjYpxD//JvG44y/td49y3OV4dSFJBrI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=e5d0aQ3mvjPl/wZClwq88soCzq+xusC7YUJm4hTW3neQv2QCOKPBK7NRWPZi0VPTL2yMwH71lxGeRHY+7FG44c0kKGG+SuGx9gdWzMG+s1Llek1bchW7jCZAHDZCH5gOUoRPAYdLtYNUkJFRm1Ir0+1cxmlCoxheLnyjC8qPBeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YLFXS831; arc=fail smtp.client-ip=40.107.22.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKpQpqifaHdP2VmhIuPgC70A8Yy8p9/6Mo2AF4z2q20h0KnpgdFTOSxjFQf7YbXvEEYNYNGQn/DLjFuE88um9aZMuHH6tnOF3d/yJOTad5Z3ezQbZAr/gNNZAk+we/lvoWtkUUnrEuG9tSSZvY5AU2m0DfAU45gUIIzWHmEZyCnfn7YCtbPaHOjPEt4gfuVtSPlfmXjmk3ebTonowTyo9wImHBdyO13Vi4vYJConoaAz7V8PHwQ5TqVvl/rW2+gkXM0oP/CNynQZ0fr6MUvCFxlw5Utr1YLgrv/WEDkySb7bkHi1W0oRvl3XjY8rs9cZ6/Do9zBJJM2h7D5V3diXWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Paf3i0CCvzyEZv+SSq04/dniSZ+gBnwsXktRpcdGQk=;
 b=IiMidpy5zw1jEcd0vZM0vSP3xvNfrGGzZkgjglRnAV7qwfZSX9shh/zzkrdifa01ldXlfcWOrzKJ/NTF+sgBw/cxJItrWhA5rUQBRyo2hPtLNH1y5ZF4LfSFAg9nPfs6MI/ZkJuJzGuwtS+84ZhSXxgyVfaXH4dgHLC1B/orvJh3CckwJAnQKlV6wRaeqsCzseB0aEHKhfMq1NP75NervfNe6xq7VqShHKNK/AzX/OkrH5I7hNitqGYo3aDrmsPANSV5yjNwiam3feYPbcZT34wxtUoiDa27va6OkwKlD6pDwjXyrp1tBCklhMZ/ZopUhUeM1/2wEJtqO5E6TEUWqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Paf3i0CCvzyEZv+SSq04/dniSZ+gBnwsXktRpcdGQk=;
 b=YLFXS831oG0z7/a72nDzt5klEEpn9d4ZElenNgDmZCthfgxieJEtfXmlInDbgcc40sTu8rPCF9ibwoYaftVheT1ClReGdjf49+zMmJ+zQf/1PPxOBHn72AGB6i+zHqQBXAI1zCGMMdkkaGnagu8rQOTl+vt8rm4ayaxxOAQMW6i8Z3T5KUZIkEPoQvh6obVVrJIt/oKex9gonB74wlG3En5kabbYyXodaTeKkxhqW8gfULVm6cX8q9t6VXJdfEVOe4LUw/MoybM1gdzEMV9vu1fmc+YDzEQubIWh903D0niiKZASIh7LXVeNVx9rqq627hJgtNQ1SiXTIaWxD066zA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AS8PR04MB8449.eurprd04.prod.outlook.com (2603:10a6:20b:407::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 10:16:40 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 10:16:40 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Tue, 11 Mar 2025 21:09:34 +0530
Subject: [PATCH v13 3/5] arm64: dts: imx8ulp-evk: add nxp secure enclave
 firmware
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-imx-se-if-v13-3-9cc6d8fd6d1c@nxp.com>
References: <20250311-imx-se-if-v13-0-9cc6d8fd6d1c@nxp.com>
In-Reply-To: <20250311-imx-se-if-v13-0-9cc6d8fd6d1c@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741707617; l=2642;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=sOFx0xbXmNFZvjYpxD//JvG44y/td49y3OV4dSFJBrI=;
 b=ZBzcL5+p7ieef/EIEpZZ4XaUnCjA9LECu0gAkUVubGQ718jqRFxDzr4gmmWpu7jSP9EZqesZT
 5TSRVsVQIOIB4TEILWp64eVM72MsaIWqilqdRL+HphznkfhQoq+Yywv
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SG2PR02CA0094.apcprd02.prod.outlook.com
 (2603:1096:4:90::34) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|AS8PR04MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: ae4d6aac-5dc8-46db-fbeb-08dd6085d0b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVFYa0ZoRHRTSVdRUzRKR2tET0RUKzByUXNRRnE1VHB3VmE4WGFmbVpKYmR6?=
 =?utf-8?B?YkRFN3JGcFYyREhwZHF4aHhWdnUxc2lwclZkeVg1VTRVZ0gyWXV1bFBhUUdn?=
 =?utf-8?B?Zk93UUF1VDhFb2FRQ2dqVE5SMUpZT2RGMW1yTlhobWpCSk1ycUlYQzU5cU9G?=
 =?utf-8?B?T1hlS0J0VnNIaUpyQjdOMWRoQnpoM25qdnFTdzBIYk9yOG1naVkydXBKd0Nm?=
 =?utf-8?B?MGNiM0l0L1dlS0h5TFE1alVmclhRU0R0TWNEY240SU83OEM5STFZb0ZSUHhO?=
 =?utf-8?B?L3dCSytNUStwUzJPZWVPNklqdmg2Z2o1M0hQMHJ4cytIMmZPSUdhM3Y3aEJW?=
 =?utf-8?B?KzdaNTB2UGl5Q0RYMGJ1TmZLMytHZlJRcnAyN1EzNC9udEJES3l4QUZlamMz?=
 =?utf-8?B?akQwSHRtUFdGbEVyeVdwSWZLdlBxMktGNzhVbzlaRTJEckRkMFFQUXVEWUZU?=
 =?utf-8?B?d3VzU2dKYitwRWlmN1pLdlc1REdKamIwbnhlNFIwZVlURjN4aGNac2ZoUzlO?=
 =?utf-8?B?UkZ2NS9sdVlaaEducWFQQk15U2hUbGxFbVU2MkJvNDVXbDVNc2lXbDkra2Vn?=
 =?utf-8?B?RDdnRnVXbXZEbUVjRk03RWxJSWlHemFTUUhIOXVwd2VqLzZPYVVBdlhVNGt1?=
 =?utf-8?B?aEVVRk1ndExubURLbXpwZG5uR2dmQjMvZnI2WUcyRCtjZVZ3c1BUUWt3S1J2?=
 =?utf-8?B?NzBxVEJtNEVkRThxRi9rem5aVlNZN1k5UXZWOXNYL1RkQjlEODZCUDdiTWxj?=
 =?utf-8?B?V3J1TVhFL1VMK1VSN25hYjZWY3dkTDBmeVZxMTExb0NPMllwbjUrclVhOEVz?=
 =?utf-8?B?ekY0Z2psZVhrbGhnUmVKcDhkU042b3VFWUVjK05EOUc2SmZQWm9mV1k3QVls?=
 =?utf-8?B?cE9DcXBpYTVZaXFnZk11V0lMUm1IY0RYVXdPbWpSRW9YOXBpbnMzMlI0NHpK?=
 =?utf-8?B?Q3kzZVpQbTR0UGZsNXNnMS9vVW9YYTBZSmFaTTZ5WUViaDRjbXlMUG41QTVW?=
 =?utf-8?B?bWhSOHoya2JkM3dDaTd1UiswZjdMY1o5WGhXTkViZ1lQd0VhSzUzWUtvcVFm?=
 =?utf-8?B?T1ZKcEwvOUprbEJvM3cvd1dFTjJUTDhQRkU3dDFUZTVGK3ZKdm9GcmdzOE40?=
 =?utf-8?B?RmxRdDRkaWRZMitKNS85aDZEcEwrc01Zd3NpbUYrN0dCY1F5Y0VxM2s0alRU?=
 =?utf-8?B?N3FYOWpFNHJyMVR1cUFNNXphVll1T2pjL2FkbUNQUFg4WDlmVEppV2QzNnA3?=
 =?utf-8?B?dVBsUVk5S28zVVBodnZ6Y0pmdHgzUndtcDNYblVkRS9HUk5XSHQvR09CeDdW?=
 =?utf-8?B?QkpRNmtkUTdKSXJUWG9YRnBpem1rdUxySXl3ZmxFZnFha3Q2YlV3eitrcmwz?=
 =?utf-8?B?MWJIWjhrd2cvZWpSbDBzL2NnTWZ5STZIMTBtekZiTW9zZkZRWGV3RkVMUXp0?=
 =?utf-8?B?bUpoMjlRL3Q5NlhQaXJwV1EwbnNpck8zbDNyK2wyWXpHdFVjTW44TEhEazVR?=
 =?utf-8?B?NmZDcndKVG9KNjFTQURpdFJtS3B6eGdDaUp1ellqK0VZVHBjY1I5NjJWYmtG?=
 =?utf-8?B?QnIzaWZUb0xBbSt1L2hDL0dmUkRtb2FuZHhOaEVTMVpScnY1cnFXY2ZIY0p2?=
 =?utf-8?B?bVB5c0szdGRWRjBvTEJ6RXVaL2pPL3BzSGZYSGpDMjFLVGhMZW05MmNxVEFO?=
 =?utf-8?B?ZTBScmdZWWpOS1JuYUl3RzcvMW5vMGtoaTEvdmN0V3djL1lJNjZSYkJVY1Vi?=
 =?utf-8?B?cVZJMk0waE9lbDNDdmRhTnEwQ0MrMUtMcVNFSllEVDJ4R3dXdWRnU1ZXZDU0?=
 =?utf-8?B?K1RoWjYxdVExcDY5RG84Y0NCNzd4ZUc3UWkzbU5mOW1oZ3FKbTQ0TGtxR3FW?=
 =?utf-8?B?ZC9DNzVobTRhdCs1c0IzVGR0a0hwa0RXanNnVkZQVkZlOVkxbmNicFJxbUg1?=
 =?utf-8?Q?6xUeuLb+e4cvibFk0Xfr4Spylz/X/8S6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWt4WDJsN3Y4MEFhc1owcFJNTTBEQ3RCSWZjczkxN29SLzZ6dnd5dDJFT1p4?=
 =?utf-8?B?eTVCMUt5bU5pQmFVNEc0Ui9iRmJzM1M5UVpGb1ZXMnJEMEJGRVBvN1Fqdm5C?=
 =?utf-8?B?MXNwY21DWm91bHVyOWZwNWVCTy9OOVhVV2dSQmltY0daQmF6SzdlcW1ENlRo?=
 =?utf-8?B?dWRoV0hFNDNwOFNSRDhRb1F4M0NxdnN5Z2czaXJRd2F4YlNxaDVITk4zUk1N?=
 =?utf-8?B?ZU04T1hDb0JjQmNMOG9OMjczcTJjMk9NcXBRTm1jWTc3ZHFDemt6Mkl5d1k2?=
 =?utf-8?B?bWpNdjZXTXBBK1NXUVhsNFVLcGRQVU1Mb05rTGJ2LzRFWlZiOVdlVHNFMFJF?=
 =?utf-8?B?TFNkaVhUZ3MrSDZVTnRoWGlHVmtsTTJtK3A4d2Q4WWVGOXZ0UkhzSG5sY2h0?=
 =?utf-8?B?VHRHdlR3ck8wMzBOZWEwa2F0bTgwcWgxbjlGZHlKRHptdzY0Q1FBZW5vUWkw?=
 =?utf-8?B?VlRBbkE3WS9rSEJuRThxN1FwZGJtU1NsRDZaa2VsTjZYSHlrdWR2RjJxUGJa?=
 =?utf-8?B?em1sc3VZYURrdlFnR1pBOTJiVzdtTWZ1Y216WmN3UWFwaE5VRkRPdHNJOVJX?=
 =?utf-8?B?d2RiUzBGWndkcDFNZ1lndE9PaDBWdEsrMWk0SCtkZ1VhS3lubldyaHVzRE4y?=
 =?utf-8?B?YzFJcmxwZDkrMlZGai9zU29KTnBVWFJtMi9JMWtOSm54Nk4wKytFaDJFNmhC?=
 =?utf-8?B?cUwwZGZ4TGNXTnVlcVdaYWpmYnd6dlp4bFJHSnplN2pQSm9xVThlT2NzUmx1?=
 =?utf-8?B?dTRTYmJMcTh6NUN4RFBybTNMdWUwMStvOHlwd3hrVTBIckpwWFdaU3F2dmxO?=
 =?utf-8?B?YS81eXZoRlF3MXhhMFUydE9ZcXdIZ0U3bjYxY2JOY0VMUndQaGd1MjJORDM0?=
 =?utf-8?B?NExFMEd2OWxPVDlzTW5rWlZtVVZ2Vm1QaHBXUWM4TC9sUmkyUE4wOTg2aXF3?=
 =?utf-8?B?cExsUjhEOGxOVnBPMnphOExRY094UXB6dzJGZ0YveXlKN3M3TWEwZ1luZ29i?=
 =?utf-8?B?RkNJdk4vK3BFV3BnL1hDK0RnWlZkS2o2eThhQ2ExbVhCZzUzUzQvWEtIbWF2?=
 =?utf-8?B?N0NtS3BSTXBXQ1UwL0lxazBlS29OTmw3NkdhREdxR2o2cTYrZUxKaDRkMnVP?=
 =?utf-8?B?b2lUY2JtRERJMEFXMWRYaHRHbjhTYVo3dFhjejdxUEk5NkhLVUNsWUxwMENp?=
 =?utf-8?B?Zi9iSzZCanBVZXM2eGF5eXNKaCs1TmF4dEVnVFozbGZXZE4ySXd3aHQxYXp0?=
 =?utf-8?B?TGMrMmtYYkRJRUV1UXNYc0JHL1p0czU3Q2JoTEZ6MGlzMHhoNnlydjY5OWg2?=
 =?utf-8?B?OFArWjBMVXVNcHYrdGZBN3JJV2lZT21iQURibzQxOTVoNkJnaHhHb0tZcmdR?=
 =?utf-8?B?dE5GL2hqTkcyTmhlWlBXZkErT0d6OGJEbEg2ZjZaRDFtTFRLVEJGUGJkN3Vi?=
 =?utf-8?B?MDZzUzMveWdPQ2xWNkdyUnpIcmhNSlB0c3ByT0gyMytvZVhmMlNsdUVvSStn?=
 =?utf-8?B?VkpNc0MvNDZyY0pSeDFDOFkxdDJTbHBkYmxocHFJdHRGZHYvaGhFUENJZlNP?=
 =?utf-8?B?TzJiZklDYkI4dlpWdDI2NHlrRnM3TmhaVzU2b2VxZzFTYnczKzVCbExxTElO?=
 =?utf-8?B?YXovUkpTTmwyVFE0bHQwaDk1eDgrMHFHUmJaQTgwWG1raFZ3TGcvd3lkSzhm?=
 =?utf-8?B?YzhLUUl1bk1tSnNPR2RBRjVrMDVQekQxa1poQVVaRzc1L1RqU3BLZEY3RmN1?=
 =?utf-8?B?TE9zUVo3MGRsbk53WHVkNDRqbTNRTGMyZFVFd0lhWjlveFYvV3Vmak12bU5E?=
 =?utf-8?B?RVV0eCtVZ0FianBtRVVEUWtOTjRTNlQ3VHJ2UENBbVJ1SWFIZ3ZHOVNRUFIz?=
 =?utf-8?B?SnZ2R3ZOU09Zdy9DSEJXdGxvTkdCLy9rdjd3QlBkbkVmR2JYRnhDK2ZLK2xk?=
 =?utf-8?B?TnlqY2V2Rm1nQ0RqMXozN2VNdVVybXN0c1dvVVI5YVNHaGZRSGVIeFFVNy9x?=
 =?utf-8?B?SStDSHNCemZrRWZYOHdKU25pRTdTVkd2NWEvZzI5Z2lvYlNySm42dktzdnhN?=
 =?utf-8?B?bG5UWUtkaVF4OEZQWkhNOURiU1BzRTBBaVlGMWtDRU1UeWErb3BZL2hZVW04?=
 =?utf-8?Q?sG6PnfMOg/mTknFJJZkRGeFPf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4d6aac-5dc8-46db-fbeb-08dd6085d0b9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 10:16:40.6543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +EF8Py5pXd3B0RUvz34aQFrm8ICe7aC4CfaHVoYhd0y5FAG9TFCxD6n4+F9hzWXuxhFWbntYFeCU5P4UDkar0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8449

Add support for NXP secure enclave called EdgeLock Enclave
firmware (se-fw) for imx8ulp-evk.

EdgeLock Enclave has a hardware limitation of restricted access to DDR
address: 0x80000000 to 0xAFFFFFFF, so reserve 1MB of DDR memory region
from 0x80000000.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 17 ++++++++++++++++-
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    | 13 +++++++++++--
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index 290a49bea2f7..a25d71bf2c26 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright 2021 NXP
+ * Copyright 2021, 2025 NXP
  */
 
 /dts-v1/;
@@ -24,6 +24,17 @@ memory@80000000 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0 0x80000000>;
 	};
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ele_reserved: ele-reserved@90000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x90000000 0 0x100000>;
+			no-map;
+		};
+	};
 
 	reserved-memory {
 		#address-cells = <2>;
@@ -259,6 +270,10 @@ &usdhc0 {
 	status = "okay";
 };
 
+&hsm0 {
+	memory-region = <&ele_reserved>;
+};
+
 &fec {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&pinctrl_enet>;
diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 2562a35286c2..c79a5de227b3 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright 2021 NXP
+ * Copyright 2021, 2025 NXP
  */
 
 #include <dt-bindings/clock/imx8ulp-clock.h>
@@ -154,7 +154,7 @@ sosc: clock-sosc {
 		#clock-cells = <0>;
 	};
 
-	sram@2201f000 {
+	sram0: sram@2201f000 {
 		compatible = "mmio-sram";
 		reg = <0x0 0x2201f000 0x0 0x1000>;
 
@@ -169,6 +169,8 @@ scmi_buf: scmi-sram-section@0 {
 	};
 
 	firmware {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		scmi {
 			compatible = "arm,scmi-smc";
 			arm,smc-id = <0xc20000fe>;
@@ -186,6 +188,13 @@ scmi_sensor: protocol@15 {
 				#thermal-sensor-cells = <1>;
 			};
 		};
+
+		hsm0: secure-enclave {
+			 compatible = "fsl,imx8ulp-se-ele-hsm";
+			 mbox-names = "tx", "rx";
+			 mboxes = <&s4muap 0 0>, <&s4muap 1 0>;
+			 sram = <&sram0>;
+		 };
 	};
 
 	cm33: remoteproc-cm33 {

-- 
2.43.0


