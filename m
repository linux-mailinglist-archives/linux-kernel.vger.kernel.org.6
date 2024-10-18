Return-Path: <linux-kernel+bounces-371393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 110D39A3A7F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6E27284086
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B712F200CB9;
	Fri, 18 Oct 2024 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HKix6W73"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2081.outbound.protection.outlook.com [40.107.247.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23DA200CAD;
	Fri, 18 Oct 2024 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729245153; cv=fail; b=OzhhW6zAYtr5OhBZnw5jpw0/up7GlctG9ooVt7FMOB+b+IjHSp8cpRH1ZkPrDIyzshfXs0/BfzmySmyo7cy0KrOqqAnxVP6Yi7Oh5PleAmGUxXFvLyf64sYA8wysRc9hc5bEAjMQCtTmD7AZLSygc+VefXFmMKovpCXzbzpJsRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729245153; c=relaxed/simple;
	bh=OZMCUhuPRtFD36Zafiu5ql9Qx4nyPgfwd62EsTg0bOM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=elvwi7oeoW5WFyIjMJztTnm5KGt9h4aLg87+2DivsmOBm9ZI9D5zOW2Lb1iCAMrtOYCdZXyBcwgXch6QnBRwTvH/nEG2l8eFBdjPSru9FGDeUTxbwSY3QsEA6ZZWSWkYrN998nQscUVQEnhOdxG4u0UI1YGyFD74E5qSmfy85ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HKix6W73; arc=fail smtp.client-ip=40.107.247.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIo7XxVnyjVQShHj7sUtXeQERWRNl7qQdCTAUKCpWz5Ap/XBeUX51eNiDCFaLLJ1Qy61h0vGKbOl1fFwQWnRs3BOUE1f5mdivGAA4pqVLuL4uUXIs2HJZvN2/hRMajImmM6/0cnBdGhpSF7q4ZOhRkHMKVa5faljXr2r4Wkj+e5YTlakxlqyx5hopwLffvyB1/WW9tXB2yCrDbk5p/NSkriMmZCzM9Vyk+NJM2BoM7lD6mMtXfnOTTpLITadwdJlpjP7iCCOsZZX8thIyQhZlRWFZleizRnBdC/7IxJSzixiYEsmEVb2mOhi7nceFY4OL+JT33qPxwxZHF7SR9XpQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7onIAiRpWzL3btPGEbwKC6KhdnLY8JS/LZCL/YIUFwQ=;
 b=BFJpEGuQtzghf8pO1M0/9N1x6jDsguxyTbjqJzuVycm02i+k0bSExa/fVca6es5O0z+n+kfD5ZAymq9nAzYdGXzVblNBJG9c0uG7Sjx20YhgC7aVVjmkKLRVuO/1cXTuG9qhfCEecGooXZYwwsz6+PKL8dP3/kmaziTib1qBx24X3qWVAUxb5PBUsLtZwLwNJQxQltHokj5koRtWEbiUECuWvZ94z9NOADVEco10kegziKTfDtIY0pldrXroV+Z2F0EZWiwbs3YnAc/cOGBTUlxZU/8gqZtmLvbvuUE2kbuaUU3WfpNTZDbTavCq9Ps4ndbJxS6oct3ehqk5hef2nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7onIAiRpWzL3btPGEbwKC6KhdnLY8JS/LZCL/YIUFwQ=;
 b=HKix6W73Vz81SOefirntAvl/MLA4w8/rL6VX9J096vAEwgd+fVc2X3g2x+knjC3T2naYu/X+/liW6T8r0YCKRigOfJ00RJ+TUHM/uKL3beptwLwdYP/yzxttAymx+Hr+wvgjJLqhwy8Q2X93/ETBcO+VDpmACcgTP2mpDgpY20YB8yhiDwjm5KE4TmE+3NCj4Rz3q+ZFmtqAkeXw8i6nlRHtfsrw2o/fZkdc26bdLMvsdt4S843NsDKeGto15MQtmLfqGKU2KL25BDiO3NV5TVG6CCb5drnKEIMSKmHrGs5uoS9EgyT+JtbS7ykSBd+n0Ld+M6BwsWrV6xdbsl1R+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBAPR04MB7285.eurprd04.prod.outlook.com (2603:10a6:10:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Fri, 18 Oct
 2024 09:52:28 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 09:52:28 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 0/4] clk: imx: scu and fracn pll update
