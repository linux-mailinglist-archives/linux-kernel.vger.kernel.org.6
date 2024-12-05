Return-Path: <linux-kernel+bounces-433724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B789E5C30
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D31163612
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E994F226EFE;
	Thu,  5 Dec 2024 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RlX5q8e8"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2087.outbound.protection.outlook.com [40.107.104.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E17224B00;
	Thu,  5 Dec 2024 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733417503; cv=fail; b=ruKD6Y7LcnIf/FA5Y+s0eX6Iz7AZhdUYcFzVy2Rt575m5kU1KJ0MzjwTa9+3bCUBNlYB0whi0FUydYkEKxY82wcRJ2JRxQPl8hjOIPHTFS5vD9WvnLzTK5hz8NIf2kY43zVtY4sAH7DxJ2VwQnhpKaxZh+pAJwG0rcm6eNnFZd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733417503; c=relaxed/simple;
	bh=LWpolkjMVGu0r7DvGNupncMS///BISprVKBCOfaLE40=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=G++CGUg6uT+6n7iHNvpQkpGASkJlgZbavltmJAbJuE7OTpS0HearIgX4AzVH8j7OmNnpYTzJlBLYdMku9GQsuVDoMFmoTpj5lIStePxGmQ18J4uDyinXZJNNWsiitrQPJQ7MmLqAj3Cq4D/+VXfal1gMNkH765gnRUkBIwVldxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RlX5q8e8; arc=fail smtp.client-ip=40.107.104.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMW/Gi3HGt2DG2+6f9AwD3lrOMBGqkE13dWNvHSiydExkj7RGZieojhasZJKQ9ksgip7PcjF0Riq+szplw8SY+PYNaJcDJLu4mrBFmHbBIIgFxje9Au9chKY/XEH5PZWIRc96rhlO6FV1JlUbgKBp2/UynidvPc4x8UVGXsNATjSCq9OvYNF5PQecNugJZg1Uq8cW/mEpAIkx07Zr8S2dUbOzfA9IfV45sdkCGvOIOno83TgSMQN95K7uMgivuibetxdeBlErY8tfTaT+djuqDCs+Iri0sWqgTcXRNPoimaiHI9jQB1IIb/WQ4yhSidxyTXzOR4sK/8NIEmvvbnZ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Qv+G0aN0fxo+eJyWD7tRd65AwEwgzuXjj7y0WGiV5Y=;
 b=xwgSpt/v8D01cKdsRD2GPj7j+Hvjx6utX9kkXHc53LKJA8fsCMQEXI4jbjsLs0W9OQSV0jfLTNlGC1em6pHWmoXIioWbbyz7x5/bfrC/NnrsALtSSoE7sHctokmHEthHkXGd1pLdY5gbf9b/LR+xfg5avYjLv532XBgX/8g8/aNIxbJ7b0a82pdO1DQL3+5yL3bHRH7xxjZc4VuHiZrH4Y4R4eZHs6jXu80kOQR7gg4crPNTLtb+XS8G5g4o1SOexAPiqERPW5oRCx7XcSmaJ0ApjKH2dk5flkdQCkBBVuqXdn+onsRwRj4mv9VPIVZtAkf2oNVDXjAfSoFD4vRHvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Qv+G0aN0fxo+eJyWD7tRd65AwEwgzuXjj7y0WGiV5Y=;
 b=RlX5q8e8kue9QpWdfDmTjFCx58Z9sMs0L+hpuJHpH80k9BgqPTkv3UvJqPEgjJohcE2R6ICU6H6eK58eS1gg+jfGZvBwhkbo7qGjs5dc/OQyMYXGTTmkbbP28EePuZW0y9hp7tAX8buYcaNWBJTE/ZHSscZRNBgQngZGI5KojWUAzdSDn0EhVMpjOIDHWighAxhDjx3SBMT+CS4TUe5oXKPJJc7DUj8AWgXYbaG8unVgUgXbCW+LSDNN+4UdAirLLbKoR/IOTi2ZffFsHFHauRjZK60gcXD+oewQD7RShErOzOSso0fQYwQeQfbxj0c+YnSjJX4S5xS/++LM/DFG1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DBAPR04MB7446.eurprd04.prod.outlook.com (2603:10a6:10:1aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 16:51:38 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 16:51:38 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 05 Dec 2024 11:51:11 -0500
Subject: [PATCH 3/5] regulator: dt-bindings: pca9450: Add pca9452 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-pca9450-v1-3-aab448b74e78@nxp.com>
References: <20241205-pca9450-v1-0-aab448b74e78@nxp.com>
In-Reply-To: <20241205-pca9450-v1-0-aab448b74e78@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robin Gong <yibin.gong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, joy.zou@nxp.com, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733417480; l=813;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=bEhg17FlqwWgEaGk85QiltrgdH1mfNZULFNEUwHv3ts=;
 b=gjUBT5yuu7VBCxchE1FH/tqzkGT6gmeQYB2uZl1u5WM0k4fP6aeMnxpqamwa61cA21FNVkF+L
 tAvtg8yQmb5AwkwKwRoEdeE8F+2Qefc4SibvWhedHVP0uCo5Q4NC06q
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::42) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DBAPR04MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: 220b1491-337c-4267-d898-08dd154d15e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjRUVFNwV3ZVOE5XdDY0T3lzVjh0b0d3R3k5M2hETzNEYzVQUjRPdldVUExK?=
 =?utf-8?B?YjVsekV4ZDN1eERwZXdmQm11ZytiS215SzZmQjNhVjJPZ0FLUGI4bzhHYTFG?=
 =?utf-8?B?Z2VOQnFjbUx3ZGdNeGlacGwxSGRyNks0dWFKakdJa0JodisxK2ExVThWWStI?=
 =?utf-8?B?TWRGanVtMXRLU2l1UjNweUVEUjdIUVlJYSt1U3NnTC9kWjdJS2Fvb2VibWNr?=
 =?utf-8?B?b09vUWpIK0srOGRMNUVBY3F4RnBBVzJjSTFZcU9oVzM5c2M1QmwzTDRZWjAr?=
 =?utf-8?B?eTVBMWpCN2xEWVA2UUZXTWU5S0NlMzNoUlZPY2ZhY3NSN1laSEtFbE5hVTZN?=
 =?utf-8?B?RXR3MGFmK2crT2xDUXRBRHUrSUVvdnFpc0t0bmN0eEdzazJ2QkwveXJWN1Ru?=
 =?utf-8?B?QitqaGNLSGNxRmx2SjFOY1ByRUFrV3k5ZVZ4MjBiTkVLdUZwK1E4UjhlaDJK?=
 =?utf-8?B?Ym9NVVJWdll3TnRkSExiZUtJTHUzNGFISFNCL1lMbXVhdXRiTkpjK2JrTzF6?=
 =?utf-8?B?aUwxOEZWeUpNTS9aV01VeTRVVEZiNktHOHgrZzhnUHhTbTdqNTF1T1BZbEtS?=
 =?utf-8?B?YmVEZ1UwZE9QVis3UFZ0dWlsclVCLzZxMGQ3ZWxGdGNsd1pNYU9kWmZJV3NS?=
 =?utf-8?B?THlNWE9VeDVEaW56YlAxbk5rek9ZTjczNGdocUU0Rk91YWNPYXpXcmE4ZmdP?=
 =?utf-8?B?V2VOVjdzT3R3MTkwcy9WeithUzJrMVpMcHR0Um16Y245MHJ1cXYwK1lLdjlN?=
 =?utf-8?B?cUNoWUlUSVk5N3ZHaFFXTlNuUU11RWg0MU1MOVYwN3l4NDZVbEZhRVJmYlgx?=
 =?utf-8?B?bXgyT3hmTkpvZGIvZXFHcW5WbytOYjZHcEZYTklLWklxdFkrVkNyckpNa1NC?=
 =?utf-8?B?TnlHS2hUYlZjLytsOE5WTzFQbmhNWmZUMXA4TktXK1hIcVo1UkVldlUySVMz?=
 =?utf-8?B?b2JpL2c0SmNoaGFkU3dDS25LSEs1aUYxNFlRWGovVnZMQisxMnYvZ0tJL21x?=
 =?utf-8?B?MzUzOWJXVkp2NFNqSVBkSlI1RG5PWkRiMG02YndzREZkN0RBU3AzQzJUdmpW?=
 =?utf-8?B?UTRTanJEZGNuTVNCQ3JocW1aNzJ1eXVJRmNzSmFoMTE2SHFLZi9IbEtCYkgr?=
 =?utf-8?B?T1VXVzlTSHdxVWRHYmhEOVJHd1FscUVhQzd5d29kRy92VWRWUTRCVVdKUmRO?=
 =?utf-8?B?TUIrbkdVNFRZZjFOY1hCanFNcjMyMmV3amxybW1IV0FxdEJDM3Z6c1Q0WXZs?=
 =?utf-8?B?andUb0plUkFSZ0tSNVBocVdqOWhHSnRVdi9Cdmd2WkNpR2tMZno4bUhsMmJz?=
 =?utf-8?B?SU1IR25KaE1XdEtWakFhcEVWdEJOMW5HclFlcTFFVnVvaEY0TG5YbnhxWGty?=
 =?utf-8?B?N0lTRVNrNUd4V0hDL0dhbi9KKzgrYkVQeGVjbC9nQnUxY1NzTnJERlpleU5N?=
 =?utf-8?B?Y3lpZEMzOUpaS1VESm1RU3V1TXE0OFl1cjYzR0kwWjlMN2pTRE5KRDZIclJl?=
 =?utf-8?B?V3Y1M09kL0t4bGtKVmF4MXN2RDd6L3hvZGhpM29VUFkzb2VWemNqejNhUTh2?=
 =?utf-8?B?c0pRMUFXL1I1cW9SVUhteUFra3dOdGxjc282a1Y4elZ6RDZ0UzNITTVpWnhX?=
 =?utf-8?B?ckFXN1plU3ladlZnR2NLbEZJb05VVFcrbHdRZlVlVUJybUsxRG1oUFhyZXRS?=
 =?utf-8?B?b0hRNzNPVWl2aGJFMHJvL29ndUNoam9WTTJ2UkhJZjJSeHlpZmk4V3RUVHM3?=
 =?utf-8?B?SnIzMFRmQWY3Mll1WnRQWVVmSjhQVFRhTDJWTGdLQzk5WCt1ZGRmUFdOdjVh?=
 =?utf-8?B?WjdvamI0Y1ZrVWs3dDEyZ3Bma1pYWTM2NGRVWmQwckpDQWgwcmlkNjVqYmY5?=
 =?utf-8?B?cFRoMmM2QTU5ZkVSZTU4dEloYTBRcWFtaGNSNEdXbjhxVllYRGRlMHBPeTdL?=
 =?utf-8?Q?90YYq55u2mQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnZBUE5KWmptckdUS0xDMTFUSThIc2ZsVSsxaVE2Y1ZNM1RwZEgvbkFoR3V6?=
 =?utf-8?B?aFZaS0Z1Qk00THRSYWlSc0hialBsQ2hmWDVXZHhOVHlEMlhJNnBISzB4RFdF?=
 =?utf-8?B?TEQydUlPNkdZNHBFWHAzU1Z3SWU0RVY3aXhvSkRsUGlvOFhpdE4vZU45S1hs?=
 =?utf-8?B?T3k0SnYzMGI3dndpT011dkU0SEhKSWJJV3c3U2ZidlIveTF2L3ZZZHM4K0NK?=
 =?utf-8?B?QkxBenI5TnJ6cnUraWNIQlR5V2ZXSVpKWGJObU1iSVdTOTB5RVBOc05UQWJH?=
 =?utf-8?B?UUZyV1JZYkp4WXJDWjBmWE1xc0g3UFAvL2NKS3kzWWg5ZGp1ZlRjRUZFOTRZ?=
 =?utf-8?B?WEJjd1FYSU5lYlhwdUE1T0d1ckxYdkI3WlcyREpmVFlFdzNkTk41dnlJWUNt?=
 =?utf-8?B?NzYxeVJwRSsydXVWZVRaS0FsLzZqR3pFUVlsOVloaTYwMzh6cTFEeWVLQk1m?=
 =?utf-8?B?ZUlTT0lDZ08vVlNQSEQ4eTNISVdCSjhsVy9SZG1qU3F5amlabmV0aUJOcUZu?=
 =?utf-8?B?eFYySlB2THRwZWdEWXpTaHdmNVFoOWF6S0J1Q0RzN2VMZ2xpRU9tdmNSYUFs?=
 =?utf-8?B?dkwvRklTbGR2RU50bTdzTzFiMDQ5dFN0cm9BRFM5OEZMZGpBK2Z6d2lSY2cw?=
 =?utf-8?B?ZSthTER5UUljZ0N3eXQwcUFXS0l3d2lDNzhXZDk4enlpZUN0MTFSaHBVSTdO?=
 =?utf-8?B?bkIzdCt0bDNMV0tRZGpoakRGNmY5djZHcXpxUG5mS0xIdng1Vk1hbkN6VEZO?=
 =?utf-8?B?N0pMVWdJSDl3YW5MQ21mc0YzR1c2Y3EwQ3FNcVlTUmxyR3BTSjdwM0FnRU14?=
 =?utf-8?B?d1I1eG9CelU1Tk9BZ0YrU2lxeW8rOHlWdjdjckFPS1JIMVQ5OEFuRXE2aWFr?=
 =?utf-8?B?b3ZFUU43bVRpamV0MWFUa3BReWpVd3hCKzIzZk01bHFmMlg0OTlNeFdNT3V3?=
 =?utf-8?B?ZmU5YitHNklZZVJCMEFDdnlXVjZSL2VwTHNVU0ZCVEZnelN0ZzhqTGJLWTVW?=
 =?utf-8?B?dU9abFNma3VVbkhIbllja1ZFK2NWUnIxaWo2SDhTTFMyWFYvVGFibzZJQWNQ?=
 =?utf-8?B?aE0xOVVFcW91aFhHdEtXUGp4MlVTblYva0FoWnMxcnM5VjM2QnFZM0VIYUtw?=
 =?utf-8?B?aGp0eFlVNTBpSG53clB4Q1QyMHV1T1ZwWThEQ3ZYTVRvVXF3RzZpVHhmV1la?=
 =?utf-8?B?Z1JQOFlZODVxZ2pkRjMyM09paS9Cb21DNHZESldIMmtXUUR0bTRCQVVhZEM2?=
 =?utf-8?B?Wk5PTW91UUhnUFdkenl0Z3Yra0Y1ZGNVTjlBd3c0RkRaSmsyZjhrQjVlTjVO?=
 =?utf-8?B?OFJrL245T1hLenF1SFU1ZHU5aU8yQndUaUE3WTdEUTlsc3lpd1l4VzVlUmRD?=
 =?utf-8?B?Ymw4UjR1eTVCN21kOGNKSTdBb1JGRFYrU3owU2YyTXduUTlaRUc3R1YxWFRC?=
 =?utf-8?B?V09VRk9sempyM2NJR0l4NUFQNTRIR2ZRbmJ1MlZ2NldNMDNzWDhKSTZiSktJ?=
 =?utf-8?B?c09KQWRGanNjb2R3bkYzZFRQTW11N3RybHEwUzhmR2J5SjRiWkJ4ODBsMVdk?=
 =?utf-8?B?Q1BBYVBxQTA1Z1JLWUh1WENneXJQbHE3ZkdjVEViTzdHc1BjL243bTVJVDRK?=
 =?utf-8?B?bmkrdy9LWEN5TzU0K3huS0Fqei9MMjczSVNyd2NLNkZjUjBQVXNlZ0dBZGto?=
 =?utf-8?B?TXhhcyt4RXlGWDJJUldyZUVoN2s4OUtKeEZjQjI3ZlQwQVBXR1VEQ0dmc0pR?=
 =?utf-8?B?RnZMelNOT1hBUXVJamZPZCtBZWl2clBCUC9FUDNucVorZWFGcGphZEFxcU92?=
 =?utf-8?B?Zzl3bm9jMlhmbStLS3N1TVBUcEZzMTVRYVcrV3NNVS9KWU44T1M5NGJQNGx1?=
 =?utf-8?B?Ry91RHMyODgzczRycFQ0T2ZYb2duQnlKOEtjY1RjK1I2dWI3T2Q3a2tMZFNx?=
 =?utf-8?B?RlptMmdONG9HUW5SOHFjbHhvQWozSGM4dTFKck94cUMxK1I1S1owT2x2Mnlx?=
 =?utf-8?B?a3Nzd3RhRzVNeFVxZXRDc3RZRnBTbVdGS3ZXN1hYQ3lZazNScWIrY0VuMWpN?=
 =?utf-8?B?blE4SVdZSUF4Rm50RWd6SUgzMUpKOE92MVlWTmVSU1pVMVoxcG55bmdoRzky?=
 =?utf-8?Q?jKhBDDnAnWX+XEvX8W0KqcSmg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 220b1491-337c-4267-d898-08dd154d15e7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 16:51:38.3759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N1bfj9wFK2BcXfoxUpj9OIzKOPoLom/yCOn0OBQ8f7sonKhfoQreMrzLH2s7gLODAeVfWRYsumZRZ/y6k8p4/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7446

From: Joy Zou <joy.zou@nxp.com>

Add compatible string 'nxp,pca9452'. pca9452 add 'ldo3' compared with
pca9451a.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
index f8057bba747a5..68709a7dc43f1 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
@@ -29,6 +29,7 @@ properties:
       - nxp,pca9450b
       - nxp,pca9450c
       - nxp,pca9451a
+      - nxp,pca9452
 
   reg:
     maxItems: 1

-- 
2.34.1


