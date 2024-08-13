Return-Path: <linux-kernel+bounces-285059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A61CB9508BB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33ED01F24068
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B3A1A2C23;
	Tue, 13 Aug 2024 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m97DvH6I"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012035.outbound.protection.outlook.com [52.101.66.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E116A1A2C03
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562157; cv=fail; b=ESGkXFjbnq3Wtwi27dJBs2jG5AcTQ62z2UAOlomdk3cYVN1Hbk1tfObWzkM+OlAAyv8s71WVadVozlekwMUzNM7tCoe8sY4Zn7C7dV1yBfO/JHCypdWTGrhSPQLLm1CRbyWwhDrcm1HPsDYDLmm7K3hSMjVD8+jyOMkiK2j/fkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562157; c=relaxed/simple;
	bh=AMTPnbXTPolpzXHYUs+QhAi1wFjOHFjoAF8ZsoKsfw4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KPSBckXHqYvAsENywPjSJdmQ32khsoM0L3Pxg/yZB0nB4RZWwhLmF5csgHkqQ8cHb5tQu4DCBsdeLWuBRtuoX0sNcUUn2TDiRzTTSPWv/fHsR17+TiRpidutFM63RFn/whxV4gLMk+Aq1WPRuGOdq5xPiJ8tEEtHdvlyeBmVoAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m97DvH6I; arc=fail smtp.client-ip=52.101.66.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rm0PdZMoQ0683DEm+/9gq1nZYP5sfk4331q4t2BvRz4gBslGkfurf9LQJlDHvZTZ5JID6vGpMm7CfqAbD9cxU4XE2EVm8zHlXuvvdZO9V1AB0QflZFktFXGGqbRk/ESm2bp0sLIJpgoVTi+BIBR4Fu5hinAi+acxDbjrjxoE7tm7Mvaxy8RGa94yKPkHQEyX/YpjkuVCgFXsvU7oKXEQXpNc3ft4v3zw9EP07vjJw3+IAGs621SQkgUm6VPMJ04kCXhCKKxJmzseuLKyEpnCmM1700PTgEGeUeK/cn6kPCAjw7RE9HUjWUfRPbdTQfuViVnVDH4WdaX+Z26egTzh3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oC5qMOvDsNYDhyMbU1awxVhjBYex/SQ12ahjS1n1Eqo=;
 b=MRDlfkTjbfbPe2z9q5YiPkF6EFIEYqaVtbfctGNJv2jEGezQ0eQonHAveaewL6zXI7YPtja6mbQ8qN43Ps+AAQqWWQO9zmFHecmKjmWHvtiNJMGhtsOl4fyprkn91RhpsHGhE7bfM7HuZyz1TEWCpz97bsK5WKghNLdZq1gOnIhPTgf7mCDjBQWYOwIUjcOeBZbFnbtsnVTaqLH5gZ+jQGMD1ktUe8AlGUAOrPQ53S5lr/pPoyjFuKtXxRIXkjYVp8RL/qgfes7tqarkvuzhCmzrHm3gMUQZ2JvERFhRIvYUCdDRUEgCreLbGwFIy3+DqjJhFET6L389+vNQAHTfIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oC5qMOvDsNYDhyMbU1awxVhjBYex/SQ12ahjS1n1Eqo=;
 b=m97DvH6I6Rrgo4EQEsW41P7Qs72Q/9i7f118+d8J3bkQLU36EmH0gg0vvggTM7LAgjB/eKL8/gllbk8xyR53dFSwmQLj9WM95E5E3f5qNZq91vaw0CgV34OME21s6FVoTVlwltFzFSHsPpBBvGVOocQvB5u71POLF3zN0ZagFBqgEZaTAPrZb0A87xhIUtK+ykw2TjknKlGbfmgrwyDhuSfAfsy84U8MhRJgFOoUy9dET/r815AjYFqQ9fKlXKnQgyJaxoWlHIZwQccxK2H0frs8oPbb9nfGCt8ZPGb/91BxXd89XJ12/+4t3l3MtpokY0TIMOgTvtvbwpnrCeYrQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10623.eurprd04.prod.outlook.com (2603:10a6:10:580::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Tue, 13 Aug
 2024 15:15:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 15:15:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Aug 2024 11:15:08 -0400
Subject: [PATCH v2 10/11] i3c: master: svc: wait for Manual ACK/NACK Done
 before next step
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-i3c_fix-v2-10-68fe4a050188@nxp.com>
References: <20240813-i3c_fix-v2-0-68fe4a050188@nxp.com>
In-Reply-To: <20240813-i3c_fix-v2-0-68fe4a050188@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Parshuram Thombare <pthombar@cadence.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Boris Brezillon <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723562115; l=3116;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=AMTPnbXTPolpzXHYUs+QhAi1wFjOHFjoAF8ZsoKsfw4=;
 b=pb8vKftqEcjI7lnZGcpOwloHzr7ggeIr4lRIHTgWrQSDvhmuKOWGszesMsjGrBGoM9ilpBk1p
 yD+1yu0vtzDDXArVTWD35Sst2+37CyO7HUpqzzNd5Rxy9vMdTcdrhLU
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0125.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10623:EE_
X-MS-Office365-Filtering-Correlation-Id: 2306c555-2115-49dc-bb5f-08dcbbaad26b
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?eTN2d21NY1c5Tkk4VVQ3SmY0bTJ1T0tDVTNtY3U4cmR3T09WVlAzZXdUTktC?=
 =?utf-8?B?L0pGeWVVKzI2Rm9zempuR29Cc01BQmErV1pvVmIrbmt1ZDczTkJZeHdhS1JH?=
 =?utf-8?B?eGxKcTF4QTlRT3dkQUhnZTZyV2RxaGhOYm9PSEdtY2lWcUZOVjRLc1RiTy83?=
 =?utf-8?B?Q0d0ZWFsYXNvZjU1YVF1cmVMOVpHbjluWjBiWGJuVkozaEJnRDNaLzRzZHEw?=
 =?utf-8?B?THNaSFdyQXR1aVNqVTc0NUtRcUtrM3ZDVVlpeXFyUXFHZUxNM0I5UmQ0ampM?=
 =?utf-8?B?UFNlVzdsOEJkR3QxTFVvelc2Q1hzTStDblZxa1BoOHRMVG5FZEdJazU2cDFR?=
 =?utf-8?B?RnRSdURUVHZBQlJpQVdscmVnWkJEUHIyWHRXT2VNRWZyTmtyRFBSU3lCK0xH?=
 =?utf-8?B?ZlRleVI0SHc3MjBKUlBBckVsKy9ZZUFvYnluL0tyQTgvazVOYlZFNlNPbXdH?=
 =?utf-8?B?RHlLb3E5RW9NQ3p6Y0tPZXllZ2tvNzZxalU5a0ZwTkpESHk2cVJmMTFyWTRl?=
 =?utf-8?B?ODhOb3NkcHExMUZJa3JiMmhaYm9RTG5oZzcwQThhYlc2UUJWNmhkMWZydkZ3?=
 =?utf-8?B?WXZ4WWRobXIweENsakxxeHdWUEVCdk9vV0RmV3FyaEg5bitkaGs5eHdZOGFs?=
 =?utf-8?B?SzZySFZGeDlIQjAzR3Z4NUJMajRpbllleDBHT2c4M3ZFemloRVlReWxiSjlu?=
 =?utf-8?B?TmZickpiTnZ6YlVmOUJoS2tEQ0pIZFZFeFZ4SFJ3cHN6MlZmRGxSQU9RT1Rk?=
 =?utf-8?B?dEFLOXBWeUtyaTRWSlExK0VGKzNaRjYzbnkzL2wrTEQrNXoxZWFIcGVWL0lV?=
 =?utf-8?B?ZWt4alZOTUJ5TCtJWTlBTnRSOU9jbGltLzNYQ1BPYXQzNTRvaWoxa3BGcnh3?=
 =?utf-8?B?RklSbVYzSzF3TWk1cVlqYnZSMWpyWGRqVzBXcEN5N0djVHNKZXFzUTh1Tlda?=
 =?utf-8?B?WmRYZTNURElwQ01jdDd3bnlRSGM5K0xoMWhDaVpSWm1zcjJPL05IZHdUbHA1?=
 =?utf-8?B?QURyM1ZDTkh6Z3I4TVlqclk2TWZiRGdUMW5nN3M5dy9KT044OXM0SFo5VkFa?=
 =?utf-8?B?MnhXUS95L1BrUlg3Q1dLVkg5YzNXb1YzR2U1UWpId3B3cStjRm4xNjdNckZH?=
 =?utf-8?B?R1VUZC9ONmRLTGVRdXZxWUlIVEQrWEVXRDgxc0hLUXlML2VKTGFLMGJxYmZ6?=
 =?utf-8?B?a1N3RzJtWTlVSHl1UlZodGZpODlSV3BEZ3l2c3AreEdITk5GTHA5QTh5a2Uw?=
 =?utf-8?B?cWt5MGtnSUxIMlRQTmlHZHgwdmZEVEVhcnY4REFsRm5IaStKbGJ3QlI0ZmdJ?=
 =?utf-8?B?ZStsbWNwazJ2UE5Ja0YvenY0Qm9ENDBUVG1ESk1aRXVHbU5jMjI2U0xXZFFV?=
 =?utf-8?B?bnlDVFlUL3l5a1pJZmVCdkY1Y3BRUm9SZXByMmdVVEFoUDREWGdTeTI5MHAz?=
 =?utf-8?B?OXYxUVF6MXdGT3l6M3ZlVHZpV2JzR3VDbnc5SWx2OWpzdkwwTE9SSTZPZDA4?=
 =?utf-8?B?MW4yUXRGL3BQTFF2alRCNUZNc1VzZG9lNXlxa0RBS05HT2VoMUUxVzdjNFFT?=
 =?utf-8?B?TjhJZ0JvTDc5dnhubmg2QzhkYlNyN2MrSGdmQnhjSzN6dWJ5VlBxMXI1Z2hy?=
 =?utf-8?B?U3hFYllxYk1uRFBJbStOOUhweWp5dENkcXV0U1luRjg1eWo1TmNFV0VRNE1h?=
 =?utf-8?B?VzZPVGgrajJpTDF4Q0IvcHRFZS9QQUwrYm5HT1Q3WHQ3eUJtbXFMSWsxN21G?=
 =?utf-8?B?TzhWQUZuMEphMFJnck16WThyMlFUdXFySnFNNFlxZ0lqcmlGalNpdS9WSFFL?=
 =?utf-8?B?UWJyZWFPS2RRMUs1bE5BUm0zNjNKT2QreWw1OFh2dTVieFN1SUVqa2NCWWts?=
 =?utf-8?B?bGNJNEcrenZkSWdWQjFSMnVJeVo5cVFUNWFES2xPVENSZUE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OUZocEczTzdiM0tjSndCTFRYZWxRNlYzR1dQSE1rVDNhQ3dCTE1ycE84RndD?=
 =?utf-8?B?aSs2YVhvcHVMam5OVnZHUENOc2tTU0dPRHlURnpudWdPN0NSYzM5OTNUbTMy?=
 =?utf-8?B?ZnowL2k3WHlBNCtMb01RQ0tXZVdOK1pzbU5VNWN6NUZGZHhsVjBWT2V1SFVk?=
 =?utf-8?B?dldIUUFvM1Q1aGI0a3NoUzBVblZ5R1U4UFhwVGNpNCs5TDZ4b1p0VW1acVYy?=
 =?utf-8?B?YVJodTVWcnB4bE1DZ2tzTWs3YU4vMUtFdCt1Zkt3aThvUUV5TXNxTGNYZktN?=
 =?utf-8?B?OWNuVlptQ1ozbDJ2bzhIaitIMUhubVZ5NUh2bXBaM1BzMWNaemdPNmp2SVU3?=
 =?utf-8?B?bzZLMU0vN3dkNGdhRTBzbWhUMEF3T2hMZ2dQOUpLeCtwNzFCd3RJRGRaNWw0?=
 =?utf-8?B?U09KY1B6cFFvSndLQUJwa3NNOHNRR2RNbk5hUitJL05iMUZvYXN3M1FxcHUz?=
 =?utf-8?B?Yk9GbFYzRm1Yemc4N0IreUh3OHBzeG00YkFYZEJydlRxMmFUdlBnNXk1dE9V?=
 =?utf-8?B?czJHaGNBRkVKMExxWjRJOFl0bVJBbzI4ZWcvMHpiaThBTnFpZVpsR2l5L2w5?=
 =?utf-8?B?TURETjV0TFZBd0xkelRrSkdVbUFVQjJFbC9MVnhIZGcxcVlXeG9UQXBrTVhS?=
 =?utf-8?B?eHFhanZjZDVScmxzM2lTeGw1dENSTTV0Q3FNMjVtd3JtSUxHQXpvWndXTFRH?=
 =?utf-8?B?czJ1L3V4L2g0YXh0Q01BRldRLy9aYkxkc0dzK1c5dGxPdHcyOTYyWkNUVGZP?=
 =?utf-8?B?L2l3ckRTZVdQWGUxY09wdHBkdTd3WDFFWE1VWlpyTURhcWl5bU54Y2dTWk5k?=
 =?utf-8?B?Rm1nSUo3WjdGTFNsYXJtSEZROVMzTXZ2Y0psZEZFdE9UQ3cyZEk1SlVDSUNL?=
 =?utf-8?B?aXgvR1pSVUo4bDhISlpESUdpRXdnVmIxYUJ0NThUZWttRnhJT2c5RHAvSkZs?=
 =?utf-8?B?UjlPd0ZQcjhNYVVYNklCcDNyYmxHc2hDRDNBazljSVgvZnpibGJ5NEduK3Bn?=
 =?utf-8?B?SVJoVTJUbHJHSVFXaEVhKzNXc0FUb2NkaUhMSkUzN29iOWVYZUdZSDU1TWpS?=
 =?utf-8?B?TkVEVmlWRjdjZ0ZQa2RHNDk5MlhrekcyOEhydnNpTWlFeFM0Sk8zYnhSZklQ?=
 =?utf-8?B?dWpEcTM4TWpWbmFVWkp6MGdYWEkrcUdlZnRzS0FqY2R0YkdrVGJtR3lEWVZo?=
 =?utf-8?B?SFRjSjJDQVBwMXdsNHlGN1pyK0U5VWUzRE1aTVBoYzdHZUd6WERyQnFiclhz?=
 =?utf-8?B?all5endxOUZTZk5saUhuS0tqU3ZmUkt2YkVOOHg0N1hwYXkvWjJKSWtnMGVy?=
 =?utf-8?B?cVdLU1VCeHBPYzF2cmNyaXppWlhIWTQ4OFNtQlJZYndXSnNvUmgxTVA3Ym1Z?=
 =?utf-8?B?K2xmRVlKN1lWbHh3YjFDTERBYzFqZWtnUlNmVjIyQUs1U1E0THZTR0djUy9s?=
 =?utf-8?B?TnlVTTR6RE9aNDBSMWlXSTh3cll5TE9pNDUrditjdHNUTnZXbEFJNWl6SnVu?=
 =?utf-8?B?R0tBL2U3Vm0wY1k2b1gwdHFmQ2hFbmE5OFpDcTFwTzJqeDEwQWQ1NmF1NC9F?=
 =?utf-8?B?MGcyM1psazRmdGRaRGR2aDIvdXh6V1FyRTduTEoyeGU4WVNQcDVzNjkvTnhP?=
 =?utf-8?B?TFR6eTlickthWERpcDQvMmJMZkV1dnFCQnBUY09pT2s2Q28xMDVSRHV5K0JE?=
 =?utf-8?B?a0YrOGJjdWI5MVNrQ3dhUGNiaEJUa3FHTFBtQ0VMaHJROEZNYW4wbkZyVklH?=
 =?utf-8?B?U1dOY2gyVUJoOEQrRllzaFI4UVhJS0FYNWxJeFVITUVFRnBwRWdRTStiVmow?=
 =?utf-8?B?UE9Rd0lQaEhpdEw0bHFiQ0MvOGtzVUVIbW5UbEorTGw0bDdyOE9MR1dVUDIx?=
 =?utf-8?B?ams5K1I2bXllMkt6ajJ2ak1hRDZwRjJHRnRPUjdBeG80MzRwQjF6Q3REYnRU?=
 =?utf-8?B?L3VSYzVub0hMUjl6TXBxWm1YU0ZDQXZibGd1RC9XcW1uMTZISHE1VW9FRHpC?=
 =?utf-8?B?c0prQkxrQjcvWCtnYmhIa2d0aDllSXJtckk1VzVHRkFENTdkYU1uUTQ3cm1G?=
 =?utf-8?B?VVAzTkI3QXl1SHBhbjNwNTRxV0RjK1pMcnJWM1BoR0hrekFHY1JkcTZLZ1Iy?=
 =?utf-8?Q?wYOY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2306c555-2115-49dc-bb5f-08dcbbaad26b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 15:15:53.0303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k78ry2i9Nu/pu9P7WKtueN2lrLyq0ueZOg/lcdBy6rONDFIQxP2bMEx27aUtkL0uqQfEugx/kl2wsXOogbBMiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10623

Wait for the controller to complete emitting ACK/NACK, otherwise the next
command may be omitted by the hardware.

Add command done check at svc_i3c_master_nack(ack)_ibi() and change return
type to int to indicate wait done timeout.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index fbb6cef405577..0de95f406c95b 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -384,10 +384,12 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
 	return 0;
 }
 
