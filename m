Return-Path: <linux-kernel+bounces-444011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BC49EFF51
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 23:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39D73188ED6C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 22:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508C01DE8BC;
	Thu, 12 Dec 2024 22:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WIBnkPn3"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2049.outbound.protection.outlook.com [40.107.105.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527061DE2A9;
	Thu, 12 Dec 2024 22:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734042412; cv=fail; b=QOAFYAs3I4b6hWcAorKZrQXqa5UvGhujacntbZ2NO3NvwTYnvfTcgQKFMSzCjosgR83uhDzLyBTOsMxG6yc5XvjhyVvlXt1brWnBrp2Io+BmnHOIlay9kf8vsq40TNGs54OUzue0UQoaN9AAUEa0/iwkTWWLeiL9r0tw+CBWoTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734042412; c=relaxed/simple;
	bh=WkSN0skgVCQ629xDNp10vcddkX1sWop5yX2QYYXJB48=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=omCOOalO7pTse3UausU6/SUiG0pXgwS89Ox5xO6rT3BMJHJGe5IQIlR2Y0ta2QKQDxzz5fqXgcsqGU8421y1NHrkrg/FJKX5hBUs+8rE0vsoRHiTy1BrSdPsggtZqVnsV4nFb+flyDFXRQv/lQ6bdM4Zu6OtwwCgTK+1Q0/nvSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WIBnkPn3; arc=fail smtp.client-ip=40.107.105.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMzZJzNJdyVfpc57D9oeroENOmSrbMllJREE//QD9mRl1HC/kGDEiVRDJwF30Bx1VIjeXDxMhfAI51TzQ9ha1KNhooIuTKHXmpsVTTCAXas94zMilmvitmlncIcMPPNqZq/rZq52TCrxkM6mn3CQlhRV3KZt5x/xEZpz38UNdzSxtnto/TCEJpSrXJcahPL2/bdp8f85hoFRme5yttc1BToASZOfDU9RaryZZ/HK5j9Bx3SR/5fSNuIm+YtOmrx5j8IFXV3Mw5czVc5OPnOfzOOYPW1YeowgJZKPleyhYgUs48nZ8J+Z3q4XrdwsdVvi2oAGN0y6G/CcF2pnlP3PMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xi5KwQosWpmTvTc0gP5xvoSXhutgxrsfQFQLM6KzUgo=;
 b=xZB3y+Krx5lJz9EGgpVr1nHoRg1TyWIjR9EjSY+m7Dz4Ww2GDtJeySp8PCTe2yZrJCIIVvNQWcNF9W4DJatQRAiGmIfwvPZmiBMWGt8llvU60iQVQfnl5R7kXeHD+mKSSvKwDaMflbqMd2eSIEd4bxsGFO3ntZ4oi5K/x4cAPK9NRgjveKQ1XDSgQ9zNdjsoRWCoXKMn5Wxe4Go0lt2uiap4yg/pCXO7Y8XZL+O2JV1cU8XB/TnSTj72loIvlNEWiSZI8SRW03ynuKxRBTXXiykJ3XMbN0tvlnr3CgliTey8aQkDE62o+fCM6SZATbRVeBPbelFQah10tajV3tjThw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xi5KwQosWpmTvTc0gP5xvoSXhutgxrsfQFQLM6KzUgo=;
 b=WIBnkPn3KKGA4BFBQoOvlx6d6bqGafAF/93QUT91VMjI7Zb6IxEXy/qFJqqyVqBTw7mCYltn2Pb09SwMsXNpIrQ8h3gZqjTxZ7lGjV3Y89da9vC5fdIdAmNl6uad3w4GCDWTBJHX5tr+ZO09Qsvk7gwndhQicb/dgxCNDuMy2jr9j2/bXNfh8JNwesYJOrcPb1t5JyTZG2WgggPW8VVbQfXGWvvRndlycK7bT7wOl6HrJ7kVooiWsDbZKdaBCCF4YidHFHvCKsaV0/Um5puKgokOX7LeLy+UtthpQ2SqsBXSVmAgOkyqmEwI1GPcmNoHLLiNw0oBRpVnlwb1JvperA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7061.eurprd04.prod.outlook.com (2603:10a6:20b:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 22:26:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Thu, 12 Dec 2024
 22:26:43 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 12 Dec 2024 17:26:24 -0500
Subject: [PATCH v2 1/2] regulator: dt-bindings: pca9450: Add nxp,pf9453
 compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-pf9453-v2-1-f59d2c096356@nxp.com>
References: <20241212-pf9453-v2-0-f59d2c096356@nxp.com>
In-Reply-To: <20241212-pf9453-v2-0-f59d2c096356@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734042396; l=2107;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=WkSN0skgVCQ629xDNp10vcddkX1sWop5yX2QYYXJB48=;
 b=6FY656TRN2pwcPDg3N3toUN/S4946G6HNuWFB+JOBSVarC/eNqY16WuqEwpaaPwy2SofMQcU7
 8UtWBFND0NRDRE/0+ufMyIAsmS4dfubye3QRF1bLpnkFJiICD7C1gKX
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0070.namprd05.prod.outlook.com
 (2603:10b6:a03:332::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7061:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bd2d345-d92d-41a0-865c-08dd1afc0e3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|52116014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MStkU2tQcVpIdUwyeG1oZEFWYkdWTDJZTVBlUVYxNllPL3h3QWY0eUthbkll?=
 =?utf-8?B?SWtReldab2VNQ240Q3ZBajg3Z1NwcXJ4dWppa3p1K1NsMVNZdmR5aERTbnZw?=
 =?utf-8?B?N3MxYWFINlRGelFCS3BQdFl1NnZuaUlRYURLWXh4WWxiVkFGUEd2RU5Qc3E0?=
 =?utf-8?B?L3V4QndMd0pGdkcwMFczTnpheGhqOGZkNEFVZFB4SEFTMTF6elZ2N1hWRklQ?=
 =?utf-8?B?bFlXOTFjbVpaUFdZcnlyb3RLQzRqczBla0J6c2pJek05TjZiL2dJaTFnLzYw?=
 =?utf-8?B?Nk5ZejFHS3pzOEdYSitpbW5qTWZPaDRNbkF2eGM1MVJVMnhhWVAwb0Y4TUNU?=
 =?utf-8?B?NHFDSS85SlhwaFNSWnpVTThRSUFKY0pLc2t5Mm0yeU1ZeXVXNXBSLzRwMTZH?=
 =?utf-8?B?VTRneXJad1hjdUs2YU5FWmlyb2d4WDUrT1ZUN3dtK2o0ZUVaZ0ZjMkFNTFdB?=
 =?utf-8?B?VHBnU1g1Y29SUldmcngxVExERHZmL1lHVkdlZFl6QzByTjNCMkpjcXNFWGxp?=
 =?utf-8?B?RjE4dU93WkUvQlo5TDd6dTZZeHZvbHNmMkljdnlNSEVCMmFUTHdka2R3RjFR?=
 =?utf-8?B?MURzenJtZDZPTDdFbjNOdUxMRG9yZk84bVo0T1I2ZXZPY3J0bjNpZ1B0ME4w?=
 =?utf-8?B?YnNvN1RsUkZEcXdDZlE2cTB3NXZBQ1RYSEpucVlpMXFadEJtWW9ZNEhObzh5?=
 =?utf-8?B?aEh2Tlp3WjZnV04vRjFVVnZ5SnpjWVBVd3F3a3VQYm5VN1dXLy9vS0IvcDhm?=
 =?utf-8?B?ZGpkbndYT2FkRFR5Zmc0TGludjEvdzh3R09LZTl1cmhlSVllL2RRb2RHVzRq?=
 =?utf-8?B?akdQNSsxMHpWWDJzUnpyZkRkZFpwaU53N25oSFZDbUt4UFJFOXJhWE9EMUZD?=
 =?utf-8?B?dkdRazl2WEI4RUV4dUcxZGdsbFVrR2g1eWZTelNBMTFqTUpIRVV4aDI0N3FT?=
 =?utf-8?B?L3JNUFdOMGlwRHVaTll0T0k4aHUxMEFQSDVua1F1eDhkZ3c2aTdOQmgxeXcz?=
 =?utf-8?B?NnFMRHV6aEV4VVRBOGZBTmN5b2lxaEt0NllQTFB1MmU5WnlGV1FicVBxZXkz?=
 =?utf-8?B?ODNIQ09XdktxTkc1L1l2SDBKd2R3YzlDSzNKQnQ5bHMybktSSGxiOWpuWjZ6?=
 =?utf-8?B?TjBJc0VLSW9OYmJ2RW1HM2ZUZ0J1clF3T09oRDNaRE9hWDZaSGdzK3pvSm9C?=
 =?utf-8?B?Y3hJOVh0VnF5eHhDMVY5bnVVRjNHeFRwRFJwWUFsTzkvdXVDTVRZVjBXUHpT?=
 =?utf-8?B?WjJvTmtIb3NKcjRBQUFJRXVzUWc5OHVVTUU2TktFWjhoVXg5MWFrcXdZTFQy?=
 =?utf-8?B?VVExRHlNZm5zZ2dlZU5qdmg3VnovNlJFYlZSQWpXUUNTV0d3cktwVFpyTkFh?=
 =?utf-8?B?UTR4WmllQTRsZmpGbjRLNGR3T0VuSm5QMVZsZ0d6NDkzWVNnUC9BRytmZ3E0?=
 =?utf-8?B?RlFEWUZqUWZBanNMVkR4Z2Iyb0dYMGZobXBpMWFaSC9FL1Z0TjZQV1Nzc3k4?=
 =?utf-8?B?dEFORkNOWmNsMlNWVmkwK2pPcldwSVNIMHZwcDhaL0ZVYjFlL3BkWjluNnZH?=
 =?utf-8?B?MWE3ZGJFSTRGQytwTXVvbUJBdERLSVpRTUNpOHlXUjdlMmVZdERKMUpvMzFy?=
 =?utf-8?B?cE5KWENKQ0U2OWE4TFRsWTVDc3lDa3JKdkJLaUFzNDVGV2ZvUlhjNktuYzBB?=
 =?utf-8?B?MWc2RFBWY2VrdnVVcXVpbW02KzcwdFIzbUQwZ1RIaVY1RFlaVGtaMkIyamRs?=
 =?utf-8?B?UW43UkhyRDJraGg3a0M4cjZXMXYxcCs1b2c1YlljWW44citablhFN3AweW92?=
 =?utf-8?Q?ZYTdQaecNDFcS1pL9LwyoE2dfqtaSZcS75rsE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(52116014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czNLbnFsVWhOeDdFZ09rVVVpVHJIY2I4TUh1UlMxbGlzZHNWdGcvSCtSVTU1?=
 =?utf-8?B?TFB1Y2xLVE93SFR0WkpZTUdvZFZyaWVQZnBpYWNnOXJzalF5ejE5VDVkMlRp?=
 =?utf-8?B?elcvcmJqOU01SzVGU25rQktWTUJRdzBYSGFqQzhRNC9ubGlKRnhzUWxWZWFo?=
 =?utf-8?B?M1oxSzcydmlUaTZublZVOTlmSHpVMytQWWVNTG4zcWxBRXZYUGZqRU9yMW91?=
 =?utf-8?B?c3BzQUVIZkZSWkRFMGFiSEdGaG5aaS9ZQ3o5VjhTWnlLelZQd0UyQkpRVkdy?=
 =?utf-8?B?cFZuWXF4UzZyWnZBZURudVNaRGc3MXFERWZSK1I0amtHRkxSb0tvUDVsZFcw?=
 =?utf-8?B?eXlVYkpxZTVwUTRnempValhRd1JzcCtvaW9lMXBRVUIzSk5pbFpHSHE1SmVY?=
 =?utf-8?B?b3NEVW0wRjZsaWlxcXV4RUNwd1hwVzZEOENvWmIxcTYwRlgzOE80emRVM1Iw?=
 =?utf-8?B?a0VYNWYxeWVGQkI5YnJXM0tWSEEybVFLZU1oOWNEMWwvQnNaa3VsLzdiWXhm?=
 =?utf-8?B?MUswTnZ5YnRJU3BWczZnR0pYTXFIemMreVdVQStnS1lSNk5Ra3NWZTlaOURt?=
 =?utf-8?B?bFNNTEtCZmM5dDByQnQzNnRiVmhVRGxUcTZLNUZOdEZCOVg5OGRLTjI4QW5t?=
 =?utf-8?B?bm5la0ZQNE5CM0EzQ2gzVFlpc2J6LzZEWHl2NUNjdUQyZGtjeXpiV0dmYUlO?=
 =?utf-8?B?UzBVUUo3SmdwNVFxTGlaZWNTRGFPMXBSRnFndjVFSzArKzFCZCtqeUhXbEky?=
 =?utf-8?B?WG9ZZkpXbXNzRmNJRFo0aWdPaUkxYlozY2I5TkZIK2k4Z2cydy9PWG1xWTJP?=
 =?utf-8?B?NXRnNjFaeVRmSDFOS2RoeHBnQjBIOFNxTXAyRjBMWUhOcktEVElXbUFIYWJX?=
 =?utf-8?B?SUVPNVdBUTFzZklha0todm9lbWIyMzQvWi9VWlplWlk3eTEzTTQ3N1luSFh6?=
 =?utf-8?B?amRnaDhTMVNDUm1URmw0ZFVSZENmUVZ3Z0RwWTkwVGhBTDhreDlKTkJGVjRM?=
 =?utf-8?B?bmF1bzdYQ1F3ZkpFK3l3Y3R3QUhkS3dvRU8zV0hpS3RmNmxBQmp3VlI4V3g2?=
 =?utf-8?B?VEpPMGhYd1BCSTFSaXNoL2lWZjMreHBQQ0dkanhGemJOT0VxUmFudkxyTU1m?=
 =?utf-8?B?eE5OQ1RDNGlKWTBmRmU1QkxtOTVXeDhNTW1XdWQzbUdydWNyZUpCQitaK29l?=
 =?utf-8?B?czMycVIwM3JheStzSEdwM1NEVVh5YXowTXh0NTRzaWNqY09vaTAwWXB1UkV4?=
 =?utf-8?B?NWxZT3IzbDczMngyMmJnU1ZzZVlxTmR2V3pkRlNDa2YwK2phbktiZkNWWExr?=
 =?utf-8?B?TzdWbmNlWnBmVUY5RXhuM0pEUU91Z3hKMFF1R1p4VUZKdWliT1U3UHR0M2k4?=
 =?utf-8?B?TXQwUFcwUnY2MGRRSG5wdXRYRXRrbnNkeVVkL2pBc2JXbDNWdzU5V1BDWmFY?=
 =?utf-8?B?VFBOcDBtTG43M2NuVWI4SFUzZnc5NkJESExVRDNHcVpRMkNiWWRIL2d5bUk4?=
 =?utf-8?B?ZHAxQ2pKS3pJSTJSWWNidm5YOE5LdGd1UnlNNllqVzdNSW15MDh4V0g0N0JP?=
 =?utf-8?B?UGExejRNbVIyRmV6WW1wbTBIRnh4cjhuMlp3c2owNkM1eGtTUW8vTkcyNVJj?=
 =?utf-8?B?bjVHOEVHdnJuK3J4dUxMYkRwSFM5dmY0TlFJeUhSQWlQTytBOWdjTkJXU2xI?=
 =?utf-8?B?ZnJ3S2lPV1dzWFc3QXRGS2RUWmlmYzFjbTY0YzdMVkZBeFIrM2pZT1NLZndt?=
 =?utf-8?B?NTJmczIvZlBEamd5RlpMenhNYU9wYS9LdUxJS3RRNCtSVkwveEd1UjVDbGJs?=
 =?utf-8?B?Sk5BL3hYaDc4Zzl2V2tiSUZ4aFZRQjF0c3BsMjRodEI4ei9jazVJNDIrVUdN?=
 =?utf-8?B?WHBqdEJJQTdUMlI4VU5YTVRsdzFOQXhGaFdFcWRXa2Z1Yy9mbWhkcHBOcUVp?=
 =?utf-8?B?VWpTaXJRUGNadmZPekZ0ejlqdXVmOVlvZGFlYUJCUmlSaUNaVFhEUEdmMXJk?=
 =?utf-8?B?Z3cyYnptNEgvSXRsUFdRNm80elY0RlI0SGMzNTR6UTdxcXVkNThGVXExMEsx?=
 =?utf-8?B?NDRORjRoTjRBcE5ZeHc0RXhDdGowcXBjdzBIc01NQktEcjBpbGYvTW9NcWh2?=
 =?utf-8?B?akdzUjZjUkl6NmY2dlJxaDltMVdpUVlOak44VEJCa1BDYkJpcG9ZVTkrazZT?=
 =?utf-8?Q?sLTJjhJDamNDJTIs9R5no8gcJ/oRwFVHEGQo+EY3/qLl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd2d345-d92d-41a0-865c-08dd1afc0e3e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 22:26:43.1061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZxEmFBxTlrNhVZBdF4QuUb40I7731hEFleRDkf7KlB7dn80mFaOOfV4Rn1y2sPBYQlmu4Oi8pIXC8WmLymACQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7061

Add the compatible string "nxp,pf9453" for the PF9453 regulator. The PF9453
is similar to the PCA9460 but supports only LDO1, LDO2, LDO_SVNS, and
BUCK[1-4].

Restrict LDO and BUCK numbers for nxp,pf9453 and keep the same restriction
for other compatible strings.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/regulator/nxp,pca9450-regulator.yaml  | 24 +++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
index f8057bba747a5..3589817858c5a 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
@@ -17,6 +17,9 @@ description: |
   Datasheet is available at
   https://www.nxp.com/docs/en/data-sheet/PCA9450DS.pdf
 
+  Support PF9453, Datasheet is available at
+  https://www.nxp.com/docs/en/data-sheet/PF9453_SDS.pdf
+
 # The valid names for PCA9450 regulator nodes are:
 # BUCK1, BUCK2, BUCK3, BUCK4, BUCK5, BUCK6,
 # LDO1, LDO2, LDO3, LDO4, LDO5
@@ -29,6 +32,7 @@ properties:
       - nxp,pca9450b
       - nxp,pca9450c
       - nxp,pca9451a
+      - nxp,pf9453
 
   reg:
     maxItems: 1
@@ -42,7 +46,7 @@ properties:
       list of regulators provided by this controller
 
     patternProperties:
-      "^LDO[1-5]$":
+      "^LDO([1-5]|_SNVS)$":
         type: object
         $ref: regulator.yaml#
         description:
@@ -100,6 +104,24 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,pf9453
+    then:
+      properties:
+        regulators:
+          patternProperties:
+            "^LDO[3-5]$": false
+            "^BUCK[5-6]$": false
+    else:
+      properties:
+        regulators:
+          properties:
+            LDO_SNVS: false
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>

-- 
2.34.1


