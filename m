Return-Path: <linux-kernel+bounces-187363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CDC8CD0B4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1D8281166
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BED61448FF;
	Thu, 23 May 2024 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IJe5wlnn"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2062.outbound.protection.outlook.com [40.107.6.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06701411C2;
	Thu, 23 May 2024 10:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716461555; cv=fail; b=B8Wh2ucjVafArqhu+iA9/jYvTl9r7+jrF+yKeLmxmwHlkKuzvKF3w65FgCrUjzSDWN4Ef9Mno9PU5SBPdfSqVbeBcDBA9zpfTxt8Ubqm3ZM0cwdfVoKBMMcXkrKCUpBy6OtOarWbpokYNcsDqBUQQv3yKTIDigVFZJ7xOogXEB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716461555; c=relaxed/simple;
	bh=EUeRLH1u3HnFhFGQ8WFYu1U3Bzgyf144085PpyjlZlA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YohDgFYyQiB+Wn8SildhPodOimEO5fvnZio/Njm43WEEFvOEEWrq+ldOkQF7vBZPihTIW5shloVBdnEf91z/oxgDDnp1CuLRu3HiF731hJIwe7HkVjl+FGBqKiIAnWP0+e+Hqol/faZ5F//L6Bf+lyKajnNOPbLRkuiStgqsiAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IJe5wlnn; arc=fail smtp.client-ip=40.107.6.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAWCVR6kGYtH+9Cwuaaf4ZWvlmXSA688P+WP5eFbn9abj9Yz/fuEdr0Cl4ckxUjqHTQx9VjyqzFPT7UDeNjMoxV+2aLgHS8CbPADmnJ7Y7Sk5NP/9ibvDBU6L9ux+WA2RXEPRDUYpFJIqpWMi6zjuewUqhvGnjj29CHuyuqUXS/4mMUKkPL8FVQrSjj/HZ8XdAtOU1BT8Wicp1/abUaajNvz3CwgZpouVqU5ygJVYa74bkS/nEe7TUVGYEsWeXTLg+BcVS/mNhR5BvQWMFxH6e3SgawkJ1VMWi8zIr0zBlNN33WsjyrX3bbD2iSStULMTvFLPhYiXWZ/zXV7dkihMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUUkBLMg0O8LrsxQpmu3PouhOIOH0gJxqVubz2X/YPI=;
 b=YLozlUIYH7KQc6hZIBCpPc6nyv11TWiNRCTSBahx7g/UTlT/eaOX5A193sy0HAz8wFHbrJgvGM9KBV8fWA1sMR70MGbQfmQl9u4bwg6ByDGZvDyBM6yDlNDW0w08JyMHTx8wFNRaEZCnHG958LU36K4hlX+3mifjURsYaLpj2gHKxBIirpj1gVWty2rwFL9L3uVdgawI15EAQYCyVydRFgZrONHexu/IwQo7Ce9bUCV4WhoNin6NPe37VBlMFiWgGjQbZW9X0KK4AZ6QUxcaLfH7ADAiX8Vs2sZcQ0UzT4zvN1NWwJbAWoYHOofoXT395PfWXaSXfH1vHZABgYqPRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUUkBLMg0O8LrsxQpmu3PouhOIOH0gJxqVubz2X/YPI=;
 b=IJe5wlnn3qXoxhTn+lEotQQy61vBRuFjLxcop71f1tisPvxN7bs73eS0yStawiSTkPl4AGzepUnBW1ts+FvjitulA7wm4f42x9mFILN6YySdzf5xTNGhXkclAi2+bn84ipS+BjBn9r4XGbRcjyFptzoBgbv0ddI0NCX6nWQgQs0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AM8PR04MB7474.eurprd04.prod.outlook.com (2603:10a6:20b:1d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 10:52:31 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%4]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 10:52:31 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Thu, 23 May 2024 16:19:32 +0530
