Return-Path: <linux-kernel+bounces-444012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339D29EFF52
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 23:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8FDC16D02F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 22:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0791DE2B8;
	Thu, 12 Dec 2024 22:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EeOys7tf"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2049.outbound.protection.outlook.com [40.107.105.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A751DE8AD;
	Thu, 12 Dec 2024 22:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734042415; cv=fail; b=pXmvBN6IDDjDkkMV+b+hf5QwkJES40wE0RqP2gZwOxEsDfdD7lRLkdknIWhvrfOu/prTwkEMMDMoOrYl15IWuV7xzZxerCQRftbyBTJU/W9R96rQr2+ILysXpIJM6Bs7LXJp7wbTcOO2Gs4E2OIX46+3OIVNqwZvaRTOzuBFyY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734042415; c=relaxed/simple;
	bh=kyLVKsODsOh8bmZpGdapyrX6y/DtJ0+kuJytfVaVGV0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dn5DmuengREdS/J0JQqd99eytMvLh3SwyHhpJplBQ5bwQ5eX8O3wq9lHwsXuiwTHFztouajjAe84aZTMgAJKN9Aen/NfqzJaDEuHjDb+JgYFgA1HZuB1x7N0paUhq27DJ70tOkYDQ48n13OQTOA6K9nYyW46IEl4WjS+Ca1O1X0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EeOys7tf; arc=fail smtp.client-ip=40.107.105.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3GPapnrzCfzWpeXqNZdMTxKK3EcO1UF3u0mhFbnFMirpIhIisZyGGcgCJL2vL7v0g5o3MRxmsA5QS9WsKnXL36JePqk42WYZsdKAl5Dq/m6apNDVbbFkZBf8D6ffYqQsktB+yHXJWYcoQ7sLYc4A/APqno+ExQABcCleYK9DiEfpITcJK9OIalabwpOg6tNxGJPzK3B1BOVj05OBqy2L4X9HfNlNruvxd2fq8GNqZF1i141AirHF46lhFSd5/ykvZHTaLwn25AgR3aoxi5O4R9xNMAjnt8gsJPZlegWMR11py4yXww0r7YVo1nu36jmR9gAUUXrRfE6Q1lXIcgZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chJSHRMdbBt4Xne4EPecQedtDQowzIIQ2Oq1FcDOqxc=;
 b=Wwjpl0eYQtoqHM2PJ9tiTP7spduPbXGIyumSvgfXJ0mrHX/evbMKL9Or0ECUOtJvvAVUF+z5YWQMpwIavjSRN7A7igEXdUq0x2oCRHqj91eJqCHK431el+lCf0m9rkgTjyzt8xjlyhNEgtylQFJ/h3TdUtaawz1WE8OnWNB69I15DiwpZWKCd02vTLcmrZKWE0GntgKpVIsMyzF5aATQ84kgx/YHkO8Dj+XTay2806UPVUUo1/ttWppuXJDGg6yRdslJKApS8ZuZBH28WU/+xcNThs5K8BITklZZyH7xeRZFepYsnjNBxV8296rKVd0jcsKxPv5IhA/oLzuik6iNtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chJSHRMdbBt4Xne4EPecQedtDQowzIIQ2Oq1FcDOqxc=;
 b=EeOys7tfRwXTSWRDq0pFkX4N811ZpIZpNJa9lTb23M+6ttKNprBUlgAEmyPTHqKIGkpEdkaJ/j7ZJQRoRA8xgKgpLdi95Hgylf4x/Y+QyZ2yAVSoUdd/HZ71aCmdGvdxAW9X/GBJvBLtsGqleUOyNVdSYrgYEDOmRB1LCKsRy2W+1DO1QDgkcug9oaxvR4wvtMlvtoJctK8lhG/0TacqmbgLxPRZVKq8G/uKqOC/wYOTgeURCPKf3X19aqDavMA5TouCwYwn856ccGF1qf7QO7/qhMowtbAB2kglHpsHD/u5TX0BhjQyq57lOpvK0gtFQLyfU9xYhOOfYWh5XQq3Bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7061.eurprd04.prod.outlook.com (2603:10a6:20b:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 22:26:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Thu, 12 Dec 2024
 22:26:46 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 12 Dec 2024 17:26:25 -0500
Subject: [PATCH v2 2/2] regulator: pf9453: add PMIC PF9453 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-pf9453-v2-2-f59d2c096356@nxp.com>
References: <20241212-pf9453-v2-0-f59d2c096356@nxp.com>
In-Reply-To: <20241212-pf9453-v2-0-f59d2c096356@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734042396; l=28243;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=2i2JGPmdW6Zd1hfRD0XfBCHYvbW5Dc3oK2kCjT2QJVg=;
 b=auWhnIO5hhOkbwsU2KUuoLnMy73ksxwssbuz1ZtwosLVcfgPFMBsSRnVnsYVha4nutNGuBexU
 9lcrgP1FIwyCWl0aI+pY+yUGbbfEoVAq4o5ijr7u4m5699CkAa8caOs
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
X-MS-Office365-Filtering-Correlation-Id: a747033b-6ad2-478c-8b7a-08dd1afc1049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|52116014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjNnQkRjem5YVGtpVjhXa3pwUlZpQlpwN3hFem42ZGtCQ3NiY1VGZ2FRZXN2?=
 =?utf-8?B?Si9SekgrZjlCMlF3ZDl6RndPSkV3a1E0MGRSeG9aLzBjZjVQeTd4ejZ1UmJK?=
 =?utf-8?B?V0ZwdStoNzVlMWNqYWNUckZvMnRUY3N0TDRlcXBCeXNnQ2hkWmFTREZQdXdz?=
 =?utf-8?B?R2xOa1oyOE5wTjRPL0haeithY0hST3kxM2dHcHlMSWp1aDRRYno1ckFFblpy?=
 =?utf-8?B?UGQ5R0F6QTRjaURpSGY0aE00QUpyTC9mRllqWXRLLytvLzlhSUhwZ0RPVEtE?=
 =?utf-8?B?enpOVDBxamxNbGpDRXRMZ1J5UUo0cVBSRmJXWUU2WUg1cVhmcEVFa1Rtbjgr?=
 =?utf-8?B?blF3ZFVwb3pWWnJkaExnL1dmUTRVRXc0R0ZTaWh4RlFsUkFicUcrTmU3YTBp?=
 =?utf-8?B?RWQ2T3NkMFJsSFZDTDZNanBocERQTHpKMktkb3pwQm5OT0lxOC83TzQxZmh0?=
 =?utf-8?B?dE5kNExGWk1Zc3lVbFNiYm1wUWt3SVZSYm4ybWxRTDl6a1cvUE5kZUFvTHk3?=
 =?utf-8?B?R1lyNjNhNzhOa1Q3aHVOMGkycEJwV2MyY1UzSHE4QlNBSnA2Nll2cHlrOHFY?=
 =?utf-8?B?OWJTWm5JUlJncVE4L3kyaW02OTRYdmtFZmkzWXNHL2hjbVMrSllJZmcvd0NX?=
 =?utf-8?B?Qzkwd1dVZ1d4TStBY1RTbk1uUXlsSk9KMC9uT0d4S05udS9lUUxHYTBudnl3?=
 =?utf-8?B?eUY3WUJaR3FzQjJ1djlmZ3kyM09tUHZSQ1FCMnU5TjE0UU9GRGs3eTk0LzNR?=
 =?utf-8?B?Nit3MEk0QWFuMXNmUzZDSGMybCtHdkFLV3YxazV4cGsweGNLSUg4dGYrUnJ4?=
 =?utf-8?B?aWJPOUVCLzRYTWZPTWY3NUpXMkJ4aFYwREJvb0tTcnlHN2ZlUzA3dEc2ODdt?=
 =?utf-8?B?OGpyUmRVeFhnSGw4Yjd1QXoxak9GcC9ySCtyVDF3WC81ZE4xcXBnZDlHSFZI?=
 =?utf-8?B?eGIwRjVubkoxZ2R6MkVsKzRWTE9kOHA4ck0wZjRZRk9ZZnhqUEU2WW9NY1g1?=
 =?utf-8?B?K2VNQXhuWW56b0o0SEk5YnhYbW4ra2hheklnMC8ySDFpNVZyV2VEcTlxa0N5?=
 =?utf-8?B?VVQyT0UyMm8zemVURkhJdHZrMDJWRzI3QW1MWHppSVA3bE9DRlRuSng2bVkx?=
 =?utf-8?B?dWFxMzZ1MS9xbGw5ejBuVDRlT3BlUGhlbjVuemptN3phSWtwWWhlYTFSL0xY?=
 =?utf-8?B?cmQrdCt4UXc0TEdkWUVjc1QzZXhNWGF3L251ZzNtcWNaUCtoSnRHamEvUm00?=
 =?utf-8?B?bSs0cGlYL04wR1RjSERyTjRMdmlHTVVtSE9pMCsvUTV3WThhZG9taGRmK0FI?=
 =?utf-8?B?NkkrcDBJWWhEYmpsdm9vaUN3SkNtZ3k4Vno2UEhRaXN3NWZWVmVCNFhBUEI2?=
 =?utf-8?B?dkZhTnYyeExvUS9PWVpmblRkN01YSGVTTmtaUXFiR3BsSUMyelZoTkVBUUxj?=
 =?utf-8?B?TzM2djQwSnFabHU1L0twR2F1T1M2TXlvZitrVkZ0Z0NhaGxQTWk5bitROVZQ?=
 =?utf-8?B?UWlSQXVzVHVham16aFkzeG1DUW1odmNKWWNJem0wVHlESmViN0FXVlJ1Zk1Z?=
 =?utf-8?B?ZkZnMHlXc0JhSm9CRGdMcjRwREVLVW1LYXJGM01CY0JSSEtZQWRCYkxLSENC?=
 =?utf-8?B?aUNhWGhFeittL1dRNVloTnJjWW5kY1NuUFBHSlkzQ0swTEdnMSsxMWtMNS82?=
 =?utf-8?B?bXk4ZUFuVmI4bTZGN2t6ZUZGaFZvU0xMSDhGVGlhTnJtZlp1SHViNHQrYWpF?=
 =?utf-8?B?MFlTT1VRUEV3RGE5Q3ZMd0hLa2xzSmxXUCtqZkJXRXozUUY5RGxnSWZXRS9G?=
 =?utf-8?B?eXdWcko3WHBlcHBQcHdBZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(52116014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0RUanpONklGalppV2VjWXYxVGtMaGVwZTUvdzhja2JJcHg3N0JFU2xycmtn?=
 =?utf-8?B?TVpTb2tyWHhSbm9POGJ1UzZtTk1YVldSaG03ZVd2ZWlSWVQrZitldVVKcGNm?=
 =?utf-8?B?bys3Q1VtME5hbFVBazR1ZFE3YkNKdU9oNkhqV0V5MTUzdGk3SUwwWi9NdEg0?=
 =?utf-8?B?c2g2czNlVExiek5Hbk5HV0x0L1QzSXRWOEFJOUVoL2JiOThUMVZCd0kybDdy?=
 =?utf-8?B?Nzd6aFBTQmk5QVEwaGZ4YTJQcjV0bGFTZ3dXNS9UeEJJbGVBWEVkQ1RoZXJE?=
 =?utf-8?B?ajlrTERlWThXK0JBTkNZKzJScThwQ1ZJbmY1RlVFRDhxNzBPZk1BamJ5QnZ4?=
 =?utf-8?B?UWdTMmxzMk9ES1RaVHVqaGFUUWlDa0paV3pqdGNPaHlkbmdUT1JwcTF0bys2?=
 =?utf-8?B?TExJZU1Sbm15T2lmakNZdFNrUlRqcXk1cTNHMTlMSlFxMkNwMnFkS1hiRTMx?=
 =?utf-8?B?NEdoZHh4ODVHME5zZngxdllmS1c3emZBdndLRkZHdHA3K0g1U09XdCsyMTJx?=
 =?utf-8?B?UDJpVXh5c2JWM1VFSStIZXQwenNFNmVraElRNmtJMkRzMFhteCt4WWdvcVpp?=
 =?utf-8?B?QlY0Z1kzbTJ5VjJMOFBmVmJON0dLMXNINm9jNEpOSzJJSEpWY2NCSmJ1UTB3?=
 =?utf-8?B?RXBnMWtaWWJ0Uy9pRitnNVJGZjZDZi9nQ0hWQ2VyN1dtbzZHbHBKQWNvOHNY?=
 =?utf-8?B?dGlHMHNnWHoyVTJLS21IUlhNajBPTjRSYjR1OEFFRytVRzhkMWVyODRtSm5I?=
 =?utf-8?B?R0lUR3Njd1ZRSmNJN2Q2Yzc3bkRucG80Qy82R29CbjhVT244K2ZLVzYxSkhY?=
 =?utf-8?B?T2ZXWlNjL242Mnord1RVZ25IY2pzdHJPNlNKZnNyb3l5VklXeVdONTNJWkpC?=
 =?utf-8?B?ektaQ2RrR1N0N2tDZjR2c0RzY3dPamVuc2ZuSHNEdW5yS3dDNUl1a2pKb0lT?=
 =?utf-8?B?ZUxGTHFLSi83dUNtRER6R2dMUC9RdXVCK25Tc3VyV25uK3Q1TmNQYlVpcStn?=
 =?utf-8?B?VXpIY1M5NE56bllhL3djcnlFNDhsQUM3Snh2K3JVbHdUR09iV1Fucm8vV2ZT?=
 =?utf-8?B?VEN1aGpMMmFKNzZkcGZHeWs1YmNKY2xaWXAvQ0tJTmx6MFdiaDNVNFJRZVh0?=
 =?utf-8?B?K2kydU05aUcreTZmK3ZybTZ1aGMycnAzdWNVZGJZbi9YWGRZdWpsTmRpNElZ?=
 =?utf-8?B?Z2FCbHExdWtmVkpUZnV3TDA4RVhmRUJDQUNzMmY1SUdmV2NlTk9BSmVReXVm?=
 =?utf-8?B?eEN3NWltV0xvVFN1QjY3UW1TaUU4WnB2MWhBbnI5VlIwMlpaUjlFSmRVNWN5?=
 =?utf-8?B?eVo5L2liSE12YjQranJldlRrc1h6eVU0YWk1OHp6UXpTTzQzcm1wSkg3S3Q1?=
 =?utf-8?B?OW9ONFlrdVBBNzNwS2ZkTFY5dE5UbE1FUmFJMEJqSFlQbnRNWXA5TEVIekNE?=
 =?utf-8?B?K3h2emdFVW4rV2xZM21NNzBjelNadTEvK1BxNG5DL2drL2g2cUtOVmJyejdC?=
 =?utf-8?B?alI3cE51MGNzZnk5aGZGRzJRMEdhenh4RTVaVWhVT3V0UW1mUVNSS21zdEdB?=
 =?utf-8?B?bW1HalJjUm9SRVYyT1NJMHEwbGtmVUwwV3gxSkxhRzVTWTZVZ3VvWTBIUDB2?=
 =?utf-8?B?d0NscDJySmUvVjV5V3RFWDJsQ1RIMWovZWY2QTU0T2FYcVFoTnJmWXh0ejVw?=
 =?utf-8?B?WXpXMDczOGpOL0svNzRtUExTT2x4TnFyRjhyOHJBQ3BmUmg2dzE4M3c4clhy?=
 =?utf-8?B?L1N2VGRGOE0vRCtBdFRBbW1HSklaRFlveWxmL3Y2KzBlaUNLVjlaN3JTS3h1?=
 =?utf-8?B?YmFGT211MitYcVJ6cGVZVUhILzRZMjNTMDdSUjZzRnZmUXlPaGxEVGdQR3Nl?=
 =?utf-8?B?OWEvdlhWSTlwY00rbGlHVXR2K2FMRzBEQytDSFFXSFp4alBmZHFVTGp3Y2hP?=
 =?utf-8?B?K091RGk1bnpNSFQrVmtOc2htMFVOZnZVcDUrVGNuMlpnVlIzWkRaQy9HQ3hY?=
 =?utf-8?B?MTJVNHZROHhka2Y1QlVhay9XQkptenZzaG8xeDhCZ0Z2Nmx6akF3TlZXdUZn?=
 =?utf-8?B?OHVqTFJONHZJK0plY21YWHZLS2E1VU9iMXlybjU3SU0xVG8xcDhvazExUVlj?=
 =?utf-8?B?bEVlSDZ2eGZZdFE1czJhd3luOXYwTHNUMFVnQlhISCs4YythbVBqUHJGdThN?=
 =?utf-8?Q?DaBgdgjUL7+vP2oKTksQX6mc0mFMBulLFYJ9fq3RgXyx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a747033b-6ad2-478c-8b7a-08dd1afc1049
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 22:26:46.7129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncesMoTRABlM3NZ0pkVPNCmDJzGIUFmF8BZkYQGsN1sTnZniiq+nkdHTkZ9+vMS5IB9zmRWwTaE3pGo6EnJSRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7061

From: Joy Zou <joy.zou@nxp.com>

Support new PMIC PF9453, which is totally difference with PCA9450. So
create new file for it.

The PF9453 is a single chip Power Management IC (PMIC) specifically
designed for i.MX 91 processor. It provides power supply solutions for IoT
(Internet of Things), smart appliance, and portable applications where size
and efficiency are critical. The device provides four high efficiency
step-down regulators, three LDOs, one 400 mA load switch and 32.768 kHz
crystal oscillator driver.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/regulator/Kconfig            |   7 +
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/pf9453-regulator.c | 723 +++++++++++++++++++++++++++++++++++
 drivers/regulator/pf9453.h           | 171 +++++++++
 4 files changed, 902 insertions(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 39297f7d81771..74d11ca2d9bee 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -981,6 +981,13 @@ config REGULATOR_PCA9450
 	  Say y here to support the NXP PCA9450A/PCA9450B/PCA9450C PMIC
 	  regulator driver.
 
+config REGULATOR_PF9453
+	tristate "NXP PF9453 regulator driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say y here to support the NXP PF9453 PMIC regulator driver.
+
 config REGULATOR_PCAP
 	tristate "Motorola PCAP2 regulator driver"
 	depends on EZX_PCAP
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 3d5a803dce8a0..5192f24796636 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -123,6 +123,7 @@ obj-$(CONFIG_REGULATOR_QCOM_SPMI) += qcom_spmi-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_USB_VBUS) += qcom_usb_vbus-regulator.o
 obj-$(CONFIG_REGULATOR_PALMAS) += palmas-regulator.o
 obj-$(CONFIG_REGULATOR_PCA9450) += pca9450-regulator.o
+obj-$(CONFIG_REGULATOR_PF9453) += pf9453-regulator.o
 obj-$(CONFIG_REGULATOR_PF8X00) += pf8x00-regulator.o
 obj-$(CONFIG_REGULATOR_PFUZE100) += pfuze100-regulator.o
 obj-$(CONFIG_REGULATOR_PV88060) += pv88060-regulator.o
diff --git a/drivers/regulator/pf9453-regulator.c b/drivers/regulator/pf9453-regulator.c
new file mode 100644
index 0000000000000..6a4dac119b6f4
--- /dev/null
+++ b/drivers/regulator/pf9453-regulator.c
@@ -0,0 +1,723 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2024 NXP.
+ * NXP PF9453 pmic driver
+ */
+
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+
+#include "pf9453.h"
+
+struct pf9453_dvs_config {
+	unsigned int run_reg; /* dvs0 */
+	unsigned int run_mask;
+	unsigned int standby_reg; /* dvs1 */
+	unsigned int standby_mask;
+};
+
+struct pf9453_regulator_desc {
+	struct regulator_desc desc;
+	const struct pf9453_dvs_config dvs;
+};
+
+struct pf9453 {
+	struct device *dev;
+	struct regmap *regmap;
+	struct gpio_desc *sd_vsel_gpio;
+	int irq;
+};
+
+static const struct regmap_range pf9453_status_range = {
+	.range_min = PF9453_REG_INT1,
+	.range_max = PF9453_REG_PWRON_STAT,
+};
+
+static const struct regmap_access_table pf9453_volatile_regs = {
+	.yes_ranges = &pf9453_status_range,
+	.n_yes_ranges = 1,
+};
+
+static const struct regmap_config pf9453_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.volatile_table = &pf9453_volatile_regs,
+	.max_register = PF9453_MAX_REG - 1,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+/*
+ * BUCK2
+ * BUCK2RAM[1:0] BUCK2 DVS ramp rate setting
+ * 00: 25mV/1usec
+ * 01: 25mV/2usec
+ * 10: 25mV/4usec
+ * 11: 25mV/8usec
+ */
+static const unsigned int pf9453_dvs_buck_ramp_table[] = {
+	25000, 12500, 6250, 3125
+};
+
+static bool is_reg_protect(uint reg)
+{
+	switch (reg) {
+	case PF9453_REG_BUCK1OUT:
+	case PF9453_REG_BUCK2OUT:
+	case PF9453_REG_BUCK3OUT:
+	case PF9453_REG_BUCK4OUT:
+	case PF9453_REG_LDO1OUT_L:
+	case PF9453_REG_LDO1OUT_H:
+	case PF9453_REG_LDO2OUT:
+	case PF9453_REG_LDOSNVS_CFG1:
+	case PF9453_REG_BUCK2OUT_MAX_LIMIT:
+	case PF9453_REG_BUCK2OUT_MIN_LIMIT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int pf9453_pmic_write(struct pf9453 *pf9453, unsigned int reg, u8 mask, unsigned int val)
+{
+	int ret = -EINVAL;
+	u8 data, key;
+	u32 rxBuf;
+
+	/* If not updating entire register, perform a read-mod-write */
+	data = val;
+	key = PF9453_UNLOCK_KEY;
+
+	if (mask != 0xFFU) {
+		/* Read data */
+		ret = regmap_read(pf9453->regmap, reg, &rxBuf);
+		if (ret) {
+			dev_err(pf9453->dev, "Read reg=%0x error!\n", reg);
+			return ret;
+		}
+		data = (val & mask) | (rxBuf & (~mask));
+	}
+
+	if (reg < PF9453_MAX_REG) {
+		if (is_reg_protect(reg)) {
+			ret = regmap_raw_write(pf9453->regmap, PF9453_REG_LOCK, &key, 1U);
+			if (ret) {
+				dev_err(pf9453->dev, "Write reg=%0x error!\n", reg);
+				return ret;
+			}
+
+			ret = regmap_raw_write(pf9453->regmap, reg, &data, 1U);
+			if (ret) {
+				dev_err(pf9453->dev, "Write reg=%0x error!\n", reg);
+				return ret;
+			}
+
+			key = PF9453_LOCK_KEY;
+			ret = regmap_raw_write(pf9453->regmap, PF9453_REG_LOCK, &key, 1U);
+			if (ret) {
+				dev_err(pf9453->dev, "Write reg=%0x error!\n", reg);
+				return ret;
+			}
+		} else {
+			ret = regmap_raw_write(pf9453->regmap, reg, &data, 1U);
+			if (ret) {
+				dev_err(pf9453->dev, "Write reg=%0x error!\n", reg);
+				return ret;
+			}
+		}
+	}
+
+	return ret;
+}
+
+/**
+ * pf9453_regulator_enable_regmap for regmap users
+ *
+ * @rdev: regulator to operate on
+ *
+ * Regulators that use regmap for their register I/O can set the
+ * enable_reg and enable_mask fields in their descriptor and then use
+ * this as their enable() operation, saving some code.
+ */
+static int pf9453_regulator_enable_regmap(struct regulator_dev *rdev)
+{
+	unsigned int val;
+	struct pf9453 *pf9453 = dev_get_drvdata(rdev->dev.parent);
+
+	if (rdev->desc->enable_is_inverted) {
+		val = rdev->desc->disable_val;
+	} else {
+		val = rdev->desc->enable_val;
+		if (!val)
+			val = rdev->desc->enable_mask;
+	}
+
+	return pf9453_pmic_write(pf9453, rdev->desc->enable_reg, rdev->desc->enable_mask, val);
+}
+
+/**
+ * pf9453_regulator_disable_regmap for regmap users
+ *
+ * @rdev: regulator to operate on
+ *
+ * Regulators that use regmap for their register I/O can set the
+ * enable_reg and enable_mask fields in their descriptor and then use
+ * this as their disable() operation, saving some code.
+ */
+static int pf9453_regulator_disable_regmap(struct regulator_dev *rdev)
+{
+	unsigned int val;
+
+	struct pf9453 *pf9453 = dev_get_drvdata(rdev->dev.parent);
+
+	if (rdev->desc->enable_is_inverted) {
+		val = rdev->desc->enable_val;
+		if (!val)
+			val = rdev->desc->enable_mask;
+	} else {
+		val = rdev->desc->disable_val;
+	}
+
+	return pf9453_pmic_write(pf9453, rdev->desc->enable_reg, rdev->desc->enable_mask, val);
+}
+
+/**
+ * pf9453_regulator_set_voltage_sel_regmap for regmap users
+ *
+ * @rdev: regulator to operate on
+ * @sel: Selector to set
+ *
+ * Regulators that use regmap for their register I/O can set the
+ * vsel_reg and vsel_mask fields in their descriptor and then use this
+ * as their set_voltage_vsel operation, saving some code.
+ */
+static int pf9453_regulator_set_voltage_sel_regmap(struct regulator_dev *rdev, unsigned int sel)
+{
+	struct pf9453 *pf9453 = dev_get_drvdata(rdev->dev.parent);
+	int ret;
+
+	sel <<= ffs(rdev->desc->vsel_mask) - 1;
+	ret = pf9453_pmic_write(pf9453, rdev->desc->vsel_reg,
+				rdev->desc->vsel_mask, sel);
+	if (ret)
+		return ret;
+
+	if (rdev->desc->apply_bit)
+		ret = pf9453_pmic_write(pf9453, rdev->desc->apply_reg,
+					rdev->desc->apply_bit,
+					rdev->desc->apply_bit);
+	return ret;
+}
+
+static int find_closest_bigger(unsigned int target, const unsigned int *table,
+			       unsigned int num_sel, unsigned int *sel)
+{
+	unsigned int s, tmp, max, maxsel = 0;
+	bool found = false;
+
+	max = table[0];
+
+	for (s = 0; s < num_sel; s++) {
+		if (table[s] > max) {
+			max = table[s];
+			maxsel = s;
+		}
+		if (table[s] >= target) {
+			if (!found || table[s] - target < tmp - target) {
+				tmp = table[s];
+				*sel = s;
+				found = true;
+				if (tmp == target)
+					break;
+			}
+		}
+	}
+
+	if (!found) {
+		*sel = maxsel;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * pf9453_regulator_set_ramp_delay_regmap
+ *
+ * @rdev: regulator to operate on
+ *
+ * Regulators that use regmap for their register I/O can set the ramp_reg
+ * and ramp_mask fields in their descriptor and then use this as their
+ * set_ramp_delay operation, saving some code.
+ */
+static int pf9453_regulator_set_ramp_delay_regmap(struct regulator_dev *rdev, int ramp_delay)
+{
+	int ret;
+	unsigned int sel;
+	struct pf9453 *pf9453 = dev_get_drvdata(rdev->dev.parent);
+
+	if (WARN_ON(!rdev->desc->n_ramp_values || !rdev->desc->ramp_delay_table))
+		return -EINVAL;
+
+	ret = find_closest_bigger(ramp_delay, rdev->desc->ramp_delay_table,
+				  rdev->desc->n_ramp_values, &sel);
+
+	if (ret) {
+		dev_warn(rdev_get_dev(rdev),
+			 "Can't set ramp-delay %u, setting %u\n", ramp_delay,
+			 rdev->desc->ramp_delay_table[sel]);
+	}
+
+	sel <<= ffs(rdev->desc->ramp_mask) - 1;
+
+	return pf9453_pmic_write(pf9453, rdev->desc->ramp_reg,
+				 rdev->desc->ramp_mask, sel);
+}
+
+static const struct regulator_ops pf9453_dvs_buck_regulator_ops = {
+	.enable = pf9453_regulator_enable_regmap,
+	.disable = pf9453_regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = pf9453_regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.set_ramp_delay	= pf9453_regulator_set_ramp_delay_regmap,
+};
+
+static const struct regulator_ops pf9453_buck_regulator_ops = {
+	.enable = pf9453_regulator_enable_regmap,
+	.disable = pf9453_regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = pf9453_regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+};
+
+static const struct regulator_ops pf9453_ldo_regulator_ops = {
+	.enable = pf9453_regulator_enable_regmap,
+	.disable = pf9453_regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = pf9453_regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+};
+
+/*
+ * BUCK1/3/4
+ * 0.60 to 3.775V (25mV step)
+ */
+static const struct linear_range pf9453_buck134_volts[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0x00, 0x7F, 25000),
+};
+
+/*
+ * BUCK2
+ * 0.60 to 2.1875V (12.5mV step)
+ */
+static const struct linear_range pf9453_buck2_volts[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0x00, 0x7F, 12500),
+};
+
+/*
+ * LDO1
+ * 0.8 to 3.3V (25mV step)
+ */
+static const struct linear_range pf9453_ldo1_volts[] = {
+	REGULATOR_LINEAR_RANGE(800000, 0x00, 0x64, 25000),
+};
+
+/*
+ * LDO2
+ * 0.5 to 1.95V (25mV step)
+ */
+static const struct linear_range pf9453_ldo2_volts[] = {
+	REGULATOR_LINEAR_RANGE(500000, 0x00, 0x3A, 25000),
+};
+
+/*
+ * LDOSNVS
+ * 1.2 to 3.4V (25mV step)
+ */
+static const struct linear_range pf9453_ldosnvs_volts[] = {
+	REGULATOR_LINEAR_RANGE(1200000, 0x00, 0x58, 25000),
+};
+
+static int buck_set_dvs(const struct regulator_desc *desc,
+			struct device_node *np, struct pf9453 *pf9453,
+			char *prop, unsigned int reg, unsigned int mask)
+{
+	int ret, i;
+	u32 uv;
+
+	ret = of_property_read_u32(np, prop, &uv);
+	if (ret == -EINVAL)
+		return 0;
+	else if (ret)
+		return ret;
+
+	for (i = 0; i < desc->n_voltages; i++) {
+		ret = regulator_desc_list_voltage_linear_range(desc, i);
+		if (ret < 0)
+			continue;
+		if (ret == uv) {
+			i <<= ffs(desc->vsel_mask) - 1;
+			ret = pf9453_pmic_write(pf9453, reg, mask, i);
+			break;
+		}
+	}
+
+	if (ret == 0) {
+		struct pf9453_regulator_desc *regulator = container_of(desc,
+					struct pf9453_regulator_desc, desc);
+
+		/* Enable DVS control through PMIC_STBY_REQ for this BUCK */
+		ret = pf9453_pmic_write(pf9453, regulator->desc.enable_reg,
+					BUCK2_LPMODE, BUCK2_LPMODE);
+	}
+	return ret;
+}
+
+static int pf9453_set_dvs_levels(struct device_node *np, const struct regulator_desc *desc,
+				 struct regulator_config *cfg)
+{
+	struct pf9453_regulator_desc *data = container_of(desc, struct pf9453_regulator_desc, desc);
+	const struct pf9453_dvs_config *dvs = &data->dvs;
+	struct pf9453 *pf9453 = dev_get_drvdata(cfg->dev);
+	unsigned int reg, mask;
+	int i, ret = 0;
+	char *prop;
+
+	for (i = 0; i < PF9453_DVS_LEVEL_MAX; i++) {
+		switch (i) {
+		case PF9453_DVS_LEVEL_RUN:
+			prop = "nxp,dvs-run-voltage";
+			reg = dvs->run_reg;
+			mask = dvs->run_mask;
+			break;
+		case PF9453_DVS_LEVEL_DPSTANDBY:
+		case PF9453_DVS_LEVEL_STANDBY:
+			prop = "nxp,dvs-standby-voltage";
+			reg = dvs->standby_reg;
+			mask = dvs->standby_mask;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		ret = buck_set_dvs(desc, np, pf9453, prop, reg, mask);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static const struct pf9453_regulator_desc pf9453_regulators[] = {
+	{
+		.desc = {
+			.name = "buck1",
+			.of_match = of_match_ptr("BUCK1"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_BUCK1,
+			.ops = &pf9453_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_BUCK1_VOLTAGE_NUM,
+			.linear_ranges = pf9453_buck134_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_buck134_volts),
+			.vsel_reg = PF9453_REG_BUCK1OUT,
+			.vsel_mask = BUCK1OUT_MASK,
+			.enable_reg = PF9453_REG_BUCK1CTRL,
+			.enable_mask = BUCK1_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck2",
+			.of_match = of_match_ptr("BUCK2"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_BUCK2,
+			.ops = &pf9453_dvs_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_BUCK2_VOLTAGE_NUM,
+			.linear_ranges = pf9453_buck2_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_buck2_volts),
+			.vsel_reg = PF9453_REG_BUCK2OUT,
+			.vsel_mask = BUCK2OUT_MASK,
+			.enable_reg = PF9453_REG_BUCK2CTRL,
+			.enable_mask = BUCK2_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.ramp_reg = PF9453_REG_BUCK2CTRL,
+			.ramp_mask = BUCK2_RAMP_MASK,
+			.ramp_delay_table = pf9453_dvs_buck_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pf9453_dvs_buck_ramp_table),
+			.owner = THIS_MODULE,
+			.of_parse_cb = pf9453_set_dvs_levels,
+		},
+		.dvs = {
+			.run_reg = PF9453_REG_BUCK2OUT,
+			.run_mask = BUCK2OUT_MASK,
+			.standby_reg = PF9453_REG_BUCK2OUT_STBY,
+			.standby_mask = BUCK2OUT_STBY_MASK,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck3",
+			.of_match = of_match_ptr("BUCK3"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_BUCK3,
+			.ops = &pf9453_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_BUCK3_VOLTAGE_NUM,
+			.linear_ranges = pf9453_buck134_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_buck134_volts),
+			.vsel_reg = PF9453_REG_BUCK3OUT,
+			.vsel_mask = BUCK3OUT_MASK,
+			.enable_reg = PF9453_REG_BUCK3CTRL,
+			.enable_mask = BUCK3_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck4",
+			.of_match = of_match_ptr("BUCK4"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_BUCK4,
+			.ops = &pf9453_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_BUCK4_VOLTAGE_NUM,
+			.linear_ranges = pf9453_buck134_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_buck134_volts),
+			.vsel_reg = PF9453_REG_BUCK4OUT,
+			.vsel_mask = BUCK4OUT_MASK,
+			.enable_reg = PF9453_REG_BUCK4CTRL,
+			.enable_mask = BUCK4_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo1",
+			.of_match = of_match_ptr("LDO1"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_LDO1,
+			.ops = &pf9453_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_LDO1_VOLTAGE_NUM,
+			.linear_ranges = pf9453_ldo1_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_ldo1_volts),
+			.vsel_reg = PF9453_REG_LDO1OUT_H,
+			.vsel_mask = LDO1OUT_MASK,
+			.enable_reg = PF9453_REG_LDO1CFG,
+			.enable_mask = LDO1_EN_MASK,
+			.enable_val = LDO_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo2",
+			.of_match = of_match_ptr("LDO2"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_LDO2,
+			.ops = &pf9453_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_LDO2_VOLTAGE_NUM,
+			.linear_ranges = pf9453_ldo2_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_ldo2_volts),
+			.vsel_reg = PF9453_REG_LDO2OUT,
+			.vsel_mask = LDO2OUT_MASK,
+			.enable_reg = PF9453_REG_LDO2CFG,
+			.enable_mask = LDO2_EN_MASK,
+			.enable_val = LDO_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldosnvs",
+			.of_match = of_match_ptr("LDO_SNVS"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_LDOSNVS,
+			.ops = &pf9453_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_LDOSNVS_VOLTAGE_NUM,
+			.linear_ranges = pf9453_ldosnvs_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_ldosnvs_volts),
+			.vsel_reg = PF9453_REG_LDOSNVS_CFG1,
+			.vsel_mask = LDOSNVSCFG1_MASK,
+			.enable_reg = PF9453_REG_LDOSNVS_CFG2,
+			.enable_mask = LDOSNVS_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+	{ }
+};
+
+static irqreturn_t pf9453_irq_handler(int irq, void *data)
+{
+	struct pf9453 *pf9453 = data;
+	struct regmap *regmap = pf9453->regmap;
+	unsigned int status;
+	int ret;
+
+	ret = regmap_read(regmap, PF9453_REG_INT1, &status);
+	if (ret < 0) {
+		dev_err(pf9453->dev,
+			"Failed to read INT1(%d)\n", ret);
+		return IRQ_NONE;
+	}
+
+	if (status & IRQ_RSTB)
+		dev_warn(pf9453->dev, "IRQ_RSTB interrupt.\n");
+
+	if (status & IRQ_ONKEY)
+		dev_warn(pf9453->dev, "IRQ_ONKEY interrupt.\n");
+
+	if (status & IRQ_VR_FLT1)
+		dev_warn(pf9453->dev, "VRFLT1 interrupt.\n");
+
+	if (status & IRQ_RESETKEY)
+		dev_warn(pf9453->dev, "IRQ_RESETKEY interrupt.\n");
+
+	if (status & IRQ_LOWVSYS)
+		dev_warn(pf9453->dev, "LOWVSYS interrupt.\n");
+
+	if (status & IRQ_THERM_100)
+		dev_warn(pf9453->dev, "IRQ_THERM_100 interrupt.\n");
+
+	if (status & IRQ_THERM_80)
+		dev_warn(pf9453->dev, "IRQ_THERM_80 interrupt.\n");
+
+	return IRQ_HANDLED;
+}
+
+static int pf9453_i2c_probe(struct i2c_client *i2c)
+{
+	const struct pf9453_regulator_desc *regulator_desc = of_device_get_match_data(&i2c->dev);
+	struct regulator_config config = { };
+	unsigned int reset_ctrl;
+	unsigned int device_id;
+	struct pf9453 *pf9453;
+	int ret;
+
+	if (!i2c->irq)
+		return dev_err_probe(&i2c->dev, -EINVAL, "No IRQ configured?\n");
+
+	pf9453 = devm_kzalloc(&i2c->dev, sizeof(struct pf9453), GFP_KERNEL);
+	if (!pf9453)
+		return -ENOMEM;
+
+	pf9453->regmap = devm_regmap_init_i2c(i2c, &pf9453_regmap_config);
+	if (IS_ERR(pf9453->regmap))
+		return dev_err_probe(&i2c->dev, PTR_ERR(pf9453->regmap),
+				     "regmap initialization failed\n");
+
+	pf9453->irq = i2c->irq;
+	pf9453->dev = &i2c->dev;
+
+	dev_set_drvdata(&i2c->dev, pf9453);
+
+	ret = regmap_read(pf9453->regmap, PF9453_REG_DEV_ID, &device_id);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret,  "Read device id error\n");
+
+	/* Check your board and dts for match the right pmic */
+	if ((device_id >> 4) != 0xB)
+		return dev_err_probe(&i2c->dev, -EINVAL, "Device id(%x) mismatched\n",
+				     device_id >> 4);
+
+	while (regulator_desc->desc.name) {
+		const struct regulator_desc *desc;
+		struct regulator_dev *rdev;
+
+		desc = &regulator_desc->desc;
+
+		config.regmap = pf9453->regmap;
+		config.dev = pf9453->dev;
+
+		rdev = devm_regulator_register(pf9453->dev, desc, &config);
+		if (IS_ERR(rdev))
+			return dev_err_probe(pf9453->dev, PTR_ERR(rdev),
+					     "Failed to register regulator(%s)\n", desc->name);
+
+		regulator_desc++;
+	}
+
+	ret = devm_request_threaded_irq(pf9453->dev, pf9453->irq, NULL,
+					pf9453_irq_handler,
+					(IRQF_TRIGGER_FALLING | IRQF_ONESHOT),
+					"pf9453-irq", pf9453);
+	if (ret)
+		return dev_err_probe(pf9453->dev, ret, "Failed to request IRQ: %d\n", pf9453->irq);
+
+	/* Unmask all interrupt except PWRON/WDOG/RSVD */
+	ret = pf9453_pmic_write(pf9453, PF9453_REG_INT1_MSK,
+				IRQ_ONKEY | IRQ_RESETKEY | IRQ_RSTB | IRQ_VR_FLT1
+				| IRQ_LOWVSYS | IRQ_THERM_100 | IRQ_THERM_80,
+				IRQ_RSVD);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret,  "Unmask irq error\n");
+
+	if (of_property_read_bool(i2c->dev.of_node, "nxp,wdog_b-warm-reset"))
+		reset_ctrl = WDOG_B_CFG_WARM;
+	else
+		reset_ctrl = WDOG_B_CFG_COLD;
+
+	/* Set reset behavior on assertion of WDOG_B signal */
+	ret = pf9453_pmic_write(pf9453, PF9453_REG_RESET_CTRL, WDOG_B_CFG_MASK, reset_ctrl);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Failed to set WDOG_B reset behavior\n");
+
+	/*
+	 * The driver uses the LDO1OUT_H register to control the LDO1 regulator.
+	 * This is only valid if the SD_VSEL input of the PMIC is high. Let's
+	 * check if the pin is available as GPIO and set it to high.
+	 */
+	pf9453->sd_vsel_gpio = gpiod_get_optional(pf9453->dev, "sd-vsel", GPIOD_OUT_HIGH);
+
+	if (IS_ERR(pf9453->sd_vsel_gpio))
+		return dev_err_probe(&i2c->dev, PTR_ERR(pf9453->sd_vsel_gpio),
+				     "Failed to get SD_VSEL GPIO\n");
+
+	return 0;
+}
+
+static const struct of_device_id pf9453_of_match[] = {
+	{
+		.compatible = "nxp,pf9453",
+		.data = pf9453_regulators,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pf9453_of_match);
+
+static struct i2c_driver pf9453_i2c_driver = {
+	.driver = {
+		.name = "nxp-pf9453",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.of_match_table = pf9453_of_match,
+	},
+	.probe = pf9453_i2c_probe,
+};
+
+module_i2c_driver(pf9453_i2c_driver);
+
+MODULE_AUTHOR("Joy Zou <joy.zou@nxp.com>");
+MODULE_DESCRIPTION("NXP PF9453 Power Management IC driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/regulator/pf9453.h b/drivers/regulator/pf9453.h
new file mode 100644
index 0000000000000..14d6343d42658
--- /dev/null
+++ b/drivers/regulator/pf9453.h
@@ -0,0 +1,171 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright 2024 NXP. */
+
+#ifndef __LINUX_REG_PF9453_H__
+#define __LINUX_REG_PF9453_H__
+
+#include <linux/regmap.h>
+
+enum {
+	PF9453_BUCK1 = 0,
+	PF9453_BUCK2,
+	PF9453_BUCK3,
+	PF9453_BUCK4,
+	PF9453_LDO1,
+	PF9453_LDO2,
+	PF9453_LDOSNVS,
+	PF9453_REGULATOR_CNT,
+};
+
+enum {
+	PF9453_DVS_LEVEL_RUN = 0,
+	PF9453_DVS_LEVEL_STANDBY,
+	PF9453_DVS_LEVEL_DPSTANDBY,
+	PF9453_DVS_LEVEL_MAX,
+};
+
+#define PF9453_BUCK1_VOLTAGE_NUM	0x80
+#define PF9453_BUCK2_VOLTAGE_NUM	0x80
+#define PF9453_BUCK3_VOLTAGE_NUM	0x80
+#define PF9453_BUCK4_VOLTAGE_NUM	0x80
+
+#define PF9453_LDO1_VOLTAGE_NUM		0x65
+#define PF9453_LDO2_VOLTAGE_NUM		0x3b
+#define PF9453_LDOSNVS_VOLTAGE_NUM	0x59
+
+enum {
+	PF9453_REG_DEV_ID              = 0x00,
+	PF9453_REG_OTP_VER             = 0x01,
+	PF9453_REG_INT1                = 0x02,
+	PF9453_REG_INT1_MSK            = 0x03,
+	PF9453_REG_INT1_STATUS         = 0x04,
+	PF9453_REG_VRFLT1_INT          = 0x05,
+	PF9453_REG_VRFLT1_MASK         = 0x06,
+	PF9453_REG_PWRON_STAT          = 0x07,
+	PF9453_REG_RESET_CTRL          = 0x08,
+	PF9453_REG_SW_RST              = 0x09,
+	PF9453_REG_PWR_CTRL            = 0x0a,
+	PF9453_REG_CONFIG1             = 0x0b,
+	PF9453_REG_CONFIG2             = 0x0c,
+	PF9453_REG_32K_CONFIG          = 0x0d,
+	PF9453_REG_BUCK1CTRL           = 0x10,
+	PF9453_REG_BUCK1OUT            = 0x11,
+	PF9453_REG_BUCK2CTRL           = 0x14,
+	PF9453_REG_BUCK2OUT            = 0x15,
+	PF9453_REG_BUCK2OUT_STBY       = 0x1D,
+	PF9453_REG_BUCK2OUT_MAX_LIMIT  = 0x1F,
+	PF9453_REG_BUCK2OUT_MIN_LIMIT  = 0x20,
+	PF9453_REG_BUCK3CTRL           = 0x21,
+	PF9453_REG_BUCK3OUT            = 0x22,
+	PF9453_REG_BUCK4CTRL           = 0x2e,
+	PF9453_REG_BUCK4OUT            = 0x2f,
+	PF9453_REG_LDO1OUT_L           = 0x36,
+	PF9453_REG_LDO1CFG             = 0x37,
+	PF9453_REG_LDO1OUT_H           = 0x38,
+	PF9453_REG_LDOSNVS_CFG1        = 0x39,
+	PF9453_REG_LDOSNVS_CFG2        = 0x3a,
+	PF9453_REG_LDO2CFG             = 0x3b,
+	PF9453_REG_LDO2OUT             = 0x3c,
+	PF9453_REG_BUCK_POK            = 0x3d,
+	PF9453_REG_LSW_CTRL1           = 0x40,
+	PF9453_REG_LSW_CTRL2           = 0x41,
+	PF9453_REG_LOCK                = 0x4e,
+	PF9453_MAX_REG,
+};
+
+#define PF9453_UNLOCK_KEY               0x5c
+#define PF9453_LOCK_KEY			0x0
+
+/* PF9453 BUCK ENMODE bits */
+#define BUCK_ENMODE_OFF			0x00
+#define BUCK_ENMODE_ONREQ		0x01
+#define BUCK_ENMODE_ONREQ_STBY		0x02
+#define BUCK_ENMODE_ONREQ_STBY_DPSTBY	0x03
+
+/* PF9453 BUCK ENMODE bits */
+#define LDO_ENMODE_OFF			0x00
+#define LDO_ENMODE_ONREQ		0x01
+#define LDO_ENMODE_ONREQ_STBY		0x02
+#define LDO_ENMODE_ONREQ_STBY_DPSTBY	0x03
+
+/* PF9453_REG_BUCK1_CTRL bits */
+#define BUCK1_LPMODE			0x30
+#define BUCK1_AD			0x08
+#define BUCK1_FPWM			0x04
+#define BUCK1_ENMODE_MASK		0x03
+
+/* PF9453_REG_BUCK2_CTRL bits */
+#define BUCK2_RAMP_MASK			0xC0
+#define BUCK2_RAMP_25MV			0x0
+#define BUCK2_RAMP_12P5MV		0x1
+#define BUCK2_RAMP_6P25MV		0x2
+#define BUCK2_RAMP_3P125MV		0x3
+#define BUCK2_LPMODE			0x30
+#define BUCK2_AD			0x08
+#define BUCK2_FPWM			0x04
+#define BUCK2_ENMODE_MASK		0x03
+
+/* PF9453_REG_BUCK3_CTRL bits */
+#define BUCK3_LPMODE			0x30
+#define BUCK3_AD			0x08
+#define BUCK3_FPWM			0x04
+#define BUCK3_ENMODE_MASK		0x03
+
+/* PF9453_REG_BUCK4_CTRL bits */
+#define BUCK4_LPMODE                    0x30
+#define BUCK4_AD			0x08
+#define BUCK4_FPWM			0x04
+#define BUCK4_ENMODE_MASK		0x03
+
+/* PF9453_REG_BUCK123_PRESET_EN bit */
+#define BUCK123_PRESET_EN		0x80
+
+/* PF9453_BUCK1OUT bits */
+#define BUCK1OUT_MASK			0x7F
+
+/* PF9453_BUCK2OUT bits */
+#define BUCK2OUT_MASK			0x7F
+#define BUCK2OUT_STBY_MASK		0x7F
+
+/* PF9453_REG_BUCK3OUT bits */
+#define BUCK3OUT_MASK			0x7F
+
+/* PF9453_REG_BUCK4OUT bits */
+#define BUCK4OUT_MASK			0x7F
+
+/* PF9453_REG_LDO1_VOLT bits */
+#define LDO1_EN_MASK			0x3
+#define LDO1OUT_MASK			0x7F
+
+/* PF9453_REG_LDO2_VOLT bits */
+#define LDO2_EN_MASK			0x3
+#define LDO2OUT_MASK			0x7F
+
+/* PF9453_REG_LDOSNVS_VOLT bits */
+#define LDOSNVS_EN_MASK			0x1
+#define LDOSNVSCFG1_MASK		0x7F
+
+/* PF9453_REG_IRQ bits */
+#define IRQ_RSVD			0x80
+#define IRQ_RSTB			0x40
+#define IRQ_ONKEY			0x20
+#define IRQ_RESETKEY			0x10
+#define IRQ_VR_FLT1			0x08
+#define IRQ_LOWVSYS			0x04
+#define IRQ_THERM_100			0x02
+#define IRQ_THERM_80			0x01
+
+/* PF9453_REG_RESET_CTRL bits */
+#define WDOG_B_CFG_MASK			0xC0
+#define WDOG_B_CFG_NONE			0x00
+#define WDOG_B_CFG_WARM			0x40
+#define WDOG_B_CFG_COLD			0x80
+
+/* PF9453_REG_CONFIG2 bits */
+#define I2C_LT_MASK			0x03
+#define I2C_LT_FORCE_DISABLE		0x00
+#define I2C_LT_ON_STANDBY_RUN		0x01
+#define I2C_LT_ON_RUN			0x02
+#define I2C_LT_FORCE_ENABLE		0x03
+
+#endif /* __LINUX_REG_PF9453_H__ */

-- 
2.34.1


