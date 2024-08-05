Return-Path: <linux-kernel+bounces-274950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97075947EA4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B6D2870F0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23D315B12C;
	Mon,  5 Aug 2024 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LYkQImDU"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FBB158DCC;
	Mon,  5 Aug 2024 15:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722873023; cv=fail; b=cLOCjdS5hlrqm35i4bMTJY5xzmf0dGkGC47UIAtkXUMtS2typM+K92c5grZMeVaOiO0dirVg4AT5hPdxypa2fs0UjN44C20EgJ5ds2BZzbTHG+9qK1hSeMno5F0aJmpGLKD4UnKcQBuU0R9mZj6ESOalEi4Yp6pg/jdVpipX/Io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722873023; c=relaxed/simple;
	bh=i/EFcpn+lqhxtfkkQ0twO8CaAAgGFPibLGq7WaYvBvU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tn4I+/0h8rHfZnTe2xHVe6hIHg//bUogtgsJo2LcOp8YwJIYZcEaYSP6u++5JwcRUcoLSbjfp5Uha0p3xoVLJ2P9lSkQJdSPZIZNqnHFcVHPLlWvlC7cODh5+UQ8YIjWfm3/PULiNInNdlIqwbDefqns8rZ05BD92qe5jSN0ShU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LYkQImDU; arc=fail smtp.client-ip=40.107.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJPcIQibtPp2XhfjAn6DZSo/K9t668NCGktU6ghPt3HPPTK1ijChjWEoB5cuBveblRdJtUAL0eYPpSiMjtHUHRNLLEAiT1Kah50Uu60mJy/+ZSbgfdhW6ntsYLkFH1kyHD7E2Sm6yF48zA2ZW+CCe1z6WsGySxUb5u8hyExKSZJI0CzqlhTjuvq1XWMwkIj9TCOMdElfEibGvOC5K+mj4N2lOu7COF3yStY0z4OLI1KZavN0CVWCliFvUt+eAyTiq7w9YTnbCxDemfSsnhDgivHRRMziY6po3QP2JJY1p3sG3mKbCJN/pHI6PAyLflIcEuBMTZyJ4wVTi5J6d4KxYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjeagDySRo8S1n1lKq1YY/11gyFvRi/0EJYJdNAnE5Q=;
 b=g0J3RdoTmIRdviMaZAl3MBiArqhEJmWr7VAUFsfn1pONDf/bk73x/nMYMA5PEoM6XDBn4Q7zDpPoauK1y9RZ5bDQDPxP/9D5uS72/bdISyYmxOJhqTlmy7+AnvqkpnLTblx+V8eHbFyImZEggVkGnlwjxFwWG3LkpxtONiXhh7DT/eGiY3OtOzfCprWClUfS/nrs5byh+xOxOKkTh+bLdiPfjvqupqMaeQZqIDrWhT4gnKBf3A/lZfI8iuM/itVVNsrqNb0AjfSSdt1Lmh4yyAfnEQdmgXmtpTe8JxbNa2+lA2XEmUC79OMCvr6OlLDbgaGLcKppkLsJHrO62RIWRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjeagDySRo8S1n1lKq1YY/11gyFvRi/0EJYJdNAnE5Q=;
 b=LYkQImDUK+AerGXBRxcSCOY9Pi3fNR9sOG1ImnrR5lKdko+9y0+euUomvJONUHA+mSG5k23eZ94xBS2owOjF76h7b0exF7iBDh6UR+rkiKw92p7t5r0goWgJaeMoUjfJZvYGCASaD2sYDcaLbnw9BJhuVRtFZnRnjwk6Vl57YPhdsNIvDnmJYeHavBaCkVZQ20b9kgvRCw2SEBJ6lFUSqxLV8rW6IjBfDlUY8gtSyKX02UgEDoNG3mrE30d9Aj+u2hdAdRceCAX8OYdfSwFxzHCnJMnfeRvRo1N/cpnmk7DyO2W5+Glb++IgYDtdsmtwWVqHZ+OLwnLtVTNYV5JXbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10464.eurprd04.prod.outlook.com (2603:10a6:800:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 15:50:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 15:50:17 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 05 Aug 2024 11:49:44 -0400
Subject: [PATCH 2/9] arm64: dts: fsl-ls1028a: remove undocumented
 'little-endian' for dspi node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-fsl_dts_warning-v1-2-055653dd5c96@nxp.com>
References: <20240805-fsl_dts_warning-v1-0-055653dd5c96@nxp.com>
In-Reply-To: <20240805-fsl_dts_warning-v1-0-055653dd5c96@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722873010; l=1397;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=i/EFcpn+lqhxtfkkQ0twO8CaAAgGFPibLGq7WaYvBvU=;
 b=z2VvEJvTGLXLRPCCzO/7T612DZpQ/ShUbSa6S2txx6dvwrhO4Nur/D9En/dSO81NVt/OUlCGU
 AU86CJCYJpECHj9euUWKx7tI2iicLPxwHnYg4X0CDic3muLiWEIb+0r
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR13CA0136.namprd13.prod.outlook.com
 (2603:10b6:806:27::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10464:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e0434e2-598b-439e-799a-08dcb5664d9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUpyOUE2SWFrZ1F2NndwMGI4M0xBM3hjcUx4OCtSUnVtME5kbkFJMm1jTnIz?=
 =?utf-8?B?QVUrcGdHVFNHV3VmYnVlRzg3Q3l1eHJ5UUJBeG5RelR2SGJ6clU5WkQ2cFI1?=
 =?utf-8?B?Z3I0MzlpZmNLZm13c0dDNWd0VGJnMTNhZ2N3dlN6Ky9QMGxXT3VsL3l3WTg3?=
 =?utf-8?B?aElzTEo0dnBDMGJxNlpjS1NsaXV1djFmUk9pZlFPL3NSUWMvK3dCZ1NPQ2VP?=
 =?utf-8?B?TlQvdDBXZDNFUy9jVmVZOTNyOWdHTFY5elZhV2ZnTWRtWHFvam9qVlVyaFRv?=
 =?utf-8?B?MGZkaFpKeXBZOGU1US9qZTNkZ3dlb0hDRmJsZDRmOHdYUmx1MW9MNWFvTkxT?=
 =?utf-8?B?bTJNSTJIOG03NGVNTUxzSUFjZ1I4Qzk1WlA4bHVQSW1TUjFZREp6b1NYWDZz?=
 =?utf-8?B?U0U3NElseFZXRHZiVktxcXB2Nm5QUXBWMytPZ1ZjR0ljN1lqVXNFMmRjT3Zy?=
 =?utf-8?B?YmxCYTd6RUlFVGxwTThRRlUrSGNVZi9tZnVGaXlLUUF5akNucFd3Ujk4Q1JW?=
 =?utf-8?B?elFOVFZrdzFUSEFFZzY1eHRreTdtUFRSK21sYmNHMFJsakhIV29POVRwaUky?=
 =?utf-8?B?OUc0Z1FtYnNDTnowa1hnZWxYcHdqdE5DbWF4VjNPcDdPTGo1ZlZqbzBHcmJs?=
 =?utf-8?B?YUxreDFZSTFRL2Y4T1RNZmVMS1M1ZWlENFgzTVZYZnFSTEtCRE5rQ3dPbDQr?=
 =?utf-8?B?bjlaM0lrZ0xwNjQxOXI0RkNGVU9uSTJKTThnZHNmbHFmNUM0SDRGbmNwNGJF?=
 =?utf-8?B?K1l3c2ZHM3J5enhMZG5ROWtLd215cXhvSEdMcXJqTzQ4ZFlZTUlFcUhsZU9a?=
 =?utf-8?B?MmdNTVNMNG91eHRudnZDTzR2QldzTjBuRTg1NmV6aWpERFlpY2F2V2h2VVJU?=
 =?utf-8?B?QnIvbjArRUV3TE15VGF2dzdrM1RyT2V0a0xvek5kMkQyVmRQZEdXNUVpRU5G?=
 =?utf-8?B?VkxaaVY3V3NsY0FVL2Fia1NhRlp2L2NVb1JRWFpRVzBRRDFxZGFiVmtpODVW?=
 =?utf-8?B?WlNZTWdWc2RvYWI0ZGVabWNLeUJBeVhxaXVURis3dWR0eU5kSG1kQ2t4WDdm?=
 =?utf-8?B?WUFweTEvTlp1RGo1b3JnNy9hZVlMSWxTa1c1VTZ4Y0dxS3hJbFZSc3BsMDIw?=
 =?utf-8?B?QVhtOGpRdXNRcHJ0T0d0b2NzVU1sdTFISHNIK1BPMGgwRjdwU2dXR0dDQ0RP?=
 =?utf-8?B?UDZLbFJTTDViUGpQQWl3bmxPZXRUSCs4eFdqWm9mbjg2UStlVldyUUNoQW9U?=
 =?utf-8?B?VWhNWmREWFVML2RqWjFRaXhFSHRNUlllT3lCK0lleE9IWWFNenVMd2p3ZzM0?=
 =?utf-8?B?K2x0VDBadjk5NGdJaDBoeFYzR0ovb2xCQldXdEFBbGZrM1ptWVEzK1dQZFJa?=
 =?utf-8?B?TFUxUFN2dG8zL092V3VpQlBHeDV0MWsxSHV6WXNhVVJyZVNhN3pmMk5BZEpa?=
 =?utf-8?B?bGMyaUhXVUg1NWVGT09jZVNsYVkrK29MY1oyU3Jia3NFeGIyZUdKQ0NuZWt1?=
 =?utf-8?B?c25zblNoL1VPc2wya1JIdE1DMWpTNnN6VklENUV6ZTk0ZUNtVTczaldEUi9L?=
 =?utf-8?B?dUlqemZ1dUhLN2E2ekpQbCtkWi9xRWM1WWR6TzRzV0VEWGpYZmpQQlQyblRP?=
 =?utf-8?B?MmdybklJOEg1cXRsTzB4MG53MlpvOEhEdXBNOWF6VUI0YWVFTmp2TG9zTzFN?=
 =?utf-8?B?OVhJN25LOG5nTHZnbjd1MGhpRnB3eGZqd2FMbmU3aitmQXp6dzdJZTRtM2ZD?=
 =?utf-8?B?YlR3KzdKaTUvMTZTN0xURGtIQ3lZRFZXWHNLaHZ3YlNxcVpyaXMvSyt2ZHU0?=
 =?utf-8?Q?MdFAAHBu0CXJyPi+FNFb21MZC9jRfFUYs4CzQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmpPVGZaU0doL2pDcG9pRWoxR3pHU3B5WWdWdGNmRG1JdmZVZ3g1cjhEVWR4?=
 =?utf-8?B?Rk05NW9xVmtDdjZLaUNVT0VlVFRFWk5jVDZBbmVPdm40cG9ZWFlYZjVhZkdk?=
 =?utf-8?B?dVlYSjN6TE9pWXJibG0rUUl3SnpBMFZQdmhmOGVXLytjd2x5UDJZRVBOQ25F?=
 =?utf-8?B?aXdjblFOU0ZtSzRnTEtpaVpraXkzdC92S3pHdENUWUVEWVp3TklrcVFxSmZp?=
 =?utf-8?B?NmVQaWVENm52ai9BQWpEdy9VMjk2d085a01MaldpSHh5cXNOYlQ5dnJhc0xa?=
 =?utf-8?B?R0FQdEMzcUlBalVzTXZsMGorME1qMmtGNzU2alkxWDFRK2VSMUxDSUNQMWsv?=
 =?utf-8?B?V0lCc0RLR01nc0xiQU5FYmlITmQ4KzMzOGM1RUdrN2psSnlKTEF6UHYxVG05?=
 =?utf-8?B?TEVXZldtYm1aTjRxQ2FuYUYxZnhGbmdadXNQNTZOZkEzL1MrTXFmNUtjYkFV?=
 =?utf-8?B?ejVYdThzeko1YXA2TmUveGZzNnJxcFNWSUU0a29vbUcvcTI2QU01R1dkMXd3?=
 =?utf-8?B?SVdKZG9kVkZEOU9pS0k4czM2Tmppcm9LYy9rWWdZMVBGREVsTlB0VFVhWDlp?=
 =?utf-8?B?ZDhMbll2YTE5QkZ1N3owZ1MyUmY0RkU1MExqWVduQ242dWpLamhkVEF2VFBv?=
 =?utf-8?B?YnUrdEgxeE92Q1Y2N2ZFOFl4SW5ndkxqeHVSeEhYV2ttR2prdmhxS1k3NVYx?=
 =?utf-8?B?eFRiaGFoS3dxcitJSmQ0MkNJUkh6UGZNSVF5dDNGMzZUaDhOT2E5UXcrS2JU?=
 =?utf-8?B?VjZOVE1LN1l0NzNTMmpyZm5mdHk2OTdVYUhuSGxBSjQ4RGV5a0RaU2xQbGt4?=
 =?utf-8?B?akRkTkZYVkMwUUcvQ0FBcjM4OTc4UW15T0l3VHVVRGUvcFQyWVVjTElJM2JI?=
 =?utf-8?B?MWxxZ29taXlxeStJVlcvSnEzeng0K1ppVUQzanJLRGJCYkRUOHJpa3dJVlhU?=
 =?utf-8?B?TXpoZmF3ZGlFRGJMUWpUWjlnUXlmbjUrQXFzUThOMkRONjlGWVJzTjQ2OE10?=
 =?utf-8?B?WHd0MDBvbGxkSFBlWCtTdjlYT3dxdkpvWE0ycHdFdGw4em4xb2ZtM0RvRnBm?=
 =?utf-8?B?VnJZRkY3ZWdkeHRJUmJmYlRIQkhjaDY4WXliR1JrZHk0V3ovY1c0KzJNUlNp?=
 =?utf-8?B?VW5US01meTBta1plM3hhbVBod1VHeGcrRDZiZldsem5WSkt3ZDRsVm1YZkYz?=
 =?utf-8?B?eVM3SlI3cnZ6N2hwbHJLS3FqSllWOStiRjlVeUJVTWVYdHV2Vm1pV2ZGcDQ1?=
 =?utf-8?B?QWlaVzk5SmVsU2tmUDhvQlkwOUlhbEhFVU16UnVncXRjL0dndnJMQ3U2TmJP?=
 =?utf-8?B?NVNIRXZreEFXZ1FYenRwdXdYL1pDTElsMkxLRmFaSFZ3TVJwNmFUS1FEMjY4?=
 =?utf-8?B?WmMyZmdzSTJINTAwak5mdkpsK1o0NnJhZG1iNWoyUWFZWnR0Z1p1ZllDbVV0?=
 =?utf-8?B?VTFQUVRtczlrL2Y1VmhwdGFBRHgwYzRUSkFHOEJVckpyMEtaZGd1bHJzbXhk?=
 =?utf-8?B?TVZWeE9RdlFUTndjcTlyM05WOEtObXpWM3g0NEs2S0V0TXNRKzBqM0lheFpk?=
 =?utf-8?B?NkhVV1JkbUlmTFRGRzRHbTJ3UldHUFJHWlYwQkFkUEVTem5RQWt5ak00N2Vh?=
 =?utf-8?B?L0RWWmNoTUx0NGtUQ25ad2Qxc2pwTjQwNXlDcnpnKzJjMjRQM2tTbXpHNWNE?=
 =?utf-8?B?Rm41RiszbjZZQVNaYlk2UlRxL1BTanFkZW1ENEZOSU9xQ04wZjh4a0Z4QllO?=
 =?utf-8?B?blJERW10cVpJSHc2c01iUmFnWHJhbHF2SmpZWlRIVW1CaWxPV3Y2UDJ5bmdr?=
 =?utf-8?B?VlJVbG9TSjlteHgwZWMraVdHQmJ0OEkzUWJSK0pjSGd6cWFUVk5XTVB5NElV?=
 =?utf-8?B?RUJsS3p2eExSMWo5SDJwUG1TcFlGc2ZETWNJaS93WmRuejVvUmRFVkpvMFJz?=
 =?utf-8?B?elFqVHc5ZUx4ZStJR01nZWxsMUtyaC9kZUpqMERQU0hESFhGVkx1ejFDMWlh?=
 =?utf-8?B?YmN3eTFhNThENzRmSzAvU1V0QWNHYjhRWkJvT3M4QmFlNjFDeGI0Y3B5NUFs?=
 =?utf-8?B?VEg2RGdGcWJQd0tYNnhkZGJZS1hsQU1wWXlCdk9pT1JUbFo5bVdGSFZvTjRt?=
 =?utf-8?Q?RBgDwsePdb18YNbkMIWl0in68?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0434e2-598b-439e-799a-08dcb5664d9e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 15:50:17.4505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kM1ADsa8RxhXfERc3nFPFtljm+BsoSigZg5qxzVnh8SzoBcfb+igkuFg9zeb6TCX2pw+dKAKOfowwKlkUDFEcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10464

According to binding doc http://devicetree.org/schemas/spi/fsl,dspi.yaml
and driver drivers/spi/spi-fsl-dspi.c, default is little-endian, should
use big-endian for big-endian system. Remove 'little-endian' to fix below
warning:

arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-85bb.dtb: spi@2100000: Unevaluated properties are not allowed ('little-endian' was unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 82b0bef07034f..1e7d4c0d76a20 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -381,7 +381,6 @@ dspi0: spi@2100000 {
 			dmas = <&edma0 0 62>, <&edma0 0 60>;
 			dma-names = "tx", "rx";
 			spi-num-chipselects = <4>;
-			little-endian;
 			status = "disabled";
 		};
 
@@ -397,7 +396,6 @@ dspi1: spi@2110000 {
 			dmas = <&edma0 0 58>, <&edma0 0 56>;
 			dma-names = "tx", "rx";
 			spi-num-chipselects = <4>;
-			little-endian;
 			status = "disabled";
 		};
 
@@ -413,7 +411,6 @@ dspi2: spi@2120000 {
 			dmas = <&edma0 0 54>, <&edma0 0 2>;
 			dma-names = "tx", "rx";
 			spi-num-chipselects = <3>;
-			little-endian;
 			status = "disabled";
 		};
 

-- 
2.34.1


