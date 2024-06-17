Return-Path: <linux-kernel+bounces-216647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E3F90A298
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 04:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCECB1F219E3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 02:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F14C54670;
	Mon, 17 Jun 2024 02:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GwIkJ/ro"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2051.outbound.protection.outlook.com [40.107.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD6E79D3;
	Mon, 17 Jun 2024 02:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718592462; cv=fail; b=VdLYRma/hVpVYDmFvH2aGkPG+lWbdp4/BctD71LspCrvELnfrlh7tFXheSd2HQzsBbe7tAA3MWcAIYqHqVqHYX0pR/75sUKODGDM6uUy+dHP1yezwkrbqpHzB0Md8YUnBSG2mQXqmQ5fuxafnGn44bFTWHCsi3CiWJoS9EpKhBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718592462; c=relaxed/simple;
	bh=9ur+DSiW50p86S3zNaeP35YXcH/1bxOTq7J8TJENAco=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=uanvzPNUIwKpcy06cddR1w1YdR1TsTniAKTJdeHX6C+3H/bkD2DTMlgp4YeQFyOCYQ/PNdOCC7++8ffXCRmmRhbVIbAPXLraIPbAmifQdTaxJeNT06DYoVNFMN2CX3QWL/KKOLAMY7vSNeAJjQlwDePUsDCA+VVtA1eIdDMwjmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GwIkJ/ro; arc=fail smtp.client-ip=40.107.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Um3ikOHguLuaQF/CoZwcso7KU2K3sN28DslIfLE0/FkHViMgFyd4HSLkeaXk1YZEnYBt46SWHvSCMelz2JKvijeVqE3riI0m6UoQTy8lyxBS8PZ8qTAWenUexRZD/HsbFLuPcScTKG+Rr9B2ZETP/NP9BNWzEtchrEsVJ44vG3R9NPfNqHqLX35nQyV85wl2efhI4lqtF6TW4tms+1tvvKuow3beAll8l75/65RdpiaxxL+Mzca2qubQSfYk6P95m65r0Pm4R6XMoJuF50yyiFwSrPQLicy5bYLk3gv29eMhQ031nJ45pTNvMiXTGt8iaBTheB+XzY9eWwO4KPpnEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15sYSbVprIcl8HsZDBbInkhDvPRCx18n1dUjhBKUFyc=;
 b=G23z88n/JDP/HxaL9ubHEfNJsC9sUvPc3Oakv1/5FHfYsCcOC9vD2u1KPJ8y3HRdxhLKjthouihjDW5KqxV3e77VOKj19btj9ixZUKVbpj187gzk7eWVy5Q2acno8GBQtcZwkQblc2U/cgWB7/C3aJm+scsA8geOd6Yp3vCv5cBIQiGTaARcCPXrBhoJ49oSoWuVPwxwLhk9Uiq/51hLlg9bf8kSTeb1kYNYTgux/9uAsnZ33GsyXNNr6BTNqwC57OBtGZq5GGudoC/ncZyMwvIttTO3UioLRlNiSSycuL/nK64MsJLeTHfZQtS0fnupSWt2t112+OGCt7ND/Kf1Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15sYSbVprIcl8HsZDBbInkhDvPRCx18n1dUjhBKUFyc=;
 b=GwIkJ/roo4Pk0tfdgz+h/6fTYlcvuKcVvXRafKYBPctdEK8IAGmr7PTKtLn2+Flrq1lK5g7FwZr+wE0dC03YLmbnJU+1eQBM4X2oESW2jF+WE+uK3VZg9GJeiOgSDkMEWAiOk+OYq4ArALQ6Drf8emg+glvIIGIcZUn8Fmk9Ev0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by AS4PR04MB9482.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 02:47:36 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 02:47:36 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v7 0/3] arm64: dts: add i.MX95 and EVK board