-static void svc_i3c_master_ack_ibi(struct svc_i3c_master *master,
+static int svc_i3c_master_ack_ibi(struct svc_i3c_master *master,
 				   bool mandatory_byte)
 {
 	unsigned int ibi_ack_nack;
+	int ret;
+	u32 reg;
 
 	ibi_ack_nack = SVC_I3C_MCTRL_REQUEST_IBI_ACKNACK;
 	if (mandatory_byte)
@@ -396,18 +398,31 @@ static void svc_i3c_master_ack_ibi(struct svc_i3c_master *master,
 		ibi_ack_nack |= SVC_I3C_MCTRL_IBIRESP_ACK_WITHOUT_BYTE;
 
 	writel(ibi_ack_nack, master->regs + SVC_I3C_MCTRL);
+
+	ret = readl_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS, reg,
+					SVC_I3C_MSTATUS_MCTRLDONE(reg), 1, 1000);
+	return ret;
+
 }
 
-static void svc_i3c_master_nack_ibi(struct svc_i3c_master *master)
+static int svc_i3c_master_nack_ibi(struct svc_i3c_master *master)
 {
+	int ret;
+	u32 reg;
+
 	writel(SVC_I3C_MCTRL_REQUEST_IBI_ACKNACK |
 	       SVC_I3C_MCTRL_IBIRESP_NACK,
 	       master->regs + SVC_I3C_MCTRL);
+
+	ret = readl_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS, reg,
+					SVC_I3C_MSTATUS_MCTRLDONE(reg), 1, 1000);
+	return ret;
 }
 
 static int svc_i3c_master_handle_ibi_won(struct svc_i3c_master *master, u32 mstatus)
 {
 	u32 ibitype;
+	int ret = 0;
 
 	ibitype = SVC_I3C_MSTATUS_IBITYPE(mstatus);
 
@@ -417,10 +432,10 @@ static int svc_i3c_master_handle_ibi_won(struct svc_i3c_master *master, u32 msta
 	switch (ibitype) {
 	case SVC_I3C_MSTATUS_IBITYPE_HOT_JOIN:
 	case SVC_I3C_MSTATUS_IBITYPE_MASTER_REQUEST:
-		svc_i3c_master_nack_ibi(master);
+		ret = svc_i3c_master_nack_ibi(master);
 	}
 
-	return 0;
+	return ret;
 }
 
 static void svc_i3c_master_ibi_work(struct work_struct *work)
@@ -871,7 +886,8 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 			if (ret)
 				break;
 		} else if (SVC_I3C_MSTATUS_IBIWON(reg)) {
-			svc_i3c_master_handle_ibi_won(master, reg);
+			if (svc_i3c_master_handle_ibi_won(master, reg))
+				break;
 			continue;
 		} else if (SVC_I3C_MSTATUS_MCTRLDONE(reg)) {
 			if (SVC_I3C_MSTATUS_STATE_IDLE(reg) &&
@@ -1145,7 +1161,8 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		 * start.
 		 */
 		if (SVC_I3C_MSTATUS_IBIWON(reg)) {
-			svc_i3c_master_handle_ibi_won(master, reg);
+			if (svc_i3c_master_handle_ibi_won(master, reg))
+				goto emit_stop;
 			continue;
 		}
 

-- 
2.34.1