Date: Fri, 18 Oct 2024 18:00:54 +0800
Message-Id: <20241018-imx-clk-v1-v2-0-92c0b66ca970@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANYxEmcC/22MQQrCMBBFr1JmbSQTY6NdeQ/poqRTO2iTkkiIl
 Nzd2LXwN+/DextECkwRumaDQIkje1dBHRqw8+AeJHisDEoqjRK14CUL+3qKhEJpq1o7DTiaK1R
 hDTRx3mP3vvLM8e3DZ28n/L1/M3VSEJnzxbTjCaW6ubwerV+gL6V8AX2Ck1qiAAAA
X-Change-ID: 20241014-imx-clk-v1-24c26cfa1d79
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Aisheng Dong <aisheng.dong@nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729245675; l=1232;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=OZMCUhuPRtFD36Zafiu5ql9Qx4nyPgfwd62EsTg0bOM=;
 b=xQzUEDPn3+igb3JZMdHeOjfUydLwvF0D7F08sHtqLPbf2otvoe1JaZ2ziHH9IZ8yiMVl6xfUP
 OksCfcIGOZqD8CGNY7jBotpdspiFIpUdcFFB08H7gPwVprLIip5/nGN
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBAPR04MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: ed3e23ad-cc06-43f7-53e5-08dcef5a9378
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFRCTzRyOGNUTTVKclF3K2NOdjl3RStILzh5QmljM01kSjJBdXBEWlhaMDd4?=
 =?utf-8?B?YTIxWWdONTFUdlhZYzFCSk93RHpFMWVVSEdxREJCdDZjUjFnZFl1eDI1Rjdq?=
 =?utf-8?B?ck1wZ1I2UUF3aWRsR3pXVGZsZjFUc0JzSXpQZkNoOUpCRmMxOE5jbENCUG15?=
 =?utf-8?B?a09JWEE2RjgwZEtSRDVza0dSbjhvWnU3S1BtOG9DWnhsUlg0TnlPRnhMVU1v?=
 =?utf-8?B?a2JZaXhZNUpIOWFnZ1dSYjMwc2JTU0pQdTBLZ3dYRWFxbmgrSk82Ny9qK1pN?=
 =?utf-8?B?QmY2L1puQTJiSEtIaCtWUHFrT004TTg0UWR2RVlJWlZpVXB1RjlRQ3VtTjBX?=
 =?utf-8?B?ZWxlcjMyQmcvaGpUMjRxY2I0Q1JRL3RMYTh0Wk5jekxwazhvR2gzbUFGSU1K?=
 =?utf-8?B?Mi9XaUxnQmt0UlNEQVdpZHQ4NWJMK0xFSXB6SFJyYXl6V2ZaakQ0cEJ6SURN?=
 =?utf-8?B?U2JrOG5Od0hlQkVkU0ZibWlkNWd2MGM0TGExNkZveTZTekFrTnlmTFNrdVJS?=
 =?utf-8?B?a3Arc29oS05RS3JLeU9iSE5aTHhobThVK0s1UUJQWVdDVnlYc0h3Rmd5Q2Ew?=
 =?utf-8?B?d2ZFR2tPT3JET0x2M21haGI4SmJMRGlDZ0RZOE1ENGQrQWgrWi9XN3RxM3lo?=
 =?utf-8?B?V0k3UzFCU3RMZ3J1MGMyeEVobWJpZGVuSUJvM3pyeVRVazNpdnZWcVFnOEZl?=
 =?utf-8?B?NHJSMkUzTGJCYlM0V0ZOV3NCYTViQnVWeW1Nc3VtcmNHV2hKZUhtL0d4SG5V?=
 =?utf-8?B?amFQOFo3UFN6M3NOS0w0UEoyODJvV05hTm1VZXU0a1kxSklCQ0Y1dnpTZTJz?=
 =?utf-8?B?bTdvd1M1TlZ3NHArRkkyenU4QmxobjMvWkd0ZXc1ZHNKbTlDdlZ5Mko4L3lN?=
 =?utf-8?B?UTcxRVdYTjBEMXg4NzMyVlRGcW5LT3JDblNoejhqZW1POCsxYmllVWU3aHdt?=
 =?utf-8?B?Wk1abzhqVTZqMkI1WUZVVllEaDhYWnNOQmRza01aL3dicjZDdUUvRkdqVWw4?=
 =?utf-8?B?Z0VoUzFMQnVKLzhPS0lnWTI5TUs3TUNONWdQZjlDNnlFK3Vqd1JUWmJoM2VV?=
 =?utf-8?B?L3F6d0RVT3BBczBLQjNRVnZ5MGtERjRJS3hvd0NtQTZrUEgvNzZPSGlvZEdt?=
 =?utf-8?B?LzVKWWdFOVk2aWNWVlpvUlJlK2p5K3pGNGFzQkdnYnVuWUJHZWlBeG9ESVVU?=
 =?utf-8?B?N2ZXek1xWXAxSEpKZUdoSTU1UkdGZncxMW1paFlnUmpmOFdmakNjUUR3VFZ2?=
 =?utf-8?B?N3JDR0M1TmZuUHBWS3pQY21Kbk5XSXJYQTM5UG8rU2pUMVZ4a3NZZ01SakRp?=
 =?utf-8?B?TWs0VHRQU1g5QzVWbjJUdUlkM3ZGZzUySy9NdjhVdEtLd2ZOYm4xQStoYnph?=
 =?utf-8?B?Y25tbGxTSEplSUY4bU9RMnBoaFJ2ZjEyRlBCZUQ3MkExc2w3WnhtV1V6Ykdp?=
 =?utf-8?B?b2FmY01ickdrb00vMml1Qkc0ODVTNEUwemJYYzY2WUdhTEM0SERISS9VblJx?=
 =?utf-8?B?dzB6Mk9jTVRodXNENkJRNFRyeEhSa0JzM3V5L1ZadmxKTVRRNlA3S0thZTlq?=
 =?utf-8?B?VENMNmxjbFB0WmZzLzJlVlVycFJJV1k3RlNsM1hCVjZKWE9NRHllVERRb3ZZ?=
 =?utf-8?B?aHdReFVHRkJVcUIyVG1IOERXbHBTdWhzV0d6L1FJaWx3MldDdUZHdzRhbzhK?=
 =?utf-8?B?dFZaYVFzMXhNNi9IYm9Tc0dzMkowRUFCcm5SYXRQQXAzMFlWby9EQW9QTGE2?=
 =?utf-8?B?T2ZHK0ZlNXBJS2lpQndubzg3Nnp0MXlqWGZtQTMyNTZjYXp0dE1KNisrZGtk?=
 =?utf-8?B?WEdpbDFxcXdyVDluZFNiR1JSVmJSakFXb2tIcHdoN1dqWHIzZTUwWWdQL2Nr?=
 =?utf-8?Q?P6rURivjrpCNY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHF6ampKbVBnMlRUTllaeVIrYTJNeG1rbkttbkZKNjVscHlhaU11UTl1TWd1?=
 =?utf-8?B?VHpYaDh4bitHVDBGKzE0WTFCNTFETU1nTlhkMFF2dFh5UW84dHRnb29lWS82?=
 =?utf-8?B?VDhiaFFmZmUwR1ZQcnJMYkxZMkZTeEhyZW9tM0hoV2dPQTMrczY1Zk1kOGE5?=
 =?utf-8?B?Z255Zk9iSVJlRlQ5VTl6L3o5NW1TS0ZrWEl2OWdhUXZhdmhWUWozbno2WmRm?=
 =?utf-8?B?MTBtWlNoMFNWOW9PVE5iaWpjM0REb00vZ3hwQVFwcTFFdFpyMU5uL3dwd1Ez?=
 =?utf-8?B?NUZnd0FaMkVTTmlxWVUvaTV1T0pYc051ZU80RjVEM01UQ2N6cnNUT1FVTUUx?=
 =?utf-8?B?cXc4SWlSdVFQOHN2dlNpRTNxK0xaRDl2Z1B4cHMzTWtlOTAxR3dSNVNYQVVR?=
 =?utf-8?B?Q1Zha2haVW9vNUU2T2JITHEveXA3OHJaZTljTXhxMHBnbVJyRDExNWFGZWlx?=
 =?utf-8?B?SCtXSGJzOFpzRFJydUtTVU1JZHdab0QvMVg2MUN0cXowSGlEbVJWc3JPRk5J?=
 =?utf-8?B?M0pndTFjUXBIajdtcytJcGxsTVliakNEZmplWE1QUTR0RXBQV1Q5d3pJemgw?=
 =?utf-8?B?NVBvYnAzbmZPWDduZnpkTThRb0VLOVdGSENaMjhTKzRmcElCRjY2MXZjRkY1?=
 =?utf-8?B?N0hweDFlVms1VWlDNmdhdjE2d1FBc2h3amlwZGY5bTdubHNYdlNsVlpra0N1?=
 =?utf-8?B?Wk9XcWJrRVNQUzFMbndhR2liYmNIM2g1N2ZiS2JJaDg2NmxGTjQxYmZUTGZU?=
 =?utf-8?B?eEhYRWdvczZ3ZHUzZjBJbjd5dUlsSG40cHFuMDVwcDRHYm5RTDcyc0ZiZ20z?=
 =?utf-8?B?QVJTQ1Ivc2Fpa2FRcmxzdEhuZEVMWnhYelZFTm4xRTlMMHBZMy9sRGVKRlVL?=
 =?utf-8?B?aVkvWTRuNHp5Z25jOXdlWVcwbHo2WXBBSDFMYnZRaTd4YTZhVmpkVENrWFhC?=
 =?utf-8?B?SXgvWnBsV0dMelBleTJ4U1BMeDBZWGRvUzE3eEVGOGxEd0l6Z3BWamlINm40?=
 =?utf-8?B?NElNZFV4TVh6UFRvL1lNYnU2OWdFa3djR2cxMTdMcm9yL29NdXh3b215aHAw?=
 =?utf-8?B?cjNEb1I0RkxZUnBOTzFmRXJFdk1XSGoyQU1veFA2ZVoxLy8ra0F3eFBFTHVJ?=
 =?utf-8?B?bG9YdDVucEh4aWx6WW51VXdSVnAzOW4vRU4rNWhDRm5FeGhSdHVQYnRtZ2I3?=
 =?utf-8?B?VzJmeWcveTk0QkxJZVFSeC9mTHlWMGp0MmVML1ZCVG90Y1FJRS9ySU9uZlBz?=
 =?utf-8?B?MkV3KzBCRHZSbnY3NGMrOEwxd0J5QndFSHF5S1F4R2xWeEhxZ1hqb2RsdGFq?=
 =?utf-8?B?S0J2WjBZd0dLcE9CeU1MME5SWVIwZ3dyT0E2dXFhaGVQY0JLYnlGbnQ1WWYx?=
 =?utf-8?B?TzFkREJ6VHJ6UU1nam5saUZjand0OUM3SzFVa2dVOEtnUWVBSm1Bby9iV0xY?=
 =?utf-8?B?L2pOSGNWb1BicFoxTjVGM3lGZEpDd1pibVdmM0d4YlR3eUowVm9RTDhUeGQr?=
 =?utf-8?B?MzlQMWdXUGJCUzZpbytRYUpnTGFaUThQUkxGY0pBZFRSY1V3aFZUNjFaVkJJ?=
 =?utf-8?B?VzlabmNac2V6d0VSdmdaMXh4TnhGNnNuUmUyNThyZGVMOWNoN3gwdVF6c3ln?=
 =?utf-8?B?T1J4OFF0S0s5S3JSWVF6WHpKbFVJa2phYytDdjlYMEptU2NGTjhtWTFNUFNz?=
 =?utf-8?B?OWNqQWJJcVZJL013MlQvZG8yOG5lbTBxTnRuTEs2bkFCRUdGQk5Ua2FSZDcy?=
 =?utf-8?B?OHNiaXRxWGdRM2puNHpCZmtZSHVOZE1hczdjZG9iNUhpRzVPZk9rQTZURFNz?=
 =?utf-8?B?a1h2S0NHRE5DVzZjanp1c1JNTTlxZjBZMERsSW4rVWdnT1RHY3ZMRkJMbUFM?=
 =?utf-8?B?aHhYWm5QL2d6dXFVSVQyUWhFbWJKMnlTZzI5ak9XZlVjMzlOZ1g3N1o0Y2hm?=
 =?utf-8?B?d1E1TFJVdGprQisrUEpRM1NJSWg5RStxOUovL3piZ2hxQTdpT1ZGUXFuZlBk?=
 =?utf-8?B?QUVsSXhYVUV3bW5iaWplWTBlTUVhNkdJbXZxRUQwa25TK3F6cWQvYy9hSXQv?=
 =?utf-8?B?RDVweXdzQUFWNW9kL2RoaVZmYVh5MVhzenBkVGVHSDdGM1p3V0hORGwycFZN?=
 =?utf-8?Q?CpIDI6b6vWe6KNhF1s6jtNwWE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3e23ad-cc06-43f7-53e5-08dcef5a9378
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 09:52:28.2419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cV3zs38uxChwujllULZwfztIVC2QHfEoHeqhQH7sdwbJCKquy+8RQv8kRL4k6p7CKU8xSXfhIqHMhCdoE+fbNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7285