Date: Mon, 17 Jun 2024 10:56:34 +0800
Message-Id: <20240617-imx95-dts-v3-v7-0-488b52e10862@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOKlb2YC/3XNTQrDIBCG4asU17WIZjR21XuULqqOjYv8oCGkh
 Ny9Jpu0QsHNN/C8LiRhDJjI9bSQiFNIoe/yUOcTsc2zeyENLm/CGa9YxWsa2lkDdWOik6AGEbR
 nCKANyWSI6MO85+6PvJuQxj6+9/oktuufUH6MKglCg69ro/2tm4eL7VuyZabqoMBEQatMQYBzl
 huHSvxS+KayoLBRtNpobb3hxa/yoJJBQWWm3CJXgI5hzQ66rusH2mdoi1cBAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Peng Fan <peng.fan@nxp.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718593010; l=3698;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=9ur+DSiW50p86S3zNaeP35YXcH/1bxOTq7J8TJENAco=;
 b=sywMkIyqw969Vvb/T9UsPoJK7CSynDBsdNOtjgYyoI6ZXKzE2k+nc7GYOU1zxaXm/Pmx4kmwp
 t59bnWy4qQVCxqJaHNV2lekY4mSb+uIzlkUwGHAL1VhYsTHhDukNuw2
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:3:17::35) To AM6PR04MB5941.eurprd04.prod.outlook.com
 (2603:10a6:20b:9e::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|AS4PR04MB9482:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e6b6efd-3df6-4997-ab91-08dc8e77d836
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|52116011|7416011|376011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RW5vNHdKR3lQYy9yN2ptWEdUcE92K25WWG5OSGhxN1VacEI0UmtMRktQQURt?=
 =?utf-8?B?a296T0ZuTTgxSks1RnRkMGZnUENuYkI1ZWg2N2VVcUZhS3FrT0JoSkkvVklL?=
 =?utf-8?B?c0lmRW56QnpkbHg5KzN1WXZUcUhMWHUybkJyVXBCblV2UFAxNFhUb2dGL1Q0?=
 =?utf-8?B?M3hITmh0bG9aRHJDYU9iNmpCektpVFZXZFlVZFdGTGpRU1NJMDVMWk41Y3F3?=
 =?utf-8?B?NW13UEhVWVZjeHNwWHlnLzJyenIxZ0JtNWpBWmkvN1k4WllhWWdyanU0MlVL?=
 =?utf-8?B?WVhodFB6SUh4YWw0THlSNFVML09KSDFYUGdlMGhJc2hnOEFJdkU4YUM0TkJK?=
 =?utf-8?B?K1A4STRQOUhWUkVnN0xZd2FodW1ZWUhnUFJiM2svNnlyYlVyRHgvQUR6RGtu?=
 =?utf-8?B?ZlhkSURNY2R4WXZHOEdSVDg5ZVVQOWtLWGYwNHhZR2dCYmd5cTJMbFhxNHZq?=
 =?utf-8?B?TU5yNnc0Wjk1bnRMSTlZSFhYbTIxS24zRzQ5TkYvOHZYdVZub01hT21vL0hR?=
 =?utf-8?B?WjZ3cHdTUmtWMU1SVXNUNnpUV2RiNm43R0FnaU9yNE1ZNER6dEdCdE4rK1hB?=
 =?utf-8?B?Q1d6K3YvdmV4QktPNFZGQmZ3aE1lRXBGZmxsUm1HQjJHVEVWSFRoYlNQRlRz?=
 =?utf-8?B?aUhaMTRncUdhS2t2cFBsTUpUTkNxd05yVFJxSUxIYTQ0RDc0WjluZTVGZmRI?=
 =?utf-8?B?TERMMW1CM0RCaUptend2N0gzYzhhQTFCeThiOHQrK25FQzJveWYzOTBabkNL?=
 =?utf-8?B?aDN3dTVpMzVzalJUQStFUHNlNi9NUFAvaEVMUXFmYmtNS2RxbDhIcXdVMkNQ?=
 =?utf-8?B?SXBCdksvcTR5UXlCSkFSSkxjanRSMDZZSThVempjKzg4TkhYOUgrbGx6bTlM?=
 =?utf-8?B?NytrdzFmbGJIUklyY2hlM2h2NlJzRmE5MG5tdXRSamFXandjUy8wdXpNYW4y?=
 =?utf-8?B?L1dHRjBtQm9MQzFFUGxrMDUveVpDM21ZY1R5SG5ucUo1cDlYSEtKbjJweTJi?=
 =?utf-8?B?YTk3ODNLZHhlbVVxRFJZa0tLd1dBdDZ1R0ZlMm9WS1VtSm1iTmRyaU1BaTJV?=
 =?utf-8?B?MHUwUk9URjlWQm5HaEVVMnR5aTJLNmlVOEozN0ttdThlT1d1YkZkZHBHdzFX?=
 =?utf-8?B?b3poZEM1K2ZHNXB2bTBidFM2ZkxQd0RJRFBpVFgxeHlCMDI3WmdDRUZodGxG?=
 =?utf-8?B?am9ZM2ZDNStMazQ2S2RJczgwdmtwUUVZcVpQV1hSRHhqVDNxMlY3RFJhZytS?=
 =?utf-8?B?a2oyaGVnZHJ3QmhYZnpEaHJ2YXhvRkpqTVNOclBWR0xnY3IzakdHVUF3OTJL?=
 =?utf-8?B?UjJ2cFk5ZEg2dnFRbmozcTBaV2dlS2lSNFFPMHBCU2NjZnYydGptckdUdlh2?=
 =?utf-8?B?ZUkvS3J6THpSREE2QjNuNkMveVlUK2tYakNsaitjbTZxTXloalVrZFd2dStC?=
 =?utf-8?B?NDUvS2htR3djLzFSc0F3RXRuSDdUYXBRV0NkeWs3RHp6d2FDUFBhYlk1L3BJ?=
 =?utf-8?B?YldhK1FzWFNhSVNkbGpmVUM2NVJPeU8rN0plNHVkT1VTVDU3c3dUYy9vNG5D?=
 =?utf-8?B?elFXcGp3QVVaYkJXa0w1dk1YTmZvdWVFNTJRSy9NZE5KSC9VdlFLRU16SEZP?=
 =?utf-8?B?TGZ1RFRUbWE1MGxWZ1dSek1wRjBlVW1RdGNaNmhFWEROU3ZlSUlXWFgxSG5V?=
 =?utf-8?B?eVRSV3dFUHZKUHhRaDE0Qm4yRVRqMU8walNzT3p1Q1VYT3o5YmpZMng0QlFN?=
 =?utf-8?Q?fdC6y9Sy6RwRW+eVB3F+yN/Kwwn6O/ZM3aPq5ZF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(52116011)(7416011)(376011)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amFmWW1WVXVTbUUrWXNwdy8rU1dVcFRpYkF6Z3pRUHBYWU1iWEFxU3J4UWM4?=
 =?utf-8?B?TUtnTFNGK0dsemZTS0ZkZzNUVVR4ZnNwZDlvQ2xYR0NsMDA5U1ZpYlpFRmtN?=
 =?utf-8?B?MElHTjdQaVFIRzFDTS9EWHd5bi9qcEl6cXRhckJPOXJMSFZTMjB1VlNFUWZD?=
 =?utf-8?B?VWtxTU5aeXlteFBPYWR4T1hnVytESWpyeGV3NENBRzFQclRlb1pQVjlleThI?=
 =?utf-8?B?cUIzbHlWek1nekIwK0c3TVpRZDQwSDhudDllYWVRbXdDL1V6OUJwM1M1TzFz?=
 =?utf-8?B?RVVsVGJ1QWJSWU8ySml1YjlyTlRvVXZ6TVUrNEhjTytKd0plVGRXZEp1TUlH?=
 =?utf-8?B?UlM1VUc3bzk1ZGtGMjk2MjZXbU1GUEwxRzFQbU10ZFI4TnZSSFJYKzcrbnBU?=
 =?utf-8?B?cUF1NUhac09VSlkzTUtNOTA0MEVMNXBaZWxmaERpajdlQ2NHTlh0ZG5GbFQ0?=
 =?utf-8?B?ZkFtY3M2N3Q4dXorSGUvNXh1TndPajdyZzBySEh2eHZIY0RSYWtuY2lpOGk2?=
 =?utf-8?B?dkdLYjE0czBjZEl0QzBvSExkbFp2YjM2YmZRSTNyMEpGQVFwYlR2Sk00WXVt?=
 =?utf-8?B?c3NoUDBnbTNWbERnN3FYZlY4cEJBSTNxMnZFQVdLb3psMXpzcHVjT1BMOE03?=
 =?utf-8?B?cFVESjJGaGovVWFpZjRXYjFqbnl2NzlZcGhENUNqam5pZFlTMXp6WHpXSG9M?=
 =?utf-8?B?VlJEdXJIVi9PYXNKTmhJT0JFTHdwbW1mbTl2dUU0YlFVWmhSQUFqY0s4MzNi?=
 =?utf-8?B?MVVhK1gyTEtDaEt0cTF2WklNNGowQmJHZFcyT0RTZUg1NjlOM2J5TUJkVUty?=
 =?utf-8?B?QldsRXFSNm5LMmNNUDl0YmI0YVhLK1hXN2wzSGdnMjFZUnB5K3d4UVFZNzVG?=
 =?utf-8?B?MVR3WTQ5U3lramNtd1pxTWVzUnorczcwWHRhTlNkWXlGMCtIVU55cnpJZEpv?=
 =?utf-8?B?dkdEVllrUDBsbDdkVWJFajRDUSttNjc5bFVEZm1RdnM5aUliRHpJYSs0c0l2?=
 =?utf-8?B?ck5ZZ3kyMTVqeEk2RVVQQzkrWUlPalNNdEF3RW9BaVV0Mkt4KzBydmVWNjBN?=
 =?utf-8?B?QzZrMEZyeWlvdEY0NXZyZG1OanBnaUV5ME5kd0gwQ1JBWEoxNktaM1Awem5U?=
 =?utf-8?B?VllhOGdMcXNaSEZhck9NRW93Z2U3QisrcnNRM25oZFdqa0JLUUlPcUsreGxP?=
 =?utf-8?B?b2xuL0luTkZkVjBpdGF0UlBERVN2cnVDNXlpa0tDZG85eEpJS0FnNFNvZCtY?=
 =?utf-8?B?SlRaZFQyaElOYWsybUpXeDBydDlHY0VGTFFOekthUDF3Szd4UWpGc3ZmUyt5?=
 =?utf-8?B?VitHeEZxS2ZweVZjZnVVOFhUaGtDalc2c1VDZ2puOXc0WEJNMk9wME4zUG5x?=
 =?utf-8?B?eHRhKzlmdVc0cTA1QXBzQ0tJRGRDd2xIbDR3WVljbkZibDRuQkxtS1Rmb3VD?=
 =?utf-8?B?UVVtS3NSQ0ZiTHVvYS9hUFM3RXVPeG5MeHBtMUdSa05pU2UwNUp3Zmx2Sk42?=
 =?utf-8?B?Y3YwSnRRNkJIVkcwU1pBWmgvV1U3Q1hISG03bHNzL0tYeG5qaStRRkNiVGFl?=
 =?utf-8?B?cnVNOW1RcXc1V25qTXpHemxLVW01djJ5cWRGZDk0bDM4aVltcG54Z3BJTTVL?=
 =?utf-8?B?R21VbXU0cFVrc1d6K3JIblg4bjJReU5pZ1NKYVRDM2k4MS9WVFEwQUVSL29N?=
 =?utf-8?B?U3VZZyszOUQ0YVFES1kvejN2bUpPcVV6RWpkWmtOdTc0VnhoUG01a3ZPN1Vn?=
 =?utf-8?B?TUlvdVVINFJya2tRUk16NUR4a1dPUTh4dnB2anRFNDl0YVlMazcrS1N2MFJ3?=
 =?utf-8?B?VDNCNkJ1bnZDVVJmVysrOEd4Qm5QUjJrZmZMOWIxZXR2RGFIbHcxWmhaYVl0?=
 =?utf-8?B?QnkrWVlCbmlTeUlQZi9mZjh3NzlBaWxmMFJES25TR0lOZm03bG1EdVN5d25u?=
 =?utf-8?B?QWtuUnFDdlJ5SnFOOUJuTGlWYVNsZ3ZJWWlMY1pxTHplRFYzQ1JraUdNNXpI?=
 =?utf-8?B?WkVPYnNJK3NxT3FuaDU2VDJ6OU02bnNWcTlzTjc0KzZhYVdicTl0SzFMRW53?=
 =?utf-8?B?RThleHpZb1RMRmFTbWFxa2VkUlE2N3NnNjFucDBod2dGZS9ueldrQW96dlh3?=
 =?utf-8?Q?YetmJRm9g7I+L9HbaPjjhLQJM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6b6efd-3df6-4997-ab91-08dc8e77d836
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 02:47:36.1020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pl/2xXJfVTvDXjYcHKVOwkBUl4lV8E9srpES39Yu0TeXNS61Or2hj9NsM5gRlfVn3GAfeOKlXkQgS/EbiLMjMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9482

Add a minimal i.MX95 dtsi and EVK board dts.
i.MX95 has a M33 running SCMI firmware that supports
pinctrl/power/perf/clock and etc.

imx95-pinfunc.h will trigger checkpatch error, that is expected and same
as other i.MX platforms.

[1] has been merge to https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=for-next

In v6, I added back a dependency on pinctrl, because [1] has got A-b/R-b
from Maintainers, so it would be soon got merged.

There will be dtbs_check error before [1] got landed. With [1] merged,
there will be no dtbs_check error.

[1] https://lore.kernel.org/all/20240521-pinctrl-scmi-imx95-v1-0-9a1175d735fd@nxp.com/

This patchset is just a minimal support for i.MX95. After this patchset
is accepted, a following patchset will include more nodes and features.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v7:
- Address Shawn's comment:
  __DT_BINDINGS_IMX95_CLOCK_H ->__IMX95_CLOCK_H
  Drop cpuidle because it is not stable as of now
  clock node name start with clock-xx
  sram unit address match reg
  enable-active-high right after line of gpio
- Address Amit's comments 0x7F000000 -> 0x7f000000
- Rebase to Linux-next next-20240613
- Link to v6: https://lore.kernel.org/r/20240605-imx95-dts-v3-v6-0-2ce275ed0e80@nxp.com

Changes in v6:
- Add pinctrl nodes and pin settings
- Add imx95-pinfunc.h
- Drop fsl,cd-gpio-disable-wakeup which is downstream property
- Per i.MX M33 SCMI firmware, drop unused PERF entries in imx95-power.h
- Rebased to next-20240604
- Link to v5: https://lore.kernel.org/r/20240506-imx95-dts-v3-v5-0-5ec9b99cfb2f@nxp.com

Changes in v5:
- Drop unused regulator and alias for now.
- Fix CHECK_DTB warning.
- Link to v4: https://lore.kernel.org/r/20240503-imx95-dts-v3-v4-0-535ddc2bde73@nxp.com

Changes in v4:
- Sort nodes by address
- Drop coresight nodes
- Align clock rates for SDHC1-3
- Drop wdog3 board specific property
- Link to v3: https://lore.kernel.org/r/20240428-imx95-dts-v3-v3-0-765395f88b9f@nxp.com

Changes in v3:
- Drop irqsteer node because binding not accepted
- Pass dtbs_check
- Link to v2: https://lore.kernel.org/r/20240226-imx95-dts-v2-0-00e36637b07e@nxp.com

Changes in v2:
- Addressed Rob and Krzysztof's comments, and fix dts_check issue
  To pass the dtbs_check, need apply:
  https://lore.kernel.org/all/20240226070910.3379108-1-peng.fan@oss.nxp.com/
  https://lore.kernel.org/all/20240226130243.3820915-1-peng.fan@oss.nxp.com/
  https://lore.kernel.org/all/20240226130516.3821803-1-peng.fan@oss.nxp.com/
  https://lore.kernel.org/all/20240226130826.3824251-1-peng.fan@oss.nxp.com/
  https://lore.kernel.org/all/20240219-imx-mailbox-v8-1-75535a87794e@nxp.com/

- Link to v1: https://lore.kernel.org/r/20240218-imx95-dts-v1-0-2959f89f2018@nxp.com

---
Peng Fan (3):
      dt-bindings: arm: fsl: add i.MX95 19x19 EVK board
      arm64: dts: freescale: add i.MX95 basic dtsi
      arm64: dts: freescale: add i.MX95 19x19 EVK minimal board dts

 Documentation/devicetree/bindings/arm/fsl.yaml    |    6 +
 arch/arm64/boot/dts/freescale/Makefile            |    1 +
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts |  200 ++++
 arch/arm64/boot/dts/freescale/imx95-clock.h       |  187 ++++
 arch/arm64/boot/dts/freescale/imx95-pinfunc.h     |  865 +++++++++++++++++
 arch/arm64/boot/dts/freescale/imx95-power.h       |   47 +
 arch/arm64/boot/dts/freescale/imx95.dtsi          | 1042 +++++++++++++++++++++
 7 files changed, 2348 insertions(+)
---
base-commit: 6906a84c482f098d31486df8dc98cead21cce2d0
change-id: 20240428-imx95-dts-v3-bee59f0e559b

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