Subject: [PATCH v2 1/5] Documentation/firmware: add imx/se to
 other_interfaces
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240523-imx-se-if-v2-1-5a6fd189a539@nxp.com>
References: <20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com>
In-Reply-To: <20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Pankaj Gupta <pankaj.gupta@nxp.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716461396; l=6534;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=EUeRLH1u3HnFhFGQ8WFYu1U3Bzgyf144085PpyjlZlA=;
 b=JkxurDtEA24/RbdCmoLqw5ywhcljghkKxJbkhG/Hm2EHk3zy/Pd2Th3/l4eo0X3EQjR1UaAGp
 cHqvV8luWZKAfN4Ow7v0cQ5BdcglbHQZK1qnuFm8D06redlFXauDCIM
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|AM8PR04MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: aacb6be4-5423-460b-f759-08dc7b1671dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|366007|1800799015|52116005|376005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWlpeUhNVmQwODM4QjFZYjhJemVZRWJON1JrNStGWWRrMGFpanpFdjVVM1dH?=
 =?utf-8?B?MDFKRjE3ZkoxNHdsWFBFaWhMSEUvZTU2RHVFQUFRdmZYUExTRlF5cjZVWFV0?=
 =?utf-8?B?ekVVWUVsRVdzcWMwdDJvenVEenRzeEsvendLT2xya0NaMmd0enpIdXppSDgy?=
 =?utf-8?B?eHBDODlxdmF5MVJpdU5QU0lPN255NVZ5RDFub25KOCtXNUJKdlh3TWZtejRp?=
 =?utf-8?B?L0wzWGFMa2ZFKzJXeVdIRDh1NXNwWkNlcEpPc3JiM0JOd1hqUGZyV0hVQk1r?=
 =?utf-8?B?UzNsRHdGd1NrR2JzTnUzSDJMQlhtSmlLa2RkaGFJNVpKendsM0w3c3RIMzNm?=
 =?utf-8?B?MHE2Yit2NVBLbkZESUVyQmFrMXRQaUZhOXAxN1JZRGFRNkV3NjJQRGZSa2Yy?=
 =?utf-8?B?dkdEdEMyYTllTDBYK2pXdjUvNUNtQ29JbG1HbEFQK2IzalRqbVpmcXFOWlFz?=
 =?utf-8?B?bkk5TzNsckpKS3JTMGszL3IvamZ6cVRvYnZRaFR3QkxnQ0JGZW1ZMU5Ed1or?=
 =?utf-8?B?UENCbkNmUDd6Z3dudnJVVTAya24yRmxkcHFOdmV3NEg4YXFWc0d0U05DWFd5?=
 =?utf-8?B?QWJxR1lQS2tRVUdTa2lVUTE4enc3bk5GU0JtL0FwL3I2WndUWDJZOWhTNzRk?=
 =?utf-8?B?N1Yzc3BOdi9EZ0p5Nk1Oc3BsbktlbC9wSy9ONFNaU3YrT2xhaXc0RE03Zk9q?=
 =?utf-8?B?bEJTZXlnV0FuYXZ1RitPOGxXVnRZQjY1b05JTHFMUmVjZVU2c0lTa3NkaFl4?=
 =?utf-8?B?STBMWlNSZlBpZm90bUZKdUZnRGJFRGw4azJhOWQ3aWhnRUNwc0FxRWx4YXd6?=
 =?utf-8?B?cmxwUkFicXFST25KSWkwZEMzRlBSWTNPYVFYeDE0V1lsYUZ1eTY4ZWVuWXRS?=
 =?utf-8?B?ZWJIdWdrNXFXOE5TMm1iRlZtaHFlNldHOUpST0gxODM1VERNbUlLcTgrTzJ3?=
 =?utf-8?B?SnNTb1dEcUZNRnlZQWxHcnVUT044SVcrL1QyRU8rOHJ2L1RGNkNZQU9FYy9E?=
 =?utf-8?B?QzQ2dVVaVk9LVVNlNUprVnVoUmFhdnFFOVRMaFVVLzQvcFRpQ2RQQ1ZDOUJT?=
 =?utf-8?B?bnlCQWVxWm5Xc3lVckcyL1dYTlcrYTBMdmpEbVV2cURvL280a3VkRDh6QzIz?=
 =?utf-8?B?S1lvVFg1UUxwOElxT21VcFVHUHd1am1HOWZtc2Z1ZUtWU29IQWs1NS9FaVh5?=
 =?utf-8?B?eDcraU92QnlZcmxLYVJJaTFVWTBsVkg4MVNGYUJXQ1lYbG40U0t6bGM3bita?=
 =?utf-8?B?Y3pndE9xdjAxTTgxZ3N1UlZzeHRQZDV5ZXcxZUJEbk1XVkJQUExBbW5hL0p0?=
 =?utf-8?B?Y2RQTTR5MG00M1lUWC84VDY4Z0RIT3dXeDB2SEM0VFNNQTR4VHhpM2U0T1lW?=
 =?utf-8?B?MS9oZit1WGo0aENoMC9sT2xUVmxYbFRhZWVGbEw3L05KODBHbEk5cE1RMWZC?=
 =?utf-8?B?VldIQVZMdGlXSVlObHdBT1QzU2U0Tnc5ZVJrTzlJajdOTDZZYVAwSVQwbDV0?=
 =?utf-8?B?VUFGWGhBczhhUlpnL1BPazBiRW1kTzdYcUhaempweVZmcXRmQm4yZWlvU3k1?=
 =?utf-8?B?SGk0ekdEWm5uZXZVNTRnVkZJR3JqZG51M083SnNEM0t5NGR3S0xoTHpZL095?=
 =?utf-8?B?MEN1U3hzMGZBS0VZMm40a01OKzk3VnN2d1N1azUzTjIxekRvN0tJL1JDOWEx?=
 =?utf-8?B?OGFrWXV5YmtncEY1bE1KelE1UjFvQmFGL3V3M004YndaWlFtMUs2NElENXM0?=
 =?utf-8?B?RWVwTGFzOU82RE9XdWthZThUZklITm83Vnlpb1JvekZxNDk0QkZqNVI1WG5F?=
 =?utf-8?Q?oCLlD4di7Po+0Z2qfvQ0UxDU0M50jgxIowwcA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(52116005)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzBUTlFUVkZUVGVjTDAwbS82UUtEcVp3N2Q4azhRNi9NUVVleEVnQURSNmpn?=
 =?utf-8?B?NzA2VGRuSno2cFpub1hZVjkvMHpqdnhXOTFGTHIyb2czWHNMUDJVNWNDZkZo?=
 =?utf-8?B?a3Ura2cyNEVVaE5FazRVT3EvMCtJQkExRnduR2lqd1JiUy82UEFNODBMZE5C?=
 =?utf-8?B?bVNnSFluUjZxbVV1SkpTTkxOakNrQk4xSER5REVrUE9RNDZqcTg2c1lMQmEy?=
 =?utf-8?B?STdLdjRCcjcyWDlUY3FrRmlpTy8zU2dqc2tmQVYrS2o3emx3NFVBRllOc3Vk?=
 =?utf-8?B?T2QvMFFicGlCYXBKWTZha2MyNlRNeHRTRHI3NGlLNkgxcXM3TGx6M0h2SXhZ?=
 =?utf-8?B?RnUzZ0VySCtJQlFQRFg3eEJ3d29FbnFxSjZ3SmtSSE1ER21GU2l5VkJkMUhB?=
 =?utf-8?B?YVBZMGVuWnAwQXJsKy90TGpWcTdvQ3lDek1TbHhndUZTZkE4aUJhZ3R6L2RT?=
 =?utf-8?B?R3M4aVA0aTI1V200VDBwWXpNQ2FDR0lIQWRPYjBLMVVZM0dwM294NEYxVERH?=
 =?utf-8?B?YjNIZ1gxcWp5VXROeEZZeFBGd3pBdzdrell4aVZwMXQxUWNqQUtTUERzanMw?=
 =?utf-8?B?d0JEdUpuR0tPQ2l1cXZqZU12a0puZTAxUG4xbys5NXFMM21QQnB2TW1zUlg3?=
 =?utf-8?B?a2RnREc5YTArVzFiNW11MGhNcjZEUE1lQldVRWpFd2o0eG9rcUorY3BuMG5z?=
 =?utf-8?B?aTFzaDF1R3FuT2JWWW55dGJXdE9xS25ySHdmWGNyQTgrbzh0TDZHTmh2VE5H?=
 =?utf-8?B?V0tKSm5Kdm9ETFpoZjl1NW15dnU2NnB4b2dzd25qZTkzUm1kTjQ5U29JQ3NO?=
 =?utf-8?B?NndYQnlvemF4VW9EcVhWZk9ETWdWZStsc21pYWNoSEFsWkwzdWVFRUZ5Mmg3?=
 =?utf-8?B?elpUNi8zZGdPdVBtbkQzZGZ6NEVpNWkyWEdVcE1RSnMzWUJ0cFdETmxPUFpp?=
 =?utf-8?B?V0p1bmU1QURGaUNHUE9RRXRpTWo4aXowOGRoNkVsLzVGYzlBdjlYRjRrQWF2?=
 =?utf-8?B?YkY5MXlLbTRwU2taVWtmZ25ENzI0MEllK3FJTGJyREdMc2RWVWVzVURCMUtE?=
 =?utf-8?B?R2hQRUQ3TXFIWFNUSExGR2EremszZTl5dkt2d0R3allNemh6b2xVY2tuY2Yw?=
 =?utf-8?B?RUkzbis1ODYzWERLRTdoUEU0ejFydU81S2VKeUVPWWZ1b21jOTVka1lIYlgr?=
 =?utf-8?B?REJhU0M0TTA5L2tUSU5JZStkRHpTenJkU1RMK2h2ZUoxejRGbUJMNEpDd242?=
 =?utf-8?B?Y25QQXBjVGttZTAyOE5FTVJLY2l4ZmVod3VTODRVTXkzV1JzZm5XUEJEejJu?=
 =?utf-8?B?bWlOZVVsd2thc0E1T2k3QW9uTmV2Y1k4Sk90MXRJbHk0YnNVbUNYS0ViaTNx?=
 =?utf-8?B?N1NsT2dGVTVPSXdBQllrdkROTGpkYUgrUVFWMjI3Y1ZxWWJ5QldkTVBEUHQr?=
 =?utf-8?B?dUJDKzhqTHMxZkRRU1phTXA5bjBta3llMHVOV0U0NEhuS3NpQkY5UWlDcndF?=
 =?utf-8?B?SVEvNjVZempmUUNLT2RBZmdxYVJOYnJ4TzBSdTYxcEp4QmJ2OXdab1M3YjJK?=
 =?utf-8?B?OU8xYVFjemZuSDNpaWdtZXBjYTlxMFlZbGJmM1ZFa21JMHNBc2pqZjV3YytB?=
 =?utf-8?B?cXFhZE14NTdIMGpILzNUakJnQXZNL0Z5c0twanZNVDJUa1BGcW5ERjlwdk95?=
 =?utf-8?B?T1h6ZWxWcDFDaVNvdDBMZlZCRmdYdzA0RG1NaWZCOUFlQ1BkOTQ1SFhkYVo1?=
 =?utf-8?B?a2VJc1dDZFprY2NsSjlmMlp4aThaV1BxWmZHdWtLSEhLdHE4VkY5b0t6VDBi?=
 =?utf-8?B?bjFHLzdYb3NiWkt6MjFPMFVycTdYOVZETEdTQUF3QVV5QlpwQ2ZWLzJYVXVt?=
 =?utf-8?B?ajczVk11R2Y4bHNqQTJkM2xrVm1CTUxKZ0gySVZlSVpHZzVINHJnTGI1TWhZ?=
 =?utf-8?B?bC9rY0VCZ2pLOUtnT3dra1dOdXJPa052MzkwZnRWRlNXV3hlTXM0MDZEb2xC?=
 =?utf-8?B?UlY0ZXZqSHIyUlJXbjRKaEJjSGg3WnozaFNDZGlPOWRySWRXcDYrUE5nY1dn?=
 =?utf-8?B?NWZYbFZFSDQ0bk5DUExHV21QMGZNTCtBMm42djMzYnN4N0tQZlZRREtLL1FD?=
 =?utf-8?Q?tTq37OuFSl/0BGjHoiFU1VNZW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacb6be4-5423-460b-f759-08dc7b1671dd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 10:52:31.0942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/4C4jPFwYm1GaRW03p6oMvjuZDh1yAy8RTnPcJXXdZLkggIEuCoYSgc5jYeW7ukbh+f1UWYMIQOvNde91bRKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7474