Patch 1 is to resubmit [1] with comments addressed.
Patch 2 is for hdmi. Fix tag not needed.
Patch 3 and Patch 4 are for i.MX93 Fracn PLL fix.
In Patch 4:
fence_write is reusing the idea of fence_udelay in drivers/clk/tegra/clk.h

Detailed information is in commit log of each patch.

[1] https://lore.kernel.org/lkml/20240228082649.1633083-1-peng.fan@oss.nxp.com/

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Patch 1: use HZ_PER_MHZ, use unsigned long, add errata link
- Patch 4: Drop fence_write, just use readl
- Link to v1: https://lore.kernel.org/r/20241014-imx-clk-v1-v1-0-ee75876d3102@nxp.com

---
Peng Fan (4):
      clk: imx: lpcg-scu: SW workaround for errata (e10858)
      clk: imx: lpcg-scu: Skip HDMI LPCG clock save/restore
      clk: imx: fracn-gppll: correct PLL initialization flow
      clk: imx: fracn-gppll: fix pll power up

 drivers/clk/imx/clk-fracn-gppll.c | 10 +++++++---
 drivers/clk/imx/clk-lpcg-scu.c    | 41 +++++++++++++++++++++++++++++++++++----
 2 files changed, 44 insertions(+), 7 deletions(-)
---
base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
change-id: 20241014-imx-clk-v1-24c26cfa1d79

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


