Return-Path: <linux-kernel+bounces-241103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CD1927711
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81211F220B7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAB41AEFF5;
	Thu,  4 Jul 2024 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aCjvQiwX"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010056.outbound.protection.outlook.com [52.101.69.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AB61AEFD7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 13:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720099294; cv=fail; b=jnG0Lfsr0M3I9jdqf9M0XwoAg6nDucUAi6R7XY1Svv3+jzKiyDNCGNI6P9hR03Rty4r0q6IponKqYPv1F4uyf7Cq6EvUQ8szRrjOTYdFDmfTYs+HjLYSAT218ZKujAml3ALrJrh4u0IXzGUIAvb2+cau+PyZa/ycWM3LJEHOlUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720099294; c=relaxed/simple;
	bh=UvJ//py6u04igD8qG8neO2Kzkeg3fYEFwQSQ2MmZYw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gM4qKCnTy1x65sI7eqTgNvlaWJx5zYkigdgdfKieXoSQ/CGUa0HVF1VQhArelNIRqVX3sc10HZq7MMbs2YnMYhvb/wpxvlq6WzolIT/eufkv09Oza+U1tt55ZDOYFSYkml6P0SZLjQcPuy8lTa4Tgo6PZJStqmP9tsT6tVYFC08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aCjvQiwX; arc=fail smtp.client-ip=52.101.69.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aveCuZM4yo7T5WHzAA67gFkOEwPiaNUe5oQkMOh2ttajPnnU5BHEvXVe2d39qdPUisDH18EP5EDjEnz5/bjy/YpE+YteLzAEKUAZ31HbNSLRPvgdIBG4ygwcaxL8JYm6V4nIZRgo9bCeF9HlAYwxr85knPiHHxhZa4U4siUnM96UE0ap9jr05PwY+pqDO9CMqhJ4P0pjBUEA9f9ohoXu8rfdKJlXNSdJHfyUh1cYbz7tEqaDqusM2f8dA4mUa1dXBUvOQS7JjjOr49qP0hCreqQXl4wIqHIsjWfdK527w8u38oefG5TTPUalZmym4yEmoQAaSo9PysJZjgadkuqPqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmzi7pzRdCyBH91BfJgTLrJfH9xHWssBPfiXsqupkYg=;
 b=d/NWvWPCA2oR0eUmYPUUawLllUAbpRTBgjJnmzNcxhJVHJMe7eMXR3eLWaQWIwcGXjlRquS1k0aUUkIK2qC5QdXzi8V47cKu19qyaNrwsnA3Ka61yUsJXmpSzua9u4UzayB4RZWTwZdWvKiWvpPR2sadjC8Cm6/pQwrMc+vDvokiaLuG3AgvXXm2umbNFPiGY5L65kzLtfhcvUKprUcnwoBiZrPgn9VmJSWPhgQ3poa5HKSauunbsOlSoJgvEboOi/sMlBOoWo09d/216qeBL/39/oSA4aALH73Uf9/KPDNvib36nvmwLlUkFMx1G+MsJwDWzqZcmUQ+ZD+B6WUT0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmzi7pzRdCyBH91BfJgTLrJfH9xHWssBPfiXsqupkYg=;
 b=aCjvQiwXDB22N6QH3UbtjfNHu1nYh2YQ1XBWc5mghFqZ24LLiokNi2SsUPnO54qylfrIhRQ2lrlkN23aHKMfMta8Ci96/1qiuXG0hdAqKOx7+QpGzQcWOaYf05HoljbsnNkTiH2Km1pmQyIS1j7vfdXO1m/hXfuvWvSWwIdTpxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PA2PR04MB10422.eurprd04.prod.outlook.com (2603:10a6:102:417::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Thu, 4 Jul
 2024 13:21:28 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%5]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 13:21:28 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>
Cc: linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	s32@nxp.com,
	Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH 4/4] MAINTAINERS: add 's32@nxp.com' as relevant mailing list for 'sdhci-esdhc-imx' driver