Documents i.MX SoC's Service layer and C_DEV driver for selected SoC(s)
that contains the NXP hardware IP(s) for secure-enclaves(se) like:
- NXP EdgeLock Enclave on i.MX93 & i.MX8ULP

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 .../driver-api/firmware/other_interfaces.rst       | 119 +++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/Documentation/driver-api/firmware/other_interfaces.rst b/Documentation/driver-api/firmware/other_interfaces.rst
index 06ac89adaafb..65e69396e22a 100644
--- a/Documentation/driver-api/firmware/other_interfaces.rst
+++ b/Documentation/driver-api/firmware/other_interfaces.rst
@@ -49,3 +49,122 @@ of the requests on to a secure monitor (EL3).
 
 .. kernel-doc:: drivers/firmware/stratix10-svc.c
    :export:
+
+NXP Secure Enclave Firmware Interface
+=====================================
+
+Introduction
+------------
+The NXP's i.MX HW IP like EdgeLock-Enclave, V2X etc., creates an embedded secure
+enclave within the SoC boundary to enable features like
+ - Hardware Security Module (HSM)
+ - Security Hardware Extension (SHE)
+ - Vehicular to Anything (V2X)
+
+Each of the above feature, is enabled through dedicated NXP H/W IP on the SoC.
+On a single SoC, multiple hardware IP (or can say more than one secure enclave)
+can exists.
+
+NXP SoCs enabled with the such secure enclaves(SEs) IPs are:
+i.MX93, i.MX8ULP
+
+To communicate with one or more co-existing SE(s) on SoC, there is/are dedicated
+messaging units(MU) per SE. Each co-existing 'se' can have one or multiple exclusive
+MU(s), dedicated to itself. None of the MU is shared between two SEs.
+Communication of the MU is realized using the Linux mailbox driver.
+
+NXP Secure Enclave(SE) Interface
+--------------------------------
+All those SE interfaces 'se-if' that is/are dedicated to a particular SE, will be
+enumerated and provisioned under the very single 'SE' node.
+
+Each 'se-if', comprise of twp layers:
+- (C_DEV Layer) User-Space software-access interface.
+- (Service Layer) OS-level software-access interface.
+
+   +--------------------------------------------+
+   |            Character Device(C_DEV)         |
+   |                                            |
+   |   +---------+ +---------+     +---------+  |
+   |   | misc #1 | | misc #2 | ... | misc #n |  |
+   |   |  dev    | |  dev    |     | dev     |  |
+   |   +---------+ +---------+     +---------+  |
+   |        +-------------------------+         |
+   |        | Misc. Dev Synchr. Logic |         |
+   |        +-------------------------+         |
+   |                                            |
+   +--------------------------------------------+
+
+   +--------------------------------------------+
+   |               Service Layer                |
+   |                                            |
+   |      +-----------------------------+       |
+   |      | Message Serialization Logic |       |
+   |      +-----------------------------+       |
+   |          +---------------+                 |
+   |          |  imx-mailbox  |                 |
+   |          |   mailbox.c   |                 |
+   |          +---------------+                 |
+   |                                            |
+   +--------------------------------------------+
+
+- service layer:
+  This layer is responsible for ensuring the communication protocol, that is defined
+  for communication with firmware.
+
+  FW Communication protocol ensures two things:
+  - Serializing the messages to be sent over an MU.
+
+  - FW can handle one command-message at a time.
+
+- c_dev:
+  This layer offers character device contexts, created as '/dev/<se>_mux_chx'.
+  Using these multiple device contexts, that are getting multiplexed over a single MU,
+  user-space application(s) can call fops like write/read to send the command-message,
+  and read back the command-response-message to/from Firmware.
+  fops like read & write uses the above defined service layer API(s) to communicate with
+  Firmware.
+
+  Misc-device(/dev/<se>_mux_chn) synchronization protocol:
+
+                                Non-Secure               +   Secure
+                                                         |
+                                                         |
+                  +---------+      +-------------+       |
+                  | se_fw.c +<---->+imx-mailbox.c|       |
+                  |         |      |  mailbox.c  +<-->+------+    +------+
+                  +---+-----+      +-------------+    | MU X +<-->+ ELE |
+                      |                               +------+    +------+
+                      +----------------+                 |
+                      |                |                 |
+                      v                v                 |
+                  logical           logical              |
+                  receiver          waiter               |
+                     +                 +                 |
+                     |                 |                 |
+                     |                 |                 |
+                     |            +----+------+          |
+                     |            |           |          |
+                     |            |           |          |
+              device_ctx     device_ctx     device_ctx   |
+                                                         |
+                User 0        User 1       User Y        |
+                +------+      +------+     +------+      |
+                |misc.c|      |misc.c|     |misc.c|      |
+ kernel space   +------+      +------+     +------+      |
+                                                         |
+ +------------------------------------------------------ |
+                    |             |           |          |
+ userspace     /dev/ele_muXch0    |           |          |
+                          /dev/ele_muXch1     |          |
+                                        /dev/ele_muXchY  |
+                                                         |
+
+When a user sends a command to the firmware, it registers its device_ctx
+as waiter of a response from firmware.
+
+Enclave's Firmware owns the storage management, over linux filesystem.
+For this c_dev provisions a dedicated slave device called "receiver".
+
+.. kernel-doc:: drivers/firmware/imx/se_fw.c
+   :export:

-- 
2.34.1


