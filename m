Return-Path: <linux-kernel+bounces-292445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB8B956F99
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 172F81C21AF3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991FA16D4E1;
	Mon, 19 Aug 2024 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OIKaA0YL"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013044.outbound.protection.outlook.com [52.101.67.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A716713B5AF
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083337; cv=fail; b=qdQ/lRopwE7/HgwT0upxKKAfKrvLN5jsLT1k7tARiVnNDLILgbikEO77K/fR/xmUYOoENqIveAAmUmWAA6UyZvGVvdchyLcYxGZ2e4+V86gAYweRhl9Ce6sMg5uptZqPNNVCWWehWYz+tQbGQEm9dcXVrK/HA89aebha33cQPTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083337; c=relaxed/simple;
	bh=/JI8s94ok2z+hT6L0BfTNT5ICOc99IOP4jbZmyhmqiE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=knhSn4pWPJbNQKP2Awf5rczaWQyPbWxGRYPRRweGGPkAbS7ghp2Ym3F3fRkFRfu717m+Cn1zJcTVlmVrB30icd4J6QlTlnlXunlSFAaSHi3QSiO1mUgX6sAC9X8XSR712VVxcZcBMewjiFo5JlsTUA8kdFM6lwTf48WqhQqG9go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OIKaA0YL; arc=fail smtp.client-ip=52.101.67.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1ecW37Gb3zLMvvEW1YQfRJ9VEOaKwpnQS0NKrvOBHCerOII16NaKMYsaymDDP6xaZgfJgiuuLpzGnGeaLjt1j0beDqckVrYmVtCByO4TlfrUEKPjK+Hm15KeqmenFfee2g7lgRN2xiH4LeNPt8KVReU+7k/mAcy4yxe4WP2+fMSLuMnCwCIcnlucdqR8lD/gNj6dG/LXnrG3/xiKQ59LsNTi4Wr2JNTEPTn8rcR1p6LylK5dxaYeU6EgLuTMSk3otj8epdEGVTHgdPgXtk9u0dku+eAtHYk4yFkHI6TMoOfJ+Z+ctVPDCzgbxkcp7P2x46aXHLHRKIBAMxMu1BkKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEH3AqOKfHzxwLjQgVs3Ok5rqhSw+ALKLhi5IuDAIjI=;
 b=yrlT80qdOWzL50NlKeWPjZC+U49vraok5/5hjrkzdkw5qIWHOV1ddWYTGPV3UDkSTX9d8osey5VwdzDPKJXJRQV57yyhnSljp5w3bH+tNwGoAFcum2leBojdizH3D76GFMhbZDMODrdhokytcZMayiJNsFImiQCBea1smfpIdsYZYqWaaqoFjixcfJdvRD9njYGqEUrkTG4qmsjzJ5VFf151ejv4b7Ed3CFCG8BU7AWBWYgeU5VSmcaGPdQUpImxGEEIA7q3d+uHJt/aCmqSsPHgCVbrnBLZUe/88AHmzdL2zFbosOBMOVEZtB9vQpWhyYooLe25juKGDpks3unlzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEH3AqOKfHzxwLjQgVs3Ok5rqhSw+ALKLhi5IuDAIjI=;
 b=OIKaA0YLZ3HpleVMFLgmvKJuzsvMEgHyubtKSSl6Kpm22127WlO2xx+O6z341s+orU0kpSnUEIHsjbAZEMTWhKYactUK2yX4hV3hdXpJnZbd5C+nT5kwEpCqnQgup5PR4LMSNzK334uNCZTbZ/zzPqwV74jF3PnqNJ79XleMFOXhlsMfa+MLXfQ+GrkmBu1YhmsRzcmH0IcTyMHIEe64rKa+ZbMidIIpAVBdp/m8bgyCZEbtUWPLKDjEcje3Bn/RbIM3cG0p5zKvtLH4DOz5a9gj5wMkXDauZ/L/JKEjfcxjfpjMEQSIorxzax+D5/hRzX78ywijtrl6WxOEVmynsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9659.eurprd04.prod.outlook.com (2603:10a6:10:320::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 16:02:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 16:02:10 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 19 Aug 2024 12:01:55 -0400
Subject: [PATCH v3 01/11] i3c: master: Remove
 i3c_dev_disable_ibi_locked(olddev) on device hotjoin
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-i3c_fix-v3-1-7d69f7b0a05e@nxp.com>
References: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
In-Reply-To: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724083326; l=1374;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/JI8s94ok2z+hT6L0BfTNT5ICOc99IOP4jbZmyhmqiE=;
 b=U8JWV56QJWMg7tHj0mH5hBVpJ2WB54ZuW2LJPI+LWtGmYzVgSThVRW0Ibp8hZnHCAQ6mK1Xu2
 41vCFO3ye3PDMzTam1jgN1r0x5OOy6pKWMrOhZRXtoUyeEm4aPZLUNJ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:806:20::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9659:EE_
X-MS-Office365-Filtering-Correlation-Id: db33ad1e-d352-4141-acfa-08dcc0684885
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?U3lwTUtPQk0zOS9BTmp6RTd6djhWNG16OFE2ODUrdDV2WG0yQ1JLVUt6WkxV?=
 =?utf-8?B?RlpReUhVZU13cmJvUG5TU1lQK2JmWHA5K1VYMVZ2TDhXekZGd0pNWEFDeENE?=
 =?utf-8?B?UVpydkMxYm82WE1nOGhzR1E2RWo2ZUJKaFp5SlVSRG5WL3pva3VjTzh4b2pl?=
 =?utf-8?B?YmZvN2IwYUFERnJyQyt1T0JvRnhSRHZRUHZkYzU2aFhlY29Db3JkRFpXZTRy?=
 =?utf-8?B?Z3Rzcy82TUMwdTJ0TUIzS2xXU04vcTFlM1Z6MFMwbEdvTkNXN3p5Q0hCcjdM?=
 =?utf-8?B?T00yYWkrbDhWTHFvRWZqSnJTNUxLWExEUlJIUDlacDVTV0luSXZEdWFlUXpV?=
 =?utf-8?B?c29lUmJHdVEzOFNXMlZ3Q0E1TXFnekhmTWJOcnl4TndabFBCejB5T3ZHZUdV?=
 =?utf-8?B?alBHNVdrVlp1NWJObFFhVXpueC9MY284U3oxMnFDS0JiVEdRa043NW5zYW9P?=
 =?utf-8?B?aDNlZ0ZXcWkvM25xVTJUWkpsRzJaSllPcWtjeUVXZStTMzhSb2JLMTl4cDBz?=
 =?utf-8?B?MXNkT0JrUlJLYmRHN3F0YjdIcGhQb2tvVVFzbGd1Y0RrOS93L3VNNHhva2J5?=
 =?utf-8?B?U2VBMmZZWkxyNEJCNlgrSVNlVmM0K042ZHcvbzQxbzIzaWpxTlBzbmlENkdO?=
 =?utf-8?B?NWhJYUszVUJNd3hkT0dFb3ZGSlNtd2NydmZLeTBqQnlyL3BVM1NkNkdRampx?=
 =?utf-8?B?cjNudWFUOXJIcVFjYTR2ZnBWeDI5cDNCcnBRZ0lrYWlERDNwYXhDMXZlU3ow?=
 =?utf-8?B?SDBheXA3YmRRVHdYYndEZ2xQNkd2cjlLcGJiYmcwMlNNOWhaaXVoMTVQTW5j?=
 =?utf-8?B?QW1Ra0xuM0UreXUvVy9jQTlxVnI5blFBdUxoWmFXNlJCRkdXOHY5eVBYaXJ6?=
 =?utf-8?B?RU0raWg3SjFraUpGTVJUZWVNek9ZS09oOC9ibWNleVk3dk5YNUdqNldnQkNM?=
 =?utf-8?B?RU9JenZuay9QM3NvbGtGSksrYzVuUDduSC9vWHA1TzRHNmpVckE4SU8xalRt?=
 =?utf-8?B?R29SckdRQ0tIRzc0NzZMY3NJSFYvMEc4Q01XS01XU25pdDlxcmEvcnhueTBK?=
 =?utf-8?B?ZE1IeWZPRzdtR1ZwdzlBY1c0YlVTaHArMUpNWGNhc2daNGJQd0ovU3Bhci9h?=
 =?utf-8?B?cEJtdzlGYmRqOEFOdCt5VzE4MTZ1TVordnJ4MXhkVTVWamVQZ2JWdmw5d3No?=
 =?utf-8?B?V3M0YjVCZkVyRE5BV2J6bkV2UnpTVXBmSUo3NzFoWHp0WTJaRW9WbGlLNGtV?=
 =?utf-8?B?K2JvVGNDaEpMRi9TY2M5NzRWQjUwZmtvREFncktGME93dk8rVkZBQzkyN3hO?=
 =?utf-8?B?amY1Y0ZLa2VSOXliamVKdm94TnJ6ZUdQdkIzT0E2TzVMVEJJcld1WVpxU3kv?=
 =?utf-8?B?TmxlaW85UUFpdE4vSWErbksrMVJ3c1RXNzZMcDB5SlprVjlIR0VsckRnazBk?=
 =?utf-8?B?ZzM4RkFGSEJ3TktndnNaOGFxVFNEZkx6am8xaTVaTFYzRG5lamFCQW9zQk9T?=
 =?utf-8?B?NEk4dUltMTFyNzBlSzRtbW5FaE9vTi9qbnZla3ZoalRlMHljQk9SWjRvaEZT?=
 =?utf-8?B?cGRUcmQwWFFVbjBQWVdqWnlaNHdTQm1hTThWSHNvUHkvai84TWJtejFJZ2k3?=
 =?utf-8?B?Z2duRFdNbG91RWZJUHlXUTFGbVpoZzRwRDdZQ2diNG1EbkhLM0JvM1h5RVIx?=
 =?utf-8?B?OFoxbVJ4Z1hWVmNYNy9YSlFHSDNTMVFkck1aSmVDTnQ2VmxIdnRoUVdpejkv?=
 =?utf-8?B?MWh3bzhwWDdwZUhIWFUrdFpSM2RKV1JSUFB4emlUMzZvc0lJSFAwWTBtR1NU?=
 =?utf-8?B?YVgyS3NHUDlTQWFXQXlqaHpZVU02U01HQk1XMUlnS3V2TjhzajRWRjRYU0pq?=
 =?utf-8?B?NjZFckFFVlI1Y1daYlg1VitJTk1UazdudEhUK3RiUHRkQ2c9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WXN1K3U0eGFwS0QweGRmU1Z0YVNEb2FEOHNhbzlyN1pZS0M1ZTdCMmsxUlRq?=
 =?utf-8?B?N0NNb0RyVk9tNEMxZWt2Mm1yWkVGZmtvU1B5bDZKNE8wc3RrWVhrK3U4QVBE?=
 =?utf-8?B?WGZrR1ZPZlh2eURRczhWVFVOZHlON0dubEU2SmlHSmtIMmtaaVBqVC9NbGNw?=
 =?utf-8?B?NnpRN0hDWkdWRGZ6NVBGRi9NQitVMWh1VDNyRFZKNkhXNWNyaHJDU2hBeHBl?=
 =?utf-8?B?OW1sVmNob0ljdHRoQm5VaExUY21uc1g5NzhUZ2RraXA0Y2s5YnhWY2ZwM3Jv?=
 =?utf-8?B?NkthYXBhYnVFMnBKTEJaYnJTZFFOaDMybmNsRW1VbmJmWnZuWi9QakNxQXFu?=
 =?utf-8?B?eWdob0diQnpVWTh5NnBHcUNWNmhSb2pMY3BNMm02SGFGRDV0dyt2dTA5UnVr?=
 =?utf-8?B?VDNlcHRVa1RySW5aQkhZQ3FPV01OWkZ0RkhldGNVK3NVRUh6K3I0VUQzQUxH?=
 =?utf-8?B?a2JxQzNYckhOTTRhZ1phWTVZTlpobVBlZFN0cisvU3AzL21aUVBOcTV3NGhQ?=
 =?utf-8?B?WEdvelFlVTBqR3VveWtoaFdBZ3JqcWdPRUYwUmpnOEt6VHRhQ3Z6N0l6VkNQ?=
 =?utf-8?B?SEpKSEJPcGpCcU4xUzEzY3BNeE9MYmszMTJPNXY3SnZLWis1dUxHbEpuR1li?=
 =?utf-8?B?d3lPUGxXRWI0di9qTUhMdTNzdUtPc21YUkdwbnNUakN6cTRrWVFJeWtlTHA5?=
 =?utf-8?B?Z3QrdXJyaWpxeFNZdHJ2K3RZc2tFUENNZ1VIcUVqNlY0K0lsUDhvT3lSTlA3?=
 =?utf-8?B?WWhPaE1wQmRnOFRla0JISzVQbTJGRjFnbExnTnh4aVJ5R3JPRW5Yb1haVm43?=
 =?utf-8?B?eHNPNkRxajROc1pMdGJEVWpROEd0ZklkNXlKM0RWMVNEd1RzY1h6RUVLTmt3?=
 =?utf-8?B?L0h1N01OSk5QU240K25RbTdHUXdoa3QxZ1NJaWRmRm1RTmhDV2dvVGc5RCtE?=
 =?utf-8?B?eDBSREhEREFNalk4ZGltVW55Y3AxL01RRWdUS1o5MDFiMUZzVEZlVDluN3R4?=
 =?utf-8?B?K1dkV1N5OWYyLzVWQ0s5bWlKb2x6Q0pud3l5bndxQ2tVVFRWallFWWdzaEZt?=
 =?utf-8?B?Wi9vR2lGY0ZHR003bm1IdG54SkIyK1J2Y2J5THU2RTQzZUhIWEFTZ2ViMWZr?=
 =?utf-8?B?bThIdHN3eFBmUXhUUWY2Nnk0c3FMUHRvM3ZZWlpncXU4MFJMTHBQNldDOENr?=
 =?utf-8?B?eGZJNkwzTVN2L1BzQmRlUjF2NWdoeHlmTHczN1lyaDFiaTlNWGJtYlJCYWlP?=
 =?utf-8?B?b2xraWVCVEtPZ3l4TDlVSVVSSXJmamF5OUYzN0FmalBkc2JSQkM3UW4rb0cx?=
 =?utf-8?B?NE9vZUM4c2EwL3I2Q01kUDNoaVY4VC9JbE9hS2I5c0R0TGV0dHRWdFFHMUpK?=
 =?utf-8?B?TEdsOWNwK2d2N3RiUlpBNWp0VjhGOU82bk9KN0p5YVI3eEF3eWJqZ3hXNFBM?=
 =?utf-8?B?NG0xbGRoK0Jzem5lQVZQZzZnU1VwdnpHTm1Ec1dIQm9qRE1JWWVZWjh1YUo1?=
 =?utf-8?B?MmNXZ1ZaUEtSczRpY2tPY2tOajJuM0tadmxjY3pacEsvdGlhUFVSYzE1ODJH?=
 =?utf-8?B?Z3JyQ2lQTEFveDhMR3lNWDRqUEJrTUlBTEFpY2JLNzRDSkt1Lzhqc2pOUEYr?=
 =?utf-8?B?STlUT2xFWlQ0MlJJUStRQ0dhcmlzcVZrK3lHd3lCQzhjY0pkcjg0a1p0UTdi?=
 =?utf-8?B?WjJPMFZ6NCtMMmZZUFlHWFA3RmJyTTRCOXgzOGVpMUJWOWZGUXN2NGxTaFF3?=
 =?utf-8?B?N2g3SDB3WDE2RjRsODNHMVNoYS9uODErbWRHZUxTRGtUbTNTUkRMdjUxSTl0?=
 =?utf-8?B?Yy9HRGx3bk1pWDdhc3lnNGdMd2kybXpQV1dKNTQrcm00ZjRRYUR2clFlNW1E?=
 =?utf-8?B?SDNnbGlWNW4zOFJCK3E5SjRGdDRIcHgvQ20yQVZBdWRUS2JTZVVpcHlmeUM1?=
 =?utf-8?B?VmhUSzRUUXFtclZDREpCdG0xMXo3TGR3WWU4azFZcmk5ZGprdFRmTml6Z2kz?=
 =?utf-8?B?VGxoVkt2MVloQ0ppazhrKy9IaWdDK3ozZEpqbjlmVG5lVGN4K1F3QzYwMGFj?=
 =?utf-8?B?dXdWKzJTREpzSkJnNnRxM2UrN0o2STRNT2RLUU9XWmN5VFFMN3RvZlVIRHEx?=
 =?utf-8?Q?Hia0QxbPhWV58sRF6k5k2Eggj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db33ad1e-d352-4141-acfa-08dcc0684885
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 16:02:10.6829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GSsGBVJ1w5UfjCUM7gC2LzZGAmn9k8dSZca0T1HiSHLN9ypXhk5O8eVfP0jSPJumy/iDAH0z9udelZnL3lpP6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9659

When a new device hotjoins, a new dynamic address is assigned.
i3c_master_add_i3c_dev_locked() identifies that the device was previously
attached to the bus and locates the olddev.

i3c_master_add_i3c_dev_locked()
{
    ...
    olddev = i3c_master_search_i3c_dev_duplicate(newdev);
    ...
    if (olddev) {
        ...
        i3c_dev_disable_ibi_locked(olddev);
        ^^^^^^
        The olddev should not receive any commands on the i3c bus as it
        does not exist and has been assigned a new address. This will
        result in NACK or timeout. So remove it.
    }
}

Fixes: 317bacf960a4 ("i3c: master: add enable(disable) hot join in sys entry")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 7028f03c2c42e..852b32178b722 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2039,10 +2039,8 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
 			ibireq.max_payload_len = olddev->ibi->max_payload_len;
 			ibireq.num_slots = olddev->ibi->num_slots;
 
-			if (olddev->ibi->enabled) {
+			if (olddev->ibi->enabled)
 				enable_ibi = true;
-				i3c_dev_disable_ibi_locked(olddev);
-			}
 
 			i3c_dev_free_ibi_locked(olddev);
 		}

-- 
2.34.1