Date: Thu,  4 Jul 2024 16:21:16 +0300
Message-ID: <20240704132116.2865864-5-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704132116.2865864-1-ciprianmarian.costea@oss.nxp.com>
References: <20240704132116.2865864-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0019.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::6) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PA2PR04MB10422:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f3abf77-d573-43c4-00a0-08dc9c2c3612
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkdiamtpS1M3OXVqYzQyelUrcnA4RDFiVXRRWnJ0OEhGQVlnV1BRdzdGK3Z0?=
 =?utf-8?B?MXpkZks5VzRrYnYyZW9wRjFtWFlZSnl3ZWJHemYxY0JSb3RNdm84L1RPUnZ2?=
 =?utf-8?B?YTY2eENKdklTaFlRbzF6R2x0SjZNNk53ZkE2YmJVUmVnY1ltUEdaL1RXUXFt?=
 =?utf-8?B?ZFVjUVlad3BERDluSXlLU3F4NjhIeVlBT1FUTm1aKzZNSW5wRmVCeVNJdTZh?=
 =?utf-8?B?TkVPNWVnaVFnNVVkM2E4czlWMHJCbGIvM3czUkNpcTkzd0RvWk5leG9iR3hk?=
 =?utf-8?B?YmowVXYyTzRBalVGNUJjaUM4VEpXeHRyOHZiM3VlTFZJVU0xTms0bFNkZGND?=
 =?utf-8?B?MndqNWFCUWd0VkVDaHZCZTArZWluVDNXTWpMWW1RQ2ppUlF2TmhCd25QMmsy?=
 =?utf-8?B?SkhPd1dEOTh0VGVZSElnMHFVeC9oSlRWQmlla21DZkJtVk03eGFxNzIvcTVq?=
 =?utf-8?B?dnBFZURKTW5YdnpHMWZuQXlpemFhakg3RmZGaFNKTVl6eGFmVUNCazVpcEtV?=
 =?utf-8?B?MzRyQXdXVTFNQk9QTmJBTnVvTWc5TWJ1a2hCZ3VMNEd4QWZTRE15alVtaFl2?=
 =?utf-8?B?UkhtamxPbEpIMlp0Q2RWMlBDc0w2Y2ZPQkRzQ04zL2gxMlN0UXZvKzE4aXRs?=
 =?utf-8?B?dVM3M0lwSStwZWl4Q0RmNmIrVFZIV0FlME9DUzlBeElmc3NsNTdFbXFXMGp2?=
 =?utf-8?B?UVVsVnN6RGVGU3pCVUV0RHp5dnN3eFVSc29yV0lOVjhHZWttS2xHYkVYM0dm?=
 =?utf-8?B?RUVYTmd1eFhWZjEwZFo3SEVUd0tRd3ZpNDhRR1VYRHFwRDNOUVBydStDNUJu?=
 =?utf-8?B?OURmQUZhcG1IR2s2a29DdC9vczJjc214RmFTbzE0NmJ4UlE2UWNGUmlwNUJN?=
 =?utf-8?B?MFN0ZXhYMzFvMzVzSHNGSGFHdFFoTUMvbCtXQmZnK0tQa1FraFlUQVY3eWtj?=
 =?utf-8?B?bWtpTm4wMy84UzhKakFFQkk3cDVBWkpmOW5Jcll0M0ppQU9wVWxFdXI3YXBC?=
 =?utf-8?B?VWovS1Nad09aczFndDRxQkprNjhNejlGdkl3eGcrZ1VzV0tOdytVZ2grck9I?=
 =?utf-8?B?Mm9kUWJXMGE0MEFXbDJyaWFPMnRHWUNFN1hocnBaUW15aXdNcjJSVVRMbXJU?=
 =?utf-8?B?N3VhM3hzaEtzRys1TnBCZm11SGJiSUdxWXIzMEVvVlBqWEtPbncyTHFwL2JP?=
 =?utf-8?B?MGtHV0l0bTE0NExDMDMvQ1ZrYkNZNWhWUGRSMHA0WDRleU1zTkErbW1jYVJH?=
 =?utf-8?B?V0ZXamxOVW9sMmVKanJzc3RzaUpCYUdCbU1rODN0SDVxUTltTlhNcnRVV0c0?=
 =?utf-8?B?R291UVIrQ0FZaUpLNU1LYTBTc0txbm1oV2dwY0txNGRpbDd4M1NBalVmOWZF?=
 =?utf-8?B?TVkzTjlhNzNrVlZ6NjNxekFacFl2TzVrU1VXb0JXa2p2MFg3Q3l6TEpaazNn?=
 =?utf-8?B?MGRQSm1RN0NYR21ZZ1FERk14WkdreDFrMlNSeHArb1lSTXpMQlZ6eVR4dkhy?=
 =?utf-8?B?VmNRaWhYRHhFb0dqNHI1OUxQL3c0YU94Y20rcWlWSU5HeGVGVHdWVVM2bm5w?=
 =?utf-8?B?ZlllRGx1dWowQkVtb0FVaVJxcnlUdi9mRm1zMW9ISnZBU2lNRnlKeDBwQTF2?=
 =?utf-8?B?UEFHNzZ1cGw5aXdEWjJIK2pIM2hzTWpEM3IzVkJoN2FYY0VGdUdlK1lMOHh4?=
 =?utf-8?B?UFVNc3ZRN2sxZm5pVGpqNTUvMTE5UUVCU3pZWlNqQTdaS0JlZEVqeTl6QTJZ?=
 =?utf-8?B?ZWhkUEQxdUFnVkVFQmVCYzJRQzlYblFIMXlsdjhNbHJWMVIxNlh6Z2R1WnF5?=
 =?utf-8?B?UHF3UjN5U1VVL3BLYnhIZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkpHdXR3dlpKNFZWZDE3Y0l4MUM5bmpuazRKZm5xdmxNb0hmZHZFVWtNMHJ1?=
 =?utf-8?B?cnh4SEdIYVdwN1Fid2R5bFMwanpKT1BGSmtOQTY3Rks1SjN5OCtXT1NCdEF1?=
 =?utf-8?B?Sjl1REFSeFROcWd4UjVxNVhocXlTY3AxTnF1dmgwQTRuNnVQaURSampjQmV5?=
 =?utf-8?B?SUR4ZWRkNHBzVzd1L2VGd0NoMnVCYUpDUTdiVTYxbDZqa25HVm4xTlg4c0NV?=
 =?utf-8?B?OVd6RUVqZnA4eHBWS291RzUybnI5SnF5VzFRaTNXODliNHlzVHZVMFNNdUJ0?=
 =?utf-8?B?VlNScmJVK1drdHBVbFlGK3BmeDFiRWFrVTIwV0JWcXRjYWZYVjU1aGdKdHlN?=
 =?utf-8?B?MWw3TmwrZG1QVXowelVmVzhudzFybUhvb3BxZnVDREwwMGdqZ3kydllncStq?=
 =?utf-8?B?UXplV0pSY0VCM3hZTm9aU1RmMFg5a2RhU3FMSGdDa0dVbE9sUTFoaUY5eGM1?=
 =?utf-8?B?TThHdHU3R0o5WENqN1lidkFubzVpQzFTTFVKVUxUeUFqTXpPZTBBaWphTVJN?=
 =?utf-8?B?SGdnTEZOMlRBNUFMbSswTVFvWGppeHQ2QnRUK3RVS1NHSE1BZGxjbEkwUkl4?=
 =?utf-8?B?Y1dEVElLdVFNRkpPcWlyR09qc2V2QllHTndHeHJESlVTamV5d2c4SitQQXBU?=
 =?utf-8?B?eHF5T0t3M1VMQTNwTU55ZFZmbkUvQnBCTCs0ZUczYzRMWU00V0ZxODNXNHB5?=
 =?utf-8?B?T0g2L1pEa0N0c28rbVB0c1hRQkNxbUQ5cnBISXVCQkF6YVVHdHBLMUJWL0ps?=
 =?utf-8?B?VVJ0TXRDQ3BTZHI0SDRzaVVvdEpUeVVlV2xTdWhueXYzRThleWRzdk5lNlEx?=
 =?utf-8?B?SHp2Q20zTXFac2k2N0puZ1JKQVlIeDFRS1VGd3dtSExRdi9wVlFUUnc2UHZD?=
 =?utf-8?B?dmtDZStIWiszZ1JrcnJRY1YvNnVmblhqdDFNeVpHZ3Nyc3RBZ2ttd2Q0L3Jt?=
 =?utf-8?B?QTA3RVhjbmw2RGl2Wm0xa1JicTBnTmozWXlOV1ZGSnY1akRnUDdWS2xLS3hS?=
 =?utf-8?B?cEZRTU5xVXlGakJlQmdTaHRuRXVVMFhpZzAyRytiMkxHZTFhaFNyYTMrdnFz?=
 =?utf-8?B?aTR6dDRwTnZRWXRpTnc0T2lZZVBieWM0bmI2NC9tNzVJMXNOZWxQUEV4ZlZK?=
 =?utf-8?B?Q2tXdE9NRVIvcmxYdVp5OEVLQ0hFZ3lVQlRkbkUzYmIwMVNldlVTSmczUDlT?=
 =?utf-8?B?bGZuM0VlK1hmTDd1SzJRRFJ5QzQ1bkZUNW8zRVZYd2VqWERLN2VGQUFEQlFM?=
 =?utf-8?B?VlRNWmxvNnkxYVJobElhcFh4ZmkwS3VVUDZUWEpiRVQyL2FFM1Q5emhiUkVo?=
 =?utf-8?B?L2RjTmpuNnFmNG54dUJSMkorbTN6NEtwc0x3aDVPbHNoTmlUSUt0eUsybnZv?=
 =?utf-8?B?OU12TVFsYTJ5OEtXNlBQOTUyVm1rQnk1dUxYSlZuZ2lpMklUcVhFRC9DVWJa?=
 =?utf-8?B?cVdnMC9XSU9JS1Q5blhISGVSaXBaM28yYkxhRVVleFNxVkVJdHgyZlhzeEQ2?=
 =?utf-8?B?T1lXUk01Y1BteDh1dFAxWTZqVm90YVZiaFlCeHh0S25vZmREbU1tOFRlTTds?=
 =?utf-8?B?WW9rUFo4b1lDN3p6YnpzQWxvTnd6eUE3NXB6VTdYT1N0RDJLVjk4NEEvNmU4?=
 =?utf-8?B?czVMZm1zNkZ4Y0pzbnc3K2hKdk00WU5TUUN1SkV2cWFYY3VBQkx5cXBRU0Rr?=
 =?utf-8?B?Wll5eW1LUFhpSjdZaWdDczdiUER3aVdBM2xWekgxcFpPT1Q4M3FUYWxwa01F?=
 =?utf-8?B?dlUvWldjLzVoQ2ZjZVZZMWhJeldNbk5Xc1hoRDNzQ1pteFRFamFIME1QNGcr?=
 =?utf-8?B?enprMTlkcEpLS0ptaXlDdHV3clJ3OWpINW5VdWRKcmxqblJuUlBWNUNZQnlT?=
 =?utf-8?B?S0h5bHVpZmd4RnRDcUs4WGJZYWV5ZzQ4blk2OHVqZ1Y1cjB2NExHRTZOYVpt?=
 =?utf-8?B?RTh4NTJqb0gyakhNKzRhSmNTVGRpTXlWbWFKYWV0VCsxdlNrYUs2RE1hNzI4?=
 =?utf-8?B?SmkwdTVpcHZ3U0dYVzBsb2JoRGpxcG1lUnR6VEp1dk5FaDhuSXpuQ0lRY0NX?=
 =?utf-8?B?Rnc0MThUbUQ4SkFHd0RiZDdRay9SVmZFUGhNYXk4UWZyZ0ROQ0orNXppbFlj?=
 =?utf-8?B?M3JZNHAxNSs4VU9qa1Q1ZXZsK2duZVN0dnVvYko1Q2VOWlVKeS9tTGY5cVZ3?=
 =?utf-8?B?MUE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3abf77-d573-43c4-00a0-08dc9c2c3612
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 13:21:28.0860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXf5CRQksQ+vdu1zYd0J0CExE0jNSr4Q/2f+VPTnyHb57P04qP7OGwY0IAFpe2SS9BChBz9HNOykVgEbMMAHvgnzrkSK1utsL1VMTi9FLpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10422

Since NXP S32G2 and S32G3 SoCs share the SDHCI controller with
I.MX platforms it would be valuable to add 's32@nxp.com' as a
relevant mailing list in this area.

Signed-off-by: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a39c237edb95..26b1ec2ba094 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20098,6 +20098,7 @@ SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) NXP i.MX DRIVER
 M:	Haibo Chen <haibo.chen@nxp.com>
 L:	imx@lists.linux.dev
 L:	linux-mmc@vger.kernel.org
+L:	s32@nxp.com
 S:	Maintained
 F:	drivers/mmc/host/sdhci-esdhc-imx.c
 
-- 
2.45.2


